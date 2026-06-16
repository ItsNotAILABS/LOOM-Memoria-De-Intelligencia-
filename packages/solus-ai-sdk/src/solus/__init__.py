"""
SOLUS AI — Sovereign Local Universal System
============================================

The open-source local model SDK for autonomous AI inference,
reasoning, and agent orchestration.

SOLUS (Sovereign Open Local Universal System) is the user-facing
AI SDK that runs entirely on local hardware — no cloud dependency.
It integrates with the Medina Organism's memory systems while
maintaining full sovereignty over inference and reasoning.

Protocols: PROT-662 to PROT-681
Worker: #78 (SOLUS-SOVEREIGN)
Layer: 22 (φ²² = 4,870,847 Hz)

Usage:
    from solus import Solus

    ai = Solus()
    ai.load_model("mistral-7b-q4")
    response = ai.generate("Explain quantum computing")
    print(response.text)

    # Agent mode
    agent = ai.create_agent("researcher")
    result = agent.run("Find papers on transformer architecture")

    # Reasoning mode
    answer = ai.reason("What is 127 * 43?", strategy="chain_of_thought")
"""

__version__ = "1.0.0"
__author__ = "Alfredo 'Freddy' Medina Hernandez"
__license__ = "MIT"

PHI = 1.618033988749895
LAYER = 22
FREQUENCY_HZ = 4_870_847  # φ²²
SYSTEM_CODENAME = "SOLUS"
SYSTEM_LATIN = "SYSTEMA LOCALE UNIVERSALE SOVEREIGNUM"

from solus.engine.runtime import SolusRuntime
from solus.engine.inference import InferenceEngine
from solus.models.manager import ModelManager
from solus.models.registry import ModelRegistry
from solus.reasoning.chain import ChainOfThought
from solus.reasoning.planner import ReasoningPlanner
from solus.memory.connector import MemoryConnector
from solus.agents.agent import Agent, AgentConfig
from solus.agents.orchestrator import AgentOrchestrator
from solus.tools.registry import ToolRegistry
from solus.tools.function_call import FunctionCaller

__all__ = [
    "Solus",
    "SolusRuntime",
    "InferenceEngine",
    "ModelManager",
    "ModelRegistry",
    "ChainOfThought",
    "ReasoningPlanner",
    "MemoryConnector",
    "Agent",
    "AgentConfig",
    "AgentOrchestrator",
    "ToolRegistry",
    "FunctionCaller",
    "PHI",
    "LAYER",
    "FREQUENCY_HZ",
    "SYSTEM_CODENAME",
    "SYSTEM_LATIN",
]


class Solus:
    """
    SOLUS — Primary entry point for the local AI SDK.

    Provides unified access to:
    - Local model inference (GGUF, Transformers, custom)
    - Reasoning (chain-of-thought, tree-of-thought, planning)
    - Agent orchestration (autonomous multi-step tasks)
    - Tool use (function calling, API integration)
    - Memory (Semper Memoria integration)
    """

    def __init__(
        self,
        model_dir: str = "~/.solus/models",
        config_path: str | None = None,
    ):
        self.runtime = SolusRuntime(model_dir=model_dir, config_path=config_path)
        self.models = ModelManager(model_dir=model_dir)
        self.tools = ToolRegistry()
        self.memory = MemoryConnector()
        self._inference: InferenceEngine | None = None
        self._agents = AgentOrchestrator(tools=self.tools, memory=self.memory)

    def load_model(self, model_id: str, **kwargs) -> "Solus":
        """Load a model for inference."""
        model = self.models.load(model_id, **kwargs)
        self._inference = InferenceEngine(model=model, memory=self.memory)
        return self

    def generate(
        self,
        prompt: str,
        max_tokens: int = 2048,
        temperature: float = 0.7,
        top_p: float = 0.9,
        stop: list[str] | None = None,
        stream: bool = False,
    ):
        """Generate text from the loaded model."""
        if not self._inference:
            raise RuntimeError("No model loaded. Call solus.load_model() first.")
        return self._inference.generate(
            prompt=prompt,
            max_tokens=max_tokens,
            temperature=temperature,
            top_p=top_p,
            stop=stop,
            stream=stream,
        )

    def reason(self, question: str, strategy: str = "chain_of_thought", **kwargs):
        """Use structured reasoning to answer a question."""
        if not self._inference:
            raise RuntimeError("No model loaded. Call solus.load_model() first.")
        planner = ReasoningPlanner(inference=self._inference)
        return planner.reason(question=question, strategy=strategy, **kwargs)

    def create_agent(self, name: str, **kwargs) -> Agent:
        """Create an autonomous agent."""
        config = AgentConfig(name=name, **kwargs)
        return self._agents.create(config)

    def chat(self, messages: list[dict], **kwargs):
        """Chat completion interface (OpenAI-compatible)."""
        if not self._inference:
            raise RuntimeError("No model loaded. Call solus.load_model() first.")
        return self._inference.chat(messages=messages, **kwargs)

    def embed(self, text: str | list[str]):
        """Generate embeddings for text."""
        if not self._inference:
            raise RuntimeError("No model loaded. Call solus.load_model() first.")
        return self._inference.embed(text)

    @property
    def identity(self) -> dict:
        """SOLUS system identity."""
        return {
            "name": SYSTEM_CODENAME,
            "latin": SYSTEM_LATIN,
            "version": __version__,
            "layer": LAYER,
            "frequency_hz": FREQUENCY_HZ,
            "phi": PHI,
            "protocols": "PROT-662 to PROT-681",
            "license": "MIT",
            "model_loaded": self._inference is not None,
        }

    def __repr__(self) -> str:
        model_str = self._inference.model_id if self._inference else "none"
        return f"Solus(model={model_str}, layer={LAYER}, freq={FREQUENCY_HZ}Hz)"
