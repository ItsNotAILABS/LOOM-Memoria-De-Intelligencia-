"""
Resonance Propagation — Shell-State Influence Propagation
==========================================================
Handles propagation of shell-state influence across organisms
with bounded coupling rules.

Shell State Components:
- Energy: Available energy for operations
- Coherence: Phase alignment quality
- Resonance: Accumulated resonance charge

Influence propagates through the resonance bus, affecting
connected organisms based on coupling strength and rules.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, TYPE_CHECKING

if TYPE_CHECKING:
    from .bus import ResonanceBus, OrganismConnection


class InfluenceType(str, Enum):
    """Types of shell-state influence."""
    ENERGY = "energy"
    COHERENCE = "coherence"
    RESONANCE = "resonance"
    PHASE = "phase"
    COMBINED = "combined"


class PropagationMode(str, Enum):
    """Modes of influence propagation."""
    BROADCAST = "broadcast"   # Send to all connected
    DIRECTED = "directed"     # Send to specific targets
    PROXIMITY = "proximity"   # Send based on torus proximity
    HIERARCHY = "hierarchy"   # Send based on hierarchy level


@dataclass
class ShellInfluence:
    """
    A unit of shell-state influence.
    
    Represents influence being sent from one organism
    to another through the resonance bus.
    """
    
    influence_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    
    # Source
    source_id: str = ""
    source_type: str = "document"
    
    # Target (optional - for directed propagation)
    target_id: Optional[str] = None
    
    # Influence type and magnitude
    influence_type: InfluenceType = InfluenceType.ENERGY
    magnitude: float = 0.0
    
    # Source state at time of influence
    source_coherence: float = 1.0
    source_energy: float = 1.0
    source_phase: float = 0.0
    
    # Propagation mode
    mode: PropagationMode = PropagationMode.BROADCAST
    
    # Beat and timestamp
    beat: int = 0
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "influence_id": self.influence_id,
            "source_id": self.source_id,
            "source_type": self.source_type,
            "target_id": self.target_id,
            "influence_type": self.influence_type.value,
            "magnitude": round(self.magnitude, 4),
            "source_coherence": round(self.source_coherence, 4),
            "source_energy": round(self.source_energy, 4),
            "source_phase": round(self.source_phase, 4),
            "mode": self.mode.value,
            "beat": self.beat,
            "timestamp": self.timestamp,
        }


@dataclass
class PropagationEvent:
    """Record of an influence propagation event."""
    
    event_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    timestamp: float = field(default_factory=time.time)
    beat: int = 0
    
    # Influence
    influence: Optional[ShellInfluence] = None
    
    # Results
    targets_reached: int = 0
    total_influence_delivered: float = 0.0
    
    # Per-target results
    target_results: Dict[str, float] = field(default_factory=dict)
    
    # Errors
    errors: List[str] = field(default_factory=list)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "event_id": self.event_id,
            "timestamp": self.timestamp,
            "beat": self.beat,
            "influence": self.influence.to_dict() if self.influence else None,
            "targets_reached": self.targets_reached,
            "total_influence_delivered": round(self.total_influence_delivered, 4),
            "target_results": {
                k: round(v, 4) for k, v in self.target_results.items()
            },
            "errors": self.errors,
        }


@dataclass
class PropagationResult:
    """Result of a propagation operation."""
    
    success: bool = True
    event: Optional[PropagationEvent] = None
    
    # Metrics
    sources_processed: int = 0
    targets_affected: int = 0
    total_influence: float = 0.0
    
    # Timing
    propagation_time_ms: float = 0.0
    
    # Errors
    error: Optional[str] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "success": self.success,
            "event": self.event.to_dict() if self.event else None,
            "metrics": {
                "sources_processed": self.sources_processed,
                "targets_affected": self.targets_affected,
                "total_influence": round(self.total_influence, 4),
            },
            "propagation_time_ms": round(self.propagation_time_ms, 3),
            "error": self.error,
        }


class ResonancePropagator:
    """
    Propagates shell-state influence across the resonance bus.
    
    Handles:
    - Influence creation from source organisms
    - Propagation mode selection
    - Coupling-based influence scaling
    - Bounded influence application
    - Evidence trail creation
    """
    
    def __init__(
        self,
        bus: Optional["ResonanceBus"] = None,
        default_mode: PropagationMode = PropagationMode.BROADCAST,
    ) -> None:
        self._bus = bus
        self.default_mode = default_mode
        
        # Propagation history
        self._events: List[PropagationEvent] = []
        
        # Statistics
        self._propagation_count = 0
        self._total_influence_propagated = 0.0
    
    def bind_bus(self, bus: "ResonanceBus") -> None:
        """Bind to a resonance bus."""
        self._bus = bus
    
    def propagate(
        self,
        source_id: str,
        influence_type: InfluenceType,
        magnitude: float,
        mode: Optional[PropagationMode] = None,
        targets: Optional[List[str]] = None,
    ) -> PropagationResult:
        """
        Propagate influence from a source organism.
        
        Args:
            source_id: Source organism ID
            influence_type: Type of influence
            magnitude: Influence magnitude
            mode: Propagation mode
            targets: Target organism IDs (for directed mode)
        
        Returns:
            PropagationResult with event details
        """
        start_time = time.time()
        mode = mode or self.default_mode
        
        if not self._bus:
            return PropagationResult(
                success=False,
                error="No bus bound",
            )
        
        source_conn = self._bus.get_connection(source_id)
        if not source_conn:
            return PropagationResult(
                success=False,
                error=f"Source not connected: {source_id}",
            )
        
        if not source_conn.can_send_influence():
            return PropagationResult(
                success=False,
                error=f"Source cannot send influence: {source_id}",
            )
        
        # Create influence
        influence = ShellInfluence(
            source_id=source_id,
            source_type=source_conn.organism_type,
            influence_type=influence_type,
            magnitude=magnitude,
            source_coherence=source_conn.state.shell_coherence,
            source_energy=source_conn.state.shell_energy,
            source_phase=source_conn.state.theta,
            mode=mode,
            beat=self._bus.current_beat,
        )
        
        # Determine targets
        if mode == PropagationMode.DIRECTED:
            target_ids = targets or []
        elif mode == PropagationMode.BROADCAST:
            target_ids = [
                org_id for org_id in self._bus.connected_organisms
                if org_id != source_id
            ]
        elif mode == PropagationMode.PROXIMITY:
            target_ids = self._get_proximity_targets(source_conn)
        elif mode == PropagationMode.HIERARCHY:
            target_ids = self._get_hierarchy_targets(source_conn)
        else:
            target_ids = []
        
        # Propagate to targets
        event = PropagationEvent(
            beat=self._bus.current_beat,
            influence=influence,
        )
        
        for target_id in target_ids:
            target_conn = self._bus.get_connection(target_id)
            if not target_conn or not target_conn.can_receive_influence():
                continue
            
            # Get coupling strength
            coupling = self._bus._coupling_matrix.get(source_id, {}).get(
                target_id, self._bus.default_coupling_strength
            )
            
            # Calculate effective influence
            effective = magnitude * coupling * source_conn.state.shell_coherence
            effective = min(effective, target_conn.max_influence)
            
            # Apply influence
            self._apply_influence(target_conn, influence_type, effective)
            
            event.target_results[target_id] = effective
            event.total_influence_delivered += effective
            event.targets_reached += 1
        
        self._events.append(event)
        self._propagation_count += 1
        self._total_influence_propagated += event.total_influence_delivered
        
        propagation_time = (time.time() - start_time) * 1000
        
        return PropagationResult(
            success=True,
            event=event,
            sources_processed=1,
            targets_affected=event.targets_reached,
            total_influence=event.total_influence_delivered,
            propagation_time_ms=propagation_time,
        )
    
    def _apply_influence(
        self,
        target: "OrganismConnection",
        influence_type: InfluenceType,
        magnitude: float,
    ) -> None:
        """Apply influence to target organism."""
        if influence_type == InfluenceType.ENERGY:
            target.state.shell_energy = min(
                1.0, target.state.shell_energy + magnitude
            )
        elif influence_type == InfluenceType.COHERENCE:
            target.state.shell_coherence = min(
                1.0, target.state.shell_coherence + magnitude
            )
        elif influence_type == InfluenceType.RESONANCE:
            target.state.shell_resonance += magnitude
        elif influence_type == InfluenceType.PHASE:
            # Phase influence adjusts theta towards source
            target.state.theta = (
                target.state.theta + magnitude * 0.1
            ) % (6.28318)  # 2π
        elif influence_type == InfluenceType.COMBINED:
            # Apply to all components
            factor = magnitude / 3.0
            target.state.shell_energy = min(1.0, target.state.shell_energy + factor)
            target.state.shell_coherence = min(1.0, target.state.shell_coherence + factor)
            target.state.shell_resonance += factor
        
        target.pulses_received += 1
    
    def _get_proximity_targets(
        self,
        source: "OrganismConnection",
        max_distance: float = 1.0,
    ) -> List[str]:
        """Get targets based on torus proximity."""
        if not self._bus:
            return []
        
        targets = []
        source_theta = source.state.torus_theta
        source_phi = source.state.torus_phi
        
        for org_id in self._bus.connected_organisms:
            if org_id == source.organism_id:
                continue
            
            conn = self._bus.get_connection(org_id)
            if not conn:
                continue
            
            # Calculate angular distance
            d_theta = abs(conn.state.torus_theta - source_theta)
            d_phi = abs(conn.state.torus_phi - source_phi)
            distance = (d_theta**2 + d_phi**2) ** 0.5
            
            if distance <= max_distance:
                targets.append(org_id)
        
        return targets
    
    def _get_hierarchy_targets(
        self,
        source: "OrganismConnection",
    ) -> List[str]:
        """Get targets based on hierarchy (adjacent levels)."""
        if not self._bus:
            return []
        
        # For now, return all organisms of same type or adjacent organism indices
        targets = []
        source_idx = source.organism_id.split('_')[-1] if '_' in source.organism_id else "0"
        
        try:
            source_num = int(source_idx)
        except ValueError:
            source_num = 0
        
        for org_id in self._bus.connected_organisms:
            if org_id == source.organism_id:
                continue
            
            conn = self._bus.get_connection(org_id)
            if not conn:
                continue
            
            # Same type organisms are hierarchically related
            if conn.organism_type == source.organism_type:
                targets.append(org_id)
        
        return targets
    
    def propagate_batch(
        self,
        sources: List[str],
        influence_type: InfluenceType,
        magnitude: float,
        mode: Optional[PropagationMode] = None,
    ) -> List[PropagationResult]:
        """Propagate from multiple sources."""
        results = []
        for source_id in sources:
            result = self.propagate(source_id, influence_type, magnitude, mode)
            results.append(result)
        return results
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get propagator statistics."""
        return {
            "propagation_count": self._propagation_count,
            "total_influence_propagated": round(self._total_influence_propagated, 4),
            "default_mode": self.default_mode.value,
            "event_history_length": len(self._events),
        }
    
    def get_event_history(self, limit: int = 100) -> List[PropagationEvent]:
        """Get propagation event history."""
        return self._events[-limit:]
