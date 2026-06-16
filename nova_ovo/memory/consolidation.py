"""
Memory Consolidation — Promotion/Consolidation Events
======================================================
Consolidation and promotion are explicit events.

Consolidation:
- Merges related memories
- Reduces noise
- Strengthens important connections

Promotion:
- Elevates memories to higher rings
- Increases salience
- Creates doctrine anchors
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, TYPE_CHECKING

if TYPE_CHECKING:
    from .temple import MemoryNode, MemoryTemple, SalienceLevel


class ConsolidationType(str, Enum):
    """Types of consolidation operations."""
    MERGE = "merge"           # Combine similar memories
    PRUNE = "prune"           # Remove dormant memories
    COMPRESS = "compress"     # Reduce detail, keep essence
    LINK = "link"             # Create connections
    ANCHOR = "anchor"         # Create doctrine anchor


class PromotionReason(str, Enum):
    """Reasons for memory promotion."""
    HIGH_ACCESS = "high_access"
    DOCTRINE_ALIGNED = "doctrine_aligned"
    CRITICAL_SALIENCE = "critical_salience"
    MANUAL = "manual"
    CONSOLIDATION_RESULT = "consolidation_result"


@dataclass
class ConsolidationEvent:
    """Record of a consolidation operation."""
    
    event_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    event_type: ConsolidationType = ConsolidationType.MERGE
    source_ids: List[str] = field(default_factory=list)
    result_id: Optional[str] = None
    beat: int = 0
    timestamp: float = field(default_factory=time.time)
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "event_id": self.event_id,
            "event_type": self.event_type.value,
            "source_ids": self.source_ids,
            "result_id": self.result_id,
            "beat": self.beat,
            "timestamp": self.timestamp,
            "metadata": self.metadata,
        }


@dataclass
class PromotionEvent:
    """Record of a memory promotion."""
    
    event_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    node_id: str = ""
    from_ring: int = 0
    to_ring: int = 0
    from_salience: str = ""
    to_salience: str = ""
    reason: PromotionReason = PromotionReason.MANUAL
    beat: int = 0
    timestamp: float = field(default_factory=time.time)
    evidence: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "event_id": self.event_id,
            "node_id": self.node_id,
            "from_ring": self.from_ring,
            "to_ring": self.to_ring,
            "from_salience": self.from_salience,
            "to_salience": self.to_salience,
            "reason": self.reason.value,
            "beat": self.beat,
            "timestamp": self.timestamp,
            "evidence": self.evidence,
        }


class ConsolidationEngine:
    """
    Engine for memory consolidation and promotion.
    
    Consolidation and promotion are explicit events with evidence trails.
    """
    
    def __init__(self, temple: Optional["MemoryTemple"] = None) -> None:
        self._temple = temple
        self._consolidation_events: List[ConsolidationEvent] = []
        self._promotion_events: List[PromotionEvent] = []
        self._consolidation_threshold = 0.8  # Angular distance threshold for merge
        self._promotion_access_threshold = 10  # Access count for auto-promotion
    
    def bind_temple(self, temple: "MemoryTemple") -> None:
        """Bind to a memory temple."""
        self._temple = temple
    
    def consolidate(
        self,
        consolidation_type: ConsolidationType = ConsolidationType.MERGE,
        ring: Optional[int] = None,
        max_operations: int = 100,
    ) -> List[ConsolidationEvent]:
        """
        Run consolidation cycle.
        
        Returns list of consolidation events performed.
        """
        if self._temple is None:
            return []
        
        events: List[ConsolidationEvent] = []
        
        if consolidation_type == ConsolidationType.MERGE:
            events = self._consolidate_merge(ring, max_operations)
        elif consolidation_type == ConsolidationType.PRUNE:
            events = self._consolidate_prune(ring, max_operations)
        elif consolidation_type == ConsolidationType.LINK:
            events = self._consolidate_link(ring, max_operations)
        
        self._consolidation_events.extend(events)
        return events
    
    def _consolidate_merge(
        self,
        ring: Optional[int],
        max_operations: int,
    ) -> List[ConsolidationEvent]:
        """Merge similar memories."""
        if self._temple is None:
            return []
        
        events: List[ConsolidationEvent] = []
        processed: set = set()
        
        nodes = list(self._temple._nodes.values())
        if ring is not None:
            nodes = [n for n in nodes if n.ring == ring]
        
        for i, node1 in enumerate(nodes):
            if node1.node_id in processed or len(events) >= max_operations:
                break
            
            for node2 in nodes[i+1:]:
                if node2.node_id in processed:
                    continue
                
                # Check if similar (close in angular distance, same type)
                if (node1.memory_type == node2.memory_type and
                    node1.angular_distance(node2) < self._consolidation_threshold):
                    
                    # Mark as consolidated
                    node1.consolidated = True
                    node2.consolidated = True
                    
                    # Create event
                    event = ConsolidationEvent(
                        event_type=ConsolidationType.MERGE,
                        source_ids=[node1.node_id, node2.node_id],
                        result_id=node1.node_id,  # Keep first node
                        beat=self._temple.current_beat,
                        metadata={
                            "angular_distance": node1.angular_distance(node2),
                            "memory_type": node1.memory_type.value,
                        },
                    )
                    events.append(event)
                    processed.add(node2.node_id)
        
        return events
    
    def _consolidate_prune(
        self,
        ring: Optional[int],
        max_operations: int,
    ) -> List[ConsolidationEvent]:
        """Prune dormant memories."""
        if self._temple is None:
            return []
        
        from .temple import SalienceLevel
        
        events: List[ConsolidationEvent] = []
        
        nodes = list(self._temple._nodes.values())
        if ring is not None:
            nodes = [n for n in nodes if n.ring == ring]
        
        # Find dormant nodes
        dormant = [n for n in nodes if n.salience == SalienceLevel.DORMANT]
        
        for node in dormant[:max_operations]:
            event = ConsolidationEvent(
                event_type=ConsolidationType.PRUNE,
                source_ids=[node.node_id],
                beat=self._temple.current_beat,
                metadata={
                    "reason": "dormant_salience",
                    "access_count": node.access_count,
                },
            )
            events.append(event)
            # Note: actual deletion would happen here in production
        
        return events
    
    def _consolidate_link(
        self,
        ring: Optional[int],
        max_operations: int,
    ) -> List[ConsolidationEvent]:
        """Create links between related memories."""
        if self._temple is None:
            return []
        
        events: List[ConsolidationEvent] = []
        
        nodes = list(self._temple._nodes.values())
        if ring is not None:
            nodes = [n for n in nodes if n.ring == ring]
        
        # Find nodes with common tags
        tag_map: Dict[str, List[str]] = {}
        for node in nodes:
            for tag in node.tags:
                if tag not in tag_map:
                    tag_map[tag] = []
                tag_map[tag].append(node.node_id)
        
        # Create links for nodes sharing tags
        for tag, node_ids in tag_map.items():
            if len(node_ids) > 1 and len(events) < max_operations:
                event = ConsolidationEvent(
                    event_type=ConsolidationType.LINK,
                    source_ids=node_ids[:5],  # Max 5 per link event
                    beat=self._temple.current_beat,
                    metadata={"shared_tag": tag},
                )
                events.append(event)
        
        return events
    
    def promote(
        self,
        node_id: str,
        to_ring: Optional[int] = None,
        to_salience: Optional["SalienceLevel"] = None,
        reason: PromotionReason = PromotionReason.MANUAL,
        evidence: Optional[Dict[str, Any]] = None,
    ) -> Optional[PromotionEvent]:
        """
        Promote a memory node.
        
        Increases ring level and/or salience.
        """
        if self._temple is None:
            return None
        
        from .temple import SalienceLevel
        
        node = self._temple.get(node_id)
        if node is None:
            return None
        
        # Determine promotion targets
        target_ring = to_ring if to_ring is not None else node.ring + 1
        target_salience = to_salience if to_salience is not None else self._next_salience(node.salience)
        
        # Create promotion event
        event = PromotionEvent(
            node_id=node_id,
            from_ring=node.ring,
            to_ring=target_ring,
            from_salience=node.salience.value,
            to_salience=target_salience.value,
            reason=reason,
            beat=self._temple.current_beat,
            evidence=evidence or {},
        )
        
        # Apply promotion
        node.ring = target_ring
        node.salience = target_salience
        node.promoted = True
        node.promotion_ring = target_ring
        node.depth = 1.0 + (target_ring * 0.1)
        
        self._promotion_events.append(event)
        return event
    
    def _next_salience(self, current: "SalienceLevel") -> "SalienceLevel":
        """Get next higher salience level."""
        from .temple import SalienceLevel
        
        order = [
            SalienceLevel.DORMANT,
            SalienceLevel.LOW,
            SalienceLevel.MEDIUM,
            SalienceLevel.HIGH,
            SalienceLevel.CRITICAL,
        ]
        
        idx = order.index(current)
        if idx < len(order) - 1:
            return order[idx + 1]
        return current
    
    def auto_promote(self, max_promotions: int = 10) -> List[PromotionEvent]:
        """
        Auto-promote memories based on access patterns and doctrine alignment.
        """
        if self._temple is None:
            return []
        
        events: List[PromotionEvent] = []
        
        for node in self._temple._nodes.values():
            if len(events) >= max_promotions:
                break
            
            if node.promoted:
                continue
            
            # Check high access
            if node.access_count >= self._promotion_access_threshold:
                event = self.promote(
                    node.node_id,
                    reason=PromotionReason.HIGH_ACCESS,
                    evidence={"access_count": node.access_count},
                )
                if event:
                    events.append(event)
                continue
            
            # Check doctrine alignment
            if node.doctrine_alignment >= 0.95:
                event = self.promote(
                    node.node_id,
                    reason=PromotionReason.DOCTRINE_ALIGNED,
                    evidence={"doctrine_alignment": node.doctrine_alignment},
                )
                if event:
                    events.append(event)
        
        return events
    
    def get_consolidation_history(self, limit: int = 100) -> List[ConsolidationEvent]:
        """Get consolidation event history."""
        return self._consolidation_events[-limit:]
    
    def get_promotion_history(self, limit: int = 100) -> List[PromotionEvent]:
        """Get promotion event history."""
        return self._promotion_events[-limit:]
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get consolidation/promotion statistics."""
        return {
            "total_consolidations": len(self._consolidation_events),
            "total_promotions": len(self._promotion_events),
            "consolidation_by_type": self._count_by_type(self._consolidation_events),
            "promotion_by_reason": self._count_by_reason(self._promotion_events),
        }
    
    def _count_by_type(self, events: List[ConsolidationEvent]) -> Dict[str, int]:
        counts: Dict[str, int] = {}
        for e in events:
            t = e.event_type.value
            counts[t] = counts.get(t, 0) + 1
        return counts
    
    def _count_by_reason(self, events: List[PromotionEvent]) -> Dict[str, int]:
        counts: Dict[str, int] = {}
        for e in events:
            r = e.reason.value
            counts[r] = counts.get(r, 0) + 1
        return counts
