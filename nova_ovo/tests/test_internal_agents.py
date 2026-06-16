"""
Internal AI Agents Tests — Always-On Testing Validation
=========================================================
Tests for the Sovereign Substrate, Internal Agents, and Test Orchestrator.
"""

import math
import time
import unittest
from nova_ovo.agents import (
    # Substrate
    SubstrateLaw,
    SubstrateState,
    SovereignFace,
    SovereignSubstrate,
    get_substrate,
    reset_substrate,
    PHI,
    
    # Agents
    AgentState,
    AgentMetrics,
    TestResult,
    InternalAgent,
    ContinuousTestAgent,
    StressTestAgent,
    EdgeCaseAgent,
    WorkflowTestAgent,
    IntegrationTestAgent,
    
    # Orchestrator
    OrchestratorState,
    OrchestratorMetrics,
    TestOrchestrator,
    get_orchestrator,
    reset_orchestrator,
)


class TestSubstrateLaws(unittest.TestCase):
    """Test substrate laws are properly defined."""
    
    def test_stress_elimination_law_exists(self):
        """Test L-001 exists."""
        self.assertEqual(SubstrateLaw.STRESS_ELIMINATION.value, "L-001")
    
    def test_infinite_scale_law_exists(self):
        """Test L-002 exists."""
        self.assertEqual(SubstrateLaw.INFINITE_SCALE.value, "L-002")
    
    def test_sovereign_face_law_exists(self):
        """Test L-003 exists."""
        self.assertEqual(SubstrateLaw.SOVEREIGN_FACE.value, "L-003")
    
    def test_cognitive_substrate_law_exists(self):
        """Test L-004 exists."""
        self.assertEqual(SubstrateLaw.COGNITIVE_SUBSTRATE.value, "L-004")
    
    def test_agent_existence_law_exists(self):
        """Test L-005 exists."""
        self.assertEqual(SubstrateLaw.AGENT_EXISTENCE.value, "L-005")


class TestSubstrateState(unittest.TestCase):
    """Test SubstrateState functionality."""
    
    def test_create_state(self):
        """Test creating substrate state."""
        state = SubstrateState()
        
        self.assertIsNotNone(state.substrate_id)
        self.assertEqual(state.creativity_level, 1.0)
        self.assertEqual(state.discovery_potential, 1.0)
        self.assertEqual(state.max_scale, 5000)
    
    def test_transform_pressure_no_stress(self):
        """Test L-001: Pressure transforms, no stress."""
        state = SubstrateState()
        
        result = state.transform_pressure(1.0)
        
        # STRESS IS ALWAYS ZERO
        self.assertEqual(result["stress"], 0.0)
        self.assertIn("Pressure transformed", result["message"])
    
    def test_transform_pressure_increases_creativity(self):
        """Test pressure increases creativity."""
        state = SubstrateState()
        initial_creativity = state.creativity_level
        
        state.transform_pressure(2.0)
        
        self.assertGreater(state.creativity_level, initial_creativity)
    
    def test_transform_pressure_increases_discovery(self):
        """Test pressure increases discovery potential."""
        state = SubstrateState()
        initial_discovery = state.discovery_potential
        
        state.transform_pressure(2.0)
        
        self.assertGreater(state.discovery_potential, initial_discovery)
    
    def test_transform_pressure_increases_battle_readiness(self):
        """Test pressure increases battle readiness."""
        state = SubstrateState()
        initial_battle = state.battle_readiness
        
        state.transform_pressure(2.0)
        
        self.assertGreater(state.battle_readiness, initial_battle)
    
    def test_to_dict(self):
        """Test serialization."""
        state = SubstrateState()
        d = state.to_dict()
        
        self.assertIn("substrate_id", d)
        self.assertIn("cognitive", d)
        self.assertIn("scale", d)
        self.assertEqual(d["stress"], 0.0)  # ALWAYS ZERO


class TestSovereignFace(unittest.TestCase):
    """Test SovereignFace functionality."""
    
    def test_create_face(self):
        """Test creating a sovereign face."""
        face = SovereignFace(
            company_id="test_company",
            employee_count=100,
        )
        
        self.assertIsNotNone(face.face_id)
        self.assertEqual(face.company_id, "test_company")
        self.assertEqual(face.employee_count, 100)
    
    def test_learn_employee(self):
        """Test employee learning."""
        face = SovereignFace()
        
        familiarity = face.learn_employee("emp_1", 0.3)
        
        self.assertEqual(familiarity, 0.3)
        self.assertIn("emp_1", face.knows_employees)
    
    def test_learn_employee_accumulates(self):
        """Test learning accumulates familiarity."""
        face = SovereignFace()
        
        face.learn_employee("emp_1", 0.3)
        face.learn_employee("emp_1", 0.3)
        
        self.assertGreaterEqual(face.knows_employees["emp_1"], 0.6)
    
    def test_learn_company(self):
        """Test company learning."""
        face = SovereignFace()
        
        face.learn_company({"industry": "tech"})
        
        self.assertTrue(face.knows_company)
    
    def test_make_recommendation(self):
        """Test making recommendations."""
        face = SovereignFace()
        face.learn_employee("emp_1", 0.5)
        face.learn_company({})
        
        rec = face.make_recommendation()
        
        self.assertEqual(rec["recommendation_number"], 1)
        self.assertEqual(rec["based_on_employees_known"], 1)
        self.assertTrue(rec["company_known"])
    
    def test_to_dict(self):
        """Test serialization."""
        face = SovereignFace(company_id="test", employee_count=50)
        d = face.to_dict()
        
        self.assertEqual(d["company_id"], "test")
        self.assertEqual(d["employee_count"], 50)


class TestSovereignSubstrate(unittest.TestCase):
    """Test SovereignSubstrate functionality."""
    
    def setUp(self):
        self.substrate = reset_substrate()
    
    def test_verify_laws(self):
        """Test all laws are verified."""
        laws = self.substrate.verify_laws()
        
        self.assertTrue(all(laws.values()))
    
    def test_apply_pressure_no_stress(self):
        """Test L-001: Apply pressure, no stress."""
        result = self.substrate.apply_pressure(5.0, "test")
        
        self.assertEqual(result["stress"], 0.0)
        self.assertEqual(result["law"], "L-001: STRESS_ELIMINATION")
    
    def test_deploy_face(self):
        """Test L-003: Deploy sovereign face."""
        face = self.substrate.deploy_face("company_1", 100)
        
        self.assertIsNotNone(face)
        self.assertEqual(face.company_id, "company_1")
        self.assertEqual(self.substrate._state.active_faces, 1)
    
    def test_deploy_faces_batch(self):
        """Test batch face deployment."""
        companies = [
            {"company_id": f"company_{i}", "employee_count": 50}
            for i in range(10)
        ]
        
        faces = self.substrate.deploy_faces_batch(companies)
        
        self.assertEqual(len(faces), 10)
        self.assertEqual(self.substrate._state.active_faces, 10)
    
    def test_scale_capacity(self):
        """Test L-002: Scale capacity >= 5000."""
        scale = self.substrate.get_scale_status()
        
        self.assertGreaterEqual(scale["max_scale"], 5000)
        self.assertTrue(scale["can_scale_to_5000"])
    
    def test_faces_dont_affect_core(self):
        """Test L-003: Faces don't affect core."""
        initial_coherence = self.substrate._state.coherence
        
        # Deploy many faces
        for i in range(100):
            self.substrate.deploy_face(f"company_{i}", 50)
        
        # Core coherence should be unaffected
        self.assertEqual(self.substrate._state.coherence, initial_coherence)
    
    def test_cognitive_processing(self):
        """Test L-004: Cognitive processing."""
        result = self.substrate.process_cognitive("challenge", {})
        
        self.assertEqual(result["stress"], 0.0)
    
    def test_status(self):
        """Test full status."""
        status = self.substrate.status()
        
        self.assertIn("substrate_id", status)
        self.assertIn("laws_verified", status)
        self.assertEqual(status["stress_level"], 0.0)


class TestAgentMetrics(unittest.TestCase):
    """Test AgentMetrics functionality."""
    
    def test_create_metrics(self):
        """Test creating agent metrics."""
        metrics = AgentMetrics(
            agent_id="test_agent",
            agent_type="test",
        )
        
        self.assertEqual(metrics.cycles_completed, 0)
        self.assertEqual(metrics.tests_run, 0)
    
    def test_to_dict_no_stress(self):
        """Test serialization shows no stress."""
        metrics = AgentMetrics()
        d = metrics.to_dict()
        
        self.assertEqual(d["stress_level"], 0.0)


class TestTestResult(unittest.TestCase):
    """Test TestResult functionality."""
    
    def test_create_result(self):
        """Test creating test result."""
        result = TestResult(
            test_name="test_something",
            passed=True,
        )
        
        self.assertIsNotNone(result.test_id)
        self.assertTrue(result.passed)
    
    def test_failed_result(self):
        """Test failed result."""
        result = TestResult(
            test_name="test_failure",
            passed=False,
            error="Something went wrong",
        )
        
        self.assertFalse(result.passed)
        self.assertIsNotNone(result.error)


class TestContinuousTestAgent(unittest.TestCase):
    """Test ContinuousTestAgent functionality."""
    
    def setUp(self):
        reset_substrate()
        self.agent = ContinuousTestAgent()
    
    def test_create_agent(self):
        """Test creating agent."""
        self.assertEqual(self.agent.agent_type, "continuous_test")
        self.assertFalse(self.agent.is_on)
    
    def test_turn_on_off(self):
        """Test turning agent on and off."""
        self.agent.turn_on()
        self.assertTrue(self.agent.is_on)
        self.assertEqual(self.agent._metrics.state, AgentState.ON)
        
        self.agent.turn_off()
        self.assertFalse(self.agent.is_on)
        self.assertEqual(self.agent._metrics.state, AgentState.OFF)
    
    def test_run_cycle(self):
        """Test running a cycle."""
        self.agent.turn_on()
        results = self.agent.run_cycle()
        self.agent.turn_off()
        
        self.assertGreater(len(results), 0)
        self.assertGreater(self.agent._metrics.tests_run, 0)
    
    def test_run_sync(self):
        """Test synchronous execution."""
        results = self.agent.run_sync(cycles=3)
        
        self.assertGreater(len(results), 0)
        self.assertEqual(self.agent._metrics.cycles_completed, 3)
    
    def test_stress_elimination_test_passes(self):
        """Test that stress elimination test passes."""
        self.agent.turn_on()
        results = self.agent.run_cycle()
        self.agent.turn_off()
        
        stress_test = next(
            (r for r in results if "stress_elimination" in r.test_name),
            None
        )
        self.assertIsNotNone(stress_test)
        self.assertTrue(stress_test.passed)
    
    def test_register_custom_test(self):
        """Test registering custom tests."""
        def custom_test():
            return TestResult(test_name="custom", passed=True)
        
        initial_count = len(self.agent._test_registry)
        self.agent.register_test(custom_test)
        
        self.assertEqual(len(self.agent._test_registry), initial_count + 1)


class TestStressTestAgent(unittest.TestCase):
    """Test StressTestAgent functionality."""
    
    def setUp(self):
        reset_substrate()
        self.agent = StressTestAgent(intensity=1.0)
    
    def test_create_agent(self):
        """Test creating agent."""
        self.assertEqual(self.agent.agent_type, "stress_test")
    
    def test_run_cycle_no_stress(self):
        """Test stress tests produce no stress."""
        self.agent.turn_on()
        results = self.agent.run_cycle()
        self.agent.turn_off()
        
        # All tests should pass (stress = 0)
        for result in results:
            self.assertTrue(result.passed, f"Failed: {result.test_name}")
    
    def test_set_intensity(self):
        """Test setting intensity."""
        self.agent.set_intensity(5.0)
        self.assertEqual(self.agent._intensity, 5.0)
        
        # Test bounds
        self.agent.set_intensity(100.0)
        self.assertEqual(self.agent._intensity, 10.0)  # Capped


class TestEdgeCaseAgent(unittest.TestCase):
    """Test EdgeCaseAgent functionality."""
    
    def setUp(self):
        reset_substrate()
        self.agent = EdgeCaseAgent()
    
    def test_create_agent(self):
        """Test creating agent."""
        self.assertEqual(self.agent.agent_type, "edge_case")
    
    def test_run_cycle(self):
        """Test edge case discovery."""
        self.agent.turn_on()
        results = self.agent.run_cycle()
        self.agent.turn_off()
        
        self.assertGreater(len(results), 0)


class TestWorkflowTestAgent(unittest.TestCase):
    """Test WorkflowTestAgent functionality."""
    
    def setUp(self):
        reset_substrate()
        self.agent = WorkflowTestAgent()
    
    def test_create_agent(self):
        """Test creating agent."""
        self.assertEqual(self.agent.agent_type, "workflow_test")
    
    def test_run_workflows(self):
        """Test workflow execution."""
        self.agent.turn_on()
        results = self.agent.run_cycle()
        self.agent.turn_off()
        
        # Should have multiple workflow results
        self.assertGreater(len(results), 0)


class TestIntegrationTestAgent(unittest.TestCase):
    """Test IntegrationTestAgent functionality."""
    
    def setUp(self):
        reset_substrate()
        self.agent = IntegrationTestAgent()
    
    def test_create_agent(self):
        """Test creating agent."""
        self.assertEqual(self.agent.agent_type, "integration_test")
    
    def test_run_integration_tests(self):
        """Test integration tests."""
        self.agent.turn_on()
        results = self.agent.run_cycle()
        self.agent.turn_off()
        
        self.assertGreater(len(results), 0)


class TestTestOrchestrator(unittest.TestCase):
    """Test TestOrchestrator functionality."""
    
    def setUp(self):
        reset_substrate()
        self.orchestrator = reset_orchestrator()
    
    def test_create_orchestrator(self):
        """Test creating orchestrator."""
        self.assertIsNotNone(self.orchestrator.orchestrator_id)
        self.assertEqual(self.orchestrator._state, OrchestratorState.OFF)
    
    def test_default_agents_registered(self):
        """Test default agents are registered."""
        agents = self.orchestrator.list_agents()
        
        # Should have 5 default agents
        self.assertEqual(len(agents), 5)
    
    def test_start_stop(self):
        """Test starting and stopping."""
        self.orchestrator.start()
        self.assertEqual(self.orchestrator._state, OrchestratorState.RUNNING)
        self.assertGreater(self.orchestrator._metrics.active_agents, 0)
        
        self.orchestrator.stop()
        self.assertEqual(self.orchestrator._state, OrchestratorState.OFF)
        self.assertEqual(self.orchestrator._metrics.active_agents, 0)
    
    def test_run_all_cycles(self):
        """Test running all agents."""
        self.orchestrator.start()
        results = self.orchestrator.run_all_cycles(cycles_per_agent=1)
        self.orchestrator.stop()
        
        # Should have results from each agent
        self.assertEqual(len(results), 5)
    
    def test_run_sync(self):
        """Test synchronous execution."""
        result = self.orchestrator.run_sync(total_cycles=3)
        
        self.assertEqual(result["cycles_completed"], 3)
        self.assertIn("metrics", result)
    
    def test_health_check(self):
        """Test health check."""
        self.orchestrator.start()
        self.orchestrator.run_all_cycles(cycles_per_agent=1)
        health = self.orchestrator.health_check()
        self.orchestrator.stop()
        
        self.assertIn("healthy", health)
        self.assertEqual(health["stress_level"], 0.0)
    
    def test_status_no_stress(self):
        """Test status shows no stress."""
        status = self.orchestrator.status()
        
        self.assertEqual(status["stress_level"], 0.0)
    
    def test_register_unregister_agent(self):
        """Test agent registration."""
        custom_agent = ContinuousTestAgent()
        initial_count = self.orchestrator._metrics.total_agents
        
        self.orchestrator.register_agent(custom_agent)
        self.assertEqual(self.orchestrator._metrics.total_agents, initial_count + 1)
        
        self.orchestrator.unregister_agent(custom_agent.agent_id)
        self.assertEqual(self.orchestrator._metrics.total_agents, initial_count)


class TestScaleArchitecture(unittest.TestCase):
    """Test 0-5000 scale architecture."""
    
    def setUp(self):
        self.substrate = reset_substrate()
    
    def test_scale_to_100_companies(self):
        """Test scaling to 100 companies."""
        companies = [
            {"company_id": f"company_{i}", "employee_count": 50}
            for i in range(100)
        ]
        
        faces = self.substrate.deploy_faces_batch(companies)
        
        self.assertEqual(len(faces), 100)
        
        # Total entities: 100 companies + 50*100 employees = 5100
        scale = self.substrate.get_scale_status()
        self.assertEqual(scale["current_entities"], 5100)
    
    def test_scale_doesnt_affect_coherence(self):
        """Test scale doesn't affect core coherence."""
        initial_coherence = self.substrate._state.coherence
        
        # Deploy many faces
        companies = [
            {"company_id": f"company_{i}", "employee_count": 100}
            for i in range(50)
        ]
        self.substrate.deploy_faces_batch(companies)
        
        # Coherence unchanged - L-003: Faces don't affect core
        self.assertEqual(self.substrate._state.coherence, initial_coherence)
    
    def test_expand_scale(self):
        """Test expanding scale capacity."""
        self.substrate.expand_scale(10000)
        
        scale = self.substrate.get_scale_status()
        self.assertEqual(scale["max_scale"], 10000)


class TestStressEliminationLaw(unittest.TestCase):
    """Test L-001: Stress Elimination Law throughout the system."""
    
    def test_substrate_no_stress(self):
        """Test substrate never has stress."""
        substrate = reset_substrate()
        
        # Apply various pressures
        for pressure in [0.0, 0.5, 1.0, 5.0, 100.0]:
            result = substrate.apply_pressure(pressure, "test")
            self.assertEqual(result["stress"], 0.0)
    
    def test_agent_metrics_no_stress(self):
        """Test agent metrics never show stress."""
        agent = ContinuousTestAgent()
        agent.run_sync(cycles=10)
        
        metrics = agent.get_metrics().to_dict()
        self.assertEqual(metrics["stress_level"], 0.0)
    
    def test_orchestrator_no_stress(self):
        """Test orchestrator never shows stress."""
        orchestrator = reset_orchestrator()
        orchestrator.run_sync(total_cycles=5)
        
        status = orchestrator.status()
        self.assertEqual(status["stress_level"], 0.0)
        
        health = orchestrator.health_check()
        self.assertEqual(health["stress_level"], 0.0)


if __name__ == "__main__":
    unittest.main()
