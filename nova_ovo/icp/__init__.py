"""
Nova OVO ICP Package — Python-to-ICP Bridge

This package provides the bridge between the Python runtime (nova_ovo)
and the ICP canister backend (medina_backend).

All intelligence queries from the Python runtime flow through this bridge
to execute on-chain in the ICP canisters.

Architecture:
    Python Runtime (nova_ovo)
           ↓
    canister_client.py (this package)
           ↓
    ICP Actor Calls
           ↓
    medina_backend canister
           ↓
    Three Hearts Intelligence Routing
           ↓
    Model Execution (57 models)
           ↓
    Response with ANIMA hash

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
"""

from .canister_client import (
    ICPCanisterClient,
    IntelligenceQuery,
    IntelligenceResponse,
    RouteSource,
    ClusterTarget,
    Priority,
)

__all__ = [
    "ICPCanisterClient",
    "IntelligenceQuery",
    "IntelligenceResponse",
    "RouteSource",
    "ClusterTarget",
    "Priority",
]
