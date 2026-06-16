"""
UX-AI CERN OS Systems — Internal Operating System Layer
=========================================================

Core operating system infrastructure for the CERN-Level UX-AI
Research Trilogy (Dissertations LXIII-LXV).

Implements:
- Particle Detection OS (real-time fermion/boson classification)
- Collision Event OS (intent-prediction collision event loop)
- Unified Field OS (force unification runtime)
- Publication Pipeline OS (Zenodo + X distribution)

Protocols: PROT-612 to PROT-641
Workers: #77, #78, #79
"""

from .particle_detection_os import ParticleDetectionOS
from .collision_event_os import CollisionEventOS
from .unified_field_os import UnifiedFieldOS
from .publication_pipeline import PublicationPipeline

__all__ = [
    "ParticleDetectionOS",
    "CollisionEventOS",
    "UnifiedFieldOS",
    "PublicationPipeline",
]

__version__ = "1.0.0"
__protocols__ = list(range(612, 642))
