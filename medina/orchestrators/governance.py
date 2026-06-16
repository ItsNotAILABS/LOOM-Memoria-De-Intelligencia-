"""
ORCH-04 FULL_GOVERNANCE_ORCHESTRATOR — Proposal/approval workflow.

Implements the governance workflow for MEDINA:
- Proposals from Core B (workforce)
- Approval/rejection by Core A (runtime truth)
- Policy enforcement
- Audit trails

Governance is built-in (not post-launch).
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional

from nova_ovo.core import GateEnforcer, GateLevel, GateDecision


class ProposalState(Enum):
    """Lifecycle states for governance proposals."""
    
    DRAFT = "draft"             # Being composed
    SUBMITTED = "submitted"     # Awaiting review
    UNDER_REVIEW = "under_review"  # Being evaluated
    APPROVED = "approved"       # Accepted by Core A
    REJECTED = "rejected"       # Denied by Core A
    WITHDRAWN = "withdrawn"     # Cancelled by proposer
    IMPLEMENTED = "implemented" # Changes applied


class ProposalCategory(Enum):
    """Categories of governance proposals."""
    
    RUNTIME_MUTATION = "runtime_mutation"   # Core A state change
    POLICY_CHANGE = "policy_change"         # Governance policy
    PERMISSION_GRANT = "permission_grant"   # Access control
    PERMISSION_REVOKE = "permission_revoke" # Access removal
    RESOURCE_ALLOCATION = "resource_allocation"  # Budget/resources
    DOCTRINE_AMENDMENT = "doctrine_amendment"    # Constitution change
    WORKFORCE_ACTIVATION = "workforce_activation"  # Agent/doc activation


@dataclass
class Proposal:
    """A governance proposal."""
    
    proposal_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    title: str = ""
    description: str = ""
    category: ProposalCategory = ProposalCategory.RUNTIME_MUTATION
    state: ProposalState = ProposalState.DRAFT
    
    # Proposer info
    proposer: str = "system"
    proposer_register: str = "builder"  # Typically Core B
    
    # Content
    proposed_changes: Dict[str, Any] = field(default_factory=dict)
    rationale: str = ""
    evidence: List[Dict[str, Any]] = field(default_factory=list)
    
    # Review
    reviewer: Optional[str] = None
    review_notes: str = ""
    review_timestamp: Optional[float] = None
    
    # Timestamps
    created_at: float = field(default_factory=time.time)
    submitted_at: Optional[float] = None
    decided_at: Optional[float] = None
    
    # Beat tracking
    created_beat: int = 0
    decided_beat: Optional[int] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "proposal_id": self.proposal_id,
            "title": self.title,
            "description": self.description,
            "category": self.category.value,
            "state": self.state.value,
            "proposer": self.proposer,
            "proposer_register": self.proposer_register,
            "proposed_changes": self.proposed_changes,
            "rationale": self.rationale,
            "evidence_count": len(self.evidence),
            "reviewer": self.reviewer,
            "review_notes": self.review_notes,
            "created_at": self.created_at,
            "submitted_at": self.submitted_at,
            "decided_at": self.decided_at,
            "created_beat": self.created_beat,
            "decided_beat": self.decided_beat,
        }


@dataclass
class GovernanceDecision:
    """Record of a governance decision."""
    
    decision_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    proposal_id: str = ""
    decision: str = ""  # "approved" or "rejected"
    authority: str = "core_a"
    reason: str = ""
    beat: int = 0
    timestamp: float = field(default_factory=time.time)
    gate_record_id: Optional[str] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "decision_id": self.decision_id,
            "proposal_id": self.proposal_id,
            "decision": self.decision,
            "authority": self.authority,
            "reason": self.reason,
            "beat": self.beat,
            "timestamp": self.timestamp,
            "gate_record_id": self.gate_record_id,
        }


# Policy check function type
PolicyCheckFn = Callable[[Proposal], tuple[bool, str]]


class GovernanceOrchestrator:
    """
    ORCH-04 FULL_GOVERNANCE_ORCHESTRATOR
    
    Manages the complete governance workflow:
    
    1. Proposal creation (Core B)
    2. Submission for review
    3. Policy validation
    4. Gate A evaluation
    5. Approval/rejection
    6. Implementation tracking
    
    All decisions are logged for audit and replay.
    """
    
    def __init__(self, gate_enforcer: Optional[GateEnforcer] = None) -> None:
        self._id = str(uuid.uuid4())
        self._gate_enforcer = gate_enforcer or GateEnforcer()
        self._proposals: Dict[str, Proposal] = {}
        self._decisions: List[GovernanceDecision] = []
        self._policy_checks: Dict[str, PolicyCheckFn] = {}
        self._current_beat = 0
        
        # Register default policy checks
        self._register_default_policies()
    
    def _register_default_policies(self) -> None:
        """Register default policy validation checks."""
        
        def check_has_rationale(proposal: Proposal) -> tuple[bool, str]:
            if not proposal.rationale:
                return False, "Proposal must include rationale"
            return True, "Rationale present"
        
        def check_has_title(proposal: Proposal) -> tuple[bool, str]:
            if not proposal.title:
                return False, "Proposal must have a title"
            return True, "Title present"
        
        def check_has_changes(proposal: Proposal) -> tuple[bool, str]:
            if not proposal.proposed_changes:
                return False, "Proposal must specify changes"
            return True, "Changes specified"
        
        self._policy_checks["has_rationale"] = check_has_rationale
        self._policy_checks["has_title"] = check_has_title
        self._policy_checks["has_changes"] = check_has_changes
    
    # ------------------------------------------------------------------ #
    # Proposal Lifecycle                                                    #
    # ------------------------------------------------------------------ #
    
    def create_proposal(
        self,
        title: str,
        description: str,
        category: ProposalCategory,
        proposed_changes: Dict[str, Any],
        rationale: str,
        proposer: str = "system",
    ) -> Proposal:
        """Create a new governance proposal (draft state)."""
        proposal = Proposal(
            title=title,
            description=description,
            category=category,
            proposed_changes=proposed_changes,
            rationale=rationale,
            proposer=proposer,
            created_beat=self._current_beat,
        )
        self._proposals[proposal.proposal_id] = proposal
        return proposal
    
    def submit_proposal(self, proposal_id: str) -> bool:
        """Submit a draft proposal for review."""
        if proposal_id not in self._proposals:
            return False
        
        proposal = self._proposals[proposal_id]
        if proposal.state != ProposalState.DRAFT:
            return False
        
        # Run policy checks
        for check_name, check_fn in self._policy_checks.items():
            passed, message = check_fn(proposal)
            if not passed:
                return False
        
        proposal.state = ProposalState.SUBMITTED
        proposal.submitted_at = time.time()
        return True
    
    def review_proposal(
        self,
        proposal_id: str,
        reviewer: str,
    ) -> bool:
        """Mark proposal as under review."""
        if proposal_id not in self._proposals:
            return False
        
        proposal = self._proposals[proposal_id]
        if proposal.state != ProposalState.SUBMITTED:
            return False
        
        proposal.state = ProposalState.UNDER_REVIEW
        proposal.reviewer = reviewer
        proposal.review_timestamp = time.time()
        return True
    
    def approve_proposal(
        self,
        proposal_id: str,
        authority: str = "core_a",
        reason: str = "",
    ) -> Optional[GovernanceDecision]:
        """
        Approve a proposal (Core A authority).
        
        Must pass Gate A before approval.
        """
        if proposal_id not in self._proposals:
            return None
        
        proposal = self._proposals[proposal_id]
        if proposal.state not in (ProposalState.SUBMITTED, ProposalState.UNDER_REVIEW):
            return None
        
        # Gate A check
        gate_record = self._gate_enforcer.evaluate(
            GateLevel.A,
            f"approve_proposal_{proposal.category.value}",
            {"proposal_id": proposal_id, "changes": proposal.proposed_changes},
            actor=authority,
        )
        
        if gate_record.decision != GateDecision.PASS:
            return None
        
        # Record approval
        proposal.state = ProposalState.APPROVED
        proposal.decided_at = time.time()
        proposal.decided_beat = self._current_beat
        proposal.review_notes = reason
        
        decision = GovernanceDecision(
            proposal_id=proposal_id,
            decision="approved",
            authority=authority,
            reason=reason,
            beat=self._current_beat,
            gate_record_id=gate_record.record_id,
        )
        self._decisions.append(decision)
        
        return decision
    
    def reject_proposal(
        self,
        proposal_id: str,
        authority: str = "core_a",
        reason: str = "",
    ) -> Optional[GovernanceDecision]:
        """Reject a proposal."""
        if proposal_id not in self._proposals:
            return None
        
        proposal = self._proposals[proposal_id]
        if proposal.state not in (ProposalState.SUBMITTED, ProposalState.UNDER_REVIEW):
            return None
        
        proposal.state = ProposalState.REJECTED
        proposal.decided_at = time.time()
        proposal.decided_beat = self._current_beat
        proposal.review_notes = reason
        
        decision = GovernanceDecision(
            proposal_id=proposal_id,
            decision="rejected",
            authority=authority,
            reason=reason,
            beat=self._current_beat,
        )
        self._decisions.append(decision)
        
        return decision
    
    def withdraw_proposal(self, proposal_id: str, reason: str = "") -> bool:
        """Withdraw a proposal (by proposer)."""
        if proposal_id not in self._proposals:
            return False
        
        proposal = self._proposals[proposal_id]
        if proposal.state in (ProposalState.APPROVED, ProposalState.IMPLEMENTED):
            return False
        
        proposal.state = ProposalState.WITHDRAWN
        proposal.review_notes = reason
        return True
    
    def mark_implemented(self, proposal_id: str) -> bool:
        """Mark an approved proposal as implemented."""
        if proposal_id not in self._proposals:
            return False
        
        proposal = self._proposals[proposal_id]
        if proposal.state != ProposalState.APPROVED:
            return False
        
        proposal.state = ProposalState.IMPLEMENTED
        return True
    
    # ------------------------------------------------------------------ #
    # Queries                                                               #
    # ------------------------------------------------------------------ #
    
    def get_proposal(self, proposal_id: str) -> Optional[Proposal]:
        """Get a proposal by ID."""
        return self._proposals.get(proposal_id)
    
    def list_proposals(
        self,
        state: Optional[ProposalState] = None,
        category: Optional[ProposalCategory] = None,
        proposer: Optional[str] = None,
        limit: int = 50,
    ) -> List[Proposal]:
        """List proposals with optional filters."""
        proposals = list(self._proposals.values())
        
        if state:
            proposals = [p for p in proposals if p.state == state]
        if category:
            proposals = [p for p in proposals if p.category == category]
        if proposer:
            proposals = [p for p in proposals if p.proposer == proposer]
        
        # Sort by creation time, newest first
        proposals.sort(key=lambda p: p.created_at, reverse=True)
        return proposals[:limit]
    
    def pending_proposals(self) -> List[Proposal]:
        """Get proposals awaiting decision."""
        return self.list_proposals(state=ProposalState.SUBMITTED) + \
               self.list_proposals(state=ProposalState.UNDER_REVIEW)
    
    def get_decisions(
        self,
        proposal_id: Optional[str] = None,
        limit: int = 100,
    ) -> List[GovernanceDecision]:
        """Get governance decisions."""
        decisions = self._decisions
        if proposal_id:
            decisions = [d for d in decisions if d.proposal_id == proposal_id]
        return decisions[-limit:]
    
    # ------------------------------------------------------------------ #
    # Policy Management                                                     #
    # ------------------------------------------------------------------ #
    
    def register_policy_check(
        self,
        name: str,
        check_fn: PolicyCheckFn,
    ) -> None:
        """Register a custom policy check."""
        self._policy_checks[name] = check_fn
    
    def unregister_policy_check(self, name: str) -> bool:
        """Remove a policy check."""
        if name in self._policy_checks:
            del self._policy_checks[name]
            return True
        return False
    
    # ------------------------------------------------------------------ #
    # Beat Integration                                                      #
    # ------------------------------------------------------------------ #
    
    def tick(self, beat: int) -> None:
        """Process beat for governance orchestrator."""
        self._current_beat = beat
    
    # ------------------------------------------------------------------ #
    # Status                                                                #
    # ------------------------------------------------------------------ #
    
    def status(self) -> Dict[str, Any]:
        """Current governance status."""
        by_state: Dict[str, int] = {}
        for proposal in self._proposals.values():
            by_state[proposal.state.value] = by_state.get(proposal.state.value, 0) + 1
        
        return {
            "orchestrator_id": self._id,
            "name": "ORCH-04 FULL_GOVERNANCE_ORCHESTRATOR",
            "current_beat": self._current_beat,
            "total_proposals": len(self._proposals),
            "proposals_by_state": by_state,
            "total_decisions": len(self._decisions),
            "policy_checks": list(self._policy_checks.keys()),
        }
