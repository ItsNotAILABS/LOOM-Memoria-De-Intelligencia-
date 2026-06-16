"""
CPL — Cognitive Procurement Language
=====================================
The substrate for organism-to-organism communication.

CPL is not HTTP. Not REST. Not JSON-RPC.
CPL is pure architecture. Pure math.

All organisms communicate through CPL messages that encode:
- State transforms (not text)
- Authority (gate level)
- Lineage (provenance chain)
- Resonance (doctrine alignment)
- Torus coordinates (spatial position)

Mathematical Foundation:
- Messages are vectors in 4D state space
- Authority is cryptographically signed
- Resonance computed via Kuramoto order parameter
- Routing via torus topology (nearest-neighbor preference)
"""

from .protocol import (
    CPLMessage,
    CPLIntent,
    CPLAuthority,
    CPLRouter,
    CPLPayload,
    TorusCoords,
    create_cpl_message,
    validate_cpl_message,
    PHI,
    PHASE_SCALE_FACTOR,
    TORUS_MAJOR_RADIUS,
    MAX_VECTOR_MAGNITUDE,
)

from .substrate import (
    CPLSubstrate,
    SubstrateConfig,
    MessageQueue,
    OrganismNode,
    DEFAULT_COUPLING_STRENGTH,
)

__all__ = [
    # Protocol
    "CPLMessage",
    "CPLIntent",
    "CPLAuthority",
    "CPLRouter",
    "CPLPayload",
    "TorusCoords",
    "create_cpl_message",
    "validate_cpl_message",
    # Constants
    "PHI",
    "PHASE_SCALE_FACTOR",
    "TORUS_MAJOR_RADIUS",
    "MAX_VECTOR_MAGNITUDE",
    "DEFAULT_COUPLING_STRENGTH",
    # Substrate
    "CPLSubstrate",
    "SubstrateConfig",
    "MessageQueue",
    "OrganismNode",
]
