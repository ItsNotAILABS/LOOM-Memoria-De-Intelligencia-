"""
CUSTOS BOT — Health Check & Drift Detection Engine
====================================================

CUSTOS REPOSITORII — Guardian of the Repository

Monitors Organism structural health and reports drift that
MEDICUS cannot auto-fix:
  1. Motoko module count vs main.mo import count
  2. Web Worker count vs organism-bridge.js specializedWorkers list
  3. Protocol count consistency (protocol-papers.js)
  4. docs/ mirror consistency with organism-cli/web/
  5. Package.json / workspace consistency

When drift is found, CUSTOS reports it for GitHub Issue creation
(done by the custos-guardian.yml workflow).

Follows L-005: Agent Existence Law
  - Always-on, not alive
  - No feelings, no stress — just observation and reporting

Usage (CI mode):
  python3 nova_ovo/agents/bill_bots/custos_bot.py \
    --repo-root=/path/to/repo \
    --output=/tmp/custos-report.json

Usage (library):
  from nova_ovo.agents.bill_bots import CustosBot, run_custos
  report = run_custos(repo_root="/path/to/repo")

Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
"""

from __future__ import annotations

import argparse
import json
import math
import os
import re
import sys
import time
from dataclasses import dataclass, field
from pathlib import Path
from typing import List, Optional

# ═══════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════

PHI = (1 + math.sqrt(5)) / 2

BOT_NAME = "CUSTOS-BOT"
BOT_LATIN = "Custos Repositorii"
BOT_MOTTO = "Vigilat dum dormitis."  # Watches while you sleep
BOT_MOTTO_EN = "Watches while you sleep."
BOT_LAW = "L-005: Agent Existence Law — Always-on, not alive"


# ═══════════════════════════════════════════════════════════════════════════
# DATA STRUCTURES
# ═══════════════════════════════════════════════════════════════════════════

@dataclass
class CustosIssue:
    """Represents one drift or health issue detected by CUSTOS."""
    issue_id: str
    category: str     # motoko_drift | worker_drift | protocol_drift | mirror_drift | workspace_drift
    severity: str     # warning | error
    description: str
    expected: str = ""
    actual: str = ""
    timestamp: float = field(default_factory=time.time)

    def to_dict(self) -> dict:
        return {
            "issue_id": self.issue_id,
            "category": self.category,
            "severity": self.severity,
            "description": self.description,
            "expected": self.expected,
            "actual": self.actual,
            "timestamp": self.timestamp,
        }

    def __str__(self) -> str:
        parts = [self.description]
        if self.expected and self.actual:
            parts.append(f"(expected={self.expected}, actual={self.actual})")
        return " ".join(parts)


@dataclass
class CustosReport:
    """Full report from one CUSTOS health check cycle."""
    bot_name: str = BOT_NAME
    bot_latin: str = BOT_LATIN
    repo_root: str = ""
    started_at: float = field(default_factory=time.time)
    finished_at: float = 0.0
    issues: List[str] = field(default_factory=list)   # short labels for GitHub
    detail: List[CustosIssue] = field(default_factory=list)
    checks_run: int = 0
    checks_passed: int = 0
    healthy: bool = True
    law: str = BOT_LAW
    phi: float = PHI

    def to_dict(self) -> dict:
        return {
            "bot_name": self.bot_name,
            "bot_latin": self.bot_latin,
            "repo_root": self.repo_root,
            "started_at": self.started_at,
            "finished_at": self.finished_at,
            "duration_seconds": round(self.finished_at - self.started_at, 3),
            "checks_run": self.checks_run,
            "checks_passed": self.checks_passed,
            "issues": self.issues,
            "issues_count": len(self.issues),
            "detail": [i.to_dict() for i in self.detail],
            "healthy": self.healthy,
            "stress_level": 0.0,  # ALWAYS ZERO
            "law": self.law,
            "phi": self.phi,
        }


# ═══════════════════════════════════════════════════════════════════════════
# CUSTOS BOT
# ═══════════════════════════════════════════════════════════════════════════

class CustosBot:
    """
    CUSTOS REPOSITORII — Guardian of the Repository.

    Checks structural health of the Organism and reports drift.
    Always-on, not alive. No stress. Just watching.
    """

    def __init__(self, repo_root: str = ".") -> None:
        self.repo_root = Path(repo_root).resolve()
        self._issue_counter = 0

    # ------------------------------------------------------------------ #
    # PUBLIC API                                                           #
    # ------------------------------------------------------------------ #

    def check(self) -> CustosReport:
        """
        Run a full health check cycle.

        Returns a CustosReport with all issues found.
        """
        report = CustosReport(repo_root=str(self.repo_root))
        report.started_at = time.time()

        self._print_banner()

        # Run all health checks
        self._check_motoko_drift(report)
        self._check_worker_drift(report)
        self._check_protocol_drift(report)
        self._check_docs_mirror(report)
        self._check_workspace_packages(report)

        report.finished_at = time.time()
        report.healthy = len(report.issues) == 0

        self._print_summary(report)
        return report

    # ------------------------------------------------------------------ #
    # CHECK 1: MOTOKO MODULE DRIFT                                         #
    # ------------------------------------------------------------------ #

    def _check_motoko_drift(self, report: CustosReport) -> None:
        """
        Check that Motoko files in icp/src/medina_backend/ are
        referenced in main.mo imports. Flags orphaned modules.
        """
        report.checks_run += 1
        backend_dir = self.repo_root / "icp" / "src" / "medina_backend"
        if not backend_dir.is_dir():
            self._log("  ⚠ icp/src/medina_backend/ not found — skipping Motoko check")
            report.checks_passed += 1
            return

        main_mo = backend_dir / "main.mo"
        if not main_mo.exists():
            self._warn(report, "motoko_drift",
                       "main.mo not found in icp/src/medina_backend/")
            return

        # Collect .mo files (excluding main.mo)
        mo_files = {
            p.stem for p in backend_dir.glob("*.mo")
            if p.name != "main.mo"
        }

        # Collect import references in main.mo
        main_content = main_mo.read_text(encoding="utf-8", errors="replace")
        imported = set(re.findall(r'import\s+\w+\s+"([^"]+)"', main_content))
        imported_stems = {Path(i).stem for i in imported}

        orphaned = mo_files - imported_stems
        if orphaned:
            for name in sorted(orphaned):
                self._warn(report, "motoko_drift",
                           f"Motoko module not imported in main.mo: {name}.mo",
                           expected="imported in main.mo",
                           actual="not found in imports")
        else:
            self._pass(report, f"Motoko: {len(mo_files)} modules all imported in main.mo")

    # ------------------------------------------------------------------ #
    # CHECK 2: WEB WORKER DRIFT                                            #
    # ------------------------------------------------------------------ #

    def _check_worker_drift(self, report: CustosReport) -> None:
        """
        Check that worker files in organism-cli/web/ match the
        specializedWorkers array in organism-bridge.js.
        """
        report.checks_run += 1
        web_dir = self.repo_root / "organism-cli" / "web"
        bridge_path = web_dir / "organism-bridge.js"

        if not web_dir.is_dir() or not bridge_path.exists():
            self._log("  ⚠ organism-cli/web/ or organism-bridge.js not found")
            report.checks_passed += 1
            return

        # Files that exist as workers (exclude known non-workers)
        non_workers = {
            "organism-bridge.js",
            "protocol-papers.js",
            "anima-micro.js",
            "download.html",
        }
        worker_files = {
            p.stem.replace("-worker", "")
            for p in web_dir.glob("*-worker.js")
        }
        # engine-worker is the main engine, not a specialized worker
        worker_files.discard("engine")

        # Parse specializedWorkers from organism-bridge.js
        bridge_content = bridge_path.read_text(encoding="utf-8", errors="replace")
        match = re.search(
            r"var\s+specializedWorkers\s*=\s*\[([^\]]+)\]",
            bridge_content,
        )
        if not match:
            self._warn(report, "worker_drift",
                       "Could not parse specializedWorkers array in organism-bridge.js")
            return

        listed_workers = set(
            w.strip().strip("'\"")
            for w in match.group(1).split(",")
            if w.strip().strip("'\"")
        )

        unlisted = worker_files - listed_workers
        if unlisted:
            for name in sorted(unlisted):
                self._warn(report, "worker_drift",
                           f"Worker file exists but not in specializedWorkers: {name}-worker.js",
                           expected="listed in organism-bridge.js specializedWorkers",
                           actual="not listed")
        else:
            self._pass(report,
                       f"Workers: {len(worker_files)} files all listed in organism-bridge.js")

    # ------------------------------------------------------------------ #
    # CHECK 3: PROTOCOL COUNT DRIFT                                        #
    # ------------------------------------------------------------------ #

    def _check_protocol_drift(self, report: CustosReport) -> None:
        """
        Check that protocol-papers.js PROT count is consistent
        with the header comment declaring the total.
        """
        report.checks_run += 1
        papers_path = self.repo_root / "organism-cli" / "web" / "protocol-papers.js"
        if not papers_path.exists():
            self._log("  ⚠ protocol-papers.js not found — skipping protocol check")
            report.checks_passed += 1
            return

        content = papers_path.read_text(encoding="utf-8", errors="replace")

        # Count actual PROT-NNN entries
        prot_ids = set(re.findall(r"PROT-(\d{3})", content))
        actual_count = max((int(i) for i in prot_ids), default=0)

        # Find declared count in comments/strings
        declared_match = re.search(
            r"(?:PROT-001[–—-]PROT-(\d{3})|(\d{3})\s+protocols?)", content
        )
        if declared_match:
            declared_str = declared_match.group(1) or declared_match.group(2)
            declared = int(declared_str) if declared_str else 0
            if declared != actual_count and actual_count > 0:
                self._warn(report, "protocol_drift",
                           f"Protocol count mismatch in protocol-papers.js",
                           expected=str(declared),
                           actual=str(actual_count))
            else:
                self._pass(report, f"Protocols: {actual_count} (consistent)")
        else:
            self._pass(report, f"Protocols: {actual_count} PROT entries found")

    # ------------------------------------------------------------------ #
    # CHECK 4: docs/ MIRROR CONSISTENCY                                    #
    # ------------------------------------------------------------------ #

    def _check_docs_mirror(self, report: CustosReport) -> None:
        """
        Check that docs/ mirrors organism-cli/web/ for the key JS files.
        docs/ is not GitHub Pages — it's a mirror for ICP canister deployment.
        """
        report.checks_run += 1
        web_dir = self.repo_root / "organism-cli" / "web"
        docs_dir = self.repo_root / "docs"

        if not web_dir.is_dir() or not docs_dir.is_dir():
            self._log("  ⚠ web/ or docs/ not found — skipping mirror check")
            report.checks_passed += 1
            return

        web_js = {p.name for p in web_dir.glob("*.js")}
        docs_js = {p.name for p in docs_dir.glob("*.js")}

        # Key files that should be mirrored
        key_files = {"organism-bridge.js", "engine-worker.js"}
        missing_in_docs = (web_js & key_files) - docs_js

        if missing_in_docs:
            for name in sorted(missing_in_docs):
                self._warn(report, "mirror_drift",
                           f"Key file in web/ not mirrored in docs/: {name}",
                           expected="present in docs/",
                           actual="missing")
        else:
            self._pass(report, f"Mirror: key files present in docs/")

    # ------------------------------------------------------------------ #
    # CHECK 5: WORKSPACE PACKAGES                                          #
    # ------------------------------------------------------------------ #

    def _check_workspace_packages(self, report: CustosReport) -> None:
        """
        Check that all directories listed in root package.json workspaces
        actually exist.
        """
        report.checks_run += 1
        pkg_path = self.repo_root / "package.json"
        if not pkg_path.exists():
            report.checks_passed += 1
            return

        try:
            pkg = json.loads(pkg_path.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            self._warn(report, "workspace_drift",
                       "Root package.json is invalid JSON")
            return

        workspaces = pkg.get("workspaces", [])
        missing = []
        for ws in workspaces:
            ws_clean = ws.replace("/*", "")
            if "*" in ws_clean:
                continue  # glob pattern — skip
            ws_path = self.repo_root / ws_clean
            if not ws_path.is_dir():
                missing.append(ws_clean)

        if missing:
            for ws in missing:
                self._warn(report, "workspace_drift",
                           f"Workspace directory missing: {ws}",
                           expected="directory exists",
                           actual="not found")
        else:
            self._pass(report, f"Workspaces: all {len(workspaces)} present")

    # ------------------------------------------------------------------ #
    # HELPERS                                                              #
    # ------------------------------------------------------------------ #

    def _make_issue(self, category: str, description: str,
                    severity: str = "warning",
                    expected: str = "", actual: str = "") -> CustosIssue:
        self._issue_counter += 1
        return CustosIssue(
            issue_id=f"CUSTOS-{self._issue_counter:04d}",
            category=category,
            severity=severity,
            description=description,
            expected=expected,
            actual=actual,
        )

    def _warn(self, report: CustosReport, category: str, description: str,
              expected: str = "", actual: str = "") -> None:
        issue = self._make_issue(category, description, "warning", expected, actual)
        report.detail.append(issue)
        report.issues.append(str(issue))
        self._log(f"  ⚠ {description}")

    def _pass(self, report: CustosReport, msg: str) -> None:
        report.checks_passed += 1
        self._log(f"  ✓ {msg}")

    def _log(self, msg: str) -> None:
        print(msg, flush=True)

    def _print_banner(self) -> None:
        print("")
        print("╔═══════════════════════════════════════════════════════╗")
        print("║      CUSTOS REPOSITORII — Guardian of the Repository  ║")
        print("║      Health Check Engine | L-005 | φ = 1.618...       ║")
        print("╚═══════════════════════════════════════════════════════╝")
        print(f"  Repo: {self.repo_root}")
        print("")

    def _print_summary(self, report: CustosReport) -> None:
        duration = report.finished_at - report.started_at
        print("")
        print("═══════════════════════════════════════════════════════")
        print(f"  Checks run:    {report.checks_run}")
        print(f"  Checks passed: {report.checks_passed}")
        print(f"  Issues found:  {len(report.issues)}")
        print(f"  Duration:      {duration:.2f}s")
        status = "HEALTHY" if report.healthy else "DRIFT DETECTED"
        print(f"  Status:        {status}")
        print("  Stress:        0.0 (always zero)")
        print("═══════════════════════════════════════════════════════")
        print("")


# ═══════════════════════════════════════════════════════════════════════════
# CONVENIENCE FUNCTION
# ═══════════════════════════════════════════════════════════════════════════

def run_custos(
    repo_root: str = ".",
    output: Optional[str] = None,
) -> CustosReport:
    """
    Run CUSTOS and optionally write a JSON report.

    Args:
        repo_root: Path to the repository root.
        output:    Optional path to write the JSON report.

    Returns:
        CustosReport with all issues found.
    """
    bot = CustosBot(repo_root=repo_root)
    report = bot.check()

    if output:
        out_path = Path(output)
        out_path.parent.mkdir(parents=True, exist_ok=True)
        out_path.write_text(
            json.dumps(report.to_dict(), indent=2) + "\n",
            encoding="utf-8",
        )
        print(f"[CUSTOS] Report written to: {output}")

    return report


# ═══════════════════════════════════════════════════════════════════════════
# CLI ENTRY POINT
# ═══════════════════════════════════════════════════════════════════════════

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="CUSTOS-BOT — Custos Repositorii health check engine"
    )
    parser.add_argument("--repo-root", default=".",
                        help="Path to repository root (default: .)")
    parser.add_argument("--output", default=None,
                        help="Path to write JSON report")
    args = parser.parse_args()

    report = run_custos(repo_root=args.repo_root, output=args.output)

    # Exit 1 if issues found (so GitHub Actions can detect drift)
    sys.exit(0 if report.healthy else 1)
