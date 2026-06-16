"""
Command Parser — Universal Chat Control Plane
==============================================
Parses command grammar:
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

Also handles natural language input (non-command mode).
"""

from __future__ import annotations

import re
import shlex
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional


class CommandDomain(str, Enum):
    """Top-level command domains."""
    MEMORY = "memory"
    GOVERN = "govern"
    MODEL = "model"
    WORKSPACE = "workspace"
    COMPANY = "company"
    REPLAY = "replay"
    RUN = "run"
    NATURAL = "natural"  # Non-command natural language


class MemoryAction(str, Enum):
    FIND = "find"
    PIN = "pin"
    MAP = "map"
    UNPIN = "unpin"
    TRAVERSE = "traverse"
    CONSOLIDATE = "consolidate"


class GovernAction(str, Enum):
    STATUS = "status"
    PROPOSE = "propose"
    APPROVE = "approve"
    REJECT = "reject"
    AUDIT = "audit"


class ModelAction(str, Enum):
    INVOKE = "invoke"
    ROUTE = "route"
    LIST = "list"
    STATUS = "status"


class WorkspaceAction(str, Enum):
    OPEN = "open"
    CLOSE = "close"
    LIST = "list"
    STATUS = "status"


class CompanyAction(str, Enum):
    ONBOARD = "onboard"
    CONNECT = "connect"
    INTERNALIZE = "internalize"
    HYBRID = "hybrid"
    STATUS = "status"
    LIST = "list"


class ReplayAction(str, Enum):
    SHOW = "show"
    LIST = "list"
    EXPORT = "export"


@dataclass
class ParsedCommand:
    """
    Parsed command structure.
    
    Attributes:
        domain: Top-level command domain (memory, govern, etc.)
        action: Sub-action within the domain
        args: Positional arguments
        kwargs: Named arguments (--key=value or --flag)
        raw: Original raw input
        is_command: True if slash command, False if natural language
    """
    domain: CommandDomain
    action: Optional[str] = None
    args: List[str] = field(default_factory=list)
    kwargs: Dict[str, Any] = field(default_factory=dict)
    raw: str = ""
    is_command: bool = True

    def to_dict(self) -> Dict[str, Any]:
        return {
            "domain": self.domain.value,
            "action": self.action,
            "args": self.args,
            "kwargs": self.kwargs,
            "raw": self.raw,
            "is_command": self.is_command,
        }


class CommandParser:
    """
    Parses user input into structured commands.
    
    Supports both slash-command mode and natural language mode.
    """
    
    # Command pattern: /domain action [args...] [--kwargs...]
    COMMAND_PATTERN = re.compile(r"^/(\w+)(?:\s+(.*))?$", re.DOTALL)
    
    # Named argument pattern: --key=value or --flag
    KWARG_PATTERN = re.compile(r"--(\w+)(?:=(.+))?")
    
    DOMAIN_MAP = {
        "memory": CommandDomain.MEMORY,
        "mem": CommandDomain.MEMORY,
        "govern": CommandDomain.GOVERN,
        "gov": CommandDomain.GOVERN,
        "model": CommandDomain.MODEL,
        "workspace": CommandDomain.WORKSPACE,
        "ws": CommandDomain.WORKSPACE,
        "company": CommandDomain.COMPANY,
        "co": CommandDomain.COMPANY,
        "replay": CommandDomain.REPLAY,
        "run": CommandDomain.RUN,
    }

    def __init__(self) -> None:
        self._history: List[ParsedCommand] = []

    def parse(self, input_text: str) -> ParsedCommand:
        """
        Parse user input into a structured command.
        
        Args:
            input_text: Raw user input
            
        Returns:
            ParsedCommand with domain, action, args, and kwargs
        """
        input_text = input_text.strip()
        
        # Check if it's a slash command
        match = self.COMMAND_PATTERN.match(input_text)
        if not match:
            # Natural language mode
            cmd = ParsedCommand(
                domain=CommandDomain.NATURAL,
                raw=input_text,
                is_command=False,
                args=[input_text],
            )
            self._history.append(cmd)
            return cmd
        
        domain_str = match.group(1).lower()
        rest = match.group(2) or ""
        
        # Map domain alias to canonical domain
        domain = self.DOMAIN_MAP.get(domain_str)
        if domain is None:
            # Unknown domain, treat as natural language
            cmd = ParsedCommand(
                domain=CommandDomain.NATURAL,
                raw=input_text,
                is_command=False,
                args=[input_text],
            )
            self._history.append(cmd)
            return cmd
        
        # Special case: /run has no sub-action
        if domain == CommandDomain.RUN:
            args, kwargs = self._parse_args(rest)
            cmd = ParsedCommand(
                domain=domain,
                action="execute",
                args=args,
                kwargs=kwargs,
                raw=input_text,
                is_command=True,
            )
            self._history.append(cmd)
            return cmd
        
        # Parse action and remaining arguments
        parts = rest.split(maxsplit=1)
        action = parts[0].lower() if parts else None
        remaining = parts[1] if len(parts) > 1 else ""
        
        args, kwargs = self._parse_args(remaining)
        
        cmd = ParsedCommand(
            domain=domain,
            action=action,
            args=args,
            kwargs=kwargs,
            raw=input_text,
            is_command=True,
        )
        self._history.append(cmd)
        return cmd

    def _parse_args(self, text: str) -> tuple[List[str], Dict[str, Any]]:
        """Parse positional args and --kwargs from text."""
        if not text.strip():
            return [], {}
        
        try:
            tokens = shlex.split(text)
        except ValueError:
            # Fallback to simple split if shlex fails
            tokens = text.split()
        
        args: List[str] = []
        kwargs: Dict[str, Any] = {}
        
        for token in tokens:
            kwarg_match = self.KWARG_PATTERN.match(token)
            if kwarg_match:
                key = kwarg_match.group(1)
                value = kwarg_match.group(2)
                if value is None:
                    # Flag without value (--flag)
                    kwargs[key] = True
                else:
                    # Try to parse as number or bool
                    kwargs[key] = self._parse_value(value)
            else:
                args.append(token)
        
        return args, kwargs

    def _parse_value(self, value: str) -> Any:
        """Parse a value string to appropriate Python type."""
        # Boolean
        if value.lower() in ("true", "yes", "on"):
            return True
        if value.lower() in ("false", "no", "off"):
            return False
        
        # Integer
        try:
            return int(value)
        except ValueError:
            pass
        
        # Float
        try:
            return float(value)
        except ValueError:
            pass
        
        # String
        return value

    @property
    def history(self) -> List[ParsedCommand]:
        """Return command history."""
        return list(self._history)

    def clear_history(self) -> None:
        """Clear command history."""
        self._history.clear()
