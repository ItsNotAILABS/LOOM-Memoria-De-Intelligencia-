"""
╔══════════════════════════════════════════════════════════════════════════════════╗
║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                          ║
║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA            ║
║  ALL RIGHTS RESERVED.                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════╝

SVA SCHEMAS — Core Data Models for Sovereign Validation Authority
=================================================================

PROT-403: SVA Schema Registry

Core invariants:
    - Every generated gene must have a target
    - Every active gene must have assertions
    - Every generation must preserve lineage
    - Every fitness score must name its strategy
    - Every promoted gene must have execution evidence

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Optional


# ═══════════════════════════════════════════════════════════════════════════════
# ENUMS
# ═══════════════════════════════════════════════════════════════════════════════

class FitnessStrategy(Enum):
    """Test gene fitness evaluation strategies."""
    COVERAGE_DRIVEN = "coverage_driven"
    FAILURE_DRIVEN = "failure_driven"
    BOUNDARY_DRIVEN = "boundary_driven"
    SEMANTIC_DRIVEN = "semantic_driven"
    MUTATION_DRIVEN = "mutation_driven"
    PERFORMANCE_DRIVEN = "performance_driven"
    SECURITY_DRIVEN = "security_driven"
    REGRESSION_DRIVEN = "regression_driven"
    CAPABILITY_DRIVEN = "capability_driven"


class TestType(Enum):
    """Types of tests a gene can represent."""
    UNIT = "unit"
    INTEGRATION = "integration"
    E2E = "e2e"
    PROPERTY = "property"
    MUTATION = "mutation"
    FUZZ = "fuzz"
    REGRESSION = "regression"
    PERFORMANCE = "performance"
    SECURITY = "security"
    CHAOS = "chaos"


class TargetType(Enum):
    """Types of targets a test can challenge."""
    FUNCTION = "function"
    COMPONENT = "component"
    WORKFLOW = "workflow"
    CAPABILITY = "capability"
    PROTOCOL = "protocol"
    RUNTIME = "runtime"
    CANISTER = "canister"
    MODULE = "module"
    API = "api"


class TestGeneStatus(Enum):
    """Lifecycle status of a test gene."""
    CANDIDATE = "candidate"        # Newly generated, unverified
    ACTIVE = "active"              # Verified, in regular rotation
    CERTIFIED_SUITE = "certified_suite"  # Part of certified test suite
    QUARANTINED = "quarantined"    # Flaky or problematic
    RETIRED = "retired"            # No longer relevant


class AssertionType(Enum):
    """Types of assertions a test can make."""
    EQUALS = "equals"
    NOT_EQUALS = "not_equals"
    THROWS = "throws"
    DOES_NOT_THROW = "does_not_throw"
    WITHIN_RANGE = "within_range"
    INVARIANT = "invariant"
    PROPERTY = "property"
    LATENCY = "latency"
    MEMORY = "memory"
    SIDE_EFFECT = "side_effect"
    CONTAINS = "contains"
    MATCHES_PATTERN = "matches_pattern"


class MutationType(Enum):
    """Types of mutations applied to test genes."""
    INPUT_CHANGE = "input_change"
    ASSERTION_CHANGE = "assertion_change"
    BOUNDARY_INJECTION = "boundary_injection"
    TIMING_CHANGE = "timing_change"
    TYPE_CHANGE = "type_change"
    STRUCTURE_CHANGE = "structure_change"
    ADVERSARIAL_CHANGE = "adversarial_change"


class ProofResult(Enum):
    """Result of an AUTE proof trace."""
    PASSED = "passed"
    FAILED = "failed"
    PARTIAL = "partial"
    BLOCKED = "blocked"


class CapabilityLevel(Enum):
    """Capability certification levels."""
    L0_UNTESTED = 0           # No evidence
    L1_UNIT_TESTED = 1        # Basic coverage
    L2_INTEGRATION_TESTED = 2  # Component interaction
    L3_E2E_TESTED = 3         # Full workflow
    L4_PROPERTY_TESTED = 4    # Invariant verified
    L5_FUZZ_TESTED = 5        # Boundary explored
    L6_MUTATION_TESTED = 6    # Defect injection survived
    L7_AUTE_EVOLVED = 7       # AI-challenged
    L8_PRODUCTION_MONITORED = 8  # Real-world validated
    L9_CERTIFIED = 9          # SVA approved


class ClaimsClass(Enum):
    """Classification of claims for external release."""
    C1_VERIFIED = "verified"       # Linked proof exists
    C2_SUPPORTED = "supported"     # Internal evidence, reproducible
    C3_HYPOTHESIS = "hypothesis"   # Plausible, untested
    C4_THESIS = "thesis"           # Strategic position, requires evidence


class CertificateStatus(Enum):
    """Status of a capability certificate."""
    PENDING = "pending"
    ISSUED = "issued"
    SUSPENDED = "suspended"
    REVOKED = "revoked"
    EXPIRED = "expired"


# ═══════════════════════════════════════════════════════════════════════════════
# ASSERTION RECORD
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class AssertionRecord:
    """
    A single assertion within a test gene.
    
    Assertions define the expected behavior that the test validates.
    """
    assertion_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    assertion_type: AssertionType = AssertionType.EQUALS
    expression: str = ""
    expected: Any = None
    tolerance: Optional[float] = None
    invariant_ref: Optional[str] = None
    
    def to_dict(self) -> dict:
        """Convert to dictionary for serialization."""
        return {
            "assertion_id": self.assertion_id,
            "assertion_type": self.assertion_type.value,
            "expression": self.expression,
            "expected": self.expected,
            "tolerance": self.tolerance,
            "invariant_ref": self.invariant_ref,
        }
    
    @classmethod
    def from_dict(cls, data: dict) -> "AssertionRecord":
        """Create from dictionary."""
        return cls(
            assertion_id=data.get("assertion_id", str(uuid.uuid4())),
            assertion_type=AssertionType(data.get("assertion_type", "equals")),
            expression=data.get("expression", ""),
            expected=data.get("expected"),
            tolerance=data.get("tolerance"),
            invariant_ref=data.get("invariant_ref"),
        )


# ═══════════════════════════════════════════════════════════════════════════════
# MUTATION RECORD
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class MutationRecord:
    """
    Record of a mutation applied to a test gene.
    
    Mutations drive the evolution of test populations.
    """
    mutation_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    mutation_type: MutationType = MutationType.INPUT_CHANGE
    before_ref: str = ""
    after_ref: str = ""
    reason: str = ""
    created_at: int = field(default_factory=lambda: int(time.time() * 1000))
    
    def to_dict(self) -> dict:
        """Convert to dictionary for serialization."""
        return {
            "mutation_id": self.mutation_id,
            "mutation_type": self.mutation_type.value,
            "before_ref": self.before_ref,
            "after_ref": self.after_ref,
            "reason": self.reason,
            "created_at": self.created_at,
        }
    
    @classmethod
    def from_dict(cls, data: dict) -> "MutationRecord":
        """Create from dictionary."""
        return cls(
            mutation_id=data.get("mutation_id", str(uuid.uuid4())),
            mutation_type=MutationType(data.get("mutation_type", "input_change")),
            before_ref=data.get("before_ref", ""),
            after_ref=data.get("after_ref", ""),
            reason=data.get("reason", ""),
            created_at=data.get("created_at", int(time.time() * 1000)),
        )


# ═══════════════════════════════════════════════════════════════════════════════
# TEST GENE
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class TestGene:
    """
    A test gene represents an evolving test case.
    
    Test genes are the fundamental unit of AUTE's evolutionary testing system.
    They carry inputs, assertions, fitness, and lineage information.
    
    Core invariants:
        - Every generated gene must have a target
        - Every active gene must have assertions
        - Every generation must preserve lineage
        - Every fitness score must name its strategy
    """
    gene_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    target_id: str = ""
    target_type: TargetType = TargetType.FUNCTION
    test_type: TestType = TestType.UNIT
    inputs: list = field(default_factory=list)
    assertions: list[AssertionRecord] = field(default_factory=list)
    fitness: float = 0.0
    strategy: FitnessStrategy = FitnessStrategy.COVERAGE_DRIVEN
    generation: int = 0
    parent_gene_ids: list[str] = field(default_factory=list)
    mutation_history: list[MutationRecord] = field(default_factory=list)
    discovered_by: str = "aute"  # "human" | "aute" | "bot" | "sva" | "cpl_pulse"
    status: TestGeneStatus = TestGeneStatus.CANDIDATE
    created_at: int = field(default_factory=lambda: int(time.time() * 1000))
    updated_at: int = field(default_factory=lambda: int(time.time() * 1000))
    
    # Execution metadata
    last_execution_time_ms: Optional[float] = None
    last_execution_passed: Optional[bool] = None
    execution_count: int = 0
    failure_count: int = 0
    
    def to_dict(self) -> dict:
        """Convert to dictionary for serialization."""
        return {
            "gene_id": self.gene_id,
            "target_id": self.target_id,
            "target_type": self.target_type.value,
            "test_type": self.test_type.value,
            "inputs": self.inputs,
            "assertions": [a.to_dict() for a in self.assertions],
            "fitness": self.fitness,
            "strategy": self.strategy.value,
            "generation": self.generation,
            "parent_gene_ids": self.parent_gene_ids,
            "mutation_history": [m.to_dict() for m in self.mutation_history],
            "discovered_by": self.discovered_by,
            "status": self.status.value,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
            "last_execution_time_ms": self.last_execution_time_ms,
            "last_execution_passed": self.last_execution_passed,
            "execution_count": self.execution_count,
            "failure_count": self.failure_count,
        }
    
    @classmethod
    def from_dict(cls, data: dict) -> "TestGene":
        """Create from dictionary."""
        return cls(
            gene_id=data.get("gene_id", str(uuid.uuid4())),
            target_id=data.get("target_id", ""),
            target_type=TargetType(data.get("target_type", "function")),
            test_type=TestType(data.get("test_type", "unit")),
            inputs=data.get("inputs", []),
            assertions=[AssertionRecord.from_dict(a) for a in data.get("assertions", [])],
            fitness=data.get("fitness", 0.0),
            strategy=FitnessStrategy(data.get("strategy", "coverage_driven")),
            generation=data.get("generation", 0),
            parent_gene_ids=data.get("parent_gene_ids", []),
            mutation_history=[MutationRecord.from_dict(m) for m in data.get("mutation_history", [])],
            discovered_by=data.get("discovered_by", "aute"),
            status=TestGeneStatus(data.get("status", "candidate")),
            created_at=data.get("created_at", int(time.time() * 1000)),
            updated_at=data.get("updated_at", int(time.time() * 1000)),
            last_execution_time_ms=data.get("last_execution_time_ms"),
            last_execution_passed=data.get("last_execution_passed"),
            execution_count=data.get("execution_count", 0),
            failure_count=data.get("failure_count", 0),
        )
    
    def record_execution(self, passed: bool, time_ms: float):
        """Record an execution of this test gene."""
        self.execution_count += 1
        if not passed:
            self.failure_count += 1
        self.last_execution_passed = passed
        self.last_execution_time_ms = time_ms
        self.updated_at = int(time.time() * 1000)
    
    def promote(self, new_status: TestGeneStatus):
        """Promote gene to new status."""
        self.status = new_status
        self.updated_at = int(time.time() * 1000)
    
    def add_mutation(self, mutation: MutationRecord):
        """Add mutation to history."""
        self.mutation_history.append(mutation)
        self.updated_at = int(time.time() * 1000)


# ═══════════════════════════════════════════════════════════════════════════════
# TEST POPULATION
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class TestPopulation:
    """
    A population of test genes evolving together.
    
    Populations track the collective evolution of tests for a target.
    """
    population_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    target_id: str = ""
    capability_id: Optional[str] = None
    generation: int = 0
    gene_ids: list[str] = field(default_factory=list)
    best_fitness: float = 0.0
    average_fitness: float = 0.0
    diversity_score: float = 0.0
    coverage_score: float = 0.0
    failure_discovery_score: float = 0.0
    last_evolved_at: int = field(default_factory=lambda: int(time.time() * 1000))
    
    def to_dict(self) -> dict:
        """Convert to dictionary for serialization."""
        return {
            "population_id": self.population_id,
            "target_id": self.target_id,
            "capability_id": self.capability_id,
            "generation": self.generation,
            "gene_ids": self.gene_ids,
            "best_fitness": self.best_fitness,
            "average_fitness": self.average_fitness,
            "diversity_score": self.diversity_score,
            "coverage_score": self.coverage_score,
            "failure_discovery_score": self.failure_discovery_score,
            "last_evolved_at": self.last_evolved_at,
        }
    
    @classmethod
    def from_dict(cls, data: dict) -> "TestPopulation":
        """Create from dictionary."""
        return cls(
            population_id=data.get("population_id", str(uuid.uuid4())),
            target_id=data.get("target_id", ""),
            capability_id=data.get("capability_id"),
            generation=data.get("generation", 0),
            gene_ids=data.get("gene_ids", []),
            best_fitness=data.get("best_fitness", 0.0),
            average_fitness=data.get("average_fitness", 0.0),
            diversity_score=data.get("diversity_score", 0.0),
            coverage_score=data.get("coverage_score", 0.0),
            failure_discovery_score=data.get("failure_discovery_score", 0.0),
            last_evolved_at=data.get("last_evolved_at", int(time.time() * 1000)),
        )
    
    def advance_generation(self, new_gene_ids: list[str], stats: dict):
        """Advance to next generation with new genes."""
        self.generation += 1
        self.gene_ids = new_gene_ids
        self.best_fitness = stats.get("best_fitness", self.best_fitness)
        self.average_fitness = stats.get("average_fitness", self.average_fitness)
        self.diversity_score = stats.get("diversity_score", self.diversity_score)
        self.coverage_score = stats.get("coverage_score", self.coverage_score)
        self.failure_discovery_score = stats.get("failure_discovery_score", self.failure_discovery_score)
        self.last_evolved_at = int(time.time() * 1000)


# ═══════════════════════════════════════════════════════════════════════════════
# AUTE RUN RECORD
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class AuteRunRecord:
    """
    Record of a single AUTE evolution run.
    """
    run_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    target_id: str = ""
    capability_id: Optional[str] = None
    strategy: FitnessStrategy = FitnessStrategy.COVERAGE_DRIVEN
    generation_start: int = 0
    generation_end: int = 0
    tests_generated: int = 0
    tests_executed: int = 0
    tests_passed: int = 0
    tests_failed: int = 0
    bugs_discovered: int = 0
    coverage_delta: float = 0.0
    mutation_score: Optional[float] = None
    best_gene_ids: list[str] = field(default_factory=list)
    proof_trace_id: str = ""
    evidence_refs: list[str] = field(default_factory=list)
    created_at: int = field(default_factory=lambda: int(time.time() * 1000))
    
    def to_dict(self) -> dict:
        """Convert to dictionary for serialization."""
        return {
            "run_id": self.run_id,
            "target_id": self.target_id,
            "capability_id": self.capability_id,
            "strategy": self.strategy.value,
            "generation_start": self.generation_start,
            "generation_end": self.generation_end,
            "tests_generated": self.tests_generated,
            "tests_executed": self.tests_executed,
            "tests_passed": self.tests_passed,
            "tests_failed": self.tests_failed,
            "bugs_discovered": self.bugs_discovered,
            "coverage_delta": self.coverage_delta,
            "mutation_score": self.mutation_score,
            "best_gene_ids": self.best_gene_ids,
            "proof_trace_id": self.proof_trace_id,
            "evidence_refs": self.evidence_refs,
            "created_at": self.created_at,
        }


# ═══════════════════════════════════════════════════════════════════════════════
# AUTE PROOF TRACE
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class AUTEProofTrace:
    """
    Proof trace for an AUTE evolution session.
    
    AUTE proof must include:
        - target analyzed
        - generation number
        - strategy used
        - genes generated
        - genes executed
        - fitness results
        - failures discovered
        - promoted genes
        - quarantined genes
        - evidence refs
        - test output refs
        - source commit or runtime version
    """
    proof_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    run_id: str = ""
    target_id: str = ""
    capability_id: Optional[str] = None
    strategy: FitnessStrategy = FitnessStrategy.COVERAGE_DRIVEN
    generation_range: tuple[int, int] = (0, 0)
    genes_generated: int = 0
    genes_executed: int = 0
    failures_discovered: int = 0
    promoted_gene_ids: list[str] = field(default_factory=list)
    quarantined_gene_ids: list[str] = field(default_factory=list)
    evidence_refs: list[str] = field(default_factory=list)
    result: ProofResult = ProofResult.PASSED
    source_commit: Optional[str] = None
    runtime_version: Optional[str] = None
    created_at: int = field(default_factory=lambda: int(time.time() * 1000))
    
    def to_dict(self) -> dict:
        """Convert to dictionary for serialization."""
        return {
            "proof_id": self.proof_id,
            "run_id": self.run_id,
            "target_id": self.target_id,
            "capability_id": self.capability_id,
            "strategy": self.strategy.value,
            "generation_range": list(self.generation_range),
            "genes_generated": self.genes_generated,
            "genes_executed": self.genes_executed,
            "failures_discovered": self.failures_discovered,
            "promoted_gene_ids": self.promoted_gene_ids,
            "quarantined_gene_ids": self.quarantined_gene_ids,
            "evidence_refs": self.evidence_refs,
            "result": self.result.value,
            "source_commit": self.source_commit,
            "runtime_version": self.runtime_version,
            "created_at": self.created_at,
        }


# ═══════════════════════════════════════════════════════════════════════════════
# CAPABILITY RECORD
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class CapabilityRecord:
    """
    A registered capability in the SVA system.
    
    Capabilities are the targets of certification.
    """
    capability_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    description: str = ""
    owner: str = ""
    level: CapabilityLevel = CapabilityLevel.L0_UNTESTED
    claims_class: ClaimsClass = ClaimsClass.C3_HYPOTHESIS
    test_suite_ids: list[str] = field(default_factory=list)
    evidence_refs: list[str] = field(default_factory=list)
    certificate_id: Optional[str] = None
    protocol_ref: Optional[str] = None
    created_at: int = field(default_factory=lambda: int(time.time() * 1000))
    updated_at: int = field(default_factory=lambda: int(time.time() * 1000))
    
    def to_dict(self) -> dict:
        """Convert to dictionary for serialization."""
        return {
            "capability_id": self.capability_id,
            "name": self.name,
            "description": self.description,
            "owner": self.owner,
            "level": self.level.value,
            "claims_class": self.claims_class.value,
            "test_suite_ids": self.test_suite_ids,
            "evidence_refs": self.evidence_refs,
            "certificate_id": self.certificate_id,
            "protocol_ref": self.protocol_ref,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
        }


# ═══════════════════════════════════════════════════════════════════════════════
# CERTIFICATE RECORD
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class CertificateRecord:
    """
    A capability certificate issued by SVA.
    
    Certificates are the output of the certification process.
    """
    certificate_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    capability_id: str = ""
    level: CapabilityLevel = CapabilityLevel.L0_UNTESTED
    status: CertificateStatus = CertificateStatus.PENDING
    issued_at: Optional[int] = None
    expires_at: Optional[int] = None
    revoked_at: Optional[int] = None
    revocation_reason: Optional[str] = None
    evidence_refs: list[str] = field(default_factory=list)
    proof_trace_ids: list[str] = field(default_factory=list)
    issuer: str = "SVA"
    
    def to_dict(self) -> dict:
        """Convert to dictionary for serialization."""
        return {
            "certificate_id": self.certificate_id,
            "capability_id": self.capability_id,
            "level": self.level.value,
            "status": self.status.value,
            "issued_at": self.issued_at,
            "expires_at": self.expires_at,
            "revoked_at": self.revoked_at,
            "revocation_reason": self.revocation_reason,
            "evidence_refs": self.evidence_refs,
            "proof_trace_ids": self.proof_trace_ids,
            "issuer": self.issuer,
        }
    
    def issue(self):
        """Issue the certificate."""
        self.status = CertificateStatus.ISSUED
        self.issued_at = int(time.time() * 1000)
    
    def revoke(self, reason: str):
        """Revoke the certificate."""
        self.status = CertificateStatus.REVOKED
        self.revoked_at = int(time.time() * 1000)
        self.revocation_reason = reason
    
    def suspend(self):
        """Suspend the certificate pending review."""
        self.status = CertificateStatus.SUSPENDED
