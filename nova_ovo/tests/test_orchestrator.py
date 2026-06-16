"""
Orchestrator Tests — Beat-Driven Runtime Validation
====================================================
Tests for Orchestrator base class, BeatResult, and heartbeat engine.
"""

import math
import unittest
from nova_ovo.orchestrators.base import (
    Orchestrator,
    OrchestratorStatus,
    BeatResult,
)
from nova_ovo.orchestrators.heartbeat import (
    HeartbeatEngine,
    CardiacState,
)
from nova_ovo.core.recital import PHI


class ConcreteOrchestrator(Orchestrator):
    """Concrete implementation for testing."""
    
    def process_input(self, input_data: dict) -> dict:
        return {"processed": True, "input": input_data}


class TestBeatResult(unittest.TestCase):
    """Test BeatResult functionality."""
    
    def test_create_beat_result(self):
        """Test creating a beat result."""
        result = BeatResult(
            beat=1,
            orchestrator_id="ORCH-01",
            success=True,
        )
        
        self.assertEqual(result.beat, 1)
        self.assertEqual(result.orchestrator_id, "ORCH-01")
        self.assertTrue(result.success)
    
    def test_default_invariants(self):
        """Test default invariant values."""
        result = BeatResult()
        
        self.assertTrue(result.continuity_preserved)
        self.assertTrue(result.doctrine_floor_held)
        self.assertTrue(result.identity_locked)
    
    def test_psi_vectors(self):
        """Test psi vectors in result."""
        result = BeatResult(
            psi_before=(1.0, 0.5, 0.2, 0.1),
            psi_after=(1.0, 0.6, 0.3, 0.1),
        )
        
        self.assertEqual(result.psi_before[1], 0.5)
        self.assertEqual(result.psi_after[1], 0.6)
    
    def test_to_dict(self):
        """Test serialization to dict."""
        result = BeatResult(
            beat=5,
            coherence=0.95,
            heart_brain_resonance=0.8,
        )
        
        d = result.to_dict()
        
        self.assertEqual(d["beat"], 5)
        self.assertEqual(d["coherence"], 0.95)
        self.assertEqual(d["heart_brain_resonance"], 0.8)
        self.assertIn("invariants", d)


class TestOrchestrator(unittest.TestCase):
    """Test Orchestrator base class."""
    
    def setUp(self):
        self.orch = ConcreteOrchestrator()
    
    def test_initial_status(self):
        """Test initial status is INITIALIZING."""
        self.assertEqual(self.orch.status, OrchestratorStatus.INITIALIZING)
    
    def test_start(self):
        """Test starting orchestrator."""
        self.orch.start()
        
        self.assertEqual(self.orch.status, OrchestratorStatus.RUNNING)
        self.assertIsNotNone(self.orch.started_at)
    
    def test_pause_resume(self):
        """Test pause and resume."""
        self.orch.start()
        self.orch.pause()
        
        self.assertEqual(self.orch.status, OrchestratorStatus.PAUSED)
        
        self.orch.resume()
        self.assertEqual(self.orch.status, OrchestratorStatus.RUNNING)
    
    def test_resume_only_when_paused(self):
        """Test resume only works when paused."""
        self.orch.start()
        self.orch.shutdown()
        self.orch.resume()
        
        # Should still be shutdown
        self.assertEqual(self.orch.status, OrchestratorStatus.SHUTDOWN)
    
    def test_shutdown(self):
        """Test shutdown."""
        self.orch.start()
        self.orch.shutdown()
        
        self.assertEqual(self.orch.status, OrchestratorStatus.SHUTDOWN)
    
    def test_psi_initial_state(self):
        """Test initial psi state."""
        psi = self.orch.psi
        
        # Initial: [doctrine, velocity, memory, projection]
        self.assertEqual(psi[0], 1.0)  # doctrine coherence
        self.assertEqual(psi[1], 0.0)  # velocity
        self.assertEqual(psi[2], 0.0)  # memory
        self.assertEqual(psi[3], 0.0)  # projection
    
    def test_tick_increments_beat(self):
        """Test tick increments beat counter."""
        self.orch.start()
        initial_beat = self.orch.current_beat
        
        self.orch.tick()
        
        self.assertEqual(self.orch.current_beat, initial_beat + 1)
    
    def test_tick_returns_result(self):
        """Test tick returns BeatResult."""
        self.orch.start()
        result = self.orch.tick()
        
        self.assertIsInstance(result, BeatResult)
        self.assertEqual(result.orchestrator_id, self.orch.orch_id)
    
    def test_tick_computes_coherence(self):
        """Test tick computes coherence."""
        self.orch.start()
        result = self.orch.tick()
        
        # Coherence should be between 0 and 1
        self.assertGreaterEqual(result.coherence, 0)
        self.assertLessEqual(result.coherence, 1)
    
    def test_tick_computes_cardio_cerebral(self):
        """Test tick computes cardio-cerebral metrics."""
        self.orch.start()
        result = self.orch.tick()
        
        self.assertGreaterEqual(result.heart_brain_resonance, 0)
        self.assertLessEqual(result.heart_brain_resonance, 1)
        self.assertEqual(len(result.direction_vector), 3)
    
    def test_doctrine_floor_enforcement(self):
        """Test doctrine floor is enforced."""
        self.orch.start()
        
        # Run multiple ticks
        for _ in range(10):
            result = self.orch.tick()
            self.assertTrue(result.doctrine_floor_held)
    
    def test_continuity_preservation(self):
        """Test no-drop continuity."""
        self.orch.start()
        
        prev_memory = self.orch.psi[2]
        for _ in range(10):
            result = self.orch.tick()
            # Memory should not decrease (no-drop)
            self.assertGreaterEqual(self.orch.psi[2], prev_memory - 0.001)
            prev_memory = self.orch.psi[2]
    
    def test_history_tracking(self):
        """Test beat history is tracked."""
        self.orch.start()
        
        for _ in range(5):
            self.orch.tick()
        
        history = self.orch.get_history()
        self.assertEqual(len(history), 5)
    
    def test_get_status(self):
        """Test get_status returns full info."""
        self.orch.start()
        self.orch.tick()
        
        status = self.orch.get_status()
        
        self.assertIn("orch_id", status)
        self.assertIn("orch_type", status)
        self.assertIn("status", status)
        self.assertIn("current_beat", status)
        self.assertIn("psi", status)
        self.assertIn("coherence", status)
    
    def test_orch_ids_mapping(self):
        """Test orchestrator ID mapping."""
        orch = ConcreteOrchestrator("SOVEREIGN_TICK")
        self.assertEqual(orch.orch_id, "ORCH-01")
        
        orch2 = ConcreteOrchestrator("FULL_GOVERNANCE")
        self.assertEqual(orch2.orch_id, "ORCH-04")
    
    def test_coupling_matrix_initialization(self):
        """Test coupling matrix is initialized with golden ratio."""
        matrix = self.orch._coupling_matrix
        
        # 8x8 matrix
        self.assertEqual(len(matrix), 8)
        self.assertEqual(len(matrix[0]), 8)
        
        # Diagonal should be zero
        for i in range(8):
            self.assertEqual(matrix[i][i], 0.0)


class TestHeartbeatEngine(unittest.TestCase):
    """Test HeartbeatEngine functionality."""
    
    def setUp(self):
        self.engine = HeartbeatEngine()
    
    def test_initial_state(self):
        """Test initial cardiac state."""
        state = self.engine.current_state
        
        self.assertEqual(state.beat, 0)
        self.assertEqual(state.theta_heart, 0.0)
        self.assertEqual(state.theta_brain, 0.0)
    
    def test_tick_advances_beat(self):
        """Test tick advances beat counter."""
        self.engine.tick()
        
        self.assertEqual(self.engine.current_beat, 1)
    
    def test_tick_updates_phases(self):
        """Test tick updates heart and brain phases."""
        initial_heart = self.engine.current_state.theta_heart
        initial_brain = self.engine.current_state.theta_brain
        
        self.engine.tick()
        
        # Phases should advance
        self.assertNotEqual(self.engine.current_state.theta_heart, initial_heart)
        self.assertNotEqual(self.engine.current_state.theta_brain, initial_brain)
    
    def test_phases_bounded(self):
        """Test phases stay in [0, 2π)."""
        for _ in range(100):
            self.engine.tick()
        
        state = self.engine.current_state
        self.assertGreaterEqual(state.theta_heart, 0)
        self.assertLess(state.theta_heart, 2 * math.pi)
        self.assertGreaterEqual(state.theta_brain, 0)
        self.assertLess(state.theta_brain, 2 * math.pi)
    
    def test_resonance_computation(self):
        """Test resonance is computed."""
        state = self.engine.tick()
        
        # Resonance should be between 0 and 1
        self.assertGreaterEqual(state.resonance, 0)
        self.assertLessEqual(state.resonance, 1)
    
    def test_direction_vector(self):
        """Test direction vector has 3 components."""
        state = self.engine.tick()
        
        self.assertEqual(len(state.direction), 3)
    
    def test_propulsion_non_negative(self):
        """Test propulsion is non-negative."""
        for _ in range(20):
            state = self.engine.tick()
            self.assertGreaterEqual(state.propulsion, 0)
    
    def test_coherence_computation(self):
        """Test get_coherence computes correctly."""
        # Run some ticks
        for _ in range(10):
            self.engine.tick()
        
        coherence = self.engine.get_coherence()
        
        # Coherence (order parameter r) should be in [0, 1]
        self.assertGreaterEqual(coherence, 0)
        self.assertLessEqual(coherence, 1)
    
    def test_set_coupling(self):
        """Test setting coupling strengths."""
        self.engine.set_coupling(K_hb=0.8, K_bh=0.4)
        
        state = self.engine.current_state
        self.assertEqual(state.K_hb, 0.8)
        self.assertEqual(state.K_bh, 0.4)
    
    def test_set_frequencies(self):
        """Test setting frequencies."""
        self.engine.set_frequencies(omega_heart=2.0, omega_brain=3.0)
        
        state = self.engine.current_state
        self.assertEqual(state.omega_heart, 2.0)
        self.assertEqual(state.omega_brain, 3.0)
    
    def test_history_tracking(self):
        """Test history is tracked."""
        for _ in range(5):
            self.engine.tick()
        
        history = self.engine.get_history()
        self.assertEqual(len(history), 5)
    
    def test_statistics(self):
        """Test statistics generation."""
        for _ in range(10):
            self.engine.tick()
        
        stats = self.engine.get_statistics()
        
        self.assertEqual(stats["beats"], 10)
        self.assertIn("avg_resonance", stats)
        self.assertIn("avg_propulsion", stats)
        self.assertIn("current_coherence", stats)
    
    def test_cardiac_state_to_dict(self):
        """Test CardiacState serialization."""
        state = self.engine.tick()
        d = state.to_dict()
        
        self.assertIn("beat", d)
        self.assertIn("theta_heart", d)
        self.assertIn("theta_brain", d)
        self.assertIn("resonance", d)
        self.assertIn("direction", d)


class TestKuramotoPhaseSync(unittest.TestCase):
    """Test Kuramoto phase synchronization behavior."""
    
    def test_strong_coupling_sync(self):
        """Test strong coupling leads to synchronization."""
        engine = HeartbeatEngine(K_hb=1.0, K_bh=1.0)
        
        # Run many beats
        for _ in range(500):
            engine.tick()
        
        # With strong coupling, coherence should be high
        coherence = engine.get_coherence()
        self.assertGreater(coherence, 0.7)
    
    def test_golden_ratio_frequency(self):
        """Test brain frequency is PHI scaled."""
        engine = HeartbeatEngine()
        
        self.assertAlmostEqual(
            engine.current_state.omega_brain,
            PHI,
            places=5,
        )
    
    def test_phase_lag_bounded(self):
        """Test phase lag stays bounded."""
        engine = HeartbeatEngine()
        
        for _ in range(100):
            state = engine.tick()
            # Phase lag should be in [-π, π]
            self.assertGreaterEqual(state.phase_lag, -math.pi)
            self.assertLessEqual(state.phase_lag, math.pi)


if __name__ == "__main__":
    unittest.main()
