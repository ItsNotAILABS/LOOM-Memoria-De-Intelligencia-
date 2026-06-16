"""
🛡️ Projection Engine — Gate C Safety Layer
=============================================

MEDINA Sovereign Architecture
Author: Freddy (Founder Architect)

The projection engine ensures that ONLY safe, projected
state is visible to external AI systems.

Gate C Principles:
1. No sovereign internals (Core A truth) exposed
2. No doctrine keys revealed
3. All data sanitized before projection
4. Complete audit trail of what was projected

The organism maintains Ω_E (External register) —
this is what external AIs see. They NEVER see Ω_F, Ω_B, or Ω_O.
"""

from __future__ import annotations

import math
import re
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Set, Tuple

# =================================================================== #
# MATHEMATICAL CONSTANTS — DERIVED FROM PRINCIPLES                      #
# =================================================================== #

PHI = (1 + math.sqrt(5)) / 2  # Golden Ratio φ
EPSILON = PHI ** -10  # Minimum non-zero value


class ProjectionLevel(str, Enum):
    """Levels of projection allowed."""
    FULL = "full"           # All safe data projected
    PARTIAL = "partial"     # Only requested fields
    MINIMAL = "minimal"     # Absolute minimum
    NONE = "none"           # Blocked


class SensitivityLevel(str, Enum):
    """Data sensitivity classification."""
    PUBLIC = "public"       # Safe for projection
    INTERNAL = "internal"   # Organization only
    SOVEREIGN = "sovereign" # Core A only
    FORBIDDEN = "forbidden" # Never project


@dataclass
class SafetyFilter:
    """
    Configurable safety filter for projection.
    
    Defines what can and cannot be projected to external systems.
    """
    
    filter_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = "default"
    
    # Forbidden patterns (never project)
    forbidden_keys: Set[str] = field(default_factory=lambda: {
        # Sovereign keys
        "doctrine_core",
        "sovereign_key",
        "gate_a_secret",
        "core_a_truth",
        "omega_f",
        "omega_o",
        "founder_register",
        "organism_register",
        
        # Security keys
        "api_key",
        "secret_key",
        "private_key",
        "password",
        "token",
        "credential",
        
        # Internal state
        "internal_state",
        "core_b_internal",
        "heartbeat_secret",
        "resonance_core",
    })
    
    # Forbidden patterns (regex)
    forbidden_patterns: List[str] = field(default_factory=lambda: [
        r"_secret$",
        r"_key$",
        r"_token$",
        r"_credential$",
        r"^omega_[fbo]",
        r"^core_a_",
        r"^sovereign_",
        r"^doctrine_",
    ])
    
    # Maximum recursion depth for nested objects
    max_depth: int = 5
    
    # Maximum string length to project
    max_string_length: int = 10000
    
    # Maximum array length to project
    max_array_length: int = 1000
    
    def is_key_forbidden(self, key: str) -> bool:
        """Check if a key is forbidden from projection."""
        key_lower = key.lower()
        
        # Check exact matches
        if key_lower in self.forbidden_keys:
            return True
        
        # Check patterns
        for pattern in self.forbidden_patterns:
            if re.search(pattern, key_lower):
                return True
        
        return False
    
    def sanitize_value(self, value: Any, depth: int = 0) -> Tuple[Any, bool]:
        """
        Sanitize a value for projection.
        
        Returns (sanitized_value, was_modified).
        """
        if depth > self.max_depth:
            return "[MAX_DEPTH_EXCEEDED]", True
        
        if value is None:
            return None, False
        
        if isinstance(value, (bool, int, float)):
            return value, False
        
        if isinstance(value, str):
            if len(value) > self.max_string_length:
                return value[:self.max_string_length] + "...[TRUNCATED]", True
            return value, False
        
        if isinstance(value, (list, tuple)):
            if len(value) > self.max_array_length:
                # Return truncated array with count indicator (preserves type compatibility)
                truncated = list(value[:self.max_array_length])
                # Note: Array truncated from {len(value)} to {self.max_array_length} items
                return truncated, True
            result = []
            modified = False
            for item in value:
                sanitized, was_modified = self.sanitize_value(item, depth + 1)
                result.append(sanitized)
                if was_modified:
                    modified = True
            return result, modified
        
        if isinstance(value, dict):
            result = {}
            modified = False
            for k, v in value.items():
                if self.is_key_forbidden(str(k)):
                    result[k] = "[REDACTED]"
                    modified = True
                else:
                    sanitized, was_modified = self.sanitize_value(v, depth + 1)
                    result[k] = sanitized
                    if was_modified:
                        modified = True
            return result, modified
        
        # Unknown types: convert to string
        return str(value), True
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "filter_id": self.filter_id,
            "name": self.name,
            "forbidden_keys_count": len(self.forbidden_keys),
            "forbidden_patterns_count": len(self.forbidden_patterns),
            "max_depth": self.max_depth,
            "max_string_length": self.max_string_length,
            "max_array_length": self.max_array_length,
        }


@dataclass
class ProjectedState:
    """
    A safely projected view of organism state.
    
    This is what external AIs see — the Ω_E register.
    """
    
    projection_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    
    # Source identification (not sovereign details)
    source_organism: str = "medina"
    beat: int = 0
    timestamp: float = field(default_factory=time.time)
    
    # Projected data
    data: Dict[str, Any] = field(default_factory=dict)
    
    # Projection metadata
    level: ProjectionLevel = ProjectionLevel.PARTIAL
    filter_applied: str = "default"
    fields_redacted: int = 0
    depth_limited: bool = False
    
    # Lineage (for tracking)
    lineage: List[str] = field(default_factory=list)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "projection_id": self.projection_id,
            "source_organism": self.source_organism,
            "beat": self.beat,
            "timestamp": self.timestamp,
            "data": self.data,
            "level": self.level.value,
            "filter_applied": self.filter_applied,
            "fields_redacted": self.fields_redacted,
            "depth_limited": self.depth_limited,
            "lineage": self.lineage,
        }


@dataclass
class ProjectionAuditRecord:
    """Audit record for a projection operation."""
    
    record_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    projection_id: str = ""
    
    # What was requested
    requested_fields: List[str] = field(default_factory=list)
    
    # What was projected
    projected_fields: List[str] = field(default_factory=list)
    
    # What was blocked
    blocked_fields: List[str] = field(default_factory=list)
    blocked_reasons: Dict[str, str] = field(default_factory=dict)
    
    # Metadata
    requester: str = "external"
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "record_id": self.record_id,
            "projection_id": self.projection_id,
            "requested_fields": self.requested_fields,
            "projected_fields": self.projected_fields,
            "blocked_fields": self.blocked_fields,
            "blocked_reasons": self.blocked_reasons,
            "requester": self.requester,
            "timestamp": self.timestamp,
        }


class ProjectionEngine:
    """
    The Gate C projection engine.
    
    Transforms sovereign state into safe external projection.
    
    Projection Formula (φ-scaled):
        Ω_E = π_C(Ω_O) × φ^-1
    
    Where π_C is the Gate C projection function that:
    1. Filters forbidden keys
    2. Sanitizes sensitive values
    3. Bounds depth and size
    4. Records audit trail
    """
    
    def __init__(self, filter: Optional[SafetyFilter] = None) -> None:
        self.filter = filter or SafetyFilter()
        self._audit_log: List[ProjectionAuditRecord] = []
    
    def project(
        self,
        state: Dict[str, Any],
        requested_fields: Optional[List[str]] = None,
        level: ProjectionLevel = ProjectionLevel.PARTIAL,
        requester: str = "external",
        beat: int = 0,
        lineage: Optional[List[str]] = None,
    ) -> ProjectedState:
        """
        Project organism state through Gate C.
        
        Returns a safe ProjectedState visible to external AIs.
        """
        # Create audit record
        audit = ProjectionAuditRecord(
            requested_fields=requested_fields or list(state.keys()),
            requester=requester,
        )
        
        # Handle projection level
        if level == ProjectionLevel.NONE:
            projected = ProjectedState(
                beat=beat,
                level=ProjectionLevel.NONE,
                filter_applied=self.filter.name,
                lineage=lineage or [],
            )
            audit.projection_id = projected.projection_id
            self._audit_log.append(audit)
            return projected
        
        # Filter and sanitize state
        projected_data = {}
        fields_redacted = 0
        depth_limited = False
        
        # Determine which fields to process
        if requested_fields:
            keys_to_process = [k for k in requested_fields if k in state]
        else:
            keys_to_process = list(state.keys())
        
        for key in keys_to_process:
            # Check if key is forbidden
            if self.filter.is_key_forbidden(key):
                audit.blocked_fields.append(key)
                audit.blocked_reasons[key] = "forbidden_key"
                fields_redacted += 1
                continue
            
            # Get value from state
            value = state.get(key)
            
            # Sanitize value
            sanitized, was_modified = self.filter.sanitize_value(value)
            
            if was_modified and isinstance(sanitized, str) and "MAX_DEPTH" in sanitized:
                depth_limited = True
            
            projected_data[key] = sanitized
            audit.projected_fields.append(key)
            
            if was_modified:
                fields_redacted += 1
        
        # Create projected state
        projected = ProjectedState(
            beat=beat,
            data=projected_data,
            level=level,
            filter_applied=self.filter.name,
            fields_redacted=fields_redacted,
            depth_limited=depth_limited,
            lineage=lineage or [],
        )
        
        audit.projection_id = projected.projection_id
        self._audit_log.append(audit)
        
        return projected
    
    def project_for_prompt(
        self,
        state: Dict[str, Any],
        context: str = "",
        max_length: int = 5000,
        beat: int = 0,
    ) -> str:
        """
        Project state into a format suitable for AI prompts.
        
        Returns a string representation of the projected state.
        """
        # First, do a full projection
        projected = self.project(
            state=state,
            level=ProjectionLevel.PARTIAL,
            requester="prompt_generation",
            beat=beat,
        )
        
        # Build prompt-friendly representation
        lines = []
        
        if context:
            lines.append(f"Context: {context}")
            lines.append("")
        
        lines.append("Current State:")
        for key, value in projected.data.items():
            value_str = str(value)
            if len(value_str) > 500:
                value_str = value_str[:500] + "..."
            lines.append(f"  {key}: {value_str}")
        
        result = "\n".join(lines)
        
        # Truncate if needed
        if len(result) > max_length:
            result = result[:max_length] + "\n...[TRUNCATED]"
        
        return result
    
    def get_audit_log(
        self,
        requester: Optional[str] = None,
        limit: int = 100,
    ) -> List[ProjectionAuditRecord]:
        """Get projection audit records."""
        records = self._audit_log
        
        if requester:
            records = [r for r in records if r.requester == requester]
        
        return records[-limit:]
    
    def audit_summary(self) -> Dict[str, Any]:
        """Get summary of projection activity."""
        total = len(self._audit_log)
        total_projected = sum(len(r.projected_fields) for r in self._audit_log)
        total_blocked = sum(len(r.blocked_fields) for r in self._audit_log)
        
        return {
            "total_projections": total,
            "total_fields_projected": total_projected,
            "total_fields_blocked": total_blocked,
            "block_rate": round(total_blocked / max(1, total_projected + total_blocked), 4),
            "filter": self.filter.to_dict(),
        }
    
    def status(self) -> Dict[str, Any]:
        """Get engine status."""
        return {
            "filter": self.filter.name,
            "audit_records": len(self._audit_log),
            "summary": self.audit_summary(),
        }
