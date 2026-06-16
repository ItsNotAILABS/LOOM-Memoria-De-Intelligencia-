"""
Governance Approval Tests — Workflow Validation
================================================
Tests for ApprovalEngine, ApprovalRecord, and approval workflows.
"""

import unittest
from nova_ovo.governance.approvals import (
    ApprovalEngine,
    ApprovalRecord,
    ApprovalDecision,
    ApprovalPolicy,
    ReviewerRole,
)
from nova_ovo.governance.proposals import (
    ProposalEngine,
    Proposal,
    ProposalType,
    ProposalStatus,
)
from nova_ovo.core.gates import GateEnforcer


class TestApprovalRecord(unittest.TestCase):
    """Test ApprovalRecord functionality."""
    
    def test_create_record(self):
        """Test creating an approval record."""
        record = ApprovalRecord(
            proposal_id="prop_123",
            reviewer="user_1",
            decision=ApprovalDecision.APPROVE,
            reason="LGTM",
        )
        
        self.assertEqual(record.proposal_id, "prop_123")
        self.assertEqual(record.reviewer, "user_1")
        self.assertEqual(record.decision, ApprovalDecision.APPROVE)
        self.assertIsNotNone(record.record_id)
    
    def test_record_with_conditions(self):
        """Test record with conditions."""
        record = ApprovalRecord(
            proposal_id="prop_123",
            reviewer="user_1",
            decision=ApprovalDecision.REQUEST_CHANGES,
            conditions=["Fix typo", "Add tests"],
        )
        
        self.assertEqual(len(record.conditions), 2)
    
    def test_to_dict(self):
        """Test serialization."""
        record = ApprovalRecord(
            proposal_id="prop_123",
            reviewer="admin",
            role=ReviewerRole.OWNER,
            decision=ApprovalDecision.APPROVE,
        )
        
        d = record.to_dict()
        
        self.assertEqual(d["proposal_id"], "prop_123")
        self.assertEqual(d["role"], "owner")
        self.assertEqual(d["decision"], "approve")


class TestApprovalPolicy(unittest.TestCase):
    """Test ApprovalPolicy functionality."""
    
    def test_create_policy(self):
        """Test creating a policy."""
        policy = ApprovalPolicy(
            name="strict",
            required_approvals=2,
            require_owner_approval=True,
        )
        
        self.assertEqual(policy.required_approvals, 2)
        self.assertTrue(policy.require_owner_approval)
    
    def test_default_values(self):
        """Test default policy values."""
        policy = ApprovalPolicy()
        
        self.assertEqual(policy.required_approvals, 1)
        self.assertFalse(policy.require_owner_approval)
        self.assertFalse(policy.allow_self_approval)
        self.assertTrue(policy.gate_required)
    
    def test_to_dict(self):
        """Test policy serialization."""
        policy = ApprovalPolicy(
            name="test",
            required_approvals=3,
        )
        
        d = policy.to_dict()
        
        self.assertEqual(d["name"], "test")
        self.assertEqual(d["required_approvals"], 3)


class TestApprovalEngine(unittest.TestCase):
    """Test ApprovalEngine functionality."""
    
    def setUp(self):
        self.proposal_engine = ProposalEngine()
        self.gate_enforcer = GateEnforcer()
        self.approval_engine = ApprovalEngine(
            proposal_engine=self.proposal_engine,
            gate_enforcer=self.gate_enforcer,
        )
    
    def test_create_engine(self):
        """Test creating approval engine."""
        engine = ApprovalEngine()
        self.assertIsNotNone(engine)
    
    def test_default_policy(self):
        """Test default policy retrieval."""
        policy = self.approval_engine.get_policy("any_type")
        
        self.assertEqual(policy.required_approvals, 1)
    
    def test_set_custom_policy(self):
        """Test setting custom policy."""
        custom_policy = ApprovalPolicy(
            name="strict",
            required_approvals=3,
        )
        
        self.approval_engine.set_policy("runtime", custom_policy)
        
        retrieved = self.approval_engine.get_policy("runtime")
        self.assertEqual(retrieved.required_approvals, 3)
    
    def test_submit_approval(self):
        """Test submitting an approval."""
        # Create and submit proposal
        proposal = self.proposal_engine.create_proposal(
            proposal_type=ProposalType.RUNTIME_MUTATION,
            title="Test Proposal",
            description="Test",
            proposer="user_1",
            payload={},
        )
        self.proposal_engine.submit_proposal(proposal.proposal_id)
        
        # Submit approval
        record = self.approval_engine.submit_decision(
            proposal_id=proposal.proposal_id,
            reviewer="reviewer_1",
            decision=ApprovalDecision.APPROVE,
            reason="Approved",
        )
        
        self.assertIsNotNone(record)
        self.assertEqual(record.decision, ApprovalDecision.APPROVE)
    
    def test_approval_resolves_proposal(self):
        """Test approval resolves proposal."""
        proposal = self.proposal_engine.create_proposal(
            proposal_type=ProposalType.RUNTIME_MUTATION,
            title="Test",
            description="Test",
            proposer="user_1",
            payload={},
        )
        self.proposal_engine.submit_proposal(proposal.proposal_id)
        
        self.approval_engine.submit_decision(
            proposal_id=proposal.proposal_id,
            reviewer="reviewer_1",
            decision=ApprovalDecision.APPROVE,
        )
        
        # Check proposal status
        updated = self.proposal_engine.get_proposal(proposal.proposal_id)
        self.assertEqual(updated.status, ProposalStatus.APPROVED)
    
    def test_rejection_resolves_proposal(self):
        """Test rejection resolves proposal."""
        proposal = self.proposal_engine.create_proposal(
            proposal_type=ProposalType.RUNTIME_MUTATION,
            title="Test",
            description="Test",
            proposer="user_1",
            payload={},
        )
        self.proposal_engine.submit_proposal(proposal.proposal_id)
        
        self.approval_engine.submit_decision(
            proposal_id=proposal.proposal_id,
            reviewer="reviewer_1",
            decision=ApprovalDecision.REJECT,
            reason="Not acceptable",
        )
        
        updated = self.proposal_engine.get_proposal(proposal.proposal_id)
        self.assertEqual(updated.status, ProposalStatus.REJECTED)
    
    def test_multiple_approvals_required(self):
        """Test multiple approvals required."""
        # Set policy requiring 2 approvals
        policy = ApprovalPolicy(
            name="multi",
            required_approvals=2,
        )
        self.approval_engine.set_policy("runtime_mutation", policy)
        
        proposal = self.proposal_engine.create_proposal(
            proposal_type=ProposalType.RUNTIME_MUTATION,
            title="Test",
            description="Test",
            proposer="user_1",
            payload={},
        )
        self.proposal_engine.submit_proposal(proposal.proposal_id)
        
        # First approval - should not resolve
        self.approval_engine.submit_decision(
            proposal_id=proposal.proposal_id,
            reviewer="reviewer_1",
            decision=ApprovalDecision.APPROVE,
        )
        
        updated = self.proposal_engine.get_proposal(proposal.proposal_id)
        self.assertEqual(updated.status, ProposalStatus.PENDING)
        
        # Second approval - should resolve
        self.approval_engine.submit_decision(
            proposal_id=proposal.proposal_id,
            reviewer="reviewer_2",
            decision=ApprovalDecision.APPROVE,
        )
        
        final = self.proposal_engine.get_proposal(proposal.proposal_id)
        self.assertEqual(final.status, ProposalStatus.APPROVED)
    
    def test_owner_approval_required(self):
        """Test owner approval requirement."""
        policy = ApprovalPolicy(
            name="owner_required",
            required_approvals=1,
            require_owner_approval=True,
        )
        self.approval_engine.set_policy("runtime_mutation", policy)
        
        proposal = self.proposal_engine.create_proposal(
            proposal_type=ProposalType.RUNTIME_MUTATION,
            title="Test",
            description="Test",
            proposer="user_1",
            payload={},
        )
        self.proposal_engine.submit_proposal(proposal.proposal_id)
        
        # Regular approval - should not resolve
        self.approval_engine.submit_decision(
            proposal_id=proposal.proposal_id,
            reviewer="reviewer_1",
            decision=ApprovalDecision.APPROVE,
            role=ReviewerRole.OPTIONAL,
        )
        
        updated = self.proposal_engine.get_proposal(proposal.proposal_id)
        self.assertEqual(updated.status, ProposalStatus.PENDING)
        
        # Owner approval - should resolve
        self.approval_engine.submit_decision(
            proposal_id=proposal.proposal_id,
            reviewer="owner_1",
            decision=ApprovalDecision.APPROVE,
            role=ReviewerRole.OWNER,
        )
        
        final = self.proposal_engine.get_proposal(proposal.proposal_id)
        self.assertEqual(final.status, ProposalStatus.APPROVED)
    
    def test_get_records(self):
        """Test getting approval records."""
        proposal = self.proposal_engine.create_proposal(
            proposal_type=ProposalType.RUNTIME_MUTATION,
            title="Test",
            description="Test",
            proposer="user_1",
            payload={},
        )
        self.proposal_engine.submit_proposal(proposal.proposal_id)
        
        self.approval_engine.submit_decision(
            proposal_id=proposal.proposal_id,
            reviewer="r1",
            decision=ApprovalDecision.APPROVE,
        )
        
        records = self.approval_engine.get_records(proposal.proposal_id)
        self.assertEqual(len(records), 1)
    
    def test_get_pending_approvals(self):
        """Test getting pending approvals for reviewer."""
        prop1 = self.proposal_engine.create_proposal(
            proposal_type=ProposalType.RUNTIME_MUTATION,
            title="Test1",
            description="Test",
            proposer="user_1",
            payload={},
        )
        self.proposal_engine.submit_proposal(prop1.proposal_id)
        
        prop2 = self.proposal_engine.create_proposal(
            proposal_type=ProposalType.RUNTIME_MUTATION,
            title="Test2",
            description="Test",
            proposer="user_1",
            payload={},
        )
        self.proposal_engine.submit_proposal(prop2.proposal_id)
        
        # Approve prop1 only
        self.approval_engine.submit_decision(
            proposal_id=prop1.proposal_id,
            reviewer="reviewer_1",
            decision=ApprovalDecision.APPROVE,
        )
        
        pending = self.approval_engine.get_pending_approvals("reviewer_1")
        
        # Only prop2 should be pending
        self.assertEqual(len(pending), 1)
        self.assertEqual(pending[0], prop2.proposal_id)
    
    def test_approval_status(self):
        """Test getting detailed approval status."""
        proposal = self.proposal_engine.create_proposal(
            proposal_type=ProposalType.RUNTIME_MUTATION,
            title="Test",
            description="Test",
            proposer="user_1",
            payload={},
        )
        self.proposal_engine.submit_proposal(proposal.proposal_id)
        
        self.approval_engine.submit_decision(
            proposal_id=proposal.proposal_id,
            reviewer="r1",
            decision=ApprovalDecision.APPROVE,
        )
        
        status = self.approval_engine.get_approval_status(proposal.proposal_id)
        
        self.assertEqual(status["approvals_received"], 1)
        self.assertEqual(status["rejections"], 0)
        self.assertIn("records", status)
    
    def test_audit_log(self):
        """Test audit log recording."""
        proposal = self.proposal_engine.create_proposal(
            proposal_type=ProposalType.RUNTIME_MUTATION,
            title="Test",
            description="Test",
            proposer="user_1",
            payload={},
        )
        self.proposal_engine.submit_proposal(proposal.proposal_id)
        
        self.approval_engine.submit_decision(
            proposal_id=proposal.proposal_id,
            reviewer="r1",
            decision=ApprovalDecision.APPROVE,
        )
        
        audit = self.approval_engine.get_audit_log()
        
        self.assertGreater(len(audit), 0)
        self.assertIn("event", audit[-1])
    
    def test_request_changes(self):
        """Test request changes decision."""
        proposal = self.proposal_engine.create_proposal(
            proposal_type=ProposalType.RUNTIME_MUTATION,
            title="Test",
            description="Test",
            proposer="user_1",
            payload={},
        )
        self.proposal_engine.submit_proposal(proposal.proposal_id)
        
        record = self.approval_engine.submit_decision(
            proposal_id=proposal.proposal_id,
            reviewer="r1",
            decision=ApprovalDecision.REQUEST_CHANGES,
            conditions=["Fix bug", "Add docs"],
        )
        
        self.assertIsNotNone(record)
        self.assertEqual(record.decision, ApprovalDecision.REQUEST_CHANGES)
        self.assertEqual(len(record.conditions), 2)
        
        # Should not resolve proposal
        updated = self.proposal_engine.get_proposal(proposal.proposal_id)
        self.assertEqual(updated.status, ProposalStatus.PENDING)
    
    def test_abstain(self):
        """Test abstain decision."""
        proposal = self.proposal_engine.create_proposal(
            proposal_type=ProposalType.RUNTIME_MUTATION,
            title="Test",
            description="Test",
            proposer="user_1",
            payload={},
        )
        self.proposal_engine.submit_proposal(proposal.proposal_id)
        
        record = self.approval_engine.submit_decision(
            proposal_id=proposal.proposal_id,
            reviewer="r1",
            decision=ApprovalDecision.ABSTAIN,
        )
        
        self.assertEqual(record.decision, ApprovalDecision.ABSTAIN)


class TestApprovalDecisions(unittest.TestCase):
    """Test approval decision types."""
    
    def test_all_decisions_exist(self):
        """Test all decision types exist."""
        decisions = [
            ApprovalDecision.APPROVE,
            ApprovalDecision.REJECT,
            ApprovalDecision.REQUEST_CHANGES,
            ApprovalDecision.ABSTAIN,
        ]
        
        self.assertEqual(len(decisions), 4)
    
    def test_decision_values(self):
        """Test decision string values."""
        self.assertEqual(ApprovalDecision.APPROVE.value, "approve")
        self.assertEqual(ApprovalDecision.REJECT.value, "reject")


class TestReviewerRoles(unittest.TestCase):
    """Test reviewer role types."""
    
    def test_all_roles_exist(self):
        """Test all roles exist."""
        roles = [
            ReviewerRole.REQUIRED,
            ReviewerRole.OPTIONAL,
            ReviewerRole.OWNER,
        ]
        
        self.assertEqual(len(roles), 3)


if __name__ == "__main__":
    unittest.main()
