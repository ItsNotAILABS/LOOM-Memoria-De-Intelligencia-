"""
REPOSITORY LAYER — Data Access Objects
=======================================
Protocol: PROT-521 — REPOSITORY LAYER

"Repositorium data servat et reddit."
(The repository stores and retrieves data.)

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

import asyncio
import json
from datetime import datetime
from typing import Dict, List, Optional, Any
import logging

from .schema import (
    MemorySchema,
    LineageSchema,
    TorusCoordinateSchema,
    MemoryState,
    MemoryType,
)
from .connection import DatabaseConnection, ConnectionPool

# ═══════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════

PHI = 1.6180339887498948482
logger = logging.getLogger(__name__)


# ═══════════════════════════════════════════════════════════════════════════
# MEMORY REPOSITORY
# ═══════════════════════════════════════════════════════════════════════════

class MemoryRepository:
    """
    Repository for memory operations
    """
    
    def __init__(self, pool: ConnectionPool):
        self.pool = pool
    
    async def create(self, memory: MemorySchema) -> str:
        """Create a new memory entry"""
        async with self.pool.acquire() as conn:
            await conn.execute(
                """
                INSERT INTO memories (
                    id, content, memory_type, state, theta, phi, rho, ring, beat,
                    context, emotional_valence, priority, lineage_id, metadata
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """,
                (
                    memory.id,
                    memory.content,
                    memory.memory_type.value,
                    memory.state.value,
                    memory.coordinates.theta if memory.coordinates else None,
                    memory.coordinates.phi if memory.coordinates else None,
                    memory.coordinates.rho if memory.coordinates else PHI,
                    memory.coordinates.ring if memory.coordinates else 0,
                    memory.coordinates.beat if memory.coordinates else 0,
                    memory.context,
                    memory.emotional_valence,
                    memory.priority,
                    memory.lineage_id,
                    json.dumps(memory.metadata),
                )
            )
        return memory.id
    
    async def get(self, memory_id: str) -> Optional[MemorySchema]:
        """Get a memory by ID"""
        async with self.pool.acquire() as conn:
            row = await conn.fetch_one(
                "SELECT * FROM memories WHERE id = ?",
                (memory_id,)
            )
            if row:
                return self._row_to_memory(row)
        return None
    
    async def update(self, memory: MemorySchema) -> bool:
        """Update a memory entry"""
        async with self.pool.acquire() as conn:
            await conn.execute(
                """
                UPDATE memories SET
                    content = ?, state = ?, priority = ?,
                    access_count = ?, replay_count = ?, strength = ?,
                    is_pinned = ?, updated_at = ?
                WHERE id = ?
                """,
                (
                    memory.content,
                    memory.state.value,
                    memory.priority,
                    memory.access_count,
                    memory.replay_count,
                    memory.strength,
                    memory.is_pinned,
                    datetime.utcnow().isoformat(),
                    memory.id,
                )
            )
        return True
    
    async def delete(self, memory_id: str) -> bool:
        """Delete a memory"""
        async with self.pool.acquire() as conn:
            await conn.execute(
                "DELETE FROM memories WHERE id = ?",
                (memory_id,)
            )
        return True
    
    async def find_by_type(
        self,
        memory_type: MemoryType,
        limit: int = 100
    ) -> List[MemorySchema]:
        """Find memories by type"""
        async with self.pool.acquire() as conn:
            rows = await conn.fetch_all(
                "SELECT * FROM memories WHERE memory_type = ? LIMIT ?",
                (memory_type.value, limit)
            )
            return [self._row_to_memory(row) for row in rows]
    
    async def find_by_ring(self, ring: int, limit: int = 100) -> List[MemorySchema]:
        """Find memories by torus ring"""
        async with self.pool.acquire() as conn:
            rows = await conn.fetch_all(
                "SELECT * FROM memories WHERE ring = ? LIMIT ?",
                (ring, limit)
            )
            return [self._row_to_memory(row) for row in rows]
    
    async def find_pinned(self, limit: int = 100) -> List[MemorySchema]:
        """Find pinned memories"""
        async with self.pool.acquire() as conn:
            rows = await conn.fetch_all(
                "SELECT * FROM memories WHERE is_pinned = 1 LIMIT ?",
                (limit,)
            )
            return [self._row_to_memory(row) for row in rows]
    
    async def search(self, query: str, limit: int = 100) -> List[MemorySchema]:
        """Search memories by content"""
        async with self.pool.acquire() as conn:
            rows = await conn.fetch_all(
                "SELECT * FROM memories WHERE content LIKE ? LIMIT ?",
                (f"%{query}%", limit)
            )
            return [self._row_to_memory(row) for row in rows]
    
    def _row_to_memory(self, row: Dict[str, Any]) -> MemorySchema:
        """Convert database row to MemorySchema"""
        coords = None
        if row.get("theta") is not None:
            coords = TorusCoordinateSchema(
                theta=row["theta"],
                phi=row["phi"],
                rho=row.get("rho", PHI),
                ring=row.get("ring", 0),
                beat=row.get("beat", 0),
            )
        
        return MemorySchema(
            id=row["id"],
            content=row["content"],
            memory_type=MemoryType(row["memory_type"]),
            state=MemoryState(row["state"]),
            coordinates=coords,
            context=row.get("context", ""),
            emotional_valence=row.get("emotional_valence", 0.0),
            priority=row.get("priority", 0.5),
            access_count=row.get("access_count", 0),
            replay_count=row.get("replay_count", 0),
            strength=row.get("strength", 0.0),
            is_pinned=bool(row.get("is_pinned", False)),
            lineage_id=row.get("lineage_id"),
            metadata=json.loads(row.get("metadata", "{}")),
        )


# ═══════════════════════════════════════════════════════════════════════════
# LINEAGE REPOSITORY
# ═══════════════════════════════════════════════════════════════════════════

class LineageRepository:
    """
    Repository for lineage operations
    """
    
    def __init__(self, pool: ConnectionPool):
        self.pool = pool
    
    async def create(self, lineage: LineageSchema) -> str:
        """Create a new lineage"""
        async with self.pool.acquire() as conn:
            await conn.execute(
                """
                INSERT INTO lineages (
                    id, root_id, ancestors, descendants, depth, phi_spacing, metadata
                ) VALUES (?, ?, ?, ?, ?, ?, ?)
                """,
                (
                    lineage.id,
                    lineage.root_id,
                    json.dumps(lineage.ancestors),
                    json.dumps(lineage.descendants),
                    lineage.depth,
                    lineage.phi_spacing,
                    json.dumps(lineage.metadata),
                )
            )
        return lineage.id
    
    async def get(self, lineage_id: str) -> Optional[LineageSchema]:
        """Get a lineage by ID"""
        async with self.pool.acquire() as conn:
            row = await conn.fetch_one(
                "SELECT * FROM lineages WHERE id = ?",
                (lineage_id,)
            )
            if row:
                return self._row_to_lineage(row)
        return None
    
    async def add_descendant(self, lineage_id: str, descendant_id: str) -> bool:
        """Add a descendant to a lineage"""
        lineage = await self.get(lineage_id)
        if lineage:
            lineage.descendants.append(descendant_id)
            async with self.pool.acquire() as conn:
                await conn.execute(
                    "UPDATE lineages SET descendants = ? WHERE id = ?",
                    (json.dumps(lineage.descendants), lineage_id)
                )
            return True
        return False
    
    def _row_to_lineage(self, row: Dict[str, Any]) -> LineageSchema:
        """Convert database row to LineageSchema"""
        return LineageSchema(
            id=row["id"],
            root_id=row["root_id"],
            ancestors=json.loads(row.get("ancestors", "[]")),
            descendants=json.loads(row.get("descendants", "[]")),
            depth=row.get("depth", 0),
            phi_spacing=row.get("phi_spacing", PHI),
            metadata=json.loads(row.get("metadata", "{}")),
        )


# ═══════════════════════════════════════════════════════════════════════════
# TORUS REPOSITORY
# ═══════════════════════════════════════════════════════════════════════════

class TorusRepository:
    """
    Repository for torus-specific operations
    """
    
    def __init__(self, pool: ConnectionPool):
        self.pool = pool
        self._memory_repo = MemoryRepository(pool)
    
    async def store_at_coordinate(
        self,
        content: str,
        coordinates: TorusCoordinateSchema,
        memory_type: MemoryType = MemoryType.EPISODIC,
    ) -> str:
        """Store a memory at specific torus coordinates"""
        memory_id = f"{coordinates.ring}-{coordinates.beat}"
        
        memory = MemorySchema(
            id=memory_id,
            content=content,
            memory_type=memory_type,
            state=MemoryState.ACTIVE,
            coordinates=coordinates,
        )
        
        return await self._memory_repo.create(memory)
    
    async def traverse_to(
        self,
        target: TorusCoordinateSchema
    ) -> Optional[MemorySchema]:
        """Find nearest memory to target coordinates"""
        async with self.pool.acquire() as conn:
            rows = await conn.fetch_all(
                "SELECT * FROM memories WHERE ring = ? ORDER BY beat DESC LIMIT 1",
                (target.ring,)
            )
            if rows:
                return self._memory_repo._row_to_memory(rows[0])
        return None
    
    async def get_ring_memories(self, ring: int) -> List[MemorySchema]:
        """Get all memories in a ring"""
        return await self._memory_repo.find_by_ring(ring)


# ═══════════════════════════════════════════════════════════════════════════
# MODULE IDENTITY
# ═══════════════════════════════════════════════════════════════════════════

REPOSITORY_IDENTITY = {
    "name": "nova_ovo.storage_layer.repository",
    "protocol": "PROT-521",
    "repositories": ["MemoryRepository", "LineageRepository", "TorusRepository"],
    "primitive_trace": "ADDRESS → MEMORY → FIELD → φ",
}
