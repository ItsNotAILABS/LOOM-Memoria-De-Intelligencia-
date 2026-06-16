"""
ORCH-06 NEURAL_CORE_MESH_ORCHESTRATOR — Model routing.

Implements multi-model runtime with role-specialized models:
- strategist, builder, analyst, governance
- memory curator, operations, defense/risk, projection

Model families:
- R-MODEL-* : Runtime organism models
- U-MODEL-* : Interface operation models
- D-MODEL-* : Document intelligence models
- N-MODEL-* : Sovereign macro-node models
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional


class ModelFamily(Enum):
    """Model family classification."""
    
    R_MODEL = "R-MODEL"  # Runtime organism
    U_MODEL = "U-MODEL"  # Interface operation
    D_MODEL = "D-MODEL"  # Document intelligence
    N_MODEL = "N-MODEL"  # Sovereign macro-node


class ModelRole(Enum):
    """Specialized model roles."""
    
    STRATEGIST = "strategist"
    BUILDER = "builder"
    ANALYST = "analyst"
    GOVERNANCE = "governance"
    MEMORY_CURATOR = "memory_curator"
    OPERATIONS = "operations"
    DEFENSE_RISK = "defense_risk"
    PROJECTION = "projection"


class ModelState(Enum):
    """Model instance states."""
    
    AVAILABLE = "available"
    BUSY = "busy"
    DEGRADED = "degraded"
    OFFLINE = "offline"


@dataclass
class ModelSpec:
    """Specification for a registered model."""
    
    model_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    family: ModelFamily = ModelFamily.R_MODEL
    role: ModelRole = ModelRole.BUILDER
    version: str = "1.0.0"
    state: ModelState = ModelState.AVAILABLE
    
    # Capabilities
    capabilities: List[str] = field(default_factory=list)
    max_context_tokens: int = 8192
    
    # Routing metadata
    priority: int = 0  # Higher = preferred
    affinity_tags: List[str] = field(default_factory=list)
    
    # Health
    last_invocation: Optional[float] = None
    invocation_count: int = 0
    error_count: int = 0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "model_id": self.model_id,
            "name": self.name,
            "family": self.family.value,
            "role": self.role.value,
            "version": self.version,
            "state": self.state.value,
            "capabilities": self.capabilities,
            "max_context_tokens": self.max_context_tokens,
            "priority": self.priority,
            "affinity_tags": self.affinity_tags,
            "invocation_count": self.invocation_count,
            "error_count": self.error_count,
        }


@dataclass
class InvocationRequest:
    """Request to invoke a model."""
    
    request_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    role: Optional[ModelRole] = None
    family: Optional[ModelFamily] = None
    model_id: Optional[str] = None  # Direct routing
    prompt: str = ""
    context: Dict[str, Any] = field(default_factory=dict)
    max_tokens: int = 1024
    required_capabilities: List[str] = field(default_factory=list)
    affinity_tags: List[str] = field(default_factory=list)
    timestamp: float = field(default_factory=time.time)


@dataclass
class InvocationResult:
    """Result from model invocation."""
    
    request_id: str = ""
    model_id: str = ""
    model_name: str = ""
    success: bool = True
    output: Any = None
    error: Optional[str] = None
    latency_ms: float = 0.0
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "request_id": self.request_id,
            "model_id": self.model_id,
            "model_name": self.model_name,
            "success": self.success,
            "output": self.output if self.success else None,
            "error": self.error,
            "latency_ms": round(self.latency_ms, 3),
            "timestamp": self.timestamp,
        }


# Model handler function type
ModelHandler = Callable[[InvocationRequest], Any]


class ModelRouterOrchestrator:
    """
    ORCH-06 NEURAL_CORE_MESH_ORCHESTRATOR
    
    Multi-model runtime with intelligent routing.
    
    Responsibilities:
    - Register and manage model pool
    - Route requests to appropriate models
    - Balance load and handle failures
    - Track invocation metrics
    
    Routing priority:
    1. Direct model_id (if specified)
    2. Role match with highest priority
    3. Capability match
    4. Affinity tag match
    """
    
    # Default R-MODEL names from spec
    DEFAULT_R_MODELS = [
        "R-MODEL-HEARTBEAT-CORE",
        "R-MODEL-CCVE-STATE",
        "R-MODEL-CNCO-STATE",
        "R-MODEL-GRPE-STATE",
        "R-MODEL-AUTONOMOUS-ANALYST",
        "R-MODEL-MEMORY-TEMPLE-STATE",
        "R-MODEL-CONSTANT-FEEDBACK",
        "R-MODEL-NEUROCHEM-CROSSTALK",
        "R-MODEL-UNIFIED-EMOTIONAL-FIELD",
        "R-MODEL-PARALLAX-DECISION",
        "R-MODEL-ENTANGLA-SOCIAL-BINDING",
        "R-MODEL-NEURAL-CORE-MESH",
        "R-MODEL-LIVING-ARCHITECTURE-MACRO",
        "R-MODEL-SWARM-COHERENCE",
        "R-MODEL-DRIFT-JASMINE",
        "R-MODEL-QUANTUM-CHANNEL-FABRIC",
        "R-MODEL-AUDIT-REPLAY",
        "R-MODEL-GOVERNANCE-HEARTBEAT",
        "R-MODEL-STABILITY-BUDGET",
        "R-MODEL-RISK-MANAGEMENT",
        "R-MODEL-WAR-DEFENSE",
        "R-MODEL-WORLD-ORGANISM-BRIDGE",
        "R-MODEL-SACRED-MATHEMATICS",
    ]
    
    # Default U-MODEL names from spec
    DEFAULT_U_MODELS = [
        "U-MODEL-MEDINA-COMMAND-CENTER",
        "U-MODEL-MEMORY-TEMPLE-LAB",
        "U-MODEL-MEMORY-NAVIGATION",
        "U-MODEL-CONSTANT-FEEDBACK-LAB",
        "U-MODEL-INTERNAL-ANALYSIS-LAB",
        "U-MODEL-GRPE-LAB",
        "U-MODEL-EMERGENCE-LAB",
        "U-MODEL-MATH-PHYSICS-LAB",
        "U-MODEL-NEUROCOG-LAB",
        "U-MODEL-AGENT-WORKSPACE",
        "U-MODEL-COMPANION-CONSOLE",
        "U-MODEL-DRONE-SIM-WORLD",
    ]
    
    def __init__(self) -> None:
        self._id = str(uuid.uuid4())
        self._models: Dict[str, ModelSpec] = {}
        self._handlers: Dict[str, ModelHandler] = {}
        self._invocation_log: List[InvocationResult] = []
        self._current_beat = 0
        
        # Initialize default model registry
        self._initialize_default_models()
    
    def _initialize_default_models(self) -> None:
        """Register default model placeholders."""
        # R-MODELS
        for name in self.DEFAULT_R_MODELS:
            spec = ModelSpec(
                name=name,
                family=ModelFamily.R_MODEL,
                role=self._infer_role(name),
            )
            self._models[spec.model_id] = spec
        
        # U-MODELS
        for name in self.DEFAULT_U_MODELS:
            spec = ModelSpec(
                name=name,
                family=ModelFamily.U_MODEL,
                role=self._infer_role(name),
            )
            self._models[spec.model_id] = spec
    
    def _infer_role(self, name: str) -> ModelRole:
        """Infer model role from name."""
        name_lower = name.lower()
        
        if "governance" in name_lower:
            return ModelRole.GOVERNANCE
        elif "memory" in name_lower:
            return ModelRole.MEMORY_CURATOR
        elif "analyst" in name_lower or "analysis" in name_lower:
            return ModelRole.ANALYST
        elif "risk" in name_lower or "defense" in name_lower or "war" in name_lower:
            return ModelRole.DEFENSE_RISK
        elif "projection" in name_lower or "external" in name_lower:
            return ModelRole.PROJECTION
        elif any(x in name_lower for x in ["command", "workspace", "console"]):
            return ModelRole.OPERATIONS
        elif "architect" in name_lower or "strategic" in name_lower:
            return ModelRole.STRATEGIST
        else:
            return ModelRole.BUILDER
    
    # ------------------------------------------------------------------ #
    # Model Registration                                                    #
    # ------------------------------------------------------------------ #
    
    def register_model(
        self,
        spec: ModelSpec,
        handler: Optional[ModelHandler] = None,
    ) -> str:
        """Register a model with optional handler."""
        self._models[spec.model_id] = spec
        if handler:
            self._handlers[spec.model_id] = handler
        return spec.model_id
    
    def unregister_model(self, model_id: str) -> bool:
        """Remove a model from the registry."""
        if model_id in self._models:
            del self._models[model_id]
            if model_id in self._handlers:
                del self._handlers[model_id]
            return True
        return False
    
    def set_model_state(self, model_id: str, state: ModelState) -> bool:
        """Update model state."""
        if model_id in self._models:
            self._models[model_id].state = state
            return True
        return False
    
    def set_handler(self, model_id: str, handler: ModelHandler) -> bool:
        """Set handler for a model."""
        if model_id in self._models:
            self._handlers[model_id] = handler
            return True
        return False
    
    # ------------------------------------------------------------------ #
    # Model Selection                                                       #
    # ------------------------------------------------------------------ #
    
    def select_model(self, request: InvocationRequest) -> Optional[ModelSpec]:
        """
        Select best model for a request.
        
        Priority:
        1. Direct model_id match
        2. Role + family match
        3. Capabilities match
        4. Affinity tags
        """
        # Direct routing
        if request.model_id and request.model_id in self._models:
            model = self._models[request.model_id]
            if model.state == ModelState.AVAILABLE:
                return model
        
        candidates: List[tuple[ModelSpec, int]] = []
        
        for model in self._models.values():
            if model.state != ModelState.AVAILABLE:
                continue
            
            score = 0
            
            # Role match
            if request.role and model.role == request.role:
                score += 100
            
            # Family match
            if request.family and model.family == request.family:
                score += 50
            
            # Capability match
            if request.required_capabilities:
                matched = sum(1 for c in request.required_capabilities if c in model.capabilities)
                score += matched * 10
            
            # Affinity match
            if request.affinity_tags:
                matched = sum(1 for t in request.affinity_tags if t in model.affinity_tags)
                score += matched * 5
            
            # Priority boost
            score += model.priority
            
            candidates.append((model, score))
        
        if not candidates:
            return None
        
        # Return highest scoring model
        candidates.sort(key=lambda x: x[1], reverse=True)
        return candidates[0][0]
    
    # ------------------------------------------------------------------ #
    # Invocation                                                            #
    # ------------------------------------------------------------------ #
    
    def invoke(self, request: InvocationRequest) -> InvocationResult:
        """
        Invoke a model with the given request.
        
        Selects appropriate model and executes handler.
        """
        start_time = time.time()
        
        # Select model
        model = self.select_model(request)
        if not model:
            return InvocationResult(
                request_id=request.request_id,
                success=False,
                error="No suitable model available",
            )
        
        # Check handler
        if model.model_id not in self._handlers:
            # No handler - return mock result
            return InvocationResult(
                request_id=request.request_id,
                model_id=model.model_id,
                model_name=model.name,
                success=True,
                output=f"[{model.name}] Handler not implemented",
                latency_ms=(time.time() - start_time) * 1000,
            )
        
        handler = self._handlers[model.model_id]
        
        # Mark model busy
        model.state = ModelState.BUSY
        
        try:
            output = handler(request)
            success = True
            error = None
            model.invocation_count += 1
        except Exception as e:
            output = None
            success = False
            error = str(e)
            model.error_count += 1
        finally:
            model.state = ModelState.AVAILABLE
            model.last_invocation = time.time()
        
        latency_ms = (time.time() - start_time) * 1000
        
        result = InvocationResult(
            request_id=request.request_id,
            model_id=model.model_id,
            model_name=model.name,
            success=success,
            output=output,
            error=error,
            latency_ms=latency_ms,
        )
        
        self._invocation_log.append(result)
        return result
    
    def invoke_role(
        self,
        role: ModelRole,
        prompt: str,
        context: Optional[Dict[str, Any]] = None,
    ) -> InvocationResult:
        """Convenience: invoke by role."""
        request = InvocationRequest(
            role=role,
            prompt=prompt,
            context=context or {},
        )
        return self.invoke(request)
    
    # ------------------------------------------------------------------ #
    # Queries                                                               #
    # ------------------------------------------------------------------ #
    
    def get_model(self, model_id: str) -> Optional[ModelSpec]:
        """Get model by ID."""
        return self._models.get(model_id)
    
    def get_model_by_name(self, name: str) -> Optional[ModelSpec]:
        """Get model by name."""
        for model in self._models.values():
            if model.name == name:
                return model
        return None
    
    def list_models(
        self,
        family: Optional[ModelFamily] = None,
        role: Optional[ModelRole] = None,
        state: Optional[ModelState] = None,
    ) -> List[ModelSpec]:
        """List models with optional filters."""
        models = list(self._models.values())
        
        if family:
            models = [m for m in models if m.family == family]
        if role:
            models = [m for m in models if m.role == role]
        if state:
            models = [m for m in models if m.state == state]
        
        return models
    
    def get_invocation_log(self, limit: int = 100) -> List[InvocationResult]:
        """Get recent invocations."""
        return self._invocation_log[-limit:]
    
    # ------------------------------------------------------------------ #
    # Beat Integration                                                      #
    # ------------------------------------------------------------------ #
    
    def tick(self, beat: int) -> None:
        """Process beat for model router."""
        self._current_beat = beat
    
    # ------------------------------------------------------------------ #
    # Status                                                                #
    # ------------------------------------------------------------------ #
    
    def status(self) -> Dict[str, Any]:
        """Current router status."""
        by_family: Dict[str, int] = {}
        by_state: Dict[str, int] = {}
        
        for model in self._models.values():
            by_family[model.family.value] = by_family.get(model.family.value, 0) + 1
            by_state[model.state.value] = by_state.get(model.state.value, 0) + 1
        
        return {
            "orchestrator_id": self._id,
            "name": "ORCH-06 NEURAL_CORE_MESH_ORCHESTRATOR",
            "current_beat": self._current_beat,
            "total_models": len(self._models),
            "models_by_family": by_family,
            "models_by_state": by_state,
            "handlers_registered": len(self._handlers),
            "total_invocations": len(self._invocation_log),
        }
