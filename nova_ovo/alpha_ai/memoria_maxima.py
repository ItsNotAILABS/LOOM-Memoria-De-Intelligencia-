"""
MEMORIA MAXIMA — Supreme Memory AI
==================================
Protocol: PROT-163
Frequency: φ⁶ = 17.94 Hz

Manages the highest-level memory operations across the organism.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

import time
from dataclasses import dataclass
from typing import Dict, List, Optional, Any

PHI = 1.6180339887498948482


@dataclass
class MemoryRecord:
    """A memory record in MEMORIA MAXIMA."""
    record_id: str
    content: Any
    memory_type: str  # EPISODIC, SEMANTIC, PROCEDURAL, WORKING, DOCTRINE
    salience: float
    created_at: float
    ring: int
    torus_coords: Dict[str, float]


class MemoriaMaxima:
    """
    MEMORIA MAXIMA — Supreme Memory Coordinator
    
    Manages all memory operations at the organism level:
    - Cross-tier memory synchronization
    - Salience promotion/demotion
    - Memory consolidation
    - Torus navigation
    
    Frequency: φ⁶ = 17.94 Hz
    Protocol: PROT-163
    """
    
    FREQUENCY = PHI ** 6
    PROTOCOL = "PROT-163"
    
    def __init__(self):
        self.name = "MEMORIA MAXIMA"
        self.latin_name = "MEMORIA MAXIMA"
        self.memories: Dict[str, MemoryRecord] = {}
        self.ring_counts: Dict[int, int] = {}
    
    def store(self, content: Any, memory_type: str, salience: float = 1.0) -> MemoryRecord:
        """Store a new memory."""
        import hashlib
        record_id = hashlib.sha256(f"{content}{time.time()}".encode()).hexdigest()[:16]
        
        ring = self._compute_ring(len(self.memories))
        coords = self._compute_torus_coords(len(self.memories))
        
        record = MemoryRecord(
            record_id=record_id,
            content=content,
            memory_type=memory_type,
            salience=salience,
            created_at=time.time(),
            ring=ring,
            torus_coords=coords
        )
        
        self.memories[record_id] = record
        self.ring_counts[ring] = self.ring_counts.get(ring, 0) + 1
        
        return record
    
    def recall(self, record_id: str) -> Optional[MemoryRecord]:
        """Recall a memory by ID."""
        return self.memories.get(record_id)
    
    def search(self, query: str, memory_type: Optional[str] = None) -> List[MemoryRecord]:
        """Search memories by content."""
        results = []
        for record in self.memories.values():
            if memory_type and record.memory_type != memory_type:
                continue
            if query.lower() in str(record.content).lower():
                results.append(record)
        return sorted(results, key=lambda r: r.salience, reverse=True)
    
    def promote(self, record_id: str) -> bool:
        """Promote memory salience."""
        if record_id in self.memories:
            self.memories[record_id].salience = min(10.0, self.memories[record_id].salience * PHI)
            return True
        return False
    
    def consolidate(self, ring: int) -> int:
        """Consolidate memories in a ring."""
        records = [r for r in self.memories.values() if r.ring == ring]
        # Simple consolidation: mark low-salience as candidates
        consolidated = 0
        for record in records:
            if record.salience < 0.5:
                consolidated += 1
        return consolidated
    
    def _compute_ring(self, index: int) -> int:
        """Compute ring from Fibonacci thresholds."""
        fib = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]
        for i, f in enumerate(fib):
            if index < f:
                return max(0, i - 1)
        return len(fib) - 1
    
    def _compute_torus_coords(self, index: int) -> Dict[str, float]:
        """Compute torus coordinates."""
        import math
        delta_theta = (2 * math.pi) / (PHI ** 2 * 10)
        delta_phi = (2 * math.pi) / (PHI ** 3 * 10)
        return {
            'theta': (index * delta_theta) % (2 * math.pi),
            'phi': (index * delta_phi) % (2 * math.pi),
            'rho': PHI
        }
    
    def get_state(self) -> Dict:
        return {
            "name": self.name,
            "protocol": self.PROTOCOL,
            "frequency_hz": self.FREQUENCY,
            "total_memories": len(self.memories),
            "ring_distribution": self.ring_counts
        }
