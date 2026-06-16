"""
UX AI — Interaction Intelligence (PROT-584)
Predictive interaction model and gesture intelligence.
"""

from __future__ import annotations
from typing import Any, Dict, List, Optional, Tuple
from dataclasses import dataclass, field
from enum import Enum
from datetime import datetime

PHI: float = 1.6180339887498948482


class GestureType(Enum):
    TAP = "tap"
    DOUBLE_TAP = "double_tap"
    LONG_PRESS = "long_press"
    SWIPE_LEFT = "swipe_left"
    SWIPE_RIGHT = "swipe_right"
    SWIPE_UP = "swipe_up"
    SWIPE_DOWN = "swipe_down"
    PINCH = "pinch"
    SPREAD = "spread"
    ROTATE = "rotate"
    PAN = "pan"
    HOVER = "hover"
    SCROLL = "scroll"


@dataclass
class InteractionEvent:
    """A recorded interaction event."""
    event_type: str
    target_id: str
    timestamp: str = field(default_factory=lambda: datetime.utcnow().isoformat())
    position: Tuple[int, int] = (0, 0)
    velocity: float = 0.0
    pressure: float = 1.0
    metadata: Dict[str, Any] = field(default_factory=dict)


@dataclass
class PredictedAction:
    """An AI-predicted next action."""
    action: str
    target_id: str
    confidence: float
    reasoning: str
    suggested_preload: Optional[str] = None


class InteractionAI:
    """
    Predictive Interaction Intelligence — PROT-584
    Learns user behavior patterns and predicts next actions.
    """

    def __init__(self):
        self.history: List[InteractionEvent] = []
        self.patterns: Dict[str, List[str]] = {}
        self.hotspots: Dict[str, int] = {}

    def record(self, event: InteractionEvent) -> None:
        """Record an interaction event."""
        self.history.append(event)
        self.hotspots[event.target_id] = self.hotspots.get(event.target_id, 0) + 1

        # Update sequential patterns
        if len(self.history) >= 2:
            prev = self.history[-2].target_id
            if prev not in self.patterns:
                self.patterns[prev] = []
            self.patterns[prev].append(event.target_id)

    def predict_next(self, current_target: str) -> List[PredictedAction]:
        """Predict most likely next user actions."""
        predictions = []

        if current_target in self.patterns:
            next_targets = self.patterns[current_target]
            # Count frequencies
            freq: Dict[str, int] = {}
            for t in next_targets:
                freq[t] = freq.get(t, 0) + 1

            total = len(next_targets)
            sorted_targets = sorted(freq.items(), key=lambda x: x[1], reverse=True)

            for target, count in sorted_targets[:5]:
                confidence = count / total
                predictions.append(PredictedAction(
                    action="navigate",
                    target_id=target,
                    confidence=round(confidence, 3),
                    reasoning=f"User navigated to {target} {count}/{total} times after {current_target}",
                    suggested_preload=target if confidence > 0.5 else None,
                ))

        return predictions

    def get_hotspots(self, top_n: int = 10) -> List[Dict[str, Any]]:
        """Get the most interacted-with targets."""
        sorted_spots = sorted(self.hotspots.items(), key=lambda x: x[1], reverse=True)
        return [
            {"target_id": target, "interactions": count, "heat": count / max(1, sum(self.hotspots.values()))}
            for target, count in sorted_spots[:top_n]
        ]

    def suggest_shortcuts(self) -> List[Dict[str, Any]]:
        """Suggest keyboard shortcuts based on usage patterns."""
        hotspots = self.get_hotspots(5)
        shortcuts = []
        keys = ["1", "2", "3", "4", "5"]
        for i, spot in enumerate(hotspots):
            shortcuts.append({
                "target": spot["target_id"],
                "shortcut": f"Ctrl+{keys[i]}",
                "reason": f"Top #{i+1} most used ({spot['interactions']} interactions)",
            })
        return shortcuts

    def calculate_fitts_time(self, distance: float, target_width: float) -> float:
        """Calculate Fitts's Law movement time (ms)."""
        import math
        a = 50   # intercept (ms)
        b = 150  # slope (ms/bit)
        index_of_difficulty = math.log2(2 * distance / target_width) if target_width > 0 else 0
        return a + b * max(0, index_of_difficulty)

    def optimize_target_sizes(self, targets: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """Optimize target sizes using Fitts's Law and usage frequency."""
        optimized = []
        max_freq = max((t.get("frequency", 1) for t in targets), default=1)

        for target in targets:
            freq = target.get("frequency", 1)
            base_size = target.get("size", 44)
            # More frequent targets get larger hit areas
            scale = 1 + (freq / max_freq) * (PHI - 1)
            optimized.append({
                **target,
                "optimized_size": int(base_size * scale),
                "min_size": 44,  # WCAG minimum
                "scale_factor": round(scale, 3),
            })

        return optimized

    def status(self) -> Dict[str, Any]:
        return {
            "protocol": "PROT-584",
            "events_recorded": len(self.history),
            "patterns_learned": len(self.patterns),
            "hotspots_tracked": len(self.hotspots),
        }


# Singleton
interaction_ai = InteractionAI()

__all__ = ["InteractionAI", "InteractionEvent", "PredictedAction", "GestureType", "interaction_ai"]
