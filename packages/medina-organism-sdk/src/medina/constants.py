"""
Medina Organism SDK — Fundamental Constants

The mathematical substrate upon which everything is built.
"""

from __future__ import annotations

import math
from typing import Any, Dict, List

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# GOLDEN RATIO AND DERIVATIVES
# ═══════════════════════════════════════════════════════════════════════════════════════════════

PHI: float = 1.6180339887498948482
PHI_SQ: float = 2.6180339887498948482
PHI_INV: float = 0.6180339887498948482
TORUS_R: float = PHI * 10.0

# φ Powers (pre-computed for efficiency)
PHI_POWERS: Dict[int, float] = {
    1: 1.618033988749895,
    2: 2.618033988749895,
    3: 4.236067977499790,
    4: 6.854101966249685,
    5: 11.090169943749475,
    6: 17.944271909999163,
    7: 29.034441853748636,
    8: 46.978713763747800,
    9: 76.013155617496440,
    10: 122.99186938124424,
    11: 199.00502499874069,
    12: 321.99689437998490,
    13: 521.00191937872560,
    14: 842.99881375870995,
    15: 1364.0007331374355,
    16: 2206.9995468961454,
    17: 3571.0002800335809,
    18: 5777.9998269297260,
    19: 9349.0001069633070,
    20: 15127.000933893033,
}

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# EARTH AND COSMIC FREQUENCIES
# ═══════════════════════════════════════════════════════════════════════════════════════════════

SCHUMANN: float = 7.83  # Hz — Earth's fundamental resonance

# Solfeggio frequencies — Ancient healing tones
SOLFEGGIO: List[float] = [
    174.0,   # Ut — Foundation
    285.0,   # Re — Healing
    396.0,   # Mi — Liberation
    417.0,   # Fa — Change
    528.0,   # Sol — Miracles (DNA repair)
    639.0,   # La — Connection
    741.0,   # Si — Awakening
    852.0,   # Ti — Intuition
    963.0,   # Do — Transcendence
]

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# FIBONACCI SEQUENCE
# ═══════════════════════════════════════════════════════════════════════════════════════════════

FIBONACCI: List[int] = [
    1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144,
    233, 377, 610, 987, 1597, 2584, 4181, 6765,
    10946, 17711, 28657, 46368, 75025, 121393,
]

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# PHYSICAL CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

BOLTZMANN: float = 1.380649e-23  # J/K
PLANCK: float = 6.62607015e-34   # J·s
SPEED_OF_LIGHT: float = 299792458.0  # m/s (exact)

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# MICROMACRO SUBSTRATE LAYERS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

SUBSTRATE_LAYERS: List[Dict[str, Any]] = [
    {"layer": 0, "name": "QUANTUM", "scale": 1e-35, "frequency": 1e15},
    {"layer": 1, "name": "PLANCK", "scale": 1e-34, "frequency": 1e14},
    {"layer": 2, "name": "SUBATOMIC", "scale": 1e-15, "frequency": 1e12},
    {"layer": 3, "name": "ATOMIC", "scale": 1e-10, "frequency": 1e9},
    {"layer": 4, "name": "MOLECULAR", "scale": 1e-9, "frequency": 1e6},
    {"layer": 5, "name": "CELLULAR", "scale": 1e-6, "frequency": 1e3},
    {"layer": 6, "name": "TISSUE", "scale": 1e-3, "frequency": 1e2},
    {"layer": 7, "name": "ORGAN", "scale": 1e-1, "frequency": 1e1},
    {"layer": 8, "name": "SYSTEM", "scale": 1e0, "frequency": 1e0},
    {"layer": 9, "name": "ORGANISM", "scale": 1e0, "frequency": PHI},
    {"layer": 10, "name": "COLONY", "scale": 1e2, "frequency": 0.1},
    {"layer": 11, "name": "PLANETARY", "scale": 1e7, "frequency": SCHUMANN},
    {"layer": 12, "name": "COSMIC", "scale": 1e26, "frequency": 1e-18},
]

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# THREE HEARTS OF THE ORGANISM
# ═══════════════════════════════════════════════════════════════════════════════════════════════

THREE_HEARTS = {
    "METROPOLIS": {"frequency": 0.1, "role": "Backend computation, truth processing"},
    "COUPLING": {"frequency": PHI, "role": "Resonance, memory consolidation, phase sync"},
    "REGULATING": {"frequency": PHI_SQ, "role": "Full system orchestration, sovereign tick"},
}

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# HELPER FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

def phi_power(n: int) -> float:
    """Get φ raised to power n."""
    if n in PHI_POWERS:
        return PHI_POWERS[n]
    return math.pow(PHI, n)


def derive_frequency(beat: int, ring: int) -> float:
    """Derive a frequency from beat and ring position."""
    return SCHUMANN * SOLFEGGIO[beat % 9] * phi_power(ring)


def fibonacci_at(n: int) -> int:
    """Get the nth Fibonacci number."""
    if n < len(FIBONACCI):
        return FIBONACCI[n]
    # Compute if not pre-computed
    a, b = FIBONACCI[-2], FIBONACCI[-1]
    for _ in range(len(FIBONACCI), n + 1):
        a, b = b, a + b
    return b


__all__ = [
    "PHI", "PHI_SQ", "PHI_INV", "TORUS_R", "PHI_POWERS",
    "SCHUMANN", "SOLFEGGIO",
    "FIBONACCI",
    "BOLTZMANN", "PLANCK", "SPEED_OF_LIGHT",
    "SUBSTRATE_LAYERS",
    "THREE_HEARTS",
    "phi_power", "derive_frequency", "fibonacci_at",
]
