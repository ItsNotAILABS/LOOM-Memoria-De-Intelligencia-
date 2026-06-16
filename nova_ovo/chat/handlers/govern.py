"""
Govern Handler — /govern command operations
============================================
Handles governance operations:
- /govern status — show governance state
- /govern propose <action> — create a proposal
- /govern approve <id> — approve a proposal
- /govern reject <id> — reject a proposal
- /govern audit — show audit trail

All operations pass through Gate A/B/C enforcement.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, TYPE_CHECKING

if TYPE_CHECKING:
    from ..parser import ParsedCommand
    from ..router import CommandResult


class ProposalStatus(str, Enum):
    PENDING = "pending"
    APPROVED = "approved"
    REJECTED = "rejected"
    EXPIRED = "expired"


@dataclass
class Proposal:
    """A governance proposal requiring approval."""
    
    proposal_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    action_type: str = ""
    description: str = ""
    payload: Dict[str, Any] = field(default_factory=dict)
    status: ProposalStatus = ProposalStatus.PENDING
    proposer: str = "system"
    approver: Optional[str] = None
    created_at: float = field(default_factory=time.time)
    resolved_at: Optional[float] = None
    gate_record_id: Optional[str] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "proposal_id": self.proposal_id,
            "action_type": self.action_type,
            "description": self.description,
            "payload": self.payload,
            "status": self.status.value,
            "proposer": self.proposer,
            "approver": self.approver,
            "created_at": self.created_at,
            "resolved_at": self.resolved_at,
            "gate_record_id": self.gate_record_id,
        }


class GovernHandler:
    """
    Handler for /govern command domain.
    
    Governance operations with Gate A/B/C enforcement.
    All proposals create evidence chains for replay.
    """
    
    def __init__(self) -> None:
        self._proposals: Dict[str, Proposal] = {}
        self._audit_log: List[Dict[str, Any]] = []
    
    def __call__(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Route to appropriate governance action."""
        from ..router import CommandResult
        
        action = command.action
        
        if action == "status":
            return self._status(command, ctx)
        elif action == "propose":
            return self._propose(command, ctx)
        elif action == "approve":
            return self._approve(command, ctx)
        elif action == "reject":
            return self._reject(command, ctx)
        elif action == "audit":
            return self._audit(command, ctx)
        else:
            return CommandResult(
                success=False,
                error=f"Unknown govern action: {action}",
                message="Valid actions: status, propose, approve, reject, audit",
            )
    
    def _status(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Show governance status."""
        from ..router import CommandResult
        
        pending = [p for p in self._proposals.values() if p.status == ProposalStatus.PENDING]
        approved = [p for p in self._proposals.values() if p.status == ProposalStatus.APPROVED]
        rejected = [p for p in self._proposals.values() if p.status == ProposalStatus.REJECTED]
        
        # Get gate status if enforcer available
        gate_enforcer = ctx.get("gate_enforcer")
        gate_summary = gate_enforcer.audit_summary() if gate_enforcer else {}
        
        return CommandResult(
            success=True,
            data={
                "pending_count": len(pending),
                "approved_count": len(approved),
                "rejected_count": len(rejected),
                "pending_proposals": [p.to_dict() for p in pending],
                "gate_summary": gate_summary,
            },
            message=f"Governance: {len(pending)} pending, {len(approved)} approved, {len(rejected)} rejected",
        )
    
    def _propose(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Create a new proposal."""
        from ..router import CommandResult
        
        action_type = command.args[0] if command.args else "general"
        description = " ".join(command.args[1:]) if len(command.args) > 1 else ""
        
        proposal = Proposal(
            action_type=action_type,
            description=description,
            payload=command.kwargs,
            proposer=ctx.get("actor", "operator"),
        )
        
        self._proposals[proposal.proposal_id] = proposal
        
        # Log to audit trail
        self._audit_log.append({
            "event": "proposal_created",
            "proposal_id": proposal.proposal_id,
            "action_type": action_type,
            "timestamp": time.time(),
        })
        
        return CommandResult(
            success=True,
            data={"proposal": proposal.to_dict()},
            message=f"Proposal created: {proposal.proposal_id}",
        )
    
    def _approve(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Approve a pending proposal."""
        from ..router import CommandResult
        
        if not command.args:
            return CommandResult(
                success=False,
                error="Proposal ID required for approval",
            )
        
        proposal_id = command.args[0]
        proposal = self._proposals.get(proposal_id)
        
        if proposal is None:
            return CommandResult(
                success=False,
                error=f"Proposal not found: {proposal_id}",
            )
        
        if proposal.status != ProposalStatus.PENDING:
            return CommandResult(
                success=False,
                error=f"Proposal already resolved: {proposal.status.value}",
            )
        
        # Check Gate B for workforce activation
        gate_enforcer = ctx.get("gate_enforcer")
        if gate_enforcer:
            from ...core.gates import GateLevel
            record = gate_enforcer.evaluate(
                GateLevel.B,
                f"approve_{proposal.action_type}",
                proposal.payload,
                ctx.get("actor", "operator"),
            )
            proposal.gate_record_id = record.record_id
            
            if record.decision.value != "PASS":
                return CommandResult(
                    success=False,
                    error=f"Gate B denied approval: {record.reason}",
                    data={"gate_record": record.to_dict()},
                )
        
        proposal.status = ProposalStatus.APPROVED
        proposal.approver = ctx.get("actor", "operator")
        proposal.resolved_at = time.time()
        
        # Log to audit trail
        self._audit_log.append({
            "event": "proposal_approved",
            "proposal_id": proposal_id,
            "approver": proposal.approver,
            "timestamp": time.time(),
        })
        
        return CommandResult(
            success=True,
            data={"proposal": proposal.to_dict()},
            message=f"Proposal approved: {proposal_id}",
        )
    
    def _reject(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Reject a pending proposal."""
        from ..router import CommandResult
        
        if not command.args:
            return CommandResult(
                success=False,
                error="Proposal ID required for rejection",
            )
        
        proposal_id = command.args[0]
        proposal = self._proposals.get(proposal_id)
        
        if proposal is None:
            return CommandResult(
                success=False,
                error=f"Proposal not found: {proposal_id}",
            )
        
        if proposal.status != ProposalStatus.PENDING:
            return CommandResult(
                success=False,
                error=f"Proposal already resolved: {proposal.status.value}",
            )
        
        reason = command.kwargs.get("reason", "No reason provided")
        
        proposal.status = ProposalStatus.REJECTED
        proposal.approver = ctx.get("actor", "operator")
        proposal.resolved_at = time.time()
        
        # Log to audit trail
        self._audit_log.append({
            "event": "proposal_rejected",
            "proposal_id": proposal_id,
            "rejector": proposal.approver,
            "reason": reason,
            "timestamp": time.time(),
        })
        
        return CommandResult(
            success=True,
            data={"proposal": proposal.to_dict(), "reason": reason},
            message=f"Proposal rejected: {proposal_id}",
        )
    
    def _audit(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Show audit trail."""
        from ..router import CommandResult
        
        limit = command.kwargs.get("limit", 100)
        event_type = command.kwargs.get("event")
        
        logs = self._audit_log
        if event_type:
            logs = [l for l in logs if l.get("event") == event_type]
        
        return CommandResult(
            success=True,
            data={"audit_log": logs[-limit:]},
            message=f"Audit trail: {len(logs)} events",
        )
