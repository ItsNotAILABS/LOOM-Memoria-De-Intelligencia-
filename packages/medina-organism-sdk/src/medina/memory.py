"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                          MEDINA SDK — MEMORY TEMPLE MODULE                                   ║
║               "Intelligentia Ex Primitivo — Intelligence From The Primitive"                 ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-126 — MEMORY TEMPLE SDK                                                     ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ¹⁰ = 122.991 Hz — Memory Temple Layer                                ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import hashlib
import math
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

from .constants import PHI, PHI_POWERS, PHI_INV, FIBONACCI, TORUS_R


class MemoryKind(str, Enum):
    """Types of memory in the temple."""
    EPISODIC = "episodic"
    SEMANTIC = "semantic"
    PROCEDURAL = "procedural"
    WORKING = "working"
    DOCTRINE = "doctrine"


class MemoryState(str, Enum):
    """States of a memory."""
    DORMANT = "dormant"
    ACTIVE = "active"
    CONSOLIDATING = "consolidating"
    ARCHIVED = "archived"
    PINNED = "pinned"


@dataclass
class TorusCoordinates:
    """
    Coordinates on the memory torus.
    
    θ (theta) ∈ [0, 2π) — angular position on helix ring
    φ (phi)   ∈ [0, 2π) — toroidal rotation  
    ρ (rho)   ∈ ℝ₊      — radial depth (salience indicator)
    ring      ∈ ℕ       — memory ring index (temporal layer)
    beat      ∈ ℕ       — discrete creation time
    """
    theta: float
    phi: float
    rho: float
    ring: int
    beat: int
    
    def to_cartesian(self) -> Tuple[float, float, float]:
        """Convert to 3D Cartesian coordinates."""
        R = TORUS_R
        x = (R + self.rho * math.cos(self.theta)) * math.cos(self.phi)
        y = (R + self.rho * math.cos(self.theta)) * math.sin(self.phi)
        z = self.rho * math.sin(self.theta)
        return (x, y, z)


@dataclass
class Memory:
    """A memory stored in the temple."""
    
    id: str
    content: str
    kind: MemoryKind
    coordinates: TorusCoordinates
    state: MemoryState = MemoryState.ACTIVE
    salience: float = 1.0
    frequency: float = 0.0
    parent_id: Optional[str] = None
    children_ids: List[str] = field(default_factory=list)
    created_at: float = field(default_factory=time.time)
    accessed_at: float = field(default_factory=time.time)
    access_count: int = 0
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.id,
            "content": self.content[:100] + "..." if len(self.content) > 100 else self.content,
            "kind": self.kind.value,
            "state": self.state.value,
            "salience": self.salience,
            "frequency": self.frequency,
            "coordinates": {
                "theta": self.coordinates.theta,
                "phi": self.coordinates.phi,
                "rho": self.coordinates.rho,
                "ring": self.coordinates.ring,
                "beat": self.coordinates.beat,
            },
            "access_count": self.access_count,
            "created_at": self.created_at,
        }


class MemoryTemple:
    """
    Memory Temple — Torus-based memory storage system.
    
    The temple stores memories on a geometric torus with:
    - 13 rings (temporal layers)
    - 144 positions per ring (Fibonacci)
    - Golden ratio spacing for optimal dispersal
    
    FREQUENCY SIGNATURE: φ¹⁰ = 122.991 Hz
    PROTOCOL: PROT-126
    """
    
    def __init__(
        self,
        name: str = "TEMPLUM MEMORIAE",
        ring_count: int = 13,
        positions_per_ring: int = 144,
    ) -> None:
        self.name = name
        self.frequency = PHI_POWERS[10]
        self.protocol = "PROT-126"
        
        # Torus configuration
        self.ring_count = ring_count
        self.positions_per_ring = positions_per_ring
        self.major_radius = TORUS_R
        
        # Memory storage
        self.memories: Dict[str, Memory] = {}
        
        # Coordinate tracking
        self._next_theta = 0.0
        self._next_phi = 0.0
        self._current_ring = 0
        self._current_beat = 0
        
        # Golden ratio stepping
        self._theta_step = 2 * math.pi / (PHI ** 2 * 10)
        self._phi_step = 2 * math.pi / (PHI ** 3 * 10)
    
    def _advance_coordinates(self) -> TorusCoordinates:
        """Advance to next torus position using golden ratio spacing."""
        coords = TorusCoordinates(
            theta=self._next_theta,
            phi=self._next_phi,
            rho=1.0,
            ring=self._current_ring,
            beat=self._current_beat,
        )
        
        # Advance using golden ratio for optimal dispersal
        self._next_theta = (self._next_theta + self._theta_step) % (2 * math.pi)
        self._next_phi = (self._next_phi + self._phi_step) % (2 * math.pi)
        
        # Advance ring occasionally
        self._current_beat += 1
        if self._current_beat % self.positions_per_ring == 0:
            self._current_ring = (self._current_ring + 1) % self.ring_count
        
        return coords
    
    def store(
        self,
        content: str,
        kind: MemoryKind = MemoryKind.EPISODIC,
        metadata: Optional[Dict[str, Any]] = None,
    ) -> Memory:
        """
        Store a new memory in the temple.
        
        Args:
            content: Memory content
            kind: Type of memory
            metadata: Optional metadata
        
        Returns:
            The stored memory
        """
        memory_id = f"MEM-{uuid.uuid4().hex[:12].upper()}"
        coords = self._advance_coordinates()
        
        # Calculate frequency based on position
        freq = self.frequency * (1 + coords.ring * PHI_INV * 0.1)
        
        memory = Memory(
            id=memory_id,
            content=content,
            kind=kind,
            coordinates=coords,
            frequency=freq,
            metadata=metadata or {},
        )
        
        self.memories[memory_id] = memory
        return memory
    
    def recall(self, memory_id: str) -> Optional[Memory]:
        """Recall a memory by ID."""
        memory = self.memories.get(memory_id)
        if memory:
            memory.accessed_at = time.time()
            memory.access_count += 1
            memory.state = MemoryState.ACTIVE
        return memory
    
    def search(
        self,
        query: str,
        kind: Optional[MemoryKind] = None,
        limit: int = 10,
    ) -> List[Memory]:
        """
        Search memories by content.
        
        Args:
            query: Search query
            kind: Optional filter by kind
            limit: Maximum results
        
        Returns:
            List of matching memories
        """
        query_lower = query.lower()
        matches = []
        
        for memory in self.memories.values():
            if kind and memory.kind != kind:
                continue
            
            if query_lower in memory.content.lower():
                matches.append(memory)
        
        # Sort by relevance (access count + salience)
        matches.sort(key=lambda m: m.access_count * m.salience, reverse=True)
        
        return matches[:limit]
    
    def traverse(self, ring: int) -> List[Memory]:
        """
        Traverse to a specific ring and return its memories.
        
        Args:
            ring: Ring index (0 to ring_count-1)
        
        Returns:
            List of memories on that ring
        """
        return [
            m for m in self.memories.values()
            if m.coordinates.ring == ring
        ]
    
    def consolidate(self) -> int:
        """
        Consolidate memories — promote frequently accessed, decay others.
        
        Returns:
            Number of memories affected
        """
        affected = 0
        
        for memory in self.memories.values():
            # Calculate time since last access
            time_since = time.time() - memory.accessed_at
            
            # Decay salience over time
            decay_factor = math.exp(-time_since / (86400 * PHI))  # Daily decay
            memory.salience *= decay_factor
            
            # Promote if frequently accessed
            if memory.access_count > 10 and memory.state != MemoryState.PINNED:
                memory.state = MemoryState.CONSOLIDATING
                memory.salience = min(memory.salience * PHI, 10.0)
            
            # Archive if very low salience
            elif memory.salience < 0.1 and memory.state != MemoryState.PINNED:
                memory.state = MemoryState.ARCHIVED
            
            affected += 1
        
        return affected
    
    def pin(self, memory_id: str) -> bool:
        """Pin a memory (prevent decay)."""
        memory = self.memories.get(memory_id)
        if memory:
            memory.state = MemoryState.PINNED
            memory.salience = max(memory.salience, 5.0)
            return True
        return False
    
    def link(self, parent_id: str, child_id: str) -> bool:
        """Create a lineage link between memories."""
        parent = self.memories.get(parent_id)
        child = self.memories.get(child_id)
        
        if parent and child:
            if child_id not in parent.children_ids:
                parent.children_ids.append(child_id)
            child.parent_id = parent_id
            return True
        return False
    
    def get_lineage(self, memory_id: str) -> List[Memory]:
        """Get the full lineage chain of a memory."""
        lineage = []
        current_id = memory_id
        
        while current_id:
            memory = self.memories.get(current_id)
            if not memory:
                break
            lineage.insert(0, memory)
            current_id = memory.parent_id
        
        return lineage
    
    def list_memories(
        self,
        kind: Optional[MemoryKind] = None,
        state: Optional[MemoryState] = None,
        ring: Optional[int] = None,
        limit: int = 50,
    ) -> List[Dict[str, Any]]:
        """List memories with optional filters."""
        memories = list(self.memories.values())
        
        if kind:
            memories = [m for m in memories if m.kind == kind]
        if state:
            memories = [m for m in memories if m.state == state]
        if ring is not None:
            memories = [m for m in memories if m.coordinates.ring == ring]
        
        # Sort by salience
        memories.sort(key=lambda m: m.salience, reverse=True)
        
        return [m.to_dict() for m in memories[:limit]]
    
    def get_status(self) -> Dict[str, Any]:
        """Get temple status."""
        return {
            "name": self.name,
            "frequency": self.frequency,
            "protocol": self.protocol,
            "ring_count": self.ring_count,
            "positions_per_ring": self.positions_per_ring,
            "total_memories": len(self.memories),
            "current_ring": self._current_ring,
            "current_beat": self._current_beat,
            "by_kind": {
                k.value: sum(1 for m in self.memories.values() if m.kind == k)
                for k in MemoryKind
            },
            "by_state": {
                s.value: sum(1 for m in self.memories.values() if m.state == s)
                for s in MemoryState
            },
        }


__all__ = [
    "MemoryTemple",
    "Memory",
    "TorusCoordinates",
    "MemoryKind",
    "MemoryState",
]
