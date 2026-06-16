"""
Multi-Engine — Routing Engine (PROT-604)
Intelligent request routing, load balancing, and circuit breaking.
"""

from __future__ import annotations
from typing import Any, Dict, List, Optional, Callable
from dataclasses import dataclass, field
from enum import Enum
from datetime import datetime
import hashlib

PHI: float = 1.6180339887498948482


class LoadBalanceStrategy(Enum):
    ROUND_ROBIN = "round_robin"
    LEAST_CONNECTIONS = "least_connections"
    WEIGHTED = "weighted"
    RANDOM = "random"
    PHI_HARMONIC = "phi_harmonic"
    LATENCY_BASED = "latency_based"


class CircuitState(Enum):
    CLOSED = "closed"      # Normal operation
    OPEN = "open"          # Failing, reject requests
    HALF_OPEN = "half_open"  # Testing recovery


@dataclass
class RouteTarget:
    """A target endpoint for routing."""
    id: str
    name: str
    endpoint: str
    weight: float = 1.0
    healthy: bool = True
    connections: int = 0
    avg_latency_ms: float = 0.0
    error_rate: float = 0.0
    circuit_state: CircuitState = CircuitState.CLOSED
    consecutive_failures: int = 0
    last_success: Optional[str] = None


@dataclass
class RouteRule:
    """A routing rule definition."""
    id: str
    pattern: str
    targets: List[str]
    strategy: LoadBalanceStrategy = LoadBalanceStrategy.PHI_HARMONIC
    timeout_ms: int = 30000
    retry_count: int = 3
    circuit_threshold: int = 5  # failures before opening circuit
    metadata: Dict[str, Any] = field(default_factory=dict)


@dataclass
class RouteDecision:
    """The result of a routing decision."""
    rule_id: str
    target_id: str
    target_endpoint: str
    strategy_used: str
    fallback: bool = False
    reason: str = ""


class RoutingEngine:
    """
    Intelligent Routing Engine — PROT-604
    Routes requests with load balancing, circuit breaking, and health-aware selection.
    """

    def __init__(self):
        self.targets: Dict[str, RouteTarget] = {}
        self.rules: Dict[str, RouteRule] = {}
        self.round_robin_counters: Dict[str, int] = {}
        self.decisions_log: List[RouteDecision] = []
        self._init_default_targets()

    def _init_default_targets(self):
        """Initialize default routing targets."""
        default_targets = [
            RouteTarget("inference-primary", "Primary Inference", "engine://inference/primary", weight=PHI),
            RouteTarget("inference-secondary", "Secondary Inference", "engine://inference/secondary", weight=1.0),
            RouteTarget("memory-primary", "Primary Memory", "engine://memory/primary", weight=PHI),
            RouteTarget("memory-replica", "Memory Replica", "engine://memory/replica", weight=1.0),
            RouteTarget("search-primary", "Primary Search", "engine://search/primary", weight=PHI),
            RouteTarget("search-replica", "Search Replica", "engine://search/replica", weight=1.0),
            RouteTarget("cache-hot", "Hot Cache", "engine://cache/hot", weight=PHI ** 2),
            RouteTarget("cache-warm", "Warm Cache", "engine://cache/warm", weight=PHI),
            RouteTarget("cache-cold", "Cold Cache", "engine://cache/cold", weight=1.0),
            RouteTarget("governance", "Governance Engine", "engine://governance/primary", weight=PHI ** 2),
        ]
        for target in default_targets:
            self.targets[target.id] = target

        # Default rules
        self.rules = {
            "inference": RouteRule("inference", "inference.*",
                                  ["inference-primary", "inference-secondary"],
                                  LoadBalanceStrategy.LATENCY_BASED),
            "memory": RouteRule("memory", "memory.*",
                               ["memory-primary", "memory-replica"],
                               LoadBalanceStrategy.LEAST_CONNECTIONS),
            "search": RouteRule("search", "search.*",
                               ["search-primary", "search-replica"],
                               LoadBalanceStrategy.PHI_HARMONIC),
            "cache": RouteRule("cache", "cache.*",
                              ["cache-hot", "cache-warm", "cache-cold"],
                              LoadBalanceStrategy.WEIGHTED),
        }

    def route(self, pattern: str) -> RouteDecision:
        """Route a request to the best target."""
        rule = self._match_rule(pattern)
        if not rule:
            return RouteDecision(
                rule_id="none", target_id="none",
                target_endpoint="", strategy_used="none",
                reason="No matching rule found",
            )

        # Get healthy targets
        available = [
            self.targets[tid] for tid in rule.targets
            if tid in self.targets and self.targets[tid].healthy
            and self.targets[tid].circuit_state != CircuitState.OPEN
        ]

        if not available:
            # Try half-open circuits
            available = [
                self.targets[tid] for tid in rule.targets
                if tid in self.targets and self.targets[tid].circuit_state == CircuitState.HALF_OPEN
            ]

        if not available:
            return RouteDecision(
                rule_id=rule.id, target_id="none",
                target_endpoint="", strategy_used=rule.strategy.value,
                reason="All targets unavailable",
            )

        # Select target based on strategy
        target = self._select_target(available, rule)

        decision = RouteDecision(
            rule_id=rule.id,
            target_id=target.id,
            target_endpoint=target.endpoint,
            strategy_used=rule.strategy.value,
            reason=f"Selected by {rule.strategy.value}",
        )
        self.decisions_log.append(decision)
        target.connections += 1

        return decision

    def _match_rule(self, pattern: str) -> Optional[RouteRule]:
        """Match a pattern to a routing rule."""
        for rule in self.rules.values():
            rule_prefix = rule.pattern.replace("*", "")
            if pattern.startswith(rule_prefix):
                return rule
        return None

    def _select_target(self, targets: List[RouteTarget], rule: RouteRule) -> RouteTarget:
        """Select a target using the configured strategy."""
        if rule.strategy == LoadBalanceStrategy.ROUND_ROBIN:
            counter = self.round_robin_counters.get(rule.id, 0)
            target = targets[counter % len(targets)]
            self.round_robin_counters[rule.id] = counter + 1
            return target

        elif rule.strategy == LoadBalanceStrategy.LEAST_CONNECTIONS:
            return min(targets, key=lambda t: t.connections)

        elif rule.strategy == LoadBalanceStrategy.WEIGHTED:
            # Weighted selection (highest weight)
            return max(targets, key=lambda t: t.weight)

        elif rule.strategy == LoadBalanceStrategy.LATENCY_BASED:
            return min(targets, key=lambda t: t.avg_latency_ms if t.avg_latency_ms > 0 else float('inf'))

        elif rule.strategy == LoadBalanceStrategy.PHI_HARMONIC:
            # Phi-harmonic: score = weight * phi^(-error_rate * 10) / (connections + 1)
            def phi_score(t: RouteTarget) -> float:
                return t.weight * (PHI ** (-t.error_rate * 10)) / (t.connections + 1)
            return max(targets, key=phi_score)

        # Default: first available
        return targets[0]

    def report_success(self, target_id: str, latency_ms: float) -> None:
        """Report a successful request to a target."""
        target = self.targets.get(target_id)
        if target:
            target.consecutive_failures = 0
            target.last_success = datetime.utcnow().isoformat()
            target.avg_latency_ms = (target.avg_latency_ms * 0.9) + (latency_ms * 0.1)
            target.connections = max(0, target.connections - 1)
            if target.circuit_state == CircuitState.HALF_OPEN:
                target.circuit_state = CircuitState.CLOSED

    def report_failure(self, target_id: str) -> None:
        """Report a failed request to a target."""
        target = self.targets.get(target_id)
        if target:
            target.consecutive_failures += 1
            target.error_rate = min(1.0, target.error_rate + 0.1)
            target.connections = max(0, target.connections - 1)

            # Check circuit breaker threshold
            rule = None
            for r in self.rules.values():
                if target_id in r.targets:
                    rule = r
                    break
            threshold = rule.circuit_threshold if rule else 5
            if target.consecutive_failures >= threshold:
                target.circuit_state = CircuitState.OPEN

    def status(self) -> Dict[str, Any]:
        return {
            "protocol": "PROT-604",
            "targets_registered": len(self.targets),
            "targets_healthy": len([t for t in self.targets.values() if t.healthy and t.circuit_state == CircuitState.CLOSED]),
            "rules_configured": len(self.rules),
            "total_decisions": len(self.decisions_log),
            "strategies": [s.value for s in LoadBalanceStrategy],
        }


# Singleton
routing_engine = RoutingEngine()

__all__ = [
    "RoutingEngine", "RouteTarget", "RouteRule", "RouteDecision",
    "LoadBalanceStrategy", "CircuitState", "routing_engine",
]
