"""
SOLUS API Server — Local REST & WebSocket API
===============================================

PROT-673: OpenAI-compatible local API server for inference,
chat, embeddings, and agent execution.
"""

from __future__ import annotations

import json
import time
import uuid
from typing import Any, Dict, List, Optional

try:
    from fastapi import FastAPI, HTTPException, WebSocket, WebSocketDisconnect
    from fastapi.middleware.cors import CORSMiddleware
    from fastapi.responses import JSONResponse, StreamingResponse
    from pydantic import BaseModel, Field
    HAS_FASTAPI = True
except ImportError:
    HAS_FASTAPI = False


# --- Pydantic Models (only if FastAPI available) ---

if HAS_FASTAPI:
    class CompletionRequest(BaseModel):
        model: str = "default"
        prompt: str
        max_tokens: int = 2048
        temperature: float = 0.7
        top_p: float = 0.9
        stop: Optional[List[str]] = None
        stream: bool = False

    class ChatRequest(BaseModel):
        model: str = "default"
        messages: List[Dict[str, str]]
        max_tokens: int = 2048
        temperature: float = 0.7
        top_p: float = 0.9
        stream: bool = False
        tools: Optional[List[Dict]] = None

    class EmbeddingRequest(BaseModel):
        model: str = "default"
        input: Any  # str or list[str]

    class AgentRequest(BaseModel):
        task: str
        agent_name: str = "default"
        max_steps: int = 20
        tools: Optional[List[str]] = None

    class ReasoningRequest(BaseModel):
        question: str
        strategy: str = "auto"
        max_steps: int = 10
        verify: bool = True


def create_app(solus_instance: Any = None) -> Any:
    """
    Create the SOLUS API server application.

    Args:
        solus_instance: A configured Solus instance

    Returns:
        FastAPI application
    """
    if not HAS_FASTAPI:
        raise ImportError(
            "FastAPI is required for the SOLUS server. "
            "Install with: pip install solus-ai"
        )

    app = FastAPI(
        title="SOLUS AI — Local Model Server",
        description="Sovereign Local Universal System — OpenAI-compatible API",
        version="1.0.0",
    )

    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    # Store solus instance
    app.state.solus = solus_instance

    # --- Health & Info ---

    @app.get("/")
    async def root():
        return {
            "name": "SOLUS AI",
            "version": "1.0.0",
            "status": "running",
            "endpoints": [
                "/v1/completions",
                "/v1/chat/completions",
                "/v1/embeddings",
                "/v1/models",
                "/v1/agents/run",
                "/v1/reasoning",
            ],
        }

    @app.get("/health")
    async def health():
        return {"status": "healthy", "timestamp": time.time()}

    @app.get("/v1/models")
    async def list_models():
        solus = app.state.solus
        if solus and hasattr(solus, "models"):
            models = solus.models.registry.list_all()
            return {
                "object": "list",
                "data": [
                    {
                        "id": m.model_id,
                        "object": "model",
                        "owned_by": "solus-local",
                        "permission": [],
                    }
                    for m in models
                ],
            }
        return {"object": "list", "data": []}

    # --- Completions ---

    @app.post("/v1/completions")
    async def create_completion(request: CompletionRequest):
        solus = app.state.solus
        if not solus or not solus._inference:
            raise HTTPException(status_code=503, detail="No model loaded")

        result = solus.generate(
            prompt=request.prompt,
            max_tokens=request.max_tokens,
            temperature=request.temperature,
            top_p=request.top_p,
            stop=request.stop,
        )

        return {
            "id": f"cmpl-{uuid.uuid4().hex[:8]}",
            "object": "text_completion",
            "created": int(time.time()),
            "model": request.model,
            "choices": [
                {
                    "text": result.text,
                    "index": 0,
                    "finish_reason": result.finish_reason,
                }
            ],
            "usage": {
                "prompt_tokens": result.tokens_prompt,
                "completion_tokens": result.tokens_generated,
                "total_tokens": result.tokens_prompt + result.tokens_generated,
            },
        }

    # --- Chat Completions ---

    @app.post("/v1/chat/completions")
    async def create_chat_completion(request: ChatRequest):
        solus = app.state.solus
        if not solus or not solus._inference:
            raise HTTPException(status_code=503, detail="No model loaded")

        result = solus.chat(
            messages=request.messages,
            max_tokens=request.max_tokens,
            temperature=request.temperature,
        )

        return {
            "id": f"chatcmpl-{uuid.uuid4().hex[:8]}",
            "object": "chat.completion",
            "created": int(time.time()),
            "model": request.model,
            "choices": [
                {
                    "index": 0,
                    "message": {
                        "role": "assistant",
                        "content": result.text,
                    },
                    "finish_reason": result.finish_reason,
                }
            ],
            "usage": {
                "prompt_tokens": result.tokens_prompt,
                "completion_tokens": result.tokens_generated,
                "total_tokens": result.tokens_prompt + result.tokens_generated,
            },
        }

    # --- Embeddings ---

    @app.post("/v1/embeddings")
    async def create_embedding(request: EmbeddingRequest):
        solus = app.state.solus
        if not solus or not solus._inference:
            raise HTTPException(status_code=503, detail="No model loaded")

        result = solus.embed(request.input)

        return {
            "object": "list",
            "data": [
                {
                    "object": "embedding",
                    "index": i,
                    "embedding": emb,
                }
                for i, emb in enumerate(result.embeddings)
            ],
            "model": request.model,
            "usage": {"prompt_tokens": result.token_count, "total_tokens": result.token_count},
        }

    # --- Agents ---

    @app.post("/v1/agents/run")
    async def run_agent(request: AgentRequest):
        solus = app.state.solus
        if not solus:
            raise HTTPException(status_code=503, detail="SOLUS not initialized")

        agent = solus.create_agent(
            name=request.agent_name,
            max_steps=request.max_steps,
            tools=request.tools or [],
        )
        result = agent.run(request.task)

        return result.to_dict()

    # --- Reasoning ---

    @app.post("/v1/reasoning")
    async def reason(request: ReasoningRequest):
        solus = app.state.solus
        if not solus:
            raise HTTPException(status_code=503, detail="SOLUS not initialized")

        result = solus.reason(
            question=request.question,
            strategy=request.strategy,
            max_steps=request.max_steps,
            verify=request.verify,
        )

        return result.to_dict()

    # --- WebSocket for streaming ---

    @app.websocket("/v1/stream")
    async def websocket_stream(websocket: WebSocket):
        await websocket.accept()
        solus = app.state.solus

        try:
            while True:
                data = await websocket.receive_text()
                request = json.loads(data)

                if not solus or not solus._inference:
                    await websocket.send_json({"error": "No model loaded"})
                    continue

                prompt = request.get("prompt", "")
                for token in solus.generate(prompt, stream=True):
                    await websocket.send_json({"token": token})
                await websocket.send_json({"done": True})

        except WebSocketDisconnect:
            pass

    # --- System Status ---

    @app.get("/v1/status")
    async def system_status():
        solus = app.state.solus
        if solus:
            return solus.identity
        return {"status": "not initialized"}

    return app


def run(
    host: str = "0.0.0.0",
    port: int = 8741,
    model: Optional[str] = None,
    model_dir: str = "~/.solus/models",
):
    """
    Run the SOLUS API server.

    Args:
        host: Bind address
        port: Port number (default: 8741 — phi-harmonic)
        model: Model to load on startup
        model_dir: Directory containing models
    """
    if not HAS_FASTAPI:
        raise ImportError("FastAPI required. Install with: pip install solus-ai")

    import uvicorn

    # Create Solus instance
    from solus import Solus
    solus = Solus(model_dir=model_dir)

    if model:
        solus.load_model(model)

    app = create_app(solus)

    print(f"🔮 SOLUS AI Server starting on http://{host}:{port}")
    print(f"   OpenAI-compatible API: http://{host}:{port}/v1/")
    print(f"   Model: {model or 'none loaded'}")
    print(f"   Docs: http://{host}:{port}/docs")

    uvicorn.run(app, host=host, port=port)
