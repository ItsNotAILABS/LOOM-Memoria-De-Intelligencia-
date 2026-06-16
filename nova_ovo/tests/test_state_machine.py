"""
State Machine Contract Tests — Transition Validity
===================================================
Tests for state machine contracts and transition enforcement.
"""

import unittest
from nova_ovo.workspace import (
    StateMachineContract,
    StateDefinition,
    Transition,
    TransitionGuard,
    TransitionEvent,
    MachineState,
    create_document_lifecycle_contract,
    create_kernel_lifecycle_contract,
    create_workforce_task_contract,
)


class TestStateMachineContract(unittest.TestCase):
    """Test state machine contract functionality."""
    
    def test_create_contract(self):
        """Test creating a basic contract."""
        contract = StateMachineContract(
            name="Test Contract",
            contract_type="document",
        )
        
        self.assertIsNotNone(contract.contract_id)
        self.assertEqual(contract.name, "Test Contract")
        self.assertTrue(contract.is_active)
    
    def test_add_states(self):
        """Test adding states to contract."""
        contract = StateMachineContract(name="Test")
        
        contract.add_state("draft", "initial", "Draft state")
        contract.add_state("active", "standard", "Active state")
        contract.add_state("archived", "terminal", "Archived state")
        
        self.assertEqual(len(contract.states), 3)
        self.assertEqual(contract.initial_state, "draft")
        self.assertEqual(contract.current_state, "draft")
        self.assertIn("archived", contract.terminal_states)
    
    def test_add_transitions(self):
        """Test adding transitions."""
        contract = StateMachineContract(name="Test")
        contract.add_state("draft", "initial")
        contract.add_state("active", "standard")
        
        contract.add_transition("activate", "draft", "active")
        
        self.assertEqual(len(contract.transitions), 1)
    
    def test_execute_transition(self):
        """Test executing a transition."""
        contract = StateMachineContract(name="Test")
        contract.add_state("draft", "initial")
        contract.add_state("active", "standard")
        contract.add_transition("activate", "draft", "active")
        
        success, event = contract.execute_transition("activate")
        
        self.assertTrue(success)
        self.assertEqual(contract.current_state, "active")
        self.assertEqual(event.from_state, "draft")
        self.assertEqual(event.to_state, "active")
    
    def test_invalid_transition(self):
        """Test that invalid transitions fail."""
        contract = StateMachineContract(name="Test")
        contract.add_state("draft", "initial")
        contract.add_state("active", "standard")
        contract.add_transition("activate", "draft", "active")
        
        # Execute valid transition first
        contract.execute_transition("activate")
        
        # Try to execute same transition from wrong state
        success, event = contract.execute_transition("activate")
        
        self.assertFalse(success)
        self.assertEqual(contract.current_state, "active")  # Unchanged
    
    def test_transition_guards(self):
        """Test transition guards."""
        contract = StateMachineContract(name="Test")
        contract.add_state("draft", "initial")
        contract.add_state("review", "standard")
        
        # Add guard requiring content
        guard = TransitionGuard(
            name="has_content",
            guard_type="condition",
            condition_field="has_content",
            condition_operator="eq",
            condition_value=True,
        )
        
        contract.add_transition(
            "submit",
            "draft",
            "review",
            guards=[guard],
        )
        
        # Try without content
        success, event = contract.execute_transition(
            "submit",
            context={"has_content": False},
        )
        self.assertFalse(success)
        
        # Try with content
        success, event = contract.execute_transition(
            "submit",
            context={"has_content": True},
        )
        self.assertTrue(success)
    
    def test_evidence_trail(self):
        """Test that transitions create evidence trail."""
        contract = StateMachineContract(name="Test")
        contract.add_state("draft", "initial")
        contract.add_state("active", "standard")
        contract.add_transition("activate", "draft", "active")
        
        contract.execute_transition("activate", actor_id="user_1", beat=1)
        
        self.assertEqual(len(contract.history), 1)
        event = contract.history[0]
        self.assertEqual(event.actor_id, "user_1")
        self.assertEqual(event.beat, 1)
        self.assertTrue(event.success)
    
    def test_terminal_state_detection(self):
        """Test terminal state detection."""
        contract = StateMachineContract(name="Test")
        contract.add_state("active", "initial")
        contract.add_state("completed", "terminal")
        contract.add_transition("complete", "active", "completed")
        
        self.assertFalse(contract.is_in_terminal_state())
        
        contract.execute_transition("complete")
        
        self.assertTrue(contract.is_in_terminal_state())


class TestDocumentLifecycleContract(unittest.TestCase):
    """Test document lifecycle contract template."""
    
    def test_create_document_contract(self):
        """Test creating document lifecycle contract."""
        contract = create_document_lifecycle_contract("doc_123", "Test Doc")
        
        self.assertEqual(contract.bound_entity_id, "doc_123")
        self.assertEqual(contract.contract_type, "document")
        self.assertEqual(contract.current_state, "draft")
    
    def test_document_workflow(self):
        """Test complete document workflow."""
        contract = create_document_lifecycle_contract("doc_123")
        
        # Draft -> Review
        success, _ = contract.execute_transition("submit_for_review")
        self.assertTrue(success)
        self.assertEqual(contract.current_state, "review")
        
        # Review -> Approved
        success, _ = contract.execute_transition(
            "approve",
            actor_role="approver",
        )
        self.assertTrue(success)
        self.assertEqual(contract.current_state, "approved")
        
        # Approved -> Active
        success, _ = contract.execute_transition("activate")
        self.assertTrue(success)
        self.assertEqual(contract.current_state, "active")
        
        # Active -> Archived
        success, _ = contract.execute_transition("archive")
        self.assertTrue(success)
        self.assertEqual(contract.current_state, "archived")
        
        # Verify terminal state
        self.assertTrue(contract.is_in_terminal_state())


class TestKernelLifecycleContract(unittest.TestCase):
    """Test kernel lifecycle contract template."""
    
    def test_create_kernel_contract(self):
        """Test creating kernel lifecycle contract."""
        contract = create_kernel_lifecycle_contract("kernel_123")
        
        self.assertEqual(contract.bound_entity_id, "kernel_123")
        self.assertEqual(contract.contract_type, "kernel")
        self.assertEqual(contract.current_state, "uncompressed")
    
    def test_kernel_compression_workflow(self):
        """Test kernel compression workflow."""
        contract = create_kernel_lifecycle_contract("kernel_123")
        
        # Uncompressed -> Compressing
        success, _ = contract.execute_transition("compress")
        self.assertTrue(success)
        
        # Compressing -> Compressed
        success, _ = contract.execute_transition("compression_complete")
        self.assertTrue(success)
        self.assertEqual(contract.current_state, "compressed")
    
    def test_kernel_expansion_workflow(self):
        """Test kernel expansion workflow."""
        contract = create_kernel_lifecycle_contract("kernel_123")
        
        # Get to compressed state
        contract.execute_transition("compress")
        contract.execute_transition("compression_complete")
        
        # Compressed -> Expanding
        success, _ = contract.execute_transition("expand")
        self.assertTrue(success)
        
        # Expanding -> Executing
        success, _ = contract.execute_transition("expansion_complete")
        self.assertTrue(success)
        self.assertEqual(contract.current_state, "executing")
        
        # Executing -> Compressed
        success, _ = contract.execute_transition("execution_complete")
        self.assertTrue(success)
        self.assertEqual(contract.current_state, "compressed")


class TestWorkforceTaskContract(unittest.TestCase):
    """Test workforce task contract template."""
    
    def test_create_task_contract(self):
        """Test creating task contract."""
        contract = create_workforce_task_contract("task_123", "Test Task")
        
        self.assertEqual(contract.bound_entity_id, "task_123")
        self.assertEqual(contract.contract_type, "workforce")
        self.assertEqual(contract.current_state, "idle")
    
    def test_task_success_workflow(self):
        """Test successful task workflow."""
        contract = create_workforce_task_contract("task_123")
        
        contract.execute_transition("assign")
        self.assertEqual(contract.current_state, "assigned")
        
        contract.execute_transition("start")
        self.assertEqual(contract.current_state, "in_progress")
        
        contract.execute_transition("complete")
        self.assertEqual(contract.current_state, "completed")
        
        self.assertTrue(contract.is_in_terminal_state())
    
    def test_task_failure_and_retry(self):
        """Test task failure and retry."""
        contract = create_workforce_task_contract("task_123")
        
        contract.execute_transition("assign")
        contract.execute_transition("start")
        contract.execute_transition("fail")
        self.assertEqual(contract.current_state, "failed")
        
        # Retry
        contract.execute_transition("retry")
        self.assertEqual(contract.current_state, "idle")


if __name__ == "__main__":
    unittest.main()
