"""
TERMINAL INTEGRATION ARCHITECTURE — Unified Terminal Hub
=========================================================
Protocol: PROT-318 through PROT-322
Frequency: φ⁷ = 29.03 Hz (Terminal Resonance)

"We need to tie all the terminals inside as well that kind of help with everything.
 Each terminal is a window into the organism. Each command flows through the
 sovereign substrate."

Terminal Categories:
- TERMINALIS SOVEREIGNUS: Sovereign command terminal
- TERMINALIS OPERATIONIS: Operational terminal
- TERMINALIS MEMORIAE: Memory interaction terminal
- TERMINALIS EVOLUTIONIS: Evolution monitoring terminal
- TERMINALIS EXTERNUS: External integration terminal

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
All Rights Reserved. ISIL-1.0 License.
"""

from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any, Callable
from enum import Enum
import time
import hashlib
import json
import subprocess
import os

# φ-Constants
PHI = 1.6180339887498948482
PHI_INV = 1 / PHI
PHI_7 = PHI ** 7   # 29.03 Hz - Terminal frequency
PHI_8 = PHI ** 8   # 46.98 Hz - Advanced terminal
SCHUMANN = 7.83    # Hz - Earth resonance


class TerminalType(Enum):
    """Types of organism terminals."""
    TERMINALIS_SOVEREIGNUS = "sovereign"     # Founder terminal
    TERMINALIS_OPERATIONIS = "operations"    # Ops terminal
    TERMINALIS_MEMORIAE = "memory"           # Memory terminal
    TERMINALIS_EVOLUTIONIS = "evolution"     # Evolution terminal
    TERMINALIS_EXTERNUS = "external"         # External integration
    TERMINALIS_DEBUG = "debug"               # Debug terminal
    TERMINALIS_SHELL = "shell"               # Shell integration


class TerminalState(Enum):
    """Terminal connection states."""
    DISCONNECTED = 0
    CONNECTING = 1
    CONNECTED = 2
    AUTHENTICATED = 3
    SOVEREIGN_MODE = 4  # Full sovereign access
    SUSPENDED = 5
    ERROR = 6


class CommandType(Enum):
    """Types of terminal commands."""
    QUERY = "query"           # Read-only query
    MUTATION = "mutation"     # State change
    SOVEREIGN = "sovereign"   # Sovereign command
    SYSTEM = "system"         # System command
    SHELL = "shell"           # Shell passthrough
    PIPELINE = "pipeline"     # Multi-command pipeline


@dataclass
class TerminalCommand:
    """A terminal command instance."""
    command_id: str
    command_type: CommandType
    command_text: str
    terminal_id: str
    user_id: str
    
    # Execution
    created_at: float = field(default_factory=time.time)
    executed_at: Optional[float] = None
    completed_at: Optional[float] = None
    
    # Result
    success: Optional[bool] = None
    result: Optional[Any] = None
    error: Optional[str] = None
    
    # Audit
    hash_proof: Optional[str] = None
    
    def execute(self) -> bool:
        """Mark command as executed."""
        self.executed_at = time.time()
        return True
    
    def complete(self, success: bool, result: Any = None, 
                error: str = None) -> None:
        """Complete command execution."""
        self.completed_at = time.time()
        self.success = success
        self.result = result
        self.error = error
        
        # Generate hash proof of execution
        proof_data = f"{self.command_id}:{self.command_text}:{self.completed_at}:{success}"
        self.hash_proof = hashlib.sha256(proof_data.encode()).hexdigest()
    
    def to_json(self) -> Dict[str, Any]:
        """Export command to JSON."""
        return {
            "command_id": self.command_id,
            "type": self.command_type.value,
            "text": self.command_text,
            "terminal_id": self.terminal_id,
            "user_id": self.user_id,
            "timestamps": {
                "created": self.created_at,
                "executed": self.executed_at,
                "completed": self.completed_at
            },
            "success": self.success,
            "result": self.result,
            "error": self.error,
            "hash_proof": self.hash_proof
        }


@dataclass
class TerminalSession:
    """A terminal session."""
    session_id: str
    terminal_id: str
    user_id: str
    terminal_type: TerminalType
    
    # State
    state: TerminalState = TerminalState.DISCONNECTED
    created_at: float = field(default_factory=time.time)
    last_activity: float = field(default_factory=time.time)
    
    # Command history
    commands: List[TerminalCommand] = field(default_factory=list)
    
    # Access control
    access_level: int = 0
    permissions: List[str] = field(default_factory=list)
    
    # Environment
    environment: Dict[str, str] = field(default_factory=dict)
    working_directory: str = "/"
    
    def connect(self) -> bool:
        """Connect the terminal session."""
        self.state = TerminalState.CONNECTING
        self.last_activity = time.time()
        return True
    
    def authenticate(self, access_level: int, 
                    permissions: List[str]) -> bool:
        """Authenticate the session."""
        if self.state == TerminalState.CONNECTING:
            self.state = TerminalState.AUTHENTICATED
            self.access_level = access_level
            self.permissions = permissions
            self.last_activity = time.time()
            return True
        return False
    
    def elevate_to_sovereign(self) -> bool:
        """Elevate to sovereign mode."""
        if self.access_level >= 9:
            self.state = TerminalState.SOVEREIGN_MODE
            self.last_activity = time.time()
            return True
        return False
    
    def execute_command(self, command: TerminalCommand) -> bool:
        """Execute a command in this session."""
        self.commands.append(command)
        self.last_activity = time.time()
        return command.execute()
    
    def disconnect(self) -> None:
        """Disconnect the session."""
        self.state = TerminalState.DISCONNECTED
        self.last_activity = time.time()
    
    def to_json(self) -> Dict[str, Any]:
        """Export session to JSON."""
        return {
            "session_id": self.session_id,
            "terminal_id": self.terminal_id,
            "user_id": self.user_id,
            "type": self.terminal_type.value,
            "state": self.state.name,
            "access_level": self.access_level,
            "permissions": self.permissions,
            "created_at": self.created_at,
            "last_activity": self.last_activity,
            "command_count": len(self.commands),
            "environment": self.environment,
            "working_directory": self.working_directory
        }


@dataclass
class Terminal:
    """A terminal instance."""
    terminal_id: str
    terminal_type: TerminalType
    name: str
    description: str
    protocol: str  # PROT-XXX
    
    # Configuration
    frequency_hz: float = PHI_7
    max_sessions: int = 10
    timeout_seconds: int = 3600
    
    # State
    created_at: float = field(default_factory=time.time)
    sessions: Dict[str, TerminalSession] = field(default_factory=dict)
    
    # Command handlers
    command_handlers: Dict[str, Callable] = field(default_factory=dict)
    
    def create_session(self, user_id: str) -> Optional[TerminalSession]:
        """Create a new terminal session."""
        if len(self.sessions) >= self.max_sessions:
            return None
        
        session_id = f"session-{self.terminal_id}-{int(time.time() * 1000)}"
        session = TerminalSession(
            session_id=session_id,
            terminal_id=self.terminal_id,
            user_id=user_id,
            terminal_type=self.terminal_type
        )
        
        self.sessions[session_id] = session
        return session
    
    def get_session(self, session_id: str) -> Optional[TerminalSession]:
        """Get a session by ID."""
        return self.sessions.get(session_id)
    
    def close_session(self, session_id: str) -> bool:
        """Close a terminal session."""
        if session_id in self.sessions:
            self.sessions[session_id].disconnect()
            del self.sessions[session_id]
            return True
        return False
    
    def register_handler(self, command_prefix: str, 
                        handler: Callable) -> None:
        """Register a command handler."""
        self.command_handlers[command_prefix] = handler
    
    def get_active_sessions(self) -> List[TerminalSession]:
        """Get all active sessions."""
        return [s for s in self.sessions.values() 
                if s.state != TerminalState.DISCONNECTED]
    
    def to_json(self) -> Dict[str, Any]:
        """Export terminal to JSON."""
        return {
            "terminal_id": self.terminal_id,
            "type": self.terminal_type.value,
            "name": self.name,
            "description": self.description,
            "protocol": self.protocol,
            "frequency_hz": self.frequency_hz,
            "max_sessions": self.max_sessions,
            "timeout_seconds": self.timeout_seconds,
            "created_at": self.created_at,
            "session_count": len(self.sessions),
            "active_sessions": len(self.get_active_sessions()),
            "registered_handlers": list(self.command_handlers.keys())
        }


class TerminalRegistry:
    """
    TERMINAL REGISTRY — PROT-318
    
    Registry of all organism terminals for unified access.
    """
    
    def __init__(self):
        self.terminals: Dict[str, Terminal] = {}
        self.frequency_hz = PHI_7
        self.created_at = time.time()
        
        # Initialize default terminals
        self._init_default_terminals()
    
    def _init_default_terminals(self) -> None:
        """Initialize the default organism terminals."""
        
        # 1. Sovereign Terminal (PROT-318)
        sovereign = Terminal(
            terminal_id="terminalis-sovereignus-001",
            terminal_type=TerminalType.TERMINALIS_SOVEREIGNUS,
            name="TERMINALIS SOVEREIGNUS",
            description="The sovereign command terminal for founder access",
            protocol="PROT-318",
            frequency_hz=PHI_8,
            max_sessions=1  # Only one sovereign session
        )
        self.terminals["terminalis-sovereignus-001"] = sovereign
        
        # 2. Operations Terminal (PROT-319)
        operations = Terminal(
            terminal_id="terminalis-operationis-001",
            terminal_type=TerminalType.TERMINALIS_OPERATIONIS,
            name="TERMINALIS OPERATIONIS",
            description="Operations terminal for worker management",
            protocol="PROT-319",
            max_sessions=10
        )
        self.terminals["terminalis-operationis-001"] = operations
        
        # 3. Memory Terminal (PROT-320)
        memory = Terminal(
            terminal_id="terminalis-memoriae-001",
            terminal_type=TerminalType.TERMINALIS_MEMORIAE,
            name="TERMINALIS MEMORIAE",
            description="Memory interaction terminal",
            protocol="PROT-320",
            max_sessions=5
        )
        self.terminals["terminalis-memoriae-001"] = memory
        
        # 4. Evolution Terminal (PROT-321)
        evolution = Terminal(
            terminal_id="terminalis-evolutionis-001",
            terminal_type=TerminalType.TERMINALIS_EVOLUTIONIS,
            name="TERMINALIS EVOLUTIONIS",
            description="Evolution monitoring terminal",
            protocol="PROT-321",
            max_sessions=3
        )
        self.terminals["terminalis-evolutionis-001"] = evolution
        
        # 5. External Integration Terminal (PROT-322)
        external = Terminal(
            terminal_id="terminalis-externus-001",
            terminal_type=TerminalType.TERMINALIS_EXTERNUS,
            name="TERMINALIS EXTERNUS",
            description="External integration terminal",
            protocol="PROT-322",
            max_sessions=20
        )
        self.terminals["terminalis-externus-001"] = external
    
    def register_terminal(self, terminal: Terminal) -> None:
        """Register a terminal in the registry."""
        self.terminals[terminal.terminal_id] = terminal
    
    def get_terminal(self, terminal_id: str) -> Optional[Terminal]:
        """Get a terminal by ID."""
        return self.terminals.get(terminal_id)
    
    def get_terminals_by_type(self, terminal_type: TerminalType) -> List[Terminal]:
        """Get all terminals of a specific type."""
        return [t for t in self.terminals.values() 
                if t.terminal_type == terminal_type]
    
    def list_terminals(self) -> List[Terminal]:
        """List all registered terminals."""
        return list(self.terminals.values())
    
    def get_all_sessions(self) -> Dict[str, List[TerminalSession]]:
        """Get all sessions across all terminals."""
        return {
            tid: list(t.sessions.values()) 
            for tid, t in self.terminals.items()
        }
    
    def to_json(self) -> Dict[str, Any]:
        """Export registry to JSON."""
        total_sessions = sum(len(t.sessions) for t in self.terminals.values())
        active_sessions = sum(
            len(t.get_active_sessions()) for t in self.terminals.values()
        )
        
        return {
            "engine": "TerminalRegistry",
            "protocol": "PROT-318",
            "frequency_hz": self.frequency_hz,
            "terminal_count": len(self.terminals),
            "total_sessions": total_sessions,
            "active_sessions": active_sessions,
            "terminals": [t.to_json() for t in self.terminals.values()]
        }


class TerminalBridge:
    """
    TERMINAL BRIDGE — PROT-323
    
    Bridge between terminals and the organism substrate.
    "The bridge becomes a highway."
    """
    
    def __init__(self, registry: TerminalRegistry):
        self.registry = registry
        self.command_queue: List[TerminalCommand] = []
        self.command_history: List[TerminalCommand] = []
        self.frequency_hz = PHI_8
        self.created_at = time.time()
        
        # Pipeline handlers
        self.pipeline_handlers: Dict[str, Callable] = {}
    
    def submit_command(self, terminal_id: str, session_id: str,
                      command_type: CommandType, command_text: str,
                      user_id: str) -> Optional[TerminalCommand]:
        """Submit a command through the bridge."""
        terminal = self.registry.get_terminal(terminal_id)
        if not terminal:
            return None
        
        session = terminal.get_session(session_id)
        if not session:
            return None
        
        # Create command
        command = TerminalCommand(
            command_id=f"cmd-{int(time.time() * 1000)}",
            command_type=command_type,
            command_text=command_text,
            terminal_id=terminal_id,
            user_id=user_id
        )
        
        # Queue command
        self.command_queue.append(command)
        
        # Execute in session
        session.execute_command(command)
        
        return command
    
    def process_queue(self) -> List[TerminalCommand]:
        """Process queued commands."""
        processed = []
        
        while self.command_queue:
            command = self.command_queue.pop(0)
            
            try:
                # Execute based on command type
                if command.command_type == CommandType.QUERY:
                    result = self._execute_query(command)
                elif command.command_type == CommandType.MUTATION:
                    result = self._execute_mutation(command)
                elif command.command_type == CommandType.SOVEREIGN:
                    result = self._execute_sovereign(command)
                elif command.command_type == CommandType.SHELL:
                    result = self._execute_shell(command)
                elif command.command_type == CommandType.PIPELINE:
                    result = self._execute_pipeline(command)
                else:
                    result = {"error": "Unknown command type"}
                
                command.complete(True, result)
                
            except Exception as e:
                command.complete(False, error=str(e))
            
            processed.append(command)
            self.command_history.append(command)
        
        return processed
    
    def _execute_query(self, command: TerminalCommand) -> Dict[str, Any]:
        """Execute a query command."""
        return {
            "type": "query",
            "command": command.command_text,
            "timestamp": time.time()
        }
    
    def _execute_mutation(self, command: TerminalCommand) -> Dict[str, Any]:
        """Execute a mutation command."""
        return {
            "type": "mutation",
            "command": command.command_text,
            "applied": True,
            "timestamp": time.time()
        }
    
    def _execute_sovereign(self, command: TerminalCommand) -> Dict[str, Any]:
        """Execute a sovereign command."""
        # Verify sovereign access
        terminal = self.registry.get_terminal(command.terminal_id)
        if terminal and terminal.terminal_type == TerminalType.TERMINALIS_SOVEREIGNUS:
            return {
                "type": "sovereign",
                "command": command.command_text,
                "executed": True,
                "sovereign_verified": True,
                "timestamp": time.time()
            }
        return {"error": "Sovereign access required"}
    
    def _execute_shell(self, command: TerminalCommand) -> Dict[str, Any]:
        """Execute a shell command (sandboxed)."""
        # In production, this would be sandboxed
        return {
            "type": "shell",
            "command": command.command_text,
            "note": "Shell execution sandboxed",
            "timestamp": time.time()
        }
    
    def _execute_pipeline(self, command: TerminalCommand) -> Dict[str, Any]:
        """Execute a pipeline command."""
        if command.command_text in self.pipeline_handlers:
            handler = self.pipeline_handlers[command.command_text]
            return handler()
        return {"error": "Pipeline not found"}
    
    def register_pipeline(self, name: str, handler: Callable) -> None:
        """Register a pipeline handler."""
        self.pipeline_handlers[name] = handler
    
    def get_command_history(self, 
                           terminal_id: Optional[str] = None,
                           limit: int = 100) -> List[TerminalCommand]:
        """Get command history."""
        history = self.command_history
        
        if terminal_id:
            history = [c for c in history if c.terminal_id == terminal_id]
        
        return history[-limit:]
    
    def to_json(self) -> Dict[str, Any]:
        """Export bridge state to JSON."""
        return {
            "engine": "TerminalBridge",
            "protocol": "PROT-323",
            "frequency_hz": self.frequency_hz,
            "queue_size": len(self.command_queue),
            "history_size": len(self.command_history),
            "registered_pipelines": list(self.pipeline_handlers.keys()),
            "uptime_seconds": time.time() - self.created_at
        }


# Export classes
__all__ = [
    "TerminalType",
    "TerminalState",
    "CommandType",
    "TerminalCommand",
    "TerminalSession",
    "Terminal",
    "TerminalRegistry",
    "TerminalBridge",
    "PHI",
    "PHI_7",
    "PHI_8"
]
