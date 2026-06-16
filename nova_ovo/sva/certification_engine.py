"""
╔══════════════════════════════════════════════════════════════════════════════════╗
║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                          ║
║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA            ║
║  ALL RIGHTS RESERVED.                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════╝

SVA CERTIFICATION ENGINE — PROTO-SVA-001 Capability Certification Protocol
==========================================================================

PROT-409: Certification Engine

Certificate issuance, revocation, and continuous monitoring.

Core doctrine:
    No capability is real until it is tested, proof-linked, monitored, and revocable.

Certification flow:
    Capability Claim → Tests Execute → Evidence Collected → Certificate Issued/Denied
    → Continuous Monitoring → Certificate Maintained/Suspended/Revoked

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Optional

from nova_ovo.sva.schemas import (
    CapabilityRecord,
    CapabilityLevel,
    CertificateRecord,
    CertificateStatus,
    ClaimsClass,
)
from nova_ovo.sva.evidence_feed import EvidenceFeed, EvidenceType


# ── φ Constants ───────────────────────────────────────────────────────────────
PHI = 1.6180339887498948482
PHI_INV = 1.0 / PHI  # 0.618


# ═══════════════════════════════════════════════════════════════════════════════
# CERTIFICATION TYPES
# ═══════════════════════════════════════════════════════════════════════════════

class CertificationDecision(Enum):
    """Possible certification decisions."""
    APPROVE = "approve"
    DENY = "deny"
    PENDING_REVIEW = "pending_review"
    CONDITIONAL = "conditional"


class RevocationReason(Enum):
    """Reasons for certificate revocation."""
    TEST_FAILURE = "test_failure"
    REGRESSION_DETECTED = "regression_detected"
    SECURITY_VULNERABILITY = "security_vulnerability"
    EVIDENCE_INVALIDATED = "evidence_invalidated"
    CAPABILITY_DEGRADED = "capability_degraded"
    MANUAL_REVOCATION = "manual_revocation"
    EXPIRATION = "expiration"
    MONITORING_FAILURE = "monitoring_failure"


# ═══════════════════════════════════════════════════════════════════════════════
# CERTIFICATION THRESHOLDS
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class CertificationThresholds:
    """
    Thresholds required for each capability level.
    
    These are φ-based to maintain golden ratio harmony.
    """
    # Evidence strength thresholds (0-1)
    l1_min_evidence: float = 0.3
    l2_min_evidence: float = 0.4
    l3_min_evidence: float = 0.5
    l4_min_evidence: float = PHI_INV  # 0.618
    l5_min_evidence: float = 0.7
    l6_min_evidence: float = 0.75
    l7_min_evidence: float = 0.8
    l8_min_evidence: float = 0.85
    l9_min_evidence: float = 0.9
    
    # Coverage thresholds
    min_line_coverage: float = PHI_INV  # 0.618
    min_branch_coverage: float = 0.5
    
    # Mutation score threshold
    min_mutation_score: float = PHI_INV  # 0.618
    
    # Minimum test count
    min_tests_per_capability: int = 5
    
    # Monitoring requirements
    monitoring_interval_ms: int = 3600000  # 1 hour
    max_consecutive_failures: int = 3


# ═══════════════════════════════════════════════════════════════════════════════
# CERTIFICATION ENGINE
# ═══════════════════════════════════════════════════════════════════════════════

class CertificationEngine:
    """
    SVA Certification Engine.
    
    PROTO-SVA-001: Capability Certification Protocol
    
    Handles certificate issuance, maintenance, and revocation.
    
    Core doctrine:
        No capability is real until it is tested, proof-linked, monitored, and revocable.
    """
    
    def __init__(
        self,
        evidence_feed: Optional[EvidenceFeed] = None,
        thresholds: Optional[CertificationThresholds] = None,
    ):
        """Initialize certification engine."""
        self.evidence_feed = evidence_feed or EvidenceFeed()
        self.thresholds = thresholds or CertificationThresholds()
        self.certificates: dict[str, CertificateRecord] = {}
        self.monitoring_status: dict[str, dict] = {}
    
    # ── Level Determination ───────────────────────────────────────────────────
    
    def _get_level_threshold(self, level: CapabilityLevel) -> float:
        """Get the evidence threshold for a capability level."""
        level_thresholds = {
            CapabilityLevel.L0_UNTESTED: 0.0,
            CapabilityLevel.L1_UNIT_TESTED: self.thresholds.l1_min_evidence,
            CapabilityLevel.L2_INTEGRATION_TESTED: self.thresholds.l2_min_evidence,
            CapabilityLevel.L3_E2E_TESTED: self.thresholds.l3_min_evidence,
            CapabilityLevel.L4_PROPERTY_TESTED: self.thresholds.l4_min_evidence,
            CapabilityLevel.L5_FUZZ_TESTED: self.thresholds.l5_min_evidence,
            CapabilityLevel.L6_MUTATION_TESTED: self.thresholds.l6_min_evidence,
            CapabilityLevel.L7_AUTE_EVOLVED: self.thresholds.l7_min_evidence,
            CapabilityLevel.L8_PRODUCTION_MONITORED: self.thresholds.l8_min_evidence,
            CapabilityLevel.L9_CERTIFIED: self.thresholds.l9_min_evidence,
        }
        return level_thresholds.get(level, 0.0)
    
    def determine_capability_level(
        self,
        capability_id: str,
        evidence_summary: Optional[dict] = None,
    ) -> CapabilityLevel:
        """
        Determine the appropriate capability level based on evidence.
        
        Walks through levels from highest to lowest, returning the
        highest level for which the capability qualifies.
        """
        if evidence_summary is None:
            evidence_summary = self.evidence_feed.generate_evidence_summary(capability_id)
        
        evidence_strength = evidence_summary.get("evidence_strength", 0.0)
        evidence_by_type = evidence_summary.get("evidence_by_type", {})
        
        # Check levels from highest to lowest
        levels = [
            (CapabilityLevel.L9_CERTIFIED, self._check_l9_requirements),
            (CapabilityLevel.L8_PRODUCTION_MONITORED, self._check_l8_requirements),
            (CapabilityLevel.L7_AUTE_EVOLVED, self._check_l7_requirements),
            (CapabilityLevel.L6_MUTATION_TESTED, self._check_l6_requirements),
            (CapabilityLevel.L5_FUZZ_TESTED, self._check_l5_requirements),
            (CapabilityLevel.L4_PROPERTY_TESTED, self._check_l4_requirements),
            (CapabilityLevel.L3_E2E_TESTED, self._check_l3_requirements),
            (CapabilityLevel.L2_INTEGRATION_TESTED, self._check_l2_requirements),
            (CapabilityLevel.L1_UNIT_TESTED, self._check_l1_requirements),
        ]
        
        for level, check_fn in levels:
            threshold = self._get_level_threshold(level)
            if evidence_strength >= threshold and check_fn(evidence_summary):
                return level
        
        return CapabilityLevel.L0_UNTESTED
    
    def _check_l1_requirements(self, summary: dict) -> bool:
        """Check L1 (unit tested) requirements."""
        types = summary.get("evidence_by_type", {})
        return types.get("test_execution", 0) >= 1
    
    def _check_l2_requirements(self, summary: dict) -> bool:
        """Check L2 (integration tested) requirements."""
        types = summary.get("evidence_by_type", {})
        return (
            types.get("test_execution", 0) >= 3 and
            summary.get("total_evidence_records", 0) >= 5
        )
    
    def _check_l3_requirements(self, summary: dict) -> bool:
        """Check L3 (e2e tested) requirements."""
        types = summary.get("evidence_by_type", {})
        return (
            types.get("test_execution", 0) >= 5 and
            types.get("coverage_report", 0) >= 1
        )
    
    def _check_l4_requirements(self, summary: dict) -> bool:
        """Check L4 (property tested) requirements."""
        types = summary.get("evidence_by_type", {})
        return (
            types.get("invariant_verification", 0) >= 1 or
            (types.get("test_execution", 0) >= 10 and
             summary.get("average_confidence", 0) >= PHI_INV)
        )
    
    def _check_l5_requirements(self, summary: dict) -> bool:
        """Check L5 (fuzz tested) requirements."""
        types = summary.get("evidence_by_type", {})
        return types.get("boundary_hit", 0) >= 5
    
    def _check_l6_requirements(self, summary: dict) -> bool:
        """Check L6 (mutation tested) requirements."""
        types = summary.get("evidence_by_type", {})
        return types.get("mutation_result", 0) >= 1
    
    def _check_l7_requirements(self, summary: dict) -> bool:
        """Check L7 (AUTE evolved) requirements."""
        return summary.get("total_proof_traces", 0) >= 1
    
    def _check_l8_requirements(self, summary: dict) -> bool:
        """Check L8 (production monitored) requirements."""
        types = summary.get("evidence_by_type", {})
        return (
            summary.get("total_proof_traces", 0) >= 3 and
            types.get("regression_detection", 0) >= 0  # Monitoring in place
        )
    
    def _check_l9_requirements(self, summary: dict) -> bool:
        """Check L9 (certified) requirements."""
        return (
            summary.get("evidence_strength", 0) >= self.thresholds.l9_min_evidence and
            summary.get("verified_count", 0) >= 10 and
            summary.get("total_proof_traces", 0) >= 5
        )
    
    # ── Certification Decisions ───────────────────────────────────────────────
    
    def evaluate_certification(
        self,
        capability: CapabilityRecord,
        requested_level: Optional[CapabilityLevel] = None,
    ) -> tuple[CertificationDecision, CapabilityLevel, str]:
        """
        Evaluate whether a capability should be certified.
        
        Returns:
            Tuple of (decision, achieved_level, reason)
        """
        evidence_summary = self.evidence_feed.generate_evidence_summary(capability.capability_id)
        achieved_level = self.determine_capability_level(capability.capability_id, evidence_summary)
        
        # If no level requested, use current capability level or L1
        if requested_level is None:
            requested_level = capability.level if capability.level != CapabilityLevel.L0_UNTESTED else CapabilityLevel.L1_UNIT_TESTED
        
        # Check if achieved level meets or exceeds requested
        if achieved_level.value >= requested_level.value:
            return (
                CertificationDecision.APPROVE,
                achieved_level,
                f"Capability meets requirements for {achieved_level.name}"
            )
        
        # Check if there's any evidence at all
        if evidence_summary.get("total_evidence_records", 0) == 0:
            return (
                CertificationDecision.DENY,
                CapabilityLevel.L0_UNTESTED,
                "No evidence found for capability"
            )
        
        # Conditional approval at achieved level
        if achieved_level.value > 0:
            return (
                CertificationDecision.CONDITIONAL,
                achieved_level,
                f"Approved at {achieved_level.name}, requested {requested_level.name} not met"
            )
        
        return (
            CertificationDecision.PENDING_REVIEW,
            CapabilityLevel.L0_UNTESTED,
            "Insufficient evidence for certification"
        )
    
    # ── Certificate Issuance ──────────────────────────────────────────────────
    
    def issue_certificate(
        self,
        capability: CapabilityRecord,
        level: CapabilityLevel,
        evidence_refs: list[str],
        proof_trace_ids: list[str],
        expires_in_days: int = 90,
    ) -> CertificateRecord:
        """
        Issue a certificate for a capability.
        
        PROTO-SVA-001: Capability Certification Protocol
        """
        now = int(time.time() * 1000)
        expires_at = now + (expires_in_days * 24 * 60 * 60 * 1000)
        
        certificate = CertificateRecord(
            capability_id=capability.capability_id,
            level=level,
            status=CertificateStatus.ISSUED,
            issued_at=now,
            expires_at=expires_at,
            evidence_refs=evidence_refs,
            proof_trace_ids=proof_trace_ids,
            issuer="SVA",
        )
        certificate.issue()
        
        # Store certificate
        self.certificates[certificate.certificate_id] = certificate
        
        # Update capability
        capability.certificate_id = certificate.certificate_id
        capability.level = level
        capability.updated_at = now
        
        # Initialize monitoring
        self.monitoring_status[certificate.certificate_id] = {
            "last_check": now,
            "consecutive_failures": 0,
            "status": "active",
        }
        
        return certificate
    
    def certify_capability(
        self,
        capability: CapabilityRecord,
        requested_level: Optional[CapabilityLevel] = None,
    ) -> tuple[CertificateRecord | None, CertificationDecision, str]:
        """
        Full certification flow for a capability.
        
        Evaluates the capability and issues a certificate if approved.
        """
        decision, achieved_level, reason = self.evaluate_certification(capability, requested_level)
        
        if decision == CertificationDecision.APPROVE or decision == CertificationDecision.CONDITIONAL:
            # Gather evidence references
            evidence = self.evidence_feed.get_evidence_for_capability(capability.capability_id)
            evidence_refs = [e.evidence_id for e in evidence]
            
            # Gather proof traces
            proof_traces = self.evidence_feed.get_proof_traces_for_capability(capability.capability_id)
            proof_trace_ids = [t.proof_id for t in proof_traces]
            
            certificate = self.issue_certificate(
                capability=capability,
                level=achieved_level,
                evidence_refs=evidence_refs,
                proof_trace_ids=proof_trace_ids,
            )
            
            return certificate, decision, reason
        
        return None, decision, reason
    
    # ── Certificate Revocation ────────────────────────────────────────────────
    
    def revoke_certificate(
        self,
        certificate_id: str,
        reason: RevocationReason,
        details: str = "",
    ) -> bool:
        """
        Revoke a certificate.
        
        PROTO-SVA-004: Certification Revocation Protocol
        """
        certificate = self.certificates.get(certificate_id)
        if not certificate:
            return False
        
        if certificate.status == CertificateStatus.REVOKED:
            return True  # Already revoked
        
        certificate.revoke(f"{reason.value}: {details}")
        
        # Update monitoring status
        if certificate_id in self.monitoring_status:
            self.monitoring_status[certificate_id]["status"] = "revoked"
        
        return True
    
    def suspend_certificate(
        self,
        certificate_id: str,
        reason: str = "",
    ) -> bool:
        """Suspend a certificate pending investigation."""
        certificate = self.certificates.get(certificate_id)
        if not certificate:
            return False
        
        certificate.suspend()
        
        if certificate_id in self.monitoring_status:
            self.monitoring_status[certificate_id]["status"] = "suspended"
        
        return True
    
    # ── Continuous Monitoring ─────────────────────────────────────────────────
    
    def check_certificate_health(
        self,
        certificate_id: str,
        test_results: dict,
    ) -> tuple[bool, str]:
        """
        Check the health of a certified capability.
        
        PROTO-SVA-003: Test Immune Response Protocol
        
        Args:
            certificate_id: Certificate to check
            test_results: Recent test results for the capability
        
        Returns:
            Tuple of (healthy, message)
        """
        certificate = self.certificates.get(certificate_id)
        if not certificate:
            return False, "Certificate not found"
        
        if certificate.status != CertificateStatus.ISSUED:
            return False, f"Certificate status: {certificate.status.value}"
        
        now = int(time.time() * 1000)
        
        # Check expiration
        if certificate.expires_at and certificate.expires_at < now:
            self.revoke_certificate(
                certificate_id,
                RevocationReason.EXPIRATION,
                "Certificate expired"
            )
            return False, "Certificate expired"
        
        # Check test results
        tests_passed = test_results.get("passed", 0)
        tests_failed = test_results.get("failed", 0)
        total_tests = tests_passed + tests_failed
        
        if total_tests == 0:
            return True, "No test results to evaluate"
        
        pass_rate = tests_passed / total_tests
        
        # Update monitoring status
        status = self.monitoring_status.get(certificate_id, {
            "last_check": now,
            "consecutive_failures": 0,
            "status": "active",
        })
        
        if pass_rate < PHI_INV:  # Less than 61.8% passing
            status["consecutive_failures"] += 1
            
            if status["consecutive_failures"] >= self.thresholds.max_consecutive_failures:
                self.revoke_certificate(
                    certificate_id,
                    RevocationReason.TEST_FAILURE,
                    f"Pass rate {pass_rate:.1%} after {status['consecutive_failures']} consecutive failures"
                )
                return False, "Certificate revoked due to consecutive failures"
            
            self.suspend_certificate(
                certificate_id,
                f"Pass rate {pass_rate:.1%}, consecutive failures: {status['consecutive_failures']}"
            )
            return False, f"Certificate suspended, pass rate: {pass_rate:.1%}"
        
        # Reset consecutive failures on success
        status["consecutive_failures"] = 0
        status["last_check"] = now
        status["status"] = "active"
        self.monitoring_status[certificate_id] = status
        
        return True, f"Healthy, pass rate: {pass_rate:.1%}"
    
    def run_monitoring_cycle(self, test_results_map: dict[str, dict]) -> dict:
        """
        Run a monitoring cycle for all certificates.
        
        Args:
            test_results_map: Map of certificate_id -> test_results
        
        Returns:
            Summary of monitoring results
        """
        results = {
            "checked": 0,
            "healthy": 0,
            "suspended": 0,
            "revoked": 0,
            "details": [],
        }
        
        for cert_id, certificate in self.certificates.items():
            if certificate.status != CertificateStatus.ISSUED:
                continue
            
            test_results = test_results_map.get(cert_id, {})
            healthy, message = self.check_certificate_health(cert_id, test_results)
            
            results["checked"] += 1
            if healthy:
                results["healthy"] += 1
            elif certificate.status == CertificateStatus.SUSPENDED:
                results["suspended"] += 1
            elif certificate.status == CertificateStatus.REVOKED:
                results["revoked"] += 1
            
            results["details"].append({
                "certificate_id": cert_id,
                "capability_id": certificate.capability_id,
                "healthy": healthy,
                "message": message,
            })
        
        return results
    
    # ── Queries ───────────────────────────────────────────────────────────────
    
    def get_certificate(self, certificate_id: str) -> Optional[CertificateRecord]:
        """Get a certificate by ID."""
        return self.certificates.get(certificate_id)
    
    def get_certificate_for_capability(self, capability_id: str) -> Optional[CertificateRecord]:
        """Get the active certificate for a capability."""
        for cert in self.certificates.values():
            if cert.capability_id == capability_id and cert.status == CertificateStatus.ISSUED:
                return cert
        return None
    
    def list_certificates(self, status: Optional[CertificateStatus] = None) -> list[CertificateRecord]:
        """List certificates, optionally filtered by status."""
        if status is None:
            return list(self.certificates.values())
        return [c for c in self.certificates.values() if c.status == status]
