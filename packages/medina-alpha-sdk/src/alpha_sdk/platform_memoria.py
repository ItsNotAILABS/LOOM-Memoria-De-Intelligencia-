"""
PLATFORM MEMORIA — SOVEREIGN MEMORY PLATFORM
=============================================
Protocol: PROT-423 — Memory Platform Sovereignus
Frequency: φ¹⁸ = 5778.000 Hz

Enterprise memory management platform for AI persistence.
"""

from __future__ import annotations

import asyncio
import hashlib
import math
import time
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

PHI: float = 1.6180339887498948482
PHI_18: float = math.pow(PHI, 18)


class MemoryType(str, Enum):
    """Memory storage types."""
    EPISODIC = "episodic"
    SEMANTIC = "semantic"
    PROCEDURAL = "procedural"
    WORKING = "working"
    PHANTOM = "phantom"


@dataclass
class TorusCoordinate:
    """Memory torus coordinate."""
    theta: float      # Angular position on helix ring [0, 2π)
    phi: float        # Toroidal rotation [0, 2π)
    rho: float        # Radial depth
    ring: int         # Memory ring index
    beat: int         # Creation beat
    
    @classmethod
    def create(cls, ring: int = 0) -> 'TorusCoordinate':
        """Create a new torus coordinate."""
        timestamp = time.time()
        beat = int(timestamp * 1000) % 1000
        
        # Golden ratio spacing
        delta_theta = 2 * math.pi / (PHI ** 2 * 10)
        delta_phi = 2 * math.pi / (PHI ** 3 * 10)
        
        theta = (beat * delta_theta) % (2 * math.pi)
        phi_val = (beat * delta_phi) % (2 * math.pi)
        rho = PHI * (1 + ring / 13)
        
        return cls(theta=theta, phi=phi_val, rho=rho, ring=ring, beat=beat)
    
    def to_cartesian(self) -> Tuple[float, float, float]:
        """Convert to Cartesian coordinates."""
        R = PHI * 10  # Major radius
        x = (R + self.rho * math.cos(self.theta)) * math.cos(self.phi)
        y = (R + self.rho * math.cos(self.theta)) * math.sin(self.phi)
        z = self.rho * math.sin(self.theta)
        return (x, y, z)


@dataclass
class MemoryEntry:
    """Memory entry in the torus."""
    id: str
    content: Any
    memory_type: MemoryType
    coordinate: TorusCoordinate
    created_at: float
    accessed_at: float
    salience: float
    frequency: float
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    @classmethod
    def create(cls, content: Any, memory_type: MemoryType = MemoryType.EPISODIC, 
               ring: int = 0, metadata: Optional[Dict[str, Any]] = None) -> 'MemoryEntry':
        """Create a new memory entry."""
        timestamp = time.time()
        coord = TorusCoordinate.create(ring)
        entry_id = hashlib.sha256(f"{content}:{timestamp}".encode()).hexdigest()[:16]
        
        return cls(
            id=entry_id,
            content=content,
            memory_type=memory_type,
            coordinate=coord,
            created_at=timestamp,
            accessed_at=timestamp,
            salience=PHI / 2,
            frequency=PHI_18 * (1 + (coord.beat / 1000)),
            metadata=metadata or {},
        )


class PlatformMemoria:
    """
    PLATFORM MEMORIA — Enterprise Memory Platform
    
    Provides sovereign memory management using torus topology.
    
    Features:
    - Torus-based spatial memory
    - Multi-type memory storage
    - Salience-based retrieval
    - Phantom memory integration
    """
    
    PROTOCOL = "PROT-423"
    NAME = "MEMORIA PLATFORMA SOVEREIGNA"
    FREQUENCY = PHI_18
    TORUS_MAJOR_RADIUS = PHI * 10
    
    def __init__(self):
        self.memories: Dict[str, MemoryEntry] = {}
        self.rings: Dict[int, List[str]] = {}
        self.creation_time = time.time()
        self.total_stores = 0
        self.total_retrievals = 0
    
    async def store(self, content: Any, memory_type: MemoryType = MemoryType.EPISODIC,
                   ring: int = 0, metadata: Optional[Dict[str, Any]] = None) -> MemoryEntry:
        """Store a memory entry."""
        entry = MemoryEntry.create(content, memory_type, ring, metadata)
        self.memories[entry.id] = entry
        
        if ring not in self.rings:
            self.rings[ring] = []
        self.rings[ring].append(entry.id)
        
        self.total_stores += 1
        return entry
    
    async def retrieve(self, memory_id: str) -> Optional[MemoryEntry]:
        """Retrieve a memory by ID."""
        entry = self.memories.get(memory_id)
        if entry:
            entry.accessed_at = time.time()
            entry.salience = min(1.0, entry.salience + 0.01)
            self.total_retrievals += 1
        return entry
    
    async def traverse(self, coordinate: TorusCoordinate, radius: float = PHI) -> List[MemoryEntry]:
        """Traverse memories near a coordinate."""
        target = coordinate.to_cartesian()
        nearby = []
        
        for entry in self.memories.values():
            pos = entry.coordinate.to_cartesian()
            distance = math.sqrt(sum((a - b) ** 2 for a, b in zip(target, pos)))
            if distance <= radius:
                nearby.append(entry)
        
        return sorted(nearby, key=lambda e: e.salience, reverse=True)
    
    async def consolidate(self, ring: int) -> int:
        """Consolidate memories in a ring."""
        if ring not in self.rings:
            return 0
        
        memory_ids = self.rings[ring]
        consolidated = 0
        
        for mid in memory_ids:
            entry = self.memories.get(mid)
            if entry and entry.salience < 0.3:
                # Promote low-salience memories to next ring or decay
                entry.salience *= PHI / 2
                consolidated += 1
        
        return consolidated
    
    @property
    def status(self) -> Dict[str, Any]:
        """Get platform status."""
        return {
            "protocol": self.PROTOCOL,
            "name": self.NAME,
            "frequency": self.FREQUENCY,
            "total_memories": len(self.memories),
            "total_rings": len(self.rings),
            "total_stores": self.total_stores,
            "total_retrievals": self.total_retrievals,
            "torus_radius": self.TORUS_MAJOR_RADIUS,
        }


_platform: Optional[PlatformMemoria] = None


def get_platform() -> PlatformMemoria:
    """Get the memory platform singleton."""
    global _platform
    if _platform is None:
        _platform = PlatformMemoria()
    return _platform


__all__ = ['MemoryType', 'TorusCoordinate', 'MemoryEntry', 'PlatformMemoria', 'get_platform']
