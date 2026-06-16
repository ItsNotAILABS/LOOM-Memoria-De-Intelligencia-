"""
Workforce Division — Document Organisms and Agents
===================================================
Stack Position: 7 (Bottom — Output)

The Workforce Division manages execution:
- Document organisms (D1-D10)
- Agent coordination
- Task execution
- Output production

Depends on: Procedures, Memory, Interface
Provides to: (Output layer — final production)

This is the output layer of the architecture stack:
  Doctrine → Procedures → Engine → Three Computers → Output
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Any, Dict, List

from .registry import Division, DivisionType
from .beings import SovereignBeing, BeingType


@dataclass
class WorkforceDivision(Division):
    """Workforce Division — Document organisms and agents."""
    
    def __post_init__(self) -> None:
        self.division_type = DivisionType.WORKFORCE
        self.name = "Workforce Division"
        self.description = "Document organisms and agents"
        self.stack_position = 7
        self._init_beings()
    
    def _init_beings(self) -> None:
        # Initialize D1-D10 document organisms
        for i in range(1, 11):
            doc_organism = SovereignBeing(
                name=f"Document Organism D{i}",
                being_type=BeingType.DOCUMENT_ORGANISM,
                division="workforce",
                tags=[f"D{i}", "document", "organism"],
            )
            doc_organism.add_capability("write", "Self-write content")
            doc_organism.add_capability("chain", "Chain to other documents")
            doc_organism.add_capability("translate", "Translate content")
            doc_organism.add_capability("compress", "Compress to kernel")
            doc_organism.add_capability("expand", "Expand from kernel")
            self.add_being(doc_organism)
        
        # Agent Coordinator
        coordinator = SovereignBeing(
            name="Agent Coordinator",
            being_type=BeingType.AGENT_COORDINATOR,
            division="workforce",
        )
        coordinator.add_capability("assign_task", "Assign tasks to agents")
        coordinator.add_capability("coordinate_swarm", "Coordinate agent swarm")
        coordinator.add_capability("balance_load", "Balance agent workload")
        self.add_being(coordinator)
        
        # Task Executor
        executor = SovereignBeing(
            name="Task Executor",
            being_type=BeingType.TASK_EXECUTOR,
            division="workforce",
        )
        executor.add_capability("execute_task", "Execute assigned tasks")
        executor.add_capability("report_progress", "Report task progress")
        executor.add_capability("handle_failure", "Handle task failures")
        self.add_being(executor)
    
    def get_document_organisms(self) -> List[SovereignBeing]:
        """Get all D1-D10 document organisms."""
        return self.get_beings_by_type(BeingType.DOCUMENT_ORGANISM)
    
    def get_document_organism(self, index: int) -> SovereignBeing | None:
        """Get a specific document organism by index (1-10)."""
        organisms = self.get_document_organisms()
        for org in organisms:
            if f"D{index}" in org.tags:
                return org
        return None
