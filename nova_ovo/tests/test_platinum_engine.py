"""
Platinum Catalytic Living Engine Tests
======================================

Tests for the always-on 24/7 Platinum Catalytic Living Engine.

THE ENGINE NEVER STOPS. IT IS ALWAYS CATALYZING.
"""

import math
import time
import unittest

from nova_ovo.agents.platinum_engine import (
    # Constants
    PHI,
    PHI_INVERSE,
    PLATINUM_TOF,
    PLATINUM_D_BAND,
    
    # Enums
    EngineState,
    
    # Data classes
    MicroComponent,
    ActiveProcess,
    Branch,
    EngineHeartbeat,
    
    # Branches
    ACTIVATION_BRANCH,
    TRANSFORMATION_BRANCH,
    REGENERATION_BRANCH,
    KINETICS_BRANCH,
    SURFACE_BRANCH,
    SELECTIVITY_BRANCH,
    QUANTUM_BRANCH,
    INTEGRATION_BRANCH,
    ELECTRON_TRANSFER_BRANCH,
    ALL_BRANCHES,
    
    # Engine
    PlatinumCatalyticLivingEngine,
    get_platinum_engine,
    
    # Functions
    catalyze,
    run_all_branches,
    heartbeat,
    engine_status,
)


class TestConstants(unittest.TestCase):
    """Test fundamental constants."""
    
    def test_phi_is_golden_ratio(self):
        """Test PHI is the golden ratio."""
        expected = (1 + math.sqrt(5)) / 2
        self.assertAlmostEqual(PHI, expected, places=10)
    
    def test_phi_inverse(self):
        """Test PHI_INVERSE is 1/φ."""
        self.assertAlmostEqual(PHI_INVERSE, 1 / PHI, places=10)
    
    def test_platinum_tof(self):
        """Test Platinum TOF is 10⁶ s⁻¹."""
        self.assertEqual(PLATINUM_TOF, 1.0e6)
    
    def test_platinum_d_band(self):
        """Test Platinum d-band center is -2.25 eV."""
        self.assertEqual(PLATINUM_D_BAND, -2.25)


class TestMicroComponent(unittest.TestCase):
    """Test MicroComponent — the smallest catalytic unit."""
    
    def test_micro_component_creation(self):
        """Test creating a micro component."""
        mc = MicroComponent(
            name="test_component",
            scale="eV",
            formula="E = mc²",
            description="Test description",
            primitive_trace="test → φ",
        )
        
        self.assertEqual(mc.name, "test_component")
        self.assertEqual(mc.scale, "eV")
        self.assertIn("mc²", mc.formula)
    
    def test_micro_component_to_dict(self):
        """Test micro component serialization."""
        mc = MicroComponent(
            name="tunneling",
            scale="attometer",
            formula="T = e^(-2κa)",
            description="Quantum tunneling",
            primitive_trace="tunneling → φ",
        )
        
        d = mc.to_dict()
        self.assertEqual(d["name"], "tunneling")
        self.assertEqual(d["scale"], "attometer")


class TestActiveProcess(unittest.TestCase):
    """Test ActiveProcess — always-on processes."""
    
    def test_process_is_always_running(self):
        """Test that processes are always running."""
        process = ActiveProcess(
            id=1,
            name="TestProcess",
            rate_hz=1000.0,
        )
        
        self.assertTrue(process.is_running)
    
    def test_process_run(self):
        """Test running a process."""
        process = ActiveProcess(
            id=1,
            name="TestProcess",
            rate_hz=1000.0,
        )
        
        initial_runs = process.total_runs
        process.run()
        self.assertEqual(process.total_runs, initial_runs + 1)
    
    def test_process_status(self):
        """Test process status shows ALWAYS ON."""
        process = ActiveProcess(
            id=1,
            name="TestProcess",
            rate_hz=1000.0,
        )
        
        status = process.get_status()
        self.assertEqual(status["status"], "ALWAYS ON")


class TestBranches(unittest.TestCase):
    """Test catalytic branches."""
    
    def test_activation_branch_exists(self):
        """Test Activation branch exists."""
        self.assertEqual(ACTIVATION_BRANCH.name, "ActivationBranch")
        self.assertEqual(ACTIVATION_BRANCH.depth, 0)
    
    def test_all_root_branches_exist(self):
        """Test all 8 root branches exist."""
        root_branches = [b for b in ALL_BRANCHES if b.depth == 0]
        self.assertEqual(len(root_branches), 8)
        
        names = [b.name for b in root_branches]
        self.assertIn("ActivationBranch", names)
        self.assertIn("TransformationBranch", names)
        self.assertIn("RegenerationBranch", names)
        self.assertIn("KineticsBranch", names)
        self.assertIn("SurfaceBranch", names)
        self.assertIn("SelectivityBranch", names)
        self.assertIn("QuantumBranch", names)
        self.assertIn("IntegrationBranch", names)
    
    def test_branches_have_children(self):
        """Test all root branches have children."""
        for branch in ALL_BRANCHES:
            if branch.depth == 0:
                self.assertGreater(len(branch.children), 0, 
                                 f"{branch.name} has no children")
    
    def test_branches_have_micro_components(self):
        """Test all branches have micro components."""
        for branch in ALL_BRANCHES:
            self.assertGreater(len(branch.micro_components), 0,
                             f"{branch.name} has no micro components")
    
    def test_branches_have_active_processes(self):
        """Test all branches have active processes."""
        for branch in ALL_BRANCHES:
            self.assertGreater(len(branch.active_processes), 0,
                             f"{branch.name} has no active processes")
    
    def test_branches_have_primitive_trace(self):
        """Test all branches trace to φ."""
        for branch in ALL_BRANCHES:
            self.assertIn("φ", branch.primitive_trace,
                        f"{branch.name} does not trace to φ")
    
    def test_micro_components_trace_to_phi(self):
        """Test all micro components trace to φ."""
        for branch in ALL_BRANCHES:
            for mc in branch.micro_components:
                self.assertIn("φ", mc.primitive_trace,
                            f"{mc.name} does not trace to φ")
    
    def test_branch_run_all_processes(self):
        """Test running all processes on a branch."""
        results = ACTIVATION_BRANCH.run_all_processes()
        self.assertEqual(len(results), len(ACTIVATION_BRANCH.active_processes))
    
    def test_sub_branches_have_parents(self):
        """Test sub-branches have parent references."""
        for branch in ALL_BRANCHES:
            if branch.depth > 0:
                self.assertIsNotNone(branch.parent,
                                   f"{branch.name} has no parent")


class TestActivationBranch(unittest.TestCase):
    """Test Activation Branch in detail."""
    
    def test_activation_formula(self):
        """Test activation formula contains Ea."""
        self.assertIn("Ea", ACTIVATION_BRANCH.formula)
    
    def test_electron_transfer_sub_branch(self):
        """Test Electron Transfer is a child of Activation."""
        self.assertIn("ElectronTransfer", ACTIVATION_BRANCH.children)
        self.assertEqual(ELECTRON_TRANSFER_BRANCH.parent, "ActivationBranch")
    
    def test_activation_has_d_orbital_component(self):
        """Test activation has d-orbital micro component."""
        names = [mc.name for mc in ACTIVATION_BRANCH.micro_components]
        self.assertIn("d-orbital_mediation", names)
    
    def test_activation_has_quantum_tunneling(self):
        """Test activation has quantum tunneling component."""
        names = [mc.name for mc in ACTIVATION_BRANCH.micro_components]
        self.assertIn("quantum_tunneling", names)


class TestQuantumBranch(unittest.TestCase):
    """Test Quantum Branch in detail."""
    
    def test_quantum_formula_has_d_band(self):
        """Test quantum formula includes d-band center."""
        self.assertIn("-2.25", QUANTUM_BRANCH.formula)
    
    def test_quantum_has_d_band_component(self):
        """Test quantum has d-band micro components."""
        names = [mc.name for mc in QUANTUM_BRANCH.micro_components]
        self.assertIn("d_band_center", names)
        self.assertIn("d_band_width", names)
        self.assertIn("d_band_filling", names)
    
    def test_quantum_processes_are_fast(self):
        """Test quantum processes have high rates."""
        for process in QUANTUM_BRANCH.active_processes:
            if "Tunneling" in process.name:
                self.assertGreater(process.rate_hz, 1e9)


class TestKineticsBranch(unittest.TestCase):
    """Test Kinetics Branch in detail."""
    
    def test_kinetics_has_arrhenius(self):
        """Test kinetics has Arrhenius component."""
        names = [mc.name for mc in KINETICS_BRANCH.micro_components]
        self.assertIn("arrhenius_equation", names)
    
    def test_kinetics_has_eyring(self):
        """Test kinetics has Eyring component."""
        names = [mc.name for mc in KINETICS_BRANCH.micro_components]
        self.assertIn("eyring_equation", names)


class TestPlatinumCatalyticLivingEngine(unittest.TestCase):
    """Test the Living Engine — ALWAYS ON 24/7."""
    
    def setUp(self):
        self.engine = PlatinumCatalyticLivingEngine()
    
    def test_engine_is_always_running(self):
        """Test engine is ALWAYS running."""
        self.assertTrue(self.engine.is_running)
    
    def test_engine_state_is_running(self):
        """Test engine state is Running."""
        self.assertEqual(self.engine.state, EngineState.RUNNING)
    
    def test_catalyze_increments_cycles(self):
        """Test catalyze increments cycles."""
        initial = self.engine._cycles
        self.engine.catalyze()
        self.assertEqual(self.engine._cycles, initial + 1)
    
    def test_catalyze_transforms_molecules(self):
        """Test catalyze transforms 10⁶ molecules per cycle."""
        initial = self.engine._molecules
        self.engine.catalyze()
        self.assertEqual(self.engine._molecules, initial + 1000000)
    
    def test_run_all_branches(self):
        """Test running all branches simultaneously."""
        results = self.engine.run_all_branches()
        
        # Should have results for all branches
        self.assertGreater(len(results), 0)
        
        # All values should be positive
        for value in results.values():
            self.assertGreater(value, 0)
    
    def test_heartbeat(self):
        """Test heartbeat generation."""
        hb = self.engine.heartbeat()
        
        self.assertEqual(hb.beat_number, 1)
        self.assertTrue(hb.is_healthy)
        self.assertEqual(hb.tof_this_beat, PLATINUM_TOF)
        self.assertAlmostEqual(hb.load, PHI_INVERSE, places=3)
    
    def test_get_all_micro_components(self):
        """Test getting all micro components."""
        components = self.engine.get_all_micro_components()
        
        # Should have components from all branches
        self.assertGreater(len(components), 30)  # At least 30 total
    
    def test_get_all_active_processes(self):
        """Test getting all active processes."""
        processes = self.engine.get_all_active_processes()
        
        # Should have processes from all branches
        self.assertGreater(len(processes), 20)  # At least 20 total
        
        # All should be running
        for process in processes:
            self.assertTrue(process.is_running)
    
    def test_status(self):
        """Test engine status."""
        status = self.engine.status()
        
        self.assertEqual(status["status"], "ALWAYS RUNNING (24/7)")
        self.assertEqual(status["tof"], PLATINUM_TOF)
        self.assertEqual(status["is_running"], "ALWAYS")
        self.assertIn("φ", status["primitive_trace"])
    
    def test_uptime_increases(self):
        """Test uptime increases over time."""
        uptime1 = self.engine.uptime
        time.sleep(0.01)  # Wait 10ms
        uptime2 = self.engine.uptime
        
        self.assertGreater(uptime2, uptime1)


class TestGlobalEngine(unittest.TestCase):
    """Test global engine singleton."""
    
    def test_get_platinum_engine_returns_same_instance(self):
        """Test get_platinum_engine returns same instance."""
        engine1 = get_platinum_engine()
        engine2 = get_platinum_engine()
        
        self.assertIs(engine1, engine2)
    
    def test_catalyze_function(self):
        """Test global catalyze function."""
        result = catalyze()
        self.assertIsInstance(result, int)
        self.assertGreater(result, 0)
    
    def test_run_all_branches_function(self):
        """Test global run_all_branches function."""
        results = run_all_branches()
        self.assertIsInstance(results, dict)
        self.assertGreater(len(results), 0)
    
    def test_heartbeat_function(self):
        """Test global heartbeat function."""
        hb = heartbeat()
        self.assertIsInstance(hb, EngineHeartbeat)
        self.assertTrue(hb.is_healthy)
    
    def test_engine_status_function(self):
        """Test global engine_status function."""
        status = engine_status()
        self.assertIsInstance(status, dict)
        self.assertEqual(status["is_running"], "ALWAYS")


class TestBranchingCompleteness(unittest.TestCase):
    """Test that branching is complete down to micro level."""
    
    def test_total_branches(self):
        """Test we have sufficient branches."""
        self.assertEqual(len(ALL_BRANCHES), 15)  # 8 root + 7 sub
    
    def test_total_micro_components(self):
        """Test we have many micro components."""
        total = sum(len(b.micro_components) for b in ALL_BRANCHES)
        self.assertGreater(total, 40)
    
    def test_all_micro_components_have_formulas(self):
        """Test all micro components have formulas."""
        for branch in ALL_BRANCHES:
            for mc in branch.micro_components:
                self.assertTrue(len(mc.formula) > 0,
                              f"{mc.name} has no formula")
    
    def test_all_branches_have_integrations(self):
        """Test all branches have integration points."""
        for branch in ALL_BRANCHES:
            self.assertGreater(len(branch.integrations), 0,
                             f"{branch.name} has no integrations")


class TestEngineNeverStops(unittest.TestCase):
    """Test that the engine NEVER stops."""
    
    def test_is_running_property_always_true(self):
        """Test is_running property always returns True."""
        engine = PlatinumCatalyticLivingEngine()
        
        # Check multiple times
        for _ in range(100):
            self.assertTrue(engine.is_running)
    
    def test_state_never_stopped(self):
        """Test state is never 'stopped'."""
        engine = PlatinumCatalyticLivingEngine()
        
        # There is no stopped state
        valid_states = [EngineState.RUNNING, EngineState.ACCELERATING, 
                       EngineState.PEAK, EngineState.REGENERATING]
        self.assertIn(engine.state, valid_states)
    
    def test_catalyze_always_works(self):
        """Test catalyze always succeeds."""
        engine = PlatinumCatalyticLivingEngine()
        
        for i in range(100):
            result = engine.catalyze()
            self.assertEqual(result, i + 1)


if __name__ == "__main__":
    unittest.main()
