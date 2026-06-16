"""
🌐 External AI Gateway — Gate C Request Handler
================================================

MEDINA Sovereign Architecture
Author: Freddy (Founder Architect)

The Gateway is the primary interface between MEDINA
and external AI systems.

Gateway Responsibilities:
1. Receive requests from the organism
2. Project state through Gate C
3. Translate CPL to AI prompts
4. Route to appropriate adapter
5. Process responses back to CPL
6. Enforce rate limits and safety

All communication flows through the gateway.
No direct adapter access is permitted.
"""

from __future__ import annotations

import math
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

# Import local modules
from nova_ovo.external_ai.adapters import (
    ExternalAIAdapter,
    ClaudeAdapter,
    OpenAIAdapter,
    GenericLLMAdapter,
    AIProvider,
    AdapterRequest,
    AdapterResponse,
    create_adapter,
)
from nova_ovo.external_ai.projection import (
    ProjectionEngine,
    ProjectedState,
    SafetyFilter,
    ProjectionLevel,
)
from nova_ovo.external_ai.translator import (
    AIMessageTranslator,
    CPLtoPrompt,
    ResponsetoCPL,
)

# Import CPL types
from nova_ovo.cpl.protocol import (
    CPLMessage,
    CPLPayload,
    CPLIntent,
    CPLAuthority,
    TorusCoords,
    create_cpl_message,
    validate_cpl_message,
)

# Import gate enforcement
from nova_ovo.core.gates import (
    GateEnforcer,
    GateLevel,
    GateDecision,
    GateRecord,
)

# =================================================================== #
# MATHEMATICAL CONSTANTS — DERIVED FROM PRINCIPLES                      #
# =================================================================== #

PHI = (1 + math.sqrt(5)) / 2  # Golden Ratio φ
EPSILON = PHI ** -10  # Minimum non-zero value

# Metrics calculation constants
DEFAULT_METRICS_ALPHA = 0.1  # Moving average smoothing factor (0.1 = slow, 0.3 = fast)
RATE_LIMIT_WINDOW_SECONDS = 60


class RequestStatus(str, Enum):
    """Status of a gateway request."""
    PENDING = "pending"
    PROCESSING = "processing"
    COMPLETED = "completed"
    FAILED = "failed"
    REJECTED = "rejected"


class RejectionReason(str, Enum):
    """Reason for request rejection."""
    GATE_C_DENIED = "gate_c_denied"
    RATE_LIMITED = "rate_limited"
    INVALID_MESSAGE = "invalid_message"
    ADAPTER_ERROR = "adapter_error"
    RESONANCE_LOW = "resonance_low"


@dataclass
class AIRequest:
    """
    A request to the External AI Gateway.
    
    Wraps a CPL message with gateway metadata.
    """
    
    request_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    
    # Source CPL message
    cpl_message: Optional[CPLMessage] = None
    
    # Target configuration
    provider: AIProvider = AIProvider.CLAUDE
    model_override: Optional[str] = None
    
    # Request parameters
    max_tokens: int = 4096
    temperature: float = 0.7
    
    # State context
    organism_state: Dict[str, Any] = field(default_factory=dict)
    projection_level: ProjectionLevel = ProjectionLevel.PARTIAL
    
    # Tracking
    status: RequestStatus = RequestStatus.PENDING
    created_at: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "request_id": self.request_id,
            "has_cpl_message": self.cpl_message is not None,
            "provider": self.provider.value,
            "model_override": self.model_override,
            "max_tokens": self.max_tokens,
            "temperature": self.temperature,
            "projection_level": self.projection_level.value,
            "status": self.status.value,
            "created_at": self.created_at,
        }


@dataclass
class AIResponse:
    """
    A response from the External AI Gateway.
    
    Contains both the raw AI response and the CPL translation.
    """
    
    response_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    request_id: str = ""
    
    # Raw AI response
    content: str = ""
    finish_reason: str = "stop"
    
    # CPL translation
    cpl_response: Optional[CPLMessage] = None
    
    # Token usage
    input_tokens: int = 0
    output_tokens: int = 0
    
    # Quality metrics
    resonance_score: float = 0.0
    resonance_aligned: bool = True
    confidence: float = 0.0
    
    # Status
    status: RequestStatus = RequestStatus.COMPLETED
    error: Optional[str] = None
    rejection_reason: Optional[RejectionReason] = None
    
    # Timing
    latency_ms: float = 0.0
    created_at: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "response_id": self.response_id,
            "request_id": self.request_id,
            "content": self.content[:500] + "..." if len(self.content) > 500 else self.content,
            "finish_reason": self.finish_reason,
            "has_cpl_response": self.cpl_response is not None,
            "input_tokens": self.input_tokens,
            "output_tokens": self.output_tokens,
            "resonance_score": round(self.resonance_score, 4),
            "resonance_aligned": self.resonance_aligned,
            "confidence": round(self.confidence, 4),
            "status": self.status.value,
            "error": self.error,
            "rejection_reason": self.rejection_reason.value if self.rejection_reason else None,
            "latency_ms": round(self.latency_ms, 2),
        }


@dataclass
class GatewayMetrics:
    """Metrics for gateway monitoring."""
    
    total_requests: int = 0
    successful_requests: int = 0
    failed_requests: int = 0
    rejected_requests: int = 0
    
    total_input_tokens: int = 0
    total_output_tokens: int = 0
    
    avg_latency_ms: float = 0.0
    avg_resonance: float = 0.0
    
    gate_c_denials: int = 0
    rate_limited_count: int = 0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "total_requests": self.total_requests,
            "successful_requests": self.successful_requests,
            "failed_requests": self.failed_requests,
            "rejected_requests": self.rejected_requests,
            "success_rate": round(self.successful_requests / max(1, self.total_requests), 4),
            "total_input_tokens": self.total_input_tokens,
            "total_output_tokens": self.total_output_tokens,
            "avg_latency_ms": round(self.avg_latency_ms, 2),
            "avg_resonance": round(self.avg_resonance, 4),
            "gate_c_denials": self.gate_c_denials,
            "rate_limited_count": self.rate_limited_count,
        }


class ExternalAIGateway:
    """
    The External AI Gateway — Central orchestrator for AI integration.
    
    Architecture:
        CPL Message → Gate C Check → Projection → Translation → Adapter → Response → CPL
    
    The gateway ensures all interactions are:
    1. Gate C authorized
    2. Properly projected (no sovereign data)
    3. Correctly translated (CPL ↔ prompt)
    4. Safely processed (rate limits, errors)
    """
    
    def __init__(
        self,
        default_provider: AIProvider = AIProvider.CLAUDE,
        resonance_threshold: float = 0.5,
        metrics_alpha: float = DEFAULT_METRICS_ALPHA,
    ) -> None:
        # Configuration
        self.default_provider = default_provider
        self.resonance_threshold = resonance_threshold
        self._metrics_alpha = metrics_alpha  # Moving average smoothing factor
        
        # Core components
        self.gate_enforcer = GateEnforcer()
        self.projection_engine = ProjectionEngine()
        self.translator = AIMessageTranslator(resonance_threshold=resonance_threshold)
        
        # Adapters (lazy-loaded)
        self._adapters: Dict[AIProvider, ExternalAIAdapter] = {}
        
        # Request tracking
        self._pending_requests: Dict[str, AIRequest] = {}
        self._completed_requests: List[AIResponse] = []
        
        # Metrics
        self.metrics = GatewayMetrics()
        
        # Rate limiting (gateway level)
        self._requests_per_minute = 100
        self._request_times: List[float] = []
    
    def register_adapter(
        self,
        provider: AIProvider,
        adapter: ExternalAIAdapter,
    ) -> None:
        """Register an adapter for a provider."""
        self._adapters[provider] = adapter
    
    def configure_adapter(
        self,
        provider: AIProvider,
        api_key: str,
        model_id: Optional[str] = None,
    ) -> ExternalAIAdapter:
        """
        Configure and register an adapter with API key.
        
        Returns the configured adapter.
        """
        adapter = create_adapter(provider, model_id)
        adapter.set_api_key(api_key)
        self._adapters[provider] = adapter
        return adapter
    
    def _get_adapter(self, provider: AIProvider) -> ExternalAIAdapter:
        """Get adapter for provider, creating if needed."""
        if provider not in self._adapters:
            # Create default adapter (will need API key set)
            self._adapters[provider] = create_adapter(provider)
        return self._adapters[provider]
    
    def _check_rate_limit(self) -> bool:
        """Check if gateway rate limit allows the request."""
        now = time.time()
        
        # Clean old entries
        self._request_times = [t for t in self._request_times if now - t < RATE_LIMIT_WINDOW_SECONDS]
        
        if len(self._request_times) >= self._requests_per_minute:
            self.metrics.rate_limited_count += 1
            return False
        
        self._request_times.append(now)
        return True
    
    def _update_metrics(
        self,
        response: AIResponse,
        latency_ms: float,
    ) -> None:
        """Update gateway metrics with request outcome."""
        self.metrics.total_requests += 1
        
        if response.status == RequestStatus.COMPLETED:
            self.metrics.successful_requests += 1
        elif response.status == RequestStatus.FAILED:
            self.metrics.failed_requests += 1
        elif response.status == RequestStatus.REJECTED:
            self.metrics.rejected_requests += 1
        
        self.metrics.total_input_tokens += response.input_tokens
        self.metrics.total_output_tokens += response.output_tokens
        
        # Moving average for latency (using configurable alpha)
        alpha = self._metrics_alpha
        self.metrics.avg_latency_ms = (
            alpha * latency_ms + (1 - alpha) * self.metrics.avg_latency_ms
        )
        
        # Moving average for resonance (using configurable alpha)
        if response.resonance_score > 0:
            self.metrics.avg_resonance = (
                alpha * response.resonance_score + (1 - alpha) * self.metrics.avg_resonance
            )
    
    async def process_request(self, request: AIRequest) -> AIResponse:
        """
        Process an AI request through the gateway.
        
        Full pipeline:
        1. Validate CPL message
        2. Check Gate C authorization
        3. Project organism state
        4. Translate to AI prompt
        5. Send to adapter
        6. Translate response back to CPL
        7. Update metrics
        """
        start_time = time.time()
        request.status = RequestStatus.PROCESSING
        self._pending_requests[request.request_id] = request
        
        try:
            # Check gateway rate limit
            if not self._check_rate_limit():
                return self._create_rejection(
                    request,
                    RejectionReason.RATE_LIMITED,
                    "Gateway rate limit exceeded",
                )
            
            # Validate CPL message
            if request.cpl_message:
                valid, reason = validate_cpl_message(request.cpl_message)
                if not valid:
                    return self._create_rejection(
                        request,
                        RejectionReason.INVALID_MESSAGE,
                        f"Invalid CPL message: {reason}",
                    )
            
            # Gate C authorization check
            gate_payload = {
                "provider": request.provider.value,
                "intent": request.cpl_message.payload.intent.value if request.cpl_message else "query",
                "state_keys": list(request.organism_state.keys()) if request.organism_state else [],
            }
            
            gate_record = self.gate_enforcer.evaluate(
                gate=GateLevel.C,
                action_type="external_ai_request",
                payload=gate_payload,
                actor="gateway",
            )
            
            if gate_record.decision != GateDecision.PASS:
                self.metrics.gate_c_denials += 1
                return self._create_rejection(
                    request,
                    RejectionReason.GATE_C_DENIED,
                    f"Gate C denied: {gate_record.reason}",
                )
            
            # Project organism state
            projected_state = self.projection_engine.project(
                state=request.organism_state,
                level=request.projection_level,
                requester=f"ai_gateway:{request.provider.value}",
                beat=request.cpl_message.beat if request.cpl_message else 0,
            )
            
            # Translate to AI prompt
            if request.cpl_message:
                prompt_translation = self.translator.cpl_to_prompt(
                    message=request.cpl_message,
                    include_context=True,
                )
            else:
                # Create a default prompt if no CPL message
                prompt_translation = CPLtoPrompt(
                    system_prompt="You are an AI assistant integrated with MEDINA.",
                    user_prompt="Please respond to the following request.",
                    context=self.projection_engine.project_for_prompt(
                        request.organism_state,
                        beat=0,
                    ),
                )
            
            # Get adapter
            adapter = self._get_adapter(request.provider)
            
            # Build adapter request
            adapter_request = AdapterRequest(
                system_prompt=prompt_translation.system_prompt,
                messages=prompt_translation.to_messages(),
                max_tokens=request.max_tokens,
                temperature=request.temperature,
                lineage=prompt_translation.lineage,
                resonance=prompt_translation.resonance,
                beat=prompt_translation.beat,
            )
            
            # Send to adapter
            adapter_response = await adapter.complete(adapter_request)
            
            if not adapter_response.success:
                return self._create_failure(
                    request,
                    adapter_response.error or "Adapter error",
                    start_time,
                )
            
            # Translate response back to CPL
            if request.cpl_message:
                response_translation = self.translator.response_to_cpl(
                    response_content=adapter_response.content,
                    response_tokens=adapter_response.output_tokens,
                    original_message=request.cpl_message,
                    sender=f"external_ai:{request.provider.value}",
                )
            else:
                response_translation = ResponsetoCPL(
                    response_content=adapter_response.content,
                    response_tokens=adapter_response.output_tokens,
                    confidence=0.8,
                    resonance_checked=False,
                )
            
            # Build final response
            latency_ms = (time.time() - start_time) * 1000
            
            response = AIResponse(
                request_id=request.request_id,
                content=adapter_response.content,
                finish_reason=adapter_response.finish_reason,
                cpl_response=response_translation.cpl_message,
                input_tokens=adapter_response.input_tokens,
                output_tokens=adapter_response.output_tokens,
                resonance_score=response_translation.resonance_score,
                resonance_aligned=response_translation.resonance_aligned,
                confidence=response_translation.confidence,
                status=RequestStatus.COMPLETED,
                latency_ms=latency_ms,
            )
            
            # Update metrics
            self._update_metrics(response, latency_ms)
            
            # Cleanup
            del self._pending_requests[request.request_id]
            self._completed_requests.append(response)
            
            # Keep completed requests bounded
            if len(self._completed_requests) > 1000:
                self._completed_requests = self._completed_requests[-500:]
            
            return response
            
        except Exception as e:
            return self._create_failure(
                request,
                str(e),
                start_time,
            )
    
    def _create_rejection(
        self,
        request: AIRequest,
        reason: RejectionReason,
        error: str,
    ) -> AIResponse:
        """Create a rejection response."""
        request.status = RequestStatus.REJECTED
        
        response = AIResponse(
            request_id=request.request_id,
            status=RequestStatus.REJECTED,
            error=error,
            rejection_reason=reason,
        )
        
        self._pending_requests.pop(request.request_id, None)
        self._completed_requests.append(response)
        self._update_metrics(response, 0.0)
        
        return response
    
    def _create_failure(
        self,
        request: AIRequest,
        error: str,
        start_time: float,
    ) -> AIResponse:
        """Create a failure response."""
        request.status = RequestStatus.FAILED
        latency_ms = (time.time() - start_time) * 1000
        
        response = AIResponse(
            request_id=request.request_id,
            status=RequestStatus.FAILED,
            error=error,
            latency_ms=latency_ms,
        )
        
        if request.request_id in self._pending_requests:
            del self._pending_requests[request.request_id]
        self._completed_requests.append(response)
        self._update_metrics(response, latency_ms)
        
        return response
    
    def get_pending_requests(self) -> List[AIRequest]:
        """Get list of pending requests."""
        return list(self._pending_requests.values())
    
    def get_recent_responses(self, limit: int = 100) -> List[AIResponse]:
        """Get recent completed responses."""
        return self._completed_requests[-limit:]
    
    def status(self) -> Dict[str, Any]:
        """Get gateway status."""
        adapter_statuses = {}
        for provider, adapter in self._adapters.items():
            adapter_statuses[provider.value] = adapter.get_status()
        
        return {
            "default_provider": self.default_provider.value,
            "resonance_threshold": self.resonance_threshold,
            "adapters": adapter_statuses,
            "pending_requests": len(self._pending_requests),
            "completed_requests": len(self._completed_requests),
            "metrics": self.metrics.to_dict(),
            "projection_summary": self.projection_engine.audit_summary(),
            "translation_stats": self.translator.translation_statistics(),
            "gate_summary": self.gate_enforcer.audit_summary(),
        }
