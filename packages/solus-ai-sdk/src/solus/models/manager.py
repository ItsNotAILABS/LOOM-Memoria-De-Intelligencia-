"""
SOLUS Model Manager — Load, Serve & Swap Models
=================================================

PROT-665: Manages model downloading, loading into memory, quantization
selection, and hot-swapping between different models.
"""

from __future__ import annotations

import os
import time
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Dict, List, Optional

from solus.models.registry import (
    ModelFormat,
    ModelRegistry,
    ModelSpec,
    QuantizationType,
)


@dataclass
class LoadedModel:
    """A model loaded into memory."""
    model_id: str
    spec: ModelSpec
    format: ModelFormat
    quantization: QuantizationType
    backend: Any = None  # Actual model object
    loaded_at: float = field(default_factory=time.time)
    memory_usage_mb: float = 0.0

    def generate(self, prompt: str, **kwargs) -> str:
        """Generate text using the loaded backend."""
        if self.backend is None:
            raise RuntimeError(f"Model {self.model_id} backend not initialized")
        if hasattr(self.backend, "create_completion"):
            # llama-cpp-python interface
            result = self.backend.create_completion(prompt, **kwargs)
            if isinstance(result, dict):
                return result.get("choices", [{}])[0].get("text", "")
            return str(result)
        elif hasattr(self.backend, "generate"):
            return self.backend.generate(prompt, **kwargs)
        elif callable(self.backend):
            return self.backend(prompt, **kwargs)
        raise RuntimeError(f"Model {self.model_id} does not support generation")

    def stream(self, prompt: str, **kwargs):
        """Stream tokens from the model."""
        if hasattr(self.backend, "create_completion"):
            kwargs["stream"] = True
            for chunk in self.backend.create_completion(prompt, **kwargs):
                if isinstance(chunk, dict):
                    text = chunk.get("choices", [{}])[0].get("text", "")
                    if text:
                        yield text
        else:
            # Fallback
            yield self.generate(prompt, **kwargs)

    def tokenize(self, text: str) -> List[int]:
        """Tokenize text."""
        if hasattr(self.backend, "tokenize"):
            result = self.backend.tokenize(text.encode("utf-8"))
            return list(result) if result else []
        return list(range(len(text) // 4))

    def format_chat(self, messages: List[Any]) -> str:
        """Format chat messages using model's template."""
        if hasattr(self.backend, "create_chat_completion"):
            return None  # Use native chat interface
        # Default ChatML formatting
        formatted = ""
        for msg in messages:
            role = msg.role if hasattr(msg, "role") else msg.get("role", "user")
            content = msg.content if hasattr(msg, "content") else msg.get("content", "")
            formatted += f"<|im_start|>{role}\n{content}<|im_end|>\n"
        formatted += "<|im_start|>assistant\n"
        return formatted


class ModelManager:
    """
    SOLUS Model Manager.

    Handles:
    - Model discovery and download
    - Loading models (GGUF via llama-cpp-python, Transformers, etc.)
    - Memory-efficient loading with quantization
    - Hot-swapping between models
    - Model lifecycle management
    """

    def __init__(self, model_dir: str = "~/.solus/models"):
        self._model_dir = Path(model_dir).expanduser()
        self._model_dir.mkdir(parents=True, exist_ok=True)
        self._registry = ModelRegistry()
        self._loaded: Dict[str, LoadedModel] = {}
        self._active: Optional[LoadedModel] = None

    @property
    def registry(self) -> ModelRegistry:
        """Access the model registry."""
        return self._registry

    @property
    def active_model(self) -> Optional[LoadedModel]:
        """Currently active model."""
        return self._active

    def list_local(self) -> List[str]:
        """List locally available model files."""
        models = []
        if self._model_dir.exists():
            for f in self._model_dir.rglob("*"):
                if f.suffix in (".gguf", ".bin", ".safetensors"):
                    models.append(str(f.relative_to(self._model_dir)))
        return models

    def load(
        self,
        model_id: str,
        quantization: Optional[str] = None,
        gpu_layers: int = -1,
        context_length: Optional[int] = None,
        **kwargs,
    ) -> LoadedModel:
        """
        Load a model for inference.

        Args:
            model_id: Model identifier or path to model file
            quantization: Quantization level (e.g., 'q4_k_m')
            gpu_layers: Number of layers to offload to GPU (-1 = all)
            context_length: Override context length

        Returns:
            LoadedModel instance ready for inference
        """
        # Check if already loaded
        if model_id in self._loaded:
            self._active = self._loaded[model_id]
            return self._active

        # Resolve model spec
        spec = self._registry.get(model_id)
        quant = QuantizationType(quantization) if quantization else (
            spec.default_quant if spec else QuantizationType.Q4_K_M
        )

        # Determine model path
        model_path = self._resolve_model_path(model_id, quant)

        if not model_path:
            raise FileNotFoundError(
                f"Model '{model_id}' not found locally. "
                f"Download it to {self._model_dir} or provide a direct path."
            )

        # Load based on format
        fmt = self._detect_format(model_path)

        if fmt == ModelFormat.GGUF:
            backend = self._load_gguf(model_path, gpu_layers, context_length, **kwargs)
        elif fmt in (ModelFormat.SAFETENSORS, ModelFormat.PYTORCH):
            backend = self._load_transformers(model_path, **kwargs)
        else:
            raise ValueError(f"Unsupported model format: {fmt}")

        if not spec:
            spec = ModelSpec(
                model_id=model_id,
                name=model_id,
                family="custom",
                parameters="unknown",
                context_length=context_length or 4096,
            )

        loaded = LoadedModel(
            model_id=model_id,
            spec=spec,
            format=fmt,
            quantization=quant,
            backend=backend,
        )

        self._loaded[model_id] = loaded
        self._active = loaded
        return loaded

    def unload(self, model_id: str) -> None:
        """Unload a model from memory."""
        if model_id in self._loaded:
            model = self._loaded.pop(model_id)
            if hasattr(model.backend, "close"):
                model.backend.close()
            del model.backend
            if self._active and self._active.model_id == model_id:
                self._active = None

    def unload_all(self) -> None:
        """Unload all models."""
        for model_id in list(self._loaded.keys()):
            self.unload(model_id)

    def _resolve_model_path(
        self, model_id: str, quant: QuantizationType
    ) -> Optional[Path]:
        """Find the model file on disk."""
        # Direct path
        direct = Path(model_id).expanduser()
        if direct.exists():
            return direct

        # Search in model directory
        search_patterns = [
            f"{model_id}*.gguf",
            f"{model_id}*{quant.value}*.gguf",
            f"*{model_id}*.gguf",
            f"{model_id}*/",
        ]

        for pattern in search_patterns:
            matches = list(self._model_dir.glob(pattern))
            if matches:
                return matches[0]

        return None

    def _detect_format(self, path: Path) -> ModelFormat:
        """Detect model file format."""
        if path.suffix == ".gguf":
            return ModelFormat.GGUF
        elif path.suffix == ".safetensors":
            return ModelFormat.SAFETENSORS
        elif path.suffix in (".bin", ".pt", ".pth"):
            return ModelFormat.PYTORCH
        elif path.suffix == ".onnx":
            return ModelFormat.ONNX
        elif path.is_dir():
            # Check for safetensors/bin in directory
            if list(path.glob("*.safetensors")):
                return ModelFormat.SAFETENSORS
            return ModelFormat.PYTORCH
        return ModelFormat.GGUF

    def _load_gguf(
        self,
        path: Path,
        gpu_layers: int = -1,
        context_length: Optional[int] = None,
        **kwargs,
    ) -> Any:
        """Load a GGUF model via llama-cpp-python."""
        try:
            from llama_cpp import Llama
        except ImportError:
            raise ImportError(
                "llama-cpp-python is required for GGUF models. "
                "Install with: pip install solus-ai[gguf]"
            )

        params = {
            "model_path": str(path),
            "n_gpu_layers": gpu_layers,
            "n_ctx": context_length or 4096,
            "verbose": False,
            **kwargs,
        }

        return Llama(**params)

    def _load_transformers(self, path: Path, **kwargs) -> Any:
        """Load a model via Hugging Face Transformers."""
        try:
            from transformers import AutoModelForCausalLM, AutoTokenizer
        except ImportError:
            raise ImportError(
                "transformers is required for safetensors/pytorch models. "
                "Install with: pip install solus-ai[gpu]"
            )

        model_path = str(path)
        tokenizer = AutoTokenizer.from_pretrained(model_path)
        model = AutoModelForCausalLM.from_pretrained(
            model_path,
            device_map="auto",
            **kwargs,
        )

        # Return a wrapper that combines model + tokenizer
        return _TransformersWrapper(model, tokenizer)

    def get_status(self) -> Dict[str, Any]:
        """Get model manager status."""
        return {
            "model_dir": str(self._model_dir),
            "local_models": self.list_local(),
            "loaded": list(self._loaded.keys()),
            "active": self._active.model_id if self._active else None,
            "registry_size": len(self._registry.list_all()),
        }


class _TransformersWrapper:
    """Wrapper to provide unified interface over Transformers models."""

    def __init__(self, model: Any, tokenizer: Any):
        self._model = model
        self._tokenizer = tokenizer

    def generate(self, prompt: str, max_tokens: int = 512, **kwargs) -> str:
        import torch

        inputs = self._tokenizer(prompt, return_tensors="pt").to(self._model.device)
        with torch.no_grad():
            outputs = self._model.generate(
                **inputs,
                max_new_tokens=max_tokens,
                do_sample=True,
                temperature=kwargs.get("temperature", 0.7),
                top_p=kwargs.get("top_p", 0.9),
            )
        generated = outputs[0][inputs["input_ids"].shape[1]:]
        return self._tokenizer.decode(generated, skip_special_tokens=True)

    def tokenize(self, text: str) -> list:
        return self._tokenizer.encode(text)

    def encode(self, text: str):
        import torch

        inputs = self._tokenizer(text, return_tensors="pt").to(self._model.device)
        with torch.no_grad():
            outputs = self._model(**inputs, output_hidden_states=True)
        return outputs.hidden_states[-1].mean(dim=1).squeeze().cpu().numpy()
