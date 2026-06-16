"""
MEMORIA INDEX BOT — Indexator Memoriae
=======================================

Scans the Organism for all memory objects (research papers, protocols,
doctrines, axioms, bot records) and builds a unified searchable memory index.
Writes the index to docs/bot-fleet/memoria-index.json.

Objects indexed:
  1. Research papers from organism-cli/web/papers-worker.js
  2. Protocols from organism-cli/web/protocol-papers.js (count)
  3. Doctrine files from doctrine/
  4. Bot fleet files from docs/bot-fleet/
  5. Motoko engine files from icp/src/medina_backend/
  6. Web workers from organism-cli/web/

Usage (CI mode):
  python3 nova_ovo/agents/memoria/memoria_index_bot.py \
    --repo-root=/path/to/repo \
    --output=docs/bot-fleet/memoria-index.json

Usage (library):
  from nova_ovo.agents.memoria import MemoriaIndexBot, run_indexator
  index = run_indexator(repo_root="/path/to/repo")

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
from typing import Any, Dict, List, Optional

# ═══════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════

PHI = (1 + math.sqrt(5)) / 2

BOT_NAME  = "INDEXATOR-BOT"
BOT_LATIN = "Indexator Memoriae"
BOT_MOTTO = "Omnia in unum indicem."       # All things into one index
BOT_MOTTO_EN = "All things into one index."
BOT_LAW   = "L-005: Agent Existence Law — Always-on, not alive"
BOT_PROT  = "PROT-129"


# ═══════════════════════════════════════════════════════════════════════════
# DATA STRUCTURES
# ═══════════════════════════════════════════════════════════════════════════

@dataclass
class IndexEntry:
    """One entry in the memory index."""
    entry_id:    str
    category:    str    # paper | protocol | doctrine | bot | engine | worker | axiom
    source_file: str
    name:        str
    summary:     str    = ""
    tags:        List[str] = field(default_factory=list)
    scc:         Optional[float] = None
    phi_optimal: bool   = False
    indexed_at:  float  = field(default_factory=time.time)

    def to_dict(self) -> Dict[str, Any]:
        return {
            "entry_id":    self.entry_id,
            "category":    self.category,
            "source_file": self.source_file,
            "name":        self.name,
            "summary":     self.summary,
            "tags":        self.tags,
            "scc":         self.scc,
            "phi_optimal": self.phi_optimal,
            "indexed_at":  self.indexed_at,
        }


@dataclass
class MemoriaIndex:
    """Full memory index output."""
    bot_name:   str = BOT_NAME
    bot_latin:  str = BOT_LATIN
    repo_root:  str = ""
    built_at:   float = field(default_factory=time.time)
    phi:        float = PHI
    entries:    List[IndexEntry] = field(default_factory=list)
    stats:      Dict[str, Any] = field(default_factory=dict)

    def to_dict(self) -> Dict[str, Any]:
        return {
            "_meta": {
                "bot_name":  self.bot_name,
                "bot_latin": self.bot_latin,
                "bot_prot":  BOT_PROT,
                "built_at":  self.built_at,
                "phi":       self.phi,
                "law":       BOT_LAW,
            },
            "stats":   self.stats,
            "entries": [e.to_dict() for e in self.entries],
        }


# ═══════════════════════════════════════════════════════════════════════════
# INDEXATOR BOT
# ═══════════════════════════════════════════════════════════════════════════

class MemoriaIndexBot:
    """INDEXATOR — builds the Organism memory index."""

    def __init__(self, repo_root: str):
        self.repo_root = Path(repo_root).resolve()
        self.entries: List[IndexEntry] = []
        self._seq = 1

    def _make_id(self, prefix: str) -> str:
        eid = f"{prefix}-{self._seq:04d}"
        self._seq += 1
        return eid

    # ── Scanners ───────────────────────────────────────────────────────────

    def _scan_papers(self) -> None:
        """Extract paper records from papers-worker.js."""
        pw = self.repo_root / "organism-cli" / "web" / "papers-worker.js"
        if not pw.exists():
            return
        src = pw.read_text(encoding="utf-8", errors="ignore")
        # Extract id + latinTitle + scc
        for m in re.finditer(r"id:\s*'(PAPER-[^']+)'.*?latinTitle:\s*'([^']+)'.*?scc:\s*([\d.]+)",
                              src, re.DOTALL):
            pid, title, scc_str = m.group(1), m.group(2), m.group(3)
            scc = float(scc_str)
            self.entries.append(IndexEntry(
                entry_id=self._make_id("PAPER"),
                category="paper",
                source_file="organism-cli/web/papers-worker.js",
                name=pid,
                summary=title,
                tags=["paper", "research", pid.lower()],
                scc=scc,
                phi_optimal=(scc >= PHI ** 2),
            ))

    def _scan_protocols(self) -> None:
        """Count protocols from protocol-papers.js."""
        pp = self.repo_root / "organism-cli" / "web" / "protocol-papers.js"
        if not pp.exists():
            return
        src = pp.read_text(encoding="utf-8", errors="ignore")
        matches = re.findall(r"PROT-(\d+)", src)
        count = len(set(matches))
        self.entries.append(IndexEntry(
            entry_id=self._make_id("PROT"),
            category="protocol",
            source_file="organism-cli/web/protocol-papers.js",
            name=f"PROTOCOLS ({count})",
            summary=f"{count} sovereign protocols PROT-001 through PROT-{max(int(m) for m in matches):03d}",
            tags=["protocol", "sovereign"],
        ))

    def _scan_doctrines(self) -> None:
        """Index doctrine markdown files."""
        doctrine_dir = self.repo_root / "doctrine"
        if not doctrine_dir.exists():
            return
        for md in sorted(doctrine_dir.rglob("*.md")):
            rel = str(md.relative_to(self.repo_root))
            name = md.stem.replace("_", " ").replace("-", " ")
            self.entries.append(IndexEntry(
                entry_id=self._make_id("DOC"),
                category="doctrine",
                source_file=rel,
                name=name,
                summary=f"Doctrine document: {rel}",
                tags=["doctrine", md.parent.name],
            ))

    def _scan_motoko_engines(self) -> None:
        """Index Motoko backend engine files."""
        backend = self.repo_root / "icp" / "src" / "medina_backend"
        if not backend.exists():
            return
        engines = sorted(backend.glob("*.mo"))
        for mo in engines:
            rel = str(mo.relative_to(self.repo_root))
            self.entries.append(IndexEntry(
                entry_id=self._make_id("MO"),
                category="engine",
                source_file=rel,
                name=mo.stem,
                summary=f"Motoko engine: {mo.stem}",
                tags=["motoko", "icp", "engine"],
            ))

    def _scan_web_workers(self) -> None:
        """Index web worker JS files."""
        web = self.repo_root / "organism-cli" / "web"
        if not web.exists():
            return
        for js in sorted(web.glob("*-worker.js")):
            rel = str(js.relative_to(self.repo_root))
            self.entries.append(IndexEntry(
                entry_id=self._make_id("WW"),
                category="worker",
                source_file=rel,
                name=js.stem,
                summary=f"Web Worker: {js.stem}",
                tags=["worker", "web", "organism"],
            ))

    def _scan_bot_fleet(self) -> None:
        """Index bot fleet docs."""
        bf = self.repo_root / "docs" / "bot-fleet"
        if not bf.exists():
            return
        for f in sorted(bf.iterdir()):
            if f.suffix in {".json", ".md"}:
                rel = str(f.relative_to(self.repo_root))
                self.entries.append(IndexEntry(
                    entry_id=self._make_id("BF"),
                    category="bot",
                    source_file=rel,
                    name=f.stem,
                    summary=f"Bot fleet record: {f.stem}",
                    tags=["bot-fleet", "proof", f.suffix.lstrip(".")],
                ))

    # ── Build ──────────────────────────────────────────────────────────────

    def build(self) -> MemoriaIndex:
        self._scan_papers()
        self._scan_protocols()
        self._scan_doctrines()
        self._scan_motoko_engines()
        self._scan_web_workers()
        self._scan_bot_fleet()

        # Build stats
        by_cat: Dict[str, int] = {}
        phi_opt = 0
        for e in self.entries:
            by_cat[e.category] = by_cat.get(e.category, 0) + 1
            if e.phi_optimal:
                phi_opt += 1

        idx = MemoriaIndex(
            repo_root=str(self.repo_root),
            entries=self.entries,
            stats={
                "total_entries": len(self.entries),
                "by_category":   by_cat,
                "phi_optimal":   phi_opt,
                "phi":           PHI,
            },
        )
        return idx


# ═══════════════════════════════════════════════════════════════════════════
# CONVENIENCE WRAPPER
# ═══════════════════════════════════════════════════════════════════════════

def run_indexator(repo_root: str, output: Optional[str] = None) -> Dict[str, Any]:
    """Run the INDEXATOR and optionally write output JSON."""
    bot   = MemoriaIndexBot(repo_root=repo_root)
    index = bot.build()
    data  = index.to_dict()

    if output:
        out_path = Path(output)
        out_path.parent.mkdir(parents=True, exist_ok=True)
        out_path.write_text(json.dumps(data, indent=2, ensure_ascii=False), encoding="utf-8")
        print(f"[INDEXATOR] Memory index written to {output}")

    print(f"[INDEXATOR] {data['stats']['total_entries']} entries indexed. φ = {PHI:.10f}")
    return data


# ═══════════════════════════════════════════════════════════════════════════
# CLI
# ═══════════════════════════════════════════════════════════════════════════

def main() -> int:
    parser = argparse.ArgumentParser(description="INDEXATOR — Memoria Index Bot")
    parser.add_argument("--repo-root", required=True)
    parser.add_argument("--output",    default=None)
    args = parser.parse_args()

    try:
        run_indexator(repo_root=args.repo_root, output=args.output)
        return 0
    except Exception as exc:
        print(f"[INDEXATOR] ERROR: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
