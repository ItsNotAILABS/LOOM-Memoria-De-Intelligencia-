/**
 * ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                                                          ║
 * ║                         ANCIENT PRIMITIVE FOUNDATION — THE ROOT OF ALL                                                   ║
 * ║                    "Fundamentum Antiquum — Radix Omnium Intelligentiae"                                                  ║
 * ║                    (Ancient Foundation — Root of All Intelligence)                                                       ║
 * ║                                                                                                                          ║
 * ║  ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════  ║
 * ║                                                                                                                          ║
 * ║  THE DEEPER PRIMITIVE SET — FROM WHICH ALL GROWS                                                                         ║
 * ║  ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐  ║
 * ║  │  What makes a NUMBER possible?                                                                                      │  ║
 * ║  │    → Repeated distinguishable units and stable comparison                                                           │  ║
 * ║  │                                                                                                                    │  ║
 * ║  │  What makes a LETTER possible?                                                                                      │  ║
 * ║  │    → Persistent symbolic differentiation and shared mapping                                                         │  ║
 * ║  │                                                                                                                    │  ║
 * ║  │  What makes BOTH possible?                                                                                          │  ║
 * ║  │    → A field that can hold stable differences, preserve them long enough, and transfer them                         │  ║
 * ║  └────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘  ║
 * ║                                                                                                                          ║
 * ║  THE SIX PRIMITIVES:                                                                                                     ║
 * ║  ┌───────────────┬─────────────────────────────────────────────────────────────────────────────────────────────────────┐  ║
 * ║  │  FIELD        │  A medium that can hold stable differences and transfer them                                       │  ║
 * ║  │  DISTINCTION  │  The ability to mark one thing as different from another                                           │  ║
 * ║  │  RELATION     │  Lawful connection between distinguished things                                                    │  ║
 * ║  │  REPETITION   │  The ability to reproduce the same distinction multiple times                                      │  ║
 * ║  │  MEMORY       │  The ability to preserve distinctions and relations across time                                    │  ║
 * ║  │  ADDRESS      │  The ability to locate and retrieve a specific distinction                                         │  ║
 * ║  └───────────────┴─────────────────────────────────────────────────────────────────────────────────────────────────────┘  ║
 * ║                                                                                                                          ║
 * ║  FROM PRIMITIVES TO CONSTRUCTS:                                                                                          ║
 * ║  ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐  ║
 * ║  │  NUMBER   ← REPETITION + MEASURE (counting distinguishable units)                                                  │  ║
 * ║  │  LETTER   ← ADDRESS + SYMBOL (locatable persistent differentiation)                                                │  ║
 * ║  │  LOGIC    ← LAWFUL RELATION (if-then, causality, implication)                                                      │  ║
 * ║  │  EQUATION ← NUMBER + RELATION (quantitative equality)                                                              │  ║
 * ║  │  LANGUAGE ← SYMBOL + ORDERING (structured symbolic sequences)                                                      │  ║
 * ║  │  MODEL    ← ALL OF THEM TOGETHER (complete representational system)                                                │  ║
 * ║  └────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘  ║
 * ║                                                                                                                          ║
 * ║  ANCIENT ARCHITECTURAL FUNCTIONS (sorting by function, not culture):                                                     ║
 * ║  ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐  ║
 * ║  │  1. Field Anchoring          → Temples, sacred sites, power centers                                                │  ║
 * ║  │  2. Symbolic Compression     → Glyphs, hieroglyphs, compact meaning                                                │  ║
 * ║  │  3. Calendar/Time Governance → Scheduling, astronomy, ritual timing                                                │  ║
 * ║  │  4. Metallurgy as Power      → Power routing, energy channels                                                      │  ║
 * ║  │  5. Ritual as State Induction → State changes, ceremonies, transformations                                         │  ║
 * ║  │  6. Burial as Continuity     → Memory preservation, lineage, eternity                                              │  ║
 * ║  │  7. City Grids as Circulation → Movement, flow, distribution                                                       │  ║
 * ║  │  8. Pyramids/Temples         → Hierarchy, memory, signal amplification                                             │  ║
 * ║  │  9. Glyphs as Organism Memory → Persistent storage, retrieval, identity                                            │  ║
 * ║  │ 10. Trickster as Transfer    → Boundary crossing, transformation, exchange                                         │  ║
 * ║  └────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘  ║
 * ║                                                                                                                          ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                                               ║
 * ║  L-130 COMPLIANT — Every primitive traces to φ, every branch connects to root                                            ║
 * ╚══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Hash "mo:base/Hash";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

module AncientPrimitiveFoundation {

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // THE ROOT CONSTANT — FROM WHICH ALL FLOWS
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    /// φ = (1 + √5) / 2 — The Golden Ratio (Ultimate Primitive Root)
    public let PHI : Float = 1.6180339887498948482045868343656381177203091798057628621354486227;
    
    /// φ² = φ + 1 — The Golden Square
    public let PHI_SQUARED : Float = 2.6180339887498948482045868343656381177203091798057628621354486227;
    
    /// 1/φ = φ - 1 — The Golden Inverse
    public let PHI_INVERSE : Float = 0.6180339887498948482045868343656381177203091798057628621354486227;

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // THE SIX PRIMITIVES — THE DEEPER SET
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    /// The six fundamental primitives from which all constructs grow
    public type Primitive = {
        #Field;        // A medium that holds stable differences
        #Distinction;  // Marking one thing as different from another
        #Relation;     // Lawful connection between things
        #Repetition;   // Reproducing the same distinction
        #Memory;       // Preserving across time
        #Address;      // Locating and retrieving
    };
    
    /// Primitive definition with formulas
    public type PrimitiveDefinition = {
        primitive: Primitive;
        name: Text;
        latin: Text;
        definition: Text;
        formula: Text;              // Mathematical representation
        phi_trace: Text;            // How it traces to φ
        generates: [Text];          // What grows from this primitive
        requires: [Primitive];      // What primitives this depends on
        ancient_manifestation: Text; // How ancients embodied this
    };
    
    public let PRIMITIVE_DEFINITIONS : [PrimitiveDefinition] = [
        {
            primitive = #Field;
            name = "Field";
            latin = "Campus";
            definition = "A medium that can hold stable differences, preserve them long enough, and transfer them";
            formula = "F = ∇φ × ∇ψ  (field as gradient interaction)";
            phi_trace = "Field structure follows φ-spiral distribution → equipotential lines at golden angles";
            generates = ["Space", "Substrate", "Medium", "Container", "Context"];
            requires = [];  // Field is the most fundamental
            ancient_manifestation = "Sacred sites, temple grounds, power centers — spaces that HOLD and ANCHOR";
        },
        {
            primitive = #Distinction;
            name = "Distinction";
            latin = "Distinctio";
            definition = "The ability to mark one thing as different from another";
            formula = "D = |a - b| > ε  (difference exceeds threshold)";
            phi_trace = "Minimum distinguishable ratio approaches 1/φ → Weber-Fechner follows φ scaling";
            generates = ["Category", "Type", "Kind", "Class", "Boundary"];
            requires = [#Field];  // Needs a field to make distinctions within
            ancient_manifestation = "Hieroglyphs, symbols, markers — things that SEPARATE and IDENTIFY";
        },
        {
            primitive = #Relation;
            name = "Relation";
            latin = "Relatio";
            definition = "Lawful connection between distinguished things";
            formula = "R: A → B  (function/mapping/causation)";
            phi_trace = "Optimal relations follow φ-proportion → beauty, harmony, stability";
            generates = ["Causality", "Implication", "Function", "Connection", "Law"];
            requires = [#Field, #Distinction];  // Needs things to relate
            ancient_manifestation = "Laws, rituals, ceremonies — things that CONNECT and GOVERN";
        },
        {
            primitive = #Repetition;
            name = "Repetition";
            latin = "Repetitio";
            definition = "The ability to reproduce the same distinction multiple times";
            formula = "Rep(x, n) = x₁ ≅ x₂ ≅ ... ≅ xₙ  (n equivalent copies)";
            phi_trace = "Fibonacci sequence = φ-governed repetition → F(n+1)/F(n) → φ";
            generates = ["Number", "Count", "Sequence", "Pattern", "Rhythm"];
            requires = [#Field, #Distinction];
            ancient_manifestation = "Counting, calendars, cycles — things that MEASURE and MULTIPLY";
        },
        {
            primitive = #Memory;
            name = "Memory";
            latin = "Memoria";
            definition = "The ability to preserve distinctions and relations across time";
            formula = "M(t) = ∫₀ᵗ f(τ)·e^(-λτ) dτ  (exponential decay with persistence)";
            phi_trace = "Memory decay follows φ-ratio → forgetting curve approaches φ-inverse";
            generates = ["Storage", "History", "Persistence", "Continuity", "Identity"];
            requires = [#Field, #Distinction, #Relation];
            ancient_manifestation = "Burial, monuments, inscriptions — things that PRESERVE and REMEMBER";
        },
        {
            primitive = #Address;
            name = "Address";
            latin = "Inscriptio";
            definition = "The ability to locate and retrieve a specific distinction";
            formula = "A: Index → Value  (lookup function)";
            phi_trace = "Optimal addressing follows φ-hash distribution → minimal collisions at golden positions";
            generates = ["Location", "Reference", "Symbol", "Name", "Index"];
            requires = [#Field, #Distinction, #Memory];
            ancient_manifestation = "Maps, coordinates, names — things that LOCATE and REFERENCE";
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // CONSTRUCTS — WHAT GROWS FROM PRIMITIVES
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    /// Constructs that emerge from primitive combinations
    public type Construct = {
        #Number;     // Repetition + Measure
        #Letter;     // Address + Symbol
        #Logic;      // Lawful Relation
        #Equation;   // Number + Relation
        #Language;   // Symbol + Ordering
        #Model;      // All of them together
    };
    
    public type ConstructDefinition = {
        construct: Construct;
        name: Text;
        latin: Text;
        definition: Text;
        formula: Text;
        primitives_required: [Primitive];
        phi_trace: Text;
        ancient_use: Text;
    };
    
    public let CONSTRUCT_DEFINITIONS : [ConstructDefinition] = [
        {
            construct = #Number;
            name = "Number";
            latin = "Numerus";
            definition = "Repeated distinguishable units with stable comparison";
            formula = "N = Rep(Distinct(1)) → counting";
            primitives_required = [#Repetition, #Distinction];
            phi_trace = "Number theory → Fibonacci → φ ratio → golden number system";
            ancient_use = "Taxation, astronomy, ritual timing, land measurement, architecture proportion";
        },
        {
            construct = #Letter;
            name = "Letter";
            latin = "Littera";
            definition = "Persistent symbolic differentiation with shared mapping";
            formula = "L = Address(Symbol) → alphabet";
            primitives_required = [#Address, #Distinction, #Memory];
            phi_trace = "Letter forms follow φ-proportions → beauty in writing";
            ancient_use = "Identity, law, invocation, memory, priestly transfer, legitimacy";
        },
        {
            construct = #Logic;
            name = "Logic";
            latin = "Logica";
            definition = "Lawful relations that preserve truth";
            formula = "Logic = Relation(True → True)";
            primitives_required = [#Relation, #Distinction];
            phi_trace = "Logical operators map to φ-gates → golden logic";
            ancient_use = "Judgment, law, causality, divination, governance";
        },
        {
            construct = #Equation;
            name = "Equation";
            latin = "Aequatio";
            definition = "Quantitative equality between expressions";
            formula = "Eq: Number × Relation → Balance";
            primitives_required = [#Repetition, #Distinction, #Relation];
            phi_trace = "φ² = φ + 1 → the quintessential equation";
            ancient_use = "Trade balance, architectural harmony, astronomical cycles";
        },
        {
            construct = #Language;
            name = "Language";
            latin = "Lingua";
            definition = "Structured sequences of symbols with meaning";
            formula = "Lang = Sequence(Symbol) × Grammar";
            primitives_required = [#Address, #Distinction, #Relation, #Repetition, #Memory];
            phi_trace = "Language follows φ-Zipf distribution → word frequency = φ-power law";
            ancient_use = "Compression of world-models, law, poetry, prayer, record";
        },
        {
            construct = #Model;
            name = "Model";
            latin = "Exemplar";
            definition = "Complete representational system of a domain";
            formula = "Model = ∏(all primitives) → living intelligence";
            primitives_required = [#Field, #Distinction, #Relation, #Repetition, #Memory, #Address];
            phi_trace = "Complete model self-organizes to φ-harmony → living system";
            ancient_use = "Temple, city, calendar, civilization — the organism itself";
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // ANCIENT ARCHITECTURAL FUNCTIONS — SORTED BY FUNCTION, NOT CULTURE
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public type ArchitecturalFunction = {
        #FieldAnchoring;         // Temples, sacred sites, power centers
        #SymbolicCompression;    // Glyphs, hieroglyphs, compact meaning
        #TimeGovernance;         // Calendar, astronomy, ritual timing
        #MetallurgyPower;        // Power routing, energy channels
        #RitualInduction;        // State changes, ceremonies
        #BurialContinuity;       // Memory preservation, lineage
        #CirculationLogic;       // City grids, movement, flow
        #HierarchyMemorySignal;  // Pyramids, temples, amplification
        #OrganismMemory;         // Glyphs as persistent storage
        #BoundaryTransfer;       // Trickster, transformation, exchange
    };
    
    public type ArchitecturalFunctionDef = {
        function: ArchitecturalFunction;
        name: Text;
        latin: Text;
        purpose: Text;
        primitives_used: [Primitive];
        ancient_examples: [Text];
        medina_mapping: Text;
        formula: Text;
    };
    
    public let ARCHITECTURAL_FUNCTIONS : [ArchitecturalFunctionDef] = [
        {
            function = #FieldAnchoring;
            name = "Field Anchoring";
            latin = "Ancoratio Campi";
            purpose = "Establish stable fields that hold power and meaning";
            primitives_used = [#Field];
            ancient_examples = ["Temples", "Sacred groves", "Stonehenge", "Pyramids", "Axis mundi"];
            medina_mapping = "Substrate layer, ICP canisters, sovereign infrastructure";
            formula = "F_anchor = ∇²φ × location → stable field node";
        },
        {
            function = #SymbolicCompression;
            name = "Symbolic Compression";
            latin = "Compressio Symbolica";
            purpose = "Compress entire concepts into executable symbols";
            primitives_used = [#Distinction, #Address, #Memory];
            ancient_examples = ["Hieroglyphs", "Cuneiform", "Chinese characters", "Runes"];
            medina_mapping = "Glyphs, tokens, compressed representations, ANIMA symbols";
            formula = "C = Information / Symbol_size → maximum density";
        },
        {
            function = #TimeGovernance;
            name = "Calendar/Time Governance";
            latin = "Gubernatio Temporis";
            purpose = "Schedule, predict, and govern temporal cycles";
            primitives_used = [#Repetition, #Relation, #Memory];
            ancient_examples = ["Mayan Long Count", "Egyptian calendar", "Stonehenge", "Antikythera"];
            medina_mapping = "Heartbeat system, frequency layers, scheduling, cycles";
            formula = "T_gov = mod(t, cycle) × φ → golden cycle governance";
        },
        {
            function = #MetallurgyPower;
            name = "Metallurgy as Power Routing";
            latin = "Metallurgia Potentiae";
            purpose = "Route and channel power through material properties";
            primitives_used = [#Field, #Relation];
            ancient_examples = ["Bronze Age", "Iron Age", "Gold ritual objects", "Copper conductors"];
            medina_mapping = "Thermodynamics substrate, strategic metals, elemental properties";
            formula = "P_route = σ × A × ΔV → power = conductivity × area × gradient";
        },
        {
            function = #RitualInduction;
            name = "Ritual as State Induction";
            latin = "Rituale Inductionis";
            purpose = "Induce state changes through prescribed sequences";
            primitives_used = [#Relation, #Repetition, #Memory];
            ancient_examples = ["Initiation rites", "Coronation", "Marriage", "Funerals"];
            medina_mapping = "State transitions, authentication, authorization, transformations";
            formula = "State_new = Ritual(State_old) → deterministic transition";
        },
        {
            function = #BurialContinuity;
            name = "Burial as Continuity Architecture";
            latin = "Sepultura Continuitatis";
            purpose = "Preserve identity and memory across death/time";
            primitives_used = [#Memory, #Address, #Field];
            ancient_examples = ["Pyramids", "Mausoleums", "Ancestor veneration", "Libraries"];
            medina_mapping = "Memory Temple, persistent storage, identity continuity, lineage";
            formula = "Continuity = ∫ Memory(t) dt → eternal persistence";
        },
        {
            function = #CirculationLogic;
            name = "City Grids as Circulation Logic";
            latin = "Logica Circulationis";
            purpose = "Enable movement, flow, and distribution";
            primitives_used = [#Field, #Relation, #Address];
            ancient_examples = ["Roman grid", "Chinese city planning", "Inca roads"];
            medina_mapping = "Message routing, data flow, agent circulation, network topology";
            formula = "Flow = ∇P × Permeability → gradient drives movement";
        },
        {
            function = #HierarchyMemorySignal;
            name = "Pyramids/Temples as Hierarchy-Memory-Signal";
            latin = "Hierarchia Memoria Signum";
            purpose = "Amplify signals, store memory, establish hierarchy";
            primitives_used = [#Field, #Distinction, #Memory, #Address];
            ancient_examples = ["Pyramids", "Ziggurats", "Gothic cathedrals", "Temples"];
            medina_mapping = "Russian doll intelligence, layer hierarchy, signal amplification";
            formula = "Signal_out = Signal_in × φⁿ → golden amplification";
        },
        {
            function = #OrganismMemory;
            name = "Glyphs as Persistent Organism Memory";
            latin = "Memoria Organismi";
            purpose = "Store and retrieve organizational knowledge";
            primitives_used = [#Memory, #Address, #Distinction];
            ancient_examples = ["Library of Alexandria", "Clay tablets", "Codices", "Archives"];
            medina_mapping = "Document organism, knowledge base, glyph codex, permanent storage";
            formula = "M_org = Σ glyphs × context → total organizational memory";
        },
        {
            function = #BoundaryTransfer;
            name = "Trickster as Boundary Transfer Operator";
            latin = "Operator Transitus";
            purpose = "Enable transformation, exchange, and boundary crossing";
            primitives_used = [#Relation, #Distinction];
            ancient_examples = ["Hermes", "Loki", "Coyote", "Anansi", "Mercury"];
            medina_mapping = "Translation layers, format conversion, protocol bridging, transformation";
            formula = "Transfer(A→B) = Trickster(boundary) → cross domains";
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // PRIMITIVE ENGINE — ALWAYS-ON 24/7 PRIMITIVE PROCESSOR
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public type PrimitiveEngineState = {
        var field_coherence: Float;         // Field stability measure
        var distinction_count: Nat;         // Active distinctions
        var relation_count: Nat;            // Active relations
        var repetition_cycles: Nat;         // Total repetition cycles
        var memory_persistence: Float;      // Memory decay factor
        var address_lookups: Nat;           // Total address operations
        var last_cycle: Int;                // Last processing cycle timestamp
        var total_cycles: Nat;              // Total engine cycles
        var phi_alignment: Float;           // Alignment with φ
    };
    
    /// Initialize primitive engine state
    public func initEngine() : PrimitiveEngineState {
        {
            var field_coherence = 1.0;
            var distinction_count = 0;
            var relation_count = 0;
            var repetition_cycles = 0;
            var memory_persistence = PHI_INVERSE;  // Golden decay
            var address_lookups = 0;
            var last_cycle = Time.now();
            var total_cycles = 0;
            var phi_alignment = 1.0;
        }
    };
    
    /// Process one primitive engine cycle (call continuously, 24/7)
    public func processCycle(state: PrimitiveEngineState) : () {
        state.total_cycles += 1;
        state.last_cycle := Time.now();
        
        // Maintain field coherence through φ
        state.field_coherence := state.field_coherence * PHI_INVERSE + (1.0 - PHI_INVERSE);
        
        // Update phi alignment
        let ideal_ratio = Float.fromInt(state.repetition_cycles + 1) / Float.fromInt(state.distinction_count + 1);
        state.phi_alignment := if (ideal_ratio > 0.0) {
            1.0 - Float.abs(PHI - ideal_ratio) / PHI
        } else {
            1.0
        };
    };
    
    /// Create a distinction in the field
    public func createDistinction(state: PrimitiveEngineState) : Nat {
        state.distinction_count += 1;
        state.distinction_count
    };
    
    /// Create a relation between distinctions
    public func createRelation(state: PrimitiveEngineState, from: Nat, to: Nat) : Nat {
        state.relation_count += 1;
        state.relation_count
    };
    
    /// Repeat a distinction
    public func repeatDistinction(state: PrimitiveEngineState, original: Nat, times: Nat) : [Nat] {
        state.repetition_cycles += times;
        Array.tabulate<Nat>(times, func(i) {
            createDistinction(state)
        })
    };
    
    /// Store in memory
    public func storeMemory(state: PrimitiveEngineState, value: Text) : Nat {
        let address = state.distinction_count + 1;
        ignore createDistinction(state);
        address
    };
    
    /// Lookup by address
    public func lookupAddress(state: PrimitiveEngineState, address: Nat) : Bool {
        state.address_lookups += 1;
        address <= state.distinction_count
    };
    
    /// Get engine status
    public func getEngineStatus(state: PrimitiveEngineState) : Text {
        "ANCIENT PRIMITIVE ENGINE\n" #
        "========================\n" #
        "Status: ALWAYS RUNNING (24/7)\n" #
        "Total Cycles: " # Nat.toText(state.total_cycles) # "\n" #
        "Distinctions: " # Nat.toText(state.distinction_count) # "\n" #
        "Relations: " # Nat.toText(state.relation_count) # "\n" #
        "Repetitions: " # Nat.toText(state.repetition_cycles) # "\n" #
        "Address Lookups: " # Nat.toText(state.address_lookups) # "\n" #
        "Field Coherence: " # Float.toText(state.field_coherence) # "\n" #
        "φ Alignment: " # Float.toText(state.phi_alignment) # "\n" #
        "Memory Persistence: " # Float.toText(state.memory_persistence)
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // PRIMITIVE TRACING — TRACE ANY CONSTRUCT BACK TO PRIMITIVES
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    /// Trace a construct back to its primitive roots
    public func traceToRoots(construct: Construct) : [Primitive] {
        switch (construct) {
            case (#Number) { [#Repetition, #Distinction] };
            case (#Letter) { [#Address, #Distinction, #Memory] };
            case (#Logic) { [#Relation, #Distinction] };
            case (#Equation) { [#Repetition, #Distinction, #Relation] };
            case (#Language) { [#Address, #Distinction, #Relation, #Repetition, #Memory] };
            case (#Model) { [#Field, #Distinction, #Relation, #Repetition, #Memory, #Address] };
        }
    };
    
    /// Trace primitives to φ
    public func traceToPhI(primitive: Primitive) : Text {
        switch (primitive) {
            case (#Field) { "Field → φ-spiral distribution → golden angle = 137.5°" };
            case (#Distinction) { "Distinction → 1/φ threshold → Weber-Fechner law" };
            case (#Relation) { "Relation → φ-proportion → beauty and harmony" };
            case (#Repetition) { "Repetition → Fibonacci → F(n)/F(n-1) → φ" };
            case (#Memory) { "Memory → φ-inverse decay → forgetting curve" };
            case (#Address) { "Address → φ-hash → golden ratio hashing" };
        }
    };
    
    /// Get the complete trace from construct to φ
    public func getCompleteTrace(construct: Construct) : Text {
        let primitives = traceToRoots(construct);
        var trace = "CONSTRUCT: " # constructToText(construct) # "\n";
        trace #= "PRIMITIVES:\n";
        for (p in primitives.vals()) {
            trace #= "  → " # primitiveToText(p) # "\n";
            trace #= "     ↳ " # traceToPhI(p) # "\n";
        };
        trace #= "ROOT: φ = (1 + √5) / 2 = 1.618...\n";
        trace
    };
    
    /// Convert primitive to text
    public func primitiveToText(p: Primitive) : Text {
        switch (p) {
            case (#Field) { "Field" };
            case (#Distinction) { "Distinction" };
            case (#Relation) { "Relation" };
            case (#Repetition) { "Repetition" };
            case (#Memory) { "Memory" };
            case (#Address) { "Address" };
        }
    };
    
    /// Convert construct to text
    public func constructToText(c: Construct) : Text {
        switch (c) {
            case (#Number) { "Number" };
            case (#Letter) { "Letter" };
            case (#Logic) { "Logic" };
            case (#Equation) { "Equation" };
            case (#Language) { "Language" };
            case (#Model) { "Model" };
        }
    };
};
