"""
BACKEND MATH ENGINES — Computational Substrate
===============================================
Protocol: PROT-290 to PROT-292
Frequency: φ² = 2.618 Hz (Foundation Layer)

Backend Math Engines provide the computational substrate for
all φ-harmonic operations, probability calculations, and
torus mathematics.

Engines:
1. COMPUTATOR TOROIDALIS — Torus calculation engine (PROT-290)
2. RESONANTIA CALCULATOR — φ-harmonic resonance math (PROT-291)
3. PROBABILITAS ENGINE — Bayesian inference on organism state (PROT-292)

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
All Rights Reserved. ISIL-1.0 License.
"""

from dataclasses import dataclass, field
from typing import Dict, List, Optional, Tuple, Any
from enum import Enum
import math

# φ-Constants
PHI = 1.6180339887498948482
PHI_INV = 1 / PHI  # 0.618
PHI_2 = PHI ** 2  # 2.618
PHI_SQ = PHI ** 0.5  # √φ

# Torus Constants
TORUS_MAJOR_RADIUS = PHI * 10  # R = 16.18
TORUS_MINOR_RADIUS = PHI * 5   # r = 8.09


class MathEngineType(Enum):
    """Types of Math Engines."""
    COMPUTATOR_TOROIDALIS = "COMPUTATOR_TOROIDALIS"
    RESONANTIA_CALCULATOR = "RESONANTIA_CALCULATOR"
    PROBABILITAS_ENGINE = "PROBABILITAS_ENGINE"


@dataclass
class TorusCoordinate:
    """A coordinate in the Memory Torus."""
    theta: float  # 0 to 2π (helix ring position)
    phi: float    # 0 to 2π (toroidal rotation)
    rho: float    # Radial depth


@dataclass
class ComputatorToroidalis:
    """
    COMPUTATOR TOROIDALIS — Torus calculation engine
    
    The Computator handles all mathematics related to the
    Memory Torus: coordinate transformation, distance calculation,
    navigation, and placement algorithms.
    
    Protocol: PROT-290
    Frequency: φ² × φ = 4.236 Hz
    Latin: "Torus Calculator"
    """
    computator_id: str = "COMPUTATOR_TOROIDALIS_PRIME"
    latin_name: str = "COMPUTATOR TOROIDALIS"
    frequency_hz: float = PHI_2 * PHI
    protocol: str = "PROT-290"
    
    # Torus parameters
    major_radius: float = TORUS_MAJOR_RADIUS
    minor_radius: float = TORUS_MINOR_RADIUS
    
    def to_cartesian(self, coord: TorusCoordinate) -> Tuple[float, float, float]:
        """Convert torus coordinates to Cartesian (x, y, z)."""
        theta = coord.theta
        phi = coord.phi
        rho = coord.rho
        
        # Torus parametric equations with depth
        r = self.minor_radius + rho
        x = (self.major_radius + r * math.cos(theta)) * math.cos(phi)
        y = (self.major_radius + r * math.cos(theta)) * math.sin(phi)
        z = r * math.sin(theta)
        
        return (x, y, z)
    
    def from_cartesian(self, x: float, y: float, z: float) -> TorusCoordinate:
        """Convert Cartesian coordinates to torus coordinates."""
        phi = math.atan2(y, x)
        r_major = math.sqrt(x*x + y*y)
        theta = math.atan2(z, r_major - self.major_radius)
        rho = math.sqrt(z*z + (r_major - self.major_radius)**2) - self.minor_radius
        
        # Normalize angles to [0, 2π]
        if phi < 0:
            phi += 2 * math.pi
        if theta < 0:
            theta += 2 * math.pi
        
        return TorusCoordinate(theta=theta, phi=phi, rho=rho)
    
    def distance(self, c1: TorusCoordinate, c2: TorusCoordinate) -> float:
        """Calculate geodesic distance between two torus coordinates."""
        # Convert to Cartesian and calculate Euclidean distance
        # (approximation - true geodesic is more complex)
        p1 = self.to_cartesian(c1)
        p2 = self.to_cartesian(c2)
        
        return math.sqrt(sum((a - b)**2 for a, b in zip(p1, p2)))
    
    def golden_angle_placement(self, index: int) -> TorusCoordinate:
        """Calculate placement using golden angle for optimal distribution."""
        golden_angle = 2 * math.pi / (PHI ** 2)  # ~137.5°
        
        theta = (index * golden_angle) % (2 * math.pi)
        phi = (index * golden_angle / PHI) % (2 * math.pi)
        rho = PHI * (1 + (index % 10) / 10)  # Vary depth
        
        return TorusCoordinate(theta=theta, phi=phi, rho=rho)
    
    def navigate(self, start: TorusCoordinate, target: TorusCoordinate, 
                 steps: int = 10) -> List[TorusCoordinate]:
        """Generate navigation path between two coordinates."""
        path = []
        for i in range(steps + 1):
            t = i / steps
            theta = start.theta + t * (target.theta - start.theta)
            phi = start.phi + t * (target.phi - start.phi)
            rho = start.rho + t * (target.rho - start.rho)
            path.append(TorusCoordinate(theta=theta, phi=phi, rho=rho))
        return path
    
    def get_state(self) -> Dict:
        """Get computator state."""
        return {
            "id": self.computator_id,
            "name": self.latin_name,
            "protocol": self.protocol,
            "frequency_hz": self.frequency_hz,
            "major_radius": self.major_radius,
            "minor_radius": self.minor_radius
        }


@dataclass
class ResonantiaCalculator:
    """
    RESONANTIA CALCULATOR — φ-harmonic resonance math
    
    The Resonantia Calculator handles all φ-harmonic mathematics:
    frequency alignment, resonance detection, and harmonic analysis.
    
    Protocol: PROT-291
    Frequency: φ = 1.618 Hz
    Latin: "Resonance Calculator"
    """
    calculator_id: str = "RESONANTIA_CALCULATOR_PRIME"
    latin_name: str = "RESONANTIA CALCULATOR"
    frequency_hz: float = PHI
    protocol: str = "PROT-291"
    
    def phi_power(self, n: int) -> float:
        """Calculate φ^n."""
        return PHI ** n
    
    def fibonacci(self, n: int) -> int:
        """Calculate nth Fibonacci number."""
        if n <= 0:
            return 0
        if n == 1:
            return 1
        a, b = 0, 1
        for _ in range(2, n + 1):
            a, b = b, a + b
        return b
    
    def is_phi_harmonic(self, f1: float, f2: float, tolerance: float = 0.01) -> bool:
        """Check if two frequencies are φ-harmonically related."""
        if f1 == 0 or f2 == 0:
            return False
        ratio = max(f1, f2) / min(f1, f2)
        log_ratio = math.log(ratio) / math.log(PHI)
        return abs(log_ratio - round(log_ratio)) < tolerance
    
    def nearest_phi_harmonic(self, frequency: float, base: float = 7.83) -> Tuple[float, int]:
        """Find nearest φ-harmonic of base frequency."""
        ratio = frequency / base
        log_ratio = math.log(ratio) / math.log(PHI) if ratio > 0 else 0
        nearest_power = round(log_ratio)
        target = base * (PHI ** nearest_power)
        return target, nearest_power
    
    def resonance_strength(self, f1: float, f2: float) -> float:
        """Calculate resonance strength between two frequencies."""
        if f1 == 0 or f2 == 0:
            return 0.0
        ratio = max(f1, f2) / min(f1, f2)
        log_ratio = math.log(ratio) / math.log(PHI)
        deviation = abs(log_ratio - round(log_ratio))
        return max(0, 1 - deviation)
    
    def golden_spiral_point(self, t: float) -> Tuple[float, float]:
        """Calculate point on golden spiral at parameter t."""
        r = PHI ** (t / (2 * math.pi))
        x = r * math.cos(t)
        y = r * math.sin(t)
        return (x, y)
    
    def kuramoto_coupling(self, phases: List[float], coupling_strength: float = 1.0) -> List[float]:
        """Calculate Kuramoto oscillator coupling for phase synchronization."""
        n = len(phases)
        if n == 0:
            return []
        
        mean_phase = sum(phases) / n
        new_phases = []
        for phase in phases:
            # Kuramoto equation: dθ/dt = ω + K/N * Σ sin(θⱼ - θᵢ)
            coupling = coupling_strength * math.sin(mean_phase - phase)
            new_phases.append(phase + coupling * 0.1)  # Small time step
        
        return new_phases
    
    def get_state(self) -> Dict:
        """Get calculator state."""
        return {
            "id": self.calculator_id,
            "name": self.latin_name,
            "protocol": self.protocol,
            "frequency_hz": self.frequency_hz,
            "phi": PHI,
            "phi_inverse": PHI_INV
        }


@dataclass
class ProbabilitasEngine:
    """
    PROBABILITAS ENGINE — Bayesian inference on organism state
    
    The Probabilitas Engine performs Bayesian inference to
    estimate organism state, update beliefs, and make predictions.
    
    Protocol: PROT-292
    Frequency: φ⁻¹ = 0.618 Hz
    Latin: "Probability Engine"
    """
    engine_id: str = "PROBABILITAS_ENGINE_PRIME"
    latin_name: str = "PROBABILITAS ENGINE"
    frequency_hz: float = PHI_INV
    protocol: str = "PROT-292"
    
    # Belief state
    beliefs: Dict[str, float] = field(default_factory=dict)
    observations: List[Dict] = field(default_factory=list)
    
    def set_prior(self, hypothesis: str, probability: float):
        """Set prior probability for a hypothesis."""
        self.beliefs[hypothesis] = max(0.0, min(1.0, probability))
    
    def observe(self, evidence: str, likelihoods: Dict[str, float]):
        """Record an observation and update beliefs."""
        observation = {
            "evidence": evidence,
            "likelihoods": likelihoods,
            "timestamp": len(self.observations)
        }
        self.observations.append(observation)
        
        # Bayesian update
        self._bayesian_update(likelihoods)
    
    def _bayesian_update(self, likelihoods: Dict[str, float]):
        """Perform Bayesian update of beliefs."""
        # P(H|E) = P(E|H) * P(H) / P(E)
        # P(E) = Σ P(E|H) * P(H)
        
        # Calculate P(E)
        p_evidence = sum(
            likelihoods.get(h, 0.5) * self.beliefs.get(h, 0.5)
            for h in set(likelihoods.keys()) | set(self.beliefs.keys())
        )
        
        if p_evidence == 0:
            return
        
        # Update each belief
        for hypothesis in self.beliefs:
            likelihood = likelihoods.get(hypothesis, 0.5)
            prior = self.beliefs[hypothesis]
            posterior = (likelihood * prior) / p_evidence
            self.beliefs[hypothesis] = posterior
    
    def get_probability(self, hypothesis: str) -> float:
        """Get current probability of a hypothesis."""
        return self.beliefs.get(hypothesis, 0.5)  # Default to maximum entropy
    
    def most_likely(self) -> Tuple[str, float]:
        """Get the most likely hypothesis."""
        if not self.beliefs:
            return ("UNKNOWN", 0.5)
        return max(self.beliefs.items(), key=lambda x: x[1])
    
    def entropy(self) -> float:
        """Calculate entropy of current belief distribution."""
        if not self.beliefs:
            return 0.0
        
        total = sum(self.beliefs.values())
        if total == 0:
            return 0.0
        
        entropy = 0.0
        for p in self.beliefs.values():
            if p > 0:
                normalized = p / total
                entropy -= normalized * math.log2(normalized)
        
        return entropy
    
    def confidence(self) -> float:
        """Calculate confidence (inverse of normalized entropy)."""
        max_entropy = math.log2(max(len(self.beliefs), 1))
        if max_entropy == 0:
            return 1.0
        return 1 - (self.entropy() / max_entropy)
    
    def get_state(self) -> Dict:
        """Get engine state."""
        most_likely_h, most_likely_p = self.most_likely()
        return {
            "id": self.engine_id,
            "name": self.latin_name,
            "protocol": self.protocol,
            "frequency_hz": self.frequency_hz,
            "hypotheses": len(self.beliefs),
            "observations": len(self.observations),
            "entropy": self.entropy(),
            "confidence": self.confidence(),
            "most_likely": {"hypothesis": most_likely_h, "probability": most_likely_p}
        }


# Registry of all Math Engines
MATH_ENGINES_REGISTRY = {
    "COMPUTATOR_TOROIDALIS": {
        "class": ComputatorToroidalis,
        "protocol": "PROT-290",
        "frequency_hz": PHI_2 * PHI,
        "description": "Torus calculation engine"
    },
    "RESONANTIA_CALCULATOR": {
        "class": ResonantiaCalculator,
        "protocol": "PROT-291",
        "frequency_hz": PHI,
        "description": "φ-harmonic resonance math"
    },
    "PROBABILITAS_ENGINE": {
        "class": ProbabilitasEngine,
        "protocol": "PROT-292",
        "frequency_hz": PHI_INV,
        "description": "Bayesian inference on organism state"
    }
}


def get_math_engines_summary() -> Dict:
    """Get summary of all Math Engines."""
    return {
        "module": "BACKEND_MATH_ENGINES",
        "protocols": ["PROT-290", "PROT-291", "PROT-292"],
        "base_frequency_hz": PHI_2,
        "engines": list(MATH_ENGINES_REGISTRY.keys()),
        "count": len(MATH_ENGINES_REGISTRY),
        "phi": PHI,
        "phi_inverse": PHI_INV
    }


__all__ = [
    'ComputatorToroidalis',
    'ResonantiaCalculator',
    'ProbabilitasEngine',
    'TorusCoordinate',
    'MathEngineType',
    'MATH_ENGINES_REGISTRY',
    'get_math_engines_summary',
    'PHI',
    'PHI_INV',
    'PHI_2',
    'TORUS_MAJOR_RADIUS',
    'TORUS_MINOR_RADIUS'
]

__version__ = 'φ.0.1.0'
__protocol__ = 'PROT-290-292'
