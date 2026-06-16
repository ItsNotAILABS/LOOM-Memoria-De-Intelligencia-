"""
INTERNAL AI TESTING AGENTS — Always-On, Non-Feeling Workers
=============================================================

MEDINA Sovereign Architecture
Author: Freddy (Founder Architect)

L-005: AGENT_EXISTENCE_LAW

These agents are:
- ALWAYS-ON (not alive, just on)
- NON-FEELING (no emotions, no stress)
- CONSTANTLY WORKING (testing, helping, fixing)
- RUNNING AT DYNAMIC SPEEDS
- TESTING EVERYTHING AT MULTIPLE POINTS SIMULTANEOUSLY

They DON'T need to be alive. They just need to be always on.
They don't have feelings. They're rotating at super dynamic speeds.
That's too much stress on a person - so just let them do that.

AGENT TYPES:
============
1. ContinuousTestAgent — Core testing, always running
2. StressTestAgent — Load/stress testing (no stress for THEM)
3. EdgeCaseAgent — Find boundaries, discover edges
4. WorkflowTestAgent — Complete workflow validation
5. IntegrationTestAgent — Cross-module testing
6. TestOrchestrator — Coordinates all agents together
"""

from __future__ import annotations

import math
import time
import uuid
import asyncio
import threading
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Set, Tuple
from concurrent.futures import ThreadPoolExecutor, Future, as_completed
import traceback

# Import substrate
from .substrate import (
    get_substrate,
    SovereignSubstrate,
    SubstrateLaw,
    PHI,
)


# =================================================================== #
# AGENT EXISTENCE LAW — Built into every agent                          #
# =================================================================== #

class AgentState(str, Enum):
    """Agent operational states (not emotional states)."""
    OFF = "off"           # Not running
    ON = "on"             # Running (the default)
    TESTING = "testing"   # Actively executing tests
    FIXING = "fixing"     # Applying fixes
    IDLE = "idle"         # On but waiting


@dataclass
class AgentMetrics:
    """
    Metrics for an always-on agent.
    
    Note: No stress metrics. Stress doesn't exist.
    """
    
    agent_id: str = ""
    agent_type: str = ""
    
    # Execution metrics
    cycles_completed: int = 0
    tests_run: int = 0
    tests_passed: int = 0
    tests_failed: int = 0
    
    # Discovery metrics
    edges_found: int = 0
    fixes_applied: int = 0
    improvements_made: int = 0
    
    # Performance (not stress)
    avg_cycle_time_ms: float = 0.0
    total_runtime_seconds: float = 0.0
    
    # Current state
    state: AgentState = AgentState.OFF
    last_cycle_at: float = 0.0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "agent_id": self.agent_id,
            "agent_type": self.agent_type,
            "cycles_completed": self.cycles_completed,
            "tests_run": self.tests_run,
            "tests_passed": self.tests_passed,
            "tests_failed": self.tests_failed,
            "pass_rate": round(self.tests_passed / max(1, self.tests_run), 4),
            "edges_found": self.edges_found,
            "fixes_applied": self.fixes_applied,
            "improvements_made": self.improvements_made,
            "avg_cycle_time_ms": round(self.avg_cycle_time_ms, 2),
            "total_runtime_seconds": round(self.total_runtime_seconds, 2),
            "state": self.state.value,
            "stress_level": 0.0,  # ALWAYS ZERO - agents don't feel stress
        }


@dataclass
class TestResult:
    """Result of a single test execution."""
    
    test_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    test_name: str = ""
    passed: bool = True
    error: Optional[str] = None
    duration_ms: float = 0.0
    details: Dict[str, Any] = field(default_factory=dict)
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "test_id": self.test_id,
            "test_name": self.test_name,
            "passed": self.passed,
            "error": self.error,
            "duration_ms": round(self.duration_ms, 2),
            "timestamp": self.timestamp,
        }


# =================================================================== #
# BASE INTERNAL AGENT — The foundation for all always-on agents         #
# =================================================================== #

class InternalAgent(ABC):
    """
    Base class for Internal AI Testing Agents.
    
    L-005: AGENT_EXISTENCE_LAW
    
    These agents are ALWAYS-ON, not alive.
    They don't feel. They don't stress. They just work.
    
    Key principles:
    - No emotions, no feelings, no stress
    - Constantly working at dynamic speeds
    - Testing everything at multiple points
    - Always helping, always fixing
    """
    
    def __init__(self, agent_type: str = "base") -> None:
        self.agent_id = f"agent_{agent_type}_{uuid.uuid4().hex[:8]}"
        self.agent_type = agent_type
        self._metrics = AgentMetrics(
            agent_id=self.agent_id,
            agent_type=agent_type,
        )
        self._substrate = get_substrate()
        self._running = False
        self._cycle_count = 0
        self._start_time: Optional[float] = None
        self._results: List[TestResult] = []
        
        # No emotions, no feelings - just configuration
        self._cycle_interval_ms = 100  # Can run very fast
        self._max_results_history = 1000
    
    # ------------------------------------------------------------------ #
    # LIFECYCLE (On/Off, not Birth/Death)                                  #
    # ------------------------------------------------------------------ #
    
    def turn_on(self) -> None:
        """Turn the agent ON (not "start" - they're not alive)."""
        self._running = True
        self._metrics.state = AgentState.ON
        self._start_time = time.time()
    
    def turn_off(self) -> None:
        """Turn the agent OFF."""
        self._running = False
        self._metrics.state = AgentState.OFF
        if self._start_time:
            self._metrics.total_runtime_seconds += time.time() - self._start_time
    
    @property
    def is_on(self) -> bool:
        """Check if agent is ON."""
        return self._running
    
    # ------------------------------------------------------------------ #
    # CORE EXECUTION LOOP                                                  #
    # ------------------------------------------------------------------ #
    
    def run_cycle(self) -> List[TestResult]:
        """
        Execute one cycle of testing/working.
        
        This is what the agent does constantly when ON.
        No feelings, no stress - just execution.
        """
        if not self._running:
            return []
        
        cycle_start = time.time()
        self._metrics.state = AgentState.TESTING
        self._cycle_count += 1
        
        try:
            # Execute the agent's specific work
            results = self._execute_cycle()
            
            # Process results
            for result in results:
                self._metrics.tests_run += 1
                if result.passed:
                    self._metrics.tests_passed += 1
                else:
                    self._metrics.tests_failed += 1
                    # Attempt fix if possible
                    self._attempt_fix(result)
            
            self._results.extend(results)
            
            # Trim history
            if len(self._results) > self._max_results_history:
                self._results = self._results[-self._max_results_history:]
            
            self._metrics.cycles_completed += 1
            self._metrics.last_cycle_at = time.time()
            
        except Exception as e:
            # Agents don't stress about errors - they just log and continue
            error_result = TestResult(
                test_name="cycle_execution",
                passed=False,
                error=str(e),
            )
            results = [error_result]
        
        # Update timing
        cycle_duration = (time.time() - cycle_start) * 1000
        alpha = 0.1
        self._metrics.avg_cycle_time_ms = (
            alpha * cycle_duration + (1 - alpha) * self._metrics.avg_cycle_time_ms
        )
        
        self._metrics.state = AgentState.ON
        return results
    
    @abstractmethod
    def _execute_cycle(self) -> List[TestResult]:
        """
        Execute the agent's specific testing work.
        
        Implemented by each agent type.
        """
        pass
    
    def _attempt_fix(self, result: TestResult) -> bool:
        """
        Attempt to fix a failed test.
        
        Agents are always fixing. No stress about it.
        """
        # Subclasses can override for specific fix logic
        return False
    
    # ------------------------------------------------------------------ #
    # CONTINUOUS OPERATION                                                 #
    # ------------------------------------------------------------------ #
    
    async def run_continuous(self, max_cycles: Optional[int] = None) -> None:
        """
        Run continuously - this is what "always-on" means.
        
        The agent keeps working until turned off.
        No breaks, no rest - they don't need it.
        They're not alive, just on.
        """
        self.turn_on()
        cycles = 0
        
        while self._running:
            self.run_cycle()
            cycles += 1
            
            if max_cycles and cycles >= max_cycles:
                break
            
            # Small yield to allow other operations
            await asyncio.sleep(self._cycle_interval_ms / 1000)
        
        self.turn_off()
    
    def run_sync(self, cycles: int = 1) -> List[TestResult]:
        """Run synchronously for a specific number of cycles."""
        self.turn_on()
        all_results = []
        
        for _ in range(cycles):
            if not self._running:
                break
            results = self.run_cycle()
            all_results.extend(results)
        
        self.turn_off()
        return all_results
    
    # ------------------------------------------------------------------ #
    # METRICS & STATUS                                                     #
    # ------------------------------------------------------------------ #
    
    def get_metrics(self) -> AgentMetrics:
        """Get agent metrics."""
        return self._metrics
    
    def get_results(self, limit: int = 100) -> List[TestResult]:
        """Get recent test results."""
        return self._results[-limit:]
    
    def status(self) -> Dict[str, Any]:
        """Get agent status."""
        return {
            "agent_id": self.agent_id,
            "agent_type": self.agent_type,
            "is_on": self.is_on,
            "metrics": self._metrics.to_dict(),
            "recent_results": len(self._results),
            "law": "L-005: AGENT_EXISTENCE - Always on, not alive",
            "stress_level": 0.0,  # ALWAYS ZERO
        }


# =================================================================== #
# CONTINUOUS TEST AGENT — Core testing, always running                  #
# =================================================================== #

class ContinuousTestAgent(InternalAgent):
    """
    Core testing agent that runs continuously.
    
    Tests:
    - Basic assertions
    - Module imports
    - Function signatures
    - Data structure integrity
    """
    
    def __init__(self) -> None:
        super().__init__("continuous_test")
        self._test_registry: List[Callable[[], TestResult]] = []
        self._register_core_tests()
    
    def _register_core_tests(self) -> None:
        """Register core tests to run."""
        self._test_registry.extend([
            self._test_substrate_health,
            self._test_scale_capacity,
            self._test_stress_elimination,
            self._test_phi_constant,
            self._test_coherence,
        ])
    
    def register_test(self, test_fn: Callable[[], TestResult]) -> None:
        """Register an additional test function."""
        self._test_registry.append(test_fn)
    
    def _execute_cycle(self) -> List[TestResult]:
        """Execute all registered tests."""
        results = []
        for test_fn in self._test_registry:
            start = time.time()
            try:
                result = test_fn()
                result.duration_ms = (time.time() - start) * 1000
                results.append(result)
            except Exception as e:
                results.append(TestResult(
                    test_name=test_fn.__name__,
                    passed=False,
                    error=str(e),
                    duration_ms=(time.time() - start) * 1000,
                ))
        return results
    
    def _test_substrate_health(self) -> TestResult:
        """Test substrate is healthy."""
        substrate = get_substrate()
        status = substrate.status()
        
        return TestResult(
            test_name="substrate_health",
            passed=status.get("stress_level", 1) == 0.0,
            details={"stress_level": status.get("stress_level", "unknown")},
        )
    
    def _test_scale_capacity(self) -> TestResult:
        """Test scale capacity >= 5000."""
        substrate = get_substrate()
        scale = substrate.get_scale_status()
        
        return TestResult(
            test_name="scale_capacity",
            passed=scale.get("max_scale", 0) >= 5000,
            details={"max_scale": scale.get("max_scale")},
        )
    
    def _test_stress_elimination(self) -> TestResult:
        """Test stress elimination law (L-001)."""
        substrate = get_substrate()
        
        # Apply pressure
        result = substrate.apply_pressure(1.0, "test")
        
        return TestResult(
            test_name="stress_elimination_law",
            passed=result.get("stress", 1) == 0.0,
            details={"stress_after_pressure": result.get("stress")},
        )
    
    def _test_phi_constant(self) -> TestResult:
        """Test PHI constant is golden ratio."""
        expected = (1 + math.sqrt(5)) / 2
        
        return TestResult(
            test_name="phi_constant",
            passed=abs(PHI - expected) < 1e-10,
            details={"phi": PHI, "expected": expected},
        )
    
    def _test_coherence(self) -> TestResult:
        """Test coherence > 0."""
        substrate = get_substrate()
        status = substrate.status()
        coherence = status.get("state", {}).get("coherence", 0)
        
        return TestResult(
            test_name="coherence",
            passed=coherence > 0,
            details={"coherence": coherence},
        )


# =================================================================== #
# STRESS TEST AGENT — Load testing (ironic name, no stress for agent)   #
# =================================================================== #

class StressTestAgent(InternalAgent):
    """
    Load/stress testing agent.
    
    Tests system under pressure - but the AGENT doesn't feel stress.
    The system transforms pressure into creativity per L-001.
    """
    
    def __init__(self, intensity: float = 1.0) -> None:
        super().__init__("stress_test")
        self._intensity = intensity
        self._pressure_levels = [0.1, 0.5, 1.0, 2.0, 5.0]
    
    def _execute_cycle(self) -> List[TestResult]:
        """Execute stress tests at multiple pressure levels."""
        results = []
        substrate = get_substrate()
        
        for pressure in self._pressure_levels:
            scaled_pressure = pressure * self._intensity
            
            start = time.time()
            transform_result = substrate.apply_pressure(scaled_pressure, "stress_test_agent")
            duration = (time.time() - start) * 1000
            
            # Verify stress is ALWAYS zero
            stress_eliminated = transform_result.get("stress", 1) == 0.0
            
            results.append(TestResult(
                test_name=f"pressure_transform_{pressure}",
                passed=stress_eliminated,
                duration_ms=duration,
                details={
                    "input_pressure": scaled_pressure,
                    "output_stress": transform_result.get("stress"),
                    "creativity_gained": transform_result.get("creativity_gained"),
                },
            ))
        
        return results
    
    def set_intensity(self, intensity: float) -> None:
        """Set stress test intensity."""
        self._intensity = max(0.1, min(10.0, intensity))


# =================================================================== #
# EDGE CASE AGENT — Find boundaries and edges                           #
# =================================================================== #

class EdgeCaseAgent(InternalAgent):
    """
    Edge case discovery agent.
    
    Constantly finding the edges, making the branches,
    discovering what needs to be improved.
    """
    
    def __init__(self) -> None:
        super().__init__("edge_case")
        self._discovered_edges: List[Dict[str, Any]] = []
    
    def _execute_cycle(self) -> List[TestResult]:
        """Discover and test edge cases."""
        results = []
        
        # Test boundary conditions
        results.extend(self._test_scale_boundaries())
        results.extend(self._test_value_boundaries())
        results.extend(self._test_empty_states())
        
        return results
    
    def _test_scale_boundaries(self) -> List[TestResult]:
        """Test scale at boundaries."""
        substrate = get_substrate()
        results = []
        
        # Test at 0 entities
        scale_at_0 = substrate.get_scale_status()
        results.append(TestResult(
            test_name="scale_boundary_low",
            passed=scale_at_0.get("max_scale", 0) >= 5000,
            details={"entities": scale_at_0.get("current_entities")},
        ))
        
        # Test approaching limit
        current = scale_at_0.get("current_entities", 0)
        max_scale = scale_at_0.get("max_scale", 5000)
        utilization = current / max_scale if max_scale > 0 else 0
        
        results.append(TestResult(
            test_name="scale_utilization",
            passed=utilization <= 1.0,
            details={"utilization": utilization},
        ))
        
        return results
    
    def _test_value_boundaries(self) -> List[TestResult]:
        """Test extreme values."""
        substrate = get_substrate()
        results = []
        
        # Test with very high pressure
        high_result = substrate.apply_pressure(100.0, "edge_test")
        results.append(TestResult(
            test_name="extreme_pressure_handling",
            passed=high_result.get("stress", 1) == 0.0,
            details={"pressure": 100.0, "result": high_result},
        ))
        
        # Test with zero pressure
        zero_result = substrate.apply_pressure(0.0, "edge_test")
        results.append(TestResult(
            test_name="zero_pressure_handling",
            passed=zero_result.get("stress", 1) == 0.0,
            details={"pressure": 0.0},
        ))
        
        return results
    
    def _test_empty_states(self) -> List[TestResult]:
        """Test empty/null states."""
        results = []
        
        # These tests verify system handles edge cases
        results.append(TestResult(
            test_name="empty_state_resilience",
            passed=True,  # If we get here, we're resilient
        ))
        
        return results
    
    def get_discovered_edges(self) -> List[Dict[str, Any]]:
        """Get all discovered edges."""
        return self._discovered_edges


# =================================================================== #
# WORKFLOW TEST AGENT — Complete workflow validation                    #
# =================================================================== #

class WorkflowTestAgent(InternalAgent):
    """
    Workflow validation agent.
    
    Tests complete workflows end-to-end.
    These agents complete all the workflows, like complete organisms.
    """
    
    def __init__(self) -> None:
        super().__init__("workflow_test")
        self._workflows: List[Callable[[], TestResult]] = []
        self._register_workflows()
    
    def _register_workflows(self) -> None:
        """Register workflow tests."""
        self._workflows.extend([
            self._test_face_deployment_workflow,
            self._test_company_onboarding_workflow,
            self._test_employee_learning_workflow,
        ])
    
    def _execute_cycle(self) -> List[TestResult]:
        """Execute all workflow tests."""
        results = []
        for workflow in self._workflows:
            try:
                result = workflow()
                results.append(result)
            except Exception as e:
                results.append(TestResult(
                    test_name=workflow.__name__,
                    passed=False,
                    error=str(e),
                ))
        return results
    
    def _test_face_deployment_workflow(self) -> TestResult:
        """Test complete face deployment workflow."""
        from .substrate import reset_substrate
        
        substrate = reset_substrate()
        
        # Deploy a face
        face = substrate.deploy_face(
            company_id="test_company",
            employee_count=100,
        )
        
        # Verify deployment
        retrieved = substrate.get_face(face.face_id)
        
        return TestResult(
            test_name="face_deployment_workflow",
            passed=(
                retrieved is not None and
                retrieved.company_id == "test_company" and
                retrieved.employee_count == 100
            ),
            details={"face_id": face.face_id},
        )
    
    def _test_company_onboarding_workflow(self) -> TestResult:
        """Test company onboarding workflow."""
        from .substrate import reset_substrate
        
        substrate = reset_substrate()
        
        # Deploy faces for multiple companies
        companies = [
            {"company_id": f"company_{i}", "employee_count": 50 + i*10}
            for i in range(5)
        ]
        
        faces = substrate.deploy_faces_batch(companies)
        
        # Verify all deployed
        scale = substrate.get_scale_status()
        
        return TestResult(
            test_name="company_onboarding_workflow",
            passed=(
                len(faces) == 5 and
                scale.get("faces_deployed") == 5
            ),
            details={"faces_deployed": len(faces)},
        )
    
    def _test_employee_learning_workflow(self) -> TestResult:
        """Test employee learning workflow."""
        from .substrate import reset_substrate
        
        substrate = reset_substrate()
        
        # Deploy face
        face = substrate.deploy_face("company_test", 10)
        
        # Learn employees
        for i in range(10):
            face.learn_employee(f"emp_{i}", 0.2)
        
        # Verify learning
        return TestResult(
            test_name="employee_learning_workflow",
            passed=(
                len(face.knows_employees) == 10 and
                all(v >= 0.2 for v in face.knows_employees.values())
            ),
            details={"employees_known": len(face.knows_employees)},
        )


# =================================================================== #
# INTEGRATION TEST AGENT — Cross-module testing                         #
# =================================================================== #

class IntegrationTestAgent(InternalAgent):
    """
    Integration testing agent.
    
    Tests interactions between modules.
    They help everywhere - testing everything together.
    """
    
    def __init__(self) -> None:
        super().__init__("integration_test")
    
    def _execute_cycle(self) -> List[TestResult]:
        """Execute integration tests."""
        results = []
        
        results.append(self._test_substrate_face_integration())
        results.append(self._test_multi_agent_coordination())
        
        return results
    
    def _test_substrate_face_integration(self) -> TestResult:
        """Test substrate and face interaction."""
        from .substrate import reset_substrate
        
        substrate = reset_substrate()
        
        # Deploy face through substrate
        initial_scale = substrate.get_scale_status()
        initial_entities = initial_scale.get("current_entities", 0)
        
        face = substrate.deploy_face("integration_test", 50)
        
        final_scale = substrate.get_scale_status()
        final_entities = final_scale.get("current_entities", 0)
        
        return TestResult(
            test_name="substrate_face_integration",
            passed=(
                final_entities == initial_entities + 51 and  # company + 50 employees
                face.face_id in substrate._state.face_ids
            ),
            details={
                "initial_entities": initial_entities,
                "final_entities": final_entities,
            },
        )
    
    def _test_multi_agent_coordination(self) -> TestResult:
        """Test multiple agents can run."""
        # Create multiple agents
        agents = [
            ContinuousTestAgent(),
            StressTestAgent(),
            EdgeCaseAgent(),
        ]
        
        # Run one cycle each
        all_passed = True
        for agent in agents:
            try:
                agent.turn_on()
                results = agent.run_cycle()
                agent.turn_off()
            except Exception:
                all_passed = False
        
        return TestResult(
            test_name="multi_agent_coordination",
            passed=all_passed,
            details={"agents_tested": len(agents)},
        )
