"""
╔══════════════════════════════════════════════════════════════════════════════════╗
║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                          ║
║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA            ║
║  ALL RIGHTS RESERVED.                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════╝

SVA REGISTRY — Capability, Test Suite, Evidence, and Certificate Registries
============================================================================

PROT-404: SVA Registry System

The registry layer provides in-memory storage and retrieval for SVA entities.

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
"""

from __future__ import annotations

import time
from dataclasses import dataclass, field
from typing import Optional

from nova_ovo.sva.schemas import (
    TestGene,
    TestGeneStatus,
    TestPopulation,
    CapabilityRecord,
    CertificateRecord,
    CertificateStatus,
    AUTEProofTrace,
    AuteRunRecord,
)


# ═══════════════════════════════════════════════════════════════════════════════
# TEST SUITE REGISTRY
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class TestSuiteRegistry:
    """
    Registry for test genes and populations.
    
    Manages the lifecycle of test genes from candidate to certified-suite.
    """
    genes: dict[str, TestGene] = field(default_factory=dict)
    populations: dict[str, TestPopulation] = field(default_factory=dict)
    run_records: dict[str, AuteRunRecord] = field(default_factory=dict)
    
    def register_gene(self, gene: TestGene) -> str:
        """Register a new test gene."""
        self.genes[gene.gene_id] = gene
        return gene.gene_id
    
    def get_gene(self, gene_id: str) -> Optional[TestGene]:
        """Get a gene by ID."""
        return self.genes.get(gene_id)
    
    def update_gene(self, gene: TestGene):
        """Update an existing gene."""
        gene.updated_at = int(time.time() * 1000)
        self.genes[gene.gene_id] = gene
    
    def get_genes_by_target(self, target_id: str) -> list[TestGene]:
        """Get all genes for a target."""
        return [g for g in self.genes.values() if g.target_id == target_id]
    
    def get_genes_by_status(self, status: TestGeneStatus) -> list[TestGene]:
        """Get all genes with a specific status."""
        return [g for g in self.genes.values() if g.status == status]
    
    def get_active_genes(self) -> list[TestGene]:
        """Get all active genes."""
        return self.get_genes_by_status(TestGeneStatus.ACTIVE)
    
    def get_certified_genes(self) -> list[TestGene]:
        """Get all certified suite genes."""
        return self.get_genes_by_status(TestGeneStatus.CERTIFIED_SUITE)
    
    def quarantine_gene(self, gene_id: str, reason: str):
        """Quarantine a flaky gene."""
        gene = self.genes.get(gene_id)
        if gene:
            gene.status = TestGeneStatus.QUARANTINED
            gene.updated_at = int(time.time() * 1000)
    
    def retire_gene(self, gene_id: str):
        """Retire a gene."""
        gene = self.genes.get(gene_id)
        if gene:
            gene.status = TestGeneStatus.RETIRED
            gene.updated_at = int(time.time() * 1000)
    
    def promote_gene(self, gene_id: str, new_status: TestGeneStatus):
        """Promote a gene to new status."""
        gene = self.genes.get(gene_id)
        if gene:
            gene.status = new_status
            gene.updated_at = int(time.time() * 1000)
    
    # ── Population Management ─────────────────────────────────────────────────
    
    def register_population(self, population: TestPopulation) -> str:
        """Register a new population."""
        self.populations[population.population_id] = population
        return population.population_id
    
    def get_population(self, population_id: str) -> Optional[TestPopulation]:
        """Get a population by ID."""
        return self.populations.get(population_id)
    
    def get_population_by_target(self, target_id: str) -> Optional[TestPopulation]:
        """Get population for a target."""
        for p in self.populations.values():
            if p.target_id == target_id:
                return p
        return None
    
    def update_population(self, population: TestPopulation):
        """Update an existing population."""
        self.populations[population.population_id] = population
    
    # ── Run Record Management ─────────────────────────────────────────────────
    
    def register_run(self, run: AuteRunRecord) -> str:
        """Register an AUTE run."""
        self.run_records[run.run_id] = run
        return run.run_id
    
    def get_run(self, run_id: str) -> Optional[AuteRunRecord]:
        """Get a run by ID."""
        return self.run_records.get(run_id)
    
    def get_runs_by_target(self, target_id: str) -> list[AuteRunRecord]:
        """Get all runs for a target."""
        return [r for r in self.run_records.values() if r.target_id == target_id]


# ═══════════════════════════════════════════════════════════════════════════════
# CAPABILITY REGISTRY
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class CapabilityRegistry:
    """
    Registry for capabilities.
    
    Capabilities are the targets of SVA certification.
    """
    capabilities: dict[str, CapabilityRecord] = field(default_factory=dict)
    
    def register(self, capability: CapabilityRecord) -> str:
        """Register a new capability."""
        self.capabilities[capability.capability_id] = capability
        return capability.capability_id
    
    def get(self, capability_id: str) -> Optional[CapabilityRecord]:
        """Get a capability by ID."""
        return self.capabilities.get(capability_id)
    
    def get_by_name(self, name: str) -> Optional[CapabilityRecord]:
        """Get a capability by name."""
        for cap in self.capabilities.values():
            if cap.name == name:
                return cap
        return None
    
    def update(self, capability: CapabilityRecord):
        """Update an existing capability."""
        capability.updated_at = int(time.time() * 1000)
        self.capabilities[capability.capability_id] = capability
    
    def list_all(self) -> list[CapabilityRecord]:
        """List all capabilities."""
        return list(self.capabilities.values())
    
    def list_by_owner(self, owner: str) -> list[CapabilityRecord]:
        """List capabilities by owner."""
        return [c for c in self.capabilities.values() if c.owner == owner]
    
    def add_test_suite(self, capability_id: str, suite_id: str):
        """Add a test suite to a capability."""
        cap = self.capabilities.get(capability_id)
        if cap and suite_id not in cap.test_suite_ids:
            cap.test_suite_ids.append(suite_id)
            cap.updated_at = int(time.time() * 1000)
    
    def add_evidence(self, capability_id: str, evidence_ref: str):
        """Add evidence to a capability."""
        cap = self.capabilities.get(capability_id)
        if cap and evidence_ref not in cap.evidence_refs:
            cap.evidence_refs.append(evidence_ref)
            cap.updated_at = int(time.time() * 1000)


# ═══════════════════════════════════════════════════════════════════════════════
# EVIDENCE REGISTRY
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class EvidenceRecord:
    """A piece of evidence in the evidence registry."""
    evidence_id: str
    evidence_type: str
    source: str
    target_id: str
    capability_id: Optional[str]
    content_ref: str
    created_at: int


@dataclass
class EvidenceRegistry:
    """
    Registry for evidence records.
    
    Evidence supports capability certification.
    """
    records: dict[str, EvidenceRecord] = field(default_factory=dict)
    proof_traces: dict[str, AUTEProofTrace] = field(default_factory=dict)
    
    def register(self, record: EvidenceRecord) -> str:
        """Register evidence."""
        self.records[record.evidence_id] = record
        return record.evidence_id
    
    def get(self, evidence_id: str) -> Optional[EvidenceRecord]:
        """Get evidence by ID."""
        return self.records.get(evidence_id)
    
    def get_by_capability(self, capability_id: str) -> list[EvidenceRecord]:
        """Get all evidence for a capability."""
        return [e for e in self.records.values() if e.capability_id == capability_id]
    
    def get_by_target(self, target_id: str) -> list[EvidenceRecord]:
        """Get all evidence for a target."""
        return [e for e in self.records.values() if e.target_id == target_id]
    
    # ── Proof Trace Management ────────────────────────────────────────────────
    
    def register_proof_trace(self, trace: AUTEProofTrace) -> str:
        """Register an AUTE proof trace."""
        self.proof_traces[trace.proof_id] = trace
        return trace.proof_id
    
    def get_proof_trace(self, proof_id: str) -> Optional[AUTEProofTrace]:
        """Get a proof trace by ID."""
        return self.proof_traces.get(proof_id)
    
    def get_proof_traces_by_capability(self, capability_id: str) -> list[AUTEProofTrace]:
        """Get all proof traces for a capability."""
        return [t for t in self.proof_traces.values() if t.capability_id == capability_id]


# ═══════════════════════════════════════════════════════════════════════════════
# CERTIFICATE REGISTRY
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class CertificateRegistry:
    """
    Registry for certificates.
    
    Certificates are the output of SVA certification.
    """
    certificates: dict[str, CertificateRecord] = field(default_factory=dict)
    
    def register(self, certificate: CertificateRecord) -> str:
        """Register a new certificate."""
        self.certificates[certificate.certificate_id] = certificate
        return certificate.certificate_id
    
    def get(self, certificate_id: str) -> Optional[CertificateRecord]:
        """Get a certificate by ID."""
        return self.certificates.get(certificate_id)
    
    def get_by_capability(self, capability_id: str) -> Optional[CertificateRecord]:
        """Get the certificate for a capability."""
        for cert in self.certificates.values():
            if cert.capability_id == capability_id and cert.status == CertificateStatus.ISSUED:
                return cert
        return None
    
    def update(self, certificate: CertificateRecord):
        """Update an existing certificate."""
        self.certificates[certificate.certificate_id] = certificate
    
    def list_all(self) -> list[CertificateRecord]:
        """List all certificates."""
        return list(self.certificates.values())
    
    def list_issued(self) -> list[CertificateRecord]:
        """List all issued certificates."""
        return [c for c in self.certificates.values() if c.status == CertificateStatus.ISSUED]
    
    def list_revoked(self) -> list[CertificateRecord]:
        """List all revoked certificates."""
        return [c for c in self.certificates.values() if c.status == CertificateStatus.REVOKED]
    
    def revoke(self, certificate_id: str, reason: str):
        """Revoke a certificate."""
        cert = self.certificates.get(certificate_id)
        if cert:
            cert.revoke(reason)
    
    def suspend(self, certificate_id: str):
        """Suspend a certificate."""
        cert = self.certificates.get(certificate_id)
        if cert:
            cert.suspend()
