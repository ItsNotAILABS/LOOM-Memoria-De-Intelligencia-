"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                    BASAL GANGLIA SYSTEM — PROCEDURAL MEMORY & HABITS                        ║
║              "Quod Corpus Discit, Anima Non Obliviscitur"                                    ║
║              (What The Body Learns, The Soul Does Not Forget)                                ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-483 — PROCEDURAL MEMORY SYSTEM                                              ║
║                                                                                              ║
║  BIOLOGICAL INSPIRATION:                                                                     ║
║    The basal ganglia (striatum, globus pallidus, substantia nigra) encode:                   ║
║    - Procedural memories: skills, motor sequences, habits                                    ║
║    - Action selection: choosing between competing behaviors                                   ║
║    - Reward prediction: learning from outcomes (dopamine signals)                            ║
║    - Habit formation: chunking sequences into automatic routines                             ║
║                                                                                              ║
║  COMPUTATIONAL MODEL:                                                                        ║
║    1. Action-Value Learning: Q-learning style value estimation                               ║
║    2. Chunking: combine action sequences into single retrievable units                       ║
║    3. Habit Formation: transition from goal-directed to habitual control                     ║
║    4. Motor Programs: stored action sequences for skill execution                            ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ¹¹ = 199.005 Hz — Motor Rhythm                                       ║
║  PRIMITIVE TRACE: FIELD → REPETITION → RELATION → MEMORY → φ                                ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import math
import time
import uuid
import random
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple, Callable
from collections import deque

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

PHI: float = 1.6180339887498948482
PHI_11: float = 199.0050154405025  # φ¹¹ — Motor rhythm frequency
PHI_INV: float = 0.6180339887498948482

# Learning parameters (φ-tuned)
DEFAULT_LEARNING_RATE: float = PHI_INV * 0.1  # ~0.0618
DEFAULT_DISCOUNT_FACTOR: float = PHI_INV  # ~0.618 (temporal discounting)
DEFAULT_EXPLORATION_RATE: float = PHI_INV * 0.5  # ~0.309

# Habit formation thresholds
CHUNKING_THRESHOLD: int = 5  # Repetitions before chunking
HABIT_THRESHOLD: int = 21   # Repetitions before habit formation (21-day rule)
AUTOMATION_THRESHOLD: float = 0.95  # Confidence for automatic execution


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# TYPES
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class SkillPhase(str, Enum):
    """Phases of skill acquisition (Fitts & Posner model)."""
    COGNITIVE = "cognitive"       # Learning what to do
    ASSOCIATIVE = "associative"   # Practicing how to do it
    AUTONOMOUS = "autonomous"     # Automatic execution


class HabitState(str, Enum):
    """States of habit formation."""
    NOVEL = "novel"           # New behavior
    LEARNING = "learning"     # Being learned
    CHUNKED = "chunked"       # Chunked into sequence
    HABITUAL = "habitual"     # Automatic habit
    OVERLEARNED = "overlearned"  # Deeply ingrained


class ActionType(str, Enum):
    """Types of actions in motor programs."""
    DISCRETE = "discrete"     # Single action
    SEQUENTIAL = "sequential" # Ordered sequence
    PARALLEL = "parallel"     # Simultaneous actions
    CONDITIONAL = "conditional"  # If-then actions


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# ACTION & MOTOR PROGRAM STRUCTURES
# ═══════════════════════════════════════════════════════════════════════════════════════════════

@dataclass
class Action:
    """
    A single action unit — the atomic element of procedural memory.
    """
    action_id: str
    name: str
    action_type: ActionType = ActionType.DISCRETE
    
    # Execution
    parameters: Dict[str, Any] = field(default_factory=dict)
    duration: float = 0.0  # Expected execution time
    
    # Value estimation
    q_value: float = 0.0  # Estimated reward
    execution_count: int = 0
    success_count: int = 0
    
    # Timing
    last_executed: float = 0.0
    average_latency: float = 0.0
    
    @property
    def success_rate(self) -> float:
        if self.execution_count == 0:
            return 0.0
        return self.success_count / self.execution_count
    
    def execute(self, success: bool = True) -> None:
        """Record action execution."""
        self.execution_count += 1
        if success:
            self.success_count += 1
        self.last_executed = time.time()


@dataclass
class MotorProgram:
    """
    A motor program — a stored sequence of actions.
    
    This is how the brain stores skills like riding a bike,
    typing, or playing an instrument.
    """
    program_id: str
    name: str
    
    # Action sequence
    actions: List[str] = field(default_factory=list)  # Action IDs in order
    timing: List[float] = field(default_factory=list)  # Inter-action intervals
    
    # Execution state
    current_step: int = 0
    is_running: bool = False
    
    # Learning state
    phase: SkillPhase = SkillPhase.COGNITIVE
    execution_count: int = 0
    error_count: int = 0
    
    # Chunking
    is_chunked: bool = False
    parent_chunk: Optional[str] = None
    sub_programs: List[str] = field(default_factory=list)
    
    @property
    def accuracy(self) -> float:
        total = self.execution_count + self.error_count
        if total == 0:
            return 0.0
        return self.execution_count / total
    
    @property
    def is_autonomous(self) -> bool:
        return self.phase == SkillPhase.AUTONOMOUS and self.accuracy > AUTOMATION_THRESHOLD


@dataclass
class ProceduralSkill:
    """
    A complete procedural skill — combination of motor programs.
    
    Examples: playing piano, martial arts kata, surgical procedures.
    """
    skill_id: str
    name: str
    description: str = ""
    
    # Component programs
    motor_programs: List[str] = field(default_factory=list)
    
    # Context
    context_cues: List[str] = field(default_factory=list)  # What triggers this skill
    required_state: Dict[str, Any] = field(default_factory=dict)
    
    # Learning
    phase: SkillPhase = SkillPhase.COGNITIVE
    total_practice_time: float = 0.0
    mastery_level: float = 0.0  # 0.0 to 1.0
    
    # Metadata
    created_at: float = field(default_factory=time.time)
    last_practiced: float = field(default_factory=time.time)
    
    def practice(self, duration: float, performance: float) -> None:
        """Record a practice session."""
        self.total_practice_time += duration
        self.last_practiced = time.time()
        
        # Update mastery based on performance and practice
        # Power law of practice: improvement slows logarithmically
        practice_factor = math.log(self.total_practice_time + 1) / 10.0
        self.mastery_level = min(1.0, self.mastery_level + performance * 0.01 * practice_factor)
        
        # Phase transitions
        if self.mastery_level > 0.3 and self.phase == SkillPhase.COGNITIVE:
            self.phase = SkillPhase.ASSOCIATIVE
        elif self.mastery_level > 0.8 and self.phase == SkillPhase.ASSOCIATIVE:
            self.phase = SkillPhase.AUTONOMOUS


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# HABIT FORMATION — STIMULUS-RESPONSE LEARNING
# ═══════════════════════════════════════════════════════════════════════════════════════════════

@dataclass
class HabitFormation:
    """
    Habit Formation — tracking the development of automatic behaviors.
    
    Based on the Habit Loop: Cue → Routine → Reward
    """
    habit_id: str
    name: str
    
    # The habit loop
    cue: str  # What triggers the habit
    routine: str  # The motor program to execute
    reward: str  # The expected outcome
    
    # Formation state
    state: HabitState = HabitState.NOVEL
    repetitions: int = 0
    consecutive_successes: int = 0
    
    # Association strength
    cue_routine_strength: float = 0.0  # How strongly cue triggers routine
    routine_reward_strength: float = 0.0  # How reliably routine produces reward
    
    # Timing
    formed_at: Optional[float] = None
    last_triggered: float = field(default_factory=time.time)
    
    def trigger(self, success: bool = True, reward_received: bool = True) -> None:
        """Record a habit trigger."""
        self.repetitions += 1
        self.last_triggered = time.time()
        
        if success:
            self.consecutive_successes += 1
            # Strengthen cue-routine association
            self.cue_routine_strength = min(1.0, self.cue_routine_strength + 0.05)
        else:
            self.consecutive_successes = 0
            self.cue_routine_strength = max(0.0, self.cue_routine_strength - 0.02)
        
        if reward_received:
            # Strengthen routine-reward association
            self.routine_reward_strength = min(1.0, self.routine_reward_strength + 0.05)
        else:
            self.routine_reward_strength = max(0.0, self.routine_reward_strength - 0.03)
        
        # State transitions
        self._update_state()
    
    def _update_state(self) -> None:
        """Update habit state based on repetitions and strength."""
        if self.repetitions >= HABIT_THRESHOLD and self.cue_routine_strength > 0.8:
            if self.state != HabitState.HABITUAL:
                self.state = HabitState.HABITUAL
                self.formed_at = time.time()
        elif self.repetitions >= CHUNKING_THRESHOLD and self.cue_routine_strength > 0.5:
            self.state = HabitState.CHUNKED
        elif self.repetitions > 0:
            self.state = HabitState.LEARNING
        
        # Overlearning (after significant practice)
        if self.repetitions > HABIT_THRESHOLD * 3 and self.cue_routine_strength > 0.95:
            self.state = HabitState.OVERLEARNED
    
    @property
    def is_automatic(self) -> bool:
        """Check if habit is automatic (doesn't require conscious thought)."""
        return self.state in [HabitState.HABITUAL, HabitState.OVERLEARNED]


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# Q-LEARNING — ACTION-VALUE ESTIMATION
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class QLearner:
    """
    Q-Learning for action selection — models dopamine reward prediction.
    
    The basal ganglia computes expected rewards for actions,
    similar to temporal difference learning.
    """
    
    def __init__(
        self,
        learning_rate: float = DEFAULT_LEARNING_RATE,
        discount_factor: float = DEFAULT_DISCOUNT_FACTOR,
        exploration_rate: float = DEFAULT_EXPLORATION_RATE,
    ) -> None:
        self.learning_rate = learning_rate
        self.discount_factor = discount_factor
        self.exploration_rate = exploration_rate
        
        # Q-table: state -> action -> value
        self.q_table: Dict[str, Dict[str, float]] = {}
        
        # Experience replay
        self.experience_buffer: deque = deque(maxlen=1000)
        
        # Statistics
        self.total_updates = 0
    
    def get_q_value(self, state: str, action: str) -> float:
        """Get Q-value for state-action pair."""
        if state not in self.q_table:
            self.q_table[state] = {}
        return self.q_table[state].get(action, 0.0)
    
    def get_best_action(self, state: str, available_actions: List[str]) -> str:
        """Get the best action for a state (exploitation)."""
        if not available_actions:
            return ""
        
        best_action = available_actions[0]
        best_value = self.get_q_value(state, best_action)
        
        for action in available_actions[1:]:
            value = self.get_q_value(state, action)
            if value > best_value:
                best_value = value
                best_action = action
        
        return best_action
    
    def select_action(self, state: str, available_actions: List[str]) -> str:
        """
        Select action using ε-greedy policy (exploration vs exploitation).
        """
        if not available_actions:
            return ""
        
        if random.random() < self.exploration_rate:
            # Explore: random action
            return random.choice(available_actions)
        else:
            # Exploit: best known action
            return self.get_best_action(state, available_actions)
    
    def update(
        self,
        state: str,
        action: str,
        reward: float,
        next_state: str,
        next_actions: List[str],
    ) -> float:
        """
        Update Q-value using temporal difference learning.
        
        Q(s,a) ← Q(s,a) + α[r + γ·max(Q(s',a')) - Q(s,a)]
        
        This models the dopamine prediction error signal.
        """
        current_q = self.get_q_value(state, action)
        
        # Max Q-value for next state
        if next_actions:
            next_q = max(self.get_q_value(next_state, a) for a in next_actions)
        else:
            next_q = 0.0
        
        # TD error (prediction error = reward signal)
        td_error = reward + self.discount_factor * next_q - current_q
        
        # Update Q-value
        new_q = current_q + self.learning_rate * td_error
        
        if state not in self.q_table:
            self.q_table[state] = {}
        self.q_table[state][action] = new_q
        
        # Store experience
        self.experience_buffer.append((state, action, reward, next_state))
        
        self.total_updates += 1
        return td_error
    
    def replay_experience(self, batch_size: int = 10) -> int:
        """Replay experiences for learning (offline consolidation)."""
        if len(self.experience_buffer) < batch_size:
            return 0
        
        # Sample random experiences
        samples = random.sample(list(self.experience_buffer), batch_size)
        
        for state, action, reward, next_state in samples:
            # Get available actions (simplified: use existing actions for state)
            next_actions = list(self.q_table.get(next_state, {}).keys())
            if next_actions:
                self.update(state, action, reward, next_state, next_actions)
        
        return batch_size
    
    def decay_exploration(self, decay_rate: float = 0.99) -> None:
        """Decay exploration rate over time."""
        self.exploration_rate *= decay_rate


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# BASAL GANGLIA SYSTEM — INTEGRATED PROCEDURAL MEMORY
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class BasalGangliaSystem:
    """
    The Basal Ganglia System — procedural memory and habit formation.
    
    Integrates:
    - Motor programs for skill execution
    - Habit formation through repetition
    - Action selection via Q-learning (reward prediction)
    - Chunking for sequence compression
    
    Protocol: PROT-483
    Frequency: φ¹¹ = 199.005 Hz
    """
    
    def __init__(self) -> None:
        self.system_id = f"BG-{uuid.uuid4().hex[:8].upper()}"
        self.frequency = PHI_11
        self.protocol = "PROT-483"
        
        # Storage
        self.actions: Dict[str, Action] = {}
        self.motor_programs: Dict[str, MotorProgram] = {}
        self.skills: Dict[str, ProceduralSkill] = {}
        self.habits: Dict[str, HabitFormation] = {}
        
        # Q-learner for action selection
        self.q_learner = QLearner()
        
        # Current state
        self.current_state: str = "IDLE"
        self.current_program: Optional[str] = None
        self.execution_stack: List[str] = []
        
        # Statistics
        self.total_actions_executed = 0
        self.total_programs_completed = 0
        self.total_habits_formed = 0
    
    def register_action(
        self,
        name: str,
        action_type: ActionType = ActionType.DISCRETE,
        parameters: Optional[Dict[str, Any]] = None,
    ) -> Action:
        """Register a new action in the repertoire."""
        action = Action(
            action_id=f"ACT-{uuid.uuid4().hex[:8].upper()}",
            name=name,
            action_type=action_type,
            parameters=parameters or {},
        )
        self.actions[action.action_id] = action
        return action
    
    def create_motor_program(
        self,
        name: str,
        action_sequence: List[str],
        timing: Optional[List[float]] = None,
    ) -> MotorProgram:
        """Create a new motor program from action sequence."""
        program = MotorProgram(
            program_id=f"MP-{uuid.uuid4().hex[:8].upper()}",
            name=name,
            actions=action_sequence,
            timing=timing or [0.1] * len(action_sequence),
        )
        self.motor_programs[program.program_id] = program
        return program
    
    def create_skill(
        self,
        name: str,
        description: str,
        motor_programs: List[str],
        context_cues: Optional[List[str]] = None,
    ) -> ProceduralSkill:
        """Create a new procedural skill."""
        skill = ProceduralSkill(
            skill_id=f"SKILL-{uuid.uuid4().hex[:8].upper()}",
            name=name,
            description=description,
            motor_programs=motor_programs,
            context_cues=context_cues or [],
        )
        self.skills[skill.skill_id] = skill
        return skill
    
    def create_habit(
        self,
        name: str,
        cue: str,
        routine: str,  # Motor program ID
        reward: str,
    ) -> HabitFormation:
        """Create a new habit loop."""
        habit = HabitFormation(
            habit_id=f"HABIT-{uuid.uuid4().hex[:8].upper()}",
            name=name,
            cue=cue,
            routine=routine,
            reward=reward,
        )
        self.habits[habit.habit_id] = habit
        return habit
    
    def execute_action(
        self,
        action_id: str,
        success: bool = True,
    ) -> bool:
        """Execute a single action."""
        if action_id not in self.actions:
            return False
        
        action = self.actions[action_id]
        action.execute(success)
        self.total_actions_executed += 1
        
        return True
    
    def execute_program(
        self,
        program_id: str,
    ) -> bool:
        """Start executing a motor program."""
        if program_id not in self.motor_programs:
            return False
        
        program = self.motor_programs[program_id]
        program.is_running = True
        program.current_step = 0
        self.current_program = program_id
        
        return True
    
    def step_program(self) -> Optional[str]:
        """
        Execute the next step of current motor program.
        
        Returns the action ID executed, or None if program is complete.
        """
        if self.current_program is None:
            return None
        
        program = self.motor_programs[self.current_program]
        
        if program.current_step >= len(program.actions):
            # Program complete
            program.is_running = False
            program.execution_count += 1
            self.total_programs_completed += 1
            self.current_program = None
            return None
        
        # Get next action
        action_id = program.actions[program.current_step]
        program.current_step += 1
        
        # Execute action
        self.execute_action(action_id)
        
        return action_id
    
    def trigger_habit(
        self,
        cue: str,
    ) -> Optional[str]:
        """
        Check if a cue triggers any habit and return the routine.
        """
        for habit in self.habits.values():
            if habit.cue == cue and habit.cue_routine_strength > 0.3:
                return habit.routine
        return None
    
    def reinforce_habit(
        self,
        habit_id: str,
        success: bool = True,
        reward_received: bool = True,
    ) -> None:
        """Reinforce a habit after execution."""
        if habit_id in self.habits:
            habit = self.habits[habit_id]
            was_habitual = habit.is_automatic
            
            habit.trigger(success, reward_received)
            
            # Track new habit formation
            if not was_habitual and habit.is_automatic:
                self.total_habits_formed += 1
    
    def chunk_sequence(
        self,
        program_ids: List[str],
        chunk_name: str,
    ) -> Optional[MotorProgram]:
        """
        Chunk multiple motor programs into a single unit.
        
        This is how complex skills become automatic — sequences
        are compressed into single retrievable chunks.
        """
        # Collect all actions from programs
        all_actions = []
        all_timing = []
        
        for pid in program_ids:
            if pid not in self.motor_programs:
                return None
            program = self.motor_programs[pid]
            all_actions.extend(program.actions)
            all_timing.extend(program.timing)
        
        # Create chunk
        chunk = self.create_motor_program(
            name=chunk_name,
            action_sequence=all_actions,
            timing=all_timing,
        )
        chunk.is_chunked = True
        chunk.sub_programs = program_ids
        
        # Mark original programs as sub-components
        for pid in program_ids:
            self.motor_programs[pid].parent_chunk = chunk.program_id
        
        return chunk
    
    def select_action_for_state(
        self,
        state: str,
        available_action_ids: List[str],
    ) -> str:
        """
        Select an action using the Q-learner.
        """
        self.current_state = state
        action_names = [self.actions[aid].name for aid in available_action_ids if aid in self.actions]
        
        if not action_names:
            return ""
        
        selected_name = self.q_learner.select_action(state, action_names)
        
        # Find the action ID
        for aid in available_action_ids:
            if aid in self.actions and self.actions[aid].name == selected_name:
                return aid
        
        return available_action_ids[0] if available_action_ids else ""
    
    def learn_from_outcome(
        self,
        state: str,
        action_id: str,
        reward: float,
        next_state: str,
    ) -> float:
        """
        Update action values based on outcome (dopamine signal).
        
        Returns the prediction error (surprise).
        """
        if action_id not in self.actions:
            return 0.0
        
        action_name = self.actions[action_id].name
        
        # Get available actions for next state (simplified)
        next_actions = [a.name for a in self.actions.values()]
        
        # Update Q-values
        td_error = self.q_learner.update(
            state,
            action_name,
            reward,
            next_state,
            next_actions,
        )
        
        # Update action's Q-value directly
        self.actions[action_id].q_value = self.q_learner.get_q_value(state, action_name)
        
        return td_error
    
    def practice_skill(
        self,
        skill_id: str,
        duration: float,
        performance: float,
    ) -> bool:
        """Record a practice session for a skill."""
        if skill_id not in self.skills:
            return False
        
        skill = self.skills[skill_id]
        skill.practice(duration, performance)
        
        # Also practice constituent motor programs
        for mp_id in skill.motor_programs:
            if mp_id in self.motor_programs:
                program = self.motor_programs[mp_id]
                program.execution_count += 1
                
                # Update program phase based on parent skill
                if skill.phase == SkillPhase.AUTONOMOUS:
                    program.phase = SkillPhase.AUTONOMOUS
                elif skill.phase == SkillPhase.ASSOCIATIVE:
                    program.phase = SkillPhase.ASSOCIATIVE
        
        return True
    
    def run_consolidation(self) -> Dict[str, int]:
        """
        Run consolidation cycle — replay experiences, update habits.
        """
        results = {
            "experiences_replayed": 0,
            "habits_strengthened": 0,
            "programs_automated": 0,
        }
        
        # Replay experiences
        results["experiences_replayed"] = self.q_learner.replay_experience(20)
        
        # Check for habit formation
        for habit in self.habits.values():
            if habit.state == HabitState.LEARNING and habit.repetitions > CHUNKING_THRESHOLD:
                results["habits_strengthened"] += 1
        
        # Check for program automation
        for program in self.motor_programs.values():
            if program.execution_count > HABIT_THRESHOLD and program.phase != SkillPhase.AUTONOMOUS:
                if program.accuracy > AUTOMATION_THRESHOLD:
                    program.phase = SkillPhase.AUTONOMOUS
                    results["programs_automated"] += 1
        
        # Decay exploration
        self.q_learner.decay_exploration()
        
        return results
    
    def get_status(self) -> Dict[str, Any]:
        """Get basal ganglia system status."""
        habit_states = {}
        for habit in self.habits.values():
            state = habit.state.value
            habit_states[state] = habit_states.get(state, 0) + 1
        
        skill_phases = {}
        for skill in self.skills.values():
            phase = skill.phase.value
            skill_phases[phase] = skill_phases.get(phase, 0) + 1
        
        return {
            "system_id": self.system_id,
            "frequency": self.frequency,
            "protocol": self.protocol,
            "action_count": len(self.actions),
            "motor_program_count": len(self.motor_programs),
            "skill_count": len(self.skills),
            "habit_count": len(self.habits),
            "current_state": self.current_state,
            "current_program": self.current_program,
            "habit_distribution": habit_states,
            "skill_phase_distribution": skill_phases,
            "q_table_size": sum(len(v) for v in self.q_learner.q_table.values()),
            "exploration_rate": self.q_learner.exploration_rate,
            "total_actions_executed": self.total_actions_executed,
            "total_programs_completed": self.total_programs_completed,
            "total_habits_formed": self.total_habits_formed,
        }


__all__ = [
    "Action",
    "MotorProgram",
    "ProceduralSkill",
    "HabitFormation",
    "QLearner",
    "BasalGangliaSystem",
    "SkillPhase",
    "HabitState",
    "ActionType",
]
