"""
Sovereign Nodes — N1-N12 Macro Hierarchy
========================================
N1–N12 sovereign macro hierarchy as control topology.

The sovereign hierarchy maintains:
- Constitutional authority
- Governance oversight
- Doctrine enforcement
- Gate control
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional


class NodeLevel(str, Enum):
    """Sovereignty levels for macro nodes."""
    ABSOLUTE = "absolute"     # N1 - Constitutional root
    LAW = "law"               # N2-N3 - Law definition
    MODEL = "model"           # N4-N5 - Model governance
    ENGINE = "engine"         # N6-N7 - Engine control
    CORE = "core"             # N8-N9 - Core operations
    MODULE = "module"         # N10 - Module coordination
    LAB = "lab"               # N11 - Lab/experimental
    WORKFORCE = "workforce"   # N12 - Workforce oversight


class NodeStatus(str, Enum):
    """Node operational status."""
    ACTIVE = "active"
    DORMANT = "dormant"
    MAINTENANCE = "maintenance"
    ERROR = "error"


# Node level mapping
NODE_LEVELS: Dict[int, NodeLevel] = {
    1: NodeLevel.ABSOLUTE,
    2: NodeLevel.LAW,
    3: NodeLevel.LAW,
    4: NodeLevel.MODEL,
    5: NodeLevel.MODEL,
    6: NodeLevel.ENGINE,
    7: NodeLevel.ENGINE,
    8: NodeLevel.CORE,
    9: NodeLevel.CORE,
    10: NodeLevel.MODULE,
    11: NodeLevel.LAB,
    12: NodeLevel.WORKFORCE,
}


@dataclass
class SovereignNode:
    """
    A sovereign macro node (N1-N12).
    
    Each node represents a level in the control topology
    with specific governance and oversight responsibilities.
    """
    
    node_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    index: int = 1  # N1 through N12
    name: str = ""
    level: NodeLevel = NodeLevel.CORE
    status: NodeStatus = NodeStatus.ACTIVE
    
    # Hierarchy
    parent_index: Optional[int] = None
    child_indices: List[int] = field(default_factory=list)
    
    # Authority
    authority_scope: List[str] = field(default_factory=list)
    gate_control: List[str] = field(default_factory=list)  # Gates this node controls
    
    # State
    doctrine_alignment: float = 1.0
    coherence: float = 1.0
    last_beat: int = 0
    
    # Audit
    decisions: List[Dict[str, Any]] = field(default_factory=list)
    created_at: float = field(default_factory=time.time)
    
    @property
    def node_name(self) -> str:
        return f"N{self.index}"
    
    def is_ancestor_of(self, other_index: int) -> bool:
        """Check if this node is an ancestor of another."""
        return self.index < other_index
    
    def can_override(self, other_index: int) -> bool:
        """Check if this node can override another."""
        return self.index < other_index and self.status == NodeStatus.ACTIVE
    
    def record_decision(
        self,
        decision_type: str,
        target: str,
        outcome: str,
        evidence: Optional[Dict[str, Any]] = None,
    ) -> Dict[str, Any]:
        """Record a governance decision."""
        decision = {
            "decision_id": str(uuid.uuid4()),
            "node": self.node_name,
            "decision_type": decision_type,
            "target": target,
            "outcome": outcome,
            "evidence": evidence or {},
            "timestamp": time.time(),
        }
        self.decisions.append(decision)
        return decision
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "node_id": self.node_id,
            "node_name": self.node_name,
            "index": self.index,
            "name": self.name,
            "level": self.level.value,
            "status": self.status.value,
            "parent_index": self.parent_index,
            "child_indices": self.child_indices,
            "authority_scope": self.authority_scope,
            "gate_control": self.gate_control,
            "doctrine_alignment": self.doctrine_alignment,
            "coherence": self.coherence,
            "last_beat": self.last_beat,
            "decision_count": len(self.decisions),
            "created_at": self.created_at,
        }


class MacroHierarchy:
    """
    Manager for N1-N12 sovereign macro hierarchy.
    
    The hierarchy provides:
    - Constitutional control topology
    - Governance oversight cascade
    - Authority delegation
    - Gate control distribution
    """
    
    def __init__(self) -> None:
        self._nodes: Dict[int, SovereignNode] = {}
        self._init_hierarchy()
    
    def _init_hierarchy(self) -> None:
        """Initialize the N1-N12 hierarchy."""
        # Define node properties
        node_defs = [
            (1, "Constitutional Root", NodeLevel.ABSOLUTE, None, ["A", "B", "C"]),
            (2, "Primary Law", NodeLevel.LAW, 1, ["A"]),
            (3, "Secondary Law", NodeLevel.LAW, 1, ["A"]),
            (4, "Model Governance Alpha", NodeLevel.MODEL, 2, ["B"]),
            (5, "Model Governance Beta", NodeLevel.MODEL, 2, ["B"]),
            (6, "Engine Control Alpha", NodeLevel.ENGINE, 4, []),
            (7, "Engine Control Beta", NodeLevel.ENGINE, 5, []),
            (8, "Core Operations Alpha", NodeLevel.CORE, 6, []),
            (9, "Core Operations Beta", NodeLevel.CORE, 7, []),
            (10, "Module Coordinator", NodeLevel.MODULE, 8, []),
            (11, "Lab Oversight", NodeLevel.LAB, 9, []),
            (12, "Workforce Manager", NodeLevel.WORKFORCE, 10, ["C"]),
        ]
        
        for idx, name, level, parent, gates in node_defs:
            node = SovereignNode(
                index=idx,
                name=name,
                level=level,
                parent_index=parent,
                gate_control=gates,
                authority_scope=[level.value],
            )
            self._nodes[idx] = node
        
        # Build child relationships
        for node in self._nodes.values():
            if node.parent_index:
                parent = self._nodes.get(node.parent_index)
                if parent:
                    parent.child_indices.append(node.index)
    
    def get_node(self, index: int) -> Optional[SovereignNode]:
        """Get node by index (1-12)."""
        return self._nodes.get(index)
    
    def get_by_level(self, level: NodeLevel) -> List[SovereignNode]:
        """Get all nodes at a given level."""
        return [n for n in self._nodes.values() if n.level == level]
    
    def get_ancestry(self, index: int) -> List[SovereignNode]:
        """Get ancestry chain from node to root."""
        chain: List[SovereignNode] = []
        current = self._nodes.get(index)
        
        while current:
            chain.append(current)
            if current.parent_index:
                current = self._nodes.get(current.parent_index)
            else:
                break
        
        return chain
    
    def get_descendants(self, index: int) -> List[SovereignNode]:
        """Get all descendants of a node."""
        result: List[SovereignNode] = []
        queue = [index]
        
        while queue:
            current_idx = queue.pop(0)
            current = self._nodes.get(current_idx)
            if current and current_idx != index:
                result.append(current)
            if current:
                queue.extend(current.child_indices)
        
        return result
    
    def check_authority(self, actor_node: int, target_scope: str) -> bool:
        """Check if a node has authority over a scope."""
        node = self._nodes.get(actor_node)
        if not node or node.status != NodeStatus.ACTIVE:
            return False
        
        # Check direct authority
        if target_scope in node.authority_scope:
            return True
        
        # Check inherited authority from ancestors
        for ancestor in self.get_ancestry(actor_node):
            if target_scope in ancestor.authority_scope:
                return True
        
        return False
    
    def propagate_decision(
        self,
        from_node: int,
        decision_type: str,
        target: str,
        outcome: str,
        evidence: Optional[Dict[str, Any]] = None,
    ) -> List[Dict[str, Any]]:
        """Propagate a decision down the hierarchy."""
        decisions: List[Dict[str, Any]] = []
        
        node = self._nodes.get(from_node)
        if not node:
            return decisions
        
        # Record at source
        decisions.append(node.record_decision(decision_type, target, outcome, evidence))
        
        # Propagate to descendants
        for descendant in self.get_descendants(from_node):
            decisions.append(descendant.record_decision(
                f"inherited_{decision_type}",
                target,
                outcome,
                {"source_node": from_node, **(evidence or {})},
            ))
        
        return decisions
    
    def update_beat(self, beat: int) -> None:
        """Update all nodes with current beat."""
        for node in self._nodes.values():
            node.last_beat = beat
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get hierarchy statistics."""
        nodes = list(self._nodes.values())
        
        by_level: Dict[str, int] = {}
        by_status: Dict[str, int] = {}
        
        for n in nodes:
            by_level[n.level.value] = by_level.get(n.level.value, 0) + 1
            by_status[n.status.value] = by_status.get(n.status.value, 0) + 1
        
        total_decisions = sum(len(n.decisions) for n in nodes)
        avg_coherence = sum(n.coherence for n in nodes) / len(nodes)
        
        return {
            "total_nodes": len(nodes),
            "by_level": by_level,
            "by_status": by_status,
            "total_decisions": total_decisions,
            "avg_coherence": avg_coherence,
        }
    
    def to_dict(self) -> Dict[str, Any]:
        """Get full hierarchy as dict."""
        return {
            "nodes": {n.node_name: n.to_dict() for n in self._nodes.values()},
            "statistics": self.get_statistics(),
        }
