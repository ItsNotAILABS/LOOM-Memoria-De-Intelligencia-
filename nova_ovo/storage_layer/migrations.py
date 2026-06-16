"""
MIGRATIONS MANAGER — Database Schema Migrations
================================================
Protocol: PROT-522 — MIGRATIONS MANAGER

"Migratio data securum efficit."
(Migration makes data safe.)

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

import asyncio
from dataclasses import dataclass, field
from datetime import datetime
from typing import Dict, List, Optional, Callable, Awaitable
import logging

from .connection import DatabaseConnection, ConnectionPool, DatabaseConfig
from .schema import SCHEMA_VERSION

# ═══════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════

logger = logging.getLogger(__name__)


# ═══════════════════════════════════════════════════════════════════════════
# DATA CLASSES
# ═══════════════════════════════════════════════════════════════════════════

@dataclass
class Migration:
    """A single migration"""
    version: str
    description: str
    up_sql: str
    down_sql: str = ""
    applied_at: Optional[datetime] = None


# ═══════════════════════════════════════════════════════════════════════════
# BUILT-IN MIGRATIONS
# ═══════════════════════════════════════════════════════════════════════════

MIGRATIONS: List[Migration] = [
    Migration(
        version="1.0.0",
        description="Initial schema",
        up_sql="""
            CREATE TABLE IF NOT EXISTS schema_versions (
                id INTEGER PRIMARY KEY,
                version TEXT NOT NULL,
                applied_at TEXT DEFAULT CURRENT_TIMESTAMP
            );
        """,
        down_sql="DROP TABLE IF EXISTS schema_versions;",
    ),
    Migration(
        version="2.0.0",
        description="Add memories table",
        up_sql="""
            CREATE TABLE IF NOT EXISTS memories (
                id TEXT PRIMARY KEY,
                content TEXT NOT NULL,
                memory_type TEXT NOT NULL,
                state TEXT NOT NULL DEFAULT 'active',
                created_at TEXT DEFAULT CURRENT_TIMESTAMP
            );
        """,
        down_sql="DROP TABLE IF EXISTS memories;",
    ),
    Migration(
        version="3.0.0",
        description="Add torus coordinates and full schema",
        up_sql="""
            ALTER TABLE memories ADD COLUMN theta REAL;
            ALTER TABLE memories ADD COLUMN phi REAL;
            ALTER TABLE memories ADD COLUMN rho REAL DEFAULT 1.618033988749895;
            ALTER TABLE memories ADD COLUMN ring INTEGER DEFAULT 0;
            ALTER TABLE memories ADD COLUMN beat INTEGER DEFAULT 0;
            ALTER TABLE memories ADD COLUMN context TEXT;
            ALTER TABLE memories ADD COLUMN emotional_valence REAL DEFAULT 0.0;
            ALTER TABLE memories ADD COLUMN priority REAL DEFAULT 0.5;
            ALTER TABLE memories ADD COLUMN access_count INTEGER DEFAULT 0;
            ALTER TABLE memories ADD COLUMN replay_count INTEGER DEFAULT 0;
            ALTER TABLE memories ADD COLUMN strength REAL DEFAULT 0.0;
            ALTER TABLE memories ADD COLUMN is_pinned INTEGER DEFAULT 0;
            ALTER TABLE memories ADD COLUMN lineage_id TEXT;
            ALTER TABLE memories ADD COLUMN metadata TEXT DEFAULT '{}';
            ALTER TABLE memories ADD COLUMN updated_at TEXT;
            
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
            
            CREATE TABLE IF NOT EXISTS procedures (
                name TEXT PRIMARY KEY,
                sequence TEXT NOT NULL,
                repetitions INTEGER DEFAULT 0,
                strength REAL DEFAULT 0.0,
                is_habit INTEGER DEFAULT 0,
                last_executed TEXT,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP
            );
            
            CREATE TABLE IF NOT EXISTS hive_nodes (
                id TEXT PRIMARY KEY,
                metadata TEXT,
                sync_version INTEGER DEFAULT 0,
                last_sync TEXT DEFAULT CURRENT_TIMESTAMP,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP
            );
            
            CREATE TABLE IF NOT EXISTS working_slots (
                key TEXT PRIMARY KEY,
                value TEXT NOT NULL,
                priority REAL DEFAULT 0.5,
                access_count INTEGER DEFAULT 0,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP,
                updated_at TEXT DEFAULT CURRENT_TIMESTAMP
            );
            
            CREATE TABLE IF NOT EXISTS sync_queue (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                operation TEXT NOT NULL,
                table_name TEXT NOT NULL,
                record_id TEXT NOT NULL,
                payload TEXT NOT NULL,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP,
                processed_at TEXT
            );
            
            CREATE INDEX IF NOT EXISTS idx_memories_type ON memories(memory_type);
            CREATE INDEX IF NOT EXISTS idx_memories_ring ON memories(ring);
        """,
        down_sql="""
            DROP INDEX IF EXISTS idx_memories_ring;
            DROP INDEX IF EXISTS idx_memories_type;
            DROP TABLE IF EXISTS sync_queue;
            DROP TABLE IF EXISTS working_slots;
            DROP TABLE IF EXISTS hive_nodes;
            DROP TABLE IF EXISTS procedures;
            DROP TABLE IF EXISTS lineages;
        """,
    ),
]


# ═══════════════════════════════════════════════════════════════════════════
# MIGRATION MANAGER
# ═══════════════════════════════════════════════════════════════════════════

class MigrationManager:
    """
    Manages database schema migrations
    """
    
    def __init__(self, pool: ConnectionPool):
        self.pool = pool
        self._migrations = {m.version: m for m in MIGRATIONS}
    
    async def get_current_version(self) -> Optional[str]:
        """Get the current schema version"""
        try:
            async with self.pool.acquire() as conn:
                row = await conn.fetch_one(
                    "SELECT version FROM schema_versions ORDER BY id DESC LIMIT 1",
                    ()
                )
                return row["version"] if row else None
        except Exception:
            return None
    
    async def get_applied_migrations(self) -> List[str]:
        """Get list of applied migration versions"""
        try:
            async with self.pool.acquire() as conn:
                rows = await conn.fetch_all(
                    "SELECT version FROM schema_versions ORDER BY id",
                    ()
                )
                return [row["version"] for row in rows]
        except Exception:
            return []
    
    async def get_pending_migrations(self) -> List[Migration]:
        """Get list of pending migrations"""
        applied = set(await self.get_applied_migrations())
        return [m for m in MIGRATIONS if m.version not in applied]
    
    async def migrate(self, target_version: Optional[str] = None) -> int:
        """
        Run pending migrations up to target version
        
        Returns number of migrations applied
        """
        pending = await self.get_pending_migrations()
        
        if target_version:
            pending = [m for m in pending if m.version <= target_version]
        
        count = 0
        for migration in pending:
            try:
                async with self.pool.acquire() as conn:
                    # Run migration
                    for statement in migration.up_sql.split(';'):
                        statement = statement.strip()
                        if statement:
                            await conn.execute(statement, ())
                    
                    # Record migration
                    await conn.execute(
                        "INSERT INTO schema_versions (version) VALUES (?)",
                        (migration.version,)
                    )
                
                logger.info(f"Applied migration {migration.version}: {migration.description}")
                count += 1
                
            except Exception as e:
                logger.error(f"Migration {migration.version} failed: {e}")
                raise
        
        return count
    
    async def rollback(self, steps: int = 1) -> int:
        """
        Rollback migrations
        
        Returns number of migrations rolled back
        """
        applied = await self.get_applied_migrations()
        
        count = 0
        for _ in range(min(steps, len(applied))):
            version = applied.pop()
            migration = self._migrations.get(version)
            
            if migration and migration.down_sql:
                try:
                    async with self.pool.acquire() as conn:
                        for statement in migration.down_sql.split(';'):
                            statement = statement.strip()
                            if statement:
                                await conn.execute(statement, ())
                        
                        await conn.execute(
                            "DELETE FROM schema_versions WHERE version = ?",
                            (version,)
                        )
                    
                    logger.info(f"Rolled back migration {version}")
                    count += 1
                    
                except Exception as e:
                    logger.error(f"Rollback {version} failed: {e}")
                    raise
        
        return count


def get_pending_migrations(pool: ConnectionPool) -> List[Migration]:
    """Convenience function to get pending migrations synchronously"""
    manager = MigrationManager(pool)
    return asyncio.run(manager.get_pending_migrations())


# ═══════════════════════════════════════════════════════════════════════════
# MODULE IDENTITY
# ═══════════════════════════════════════════════════════════════════════════

MIGRATIONS_IDENTITY = {
    "name": "nova_ovo.storage_layer.migrations",
    "protocol": "PROT-522",
    "current_version": SCHEMA_VERSION,
    "total_migrations": len(MIGRATIONS),
    "primitive_trace": "REPETITION → MEMORY → φ",
}
