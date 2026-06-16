/**
 * UniversalPrimitiveLaw Module — L-130: The Architecture Law
 * 
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                    L-130: UNIVERSAL PRIMITIVE LAW                         ║
 * ║                                                                           ║
 * ║  Before recomposition, trace to primitive.                                ║
 * ║  Before explanation, trace to primitive.                                  ║
 * ║  Before implementation, trace to primitive.                               ║
 * ║  Before governance, trace to primitive.                                   ║
 * ║  Before naming, trace to primitive.                                       ║
 * ║                                                                           ║
 * ║  This is not a style preference.                                          ║
 * ║  This is an architecture law.                                             ║
 * ║                                                                           ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 * 
 * THE LAW REACHES ACROSS EVERYTHING:
 *   - Physics (field states, wavelengths, forces)
 *   - Biology (cells, organisms, life cycles)
 *   - Civilization (law, governance, culture)
 *   - Myth (archetypes, symbols, narratives)
 *   - Law (contracts, rights, obligations)
 *   - Software (functions, data, state)
 *   - Tokens (value, transfer, ownership)
 *   - Companies (entities, contracts, missions)
 *   - Documents (memory, compression, transfer)
 *   - Intelligence itself (recognition, preservation, relation)
 * 
 * INTELLIGENCE DEFINED:
 *   Intelligence is the field that remains when false wrappers are stripped away,
 *   and the lawful capacity to recognize, preserve, relate, and recompose
 *   from what is most primitive and most true.
 * 
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Hash "mo:base/Hash";

import MatalkoICP "MatalkoICP";

module {
    // ================================================================== //
    // THE LAW STATEMENT                                                   //
    // ================================================================== //
    
    /// The Law ID
    public let LAW_ID : Text = "L-130";
    
    /// The Law Name  
    public let LAW_NAME : Text = "Universal Primitive Law";
    
    /// The Law Statement (complete)
    public let LAW_STATEMENT : Text = 
        "Before recomposition, trace to primitive. " #
        "Before explanation, trace to primitive. " #
        "Before implementation, trace to primitive. " #
        "Before governance, trace to primitive. " #
        "Before naming, trace to primitive. " #
        "This is not a style preference. This is an architecture law.";
    
    /// Golden ratio — fundamental primitive
    public let PHI : Float = MatalkoICP.PHI;
    
    // ================================================================== //
    // PRIMITIVE DOMAIN CATEGORIES                                         //
    // ================================================================== //
    
    /// The domains that primitives can trace to
    public type PrimitiveDomain = {
        #Physics;       // Field states, wavelengths, forces, energy
        #Biology;       // Cells, organisms, life, metabolism
        #Civilization;  // Law, governance, culture, society
        #Myth;          // Archetypes, symbols, narratives, meanings
        #Law;           // Contracts, rights, obligations, justice
        #Software;      // Functions, data, state, computation
        #Tokens;        // Value, transfer, ownership, scarcity
        #Companies;     // Entities, missions, contracts, structure
        #Documents;     // Memory, compression, transfer, crystallization
        #Intelligence;  // Recognition, preservation, relation, recomposition
    };
    
    /// Convert domain to text
    public func domainToText(domain: PrimitiveDomain) : Text {
        switch (domain) {
            case (#Physics) "Physics";
            case (#Biology) "Biology";
            case (#Civilization) "Civilization";
            case (#Myth) "Myth";
            case (#Law) "Law";
            case (#Software) "Software";
            case (#Tokens) "Tokens";
            case (#Companies) "Companies";
            case (#Documents) "Documents";
            case (#Intelligence) "Intelligence";
        }
    };
    
    // ================================================================== //
    // PRIMITIVE TRACE TYPES                                               //
    // ================================================================== //
    
    /// A single primitive element in a trace
    public type PrimitiveElement = {
        element_id: Text;
        name: Text;
        domain: PrimitiveDomain;
        description: Text;
        depth: Nat;              // 0 = most primitive, increasing = more derived
        parent_element: ?Text;   // The more primitive element this derives from
        resonance: Float;        // [0, 1] how close to fundamental truth
    };
    
    /// A complete primitive trace (from surface to foundation)
    public type PrimitiveTrace = {
        trace_id: Text;
        entity_name: Text;           // What we're tracing (e.g., "blue color")
        current_form: Text;          // How it appears now (e.g., "interface color")
        elements: [PrimitiveElement]; // The trace from surface to primitive
        total_depth: Nat;            // How deep the trace goes
        recomposition: Text;         // The insight from tracing
        created_at: Int;
        verified: Bool;
        verification_hash: Text;
    };
    
    // ================================================================== //
    // ENTITY CATEGORIES FOR TRACING                                       //
    // ================================================================== //
    
    /// Categories of entities that must be traced
    public type EntityCategory = {
        #Color;         // Colors in the system
        #Document;      // Documents and files
        #Canister;      // ICP canisters
        #Workflow;      // Processes and workflows
        #Contract;      // Agreements and contracts
        #Model;         // Intelligence models
        #Organ;         // Organism components
        #Function;      // Computational functions
        #Memory;        // Memory structures
        #Symbol;        // Symbols and glyphs
    };
    
    /// Convert category to text
    public func categoryToText(category: EntityCategory) : Text {
        switch (category) {
            case (#Color) "Color";
            case (#Document) "Document";
            case (#Canister) "Canister";
            case (#Workflow) "Workflow";
            case (#Contract) "Contract";
            case (#Model) "Model";
            case (#Organ) "Organ";
            case (#Function) "Function";
            case (#Memory) "Memory";
            case (#Symbol) "Symbol";
        }
    };
    
    // ================================================================== //
    // LAW STATE                                                           //
    // ================================================================== //
    
    /// Complete law state
    public type LawState = {
        law_id: Text;
        law_name: Text;
        traces: [PrimitiveTrace];
        total_traces: Nat;
        total_verifications: Nat;
        total_violations: Nat;
        last_enforcement: Int;
        active: Bool;
        coherence: Float;       // Overall law coherence
    };
    
    /// Initialize law state
    public func init() : LawState {
        {
            law_id = LAW_ID;
            law_name = LAW_NAME;
            traces = [];
            total_traces = 0;
            total_verifications = 0;
            total_violations = 0;
            last_enforcement = Time.now();
            active = true;
            coherence = 1.0;
        }
    };
    
    // ================================================================== //
    // PRIMITIVE ELEMENT CREATION                                          //
    // ================================================================== //
    
    /// Create a primitive element
    public func createElement(
        name: Text,
        domain: PrimitiveDomain,
        description: Text,
        depth: Nat,
        parentElement: ?Text
    ) : PrimitiveElement {
        let resonance = calculateResonance(depth);
        {
            element_id = name # "_" # Int.toText(Time.now());
            name = name;
            domain = domain;
            description = description;
            depth = depth;
            parent_element = parentElement;
            resonance = resonance;
        }
    };
    
    /// Calculate resonance based on depth (deeper = more primitive = higher resonance)
    func calculateResonance(depth: Nat) : Float {
        // At depth 0, resonance is 1.0 (most primitive)
        // Resonance decreases with depth using golden ratio decay
        if (depth == 0) {
            1.0
        } else {
            let depthFloat = Float.fromInt(Int.abs(depth));
            1.0 / (1.0 + depthFloat * (1.0 - PHI))  // φ-scaled decay
        }
    };
    
    // ================================================================== //
    // TRACE CREATION                                                      //
    // ================================================================== //
    
    /// Create a new primitive trace
    public func createTrace(
        state: LawState,
        entityName: Text,
        currentForm: Text,
        elements: [PrimitiveElement],
        recomposition: Text
    ) : (LawState, PrimitiveTrace) {
        let traceId = entityName # "_trace_" # Int.toText(Time.now());
        let totalDepth = elements.size();
        let hash = generateTraceHash(entityName, elements);
        
        let trace : PrimitiveTrace = {
            trace_id = traceId;
            entity_name = entityName;
            current_form = currentForm;
            elements = elements;
            total_depth = totalDepth;
            recomposition = recomposition;
            created_at = Time.now();
            verified = false;
            verification_hash = hash;
        };
        
        // Add to state
        let newTraces = Array.append(state.traces, [trace]);
        let newState : LawState = {
            law_id = state.law_id;
            law_name = state.law_name;
            traces = newTraces;
            total_traces = state.total_traces + 1;
            total_verifications = state.total_verifications;
            total_violations = state.total_violations;
            last_enforcement = Time.now();
            active = state.active;
            coherence = calculateLawCoherence(newTraces);
        };
        
        (newState, trace)
    };
    
    /// Generate hash for trace verification
    func generateTraceHash(entityName: Text, elements: [PrimitiveElement]) : Text {
        var combined = entityName;
        for (elem in elements.vals()) {
            combined := combined # "_" # elem.name # "_" # Nat.toText(elem.depth);
        };
        combined # "_" # Int.toText(Time.now())
    };
    
    /// Calculate overall law coherence
    func calculateLawCoherence(traces: [PrimitiveTrace]) : Float {
        if (traces.size() == 0) {
            return 1.0;
        };
        
        var totalResonance : Float = 0.0;
        var count : Float = 0.0;
        
        for (trace in traces.vals()) {
            for (elem in trace.elements.vals()) {
                totalResonance := totalResonance + elem.resonance;
                count := count + 1.0;
            };
        };
        
        if (count == 0.0) {
            1.0
        } else {
            totalResonance / count
        }
    };
    
    // ================================================================== //
    // VERIFICATION                                                        //
    // ================================================================== //
    
    /// Verification result
    public type VerificationResult = {
        valid: Bool;
        trace_id: Text;
        depth_verified: Bool;
        elements_verified: Bool;
        recomposition_verified: Bool;
        coherence: Float;
        violations: [Text];
    };
    
    /// Verify a primitive trace
    public func verifyTrace(
        state: LawState,
        traceId: Text
    ) : (LawState, VerificationResult) {
        // Find the trace
        let traceOpt = Array.find<PrimitiveTrace>(state.traces, func(t) { t.trace_id == traceId });
        
        switch (traceOpt) {
            case null {
                let result : VerificationResult = {
                    valid = false;
                    trace_id = traceId;
                    depth_verified = false;
                    elements_verified = false;
                    recomposition_verified = false;
                    coherence = 0.0;
                    violations = ["Trace not found"];
                };
                (state, result)
            };
            case (?trace) {
                let violations = Buffer.Buffer<Text>(0);
                
                // Check depth (must have at least one element)
                let depthVerified = trace.elements.size() > 0;
                if (not depthVerified) {
                    violations.add("Trace has no elements");
                };
                
                // Check elements (must have proper depth ordering)
                var elementsVerified = true;
                var prevDepth : Int = -1;
                for (elem in trace.elements.vals()) {
                    if (Int.abs(elem.depth) <= prevDepth) {
                        elementsVerified := false;
                        violations.add("Elements not properly ordered by depth");
                    };
                    prevDepth := Int.abs(elem.depth);
                };
                
                // Check recomposition (must not be empty)
                let recompVerified = trace.recomposition.size() > 0;
                if (not recompVerified) {
                    violations.add("Recomposition is empty");
                };
                
                // Calculate coherence
                var traceCoherence : Float = 0.0;
                if (trace.elements.size() > 0) {
                    for (elem in trace.elements.vals()) {
                        traceCoherence := traceCoherence + elem.resonance;
                    };
                    traceCoherence := traceCoherence / Float.fromInt(trace.elements.size());
                };
                
                let valid = depthVerified and elementsVerified and recompVerified;
                
                // Update state
                let newState : LawState = {
                    law_id = state.law_id;
                    law_name = state.law_name;
                    traces = state.traces;
                    total_traces = state.total_traces;
                    total_verifications = state.total_verifications + 1;
                    total_violations = if (valid) state.total_violations else state.total_violations + 1;
                    last_enforcement = Time.now();
                    active = state.active;
                    coherence = state.coherence;
                };
                
                let result : VerificationResult = {
                    valid = valid;
                    trace_id = traceId;
                    depth_verified = depthVerified;
                    elements_verified = elementsVerified;
                    recomposition_verified = recompVerified;
                    coherence = traceCoherence;
                    violations = Buffer.toArray(violations);
                };
                
                (newState, result)
            };
        }
    };
    
    // ================================================================== //
    // LAW ENFORCEMENT                                                     //
    // ================================================================== //
    
    /// Enforcement result
    public type EnforcementResult = {
        entity_id: Text;
        has_trace: Bool;
        trace_valid: Bool;
        allowed: Bool;
        reason: Text;
    };
    
    /// Enforce the law on an entity (check if it has valid primitive trace)
    public func enforceLaw(
        state: LawState,
        entityId: Text,
        entityName: Text
    ) : EnforcementResult {
        // Find any trace for this entity
        let traceOpt = Array.find<PrimitiveTrace>(state.traces, func(t) { t.entity_name == entityName });
        
        switch (traceOpt) {
            case null {
                {
                    entity_id = entityId;
                    has_trace = false;
                    trace_valid = false;
                    allowed = false;
                    reason = "L-130 VIOLATION: No primitive trace exists for '" # entityName # "'. Before implementation, trace to primitive.";
                }
            };
            case (?trace) {
                let valid = trace.verified and trace.elements.size() > 0;
                {
                    entity_id = entityId;
                    has_trace = true;
                    trace_valid = valid;
                    allowed = valid;
                    reason = if (valid) {
                        "L-130 COMPLIANT: Entity '" # entityName # "' has valid primitive trace with depth " # Nat.toText(trace.total_depth);
                    } else {
                        "L-130 VIOLATION: Primitive trace for '" # entityName # "' is not verified or incomplete.";
                    };
                }
            };
        }
    };
    
    // ================================================================== //
    // QUERY FUNCTIONS                                                     //
    // ================================================================== //
    
    /// Get law status
    public func status(state: LawState) : {
        law_id: Text;
        law_name: Text;
        law_statement: Text;
        total_traces: Nat;
        total_verifications: Nat;
        total_violations: Nat;
        active: Bool;
        coherence: Float;
    } {
        {
            law_id = state.law_id;
            law_name = state.law_name;
            law_statement = LAW_STATEMENT;
            total_traces = state.total_traces;
            total_verifications = state.total_verifications;
            total_violations = state.total_violations;
            active = state.active;
            coherence = state.coherence;
        }
    };
    
    /// Get all traces
    public func getTraces(state: LawState) : [PrimitiveTrace] {
        state.traces
    };
    
    /// Get trace by ID
    public func getTrace(state: LawState, traceId: Text) : ?PrimitiveTrace {
        Array.find<PrimitiveTrace>(state.traces, func(t) { t.trace_id == traceId })
    };
    
    /// Get traces for entity
    public func getTracesForEntity(state: LawState, entityName: Text) : [PrimitiveTrace] {
        Array.filter<PrimitiveTrace>(state.traces, func(t) { t.entity_name == entityName })
    };
}
