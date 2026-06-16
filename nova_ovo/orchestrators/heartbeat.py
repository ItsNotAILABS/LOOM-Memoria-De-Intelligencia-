"""
Heartbeat Engine — Core Cardiac Rhythm
======================================
The heartbeat engine maintains the fundamental rhythm
of the organism, implementing heart-brain coupling.

Per AURO requirements, computes every beat:
- heart-brain resonance
- phase lag
- doctrine-aligned direction vector
- propulsion (push magnitude)
- alignment score
- push effectiveness
"""

from __future__ import annotations

import math
import time
from dataclasses import dataclass, field
from typing import Any, Dict, List, Tuple

from ..core.recital import PHI


@dataclass
class CardiacState:
    """
    State of the cardiac system at a single beat.
    
    Implements phase coupling:
    d(theta_i)/dt = omega_i + Σ K_ij sin(theta_j - theta_i)
    """
    
    beat: int = 0
    
    # Phase angles (radians)
    theta_heart: float = 0.0
    theta_brain: float = 0.0
    
    # Frequencies (base oscillation rates)
    omega_heart: float = 1.0  # ~1 Hz resting heart rate
    omega_brain: float = PHI  # Golden ratio scaled brain rhythm
    
    # Coupling strength
    K_hb: float = 0.5  # Heart -> Brain coupling
    K_bh: float = 0.3  # Brain -> Heart coupling
    
    # Derived metrics
    phase_lag: float = 0.0
    resonance: float = 1.0
    direction: Tuple[float, float, float] = (0.0, 0.0, 1.0)
    propulsion: float = 0.0
    alignment: float = 1.0
    effectiveness: float = 1.0
    
    # Doctrine alignment
    doctrine_coherence: float = 1.0
    
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "beat": self.beat,
            "theta_heart": self.theta_heart,
            "theta_brain": self.theta_brain,
            "omega_heart": self.omega_heart,
            "omega_brain": self.omega_brain,
            "K_hb": self.K_hb,
            "K_bh": self.K_bh,
            "phase_lag": self.phase_lag,
            "resonance": self.resonance,
            "direction": self.direction,
            "propulsion": self.propulsion,
            "alignment": self.alignment,
            "effectiveness": self.effectiveness,
            "doctrine_coherence": self.doctrine_coherence,
            "timestamp": self.timestamp,
        }


class HeartbeatEngine:
    """
    Core heartbeat engine implementing cardiac rhythm.
    
    The heartbeat is the fundamental clock of the organism.
    All other systems synchronize to this rhythm.
    """
    
    def __init__(
        self,
        omega_heart: float = 1.0,
        omega_brain: float = PHI,
        K_hb: float = 0.5,
        K_bh: float = 0.3,
    ) -> None:
        self._state = CardiacState(
            omega_heart=omega_heart,
            omega_brain=omega_brain,
            K_hb=K_hb,
            K_bh=K_bh,
        )
        self._history: List[CardiacState] = []
        self._dt = 1.0 / (PHI * 10)  # Time step
    
    @property
    def current_state(self) -> CardiacState:
        return self._state
    
    @property
    def current_beat(self) -> int:
        return self._state.beat
    
    def tick(self, doctrine_coherence: float = 1.0) -> CardiacState:
        """
        Execute one heartbeat cycle.
        
        Implements Kuramoto phase coupling:
        d(theta_heart)/dt = omega_heart + K_bh * sin(theta_brain - theta_heart)
        d(theta_brain)/dt = omega_brain + K_hb * sin(theta_heart - theta_brain)
        """
        s = self._state
        
        # Phase coupling equations
        d_theta_heart = s.omega_heart + s.K_bh * math.sin(s.theta_brain - s.theta_heart)
        d_theta_brain = s.omega_brain + s.K_hb * math.sin(s.theta_heart - s.theta_brain)
        
        # Update phases
        new_theta_heart = (s.theta_heart + self._dt * d_theta_heart) % (2 * math.pi)
        new_theta_brain = (s.theta_brain + self._dt * d_theta_brain) % (2 * math.pi)
        
        # Compute phase lag
        phase_lag = (new_theta_brain - new_theta_heart) % (2 * math.pi)
        if phase_lag > math.pi:
            phase_lag -= 2 * math.pi
        
        # Compute resonance (optimal when phases aligned)
        resonance = (1 + math.cos(phase_lag)) / 2
        
        # Compute direction vector (doctrine-aligned)
        direction = (
            math.cos(new_theta_heart) * doctrine_coherence,
            math.sin(new_theta_heart) * doctrine_coherence,
            math.cos(new_theta_brain) * doctrine_coherence,
        )
        
        # Compute propulsion (push magnitude)
        propulsion = resonance * abs(math.sin(new_theta_heart))
        
        # Compute alignment with doctrine
        dir_magnitude = math.sqrt(sum(d**2 for d in direction))
        alignment = dir_magnitude * doctrine_coherence
        
        # Compute push effectiveness
        effectiveness = propulsion * alignment * resonance
        
        # Create new state
        new_state = CardiacState(
            beat=s.beat + 1,
            theta_heart=new_theta_heart,
            theta_brain=new_theta_brain,
            omega_heart=s.omega_heart,
            omega_brain=s.omega_brain,
            K_hb=s.K_hb,
            K_bh=s.K_bh,
            phase_lag=phase_lag,
            resonance=resonance,
            direction=direction,
            propulsion=propulsion,
            alignment=alignment,
            effectiveness=effectiveness,
            doctrine_coherence=doctrine_coherence,
        )
        
        self._history.append(new_state)
        self._state = new_state
        
        return new_state
    
    def get_coherence(self) -> float:
        """
        Compute global coherence.
        
        r = |(1/N) Σ exp(i * theta_j)|
        
        For 2 oscillators:
        r = |exp(i*theta_heart) + exp(i*theta_brain)| / 2
        """
        s = self._state
        
        real_sum = math.cos(s.theta_heart) + math.cos(s.theta_brain)
        imag_sum = math.sin(s.theta_heart) + math.sin(s.theta_brain)
        
        r = math.sqrt(real_sum**2 + imag_sum**2) / 2
        return r
    
    def set_coupling(self, K_hb: float, K_bh: float) -> None:
        """Adjust coupling strengths."""
        self._state.K_hb = K_hb
        self._state.K_bh = K_bh
    
    def set_frequencies(self, omega_heart: float, omega_brain: float) -> None:
        """Adjust base frequencies."""
        self._state.omega_heart = omega_heart
        self._state.omega_brain = omega_brain
    
    def get_history(self, limit: int = 100) -> List[CardiacState]:
        """Get beat history."""
        return self._history[-limit:]
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get heartbeat statistics."""
        if not self._history:
            return {"beats": 0}
        
        resonances = [s.resonance for s in self._history]
        propulsions = [s.propulsion for s in self._history]
        
        return {
            "beats": len(self._history),
            "current_beat": self._state.beat,
            "avg_resonance": sum(resonances) / len(resonances),
            "avg_propulsion": sum(propulsions) / len(propulsions),
            "current_coherence": self.get_coherence(),
            "theta_heart": self._state.theta_heart,
            "theta_brain": self._state.theta_brain,
        }
