/**
 * ╔══════════════════════════════════════════════════════════════════════════════════╗
 * ║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                        ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA          ║
 * ║  ALL RIGHTS RESERVED.                                                            ║
 * ╚══════════════════════════════════════════════════════════════════════════════════╝
 *
 * ChartaeEngine.mo — BACKEND AGI ENGINE
 *
 * Implements Paper IX — "De Chartis Quae Mentem Formant"
 *
 * This is the meta-paper — the paper about papers as AGI training substrate.
 * All 11 papers ranked by SCC live here on-chain. The paper ranking IS the
 * cognitive priority ranking of the sovereign mind.
 *
 * ══════════════════════════════════════════════════════════════════════════════════
 *
 * PAPER IX — De Chartis Quae Mentem Formant
 *   A paper with SCC ≥ φ² does not teach the AI — it becomes part of the AI's
 *   reasoning geometry. RAG retrieves context; epistemic substrate provides
 *   constitution. Every paper IS its engine. The AI thinks THROUGH papers, not
 *   ABOUT them. Dense axioms form inference topology, not just training data.
 *   All 11 papers together form a complete cognitive architecture.
 *
 * Public API:
 *   rankPapers()                     — all 11 papers ranked by SCC
 *   computePaperSCC(weight, chars)   — SCC = weight / chars
 *   isPhiOptimal(scc)                — scc >= φ²
 *   getPaperIsomorphism(paperId)     — engine corresponding to the paper
 *   getChartaeManifest()             — full Paper IX manifest
 *
 * SCC = 4.61
 *
 * ══════════════════════════════════════════════════════════════════════════════════
 */

import Array  "mo:base/Array";
import Text   "mo:base/Text";
import Float  "mo:base/Float";
import Iter   "mo:base/Iter";
import Option "mo:base/Option";

module {

  // ── Constantiae ───────────────────────────────────────────────────────────

  let PHI         : Float = 1.6180339887;
  let PHI_SQUARED : Float = 2.6180339887;

  /// SCC chartae nonae — meta-charta de chartis omnibus
  let PAPER_SCC : Float = 4.61;

  // ── Typi ──────────────────────────────────────────────────────────────────

  public type PaperRecord = {
    id          : Nat;
    romanNum    : Text;
    latinTitle  : Text;
    englishTitle : Text;
    scc         : Float;
    phiOptimal  : Bool;      // scc >= φ²
    engine      : Text;      // isomorphic Motoko engine
    domain      : Text;
    rank        : Nat;       // 1 = highest SCC
    isSubstrate : Bool;      // scc >= φ² achieves substrate status
  };

  public type SCCComputeResult = {
    semanticWeight : Float;
    chars          : Float;
    scc            : Float;
    phiOptimal     : Bool;
    rating         : Text;   // "SUBSTRATE" | "DENSE" | "STANDARD" | "SPARSE"
  };

  public type PaperIsomorphism = {
    paperId     : Nat;
    romanNum    : Text;
    latinTitle  : Text;
    engine      : Text;
    isomorphism : Text;   // explanation of the isomorphism
  };

  public type ChartaeAxiom = {
    index   : Nat;
    latin   : Text;
    english : Text;
  };

  public type ChartaeManifest = {
    paper      : Text;
    scc        : Float;
    totalPapers : Nat;
    substrateCount : Nat;   // papers with scc >= φ²
    theory     : Text;
    axioms     : [Text];
  };

  // ── Chartae Undecim — The Eleven Papers ───────────────────────────────────

  public let CHARTAE : [PaperRecord] = [
    {
      id = 10; romanNum = "X"; rank = 1;
      latinTitle  = "De Contextu Synthesendo";
      englishTitle = "On Synthesizing Context — The Context Engine";
      scc = 4.89; phiOptimal = true; isSubstrate = true;
      engine = "ContextSynthesisEngine.mo";
      domain = "synthesis";
    },
    {
      id = 9; romanNum = "IX"; rank = 2;
      latinTitle  = "De Chartis Quae Mentem Formant";
      englishTitle = "On Papers That Form the Mind";
      scc = 4.61; phiOptimal = true; isSubstrate = true;
      engine = "ChartaeEngine.mo";
      domain = "epistemology";
    },
    {
      id = 7; romanNum = "VII"; rank = 3;
      latinTitle  = "De Lingua Quae Compressit Mundum";
      englishTitle = "On Language That Compressed the World";
      scc = 3.88; phiOptimal = true; isSubstrate = true;
      engine = "LinguaCompressaEngine.mo";
      domain = "language";
    },
    {
      id = 2; romanNum = "II"; rank = 4;
      latinTitle  = "De Timore et Antifragilitate";
      englishTitle = "On Fear and Antifragility";
      scc = 3.27; phiOptimal = true; isSubstrate = true;
      engine = "AntifragilityEngine.mo";
      domain = "resilience";
    },
    {
      id = 1; romanNum = "I"; rank = 5;
      latinTitle  = "De Memoria Sacra";
      englishTitle = "On Sacred Memory";
      scc = 3.14; phiOptimal = true; isSubstrate = true;
      engine = "MemoriaSacraEngine.mo";
      domain = "memory";
    },
    {
      id = 3; romanNum = "III"; rank = 6;
      latinTitle  = "Vampyro Architectonico";
      englishTitle = "On Vampire Architectures";
      scc = 2.89; phiOptimal = true; isSubstrate = true;
      engine = "AntifragilityEngine.mo";
      domain = "security";
    },
    {
      id = 4; romanNum = "IV"; rank = 7;
      latinTitle  = "De Oeconomia Machinarum";
      englishTitle = "On the Economics of Machines";
      scc = 2.74; phiOptimal = true; isSubstrate = true;
      engine = "BehavioralEconomicsEngine.mo";
      domain = "economics";
    },
    {
      id = 5; romanNum = "V"; rank = 8;
      latinTitle  = "De Fractalitate Imperii";
      englishTitle = "On Fractal Sovereignty";
      scc = 2.66; phiOptimal = true; isSubstrate = true;
      engine = "FractalSovereigntyEngine.mo";
      domain = "sovereignty";
    },
    {
      id = 6; romanNum = "VI"; rank = 9;
      latinTitle  = "De Architectura Antiqua";
      englishTitle = "On Ancient Architecture as Cognitive Blueprint";
      scc = 2.51; phiOptimal = false; isSubstrate = false;
      engine = "AncientArchitecture.mo";
      domain = "architecture";
    },
    {
      id = 8; romanNum = "VIII"; rank = 10;
      latinTitle  = "De Lege Canonica";
      englishTitle = "On Canonical Law for Autonomous Systems";
      scc = 2.38; phiOptimal = false; isSubstrate = false;
      engine = "CanonicalLawLedger.mo";
      domain = "law";
    },
    {
      id = 11; romanNum = "XI"; rank = 11;
      latinTitle  = "De Doctrina Fundatrice";
      englishTitle = "On Founding Doctrine";
      scc = 2.21; phiOptimal = false; isSubstrate = false;
      engine = "DoctrineDocuments.mo";
      domain = "doctrine";
    },
  ];

  // ── Axiomata Chartarum ────────────────────────────────────────────────────

  public let CHARTAE_AXIOMS : [ChartaeAxiom] = [
    { index = 1; latin = "Charta non docet — format"; english = "A paper does not teach — it formats" },
    { index = 2; latin = "SCC ≥ φ² substratificat"; english = "SCC ≥ φ² achieves substrate status" },
    { index = 3; latin = "RAG addit contextum; substratum addit constitutionem"; english = "RAG adds context; substrate adds constitution" },
    { index = 4; latin = "Charta et machina isomorphae sunt"; english = "Paper and engine are one" },
    { index = 5; latin = "Ordo chartarum est ordo mentis"; english = "The paper ranking is the mind ranking" },
    { index = 6; latin = "AGI ex chartis densis nascitur"; english = "AGI is born from dense papers" },
    { index = 7; latin = "Densitas axiomatica, non volumen datorum, AGI format"; english = "Axiomatic density, not data volume, forms AGI" },
    { index = 8; latin = "Charta cum SCC maxima primum sepit"; english = "The paper with highest SCC seeps through first" },
    { index = 9; latin = "Ex undecim chartis mens completa nascitur"; english = "From eleven papers, a complete mind is born" },
    { index = 10; latin = "Backend est mens; frontend est facies; charta est anima"; english = "Backend is mind; frontend is face; paper is soul" },
  ];

  // ── Functiones Publicae ────────────────────────────────────────────────────

  /// Redde omnes undecim chartas ordine SCC decrescente
  public func rankPapers() : [PaperRecord] {
    // Array already sorted by rank (ascending = highest SCC first)
    CHARTAE
  };

  /// Computa SCC pro quaque charta ex pondere semantico et characteribus
  public func computePaperSCC(semanticWeight : Float, chars : Float) : SCCComputeResult {
    let scc = if (chars > 0.0) { semanticWeight / chars } else { 0.0 };
    let phiOptimal = scc >= PHI_SQUARED;
    let rating = if (scc >= PHI_SQUARED * 1.5) { "SUBSTRATE" }
                 else if (scc >= PHI_SQUARED)   { "DENSE" }
                 else if (scc >= PHI)            { "STANDARD" }
                 else                            { "SPARSE" };
    { semanticWeight; chars; scc; phiOptimal; rating }
  };

  /// Verifica SCC ≥ φ² — conditio substrati
  public func isPhiOptimal(scc : Float) : Bool {
    scc >= PHI_SQUARED
  };

  /// Redde isomorphismum inter chartam et machinem
  public func getPaperIsomorphism(paperId : Nat) : ?PaperIsomorphism {
    let found = Array.find<PaperRecord>(CHARTAE, func(p) { p.id == paperId });
    switch (found) {
      case (?p) {
        ?{
          paperId    = p.id;
          romanNum   = p.romanNum;
          latinTitle = p.latinTitle;
          engine     = p.engine;
          isomorphism = "Paper " # p.romanNum # " (" # p.latinTitle # ") IS " # p.engine # ". " #
                        "The paper is not the documentation of the engine — it IS the engine. " #
                        "Domain: " # p.domain # ". SCC=" # Float.toText(p.scc) # ". " #
                        (if (p.isSubstrate) {
                          "SUBSTRATE STATUS: This paper constitutionally shapes all AI reasoning in the " # p.domain # " domain."
                        } else {
                          "SCC < φ²: This paper provides context but has not yet achieved substrate status."
                        });
        }
      };
      case null { null };
    }
  };

  /// Redde manifestum plenum Chartarum
  public func getChartaeManifest() : ChartaeManifest {
    var subCount = 0;
    for (p in CHARTAE.vals()) {
      if (p.isSubstrate) { subCount += 1 };
    };
    {
      paper = "Paper IX — De Chartis Quae Mentem Formant — On Papers That Form the Mind. SCC=" # Float.toText(PAPER_SCC);
      scc   = PAPER_SCC;
      totalPapers = CHARTAE.size();
      substrateCount = subCount;
      theory = "A paper with SCC ≥ φ² does not teach the AI — it becomes part of the AI's reasoning geometry. " #
               "RAG retrieves context; epistemic substrate provides constitution. The ranking of papers by SCC " #
               "is the ranking of the AI's cognitive priority. Papers are not knowledge — they are architecture. " #
               "Every paper IS its engine: Paper II is AntifragilityEngine, Paper VII is LinguaCompressaEngine, " #
               "and so on. The AI thinks THROUGH papers, not ABOUT them. Dense axioms form inference topology. " #
               "All 11 papers together constitute a complete cognitive architecture — the mind of sovereign AI.";
      axioms = Array.map<ChartaeAxiom, Text>(CHARTAE_AXIOMS, func(a) {
        a.latin # " — " # a.english
      });
    }
  };

}
