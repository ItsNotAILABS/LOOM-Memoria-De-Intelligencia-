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
 * UNIVERSAL PRIMITIVE ENGINE — Four-Phase Primitive Recovery System
 * 
 * ═══════════════════════════════════════════════════════════════════════════
 * 
 * ENGINE PURPOSE:
 *   This engine runs on any entity in the registry and performs four phases:
 * 
 *   PHASE 1 — STRIP
 *     Remove wrappers, labels, and current packaging
 *     Strip away naming wrappers, abstraction wrappers, convenience wrappers,
 *     historical wrappers, regulatory wrappers, marketing wrappers, 
 *     technical wrappers, cultural wrappers
 * 
 *   PHASE 2 — DESCEND
 *     Walk backward through the stack until the primitive is found
 *     Trace through each architectural layer
 *     Follow dependencies downward
 *     Record each layer's abstractions
 * 
 *   PHASE 3 — VERIFY
 *     Test whether the primitive is actually primitive or only an earlier wrapper
 *     Check: Is it alive? Is it false? Is it damaged? Is it split?
 *            Is it hybridized? Is it inverted? Is it concealed?
 * 
 *   PHASE 4 — RECOMPOSE
 *     Rebuild the entity outward while preserving primitive continuity
 *     Path: primitive → substrate → structure → signal → interface → expression
 * 
 * ═══════════════════════════════════════════════════════════════════════════
 * 
 * ENGINE I/O:
 * 
 *   INPUTS:
 *     - entity_id
 *     - entity_type
 *     - current_expression
 *     - known_layers
 *     - doctrine_context
 *     - history_context
 *     - cross_domain_references
 * 
 *   OUTPUTS:
 *     - primitive_form
 *     - primitive_confidence_score
 *     - drift_map
 *     - recomposition_blueprint
 *     - related_laws
 *     - organism_registry_link
 *     - document_registry_link
 *     - implementation_targets
 *     - primitive_state
 * 
 * ═══════════════════════════════════════════════════════════════════════════
 * 
 * Attribution: Alfredo Medina Hernandez — Founder, Architect of MEDINA
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import UniversalPrimitiveLaw "UniversalPrimitiveLaw";

module {
    // ================================================================== //
    // ENGINE CONSTANTS                                                     //
    // ================================================================== //
    
    /// Engine name
    public let ENGINE_NAME : Text = "Universal Primitive Engine";
    
    /// Engine version
    public let ENGINE_VERSION : Text = "1.0.0";
    
    /// Maximum descent depth before giving up
    public let MAX_DESCENT_DEPTH : Nat = 100;
    
    /// Minimum confidence to consider primitive valid
    public let MIN_PRIMITIVE_CONFIDENCE : Float = 0.5;
    
    /// Golden ratio for calculations
    public let PHI : Float = MatalkoICP.PHI;
    
    // ================================================================== //
    // ENGINE INPUT/OUTPUT TYPES                                            //
    // ================================================================== //
    
    /// Engine input specification
    public type EngineInput = {
        entity_id: Text;
        entity_type: UniversalPrimitiveLaw.EntityDomain;
        current_expression: Text;
        known_layers: [Text];
        doctrine_context: ?Text;
        history_context: ?Text;
        cross_domain_references: [CrossDomainReference];
    };
    
    /// Cross-domain reference
    public type CrossDomainReference = {
        ref_id: Text;
        source_domain: UniversalPrimitiveLaw.EntityDomain;
        target_domain: UniversalPrimitiveLaw.EntityDomain;
        relationship: Text;
        relevance: Float;
    };
    
    /// Engine output specification
    public type EngineOutput = {
        entity_id: Text;
        primitive_form: ?Text;
        primitive_confidence_score: Float;
        primitive_state: UniversalPrimitiveLaw.PrimitiveState;
        drift_map: [DriftMapEntry];
        recomposition_blueprint: ?UniversalPrimitiveLaw.RecompositionBlueprint;
        related_laws: [Text];
        organism_registry_link: ?Text;
        document_registry_link: ?Text;
        implementation_targets: [Text];
        phase_results: PhaseResults;
        processing_time_ns: Int;
        timestamp: Int;
    };
    
    /// Drift map entry
    public type DriftMapEntry = {
        layer: Text;
        drift_type: UniversalPrimitiveLaw.DriftType;
        severity: Float;
        description: Text;
    };
    
    /// Results from each phase
    public type PhaseResults = {
        strip_result: StripResult;
        descend_result: DescendResult;
        verify_result: VerifyResult;
        recompose_result: RecomposeResult;
    };
    
    // ================================================================== //
    // PHASE 1: STRIP — Remove wrappers, labels, packaging                  //
    // ================================================================== //
    
    /// Result of strip phase
    public type StripResult = {
        original_expression: Text;
        stripped_expression: Text;
        removed_wrappers: [RemovedWrapper];
        wrapper_count: Nat;
        stripping_complete: Bool;
    };
    
    /// A wrapper that was removed
    public type RemovedWrapper = {
        wrapper_type: UniversalPrimitiveLaw.WrapperType;
        wrapper_content: Text;
        layer_depth: Nat;
        reason_removed: Text;
    };
    
    /// Phase 1: Strip all wrappers from the expression
    public func phase1Strip(input: EngineInput) : StripResult {
        let wrappers = Buffer.Buffer<RemovedWrapper>(8);
        var current = input.current_expression;
        var depth : Nat = 0;
        
        // Check for naming wrapper (different name than function)
        let namingWrapper = detectNamingWrapper(current, input.entity_type);
        switch (namingWrapper) {
            case (?w) { 
                wrappers.add(w);
                depth += 1;
            };
            case (null) {};
        };
        
        // Check for abstraction wrapper
        let abstractionWrapper = detectAbstractionWrapper(current, input.known_layers);
        switch (abstractionWrapper) {
            case (?w) { 
                wrappers.add(w);
                depth += 1;
            };
            case (null) {};
        };
        
        // Check for convenience wrapper
        let convenienceWrapper = detectConvenienceWrapper(current, input.entity_type);
        switch (convenienceWrapper) {
            case (?w) { 
                wrappers.add(w);
                depth += 1;
            };
            case (null) {};
        };
        
        // Check for marketing wrapper
        let marketingWrapper = detectMarketingWrapper(current);
        switch (marketingWrapper) {
            case (?w) { 
                wrappers.add(w);
                depth += 1;
            };
            case (null) {};
        };
        
        // Strip identified wrappers from expression
        let stripped = if (wrappers.size() > 0) {
            stripWrappers(current, Buffer.toArray(wrappers))
        } else {
            current
        };
        
        {
            original_expression = input.current_expression;
            stripped_expression = stripped;
            removed_wrappers = Buffer.toArray(wrappers);
            wrapper_count = wrappers.size();
            stripping_complete = true;
        }
    };
    
    /// Detect naming wrapper (name doesn't match function)
    func detectNamingWrapper(expression: Text, domain: UniversalPrimitiveLaw.EntityDomain) : ?RemovedWrapper {
        // Check if the expression contains marketing/branding terms
        let marketingTerms = ["premium", "pro", "ultra", "next-gen", "revolutionary", "innovative", "smart"];
        for (term in marketingTerms.vals()) {
            if (Text.contains(expression, #text term)) {
                return ?{
                    wrapper_type = #NamingWrapper;
                    wrapper_content = term;
                    layer_depth = 0;
                    reason_removed = "Marketing terminology obscures primitive function";
                };
            };
        };
        null
    };
    
    /// Detect abstraction wrapper
    func detectAbstractionWrapper(expression: Text, known_layers: [Text]) : ?RemovedWrapper {
        // If there are known deeper layers, current is abstraction
        if (known_layers.size() > 1) {
            return ?{
                wrapper_type = #AbstractionWrapper;
                wrapper_content = "Abstraction layer over " # Nat.toText(known_layers.size()) # " deeper layers";
                layer_depth = 1;
                reason_removed = "Deeper architectural layers exist";
            };
        };
        null
    };
    
    /// Detect convenience wrapper
    func detectConvenienceWrapper(expression: Text, domain: UniversalPrimitiveLaw.EntityDomain) : ?RemovedWrapper {
        // Check for convenience patterns
        let convenienceTerms = ["helper", "util", "wrapper", "adapter", "facade", "proxy"];
        for (term in convenienceTerms.vals()) {
            if (Text.contains(expression, #text term)) {
                return ?{
                    wrapper_type = #ConvenienceWrapper;
                    wrapper_content = term;
                    layer_depth = 1;
                    reason_removed = "Convenience pattern indicates underlying primitive";
                };
            };
        };
        null
    };
    
    /// Detect marketing wrapper
    func detectMarketingWrapper(expression: Text) : ?RemovedWrapper {
        let brandingTerms = ["™", "®", "brand", "trademark", "patent"];
        for (term in brandingTerms.vals()) {
            if (Text.contains(expression, #text term)) {
                return ?{
                    wrapper_type = #MarketingWrapper;
                    wrapper_content = term;
                    layer_depth = 0;
                    reason_removed = "Commercial packaging obscures primitive";
                };
            };
        };
        null
    };
    
    /// Remove wrappers from expression
    func stripWrappers(expression: Text, wrappers: [RemovedWrapper]) : Text {
        var result = expression;
        for (wrapper in wrappers.vals()) {
            // Simple stripping - would be more sophisticated in production
            result := Text.replace(result, #text wrapper.wrapper_content, "");
        };
        result
    };
    
    // ================================================================== //
    // PHASE 2: DESCEND — Walk backward through stack to primitive          //
    // ================================================================== //
    
    /// Result of descend phase
    public type DescendResult = {
        starting_layer: Text;
        layers_traversed: [UniversalPrimitiveLaw.ArchitecturalLayer];
        primitive_candidate: ?Text;
        descent_depth: Nat;
        descent_complete: Bool;
        gaps_encountered: [Text];
        branches_found: Nat;
    };
    
    /// Phase 2: Descend through architectural layers to find primitive
    public func phase2Descend(
        input: EngineInput,
        strip_result: StripResult
    ) : DescendResult {
        let layers = Buffer.Buffer<UniversalPrimitiveLaw.ArchitecturalLayer>(16);
        let gaps = Buffer.Buffer<Text>(4);
        var current_depth : Nat = 0;
        var primitive_found : ?Text = null;
        var branches : Nat = 0;
        
        // Start from stripped expression
        let starting = strip_result.stripped_expression;
        
        // Add surface layer
        layers.add({
            layer_id = "layer_0";
            layer_name = "Surface Expression";
            layer_depth = 0;
            is_primitive = false;
            description = starting;
            dependencies = [];
            abstractions = [];
            wrapper_type = null;
        });
        
        // Traverse known layers
        for (i in Iter.range(0, input.known_layers.size() - 1)) {
            current_depth += 1;
            let layer_name = input.known_layers[i];
            let is_last = i == input.known_layers.size() - 1;
            
            layers.add({
                layer_id = "layer_" # Nat.toText(current_depth);
                layer_name = layer_name;
                layer_depth = current_depth;
                is_primitive = is_last;  // Assume deepest known is primitive candidate
                description = "Known layer: " # layer_name;
                dependencies = if (i > 0) { [input.known_layers[i-1]] } else { [] };
                abstractions = [];
                wrapper_type = null;
            });
            
            if (is_last) {
                primitive_found := ?layer_name;
            };
        };
        
        // Use doctrine context to find deeper layers
        switch (input.doctrine_context) {
            case (?doctrine) {
                current_depth += 1;
                layers.add({
                    layer_id = "layer_" # Nat.toText(current_depth);
                    layer_name = "Doctrine Foundation";
                    layer_depth = current_depth;
                    is_primitive = true;
                    description = doctrine;
                    dependencies = [];
                    abstractions = [];
                    wrapper_type = null;
                });
                primitive_found := ?doctrine;
            };
            case (null) {
                if (input.known_layers.size() == 0) {
                    gaps.add("No known layers or doctrine context - cannot descend");
                };
            };
        };
        
        // Use history context for additional depth
        switch (input.history_context) {
            case (?history) {
                // History provides earliest known form
                current_depth += 1;
                layers.add({
                    layer_id = "layer_" # Nat.toText(current_depth);
                    layer_name = "Historical Origin";
                    layer_depth = current_depth;
                    is_primitive = true;
                    description = history;
                    dependencies = [];
                    abstractions = [];
                    wrapper_type = null;
                });
                primitive_found := ?history;
            };
            case (null) {};
        };
        
        // Check cross-domain references for branches
        for (ref in input.cross_domain_references.vals()) {
            if (ref.relevance > 0.5) {
                branches += 1;
            };
        };
        
        {
            starting_layer = starting;
            layers_traversed = Buffer.toArray(layers);
            primitive_candidate = primitive_found;
            descent_depth = current_depth;
            descent_complete = primitive_found != null;
            gaps_encountered = Buffer.toArray(gaps);
            branches_found = branches;
        }
    };
    
    // ================================================================== //
    // PHASE 3: VERIFY — Test if primitive is actually primitive            //
    // ================================================================== //
    
    /// Result of verify phase
    public type VerifyResult = {
        candidate: ?Text;
        health_check: UniversalPrimitiveLaw.PrimitiveHealthCheck;
        primitive_state: UniversalPrimitiveLaw.PrimitiveState;
        confidence: Float;
        verification_tests: [VerificationTest];
        is_verified: Bool;
    };
    
    /// A single verification test
    public type VerificationTest = {
        test_name: Text;
        test_question: Text;
        result: Bool;
        evidence: Text;
    };
    
    /// Phase 3: Verify that candidate is actually primitive
    public func phase3Verify(
        input: EngineInput,
        descend_result: DescendResult
    ) : VerifyResult {
        let tests = Buffer.Buffer<VerificationTest>(8);
        
        switch (descend_result.primitive_candidate) {
            case (?candidate) {
                // Test 1: Irreducibility
                let irreducible = testIrreducibility(candidate, descend_result.layers_traversed);
                tests.add(irreducible);
                
                // Test 2: Activity (is it still functional?)
                let active = testActivity(candidate);
                tests.add(active);
                
                // Test 3: Identity persistence
                let identity = testIdentityPersistence(candidate, input.current_expression);
                tests.add(identity);
                
                // Test 4: Contamination
                let contamination = testContamination(candidate);
                tests.add(contamination);
                
                // Test 5: Hybridization
                let hybridization = testHybridization(candidate, input.cross_domain_references);
                tests.add(hybridization);
                
                // Test 6: Inversion
                let inversion = testInversion(candidate);
                tests.add(inversion);
                
                // Test 7: Concealment
                let concealment = testConcealment(candidate, descend_result.gaps_encountered);
                tests.add(concealment);
                
                // Test 8: Precedence
                let precedence = testPrecedence(candidate, input.history_context);
                tests.add(precedence);
                
                // Calculate health check from tests
                let health : UniversalPrimitiveLaw.PrimitiveHealthCheck = {
                    is_alive = active.result;
                    is_false = not precedence.result;
                    is_damaged = contamination.result;
                    is_split = descend_result.branches_found > 1;
                    is_hybridized = hybridization.result;
                    is_inverted = inversion.result;
                    is_concealed = concealment.result;
                };
                
                // Determine primitive state
                let state = determinePrimitiveState(health, irreducible.result);
                
                // Calculate confidence
                var passed : Nat = 0;
                for (test in tests.vals()) {
                    if (test.result) { passed += 1; };
                };
                let confidence = Float.fromInt(passed) / Float.fromInt(tests.size());
                
                {
                    candidate = ?candidate;
                    health_check = health;
                    primitive_state = state;
                    confidence = confidence;
                    verification_tests = Buffer.toArray(tests);
                    is_verified = confidence >= MIN_PRIMITIVE_CONFIDENCE;
                }
            };
            case (null) {
                {
                    candidate = null;
                    health_check = {
                        is_alive = false;
                        is_false = false;
                        is_damaged = false;
                        is_split = false;
                        is_hybridized = false;
                        is_inverted = false;
                        is_concealed = true;
                    };
                    primitive_state = #PRIMITIVE_UNREACHED;
                    confidence = 0.0;
                    verification_tests = Buffer.toArray(tests);
                    is_verified = false;
                }
            };
        }
    };
    
    /// Test if candidate is irreducible
    func testIrreducibility(candidate: Text, layers: [UniversalPrimitiveLaw.ArchitecturalLayer]) : VerificationTest {
        // Check if there are no deeper layers
        let deepest = if (layers.size() > 0) {
            layers[layers.size() - 1]
        } else {
            { layer_id = ""; layer_name = ""; layer_depth = 0; is_primitive = false; 
              description = ""; dependencies = []; abstractions = []; wrapper_type = null }
        };
        
        {
            test_name = "Irreducibility Test";
            test_question = "Is this actually irreducible, or can it be traced further back?";
            result = deepest.is_primitive;
            evidence = "Layer depth: " # Nat.toText(deepest.layer_depth);
        }
    };
    
    /// Test if candidate is active
    func testActivity(candidate: Text) : VerificationTest {
        // Active means still functional, not just historical
        let is_active = Text.size(candidate) > 0;
        {
            test_name = "Activity Test";
            test_question = "Is this active (functional) or just historical?";
            result = is_active;
            evidence = if (is_active) { "Candidate has content" } else { "Candidate is empty" };
        }
    };
    
    /// Test if identity persists without candidate
    func testIdentityPersistence(candidate: Text, expression: Text) : VerificationTest {
        // If removing candidate would destroy identity, it's core
        let is_essential = not Text.contains(expression, #text candidate);
        {
            test_name = "Identity Persistence Test";
            test_question = "Does identity persist if this is removed?";
            result = not is_essential;  // If essential, identity doesn't persist
            evidence = if (is_essential) { "Primitive is distinct from expression" } 
                       else { "Primitive may be surface element" };
        }
    };
    
    /// Test for contamination
    func testContamination(candidate: Text) : VerificationTest {
        // Check for signs of downstream additions
        let contaminants = ["v2", "new", "improved", "updated", "modified"];
        var contaminated = false;
        for (term in contaminants.vals()) {
            if (Text.contains(candidate, #text term)) {
                contaminated := true;
            };
        };
        {
            test_name = "Contamination Test";
            test_question = "Is this contaminated with downstream additions?";
            result = contaminated;
            evidence = if (contaminated) { "Contains modification markers" } 
                       else { "No modification markers found" };
        }
    };
    
    /// Test for hybridization
    func testHybridization(candidate: Text, refs: [CrossDomainReference]) : VerificationTest {
        // Multiple cross-domain refs with high relevance = potential hybridization
        var high_relevance_count : Nat = 0;
        for (ref in refs.vals()) {
            if (ref.relevance > 0.7) {
                high_relevance_count += 1;
            };
        };
        {
            test_name = "Hybridization Test";
            test_question = "Has this been hybridized with incompatible elements?";
            result = high_relevance_count > 2;
            evidence = "Cross-domain references: " # Nat.toText(high_relevance_count);
        }
    };
    
    /// Test for inversion
    func testInversion(candidate: Text) : VerificationTest {
        // Check for cause/effect inversion markers
        let inversionMarkers = ["because of", "due to", "caused by", "result of"];
        var inverted = false;
        for (marker in inversionMarkers.vals()) {
            if (Text.contains(candidate, #text marker)) {
                inverted := true;
            };
        };
        {
            test_name = "Inversion Test";
            test_question = "Has cause/effect been inverted?";
            result = inverted;
            evidence = if (inverted) { "Contains causal inversion markers" } 
                       else { "No inversion markers found" };
        }
    };
    
    /// Test for concealment
    func testConcealment(candidate: Text, gaps: [Text]) : VerificationTest {
        {
            test_name = "Concealment Test";
            test_question = "Is this concealed behind unnecessary abstractions?";
            result = gaps.size() > 0;
            evidence = "Gaps in descent: " # Nat.toText(gaps.size());
        }
    };
    
    /// Test for precedence
    func testPrecedence(candidate: Text, history: ?Text) : VerificationTest {
        let precedes = switch (history) {
            case (?h) { true };  // Has historical context
            case (null) { false };
        };
        {
            test_name = "Precedence Test";
            test_question = "Does this predate the current expression?";
            result = precedes;
            evidence = switch (history) {
                case (?h) { "Historical context: " # h };
                case (null) { "No historical context available" };
            };
        }
    };
    
    /// Determine primitive state from health check
    func determinePrimitiveState(
        health: UniversalPrimitiveLaw.PrimitiveHealthCheck,
        irreducible: Bool
    ) : UniversalPrimitiveLaw.PrimitiveState {
        if (not health.is_alive) {
            return #PRIMITIVE_UNREACHED;
        };
        if (health.is_false) {
            return #PRIMITIVE_HIDDEN;
        };
        if (health.is_split) {
            return #PRIMITIVE_FRAGMENTED;
        };
        if (health.is_inverted) {
            return #PRIMITIVE_INVERTED;
        };
        if (health.is_hybridized) {
            return #PRIMITIVE_HYBRIDIZED;
        };
        if (health.is_damaged) {
            return #PRIMITIVE_CONTAMINATED;
        };
        if (irreducible and health.is_alive and not health.is_concealed) {
            return #PRIMITIVE_CONFIRMED;
        };
        #PRIMITIVE_UNREACHED
    };
    
    // ================================================================== //
    // PHASE 4: RECOMPOSE — Rebuild from primitive preserving continuity    //
    // ================================================================== //
    
    /// Result of recompose phase
    public type RecomposeResult = {
        primitive_source: ?Text;
        recomposition_path: ?UniversalPrimitiveLaw.RecompositionPath;
        steps: [UniversalPrimitiveLaw.RecompositionStep];
        blueprint: ?UniversalPrimitiveLaw.RecompositionBlueprint;
        recomposition_complete: Bool;
        drift_detected: Bool;
        drift_points: [Text];
    };
    
    /// Phase 4: Recompose from primitive outward
    public func phase4Recompose(
        input: EngineInput,
        verify_result: VerifyResult
    ) : RecomposeResult {
        switch (verify_result.candidate) {
            case (?primitive) {
                if (not verify_result.is_verified) {
                    return {
                        primitive_source = ?primitive;
                        recomposition_path = null;
                        steps = [];
                        blueprint = null;
                        recomposition_complete = false;
                        drift_detected = true;
                        drift_points = ["Primitive not verified - recomposition blocked"];
                    };
                };
                
                // Build recomposition path
                let path : UniversalPrimitiveLaw.RecompositionPath = {
                    primitive = primitive;
                    substrate = "Foundational layer derived from " # primitive;
                    structure = "Structural organization of substrate";
                    signal = "Communication/signal layer";
                    interface = "Interaction surface";
                    expression = input.current_expression;
                };
                
                // Build recomposition steps
                let steps = Buffer.Buffer<UniversalPrimitiveLaw.RecompositionStep>(5);
                
                // Step 1: Primitive → Substrate
                steps.add({
                    step_number = 1;
                    from_layer = "Primitive";
                    to_layer = "Substrate";
                    transformation = "Ground primitive in foundational layer";
                    preserves = ["Core function", "Essential identity"];
                    risks = ["Abstraction creep", "Feature addition"];
                });
                
                // Step 2: Substrate → Structure
                steps.add({
                    step_number = 2;
                    from_layer = "Substrate";
                    to_layer = "Structure";
                    transformation = "Organize substrate into coherent structure";
                    preserves = ["Substrate integrity", "Functional relationships"];
                    risks = ["Over-engineering", "Unnecessary complexity"];
                });
                
                // Step 3: Structure → Signal
                steps.add({
                    step_number = 3;
                    from_layer = "Structure";
                    to_layer = "Signal";
                    transformation = "Add communication/signal capabilities";
                    preserves = ["Structural integrity", "Information flow"];
                    risks = ["Signal noise", "Information loss"];
                });
                
                // Step 4: Signal → Interface
                steps.add({
                    step_number = 4;
                    from_layer = "Signal";
                    to_layer = "Interface";
                    transformation = "Create interaction surface";
                    preserves = ["Signal fidelity", "Accessibility"];
                    risks = ["Interface bloat", "Usability drift"];
                });
                
                // Step 5: Interface → Expression
                steps.add({
                    step_number = 5;
                    from_layer = "Interface";
                    to_layer = "Expression";
                    transformation = "Manifest final expression";
                    preserves = ["Interface contract", "Primitive continuity"];
                    risks = ["Marketing wrapper", "Name drift"];
                });
                
                // Build blueprint
                let blueprint : UniversalPrimitiveLaw.RecompositionBlueprint = {
                    entity_id = input.entity_id;
                    primitive_source = primitive;
                    path = path;
                    steps = Buffer.toArray(steps);
                    constraints = [
                        "Must preserve primitive identity at each layer",
                        "Must maintain functional continuity",
                        "Must not add unnecessary abstractions"
                    ];
                    warnings = [
                        "Monitor for abstraction drift",
                        "Watch for feature creep",
                        "Guard against naming confusion"
                    ];
                    confidence = verify_result.confidence;
                };
                
                // Check for drift between recomposed and current
                let drift_detected = input.current_expression != path.expression;
                
                {
                    primitive_source = ?primitive;
                    recomposition_path = ?path;
                    steps = Buffer.toArray(steps);
                    blueprint = ?blueprint;
                    recomposition_complete = true;
                    drift_detected = drift_detected;
                    drift_points = if (drift_detected) {
                        ["Expression diverges from primitive-based recomposition"]
                    } else { [] };
                }
            };
            case (null) {
                {
                    primitive_source = null;
                    recomposition_path = null;
                    steps = [];
                    blueprint = null;
                    recomposition_complete = false;
                    drift_detected = false;
                    drift_points = ["No primitive to recompose from"];
                }
            };
        }
    };
    
    // ================================================================== //
    // ENGINE STATE                                                         //
    // ================================================================== //
    
    /// Engine state
    public type EngineState = {
        var engine_id: Text;
        var total_processed: Nat;
        var primitives_found: Nat;
        var primitives_verified: Nat;
        var drift_detections: Nat;
        var processing_history: [EngineOutput];
        var created_at: Int;
        var last_processed_at: Int;
    };
    
    /// Initialize engine state
    public func init() : EngineState {
        {
            var engine_id = "universal_primitive_engine_" # Int.toText(Time.now());
            var total_processed = 0;
            var primitives_found = 0;
            var primitives_verified = 0;
            var drift_detections = 0;
            var processing_history = [];
            var created_at = Time.now();
            var last_processed_at = Time.now();
        }
    };
    
    // ================================================================== //
    // MAIN ENGINE FUNCTIONS                                                //
    // ================================================================== //
    
    /// Main engine entry point: Process entity through all four phases
    public func processEntity(state: EngineState, input: EngineInput) : (EngineState, EngineOutput) {
        let start_time = Time.now();
        
        // Phase 1: Strip
        let strip_result = phase1Strip(input);
        
        // Phase 2: Descend
        let descend_result = phase2Descend(input, strip_result);
        
        // Phase 3: Verify
        let verify_result = phase3Verify(input, descend_result);
        
        // Phase 4: Recompose
        let recompose_result = phase4Recompose(input, verify_result);
        
        // Build drift map
        let drift_map = Buffer.Buffer<DriftMapEntry>(4);
        if (recompose_result.drift_detected) {
            drift_map.add({
                layer = "Expression";
                drift_type = #FunctionDrift;
                severity = 0.5;
                description = "Current expression diverges from primitive-based recomposition";
            });
        };
        for (gap in descend_result.gaps_encountered.vals()) {
            drift_map.add({
                layer = "Unknown";
                drift_type = #AbstractionDrift;
                severity = 0.3;
                description = gap;
            });
        };
        
        // Determine related laws
        let related_laws = [
            "L-130 — Universal Primitive Law",
            "L-130.1 — Primitive Precedes Expression",
            "L-130.2 — Primitive Governs Recomposition",
            "L-130.3 — Primitive Drift Causes Architectural Falsehood",
            "L-130.4 — Primitive Recovery Restores Sovereignty"
        ];
        
        // Build output
        let output : EngineOutput = {
            entity_id = input.entity_id;
            primitive_form = verify_result.candidate;
            primitive_confidence_score = verify_result.confidence;
            primitive_state = verify_result.primitive_state;
            drift_map = Buffer.toArray(drift_map);
            recomposition_blueprint = recompose_result.blueprint;
            related_laws = related_laws;
            organism_registry_link = ?"organism_registry_" # input.entity_id;
            document_registry_link = ?"document_registry_" # input.entity_id;
            implementation_targets = [
                "Update entity registry with primitive trace",
                "Add to primitive registry",
                "Link to DOC-PRIMITIVA-130"
            ];
            phase_results = {
                strip_result = strip_result;
                descend_result = descend_result;
                verify_result = verify_result;
                recompose_result = recompose_result;
            };
            processing_time_ns = Time.now() - start_time;
            timestamp = Time.now();
        };
        
        // Update state
        state.total_processed += 1;
        if (verify_result.candidate != null) {
            state.primitives_found += 1;
        };
        if (verify_result.is_verified) {
            state.primitives_verified += 1;
        };
        if (recompose_result.drift_detected) {
            state.drift_detections += 1;
        };
        state.last_processed_at := Time.now();
        
        // Add to history (keep last 100)
        let history = Buffer.fromArray<EngineOutput>(state.processing_history);
        history.add(output);
        if (history.size() > 100) {
            let _ = history.remove(0);
        };
        state.processing_history := Buffer.toArray(history);
        
        (state, output)
    };
    
    /// Convenience function: Detect primitive
    public func detectPrimitive(state: EngineState, input: EngineInput) : (EngineState, ?Text) {
        let (newState, output) = processEntity(state, input);
        (newState, output.primitive_form)
    };
    
    /// Convenience function: Descend layers
    public func descendLayers(state: EngineState, input: EngineInput) : DescendResult {
        let strip_result = phase1Strip(input);
        phase2Descend(input, strip_result)
    };
    
    /// Convenience function: Validate primitive
    public func validatePrimitive(
        state: EngineState,
        input: EngineInput
    ) : VerifyResult {
        let strip_result = phase1Strip(input);
        let descend_result = phase2Descend(input, strip_result);
        phase3Verify(input, descend_result)
    };
    
    /// Convenience function: Map recomposition
    public func mapRecomposition(
        state: EngineState,
        input: EngineInput
    ) : RecomposeResult {
        let strip_result = phase1Strip(input);
        let descend_result = phase2Descend(input, strip_result);
        let verify_result = phase3Verify(input, descend_result);
        phase4Recompose(input, verify_result)
    };
    
    /// Convenience function: Compare current to recomposed
    public func compareCurrentToRecomposed(
        state: EngineState,
        input: EngineInput
    ) : { drift_detected: Bool; drift_points: [Text]; confidence: Float } {
        let (_, output) = processEntity(state, input);
        {
            drift_detected = output.phase_results.recompose_result.drift_detected;
            drift_points = output.phase_results.recompose_result.drift_points;
            confidence = output.primitive_confidence_score;
        }
    };
    
    // ================================================================== //
    // ENGINE STATISTICS                                                    //
    // ================================================================== //
    
    /// Get engine statistics
    public func getStatistics(state: EngineState) : {
        engine_id: Text;
        total_processed: Nat;
        primitives_found: Nat;
        primitives_verified: Nat;
        drift_detections: Nat;
        verification_rate: Float;
        drift_rate: Float;
        created_at: Int;
        last_processed_at: Int;
    } {
        let verification_rate = if (state.primitives_found > 0) {
            Float.fromInt(state.primitives_verified) / Float.fromInt(state.primitives_found)
        } else { 0.0 };
        
        let drift_rate = if (state.total_processed > 0) {
            Float.fromInt(state.drift_detections) / Float.fromInt(state.total_processed)
        } else { 0.0 };
        
        {
            engine_id = state.engine_id;
            total_processed = state.total_processed;
            primitives_found = state.primitives_found;
            primitives_verified = state.primitives_verified;
            drift_detections = state.drift_detections;
            verification_rate = verification_rate;
            drift_rate = drift_rate;
            created_at = state.created_at;
            last_processed_at = state.last_processed_at;
        }
    };
}
