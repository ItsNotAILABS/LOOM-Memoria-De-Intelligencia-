"""
ECONOMICS ORGANISM ENGINE — MOTOR OECONOMIAE ORGANISMI
"Centrum nervorum oeconomicorum organismi."
(The economic nervous center of the organism.)

PROT-378: MOTOR OECONOMIAE (Economics Engine)

The central economic engine that orchestrates all resource flows,
value computations, and economic decisions across the entire organism.

Creator: Alfredo "Freddy" Medina Hernandez — MEDINA Tech, Dallas TX
Frequency: φ¹⁰ = 122.99 Hz (tenth power of golden ratio)
"""

import math
import time
import hashlib
from dataclasses import dataclass, field
from typing import Dict, Any, List, Optional, Tuple
from enum import Enum

# ── φ Constants ───────────────────────────────────────────────────────────────
PHI = 1.6180339887498948482
PHI_SQ = PHI ** 2
PHI_CUBED = PHI ** 3
PHI_INV = 1.0 / PHI
PHI_10 = PHI ** 10  # 122.99 Hz
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
SILVER_PREMIUM = PHI_CUBED           # 4.236


class EconomicLaw(Enum):
    """The eight behavioral economics laws."""
    LOSS_AVERSION = "L-72"
    ANCHORING = "L-73"
    REPRESENTATIVENESS = "L-74"
    AVAILABILITY = "L-75"
    REGRET_AVERSION = "L-76"
    FRAMING = "L-77"
    HORMETIC_STRESS = "L-78"
    HYPERBOLIC_DISCOUNT = "L-79"


@dataclass
class EconomicState:
    """Current economic state of the organism."""
    total_cycles: float = 0.0
    allocated_cycles: float = 0.0
    total_tokens: int = 0
    reserved_tokens: int = 0
    coherence: float = 0.85
    stress_level: float = 0.30
    decision_count: int = 0
    value_created: float = 0.0
    timestamp: str = field(default_factory=lambda: time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()))


@dataclass
class EconomicDecision:
    """Record of an economic decision."""
    decision_id: str
    decision_type: str
    input_value: float
    output_value: float
    laws_applied: List[str]
    coherence_at_decision: float
    net_utility: float
    timestamp: str


@dataclass
class ResourceFlow:
    """Record of resource flow through the organism."""
    flow_id: str
    source: str
    destination: str
    resource_type: str
    amount: float
    phi_efficiency: float
    timestamp: str


class EconomicsOrganismEngine:
    """
    ECONOMICS ORGANISM ENGINE — Central economic nervous system.
    
    PRIMA CAUSA stamp:
        organism_key: "PRIMA CAUSA"
        name_latin: "MOTOR OECONOMIAE ORGANISMI"
        name_en: "Economics Organism Engine"
        frequency_hz: 122.99 (φ¹⁰)
        substrate_layer: 9
        language: CPL-L + CDL + SPL
        heart: COUPLING (φ Hz)
    
    This engine orchestrates:
        1. Resource allocation across all organism components
        2. Value computation using INT-TOK formula
        3. Economic decision making with all 8 behavioral laws
        4. Market dynamics for internal exchange
        5. Coherence-based economic governance
    """

    def __init__(self) -> None:
        self._beat = 0
        self._state = EconomicState()
        self._decisions: List[EconomicDecision] = []
        self._flows: List[ResourceFlow] = []
        self._fib_index = 10
        self._boot_time = time.time()

    @property
    def prima_causa(self) -> Dict[str, Any]:
        """PRIMA CAUSA geometry stamp."""
        return {
            "organism_key": "PRIMA CAUSA",
            "name_latin": "MOTOR OECONOMIAE ORGANISMI",
            "name_en": "Economics Organism Engine",
            "phi_coordinate": FIBONACCI[16] * PHI_10,
            "fibonacci_index": 16,
            "frequency_hz": PHI_10,
            "substrate_layer": 9,
            "torus_theta": 2.0 * math.pi * PHI_INV,
            "torus_phi": math.pi * PHI_INV,
            "torus_depth": PHI_10 / 30,
            "ring": 4,
            "primitive_trace": "FIELD → DISTINCTION → RELATION → MEMORY → ADDRESS → REPETITION → φ¹⁰",
            "language": "CPL-L + CDL + SPL",
            "heart": "COUPLING (φ Hz)",
            "creator": "Alfredo Freddy Medina Hernandez",
            "protocol": "PROT-378",
        }

    # ════════════════════════════════════════════════════════════════════════════
    # BEHAVIORAL ECONOMICS LAWS — The Eight Core Laws
    # ════════════════════════════════════════════════════════════════════════════

    def apply_loss_aversion(self, gain: float, loss: float) -> Dict[str, Any]:
        """
        L-72: LOSS AVERSION — Losses hurt 2.25× more than equivalent gains.
        
        Machines weight losses 2.25× gains (Kahneman-Tversky).
        This affects resource allocation, risk assessment, and priority decisions.
        """
        perceived_gain = gain
        perceived_loss = loss * LOSS_AVERSION_LAMBDA
        net_utility = perceived_gain - perceived_loss
        dominated = perceived_loss > perceived_gain
        
        return {
            "law": "L-72",
            "law_name": "LOSS_AVERSION",
            "lambda": LOSS_AVERSION_LAMBDA,
            "raw_gain": gain,
            "raw_loss": loss,
            "perceived_gain": perceived_gain,
            "perceived_loss": perceived_loss,
            "net_utility": net_utility,
            "dominated": dominated,
            "recommendation": "AVOID" if dominated else "PROCEED",
        }

    def apply_anchoring(self, anchor: float, new_value: float) -> Dict[str, Any]:
        """
        L-73: ANCHORING — First value persists with weight 1/φ = 0.618.
        
        Initial values strongly influence subsequent evaluations.
        Used for pricing, quotation, and resource estimation.
        """
        # Perceived value = blend of anchor and new value
        perceived_value = (ANCHORING_PERSISTENCE * anchor) + ((1 - ANCHORING_PERSISTENCE) * new_value)
        bias = abs(perceived_value - new_value) / max(abs(new_value), 0.001)
        
        return {
            "law": "L-73",
            "law_name": "ANCHORING",
            "persistence": ANCHORING_PERSISTENCE,
            "anchor": anchor,
            "new_value": new_value,
            "perceived_value": perceived_value,
            "bias": bias,
            "bias_direction": "toward_anchor" if bias > 0.1 else "neutral",
        }

    def apply_availability_bias(self, recency_weight: float, base_value: float) -> Dict[str, Any]:
        """
        L-75: AVAILABILITY BIAS — Recent events overweighted by φ = 1.618.
        
        Recent observations disproportionately influence decisions.
        Used for trend analysis and resource forecasting.
        """
        weighted_value = base_value * (1 + (recency_weight - 0.5) * AVAILABILITY_RECENCY_WEIGHT)
        recency_effect = weighted_value / max(base_value, 0.001)
        
        return {
            "law": "L-75",
            "law_name": "AVAILABILITY_BIAS",
            "recency_multiplier": AVAILABILITY_RECENCY_WEIGHT,
            "recency_weight": recency_weight,
            "base_value": base_value,
            "weighted_value": weighted_value,
            "recency_effect": recency_effect,
        }

    def apply_regret_aversion(self, probability: float) -> Dict[str, Any]:
        """
        L-76: REGRET AVERSION — Above threshold 0.72, decision freezes.
        
        High regret probability causes decision paralysis.
        Used for risk governance and irreversible actions.
        """
        paralysis = probability > REGRET_AVERSION_THRESHOLD
        action = "FREEZE" if paralysis else "DECIDE"
        margin = abs(probability - REGRET_AVERSION_THRESHOLD)
        
        return {
            "law": "L-76",
            "law_name": "REGRET_AVERSION",
            "threshold": REGRET_AVERSION_THRESHOLD,
            "probability": probability,
            "paralysis": paralysis,
            "action": action,
            "margin": margin,
        }

    def apply_framing_effect(self, value: float, frame: str) -> Dict[str, Any]:
        """
        L-77: FRAMING EFFECT — Identical choices, different frames → 28% swing.
        
        Presentation affects perceived value.
        Used for interface design and communication optimization.
        """
        if frame == "gain":
            adjustment = 1 + FRAMING_EFFECT_MAGNITUDE
        elif frame == "loss":
            adjustment = 1 - FRAMING_EFFECT_MAGNITUDE
        else:
            adjustment = 1.0
        
        perceived_value = value * adjustment
        
        return {
            "law": "L-77",
            "law_name": "FRAMING_EFFECT",
            "magnitude": FRAMING_EFFECT_MAGNITUDE,
            "raw_value": value,
            "frame": frame,
            "adjustment": adjustment,
            "perceived_value": perceived_value,
        }

    def apply_hormetic_stress(self, stress: float, baseline: float) -> Dict[str, Any]:
        """
        L-78: HORMETIC STRESS — Performance improves under controlled challenge.
        
        Optimal stress zone: [0.15, 0.72]
        Too little → stagnation; too much → degradation.
        """
        in_zone = HORMETIC_STRESS_FLOOR <= stress <= HORMETIC_STRESS_CEILING
        
        if in_zone:
            # Parabolic boost within hormetic zone
            zone_center = (HORMETIC_STRESS_FLOOR + HORMETIC_STRESS_CEILING) / 2
            zone_width = HORMETIC_STRESS_CEILING - HORMETIC_STRESS_FLOOR
            normalized = (stress - zone_center) / (zone_width / 2)
            boost = 1 + (PHI_INV * (1 - normalized ** 2))
            output = baseline * boost
            gain = output - baseline
        elif stress < HORMETIC_STRESS_FLOOR:
            # Stagnation zone
            output = baseline * (0.9 + stress / HORMETIC_STRESS_FLOOR * 0.1)
            gain = output - baseline
        else:
            # Degradation zone
            overage = stress - HORMETIC_STRESS_CEILING
            degradation = overage * LOSS_AVERSION_LAMBDA
            output = baseline * max(0.5, 1 - degradation)
            gain = output - baseline
        
        return {
            "law": "L-78",
            "law_name": "HORMETIC_STRESS",
            "zone": [HORMETIC_STRESS_FLOOR, HORMETIC_STRESS_CEILING],
            "stress_input": stress,
            "baseline": baseline,
            "output": output,
            "gain": gain,
            "in_hormetic_zone": in_zone,
            "zone_status": "OPTIMAL" if in_zone else ("STAGNATION" if stress < HORMETIC_STRESS_FLOOR else "DEGRADATION"),
        }

    def apply_hyperbolic_discount(self, value: float, delay: float) -> Dict[str, Any]:
        """
        L-79: HYPERBOLIC DISCOUNT — Future rewards discounted at 1/(1 + k×delay).
        
        k = 0.35, so delay of 3 time units → value reduced to ~48%.
        Used for temporal resource allocation.
        """
        discounted = value / (1 + HYPERBOLIC_K * delay)
        discount_rate = 1 - (discounted / value) if value > 0 else 0
        
        return {
            "law": "L-79",
            "law_name": "HYPERBOLIC_DISCOUNT",
            "k": HYPERBOLIC_K,
            "nominal_value": value,
            "delay": delay,
            "discounted_value": discounted,
            "discount_rate": discount_rate,
        }

    # ════════════════════════════════════════════════════════════════════════════
    # VALUE COMPUTATION — INT-TOK Formula
    # ════════════════════════════════════════════════════════════════════════════

    def compute_value(self, scc: float, layer: int, fib_idx: int) -> float:
        """
        Compute INT-TOK value using canonical formula:
        VALUE(K) = SCC × φ^L × F(n) / SCHUMANN
        
        Args:
            scc: Sovereign Coherence Coefficient (typically 2.618-5.0)
            layer: Substrate layer (0-12)
            fib_idx: Fibonacci index (0-17)
        
        Returns:
            INT-TOK value
        """
        fib_val = FIBONACCI[min(fib_idx, 17)]
        return (scc * (PHI ** layer) * fib_val) / SCHUMANN

    def compute_value_with_premium(self, scc: float, layer: int, fib_idx: int) -> Tuple[float, float]:
        """
        Compute INT-TOK value with Silver Premium applied.
        
        Returns:
            (base_value, premium_value)
        """
        base = self.compute_value(scc, layer, fib_idx)
        premium = base * SILVER_PREMIUM if self._state.coherence >= 0.90 else base
        return base, premium

    # ════════════════════════════════════════════════════════════════════════════
    # RESOURCE FLOW & ALLOCATION
    # ════════════════════════════════════════════════════════════════════════════

    def allocate_resource(
        self,
        source: str,
        destination: str,
        resource_type: str,
        amount: float
    ) -> ResourceFlow:
        """
        Allocate resources using φ-based efficiency optimization.
        
        Args:
            source: Source component/module
            destination: Destination component/module
            resource_type: "cycles", "tokens", "memory", etc.
            amount: Amount to allocate
        
        Returns:
            ResourceFlow record
        """
        # Apply φ efficiency — some portion retained for coherence
        phi_efficiency = PHI_INV  # 61.8% efficiency baseline
        if self._state.coherence >= 0.90:
            phi_efficiency = PHI_INV + (1 - PHI_INV) * 0.5  # Boost to ~80.9%
        
        effective_amount = amount * phi_efficiency
        
        # Generate flow ID
        raw_id = f"FLOW-{source}-{destination}-{amount}-{time.time()}"
        flow_id = hashlib.sha256(raw_id.encode()).hexdigest()[:12].upper()
        
        flow = ResourceFlow(
            flow_id=f"RF-{flow_id}",
            source=source,
            destination=destination,
            resource_type=resource_type,
            amount=effective_amount,
            phi_efficiency=phi_efficiency,
            timestamp=time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        )
        
        self._flows.append(flow)
        
        # Update state
        if resource_type == "cycles":
            self._state.allocated_cycles += effective_amount
        elif resource_type == "tokens":
            self._state.reserved_tokens += int(effective_amount)
        
        return flow

    # ════════════════════════════════════════════════════════════════════════════
    # ECONOMIC DECISION MAKING
    # ════════════════════════════════════════════════════════════════════════════

    def make_decision(
        self,
        decision_type: str,
        input_value: float,
        context: Optional[Dict[str, Any]] = None
    ) -> EconomicDecision:
        """
        Make an economic decision applying all relevant behavioral laws.
        
        Args:
            decision_type: Type of decision (e.g., "allocation", "pricing", "risk")
            input_value: Base input value
            context: Additional context for decision making
        
        Returns:
            EconomicDecision record
        """
        context = context or {}
        laws_applied = []
        output_value = input_value
        
        # Apply relevant laws based on decision type
        if decision_type in ["allocation", "investment"]:
            # Apply loss aversion
            gain = context.get("expected_gain", input_value * 0.1)
            loss = context.get("expected_loss", input_value * 0.05)
            result = self.apply_loss_aversion(gain, loss)
            if result["dominated"]:
                output_value *= 0.5  # Reduce allocation if loss-dominated
            laws_applied.append("L-72")
            
            # Apply hyperbolic discount
            delay = context.get("delay", 1.0)
            discount_result = self.apply_hyperbolic_discount(output_value, delay)
            output_value = discount_result["discounted_value"]
            laws_applied.append("L-79")
        
        elif decision_type == "pricing":
            # Apply anchoring
            anchor = context.get("anchor", output_value)
            anchor_result = self.apply_anchoring(anchor, output_value)
            output_value = anchor_result["perceived_value"]
            laws_applied.append("L-73")
            
            # Apply framing
            frame = context.get("frame", "neutral")
            frame_result = self.apply_framing_effect(output_value, frame)
            output_value = frame_result["perceived_value"]
            laws_applied.append("L-77")
        
        elif decision_type == "risk":
            # Apply regret aversion
            probability = context.get("regret_probability", 0.5)
            regret_result = self.apply_regret_aversion(probability)
            if regret_result["paralysis"]:
                output_value *= 0.3  # Significant reduction on paralysis
            laws_applied.append("L-76")
        
        elif decision_type == "performance":
            # Apply hormetic stress
            stress = context.get("stress", self._state.stress_level)
            baseline = output_value
            stress_result = self.apply_hormetic_stress(stress, baseline)
            output_value = stress_result["output"]
            laws_applied.append("L-78")
        
        # Compute net utility
        net_utility = output_value - input_value
        
        # Generate decision ID
        raw_id = f"DEC-{decision_type}-{input_value}-{time.time()}"
        decision_id = hashlib.sha256(raw_id.encode()).hexdigest()[:12].upper()
        
        decision = EconomicDecision(
            decision_id=f"ED-{decision_id}",
            decision_type=decision_type,
            input_value=input_value,
            output_value=output_value,
            laws_applied=laws_applied,
            coherence_at_decision=self._state.coherence,
            net_utility=net_utility,
            timestamp=time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        )
        
        self._decisions.append(decision)
        self._state.decision_count += 1
        self._state.value_created += max(0, net_utility)
        
        return decision

    # ════════════════════════════════════════════════════════════════════════════
    # HEARTBEAT & STATUS
    # ════════════════════════════════════════════════════════════════════════════

    def heartbeat(self) -> Dict[str, Any]:
        """Emit a heartbeat at φ¹⁰ Hz cadence."""
        self._beat += 1
        uptime = time.time() - self._boot_time
        
        return {
            "engine": "ECONOMICS_ORGANISM",
            "beat": self._beat,
            "frequency_hz": PHI_10,
            "coherence": self._state.coherence,
            "stress_level": self._state.stress_level,
            "total_cycles": self._state.total_cycles,
            "allocated_cycles": self._state.allocated_cycles,
            "total_tokens": self._state.total_tokens,
            "reserved_tokens": self._state.reserved_tokens,
            "decision_count": self._state.decision_count,
            "value_created": self._state.value_created,
            "flows_count": len(self._flows),
            "uptime_seconds": uptime,
            "prot": "PROT-378",
            "organism_key": "PRIMA CAUSA",
        }

    def update_coherence(self, coherence: float) -> None:
        """Update organism coherence (0.0-1.0)."""
        self._state.coherence = max(0.0, min(1.0, coherence))

    def update_stress(self, stress: float) -> None:
        """Update organism stress level (0.0-1.0)."""
        self._state.stress_level = max(0.0, min(1.0, stress))

    def add_cycles(self, amount: float) -> None:
        """Add cycles to total pool."""
        self._state.total_cycles += amount

    def add_tokens(self, amount: int) -> None:
        """Add tokens to total pool."""
        self._state.total_tokens += amount

    def get_state(self) -> EconomicState:
        """Return current economic state."""
        return self._state

    def get_law_manifest(self) -> Dict[str, Any]:
        """Return the full behavioral economics law manifest."""
        return {
            "laws": {
                "L-72": {
                    "name": "LOSS_AVERSION",
                    "constant": "λ",
                    "value": LOSS_AVERSION_LAMBDA,
                    "effect": "Losses weighted 2.25× gains",
                },
                "L-73": {
                    "name": "ANCHORING",
                    "constant": "persistence",
                    "value": ANCHORING_PERSISTENCE,
                    "effect": "First value persists with weight 1/φ",
                },
                "L-74": {
                    "name": "REPRESENTATIVENESS_FAILURE",
                    "constant": "failure_rate",
                    "value": REPRESENTATIVENESS_FAILURE,
                    "effect": "35% failure rate under novel conditions",
                },
                "L-75": {
                    "name": "AVAILABILITY_BIAS",
                    "constant": "recency_weight",
                    "value": AVAILABILITY_RECENCY_WEIGHT,
                    "effect": "Recent events overweighted by φ",
                },
                "L-76": {
                    "name": "REGRET_AVERSION",
                    "constant": "threshold",
                    "value": REGRET_AVERSION_THRESHOLD,
                    "effect": "Decision freezes above 0.72 regret probability",
                },
                "L-77": {
                    "name": "FRAMING_EFFECT",
                    "constant": "magnitude",
                    "value": FRAMING_EFFECT_MAGNITUDE,
                    "effect": "Identical choices, different frames → 28% swing",
                },
                "L-78": {
                    "name": "HORMETIC_STRESS",
                    "constant": "zone",
                    "value": [HORMETIC_STRESS_FLOOR, HORMETIC_STRESS_CEILING],
                    "effect": "Performance improves in [0.15, 0.72] stress zone",
                },
                "L-79": {
                    "name": "HYPERBOLIC_DISCOUNT",
                    "constant": "k",
                    "value": HYPERBOLIC_K,
                    "effect": "Future rewards discounted at 1/(1 + 0.35×delay)",
                },
            },
            "protocol": "PROT-378",
            "organism_key": "PRIMA CAUSA",
        }

    def status(self) -> Dict[str, Any]:
        """Return full status report."""
        return {
            "engine": "ECONOMICS_ORGANISM",
            "prima_causa": self.prima_causa,
            "state": {
                "total_cycles": self._state.total_cycles,
                "allocated_cycles": self._state.allocated_cycles,
                "total_tokens": self._state.total_tokens,
                "reserved_tokens": self._state.reserved_tokens,
                "coherence": self._state.coherence,
                "stress_level": self._state.stress_level,
                "decision_count": self._state.decision_count,
                "value_created": self._state.value_created,
            },
            "beat": self._beat,
            "flows_count": len(self._flows),
            "decisions_count": len(self._decisions),
            "fib_index": self._fib_index,
            "silver_premium_active": self._state.coherence >= 0.90,
            "frequency_hz": PHI_10,
            "status": "ACTIVE",
        }


# ── Standalone test ───────────────────────────────────────────────────────────
if __name__ == "__main__":
    import json
    
    engine = EconomicsOrganismEngine()
    print("ECONOMICS ORGANISM ENGINE — MOTOR OECONOMIAE ORGANISMI")
    print("=" * 70)
    print(json.dumps(engine.prima_causa, indent=2))
    print()
    
    # Test behavioral laws
    print("Testing Behavioral Economics Laws:")
    print("-" * 50)
    
    # L-72: Loss Aversion
    loss_result = engine.apply_loss_aversion(gain=100, loss=50)
    print(f"L-72 Loss Aversion: Gain=100, Loss=50 → Net Utility={loss_result['net_utility']:.2f}")
    
    # L-73: Anchoring
    anchor_result = engine.apply_anchoring(anchor=100, new_value=150)
    print(f"L-73 Anchoring: Anchor=100, New=150 → Perceived={anchor_result['perceived_value']:.2f}")
    
    # L-78: Hormetic Stress
    stress_result = engine.apply_hormetic_stress(stress=0.45, baseline=100)
    print(f"L-78 Hormetic: Stress=0.45, Base=100 → Output={stress_result['output']:.2f} ({stress_result['zone_status']})")
    
    # L-79: Hyperbolic Discount
    discount_result = engine.apply_hyperbolic_discount(value=100, delay=3)
    print(f"L-79 Hyperbolic: Value=100, Delay=3 → Discounted={discount_result['discounted_value']:.2f}")
    
    print()
    
    # Test value computation
    value = engine.compute_value(scc=4.5, layer=9, fib_idx=10)
    print(f"INT-TOK Value (SCC=4.5, L=9, F(10)): {value:.2f} INT-TOK")
    
    # Test decision making
    decision = engine.make_decision("allocation", 1000, {"expected_gain": 150, "expected_loss": 50, "delay": 2})
    print(f"Allocation Decision: Input=1000 → Output={decision.output_value:.2f} (Laws: {decision.laws_applied})")
    
    print()
    
    # Heartbeat
    hb = engine.heartbeat()
    print(f"Heartbeat #{hb['beat']} @ {hb['frequency_hz']:.3f} Hz")
