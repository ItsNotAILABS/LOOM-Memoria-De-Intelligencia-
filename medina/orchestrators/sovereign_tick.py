"""
ORCH-01 SOVEREIGN_TICK_ORCHESTRATOR — Master beat timing.

The sovereign tick is the fundamental rhythm of MEDINA:
- All operations synchronize to ticks
- Models coordinate through tick boundaries
- State advances in discrete beat increments

This orchestrator:
- Drives the heartbeat
- Coordinates all other orchestrators
- Enforces global cadence policy
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional

from medina.core.heartbeat import Heartbeat, BeatTask, CadenceClass, BeatMetrics


class OrchestratorState(Enum):
    """Orchestrator lifecycle states."""
    
    INITIALIZING = "initializing"
    READY = "ready"
    RUNNING = "running"
    PAUSED = "paused"
    ERROR = "error"
    SHUTDOWN = "shutdown"


@dataclass
class OrchestratorMetrics:
    """Metrics for orchestrator performance."""
    
    total_ticks: int = 0
    successful_ticks: int = 0
    failed_ticks: int = 0
    total_duration_ms: float = 0.0
    max_tick_ms: float = 0.0
    min_tick_ms: float = float("inf")
    
    @property
    def avg_tick_ms(self) -> float:
        if self.total_ticks == 0:
            return 0.0
        return self.total_duration_ms / self.total_ticks
    
    def record_tick(self, duration_ms: float, success: bool) -> None:
        self.total_ticks += 1
        self.total_duration_ms += duration_ms
        self.max_tick_ms = max(self.max_tick_ms, duration_ms)
        self.min_tick_ms = min(self.min_tick_ms, duration_ms)
        if success:
            self.successful_ticks += 1
        else:
            self.failed_ticks += 1
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "total_ticks": self.total_ticks,
            "successful_ticks": self.successful_ticks,
            "failed_ticks": self.failed_ticks,
            "avg_tick_ms": round(self.avg_tick_ms, 3),
            "max_tick_ms": round(self.max_tick_ms, 3),
            "min_tick_ms": round(self.min_tick_ms, 3) if self.min_tick_ms != float("inf") else 0.0,
        }


# Handler type for tick callbacks
TickHandler = Callable[[int], None]


class SovereignTickOrchestrator:
    """
    ORCH-01 SOVEREIGN_TICK_ORCHESTRATOR
    
    Master beat timing for the entire MEDINA platform.
    
    Responsibilities:
    - Drive the heartbeat rhythm
    - Register and coordinate sub-orchestrators
    - Enforce global timing policy
    - Produce tick evidence for replay
    
    All other orchestrators align to this sovereign tick.
    """
    
    def __init__(
        self,
        heartbeat: Optional[Heartbeat] = None,
        tick_interval_ms: float = 100.0,
    ) -> None:
        self._id = str(uuid.uuid4())
        self._heartbeat = heartbeat or Heartbeat()
        self._tick_interval_ms = tick_interval_ms
        self._state = OrchestratorState.INITIALIZING
        self._metrics = OrchestratorMetrics()
        
        # Sub-orchestrators to coordinate
        self._sub_orchestrators: Dict[str, TickHandler] = {}
        
        # Evidence log
        self._tick_evidence: List[Dict[str, Any]] = []
        
        # Initialize
        self._state = OrchestratorState.READY
    
    # ------------------------------------------------------------------ #
    # Properties                                                            #
    # ------------------------------------------------------------------ #
    
    @property
    def orchestrator_id(self) -> str:
        return self._id
    
    @property
    def name(self) -> str:
        return "ORCH-01 SOVEREIGN_TICK_ORCHESTRATOR"
    
    @property
    def state(self) -> OrchestratorState:
        return self._state
    
    @property
    def current_beat(self) -> int:
        return self._heartbeat.current_beat
    
    # ------------------------------------------------------------------ #
    # Sub-orchestrator Registration                                         #
    # ------------------------------------------------------------------ #
    
    def register_sub_orchestrator(
        self,
        name: str,
        handler: TickHandler,
        cadence: CadenceClass = CadenceClass.EVERY_BEAT,
        n_interval: int = 1,
    ) -> str:
        """
        Register a sub-orchestrator to receive tick notifications.
        
        Returns a task ID for the registered handler.
        """
        task = BeatTask(
            name=name,
            cadence=cadence,
            n_interval=n_interval,
            handler=handler,
        )
        self._heartbeat.register_task(task)
        self._sub_orchestrators[task.task_id] = handler
        return task.task_id
    
    def unregister_sub_orchestrator(self, task_id: str) -> bool:
        """Remove a sub-orchestrator."""
        if task_id in self._sub_orchestrators:
            self._heartbeat.unregister_task(task_id)
            del self._sub_orchestrators[task_id]
            return True
        return False
    
    # ------------------------------------------------------------------ #
    # Tick Execution                                                        #
    # ------------------------------------------------------------------ #
    
    def tick(self) -> BeatMetrics:
        """
        Execute one sovereign tick.
        
        This advances the heartbeat and notifies all registered
        sub-orchestrators according to their cadence.
        """
        if self._state not in (OrchestratorState.READY, OrchestratorState.RUNNING):
            raise RuntimeError(f"Cannot tick in state {self._state}")
        
        self._state = OrchestratorState.RUNNING
        
        start_time = time.time()
        beat = self._heartbeat.current_beat
        
        try:
            # Execute heartbeat tick (triggers all registered handlers)
            metrics = self._heartbeat.tick()
            success = not metrics.budget_exceeded
            
        except Exception as e:
            success = False
            metrics = BeatMetrics(beat=beat)
        
        end_time = time.time()
        duration_ms = (end_time - start_time) * 1000
        
        # Record metrics
        self._metrics.record_tick(duration_ms, success)
        
        # Record evidence
        evidence = {
            "beat": beat,
            "timestamp": start_time,
            "duration_ms": round(duration_ms, 3),
            "success": success,
            "tasks_executed": metrics.tasks_executed,
            "tasks_skipped": metrics.tasks_skipped,
        }
        self._tick_evidence.append(evidence)
        
        self._state = OrchestratorState.READY
        return metrics
    
    def tick_n(self, n: int) -> List[BeatMetrics]:
        """Execute N ticks."""
        return [self.tick() for _ in range(n)]
    
    # ------------------------------------------------------------------ #
    # Control                                                               #
    # ------------------------------------------------------------------ #
    
    def start(self) -> None:
        """Start the orchestrator."""
        if self._state == OrchestratorState.SHUTDOWN:
            raise RuntimeError("Cannot restart shutdown orchestrator")
        self._state = OrchestratorState.READY
        self._heartbeat.resume()
    
    def pause(self) -> None:
        """Pause tick execution."""
        self._state = OrchestratorState.PAUSED
        self._heartbeat.pause()
    
    def resume(self) -> None:
        """Resume from pause."""
        if self._state == OrchestratorState.PAUSED:
            self._state = OrchestratorState.READY
            self._heartbeat.resume()
    
    def shutdown(self) -> None:
        """Shutdown the orchestrator."""
        self._state = OrchestratorState.SHUTDOWN
        self._heartbeat.pause()
    
    def reset(self) -> None:
        """Reset to initial state."""
        self._heartbeat.reset()
        self._metrics = OrchestratorMetrics()
        self._tick_evidence.clear()
        self._state = OrchestratorState.READY
    
    # ------------------------------------------------------------------ #
    # Evidence & Replay                                                     #
    # ------------------------------------------------------------------ #
    
    def get_evidence(
        self,
        from_beat: int = 0,
        to_beat: Optional[int] = None,
    ) -> List[Dict[str, Any]]:
        """Get tick evidence for replay."""
        evidence = self._tick_evidence
        if to_beat is not None:
            evidence = [e for e in evidence if from_beat <= e["beat"] <= to_beat]
        else:
            evidence = [e for e in evidence if e["beat"] >= from_beat]
        return evidence
    
    def replay(
        self,
        from_beat: int = 0,
        to_beat: Optional[int] = None,
    ) -> List[Dict[str, Any]]:
        """Replay tick sequence (read-only view of evidence)."""
        return self.get_evidence(from_beat, to_beat)
    
    # ------------------------------------------------------------------ #
    # Status                                                                #
    # ------------------------------------------------------------------ #
    
    def status(self) -> Dict[str, Any]:
        """Current orchestrator status."""
        return {
            "orchestrator_id": self._id,
            "name": self.name,
            "state": self._state.value,
            "current_beat": self.current_beat,
            "tick_interval_ms": self._tick_interval_ms,
            "registered_sub_orchestrators": len(self._sub_orchestrators),
            "metrics": self._metrics.to_dict(),
            "evidence_count": len(self._tick_evidence),
        }
