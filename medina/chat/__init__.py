"""
MEDINA Chat — Universal control surface.

Chat is the universal control surface for MEDINA:
- One chat controls all platform planes
- Command + natural language modes
- Settings/toggles are explicit, revocable, auditable

Operator surfaces through chat:
- memory operations
- governance operations
- model routing/invocation
- workspace actions
- enterprise operations
- replay/evidence inspection
"""

from medina.orchestrators.command_processor import (
    CommandOrchestrator,
    ParsedCommand,
    CommandResult,
    CommandCategory,
    CommandLog,
)

__all__ = [
    "CommandOrchestrator",
    "ParsedCommand",
    "CommandResult",
    "CommandCategory",
    "CommandLog",
]
