"""
Pattern Detector — DETECTOR EXEMPLORUM
========================================

PROT-647: Cross-system pattern recognition for LOOKING GLASS.

Detects emergent patterns that span multiple subsystems and would
be invisible to any single subsystem operating alone.
"""

from dataclasses import dataclass, field
from typing import Dict, List, Any, Optional
from datetime import datetime, timezone


PHI = 1.618033988749895


@dataclass
class Pattern:
    """An emergent pattern detected across subsystems."""
    pattern_id: str
    name: str
    description: str
    source_systems: List[str]
    confidence: float
    pattern_type: str  # emergent, recurring, convergent, evolutionary, anomalous
    first_detected: datetime = field(default_factory=lambda: datetime.now(timezone.utc))
    occurrences: int = 1


class PatternDetector:
    """
    DETECTOR EXEMPLORUM — Cross-System Pattern Detector.

    Finds emergent patterns that span multiple subsystems and would
    be invisible without the unified observation of LOOKING GLASS.
    """

    def __init__(self):
        self._detected_patterns: Dict[str, Pattern] = {}
        self._pattern_counter = 0
        self._observation_buffer: List[Dict[str, Any]] = []

    def observe(self, system: str, event_type: str, data: Any):
        """Record an observation for pattern analysis."""
        self._observation_buffer.append({
            "system": system,
            "event_type": event_type,
            "data": data,
            "timestamp": datetime.now(timezone.utc),
        })

    def detect(self) -> List[Pattern]:
        """
        Run pattern detection across all buffered observations.

        Returns newly detected or reinforced patterns.
        """
        if len(self._observation_buffer) < 2:
            return []

        new_patterns = []

        # Group by event type
        type_groups: Dict[str, List] = {}
        for obs in self._observation_buffer:
            key = obs["event_type"]
            if key not in type_groups:
                type_groups[key] = []
            type_groups[key].append(obs)

        # Detect recurring patterns (same event across multiple systems)
        for event_type, observations in type_groups.items():
            systems = list(set(obs["system"] for obs in observations))
            if len(systems) > 1:
                pattern = self._create_pattern(
                    name=f"CROSS_SYSTEM_{event_type.upper()}",
                    description=f"Event '{event_type}' observed across {len(systems)} systems: {', '.join(systems)}",
                    systems=systems,
                    pattern_type="recurring",
                    confidence=min(1.0, len(systems) / 5.0),
                )
                new_patterns.append(pattern)

        # Detect convergent patterns (multiple events in same time window)
        if len(self._observation_buffer) >= 3:
            recent = self._observation_buffer[-10:]
            recent_systems = list(set(obs["system"] for obs in recent))
            if len(recent_systems) >= 3:
                pattern = self._create_pattern(
                    name="MULTI_SYSTEM_CONVERGENCE",
                    description=f"Simultaneous activity across {len(recent_systems)} systems",
                    systems=recent_systems,
                    pattern_type="convergent",
                    confidence=min(1.0, len(recent_systems) / 7.0),
                )
                new_patterns.append(pattern)

        self._observation_buffer.clear()
        return new_patterns

    def _create_pattern(self, name: str, description: str, systems: List[str],
                        pattern_type: str, confidence: float) -> Pattern:
        """Create or reinforce a pattern."""
        # Check if pattern already exists
        for existing in self._detected_patterns.values():
            if existing.name == name and set(existing.source_systems) == set(systems):
                existing.occurrences += 1
                existing.confidence = min(1.0, existing.confidence + 0.05)
                return existing

        self._pattern_counter += 1
        pattern = Pattern(
            pattern_id=f"PAT-{self._pattern_counter:06d}",
            name=name,
            description=description,
            source_systems=systems,
            confidence=confidence,
            pattern_type=pattern_type,
        )
        self._detected_patterns[pattern.pattern_id] = pattern
        return pattern

    def get_patterns(self) -> List[Dict[str, Any]]:
        """Return all detected patterns."""
        return [
            {
                "pattern_id": p.pattern_id,
                "name": p.name,
                "description": p.description,
                "source_systems": p.source_systems,
                "confidence": p.confidence,
                "type": p.pattern_type,
                "occurrences": p.occurrences,
            }
            for p in self._detected_patterns.values()
        ]
