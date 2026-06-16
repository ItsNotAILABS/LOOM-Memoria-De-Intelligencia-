"""
Cross-System Fusion Engine — FUSIO OMNIUM
==========================================

PROT-643: Synthesizes signals from all subsystems into unified intelligence.

Takes disparate signals from 76+ workers, 180+ Motoko engines, 60+ Python
modules and produces coherent intelligence streams.
"""

from dataclasses import dataclass, field
from typing import Dict, List, Any, Optional, Callable
from datetime import datetime, timezone


PHI = 1.618033988749895


@dataclass
class Signal:
    """A signal from any subsystem."""
    source: str
    signal_type: str  # data, frequency, event, state, pattern
    payload: Any
    timestamp: datetime = field(default_factory=lambda: datetime.now(timezone.utc))
    strength: float = 1.0
    layer: int = 0


@dataclass
class FusedStream:
    """A unified intelligence stream produced by fusion."""
    stream_id: str
    sources: List[str]
    fused_signal: Any
    coherence: float
    timestamp: datetime = field(default_factory=lambda: datetime.now(timezone.utc))
    fusion_method: str = "phi_harmonic"


class FusionEngine:
    """
    FUSIO OMNIUM — The Cross-System Fusion Engine.

    Receives signals from all subsystems and fuses them into unified
    intelligence streams. No system operates in isolation when viewed
    through LOOKING GLASS.
    """

    def __init__(self):
        self._signal_buffer: List[Signal] = []
        self._fused_streams: List[FusedStream] = []
        self._fusion_rules: Dict[str, Callable] = {}
        self._stream_counter = 0

    def ingest(self, signal: Signal):
        """Ingest a signal from any subsystem."""
        self._signal_buffer.append(signal)

    def ingest_batch(self, signals: List[Signal]):
        """Ingest multiple signals at once."""
        self._signal_buffer.extend(signals)

    def fuse(self) -> List[FusedStream]:
        """
        Execute fusion across all buffered signals.

        Groups signals by compatibility, applies phi-harmonic weighting,
        and produces unified intelligence streams.
        """
        if not self._signal_buffer:
            return []

        # Group signals by type
        groups: Dict[str, List[Signal]] = {}
        for signal in self._signal_buffer:
            key = signal.signal_type
            if key not in groups:
                groups[key] = []
            groups[key].append(signal)

        streams = []
        for signal_type, signals in groups.items():
            stream = self._fuse_group(signal_type, signals)
            if stream:
                streams.append(stream)

        # Cross-type fusion for related signals
        if len(groups) > 1:
            cross_stream = self._cross_fuse(groups)
            if cross_stream:
                streams.append(cross_stream)

        self._fused_streams.extend(streams)
        self._signal_buffer.clear()
        return streams

    def _fuse_group(self, signal_type: str, signals: List[Signal]) -> Optional[FusedStream]:
        """Fuse a group of same-type signals."""
        if not signals:
            return None

        self._stream_counter += 1

        # Phi-harmonic weighted aggregation
        total_weight = 0.0
        weighted_payloads = []
        for i, signal in enumerate(signals):
            weight = signal.strength * (PHI ** (-i))  # Fibonacci decay
            total_weight += weight
            weighted_payloads.append({
                "source": signal.source,
                "payload": signal.payload,
                "weight": weight,
                "layer": signal.layer,
            })

        # Calculate coherence
        if len(signals) > 1:
            strengths = [s.strength for s in signals]
            mean_strength = sum(strengths) / len(strengths)
            variance = sum((s - mean_strength) ** 2 for s in strengths) / len(strengths)
            coherence = 1.0 - min(1.0, variance)
        else:
            coherence = 1.0

        return FusedStream(
            stream_id=f"FUSIO-{self._stream_counter:06d}",
            sources=[s.source for s in signals],
            fused_signal={
                "type": signal_type,
                "components": weighted_payloads,
                "total_weight": total_weight,
                "signal_count": len(signals),
            },
            coherence=coherence,
            fusion_method="phi_harmonic_decay",
        )

    def _cross_fuse(self, groups: Dict[str, List[Signal]]) -> Optional[FusedStream]:
        """Cross-type fusion to find inter-system patterns."""
        self._stream_counter += 1

        all_sources = set()
        cross_signals = []
        for signal_type, signals in groups.items():
            for s in signals:
                all_sources.add(s.source)
                cross_signals.append({"type": signal_type, "source": s.source, "layer": s.layer})

        return FusedStream(
            stream_id=f"CROSS-{self._stream_counter:06d}",
            sources=list(all_sources),
            fused_signal={
                "fusion_type": "cross_system",
                "type_count": len(groups),
                "total_signals": sum(len(s) for s in groups.values()),
                "cross_map": cross_signals,
            },
            coherence=min(1.0, len(groups) / 5.0 * PHI / PHI),
            fusion_method="cross_type_synthesis",
        )

    def get_streams(self) -> List[Dict[str, Any]]:
        """Return all fused streams."""
        return [
            {
                "stream_id": s.stream_id,
                "sources": s.sources,
                "coherence": s.coherence,
                "fusion_method": s.fusion_method,
                "timestamp": s.timestamp.isoformat(),
            }
            for s in self._fused_streams
        ]

    def register_fusion_rule(self, name: str, rule: Callable):
        """Register a custom fusion rule."""
        self._fusion_rules[name] = rule
