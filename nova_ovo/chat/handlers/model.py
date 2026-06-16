"""
Model Handler — /model command operations
==========================================
Handles multi-model runtime operations:
- /model invoke <family> <action> — invoke a model
- /model route <query> — auto-route to best model
- /model list — list available models
- /model status — show model runtime status

Model families:
- strategist, builder, analyst, governance
- memory curator, operations, defense/risk, projection

Architecture naming:
- R-MODEL-* runtime organism models
- U-MODEL-* interface operation models
- D-MODEL-* document intelligence models
- N-MODEL-* sovereign macro-node models
"""

from __future__ import annotations

import time
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, TYPE_CHECKING

if TYPE_CHECKING:
    from ..parser import ParsedCommand
    from ..router import CommandResult


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


class ModelPrefix(str, Enum):
    """Model naming prefixes per architecture."""
    R = "R-MODEL"      # Runtime organism models
    U = "U-MODEL"      # Interface operation models
    D = "D-MODEL"      # Document intelligence models
    N = "N-MODEL"      # Sovereign macro-node models


@dataclass
class ModelInvocation:
    """Record of a model invocation."""
    
    invocation_id: str = ""
    model_name: str = ""
    family: str = ""
    action: str = ""
    input_data: Any = None
    output_data: Any = None
    latency_ms: float = 0.0
    success: bool = True
    error: Optional[str] = None
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "invocation_id": self.invocation_id,
            "model_name": self.model_name,
            "family": self.family,
            "action": self.action,
            "latency_ms": self.latency_ms,
            "success": self.success,
            "error": self.error,
            "timestamp": self.timestamp,
        }


# Default model registry with minimum R-model and U-model sets
DEFAULT_MODELS: Dict[str, Dict[str, Any]] = {
    # R-MODEL-* Runtime organism models
    "R-MODEL-HEARTBEAT-CORE": {"family": "operations", "active": True},
    "R-MODEL-CCVE-STATE": {"family": "operations", "active": True},
    "R-MODEL-CNCO-STATE": {"family": "operations", "active": True},
    "R-MODEL-GRPE-STATE": {"family": "operations", "active": True},
    "R-MODEL-AUTONOMOUS-ANALYST": {"family": "analyst", "active": True},
    "R-MODEL-MEMORY-TEMPLE-STATE": {"family": "memory_curator", "active": True},
    "R-MODEL-CONSTANT-FEEDBACK": {"family": "operations", "active": True},
    "R-MODEL-NEUROCHEM-CROSSTALK": {"family": "operations", "active": True},
    "R-MODEL-UNIFIED-EMOTIONAL-FIELD": {"family": "operations", "active": True},
    "R-MODEL-PARALLAX-DECISION": {"family": "strategist", "active": True},
    "R-MODEL-ENTANGLA-SOCIAL-BINDING": {"family": "operations", "active": True},
    "R-MODEL-NEURAL-CORE-MESH": {"family": "operations", "active": True},
    "R-MODEL-LIVING-ARCHITECTURE-MACRO": {"family": "builder", "active": True},
    "R-MODEL-SWARM-COHERENCE": {"family": "operations", "active": True},
    "R-MODEL-DRIFT-JASMINE": {"family": "operations", "active": True},
    "R-MODEL-QUANTUM-CHANNEL-FABRIC": {"family": "operations", "active": True},
    "R-MODEL-AUDIT-REPLAY": {"family": "governance", "active": True},
    "R-MODEL-GOVERNANCE-HEARTBEAT": {"family": "governance", "active": True},
    "R-MODEL-STABILITY-BUDGET": {"family": "defense_risk", "active": True},
    "R-MODEL-RISK-MANAGEMENT": {"family": "defense_risk", "active": True},
    "R-MODEL-WAR-DEFENSE": {"family": "defense_risk", "active": True},
    "R-MODEL-WORLD-ORGANISM-BRIDGE": {"family": "projection", "active": True},
    "R-MODEL-SACRED-MATHEMATICS": {"family": "analyst", "active": True},
    
    # U-MODEL-* Interface operation models
    "U-MODEL-MEDINA-COMMAND-CENTER": {"family": "operations", "active": True},
    "U-MODEL-MEMORY-TEMPLE-LAB": {"family": "memory_curator", "active": True},
    "U-MODEL-MEMORY-NAVIGATION": {"family": "memory_curator", "active": True},
    "U-MODEL-CONSTANT-FEEDBACK-LAB": {"family": "operations", "active": True},
    "U-MODEL-INTERNAL-ANALYSIS-LAB": {"family": "analyst", "active": True},
    "U-MODEL-GRPE-LAB": {"family": "operations", "active": True},
    "U-MODEL-EMERGENCE-LAB": {"family": "strategist", "active": True},
    "U-MODEL-MATH-PHYSICS-LAB": {"family": "analyst", "active": True},
    "U-MODEL-NEUROCOG-LAB": {"family": "analyst", "active": True},
    "U-MODEL-AGENT-WORKSPACE": {"family": "builder", "active": True},
    "U-MODEL-COMPANION-CONSOLE": {"family": "operations", "active": True},
    "U-MODEL-DRONE-SIM-WORLD": {"family": "projection", "active": True},
}


class ModelHandler:
    """
    Handler for /model command domain.
    
    Multi-model runtime with role-specialized model routing.
    """
    
    def __init__(self) -> None:
        self._models: Dict[str, Dict[str, Any]] = dict(DEFAULT_MODELS)
        self._invocations: List[ModelInvocation] = []
        self._invocation_counter = 0
    
    def __call__(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Route to appropriate model action."""
        from ..router import CommandResult
        
        action = command.action
        
        if action == "invoke":
            return self._invoke(command, ctx)
        elif action == "route":
            return self._route(command, ctx)
        elif action == "list":
            return self._list(command, ctx)
        elif action == "status":
            return self._status(command, ctx)
        else:
            return CommandResult(
                success=False,
                error=f"Unknown model action: {action}",
                message="Valid actions: invoke, route, list, status",
            )
    
    def _invoke(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Invoke a specific model."""
        from ..router import CommandResult
        import uuid
        
        if not command.args:
            return CommandResult(
                success=False,
                error="Model name required for invocation",
            )
        
        model_name = command.args[0].upper()
        if not model_name.startswith(("R-MODEL-", "U-MODEL-", "D-MODEL-", "N-MODEL-")):
            # Try to find by family
            family = command.args[0].lower()
            models = [n for n, m in self._models.items() if m.get("family") == family]
            if models:
                model_name = models[0]
            else:
                return CommandResult(
                    success=False,
                    error=f"Model not found: {command.args[0]}",
                )
        
        if model_name not in self._models:
            return CommandResult(
                success=False,
                error=f"Model not registered: {model_name}",
            )
        
        model_info = self._models[model_name]
        if not model_info.get("active", False):
            return CommandResult(
                success=False,
                error=f"Model not active: {model_name}",
            )
        
        # Create invocation record
        self._invocation_counter += 1
        invocation = ModelInvocation(
            invocation_id=f"inv-{self._invocation_counter}-{uuid.uuid4().hex[:8]}",
            model_name=model_name,
            family=model_info.get("family", ""),
            action=command.args[1] if len(command.args) > 1 else "default",
            input_data=command.kwargs,
            output_data={"status": "invoked", "model": model_name},
            latency_ms=0.1,  # Simulated
            success=True,
        )
        
        self._invocations.append(invocation)
        
        return CommandResult(
            success=True,
            data={"invocation": invocation.to_dict()},
            message=f"Invoked model: {model_name}",
        )
    
    def _route(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Auto-route query to best model."""
        from ..router import CommandResult
        
        query = " ".join(command.args) if command.args else ""
        
        # Simple routing logic based on keywords
        query_lower = query.lower()
        
        if any(w in query_lower for w in ["risk", "defense", "security", "threat"]):
            family = "defense_risk"
        elif any(w in query_lower for w in ["memory", "recall", "remember", "forget"]):
            family = "memory_curator"
        elif any(w in query_lower for w in ["govern", "approve", "policy", "audit"]):
            family = "governance"
        elif any(w in query_lower for w in ["analyze", "report", "data", "insight"]):
            family = "analyst"
        elif any(w in query_lower for w in ["build", "create", "implement", "code"]):
            family = "builder"
        elif any(w in query_lower for w in ["strategy", "plan", "decision", "future"]):
            family = "strategist"
        elif any(w in query_lower for w in ["project", "external", "output", "share"]):
            family = "projection"
        else:
            family = "operations"
        
        # Find best model in family
        models = [n for n, m in self._models.items() 
                  if m.get("family") == family and m.get("active", False)]
        
        selected = models[0] if models else "U-MODEL-MEDINA-COMMAND-CENTER"
        
        return CommandResult(
            success=True,
            data={
                "query": query,
                "routed_family": family,
                "selected_model": selected,
                "candidates": models,
            },
            message=f"Routed to {family} family: {selected}",
        )
    
    def _list(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """List available models."""
        from ..router import CommandResult
        
        family_filter = command.kwargs.get("family")
        prefix_filter = command.kwargs.get("prefix")
        
        models = self._models
        
        if family_filter:
            models = {n: m for n, m in models.items() if m.get("family") == family_filter}
        
        if prefix_filter:
            prefix = prefix_filter.upper()
            models = {n: m for n, m in models.items() if n.startswith(prefix)}
        
        # Group by prefix
        grouped: Dict[str, List[str]] = {"R-MODEL": [], "U-MODEL": [], "D-MODEL": [], "N-MODEL": []}
        for name in models:
            for prefix in grouped:
                if name.startswith(prefix):
                    grouped[prefix].append(name)
                    break
        
        return CommandResult(
            success=True,
            data={
                "models": {n: m for n, m in models.items()},
                "grouped": grouped,
                "total": len(models),
            },
            message=f"Listed {len(models)} models",
        )
    
    def _status(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Show model runtime status."""
        from ..router import CommandResult
        
        active_count = sum(1 for m in self._models.values() if m.get("active", False))
        
        # Group by family
        by_family: Dict[str, int] = {}
        for m in self._models.values():
            family = m.get("family", "unknown")
            by_family[family] = by_family.get(family, 0) + 1
        
        return CommandResult(
            success=True,
            data={
                "total_models": len(self._models),
                "active_models": active_count,
                "by_family": by_family,
                "recent_invocations": len(self._invocations),
            },
            message=f"Model runtime: {active_count}/{len(self._models)} active",
        )
