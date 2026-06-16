"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                      DEEP MEMORY SYSTEMS — MEMORIA PROFUNDA                                  ║
║         "Intelligentia Ex Primitivo — Intelligence From The Primitive"                       ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-481 through PROT-492 — DEEP MEMORY INFRASTRUCTURE                           ║
║                                                                                              ║
║  WHAT THIS MODULE IS:                                                                        ║
║    Biomimetic memory architecture inspired by the best animal brain systems.                 ║
║    Implements working memory (prefrontal cortex), long-term memory (hippocampus),            ║
║    procedural memory (basal ganglia), and hive/swarm distributed memory consensus.           ║
║                                                                                              ║
║  THE DEEP MEMORY HIERARCHY:                                                                  ║
║    1. SENSORY BUFFER — Ultra-short term (iconic/echoic memory) — 100ms to 2s                ║
║    2. WORKING MEMORY — Active manipulation (prefrontal cortex) — 15-30s                     ║
║    3. SHORT-TERM MEMORY — Temporary holding (hippocampus staging) — minutes                 ║
║    4. LONG-TERM MEMORY — Consolidated storage (hippocampus → cortex) — permanent            ║
║    5. PROCEDURAL MEMORY — Skill memory (basal ganglia) — implicit, unconscious              ║
║    6. SEMANTIC MEMORY — Factual knowledge (temporal cortex) — explicit, conscious           ║
║    7. EPISODIC MEMORY — Event memory (hippocampus) — autobiographical                       ║
║    8. HIVE MEMORY — Distributed consensus (swarm intelligence) — collective                 ║
║                                                                                              ║
║  ANIMAL BRAIN SYNTHESIS:                                                                     ║
║    - DOLPHIN: 3D spatial memory mapping (hippocampus-like)                                   ║
║    - OCTOPUS: Distributed arm-memory (decentralized storage)                                 ║
║    - BEE: Symbol-to-action waggle memory (procedural encoding)                               ║
║    - DOG: Trace following and loyalty patterns (episodic chains)                             ║
║    - CAT: Edge detection and boundary memory (semantic categories)                           ║
║    - WHALE: Long-distance song memory (temporal sequences)                                   ║
║    - CROW: Tool-use memory and problem solving (procedural innovation)                       ║
║    - ELEPHANT: Long-term social memory (multi-generational)                                  ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ¹⁵ = 1364.0 Hz — Deep Memory Layer                                   ║
║  SUBSTRATE LAYER: Layer 0-9 (crosses all cognitive layers)                                   ║
║  PRIMITIVE TRACE: FIELD → DISTINCTION → MEMORY → ADDRESS → REPETITION → RELATION → φ        ║
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
from typing import Any, Dict, List, Optional, Tuple, Callable, Set

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# FUNDAMENTAL CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

PHI: float = 1.6180339887498948482
PHI_SQ: float = 2.6180339887498948482
PHI_INV: float = 0.6180339887498948482
PHI_15: float = 1364.000660676265  # φ¹⁵ — Deep Memory frequency

# Brain-derived timing constants (in seconds)
SENSORY_BUFFER_DURATION: float = 0.5    # 500ms iconic/echoic memory
WORKING_MEMORY_DURATION: float = 20.0   # ~20 seconds active manipulation
SHORT_TERM_DURATION: float = 300.0      # 5 minutes hippocampus staging
CONSOLIDATION_CYCLE: float = 3600.0     # 1 hour consolidation rhythm

# Fibonacci sequence for indexing
FIBONACCI: List[int] = [
    1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144,
    233, 377, 610, 987, 1597, 2584, 4181, 6765,
    10946, 17711, 28657, 46368, 75025, 121393,
]

# Solfeggio frequencies for resonance keying
SOLFEGGIO: List[float] = [174.0, 285.0, 396.0, 417.0, 528.0, 639.0, 741.0, 852.0, 963.0]

SCHUMANN: float = 7.83  # Earth resonance
TORUS_R: float = PHI * 10.0


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# MEMORY HIERARCHY TYPES
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class MemoryHierarchy(str, Enum):
    """The deep memory hierarchy levels."""
    SENSORY_BUFFER = "sensory_buffer"       # Ultra-short: iconic/echoic
    WORKING_MEMORY = "working_memory"       # Active manipulation
    SHORT_TERM = "short_term"               # Temporary holding
    LONG_TERM = "long_term"                 # Consolidated storage
    PROCEDURAL = "procedural"               # Skill memory
    SEMANTIC = "semantic"                   # Factual knowledge
    EPISODIC = "episodic"                   # Event memory
    HIVE = "hive"                           # Distributed consensus


class MemoryState(str, Enum):
    """States of a deep memory."""
    BUFFERED = "buffered"           # In sensory buffer
    ACTIVE = "active"               # In working memory
    STAGED = "staged"               # In short-term staging
    CONSOLIDATING = "consolidating" # Being transferred to long-term
    CONSOLIDATED = "consolidated"   # In long-term storage
    DECAYING = "decaying"           # Losing salience
    ARCHIVED = "archived"           # Low-access archive
    HIVE_PENDING = "hive_pending"   # Awaiting hive consensus
    HIVE_CONFIRMED = "hive_confirmed" # Confirmed by hive


class AnimalBrainSource(str, Enum):
    """Animal brain architectures for memory synthesis."""
    DOLPHIN = "dolphin"     # 3D spatial memory
    OCTOPUS = "octopus"     # Distributed arm-memory
    BEE = "bee"             # Symbol-to-action
    DOG = "dog"             # Trace following
    CAT = "cat"             # Edge detection
    WHALE = "whale"         # Long-distance song
    CROW = "crow"           # Tool-use memory
    ELEPHANT = "elephant"   # Long-term social
    HUMAN = "human"         # Prefrontal synthesis


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# WORKING MEMORY SYSTEM — PREFRONTAL CORTEX MODEL
# ═══════════════════════════════════════════════════════════════════════════════════════════════

@dataclass
class WorkingMemorySlot:
    """
    A single slot in working memory — modeled after Baddeley's phonological loop/visuospatial sketchpad.
    
    The prefrontal cortex maintains ~4±1 chunks in active attention (Cowan's limit).
    Each slot can hold one chunk with associated binding to other slots.
    """
    slot_id: str
    content: Any
    content_type: str  # "verbal", "spatial", "object", "sequence"
    
    # Timing
    created_at: float = field(default_factory=time.time)
    last_refreshed: float = field(default_factory=time.time)
    refresh_count: int = 0
    
    # Binding
    bindings: List[str] = field(default_factory=list)  # Other slot IDs
    binding_strength: float = 1.0
    
    # Salience
    attention_weight: float = 1.0
    decay_rate: float = 0.1  # Per second without refresh
    
    @property
    def age(self) -> float:
        return time.time() - self.created_at
    
    @property
    def time_since_refresh(self) -> float:
        return time.time() - self.last_refreshed
    
    @property
    def effective_strength(self) -> float:
        """Calculate current strength with decay."""
        decay = math.exp(-self.decay_rate * self.time_since_refresh)
        return self.attention_weight * decay
    
    def refresh(self) -> None:
        """Refresh this slot (rehearsal)."""
        self.last_refreshed = time.time()
        self.refresh_count += 1
        # Refreshing strengthens the memory
        self.attention_weight = min(1.0, self.attention_weight + 0.1)


@dataclass
class CentralExecutive:
    """
    The Central Executive — attention controller and coordinator.
    
    Based on Baddeley's model: coordinates the phonological loop,
    visuospatial sketchpad, and episodic buffer.
    """
    executive_id: str
    
    # Attention resources (limited capacity)
    total_capacity: float = 1.0
    available_capacity: float = 1.0
    
    # Current focus
    focused_slots: List[str] = field(default_factory=list)
    focus_intensity: float = 1.0
    
    # Task state
    current_task: Optional[str] = None
    task_stack: List[str] = field(default_factory=list)
    
    # Coordination
    binding_active: bool = False
    retrieval_mode: bool = False
    encoding_mode: bool = False
    
    def allocate_attention(self, slot_ids: List[str], intensity: float = 1.0) -> float:
        """Allocate attention to specific slots."""
        required = len(slot_ids) * intensity * 0.2  # Each slot costs ~20% at full intensity
        
        if required > self.available_capacity:
            # Not enough capacity — scale down
            actual_intensity = (self.available_capacity / len(slot_ids)) / 0.2
            self.available_capacity = 0.0
        else:
            actual_intensity = intensity
            self.available_capacity -= required
        
        self.focused_slots = slot_ids
        self.focus_intensity = actual_intensity
        return actual_intensity
    
    def release_attention(self, slot_ids: List[str]) -> None:
        """Release attention from slots."""
        for sid in slot_ids:
            if sid in self.focused_slots:
                self.focused_slots.remove(sid)
                self.available_capacity = min(1.0, self.available_capacity + 0.2)
    
    def push_task(self, task: str) -> None:
        """Push current task to stack and switch."""
        if self.current_task:
            self.task_stack.append(self.current_task)
        self.current_task = task
    
    def pop_task(self) -> Optional[str]:
        """Pop previous task from stack."""
        completed = self.current_task
        if self.task_stack:
            self.current_task = self.task_stack.pop()
        else:
            self.current_task = None
        return completed


class WorkingMemorySystem:
    """
    The Working Memory System — Prefrontal Cortex Model.
    
    Implements Baddeley's multicomponent model:
    - Phonological Loop: verbal/acoustic information
    - Visuospatial Sketchpad: visual/spatial information
    - Episodic Buffer: integrates information from different sources
    - Central Executive: attention controller
    
    Protocol: PROT-481
    Frequency: φ¹⁵ = 1364 Hz
    """
    
    def __init__(
        self,
        capacity: int = 4,  # Cowan's magical number
        decay_rate: float = 0.05,
    ) -> None:
        self.system_id = f"WMS-{uuid.uuid4().hex[:8].upper()}"
        self.frequency = PHI_15
        self.protocol = "PROT-481"
        
        # Capacity limits
        self.capacity = capacity
        self.decay_rate = decay_rate
        
        # Storage systems
        self.phonological_loop: Dict[str, WorkingMemorySlot] = {}  # Verbal
        self.visuospatial_sketchpad: Dict[str, WorkingMemorySlot] = {}  # Spatial
        self.episodic_buffer: Dict[str, WorkingMemorySlot] = {}  # Integrated
        
        # Central executive
        self.executive = CentralExecutive(executive_id=f"CE-{self.system_id}")
        
        # Statistics
        self.total_stored = 0
        self.total_decayed = 0
        self.total_consolidated = 0
    
    def encode(
        self,
        content: Any,
        content_type: str = "verbal",
        attention_weight: float = 1.0,
    ) -> Optional[WorkingMemorySlot]:
        """
        Encode new information into working memory.
        
        Returns the slot if successful, None if capacity exceeded.
        """
        # Select appropriate buffer
        if content_type in ["verbal", "acoustic", "phonological"]:
            buffer = self.phonological_loop
        elif content_type in ["spatial", "visual", "object"]:
            buffer = self.visuospatial_sketchpad
        else:
            buffer = self.episodic_buffer
        
        # Check capacity
        if len(buffer) >= self.capacity:
            # Try to evict weakest slot
            weakest = self._find_weakest_slot(buffer)
            if weakest and weakest.effective_strength < attention_weight:
                del buffer[weakest.slot_id]
                self.total_decayed += 1
            else:
                return None  # Cannot encode — capacity full
        
        # Create slot
        slot = WorkingMemorySlot(
            slot_id=f"WM-{uuid.uuid4().hex[:12].upper()}",
            content=content,
            content_type=content_type,
            attention_weight=attention_weight,
            decay_rate=self.decay_rate,
        )
        
        buffer[slot.slot_id] = slot
        self.total_stored += 1
        
        # Allocate attention
        self.executive.allocate_attention([slot.slot_id], attention_weight)
        
        return slot
    
    def retrieve(self, slot_id: str) -> Optional[WorkingMemorySlot]:
        """Retrieve and refresh a slot."""
        for buffer in [self.phonological_loop, self.visuospatial_sketchpad, self.episodic_buffer]:
            if slot_id in buffer:
                slot = buffer[slot_id]
                slot.refresh()
                return slot
        return None
    
    def rehearse(self, slot_ids: Optional[List[str]] = None) -> int:
        """
        Rehearse (refresh) slots to prevent decay.
        
        If no slot_ids provided, rehearses all currently focused slots.
        Returns number of slots refreshed.
        """
        if slot_ids is None:
            slot_ids = self.executive.focused_slots
        
        refreshed = 0
        for buffer in [self.phonological_loop, self.visuospatial_sketchpad, self.episodic_buffer]:
            for sid in slot_ids:
                if sid in buffer:
                    buffer[sid].refresh()
                    refreshed += 1
        
        return refreshed
    
    def bind(self, slot_ids: List[str], binding_strength: float = 1.0) -> bool:
        """
        Create binding between slots (feature binding).
        
        This is how the brain combines separate features into unified objects.
        """
        slots = []
        for buffer in [self.phonological_loop, self.visuospatial_sketchpad, self.episodic_buffer]:
            for sid in slot_ids:
                if sid in buffer:
                    slots.append(buffer[sid])
        
        if len(slots) < 2:
            return False
        
        # Create mutual bindings
        for slot in slots:
            for other_slot in slots:
                if slot.slot_id != other_slot.slot_id:
                    if other_slot.slot_id not in slot.bindings:
                        slot.bindings.append(other_slot.slot_id)
                    slot.binding_strength = max(slot.binding_strength, binding_strength)
        
        self.executive.binding_active = True
        return True
    
    def integrate_to_episodic_buffer(self, slot_ids: List[str]) -> Optional[WorkingMemorySlot]:
        """
        Integrate multiple slots into the episodic buffer.
        
        This creates a unified representation from multiple sources.
        """
        content_parts = []
        for buffer in [self.phonological_loop, self.visuospatial_sketchpad]:
            for sid in slot_ids:
                if sid in buffer:
                    content_parts.append({
                        "source": sid,
                        "type": buffer[sid].content_type,
                        "content": buffer[sid].content,
                    })
        
        if not content_parts:
            return None
        
        # Create integrated slot
        integrated = WorkingMemorySlot(
            slot_id=f"WM-INT-{uuid.uuid4().hex[:8].upper()}",
            content={"integrated": content_parts},
            content_type="integrated",
            bindings=slot_ids,
        )
        
        self.episodic_buffer[integrated.slot_id] = integrated
        return integrated
    
    def decay_cycle(self) -> List[str]:
        """
        Run decay cycle — remove slots that have decayed below threshold.
        
        Returns list of decayed slot IDs.
        """
        decayed = []
        threshold = 0.1
        
        for buffer in [self.phonological_loop, self.visuospatial_sketchpad, self.episodic_buffer]:
            to_remove = []
            for sid, slot in buffer.items():
                if slot.effective_strength < threshold:
                    to_remove.append(sid)
                    decayed.append(sid)
            
            for sid in to_remove:
                del buffer[sid]
                self.executive.release_attention([sid])
        
        self.total_decayed += len(decayed)
        return decayed
    
    def prepare_for_consolidation(self) -> List[WorkingMemorySlot]:
        """
        Identify slots ready for consolidation to long-term memory.
        
        Slots with high refresh count and strength are candidates.
        """
        candidates = []
        threshold_refresh = 3
        threshold_strength = 0.7
        
        for buffer in [self.phonological_loop, self.visuospatial_sketchpad, self.episodic_buffer]:
            for slot in buffer.values():
                if slot.refresh_count >= threshold_refresh and slot.effective_strength >= threshold_strength:
                    candidates.append(slot)
        
        return candidates
    
    def _find_weakest_slot(self, buffer: Dict[str, WorkingMemorySlot]) -> Optional[WorkingMemorySlot]:
        """Find the weakest slot in a buffer."""
        if not buffer:
            return None
        return min(buffer.values(), key=lambda s: s.effective_strength)
    
    def get_status(self) -> Dict[str, Any]:
        """Get working memory status."""
        return {
            "system_id": self.system_id,
            "frequency": self.frequency,
            "protocol": self.protocol,
            "capacity": self.capacity,
            "phonological_loop_count": len(self.phonological_loop),
            "visuospatial_sketchpad_count": len(self.visuospatial_sketchpad),
            "episodic_buffer_count": len(self.episodic_buffer),
            "total_active": (
                len(self.phonological_loop) +
                len(self.visuospatial_sketchpad) +
                len(self.episodic_buffer)
            ),
            "executive_available_capacity": self.executive.available_capacity,
            "executive_focused_slots": len(self.executive.focused_slots),
            "total_stored": self.total_stored,
            "total_decayed": self.total_decayed,
            "total_consolidated": self.total_consolidated,
        }


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# EXPORTS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

# Import submodules
from .hippocampus import HippocampalSystem, PlaceCell, GridCell, TimeCell
from .basal_ganglia import BasalGangliaSystem, ProceduralSkill, HabitFormation
from .hive_memory import HiveMemorySystem, HiveNode, ConsensusProtocol
from .animal_synthesis import AnimalBrainSynthesizer, BrainRegion, MemoryModality

__all__ = [
    # Constants
    "PHI",
    "PHI_15",
    "FIBONACCI",
    "SOLFEGGIO",
    
    # Enums
    "MemoryHierarchy",
    "MemoryState",
    "AnimalBrainSource",
    
    # Working Memory
    "WorkingMemorySlot",
    "CentralExecutive",
    "WorkingMemorySystem",
    
    # Hippocampus (from submodule)
    "HippocampalSystem",
    "PlaceCell",
    "GridCell",
    "TimeCell",
    
    # Basal Ganglia (from submodule)
    "BasalGangliaSystem",
    "ProceduralSkill",
    "HabitFormation",
    
    # Hive Memory (from submodule)
    "HiveMemorySystem",
    "HiveNode",
    "ConsensusProtocol",
    
    # Animal Synthesis (from submodule)
    "AnimalBrainSynthesizer",
    "BrainRegion",
    "MemoryModality",
]
