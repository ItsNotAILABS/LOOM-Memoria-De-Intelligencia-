"""
╔══════════════════════════════════════════════════════════════════════════════════╗
║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                          ║
║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA            ║
║  ALL RIGHTS RESERVED.                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════╝

SVA EVIDENCE FEED — PROTO-SVA-005 Claims Evidence Protocol
===========================================================

PROT-408: Evidence Feed System

Turn discovered failures and high-value tests into organism memory.

Memory outputs:
    - new regression tests
    - known failure patterns
    - capability weaknesses
    - fragile boundaries
    - mutation survivors
    - recurring bug families
    - certificate degradation triggers

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Optional

from nova_ovo.sva.schemas import (
    AUTEProofTrace,
    AuteRunRecord,
    ProofResult,
    FitnessStrategy,
    TestGene,
    ClaimsClass,
)


# ═══════════════════════════════════════════════════════════════════════════════
# EVIDENCE TYPES
# ═══════════════════════════════════════════════════════════════════════════════

class EvidenceType(Enum):
    """Types of evidence that can be recorded."""
    TEST_EXECUTION = "test_execution"
    COVERAGE_REPORT = "coverage_report"
    BUG_DISCOVERY = "bug_discovery"
    MUTATION_RESULT = "mutation_result"
    PERFORMANCE_METRIC = "performance_metric"
    SECURITY_SCAN = "security_scan"
    BOUNDARY_HIT = "boundary_hit"
    INVARIANT_VERIFICATION = "invariant_verification"
    REGRESSION_DETECTION = "regression_detection"
    BOT_PROOF_RECORD = "bot_proof_record"
    AUTE_PROOF_TRACE = "aute_proof_trace"
    EXTERNAL_AUDIT = "external_audit"
    HUMAN_REVIEW = "human_review"


# ═══════════════════════════════════════════════════════════════════════════════
# EVIDENCE RECORD
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class EvidenceRecord:
    """
    A piece of evidence supporting capability certification.
    """
    evidence_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    evidence_type: EvidenceType = EvidenceType.TEST_EXECUTION
    source: str = ""  # "aute" | "bot" | "human" | "external" | "cpl_pulse"
    target_id: str = ""
    capability_id: Optional[str] = None
    content_ref: str = ""  # Reference to full content
    summary: str = ""
    claims_class: ClaimsClass = ClaimsClass.C2_SUPPORTED
    confidence: float = 0.0  # 0-1 confidence score
    metadata: dict = field(default_factory=dict)
    created_at: int = field(default_factory=lambda: int(time.time() * 1000))
    
    def to_dict(self) -> dict:
        """Convert to dictionary for serialization."""
        return {
            "evidence_id": self.evidence_id,
            "evidence_type": self.evidence_type.value,
            "source": self.source,
            "target_id": self.target_id,
            "capability_id": self.capability_id,
            "content_ref": self.content_ref,
            "summary": self.summary,
            "claims_class": self.claims_class.value,
            "confidence": self.confidence,
            "metadata": self.metadata,
            "created_at": self.created_at,
        }
    
    @classmethod
    def from_dict(cls, data: dict) -> "EvidenceRecord":
        """Create from dictionary."""
        return cls(
            evidence_id=data.get("evidence_id", str(uuid.uuid4())),
            evidence_type=EvidenceType(data.get("evidence_type", "test_execution")),
            source=data.get("source", ""),
            target_id=data.get("target_id", ""),
            capability_id=data.get("capability_id"),
            content_ref=data.get("content_ref", ""),
            summary=data.get("summary", ""),
            claims_class=ClaimsClass(data.get("claims_class", "supported")),
            confidence=data.get("confidence", 0.0),
            metadata=data.get("metadata", {}),
            created_at=data.get("created_at", int(time.time() * 1000)),
        )


# ═══════════════════════════════════════════════════════════════════════════════
# EVIDENCE FEED
# ═══════════════════════════════════════════════════════════════════════════════

class EvidenceFeed:
    """
    AUTE/SVA Evidence Feed System.
    
    PROTO-SVA-005: Claims Evidence Protocol
    
    Collects, processes, and stores evidence for capability certification.
    """
    
    def __init__(self):
        """Initialize evidence feed."""
        self.records: list[EvidenceRecord] = []
        self.proof_traces: list[AUTEProofTrace] = []
    
    # ── Evidence Recording ────────────────────────────────────────────────────
    
    def record_test_execution(
        self,
        gene: TestGene,
        passed: bool,
        execution_time_ms: float,
        output: str = "",
        capability_id: Optional[str] = None,
    ) -> EvidenceRecord:
        """Record evidence from a test execution."""
        record = EvidenceRecord(
            evidence_type=EvidenceType.TEST_EXECUTION,
            source="aute" if gene.discovered_by == "aute" else gene.discovered_by,
            target_id=gene.target_id,
            capability_id=capability_id,
            content_ref=gene.gene_id,
            summary=f"Test {'passed' if passed else 'failed'} in {execution_time_ms:.2f}ms",
            claims_class=ClaimsClass.C1_VERIFIED if passed else ClaimsClass.C2_SUPPORTED,
            confidence=gene.fitness,
            metadata={
                "gene_id": gene.gene_id,
                "passed": passed,
                "execution_time_ms": execution_time_ms,
                "generation": gene.generation,
                "strategy": gene.strategy.value,
                "output_preview": output[:500] if output else "",
            },
        )
        self.records.append(record)
        return record
    
    def record_bug_discovery(
        self,
        gene: TestGene,
        bug_description: str,
        severity: str,
        reproducible: bool,
        capability_id: Optional[str] = None,
    ) -> EvidenceRecord:
        """Record evidence of a bug discovery."""
        record = EvidenceRecord(
            evidence_type=EvidenceType.BUG_DISCOVERY,
            source="aute",
            target_id=gene.target_id,
            capability_id=capability_id,
            content_ref=gene.gene_id,
            summary=f"Bug discovered: {bug_description[:100]}",
            claims_class=ClaimsClass.C1_VERIFIED if reproducible else ClaimsClass.C2_SUPPORTED,
            confidence=0.9 if reproducible else 0.6,
            metadata={
                "gene_id": gene.gene_id,
                "bug_description": bug_description,
                "severity": severity,
                "reproducible": reproducible,
                "inputs": gene.inputs,
            },
        )
        self.records.append(record)
        return record
    
    def record_coverage(
        self,
        target_id: str,
        line_coverage: float,
        branch_coverage: float,
        path_coverage: float = 0.0,
        capability_id: Optional[str] = None,
    ) -> EvidenceRecord:
        """Record coverage metrics evidence."""
        record = EvidenceRecord(
            evidence_type=EvidenceType.COVERAGE_REPORT,
            source="aute",
            target_id=target_id,
            capability_id=capability_id,
            summary=f"Coverage: {line_coverage:.1%} line, {branch_coverage:.1%} branch",
            claims_class=ClaimsClass.C1_VERIFIED,
            confidence=min(line_coverage, branch_coverage),
            metadata={
                "line_coverage": line_coverage,
                "branch_coverage": branch_coverage,
                "path_coverage": path_coverage,
            },
        )
        self.records.append(record)
        return record
    
    def record_mutation_result(
        self,
        target_id: str,
        mutants_killed: int,
        total_mutants: int,
        survived_mutants: list[str],
        capability_id: Optional[str] = None,
    ) -> EvidenceRecord:
        """Record mutation testing results."""
        mutation_score = mutants_killed / max(1, total_mutants)
        record = EvidenceRecord(
            evidence_type=EvidenceType.MUTATION_RESULT,
            source="aute",
            target_id=target_id,
            capability_id=capability_id,
            summary=f"Mutation score: {mutation_score:.1%} ({mutants_killed}/{total_mutants})",
            claims_class=ClaimsClass.C1_VERIFIED,
            confidence=mutation_score,
            metadata={
                "mutants_killed": mutants_killed,
                "total_mutants": total_mutants,
                "mutation_score": mutation_score,
                "survived_mutants": survived_mutants[:10],  # Limit for storage
            },
        )
        self.records.append(record)
        return record
    
    def record_boundary_hit(
        self,
        gene: TestGene,
        boundary_class: str,
        boundary_value: str,
        caused_failure: bool,
        capability_id: Optional[str] = None,
    ) -> EvidenceRecord:
        """Record evidence of a boundary condition hit."""
        record = EvidenceRecord(
            evidence_type=EvidenceType.BOUNDARY_HIT,
            source="aute",
            target_id=gene.target_id,
            capability_id=capability_id,
            content_ref=gene.gene_id,
            summary=f"Boundary hit: {boundary_class} {'caused failure' if caused_failure else 'handled'}",
            claims_class=ClaimsClass.C1_VERIFIED,
            confidence=0.95 if caused_failure else 0.8,
            metadata={
                "gene_id": gene.gene_id,
                "boundary_class": boundary_class,
                "boundary_value": str(boundary_value)[:100],
                "caused_failure": caused_failure,
            },
        )
        self.records.append(record)
        return record
    
    def record_security_finding(
        self,
        target_id: str,
        finding_type: str,
        severity: str,
        description: str,
        payload: str = "",
        capability_id: Optional[str] = None,
    ) -> EvidenceRecord:
        """Record a security finding."""
        record = EvidenceRecord(
            evidence_type=EvidenceType.SECURITY_SCAN,
            source="aute",
            target_id=target_id,
            capability_id=capability_id,
            summary=f"Security finding: {finding_type} ({severity})",
            claims_class=ClaimsClass.C1_VERIFIED,
            confidence=0.9 if severity in ["critical", "high"] else 0.7,
            metadata={
                "finding_type": finding_type,
                "severity": severity,
                "description": description,
                "payload_preview": payload[:100] if payload else "",
            },
        )
        self.records.append(record)
        return record
    
    def record_regression(
        self,
        target_id: str,
        regression_type: str,
        previous_behavior: str,
        current_behavior: str,
        capability_id: Optional[str] = None,
    ) -> EvidenceRecord:
        """Record a regression detection."""
        record = EvidenceRecord(
            evidence_type=EvidenceType.REGRESSION_DETECTION,
            source="aute",
            target_id=target_id,
            capability_id=capability_id,
            summary=f"Regression detected: {regression_type}",
            claims_class=ClaimsClass.C1_VERIFIED,
            confidence=0.95,
            metadata={
                "regression_type": regression_type,
                "previous_behavior": previous_behavior[:200],
                "current_behavior": current_behavior[:200],
            },
        )
        self.records.append(record)
        return record
    
    # ── Proof Trace Management ────────────────────────────────────────────────
    
    def create_proof_trace(
        self,
        run: AuteRunRecord,
        promoted_genes: list[str],
        quarantined_genes: list[str],
        evidence_refs: list[str],
        result: ProofResult,
        source_commit: Optional[str] = None,
    ) -> AUTEProofTrace:
        """
        Create an AUTE proof trace from a run record.
        
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
        """
        trace = AUTEProofTrace(
            run_id=run.run_id,
            target_id=run.target_id,
            capability_id=run.capability_id,
            strategy=run.strategy,
            generation_range=(run.generation_start, run.generation_end),
            genes_generated=run.tests_generated,
            genes_executed=run.tests_executed,
            failures_discovered=run.bugs_discovered,
            promoted_gene_ids=promoted_genes,
            quarantined_gene_ids=quarantined_genes,
            evidence_refs=evidence_refs,
            result=result,
            source_commit=source_commit,
        )
        self.proof_traces.append(trace)
        return trace
    
    def record_bot_proof(
        self,
        bot_id: str,
        workflow: str,
        target_id: str,
        proof_data: dict,
        capability_id: Optional[str] = None,
    ) -> EvidenceRecord:
        """
        Record a BotProofRecord from the bot fleet.
        
        Bot fleet proof record integration:
        The repo-level bot fleet can generate BotProofRecords,
        which SVA can consume as certification evidence.
        """
        record = EvidenceRecord(
            evidence_type=EvidenceType.BOT_PROOF_RECORD,
            source="bot",
            target_id=target_id,
            capability_id=capability_id,
            content_ref=f"bot:{bot_id}:{workflow}",
            summary=f"Bot proof from {bot_id} via {workflow}",
            claims_class=ClaimsClass.C1_VERIFIED,
            confidence=proof_data.get("confidence", 0.8),
            metadata={
                "bot_id": bot_id,
                "workflow": workflow,
                "status": proof_data.get("status", "unknown"),
                "artifacts": proof_data.get("artifacts", []),
            },
        )
        self.records.append(record)
        return record
    
    # ── Evidence Queries ──────────────────────────────────────────────────────
    
    def get_evidence_for_capability(self, capability_id: str) -> list[EvidenceRecord]:
        """Get all evidence for a capability."""
        return [r for r in self.records if r.capability_id == capability_id]
    
    def get_evidence_for_target(self, target_id: str) -> list[EvidenceRecord]:
        """Get all evidence for a target."""
        return [r for r in self.records if r.target_id == target_id]
    
    def get_verified_evidence(self) -> list[EvidenceRecord]:
        """Get all verified (C1) evidence."""
        return [r for r in self.records if r.claims_class == ClaimsClass.C1_VERIFIED]
    
    def get_evidence_by_type(self, evidence_type: EvidenceType) -> list[EvidenceRecord]:
        """Get all evidence of a specific type."""
        return [r for r in self.records if r.evidence_type == evidence_type]
    
    def get_proof_traces_for_capability(self, capability_id: str) -> list[AUTEProofTrace]:
        """Get all proof traces for a capability."""
        return [t for t in self.proof_traces if t.capability_id == capability_id]
    
    def compute_evidence_strength(self, capability_id: str) -> float:
        """
        Compute overall evidence strength for a capability.
        
        Combines confidence scores from all evidence records.
        """
        evidence = self.get_evidence_for_capability(capability_id)
        if not evidence:
            return 0.0
        
        # Weight by claims class
        weights = {
            ClaimsClass.C1_VERIFIED: 1.0,
            ClaimsClass.C2_SUPPORTED: 0.7,
            ClaimsClass.C3_HYPOTHESIS: 0.3,
            ClaimsClass.C4_THESIS: 0.1,
        }
        
        total_weight = 0.0
        weighted_sum = 0.0
        
        for record in evidence:
            weight = weights.get(record.claims_class, 0.5)
            weighted_sum += record.confidence * weight
            total_weight += weight
        
        if total_weight > 0:
            return weighted_sum / total_weight
        return 0.0
    
    def generate_evidence_summary(self, capability_id: str) -> dict:
        """Generate a summary of evidence for a capability."""
        evidence = self.get_evidence_for_capability(capability_id)
        proof_traces = self.get_proof_traces_for_capability(capability_id)
        
        type_counts = {}
        for record in evidence:
            t = record.evidence_type.value
            type_counts[t] = type_counts.get(t, 0) + 1
        
        return {
            "capability_id": capability_id,
            "total_evidence_records": len(evidence),
            "total_proof_traces": len(proof_traces),
            "evidence_by_type": type_counts,
            "average_confidence": sum(r.confidence for r in evidence) / len(evidence) if evidence else 0.0,
            "verified_count": len([r for r in evidence if r.claims_class == ClaimsClass.C1_VERIFIED]),
            "evidence_strength": self.compute_evidence_strength(capability_id),
        }
