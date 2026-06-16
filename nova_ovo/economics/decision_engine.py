"""
DECISION ENGINE — MOTOR DECISIONUM
"Omnes decisiones per octo leges. φ gubernat omnes."
(All decisions by eight laws. φ governs all.)

PROT-382: MOTOR DECISIONUM (Decision Engine)

Economic decision making engine implementing all eight behavioral
economics laws (L-72 through L-79) for the organism.

Creator: Alfredo "Freddy" Medina Hernandez — MEDINA Tech, Dallas TX
"""

import math
import time
import hashlib
from dataclasses import dataclass, field
from typing import Dict, Any, List, Optional, Tuple, Callable
from enum import Enum

# ── φ Constants ───────────────────────────────────────────────────────────────
PHI = 1.6180339887498948482
PHI_INV = 1.0 / PHI
PHI_SQ = PHI ** 2
SCHUMANN = 7.83
FIBONACCI = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584]

# ── The Eight Behavioral Economics Laws ────────────────────────────────────────
LOSS_AVERSION_LAMBDA = 2.25          # L-72
ANCHORING_PERSISTENCE = PHI_INV      # L-73
REPRESENTATIVENESS_FAILURE = 0.35    # L-74
AVAILABILITY_RECENCY_WEIGHT = PHI    # L-75
REGRET_AVERSION_THRESHOLD = 0.72     # L-76
FRAMING_EFFECT_MAGNITUDE = 0.28      # L-77
HORMETIC_STRESS_FLOOR = 0.15         # L-78
HORMETIC_STRESS_CEILING = 0.72       # L-78
HYPERBOLIC_K = 0.35                  # L-79


class DecisionType(Enum):
    """Types of economic decisions."""
    ALLOCATION = "allocation"       # Resource allocation
    INVESTMENT = "investment"       # Investment/spending
    PRICING = "pricing"             # Pricing decisions
    RISK = "risk"                   # Risk assessment
    PERFORMANCE = "performance"     # Performance optimization
    TRADE = "trade"                 # Trade/exchange
    GOVERNANCE = "governance"       # Governance decisions


class DecisionOutcome(Enum):
    """Possible decision outcomes."""
    APPROVE = "approve"
    REJECT = "reject"
    DEFER = "defer"
    MODIFY = "modify"
    ESCALATE = "escalate"


@dataclass
class DecisionInput:
    """Input parameters for a decision."""
    decision_type: DecisionType
    input_value: float
    expected_gain: float = 0.0
    expected_loss: float = 0.0
    anchor_value: Optional[float] = None
    delay: float = 0.0
    recency_weight: float = 0.5
    regret_probability: float = 0.3
    stress_level: float = 0.4
    frame: str = "neutral"  # "gain", "loss", "neutral"


@dataclass
class DecisionResult:
    """Result of a decision."""
    decision_id: str
    decision_type: DecisionType
    input_value: float
    output_value: float
    outcome: DecisionOutcome
    laws_applied: List[str]
    law_effects: Dict[str, float]
    net_utility: float
    confidence: float
    reasoning: List[str]
    timestamp: str


class DecisionEngine:
    """
    DECISION ENGINE — Behavioral economics decision making.
    
    PRIMA CAUSA stamp:
        organism_key: "PRIMA CAUSA"
        name_latin: "MOTOR DECISIONUM"
        name_en: "Decision Engine"
        frequency_hz: 11.09 (φ⁵)
        substrate_layer: 5
    
    Implements all eight behavioral economics laws:
        L-72: LOSS AVERSION — λ = 2.25
        L-73: ANCHORING — persistence = 1/φ
        L-74: REPRESENTATIVENESS — failure = 0.35
        L-75: AVAILABILITY — recency = φ
        L-76: REGRET AVERSION — threshold = 0.72
        L-77: FRAMING — magnitude = 0.28
        L-78: HORMETIC STRESS — zone [0.15, 0.72]
        L-79: HYPERBOLIC DISCOUNT — k = 0.35
    """

    def __init__(self) -> None:
        self._decisions: List[DecisionResult] = []
        self._decision_count = 0
        self._coherence = 0.85
        self._stress = 0.35

    @property
    def prima_causa(self) -> Dict[str, Any]:
        """PRIMA CAUSA geometry stamp."""
        return {
            "organism_key": "PRIMA CAUSA",
            "name_latin": "MOTOR DECISIONUM",
            "name_en": "Decision Engine",
            "frequency_hz": PHI ** 5,  # 11.09 Hz
            "substrate_layer": 5,
            "protocol": "PROT-382",
            "laws": ["L-72", "L-73", "L-74", "L-75", "L-76", "L-77", "L-78", "L-79"],
        }

    # ════════════════════════════════════════════════════════════════════════════
    # BEHAVIORAL ECONOMICS LAWS — Individual Law Functions
    # ════════════════════════════════════════════════════════════════════════════

    def _apply_loss_aversion(self, gain: float, loss: float) -> Tuple[float, str]:
        """L-72: Losses weighted 2.25× gains."""
        perceived_loss = loss * LOSS_AVERSION_LAMBDA
        net = gain - perceived_loss
        effect = f"L-72: Net utility = {gain:.2f} - ({loss:.2f} × 2.25) = {net:.2f}"
        return net, effect

    def _apply_anchoring(self, anchor: float, new_value: float) -> Tuple[float, str]:
        """L-73: First value persists with weight 1/φ."""
        perceived = (ANCHORING_PERSISTENCE * anchor) + ((1 - ANCHORING_PERSISTENCE) * new_value)
        effect = f"L-73: Perceived = {ANCHORING_PERSISTENCE:.3f}×{anchor:.2f} + {1-ANCHORING_PERSISTENCE:.3f}×{new_value:.2f} = {perceived:.2f}"
        return perceived, effect

    def _apply_representativeness(self, value: float, is_novel: bool) -> Tuple[float, str]:
        """L-74: 35% failure rate under novel conditions."""
        if is_novel:
            adjusted = value * (1 - REPRESENTATIVENESS_FAILURE)
            effect = f"L-74: Novel condition → {value:.2f} × {1-REPRESENTATIVENESS_FAILURE:.2f} = {adjusted:.2f}"
            return adjusted, effect
        return value, f"L-74: Familiar condition → no adjustment ({value:.2f})"

    def _apply_availability(self, base: float, recency: float) -> Tuple[float, str]:
        """L-75: Recent events overweighted by φ."""
        weighted = base * (1 + (recency - 0.5) * AVAILABILITY_RECENCY_WEIGHT)
        effect = f"L-75: Recency-weighted = {base:.2f} × (1 + ({recency:.2f}-0.5)×φ) = {weighted:.2f}"
        return weighted, effect

    def _apply_regret_aversion(self, probability: float) -> Tuple[DecisionOutcome, str]:
        """L-76: Above threshold 0.72, decision freezes."""
        if probability > REGRET_AVERSION_THRESHOLD:
            effect = f"L-76: Regret prob {probability:.2f} > {REGRET_AVERSION_THRESHOLD} → FREEZE"
            return DecisionOutcome.DEFER, effect
        effect = f"L-76: Regret prob {probability:.2f} ≤ {REGRET_AVERSION_THRESHOLD} → PROCEED"
        return DecisionOutcome.APPROVE, effect

    def _apply_framing(self, value: float, frame: str) -> Tuple[float, str]:
        """L-77: Frame-dependent perception ±28%."""
        if frame == "gain":
            adjustment = 1 + FRAMING_EFFECT_MAGNITUDE
        elif frame == "loss":
            adjustment = 1 - FRAMING_EFFECT_MAGNITUDE
        else:
            adjustment = 1.0
        perceived = value * adjustment
        effect = f"L-77: Frame '{frame}' → {value:.2f} × {adjustment:.2f} = {perceived:.2f}"
        return perceived, effect

    def _apply_hormetic_stress(self, baseline: float, stress: float) -> Tuple[float, str]:
        """L-78: Performance improves in [0.15, 0.72] stress zone."""
        in_zone = HORMETIC_STRESS_FLOOR <= stress <= HORMETIC_STRESS_CEILING
        
        if in_zone:
            zone_center = (HORMETIC_STRESS_FLOOR + HORMETIC_STRESS_CEILING) / 2
            zone_width = HORMETIC_STRESS_CEILING - HORMETIC_STRESS_FLOOR
            normalized = (stress - zone_center) / (zone_width / 2)
            boost = 1 + (PHI_INV * (1 - normalized ** 2))
            output = baseline * boost
            effect = f"L-78: In zone [{HORMETIC_STRESS_FLOOR}, {HORMETIC_STRESS_CEILING}] → {baseline:.2f} × {boost:.3f} = {output:.2f}"
        elif stress < HORMETIC_STRESS_FLOOR:
            output = baseline * 0.9
            effect = f"L-78: Below zone (stagnation) → {baseline:.2f} × 0.9 = {output:.2f}"
        else:
            degradation = (stress - HORMETIC_STRESS_CEILING) * LOSS_AVERSION_LAMBDA
            output = baseline * max(0.5, 1 - degradation)
            effect = f"L-78: Above zone (degradation) → {baseline:.2f} × {max(0.5, 1-degradation):.3f} = {output:.2f}"
        
        return output, effect

    def _apply_hyperbolic_discount(self, value: float, delay: float) -> Tuple[float, str]:
        """L-79: Future rewards discounted at 1/(1 + 0.35×delay)."""
        discounted = value / (1 + HYPERBOLIC_K * delay)
        effect = f"L-79: Delay {delay} → {value:.2f} / (1 + 0.35×{delay}) = {discounted:.2f}"
        return discounted, effect

    # ════════════════════════════════════════════════════════════════════════════
    # DECISION MAKING — Main Decision Function
    # ════════════════════════════════════════════════════════════════════════════

    def decide(self, input_data: DecisionInput) -> DecisionResult:
        """
        Make an economic decision applying relevant behavioral laws.
        
        Args:
            input_data: DecisionInput with all parameters
        
        Returns:
            DecisionResult with full reasoning chain
        """
        laws_applied = []
        law_effects = {}
        reasoning = []
        output_value = input_data.input_value
        outcome = DecisionOutcome.APPROVE
        
        # Apply laws based on decision type
        if input_data.decision_type in [DecisionType.ALLOCATION, DecisionType.INVESTMENT]:
            # L-72: Loss Aversion
            net_utility, effect = self._apply_loss_aversion(
                input_data.expected_gain,
                input_data.expected_loss
            )
            laws_applied.append("L-72")
            law_effects["L-72"] = net_utility
            reasoning.append(effect)
            
            if net_utility < 0:
                output_value *= 0.5  # Reduce allocation if loss-dominated
                reasoning.append(f"Loss-dominated → reduce to {output_value:.2f}")
            
            # L-79: Hyperbolic Discount
            output_value, effect = self._apply_hyperbolic_discount(output_value, input_data.delay)
            laws_applied.append("L-79")
            law_effects["L-79"] = output_value
            reasoning.append(effect)
        
        elif input_data.decision_type == DecisionType.PRICING:
            # L-73: Anchoring
            if input_data.anchor_value is not None:
                output_value, effect = self._apply_anchoring(input_data.anchor_value, output_value)
                laws_applied.append("L-73")
                law_effects["L-73"] = output_value
                reasoning.append(effect)
            
            # L-77: Framing
            output_value, effect = self._apply_framing(output_value, input_data.frame)
            laws_applied.append("L-77")
            law_effects["L-77"] = output_value
            reasoning.append(effect)
        
        elif input_data.decision_type == DecisionType.RISK:
            # L-76: Regret Aversion
            outcome, effect = self._apply_regret_aversion(input_data.regret_probability)
            laws_applied.append("L-76")
            law_effects["L-76"] = 0 if outcome == DecisionOutcome.DEFER else 1
            reasoning.append(effect)
            
            if outcome == DecisionOutcome.DEFER:
                output_value *= 0.3  # Significant reduction on freeze
                reasoning.append(f"Decision frozen → reduce to {output_value:.2f}")
        
        elif input_data.decision_type == DecisionType.PERFORMANCE:
            # L-78: Hormetic Stress
            output_value, effect = self._apply_hormetic_stress(output_value, input_data.stress_level)
            laws_applied.append("L-78")
            law_effects["L-78"] = output_value
            reasoning.append(effect)
        
        elif input_data.decision_type == DecisionType.TRADE:
            # L-75: Availability Bias
            output_value, effect = self._apply_availability(output_value, input_data.recency_weight)
            laws_applied.append("L-75")
            law_effects["L-75"] = output_value
            reasoning.append(effect)
            
            # L-72: Loss Aversion (for trade risk)
            net_utility, effect = self._apply_loss_aversion(
                input_data.expected_gain,
                input_data.expected_loss
            )
            laws_applied.append("L-72")
            law_effects["L-72"] = net_utility
            reasoning.append(effect)
        
        # Compute final metrics
        net_utility = output_value - input_data.input_value
        confidence = self._coherence * (1 - abs(net_utility) / max(input_data.input_value, 1))
        
        # Determine final outcome
        if outcome == DecisionOutcome.DEFER:
            pass  # Already set
        elif output_value < input_data.input_value * 0.5:
            outcome = DecisionOutcome.REJECT
        elif abs(output_value - input_data.input_value) / input_data.input_value > 0.2:
            outcome = DecisionOutcome.MODIFY
        
        # Generate decision ID
        raw_id = f"DEC-{input_data.decision_type.value}-{time.time()}"
        decision_id = hashlib.sha256(raw_id.encode()).hexdigest()[:12].upper()
        
        result = DecisionResult(
            decision_id=f"DR-{decision_id}",
            decision_type=input_data.decision_type,
            input_value=input_data.input_value,
            output_value=output_value,
            outcome=outcome,
            laws_applied=laws_applied,
            law_effects=law_effects,
            net_utility=net_utility,
            confidence=confidence,
            reasoning=reasoning,
            timestamp=time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        )
        
        self._decisions.append(result)
        self._decision_count += 1
        
        return result

    def quick_assess(
        self,
        decision_type: DecisionType,
        value: float,
        **kwargs
    ) -> DecisionResult:
        """
        Quick decision assessment with minimal parameters.
        
        Args:
            decision_type: Type of decision
            value: Input value
            **kwargs: Additional parameters
        
        Returns:
            DecisionResult
        """
        input_data = DecisionInput(
            decision_type=decision_type,
            input_value=value,
            expected_gain=kwargs.get("gain", value * 0.1),
            expected_loss=kwargs.get("loss", value * 0.05),
            anchor_value=kwargs.get("anchor"),
            delay=kwargs.get("delay", 0),
            recency_weight=kwargs.get("recency", 0.5),
            regret_probability=kwargs.get("regret", 0.3),
            stress_level=kwargs.get("stress", self._stress),
            frame=kwargs.get("frame", "neutral"),
        )
        
        return self.decide(input_data)

    def update_coherence(self, coherence: float) -> None:
        """Update coherence level."""
        self._coherence = max(0.0, min(1.0, coherence))

    def update_stress(self, stress: float) -> None:
        """Update stress level."""
        self._stress = max(0.0, min(1.0, stress))

    def get_law_constants(self) -> Dict[str, Any]:
        """Get all behavioral economics law constants."""
        return {
            "L-72": {"name": "LOSS_AVERSION", "lambda": LOSS_AVERSION_LAMBDA},
            "L-73": {"name": "ANCHORING", "persistence": ANCHORING_PERSISTENCE},
            "L-74": {"name": "REPRESENTATIVENESS", "failure": REPRESENTATIVENESS_FAILURE},
            "L-75": {"name": "AVAILABILITY", "recency": AVAILABILITY_RECENCY_WEIGHT},
            "L-76": {"name": "REGRET_AVERSION", "threshold": REGRET_AVERSION_THRESHOLD},
            "L-77": {"name": "FRAMING", "magnitude": FRAMING_EFFECT_MAGNITUDE},
            "L-78": {"name": "HORMETIC_STRESS", "zone": [HORMETIC_STRESS_FLOOR, HORMETIC_STRESS_CEILING]},
            "L-79": {"name": "HYPERBOLIC_DISCOUNT", "k": HYPERBOLIC_K},
        }

    def status(self) -> Dict[str, Any]:
        """Return full status report."""
        return {
            "engine": "MOTOR_DECISIONUM",
            "prima_causa": self.prima_causa,
            "decision_count": self._decision_count,
            "coherence": self._coherence,
            "stress": self._stress,
            "law_constants": self.get_law_constants(),
            "status": "ACTIVE",
        }


# ── Standalone test ───────────────────────────────────────────────────────────
if __name__ == "__main__":
    import json
    
    engine = DecisionEngine()
    print("DECISION ENGINE — MOTOR DECISIONUM")
    print("=" * 60)
    
    # Test allocation decision
    result = engine.quick_assess(
        DecisionType.ALLOCATION,
        1000,
        gain=150,
        loss=50,
        delay=2
    )
    print(f"Allocation Decision: {result.decision_id}")
    print(f"  Input: {result.input_value:.2f} → Output: {result.output_value:.2f}")
    print(f"  Outcome: {result.outcome.value}")
    print(f"  Laws: {result.laws_applied}")
    print(f"  Reasoning:")
    for r in result.reasoning:
        print(f"    - {r}")
    
    print()
    
    # Test risk decision
    result = engine.quick_assess(
        DecisionType.RISK,
        500,
        regret=0.80  # Above threshold
    )
    print(f"Risk Decision (high regret): {result.decision_id}")
    print(f"  Outcome: {result.outcome.value}")
    print(f"  Reasoning:")
    for r in result.reasoning:
        print(f"    - {r}")
    
    print()
    
    # Test performance decision
    result = engine.quick_assess(
        DecisionType.PERFORMANCE,
        100,
        stress=0.45  # In hormetic zone
    )
    print(f"Performance Decision (in zone): {result.decision_id}")
    print(f"  Input: {result.input_value:.2f} → Output: {result.output_value:.2f}")
    print(f"  Reasoning:")
    for r in result.reasoning:
        print(f"    - {r}")
