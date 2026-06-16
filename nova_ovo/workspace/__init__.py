"""
Workspace — Agentic Workspace Fabric
====================================
Implement packetized operation:
- task constitution packet
- agent work packet
- arbitration record
- integration contract
- replay bundle
- state machine contracts (document↔workforce governance)
"""

from .packets import WorkPacket, PacketType, TaskConstitution
from .contracts import IntegrationContract, ContractStatus
from .state_machine import (
    StateMachineContract,
    StateDefinition,
    Transition,
    TransitionGuard,
    TransitionEvent,
    MachineState,
    create_document_lifecycle_contract,
    create_kernel_lifecycle_contract,
    create_workforce_task_contract,
)

__all__ = [
    "WorkPacket",
    "PacketType",
    "TaskConstitution",
    "IntegrationContract",
    "ContractStatus",
    # State Machine Contracts
    "StateMachineContract",
    "StateDefinition",
    "Transition",
    "TransitionGuard",
    "TransitionEvent",
    "MachineState",
    "create_document_lifecycle_contract",
    "create_kernel_lifecycle_contract",
    "create_workforce_task_contract",
]
