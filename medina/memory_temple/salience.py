"""
MEDINA Salience Engine — Memory priority and attention.

Manages salience scores for memory retrieval priority:
- Salience levels for categorization
- Decay and boost mechanisms
- Doctrine overlays for priority
"""

from __future__ import annotations

import time
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional

from .temple import MemoryTemple, MemoryNode


class SalienceLevel(Enum):
    """Categorical salience levels."""
    
    CRITICAL = "critical"       # 0.9 - 1.0: Must retain
    HIGH = "high"               # 0.7 - 0.9: Strong retention
    MEDIUM = "medium"           # 0.4 - 0.7: Normal retention
    LOW = "low"                 # 0.2 - 0.4: May decay
    NEGLIGIBLE = "negligible"   # 0.0 - 0.2: Decay candidate
    
    @classmethod
    def from_score(cls, score: float) -> "SalienceLevel":
        """Get level from numerical score."""
        if score >= 0.9:
            return cls.CRITICAL
        elif score >= 0.7:
            return cls.HIGH
        elif score >= 0.4:
            return cls.MEDIUM
        elif score >= 0.2:
            return cls.LOW
        else:
            return cls.NEGLIGIBLE


@dataclass
class SaliencePolicy:
    """Policy configuration for salience management."""
    
    # Decay configuration
    enable_decay: bool = True
    decay_rate: float = 0.01        # Per-beat decay
    decay_floor: float = 0.1        # Minimum salience
    
    # Access boost
    access_boost: float = 0.05      # Boost on access
    access_ceiling: float = 0.95    # Maximum from access
    
    # Pinned protection
    pinned_immune: bool = True      # Pinned memories don't decay
    
    # Doctrine overlay
    doctrine_multiplier: float = 1.5  # Boost for doctrine memories


@dataclass
class SalienceEvent:
    """Record of a salience change."""
    
    node_id: str
    old_score: float
    new_score: float
    reason: str
    beat: int
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "node_id": self.node_id,
            "old_score": round(self.old_score, 4),
            "new_score": round(self.new_score, 4),
            "reason": self.reason,
            "beat": self.beat,
            "timestamp": self.timestamp,
        }


class SalienceEngine:
    """
    MEDINA Salience Engine — Memory attention and priority.
    
    Manages which memories are prioritized for retrieval:
    - Natural decay over time
    - Boost on access (recency)
    - Promotion events (explicit)
    - Doctrine overlay (type-based priority)
    """
    
    def __init__(
        self,
        temple: MemoryTemple,
        policy: Optional[SaliencePolicy] = None,
    ) -> None:
        self._temple = temple
        self._policy = policy or SaliencePolicy()
        self._events: List[SalienceEvent] = []
        self._current_beat = 0
    
    # ------------------------------------------------------------------ #
    # Score Operations                                                      #
    # ------------------------------------------------------------------ #
    
    def get_level(self, node_id: str) -> Optional[SalienceLevel]:
        """Get salience level for a memory."""
        node = self._temple.get(node_id)
        if not node:
            return None
        return SalienceLevel.from_score(node.salience_score)
    
    def boost(
        self,
        node_id: str,
        amount: float,
        reason: str = "manual boost",
    ) -> Optional[float]:
        """Boost a memory's salience score."""
        node = self._temple.get(node_id)
        if not node:
            return None
        
        old_score = node.salience_score
        new_score = min(1.0, old_score + amount)
        
        node.salience_score = new_score
        node.updated_at = time.time()
        
        self._record_event(node_id, old_score, new_score, reason)
        return new_score
    
    def decay(
        self,
        node_id: str,
        amount: Optional[float] = None,
    ) -> Optional[float]:
        """Apply decay to a memory's salience."""
        node = self._temple.get(node_id)
        if not node:
            return None
        
        # Check pinned immunity
        if self._policy.pinned_immune and node.pinned:
            return node.salience_score
        
        old_score = node.salience_score
        decay_amount = amount if amount is not None else self._policy.decay_rate
        new_score = max(self._policy.decay_floor, old_score - decay_amount)
        
        node.salience_score = new_score
        node.updated_at = time.time()
        
        self._record_event(node_id, old_score, new_score, "decay")
        return new_score
    
    def on_access(self, node_id: str) -> Optional[float]:
        """Apply access boost to a memory."""
        node = self._temple.get(node_id)
        if not node:
            return None
        
        old_score = node.salience_score
        new_score = min(
            self._policy.access_ceiling,
            old_score + self._policy.access_boost,
        )
        
        if new_score > old_score:
            node.salience_score = new_score
            node.updated_at = time.time()
            self._record_event(node_id, old_score, new_score, "access boost")
        
        return new_score
    
    # ------------------------------------------------------------------ #
    # Batch Operations                                                      #
    # ------------------------------------------------------------------ #
    
    def apply_decay_all(self) -> int:
        """Apply decay to all non-immune memories."""
        if not self._policy.enable_decay:
            return 0
        
        count = 0
        for node in self._temple._nodes.values():
            if self._policy.pinned_immune and node.pinned:
                continue
            
            self.decay(node.node_id)
            count += 1
        
        return count
    
    def apply_doctrine_overlay(self) -> int:
        """Apply doctrine multiplier to doctrine-type memories."""
        from .temple import MemoryType
        
        count = 0
        for node in self._temple._nodes.values():
            if node.memory_type == MemoryType.DOCTRINE:
                old_score = node.salience_score
                new_score = min(1.0, old_score * self._policy.doctrine_multiplier)
                
                if new_score > old_score:
                    node.salience_score = new_score
                    self._record_event(
                        node.node_id,
                        old_score,
                        new_score,
                        "doctrine overlay",
                    )
                    count += 1
        
        return count
    
    # ------------------------------------------------------------------ #
    # Beat Integration                                                      #
    # ------------------------------------------------------------------ #
    
    def tick(self, beat: int) -> Dict[str, int]:
        """
        Process salience for a heartbeat cycle.
        
        Called by heartbeat orchestrator.
        """
        self._current_beat = beat
        
        # Apply periodic decay
        decay_count = 0
        if self._policy.enable_decay:
            decay_count = self.apply_decay_all()
        
        return {
            "beat": beat,
            "decayed": decay_count,
        }
    
    # ------------------------------------------------------------------ #
    # Analysis                                                              #
    # ------------------------------------------------------------------ #
    
    def distribution(self) -> Dict[str, int]:
        """Get distribution of memories across salience levels."""
        dist: Dict[str, int] = {level.value: 0 for level in SalienceLevel}
        
        for node in self._temple._nodes.values():
            level = SalienceLevel.from_score(node.salience_score)
            dist[level.value] += 1
        
        return dist
    
    def top_salient(self, limit: int = 10) -> List[MemoryNode]:
        """Get most salient memories."""
        nodes = list(self._temple._nodes.values())
        nodes.sort(key=lambda n: n.salience_score, reverse=True)
        return nodes[:limit]
    
    def decay_candidates(self, threshold: float = 0.2) -> List[MemoryNode]:
        """Get memories that are candidates for decay/archival."""
        return [
            n for n in self._temple._nodes.values()
            if n.salience_score < threshold and not n.pinned
        ]
    
    # ------------------------------------------------------------------ #
    # Events                                                                #
    # ------------------------------------------------------------------ #
    
    def _record_event(
        self,
        node_id: str,
        old_score: float,
        new_score: float,
        reason: str,
    ) -> None:
        """Record a salience change event."""
        event = SalienceEvent(
            node_id=node_id,
            old_score=old_score,
            new_score=new_score,
            reason=reason,
            beat=self._current_beat,
        )
        self._events.append(event)
    
    def get_events(
        self,
        node_id: Optional[str] = None,
        limit: int = 100,
    ) -> List[SalienceEvent]:
        """Query salience events."""
        events = self._events
        if node_id:
            events = [e for e in events if e.node_id == node_id]
        return events[-limit:]
    
    def clear_events(self) -> None:
        """Clear event history."""
        self._events.clear()
