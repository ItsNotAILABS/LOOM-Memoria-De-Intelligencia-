"""
Profile-Aware Alpha Orchestrators + Native Validation Flows.

Implements:
- Atlas profile hooks for backend orchestrators
- Five native orchestrators (vision/security/billing/internal-build/governance)
- Tokenized validation artifacts for pack runs
"""

from __future__ import annotations

import hashlib
import json
import time
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, List

from ..core.recital import PHI
from .base import BeatResult, Orchestrator
from .heartbeat import HeartbeatEngine

PHI_SQ = PHI**2
INV_PHI = 1 / PHI
SCHUMANN = 7.83

ROOT = Path(__file__).resolve().parents[2]
ATLAS_RUNTIME = ROOT / "atlas" / "registry" / "runtime"
PACK_PROFILES_PATH = ATLAS_RUNTIME / "pack-profiles.json"
VALIDATION_ARTIFACT_DIR = ATLAS_RUNTIME / "validation-artifacts"
TOKEN_LEDGER_PATH = ATLAS_RUNTIME / "validation-token-ledger.json"


def fibonacci(n: int) -> int:
    """Compute Fibonacci number F(n) with iterative flow."""
    if n <= 0:
        return 0
    if n == 1:
        return 1
    a, b = 0, 1
    for _ in range(2, n + 1):
        a, b = b, a + b
    return b


def load_pack_profile(profile: str) -> Dict[str, Any]:
    data = json.loads(PACK_PROFILES_PATH.read_text(encoding="utf-8"))
    profiles = data.get("profiles", {})
    selected = profiles.get(profile) or profiles.get("full") or {}
    return {
        "profile": profile if profile in profiles else "full",
        "registry_first": data.get("registry_first", True),
        "math_surface": data.get("math_surface", {}),
        "foundational_workers": data.get("foundational_workers", []),
        "worker_catalog": data.get("worker_catalog", []),
        "selected": selected,
    }


@dataclass
class ValidationToken:
    token_id: str
    flow: str
    profile: str
    minted_at: str
    amount: int
    evidence_hash: str

    def to_dict(self) -> Dict[str, Any]:
        return {
            "token_id": self.token_id,
            "flow": self.flow,
            "profile": self.profile,
            "minted_at": self.minted_at,
            "amount": self.amount,
            "evidence_hash": self.evidence_hash,
        }


class ProfileAwareAlphaOrchestrator(Orchestrator):
    """Base orchestrator bound to Atlas runtime profile state."""

    def __init__(self, orch_type: str, domain: str, profile: str = "ops") -> None:
        super().__init__(orch_type=orch_type)
        self.domain = domain
        self.profile_ctx = load_pack_profile(profile)
        self.heartbeat = HeartbeatEngine()
        self.last_domain_metric: float = 0.0

    @property
    def profile(self) -> str:
        return self.profile_ctx["profile"]

    def _fib_seed(self) -> int:
        base = len(self.profile_ctx.get("worker_catalog", [])) + len(self.domain)
        return fibonacci(max(3, min(base, 22)))

    def _core_math_metric(self) -> Dict[str, float]:
        hb = self.heartbeat.tick(doctrine_coherence=1.0)
        fib = self._fib_seed()
        coherence = self.heartbeat.get_coherence()
        score = (fib * INV_PHI) * (hb.resonance + coherence) / (PHI_SQ)
        self.last_domain_metric = score
        return {
            "fib_seed": float(fib),
            "resonance": hb.resonance,
            "coherence": coherence,
            "phi_score": score,
            "schumann": SCHUMANN,
        }


class VisionAlphaOrchestrator(ProfileAwareAlphaOrchestrator):
    def __init__(self, profile: str = "ops") -> None:
        super().__init__("NEURAL_CORE_MESH", "vision", profile)

    def process_input(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        m = self._core_math_metric()
        return {
            "domain": "vision",
            "profile": self.profile,
            "edge_analysis_score": round(m["phi_score"], 6),
            "event": input_data.get("event", "frame-analysis"),
            "registry_first": self.profile_ctx.get("registry_first", True),
        }


class SecurityAlphaOrchestrator(ProfileAwareAlphaOrchestrator):
    def __init__(self, profile: str = "ops") -> None:
        super().__init__("CONSTITUTIONAL_LAW", "security", profile)

    def process_input(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        m = self._core_math_metric()
        threat = float(input_data.get("threat", 0.2))
        risk = min(1.0, threat * INV_PHI + m["coherence"] * 0.25)
        return {
            "domain": "security",
            "profile": self.profile,
            "risk": round(risk, 6),
            "gate_action": "tighten" if risk > 0.5 else "steady",
            "registry_first": self.profile_ctx.get("registry_first", True),
        }


class BillingAlphaOrchestrator(ProfileAwareAlphaOrchestrator):
    def __init__(self, profile: str = "ops") -> None:
        super().__init__("FULL_GOVERNANCE", "billing", profile)

    def process_input(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        m = self._core_math_metric()
        base_units = int(input_data.get("units", 8))
        token_quote = int(max(1, round(base_units * PHI + m["fib_seed"] * 0.05)))
        return {
            "domain": "billing",
            "profile": self.profile,
            "token_quote": token_quote,
            "rate_model": "phi-fibonacci",
        }


class InternalBuildAlphaOrchestrator(ProfileAwareAlphaOrchestrator):
    def __init__(self, profile: str = "ops") -> None:
        super().__init__("SWARM_CORE", "internal-build", profile)

    def process_input(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        m = self._core_math_metric()
        queue = int(input_data.get("queue", 3))
        build_velocity = round((queue + m["fib_seed"] * 0.01) * INV_PHI, 6)
        return {
            "domain": "internal-build",
            "profile": self.profile,
            "build_velocity": build_velocity,
            "orchestration": "multi-engine",
        }


class GovernanceAlphaOrchestrator(ProfileAwareAlphaOrchestrator):
    def __init__(self, profile: str = "ops") -> None:
        super().__init__("LIVING_DOCUMENT_MACRO", "governance", profile)

    def process_input(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        m = self._core_math_metric()
        continuity = min(1.0, max(0.0, 0.5 + m["coherence"] * 0.5))
        return {
            "domain": "governance",
            "profile": self.profile,
            "continuity_attestation": round(continuity, 6),
            "doctrine": "held" if continuity >= 0.5 else "degraded",
        }


def build_alpha_orchestrators(profile: str = "ops") -> List[ProfileAwareAlphaOrchestrator]:
    return [
        VisionAlphaOrchestrator(profile=profile),
        SecurityAlphaOrchestrator(profile=profile),
        BillingAlphaOrchestrator(profile=profile),
        InternalBuildAlphaOrchestrator(profile=profile),
        GovernanceAlphaOrchestrator(profile=profile),
    ]


def _mint_token(flow: str, profile: str, payload: Dict[str, Any]) -> ValidationToken:
    payload_bytes = json.dumps(payload, sort_keys=True).encode("utf-8")
    evidence_hash = hashlib.sha256(payload_bytes).hexdigest()
    now = datetime.now(timezone.utc).isoformat()
    token_id = f"valtok-{flow}-{int(time.time() * 1000)}"
    amount = max(1, int(len(payload_bytes) * INV_PHI / 100))
    return ValidationToken(
        token_id=token_id,
        flow=flow,
        profile=profile,
        minted_at=now,
        amount=amount,
        evidence_hash=evidence_hash,
    )


def run_native_validation_bundle(profile: str = "ops") -> Dict[str, Any]:
    orchestrators = build_alpha_orchestrators(profile=profile)
    for orch in orchestrators:
        orch.start()

    results: Dict[str, Dict[str, Any]] = {}
    minted: List[ValidationToken] = []

    for orch in orchestrators:
        beat: BeatResult = orch.tick()
        payload = orch.process_input({"event": "native-validation"})
        payload["beat"] = beat.to_dict()
        results[orch.domain] = payload
        minted.append(_mint_token(flow=orch.domain, profile=profile, payload=payload))

    VALIDATION_ARTIFACT_DIR.mkdir(parents=True, exist_ok=True)
    artifact = {
        "artifact_id": f"native-validation-{datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ')}",
        "created_at": datetime.now(timezone.utc).isoformat(),
        "profile": profile,
        "math_surface": {
            "phi": PHI,
            "phi_sq": PHI_SQ,
            "inv_phi": INV_PHI,
            "schumann": SCHUMANN,
            "fibonacci_window": [fibonacci(i) for i in range(3, 11)],
        },
        "results": results,
        "tokens": [t.to_dict() for t in minted],
    }

    artifact_path = VALIDATION_ARTIFACT_DIR / f"{artifact['artifact_id']}.json"
    artifact_path.write_text(json.dumps(artifact, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    (VALIDATION_ARTIFACT_DIR / "latest.json").write_text(
        json.dumps(artifact, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
    )

    if TOKEN_LEDGER_PATH.exists():
        ledger = json.loads(TOKEN_LEDGER_PATH.read_text(encoding="utf-8"))
    else:
        ledger = {"id": "atlas://registry/runtime/validation-token-ledger", "tokens": []}

    ledger.setdefault("tokens", []).extend([t.to_dict() for t in minted])
    ledger["updated_at"] = datetime.now(timezone.utc).isoformat()
    TOKEN_LEDGER_PATH.write_text(json.dumps(ledger, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

    return {
        "ok": True,
        "artifact_path": str(artifact_path.relative_to(ROOT)),
        "token_count": len(minted),
        "total_tokens": sum(t.amount for t in minted),
    }
