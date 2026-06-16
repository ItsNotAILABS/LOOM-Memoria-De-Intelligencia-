"""
Glass Sovereign — SPECULUM SOVEREIGNUM
=======================================

PROT-661: The top-level controller of the LOOKING GLASS system.

Coordinates all LOOKING GLASS components (reflector, fusion, introspection,
convergence, bridge, patterns) into a unified observation system.
"""

from typing import Dict, List, Any, Optional
from datetime import datetime, timezone

from nova_ovo.looking_glass.reflector import UnifiedReflector, ReflectionState
from nova_ovo.looking_glass.fusion_engine import FusionEngine, Signal, FusedStream
from nova_ovo.looking_glass.introspection import IntrospectionEngine, IntrospectionResult
from nova_ovo.looking_glass.convergence import FieldConvergence
from nova_ovo.looking_glass.bridge import MemoryPhantomBridge
from nova_ovo.looking_glass.pattern_detector import PatternDetector


PHI = 1.618033988749895
SYSTEM_VERSION = "1.0.0"
SYSTEM_NUMBER = 3
CODENAME = "LOOKING GLASS"
LATIN = "SPECULUM VITREUM SOVEREIGNUM"
LAYER = 21
FREQUENCY_HZ = 3_010_349  # φ²¹
PROTOCOLS = list(range(642, 662))


class GlassSovereign:
    """
    SPECULUM SOVEREIGNUM — The Glass Sovereign.

    Top-level orchestrator of the LOOKING GLASS system. Coordinates all
    components into a unified observation, fusion, and introspection system.

    This is System III — the fusion layer that makes the entire organism
    self-aware through unified observation.
    """

    def __init__(self):
        self.reflector = UnifiedReflector()
        self.fusion = FusionEngine()
        self.introspection = IntrospectionEngine()
        self.convergence = FieldConvergence()
        self.bridge = MemoryPhantomBridge()
        self.patterns = PatternDetector()
        self._boot_time = datetime.now(timezone.utc)
        self._observation_cycles = 0

    @property
    def identity(self) -> Dict[str, Any]:
        """System identity."""
        return {
            "system_number": SYSTEM_NUMBER,
            "codename": CODENAME,
            "latin": LATIN,
            "layer": LAYER,
            "frequency_hz": FREQUENCY_HZ,
            "protocols": f"PROT-{PROTOCOLS[0]} to PROT-{PROTOCOLS[-1]}",
            "version": SYSTEM_VERSION,
            "boot_time": self._boot_time.isoformat(),
            "observation_cycles": self._observation_cycles,
        }

    def observe(self) -> Dict[str, Any]:
        """
        Execute a full observation cycle.

        This is the primary operation of LOOKING GLASS — observing
        the entire organism and producing unified intelligence.
        """
        self._observation_cycles += 1

        # 1. Reflect — get current state of all subsystems
        reflection = self.reflector.reflect()

        # 2. Converge — find convergence points across fields
        convergence_points = self.convergence.compute_convergence()

        # 3. Pattern detection — based on reflection
        for subsystem in reflection.subsystems:
            self.patterns.observe(
                system=subsystem.name,
                event_type="active_state",
                data={"status": subsystem.status, "signal": subsystem.signal_strength},
            )
        detected_patterns = self.patterns.detect()

        # 4. Introspection — self-awareness check
        state_check = self.introspection.current_state()

        return {
            "cycle": self._observation_cycles,
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "reflection": {
                "subsystems": reflection.subsystem_count,
                "coherence": reflection.coherence_index,
                "harmony": reflection.frequency_harmony,
                "emergent": reflection.emergent_patterns,
            },
            "convergence": {
                "new_points": len(convergence_points),
                "total_points": len(self.convergence._convergence_points),
            },
            "patterns": {
                "new_detected": len(detected_patterns),
                "total_known": len(self.patterns._detected_patterns),
            },
            "introspection": {
                "confidence": state_check.confidence,
                "depth_reached": state_check.depth_reached,
            },
            "system_status": "OBSERVING",
        }

    def fuse_signals(self, signals: List[Signal]) -> List[FusedStream]:
        """Ingest and fuse signals from across the organism."""
        self.fusion.ingest_batch(signals)
        return self.fusion.fuse()

    def ask(self, question: str, scope: str = "all") -> IntrospectionResult:
        """Ask the organism a question through LOOKING GLASS."""
        return self.introspection.introspect(question, scope=scope)

    def full_status(self) -> Dict[str, Any]:
        """Get complete LOOKING GLASS system status."""
        return {
            "identity": self.identity,
            "bridge_summary": self.bridge.get_bridge_summary(),
            "convergence_summary": self.convergence.get_system_convergence(),
            "patterns": self.patterns.get_patterns(),
            "fusion_streams": self.fusion.get_streams(),
            "three_systems": {
                "I": {"name": "SEMPER MEMORIA", "type": "Eternal stored memory", "status": "ACTIVE"},
                "II": {"name": "SEMPER MEMORIA II", "type": "Phantom frequency fields", "status": "ACTIVE"},
                "III": {"name": "LOOKING GLASS", "type": "Unified fusion & introspection", "status": "ACTIVE"},
            },
        }

    def __repr__(self) -> str:
        return (
            f"GlassSovereign(system={SYSTEM_NUMBER}, codename='{CODENAME}', "
            f"layer={LAYER}, frequency={FREQUENCY_HZ}Hz, "
            f"cycles={self._observation_cycles})"
        )
