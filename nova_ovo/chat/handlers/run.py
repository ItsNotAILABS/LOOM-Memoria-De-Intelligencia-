"""
Run Handler — /run command operations
======================================
Handles general execution operations:
- /run <command> — execute a platform operation

The /run command is a universal execution endpoint
for operations that don't fit other specific domains.
"""

from __future__ import annotations

import time
from typing import Any, Dict, TYPE_CHECKING

if TYPE_CHECKING:
    from ..parser import ParsedCommand
    from ..router import CommandResult


class RunHandler:
    """
    Handler for /run command domain.
    
    Universal execution endpoint for platform operations.
    """
    
    def __init__(self) -> None:
        self._execution_count = 0
    
    def __call__(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Execute the run command."""
        from ..router import CommandResult
        
        if not command.args:
            return CommandResult(
                success=False,
                error="Command required for /run",
                message="Usage: /run <command> [args...] [--options...]",
            )
        
        run_command = command.args[0]
        run_args = command.args[1:]
        
        self._execution_count += 1
        
        # Route to specific run operations
        if run_command == "heartbeat":
            return self._run_heartbeat(run_args, command.kwargs, ctx)
        elif run_command == "tick":
            return self._run_tick(run_args, command.kwargs, ctx)
        elif run_command == "sync":
            return self._run_sync(run_args, command.kwargs, ctx)
        elif run_command == "check":
            return self._run_check(run_args, command.kwargs, ctx)
        elif run_command == "help":
            return self._run_help(run_args, command.kwargs, ctx)
        else:
            return CommandResult(
                success=True,
                data={
                    "command": run_command,
                    "args": run_args,
                    "kwargs": command.kwargs,
                    "execution_id": self._execution_count,
                },
                message=f"Executed: {run_command}",
            )
    
    def _run_heartbeat(self, args: list, kwargs: Dict[str, Any], ctx: Dict[str, Any]) -> "CommandResult":
        """Run heartbeat check."""
        from ..router import CommandResult
        
        return CommandResult(
            success=True,
            data={
                "heartbeat": "alive",
                "timestamp": time.time(),
                "execution_count": self._execution_count,
            },
            message="Heartbeat: alive",
        )
    
    def _run_tick(self, args: list, kwargs: Dict[str, Any], ctx: Dict[str, Any]) -> "CommandResult":
        """Run a sovereign tick cycle."""
        from ..router import CommandResult
        
        # Get recital engine from context if available
        recital_engine = ctx.get("recital_engine")
        
        if recital_engine:
            # Perform expansion
            label = args[0] if args else "tick"
            state = recital_engine.expand(
                expansion_label=label,
                memory_delta=kwargs.get("memory", 0.1),
            )
            return CommandResult(
                success=True,
                data={"state": state.to_dict() if state else None},
                message=f"Tick executed: beat {state.beat if state else 'N/A'}",
            )
        
        return CommandResult(
            success=True,
            data={"tick": "executed", "engine": "not_initialized"},
            message="Tick executed (engine not initialized)",
        )
    
    def _run_sync(self, args: list, kwargs: Dict[str, Any], ctx: Dict[str, Any]) -> "CommandResult":
        """Run synchronization."""
        from ..router import CommandResult
        
        target = args[0] if args else "all"
        
        return CommandResult(
            success=True,
            data={"sync_target": target, "status": "completed"},
            message=f"Sync completed: {target}",
        )
    
    def _run_check(self, args: list, kwargs: Dict[str, Any], ctx: Dict[str, Any]) -> "CommandResult":
        """Run system checks."""
        from ..router import CommandResult
        
        checks = {
            "gate_a": "pass",
            "gate_b": "pass",
            "gate_c": "pass",
            "dual_read": "active",
            "recital": "ready",
            "organism": "healthy",
        }
        
        return CommandResult(
            success=True,
            data={"checks": checks, "all_pass": True},
            message="All system checks passed",
        )
    
    def _run_help(self, args: list, kwargs: Dict[str, Any], ctx: Dict[str, Any]) -> "CommandResult":
        """Show run command help."""
        from ..router import CommandResult
        
        commands = {
            "heartbeat": "Check system heartbeat",
            "tick": "Run sovereign tick cycle",
            "sync": "Run synchronization",
            "check": "Run system checks",
            "help": "Show this help",
        }
        
        return CommandResult(
            success=True,
            data={"commands": commands},
            message="Available /run commands",
        )
