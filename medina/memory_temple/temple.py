"""
MEDINA Memory Temple Core — Operational memory workspace.

Memory as navigable geometry with lineage tracking.
"""

from __future__ import annotations

import math
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

# Golden ratio for natural scaling
PHI = (1 + math.sqrt(5)) / 2

# Major torus radius
TORUS_R = PHI * 10.0


class MemoryType(Enum):
    """Classification of memory nodes."""
    
    EPISODIC = "episodic"       # Event/experience memory
    SEMANTIC = "semantic"       # Knowledge/fact memory
    PROCEDURAL = "procedural"   # How-to/skill memory
    WORKING = "working"         # Active/temporary memory
    DOCTRINE = "doctrine"       # Constitutional/law memory


class ConsolidationState(Enum):
    """Memory consolidation lifecycle states."""
    
    FRESH = "fresh"             # Newly created
    STABLE = "stable"           # Verified and settled
    CONSOLIDATING = "consolidating"  # In merge process
    CONSOLIDATED = "consolidated"    # Merged into parent
    PROMOTED = "promoted"       # Elevated to higher salience
    ARCHIVED = "archived"       # Moved to cold storage


@dataclass
class MemoryCoordinates:
    """
    Toroidal coordinate system for memory geometry.
    
    Every memory has a unique position in the memory temple:
    - theta: angular position on helix [0, 2π)
    - phi: toroidal rotation [0, 2π)
    - depth: radial depth (salience indicator)
    - ring: memory ring index (temporal grouping)
    - beat: creation beat (discrete time)
    """
    
    theta: float = 0.0      # [0, 2π)
    phi: float = 0.0        # [0, 2π)
    depth: float = 1.0      # ρ > 0
    ring: int = 0           # ring ≥ 0
    beat: int = 0           # beat ≥ 0
    
    def to_xyz(self) -> Tuple[float, float, float]:
        """
        Convert to Cartesian coordinates.
        
        Embedding on torus surface:
          x = (R + ρ·cos θ)·cos φ
          y = (R + ρ·cos θ)·sin φ
          z = ρ·sin θ
        """
        r = TORUS_R
        x = (r + self.depth * math.cos(self.theta)) * math.cos(self.phi)
        y = (r + self.depth * math.cos(self.theta)) * math.sin(self.phi)
        z = self.depth * math.sin(self.theta)
        return (round(x, 6), round(y, 6), round(z, 6))
    
    def distance_to(self, other: "MemoryCoordinates") -> float:
        """Euclidean distance between coordinate points."""
        xyz1 = self.to_xyz()
        xyz2 = other.to_xyz()
        return math.sqrt(sum((a - b) ** 2 for a, b in zip(xyz1, xyz2)))
    
    def advance(self, delta_theta: float = 0.0, delta_phi: float = 0.0) -> "MemoryCoordinates":
        """Create new coordinates advanced by deltas."""
        new_theta = (self.theta + delta_theta) % (2 * math.pi)
        new_phi = (self.phi + delta_phi) % (2 * math.pi)
        new_ring = self.ring + (1 if new_phi < self.phi else 0)
        
        return MemoryCoordinates(
            theta=new_theta,
            phi=new_phi,
            depth=self.depth,
            ring=new_ring,
            beat=self.beat + 1,
        )
    
    def to_dict(self) -> Dict[str, Any]:
        x, y, z = self.to_xyz()
        return {
            "theta": round(self.theta, 6),
            "phi": round(self.phi, 6),
            "depth": round(self.depth, 6),
            "ring": self.ring,
            "beat": self.beat,
            "xyz": {"x": x, "y": y, "z": z},
        }


@dataclass
class MemoryNode:
    """
    A single memory node in the temple.
    
    Each node contains:
    - Unique identifier and lineage reference
    - Content (the memory itself)
    - Coordinates (position in memory geometry)
    - Metadata (type, state, timestamps)
    - Salience score (retrieval priority)
    - Evidence trail (for replay)
    """
    
    node_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    parent_id: Optional[str] = None
    
    # Content
    content: Dict[str, Any] = field(default_factory=dict)
    summary: str = ""
    tags: List[str] = field(default_factory=list)
    
    # Classification
    memory_type: MemoryType = MemoryType.EPISODIC
    state: ConsolidationState = ConsolidationState.FRESH
    
    # Position
    coordinates: MemoryCoordinates = field(default_factory=MemoryCoordinates)
    
    # Salience
    salience_score: float = 0.5  # [0, 1]
    pinned: bool = False
    
    # Timestamps
    created_at: float = field(default_factory=time.time)
    updated_at: float = field(default_factory=time.time)
    accessed_at: float = field(default_factory=time.time)
    
    # Evidence
    creation_evidence: Dict[str, Any] = field(default_factory=dict)
    
    def touch(self) -> None:
        """Update access timestamp."""
        self.accessed_at = time.time()
    
    def update_content(self, content: Dict[str, Any]) -> None:
        """Update memory content."""
        self.content = content
        self.updated_at = time.time()
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "node_id": self.node_id,
            "parent_id": self.parent_id,
            "content": self.content,
            "summary": self.summary,
            "tags": self.tags,
            "memory_type": self.memory_type.value,
            "state": self.state.value,
            "coordinates": self.coordinates.to_dict(),
            "salience_score": self.salience_score,
            "pinned": self.pinned,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
            "accessed_at": self.accessed_at,
        }


@dataclass
class MemoryQuery:
    """Query specification for memory retrieval."""
    
    text: Optional[str] = None
    tags: Optional[List[str]] = None
    memory_type: Optional[MemoryType] = None
    state: Optional[ConsolidationState] = None
    min_salience: float = 0.0
    max_salience: float = 1.0
    pinned_only: bool = False
    ring: Optional[int] = None
    from_beat: Optional[int] = None
    to_beat: Optional[int] = None
    near_coordinates: Optional[MemoryCoordinates] = None
    max_distance: Optional[float] = None
    limit: int = 10


class MemoryTemple:
    """
    MEDINA Memory Temple — The sovereign memory workspace.
    
    Core substrate for all memory operations:
    - Stores memories in toroidal geometry
    - Supports path-based retrieval
    - Tracks lineage for all memories
    - Enables promotion and consolidation
    - Provides unified traversal for user and system
    
    Integration with:
    - R-MODEL-MEMORY-TEMPLE-STATE
    - U-MODEL-MEMORY-TEMPLE-LAB
    - U-MODEL-MEMORY-NAVIGATION
    """
    
    def __init__(self) -> None:
        self._nodes: Dict[str, MemoryNode] = {}
        self._current_coords = MemoryCoordinates()
        self._beat = 0
        self._ring = 0
        self._created_at = time.time()
        
        # Phase advancement rates (φ-scaled for natural cadence)
        self._delta_theta = (2 * math.pi) / (PHI ** 2 * 10)
        self._delta_phi = (2 * math.pi) / (PHI ** 3 * 10)
    
    # ------------------------------------------------------------------ #
    # Core Operations                                                       #
    # ------------------------------------------------------------------ #
    
    def store(
        self,
        content: Dict[str, Any],
        summary: str = "",
        tags: Optional[List[str]] = None,
        memory_type: MemoryType = MemoryType.EPISODIC,
        parent_id: Optional[str] = None,
        salience: float = 0.5,
    ) -> MemoryNode:
        """
        Store a new memory in the temple.
        
        Memory is placed at current coordinates, then coordinates advance.
        """
        # Advance coordinates for this memory
        coords = self._current_coords.advance(self._delta_theta, self._delta_phi)
        coords.beat = self._beat
        
        node = MemoryNode(
            parent_id=parent_id,
            content=content,
            summary=summary,
            tags=tags or [],
            memory_type=memory_type,
            coordinates=coords,
            salience_score=salience,
            creation_evidence={
                "beat": self._beat,
                "source": "store",
                "timestamp": time.time(),
            },
        )
        
        self._nodes[node.node_id] = node
        self._current_coords = coords
        self._beat += 1
        
        if coords.ring > self._ring:
            self._ring = coords.ring
        
        return node
    
    def get(self, node_id: str) -> Optional[MemoryNode]:
        """Retrieve a memory by ID."""
        node = self._nodes.get(node_id)
        if node:
            node.touch()
        return node
    
    def find(self, query: MemoryQuery) -> List[MemoryNode]:
        """
        Find memories matching query criteria.
        
        This is the primary retrieval interface.
        """
        results: List[MemoryNode] = []
        
        for node in self._nodes.values():
            # Apply filters
            if query.memory_type and node.memory_type != query.memory_type:
                continue
            if query.state and node.state != query.state:
                continue
            if query.pinned_only and not node.pinned:
                continue
            if node.salience_score < query.min_salience:
                continue
            if node.salience_score > query.max_salience:
                continue
            if query.ring is not None and node.coordinates.ring != query.ring:
                continue
            if query.from_beat is not None and node.coordinates.beat < query.from_beat:
                continue
            if query.to_beat is not None and node.coordinates.beat > query.to_beat:
                continue
            if query.tags:
                if not any(t in node.tags for t in query.tags):
                    continue
            if query.near_coordinates and query.max_distance:
                dist = node.coordinates.distance_to(query.near_coordinates)
                if dist > query.max_distance:
                    continue
            if query.text:
                # Simple text match in summary and content
                text_lower = query.text.lower()
                if text_lower not in node.summary.lower():
                    content_str = str(node.content).lower()
                    if text_lower not in content_str:
                        continue
            
            results.append(node)
            node.touch()
        
        # Sort by salience descending, then by recency
        results.sort(
            key=lambda n: (n.salience_score, -n.created_at),
            reverse=True,
        )
        
        return results[: query.limit]
    
    # ------------------------------------------------------------------ #
    # Memory Management                                                     #
    # ------------------------------------------------------------------ #
    
    def pin(self, node_id: str) -> bool:
        """Pin a memory for preservation."""
        if node_id in self._nodes:
            self._nodes[node_id].pinned = True
            self._nodes[node_id].updated_at = time.time()
            return True
        return False
    
    def unpin(self, node_id: str) -> bool:
        """Unpin a memory."""
        if node_id in self._nodes:
            self._nodes[node_id].pinned = False
            self._nodes[node_id].updated_at = time.time()
            return True
        return False
    
    def promote(self, node_id: str, salience_boost: float = 0.1) -> bool:
        """
        Promote a memory to higher salience.
        
        This is an explicit event, not automatic decay.
        """
        if node_id not in self._nodes:
            return False
        
        node = self._nodes[node_id]
        node.salience_score = min(1.0, node.salience_score + salience_boost)
        node.state = ConsolidationState.PROMOTED
        node.updated_at = time.time()
        return True
    
    def consolidate(
        self,
        node_ids: List[str],
        merged_content: Dict[str, Any],
        merged_summary: str,
    ) -> Optional[MemoryNode]:
        """
        Consolidate multiple memories into one.
        
        Creates a new node with merged content.
        Original nodes are marked CONSOLIDATED.
        """
        nodes = [self._nodes.get(nid) for nid in node_ids]
        if not all(nodes):
            return None
        
        # Merge tags
        all_tags = []
        for n in nodes:
            all_tags.extend(n.tags if n else [])
        unique_tags = list(set(all_tags))
        
        # Average salience
        avg_salience = sum(n.salience_score for n in nodes if n) / len(nodes)
        
        # Create consolidated node
        consolidated = self.store(
            content=merged_content,
            summary=merged_summary,
            tags=unique_tags,
            salience=min(1.0, avg_salience + 0.1),  # Boost for consolidation
        )
        consolidated.state = ConsolidationState.STABLE
        
        # Mark originals as consolidated
        for node in nodes:
            if node:
                node.state = ConsolidationState.CONSOLIDATED
                node.updated_at = time.time()
        
        return consolidated
    
    # ------------------------------------------------------------------ #
    # Lineage                                                               #
    # ------------------------------------------------------------------ #
    
    def lineage(self, node_id: str) -> List[MemoryNode]:
        """Trace lineage from a memory back to its root."""
        chain: List[MemoryNode] = []
        current_id: Optional[str] = node_id
        
        while current_id:
            node = self._nodes.get(current_id)
            if not node:
                break
            chain.insert(0, node)
            current_id = node.parent_id
        
        return chain
    
    def descendants(self, node_id: str) -> List[MemoryNode]:
        """Find all descendants of a memory."""
        result: List[MemoryNode] = []
        
        def collect(parent_id: str) -> None:
            for node in self._nodes.values():
                if node.parent_id == parent_id:
                    result.append(node)
                    collect(node.node_id)
        
        collect(node_id)
        return result
    
    # ------------------------------------------------------------------ #
    # Navigation                                                            #
    # ------------------------------------------------------------------ #
    
    def memories_at_ring(self, ring: int) -> List[MemoryNode]:
        """Get all memories in a specific ring."""
        return [n for n in self._nodes.values() if n.coordinates.ring == ring]
    
    def memories_in_beat_range(
        self,
        from_beat: int,
        to_beat: int,
    ) -> List[MemoryNode]:
        """Get memories within a beat range."""
        return [
            n for n in self._nodes.values()
            if from_beat <= n.coordinates.beat <= to_beat
        ]
    
    def nearest_to(
        self,
        coords: MemoryCoordinates,
        limit: int = 5,
    ) -> List[Tuple[MemoryNode, float]]:
        """Find memories nearest to given coordinates."""
        distances: List[Tuple[MemoryNode, float]] = []
        
        for node in self._nodes.values():
            dist = node.coordinates.distance_to(coords)
            distances.append((node, dist))
        
        distances.sort(key=lambda x: x[1])
        return distances[:limit]
    
    # ------------------------------------------------------------------ #
    # Replay / Evidence                                                     #
    # ------------------------------------------------------------------ #
    
    def replay(
        self,
        from_beat: int = 0,
        to_beat: Optional[int] = None,
    ) -> List[Dict[str, Any]]:
        """
        Generate replay bundle for beat range.
        
        Returns ordered list of memory operations.
        """
        end_beat = to_beat if to_beat is not None else self._beat
        
        relevant = [
            n for n in self._nodes.values()
            if from_beat <= n.coordinates.beat <= end_beat
        ]
        relevant.sort(key=lambda n: n.coordinates.beat)
        
        return [
            {
                "beat": n.coordinates.beat,
                "operation": "store",
                "node": n.to_dict(),
            }
            for n in relevant
        ]
    
    # ------------------------------------------------------------------ #
    # Status                                                                #
    # ------------------------------------------------------------------ #
    
    def status(self) -> Dict[str, Any]:
        """Memory temple status."""
        by_type: Dict[str, int] = {}
        by_state: Dict[str, int] = {}
        pinned_count = 0
        
        for node in self._nodes.values():
            by_type[node.memory_type.value] = by_type.get(node.memory_type.value, 0) + 1
            by_state[node.state.value] = by_state.get(node.state.value, 0) + 1
            if node.pinned:
                pinned_count += 1
        
        return {
            "total_memories": len(self._nodes),
            "current_beat": self._beat,
            "current_ring": self._ring,
            "pinned_count": pinned_count,
            "by_type": by_type,
            "by_state": by_state,
            "current_coordinates": self._current_coords.to_dict(),
        }
    
    def map_topology(self) -> Dict[str, Any]:
        """
        Generate map of memory topology.
        
        For visualization of the memory temple structure.
        """
        rings: Dict[int, List[Dict[str, Any]]] = {}
        
        for node in self._nodes.values():
            ring = node.coordinates.ring
            if ring not in rings:
                rings[ring] = []
            rings[ring].append({
                "node_id": node.node_id,
                "summary": node.summary[:50] if node.summary else "",
                "salience": node.salience_score,
                "coordinates": node.coordinates.to_dict(),
            })
        
        return {
            "total_rings": len(rings),
            "rings": rings,
            "torus_radius": TORUS_R,
            "phi_constant": PHI,
        }
