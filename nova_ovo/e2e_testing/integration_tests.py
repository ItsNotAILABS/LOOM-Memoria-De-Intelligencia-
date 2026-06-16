"""
INTEGRATION TESTS — Full System Integration Testing
====================================================
Protocol: PROT-526 — INTEGRATION TESTS

"Integratio totum confirmat."
(Integration confirms the whole.)

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

import asyncio
import time
from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum
from typing import Dict, List, Optional, Any, Callable, Awaitable
import logging
import json

from .health_checks import HealthCheck, HealthCheckResult, HealthStatus, run_all_health_checks
from .smoke_tests import SmokeTest, SmokeTestResult, TestStatus, run_all_smoke_tests

# ═══════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════

PHI = 1.6180339887498948482
INTEGRATION_TEST_TIMEOUT = 120.0

logger = logging.getLogger(__name__)


# ═══════════════════════════════════════════════════════════════════════════
# DATA CLASSES
# ═══════════════════════════════════════════════════════════════════════════

class IntegrationStatus(Enum):
    PASSED = "passed"
    FAILED = "failed"
    PARTIAL = "partial"
    ERROR = "error"


@dataclass
class IntegrationTestResult:
    """Result of an integration test"""
    name: str
    status: IntegrationStatus
    health_results: Dict[str, HealthCheckResult] = field(default_factory=dict)
    smoke_results: Dict[str, SmokeTestResult] = field(default_factory=dict)
    total_checks: int = 0
    passed_checks: int = 0
    failed_checks: int = 0
    duration_ms: float = 0.0
    timestamp: datetime = field(default_factory=datetime.utcnow)
    
    @property
    def pass_rate(self) -> float:
        if self.total_checks == 0:
            return 0.0
        return (self.passed_checks / self.total_checks) * 100
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "status": self.status.value,
            "total_checks": self.total_checks,
            "passed_checks": self.passed_checks,
            "failed_checks": self.failed_checks,
            "pass_rate": f"{self.pass_rate:.1f}%",
            "duration_ms": self.duration_ms,
            "timestamp": self.timestamp.isoformat(),
        }


@dataclass
class IntegrationTest:
    """Configuration for an integration test"""
    name: str
    health_checks: List[HealthCheck] = field(default_factory=list)
    smoke_tests: List[SmokeTest] = field(default_factory=list)
    timeout: float = INTEGRATION_TEST_TIMEOUT


# ═══════════════════════════════════════════════════════════════════════════
# E2E TEST SUITE
# ═══════════════════════════════════════════════════════════════════════════

class E2ETestSuite:
    """
    End-to-end test suite for production validation
    
    Runs health checks, smoke tests, and integration tests
    in a coordinated manner.
    """
    
    def __init__(self, name: str = "production"):
        self.name = name
        self._health_checks: List[HealthCheck] = []
        self._smoke_tests: List[SmokeTest] = []
        self._integration_tests: List[IntegrationTest] = []
    
    def add_health_check(self, check: HealthCheck) -> "E2ETestSuite":
        """Add a health check"""
        self._health_checks.append(check)
        return self
    
    def add_smoke_test(self, test: SmokeTest) -> "E2ETestSuite":
        """Add a smoke test"""
        self._smoke_tests.append(test)
        return self
    
    def add_integration_test(self, test: IntegrationTest) -> "E2ETestSuite":
        """Add an integration test"""
        self._integration_tests.append(test)
        return self
    
    async def run_health_checks(self) -> Dict[str, HealthCheckResult]:
        """Run all health checks"""
        if not self._health_checks:
            return {}
        
        logger.info("=" * 60)
        logger.info("RUNNING HEALTH CHECKS")
        logger.info("=" * 60)
        
        return await run_all_health_checks(self._health_checks)
    
    async def run_smoke_tests(self) -> Dict[str, SmokeTestResult]:
        """Run all smoke tests"""
        if not self._smoke_tests:
            return {}
        
        logger.info("=" * 60)
        logger.info("RUNNING SMOKE TESTS")
        logger.info("=" * 60)
        
        return await run_all_smoke_tests(self._smoke_tests)
    
    async def run_full_suite(self) -> IntegrationTestResult:
        """Run the full E2E test suite"""
        start_time = time.time()
        
        logger.info("=" * 60)
        logger.info(f"E2E TEST SUITE: {self.name}")
        logger.info("=" * 60)
        
        # Run health checks
        health_results = await self.run_health_checks()
        
        # Run smoke tests
        smoke_results = await self.run_smoke_tests()
        
        # Calculate totals
        total_checks = len(health_results) + len(smoke_results)
        passed_checks = 0
        failed_checks = 0
        
        for result in health_results.values():
            if result.is_healthy:
                passed_checks += 1
            else:
                failed_checks += 1
        
        for result in smoke_results.values():
            if result.passed:
                passed_checks += 1
            else:
                failed_checks += 1
        
        # Determine overall status
        if failed_checks == 0:
            status = IntegrationStatus.PASSED
        elif passed_checks == 0:
            status = IntegrationStatus.FAILED
        elif passed_checks / total_checks >= PHI - 1:  # 61.8% threshold
            status = IntegrationStatus.PARTIAL
        else:
            status = IntegrationStatus.FAILED
        
        duration_ms = (time.time() - start_time) * 1000
        
        result = IntegrationTestResult(
            name=self.name,
            status=status,
            health_results=health_results,
            smoke_results=smoke_results,
            total_checks=total_checks,
            passed_checks=passed_checks,
            failed_checks=failed_checks,
            duration_ms=duration_ms,
        )
        
        # Log summary
        logger.info("=" * 60)
        logger.info("E2E TEST SUITE SUMMARY")
        logger.info("=" * 60)
        logger.info(f"  Status: {status.value.upper()}")
        logger.info(f"  Total Checks: {total_checks}")
        logger.info(f"  Passed: {passed_checks}")
        logger.info(f"  Failed: {failed_checks}")
        logger.info(f"  Pass Rate: {result.pass_rate:.1f}%")
        logger.info(f"  Duration: {duration_ms:.1f}ms")
        logger.info("=" * 60)
        
        return result
    
    def generate_report(self, result: IntegrationTestResult) -> str:
        """Generate a test report"""
        report = []
        report.append("=" * 60)
        report.append(f"E2E TEST REPORT: {self.name}")
        report.append("=" * 60)
        report.append("")
        report.append(f"Status: {result.status.value.upper()}")
        report.append(f"Timestamp: {result.timestamp.isoformat()}")
        report.append(f"Duration: {result.duration_ms:.1f}ms")
        report.append("")
        report.append("SUMMARY")
        report.append("-" * 40)
        report.append(f"  Total Checks: {result.total_checks}")
        report.append(f"  Passed: {result.passed_checks}")
        report.append(f"  Failed: {result.failed_checks}")
        report.append(f"  Pass Rate: {result.pass_rate:.1f}%")
        report.append("")
        
        if result.health_results:
            report.append("HEALTH CHECKS")
            report.append("-" * 40)
            for name, hr in result.health_results.items():
                symbol = "✓" if hr.is_healthy else "✗"
                report.append(f"  {symbol} {name}: {hr.status.value} ({hr.latency_ms:.1f}ms)")
            report.append("")
        
        if result.smoke_results:
            report.append("SMOKE TESTS")
            report.append("-" * 40)
            for name, sr in result.smoke_results.items():
                symbol = "✓" if sr.passed else "✗"
                report.append(f"  {symbol} {name}: {sr.status.value} ({sr.duration_ms:.1f}ms)")
                if sr.failures:
                    for failure in sr.failures:
                        report.append(f"      - {failure}")
            report.append("")
        
        report.append("=" * 60)
        return "\n".join(report)


# ═══════════════════════════════════════════════════════════════════════════
# CONVENIENCE FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════

async def run_integration_tests(
    canister_id: Optional[str] = None,
    network: str = "local",
) -> IntegrationTestResult:
    """
    Run standard integration tests for production validation
    """
    from .health_checks import CanisterHealthCheck, DatabaseHealthCheck
    from .smoke_tests import CanisterSmokeTest, MemoryTemplateSmokeTest
    
    suite = E2ETestSuite("production_validation")
    
    # Add health checks
    if canister_id:
        suite.add_health_check(CanisterHealthCheck(canister_id, network))
    
    # Add smoke tests
    if canister_id:
        suite.add_smoke_test(CanisterSmokeTest(canister_id, network))
    
    suite.add_smoke_test(MemoryTemplateSmokeTest())
    
    return await suite.run_full_suite()


# ═══════════════════════════════════════════════════════════════════════════
# MODULE IDENTITY
# ═══════════════════════════════════════════════════════════════════════════

INTEGRATION_TESTS_IDENTITY = {
    "name": "nova_ovo.e2e_testing.integration_tests",
    "protocol": "PROT-526",
    "capabilities": [
        "health_checks", "smoke_tests", "integration_tests",
        "report_generation", "pass_rate_calculation",
    ],
    "threshold": "61.8% (φ-1) for partial pass",
    "primitive_trace": "RELATION → DISTINCTION → REPETITION → φ",
}
