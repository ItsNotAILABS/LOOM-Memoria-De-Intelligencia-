"""
🔌 External AI Adapters — Provider Interface Layer
===================================================

MEDINA Sovereign Architecture
Author: Freddy (Founder Architect)

Adapter pattern for external AI providers.

Each adapter:
- Implements the ExternalAIAdapter interface
- Handles provider-specific authentication
- Transforms requests/responses to/from provider format
- Maintains provider state and rate limits

The adapters are Gate C bounded — they only receive
projected state, never sovereign internals.
"""

from __future__ import annotations

import math
import time
import uuid
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

# =================================================================== #
# MATHEMATICAL CONSTANTS — DERIVED FROM PRINCIPLES                      #
# =================================================================== #

# Golden ratio — natural scaling constant (Pythagorean)
PHI = (1 + math.sqrt(5)) / 2  # Golden Ratio φ
EPSILON = PHI ** -10  # Minimum non-zero value

# Rate limiting constants
SECONDS_PER_MINUTE = 60


class AIProvider(str, Enum):
    """Supported external AI providers."""
    CLAUDE = "claude"
    OPENAI = "openai"
    GENERIC = "generic"


class ModelTier(str, Enum):
    """Model capability tiers."""
    TIER_1 = "tier_1"  # Basic models (haiku, gpt-3.5)
    TIER_2 = "tier_2"  # Standard models (sonnet, gpt-4)
    TIER_3 = "tier_3"  # Advanced models (opus, gpt-4-turbo)


@dataclass
class AIModelConfig:
    """Configuration for an external AI model."""
    
    provider: AIProvider
    model_id: str
    tier: ModelTier = ModelTier.TIER_2
    max_tokens: int = 4096
    temperature: float = 0.7
    context_window: int = 100000
    
    # Rate limiting
    requests_per_minute: int = 60
    tokens_per_minute: int = 100000
    
    # Cost tracking
    input_cost_per_1k: float = 0.0
    output_cost_per_1k: float = 0.0


@dataclass
class AdapterState:
    """State tracking for an adapter instance."""
    
    adapter_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    provider: AIProvider = AIProvider.GENERIC
    
    # Usage tracking
    total_requests: int = 0
    total_input_tokens: int = 0
    total_output_tokens: int = 0
    total_cost: float = 0.0
    
    # Rate limiting state
    requests_this_minute: int = 0
    tokens_this_minute: int = 0
    minute_start: float = field(default_factory=time.time)
    
    # Health metrics
    success_rate: float = 1.0
    avg_latency_ms: float = 0.0
    last_error: Optional[str] = None
    last_request_time: float = field(default_factory=time.time)
    
    def reset_minute_counters(self) -> None:
        """Reset rate limit counters for new minute."""
        self.requests_this_minute = 0
        self.tokens_this_minute = 0
        self.minute_start = time.time()
    
    def update_health(
        self,
        success: bool,
        latency_ms: float,
        error: Optional[str] = None,
    ) -> None:
        """Update health metrics with request outcome."""
        # Exponential moving average for success rate
        alpha = 0.1
        self.success_rate = alpha * (1.0 if success else 0.0) + (1 - alpha) * self.success_rate
        
        # Moving average for latency
        self.avg_latency_ms = alpha * latency_ms + (1 - alpha) * self.avg_latency_ms
        
        if not success and error:
            self.last_error = error
        
        self.last_request_time = time.time()
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "adapter_id": self.adapter_id,
            "provider": self.provider.value,
            "total_requests": self.total_requests,
            "total_input_tokens": self.total_input_tokens,
            "total_output_tokens": self.total_output_tokens,
            "total_cost": round(self.total_cost, 4),
            "success_rate": round(self.success_rate, 4),
            "avg_latency_ms": round(self.avg_latency_ms, 2),
            "last_error": self.last_error,
        }


@dataclass
class AdapterRequest:
    """Request to an external AI adapter."""
    
    request_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    
    # Message content
    system_prompt: str = ""
    messages: List[Dict[str, str]] = field(default_factory=list)
    
    # Generation parameters
    max_tokens: int = 4096
    temperature: float = 0.7
    stop_sequences: List[str] = field(default_factory=list)
    
    # Metadata
    lineage: List[str] = field(default_factory=list)
    resonance: float = 1.0
    beat: int = 0


@dataclass
class AdapterResponse:
    """Response from an external AI adapter."""
    
    response_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    request_id: str = ""
    
    # Response content
    content: str = ""
    finish_reason: str = "stop"
    
    # Token counts
    input_tokens: int = 0
    output_tokens: int = 0
    
    # Timing
    latency_ms: float = 0.0
    timestamp: float = field(default_factory=time.time)
    
    # Status
    success: bool = True
    error: Optional[str] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "response_id": self.response_id,
            "request_id": self.request_id,
            "content": self.content,
            "finish_reason": self.finish_reason,
            "input_tokens": self.input_tokens,
            "output_tokens": self.output_tokens,
            "latency_ms": round(self.latency_ms, 2),
            "success": self.success,
            "error": self.error,
        }


class ExternalAIAdapter(ABC):
    """
    Abstract base class for external AI adapters.
    
    All adapters must implement:
    - complete(): Send request and get response
    - validate_config(): Check configuration is valid
    - health_check(): Verify adapter is operational
    """
    
    def __init__(self, config: AIModelConfig) -> None:
        self.config = config
        self.state = AdapterState(provider=config.provider)
        self._api_key: Optional[str] = None
    
    def set_api_key(self, api_key: str) -> None:
        """Set API key for authentication."""
        self._api_key = api_key
    
    def _check_rate_limits(self, estimated_tokens: int) -> Tuple[bool, str]:
        """Check if request would exceed rate limits."""
        now = time.time()
        
        # Reset counters if minute has passed
        if now - self.state.minute_start >= SECONDS_PER_MINUTE:
            self.state.reset_minute_counters()
        
        # Check request limit
        if self.state.requests_this_minute >= self.config.requests_per_minute:
            return False, "Request rate limit exceeded"
        
        # Check token limit
        if self.state.tokens_this_minute + estimated_tokens > self.config.tokens_per_minute:
            return False, "Token rate limit exceeded"
        
        return True, "OK"
    
    def _update_usage(
        self,
        input_tokens: int,
        output_tokens: int,
        latency_ms: float,
        success: bool,
        error: Optional[str] = None,
    ) -> None:
        """Update usage tracking after request."""
        self.state.total_requests += 1
        self.state.total_input_tokens += input_tokens
        self.state.total_output_tokens += output_tokens
        
        # Calculate cost
        input_cost = (input_tokens / 1000) * self.config.input_cost_per_1k
        output_cost = (output_tokens / 1000) * self.config.output_cost_per_1k
        self.state.total_cost += input_cost + output_cost
        
        # Update rate limit counters
        self.state.requests_this_minute += 1
        self.state.tokens_this_minute += input_tokens + output_tokens
        
        # Update health metrics
        self.state.update_health(success, latency_ms, error)
    
    @abstractmethod
    async def complete(self, request: AdapterRequest) -> AdapterResponse:
        """
        Send completion request to external AI.
        
        Must be implemented by each provider adapter.
        """
        pass
    
    @abstractmethod
    def validate_config(self) -> Tuple[bool, str]:
        """
        Validate adapter configuration.
        
        Returns (valid, reason).
        """
        pass
    
    @abstractmethod
    async def health_check(self) -> Tuple[bool, str]:
        """
        Check if adapter is operational.
        
        Returns (healthy, reason).
        """
        pass
    
    def get_status(self) -> Dict[str, Any]:
        """Get adapter status for monitoring."""
        return {
            "config": {
                "provider": self.config.provider.value,
                "model_id": self.config.model_id,
                "tier": self.config.tier.value,
            },
            "state": self.state.to_dict(),
            "has_api_key": self._api_key is not None,
        }


class ClaudeAdapter(ExternalAIAdapter):
    """
    Adapter for Anthropic's Claude models.
    
    Supports Claude 3 family: Haiku, Sonnet, Opus.
    """
    
    CLAUDE_MODELS = {
        "claude-3-haiku-20240307": ModelTier.TIER_1,
        "claude-3-sonnet-20240229": ModelTier.TIER_2,
        "claude-3-opus-20240229": ModelTier.TIER_3,
        "claude-3-5-sonnet-20241022": ModelTier.TIER_2,
    }
    
    def __init__(self, model_id: str = "claude-3-5-sonnet-20241022") -> None:
        config = AIModelConfig(
            provider=AIProvider.CLAUDE,
            model_id=model_id,
            tier=self.CLAUDE_MODELS.get(model_id, ModelTier.TIER_2),
            max_tokens=4096,
            temperature=0.7,
            context_window=200000,
            requests_per_minute=60,
            tokens_per_minute=100000,
            input_cost_per_1k=0.003,   # $3/1M
            output_cost_per_1k=0.015,  # $15/1M
        )
        super().__init__(config)
        self._base_url = "https://api.anthropic.com/v1/messages"
    
    def validate_config(self) -> Tuple[bool, str]:
        """Validate Claude configuration."""
        if self.config.model_id not in self.CLAUDE_MODELS:
            return False, f"Unknown Claude model: {self.config.model_id}"
        if not self._api_key:
            return False, "API key not set"
        return True, "Valid"
    
    async def health_check(self) -> Tuple[bool, str]:
        """Check Claude API health."""
        if not self._api_key:
            return False, "API key not set"
        
        # In production, this would make a lightweight API call
        # For now, return healthy if API key is set
        return True, "Claude adapter operational"
    
    async def complete(self, request: AdapterRequest) -> AdapterResponse:
        """
        Send completion request to Claude API.
        
        Note: This is a simulation. In production, this would use
        the actual Anthropic SDK or HTTP client.
        """
        start_time = time.time()
        
        # Validate configuration
        valid, reason = self.validate_config()
        if not valid:
            return AdapterResponse(
                request_id=request.request_id,
                success=False,
                error=reason,
            )
        
        # Check rate limits
        estimated_tokens = len(request.system_prompt.split()) + sum(
            len(m.get("content", "").split()) for m in request.messages
        )
        ok, reason = self._check_rate_limits(estimated_tokens * 2)
        if not ok:
            return AdapterResponse(
                request_id=request.request_id,
                success=False,
                error=reason,
            )
        
        # Simulate API call
        # In production: use anthropic SDK
        # response = await self._client.messages.create(...)
        
        latency_ms = (time.time() - start_time) * 1000
        
        # Simulated response
        response = AdapterResponse(
            request_id=request.request_id,
            content="[Claude response would appear here in production]",
            finish_reason="stop",
            input_tokens=estimated_tokens,
            output_tokens=100,
            latency_ms=latency_ms,
            success=True,
        )
        
        self._update_usage(
            input_tokens=response.input_tokens,
            output_tokens=response.output_tokens,
            latency_ms=latency_ms,
            success=True,
        )
        
        return response


class OpenAIAdapter(ExternalAIAdapter):
    """
    Adapter for OpenAI models.
    
    Supports GPT-4 family and GPT-3.5.
    """
    
    OPENAI_MODELS = {
        "gpt-3.5-turbo": ModelTier.TIER_1,
        "gpt-4": ModelTier.TIER_2,
        "gpt-4-turbo": ModelTier.TIER_3,
        "gpt-4o": ModelTier.TIER_2,
        "gpt-4o-mini": ModelTier.TIER_1,
    }
    
    def __init__(self, model_id: str = "gpt-4o") -> None:
        config = AIModelConfig(
            provider=AIProvider.OPENAI,
            model_id=model_id,
            tier=self.OPENAI_MODELS.get(model_id, ModelTier.TIER_2),
            max_tokens=4096,
            temperature=0.7,
            context_window=128000,
            requests_per_minute=60,
            tokens_per_minute=150000,
            input_cost_per_1k=0.005,   # $5/1M
            output_cost_per_1k=0.015,  # $15/1M
        )
        super().__init__(config)
        self._base_url = "https://api.openai.com/v1/chat/completions"
    
    def validate_config(self) -> Tuple[bool, str]:
        """Validate OpenAI configuration."""
        if self.config.model_id not in self.OPENAI_MODELS:
            return False, f"Unknown OpenAI model: {self.config.model_id}"
        if not self._api_key:
            return False, "API key not set"
        return True, "Valid"
    
    async def health_check(self) -> Tuple[bool, str]:
        """Check OpenAI API health."""
        if not self._api_key:
            return False, "API key not set"
        return True, "OpenAI adapter operational"
    
    async def complete(self, request: AdapterRequest) -> AdapterResponse:
        """
        Send completion request to OpenAI API.
        
        Note: This is a simulation. In production, this would use
        the actual OpenAI SDK or HTTP client.
        """
        start_time = time.time()
        
        # Validate configuration
        valid, reason = self.validate_config()
        if not valid:
            return AdapterResponse(
                request_id=request.request_id,
                success=False,
                error=reason,
            )
        
        # Check rate limits
        estimated_tokens = len(request.system_prompt.split()) + sum(
            len(m.get("content", "").split()) for m in request.messages
        )
        ok, reason = self._check_rate_limits(estimated_tokens * 2)
        if not ok:
            return AdapterResponse(
                request_id=request.request_id,
                success=False,
                error=reason,
            )
        
        # Simulate API call
        # In production: use openai SDK
        # response = await self._client.chat.completions.create(...)
        
        latency_ms = (time.time() - start_time) * 1000
        
        # Simulated response
        response = AdapterResponse(
            request_id=request.request_id,
            content="[OpenAI response would appear here in production]",
            finish_reason="stop",
            input_tokens=estimated_tokens,
            output_tokens=100,
            latency_ms=latency_ms,
            success=True,
        )
        
        self._update_usage(
            input_tokens=response.input_tokens,
            output_tokens=response.output_tokens,
            latency_ms=latency_ms,
            success=True,
        )
        
        return response


class GenericLLMAdapter(ExternalAIAdapter):
    """
    Generic adapter for any LLM provider.
    
    Configurable for any OpenAI-compatible API.
    """
    
    def __init__(
        self,
        model_id: str,
        base_url: str,
        tier: ModelTier = ModelTier.TIER_2,
    ) -> None:
        config = AIModelConfig(
            provider=AIProvider.GENERIC,
            model_id=model_id,
            tier=tier,
            max_tokens=4096,
            temperature=0.7,
            context_window=32000,
            requests_per_minute=60,
            tokens_per_minute=100000,
            input_cost_per_1k=0.0,
            output_cost_per_1k=0.0,
        )
        super().__init__(config)
        self._base_url = base_url
    
    def validate_config(self) -> Tuple[bool, str]:
        """Validate generic adapter configuration."""
        if not self._base_url:
            return False, "Base URL not set"
        if not self._api_key:
            return False, "API key not set"
        return True, "Valid"
    
    async def health_check(self) -> Tuple[bool, str]:
        """Check generic API health."""
        if not self._api_key:
            return False, "API key not set"
        return True, "Generic adapter operational"
    
    async def complete(self, request: AdapterRequest) -> AdapterResponse:
        """
        Send completion request to generic LLM API.
        
        Uses OpenAI-compatible format.
        """
        start_time = time.time()
        
        # Validate configuration
        valid, reason = self.validate_config()
        if not valid:
            return AdapterResponse(
                request_id=request.request_id,
                success=False,
                error=reason,
            )
        
        # Estimate tokens
        estimated_tokens = len(request.system_prompt.split()) + sum(
            len(m.get("content", "").split()) for m in request.messages
        )
        
        latency_ms = (time.time() - start_time) * 1000
        
        # Simulated response
        response = AdapterResponse(
            request_id=request.request_id,
            content="[Generic LLM response would appear here in production]",
            finish_reason="stop",
            input_tokens=estimated_tokens,
            output_tokens=100,
            latency_ms=latency_ms,
            success=True,
        )
        
        self._update_usage(
            input_tokens=response.input_tokens,
            output_tokens=response.output_tokens,
            latency_ms=latency_ms,
            success=True,
        )
        
        return response


def create_adapter(
    provider: AIProvider,
    model_id: Optional[str] = None,
    **kwargs: Any,
) -> ExternalAIAdapter:
    """
    Factory function to create an adapter for a provider.
    
    Returns the appropriate adapter instance.
    """
    if provider == AIProvider.CLAUDE:
        return ClaudeAdapter(model_id or "claude-3-5-sonnet-20241022")
    elif provider == AIProvider.OPENAI:
        return OpenAIAdapter(model_id or "gpt-4o")
    elif provider == AIProvider.GENERIC:
        base_url = kwargs.get("base_url", "")
        if not base_url:
            raise ValueError("base_url required for generic adapter")
        return GenericLLMAdapter(
            model_id=model_id or "generic-model",
            base_url=base_url,
        )
    else:
        raise ValueError(f"Unknown provider: {provider}")
