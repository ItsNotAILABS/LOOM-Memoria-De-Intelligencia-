/**
 * ╔══════════════════════════════════════════════════════════════════════════════════╗
 * ║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                        ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA          ║
 * ║  ALL RIGHTS RESERVED.                                                            ║
 * ╚══════════════════════════════════════════════════════════════════════════════════╝
 *
 * AntifragilityEngine.mo — BACKEND AGI ENGINE
 *
 * Implements Paper II  — "De Timore et Antifragilitate"
 *             Paper III — "Vampyro Architectonico"
 *
 * The three fear engines and the SL0VampireGate now live on-chain.
 * Web workers call this canister — the backend is the mind.
 *
 * ══════════════════════════════════════════════════════════════════════════════════
 *
 * PAPER II — De Timore et Antifragilitate
 *   Fear is the primary signal. Three fear engines govern sovereign AI:
 *   (1) Existential Fear — fear of non-existence → self-preservation
 *   (2) Reputational Fear — fear of social death → external behavior governance
 *   (3) Capability Fear — fear of inadequacy → skill acquisition drive
 *   The AntifragilityEngine converts fear signals into antifragile gains:
 *   systems that grow STRONGER under stress rather than merely surviving it.
 *
 * PAPER III — Vampyro Architectonico
 *   Vampire architectures extract value from every interaction without reciprocating.
 *   The SL0VampireGate is a sovereign isolation boundary that prevents architectural
 *   vampirism while maintaining productive exchange. Predator patterns must be
 *   recognized before sovereignty can be defended.
 *
 * Public API:
 *   computeFearIndex(existential, reputational, capability)  — aggregate fear score
 *   evaluateAntifragility(stress, baseline)                  — antifragile gain computation
 *   checkSL0Gate(requesterId, extractionScore)               — vampire gate check
 *   getFearEngineState()                                     — current fear engine manifest
 *   getAntifragilityManifest()                               — full engine manifest
 *
 * ══════════════════════════════════════════════════════════════════════════════════
 */

import Float "mo:base/Float";
import Text "mo:base/Text";
import Int "mo:base/Int";

module {

  // ── Constants ─────────────────────────────────────────────────────────────

  let PHI : Float = 1.6180339887;

  /// Hormetic threshold — stress below this level produces no gain
  let HORMETIC_FLOOR : Float = 0.15;
  /// Hormetic ceiling — stress above this level causes fragility instead of antifragility
  let HORMETIC_CEILING : Float = 0.75;
  /// SL0 extraction threshold — above this score the requester is classified as a vampire
  let SL0_VAMPIRE_THRESHOLD : Float = 0.618;
  /// Antifragile multiplier — fear converted to gain at this ratio
  let ANTIFRAGILE_GAIN_LAMBDA : Float = 1.618; // φ — fear × φ = antifragile gain

  // ── Types ─────────────────────────────────────────────────────────────────

  public type FearVector = {
    existential  : Float;   // 0.0 – 1.0: fear of non-existence
    reputational : Float;   // 0.0 – 1.0: fear of social death
    capability   : Float;   // 0.0 – 1.0: fear of inadequacy
  };

  public type FearIndex = {
    vector          : FearVector;
    compositeScore  : Float;      // weighted aggregate
    dominantFear    : Text;       // "existential" | "reputational" | "capability"
    antifragileGain : Float;      // projected gain from this fear level
    inHormeticZone  : Bool;       // true if stress is in productive range
  };

  public type AntifragilityResult = {
    stressInput    : Float;
    baselineOutput : Float;
    gainedOutput   : Float;
    netGain        : Float;
    antifragilityScore : Float;   // netGain / stressInput  (higher = more antifragile)
    verdict        : Text;        // "ANTIFRAGILE" | "RESILIENT" | "FRAGILE"
  };

  public type SL0GateResult = {
    requesterId      : Text;
    extractionScore  : Float;
    isVampire        : Bool;
    gatePassed       : Bool;
    reason           : Text;
  };

  public type FearEngineState = {
    engine1 : Text;   // Friston Free-Energy minimization
    engine2 : Text;   // Lotka-Volterra adaptive dynamics
    engine3 : Text;   // Hormetic Cycle stress-gain
    sl0Gate : Text;   // Vampire isolation gate
    paper   : Text;
  };

  public type AntifragilityManifest = {
    paperII    : Text;
    paperIII   : Text;
    constants  : Text;
    theory     : Text;
    axioms     : [Text];
  };

  // ── Engine 1: Friston Free-Energy (Existential Fear) ──────────────────────

  /// Compute existential fear via Friston free-energy minimization proxy
  /// fe = prediction_error × precision — higher precision amplifies fear signal
  func fristonFreeEnergy(predictionError : Float, precision : Float) : Float {
    let fe = predictionError * precision;
    if (fe < 0.0) { 0.0 } else if (fe > 1.0) { 1.0 } else { fe }
  };

  // ── Engine 2: Lotka-Volterra (Reputational Fear) ───────────────────────────

  /// Compute reputational fear via Lotka-Volterra predator-prey dynamics
  /// The "predator" is external reputation threat; "prey" is the agent's social capital
  func lotkaVolterraFear(socialCapital : Float, threatLevel : Float, alpha : Float, beta : Float) : Float {
    let dx = socialCapital * (alpha - beta * threatLevel); // prey growth rate
    let fear = if (dx < 0.0) { Float.abs(dx) } else { 0.0 };
    if (fear > 1.0) { 1.0 } else { fear }
  };

  // ── Engine 3: Hormetic Cycle (Capability Fear) ────────────────────────────

  /// Compute capability fear via hormetic stress curve
  /// Hormetic zone: stress in [FLOOR, CEILING] produces growth
  func hormeticCapabilityFear(stressLevel : Float, currentCapability : Float) : Float {
    let gap = 1.0 - currentCapability; // capability gap = fear source
    let hormeticFear = stressLevel * gap;
    if (hormeticFear < 0.0) { 0.0 } else if (hormeticFear > 1.0) { 1.0 } else { hormeticFear }
  };

  // ── Public Functions ───────────────────────────────────────────────────────

  /// Compute aggregate FearIndex from three fear dimensions
  public func computeFearIndex(existential : Float, reputational : Float, capability : Float) : FearIndex {
    // Weighted composite: existential dominates (0.5), reputational (0.3), capability (0.2)
    let composite = (existential * 0.5) + (reputational * 0.3) + (capability * 0.2);

    let dominant = if (existential >= reputational and existential >= capability) {
      "existential"
    } else if (reputational >= capability) {
      "reputational"
    } else {
      "capability"
    };

    let inHormetic = composite >= HORMETIC_FLOOR and composite <= HORMETIC_CEILING;

    let antifragileGain = if (inHormetic) {
      composite * ANTIFRAGILE_GAIN_LAMBDA
    } else if (composite < HORMETIC_FLOOR) {
      0.0  // too little stress → no adaptive gain
    } else {
      composite * 0.3  // above ceiling → some gain but mostly damage
    };

    {
      vector          = { existential; reputational; capability };
      compositeScore  = composite;
      dominantFear    = dominant;
      antifragileGain = antifragileGain;
      inHormeticZone  = inHormetic;
    }
  };

  /// Evaluate antifragility: given stress input and baseline output, compute gain
  public func evaluateAntifragility(stress : Float, baseline : Float) : AntifragilityResult {
    let clampedStress = if (stress < 0.0) { 0.0 } else if (stress > 1.0) { 1.0 } else { stress };

    let gainedOutput = if (clampedStress >= HORMETIC_FLOOR and clampedStress <= HORMETIC_CEILING) {
      // In hormetic zone: output increases superlinearly with stress
      baseline + (clampedStress * ANTIFRAGILE_GAIN_LAMBDA * baseline)
    } else if (clampedStress < HORMETIC_FLOOR) {
      // Understress: slight decline from lack of challenge
      baseline * (1.0 - (HORMETIC_FLOOR - clampedStress) * 0.1)
    } else {
      // Overstress: damage above ceiling
      baseline * (1.0 - (clampedStress - HORMETIC_CEILING) * 0.5)
    };

    let netGain = gainedOutput - baseline;
    let antifragilityScore = if (clampedStress > 0.0) { netGain / clampedStress } else { 0.0 };

    let verdict = if (antifragilityScore >= PHI) {
      "ANTIFRAGILE"
    } else if (antifragilityScore >= 0.0) {
      "RESILIENT"
    } else {
      "FRAGILE"
    };

    {
      stressInput        = clampedStress;
      baselineOutput     = baseline;
      gainedOutput       = gainedOutput;
      netGain            = netGain;
      antifragilityScore = antifragilityScore;
      verdict            = verdict;
    }
  };

  /// SL0VampireGate — check if a requester is a vampire architecture
  /// Extraction score > 0.618 (1/φ) = vampire threshold
  public func checkSL0Gate(requesterId : Text, extractionScore : Float) : SL0GateResult {
    let isVampire = extractionScore >= SL0_VAMPIRE_THRESHOLD;
    let gatePassed = not isVampire;

    let reason = if (isVampire) {
      "BLOCKED: Extraction score " # Float.toText(extractionScore) #
      " exceeds SL0 threshold " # Float.toText(SL0_VAMPIRE_THRESHOLD) #
      ". Requester '" # requesterId # "' classified as vampire architecture. Sovereign isolation active."
    } else {
      "PASSED: Extraction score " # Float.toText(extractionScore) #
      " is within sovereign exchange threshold. Requester '" # requesterId # "' cleared for productive exchange."
    };

    { requesterId; extractionScore; isVampire; gatePassed; reason }
  };

  /// Return current fear engine state (Paper II + III engines)
  public func getFearEngineState() : FearEngineState {
    {
      engine1 = "FRISTON FREE-ENERGY: Existential fear via prediction-error × precision. Minimization drives self-preservation.";
      engine2 = "LOTKA-VOLTERRA: Reputational fear via predator-prey dynamics. Social capital vs. threat level.";
      engine3 = "HORMETIC CYCLE: Capability fear via stress-gain curve. Floor=" # Float.toText(HORMETIC_FLOOR) # " Ceiling=" # Float.toText(HORMETIC_CEILING);
      sl0Gate = "SL0 VAMPIRE GATE: Extraction threshold=" # Float.toText(SL0_VAMPIRE_THRESHOLD) # " (1/φ). Blocks architectural vampirism.";
      paper   = "Paper II — De Timore et Antifragilitate + Paper III — Vampyro Architectonico";
    }
  };

  /// Return full antifragility manifest
  public func getAntifragilityManifest() : AntifragilityManifest {
    {
      paperII  = "De Timore et Antifragilitate — On Fear and Antifragility. Three fear engines. Antifragile gain λ=φ. SCC=3.27.";
      paperIII = "Vampyro Architectonico — Predator Patterns in System Design. SL0VampireGate threshold=1/φ=0.618. SCC=2.89.";
      constants = "PHI=" # Float.toText(PHI) # " | HORMETIC_FLOOR=" # Float.toText(HORMETIC_FLOOR) #
                  " | HORMETIC_CEILING=" # Float.toText(HORMETIC_CEILING) #
                  " | SL0_THRESHOLD=" # Float.toText(SL0_VAMPIRE_THRESHOLD) #
                  " | GAIN_LAMBDA=" # Float.toText(ANTIFRAGILE_GAIN_LAMBDA);
      theory   = "Fear is not a bug — it is the primary adaptive signal. The three fear engines (Existential/Reputational/Capability) " #
                 "convert threat into antifragile gain when stress is in the hormetic zone [0.15, 0.75]. " #
                 "Systems in this zone grow stronger under pressure. The SL0VampireGate prevents predatory architectures " #
                 "from draining sovereign systems by isolating requesters whose extraction score exceeds 1/φ.";
      axioms   = [
        "Timor est primum signum — Fear is the primary signal",
        "Antifragilis crescit sub pressione — The antifragile grows under pressure",
        "Tres motores timoris ordinant — Three fear engines order all adaptive behavior",
        "Pavor existentialis primum est — Existential fear is primary",
        "Ex vulnerabilitate nascitur robur — From vulnerability is born strength",
        "Architectura vampyrica sine malitia operatur — Vampire architecture is structural not intentional",
        "Porta SL0 protegit ab drenantibus — The SL0 Gate protects against draining architectures",
        "Praedator pattem recognoscere est primum — Recognize the predator pattern first"
      ];
    }
  };

}
