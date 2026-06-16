"""
PRODUCTION PROTOCOLS ENFORCEMENT
=================================

Python enforcement layer for L-131 and production protocols.
Prevents fake work from being created by validating against Motoko backend.

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX

PURPOSE:
    Enforces the production protocols at the Python orchestration layer.
    Blocks surface work before it can be committed to the repository.
    Validates all work traces to mathematical primitives in Motoko backend.
"""

import os
import re
from dataclasses import dataclass
from enum import Enum
from pathlib import Path
from typing import List, Optional, Dict, Set
import time


# ══════════════════════════════════════════════════════════════════════════════
# CONSTANTS FROM MOTOKO BACKEND
# ══════════════════════════════════════════════════════════════════════════════

PHI = 1.6180339887498948  # Golden ratio from RootMathematicalFoundation.mo
OPERATING_FREQ_HZ = PHI
SCHUMANN_HZ = 7.83

DOCTRINE = "PRODUCTION ONLY. NO SURFACE WORK. NO DEMOS. MATH FIRST."


# ══════════════════════════════════════════════════════════════════════════════
# WORK TYPE CLASSIFICATION
# ══════════════════════════════════════════════════════════════════════════════

class WorkType(Enum):
    """Work artifact classification"""
    BACKEND_ENGINE = "backend_engine"           # Motoko canister with math
    WIRE_CONNECTION = "wire_connection"         # Bridge/orchestration code
    INTEGRATION_TEST = "integration_test"       # Tests proving execution
    PRODUCTION_FRONTEND = "production_frontend" # Frontend WITH wired computation
    DOCUMENTATION = "documentation"             # Docs reflecting reality
    SURFACE_WORK = "surface_work"              # FORBIDDEN — L-131 violation


class ProductionReadiness(Enum):
    """Production readiness levels"""
    DEMO = "demo"           # FORBIDDEN
    PROTOTYPE = "prototype" # FORBIDDEN
    MVP = "mvp"            # FORBIDDEN
    ALPHA_BETA = "alpha_beta" # FORBIDDEN
    PRODUCTION = "production" # ALLOWED


# ══════════════════════════════════════════════════════════════════════════════
# DATA STRUCTURES
# ══════════════════════════════════════════════════════════════════════════════

@dataclass
class WorkArtifact:
    """Represents a work artifact to be validated"""
    id: str
    filepath: Path
    work_type: WorkType
    created_at: float
    has_backend: bool
    has_math_formulas: bool
    has_wire_connection: bool
    has_integration_tests: bool
    mathematical_basis: str
    primitive_trace: str
    violation: Optional[str] = None


@dataclass
class L131Violation:
    """L-131 protocol violation"""
    artifact_id: str
    filepath: Path
    violation_type: str
    detected_at: float
    reason: str
    action_taken: str


@dataclass
class ProductionCheck:
    """Production readiness check"""
    artifact_id: str
    readiness: ProductionReadiness
    has_error_handling: bool
    has_complete_workflows: bool
    has_real_backend: bool
    has_end_to_end_tests: bool
    production_ready: bool


# ══════════════════════════════════════════════════════════════════════════════
# L-131: NO SURFACE WORK LAW ENFORCEMENT
# ══════════════════════════════════════════════════════════════════════════════

class L131Enforcer:
    """
    Enforces L-131: No Surface Work Law

    FORBIDDEN:
    - Documentation before backend
    - TypeScript without Motoko
    - HTML/CSS without wired computation
    - README files for non-existent functionality
    - Demo applications
    - Mock data or stubs
    """

    def __init__(self, repo_root: Path):
        self.repo_root = repo_root
        self.motoko_backend = repo_root / "icp" / "src" / "medina_backend"
        self.python_orchestration = repo_root / "nova_ovo"
        self.violations: List[L131Violation] = []

    def classify_file(self, filepath: Path) -> WorkType:
        """Classify file into work type"""
        suffix = filepath.suffix.lower()
        name = filepath.name.lower()

        # Motoko backend = backend engine
        if suffix == ".mo":
            return WorkType.BACKEND_ENGINE

        # Python orchestration/bridges = wire connection
        if suffix == ".py" and ("orchestrat" in name or "bridge" in name or "wire" in name):
            return WorkType.WIRE_CONNECTION

        # Test files = integration test
        if "test" in name and suffix in [".py", ".ts", ".js"]:
            return WorkType.INTEGRATION_TEST

        # Documentation files
        if suffix in [".md", ".txt", ".rst"] or name in ["readme", "readme.md"]:
            return WorkType.DOCUMENTATION

        # TypeScript/JavaScript without backend connection = SURFACE WORK
        if suffix in [".ts", ".js", ".tsx", ".jsx"]:
            # Check if it's wired to backend
            if self._check_has_backend_connection(filepath):
                return WorkType.PRODUCTION_FRONTEND
            else:
                return WorkType.SURFACE_WORK

        # HTML/CSS without computation = SURFACE WORK
        if suffix in [".html", ".css"]:
            return WorkType.SURFACE_WORK

        return WorkType.SURFACE_WORK

    def _check_has_backend_connection(self, filepath: Path) -> bool:
        """Check if file connects to Motoko backend"""
        try:
            content = filepath.read_text()

            # Look for ICP canister imports
            if "@dfinity/agent" in content or "@dfinity/candid" in content:
                return True

            # Look for canister ID references
            if "canister_id" in content.lower() or "canisterId" in content:
                return True

            # Look for actor references
            if "createActor" in content or "Actor.createActor" in content:
                return True

            return False
        except:
            return False

    def _check_has_math_formulas(self, filepath: Path) -> bool:
        """Check if backend file contains mathematical formulas"""
        try:
            content = filepath.read_text()

            # Look for mathematical operations
            math_indicators = [
                "PHI", "PI", "SQRT", "Float.sqrt", "Float.pow",
                "Pythagorean", "Fibonacci", "golden ratio",
                "RootMathematicalFoundation", "AncientMathEngine",
                "formula", "theorem", "equation"
            ]

            return any(indicator in content for indicator in math_indicators)
        except:
            return False

    def _check_primitive_trace(self, filepath: Path) -> str:
        """Extract primitive trace from file"""
        try:
            content = filepath.read_text()

            if "RootMathematicalFoundation" in content:
                return "RootMathematicalFoundation"
            if "FreddysLaws" in content:
                return "FreddysLaws"
            if "AncientMathEngine" in content:
                return "AncientMathEngine"
            if "MatalkoICP" in content:
                return "MatalkoICP"

            return ""
        except:
            return ""

    def _find_corresponding_backend(self, filepath: Path) -> Optional[Path]:
        """Find corresponding Motoko backend for a file"""
        # Look for .mo files with similar names
        name_base = filepath.stem.replace("-", "").replace("_", "").lower()

        if not self.motoko_backend.exists():
            return None

        for mo_file in self.motoko_backend.glob("*.mo"):
            mo_base = mo_file.stem.replace("-", "").replace("_", "").lower()
            if name_base in mo_base or mo_base in name_base:
                return mo_file

        return None

    def create_work_artifact(self, filepath: Path) -> WorkArtifact:
        """Create work artifact from file"""
        work_type = self.classify_file(filepath)

        # Check for backend
        has_backend = False
        if work_type == WorkType.BACKEND_ENGINE:
            has_backend = True
        else:
            backend_file = self._find_corresponding_backend(filepath)
            has_backend = backend_file is not None and backend_file.exists()

        # Check for math formulas
        has_math = self._check_has_math_formulas(filepath)

        # Check for wire connection
        has_wire = self._check_has_backend_connection(filepath)

        # Check for tests
        test_dir = filepath.parent / "tests"
        has_tests = test_dir.exists() and any(test_dir.glob("test_*.py"))

        # Mathematical basis
        math_basis = ""
        if has_math:
            math_basis = "Contains mathematical formulas"

        # Primitive trace
        primitive_trace = self._check_primitive_trace(filepath)

        return WorkArtifact(
            id=f"artifact_{int(time.time() * 1000)}",
            filepath=filepath,
            work_type=work_type,
            created_at=time.time(),
            has_backend=has_backend,
            has_math_formulas=has_math,
            has_wire_connection=has_wire,
            has_integration_tests=has_tests,
            mathematical_basis=math_basis,
            primitive_trace=primitive_trace
        )

    def validate_l131(self, artifact: WorkArtifact) -> Optional[L131Violation]:
        """Validate artifact against L-131"""

        # Check if surface work
        if artifact.work_type == WorkType.SURFACE_WORK:
            violation = L131Violation(
                artifact_id=artifact.id,
                filepath=artifact.filepath,
                violation_type="L-131: SURFACE WORK DETECTED",
                detected_at=time.time(),
                reason="Work artifact is surface work with no backend implementation",
                action_taken="REJECT AND DELETE"
            )
            self.violations.append(violation)
            return violation

        # Documentation requires backend
        if artifact.work_type == WorkType.DOCUMENTATION:
            if not artifact.has_backend:
                violation = L131Violation(
                    artifact_id=artifact.id,
                    filepath=artifact.filepath,
                    violation_type="L-131: DOCUMENTATION BEFORE BACKEND",
                    detected_at=time.time(),
                    reason="Documentation created without backend implementation",
                    action_taken="REJECT — Build backend first"
                )
                self.violations.append(violation)
                return violation

        # Frontend requires wired computation
        if artifact.work_type == WorkType.PRODUCTION_FRONTEND:
            if not artifact.has_wire_connection:
                violation = L131Violation(
                    artifact_id=artifact.id,
                    filepath=artifact.filepath,
                    violation_type="L-131: UNWIRED FRONTEND",
                    detected_at=time.time(),
                    reason="Frontend has no wire connection to backend computation",
                    action_taken="REJECT — Wire to backend first"
                )
                self.violations.append(violation)
                return violation

            if not artifact.has_math_formulas:
                violation = L131Violation(
                    artifact_id=artifact.id,
                    filepath=artifact.filepath,
                    violation_type="L-131: NO MATHEMATICAL BASIS",
                    detected_at=time.time(),
                    reason="Frontend has no mathematical computation basis",
                    action_taken="REJECT — Add math formulas to backend"
                )
                self.violations.append(violation)
                return violation

        # Backend requires math formulas
        if artifact.work_type == WorkType.BACKEND_ENGINE:
            if not artifact.has_math_formulas:
                violation = L131Violation(
                    artifact_id=artifact.id,
                    filepath=artifact.filepath,
                    violation_type="L-131: BACKEND WITHOUT MATH",
                    detected_at=time.time(),
                    reason="Backend engine has no mathematical formulas",
                    action_taken="REJECT — Add mathematical formulas"
                )
                self.violations.append(violation)
                return violation

            if not artifact.primitive_trace:
                violation = L131Violation(
                    artifact_id=artifact.id,
                    filepath=artifact.filepath,
                    violation_type="L-130: NO PRIMITIVE TRACE",
                    detected_at=time.time(),
                    reason="Backend cannot trace to mathematical primitive",
                    action_taken="REJECT — Trace to RootMathematicalFoundation"
                )
                self.violations.append(violation)
                return violation

        # Wire requires backend
        if artifact.work_type == WorkType.WIRE_CONNECTION:
            if not artifact.has_backend:
                violation = L131Violation(
                    artifact_id=artifact.id,
                    filepath=artifact.filepath,
                    violation_type="L-131: WIRE WITHOUT BACKEND",
                    detected_at=time.time(),
                    reason="Wire connection has no backend to connect to",
                    action_taken="REJECT — Build backend first"
                )
                self.violations.append(violation)
                return violation

        # Tests require backend
        if artifact.work_type == WorkType.INTEGRATION_TEST:
            if not artifact.has_backend:
                violation = L131Violation(
                    artifact_id=artifact.id,
                    filepath=artifact.filepath,
                    violation_type="L-131: TESTS WITHOUT BACKEND",
                    detected_at=time.time(),
                    reason="Integration tests have no backend to test",
                    action_taken="REJECT — Build backend first"
                )
                self.violations.append(violation)
                return violation

        # No violation
        return None

    def scan_directory(self, directory: Path, patterns: List[str] = None) -> List[L131Violation]:
        """Scan directory for L-131 violations"""
        if patterns is None:
            patterns = ["*.ts", "*.js", "*.tsx", "*.jsx", "*.html", "*.css", "*.md"]

        violations = []

        for pattern in patterns:
            for filepath in directory.rglob(pattern):
                # Skip node_modules, .git, etc.
                if any(part.startswith(".") or part == "node_modules" for part in filepath.parts):
                    continue

                artifact = self.create_work_artifact(filepath)
                violation = self.validate_l131(artifact)
                if violation:
                    violations.append(violation)

        return violations


# ══════════════════════════════════════════════════════════════════════════════
# PROT-001: NO DEMOS PROTOCOL ENFORCEMENT
# ══════════════════════════════════════════════════════════════════════════════

class NoDemosEnforcer:
    """
    Enforces PROT-001: No Demos Protocol

    FORBIDDEN:
    - Demo applications
    - Proof of concept
    - Minimum Viable Product (MVP)
    - Prototypes
    - Mock services
    """

    FORBIDDEN_KEYWORDS = [
        "demo", "prototype", "mvp", "poc", "proof-of-concept",
        "alpha", "beta", "sample", "example", "mock", "stub",
        "test-app", "demo-app"
    ]

    def __init__(self, repo_root: Path):
        self.repo_root = repo_root

    def check_file_is_demo(self, filepath: Path) -> bool:
        """Check if file is a demo/prototype"""
        name_lower = filepath.name.lower()
        return any(keyword in name_lower for keyword in self.FORBIDDEN_KEYWORDS)

    def check_directory_is_demo(self, dirpath: Path) -> bool:
        """Check if directory is for demos"""
        name_lower = dirpath.name.lower()
        return any(keyword in name_lower for keyword in self.FORBIDDEN_KEYWORDS)

    def validate_production_readiness(self, check: ProductionCheck) -> Optional[str]:
        """Validate production readiness"""
        if check.readiness == ProductionReadiness.DEMO:
            return "PROT-001 VIOLATION: Demos are forbidden. Production only."
        elif check.readiness == ProductionReadiness.PROTOTYPE:
            return "PROT-001 VIOLATION: Prototypes are forbidden. Production only."
        elif check.readiness == ProductionReadiness.MVP:
            return "PROT-001 VIOLATION: MVPs are forbidden. Production only."
        elif check.readiness == ProductionReadiness.ALPHA_BETA:
            return "PROT-001 VIOLATION: Alpha/Beta releases forbidden. Production only."
        elif check.readiness == ProductionReadiness.PRODUCTION:
            if not check.has_error_handling:
                return "PROT-001 VIOLATION: Production requires complete error handling"
            elif not check.has_complete_workflows:
                return "PROT-001 VIOLATION: Production requires complete workflows"
            elif not check.has_real_backend:
                return "PROT-001 VIOLATION: Production requires real backend execution"
            elif not check.has_end_to_end_tests:
                return "PROT-001 VIOLATION: Production requires end-to-end tests"

        return None


# ══════════════════════════════════════════════════════════════════════════════
# MAIN ENFORCEMENT ORCHESTRATOR
# ══════════════════════════════════════════════════════════════════════════════

class ProductionProtocolEnforcer:
    """
    Main enforcement orchestrator
    Integrates all protocol enforcers
    """

    def __init__(self, repo_root: Path = None):
        if repo_root is None:
            repo_root = Path(__file__).parent.parent.parent

        self.repo_root = repo_root
        self.l131_enforcer = L131Enforcer(repo_root)
        self.no_demos_enforcer = NoDemosEnforcer(repo_root)

    def scan_repository(self) -> Dict[str, List]:
        """Scan entire repository for violations"""
        results = {
            "l131_violations": [],
            "demo_violations": [],
            "total_violations": 0,
            "scanned_at": time.time(),
            "doctrine": DOCTRINE
        }

        # Scan for L-131 violations
        l131_violations = self.l131_enforcer.scan_directory(self.repo_root)
        results["l131_violations"] = [
            {
                "artifact_id": v.artifact_id,
                "filepath": str(v.filepath),
                "violation_type": v.violation_type,
                "reason": v.reason,
                "action_taken": v.action_taken
            }
            for v in l131_violations
        ]

        # Scan for demo violations
        demo_violations = []
        for filepath in self.repo_root.rglob("*"):
            if filepath.is_file():
                if self.no_demos_enforcer.check_file_is_demo(filepath):
                    demo_violations.append(str(filepath))
        results["demo_violations"] = demo_violations

        results["total_violations"] = len(l131_violations) + len(demo_violations)

        return results

    def enforce(self, filepath: Path) -> bool:
        """
        Enforce protocols on a single file
        Returns True if file is compliant, False if violation
        """
        # Check L-131
        artifact = self.l131_enforcer.create_work_artifact(filepath)
        l131_violation = self.l131_enforcer.validate_l131(artifact)
        if l131_violation:
            print(f"❌ {l131_violation.violation_type}")
            print(f"   File: {filepath}")
            print(f"   Reason: {l131_violation.reason}")
            print(f"   Action: {l131_violation.action_taken}")
            return False

        # Check PROT-001 (no demos)
        if self.no_demos_enforcer.check_file_is_demo(filepath):
            print(f"❌ PROT-001 VIOLATION: Demo file detected")
            print(f"   File: {filepath}")
            print(f"   Action: REJECT")
            return False

        print(f"✅ COMPLIANT: {filepath}")
        return True

    def get_status(self) -> Dict:
        """Get enforcement status"""
        return {
            "protocols_active": 4,  # L-131, PROT-001, PROT-002, PROT-003
            "enforcement_enabled": True,
            "operating_frequency_hz": OPERATING_FREQ_HZ,
            "doctrine": DOCTRINE,
            "repo_root": str(self.repo_root)
        }


# ══════════════════════════════════════════════════════════════════════════════
# CLI INTERFACE
# ══════════════════════════════════════════════════════════════════════════════

def main():
    """CLI for protocol enforcement"""
    import sys

    enforcer = ProductionProtocolEnforcer()

    if len(sys.argv) > 1:
        # Enforce on specific file
        filepath = Path(sys.argv[1])
        if filepath.exists():
            enforcer.enforce(filepath)
        else:
            print(f"Error: File not found: {filepath}")
            sys.exit(1)
    else:
        # Scan repository
        print("=" * 80)
        print("PRODUCTION PROTOCOLS ENFORCEMENT SCAN")
        print("=" * 80)
        print(f"Doctrine: {DOCTRINE}")
        print(f"Operating Frequency: {OPERATING_FREQ_HZ} Hz (φ)")
        print()

        results = enforcer.scan_repository()

        print(f"L-131 Violations: {len(results['l131_violations'])}")
        for violation in results['l131_violations']:
            print(f"  ❌ {violation['violation_type']}")
            print(f"     File: {violation['filepath']}")
            print(f"     Reason: {violation['reason']}")
            print()

        print(f"Demo Violations: {len(results['demo_violations'])}")
        for filepath in results['demo_violations']:
            print(f"  ❌ PROT-001: Demo file detected")
            print(f"     File: {filepath}")
            print()

        print(f"Total Violations: {results['total_violations']}")

        if results['total_violations'] == 0:
            print("\n✅ REPOSITORY IS COMPLIANT")
            sys.exit(0)
        else:
            print("\n❌ REPOSITORY HAS VIOLATIONS")
            sys.exit(1)


if __name__ == "__main__":
    main()
