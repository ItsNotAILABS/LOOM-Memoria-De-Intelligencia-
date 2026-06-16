"""
State Machine Contracts — Document↔Workforce Formal Contracts
=============================================================
Extends contracts with formal state machines for document-workforce
interaction governance.

A StateMachineContract defines:
- States: Named states with properties
- Transitions: Valid state changes with guards
- Guards: Conditions that must be met for transitions
- Evidence: Audit trail of all state changes

Document organisms and workforce agents bind to contracts
that enforce state machine rules during mutation flows.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Tuple, TYPE_CHECKING

if TYPE_CHECKING:
    from ..documents.organisms import DocumentOrganism


class MachineState(str, Enum):
    """Standard document-workforce states."""
    # Document lifecycle
    DRAFT = "draft"
    REVIEW = "review"
    APPROVED = "approved"
    ACTIVE = "active"
    SUSPENDED = "suspended"
    ARCHIVED = "archived"
    SUPERSEDED = "superseded"
    
    # Workforce states
    IDLE = "idle"
    ASSIGNED = "assigned"
    IN_PROGRESS = "in_progress"
    BLOCKED = "blocked"
    COMPLETED = "completed"
    FAILED = "failed"
    
    # Kernel states
    UNCOMPRESSED = "uncompressed"
    COMPRESSING = "compressing"
    COMPRESSED = "compressed"
    EXPANDING = "expanding"
    EXECUTING = "executing"


@dataclass
class StateDefinition:
    """Definition of a state in the state machine."""
    
    name: str
    state_type: str = "standard"  # "standard", "initial", "terminal"
    description: str = ""
    
    # Properties when in this state
    properties: Dict[str, Any] = field(default_factory=dict)
    
    # Allowed actions in this state
    allowed_actions: List[str] = field(default_factory=list)
    
    # Time limits (optional)
    max_duration_seconds: Optional[float] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "state_type": self.state_type,
            "description": self.description,
            "properties": self.properties,
            "allowed_actions": self.allowed_actions,
            "max_duration_seconds": self.max_duration_seconds,
        }


@dataclass
class TransitionGuard:
    """
    Guard condition for a state transition.
    
    Guards are conditions that must be met for a transition to occur.
    """
    
    guard_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    description: str = ""
    
    # Guard type
    guard_type: str = "condition"  # "condition", "permission", "time", "count"
    
    # Condition (for condition type)
    condition_field: str = ""
    condition_operator: str = "eq"  # "eq", "ne", "gt", "lt", "ge", "le", "in"
    condition_value: Any = None
    
    # Permission (for permission type)
    required_role: Optional[str] = None
    required_permission: Optional[str] = None
    
    # Time (for time type)
    min_time_in_state: Optional[float] = None
    max_time_in_state: Optional[float] = None
    
    # Custom evaluator (callable)
    custom_evaluator: Optional[Callable[[Dict[str, Any]], bool]] = None
    
    def evaluate(self, context: Dict[str, Any]) -> Tuple[bool, str]:
        """
        Evaluate the guard against context.
        
        Returns:
            (passed, reason) tuple
        """
        if self.custom_evaluator:
            try:
                result = self.custom_evaluator(context)
                return result, "custom_evaluator"
            except Exception as e:
                return False, f"evaluator_error: {str(e)}"
        
        if self.guard_type == "condition":
            return self._evaluate_condition(context)
        elif self.guard_type == "permission":
            return self._evaluate_permission(context)
        elif self.guard_type == "time":
            return self._evaluate_time(context)
        elif self.guard_type == "count":
            return self._evaluate_count(context)
        
        return True, "no_guard"
    
    def _evaluate_condition(self, context: Dict[str, Any]) -> Tuple[bool, str]:
        """Evaluate field condition."""
        value = context.get(self.condition_field)
        expected = self.condition_value
        
        ops = {
            "eq": lambda a, b: a == b,
            "ne": lambda a, b: a != b,
            "gt": lambda a, b: a > b,
            "lt": lambda a, b: a < b,
            "ge": lambda a, b: a >= b,
            "le": lambda a, b: a <= b,
            "in": lambda a, b: a in b,
        }
        
        op_fn = ops.get(self.condition_operator, lambda a, b: True)
        
        try:
            result = op_fn(value, expected)
            reason = f"{self.condition_field} {self.condition_operator} {expected}: {'pass' if result else 'fail'}"
            return result, reason
        except Exception as e:
            return False, f"condition_error: {str(e)}"
    
    def _evaluate_permission(self, context: Dict[str, Any]) -> Tuple[bool, str]:
        """Evaluate permission requirement."""
        user_roles = context.get("roles", [])
        user_permissions = context.get("permissions", [])
        
        if self.required_role and self.required_role not in user_roles:
            return False, f"missing_role: {self.required_role}"
        
        if self.required_permission and self.required_permission not in user_permissions:
            return False, f"missing_permission: {self.required_permission}"
        
        return True, "permission_ok"
    
    def _evaluate_time(self, context: Dict[str, Any]) -> Tuple[bool, str]:
        """Evaluate time constraints."""
        time_in_state = context.get("time_in_state", 0.0)
        
        if self.min_time_in_state and time_in_state < self.min_time_in_state:
            return False, f"min_time_not_met: {time_in_state} < {self.min_time_in_state}"
        
        if self.max_time_in_state and time_in_state > self.max_time_in_state:
            return False, f"max_time_exceeded: {time_in_state} > {self.max_time_in_state}"
        
        return True, "time_ok"
    
    def _evaluate_count(self, context: Dict[str, Any]) -> Tuple[bool, str]:
        """Evaluate count constraints."""
        return True, "count_ok"
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "guard_id": self.guard_id,
            "name": self.name,
            "description": self.description,
            "guard_type": self.guard_type,
            "condition_field": self.condition_field,
            "condition_operator": self.condition_operator,
            "condition_value": str(self.condition_value),
            "required_role": self.required_role,
            "required_permission": self.required_permission,
            "min_time_in_state": self.min_time_in_state,
            "max_time_in_state": self.max_time_in_state,
        }


@dataclass
class Transition:
    """
    A transition between states in the state machine.
    """
    
    transition_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    description: str = ""
    
    # From and to states
    from_state: str = ""
    to_state: str = ""
    
    # Guards that must pass
    guards: List[TransitionGuard] = field(default_factory=list)
    
    # Actions to perform on transition
    actions: List[str] = field(default_factory=list)
    
    # Who can trigger this transition
    allowed_actors: List[str] = field(default_factory=list)  # roles or "*"
    
    # Priority (for competing transitions)
    priority: int = 0
    
    def can_execute(self, context: Dict[str, Any]) -> Tuple[bool, List[str]]:
        """
        Check if transition can be executed.
        
        Returns:
            (can_execute, [reasons])
        """
        reasons: List[str] = []
        
        # Check actor permission
        actor_role = context.get("actor_role", "system")
        if self.allowed_actors and "*" not in self.allowed_actors:
            if actor_role not in self.allowed_actors:
                reasons.append(f"actor_not_allowed: {actor_role}")
                return False, reasons
        
        # Check all guards
        for guard in self.guards:
            passed, reason = guard.evaluate(context)
            if not passed:
                reasons.append(f"guard_failed: {guard.name} - {reason}")
                return False, reasons
        
        return True, reasons
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "transition_id": self.transition_id,
            "name": self.name,
            "description": self.description,
            "from_state": self.from_state,
            "to_state": self.to_state,
            "guards": [g.to_dict() for g in self.guards],
            "actions": self.actions,
            "allowed_actors": self.allowed_actors,
            "priority": self.priority,
        }


@dataclass
class TransitionEvent:
    """Record of a state transition (evidence trail)."""
    
    event_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    timestamp: float = field(default_factory=time.time)
    
    # Contract and transition
    contract_id: str = ""
    transition_id: str = ""
    transition_name: str = ""
    
    # State change
    from_state: str = ""
    to_state: str = ""
    
    # Actor
    actor_id: str = ""
    actor_role: str = ""
    
    # Context snapshot
    context_snapshot: Dict[str, Any] = field(default_factory=dict)
    
    # Result
    success: bool = True
    failure_reason: Optional[str] = None
    
    # Beat (for timeline alignment)
    beat: int = 0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "event_id": self.event_id,
            "timestamp": self.timestamp,
            "contract_id": self.contract_id,
            "transition_id": self.transition_id,
            "transition_name": self.transition_name,
            "from_state": self.from_state,
            "to_state": self.to_state,
            "actor_id": self.actor_id,
            "actor_role": self.actor_role,
            "success": self.success,
            "failure_reason": self.failure_reason,
            "beat": self.beat,
        }


@dataclass
class StateMachineContract:
    """
    A formal state machine contract for document-workforce governance.
    
    Defines:
    - Valid states for the bound entity
    - Allowed transitions between states
    - Guards that must pass for transitions
    - Evidence trail of all state changes
    """
    
    contract_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    description: str = ""
    version: str = "1.0.0"
    
    # Contract type
    contract_type: str = "document"  # "document", "workforce", "kernel"
    
    # Bound entity
    bound_entity_id: Optional[str] = None
    bound_entity_type: str = ""
    
    # State machine definition
    states: Dict[str, StateDefinition] = field(default_factory=dict)
    transitions: Dict[str, Transition] = field(default_factory=dict)
    
    # Current state
    current_state: str = ""
    state_entered_at: float = field(default_factory=time.time)
    
    # Initial and terminal states
    initial_state: str = ""
    terminal_states: List[str] = field(default_factory=list)
    
    # Evidence trail
    history: List[TransitionEvent] = field(default_factory=list)
    
    # Status
    is_active: bool = True
    created_at: float = field(default_factory=time.time)
    updated_at: float = field(default_factory=time.time)
    
    @property
    def time_in_current_state(self) -> float:
        """Time spent in current state (seconds)."""
        return time.time() - self.state_entered_at
    
    def add_state(
        self,
        name: str,
        state_type: str = "standard",
        description: str = "",
        properties: Optional[Dict[str, Any]] = None,
        allowed_actions: Optional[List[str]] = None,
    ) -> StateDefinition:
        """Add a state to the machine."""
        state = StateDefinition(
            name=name,
            state_type=state_type,
            description=description,
            properties=properties or {},
            allowed_actions=allowed_actions or [],
        )
        self.states[name] = state
        
        # Set initial state
        if state_type == "initial":
            self.initial_state = name
            if not self.current_state:
                self.current_state = name
        
        # Add terminal state
        if state_type == "terminal":
            self.terminal_states.append(name)
        
        return state
    
    def add_transition(
        self,
        name: str,
        from_state: str,
        to_state: str,
        guards: Optional[List[TransitionGuard]] = None,
        actions: Optional[List[str]] = None,
        allowed_actors: Optional[List[str]] = None,
        priority: int = 0,
    ) -> Transition:
        """Add a transition to the machine."""
        transition = Transition(
            name=name,
            from_state=from_state,
            to_state=to_state,
            guards=guards or [],
            actions=actions or [],
            allowed_actors=allowed_actors or ["*"],
            priority=priority,
        )
        self.transitions[transition.transition_id] = transition
        return transition
    
    def get_available_transitions(
        self,
        context: Optional[Dict[str, Any]] = None,
    ) -> List[Transition]:
        """Get transitions available from current state."""
        context = context or {}
        context["time_in_state"] = self.time_in_current_state
        
        available = []
        for transition in self.transitions.values():
            if transition.from_state == self.current_state:
                can_execute, _ = transition.can_execute(context)
                if can_execute:
                    available.append(transition)
        
        # Sort by priority
        available.sort(key=lambda t: -t.priority)
        return available
    
    def execute_transition(
        self,
        transition_name: str,
        actor_id: str = "system",
        actor_role: str = "system",
        context: Optional[Dict[str, Any]] = None,
        beat: int = 0,
    ) -> Tuple[bool, TransitionEvent]:
        """
        Execute a transition by name.
        
        Args:
            transition_name: Name of transition to execute
            actor_id: ID of the actor triggering transition
            actor_role: Role of the actor
            context: Additional context for guard evaluation
            beat: Current beat number
        
        Returns:
            (success, TransitionEvent)
        """
        context = context or {}
        context["actor_role"] = actor_role
        context["time_in_state"] = self.time_in_current_state
        
        # Find the transition
        transition = None
        for t in self.transitions.values():
            if t.name == transition_name and t.from_state == self.current_state:
                transition = t
                break
        
        if not transition:
            event = TransitionEvent(
                contract_id=self.contract_id,
                from_state=self.current_state,
                to_state=self.current_state,
                actor_id=actor_id,
                actor_role=actor_role,
                success=False,
                failure_reason=f"transition_not_found: {transition_name}",
                beat=beat,
            )
            self.history.append(event)
            return False, event
        
        # Check if can execute
        can_execute, reasons = transition.can_execute(context)
        
        if not can_execute:
            event = TransitionEvent(
                contract_id=self.contract_id,
                transition_id=transition.transition_id,
                transition_name=transition.name,
                from_state=self.current_state,
                to_state=transition.to_state,
                actor_id=actor_id,
                actor_role=actor_role,
                context_snapshot=context,
                success=False,
                failure_reason="; ".join(reasons),
                beat=beat,
            )
            self.history.append(event)
            return False, event
        
        # Execute transition
        old_state = self.current_state
        self.current_state = transition.to_state
        self.state_entered_at = time.time()
        self.updated_at = time.time()
        
        # Create success event
        event = TransitionEvent(
            contract_id=self.contract_id,
            transition_id=transition.transition_id,
            transition_name=transition.name,
            from_state=old_state,
            to_state=self.current_state,
            actor_id=actor_id,
            actor_role=actor_role,
            context_snapshot=context,
            success=True,
            beat=beat,
        )
        self.history.append(event)
        
        return True, event
    
    def is_in_terminal_state(self) -> bool:
        """Check if machine is in a terminal state."""
        return self.current_state in self.terminal_states
    
    def get_state_history(self) -> List[str]:
        """Get list of states visited."""
        states = [self.initial_state]
        for event in self.history:
            if event.success:
                states.append(event.to_state)
        return states
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "contract_id": self.contract_id,
            "name": self.name,
            "description": self.description,
            "version": self.version,
            "contract_type": self.contract_type,
            "bound_entity_id": self.bound_entity_id,
            "bound_entity_type": self.bound_entity_type,
            "states": {k: v.to_dict() for k, v in self.states.items()},
            "transitions": {k: v.to_dict() for k, v in self.transitions.items()},
            "current_state": self.current_state,
            "state_entered_at": self.state_entered_at,
            "time_in_current_state": self.time_in_current_state,
            "initial_state": self.initial_state,
            "terminal_states": self.terminal_states,
            "history_length": len(self.history),
            "is_active": self.is_active,
            "is_terminal": self.is_in_terminal_state(),
            "created_at": self.created_at,
            "updated_at": self.updated_at,
        }


# ============================================================================ #
# STANDARD CONTRACT TEMPLATES                                                    #
# ============================================================================ #


def create_document_lifecycle_contract(
    document_id: str,
    document_name: str = "",
) -> StateMachineContract:
    """
    Create a standard document lifecycle state machine contract.
    
    States: DRAFT -> REVIEW -> APPROVED -> ACTIVE -> (SUPERSEDED | ARCHIVED)
    """
    contract = StateMachineContract(
        name=f"Document Lifecycle: {document_name or document_id[:8]}",
        description="Standard document lifecycle state machine",
        contract_type="document",
        bound_entity_id=document_id,
        bound_entity_type="DocumentOrganism",
    )
    
    # Add states
    contract.add_state("draft", "initial", "Document is being drafted")
    contract.add_state("review", "standard", "Document under review")
    contract.add_state("approved", "standard", "Document approved")
    contract.add_state("active", "standard", "Document is active and in use")
    contract.add_state("suspended", "standard", "Document temporarily suspended")
    contract.add_state("archived", "terminal", "Document archived")
    contract.add_state("superseded", "terminal", "Document replaced by newer version")
    
    # Add transitions
    contract.add_transition("submit_for_review", "draft", "review")
    contract.add_transition("approve", "review", "approved", allowed_actors=["approver", "admin"])
    contract.add_transition("reject", "review", "draft")
    contract.add_transition("activate", "approved", "active")
    contract.add_transition("suspend", "active", "suspended", allowed_actors=["admin"])
    contract.add_transition("resume", "suspended", "active")
    contract.add_transition("archive", "active", "archived")
    contract.add_transition("supersede", "active", "superseded")
    contract.add_transition("revise", "active", "draft")  # Create new version
    
    return contract


def create_kernel_lifecycle_contract(
    kernel_id: str,
) -> StateMachineContract:
    """
    Create a kernel lifecycle state machine contract.
    
    States: UNCOMPRESSED -> COMPRESSING -> COMPRESSED -> EXPANDING -> EXECUTING -> COMPRESSED
    """
    contract = StateMachineContract(
        name=f"Kernel Lifecycle: {kernel_id[:8]}",
        description="Kernel compression/expansion lifecycle",
        contract_type="kernel",
        bound_entity_id=kernel_id,
        bound_entity_type="KernelSymbol",
    )
    
    # Add states
    contract.add_state("uncompressed", "initial", "Content not compressed")
    contract.add_state("compressing", "standard", "Compression in progress")
    contract.add_state("compressed", "standard", "Compressed kernel ready")
    contract.add_state("expanding", "standard", "Expansion in progress")
    contract.add_state("executing", "standard", "Kernel executing")
    contract.add_state("invalid", "terminal", "Kernel corrupted or invalid")
    
    # Add transitions
    contract.add_transition("compress", "uncompressed", "compressing")
    contract.add_transition("compression_complete", "compressing", "compressed")
    contract.add_transition("compression_failed", "compressing", "invalid")
    contract.add_transition("expand", "compressed", "expanding")
    contract.add_transition("expansion_complete", "expanding", "executing")
    contract.add_transition("expansion_failed", "expanding", "compressed")
    contract.add_transition("execution_complete", "executing", "compressed")
    contract.add_transition("invalidate", "compressed", "invalid")
    
    return contract


def create_workforce_task_contract(
    task_id: str,
    task_name: str = "",
) -> StateMachineContract:
    """
    Create a workforce task state machine contract.
    
    States: IDLE -> ASSIGNED -> IN_PROGRESS -> (COMPLETED | FAILED | BLOCKED)
    """
    contract = StateMachineContract(
        name=f"Task: {task_name or task_id[:8]}",
        description="Workforce task lifecycle",
        contract_type="workforce",
        bound_entity_id=task_id,
        bound_entity_type="WorkPacket",
    )
    
    # Add states
    contract.add_state("idle", "initial", "Task created, awaiting assignment")
    contract.add_state("assigned", "standard", "Task assigned to agent")
    contract.add_state("in_progress", "standard", "Task being executed")
    contract.add_state("blocked", "standard", "Task blocked by dependency")
    contract.add_state("completed", "terminal", "Task completed successfully")
    contract.add_state("failed", "terminal", "Task failed")
    contract.add_state("cancelled", "terminal", "Task cancelled")
    
    # Add transitions
    contract.add_transition("assign", "idle", "assigned")
    contract.add_transition("start", "assigned", "in_progress")
    contract.add_transition("block", "in_progress", "blocked")
    contract.add_transition("unblock", "blocked", "in_progress")
    contract.add_transition("complete", "in_progress", "completed")
    contract.add_transition("fail", "in_progress", "failed")
    contract.add_transition("cancel", "idle", "cancelled")
    contract.add_transition("cancel", "assigned", "cancelled")
    contract.add_transition("cancel", "blocked", "cancelled")
    contract.add_transition("retry", "failed", "idle")
    
    return contract
