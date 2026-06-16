"""
Memory Navigation — Helix/Ring Traversal
=========================================
Path-based, lineage-aware navigation through memory topology.

User + system traverse same memory topology.
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional, Tuple, TYPE_CHECKING

from ..core.recital import PHI, TORUS_R

if TYPE_CHECKING:
    from .temple import MemoryNode, MemoryTemple


@dataclass
class TorusCoordinate:
    """
    A coordinate in torus space.
    
    θ ∈ [0, 2π) — angular position on helix ring
    φ ∈ [0, 2π) — toroidal rotation
    ρ ∈ ℝ₊      — radial depth
    ring ∈ ℕ    — memory ring index
    beat ∈ ℕ    — discrete time counter
    """
    
    theta: float = 0.0
    phi: float = 0.0
    depth: float = 1.0
    ring: int = 0
    beat: Optional[int] = None
    
    def xyz(self) -> Tuple[float, float, float]:
        """Cartesian embedding."""
        rho = self.depth
        th = self.theta
        ph = self.phi
        x = (TORUS_R + rho * math.cos(th)) * math.cos(ph)
        y = (TORUS_R + rho * math.cos(th)) * math.sin(ph)
        z = rho * math.sin(th)
        return x, y, z
    
    def distance_to(self, other: "TorusCoordinate") -> float:
        """Euclidean distance in 3D space."""
        x1, y1, z1 = self.xyz()
        x2, y2, z2 = other.xyz()
        return math.sqrt((x2-x1)**2 + (y2-y1)**2 + (z2-z1)**2)
    
    def angular_distance(self, other: "TorusCoordinate") -> float:
        """Angular distance on torus surface."""
        d_theta = abs(self.theta - other.theta)
        d_phi = abs(self.phi - other.phi)
        d_theta = min(d_theta, 2*math.pi - d_theta)
        d_phi = min(d_phi, 2*math.pi - d_phi)
        return math.sqrt(d_theta**2 + d_phi**2)
    
    def advance(self, steps: int = 1) -> "TorusCoordinate":
        """Advance coordinates by golden ratio increments."""
        delta_theta = (2 * math.pi) / (PHI ** 2 * 10)
        delta_phi = (2 * math.pi) / (PHI ** 3 * 10)
        
        new_theta = (self.theta + delta_theta * steps) % (2 * math.pi)
        new_phi = (self.phi + delta_phi * steps) % (2 * math.pi)
        
        # Calculate ring advancement
        phi_cycles = int((self.phi + delta_phi * steps) / (2 * math.pi))
        new_ring = self.ring + phi_cycles
        
        new_beat = (self.beat or 0) + steps
        
        return TorusCoordinate(
            theta=new_theta,
            phi=new_phi,
            depth=self.depth,
            ring=new_ring,
            beat=new_beat,
        )
    
    def to_dict(self) -> Dict[str, Any]:
        x, y, z = self.xyz()
        return {
            "theta": round(self.theta, 6),
            "phi": round(self.phi, 6),
            "depth": round(self.depth, 6),
            "ring": self.ring,
            "beat": self.beat,
            "xyz": (round(x, 4), round(y, 4), round(z, 4)),
        }
    
    @classmethod
    def from_dict(cls, d: Dict[str, Any]) -> "TorusCoordinate":
        return cls(
            theta=d.get("theta", 0.0),
            phi=d.get("phi", 0.0),
            depth=d.get("depth", 1.0),
            ring=d.get("ring", 0),
            beat=d.get("beat"),
        )


@dataclass
class NavigationPath:
    """A path through memory space."""
    
    path_id: str = ""
    waypoints: List[TorusCoordinate] = field(default_factory=list)
    node_ids: List[str] = field(default_factory=list)
    
    def length(self) -> float:
        """Total path length in 3D space."""
        if len(self.waypoints) < 2:
            return 0.0
        total = 0.0
        for i in range(1, len(self.waypoints)):
            total += self.waypoints[i-1].distance_to(self.waypoints[i])
        return total
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "path_id": self.path_id,
            "waypoints": [w.to_dict() for w in self.waypoints],
            "node_ids": self.node_ids,
            "length": self.length(),
        }


class MemoryNavigator:
    """
    Navigator for Memory Temple topology.
    
    Provides path-based, lineage-aware navigation.
    User and system share the same traversal interface.
    """
    
    def __init__(self, temple: Optional["MemoryTemple"] = None) -> None:
        self._temple = temple
        self._current_position = TorusCoordinate()
        self._history: List[TorusCoordinate] = [self._current_position]
        self._saved_paths: Dict[str, NavigationPath] = {}
    
    def bind_temple(self, temple: "MemoryTemple") -> None:
        """Bind to a memory temple."""
        self._temple = temple
    
    @property
    def current_position(self) -> TorusCoordinate:
        return self._current_position
    
    def goto(self, coords: TorusCoordinate) -> Optional["MemoryNode"]:
        """
        Navigate to specific coordinates.
        
        Returns nearest memory node at target location.
        """
        self._current_position = coords
        self._history.append(coords)
        
        if self._temple is None:
            return None
        
        return self._temple.traverse(coords.to_dict())
    
    def goto_ring(self, ring: int) -> Optional["MemoryNode"]:
        """Navigate to a specific memory ring."""
        coords = TorusCoordinate(
            theta=self._current_position.theta,
            phi=self._current_position.phi,
            depth=1.0 + (ring * 0.1),
            ring=ring,
        )
        return self.goto(coords)
    
    def goto_beat(self, beat: int) -> Optional["MemoryNode"]:
        """Navigate to a specific beat in time."""
        if self._temple is None:
            return None
        
        # Find node at that beat
        for node in self._temple._nodes.values():
            if node.beat == beat:
                coords = TorusCoordinate(
                    theta=node.theta,
                    phi=node.phi,
                    depth=node.depth,
                    ring=node.ring,
                    beat=node.beat,
                )
                return self.goto(coords)
        
        return None
    
    def advance(self, steps: int = 1) -> TorusCoordinate:
        """Advance position by golden-ratio steps."""
        self._current_position = self._current_position.advance(steps)
        self._history.append(self._current_position)
        return self._current_position
    
    def back(self, steps: int = 1) -> TorusCoordinate:
        """Go back in navigation history."""
        if len(self._history) > steps:
            # Remove recent positions
            for _ in range(steps):
                self._history.pop()
            self._current_position = self._history[-1]
        return self._current_position
    
    def find_nearest(self, count: int = 5) -> List["MemoryNode"]:
        """Find nearest memory nodes to current position."""
        if self._temple is None:
            return []
        
        nodes_with_distance: List[Tuple[float, "MemoryNode"]] = []
        
        for node in self._temple._nodes.values():
            node_coord = TorusCoordinate(
                theta=node.theta,
                phi=node.phi,
                depth=node.depth,
                ring=node.ring,
                beat=node.beat,
            )
            dist = self._current_position.angular_distance(node_coord)
            nodes_with_distance.append((dist, node))
        
        nodes_with_distance.sort(key=lambda x: x[0])
        return [n for _, n in nodes_with_distance[:count]]
    
    def find_in_ring(self, ring: int, limit: int = 10) -> List["MemoryNode"]:
        """Find all nodes in a specific ring."""
        if self._temple is None:
            return []
        
        nodes = [n for n in self._temple._nodes.values() if n.ring == ring]
        nodes.sort(key=lambda n: n.theta)  # Sort by angular position
        return nodes[:limit]
    
    def trace_lineage(self, node_id: str) -> List["MemoryNode"]:
        """Trace ancestry of a node."""
        if self._temple is None:
            return []
        return self._temple.lineage(node_id)
    
    def save_path(self, name: str) -> NavigationPath:
        """Save current navigation path."""
        import uuid
        path = NavigationPath(
            path_id=str(uuid.uuid4()),
            waypoints=list(self._history),
            node_ids=[],  # Could populate with visited nodes
        )
        self._saved_paths[name] = path
        return path
    
    def load_path(self, name: str) -> Optional[NavigationPath]:
        """Load a saved navigation path."""
        return self._saved_paths.get(name)
    
    def replay_path(self, path: NavigationPath) -> List[Optional["MemoryNode"]]:
        """Replay a navigation path, returning nodes at each waypoint."""
        results: List[Optional["MemoryNode"]] = []
        for coord in path.waypoints:
            node = self.goto(coord)
            results.append(node)
        return results
    
    def get_navigation_history(self, limit: int = 50) -> List[TorusCoordinate]:
        """Get recent navigation history."""
        return self._history[-limit:]
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "current_position": self._current_position.to_dict(),
            "history_length": len(self._history),
            "saved_paths": list(self._saved_paths.keys()),
        }
