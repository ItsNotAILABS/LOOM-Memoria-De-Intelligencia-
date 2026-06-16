"""
MEDINA Workspace Packets — Agentic operation units.

All agent operations are packetized for:
- Traceable execution
- Replay capability
- Arbitration support
- Integration contracts
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional


class PacketState(Enum):
    """Lifecycle states for work packets."""
    
    CREATED = "created"         # Packet initialized
    QUEUED = "queued"           # Awaiting execution
    IN_PROGRESS = "in_progress" # Currently executing
    COMPLETED = "completed"     # Successfully finished
    FAILED = "failed"           # Execution failed
    CANCELLED = "cancelled"     # Explicitly cancelled
    ARBITRATING = "arbitrating" # In dispute resolution


class PacketPriority(Enum):
    """Priority levels for packet execution."""
    
    CRITICAL = 0
    HIGH = 1
    NORMAL = 2
    LOW = 3
    BACKGROUND = 4


@dataclass
class TaskPacket:
    """
    Task constitution packet — defines the work to be done.
    
    Contains:
    - Task specification
    - Required capabilities
    - Constraints and boundaries
    - Expected outputs
    """
    
    packet_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    
    # Task definition
    title: str = ""
    description: str = ""
    task_type: str = ""
    
    # Requirements
    required_capabilities: List[str] = field(default_factory=list)
    required_permissions: List[str] = field(default_factory=list)
    
    # Constraints
    max_duration_seconds: int = 300
    max_retries: int = 3
    
    # Input/Output
    input_data: Dict[str, Any] = field(default_factory=dict)
    expected_output_schema: Dict[str, Any] = field(default_factory=dict)
    
    # Metadata
    priority: PacketPriority = PacketPriority.NORMAL
    created_at: float = field(default_factory=time.time)
    created_by: str = "system"
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "packet_id": self.packet_id,
            "title": self.title,
            "description": self.description,
            "task_type": self.task_type,
            "required_capabilities": self.required_capabilities,
            "required_permissions": self.required_permissions,
            "max_duration_seconds": self.max_duration_seconds,
            "max_retries": self.max_retries,
            "priority": self.priority.name,
            "created_at": self.created_at,
            "created_by": self.created_by,
        }


@dataclass
class WorkPacket:
    """
    Agent work packet — execution unit for a task.
    
    Tracks:
    - Execution state
    - Progress
    - Results
    - Evidence
    """
    
    packet_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    task_packet_id: str = ""  # Reference to TaskPacket
    
    # Execution
    state: PacketState = PacketState.CREATED
    assigned_agent: str = ""
    assigned_model: str = ""
    
    # Progress
    progress_percent: float = 0.0
    current_step: str = ""
    steps_completed: int = 0
    steps_total: int = 0
    
    # Results
    output_data: Dict[str, Any] = field(default_factory=dict)
    error: Optional[str] = None
    
    # Timing
    queued_at: Optional[float] = None
    started_at: Optional[float] = None
    completed_at: Optional[float] = None
    
    # Retry tracking
    attempt_number: int = 1
    previous_attempts: List[Dict[str, Any]] = field(default_factory=list)
    
    # Evidence
    execution_log: List[Dict[str, Any]] = field(default_factory=list)
    
    def log_step(self, step: str, details: Optional[Dict[str, Any]] = None) -> None:
        """Log an execution step."""
        self.execution_log.append({
            "timestamp": time.time(),
            "step": step,
            "details": details or {},
        })
        self.current_step = step
        self.steps_completed += 1
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "packet_id": self.packet_id,
            "task_packet_id": self.task_packet_id,
            "state": self.state.value,
            "assigned_agent": self.assigned_agent,
            "assigned_model": self.assigned_model,
            "progress_percent": self.progress_percent,
            "current_step": self.current_step,
            "steps_completed": self.steps_completed,
            "steps_total": self.steps_total,
            "error": self.error,
            "attempt_number": self.attempt_number,
            "queued_at": self.queued_at,
            "started_at": self.started_at,
            "completed_at": self.completed_at,
            "execution_log_size": len(self.execution_log),
        }


@dataclass
class ArbitrationRecord:
    """
    Arbitration record — dispute resolution for agent conflicts.
    
    When agents disagree or conflicts arise, arbitration:
    - Records the dispute
    - Collects evidence
    - Applies resolution policy
    - Documents outcome
    """
    
    record_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    
    # Dispute
    dispute_type: str = ""  # conflict, error, timeout, etc.
    description: str = ""
    
    # Parties
    packets_involved: List[str] = field(default_factory=list)
    agents_involved: List[str] = field(default_factory=list)
    
    # Evidence
    evidence: List[Dict[str, Any]] = field(default_factory=list)
    
    # Resolution
    resolution_policy: str = ""
    resolution_outcome: str = ""
    resolved_by: str = ""
    
    # Timestamps
    created_at: float = field(default_factory=time.time)
    resolved_at: Optional[float] = None
    
    def add_evidence(self, evidence_type: str, data: Dict[str, Any]) -> None:
        """Add evidence to the arbitration record."""
        self.evidence.append({
            "type": evidence_type,
            "data": data,
            "timestamp": time.time(),
        })
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "record_id": self.record_id,
            "dispute_type": self.dispute_type,
            "description": self.description,
            "packets_involved": self.packets_involved,
            "agents_involved": self.agents_involved,
            "evidence_count": len(self.evidence),
            "resolution_policy": self.resolution_policy,
            "resolution_outcome": self.resolution_outcome,
            "resolved_by": self.resolved_by,
            "created_at": self.created_at,
            "resolved_at": self.resolved_at,
        }


@dataclass
class IntegrationContract:
    """
    Integration contract — agreement for system integration.
    
    Defines:
    - Integration parties
    - Data exchange format
    - Sync requirements
    - Error handling
    """
    
    contract_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    
    # Parties
    provider: str = ""
    consumer: str = ""
    
    # Contract terms
    name: str = ""
    version: str = "1.0.0"
    description: str = ""
    
    # Data specification
    data_schema: Dict[str, Any] = field(default_factory=dict)
    sync_frequency: str = "on_demand"  # on_demand, periodic, realtime
    
    # Error handling
    retry_policy: Dict[str, Any] = field(default_factory=dict)
    fallback_behavior: str = ""
    
    # Status
    active: bool = True
    created_at: float = field(default_factory=time.time)
    expires_at: Optional[float] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "contract_id": self.contract_id,
            "provider": self.provider,
            "consumer": self.consumer,
            "name": self.name,
            "version": self.version,
            "sync_frequency": self.sync_frequency,
            "active": self.active,
            "created_at": self.created_at,
            "expires_at": self.expires_at,
        }


@dataclass
class ReplayBundle:
    """
    Replay bundle — package for replaying execution history.
    
    Contains everything needed to:
    - Understand what happened
    - Reproduce the execution
    - Audit decisions
    """
    
    bundle_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    
    # Scope
    from_beat: int = 0
    to_beat: int = 0
    
    # Content
    task_packets: List[TaskPacket] = field(default_factory=list)
    work_packets: List[WorkPacket] = field(default_factory=list)
    arbitration_records: List[ArbitrationRecord] = field(default_factory=list)
    
    # Metadata
    created_at: float = field(default_factory=time.time)
    description: str = ""
    
    # Checksums for integrity
    content_hash: str = ""
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "bundle_id": self.bundle_id,
            "from_beat": self.from_beat,
            "to_beat": self.to_beat,
            "task_packet_count": len(self.task_packets),
            "work_packet_count": len(self.work_packets),
            "arbitration_record_count": len(self.arbitration_records),
            "created_at": self.created_at,
            "description": self.description,
            "content_hash": self.content_hash,
        }


class WorkspaceManager:
    """
    MEDINA Workspace Manager — Orchestrates packetized operations.
    
    Manages:
    - Task and work packet lifecycle
    - Agent assignment
    - Arbitration
    - Replay bundles
    """
    
    def __init__(self) -> None:
        self._task_packets: Dict[str, TaskPacket] = {}
        self._work_packets: Dict[str, WorkPacket] = {}
        self._arbitration_records: Dict[str, ArbitrationRecord] = {}
        self._integration_contracts: Dict[str, IntegrationContract] = {}
        self._replay_bundles: Dict[str, ReplayBundle] = {}
    
    # ------------------------------------------------------------------ #
    # Task Packets                                                          #
    # ------------------------------------------------------------------ #
    
    def create_task(
        self,
        title: str,
        description: str,
        task_type: str,
        input_data: Optional[Dict[str, Any]] = None,
        priority: PacketPriority = PacketPriority.NORMAL,
        created_by: str = "system",
    ) -> TaskPacket:
        """Create a new task packet."""
        task = TaskPacket(
            title=title,
            description=description,
            task_type=task_type,
            input_data=input_data or {},
            priority=priority,
            created_by=created_by,
        )
        self._task_packets[task.packet_id] = task
        return task
    
    def get_task(self, packet_id: str) -> Optional[TaskPacket]:
        """Get a task packet by ID."""
        return self._task_packets.get(packet_id)
    
    # ------------------------------------------------------------------ #
    # Work Packets                                                          #
    # ------------------------------------------------------------------ #
    
    def create_work(self, task_packet_id: str) -> Optional[WorkPacket]:
        """Create a work packet for a task."""
        if task_packet_id not in self._task_packets:
            return None
        
        work = WorkPacket(task_packet_id=task_packet_id)
        self._work_packets[work.packet_id] = work
        return work
    
    def assign_work(
        self,
        work_packet_id: str,
        agent: str,
        model: str = "",
    ) -> bool:
        """Assign a work packet to an agent."""
        if work_packet_id not in self._work_packets:
            return False
        
        work = self._work_packets[work_packet_id]
        work.assigned_agent = agent
        work.assigned_model = model
        work.state = PacketState.QUEUED
        work.queued_at = time.time()
        return True
    
    def start_work(self, work_packet_id: str) -> bool:
        """Mark work as started."""
        if work_packet_id not in self._work_packets:
            return False
        
        work = self._work_packets[work_packet_id]
        work.state = PacketState.IN_PROGRESS
        work.started_at = time.time()
        work.log_step("started")
        return True
    
    def complete_work(
        self,
        work_packet_id: str,
        output_data: Dict[str, Any],
    ) -> bool:
        """Mark work as completed."""
        if work_packet_id not in self._work_packets:
            return False
        
        work = self._work_packets[work_packet_id]
        work.state = PacketState.COMPLETED
        work.completed_at = time.time()
        work.output_data = output_data
        work.progress_percent = 100.0
        work.log_step("completed", {"output_keys": list(output_data.keys())})
        return True
    
    def fail_work(
        self,
        work_packet_id: str,
        error: str,
    ) -> bool:
        """Mark work as failed."""
        if work_packet_id not in self._work_packets:
            return False
        
        work = self._work_packets[work_packet_id]
        work.state = PacketState.FAILED
        work.completed_at = time.time()
        work.error = error
        work.log_step("failed", {"error": error})
        return True
    
    def get_work(self, packet_id: str) -> Optional[WorkPacket]:
        """Get a work packet by ID."""
        return self._work_packets.get(packet_id)
    
    # ------------------------------------------------------------------ #
    # Arbitration                                                           #
    # ------------------------------------------------------------------ #
    
    def create_arbitration(
        self,
        dispute_type: str,
        description: str,
        packets_involved: List[str],
        agents_involved: List[str],
    ) -> ArbitrationRecord:
        """Create an arbitration record."""
        record = ArbitrationRecord(
            dispute_type=dispute_type,
            description=description,
            packets_involved=packets_involved,
            agents_involved=agents_involved,
        )
        self._arbitration_records[record.record_id] = record
        
        # Mark involved packets as arbitrating
        for pid in packets_involved:
            if pid in self._work_packets:
                self._work_packets[pid].state = PacketState.ARBITRATING
        
        return record
    
    def resolve_arbitration(
        self,
        record_id: str,
        policy: str,
        outcome: str,
        resolved_by: str,
    ) -> bool:
        """Resolve an arbitration."""
        if record_id not in self._arbitration_records:
            return False
        
        record = self._arbitration_records[record_id]
        record.resolution_policy = policy
        record.resolution_outcome = outcome
        record.resolved_by = resolved_by
        record.resolved_at = time.time()
        return True
    
    # ------------------------------------------------------------------ #
    # Replay                                                                #
    # ------------------------------------------------------------------ #
    
    def create_replay_bundle(
        self,
        from_beat: int,
        to_beat: int,
        description: str = "",
    ) -> ReplayBundle:
        """Create a replay bundle for a beat range."""
        # Collect relevant packets
        task_packets = list(self._task_packets.values())
        work_packets = list(self._work_packets.values())
        arbitration_records = list(self._arbitration_records.values())
        
        bundle = ReplayBundle(
            from_beat=from_beat,
            to_beat=to_beat,
            task_packets=task_packets,
            work_packets=work_packets,
            arbitration_records=arbitration_records,
            description=description,
        )
        self._replay_bundles[bundle.bundle_id] = bundle
        return bundle
    
    def get_replay_bundle(self, bundle_id: str) -> Optional[ReplayBundle]:
        """Get a replay bundle by ID."""
        return self._replay_bundles.get(bundle_id)
    
    # ------------------------------------------------------------------ #
    # Status                                                                #
    # ------------------------------------------------------------------ #
    
    def status(self) -> Dict[str, Any]:
        """Workspace status."""
        work_by_state: Dict[str, int] = {}
        for work in self._work_packets.values():
            work_by_state[work.state.value] = work_by_state.get(work.state.value, 0) + 1
        
        return {
            "task_packets": len(self._task_packets),
            "work_packets": len(self._work_packets),
            "work_by_state": work_by_state,
            "arbitration_records": len(self._arbitration_records),
            "integration_contracts": len(self._integration_contracts),
            "replay_bundles": len(self._replay_bundles),
        }
