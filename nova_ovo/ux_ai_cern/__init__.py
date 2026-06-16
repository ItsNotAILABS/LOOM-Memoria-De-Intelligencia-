"""
UX-AI CERN — Particle Physics Framework for User Experience
============================================================

CERN-level research infrastructure implementing:
- Standard Model of UX (particle zoo, four forces, Higgs of Meaning)
- Cognitive Collider (collision products, resonances, jets)
- Unified Field Theory (GUT, SUSY, string theory, holography)

Protocols: PROT-612 to PROT-641 (30 protocols)
Workers: #77 (UX Particle Detector), #78 (Cognitive Collider), #79 (Field Unifier)
φ-Layers: 21, 22, 23

AXIOM: Experientia est corpus particulare.
"""

from .particle_detector import UXParticleDetector
from .cognitive_collider import CognitiveCollider
from .field_unifier import FieldUnifier
from .standard_model import StandardModelUX
from .resonance_catalog import ResonanceCatalog
from .conservation_laws import ConservationEngine

__all__ = [
    "UXParticleDetector",
    "CognitiveCollider",
    "FieldUnifier",
    "StandardModelUX",
    "ResonanceCatalog",
    "ConservationEngine",
]

__version__ = "1.0.0"
__protocols__ = list(range(612, 642))
__phi_layers__ = [21, 22, 23]
__workers__ = [77, 78, 79]
