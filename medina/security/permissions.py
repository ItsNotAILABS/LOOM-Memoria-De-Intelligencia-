"""
MEDINA Permission Management — Explicit access control.

All permissions are:
- Explicit (must be granted)
- Revocable (can be removed)
- Auditable (all changes logged)

No hidden collection. No silent escalation.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional


class PermissionScope(Enum):
    """Categories of permissions."""
    
    FILESYSTEM = "filesystem"
    CAMERA = "camera"
    MICROPHONE = "microphone"
    SCREEN_CAPTURE = "screen_capture"
    CLIPBOARD = "clipboard"
    LOCATION = "location"
    NOTIFICATIONS = "notifications"
    COMMAND_BRIDGE = "command_bridge"
    CONNECTORS = "connectors"
    COMPUTE_LOCAL = "compute_local"
    COMPUTE_SANDBOX = "compute_sandbox"
    COMPUTE_CLOUD = "compute_cloud"
    MEMORY_READ = "memory_read"
    MEMORY_WRITE = "memory_write"
    GOVERNANCE_READ = "governance_read"
    GOVERNANCE_WRITE = "governance_write"
    MODEL_INVOKE = "model_invoke"


class PermissionLevel(Enum):
    """Permission access levels."""
    
    NONE = "none"           # No access
    READ = "read"           # Read-only
    WRITE = "write"         # Read + write
    ADMIN = "admin"         # Full control


class GrantStatus(Enum):
    """Status of a permission grant."""
    
    ACTIVE = "active"       # Currently granted
    REVOKED = "revoked"     # Explicitly revoked
    EXPIRED = "expired"     # Time-limited, expired
    PENDING = "pending"     # Awaiting approval


@dataclass
class Permission:
    """A single permission definition."""
    
    permission_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    scope: PermissionScope = PermissionScope.FILESYSTEM
    level: PermissionLevel = PermissionLevel.NONE
    description: str = ""
    
    # Constraints
    path_pattern: Optional[str] = None  # For filesystem
    time_limit_hours: Optional[int] = None  # Auto-expire
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "permission_id": self.permission_id,
            "scope": self.scope.value,
            "level": self.level.value,
            "description": self.description,
            "path_pattern": self.path_pattern,
            "time_limit_hours": self.time_limit_hours,
        }


@dataclass
class PermissionGrant:
    """A grant of permission to an actor."""
    
    grant_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    permission: Permission = field(default_factory=Permission)
    grantee: str = ""  # Actor receiving permission
    grantor: str = ""  # Actor granting permission
    
    # Status
    status: GrantStatus = GrantStatus.ACTIVE
    
    # Timestamps
    granted_at: float = field(default_factory=time.time)
    expires_at: Optional[float] = None
    revoked_at: Optional[float] = None
    revoked_by: Optional[str] = None
    revocation_reason: Optional[str] = None
    
    def is_valid(self) -> bool:
        """Check if grant is currently valid."""
        if self.status != GrantStatus.ACTIVE:
            return False
        if self.expires_at and time.time() > self.expires_at:
            return False
        return True
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "grant_id": self.grant_id,
            "permission": self.permission.to_dict(),
            "grantee": self.grantee,
            "grantor": self.grantor,
            "status": self.status.value,
            "granted_at": self.granted_at,
            "expires_at": self.expires_at,
            "revoked_at": self.revoked_at,
            "revoked_by": self.revoked_by,
            "is_valid": self.is_valid(),
        }


@dataclass
class AuditEntry:
    """Audit log entry for permission changes."""
    
    entry_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    action: str = ""  # grant, revoke, check
    grant_id: str = ""
    actor: str = ""
    result: str = ""
    timestamp: float = field(default_factory=time.time)
    details: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "entry_id": self.entry_id,
            "action": self.action,
            "grant_id": self.grant_id,
            "actor": self.actor,
            "result": self.result,
            "timestamp": self.timestamp,
            "details": self.details,
        }


class PermissionManager:
    """
    MEDINA Permission Manager — Explicit access control.
    
    All permissions must be:
    - Explicitly granted (no implicit access)
    - Revocable at any time
    - Fully audited
    
    No hidden data capture. No silent access escalation.
    """
    
    def __init__(self) -> None:
        self._grants: Dict[str, PermissionGrant] = {}
        self._audit_log: List[AuditEntry] = []
    
    # ------------------------------------------------------------------ #
    # Grant Management                                                      #
    # ------------------------------------------------------------------ #
    
    def grant(
        self,
        grantee: str,
        scope: PermissionScope,
        level: PermissionLevel,
        grantor: str,
        description: str = "",
        path_pattern: Optional[str] = None,
        time_limit_hours: Optional[int] = None,
    ) -> PermissionGrant:
        """
        Grant a permission to an actor.
        
        Creates a new grant and logs the action.
        """
        permission = Permission(
            scope=scope,
            level=level,
            description=description,
            path_pattern=path_pattern,
            time_limit_hours=time_limit_hours,
        )
        
        expires_at = None
        if time_limit_hours:
            expires_at = time.time() + (time_limit_hours * 3600)
        
        grant = PermissionGrant(
            permission=permission,
            grantee=grantee,
            grantor=grantor,
            expires_at=expires_at,
        )
        
        self._grants[grant.grant_id] = grant
        
        # Audit
        self._audit("grant", grant.grant_id, grantor, "granted", {
            "grantee": grantee,
            "scope": scope.value,
            "level": level.value,
        })
        
        return grant
    
    def revoke(
        self,
        grant_id: str,
        revoker: str,
        reason: str = "",
    ) -> bool:
        """
        Revoke a permission grant.
        
        Marks the grant as revoked (does not delete for audit trail).
        """
        if grant_id not in self._grants:
            return False
        
        grant = self._grants[grant_id]
        
        if grant.status == GrantStatus.REVOKED:
            return False
        
        grant.status = GrantStatus.REVOKED
        grant.revoked_at = time.time()
        grant.revoked_by = revoker
        grant.revocation_reason = reason
        
        # Audit
        self._audit("revoke", grant_id, revoker, "revoked", {
            "reason": reason,
            "grantee": grant.grantee,
        })
        
        return True
    
    def revoke_all(
        self,
        grantee: str,
        revoker: str,
        reason: str = "",
    ) -> int:
        """Revoke all grants for a grantee."""
        count = 0
        for grant_id, grant in self._grants.items():
            if grant.grantee == grantee and grant.status == GrantStatus.ACTIVE:
                self.revoke(grant_id, revoker, reason)
                count += 1
        return count
    
    # ------------------------------------------------------------------ #
    # Permission Checking                                                   #
    # ------------------------------------------------------------------ #
    
    def check(
        self,
        grantee: str,
        scope: PermissionScope,
        required_level: PermissionLevel = PermissionLevel.READ,
        path: Optional[str] = None,
    ) -> bool:
        """
        Check if an actor has a specific permission.
        
        Returns True only if valid grant exists at required level.
        """
        for grant in self._grants.values():
            if grant.grantee != grantee:
                continue
            if grant.permission.scope != scope:
                continue
            if not grant.is_valid():
                continue
            
            # Check level (admin > write > read > none)
            level_order = [
                PermissionLevel.NONE,
                PermissionLevel.READ,
                PermissionLevel.WRITE,
                PermissionLevel.ADMIN,
            ]
            grant_idx = level_order.index(grant.permission.level)
            required_idx = level_order.index(required_level)
            
            if grant_idx < required_idx:
                continue
            
            # Check path pattern if applicable
            if path and grant.permission.path_pattern:
                import fnmatch
                if not fnmatch.fnmatch(path, grant.permission.path_pattern):
                    continue
            
            # Audit successful check
            self._audit("check", grant.grant_id, grantee, "allowed", {
                "scope": scope.value,
                "level": required_level.value,
            })
            
            return True
        
        # Audit failed check
        self._audit("check", "", grantee, "denied", {
            "scope": scope.value,
            "level": required_level.value,
        })
        
        return False
    
    def require(
        self,
        grantee: str,
        scope: PermissionScope,
        required_level: PermissionLevel = PermissionLevel.READ,
        path: Optional[str] = None,
    ) -> None:
        """Check permission and raise if denied."""
        if not self.check(grantee, scope, required_level, path):
            raise PermissionError(
                f"Permission denied: {grantee} requires {scope.value}:{required_level.value}"
            )
    
    # ------------------------------------------------------------------ #
    # Queries                                                               #
    # ------------------------------------------------------------------ #
    
    def get_grant(self, grant_id: str) -> Optional[PermissionGrant]:
        """Get a grant by ID."""
        return self._grants.get(grant_id)
    
    def list_grants(
        self,
        grantee: Optional[str] = None,
        scope: Optional[PermissionScope] = None,
        active_only: bool = True,
    ) -> List[PermissionGrant]:
        """List grants with optional filters."""
        grants = list(self._grants.values())
        
        if grantee:
            grants = [g for g in grants if g.grantee == grantee]
        if scope:
            grants = [g for g in grants if g.permission.scope == scope]
        if active_only:
            grants = [g for g in grants if g.is_valid()]
        
        return grants
    
    def get_grantee_permissions(
        self,
        grantee: str,
    ) -> Dict[str, PermissionLevel]:
        """Get all active permissions for a grantee."""
        perms: Dict[str, PermissionLevel] = {}
        
        for grant in self._grants.values():
            if grant.grantee != grantee or not grant.is_valid():
                continue
            
            scope = grant.permission.scope.value
            level = grant.permission.level
            
            # Keep highest level for each scope
            if scope not in perms:
                perms[scope] = level
            else:
                level_order = [
                    PermissionLevel.NONE,
                    PermissionLevel.READ,
                    PermissionLevel.WRITE,
                    PermissionLevel.ADMIN,
                ]
                if level_order.index(level) > level_order.index(perms[scope]):
                    perms[scope] = level
        
        return perms
    
    # ------------------------------------------------------------------ #
    # Audit                                                                 #
    # ------------------------------------------------------------------ #
    
    def _audit(
        self,
        action: str,
        grant_id: str,
        actor: str,
        result: str,
        details: Dict[str, Any],
    ) -> None:
        """Record an audit entry."""
        entry = AuditEntry(
            action=action,
            grant_id=grant_id,
            actor=actor,
            result=result,
            details=details,
        )
        self._audit_log.append(entry)
    
    def get_audit_log(
        self,
        actor: Optional[str] = None,
        action: Optional[str] = None,
        limit: int = 100,
    ) -> List[AuditEntry]:
        """Query audit log."""
        entries = self._audit_log
        
        if actor:
            entries = [e for e in entries if e.actor == actor]
        if action:
            entries = [e for e in entries if e.action == action]
        
        return entries[-limit:]
    
    # ------------------------------------------------------------------ #
    # Expiration                                                            #
    # ------------------------------------------------------------------ #
    
    def expire_grants(self) -> int:
        """Expire time-limited grants that have passed their expiration."""
        count = 0
        now = time.time()
        
        for grant in self._grants.values():
            if grant.status == GrantStatus.ACTIVE:
                if grant.expires_at and now > grant.expires_at:
                    grant.status = GrantStatus.EXPIRED
                    self._audit("expire", grant.grant_id, "system", "expired", {
                        "grantee": grant.grantee,
                    })
                    count += 1
        
        return count
    
    # ------------------------------------------------------------------ #
    # Status                                                                #
    # ------------------------------------------------------------------ #
    
    def status(self) -> Dict[str, Any]:
        """Permission system status."""
        active = sum(1 for g in self._grants.values() if g.status == GrantStatus.ACTIVE)
        revoked = sum(1 for g in self._grants.values() if g.status == GrantStatus.REVOKED)
        expired = sum(1 for g in self._grants.values() if g.status == GrantStatus.EXPIRED)
        
        return {
            "total_grants": len(self._grants),
            "active_grants": active,
            "revoked_grants": revoked,
            "expired_grants": expired,
            "audit_log_size": len(self._audit_log),
        }
