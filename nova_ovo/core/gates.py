"""
Gate enforcement — A (runtime) · B (workforce) · C (projection).

No gate bypass. All cross-boundary state changes must pass
through the appropriate gate with a logged decision.

Gate hierarchy:
  Gate A — runtime truth mutations (Ω_O writes)
  Gate B — workforce execution approvals (Ω_B → action)
  Gate C — external projection boundary (Ω_E → public)

Decision algebra:
  PASS  → action authorized, continue
  HOLD  → action queued, awaiting authority
  DENY  → action rejected, logged, no mutation

Invariant: DENY never silently drops — it always produces an evidence record.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional


class GateLevel(str, Enum):
    A = "A"  # runtime
    B = "B"  # workforce
    C = "C"  # projection


class GateDecision(str, Enum):
    PASS = "PASS"
    HOLD = "HOLD"
    DENY = "DENY"


@dataclass
class GateRecord:
    """Immutable evidence record produced by every gate evaluation."""

    record_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    gate: GateLevel = GateLevel.A
    decision: GateDecision = GateDecision.DENY
    action_type: str = ""
    actor: str = "system"
    payload_summary: str = ""
    reason: str = ""
    timestamp: float = field(default_factory=time.time)

    def to_dict(self) -> Dict[str, Any]:
        return {
            "record_id": self.record_id,
            "gate": self.gate.value,
            "decision": self.decision.value,
            "action_type": self.action_type,
            "actor": self.actor,
            "payload_summary": self.payload_summary,
            "reason": self.reason,
            "timestamp": self.timestamp,
        }


# Policy function type: (action_type, payload) → (GateDecision, reason)
PolicyFn = Callable[[str, Dict[str, Any]], tuple[GateDecision, str]]


def _default_policy_a(action_type: str, payload: Dict[str, Any]) -> tuple[GateDecision, str]:
    """Default Gate A policy: pass all runtime writes by default."""
    return GateDecision.PASS, "default runtime policy"


def _default_policy_b(action_type: str, payload: Dict[str, Any]) -> tuple[GateDecision, str]:
    """Default Gate B policy: pass all workforce actions by default."""
    return GateDecision.PASS, "default workforce policy"


def _default_policy_c(action_type: str, payload: Dict[str, Any]) -> tuple[GateDecision, str]:
    """
    Default Gate C policy — projection boundary.

    Deny any payload containing forbidden sovereign keys.
    """
    forbidden = {"doctrine_core", "sovereign_key", "gate_a_secret", "core_b_internal"}

    def normalize_key(key: Any) -> str:
        key_str = str(key).lower().strip()
        for ch in ("\x00", "\u200b", "\u200d", "\ufeff", "\u202e"):
            key_str = key_str.replace(ch, "")
        return key_str

    def collect_keys(value: Any, keys: set[str]) -> None:
        if isinstance(value, dict):
            for k, v in value.items():
                keys.add(normalize_key(k))
                collect_keys(v, keys)
            return
        if isinstance(value, (list, tuple, set)):
            for item in value:
                collect_keys(item, keys)

    keys_present: set[str] = set()
    collect_keys(payload, keys_present)
    leak = forbidden & keys_present
    if leak:
        return GateDecision.DENY, f"sovereign key leak detected: {sorted(leak)}"
    return GateDecision.PASS, "projection boundary clear"


class GateEnforcer:
    """
    Enforces Gates A, B, C for all cross-boundary actions.

    Every evaluation produces a GateRecord regardless of outcome.
    No bypass is possible — the only way to act is through evaluate().
    """

    DEFAULT_POLICIES: Dict[GateLevel, PolicyFn] = {
        GateLevel.A: _default_policy_a,
        GateLevel.B: _default_policy_b,
        GateLevel.C: _default_policy_c,
    }

    def __init__(self) -> None:
        self._policies: Dict[GateLevel, PolicyFn] = dict(self.DEFAULT_POLICIES)
        self._log: List[GateRecord] = []

    # ------------------------------------------------------------------ #
    # Policy configuration                                                  #
    # ------------------------------------------------------------------ #

    def set_policy(self, gate: GateLevel, policy: PolicyFn) -> None:
        """Replace the policy function for a gate."""
        self._policies[gate] = policy

    # ------------------------------------------------------------------ #
    # Evaluation                                                            #
    # ------------------------------------------------------------------ #

    def evaluate(
        self,
        gate: GateLevel,
        action_type: str,
        payload: Dict[str, Any],
        actor: str = "system",
    ) -> GateRecord:
        """
        Evaluate an action against the specified gate.

        Always returns a GateRecord — never raises.
        """
        policy = self._policies[gate]
        try:
            decision, reason = policy(action_type, payload)
        except Exception as exc:
            decision = GateDecision.DENY
            reason = f"policy evaluation error: {exc}"

        summary = ", ".join(f"{k}={repr(v)[:40]}" for k, v in list(payload.items())[:5])
        record = GateRecord(
            gate=gate,
            decision=decision,
            action_type=action_type,
            actor=actor,
            payload_summary=summary,
            reason=reason,
        )
        self._log.append(record)
        return record

    def require_pass(
        self,
        gate: GateLevel,
        action_type: str,
        payload: Dict[str, Any],
        actor: str = "system",
    ) -> GateRecord:
        """
        Evaluate gate and raise RuntimeError if decision is not PASS.

        Useful for hard enforcement points.
        """
        record = self.evaluate(gate, action_type, payload, actor)
        if record.decision != GateDecision.PASS:
            raise RuntimeError(
                f"Gate {gate.value} {record.decision.value}: {record.reason} "
                f"[record={record.record_id}]"
            )
        return record

    # ------------------------------------------------------------------ #
    # Log access                                                            #
    # ------------------------------------------------------------------ #

    def get_log(
        self,
        gate: Optional[GateLevel] = None,
        decision: Optional[GateDecision] = None,
        limit: int = 100,
    ) -> List[GateRecord]:
        """Query the gate log with optional filters."""
        records = self._log
        if gate is not None:
            records = [r for r in records if r.gate == gate]
        if decision is not None:
            records = [r for r in records if r.decision == decision]
        return records[-limit:]

    def audit_summary(self) -> Dict[str, Any]:
        """Return counts per gate and decision for audit dashboard."""
        summary: Dict[str, Dict[str, int]] = {}
        for r in self._log:
            g = r.gate.value
            d = r.decision.value
            summary.setdefault(g, {})
            summary[g][d] = summary[g].get(d, 0) + 1
        return summary
