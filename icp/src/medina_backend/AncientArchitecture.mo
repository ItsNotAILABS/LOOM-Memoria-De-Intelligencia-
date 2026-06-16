/**
 * MEDINA Ancient Architecture Module — Pattern Synthesis Engine
 * 
 * This module encodes the synthesis of ancient civilization architecture patterns
 * into MEDINA's runtime substrate. It serves as the bridge between timeless
 * architectural wisdom and executable canister intelligence.
 * 
 * PATTERN DOMAINS:
 *   1. Canon-Before-Execution    → Law/gate/governance sequencing
 *   2. Initiatory Translation    → Sandbox M92..M95 staging
 *   3. Memory Geometry           → Toroidal coordinate topology
 *   4. Harmonic Calibration      → Climate + frequency ladder + resonance
 *   5. Dual Witness Mechanisms   → Oro/Nova + consensus gate
 *   6. Inscription/Provenance    → Replay + evidence + ANIMA chains
 *   7. Distributed Specialists   → Workforce organisms + CPL
 *   8. Pattern Sensing           → Structural recognition + drift detection
 * 
 * ANCIENT SOURCES:
 *   - Egyptian temple orientation (astronomical alignment)
 *   - Greek harmonic proportions (PHI, golden ratio)
 *   - Mesopotamian record-keeping (provenance chains)
 *   - Mayan calendar systems (cyclical time patterns)
 *   - Vedic architectural principles (sacred geometry)
 *   - Gothic cathedral geometry (structural resonance)
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

import Types "Types";
import Utils "Utils";
import LawVectorCompiler "LawVectorCompiler";

module {
    
    // ================================================================== //
    // ANCIENT PATTERN TYPES                                                //
    // ================================================================== //
    
    /// Ancient civilization source
    public type AncientSource = {
        #EGYPTIAN;       // Temple orientation, astronomical alignment
        #GREEK;          // Harmonic proportions, geometry
        #MESOPOTAMIAN;   // Record-keeping, cuneiform tablets
        #MAYAN;          // Calendar systems, cyclical time
        #VEDIC;          // Sacred geometry, Vastu
        #GOTHIC;         // Cathedral geometry, acoustics
        #CHINESE;        // Feng shui, I Ching patterns
        #UNIVERSAL;      // Cross-cultural universal patterns
    };
    
    /// Pattern domain classification
    public type PatternDomain = {
        #CANON_EXECUTION;      // Canon-before-execution sequencing
        #INITIATORY;           // Translation/initiation layers
        #MEMORY_GEOMETRY;      // Spatial memory organization
        #HARMONIC;             // Frequency and resonance
        #DUAL_WITNESS;         // Witness and consensus
        #PROVENANCE;           // Record and lineage
        #WORKFORCE;            // Distributed specialists
        #PATTERN_SENSING;      // Recognition and drift
    };
    
    /// Ancient architectural pattern
    public type AncientPattern = {
        pattern_id: Text;
        name: Text;
        source: AncientSource;
        domain: PatternDomain;
        description: Text;
        mathematical_basis: Text;       // Mathematical/geometric foundation
        medina_mapping: Text;           // How it maps to MEDINA
        implementation_notes: Text;
        sacred_ratios: [Float];         // Associated sacred numbers
        created_at: Int;
    };
    
    /// Pattern synthesis result
    public type PatternSynthesis = {
        synthesis_id: Text;
        patterns: [AncientPattern];
        law_vectors_generated: Nat;
        ratio_vectors_generated: Nat;
        harmonic_signatures_generated: Nat;
        provenance_chains_created: Nat;
        timestamp: Int;
        integrity_signature: Text;
    };
    
    // ================================================================== //
    // ARCHITECTURE SYNTHESIS STATE                                         //
    // ================================================================== //
    
    /// Ancient architecture synthesis state
    public type ArchitectureState = {
        var patterns: [(Text, AncientPattern)];
        var syntheses: [(Text, PatternSynthesis)];
        var compiler_state: LawVectorCompiler.CompilerState;
        var id_counter: Nat;
        var created_at: Int;
    };
    
    /// Initialize architecture state
    public func init() : ArchitectureState {
        {
            var patterns = [];
            var syntheses = [];
            var compiler_state = LawVectorCompiler.init();
            var id_counter = 0;
            var created_at = Time.now();
        }
    };
    
    // ================================================================== //
    // PATTERN REGISTRATION                                                 //
    // ================================================================== //
    
    /// Register an ancient pattern
    public func registerPattern(
        state: ArchitectureState,
        name: Text,
        source: AncientSource,
        domain: PatternDomain,
        description: Text,
        mathematical_basis: Text,
        medina_mapping: Text,
        implementation_notes: Text,
        sacred_ratios: [Float]
    ) : AncientPattern {
        state.id_counter += 1;
        
        let pattern : AncientPattern = {
            pattern_id = Utils.generateId("pattern", state.id_counter);
            name = name;
            source = source;
            domain = domain;
            description = description;
            mathematical_basis = mathematical_basis;
            medina_mapping = medina_mapping;
            implementation_notes = implementation_notes;
            sacred_ratios = sacred_ratios;
            created_at = Time.now();
        };
        
        let buffer = Buffer.fromArray<(Text, AncientPattern)>(state.patterns);
        buffer.add((pattern.pattern_id, pattern));
        state.patterns := Buffer.toArray(buffer);
        
        pattern
    };
    
    // ================================================================== //
    // FOUNDATIONAL PATTERNS — Pre-loaded Ancient Wisdom                    //
    // ================================================================== //
    
    /// Load all foundational ancient patterns
    public func loadFoundationalPatterns(state: ArchitectureState) {
        
        // 1. CANON-BEFORE-EXECUTION (Egyptian/Mesopotamian)
        let _ = registerPattern(
            state,
            "Canon-Before-Execution",
            #EGYPTIAN,
            #CANON_EXECUTION,
            "No temple could be built without first establishing the sacred canon. The Ma'at (divine order) preceded all construction. Similarly, MEDINA requires constitutional law validation before any runtime mutation.",
            "Precedence ordering: Law > Gate > Action. Mathematical constraint: ∀action, ∃law | law.validates(action)",
            "Maps to MEDINA's gate sequencing: Constitution check → Gate A (runtime readiness) → Gate B (workforce activation) → Gate C (projection safety) → Execution",
            "Implemented via LawVector compilation with gates_required field. Each action packet must pass through sequential gate validation.",
            [1.0, 3.0, 7.0, 12.0]  // Sacred numbers: unity, trinity, completion, zodiac
        );
        
        // 2. INITIATORY TRANSLATION (Greek Mystery Schools)
        let _ = registerPattern(
            state,
            "Initiatory Translation Layers",
            #GREEK,
            #INITIATORY,
            "Greek mystery schools required progressive initiation through distinct levels. Each level translated higher knowledge into comprehensible form. MEDINA's sandbox models M92-M95 serve as translation layers.",
            "Staged revelation: Level(n+1) = Transform(Level(n), Initiation(n)). Information is not hidden but appropriately staged.",
            "Maps to MEDINA's sandbox models: M92 (initial exposure) → M93 (conceptual grounding) → M94 (practical application) → M95 (mastery integration)",
            "Implemented via tiered document intelligence models. Each sandbox level has specific input/output contracts.",
            [3.0, 7.0, 12.0, 33.0]  // Mystery school degree numbers
        );
        
        // 3. MEMORY GEOMETRY (Egyptian/Vedic)
        let _ = registerPattern(
            state,
            "Sacred Memory Geometry",
            #VEDIC,
            #MEMORY_GEOMETRY,
            "Vedic Vastu and Egyptian temple design used geometric forms to encode memory and meaning. The torus (donut shape) represents eternal return and memory circulation.",
            "Toroidal coordinates: (θ, φ, ρ) where θ=helical position, φ=major rotation, ρ=depth/salience. Volume = 2π²Rr²",
            "Maps to MEDINA's Memory Temple: Toroidal coordinate system for memory positioning. Higher salience = closer to torus surface. Lineage follows helical paths.",
            "Implemented via MemoryCoordinates type. PHI-scaled advancement creates golden spiral memory paths.",
            [LawVectorCompiler.PHI, LawVectorCompiler.PI, LawVectorCompiler.TAU]
        );
        
        // 4. HARMONIC CALIBRATION (Greek/Gothic)
        let _ = registerPattern(
            state,
            "Harmonic Frequency Calibration",
            #GREEK,
            #HARMONIC,
            "Pythagoras discovered harmonic ratios govern music, architecture, and cosmos. Gothic cathedrals were tuned to specific resonant frequencies. MEDINA uses frequency ladders for system calibration.",
            "Harmonic series: f, 2f, 3f, 4f... or PHI-scaled: f, fφ, fφ², fφ³... Resonance occurs when frequencies align.",
            "Maps to MEDINA's HarmonicSignature system: Base frequencies with PHI-scaled overtones. Resonance gates open when harmonic alignment achieved.",
            "Implemented via compileHarmonicSignature(). Schumann resonance (7.83Hz) serves as Earth baseline.",
            [7.83, 432.0, 528.0]  // Schumann, ancient A, "love frequency"
        );
        
        // 5. DUAL WITNESS MECHANISM (Mesopotamian/Hebrew)
        let _ = registerPattern(
            state,
            "Dual Witness Consensus",
            #MESOPOTAMIAN,
            #DUAL_WITNESS,
            "Ancient legal codes required two witnesses for valid testimony. Hebrew law codified this. MEDINA's Oro/Nova dual-witness system ensures no single point of failure in verification.",
            "Consensus formula: Valid(claim) iff Witness₁(claim) ∧ Witness₂(claim). Dissent triggers escalation.",
            "Maps to MEDINA's ConsensusVerdict system: Oro (observation witness) + Nova (validation witness). Consensus required for state mutations.",
            "Implemented via submitWitnessVerdict(). Both Oro and Nova must submit before verdict finalizes.",
            [2.0, 7.0]  // Duality, sacred witness count
        );
        
        // 6. INSCRIPTION/PROVENANCE (Mesopotamian)
        let _ = registerPattern(
            state,
            "Provenance Chain Inscription",
            #MESOPOTAMIAN,
            #PROVENANCE,
            "Cuneiform tablets tracked ownership, transactions, and lineage over millennia. Each inscription referenced prior inscriptions. MEDINA's provenance chains create unbroken evidence trails.",
            "Chain integrity: Entry(n).parent = Entry(n-1).id. Merkle-like: Hash(chain) = Hash(Hash(entries))",
            "Maps to MEDINA's ProvenanceChain system: Root inscription → subsequent entries. Each entry links to parent. ANIMA references connect to soul lineage.",
            "Implemented via createProvenanceChain() and addProvenanceEntry(). Integrity hash validates chain.",
            [1.0, 7.0, 40.0]  // Unity, completion, biblical generation
        );
        
        // 7. DISTRIBUTED SPECIALISTS (Egyptian/Medieval)
        let _ = registerPattern(
            state,
            "Distributed Specialist Orders",
            #EGYPTIAN,
            #WORKFORCE,
            "Temple construction required specialized guilds (stonemasons, astronomers, scribes) coordinated under sovereign authority. Medieval guilds continued this. MEDINA's workforce organisms operate similarly.",
            "Specialization with coordination: Guild(specialty) ⊂ Temple(authority). Each guild has domain expertise, all serve canonical mission.",
            "Maps to MEDINA's workforce organism system: Specialized document agents (D1-D10), neural models (N1-N12), operating under constitutional authority.",
            "Implemented via CPL (Canister Processing Language) packet structures. Each organism type has specific capabilities.",
            [12.0, 72.0]  // Zodiac guilds, 72 names/aspects
        );
        
        // 8. PATTERN SENSING (Universal)
        let _ = registerPattern(
            state,
            "Structural Pattern Recognition",
            #UNIVERSAL,
            #PATTERN_SENSING,
            "All ancient traditions emphasized pattern recognition as core intelligence. Reading omens, interpreting dreams, detecting seasonal changes. MEDINA's pattern sensing detects drift and contradictions.",
            "Recognition: Pattern(observed) ≈ Pattern(canonical) within tolerance ε. Drift = |observed - canonical| / canonical",
            "Maps to MEDINA's structural recognition system: Compare runtime state against canonical patterns. Detect drift, flag contradictions, trigger correction.",
            "Implemented via RECITAL_PLUS_ONE constraint checking. Each state transition must conform to canonical expansion rules.",
            [LawVectorCompiler.PHI, 1.0 / LawVectorCompiler.PHI]  // PHI and its inverse define tolerance bands
        );
    };
    
    // ================================================================== //
    // FULL SYNTHESIS                                                       //
    // ================================================================== //
    
    /// Execute full ancient architecture synthesis
    public func synthesize(state: ArchitectureState) : PatternSynthesis {
        state.id_counter += 1;
        
        // Load foundational patterns if not already loaded
        if (state.patterns.size() == 0) {
            loadFoundationalPatterns(state);
        };
        
        // Synthesize law vectors from compiler
        let compiler_synthesis = LawVectorCompiler.synthesizeAncientPatterns(state.compiler_state);
        
        // Create provenance chain for this synthesis
        let _ = LawVectorCompiler.createProvenanceChain(
            state.compiler_state,
            "{\"event\": \"ancient_architecture_synthesis\", \"patterns_synthesized\": " # Nat.toText(state.patterns.size()) # "}",
            "MEDINA_SYNTHESIS_ENGINE"
        );
        
        let synthesis : PatternSynthesis = {
            synthesis_id = Utils.generateId("synthesis", state.id_counter);
            patterns = Array.map<(Text, AncientPattern), AncientPattern>(
                state.patterns, func((_, p)) : AncientPattern { p }
            );
            law_vectors_generated = compiler_synthesis.law_vectors.size();
            ratio_vectors_generated = compiler_synthesis.ratio_vectors.size();
            harmonic_signatures_generated = compiler_synthesis.harmonic_signatures.size();
            provenance_chains_created = LawVectorCompiler.getProvenanceChains(state.compiler_state).size();
            timestamp = Time.now();
            integrity_signature = Utils.generateId("integrity", state.id_counter);
        };
        
        let buffer = Buffer.fromArray<(Text, PatternSynthesis)>(state.syntheses);
        buffer.add((synthesis.synthesis_id, synthesis));
        state.syntheses := Buffer.toArray(buffer);
        
        synthesis
    };
    
    // ================================================================== //
    // QUERY FUNCTIONS                                                      //
    // ================================================================== //
    
    /// Get all registered patterns
    public func getPatterns(state: ArchitectureState) : [AncientPattern] {
        Array.map<(Text, AncientPattern), AncientPattern>(
            state.patterns, func((_, p)) : AncientPattern { p }
        )
    };
    
    /// Get patterns by domain
    public func getPatternsByDomain(state: ArchitectureState, domain: PatternDomain) : [AncientPattern] {
        let results = Buffer.Buffer<AncientPattern>(8);
        for ((_, pattern) in state.patterns.vals()) {
            if (patternDomainEqual(pattern.domain, domain)) {
                results.add(pattern);
            };
        };
        Buffer.toArray(results)
    };
    
    /// Get patterns by source
    public func getPatternsBySource(state: ArchitectureState, source: AncientSource) : [AncientPattern] {
        let results = Buffer.Buffer<AncientPattern>(8);
        for ((_, pattern) in state.patterns.vals()) {
            if (ancientSourceEqual(pattern.source, source)) {
                results.add(pattern);
            };
        };
        Buffer.toArray(results)
    };
    
    /// Get all syntheses
    public func getSyntheses(state: ArchitectureState) : [PatternSynthesis] {
        Array.map<(Text, PatternSynthesis), PatternSynthesis>(
            state.syntheses, func((_, s)) : PatternSynthesis { s }
        )
    };
    
    /// Get latest synthesis
    public func getLatestSynthesis(state: ArchitectureState) : ?PatternSynthesis {
        if (state.syntheses.size() == 0) {
            return null;
        };
        let (_, latest) = state.syntheses[state.syntheses.size() - 1];
        ?latest
    };
    
    /// Get full synthesis report
    public func getSynthesisReport(state: ArchitectureState) : {
        total_patterns: Nat;
        total_syntheses: Nat;
        law_vectors: [LawVectorCompiler.LawVector];
        ratio_vectors: [LawVectorCompiler.RatioVector];
        harmonic_signatures: [LawVectorCompiler.HarmonicSignature];
        provenance_chains: [LawVectorCompiler.ProvenanceChain];
        consensus_verdicts: [LawVectorCompiler.ConsensusVerdict];
        created_at: Int;
    } {
        {
            total_patterns = state.patterns.size();
            total_syntheses = state.syntheses.size();
            law_vectors = LawVectorCompiler.getLawVectors(state.compiler_state);
            ratio_vectors = LawVectorCompiler.getRatioVectors(state.compiler_state);
            harmonic_signatures = LawVectorCompiler.getHarmonicSignatures(state.compiler_state);
            provenance_chains = LawVectorCompiler.getProvenanceChains(state.compiler_state);
            consensus_verdicts = LawVectorCompiler.getConsensusVerdicts(state.compiler_state);
            created_at = state.created_at;
        }
    };
    
    /// Get architecture status
    public func status(state: ArchitectureState) : {
        pattern_count: Nat;
        synthesis_count: Nat;
        compiler_status: {
            law_vector_count: Nat;
            ratio_vector_count: Nat;
            harmonic_signature_count: Nat;
            provenance_chain_count: Nat;
            consensus_verdict_count: Nat;
            created_at: Int;
        };
        created_at: Int;
    } {
        {
            pattern_count = state.patterns.size();
            synthesis_count = state.syntheses.size();
            compiler_status = LawVectorCompiler.status(state.compiler_state);
            created_at = state.created_at;
        }
    };
    
    // ================================================================== //
    // HELPER FUNCTIONS                                                     //
    // ================================================================== //
    
    func patternDomainEqual(a: PatternDomain, b: PatternDomain) : Bool {
        switch (a, b) {
            case (#CANON_EXECUTION, #CANON_EXECUTION) true;
            case (#INITIATORY, #INITIATORY) true;
            case (#MEMORY_GEOMETRY, #MEMORY_GEOMETRY) true;
            case (#HARMONIC, #HARMONIC) true;
            case (#DUAL_WITNESS, #DUAL_WITNESS) true;
            case (#PROVENANCE, #PROVENANCE) true;
            case (#WORKFORCE, #WORKFORCE) true;
            case (#PATTERN_SENSING, #PATTERN_SENSING) true;
            case (_, _) false;
        }
    };
    
    func ancientSourceEqual(a: AncientSource, b: AncientSource) : Bool {
        switch (a, b) {
            case (#EGYPTIAN, #EGYPTIAN) true;
            case (#GREEK, #GREEK) true;
            case (#MESOPOTAMIAN, #MESOPOTAMIAN) true;
            case (#MAYAN, #MAYAN) true;
            case (#VEDIC, #VEDIC) true;
            case (#GOTHIC, #GOTHIC) true;
            case (#CHINESE, #CHINESE) true;
            case (#UNIVERSAL, #UNIVERSAL) true;
            case (_, _) false;
        }
    };
}
