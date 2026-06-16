"""
SOLUS Tool Registry — Available Tools for Agents
==================================================

PROT-671: Registry of tools available to SOLUS agents and models
for function calling and external system interaction.
"""

from __future__ import annotations

import inspect
import json
from dataclasses import dataclass, field
from typing import Any, Callable, Dict, List, Optional, get_type_hints


@dataclass
class ToolParameter:
    """Parameter definition for a tool."""
    name: str
    type: str
    description: str = ""
    required: bool = True
    default: Any = None

    def to_schema(self) -> Dict[str, Any]:
        schema: Dict[str, Any] = {"type": self.type, "description": self.description}
        if self.default is not None:
            schema["default"] = self.default
        return schema


@dataclass
class ToolDefinition:
    """Full definition of a tool."""
    name: str
    description: str
    parameters: List[ToolParameter] = field(default_factory=list)
    returns: str = "string"
    category: str = "general"
    callable: Optional[Callable] = None

    def to_openai_schema(self) -> Dict[str, Any]:
        """Export as OpenAI function-calling schema."""
        properties = {}
        required = []

        for param in self.parameters:
            properties[param.name] = param.to_schema()
            if param.required:
                required.append(param.name)

        return {
            "type": "function",
            "function": {
                "name": self.name,
                "description": self.description,
                "parameters": {
                    "type": "object",
                    "properties": properties,
                    "required": required,
                },
            },
        }

    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "description": self.description,
            "category": self.category,
            "parameters": [
                {"name": p.name, "type": p.type, "required": p.required}
                for p in self.parameters
            ],
        }


# Type mapping for Python types to JSON schema types
TYPE_MAP = {
    "str": "string",
    "int": "integer",
    "float": "number",
    "bool": "boolean",
    "list": "array",
    "dict": "object",
    "None": "null",
}


class ToolRegistry:
    """
    Registry of tools available to SOLUS agents.

    Tools can be:
    - Built-in (file I/O, web search, code execution)
    - Custom (user-defined functions)
    - External (API integrations)
    """

    def __init__(self) -> None:
        self._tools: Dict[str, ToolDefinition] = {}
        self._register_builtins()

    def register(
        self,
        func: Optional[Callable] = None,
        *,
        name: Optional[str] = None,
        description: Optional[str] = None,
        category: str = "custom",
    ) -> Callable:
        """
        Register a function as a tool.

        Can be used as a decorator:
            @tools.register
            def my_tool(x: int) -> str:
                '''My tool description.'''
                return str(x)
        """
        def decorator(fn: Callable) -> Callable:
            tool_name = name or fn.__name__
            tool_desc = description or fn.__doc__ or f"Tool: {tool_name}"

            # Extract parameters from function signature
            params = self._extract_params(fn)

            definition = ToolDefinition(
                name=tool_name,
                description=tool_desc.strip(),
                parameters=params,
                category=category,
                callable=fn,
            )
            self._tools[tool_name] = definition
            return fn

        if func is not None:
            return decorator(func)
        return decorator

    def get(self, name: str) -> Optional[Callable]:
        """Get a tool's callable by name."""
        tool = self._tools.get(name)
        return tool.callable if tool else None

    def get_definition(self, name: str) -> Optional[ToolDefinition]:
        """Get a tool's full definition."""
        return self._tools.get(name)

    def list_tools(self) -> List[ToolDefinition]:
        """List all registered tools."""
        return list(self._tools.values())

    def list_by_category(self, category: str) -> List[ToolDefinition]:
        """List tools by category."""
        return [t for t in self._tools.values() if t.category == category]

    def get_openai_tools(self) -> List[Dict[str, Any]]:
        """Export all tools in OpenAI function-calling format."""
        return [t.to_openai_schema() for t in self._tools.values()]

    def execute(self, name: str, **kwargs) -> Any:
        """Execute a tool by name."""
        tool = self._tools.get(name)
        if not tool or not tool.callable:
            raise ValueError(f"Tool '{name}' not found or not callable")
        return tool.callable(**kwargs)

    def _extract_params(self, func: Callable) -> List[ToolParameter]:
        """Extract parameter definitions from a function."""
        params = []
        sig = inspect.signature(func)

        try:
            hints = get_type_hints(func)
        except Exception:
            hints = {}

        for param_name, param in sig.parameters.items():
            if param_name in ("self", "cls"):
                continue

            # Get type
            type_hint = hints.get(param_name, str)
            type_name = getattr(type_hint, "__name__", str(type_hint))
            json_type = TYPE_MAP.get(type_name, "string")

            # Check if required
            has_default = param.default != inspect.Parameter.empty
            default_val = param.default if has_default else None

            params.append(ToolParameter(
                name=param_name,
                type=json_type,
                required=not has_default,
                default=default_val,
            ))

        return params

    def _register_builtins(self) -> None:
        """Register built-in tools."""
        # Read file tool
        self.register(
            self._builtin_read_file,
            name="read_file",
            description="Read the contents of a file from disk",
            category="filesystem",
        )

        # Write file tool
        self.register(
            self._builtin_write_file,
            name="write_file",
            description="Write content to a file on disk",
            category="filesystem",
        )

        # Shell command tool
        self.register(
            self._builtin_shell,
            name="shell",
            description="Execute a shell command and return output",
            category="system",
        )

        # Web fetch tool
        self.register(
            self._builtin_web_fetch,
            name="web_fetch",
            description="Fetch content from a URL",
            category="web",
        )

        # Calculate tool
        self.register(
            self._builtin_calculate,
            name="calculate",
            description="Evaluate a mathematical expression",
            category="math",
        )

    @staticmethod
    def _builtin_read_file(path: str) -> str:
        """Read file contents."""
        try:
            with open(path) as f:
                return f.read()
        except Exception as e:
            return f"Error reading file: {e}"

    @staticmethod
    def _builtin_write_file(path: str, content: str) -> str:
        """Write content to file."""
        try:
            with open(path, "w") as f:
                f.write(content)
            return f"Written {len(content)} bytes to {path}"
        except Exception as e:
            return f"Error writing file: {e}"

    @staticmethod
    def _builtin_shell(command: str) -> str:
        """Execute shell command."""
        import subprocess
        try:
            result = subprocess.run(
                command, shell=True, capture_output=True, text=True, timeout=30
            )
            output = result.stdout
            if result.returncode != 0:
                output += f"\nSTDERR: {result.stderr}"
            return output[:10000]
        except subprocess.TimeoutExpired:
            return "Error: Command timed out (30s limit)"
        except Exception as e:
            return f"Error: {e}"

    @staticmethod
    def _builtin_web_fetch(url: str) -> str:
        """Fetch URL content."""
        import urllib.request
        try:
            with urllib.request.urlopen(url, timeout=10) as response:
                return response.read().decode("utf-8")[:10000]
        except Exception as e:
            return f"Error fetching URL: {e}"

    @staticmethod
    def _builtin_calculate(expression: str) -> str:
        """Evaluate math expression safely."""
        import ast
        import operator

        # Safe evaluation of mathematical expressions
        ops = {
            ast.Add: operator.add,
            ast.Sub: operator.sub,
            ast.Mult: operator.mul,
            ast.Div: operator.truediv,
            ast.Pow: operator.pow,
            ast.Mod: operator.mod,
            ast.USub: operator.neg,
        }

        def _eval(node):
            if isinstance(node, ast.Constant):
                return node.value
            elif isinstance(node, ast.BinOp):
                left = _eval(node.left)
                right = _eval(node.right)
                op_func = ops.get(type(node.op))
                if op_func:
                    return op_func(left, right)
            elif isinstance(node, ast.UnaryOp):
                operand = _eval(node.operand)
                op_func = ops.get(type(node.op))
                if op_func:
                    return op_func(operand)
            raise ValueError(f"Unsupported expression: {ast.dump(node)}")

        try:
            tree = ast.parse(expression, mode="eval")
            result = _eval(tree.body)
            return str(result)
        except Exception as e:
            return f"Error: {e}"

    def to_dict(self) -> Dict[str, Any]:
        """Export registry as dict."""
        return {
            "total_tools": len(self._tools),
            "categories": list(set(t.category for t in self._tools.values())),
            "tools": [t.to_dict() for t in self._tools.values()],
        }
