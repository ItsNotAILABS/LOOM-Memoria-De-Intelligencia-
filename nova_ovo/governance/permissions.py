"""
Permissions — Governance
========================
Explicit toggles (grant/revoke/audit).
No hidden collection. No silent escalation.

Coverage:
- filesystem scope
- camera
- microphone
- screen capture
- clipboard
- location
- notifications
- command bridge
- connectors
- local/sandbox/cloud compute
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Set


class AccessScope(str, Enum):
    """Access scopes for permissions."""
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
    MODEL_ADMIN = "model_admin"
    COMPANY_READ = "company_read"
    COMPANY_ADMIN = "company_admin"


class PermissionAction(str, Enum):
    """Actions that can be taken on permissions."""
    GRANT = "grant"
    REVOKE = "revoke"
    SUSPEND = "suspend"
    RESTORE = "restore"


@dataclass
class Permission:
    """A single permission grant."""
    
    permission_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    scope: AccessScope = AccessScope.MEMORY_READ
    granted_to: str = ""  # Actor/role ID
    granted_by: str = ""
    active: bool = True
    conditions: Dict[str, Any] = field(default_factory=dict)
    expires_at: Optional[float] = None
    created_at: float = field(default_factory=time.time)
    modified_at: float = field(default_factory=time.time)
    
    def is_valid(self) -> bool:
        """Check if permission is currently valid."""
        if not self.active:
            return False
        if self.expires_at and self.expires_at < time.time():
            return False
        return True
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "permission_id": self.permission_id,
            "scope": self.scope.value,
            "granted_to": self.granted_to,
            "granted_by": self.granted_by,
            "active": self.active,
            "conditions": self.conditions,
            "expires_at": self.expires_at,
            "created_at": self.created_at,
            "modified_at": self.modified_at,
            "is_valid": self.is_valid(),
        }


@dataclass
class Role:
    """A role with associated permissions."""
    
    role_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    description: str = ""
    scopes: Set[AccessScope] = field(default_factory=set)
    parent_role_id: Optional[str] = None  # Role inheritance
    created_at: float = field(default_factory=time.time)
    
    def has_scope(self, scope: AccessScope) -> bool:
        return scope in self.scopes
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "role_id": self.role_id,
            "name": self.name,
            "description": self.description,
            "scopes": [s.value for s in self.scopes],
            "parent_role_id": self.parent_role_id,
            "created_at": self.created_at,
        }


@dataclass
class PermissionAuditEntry:
    """Audit entry for permission changes."""
    
    entry_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    action: PermissionAction = PermissionAction.GRANT
    permission_id: str = ""
    scope: str = ""
    target: str = ""  # Who the permission affects
    actor: str = ""   # Who made the change
    reason: str = ""
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "entry_id": self.entry_id,
            "action": self.action.value,
            "permission_id": self.permission_id,
            "scope": self.scope,
            "target": self.target,
            "actor": self.actor,
            "reason": self.reason,
            "timestamp": self.timestamp,
        }


# Default roles
DEFAULT_ROLES = {
    "admin": Role(
        name="admin",
        description="Full administrative access",
        scopes=set(AccessScope),  # All scopes
    ),
    "operator": Role(
        name="operator",
        description="Standard operator access",
        scopes={
            AccessScope.MEMORY_READ,
            AccessScope.MEMORY_WRITE,
            AccessScope.GOVERNANCE_READ,
            AccessScope.MODEL_INVOKE,
            AccessScope.COMPANY_READ,
            AccessScope.NOTIFICATIONS,
            AccessScope.CLIPBOARD,
        },
    ),
    "viewer": Role(
        name="viewer",
        description="Read-only access",
        scopes={
            AccessScope.MEMORY_READ,
            AccessScope.GOVERNANCE_READ,
            AccessScope.COMPANY_READ,
        },
    ),
    "guest": Role(
        name="guest",
        description="Minimal guest access",
        scopes={
            AccessScope.MEMORY_READ,
        },
    ),
}


class PermissionManager:
    """
    Manager for permissions and access control.
    
    All changes are audited and revocable.
    No silent escalation.
    """
    
    def __init__(self) -> None:
        self._permissions: Dict[str, Permission] = {}
        self._roles: Dict[str, Role] = dict(DEFAULT_ROLES)
        self._actor_roles: Dict[str, Set[str]] = {}  # actor_id -> role_ids
        self._audit_log: List[PermissionAuditEntry] = []
    
    # ------------------------------------------------------------------ #
    # Role Management                                                       #
    # ------------------------------------------------------------------ #
    
    def create_role(
        self,
        name: str,
        description: str,
        scopes: Set[AccessScope],
        parent_role_id: Optional[str] = None,
    ) -> Role:
        """Create a new role."""
        role = Role(
            name=name,
            description=description,
            scopes=scopes,
            parent_role_id=parent_role_id,
        )
        self._roles[role.role_id] = role
        return role
    
    def get_role(self, role_id: str) -> Optional[Role]:
        """Get a role by ID or name."""
        if role_id in self._roles:
            return self._roles[role_id]
        # Try by name
        for role in self._roles.values():
            if role.name == role_id:
                return role
        return None
    
    def assign_role(self, actor_id: str, role_id: str, assigner: str = "system") -> bool:
        """Assign a role to an actor."""
        role = self.get_role(role_id)
        if role is None:
            return False
        
        if actor_id not in self._actor_roles:
            self._actor_roles[actor_id] = set()
        
        self._actor_roles[actor_id].add(role.role_id)
        
        self._audit_log.append(PermissionAuditEntry(
            action=PermissionAction.GRANT,
            scope=f"role:{role.name}",
            target=actor_id,
            actor=assigner,
            reason="Role assignment",
        ))
        
        return True
    
    def revoke_role(self, actor_id: str, role_id: str, revoker: str = "system") -> bool:
        """Revoke a role from an actor."""
        role = self.get_role(role_id)
        if role is None:
            return False
        
        if actor_id not in self._actor_roles:
            return False
        
        self._actor_roles[actor_id].discard(role.role_id)
        
        self._audit_log.append(PermissionAuditEntry(
            action=PermissionAction.REVOKE,
            scope=f"role:{role.name}",
            target=actor_id,
            actor=revoker,
            reason="Role revocation",
        ))
        
        return True
    
    def get_actor_roles(self, actor_id: str) -> List[Role]:
        """Get all roles for an actor."""
        role_ids = self._actor_roles.get(actor_id, set())
        roles: List[Role] = []
        
        for rid in role_ids:
            role = self._roles.get(rid)
            if role:
                roles.append(role)
                # Include parent roles
                if role.parent_role_id:
                    parent = self._roles.get(role.parent_role_id)
                    if parent and parent not in roles:
                        roles.append(parent)
        
        return roles
    
    # ------------------------------------------------------------------ #
    # Permission Management                                                 #
    # ------------------------------------------------------------------ #
    
    def grant(
        self,
        scope: AccessScope,
        target: str,
        granter: str = "system",
        conditions: Optional[Dict[str, Any]] = None,
        expires_at: Optional[float] = None,
        reason: str = "",
    ) -> Permission:
        """
        Grant a permission.
        
        All grants are logged and auditable.
        """
        permission = Permission(
            scope=scope,
            granted_to=target,
            granted_by=granter,
            active=True,
            conditions=conditions or {},
            expires_at=expires_at,
        )
        
        self._permissions[permission.permission_id] = permission
        
        self._audit_log.append(PermissionAuditEntry(
            action=PermissionAction.GRANT,
            permission_id=permission.permission_id,
            scope=scope.value,
            target=target,
            actor=granter,
            reason=reason,
        ))
        
        return permission
    
    def revoke(
        self,
        permission_id: str,
        revoker: str = "system",
        reason: str = "",
    ) -> bool:
        """
        Revoke a permission.
        
        All revocations are logged.
        """
        permission = self._permissions.get(permission_id)
        if permission is None:
            return False
        
        permission.active = False
        permission.modified_at = time.time()
        
        self._audit_log.append(PermissionAuditEntry(
            action=PermissionAction.REVOKE,
            permission_id=permission_id,
            scope=permission.scope.value,
            target=permission.granted_to,
            actor=revoker,
            reason=reason,
        ))
        
        return True
    
    def revoke_by_scope(
        self,
        scope: AccessScope,
        target: str,
        revoker: str = "system",
        reason: str = "",
    ) -> int:
        """Revoke all permissions for a scope/target combination."""
        revoked = 0
        for perm in self._permissions.values():
            if perm.scope == scope and perm.granted_to == target and perm.active:
                self.revoke(perm.permission_id, revoker, reason)
                revoked += 1
        return revoked
    
    def suspend(
        self,
        permission_id: str,
        suspender: str = "system",
        reason: str = "",
    ) -> bool:
        """Temporarily suspend a permission."""
        permission = self._permissions.get(permission_id)
        if permission is None:
            return False
        
        permission.active = False
        permission.modified_at = time.time()
        
        self._audit_log.append(PermissionAuditEntry(
            action=PermissionAction.SUSPEND,
            permission_id=permission_id,
            scope=permission.scope.value,
            target=permission.granted_to,
            actor=suspender,
            reason=reason,
        ))
        
        return True
    
    def restore(
        self,
        permission_id: str,
        restorer: str = "system",
        reason: str = "",
    ) -> bool:
        """Restore a suspended permission."""
        permission = self._permissions.get(permission_id)
        if permission is None:
            return False
        
        permission.active = True
        permission.modified_at = time.time()
        
        self._audit_log.append(PermissionAuditEntry(
            action=PermissionAction.RESTORE,
            permission_id=permission_id,
            scope=permission.scope.value,
            target=permission.granted_to,
            actor=restorer,
            reason=reason,
        ))
        
        return True
    
    # ------------------------------------------------------------------ #
    # Access Checks                                                         #
    # ------------------------------------------------------------------ #
    
    def has_access(self, actor_id: str, scope: AccessScope) -> bool:
        """
        Check if an actor has access to a scope.
        
        Checks both direct permissions and role-based permissions.
        """
        # Check direct permissions
        for perm in self._permissions.values():
            if (perm.granted_to == actor_id and
                perm.scope == scope and
                perm.is_valid()):
                return True
        
        # Check role-based permissions
        for role in self.get_actor_roles(actor_id):
            if role.has_scope(scope):
                return True
        
        return False
    
    def get_actor_scopes(self, actor_id: str) -> Set[AccessScope]:
        """Get all accessible scopes for an actor."""
        scopes: Set[AccessScope] = set()
        
        # Direct permissions
        for perm in self._permissions.values():
            if perm.granted_to == actor_id and perm.is_valid():
                scopes.add(perm.scope)
        
        # Role-based permissions
        for role in self.get_actor_roles(actor_id):
            scopes.update(role.scopes)
        
        return scopes
    
    def get_permissions(
        self,
        target: Optional[str] = None,
        scope: Optional[AccessScope] = None,
        active_only: bool = True,
    ) -> List[Permission]:
        """Get permissions with optional filters."""
        permissions = list(self._permissions.values())
        
        if target is not None:
            permissions = [p for p in permissions if p.granted_to == target]
        
        if scope is not None:
            permissions = [p for p in permissions if p.scope == scope]
        
        if active_only:
            permissions = [p for p in permissions if p.is_valid()]
        
        return permissions
    
    # ------------------------------------------------------------------ #
    # Audit                                                                 #
    # ------------------------------------------------------------------ #
    
    def get_audit_log(
        self,
        target: Optional[str] = None,
        scope: Optional[str] = None,
        action: Optional[PermissionAction] = None,
        limit: int = 100,
    ) -> List[PermissionAuditEntry]:
        """Get audit log with optional filters."""
        logs = self._audit_log
        
        if target:
            logs = [l for l in logs if l.target == target]
        
        if scope:
            logs = [l for l in logs if l.scope == scope]
        
        if action:
            logs = [l for l in logs if l.action == action]
        
        return logs[-limit:]
    
    def get_summary(self) -> Dict[str, Any]:
        """Get permission system summary."""
        active_permissions = [p for p in self._permissions.values() if p.is_valid()]
        
        by_scope: Dict[str, int] = {}
        for p in active_permissions:
            s = p.scope.value
            by_scope[s] = by_scope.get(s, 0) + 1
        
        return {
            "total_permissions": len(self._permissions),
            "active_permissions": len(active_permissions),
            "total_roles": len(self._roles),
            "actors_with_roles": len(self._actor_roles),
            "by_scope": by_scope,
            "audit_entries": len(self._audit_log),
        }
