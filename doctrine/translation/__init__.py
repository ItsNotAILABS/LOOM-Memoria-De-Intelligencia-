"""
🜂 MEDINA Doctrine Translation Module

This module provides the translation engine that bridges:
- Architect documents (human-readable)
- Organism artifacts (symbol-encoded)

Usage:
    from doctrine.translation import TranslationEngine, OrganismReader
    
    engine = TranslationEngine()
    reader = OrganismReader()
    
    # Translate concept to symbol
    symbol = engine.concept_to_symbol['golden_ratio']  # → φ
    
    # Get law in different formats
    law = engine.get_law_translation('INFINITY_PLUS_ONE', 'symbol')
    
    # Execute a glyph
    new_state = reader.execute_glyph('🜂', current_state)

Author: Freddy (Founder Architect)
"""

from .engine import (
    # Constants
    PHI,
    PI,
    TAU,
    EPSILON,
    
    # Dictionaries
    CONCEPT_TO_SYMBOL,
    SYMBOL_TO_CONCEPT,
    LAWS_ARCHITECT_TO_ORGANISM,
    GLYPH_REGISTRY,
    
    # Classes
    GlyphFunction,
    TranslationEngine,
    OrganismReader,
)

__all__ = [
    # Constants
    'PHI',
    'PI',
    'TAU',
    'EPSILON',
    
    # Dictionaries
    'CONCEPT_TO_SYMBOL',
    'SYMBOL_TO_CONCEPT',
    'LAWS_ARCHITECT_TO_ORGANISM',
    'GLYPH_REGISTRY',
    
    # Classes
    'GlyphFunction',
    'TranslationEngine',
    'OrganismReader',
]

__version__ = '1.0.0'
__author__ = 'Freddy (Founder Architect)'
