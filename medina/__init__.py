"""
MEDINA — Sovereign Memory-Operating Intelligence Platform
==========================================================
Architecture-first, production-real memory system AI.

MEDINA integrates:
- Memory Temple as core substrate
- Universal chat control surface
- Built-in governance (not post-launch)
- Native company onboarding (connect/internalize/hybrid)
- Coupled runtime truth + document intelligence + interface intelligence

NON-NEGOTIABLE LAWS:
1) RECITAL_PLUS_ONE: state(n+1) = recital(validated_state_n) + one_lawful_expansion
2) FOUR REGISTERS: Founder · Builder · Organism · External
3) DUAL READ ALWAYS-ON: semantic_read + resonance_read mandatory
4) NO-COLLAPSE ONTOLOGY: Absolute ≠ Law ≠ Model ≠ Engine ≠ Core ≠ Module ≠ Lab ≠ Workforce ≠ Product
5) AUTHORITY: Core A = runtime truth, Core B = industrial/workforce execution
6) GATES: A (runtime) · B (workforce) · C (projection) — No bypass

Architecture Planes:
- Constitutional Law View (Parallel View A)
- Runtime Organism View (Parallel View B)
- Memory Kingdom View (Parallel View C)
- Interface/Interaction View (Parallel View D)
- Model Ecology View (Parallel View E)
- Enterprise/Company View (Parallel View F)
- Security/Projection View (Parallel View G)
- Learning/Adaptation View (Parallel View H)
- Attention/Release View (Parallel View I)
- Day-1 Superiority View (Parallel View J)

ORCHESTRATORS:
- ORCH-01 SOVEREIGN_TICK_ORCHESTRATOR
- ORCH-02 SPHERICAL_INTEGRATION_ORCHESTRATOR
- ORCH-03 SWARM_CORE_ORCHESTRATOR
- ORCH-04 FULL_GOVERNANCE_ORCHESTRATOR
- ORCH-05 CONSTITUTIONAL_LAW_ORCHESTRATOR
- ORCH-06 NEURAL_CORE_MESH_ORCHESTRATOR
- ORCH-07 LIVING_DOCUMENT_MACRO_ORCHESTRATOR
- ORCH-08 FRONTEND_COMMAND_ORCHESTRATOR
"""

__version__ = "1.0.0"
__codename__ = "MEDINA V1"
__platform__ = "Sovereign Memory-Operating Intelligence"

# Re-export nova_ovo core foundation
from nova_ovo.core import (
    OrganismSovereign,
    Register,
    RecitalEngine,
    OrganismState,
    GateEnforcer,
    GateLevel,
    GateDecision,
)

# Re-export MEDINA core
from medina.core import (
    Constitution,
    DoctrineLevel,
    Heartbeat,
    BeatEvent,
    LawEngine,
    LawCheck,
    LawViolation,
)

# Re-export Memory Temple
from medina.memory_temple import (
    MemoryTemple,
    MemoryNode,
    MemoryCoordinates,
    MemoryNavigator,
    NavigationPath,
    SalienceEngine,
    SalienceLevel,
)

# Re-export Orchestrators
from medina.orchestrators import (
    SovereignTickOrchestrator,
    GovernanceOrchestrator,
    ModelRouterOrchestrator,
    CommandOrchestrator,
)

# Re-export Company Onboarding
from medina.company import (
    CompanyOnboarding,
    OnboardingMode,
    OnboardingStatus,
    CompanyProfile,
)

# Re-export Security
from medina.security import (
    PermissionManager,
    Permission,
    PermissionGrant,
    PermissionScope,
    ProjectionSafetyEngine,
    ProjectionBoundary,
    SafeProjection,
)

# Re-export Platform
from medina.platform import MedinaPlatform, create_platform

__all__ = [
    # Version
    "__version__",
    "__codename__",
    "__platform__",
    
    # Nova OVO Core foundation
    "OrganismSovereign",
    "Register",
    "RecitalEngine",
    "OrganismState",
    "GateEnforcer",
    "GateLevel",
    "GateDecision",
    
    # MEDINA Core
    "Constitution",
    "DoctrineLevel",
    "Heartbeat",
    "BeatEvent",
    "LawEngine",
    "LawCheck",
    "LawViolation",
    
    # Memory Temple
    "MemoryTemple",
    "MemoryNode",
    "MemoryCoordinates",
    "MemoryNavigator",
    "NavigationPath",
    "SalienceEngine",
    "SalienceLevel",
    
    # Orchestrators
    "SovereignTickOrchestrator",
    "GovernanceOrchestrator",
    "ModelRouterOrchestrator",
    "CommandOrchestrator",
    
    # Company Onboarding
    "CompanyOnboarding",
    "OnboardingMode",
    "OnboardingStatus",
    "CompanyProfile",
    
    # Security
    "PermissionManager",
    "Permission",
    "PermissionGrant",
    "PermissionScope",
    "ProjectionSafetyEngine",
    "ProjectionBoundary",
    "SafeProjection",
    
    # Platform
    "MedinaPlatform",
    "create_platform",
]
