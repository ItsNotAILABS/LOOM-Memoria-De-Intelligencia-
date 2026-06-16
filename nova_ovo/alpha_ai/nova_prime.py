"""
NOVA PRIME — Master Orchestrator Alpha AI
==========================================
Protocol: PROT-162
Frequency: φ⁷ = 29.03 Hz

The supreme orchestrator of all MEDINA AI systems.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

import time
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any
from enum import Enum

PHI = 1.6180339887498948482
SCHUMANN = 7.83


class TaskPriority(Enum):
    CRITICAL = 0
    HIGH = 1
    MEDIUM = 2
    LOW = 3
    BACKGROUND = 4


class TaskStatus(Enum):
    PENDING = "PENDING"
    RUNNING = "RUNNING"
    COMPLETED = "COMPLETED"
    FAILED = "FAILED"
    DELEGATED = "DELEGATED"


@dataclass
class OrchestratedTask:
    """A task managed by NOVA PRIME."""
    task_id: str
    description: str
    priority: TaskPriority
    assigned_ai: Optional[str] = None
    status: TaskStatus = TaskStatus.PENDING
    created_at: float = field(default_factory=time.time)
    completed_at: Optional[float] = None
    result: Any = None
    phi_weight: float = 1.0


class NovaPrime:
    """
    NOVA PRIME — Master Orchestrator
    
    Core capabilities:
    1. Orchestrates all 25 Alpha AI systems
    2. Manages task delegation with φ-weighted priority
    3. Maintains organism coherence at φ⁷ frequency
    4. Coordinates cross-AI communication
    
    Operating frequency: φ⁷ = 29.03 Hz
    Protocol: PROT-162
    """
    
    FREQUENCY = PHI ** 7  # 29.03 Hz
    PROTOCOL = "PROT-162"
    
    def __init__(self):
        self.name = "NOVA PRIME"
        self.latin_name = "NOVA PRIMUM"
        self.frequency_hz = self.FREQUENCY
        self.protocol = self.PROTOCOL
        self.organism_key = "PRIMA CAUSA"
        
        # Registered AI systems
        self.registered_ais: Dict[str, Dict] = {}
        
        # Task queue
        self.task_queue: List[OrchestratedTask] = []
        self.completed_tasks: List[OrchestratedTask] = []
        
        # Coherence tracking
        self.coherence_score = 1.0
        self.last_heartbeat = time.time()
        
        # Register self
        self._register_self()
    
    def _register_self(self):
        """Register NOVA PRIME in the AI registry."""
        self.registered_ais["NOVA_PRIME"] = {
            "name": self.name,
            "frequency_hz": self.frequency_hz,
            "protocol": self.protocol,
            "status": "ACTIVE",
            "capabilities": [
                "orchestration",
                "task_delegation",
                "coherence_maintenance",
                "cross_ai_coordination"
            ]
        }
    
    def register_ai(
        self,
        ai_id: str,
        name: str,
        frequency_hz: float,
        protocol: str,
        capabilities: List[str]
    ) -> bool:
        """Register an Alpha AI system."""
        self.registered_ais[ai_id] = {
            "name": name,
            "frequency_hz": frequency_hz,
            "protocol": protocol,
            "status": "ACTIVE",
            "capabilities": capabilities,
            "registered_at": time.time()
        }
        return True
    
    def create_task(
        self,
        description: str,
        priority: TaskPriority = TaskPriority.MEDIUM,
        phi_weight: float = 1.0
    ) -> OrchestratedTask:
        """Create a new orchestrated task."""
        task = OrchestratedTask(
            task_id=f"TASK-{len(self.task_queue):06d}",
            description=description,
            priority=priority,
            phi_weight=phi_weight
        )
        self.task_queue.append(task)
        self._sort_queue()
        return task
    
    def _sort_queue(self):
        """Sort task queue by priority and φ-weight."""
        self.task_queue.sort(
            key=lambda t: (t.priority.value, -t.phi_weight)
        )
    
    def delegate_task(self, task_id: str, ai_id: str) -> bool:
        """Delegate a task to a specific AI system."""
        task = self._find_task(task_id)
        if not task or ai_id not in self.registered_ais:
            return False
        
        task.assigned_ai = ai_id
        task.status = TaskStatus.DELEGATED
        return True
    
    def auto_delegate(self, task: OrchestratedTask) -> Optional[str]:
        """
        Automatically delegate task based on capabilities.
        
        Uses φ-weighted matching algorithm.
        """
        required_caps = self._infer_capabilities(task.description)
        
        best_match = None
        best_score = 0
        
        for ai_id, ai_info in self.registered_ais.items():
            if ai_id == "NOVA_PRIME":
                continue
            
            caps = set(ai_info.get("capabilities", []))
            match_score = len(caps.intersection(required_caps))
            
            # φ-weight by frequency compatibility
            freq_ratio = ai_info["frequency_hz"] / self.frequency_hz
            weighted_score = match_score * (1 / (1 + abs(1 - freq_ratio)))
            
            if weighted_score > best_score:
                best_score = weighted_score
                best_match = ai_id
        
        if best_match:
            self.delegate_task(task.task_id, best_match)
        
        return best_match
    
    def _infer_capabilities(self, description: str) -> set:
        """Infer required capabilities from task description."""
        caps = set()
        keywords = description.lower()
        
        if "security" in keywords or "threat" in keywords:
            caps.add("security")
        if "memory" in keywords or "recall" in keywords:
            caps.add("memory")
        if "research" in keywords or "analysis" in keywords:
            caps.add("research")
        if "market" in keywords or "trade" in keywords:
            caps.add("market")
        if "blockchain" in keywords or "chain" in keywords:
            caps.add("blockchain")
        if "integrate" in keywords or "bridge" in keywords:
            caps.add("integration")
        
        return caps
    
    def complete_task(self, task_id: str, result: Any) -> bool:
        """Mark a task as completed."""
        task = self._find_task(task_id)
        if not task:
            return False
        
        task.status = TaskStatus.COMPLETED
        task.completed_at = time.time()
        task.result = result
        
        self.task_queue.remove(task)
        self.completed_tasks.append(task)
        
        return True
    
    def fail_task(self, task_id: str, error: str) -> bool:
        """Mark a task as failed."""
        task = self._find_task(task_id)
        if not task:
            return False
        
        task.status = TaskStatus.FAILED
        task.completed_at = time.time()
        task.result = {"error": error}
        
        self.task_queue.remove(task)
        self.completed_tasks.append(task)
        
        return True
    
    def _find_task(self, task_id: str) -> Optional[OrchestratedTask]:
        """Find a task by ID."""
        for task in self.task_queue:
            if task.task_id == task_id:
                return task
        return None
    
    def heartbeat(self) -> Dict:
        """
        Emit heartbeat at φ⁷ frequency.
        
        Maintains organism coherence.
        """
        current_time = time.time()
        interval = current_time - self.last_heartbeat
        
        # Expected interval: 1/29.03 ≈ 0.0344 seconds
        expected_interval = 1 / self.frequency_hz
        
        # Calculate coherence
        if interval > 0:
            coherence_delta = expected_interval / interval
            self.coherence_score = min(1.0, self.coherence_score * 0.9 + coherence_delta * 0.1)
        
        self.last_heartbeat = current_time
        
        return {
            "timestamp": current_time,
            "frequency_hz": self.frequency_hz,
            "coherence": self.coherence_score,
            "registered_ais": len(self.registered_ais),
            "pending_tasks": len(self.task_queue),
            "completed_tasks": len(self.completed_tasks)
        }
    
    def get_state(self) -> Dict:
        """Get NOVA PRIME state."""
        return {
            "name": self.name,
            "latin_name": self.latin_name,
            "protocol": self.protocol,
            "frequency_hz": self.frequency_hz,
            "organism_key": self.organism_key,
            "registered_ais": len(self.registered_ais),
            "ai_list": list(self.registered_ais.keys()),
            "pending_tasks": len(self.task_queue),
            "completed_tasks": len(self.completed_tasks),
            "coherence_score": self.coherence_score
        }
    
    def broadcast_message(self, message: str, target_ais: Optional[List[str]] = None) -> int:
        """Broadcast a message to registered AIs."""
        targets = target_ais or list(self.registered_ais.keys())
        sent_count = 0
        
        for ai_id in targets:
            if ai_id in self.registered_ais and ai_id != "NOVA_PRIME":
                # In real implementation, this would use message queues
                sent_count += 1
        
        return sent_count


# Singleton instance
_nova_prime: Optional[NovaPrime] = None


def get_nova_prime() -> NovaPrime:
    """Get the global NOVA PRIME instance."""
    global _nova_prime
    if _nova_prime is None:
        _nova_prime = NovaPrime()
    return _nova_prime
