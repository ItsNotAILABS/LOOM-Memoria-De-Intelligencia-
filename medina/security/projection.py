"""
MEDINA Projection Safety — Safe external boundaries.

PROJECTION PRINCIPLES:
- Internal sovereign truth never directly exposed
- External outputs are bounded projections
- Every projection has evidence
- Proof references, not raw data

SAFE OUTPUTS:
- Safe metrics (aggregated, anonymized)
- Safe summaries (filtered, bounded)
- Proof references (not sovereign data)
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Set


class ProjectionLevel(Enum):
    """Levels of projection exposure."""
    
    INTERNAL = "internal"       # Sovereign, never exposed
    RESTRICTED = "restricted"   # Limited internal sharing
    BOUNDED = "bounded"         # Safe external projection
    PUBLIC = "public"           # Open information


class BoundaryViolationType(Enum):
    """Types of projection boundary violations."""
    
    SOVEREIGN_KEY = "sovereign_key"           # Sovereign data exposure
    EXCESS_DETAIL = "excess_detail"           # Too much internal detail
    UNBOUNDED_QUERY = "unbounded_query"       # Unconstrained data access
    MISSING_EVIDENCE = "missing_evidence"     # No proof chain
    UNAUTHORIZED_SCOPE = "unauthorized_scope" # Beyond allowed scope


@dataclass
class ProjectionBoundary:
    """Definition of a projection boundary."""
    
    boundary_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    level: ProjectionLevel = ProjectionLevel.BOUNDED
    
    # Filtering rules
    allowed_fields: List[str] = field(default_factory=list)
    forbidden_fields: List[str] = field(default_factory=list)
    max_items: int = 100
    
    # Aggregation requirements
    require_aggregation: bool = False
    min_group_size: int = 1  # For anonymization
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "boundary_id": self.boundary_id,
            "name": self.name,
            "level": self.level.value,
            "allowed_fields": self.allowed_fields,
            "forbidden_fields": self.forbidden_fields,
            "max_items": self.max_items,
            "require_aggregation": self.require_aggregation,
        }


@dataclass
class SafeProjection:
    """A safe, bounded projection of internal data."""
    
    projection_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    boundary: ProjectionBoundary = field(default_factory=ProjectionBoundary)
    
    # Content
    data: Any = None
    summary: str = ""
    
    # Evidence
    source_ref: str = ""  # Reference to source (not actual data)
    evidence_chain: List[str] = field(default_factory=list)
    
    # Metadata
    created_at: float = field(default_factory=time.time)
    expires_at: Optional[float] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "projection_id": self.projection_id,
            "boundary": self.boundary.name,
            "level": self.boundary.level.value,
            "summary": self.summary,
            "source_ref": self.source_ref,
            "evidence_chain": self.evidence_chain,
            "created_at": self.created_at,
            "expires_at": self.expires_at,
            # Note: data is intentionally not in dict export for safety
        }


@dataclass
class BoundaryViolation:
    """Record of a projection boundary violation."""
    
    violation_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    violation_type: BoundaryViolationType = BoundaryViolationType.SOVEREIGN_KEY
    boundary_name: str = ""
    attempted_action: str = ""
    blocked_fields: List[str] = field(default_factory=list)
    actor: str = "system"
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "violation_id": self.violation_id,
            "violation_type": self.violation_type.value,
            "boundary_name": self.boundary_name,
            "attempted_action": self.attempted_action,
            "blocked_fields": self.blocked_fields,
            "actor": self.actor,
            "timestamp": self.timestamp,
        }


class ProjectionSafetyEngine:
    """
    MEDINA Projection Safety Engine — Safe external boundaries.
    
    Ensures:
    - Internal sovereign truth is never directly exposed
    - External outputs are bounded projections
    - All projections have evidence chains
    - Violations are logged and blocked
    
    Integration with Gate C (projection safety gate).
    """
    
    # Default forbidden keys (sovereign data)
    DEFAULT_FORBIDDEN = {
        "sovereign_key",
        "doctrine_core",
        "core_a_secret",
        "core_b_internal",
        "gate_a_internal",
        "private_key",
        "secret",
        "password",
        "credential",
        "auth_token",
        "internal_state",
    }
    
    def __init__(self) -> None:
        self._boundaries: Dict[str, ProjectionBoundary] = {}
        self._projections: Dict[str, SafeProjection] = {}
        self._violations: List[BoundaryViolation] = []
        self._forbidden_keys: Set[str] = set(self.DEFAULT_FORBIDDEN)
        
        # Initialize default boundaries
        self._initialize_default_boundaries()
    
    def _initialize_default_boundaries(self) -> None:
        """Create default projection boundaries."""
        # Public metrics boundary
        public_metrics = ProjectionBoundary(
            name="public_metrics",
            level=ProjectionLevel.PUBLIC,
            allowed_fields=["count", "total", "average", "timestamp"],
            require_aggregation=True,
            min_group_size=5,
        )
        self._boundaries[public_metrics.name] = public_metrics
        
        # Bounded summary boundary
        bounded_summary = ProjectionBoundary(
            name="bounded_summary",
            level=ProjectionLevel.BOUNDED,
            allowed_fields=["summary", "status", "progress", "timestamp"],
            max_items=10,
        )
        self._boundaries[bounded_summary.name] = bounded_summary
        
        # Internal boundary (restricted sharing)
        internal = ProjectionBoundary(
            name="internal",
            level=ProjectionLevel.RESTRICTED,
            forbidden_fields=list(self.DEFAULT_FORBIDDEN),
        )
        self._boundaries[internal.name] = internal
    
    # ------------------------------------------------------------------ #
    # Boundary Management                                                   #
    # ------------------------------------------------------------------ #
    
    def add_boundary(self, boundary: ProjectionBoundary) -> None:
        """Add a projection boundary."""
        self._boundaries[boundary.name] = boundary
    
    def get_boundary(self, name: str) -> Optional[ProjectionBoundary]:
        """Get a boundary by name."""
        return self._boundaries.get(name)
    
    def add_forbidden_key(self, key: str) -> None:
        """Add a key to the global forbidden list."""
        self._forbidden_keys.add(key.lower())
    
    # ------------------------------------------------------------------ #
    # Projection Creation                                                   #
    # ------------------------------------------------------------------ #
    
    def create_projection(
        self,
        data: Any,
        boundary_name: str,
        summary: str = "",
        source_ref: str = "",
        evidence_chain: Optional[List[str]] = None,
        actor: str = "system",
    ) -> Optional[SafeProjection]:
        """
        Create a safe projection of data.
        
        Applies boundary rules and blocks violations.
        """
        boundary = self._boundaries.get(boundary_name)
        if not boundary:
            return None
        
        # Validate and filter data
        filtered_data, violations = self._apply_boundary(data, boundary, actor)
        
        if violations:
            # Block projection if violations occurred
            return None
        
        # Create projection
        projection = SafeProjection(
            boundary=boundary,
            data=filtered_data,
            summary=summary,
            source_ref=source_ref,
            evidence_chain=evidence_chain or [],
        )
        
        self._projections[projection.projection_id] = projection
        return projection
    
    def _apply_boundary(
        self,
        data: Any,
        boundary: ProjectionBoundary,
        actor: str,
    ) -> tuple[Any, List[BoundaryViolation]]:
        """Apply boundary rules to data."""
        violations: List[BoundaryViolation] = []
        
        if isinstance(data, dict):
            return self._filter_dict(data, boundary, actor, violations)
        elif isinstance(data, list):
            # Apply max_items limit
            if len(data) > boundary.max_items:
                data = data[:boundary.max_items]
            # Filter each item
            filtered = []
            for item in data:
                if isinstance(item, dict):
                    filtered_item, _ = self._filter_dict(item, boundary, actor, violations)
                    filtered.append(filtered_item)
                else:
                    filtered.append(item)
            return filtered, violations
        else:
            return data, violations
    
    def _filter_dict(
        self,
        data: Dict[str, Any],
        boundary: ProjectionBoundary,
        actor: str,
        violations: List[BoundaryViolation],
    ) -> tuple[Dict[str, Any], List[BoundaryViolation]]:
        """Filter a dictionary according to boundary rules."""
        filtered: Dict[str, Any] = {}
        blocked_fields: List[str] = []
        
        for key, value in data.items():
            key_lower = key.lower()
            
            # Check global forbidden
            if key_lower in self._forbidden_keys:
                blocked_fields.append(key)
                continue
            
            # Check boundary forbidden
            if key in boundary.forbidden_fields or key_lower in [f.lower() for f in boundary.forbidden_fields]:
                blocked_fields.append(key)
                continue
            
            # Check allowed (if specified)
            if boundary.allowed_fields:
                if key not in boundary.allowed_fields and key_lower not in [f.lower() for f in boundary.allowed_fields]:
                    blocked_fields.append(key)
                    continue
            
            # Recursively filter nested dicts
            if isinstance(value, dict):
                value, _ = self._filter_dict(value, boundary, actor, violations)
            
            filtered[key] = value
        
        # Record violation if fields were blocked
        if blocked_fields:
            violation = BoundaryViolation(
                violation_type=BoundaryViolationType.SOVEREIGN_KEY,
                boundary_name=boundary.name,
                attempted_action="projection_create",
                blocked_fields=blocked_fields,
                actor=actor,
            )
            violations.append(violation)
            self._violations.append(violation)
        
        return filtered, violations
    
    # ------------------------------------------------------------------ #
    # Safe Metrics                                                          #
    # ------------------------------------------------------------------ #
    
    def create_safe_metrics(
        self,
        values: List[float],
        source_ref: str = "",
    ) -> Optional[SafeProjection]:
        """
        Create safe aggregated metrics.
        
        Returns count, sum, average — not individual values.
        """
        boundary = self._boundaries.get("public_metrics")
        if not boundary:
            return None
        
        # Check minimum group size for anonymization
        if len(values) < boundary.min_group_size:
            return None
        
        metrics = {
            "count": len(values),
            "total": sum(values),
            "average": sum(values) / len(values) if values else 0,
            "timestamp": time.time(),
        }
        
        return self.create_projection(
            data=metrics,
            boundary_name="public_metrics",
            summary=f"Aggregated metrics (n={len(values)})",
            source_ref=source_ref,
        )
    
    def create_safe_summary(
        self,
        content: str,
        max_length: int = 200,
        source_ref: str = "",
    ) -> Optional[SafeProjection]:
        """Create a safe summary projection."""
        # Truncate if needed
        if len(content) > max_length:
            content = content[:max_length] + "..."
        
        return self.create_projection(
            data={"summary": content, "timestamp": time.time()},
            boundary_name="bounded_summary",
            summary=content[:50] + "..." if len(content) > 50 else content,
            source_ref=source_ref,
        )
    
    # ------------------------------------------------------------------ #
    # Queries                                                               #
    # ------------------------------------------------------------------ #
    
    def get_projection(self, projection_id: str) -> Optional[SafeProjection]:
        """Get a projection by ID."""
        return self._projections.get(projection_id)
    
    def list_projections(
        self,
        boundary_name: Optional[str] = None,
        limit: int = 100,
    ) -> List[SafeProjection]:
        """List projections with optional filter."""
        projections = list(self._projections.values())
        
        if boundary_name:
            projections = [p for p in projections if p.boundary.name == boundary_name]
        
        return projections[-limit:]
    
    def get_violations(
        self,
        violation_type: Optional[BoundaryViolationType] = None,
        limit: int = 100,
    ) -> List[BoundaryViolation]:
        """Get boundary violations."""
        violations = self._violations
        
        if violation_type:
            violations = [v for v in violations if v.violation_type == violation_type]
        
        return violations[-limit:]
    
    # ------------------------------------------------------------------ #
    # Status                                                                #
    # ------------------------------------------------------------------ #
    
    def status(self) -> Dict[str, Any]:
        """Projection safety system status."""
        return {
            "boundaries": len(self._boundaries),
            "projections": len(self._projections),
            "violations": len(self._violations),
            "forbidden_keys": len(self._forbidden_keys),
        }
