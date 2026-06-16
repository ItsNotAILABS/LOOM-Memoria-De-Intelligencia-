"""
MEDINA / NOVA OVO — Memory Temple · Multi-Model Runtime · Governance OS
========================================================================
Sovereign memory-operating intelligence platform.

Architecture grounded in RECITAL_PLUS_ONE law:

  state(n+1) = recital(Ψ_n) ⊕ Δ_lawful

Where:
  Ψ_n      = validated organism state at beat n
  ⊕        = lawful expansion operator (Gate A authorized)
  Δ_lawful = one expansion unit conforming to doctrine

Core Components:
- Memory Temple: Navigable geometry (helix/ring/coordinates)
- Universal Chat: One control surface for all platform planes
- Governance: Built-in with Gate A/B/C enforcement
- Company Onboarding: Connect/Internalize/Hybrid modes
- Multi-Model Runtime: R/U/D/N model families
- Orchestrators: Beat-driven with heart-brain coupling
- Kernel Compression: Symbolic intelligence compression/expansion

KERNEL COMPRESSION SYSTEM:
Every document organism holds a compressed symbolic kernel of its full
intelligence. When that kernel is called at any point in time, from any
organism, it expands back into the complete document and executes.
The symbol holds everything. The organism reads the symbol and knows
everything behind it.

ORGANISM_SOVEREIGN registers: Founder · Builder · Organism · External
Gates: A (runtime) · B (workforce) · C (projection)

Non-negotiable Laws:
1. RECITAL_PLUS_ONE: state evolution with lineage
2. Four registers required: Founder, Builder, Organism, External
3. Dual-read always-on: semantic + resonance
4. No-collapse ontology: Absolute ≠ Law ≠ Model ≠ Engine ≠ Core ≠ Module
5. Core A/B authority: Core B proposes, Core A accepts
6. Gates A/B/C: No bypass
"""

__version__ = "1.1.0"
__codename__ = "MEDINA V1 — KERNEL"

# Core sovereign architecture
from .core import (
    OrganismSovereign,
    Register,
    RecitalEngine,
    OrganismState,
    GateEnforcer,
    GateLevel,
    GateDecision,
)

# Memory Temple
from .memory import (
    MemoryTemple,
    MemoryNode,
    MemoryNavigator,
    TorusCoordinate,
    ConsolidationEngine,
    PromotionEvent,
)

# Chat Control Plane
from .chat import (
    CommandParser,
    ParsedCommand,
    CommandRouter,
)

# Governance
from .governance import (
    ProposalEngine,
    Proposal,
    ProposalStatus,
    ApprovalEngine,
    ApprovalDecision,
    PermissionManager,
    Role,
    Permission,
    AccessScope,
)

# Models
from .models import (
    ModelRegistry,
    ModelDefinition,
    ModelFamily,
    ModelRouter,
    RoutingDecision,
)

# Company Onboarding
from .company import (
    CompanyOnboarder,
    OnboardingMode,
    OnboardingStatus,
)

# Orchestrators
from .orchestrators import (
    Orchestrator,
    OrchestratorStatus,
    BeatResult,
    SovereignTickOrchestrator,
    HeartbeatEngine,
    CardiacState,
)

# Documents
from .documents import (
    DocumentOrganism,
    DocumentStatus,
    DocumentType,
    DocumentVersion,
    DocumentChain,
    DocumentWorkforce,
    OrganismMode,
)

# CPL (Cognitive Procurement Language)
from .cpl import (
    CPLMessage,
    CPLIntent,
    CPLAuthority,
    CPLRouter,
    CPLSubstrate,
    SubstrateConfig,
    create_cpl_message,
    validate_cpl_message,
)

# Kernel Compression
from .kernel import (
    KernelSymbol,
    KernelMetadata,
    KernelIntegrity,
    CompressionLevel,
    KernelCompressor,
    CompressionResult,
    CompressionStrategy,
    KernelExpander,
    ExpansionResult,
    ExpansionContext,
    KernelExecutor,
    ExecutionResult,
    ExecutionContext,
    KernelRegistry,
    KernelLookup,
)

# Resonance (Tier-11 Cross-Organism)
from .resonance import (
    ResonanceBus,
    OrganismConnection,
    ResonanceState,
    CouplingMatrix,
    CouplingRule,
    BoundedCoupling,
    compute_kuramoto_coupling,
    ResonancePropagator,
    PropagationEvent,
    PropagationResult,
    ShellInfluence,
)

# Sovereign Hierarchy
from .sovereign import (
    SovereignNode,
    MacroHierarchy,
    NodeLevel,
)

# Workspace
from .workspace import (
    WorkPacket,
    PacketType,
    TaskConstitution,
    IntegrationContract,
    ContractStatus,
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

# Projection
from .projection import (
    ProjectionBoundary,
    SafeProjection,
    ProjectionType,
)

# Economics Organism (PROT-377 to PROT-382)
from .economics import (
    EconomicsOrganismEngine,
    ResourceAllocator,
    MarketEngine,
    ValueEngine,
    DecisionEngine,
    PHI as ECONOMICS_PHI,
    PHI_10 as ECONOMICS_FREQUENCY,
    LOSS_AVERSION_LAMBDA,
    ANCHORING_PERSISTENCE,
    REPRESENTATIVENESS_FAILURE,
    AVAILABILITY_RECENCY_WEIGHT,
    REGRET_AVERSION_THRESHOLD,
    FRAMING_EFFECT_MAGNITUDE,
    HORMETIC_STRESS_FLOOR,
    HORMETIC_STRESS_CEILING,
    HYPERBOLIC_K,
    SILVER_PREMIUM,
)

__all__ = [
    # Version
    "__version__",
    "__codename__",
    # Core
    "OrganismSovereign",
    "Register",
    "RecitalEngine",
    "OrganismState",
    "GateEnforcer",
    "GateLevel",
    "GateDecision",
    # Memory
    "MemoryTemple",
    "MemoryNode",
    "MemoryNavigator",
    "TorusCoordinate",
    "ConsolidationEngine",
    "PromotionEvent",
    # Chat
    "CommandParser",
    "ParsedCommand",
    "CommandRouter",
    # Governance
    "ProposalEngine",
    "Proposal",
    "ProposalStatus",
    "ApprovalEngine",
    "ApprovalDecision",
    "PermissionManager",
    "Role",
    "Permission",
    "AccessScope",
    # Models
    "ModelRegistry",
    "ModelDefinition",
    "ModelFamily",
    "ModelRouter",
    "RoutingDecision",
    # Company
    "CompanyOnboarder",
    "OnboardingMode",
    "OnboardingStatus",
    # Orchestrators
    "Orchestrator",
    "OrchestratorStatus",
    "BeatResult",
    "SovereignTickOrchestrator",
    "HeartbeatEngine",
    "CardiacState",
    # Documents
    "DocumentOrganism",
    "DocumentStatus",
    "DocumentType",
    "DocumentVersion",
    "DocumentChain",
    "DocumentWorkforce",
    "OrganismMode",
    # CPL (Cognitive Procurement Language)
    "CPLMessage",
    "CPLIntent",
    "CPLAuthority",
    "CPLRouter",
    "CPLSubstrate",
    "SubstrateConfig",
    "create_cpl_message",
    "validate_cpl_message",
    # Kernel Compression
    "KernelSymbol",
    "KernelMetadata",
    "KernelIntegrity",
    "CompressionLevel",
    "KernelCompressor",
    "CompressionResult",
    "CompressionStrategy",
    "KernelExpander",
    "ExpansionResult",
    "ExpansionContext",
    "KernelExecutor",
    "ExecutionResult",
    "ExecutionContext",
    "KernelRegistry",
    "KernelLookup",
    # Resonance (Tier-11)
    "ResonanceBus",
    "OrganismConnection",
    "ResonanceState",
    "CouplingMatrix",
    "CouplingRule",
    "BoundedCoupling",
    "compute_kuramoto_coupling",
    "ResonancePropagator",
    "PropagationEvent",
    "PropagationResult",
    "ShellInfluence",
    # Sovereign
    "SovereignNode",
    "MacroHierarchy",
    "NodeLevel",
    # Workspace
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
    # Projection
    "ProjectionBoundary",
    "SafeProjection",
    "ProjectionType",
    # Economics Organism (PROT-377 to PROT-382)
    "EconomicsOrganismEngine",
    "ResourceAllocator",
    "MarketEngine",
    "ValueEngine",
    "DecisionEngine",
    "ECONOMICS_PHI",
    "ECONOMICS_FREQUENCY",
    "LOSS_AVERSION_LAMBDA",
    "ANCHORING_PERSISTENCE",
    "REPRESENTATIVENESS_FAILURE",
    "AVAILABILITY_RECENCY_WEIGHT",
    "REGRET_AVERSION_THRESHOLD",
    "FRAMING_EFFECT_MAGNITUDE",
    "HORMETIC_STRESS_FLOOR",
    "HORMETIC_STRESS_CEILING",
    "HYPERBOLIC_K",
    "SILVER_PREMIUM",
]
