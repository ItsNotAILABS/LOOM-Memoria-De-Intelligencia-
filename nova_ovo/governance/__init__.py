"""
Governance — MEDINA V1
======================
Governance is built in (not post-launch).

Provides:
- Proposal workflow
- Approval workflow
- Policy checks
- Role-based permissions
- Replay evidence chains
- Gate score visibility

No runtime truth mutation without governance acceptance.
"""

from .proposals import ProposalEngine, Proposal, ProposalStatus
from .approvals import ApprovalEngine, ApprovalDecision
from .permissions import PermissionManager, Role, Permission, AccessScope

__all__ = [
    "ProposalEngine",
    "Proposal",
    "ProposalStatus",
    "ApprovalEngine",
    "ApprovalDecision",
    "PermissionManager",
    "Role",
    "Permission",
    "AccessScope",
]
