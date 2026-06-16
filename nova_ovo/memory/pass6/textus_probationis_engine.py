"""
MACHINA TEXTUS PROBATIONIS — Proof-Weave Integrity Engine
PROT-155 + PROT-156 | PRIMA CAUSA | L-130 compliant
"""

import hashlib
import json
from typing import Dict, Any


class TextusProbationisEngine:
    """Produces and verifies memory provenance receipts."""

    PROTOCOLS = ("PROT-155", "PROT-156")
    LATIN_NAME = "MACHINA TEXTUS PROBATIONIS"
    ORGANISM_KEY = "PRIMA CAUSA"
    L130 = "Before recomposition, trace to primitive."

    @staticmethod
    def receipt(payload: Dict[str, Any]) -> str:
        blob = json.dumps(payload, sort_keys=True, ensure_ascii=True)
        return hashlib.sha256(blob.encode("utf-8")).hexdigest()

    @staticmethod
    def verify(payload: Dict[str, Any], receipt_hash: str) -> bool:
        return TextusProbationisEngine.receipt(payload) == receipt_hash

    @staticmethod
    def drift_score(expected_hash: str, observed_hash: str) -> float:
        """Hash-distance score in [0,1], where 1 means exact match."""
        if not expected_hash or not observed_hash or len(expected_hash) != len(observed_hash):
            return 0.0
        diff = sum(1 for a, b in zip(expected_hash, observed_hash) if a != b)
        return round(1.0 - (diff / len(expected_hash)), 6)

    @staticmethod
    def provenance_packet(
        payload: Dict[str, Any],
        source_face: str,
        target_face: str,
        beat: int,
        ring: int,
    ) -> Dict[str, Any]:
        receipt_hash = TextusProbationisEngine.receipt(payload)
        return {
            "receipt_hash": receipt_hash,
            "protocols": TextusProbationisEngine.PROTOCOLS,
            "source_face": source_face,
            "target_face": target_face,
            "beat": beat,
            "ring": ring,
            "organism_key": TextusProbationisEngine.ORGANISM_KEY,
            "l130": TextusProbationisEngine.L130,
        }
