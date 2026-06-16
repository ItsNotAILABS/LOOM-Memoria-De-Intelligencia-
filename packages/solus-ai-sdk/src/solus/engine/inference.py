"""
SOLUS Inference Engine — Local Model Inference
===============================================

PROT-663: Core inference engine that executes generation, chat completion,
embeddings, and structured output from locally loaded models.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from typing import Any, Dict, Generator, List, Optional, Union


PHI = 1.618033988749895


@dataclass
class GenerationConfig:
    """Configuration for text generation."""
    max_tokens: int = 2048
    temperature: float = 0.7
    top_p: float = 0.9
    top_k: int = 40
    repeat_penalty: float = 1.1
    stop: List[str] = field(default_factory=list)
    seed: int = -1
    stream: bool = False


@dataclass
class GenerationResult:
    """Result of a generation request."""
    text: str
    tokens_generated: int
    tokens_prompt: int
    generation_time_ms: float
    model_id: str
    finish_reason: str = "stop"
    request_id: str = field(default_factory=lambda: str(uuid.uuid4()))

    @property
    def tokens_per_second(self) -> float:
        if self.generation_time_ms == 0:
            return 0.0
        return self.tokens_generated / (self.generation_time_ms / 1000.0)

    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.request_id,
            "text": self.text,
            "model": self.model_id,
            "usage": {
                "prompt_tokens": self.tokens_prompt,
                "completion_tokens": self.tokens_generated,
                "total_tokens": self.tokens_prompt + self.tokens_generated,
            },
            "timing": {
                "generation_ms": round(self.generation_time_ms, 2),
                "tokens_per_second": round(self.tokens_per_second, 2),
            },
            "finish_reason": self.finish_reason,
        }


@dataclass
class ChatMessage:
    """A chat message."""
    role: str  # system, user, assistant, tool
    content: str
    name: Optional[str] = None
    tool_calls: Optional[List[Dict[str, Any]]] = None


@dataclass
class EmbeddingResult:
    """Result of an embedding request."""
    embeddings: List[List[float]]
    model_id: str
    dimensions: int
    token_count: int


class InferenceEngine:
    """
    SOLUS Inference Engine.

    Provides:
    - Text generation (completion)
    - Chat completion (multi-turn)
    - Embeddings
    - Streaming generation
    - Structured output (JSON mode)
    """

    def __init__(self, model: Any, memory: Any = None):
        self._model = model
        self._memory = memory
        self._context: List[ChatMessage] = []
        self._total_generated = 0

    @property
    def model_id(self) -> str:
        """Current model identifier."""
        if hasattr(self._model, "model_id"):
            return self._model.model_id
        return "unknown"

    def generate(
        self,
        prompt: str,
        max_tokens: int = 2048,
        temperature: float = 0.7,
        top_p: float = 0.9,
        stop: Optional[List[str]] = None,
        stream: bool = False,
        **kwargs,
    ) -> Union[GenerationResult, Generator]:
        """
        Generate text from a prompt.

        Args:
            prompt: Input text prompt
            max_tokens: Maximum tokens to generate
            temperature: Sampling temperature (0.0 = deterministic)
            top_p: Nucleus sampling threshold
            stop: Stop sequences
            stream: If True, returns a generator of tokens

        Returns:
            GenerationResult or Generator if streaming
        """
        config = GenerationConfig(
            max_tokens=max_tokens,
            temperature=temperature,
            top_p=top_p,
            stop=stop or [],
            stream=stream,
        )

        if stream:
            return self._stream_generate(prompt, config)

        start_time = time.time()

        # Execute inference through model backend
        output = self._execute_inference(prompt, config)

        elapsed_ms = (time.time() - start_time) * 1000
        tokens_gen = self._count_tokens(output)
        tokens_prompt = self._count_tokens(prompt)
        self._total_generated += tokens_gen

        # Store in memory if connected
        if self._memory:
            self._memory.store_interaction(prompt=prompt, response=output)

        return GenerationResult(
            text=output,
            tokens_generated=tokens_gen,
            tokens_prompt=tokens_prompt,
            generation_time_ms=elapsed_ms,
            model_id=self.model_id,
        )

    def chat(
        self,
        messages: List[Dict[str, str]],
        max_tokens: int = 2048,
        temperature: float = 0.7,
        **kwargs,
    ) -> GenerationResult:
        """
        Chat completion interface.

        Args:
            messages: List of {role, content} dicts
            max_tokens: Maximum tokens to generate
            temperature: Sampling temperature

        Returns:
            GenerationResult with assistant response
        """
        # Convert to ChatMessage objects
        chat_messages = [
            ChatMessage(role=m["role"], content=m["content"], name=m.get("name"))
            for m in messages
        ]

        # Format messages into prompt
        prompt = self._format_chat(chat_messages)

        # Generate
        result = self.generate(
            prompt=prompt,
            max_tokens=max_tokens,
            temperature=temperature,
            **kwargs,
        )

        # Update context
        self._context.extend(chat_messages)
        self._context.append(ChatMessage(role="assistant", content=result.text))

        return result

    def embed(self, text: Union[str, List[str]]) -> EmbeddingResult:
        """
        Generate embeddings for text.

        Args:
            text: Single string or list of strings

        Returns:
            EmbeddingResult with embedding vectors
        """
        if isinstance(text, str):
            texts = [text]
        else:
            texts = text

        embeddings = self._execute_embedding(texts)
        dimensions = len(embeddings[0]) if embeddings else 0
        token_count = sum(self._count_tokens(t) for t in texts)

        return EmbeddingResult(
            embeddings=embeddings,
            model_id=self.model_id,
            dimensions=dimensions,
            token_count=token_count,
        )

    def _execute_inference(self, prompt: str, config: GenerationConfig) -> str:
        """Execute inference through the model backend."""
        if hasattr(self._model, "generate"):
            return self._model.generate(
                prompt,
                max_tokens=config.max_tokens,
                temperature=config.temperature,
                top_p=config.top_p,
                top_k=config.top_k,
                repeat_penalty=config.repeat_penalty,
                stop=config.stop,
            )
        elif hasattr(self._model, "__call__"):
            return self._model(prompt, max_new_tokens=config.max_tokens)
        else:
            raise RuntimeError(f"Model {self.model_id} does not support generation")

    def _execute_embedding(self, texts: List[str]) -> List[List[float]]:
        """Execute embedding through model backend."""
        if hasattr(self._model, "embed"):
            return [self._model.embed(t) for t in texts]
        elif hasattr(self._model, "encode"):
            return [self._model.encode(t).tolist() for t in texts]
        else:
            raise RuntimeError(f"Model {self.model_id} does not support embeddings")

    def _stream_generate(
        self, prompt: str, config: GenerationConfig
    ) -> Generator[str, None, None]:
        """Stream tokens from the model."""
        if hasattr(self._model, "stream"):
            yield from self._model.stream(
                prompt,
                max_tokens=config.max_tokens,
                temperature=config.temperature,
            )
        else:
            # Fallback: generate all then yield
            result = self._execute_inference(prompt, config)
            for token in result.split():
                yield token + " "

    def _format_chat(self, messages: List[ChatMessage]) -> str:
        """Format chat messages into a model prompt."""
        if hasattr(self._model, "format_chat"):
            return self._model.format_chat(messages)

        # Default ChatML format
        formatted = ""
        for msg in messages:
            formatted += f"<|im_start|>{msg.role}\n{msg.content}<|im_end|>\n"
        formatted += "<|im_start|>assistant\n"
        return formatted

    def _count_tokens(self, text: str) -> int:
        """Estimate token count."""
        if hasattr(self._model, "tokenize"):
            return len(self._model.tokenize(text))
        # Rough estimate: ~4 chars per token
        return max(1, len(text) // 4)

    def reset_context(self) -> None:
        """Clear conversation context."""
        self._context = []

    def get_stats(self) -> Dict[str, Any]:
        """Get inference statistics."""
        return {
            "model_id": self.model_id,
            "total_generated": self._total_generated,
            "context_messages": len(self._context),
        }
