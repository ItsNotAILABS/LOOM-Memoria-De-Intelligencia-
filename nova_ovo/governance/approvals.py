"""
Approval Workflow — Governance
==============================
No runtime truth mutation without governance acceptance.
Gate A/B/C enforced everywhere.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, TYPE_CHECKING

if TYPE_CHECKING:
    from ..core.gates import GateEnforcer, GateLevel
    from .proposals import Proposal, ProposalEngine, ProposalStatus


class ApprovalDecision(str, Enum):
    APPROVE = "approve"
    REJECT = "reject"
    REQUEST_CHANGES = "request_changes"
    ABSTAIN = "abstain"


class ReviewerRole(str, Enum):
    REQUIRED = "required"
    OPTIONAL = "optional"
    OWNER = "owner"


@dataclass
class ApprovalRecord:
    """Record of an approval decision."""
    
    record_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    proposal_id: str = ""
    reviewer: str = ""
    role: ReviewerRole = ReviewerRole.OPTIONAL
    decision: ApprovalDecision = ApprovalDecision.ABSTAIN
    reason: str = ""
    conditions: List[str] = field(default_factory=list)
    gate_record_id: Optional[str] = None
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "record_id": self.record_id,
            "proposal_id": self.proposal_id,
            "reviewer": self.reviewer,
            "role": self.role.value,
            "decision": self.decision.value,
            "reason": self.reason,
            "conditions": self.conditions,
            "gate_record_id": self.gate_record_id,
            "timestamp": self.timestamp,
        }


@dataclass
class ApprovalPolicy:
    """Policy for proposal approval requirements."""
    
    policy_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    required_approvals: int = 1
    required_roles: List[str] = field(default_factory=list)
    require_owner_approval: bool = False
    allow_self_approval: bool = False
    gate_required: bool = True
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "policy_id": self.policy_id,
            "name": self.name,
            "required_approvals": self.required_approvals,
            "required_roles": self.required_roles,
            "require_owner_approval": self.require_owner_approval,
            "allow_self_approval": self.allow_self_approval,
            "gate_required": self.gate_required,
        }


class ApprovalEngine:
    """
    Engine for managing approval workflow.
    
    Enforces Gate B for workforce activation.
    All decisions create evidence records.
    """
    
    DEFAULT_POLICY = ApprovalPolicy(
        name="default",
        required_approvals=1,
        require_owner_approval=False,
        allow_self_approval=False,
        gate_required=True,
    )
    
    def __init__(
        self,
        proposal_engine: Optional["ProposalEngine"] = None,
        gate_enforcer: Optional["GateEnforcer"] = None,
    ) -> None:
        self._proposal_engine = proposal_engine
        self._gate_enforcer = gate_enforcer
        self._records: Dict[str, List[ApprovalRecord]] = {}  # proposal_id -> records
        self._policies: Dict[str, ApprovalPolicy] = {"default": self.DEFAULT_POLICY}
        self._audit_log: List[Dict[str, Any]] = []
    
    def bind_proposal_engine(self, engine: "ProposalEngine") -> None:
        """Bind to a proposal engine."""
        self._proposal_engine = engine
    
    def set_policy(self, proposal_type: str, policy: ApprovalPolicy) -> None:
        """Set approval policy for a proposal type."""
        self._policies[proposal_type] = policy
    
    def get_policy(self, proposal_type: str) -> ApprovalPolicy:
        """Get approval policy for a proposal type."""
        return self._policies.get(proposal_type, self.DEFAULT_POLICY)
    
    def submit_decision(
        self,
        proposal_id: str,
        reviewer: str,
        decision: ApprovalDecision,
        reason: str = "",
        conditions: Optional[List[str]] = None,
        role: ReviewerRole = ReviewerRole.OPTIONAL,
    ) -> Optional[ApprovalRecord]:
        """
        Submit an approval decision for a proposal.
        
        Checks Gate B for workforce activation.
        """
        if self._proposal_engine is None:
            return None
        
        proposal = self._proposal_engine.get_proposal(proposal_id)
        if proposal is None:
            return None
        
        from .proposals import ProposalStatus
        if proposal.status != ProposalStatus.PENDING:
            return None
        
        # Check Gate B
        gate_record_id: Optional[str] = None
        if self._gate_enforcer:
            from ..core.gates import GateLevel
            record = self._gate_enforcer.evaluate(
                GateLevel.B,
                f"approval_{decision.value}",
                {
                    "proposal_id": proposal_id,
                    "reviewer": reviewer,
                    "decision": decision.value,
                },
                reviewer,
            )
            gate_record_id = record.record_id
            proposal.gate_records.append(record.record_id)
            
            if record.decision.value != "PASS":
                self._audit_log.append({
                    "event": "approval_gate_denied",
                    "proposal_id": proposal_id,
                    "reviewer": reviewer,
                    "gate_record_id": gate_record_id,
                    "reason": record.reason,
                    "timestamp": time.time(),
                })
                return None
        
        # Create approval record
        approval = ApprovalRecord(
            proposal_id=proposal_id,
            reviewer=reviewer,
            role=role,
            decision=decision,
            reason=reason,
            conditions=conditions or [],
            gate_record_id=gate_record_id,
        )
        
        # Store record
        if proposal_id not in self._records:
            self._records[proposal_id] = []
        self._records[proposal_id].append(approval)
        
        # Add reviewer to proposal
        if reviewer not in proposal.reviewers:
            proposal.reviewers.append(reviewer)
        
        self._audit_log.append({
            "event": "approval_submitted",
            "proposal_id": proposal_id,
            "reviewer": reviewer,
            "decision": decision.value,
            "timestamp": time.time(),
        })
        
        # Check if proposal should be resolved
        self._check_resolution(proposal_id)
        
        return approval
    
    def _check_resolution(self, proposal_id: str) -> None:
        """Check if proposal can be resolved based on approvals."""
        if self._proposal_engine is None:
            return
        
        proposal = self._proposal_engine.get_proposal(proposal_id)
        if proposal is None:
            return
        
        from .proposals import ProposalStatus
        if proposal.status != ProposalStatus.PENDING:
            return
        
        records = self._records.get(proposal_id, [])
        policy = self.get_policy(proposal.proposal_type.value)
        
        # Count decisions
        approvals = [r for r in records if r.decision == ApprovalDecision.APPROVE]
        rejections = [r for r in records if r.decision == ApprovalDecision.REJECT]
        
        # Check rejection (any rejection fails)
        if rejections:
            proposal.status = ProposalStatus.REJECTED
            proposal.resolved_at = time.time()
            proposal.approver = rejections[0].reviewer
            
            self._audit_log.append({
                "event": "proposal_rejected",
                "proposal_id": proposal_id,
                "rejector": rejections[0].reviewer,
                "reason": rejections[0].reason,
                "timestamp": time.time(),
            })
            return
        
        # Check approval threshold
        if len(approvals) >= policy.required_approvals:
            # Check owner approval if required
            if policy.require_owner_approval:
                owner_approved = any(r.role == ReviewerRole.OWNER for r in approvals)
                if not owner_approved:
                    return
            
            proposal.status = ProposalStatus.APPROVED
            proposal.resolved_at = time.time()
            proposal.approver = approvals[-1].reviewer
            
            self._audit_log.append({
                "event": "proposal_approved",
                "proposal_id": proposal_id,
                "approver": proposal.approver,
                "approval_count": len(approvals),
                "timestamp": time.time(),
            })
    
    def get_records(self, proposal_id: str) -> List[ApprovalRecord]:
        """Get all approval records for a proposal."""
        return self._records.get(proposal_id, [])
    
    def get_pending_approvals(self, reviewer: str) -> List[str]:
        """Get proposal IDs pending approval from a reviewer."""
        if self._proposal_engine is None:
            return []
        
        from .proposals import ProposalStatus
        pending: List[str] = []
        
        for proposal in self._proposal_engine.list_proposals(status=ProposalStatus.PENDING):
            # Check if reviewer has already decided
            records = self._records.get(proposal.proposal_id, [])
            has_decided = any(r.reviewer == reviewer for r in records)
            if not has_decided:
                pending.append(proposal.proposal_id)
        
        return pending
    
    def get_approval_status(self, proposal_id: str) -> Dict[str, Any]:
        """Get detailed approval status for a proposal."""
        if self._proposal_engine is None:
            return {"error": "No proposal engine"}
        
        proposal = self._proposal_engine.get_proposal(proposal_id)
        if proposal is None:
            return {"error": "Proposal not found"}
        
        records = self._records.get(proposal_id, [])
        policy = self.get_policy(proposal.proposal_type.value)
        
        approvals = [r for r in records if r.decision == ApprovalDecision.APPROVE]
        rejections = [r for r in records if r.decision == ApprovalDecision.REJECT]
        
        return {
            "proposal_id": proposal_id,
            "status": proposal.status.value,
            "policy": policy.to_dict(),
            "approvals_needed": policy.required_approvals,
            "approvals_received": len(approvals),
            "rejections": len(rejections),
            "records": [r.to_dict() for r in records],
        }
    
    def get_audit_log(self, limit: int = 100) -> List[Dict[str, Any]]:
        """Get audit log."""
        return self._audit_log[-limit:]
