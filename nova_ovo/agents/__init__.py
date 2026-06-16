"""
Nova OVO Agents Package
========================

Internal AI Testing Agents - Always-On, Non-Feeling Workers

L-005: AGENT_EXISTENCE_LAW
- Agents are ALWAYS-ON, not alive
- They don't feel, they don't stress
- Constantly working at dynamic speeds
- Testing everything at multiple points simultaneously

THERMODYNAMICS SUBSTRATE DIVISION
- 10 Alpha Models for elemental protection
- All metals with primary formulas (thermodynamics) and secondary formulas (load/stress)
- Gold (Au): Non-oxidizing, infinite protection
- Titanium (Ti): Structural integrity, never yields
- Tungsten (W): Thermal resistance, survives any heat
- Iridium (Ir): Densest defense, impenetrable core
- Silver (Ag): Maximum conductivity
- Copper (Cu): Universal connector
- Platinum (Pt): Eternal catalyst

Components:
- SovereignSubstrate: The alpha foundation with stress elimination law
- InternalAgents: Testing agents (Continuous, Stress, Edge, Workflow, Integration)
- TestOrchestrator: Coordinates all agents as the "big model"
- ThermodynamicsSubstrate: Elemental protection with all metals and formulas
"""

from .substrate import (
    # Laws
    SubstrateLaw,
    
    # State
    SubstrateState,
    SovereignFace,
    SovereignSubstrate,
    
    # Singleton
    get_substrate,
    reset_substrate,
    
    # Constants
    PHI,
)

from .internal_agents import (
    # State
    AgentState,
    AgentMetrics,
    TestResult,
    
    # Base
    InternalAgent,
    
    # Agents
    ContinuousTestAgent,
    StressTestAgent,
    EdgeCaseAgent,
    WorkflowTestAgent,
    IntegrationTestAgent,
)

from .orchestrator import (
    # State
    OrchestratorState,
    OrchestratorMetrics,
    
    # Orchestrator
    TestOrchestrator,
    
    # Singleton
    get_orchestrator,
    reset_orchestrator,
)

from .thermodynamics import (
    # Constants
    PHI as THERMO_PHI,
    BOLTZMANN,
    PLANCK,
    
    # Enums
    ElementCategory,
    ElementUseCase,
    ArchitecturePlacement,
    
    # Data classes
    PrimaryFormula,
    SecondaryFormula,
    ElementUse,
    Element,
    AlphaModel,
    
    # Elements
    GOLD,
    TITANIUM,
    TUNGSTEN,
    IRIDIUM,
    SILVER,
    COPPER,
    PLATINUM,
    ALL_ELEMENTS,
    ALPHA_MODELS,
    
    # Functions
    get_element,
    get_elements_for_placement,
    get_elements_for_use_case,
    get_alpha_model,
    
    # Substrate
    ThermodynamicsSubstrate,
    get_thermodynamics_substrate,
)

__all__ = [
    # Substrate
    "SubstrateLaw",
    "SubstrateState",
    "SovereignFace",
    "SovereignSubstrate",
    "get_substrate",
    "reset_substrate",
    "PHI",
    
    # Agents
    "AgentState",
    "AgentMetrics",
    "TestResult",
    "InternalAgent",
    "ContinuousTestAgent",
    "StressTestAgent",
    "EdgeCaseAgent",
    "WorkflowTestAgent",
    "IntegrationTestAgent",
    
    # Orchestrator
    "OrchestratorState",
    "OrchestratorMetrics",
    "TestOrchestrator",
    "get_orchestrator",
    "reset_orchestrator",
    
    # Thermodynamics
    "THERMO_PHI",
    "BOLTZMANN",
    "PLANCK",
    "ElementCategory",
    "ElementUseCase",
    "ArchitecturePlacement",
    "PrimaryFormula",
    "SecondaryFormula",
    "ElementUse",
    "Element",
    "AlphaModel",
    "GOLD",
    "TITANIUM",
    "TUNGSTEN",
    "IRIDIUM",
    "SILVER",
    "COPPER",
    "PLATINUM",
    "ALL_ELEMENTS",
    "ALPHA_MODELS",
    "get_element",
    "get_elements_for_placement",
    "get_elements_for_use_case",
    "get_alpha_model",
    "ThermodynamicsSubstrate",
    "get_thermodynamics_substrate",
]
