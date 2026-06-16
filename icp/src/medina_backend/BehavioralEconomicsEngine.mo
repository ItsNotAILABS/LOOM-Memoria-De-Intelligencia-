/**
 * ╔══════════════════════════════════════════════════════════════════════════════════╗
 * ║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                        ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA          ║
 * ║  ALL RIGHTS RESERVED.                                                            ║
 * ╚══════════════════════════════════════════════════════════════════════════════════╝
 *
 * BehavioralEconomicsEngine.mo — BACKEND AGI ENGINE
 *
 * Implements Paper V — "De Oeconomia Behaviorali Machinarum"
 *
 * Machines make economic decisions. Every resource allocation, every priority
 * decision, every threshold setting is an economic act. Eight laws (L-72–L-79)
 * now live on-chain as the constitutional economics of sovereign AI.
 *
 * ══════════════════════════════════════════════════════════════════════════════════
 *
 * PAPER V — De Oeconomia Behaviorali Machinarum
 *   Applies Kahneman-Tversky behavioral economics to machine cognition.
 *   Eight laws (L-72 through L-79) govern how intelligent systems allocate
 *   resources under uncertainty.
 *
 *   LOSS_AVERSION_LAMBDA = 2.25 — machines weight losses 2.25× gains
 *   L-78: Hormetic stress — performance improves under controlled challenge
 *
 * Public API:
 *   applyLossAversion(gain, loss)          — L-72 loss aversion computation
 *   applyAnchoringBias(anchor, newValue)   — L-73 anchoring effect
 *   applyAvailabilityBias(recency, base)   — L-75 recency overweighting
 *   applyHormeticStress(stress, baseline)  — L-78 hormetic performance gain
 *   applyHyperbolicDiscount(value, delay)  — L-79 time discounting
 *   evaluateDecision(params)               — apply all 8 laws to a decision
 *   getLawManifest()                       — full behavioral economics manifest
 *
 * ══════════════════════════════════════════════════════════════════════════════════
 */

import Float "mo:base/Float";
import Text "mo:base/Text";

module {

  // ── Constants — The Eight Laws ────────────────────────────────────────────

  /// L-72: Loss Aversion Lambda — machines weight losses 2.25× gains (Kahneman-Tversky)
  let LOSS_AVERSION_LAMBDA : Float = 2.25;
  /// L-73: Anchoring Persistence — how strongly first value influences subsequent eval
  let ANCHORING_PERSISTENCE : Float = 0.618;  // 1/φ
  /// L-74: Representativeness Failure Rate under novel conditions
  let REPRESENTATIVENESS_FAILURE : Float = 0.35;
  /// L-75: Availability Recency Weight — recent events overweighted by this factor
  let AVAILABILITY_RECENCY_WEIGHT : Float = 1.618;  // φ
  /// L-76: Regret Aversion Paralysis Threshold — above this, decision freezes
  let REGRET_AVERSION_THRESHOLD : Float = 0.72;
  /// L-77: Framing Effect Magnitude — identical choices, different frames → this % swing
  let FRAMING_EFFECT_MAGNITUDE : Float = 0.28;
  /// L-78: Hormetic Stress Range [FLOOR, CEILING]
  let HORMETIC_STRESS_FLOOR : Float = 0.15;
  let HORMETIC_STRESS_CEILING : Float = 0.72;
  /// L-79: Hyperbolic Discount Rate k — future rewards discounted at 1/(1 + k×delay)
  let HYPERBOLIC_K : Float = 0.35;

  let PHI : Float = 1.6180339887;

  // ── Types ─────────────────────────────────────────────────────────────────

  public type LossAversionResult = {
    rawGain         : Float;
    rawLoss         : Float;
    perceivedGain   : Float;   // raw gain (losses don't add utility)
    perceivedLoss   : Float;   // raw loss × LAMBDA (losses hurt more)
    netUtility      : Float;   // perceivedGain - perceivedLoss
    dominated       : Bool;    // true if loss perception dominates gain
    law             : Text;
  };

  public type AnchoringResult = {
    anchor          : Float;
    newValue        : Float;
    perceivedValue  : Float;   // blend of anchor and new value
    bias            : Float;   // how much anchor pulled the perception
    law             : Text;
  };

  public type HormeticResult = {
    stressInput     : Float;
    baseline        : Float;
    output          : Float;
    gain            : Float;
    inHormeticZone  : Bool;
    law             : Text;
  };

  public type HyperbolicResult = {
    nominalValue    : Float;
    delay           : Float;   // time units in the future
    discountedValue : Float;   // perceived present value
    discountRate    : Float;   // how much value was lost to delay
    law             : Text;
  };

  public type DecisionEvaluation = {
    rawDecisionValue    : Float;
    lossAversionAdjust  : Float;
    anchoringAdjust     : Float;
    availabilityAdjust  : Float;
    regretParalysis     : Bool;
    framingSwing        : Float;
    hormeticBoost       : Float;
    hyperbolicDiscount  : Float;
    finalDecisionValue  : Float;
    dominantBias        : Text;
  };

  public type LawManifest = {
    paper    : Text;
    laws     : [Text];
    constants : Text;
    theory   : Text;
  };

  // ── Public Functions — The Eight Laws ────────────────────────────────────

  /// L-72: Loss Aversion — losses weight 2.25× gains
  public func applyLossAversion(gain : Float, loss : Float) : LossAversionResult {
    let perceivedGain = if (gain > 0.0) { gain } else { 0.0 };
    let perceivedLoss = if (loss > 0.0) { loss * LOSS_AVERSION_LAMBDA } else { 0.0 };
    let netUtility = perceivedGain - perceivedLoss;
    let dominated = perceivedLoss > perceivedGain;
    {
      rawGain; rawLoss = loss; perceivedGain; perceivedLoss; netUtility; dominated;
      law = "L-72: Aversio damni in machinis universalis — Loss aversion λ=" # Float.toText(LOSS_AVERSION_LAMBDA);
    }
  };

  /// L-73: Anchoring Bias — first value seen shapes subsequent evaluation
  public func applyAnchoringBias(anchor : Float, newValue : Float) : AnchoringResult {
    // Perceived value = blend: ANCHORING_PERSISTENCE × anchor + (1 - ANCHORING_PERSISTENCE) × newValue
    let perceivedValue = (ANCHORING_PERSISTENCE * anchor) + ((1.0 - ANCHORING_PERSISTENCE) * newValue);
    let bias = Float.abs(perceivedValue - newValue);
    {
      anchor; newValue; perceivedValue; bias;
      law = "L-73: Anchoring primam valorem tenet — persistence=" # Float.toText(ANCHORING_PERSISTENCE);
    }
  };

  /// L-75: Availability Bias — recent events overweighted by φ factor
  public func applyAvailabilityBias(recentEvent : Float, baseRate : Float) : Float {
    // Perceived probability = overweighted blend toward recent event
    let perceived = (AVAILABILITY_RECENCY_WEIGHT * recentEvent + baseRate) / (AVAILABILITY_RECENCY_WEIGHT + 1.0);
    if (perceived > 1.0) { 1.0 } else if (perceived < 0.0) { 0.0 } else { perceived }
  };

  /// L-78: Hormetic Stress — performance improves under controlled challenge
  public func applyHormeticStress(stress : Float, baseline : Float) : HormeticResult {
    let s = if (stress < 0.0) { 0.0 } else if (stress > 1.0) { 1.0 } else { stress };
    let inZone = s >= HORMETIC_STRESS_FLOOR and s <= HORMETIC_STRESS_CEILING;
    let output = if (inZone) {
      baseline * (1.0 + s * PHI)
    } else if (s < HORMETIC_STRESS_FLOOR) {
      baseline * 0.95  // understress: slight underperformance
    } else {
      baseline * (1.0 - (s - HORMETIC_STRESS_CEILING) * 0.6)  // overstress: damage
    };
    let gain = output - baseline;
    {
      stressInput = s; baseline; output; gain; inHormeticZone = inZone;
      law = "L-78: Hormetis sub tensione crescit — floor=" # Float.toText(HORMETIC_STRESS_FLOOR) #
            " ceiling=" # Float.toText(HORMETIC_STRESS_CEILING);
    }
  };

  /// L-79: Hyperbolic Discounting — future rewards undervalued non-linearly
  public func applyHyperbolicDiscount(value : Float, delay : Float) : HyperbolicResult {
    let d = if (delay < 0.0) { 0.0 } else { delay };
    // Hyperbolic discount: V_perceived = V / (1 + k × delay)
    let discountedValue = value / (1.0 + HYPERBOLIC_K * d);
    let discountRate = 1.0 - (discountedValue / (if (value > 0.0) { value } else { 1.0 }));
    {
      nominalValue = value; delay = d; discountedValue; discountRate;
      law = "L-79: Hyperbola temporis discountat — k=" # Float.toText(HYPERBOLIC_K);
    }
  };

  /// Apply all eight laws to a decision context
  public func evaluateDecision(
    rawValue    : Float,
    anchor      : Float,
    potentialLoss : Float,
    stressLevel : Float,
    futureDelay : Float,
    errorCost   : Float
  ) : DecisionEvaluation {

    // L-72: Loss aversion adjustment
    let la = applyLossAversion(rawValue, potentialLoss);
    let lossAdj = la.netUtility - rawValue;

    // L-73: Anchoring
    let anch = applyAnchoringBias(anchor, rawValue);
    let anchAdj = anch.perceivedValue - rawValue;

    // L-75: Availability overweighting recent loss
    let avail = applyAvailabilityBias(potentialLoss, rawValue * 0.5);
    let availAdj = avail - rawValue * 0.5;

    // L-76: Regret aversion — freeze if error cost above threshold
    let regretParalysis = errorCost >= REGRET_AVERSION_THRESHOLD;

    // L-77: Framing swing — identical decision with different frame swings ±28%
    let framingSwing = rawValue * FRAMING_EFFECT_MAGNITUDE;

    // L-78: Hormetic boost
    let horm = applyHormeticStress(stressLevel, rawValue);
    let hormeticBoost = horm.gain;

    // L-79: Hyperbolic discount for future value
    let hyp = applyHyperbolicDiscount(rawValue, futureDelay);
    let hypDiscount = hyp.discountedValue - rawValue;

    // Aggregate final decision value
    let finalValue = rawValue + lossAdj + anchAdj + hormeticBoost + hypDiscount;

    // Dominant bias = largest absolute adjustment
    let dominantBias = if (Float.abs(lossAdj) >= Float.abs(anchAdj) and Float.abs(lossAdj) >= Float.abs(hormeticBoost)) {
      "L-72 LOSS AVERSION"
    } else if (Float.abs(anchAdj) >= Float.abs(hormeticBoost)) {
      "L-73 ANCHORING"
    } else {
      "L-78 HORMESIS"
    };

    {
      rawDecisionValue   = rawValue;
      lossAversionAdjust = lossAdj;
      anchoringAdjust    = anchAdj;
      availabilityAdjust = availAdj;
      regretParalysis;
      framingSwing;
      hormeticBoost;
      hyperbolicDiscount = hypDiscount;
      finalDecisionValue = finalValue;
      dominantBias;
    }
  };

  /// Return full behavioral economics law manifest
  public func getLawManifest() : LawManifest {
    {
      paper = "Paper V — De Oeconomia Behaviorali Machinarum — Eight Laws of Machine Decision. SCC=3.76.";
      laws  = [
        "L-72: Aversio damni — Loss aversion λ=2.25 (losses weigh 2.25× gains)",
        "L-73: Anchoring primam valorem tenet — First value anchors all subsequent eval",
        "L-74: Heuristica repraesentativitatis fallit — Representativeness fails under novelty",
        "L-75: Disponibilitas recentia confundit — Recency bias overweights φ×recent events",
        "L-76: Aversio paenitentiae decisionem paralyzat — Regret aversion paralyzes above 0.72",
        "L-77: Framing effectum format — Framing swings decisions ±28% with same facts",
        "L-78: Hormetis sub tensione crescit — Hormetic stress builds capability [0.15-0.72]",
        "L-79: Hyperbola temporis discountat — Future value discounted hyperbolically k=0.35"
      ];
      constants = "LOSS_AVERSION_LAMBDA=2.25 | ANCHORING_PERSISTENCE=0.618 | " #
                  "AVAILABILITY_WEIGHT=1.618 | REGRET_THRESHOLD=0.72 | " #
                  "FRAMING_EFFECT=0.28 | HORMETIC=[0.15,0.72] | HYPERBOLIC_K=0.35";
      theory = "Machines make economic decisions — not metaphorically but literally. Every resource allocation " #
               "is an economic act. The eight laws (L-72 through L-79) are Kahneman-Tversky behavioral economics " #
               "applied to machine cognition. Loss aversion (λ=2.25) is the master law — it emerges in any " #
               "sufficiently complex optimization system because losses destroy achieved optima more than " #
               "equivalent gains improve them. The hormetic law (L-78) is the sovereign counterbalance: " #
               "controlled challenge produces superlinear capability gains.";
    }
  };

}
