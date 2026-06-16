"""
MEDINA Memory Temple — The operational memory workspace.

Memory Temple is MEDINA's core substrate (not a plugin):
- Memory as navigable geometry (helix/ring/coordinates), not chat logs
- Retrieval is path-based, lineage-aware, replayable
- Consolidation and promotion are explicit events
- User + system traverse same memory topology

COORDINATE SYSTEM (Toroidal Memory Geometry):
  θ (theta) — angular position on helix ring [0, 2π)
  φ (phi)   — toroidal rotation [0, 2π)
  ρ (depth) — radial depth (salience)
  β (beat)  — discrete time (beat counter)
  ring      — memory ring index

Cartesian embedding:
  x = (R + ρ·cos θ)·cos φ
  y = (R + ρ·cos θ)·sin φ
  z = ρ·sin θ
  t = β · Δt_beat

MEMORY OPERATIONS:
  find    — locate memories by query/coordinates
  pin     — mark memory for preservation
  map     — visualize memory topology
  promote — elevate memory to higher salience
  consolidate — merge related memories
  traverse — navigate memory paths
"""

from .temple import MemoryTemple, MemoryNode, MemoryCoordinates
from .navigation import MemoryNavigator, NavigationPath
from .salience import SalienceEngine, SalienceLevel

__all__ = [
    "MemoryTemple",
    "MemoryNode",
    "MemoryCoordinates",
    "MemoryNavigator",
    "NavigationPath",
    "SalienceEngine",
    "SalienceLevel",
]
