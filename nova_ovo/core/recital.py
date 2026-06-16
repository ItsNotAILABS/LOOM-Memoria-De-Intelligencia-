"""
RECITAL_PLUS_ONE — Master generative law of NOVA OVO.

  state(n+1) = recital(Ψ_n) ⊕ Δ_lawful

Mathematical foundation (4-dimensional state manifold):

  Ψ ∈ ℝ⁴   where dimensions are:
    ψ₀ = doctrine coherence     ∈ [0, 1]
    ψ₁ = execution velocity     ∈ [0, ∞)
    ψ₂ = memory depth           ∈ [0, ∞)
    ψ₃ = projection exposure    ∈ [0, 1]

  Recital operator R: ℝ⁴ → ℝ⁴
    R(Ψ) = normalize(Ψ) ⊗ constitution_matrix(C)

  Lawful expansion Δ:
    Δ_lawful iff ‖Δ‖ ≤ ε_max AND Δ satisfies gate_A(Δ)

  Torus phase encoding (memory coordinates):
    θ ∈ [0, 2π)   — angular position on helix ring
    φ ∈ [0, 2π)   — toroidal rotation
    ρ ∈ ℝ₊        — radial depth
    β ∈ ℕ         — beat counter (discrete time)

  Toroidal embedding:
    x = (R + ρ·cos θ)·cos φ
    y = (R + ρ·cos θ)·sin φ
    z = ρ·sin θ
    t = β · Δt_beat

Ancient architectural constant (φ = golden ratio):
  φ = (1 + √5) / 2 ≈ 1.6180339887...
  Used as natural scaling factor for beat intervals and ring radii.
"""

from __future__ import annotations

import math
import time
import uuid
from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional, Tuple

# Golden ratio — natural expansion constant
PHI = (1 + math.sqrt(5)) / 2

# Major torus radius (memory temple geometry)
TORUS_R = PHI * 10.0

# Maximum single-beat expansion magnitude
EPSILON_MAX = 1.0


@dataclass
class OrganismState:
    """
    4-dimensional organism state vector Ψ ∈ ℝ⁴.

    Torus coordinates give each state a unique position in memory space.
    """

    beat: int = 0
    doctrine_coherence: float = 1.0      # ψ₀ ∈ [0,1]
    execution_velocity: float = 0.0      # ψ₁ ∈ [0,∞)
    memory_depth: float = 0.0            # ψ₂ ∈ [0,∞)
    projection_exposure: float = 0.0     # ψ₃ ∈ [0,1]

    # Torus phase coordinates
    theta: float = 0.0    # helix angle θ ∈ [0, 2π)
    phi: float = 0.0      # toroidal rotation φ ∈ [0, 2π)
    depth: float = 1.0    # radial depth ρ
    ring: int = 0         # memory ring index

    # Provenance
    state_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    parent_id: Optional[str] = None
    timestamp: float = field(default_factory=time.time)
    expansion_label: str = ""

    # ------------------------------------------------------------------ #
    # 4D vector operations                                                  #
    # ------------------------------------------------------------------ #

    def vector(self) -> Tuple[float, float, float, float]:
        """Return the 4D state vector (ψ₀, ψ₁, ψ₂, ψ₃)."""
        return (
            self.doctrine_coherence,
            self.execution_velocity,
            self.memory_depth,
            self.projection_exposure,
        )

    def magnitude(self) -> float:
        """‖Ψ‖ — Euclidean norm of the state vector."""
        return math.sqrt(sum(v ** 2 for v in self.vector()))

    # ------------------------------------------------------------------ #
    # Torus embedding                                                        #
    # ------------------------------------------------------------------ #

    def torus_xyz(self) -> Tuple[float, float, float]:
        """
        Cartesian embedding on the torus surface.

          x = (R + ρ·cos θ)·cos φ
          y = (R + ρ·cos θ)·sin φ
          z = ρ·sin θ
        """
        r = TORUS_R
        rho = self.depth
        th = self.theta
        ph = self.phi
        x = (r + rho * math.cos(th)) * math.cos(ph)
        y = (r + rho * math.cos(th)) * math.sin(ph)
        z = rho * math.sin(th)
        return x, y, z

    def torus_coords(self) -> Dict[str, Any]:
        x, y, z = self.torus_xyz()
        return {
            "theta": round(self.theta, 6),
            "phi": round(self.phi, 6),
            "depth": round(self.depth, 6),
            "ring": self.ring,
            "beat": self.beat,
            "xyz": (round(x, 4), round(y, 4), round(z, 4)),
        }

    # ------------------------------------------------------------------ #
    # Serialization                                                          #
    # ------------------------------------------------------------------ #

    def to_dict(self) -> Dict[str, Any]:
        return {
            "state_id": self.state_id,
            "parent_id": self.parent_id,
            "beat": self.beat,
            "timestamp": self.timestamp,
            "expansion_label": self.expansion_label,
            "vector": {
                "doctrine_coherence": self.doctrine_coherence,
                "execution_velocity": self.execution_velocity,
                "memory_depth": self.memory_depth,
                "projection_exposure": self.projection_exposure,
            },
            "torus": self.torus_coords(),
        }


class RecitalEngine:
    """
    Implements the RECITAL_PLUS_ONE law.

      state(n+1) = R(Ψ_n) ⊕ Δ_lawful

    The recital operator R normalizes and validates the current state
    against the constitutional matrix before allowing expansion.

    Constitution matrix C encodes invariant doctrine constraints:
      C = [[c₀₀, c₀₁, c₀₂, c₀₃],   (doctrine coherence row)
           [c₁₀, c₁₁, c₁₂, c₁₃],   (execution velocity row)
           [c₂₀, c₂₁, c₂₂, c₂₃],   (memory depth row)
           [c₃₀, c₃₁, c₃₂, c₃₃]]  (projection exposure row)

    C is initialized to the identity scaled by φ (golden ratio),
    anchoring expansion to natural harmonic growth.
    """

    # Constitution matrix C = φ · I₄
    CONSTITUTION_MATRIX: List[List[float]] = [
        [PHI, 0.0, 0.0, 0.0],
        [0.0, PHI, 0.0, 0.0],
        [0.0, 0.0, PHI, 0.0],
        [0.0, 0.0, 0.0, PHI],
    ]

    def __init__(self) -> None:
        self._history: List[OrganismState] = []
        self._current: OrganismState = OrganismState()
        self._history.append(self._current)

    # ------------------------------------------------------------------ #
    # Core recital                                                           #
    # ------------------------------------------------------------------ #

    @property
    def current(self) -> OrganismState:
        return self._current

    @property
    def history(self) -> List[OrganismState]:
        return list(self._history)

    def recital(self, state: OrganismState) -> OrganismState:
        """
        Apply recital operator R to state Ψ_n.

        R normalizes the state vector to unit sphere within constitutional bounds
        and advances torus coordinates by one beat (φ-scaled arc increment).
        """
        v = list(state.vector())

        # Clamp bounded dimensions
        v[0] = max(0.0, min(1.0, v[0]))   # doctrine_coherence ∈ [0,1]
        v[3] = max(0.0, min(1.0, v[3]))   # projection_exposure ∈ [0,1]

        # Advance torus phase by φ-scaled increment (natural beat cadence)
        delta_theta = (2 * math.pi) / (PHI ** 2 * 10)
        delta_phi = (2 * math.pi) / (PHI ** 3 * 10)

        new_theta = (state.theta + delta_theta) % (2 * math.pi)
        new_phi = (state.phi + delta_phi) % (2 * math.pi)

        # Ring advances every full toroidal cycle
        new_ring = state.ring + (1 if new_phi < state.phi else 0)

        return OrganismState(
            beat=state.beat,
            doctrine_coherence=v[0],
            execution_velocity=v[1],
            memory_depth=v[2],
            projection_exposure=v[3],
            theta=new_theta,
            phi=new_phi,
            depth=state.depth,
            ring=new_ring,
            state_id=state.state_id,
            parent_id=state.parent_id,
            timestamp=state.timestamp,
            expansion_label=state.expansion_label,
        )

    def _validate_expansion(self, delta: Dict[str, float]) -> bool:
        """
        Gate A pre-check: expansion Δ is lawful iff ‖Δ‖ ≤ ε_max.
        """
        mag = math.sqrt(sum(v ** 2 for v in delta.values() if isinstance(v, (int, float))))
        return mag <= EPSILON_MAX

    def expand(
        self,
        expansion_label: str,
        doctrine_delta: float = 0.0,
        velocity_delta: float = 0.0,
        memory_delta: float = 0.0,
        exposure_delta: float = 0.0,
    ) -> Optional[OrganismState]:
        """
        Apply one lawful expansion Δ and advance to state(n+1).

        Returns new state on success, None if expansion is unlawful.
        """
        delta = {
            "d": doctrine_delta,
            "v": velocity_delta,
            "m": memory_delta,
            "e": exposure_delta,
        }
        if not self._validate_expansion(delta):
            return None

        # Recite current state
        recited = self.recital(self._current)

        # Apply expansion
        new_state = OrganismState(
            beat=recited.beat + 1,
            doctrine_coherence=recited.doctrine_coherence + doctrine_delta,
            execution_velocity=recited.execution_velocity + velocity_delta,
            memory_depth=recited.memory_depth + memory_delta,
            projection_exposure=recited.projection_exposure + exposure_delta,
            theta=recited.theta,
            phi=recited.phi,
            depth=recited.depth,
            ring=recited.ring,
            parent_id=recited.state_id,
            expansion_label=expansion_label,
        )

        self._current = new_state
        self._history.append(new_state)
        return new_state

    def replay(self, from_beat: int = 0, to_beat: Optional[int] = None) -> List[OrganismState]:
        """Return slice of state history for replay."""
        end = to_beat + 1 if to_beat is not None else len(self._history)
        return [s for s in self._history if from_beat <= s.beat < end]

    def lineage(self, state_id: str) -> List[OrganismState]:
        """Trace ancestry chain back to root."""
        id_map = {s.state_id: s for s in self._history}
        chain: List[OrganismState] = []
        current_id: Optional[str] = state_id
        while current_id and current_id in id_map:
            s = id_map[current_id]
            chain.insert(0, s)
            current_id = s.parent_id
        return chain
