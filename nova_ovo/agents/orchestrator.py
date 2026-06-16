"""
TEST ORCHESTRATOR — Coordinates All Internal Agents
=====================================================

MEDINA Sovereign Architecture
Author: Freddy (Founder Architect)

The Test Orchestrator wires all internal agents together.
They complete all the workflows, like complete organisms.

This is the "big model" that coordinates:
- ContinuousTestAgent
- StressTestAgent
- EdgeCaseAgent
- WorkflowTestAgent
- IntegrationTestAgent

All running at dynamic speeds, testing everything,
at multiple points simultaneously.
"""

from __future__ import annotations

import asyncio
import math
import time
import uuid
import threading
from concurrent.futures import ThreadPoolExecutor, Future, as_completed
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Set

# Import agents
from .internal_agents import (
    InternalAgent,
    ContinuousTestAgent,
    StressTestAgent,
    EdgeCaseAgent,
    WorkflowTestAgent,
    IntegrationTestAgent,
    AgentState,
    AgentMetrics,
    TestResult,
)

# Import substrate
from .substrate import (
    get_substrate,
    SovereignSubstrate,
    PHI,
)


# =================================================================== #
# ORCHESTRATOR STATE                                                    #
# =================================================================== #

class OrchestratorState(str, Enum):
    """Orchestrator operational states."""
    OFF = "off"
    RUNNING = "running"
    PAUSED = "paused"


@dataclass
class OrchestratorMetrics:
    """Metrics for the test orchestrator."""
    
    orchestrator_id: str = ""
    
    # Agent counts
    total_agents: int = 0
    active_agents: int = 0
    
    # Aggregate test metrics
    total_cycles: int = 0
    total_tests_run: int = 0
    total_tests_passed: int = 0
    total_tests_failed: int = 0
    
    # Discoveries
    total_edges_found: int = 0
    total_fixes_applied: int = 0
    
    # Performance
    uptime_seconds: float = 0.0
    tests_per_second: float = 0.0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "orchestrator_id": self.orchestrator_id,
            "total_agents": self.total_agents,
            "active_agents": self.active_agents,
            "total_cycles": self.total_cycles,
            "total_tests_run": self.total_tests_run,
            "total_tests_passed": self.total_tests_passed,
            "total_tests_failed": self.total_tests_failed,
            "pass_rate": round(self.total_tests_passed / max(1, self.total_tests_run), 4),
            "total_edges_found": self.total_edges_found,
            "total_fixes_applied": self.total_fixes_applied,
            "uptime_seconds": round(self.uptime_seconds, 2),
            "tests_per_second": round(self.tests_per_second, 2),
            "stress_level": 0.0,  # ALWAYS ZERO
        }


# =================================================================== #
# TEST ORCHESTRATOR — The Big Model                                     #
# =================================================================== #

class TestOrchestrator:
    """
    Test Orchestrator — Coordinates all internal AI testing agents.
    
    This is the "big model" that wires them all together.
    They complete all the workflows, like complete organisms.
    
    The orchestrator:
    - Manages agent lifecycle (on/off)
    - Runs agents in parallel
    - Collects and aggregates results
    - Coordinates testing at multiple points simultaneously
    
    No feelings. No stress. Just constant testing and improvement.
    """
    
    def __init__(self, parallelism: int = 5) -> None:
        self.orchestrator_id = f"orch_{uuid.uuid4().hex[:8]}"
        self._state = OrchestratorState.OFF
        self._substrate = get_substrate()
        
        # Agent registry
        self._agents: Dict[str, InternalAgent] = {}
        
        # Execution
        self._executor: Optional[ThreadPoolExecutor] = None
        self._parallelism = parallelism
        
        # Metrics
        self._metrics = OrchestratorMetrics(orchestrator_id=self.orchestrator_id)
        self._start_time: Optional[float] = None
        
        # Results aggregation
        self._all_results: List[TestResult] = []
        self._max_results = 10000
        
        # Initialize default agents
        self._initialize_default_agents()
    
    def _initialize_default_agents(self) -> None:
        """Initialize the default set of internal agents."""
        self.register_agent(ContinuousTestAgent())
        self.register_agent(StressTestAgent(intensity=1.0))
        self.register_agent(EdgeCaseAgent())
        self.register_agent(WorkflowTestAgent())
        self.register_agent(IntegrationTestAgent())
        
        self._metrics.total_agents = len(self._agents)
    
    # ------------------------------------------------------------------ #
    # AGENT MANAGEMENT                                                     #
    # ------------------------------------------------------------------ #
    
    def register_agent(self, agent: InternalAgent) -> None:
        """Register an agent with the orchestrator."""
        self._agents[agent.agent_id] = agent
        self._metrics.total_agents = len(self._agents)
    
    def unregister_agent(self, agent_id: str) -> bool:
        """Unregister an agent."""
        if agent_id in self._agents:
            agent = self._agents[agent_id]
            agent.turn_off()
            del self._agents[agent_id]
            self._metrics.total_agents = len(self._agents)
            return True
        return False
    
    def get_agent(self, agent_id: str) -> Optional[InternalAgent]:
        """Get an agent by ID."""
        return self._agents.get(agent_id)
    
    def list_agents(self) -> List[Dict[str, Any]]:
        """List all registered agents."""
        return [agent.status() for agent in self._agents.values()]
    
    # ------------------------------------------------------------------ #
    # ORCHESTRATION LIFECYCLE                                              #
    # ------------------------------------------------------------------ #
    
    def start(self) -> None:
        """Start the orchestrator and all agents."""
        if self._state == OrchestratorState.RUNNING:
            return
        
        self._state = OrchestratorState.RUNNING
        self._start_time = time.time()
        self._executor = ThreadPoolExecutor(max_workers=self._parallelism)
        
        # Turn on all agents
        for agent in self._agents.values():
            agent.turn_on()
        
        self._metrics.active_agents = len(self._agents)
    
    def stop(self) -> None:
        """Stop the orchestrator and all agents."""
        self._state = OrchestratorState.OFF
        
        # Turn off all agents
        for agent in self._agents.values():
            agent.turn_off()
        
        self._metrics.active_agents = 0
        
        # Shutdown executor
        if self._executor:
            self._executor.shutdown(wait=False)
            self._executor = None
        
        # Update uptime
        if self._start_time:
            self._metrics.uptime_seconds += time.time() - self._start_time
    
    def pause(self) -> None:
        """Pause the orchestrator."""
        self._state = OrchestratorState.PAUSED
        for agent in self._agents.values():
            agent._running = False
    
    def resume(self) -> None:
        """Resume the orchestrator."""
        if self._state == OrchestratorState.PAUSED:
            self._state = OrchestratorState.RUNNING
            for agent in self._agents.values():
                agent.turn_on()
    
    # ------------------------------------------------------------------ #
    # TEST EXECUTION                                                       #
    # ------------------------------------------------------------------ #
    
    def run_all_cycles(self, cycles_per_agent: int = 1) -> Dict[str, List[TestResult]]:
        """
        Run all agents for specified cycles.
        
        Tests everything at multiple points simultaneously.
        """
        if self._state != OrchestratorState.RUNNING:
            self.start()
        
        results_by_agent: Dict[str, List[TestResult]] = {}
        
        if self._executor is None:
            return results_by_agent
        
        # Submit all agents to run in parallel
        futures: Dict[Future, str] = {}
        
        for agent_id, agent in self._agents.items():
            future = self._executor.submit(
                self._run_agent_cycles,
                agent,
                cycles_per_agent,
            )
            futures[future] = agent_id
        
        # Collect results
        for future in as_completed(futures):
            agent_id = futures[future]
            try:
                results = future.result()
                results_by_agent[agent_id] = results
                self._process_results(results)
            except Exception as e:
                results_by_agent[agent_id] = [TestResult(
                    test_name="agent_execution",
                    passed=False,
                    error=str(e),
                )]
        
        self._metrics.total_cycles += cycles_per_agent
        self._update_performance_metrics()
        
        return results_by_agent
    
    def _run_agent_cycles(
        self,
        agent: InternalAgent,
        cycles: int,
    ) -> List[TestResult]:
        """Run an agent for specified cycles."""
        all_results = []
        for _ in range(cycles):
            results = agent.run_cycle()
            all_results.extend(results)
        return all_results
    
    def _process_results(self, results: List[TestResult]) -> None:
        """Process and aggregate results."""
        for result in results:
            self._metrics.total_tests_run += 1
            if result.passed:
                self._metrics.total_tests_passed += 1
            else:
                self._metrics.total_tests_failed += 1
        
        self._all_results.extend(results)
        
        # Trim history
        if len(self._all_results) > self._max_results:
            self._all_results = self._all_results[-self._max_results:]
    
    def _update_performance_metrics(self) -> None:
        """Update performance metrics."""
        if self._start_time:
            elapsed = time.time() - self._start_time
            if elapsed > 0:
                self._metrics.tests_per_second = self._metrics.total_tests_run / elapsed
    
    # ------------------------------------------------------------------ #
    # CONTINUOUS OPERATION                                                 #
    # ------------------------------------------------------------------ #
    
    async def run_continuous(
        self,
        max_cycles: Optional[int] = None,
        cycle_interval_seconds: float = 1.0,
    ) -> None:
        """
        Run continuously - always on, constantly testing.
        
        This is the "always-on" operation mode.
        The agents keep working until stopped.
        """
        self.start()
        cycles = 0
        
        while self._state == OrchestratorState.RUNNING:
            self.run_all_cycles(cycles_per_agent=1)
            cycles += 1
            
            if max_cycles and cycles >= max_cycles:
                break
            
            await asyncio.sleep(cycle_interval_seconds)
        
        self.stop()
    
    def run_sync(self, total_cycles: int = 10) -> Dict[str, Any]:
        """
        Run synchronously for specified total cycles.
        
        Good for testing the orchestrator itself.
        """
        self.start()
        
        all_results: Dict[str, List[TestResult]] = {}
        
        for _ in range(total_cycles):
            cycle_results = self.run_all_cycles(cycles_per_agent=1)
            for agent_id, results in cycle_results.items():
                if agent_id not in all_results:
                    all_results[agent_id] = []
                all_results[agent_id].extend(results)
        
        self.stop()
        
        return {
            "cycles_completed": total_cycles,
            "results_by_agent": {
                agent_id: [r.to_dict() for r in results[-10:]]  # Last 10 per agent
                for agent_id, results in all_results.items()
            },
            "metrics": self._metrics.to_dict(),
        }
    
    # ------------------------------------------------------------------ #
    # METRICS & STATUS                                                     #
    # ------------------------------------------------------------------ #
    
    def get_metrics(self) -> OrchestratorMetrics:
        """Get orchestrator metrics."""
        return self._metrics
    
    def get_results(self, limit: int = 100) -> List[TestResult]:
        """Get recent results from all agents."""
        return self._all_results[-limit:]
    
    def get_failed_tests(self, limit: int = 100) -> List[TestResult]:
        """Get recent failed tests."""
        failed = [r for r in self._all_results if not r.passed]
        return failed[-limit:]
    
    def status(self) -> Dict[str, Any]:
        """Get full orchestrator status."""
        return {
            "orchestrator_id": self.orchestrator_id,
            "state": self._state.value,
            "agents": self.list_agents(),
            "metrics": self._metrics.to_dict(),
            "recent_failures": len(self.get_failed_tests(100)),
            "substrate_status": self._substrate.status(),
            "law": "L-005: Agents are ALWAYS-ON, not alive",
            "stress_level": 0.0,  # ALWAYS ZERO
        }
    
    def health_check(self) -> Dict[str, Any]:
        """Quick health check."""
        return {
            "healthy": self._metrics.total_tests_failed == 0 or (
                self._metrics.total_tests_passed / max(1, self._metrics.total_tests_run) > 0.95
            ),
            "pass_rate": round(
                self._metrics.total_tests_passed / max(1, self._metrics.total_tests_run),
                4
            ),
            "agents_active": self._metrics.active_agents,
            "total_tests": self._metrics.total_tests_run,
            "stress_level": 0.0,  # ALWAYS ZERO
        }


# =================================================================== #
# ORCHESTRATOR SINGLETON — Global Access Point                          #
# =================================================================== #

_orchestrator_instance: Optional[TestOrchestrator] = None


def get_orchestrator() -> TestOrchestrator:
    """Get or create the global orchestrator instance."""
    global _orchestrator_instance
    if _orchestrator_instance is None:
        _orchestrator_instance = TestOrchestrator()
    return _orchestrator_instance


def reset_orchestrator() -> TestOrchestrator:
    """Reset the orchestrator (for testing)."""
    global _orchestrator_instance
    if _orchestrator_instance:
        _orchestrator_instance.stop()
    _orchestrator_instance = TestOrchestrator()
    return _orchestrator_instance
