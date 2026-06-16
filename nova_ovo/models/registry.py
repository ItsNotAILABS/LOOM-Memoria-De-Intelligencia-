"""
Model Registry — Multi-Model Runtime
====================================
Registry for all model families and instances.

Model naming architecture:
- R-MODEL-* runtime organism models (23 minimum)
- U-MODEL-* interface operation models (12 minimum)
- D-MODEL-* document intelligence models (D1-D10)
- N-MODEL-* sovereign macro-node models (N1-N12)
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Set


class ModelFamily(str, Enum):
    """Role-specialized model families."""
    STRATEGIST = "strategist"
    BUILDER = "builder"
    ANALYST = "analyst"
    GOVERNANCE = "governance"
    MEMORY_CURATOR = "memory_curator"
    OPERATIONS = "operations"
    DEFENSE_RISK = "defense_risk"
    PROJECTION = "projection"
    HEARTBEAT = "heartbeat"
    CARDIO_CEREBRAL = "cardio_cerebral"
    FEEDBACK = "feedback"
    EMBODIMENT = "embodiment"


class ModelPrefix(str, Enum):
    """Model naming prefixes per architecture."""
    R = "R-MODEL"      # Runtime organism models
    U = "U-MODEL"      # Interface operation models
    D = "D-MODEL"      # Document intelligence models
    N = "N-MODEL"      # Sovereign macro-node models


class ModelStatus(str, Enum):
    """Model operational status."""
    ACTIVE = "active"
    INACTIVE = "inactive"
    WARMING = "warming"
    ERROR = "error"
    MAINTENANCE = "maintenance"


@dataclass
class ModelDefinition:
    """Definition of a model in the registry."""
    
    model_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    prefix: ModelPrefix = ModelPrefix.R
    family: ModelFamily = ModelFamily.OPERATIONS
    status: ModelStatus = ModelStatus.INACTIVE
    
    # Capabilities
    capabilities: Set[str] = field(default_factory=set)
    input_types: Set[str] = field(default_factory=set)
    output_types: Set[str] = field(default_factory=set)
    
    # Configuration
    config: Dict[str, Any] = field(default_factory=dict)
    
    # Beat budget (per AURO requirements)
    beat_budget: int = 1  # How often this model runs (every N beats)
    last_beat: int = 0
    
    # Metrics
    invocation_count: int = 0
    total_latency_ms: float = 0.0
    error_count: int = 0
    
    # Timestamps
    registered_at: float = field(default_factory=time.time)
    last_invoked_at: Optional[float] = None
    
    @property
    def full_name(self) -> str:
        return f"{self.prefix.value}-{self.name}"
    
    @property
    def avg_latency_ms(self) -> float:
        if self.invocation_count == 0:
            return 0.0
        return self.total_latency_ms / self.invocation_count
    
    def should_run_at_beat(self, beat: int) -> bool:
        """Check if model should run at given beat based on budget."""
        if self.beat_budget <= 0:
            return False
        return (beat - self.last_beat) >= self.beat_budget
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "model_id": self.model_id,
            "name": self.name,
            "full_name": self.full_name,
            "prefix": self.prefix.value,
            "family": self.family.value,
            "status": self.status.value,
            "capabilities": list(self.capabilities),
            "input_types": list(self.input_types),
            "output_types": list(self.output_types),
            "beat_budget": self.beat_budget,
            "invocation_count": self.invocation_count,
            "avg_latency_ms": self.avg_latency_ms,
            "error_count": self.error_count,
            "registered_at": self.registered_at,
            "last_invoked_at": self.last_invoked_at,
        }


# Model handler type
ModelHandler = Callable[[Dict[str, Any]], Dict[str, Any]]


# Minimum R-MODEL set (23 models per spec)
R_MODEL_DEFINITIONS = [
    ("HEARTBEAT-CORE", ModelFamily.HEARTBEAT, {"beat_budget": 1}),
    ("CCVE-STATE", ModelFamily.CARDIO_CEREBRAL, {"beat_budget": 1}),
    ("CNCO-STATE", ModelFamily.OPERATIONS, {"beat_budget": 1}),
    ("GRPE-STATE", ModelFamily.OPERATIONS, {"beat_budget": 1}),
    ("AUTONOMOUS-ANALYST", ModelFamily.ANALYST, {"beat_budget": 2}),
    ("MEMORY-TEMPLE-STATE", ModelFamily.MEMORY_CURATOR, {"beat_budget": 1}),
    ("CONSTANT-FEEDBACK", ModelFamily.FEEDBACK, {"beat_budget": 1}),
    ("NEUROCHEM-CROSSTALK", ModelFamily.OPERATIONS, {"beat_budget": 2}),
    ("UNIFIED-EMOTIONAL-FIELD", ModelFamily.OPERATIONS, {"beat_budget": 2}),
    ("PARALLAX-DECISION", ModelFamily.STRATEGIST, {"beat_budget": 3}),
    ("ENTANGLA-SOCIAL-BINDING", ModelFamily.OPERATIONS, {"beat_budget": 5}),
    ("NEURAL-CORE-MESH", ModelFamily.OPERATIONS, {"beat_budget": 1}),
    ("LIVING-ARCHITECTURE-MACRO", ModelFamily.BUILDER, {"beat_budget": 5}),
    ("SWARM-COHERENCE", ModelFamily.OPERATIONS, {"beat_budget": 2}),
    ("DRIFT-JASMINE", ModelFamily.OPERATIONS, {"beat_budget": 10}),
    ("QUANTUM-CHANNEL-FABRIC", ModelFamily.OPERATIONS, {"beat_budget": 1}),
    ("AUDIT-REPLAY", ModelFamily.GOVERNANCE, {"beat_budget": 5}),
    ("GOVERNANCE-HEARTBEAT", ModelFamily.GOVERNANCE, {"beat_budget": 1}),
    ("STABILITY-BUDGET", ModelFamily.DEFENSE_RISK, {"beat_budget": 2}),
    ("RISK-MANAGEMENT", ModelFamily.DEFENSE_RISK, {"beat_budget": 2}),
    ("WAR-DEFENSE", ModelFamily.DEFENSE_RISK, {"beat_budget": 1}),
    ("WORLD-ORGANISM-BRIDGE", ModelFamily.PROJECTION, {"beat_budget": 5}),
    ("SACRED-MATHEMATICS", ModelFamily.ANALYST, {"beat_budget": 10}),
]

# Minimum U-MODEL set (12 models per spec)
U_MODEL_DEFINITIONS = [
    ("MEDINA-COMMAND-CENTER", ModelFamily.OPERATIONS, {}),
    ("MEMORY-TEMPLE-LAB", ModelFamily.MEMORY_CURATOR, {}),
    ("MEMORY-NAVIGATION", ModelFamily.MEMORY_CURATOR, {}),
    ("CONSTANT-FEEDBACK-LAB", ModelFamily.FEEDBACK, {}),
    ("INTERNAL-ANALYSIS-LAB", ModelFamily.ANALYST, {}),
    ("GRPE-LAB", ModelFamily.OPERATIONS, {}),
    ("EMERGENCE-LAB", ModelFamily.STRATEGIST, {}),
    ("MATH-PHYSICS-LAB", ModelFamily.ANALYST, {}),
    ("NEUROCOG-LAB", ModelFamily.ANALYST, {}),
    ("AGENT-WORKSPACE", ModelFamily.BUILDER, {}),
    ("COMPANION-CONSOLE", ModelFamily.OPERATIONS, {}),
    ("DRONE-SIM-WORLD", ModelFamily.EMBODIMENT, {}),
]

# D-MODEL document workforce (D1-D10)
D_MODEL_DEFINITIONS = [
    (f"D{i}", ModelFamily.BUILDER, {"doc_index": i})
    for i in range(1, 11)
]

# N-MODEL sovereign macro nodes (N1-N12)
N_MODEL_DEFINITIONS = [
    (f"N{i}", ModelFamily.GOVERNANCE, {"node_index": i, "sovereignty_level": i})
    for i in range(1, 13)
]


class ModelRegistry:
    """
    Registry for all models in the multi-model runtime.
    
    Manages:
    - Model registration and discovery
    - Status tracking
    - Handler binding
    - Metrics collection
    """
    
    def __init__(self, auto_register_defaults: bool = True) -> None:
        self._models: Dict[str, ModelDefinition] = {}
        self._handlers: Dict[str, ModelHandler] = {}
        self._name_index: Dict[str, str] = {}  # full_name -> model_id
        
        if auto_register_defaults:
            self._register_default_models()
    
    def _register_default_models(self) -> None:
        """Register all default model definitions."""
        # R-MODELs
        for name, family, config in R_MODEL_DEFINITIONS:
            self.register(
                name=name,
                prefix=ModelPrefix.R,
                family=family,
                config=config,
            )
        
        # U-MODELs
        for name, family, config in U_MODEL_DEFINITIONS:
            self.register(
                name=name,
                prefix=ModelPrefix.U,
                family=family,
                config=config,
            )
        
        # D-MODELs
        for name, family, config in D_MODEL_DEFINITIONS:
            self.register(
                name=name,
                prefix=ModelPrefix.D,
                family=family,
                config=config,
            )
        
        # N-MODELs
        for name, family, config in N_MODEL_DEFINITIONS:
            self.register(
                name=name,
                prefix=ModelPrefix.N,
                family=family,
                config=config,
            )
    
    def register(
        self,
        name: str,
        prefix: ModelPrefix = ModelPrefix.R,
        family: ModelFamily = ModelFamily.OPERATIONS,
        capabilities: Optional[Set[str]] = None,
        config: Optional[Dict[str, Any]] = None,
        handler: Optional[ModelHandler] = None,
    ) -> ModelDefinition:
        """Register a new model."""
        model = ModelDefinition(
            name=name,
            prefix=prefix,
            family=family,
            capabilities=capabilities or set(),
            config=config or {},
            status=ModelStatus.ACTIVE if handler else ModelStatus.INACTIVE,
        )
        
        # Apply config overrides
        if config:
            if "beat_budget" in config:
                model.beat_budget = config["beat_budget"]
        
        self._models[model.model_id] = model
        self._name_index[model.full_name] = model.model_id
        
        if handler:
            self._handlers[model.model_id] = handler
        
        return model
    
    def unregister(self, model_id: str) -> bool:
        """Unregister a model."""
        model = self._models.pop(model_id, None)
        if model:
            self._name_index.pop(model.full_name, None)
            self._handlers.pop(model_id, None)
            return True
        return False
    
    def get(self, identifier: str) -> Optional[ModelDefinition]:
        """Get model by ID or full name."""
        if identifier in self._models:
            return self._models[identifier]
        if identifier in self._name_index:
            return self._models.get(self._name_index[identifier])
        # Try partial match
        for full_name, model_id in self._name_index.items():
            if identifier in full_name:
                return self._models.get(model_id)
        return None
    
    def bind_handler(self, model_id: str, handler: ModelHandler) -> bool:
        """Bind a handler to a model."""
        model = self.get(model_id)
        if model is None:
            return False
        
        self._handlers[model.model_id] = handler
        model.status = ModelStatus.ACTIVE
        return True
    
    def invoke(
        self,
        identifier: str,
        input_data: Dict[str, Any],
        beat: int = 0,
    ) -> Dict[str, Any]:
        """Invoke a model."""
        model = self.get(identifier)
        if model is None:
            return {"error": f"Model not found: {identifier}"}
        
        if model.status != ModelStatus.ACTIVE:
            return {"error": f"Model not active: {model.status.value}"}
        
        handler = self._handlers.get(model.model_id)
        if handler is None:
            # Default handler
            return {
                "status": "invoked",
                "model": model.full_name,
                "input": input_data,
            }
        
        start_time = time.time()
        try:
            result = handler(input_data)
            latency = (time.time() - start_time) * 1000
            
            model.invocation_count += 1
            model.total_latency_ms += latency
            model.last_invoked_at = time.time()
            model.last_beat = beat
            
            return result
        except Exception as e:
            model.error_count += 1
            return {"error": str(e)}
    
    def list_models(
        self,
        prefix: Optional[ModelPrefix] = None,
        family: Optional[ModelFamily] = None,
        status: Optional[ModelStatus] = None,
    ) -> List[ModelDefinition]:
        """List models with optional filters."""
        models = list(self._models.values())
        
        if prefix is not None:
            models = [m for m in models if m.prefix == prefix]
        
        if family is not None:
            models = [m for m in models if m.family == family]
        
        if status is not None:
            models = [m for m in models if m.status == status]
        
        return models
    
    def get_models_for_beat(self, beat: int) -> List[ModelDefinition]:
        """Get models that should run at a given beat."""
        return [
            m for m in self._models.values()
            if m.status == ModelStatus.ACTIVE and m.should_run_at_beat(beat)
        ]
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get registry statistics."""
        models = list(self._models.values())
        
        by_prefix: Dict[str, int] = {}
        by_family: Dict[str, int] = {}
        by_status: Dict[str, int] = {}
        
        for m in models:
            by_prefix[m.prefix.value] = by_prefix.get(m.prefix.value, 0) + 1
            by_family[m.family.value] = by_family.get(m.family.value, 0) + 1
            by_status[m.status.value] = by_status.get(m.status.value, 0) + 1
        
        total_invocations = sum(m.invocation_count for m in models)
        total_errors = sum(m.error_count for m in models)
        
        return {
            "total_models": len(models),
            "by_prefix": by_prefix,
            "by_family": by_family,
            "by_status": by_status,
            "total_invocations": total_invocations,
            "total_errors": total_errors,
            "handlers_bound": len(self._handlers),
        }
