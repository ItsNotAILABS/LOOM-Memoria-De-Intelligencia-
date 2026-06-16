"""
Replay Handler — /replay command operations
============================================
Handles replay/evidence operations:
- /replay show <id> — show replay bundle
- /replay list — list available replays
- /replay export <id> — export replay bundle

Incident + rollback + replay required.
Every adaptation has lineage, evidence, rollback path.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, TYPE_CHECKING

if TYPE_CHECKING:
    from ..parser import ParsedCommand
    from ..router import CommandResult


class ReplayType(str, Enum):
    STATE_CHANGE = "state_change"
    COMMAND_EXECUTION = "command_execution"
    GATE_EVALUATION = "gate_evaluation"
    GOVERNANCE_ACTION = "governance_action"
    MEMORY_OPERATION = "memory_operation"
    MODEL_INVOCATION = "model_invocation"
    INCIDENT = "incident"
    ROLLBACK = "rollback"


@dataclass
class ReplayEntry:
    """A single replay entry with lineage."""
    
    entry_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    replay_type: ReplayType = ReplayType.STATE_CHANGE
    parent_id: Optional[str] = None
    beat: int = 0
    actor: str = "system"
    action: str = ""
    input_state: Dict[str, Any] = field(default_factory=dict)
    output_state: Dict[str, Any] = field(default_factory=dict)
    evidence: Dict[str, Any] = field(default_factory=dict)
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "entry_id": self.entry_id,
            "replay_type": self.replay_type.value,
            "parent_id": self.parent_id,
            "beat": self.beat,
            "actor": self.actor,
            "action": self.action,
            "input_state": self.input_state,
            "output_state": self.output_state,
            "evidence": self.evidence,
            "timestamp": self.timestamp,
        }


@dataclass
class ReplayBundle:
    """A bundle of replay entries for export/inspection."""
    
    bundle_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    entries: List[ReplayEntry] = field(default_factory=list)
    created_at: float = field(default_factory=time.time)
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "bundle_id": self.bundle_id,
            "name": self.name,
            "entry_count": len(self.entries),
            "created_at": self.created_at,
            "metadata": self.metadata,
        }
    
    def to_full_dict(self) -> Dict[str, Any]:
        d = self.to_dict()
        d["entries"] = [e.to_dict() for e in self.entries]
        return d


class ReplayHandler:
    """
    Handler for /replay command domain.
    
    Replay/evidence inspection with lineage awareness.
    """
    
    def __init__(self) -> None:
        self._entries: List[ReplayEntry] = []
        self._bundles: Dict[str, ReplayBundle] = {}
        self._beat_counter = 0
    
    def __call__(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Route to appropriate replay action."""
        from ..router import CommandResult
        
        action = command.action
        
        if action == "show":
            return self._show(command, ctx)
        elif action == "list":
            return self._list(command, ctx)
        elif action == "export":
            return self._export(command, ctx)
        else:
            return CommandResult(
                success=False,
                error=f"Unknown replay action: {action}",
                message="Valid actions: show, list, export",
            )
    
    def record(
        self,
        replay_type: ReplayType,
        action: str,
        input_state: Dict[str, Any],
        output_state: Dict[str, Any],
        evidence: Optional[Dict[str, Any]] = None,
        actor: str = "system",
        parent_id: Optional[str] = None,
    ) -> ReplayEntry:
        """Record a replay entry."""
        self._beat_counter += 1
        
        entry = ReplayEntry(
            replay_type=replay_type,
            parent_id=parent_id or (self._entries[-1].entry_id if self._entries else None),
            beat=self._beat_counter,
            actor=actor,
            action=action,
            input_state=input_state,
            output_state=output_state,
            evidence=evidence or {},
        )
        
        self._entries.append(entry)
        return entry
    
    def _show(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Show replay bundle or entry."""
        from ..router import CommandResult
        
        if not command.args:
            # Show recent entries
            limit = command.kwargs.get("limit", 10)
            entries = self._entries[-limit:]
            return CommandResult(
                success=True,
                data={"entries": [e.to_dict() for e in entries]},
                message=f"Showing {len(entries)} recent replay entries",
            )
        
        identifier = command.args[0]
        
        # Check bundles
        bundle = self._bundles.get(identifier)
        if bundle:
            return CommandResult(
                success=True,
                data={"bundle": bundle.to_full_dict()},
                message=f"Replay bundle: {bundle.name}",
            )
        
        # Check entries
        entry = next((e for e in self._entries if e.entry_id == identifier), None)
        if entry:
            # Get lineage
            lineage = self._trace_lineage(entry.entry_id)
            return CommandResult(
                success=True,
                data={
                    "entry": entry.to_dict(),
                    "lineage": [e.to_dict() for e in lineage],
                },
                message=f"Replay entry with {len(lineage)} ancestors",
            )
        
        return CommandResult(
            success=False,
            error=f"Replay not found: {identifier}",
        )
    
    def _list(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """List available replays."""
        from ..router import CommandResult
        
        type_filter = command.kwargs.get("type")
        limit = command.kwargs.get("limit", 50)
        
        entries = self._entries
        if type_filter:
            entries = [e for e in entries if e.replay_type.value == type_filter]
        
        return CommandResult(
            success=True,
            data={
                "entries": [e.to_dict() for e in entries[-limit:]],
                "bundles": [b.to_dict() for b in self._bundles.values()],
                "total_entries": len(self._entries),
                "total_bundles": len(self._bundles),
            },
            message=f"Replay: {len(self._entries)} entries, {len(self._bundles)} bundles",
        )
    
    def _export(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Export replay bundle."""
        from ..router import CommandResult
        
        name = command.args[0] if command.args else f"export-{uuid.uuid4().hex[:8]}"
        
        # Filter entries for export
        type_filter = command.kwargs.get("type")
        from_beat = command.kwargs.get("from_beat", 0)
        to_beat = command.kwargs.get("to_beat")
        
        entries = self._entries
        
        if type_filter:
            entries = [e for e in entries if e.replay_type.value == type_filter]
        
        entries = [e for e in entries if e.beat >= from_beat]
        if to_beat is not None:
            entries = [e for e in entries if e.beat <= to_beat]
        
        bundle = ReplayBundle(
            name=name,
            entries=list(entries),
            metadata={
                "type_filter": type_filter,
                "from_beat": from_beat,
                "to_beat": to_beat,
                "exported_by": ctx.get("actor", "operator"),
            },
        )
        
        self._bundles[bundle.bundle_id] = bundle
        
        return CommandResult(
            success=True,
            data={"bundle": bundle.to_dict()},
            message=f"Exported {len(entries)} entries to bundle: {name}",
        )
    
    def _trace_lineage(self, entry_id: str) -> List[ReplayEntry]:
        """Trace lineage back to root."""
        id_map = {e.entry_id: e for e in self._entries}
        chain: List[ReplayEntry] = []
        current_id: Optional[str] = entry_id
        
        while current_id and current_id in id_map:
            entry = id_map[current_id]
            chain.insert(0, entry)
            current_id = entry.parent_id
        
        return chain
