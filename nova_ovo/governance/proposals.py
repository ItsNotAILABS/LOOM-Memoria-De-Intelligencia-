"""
Proposal Workflow — Governance
==============================
Every adaptation has lineage, evidence, rollback path.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, TYPE_CHECKING

if TYPE_CHECKING:
    from ..core.gates import GateEnforcer, GateRecord


class ProposalStatus(str, Enum):
    DRAFT = "draft"
    PENDING = "pending"
    APPROVED = "approved"
    REJECTED = "rejected"
    EXPIRED = "expired"
    EXECUTED = "executed"
    ROLLED_BACK = "rolled_back"


class ProposalType(str, Enum):
    RUNTIME_MUTATION = "runtime_mutation"
    POLICY_CHANGE = "policy_change"
    PERMISSION_GRANT = "permission_grant"
    PERMISSION_REVOKE = "permission_revoke"
    CONFIG_UPDATE = "config_update"
    ONBOARDING = "onboarding"
    GENERAL = "general"


@dataclass
class ProposalEvidence:
    """Evidence attached to a proposal."""
    
    evidence_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    evidence_type: str = ""
    content: Dict[str, Any] = field(default_factory=dict)
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "evidence_id": self.evidence_id,
            "evidence_type": self.evidence_type,
            "content": self.content,
            "timestamp": self.timestamp,
        }


@dataclass
class Proposal:
    """
    A governance proposal requiring review and approval.
    
    Every proposal has:
    - Lineage (parent proposal if any)
    - Evidence chain
    - Rollback path
    """
    
    proposal_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    proposal_type: ProposalType = ProposalType.GENERAL
    title: str = ""
    description: str = ""
    payload: Dict[str, Any] = field(default_factory=dict)
    status: ProposalStatus = ProposalStatus.DRAFT
    
    # Actors
    proposer: str = "system"
    reviewers: List[str] = field(default_factory=list)
    approver: Optional[str] = None
    
    # Lineage
    parent_proposal_id: Optional[str] = None
    rollback_proposal_id: Optional[str] = None
    
    # Evidence chain
    evidence: List[ProposalEvidence] = field(default_factory=list)
    
    # Gate records
    gate_records: List[str] = field(default_factory=list)  # Gate record IDs
    
    # Timestamps
    created_at: float = field(default_factory=time.time)
    submitted_at: Optional[float] = None
    resolved_at: Optional[float] = None
    executed_at: Optional[float] = None
    expires_at: Optional[float] = None
    
    # Execution
    execution_result: Optional[Dict[str, Any]] = None
    rollback_data: Optional[Dict[str, Any]] = None
    
    def add_evidence(self, evidence_type: str, content: Dict[str, Any]) -> ProposalEvidence:
        """Add evidence to the proposal."""
        evidence = ProposalEvidence(
            evidence_type=evidence_type,
            content=content,
        )
        self.evidence.append(evidence)
        return evidence
    
    def submit(self) -> None:
        """Submit proposal for review."""
        if self.status == ProposalStatus.DRAFT:
            self.status = ProposalStatus.PENDING
            self.submitted_at = time.time()
            # Set expiration (default 24 hours)
            if self.expires_at is None:
                self.expires_at = self.submitted_at + 86400
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "proposal_id": self.proposal_id,
            "proposal_type": self.proposal_type.value,
            "title": self.title,
            "description": self.description,
            "payload": self.payload,
            "status": self.status.value,
            "proposer": self.proposer,
            "reviewers": self.reviewers,
            "approver": self.approver,
            "parent_proposal_id": self.parent_proposal_id,
            "rollback_proposal_id": self.rollback_proposal_id,
            "evidence_count": len(self.evidence),
            "gate_records": self.gate_records,
            "created_at": self.created_at,
            "submitted_at": self.submitted_at,
            "resolved_at": self.resolved_at,
            "executed_at": self.executed_at,
            "expires_at": self.expires_at,
        }


# Execution function type
ExecutionFn = Callable[[Proposal], Dict[str, Any]]


class ProposalEngine:
    """
    Engine for managing governance proposals.
    
    Provides:
    - Proposal creation and submission
    - Review workflow
    - Execution with rollback capability
    - Evidence chain management
    """
    
    def __init__(self, gate_enforcer: Optional["GateEnforcer"] = None) -> None:
        self._proposals: Dict[str, Proposal] = {}
        self._gate_enforcer = gate_enforcer
        self._executors: Dict[ProposalType, ExecutionFn] = {}
        self._audit_log: List[Dict[str, Any]] = []
    
    def register_executor(self, proposal_type: ProposalType, executor: ExecutionFn) -> None:
        """Register an executor for a proposal type."""
        self._executors[proposal_type] = executor
    
    def create_proposal(
        self,
        proposal_type: ProposalType,
        title: str,
        description: str,
        payload: Dict[str, Any],
        proposer: str = "system",
        parent_proposal_id: Optional[str] = None,
    ) -> Proposal:
        """Create a new proposal."""
        proposal = Proposal(
            proposal_type=proposal_type,
            title=title,
            description=description,
            payload=payload,
            proposer=proposer,
            parent_proposal_id=parent_proposal_id,
        )
        
        self._proposals[proposal.proposal_id] = proposal
        
        self._audit_log.append({
            "event": "proposal_created",
            "proposal_id": proposal.proposal_id,
            "proposal_type": proposal_type.value,
            "proposer": proposer,
            "timestamp": time.time(),
        })
        
        return proposal
    
    def submit_proposal(self, proposal_id: str) -> bool:
        """Submit a proposal for review."""
        proposal = self._proposals.get(proposal_id)
        if proposal is None:
            return False
        
        proposal.submit()
        
        self._audit_log.append({
            "event": "proposal_submitted",
            "proposal_id": proposal_id,
            "timestamp": time.time(),
        })
        
        return True
    
    def get_proposal(self, proposal_id: str) -> Optional[Proposal]:
        """Get a proposal by ID."""
        return self._proposals.get(proposal_id)
    
    def list_proposals(
        self,
        status: Optional[ProposalStatus] = None,
        proposal_type: Optional[ProposalType] = None,
        proposer: Optional[str] = None,
        limit: int = 100,
    ) -> List[Proposal]:
        """List proposals with optional filters."""
        proposals = list(self._proposals.values())
        
        if status is not None:
            proposals = [p for p in proposals if p.status == status]
        
        if proposal_type is not None:
            proposals = [p for p in proposals if p.proposal_type == proposal_type]
        
        if proposer is not None:
            proposals = [p for p in proposals if p.proposer == proposer]
        
        # Sort by created_at descending
        proposals.sort(key=lambda p: p.created_at, reverse=True)
        
        return proposals[:limit]
    
    def add_evidence(
        self,
        proposal_id: str,
        evidence_type: str,
        content: Dict[str, Any],
    ) -> Optional[ProposalEvidence]:
        """Add evidence to a proposal."""
        proposal = self._proposals.get(proposal_id)
        if proposal is None:
            return None
        
        evidence = proposal.add_evidence(evidence_type, content)
        
        self._audit_log.append({
            "event": "evidence_added",
            "proposal_id": proposal_id,
            "evidence_id": evidence.evidence_id,
            "evidence_type": evidence_type,
            "timestamp": time.time(),
        })
        
        return evidence
    
    def check_expiration(self) -> List[Proposal]:
        """Check and expire overdue proposals."""
        now = time.time()
        expired: List[Proposal] = []
        
        for proposal in self._proposals.values():
            if (proposal.status == ProposalStatus.PENDING and
                proposal.expires_at and proposal.expires_at < now):
                proposal.status = ProposalStatus.EXPIRED
                proposal.resolved_at = now
                expired.append(proposal)
                
                self._audit_log.append({
                    "event": "proposal_expired",
                    "proposal_id": proposal.proposal_id,
                    "timestamp": now,
                })
        
        return expired
    
    def execute_proposal(
        self,
        proposal_id: str,
        actor: str = "system",
    ) -> Dict[str, Any]:
        """
        Execute an approved proposal.
        
        Returns execution result with rollback data.
        """
        proposal = self._proposals.get(proposal_id)
        if proposal is None:
            return {"success": False, "error": "Proposal not found"}
        
        if proposal.status != ProposalStatus.APPROVED:
            return {"success": False, "error": f"Proposal not approved: {proposal.status.value}"}
        
        # Check Gate A for runtime mutation
        if self._gate_enforcer and proposal.proposal_type == ProposalType.RUNTIME_MUTATION:
            from ..core.gates import GateLevel
            record = self._gate_enforcer.evaluate(
                GateLevel.A,
                f"execute_{proposal.proposal_type.value}",
                proposal.payload,
                actor,
            )
            proposal.gate_records.append(record.record_id)
            
            if record.decision.value != "PASS":
                return {
                    "success": False,
                    "error": f"Gate A denied: {record.reason}",
                    "gate_record": record.to_dict(),
                }
        
        # Get executor
        executor = self._executors.get(proposal.proposal_type)
        if executor is None:
            # Default executor just marks as executed
            result = {"status": "executed", "payload": proposal.payload}
        else:
            try:
                result = executor(proposal)
            except Exception as e:
                return {"success": False, "error": str(e)}
        
        # Store rollback data (the original state before execution)
        proposal.rollback_data = {
            "pre_execution_state": proposal.payload,
            "execution_result": result,
        }
        
        proposal.status = ProposalStatus.EXECUTED
        proposal.executed_at = time.time()
        proposal.execution_result = result
        
        self._audit_log.append({
            "event": "proposal_executed",
            "proposal_id": proposal_id,
            "actor": actor,
            "timestamp": time.time(),
        })
        
        return {"success": True, "result": result}
    
    def rollback_proposal(
        self,
        proposal_id: str,
        actor: str = "system",
        reason: str = "",
    ) -> Dict[str, Any]:
        """
        Rollback an executed proposal.
        
        Creates a new rollback proposal for audit trail.
        """
        proposal = self._proposals.get(proposal_id)
        if proposal is None:
            return {"success": False, "error": "Proposal not found"}
        
        if proposal.status != ProposalStatus.EXECUTED:
            return {"success": False, "error": f"Proposal not executed: {proposal.status.value}"}
        
        if proposal.rollback_data is None:
            return {"success": False, "error": "No rollback data available"}
        
        # Create rollback proposal
        rollback_proposal = self.create_proposal(
            proposal_type=proposal.proposal_type,
            title=f"Rollback: {proposal.title}",
            description=f"Rollback of proposal {proposal_id}. Reason: {reason}",
            payload=proposal.rollback_data.get("pre_execution_state", {}),
            proposer=actor,
            parent_proposal_id=proposal_id,
        )
        
        rollback_proposal.add_evidence("rollback_reason", {"reason": reason})
        rollback_proposal.add_evidence("original_execution", {
            "original_proposal_id": proposal_id,
            "execution_result": proposal.execution_result,
        })
        
        # Link proposals
        proposal.rollback_proposal_id = rollback_proposal.proposal_id
        proposal.status = ProposalStatus.ROLLED_BACK
        
        self._audit_log.append({
            "event": "proposal_rolled_back",
            "proposal_id": proposal_id,
            "rollback_proposal_id": rollback_proposal.proposal_id,
            "actor": actor,
            "reason": reason,
            "timestamp": time.time(),
        })
        
        return {
            "success": True,
            "rollback_proposal_id": rollback_proposal.proposal_id,
        }
    
    def get_lineage(self, proposal_id: str) -> List[Proposal]:
        """Get full lineage chain for a proposal."""
        chain: List[Proposal] = []
        current_id: Optional[str] = proposal_id
        
        while current_id and current_id in self._proposals:
            proposal = self._proposals[current_id]
            chain.insert(0, proposal)
            current_id = proposal.parent_proposal_id
        
        return chain
    
    def get_audit_log(
        self,
        event_type: Optional[str] = None,
        proposal_id: Optional[str] = None,
        limit: int = 100,
    ) -> List[Dict[str, Any]]:
        """Get audit log with optional filters."""
        logs = self._audit_log
        
        if event_type:
            logs = [l for l in logs if l.get("event") == event_type]
        
        if proposal_id:
            logs = [l for l in logs if l.get("proposal_id") == proposal_id]
        
        return logs[-limit:]
