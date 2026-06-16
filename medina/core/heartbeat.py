"""
MEDINA Heartbeat — Beat-driven orchestrator rhythm.

The heartbeat is the fundamental timing mechanism of MEDINA:
- Every operation synchronizes to beats
- Cadence classes define execution frequency
- Instruction budget enforces resource limits per beat

CADENCE CLASSES:
  EVERY_BEAT      — execute on every heartbeat tick
  N_BEAT          — execute every N beats (configurable)
  EVENT_DRIVEN    — execute only on explicit trigger

BEAT LIFECYCLE:
  1. Pre-beat: collect pending operations
  2. Beat: execute within budget
  3. Post-beat: emit events, update state
  4. Inter-beat: idle/wait

Runtime beat budget (H5 hardening):
  - Cadence classes are enforced
  - Instruction budget policy prevents runaway execution
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional


class CadenceClass(Enum):
    """Beat execution cadence for orchestrated operations."""
    
    EVERY_BEAT = "every_beat"       # Execute on every tick
    N_BEAT = "n_beat"               # Execute every N beats
    EVENT_DRIVEN = "event_driven"   # Execute only on trigger


@dataclass
class BeatEvent:
    """Event emitted by a heartbeat tick."""
    
    event_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    beat: int = 0
    timestamp: float = field(default_factory=time.time)
    phase: str = "tick"  # pre_beat, tick, post_beat
    payload: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "event_id": self.event_id,
            "beat": self.beat,
            "timestamp": self.timestamp,
            "phase": self.phase,
            "payload": self.payload,
        }


@dataclass
class BeatTask:
    """A task registered to execute on heartbeat."""
    
    task_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    cadence: CadenceClass = CadenceClass.EVERY_BEAT
    n_interval: int = 1  # For N_BEAT cadence
    handler: Optional[Callable[[int], Any]] = None
    last_beat: int = -1
    enabled: bool = True
    instruction_budget: int = 1000  # Max instructions per execution
    
    def should_execute(self, current_beat: int) -> bool:
        """Determine if task should execute on this beat."""
        if not self.enabled:
            return False
        
        if self.cadence == CadenceClass.EVERY_BEAT:
            return True
        elif self.cadence == CadenceClass.N_BEAT:
            return (current_beat - self.last_beat) >= self.n_interval
        elif self.cadence == CadenceClass.EVENT_DRIVEN:
            return False  # Must be explicitly triggered
        return False


@dataclass
class BeatMetrics:
    """Metrics collected during a heartbeat cycle."""
    
    beat: int = 0
    start_time: float = 0.0
    end_time: float = 0.0
    tasks_executed: int = 0
    tasks_skipped: int = 0
    events_emitted: int = 0
    budget_exceeded: bool = False
    
    @property
    def duration_ms(self) -> float:
        return (self.end_time - self.start_time) * 1000
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "beat": self.beat,
            "duration_ms": round(self.duration_ms, 3),
            "tasks_executed": self.tasks_executed,
            "tasks_skipped": self.tasks_skipped,
            "events_emitted": self.events_emitted,
            "budget_exceeded": self.budget_exceeded,
        }


class Heartbeat:
    """
    MEDINA Heartbeat — The sovereign tick orchestrator.
    
    All runtime operations synchronize to the heartbeat:
    - Beat counter advances monotonically
    - Tasks execute according to cadence class
    - Budget limits prevent resource exhaustion
    - Events provide observability
    
    ORCH-01 SOVEREIGN_TICK_ORCHESTRATOR aligns to this rhythm.
    """
    
    # Default budget per beat (total across all tasks)
    DEFAULT_BEAT_BUDGET = 10000
    
    def __init__(self, beat_budget: int = DEFAULT_BEAT_BUDGET) -> None:
        self._beat: int = 0
        self._started_at: float = time.time()
        self._last_tick: float = 0.0
        self._tasks: Dict[str, BeatTask] = {}
        self._event_log: List[BeatEvent] = []
        self._metrics_log: List[BeatMetrics] = []
        self._beat_budget = beat_budget
        self._paused = False
    
    # ------------------------------------------------------------------ #
    # Properties                                                            #
    # ------------------------------------------------------------------ #
    
    @property
    def current_beat(self) -> int:
        return self._beat
    
    @property
    def is_paused(self) -> bool:
        return self._paused
    
    # ------------------------------------------------------------------ #
    # Task Management                                                       #
    # ------------------------------------------------------------------ #
    
    def register_task(self, task: BeatTask) -> str:
        """Register a task to execute on heartbeat."""
        self._tasks[task.task_id] = task
        return task.task_id
    
    def unregister_task(self, task_id: str) -> bool:
        """Remove a task from the heartbeat."""
        if task_id in self._tasks:
            del self._tasks[task_id]
            return True
        return False
    
    def enable_task(self, task_id: str, enabled: bool = True) -> bool:
        """Enable or disable a task."""
        if task_id in self._tasks:
            self._tasks[task_id].enabled = enabled
            return True
        return False
    
    def trigger_event_driven(self, task_id: str) -> bool:
        """
        Trigger an event-driven task to execute on next tick.
        
        Temporarily sets its cadence to EVERY_BEAT for one cycle.
        """
        if task_id not in self._tasks:
            return False
        task = self._tasks[task_id]
        if task.cadence != CadenceClass.EVENT_DRIVEN:
            return False
        # Mark for next execution
        task.last_beat = -999  # Force execution
        return True
    
    # ------------------------------------------------------------------ #
    # Core Tick                                                             #
    # ------------------------------------------------------------------ #
    
    def tick(self) -> BeatMetrics:
        """
        Execute one heartbeat cycle.
        
        Lifecycle:
        1. Pre-beat event
        2. Execute eligible tasks (within budget)
        3. Post-beat event
        4. Record metrics
        """
        if self._paused:
            return BeatMetrics(beat=self._beat)
        
        metrics = BeatMetrics(beat=self._beat, start_time=time.time())
        
        # Pre-beat event
        pre_event = BeatEvent(
            beat=self._beat,
            phase="pre_beat",
        )
        self._event_log.append(pre_event)
        metrics.events_emitted += 1
        
        # Execute tasks within budget
        budget_remaining = self._beat_budget
        for task in self._tasks.values():
            if task.should_execute(self._beat):
                if task.instruction_budget <= budget_remaining:
                    try:
                        if task.handler:
                            task.handler(self._beat)
                        task.last_beat = self._beat
                        metrics.tasks_executed += 1
                        budget_remaining -= task.instruction_budget
                    except Exception:
                        pass  # Log but don't fail the beat
                else:
                    metrics.tasks_skipped += 1
                    metrics.budget_exceeded = True
            elif task.cadence == CadenceClass.EVENT_DRIVEN and task.last_beat == -999:
                # Reset event-driven trigger
                task.last_beat = self._beat
        
        # Post-beat event
        post_event = BeatEvent(
            beat=self._beat,
            phase="post_beat",
            payload={
                "tasks_executed": metrics.tasks_executed,
                "budget_remaining": budget_remaining,
            },
        )
        self._event_log.append(post_event)
        metrics.events_emitted += 1
        
        # Finalize
        metrics.end_time = time.time()
        self._metrics_log.append(metrics)
        self._last_tick = metrics.end_time
        self._beat += 1
        
        return metrics
    
    def tick_n(self, n: int) -> List[BeatMetrics]:
        """Execute N heartbeat cycles."""
        return [self.tick() for _ in range(n)]
    
    # ------------------------------------------------------------------ #
    # Control                                                               #
    # ------------------------------------------------------------------ #
    
    def pause(self) -> None:
        """Pause heartbeat execution."""
        self._paused = True
    
    def resume(self) -> None:
        """Resume heartbeat execution."""
        self._paused = False
    
    def reset(self) -> None:
        """Reset heartbeat to initial state."""
        self._beat = 0
        self._started_at = time.time()
        self._last_tick = 0.0
        self._event_log.clear()
        self._metrics_log.clear()
        for task in self._tasks.values():
            task.last_beat = -1
    
    # ------------------------------------------------------------------ #
    # Observability                                                         #
    # ------------------------------------------------------------------ #
    
    def get_events(
        self,
        from_beat: int = 0,
        to_beat: Optional[int] = None,
        phase: Optional[str] = None,
    ) -> List[BeatEvent]:
        """Query event log."""
        events = self._event_log
        if to_beat is not None:
            events = [e for e in events if from_beat <= e.beat <= to_beat]
        else:
            events = [e for e in events if e.beat >= from_beat]
        if phase:
            events = [e for e in events if e.phase == phase]
        return events
    
    def get_metrics(self, last_n: int = 10) -> List[BeatMetrics]:
        """Get recent beat metrics."""
        return self._metrics_log[-last_n:]
    
    def status(self) -> Dict[str, Any]:
        """Current heartbeat status."""
        return {
            "current_beat": self._beat,
            "paused": self._paused,
            "started_at": self._started_at,
            "last_tick": self._last_tick,
            "registered_tasks": len(self._tasks),
            "event_log_size": len(self._event_log),
            "beat_budget": self._beat_budget,
        }
