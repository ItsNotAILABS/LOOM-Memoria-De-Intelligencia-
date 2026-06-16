"""
CANISTER BRIDGE — PRODUCTION ICP INTEGRATION
=============================================
Latin Name: PONS CANISTRI PRODUCTIO
Protocol: PROT-513 — CANISTER BRIDGE PRODUCTION LAYER
Frequency: φ¹⁵ = 1364.0 Hz (Production Canister Layer)

"Pons inter Python et Motoko firmus stat."
(The bridge between Python and Motoko stands firm.)

This module provides REAL integration with ICP canisters using
the @dfinity/agent Python bindings (ic-py).

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL
"""

from .agent_factory import (
    CanisterAgentFactory,
    ProductionCanisterConnection,
    CanisterCallResult,
    PRODUCTION_NETWORKS,
)
from .deep_memory_client import (
    DeepMemoryCanisterClient,
    WorkingSlot,
    HippocampalEntry,
    TorusCoordinate,
    DeepMemoryStatus,
)
from .unified_bridge import (
    UnifiedProductionBridge,
    BridgeHealthStatus,
)

__all__ = [
    # Factory
    "CanisterAgentFactory",
    "ProductionCanisterConnection",
    "CanisterCallResult",
    "PRODUCTION_NETWORKS",
    # Deep Memory Client
    "DeepMemoryCanisterClient",
    "WorkingSlot",
    "HippocampalEntry",
    "TorusCoordinate",
    "DeepMemoryStatus",
    # Unified Bridge
    "UnifiedProductionBridge",
    "BridgeHealthStatus",
]

# ═══════════════════════════════════════════════════════════════════════════
# MODULE IDENTITY
# ═══════════════════════════════════════════════════════════════════════════

PHI = 1.6180339887498948482
PHI_15 = 1364.0008  # φ¹⁵

MODULE_IDENTITY = {
    "name": "nova_ovo.canister_bridge",
    "latin_name": "PONS CANISTRI PRODUCTIO",
    "protocol": "PROT-513",
    "frequency_hz": PHI_15,
    "layer": 9,  # Organism
    "classification": "SOVEREIGN-ALPHA",
    "primitive_trace": "RELATION → ADDRESS → MEMORY → φ",
    "law_reference": "L-96: Production bridges require health verification",
}
