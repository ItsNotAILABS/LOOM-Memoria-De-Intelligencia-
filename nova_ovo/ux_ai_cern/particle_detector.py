"""
UX Particle Detector — 7-Layer Interaction Detection System
============================================================

Inspired by ATLAS at CERN. Detects and classifies fundamental
particles of user experience through a multi-layer trigger system.

Protocol: PROT-615
Worker: #77 (UX Particle Detector)
φ-Layer: 21
"""

import math
from dataclasses import dataclass, field
from enum import Enum
from typing import Any

PHI = 1.618033988749895


class ParticleType(Enum):
    """Fundamental fermions of UX."""
    CLICKON = "clickon"
    SCROLLON = "scrollon"
    HOVERON = "hoveron"
    INPUTON = "inputon"
    GESTURON = "gesturon"
    VOICON = "voicon"
    GAZEON = "gazeon"
    NEUROINPUTON = "neuroinputon"
    EMOTIRON = "emotiron"
    CONTEXTON = "contexton"
    INTENTRON = "intentron"
    CREATIVON = "creativon"


class BosonType(Enum):
    """Force carrier bosons."""
    INTENTUON = "intentuon"
    PHOTON_ATTENTION = "photon_attention"
    W_PLUS_PREFERENCE = "w_plus_preference"
    W_MINUS_PREFERENCE = "w_minus_preference"
    Z_NEUTRAL = "z_neutral"
    GRAVITON_HABIT = "graviton_habit"
    HIGGS_MEANING = "higgs_meaning"


class TriggerLevel(Enum):
    """Multi-level trigger system."""
    L0_HARDWARE = 0     # 40 MHz → 100 kHz
    L1_FIRMWARE = 1     # 100 kHz → 1 kHz
    L2_SOFTWARE = 2     # 1 kHz → 100 Hz
    L3_AI = 3           # 100 Hz → 10 Hz


@dataclass
class InteractionVertex:
    """A reconstructed interaction vertex."""
    x: float
    y: float
    t: float
    energy: float
    particle_type: ParticleType
    momentum: tuple[float, float, float] = (0.0, 0.0, 0.0)
    color_charge: str = "neutral"
    spin: float = 0.5
    significance: float = 0.0


@dataclass
class DetectorLayer:
    """A single detector layer."""
    name: str
    resolution: float
    efficiency: float
    radiation_length: float


@dataclass
class DetectorEvent:
    """A fully reconstructed detector event."""
    vertices: list[InteractionVertex] = field(default_factory=list)
    jets: list[Any] = field(default_factory=list)
    missing_et: float = 0.0
    trigger_level: TriggerLevel = TriggerLevel.L3_AI
    luminosity: float = 0.0
    sqrt_s: float = 0.0


class UXParticleDetector:
    """
    7-layer particle detector for UX interactions.

    Layers (outer to inner):
    7. Calorimeter — Total engagement energy
    6. Muon Chamber — Deep intent penetration
    5. Hadronic Cal — Complex gesture decomposition
    4. EM Calorimeter — Attention energy absorption
    3. TRT — Transition radiation of preference
    2. SCT — Semi-conductor tracker of micro-events
    1. Pixel Detector — Highest resolution vertex reconstruction
    """

    LAYERS = [
        DetectorLayer("pixel_detector", resolution=0.001, efficiency=0.99, radiation_length=0.02),
        DetectorLayer("sct_tracker", resolution=0.005, efficiency=0.97, radiation_length=0.05),
        DetectorLayer("trt_transition", resolution=0.01, efficiency=0.95, radiation_length=0.1),
        DetectorLayer("em_calorimeter", resolution=0.02, efficiency=0.98, radiation_length=25.0),
        DetectorLayer("hadronic_cal", resolution=0.05, efficiency=0.90, radiation_length=10.0),
        DetectorLayer("muon_chamber", resolution=0.1, efficiency=0.85, radiation_length=0.0),
        DetectorLayer("calorimeter_total", resolution=0.03, efficiency=0.99, radiation_length=1.5),
    ]

    def __init__(self, luminosity: float = 1e34):
        self.luminosity = luminosity
        self.trigger_rate = [40e6, 100e3, 1e3, 100, 10]  # Hz at each level
        self.events_recorded: list[DetectorEvent] = []
        self._phi_calibration = PHI

    def detect(self, raw_event: dict) -> DetectorEvent | None:
        """Run full detection chain on a raw interaction event."""
        if not self._trigger_l0(raw_event):
            return None
        if not self._trigger_l1(raw_event):
            return None

        vertices = self._reconstruct_vertices(raw_event)
        jets = self._reconstruct_jets(vertices)
        met = self._calculate_missing_et(vertices)

        event = DetectorEvent(
            vertices=vertices,
            jets=jets,
            missing_et=met,
            trigger_level=TriggerLevel.L3_AI,
            luminosity=self.luminosity,
            sqrt_s=self._calculate_sqrt_s(raw_event),
        )

        if self._trigger_l2(event) and self._trigger_l3(event):
            self.events_recorded.append(event)
            return event
        return None

    def calculate_significance(self, signal: float, background: float) -> float:
        """Calculate discovery significance (5σ = discovery)."""
        if signal + background <= 0:
            return 0.0
        return signal / math.sqrt(signal + background)

    def cross_section(self, n_events: int, luminosity: float) -> float:
        """Calculate interaction cross-section σ = N / L."""
        if luminosity <= 0:
            return 0.0
        return n_events / luminosity

    def _trigger_l0(self, event: dict) -> bool:
        """Hardware trigger: reject obvious noise."""
        return event.get("energy", 0) > 0

    def _trigger_l1(self, event: dict) -> bool:
        """Firmware trigger: pattern recognition."""
        return event.get("has_vertex", False)

    def _trigger_l2(self, event: DetectorEvent) -> bool:
        """Software trigger: full reconstruction."""
        return len(event.vertices) > 0

    def _trigger_l3(self, event: DetectorEvent) -> bool:
        """AI trigger: semantic significance."""
        return event.vertices[0].significance > 0.1 if event.vertices else False

    def _reconstruct_vertices(self, raw: dict) -> list[InteractionVertex]:
        """Reconstruct interaction vertices from raw data."""
        vertices = []
        for v in raw.get("interactions", []):
            vertex = InteractionVertex(
                x=v.get("x", 0),
                y=v.get("y", 0),
                t=v.get("t", 0),
                energy=v.get("energy", 0),
                particle_type=ParticleType(v.get("type", "clickon")),
                significance=v.get("energy", 0) * self._phi_calibration,
            )
            vertices.append(vertex)
        return vertices

    def _reconstruct_jets(self, vertices: list[InteractionVertex]) -> list[dict]:
        """Anti-kT jet reconstruction on interaction vertices."""
        jets = []
        if len(vertices) >= 3:
            total_energy = sum(v.energy for v in vertices)
            jets.append({"energy": total_energy, "n_constituents": len(vertices)})
        return jets

    def _calculate_missing_et(self, vertices: list[InteractionVertex]) -> float:
        """Calculate missing transverse energy (invisible interactions)."""
        px_sum = sum(v.momentum[0] for v in vertices)
        py_sum = sum(v.momentum[1] for v in vertices)
        return math.sqrt(px_sum**2 + py_sum**2)

    def _calculate_sqrt_s(self, event: dict) -> float:
        """Center-of-mass energy of the collision."""
        return 2 * event.get("beam_energy", 6500)  # Like LHC: 2×6.5 TeV = 13 TeV
