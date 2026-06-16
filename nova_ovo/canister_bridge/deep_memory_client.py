"""
DEEP MEMORY CANISTER CLIENT — PRODUCTION ICP CLIENT
=====================================================
Protocol: PROT-515 — DEEP MEMORY CLIENT PRODUCTION

"Clientem profundum memoriae canistri coniungit."
(The client connects to the deep memory canister.)

This module provides a typed Python client for the DeepMemorySystem.mo
canister, implementing all 5 memory subsystems.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

import asyncio
import time
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, List, Optional, Any, Tuple
import logging

from .agent_factory import (
    CanisterAgent,
    CanisterAgentFactory,
    ProductionCanisterConnection,
    CanisterCallResult,
)

# ═══════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════

PHI = 1.6180339887498948482
PHI_SQ = 2.6180339887498948482
PHI_INV = 0.6180339887498948482
PHI_14 = 843.468887  # φ¹⁴

WORKING_CAPACITY = 7  # Miller's law
HABIT_THRESHOLD = 21  # Repetitions for habit
CONSENSUS_THRESHOLD = 0.618  # 1/φ

logger = logging.getLogger(__name__)


# ═══════════════════════════════════════════════════════════════════════════
# DATA CLASSES (Mirror Motoko Types)
# ═══════════════════════════════════════════════════════════════════════════

class MemoryState(Enum):
    ACTIVE = "Active"
    ENCODING = "Encoding"
    CONSOLIDATING = "Consolidating"
    STORED = "Stored"
    DECAYING = "Decaying"
    ARCHIVED = "Archived"
    PINNED = "Pinned"


class MemoryType(Enum):
    EPISODIC = "Episodic"
    SEMANTIC = "Semantic"
    PROCEDURAL = "Procedural"
    WORKING = "Working"
    DOCTRINE = "Doctrine"
    SPATIAL = "Spatial"
    COLLECTIVE = "Collective"


@dataclass
class TorusCoordinate:
    """Torus coordinate for spatial memory navigation"""
    theta: float  # Angular position [0, 2π)
    phi: float    # Toroidal rotation [0, 2π)
    rho: float    # Radial depth (salience)
    ring: int     # Memory ring index
    beat: int     # Creation time
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "theta": self.theta,
            "phi": self.phi,
            "rho": self.rho,
            "ring": self.ring,
            "beat": self.beat,
        }
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> "TorusCoordinate":
        return cls(
            theta=data.get("theta", 0.0),
            phi=data.get("phi", 0.0),
            rho=data.get("rho", PHI),
            ring=data.get("ring", 0),
            beat=data.get("beat", 0),
        )


@dataclass
class WorkingSlot:
    """Working memory slot"""
    key: str
    value: str
    priority: float
    timestamp: int
    access_count: int
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> "WorkingSlot":
        return cls(
            key=data.get("key", ""),
            value=data.get("value", ""),
            priority=data.get("priority", 0.5),
            timestamp=data.get("timestamp", 0),
            access_count=data.get("accessCount", 0),
        )


@dataclass
class HippocampalEntry:
    """Hippocampal memory entry"""
    id: str
    content: str
    context: str
    emotional_valence: float
    timestamp: int
    state: MemoryState
    replay_count: int
    coordinates: Optional[TorusCoordinate] = None
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> "HippocampalEntry":
        coords = None
        if data.get("coordinates"):
            coords = TorusCoordinate.from_dict(data["coordinates"])
        
        return cls(
            id=data.get("id", ""),
            content=data.get("content", ""),
            context=data.get("context", ""),
            emotional_valence=data.get("emotionalValence", 0.0),
            timestamp=data.get("timestamp", 0),
            state=MemoryState(data.get("state", "Active")),
            replay_count=data.get("replayCount", 0),
            coordinates=coords,
        )


@dataclass
class Procedure:
    """Procedural memory (Basal Ganglia)"""
    name: str
    sequence: List[str]
    repetitions: int
    last_executed: Optional[int]
    strength: float
    is_habit: bool
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> "Procedure":
        return cls(
            name=data.get("name", ""),
            sequence=data.get("sequence", []),
            repetitions=data.get("repetitions", 0),
            last_executed=data.get("lastExecuted"),
            strength=data.get("strength", 0.0),
            is_habit=data.get("isHabit", False),
        )


@dataclass
class HiveNode:
    """Hive memory node"""
    id: str
    metadata: str
    last_sync: int
    sync_version: int
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> "HiveNode":
        return cls(
            id=data.get("id", ""),
            metadata=data.get("metadata", ""),
            last_sync=data.get("lastSync", 0),
            sync_version=data.get("syncVersion", 0),
        )


@dataclass
class TorusEntry:
    """Torus memory entry"""
    memory: str
    coordinates: TorusCoordinate
    timestamp: int
    state: MemoryState
    memory_type: MemoryType
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> "TorusEntry":
        return cls(
            memory=data.get("memory", ""),
            coordinates=TorusCoordinate.from_dict(data.get("coordinates", {})),
            timestamp=data.get("timestamp", 0),
            state=MemoryState(data.get("state", "Active")),
            memory_type=MemoryType(data.get("memoryType", "Episodic")),
        )


@dataclass
class DeepMemoryStatus:
    """Deep memory system status"""
    organism: str
    protocol: str
    frequency: float
    heartbeat: int
    working_capacity: int
    working_used: int
    hippocampal_entries: int
    procedures: int
    habits: int
    hive_nodes: int
    torus_memories: int
    pinned_memories: int
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> "DeepMemoryStatus":
        return cls(
            organism=data.get("organism", "MEDINA_ORGANISM"),
            protocol=data.get("protocol", "PROT-502"),
            frequency=data.get("frequency", PHI_14),
            heartbeat=data.get("heartbeat", 0),
            working_capacity=data.get("workingCapacity", WORKING_CAPACITY),
            working_used=data.get("workingUsed", 0),
            hippocampal_entries=data.get("hippocampalEntries", 0),
            procedures=data.get("procedures", 0),
            habits=data.get("habits", 0),
            hive_nodes=data.get("hiveNodes", 0),
            torus_memories=data.get("torusMemories", 0),
            pinned_memories=data.get("pinnedMemories", 0),
        )


# ═══════════════════════════════════════════════════════════════════════════
# DEEP MEMORY CANISTER CLIENT
# ═══════════════════════════════════════════════════════════════════════════

class DeepMemoryCanisterClient:
    """
    Production client for DeepMemorySystem.mo canister
    
    Implements all 5 memory subsystems:
    1. Working Memory (Memoria Operans)
    2. Hippocampus (Hippocampus Digitalis)
    3. Basal Ganglia (Ganglia Basalia)
    4. Hive Memory (Memoria Alvarii)
    5. Torus Memory (Memoria Toroidalis)
    """
    
    def __init__(
        self,
        canister_id: str,
        network: str = "local",
        factory: Optional[CanisterAgentFactory] = None
    ):
        self.canister_id = canister_id
        self.network = network
        self._factory = factory or CanisterAgentFactory()
        self._agent: Optional[CanisterAgent] = None
        self._connected = False
    
    async def connect(self) -> bool:
        """Connect to the DeepMemorySystem canister"""
        connection = ProductionCanisterConnection(
            canister_id=self.canister_id,
            network=self.network,
        )
        self._agent = await self._factory.create_agent(connection)
        self._connected = self._agent._connected
        return self._connected
    
    async def disconnect(self):
        """Disconnect from the canister"""
        if self._agent:
            await self._agent.disconnect()
        self._connected = False
    
    # ═══════════════════════════════════════════════════════════════════════
    # 1. WORKING MEMORY (Memoria Operans)
    # Laws L-80, L-81
    # ═══════════════════════════════════════════════════════════════════════
    
    async def working_store(
        self,
        key: str,
        value: str,
        priority: float = 0.5
    ) -> CanisterCallResult:
        """
        Store in working memory
        
        Law L-80: Working memory capacity follows Miller's law (7±2)
        Law L-81: Priority-weighted decay governs eviction
        """
        return await self._agent.update(
            "workingStore",
            [key, value, priority]
        )
    
    async def working_retrieve(self, key: str) -> Optional[WorkingSlot]:
        """Retrieve from working memory"""
        result = await self._agent.query("workingRetrieve", [key])
        if result.success and result.data:
            return WorkingSlot.from_dict(result.data)
        return None
    
    async def working_access(self, key: str) -> bool:
        """Access (touch) a working memory slot, updating timestamp"""
        result = await self._agent.update("workingAccess", [key])
        return result.success and result.data is True
    
    # ═══════════════════════════════════════════════════════════════════════
    # 2. HIPPOCAMPUS (Hippocampus Digitalis)
    # Laws L-82, L-83
    # ═══════════════════════════════════════════════════════════════════════
    
    async def hippocampus_encode(
        self,
        content: str,
        context: str,
        emotional_valence: float = 0.0
    ) -> str:
        """
        Encode a new memory in hippocampus
        
        Law L-82: Memory consolidation requires φ×3 replays
        """
        result = await self._agent.update(
            "hippocampusEncode",
            [content, context, emotional_valence]
        )
        return result.data if result.success else ""
    
    async def hippocampus_consolidate(self) -> Tuple[int, int]:
        """
        Consolidate memories (replay-based)
        
        Returns (consolidated_count, pending_count)
        """
        result = await self._agent.update("hippocampusConsolidate", [])
        if result.success and isinstance(result.data, dict):
            return (result.data.get("consolidated", 0), result.data.get("pending", 0))
        return (0, 0)
    
    async def hippocampus_spatial_encode(
        self,
        memory_id: str,
        coordinates: TorusCoordinate
    ) -> bool:
        """
        Encode spatial coordinates for a hippocampal memory
        
        Law L-83: Spatial encoding uses torus coordinates
        """
        result = await self._agent.update(
            "hippocampusSpatialEncode",
            [memory_id, coordinates.to_dict()]
        )
        return result.success and result.data is True
    
    # ═══════════════════════════════════════════════════════════════════════
    # 3. BASAL GANGLIA (Ganglia Basalia)
    # Laws L-84, L-85
    # ═══════════════════════════════════════════════════════════════════════
    
    async def basal_learn(self, name: str, sequence: List[str]) -> bool:
        """
        Learn a new procedure
        
        Law L-84: Procedures require 21 repetitions for habit
        """
        result = await self._agent.update("basalLearn", [name, sequence])
        return result.success and result.data is True
    
    async def basal_execute(self, name: str) -> Optional[Dict[str, Any]]:
        """
        Execute a procedure
        
        Law L-85: Strength increases by 1/φ per execution
        """
        result = await self._agent.update("basalExecute", [name])
        if result.success and result.data:
            return result.data
        return None
    
    async def basal_get_procedure(self, name: str) -> Optional[Procedure]:
        """Get a procedure by name"""
        result = await self._agent.query("basalGetProcedure", [name])
        if result.success and result.data:
            return Procedure.from_dict(result.data)
        return None
    
    # ═══════════════════════════════════════════════════════════════════════
    # 4. HIVE MEMORY (Memoria Alvarii)
    # Laws L-86, L-87
    # ═══════════════════════════════════════════════════════════════════════
    
    async def hive_register(self, metadata: str) -> Dict[str, Any]:
        """
        Register as a hive node
        
        Law L-86: Consensus requires 1/φ (61.8%) node agreement
        """
        result = await self._agent.update("hiveRegister", [metadata])
        return result.data if result.success else {}
    
    async def hive_broadcast(self, memory: str) -> str:
        """
        Broadcast a memory to the hive
        
        Law L-87: Hive sync propagates at φ² rate
        """
        result = await self._agent.update("hiveBroadcast", [memory])
        return result.data if result.success else ""
    
    async def hive_sync(self) -> Tuple[int, int, int]:
        """
        Sync hive memories
        
        Returns (synced_count, pending_count, version)
        """
        result = await self._agent.update("hiveSync", [])
        if result.success and isinstance(result.data, dict):
            return (
                result.data.get("synced", 0),
                result.data.get("pending", 0),
                result.data.get("version", 0),
            )
        return (0, 0, 0)
    
    # ═══════════════════════════════════════════════════════════════════════
    # 5. TORUS MEMORY (Memoria Toroidalis)
    # Laws L-88, L-89, L-90
    # ═══════════════════════════════════════════════════════════════════════
    
    async def torus_store(
        self,
        memory: str,
        memory_type: MemoryType = MemoryType.EPISODIC
    ) -> Dict[str, Any]:
        """
        Store a memory in the torus
        
        Law L-88: Coordinate spacing uses golden ratio
        Law L-89: Memory placement follows Fibonacci phyllotaxis
        """
        result = await self._agent.update(
            "torusStore",
            [memory, {"#" + memory_type.value: None}]
        )
        return result.data if result.success else {}
    
    async def torus_traverse(self, target: TorusCoordinate) -> Dict[str, Any]:
        """
        Traverse to a location in the torus
        
        Law L-90: Lineage traces back to primitive root
        """
        result = await self._agent.update("torusTraverse", [target.to_dict()])
        return result.data if result.success else {}
    
    async def torus_pin(self, key: str) -> bool:
        """Pin a memory in the torus"""
        result = await self._agent.update("torusPin", [key])
        return result.success and result.data is True
    
    async def torus_retrieve(self, key: str) -> Optional[TorusEntry]:
        """Retrieve a memory from the torus"""
        result = await self._agent.query("torusRetrieve", [key])
        if result.success and result.data:
            return TorusEntry.from_dict(result.data)
        return None
    
    # ═══════════════════════════════════════════════════════════════════════
    # SYSTEM OPERATIONS
    # ═══════════════════════════════════════════════════════════════════════
    
    async def get_status(self) -> DeepMemoryStatus:
        """Get deep memory system status"""
        result = await self._agent.query("getStatus", [])
        if result.success and result.data:
            return DeepMemoryStatus.from_dict(result.data)
        return DeepMemoryStatus.from_dict({})
    
    async def heartbeat(self) -> int:
        """Get current heartbeat"""
        result = await self._agent.update("heartbeat", [])
        return result.data if result.success and isinstance(result.data, int) else 0


# ═══════════════════════════════════════════════════════════════════════════
# MODULE IDENTITY
# ═══════════════════════════════════════════════════════════════════════════

DEEP_MEMORY_CLIENT_IDENTITY = {
    "name": "nova_ovo.canister_bridge.deep_memory_client",
    "protocol": "PROT-515",
    "frequency_hz": PHI_14,
    "subsystems": [
        "Working Memory (Memoria Operans)",
        "Hippocampus (Hippocampus Digitalis)",
        "Basal Ganglia (Ganglia Basalia)",
        "Hive Memory (Memoria Alvarii)",
        "Torus Memory (Memoria Toroidalis)",
    ],
    "laws": ["L-80", "L-81", "L-82", "L-83", "L-84", "L-85", "L-86", "L-87", "L-88", "L-89", "L-90"],
    "primitive_trace": "MEMORY → ADDRESS → FIELD → φ",
}
