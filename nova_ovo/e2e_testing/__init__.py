"""
E2E TESTING — End-to-End Test Infrastructure
=============================================
Latin Name: PROBATIO FINIS AD FINEM PRODUCTIO
Protocol: PROT-523 — E2E TESTING INFRASTRUCTURE

"Probatio omnia confirmat."
(Testing confirms everything.)

This module provides end-to-end testing infrastructure for production
deployment validation, including health checks, smoke tests, and
integration tests.

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL
"""

from .health_checks import (
    HealthCheck,
    HealthCheckResult,
    CanisterHealthCheck,
    DatabaseHealthCheck,
    APIHealthCheck,
    run_all_health_checks,
)
from .smoke_tests import (
    SmokeTest,
    SmokeTestResult,
    CanisterSmokeTest,
    MemoryTemplateSmokeTest,
    run_all_smoke_tests,
)
from .integration_tests import (
    IntegrationTest,
    IntegrationTestResult,
    E2ETestSuite,
    run_integration_tests,
)

__all__ = [
    # Health Checks
    "HealthCheck",
    "HealthCheckResult",
    "CanisterHealthCheck",
    "DatabaseHealthCheck",
    "APIHealthCheck",
    "run_all_health_checks",
    # Smoke Tests
    "SmokeTest",
    "SmokeTestResult",
    "CanisterSmokeTest",
    "MemoryTemplateSmokeTest",
    "run_all_smoke_tests",
    # Integration Tests
    "IntegrationTest",
    "IntegrationTestResult",
    "E2ETestSuite",
    "run_integration_tests",
]

# ═══════════════════════════════════════════════════════════════════════════
# MODULE IDENTITY
# ═══════════════════════════════════════════════════════════════════════════

PHI = 1.6180339887498948482
PHI_17 = 3571.0  # φ¹⁷

MODULE_IDENTITY = {
    "name": "nova_ovo.e2e_testing",
    "latin_name": "PROBATIO FINIS AD FINEM PRODUCTIO",
    "protocol": "PROT-523",
    "frequency_hz": PHI_17,
    "layer": 9,  # Organism
    "classification": "SOVEREIGN-ALPHA",
    "primitive_trace": "DISTINCTION → RELATION → REPETITION → φ",
    "law_reference": "L-98: Production deployments require E2E validation",
    "test_types": ["health_checks", "smoke_tests", "integration_tests"],
}
