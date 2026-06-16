"""
SOLUS Agent — Autonomous AI Agent Framework
=============================================

PROT-669: Autonomous agent that can plan, execute multi-step tasks,
use tools, and maintain state across interactions.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional


class AgentStatus(str, Enum):
    """Agent operational status."""
    IDLE = "idle"
    PLANNING = "planning"
    EXECUTING = "executing"
    WAITING = "waiting"
    COMPLETED = "completed"
    FAILED = "failed"


@dataclass
class AgentConfig:
    """Configuration for an agent."""
    name: str = "default"
    description: str = ""
    system_prompt: str = ""
    max_steps: int = 20
    max_retries: int = 3
    timeout_seconds: float = 300.0
    tools: List[str] = field(default_factory=list)
    memory_enabled: bool = True
    verbose: bool = False
    temperature: float = 0.3
    model_id: Optional[str] = None

    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "description": self.description,
            "max_steps": self.max_steps,
            "max_retries": self.max_retries,
            "timeout_seconds": self.timeout_seconds,
            "tools": self.tools,
            "memory_enabled": self.memory_enabled,
        }


@dataclass
class AgentStep:
    """A single step in agent execution."""
    step_id: str = field(default_factory=lambda: str(uuid.uuid4())[:8])
    index: int = 0
    thought: str = ""
    action: str = ""
    action_input: Dict[str, Any] = field(default_factory=dict)
    observation: str = ""
    duration_ms: float = 0.0

    def to_dict(self) -> Dict[str, Any]:
        return {
            "step": self.index,
            "thought": self.thought,
            "action": self.action,
            "input": self.action_input,
            "observation": self.observation[:500],
            "duration_ms": round(self.duration_ms, 2),
        }


@dataclass
class AgentResult:
    """Result of an agent run."""
    task: str
    answer: str
    steps: List[AgentStep] = field(default_factory=list)
    status: AgentStatus = AgentStatus.COMPLETED
    total_duration_ms: float = 0.0
    tokens_used: int = 0
    tools_called: List[str] = field(default_factory=list)

    def to_dict(self) -> Dict[str, Any]:
        return {
            "task": self.task,
            "answer": self.answer,
            "status": self.status.value,
            "steps": [s.to_dict() for s in self.steps],
            "total_duration_ms": round(self.total_duration_ms, 2),
            "tokens_used": self.tokens_used,
            "tools_called": self.tools_called,
            "step_count": len(self.steps),
        }


# Agent system prompts
AGENT_SYSTEM_PROMPT = """You are an autonomous AI agent with access to tools.
Your goal is to complete the task given to you.

Available tools: {tools}

For each step, output your thinking in this format:
THOUGHT: [your reasoning about what to do next]
ACTION: [tool name to use, or "finish" if done]
ACTION_INPUT: [input for the tool as JSON]

After receiving an observation, continue with another THOUGHT/ACTION/ACTION_INPUT cycle.
When you have the final answer, use ACTION: finish with ACTION_INPUT: {{"answer": "your answer"}}
"""


class Agent:
    """
    SOLUS Agent — Autonomous task executor.

    Agents can:
    - Plan multi-step task execution
    - Use tools to interact with external systems
    - Maintain memory across steps
    - Self-correct on failures
    - Report progress and results
    """

    def __init__(
        self,
        config: AgentConfig,
        inference: Any = None,
        tools: Optional[Dict[str, Callable]] = None,
        memory: Any = None,
    ):
        self.config = config
        self.agent_id = str(uuid.uuid4())[:12]
        self._inference = inference
        self._tools = tools or {}
        self._memory = memory
        self._status = AgentStatus.IDLE
        self._steps: List[AgentStep] = []
        self._runs: List[AgentResult] = []

    @property
    def status(self) -> AgentStatus:
        return self._status

    def run(self, task: str) -> AgentResult:
        """
        Execute a task autonomously.

        Args:
            task: Natural language description of what to accomplish

        Returns:
            AgentResult with answer and execution trace
        """
        self._status = AgentStatus.PLANNING
        self._steps = []
        start_time = time.time()

        # Build system prompt with available tools
        tool_descriptions = "\n".join(
            f"- {name}: {func.__doc__ or 'No description'}"
            for name, func in self._tools.items()
        )
        system = AGENT_SYSTEM_PROMPT.format(tools=tool_descriptions or "none")

        # Execution loop
        messages = [
            {"role": "system", "content": system},
            {"role": "user", "content": f"Task: {task}"},
        ]

        answer = ""
        tools_called = []

        for i in range(self.config.max_steps):
            self._status = AgentStatus.EXECUTING
            step_start = time.time()

            # Get agent's next action
            response = self._generate_step(messages)

            # Parse thought/action/input
            thought, action, action_input = self._parse_response(response)

            step = AgentStep(
                index=i,
                thought=thought,
                action=action,
                action_input=action_input,
            )

            # Check if agent is done
            if action.lower() == "finish":
                answer = action_input.get("answer", response)
                step.observation = "Task completed"
                step.duration_ms = (time.time() - step_start) * 1000
                self._steps.append(step)
                break

            # Execute tool
            observation = self._execute_tool(action, action_input)
            step.observation = observation
            step.duration_ms = (time.time() - step_start) * 1000
            self._steps.append(step)
            tools_called.append(action)

            # Add to conversation
            messages.append({"role": "assistant", "content": response})
            messages.append({"role": "user", "content": f"OBSERVATION: {observation}"})

        # Build result
        self._status = AgentStatus.COMPLETED
        result = AgentResult(
            task=task,
            answer=answer or "Unable to complete task within step limit",
            steps=self._steps,
            status=self._status,
            total_duration_ms=(time.time() - start_time) * 1000,
            tools_called=list(set(tools_called)),
        )
        self._runs.append(result)

        # Store in memory
        if self._memory and self.config.memory_enabled:
            self._memory.store_interaction(
                prompt=f"Agent task: {task}",
                response=f"Agent result: {answer}",
            )

        return result

    def _generate_step(self, messages: List[Dict[str, str]]) -> str:
        """Generate the next agent step."""
        if self._inference is None:
            return 'THOUGHT: No inference engine\nACTION: finish\nACTION_INPUT: {"answer": "Inference engine not connected"}'

        if hasattr(self._inference, "chat"):
            result = self._inference.chat(
                messages=messages,
                max_tokens=1024,
                temperature=self.config.temperature,
            )
            if hasattr(result, "text"):
                return result.text
            return str(result)
        elif hasattr(self._inference, "generate"):
            # Format messages into prompt
            prompt = "\n".join(f"{m['role']}: {m['content']}" for m in messages)
            result = self._inference.generate(prompt, max_tokens=1024)
            if hasattr(result, "text"):
                return result.text
            return str(result)
        return ""

    def _parse_response(self, response: str) -> tuple:
        """Parse agent response into thought/action/input."""
        import json
        import re

        thought = ""
        action = "finish"
        action_input: Dict[str, Any] = {}

        # Extract THOUGHT
        thought_match = re.search(r"THOUGHT:\s*(.+?)(?=\nACTION:|$)", response, re.DOTALL)
        if thought_match:
            thought = thought_match.group(1).strip()

        # Extract ACTION
        action_match = re.search(r"ACTION:\s*(.+?)(?=\nACTION_INPUT:|$)", response, re.DOTALL)
        if action_match:
            action = action_match.group(1).strip()

        # Extract ACTION_INPUT
        input_match = re.search(r"ACTION_INPUT:\s*(.+?)$", response, re.DOTALL)
        if input_match:
            raw = input_match.group(1).strip()
            try:
                action_input = json.loads(raw)
            except json.JSONDecodeError:
                action_input = {"raw": raw}

        return thought, action, action_input

    def _execute_tool(self, tool_name: str, tool_input: Dict[str, Any]) -> str:
        """Execute a tool and return observation."""
        if tool_name not in self._tools:
            return f"Error: Tool '{tool_name}' not found. Available: {list(self._tools.keys())}"

        try:
            func = self._tools[tool_name]
            result = func(**tool_input) if tool_input else func()
            return str(result)
        except Exception as e:
            return f"Error executing {tool_name}: {str(e)}"

    def get_history(self) -> List[Dict[str, Any]]:
        """Get agent run history."""
        return [r.to_dict() for r in self._runs]

    def __repr__(self) -> str:
        return f"Agent(name={self.config.name}, status={self._status.value}, runs={len(self._runs)})"
