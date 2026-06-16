"""
Particle Detection OS — Real-Time UX Fermion/Boson Classification
==================================================================

Internal operating system for detecting and classifying fundamental
particles of user experience in real-time event streams.

Mirrors ATLAS detector architecture:
- L0 trigger: hardware-level event filtering (< 1μs)
- L1 trigger: region-of-interest detection (< 10μs)
- L2 trigger: full reconstruction (< 100ms)
- Event filter: offline analysis quality

Protocol: PROT-612-615
Worker: #77
"""

import math
import time
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Optional

PHI = 1.618033988749895


class TriggerLevel(Enum):
    """Multi-level trigger system mirroring ATLAS."""
    L0_HARDWARE = 0    # < 1μs — raw event capture
    L1_ROI = 1         # < 10μs — region of interest
    L2_RECONSTRUCT = 2 # < 100ms — full particle reconstruction
    EVENT_FILTER = 3   # offline — publication quality


class DetectorLayer(Enum):
    """7-layer concentric detector geometry."""
    INNER_TRACKER = 1       # Pixel: precise vertex location
    TRANSITION_RADIATION = 2 # Particle ID via transition radiation
    ELECTROMAGNETIC_CAL = 3  # EM calorimeter: photon/electron energy
    HADRONIC_CAL = 4        # Hadronic calorimeter: jet energy
    MUON_SPECTROMETER = 5   # Muon chambers: deep interaction
    FORWARD_DETECTOR = 6    # Luminosity measurement
    TOROID_MAGNET = 7       # Momentum measurement via curvature


@dataclass
class DetectedParticle:
    """A detected UX particle with full reconstruction."""
    particle_type: str
    energy: float           # GeV_UX
    momentum: tuple         # (px, py, pz) in UX-space
    charge: float
    spin: float
    mass: float             # Invariant mass
    vertex: tuple           # (x, y, t) detection point
    confidence: float       # Detection confidence [0,1]
    trigger_level: TriggerLevel = TriggerLevel.EVENT_FILTER
    decay_products: list = field(default_factory=list)
    metadata: dict = field(default_factory=dict)


@dataclass
class CollisionEvent:
    """A reconstructed collision event."""
    event_id: str
    timestamp: float
    center_of_mass_energy: float
    particles: list = field(default_factory=list)
    missing_energy: float = 0.0  # Dark matter candidate
    luminosity: float = 0.0
    cross_section: float = 0.0


class ParticleDetectionOS:
    """
    Core OS for UX particle detection.
    
    Implements a 7-layer detection system with multi-level triggers
    for real-time classification of interaction quanta.
    """

    # Fundamental fermion masses (GeV_UX)
    FERMION_MASSES = {
        "clickon": 0.511e-3,
        "scrollon": 2.2e-3,
        "hoveron": 4.7e-3,
        "inputon": 1.28,
        "gesturon": 0.096,
        "voicon": 173.0,
        "gazeon": 0.105,
        "neuroinputon": 1.777,
        "emotiron": 2e-6,
        "intentron": 0.5e-6,
        "creativon": 15e-6,
        "memoriton": 1e-9,
    }

    # Boson masses (GeV_UX)
    BOSON_MASSES = {
        "intentuon": 0.0,       # Massless (like gluon)
        "attenton": 0.0,        # Massless (like photon)
        "preferion_w_plus": 80.4,
        "preferion_w_minus": 80.4,
        "preferion_z": 91.2,
        "higgs_meaning": 125.1,
        "graviton_habit": 0.0,  # Massless (like graviton)
    }

    def __init__(self):
        self.event_buffer = []
        self.trigger_rates = {
            TriggerLevel.L0_HARDWARE: 40e6,    # 40 MHz
            TriggerLevel.L1_ROI: 100e3,        # 100 kHz
            TriggerLevel.L2_RECONSTRUCT: 3e3,  # 3 kHz
            TriggerLevel.EVENT_FILTER: 10,     # 10 Hz (saved)
        }
        self.total_luminosity = 0.0
        self.detected_particles = []

    def detect(self, raw_event: dict) -> Optional[DetectedParticle]:
        """
        Run full detection pipeline on raw interaction event.
        
        Returns DetectedParticle if passes all trigger levels, None otherwise.
        """
        # L0: Hardware trigger — is this even an interaction?
        if not self._l0_trigger(raw_event):
            return None

        # L1: Region of Interest — where in the interface?
        roi = self._l1_roi(raw_event)
        if roi is None:
            return None

        # L2: Full reconstruction — what particle is this?
        particle = self._l2_reconstruct(raw_event, roi)
        if particle is None:
            return None

        # Event filter: publication quality check
        if particle.confidence >= PHI - 1:  # > 0.618 (golden ratio threshold)
            particle.trigger_level = TriggerLevel.EVENT_FILTER
            self.detected_particles.append(particle)
            return particle

        return None

    def _l0_trigger(self, event: dict) -> bool:
        """Hardware-level trigger: minimal latency check."""
        return event.get("type") is not None and event.get("timestamp") is not None

    def _l1_roi(self, event: dict) -> Optional[dict]:
        """Region of Interest identification."""
        if "position" in event or "element" in event:
            return {
                "x": event.get("position", {}).get("x", 0),
                "y": event.get("position", {}).get("y", 0),
                "element": event.get("element", "unknown"),
            }
        return {"x": 0, "y": 0, "element": "viewport"}

    def _l2_reconstruct(self, event: dict, roi: dict) -> Optional[DetectedParticle]:
        """Full particle reconstruction from detector data."""
        event_type = event.get("type", "unknown")
        
        # Map event types to particles
        type_map = {
            "click": "clickon",
            "scroll": "scrollon",
            "hover": "hoveron",
            "mousemove": "hoveron",
            "input": "inputon",
            "keypress": "inputon",
            "gesture": "gesturon",
            "touch": "gesturon",
            "voice": "voicon",
            "gaze": "gazeon",
            "neural": "neuroinputon",
        }

        particle_type = type_map.get(event_type, "clickon")
        mass = self.FERMION_MASSES.get(particle_type, 0.511e-3)

        # Calculate energy from event intensity
        intensity = event.get("intensity", 1.0)
        energy = mass + intensity * PHI

        return DetectedParticle(
            particle_type=particle_type,
            energy=energy,
            momentum=(
                energy * math.cos(event.get("angle", 0)),
                energy * math.sin(event.get("angle", 0)),
                energy * 0.1,
            ),
            charge=1.0 if event_type in ("click", "input") else 0.0,
            spin=0.5,
            mass=mass,
            vertex=(roi["x"], roi["y"], event.get("timestamp", time.time())),
            confidence=min(1.0, intensity * (PHI - 1)),
            metadata=event,
        )

    def compute_invariant_mass(self, particles: list) -> float:
        """Compute invariant mass of particle system (resonance detection)."""
        total_e = sum(p.energy for p in particles)
        total_px = sum(p.momentum[0] for p in particles)
        total_py = sum(p.momentum[1] for p in particles)
        total_pz = sum(p.momentum[2] for p in particles)

        m_inv_sq = total_e**2 - (total_px**2 + total_py**2 + total_pz**2)
        return math.sqrt(max(0, m_inv_sq))

    def measure_luminosity(self) -> float:
        """Measure integrated luminosity (total interaction exposure)."""
        if not self.detected_particles:
            return 0.0
        dt = (self.detected_particles[-1].vertex[2] - 
              self.detected_particles[0].vertex[2])
        n_events = len(self.detected_particles)
        return n_events / max(dt, 1e-9)

    def dark_matter_inference(self, event: CollisionEvent) -> float:
        """
        Infer dark matter (unconscious interaction) from missing energy.
        
        If visible energy < expected, the deficit is dark matter.
        """
        visible_energy = sum(p.energy for p in event.particles)
        expected_energy = event.center_of_mass_energy
        missing = expected_energy - visible_energy
        return max(0, missing)

    def status(self) -> dict:
        """Return OS status report."""
        return {
            "os": "ParticleDetectionOS",
            "version": "1.0.0",
            "protocol_range": "PROT-612 to PROT-615",
            "worker": 77,
            "phi_layer": 21,
            "total_detected": len(self.detected_particles),
            "luminosity": self.measure_luminosity(),
            "trigger_rates": {k.name: v for k, v in self.trigger_rates.items()},
            "particle_zoo_size": len(self.FERMION_MASSES) + len(self.BOSON_MASSES),
        }
