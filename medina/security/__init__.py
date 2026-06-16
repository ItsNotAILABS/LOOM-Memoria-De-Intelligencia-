"""
MEDINA Security — Projection safety and access control.

SECURITY PRINCIPLES:
- Internal sovereign truth never directly exposed
- External is bounded projection with evidence
- Incident + rollback + replay required
- No hidden data capture, no silent access escalation

PERMISSIONS (explicit toggles):
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

from .permissions import (
    PermissionManager,
    Permission,
    PermissionGrant,
    PermissionScope,
)
from .projection import (
    ProjectionSafetyEngine,
    ProjectionBoundary,
    SafeProjection,
)

__all__ = [
    "PermissionManager",
    "Permission",
    "PermissionGrant",
    "PermissionScope",
    "ProjectionSafetyEngine",
    "ProjectionBoundary",
    "SafeProjection",
]
