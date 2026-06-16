"""
Coupling Matrix — Cross-Organism Coupling Rules
================================================
Defines coupling rules and matrices for Kuramoto-style
organism synchronization.

Coupling Types:
- UNIFORM: All organisms coupled equally
- PHI_SCALED: Coupling scaled by golden ratio distance
- TORUS_PROXIMITY: Coupling based on torus coordinate distance
- HIERARCHICAL: Coupling based on organism hierarchy
- CUSTOM: User-defined coupling rules
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Tuple

# Golden ratio
PHI = (1 + math.sqrt(5)) / 2


class CouplingType(str, Enum):
    """Types of coupling rules."""
    UNIFORM = "uniform"
    PHI_SCALED = "phi_scaled"
    TORUS_PROXIMITY = "torus_proximity"
    HIERARCHICAL = "hierarchical"
    CUSTOM = "custom"


@dataclass
class CouplingRule:
    """
    Rule for computing coupling strength between organisms.
    """
    
    rule_id: str = ""
    name: str = ""
    coupling_type: CouplingType = CouplingType.UNIFORM
    
    # Base coupling strength
    base_strength: float = 0.5
    
    # Scaling parameters
    phi_exponent: float = 1.0  # For PHI_SCALED
    distance_decay: float = 1.0  # For TORUS_PROXIMITY
    hierarchy_factor: float = 0.5  # For HIERARCHICAL
    
    # Bounds
    min_coupling: float = 0.0
    max_coupling: float = 1.0
    
    # Custom evaluator
    custom_evaluator: Optional[Callable[[Dict[str, Any], Dict[str, Any]], float]] = None
    
    def compute(
        self,
        organism_a: Dict[str, Any],
        organism_b: Dict[str, Any],
    ) -> float:
        """
        Compute coupling strength between two organisms.
        
        Args:
            organism_a: Properties of first organism
            organism_b: Properties of second organism
        
        Returns:
            Coupling strength [min_coupling, max_coupling]
        """
        if self.coupling_type == CouplingType.UNIFORM:
            strength = self.base_strength
        
        elif self.coupling_type == CouplingType.PHI_SCALED:
            # Scale by golden ratio based on index difference
            idx_a = organism_a.get("index", 0)
            idx_b = organism_b.get("index", 0)
            distance = abs(idx_a - idx_b)
            strength = self.base_strength / (PHI ** (distance * self.phi_exponent))
        
        elif self.coupling_type == CouplingType.TORUS_PROXIMITY:
            # Scale by torus coordinate distance
            theta_a = organism_a.get("theta", 0.0)
            theta_b = organism_b.get("theta", 0.0)
            phi_a = organism_a.get("phi", 0.0)
            phi_b = organism_b.get("phi", 0.0)
            
            # Angular distance on torus
            d_theta = abs(theta_a - theta_b)
            d_phi = abs(phi_a - phi_b)
            distance = math.sqrt(d_theta**2 + d_phi**2)
            
            strength = self.base_strength * math.exp(-self.distance_decay * distance)
        
        elif self.coupling_type == CouplingType.HIERARCHICAL:
            # Stronger coupling for hierarchically related organisms
            level_a = organism_a.get("level", 0)
            level_b = organism_b.get("level", 0)
            level_diff = abs(level_a - level_b)
            
            if level_diff == 0:
                # Same level - base strength
                strength = self.base_strength
            elif level_diff == 1:
                # Adjacent levels - increased coupling
                strength = self.base_strength * (1 + self.hierarchy_factor)
            else:
                # Distant levels - decreased coupling
                strength = self.base_strength / (level_diff * self.hierarchy_factor + 1)
        
        elif self.coupling_type == CouplingType.CUSTOM:
            if self.custom_evaluator:
                strength = self.custom_evaluator(organism_a, organism_b)
            else:
                strength = self.base_strength
        
        else:
            strength = self.base_strength
        
        # Apply bounds
        return max(self.min_coupling, min(self.max_coupling, strength))
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "rule_id": self.rule_id,
            "name": self.name,
            "coupling_type": self.coupling_type.value,
            "base_strength": self.base_strength,
            "phi_exponent": self.phi_exponent,
            "distance_decay": self.distance_decay,
            "hierarchy_factor": self.hierarchy_factor,
            "min_coupling": self.min_coupling,
            "max_coupling": self.max_coupling,
        }


@dataclass
class BoundedCoupling:
    """
    Bounded coupling constraint for cross-organism influence.
    
    Ensures coupling remains within safe bounds to prevent
    runaway synchronization or desynchronization.
    """
    
    # Global bounds
    max_total_influence: float = 1.0     # Max sum of all influences
    max_single_influence: float = 0.5    # Max influence from one source
    min_coherence_to_send: float = 0.1   # Min coherence to send influence
    min_energy_to_receive: float = 0.1   # Min energy to receive influence
    
    # Decay and damping
    influence_decay_rate: float = 0.1    # How fast influence decays
    coupling_damping: float = 0.9        # Damping factor for coupling
    
    # Protection
    desync_protection: bool = True       # Protect against desynchronization
    runaway_protection: bool = True      # Protect against runaway sync
    
    def bound_influence(
        self,
        raw_influence: float,
        current_total: float = 0.0,
    ) -> float:
        """
        Apply bounds to raw influence value.
        
        Args:
            raw_influence: Raw influence to bound
            current_total: Current total influence received
        
        Returns:
            Bounded influence value
        """
        # Apply single-source bound
        bounded = min(abs(raw_influence), self.max_single_influence)
        
        # Apply total bound
        available = self.max_total_influence - current_total
        bounded = min(bounded, max(0.0, available))
        
        # Apply sign
        bounded = bounded if raw_influence >= 0 else -bounded
        
        return bounded
    
    def can_send(
        self,
        coherence: float,
        energy: float,
    ) -> bool:
        """Check if organism can send influence."""
        return coherence >= self.min_coherence_to_send
    
    def can_receive(
        self,
        coherence: float,
        energy: float,
    ) -> bool:
        """Check if organism can receive influence."""
        return energy >= self.min_energy_to_receive
    
    def apply_damping(self, coupling: float) -> float:
        """Apply damping to coupling value."""
        return coupling * self.coupling_damping
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "max_total_influence": self.max_total_influence,
            "max_single_influence": self.max_single_influence,
            "min_coherence_to_send": self.min_coherence_to_send,
            "min_energy_to_receive": self.min_energy_to_receive,
            "influence_decay_rate": self.influence_decay_rate,
            "coupling_damping": self.coupling_damping,
            "desync_protection": self.desync_protection,
            "runaway_protection": self.runaway_protection,
        }


class CouplingMatrix:
    """
    Coupling matrix K_ij for N organisms.
    
    K_ij represents the coupling strength from organism j to organism i.
    Used in Kuramoto dynamics: d(θᵢ)/dt = ωᵢ + Σⱼ Kᵢⱼ sin(θⱼ - θᵢ)
    """
    
    def __init__(
        self,
        default_rule: Optional[CouplingRule] = None,
        bounds: Optional[BoundedCoupling] = None,
    ) -> None:
        self.default_rule = default_rule or CouplingRule()
        self.bounds = bounds or BoundedCoupling()
        
        # Matrix storage: organism_id -> organism_id -> coupling
        self._matrix: Dict[str, Dict[str, float]] = {}
        
        # Organism properties (for rule computation)
        self._organisms: Dict[str, Dict[str, Any]] = {}
        
        # Custom rules per organism pair
        self._custom_rules: Dict[Tuple[str, str], CouplingRule] = {}
    
    def add_organism(
        self,
        organism_id: str,
        properties: Optional[Dict[str, Any]] = None,
    ) -> None:
        """Add an organism to the matrix."""
        self._organisms[organism_id] = properties or {}
        
        if organism_id not in self._matrix:
            self._matrix[organism_id] = {}
        
        # Compute coupling to all existing organisms
        for other_id in self._organisms:
            if other_id == organism_id:
                continue
            
            self._compute_and_set(organism_id, other_id)
            self._compute_and_set(other_id, organism_id)
    
    def remove_organism(self, organism_id: str) -> None:
        """Remove an organism from the matrix."""
        if organism_id in self._matrix:
            del self._matrix[organism_id]
        
        if organism_id in self._organisms:
            del self._organisms[organism_id]
        
        # Remove from other rows
        for other_id in self._matrix:
            if organism_id in self._matrix[other_id]:
                del self._matrix[other_id][organism_id]
        
        # Remove custom rules
        keys_to_remove = [
            k for k in self._custom_rules
            if organism_id in k
        ]
        for k in keys_to_remove:
            del self._custom_rules[k]
    
    def _compute_and_set(self, from_id: str, to_id: str) -> None:
        """Compute and set coupling from rule."""
        rule = self._custom_rules.get((from_id, to_id), self.default_rule)
        
        props_from = self._organisms.get(from_id, {})
        props_to = self._organisms.get(to_id, {})
        
        coupling = rule.compute(props_from, props_to)
        coupling = self.bounds.apply_damping(coupling)
        
        if from_id not in self._matrix:
            self._matrix[from_id] = {}
        self._matrix[from_id][to_id] = coupling
    
    def get(self, from_id: str, to_id: str) -> float:
        """Get coupling strength from organism to organism."""
        return self._matrix.get(from_id, {}).get(to_id, 0.0)
    
    def set(
        self,
        from_id: str,
        to_id: str,
        coupling: float,
    ) -> None:
        """Set coupling strength directly."""
        coupling = max(0.0, min(1.0, coupling))
        
        if from_id not in self._matrix:
            self._matrix[from_id] = {}
        self._matrix[from_id][to_id] = coupling
    
    def set_custom_rule(
        self,
        from_id: str,
        to_id: str,
        rule: CouplingRule,
    ) -> None:
        """Set custom rule for organism pair."""
        self._custom_rules[(from_id, to_id)] = rule
        self._compute_and_set(from_id, to_id)
    
    def recompute_all(self) -> None:
        """Recompute all coupling values."""
        for from_id in self._organisms:
            for to_id in self._organisms:
                if from_id != to_id:
                    self._compute_and_set(from_id, to_id)
    
    def get_row(self, organism_id: str) -> Dict[str, float]:
        """Get all couplings from an organism."""
        return dict(self._matrix.get(organism_id, {}))
    
    def get_column(self, organism_id: str) -> Dict[str, float]:
        """Get all couplings to an organism."""
        result: Dict[str, float] = {}
        for from_id, row in self._matrix.items():
            if organism_id in row:
                result[from_id] = row[organism_id]
        return result
    
    def to_dict(self) -> Dict[str, Any]:
        """Serialize matrix."""
        return {
            "organisms": list(self._organisms.keys()),
            "matrix": {
                k: dict(v) for k, v in self._matrix.items()
            },
            "default_rule": self.default_rule.to_dict(),
            "bounds": self.bounds.to_dict(),
        }


def compute_kuramoto_coupling(
    phases: List[float],
    coupling_matrix: List[List[float]],
    frequencies: Optional[List[float]] = None,
    dt: float = 0.1,
) -> List[float]:
    """
    Compute one step of Kuramoto dynamics.
    
    d(θᵢ)/dt = ωᵢ + Σⱼ Kᵢⱼ sin(θⱼ - θᵢ)
    
    Args:
        phases: Current phases [θ₁, θ₂, ..., θₙ]
        coupling_matrix: N×N coupling matrix K
        frequencies: Natural frequencies [ω₁, ω₂, ..., ωₙ]
        dt: Time step
    
    Returns:
        New phases after one step
    """
    n = len(phases)
    
    if frequencies is None:
        frequencies = [1.0] * n
    
    new_phases = []
    
    for i in range(n):
        # Sum coupling from all other oscillators
        coupling_sum = 0.0
        for j in range(n):
            if i != j:
                k_ij = coupling_matrix[i][j]
                phase_diff = phases[j] - phases[i]
                coupling_sum += k_ij * math.sin(phase_diff)
        
        # Update phase
        d_theta = frequencies[i] + coupling_sum
        new_theta = (phases[i] + dt * d_theta) % (2 * math.pi)
        new_phases.append(new_theta)
    
    return new_phases
