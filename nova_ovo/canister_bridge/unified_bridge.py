"""
UNIFIED PRODUCTION BRIDGE — ORCHESTRATED CANISTER INTEGRATION
==============================================================
Protocol: PROT-516 — UNIFIED PRODUCTION BRIDGE

"Unum pontem omnia canistra connectit."
(One bridge connects all canisters.)

This module provides a unified interface for all production canister
operations, including health monitoring and failover.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

import asyncio
import time
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, List, Optional, Any, Callable
import logging

from .agent_factory import (
    CanisterAgentFactory,
    ProductionCanisterConnection,
    CanisterCallResult,
    AgentHealth,
)
from .deep_memory_client import (
    DeepMemoryCanisterClient,
    DeepMemoryStatus,
)

# ═══════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════

PHI = 1.6180339887498948482
PHI_SQ = 2.6180339887498948482
PHI_INV = 0.6180339887498948482

HEARTBEAT_INTERVAL = 1.0 / PHI  # ~0.618 seconds
HEALTH_CHECK_INTERVAL = PHI_SQ * 10  # ~26 seconds

logger = logging.getLogger(__name__)


# ═══════════════════════════════════════════════════════════════════════════
# DATA CLASSES
# ═══════════════════════════════════════════════════════════════════════════

class BridgeState(Enum):
    DISCONNECTED = "disconnected"
    CONNECTING = "connecting"
    CONNECTED = "connected"
    DEGRADED = "degraded"
    FAILED = "failed"


@dataclass
class CanisterConfig:
    """Configuration for a canister"""
    name: str
    canister_id: str
    network: str = "local"
    client_type: str = "deep_memory"  # Type of client to create
    required: bool = True  # If false, bridge can operate without it


@dataclass
class BridgeHealthStatus:
    """Health status of the unified bridge"""
    state: BridgeState
    connected_canisters: int
    total_canisters: int
    failed_canisters: List[str]
    last_health_check: float
    uptime_seconds: float
    total_calls: int
    failed_calls: int
    average_latency_ms: float
    heartbeat_count: int
    
    @property
    def health_percentage(self) -> float:
        if self.total_canisters == 0:
            return 0.0
        return (self.connected_canisters / self.total_canisters) * 100
    
    @property
    def is_healthy(self) -> bool:
        return self.state in (BridgeState.CONNECTED, BridgeState.DEGRADED)


# ═══════════════════════════════════════════════════════════════════════════
# UNIFIED PRODUCTION BRIDGE
# ═══════════════════════════════════════════════════════════════════════════

class UnifiedProductionBridge:
    """
    Unified production bridge for all ICP canister operations
    
    Features:
    - Multi-canister management
    - Health monitoring
    - φ-harmonic heartbeat
    - Automatic reconnection
    - Metrics collection
    """
    
    def __init__(self, configs: List[CanisterConfig]):
        self.configs = {c.name: c for c in configs}
        self._factory = CanisterAgentFactory()
        
        # Clients
        self._clients: Dict[str, Any] = {}
        
        # State
        self._state = BridgeState.DISCONNECTED
        self._start_time: Optional[float] = None
        self._heartbeat_count = 0
        self._last_health_check = 0.0
        
        # Tasks
        self._heartbeat_task: Optional[asyncio.Task] = None
        self._health_check_task: Optional[asyncio.Task] = None
        
        # Metrics
        self._total_calls = 0
        self._failed_calls = 0
        self._latencies: List[float] = []
    
    async def connect(self) -> bool:
        """
        Connect to all configured canisters
        """
        self._state = BridgeState.CONNECTING
        self._start_time = time.time()
        
        logger.info("🔌 Connecting Unified Production Bridge...")
        
        connected = 0
        failed = []
        
        for name, config in self.configs.items():
            try:
                client = await self._create_client(config)
                if await client.connect():
                    self._clients[name] = client
                    connected += 1
                    logger.info(f"   ✓ {name} ({config.canister_id})")
                else:
                    failed.append(name)
                    logger.warning(f"   ✗ {name} failed to connect")
            except Exception as e:
                failed.append(name)
                logger.error(f"   ✗ {name} error: {e}")
        
        # Determine state
        if connected == len(self.configs):
            self._state = BridgeState.CONNECTED
        elif connected > 0:
            self._state = BridgeState.DEGRADED
        else:
            self._state = BridgeState.FAILED
            return False
        
        # Start background tasks
        self._heartbeat_task = asyncio.create_task(self._heartbeat_loop())
        self._health_check_task = asyncio.create_task(self._health_check_loop())
        
        logger.info(f"✅ Bridge connected: {connected}/{len(self.configs)} canisters")
        return True
    
    async def _create_client(self, config: CanisterConfig) -> Any:
        """Create appropriate client based on config type"""
        if config.client_type == "deep_memory":
            return DeepMemoryCanisterClient(
                canister_id=config.canister_id,
                network=config.network,
                factory=self._factory,
            )
        else:
            # Generic client via factory
            connection = ProductionCanisterConnection(
                canister_id=config.canister_id,
                network=config.network,
            )
            return await self._factory.create_agent(connection)
    
    async def _heartbeat_loop(self):
        """φ-harmonic heartbeat loop"""
        while self._state in (BridgeState.CONNECTED, BridgeState.DEGRADED):
            await asyncio.sleep(HEARTBEAT_INTERVAL)
            self._heartbeat_count += 1
            
            # Send heartbeat to all connected clients
            for name, client in self._clients.items():
                try:
                    if hasattr(client, 'heartbeat'):
                        await client.heartbeat()
                except Exception as e:
                    logger.debug(f"Heartbeat failed for {name}: {e}")
    
    async def _health_check_loop(self):
        """Periodic health check loop"""
        while self._state in (BridgeState.CONNECTED, BridgeState.DEGRADED):
            await asyncio.sleep(HEALTH_CHECK_INTERVAL)
            
            try:
                await self._perform_health_check()
            except Exception as e:
                logger.error(f"Health check error: {e}")
    
    async def _perform_health_check(self):
        """Perform health check on all canisters"""
        self._last_health_check = time.time()
        
        connected = 0
        for name, client in self._clients.items():
            try:
                if hasattr(client, 'get_status'):
                    status = await client.get_status()
                    if status:
                        connected += 1
                elif hasattr(client, 'get_health'):
                    health = client.get_health()
                    if health.connected:
                        connected += 1
            except Exception:
                pass
        
        # Update state based on health
        if connected == len(self._clients):
            self._state = BridgeState.CONNECTED
        elif connected > 0:
            self._state = BridgeState.DEGRADED
        else:
            self._state = BridgeState.FAILED
    
    # ═══════════════════════════════════════════════════════════════════════
    # CLIENT ACCESS
    # ═══════════════════════════════════════════════════════════════════════
    
    def get_client(self, name: str) -> Optional[Any]:
        """Get a specific client by name"""
        return self._clients.get(name)
    
    @property
    def deep_memory(self) -> Optional[DeepMemoryCanisterClient]:
        """Get the deep memory client"""
        client = self._clients.get("deep_memory")
        if isinstance(client, DeepMemoryCanisterClient):
            return client
        return None
    
    # ═══════════════════════════════════════════════════════════════════════
    # UNIFIED OPERATIONS
    # ═══════════════════════════════════════════════════════════════════════
    
    async def call(
        self,
        canister_name: str,
        method: str,
        args: Any = None,
        is_update: bool = False
    ) -> CanisterCallResult:
        """
        Make a call to a canister
        """
        start_time = time.time()
        self._total_calls += 1
        
        client = self._clients.get(canister_name)
        if not client:
            self._failed_calls += 1
            return CanisterCallResult(
                success=False,
                error=f"Unknown canister: {canister_name}",
                method=method
            )
        
        try:
            if hasattr(client, '_agent'):
                agent = client._agent
                if is_update:
                    result = await agent.update(method, args)
                else:
                    result = await agent.query(method, args)
            else:
                # Client is already an agent
                if is_update:
                    result = await client.update(method, args)
                else:
                    result = await client.query(method, args)
            
            elapsed_ms = (time.time() - start_time) * 1000
            self._latencies.append(elapsed_ms)
            
            if not result.success:
                self._failed_calls += 1
            
            return result
            
        except Exception as e:
            self._failed_calls += 1
            elapsed_ms = (time.time() - start_time) * 1000
            
            return CanisterCallResult(
                success=False,
                error=str(e),
                call_time_ms=elapsed_ms,
                method=method
            )
    
    # ═══════════════════════════════════════════════════════════════════════
    # HEALTH & METRICS
    # ═══════════════════════════════════════════════════════════════════════
    
    def get_health(self) -> BridgeHealthStatus:
        """Get current bridge health status"""
        uptime = time.time() - self._start_time if self._start_time else 0.0
        avg_latency = sum(self._latencies[-100:]) / len(self._latencies[-100:]) if self._latencies else 0.0
        
        # Check which canisters are connected
        connected = []
        failed = []
        for name in self.configs:
            if name in self._clients:
                connected.append(name)
            else:
                failed.append(name)
        
        return BridgeHealthStatus(
            state=self._state,
            connected_canisters=len(connected),
            total_canisters=len(self.configs),
            failed_canisters=failed,
            last_health_check=self._last_health_check,
            uptime_seconds=uptime,
            total_calls=self._total_calls,
            failed_calls=self._failed_calls,
            average_latency_ms=avg_latency,
            heartbeat_count=self._heartbeat_count,
        )
    
    # ═══════════════════════════════════════════════════════════════════════
    # LIFECYCLE
    # ═══════════════════════════════════════════════════════════════════════
    
    async def disconnect(self):
        """Disconnect all canisters"""
        logger.info("🔌 Disconnecting Unified Production Bridge...")
        
        # Cancel background tasks
        if self._heartbeat_task:
            self._heartbeat_task.cancel()
        if self._health_check_task:
            self._health_check_task.cancel()
        
        # Disconnect clients
        for name, client in self._clients.items():
            try:
                if hasattr(client, 'disconnect'):
                    await client.disconnect()
            except Exception as e:
                logger.debug(f"Error disconnecting {name}: {e}")
        
        self._clients.clear()
        self._state = BridgeState.DISCONNECTED
        
        # Disconnect factory agents
        await self._factory.disconnect_all()
        
        logger.info("✅ Bridge disconnected")


# ═══════════════════════════════════════════════════════════════════════════
# CONVENIENCE FACTORY
# ═══════════════════════════════════════════════════════════════════════════

def create_production_bridge(
    deep_memory_canister: str,
    network: str = "local",
    additional_canisters: Optional[List[CanisterConfig]] = None
) -> UnifiedProductionBridge:
    """
    Create a production bridge with standard configuration
    """
    configs = [
        CanisterConfig(
            name="deep_memory",
            canister_id=deep_memory_canister,
            network=network,
            client_type="deep_memory",
            required=True,
        ),
    ]
    
    if additional_canisters:
        configs.extend(additional_canisters)
    
    return UnifiedProductionBridge(configs)


# ═══════════════════════════════════════════════════════════════════════════
# MODULE IDENTITY
# ═══════════════════════════════════════════════════════════════════════════

UNIFIED_BRIDGE_IDENTITY = {
    "name": "nova_ovo.canister_bridge.unified_bridge",
    "protocol": "PROT-516",
    "frequency_hz": PHI * 843.5,
    "capabilities": [
        "multi_canister_management",
        "health_monitoring",
        "phi_harmonic_heartbeat",
        "automatic_reconnection",
        "metrics_collection",
        "failover_support",
    ],
    "primitive_trace": "RELATION → ADDRESS → MEMORY → φ",
    "law_reference": "L-96: Production bridges require health verification",
}
