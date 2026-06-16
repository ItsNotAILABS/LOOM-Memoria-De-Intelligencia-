"""
SOLUS Model Registry — Known Models & Configurations
=====================================================

PROT-664: Registry of known local models with their configurations,
quantization options, and hardware requirements.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional


class ModelFormat(str, Enum):
    """Supported model formats."""
    GGUF = "gguf"
    SAFETENSORS = "safetensors"
    PYTORCH = "pytorch"
    ONNX = "onnx"
    OPENVINO = "openvino"


class QuantizationType(str, Enum):
    """Quantization levels."""
    F32 = "f32"
    F16 = "f16"
    Q8_0 = "q8_0"
    Q6_K = "q6_k"
    Q5_K_M = "q5_k_m"
    Q4_K_M = "q4_k_m"
    Q4_0 = "q4_0"
    Q3_K_M = "q3_k_m"
    Q2_K = "q2_k"
    IQ4_XS = "iq4_xs"
    IQ3_XXS = "iq3_xxs"


@dataclass
class ModelSpec:
    """Specification for a known model."""
    model_id: str
    name: str
    family: str
    parameters: str  # e.g., "7B", "13B", "70B"
    context_length: int
    formats: List[ModelFormat] = field(default_factory=list)
    quantizations: List[QuantizationType] = field(default_factory=list)
    default_quant: QuantizationType = QuantizationType.Q4_K_M
    min_ram_gb: float = 4.0
    min_vram_gb: float = 0.0
    chat_template: str = "chatml"
    description: str = ""
    license: str = ""
    source_url: str = ""
    tags: List[str] = field(default_factory=list)

    def to_dict(self) -> Dict[str, Any]:
        return {
            "model_id": self.model_id,
            "name": self.name,
            "family": self.family,
            "parameters": self.parameters,
            "context_length": self.context_length,
            "formats": [f.value for f in self.formats],
            "quantizations": [q.value for q in self.quantizations],
            "default_quant": self.default_quant.value,
            "min_ram_gb": self.min_ram_gb,
            "min_vram_gb": self.min_vram_gb,
            "chat_template": self.chat_template,
            "license": self.license,
        }


# Built-in model registry
KNOWN_MODELS: Dict[str, ModelSpec] = {
    "mistral-7b": ModelSpec(
        model_id="mistral-7b",
        name="Mistral 7B Instruct",
        family="mistral",
        parameters="7B",
        context_length=32768,
        formats=[ModelFormat.GGUF, ModelFormat.SAFETENSORS],
        quantizations=[QuantizationType.Q4_K_M, QuantizationType.Q5_K_M, QuantizationType.Q8_0],
        min_ram_gb=6.0,
        chat_template="mistral",
        description="Fast, capable 7B model for general tasks",
        license="Apache-2.0",
        tags=["general", "fast", "instruction"],
    ),
    "llama3-8b": ModelSpec(
        model_id="llama3-8b",
        name="Llama 3 8B Instruct",
        family="llama",
        parameters="8B",
        context_length=8192,
        formats=[ModelFormat.GGUF, ModelFormat.SAFETENSORS],
        quantizations=[QuantizationType.Q4_K_M, QuantizationType.Q5_K_M, QuantizationType.Q8_0],
        min_ram_gb=6.0,
        chat_template="llama3",
        description="Meta's Llama 3 — strong reasoning and instruction following",
        license="Llama-3",
        tags=["general", "reasoning", "instruction"],
    ),
    "llama3-70b": ModelSpec(
        model_id="llama3-70b",
        name="Llama 3 70B Instruct",
        family="llama",
        parameters="70B",
        context_length=8192,
        formats=[ModelFormat.GGUF, ModelFormat.SAFETENSORS],
        quantizations=[QuantizationType.Q4_K_M, QuantizationType.Q3_K_M, QuantizationType.Q2_K],
        min_ram_gb=48.0,
        min_vram_gb=40.0,
        chat_template="llama3",
        description="Large-scale Llama 3 for complex reasoning",
        license="Llama-3",
        tags=["reasoning", "complex", "large"],
    ),
    "phi3-mini": ModelSpec(
        model_id="phi3-mini",
        name="Phi-3 Mini 3.8B",
        family="phi",
        parameters="3.8B",
        context_length=4096,
        formats=[ModelFormat.GGUF, ModelFormat.SAFETENSORS],
        quantizations=[QuantizationType.Q4_K_M, QuantizationType.Q5_K_M],
        min_ram_gb=4.0,
        chat_template="phi3",
        description="Microsoft Phi-3 — compact but capable",
        license="MIT",
        tags=["compact", "fast", "efficient"],
    ),
    "codellama-13b": ModelSpec(
        model_id="codellama-13b",
        name="Code Llama 13B Instruct",
        family="codellama",
        parameters="13B",
        context_length=16384,
        formats=[ModelFormat.GGUF, ModelFormat.SAFETENSORS],
        quantizations=[QuantizationType.Q4_K_M, QuantizationType.Q5_K_M],
        min_ram_gb=10.0,
        chat_template="codellama",
        description="Specialized for code generation and understanding",
        license="Llama-2",
        tags=["code", "programming", "instruction"],
    ),
    "deepseek-coder-6.7b": ModelSpec(
        model_id="deepseek-coder-6.7b",
        name="DeepSeek Coder 6.7B",
        family="deepseek",
        parameters="6.7B",
        context_length=16384,
        formats=[ModelFormat.GGUF, ModelFormat.SAFETENSORS],
        quantizations=[QuantizationType.Q4_K_M, QuantizationType.Q5_K_M],
        min_ram_gb=6.0,
        chat_template="deepseek",
        description="Strong code generation model",
        license="DeepSeek",
        tags=["code", "fast"],
    ),
    "qwen2-7b": ModelSpec(
        model_id="qwen2-7b",
        name="Qwen 2 7B Instruct",
        family="qwen",
        parameters="7B",
        context_length=32768,
        formats=[ModelFormat.GGUF, ModelFormat.SAFETENSORS],
        quantizations=[QuantizationType.Q4_K_M, QuantizationType.Q5_K_M, QuantizationType.Q8_0],
        min_ram_gb=6.0,
        chat_template="qwen",
        description="Alibaba Qwen 2 — multilingual and capable",
        license="Apache-2.0",
        tags=["general", "multilingual", "instruction"],
    ),
    "gemma2-9b": ModelSpec(
        model_id="gemma2-9b",
        name="Gemma 2 9B Instruct",
        family="gemma",
        parameters="9B",
        context_length=8192,
        formats=[ModelFormat.GGUF, ModelFormat.SAFETENSORS],
        quantizations=[QuantizationType.Q4_K_M, QuantizationType.Q5_K_M],
        min_ram_gb=8.0,
        chat_template="gemma",
        description="Google Gemma 2 — efficient instruction model",
        license="Gemma",
        tags=["general", "instruction", "efficient"],
    ),
}


class ModelRegistry:
    """
    Registry of known models and their configurations.

    Provides model discovery, filtering, and recommendation
    based on hardware capabilities.
    """

    def __init__(self) -> None:
        self._models: Dict[str, ModelSpec] = dict(KNOWN_MODELS)
        self._custom_models: Dict[str, ModelSpec] = {}

    def get(self, model_id: str) -> Optional[ModelSpec]:
        """Get a model spec by ID."""
        return self._models.get(model_id) or self._custom_models.get(model_id)

    def list_all(self) -> List[ModelSpec]:
        """List all known models."""
        return list(self._models.values()) + list(self._custom_models.values())

    def search(
        self,
        family: Optional[str] = None,
        tags: Optional[List[str]] = None,
        max_ram_gb: Optional[float] = None,
        min_context: Optional[int] = None,
    ) -> List[ModelSpec]:
        """Search models by criteria."""
        results = self.list_all()

        if family:
            results = [m for m in results if m.family == family]
        if tags:
            results = [m for m in results if any(t in m.tags for t in tags)]
        if max_ram_gb:
            results = [m for m in results if m.min_ram_gb <= max_ram_gb]
        if min_context:
            results = [m for m in results if m.context_length >= min_context]

        return results

    def recommend(self, ram_gb: float, vram_gb: float = 0.0) -> List[ModelSpec]:
        """Recommend models based on available hardware."""
        compatible = [
            m for m in self.list_all()
            if m.min_ram_gb <= ram_gb and m.min_vram_gb <= max(vram_gb, ram_gb)
        ]
        # Sort by parameter count (larger = better, if it fits)
        return sorted(compatible, key=lambda m: m.min_ram_gb, reverse=True)

    def register(self, spec: ModelSpec) -> None:
        """Register a custom model."""
        self._custom_models[spec.model_id] = spec

    def to_dict(self) -> Dict[str, Any]:
        """Export registry as dict."""
        return {
            "built_in": {k: v.to_dict() for k, v in self._models.items()},
            "custom": {k: v.to_dict() for k, v in self._custom_models.items()},
            "total": len(self._models) + len(self._custom_models),
        }
