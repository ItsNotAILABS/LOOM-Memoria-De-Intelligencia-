"""
Workspace Handler — /workspace command operations
==================================================
Handles agentic workspace fabric operations:
- /workspace open <name> — open a workspace
- /workspace close <name> — close a workspace
- /workspace list — list workspaces
- /workspace status — show workspace status

Implements packetized operation:
- task constitution packet
- agent work packet
- arbitration record
- integration contract
- replay bundle
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


class WorkspaceStatus(str, Enum):
    OPEN = "open"
    CLOSED = "closed"
    SUSPENDED = "suspended"


class PacketType(str, Enum):
    TASK_CONSTITUTION = "task_constitution"
    AGENT_WORK = "agent_work"
    ARBITRATION = "arbitration"
    INTEGRATION_CONTRACT = "integration_contract"
    REPLAY_BUNDLE = "replay_bundle"


@dataclass
class WorkspacePacket:
    """A packetized operation unit."""
    
    packet_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    packet_type: PacketType = PacketType.TASK_CONSTITUTION
    workspace_id: str = ""
    content: Dict[str, Any] = field(default_factory=dict)
    created_at: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "packet_id": self.packet_id,
            "packet_type": self.packet_type.value,
            "workspace_id": self.workspace_id,
            "content": self.content,
            "created_at": self.created_at,
        }


@dataclass
class Workspace:
    """An agentic workspace instance."""
    
    workspace_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    status: WorkspaceStatus = WorkspaceStatus.CLOSED
    created_at: float = field(default_factory=time.time)
    opened_at: Optional[float] = None
    closed_at: Optional[float] = None
    packets: List[WorkspacePacket] = field(default_factory=list)
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "workspace_id": self.workspace_id,
            "name": self.name,
            "status": self.status.value,
            "created_at": self.created_at,
            "opened_at": self.opened_at,
            "closed_at": self.closed_at,
            "packet_count": len(self.packets),
            "metadata": self.metadata,
        }


class WorkspaceHandler:
    """
    Handler for /workspace command domain.
    
    Agentic workspace fabric with packetized operations.
    """
    
    def __init__(self) -> None:
        self._workspaces: Dict[str, Workspace] = {}
    
    def __call__(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Route to appropriate workspace action."""
        from ..router import CommandResult
        
        action = command.action
        
        if action == "open":
            return self._open(command, ctx)
        elif action == "close":
            return self._close(command, ctx)
        elif action == "list":
            return self._list(command, ctx)
        elif action == "status":
            return self._status(command, ctx)
        else:
            return CommandResult(
                success=False,
                error=f"Unknown workspace action: {action}",
                message="Valid actions: open, close, list, status",
            )
    
    def _open(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Open a workspace."""
        from ..router import CommandResult
        
        name = command.args[0] if command.args else f"workspace-{len(self._workspaces) + 1}"
        
        # Check if already exists
        existing = next((w for w in self._workspaces.values() if w.name == name), None)
        if existing:
            if existing.status == WorkspaceStatus.OPEN:
                return CommandResult(
                    success=True,
                    data={"workspace": existing.to_dict()},
                    message=f"Workspace already open: {name}",
                )
            # Reopen
            existing.status = WorkspaceStatus.OPEN
            existing.opened_at = time.time()
            
            # Create task constitution packet
            packet = WorkspacePacket(
                packet_type=PacketType.TASK_CONSTITUTION,
                workspace_id=existing.workspace_id,
                content={"action": "reopen", "metadata": command.kwargs},
            )
            existing.packets.append(packet)
            
            return CommandResult(
                success=True,
                data={"workspace": existing.to_dict(), "packet": packet.to_dict()},
                message=f"Workspace reopened: {name}",
            )
        
        # Create new workspace
        workspace = Workspace(
            name=name,
            status=WorkspaceStatus.OPEN,
            opened_at=time.time(),
            metadata=command.kwargs,
        )
        
        # Create task constitution packet
        packet = WorkspacePacket(
            packet_type=PacketType.TASK_CONSTITUTION,
            workspace_id=workspace.workspace_id,
            content={"action": "create", "name": name, "metadata": command.kwargs},
        )
        workspace.packets.append(packet)
        
        self._workspaces[workspace.workspace_id] = workspace
        
        return CommandResult(
            success=True,
            data={"workspace": workspace.to_dict(), "packet": packet.to_dict()},
            message=f"Workspace opened: {name}",
        )
    
    def _close(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Close a workspace."""
        from ..router import CommandResult
        
        if not command.args:
            return CommandResult(
                success=False,
                error="Workspace name or ID required",
            )
        
        identifier = command.args[0]
        
        # Find by name or ID
        workspace = self._workspaces.get(identifier)
        if workspace is None:
            workspace = next((w for w in self._workspaces.values() if w.name == identifier), None)
        
        if workspace is None:
            return CommandResult(
                success=False,
                error=f"Workspace not found: {identifier}",
            )
        
        if workspace.status == WorkspaceStatus.CLOSED:
            return CommandResult(
                success=True,
                data={"workspace": workspace.to_dict()},
                message=f"Workspace already closed: {workspace.name}",
            )
        
        workspace.status = WorkspaceStatus.CLOSED
        workspace.closed_at = time.time()
        
        # Create replay bundle packet
        packet = WorkspacePacket(
            packet_type=PacketType.REPLAY_BUNDLE,
            workspace_id=workspace.workspace_id,
            content={
                "action": "close",
                "total_packets": len(workspace.packets),
                "duration_s": workspace.closed_at - (workspace.opened_at or workspace.created_at),
            },
        )
        workspace.packets.append(packet)
        
        return CommandResult(
            success=True,
            data={"workspace": workspace.to_dict(), "packet": packet.to_dict()},
            message=f"Workspace closed: {workspace.name}",
        )
    
    def _list(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """List workspaces."""
        from ..router import CommandResult
        
        status_filter = command.kwargs.get("status")
        
        workspaces = list(self._workspaces.values())
        if status_filter:
            workspaces = [w for w in workspaces if w.status.value == status_filter]
        
        return CommandResult(
            success=True,
            data={
                "workspaces": [w.to_dict() for w in workspaces],
                "total": len(workspaces),
            },
            message=f"Listed {len(workspaces)} workspaces",
        )
    
    def _status(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Show workspace status."""
        from ..router import CommandResult
        
        if command.args:
            # Status of specific workspace
            identifier = command.args[0]
            workspace = self._workspaces.get(identifier)
            if workspace is None:
                workspace = next((w for w in self._workspaces.values() if w.name == identifier), None)
            
            if workspace is None:
                return CommandResult(
                    success=False,
                    error=f"Workspace not found: {identifier}",
                )
            
            return CommandResult(
                success=True,
                data={
                    "workspace": workspace.to_dict(),
                    "packets": [p.to_dict() for p in workspace.packets[-10:]],
                },
                message=f"Workspace status: {workspace.name}",
            )
        
        # Overall status
        open_count = sum(1 for w in self._workspaces.values() if w.status == WorkspaceStatus.OPEN)
        total_packets = sum(len(w.packets) for w in self._workspaces.values())
        
        return CommandResult(
            success=True,
            data={
                "total_workspaces": len(self._workspaces),
                "open_workspaces": open_count,
                "total_packets": total_packets,
            },
            message=f"Workspaces: {open_count}/{len(self._workspaces)} open",
        )
