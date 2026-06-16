"""
╔══════════════════════════════════════════════════════════════════════════════════╗
║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                          ║
║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA            ║
║  ALL RIGHTS RESERVED.                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════╝

SOVEREIGN VALIDATION AUTHORITY (SVA) — AUCTORITAS VALIDATIONIS SOVEREIGNA
=========================================================================

The organism's sovereign QA/certification substrate.

CORE DOCTRINE:
    No capability is real until it is tested, proof-linked, monitored, and revocable.
    No capability is fully challenged until tests can evolve beyond human imagination.

SVA MISSION:
    Turn tests into proof, proof into certificates, certificates into monitored trust,
    and monitored trust into organism memory.

SVA/AUTE RELATIONSHIP:
    - SVA certifies what is real
    - AUTE evolves the tests that try to prove it is not
    - CPL/PULSE records the proof
    - Memory makes the organism harder to fool next time

PROTOCOLS:
    PROTO-SVA-001: Capability Certification Protocol
    PROTO-SVA-002: Autonomous Testing Protocol
    PROTO-SVA-003: Test Immune Response Protocol
    PROTO-SVA-004: Certification Revocation Protocol
    PROTO-SVA-005: Claims Evidence Protocol
    PROTO-SVA-AUTE-001: Test Gene Evolution Protocol
    PROTO-SVA-AUTE-002: Boundary Discovery Protocol
    PROTO-SVA-AUTE-003: Test Fitness Protocol
    PROTO-SVA-AUTE-004: Genetic Operator Protocol
    PROTO-SVA-AUTE-005: Verification Paradox Protocol
    PROTO-SVA-AUTE-006: Test Memory Protocol

DSL REGISTRY:
    CTL: Capability Testing Language
    MTL: Memory Testing Language
    WTL: Workflow Testing Language
    ATL: Autonomous Testing Language
    ETL: Exam Testing Language

CAPABILITY LEVELS:
    L0: Untested — No evidence
    L1: Unit Tested — Basic coverage
    L2: Integration Tested — Component interaction
    L3: E2E Tested — Full workflow
    L4: Property Tested — Invariant verified
    L5: Fuzz Tested — Boundary explored
    L6: Mutation Tested — Defect injection survived
    L7: AUTE Evolved — AI-challenged
    L8: Production Monitored — Real-world validated
    L9: Certified — SVA approved

CLAIMS CLASSIFICATION:
    C1: Verified — Linked proof exists
    C2: Supported — Internal evidence, reproducible
    C3: Hypothesis — Plausible, untested
    C4: Thesis — Strategic position, requires evidence before external release

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
Protocol: PROT-403 to PROT-414 (SVA Domain)
"""

__version__ = "1.0.0"
__protocol_range__ = "PROT-403 to PROT-414"
__scc__ = 4.97
__organism_key__ = "PRIMA CAUSA"

# ── φ Constants ───────────────────────────────────────────────────────────────
PHI = 1.6180339887498948482
PHI_SQ = PHI ** 2                    # 2.618
PHI_CUBED = PHI ** 3                 # 4.236
PHI_INV = 1.0 / PHI                  # 0.618
PHI_13 = PHI ** 13                   # 521.002 Hz (SVA frequency)
SCHUMANN = 7.83

# ── Core Schemas ──────────────────────────────────────────────────────────────
from nova_ovo.sva.schemas import (
    # Fitness strategies
    FitnessStrategy,
    
    # Assertion and mutation records
    AssertionRecord,
    AssertionType,
    MutationRecord,
    MutationType,
    
    # Test genes and populations
    TestGene,
    TestGeneStatus,
    TestType,
    TargetType,
    TestPopulation,
    
    # AUTE run and proof
    AuteRunRecord,
    AUTEProofTrace,
    ProofResult,
    
    # Capability and certificate
    CapabilityLevel,
    ClaimsClass,
    CapabilityRecord,
    CertificateRecord,
    CertificateStatus,
)

# ── Registries ────────────────────────────────────────────────────────────────
from nova_ovo.sva.registry import (
    CapabilityRegistry,
    TestSuiteRegistry,
    EvidenceRegistry,
    CertificateRegistry,
)

# ── Boundary Generator ────────────────────────────────────────────────────────
from nova_ovo.sva.boundary_generator import (
    BoundaryGenerator,
    BoundaryClass,
    BoundaryValue,
)

# ── Fitness Evaluator ─────────────────────────────────────────────────────────
from nova_ovo.sva.fitness_evaluator import (
    FitnessEvaluator,
    FitnessScore,
    FitnessReport,
)

# ── Genetic Operators ─────────────────────────────────────────────────────────
from nova_ovo.sva.genetic_operators import (
    GeneticOperators,
    SelectionResult,
    CrossoverResult,
    MutationResult,
)

# ── Evidence Feed ─────────────────────────────────────────────────────────────
from nova_ovo.sva.evidence_feed import (
    EvidenceFeed,
    EvidenceRecord,
    EvidenceType,
)

# ── Certification Engine ──────────────────────────────────────────────────────
from nova_ovo.sva.certification_engine import (
    CertificationEngine,
    CertificationDecision,
    RevocationReason,
)

# ── AUTE Engine ───────────────────────────────────────────────────────────────
from nova_ovo.sva.aute_engine import (
    AUTEEngine,
    EvolutionConfig,
    EvolutionResult,
)

__all__ = [
    # Version
    "__version__",
    "__protocol_range__",
    "__scc__",
    
    # Constants
    "PHI",
    "PHI_SQ",
    "PHI_13",
    
    # Fitness strategies
    "FitnessStrategy",
    
    # Assertion and mutation
    "AssertionRecord",
    "AssertionType",
    "MutationRecord",
    "MutationType",
    
    # Test genes and populations
    "TestGene",
    "TestGeneStatus",
    "TestType",
    "TargetType",
    "TestPopulation",
    
    # AUTE run and proof
    "AuteRunRecord",
    "AUTEProofTrace",
    "ProofResult",
    
    # Capability and certificate
    "CapabilityLevel",
    "ClaimsClass",
    "CapabilityRecord",
    "CertificateRecord",
    "CertificateStatus",
    
    # Registries
    "CapabilityRegistry",
    "TestSuiteRegistry",
    "EvidenceRegistry",
    "CertificateRegistry",
    
    # Boundary generator
    "BoundaryGenerator",
    "BoundaryClass",
    "BoundaryValue",
    
    # Fitness evaluator
    "FitnessEvaluator",
    "FitnessScore",
    "FitnessReport",
    
    # Genetic operators
    "GeneticOperators",
    "SelectionResult",
    "CrossoverResult",
    "MutationResult",
    
    # Evidence feed
    "EvidenceFeed",
    "EvidenceRecord",
    "EvidenceType",
    
    # Certification engine
    "CertificationEngine",
    "CertificationDecision",
    "RevocationReason",
    
    # AUTE engine
    "AUTEEngine",
    "EvolutionConfig",
    "EvolutionResult",
]
