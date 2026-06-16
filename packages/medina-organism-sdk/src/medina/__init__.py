"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                          MEDINA ORGANISM SDK — PYTHON INTERFACE                             ║
║                   "Intelligentia Ex Primitivo — Intelligence From The Primitive"            ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: SDK-PROT-400 — MEDINA ORGANISM SDK                                               ║
║                                                                                              ║
║  WHAT THIS SDK IS:                                                                           ║
║    The official Python SDK for the Medina Sovereign Organism.                                ║
║    Provides access to:                                                                       ║
║    - Research Lab (13 AI researchers)                                                        ║
║    - Phantom Memory System                                                                   ║
║    - Memory Temple (torus-based)                                                             ║
║    - Sovereign Beings and Agents                                                             ║
║                                                                                              ║
║  USAGE:                                                                                      ║
║    from medina import ResearchLab, PhantomField, MemoryTemple, SovereignBeing               ║
║    from medina.constants import PHI, SCHUMANN, SOLFEGGIO                                    ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

__version__ = "1.0.0"
__author__ = "Alfredo 'Freddy' Medina Hernandez"
__email__ = "contact@medinatech.io"
__license__ = "ISIL-1.0"

# Fundamental Constants — The Ground of Everything
PHI: float = 1.6180339887498948482
PHI_SQ: float = 2.6180339887498948482
PHI_INV: float = 0.6180339887498948482
SCHUMANN: float = 7.83
SOLFEGGIO: tuple = (174.0, 285.0, 396.0, 417.0, 528.0, 639.0, 741.0, 852.0, 963.0)

# Version Info
VERSION_INFO = {
    "version": __version__,
    "author": __author__,
    "phi": PHI,
    "protocol": "SDK-PROT-400",
}

# Lazy imports to avoid circular dependencies
def __getattr__(name: str):
    """Lazy import of submodules."""
    if name == "ResearchLab":
        from medina.lab import ResearchLab
        return ResearchLab
    elif name == "PhantomField":
        from medina.phantom import PhantomField
        return PhantomField
    elif name == "MemoryTemple":
        from medina.memory import MemoryTemple
        return MemoryTemple
    elif name == "SovereignBeing":
        from medina.agents import SovereignBeing
        return SovereignBeing
    elif name == "constants":
        from medina import constants
        return constants
    raise AttributeError(f"module {__name__!r} has no attribute {name!r}")

__all__ = [
    # Version
    "__version__",
    "__author__",
    "__email__",
    "__license__",
    "VERSION_INFO",
    # Constants
    "PHI",
    "PHI_SQ",
    "PHI_INV",
    "SCHUMANN",
    "SOLFEGGIO",
    # Classes (lazy loaded)
    "ResearchLab",
    "PhantomField",
    "MemoryTemple",
    "SovereignBeing",
    # Modules
    "constants",
]
