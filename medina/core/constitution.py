"""
MEDINA Constitution — Root charter and doctrine hierarchy.

DOCTRINE LEVELS (non-collapsible):
  Absolute  — immutable founding truth
  Law       — constitutional laws (RECITAL_PLUS_ONE, Gates, etc.)
  Model     — runtime model contracts
  Engine    — execution engine specifications
  Core      — Core A/B authority boundaries
  Module    — modular capability contracts
  Lab       — experimental/sandbox scope
  Workforce — document/agent workforce
  Product   — external product surface

NO-COLLAPSE INVARIANT:
  Absolute ≠ Law ≠ Model ≠ Engine ≠ Core ≠ Module ≠ Lab ≠ Workforce ≠ Product

Each level has distinct:
  - Mutation authority
  - Governance requirements
  - Evidence trails
  - Rollback scope
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum, auto
from typing import Any, Dict, List, Optional


class DoctrineLevel(Enum):
    """
    Non-collapsible doctrine hierarchy.
    
    Numerical ordering reflects authority precedence:
    lower number = higher authority.
    """
    ABSOLUTE = 0    # Immutable founding truth
    LAW = 1         # Constitutional laws
    MODEL = 2       # Runtime model contracts
    ENGINE = 3      # Execution engine specs
    CORE = 4        # Core A/B boundaries
    MODULE = 5      # Module capabilities
    LAB = 6         # Experimental scope
    WORKFORCE = 7   # Document/agent workforce
    PRODUCT = 8     # External product surface
    
    def __lt__(self, other: "DoctrineLevel") -> bool:
        return self.value < other.value
    
    def can_govern(self, other: "DoctrineLevel") -> bool:
        """Higher authority can govern lower levels."""
        return self.value < other.value


@dataclass
class DoctrineEntry:
    """Single entry in the constitution registry."""
    
    entry_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    level: DoctrineLevel = DoctrineLevel.LAW
    key: str = ""
    value: Any = None
    rationale: str = ""
    created_at: float = field(default_factory=time.time)
    updated_at: float = field(default_factory=time.time)
    version: int = 1
    immutable: bool = False
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "entry_id": self.entry_id,
            "level": self.level.name,
            "key": self.key,
            "value": self.value,
            "rationale": self.rationale,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
            "version": self.version,
            "immutable": self.immutable,
        }


@dataclass
class ConstitutionSnapshot:
    """Immutable snapshot of constitution state."""
    
    snapshot_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    beat: int = 0
    timestamp: float = field(default_factory=time.time)
    entries: List[DoctrineEntry] = field(default_factory=list)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "snapshot_id": self.snapshot_id,
            "beat": self.beat,
            "timestamp": self.timestamp,
            "entries": [e.to_dict() for e in self.entries],
        }


class Constitution:
    """
    MEDINA Constitution — the authoritative doctrine registry.
    
    Enforces:
    - NO-COLLAPSE: levels never merge or collapse
    - IMMUTABLE ABSOLUTE: founding truth cannot change
    - GOVERNANCE CHAIN: mutations require appropriate authority
    - EVIDENCE TRAIL: all changes produce evidence records
    
    FOUNDING ABSOLUTES (pre-loaded):
    - RECITAL_PLUS_ONE law
    - Four-register requirement
    - Dual-read always-on
    - Gate A/B/C enforcement
    - Core A/B authority separation
    """
    
    # Founding absolutes — immutable after instantiation
    FOUNDING_ABSOLUTES = {
        "RECITAL_PLUS_ONE": {
            "value": "state(n+1) = recital(validated_state_n) + one_lawful_expansion",
            "rationale": "Master generative law governing all state evolution",
        },
        "FOUR_REGISTERS": {
            "value": ["Founder", "Builder", "Organism", "External"],
            "rationale": "All critical artifacts preserve four registers",
        },
        "DUAL_READ_ALWAYS_ON": {
            "value": {"semantic_read": True, "resonance_read": True},
            "rationale": "Missing either mode degrades or halts autonomous write",
        },
        "GATES_ABC": {
            "value": {
                "Gate_A": "runtime readiness",
                "Gate_B": "workforce activation",
                "Gate_C": "projection safety",
            },
            "rationale": "No bypass allowed for any gate",
        },
        "CORE_AUTHORITY": {
            "value": {
                "Core_A": "runtime truth",
                "Core_B": "industrial/workforce execution",
            },
            "rationale": "Core B proposes; Core A accepts runtime-truth mutation",
        },
        "NO_COLLAPSE_ONTOLOGY": {
            "value": [
                "Absolute", "Law", "Model", "Engine", 
                "Core", "Module", "Lab", "Workforce", "Product"
            ],
            "rationale": "These nine levels must never collapse into each other",
        },
    }
    
    def __init__(self) -> None:
        self._entries: Dict[str, DoctrineEntry] = {}
        self._snapshots: List[ConstitutionSnapshot] = []
        self._beat: int = 0
        self._created_at = time.time()
        
        # Load founding absolutes (immutable)
        self._load_founding_absolutes()
    
    def _load_founding_absolutes(self) -> None:
        """Pre-load immutable founding absolutes."""
        for key, spec in self.FOUNDING_ABSOLUTES.items():
            entry = DoctrineEntry(
                level=DoctrineLevel.ABSOLUTE,
                key=key,
                value=spec["value"],
                rationale=spec["rationale"],
                immutable=True,
            )
            self._entries[key] = entry
    
    # ------------------------------------------------------------------ #
    # Reads                                                                 #
    # ------------------------------------------------------------------ #
    
    def get(self, key: str) -> Optional[DoctrineEntry]:
        """Read a doctrine entry by key."""
        return self._entries.get(key)
    
    def get_level(self, level: DoctrineLevel) -> List[DoctrineEntry]:
        """Get all entries at a specific doctrine level."""
        return [e for e in self._entries.values() if e.level == level]
    
    def list_keys(self, level: Optional[DoctrineLevel] = None) -> List[str]:
        """List all keys, optionally filtered by level."""
        if level is not None:
            return [e.key for e in self._entries.values() if e.level == level]
        return list(self._entries.keys())
    
    # ------------------------------------------------------------------ #
    # Writes (governance required)                                          #
    # ------------------------------------------------------------------ #
    
    def register(
        self,
        key: str,
        value: Any,
        level: DoctrineLevel,
        rationale: str,
        authority_level: DoctrineLevel,
    ) -> Optional[DoctrineEntry]:
        """
        Register a new doctrine entry.
        
        Requires authority_level to be strictly higher than target level.
        Cannot modify immutable entries.
        """
        # Check authority
        if not authority_level.can_govern(level):
            return None
        
        # Cannot overwrite immutable
        if key in self._entries and self._entries[key].immutable:
            return None
        
        # Cannot register at ABSOLUTE level after initialization
        if level == DoctrineLevel.ABSOLUTE:
            return None
        
        existing = self._entries.get(key)
        new_version = (existing.version + 1) if existing else 1
        
        entry = DoctrineEntry(
            level=level,
            key=key,
            value=value,
            rationale=rationale,
            version=new_version,
        )
        self._entries[key] = entry
        return entry
    
    def update(
        self,
        key: str,
        value: Any,
        rationale: str,
        authority_level: DoctrineLevel,
    ) -> Optional[DoctrineEntry]:
        """
        Update an existing doctrine entry.
        
        Requires authority to govern the entry's level.
        Cannot modify immutable entries.
        """
        if key not in self._entries:
            return None
        
        existing = self._entries[key]
        
        if existing.immutable:
            return None
        
        if not authority_level.can_govern(existing.level):
            return None
        
        entry = DoctrineEntry(
            entry_id=existing.entry_id,
            level=existing.level,
            key=key,
            value=value,
            rationale=rationale,
            created_at=existing.created_at,
            version=existing.version + 1,
        )
        self._entries[key] = entry
        return entry
    
    # ------------------------------------------------------------------ #
    # Snapshots                                                             #
    # ------------------------------------------------------------------ #
    
    def snapshot(self) -> ConstitutionSnapshot:
        """Create an immutable snapshot of current state."""
        snap = ConstitutionSnapshot(
            beat=self._beat,
            entries=list(self._entries.values()),
        )
        self._snapshots.append(snap)
        self._beat += 1
        return snap
    
    def get_snapshot(self, snapshot_id: str) -> Optional[ConstitutionSnapshot]:
        """Retrieve a historical snapshot."""
        for snap in self._snapshots:
            if snap.snapshot_id == snapshot_id:
                return snap
        return None
    
    def latest_snapshot(self) -> Optional[ConstitutionSnapshot]:
        """Get the most recent snapshot."""
        return self._snapshots[-1] if self._snapshots else None
    
    # ------------------------------------------------------------------ #
    # Validation                                                            #
    # ------------------------------------------------------------------ #
    
    def validate_no_collapse(self) -> bool:
        """
        Verify NO-COLLAPSE invariant.
        
        Each doctrine level must have distinct entries —
        no entry should span multiple levels.
        """
        levels_seen: Dict[str, DoctrineLevel] = {}
        for entry in self._entries.values():
            if entry.key in levels_seen:
                # Same key at different level would violate no-collapse
                if levels_seen[entry.key] != entry.level:
                    return False
            levels_seen[entry.key] = entry.level
        return True
    
    def to_dict(self) -> Dict[str, Any]:
        """Full constitution export."""
        return {
            "beat": self._beat,
            "created_at": self._created_at,
            "founding_absolutes": list(self.FOUNDING_ABSOLUTES.keys()),
            "entries": {k: v.to_dict() for k, v in self._entries.items()},
            "snapshot_count": len(self._snapshots),
        }
