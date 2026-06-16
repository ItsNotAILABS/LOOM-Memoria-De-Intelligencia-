"""
Memory Temple — MEDINA V1
=========================
Memory as navigable geometry (helix/ring/coordinates), not chat logs.
Retrieval is path-based, lineage-aware, replayable.
Consolidation and promotion are explicit events.
User + system traverse same memory topology.

Coordinate system:
- theta: angular position on helix ring ∈ [0, 2π)
- phi: toroidal rotation ∈ [0, 2π)
- depth: radial depth ρ ∈ ℝ₊
- ring: memory ring index ∈ ℕ
- beat: discrete time counter ∈ ℕ
"""

from .temple import MemoryTemple, MemoryNode
from .navigation import MemoryNavigator, TorusCoordinate
from .consolidation import ConsolidationEngine, PromotionEvent
from .pass6 import (
    IusMemoriaCore,
    MemoryRight,
    ChronostratiMemoryEngine,
    TemporalLayer,
    TextusProbationisEngine,
)

__all__ = [
    "MemoryTemple",
    "MemoryNode",
    "MemoryNavigator",
    "TorusCoordinate",
    "ConsolidationEngine",
    "PromotionEvent",
    "IusMemoriaCore",
    "MemoryRight",
    "ChronostratiMemoryEngine",
    "TemporalLayer",
    "TextusProbationisEngine",
]
