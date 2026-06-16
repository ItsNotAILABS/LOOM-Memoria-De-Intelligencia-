"""
ATMOSPHERIC INTELLIGENCE CORE — φ-Mathematics Backend
======================================================
Protocol: PROT-220 to PROT-225
Frequency: φ⁴ = 6.854 Hz (Atmospheric Layer)

Core mathematical foundations for atmospheric/civilizational intelligence:
- Dimensional plane calculations
- φ-weighted signal processing
- Torus coordinate mapping for atmospheric events
- Coverage geometry calculations

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
All Rights Reserved. ISIL-1.0 License.
"""

import math
from dataclasses import dataclass
from typing import Tuple, List, Optional

# ═══════════════════════════════════════════════════════════════════════════
# φ-CONSTANTS — The Mathematical Foundation
# ═══════════════════════════════════════════════════════════════════════════

PHI = 1.6180339887498948482
PHI_SQ = PHI ** 2  # 2.618033988749895
PHI_CU = PHI ** 3  # 4.23606797749979
PHI_4 = PHI ** 4   # 6.854101966249685
PHI_5 = PHI ** 5   # 11.090169943749476
PHI_6 = PHI ** 6   # 17.94427190999916
PHI_7 = PHI ** 7   # 29.034441853748632

PHI_INV = 1 / PHI  # 0.6180339887498949
PHI_INV_SQ = PHI_INV ** 2  # 0.3819660112501051

TAU = 2 * math.pi
SCHUMANN = 7.83  # Earth's fundamental resonance

# Fibonacci sequence for threshold calculations
FIBONACCI = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987]


# ═══════════════════════════════════════════════════════════════════════════
# DIMENSIONAL PLANE MATHEMATICS
# ═══════════════════════════════════════════════════════════════════════════

@dataclass
class DimensionalPlane:
    """A dimensional plane in the atmospheric intelligence stack."""
    index: int
    phi_weight: float
    frequency_hz: float
    coverage_threshold: float
    name: str


def build_dimensional_stack(num_planes: int = 5) -> List[DimensionalPlane]:
    """
    Build the dimensional plane stack with φ-derived weights.
    
    Each plane has:
    - Weight: φⁿ where n = plane index
    - Frequency: base_freq × φⁿ
    - Coverage threshold: φ⁻¹ for all planes (0.618)
    """
    planes = []
    base_freq = 1.0  # 1 Hz base
    
    for i in range(num_planes):
        weight = PHI ** i
        freq = base_freq * weight
        
        plane = DimensionalPlane(
            index=i,
            phi_weight=weight,
            frequency_hz=freq,
            coverage_threshold=PHI_INV,
            name=f"PLANE_{i}_PHI_{i}"
        )
        planes.append(plane)
    
    return planes


# ═══════════════════════════════════════════════════════════════════════════
# SIGNAL PROCESSING MATHEMATICS
# ═══════════════════════════════════════════════════════════════════════════

def compute_signal_to_noise(signal: float, noise: float) -> float:
    """
    Compute signal-to-noise ratio.
    
    L-44 threshold: SNR >= φ = 1.618
    """
    if noise <= 0:
        return float('inf')
    return signal / noise


def compute_coverage_ratio(covered_area: float, total_area: float) -> float:
    """
    Compute territorial coverage ratio.
    
    L-43/L-44/L-45 threshold: coverage >= φ⁻¹ = 0.618
    """
    if total_area <= 0:
        return 0.0
    return min(1.0, covered_area / total_area)


def phi_weighted_average(values: List[float], plane_indices: List[int]) -> float:
    """
    Compute φ-weighted average across dimensional planes.
    
    weight_i = φⁱ
    result = Σ(value_i × φⁱ) / Σ(φⁱ)
    """
    if not values or len(values) != len(plane_indices):
        return 0.0
    
    weighted_sum = sum(v * (PHI ** i) for v, i in zip(values, plane_indices))
    weight_sum = sum(PHI ** i for i in plane_indices)
    
    return weighted_sum / weight_sum if weight_sum > 0 else 0.0


def fibonacci_threshold(index: int) -> int:
    """
    Get Fibonacci threshold for a given index.
    
    Used for memory ring thresholds and channel activation.
    """
    if 0 <= index < len(FIBONACCI):
        return FIBONACCI[index]
    # Compute dynamically for larger indices
    if index >= len(FIBONACCI):
        a, b = FIBONACCI[-2], FIBONACCI[-1]
        for _ in range(index - len(FIBONACCI) + 1):
            a, b = b, a + b
        return b
    return 1


# ═══════════════════════════════════════════════════════════════════════════
# TORUS COORDINATE MATHEMATICS
# ═══════════════════════════════════════════════════════════════════════════

@dataclass
class TorusCoordinate:
    """Torus coordinate for atmospheric event mapping."""
    theta: float  # [0, 2π) helix angle
    phi: float    # [0, 2π) toroidal angle
    rho: float    # radial depth / salience
    ring: int     # temporal ring


def atmospheric_event_to_torus(
    signal_strength: float,
    coverage: float,
    timestamp: float,
    base_beat: int = 0
) -> TorusCoordinate:
    """
    Map an atmospheric event to torus coordinates.
    
    Uses the AU Infinity formula adapted for atmospheric events:
    - θ derived from coverage geometry
    - φ derived from signal strength
    - ρ derived from event intensity
    - ring from temporal beat
    """
    # Golden angle advancement
    delta_theta = TAU / (PHI_SQ * 10)
    delta_phi = TAU / (PHI_CU * 10)
    
    # Compute coordinates
    beat = base_beat + int(timestamp * PHI_4)
    theta = (coverage * TAU + beat * delta_theta) % TAU
    phi_coord = (signal_strength * TAU / 100 + beat * delta_phi) % TAU
    rho = PHI + coverage * signal_strength / 100
    ring = beat // fibonacci_threshold(10)  # F(10) = 55
    
    return TorusCoordinate(
        theta=theta,
        phi=phi_coord,
        rho=rho,
        ring=ring
    )


def torus_to_cartesian(coord: TorusCoordinate, major_radius: float = PHI * 10) -> Tuple[float, float, float]:
    """
    Convert torus coordinates to Cartesian (x, y, z).
    
    x = (R + ρ·cos θ)·cos φ
    y = (R + ρ·cos θ)·sin φ
    z = ρ·sin θ
    """
    R = major_radius
    x = (R + coord.rho * math.cos(coord.theta)) * math.cos(coord.phi)
    y = (R + coord.rho * math.cos(coord.theta)) * math.sin(coord.phi)
    z = coord.rho * math.sin(coord.theta)
    return (x, y, z)


# ═══════════════════════════════════════════════════════════════════════════
# COVERAGE GEOMETRY MATHEMATICS
# ═══════════════════════════════════════════════════════════════════════════

def compute_circular_coverage(
    center_lat: float,
    center_lon: float,
    radius_km: float,
    territory_area_km2: float
) -> float:
    """
    Compute coverage ratio for circular atmospheric event.
    
    Uses spherical geometry approximation for Earth surface.
    """
    # πr² for circular coverage
    covered_area = math.pi * (radius_km ** 2)
    return compute_coverage_ratio(covered_area, territory_area_km2)


def compute_elliptical_coverage(
    semi_major_km: float,
    semi_minor_km: float,
    territory_area_km2: float
) -> float:
    """
    Compute coverage ratio for elliptical atmospheric event.
    
    Storm systems often have elliptical coverage patterns.
    """
    # πab for elliptical coverage
    covered_area = math.pi * semi_major_km * semi_minor_km
    return compute_coverage_ratio(covered_area, territory_area_km2)


def coverage_meets_threshold(coverage: float, threshold: float = PHI_INV) -> bool:
    """
    Check if coverage meets the φ⁻¹ threshold.
    
    Default threshold: 0.618 (golden ratio inverse)
    """
    return coverage >= threshold


# ═══════════════════════════════════════════════════════════════════════════
# GOVERNANCE WEIGHT MATHEMATICS
# ═══════════════════════════════════════════════════════════════════════════

def compute_governance_weight(
    l43_active: bool,
    l44_forced: bool,
    l45_organ: bool,
    synchronization_level: float = 0.0
) -> float:
    """
    Compute aggregate governance weight from L-43, L-44, L-45 states.
    
    Base weight: 1.0
    L-43 adds: synchronization_level × 0.1
    L-44 multiplies: × φ when forced
    L-45 multiplies: × φ when organ active
    """
    weight = 1.0
    
    if l43_active:
        weight *= (1 + synchronization_level * 0.1)
    
    if l44_forced:
        weight *= PHI
    
    if l45_organ:
        weight *= PHI
    
    return weight


def phi_governance_hierarchy(base_weight: float, tier: int) -> float:
    """
    Apply φ-hierarchy to governance weight.
    
    Higher tiers get exponentially more weight.
    """
    return base_weight * (PHI ** tier)


# ═══════════════════════════════════════════════════════════════════════════
# FREQUENCY RESONANCE MATHEMATICS
# ═══════════════════════════════════════════════════════════════════════════

def compute_resonance_factor(freq1: float, freq2: float) -> float:
    """
    Compute resonance factor between two frequencies.
    
    Perfect resonance (ratio = 1.0) returns 1.0
    φ-harmonic ratios return high values
    """
    if freq2 <= 0:
        return 0.0
    
    ratio = freq1 / freq2
    
    # Check for φ-harmonic relationships
    phi_harmonics = [1.0, PHI, PHI_SQ, PHI_CU, PHI_4, PHI_INV, PHI_INV_SQ]
    
    for harmonic in phi_harmonics:
        if abs(ratio - harmonic) < 0.01:  # 1% tolerance
            return 1.0 - abs(ratio - harmonic) / harmonic
    
    # Non-harmonic: return inverse of distance from nearest harmonic
    min_distance = min(abs(ratio - h) for h in phi_harmonics)
    return max(0.0, 1.0 - min_distance)


def schumann_alignment(frequency: float) -> float:
    """
    Compute alignment with Schumann resonance (7.83 Hz).
    
    Returns 1.0 for perfect alignment, decreases with distance.
    """
    return compute_resonance_factor(frequency, SCHUMANN)


# ═══════════════════════════════════════════════════════════════════════════
# THRESHOLD DECISION FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════

def evaluate_l43_threshold(coverage: float) -> bool:
    """L-43: coverage >= φ⁻¹ = 0.618"""
    return coverage >= PHI_INV


def evaluate_l44_threshold(snr: float, coverage: float) -> bool:
    """L-44: SNR >= φ = 1.618 AND coverage >= φ⁻¹ = 0.618"""
    return snr >= PHI and coverage >= PHI_INV


def evaluate_l45_threshold(coverage: float, channels: int) -> bool:
    """L-45: coverage >= φ⁻¹ = 0.618 AND channels >= 3"""
    return coverage >= PHI_INV and channels >= 3


# ═══════════════════════════════════════════════════════════════════════════
# MATHEMATICAL CONSTANTS EXPORT
# ═══════════════════════════════════════════════════════════════════════════

ATMOSPHERIC_MATH_CONSTANTS = {
    'PHI': PHI,
    'PHI_INV': PHI_INV,
    'PHI_POWERS': [PHI ** i for i in range(8)],
    'TAU': TAU,
    'SCHUMANN': SCHUMANN,
    'FIBONACCI': FIBONACCI,
    'L43_THRESHOLD': PHI_INV,
    'L44_SNR_THRESHOLD': PHI,
    'L44_COVERAGE_THRESHOLD': PHI_INV,
    'L45_COVERAGE_THRESHOLD': PHI_INV,
    'L45_CHANNEL_THRESHOLD': 3,
    'GOVERNANCE_MULTIPLIER': PHI
}
