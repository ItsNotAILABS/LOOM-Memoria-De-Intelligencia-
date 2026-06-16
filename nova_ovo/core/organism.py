"""
ORGANISM_SOVEREIGN
==================
The living constitutional body of NOVA OVO.

Single source of truth held in four registers:

  Ω = {Ω_F, Ω_B, Ω_O, Ω_E}

  Ω_F  (Founder)   — founding intent, doctrine root
  Ω_B  (Builder)   — workforce proposals, execution claims
  Ω_O  (Organism)  — validated runtime truth (Core A)
  Ω_E  (External)  — safe projection payload (Gate C bounded)

Boundary rule:
  Core A = runtime truth (Ω_O authoritative source)
  Core B = workforce execution (Ω_B proposes → Core A authorizes)

Collapse prevention:
  Absolute ≠ Law ≠ Model ≠ Engine ≠ Core ≠ Module ≠ Lab
           ≠ Workforce ≠ Product
"""

from __future__ import annotations

import json
import time
import uuid
from dataclasses import dataclass, field, asdict
from enum import Enum
from typing import Any, Dict, Optional


class Register(str, Enum):
    FOUNDER = "founder"
    BUILDER = "builder"
    ORGANISM = "organism"
    EXTERNAL = "external"


@dataclass
class RegisterState:
    """State held by a single organism register."""

    register: Register
    content: Dict[str, Any] = field(default_factory=dict)
    version: int = 0
    beat: int = 0
    updated_at: float = field(default_factory=time.time)

    def bump(self, delta: Dict[str, Any]) -> "RegisterState":
        """Return a new RegisterState with delta merged in."""
        merged = {**self.content, **delta}
        return RegisterState(
            register=self.register,
            content=merged,
            version=self.version + 1,
            beat=self.beat + 1,
            updated_at=time.time(),
        )

    def to_dict(self) -> Dict[str, Any]:
        d = asdict(self)
        d["register"] = self.register.value
        return d


class DualReadResult:
    """
    Always-on dual-read result: semantic + resonance.

    If either read fails the Organism degrades to HALT_WRITE policy.
    """

    def __init__(self, semantic_ok: bool, resonance_ok: bool, payload: Any = None):
        self.semantic_ok = semantic_ok
        self.resonance_ok = resonance_ok
        self.payload = payload

    @property
    def ok(self) -> bool:
        return self.semantic_ok and self.resonance_ok

    @property
    def degraded(self) -> bool:
        return not self.ok

    def __repr__(self) -> str:
        return (
            f"DualRead(semantic={self.semantic_ok}, "
            f"resonance={self.resonance_ok}, ok={self.ok})"
        )


class OrganismSovereign:
    """
    ORGANISM_SOVEREIGN — the single living constitutional body.

    Maintains four registers with dual-read integrity.
    All mutations pass through Gate A before touching Ω_O.
    """

    def __init__(self) -> None:
        self._registers: Dict[Register, RegisterState] = {
            Register.FOUNDER: RegisterState(register=Register.FOUNDER),
            Register.BUILDER: RegisterState(register=Register.BUILDER),
            Register.ORGANISM: RegisterState(register=Register.ORGANISM),
            Register.EXTERNAL: RegisterState(register=Register.EXTERNAL),
        }
        self._id = str(uuid.uuid4())
        self._created_at = time.time()
        self._write_halted = False

    # ------------------------------------------------------------------ #
    # Dual Read                                                             #
    # ------------------------------------------------------------------ #

    def dual_read(self, register: Register) -> DualReadResult:
        """
        Perform semantic + resonance read on a register.

        Semantic  — structural integrity of the register content.
        Resonance — alignment of register with organism constitution.

        If either fails → autonomous write degrade/halt by policy.
        """
        state = self._registers[register]

        # Semantic check: register must have a valid structure
        semantic_ok = isinstance(state.content, dict) and state.version >= 0

        # Resonance check: register beat must not have drifted beyond tolerance
        # (simple policy: builder beat should never lead organism beat by >1)
        org_beat = self._registers[Register.ORGANISM].beat
        reg_beat = state.beat
        if register == Register.BUILDER:
            resonance_ok = (reg_beat - org_beat) <= 1
        else:
            resonance_ok = True

        result = DualReadResult(
            semantic_ok=semantic_ok,
            resonance_ok=resonance_ok,
            payload=state.content,
        )

        if result.degraded:
            self._write_halted = True

        return result

    # ------------------------------------------------------------------ #
    # Reads                                                                 #
    # ------------------------------------------------------------------ #

    def read(self, register: Register) -> RegisterState:
        """Read a register state (no side-effects)."""
        return self._registers[register]

    def snapshot(self) -> Dict[str, Any]:
        """Full organism snapshot."""
        return {
            "id": self._id,
            "created_at": self._created_at,
            "write_halted": self._write_halted,
            "registers": {r.value: s.to_dict() for r, s in self._registers.items()},
        }

    # ------------------------------------------------------------------ #
    # Authorized writes (Core A path)                                       #
    # ------------------------------------------------------------------ #

    def authorize_organism_write(self, delta: Dict[str, Any]) -> bool:
        """
        Core A authorizes a runtime-truth mutation to Ω_O.

        Returns False if write-halted or dual-read fails.
        """
        if self._write_halted:
            return False

        dr = self.dual_read(Register.ORGANISM)
        if dr.degraded:
            return False

        self._registers[Register.ORGANISM] = self._registers[Register.ORGANISM].bump(
            delta
        )
        return True

    def propose_builder_write(self, delta: Dict[str, Any]) -> bool:
        """
        Core B proposes a write to Ω_B.
        This does NOT touch Ω_O; governance must authorize promotion.
        """
        if self._write_halted:
            return False

        self._registers[Register.BUILDER] = self._registers[Register.BUILDER].bump(
            delta
        )
        return True

    def promote_builder_to_organism(self, keys: list[str]) -> bool:
        """
        Promote specific keys from Ω_B into Ω_O (requires Gate A).
        """
        builder_content = self._registers[Register.BUILDER].content
        delta = {k: builder_content[k] for k in keys if k in builder_content}
        return self.authorize_organism_write(delta)

    def update_external_projection(self, payload: Dict[str, Any]) -> bool:
        """
        Update Ω_E (Gate C bounded — safe projection only).
        Internal doctrine fields must never appear here.
        """
        forbidden_keys = {"doctrine", "sovereign", "core_a", "core_b", "gate_a"}
        safe = {k: v for k, v in payload.items() if k not in forbidden_keys}
        self._registers[Register.EXTERNAL] = self._registers[Register.EXTERNAL].bump(
            safe
        )
        return True

    def clear_write_halt(self) -> None:
        """Manually clear write-halt after operator resolution."""
        self._write_halted = False

    def to_json(self, indent: int = 2) -> str:
        return json.dumps(self.snapshot(), indent=indent)
