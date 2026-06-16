"""
MEDINA Memory Navigation — Path-based memory traversal.

Provides unified traversal for user and system:
- Navigate by coordinates
- Follow lineage paths
- Explore by proximity
- Build traversal histories
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional

from .temple import MemoryTemple, MemoryNode, MemoryCoordinates


class NavigationMode(Enum):
    """Navigation traversal modes."""
    
    LINEAR = "linear"           # Beat-by-beat
    RING = "ring"               # Around a ring
    DEPTH = "depth"             # By salience depth
    LINEAGE = "lineage"         # Parent-child chain
    PROXIMITY = "proximity"     # Nearest neighbors
    SEMANTIC = "semantic"       # By tag/content similarity


@dataclass
class NavigationStep:
    """A single step in a navigation path."""
    
    step_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    node_id: str = ""
    node_summary: str = ""
    coordinates: Optional[MemoryCoordinates] = None
    mode: NavigationMode = NavigationMode.LINEAR
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "step_id": self.step_id,
            "node_id": self.node_id,
            "node_summary": self.node_summary,
            "coordinates": self.coordinates.to_dict() if self.coordinates else None,
            "mode": self.mode.value,
            "timestamp": self.timestamp,
        }


@dataclass
class NavigationPath:
    """A recorded navigation path through memory."""
    
    path_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    description: str = ""
    steps: List[NavigationStep] = field(default_factory=list)
    created_at: float = field(default_factory=time.time)
    
    def add_step(self, step: NavigationStep) -> None:
        """Add a step to the path."""
        self.steps.append(step)
    
    @property
    def length(self) -> int:
        return len(self.steps)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "path_id": self.path_id,
            "name": self.name,
            "description": self.description,
            "length": self.length,
            "steps": [s.to_dict() for s in self.steps],
            "created_at": self.created_at,
        }


class MemoryNavigator:
    """
    MEDINA Memory Navigator — Unified traversal interface.
    
    Both user and system traverse the same memory topology.
    Navigation is:
    - Path-based (explicit routes)
    - Lineage-aware (ancestry tracking)
    - Replayable (recorded paths)
    
    Integration with:
    - U-MODEL-MEMORY-NAVIGATION
    - /memory map command
    """
    
    def __init__(self, temple: MemoryTemple) -> None:
        self._temple = temple
        self._current_position: Optional[MemoryNode] = None
        self._history: List[NavigationStep] = []
        self._saved_paths: Dict[str, NavigationPath] = {}
    
    # ------------------------------------------------------------------ #
    # Position                                                              #
    # ------------------------------------------------------------------ #
    
    @property
    def current(self) -> Optional[MemoryNode]:
        """Current navigation position."""
        return self._current_position
    
    def go_to(self, node_id: str) -> Optional[MemoryNode]:
        """Navigate to a specific memory by ID."""
        node = self._temple.get(node_id)
        if node:
            self._current_position = node
            self._record_step(node, NavigationMode.LINEAR)
        return node
    
    def go_to_coordinates(
        self,
        coords: MemoryCoordinates,
    ) -> Optional[MemoryNode]:
        """Navigate to nearest memory at coordinates."""
        nearest = self._temple.nearest_to(coords, limit=1)
        if nearest:
            node, _ = nearest[0]
            self._current_position = node
            self._record_step(node, NavigationMode.PROXIMITY)
            return node
        return None
    
    # ------------------------------------------------------------------ #
    # Linear Navigation                                                     #
    # ------------------------------------------------------------------ #
    
    def next_by_beat(self) -> Optional[MemoryNode]:
        """Move to next memory by beat order."""
        if not self._current_position:
            # Start at first memory
            memories = self._temple.memories_in_beat_range(0, 0)
            if memories:
                self._current_position = memories[0]
                self._record_step(memories[0], NavigationMode.LINEAR)
                return memories[0]
            return None
        
        current_beat = self._current_position.coordinates.beat
        next_memories = self._temple.memories_in_beat_range(
            current_beat + 1,
            current_beat + 1,
        )
        
        if next_memories:
            node = next_memories[0]
            self._current_position = node
            self._record_step(node, NavigationMode.LINEAR)
            return node
        return None
    
    def prev_by_beat(self) -> Optional[MemoryNode]:
        """Move to previous memory by beat order."""
        if not self._current_position:
            return None
        
        current_beat = self._current_position.coordinates.beat
        if current_beat == 0:
            return None
        
        prev_memories = self._temple.memories_in_beat_range(
            current_beat - 1,
            current_beat - 1,
        )
        
        if prev_memories:
            node = prev_memories[0]
            self._current_position = node
            self._record_step(node, NavigationMode.LINEAR)
            return node
        return None
    
    # ------------------------------------------------------------------ #
    # Ring Navigation                                                       #
    # ------------------------------------------------------------------ #
    
    def go_to_ring(self, ring: int) -> List[MemoryNode]:
        """Navigate to a specific ring, return all memories there."""
        memories = self._temple.memories_at_ring(ring)
        if memories:
            # Position at first memory in ring
            self._current_position = memories[0]
            self._record_step(memories[0], NavigationMode.RING)
        return memories
    
    def next_in_ring(self) -> Optional[MemoryNode]:
        """Move to next memory in current ring."""
        if not self._current_position:
            return None
        
        ring = self._current_position.coordinates.ring
        ring_memories = self._temple.memories_at_ring(ring)
        
        # Sort by theta (angular position)
        ring_memories.sort(key=lambda n: n.coordinates.theta)
        
        current_theta = self._current_position.coordinates.theta
        for mem in ring_memories:
            if mem.coordinates.theta > current_theta:
                self._current_position = mem
                self._record_step(mem, NavigationMode.RING)
                return mem
        
        # Wrap around
        if ring_memories:
            node = ring_memories[0]
            self._current_position = node
            self._record_step(node, NavigationMode.RING)
            return node
        return None
    
    # ------------------------------------------------------------------ #
    # Lineage Navigation                                                    #
    # ------------------------------------------------------------------ #
    
    def go_to_parent(self) -> Optional[MemoryNode]:
        """Navigate to parent memory."""
        if not self._current_position or not self._current_position.parent_id:
            return None
        
        parent = self._temple.get(self._current_position.parent_id)
        if parent:
            self._current_position = parent
            self._record_step(parent, NavigationMode.LINEAGE)
        return parent
    
    def go_to_root(self) -> Optional[MemoryNode]:
        """Navigate to root of current lineage."""
        if not self._current_position:
            return None
        
        lineage = self._temple.lineage(self._current_position.node_id)
        if lineage:
            root = lineage[0]
            self._current_position = root
            self._record_step(root, NavigationMode.LINEAGE)
            return root
        return None
    
    def get_children(self) -> List[MemoryNode]:
        """Get immediate children of current position."""
        if not self._current_position:
            return []
        # Return only direct children (where parent_id matches current node)
        current_id = self._current_position.node_id
        return [
            node for node in self._temple._nodes.values()
            if node.parent_id == current_id
        ]
    
    # ------------------------------------------------------------------ #
    # Proximity Navigation                                                  #
    # ------------------------------------------------------------------ #
    
    def nearest(self, limit: int = 5) -> List[MemoryNode]:
        """Find memories nearest to current position."""
        if not self._current_position:
            return []
        
        coords = self._current_position.coordinates
        results = self._temple.nearest_to(coords, limit + 1)
        
        # Exclude current position
        return [node for node, _ in results if node.node_id != self._current_position.node_id][:limit]
    
    def go_to_nearest(self) -> Optional[MemoryNode]:
        """Navigate to nearest memory."""
        nearest = self.nearest(1)
        if nearest:
            node = nearest[0]
            self._current_position = node
            self._record_step(node, NavigationMode.PROXIMITY)
            return node
        return None
    
    # ------------------------------------------------------------------ #
    # History & Paths                                                       #
    # ------------------------------------------------------------------ #
    
    def _record_step(self, node: MemoryNode, mode: NavigationMode) -> None:
        """Record a navigation step in history."""
        step = NavigationStep(
            node_id=node.node_id,
            node_summary=node.summary,
            coordinates=node.coordinates,
            mode=mode,
        )
        self._history.append(step)
    
    def back(self) -> Optional[MemoryNode]:
        """Go back to previous position in history."""
        if len(self._history) < 2:
            return None
        
        # Remove current step
        self._history.pop()
        
        # Get previous step
        prev_step = self._history[-1]
        node = self._temple.get(prev_step.node_id)
        if node:
            self._current_position = node
        return node
    
    def get_history(self, limit: int = 20) -> List[NavigationStep]:
        """Get recent navigation history."""
        return self._history[-limit:]
    
    def clear_history(self) -> None:
        """Clear navigation history."""
        self._history.clear()
    
    # ------------------------------------------------------------------ #
    # Saved Paths                                                           #
    # ------------------------------------------------------------------ #
    
    def save_path(self, name: str, description: str = "") -> NavigationPath:
        """Save current history as a named path."""
        path = NavigationPath(
            name=name,
            description=description,
            steps=list(self._history),
        )
        self._saved_paths[path.path_id] = path
        return path
    
    def load_path(self, path_id: str) -> Optional[NavigationPath]:
        """Load a saved path."""
        return self._saved_paths.get(path_id)
    
    def replay_path(self, path_id: str) -> List[MemoryNode]:
        """Replay a saved path, returning all nodes visited."""
        path = self._saved_paths.get(path_id)
        if not path:
            return []
        
        nodes: List[MemoryNode] = []
        for step in path.steps:
            node = self._temple.get(step.node_id)
            if node:
                nodes.append(node)
                self._current_position = node
        
        return nodes
    
    def list_paths(self) -> List[NavigationPath]:
        """List all saved paths."""
        return list(self._saved_paths.values())
    
    def delete_path(self, path_id: str) -> bool:
        """Delete a saved path."""
        if path_id in self._saved_paths:
            del self._saved_paths[path_id]
            return True
        return False
