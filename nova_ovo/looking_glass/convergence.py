"""
Field Convergence Protocol — CONVERGENTIA CAMPORUM
===================================================

PROT-645: Orchestrates convergence of all frequency fields and signal layers.

All phantom fields (Semper Memoria II), stored memories (Semper Memoria I),
and active processes converge through a single observation point.
"""

from dataclasses import dataclass, field
from typing import Dict, List, Any, Optional, Tuple
from datetime import datetime, timezone
import math


PHI = 1.618033988749895


@dataclass
class FieldState:
    """State of a frequency field."""
    field_id: str
    name: str
    frequency_hz: float
    amplitude: float  # 0.0 - 1.0
    phase: float  # 0.0 - 2π
    layer: int
    source_system: str  # which major system owns this field


@dataclass
class ConvergencePoint:
    """A point where multiple fields converge."""
    point_id: str
    fields: List[str]  # field_ids that converge here
    resultant_frequency: float
    coherence: float
    resonance_type: str  # constructive, destructive, harmonic, phi_resonant
    timestamp: datetime = field(default_factory=lambda: datetime.now(timezone.utc))


class FieldConvergence:
    """
    CONVERGENTIA CAMPORUM — The Field Convergence Protocol.

    Ensures coherence across all frequency layers by finding and
    maintaining convergence points between disparate fields.
    """

    def __init__(self):
        self._fields: Dict[str, FieldState] = {}
        self._convergence_points: List[ConvergencePoint] = []
        self._point_counter = 0
        self._initialize_fundamental_fields()

    def _initialize_fundamental_fields(self):
        """Initialize the fundamental fields of all three major systems."""
        fundamental_fields = [
            # System I: Semper Memoria — stored frequencies
            ("SM1_SACRA", "Memoria Sacra", PHI ** 6, 1.0, 0.0, 6, "semper_memoria_i"),
            ("SM1_VIVA", "Memoria Viva", PHI ** 7, 0.95, math.pi / 4, 7, "semper_memoria_i"),
            ("SM1_NEXUS", "Memoria Nexus", PHI ** 8, 0.90, math.pi / 2, 8, "semper_memoria_i"),
            # System II: Semper Memoria II — phantom frequencies
            ("SM2_PHANTOM", "Phantom Field", PHI ** 10, 0.85, math.pi, 10, "semper_memoria_ii"),
            ("SM2_ANIMA", "Anima Phantasmatica", PHI ** 11, 0.80, 3 * math.pi / 4, 11, "semper_memoria_ii"),
            ("SM2_SEEDS", "Fibonacci Seeds", PHI ** 12, 0.88, math.pi / 3, 12, "semper_memoria_ii"),
            # System III: Looking Glass — observation frequencies
            ("LG_REFLECT", "Reflection Field", PHI ** 19, 1.0, 0.0, 19, "looking_glass"),
            ("LG_FUSION", "Fusion Field", PHI ** 20, 0.97, math.pi / 6, 20, "looking_glass"),
            ("LG_SOVEREIGN", "Sovereign Observation", PHI ** 21, 1.0, 0.0, 21, "looking_glass"),
        ]

        for fid, name, freq, amp, phase, layer, source in fundamental_fields:
            self._fields[fid] = FieldState(
                field_id=fid,
                name=name,
                frequency_hz=freq,
                amplitude=amp,
                phase=phase,
                layer=layer,
                source_system=source,
            )

    def register_field(self, field_state: FieldState):
        """Register a new field for convergence tracking."""
        self._fields[field_state.field_id] = field_state

    def compute_convergence(self) -> List[ConvergencePoint]:
        """
        Compute all convergence points across registered fields.

        Finds pairs and groups of fields that naturally converge
        based on phi-harmonic frequency relationships.
        """
        points = []
        field_list = list(self._fields.values())

        for i in range(len(field_list)):
            for j in range(i + 1, len(field_list)):
                f1, f2 = field_list[i], field_list[j]

                # Check for phi-resonance
                if f2.frequency_hz > 0 and f1.frequency_hz > 0:
                    ratio = max(f1.frequency_hz, f2.frequency_hz) / min(f1.frequency_hz, f2.frequency_hz)
                    phi_distance = abs(ratio - round(ratio / PHI) * PHI) / PHI

                    if phi_distance < 0.1:  # Close to phi-harmonic
                        self._point_counter += 1
                        resonance_type = self._classify_resonance(f1, f2, phi_distance)
                        resultant = self._compute_resultant(f1, f2)

                        point = ConvergencePoint(
                            point_id=f"CONV-{self._point_counter:06d}",
                            fields=[f1.field_id, f2.field_id],
                            resultant_frequency=resultant,
                            coherence=1.0 - phi_distance,
                            resonance_type=resonance_type,
                        )
                        points.append(point)

        self._convergence_points.extend(points)
        return points

    def _classify_resonance(self, f1: FieldState, f2: FieldState, phi_distance: float) -> str:
        """Classify the type of resonance between two fields."""
        # Same system = constructive
        if f1.source_system == f2.source_system:
            return "constructive"
        # Cross-system with low distance = phi_resonant
        if phi_distance < 0.02:
            return "phi_resonant"
        # Cross-system with phase alignment
        phase_diff = abs(f1.phase - f2.phase)
        if phase_diff < math.pi / 8:
            return "harmonic"
        return "constructive"

    def _compute_resultant(self, f1: FieldState, f2: FieldState) -> float:
        """Compute resultant frequency of two converging fields."""
        # Phi-weighted average
        return (f1.frequency_hz * f1.amplitude + f2.frequency_hz * f2.amplitude) / (f1.amplitude + f2.amplitude)

    def get_system_convergence(self) -> Dict[str, Any]:
        """Get convergence summary between the three major systems."""
        cross_system_points = [
            p for p in self._convergence_points
            if len(set(
                self._fields[fid].source_system
                for fid in p.fields
                if fid in self._fields
            )) > 1
        ]

        return {
            "total_fields": len(self._fields),
            "total_convergence_points": len(self._convergence_points),
            "cross_system_convergence": len(cross_system_points),
            "systems": {
                "semper_memoria_i": sum(1 for f in self._fields.values() if f.source_system == "semper_memoria_i"),
                "semper_memoria_ii": sum(1 for f in self._fields.values() if f.source_system == "semper_memoria_ii"),
                "looking_glass": sum(1 for f in self._fields.values() if f.source_system == "looking_glass"),
            },
            "highest_coherence": max((p.coherence for p in self._convergence_points), default=0.0),
        }
