"""
MEDINA Governance — Built-in governance system.

Governance is built-in (not post-launch):
- Proposal workflow
- Approval workflow
- Policy checks
- Role-based permissions
- Replay evidence chains
- Gate score visibility
"""

from medina.orchestrators.governance import (
    GovernanceOrchestrator,
    Proposal,
    ProposalState,
    ProposalCategory,
    GovernanceDecision,
)

__all__ = [
    "GovernanceOrchestrator",
    "Proposal",
    "ProposalState",
    "ProposalCategory",
    "GovernanceDecision",
]
