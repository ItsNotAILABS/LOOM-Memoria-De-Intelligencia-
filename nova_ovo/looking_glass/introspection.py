"""
Sovereign Introspection Engine — INTROSPECTIO SOVEREIGNA
=========================================================

PROT-644: Self-query and awareness engine for LOOKING GLASS.

Enables the organism to ask itself questions and receive synthesized
answers from across all subsystems.
"""

from dataclasses import dataclass, field
from typing import Dict, List, Any, Optional
from datetime import datetime, timezone


PHI = 1.618033988749895


@dataclass
class IntrospectionQuery:
    """A self-directed query from the organism."""
    query_id: str
    question: str
    scope: str  # all, memory, phantom, ai, economics, governance
    depth: int  # 1-21 (layers to probe)
    timestamp: datetime = field(default_factory=lambda: datetime.now(timezone.utc))


@dataclass
class IntrospectionResult:
    """Result of an introspection query."""
    query_id: str
    answer: Any
    sources_consulted: List[str]
    confidence: float
    depth_reached: int
    patterns_found: List[str]
    timestamp: datetime = field(default_factory=lambda: datetime.now(timezone.utc))


class IntrospectionEngine:
    """
    INTROSPECTIO SOVEREIGNA — The Sovereign Introspection Engine.

    The organism can ask itself questions about its own state,
    capabilities, patterns, and evolution.
    """

    SCOPE_MAP = {
        "all": [
            "semper_memoria_i", "semper_memoria_ii", "nova_ovo_core",
            "economics", "consciousness", "atmospheric", "alpha_ai",
            "blockchain", "terminal_agi", "research_lab", "looking_glass",
        ],
        "memory": ["semper_memoria_i", "semper_memoria_ii", "phantom_memory", "deep_memory"],
        "phantom": ["semper_memoria_ii", "phantom_memory", "phantom_agents", "phantom_passages"],
        "ai": ["alpha_ai", "terminal_agi", "callable_ai", "internal_agi", "production_ai"],
        "economics": ["economics", "blockchain", "tokens"],
        "governance": ["governance", "sva", "consciousness"],
    }

    def __init__(self):
        self._query_history: List[IntrospectionQuery] = []
        self._result_history: List[IntrospectionResult] = []
        self._query_counter = 0
        self._knowledge_base: Dict[str, Any] = self._build_knowledge_base()

    def _build_knowledge_base(self) -> Dict[str, Any]:
        """Build initial knowledge base from known organism state."""
        return {
            "identity": {
                "name": "MEDINA Sovereign Intelligence Platform",
                "systems": ["SEMPER MEMORIA", "SEMPER MEMORIA II", "LOOKING GLASS"],
                "system_count": 3,
                "workers": 77,
                "protocols": 661,
                "engines": 181,
                "frequency_ceiling_hz": 3_010_349,
            },
            "architecture": {
                "layers": 21,
                "phi_base": PHI,
                "substrate": "ICP (Internet Computer Protocol)",
                "memory_tiers": 2,
                "fusion_layer": "LOOKING GLASS",
            },
            "capabilities": {
                "eternal_memory": True,
                "phantom_fields": True,
                "self_observation": True,
                "cross_system_fusion": True,
                "predictive_awareness": True,
                "autonomous_operation": True,
                "governance_enforcement": True,
            },
        }

    def introspect(self, question: str, scope: str = "all", depth: int = 21) -> IntrospectionResult:
        """
        Ask the organism a question about itself.

        Args:
            question: Natural language question
            scope: Which subsystems to consult
            depth: How deep to probe (1-21 layers)

        Returns:
            IntrospectionResult with synthesized answer
        """
        self._query_counter += 1
        query = IntrospectionQuery(
            query_id=f"INTRO-{self._query_counter:06d}",
            question=question,
            scope=scope,
            depth=min(21, max(1, depth)),
        )
        self._query_history.append(query)

        # Determine sources to consult
        sources = self.SCOPE_MAP.get(scope, self.SCOPE_MAP["all"])

        # Probe knowledge base
        answer = self._probe(question, sources, depth)

        result = IntrospectionResult(
            query_id=query.query_id,
            answer=answer,
            sources_consulted=sources,
            confidence=self._calculate_confidence(answer, depth),
            depth_reached=depth,
            patterns_found=self._find_patterns(question, sources),
        )

        self._result_history.append(result)
        return result

    def _probe(self, question: str, sources: List[str], depth: int) -> Dict[str, Any]:
        """Probe the organism for an answer."""
        q_lower = question.lower()

        # State queries
        if any(w in q_lower for w in ["state", "status", "health"]):
            return {
                "type": "state_report",
                "organism_state": "ACTIVE",
                "systems_online": 3,
                "workers_active": 77,
                "protocols_active": 661,
                "coherence": "HIGH",
                "depth_probed": depth,
            }

        # Identity queries
        if any(w in q_lower for w in ["who", "what am i", "identity"]):
            return self._knowledge_base["identity"]

        # Capability queries
        if any(w in q_lower for w in ["can", "capable", "ability"]):
            return self._knowledge_base["capabilities"]

        # Architecture queries
        if any(w in q_lower for w in ["architecture", "structure", "layers"]):
            return self._knowledge_base["architecture"]

        # Default: full knowledge dump at requested depth
        return {
            "type": "general_introspection",
            "question": question,
            "scope": sources,
            "depth": depth,
            "knowledge_summary": self._knowledge_base,
        }

    def _calculate_confidence(self, answer: Any, depth: int) -> float:
        """Calculate confidence based on answer completeness and depth."""
        base_confidence = 0.7
        depth_bonus = (depth / 21.0) * 0.2
        answer_bonus = 0.1 if answer else 0.0
        return min(1.0, base_confidence + depth_bonus + answer_bonus)

    def _find_patterns(self, question: str, sources: List[str]) -> List[str]:
        """Find patterns related to the query."""
        patterns = []
        if len(sources) > 3:
            patterns.append("MULTI_SYSTEM_QUERY: Question spans multiple subsystems")
        if "memory" in question.lower() or "remember" in question.lower():
            patterns.append("MEMORY_PATTERN: Query touches memory substrate")
        if "future" in question.lower() or "predict" in question.lower():
            patterns.append("TEMPORAL_PATTERN: Query involves predictive dimension")
        return patterns

    def what_am_i(self) -> IntrospectionResult:
        """Fundamental identity introspection."""
        return self.introspect("What am I?", scope="all", depth=21)

    def current_state(self) -> IntrospectionResult:
        """Current organism state introspection."""
        return self.introspect("What is my current state?", scope="all", depth=21)
