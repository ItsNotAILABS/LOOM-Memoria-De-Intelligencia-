"""
CUSTOS SECURITATIS — Security Domain Sovereign Being
PROT-161 | organism_key: "PRIMA CAUSA"
Creator: Alfredo "Freddy" Medina Hernandez — MEDINA Tech, Dallas TX

Sovereign being for the Security Alpha Orchestrator domain.
Handles threat assessment, risk computation, and gate actions.
Frequency: φ⁸ = 46.979 Hz (eighth power of golden ratio)
"""

import math
import hashlib
import time
from dataclasses import dataclass
from typing import Dict, Any, List

# ── φ constants ───────────────────────────────────────────────────────────────
PHI = 1.6180339887498948482
PHI_SQ = PHI ** 2
PHI_8 = PHI ** 8  # 46.979 Hz
INV_PHI = 1 / PHI
SCHUMANN = 7.83
FIBONACCI = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584]

# Gate action thresholds
GATE_THRESHOLD_TIGHTEN = 0.5
GATE_THRESHOLD_LOCKDOWN = 0.85


@dataclass
class ThreatAssessment:
    """Result of a security threat assessment."""
    assessment_id: str
    threat_level: float
    risk_score: float
    gate_action: str
    coherence: float
    timestamp: str


class CustosSecuritatis:
    """
    CUSTOS SECURITATIS — Sovereign being for security domain.
    
    PRIMA CAUSA stamp:
      organism_key: "PRIMA CAUSA"
      name_latin: "CUSTOS SECURITATIS"
      name_en: "Guardian of Security"
      frequency_hz: 46.979 (φ⁸)
      substrate_layer: 7
      language: CPL-L + ACL
      heart: METROPOLIS (0.1 Hz)
    """

    def __init__(self) -> None:
        self._beat = 0
        self._coherence = 0.80
        self._assessments: List[ThreatAssessment] = []
        self._current_gate_state = "steady"
        self._threat_history: List[float] = []

    @property
    def prima_causa(self) -> Dict[str, Any]:
        """PRIMA CAUSA geometry stamp."""
        return {
            "organism_key": "PRIMA CAUSA",
            "name_latin": "CUSTOS SECURITATIS",
            "name_en": "Guardian of Security",
            "phi_coordinate": FIBONACCI[15] * PHI_8,  # 610 × 46.979
            "fibonacci_index": 15,
            "frequency_hz": PHI_8,
            "substrate_layer": 7,
            "torus_theta": 5.235987,  # 5π/3
            "torus_phi": 3.141593,  # π
            "torus_depth": PHI_8 / 15,
            "ring": 2,
            "primitive_trace": "DISTINCTION → FIELD → RELATION → ADDRESS → φ⁸",
            "language": "CPL-L + ACL",
            "heart": "METROPOLIS (0.1 Hz)",
            "creator": "Alfredo Freddy Medina Hernandez",
            "protocol": "PROT-161",
        }

    def heartbeat(self) -> Dict[str, Any]:
        """Emit a heartbeat at φ⁸ Hz cadence."""
        self._beat += 1
        return {
            "being": "CUSTOS_SECURITATIS",
            "beat": self._beat,
            "frequency_hz": PHI_8,
            "coherence": self._coherence,
            "gate_state": self._current_gate_state,
            "assessments_count": len(self._assessments),
            "prot": "PROT-161",
            "organism_key": "PRIMA CAUSA",
        }

    def assess_threat(self, threat_level: float = 0.2) -> ThreatAssessment:
        """
        Perform security threat assessment.
        Computes risk score and determines gate action.
        """
        # Clamp threat level
        threat = max(0.0, min(1.0, threat_level))
        self._threat_history.append(threat)
        if len(self._threat_history) > 100:
            self._threat_history = self._threat_history[-100:]
        
        # Risk computation using inverse-φ scaling
        risk = min(1.0, threat * INV_PHI + self._coherence * 0.25)
        
        # Determine gate action
        if risk >= GATE_THRESHOLD_LOCKDOWN:
            gate_action = "lockdown"
        elif risk >= GATE_THRESHOLD_TIGHTEN:
            gate_action = "tighten"
        else:
            gate_action = "steady"
        
        self._current_gate_state = gate_action
        
        # Generate assessment ID
        raw_id = f"SA-{threat}-{time.time()}"
        assessment_id = hashlib.sha256(raw_id.encode()).hexdigest()[:12].upper()
        
        result = ThreatAssessment(
            assessment_id=f"SEC-{assessment_id}",
            threat_level=round(threat, 4),
            risk_score=round(risk, 6),
            gate_action=gate_action,
            coherence=round(self._coherence, 4),
            timestamp=time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        )
        
        self._assessments.append(result)
        return result

    def update_coherence(self, new_coherence: float) -> None:
        """Update internal coherence state (0.0–1.0)."""
        self._coherence = max(0.0, min(1.0, new_coherence))

    def get_coherence(self) -> float:
        """Return current coherence value."""
        return self._coherence

    def get_gate_state(self) -> str:
        """Return current gate state."""
        return self._current_gate_state

    def average_threat(self) -> float:
        """Return average threat level from history."""
        if not self._threat_history:
            return 0.0
        return sum(self._threat_history) / len(self._threat_history)

    def status(self) -> Dict[str, Any]:
        """Return full status report."""
        return {
            "being": "CUSTOS_SECURITATIS",
            "prima_causa": self.prima_causa,
            "beat": self._beat,
            "coherence": self._coherence,
            "gate_state": self._current_gate_state,
            "assessments_count": len(self._assessments),
            "average_threat": round(self.average_threat(), 4),
            "frequency_hz": PHI_8,
            "status": "ACTIVE",
        }


# ── Standalone test ───────────────────────────────────────────────────────────
if __name__ == "__main__":
    import json
    
    guardian = CustosSecuritatis()
    print("CUSTOS SECURITATIS — Security Domain Being")
    print("=" * 60)
    print(json.dumps(guardian.prima_causa, indent=2))
    print()
    
    # Run assessment
    result = guardian.assess_threat(threat_level=0.35)
    print("Threat Assessment:")
    print(f"  ID: {result.assessment_id}")
    print(f"  Threat Level: {result.threat_level}")
    print(f"  Risk Score: {result.risk_score}")
    print(f"  Gate Action: {result.gate_action}")
    print()
    
    # Heartbeat
    hb = guardian.heartbeat()
    print(f"Heartbeat #{hb['beat']} @ {hb['frequency_hz']:.3f} Hz")
