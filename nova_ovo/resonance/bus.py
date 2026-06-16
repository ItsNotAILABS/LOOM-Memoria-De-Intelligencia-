"""
Resonance Bus — Shared Resonance State Coordination
====================================================
The ResonanceBus is the central coordination point for cross-organism
resonance at Tier-11.

Organisms connect to the bus and:
- Share their phase state
- Receive influence from connected organisms
- Participate in collective synchronization
- Maintain bounded coupling rules
"""

from __future__ import annotations

import math
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

# Golden ratio for natural frequency scaling
PHI = (1 + math.sqrt(5)) / 2

# Schumann resonance base frequency (Hz)
SCHUMANN_BASE = 7.83


class ConnectionStatus(str, Enum):
    """Connection status for organisms on the bus."""
    DISCONNECTED = "disconnected"
    CONNECTING = "connecting"
    CONNECTED = "connected"
    SYNCHRONIZED = "synchronized"
    ERROR = "error"


@dataclass
class ResonanceState:
    """
    Resonance state of an organism.
    
    Captures phase, frequency, and coupling information
    for cross-organism synchronization.
    """
    
    # Identity
    organism_id: str = ""
    organism_type: str = "document"  # "document", "workforce", "kernel", "sovereign"
    
    # Phase state (Kuramoto)
    theta: float = 0.0           # Phase angle [0, 2π)
    omega: float = 1.0           # Natural frequency
    d_theta: float = 0.0         # Phase velocity
    
    # Shell state (organism envelope)
    shell_energy: float = 1.0    # Energy level [0, 1]
    shell_coherence: float = 1.0 # Coherence [0, 1]
    shell_resonance: float = 0.0 # Accumulated resonance
    
    # Coupling
    coupling_strength: float = 0.5  # Default coupling strength
    influence_received: float = 0.0 # Total influence from others
    influence_sent: float = 0.0     # Total influence to others
    
    # Torus coordinates (memory position)
    torus_theta: float = 0.0
    torus_phi: float = 0.0
    torus_ring: int = 0
    
    # Beat tracking
    beat: int = 0
    timestamp: float = field(default_factory=time.time)
    
    @property
    def frequency_hz(self) -> float:
        """Frequency in Hz (scaled by PHI)."""
        return self.omega * PHI
    
    def phase_difference(self, other: "ResonanceState") -> float:
        """Compute phase difference with another state."""
        diff = other.theta - self.theta
        # Normalize to [-π, π]
        while diff > math.pi:
            diff -= 2 * math.pi
        while diff < -math.pi:
            diff += 2 * math.pi
        return diff
    
    def advance_phase(self, dt: float, coupling_sum: float = 0.0) -> None:
        """
        Advance phase by one timestep using Kuramoto dynamics.
        
        d(θ)/dt = ω + coupling_sum
        """
        self.d_theta = self.omega + coupling_sum
        self.theta = (self.theta + dt * self.d_theta) % (2 * math.pi)
        self.timestamp = time.time()
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "organism_id": self.organism_id,
            "organism_type": self.organism_type,
            "phase": {
                "theta": round(self.theta, 6),
                "omega": round(self.omega, 4),
                "d_theta": round(self.d_theta, 6),
                "frequency_hz": round(self.frequency_hz, 4),
            },
            "shell": {
                "energy": round(self.shell_energy, 4),
                "coherence": round(self.shell_coherence, 4),
                "resonance": round(self.shell_resonance, 4),
            },
            "coupling": {
                "strength": round(self.coupling_strength, 4),
                "influence_received": round(self.influence_received, 4),
                "influence_sent": round(self.influence_sent, 4),
            },
            "torus": {
                "theta": round(self.torus_theta, 6),
                "phi": round(self.torus_phi, 6),
                "ring": self.torus_ring,
            },
            "beat": self.beat,
            "timestamp": self.timestamp,
        }


@dataclass
class OrganismConnection:
    """
    Connection of an organism to the resonance bus.
    """
    
    connection_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    organism_id: str = ""
    organism_type: str = "document"
    
    # Connection state
    status: ConnectionStatus = ConnectionStatus.DISCONNECTED
    connected_at: Optional[float] = None
    last_pulse_at: Optional[float] = None
    
    # Resonance state
    state: ResonanceState = field(default_factory=ResonanceState)
    
    # Configuration
    coupling_enabled: bool = True
    max_influence: float = 1.0  # Maximum influence receivable
    min_coherence: float = 0.1  # Minimum coherence to send influence
    
    # Statistics
    pulses_sent: int = 0
    pulses_received: int = 0
    sync_events: int = 0
    
    def connect(self) -> None:
        """Establish connection to bus."""
        self.status = ConnectionStatus.CONNECTING
        self.connected_at = time.time()
        self.status = ConnectionStatus.CONNECTED
    
    def disconnect(self) -> None:
        """Disconnect from bus."""
        self.status = ConnectionStatus.DISCONNECTED
    
    def can_send_influence(self) -> bool:
        """Check if organism can send influence."""
        return (
            self.status == ConnectionStatus.CONNECTED and
            self.coupling_enabled and
            self.state.shell_coherence >= self.min_coherence
        )
    
    def can_receive_influence(self) -> bool:
        """Check if organism can receive influence."""
        return (
            self.status == ConnectionStatus.CONNECTED and
            self.coupling_enabled
        )
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "connection_id": self.connection_id,
            "organism_id": self.organism_id,
            "organism_type": self.organism_type,
            "status": self.status.value,
            "connected_at": self.connected_at,
            "last_pulse_at": self.last_pulse_at,
            "state": self.state.to_dict(),
            "config": {
                "coupling_enabled": self.coupling_enabled,
                "max_influence": self.max_influence,
                "min_coherence": self.min_coherence,
            },
            "statistics": {
                "pulses_sent": self.pulses_sent,
                "pulses_received": self.pulses_received,
                "sync_events": self.sync_events,
            },
        }


class ResonanceBus:
    """
    Central resonance bus for Tier-11 cross-organism coupling.
    
    Organisms connect to the bus and participate in collective
    phase synchronization through Kuramoto coupling dynamics.
    """
    
    def __init__(
        self,
        coupling_strength: float = 0.5,
        sync_threshold: float = 0.8,
    ) -> None:
        self.bus_id = str(uuid.uuid4())
        self.created_at = time.time()
        
        # Global coupling parameters
        self.default_coupling_strength = coupling_strength
        self.sync_threshold = sync_threshold  # Coherence threshold for "synchronized"
        
        # Connected organisms
        self._connections: Dict[str, OrganismConnection] = {}
        
        # Coupling matrix (organism_id -> organism_id -> coupling_strength)
        self._coupling_matrix: Dict[str, Dict[str, float]] = {}
        
        # Global state
        self.current_beat = 0
        self.global_coherence = 0.0
        self.global_phase = 0.0
        
        # History
        self._pulse_history: List[Dict[str, Any]] = []
    
    @property
    def connection_count(self) -> int:
        return len(self._connections)
    
    @property
    def connected_organisms(self) -> List[str]:
        return [
            c.organism_id for c in self._connections.values()
            if c.status == ConnectionStatus.CONNECTED
        ]
    
    def connect(
        self,
        organism_id: str,
        organism_type: str = "document",
        initial_state: Optional[ResonanceState] = None,
        coupling_strength: Optional[float] = None,
    ) -> OrganismConnection:
        """
        Connect an organism to the resonance bus.
        
        Args:
            organism_id: ID of the organism
            organism_type: Type of organism
            initial_state: Initial resonance state
            coupling_strength: Coupling strength (default: bus default)
        
        Returns:
            OrganismConnection for the connected organism
        """
        # Create connection
        conn = OrganismConnection(
            organism_id=organism_id,
            organism_type=organism_type,
        )
        
        # Set initial state
        if initial_state:
            conn.state = initial_state
        else:
            conn.state = ResonanceState(
                organism_id=organism_id,
                organism_type=organism_type,
                omega=1.0 + 0.1 * len(self._connections),  # Slight frequency variation
                coupling_strength=coupling_strength or self.default_coupling_strength,
            )
        
        # Establish connection
        conn.connect()
        
        # Add to bus
        self._connections[organism_id] = conn
        
        # Initialize coupling matrix row/column
        if organism_id not in self._coupling_matrix:
            self._coupling_matrix[organism_id] = {}
        
        # Set default coupling to all other organisms
        for other_id in self._connections:
            if other_id != organism_id:
                self._coupling_matrix[organism_id][other_id] = coupling_strength or self.default_coupling_strength
                if other_id not in self._coupling_matrix:
                    self._coupling_matrix[other_id] = {}
                self._coupling_matrix[other_id][organism_id] = coupling_strength or self.default_coupling_strength
        
        return conn
    
    def disconnect(self, organism_id: str) -> bool:
        """Disconnect an organism from the bus."""
        if organism_id not in self._connections:
            return False
        
        self._connections[organism_id].disconnect()
        del self._connections[organism_id]
        
        # Clean up coupling matrix
        if organism_id in self._coupling_matrix:
            del self._coupling_matrix[organism_id]
        for other_id in self._coupling_matrix:
            if organism_id in self._coupling_matrix[other_id]:
                del self._coupling_matrix[other_id][organism_id]
        
        return True
    
    def get_connection(self, organism_id: str) -> Optional[OrganismConnection]:
        """Get connection for an organism."""
        return self._connections.get(organism_id)
    
    def set_coupling(
        self,
        organism_a: str,
        organism_b: str,
        strength: float,
        bidirectional: bool = True,
    ) -> None:
        """
        Set coupling strength between two organisms.
        
        Args:
            organism_a: First organism ID
            organism_b: Second organism ID
            strength: Coupling strength [0, 1]
            bidirectional: If True, set both A→B and B→A
        """
        strength = max(0.0, min(1.0, strength))
        
        if organism_a in self._coupling_matrix:
            self._coupling_matrix[organism_a][organism_b] = strength
        
        if bidirectional and organism_b in self._coupling_matrix:
            self._coupling_matrix[organism_b][organism_a] = strength
    
    def pulse(self, dt: float = 0.1) -> Dict[str, Any]:
        """
        Pulse the bus — advance all organisms by one timestep.
        
        Implements Kuramoto dynamics:
          d(θᵢ)/dt = ωᵢ + Σⱼ Kᵢⱼ sin(θⱼ - θᵢ)
        
        Args:
            dt: Time step
        
        Returns:
            Pulse result with coherence and state updates
        """
        self.current_beat += 1
        
        # Calculate coupling sums for each organism
        coupling_sums: Dict[str, float] = {}
        
        for org_id, conn in self._connections.items():
            if not conn.can_receive_influence():
                coupling_sums[org_id] = 0.0
                continue
            
            coupling_sum = 0.0
            for other_id, other_conn in self._connections.items():
                if other_id == org_id:
                    continue
                if not other_conn.can_send_influence():
                    continue
                
                # Get coupling strength
                k_ij = self._coupling_matrix.get(org_id, {}).get(
                    other_id, self.default_coupling_strength
                )
                
                # Kuramoto coupling: K_ij * sin(θ_j - θ_i)
                phase_diff = conn.state.phase_difference(other_conn.state)
                coupling_sum += k_ij * math.sin(phase_diff)
                
                # Track influence
                other_conn.state.influence_sent += abs(k_ij * math.sin(phase_diff))
            
            coupling_sums[org_id] = coupling_sum
            conn.state.influence_received = coupling_sum
        
        # Advance phases
        for org_id, conn in self._connections.items():
            conn.state.advance_phase(dt, coupling_sums.get(org_id, 0.0))
            conn.state.beat = self.current_beat
            conn.last_pulse_at = time.time()
            conn.pulses_received += 1
        
        # Calculate global coherence: r = |(1/N) Σ exp(i * θⱼ)|
        self.global_coherence = self._compute_global_coherence()
        self.global_phase = self._compute_mean_phase()
        
        # Check for synchronization
        for conn in self._connections.values():
            if self.global_coherence >= self.sync_threshold:
                if conn.status != ConnectionStatus.SYNCHRONIZED:
                    conn.status = ConnectionStatus.SYNCHRONIZED
                    conn.sync_events += 1
            else:
                if conn.status == ConnectionStatus.SYNCHRONIZED:
                    conn.status = ConnectionStatus.CONNECTED
        
        # Create pulse record
        pulse_record = {
            "beat": self.current_beat,
            "timestamp": time.time(),
            "dt": dt,
            "global_coherence": self.global_coherence,
            "global_phase": self.global_phase,
            "organism_count": len(self._connections),
            "synchronized_count": sum(
                1 for c in self._connections.values()
                if c.status == ConnectionStatus.SYNCHRONIZED
            ),
        }
        
        self._pulse_history.append(pulse_record)
        
        return pulse_record
    
    def _compute_global_coherence(self) -> float:
        """
        Compute global coherence (Kuramoto order parameter).
        
        r = |(1/N) Σ exp(i * θⱼ)|
        """
        if not self._connections:
            return 1.0
        
        n = len(self._connections)
        real_sum = sum(
            math.cos(c.state.theta) for c in self._connections.values()
        )
        imag_sum = sum(
            math.sin(c.state.theta) for c in self._connections.values()
        )
        
        return math.sqrt(real_sum**2 + imag_sum**2) / n
    
    def _compute_mean_phase(self) -> float:
        """Compute mean phase angle."""
        if not self._connections:
            return 0.0
        
        real_sum = sum(
            math.cos(c.state.theta) for c in self._connections.values()
        )
        imag_sum = sum(
            math.sin(c.state.theta) for c in self._connections.values()
        )
        
        return math.atan2(imag_sum, real_sum)
    
    def propagate_shell_influence(
        self,
        source_id: str,
        influence_type: str = "energy",
        magnitude: float = 0.1,
    ) -> Dict[str, float]:
        """
        Propagate shell-state influence from one organism to others.
        
        Args:
            source_id: Source organism ID
            influence_type: Type of influence ("energy", "coherence", "resonance")
            magnitude: Influence magnitude
        
        Returns:
            Dict of organism_id -> influence received
        """
        if source_id not in self._connections:
            return {}
        
        source = self._connections[source_id]
        if not source.can_send_influence():
            return {}
        
        results: Dict[str, float] = {}
        
        for target_id, target in self._connections.items():
            if target_id == source_id:
                continue
            if not target.can_receive_influence():
                continue
            
            # Get coupling strength
            k = self._coupling_matrix.get(source_id, {}).get(
                target_id, self.default_coupling_strength
            )
            
            # Calculate influence (bounded by target's max_influence)
            raw_influence = magnitude * k * source.state.shell_coherence
            actual_influence = min(raw_influence, target.max_influence)
            
            # Apply influence based on type
            if influence_type == "energy":
                target.state.shell_energy = min(
                    1.0, target.state.shell_energy + actual_influence
                )
            elif influence_type == "coherence":
                target.state.shell_coherence = min(
                    1.0, target.state.shell_coherence + actual_influence
                )
            elif influence_type == "resonance":
                target.state.shell_resonance += actual_influence
            
            results[target_id] = actual_influence
        
        source.pulses_sent += 1
        return results
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get bus statistics."""
        connected = [
            c for c in self._connections.values()
            if c.status in (ConnectionStatus.CONNECTED, ConnectionStatus.SYNCHRONIZED)
        ]
        
        return {
            "bus_id": self.bus_id,
            "created_at": self.created_at,
            "current_beat": self.current_beat,
            "connection_count": len(self._connections),
            "connected_count": len(connected),
            "global_coherence": round(self.global_coherence, 4),
            "global_phase": round(self.global_phase, 4),
            "sync_threshold": self.sync_threshold,
            "synchronized_count": sum(
                1 for c in self._connections.values()
                if c.status == ConnectionStatus.SYNCHRONIZED
            ),
            "pulse_history_length": len(self._pulse_history),
            "by_type": self._count_by_type(),
        }
    
    def _count_by_type(self) -> Dict[str, int]:
        """Count connections by organism type."""
        counts: Dict[str, int] = {}
        for conn in self._connections.values():
            t = conn.organism_type
            counts[t] = counts.get(t, 0) + 1
        return counts
    
    def get_pulse_history(self, limit: int = 100) -> List[Dict[str, Any]]:
        """Get pulse history."""
        return self._pulse_history[-limit:]
    
    def to_dict(self) -> Dict[str, Any]:
        """Serialize bus state."""
        return {
            "bus_id": self.bus_id,
            "statistics": self.get_statistics(),
            "connections": {
                k: v.to_dict() for k, v in self._connections.items()
            },
        }
