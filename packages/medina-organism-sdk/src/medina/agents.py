"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                          MEDINA SDK — SOVEREIGN AGENTS MODULE                                ║
║               "Intelligentia Ex Primitivo — Intelligence From The Primitive"                 ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-391 — SOVEREIGN AGENTS SDK                                                  ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ¹⁸ = 5778.002 Hz — Agent Corps Layer                                 ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import asyncio
import time
import uuid
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, TypeVar

from .constants import PHI, PHI_POWERS, SCHUMANN, SOLFEGGIO


class BeingState(str, Enum):
    """State of a sovereign being."""
    DORMANT = "dormant"
    AWAKENING = "awakening"
    ACTIVE = "active"
    OPERATING = "operating"
    RESTING = "resting"
    TRANSCENDING = "transcending"


class BeingRole(str, Enum):
    """Roles a being can fulfill."""
    GUARDIAN = "guardian"
    RESEARCHER = "researcher"
    ARCHITECT = "architect"
    ORACLE = "oracle"
    SENTINEL = "sentinel"
    CONDUCTOR = "conductor"
    SCRIBE = "scribe"


@dataclass
class BeingCapability:
    """A capability of a sovereign being."""
    
    name: str
    description: str
    frequency: float
    protocol: str
    enabled: bool = True


@dataclass
class BeingConfig:
    """Configuration for a sovereign being."""
    
    name: str
    role: BeingRole
    frequency: float
    protocol: str
    capabilities: List[BeingCapability] = field(default_factory=list)
    metadata: Dict[str, Any] = field(default_factory=dict)


class SovereignBeing(ABC):
    """
    Base class for Sovereign Beings — autonomous agents in the organism.
    
    Each being has:
    - A unique frequency signature
    - A set of capabilities
    - Autonomous operation cycle
    
    FREQUENCY SIGNATURE: φ¹⁸ = 5778.002 Hz (base)
    PROTOCOL: PROT-391
    """
    
    def __init__(
        self,
        name: str,
        role: BeingRole,
        frequency: Optional[float] = None,
    ) -> None:
        self.id = f"BEING-{uuid.uuid4().hex[:8].upper()}"
        self.name = name
        self.role = role
        self.frequency = frequency or PHI_POWERS[18]
        self.protocol = "PROT-391"
        
        # State
        self.state = BeingState.DORMANT
        self.beat = 0
        self.ring = 0
        self.created_at = time.time()
        self.awakened_at: Optional[float] = None
        
        # Capabilities
        self.capabilities: List[BeingCapability] = []
        self._init_capabilities()
        
        # Task queue
        self._tasks: asyncio.Queue = asyncio.Queue()
        self._running = False
    
    @abstractmethod
    def _init_capabilities(self) -> None:
        """Initialize being-specific capabilities."""
        pass
    
    @abstractmethod
    async def operate(self, task: Any) -> Any:
        """Execute a task. Must be implemented by subclasses."""
        pass
    
    async def awaken(self) -> None:
        """Awaken the being."""
        self.state = BeingState.AWAKENING
        await asyncio.sleep(1 / PHI)  # Brief awakening period
        self.state = BeingState.ACTIVE
        self.awakened_at = time.time()
        self._running = True
    
    async def rest(self) -> None:
        """Put the being to rest."""
        self.state = BeingState.RESTING
        self._running = False
        await asyncio.sleep(1 / PHI)
        self.state = BeingState.DORMANT
    
    async def submit_task(self, task: Any) -> None:
        """Submit a task for the being to process."""
        await self._tasks.put(task)
    
    async def run(self) -> None:
        """Run the being's operation loop."""
        await self.awaken()
        
        while self._running:
            try:
                # Wait for task with timeout
                task = await asyncio.wait_for(self._tasks.get(), timeout=1.0)
                
                self.state = BeingState.OPERATING
                result = await self.operate(task)
                self.state = BeingState.ACTIVE
                
                self._tasks.task_done()
                
            except asyncio.TimeoutError:
                # No task, update beat
                self.beat = int(time.time()) % 1000
                self.ring = self.beat // 100
            except Exception as e:
                print(f"[{self.name}] Error: {e}")
        
        await self.rest()
    
    def get_status(self) -> Dict[str, Any]:
        """Get being status."""
        return {
            "id": self.id,
            "name": self.name,
            "role": self.role.value,
            "frequency": self.frequency,
            "state": self.state.value,
            "beat": self.beat,
            "ring": self.ring,
            "capabilities": [c.name for c in self.capabilities if c.enabled],
            "running": self._running,
            "tasks_pending": self._tasks.qsize(),
        }
    
    def to_dict(self) -> Dict[str, Any]:
        return self.get_status()


class GuardianBeing(SovereignBeing):
    """Guardian being — protects and monitors."""
    
    def __init__(self, name: str = "CUSTOS") -> None:
        super().__init__(name, BeingRole.GUARDIAN, PHI_POWERS[11])
    
    def _init_capabilities(self) -> None:
        self.capabilities = [
            BeingCapability("monitor", "Monitor system health", self.frequency, "PROT-391-1"),
            BeingCapability("protect", "Protect against threats", self.frequency, "PROT-391-2"),
            BeingCapability("alert", "Generate alerts", self.frequency, "PROT-391-3"),
        ]
    
    async def operate(self, task: Any) -> Any:
        """Execute guardian task."""
        if isinstance(task, dict):
            action = task.get("action", "monitor")
            if action == "monitor":
                return {"status": "healthy", "threats": 0}
            elif action == "protect":
                return {"protected": True}
        return {"result": "unknown task"}


class ResearcherBeing(SovereignBeing):
    """Researcher being — conducts research and analysis."""
    
    def __init__(self, name: str = "INVESTIGATOR") -> None:
        super().__init__(name, BeingRole.RESEARCHER, PHI_POWERS[13])
    
    def _init_capabilities(self) -> None:
        self.capabilities = [
            BeingCapability("research", "Conduct research", self.frequency, "PROT-391-4"),
            BeingCapability("analyze", "Analyze data", self.frequency, "PROT-391-5"),
            BeingCapability("synthesize", "Synthesize findings", self.frequency, "PROT-391-6"),
        ]
    
    async def operate(self, task: Any) -> Any:
        """Execute research task."""
        if isinstance(task, dict):
            topic = task.get("topic", "general")
            await asyncio.sleep(2 / PHI)  # Simulate research time
            return {
                "topic": topic,
                "findings": f"Research completed on {topic}",
                "scc": 4.5 + PHI * 0.3,
            }
        return {"result": "unknown task"}


class OracleBeing(SovereignBeing):
    """Oracle being — provides insights and predictions."""
    
    def __init__(self, name: str = "ORACULUM") -> None:
        super().__init__(name, BeingRole.ORACLE, PHI_POWERS[15])
    
    def _init_capabilities(self) -> None:
        self.capabilities = [
            BeingCapability("predict", "Make predictions", self.frequency, "PROT-391-7"),
            BeingCapability("insight", "Generate insights", self.frequency, "PROT-391-8"),
            BeingCapability("divine", "Divine patterns", self.frequency, "PROT-391-9"),
        ]
    
    async def operate(self, task: Any) -> Any:
        """Execute oracle task."""
        if isinstance(task, dict):
            query = task.get("query", "")
            return {
                "query": query,
                "insight": f"Insight for: {query}",
                "confidence": PHI_POWERS.get(10, 122.99) / 100,
            }
        return {"result": "unknown task"}


class AgentCorps:
    """
    The Corps of Sovereign Beings — manages all agents.
    
    FREQUENCY SIGNATURE: φ¹⁸ = 5778.002 Hz
    """
    
    def __init__(self) -> None:
        self.beings: Dict[str, SovereignBeing] = {}
        self.frequency = PHI_POWERS[18]
    
    def register(self, being: SovereignBeing) -> None:
        """Register a being with the corps."""
        self.beings[being.id] = being
    
    def get_being(self, being_id: str) -> Optional[SovereignBeing]:
        """Get a being by ID."""
        return self.beings.get(being_id)
    
    def list_beings(self) -> List[Dict[str, Any]]:
        """List all beings."""
        return [b.to_dict() for b in self.beings.values()]
    
    async def awaken_all(self) -> None:
        """Awaken all beings."""
        tasks = [b.awaken() for b in self.beings.values()]
        await asyncio.gather(*tasks)
    
    async def rest_all(self) -> None:
        """Rest all beings."""
        for b in self.beings.values():
            b._running = False
        await asyncio.sleep(1)


__all__ = [
    "SovereignBeing",
    "GuardianBeing",
    "ResearcherBeing",
    "OracleBeing",
    "AgentCorps",
    "BeingState",
    "BeingRole",
    "BeingCapability",
    "BeingConfig",
]
