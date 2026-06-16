"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║              AI PROVIDER TOOL ADAPTERS — OpenAI / Anthropic / LangChain / MCP               ║
║              Protocol: PROT-542 — PROVIDER ADAPTERS                                          ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations
from typing import Any, Dict, List, Optional
from callable import FunctionRegistry, ToolSchema, ToolParameter, registry


# ─────────────────────────────────────────────────────────────────
# OpenAI Tool Adapter
# ─────────────────────────────────────────────────────────────────

class OpenAIToolAdapter:
    """Adapter for OpenAI function calling / tool use."""

    def __init__(self, reg: FunctionRegistry = registry):
        self.registry = reg

    def get_tools(self, category: Optional[str] = None) -> List[Dict[str, Any]]:
        """Get tools formatted for OpenAI chat completions."""
        return self.registry.export_openai(category)

    def handle_tool_call(self, tool_call: Dict[str, Any]) -> Any:
        """Handle an OpenAI tool call response."""
        import json
        name = tool_call.get("function", {}).get("name", "")
        args = json.loads(tool_call.get("function", {}).get("arguments", "{}"))
        return self.registry.invoke(name, **args)


# ─────────────────────────────────────────────────────────────────
# Anthropic Tool Adapter
# ─────────────────────────────────────────────────────────────────

class AnthropicToolAdapter:
    """Adapter for Anthropic tool use."""

    def __init__(self, reg: FunctionRegistry = registry):
        self.registry = reg

    def get_tools(self, category: Optional[str] = None) -> List[Dict[str, Any]]:
        """Get tools formatted for Anthropic messages API."""
        return self.registry.export_anthropic(category)

    def handle_tool_use(self, tool_use_block: Dict[str, Any]) -> Any:
        """Handle an Anthropic tool_use content block."""
        name = tool_use_block.get("name", "")
        inputs = tool_use_block.get("input", {})
        return self.registry.invoke(name, **inputs)


# ─────────────────────────────────────────────────────────────────
# LangChain Tool Adapter
# ─────────────────────────────────────────────────────────────────

class LangChainToolAdapter:
    """Adapter for LangChain tools integration."""

    def __init__(self, reg: FunctionRegistry = registry):
        self.registry = reg

    def get_tools(self, category: Optional[str] = None) -> List[Dict[str, Any]]:
        """Get tools formatted for LangChain agents."""
        return self.registry.export_langchain(category)

    def as_langchain_tools(self, category: Optional[str] = None) -> List[Any]:
        """Convert registry tools to LangChain Tool objects (requires langchain)."""
        try:
            from langchain.tools import StructuredTool
        except ImportError:
            return []

        tools = []
        names = self.registry.list_tools(category)
        for name in names:
            schema = self.registry.get(name)
            if schema and schema.handler:
                tool = StructuredTool.from_function(
                    func=schema.handler,
                    name=schema.name,
                    description=schema.description,
                )
                tools.append(tool)
        return tools


# ─────────────────────────────────────────────────────────────────
# MCP Server Adapter
# ─────────────────────────────────────────────────────────────────

class MCPServerAdapter:
    """Adapter for Model Context Protocol (MCP) servers."""

    def __init__(self, reg: FunctionRegistry = registry):
        self.registry = reg

    def get_tools(self, category: Optional[str] = None) -> List[Dict[str, Any]]:
        """Get tools formatted as MCP tool definitions."""
        return self.registry.export_mcp(category)

    def handle_call(self, name: str, arguments: Dict[str, Any]) -> Dict[str, Any]:
        """Handle an MCP tool call."""
        try:
            result = self.registry.invoke(name, **arguments)
            return {"content": [{"type": "text", "text": str(result)}]}
        except Exception as e:
            return {"content": [{"type": "text", "text": f"Error: {e}"}], "isError": True}


# ─────────────────────────────────────────────────────────────────
# Convenience Instances
# ─────────────────────────────────────────────────────────────────

openai_tools = OpenAIToolAdapter()
anthropic_tools = AnthropicToolAdapter()
langchain_tools = LangChainToolAdapter()
mcp_tools = MCPServerAdapter()

__all__ = [
    "OpenAIToolAdapter",
    "AnthropicToolAdapter",
    "LangChainToolAdapter",
    "MCPServerAdapter",
    "openai_tools",
    "anthropic_tools",
    "langchain_tools",
    "mcp_tools",
]
