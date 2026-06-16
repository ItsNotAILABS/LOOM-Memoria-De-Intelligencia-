"""
CPL Substrate — The Communication Fabric
=========================================
The substrate layer that enables CPL message flow.

The substrate is the "nervous system" connecting all organisms:
- Maintains message queues for each organism
- Routes messages via torus topology
- Monitors global coherence
- Handles cross-organism synchronization

ICP Integration:
  On ICP, the substrate lives in stable memory.
  Messages are processed during canister heartbeat cycles.
  Inter-canister messages use CPL encoding over IC calls.

Mathematical Foundation:
  The substrate implements a coupled oscillator network.
  Each organism is an oscillator with phase θ.
  Messages propagate via phase coupling:
    d(θᵢ)/dt = ωᵢ + Σⱼ Kᵢⱼ sin(θⱼ - θᵢ)
  Global coherence r measures synchronization:
    r = |(1/N) Σⱼ exp(i·θⱼ)|
"""

from __future__ import annotations

import math
import time
import threading
from collections import deque
from dataclasses import dataclass, field
from typing import Any, Callable, Dict, List, Optional, Tuple

from .protocol import (
    CPLMessage,
    CPLIntent,
    CPLAuthority,
    CPLRouter,
    TorusCoords,
    create_cpl_message,
    validate_cpl_message,
    PHI,
    PHASE_SCALE_FACTOR,
)

# Default coupling strength for Kuramoto phase synchronization
DEFAULT_COUPLING_STRENGTH = 0.5


@dataclass
class SubstrateConfig:
    """Configuration for the CPL substrate."""
    
    # Timing (φ-scaled tick interval)
    tick_interval: float = 1.0 / (PHI * PHASE_SCALE_FACTOR)
    max_queue_size: int = 1000
    message_ttl: float = 60.0  # Message time-to-live
    
    # Coupling
    default_coupling_strength: float = DEFAULT_COUPLING_STRENGTH
    coherence_threshold: float = 0.5  # Minimum acceptable coherence
    
    # Routing
    enable_nearest_neighbor: bool = True
    enable_broadcast: bool = True
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "tick_interval": self.tick_interval,
            "max_queue_size": self.max_queue_size,
            "message_ttl": self.message_ttl,
            "default_coupling_strength": self.default_coupling_strength,
            "coherence_threshold": self.coherence_threshold,
            "enable_nearest_neighbor": self.enable_nearest_neighbor,
            "enable_broadcast": self.enable_broadcast,
        }


class MessageQueue:
    """
    Thread-safe message queue for an organism.
    
    Implements a bounded queue with TTL enforcement.
    """
    
    def __init__(self, max_size: int = 1000, ttl: float = 60.0) -> None:
        self._queue: deque[CPLMessage] = deque(maxlen=max_size)
        self._max_size = max_size
        self._ttl = ttl
        self._lock = threading.Lock()
    
    def enqueue(self, message: CPLMessage) -> bool:
        """Add message to queue. Returns False if queue full."""
        with self._lock:
            if len(self._queue) >= self._max_size:
                return False
            self._queue.append(message)
            return True
    
    def dequeue(self) -> Optional[CPLMessage]:
        """Remove and return oldest message."""
        with self._lock:
            if not self._queue:
                return None
            return self._queue.popleft()
    
    def peek(self) -> Optional[CPLMessage]:
        """View oldest message without removing."""
        with self._lock:
            if not self._queue:
                return None
            return self._queue[0]
    
    def clear_expired(self) -> int:
        """Remove expired messages. Returns count removed."""
        now = time.time()
        removed = 0
        
        with self._lock:
            valid: deque[CPLMessage] = deque(maxlen=self._max_size)
            while self._queue:
                msg = self._queue.popleft()
                if now - msg.timestamp < self._ttl:
                    valid.append(msg)
                else:
                    removed += 1
            self._queue = valid
        
        return removed
    
    def __len__(self) -> int:
        with self._lock:
            return len(self._queue)
    
    def is_empty(self) -> bool:
        with self._lock:
            return len(self._queue) == 0


@dataclass
class OrganismNode:
    """
    Represents an organism in the substrate network.
    """
    
    organism_id: str
    coords: TorusCoords
    inbox: MessageQueue
    outbox: MessageQueue
    
    # Oscillator state
    theta: float = 0.0          # Phase angle
    omega: float = 1.0          # Natural frequency
    coupling: Dict[str, float] = field(default_factory=dict)
    
    # Health
    last_heartbeat: float = field(default_factory=time.time)
    is_active: bool = True
    
    def update_phase(self, dt: float, neighbors: Dict[str, float]) -> float:
        """
        Update phase via Kuramoto coupling.
        
          d(θ)/dt = ω + Σⱼ Kⱼ sin(θⱼ - θ)
        """
        coupling_sum = 0.0
        for neighbor_id, neighbor_theta in neighbors.items():
            K = self.coupling.get(neighbor_id, DEFAULT_COUPLING_STRENGTH)
            coupling_sum += K * math.sin(neighbor_theta - self.theta)
        
        d_theta = self.omega + coupling_sum
        self.theta = (self.theta + dt * d_theta) % (2 * math.pi)
        return self.theta


class CPLSubstrate:
    """
    The CPL communication substrate.
    
    This is the nervous system connecting all organisms.
    It handles:
    - Message routing between organisms
    - Global coherence monitoring
    - Phase synchronization
    - Heartbeat coordination
    """
    
    def __init__(self, config: Optional[SubstrateConfig] = None) -> None:
        self._config = config or SubstrateConfig()
        self._nodes: Dict[str, OrganismNode] = {}
        self._router = CPLRouter()
        self._global_beat: int = 0
        self._running: bool = False
        
        # Statistics
        self._messages_sent: int = 0
        self._messages_delivered: int = 0
        self._messages_failed: int = 0
    
    @property
    def config(self) -> SubstrateConfig:
        return self._config
    
    @property
    def global_beat(self) -> int:
        return self._global_beat
    
    # =================================================================== #
    # ORGANISM MANAGEMENT                                                   #
    # =================================================================== #
    
    def register_organism(
        self,
        organism_id: str,
        coords: TorusCoords,
        omega: float = 1.0,
    ) -> OrganismNode:
        """Register an organism with the substrate."""
        node = OrganismNode(
            organism_id=organism_id,
            coords=coords,
            inbox=MessageQueue(
                max_size=self._config.max_queue_size,
                ttl=self._config.message_ttl,
            ),
            outbox=MessageQueue(
                max_size=self._config.max_queue_size,
                ttl=self._config.message_ttl,
            ),
            theta=coords.theta,
            omega=omega,
        )
        
        self._nodes[organism_id] = node
        self._router.register_organism(organism_id, coords)
        
        # Set default coupling to all existing organisms
        for other_id in self._nodes:
            if other_id != organism_id:
                node.coupling[other_id] = self._config.default_coupling_strength
                self._nodes[other_id].coupling[organism_id] = \
                    self._config.default_coupling_strength
        
        return node
    
    def unregister_organism(self, organism_id: str) -> None:
        """Unregister an organism from the substrate."""
        if organism_id in self._nodes:
            del self._nodes[organism_id]
            self._router.unregister_organism(organism_id)
            
            # Remove from coupling dictionaries
            for node in self._nodes.values():
                node.coupling.pop(organism_id, None)
    
    def get_node(self, organism_id: str) -> Optional[OrganismNode]:
        """Get organism node by ID."""
        return self._nodes.get(organism_id)
    
    # =================================================================== #
    # MESSAGE HANDLING                                                      #
    # =================================================================== #
    
    def send_message(
        self,
        sender: str,
        receiver: str,
        intent: CPLIntent,
        authority: CPLAuthority = CPLAuthority.GATE_B,
        data: Optional[Dict[str, Any]] = None,
        vector: Tuple[float, float, float, float] = (0.0, 0.0, 0.0, 0.0),
    ) -> Optional[CPLMessage]:
        """
        Create and enqueue a message for delivery.
        """
        sender_node = self._nodes.get(sender)
        if not sender_node:
            return None
        
        # Get sender's current resonance
        resonance = self.compute_resonance(sender)
        
        msg = create_cpl_message(
            sender=sender,
            receiver=receiver,
            intent=intent,
            beat=self._global_beat,
            authority=authority,
            torus_coords=sender_node.coords,
            vector=vector,
            resonance=resonance,
            data=data or {},
        )
        
        # Validate message
        is_valid, error = validate_cpl_message(msg)
        if not is_valid:
            return None
        
        # Enqueue in sender's outbox
        if sender_node.outbox.enqueue(msg):
            self._messages_sent += 1
            return msg
        
        return None
    
    def deliver_messages(self) -> Dict[str, Any]:
        """
        Process all pending messages.
        
        Moves messages from outboxes to receiver inboxes.
        """
        delivered = 0
        failed = 0
        
        for node in self._nodes.values():
            while not node.outbox.is_empty():
                msg = node.outbox.dequeue()
                if msg is None:
                    continue
                
                # Find receiver
                if msg.receiver == "*":
                    # Broadcast
                    for other_id, other_node in self._nodes.items():
                        if other_id != msg.sender:
                            if other_node.inbox.enqueue(msg):
                                delivered += 1
                            else:
                                failed += 1
                else:
                    receiver_node = self._nodes.get(msg.receiver)
                    if receiver_node:
                        if receiver_node.inbox.enqueue(msg):
                            delivered += 1
                        else:
                            failed += 1
                    elif self._config.enable_nearest_neighbor:
                        # Route to nearest neighbor
                        nearest = self._find_nearest_neighbor(msg.torus_coords)
                        if nearest and nearest in self._nodes:
                            if self._nodes[nearest].inbox.enqueue(msg):
                                delivered += 1
                            else:
                                failed += 1
                        else:
                            failed += 1
                    else:
                        failed += 1
        
        self._messages_delivered += delivered
        self._messages_failed += failed
        
        return {
            "delivered": delivered,
            "failed": failed,
        }
    
    def _find_nearest_neighbor(self, coords: TorusCoords) -> Optional[str]:
        """Find the organism closest to given coordinates."""
        if not self._nodes:
            return None
        
        return min(
            self._nodes.keys(),
            key=lambda oid: self._nodes[oid].coords.distance_to(coords),
        )
    
    # =================================================================== #
    # PHASE SYNCHRONIZATION                                                 #
    # =================================================================== #
    
    def tick(self) -> Dict[str, Any]:
        """
        Execute one substrate tick.
        
        This is the heartbeat of the substrate:
        1. Update all organism phases (Kuramoto coupling)
        2. Deliver pending messages
        3. Clear expired messages
        4. Compute global coherence
        """
        self._global_beat += 1
        dt = self._config.tick_interval
        
        # 1. Collect current phases
        phases: Dict[str, float] = {
            oid: node.theta for oid, node in self._nodes.items()
        }
        
        # 2. Update each organism's phase
        for node in self._nodes.values():
            if node.is_active:
                neighbors = {
                    oid: theta for oid, theta in phases.items()
                    if oid != node.organism_id
                }
                node.update_phase(dt, neighbors)
                node.coords.theta = node.theta
        
        # 3. Deliver messages
        delivery_result = self.deliver_messages()
        
        # 4. Clear expired messages
        expired = 0
        for node in self._nodes.values():
            expired += node.inbox.clear_expired()
            expired += node.outbox.clear_expired()
        
        # 5. Compute global coherence
        coherence = self.compute_global_coherence()
        
        return {
            "beat": self._global_beat,
            "coherence": coherence,
            "delivered": delivery_result["delivered"],
            "failed": delivery_result["failed"],
            "expired": expired,
            "active_organisms": sum(1 for n in self._nodes.values() if n.is_active),
            "timestamp": time.time(),
        }
    
    def compute_global_coherence(self) -> float:
        """
        Compute Kuramoto order parameter.
        
          r = |(1/N) Σⱼ exp(i·θⱼ)|
        """
        active_nodes = [n for n in self._nodes.values() if n.is_active]
        if not active_nodes:
            return 1.0
        
        N = len(active_nodes)
        real_sum = sum(math.cos(n.theta) for n in active_nodes)
        imag_sum = sum(math.sin(n.theta) for n in active_nodes)
        
        r = math.sqrt(real_sum**2 + imag_sum**2) / N
        return r
    
    def compute_resonance(self, organism_id: str) -> float:
        """
        Compute individual organism resonance.
        
        Resonance = alignment with global phase.
        """
        node = self._nodes.get(organism_id)
        if not node:
            return 0.0
        
        global_coherence = self.compute_global_coherence()
        
        # Compute phase deviation from mean phase
        active_nodes = [n for n in self._nodes.values() if n.is_active]
        if not active_nodes:
            return 1.0
        
        mean_real = sum(math.cos(n.theta) for n in active_nodes) / len(active_nodes)
        mean_imag = sum(math.sin(n.theta) for n in active_nodes) / len(active_nodes)
        mean_theta = math.atan2(mean_imag, mean_real)
        
        phase_diff = node.theta - mean_theta
        individual_coherence = (1 + math.cos(phase_diff)) / 2
        
        return individual_coherence * global_coherence
    
    # =================================================================== #
    # COUPLING CONTROL                                                      #
    # =================================================================== #
    
    def set_coupling(
        self,
        organism_a: str,
        organism_b: str,
        strength: float,
    ) -> bool:
        """Set coupling strength between two organisms."""
        node_a = self._nodes.get(organism_a)
        node_b = self._nodes.get(organism_b)
        
        if not node_a or not node_b:
            return False
        
        node_a.coupling[organism_b] = strength
        node_b.coupling[organism_a] = strength
        return True
    
    def get_coupling_matrix(self) -> Dict[str, Dict[str, float]]:
        """Get the full coupling matrix."""
        return {
            oid: dict(node.coupling)
            for oid, node in self._nodes.items()
        }
    
    # =================================================================== #
    # STATISTICS                                                            #
    # =================================================================== #
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get substrate statistics."""
        total_inbox = sum(len(n.inbox) for n in self._nodes.values())
        total_outbox = sum(len(n.outbox) for n in self._nodes.values())
        
        return {
            "global_beat": self._global_beat,
            "registered_organisms": len(self._nodes),
            "active_organisms": sum(1 for n in self._nodes.values() if n.is_active),
            "global_coherence": self.compute_global_coherence(),
            "messages_sent": self._messages_sent,
            "messages_delivered": self._messages_delivered,
            "messages_failed": self._messages_failed,
            "pending_inbox": total_inbox,
            "pending_outbox": total_outbox,
            "config": self._config.to_dict(),
        }
    
    def get_organism_states(self) -> List[Dict[str, Any]]:
        """Get state of all registered organisms."""
        return [
            {
                "organism_id": node.organism_id,
                "coords": node.coords.to_dict(),
                "theta": node.theta,
                "omega": node.omega,
                "resonance": self.compute_resonance(node.organism_id),
                "is_active": node.is_active,
                "inbox_size": len(node.inbox),
                "outbox_size": len(node.outbox),
                "last_heartbeat": node.last_heartbeat,
            }
            for node in self._nodes.values()
        ]
