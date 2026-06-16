"""
Memoria Agents — Memory Temple Bot Fleet
=========================================

Three sovereign memory bots for the Medina Organism Memory Temple:
  - MemoriaIndexBot  (INDEXATOR)  — indexes all memory objects
  - MemoriaCompressBot (COMPRESSOR) — consolidates duplicate/redundant memories
  - MemoriaRecallBot (RECUPERATOR) — tests memory recall health

All bots follow L-005: Agent Existence Law
  - Always-on, not alive
  - No feelings, no stress — just memory work

Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
"""

from .memoria_index_bot   import MemoriaIndexBot,    run_indexator
from .memoria_compress_bot import MemoriaCompressBot, run_compressor
from .memoria_recall_bot  import MemoriaRecallBot,   run_recuperator

__all__ = [
    "MemoriaIndexBot",    "run_indexator",
    "MemoriaCompressBot", "run_compressor",
    "MemoriaRecallBot",   "run_recuperator",
]
