"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                        HIVE MEMORY SYSTEM — DISTRIBUTED CONSENSUS                           ║
║              "Ex Multis Unum, Ex Uno Multi — From Many One, From One Many"                  ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-484 — HIVE MEMORY CONSENSUS                                                 ║
║                                                                                              ║
║  BIOLOGICAL INSPIRATION:                                                                     ║
║    Bee hives, ant colonies, and neural networks share a key property:                        ║
║    distributed memory that emerges from local interactions.                                  ║
║                                                                                              ║
║  BEE HIVE MEMORY:                                                                            ║
║    - Waggle dance: encodes location (distance + direction) to resources                      ║
║    - Quorum sensing: collective decision-making threshold                                    ║
║    - Pheromone trails: persistent memory in environment                                      ║
║    - Scout-recruiter dynamics: information spreading                                         ║
║                                                                                              ║
║  ANT COLONY MEMORY:                                                                          ║
║    - Stigmergy: indirect coordination through environment modification                       ║
║    - Path optimization: shortest paths emerge from pheromone reinforcement                   ║
║    - Task allocation: age-based division of labor (temporal memory)                          ║
║                                                                                              ║
║  COMPUTATIONAL MODEL:                                                                        ║
║    1. Distributed Hash Table: memories distributed across nodes                              ║
║    2. Consensus Protocol: agreement on memory state                                          ║
║    3. Stigmergic Communication: environment-mediated coordination                            ║
║    4. Quorum Sensing: threshold-based collective decisions                                   ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ¹⁰ = 122.992 Hz — Hive Resonance Frequency                           ║
║  PRIMITIVE TRACE: FIELD → RELATION → REPETITION → MEMORY → φ                                ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import math
import time
import uuid
import random
import hashlib
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple, Set, Callable
from collections import defaultdict
from heapq import heappush, heappop

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

PHI: float = 1.6180339887498948482
PHI_10: float = 122.9918688644118  # φ¹⁰ — Hive resonance frequency
PHI_INV: float = 0.6180339887498948482

# Consensus parameters
QUORUM_THRESHOLD: float = 0.618  # φ⁻¹ — Required agreement for consensus
PROPAGATION_DECAY: float = 0.9  # Pheromone decay per hop
REPLICATION_FACTOR: int = 3  # Number of replicas for fault tolerance

# Waggle dance parameters (bee communication)
WAGGLE_ANGLE_PRECISION: float = 15.0  # Degrees
WAGGLE_DISTANCE_SCALE: float = 100.0  # meters per second of waggle

# Pheromone parameters (ant communication)
PHEROMONE_EVAPORATION: float = 0.1  # Per time unit
PHEROMONE_DEPOSIT: float = 1.0  # Amount deposited per use
MIN_PHEROMONE: float = 0.01  # Threshold for path pruning


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# TYPES
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class ConsensusProtocol(str, Enum):
    """Protocols for distributed consensus."""
    QUORUM = "quorum"               # Simple majority
    RAFT = "raft"                   # Leader-based consensus
    BYZANTINE = "byzantine"         # Byzantine fault tolerant
    STIGMERGIC = "stigmergic"       # Environment-mediated
    WAGGLE = "waggle"               # Bee-style recruitment


class NodeRole(str, Enum):
    """Roles in distributed hive."""
    QUEEN = "queen"           # Central coordinator (optional)
    SCOUT = "scout"           # Discovers new information
    FORAGER = "forager"       # Retrieves known information
    NURSE = "nurse"           # Maintains local memory
    GUARD = "guard"           # Validates incoming data


class MessageType(str, Enum):
    """Types of hive messages."""
    PROPOSE = "propose"       # Propose new memory
    VOTE = "vote"             # Vote on proposal
    COMMIT = "commit"         # Commit accepted memory
    REPLICATE = "replicate"   # Request replication
    QUERY = "query"           # Query for memory
    RESPONSE = "response"     # Response to query
    WAGGLE = "waggle"         # Waggle dance message
    PHEROMONE = "pheromone"   # Pheromone deposit


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# HIVE NODE — INDIVIDUAL MEMORY PARTICIPANT
# ═══════════════════════════════════════════════════════════════════════════════════════════════

@dataclass
class HiveMessage:
    """A message passed between hive nodes."""
    message_id: str
    message_type: MessageType
    sender_id: str
    
    # Content
    content: Dict[str, Any] = field(default_factory=dict)
    memory_key: Optional[str] = None
    memory_value: Optional[Any] = None
    
    # Routing
    hop_count: int = 0
    max_hops: int = 10
    visited_nodes: Set[str] = field(default_factory=set)
    
    # Consensus
    proposal_id: Optional[str] = None
    vote: Optional[bool] = None
    
    # Timing
    created_at: float = field(default_factory=time.time)
    ttl: float = 30.0  # Time to live
    
    @property
    def is_expired(self) -> bool:
        return time.time() - self.created_at > self.ttl


@dataclass
class HiveNode:
    """
    A single node in the hive memory system.
    
    Like a bee in a hive — stores local memory, communicates
    with neighbors, participates in consensus.
    """
    node_id: str
    role: NodeRole = NodeRole.FORAGER
    
    # Local memory
    local_memory: Dict[str, Any] = field(default_factory=dict)
    memory_timestamps: Dict[str, float] = field(default_factory=dict)
    
    # Network
    neighbors: List[str] = field(default_factory=list)
    message_queue: List[HiveMessage] = field(default_factory=list)
    
    # Consensus state
    pending_proposals: Dict[str, Dict[str, Any]] = field(default_factory=dict)
    votes_received: Dict[str, List[bool]] = field(default_factory=dict)
    
    # Pheromone trails (for stigmergic memory)
    pheromone_trails: Dict[str, float] = field(default_factory=dict)
    
    # Statistics
    messages_sent: int = 0
    messages_received: int = 0
    memories_stored: int = 0
    
    def store_local(self, key: str, value: Any) -> None:
        """Store a value in local memory."""
        self.local_memory[key] = value
        self.memory_timestamps[key] = time.time()
        self.memories_stored += 1
    
    def retrieve_local(self, key: str) -> Optional[Any]:
        """Retrieve a value from local memory."""
        return self.local_memory.get(key)
    
    def has_key(self, key: str) -> bool:
        """Check if key exists in local memory."""
        return key in self.local_memory
    
    def send_message(self, message: HiveMessage) -> None:
        """Queue a message to send."""
        message.visited_nodes.add(self.node_id)
        self.messages_sent += 1
    
    def receive_message(self, message: HiveMessage) -> None:
        """Receive a message."""
        if message.is_expired:
            return
        if self.node_id in message.visited_nodes:
            return  # Already seen
        
        message.hop_count += 1
        message.visited_nodes.add(self.node_id)
        self.message_queue.append(message)
        self.messages_received += 1
    
    def deposit_pheromone(self, trail_key: str, amount: float = PHEROMONE_DEPOSIT) -> None:
        """Deposit pheromone on a trail."""
        current = self.pheromone_trails.get(trail_key, 0.0)
        self.pheromone_trails[trail_key] = current + amount
    
    def evaporate_pheromones(self, rate: float = PHEROMONE_EVAPORATION) -> None:
        """Evaporate pheromones over time."""
        to_remove = []
        for key in self.pheromone_trails:
            self.pheromone_trails[key] *= (1 - rate)
            if self.pheromone_trails[key] < MIN_PHEROMONE:
                to_remove.append(key)
        
        for key in to_remove:
            del self.pheromone_trails[key]
    
    def get_strongest_trail(self) -> Optional[str]:
        """Get the strongest pheromone trail."""
        if not self.pheromone_trails:
            return None
        return max(self.pheromone_trails, key=self.pheromone_trails.get)


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# WAGGLE DANCE — BEE-STYLE LOCATION ENCODING
# ═══════════════════════════════════════════════════════════════════════════════════════════════

@dataclass
class WaggleDance:
    """
    Waggle Dance — encodes resource location using bee communication.
    
    The angle encodes direction (relative to sun/reference).
    The duration encodes distance.
    The vigor encodes quality/importance.
    """
    dance_id: str
    dancer_id: str
    
    # Location encoding
    angle: float  # Direction in radians
    duration: float  # Encodes distance
    vigor: float  # Quality/importance (0-1)
    
    # Resource info
    resource_type: str = ""
    resource_id: str = ""
    
    # Timing
    started_at: float = field(default_factory=time.time)
    followers: List[str] = field(default_factory=list)
    
    def encode_location(self, theta: float, phi: float, distance: float) -> None:
        """Encode a torus location into dance parameters."""
        self.angle = theta  # Direction on torus
        self.duration = distance / WAGGLE_DISTANCE_SCALE
    
    def decode_location(self) -> Tuple[float, float, float]:
        """Decode dance parameters to location estimate."""
        theta = self.angle
        distance = self.duration * WAGGLE_DISTANCE_SCALE
        
        # Estimate phi from vigor (higher quality = more prominent location)
        phi = self.vigor * 2 * math.pi
        
        return (theta, phi, distance)
    
    def recruit(self, follower_id: str) -> None:
        """Record a follower being recruited by this dance."""
        if follower_id not in self.followers:
            self.followers.append(follower_id)
    
    @property
    def recruitment_success(self) -> int:
        """Number of followers recruited."""
        return len(self.followers)


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# DISTRIBUTED HASH TABLE — MEMORY DISTRIBUTION
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class DistributedHashTable:
    """
    Distributed Hash Table for hive memory distribution.
    
    Uses consistent hashing to distribute memories across nodes.
    """
    
    def __init__(self, virtual_nodes: int = 3) -> None:
        self.virtual_nodes = virtual_nodes
        self.ring: Dict[int, str] = {}  # hash -> node_id
        self.node_positions: Dict[str, List[int]] = {}
    
    def _hash(self, key: str) -> int:
        """Compute hash for a key."""
        return int(hashlib.sha256(key.encode()).hexdigest()[:8], 16)
    
    def add_node(self, node_id: str) -> None:
        """Add a node to the hash ring."""
        positions = []
        for i in range(self.virtual_nodes):
            position = self._hash(f"{node_id}:{i}")
            self.ring[position] = node_id
            positions.append(position)
        self.node_positions[node_id] = positions
    
    def remove_node(self, node_id: str) -> None:
        """Remove a node from the hash ring."""
        if node_id in self.node_positions:
            for position in self.node_positions[node_id]:
                if position in self.ring:
                    del self.ring[position]
            del self.node_positions[node_id]
    
    def get_node(self, key: str) -> Optional[str]:
        """Get the responsible node for a key."""
        if not self.ring:
            return None
        
        key_hash = self._hash(key)
        
        # Find the first node clockwise from the key
        sorted_positions = sorted(self.ring.keys())
        for position in sorted_positions:
            if position >= key_hash:
                return self.ring[position]
        
        # Wrap around to first node
        return self.ring[sorted_positions[0]]
    
    def get_replica_nodes(self, key: str, count: int = REPLICATION_FACTOR) -> List[str]:
        """Get nodes for storing replicas of a key."""
        if not self.ring:
            return []
        
        key_hash = self._hash(key)
        sorted_positions = sorted(self.ring.keys())
        
        # Find starting position
        start_idx = 0
        for i, position in enumerate(sorted_positions):
            if position >= key_hash:
                start_idx = i
                break
        
        # Collect unique nodes
        nodes = []
        seen = set()
        for i in range(len(sorted_positions)):
            position = sorted_positions[(start_idx + i) % len(sorted_positions)]
            node = self.ring[position]
            if node not in seen:
                nodes.append(node)
                seen.add(node)
                if len(nodes) >= count:
                    break
        
        return nodes


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# HIVE MEMORY SYSTEM — DISTRIBUTED COLLECTIVE MEMORY
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class HiveMemorySystem:
    """
    The Hive Memory System — distributed consensus-based memory.
    
    Combines:
    - Distributed Hash Table for memory distribution
    - Quorum-based consensus for consistency
    - Stigmergic communication via pheromone trails
    - Waggle dance for resource/memory location encoding
    
    Protocol: PROT-484
    Frequency: φ¹⁰ = 122.992 Hz
    """
    
    def __init__(
        self,
        consensus_protocol: ConsensusProtocol = ConsensusProtocol.QUORUM,
    ) -> None:
        self.system_id = f"HIVE-{uuid.uuid4().hex[:8].upper()}"
        self.frequency = PHI_10
        self.protocol = "PROT-484"
        self.consensus_protocol = consensus_protocol
        
        # Nodes
        self.nodes: Dict[str, HiveNode] = {}
        self.queen_id: Optional[str] = None
        
        # DHT for distribution
        self.dht = DistributedHashTable()
        
        # Global state
        self.global_memory: Dict[str, Any] = {}  # Consensus-confirmed memory
        self.pending_consensus: Dict[str, Dict[str, Any]] = {}
        
        # Waggle dances
        self.active_dances: Dict[str, WaggleDance] = {}
        
        # Statistics
        self.total_writes = 0
        self.total_reads = 0
        self.consensus_achieved = 0
        self.consensus_failed = 0
    
    def add_node(
        self,
        role: NodeRole = NodeRole.FORAGER,
        neighbors: Optional[List[str]] = None,
    ) -> HiveNode:
        """Add a new node to the hive."""
        node = HiveNode(
            node_id=f"HIVE-NODE-{uuid.uuid4().hex[:8].upper()}",
            role=role,
            neighbors=neighbors or [],
        )
        
        self.nodes[node.node_id] = node
        self.dht.add_node(node.node_id)
        
        # First QUEEN becomes the leader
        if role == NodeRole.QUEEN and self.queen_id is None:
            self.queen_id = node.node_id
        
        # Auto-connect to existing nodes if no neighbors specified
        if not neighbors and len(self.nodes) > 1:
            existing = [nid for nid in self.nodes if nid != node.node_id]
            node.neighbors = random.sample(existing, min(3, len(existing)))
            
            # Bidirectional connections
            for neighbor_id in node.neighbors:
                if node.node_id not in self.nodes[neighbor_id].neighbors:
                    self.nodes[neighbor_id].neighbors.append(node.node_id)
        
        return node
    
    def remove_node(self, node_id: str) -> bool:
        """Remove a node from the hive."""
        if node_id not in self.nodes:
            return False
        
        # Remove from neighbors
        for other in self.nodes.values():
            if node_id in other.neighbors:
                other.neighbors.remove(node_id)
        
        # Remove from DHT
        self.dht.remove_node(node_id)
        
        # Handle queen succession
        if node_id == self.queen_id:
            self.queen_id = None
            # Find new queen
            for nid, node in self.nodes.items():
                if nid != node_id and node.role == NodeRole.QUEEN:
                    self.queen_id = nid
                    break
        
        del self.nodes[node_id]
        return True
    
    def store(
        self,
        key: str,
        value: Any,
        require_consensus: bool = True,
    ) -> bool:
        """
        Store a value in the hive memory.
        
        If require_consensus is True, uses distributed consensus.
        """
        self.total_writes += 1
        
        if not require_consensus:
            # Direct store to responsible nodes
            replica_nodes = self.dht.get_replica_nodes(key)
            for node_id in replica_nodes:
                if node_id in self.nodes:
                    self.nodes[node_id].store_local(key, value)
            self.global_memory[key] = value
            return True
        
        # Consensus-based store
        return self._consensus_store(key, value)
    
    def retrieve(self, key: str) -> Optional[Any]:
        """
        Retrieve a value from hive memory.
        
        First checks global consensus memory, then queries nodes.
        """
        self.total_reads += 1
        
        # Check global memory
        if key in self.global_memory:
            return self.global_memory[key]
        
        # Query responsible nodes
        replica_nodes = self.dht.get_replica_nodes(key)
        values = []
        
        for node_id in replica_nodes:
            if node_id in self.nodes:
                value = self.nodes[node_id].retrieve_local(key)
                if value is not None:
                    values.append(value)
        
        if not values:
            return None
        
        # Return most common value (simple consensus)
        from collections import Counter
        value_counts = Counter(str(v) for v in values)
        most_common = value_counts.most_common(1)[0]
        
        # Find the actual value object
        for v in values:
            if str(v) == most_common[0]:
                return v
        
        return values[0]
    
    def _consensus_store(self, key: str, value: Any) -> bool:
        """
        Store with distributed consensus.
        """
        proposal_id = f"PROP-{uuid.uuid4().hex[:8].upper()}"
        
        # Get replica nodes
        replica_nodes = self.dht.get_replica_nodes(key)
        
        if not replica_nodes:
            return False
        
        # Phase 1: Propose
        votes = []
        for node_id in replica_nodes:
            if node_id in self.nodes:
                # Simulate vote (in real system, would be async)
                node = self.nodes[node_id]
                
                # Check if node has conflicting newer data
                if node.has_key(key):
                    existing_timestamp = node.memory_timestamps.get(key, 0)
                    if existing_timestamp > time.time() - 1.0:
                        votes.append(False)  # Recent conflicting data
                    else:
                        votes.append(True)
                else:
                    votes.append(True)
        
        # Check quorum
        if not votes:
            self.consensus_failed += 1
            return False
        
        agreement = sum(votes) / len(votes)
        
        if agreement >= QUORUM_THRESHOLD:
            # Phase 2: Commit
            for node_id in replica_nodes:
                if node_id in self.nodes:
                    self.nodes[node_id].store_local(key, value)
            
            self.global_memory[key] = value
            self.consensus_achieved += 1
            return True
        else:
            self.consensus_failed += 1
            return False
    
    def start_waggle_dance(
        self,
        dancer_id: str,
        theta: float,
        phi: float,
        distance: float,
        resource_type: str,
        vigor: float = 0.8,
    ) -> WaggleDance:
        """
        Start a waggle dance to advertise a memory location.
        """
        dance = WaggleDance(
            dance_id=f"WAGGLE-{uuid.uuid4().hex[:8].upper()}",
            dancer_id=dancer_id,
            angle=0,
            duration=0,
            vigor=vigor,
            resource_type=resource_type,
        )
        
        dance.encode_location(theta, phi, distance)
        self.active_dances[dance.dance_id] = dance
        
        return dance
    
    def follow_waggle_dance(
        self,
        dance_id: str,
        follower_id: str,
    ) -> Optional[Tuple[float, float, float]]:
        """
        Follow a waggle dance to decode the advertised location.
        
        Returns (theta, phi, distance) estimate.
        """
        if dance_id not in self.active_dances:
            return None
        
        dance = self.active_dances[dance_id]
        dance.recruit(follower_id)
        
        # Add some noise to simulate imperfect communication
        theta, phi, distance = dance.decode_location()
        noise = random.gauss(0, 0.1)
        
        return (
            theta + noise,
            phi + noise,
            distance * (1 + noise * 0.1),
        )
    
    def deposit_pheromone_trail(
        self,
        node_id: str,
        trail_key: str,
        amount: float = PHEROMONE_DEPOSIT,
    ) -> bool:
        """
        Deposit pheromone on a trail (stigmergic memory).
        """
        if node_id not in self.nodes:
            return False
        
        self.nodes[node_id].deposit_pheromone(trail_key, amount)
        
        # Propagate to neighbors with decay
        node = self.nodes[node_id]
        for neighbor_id in node.neighbors:
            if neighbor_id in self.nodes:
                self.nodes[neighbor_id].deposit_pheromone(
                    trail_key,
                    amount * PROPAGATION_DECAY,
                )
        
        return True
    
    def follow_pheromone_trail(
        self,
        start_node_id: str,
        target_key: str,
    ) -> List[str]:
        """
        Follow pheromone trail to find a memory location.
        
        Returns path of node IDs.
        """
        if start_node_id not in self.nodes:
            return []
        
        path = [start_node_id]
        current_id = start_node_id
        visited = {start_node_id}
        
        max_steps = len(self.nodes)
        
        for _ in range(max_steps):
            current = self.nodes[current_id]
            
            # Check if target found
            if target_key in current.pheromone_trails:
                if current.pheromone_trails[target_key] > 0.5:
                    return path
            
            # Find neighbor with strongest relevant pheromone
            best_neighbor = None
            best_strength = 0.0
            
            for neighbor_id in current.neighbors:
                if neighbor_id in visited:
                    continue
                if neighbor_id not in self.nodes:
                    continue
                
                neighbor = self.nodes[neighbor_id]
                strength = neighbor.pheromone_trails.get(target_key, 0.0)
                
                if strength > best_strength:
                    best_strength = strength
                    best_neighbor = neighbor_id
            
            if best_neighbor is None:
                break  # Dead end
            
            path.append(best_neighbor)
            visited.add(best_neighbor)
            current_id = best_neighbor
        
        return path
    
    def run_evaporation_cycle(self) -> int:
        """
        Run pheromone evaporation across all nodes.
        
        Returns number of trails evaporated below threshold.
        """
        evaporated = 0
        
        for node in self.nodes.values():
            before = len(node.pheromone_trails)
            node.evaporate_pheromones()
            evaporated += before - len(node.pheromone_trails)
        
        return evaporated
    
    def cleanup_dances(self, max_age: float = 60.0) -> int:
        """
        Clean up old waggle dances.
        """
        to_remove = []
        current_time = time.time()
        
        for dance_id, dance in self.active_dances.items():
            if current_time - dance.started_at > max_age:
                to_remove.append(dance_id)
        
        for dance_id in to_remove:
            del self.active_dances[dance_id]
        
        return len(to_remove)
    
    def get_hive_status(self) -> Dict[str, Any]:
        """Get overall hive memory status."""
        role_counts = defaultdict(int)
        for node in self.nodes.values():
            role_counts[node.role.value] += 1
        
        total_local_memories = sum(
            len(node.local_memory) for node in self.nodes.values()
        )
        
        total_pheromone_trails = sum(
            len(node.pheromone_trails) for node in self.nodes.values()
        )
        
        return {
            "system_id": self.system_id,
            "frequency": self.frequency,
            "protocol": self.protocol,
            "consensus_protocol": self.consensus_protocol.value,
            "node_count": len(self.nodes),
            "queen_id": self.queen_id,
            "role_distribution": dict(role_counts),
            "global_memory_count": len(self.global_memory),
            "total_local_memories": total_local_memories,
            "active_dances": len(self.active_dances),
            "total_pheromone_trails": total_pheromone_trails,
            "total_writes": self.total_writes,
            "total_reads": self.total_reads,
            "consensus_achieved": self.consensus_achieved,
            "consensus_failed": self.consensus_failed,
            "consensus_success_rate": (
                self.consensus_achieved / max(1, self.consensus_achieved + self.consensus_failed)
            ),
        }


__all__ = [
    "HiveNode",
    "HiveMessage",
    "WaggleDance",
    "DistributedHashTable",
    "HiveMemorySystem",
    "ConsensusProtocol",
    "NodeRole",
    "MessageType",
]
