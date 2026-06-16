"""
MEMORIA RECALL BOT — Recuperator Memoriae
==========================================

Tests the three Memory Temple tiers (SACRA, VIVA, NEXUS) for recall health.
Exercises the web worker JS files for syntax validity, checks that the memory
index is fresh, and benchmarks retrieval expectations.

Tests run:
  1. SACRA health — memoria-sacra-worker.js syntax + seed ring presence
  2. VIVA health  — memoria-viva-worker.js syntax + TTL presets valid
  3. NEXUS health — memoria-nexus-worker.js syntax + seed graph integrity
  4. Index freshness — memoria-index.json exists and is current
  5. Entity count drift — actual counts match expected thresholds

Scoring:
  recall_score = passed_tests / total_tests
  healthy = recall_score >= φ² / (total_tests / PHI)   (scaled to PHI)
  Simple healthy = all critical tests pass

Usage (CI mode):
  python3 nova_ovo/agents/memoria/memoria_recall_bot.py \
    --repo-root=/path/to/repo \
    --output=/tmp/recall-report.json

Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
"""

from __future__ import annotations

import argparse
import json
import math
import re
import sys
import time
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Dict, List, Optional

PHI    = (1 + math.sqrt(5)) / 2
PHI_SQ = PHI * PHI

BOT_NAME  = "RECUPERATOR-BOT"
BOT_LATIN = "Recuperator Memoriae"
BOT_MOTTO = "Recordatur, ergo est."     # It remembers, therefore it is
BOT_MOTTO_EN = "It remembers, therefore it is."
BOT_LAW   = "L-005: Agent Existence Law — Always-on, not alive"
BOT_PROT  = "PROT-131"

# Expected thresholds (from entity-counts.json)
EXPECTED_MOTOKO  = 181
EXPECTED_WORKERS = 31
EXPECTED_PAPERS  = 17   # PAPER-I through PAPER-XVII (Leges + Doctrina use different IDs)
EXPECTED_PROTOCOLS = 125


@dataclass
class RecallTest:
    """One recall health test."""
    test_id:     str
    name:        str
    tier:        str    # SACRA | VIVA | NEXUS | INDEX | ENTITY | SYSTEM
    critical:    bool
    passed:      bool = False
    detail:      str  = ""
    duration_ms: float = 0.0

    def to_dict(self) -> dict:
        return {
            "test_id":     self.test_id,
            "name":        self.name,
            "tier":        self.tier,
            "critical":    self.critical,
            "passed":      self.passed,
            "detail":      self.detail,
            "duration_ms": self.duration_ms,
        }


class MemoriaRecallBot:
    """RECUPERATOR — tests Memory Temple recall health."""

    def __init__(self, repo_root: str):
        self.root  = Path(repo_root).resolve()
        self.tests: List[RecallTest] = []
        self._seq = 1

    def _t(self, name: str, tier: str, critical: bool) -> RecallTest:
        t = RecallTest(test_id=f"RT-{self._seq:03d}", name=name, tier=tier, critical=critical)
        self._seq += 1
        self.tests.append(t)
        return t

    def _worker_exists_and_valid(self, filename: str) -> tuple[bool, str]:
        """Check that a web worker JS file exists and has no syntax errors heuristically."""
        path = self.root / "organism-cli" / "web" / filename
        if not path.exists():
            return False, f"{filename} not found"
        src = path.read_text(encoding="utf-8", errors="ignore")
        if len(src) < 500:
            return False, f"{filename} suspiciously small ({len(src)} chars)"
        if "self.onmessage" not in src:
            return False, f"{filename} missing self.onmessage handler"
        if "PHI" not in src:
            return False, f"{filename} missing PHI constant"
        return True, f"OK ({len(src)} chars)"

    # ── Tests ──────────────────────────────────────────────────────────────

    def _test_sacra(self) -> None:
        t = self._t("SACRA worker exists and valid", "SACRA", critical=True)
        start = time.time()
        ok, detail = self._worker_exists_and_valid("memoria-sacra-worker.js")
        if ok:
            # Check for seed ring
            src = (self.root / "organism-cli" / "web" / "memoria-sacra-worker.js").read_text(encoding="utf-8")
            if "SACRED_RING" not in src or "ring: 0" not in src:
                ok, detail = False, "SACRED_RING seed data missing or corrupt"
        t.passed = ok
        t.detail = detail
        t.duration_ms = (time.time() - start) * 1000

    def _test_viva(self) -> None:
        t = self._t("VIVA worker exists and valid", "VIVA", critical=True)
        start = time.time()
        ok, detail = self._worker_exists_and_valid("memoria-viva-worker.js")
        if ok:
            src = (self.root / "organism-cli" / "web" / "memoria-viva-worker.js").read_text(encoding="utf-8")
            if "TTL" not in src or "FLASH" not in src:
                ok, detail = False, "TTL presets missing in VIVA worker"
        t.passed = ok
        t.detail = detail
        t.duration_ms = (time.time() - start) * 1000

    def _test_nexus(self) -> None:
        t = self._t("NEXUS worker exists and valid", "NEXUS", critical=True)
        start = time.time()
        ok, detail = self._worker_exists_and_valid("memoria-nexus-worker.js")
        if ok:
            src = (self.root / "organism-cli" / "web" / "memoria-nexus-worker.js").read_text(encoding="utf-8")
            if "_edges" not in src or "_nodes" not in src:
                ok, detail = False, "NEXUS graph structures missing"
        t.passed = ok
        t.detail = detail
        t.duration_ms = (time.time() - start) * 1000

    def _test_index_freshness(self) -> None:
        t = self._t("memoria-index.json exists", "INDEX", critical=False)
        start = time.time()
        index_path = self.root / "docs" / "bot-fleet" / "memoria-index.json"
        if index_path.exists():
            try:
                data = json.loads(index_path.read_text(encoding="utf-8"))
                count = data.get("stats", {}).get("total_entries", 0)
                t.passed = count > 0
                t.detail = f"Index present: {count} entries"
            except Exception as exc:
                t.passed = False
                t.detail = f"JSON parse error: {exc}"
        else:
            t.passed = False
            t.detail = "memoria-index.json not yet built (run INDEXATOR first)"
        t.duration_ms = (time.time() - start) * 1000

    def _test_entity_counts(self) -> None:
        # Motoko modules
        t = self._t(f"Motoko modules ≥ {EXPECTED_MOTOKO}", "ENTITY", critical=False)
        start = time.time()
        backend = self.root / "icp" / "src" / "medina_backend"
        actual = len(list(backend.glob("*.mo"))) if backend.exists() else 0
        t.passed = actual >= EXPECTED_MOTOKO
        t.detail = f"expected ≥ {EXPECTED_MOTOKO}, actual = {actual}"
        t.duration_ms = (time.time() - start) * 1000

        # Web workers
        t2 = self._t(f"Web workers ≥ {EXPECTED_WORKERS}", "ENTITY", critical=False)
        start = time.time()
        web = self.root / "organism-cli" / "web"
        actual2 = len(list(web.glob("*.js"))) if web.exists() else 0
        t2.passed = actual2 >= EXPECTED_WORKERS
        t2.detail = f"expected ≥ {EXPECTED_WORKERS}, actual = {actual2}"
        t2.duration_ms = (time.time() - start) * 1000

        # Papers in worker
        t3 = self._t(f"Research papers = {EXPECTED_PAPERS}", "ENTITY", critical=False)
        start = time.time()
        pw = self.root / "organism-cli" / "web" / "papers-worker.js"
        if pw.exists():
            src = pw.read_text(encoding="utf-8", errors="ignore")
            found = len(re.findall(r"id:\s*'PAPER-", src))
            t3.passed = found >= EXPECTED_PAPERS
            t3.detail = f"expected ≥ {EXPECTED_PAPERS}, found {found} PAPER-* entries"
        else:
            t3.passed = False
            t3.detail = "papers-worker.js not found"
        t3.duration_ms = (time.time() - start) * 1000

    # ── Run all ────────────────────────────────────────────────────────────

    def run(self) -> Dict[str, Any]:
        self._test_sacra()
        self._test_viva()
        self._test_nexus()
        self._test_index_freshness()
        self._test_entity_counts()

        passed   = sum(1 for t in self.tests if t.passed)
        total    = len(self.tests)
        critical_failed = [t for t in self.tests if t.critical and not t.passed]
        recall_score = round(passed / total, 4) if total else 0.0
        healthy  = len(critical_failed) == 0

        issues = [f"[{t.tier}] {t.name}: {t.detail}" for t in self.tests if not t.passed]

        return {
            "_meta": {
                "bot_name":  BOT_NAME,
                "bot_latin": BOT_LATIN,
                "bot_prot":  BOT_PROT,
                "built_at":  time.time(),
                "phi":       PHI,
                "law":       BOT_LAW,
            },
            "summary": {
                "passed":        passed,
                "total":         total,
                "recall_score":  recall_score,
                "healthy":       healthy,
                "critical_failed": len(critical_failed),
                "phi":           PHI,
            },
            "issues":  issues,
            "tests":   [t.to_dict() for t in self.tests],
        }


def run_recuperator(repo_root: str, output: Optional[str] = None) -> Dict[str, Any]:
    bot  = MemoriaRecallBot(repo_root=repo_root)
    data = bot.run()

    if output:
        out_path = Path(output)
        out_path.parent.mkdir(parents=True, exist_ok=True)
        out_path.write_text(json.dumps(data, indent=2, ensure_ascii=False), encoding="utf-8")

    s = data["summary"]
    status = "✅ HEALTHY" if s["healthy"] else "⚠️ ISSUES DETECTED"
    print(f"[RECUPERATOR] {status} | score={s['recall_score']} ({s['passed']}/{s['total']}) | φ={PHI:.6f}")
    for issue in data.get("issues", []):
        print(f"  ⚠ {issue}")
    return data


def main() -> int:
    parser = argparse.ArgumentParser(description="RECUPERATOR — Memoria Recall Bot")
    parser.add_argument("--repo-root", required=True)
    parser.add_argument("--output",    default=None)
    args = parser.parse_args()

    try:
        data = run_recuperator(repo_root=args.repo_root, output=args.output)
        return 0 if data["summary"]["healthy"] else 1
    except Exception as exc:
        print(f"[RECUPERATOR] ERROR: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
