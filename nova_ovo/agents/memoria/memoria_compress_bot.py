"""
MEMORIA COMPRESS BOT — Compressor Memoriae
===========================================

Scans for duplicate or redundant memory records across the Organism and
produces a compression report. Never hard-deletes — only archives/summarizes.

What it compresses:
  1. Duplicate keys in docs/bot-fleet/memoria-index.json
  2. Redundant ORPHAN entries in escalation-log.md (same ESC-ID)
  3. Stale JSON artifacts older than retention period
  4. Semantic near-duplicates (same name, different path)

Output:
  docs/bot-fleet/memoria-compress-report.json

Usage (CI mode):
  python3 nova_ovo/agents/memoria/memoria_compress_bot.py \
    --repo-root=/path/to/repo \
    --output=docs/bot-fleet/memoria-compress-report.json

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
from typing import Any, Dict, List, Optional

PHI = (1 + math.sqrt(5)) / 2
PHI_SQ = PHI * PHI

BOT_NAME  = "COMPRESSOR-BOT"
BOT_LATIN = "Compressor Memoriae"
BOT_MOTTO = "Comprimit sine delendo."   # Compresses without deleting
BOT_MOTTO_EN = "Compresses without deleting."
BOT_LAW   = "L-005: Agent Existence Law — Always-on, not alive"
BOT_PROT  = "PROT-130"

RETENTION_DAYS = 30   # artifacts older than this are flagged (never deleted)


@dataclass
class CompressionRecord:
    """One compression action or observation."""
    record_id:   str
    action:      str   # DEDUPE | ARCHIVE_FLAG | STALE_FLAG | MERGE_SUGGEST
    category:    str
    description: str
    source:      str   = ""
    savings:     int   = 0   # estimated bytes or entries saved
    timestamp:   float = field(default_factory=time.time)

    def to_dict(self) -> dict:
        return {
            "record_id":   self.record_id,
            "action":      self.action,
            "category":    self.category,
            "description": self.description,
            "source":      self.source,
            "savings":     self.savings,
            "timestamp":   self.timestamp,
        }


class MemoriaCompressBot:
    """COMPRESSOR — consolidates Organism memory."""

    def __init__(self, repo_root: str):
        self.repo_root = Path(repo_root).resolve()
        self.records: List[CompressionRecord] = []
        self._seq = 1

    def _make_id(self) -> str:
        rid = f"CR-{self._seq:04d}"
        self._seq += 1
        return rid

    def _compress_index(self) -> None:
        """Deduplicate entries in memoria-index.json."""
        index_path = self.repo_root / "docs" / "bot-fleet" / "memoria-index.json"
        if not index_path.exists():
            return

        try:
            data = json.loads(index_path.read_text(encoding="utf-8"))
        except Exception:
            return

        entries = data.get("entries", [])
        seen_names: Dict[str, int] = {}
        dupes = 0
        for e in entries:
            name = e.get("name", "")
            seen_names[name] = seen_names.get(name, 0) + 1
        for name, count in seen_names.items():
            if count > 1:
                dupes += count - 1
                self.records.append(CompressionRecord(
                    record_id=self._make_id(),
                    action="DEDUPE",
                    category="index",
                    description=f"Duplicate index entry '{name}' appears {count} times — keep 1, archive {count-1}",
                    source="docs/bot-fleet/memoria-index.json",
                    savings=count - 1,
                ))

        if dupes == 0:
            self.records.append(CompressionRecord(
                record_id=self._make_id(),
                action="NO_ACTION",
                category="index",
                description=f"memoria-index.json clean — {len(entries)} unique entries, 0 duplicates",
                source="docs/bot-fleet/memoria-index.json",
            ))

    def _compress_escalations(self) -> None:
        """Check escalation-log.md for redundant open entries."""
        esc_path = self.repo_root / "docs" / "bot-fleet" / "escalation-log.md"
        if not esc_path.exists():
            return

        content = esc_path.read_text(encoding="utf-8", errors="ignore")
        import re
        esc_ids = re.findall(r"ESC-\d+", content)
        seen: Dict[str, int] = {}
        for eid in esc_ids:
            seen[eid] = seen.get(eid, 0) + 1

        for eid, count in seen.items():
            if count > 4:   # ESC-IDs appear in headers + tables; >4 refs suggests duplication
                self.records.append(CompressionRecord(
                    record_id=self._make_id(),
                    action="MERGE_SUGGEST",
                    category="escalation",
                    description=f"{eid} appears {count} times in escalation-log — verify for duplication",
                    source="docs/bot-fleet/escalation-log.md",
                ))

    def _flag_stale_artifacts(self) -> None:
        """Flag JSON artifacts older than RETENTION_DAYS."""
        cutoff = time.time() - RETENTION_DAYS * 86400
        artifacts = [
            self.repo_root / "docs" / "bot-fleet" / "memoria-compress-report.json",
        ]
        for a in artifacts:
            if a.exists() and a.stat().st_mtime < cutoff:
                age_days = (time.time() - a.stat().st_mtime) / 86400
                self.records.append(CompressionRecord(
                    record_id=self._make_id(),
                    action="STALE_FLAG",
                    category="artifact",
                    description=f"{a.name} is {age_days:.0f} days old (threshold: {RETENTION_DAYS} days) — consider refresh",
                    source=str(a.relative_to(self.repo_root)),
                ))

    def run(self) -> Dict[str, Any]:
        self._compress_index()
        self._compress_escalations()
        self._flag_stale_artifacts()

        total_savings = sum(r.savings for r in self.records)
        return {
            "_meta": {
                "bot_name":  BOT_NAME,
                "bot_latin": BOT_LATIN,
                "bot_prot":  BOT_PROT,
                "built_at":  time.time(),
                "phi":       PHI,
                "law":       BOT_LAW,
                "policy":    "NEVER_DELETE — only archive/flag/suggest",
            },
            "summary": {
                "total_records":   len(self.records),
                "total_savings":   total_savings,
                "healthy":         total_savings == 0,
                "phi":             PHI,
            },
            "records": [r.to_dict() for r in self.records],
        }


def run_compressor(repo_root: str, output: Optional[str] = None) -> Dict[str, Any]:
    bot  = MemoriaCompressBot(repo_root=repo_root)
    data = bot.run()

    if output:
        out_path = Path(output)
        out_path.parent.mkdir(parents=True, exist_ok=True)
        out_path.write_text(json.dumps(data, indent=2, ensure_ascii=False), encoding="utf-8")
        print(f"[COMPRESSOR] Report written to {output}")

    s = data["summary"]
    print(f"[COMPRESSOR] {s['total_records']} records, {s['total_savings']} savings, healthy={s['healthy']}. φ = {PHI:.10f}")
    return data


def main() -> int:
    parser = argparse.ArgumentParser(description="COMPRESSOR — Memoria Compress Bot")
    parser.add_argument("--repo-root", required=True)
    parser.add_argument("--output",    default=None)
    args = parser.parse_args()

    try:
        run_compressor(repo_root=args.repo_root, output=args.output)
        return 0
    except Exception as exc:
        print(f"[COMPRESSOR] ERROR: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
