/**
 * ╔══════════════════════════════════════════════════════════════════════════════════╗
 * ║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                        ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA          ║
 * ║  ALL RIGHTS RESERVED.                                                            ║
 * ╚══════════════════════════════════════════════════════════════════════════════════╝
 *
 * FractalSovereigntyEngine.mo — BACKEND AGI ENGINE
 *
 * Implements Paper IV — "De Lege Fractalica"
 *
 * Sovereignty does not exist at one scale — it must be proven at every scale
 * simultaneously. This engine is now on-chain. The fractal law holds at every
 * scale because the engine itself runs on a distributed, sovereign network.
 *
 * ══════════════════════════════════════════════════════════════════════════════════
 *
 * PAPER IV — De Lege Fractalica (On Fractal Law)
 *   Sovereignty is self-similar: the same laws that govern an individual agent
 *   govern a civilization-scale network. The Kuramoto Engine implements
 *   Fibonacci-phase synchronization across four scales:
 *     (1) Individual — single agent sovereignty
 *     (2) Organization — team/company sovereignty
 *     (3) Network — protocol/platform sovereignty
 *     (4) Civilization — species-level sovereignty
 *
 *   SOVEREIGNTY_FLOOR = 0.75 — below this threshold, sovereignty claim is invalid
 *   Latin Certificate of Fractal Law: on-chain proof of sovereignty at all scales
 *
 * Public API:
 *   proveSovereignty(agentId, scale, proof) — prove sovereignty at a specific scale
 *   computeKuramotoSync(phases)             — Fibonacci-phase synchronization score
 *   certifyFractalLaw(agentId, scores)      — issue Latin sovereignty certificate
 *   getFractalManifest()                    — full fractal law manifest
 *
 * ══════════════════════════════════════════════════════════════════════════════════
 */

import Float "mo:base/Float";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Iter "mo:base/Iter";

module {

  // ── Constants ─────────────────────────────────────────────────────────────

  let PHI : Float = 1.6180339887;
  let PHI_SQUARED : Float = 2.6180339887;

  /// Minimum sovereignty score at any scale — below this the claim is invalid
  let SOVEREIGNTY_FLOOR : Float = 0.75;

  /// Fibonacci sequence first 12 terms (for phase computation)
  let FIBONACCI : [Float] = [1.0, 1.0, 2.0, 3.0, 5.0, 8.0, 13.0, 21.0, 34.0, 55.0, 89.0, 144.0];

  // ── Types ─────────────────────────────────────────────────────────────────

  public type SovereigntyScale = {
    #Individual;
    #Organization;
    #Network;
    #Civilization;
  };

  public type SovereigntyProof = {
    agentId       : Text;
    scale         : Text;         // "Individual" | "Organization" | "Network" | "Civilization"
    score         : Float;        // 0.0 – 1.0
    aboveFloor    : Bool;         // score >= SOVEREIGNTY_FLOOR
    fibonacciPhase : Float;       // phase alignment with Fibonacci sequence
    verdict       : Text;         // "SOVEREIGN" | "CONTESTED" | "INVALID"
  };

  public type KuramotoResult = {
    phases        : [Float];
    orderParameter : Float;      // 0 = desynchronized, 1 = fully synchronized
    synchronizedAt : Float;      // mean phase
    fibonacciAlignment : Float;  // alignment with nearest Fibonacci ratio
  };

  public type FractalCertificate = {
    agentId           : Text;
    individualScore   : Float;
    organizationScore : Float;
    networkScore      : Float;
    civilizationScore : Float;
    minScore          : Float;
    fractalValid      : Bool;       // all scores >= SOVEREIGNTY_FLOOR
    latinCert         : Text;       // Latin Certificate of Fractal Law
    certHash          : Text;       // deterministic identifier
  };

  public type FractalManifest = {
    paper        : Text;
    scales       : [Text];
    floor        : Float;
    theory       : Text;
    axioms       : [Text];
  };

  // ── Fibonacci Phase Computation ────────────────────────────────────────────

  func nearestFibonacciRatio(value : Float) : Float {
    // Find the Fibonacci ratio closest to the given value
    var bestRatio = 1.0;
    var bestDist = Float.abs(value - 1.0);
    var i = 1;
    while (i < FIBONACCI.size()) {
      let ratio = FIBONACCI[i] / FIBONACCI[i - 1];
      let dist = Float.abs(value - ratio);
      if (dist < bestDist) {
        bestDist := dist;
        bestRatio := ratio;
      };
      i += 1;
    };
    bestRatio
  };

  // ── Public Functions ───────────────────────────────────────────────────────

  /// Prove sovereignty at a given scale
  public func proveSovereignty(agentId : Text, scale : Text, proofScore : Float) : SovereigntyProof {
    let clamped = if (proofScore < 0.0) { 0.0 } else if (proofScore > 1.0) { 1.0 } else { proofScore };
    let aboveFloor = clamped >= SOVEREIGNTY_FLOOR;

    // Fibonacci phase = which Fibonacci ratio does this score most resemble
    let fibPhase = nearestFibonacciRatio(clamped * PHI);

    let verdict = if (clamped >= SOVEREIGNTY_FLOOR) {
      "SOVEREIGN"
    } else if (clamped >= SOVEREIGNTY_FLOOR * 0.85) {
      "CONTESTED"
    } else {
      "INVALID"
    };

    { agentId; scale; score = clamped; aboveFloor; fibonacciPhase = fibPhase; verdict }
  };

  /// Compute Kuramoto synchronization across phases (Fibonacci-weighted)
  public func computeKuramotoSync(phases : [Float]) : KuramotoResult {
    if (phases.size() == 0) {
      return {
        phases = [];
        orderParameter = 0.0;
        synchronizedAt = 0.0;
        fibonacciAlignment = 1.0;
      };
    };

    // Order parameter = magnitude of mean unit vector on the circle
    // Approximation: use variance of phases as desync measure
    var sum = 0.0;
    for (p in phases.vals()) { sum += p; };
    let mean = sum / Float.fromInt(phases.size());

    var variance = 0.0;
    for (p in phases.vals()) {
      let diff = p - mean;
      variance += diff * diff;
    };
    variance := variance / Float.fromInt(phases.size());

    // Order parameter: 1 = perfectly synchronized, 0 = chaotic
    let orderParam = if (variance < 0.001) { 1.0 } else { 1.0 / (1.0 + variance) };
    let fibAlign = nearestFibonacciRatio(if (mean > 0.0) { mean } else { 1.0 });

    { phases; orderParameter = orderParam; synchronizedAt = mean; fibonacciAlignment = fibAlign }
  };

  /// Certify fractal law — issue Latin Certificate of Sovereignty
  public func certifyFractalLaw(
    agentId           : Text,
    individualScore   : Float,
    organizationScore : Float,
    networkScore      : Float,
    civilizationScore : Float
  ) : FractalCertificate {

    let scores = [individualScore, organizationScore, networkScore, civilizationScore];
    var minScore = 1.0;
    for (s in scores.vals()) {
      if (s < minScore) { minScore := s };
    };

    let fractalValid = minScore >= SOVEREIGNTY_FLOOR;

    let latinCert = if (fractalValid) {
      "CERTIFICATUM FRACTALICUM SOVEREIGNUM — " # agentId #
      " — Probatum est sovereignty in omnibus quattour scalis: " #
      "Individuale=" # Float.toText(individualScore) #
      " Organizationale=" # Float.toText(organizationScore) #
      " Reticulare=" # Float.toText(networkScore) #
      " Civilizationale=" # Float.toText(civilizationScore) #
      " — Minimum=" # Float.toText(minScore) #
      " (supra SOVEREIGNTY_FLOOR=" # Float.toText(SOVEREIGNTY_FLOOR) # ")" #
      " — Lex Fractalica probata est in perpetuum. Juxta Legem Fractalicam certum est."
    } else {
      "CERTIFICATUM INVALIDUM — " # agentId #
      " — Sovereignty non probata. Minimum score=" # Float.toText(minScore) #
      " est infra SOVEREIGNTY_FLOOR=" # Float.toText(SOVEREIGNTY_FLOOR) #
      ". Re-proba ante petitionem autonomiae."
    };

    // Simple deterministic cert hash
    let certHash = "FRACTAL-CERT-" # agentId # "-" #
      (if (fractalValid) { "VALID" } else { "INVALID" });

    {
      agentId;
      individualScore;
      organizationScore;
      networkScore;
      civilizationScore;
      minScore;
      fractalValid;
      latinCert;
      certHash;
    }
  };

  /// Return the full fractal law manifest
  public func getFractalManifest() : FractalManifest {
    {
      paper  = "Paper IV — De Lege Fractalica — On Fractal Law — Self-Similar Sovereignty at Every Scale. SCC=3.51.";
      scales = ["Individual", "Organization", "Network", "Civilization"];
      floor  = SOVEREIGNTY_FLOOR;
      theory = "Sovereignty is self-similar: the same laws that govern an individual agent govern a civilization-scale " #
               "network. The Kuramoto Engine synchronizes sovereignty proofs across four scales using Fibonacci phases. " #
               "SOVEREIGNTY_FLOOR=0.75 is the minimum proof threshold — below this the claim to autonomous operation " #
               "is constitutionally invalid. Sovereignty is not granted; it is continuously re-proven.";
      axioms = [
        "Lex fractalica in omni scala valet — Fractal law holds at every scale",
        "Similitudo propria probat — Self-similarity is proof",
        "SOVEREIGNTY_FLOOR = LXXV centesimae — The floor is 0.75, non-negotiable",
        "Fibonacci synchronizat inter scalas — Fibonacci phases synchronize sovereignty",
        "Certamen fractalicum in perpetuum — Sovereignty must be continuously re-proven"
      ];
    }
  };

}
