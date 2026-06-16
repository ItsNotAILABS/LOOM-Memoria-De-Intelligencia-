"""
Model Router — Multi-Model Runtime
==================================
Auto-routes queries to best model based on:
- Mastery routing: winner = argmax_m(w_m * coherence_m * doctrineFit_m)
- Family specialization
- Capability matching
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional, Tuple, TYPE_CHECKING

from .registry import ModelDefinition, ModelFamily, ModelPrefix, ModelRegistry, ModelStatus

if TYPE_CHECKING:
    pass


@dataclass
class RoutingDecision:
    """Record of a routing decision."""
    
    decision_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    query: str = ""
    selected_model_id: str = ""
    selected_model_name: str = ""
    family: str = ""
    score: float = 0.0
    candidates: List[Dict[str, Any]] = field(default_factory=list)
    routing_factors: Dict[str, float] = field(default_factory=dict)
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "decision_id": self.decision_id,
            "query": self.query,
            "selected_model_id": self.selected_model_id,
            "selected_model_name": self.selected_model_name,
            "family": self.family,
            "score": self.score,
            "candidates_count": len(self.candidates),
            "routing_factors": self.routing_factors,
            "timestamp": self.timestamp,
        }


# Keyword -> Family mapping for semantic routing
FAMILY_KEYWORDS: Dict[ModelFamily, List[str]] = {
    ModelFamily.STRATEGIST: ["strategy", "plan", "decision", "future", "direction", "vision"],
    ModelFamily.BUILDER: ["build", "create", "implement", "code", "develop", "construct"],
    ModelFamily.ANALYST: ["analyze", "report", "data", "insight", "measure", "evaluate"],
    ModelFamily.GOVERNANCE: ["govern", "approve", "policy", "audit", "compliance", "rule"],
    ModelFamily.MEMORY_CURATOR: ["memory", "recall", "remember", "forget", "store", "retrieve"],
    ModelFamily.OPERATIONS: ["operate", "run", "execute", "process", "manage", "coordinate"],
    ModelFamily.DEFENSE_RISK: ["risk", "defense", "security", "threat", "protect", "guard"],
    ModelFamily.PROJECTION: ["project", "external", "output", "share", "publish", "expose"],
    ModelFamily.HEARTBEAT: ["heartbeat", "pulse", "rhythm", "beat", "alive"],
    ModelFamily.CARDIO_CEREBRAL: ["heart", "brain", "coupling", "resonance", "vector"],
    ModelFamily.FEEDBACK: ["feedback", "loop", "response", "adjust", "tune"],
    ModelFamily.EMBODIMENT: ["body", "drone", "physical", "world", "action"],
}


class ModelRouter:
    """
    Routes queries to appropriate models.
    
    Uses mastery routing formula:
    winner = argmax_m(w_m * coherence_m * doctrineFit_m)
    
    Where:
    - w_m = weight/priority of model
    - coherence_m = how well model aligns with query
    - doctrineFit_m = doctrine alignment score
    """
    
    def __init__(self, registry: Optional[ModelRegistry] = None) -> None:
        self._registry = registry or ModelRegistry()
        self._decisions: List[RoutingDecision] = []
        self._model_weights: Dict[str, float] = {}  # model_id -> weight
        self._default_weight = 1.0
        self._doctrine_floor = 0.5  # Minimum doctrine fit required
    
    def bind_registry(self, registry: ModelRegistry) -> None:
        """Bind to a model registry."""
        self._registry = registry
    
    def set_model_weight(self, model_id: str, weight: float) -> None:
        """Set routing weight for a model."""
        self._model_weights[model_id] = max(0.0, weight)
    
    def route(
        self,
        query: str,
        preferred_family: Optional[ModelFamily] = None,
        preferred_prefix: Optional[ModelPrefix] = None,
        required_capabilities: Optional[List[str]] = None,
        doctrine_fit: float = 1.0,
    ) -> RoutingDecision:
        """
        Route query to best model.
        
        Returns routing decision with selected model and scoring details.
        """
        candidates = self._get_candidates(
            preferred_family=preferred_family,
            preferred_prefix=preferred_prefix,
            required_capabilities=required_capabilities,
        )
        
        if not candidates:
            # Fallback to any active model
            candidates = [m for m in self._registry.list_models() 
                         if m.status == ModelStatus.ACTIVE]
        
        # Score candidates
        scored: List[Tuple[float, ModelDefinition, Dict[str, float]]] = []
        
        for model in candidates:
            score, factors = self._score_model(
                model=model,
                query=query,
                doctrine_fit=doctrine_fit,
            )
            scored.append((score, model, factors))
        
        # Sort by score descending
        scored.sort(key=lambda x: x[0], reverse=True)
        
        # Select winner
        if scored:
            best_score, best_model, best_factors = scored[0]
            
            decision = RoutingDecision(
                query=query,
                selected_model_id=best_model.model_id,
                selected_model_name=best_model.full_name,
                family=best_model.family.value,
                score=best_score,
                candidates=[
                    {"model": m.full_name, "score": s}
                    for s, m, _ in scored[:5]
                ],
                routing_factors=best_factors,
            )
        else:
            decision = RoutingDecision(
                query=query,
                selected_model_id="",
                selected_model_name="",
                family="",
                score=0.0,
                routing_factors={"error": 1.0},
            )
        
        self._decisions.append(decision)
        return decision
    
    def _get_candidates(
        self,
        preferred_family: Optional[ModelFamily] = None,
        preferred_prefix: Optional[ModelPrefix] = None,
        required_capabilities: Optional[List[str]] = None,
    ) -> List[ModelDefinition]:
        """Get candidate models for routing."""
        models = self._registry.list_models(status=ModelStatus.ACTIVE)
        
        if preferred_family is not None:
            family_models = [m for m in models if m.family == preferred_family]
            if family_models:
                models = family_models
        
        if preferred_prefix is not None:
            prefix_models = [m for m in models if m.prefix == preferred_prefix]
            if prefix_models:
                models = prefix_models
        
        if required_capabilities:
            cap_models = [
                m for m in models
                if all(c in m.capabilities for c in required_capabilities)
            ]
            if cap_models:
                models = cap_models
        
        return models
    
    def _score_model(
        self,
        model: ModelDefinition,
        query: str,
        doctrine_fit: float,
    ) -> Tuple[float, Dict[str, float]]:
        """
        Score a model for the query.
        
        Formula: score = w_m * coherence_m * doctrineFit_m
        """
        # Get model weight
        w_m = self._model_weights.get(model.model_id, self._default_weight)
        
        # Calculate coherence (keyword matching)
        coherence_m = self._calculate_coherence(model, query)
        
        # Doctrine fit (passed in, floor enforced)
        doctrineFit_m = max(doctrine_fit, self._doctrine_floor)
        
        # Performance factor (favor models with good track record)
        perf_factor = 1.0
        if model.invocation_count > 0:
            error_rate = model.error_count / model.invocation_count
            perf_factor = 1.0 - (error_rate * 0.5)
        
        # Calculate final score
        score = w_m * coherence_m * doctrineFit_m * perf_factor
        
        factors = {
            "weight": w_m,
            "coherence": coherence_m,
            "doctrine_fit": doctrineFit_m,
            "performance": perf_factor,
        }
        
        return score, factors
    
    def _calculate_coherence(self, model: ModelDefinition, query: str) -> float:
        """Calculate coherence score based on keyword matching."""
        query_lower = query.lower()
        
        # Check family keywords
        family_keywords = FAMILY_KEYWORDS.get(model.family, [])
        keyword_matches = sum(1 for kw in family_keywords if kw in query_lower)
        
        if family_keywords:
            coherence = min(1.0, keyword_matches / len(family_keywords) * 2)
        else:
            coherence = 0.5  # Neutral if no keywords defined
        
        # Bonus for model name match
        if model.name.lower() in query_lower:
            coherence = min(1.0, coherence + 0.3)
        
        return max(0.1, coherence)  # Minimum 0.1
    
    def route_and_invoke(
        self,
        query: str,
        input_data: Dict[str, Any],
        beat: int = 0,
        **routing_kwargs: Any,
    ) -> Tuple[RoutingDecision, Dict[str, Any]]:
        """Route query and invoke selected model."""
        decision = self.route(query, **routing_kwargs)
        
        if not decision.selected_model_id:
            return decision, {"error": "No model selected"}
        
        result = self._registry.invoke(
            decision.selected_model_id,
            input_data,
            beat=beat,
        )
        
        return decision, result
    
    def get_family_for_query(self, query: str) -> Optional[ModelFamily]:
        """Determine best family for a query."""
        query_lower = query.lower()
        
        best_family: Optional[ModelFamily] = None
        best_matches = 0
        
        for family, keywords in FAMILY_KEYWORDS.items():
            matches = sum(1 for kw in keywords if kw in query_lower)
            if matches > best_matches:
                best_matches = matches
                best_family = family
        
        return best_family
    
    def get_routing_history(self, limit: int = 100) -> List[RoutingDecision]:
        """Get recent routing decisions."""
        return self._decisions[-limit:]
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get routing statistics."""
        if not self._decisions:
            return {"total_decisions": 0}
        
        by_family: Dict[str, int] = {}
        total_score = 0.0
        
        for d in self._decisions:
            by_family[d.family] = by_family.get(d.family, 0) + 1
            total_score += d.score
        
        return {
            "total_decisions": len(self._decisions),
            "by_family": by_family,
            "avg_score": total_score / len(self._decisions),
        }
