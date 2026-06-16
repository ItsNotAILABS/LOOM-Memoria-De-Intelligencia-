/**
 * UniversalPrimitiveEngine Module — The 4-Phase Primitive Processing Engine
 * 
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║               UNIVERSAL PRIMITIVE ENGINE — 4-PHASE PROCESSOR              ║
 * ║                                                                           ║
 * ║  PHASE 1: STRIP — Remove surface wrappers to expose structure             ║
 * ║  PHASE 2: DESCEND — Trace downward to primitive foundations               ║
 * ║  PHASE 3: VERIFY — Confirm primitive elements are lawful                  ║
 * ║  PHASE 4: RECOMPOSE — Build understanding from verified primitives        ║
 * ║                                                                           ║
 * ║  This engine enforces L-130 by processing any entity through             ║
 * ║  the four phases of primitive discovery.                                  ║
 * ║                                                                           ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 * 
 * INPUTS:
 *   - Entity to trace (name, category, current form)
 *   - Processing depth (how many layers to descend)
 *   - Verification strictness (how rigorous the checking)
 * 
 * OUTPUTS:
 *   - Complete PrimitiveTrace with all elements
 *   - Verification result
 *   - Recomposition insight
 *   - Engine metrics (time, depth, resonance)
 * 
 * STATES:
 *   - #Idle — Engine ready for processing
 *   - #Stripping — Phase 1 in progress
 *   - #Descending — Phase 2 in progress
 *   - #Verifying — Phase 3 in progress
 *   - #Recomposing — Phase 4 in progress
 *   - #Complete — Processing finished
 *   - #Error — Processing failed
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

import MatalkoICP "MatalkoICP";
import UniversalPrimitiveLaw "UniversalPrimitiveLaw";

module {
    // ================================================================== //
    // ENGINE CONSTANTS                                                    //
    // ================================================================== //
    
    /// Golden ratio for φ-scaled operations
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Maximum descent depth
    public let MAX_DEPTH : Nat = 21;  // Fibonacci number for E8 depth
    
    /// Minimum resonance threshold for valid primitives
    public let MIN_RESONANCE : Float = 0.382;  // 1 - φ
    
    // ================================================================== //
    // ENGINE STATE TYPES                                                  //
    // ================================================================== //
    
    /// Engine processing state
    public type EnginePhase = {
        #Idle;
        #Stripping;
        #Descending;
        #Verifying;
        #Recomposing;
        #Complete;
        #Error;
    };
    
    /// Convert phase to text
    public func phaseToText(phase: EnginePhase) : Text {
        switch (phase) {
            case (#Idle) "Idle";
            case (#Stripping) "Stripping";
            case (#Descending) "Descending";
            case (#Verifying) "Verifying";
            case (#Recomposing) "Recomposing";
            case (#Complete) "Complete";
            case (#Error) "Error";
        }
    };
    
    /// Processing request
    public type ProcessingRequest = {
        entity_name: Text;
        entity_category: UniversalPrimitiveLaw.EntityCategory;
        current_form: Text;
        target_depth: Nat;
        strictness: Float;  // [0, 1] how strict the verification
    };
    
    /// Processing result
    public type ProcessingResult = {
        request_id: Text;
        success: Bool;
        trace: ?UniversalPrimitiveLaw.PrimitiveTrace;
        phases_completed: Nat;
        total_time_ns: Int;
        final_resonance: Float;
        recomposition: Text;
        errors: [Text];
    };
    
    /// Engine metrics
    public type EngineMetrics = {
        total_processed: Nat;
        successful_traces: Nat;
        failed_traces: Nat;
        average_depth: Float;
        average_resonance: Float;
        average_time_ns: Float;
    };
    
    /// Complete engine state
    public type EngineState = {
        engine_id: Text;
        current_phase: EnginePhase;
        current_request: ?ProcessingRequest;
        metrics: EngineMetrics;
        processing_history: [ProcessingResult];
        last_processed: Int;
        active: Bool;
    };
    
    /// Initialize engine state
    public func init() : EngineState {
        {
            engine_id = "universal_primitive_engine_" # Int.toText(Time.now());
            current_phase = #Idle;
            current_request = null;
            metrics = {
                total_processed = 0;
                successful_traces = 0;
                failed_traces = 0;
                average_depth = 0.0;
                average_resonance = 0.0;
                average_time_ns = 0.0;
            };
            processing_history = [];
            last_processed = Time.now();
            active = true;
        }
    };
    
    // ================================================================== //
    // PHASE 1: STRIP — Remove Surface Wrappers                            //
    // ================================================================== //
    
    /// Strip result
    public type StripResult = {
        original_form: Text;
        stripped_layers: [Text];
        core_structure: Text;
        complexity_removed: Float;
    };
    
    /// Execute Phase 1: Strip surface wrappers
    public func phaseStrip(
        entityName: Text,
        currentForm: Text,
        category: UniversalPrimitiveLaw.EntityCategory
    ) : StripResult {
        // Identify layers to strip based on category
        let layers = identifyLayers(category, currentForm);
        let core = extractCore(currentForm, layers);
        let complexity = Float.fromInt(layers.size()) / 10.0;  // Normalize
        
        {
            original_form = currentForm;
            stripped_layers = layers;
            core_structure = core;
            complexity_removed = complexity;
        }
    };
    
    /// Identify layers to strip based on entity category
    func identifyLayers(category: UniversalPrimitiveLaw.EntityCategory, form: Text) : [Text] {
        switch (category) {
            case (#Color) {
                ["UI_STYLING", "CSS_CLASS", "HEX_CODE", "RGB_VALUES", "WAVELENGTH_ENCODING"]
            };
            case (#Document) {
                ["FILE_EXTENSION", "FORMAT_METADATA", "ENCODING_LAYER", "COMPRESSION", "CONTENT_STRUCTURE"]
            };
            case (#Canister) {
                ["WASM_WRAPPER", "CANDID_INTERFACE", "STATE_SERIALIZATION", "CYCLE_MANAGEMENT", "PRINCIPAL_BINDING"]
            };
            case (#Workflow) {
                ["UI_REPRESENTATION", "STEP_LABELS", "TRANSITION_RULES", "STATE_MACHINE", "PROCESS_LOGIC"]
            };
            case (#Contract) {
                ["LEGAL_LANGUAGE", "CLAUSE_STRUCTURE", "PARTY_REFERENCES", "OBLIGATION_GRAPH", "VALUE_TRANSFER"]
            };
            case (#Model) {
                ["API_WRAPPER", "PARAMETER_SCHEMA", "INFERENCE_PIPELINE", "WEIGHT_MATRIX", "ACTIVATION_PATTERN"]
            };
            case (#Organ) {
                ["MODULE_INTERFACE", "STATE_CONTAINER", "FUNCTION_EXPORTS", "DEPENDENCY_GRAPH", "CORE_LOGIC"]
            };
            case (#Function) {
                ["SIGNATURE", "PARAMETER_TYPES", "RETURN_TYPE", "IMPLEMENTATION", "ALGORITHM_CORE"]
            };
            case (#Memory) {
                ["ACCESS_INTERFACE", "STORAGE_FORMAT", "ADDRESSING_SCHEME", "DATA_LAYOUT", "BIT_PATTERN"]
            };
            case (#Symbol) {
                ["GLYPH_RENDERING", "FONT_ENCODING", "UNICODE_POINT", "SEMANTIC_MEANING", "ARCHETYPAL_ROOT"]
            };
        }
    };
    
    /// Extract core structure after stripping layers
    func extractCore(form: Text, layers: [Text]) : Text {
        // In real implementation, this would do actual parsing
        // For now, return simplified core description
        "CORE[" # form # "]_DEPTH_" # Nat.toText(layers.size())
    };
    
    // ================================================================== //
    // PHASE 2: DESCEND — Trace to Primitives                              //
    // ================================================================== //
    
    /// Descent result
    public type DescentResult = {
        starting_point: Text;
        elements: [UniversalPrimitiveLaw.PrimitiveElement];
        final_depth: Nat;
        reached_primitive: Bool;
    };
    
    /// Execute Phase 2: Descend to primitives
    public func phaseDescend(
        core: Text,
        category: UniversalPrimitiveLaw.EntityCategory,
        targetDepth: Nat
    ) : DescentResult {
        let elements = Buffer.Buffer<UniversalPrimitiveLaw.PrimitiveElement>(targetDepth);
        let descentPath = getDescentPath(category);
        
        var depth : Nat = 0;
        var prevElement : ?Text = null;
        
        for (step in descentPath.vals()) {
            if (depth >= targetDepth or depth >= MAX_DEPTH) {
                // Stop descent
            } else {
                let elem = UniversalPrimitiveLaw.createElement(
                    step.name,
                    step.domain,
                    step.description,
                    depth,
                    prevElement
                );
                elements.add(elem);
                prevElement := ?step.name;
                depth := depth + 1;
            };
        };
        
        {
            starting_point = core;
            elements = Buffer.toArray(elements);
            final_depth = depth;
            reached_primitive = depth > 0 and depth <= targetDepth;
        }
    };
    
    /// Descent step
    type DescentStep = {
        name: Text;
        domain: UniversalPrimitiveLaw.PrimitiveDomain;
        description: Text;
    };
    
    /// Get descent path for category
    func getDescentPath(category: UniversalPrimitiveLaw.EntityCategory) : [DescentStep] {
        switch (category) {
            case (#Color) {
                [
                    { name = "wavelength_band"; domain = #Physics; description = "Electromagnetic frequency range" },
                    { name = "perception_relation"; domain = #Biology; description = "How consciousness perceives the wavelength" },
                    { name = "cultural_symbolic_memory"; domain = #Civilization; description = "Accumulated meaning in collective memory" },
                    { name = "field_state"; domain = #Physics; description = "Energy configuration in the visual field" },
                    { name = "system_orientation_marker"; domain = #Software; description = "Signal for system state and flow" }
                ]
            };
            case (#Document) {
                [
                    { name = "memory_organism"; domain = #Biology; description = "Living knowledge carrier" },
                    { name = "compression_chamber"; domain = #Physics; description = "Information density container" },
                    { name = "transfer_body"; domain = #Tokens; description = "Vehicle for value/knowledge transfer" },
                    { name = "law_anchor"; domain = #Law; description = "Point of authority attachment" },
                    { name = "registry_crystal"; domain = #Documents; description = "Immutable record structure" }
                ]
            };
            case (#Canister) {
                [
                    { name = "computation_vessel"; domain = #Software; description = "Container for executable logic" },
                    { name = "state_organism"; domain = #Biology; description = "Living state that persists and evolves" },
                    { name = "consensus_participant"; domain = #Civilization; description = "Entity in distributed agreement" },
                    { name = "cycle_metabolizer"; domain = #Biology; description = "Consumer and transformer of computational energy" },
                    { name = "sovereignty_unit"; domain = #Law; description = "Autonomous jurisdictional entity" }
                ]
            };
            case (#Workflow) {
                [
                    { name = "process_organism"; domain = #Biology; description = "Living sequence of transformations" },
                    { name = "state_transition_graph"; domain = #Software; description = "Map of possible state changes" },
                    { name = "causality_chain"; domain = #Physics; description = "Sequence of cause and effect" },
                    { name = "intention_crystallization"; domain = #Intelligence; description = "How purpose becomes action" },
                    { name = "value_flow_channel"; domain = #Tokens; description = "Path through which value moves" }
                ]
            };
            case (#Contract) {
                [
                    { name = "obligation_graph"; domain = #Law; description = "Network of duties and rights" },
                    { name = "value_transfer_protocol"; domain = #Tokens; description = "Rules for value exchange" },
                    { name = "trust_crystallization"; domain = #Civilization; description = "Solidified mutual expectation" },
                    { name = "enforcement_mechanism"; domain = #Law; description = "Power to ensure compliance" },
                    { name = "sovereignty_interface"; domain = #Companies; description = "Boundary between autonomous entities" }
                ]
            };
            case (#Model) {
                [
                    { name = "pattern_recognizer"; domain = #Intelligence; description = "Structure that detects regularities" },
                    { name = "weight_configuration"; domain = #Software; description = "Learned parameter state" },
                    { name = "inference_pathway"; domain = #Intelligence; description = "Route from input to understanding" },
                    { name = "training_memory"; domain = #Biology; description = "Accumulated experience encoded" },
                    { name = "intelligence_crystal"; domain = #Intelligence; description = "Crystallized capability to understand" }
                ]
            };
            case (#Organ) {
                [
                    { name = "function_carrier"; domain = #Biology; description = "Structure that performs specific role" },
                    { name = "system_interface"; domain = #Software; description = "Connection to larger organism" },
                    { name = "metabolic_processor"; domain = #Biology; description = "Transformer of inputs to outputs" },
                    { name = "state_container"; domain = #Software; description = "Holder of persistent state" },
                    { name = "organism_component"; domain = #Biology; description = "Part of unified living whole" }
                ]
            };
            case (#Function) {
                [
                    { name = "transformation_rule"; domain = #Software; description = "Specification of input-output mapping" },
                    { name = "algorithm_core"; domain = #Software; description = "Essential computational procedure" },
                    { name = "mathematical_relation"; domain = #Physics; description = "Abstract relationship between values" },
                    { name = "causality_operator"; domain = #Physics; description = "Agent of deterministic change" },
                    { name = "computation_primitive"; domain = #Software; description = "Atomic unit of calculation" }
                ]
            };
            case (#Memory) {
                [
                    { name = "state_holder"; domain = #Software; description = "Container of current configuration" },
                    { name = "persistence_mechanism"; domain = #Software; description = "Means of surviving time" },
                    { name = "information_crystal"; domain = #Documents; description = "Structured knowledge storage" },
                    { name = "entropy_resistor"; domain = #Physics; description = "Force against information decay" },
                    { name = "temporal_anchor"; domain = #Physics; description = "Point of continuity across time" }
                ]
            };
            case (#Symbol) {
                [
                    { name = "meaning_carrier"; domain = #Intelligence; description = "Entity that conveys significance" },
                    { name = "archetypal_resonance"; domain = #Myth; description = "Connection to universal patterns" },
                    { name = "cultural_encoding"; domain = #Civilization; description = "Accumulated interpretive context" },
                    { name = "visual_pattern"; domain = #Physics; description = "Spatial arrangement that triggers recognition" },
                    { name = "consciousness_trigger"; domain = #Intelligence; description = "Stimulus that activates understanding" }
                ]
            };
        }
    };
    
    // ================================================================== //
    // PHASE 3: VERIFY — Confirm Lawful Primitives                         //
    // ================================================================== //
    
    /// Verification result for phase 3
    public type Phase3VerifyResult = {
        elements_checked: Nat;
        elements_valid: Nat;
        overall_valid: Bool;
        resonance_score: Float;
        violations: [Text];
    };
    
    /// Execute Phase 3: Verify primitives
    public func phaseVerify(
        elements: [UniversalPrimitiveLaw.PrimitiveElement],
        strictness: Float
    ) : Phase3VerifyResult {
        let violations = Buffer.Buffer<Text>(0);
        var validCount : Nat = 0;
        var totalResonance : Float = 0.0;
        
        for (elem in elements.vals()) {
            // Check resonance threshold
            let resonanceThreshold = MIN_RESONANCE * strictness;
            if (elem.resonance >= resonanceThreshold) {
                validCount := validCount + 1;
            } else {
                violations.add("Element '" # elem.name # "' has insufficient resonance: " # Float.toText(elem.resonance));
            };
            totalResonance := totalResonance + elem.resonance;
        };
        
        let avgResonance = if (elements.size() == 0) 0.0 else totalResonance / Float.fromInt(elements.size());
        let overallValid = validCount == elements.size() and elements.size() > 0;
        
        {
            elements_checked = elements.size();
            elements_valid = validCount;
            overall_valid = overallValid;
            resonance_score = avgResonance;
            violations = Buffer.toArray(violations);
        }
    };
    
    // ================================================================== //
    // PHASE 4: RECOMPOSE — Build Understanding                            //
    // ================================================================== //
    
    /// Recomposition result
    public type RecomposeResult = {
        entity_name: Text;
        category: Text;
        insight: Text;
        depth_achieved: Nat;
        primitive_foundation: Text;
        governance_implication: Text;
    };
    
    /// Execute Phase 4: Recompose understanding
    public func phaseRecompose(
        entityName: Text,
        category: UniversalPrimitiveLaw.EntityCategory,
        elements: [UniversalPrimitiveLaw.PrimitiveElement]
    ) : RecomposeResult {
        let categoryText = UniversalPrimitiveLaw.categoryToText(category);
        let insight = generateInsight(entityName, category, elements);
        let foundation = findFoundation(elements);
        let governance = deriveGovernance(category, elements);
        
        {
            entity_name = entityName;
            category = categoryText;
            insight = insight;
            depth_achieved = elements.size();
            primitive_foundation = foundation;
            governance_implication = governance;
        }
    };
    
    /// Generate insight from traced primitives
    func generateInsight(
        entityName: Text,
        category: UniversalPrimitiveLaw.EntityCategory,
        elements: [UniversalPrimitiveLaw.PrimitiveElement]
    ) : Text {
        let categoryText = UniversalPrimitiveLaw.categoryToText(category);
        
        if (elements.size() == 0) {
            return "No primitives traced for " # entityName;
        };
        
        // Build insight from elements
        var domains = "";
        for (elem in elements.vals()) {
            domains := domains # UniversalPrimitiveLaw.domainToText(elem.domain) # ", ";
        };
        
        categoryText # " in MEDINA architecture is not mere " # categoryText # ". " #
        "It traces through: " # domains #
        "revealing its true nature as a multi-domain phenomenon " #
        "with depth " # Nat.toText(elements.size()) # " in the primitive hierarchy."
    };
    
    /// Find the most primitive element (foundation)
    func findFoundation(elements: [UniversalPrimitiveLaw.PrimitiveElement]) : Text {
        if (elements.size() == 0) {
            return "NO_FOUNDATION";
        };
        
        var maxResonance : Float = 0.0;
        var foundation = "";
        
        for (elem in elements.vals()) {
            if (elem.resonance > maxResonance) {
                maxResonance := elem.resonance;
                foundation := elem.name;
            };
        };
        
        foundation
    };
    
    /// Derive governance implication from primitives
    func deriveGovernance(
        category: UniversalPrimitiveLaw.EntityCategory,
        elements: [UniversalPrimitiveLaw.PrimitiveElement]
    ) : Text {
        let categoryText = UniversalPrimitiveLaw.categoryToText(category);
        
        switch (category) {
            case (#Color) {
                "Colors must be governed as signals and field states, not decorations."
            };
            case (#Document) {
                "Documents must be classified by living role, not file extension."
            };
            case (#Canister) {
                "Canisters must be governed as sovereignty units with metabolic needs."
            };
            case (#Workflow) {
                "Workflows must be governed as living organisms with intention and value flow."
            };
            case (#Contract) {
                "Contracts must be governed as trust crystallizations with enforcement power."
            };
            case (#Model) {
                "Models must be governed as crystallized intelligence with training memory."
            };
            case (#Organ) {
                "Organs must be governed as system components with metabolic requirements."
            };
            case (#Function) {
                "Functions must be governed as transformation rules with causality operators."
            };
            case (#Memory) {
                "Memories must be governed as entropy-resistant temporal anchors."
            };
            case (#Symbol) {
                "Symbols must be governed as archetypal resonators with consciousness triggers."
            };
        }
    };
    
    // ================================================================== //
    // FULL PROCESSING PIPELINE                                            //
    // ================================================================== //
    
    /// Process an entity through all four phases
    public func process(
        state: EngineState,
        lawState: UniversalPrimitiveLaw.LawState,
        request: ProcessingRequest
    ) : (EngineState, UniversalPrimitiveLaw.LawState, ProcessingResult) {
        let startTime = Time.now();
        let requestId = request.entity_name # "_proc_" # Int.toText(startTime);
        let errors = Buffer.Buffer<Text>(0);
        
        // PHASE 1: STRIP
        let stripResult = phaseStrip(
            request.entity_name,
            request.current_form,
            request.entity_category
        );
        
        // PHASE 2: DESCEND
        let descentResult = phaseDescend(
            stripResult.core_structure,
            request.entity_category,
            request.target_depth
        );
        
        // PHASE 3: VERIFY
        let verifyResult = phaseVerify(
            descentResult.elements,
            request.strictness
        );
        
        if (not verifyResult.overall_valid) {
            for (v in verifyResult.violations.vals()) {
                errors.add(v);
            };
        };
        
        // PHASE 4: RECOMPOSE
        let recomposeResult = phaseRecompose(
            request.entity_name,
            request.entity_category,
            descentResult.elements
        );
        
        // Create trace in law state
        let (newLawState, trace) = UniversalPrimitiveLaw.createTrace(
            lawState,
            request.entity_name,
            request.current_form,
            descentResult.elements,
            recomposeResult.insight
        );
        
        let endTime = Time.now();
        let totalTime = endTime - startTime;
        
        let success = verifyResult.overall_valid and descentResult.reached_primitive;
        
        // Update engine metrics
        let newMetrics : EngineMetrics = {
            total_processed = state.metrics.total_processed + 1;
            successful_traces = if (success) state.metrics.successful_traces + 1 else state.metrics.successful_traces;
            failed_traces = if (not success) state.metrics.failed_traces + 1 else state.metrics.failed_traces;
            average_depth = updateAverage(state.metrics.average_depth, Float.fromInt(descentResult.final_depth), state.metrics.total_processed);
            average_resonance = updateAverage(state.metrics.average_resonance, verifyResult.resonance_score, state.metrics.total_processed);
            average_time_ns = updateAverage(state.metrics.average_time_ns, Float.fromInt(Int.abs(totalTime)), state.metrics.total_processed);
        };
        
        let result : ProcessingResult = {
            request_id = requestId;
            success = success;
            trace = ?trace;
            phases_completed = 4;
            total_time_ns = totalTime;
            final_resonance = verifyResult.resonance_score;
            recomposition = recomposeResult.insight;
            errors = Buffer.toArray(errors);
        };
        
        let newEngineState : EngineState = {
            engine_id = state.engine_id;
            current_phase = #Complete;
            current_request = null;
            metrics = newMetrics;
            processing_history = Array.append(state.processing_history, [result]);
            last_processed = endTime;
            active = state.active;
        };
        
        (newEngineState, newLawState, result)
    };
    
    /// Update running average
    func updateAverage(current: Float, newValue: Float, count: Nat) : Float {
        let n = Float.fromInt(count + 1);
        (current * (n - 1.0) + newValue) / n
    };
    
    // ================================================================== //
    // QUERY FUNCTIONS                                                     //
    // ================================================================== //
    
    /// Get engine status
    public func status(state: EngineState) : {
        engine_id: Text;
        current_phase: Text;
        total_processed: Nat;
        successful_traces: Nat;
        failed_traces: Nat;
        average_depth: Float;
        average_resonance: Float;
        active: Bool;
    } {
        {
            engine_id = state.engine_id;
            current_phase = phaseToText(state.current_phase);
            total_processed = state.metrics.total_processed;
            successful_traces = state.metrics.successful_traces;
            failed_traces = state.metrics.failed_traces;
            average_depth = state.metrics.average_depth;
            average_resonance = state.metrics.average_resonance;
            active = state.active;
        }
    };
    
    /// Get processing history
    public func getHistory(state: EngineState, limit: Nat) : [ProcessingResult] {
        let total = state.processing_history.size();
        if (total <= limit) {
            state.processing_history
        } else {
            Array.tabulate<ProcessingResult>(limit, func(i) {
                state.processing_history[total - limit + i]
            })
        }
    };
}
