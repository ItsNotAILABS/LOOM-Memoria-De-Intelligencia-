"""
SOLUS Function Caller — Structured Function Calling
=====================================================

PROT-672: Handles structured function calling from model output,
parsing tool-use requests and formatting results back to the model.
"""

from __future__ import annotations

import json
import re
import uuid
from dataclasses import dataclass, field
from typing import Any, Callable, Dict, List, Optional

from solus.tools.registry import ToolRegistry


@dataclass
class FunctionCall:
    """A parsed function call from model output."""
    call_id: str = field(default_factory=lambda: str(uuid.uuid4())[:8])
    name: str = ""
    arguments: Dict[str, Any] = field(default_factory=dict)
    raw_text: str = ""


@dataclass
class FunctionResult:
    """Result of a function call execution."""
    call_id: str = ""
    name: str = ""
    result: Any = None
    error: Optional[str] = None
    duration_ms: float = 0.0

    @property
    def success(self) -> bool:
        return self.error is None

    def to_message(self) -> Dict[str, str]:
        """Format as a message for the model."""
        content = str(self.result) if self.success else f"Error: {self.error}"
        return {
            "role": "tool",
            "content": content,
            "name": self.name,
            "tool_call_id": self.call_id,
        }


class FunctionCaller:
    """
    Handles function calling between SOLUS models and tools.

    Parses function call requests from model output and executes
    them through the tool registry.
    """

    def __init__(self, registry: Optional[ToolRegistry] = None):
        self._registry = registry or ToolRegistry()
        self._call_history: List[FunctionResult] = []

    def parse_calls(self, model_output: str) -> List[FunctionCall]:
        """
        Parse function calls from model output.

        Supports multiple formats:
        - OpenAI-style: {"name": "func", "arguments": {...}}
        - XML-style: <function_call name="func">...</function_call>
        - Action-style: ACTION: func\nACTION_INPUT: {...}
        """
        calls = []

        # Try JSON format first
        json_calls = self._parse_json_calls(model_output)
        if json_calls:
            return json_calls

        # Try action format
        action_calls = self._parse_action_calls(model_output)
        if action_calls:
            return action_calls

        # Try XML format
        xml_calls = self._parse_xml_calls(model_output)
        if xml_calls:
            return xml_calls

        return calls

    def execute(self, call: FunctionCall) -> FunctionResult:
        """Execute a single function call."""
        import time
        start = time.time()

        try:
            result = self._registry.execute(call.name, **call.arguments)
            return FunctionResult(
                call_id=call.call_id,
                name=call.name,
                result=result,
                duration_ms=(time.time() - start) * 1000,
            )
        except Exception as e:
            return FunctionResult(
                call_id=call.call_id,
                name=call.name,
                error=str(e),
                duration_ms=(time.time() - start) * 1000,
            )

    def execute_all(self, calls: List[FunctionCall]) -> List[FunctionResult]:
        """Execute multiple function calls."""
        results = []
        for call in calls:
            result = self.execute(call)
            results.append(result)
            self._call_history.append(result)
        return results

    def process_output(self, model_output: str) -> tuple:
        """
        Process model output: parse calls, execute, return results.

        Returns:
            Tuple of (has_calls: bool, results: List[FunctionResult], text: str)
        """
        calls = self.parse_calls(model_output)

        if not calls:
            return False, [], model_output

        results = self.execute_all(calls)
        return True, results, ""

    def _parse_json_calls(self, text: str) -> List[FunctionCall]:
        """Parse JSON-formatted function calls."""
        calls = []

        # Look for tool_calls array
        try:
            data = json.loads(text)
            if isinstance(data, dict) and "tool_calls" in data:
                for tc in data["tool_calls"]:
                    calls.append(FunctionCall(
                        name=tc.get("function", {}).get("name", ""),
                        arguments=json.loads(tc.get("function", {}).get("arguments", "{}")),
                        raw_text=json.dumps(tc),
                    ))
                return calls
        except (json.JSONDecodeError, TypeError):
            pass

        # Look for inline JSON function calls
        pattern = r'\{["\']name["\']\s*:\s*["\'](\w+)["\'].*?["\']arguments["\']\s*:\s*(\{[^}]*\})'
        for match in re.finditer(pattern, text, re.DOTALL):
            try:
                args = json.loads(match.group(2))
                calls.append(FunctionCall(
                    name=match.group(1),
                    arguments=args,
                    raw_text=match.group(0),
                ))
            except json.JSONDecodeError:
                pass

        return calls

    def _parse_action_calls(self, text: str) -> List[FunctionCall]:
        """Parse ACTION/ACTION_INPUT formatted calls."""
        calls = []

        action_pattern = r"ACTION:\s*(\w+)\s*\nACTION_INPUT:\s*(.+?)(?=\n(?:THOUGHT|ACTION)|$)"
        for match in re.finditer(action_pattern, text, re.DOTALL):
            name = match.group(1).strip()
            raw_input = match.group(2).strip()

            if name.lower() == "finish":
                continue

            try:
                arguments = json.loads(raw_input)
            except json.JSONDecodeError:
                arguments = {"input": raw_input}

            calls.append(FunctionCall(
                name=name,
                arguments=arguments if isinstance(arguments, dict) else {"input": arguments},
                raw_text=match.group(0),
            ))

        return calls

    def _parse_xml_calls(self, text: str) -> List[FunctionCall]:
        """Parse XML-style function calls."""
        calls = []

        pattern = r'<function_call\s+name="(\w+)">(.*?)</function_call>'
        for match in re.finditer(pattern, text, re.DOTALL):
            name = match.group(1)
            content = match.group(2).strip()

            try:
                arguments = json.loads(content)
            except json.JSONDecodeError:
                arguments = {"input": content}

            calls.append(FunctionCall(
                name=name,
                arguments=arguments if isinstance(arguments, dict) else {"input": arguments},
                raw_text=match.group(0),
            ))

        return calls

    def get_history(self) -> List[Dict[str, Any]]:
        """Get function call history."""
        return [
            {
                "call_id": r.call_id,
                "name": r.name,
                "success": r.success,
                "duration_ms": round(r.duration_ms, 2),
            }
            for r in self._call_history
        ]
