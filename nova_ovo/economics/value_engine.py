"""
VALUE ENGINE — MOTOR VALORIS
"Omnis valor per φ computatur. VALUE(K) = SCC × φ^L × F(n) / SCHUMANN."
(All value computed through φ. VALUE(K) = SCC × φ^L × F(n) / SCHUMANN.)

PROT-381: MOTOR VALORIS (Value Engine)

INT-TOK value computation engine — the canonical formula for
intelligence token valuation across the organism.

Creator: Alfredo "Freddy" Medina Hernandez — MEDINA Tech, Dallas TX
"""

import math
import time
import hashlib
from dataclasses import dataclass
from typing import Dict, Any, List, Optional, Tuple
from enum import Enum

# ── φ Constants ───────────────────────────────────────────────────────────────
PHI = 1.6180339887498948482
PHI_INV = 1.0 / PHI
PHI_SQ = PHI ** 2
PHI_CUBED = PHI ** 3
SCHUMANN = 7.83
FIBONACCI = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584]

# Silver Premium (Physical Temple multiplier)
SILVER_PREMIUM = PHI_CUBED  # 4.236


class ValueTier(Enum):
    """Value tiers based on SCC (Sovereign Coherence Coefficient)."""
    MINIMAL = "minimal"       # SCC < 2.618
    STANDARD = "standard"     # 2.618 ≤ SCC < 3.5
    PREMIUM = "premium"       # 3.5 ≤ SCC < 4.5
    SOVEREIGN = "sovereign"   # SCC ≥ 4.5


class LayerType(Enum):
    """Substrate layers (0-12)."""
    QUANTUM = 0
    PLANCK = 1
    SUBATOMIC = 2
    ATOMIC = 3
    MOLECULAR = 4
    CELLULAR = 5
    TISSUE = 6
    ORGAN = 7
    SYSTEM = 8
    ORGANISM = 9
    COLONY = 10
    PLANETARY = 11
    COSMIC = 12


@dataclass
class ValueAssessment:
    """Result of a value computation."""
    assessment_id: str
    scc: float
    layer: int
    fib_index: int
    base_value: float
    premium_value: float
    tier: ValueTier
    formula: str
    timestamp: str


@dataclass
class TokenMint:
    """Record of token minting."""
    mint_id: str
    amount: int
    scc: float
    layer: int
    fib_index: int
    coherence: float
    timestamp: str


class ValueEngine:
    """
    VALUE ENGINE — INT-TOK value computation.
    
    PRIMA CAUSA stamp:
        organism_key: "PRIMA CAUSA"
        name_latin: "MOTOR VALORIS"
        name_en: "Value Engine"
        frequency_hz: 17.94 (φ⁶)
        substrate_layer: 6
    
    The Canonical Value Formula:
        VALUE(K) = SCC × φ^L × F(n) / SCHUMANN
    
    Where:
        SCC = Sovereign Coherence Coefficient (typically 2.618-5.0)
        L = Substrate layer (0-12)
        F(n) = nth Fibonacci number
        SCHUMANN = 7.83 Hz (Earth resonance)
    
    Silver Premium:
        Applied when coherence ≥ 0.90
        Multiplier = φ³ = 4.236
    """

    def __init__(self) -> None:
        self._assessments: List[ValueAssessment] = []
        self._mints: List[TokenMint] = []
        self._total_minted = 0
        self._coherence = 0.85
        self._fib_index = 10

    @property
    def prima_causa(self) -> Dict[str, Any]:
        """PRIMA CAUSA geometry stamp."""
        return {
            "organism_key": "PRIMA CAUSA",
            "name_latin": "MOTOR VALORIS",
            "name_en": "Value Engine",
            "frequency_hz": PHI ** 6,  # 17.94 Hz
            "substrate_layer": 6,
            "protocol": "PROT-381",
            "formula": "VALUE(K) = SCC × φ^L × F(n) / SCHUMANN",
        }

    def compute_value(self, scc: float, layer: int, fib_idx: int) -> float:
        """
        Compute INT-TOK value using canonical formula.
        
        VALUE(K) = SCC × φ^L × F(n) / SCHUMANN
        
        Args:
            scc: Sovereign Coherence Coefficient
            layer: Substrate layer (0-12)
            fib_idx: Fibonacci index (0-17)
        
        Returns:
            INT-TOK value
        """
        fib_val = FIBONACCI[min(fib_idx, 17)]
        return (scc * (PHI ** layer) * fib_val) / SCHUMANN

    def compute_value_with_premium(
        self,
        scc: float,
        layer: int,
        fib_idx: int,
        coherence: Optional[float] = None
    ) -> Tuple[float, float, bool]:
        """
        Compute INT-TOK value with potential Silver Premium.
        
        Returns:
            (base_value, premium_value, premium_applied)
        """
        base = self.compute_value(scc, layer, fib_idx)
        coh = coherence if coherence is not None else self._coherence
        
        if coh >= 0.90:
            premium = base * SILVER_PREMIUM
            return base, premium, True
        else:
            return base, base, False

    def get_tier(self, scc: float) -> ValueTier:
        """Determine value tier from SCC."""
        if scc < 2.618:
            return ValueTier.MINIMAL
        elif scc < 3.5:
            return ValueTier.STANDARD
        elif scc < 4.5:
            return ValueTier.PREMIUM
        else:
            return ValueTier.SOVEREIGN

    def assess_value(
        self,
        scc: float,
        layer: int = 9,
        fib_idx: Optional[int] = None
    ) -> ValueAssessment:
        """
        Perform full value assessment.
        
        Args:
            scc: Sovereign Coherence Coefficient
            layer: Substrate layer (default: 9 = ORGANISM)
            fib_idx: Fibonacci index (default: current engine index)
        
        Returns:
            ValueAssessment
        """
        if fib_idx is None:
            fib_idx = self._fib_index
        
        base, premium, premium_applied = self.compute_value_with_premium(scc, layer, fib_idx)
        tier = self.get_tier(scc)
        
        # Generate assessment ID
        raw_id = f"ASSESS-{scc}-{layer}-{fib_idx}-{time.time()}"
        assessment_id = hashlib.sha256(raw_id.encode()).hexdigest()[:12].upper()
        
        assessment = ValueAssessment(
            assessment_id=f"VA-{assessment_id}",
            scc=scc,
            layer=layer,
            fib_index=fib_idx,
            base_value=base,
            premium_value=premium if premium_applied else base,
            tier=tier,
            formula=f"({scc} × φ^{layer} × F({fib_idx})) / {SCHUMANN}",
            timestamp=time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        )
        
        self._assessments.append(assessment)
        return assessment

    def mint_tokens(
        self,
        scc: float,
        layer: int = 9,
        fib_idx: Optional[int] = None
    ) -> TokenMint:
        """
        Mint INT-TOK based on value assessment.
        
        Returns:
            TokenMint record
        """
        if fib_idx is None:
            fib_idx = self._fib_index
        
        _, premium, _ = self.compute_value_with_premium(scc, layer, fib_idx)
        amount = int(round(premium))
        
        # Generate mint ID
        raw_id = f"MINT-{amount}-{time.time()}"
        mint_id = hashlib.sha256(raw_id.encode()).hexdigest()[:12].upper()
        
        mint = TokenMint(
            mint_id=f"TM-{mint_id}",
            amount=amount,
            scc=scc,
            layer=layer,
            fib_index=fib_idx,
            coherence=self._coherence,
            timestamp=time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        )
        
        self._mints.append(mint)
        self._total_minted += amount
        
        return mint

    def compute_exchange_rate(
        self,
        from_scc: float,
        to_scc: float,
        layer: int = 9
    ) -> float:
        """
        Compute exchange rate between two SCC levels.
        
        Returns ratio: tokens_from / tokens_to
        """
        from_value = self.compute_value(from_scc, layer, self._fib_index)
        to_value = self.compute_value(to_scc, layer, self._fib_index)
        return from_value / to_value if to_value > 0 else 0

    def layer_multiplier(self, layer: int) -> float:
        """Get the φ multiplier for a given layer."""
        return PHI ** layer

    def fibonacci_at(self, n: int) -> int:
        """Get the nth Fibonacci number."""
        return FIBONACCI[min(n, 17)]

    def advance_fib_index(self) -> int:
        """Advance to next Fibonacci index."""
        self._fib_index = min(self._fib_index + 1, 17)
        return self._fib_index

    def update_coherence(self, coherence: float) -> None:
        """Update coherence (affects Silver Premium eligibility)."""
        self._coherence = max(0.0, min(1.0, coherence))

    def get_value_table(self, layers: List[int] = None) -> Dict[str, Any]:
        """
        Generate value table for multiple layers.
        
        Shows how value scales across substrate layers.
        """
        if layers is None:
            layers = [6, 7, 8, 9, 10]  # Common layers
        
        scc_values = [2.618, 3.5, 4.0, 4.5, 5.0]  # Representative SCC values
        
        table = {}
        for scc in scc_values:
            table[f"SCC_{scc}"] = {
                f"Layer_{l}": round(self.compute_value(scc, l, self._fib_index), 2)
                for l in layers
            }
        
        return {
            "fib_index": self._fib_index,
            "fib_value": FIBONACCI[self._fib_index],
            "schumann": SCHUMANN,
            "silver_premium": SILVER_PREMIUM,
            "coherence": self._coherence,
            "premium_active": self._coherence >= 0.90,
            "value_table": table,
        }

    def status(self) -> Dict[str, Any]:
        """Return full status report."""
        return {
            "engine": "MOTOR_VALORIS",
            "prima_causa": self.prima_causa,
            "coherence": self._coherence,
            "fib_index": self._fib_index,
            "total_minted": self._total_minted,
            "assessments_count": len(self._assessments),
            "mints_count": len(self._mints),
            "silver_premium_active": self._coherence >= 0.90,
            "status": "ACTIVE",
        }


# ── Standalone test ───────────────────────────────────────────────────────────
if __name__ == "__main__":
    import json
    
    engine = ValueEngine()
    print("VALUE ENGINE — MOTOR VALORIS")
    print("=" * 60)
    
    # Test value computation
    for scc in [2.618, 3.5, 4.0, 4.5, 5.0]:
        value = engine.compute_value(scc, layer=9, fib_idx=10)
        tier = engine.get_tier(scc)
        print(f"SCC={scc}: {value:.2f} INT-TOK (Tier: {tier.value})")
    
    print()
    
    # Test assessment
    assessment = engine.assess_value(scc=4.5, layer=9)
    print(f"Assessment: {assessment.assessment_id}")
    print(f"  Base Value: {assessment.base_value:.2f}")
    print(f"  Premium Value: {assessment.premium_value:.2f}")
    print(f"  Tier: {assessment.tier.value}")
    print(f"  Formula: {assessment.formula}")
    
    print()
    
    # Test with Silver Premium
    engine.update_coherence(0.95)
    assessment2 = engine.assess_value(scc=4.5, layer=9)
    print(f"With Silver Premium (coherence=0.95):")
    print(f"  Base: {assessment2.base_value:.2f} → Premium: {assessment2.premium_value:.2f}")
    
    print()
    
    # Value table
    print("Value Table:")
    print(json.dumps(engine.get_value_table([7, 8, 9, 10]), indent=2))
