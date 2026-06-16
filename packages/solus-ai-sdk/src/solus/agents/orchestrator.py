"""
SOLUS Agent Orchestrator — Multi-Agent Coordination
=====================================================

PROT-670: Orchestrates multiple agents, delegates sub-tasks,
and coordinates agent-to-agent communication.
"""

from __future__ import annotations

import time
import uuid
from typing import Any, Callable, Dict, List, Optional

from solus.agents.agent import Agent, AgentConfig, AgentResult, AgentStatus


class AgentOrchestrator:
    """
    Orchestrates multiple SOLUS agents.

    Capabilities:
    - Create and manage agent instances
    - Delegate sub-tasks to specialized agents
    - Coordinate multi-agent workflows
    - Shared tool and memory access
    """

    def __init__(
        self,
        tools: Any = None,
        memory: Any = None,
        inference: Any = None,
    ):
        self._tools_registry = tools
        self._memory = memory
        self._inference = inference
        self._agents: Dict[str, Agent] = {}
        self._workflows: List[Dict[str, Any]] = []

    def create(self, config: AgentConfig) -> Agent:
        """Create a new agent."""
        # Resolve tools for this agent
        tools = {}
        if self._tools_registry and config.tools:
            for tool_name in config.tools:
                tool = self._tools_registry.get(tool_name)
                if tool:
                    tools[tool_name] = tool

        agent = Agent(
            config=config,
            inference=self._inference,
            tools=tools,
            memory=self._memory,
        )
        self._agents[agent.agent_id] = agent
        return agent

    def get_agent(self, agent_id: str) -> Optional[Agent]:
        """Get an agent by ID."""
        return self._agents.get(agent_id)

    def list_agents(self) -> List[Dict[str, Any]]:
        """List all managed agents."""
        return [
            {
                "id": agent.agent_id,
                "name": agent.config.name,
                "status": agent.status.value,
                "runs": len(agent._runs),
            }
            for agent in self._agents.values()
        ]

    def run_workflow(
        self,
        task: str,
        agent_configs: Optional[List[AgentConfig]] = None,
    ) -> Dict[str, Any]:
        """
        Run a multi-agent workflow.

        Creates specialized agents and coordinates them to complete a task.
        """
        workflow_id = str(uuid.uuid4())[:8]
        start_time = time.time()
        results: List[AgentResult] = []

        if agent_configs:
            # Use provided agent configurations
            for config in agent_configs:
                agent = self.create(config)
                result = agent.run(task)
                results.append(result)
        else:
            # Default: single agent
            config = AgentConfig(name="workflow-agent", max_steps=20)
            agent = self.create(config)
            result = agent.run(task)
            results.append(result)

        workflow_result = {
            "workflow_id": workflow_id,
            "task": task,
            "agents_used": len(results),
            "results": [r.to_dict() for r in results],
            "total_duration_ms": (time.time() - start_time) * 1000,
            "status": "completed",
        }
        self._workflows.append(workflow_result)
        return workflow_result

    def delegate(
        self,
        task: str,
        agent_name: str = "delegate",
        tools: Optional[List[str]] = None,
    ) -> AgentResult:
        """Delegate a task to a new agent."""
        config = AgentConfig(
            name=agent_name,
            tools=tools or [],
            max_steps=10,
        )
        agent = self.create(config)
        return agent.run(task)

    def get_status(self) -> Dict[str, Any]:
        """Get orchestrator status."""
        return {
            "total_agents": len(self._agents),
            "active_agents": sum(
                1 for a in self._agents.values()
                if a.status in (AgentStatus.EXECUTING, AgentStatus.PLANNING)
            ),
            "completed_workflows": len(self._workflows),
            "agents": self.list_agents(),
        }
