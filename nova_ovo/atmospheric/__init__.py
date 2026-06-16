"""
ATMOSPHERIC INTELLIGENCE — Module Initialization
=================================================
Protocol: PROT-220 to PROT-245
Frequency: φ⁴ = 6.854 Hz (Atmospheric Layer)

The atmospheric intelligence module implements L-43, L-44, L-45 laws
for civilizational sky broadcasting, field-wide signal priority,
and atmospheric organ classification.

26 Internal AGI Systems:
- 6 Alpha systems (PROT-220-225)
- 7 Beta production systems (PROT-226-232)
- 6 Gamma helper systems (PROT-233-238)
- 7 Delta worker systems (PROT-239-245)

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
All Rights Reserved. ISIL-1.0 License.
"""

from .phi_math_core import (
    PHI, PHI_INV, PHI_SQ, PHI_CU, PHI_4, PHI_5, PHI_6, PHI_7,
    TAU, SCHUMANN, FIBONACCI,
    build_dimensional_stack,
    compute_signal_to_noise,
    compute_coverage_ratio,
    phi_weighted_average,
    fibonacci_threshold,
    atmospheric_event_to_torus,
    torus_to_cartesian,
    compute_circular_coverage,
    compute_elliptical_coverage,
    coverage_meets_threshold,
    compute_governance_weight,
    phi_governance_hierarchy,
    compute_resonance_factor,
    schumann_alignment,
    evaluate_l43_threshold,
    evaluate_l44_threshold,
    evaluate_l45_threshold,
    ATMOSPHERIC_MATH_CONSTANTS,
    DimensionalPlane,
    TorusCoordinate
)

from .agi_registry import (
    AtmosphericAGIRegistry,
    get_atmospheric_registry,
    InternalAGISystem,
    SystemTier,
    SystemStatus,
    ATMOSPHERIC_ALPHA_SYSTEMS,
    ATMOSPHERIC_BETA_SYSTEMS,
    ATMOSPHERIC_GAMMA_SYSTEMS,
    ATMOSPHERIC_DELTA_SYSTEMS
)

__all__ = [
    # Math constants
    'PHI', 'PHI_INV', 'PHI_SQ', 'PHI_CU', 'PHI_4', 'PHI_5', 'PHI_6', 'PHI_7',
    'TAU', 'SCHUMANN', 'FIBONACCI',
    
    # Math functions
    'build_dimensional_stack',
    'compute_signal_to_noise',
    'compute_coverage_ratio',
    'phi_weighted_average',
    'fibonacci_threshold',
    'atmospheric_event_to_torus',
    'torus_to_cartesian',
    'compute_circular_coverage',
    'compute_elliptical_coverage',
    'coverage_meets_threshold',
    'compute_governance_weight',
    'phi_governance_hierarchy',
    'compute_resonance_factor',
    'schumann_alignment',
    'evaluate_l43_threshold',
    'evaluate_l44_threshold',
    'evaluate_l45_threshold',
    'ATMOSPHERIC_MATH_CONSTANTS',
    'DimensionalPlane',
    'TorusCoordinate',
    
    # AGI Registry
    'AtmosphericAGIRegistry',
    'get_atmospheric_registry',
    'InternalAGISystem',
    'SystemTier',
    'SystemStatus',
    'ATMOSPHERIC_ALPHA_SYSTEMS',
    'ATMOSPHERIC_BETA_SYSTEMS',
    'ATMOSPHERIC_GAMMA_SYSTEMS',
    'ATMOSPHERIC_DELTA_SYSTEMS'
]

# Module version
__version__ = 'φ.0.1.0'
__protocol_range__ = 'PROT-220 to PROT-245'
__laws__ = ['L-43', 'L-44', 'L-45']
