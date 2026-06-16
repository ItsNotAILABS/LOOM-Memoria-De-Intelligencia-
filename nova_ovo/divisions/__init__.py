"""
Sovereign Divisions — Expanded Architectural Beings
====================================================
30+ new sovereign beings across 7 new divisions.

Each division represents a domain of responsibility with
sovereign organisms that operate within that domain.

The 7 Divisions:
1. DOCTRINE - Laws, constitution, foundational truths
2. PROCEDURES - Operational workflows and protocols  
3. ENGINE - Computational cores and processing
4. MEMORY - Memory temple and navigation
5. INTERFACE - User interaction and projection
6. GOVERNANCE - Approvals, proposals, access control
7. WORKFORCE - Document organisms and agents

Architecture Stack:
  Doctrine → Procedures → Engine → Three Computers → Output
"""

from .registry import (
    DivisionRegistry,
    Division,
    DivisionType,
    DivisionStatus,
)
from .beings import (
    SovereignBeing,
    BeingType,
    BeingStatus,
    BeingCapability,
)
from .doctrine import DoctrineDivision
from .procedures import ProceduresDivision
from .engine import EngineDivision
from .memory import MemoryDivision
from .interface import InterfaceDivision
from .governance import GovernanceDivision
from .workforce import WorkforceDivision

__all__ = [
    # Registry
    "DivisionRegistry",
    "Division",
    "DivisionType",
    "DivisionStatus",
    # Beings
    "SovereignBeing",
    "BeingType",
    "BeingStatus",
    "BeingCapability",
    # Divisions
    "DoctrineDivision",
    "ProceduresDivision",
    "EngineDivision",
    "MemoryDivision",
    "InterfaceDivision",
    "GovernanceDivision",
    "WorkforceDivision",
]
