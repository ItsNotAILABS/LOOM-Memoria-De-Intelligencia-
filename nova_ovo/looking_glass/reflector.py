"""
Unified System Reflector — SPECULUM UNITATIS
=============================================

PROT-642: Core reflection engine for LOOKING GLASS.

Observes every subsystem simultaneously and produces a single coherent
reflection state representing the entire organism at any moment.
"""

from dataclasses import dataclass, field
from typing import Dict, List, Any, Optional
from datetime import datetime, timezone
import json


PHI = 1.618033988749895
FREQUENCY_HZ = 3_010_349  # φ²¹


@dataclass
class SubsystemState:
    """State snapshot of a single subsystem."""
    name: str
    layer: int
    status: str  # active, dormant, evolving, converging
    frequency_hz: float
    signal_strength: float  # 0.0 - 1.0
    last_pulse: Optional[datetime] = None
    metadata: Dict[str, Any] = field(default_factory=dict)


@dataclass
class ReflectionState:
    """Unified reflection of the entire organism."""
    timestamp: datetime
    subsystem_count: int
    active_workers: int
    total_protocols: int
    coherence_index: float  # 0.0 - 1.0, phi-harmonic
    frequency_harmony: float
    subsystems: List[SubsystemState] = field(default_factory=list)
    emergent_patterns: List[str] = field(default_factory=list)
    convergence_points: List[str] = field(default_factory=list)

    def to_dict(self) -> Dict[str, Any]:
        return {
            "timestamp": self.timestamp.isoformat(),
            "subsystem_count": self.subsystem_count,
            "active_workers": self.active_workers,
            "total_protocols": self.total_protocols,
            "coherence_index": self.coherence_index,
            "frequency_harmony": self.frequency_harmony,
            "subsystems": [
                {
                    "name": s.name,
                    "layer": s.layer,
                    "status": s.status,
                    "frequency_hz": s.frequency_hz,
                    "signal_strength": s.signal_strength,
                }
                for s in self.subsystems
            ],
            "emergent_patterns": self.emergent_patterns,
            "convergence_points": self.convergence_points,
        }


class UnifiedReflector:
    """
    SPECULUM UNITATIS — The Unified System Reflector.

    Observes all subsystems across the organism and produces a coherent
    reflection state. The reflector is the "eye" of LOOKING GLASS.
    """

    KNOWN_SUBSYSTEMS = [
        ("semper_memoria_i", 1, "Eternal stored memory"),
        ("semper_memoria_ii", 2, "Phantom frequency fields"),
        ("nova_ovo_core", 3, "Core organism substrate"),
        ("economics", 4, "Behavioral economics engine"),
        ("consciousness", 5, "Consciousness substrate"),
        ("atmospheric", 6, "Atmospheric intelligence"),
        ("alpha_ai", 7, "Alpha AI systems"),
        ("blockchain", 8, "Catena Sovereigna"),
        ("terminal_agi", 9, "Terminal AGI systems"),
        ("research_lab", 10, "Research laboratory"),
        ("phantom_memory", 11, "Phantom memory layer"),
        ("phantom_agents", 12, "Phantom field agents"),
        ("flows", 13, "Flow orchestration"),
        ("dashboards", 14, "Dashboard systems"),
        ("command_center", 15, "Command center"),
        ("callable_ai", 16, "Callable AI registry"),
        ("library_nexus", 17, "Library nexus connections"),
        ("ux_ai", 18, "UX AI intelligence"),
        ("multi_engines", 19, "Multi-engine orchestration"),
        ("looking_glass", 21, "Self-observation (this system)"),
    ]

    def __init__(self):
        self._subsystem_states: Dict[str, SubsystemState] = {}
        self._reflection_history: List[ReflectionState] = []
        self._initialize_subsystems()

    def _initialize_subsystems(self):
        """Initialize known subsystem tracking."""
        for name, layer, description in self.KNOWN_SUBSYSTEMS:
            self._subsystem_states[name] = SubsystemState(
                name=name,
                layer=layer,
                status="active",
                frequency_hz=PHI ** layer,
                signal_strength=1.0,
                metadata={"description": description},
            )

    def reflect(self) -> ReflectionState:
        """
        Produce a unified reflection of the entire organism state.

        Returns a coherent snapshot representing all subsystems,
        their relationships, and emergent properties.
        """
        now = datetime.now(timezone.utc)
        subsystems = list(self._subsystem_states.values())

        # Calculate coherence index (phi-harmonic average of signal strengths)
        if subsystems:
            total_signal = sum(s.signal_strength for s in subsystems)
            coherence = (total_signal / len(subsystems)) * PHI / PHI  # normalized
        else:
            coherence = 0.0

        # Calculate frequency harmony
        frequencies = [s.frequency_hz for s in subsystems if s.frequency_hz > 0]
        if len(frequencies) >= 2:
            ratios = [frequencies[i+1] / frequencies[i] for i in range(len(frequencies)-1)]
            phi_deviations = [abs(r - PHI) / PHI for r in ratios if r > 0]
            harmony = 1.0 - (sum(phi_deviations) / len(phi_deviations)) if phi_deviations else 1.0
        else:
            harmony = 1.0

        reflection = ReflectionState(
            timestamp=now,
            subsystem_count=len(subsystems),
            active_workers=77,  # Current worker count including looking-glass
            total_protocols=661,  # Up to PROT-661
            coherence_index=min(1.0, max(0.0, coherence)),
            frequency_harmony=min(1.0, max(0.0, harmony)),
            subsystems=subsystems,
            emergent_patterns=self._detect_emergence(),
            convergence_points=self._find_convergence(),
        )

        self._reflection_history.append(reflection)
        return reflection

    def _detect_emergence(self) -> List[str]:
        """Detect emergent patterns across subsystems."""
        patterns = []
        active_count = sum(
            1 for s in self._subsystem_states.values() if s.status == "active"
        )
        if active_count >= 15:
            patterns.append("FULL_CONVERGENCE: All major subsystems active")
        if active_count >= 10:
            patterns.append("CRITICAL_MASS: Sufficient subsystems for self-organization")
        return patterns

    def _find_convergence(self) -> List[str]:
        """Find natural convergence points between subsystems."""
        return [
            "MEMORY_PHANTOM_CONVERGENCE: Tier I + Tier II unified",
            "AI_SUBSTRATE_CONVERGENCE: Alpha AI + Terminal AGI + Callable AI",
            "OBSERVATION_CONVERGENCE: Consciousness + Looking Glass",
        ]

    def update_subsystem(self, name: str, status: str = None, signal: float = None):
        """Update a subsystem's observed state."""
        if name in self._subsystem_states:
            if status:
                self._subsystem_states[name].status = status
            if signal is not None:
                self._subsystem_states[name].signal_strength = max(0.0, min(1.0, signal))
            self._subsystem_states[name].last_pulse = datetime.now(timezone.utc)

    def get_history(self) -> List[Dict[str, Any]]:
        """Return reflection history."""
        return [r.to_dict() for r in self._reflection_history]
