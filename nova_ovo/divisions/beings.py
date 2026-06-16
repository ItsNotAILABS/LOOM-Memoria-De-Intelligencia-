"""
Sovereign Beings — Base Class for All Division Organisms
=========================================================
Every division contains sovereign beings that operate autonomously
within their domain of responsibility.

Beings have:
- Identity and lineage
- Capabilities and permissions
- Lifecycle state
- Resonance state (for Tier-11 coupling)
- Kernel compression (symbolic intelligence)
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional


class BeingType(str, Enum):
    """Types of sovereign beings."""
    # Doctrine beings
    LAW_KEEPER = "law_keeper"
    CONSTITUTION_GUARDIAN = "constitution_guardian"
    TRUTH_VALIDATOR = "truth_validator"
    
    # Procedure beings
    WORKFLOW_ORCHESTRATOR = "workflow_orchestrator"
    PROTOCOL_ENFORCER = "protocol_enforcer"
    PROCESS_MANAGER = "process_manager"
    
    # Engine beings
    COMPUTE_CORE = "compute_core"
    HEART_OSCILLATOR = "heart_oscillator"
    BRAIN_PROCESSOR = "brain_processor"
    
    # Memory beings
    TEMPLE_NAVIGATOR = "temple_navigator"
    MEMORY_CONSOLIDATOR = "memory_consolidator"
    LINEAGE_TRACKER = "lineage_tracker"
    
    # Interface beings
    PROJECTION_BOUNDARY = "projection_boundary"
    CHAT_CONTROLLER = "chat_controller"
    SURFACE_RENDERER = "surface_renderer"
    
    # Governance beings
    PROPOSAL_PROCESSOR = "proposal_processor"
    APPROVAL_AUTHORITY = "approval_authority"
    GATE_ENFORCER = "gate_enforcer"
    
    # Workforce beings
    DOCUMENT_ORGANISM = "document_organism"
    AGENT_COORDINATOR = "agent_coordinator"
    TASK_EXECUTOR = "task_executor"


class BeingStatus(str, Enum):
    """Lifecycle status of a being."""
    INITIALIZING = "initializing"
    ACTIVE = "active"
    SUSPENDED = "suspended"
    DORMANT = "dormant"
    TRANSCENDING = "transcending"
    TERMINATED = "terminated"


@dataclass
class BeingCapability:
    """A capability possessed by a being."""
    
    capability_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    description: str = ""
    
    # Permission level required
    permission_level: str = "internal"  # "internal", "external", "founder", "builder"
    
    # Rate limits
    max_invocations_per_beat: int = 100
    cooldown_beats: int = 0
    
    # Current usage
    invocations_this_beat: int = 0
    last_invoked_beat: int = 0
    
    def can_invoke(self, current_beat: int) -> bool:
        """Check if capability can be invoked."""
        if current_beat > self.last_invoked_beat:
            self.invocations_this_beat = 0
        
        if self.cooldown_beats > 0:
            if current_beat - self.last_invoked_beat < self.cooldown_beats:
                return False
        
        return self.invocations_this_beat < self.max_invocations_per_beat
    
    def invoke(self, current_beat: int) -> bool:
        """Invoke the capability."""
        if not self.can_invoke(current_beat):
            return False
        
        if current_beat > self.last_invoked_beat:
            self.invocations_this_beat = 0
        
        self.invocations_this_beat += 1
        self.last_invoked_beat = current_beat
        return True
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "capability_id": self.capability_id,
            "name": self.name,
            "description": self.description,
            "permission_level": self.permission_level,
            "max_invocations_per_beat": self.max_invocations_per_beat,
            "cooldown_beats": self.cooldown_beats,
            "invocations_this_beat": self.invocations_this_beat,
            "last_invoked_beat": self.last_invoked_beat,
        }


@dataclass
class SovereignBeing:
    """
    A sovereign being within a division.
    
    Beings are autonomous entities that:
    - Operate within their division's domain
    - Have specific capabilities and permissions
    - Participate in Tier-11 resonance coupling
    - Maintain kernel compression of their intelligence
    """
    
    # Identity
    being_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    being_type: BeingType = BeingType.DOCUMENT_ORGANISM
    division: str = ""  # Division name
    
    # Status and lifecycle
    status: BeingStatus = BeingStatus.INITIALIZING
    created_at: float = field(default_factory=time.time)
    activated_at: Optional[float] = None
    last_activity_at: Optional[float] = None
    
    # Capabilities
    capabilities: List[BeingCapability] = field(default_factory=list)
    
    # Lineage
    parent_being_id: Optional[str] = None
    child_being_ids: List[str] = field(default_factory=list)
    lineage_depth: int = 0
    
    # Resonance state (Tier-11)
    resonance_connected: bool = False
    resonance_phase: float = 0.0
    resonance_coherence: float = 1.0
    resonance_energy: float = 1.0
    
    # Kernel (compressed intelligence)
    kernel_id: Optional[str] = None
    kernel_glyph: str = ""
    
    # Beat tracking
    current_beat: int = 0
    total_beats: int = 0
    
    # Metadata
    metadata: Dict[str, Any] = field(default_factory=dict)
    tags: List[str] = field(default_factory=list)
    
    def activate(self) -> None:
        """Activate the being."""
        self.status = BeingStatus.ACTIVE
        self.activated_at = time.time()
        self.last_activity_at = time.time()
    
    def suspend(self) -> None:
        """Suspend the being."""
        self.status = BeingStatus.SUSPENDED
        self.last_activity_at = time.time()
    
    def resume(self) -> None:
        """Resume the being."""
        if self.status == BeingStatus.SUSPENDED:
            self.status = BeingStatus.ACTIVE
            self.last_activity_at = time.time()
    
    def go_dormant(self) -> None:
        """Put being in dormant state."""
        self.status = BeingStatus.DORMANT
        self.last_activity_at = time.time()
    
    def transcend(self) -> None:
        """Begin transcendence (Infinity+1 law)."""
        self.status = BeingStatus.TRANSCENDING
        self.last_activity_at = time.time()
    
    def tick(self, beat: int) -> None:
        """Process one beat."""
        self.current_beat = beat
        self.total_beats += 1
        self.last_activity_at = time.time()
    
    def add_capability(
        self,
        name: str,
        description: str = "",
        permission_level: str = "internal",
        max_invocations: int = 100,
    ) -> BeingCapability:
        """Add a capability to the being."""
        cap = BeingCapability(
            name=name,
            description=description,
            permission_level=permission_level,
            max_invocations_per_beat=max_invocations,
        )
        self.capabilities.append(cap)
        return cap
    
    def invoke_capability(self, name: str) -> bool:
        """Invoke a capability by name."""
        for cap in self.capabilities:
            if cap.name == name:
                return cap.invoke(self.current_beat)
        return False
    
    def can_invoke(self, name: str) -> bool:
        """Check if capability can be invoked."""
        for cap in self.capabilities:
            if cap.name == name:
                return cap.can_invoke(self.current_beat)
        return False
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "being_id": self.being_id,
            "name": self.name,
            "being_type": self.being_type.value,
            "division": self.division,
            "status": self.status.value,
            "lifecycle": {
                "created_at": self.created_at,
                "activated_at": self.activated_at,
                "last_activity_at": self.last_activity_at,
            },
            "capabilities": [c.to_dict() for c in self.capabilities],
            "lineage": {
                "parent_id": self.parent_being_id,
                "child_count": len(self.child_being_ids),
                "depth": self.lineage_depth,
            },
            "resonance": {
                "connected": self.resonance_connected,
                "phase": round(self.resonance_phase, 6),
                "coherence": round(self.resonance_coherence, 4),
                "energy": round(self.resonance_energy, 4),
            },
            "kernel": {
                "id": self.kernel_id,
                "glyph": self.kernel_glyph,
            },
            "beats": {
                "current": self.current_beat,
                "total": self.total_beats,
            },
            "tags": self.tags,
        }
