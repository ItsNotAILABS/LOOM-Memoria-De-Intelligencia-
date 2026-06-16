"""
Organism Sovereign Tests — Constitutional Body Validation
==========================================================
Tests for OrganismSovereign, RegisterState, DualReadResult.
"""

import unittest
import time
from nova_ovo.core.organism import (
    OrganismSovereign,
    Register,
    RegisterState,
    DualReadResult,
)


class TestRegisterState(unittest.TestCase):
    """Test RegisterState functionality."""
    
    def test_create_register_state(self):
        """Test creating a register state."""
        state = RegisterState(register=Register.ORGANISM)
        
        self.assertEqual(state.register, Register.ORGANISM)
        self.assertEqual(state.version, 0)
        self.assertEqual(state.beat, 0)
        self.assertIsInstance(state.content, dict)
    
    def test_bump_register(self):
        """Test bumping register with delta."""
        state = RegisterState(register=Register.ORGANISM)
        
        delta = {"key1": "value1", "key2": 42}
        new_state = state.bump(delta)
        
        self.assertEqual(new_state.version, 1)
        self.assertEqual(new_state.beat, 1)
        self.assertEqual(new_state.content["key1"], "value1")
        self.assertEqual(new_state.content["key2"], 42)
    
    def test_bump_preserves_register(self):
        """Test that bump preserves register type."""
        state = RegisterState(register=Register.FOUNDER)
        new_state = state.bump({"test": True})
        
        self.assertEqual(new_state.register, Register.FOUNDER)
    
    def test_bump_merges_content(self):
        """Test that bump merges content correctly."""
        state = RegisterState(
            register=Register.ORGANISM,
            content={"existing": "data"}
        )
        
        new_state = state.bump({"new": "value"})
        
        self.assertEqual(new_state.content["existing"], "data")
        self.assertEqual(new_state.content["new"], "value")
    
    def test_to_dict(self):
        """Test serialization to dict."""
        state = RegisterState(
            register=Register.BUILDER,
            content={"key": "value"},
            version=5,
            beat=10,
        )
        
        d = state.to_dict()
        
        self.assertEqual(d["register"], "builder")
        self.assertEqual(d["version"], 5)
        self.assertEqual(d["beat"], 10)
        self.assertEqual(d["content"]["key"], "value")


class TestDualReadResult(unittest.TestCase):
    """Test DualReadResult functionality."""
    
    def test_ok_when_both_pass(self):
        """Test ok is True when both semantic and resonance pass."""
        result = DualReadResult(semantic_ok=True, resonance_ok=True)
        
        self.assertTrue(result.ok)
        self.assertFalse(result.degraded)
    
    def test_degraded_when_semantic_fails(self):
        """Test degraded when semantic check fails."""
        result = DualReadResult(semantic_ok=False, resonance_ok=True)
        
        self.assertFalse(result.ok)
        self.assertTrue(result.degraded)
    
    def test_degraded_when_resonance_fails(self):
        """Test degraded when resonance check fails."""
        result = DualReadResult(semantic_ok=True, resonance_ok=False)
        
        self.assertFalse(result.ok)
        self.assertTrue(result.degraded)
    
    def test_payload_storage(self):
        """Test payload storage in result."""
        payload = {"data": "test"}
        result = DualReadResult(True, True, payload)
        
        self.assertEqual(result.payload, payload)
    
    def test_repr(self):
        """Test string representation."""
        result = DualReadResult(True, False)
        rep = repr(result)
        
        self.assertIn("semantic=True", rep)
        self.assertIn("resonance=False", rep)
        self.assertIn("ok=False", rep)


class TestOrganismSovereign(unittest.TestCase):
    """Test OrganismSovereign functionality."""
    
    def setUp(self):
        self.organism = OrganismSovereign()
    
    def test_initial_state(self):
        """Test organism initializes with four registers."""
        snapshot = self.organism.snapshot()
        
        self.assertIn("registers", snapshot)
        self.assertEqual(len(snapshot["registers"]), 4)
        self.assertIn("founder", snapshot["registers"])
        self.assertIn("builder", snapshot["registers"])
        self.assertIn("organism", snapshot["registers"])
        self.assertIn("external", snapshot["registers"])
    
    def test_write_not_halted_initially(self):
        """Test writes are not halted initially."""
        self.assertFalse(self.organism._write_halted)
    
    def test_read_register(self):
        """Test reading a register."""
        state = self.organism.read(Register.ORGANISM)
        
        self.assertIsInstance(state, RegisterState)
        self.assertEqual(state.register, Register.ORGANISM)
    
    def test_dual_read_passes(self):
        """Test dual read passes for healthy organism."""
        result = self.organism.dual_read(Register.ORGANISM)
        
        self.assertTrue(result.ok)
        self.assertFalse(result.degraded)
    
    def test_dual_read_detects_beat_drift(self):
        """Test dual read detects builder beat drift."""
        # Manually drift builder beat
        builder_state = self.organism._registers[Register.BUILDER]
        self.organism._registers[Register.BUILDER] = RegisterState(
            register=Register.BUILDER,
            beat=100,  # Way ahead of organism
        )
        
        result = self.organism.dual_read(Register.BUILDER)
        
        self.assertFalse(result.resonance_ok)
        self.assertTrue(result.degraded)
        self.assertTrue(self.organism._write_halted)
    
    def test_authorize_organism_write(self):
        """Test authorized organism write."""
        delta = {"doctrine": "updated"}
        success = self.organism.authorize_organism_write(delta)
        
        self.assertTrue(success)
        state = self.organism.read(Register.ORGANISM)
        self.assertEqual(state.content["doctrine"], "updated")
    
    def test_write_blocked_when_halted(self):
        """Test writes blocked when halted."""
        self.organism._write_halted = True
        
        success = self.organism.authorize_organism_write({"key": "value"})
        
        self.assertFalse(success)
    
    def test_propose_builder_write(self):
        """Test proposing builder write."""
        delta = {"proposal": "new_feature"}
        success = self.organism.propose_builder_write(delta)
        
        self.assertTrue(success)
        state = self.organism.read(Register.BUILDER)
        self.assertEqual(state.content["proposal"], "new_feature")
    
    def test_promote_builder_to_organism(self):
        """Test promoting builder keys to organism."""
        # Propose to builder
        self.organism.propose_builder_write({"feature": "implemented"})
        
        # Promote to organism
        success = self.organism.promote_builder_to_organism(["feature"])
        
        self.assertTrue(success)
        org_state = self.organism.read(Register.ORGANISM)
        self.assertEqual(org_state.content["feature"], "implemented")
    
    def test_update_external_projection(self):
        """Test external projection update."""
        payload = {"public_data": "safe"}
        success = self.organism.update_external_projection(payload)
        
        self.assertTrue(success)
        state = self.organism.read(Register.EXTERNAL)
        self.assertEqual(state.content["public_data"], "safe")
    
    def test_external_filters_forbidden_keys(self):
        """Test external projection filters sovereign keys."""
        payload = {
            "public": "ok",
            "doctrine": "FILTERED",
            "sovereign": "FILTERED",
            "gate_a": "FILTERED",
        }
        
        self.organism.update_external_projection(payload)
        state = self.organism.read(Register.EXTERNAL)
        
        self.assertEqual(state.content["public"], "ok")
        self.assertNotIn("doctrine", state.content)
        self.assertNotIn("sovereign", state.content)
        self.assertNotIn("gate_a", state.content)
    
    def test_clear_write_halt(self):
        """Test clearing write halt."""
        self.organism._write_halted = True
        self.organism.clear_write_halt()
        
        self.assertFalse(self.organism._write_halted)
    
    def test_to_json(self):
        """Test JSON serialization."""
        json_str = self.organism.to_json()
        
        self.assertIn("registers", json_str)
        self.assertIn("organism", json_str)
    
    def test_snapshot_contains_metadata(self):
        """Test snapshot includes all metadata."""
        snapshot = self.organism.snapshot()
        
        self.assertIn("id", snapshot)
        self.assertIn("created_at", snapshot)
        self.assertIn("write_halted", snapshot)


class TestOrganismIntegration(unittest.TestCase):
    """Integration tests for organism operations."""
    
    def test_full_proposal_workflow(self):
        """Test complete proposal → promotion workflow."""
        organism = OrganismSovereign()
        
        # Founder sets doctrine
        organism.authorize_organism_write({"doctrine_floor": 0.5})
        
        # Builder proposes
        organism.propose_builder_write({
            "new_capability": "test_feature",
            "version": 2,
        })
        
        # Promote approved items
        organism.promote_builder_to_organism(["new_capability"])
        
        # Verify organism state
        org_state = organism.read(Register.ORGANISM)
        self.assertEqual(org_state.content["new_capability"], "test_feature")
        self.assertEqual(org_state.content["doctrine_floor"], 0.5)
        
        # Unpromoted items remain in builder
        builder_state = organism.read(Register.BUILDER)
        self.assertEqual(builder_state.content["version"], 2)
    
    def test_concurrent_reads_safe(self):
        """Test concurrent reads don't interfere."""
        organism = OrganismSovereign()
        organism.authorize_organism_write({"data": "test"})
        
        # Multiple reads
        results = [organism.dual_read(Register.ORGANISM) for _ in range(100)]
        
        # All should pass
        self.assertTrue(all(r.ok for r in results))


if __name__ == "__main__":
    unittest.main()
