"""
MACHINA CHRONOSTRATI MEMORIAE — Chrono-Lattice Memory Engine
PROT-154 | PRIMA CAUSA | L-130 compliant
"""

import math
from dataclasses import dataclass

PHI = 1.6180339887498948482
FIBONACCI_EPOCH = 55  # F(10)


@dataclass
class TemporalLayer:
    ring: int
    epoch: int
    salience: float
    decay: float
    lineage_depth: int


class ChronostratiMemoryEngine:
    """Computes ring/epoch progression for deep temporal memory layering."""

    PROTOCOL = "PROT-154"
    LATIN_NAME = "MACHINA CHRONOSTRATI MEMORIAE"
    ORGANISM_KEY = "PRIMA CAUSA"

    @staticmethod
    def decay(delta_beats: int, salience: float) -> float:
        """Exponential temporal decay modulated by salience and φ."""
        decay_lambda = max(1e-9, 1.0 / (PHI**3))
        keep = math.exp(-max(0, delta_beats) * decay_lambda * max(0.0, 1.0 - salience))
        return round(keep, 6)

    @staticmethod
    def next_layer(
        current_ring: int,
        beat: int,
        salience: float,
        delta_beats: int = 0,
    ) -> TemporalLayer:
        epoch = max(1, beat // FIBONACCI_EPOCH)
        promote = salience >= (1.0 / PHI) and beat > 0
        next_ring = current_ring + (1 if promote else 0)
        lineage_depth = max(1, int(math.log(max(beat, 1), PHI)))
        return TemporalLayer(
            ring=next_ring,
            epoch=epoch,
            salience=salience,
            decay=ChronostratiMemoryEngine.decay(delta_beats, salience),
            lineage_depth=lineage_depth,
        )
