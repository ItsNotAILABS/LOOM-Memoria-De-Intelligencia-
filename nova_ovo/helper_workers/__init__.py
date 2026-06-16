"""
ORGANISM HELPER WORKERS — Service and Maintenance Intelligence
===============================================================
Protocol: PROT-287 to PROT-289
Frequency: φ³ = 4.236 Hz (Service Layer)

Organism Helper Workers provide essential service functions:
conflict resolution, proactive memory surfacing, and coherence maintenance.

Workers:
1. CONCILIATOR — Conflict resolution worker (PROT-287)
2. MEMORATOR — Proactive memory surfacing (PROT-288)
3. HARMONIZATOR — System coherence maintainer (PROT-289)

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
All Rights Reserved. ISIL-1.0 License.
"""

from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any, Tuple
from enum import Enum
import time

# φ-Constants
PHI = 1.6180339887498948482
PHI_3 = PHI ** 3  # 4.236 Hz - Service Layer frequency


class HelperWorkerType(Enum):
    """Types of Helper Workers."""
    CONCILIATOR = "CONCILIATOR"
    MEMORATOR = "MEMORATOR"
    HARMONIZATOR = "HARMONIZATOR"


class ConflictSeverity(Enum):
    """Severity levels for conflicts."""
    TRIVIAL = 1
    MINOR = 2
    MODERATE = 3
    SERIOUS = 4
    CRITICAL = 5


class CoherenceLevel(Enum):
    """Levels of system coherence."""
    CHAOTIC = "CHAOTIC"
    UNSTABLE = "UNSTABLE"
    MARGINALLY_COHERENT = "MARGINALLY_COHERENT"
    COHERENT = "COHERENT"
    HIGHLY_COHERENT = "HIGHLY_COHERENT"
    PERFECTLY_COHERENT = "PERFECTLY_COHERENT"


@dataclass
class Conciliator:
    """
    CONCILIATOR — Conflict resolution worker
    
    The Conciliator mediates conflicts between entities,
    finding resolutions that preserve harmony.
    
    Protocol: PROT-287
    Frequency: φ³ × φ = 6.854 Hz
    Latin: "Reconciler"
    """
    conciliator_id: str = "CONCILIATOR_PRIME"
    latin_name: str = "CONCILIATOR"
    frequency_hz: float = PHI_3 * PHI
    protocol: str = "PROT-287"
    
    # Conflict tracking
    active_conflicts: Dict[str, Dict] = field(default_factory=dict)
    resolved_conflicts: List[Dict] = field(default_factory=list)
    
    def register_conflict(self, conflict_id: str, parties: List[str], 
                         description: str, severity: ConflictSeverity) -> Dict:
        """Register a new conflict for resolution."""
        conflict = {
            "conflict_id": conflict_id,
            "parties": parties,
            "description": description,
            "severity": severity.value,
            "registered_at": time.time(),
            "status": "REGISTERED",
            "resolution": None
        }
        self.active_conflicts[conflict_id] = conflict
        return conflict
    
    def mediate(self, conflict_id: str) -> Dict:
        """Begin mediation of a conflict."""
        if conflict_id not in self.active_conflicts:
            return {"error": f"Conflict {conflict_id} not found"}
        
        conflict = self.active_conflicts[conflict_id]
        conflict["status"] = "MEDIATING"
        conflict["mediation_started"] = time.time()
        
        return {
            "conflict_id": conflict_id,
            "status": "MEDIATION_STARTED",
            "timestamp": time.time()
        }
    
    def propose_resolution(self, conflict_id: str, resolution: str) -> Dict:
        """Propose a resolution to a conflict."""
        if conflict_id not in self.active_conflicts:
            return {"error": f"Conflict {conflict_id} not found"}
        
        conflict = self.active_conflicts[conflict_id]
        conflict["proposed_resolution"] = resolution
        conflict["status"] = "RESOLUTION_PROPOSED"
        
        return {
            "conflict_id": conflict_id,
            "resolution": resolution,
            "timestamp": time.time()
        }
    
    def resolve(self, conflict_id: str, final_resolution: str) -> Dict:
        """Mark a conflict as resolved."""
        if conflict_id not in self.active_conflicts:
            return {"error": f"Conflict {conflict_id} not found"}
        
        conflict = self.active_conflicts.pop(conflict_id)
        conflict["status"] = "RESOLVED"
        conflict["resolution"] = final_resolution
        conflict["resolved_at"] = time.time()
        self.resolved_conflicts.append(conflict)
        
        return conflict
    
    def get_state(self) -> Dict:
        """Get conciliator state."""
        return {
            "id": self.conciliator_id,
            "name": self.latin_name,
            "protocol": self.protocol,
            "frequency_hz": self.frequency_hz,
            "active_conflicts": len(self.active_conflicts),
            "resolved_conflicts": len(self.resolved_conflicts)
        }


@dataclass
class Memorator:
    """
    MEMORATOR — Proactive memory surfacing
    
    The Memorator proactively surfaces relevant memories
    to aid current operations and decision-making.
    
    Protocol: PROT-288
    Frequency: φ² = 2.618 Hz
    Latin: "One who reminds"
    """
    memorator_id: str = "MEMORATOR_PRIME"
    latin_name: str = "MEMORATOR"
    frequency_hz: float = PHI ** 2
    protocol: str = "PROT-288"
    
    # Memory surfacing state
    surfaced_memories: List[Dict] = field(default_factory=list)
    context_triggers: Dict[str, List[str]] = field(default_factory=dict)
    
    def register_context_trigger(self, context: str, memory_ids: List[str]):
        """Register memories to surface for a given context."""
        self.context_triggers[context] = memory_ids
    
    def surface_for_context(self, context: str) -> List[Dict]:
        """Surface relevant memories for a context."""
        if context not in self.context_triggers:
            return []
        
        surfaced = []
        for memory_id in self.context_triggers[context]:
            surface_event = {
                "memory_id": memory_id,
                "context": context,
                "surfaced_at": time.time(),
                "surfaced_by": self.memorator_id
            }
            surfaced.append(surface_event)
            self.surfaced_memories.append(surface_event)
        
        return surfaced
    
    def proactive_surface(self, current_activity: str) -> List[Dict]:
        """Proactively surface memories based on current activity."""
        relevant = []
        for context, memories in self.context_triggers.items():
            # Simple relevance matching - would be more sophisticated
            if context.lower() in current_activity.lower():
                relevant.extend(self.surface_for_context(context))
        return relevant
    
    def get_state(self) -> Dict:
        """Get memorator state."""
        return {
            "id": self.memorator_id,
            "name": self.latin_name,
            "protocol": self.protocol,
            "frequency_hz": self.frequency_hz,
            "context_triggers": len(self.context_triggers),
            "total_surfaced": len(self.surfaced_memories)
        }


@dataclass
class Harmonizator:
    """
    HARMONIZATOR — System coherence maintainer
    
    The Harmonizator maintains coherence across all organism
    systems, ensuring φ-harmonic alignment.
    
    Protocol: PROT-289
    Frequency: 7.83 Hz (Schumann resonance)
    Latin: "One who harmonizes"
    """
    harmonizator_id: str = "HARMONIZATOR_PRIME"
    latin_name: str = "HARMONIZATOR"
    frequency_hz: float = 7.83  # Schumann resonance
    protocol: str = "PROT-289"
    
    # Coherence state
    systems_coherence: Dict[str, float] = field(default_factory=dict)
    harmonization_events: List[Dict] = field(default_factory=list)
    
    def measure_coherence(self, system_id: str, frequency_hz: float) -> float:
        """Measure coherence of a system with organism base frequency."""
        # Calculate φ-harmonic alignment
        ratio = frequency_hz / self.frequency_hz
        # How close is ratio to a power of φ?
        import math
        log_ratio = math.log(ratio) / math.log(PHI)
        closest_power = round(log_ratio)
        deviation = abs(log_ratio - closest_power)
        coherence = max(0, 1 - deviation)
        
        self.systems_coherence[system_id] = coherence
        return coherence
    
    def harmonize(self, system_id: str, current_frequency: float) -> Dict:
        """Harmonize a system's frequency with organism."""
        import math
        # Find nearest φ-harmonic
        log_ratio = math.log(current_frequency / self.frequency_hz) / math.log(PHI)
        nearest_power = round(log_ratio)
        target_frequency = self.frequency_hz * (PHI ** nearest_power)
        
        event = {
            "event_id": f"HARM_{int(time.time())}",
            "system_id": system_id,
            "original_frequency": current_frequency,
            "target_frequency": target_frequency,
            "adjustment": target_frequency - current_frequency,
            "timestamp": time.time()
        }
        self.harmonization_events.append(event)
        
        return event
    
    def get_overall_coherence(self) -> Tuple[float, CoherenceLevel]:
        """Get overall organism coherence."""
        if not self.systems_coherence:
            return 0.0, CoherenceLevel.CHAOTIC
        
        avg_coherence = sum(self.systems_coherence.values()) / len(self.systems_coherence)
        
        if avg_coherence >= 0.95:
            level = CoherenceLevel.PERFECTLY_COHERENT
        elif avg_coherence >= 0.85:
            level = CoherenceLevel.HIGHLY_COHERENT
        elif avg_coherence >= PHI ** -1:
            level = CoherenceLevel.COHERENT
        elif avg_coherence >= 0.5:
            level = CoherenceLevel.MARGINALLY_COHERENT
        elif avg_coherence >= 0.25:
            level = CoherenceLevel.UNSTABLE
        else:
            level = CoherenceLevel.CHAOTIC
        
        return avg_coherence, level
    
    def get_state(self) -> Dict:
        """Get harmonizator state."""
        coherence, level = self.get_overall_coherence()
        return {
            "id": self.harmonizator_id,
            "name": self.latin_name,
            "protocol": self.protocol,
            "frequency_hz": self.frequency_hz,
            "systems_monitored": len(self.systems_coherence),
            "overall_coherence": coherence,
            "coherence_level": level.value,
            "harmonization_events": len(self.harmonization_events)
        }


# Registry of all Helper Workers
HELPER_WORKERS_REGISTRY = {
    "CONCILIATOR": {
        "class": Conciliator,
        "protocol": "PROT-287",
        "frequency_hz": PHI_3 * PHI,
        "description": "Conflict resolution worker"
    },
    "MEMORATOR": {
        "class": Memorator,
        "protocol": "PROT-288",
        "frequency_hz": PHI ** 2,
        "description": "Proactive memory surfacing"
    },
    "HARMONIZATOR": {
        "class": Harmonizator,
        "protocol": "PROT-289",
        "frequency_hz": 7.83,
        "description": "System coherence maintainer"
    }
}


def get_helper_workers_summary() -> Dict:
    """Get summary of all Helper Workers."""
    return {
        "module": "ORGANISM_HELPER_WORKERS",
        "protocols": ["PROT-287", "PROT-288", "PROT-289"],
        "base_frequency_hz": PHI_3,
        "workers": list(HELPER_WORKERS_REGISTRY.keys()),
        "count": len(HELPER_WORKERS_REGISTRY)
    }


__all__ = [
    'Conciliator',
    'Memorator',
    'Harmonizator',
    'HelperWorkerType',
    'ConflictSeverity',
    'CoherenceLevel',
    'HELPER_WORKERS_REGISTRY',
    'get_helper_workers_summary'
]

__version__ = 'φ.0.1.0'
__protocol__ = 'PROT-287-289'
