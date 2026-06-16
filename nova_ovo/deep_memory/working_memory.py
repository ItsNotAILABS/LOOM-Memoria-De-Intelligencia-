"""
WORKING MEMORY SYSTEM — Prefrontal Cortex Model
PROT-485: MEMORIA OPERATIVA

φ = 1.6180339887498948482
Traces to primitive: MEMORY → FIELD → ADDRESS → RELATION

The working memory system models the prefrontal cortex's role in
maintaining active information, executive control, and attention gating.
Like the biological PFC, it maintains a limited capacity buffer that
integrates sensory input with long-term memory retrievals.

(c) 2024-2025 Alfredo "Freddy" Medina Hernandez — Medina Tech, Dallas TX
License: ISIL-1.0
"""

from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any, Callable
from enum import Enum
import math
import time
from collections import deque

# ═══════════════════════════════════════════════════════════════════════════════
# MATHEMATICAL CONSTANTS — The Substrate
# ═══════════════════════════════════════════════════════════════════════════════

PHI = 1.6180339887498948482
PHI_SQUARED = 2.6180339887498948482
PHI_INVERSE = 0.6180339887498948482
WORKING_MEMORY_FREQ = PHI ** 8  # 46.98 Hz — Gamma band (cognitive processing)

# Miller's Law: 7 ± 2 items — we use φ-based capacity
WORKING_MEMORY_CAPACITY = int(PHI ** 4)  # 7 items (6.854 rounded)
ATTENTION_DECAY_RATE = 1.0 / PHI  # Golden ratio decay
REHEARSAL_BOOST = PHI_INVERSE  # Rehearsal strengthens by φ⁻¹


class AttentionGate(Enum):
    """Attention gating mechanisms based on PFC function."""
    OPEN = "open"           # Full attention - new information enters
    PARTIAL = "partial"     # Selective attention - filtered entry
    CLOSED = "closed"       # Maintenance mode - protect active contents
    REFRESH = "refresh"     # Active refreshing of existing contents


class WorkingMemoryType(Enum):
    """Types of working memory subsystems (Baddeley model extended)."""
    PHONOLOGICAL = "phonological"     # Verbal/acoustic information
    VISUOSPATIAL = "visuospatial"     # Visual and spatial information
    EPISODIC = "episodic"             # Integrated episodes, binding
    CENTRAL_EXECUTIVE = "executive"    # Control and coordination


@dataclass
class WorkingMemoryItem:
    """
    An item held in working memory.
    
    Each item has activation strength that decays over time unless
    rehearsed or attended to. Items compete for limited capacity.
    """
    content: Any
    item_type: WorkingMemoryType
    activation: float = 1.0
    created_at: float = field(default_factory=time.time)
    last_accessed: float = field(default_factory=time.time)
    access_count: int = 1
    binding_ids: List[str] = field(default_factory=list)
    source: str = "input"  # input, retrieval, generation
    
    def decay(self, current_time: float) -> float:
        """Apply temporal decay to activation using golden ratio."""
        time_delta = current_time - self.last_accessed
        decay_factor = math.exp(-ATTENTION_DECAY_RATE * time_delta)
        self.activation *= decay_factor
        return self.activation
    
    def rehearse(self) -> float:
        """Strengthen item through rehearsal (like subvocal repetition)."""
        self.activation = min(1.0, self.activation + REHEARSAL_BOOST)
        self.last_accessed = time.time()
        self.access_count += 1
        return self.activation
    
    def bind_to(self, other_id: str) -> None:
        """Create episodic binding between items."""
        if other_id not in self.binding_ids:
            self.binding_ids.append(other_id)


@dataclass
class AttentionFocus:
    """
    The current focus of attention within working memory.
    
    Models the spotlight/zoom lens metaphor of attention.
    """
    target_ids: List[str] = field(default_factory=list)
    intensity: float = 1.0  # 0.0 = diffuse, 1.0 = focused
    breadth: float = PHI_INVERSE  # Width of attention (inverse of items)
    gate_state: AttentionGate = AttentionGate.OPEN


class PrefrontalCortexModel:
    """
    Model of prefrontal cortex executive functions.
    
    The PFC coordinates working memory maintenance, manipulation,
    and the gating of information flow. This model implements:
    - Active maintenance of goal-relevant information
    - Gating mechanisms for selective updating
    - Inhibitory control over irrelevant information
    - Task switching and cognitive flexibility
    """
    
    def __init__(self, organism_id: str = "default"):
        self.organism_id = organism_id
        self.current_goal: Optional[str] = None
        self.goal_hierarchy: List[str] = []
        self.inhibition_strength: float = PHI_INVERSE
        self.flexibility_index: float = 0.5
        self.conflict_monitor: float = 0.0
        self._rule_set: Dict[str, Callable] = {}
        
    def set_goal(self, goal: str, priority: int = 0) -> None:
        """Set current goal, managing goal hierarchy."""
        if priority == 0:
            self.current_goal = goal
            if goal not in self.goal_hierarchy:
                self.goal_hierarchy.insert(0, goal)
        else:
            if goal not in self.goal_hierarchy:
                self.goal_hierarchy.insert(min(priority, len(self.goal_hierarchy)), goal)
    
    def evaluate_relevance(self, item: WorkingMemoryItem) -> float:
        """Evaluate item relevance to current goal."""
        if not self.current_goal:
            return 0.5  # Neutral relevance without goal
        
        # Simple relevance based on type and goal
        base_relevance = item.activation
        
        # Executive items always relevant
        if item.item_type == WorkingMemoryType.CENTRAL_EXECUTIVE:
            return min(1.0, base_relevance * PHI)
        
        return base_relevance
    
    def should_gate(self, item: WorkingMemoryItem, current_contents: int) -> AttentionGate:
        """Determine gating decision for new item."""
        relevance = self.evaluate_relevance(item)
        
        # High conflict = close gate for maintenance
        if self.conflict_monitor > PHI_INVERSE:
            return AttentionGate.CLOSED
        
        # Near capacity = selective gating
        if current_contents >= WORKING_MEMORY_CAPACITY - 1:
            if relevance > PHI_INVERSE:
                return AttentionGate.PARTIAL
            return AttentionGate.CLOSED
        
        # Low load = open gate
        if relevance > 0.3:
            return AttentionGate.OPEN
        
        return AttentionGate.PARTIAL
    
    def inhibit(self, item: WorkingMemoryItem) -> float:
        """Apply inhibitory control to reduce item activation."""
        suppression = self.inhibition_strength * (1.0 - self.evaluate_relevance(item))
        item.activation = max(0.0, item.activation - suppression)
        return item.activation
    
    def detect_conflict(self, items: List[WorkingMemoryItem]) -> float:
        """Detect cognitive conflict between active items."""
        if len(items) < 2:
            return 0.0
        
        # Simplified conflict detection based on competing activations
        activations = [item.activation for item in items]
        max_act = max(activations)
        second_max = sorted(activations)[-2] if len(activations) > 1 else 0
        
        # High conflict when two items have similar high activation
        self.conflict_monitor = second_max / max_act if max_act > 0 else 0
        return self.conflict_monitor


class WorkingMemorySystem:
    """
    Complete Working Memory System with biological inspiration.
    
    Implements a multi-component model based on Baddeley's working memory
    framework, enhanced with neural-inspired activation dynamics and
    golden ratio mathematics.
    
    Components:
    - Phonological Loop: Verbal/acoustic rehearsal buffer
    - Visuospatial Sketchpad: Visual and spatial buffer
    - Episodic Buffer: Integration and binding
    - Central Executive: Attention control (PFC model)
    
    φ-Based Design:
    - Capacity = φ⁴ ≈ 7 items (Miller's Law emergence)
    - Decay rate = 1/φ (golden ratio temporal dynamics)
    - Rehearsal boost = φ⁻¹ (balanced strengthening)
    """
    
    def __init__(self, organism_id: str = "default"):
        self.organism_id = organism_id
        self.frequency = WORKING_MEMORY_FREQ
        
        # Multi-component buffers
        self.phonological_loop: Dict[str, WorkingMemoryItem] = {}
        self.visuospatial_sketchpad: Dict[str, WorkingMemoryItem] = {}
        self.episodic_buffer: Dict[str, WorkingMemoryItem] = {}
        
        # Central Executive (PFC model)
        self.executive = PrefrontalCortexModel(organism_id)
        
        # Attention state
        self.attention = AttentionFocus()
        
        # Recent access history for recency effects
        self._access_history: deque = deque(maxlen=int(WORKING_MEMORY_CAPACITY * PHI))
        
        # Statistics
        self._total_items_processed: int = 0
        self._total_retrievals: int = 0
        self._capacity_overflows: int = 0
    
    def _get_buffer(self, item_type: WorkingMemoryType) -> Dict[str, WorkingMemoryItem]:
        """Get appropriate buffer for item type."""
        if item_type == WorkingMemoryType.PHONOLOGICAL:
            return self.phonological_loop
        elif item_type == WorkingMemoryType.VISUOSPATIAL:
            return self.visuospatial_sketchpad
        else:  # EPISODIC and EXECUTIVE go to episodic buffer
            return self.episodic_buffer
    
    def _generate_item_id(self) -> str:
        """Generate unique item ID using golden ratio timestamp."""
        timestamp = time.time()
        phi_component = int((timestamp * PHI) % 1000000)
        return f"wm_{self.organism_id}_{phi_component}"
    
    def _apply_global_decay(self) -> None:
        """Apply decay to all items in all buffers."""
        current_time = time.time()
        
        for buffer in [self.phonological_loop, self.visuospatial_sketchpad, self.episodic_buffer]:
            items_to_remove = []
            for item_id, item in buffer.items():
                item.decay(current_time)
                if item.activation < 0.1:  # Below threshold
                    items_to_remove.append(item_id)
            
            for item_id in items_to_remove:
                del buffer[item_id]
    
    def _enforce_capacity(self, buffer: Dict[str, WorkingMemoryItem]) -> None:
        """Enforce capacity limit using activation-based competition."""
        while len(buffer) > WORKING_MEMORY_CAPACITY:
            # Find lowest activation item
            min_item_id = min(buffer.keys(), key=lambda k: buffer[k].activation)
            del buffer[min_item_id]
            self._capacity_overflows += 1
    
    def encode(self, content: Any, item_type: WorkingMemoryType = WorkingMemoryType.EPISODIC,
               source: str = "input") -> str:
        """
        Encode new item into working memory.
        
        The encoding process:
        1. Apply global decay to existing items
        2. Evaluate gating decision via PFC
        3. If gated in, add to appropriate buffer
        4. Enforce capacity limits through competition
        """
        self._apply_global_decay()
        
        # Create new item
        item = WorkingMemoryItem(
            content=content,
            item_type=item_type,
            source=source
        )
        
        # Get target buffer
        buffer = self._get_buffer(item_type)
        
        # Evaluate gating
        gate_decision = self.executive.should_gate(item, len(buffer))
        
        if gate_decision == AttentionGate.CLOSED:
            return ""  # Item not encoded
        
        if gate_decision == AttentionGate.PARTIAL:
            item.activation *= PHI_INVERSE  # Reduced initial activation
        
        # Generate ID and store
        item_id = self._generate_item_id()
        buffer[item_id] = item
        
        # Update access history
        self._access_history.append(item_id)
        
        # Enforce capacity
        self._enforce_capacity(buffer)
        
        self._total_items_processed += 1
        
        return item_id
    
    def retrieve(self, item_id: str) -> Optional[WorkingMemoryItem]:
        """Retrieve item from working memory, boosting its activation."""
        for buffer in [self.phonological_loop, self.visuospatial_sketchpad, self.episodic_buffer]:
            if item_id in buffer:
                item = buffer[item_id]
                item.rehearse()  # Retrieval strengthens item
                self._access_history.append(item_id)
                self._total_retrievals += 1
                return item
        return None
    
    def search(self, query: Callable[[WorkingMemoryItem], bool]) -> List[str]:
        """Search all buffers for items matching query function."""
        results = []
        for buffer in [self.phonological_loop, self.visuospatial_sketchpad, self.episodic_buffer]:
            for item_id, item in buffer.items():
                if query(item):
                    results.append(item_id)
        return results
    
    def focus_attention(self, item_ids: List[str], intensity: float = 1.0) -> None:
        """Direct attention to specific items, boosting their activation."""
        self.attention.target_ids = item_ids
        self.attention.intensity = intensity
        
        for item_id in item_ids:
            item = self.retrieve(item_id)
            if item:
                # Attention boost proportional to intensity
                item.activation = min(1.0, item.activation + (intensity * REHEARSAL_BOOST))
    
    def rehearse_all(self) -> int:
        """Rehearse all items in phonological loop (subvocal rehearsal)."""
        rehearsed = 0
        for item in self.phonological_loop.values():
            item.rehearse()
            rehearsed += 1
        return rehearsed
    
    def bind_items(self, item_ids: List[str]) -> bool:
        """Create episodic binding between items (episodic buffer function)."""
        if len(item_ids) < 2:
            return False
        
        items = [self.retrieve(item_id) for item_id in item_ids]
        items = [item for item in items if item is not None]
        
        if len(items) < 2:
            return False
        
        # Create mutual bindings
        for i, item_id in enumerate(item_ids):
            item = items[i] if i < len(items) else None
            if item:
                for other_id in item_ids:
                    if other_id != item_id:
                        item.bind_to(other_id)
        
        return True
    
    def get_active_contents(self) -> Dict[str, List[WorkingMemoryItem]]:
        """Get all currently active items organized by buffer."""
        return {
            "phonological": list(self.phonological_loop.values()),
            "visuospatial": list(self.visuospatial_sketchpad.values()),
            "episodic": list(self.episodic_buffer.values())
        }
    
    def get_total_load(self) -> int:
        """Get total number of items across all buffers."""
        return (len(self.phonological_loop) + 
                len(self.visuospatial_sketchpad) + 
                len(self.episodic_buffer))
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get working memory statistics."""
        return {
            "organism_id": self.organism_id,
            "frequency_hz": self.frequency,
            "total_load": self.get_total_load(),
            "capacity": WORKING_MEMORY_CAPACITY,
            "phonological_count": len(self.phonological_loop),
            "visuospatial_count": len(self.visuospatial_sketchpad),
            "episodic_count": len(self.episodic_buffer),
            "total_processed": self._total_items_processed,
            "total_retrievals": self._total_retrievals,
            "capacity_overflows": self._capacity_overflows,
            "current_goal": self.executive.current_goal,
            "attention_gate": self.attention.gate_state.value
        }
    
    def clear(self) -> None:
        """Clear all working memory contents (like distraction or task switch)."""
        self.phonological_loop.clear()
        self.visuospatial_sketchpad.clear()
        self.episodic_buffer.clear()
        self._access_history.clear()
        self.attention = AttentionFocus()


# ═══════════════════════════════════════════════════════════════════════════════
# EXPORT INTERFACE
# ═══════════════════════════════════════════════════════════════════════════════

__all__ = [
    'WorkingMemorySystem',
    'PrefrontalCortexModel', 
    'WorkingMemoryItem',
    'WorkingMemoryType',
    'AttentionGate',
    'AttentionFocus',
    'PHI', 'PHI_SQUARED', 'PHI_INVERSE',
    'WORKING_MEMORY_FREQ',
    'WORKING_MEMORY_CAPACITY'
]
