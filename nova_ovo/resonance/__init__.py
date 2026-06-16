"""
Tier-11 Cross-Organism Resonance System
========================================
Cross-organism resonance enables organisms working as a team to pulse
and influence each other's shell state.

The resonance bus connects organisms at Tier-11, allowing:
- Shared resonance state propagation
- Shell-state influence with bounded coupling
- Collective phase synchronization
- Team pulse coordination

Mathematical Foundation (Kuramoto Coupling):
  d(θᵢ)/dt = ωᵢ + Σⱼ Kᵢⱼ sin(θⱼ - θᵢ)

Where:
  θᵢ = phase of organism i
  ωᵢ = natural frequency of organism i
  Kᵢⱼ = coupling strength between organisms i and j
"""

from .bus import ResonanceBus, OrganismConnection, ResonanceState
from .coupling import (
    CouplingMatrix,
    CouplingRule,
    BoundedCoupling,
    compute_kuramoto_coupling,
)
from .propagation import (
    ResonancePropagator,
    PropagationEvent,
    PropagationResult,
    ShellInfluence,
)

__all__ = [
    # Bus
    "ResonanceBus",
    "OrganismConnection",
    "ResonanceState",
    # Coupling
    "CouplingMatrix",
    "CouplingRule",
    "BoundedCoupling",
    "compute_kuramoto_coupling",
    # Propagation
    "ResonancePropagator",
    "PropagationEvent",
    "PropagationResult",
    "ShellInfluence",
]
