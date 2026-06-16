"""
Resonance Propagation Tests — Tier-11 Cross-Organism Coupling
==============================================================
Tests for resonance bus, coupling, and propagation.
"""

import math
import unittest
from nova_ovo.resonance import (
    ResonanceBus,
    OrganismConnection,
    ResonanceState,
    CouplingMatrix,
    CouplingRule,
    BoundedCoupling,
    compute_kuramoto_coupling,
    ResonancePropagator,
    PropagationEvent,
    PropagationResult,
    ShellInfluence,
)


class TestResonanceBus(unittest.TestCase):
    """Test resonance bus functionality."""
    
    def test_create_bus(self):
        """Test creating a resonance bus."""
        bus = ResonanceBus()
        
        self.assertIsNotNone(bus.bus_id)
        self.assertEqual(bus.connection_count, 0)
    
    def test_connect_organism(self):
        """Test connecting an organism."""
        bus = ResonanceBus()
        
        conn = bus.connect("org_1", "document")
        
        self.assertIsNotNone(conn)
        self.assertEqual(conn.organism_id, "org_1")
        self.assertEqual(bus.connection_count, 1)
    
    def test_disconnect_organism(self):
        """Test disconnecting an organism."""
        bus = ResonanceBus()
        bus.connect("org_1")
        
        result = bus.disconnect("org_1")
        
        self.assertTrue(result)
        self.assertEqual(bus.connection_count, 0)
    
    def test_multiple_connections(self):
        """Test multiple organism connections."""
        bus = ResonanceBus()
        
        for i in range(5):
            bus.connect(f"org_{i}", "document")
        
        self.assertEqual(bus.connection_count, 5)
    
    def test_pulse(self):
        """Test bus pulse advances phases."""
        bus = ResonanceBus()
        bus.connect("org_1")
        bus.connect("org_2")
        
        conn1 = bus.get_connection("org_1")
        initial_phase = conn1.state.theta
        
        bus.pulse(dt=0.1)
        
        self.assertNotEqual(conn1.state.theta, initial_phase)
        self.assertEqual(bus.current_beat, 1)
    
    def test_global_coherence(self):
        """Test global coherence calculation."""
        bus = ResonanceBus()
        
        # Add organisms with similar phases
        conn1 = bus.connect("org_1")
        conn2 = bus.connect("org_2")
        
        # Set similar phases
        conn1.state.theta = 0.0
        conn2.state.theta = 0.1
        
        bus.pulse(dt=0.01)  # Small step to keep phases similar
        
        # Coherence should be high
        self.assertGreater(bus.global_coherence, 0.9)
    
    def test_synchronization(self):
        """Test that organisms synchronize over time."""
        bus = ResonanceBus(coupling_strength=0.5, sync_threshold=0.8)
        
        # Connect organisms with different phases
        conn1 = bus.connect("org_1")
        conn2 = bus.connect("org_2")
        conn3 = bus.connect("org_3")
        
        conn1.state.theta = 0.0
        conn2.state.theta = math.pi / 2
        conn3.state.theta = math.pi
        
        # Pulse many times to allow synchronization
        for _ in range(100):
            bus.pulse(dt=0.1)
        
        # Should converge to higher coherence
        self.assertGreater(bus.global_coherence, 0.5)


class TestCouplingMatrix(unittest.TestCase):
    """Test coupling matrix functionality."""
    
    def test_create_matrix(self):
        """Test creating a coupling matrix."""
        matrix = CouplingMatrix()
        
        self.assertIsNotNone(matrix)
    
    def test_add_organisms(self):
        """Test adding organisms to matrix."""
        matrix = CouplingMatrix()
        
        matrix.add_organism("org_1", {"index": 1})
        matrix.add_organism("org_2", {"index": 2})
        
        # Should have coupling between them
        coupling = matrix.get("org_1", "org_2")
        self.assertGreater(coupling, 0)
    
    def test_phi_scaled_coupling(self):
        """Test PHI-scaled coupling rule."""
        rule = CouplingRule(
            coupling_type="phi_scaled",
            base_strength=1.0,
            phi_exponent=1.0,
        )
        
        matrix = CouplingMatrix(default_rule=rule)
        
        matrix.add_organism("org_1", {"index": 1})
        matrix.add_organism("org_2", {"index": 2})
        matrix.add_organism("org_3", {"index": 3})
        
        # Closer organisms should have stronger coupling
        coupling_1_2 = matrix.get("org_1", "org_2")
        coupling_1_3 = matrix.get("org_1", "org_3")
        
        self.assertGreater(coupling_1_2, coupling_1_3)
    
    def test_bounded_coupling(self):
        """Test coupling bounds."""
        bounds = BoundedCoupling(
            max_single_influence=0.5,
            max_total_influence=1.0,
        )
        
        # Test bounding
        raw = 0.8
        bounded = bounds.bound_influence(raw)
        
        self.assertEqual(bounded, 0.5)  # Capped at max_single
    
    def test_can_send_influence(self):
        """Test send influence checks."""
        bounds = BoundedCoupling(
            min_coherence_to_send=0.3,
            min_energy_to_receive=0.2,
        )
        
        # Below threshold
        self.assertFalse(bounds.can_send(coherence=0.1, energy=0.5))
        
        # Above threshold
        self.assertTrue(bounds.can_send(coherence=0.5, energy=0.5))


class TestKuramotoCoupling(unittest.TestCase):
    """Test Kuramoto coupling computation."""
    
    def test_basic_coupling(self):
        """Test basic Kuramoto step."""
        phases = [0.0, math.pi / 2, math.pi]
        coupling = [[0, 0.5, 0.5], [0.5, 0, 0.5], [0.5, 0.5, 0]]
        frequencies = [1.0, 1.0, 1.0]
        
        new_phases = compute_kuramoto_coupling(
            phases, coupling, frequencies, dt=0.1
        )
        
        self.assertEqual(len(new_phases), 3)
        for phase in new_phases:
            self.assertGreaterEqual(phase, 0)
            self.assertLess(phase, 2 * math.pi)
    
    def test_phase_synchronization(self):
        """Test that phases converge."""
        phases = [0.0, math.pi]  # Opposite phases
        coupling = [[0, 1.0], [1.0, 0]]  # Strong coupling
        frequencies = [1.0, 1.0]  # Same frequency
        
        # Iterate many times
        for _ in range(100):
            phases = compute_kuramoto_coupling(phases, coupling, frequencies, dt=0.1)
        
        # Phases should be closer together
        phase_diff = abs(phases[1] - phases[0])
        # Normalize to [-π, π]
        if phase_diff > math.pi:
            phase_diff = 2 * math.pi - phase_diff
        
        self.assertLess(phase_diff, math.pi)  # Should be more aligned


class TestResonancePropagation(unittest.TestCase):
    """Test resonance propagation functionality."""
    
    def setUp(self):
        self.bus = ResonanceBus()
        self.propagator = ResonancePropagator(self.bus)
    
    def test_create_propagator(self):
        """Test creating a propagator."""
        propagator = ResonancePropagator()
        self.assertIsNotNone(propagator)
    
    def test_propagate_energy(self):
        """Test energy propagation."""
        self.bus.connect("source")
        self.bus.connect("target")
        
        from nova_ovo.resonance.propagation import InfluenceType
        
        result = self.propagator.propagate(
            source_id="source",
            influence_type=InfluenceType.ENERGY,
            magnitude=0.2,
        )
        
        self.assertTrue(result.success)
        self.assertGreater(result.total_influence, 0)
    
    def test_propagate_coherence(self):
        """Test coherence propagation."""
        self.bus.connect("source")
        self.bus.connect("target")
        
        from nova_ovo.resonance.propagation import InfluenceType
        
        result = self.propagator.propagate(
            source_id="source",
            influence_type=InfluenceType.COHERENCE,
            magnitude=0.1,
        )
        
        self.assertTrue(result.success)
        self.assertEqual(result.targets_affected, 1)
    
    def test_propagation_to_multiple_targets(self):
        """Test propagation to multiple targets."""
        self.bus.connect("source")
        self.bus.connect("target_1")
        self.bus.connect("target_2")
        self.bus.connect("target_3")
        
        from nova_ovo.resonance.propagation import InfluenceType
        
        result = self.propagator.propagate(
            source_id="source",
            influence_type=InfluenceType.ENERGY,
            magnitude=0.3,
        )
        
        self.assertTrue(result.success)
        self.assertEqual(result.targets_affected, 3)
    
    def test_shell_influence(self):
        """Test creating shell influence."""
        influence = ShellInfluence(
            source_id="source",
            magnitude=0.5,
        )
        
        self.assertEqual(influence.source_id, "source")
        self.assertEqual(influence.magnitude, 0.5)


class TestResonanceState(unittest.TestCase):
    """Test resonance state functionality."""
    
    def test_create_state(self):
        """Test creating resonance state."""
        state = ResonanceState(
            organism_id="org_1",
            omega=1.0,
        )
        
        self.assertEqual(state.organism_id, "org_1")
        self.assertEqual(state.omega, 1.0)
    
    def test_advance_phase(self):
        """Test phase advancement."""
        state = ResonanceState(theta=0.0, omega=1.0)
        
        state.advance_phase(dt=0.1, coupling_sum=0.0)
        
        self.assertGreater(state.theta, 0)
    
    def test_phase_difference(self):
        """Test phase difference calculation."""
        state1 = ResonanceState(theta=0.0)
        state2 = ResonanceState(theta=math.pi / 2)
        
        diff = state1.phase_difference(state2)
        
        self.assertAlmostEqual(diff, math.pi / 2, places=5)
    
    def test_frequency_hz(self):
        """Test frequency in Hz."""
        state = ResonanceState(omega=1.0)
        
        # PHI ≈ 1.618
        self.assertGreater(state.frequency_hz, 1.6)
        self.assertLess(state.frequency_hz, 1.7)


if __name__ == "__main__":
    unittest.main()
