"""
UI Surfaces — Platform Interface Surfaces
==========================================
New UI surfaces for the expanded MEDINA platform:

1. THE WORLD Surface — PHI geometry and Schumann-frequency lighting
2. Designer Hub — Manufacturer catalog, project intelligence, CEU tracker
3. FORMA Leaderboard — Designer rankings and achievements
4. Architecture Stack — Doctrine → Procedures → Engine → Three Computers → Output
5. Glassmorphism Design System — Full UI redesign constants

Each surface is a vertical slice that can be feature-flagged.
"""

from .constants import (
    # PHI geometry
    PHI,
    PHI_SQUARED,
    PHI_CUBED,
    PHI_INVERSE,
    GOLDEN_ANGLE,
    
    # Schumann frequencies
    SCHUMANN_BASE,
    SCHUMANN_HARMONICS,
    
    # Glassmorphism
    GLASS_BLUR,
    GLASS_OPACITY,
    GLASS_BORDER,
    GLASS_COLORS,
)
from .world import TheWorldSurface, WorldGeometry, SchumannLighting
from .designer_hub import (
    DesignerHub,
    ManufacturerCatalog,
    ProjectIntelligence,
    CEUTracker,
    DesignTeamPreset,
)
from .leaderboard import FORMALeaderboard, LeaderboardEntry, RankingMetric
from .architecture import (
    ArchitectureSurface,
    StackLayer,
    StackFlow,
)

__all__ = [
    # Constants
    "PHI",
    "PHI_SQUARED",
    "PHI_CUBED",
    "PHI_INVERSE",
    "GOLDEN_ANGLE",
    "SCHUMANN_BASE",
    "SCHUMANN_HARMONICS",
    "GLASS_BLUR",
    "GLASS_OPACITY",
    "GLASS_BORDER",
    "GLASS_COLORS",
    # World
    "TheWorldSurface",
    "WorldGeometry",
    "SchumannLighting",
    # Designer Hub
    "DesignerHub",
    "ManufacturerCatalog",
    "ProjectIntelligence",
    "CEUTracker",
    "DesignTeamPreset",
    # Leaderboard
    "FORMALeaderboard",
    "LeaderboardEntry",
    "RankingMetric",
    # Architecture
    "ArchitectureSurface",
    "StackLayer",
    "StackFlow",
]
