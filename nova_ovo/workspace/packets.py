"""
Work Packets — Packetized Operations
====================================
Packetized operation units for agentic workspace fabric.

Types:
- Task constitution packet
- Agent work packet
- Arbitration record
- Replay bundle
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional


class PacketType(str, Enum):
    """Types of work packets."""
    TASK_CONSTITUTION = "task_constitution"
    AGENT_WORK = "agent_work"
    ARBITRATION = "arbitration"
    REPLAY_BUNDLE = "replay_bundle"


class PacketStatus(str, Enum):
    """Packet lifecycle status."""
    DRAFT = "draft"
    ACTIVE = "active"
    COMPLETED = "completed"
    FAILED = "failed"
    ARCHIVED = "archived"


@dataclass
class TaskConstitution:
    """
    Task constitution defining work parameters.
    
    Every task has a constitution that specifies:
    - Objectives and constraints
    - Authority scope
    - Resource budget
    - Success criteria
    """
    
    constitution_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    task_name: str = ""
    objectives: List[str] = field(default_factory=list)
    constraints: List[str] = field(default_factory=list)
    authority_scope: List[str] = field(default_factory=list)
    resource_budget: Dict[str, Any] = field(default_factory=dict)
    success_criteria: List[str] = field(default_factory=list)
    doctrine_requirements: List[str] = field(default_factory=list)
    created_at: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "constitution_id": self.constitution_id,
            "task_name": self.task_name,
            "objectives": self.objectives,
            "constraints": self.constraints,
            "authority_scope": self.authority_scope,
            "resource_budget": self.resource_budget,
            "success_criteria": self.success_criteria,
            "doctrine_requirements": self.doctrine_requirements,
            "created_at": self.created_at,
        }


@dataclass
class WorkPacket:
    """
    A packetized unit of work.
    
    Work packets are the atomic units of execution
    in the agentic workspace fabric.
    """
    
    packet_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    packet_type: PacketType = PacketType.AGENT_WORK
    status: PacketStatus = PacketStatus.DRAFT
    
    # Constitution
    constitution: Optional[TaskConstitution] = None
    
    # Work content
    input_data: Dict[str, Any] = field(default_factory=dict)
    output_data: Dict[str, Any] = field(default_factory=dict)
    
    # Execution context
    workspace_id: str = ""
    agent_id: str = ""
    beat_started: int = 0
    beat_completed: Optional[int] = None
    
    # Lineage
    parent_packet_id: Optional[str] = None
    child_packet_ids: List[str] = field(default_factory=list)
    
    # Evidence
    evidence: List[Dict[str, Any]] = field(default_factory=list)
    
    # Timestamps
    created_at: float = field(default_factory=time.time)
    started_at: Optional[float] = None
    completed_at: Optional[float] = None
    
    def start(self, agent_id: str, beat: int) -> None:
        """Start packet execution."""
        self.status = PacketStatus.ACTIVE
        self.agent_id = agent_id
        self.beat_started = beat
        self.started_at = time.time()
    
    def complete(self, output: Dict[str, Any], beat: int) -> None:
        """Complete packet execution."""
        self.status = PacketStatus.COMPLETED
        self.output_data = output
        self.beat_completed = beat
        self.completed_at = time.time()
    
    def fail(self, error: str, beat: int) -> None:
        """Mark packet as failed."""
        self.status = PacketStatus.FAILED
        self.output_data = {"error": error}
        self.beat_completed = beat
        self.completed_at = time.time()
    
    def add_evidence(self, evidence_type: str, data: Dict[str, Any]) -> None:
        """Add evidence to the packet."""
        self.evidence.append({
            "evidence_id": str(uuid.uuid4()),
            "type": evidence_type,
            "data": data,
            "timestamp": time.time(),
        })
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "packet_id": self.packet_id,
            "packet_type": self.packet_type.value,
            "status": self.status.value,
            "constitution": self.constitution.to_dict() if self.constitution else None,
            "workspace_id": self.workspace_id,
            "agent_id": self.agent_id,
            "beat_started": self.beat_started,
            "beat_completed": self.beat_completed,
            "parent_packet_id": self.parent_packet_id,
            "child_count": len(self.child_packet_ids),
            "evidence_count": len(self.evidence),
            "created_at": self.created_at,
            "started_at": self.started_at,
            "completed_at": self.completed_at,
        }


@dataclass
class ArbitrationRecord:
    """
    Record of arbitration between agents or packets.
    """
    
    record_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    dispute_type: str = ""
    parties: List[str] = field(default_factory=list)
    packet_ids: List[str] = field(default_factory=list)
    resolution: str = ""
    arbiter: str = "system"
    evidence: List[Dict[str, Any]] = field(default_factory=list)
    created_at: float = field(default_factory=time.time)
    resolved_at: Optional[float] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "record_id": self.record_id,
            "dispute_type": self.dispute_type,
            "parties": self.parties,
            "packet_ids": self.packet_ids,
            "resolution": self.resolution,
            "arbiter": self.arbiter,
            "evidence_count": len(self.evidence),
            "created_at": self.created_at,
            "resolved_at": self.resolved_at,
        }


@dataclass
class ReplayBundle:
    """
    Bundle of packets for replay/audit.
    """
    
    bundle_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    packets: List[WorkPacket] = field(default_factory=list)
    arbitrations: List[ArbitrationRecord] = field(default_factory=list)
    metadata: Dict[str, Any] = field(default_factory=dict)
    created_at: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "bundle_id": self.bundle_id,
            "name": self.name,
            "packet_count": len(self.packets),
            "arbitration_count": len(self.arbitrations),
            "metadata": self.metadata,
            "created_at": self.created_at,
        }
