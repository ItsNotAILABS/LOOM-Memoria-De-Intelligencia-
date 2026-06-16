"""
SOLUS Runtime — Local Model Execution Environment
==================================================

PROT-662: Core runtime that manages model lifecycle, hardware detection,
memory allocation, and execution context for local inference.
"""

from __future__ import annotations

import os
import platform
import time
from dataclasses import dataclass, field
from enum import Enum
from pathlib import Path
from typing import Any, Dict, Optional


PHI = 1.618033988749895


class HardwareBackend(str, Enum):
    """Available hardware backends for inference."""
    CPU = "cpu"
    CUDA = "cuda"
    METAL = "metal"
    VULKAN = "vulkan"
    OPENCL = "opencl"
    AUTO = "auto"


class RuntimeStatus(str, Enum):
    """Runtime operational status."""
    IDLE = "idle"
    LOADING = "loading"
    READY = "ready"
    INFERRING = "inferring"
    ERROR = "error"


@dataclass
class HardwareProfile:
    """Detected hardware capabilities."""
    cpu_cores: int = 0
    cpu_threads: int = 0
    ram_total_gb: float = 0.0
    ram_available_gb: float = 0.0
    gpu_available: bool = False
    gpu_name: str = ""
    gpu_vram_gb: float = 0.0
    backend: HardwareBackend = HardwareBackend.CPU
    os_name: str = ""
    arch: str = ""

    @classmethod
    def detect(cls) -> "HardwareProfile":
        """Detect current hardware capabilities."""
        profile = cls()
        profile.os_name = platform.system()
        profile.arch = platform.machine()
        profile.cpu_cores = os.cpu_count() or 1
        profile.cpu_threads = profile.cpu_cores * 2

        # Estimate RAM (portable fallback)
        try:
            import shutil
            total, _, free = shutil.disk_usage("/")
            # Use os-level memory detection
            if hasattr(os, "sysconf"):
                pages = os.sysconf("SC_PHYS_PAGES")
                page_size = os.sysconf("SC_PAGE_SIZE")
                if pages and page_size:
                    profile.ram_total_gb = (pages * page_size) / (1024**3)
        except (OSError, ValueError):
            profile.ram_total_gb = 8.0  # Safe default

        # GPU detection
        profile.gpu_available = False
        try:
            import torch
            if torch.cuda.is_available():
                profile.gpu_available = True
                profile.gpu_name = torch.cuda.get_device_name(0)
                profile.gpu_vram_gb = torch.cuda.get_device_properties(0).total_mem / (1024**3)
                profile.backend = HardwareBackend.CUDA
            elif hasattr(torch.backends, "mps") and torch.backends.mps.is_available():
                profile.gpu_available = True
                profile.gpu_name = "Apple Silicon (MPS)"
                profile.backend = HardwareBackend.METAL
        except ImportError:
            pass

        if not profile.gpu_available and profile.os_name == "Darwin":
            profile.backend = HardwareBackend.METAL

        return profile


@dataclass
class RuntimeConfig:
    """Runtime configuration."""
    model_dir: str = "~/.solus/models"
    cache_dir: str = "~/.solus/cache"
    max_context_length: int = 8192
    max_batch_size: int = 1
    num_threads: int = 0  # 0 = auto
    backend: HardwareBackend = HardwareBackend.AUTO
    gpu_layers: int = -1  # -1 = all
    memory_lock: bool = False
    flash_attention: bool = True
    phi_resonance: float = PHI

    def resolve_paths(self) -> None:
        """Expand user paths."""
        self.model_dir = str(Path(self.model_dir).expanduser())
        self.cache_dir = str(Path(self.cache_dir).expanduser())

    def ensure_dirs(self) -> None:
        """Create directories if they don't exist."""
        self.resolve_paths()
        Path(self.model_dir).mkdir(parents=True, exist_ok=True)
        Path(self.cache_dir).mkdir(parents=True, exist_ok=True)


class SolusRuntime:
    """
    SOLUS Runtime — The local execution environment.

    Manages:
    - Hardware detection and backend selection
    - Model lifecycle (load, unload, swap)
    - Memory allocation and context windows
    - Inference scheduling
    """

    def __init__(
        self,
        model_dir: str = "~/.solus/models",
        config_path: str | None = None,
    ):
        self.config = RuntimeConfig(model_dir=model_dir)
        self.config.ensure_dirs()
        self.hardware = HardwareProfile.detect()
        self.status = RuntimeStatus.IDLE
        self._boot_time = time.time()
        self._inference_count = 0
        self._total_tokens = 0
        self._loaded_model: Optional[str] = None

        if config_path:
            self._load_config(config_path)

        # Auto-configure threads
        if self.config.num_threads == 0:
            self.config.num_threads = max(1, self.hardware.cpu_cores - 1)

    def _load_config(self, path: str) -> None:
        """Load configuration from YAML file."""
        import yaml
        config_path = Path(path).expanduser()
        if config_path.exists():
            with open(config_path) as f:
                data = yaml.safe_load(f)
            if data:
                for key, value in data.items():
                    if hasattr(self.config, key):
                        setattr(self.config, key, value)

    @property
    def uptime_seconds(self) -> float:
        """Runtime uptime in seconds."""
        return time.time() - self._boot_time

    @property
    def tokens_per_second(self) -> float:
        """Average inference throughput."""
        if self.uptime_seconds == 0:
            return 0.0
        return self._total_tokens / self.uptime_seconds

    def record_inference(self, tokens: int) -> None:
        """Record inference statistics."""
        self._inference_count += 1
        self._total_tokens += tokens

    def get_status(self) -> Dict[str, Any]:
        """Get full runtime status."""
        return {
            "status": self.status.value,
            "uptime_s": round(self.uptime_seconds, 2),
            "hardware": {
                "backend": self.hardware.backend.value,
                "cpu_cores": self.hardware.cpu_cores,
                "ram_gb": round(self.hardware.ram_total_gb, 1),
                "gpu": self.hardware.gpu_name if self.hardware.gpu_available else None,
                "gpu_vram_gb": round(self.hardware.gpu_vram_gb, 1) if self.hardware.gpu_available else None,
            },
            "inference": {
                "count": self._inference_count,
                "total_tokens": self._total_tokens,
                "tokens_per_second": round(self.tokens_per_second, 2),
            },
            "config": {
                "model_dir": self.config.model_dir,
                "max_context": self.config.max_context_length,
                "threads": self.config.num_threads,
                "flash_attention": self.config.flash_attention,
            },
            "loaded_model": self._loaded_model,
        }

    def __repr__(self) -> str:
        return (
            f"SolusRuntime(status={self.status.value}, "
            f"backend={self.hardware.backend.value}, "
            f"model={self._loaded_model})"
        )
