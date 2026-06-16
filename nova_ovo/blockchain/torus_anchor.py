"""
TORUS STATE ANCHOR — Memory Torus State Anchoring
==================================================
Protocol: PROT-161-B
Anchors memory torus coordinates on-chain for sovereign persistence.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

import math
import hashlib
import time
from dataclasses import dataclass
from typing import Dict, List, Optional, Tuple

PHI = 1.6180339887498948482
TAU = 2 * math.pi


@dataclass
class TorusCoordinate:
    """A coordinate on the memory torus."""
    theta: float  # Angular position on helix ring [0, 2π)
    phi: float    # Toroidal rotation [0, 2π)
    rho: float    # Radial depth (salience)
    ring: int     # Memory ring index
    beat: int     # Discrete creation time


@dataclass
class StateAnchor:
    """An anchored state on the blockchain."""
    anchor_id: str
    torus_coord: TorusCoordinate
    state_hash: str
    block_index: int
    timestamp: float
    memory_type: str  # EPISODIC, SEMANTIC, PROCEDURAL, WORKING, DOCTRINE
    salience: float


class TorusStateAnchor:
    """
    TORUS STATE ANCHOR — On-Chain Memory Anchoring
    
    Maps memory torus coordinates to blockchain state:
    - θ (theta): helix position
    - φ (phi): toroidal rotation  
    - ρ (rho): radial depth / salience
    - ring: temporal layer
    
    Golden ratio spacing ensures non-repeating placement.
    """
    
    # Torus major radius
    MAJOR_RADIUS = PHI * 10  # R = 16.18
    
    # Golden angle steps
    DELTA_THETA = TAU / (PHI ** 2 * 10)  # Helix step
    DELTA_PHI = TAU / (PHI ** 3 * 10)    # Toroidal step
    
    def __init__(self):
        self.anchors: Dict[str, StateAnchor] = {}
        self.coordinate_index: Dict[Tuple[int, int], List[str]] = {}  # (ring, beat) -> anchor_ids
        self.current_beat: int = 0
    
    def compute_torus_coordinate(
        self,
        beat: int,
        ring: int = 0,
        salience: float = 1.0
    ) -> TorusCoordinate:
        """
        Compute torus coordinates using golden ratio spacing.
        
        Fibonacci phyllotaxis applied to memory placement.
        """
        theta = (beat * self.DELTA_THETA) % TAU
        phi = (beat * self.DELTA_PHI) % TAU
        rho = PHI + salience * 0.5  # Base depth + salience modifier
        
        return TorusCoordinate(
            theta=theta,
            phi=phi,
            rho=rho,
            ring=ring,
            beat=beat
        )
    
    def compute_cartesian(self, coord: TorusCoordinate) -> Tuple[float, float, float]:
        """
        Convert torus coordinates to Cartesian (x, y, z).
        
        x = (R + ρ·cos θ)·cos φ
        y = (R + ρ·cos θ)·sin φ
        z = ρ·sin θ
        """
        R = self.MAJOR_RADIUS
        x = (R + coord.rho * math.cos(coord.theta)) * math.cos(coord.phi)
        y = (R + coord.rho * math.cos(coord.theta)) * math.sin(coord.phi)
        z = coord.rho * math.sin(coord.theta)
        return (x, y, z)
    
    def anchor_state(
        self,
        state_data: Dict,
        memory_type: str,
        salience: float = 1.0,
        ring: Optional[int] = None
    ) -> StateAnchor:
        """
        Anchor a state to the torus and blockchain.
        
        Returns an immutable StateAnchor with coordinates.
        """
        self.current_beat += 1
        beat = self.current_beat
        
        # Determine ring based on Fibonacci progression
        if ring is None:
            ring = self._compute_ring(beat)
        
        # Compute torus coordinate
        coord = self.compute_torus_coordinate(beat, ring, salience)
        
        # Hash the state
        state_hash = hashlib.sha256(
            str(state_data).encode()
        ).hexdigest()
        
        # Create anchor ID
        anchor_id = f"ANCHOR-{ring}-{beat}-{state_hash[:8]}"
        
        anchor = StateAnchor(
            anchor_id=anchor_id,
            torus_coord=coord,
            state_hash=state_hash,
            block_index=beat,  # Simplified: beat = block index
            timestamp=time.time(),
            memory_type=memory_type,
            salience=salience
        )
        
        self.anchors[anchor_id] = anchor
        
        # Index by (ring, beat)
        key = (ring, beat)
        if key not in self.coordinate_index:
            self.coordinate_index[key] = []
        self.coordinate_index[key].append(anchor_id)
        
        return anchor
    
    def _compute_ring(self, beat: int) -> int:
        """
        Compute ring based on Fibonacci thresholds.
        
        F(n) thresholds:
        - Ring 0: beat < 55
        - Ring 1: 55 ≤ beat < 89
        - Ring 2: 89 ≤ beat < 144
        - etc.
        """
        fibonacci = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]
        
        for i, fib in enumerate(fibonacci):
            if beat < fib:
                return max(0, i - 1)
        
        return len(fibonacci) - 1
    
    def traverse(self, theta: float, phi: float, ring: int) -> List[StateAnchor]:
        """
        Traverse the torus to find nearby anchors.
        
        Returns anchors within golden angle tolerance.
        """
        tolerance = self.DELTA_THETA  # One golden step
        
        results = []
        for anchor in self.anchors.values():
            if anchor.torus_coord.ring != ring:
                continue
            
            theta_dist = abs(anchor.torus_coord.theta - theta)
            phi_dist = abs(anchor.torus_coord.phi - phi)
            
            # Handle wrap-around
            theta_dist = min(theta_dist, TAU - theta_dist)
            phi_dist = min(phi_dist, TAU - phi_dist)
            
            if theta_dist <= tolerance and phi_dist <= tolerance:
                results.append(anchor)
        
        return sorted(results, key=lambda a: a.salience, reverse=True)
    
    def get_ring_anchors(self, ring: int) -> List[StateAnchor]:
        """Get all anchors in a specific ring."""
        return [
            a for a in self.anchors.values()
            if a.torus_coord.ring == ring
        ]
    
    def compute_lineage(self, anchor_id: str) -> List[StateAnchor]:
        """
        Compute anchor lineage back to ring 0.
        
        Traces through connected anchors.
        """
        if anchor_id not in self.anchors:
            return []
        
        anchor = self.anchors[anchor_id]
        lineage = [anchor]
        
        current_ring = anchor.torus_coord.ring
        current_beat = anchor.torus_coord.beat
        
        while current_ring > 0:
            # Find nearest ancestor in previous ring
            ancestor = self._find_nearest_ancestor(current_beat, current_ring - 1)
            if ancestor:
                lineage.insert(0, ancestor)
                current_ring = ancestor.torus_coord.ring
                current_beat = ancestor.torus_coord.beat
            else:
                break
        
        return lineage
    
    def _find_nearest_ancestor(self, beat: int, target_ring: int) -> Optional[StateAnchor]:
        """Find nearest anchor in target ring."""
        candidates = self.get_ring_anchors(target_ring)
        if not candidates:
            return None
        
        return min(
            candidates,
            key=lambda a: abs(a.torus_coord.beat - beat)
        )
    
    def consolidate_ring(self, ring: int) -> int:
        """
        Consolidate anchors in a ring (reduce redundancy).
        
        Merges anchors with similar coordinates.
        """
        anchors = self.get_ring_anchors(ring)
        if len(anchors) < 2:
            return 0
        
        merged_count = 0
        tolerance = self.DELTA_THETA * 0.5
        
        # Simple consolidation: mark duplicates
        seen_coords = set()
        for anchor in anchors:
            coord_key = (
                round(anchor.torus_coord.theta / tolerance),
                round(anchor.torus_coord.phi / tolerance)
            )
            if coord_key in seen_coords:
                merged_count += 1
            seen_coords.add(coord_key)
        
        return merged_count
    
    def get_anchor_state(self) -> Dict:
        """Get torus anchor system state."""
        ring_counts = {}
        for anchor in self.anchors.values():
            ring = anchor.torus_coord.ring
            ring_counts[ring] = ring_counts.get(ring, 0) + 1
        
        return {
            'total_anchors': len(self.anchors),
            'current_beat': self.current_beat,
            'ring_distribution': ring_counts,
            'major_radius': self.MAJOR_RADIUS,
            'delta_theta': self.DELTA_THETA,
            'delta_phi': self.DELTA_PHI,
            'memory_types': list(set(a.memory_type for a in self.anchors.values()))
        }
