"""
STORAGE LAYER — PRODUCTION PERSISTENCE INFRASTRUCTURE
=====================================================
Latin Name: STRATUM REPOSITORII PRODUCTIO
Protocol: PROT-518 — STORAGE LAYER PRODUCTION

"Data persistens in aeternum vivit."
(Persistent data lives forever.)

This module provides production-ready persistence for the Memory Temple
with support for PostgreSQL, SQLite, and IndexedDB backends.

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL
"""

from .schema import (
    MemorySchema,
    LineageSchema,
    TorusCoordinateSchema,
    create_all_tables,
    SCHEMA_VERSION,
)
from .repository import (
    MemoryRepository,
    LineageRepository,
    TorusRepository,
)
from .connection import (
    DatabaseConnection,
    ConnectionPool,
    DatabaseConfig,
)
from .migrations import (
    MigrationManager,
    Migration,
    get_pending_migrations,
)

__all__ = [
    # Schema
    "MemorySchema",
    "LineageSchema",
    "TorusCoordinateSchema",
    "create_all_tables",
    "SCHEMA_VERSION",
    # Repository
    "MemoryRepository",
    "LineageRepository",
    "TorusRepository",
    # Connection
    "DatabaseConnection",
    "ConnectionPool",
    "DatabaseConfig",
    # Migrations
    "MigrationManager",
    "Migration",
    "get_pending_migrations",
]

# ═══════════════════════════════════════════════════════════════════════════
# MODULE IDENTITY
# ═══════════════════════════════════════════════════════════════════════════

PHI = 1.6180339887498948482
PHI_16 = 2207.0  # φ¹⁶

MODULE_IDENTITY = {
    "name": "nova_ovo.storage_layer",
    "latin_name": "STRATUM REPOSITORII PRODUCTIO",
    "protocol": "PROT-518",
    "frequency_hz": PHI_16,
    "layer": 9,  # Organism
    "classification": "SOVEREIGN-ALPHA",
    "primitive_trace": "MEMORY → FIELD → DISTINCTION → φ",
    "law_reference": "L-97: Persistent storage requires transactional integrity",
    "supported_backends": ["postgresql", "sqlite", "indexeddb"],
}
