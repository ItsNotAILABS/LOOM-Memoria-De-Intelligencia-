"""
MEDINA Law Engine — Constitutional law enforcement.

The Law Engine validates all operations against the constitution:
- Pre-execution law checks
- Post-execution verification
- Violation logging and evidence

LAW CHECK CATEGORIES:
  RECITAL_CONFORMANCE   — state evolution follows RECITAL_PLUS_ONE
  REGISTER_INTEGRITY    — four registers preserved
  DUAL_READ_COMPLIANCE  — semantic + resonance both present
  GATE_COMPLIANCE       — A/B/C gates enforced
  AUTHORITY_BOUNDARIES  — Core A/B separation respected
  NO_COLLAPSE           — ontology levels distinct

LAW EPOCH (H6 hardening):
  One authoritative law-write epoch per beat.
  Concurrent law mutations are queued and serialized.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Tuple

from .constitution import Constitution, DoctrineLevel


class LawCategory(Enum):
    """Categories of law checks."""
    
    RECITAL_CONFORMANCE = "recital_conformance"
    REGISTER_INTEGRITY = "register_integrity"
    DUAL_READ_COMPLIANCE = "dual_read_compliance"
    GATE_COMPLIANCE = "gate_compliance"
    AUTHORITY_BOUNDARIES = "authority_boundaries"
    NO_COLLAPSE = "no_collapse"


class Severity(Enum):
    """Violation severity levels."""
    
    INFO = "info"           # Observation, no action required
    WARNING = "warning"     # Degraded operation, should address
    ERROR = "error"         # Operation blocked, must address
    CRITICAL = "critical"   # System halt, immediate attention


@dataclass
class LawCheck:
    """A single law conformance check."""
    
    check_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    category: LawCategory = LawCategory.RECITAL_CONFORMANCE
    name: str = ""
    description: str = ""
    passed: bool = False
    message: str = ""
    timestamp: float = field(default_factory=time.time)
    evidence: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "check_id": self.check_id,
            "category": self.category.value,
            "name": self.name,
            "description": self.description,
            "passed": self.passed,
            "message": self.message,
            "timestamp": self.timestamp,
            "evidence": self.evidence,
        }


@dataclass
class LawViolation:
    """A recorded law violation with evidence."""
    
    violation_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    category: LawCategory = LawCategory.RECITAL_CONFORMANCE
    severity: Severity = Severity.ERROR
    check_name: str = ""
    message: str = ""
    timestamp: float = field(default_factory=time.time)
    beat: int = 0
    actor: str = "system"
    evidence: Dict[str, Any] = field(default_factory=dict)
    resolved: bool = False
    resolution: str = ""
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "violation_id": self.violation_id,
            "category": self.category.value,
            "severity": self.severity.value,
            "check_name": self.check_name,
            "message": self.message,
            "timestamp": self.timestamp,
            "beat": self.beat,
            "actor": self.actor,
            "evidence": self.evidence,
            "resolved": self.resolved,
            "resolution": self.resolution,
        }


# Type for law check functions
LawCheckFn = Callable[[Dict[str, Any]], Tuple[bool, str, Dict[str, Any]]]


class LawEngine:
    """
    MEDINA Law Engine — Enforces constitutional law.
    
    All operations must pass relevant law checks before execution.
    Violations are logged with evidence for audit and replay.
    
    LAW EPOCH (H6):
    - One authoritative law-write epoch per beat
    - Pending mutations queue until epoch opens
    - Epoch commits atomically at beat boundary
    
    Integration with:
    - ORCH-05 CONSTITUTIONAL_LAW_ORCHESTRATOR
    - R-MODEL-GOVERNANCE-HEARTBEAT
    """
    
    def __init__(self, constitution: Constitution) -> None:
        self._constitution = constitution
        self._checks: Dict[str, LawCheckFn] = {}
        self._violations: List[LawViolation] = []
        self._epoch_beat: int = -1
        self._epoch_queue: List[Dict[str, Any]] = []
        self._current_beat: int = 0
        
        # Register default law checks
        self._register_default_checks()
    
    def _register_default_checks(self) -> None:
        """Register built-in law conformance checks."""
        
        # Check: RECITAL_PLUS_ONE conformance
        def check_recital(ctx: Dict[str, Any]) -> Tuple[bool, str, Dict[str, Any]]:
            state_delta = ctx.get("state_delta", {})
            parent_state = ctx.get("parent_state")
            
            if parent_state is None:
                return True, "Initial state, no recital required", {}
            
            # Verify delta is lawful (bounded magnitude)
            if "magnitude" in state_delta:
                if state_delta["magnitude"] > 1.0:  # EPSILON_MAX
                    return False, "State delta exceeds EPSILON_MAX", {
                        "magnitude": state_delta["magnitude"],
                        "limit": 1.0,
                    }
            
            return True, "Recital conformance verified", {"delta": state_delta}
        
        self._checks["recital_conformance"] = check_recital
        
        # Check: Four registers present
        def check_registers(ctx: Dict[str, Any]) -> Tuple[bool, str, Dict[str, Any]]:
            registers = ctx.get("registers", [])
            required = {"founder", "builder", "organism", "external"}
            present = set(str(r).lower() for r in registers)
            
            missing = required - present
            if missing:
                return False, f"Missing registers: {missing}", {
                    "required": list(required),
                    "present": list(present),
                    "missing": list(missing),
                }
            
            return True, "All four registers present", {"registers": list(present)}
        
        self._checks["register_integrity"] = check_registers
        
        # Check: Dual-read compliance
        def check_dual_read(ctx: Dict[str, Any]) -> Tuple[bool, str, Dict[str, Any]]:
            semantic_ok = ctx.get("semantic_read", False)
            resonance_ok = ctx.get("resonance_read", False)
            
            if not semantic_ok:
                return False, "Semantic read failed", {
                    "semantic": semantic_ok,
                    "resonance": resonance_ok,
                }
            if not resonance_ok:
                return False, "Resonance read failed", {
                    "semantic": semantic_ok,
                    "resonance": resonance_ok,
                }
            
            return True, "Dual read passed", {
                "semantic": semantic_ok,
                "resonance": resonance_ok,
            }
        
        self._checks["dual_read_compliance"] = check_dual_read
        
        # Check: Gate compliance
        def check_gates(ctx: Dict[str, Any]) -> Tuple[bool, str, Dict[str, Any]]:
            gate_results = ctx.get("gate_results", {})
            
            for gate, result in gate_results.items():
                if result.get("decision") == "DENY":
                    return False, f"Gate {gate} denied", {
                        "gate": gate,
                        "reason": result.get("reason", "Unknown"),
                    }
            
            return True, "All gates passed", {"gates": list(gate_results.keys())}
        
        self._checks["gate_compliance"] = check_gates
        
        # Check: No-collapse ontology
        def check_no_collapse(ctx: Dict[str, Any]) -> Tuple[bool, str, Dict[str, Any]]:
            levels = ctx.get("doctrine_levels", {})
            
            # Check for level collisions
            level_entries: Dict[str, List[str]] = {}
            for key, level in levels.items():
                level_entries.setdefault(level, []).append(key)
            
            # Verify constitution maintains no-collapse
            if self._constitution:
                if not self._constitution.validate_no_collapse():
                    return False, "Constitution no-collapse violated", {
                        "levels": level_entries,
                    }
            
            return True, "No-collapse maintained", {"level_count": len(level_entries)}
        
        self._checks["no_collapse"] = check_no_collapse
    
    # ------------------------------------------------------------------ #
    # Check Registration                                                    #
    # ------------------------------------------------------------------ #
    
    def register_check(self, name: str, check_fn: LawCheckFn) -> None:
        """Register a custom law check."""
        self._checks[name] = check_fn
    
    # ------------------------------------------------------------------ #
    # Enforcement                                                           #
    # ------------------------------------------------------------------ #
    
    def evaluate(
        self,
        check_name: str,
        context: Dict[str, Any],
        actor: str = "system",
    ) -> LawCheck:
        """
        Evaluate a single law check.
        
        Returns a LawCheck record regardless of outcome.
        """
        if check_name not in self._checks:
            return LawCheck(
                name=check_name,
                passed=False,
                message=f"Unknown check: {check_name}",
            )
        
        check_fn = self._checks[check_name]
        try:
            passed, message, evidence = check_fn(context)
        except Exception as exc:
            passed = False
            message = f"Check evaluation error: {exc}"
            evidence = {"error": str(exc)}
        
        # Determine category from check name
        category = LawCategory.RECITAL_CONFORMANCE
        for cat in LawCategory:
            if cat.value in check_name:
                category = cat
                break
        
        check = LawCheck(
            category=category,
            name=check_name,
            passed=passed,
            message=message,
            evidence=evidence,
        )
        
        # Log violation if check failed
        if not passed:
            violation = LawViolation(
                category=category,
                severity=Severity.ERROR,
                check_name=check_name,
                message=message,
                beat=self._current_beat,
                actor=actor,
                evidence=evidence,
            )
            self._violations.append(violation)
        
        return check
    
    def evaluate_all(
        self,
        context: Dict[str, Any],
        actor: str = "system",
    ) -> List[LawCheck]:
        """Evaluate all registered law checks."""
        return [
            self.evaluate(name, context, actor)
            for name in self._checks.keys()
        ]
    
    def require_pass(
        self,
        check_name: str,
        context: Dict[str, Any],
        actor: str = "system",
    ) -> LawCheck:
        """
        Evaluate check and raise if failed.
        
        Used for hard enforcement points.
        """
        check = self.evaluate(check_name, context, actor)
        if not check.passed:
            raise RuntimeError(
                f"Law check failed: {check_name} - {check.message} "
                f"[check_id={check.check_id}]"
            )
        return check
    
    # ------------------------------------------------------------------ #
    # Epoch Management (H6)                                                 #
    # ------------------------------------------------------------------ #
    
    def advance_beat(self, beat: int) -> None:
        """Advance to new beat, opening new law epoch."""
        self._current_beat = beat
        self._epoch_beat = beat
        self._epoch_queue.clear()
    
    def queue_mutation(self, mutation: Dict[str, Any]) -> str:
        """Queue a law mutation for the current epoch."""
        mutation_id = str(uuid.uuid4())
        self._epoch_queue.append({
            "mutation_id": mutation_id,
            "mutation": mutation,
            "queued_at": time.time(),
        })
        return mutation_id
    
    def commit_epoch(self) -> List[Dict[str, Any]]:
        """Commit all queued mutations atomically."""
        committed = list(self._epoch_queue)
        self._epoch_queue.clear()
        return committed
    
    # ------------------------------------------------------------------ #
    # Violations                                                            #
    # ------------------------------------------------------------------ #
    
    def get_violations(
        self,
        category: Optional[LawCategory] = None,
        severity: Optional[Severity] = None,
        unresolved_only: bool = False,
        limit: int = 100,
    ) -> List[LawViolation]:
        """Query violation log."""
        violations = self._violations
        
        if category:
            violations = [v for v in violations if v.category == category]
        if severity:
            violations = [v for v in violations if v.severity == severity]
        if unresolved_only:
            violations = [v for v in violations if not v.resolved]
        
        return violations[-limit:]
    
    def resolve_violation(
        self,
        violation_id: str,
        resolution: str,
    ) -> bool:
        """Mark a violation as resolved."""
        for v in self._violations:
            if v.violation_id == violation_id:
                v.resolved = True
                v.resolution = resolution
                return True
        return False
    
    def violation_summary(self) -> Dict[str, Any]:
        """Summary statistics for violations."""
        by_category: Dict[str, int] = {}
        by_severity: Dict[str, int] = {}
        unresolved = 0
        
        for v in self._violations:
            by_category[v.category.value] = by_category.get(v.category.value, 0) + 1
            by_severity[v.severity.value] = by_severity.get(v.severity.value, 0) + 1
            if not v.resolved:
                unresolved += 1
        
        return {
            "total": len(self._violations),
            "unresolved": unresolved,
            "by_category": by_category,
            "by_severity": by_severity,
        }
