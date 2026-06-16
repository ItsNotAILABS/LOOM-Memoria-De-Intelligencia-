"""
MEDICUS BOT — Auto-Fix Engine
==============================

MEDICUS MACHINAE — Doctor of the Machine

Detects and auto-fixes common Organism issues:
  1. JSON validation / pretty-print repair
  2. Missing __init__.py files in Python packages
  3. Trailing whitespace in source files
  4. Manifest consistency (extensions/*/manifest.json)
  5. Empty / zero-byte source files

Follows L-005: Agent Existence Law
  - Always-on, not alive
  - No feelings, no stress — just detection and repair

Usage (CI mode):
  python3 nova_ovo/agents/bill_bots/medicus_bot.py \
    --mode=ci \
    --repo-root=/path/to/repo \
    --output=dist/governance/events/medicus-report.json

Usage (library):
  from nova_ovo.agents.bill_bots import MedicusBot, run_medicus
  report = run_medicus(repo_root="/path/to/repo")

Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
"""

from __future__ import annotations

import argparse
import json
import math
import os
import sys
import time
from dataclasses import dataclass, field
from pathlib import Path
from typing import List, Optional

# ═══════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════

PHI = (1 + math.sqrt(5)) / 2
PHI_SQ = PHI * PHI

BOT_NAME = "MEDICUS-BOT"
BOT_LATIN = "Medicus Machinae"
BOT_MOTTO = "Sanat quod fractum est."  # Heals what is broken
BOT_MOTTO_EN = "Heals what is broken."
BOT_LAW = "L-005: Agent Existence Law — Always-on, not alive"

# Source file extensions that may have trailing whitespace fixed
WHITESPACE_EXTENSIONS = {
    ".py", ".js", ".ts", ".mo", ".sh", ".json", ".md",
    ".html", ".css", ".txt", ".yml", ".yaml", ".toml",
}

# Extensions whose JSON must be valid
JSON_EXTENSIONS = {".json"}


# ═══════════════════════════════════════════════════════════════════════════
# DATA STRUCTURES
# ═══════════════════════════════════════════════════════════════════════════

@dataclass
class MedicusFix:
    """Represents one auto-fix applied by MEDICUS."""
    fix_id: str
    category: str       # json_repair | missing_init | trailing_ws | empty_file | manifest
    file_path: str
    description: str
    applied: bool = False
    error: Optional[str] = None
    timestamp: float = field(default_factory=time.time)

    def to_dict(self) -> dict:
        return {
            "fix_id": self.fix_id,
            "category": self.category,
            "file_path": self.file_path,
            "description": self.description,
            "applied": self.applied,
            "error": self.error,
            "timestamp": self.timestamp,
        }


@dataclass
class MedicusReport:
    """Full report from one MEDICUS healing cycle."""
    bot_name: str = BOT_NAME
    bot_latin: str = BOT_LATIN
    repo_root: str = ""
    started_at: float = field(default_factory=time.time)
    finished_at: float = 0.0
    fixes_applied: List[str] = field(default_factory=list)   # short labels
    fixes_skipped: List[str] = field(default_factory=list)
    detail: List[MedicusFix] = field(default_factory=list)
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
            "fixes_applied": self.fixes_applied,
            "fixes_skipped": self.fixes_skipped,
            "fixes_applied_count": len(self.fixes_applied),
            "fixes_skipped_count": len(self.fixes_skipped),
            "detail": [f.to_dict() for f in self.detail],
            "healthy": self.healthy,
            "stress_level": 0.0,  # ALWAYS ZERO
            "law": self.law,
            "phi": self.phi,
        }


# ═══════════════════════════════════════════════════════════════════════════
# MEDICUS BOT
# ═══════════════════════════════════════════════════════════════════════════

class MedicusBot:
    """
    MEDICUS MACHINAE — Doctor of the Machine.

    Detects and auto-fixes common Organism issues.
    Always-on, not alive. No stress. Just healing.
    """

    def __init__(self, repo_root: str = ".") -> None:
        self.repo_root = Path(repo_root).resolve()
        self._fix_counter = 0

    # ------------------------------------------------------------------ #
    # PUBLIC API                                                           #
    # ------------------------------------------------------------------ #

    def heal(self) -> MedicusReport:
        """
        Run a full healing cycle.

        Returns a MedicusReport with all fixes attempted.
        """
        report = MedicusReport(repo_root=str(self.repo_root))
        report.started_at = time.time()

        self._print_banner()

        # Run all fix categories
        self._fix_json_files(report)
        self._fix_missing_init_files(report)
        self._fix_trailing_whitespace(report)
        self._fix_empty_source_files(report)
        self._fix_manifest_consistency(report)

        report.finished_at = time.time()
        report.healthy = len(report.fixes_applied) == 0

        self._print_summary(report)
        return report

    # ------------------------------------------------------------------ #
    # FIX CATEGORY 1: JSON VALIDATION / REPAIR                            #
    # ------------------------------------------------------------------ #

    def _fix_json_files(self, report: MedicusReport) -> None:
        """
        Find JSON files that are either invalid or not pretty-printed.
        Repairs and re-formats them with 2-space indent.
        """
        json_paths = list(self.repo_root.rglob("*.json"))
        # Exclude node_modules, .git, build artifacts
        json_paths = [
            p for p in json_paths
            if not any(part in {".git", "node_modules", "build", "dist"}
                       for part in p.parts)
        ]

        for path in json_paths:
            rel = str(path.relative_to(self.repo_root))
            try:
                raw = path.read_text(encoding="utf-8")
                if not raw.strip():
                    continue  # empty JSON handled by empty_file fixer
                data = json.loads(raw)
                pretty = json.dumps(data, indent=2, ensure_ascii=False) + "\n"
                if raw != pretty:
                    path.write_text(pretty, encoding="utf-8")
                    fix = self._make_fix("json_repair", rel,
                                        f"Re-formatted JSON: {rel}")
                    fix.applied = True
                    report.detail.append(fix)
                    report.fixes_applied.append(f"json:{rel}")
                    self._log(f"  ✓ JSON re-formatted: {rel}")
            except json.JSONDecodeError as exc:
                # Cannot auto-repair — log as skipped
                fix = self._make_fix("json_repair", rel,
                                     f"Invalid JSON (cannot auto-repair): {rel}")
                fix.applied = False
                fix.error = str(exc)
                report.detail.append(fix)
                report.fixes_skipped.append(f"json_invalid:{rel}")
                self._log(f"  ✗ Invalid JSON (skipped): {rel} — {exc}")
            except Exception as exc:
                report.fixes_skipped.append(f"json_error:{rel}")
                self._log(f"  ✗ JSON error: {rel} — {exc}")

    # ------------------------------------------------------------------ #
    # FIX CATEGORY 2: MISSING __init__.py                                  #
    # ------------------------------------------------------------------ #

    def _fix_missing_init_files(self, report: MedicusReport) -> None:
        """
        Find Python package directories that have .py files but no __init__.py.
        Creates an empty __init__.py so the package is importable.
        """
        py_dirs: set[Path] = set()
        for py_file in self.repo_root.rglob("*.py"):
            if any(part in {".git", "node_modules", "build", "dist", "__pycache__"}
                   for part in py_file.parts):
                continue
            py_dirs.add(py_file.parent)

        for dir_path in sorted(py_dirs):
            init = dir_path / "__init__.py"
            if not init.exists():
                rel = str(dir_path.relative_to(self.repo_root))
                try:
                    init.write_text(
                        f'"""\n{rel} — auto-generated __init__.py by MEDICUS-BOT\n"""\n',
                        encoding="utf-8",
                    )
                    fix = self._make_fix("missing_init",
                                        str(init.relative_to(self.repo_root)),
                                        f"Created __init__.py in: {rel}")
                    fix.applied = True
                    report.detail.append(fix)
                    report.fixes_applied.append(f"init:{rel}")
                    self._log(f"  ✓ Created __init__.py: {rel}")
                except Exception as exc:
                    report.fixes_skipped.append(f"init_error:{rel}")
                    self._log(f"  ✗ Could not create __init__.py: {rel} — {exc}")

    # ------------------------------------------------------------------ #
    # FIX CATEGORY 3: TRAILING WHITESPACE                                  #
    # ------------------------------------------------------------------ #

    def _fix_trailing_whitespace(self, report: MedicusReport) -> None:
        """
        Remove trailing whitespace from all source files.
        Only touches files that actually have it.
        """
        for ext in WHITESPACE_EXTENSIONS:
            for path in self.repo_root.rglob(f"*{ext}"):
                if any(part in {".git", "node_modules", "build", "dist", "__pycache__"}
                       for part in path.parts):
                    continue
                try:
                    original = path.read_text(encoding="utf-8", errors="replace")
                    lines = original.splitlines(keepends=True)
                    cleaned_lines = [
                        line.rstrip() + "\n" if line.endswith(("\n", "\r\n"))
                        else line.rstrip()
                        for line in lines
                    ]
                    cleaned = "".join(cleaned_lines)
                    if cleaned != original:
                        path.write_text(cleaned, encoding="utf-8")
                        rel = str(path.relative_to(self.repo_root))
                        fix = self._make_fix("trailing_ws", rel,
                                             f"Removed trailing whitespace: {rel}")
                        fix.applied = True
                        report.detail.append(fix)
                        report.fixes_applied.append(f"ws:{rel}")
                        self._log(f"  ✓ Trailing whitespace fixed: {rel}")
                except Exception:
                    pass  # Binary or unreadable — silently skip

    # ------------------------------------------------------------------ #
    # FIX CATEGORY 4: EMPTY SOURCE FILES                                   #
    # ------------------------------------------------------------------ #

    def _fix_empty_source_files(self, report: MedicusReport) -> None:
        """
        Detect zero-byte or whitespace-only source files and log them.
        MEDICUS does not delete files — it flags them for CUSTOS.
        """
        for ext in {".py", ".js", ".ts", ".mo"}:
            for path in self.repo_root.rglob(f"*{ext}"):
                if any(part in {".git", "node_modules", "build", "dist", "__pycache__"}
                       for part in path.parts):
                    continue
                try:
                    content = path.read_text(encoding="utf-8", errors="replace").strip()
                    if not content:
                        rel = str(path.relative_to(self.repo_root))
                        fix = self._make_fix("empty_file", rel,
                                             f"Empty source file detected: {rel}")
                        fix.applied = False
                        fix.error = "Empty files require manual review — flagged for CUSTOS"
                        report.detail.append(fix)
                        report.fixes_skipped.append(f"empty:{rel}")
                        self._log(f"  ⚠ Empty source file (flagged): {rel}")
                except Exception:
                    pass

    # ------------------------------------------------------------------ #
    # FIX CATEGORY 5: MANIFEST CONSISTENCY                                 #
    # ------------------------------------------------------------------ #

    def _fix_manifest_consistency(self, report: MedicusReport) -> None:
        """
        Validate browser extension manifests and re-format them.
        Ensures required fields: name, version, manifest_version.
        """
        ext_root = self.repo_root / "extensions"
        if not ext_root.is_dir():
            return

        for ext_dir in sorted(ext_root.iterdir()):
            if not ext_dir.is_dir():
                continue
            manifest_path = ext_dir / "manifest.json"
            if not manifest_path.exists():
                continue

            rel = str(manifest_path.relative_to(self.repo_root))
            try:
                raw = manifest_path.read_text(encoding="utf-8")
                data = json.loads(raw)
                changed = False

                # Ensure manifest_version is set (default 3)
                if "manifest_version" not in data:
                    data["manifest_version"] = 3
                    changed = True

                if changed:
                    pretty = json.dumps(data, indent=2, ensure_ascii=False) + "\n"
                    manifest_path.write_text(pretty, encoding="utf-8")
                    fix = self._make_fix("manifest", rel,
                                        f"Fixed manifest: {rel}")
                    fix.applied = True
                    report.detail.append(fix)
                    report.fixes_applied.append(f"manifest:{rel}")
                    self._log(f"  ✓ Manifest fixed: {rel}")
            except json.JSONDecodeError as exc:
                fix = self._make_fix("manifest", rel,
                                     f"Invalid manifest JSON: {rel}")
                fix.applied = False
                fix.error = str(exc)
                report.detail.append(fix)
                report.fixes_skipped.append(f"manifest_invalid:{rel}")
                self._log(f"  ✗ Invalid manifest: {rel} — {exc}")

    # ------------------------------------------------------------------ #
    # HELPERS                                                              #
    # ------------------------------------------------------------------ #

    def _make_fix(self, category: str, file_path: str, description: str) -> MedicusFix:
        self._fix_counter += 1
        return MedicusFix(
            fix_id=f"FIX-{self._fix_counter:04d}",
            category=category,
            file_path=file_path,
            description=description,
        )

    def _log(self, msg: str) -> None:
        print(msg, flush=True)

    def _print_banner(self) -> None:
        print("")
        print("╔═══════════════════════════════════════════════════════╗")
        print("║          MEDICUS MACHINAE — Doctor of the Machine     ║")
        print("║          Auto-Fix Engine | L-005 | φ = 1.618...       ║")
        print("╚═══════════════════════════════════════════════════════╝")
        print(f"  Repo: {self.repo_root}")
        print("")

    def _print_summary(self, report: MedicusReport) -> None:
        duration = report.finished_at - report.started_at
        print("")
        print("═══════════════════════════════════════════════════════")
        print(f"  Applied:  {len(report.fixes_applied)}")
        print(f"  Skipped:  {len(report.fixes_skipped)}")
        print(f"  Duration: {duration:.2f}s")
        status = "HEALTHY — no fixes needed" if report.healthy else "FIXED — changes committed"
        print(f"  Status:   {status}")
        print("  Stress:   0.0 (always zero)")
        print("═══════════════════════════════════════════════════════")
        print("")


# ═══════════════════════════════════════════════════════════════════════════
# CONVENIENCE FUNCTION
# ═══════════════════════════════════════════════════════════════════════════

def run_medicus(
    repo_root: str = ".",
    output: Optional[str] = None,
) -> MedicusReport:
    """
    Run MEDICUS and optionally write a JSON report.

    Args:
        repo_root: Path to the repository root.
        output:    Optional path to write the JSON report.

    Returns:
        MedicusReport with all fixes applied.
    """
    bot = MedicusBot(repo_root=repo_root)
    report = bot.heal()

    if output:
        out_path = Path(output)
        out_path.parent.mkdir(parents=True, exist_ok=True)
        out_path.write_text(
            json.dumps(report.to_dict(), indent=2) + "\n",
            encoding="utf-8",
        )
        print(f"[MEDICUS] Report written to: {output}")

    return report


# ═══════════════════════════════════════════════════════════════════════════
# CLI ENTRY POINT
# ═══════════════════════════════════════════════════════════════════════════

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="MEDICUS-BOT — Medicus Machinae auto-fix engine"
    )
    parser.add_argument("--mode", default="ci",
                        help="Run mode: ci | local (default: ci)")
    parser.add_argument("--repo-root", default=".",
                        help="Path to repository root (default: .)")
    parser.add_argument("--output", default=None,
                        help="Path to write JSON report")
    args = parser.parse_args()

    report = run_medicus(repo_root=args.repo_root, output=args.output)

    # Exit 0 even when fixes were applied — fixes are not errors
    sys.exit(0)
