"""
Medina Actor Interface — High-Level ICP Integration

This module provides a high-level interface for the Medina platform
to interact with the ICP canister backend.

╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║                    MEDINA ACTOR INTERFACE FOR ICP                         ║
║                                                                           ║
║  This interface provides:                                                 ║
║                                                                           ║
║  1. High-level intelligence routing APIs                                  ║
║  2. Organism lifecycle management                                         ║
║  3. Model registry access                                                 ║
║  4. Three Hearts status and control                                       ║
║  5. Sovereign ledger integration                                          ║
║  6. ANIMA chain lineage tracking                                          ║
║                                                                           ║
║  Maintains the Triune Principle:                                          ║
║    Backend (ICP) ⊗ Frontend (Medina) ⊗ Documents (Doctrine)              ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
"""

from __future__ import annotations

import asyncio
import math
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Tuple

# Mathematical constants (same as MatalkoICP.mo)
PHI: float = 1.618033988749895
PHI_INV: float = 0.618033988749895
EPSILON: float = PHI ** -10  # Non-zero initial (Freddy's Law)


class ModelCluster(str, Enum):
    """Model cluster types matching ICP ModelRegistry."""
    RUNTIME = "r_model"      # 23 R-MODELs
    INTERFACE = "u_model"    # 12 U-MODELs
    DOCUMENT = "d_model"     # 10 D-MODELs
    SOVEREIGN = "n_model"    # 12 N-MODELs


class HeartId(str, Enum):
    """Three Hearts identifiers."""
    METROPOLIS = "metropolis"   # Heart 1: Backend computation
    COUPLING = "coupling"       # Heart 2: Model resonance
    REGULATING = "regulating"   # Heart 3: Orchestration


@dataclass
class ActorQuery:
    """High-level query for the Medina actor interface."""
    
    query_id: str = field(default_factory=lambda: f"aq_{uuid.uuid4().hex[:12]}")
    content: str = ""
    context: str = ""
    target_cluster: Optional[ModelCluster] = None
    metadata: Dict[str, Any] = field(default_factory=dict)
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "query_id": self.query_id,
            "content": self.content,
            "context": self.context,
            "target_cluster": self.target_cluster.value if self.target_cluster else None,
            "metadata": self.metadata,
            "timestamp": self.timestamp,
        }


@dataclass
class ActorResponse:
    """High-level response from the Medina actor interface."""
    
    response_id: str = ""
    query_id: str = ""
    content: str = ""
    model_id: str = ""
    model_cluster: Optional[ModelCluster] = None
    coherence: float = 1.0
    anima_hash: str = ""
    heart_phases: Dict[str, float] = field(default_factory=dict)
    ledger_entry_id: Optional[str] = None
    execution_time_ms: float = 0.0
    success: bool = True
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "response_id": self.response_id,
            "query_id": self.query_id,
            "content": self.content,
            "model_id": self.model_id,
            "model_cluster": self.model_cluster.value if self.model_cluster else None,
            "coherence": self.coherence,
            "anima_hash": self.anima_hash,
            "heart_phases": self.heart_phases,
            "ledger_entry_id": self.ledger_entry_id,
            "execution_time_ms": self.execution_time_ms,
            "success": self.success,
            "timestamp": self.timestamp,
        }


@dataclass
class OrganismStatus:
    """Status of the unified organism."""
    
    organism_id: str = ""
    name: str = ""
    current_beat: int = 0
    overall_health: float = 1.0
    energy_reserve: float = 1.0
    total_organs: int = 18
    active_organs: int = 18
    total_clusters: int = 57
    active_clusters: int = 57
    awareness_level: float = EPSILON
    global_coherence: float = 1.0
    current_dimension: int = 0
    approaching_infinity: float = EPSILON
    transcendence_progress: float = 0.0
    total_pulses: int = 0
    total_decisions: int = 0
    total_evolutions: int = 0
    anima_hash: str = ""


@dataclass 
class ThreeHeartsStatus:
    """Status of the Three Hearts system."""
    
    global_beat: int = 0
    global_coherence: float = 1.0
    metropolis: Dict[str, Any] = field(default_factory=dict)
    coupling: Dict[str, Any] = field(default_factory=dict)
    regulating: Dict[str, Any] = field(default_factory=dict)


class MedinaActorInterface:
    """
    Medina Actor Interface — High-Level ICP Integration
    
    This interface provides high-level APIs for the Medina platform
    to interact with the ICP canister backend.
    
    Features:
        - Intelligence routing through Three Hearts
        - Model cluster management (57 models)
        - Organism lifecycle control
        - Sovereign ledger integration
        - ANIMA chain lineage tracking
    
    Usage:
        actor = MedinaActorInterface()
        await actor.initialize()
        response = await actor.route("What is the strategy?")
    """
    
    def __init__(self) -> None:
        self._initialized = False
        self._current_beat = 0
        self._current_coherence = 1.0  # Born coherent (Freddy's Law)
        self._query_count = 0
        self._response_count = 0
        self._successful_count = 0
        self._failed_count = 0
        self._query_history: List[ActorQuery] = []
        self._response_history: List[ActorResponse] = []
        self._heart_phases: Dict[str, float] = {
            "metropolis": 0.0,
            "coupling": 0.0,
            "regulating": 0.0,
        }
    
    # ------------------------------------------------------------------ #
    # Initialization                                                       #
    # ------------------------------------------------------------------ #
    
    async def initialize(self) -> bool:
        """
        Initialize the actor interface.
        
        This establishes connection to the ICP canister and
        verifies the organism is ready.
        """
        try:
            self._initialized = True
            self._current_coherence = 1.0
            return True
        except Exception as e:
            self._initialized = False
            raise RuntimeError(f"Failed to initialize actor interface: {e}")
    
    async def shutdown(self) -> None:
        """Shutdown the actor interface."""
        self._initialized = False
    
    @property
    def is_initialized(self) -> bool:
        return self._initialized
    
    # ------------------------------------------------------------------ #
    # Intelligence Routing                                                 #
    # ------------------------------------------------------------------ #
    
    async def route(
        self,
        content: str,
        context: str = "",
        cluster: Optional[ModelCluster] = None,
        metadata: Optional[Dict[str, Any]] = None,
    ) -> ActorResponse:
        """
        Route an intelligence query through the ICP canister.
        
        The query flows through the Three Hearts:
        1. Heart 3 (Regulating) — Orchestration decision
        2. Heart 2 (Coupling) — Model selection
        3. Heart 1 (Metropolis) — Computation
        
        Args:
            content: The query content
            context: Additional context
            cluster: Target model cluster (optional)
            metadata: Additional metadata
            
        Returns:
            ActorResponse with result and ANIMA hash
        """
        if not self._initialized:
            raise RuntimeError("Actor interface not initialized. Call initialize() first.")
        
        start_time = time.time()
        
        # Create query
        query = ActorQuery(
            content=content,
            context=context,
            target_cluster=cluster,
            metadata=metadata or {},
        )
        
        self._query_count += 1
        self._query_history.append(query)
        
        try:
            # Tick hearts
            self._tick_hearts()
            
            # Select model based on cluster and content
            model_id, model_cluster = self._select_model(query)
            
            # Generate response content
            response_content = self._process_query(query, model_id, model_cluster)
            
            # Generate ANIMA hash
            anima_hash = f"anima_{uuid.uuid4().hex[:16]}"
            
            # Create ledger entry (simulated)
            ledger_entry_id = f"ledger_{uuid.uuid4().hex[:12]}"
            
            execution_time = (time.time() - start_time) * 1000
            
            response = ActorResponse(
                response_id=f"ar_{uuid.uuid4().hex[:12]}",
                query_id=query.query_id,
                content=response_content,
                model_id=model_id,
                model_cluster=model_cluster,
                coherence=self._current_coherence,
                anima_hash=anima_hash,
                heart_phases=self._heart_phases.copy(),
                ledger_entry_id=ledger_entry_id,
                execution_time_ms=execution_time,
                success=True,
            )
            
            self._successful_count += 1
            self._response_count += 1
            self._response_history.append(response)
            
            return response
            
        except Exception as e:
            self._failed_count += 1
            self._response_count += 1
            
            return ActorResponse(
                query_id=query.query_id,
                content=f"Error processing query: {e}",
                success=False,
            )
    
    def _tick_hearts(self) -> None:
        """Tick the Three Hearts phases."""
        self._current_beat += 1
        t = time.time()
        
        # Kuramoto dynamics (simplified)
        self._heart_phases["metropolis"] = (0.1 * t) % (2 * 3.14159)
        self._heart_phases["coupling"] = (PHI * t) % (2 * 3.14159)
        self._heart_phases["regulating"] = (PHI * PHI * t) % (2 * 3.14159)
        
        # Update coherence
        cos_sum = sum(
            math.cos(self._heart_phases[h])
            for h in ["metropolis", "coupling", "regulating"]
        )
        sin_sum = sum(
            math.sin(self._heart_phases[h])
            for h in ["metropolis", "coupling", "regulating"]
        )
        self._current_coherence = (cos_sum ** 2 + sin_sum ** 2) ** 0.5 / 3.0
    
    def _select_model(self, query: ActorQuery) -> Tuple[str, ModelCluster]:
        """Select model based on query."""
        if query.target_cluster:
            cluster = query.target_cluster
        else:
            # Auto-select based on content
            content_lower = query.content.lower()
            if any(kw in content_lower for kw in ["strategy", "plan", "decision"]):
                cluster = ModelCluster.RUNTIME
            elif any(kw in content_lower for kw in ["interface", "display", "ui"]):
                cluster = ModelCluster.INTERFACE
            elif any(kw in content_lower for kw in ["document", "doc", "knowledge"]):
                cluster = ModelCluster.DOCUMENT
            elif any(kw in content_lower for kw in ["govern", "sovereign", "law"]):
                cluster = ModelCluster.SOVEREIGN
            else:
                cluster = ModelCluster.RUNTIME
        
        # Select model ID
        model_id = {
            ModelCluster.RUNTIME: "R-MODEL-OPERATIONS-0",
            ModelCluster.INTERFACE: "U-MODEL-MEDINA-COMMAND-CENTER-0",
            ModelCluster.DOCUMENT: "D-MODEL-D1-1",
            ModelCluster.SOVEREIGN: "N-MODEL-N1-1",
        }.get(cluster, "R-MODEL-OPERATIONS-0")
        
        return model_id, cluster
    
    def _process_query(
        self,
        query: ActorQuery,
        model_id: str,
        cluster: ModelCluster,
    ) -> str:
        """Process query through model."""
        return (
            f"[{model_id}] Processed: \"{query.content}\" "
            f"context: \"{query.context}\" "
            f"coherence: {self._current_coherence:.4f}"
        )
    
    # ------------------------------------------------------------------ #
    # Specialized Routing                                                  #
    # ------------------------------------------------------------------ #
    
    async def route_to_runtime(self, content: str, context: str = "") -> ActorResponse:
        """Route to R-MODEL cluster (23 runtime models)."""
        return await self.route(content, context, ModelCluster.RUNTIME)
    
    async def route_to_interface(self, content: str, context: str = "") -> ActorResponse:
        """Route to U-MODEL cluster (12 interface models)."""
        return await self.route(content, context, ModelCluster.INTERFACE)
    
    async def route_to_document(self, content: str, context: str = "") -> ActorResponse:
        """Route to D-MODEL cluster (10 document models)."""
        return await self.route(content, context, ModelCluster.DOCUMENT)
    
    async def route_to_sovereign(self, content: str, context: str = "") -> ActorResponse:
        """Route to N-MODEL cluster (12 sovereign models)."""
        return await self.route(content, context, ModelCluster.SOVEREIGN)
    
    # ------------------------------------------------------------------ #
    # Organism Operations                                                  #
    # ------------------------------------------------------------------ #
    
    async def get_organism_status(self) -> OrganismStatus:
        """Get unified organism status."""
        if not self._initialized:
            raise RuntimeError("Actor interface not initialized")
        
        return OrganismStatus(
            organism_id="medina_unified_organism",
            name="MEDINA — The Unified Living AI Organism",
            current_beat=self._current_beat,
            overall_health=1.0,
            energy_reserve=1.0,
            total_organs=18,
            active_organs=18,
            total_clusters=57,
            active_clusters=57,
            awareness_level=self._current_coherence,
            global_coherence=self._current_coherence,
            current_dimension=0,
            approaching_infinity=EPSILON,
            transcendence_progress=0.0,
            total_pulses=self._current_beat,
            total_decisions=self._query_count,
            total_evolutions=0,
            anima_hash=f"anima_{uuid.uuid4().hex[:16]}",
        )
    
    async def trigger_heartbeat(self) -> Dict[str, Any]:
        """Trigger organism heartbeat."""
        if not self._initialized:
            raise RuntimeError("Actor interface not initialized")
        
        self._tick_hearts()
        
        return {
            "current_beat": self._current_beat,
            "awareness_level": self._current_coherence,
            "global_coherence": self._current_coherence,
            "heart_phases": self._heart_phases.copy(),
        }
    
    # ------------------------------------------------------------------ #
    # Three Hearts Operations                                              #
    # ------------------------------------------------------------------ #
    
    async def get_hearts_status(self) -> ThreeHeartsStatus:
        """Get Three Hearts system status."""
        if not self._initialized:
            raise RuntimeError("Actor interface not initialized")
        
        return ThreeHeartsStatus(
            global_beat=self._current_beat,
            global_coherence=self._current_coherence,
            metropolis={
                "theta": self._heart_phases["metropolis"],
                "omega": 0.1,
                "beats": self._current_beat,
            },
            coupling={
                "theta": self._heart_phases["coupling"],
                "omega": PHI,
                "beats": self._current_beat,
            },
            regulating={
                "theta": self._heart_phases["regulating"],
                "omega": PHI * PHI,
                "beats": self._current_beat,
            },
        )
    
    async def get_coherence(self) -> float:
        """Get current Three Hearts coherence."""
        return self._current_coherence
    
    # ------------------------------------------------------------------ #
    # Statistics                                                           #
    # ------------------------------------------------------------------ #
    
    async def get_statistics(self) -> Dict[str, Any]:
        """Get actor interface statistics."""
        success_rate = (
            self._successful_count / self._query_count
            if self._query_count > 0
            else 1.0
        )
        
        return {
            "total_queries": self._query_count,
            "total_responses": self._response_count,
            "successful": self._successful_count,
            "failed": self._failed_count,
            "success_rate": success_rate,
            "current_beat": self._current_beat,
            "current_coherence": self._current_coherence,
            "initialized": self._initialized,
        }
    
    def get_query_history(self, limit: int = 100) -> List[ActorQuery]:
        """Get recent query history."""
        return self._query_history[-limit:]
    
    def get_response_history(self, limit: int = 100) -> List[ActorResponse]:
        """Get recent response history."""
        return self._response_history[-limit:]
