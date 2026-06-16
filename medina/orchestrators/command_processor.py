"""
ORCH-08 FRONTEND_COMMAND_ORCHESTRATOR — Chat command processing.

Implements the universal chat control plane:
- One chat controls all platform planes
- Command + natural language modes
- Explicit, revocable, auditable settings

COMMAND GRAMMAR:
  /memory find ...
  /memory pin ...
  /memory map ...
  /govern status
  /govern propose ...
  /govern approve ...
  /model invoke ...
  /model route ...
  /workspace open ...
  /company onboard ...
  /company connect ...
  /company internalize ...
  /company hybrid ...
  /replay show ...
  /run ...
"""

from __future__ import annotations

import re
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Tuple


class CommandCategory(Enum):
    """Command categories mapping to platform planes."""
    
    MEMORY = "memory"
    GOVERN = "govern"
    MODEL = "model"
    WORKSPACE = "workspace"
    COMPANY = "company"
    REPLAY = "replay"
    RUN = "run"
    SYSTEM = "system"
    HELP = "help"


@dataclass
class ParsedCommand:
    """Result of parsing a command string."""
    
    raw: str = ""
    is_command: bool = False
    category: Optional[CommandCategory] = None
    action: str = ""
    args: List[str] = field(default_factory=list)
    kwargs: Dict[str, str] = field(default_factory=dict)
    error: Optional[str] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "raw": self.raw,
            "is_command": self.is_command,
            "category": self.category.value if self.category else None,
            "action": self.action,
            "args": self.args,
            "kwargs": self.kwargs,
            "error": self.error,
        }


@dataclass
class CommandResult:
    """Result of executing a command."""
    
    command_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    success: bool = True
    output: Any = None
    error: Optional[str] = None
    timestamp: float = field(default_factory=time.time)
    execution_ms: float = 0.0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "command_id": self.command_id,
            "success": self.success,
            "output": self.output,
            "error": self.error,
            "timestamp": self.timestamp,
            "execution_ms": round(self.execution_ms, 3),
        }


@dataclass
class CommandLog:
    """Log entry for executed command."""
    
    log_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    command: ParsedCommand = field(default_factory=ParsedCommand)
    result: CommandResult = field(default_factory=CommandResult)
    actor: str = "user"
    beat: int = 0
    timestamp: float = field(default_factory=time.time)


# Command handler function type
CommandHandler = Callable[[ParsedCommand], CommandResult]


class CommandOrchestrator:
    """
    ORCH-08 FRONTEND_COMMAND_ORCHESTRATOR
    
    Universal chat control plane for MEDINA.
    
    Responsibilities:
    - Parse command input
    - Route to appropriate handlers
    - Execute and return results
    - Log all commands for audit
    
    Command format:
      /<category> <action> [args...] [--key=value ...]
    
    Examples:
      /memory find important notes
      /govern propose --title="New policy"
      /model invoke strategist
    """
    
    # Command patterns
    COMMAND_PREFIX = "/"
    KWARG_PATTERN = re.compile(r"--(\w+)=([^\s]+|\"[^\"]*\"|'[^']*')")
    
    def __init__(self) -> None:
        self._id = str(uuid.uuid4())
        self._handlers: Dict[str, Dict[str, CommandHandler]] = {}
        self._command_log: List[CommandLog] = []
        self._current_beat = 0
        
        # Register default handlers
        self._register_default_handlers()
    
    def _register_default_handlers(self) -> None:
        """Register built-in command handlers."""
        
        # Help command
        def help_handler(cmd: ParsedCommand) -> CommandResult:
            categories = list(CommandCategory)
            help_text = "Available commands:\n"
            for cat in categories:
                help_text += f"  /{cat.value} - {cat.value.title()} operations\n"
            return CommandResult(success=True, output=help_text)
        
        self.register_handler(CommandCategory.HELP, "help", help_handler)
        self.register_handler(CommandCategory.HELP, "", help_handler)
        
        # System status
        def status_handler(cmd: ParsedCommand) -> CommandResult:
            return CommandResult(success=True, output=self.status())
        
        self.register_handler(CommandCategory.SYSTEM, "status", status_handler)
        
        # Placeholder handlers for main categories
        for category in [CommandCategory.MEMORY, CommandCategory.GOVERN, 
                        CommandCategory.MODEL, CommandCategory.WORKSPACE,
                        CommandCategory.COMPANY, CommandCategory.REPLAY,
                        CommandCategory.RUN]:
            def make_handler(cat: CommandCategory):
                def handler(cmd: ParsedCommand) -> CommandResult:
                    return CommandResult(
                        success=True,
                        output=f"[{cat.value}] Command received: {cmd.action} {cmd.args}",
                    )
                return handler
            self.register_handler(category, "*", make_handler(category))
    
    # ------------------------------------------------------------------ #
    # Handler Registration                                                  #
    # ------------------------------------------------------------------ #
    
    def register_handler(
        self,
        category: CommandCategory,
        action: str,
        handler: CommandHandler,
    ) -> None:
        """
        Register a command handler.
        
        Use action="*" for catch-all handler.
        """
        if category.value not in self._handlers:
            self._handlers[category.value] = {}
        self._handlers[category.value][action] = handler
    
    def unregister_handler(
        self,
        category: CommandCategory,
        action: str,
    ) -> bool:
        """Remove a command handler."""
        if category.value in self._handlers:
            if action in self._handlers[category.value]:
                del self._handlers[category.value][action]
                return True
        return False
    
    # ------------------------------------------------------------------ #
    # Parsing                                                               #
    # ------------------------------------------------------------------ #
    
    def parse(self, input_text: str) -> ParsedCommand:
        """
        Parse input text into a command structure.
        
        Format: /<category> <action> [args...] [--key=value ...]
        """
        text = input_text.strip()
        
        # Check if it's a command
        if not text.startswith(self.COMMAND_PREFIX):
            return ParsedCommand(raw=text, is_command=False)
        
        # Remove prefix and split
        text = text[len(self.COMMAND_PREFIX):]
        
        # Extract kwargs first
        kwargs: Dict[str, str] = {}
        for match in self.KWARG_PATTERN.finditer(text):
            key = match.group(1)
            value = match.group(2).strip("\"'")
            kwargs[key] = value
        
        # Remove kwargs from text
        text = self.KWARG_PATTERN.sub("", text).strip()
        
        # Split remaining text
        parts = text.split()
        
        if not parts:
            return ParsedCommand(
                raw=input_text,
                is_command=True,
                category=CommandCategory.HELP,
                action="help",
            )
        
        # First part is category
        category_str = parts[0].lower()
        try:
            category = CommandCategory(category_str)
        except ValueError:
            return ParsedCommand(
                raw=input_text,
                is_command=True,
                error=f"Unknown command category: {category_str}",
            )
        
        # Second part is action (if present)
        action = parts[1] if len(parts) > 1 else ""
        
        # Rest are args
        args = parts[2:] if len(parts) > 2 else []
        
        return ParsedCommand(
            raw=input_text,
            is_command=True,
            category=category,
            action=action,
            args=args,
            kwargs=kwargs,
        )
    
    # ------------------------------------------------------------------ #
    # Execution                                                             #
    # ------------------------------------------------------------------ #
    
    def execute(
        self,
        input_text: str,
        actor: str = "user",
    ) -> CommandResult:
        """
        Parse and execute a command.
        
        For non-command input, returns a result indicating natural language.
        """
        start_time = time.time()
        
        # Parse
        parsed = self.parse(input_text)
        
        if not parsed.is_command:
            return CommandResult(
                success=True,
                output={"type": "natural_language", "text": input_text},
            )
        
        if parsed.error:
            return CommandResult(
                success=False,
                error=parsed.error,
            )
        
        # Find handler
        handler = self._find_handler(parsed)
        
        if not handler:
            return CommandResult(
                success=False,
                error=f"No handler for: /{parsed.category.value if parsed.category else '?'} {parsed.action}",
            )
        
        # Execute
        try:
            result = handler(parsed)
        except Exception as e:
            result = CommandResult(
                success=False,
                error=f"Command execution error: {e}",
            )
        
        result.execution_ms = (time.time() - start_time) * 1000
        
        # Log
        log_entry = CommandLog(
            command=parsed,
            result=result,
            actor=actor,
            beat=self._current_beat,
        )
        self._command_log.append(log_entry)
        
        return result
    
    def _find_handler(self, parsed: ParsedCommand) -> Optional[CommandHandler]:
        """Find appropriate handler for a parsed command."""
        if not parsed.category:
            return None
        
        cat_handlers = self._handlers.get(parsed.category.value, {})
        
        # Try exact action match
        if parsed.action in cat_handlers:
            return cat_handlers[parsed.action]
        
        # Try catch-all
        if "*" in cat_handlers:
            return cat_handlers["*"]
        
        return None
    
    # ------------------------------------------------------------------ #
    # Command Suggestions                                                   #
    # ------------------------------------------------------------------ #
    
    def get_suggestions(self, partial: str) -> List[str]:
        """Get command suggestions for partial input."""
        suggestions: List[str] = []
        
        if not partial.startswith("/"):
            # Suggest starting a command
            return [f"/{cat.value}" for cat in CommandCategory]
        
        partial = partial[1:].lower()
        
        # Match categories
        for cat in CommandCategory:
            if cat.value.startswith(partial):
                suggestions.append(f"/{cat.value}")
        
        return suggestions
    
    def get_actions(self, category: CommandCategory) -> List[str]:
        """Get available actions for a category."""
        cat_handlers = self._handlers.get(category.value, {})
        return [a for a in cat_handlers.keys() if a != "*"]
    
    # ------------------------------------------------------------------ #
    # Log Access                                                            #
    # ------------------------------------------------------------------ #
    
    def get_log(
        self,
        actor: Optional[str] = None,
        category: Optional[CommandCategory] = None,
        limit: int = 100,
    ) -> List[CommandLog]:
        """Query command log."""
        logs = self._command_log
        
        if actor:
            logs = [l for l in logs if l.actor == actor]
        if category:
            logs = [l for l in logs if l.command.category == category]
        
        return logs[-limit:]
    
    # ------------------------------------------------------------------ #
    # Beat Integration                                                      #
    # ------------------------------------------------------------------ #
    
    def tick(self, beat: int) -> None:
        """Process beat for command orchestrator."""
        self._current_beat = beat
    
    # ------------------------------------------------------------------ #
    # Status                                                                #
    # ------------------------------------------------------------------ #
    
    def status(self) -> Dict[str, Any]:
        """Current orchestrator status."""
        handler_count = sum(len(h) for h in self._handlers.values())
        
        return {
            "orchestrator_id": self._id,
            "name": "ORCH-08 FRONTEND_COMMAND_ORCHESTRATOR",
            "current_beat": self._current_beat,
            "registered_categories": list(self._handlers.keys()),
            "handler_count": handler_count,
            "command_log_size": len(self._command_log),
        }
