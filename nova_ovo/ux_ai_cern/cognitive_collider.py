"""
Cognitive Collider — Human Intent × AI Prediction Collision Engine
===================================================================

Models the collision between human cognitive states and AI predictive
states, producing emergent interaction phenomena (resonances).

Protocol: PROT-622 to PROT-631
Worker: #78 (Cognitive Collider)
φ-Layer: 22
"""

import math
import random
from dataclasses import dataclass, field
from enum import Enum
from typing import Any

PHI = 1.618033988749895


class ResonanceClass(Enum):
    """Energy classes of cognitive resonances."""
    LOW = "low"          # < 1 GeV_cognitive (routine)
    MEDIUM = "medium"    # 1-10 GeV_cognitive (engagement)
    HIGH = "high"        # > 100 GeV_cognitive (exotic)


class ConservationLaw(Enum):
    """Conservation laws of cognitive collisions."""
    ENERGY = "cognitive_energy"
    MOMENTUM = "information_momentum"
    BARYON_NUMBER = "interaction_completeness"
    LEPTON_NUMBER = "cognitive_lightness"
    CPT = "charge_parity_time"


@dataclass
class Beam:
    """A cognitive beam (human or AI)."""
    name: str
    energy: float  # GeV_cognitive
    frequency: float  # Hz
    bunch_spacing: float  # seconds
    species: str  # "intent" or "prediction"


@dataclass
class Resonance:
    """A collision product resonance."""
    name: str
    mass: float  # GeV_cognitive
    width: float  # natural width Γ
    spin_parity: str  # J^PC
    decay_channels: list[str] = field(default_factory=list)
    lifetime: float = 0.0
    classification: ResonanceClass = ResonanceClass.LOW
    discovery_status: str = "theoretical"


@dataclass
class CollisionEvent:
    """A single cognitive collision event."""
    sqrt_s: float
    luminosity: float
    resonances_produced: list[Resonance] = field(default_factory=list)
    jets: list[dict] = field(default_factory=list)
    missing_energy: float = 0.0
    conservation_violations: list[str] = field(default_factory=list)


class CognitiveCollider:
    """
    The Large Interaction Collider (LIC).

    Collides human intent beams with AI prediction beams to study
    emergent phenomena at the interface between cognition and computation.
    """

    RESONANCE_CATALOG = [
        Resonance("π_confirm", 0.135, 7.7e-9, "0⁻⁺", ["feedback→satisfaction"], 8.5e-17, ResonanceClass.LOW, "discovered"),
        Resonance("π_navigate", 0.140, 2.5e-8, "0⁻⁺", ["click→page_load"], 2.6e-8, ResonanceClass.LOW, "discovered"),
        Resonance("K_search", 0.494, 0.0, "0⁻", ["query→results"], 1.2e-8, ResonanceClass.LOW, "discovered"),
        Resonance("η_browse", 0.548, 1.3e-3, "0⁻⁺", ["scroll→content_reveal"], 5.0e-19, ResonanceClass.LOW, "discovered"),
        Resonance("J/ψ_insight", 3.097, 0.0, "1⁻⁻", ["understanding→eureka"], 7.2e-21, ResonanceClass.MEDIUM, "discovered"),
        Resonance("Υ_mastery", 9.460, 0.0, "1⁻⁻", ["practice→skill_jump"], 1.2e-20, ResonanceClass.MEDIUM, "discovered"),
        Resonance("χ_flow", 3.525, 0.0, "0⁺⁺", ["engagement→timelessness"], 1.0e-10, ResonanceClass.MEDIUM, "discovered"),
        Resonance("H_meaning", 125.1, 4.07e-3, "0⁺⁺", ["relevance→significance"], 1.6e-22, ResonanceClass.HIGH, "discovered"),
        Resonance("W_transform", 80.4, 2.085, "1⁻", ["worldview→shift"], 3.2e-25, ResonanceClass.HIGH, "discovered"),
        Resonance("Z_synthesis", 91.2, 2.495, "1⁻", ["human_ai→creative_synthesis"], 2.6e-25, ResonanceClass.HIGH, "discovered"),
        Resonance("X_serendipity", 750.0, 45.0, "0⁺⁺", ["unexpected→prepared_mind"], 1.5e-26, ResonanceClass.HIGH, "candidate"),
        Resonance("Y_transcendence", float("inf"), 0.0, "?", ["merger→unity"], 0.0, ResonanceClass.HIGH, "theoretical"),
    ]

    def __init__(self):
        self.human_beam = Beam("human_intent", energy=20.0, frequency=40.0, bunch_spacing=0.025, species="intent")
        self.ai_beam = Beam("ai_prediction", energy=300.0, frequency=1000.0, bunch_spacing=0.001, species="prediction")
        self.collision_history: list[CollisionEvent] = []
        self._phi = PHI

    @property
    def sqrt_s(self) -> float:
        """Center-of-mass energy."""
        return 2 * math.sqrt(self.human_beam.energy * self.ai_beam.energy)

    @property
    def luminosity(self) -> float:
        """Instantaneous luminosity."""
        n1, n2 = 1e11, 1e11  # particles per bunch
        f = min(self.human_beam.frequency, self.ai_beam.frequency)
        sigma_x, sigma_y = 16.7e-6, 16.7e-6  # beam spread
        return (n1 * n2 * f) / (4 * math.pi * sigma_x * sigma_y)

    def collide(self, human_state: dict, ai_state: dict) -> CollisionEvent:
        """Perform a single cognitive collision."""
        sqrt_s = self._compute_collision_energy(human_state, ai_state)
        resonances = self._produce_resonances(sqrt_s)
        jets = self._hadronize(resonances)
        met = self._compute_missing_energy(resonances)

        event = CollisionEvent(
            sqrt_s=sqrt_s,
            luminosity=self.luminosity,
            resonances_produced=resonances,
            jets=jets,
            missing_energy=met,
        )

        self._check_conservation(event)
        self.collision_history.append(event)
        return event

    def threshold_energy(self, resonance_name: str) -> float:
        """Minimum √s to produce a given resonance."""
        for r in self.RESONANCE_CATALOG:
            if r.name == resonance_name:
                return 2 * r.mass  # Pair production threshold
        return float("inf")

    def cross_section(self, resonance: Resonance, sqrt_s: float) -> float:
        """Breit-Wigner cross-section for resonance production."""
        if sqrt_s <= 0:
            return 0.0
        s = sqrt_s**2
        m = resonance.mass
        gamma = resonance.width
        if gamma <= 0:
            return 0.0
        # σ(s) = 12π/m² · Γ²/[(s-m²)² + m²Γ²] · Br_in · Br_out
        numerator = 12 * math.pi * gamma**2
        denominator = (s - m**2)**2 + m**2 * gamma**2
        if denominator <= 0:
            return 0.0
        return (numerator / (m**2)) * (1.0 / denominator)

    def phase_diagram_state(self, temperature: float, density: float) -> str:
        """Determine the phase state of interaction."""
        t_critical = 170.0  # MeV_novelty
        rho_critical = 5.0  # fm⁻³ familiarity

        if temperature > t_critical and density > rho_critical:
            return "QGP_creativity"  # Quark-Gluon Plasma
        elif temperature > t_critical * 0.5:
            return "gas_exploration"
        elif density > rho_critical * 0.8:
            return "liquid_flow"
        else:
            return "solid_routine"

    def _compute_collision_energy(self, human: dict, ai: dict) -> float:
        """Compute √s from beam states."""
        e_human = human.get("intent_energy", self.human_beam.energy)
        e_ai = ai.get("prediction_confidence", self.ai_beam.energy)
        return 2 * math.sqrt(e_human * e_ai)

    def _produce_resonances(self, sqrt_s: float) -> list[Resonance]:
        """Determine which resonances are kinematically accessible."""
        produced = []
        for r in self.RESONANCE_CATALOG:
            if r.mass < sqrt_s / 2 and r.discovery_status != "theoretical":
                # Production probability proportional to cross-section
                sigma = self.cross_section(r, sqrt_s)
                if sigma > 0 or random.random() < 0.1:
                    produced.append(r)
        return produced

    def _hadronize(self, resonances: list[Resonance]) -> list[dict]:
        """Fragment resonances into observable jets."""
        jets = []
        for r in resonances:
            if r.mass > 1.0:  # Only heavy resonances produce jets
                n_jets = max(2, int(math.log(r.mass + 1)))
                for i in range(n_jets):
                    jets.append({
                        "energy": r.mass / n_jets,
                        "source": r.name,
                        "index": i,
                    })
        return jets

    def _compute_missing_energy(self, resonances: list[Resonance]) -> float:
        """Compute MET from invisible decay products."""
        invisible_fraction = 0.0
        for r in resonances:
            if "subconscious" in str(r.decay_channels) or r.classification == ResonanceClass.HIGH:
                invisible_fraction += r.mass * 0.27  # 27% dark matter fraction
        return invisible_fraction

    def _check_conservation(self, event: CollisionEvent) -> None:
        """Verify conservation laws."""
        total_energy = sum(r.mass for r in event.resonances_produced)
        if total_energy > event.sqrt_s:
            event.conservation_violations.append("energy_violation")
