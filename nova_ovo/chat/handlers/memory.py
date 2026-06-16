"""
Memory Handler — /memory command operations
============================================
Handles memory temple operations:
- /memory find <query> — search memory by content/coordinates
- /memory pin <id> — pin a memory node
- /memory map — show memory topology
- /memory unpin <id> — unpin a memory node
- /memory traverse <coords> — navigate to coordinates
- /memory consolidate — trigger consolidation cycle
"""

from __future__ import annotations

from typing import Any, Dict, TYPE_CHECKING

if TYPE_CHECKING:
    from ..parser import ParsedCommand
    from ..router import CommandResult


class MemoryHandler:
    """
    Handler for /memory command domain.
    
    Memory Temple operations with helix/ring/coordinate addressing.
    All operations are lineage-aware and replayable.
    """
    
    def __init__(self) -> None:
        self._pinned: Dict[str, Any] = {}
    
    def __call__(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Route to appropriate memory action."""
        from ..router import CommandResult
        
        action = command.action
        
        if action == "find":
            return self._find(command, ctx)
        elif action == "pin":
            return self._pin(command, ctx)
        elif action == "map":
            return self._map(command, ctx)
        elif action == "unpin":
            return self._unpin(command, ctx)
        elif action == "traverse":
            return self._traverse(command, ctx)
        elif action == "consolidate":
            return self._consolidate(command, ctx)
        else:
            return CommandResult(
                success=False,
                error=f"Unknown memory action: {action}",
                message="Valid actions: find, pin, map, unpin, traverse, consolidate",
            )
    
    def _find(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Find memories by query or coordinates."""
        from ..router import CommandResult
        
        query = " ".join(command.args) if command.args else ""
        
        # Get memory temple from context if available
        temple = ctx.get("memory_temple")
        if temple is None:
            return CommandResult(
                success=True,
                data={"query": query, "results": []},
                message=f"Memory search for: {query} (temple not initialized)",
            )
        
        # Perform search
        results = temple.find(query, **command.kwargs)
        return CommandResult(
            success=True,
            data={"query": query, "results": results},
            message=f"Found {len(results)} memories matching: {query}",
        )
    
    def _pin(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Pin a memory node for quick access."""
        from ..router import CommandResult
        
        if not command.args:
            return CommandResult(
                success=False,
                error="Memory ID required for pin operation",
            )
        
        memory_id = command.args[0]
        self._pinned[memory_id] = {
            "id": memory_id,
            "label": command.kwargs.get("label", ""),
        }
        
        return CommandResult(
            success=True,
            data={"pinned_id": memory_id},
            message=f"Pinned memory: {memory_id}",
        )
    
    def _map(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Show memory topology map."""
        from ..router import CommandResult
        
        temple = ctx.get("memory_temple")
        if temple is None:
            return CommandResult(
                success=True,
                data={"topology": None, "pinned": list(self._pinned.keys())},
                message="Memory map (temple not initialized)",
            )
        
        topology = temple.get_topology()
        return CommandResult(
            success=True,
            data={"topology": topology, "pinned": list(self._pinned.keys())},
            message="Memory topology retrieved",
        )
    
    def _unpin(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Unpin a memory node."""
        from ..router import CommandResult
        
        if not command.args:
            return CommandResult(
                success=False,
                error="Memory ID required for unpin operation",
            )
        
        memory_id = command.args[0]
        if memory_id in self._pinned:
            del self._pinned[memory_id]
            return CommandResult(
                success=True,
                data={"unpinned_id": memory_id},
                message=f"Unpinned memory: {memory_id}",
            )
        else:
            return CommandResult(
                success=False,
                error=f"Memory not pinned: {memory_id}",
            )
    
    def _traverse(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Navigate to specific coordinates."""
        from ..router import CommandResult
        
        # Parse coordinates from args or kwargs
        coords = {
            "theta": command.kwargs.get("theta", 0.0),
            "phi": command.kwargs.get("phi", 0.0),
            "depth": command.kwargs.get("depth", 1.0),
            "ring": command.kwargs.get("ring", 0),
            "beat": command.kwargs.get("beat"),
        }
        
        temple = ctx.get("memory_temple")
        if temple is None:
            return CommandResult(
                success=True,
                data={"target_coords": coords, "current": None},
                message=f"Navigate to coordinates (temple not initialized)",
            )
        
        result = temple.traverse(coords)
        return CommandResult(
            success=True,
            data={"target_coords": coords, "current": result},
            message=f"Traversed to coordinates",
        )
    
    def _consolidate(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Trigger memory consolidation cycle."""
        from ..router import CommandResult
        
        temple = ctx.get("memory_temple")
        if temple is None:
            return CommandResult(
                success=True,
                data={"consolidated": 0},
                message="Consolidation triggered (temple not initialized)",
            )
        
        count = temple.consolidate(**command.kwargs)
        return CommandResult(
            success=True,
            data={"consolidated": count},
            message=f"Consolidated {count} memory nodes",
        )
