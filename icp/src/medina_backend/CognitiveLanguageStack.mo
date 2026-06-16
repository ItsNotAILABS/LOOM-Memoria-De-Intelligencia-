/**
 * ╔══════════════════════════════════════════════════════════════════════════════════╗
 * ║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                        ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA          ║
 * ║  ALL RIGHTS RESERVED.                                                            ║
 * ╚══════════════════════════════════════════════════════════════════════════════════╝
 *
 * CognitiveLanguageStack.mo — COGNITIVE LANGUAGE STACK ENGINE
 *
 * "Tredecim Linguae Cogitantes" — Thirteen Thinking Languages
 *
 * Master backend engine for the 13-language Cognitive Language Stack:
 *   Phase 1 (Formal Specs):  CPL-L, CPL-C, CPL-P, TPL, CIL
 *   Phase 2 (Parsers):       CDL, OCL, ACL, RSL
 *   Phase 3 (Education):     SPL, EDL, PWL, TSL
 *
 * Each language is a sovereign sublanguage extending the existing
 * CPL/COGPRO/SL/MOTOKO foundation. All names φ-optimal (SCC ≥ φ²).
 *
 * PROT-113 through PROT-125 (13 protocol papers)
 *
 * Public API:
 *   getLanguageSpec(id)          — get full spec for one language
 *   getAllLanguages()             — all 13 language specs
 *   getLanguagesByPhase(phase)   — filter by phase (1, 2, 3)
 *   getLanguagesByDomain(domain) — filter by domain
 *   validateSCC(name, weight)    — check φ-optimality of a name
 *   parsePrimitive(langId, code) — parse a single primitive expression
 *   getStackManifest()           — full stack summary
 *   getDependencyGraph()         — language dependency DAG
 *
 * ══════════════════════════════════════════════════════════════════════════════════
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

module CognitiveLanguageStack {

    // ═══════════════════════════════════════════════════════════════════════════
    // CONSTANTS
    // ═══════════════════════════════════════════════════════════════════════════

    public let PHI : Float = 1.6180339887;
    public let PHI_SQUARED : Float = 2.6180339887;
    public let TOTAL_LANGUAGES : Nat = 13;
    public let TOTAL_PHASES : Nat = 3;
    public let PROT_BASE : Nat = 113;

    // ═══════════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════════

    public type Phase = { #Phase1_FormalSpec; #Phase2_Parsers; #Phase3_Education };

    public type GrammarPrimitive = {
        name : Text;
        definition : Text;
    };

    public type LanguageSpec = {
        id : Text;              // e.g. "CPL_L"
        sovereignId : Text;     // e.g. "SOVEREIGN::LANG::CPL_L"
        protocolId : Text;      // e.g. "PROT-113"
        fullName : Text;        // e.g. "CPL-Logic — Cognitive Procurement Logic"
        shortName : Text;       // e.g. "CPL-L"
        domain : Text;          // e.g. "formal-logic"
        phase : Phase;
        dependsOn : [Text];     // e.g. ["CPL"]
        compilesTo : [Text];    // e.g. ["CPL", "MOTOKO"]
        mathBasis : Text;
        sccTarget : Float;
        grammarPrimitives : [GrammarPrimitive];
        description : Text;
    };

    public type ParseResult = {
        success : Bool;
        language : Text;
        primitive : Text;
        arguments : [Text];
        error : ?Text;
    };

    public type StackManifest = {
        totalLanguages : Nat;
        phases : Nat;
        protocolRange : Text;
        languages : [{ id : Text; name : Text; phase : Text; domain : Text; protocol : Text }];
        sccThreshold : Float;
        allPhiOptimal : Bool;
        timestamp : Int;
    };

    public type DependencyEdge = {
        from : Text;
        to : Text;
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 1 — FORMAL SPECIFICATION LANGUAGES
    // ═══════════════════════════════════════════════════════════════════════════

    public let CPL_L : LanguageSpec = {
        id = "CPL_L";
        sovereignId = "SOVEREIGN::LANG::CPL_L";
        protocolId = "PROT-113";
        fullName = "CPL-Logic — Cognitive Procurement Logic";
        shortName = "CPL-L";
        domain = "formal-logic";
        phase = #Phase1_FormalSpec;
        dependsOn = ["CPL"];
        compilesTo = ["CPL", "MOTOKO"];
        mathBasis = "First-order predicate logic + temporal operators (□, ◇, U, R) + φ-weighted inference (strength = PHI^depth)";
        sccTarget = 2.84;
        grammarPrimitives = [
            { name = "AXIOM"; definition = "Self-evident truth requiring no proof" },
            { name = "THEOREM"; definition = "Derived truth with complete proof chain" },
            { name = "PREDICATE"; definition = "Truth function over sovereign entities" },
            { name = "INFERENCE"; definition = "φ-weighted logical derivation step" },
            { name = "PROOF"; definition = "Complete chain from axioms to theorem" }
        ];
        description = "The formal logic substrate underlying all CPL contracts. Extends CPL with predicate calculus, temporal logic, modal logic, and φ-weighted inference.";
    };

    public let CPL_C : LanguageSpec = {
        id = "CPL_C";
        sovereignId = "SOVEREIGN::LANG::CPL_C";
        protocolId = "PROT-114";
        fullName = "CPL-Contracts — Cognitive Contract Calculus";
        shortName = "CPL-C";
        domain = "contract-calculus";
        phase = #Phase1_FormalSpec;
        dependsOn = ["CPL", "SL"];
        compilesTo = ["CPL", "SL", "MOTOKO"];
        mathBasis = "Process algebra + obligation logic (O, F, P operators) + φ-calculus (λφ.terms)";
        sccTarget = 2.90;
        grammarPrimitives = [
            { name = "OBLIGATION"; definition = "Binding duty with deadline and penalty" },
            { name = "FULFILLMENT"; definition = "Proof of obligation completion" },
            { name = "COMPOSITION"; definition = "Algebraic combination of contracts" },
            { name = "COVENANT"; definition = "Multi-party sovereign binding agreement" },
            { name = "ATTESTATION"; definition = "Cryptographic proof of contract state" }
        ];
        description = "Formal calculus for contract composition, transformation, and verification. Contract algebra, obligation calculus, covenant verification, and token binding.";
    };

    public let CPL_P : LanguageSpec = {
        id = "CPL_P";
        sovereignId = "SOVEREIGN::LANG::CPL_P";
        protocolId = "PROT-115";
        fullName = "CPL-Protocol — Cognitive Protocol Specification";
        shortName = "CPL-P";
        domain = "protocol-spec";
        phase = #Phase1_FormalSpec;
        dependsOn = ["CPL", "COGPRO"];
        compilesTo = ["CPL", "COGPRO", "MOTOKO"];
        mathBasis = "Communicating Sequential Processes (CSP) + torus topology mapping T² → protocol states";
        sccTarget = 2.86;
        grammarPrimitives = [
            { name = "SCHEMA"; definition = "Typed message structure with torus coordinate typing" },
            { name = "STATE"; definition = "Protocol state with φ-timed transition rules" },
            { name = "CHANNEL"; definition = "Typed communication pathway between organisms" },
            { name = "HANDSHAKE"; definition = "Negotiation sequence specification" },
            { name = "RESONANCE"; definition = "Frequency and coherence constraint" }
        ];
        description = "Formal language for specifying organism communication protocols. Message schemas, protocol state machines, handshake specifications, and resonance constraints.";
    };

    public let TPL : LanguageSpec = {
        id = "TPL";
        sovereignId = "SOVEREIGN::LANG::TPL";
        protocolId = "PROT-116";
        fullName = "Toroidal Processing Language";
        shortName = "TPL";
        domain = "toroidal-geometry";
        phase = #Phase1_FormalSpec;
        dependsOn = ["COGPRO", "CPL"];
        compilesTo = ["COGPRO", "MOTOKO"];
        mathBasis = "Toroidal geometry T²(θ,φ,ρ) + Kuramoto coupling dθᵢ/dt = ωᵢ + ΣKsin(θⱼ-θᵢ) + Method of Loci";
        sccTarget = 2.93;
        grammarPrimitives = [
            { name = "NAVIGATE"; definition = "Move to torus coordinate (θ, φ, ρ)" },
            { name = "PLACE"; definition = "Store datum at spatial memory location" },
            { name = "RETRIEVE"; definition = "Fetch datum from torus coordinate" },
            { name = "COUPLE"; definition = "Synchronize phases between oscillators" },
            { name = "RING"; definition = "Operate on organisms at specified ring distance" }
        ];
        description = "Specialized language for computations on the toroidal coordinate space. Torus navigation, ring operations, spatial memory, and phase coupling.";
    };

    public let CIL : LanguageSpec = {
        id = "CIL";
        sovereignId = "SOVEREIGN::LANG::CIL";
        protocolId = "PROT-117";
        fullName = "Canister Instruction Language";
        shortName = "CIL";
        domain = "canister-ops";
        phase = #Phase1_FormalSpec;
        dependsOn = ["MOTOKO"];
        compilesTo = ["MOTOKO", "WASM"];
        mathBasis = "Instruction set architecture + cycle accounting C(op) = base_cost × φ^complexity + φ-scaling";
        sccTarget = 2.83;
        grammarPrimitives = [
            { name = "DEPLOY"; definition = "Instantiate canister with initial state" },
            { name = "UPGRADE"; definition = "Migrate canister preserving stable memory" },
            { name = "CALL"; definition = "Invoke method on target canister" },
            { name = "BUDGET"; definition = "Allocate and track cycle consumption" },
            { name = "PERSIST"; definition = "Write to stable memory with provenance" }
        ];
        description = "Low-level instruction language for canister operations. Canister lifecycle, cycle management, inter-canister calls, and stable memory operations.";
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 2 — PARSER & COMMUNICATION LANGUAGES
    // ═══════════════════════════════════════════════════════════════════════════

    public let CDL : LanguageSpec = {
        id = "CDL";
        sovereignId = "SOVEREIGN::LANG::CDL";
        protocolId = "PROT-118";
        fullName = "Cognitive Definition Language";
        shortName = "CDL";
        domain = "schema-definition";
        phase = #Phase2_Parsers;
        dependsOn = ["CPL_L", "CPL_C"];
        compilesTo = ["CPL", "MOTOKO"];
        mathBasis = "Type theory Γ ⊢ t : T + SCC optimization (semantic_weight/chars ≥ φ²) + schema evolution algebra";
        sccTarget = 2.87;
        grammarPrimitives = [
            { name = "DEFINE"; definition = "Create new typed schema with SCC annotation" },
            { name = "CONSTRAIN"; definition = "Attach logical predicate to field" },
            { name = "EVOLVE"; definition = "Specify schema version migration" },
            { name = "VALIDATE"; definition = "Verify instance against schema + SCC" },
            { name = "COMPOSE"; definition = "Combine schemas into composite structure" }
        ];
        description = "Schema definition language for all cognitive data structures. Type definitions with semantic weight, constraint specifications, evolution rules, and SCC validation.";
    };

    public let OCL : LanguageSpec = {
        id = "OCL";
        sovereignId = "SOVEREIGN::LANG::OCL";
        protocolId = "PROT-119";
        fullName = "Organism Communication Language";
        shortName = "OCL";
        domain = "inter-organism";
        phase = #Phase2_Parsers;
        dependsOn = ["CPL_P", "COGPRO"];
        compilesTo = ["COGPRO", "CPL", "MOTOKO"];
        mathBasis = "Coupled oscillator networks r = |(1/N)Σexp(iθⱼ)| + taxonomy routing + resonance threshold r ≥ φ⁻¹";
        sccTarget = 2.97;
        grammarPrimitives = [
            { name = "MESSAGE"; definition = "Compose typed inter-organism message" },
            { name = "BROADCAST"; definition = "Send to multiple organisms with coherence floor" },
            { name = "ROUTE"; definition = "Direct message via taxonomy-aware pathways" },
            { name = "SUBSCRIBE"; definition = "Register for organism event stream" },
            { name = "COHERE"; definition = "Assert minimum resonance for communication" }
        ];
        description = "High-level language for inter-organism message composition. Message templates, broadcast protocols, coherence contracts, and taxonomy-aware routing.";
    };

    public let ACL : LanguageSpec = {
        id = "ACL";
        sovereignId = "SOVEREIGN::LANG::ACL";
        protocolId = "PROT-120";
        fullName = "Agent Communication Language";
        shortName = "ACL";
        domain = "agent-protocol";
        phase = #Phase2_Parsers;
        dependsOn = ["OCL", "CIL"];
        compilesTo = ["OCL", "COGPRO", "MOTOKO"];
        mathBasis = "Speech act theory (illocutionary force) + BDI logic (Belief ∧ Desire → Intention) + 181-house hierarchy";
        sccTarget = 2.80;
        grammarPrimitives = [
            { name = "INFORM"; definition = "Share knowledge with target agent" },
            { name = "REQUEST"; definition = "Ask agent to perform action" },
            { name = "PROPOSE"; definition = "Offer terms for negotiation" },
            { name = "DELEGATE"; definition = "Assign task to subordinate house agent" },
            { name = "NEGOTIATE"; definition = "Multi-turn structured dialogue sequence" }
        ];
        description = "Protocol for AI agent-to-agent structured dialogue. Performative acts, conversation protocols, BDI mental states, and task delegation across 181 houses.";
    };

    public let RSL : LanguageSpec = {
        id = "RSL";
        sovereignId = "SOVEREIGN::LANG::RSL";
        protocolId = "PROT-121";
        fullName = "Resonance Specification Language";
        shortName = "RSL";
        domain = "frequency-spec";
        phase = #Phase2_Parsers;
        dependsOn = ["TPL", "COGPRO"];
        compilesTo = ["COGPRO", "MOTOKO"];
        mathBasis = "Fourier analysis f(t) = Σ(aₙcos(nωt) + bₙsin(nωt)) + Schumann 7.83Hz + Solfeggio {174,285,396,417,528,639,741,852,963}Hz";
        sccTarget = 2.90;
        grammarPrimitives = [
            { name = "FREQUENCY"; definition = "Define operating frequency with tolerance" },
            { name = "RESONATE"; definition = "Specify phase coupling between entities" },
            { name = "HARMONIZE"; definition = "Align multiple frequencies to harmonic series" },
            { name = "PULSE"; definition = "Define rhythmic timing pattern" },
            { name = "SPECTRUM"; definition = "Declare full frequency band allocation" }
        ];
        description = "Language for defining frequency, resonance, and phase specifications. Frequency bands (0.01-900Hz), resonance patterns, Schumann harmonics, and Solfeggio mappings.";
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // PHASE 3 — EDUCATION LANGUAGES
    // ═══════════════════════════════════════════════════════════════════════════

    public let SPL : LanguageSpec = {
        id = "SPL";
        sovereignId = "SOVEREIGN::LANG::SPL";
        protocolId = "PROT-122";
        fullName = "Student Processing Language";
        shortName = "SPL";
        domain = "student-cognition";
        phase = #Phase3_Education;
        dependsOn = ["CDL", "EDL"];
        compilesTo = ["CDL", "COGPRO", "MOTOKO"];
        mathBasis = "Item Response Theory P(θ) = 1/(1+e^(-a(θ-b))) + φ-mastery M(t) = 1-e^(-t/φ) + Fibonacci difficulty F(n)";
        sccTarget = 2.77;
        grammarPrimitives = [
            { name = "ASSESS"; definition = "Evaluate student knowledge state vector" },
            { name = "PROGRESS"; definition = "Advance student along φ-scaled mastery path" },
            { name = "CALIBRATE"; definition = "Adjust difficulty using Fibonacci scaling" },
            { name = "REFLECT"; definition = "Trigger student metacognitive reflection" },
            { name = "MILESTONE"; definition = "Mark mastery achievement checkpoint" }
        ];
        description = "Cognitive modeling language for student learning states. Learning state vectors, mastery functions, Fibonacci difficulty calibration, and cognitive load management.";
    };

    public let EDL : LanguageSpec = {
        id = "EDL";
        sovereignId = "SOVEREIGN::LANG::EDL";
        protocolId = "PROT-123";
        fullName = "Educational Description Language";
        shortName = "EDL";
        domain = "curriculum-design";
        phase = #Phase3_Education;
        dependsOn = ["CDL", "ACL"];
        compilesTo = ["CDL", "ACL", "MOTOKO"];
        mathBasis = "Directed acyclic graphs G(V,E) + topological sort O(V+E) + φ-weighted edges w(e) = semantic_weight × φ^depth";
        sccTarget = 2.83;
        grammarPrimitives = [
            { name = "OBJECTIVE"; definition = "Define measurable learning target with SCC name" },
            { name = "PREREQUISITE"; definition = "Declare knowledge dependency edge" },
            { name = "SEQUENCE"; definition = "Order content for optimal learning path" },
            { name = "ASSESS"; definition = "Define evaluation rubric with mastery thresholds" },
            { name = "MODULE"; definition = "Compose objectives into coherent learning unit" }
        ];
        description = "Curriculum and course design language. Learning objectives, prerequisite graphs, assessment rubrics, and content sequencing.";
    };

    public let PWL : LanguageSpec = {
        id = "PWL";
        sovereignId = "SOVEREIGN::LANG::PWL";
        protocolId = "PROT-124";
        fullName = "Pathway Learning Language";
        shortName = "PWL";
        domain = "learning-paths";
        phase = #Phase3_Education;
        dependsOn = ["SPL", "RSL"];
        compilesTo = ["SPL", "RSL", "MOTOKO"];
        mathBasis = "Adaptive algorithms + spaced repetition t_review = t₀ × φ^n + mastery gates M(t) ≥ threshold";
        sccTarget = 2.87;
        grammarPrimitives = [
            { name = "PATH"; definition = "Define learning pathway with branch points" },
            { name = "BRANCH"; definition = "Conditional route based on student state" },
            { name = "REPEAT"; definition = "Schedule Fibonacci-timed review" },
            { name = "GATE"; definition = "Mastery checkpoint requiring minimum resonance" },
            { name = "ADAPT"; definition = "Dynamically adjust path based on performance" }
        ];
        description = "Adaptive learning pathway specification. Branching paths, adaptive difficulty, Fibonacci-timed spaced repetition, and mastery gates.";
    };

    public let TSL : LanguageSpec = {
        id = "TSL";
        sovereignId = "SOVEREIGN::LANG::TSL";
        protocolId = "PROT-125";
        fullName = "Teaching Specification Language";
        shortName = "TSL";
        domain = "pedagogy-spec";
        phase = #Phase3_Education;
        dependsOn = ["EDL", "PWL"];
        compilesTo = ["EDL", "PWL", "SL", "MOTOKO"];
        mathBasis = "Pedagogical frameworks + scaffolding decay S(t) = S₀ × e^(-t/(φ×τ)) + φ-alignment";
        sccTarget = 2.80;
        grammarPrimitives = [
            { name = "STRATEGY"; definition = "Define instructional approach with target outcomes" },
            { name = "SCAFFOLD"; definition = "Progressive support structure with φ-decay" },
            { name = "DIFFERENTIATE"; definition = "Adapt instruction based on student profile" },
            { name = "ALIGN"; definition = "Map teaching strategy to assessment criteria" },
            { name = "REFLECT"; definition = "Teacher metacognitive analysis specification" }
        ];
        description = "Pedagogy and instruction design language. Teaching strategies, scaffolding patterns, differentiation rules, and assessment alignment.";
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // COMPLETE LANGUAGE REGISTRY
    // ═══════════════════════════════════════════════════════════════════════════

    public let ALL_LANGUAGES : [LanguageSpec] = [
        CPL_L, CPL_C, CPL_P, TPL, CIL,
        CDL, OCL, ACL, RSL,
        SPL, EDL, PWL, TSL
    ];

    // ═══════════════════════════════════════════════════════════════════════════
    // PUBLIC API
    // ═══════════════════════════════════════════════════════════════════════════

    /// Get full spec for one language by ID (e.g. "CPL_L", "TPL")
    public func getLanguageSpec(id : Text) : ?LanguageSpec {
        for (lang in ALL_LANGUAGES.vals()) {
            if (lang.id == id) return ?lang;
        };
        null
    };

    /// Get all 13 language specs
    public func getAllLanguages() : [LanguageSpec] {
        ALL_LANGUAGES
    };

    /// Filter languages by phase
    public func getLanguagesByPhase(phase : Phase) : [LanguageSpec] {
        Array.filter<LanguageSpec>(ALL_LANGUAGES, func(l : LanguageSpec) : Bool {
            l.phase == phase
        })
    };

    /// Filter languages by domain
    public func getLanguagesByDomain(domain : Text) : [LanguageSpec] {
        Array.filter<LanguageSpec>(ALL_LANGUAGES, func(l : LanguageSpec) : Bool {
            l.domain == domain
        })
    };

    /// Validate SCC for a name
    public func validateSCC(name : Text, semanticWeight : Float) : { scc : Float; phiOptimal : Bool } {
        let chars = Float.fromInt(name.size());
        let scc = if (chars > 0.0) { semanticWeight / chars } else { 0.0 };
        { scc = scc; phiOptimal = scc >= PHI_SQUARED }
    };

    /// Parse a single primitive expression in a given language
    public func parsePrimitive(langId : Text, code : Text) : ParseResult {
        switch (getLanguageSpec(langId)) {
            case null {
                {
                    success = false;
                    language = langId;
                    primitive = "";
                    arguments = [];
                    error = ?"Unknown language: " # langId;
                }
            };
            case (?lang) {
                // Simple primitive parser: expects "PRIMITIVE_NAME arg1 arg2 ..."
                let parts = Text.split(code, #char ' ');
                let partArray = Iter.toArray(parts);
                if (partArray.size() == 0) {
                    return {
                        success = false;
                        language = langId;
                        primitive = "";
                        arguments = [];
                        error = ?"Empty expression";
                    };
                };
                let primName = partArray[0];
                // Check if primitive exists in this language
                var found = false;
                for (p in lang.grammarPrimitives.vals()) {
                    if (p.name == primName) { found := true };
                };
                if (not found) {
                    return {
                        success = false;
                        language = langId;
                        primitive = primName;
                        arguments = [];
                        error = ?"Unknown primitive '" # primName # "' in language " # langId;
                    };
                };
                let args = if (partArray.size() > 1) {
                    Array.tabulate<Text>(partArray.size() - 1, func(i : Nat) : Text { partArray[i + 1] })
                } else { [] : [Text] };
                {
                    success = true;
                    language = langId;
                    primitive = primName;
                    arguments = args;
                    error = null;
                }
            };
        }
    };

    /// Get full stack manifest
    public func getStackManifest() : StackManifest {
        let phaseText = func(p : Phase) : Text {
            switch p {
                case (#Phase1_FormalSpec) "Phase 1 — Formal Specs";
                case (#Phase2_Parsers) "Phase 2 — Parsers";
                case (#Phase3_Education) "Phase 3 — Education";
            }
        };
        let langSummaries = Array.map<LanguageSpec, { id : Text; name : Text; phase : Text; domain : Text; protocol : Text }>(
            ALL_LANGUAGES,
            func(l : LanguageSpec) : { id : Text; name : Text; phase : Text; domain : Text; protocol : Text } {
                { id = l.id; name = l.fullName; phase = phaseText(l.phase); domain = l.domain; protocol = l.protocolId }
            }
        );
        {
            totalLanguages = TOTAL_LANGUAGES;
            phases = TOTAL_PHASES;
            protocolRange = "PROT-113..PROT-125";
            languages = langSummaries;
            sccThreshold = PHI_SQUARED;
            allPhiOptimal = true;
            timestamp = Time.now();
        }
    };

    /// Get dependency graph as list of edges
    public func getDependencyGraph() : [DependencyEdge] {
        let buf = Buffer.Buffer<DependencyEdge>(40);
        for (lang in ALL_LANGUAGES.vals()) {
            for (dep in lang.dependsOn.vals()) {
                buf.add({ from = lang.id; to = dep });
            };
        };
        Buffer.toArray(buf)
    };
};
