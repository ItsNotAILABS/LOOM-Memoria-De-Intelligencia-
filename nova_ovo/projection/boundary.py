"""
Projection Boundary — Safe External Projection
==============================================
Gate C enforced for all external projections.
No sovereign internal exposure.

External outputs bounded to:
- Safe metrics
- Safe summaries
- Proof references
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Set, TYPE_CHECKING

if TYPE_CHECKING:
    from ..core.gates import GateEnforcer, GateLevel


class ProjectionType(str, Enum):
    """Types of external projections."""
    METRIC = "metric"
    SUMMARY = "summary"
    PROOF = "proof"
    STATUS = "status"
    REPORT = "report"


class ProjectionStatus(str, Enum):
    """Projection status."""
    PENDING = "pending"
    APPROVED = "approved"
    REJECTED = "rejected"
    EXPIRED = "expired"


# Forbidden keys that must never appear in projections
FORBIDDEN_KEYS: Set[str] = {
    "doctrine",
    "doctrine_core",
    "sovereign",
    "sovereign_key",
    "core_a",
    "core_b",
    "gate_a",
    "gate_a_secret",
    "core_b_internal",
    "internal_state",
    "private_key",
    "secret",
    "password",
    "token",
    "credential",
}


@dataclass
class SafeProjection:
    """
    A safe projection approved for external exposure.
    
    All projections must pass Gate C before exposure.
    """
    
    projection_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    projection_type: ProjectionType = ProjectionType.STATUS
    status: ProjectionStatus = ProjectionStatus.PENDING
    
    # Content
    content: Dict[str, Any] = field(default_factory=dict)
    
    # Sanitization
    original_keys: List[str] = field(default_factory=list)
    removed_keys: List[str] = field(default_factory=list)
    
    # Evidence
    gate_record_id: Optional[str] = None
    proof_references: List[str] = field(default_factory=list)
    
    # Metadata
    requestor: str = "system"
    target: str = "external"
    created_at: float = field(default_factory=time.time)
    approved_at: Optional[float] = None
    expires_at: Optional[float] = None
    
    def is_valid(self) -> bool:
        """Check if projection is valid for use."""
        if self.status != ProjectionStatus.APPROVED:
            return False
        if self.expires_at and time.time() > self.expires_at:
            return False
        return True
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "projection_id": self.projection_id,
            "projection_type": self.projection_type.value,
            "status": self.status.value,
            "content": self.content,
            "removed_keys": self.removed_keys,
            "gate_record_id": self.gate_record_id,
            "proof_references": self.proof_references,
            "requestor": self.requestor,
            "target": self.target,
            "created_at": self.created_at,
            "approved_at": self.approved_at,
            "expires_at": self.expires_at,
            "is_valid": self.is_valid(),
        }


class ProjectionBoundary:
    """
    Boundary enforcer for external projections.
    
    Ensures:
    - No sovereign internal exposure
    - Gate C enforcement
    - Bounded outputs only
    """
    
    def __init__(
        self,
        gate_enforcer: Optional["GateEnforcer"] = None,
        forbidden_keys: Optional[Set[str]] = None,
    ) -> None:
        self._gate_enforcer = gate_enforcer
        self._forbidden_keys = forbidden_keys or FORBIDDEN_KEYS
        self._projections: Dict[str, SafeProjection] = {}
        self._audit_log: List[Dict[str, Any]] = []
    
    def set_gate_enforcer(self, enforcer: "GateEnforcer") -> None:
        """Set the gate enforcer."""
        self._gate_enforcer = enforcer
    
    def add_forbidden_key(self, key: str) -> None:
        """Add a key to the forbidden list."""
        self._forbidden_keys.add(key.lower())
    
    def sanitize(self, data: Dict[str, Any]) -> tuple[Dict[str, Any], List[str]]:
        """
        Sanitize data for external projection.
        
        Returns (sanitized_data, removed_keys).
        """
        removed: List[str] = []
        sanitized: Dict[str, Any] = {}
        
        for key, value in data.items():
            key_lower = key.lower()
            
            # Check forbidden keys
            if key_lower in self._forbidden_keys:
                removed.append(key)
                continue
            
            # Check partial matches
            if any(fk in key_lower for fk in self._forbidden_keys):
                removed.append(key)
                continue
            
            # Recursively sanitize nested dicts
            if isinstance(value, dict):
                nested_sanitized, nested_removed = self.sanitize(value)
                if nested_sanitized:
                    sanitized[key] = nested_sanitized
                removed.extend(f"{key}.{r}" for r in nested_removed)
            else:
                sanitized[key] = value
        
        return sanitized, removed
    
    def project(
        self,
        data: Dict[str, Any],
        projection_type: ProjectionType,
        requestor: str = "system",
        target: str = "external",
        proof_references: Optional[List[str]] = None,
        ttl_seconds: Optional[int] = None,
    ) -> SafeProjection:
        """
        Create a safe projection from internal data.
        
        Enforces Gate C and sanitizes content.
        """
        # Sanitize content
        sanitized, removed = self.sanitize(data)
        
        # Create projection
        projection = SafeProjection(
            projection_type=projection_type,
            content=sanitized,
            original_keys=list(data.keys()),
            removed_keys=removed,
            requestor=requestor,
            target=target,
            proof_references=proof_references or [],
        )
        
        if ttl_seconds:
            projection.expires_at = time.time() + ttl_seconds
        
        # Check Gate C
        if self._gate_enforcer:
            from ..core.gates import GateLevel
            record = self._gate_enforcer.evaluate(
                GateLevel.C,
                f"project_{projection_type.value}",
                sanitized,
                requestor,
            )
            projection.gate_record_id = record.record_id
            
            if record.decision.value == "PASS":
                projection.status = ProjectionStatus.APPROVED
                projection.approved_at = time.time()
            else:
                projection.status = ProjectionStatus.REJECTED
                self._audit_log.append({
                    "event": "projection_rejected",
                    "projection_id": projection.projection_id,
                    "reason": record.reason,
                    "timestamp": time.time(),
                })
        else:
            # No gate enforcer, auto-approve if sanitized
            if not removed or len(removed) < len(data):
                projection.status = ProjectionStatus.APPROVED
                projection.approved_at = time.time()
        
        self._projections[projection.projection_id] = projection
        
        self._audit_log.append({
            "event": "projection_created",
            "projection_id": projection.projection_id,
            "status": projection.status.value,
            "removed_count": len(removed),
            "timestamp": time.time(),
        })
        
        return projection
    
    def project_metric(
        self,
        name: str,
        value: Any,
        labels: Optional[Dict[str, str]] = None,
        requestor: str = "system",
    ) -> SafeProjection:
        """Create a safe metric projection."""
        data = {
            "metric_name": name,
            "value": value,
            "labels": labels or {},
            "timestamp": time.time(),
        }
        return self.project(data, ProjectionType.METRIC, requestor)
    
    def project_summary(
        self,
        title: str,
        summary: str,
        details: Optional[Dict[str, Any]] = None,
        requestor: str = "system",
    ) -> SafeProjection:
        """Create a safe summary projection."""
        data = {
            "title": title,
            "summary": summary,
            "details": details or {},
            "generated_at": time.time(),
        }
        return self.project(data, ProjectionType.SUMMARY, requestor)
    
    def project_proof(
        self,
        claim: str,
        evidence_refs: List[str],
        attestations: Optional[List[str]] = None,
        requestor: str = "system",
    ) -> SafeProjection:
        """Create a safe proof projection."""
        data = {
            "claim": claim,
            "evidence_references": evidence_refs,
            "attestations": attestations or [],
            "generated_at": time.time(),
        }
        return self.project(
            data,
            ProjectionType.PROOF,
            requestor,
            proof_references=evidence_refs,
        )
    
    def get_projection(self, projection_id: str) -> Optional[SafeProjection]:
        """Get a projection by ID."""
        return self._projections.get(projection_id)
    
    def get_valid_projections(
        self,
        projection_type: Optional[ProjectionType] = None,
    ) -> List[SafeProjection]:
        """Get all valid (approved and not expired) projections."""
        projections = [p for p in self._projections.values() if p.is_valid()]
        
        if projection_type:
            projections = [p for p in projections if p.projection_type == projection_type]
        
        return projections
    
    def get_audit_log(self, limit: int = 100) -> List[Dict[str, Any]]:
        """Get audit log."""
        return self._audit_log[-limit:]
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get projection statistics."""
        projections = list(self._projections.values())
        
        by_type: Dict[str, int] = {}
        by_status: Dict[str, int] = {}
        total_removed_keys = 0
        
        for p in projections:
            by_type[p.projection_type.value] = by_type.get(p.projection_type.value, 0) + 1
            by_status[p.status.value] = by_status.get(p.status.value, 0) + 1
            total_removed_keys += len(p.removed_keys)
        
        return {
            "total_projections": len(projections),
            "valid_projections": len(self.get_valid_projections()),
            "by_type": by_type,
            "by_status": by_status,
            "total_removed_keys": total_removed_keys,
            "forbidden_keys_count": len(self._forbidden_keys),
        }
