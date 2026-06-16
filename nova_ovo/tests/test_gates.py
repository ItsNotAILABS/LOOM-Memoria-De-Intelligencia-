"""
Gate Enforcement Tests — A/B/C Boundary Validation
====================================================
Tests for GateEnforcer, GateRecord, and policy functions.
"""

import unittest
from nova_ovo.core.gates import (
    GateEnforcer,
    GateLevel,
    GateDecision,
    GateRecord,
    PolicyFn,
)


class TestGateRecord(unittest.TestCase):
    """Test GateRecord functionality."""
    
    def test_create_record(self):
        """Test creating a gate record."""
        record = GateRecord(
            gate=GateLevel.A,
            decision=GateDecision.PASS,
            action_type="test_action",
            reason="test reason",
        )
        
        self.assertEqual(record.gate, GateLevel.A)
        self.assertEqual(record.decision, GateDecision.PASS)
        self.assertIsNotNone(record.record_id)
        self.assertIsNotNone(record.timestamp)
    
    def test_record_to_dict(self):
        """Test record serialization."""
        record = GateRecord(
            gate=GateLevel.B,
            decision=GateDecision.DENY,
            action_type="blocked_action",
            actor="test_user",
            reason="policy violation",
        )
        
        d = record.to_dict()
        
        self.assertEqual(d["gate"], "B")
        self.assertEqual(d["decision"], "DENY")
        self.assertEqual(d["action_type"], "blocked_action")
        self.assertEqual(d["actor"], "test_user")
        self.assertEqual(d["reason"], "policy violation")


class TestGateEnforcer(unittest.TestCase):
    """Test GateEnforcer functionality."""
    
    def setUp(self):
        self.enforcer = GateEnforcer()
    
    def test_default_gate_a_passes(self):
        """Test default Gate A policy passes."""
        record = self.enforcer.evaluate(
            GateLevel.A,
            "runtime_write",
            {"key": "value"},
        )
        
        self.assertEqual(record.decision, GateDecision.PASS)
    
    def test_default_gate_b_passes(self):
        """Test default Gate B policy passes."""
        record = self.enforcer.evaluate(
            GateLevel.B,
            "workforce_action",
            {"task": "execute"},
        )
        
        self.assertEqual(record.decision, GateDecision.PASS)
    
    def test_default_gate_c_passes_clean_payload(self):
        """Test Gate C passes clean payload."""
        record = self.enforcer.evaluate(
            GateLevel.C,
            "projection",
            {"public_data": "safe"},
        )
        
        self.assertEqual(record.decision, GateDecision.PASS)
    
    def test_gate_c_denies_sovereign_keys(self):
        """Test Gate C denies sovereign key leaks."""
        record = self.enforcer.evaluate(
            GateLevel.C,
            "projection",
            {"doctrine_core": "leaked"},
        )
        
        self.assertEqual(record.decision, GateDecision.DENY)
        self.assertIn("leak", record.reason.lower())
    
    def test_gate_c_denies_multiple_forbidden_keys(self):
        """Test Gate C denies multiple forbidden keys."""
        record = self.enforcer.evaluate(
            GateLevel.C,
            "projection",
            {
                "sovereign_key": "secret",
                "gate_a_secret": "hidden",
                "public": "ok",
            },
        )
        
        self.assertEqual(record.decision, GateDecision.DENY)

    def test_gate_c_denies_nested_sovereign_keys(self):
        """Test Gate C denies nested sovereign key leaks."""
        record = self.enforcer.evaluate(
            GateLevel.C,
            "projection",
            {"public": {"ok": True, "doctrine_core": "leaked"}},
        )
        self.assertEqual(record.decision, GateDecision.DENY)

    def test_gate_c_denies_obfuscated_sovereign_keys(self):
        """Test Gate C denies obfuscated sovereign key leaks (zero-width, BOM)."""
        record = self.enforcer.evaluate(
            GateLevel.C,
            "projection",
            {"public": {"doctrine\u200b_core": "leaked"}},
        )
        self.assertEqual(record.decision, GateDecision.DENY)
    
    def test_custom_policy(self):
        """Test setting custom policy."""
        def strict_policy(action_type: str, payload: dict) -> tuple:
            if "dangerous" in str(payload):
                return GateDecision.DENY, "dangerous payload detected"
            return GateDecision.PASS, "safe"
        
        self.enforcer.set_policy(GateLevel.A, strict_policy)
        
        # Safe payload passes
        record1 = self.enforcer.evaluate(GateLevel.A, "test", {"safe": True})
        self.assertEqual(record1.decision, GateDecision.PASS)
        
        # Dangerous payload denied
        record2 = self.enforcer.evaluate(GateLevel.A, "test", {"dangerous": True})
        self.assertEqual(record2.decision, GateDecision.DENY)
    
    def test_hold_decision(self):
        """Test HOLD decision from custom policy."""
        def approval_required(action_type: str, payload: dict) -> tuple:
            if payload.get("requires_approval"):
                return GateDecision.HOLD, "awaiting approval"
            return GateDecision.PASS, "auto-approved"
        
        self.enforcer.set_policy(GateLevel.B, approval_required)
        
        record = self.enforcer.evaluate(
            GateLevel.B,
            "proposal",
            {"requires_approval": True},
        )
        
        self.assertEqual(record.decision, GateDecision.HOLD)
        self.assertIn("approval", record.reason)
    
    def test_require_pass_succeeds(self):
        """Test require_pass succeeds on PASS."""
        record = self.enforcer.require_pass(
            GateLevel.A,
            "safe_action",
            {"ok": True},
        )
        
        self.assertEqual(record.decision, GateDecision.PASS)
    
    def test_require_pass_raises_on_deny(self):
        """Test require_pass raises on DENY."""
        with self.assertRaises(RuntimeError) as context:
            self.enforcer.require_pass(
                GateLevel.C,
                "leak",
                {"doctrine_core": "secret"},
            )
        
        self.assertIn("DENY", str(context.exception))
    
    def test_require_pass_raises_on_hold(self):
        """Test require_pass raises on HOLD."""
        def hold_policy(action: str, payload: dict) -> tuple:
            return GateDecision.HOLD, "pending"
        
        self.enforcer.set_policy(GateLevel.A, hold_policy)
        
        with self.assertRaises(RuntimeError) as context:
            self.enforcer.require_pass(GateLevel.A, "test", {})
        
        self.assertIn("HOLD", str(context.exception))
    
    def test_log_recording(self):
        """Test all evaluations logged."""
        self.enforcer.evaluate(GateLevel.A, "action1", {})
        self.enforcer.evaluate(GateLevel.B, "action2", {})
        self.enforcer.evaluate(GateLevel.C, "action3", {"public": True})
        
        log = self.enforcer.get_log()
        
        self.assertEqual(len(log), 3)
    
    def test_log_filtering_by_gate(self):
        """Test log filtering by gate."""
        self.enforcer.evaluate(GateLevel.A, "a1", {})
        self.enforcer.evaluate(GateLevel.B, "b1", {})
        self.enforcer.evaluate(GateLevel.A, "a2", {})
        
        gate_a_log = self.enforcer.get_log(gate=GateLevel.A)
        
        self.assertEqual(len(gate_a_log), 2)
        self.assertTrue(all(r.gate == GateLevel.A for r in gate_a_log))
    
    def test_log_filtering_by_decision(self):
        """Test log filtering by decision."""
        self.enforcer.evaluate(GateLevel.C, "pass1", {"ok": True})
        self.enforcer.evaluate(GateLevel.C, "deny1", {"doctrine_core": "x"})
        self.enforcer.evaluate(GateLevel.C, "pass2", {"ok": True})
        
        deny_log = self.enforcer.get_log(decision=GateDecision.DENY)
        
        self.assertEqual(len(deny_log), 1)
        self.assertEqual(deny_log[0].decision, GateDecision.DENY)
    
    def test_audit_summary(self):
        """Test audit summary generation."""
        self.enforcer.evaluate(GateLevel.A, "a1", {})
        self.enforcer.evaluate(GateLevel.B, "b1", {})
        self.enforcer.evaluate(GateLevel.C, "deny", {"sovereign_key": "x"})
        
        summary = self.enforcer.audit_summary()
        
        self.assertIn("A", summary)
        self.assertIn("B", summary)
        self.assertIn("C", summary)
        self.assertEqual(summary["A"]["PASS"], 1)
        self.assertEqual(summary["C"]["DENY"], 1)
    
    def test_policy_error_handling(self):
        """Test policy errors result in DENY."""
        def error_policy(action: str, payload: dict) -> tuple:
            raise ValueError("Policy error!")
        
        self.enforcer.set_policy(GateLevel.A, error_policy)
        
        record = self.enforcer.evaluate(GateLevel.A, "test", {})
        
        self.assertEqual(record.decision, GateDecision.DENY)
        self.assertIn("error", record.reason.lower())
    
    def test_payload_summary_truncation(self):
        """Test payload summary is truncated."""
        long_payload = {"key": "x" * 100}
        
        record = self.enforcer.evaluate(GateLevel.A, "test", long_payload)
        
        self.assertTrue(len(record.payload_summary) < 100)


class TestGatePolicies(unittest.TestCase):
    """Test specific gate policies."""
    
    def test_gate_c_case_insensitive(self):
        """Test Gate C key detection is case insensitive."""
        enforcer = GateEnforcer()
        
        # Test various cases
        cases = [
            {"DOCTRINE_CORE": "x"},
            {"Sovereign_Key": "x"},
            {"GATE_A_SECRET": "x"},
            {"Core_B_Internal": "x"},
        ]
        
        for payload in cases:
            record = enforcer.evaluate(GateLevel.C, "test", payload)
            self.assertEqual(
                record.decision, GateDecision.DENY,
                f"Should deny: {payload}"
            )
    
    def test_all_gate_levels_exist(self):
        """Test all three gate levels exist."""
        self.assertEqual(GateLevel.A.value, "A")
        self.assertEqual(GateLevel.B.value, "B")
        self.assertEqual(GateLevel.C.value, "C")
    
    def test_all_decisions_exist(self):
        """Test all decision types exist."""
        self.assertEqual(GateDecision.PASS.value, "PASS")
        self.assertEqual(GateDecision.HOLD.value, "HOLD")
        self.assertEqual(GateDecision.DENY.value, "DENY")


if __name__ == "__main__":
    unittest.main()
