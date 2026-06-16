"""
Division Registry — Central Registry for All Divisions
========================================================
Manages lifecycle and coordination of all 7 divisions.

Architecture Stack (flow):
  Doctrine → Procedures → Engine → Three Computers → Output

The registry:
- Initializes all divisions on startup
- Manages division lifecycle
- Coordinates inter-division communication
- Tracks division health and statistics
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, TYPE_CHECKING

from .beings import SovereignBeing, BeingType, BeingStatus


class DivisionType(str, Enum):
    """The 7 division types."""
    DOCTRINE = "doctrine"
    PROCEDURES = "procedures"
    ENGINE = "engine"
    MEMORY = "memory"
    INTERFACE = "interface"
    GOVERNANCE = "governance"
    WORKFORCE = "workforce"


class DivisionStatus(str, Enum):
    """Division operational status."""
    OFFLINE = "offline"
    INITIALIZING = "initializing"
    ONLINE = "online"
    DEGRADED = "degraded"
    MAINTENANCE = "maintenance"
    ERROR = "error"


@dataclass
class Division:
    """
    A sovereign division containing multiple beings.
    
    Each division represents a domain of responsibility
    within the MEDINA architecture.
    """
    
    # Identity
    division_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    division_type: DivisionType = DivisionType.WORKFORCE
    
    # Description
    description: str = ""
    responsibilities: List[str] = field(default_factory=list)
    
    # Status
    status: DivisionStatus = DivisionStatus.OFFLINE
    created_at: float = field(default_factory=time.time)
    started_at: Optional[float] = None
    
    # Beings
    beings: Dict[str, SovereignBeing] = field(default_factory=dict)
    
    # Architecture stack position (1 = highest, 7 = lowest)
    stack_position: int = 0
    
    # Dependencies (divisions this depends on)
    dependencies: List[str] = field(default_factory=list)
    
    # Provides to (divisions that depend on this)
    provides_to: List[str] = field(default_factory=list)
    
    # Beat tracking
    current_beat: int = 0
    
    # Statistics
    total_beings_created: int = 0
    total_beats_processed: int = 0
    
    def start(self) -> None:
        """Start the division."""
        self.status = DivisionStatus.INITIALIZING
        self.started_at = time.time()
        
        # Activate all beings
        for being in self.beings.values():
            being.activate()
        
        self.status = DivisionStatus.ONLINE
    
    def stop(self) -> None:
        """Stop the division."""
        for being in self.beings.values():
            being.suspend()
        
        self.status = DivisionStatus.OFFLINE
    
    def add_being(self, being: SovereignBeing) -> None:
        """Add a being to the division."""
        being.division = self.name
        self.beings[being.being_id] = being
        self.total_beings_created += 1
    
    def remove_being(self, being_id: str) -> bool:
        """Remove a being from the division."""
        if being_id in self.beings:
            del self.beings[being_id]
            return True
        return False
    
    def get_being(self, being_id: str) -> Optional[SovereignBeing]:
        """Get a being by ID."""
        return self.beings.get(being_id)
    
    def get_beings_by_type(self, being_type: BeingType) -> List[SovereignBeing]:
        """Get all beings of a specific type."""
        return [b for b in self.beings.values() if b.being_type == being_type]
    
    def tick(self, beat: int) -> None:
        """Process one beat across all beings."""
        self.current_beat = beat
        self.total_beats_processed += 1
        
        for being in self.beings.values():
            if being.status == BeingStatus.ACTIVE:
                being.tick(beat)
    
    @property
    def active_beings_count(self) -> int:
        """Count of active beings."""
        return sum(1 for b in self.beings.values() if b.status == BeingStatus.ACTIVE)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "division_id": self.division_id,
            "name": self.name,
            "division_type": self.division_type.value,
            "description": self.description,
            "responsibilities": self.responsibilities,
            "status": self.status.value,
            "created_at": self.created_at,
            "started_at": self.started_at,
            "stack_position": self.stack_position,
            "dependencies": self.dependencies,
            "provides_to": self.provides_to,
            "beings_count": len(self.beings),
            "active_beings": self.active_beings_count,
            "current_beat": self.current_beat,
            "total_beings_created": self.total_beings_created,
            "total_beats_processed": self.total_beats_processed,
        }


class DivisionRegistry:
    """
    Central registry for all 7 divisions.
    
    Architecture Stack:
      Doctrine → Procedures → Engine → Three Computers → Output
    """
    
    # Architecture stack order (top to bottom)
    STACK_ORDER = [
        DivisionType.DOCTRINE,      # 1 - Foundational truth
        DivisionType.PROCEDURES,    # 2 - Operational workflows
        DivisionType.ENGINE,        # 3 - Computation
        DivisionType.MEMORY,        # 4 - Memory temple
        DivisionType.GOVERNANCE,    # 5 - Access control
        DivisionType.INTERFACE,     # 6 - User interaction
        DivisionType.WORKFORCE,     # 7 - Execution
    ]
    
    def __init__(self) -> None:
        self.registry_id = str(uuid.uuid4())
        self.created_at = time.time()
        
        # Divisions storage
        self._divisions: Dict[DivisionType, Division] = {}
        
        # Initialize all 7 divisions
        self._initialize_divisions()
        
        # Global beat
        self.current_beat = 0
    
    def _initialize_divisions(self) -> None:
        """Initialize all 7 divisions with their configurations."""
        configs = {
            DivisionType.DOCTRINE: {
                "name": "Doctrine Division",
                "description": "Laws, constitution, and foundational truths",
                "responsibilities": [
                    "Maintain constitutional laws",
                    "Enforce doctrine constraints",
                    "Validate truth assertions",
                    "Guard foundational principles",
                ],
                "stack_position": 1,
                "dependencies": [],
                "provides_to": ["procedures", "governance"],
            },
            DivisionType.PROCEDURES: {
                "name": "Procedures Division",
                "description": "Operational workflows and protocols",
                "responsibilities": [
                    "Define operational procedures",
                    "Manage workflow execution",
                    "Enforce protocol compliance",
                    "Coordinate process flows",
                ],
                "stack_position": 2,
                "dependencies": ["doctrine"],
                "provides_to": ["engine", "workforce"],
            },
            DivisionType.ENGINE: {
                "name": "Engine Division",
                "description": "Computational cores and processing",
                "responsibilities": [
                    "Run computational engines",
                    "Manage heart oscillators",
                    "Process brain computations",
                    "Coordinate three computers",
                ],
                "stack_position": 3,
                "dependencies": ["doctrine", "procedures"],
                "provides_to": ["memory", "interface"],
            },
            DivisionType.MEMORY: {
                "name": "Memory Division",
                "description": "Memory temple and navigation",
                "responsibilities": [
                    "Manage memory temple geometry",
                    "Navigate torus coordinates",
                    "Consolidate memories",
                    "Track lineage and provenance",
                ],
                "stack_position": 4,
                "dependencies": ["engine"],
                "provides_to": ["interface", "workforce"],
            },
            DivisionType.GOVERNANCE: {
                "name": "Governance Division",
                "description": "Approvals, proposals, and access control",
                "responsibilities": [
                    "Process proposals",
                    "Manage approvals",
                    "Enforce gate access",
                    "Control permissions",
                ],
                "stack_position": 5,
                "dependencies": ["doctrine"],
                "provides_to": ["procedures", "workforce"],
            },
            DivisionType.INTERFACE: {
                "name": "Interface Division",
                "description": "User interaction and projection",
                "responsibilities": [
                    "Manage projection boundaries",
                    "Handle chat control",
                    "Render surfaces",
                    "Control external exposure",
                ],
                "stack_position": 6,
                "dependencies": ["engine", "memory"],
                "provides_to": ["workforce"],
            },
            DivisionType.WORKFORCE: {
                "name": "Workforce Division",
                "description": "Document organisms and agents",
                "responsibilities": [
                    "Manage document organisms D1-D10",
                    "Coordinate agent workforce",
                    "Execute tasks",
                    "Produce outputs",
                ],
                "stack_position": 7,
                "dependencies": ["procedures", "memory", "interface"],
                "provides_to": [],
            },
        }
        
        for div_type, config in configs.items():
            division = Division(
                name=config["name"],
                division_type=div_type,
                description=config["description"],
                responsibilities=config["responsibilities"],
                stack_position=config["stack_position"],
                dependencies=config["dependencies"],
                provides_to=config["provides_to"],
            )
            self._divisions[div_type] = division
    
    def get_division(self, div_type: DivisionType) -> Optional[Division]:
        """Get a division by type."""
        return self._divisions.get(div_type)
    
    def get_all_divisions(self) -> List[Division]:
        """Get all divisions in stack order."""
        return [self._divisions[t] for t in self.STACK_ORDER if t in self._divisions]
    
    def start_all(self) -> None:
        """Start all divisions in stack order (top-down)."""
        for div_type in self.STACK_ORDER:
            div = self._divisions.get(div_type)
            if div:
                div.start()
    
    def stop_all(self) -> None:
        """Stop all divisions in reverse stack order (bottom-up)."""
        for div_type in reversed(self.STACK_ORDER):
            div = self._divisions.get(div_type)
            if div:
                div.stop()
    
    def tick(self, beat: int) -> None:
        """Process one beat across all divisions."""
        self.current_beat = beat
        
        # Process in stack order
        for div_type in self.STACK_ORDER:
            div = self._divisions.get(div_type)
            if div and div.status == DivisionStatus.ONLINE:
                div.tick(beat)
    
    def add_being_to_division(
        self,
        div_type: DivisionType,
        being: SovereignBeing,
    ) -> bool:
        """Add a being to a specific division."""
        div = self._divisions.get(div_type)
        if div:
            div.add_being(being)
            return True
        return False
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get registry statistics."""
        total_beings = sum(len(d.beings) for d in self._divisions.values())
        active_beings = sum(d.active_beings_count for d in self._divisions.values())
        
        by_division = {}
        for div_type, div in self._divisions.items():
            by_division[div_type.value] = {
                "status": div.status.value,
                "beings": len(div.beings),
                "active": div.active_beings_count,
                "beats": div.total_beats_processed,
            }
        
        return {
            "registry_id": self.registry_id,
            "created_at": self.created_at,
            "current_beat": self.current_beat,
            "total_divisions": len(self._divisions),
            "total_beings": total_beings,
            "active_beings": active_beings,
            "by_division": by_division,
        }
    
    def to_dict(self) -> Dict[str, Any]:
        """Serialize registry."""
        return {
            "registry_id": self.registry_id,
            "statistics": self.get_statistics(),
            "divisions": {
                k.value: v.to_dict() for k, v in self._divisions.items()
            },
        }
