"""
Memory Temple — Working Environment
====================================
Memory is operational space, not static history.

The Memory Temple provides:
- Helix/ring traversal
- Coordinate addressing
- Lineage navigation
- Salience + doctrine overlays
- Promotion/consolidation markers
- Shared traversal path for user and system
"""

from __future__ import annotations

import math
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

# Import core constants
from ..core.recital import PHI, TORUS_R


class MemoryType(str, Enum):
    """Types of memory nodes."""
    EPISODIC = "episodic"       # Event-based memories
    SEMANTIC = "semantic"       # Factual/conceptual
    PROCEDURAL = "procedural"   # How-to knowledge
    WORKING = "working"         # Active context
    DOCTRINE = "doctrine"       # Core principles


class SalienceLevel(str, Enum):
    """Salience levels for memory prioritization."""
    CRITICAL = "critical"
    HIGH = "high"
    MEDIUM = "medium"
    LOW = "low"
    DORMANT = "dormant"


@dataclass
class MemoryNode:
    """
    A single node in the Memory Temple.
    
    Each node has torus coordinates and lineage tracking.
    """
    
    node_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    content: str = ""
    memory_type: MemoryType = MemoryType.EPISODIC
    salience: SalienceLevel = SalienceLevel.MEDIUM
    
    # Torus coordinates
    theta: float = 0.0      # helix angle ∈ [0, 2π)
    phi: float = 0.0        # toroidal rotation ∈ [0, 2π)
    depth: float = 1.0      # radial depth ρ
    ring: int = 0           # memory ring index
    beat: int = 0           # creation beat
    
    # Lineage
    parent_id: Optional[str] = None
    children_ids: List[str] = field(default_factory=list)
    
    # Metadata
    created_at: float = field(default_factory=time.time)
    accessed_at: float = field(default_factory=time.time)
    access_count: int = 0
    tags: List[str] = field(default_factory=list)
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    # Doctrine overlay
    doctrine_alignment: float = 1.0  # ∈ [0, 1]
    
    # Consolidation markers
    consolidated: bool = False
    promoted: bool = False
    promotion_ring: Optional[int] = None
    
    def torus_xyz(self) -> Tuple[float, float, float]:
        """Cartesian embedding on torus surface."""
        rho = self.depth
        th = self.theta
        ph = self.phi
        x = (TORUS_R + rho * math.cos(th)) * math.cos(ph)
        y = (TORUS_R + rho * math.cos(th)) * math.sin(ph)
        z = rho * math.sin(th)
        return x, y, z
    
    def distance_to(self, other: "MemoryNode") -> float:
        """Euclidean distance in torus space."""
        x1, y1, z1 = self.torus_xyz()
        x2, y2, z2 = other.torus_xyz()
        return math.sqrt((x2-x1)**2 + (y2-y1)**2 + (z2-z1)**2)
    
    def angular_distance(self, other: "MemoryNode") -> float:
        """Angular distance on torus surface."""
        d_theta = abs(self.theta - other.theta)
        d_phi = abs(self.phi - other.phi)
        # Wrap around
        d_theta = min(d_theta, 2*math.pi - d_theta)
        d_phi = min(d_phi, 2*math.pi - d_phi)
        return math.sqrt(d_theta**2 + d_phi**2)
    
    def to_dict(self) -> Dict[str, Any]:
        x, y, z = self.torus_xyz()
        return {
            "node_id": self.node_id,
            "content": self.content,
            "memory_type": self.memory_type.value,
            "salience": self.salience.value,
            "coordinates": {
                "theta": round(self.theta, 6),
                "phi": round(self.phi, 6),
                "depth": round(self.depth, 6),
                "ring": self.ring,
                "beat": self.beat,
                "xyz": (round(x, 4), round(y, 4), round(z, 4)),
            },
            "lineage": {
                "parent_id": self.parent_id,
                "children_ids": self.children_ids,
            },
            "doctrine_alignment": self.doctrine_alignment,
            "consolidated": self.consolidated,
            "promoted": self.promoted,
            "tags": self.tags,
            "access_count": self.access_count,
            "created_at": self.created_at,
            "accessed_at": self.accessed_at,
        }


class MemoryTemple:
    """
    The Memory Temple — operational workspace for memory.
    
    Provides:
    - Storage and retrieval of memory nodes
    - Coordinate-based navigation
    - Lineage tracking
    - Salience and doctrine overlays
    """
    
    def __init__(self) -> None:
        self._nodes: Dict[str, MemoryNode] = {}
        self._current_beat = 0
        self._current_theta = 0.0
        self._current_phi = 0.0
        self._current_ring = 0
        self._traversal_path: List[str] = []  # Shared path for user + system
    
    @property
    def current_beat(self) -> int:
        return self._current_beat
    
    @property
    def node_count(self) -> int:
        return len(self._nodes)
    
    def _advance_coordinates(self) -> Tuple[float, float, int]:
        """Advance to next torus coordinates using golden ratio."""
        delta_theta = (2 * math.pi) / (PHI ** 2 * 10)
        delta_phi = (2 * math.pi) / (PHI ** 3 * 10)
        
        self._current_theta = (self._current_theta + delta_theta) % (2 * math.pi)
        old_phi = self._current_phi
        self._current_phi = (self._current_phi + delta_phi) % (2 * math.pi)
        
        # Ring advances every full toroidal cycle
        if self._current_phi < old_phi:
            self._current_ring += 1
        
        self._current_beat += 1
        
        return self._current_theta, self._current_phi, self._current_ring
    
    def store(
        self,
        content: str,
        memory_type: MemoryType = MemoryType.EPISODIC,
        salience: SalienceLevel = SalienceLevel.MEDIUM,
        parent_id: Optional[str] = None,
        tags: Optional[List[str]] = None,
        metadata: Optional[Dict[str, Any]] = None,
        doctrine_alignment: float = 1.0,
    ) -> MemoryNode:
        """
        Store a new memory node in the temple.
        
        Automatically assigns torus coordinates based on current position.
        """
        theta, phi, ring = self._advance_coordinates()
        
        node = MemoryNode(
            content=content,
            memory_type=memory_type,
            salience=salience,
            theta=theta,
            phi=phi,
            depth=1.0 + (ring * 0.1),  # Depth increases with ring
            ring=ring,
            beat=self._current_beat,
            parent_id=parent_id,
            tags=tags or [],
            metadata=metadata or {},
            doctrine_alignment=doctrine_alignment,
        )
        
        # Link to parent
        if parent_id and parent_id in self._nodes:
            self._nodes[parent_id].children_ids.append(node.node_id)
        
        self._nodes[node.node_id] = node
        self._traversal_path.append(node.node_id)
        
        return node
    
    def get(self, node_id: str) -> Optional[MemoryNode]:
        """Get a memory node by ID."""
        node = self._nodes.get(node_id)
        if node:
            node.accessed_at = time.time()
            node.access_count += 1
        return node
    
    def find(
        self,
        query: str,
        memory_type: Optional[MemoryType] = None,
        salience: Optional[SalienceLevel] = None,
        tags: Optional[List[str]] = None,
        limit: int = 10,
        **kwargs: Any,
    ) -> List[MemoryNode]:
        """
        Find memories matching query and filters.
        
        Simple substring matching for now.
        """
        results: List[MemoryNode] = []
        query_lower = query.lower()
        
        for node in self._nodes.values():
            # Content match
            if query_lower and query_lower not in node.content.lower():
                continue
            
            # Type filter
            if memory_type and node.memory_type != memory_type:
                continue
            
            # Salience filter
            if salience and node.salience != salience:
                continue
            
            # Tags filter
            if tags and not any(t in node.tags for t in tags):
                continue
            
            results.append(node)
            node.accessed_at = time.time()
            node.access_count += 1
            
            if len(results) >= limit:
                break
        
        # Sort by salience and access count
        salience_order = {
            SalienceLevel.CRITICAL: 0,
            SalienceLevel.HIGH: 1,
            SalienceLevel.MEDIUM: 2,
            SalienceLevel.LOW: 3,
            SalienceLevel.DORMANT: 4,
        }
        results.sort(key=lambda n: (salience_order[n.salience], -n.access_count))
        
        return results
    
    def traverse(self, coords: Dict[str, Any]) -> Optional[MemoryNode]:
        """
        Navigate to specific coordinates and return nearest node.
        
        Coords should include theta, phi, and optionally ring/beat.
        """
        target_theta = coords.get("theta", 0.0)
        target_phi = coords.get("phi", 0.0)
        target_ring = coords.get("ring")
        target_beat = coords.get("beat")
        
        # Find nearest node
        best_node: Optional[MemoryNode] = None
        best_distance = float("inf")
        
        for node in self._nodes.values():
            # Filter by ring/beat if specified
            if target_ring is not None and node.ring != target_ring:
                continue
            if target_beat is not None and node.beat != target_beat:
                continue
            
            # Calculate angular distance
            d_theta = abs(node.theta - target_theta)
            d_phi = abs(node.phi - target_phi)
            d_theta = min(d_theta, 2*math.pi - d_theta)
            d_phi = min(d_phi, 2*math.pi - d_phi)
            distance = math.sqrt(d_theta**2 + d_phi**2)
            
            if distance < best_distance:
                best_distance = distance
                best_node = node
        
        if best_node:
            self._traversal_path.append(best_node.node_id)
            best_node.accessed_at = time.time()
            best_node.access_count += 1
        
        return best_node
    
    def lineage(self, node_id: str) -> List[MemoryNode]:
        """Trace ancestry chain back to root."""
        chain: List[MemoryNode] = []
        current_id: Optional[str] = node_id
        
        while current_id and current_id in self._nodes:
            node = self._nodes[current_id]
            chain.insert(0, node)
            current_id = node.parent_id
        
        return chain
    
    def descendants(self, node_id: str, max_depth: int = 10) -> List[MemoryNode]:
        """Get all descendants of a node."""
        if node_id not in self._nodes:
            return []
        
        result: List[MemoryNode] = []
        queue = [(node_id, 0)]
        
        while queue:
            current_id, depth = queue.pop(0)
            if depth > max_depth:
                continue
            
            node = self._nodes.get(current_id)
            if node is None:
                continue
            
            if current_id != node_id:  # Don't include root
                result.append(node)
            
            for child_id in node.children_ids:
                queue.append((child_id, depth + 1))
        
        return result
    
    def get_topology(self) -> Dict[str, Any]:
        """Get memory topology summary."""
        by_ring: Dict[int, int] = {}
        by_type: Dict[str, int] = {}
        by_salience: Dict[str, int] = {}
        
        for node in self._nodes.values():
            by_ring[node.ring] = by_ring.get(node.ring, 0) + 1
            by_type[node.memory_type.value] = by_type.get(node.memory_type.value, 0) + 1
            by_salience[node.salience.value] = by_salience.get(node.salience.value, 0) + 1
        
        return {
            "total_nodes": len(self._nodes),
            "current_beat": self._current_beat,
            "current_ring": self._current_ring,
            "current_coordinates": {
                "theta": round(self._current_theta, 6),
                "phi": round(self._current_phi, 6),
            },
            "by_ring": by_ring,
            "by_type": by_type,
            "by_salience": by_salience,
            "traversal_depth": len(self._traversal_path),
        }
    
    def get_traversal_path(self, limit: int = 50) -> List[MemoryNode]:
        """Get recent traversal path (shared for user + system)."""
        path_ids = self._traversal_path[-limit:]
        return [self._nodes[nid] for nid in path_ids if nid in self._nodes]
    
    def consolidate(self, **kwargs: Any) -> int:
        """Trigger consolidation (delegated to ConsolidationEngine)."""
        # This is a stub - actual consolidation in consolidation.py
        return 0
