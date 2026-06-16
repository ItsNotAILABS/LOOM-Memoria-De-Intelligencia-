"""
ALPHA AI SYSTEMS — 25 Sovereign AI Orchestration Layer
=======================================================
Protocols: PROT-162 to PROT-186

The Alpha AI tier represents the highest-capability AI systems
in the MEDINA organism, operating at φ⁵ to φ⁷ frequencies.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
All Rights Reserved. ISIL-1.0 License.
"""

from .nova_prime import NovaPrime
from .memoria_maxima import MemoriaMaxima
from .vigilia_suprema import VigiliaSuprema
from .leges_prime import LegesPrime
from .mercatus_alpha import MercatusAlpha
from .sensoria_alpha import SensoriaAlpha
from .catena_alpha import CatenaAlpha
from .research_prime import ResearchPrime
from .integrator_alpha import IntegratorAlpha
from .doctrinae_alpha import DoctrinaeAlpha
from .alpha_registry import AlphaAIRegistry, get_registry

__all__ = [
    'NovaPrime',
    'MemoriaMaxima', 
    'VigiliaSuprema',
    'LegesPrime',
    'MercatusAlpha',
    'SensoriaAlpha',
    'CatenaAlpha',
    'ResearchPrime',
    'IntegratorAlpha',
    'DoctrinaeAlpha',
    'AlphaAIRegistry',
    'get_registry'
]

PHI = 1.6180339887498948482
SCHUMANN = 7.83

# Alpha AI Frequency Bands
ALPHA_FREQUENCIES = {
    'NOVA_PRIME': PHI ** 7,        # 29.03 Hz
    'MEMORIA_MAXIMA': PHI ** 6,    # 17.94 Hz
    'VIGILIA_SUPREMA': PHI ** 5,   # 11.09 Hz
    'LEGES_PRIME': PHI ** 4,       # 6.85 Hz
    'MERCATUS_ALPHA': PHI ** 3,    # 4.24 Hz
    'SENSORIA_ALPHA': PHI ** 3,    # 4.24 Hz
    'CATENA_ALPHA': PHI ** 5,      # 11.09 Hz
    'RESEARCH_PRIME': PHI ** 4,    # 6.85 Hz
    'INTEGRATOR_ALPHA': PHI ** 3,  # 4.24 Hz
    'DOCTRINAE_ALPHA': PHI ** 2,   # 2.62 Hz
}
