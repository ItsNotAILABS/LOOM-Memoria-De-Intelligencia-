"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                          MEDINA SDK — PHANTOM MEMORY MODULE                                  ║
║               "Intelligentia Ex Primitivo — Intelligence From The Primitive"                 ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-383 — PHANTOM MEMORY SDK                                                    ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ¹⁴ = 842.998 Hz — Phantom Memory Layer                               ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import asyncio
import hashlib
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

from .constants import PHI, PHI_POWERS, FIBONACCI, SOLFEGGIO, SCHUMANN


class FieldState(str, Enum):
    """State of a phantom field."""
    DORMANT = "dormant"
    RESONATING = "resonating"
    ACTIVE = "active"
    DISSOLVING = "dissolving"
    PINNED = "pinned"


class MemoryType(str, Enum):
    """Types of phantom memory."""
    EPHEMERAL = "ephemeral"
    PERSISTENT = "persistent"
    TEMPORAL = "temporal"
    RESONANT = "resonant"
    QUANTUM = "quantum"


@dataclass
class FibonacciSeed:
    """Compressed memory seed using Fibonacci sequence."""
    
    index: int
    value: int
    ratio: float
    ring: int
    
    @classmethod
    def from_content(cls, content: str) -> "FibonacciSeed":
        """Create a seed from content."""
        # Hash content to get deterministic index
        hash_val = int(hashlib.sha256(content.encode()).hexdigest()[:8], 16)
        index = hash_val % len(FIBONACCI)
        value = FIBONACCI[index]
        
        # Ratio approaches φ for higher indices
        ratio = FIBONACCI[index] / FIBONACCI[index - 1] if index > 0 else 1.0
        ring = index % 13
        
        return cls(index=index, value=value, ratio=ratio, ring=ring)


@dataclass
class FrequencyKey:
    """Frequency-based encryption key."""
    
    schumann_factor: float
    solfeggio_index: int
    phi_power: int
    derived_frequency: float
    
    @classmethod
    def derive(cls, seed: FibonacciSeed) -> "FrequencyKey":
        """Derive a frequency key from a seed."""
        solf_index = seed.index % len(SOLFEGGIO)
        phi_power = (seed.index % 20) + 1
        
        freq = SCHUMANN * SOLFEGGIO[solf_index] * PHI_POWERS.get(phi_power, PHI ** phi_power)
        
        return cls(
            schumann_factor=SCHUMANN,
            solfeggio_index=solf_index,
            phi_power=phi_power,
            derived_frequency=freq,
        )


@dataclass
class PhantomMemoryEntry:
    """A single phantom memory entry."""
    
    id: str
    content_hash: str
    seed: FibonacciSeed
    frequency_key: FrequencyKey
    memory_type: MemoryType
    state: FieldState = FieldState.DORMANT
    theta: float = 0.0
    phi_coord: float = 0.0
    rho: float = 1.0
    created_at: float = field(default_factory=time.time)
    accessed_at: float = field(default_factory=time.time)
    access_count: int = 0
    pinned: bool = False
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.id,
            "content_hash": self.content_hash,
            "seed_index": self.seed.index,
            "seed_value": self.seed.value,
            "frequency": self.frequency_key.derived_frequency,
            "memory_type": self.memory_type.value,
            "state": self.state.value,
            "theta": self.theta,
            "phi": self.phi_coord,
            "rho": self.rho,
            "pinned": self.pinned,
            "access_count": self.access_count,
        }


class PhantomField:
    """
    Phantom Memory Field — Field-based memory that exists as frequency patterns.
    
    Memories are not stored — they are resonated into existence when needed.
    No trace unless explicitly pinned.
    
    FREQUENCY SIGNATURE: φ¹⁴ = 842.998 Hz
    PROTOCOL: PROT-383
    """
    
    def __init__(self, name: str = "CAMPUS PHANTASMATICUS") -> None:
        self.name = name
        self.frequency = PHI_POWERS[14]
        self.protocol = "PROT-383"
        
        # The field (only pinned memories persist)
        self._field: Dict[str, PhantomMemoryEntry] = {}
        
        # Active resonances (temporary)
        self._resonances: Dict[str, Any] = {}
        
        # State
        self.state = FieldState.DORMANT
        self.beat = 0
        self.ring = 0
    
    def encode(
        self,
        content: str,
        memory_type: MemoryType = MemoryType.EPHEMERAL,
        pin: bool = False,
    ) -> PhantomMemoryEntry:
        """
        Encode content into the phantom field.
        
        Args:
            content: Content to encode
            memory_type: Type of memory
            pin: Whether to pin (persist) the memory
        
        Returns:
            The phantom memory entry
        """
        # Create seed from content
        seed = FibonacciSeed.from_content(content)
        
        # Derive frequency key
        freq_key = FrequencyKey.derive(seed)
        
        # Calculate torus coordinates
        theta = (2 * 3.14159 * seed.index) / len(FIBONACCI)
        phi_coord = (2 * 3.14159 * seed.ring) / 13
        
        # Create entry
        entry = PhantomMemoryEntry(
            id=f"PM-{uuid.uuid4().hex[:12].upper()}",
            content_hash=hashlib.sha256(content.encode()).hexdigest()[:16],
            seed=seed,
            frequency_key=freq_key,
            memory_type=memory_type,
            state=FieldState.PINNED if pin else FieldState.RESONATING,
            theta=theta,
            phi_coord=phi_coord,
            pinned=pin,
        )
        
        # Store if pinned
        if pin:
            self._field[entry.id] = entry
        else:
            self._resonances[entry.id] = entry
        
        return entry
    
    def resonate(self, frequency: float, tolerance: float = 0.1) -> List[PhantomMemoryEntry]:
        """
        Resonate the field at a given frequency to recall memories.
        
        Args:
            frequency: The frequency to resonate at
            tolerance: Frequency matching tolerance (proportion)
        
        Returns:
            List of matching memory entries
        """
        matches = []
        
        for entry in list(self._field.values()) + list(self._resonances.values()):
            entry_freq = entry.frequency_key.derived_frequency
            
            # Check if frequency matches within tolerance
            if abs(entry_freq - frequency) / entry_freq <= tolerance:
                entry.accessed_at = time.time()
                entry.access_count += 1
                entry.state = FieldState.ACTIVE
                matches.append(entry)
        
        return matches
    
    def pin(self, entry_id: str) -> bool:
        """Pin a memory (make it persistent)."""
        # Check resonances first
        if entry_id in self._resonances:
            entry = self._resonances.pop(entry_id)
            entry.pinned = True
            entry.state = FieldState.PINNED
            self._field[entry_id] = entry
            return True
        
        # Check if already pinned
        if entry_id in self._field:
            self._field[entry_id].pinned = True
            return True
        
        return False
    
    def dissolve(self, entry_id: str) -> bool:
        """Dissolve a memory (remove it)."""
        if entry_id in self._field:
            del self._field[entry_id]
            return True
        if entry_id in self._resonances:
            del self._resonances[entry_id]
            return True
        return False
    
    def collapse_ephemeral(self) -> int:
        """Collapse all unpinned ephemeral resonances."""
        count = len(self._resonances)
        self._resonances.clear()
        return count
    
    def list_pinned(self) -> List[Dict[str, Any]]:
        """List all pinned memories."""
        return [entry.to_dict() for entry in self._field.values()]
    
    def get_status(self) -> Dict[str, Any]:
        """Get field status."""
        return {
            "name": self.name,
            "frequency": self.frequency,
            "protocol": self.protocol,
            "state": self.state.value,
            "pinned_count": len(self._field),
            "resonance_count": len(self._resonances),
            "total_memories": len(self._field) + len(self._resonances),
        }


__all__ = [
    "PhantomField",
    "PhantomMemoryEntry",
    "FibonacciSeed",
    "FrequencyKey",
    "FieldState",
    "MemoryType",
]
