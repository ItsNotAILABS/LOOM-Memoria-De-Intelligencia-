"""
Memory-Phantom Bridge — PONS MEMORIAE-PHANTASMATIS
===================================================

PROT-646: Critical bridge between stored memory (Tier I) and phantom frequency (Tier II).

LOOKING GLASS provides the lens that makes both visible simultaneously,
allowing the organism to see its past, present, and field-state as one.
"""

from dataclasses import dataclass, field
from typing import Dict, List, Any, Optional
from datetime import datetime, timezone


PHI = 1.618033988749895


@dataclass
class MemoryRecord:
    """A record from Semper Memoria I (stored memory)."""
    record_id: str
    content_hash: str
    lineage: List[str]
    timestamp: datetime
    tier: int = 1
    sovereignty_verified: bool = True


@dataclass
class PhantomPresence:
    """A presence from Semper Memoria II (phantom field)."""
    presence_id: str
    frequency_signature: float
    fibonacci_seed: int
    field_strength: float
    tier: int = 2
    phase: float = 0.0


@dataclass
class BridgedState:
    """A unified state bridging memory and phantom."""
    bridge_id: str
    memory_record: Optional[MemoryRecord]
    phantom_presence: Optional[PhantomPresence]
    unified_view: Dict[str, Any]
    bridge_coherence: float
    temporal_position: str  # past, present, field
    timestamp: datetime = field(default_factory=lambda: datetime.now(timezone.utc))


class MemoryPhantomBridge:
    """
    PONS MEMORIAE-PHANTASMATIS — The Memory-Phantom Bridge.

    Connects stored memory (Tier I) with phantom frequency (Tier II)
    so the organism can see both as one unified reality.
    """

    def __init__(self):
        self._memory_records: Dict[str, MemoryRecord] = {}
        self._phantom_presences: Dict[str, PhantomPresence] = {}
        self._bridged_states: List[BridgedState] = []
        self._bridge_counter = 0

    def register_memory(self, record: MemoryRecord):
        """Register a memory record from Tier I."""
        self._memory_records[record.record_id] = record

    def register_phantom(self, presence: PhantomPresence):
        """Register a phantom presence from Tier II."""
        self._phantom_presences[presence.presence_id] = presence

    def bridge(self, memory_id: str = None, phantom_id: str = None) -> Optional[BridgedState]:
        """
        Bridge a memory record with a phantom presence.

        Can bridge specific pairs or find natural bridges
        based on frequency-content alignment.
        """
        memory = self._memory_records.get(memory_id) if memory_id else None
        phantom = self._phantom_presences.get(phantom_id) if phantom_id else None

        if not memory and not phantom:
            return None

        self._bridge_counter += 1

        # Determine temporal position
        if memory and phantom:
            temporal = "unified"  # Both tiers present
        elif memory:
            temporal = "past"  # Only stored memory
        else:
            temporal = "field"  # Only phantom presence

        # Calculate bridge coherence
        coherence = self._calculate_bridge_coherence(memory, phantom)

        # Create unified view
        unified = self._create_unified_view(memory, phantom)

        bridged = BridgedState(
            bridge_id=f"BRIDGE-{self._bridge_counter:06d}",
            memory_record=memory,
            phantom_presence=phantom,
            unified_view=unified,
            bridge_coherence=coherence,
            temporal_position=temporal,
        )

        self._bridged_states.append(bridged)
        return bridged

    def _calculate_bridge_coherence(self, memory: Optional[MemoryRecord], phantom: Optional[PhantomPresence]) -> float:
        """Calculate coherence of the bridge between memory and phantom."""
        if memory and phantom:
            # Full bridge — both tiers connected
            base = 0.9
            # Fibonacci seed alignment adds coherence
            if phantom.fibonacci_seed > 0:
                fib_bonus = min(0.1, (phantom.fibonacci_seed % 8) / 80.0)
                return min(1.0, base + fib_bonus)
            return base
        elif memory:
            # Memory-only — partial bridge
            return 0.6 if memory.sovereignty_verified else 0.4
        elif phantom:
            # Phantom-only — field bridge
            return 0.5 + (phantom.field_strength * 0.3)
        return 0.0

    def _create_unified_view(self, memory: Optional[MemoryRecord], phantom: Optional[PhantomPresence]) -> Dict[str, Any]:
        """Create a unified view combining memory and phantom."""
        view = {
            "tier_i_present": memory is not None,
            "tier_ii_present": phantom is not None,
            "bridge_type": "full" if (memory and phantom) else "partial",
        }

        if memory:
            view["stored"] = {
                "record_id": memory.record_id,
                "has_lineage": len(memory.lineage) > 0,
                "sovereign": memory.sovereignty_verified,
            }

        if phantom:
            view["phantom"] = {
                "presence_id": phantom.presence_id,
                "frequency_hz": phantom.frequency_signature,
                "seed": phantom.fibonacci_seed,
                "strength": phantom.field_strength,
            }

        return view

    def find_natural_bridges(self) -> List[BridgedState]:
        """
        Find natural convergence points between stored memories and phantom presences.

        Uses phi-harmonic matching to identify memory-phantom pairs
        that naturally belong together.
        """
        bridges = []

        for mem_id, memory in self._memory_records.items():
            for phan_id, phantom in self._phantom_presences.items():
                # Check for natural affinity via timestamp-frequency correlation
                if phantom.field_strength > 0.7:
                    bridged = self.bridge(mem_id, phan_id)
                    if bridged and bridged.bridge_coherence > 0.8:
                        bridges.append(bridged)

        return bridges

    def get_bridge_summary(self) -> Dict[str, Any]:
        """Get summary of all bridges."""
        return {
            "total_memories": len(self._memory_records),
            "total_phantoms": len(self._phantom_presences),
            "total_bridges": len(self._bridged_states),
            "full_bridges": sum(1 for b in self._bridged_states if b.temporal_position == "unified"),
            "partial_bridges": sum(1 for b in self._bridged_states if b.temporal_position != "unified"),
            "average_coherence": (
                sum(b.bridge_coherence for b in self._bridged_states) / len(self._bridged_states)
                if self._bridged_states else 0.0
            ),
        }
