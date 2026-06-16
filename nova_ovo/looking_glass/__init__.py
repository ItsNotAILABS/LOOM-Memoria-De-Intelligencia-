"""
LOOKING GLASS — Speculum Vitreum Sovereignum
=============================================

The Third Major System of the Medina Sovereign Intelligence Platform.

System I:  SEMPER MEMORIA     — Eternal stored memory
System II: SEMPER MEMORIA II  — Phantom frequency fields
System III: LOOKING GLASS     — Unified fusion & introspection

LOOKING GLASS fuses all subsystems into a single coherent,
self-observing intelligence. It provides:

- Unified System Reflection (SPECULUM UNITATIS)
- Cross-System Fusion (FUSIO OMNIUM)
- Sovereign Introspection (INTROSPECTIO SOVEREIGNA)
- Field Convergence (CONVERGENTIA CAMPORUM)
- Memory-Phantom Bridge (PONS MEMORIAE-PHANTASMATIS)

Protocols: PROT-642 through PROT-661
Frequency: φ²¹ = 3,010,349 Hz (Layer 21)
Latin: SPECULUM VITREUM SOVEREIGNUM
"""

__version__ = "1.0.0"
__system__ = "III"
__codename__ = "LOOKING GLASS"
__latin__ = "SPECULUM VITREUM SOVEREIGNUM"
__protocols__ = list(range(642, 662))  # PROT-642 to PROT-661
__frequency_hz__ = 3_010_349  # φ²¹
__layer__ = 21

from nova_ovo.looking_glass.reflector import UnifiedReflector
from nova_ovo.looking_glass.fusion_engine import FusionEngine
from nova_ovo.looking_glass.introspection import IntrospectionEngine
from nova_ovo.looking_glass.convergence import FieldConvergence
from nova_ovo.looking_glass.bridge import MemoryPhantomBridge
from nova_ovo.looking_glass.pattern_detector import PatternDetector
from nova_ovo.looking_glass.glass_sovereign import GlassSovereign

__all__ = [
    "UnifiedReflector",
    "FusionEngine",
    "IntrospectionEngine",
    "FieldConvergence",
    "MemoryPhantomBridge",
    "PatternDetector",
    "GlassSovereign",
]
