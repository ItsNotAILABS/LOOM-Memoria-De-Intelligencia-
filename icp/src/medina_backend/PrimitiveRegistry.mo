/**
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                    MEDINA - PROPRIETARY AND CONFIDENTIAL                  ║
 * ║                                                                           ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA   ║
 * ║                       medinasiftech@outlook.com                           ║
 * ║                                                                           ║
 * ║  ALL RIGHTS RESERVED. NO FREE LICENSES. STRICTLY PROPRIETARY.            ║
 * ║                                                                           ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 * 
 * PRIMITIVE REGISTRY — Origin-Aware Entity Registration with L-130 Enforcement
 * 
 * ═══════════════════════════════════════════════════════════════════════════
 * 
 * REGISTRY RULE (L-130 Enforcement):
 *   NO ENTITY ENTERS THE SOVEREIGN REGISTRY WITHOUT PRIMITIVE TRACE METADATA.
 * 
 *   This turns the registry from a museum of names into an origin-aware 
 *   architecture field.
 * 
 * ═══════════════════════════════════════════════════════════════════════════
 * 
 * ENTITY TYPES REQUIRING PRIMITIVE TRACE:
 *   - Organism
 *   - Document  
 *   - Token
 *   - Company
 *   - Engine
 *   - Law
 *   - Canister
 *   - Workflow
 *   - Model
 *   - Contract
 *   - Ledger
 * 
 * ═══════════════════════════════════════════════════════════════════════════
 * 
 * PRIMITIVE TRACE METADATA INCLUDES:
 *   - primitive_form: The detected primitive
 *   - primitive_state: Confirmed, Fragmented, Hidden, Inverted, etc.
 *   - confidence_score: How confident the detection is
 *   - descent_depth: How many layers were traversed
 *   - recomposition_path: Blueprint for rebuilding from primitive
 *   - drift_status: Whether drift from primitive was detected
 *   - traced_at: When the trace was performed
 *   - traced_by: What system performed the trace
 * 
 * ═══════════════════════════════════════════════════════════════════════════
 * 
 * Attribution: Alfredo Medina Hernandez — Founder, Architect of MEDINA
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import UniversalPrimitiveLaw "UniversalPrimitiveLaw";
import UniversalPrimitiveEngine "UniversalPrimitiveEngine";

module {
    // ================================================================== //
    // REGISTRY CONSTANTS                                                   //
    // ================================================================== //
    
    /// Registry name
    public let REGISTRY_NAME : Text = "Primitive Registry";
    
    /// Registry version
    public let REGISTRY_VERSION : Text = "1.0.0";
    
    /// Law enforcement reference
    public let LAW_REFERENCE : Text = "L-130 — Universal Primitive Law";
    
    /// Minimum confidence required for registration
    public let MIN_CONFIDENCE_FOR_REGISTRATION : Float = 0.3;
    
    // ================================================================== //
    // ENTITY TYPES REQUIRING PRIMITIVE TRACE                               //
    // ================================================================== //
    
    /// Entity types that must have primitive trace
    public type RegistrableEntity = {
        #Organism;
        #Document;
        #Token;
        #Company;
        #Engine;
        #Law;
        #Canister;
        #Workflow;
        #Model;
        #Contract;
        #Ledger;
        #Architecture;
        #Symbol;
        #Color;
        #Substrate;
        #Signal;
        #Interface;
    };
    
    /// All registrable entity types
    public let REGISTRABLE_ENTITIES : [RegistrableEntity] = [
        #Organism, #Document, #Token, #Company, #Engine, #Law,
        #Canister, #Workflow, #Model, #Contract, #Ledger,
        #Architecture, #Symbol, #Color, #Substrate, #Signal, #Interface
    ];
    
    // ================================================================== //
    // PRIMITIVE TRACE METADATA                                             //
    // ================================================================== //
    
    /// Primitive trace metadata attached to every registered entity
    public type PrimitiveTraceMetadata = {
        // Identity
        trace_id: Text;
        entity_id: Text;
        entity_type: RegistrableEntity;
        entity_domain: UniversalPrimitiveLaw.EntityDomain;
        
        // Primitive information
        primitive_form: Text;
        primitive_state: UniversalPrimitiveLaw.PrimitiveState;
        confidence_score: Float;
        
        // Descent information
        descent_depth: Nat;
        layers_traversed: [Text];
        gaps_encountered: [Text];
        
        // Recomposition information
        recomposition_available: Bool;
        recomposition_path: ?UniversalPrimitiveLaw.RecompositionPath;
        
        // Drift information
        drift_detected: Bool;
        drift_type: ?UniversalPrimitiveLaw.DriftType;
        drift_severity: Float;
        
        // Audit trail
        traced_at: Int;
        traced_by: Text;
        last_verified_at: Int;
        verification_count: Nat;
        
        // Related data
        related_laws: [Text];
        related_primitives: [Text];  // Other entities with same primitive
    };
    
    // ================================================================== //
    // REGISTERED ENTITY                                                    //
    // ================================================================== //
    
    /// A fully registered entity with primitive trace
    public type RegisteredEntity = {
        // Entity identity
        registration_id: Text;
        entity_id: Text;
        entity_type: RegistrableEntity;
        entity_name: Text;
        entity_description: Text;
        
        // Primitive trace (REQUIRED by L-130)
        primitive_trace: PrimitiveTraceMetadata;
        
        // Registration metadata
        registered_at: Int;
        registered_by: Text;
        registration_status: RegistrationStatus;
        
        // Verification
        last_verified_at: Int;
        verification_history: [VerificationRecord];
    };
    
    /// Registration status
    public type RegistrationStatus = {
        #PendingTrace;      // Awaiting primitive trace
        #TraceComplete;     // Primitive traced, ready for registration
        #Registered;        // Fully registered
        #DriftDetected;     // Drift from primitive detected
        #RequiresRetrace;   // Needs new primitive trace
        #Suspended;         // Registration suspended
    };
    
    /// Verification record
    public type VerificationRecord = {
        verified_at: Int;
        verified_by: Text;
        previous_state: UniversalPrimitiveLaw.PrimitiveState;
        current_state: UniversalPrimitiveLaw.PrimitiveState;
        drift_found: Bool;
        notes: Text;
    };
    
    // ================================================================== //
    // REGISTRATION REQUEST                                                 //
    // ================================================================== //
    
    /// Request to register an entity
    public type RegistrationRequest = {
        entity_id: Text;
        entity_type: RegistrableEntity;
        entity_name: Text;
        entity_description: Text;
        current_expression: Text;
        known_layers: [Text];
        doctrine_context: ?Text;
        history_context: ?Text;
        requested_by: Text;
    };
    
    /// Registration result
    public type RegistrationResult = {
        success: Bool;
        registration_id: ?Text;
        primitive_trace: ?PrimitiveTraceMetadata;
        error_message: ?Text;
        blocking_law: ?Text;  // Which law blocked registration
    };
    
    // ================================================================== //
    // REGISTRY STATE                                                       //
    // ================================================================== //
    
    /// Registry state
    public type RegistryState = {
        // Registry identity
        var registry_id: Text;
        var created_at: Int;
        
        // Registered entities
        var entities: [RegisteredEntity];
        
        // Pending registrations
        var pending: [RegistrationRequest];
        
        // Statistics
        var total_registrations: Nat;
        var total_rejections: Nat;
        var total_verifications: Nat;
        var drift_detections: Nat;
        
        // Engine reference
        var engine_state: UniversalPrimitiveEngine.EngineState;
    };
    
    /// Initialize registry
    public func init() : RegistryState {
        {
            var registry_id = "primitive_registry_" # Int.toText(Time.now());
            var created_at = Time.now();
            var entities = [];
            var pending = [];
            var total_registrations = 0;
            var total_rejections = 0;
            var total_verifications = 0;
            var drift_detections = 0;
            var engine_state = UniversalPrimitiveEngine.init();
        }
    };
    
    // ================================================================== //
    // DOMAIN CONVERSION                                                    //
    // ================================================================== //
    
    /// Convert RegistrableEntity to EntityDomain
    public func toEntityDomain(entity: RegistrableEntity) : UniversalPrimitiveLaw.EntityDomain {
        switch (entity) {
            case (#Organism) { #Organism };
            case (#Document) { #Document };
            case (#Token) { #Token };
            case (#Company) { #Company };
            case (#Engine) { #Engine };
            case (#Law) { #Law };
            case (#Canister) { #Canister };
            case (#Workflow) { #Workflow };
            case (#Model) { #Software };  // Models are software
            case (#Contract) { #Law };     // Contracts are law
            case (#Ledger) { #Memory };    // Ledgers are memory
            case (#Architecture) { #Architecture };
            case (#Symbol) { #Symbolism };
            case (#Color) { #Color };
            case (#Substrate) { #Substrate };
            case (#Signal) { #Signal };
            case (#Interface) { #Interface };
        }
    };
    
    // ================================================================== //
    // REGISTRATION FUNCTIONS                                               //
    // ================================================================== //
    
    /// Register entity with L-130 enforcement
    /// REQUIRES primitive trace before registration
    public func registerEntity(
        state: RegistryState,
        request: RegistrationRequest
    ) : (RegistryState, RegistrationResult) {
        let now = Time.now();
        
        // Check if already registered
        for (entity in state.entities.vals()) {
            if (entity.entity_id == request.entity_id) {
                return (state, {
                    success = false;
                    registration_id = null;
                    primitive_trace = null;
                    error_message = ?"Entity already registered: " # request.entity_id;
                    blocking_law = null;
                });
            };
        };
        
        // Run primitive trace through engine
        let input : UniversalPrimitiveEngine.EngineInput = {
            entity_id = request.entity_id;
            entity_type = toEntityDomain(request.entity_type);
            current_expression = request.current_expression;
            known_layers = request.known_layers;
            doctrine_context = request.doctrine_context;
            history_context = request.history_context;
            cross_domain_references = [];
        };
        
        let (newEngineState, output) = UniversalPrimitiveEngine.processEntity(
            state.engine_state, input
        );
        state.engine_state := newEngineState;
        
        // Check if primitive was found (L-130 enforcement)
        switch (output.primitive_form) {
            case (null) {
                // L-130 blocks registration
                state.total_rejections += 1;
                return (state, {
                    success = false;
                    registration_id = null;
                    primitive_trace = null;
                    error_message = ?"Primitive trace failed - cannot find primitive. L-130 blocks registration.";
                    blocking_law = ?LAW_REFERENCE;
                });
            };
            case (?primitive) {
                // Check confidence threshold
                if (output.primitive_confidence_score < MIN_CONFIDENCE_FOR_REGISTRATION) {
                    state.total_rejections += 1;
                    return (state, {
                        success = false;
                        registration_id = null;
                        primitive_trace = null;
                        error_message = ?"Primitive confidence too low (" # 
                            Float.toText(output.primitive_confidence_score) # 
                            "). Minimum required: " # Float.toText(MIN_CONFIDENCE_FOR_REGISTRATION);
                        blocking_law = ?LAW_REFERENCE;
                    });
                };
                
                // Create primitive trace metadata
                let trace : PrimitiveTraceMetadata = {
                    trace_id = "trace_" # request.entity_id # "_" # Int.toText(now);
                    entity_id = request.entity_id;
                    entity_type = request.entity_type;
                    entity_domain = toEntityDomain(request.entity_type);
                    primitive_form = primitive;
                    primitive_state = output.primitive_state;
                    confidence_score = output.primitive_confidence_score;
                    descent_depth = output.phase_results.descend_result.descent_depth;
                    layers_traversed = Array.map<UniversalPrimitiveLaw.ArchitecturalLayer, Text>(
                        output.phase_results.descend_result.layers_traversed,
                        func(l) { l.layer_name }
                    );
                    gaps_encountered = output.phase_results.descend_result.gaps_encountered;
                    recomposition_available = output.recomposition_blueprint != null;
                    recomposition_path = switch (output.recomposition_blueprint) {
                        case (?b) { ?b.path };
                        case (null) { null };
                    };
                    drift_detected = output.drift_map.size() > 0;
                    drift_type = if (output.drift_map.size() > 0) {
                        ?output.drift_map[0].drift_type
                    } else { null };
                    drift_severity = if (output.drift_map.size() > 0) {
                        output.drift_map[0].severity
                    } else { 0.0 };
                    traced_at = now;
                    traced_by = "Universal Primitive Engine";
                    last_verified_at = now;
                    verification_count = 1;
                    related_laws = output.related_laws;
                    related_primitives = [];  // Would be populated by cross-reference
                };
                
                // Create registered entity
                let registration_id = "reg_" # request.entity_id # "_" # Int.toText(now);
                let registered : RegisteredEntity = {
                    registration_id = registration_id;
                    entity_id = request.entity_id;
                    entity_type = request.entity_type;
                    entity_name = request.entity_name;
                    entity_description = request.entity_description;
                    primitive_trace = trace;
                    registered_at = now;
                    registered_by = request.requested_by;
                    registration_status = if (trace.drift_detected) {
                        #DriftDetected
                    } else {
                        #Registered
                    };
                    last_verified_at = now;
                    verification_history = [{
                        verified_at = now;
                        verified_by = "Initial registration";
                        previous_state = #PRIMITIVE_UNREACHED;
                        current_state = output.primitive_state;
                        drift_found = trace.drift_detected;
                        notes = "Initial primitive trace during registration";
                    }];
                };
                
                // Add to registry
                let entities = Buffer.fromArray<RegisteredEntity>(state.entities);
                entities.add(registered);
                state.entities := Buffer.toArray(entities);
                state.total_registrations += 1;
                
                if (trace.drift_detected) {
                    state.drift_detections += 1;
                };
                
                (state, {
                    success = true;
                    registration_id = ?registration_id;
                    primitive_trace = ?trace;
                    error_message = null;
                    blocking_law = null;
                })
            };
        }
    };
    
    /// Get entity by ID
    public func getEntity(state: RegistryState, entity_id: Text) : ?RegisteredEntity {
        for (entity in state.entities.vals()) {
            if (entity.entity_id == entity_id) {
                return ?entity;
            };
        };
        null
    };
    
    /// Get primitive trace for entity
    public func getPrimitiveTrace(state: RegistryState, entity_id: Text) : ?PrimitiveTraceMetadata {
        switch (getEntity(state, entity_id)) {
            case (?entity) { ?entity.primitive_trace };
            case (null) { null };
        }
    };
    
    /// Check if entity has primitive trace
    public func hasPrimitiveTrace(state: RegistryState, entity_id: Text) : Bool {
        getEntity(state, entity_id) != null
    };
    
    // ================================================================== //
    // VERIFICATION FUNCTIONS                                               //
    // ================================================================== //
    
    /// Verify an entity's primitive trace
    public func verifyEntity(
        state: RegistryState,
        entity_id: Text,
        current_expression: Text,
        verified_by: Text
    ) : (RegistryState, Bool, Text) {
        switch (getEntity(state, entity_id)) {
            case (null) {
                (state, false, "Entity not found: " # entity_id)
            };
            case (?entity) {
                let now = Time.now();
                
                // Re-run primitive trace
                let input : UniversalPrimitiveEngine.EngineInput = {
                    entity_id = entity_id;
                    entity_type = toEntityDomain(entity.entity_type);
                    current_expression = current_expression;
                    known_layers = entity.primitive_trace.layers_traversed;
                    doctrine_context = null;
                    history_context = null;
                    cross_domain_references = [];
                };
                
                let (newEngineState, output) = UniversalPrimitiveEngine.processEntity(
                    state.engine_state, input
                );
                state.engine_state := newEngineState;
                
                // Check for drift from original primitive
                let primitiveChanged = switch (output.primitive_form) {
                    case (?p) { p != entity.primitive_trace.primitive_form };
                    case (null) { true };
                };
                
                let drift_found = primitiveChanged or output.drift_map.size() > 0;
                
                // Create verification record
                let record : VerificationRecord = {
                    verified_at = now;
                    verified_by = verified_by;
                    previous_state = entity.primitive_trace.primitive_state;
                    current_state = output.primitive_state;
                    drift_found = drift_found;
                    notes = if (drift_found) {
                        "Drift detected from original primitive"
                    } else {
                        "Primitive verified successfully"
                    };
                };
                
                // Update entity in registry
                let updated_entities = Array.map<RegisteredEntity, RegisteredEntity>(
                    state.entities,
                    func(e) {
                        if (e.entity_id == entity_id) {
                            {
                                registration_id = e.registration_id;
                                entity_id = e.entity_id;
                                entity_type = e.entity_type;
                                entity_name = e.entity_name;
                                entity_description = e.entity_description;
                                primitive_trace = {
                                    trace_id = e.primitive_trace.trace_id;
                                    entity_id = e.primitive_trace.entity_id;
                                    entity_type = e.primitive_trace.entity_type;
                                    entity_domain = e.primitive_trace.entity_domain;
                                    primitive_form = e.primitive_trace.primitive_form;
                                    primitive_state = output.primitive_state;
                                    confidence_score = output.primitive_confidence_score;
                                    descent_depth = e.primitive_trace.descent_depth;
                                    layers_traversed = e.primitive_trace.layers_traversed;
                                    gaps_encountered = e.primitive_trace.gaps_encountered;
                                    recomposition_available = e.primitive_trace.recomposition_available;
                                    recomposition_path = e.primitive_trace.recomposition_path;
                                    drift_detected = drift_found;
                                    drift_type = if (output.drift_map.size() > 0) {
                                        ?output.drift_map[0].drift_type
                                    } else { null };
                                    drift_severity = if (output.drift_map.size() > 0) {
                                        output.drift_map[0].severity
                                    } else { 0.0 };
                                    traced_at = e.primitive_trace.traced_at;
                                    traced_by = e.primitive_trace.traced_by;
                                    last_verified_at = now;
                                    verification_count = e.primitive_trace.verification_count + 1;
                                    related_laws = e.primitive_trace.related_laws;
                                    related_primitives = e.primitive_trace.related_primitives;
                                };
                                registered_at = e.registered_at;
                                registered_by = e.registered_by;
                                registration_status = if (drift_found) {
                                    #DriftDetected
                                } else {
                                    #Registered
                                };
                                last_verified_at = now;
                                verification_history = Array.append(
                                    e.verification_history,
                                    [record]
                                );
                            }
                        } else {
                            e
                        }
                    }
                );
                
                state.entities := updated_entities;
                state.total_verifications += 1;
                
                if (drift_found) {
                    state.drift_detections += 1;
                    (state, false, "Verification complete: DRIFT DETECTED from original primitive")
                } else {
                    (state, true, "Verification complete: Primitive confirmed")
                }
            };
        }
    };
    
    // ================================================================== //
    // QUERY FUNCTIONS                                                      //
    // ================================================================== //
    
    /// Get entities by primitive form
    public func getEntitiesByPrimitive(
        state: RegistryState, 
        primitive_form: Text
    ) : [RegisteredEntity] {
        Array.filter<RegisteredEntity>(
            state.entities,
            func(e) { e.primitive_trace.primitive_form == primitive_form }
        )
    };
    
    /// Get entities by primitive state
    public func getEntitiesByState(
        state: RegistryState,
        primitive_state: UniversalPrimitiveLaw.PrimitiveState
    ) : [RegisteredEntity] {
        Array.filter<RegisteredEntity>(
            state.entities,
            func(e) { e.primitive_trace.primitive_state == primitive_state }
        )
    };
    
    /// Get entities with drift detected
    public func getEntitiesWithDrift(state: RegistryState) : [RegisteredEntity] {
        Array.filter<RegisteredEntity>(
            state.entities,
            func(e) { e.primitive_trace.drift_detected }
        )
    };
    
    /// Get entities by type
    public func getEntitiesByType(
        state: RegistryState,
        entity_type: RegistrableEntity
    ) : [RegisteredEntity] {
        Array.filter<RegisteredEntity>(
            state.entities,
            func(e) { e.entity_type == entity_type }
        )
    };
    
    // ================================================================== //
    // STATISTICS                                                           //
    // ================================================================== //
    
    /// Get registry statistics
    public func getStatistics(state: RegistryState) : {
        registry_id: Text;
        total_entities: Nat;
        total_registrations: Nat;
        total_rejections: Nat;
        total_verifications: Nat;
        drift_detections: Nat;
        registration_rate: Float;
        drift_rate: Float;
        entities_by_state: [(Text, Nat)];
        entities_by_type: [(Text, Nat)];
    } {
        let total = state.entities.size();
        let attempts = state.total_registrations + state.total_rejections;
        
        let registration_rate = if (attempts > 0) {
            Float.fromInt(state.total_registrations) / Float.fromInt(attempts)
        } else { 0.0 };
        
        let drift_rate = if (total > 0) {
            Float.fromInt(state.drift_detections) / Float.fromInt(total)
        } else { 0.0 };
        
        // Count by state
        var confirmed : Nat = 0;
        var fragmented : Nat = 0;
        var hidden : Nat = 0;
        var inverted : Nat = 0;
        var hybridized : Nat = 0;
        var unreached : Nat = 0;
        
        for (entity in state.entities.vals()) {
            switch (entity.primitive_trace.primitive_state) {
                case (#PRIMITIVE_CONFIRMED) { confirmed += 1 };
                case (#PRIMITIVE_FRAGMENTED) { fragmented += 1 };
                case (#PRIMITIVE_HIDDEN) { hidden += 1 };
                case (#PRIMITIVE_INVERTED) { inverted += 1 };
                case (#PRIMITIVE_HYBRIDIZED) { hybridized += 1 };
                case (#PRIMITIVE_UNREACHED) { unreached += 1 };
                case (_) {};
            };
        };
        
        {
            registry_id = state.registry_id;
            total_entities = total;
            total_registrations = state.total_registrations;
            total_rejections = state.total_rejections;
            total_verifications = state.total_verifications;
            drift_detections = state.drift_detections;
            registration_rate = registration_rate;
            drift_rate = drift_rate;
            entities_by_state = [
                ("CONFIRMED", confirmed),
                ("FRAGMENTED", fragmented),
                ("HIDDEN", hidden),
                ("INVERTED", inverted),
                ("HYBRIDIZED", hybridized),
                ("UNREACHED", unreached)
            ];
            entities_by_type = [];  // Would be computed similarly
        }
    };
}
