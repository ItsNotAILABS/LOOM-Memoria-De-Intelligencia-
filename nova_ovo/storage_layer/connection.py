"""
DATABASE CONNECTION — Production Connection Pool
=================================================
Protocol: PROT-520 — DATABASE CONNECTION

"Connexio firma fundamentum est."
(A firm connection is the foundation.)

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

import asyncio
import logging
from dataclasses import dataclass, field
from enum import Enum
from pathlib import Path
from typing import Dict, List, Optional, Any, AsyncContextManager
from contextlib import asynccontextmanager
import time

from .schema import BackendType, create_all_tables

# ═══════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════

PHI = 1.6180339887498948482
DEFAULT_POOL_SIZE = 5
MAX_POOL_SIZE = 21  # Fibonacci
CONNECTION_TIMEOUT = 30.0

logger = logging.getLogger(__name__)


# ═══════════════════════════════════════════════════════════════════════════
# DATA CLASSES
# ═══════════════════════════════════════════════════════════════════════════

@dataclass
class DatabaseConfig:
    """Database configuration"""
    backend: BackendType = BackendType.SQLITE
    host: str = "localhost"
    port: int = 5432
    database: str = "memory_temple"
    user: str = "medina"
    password: str = ""
    ssl_mode: str = "prefer"
    pool_min_size: int = 2
    pool_max_size: int = DEFAULT_POOL_SIZE
    connection_timeout: float = CONNECTION_TIMEOUT
    sqlite_path: Optional[Path] = None
    
    @classmethod
    def sqlite(cls, path: str = "memory_temple.db") -> "DatabaseConfig":
        """Create SQLite configuration"""
        return cls(
            backend=BackendType.SQLITE,
            database=path,
            sqlite_path=Path(path),
        )
    
    @classmethod
    def postgresql(
        cls,
        host: str = "localhost",
        port: int = 5432,
        database: str = "memory_temple",
        user: str = "medina",
        password: str = "",
    ) -> "DatabaseConfig":
        """Create PostgreSQL configuration"""
        return cls(
            backend=BackendType.POSTGRESQL,
            host=host,
            port=port,
            database=database,
            user=user,
            password=password,
        )


@dataclass
class ConnectionStats:
    """Connection pool statistics"""
    total_connections: int = 0
    active_connections: int = 0
    idle_connections: int = 0
    total_queries: int = 0
    failed_queries: int = 0
    average_query_time_ms: float = 0.0


# ═══════════════════════════════════════════════════════════════════════════
# DATABASE CONNECTION
# ═══════════════════════════════════════════════════════════════════════════

class DatabaseConnection:
    """
    Database connection with support for PostgreSQL and SQLite
    """
    
    def __init__(self, config: DatabaseConfig):
        self.config = config
        self._connection = None
        self._connected = False
        
        # Metrics
        self._query_count = 0
        self._failed_queries = 0
        self._query_times: List[float] = []
    
    async def connect(self) -> bool:
        """Connect to the database"""
        try:
            if self.config.backend == BackendType.SQLITE:
                return await self._connect_sqlite()
            elif self.config.backend == BackendType.POSTGRESQL:
                return await self._connect_postgresql()
            else:
                raise ValueError(f"Unsupported backend: {self.config.backend}")
        except Exception as e:
            logger.error(f"Connection failed: {e}")
            return False
    
    async def _connect_sqlite(self) -> bool:
        """Connect to SQLite"""
        try:
            import aiosqlite
            
            path = self.config.sqlite_path or Path(self.config.database)
            self._connection = await aiosqlite.connect(str(path))
            self._connection.row_factory = aiosqlite.Row
            self._connected = True
            
            # Initialize schema
            schema = create_all_tables(BackendType.SQLITE)
            await self._connection.executescript(schema)
            await self._connection.commit()
            
            logger.info(f"Connected to SQLite: {path}")
            return True
            
        except ImportError:
            logger.warning("aiosqlite not installed, using simulated mode")
            self._connected = True
            return True
        except Exception as e:
            logger.error(f"SQLite connection failed: {e}")
            return False
    
    async def _connect_postgresql(self) -> bool:
        """Connect to PostgreSQL"""
        try:
            import asyncpg
            
            self._connection = await asyncpg.connect(
                host=self.config.host,
                port=self.config.port,
                database=self.config.database,
                user=self.config.user,
                password=self.config.password,
                ssl=self.config.ssl_mode,
                timeout=self.config.connection_timeout,
            )
            self._connected = True
            
            # Initialize schema
            schema = create_all_tables(BackendType.POSTGRESQL)
            await self._connection.execute(schema)
            
            logger.info(f"Connected to PostgreSQL: {self.config.host}:{self.config.port}/{self.config.database}")
            return True
            
        except ImportError:
            logger.warning("asyncpg not installed, using simulated mode")
            self._connected = True
            return True
        except Exception as e:
            logger.error(f"PostgreSQL connection failed: {e}")
            return False
    
    async def execute(self, query: str, params: tuple = ()) -> Any:
        """Execute a query"""
        start_time = time.time()
        self._query_count += 1
        
        try:
            if self._connection is None:
                # Simulated mode
                await asyncio.sleep(0.01)
                return None
            
            if self.config.backend == BackendType.SQLITE:
                cursor = await self._connection.execute(query, params)
                result = await cursor.fetchall()
                await self._connection.commit()
            else:
                result = await self._connection.fetch(query, *params)
            
            elapsed_ms = (time.time() - start_time) * 1000
            self._query_times.append(elapsed_ms)
            
            return result
            
        except Exception as e:
            self._failed_queries += 1
            logger.error(f"Query failed: {e}")
            raise
    
    async def execute_many(self, query: str, params_list: List[tuple]) -> int:
        """Execute many queries"""
        count = 0
        for params in params_list:
            await self.execute(query, params)
            count += 1
        return count
    
    async def fetch_one(self, query: str, params: tuple = ()) -> Optional[Dict[str, Any]]:
        """Fetch one row"""
        result = await self.execute(query, params)
        if result:
            return dict(result[0]) if result[0] else None
        return None
    
    async def fetch_all(self, query: str, params: tuple = ()) -> List[Dict[str, Any]]:
        """Fetch all rows"""
        result = await self.execute(query, params)
        if result:
            return [dict(row) for row in result]
        return []
    
    def get_stats(self) -> ConnectionStats:
        """Get connection statistics"""
        avg_time = sum(self._query_times[-100:]) / len(self._query_times[-100:]) if self._query_times else 0.0
        
        return ConnectionStats(
            total_connections=1 if self._connected else 0,
            active_connections=1 if self._connected else 0,
            idle_connections=0,
            total_queries=self._query_count,
            failed_queries=self._failed_queries,
            average_query_time_ms=avg_time,
        )
    
    async def close(self):
        """Close the connection"""
        if self._connection:
            await self._connection.close()
            self._connection = None
        self._connected = False
        logger.info("Database connection closed")


# ═══════════════════════════════════════════════════════════════════════════
# CONNECTION POOL
# ═══════════════════════════════════════════════════════════════════════════

class ConnectionPool:
    """
    Database connection pool
    """
    
    def __init__(self, config: DatabaseConfig):
        self.config = config
        self._pool: List[DatabaseConnection] = []
        self._available: asyncio.Queue = asyncio.Queue()
        self._lock = asyncio.Lock()
        self._initialized = False
        
        # Metrics
        self._total_acquisitions = 0
        self._total_releases = 0
    
    async def initialize(self) -> bool:
        """Initialize the connection pool"""
        async with self._lock:
            if self._initialized:
                return True
            
            for _ in range(self.config.pool_min_size):
                conn = DatabaseConnection(self.config)
                if await conn.connect():
                    self._pool.append(conn)
                    await self._available.put(conn)
            
            self._initialized = len(self._pool) > 0
            logger.info(f"Connection pool initialized with {len(self._pool)} connections")
            return self._initialized
    
    @asynccontextmanager
    async def acquire(self):
        """Acquire a connection from the pool"""
        if not self._initialized:
            await self.initialize()
        
        self._total_acquisitions += 1
        
        # Try to get from pool
        try:
            conn = await asyncio.wait_for(
                self._available.get(),
                timeout=self.config.connection_timeout
            )
        except asyncio.TimeoutError:
            # Create new connection if pool exhausted and under max
            async with self._lock:
                if len(self._pool) < self.config.pool_max_size:
                    conn = DatabaseConnection(self.config)
                    await conn.connect()
                    self._pool.append(conn)
                else:
                    raise TimeoutError("Connection pool exhausted")
        
        try:
            yield conn
        finally:
            await self._available.put(conn)
            self._total_releases += 1
    
    def get_stats(self) -> ConnectionStats:
        """Get pool statistics"""
        total_queries = sum(c._query_count for c in self._pool)
        failed_queries = sum(c._failed_queries for c in self._pool)
        all_times = [t for c in self._pool for t in c._query_times[-100:]]
        avg_time = sum(all_times) / len(all_times) if all_times else 0.0
        
        return ConnectionStats(
            total_connections=len(self._pool),
            active_connections=len(self._pool) - self._available.qsize(),
            idle_connections=self._available.qsize(),
            total_queries=total_queries,
            failed_queries=failed_queries,
            average_query_time_ms=avg_time,
        )
    
    async def close(self):
        """Close all connections in the pool"""
        for conn in self._pool:
            await conn.close()
        self._pool.clear()
        self._initialized = False
        logger.info("Connection pool closed")


# ═══════════════════════════════════════════════════════════════════════════
# MODULE IDENTITY
# ═══════════════════════════════════════════════════════════════════════════

CONNECTION_IDENTITY = {
    "name": "nova_ovo.storage_layer.connection",
    "protocol": "PROT-520",
    "capabilities": [
        "sqlite_support", "postgresql_support",
        "connection_pooling", "metrics_collection",
    ],
    "primitive_trace": "RELATION → FIELD → φ",
}
