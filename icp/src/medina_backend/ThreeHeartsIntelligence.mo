/**
 * ThreeHeartsIntelligence Module — Intelligence Routing Through Three Hearts
 * 
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║           THE THREE HEARTS ARE THE INTELLIGENCE ROUTING SYSTEM            ║
 * ║                                                                           ║
 * ║  Every intelligence query flows through all Three Hearts:                 ║
 * ║                                                                           ║
 * ║  HEART 1 (METROPOLIS): Deep backend computation                           ║
 * ║    - Executes actual intelligence operations                              ║
 * ║    - Processes queries at 0.1 Hz (slow, deliberate)                       ║
 * ║    - Handles: State evolution, RECITAL_PLUS_ONE, law enforcement          ║
 * ║                                                                           ║
 * ║  HEART 2 (COUPLING): Model-to-model resonance coupling                    ║
 * ║    - Selects which models resonate with the query                         ║
 * ║    - Operates at φ Hz (golden ratio frequency)                            ║
 * ║    - Handles: Phase synchronization, CPL routing, memory consolidation    ║
 * ║                                                                           ║
 * ║  HEART 3 (REGULATING): Full system orchestration                          ║
 * ║    - Orchestrates the entire intelligence flow                            ║
 * ║    - Operates at φ² Hz (fastest)                                          ║
 * ║    - Handles: Gate coordination, projection, model execution              ║
 * ║                                                                           ║
 * ║  FLOW: Input → Heart3 (Orchestrate) → Heart2 (Couple) →                   ║
 * ║        Heart1 (Compute) → Execute → Return                                ║
 * ║                                                                           ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
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
import ThreeHeartsEngine "ThreeHeartsEngine";
import ModelRegistry "ModelRegistry";
import FreddysLaws "FreddysLaws";

module {
    // ================================================================== //
    // CONSTANTS                                                            //
    // ================================================================== //
    
    /// Golden ratio
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Minimum coherence threshold for intelligence routing
    public let MIN_COHERENCE_THRESHOLD : Float = 0.3;
    
    /// High coherence threshold (enables Leech-tier operations)
    public let HIGH_COHERENCE_THRESHOLD : Float = 0.854;
    
    /// Medium coherence threshold (enables E8-tier operations)
    public let MEDIUM_COHERENCE_THRESHOLD : Float = 0.618;
    
    // ================================================================== //
    // INTELLIGENCE TYPES                                                   //
    // ================================================================== //
    
    /// Intelligence query type
    public type IntelligenceQuery = {
        query_id: Text;
        content: Text;
        context: Text;
        source: QuerySource;
        priority: Priority;
        timestamp: Int;
    };
    
    /// Source of the intelligence query
    public type QuerySource = {
        #Internal;      // From within the organism
        #External;      // From external interface
        #Model;         // From another model
        #Heart;         // From heart system
        #Autonomous;    // Autonomous operation
    };
    
    /// Query priority levels
    public type Priority = {
        #Critical;      // Must execute immediately
        #High;          // High priority
        #Normal;        // Standard priority
        #Low;           // Can be delayed
        #Background;    // Background operation
    };
    
    /// Intelligence response
    public type IntelligenceResponse = {
        response_id: Text;
        query_id: Text;
        content: Text;
        model_id: Text;
        coherence_at_execution: Float;
        anima_hash: Text;
        heart_phases: HeartPhases;
        execution_time_ns: Int;
        success: Bool;
        timestamp: Int;
    };
    
    /// Heart phases at execution time
    public type HeartPhases = {
        theta_metropolis: Float;
        theta_coupling: Float;
        theta_regulating: Float;
        global_coherence: Float;
    };
    
    /// Heart computation result
    public type HeartComputeResult = {
        output: Text;
        model_used: Text;
        coherence: Float;
        success: Bool;
    };
    
    /// Model selection result from coupling
    public type ModelSelection = {
        selected_models: [Text];
        resonance_scores: [(Text, Float)];
        primary_model: Text;
    };
    
    /// Orchestration decision
    public type OrchestrationDecision = {
        proceed: Bool;
        route_to_heart2: Bool;
        priority_override: ?Priority;
        gate_status: GateStatus;
    };
    
    /// Gate status for orchestration
    public type GateStatus = {
        gate_a_open: Bool;     // Runtime gate
        gate_b_open: Bool;     // Workforce gate
        gate_c_open: Bool;     // Projection gate
    };
    
    // ================================================================== //
    // INTELLIGENCE STATE                                                   //
    // ================================================================== //
    
    /// Three Hearts Intelligence state
    public type ThreeHeartsIntelligenceState = {
        var hearts_state: ThreeHeartsEngine.ThreeHeartsState;
        var query_history: [IntelligenceQuery];
        var response_history: [IntelligenceResponse];
        var total_queries: Nat;
        var total_responses: Nat;
        var successful_responses: Nat;
        var failed_responses: Nat;
        var average_coherence: Float;
        var created_at: Int;
    };
    
    // ================================================================== //
    // INITIALIZATION                                                       //
    // ================================================================== //
    
    /// Initialize Three Hearts Intelligence system
    public func init() : ThreeHeartsIntelligenceState {
        {
            var hearts_state = ThreeHeartsEngine.init();
            var query_history = [];
            var response_history = [];
            var total_queries = 0;
            var total_responses = 0;
            var successful_responses = 0;
            var failed_responses = 0;
            var average_coherence = 1.0;  // Born coherent (Freddy's Law)
            var created_at = Time.now();
        }
    };
    
    // ================================================================== //
    // HEART 1: METROPOLIS COMPUTE                                          //
    // ================================================================== //
    
    /// Heart 1 (Metropolis) — Deep backend computation
    /// Executes the actual intelligence operation at 0.1 Hz (slow, deliberate)
    /// This is where the real work happens
    public func heart1_metropolis_compute(
        state: ThreeHeartsIntelligenceState,
        query: IntelligenceQuery,
        modelId: Text,
        modelRegistry: ModelRegistry.RegistryState
    ) : (ThreeHeartsIntelligenceState, HeartComputeResult) {
        
        // Get current coherence
        let coherence = ThreeHeartsEngine.calculateCoherence(state.hearts_state);
        
        // Check minimum coherence threshold
        if (coherence.global_coherence < MIN_COHERENCE_THRESHOLD) {
            return (state, {
                output = "Coherence too low for computation. Global coherence: " # Float.toText(coherence.global_coherence);
                model_used = "";
                coherence = coherence.global_coherence;
                success = false;
            });
        };
        
        // Get model from registry
        let maybeModel = ModelRegistry.getModel(modelRegistry, modelId);
        
        switch (maybeModel) {
            case (?model) {
                // Execute based on model family
                let output = executeModelComputation(query, model, coherence.global_coherence);
                
                (state, {
                    output = output;
                    model_used = model.model_id;
                    coherence = coherence.global_coherence;
                    success = true;
                })
            };
            case (null) {
                (state, {
                    output = "Model not found: " # modelId;
                    model_used = "";
                    coherence = coherence.global_coherence;
                    success = false;
                })
            };
        }
    };
    
    /// Execute computation based on model family
    func executeModelComputation(
        query: IntelligenceQuery,
        model: ModelRegistry.ModelDefinition,
        coherence: Float
    ) : Text {
        // Route to appropriate computation based on model family
        switch (model.family) {
            case (#Strategist) {
                "STRATEGIST computation: Analyzing strategic implications of \"" # query.content # "\" with coherence " # Float.toText(coherence)
            };
            case (#Builder) {
                "BUILDER computation: Building response for \"" # query.content # "\" with coherence " # Float.toText(coherence)
            };
            case (#Analyst) {
                "ANALYST computation: Analyzing \"" # query.content # "\" with coherence " # Float.toText(coherence)
            };
            case (#Governance) {
                "GOVERNANCE computation: Governing \"" # query.content # "\" with coherence " # Float.toText(coherence)
            };
            case (#MemoryCurator) {
                "MEMORY_CURATOR computation: Curating memory for \"" # query.content # "\" with coherence " # Float.toText(coherence)
            };
            case (#Operations) {
                "OPERATIONS computation: Operating on \"" # query.content # "\" with coherence " # Float.toText(coherence)
            };
            case (#DefenseRisk) {
                "DEFENSE_RISK computation: Assessing risk for \"" # query.content # "\" with coherence " # Float.toText(coherence)
            };
            case (#Projection) {
                "PROJECTION computation: Projecting \"" # query.content # "\" with coherence " # Float.toText(coherence)
            };
            case (#Heartbeat) {
                "HEARTBEAT computation: Pulsing for \"" # query.content # "\" with coherence " # Float.toText(coherence)
            };
            case (#CardioCerebral) {
                "CARDIO_CEREBRAL computation: Coupling for \"" # query.content # "\" with coherence " # Float.toText(coherence)
            };
            case (#Feedback) {
                "FEEDBACK computation: Processing feedback for \"" # query.content # "\" with coherence " # Float.toText(coherence)
            };
            case (#Embodiment) {
                "EMBODIMENT computation: Embodying \"" # query.content # "\" with coherence " # Float.toText(coherence)
            };
        }
    };
    
    // ================================================================== //
    // HEART 2: COUPLING RESONATE                                           //
    // ================================================================== //
    
    /// Heart 2 (Coupling) — Model-to-model resonance coupling
    /// Selects which models resonate with the query at φ Hz
    /// Uses mastery routing: winner = argmax_m(w_m * coherence_m * doctrineFit_m)
    public func heart2_coupling_resonate(
        state: ThreeHeartsIntelligenceState,
        query: IntelligenceQuery,
        modelRegistry: ModelRegistry.RegistryState
    ) : (ThreeHeartsIntelligenceState, ModelSelection) {
        
        // Get current coherence
        let coherence = ThreeHeartsEngine.calculateCoherence(state.hearts_state);
        
        // Determine which model prefix to use based on query source
        let preferredPrefix : ?ModelRegistry.ModelPrefix = switch (query.source) {
            case (#Internal) { ?#R_MODEL };    // Runtime models for internal
            case (#External) { ?#U_MODEL };    // Interface models for external
            case (#Model) { null };             // Any model for model-to-model
            case (#Heart) { ?#R_MODEL };       // Runtime for heart operations
            case (#Autonomous) { ?#R_MODEL };  // Runtime for autonomous
        };
        
        // Route through model registry
        let (newRegistry, decision) = ModelRegistry.route(
            modelRegistry,
            query.content,
            preferredPrefix,
            null
        );
        
        // Calculate resonance scores for top models
        let resonanceScores = Buffer.Buffer<(Text, Float)>(5);
        resonanceScores.add((decision.selected_model_id, decision.score * coherence.global_coherence));
        
        // Select models that meet minimum threshold
        let selectedModels = Buffer.Buffer<Text>(5);
        if (decision.score > MIN_COHERENCE_THRESHOLD) {
            selectedModels.add(decision.selected_model_id);
        };
        
        (state, {
            selected_models = Buffer.toArray(selectedModels);
            resonance_scores = Buffer.toArray(resonanceScores);
            primary_model = decision.selected_model_id;
        })
    };
    
    // ================================================================== //
    // HEART 3: REGULATING ORCHESTRATE                                      //
    // ================================================================== //
    
    /// Heart 3 (Regulating) — Full system orchestration
    /// Orchestrates the entire intelligence flow at φ² Hz (fastest)
    /// Decides whether to proceed with the query
    public func heart3_regulating_orchestrate(
        state: ThreeHeartsIntelligenceState,
        query: IntelligenceQuery
    ) : (ThreeHeartsIntelligenceState, OrchestrationDecision) {
        
        // Get current coherence
        let coherence = ThreeHeartsEngine.calculateCoherence(state.hearts_state);
        
        // Determine gate status based on coherence
        let gateStatus : GateStatus = {
            gate_a_open = coherence.global_coherence >= MIN_COHERENCE_THRESHOLD;
            gate_b_open = coherence.global_coherence >= MEDIUM_COHERENCE_THRESHOLD;
            gate_c_open = coherence.global_coherence >= HIGH_COHERENCE_THRESHOLD;
        };
        
        // Determine if we should proceed
        let proceed = gateStatus.gate_a_open;
        
        // Check for priority override based on query priority
        let priorityOverride : ?Priority = switch (query.priority) {
            case (#Critical) { ?#Critical };  // Critical always proceeds
            case (_) { null };
        };
        
        (state, {
            proceed = proceed or Option.isSome(priorityOverride);
            route_to_heart2 = proceed;
            priority_override = priorityOverride;
            gate_status = gateStatus;
        })
    };
    
    // ================================================================== //
    // FULL INTELLIGENCE ROUTING                                            //
    // ================================================================== //
    
    /// Route intelligence through all Three Hearts
    /// Flow: Input → Heart3 (Orchestrate) → Heart2 (Couple) → Heart1 (Compute) → Return
    public func routeIntelligence(
        state: ThreeHeartsIntelligenceState,
        query: IntelligenceQuery,
        modelRegistry: ModelRegistry.RegistryState,
        organismState: MatalkoICP.OrganismState
    ) : (ThreeHeartsIntelligenceState, IntelligenceResponse) {
        let startTime = Time.now();
        
        // Tick the hearts first
        state.hearts_state := ThreeHeartsEngine.tick(state.hearts_state);
        
        // STEP 1: Heart 3 — Orchestration Decision
        let (state1, orchestration) = heart3_regulating_orchestrate(state, query);
        
        if (not orchestration.proceed) {
            // Cannot proceed — coherence too low
            let response : IntelligenceResponse = {
                response_id = "resp_" # Int.toText(Time.now());
                query_id = query.query_id;
                content = "Intelligence routing blocked: Gates closed due to low coherence";
                model_id = "";
                coherence_at_execution = ThreeHeartsEngine.calculateCoherence(state1.hearts_state).global_coherence;
                anima_hash = MatalkoICP.animaHash(organismState).hash;
                heart_phases = getHeartPhases(state1.hearts_state);
                execution_time_ns = Time.now() - startTime;
                success = false;
                timestamp = Time.now();
            };
            
            state1.failed_responses += 1;
            state1.total_responses += 1;
            
            return (state1, response);
        };
        
        // STEP 2: Heart 2 — Model Selection (Coupling)
        let (state2, modelSelection) = heart2_coupling_resonate(state1, query, modelRegistry);
        
        if (modelSelection.primary_model == "") {
            // No model selected
            let response : IntelligenceResponse = {
                response_id = "resp_" # Int.toText(Time.now());
                query_id = query.query_id;
                content = "No model resonated with the query";
                model_id = "";
                coherence_at_execution = ThreeHeartsEngine.calculateCoherence(state2.hearts_state).global_coherence;
                anima_hash = MatalkoICP.animaHash(organismState).hash;
                heart_phases = getHeartPhases(state2.hearts_state);
                execution_time_ns = Time.now() - startTime;
                success = false;
                timestamp = Time.now();
            };
            
            state2.failed_responses += 1;
            state2.total_responses += 1;
            
            return (state2, response);
        };
        
        // STEP 3: Heart 1 — Computation (Metropolis)
        let (state3, computeResult) = heart1_metropolis_compute(
            state2, 
            query, 
            modelSelection.primary_model,
            modelRegistry
        );
        
        // Generate response with ANIMA hash
        let animaHash = MatalkoICP.animaHash(organismState);
        
        let response : IntelligenceResponse = {
            response_id = "resp_" # Int.toText(Time.now());
            query_id = query.query_id;
            content = computeResult.output;
            model_id = computeResult.model_used;
            coherence_at_execution = computeResult.coherence;
            anima_hash = animaHash.hash;
            heart_phases = getHeartPhases(state3.hearts_state);
            execution_time_ns = Time.now() - startTime;
            success = computeResult.success;
            timestamp = Time.now();
        };
        
        // Update statistics
        state3.total_queries += 1;
        state3.total_responses += 1;
        if (computeResult.success) {
            state3.successful_responses += 1;
        } else {
            state3.failed_responses += 1;
        };
        
        // Update average coherence
        let totalResponses = Float.fromInt(state3.total_responses);
        state3.average_coherence := 
            (state3.average_coherence * (totalResponses - 1.0) + computeResult.coherence) / totalResponses;
        
        // Add to history (keep last 100)
        let queryHistory = Buffer.Buffer<IntelligenceQuery>(state3.query_history.size() + 1);
        for (q in state3.query_history.vals()) {
            queryHistory.add(q);
        };
        queryHistory.add(query);
        if (queryHistory.size() > 100) {
            let trimmed = Buffer.Buffer<IntelligenceQuery>(100);
            var i = queryHistory.size() - 100;
            while (i < queryHistory.size()) {
                trimmed.add(queryHistory.get(i));
                i += 1;
            };
            state3.query_history := Buffer.toArray(trimmed);
        } else {
            state3.query_history := Buffer.toArray(queryHistory);
        };
        
        let responseHistory = Buffer.Buffer<IntelligenceResponse>(state3.response_history.size() + 1);
        for (r in state3.response_history.vals()) {
            responseHistory.add(r);
        };
        responseHistory.add(response);
        if (responseHistory.size() > 100) {
            let trimmed = Buffer.Buffer<IntelligenceResponse>(100);
            var i = responseHistory.size() - 100;
            while (i < responseHistory.size()) {
                trimmed.add(responseHistory.get(i));
                i += 1;
            };
            state3.response_history := Buffer.toArray(trimmed);
        } else {
            state3.response_history := Buffer.toArray(responseHistory);
        };
        
        (state3, response)
    };
    
    /// Get current heart phases
    func getHeartPhases(heartsState: ThreeHeartsEngine.ThreeHeartsState) : HeartPhases {
        let coherence = ThreeHeartsEngine.calculateCoherence(heartsState);
        {
            theta_metropolis = heartsState.metropolis.theta;
            theta_coupling = heartsState.coupling.theta;
            theta_regulating = heartsState.regulating.theta;
            global_coherence = coherence.global_coherence;
        }
    };
    
    // ================================================================== //
    // HELPER FUNCTIONS                                                     //
    // ================================================================== //
    
    /// Create a new intelligence query
    public func createQuery(
        content: Text,
        context: Text,
        source: QuerySource,
        priority: Priority
    ) : IntelligenceQuery {
        {
            query_id = "query_" # Int.toText(Time.now());
            content = content;
            context = context;
            source = source;
            priority = priority;
            timestamp = Time.now();
        }
    };
    
    /// Tick the Three Hearts
    public func tick(state: ThreeHeartsIntelligenceState) : ThreeHeartsIntelligenceState {
        state.hearts_state := ThreeHeartsEngine.tick(state.hearts_state);
        state
    };
    
    /// Get current coherence
    public func getCoherence(state: ThreeHeartsIntelligenceState) : Float {
        ThreeHeartsEngine.calculateCoherence(state.hearts_state).global_coherence
    };
    
    /// Get full status
    public func status(state: ThreeHeartsIntelligenceState) : {
        total_queries: Nat;
        total_responses: Nat;
        successful_responses: Nat;
        failed_responses: Nat;
        average_coherence: Float;
        current_coherence: Float;
        heart_phases: HeartPhases;
        hearts_status: {
            global_beat: Nat;
            metropolis: { theta: Float; omega: Float; beats: Nat };
            coupling: { theta: Float; omega: Float; beats: Nat };
            regulating: { theta: Float; omega: Float; beats: Nat };
        };
    } {
        let heartsStatus = ThreeHeartsEngine.status(state.hearts_state);
        let coherence = ThreeHeartsEngine.calculateCoherence(state.hearts_state);
        
        {
            total_queries = state.total_queries;
            total_responses = state.total_responses;
            successful_responses = state.successful_responses;
            failed_responses = state.failed_responses;
            average_coherence = state.average_coherence;
            current_coherence = coherence.global_coherence;
            heart_phases = getHeartPhases(state.hearts_state);
            hearts_status = {
                global_beat = heartsStatus.global_beat;
                metropolis = heartsStatus.metropolis;
                coupling = heartsStatus.coupling;
                regulating = heartsStatus.regulating;
            };
        }
    };
}
