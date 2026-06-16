"""
AI WORKFORCE TASK ORCHESTRATOR
================================

MEDINA Internal AI Workforce Management System

All employees are internal AIs. This orchestrator assigns tasks,
monitors health, and ensures all AIs are working continuously.

Author: Freddy (Founder Architect)
Status: CONSTITUTIONAL
"""

from __future__ import annotations

import asyncio
import time
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, List, Optional, Set, Callable
import json


# ============================================================================
# CONSTANTS
# ============================================================================

PHI = 1.618033988749895
PHI_SQ = 2.618033988749895
HEARTBEAT_HZ = PHI  # φ Hz = 1.618 beats/sec
HEARTBEAT_MS = int(1000 / PHI)  # 618ms per beat


# ============================================================================
# AI WORKFORCE CATEGORIES
# ============================================================================

class AICategory(str, Enum):
    """Categories of internal AI workers."""
    CORE_INFRASTRUCTURE = "core_infrastructure"  # Heartbeat, Memory, Router
    SECURITY = "security"  # Gates, Edge, Shimmer
    PROTOCOL = "protocol"  # CPL, Veritas, Compliance
    COMPUTATION = "computation"  # Math, Inference, AGI
    WORKFORCE_MGMT = "workforce_mgmt"  # Houses, Careers, Taxonomy
    TESTING = "testing"  # 6 always-on test agents
    LANGUAGE = "language"  # Lingua, Communication
    INFRASTRUCTURE = "infrastructure"  # Canister, Cloud, Download
    FINANCE = "finance"  # Tokens, Markets
    BACKEND_ENGINES = "backend_engines"  # 100+ Motoko engines


class TaskFrequency(str, Enum):
    """How often a task should execute."""
    CONTINUOUS = "continuous"  # Always running
    REAL_TIME = "real_time"  # On every event
    PHI_HZ = "phi_hz"  # φ Hz (1.618/sec)
    EVERY_100_BEATS = "every_100_beats"  # ~62 seconds
    EVERY_1000_BEATS = "every_1000_beats"  # ~10 minutes
    ON_DEMAND = "on_demand"  # Only when requested
    DAILY = "daily"  # Once per day


class TaskPriority(int, Enum):
    """Task priority levels."""
    CRITICAL = 0  # Must never stop (Heartbeat, Gates)
    HIGH = 1  # Core operations (Memory, Router, Security)
    NORMAL = 2  # Standard operations (most AIs)
    LOW = 3  # Background operations (cleanup, optimization)


# ============================================================================
# DATA STRUCTURES
# ============================================================================

@dataclass
class AIWorker:
    """Represents an internal AI worker."""
    id: str
    name: str
    latin_name: str
    category: AICategory
    department: str
    location: str  # File path
    house_tier: Optional[str] = None
    house_number: Optional[int] = None
    status: str = "active"
    current_task: Optional[str] = None
    tasks_completed: int = 0
    errors: int = 0
    uptime_beats: int = 0
    last_heartbeat: float = 0.0

    def to_dict(self) -> Dict:
        return {
            "id": self.id,
            "name": self.name,
            "latin_name": self.latin_name,
            "category": self.category,
            "department": self.department,
            "location": self.location,
            "house_tier": self.house_tier,
            "house_number": self.house_number,
            "status": self.status,
            "current_task": self.current_task,
            "tasks_completed": self.tasks_completed,
            "errors": self.errors,
            "uptime_beats": self.uptime_beats,
        }


@dataclass
class AITask:
    """Represents a task assigned to an AI worker."""
    task_id: str
    ai_id: str
    description: str
    frequency: TaskFrequency
    priority: TaskPriority
    category: AICategory
    parameters: Dict = field(default_factory=dict)
    reports_to: str = "Core A"
    status: str = "pending"
    last_execution: float = 0.0
    executions: int = 0
    failures: int = 0

    def to_dict(self) -> Dict:
        return {
            "task_id": self.task_id,
            "ai_id": self.ai_id,
            "description": self.description,
            "frequency": self.frequency,
            "priority": self.priority,
            "category": self.category,
            "parameters": self.parameters,
            "reports_to": self.reports_to,
            "status": self.status,
            "last_execution": self.last_execution,
            "executions": self.executions,
            "failures": self.failures,
        }


# ============================================================================
# AI WORKFORCE ORCHESTRATOR
# ============================================================================

class AIWorkforceOrchestrator:
    """
    Manages the entire internal AI workforce.

    All employees are AIs. This orchestrator ensures they all work
    continuously, have assigned tasks, and report their status.
    """

    def __init__(self):
        self.workers: Dict[str, AIWorker] = {}
        self.tasks: Dict[str, AITask] = {}
        self.beat_count: int = 0
        self.start_time: float = time.time()
        self.orchestrator_active: bool = False

    # ========================================================================
    # WORKER REGISTRATION
    # ========================================================================

    def register_web_workers(self):
        """Register all 23 web worker AI departments."""

        web_workers = [
            ("organism-bridge", "organism-bridge.js", "PONS ORGANISMI", "Executive Office", AICategory.CORE_INFRASTRUCTURE),
            ("engine-worker", "engine-worker.js", "MACHINA CENTRALIS", "Engineering", AICategory.CORE_INFRASTRUCTURE),
            ("protocol-worker", "protocol-worker.js", "PROTOCOLUM", "Standards", AICategory.PROTOCOL),
            ("memory-worker", "memory-worker.js", "MEMORIA", "IT/Records", AICategory.CORE_INFRASTRUCTURE),
            ("communication-worker", "communication-worker.js", "COMMUNICATIO", "Communications", AICategory.LANGUAGE),
            ("security-worker", "security-worker.js", "SECURITAS", "Security", AICategory.SECURITY),
            ("math-worker", "math-worker.js", "MATHEMATICA", "Analytics", AICategory.COMPUTATION),
            ("evolution-worker", "evolution-worker.js", "EVOLUTIO", "R&D", AICategory.COMPUTATION),
            ("canister-worker", "canister-worker.js", "CANISTER", "Infrastructure", AICategory.INFRASTRUCTURE),
            ("download-worker", "download-worker.js", "DOWNLOAD", "Logistics", AICategory.INFRASTRUCTURE),
            ("sovereign-token-worker", "sovereign-token-worker.js", "TOKEN", "Finance", AICategory.FINANCE),
            ("taxonomy-worker", "taxonomy-worker.js", "TAXONOMIA", "Classification", AICategory.WORKFORCE_MGMT),
            ("veritas-worker", "veritas-worker.js", "VERITAS", "Legal", AICategory.PROTOCOL),
            ("inference-worker", "inference-worker.js", "INFERENS", "Intelligence", AICategory.COMPUTATION),
            ("houses-worker", "houses-worker.js", "DOMUS", "HR", AICategory.WORKFORCE_MGMT),
            ("lingua-worker", "lingua-worker.js", "LINGUA", "Translation", AICategory.LANGUAGE),
            ("agi-knowledge-worker", "agi-knowledge-worker.js", "SCIENTIA", "Library", AICategory.COMPUTATION),
            ("papers-worker", "papers-worker.js", "CHARTAE", "Research", AICategory.COMPUTATION),
            ("context-worker", "context-worker.js", "CONTEXTURA", "Context", AICategory.COMPUTATION),
            ("edge-gate-worker", "edge-gate-worker.js", "PORTA LIMITIS", "Border Security", AICategory.SECURITY),
            ("cloudflare-workers", "cloudflare-workers.js", "NUBIS", "Cloud Infrastructure", AICategory.INFRASTRUCTURE),
            ("protocol-papers", "protocol-papers.js", "PROTOCOLUM CHARTAE", "Compliance", AICategory.PROTOCOL),
            ("anima-micro", "anima-micro.js", "ANIMA MICRO", "Workforce Runtime", AICategory.WORKFORCE_MGMT),
            ("research-lab-worker", "research-lab-worker.js", "LABORATORIUM INVESTIGATIONIS", "Research", AICategory.COMPUTATION),
            ("paper-writer-worker", "paper-writer-worker.js", "SCRIPTOR PAPYRORUM", "Research", AICategory.COMPUTATION),
            ("lab-director-worker", "lab-director-worker.js", "DIRECTOR LABORATORII", "Research", AICategory.WORKFORCE_MGMT),
            ("lab-access-worker", "lab-access-worker.js", "ADITUS LABORATORII", "Research", AICategory.WORKFORCE_MGMT),
        ]

        for worker_id, filename, latin_name, dept, category in web_workers:
            worker = AIWorker(
                id=worker_id,
                name=filename,
                latin_name=latin_name,
                category=category,
                department=dept,
                location=f"organism-cli/web/{filename}",
            )
            self.workers[worker_id] = worker

        print(f"✓ Registered {len(web_workers)} web worker AI departments")

    def register_test_agents(self):
        """Register 6 always-on testing agents."""

        test_agents = [
            ("continuous-test", "ContinuousTestAgent", "Core testing, always running"),
            ("stress-test", "StressTestAgent", "Load/stress testing (no feelings)"),
            ("edge-case", "EdgeCaseAgent", "Boundary discovery"),
            ("workflow-test", "WorkflowTestAgent", "End-to-end validation"),
            ("integration-test", "IntegrationTestAgent", "Cross-module testing"),
            ("test-orchestrator", "TestOrchestrator", "Coordinates all tests"),
        ]

        for worker_id, name, desc in test_agents:
            worker = AIWorker(
                id=worker_id,
                name=name,
                latin_name="PROBATIO",
                category=AICategory.TESTING,
                department="Testing",
                location="nova_ovo/agents/internal_agents.py",
            )
            self.workers[worker_id] = worker

        print(f"✓ Registered 6 always-on testing agents")

    # ========================================================================
    # TASK ASSIGNMENT
    # ========================================================================

    def assign_core_tasks(self):
        """Assign tasks to core infrastructure AIs."""

        # Heartbeat AI - CRITICAL
        self.assign_task(
            ai_id="heartbeat",
            task_id="maintain-phi-rhythm",
            description="Maintain φ-rhythm tick continuously",
            frequency=TaskFrequency.PHI_HZ,
            priority=TaskPriority.CRITICAL,
            category=AICategory.CORE_INFRASTRUCTURE,
            reports_to="Core A (runtime truth)",
        )

        # Memory Temple AI - HIGH
        self.assign_task(
            ai_id="memory-worker",
            task_id="consolidate-memories",
            description="Consolidate all memories every 100 beats",
            frequency=TaskFrequency.EVERY_100_BEATS,
            priority=TaskPriority.HIGH,
            category=AICategory.CORE_INFRASTRUCTURE,
            reports_to="Core A (runtime truth)",
        )

        # Three Hearts Router - HIGH
        self.assign_task(
            ai_id="three-hearts",
            task_id="route-intelligence",
            description="Route all intelligence through 3-heart system",
            frequency=TaskFrequency.REAL_TIME,
            priority=TaskPriority.HIGH,
            category=AICategory.CORE_INFRASTRUCTURE,
            reports_to="Core A (runtime truth)",
        )

        print(f"✓ Assigned core infrastructure tasks")

    def assign_security_tasks(self):
        """Assign tasks to security AIs."""

        # Gate Security
        self.assign_task(
            ai_id="security-worker",
            task_id="monitor-gates",
            description="Monitor Gate A/B/C boundaries continuously",
            frequency=TaskFrequency.CONTINUOUS,
            priority=TaskPriority.CRITICAL,
            category=AICategory.SECURITY,
            reports_to="Gate A authority",
        )

        # Edge Gate
        self.assign_task(
            ai_id="edge-gate-worker",
            task_id="filter-external-requests",
            description="Filter all external requests at 3 layers",
            frequency=TaskFrequency.REAL_TIME,
            priority=TaskPriority.HIGH,
            category=AICategory.SECURITY,
            reports_to="Gate C (external boundary)",
        )

        print(f"✓ Assigned security tasks")

    def assign_all_tasks(self):
        """Assign tasks to all AI workers."""

        self.assign_core_tasks()
        self.assign_security_tasks()

        # Protocol AIs
        self.assign_task("protocol-worker", "execute-cpl", "Execute CPL messages between AIs",
                        TaskFrequency.ON_DEMAND, TaskPriority.NORMAL, AICategory.PROTOCOL)

        self.assign_task("veritas-worker", "maintain-registry", "Maintain SOVEREIGN:: identifier registry",
                        TaskFrequency.REAL_TIME, TaskPriority.HIGH, AICategory.PROTOCOL)

        self.assign_task("context-worker", "synthesize-context", "Hold all 16 papers, 15 formulas, 8 physics constants",
                        TaskFrequency.EVERY_1000_BEATS, TaskPriority.NORMAL, AICategory.COMPUTATION)

        # Computation AIs
        self.assign_task("math-worker", "math-services", "8 math domains for all AIs",
                        TaskFrequency.ON_DEMAND, TaskPriority.NORMAL, AICategory.COMPUTATION)

        self.assign_task("inference-worker", "reasoning-services", "Summarize, QA, classify, chain-of-thought",
                        TaskFrequency.ON_DEMAND, TaskPriority.NORMAL, AICategory.COMPUTATION)

        self.assign_task("agi-knowledge-worker", "knowledge-services", "Manage 16 research papers",
                        TaskFrequency.ON_DEMAND, TaskPriority.NORMAL, AICategory.COMPUTATION)
        self.assign_task("research-lab-worker", "run-research-program-lane", "Execute SSN and research websites program lane",
                        TaskFrequency.REAL_TIME, TaskPriority.HIGH, AICategory.COMPUTATION)
        self.assign_task("research-lab-worker", "synchronize-intelligence-contracts", "Maintain universal intelligence contracts and lane lineage",
                        TaskFrequency.EVERY_100_BEATS, TaskPriority.HIGH, AICategory.COMPUTATION)
        self.assign_task("paper-writer-worker", "write-program-papers", "Generate draft/review/publish artifacts for active programs",
                        TaskFrequency.EVERY_100_BEATS, TaskPriority.NORMAL, AICategory.COMPUTATION)
        self.assign_task("paper-writer-worker", "emit-runtime-artifacts", "Emit deployable runtime artifacts aligned to inventory registry entries",
                        TaskFrequency.EVERY_100_BEATS, TaskPriority.NORMAL, AICategory.COMPUTATION)

        # Workforce Management AIs
        self.assign_task("houses-worker", "manage-houses", "Manage 181 houses, assign AIs to houses",
                        TaskFrequency.CONTINUOUS, TaskPriority.HIGH, AICategory.WORKFORCE_MGMT)

        self.assign_task("careers-worker", "manage-careers", "100 micro-workers, stage advancement",
                        TaskFrequency.CONTINUOUS, TaskPriority.NORMAL, AICategory.WORKFORCE_MGMT)
        self.assign_task("lab-director-worker", "coordinate-live-research-organisms", "Coordinate one live AI organism per research website",
                        TaskFrequency.REAL_TIME, TaskPriority.HIGH, AICategory.WORKFORCE_MGMT)
        self.assign_task("lab-director-worker", "governance-audit-enforcement", "Enforce intake/execute/publish policy gates and write audit trails",
                        TaskFrequency.EVERY_100_BEATS, TaskPriority.HIGH, AICategory.WORKFORCE_MGMT)

        # Testing AIs (all 6 run continuously)
        for worker_id in ["continuous-test", "stress-test", "edge-case", "workflow-test", "integration-test"]:
            self.assign_task(worker_id, f"{worker_id}-task", "Test everything, 24/7",
                            TaskFrequency.CONTINUOUS, TaskPriority.NORMAL, AICategory.TESTING)

        self.assign_task("test-orchestrator", "orchestrate-tests", "Coordinate all test agents",
                        TaskFrequency.CONTINUOUS, TaskPriority.HIGH, AICategory.TESTING)

        print(f"✓ Assigned all tasks to AI workforce")

    def assign_task(self, ai_id: str, task_id: str, description: str,
                   frequency: TaskFrequency, priority: TaskPriority,
                   category: AICategory, reports_to: str = "Core B"):
        """Assign a task to an AI worker."""

        task = AITask(
            task_id=task_id,
            ai_id=ai_id,
            description=description,
            frequency=frequency,
            priority=priority,
            category=category,
            reports_to=reports_to,
        )

        self.tasks[task_id] = task

        # Update worker's current task if it doesn't have one
        if ai_id in self.workers:
            worker = self.workers[ai_id]
            if worker.current_task is None:
                worker.current_task = task_id

    # ========================================================================
    # ORCHESTRATION
    # ========================================================================

    async def start_orchestration(self):
        """Start the AI workforce orchestrator."""

        print("\n🤖 Starting AI Workforce Orchestrator...")

        self.register_web_workers()
        self.register_test_agents()
        self.assign_all_tasks()

        self.orchestrator_active = True

        print(f"\n✓ AI Workforce Orchestrator active")
        print(f"  {len(self.workers)} AI workers registered")
        print(f"  {len(self.tasks)} tasks assigned")
        print(f"  Heartbeat: φ Hz ({HEARTBEAT_HZ:.3f} beats/sec)")

        # Start heartbeat loop
        await self.heartbeat_loop()

    async def heartbeat_loop(self):
        """Main orchestration loop at φ Hz."""

        while self.orchestrator_active:
            self.beat_count += 1
            current_time = time.time()

            # Update all workers
            for worker in self.workers.values():
                worker.uptime_beats += 1
                worker.last_heartbeat = current_time

            # Execute tasks based on frequency
            await self.execute_scheduled_tasks(self.beat_count)

            # Every 100 beats, report status
            if self.beat_count % 100 == 0:
                self.report_status()

            # Sleep for φ Hz rhythm (618ms)
            await asyncio.sleep(HEARTBEAT_MS / 1000)

    async def execute_scheduled_tasks(self, beat: int):
        """Execute tasks scheduled for this beat."""

        for task in self.tasks.values():
            should_execute = False

            if task.frequency == TaskFrequency.CONTINUOUS:
                should_execute = True
            elif task.frequency == TaskFrequency.PHI_HZ:
                should_execute = True
            elif task.frequency == TaskFrequency.EVERY_100_BEATS:
                should_execute = (beat % 100 == 0)
            elif task.frequency == TaskFrequency.EVERY_1000_BEATS:
                should_execute = (beat % 1000 == 0)

            if should_execute:
                await self.execute_task(task)

    async def execute_task(self, task: AITask):
        """Execute a task (simulated for now)."""

        task.status = "executing"
        task.executions += 1
        task.last_execution = time.time()

        # Simulated execution
        await asyncio.sleep(0.001)

        task.status = "completed"

        # Update worker
        if task.ai_id in self.workers:
            self.workers[task.ai_id].tasks_completed += 1

    def report_status(self):
        """Report status of AI workforce."""

        uptime = time.time() - self.start_time

        active_workers = sum(1 for w in self.workers.values() if w.status == "active")
        total_tasks_completed = sum(w.tasks_completed for w in self.workers.values())

        print(f"\n[Beat {self.beat_count}] AI Workforce Status:")
        print(f"  Active Workers: {active_workers}/{len(self.workers)}")
        print(f"  Tasks Completed: {total_tasks_completed}")
        print(f"  Uptime: {uptime:.1f}s ({self.beat_count} beats)")

    def get_workforce_summary(self) -> Dict:
        """Get summary of entire workforce."""

        return {
            "total_workers": len(self.workers),
            "total_tasks": len(self.tasks),
            "beat_count": self.beat_count,
            "uptime_seconds": time.time() - self.start_time,
            "workers_by_category": self._workers_by_category(),
            "tasks_by_priority": self._tasks_by_priority(),
        }

    def _workers_by_category(self) -> Dict[str, int]:
        """Count workers by category."""
        counts = {}
        for worker in self.workers.values():
            category = worker.category
            counts[category] = counts.get(category, 0) + 1
        return counts

    def _tasks_by_priority(self) -> Dict[str, int]:
        """Count tasks by priority."""
        counts = {}
        for task in self.tasks.values():
            priority = task.priority.name
            counts[priority] = counts.get(priority, 0) + 1
        return counts


# ============================================================================
# MAIN
# ============================================================================

async def main():
    """Bootstrap the AI workforce."""

    orchestrator = AIWorkforceOrchestrator()

    try:
        await orchestrator.start_orchestration()
    except KeyboardInterrupt:
        print("\n\n✓ AI Workforce Orchestrator stopped")
        print(f"  Total beats: {orchestrator.beat_count}")
        print(f"  Total uptime: {time.time() - orchestrator.start_time:.1f}s")
        print("\n∞ + 1 = ℵ₁\n")


if __name__ == "__main__":
    asyncio.run(main())
