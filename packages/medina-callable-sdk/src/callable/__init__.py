"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                    MEDINA CALLABLE SDK — AI-CALLABLE FUNCTION REGISTRY                       ║
║           "Invocatio Universalis — Universal Invocation of All Libraries"                    ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: CALLABLE-PROT-541 — AI CALLABLE SDK                                              ║
║                                                                                              ║
║  PURPOSE:                                                                                    ║
║    Provides a unified, AI-callable function registry that allows any AI agent,               ║
║    LLM, or autonomous system to invoke real library functions through a standardized         ║
║    interface. Supports tool-calling protocols (OpenAI function calling, Anthropic            ║
║    tool use, LangChain tools, MCP servers).                                                  ║
║                                                                                              ║
║  USAGE:                                                                                      ║
║    from callable import FunctionRegistry, ToolSchema, invoke                                 ║
║    from callable.providers import openai_tools, anthropic_tools, langchain_tools             ║
║    from callable.internal import organism_tools, sovereign_tools                             ║
║    from callable.external import cloud_tools, data_tools, ml_tools                           ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations
from typing import Any, Callable, Dict, List, Optional
from dataclasses import dataclass, field
import json

__version__ = "1.0.0"
__protocol__ = "CALLABLE-PROT-541"

PHI: float = 1.6180339887498948482


# ─────────────────────────────────────────────────────────────────
# Core Tool Schema — Compatible with OpenAI/Anthropic/LangChain
# ─────────────────────────────────────────────────────────────────

@dataclass
class ToolParameter:
    """A single parameter for an AI-callable function."""
    name: str
    type: str  # "string", "integer", "number", "boolean", "array", "object"
    description: str
    required: bool = True
    enum: Optional[List[str]] = None
    default: Any = None


@dataclass
class ToolSchema:
    """Schema for an AI-callable tool/function."""
    name: str
    description: str
    parameters: List[ToolParameter] = field(default_factory=list)
    category: str = "general"
    protocol: str = ""
    internal: bool = False
    handler: Optional[Callable] = None

    def to_openai_format(self) -> Dict[str, Any]:
        """Export as OpenAI function calling format."""
        properties = {}
        required = []
        for p in self.parameters:
            prop = {"type": p.type, "description": p.description}
            if p.enum:
                prop["enum"] = p.enum
            properties[p.name] = prop
            if p.required:
                required.append(p.name)

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

    def to_anthropic_format(self) -> Dict[str, Any]:
        """Export as Anthropic tool use format."""
        properties = {}
        required = []
        for p in self.parameters:
            prop = {"type": p.type, "description": p.description}
            if p.enum:
                prop["enum"] = p.enum
            properties[p.name] = prop
            if p.required:
                required.append(p.name)

        return {
            "name": self.name,
            "description": self.description,
            "input_schema": {
                "type": "object",
                "properties": properties,
                "required": required,
            },
        }

    def to_langchain_format(self) -> Dict[str, Any]:
        """Export as LangChain tool format."""
        return {
            "name": self.name,
            "description": self.description,
            "parameters": {
                "type": "object",
                "properties": {
                    p.name: {
                        "type": p.type,
                        "description": p.description,
                        **({"enum": p.enum} if p.enum else {}),
                    }
                    for p in self.parameters
                },
                "required": [p.name for p in self.parameters if p.required],
            },
        }

    def to_mcp_format(self) -> Dict[str, Any]:
        """Export as Model Context Protocol (MCP) format."""
        return {
            "name": self.name,
            "description": self.description,
            "inputSchema": {
                "type": "object",
                "properties": {
                    p.name: {
                        "type": p.type,
                        "description": p.description,
                        **({"enum": p.enum} if p.enum else {}),
                    }
                    for p in self.parameters
                },
                "required": [p.name for p in self.parameters if p.required],
            },
        }


# ─────────────────────────────────────────────────────────────────
# Function Registry — Central Registry for All Callable Functions
# ─────────────────────────────────────────────────────────────────

class FunctionRegistry:
    """
    Central registry for all AI-callable functions.
    Supports registration, discovery, invocation, and export to multiple formats.
    """

    def __init__(self):
        self._tools: Dict[str, ToolSchema] = {}
        self._categories: Dict[str, List[str]] = {}

    def register(self, tool: ToolSchema) -> None:
        """Register a tool in the registry."""
        self._tools[tool.name] = tool
        if tool.category not in self._categories:
            self._categories[tool.category] = []
        self._categories[tool.category].append(tool.name)

    def get(self, name: str) -> Optional[ToolSchema]:
        """Get a tool by name."""
        return self._tools.get(name)

    def list_tools(self, category: Optional[str] = None) -> List[str]:
        """List all registered tool names, optionally filtered by category."""
        if category:
            return self._categories.get(category, [])
        return list(self._tools.keys())

    def list_categories(self) -> List[str]:
        """List all categories."""
        return list(self._categories.keys())

    def invoke(self, name: str, **kwargs) -> Any:
        """Invoke a registered tool by name with given parameters."""
        tool = self._tools.get(name)
        if not tool:
            raise ValueError(f"Tool '{name}' not found in registry")
        if not tool.handler:
            raise ValueError(f"Tool '{name}' has no handler attached")
        return tool.handler(**kwargs)

    def export_openai(self, category: Optional[str] = None) -> List[Dict[str, Any]]:
        """Export all tools in OpenAI function calling format."""
        tools = self._tools.values()
        if category:
            tools = [t for t in tools if t.category == category]
        return [t.to_openai_format() for t in tools]

    def export_anthropic(self, category: Optional[str] = None) -> List[Dict[str, Any]]:
        """Export all tools in Anthropic tool use format."""
        tools = self._tools.values()
        if category:
            tools = [t for t in tools if t.category == category]
        return [t.to_anthropic_format() for t in tools]

    def export_langchain(self, category: Optional[str] = None) -> List[Dict[str, Any]]:
        """Export all tools in LangChain format."""
        tools = self._tools.values()
        if category:
            tools = [t for t in tools if t.category == category]
        return [t.to_langchain_format() for t in tools]

    def export_mcp(self, category: Optional[str] = None) -> List[Dict[str, Any]]:
        """Export all tools in MCP (Model Context Protocol) format."""
        tools = self._tools.values()
        if category:
            tools = [t for t in tools if t.category == category]
        return [t.to_mcp_format() for t in tools]

    def export_all_formats(self) -> Dict[str, List[Dict[str, Any]]]:
        """Export in all supported formats."""
        return {
            "openai": self.export_openai(),
            "anthropic": self.export_anthropic(),
            "langchain": self.export_langchain(),
            "mcp": self.export_mcp(),
        }

    @property
    def count(self) -> int:
        return len(self._tools)

    def status(self) -> Dict[str, Any]:
        return {
            "protocol": __protocol__,
            "version": __version__,
            "total_tools": self.count,
            "categories": self.list_categories(),
            "formats_supported": ["openai", "anthropic", "langchain", "mcp"],
        }


# Global registry singleton
registry = FunctionRegistry()


def invoke(name: str, **kwargs) -> Any:
    """Convenience function to invoke a tool from the global registry."""
    return registry.invoke(name, **kwargs)


__all__ = [
    "FunctionRegistry",
    "ToolSchema",
    "ToolParameter",
    "registry",
    "invoke",
    "__version__",
    "__protocol__",
]
