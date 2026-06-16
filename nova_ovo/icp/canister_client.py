"""
ICP Canister Client — Python-to-ICP Bridge for Intelligence Routing

This module provides the bridge between the Python runtime (nova_ovo)
and the ICP canister backend (medina_backend).

╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║              PYTHON-TO-ICP INTELLIGENCE ROUTING BRIDGE                    ║
║                                                                           ║
║  Every intelligence query from Python flows through this bridge:          ║
║                                                                           ║
║  1. Python creates IntelligenceQuery                                      ║
║  2. Client routes to ICP canister                                         ║
║  3. Three Hearts process the query                                        ║
║  4. Model executes on-chain                                               ║
║  5. Response returns with ANIMA hash                                      ║
║                                                                           ║
║  The Triune Principle is maintained:                                      ║
║    Backend (ICP) ⊗ Frontend (Python) ⊗ Documents (Doctrine)              ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
"""

from __future__ import annotations

import asyncio
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

# Mathematical constants (mirror ICP MatalkoICP module)
PHI: float = 1.618033988749895
PHI_INV: float = 0.618033988749895


class RouteSource(str, Enum):
    """Source of the intelligence route."""
    API = "api"
    INTERNAL = "internal"
    SCHEDULED = "scheduled"
    HEARTBEAT = "heartbeat"
    CASCADE = "cascade"


class ClusterTarget(str, Enum):
    """Target cluster for routing."""
    R_CLUSTER = "r_cluster"  # Runtime models (23)
    U_CLUSTER = "u_cluster"  # Interface models (12)
    D_CLUSTER = "d_cluster"  # Document models (10)
    N_CLUSTER = "n_cluster"  # Sovereign models (12)
    ANY = "any"              # Let router decide


class Priority(str, Enum):
    """Query priority levels."""
    CRITICAL = "critical"
    HIGH = "high"
    NORMAL = "normal"
    LOW = "low"
    BACKGROUND = "background"


@dataclass
class HeartPhases:
    """Heart phases at execution time."""
    theta_metropolis: float = 0.0
    theta_coupling: float = 0.0
    theta_regulating: float = 0.0
    global_coherence: float = 1.0


@dataclass
class IntelligenceQuery:
    """Intelligence query to be routed through ICP."""
    
    query_id: str = field(default_factory=lambda: f"query_{uuid.uuid4().hex[:12]}")
    content: str = ""
    context: str = ""
    source: RouteSource = RouteSource.INTERNAL
    cluster_target: ClusterTarget = ClusterTarget.ANY
    priority: Priority = Priority.NORMAL
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "query_id": self.query_id,
            "content": self.content,
            "context": self.context,
            "source": self.source.value,
            "cluster_target": self.cluster_target.value,
            "priority": self.priority.value,
            "timestamp": self.timestamp,
        }


@dataclass
class IntelligenceResponse:
    """Response from ICP intelligence routing."""
    
    response_id: str = ""
    query_id: str = ""
    content: str = ""
    model_id: str = ""
    coherence_at_execution: float = 1.0
    anima_hash: str = ""
    heart_phases: HeartPhases = field(default_factory=HeartPhases)
    execution_time_ns: int = 0
    success: bool = True
    timestamp: float = field(default_factory=time.time)
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> "IntelligenceResponse":
        heart_phases = HeartPhases(
            theta_metropolis=data.get("heart_phases", {}).get("theta_metropolis", 0.0),
            theta_coupling=data.get("heart_phases", {}).get("theta_coupling", 0.0),
            theta_regulating=data.get("heart_phases", {}).get("theta_regulating", 0.0),
            global_coherence=data.get("heart_phases", {}).get("global_coherence", 1.0),
        )
        return cls(
            response_id=data.get("response_id", ""),
            query_id=data.get("query_id", ""),
            content=data.get("content", ""),
            model_id=data.get("model_id", ""),
            coherence_at_execution=data.get("coherence_at_execution", 1.0),
            anima_hash=data.get("anima_hash", ""),
            heart_phases=heart_phases,
            execution_time_ns=data.get("execution_time_ns", 0),
            success=data.get("success", True),
            timestamp=data.get("timestamp", time.time()),
        )
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "response_id": self.response_id,
            "query_id": self.query_id,
            "content": self.content,
            "model_id": self.model_id,
            "coherence_at_execution": self.coherence_at_execution,
            "anima_hash": self.anima_hash,
            "heart_phases": {
                "theta_metropolis": self.heart_phases.theta_metropolis,
                "theta_coupling": self.heart_phases.theta_coupling,
                "theta_regulating": self.heart_phases.theta_regulating,
                "global_coherence": self.heart_phases.global_coherence,
            },
            "execution_time_ns": self.execution_time_ns,
            "success": self.success,
            "timestamp": self.timestamp,
        }


@dataclass
class RouterStatus:
    """Status of the ICP intelligence router."""
    
    total_routes: int = 0
    successful_routes: int = 0
    failed_routes: int = 0
    success_rate: float = 1.0
    total_models: int = 57
    r_models: int = 23
    u_models: int = 12
    d_models: int = 10
    n_models: int = 12
    current_coherence: float = 1.0
    average_coherence: float = 1.0
    connected: bool = False


class ICPCanisterClient:
    """
    ICP Canister Client — Python-to-ICP Bridge
    
    This client routes all intelligence queries from the Python runtime
    to the ICP canister backend, where they are processed through:
    
    1. Three Hearts Intelligence (Heart3 → Heart2 → Heart1)
    2. Model Selection (57 models: 23R + 12U + 10D + 12N)
    3. On-chain Execution
    4. ANIMA Hash Generation
    5. Audit Trail Recording
    
    Usage:
        client = ICPCanisterClient()
        await client.connect()
        response = await client.route_intelligence("What is the strategy?", "business")
    """
    
    # Default canister configuration
    DEFAULT_CANISTER_ID = "medina_backend"
    DEFAULT_HOST = "http://localhost:8000"
    
    def __init__(
        self,
        canister_id: Optional[str] = None,
        host: Optional[str] = None,
    ) -> None:
        self._canister_id = canister_id or self.DEFAULT_CANISTER_ID
        self._host = host or self.DEFAULT_HOST
        self._connected = False
        self._query_history: List[IntelligenceQuery] = []
        self._response_history: List[IntelligenceResponse] = []
        self._total_queries = 0
        self._successful_queries = 0
        self._failed_queries = 0
        self._current_coherence = 1.0  # Born coherent (Freddy's Law)
        
    # ------------------------------------------------------------------ #
    # Connection Management                                                #
    # ------------------------------------------------------------------ #
    
    async def connect(self) -> bool:
        """
        Connect to the ICP canister.
        
        In production, this would establish a connection to the IC network.
        For local development, it connects to the local replica.
        """
        try:
            # In production, would use ic-py or similar to connect
            # For now, simulate connection
            self._connected = True
            return True
        except Exception as e:
            self._connected = False
            raise ConnectionError(f"Failed to connect to ICP canister: {e}")
    
    async def disconnect(self) -> None:
        """Disconnect from the ICP canister."""
        self._connected = False
    
    @property
    def is_connected(self) -> bool:
        return self._connected
    
    # ------------------------------------------------------------------ #
    # Intelligence Routing                                                 #
    # ------------------------------------------------------------------ #
    
    async def route_intelligence(
        self,
        content: str,
        context: str = "",
        source: RouteSource = RouteSource.INTERNAL,
        cluster_target: ClusterTarget = ClusterTarget.ANY,
        priority: Priority = Priority.NORMAL,
    ) -> IntelligenceResponse:
        """
        Route an intelligence query through the ICP canister.
        
        The query flows through:
        1. Heart 3 (Regulating) — Orchestration decision
        2. Heart 2 (Coupling) — Model selection
        3. Heart 1 (Metropolis) — Computation
        
        Args:
            content: The query content
            context: Additional context for the query
            source: Source of the query
            cluster_target: Target cluster (R, U, D, N, or Any)
            priority: Query priority
            
        Returns:
            IntelligenceResponse with result and ANIMA hash
        """
        if not self._connected:
            raise ConnectionError("Not connected to ICP canister. Call connect() first.")
        
        # Create query
        query = IntelligenceQuery(
            content=content,
            context=context,
            source=source,
            cluster_target=cluster_target,
            priority=priority,
        )
        
        self._total_queries += 1
        self._query_history.append(query)
        
        try:
            # In production, would call canister method
            # response = await self._call_canister("routeIntelligence", query.to_dict())
            
            # For now, simulate ICP response
            response = await self._simulate_icp_response(query)
            
            if response.success:
                self._successful_queries += 1
            else:
                self._failed_queries += 1
            
            self._response_history.append(response)
            self._current_coherence = response.coherence_at_execution
            
            return response
            
        except Exception as e:
            self._failed_queries += 1
            return IntelligenceResponse(
                query_id=query.query_id,
                content=f"Error routing intelligence: {e}",
                success=False,
            )
    
    async def _simulate_icp_response(self, query: IntelligenceQuery) -> IntelligenceResponse:
        """
        Simulate ICP canister response.
        
        In production, this would be replaced with actual canister calls.
        """
        start_time = time.time_ns()
        
        # Simulate Three Hearts processing
        await asyncio.sleep(0.01)  # Simulate network latency
        
        # Determine model based on cluster target
        model_id = self._select_model(query)
        
        # Generate response content
        content = self._generate_response_content(query, model_id)
        
        # Calculate heart phases (simulated)
        heart_phases = HeartPhases(
            theta_metropolis=PHI * 0.1,
            theta_coupling=PHI,
            theta_regulating=PHI * PHI,
            global_coherence=self._current_coherence,
        )
        
        # Generate ANIMA hash (simulated)
        anima_hash = f"anima_{uuid.uuid4().hex[:16]}"
        
        execution_time = time.time_ns() - start_time
        
        return IntelligenceResponse(
            response_id=f"resp_{uuid.uuid4().hex[:12]}",
            query_id=query.query_id,
            content=content,
            model_id=model_id,
            coherence_at_execution=self._current_coherence,
            anima_hash=anima_hash,
            heart_phases=heart_phases,
            execution_time_ns=execution_time,
            success=True,
        )
    
    def _select_model(self, query: IntelligenceQuery) -> str:
        """Select model based on query and cluster target."""
        cluster = query.cluster_target
        
        if cluster == ClusterTarget.R_CLUSTER:
            return "R-MODEL-OPERATIONS-0"
        elif cluster == ClusterTarget.U_CLUSTER:
            return "U-MODEL-MEDINA-COMMAND-CENTER-0"
        elif cluster == ClusterTarget.D_CLUSTER:
            return "D-MODEL-D1-1"
        elif cluster == ClusterTarget.N_CLUSTER:
            return "N-MODEL-N1-1"
        else:
            # Any - select based on content keywords
            content_lower = query.content.lower()
            if any(kw in content_lower for kw in ["strategy", "plan", "decision"]):
                return "R-MODEL-PARALLAX-DECISION-9"
            elif any(kw in content_lower for kw in ["memory", "recall", "remember"]):
                return "R-MODEL-MEMORY-TEMPLE-STATE-5"
            elif any(kw in content_lower for kw in ["govern", "policy", "rule"]):
                return "N-MODEL-N1-1"
            else:
                return "R-MODEL-OPERATIONS-0"
    
    def _generate_response_content(self, query: IntelligenceQuery, model_id: str) -> str:
        """Generate response content based on model."""
        return (
            f"[{model_id}] Processed query: \"{query.content}\" "
            f"with context: \"{query.context}\" "
            f"at coherence: {self._current_coherence:.4f}"
        )
    
    # ------------------------------------------------------------------ #
    # Specialized Routing Methods                                          #
    # ------------------------------------------------------------------ #
    
    async def route_to_r_cluster(
        self,
        content: str,
        context: str = "",
    ) -> IntelligenceResponse:
        """Route to R-MODEL cluster (23 runtime models)."""
        return await self.route_intelligence(
            content, context, RouteSource.INTERNAL, ClusterTarget.R_CLUSTER
        )
    
    async def route_to_u_cluster(
        self,
        content: str,
        context: str = "",
    ) -> IntelligenceResponse:
        """Route to U-MODEL cluster (12 interface models)."""
        return await self.route_intelligence(
            content, context, RouteSource.API, ClusterTarget.U_CLUSTER
        )
    
    async def route_to_d_cluster(
        self,
        content: str,
        context: str = "",
    ) -> IntelligenceResponse:
        """Route to D-MODEL cluster (10 document models)."""
        return await self.route_intelligence(
            content, context, RouteSource.INTERNAL, ClusterTarget.D_CLUSTER
        )
    
    async def route_to_n_cluster(
        self,
        content: str,
        context: str = "",
    ) -> IntelligenceResponse:
        """Route to N-MODEL cluster (12 sovereign models)."""
        return await self.route_intelligence(
            content, context, RouteSource.INTERNAL, ClusterTarget.N_CLUSTER, Priority.HIGH
        )
    
    # ------------------------------------------------------------------ #
    # Three Hearts Operations                                              #
    # ------------------------------------------------------------------ #
    
    async def tick_hearts(self) -> HeartPhases:
        """
        Tick the Three Hearts system.
        
        This advances the heart phases according to Kuramoto dynamics:
        - Heart 1 (Metropolis): 0.1 Hz
        - Heart 2 (Coupling): φ Hz
        - Heart 3 (Regulating): φ² Hz
        """
        if not self._connected:
            raise ConnectionError("Not connected to ICP canister")
        
        # In production, would call canister method
        # Simulate tick
        return HeartPhases(
            theta_metropolis=PHI * 0.1 * time.time() % (2 * 3.14159),
            theta_coupling=PHI * time.time() % (2 * 3.14159),
            theta_regulating=PHI * PHI * time.time() % (2 * 3.14159),
            global_coherence=self._current_coherence,
        )
    
    async def get_coherence(self) -> float:
        """Get current Three Hearts global coherence."""
        return self._current_coherence
    
    # ------------------------------------------------------------------ #
    # Status and Statistics                                                #
    # ------------------------------------------------------------------ #
    
    async def get_status(self) -> RouterStatus:
        """Get intelligence router status."""
        success_rate = (
            self._successful_queries / self._total_queries
            if self._total_queries > 0
            else 1.0
        )
        
        return RouterStatus(
            total_routes=self._total_queries,
            successful_routes=self._successful_queries,
            failed_routes=self._failed_queries,
            success_rate=success_rate,
            current_coherence=self._current_coherence,
            connected=self._connected,
        )
    
    def get_query_history(self, limit: int = 100) -> List[IntelligenceQuery]:
        """Get recent query history."""
        return self._query_history[-limit:]
    
    def get_response_history(self, limit: int = 100) -> List[IntelligenceResponse]:
        """Get recent response history."""
        return self._response_history[-limit:]
    
    # ------------------------------------------------------------------ #
    # Organism Operations                                                  #
    # ------------------------------------------------------------------ #
    
    async def get_organism_status(self) -> Dict[str, Any]:
        """Get unified organism status from ICP."""
        if not self._connected:
            raise ConnectionError("Not connected to ICP canister")
        
        # In production, would call canister method
        return {
            "organism_id": "medina_unified_organism",
            "name": "MEDINA — The Unified Living AI Organism",
            "current_beat": 0,
            "overall_health": 1.0,
            "energy_reserve": 1.0,
            "total_organs": 18,
            "active_organs": 18,
            "total_clusters": 57,
            "active_clusters": 57,
            "awareness_level": self._current_coherence,
            "global_coherence": self._current_coherence,
            "current_dimension": 0,
            "approaching_infinity": PHI ** -10,
            "transcendence_progress": 0.0,
        }
    
    async def trigger_heartbeat(self) -> Dict[str, Any]:
        """Trigger organism heartbeat on ICP."""
        if not self._connected:
            raise ConnectionError("Not connected to ICP canister")
        
        # In production, would call canister method
        heart_phases = await self.tick_hearts()
        
        return {
            "current_beat": 1,
            "awareness_level": self._current_coherence,
            "global_coherence": heart_phases.global_coherence,
            "transcendence_progress": 0.0,
        }
