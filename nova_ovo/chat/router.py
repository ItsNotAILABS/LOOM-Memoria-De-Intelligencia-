"""
Command Router — Universal Chat Control Plane
==============================================
Routes parsed commands to appropriate handlers.

Maintains handler registry and execution context.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from typing import Any, Callable, Dict, List, Optional, TYPE_CHECKING

from .parser import CommandDomain, ParsedCommand

if TYPE_CHECKING:
    from ..core.gates import GateEnforcer


@dataclass
class CommandResult:
    """Result of a command execution."""
    
    result_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    success: bool = True
    data: Any = None
    message: str = ""
    error: Optional[str] = None
    timestamp: float = field(default_factory=time.time)
    command: Optional[ParsedCommand] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "result_id": self.result_id,
            "success": self.success,
            "data": self.data,
            "message": self.message,
            "error": self.error,
            "timestamp": self.timestamp,
            "command": self.command.to_dict() if self.command else None,
        }


# Handler type: (command, context) -> CommandResult
HandlerFn = Callable[[ParsedCommand, Dict[str, Any]], CommandResult]


class CommandRouter:
    """
    Routes commands to registered handlers.
    
    Each domain has a handler registered. The router dispatches
    parsed commands to the appropriate handler and records results
    for replay/audit.
    """
    
    def __init__(self, gate_enforcer: Optional["GateEnforcer"] = None) -> None:
        self._handlers: Dict[CommandDomain, HandlerFn] = {}
        self._results: List[CommandResult] = []
        self._gate_enforcer = gate_enforcer
        self._context: Dict[str, Any] = {}

    def register(self, domain: CommandDomain, handler: HandlerFn) -> None:
        """Register a handler for a command domain."""
        self._handlers[domain] = handler

    def unregister(self, domain: CommandDomain) -> None:
        """Unregister a handler."""
        self._handlers.pop(domain, None)

    def set_context(self, key: str, value: Any) -> None:
        """Set a context value available to all handlers."""
        self._context[key] = value

    def get_context(self, key: str, default: Any = None) -> Any:
        """Get a context value."""
        return self._context.get(key, default)

    def route(self, command: ParsedCommand) -> CommandResult:
        """
        Route a command to its handler and execute.
        
        Args:
            command: Parsed command to execute
            
        Returns:
            CommandResult with execution outcome
        """
        handler = self._handlers.get(command.domain)
        
        if handler is None:
            result = CommandResult(
                success=False,
                error=f"No handler registered for domain: {command.domain.value}",
                command=command,
            )
            self._results.append(result)
            return result
        
        try:
            # Create execution context
            ctx = {
                **self._context,
                "gate_enforcer": self._gate_enforcer,
                "router": self,
            }
            
            result = handler(command, ctx)
            result.command = command
            
        except Exception as e:
            result = CommandResult(
                success=False,
                error=str(e),
                command=command,
            )
        
        self._results.append(result)
        return result

    def execute(self, input_text: str, parser: "CommandParser") -> CommandResult:
        """
        Convenience method: parse and route in one call.
        
        Args:
            input_text: Raw user input
            parser: CommandParser instance
            
        Returns:
            CommandResult
        """
        from .parser import CommandParser
        command = parser.parse(input_text)
        return self.route(command)

    @property
    def results(self) -> List[CommandResult]:
        """Return execution results history."""
        return list(self._results)

    def get_results(
        self,
        domain: Optional[CommandDomain] = None,
        success: Optional[bool] = None,
        limit: int = 100,
    ) -> List[CommandResult]:
        """Query results with optional filters."""
        results = self._results
        if domain is not None:
            results = [r for r in results if r.command and r.command.domain == domain]
        if success is not None:
            results = [r for r in results if r.success == success]
        return results[-limit:]

    def clear_results(self) -> None:
        """Clear results history."""
        self._results.clear()
