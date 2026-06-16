"""
DATABASE SCHEMA — Memory Temple Data Structures
================================================
Protocol: PROT-519 — DATABASE SCHEMA

"Structura data fundamentum est."
(Data structure is the foundation.)

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum
from typing import Dict, List, Optional, Any
import json

# ═══════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════

SCHEMA_VERSION = "3.0.0"
PHI = 1.6180339887498948482


# ═══════════════════════════════════════════════════════════════════════════
# ENUMS
# ═══════════════════════════════════════════════════════════════════════════

class MemoryState(Enum):
    ACTIVE = "active"
    ENCODING = "encoding"
    CONSOLIDATING = "consolidating"
    STORED = "stored"
    DECAYING = "decaying"
    ARCHIVED = "archived"
    PINNED = "pinned"


class MemoryType(Enum):
    EPISODIC = "episodic"
    SEMANTIC = "semantic"
    PROCEDURAL = "procedural"
    WORKING = "working"
    DOCTRINE = "doctrine"
    SPATIAL = "spatial"
    COLLECTIVE = "collective"


class BackendType(Enum):
    POSTGRESQL = "postgresql"
    SQLITE = "sqlite"
    INDEXEDDB = "indexeddb"


# ═══════════════════════════════════════════════════════════════════════════
# SCHEMA CLASSES
# ═══════════════════════════════════════════════════════════════════════════

@dataclass
class TorusCoordinateSchema:
    """Torus coordinate for spatial memory"""
    theta: float  # Angular position [0, 2π)
    phi: float    # Toroidal rotation [0, 2π)
    rho: float = PHI  # Radial depth (salience)
    ring: int = 0     # Memory ring index
    beat: int = 0     # Creation time
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "theta": self.theta,
            "phi": self.phi,
            "rho": self.rho,
            "ring": self.ring,
            "beat": self.beat,
        }
    
    def to_json(self) -> str:
        return json.dumps(self.to_dict())
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> "TorusCoordinateSchema":
        return cls(
            theta=data.get("theta", 0.0),
            phi=data.get("phi", 0.0),
            rho=data.get("rho", PHI),
            ring=data.get("ring", 0),
            beat=data.get("beat", 0),
        )


@dataclass
class MemorySchema:
    """Memory entry schema"""
    id: str
    content: str
    memory_type: MemoryType
    state: MemoryState
    coordinates: Optional[TorusCoordinateSchema] = None
    context: str = ""
    emotional_valence: float = 0.0
    priority: float = 0.5
    access_count: int = 0
    replay_count: int = 0
    strength: float = 0.0
    is_pinned: bool = False
    created_at: datetime = field(default_factory=datetime.utcnow)
    updated_at: datetime = field(default_factory=datetime.utcnow)
    lineage_id: Optional[str] = None
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.id,
            "content": self.content,
            "memory_type": self.memory_type.value,
            "state": self.state.value,
            "coordinates": self.coordinates.to_dict() if self.coordinates else None,
            "context": self.context,
            "emotional_valence": self.emotional_valence,
            "priority": self.priority,
            "access_count": self.access_count,
            "replay_count": self.replay_count,
            "strength": self.strength,
            "is_pinned": self.is_pinned,
            "created_at": self.created_at.isoformat(),
            "updated_at": self.updated_at.isoformat(),
            "lineage_id": self.lineage_id,
            "metadata": self.metadata,
        }


@dataclass
class LineageSchema:
    """Lineage tracking schema"""
    id: str
    root_id: str
    ancestors: List[str] = field(default_factory=list)
    descendants: List[str] = field(default_factory=list)
    depth: int = 0
    phi_spacing: float = PHI
    created_at: datetime = field(default_factory=datetime.utcnow)
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.id,
            "root_id": self.root_id,
            "ancestors": self.ancestors,
            "descendants": self.descendants,
            "depth": self.depth,
            "phi_spacing": self.phi_spacing,
            "created_at": self.created_at.isoformat(),
            "metadata": self.metadata,
        }


@dataclass
class ProcedureSchema:
    """Procedural memory schema"""
    name: str
    sequence: List[str]
    repetitions: int = 0
    strength: float = 0.0
    is_habit: bool = False
    last_executed: Optional[datetime] = None
    created_at: datetime = field(default_factory=datetime.utcnow)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "sequence": self.sequence,
            "repetitions": self.repetitions,
            "strength": self.strength,
            "is_habit": self.is_habit,
            "last_executed": self.last_executed.isoformat() if self.last_executed else None,
            "created_at": self.created_at.isoformat(),
        }


@dataclass
class HiveNodeSchema:
    """Hive node schema"""
    id: str
    metadata: str
    sync_version: int = 0
    last_sync: datetime = field(default_factory=datetime.utcnow)
    created_at: datetime = field(default_factory=datetime.utcnow)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.id,
            "metadata": self.metadata,
            "sync_version": self.sync_version,
            "last_sync": self.last_sync.isoformat(),
            "created_at": self.created_at.isoformat(),
        }


# ═══════════════════════════════════════════════════════════════════════════
# SQL SCHEMA DEFINITIONS
# ═══════════════════════════════════════════════════════════════════════════

POSTGRESQL_SCHEMA = """
-- Memory Temple PostgreSQL Schema v3.0.0
-- Protocol: PROT-519

-- Schema version tracking
CREATE TABLE IF NOT EXISTS schema_versions (
    id SERIAL PRIMARY KEY,
    version VARCHAR(20) NOT NULL,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Memory entries
CREATE TABLE IF NOT EXISTS memories (
    id VARCHAR(64) PRIMARY KEY,
    content TEXT NOT NULL,
    memory_type VARCHAR(20) NOT NULL,
    state VARCHAR(20) NOT NULL DEFAULT 'active',
    theta FLOAT,
    phi FLOAT,
    rho FLOAT DEFAULT 1.618033988749895,
    ring INTEGER DEFAULT 0,
    beat INTEGER DEFAULT 0,
    context TEXT,
    emotional_valence FLOAT DEFAULT 0.0,
    priority FLOAT DEFAULT 0.5,
    access_count INTEGER DEFAULT 0,
    replay_count INTEGER DEFAULT 0,
    strength FLOAT DEFAULT 0.0,
    is_pinned BOOLEAN DEFAULT FALSE,
    lineage_id VARCHAR(64),
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for memories
CREATE INDEX IF NOT EXISTS idx_memories_type ON memories(memory_type);
CREATE INDEX IF NOT EXISTS idx_memories_state ON memories(state);
CREATE INDEX IF NOT EXISTS idx_memories_ring ON memories(ring);
CREATE INDEX IF NOT EXISTS idx_memories_lineage ON memories(lineage_id);
CREATE INDEX IF NOT EXISTS idx_memories_pinned ON memories(is_pinned) WHERE is_pinned = TRUE;

-- Lineages
CREATE TABLE IF NOT EXISTS lineages (
    id VARCHAR(64) PRIMARY KEY,
    root_id VARCHAR(64) NOT NULL,
    ancestors TEXT[] DEFAULT '{}',
    descendants TEXT[] DEFAULT '{}',
    depth INTEGER DEFAULT 0,
    phi_spacing FLOAT DEFAULT 1.618033988749895,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Procedures (Basal Ganglia)
CREATE TABLE IF NOT EXISTS procedures (
    name VARCHAR(128) PRIMARY KEY,
    sequence TEXT[] NOT NULL,
    repetitions INTEGER DEFAULT 0,
    strength FLOAT DEFAULT 0.0,
    is_habit BOOLEAN DEFAULT FALSE,
    last_executed TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Hive nodes
CREATE TABLE IF NOT EXISTS hive_nodes (
    id VARCHAR(64) PRIMARY KEY,
    metadata TEXT,
    sync_version INTEGER DEFAULT 0,
    last_sync TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Hive broadcasts
CREATE TABLE IF NOT EXISTS hive_broadcasts (
    id VARCHAR(64) PRIMARY KEY,
    memory TEXT NOT NULL,
    source_id VARCHAR(64) NOT NULL,
    acks TEXT[] DEFAULT '{}',
    consensus BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Working memory slots
CREATE TABLE IF NOT EXISTS working_slots (
    key VARCHAR(128) PRIMARY KEY,
    value TEXT NOT NULL,
    priority FLOAT DEFAULT 0.5,
    access_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sync queue for offline operations
CREATE TABLE IF NOT EXISTS sync_queue (
    id SERIAL PRIMARY KEY,
    operation VARCHAR(20) NOT NULL,
    table_name VARCHAR(64) NOT NULL,
    record_id VARCHAR(64) NOT NULL,
    payload JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    processed_at TIMESTAMP
);
"""

SQLITE_SCHEMA = """
-- Memory Temple SQLite Schema v3.0.0
-- Protocol: PROT-519

-- Schema version tracking
CREATE TABLE IF NOT EXISTS schema_versions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    version TEXT NOT NULL,
    applied_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Memory entries
CREATE TABLE IF NOT EXISTS memories (
    id TEXT PRIMARY KEY,
    content TEXT NOT NULL,
    memory_type TEXT NOT NULL,
    state TEXT NOT NULL DEFAULT 'active',
    theta REAL,
    phi REAL,
    rho REAL DEFAULT 1.618033988749895,
    ring INTEGER DEFAULT 0,
    beat INTEGER DEFAULT 0,
    context TEXT,
    emotional_valence REAL DEFAULT 0.0,
    priority REAL DEFAULT 0.5,
    access_count INTEGER DEFAULT 0,
    replay_count INTEGER DEFAULT 0,
    strength REAL DEFAULT 0.0,
    is_pinned INTEGER DEFAULT 0,
    lineage_id TEXT,
    metadata TEXT DEFAULT '{}',
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for memories
CREATE INDEX IF NOT EXISTS idx_memories_type ON memories(memory_type);
CREATE INDEX IF NOT EXISTS idx_memories_state ON memories(state);
CREATE INDEX IF NOT EXISTS idx_memories_ring ON memories(ring);

-- Lineages
CREATE TABLE IF NOT EXISTS lineages (
    id TEXT PRIMARY KEY,
    root_id TEXT NOT NULL,
    ancestors TEXT DEFAULT '[]',
    descendants TEXT DEFAULT '[]',
    depth INTEGER DEFAULT 0,
    phi_spacing REAL DEFAULT 1.618033988749895,
    metadata TEXT DEFAULT '{}',
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Procedures
CREATE TABLE IF NOT EXISTS procedures (
    name TEXT PRIMARY KEY,
    sequence TEXT NOT NULL,
    repetitions INTEGER DEFAULT 0,
    strength REAL DEFAULT 0.0,
    is_habit INTEGER DEFAULT 0,
    last_executed TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Hive nodes
CREATE TABLE IF NOT EXISTS hive_nodes (
    id TEXT PRIMARY KEY,
    metadata TEXT,
    sync_version INTEGER DEFAULT 0,
    last_sync TEXT DEFAULT CURRENT_TIMESTAMP,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Working memory slots
CREATE TABLE IF NOT EXISTS working_slots (
    key TEXT PRIMARY KEY,
    value TEXT NOT NULL,
    priority REAL DEFAULT 0.5,
    access_count INTEGER DEFAULT 0,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Sync queue
CREATE TABLE IF NOT EXISTS sync_queue (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    operation TEXT NOT NULL,
    table_name TEXT NOT NULL,
    record_id TEXT NOT NULL,
    payload TEXT NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    processed_at TEXT
);
"""


def create_all_tables(backend: BackendType = BackendType.SQLITE) -> str:
    """Get schema SQL for the specified backend"""
    if backend == BackendType.POSTGRESQL:
        return POSTGRESQL_SCHEMA
    elif backend == BackendType.SQLITE:
        return SQLITE_SCHEMA
    else:
        raise ValueError(f"Unsupported backend: {backend}")


# ═══════════════════════════════════════════════════════════════════════════
# MODULE IDENTITY
# ═══════════════════════════════════════════════════════════════════════════

SCHEMA_IDENTITY = {
    "name": "nova_ovo.storage_layer.schema",
    "protocol": "PROT-519",
    "version": SCHEMA_VERSION,
    "tables": [
        "memories", "lineages", "procedures",
        "hive_nodes", "hive_broadcasts", "working_slots", "sync_queue",
    ],
    "primitive_trace": "FIELD → DISTINCTION → MEMORY → φ",
}
