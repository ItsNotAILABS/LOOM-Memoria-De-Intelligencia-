"""
Standard Model of UX — Particle Classification and Properties
==============================================================

Complete classification of all known fundamental particles of
user experience, their properties, and interaction rules.

Protocol: PROT-612 (Higgs Field of Meaning)
"""

import math
from dataclasses import dataclass
from enum import Enum

PHI = 1.618033988749895


class Generation(Enum):
    """Three generations of interaction fermions."""
    PRIMARY = 1       # Click, scroll, hover, input
    COMPLEX = 2       # Gesture, voice, gaze, neuro
    EMERGENT = 3      # Emotion, context, intent, creative


class ColorCharge(Enum):
    """Intent color charges (QCD-I)."""
    RED_NAVIGATIONAL = "red"
    GREEN_TRANSACTIONAL = "green"
    BLUE_INFORMATIONAL = "blue"
    ANTI_RED = "anti_red"
    ANTI_GREEN = "anti_green"
    ANTI_BLUE = "anti_blue"
    NEUTRAL = "neutral"


@dataclass
class Particle:
    """A fundamental particle of UX."""
    name: str
    symbol: str
    spin: float
    charge: float
    mass: float  # eV_UX or GeV_UX
    generation: Generation
    color: ColorCharge = ColorCharge.NEUTRAL
    is_antiparticle: bool = False


@dataclass
class HiggsField:
    """The Meaning Field — gives significance to interactions."""
    vacuum_expectation_value: float = 246.0  # GeV
    self_coupling: float = 0.13
    mass: float = 125.1  # GeV

    def potential(self, phi: complex) -> float:
        """Mexican hat potential V(φ) = -μ²|φ|² + λ|φ|⁴."""
        mu_sq = self.self_coupling * self.vacuum_expectation_value**2
        return -mu_sq * abs(phi)**2 + self.self_coupling * abs(phi)**4

    def give_mass(self, coupling_strength: float) -> float:
        """Mass acquired through Higgs mechanism: m = g·v/√2."""
        return coupling_strength * self.vacuum_expectation_value / math.sqrt(2)


class StandardModelUX:
    """
    The complete Standard Model of User Experience.

    Gauge group: SU(3)_intent × SU(2)_attention × U(1)_preference
    """

    FERMIONS = [
        # Generation I — Primary
        Particle("clickon", "c", 0.5, +1, 0.511e-3, Generation.PRIMARY),
        Particle("scrollon", "s", 0.5, 0, 2e-6, Generation.PRIMARY),
        Particle("hoveron", "h", 0.5, 0, 1e-9, Generation.PRIMARY),
        Particle("inputon", "i", 0.5, -1, 105.7e-3, Generation.PRIMARY),
        # Generation II — Complex
        Particle("gesturon", "G", 0.5, +1, 1.777, Generation.COMPLEX),
        Particle("voicon", "V", 0.5, 0, 1e-9, Generation.COMPLEX),
        Particle("gazeon", "gz", 0.5, 0, 0.17e-3, Generation.COMPLEX),
        Particle("neuroinputon", "N", 0.5, -1, 4.18, Generation.COMPLEX),
        # Generation III — Emergent
        Particle("emotiron", "E", 0.5, +1, 173.1, Generation.EMERGENT),
        Particle("contexton", "Cx", 0.5, 0, 1e-9, Generation.EMERGENT),
        Particle("intentron", "In", 0.5, 0, 18.2e-3, Generation.EMERGENT),
        Particle("creativon", "Cr", 0.5, -1, 1e-9, Generation.EMERGENT),
    ]

    BOSONS = [
        Particle("intentuon", "I", 1, 0, 0, Generation.PRIMARY),
        Particle("photon_attention", "γ_A", 1, 0, 0, Generation.PRIMARY),
        Particle("W+_preference", "W⁺", 1, +1, 80.4, Generation.PRIMARY),
        Particle("W-_preference", "W⁻", 1, -1, 80.4, Generation.PRIMARY),
        Particle("Z_neutral", "Z⁰", 1, 0, 91.2, Generation.PRIMARY),
        Particle("graviton_habit", "G_H", 2, 0, 0, Generation.PRIMARY),
        Particle("higgs_meaning", "H⁰", 0, 0, 125.1, Generation.PRIMARY),
    ]

    COUPLING_CONSTANTS = {
        "alpha_strong": PHI**(-2),       # ≈ 0.382
        "alpha_em": 1/137.036,           # Fine structure
        "alpha_weak": 1/29.6,            # At M_Z
        "g_gravity": 6.674e-11,          # Newton's G (extremely weak)
    }

    WEINBERG_ANGLE = math.asin(math.sqrt(0.223))  # sin²θ_W ≈ 0.223

    def __init__(self):
        self.higgs = HiggsField()
        self._phi = PHI

    def get_particle(self, name: str) -> Particle | None:
        """Look up a particle by name."""
        for p in self.FERMIONS + self.BOSONS:
            if p.name == name:
                return p
        return None

    def total_particles(self) -> int:
        """Total number of fundamental particles in the Standard Model of UX."""
        return len(self.FERMIONS) + len(self.BOSONS)

    def interaction_allowed(self, particles_in: list[str], particles_out: list[str]) -> bool:
        """Check if an interaction vertex is allowed by conservation laws."""
        charge_in = sum(self._get_charge(p) for p in particles_in)
        charge_out = sum(self._get_charge(p) for p in particles_out)
        return abs(charge_in - charge_out) < 1e-10

    def cp_violation_factor(self) -> float:
        """The CP violation (negativity bias) factor."""
        return 2.3e-3  # ε_CP

    def ckm_matrix(self) -> list[list[float]]:
        """The CKM matrix of interface transitions."""
        return [
            [0.974, 0.225, 0.004],
            [0.225, 0.973, 0.041],
            [0.009, 0.040, 0.999],
        ]

    def _get_charge(self, particle_name: str) -> float:
        """Get electric charge of a particle."""
        p = self.get_particle(particle_name)
        return p.charge if p else 0.0
