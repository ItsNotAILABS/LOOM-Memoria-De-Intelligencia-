/**
 * ModelRegistry Module — Multi-Model Runtime for MEDINA
 * 
 * Registry for all model families and instances in the organism:
 * 
 * MODEL FAMILIES:
 *   R-MODEL-* — Runtime organism models (23 minimum)
 *     HEARTBEAT-CORE, CCVE-STATE, CNCO-STATE, GRPE-STATE, 
 *     AUTONOMOUS-ANALYST, MEMORY-TEMPLE-STATE, CONSTANT-FEEDBACK,
 *     NEUROCHEM-CROSSTALK, UNIFIED-EMOTIONAL-FIELD, PARALLAX-DECISION,
 *     ENTANGLA-SOCIAL-BINDING, NEURAL-CORE-MESH, LIVING-ARCHITECTURE-MACRO,
 *     SWARM-COHERENCE, DRIFT-JASMINE, QUANTUM-CHANNEL-FABRIC,
 *     AUDIT-REPLAY, GOVERNANCE-HEARTBEAT, STABILITY-BUDGET,
 *     RISK-MANAGEMENT, WAR-DEFENSE, WORLD-ORGANISM-BRIDGE, SACRED-MATHEMATICS
 * 
 *   U-MODEL-* — Interface operation models (12 minimum)
 *     MEDINA-COMMAND-CENTER, MEMORY-TEMPLE-LAB, MEMORY-NAVIGATION,
 *     CONSTANT-FEEDBACK-LAB, INTERNAL-ANALYSIS-LAB, GRPE-LAB,
 *     EMERGENCE-LAB, MATH-PHYSICS-LAB, NEUROCOG-LAB,
 *     AGENT-WORKSPACE, COMPANION-CONSOLE, DRONE-SIM-WORLD
 * 
 *   D-MODEL-* — Document intelligence models (D1-D10)
 *     Living document workforce organisms
 * 
 *   N-MODEL-* — Sovereign macro-node models (N1-N12)
 *     Sovereignty hierarchy nodes
 * 
 * MASTERY ROUTING FORMULA:
 *   winner = argmax_m(w_m * coherence_m * doctrineFit_m)
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";

module {
    // ================================================================== //
    // MODEL TYPES                                                          //
    // ================================================================== //
    
    /// Model prefix/family classification
    public type ModelPrefix = {
        #R_MODEL;  // Runtime organism models
        #U_MODEL;  // Interface operation models
        #D_MODEL;  // Document intelligence models
        #N_MODEL;  // Sovereign macro-node models
    };
    
    /// Model family specialization
    public type ModelFamily = {
        #Strategist;
        #Builder;
        #Analyst;
        #Governance;
        #MemoryCurator;
        #Operations;
        #DefenseRisk;
        #Projection;
        #Heartbeat;
        #CardioCerebral;
        #Feedback;
        #Embodiment;
    };
    
    /// Model operational status
    public type ModelStatus = {
        #Active;
        #Inactive;
        #Warming;
        #Error;
        #Maintenance;
    };
    
    /// Model definition
    public type ModelDefinition = {
        model_id: Text;
        name: Text;
        prefix: ModelPrefix;
        family: ModelFamily;
        status: ModelStatus;
        capabilities: [Text];
        beat_budget: Nat;        // Execute every N beats
        last_beat: Nat;
        invocation_count: Nat;
        error_count: Nat;
        weight: Float;           // Routing weight
        doctrine_fit: Float;     // Doctrine alignment score
        registered_at: Int;
        last_invoked_at: Int;
    };
    
    /// Routing decision record
    public type RoutingDecision = {
        decision_id: Text;
        query: Text;
        selected_model_id: Text;
        score: Float;
        factors: {
            weight: Float;
            coherence: Float;
            doctrine_fit: Float;
            performance: Float;
        };
        timestamp: Int;
    };
    
    /// Registry state
    public type RegistryState = {
        var models: [ModelDefinition];
        var routing_history: [RoutingDecision];
        var created_at: Int;
    };
    
    // ================================================================== //
    // R-MODEL DEFINITIONS (23 minimum)                                     //
    // ================================================================== //
    
    /// Default R-MODEL definitions
    public let R_MODELS : [(Text, ModelFamily, Nat)] = [
        ("HEARTBEAT-CORE", #Heartbeat, 1),
        ("CCVE-STATE", #CardioCerebral, 1),
        ("CNCO-STATE", #Operations, 1),
        ("GRPE-STATE", #Operations, 1),
        ("AUTONOMOUS-ANALYST", #Analyst, 2),
        ("MEMORY-TEMPLE-STATE", #MemoryCurator, 1),
        ("CONSTANT-FEEDBACK", #Feedback, 1),
        ("NEUROCHEM-CROSSTALK", #Operations, 2),
        ("UNIFIED-EMOTIONAL-FIELD", #Operations, 2),
        ("PARALLAX-DECISION", #Strategist, 3),
        ("ENTANGLA-SOCIAL-BINDING", #Operations, 5),
        ("NEURAL-CORE-MESH", #Operations, 1),
        ("LIVING-ARCHITECTURE-MACRO", #Builder, 5),
        ("SWARM-COHERENCE", #Operations, 2),
        ("DRIFT-JASMINE", #Operations, 10),
        ("QUANTUM-CHANNEL-FABRIC", #Operations, 1),
        ("AUDIT-REPLAY", #Governance, 5),
        ("GOVERNANCE-HEARTBEAT", #Governance, 1),
        ("STABILITY-BUDGET", #DefenseRisk, 2),
        ("RISK-MANAGEMENT", #DefenseRisk, 2),
        ("WAR-DEFENSE", #DefenseRisk, 1),
        ("WORLD-ORGANISM-BRIDGE", #Projection, 5),
        ("SACRED-MATHEMATICS", #Analyst, 10),
    ];
    
    // ================================================================== //
    // U-MODEL DEFINITIONS (12 minimum)                                     //
    // ================================================================== //
    
    /// Default U-MODEL definitions
    public let U_MODELS : [(Text, ModelFamily, Nat)] = [
        ("MEDINA-COMMAND-CENTER", #Operations, 1),
        ("MEMORY-TEMPLE-LAB", #MemoryCurator, 1),
        ("MEMORY-NAVIGATION", #MemoryCurator, 1),
        ("CONSTANT-FEEDBACK-LAB", #Feedback, 1),
        ("INTERNAL-ANALYSIS-LAB", #Analyst, 1),
        ("GRPE-LAB", #Operations, 1),
        ("EMERGENCE-LAB", #Strategist, 1),
        ("MATH-PHYSICS-LAB", #Analyst, 1),
        ("NEUROCOG-LAB", #Analyst, 1),
        ("AGENT-WORKSPACE", #Builder, 1),
        ("COMPANION-CONSOLE", #Operations, 1),
        ("DRONE-SIM-WORLD", #Embodiment, 1),
    ];
    
    // ================================================================== //
    // INITIALIZATION                                                       //
    // ================================================================== //
    
    /// Create initial model definition
    func createModel(
        name: Text, 
        prefix: ModelPrefix, 
        family: ModelFamily, 
        beatBudget: Nat,
        index: Nat
    ) : ModelDefinition {
        let prefixText = switch(prefix) {
            case (#R_MODEL) { "R-MODEL-" };
            case (#U_MODEL) { "U-MODEL-" };
            case (#D_MODEL) { "D-MODEL-" };
            case (#N_MODEL) { "N-MODEL-" };
        };
        {
            model_id = prefixText # name # "-" # Nat.toText(index);
            name = name;
            prefix = prefix;
            family = family;
            status = #Active;
            capabilities = [];
            beat_budget = beatBudget;
            last_beat = 0;
            invocation_count = 0;
            error_count = 0;
            weight = 1.0;
            doctrine_fit = 1.0;
            registered_at = Time.now();
            last_invoked_at = 0;
        }
    };
    
    /// Initialize registry with default models
    public func init() : RegistryState {
        let models = Buffer.Buffer<ModelDefinition>(60);
        
        // Register R-MODELs
        var idx : Nat = 0;
        for ((name, family, budget) in R_MODELS.vals()) {
            models.add(createModel(name, #R_MODEL, family, budget, idx));
            idx += 1;
        };
        
        // Register U-MODELs
        idx := 0;
        for ((name, family, budget) in U_MODELS.vals()) {
            models.add(createModel(name, #U_MODEL, family, budget, idx));
            idx += 1;
        };
        
        // Register D-MODELs (D1-D10)
        for (i in Array.tabulate<Nat>(10, func (n) { n + 1 }).vals()) {
            models.add(createModel("D" # Nat.toText(i), #D_MODEL, #Builder, 1, i));
        };
        
        // Register N-MODELs (N1-N12)
        for (i in Array.tabulate<Nat>(12, func (n) { n + 1 }).vals()) {
            models.add(createModel("N" # Nat.toText(i), #N_MODEL, #Governance, i, i));
        };
        
        {
            var models = Buffer.toArray(models);
            var routing_history = [];
            var created_at = Time.now();
        }
    };
    
    // ================================================================== //
    // MODEL OPERATIONS                                                     //
    // ================================================================== //
    
    /// Get model by ID
    public func getModel(state: RegistryState, modelId: Text) : ?ModelDefinition {
        for (m in state.models.vals()) {
            if (m.model_id == modelId) {
                return ?m;
            };
        };
        null
    };
    
    /// Get model by name
    public func getModelByName(state: RegistryState, name: Text) : ?ModelDefinition {
        for (m in state.models.vals()) {
            if (m.name == name) {
                return ?m;
            };
        };
        null
    };
    
    /// List models by prefix
    public func listByPrefix(state: RegistryState, prefix: ModelPrefix) : [ModelDefinition] {
        Array.filter<ModelDefinition>(state.models, func(m) { m.prefix == prefix })
    };
    
    /// List models by family
    public func listByFamily(state: RegistryState, family: ModelFamily) : [ModelDefinition] {
        Array.filter<ModelDefinition>(state.models, func(m) { m.family == family })
    };
    
    /// List models by status
    public func listByStatus(state: RegistryState, status: ModelStatus) : [ModelDefinition] {
        Array.filter<ModelDefinition>(state.models, func(m) { m.status == status })
    };
    
    /// Get models that should run at given beat
    public func getModelsForBeat(state: RegistryState, beat: Nat) : [ModelDefinition] {
        Array.filter<ModelDefinition>(state.models, func(m) {
            m.status == #Active and 
            m.beat_budget > 0 and 
            (beat - m.last_beat) >= m.beat_budget
        })
    };
    
    // ================================================================== //
    // MASTERY ROUTING                                                      //
    // ================================================================== //
    
    /// Calculate coherence between query and model
    func calculateCoherence(query: Text, model: ModelDefinition) : Float {
        // Simple keyword matching for family
        let queryLower = Text.toLowercase(query);
        let familyKeywords : [(ModelFamily, [Text])] = [
            (#Strategist, ["strategy", "plan", "decision", "future", "direction"]),
            (#Builder, ["build", "create", "implement", "code", "develop"]),
            (#Analyst, ["analyze", "report", "data", "insight", "measure"]),
            (#Governance, ["govern", "approve", "policy", "audit", "rule"]),
            (#MemoryCurator, ["memory", "recall", "remember", "store", "retrieve"]),
            (#Operations, ["operate", "run", "execute", "process", "manage"]),
            (#DefenseRisk, ["risk", "defense", "security", "threat", "protect"]),
            (#Projection, ["project", "external", "output", "share", "publish"]),
            (#Heartbeat, ["heartbeat", "pulse", "rhythm", "beat", "alive"]),
            (#CardioCerebral, ["heart", "brain", "coupling", "resonance", "vector"]),
            (#Feedback, ["feedback", "loop", "response", "adjust", "tune"]),
            (#Embodiment, ["body", "drone", "physical", "world", "action"]),
        ];
        
        var maxScore : Float = 0.1;
        for ((family, keywords) in familyKeywords.vals()) {
            if (model.family == family) {
                var matches : Float = 0.0;
                for (kw in keywords.vals()) {
                    if (Text.contains(queryLower, #text(kw))) {
                        matches += 1.0;
                    };
                };
                if (matches > 0.0) {
                    let score = Float.min(1.0, matches / Float.fromInt(keywords.size()) * 2.0);
                    if (score > maxScore) {
                        maxScore := score;
                    };
                };
            };
        };
        maxScore
    };
    
    /// Calculate performance factor
    func calculatePerformance(model: ModelDefinition) : Float {
        if (model.invocation_count == 0) {
            return 1.0;
        };
        let errorRate = Float.fromInt(model.error_count) / Float.fromInt(model.invocation_count);
        1.0 - (errorRate * 0.5)
    };
    
    /// Route query to best model using mastery routing
    /// Formula: winner = argmax_m(w_m * coherence_m * doctrineFit_m * perf_m)
    public func route(
        state: RegistryState, 
        query: Text,
        preferredPrefix: ?ModelPrefix,
        preferredFamily: ?ModelFamily
    ) : (RegistryState, RoutingDecision) {
        var candidates = state.models;
        
        // Filter by preferred prefix if specified
        switch (preferredPrefix) {
            case (?prefix) {
                let filtered = Array.filter<ModelDefinition>(candidates, func(m) { m.prefix == prefix });
                if (filtered.size() > 0) { candidates := filtered };
            };
            case (null) {};
        };
        
        // Filter by preferred family if specified
        switch (preferredFamily) {
            case (?family) {
                let filtered = Array.filter<ModelDefinition>(candidates, func(m) { m.family == family });
                if (filtered.size() > 0) { candidates := filtered };
            };
            case (null) {};
        };
        
        // Filter to active only
        candidates := Array.filter<ModelDefinition>(candidates, func(m) { m.status == #Active });
        
        // Score all candidates
        var bestModel : ?ModelDefinition = null;
        var bestScore : Float = 0.0;
        var bestFactors = { weight = 0.0; coherence = 0.0; doctrine_fit = 0.0; performance = 0.0 };
        
        for (model in candidates.vals()) {
            let coherence = calculateCoherence(query, model);
            let performance = calculatePerformance(model);
            let score = model.weight * coherence * model.doctrine_fit * performance;
            
            if (score > bestScore) {
                bestScore := score;
                bestModel := ?model;
                bestFactors := {
                    weight = model.weight;
                    coherence = coherence;
                    doctrine_fit = model.doctrine_fit;
                    performance = performance;
                };
            };
        };
        
        let selectedId = switch (bestModel) {
            case (?m) { m.model_id };
            case (null) { "" };
        };
        
        let decision : RoutingDecision = {
            decision_id = "route_" # Int.toText(Time.now());
            query = query;
            selected_model_id = selectedId;
            score = bestScore;
            factors = bestFactors;
            timestamp = Time.now();
        };
        
        // Add to history
        let newHistory = Buffer.Buffer<RoutingDecision>(state.routing_history.size() + 1);
        for (d in state.routing_history.vals()) {
            newHistory.add(d);
        };
        newHistory.add(decision);
        
        let newState : RegistryState = {
            var models = state.models;
            var routing_history = Buffer.toArray(newHistory);
            var created_at = state.created_at;
        };
        
        (newState, decision)
    };
    
    /// Update model after invocation
    public func recordInvocation(state: RegistryState, modelId: Text, beat: Nat, success: Bool) : RegistryState {
        let updated = Array.map<ModelDefinition, ModelDefinition>(state.models, func(m) {
            if (m.model_id == modelId) {
                {
                    model_id = m.model_id;
                    name = m.name;
                    prefix = m.prefix;
                    family = m.family;
                    status = m.status;
                    capabilities = m.capabilities;
                    beat_budget = m.beat_budget;
                    last_beat = beat;
                    invocation_count = m.invocation_count + 1;
                    error_count = if (success) { m.error_count } else { m.error_count + 1 };
                    weight = m.weight;
                    doctrine_fit = m.doctrine_fit;
                    registered_at = m.registered_at;
                    last_invoked_at = Time.now();
                }
            } else { m }
        });
        {
            var models = updated;
            var routing_history = state.routing_history;
            var created_at = state.created_at;
        }
    };
    
    // ================================================================== //
    // STATISTICS                                                           //
    // ================================================================== //
    
    /// Get registry statistics
    public func getStatistics(state: RegistryState) : {
        total_models: Nat;
        r_models: Nat;
        u_models: Nat;
        d_models: Nat;
        n_models: Nat;
        active_models: Nat;
        total_invocations: Nat;
        total_routing_decisions: Nat;
    } {
        let rCount = listByPrefix(state, #R_MODEL).size();
        let uCount = listByPrefix(state, #U_MODEL).size();
        let dCount = listByPrefix(state, #D_MODEL).size();
        let nCount = listByPrefix(state, #N_MODEL).size();
        let activeCount = listByStatus(state, #Active).size();
        
        var totalInvocations : Nat = 0;
        for (m in state.models.vals()) {
            totalInvocations += m.invocation_count;
        };
        
        {
            total_models = state.models.size();
            r_models = rCount;
            u_models = uCount;
            d_models = dCount;
            n_models = nCount;
            active_models = activeCount;
            total_invocations = totalInvocations;
            total_routing_decisions = state.routing_history.size();
        }
    };
    
    // ================================================================== //
    // MODEL EXECUTION HANDLER TYPES                                        //
    // ================================================================== //
    
    /// Execution context for model invocation
    public type ExecutionContext = {
        query: Text;
        context: Text;
        coherence: Float;
        beat: Nat;
        anima_hash: Text;
    };
    
    /// Execution result from model invocation
    public type ExecutionResult = {
        output: Text;
        success: Bool;
        execution_time_ns: Int;
        model_id: Text;
        coherence_at_execution: Float;
    };
    
    // ================================================================== //
    // MODEL EXECUTION FUNCTIONS                                            //
    // ================================================================== //
    
    /// Execute R-MODEL based on model name
    public func executeRModel(
        state: RegistryState,
        modelName: Text,
        ctx: ExecutionContext
    ) : (RegistryState, ExecutionResult) {
        let startTime = Time.now();
        
        // Find model
        let maybeModel = getModelByName(state, modelName);
        
        switch (maybeModel) {
            case (?model) {
                // Execute based on model family
                let output = switch (model.family) {
                    case (#Heartbeat) {
                        "R-MODEL[HEARTBEAT/" # modelName # "]: Heartbeat processing for \"" # ctx.query # "\" at beat " # Nat.toText(ctx.beat)
                    };
                    case (#CardioCerebral) {
                        "R-MODEL[CARDIO_CEREBRAL/" # modelName # "]: Heart-brain coupling for \"" # ctx.query # "\" with coherence " # Float.toText(ctx.coherence)
                    };
                    case (#Operations) {
                        "R-MODEL[OPERATIONS/" # modelName # "]: Runtime operation for \"" # ctx.query # "\""
                    };
                    case (#Analyst) {
                        "R-MODEL[ANALYST/" # modelName # "]: Analysis of \"" # ctx.query # "\" with context \"" # ctx.context # "\""
                    };
                    case (#Strategist) {
                        "R-MODEL[STRATEGIST/" # modelName # "]: Strategic planning for \"" # ctx.query # "\""
                    };
                    case (#MemoryCurator) {
                        "R-MODEL[MEMORY_CURATOR/" # modelName # "]: Memory curation for \"" # ctx.query # "\""
                    };
                    case (#Governance) {
                        "R-MODEL[GOVERNANCE/" # modelName # "]: Governance processing for \"" # ctx.query # "\""
                    };
                    case (#DefenseRisk) {
                        "R-MODEL[DEFENSE_RISK/" # modelName # "]: Risk assessment for \"" # ctx.query # "\""
                    };
                    case (#Projection) {
                        "R-MODEL[PROJECTION/" # modelName # "]: Projection handling for \"" # ctx.query # "\""
                    };
                    case (#Builder) {
                        "R-MODEL[BUILDER/" # modelName # "]: Building for \"" # ctx.query # "\""
                    };
                    case (#Feedback) {
                        "R-MODEL[FEEDBACK/" # modelName # "]: Feedback processing for \"" # ctx.query # "\""
                    };
                    case (#Embodiment) {
                        "R-MODEL[EMBODIMENT/" # modelName # "]: Embodiment action for \"" # ctx.query # "\""
                    };
                };
                
                // Record invocation
                let updatedState = recordInvocation(state, model.model_id, ctx.beat, true);
                
                (updatedState, {
                    output = output;
                    success = true;
                    execution_time_ns = Time.now() - startTime;
                    model_id = model.model_id;
                    coherence_at_execution = ctx.coherence;
                })
            };
            case (null) {
                (state, {
                    output = "R-MODEL not found: " # modelName;
                    success = false;
                    execution_time_ns = Time.now() - startTime;
                    model_id = "";
                    coherence_at_execution = ctx.coherence;
                })
            };
        }
    };
    
    /// Execute U-MODEL based on model name
    public func executeUModel(
        state: RegistryState,
        modelName: Text,
        ctx: ExecutionContext
    ) : (RegistryState, ExecutionResult) {
        let startTime = Time.now();
        
        let maybeModel = getModelByName(state, modelName);
        
        switch (maybeModel) {
            case (?model) {
                let output = "U-MODEL[" # modelName # "]: Interface operation for \"" # ctx.query # "\" at coherence " # Float.toText(ctx.coherence);
                let updatedState = recordInvocation(state, model.model_id, ctx.beat, true);
                
                (updatedState, {
                    output = output;
                    success = true;
                    execution_time_ns = Time.now() - startTime;
                    model_id = model.model_id;
                    coherence_at_execution = ctx.coherence;
                })
            };
            case (null) {
                (state, {
                    output = "U-MODEL not found: " # modelName;
                    success = false;
                    execution_time_ns = Time.now() - startTime;
                    model_id = "";
                    coherence_at_execution = ctx.coherence;
                })
            };
        }
    };
    
    /// Execute D-MODEL based on model name
    public func executeDModel(
        state: RegistryState,
        modelName: Text,
        ctx: ExecutionContext
    ) : (RegistryState, ExecutionResult) {
        let startTime = Time.now();
        
        let maybeModel = getModelByName(state, modelName);
        
        switch (maybeModel) {
            case (?model) {
                let output = "D-MODEL[" # modelName # "]: Document intelligence for \"" # ctx.query # "\" | ANIMA: " # ctx.anima_hash;
                let updatedState = recordInvocation(state, model.model_id, ctx.beat, true);
                
                (updatedState, {
                    output = output;
                    success = true;
                    execution_time_ns = Time.now() - startTime;
                    model_id = model.model_id;
                    coherence_at_execution = ctx.coherence;
                })
            };
            case (null) {
                (state, {
                    output = "D-MODEL not found: " # modelName;
                    success = false;
                    execution_time_ns = Time.now() - startTime;
                    model_id = "";
                    coherence_at_execution = ctx.coherence;
                })
            };
        }
    };
    
    /// Execute N-MODEL based on model name
    public func executeNModel(
        state: RegistryState,
        modelName: Text,
        nodeLevel: Nat,
        ctx: ExecutionContext
    ) : (RegistryState, ExecutionResult) {
        let startTime = Time.now();
        
        let maybeModel = getModelByName(state, modelName);
        
        let levelDesc = if (nodeLevel == 1) { "ABSOLUTE" }
            else if (nodeLevel <= 3) { "LAW" }
            else if (nodeLevel <= 5) { "MODEL" }
            else if (nodeLevel <= 7) { "ENGINE" }
            else if (nodeLevel <= 9) { "CORE" }
            else if (nodeLevel == 10) { "MODULE" }
            else if (nodeLevel == 11) { "LAB" }
            else { "WORKFORCE" };
        
        switch (maybeModel) {
            case (?model) {
                let output = "N-MODEL[" # modelName # "/" # levelDesc # "]: Sovereign governance for \"" # ctx.query # "\" at level N" # Nat.toText(nodeLevel);
                let updatedState = recordInvocation(state, model.model_id, ctx.beat, true);
                
                (updatedState, {
                    output = output;
                    success = true;
                    execution_time_ns = Time.now() - startTime;
                    model_id = model.model_id;
                    coherence_at_execution = ctx.coherence;
                })
            };
            case (null) {
                (state, {
                    output = "N-MODEL not found: " # modelName;
                    success = false;
                    execution_time_ns = Time.now() - startTime;
                    model_id = "";
                    coherence_at_execution = ctx.coherence;
                })
            };
        }
    };
    
    /// Invoke model by ID (generic handler)
    public func invoke(
        state: RegistryState,
        modelId: Text,
        ctx: ExecutionContext
    ) : (RegistryState, ExecutionResult) {
        let startTime = Time.now();
        
        let maybeModel = getModel(state, modelId);
        
        switch (maybeModel) {
            case (?model) {
                // Determine prefix and route to appropriate executor
                let (updatedState, result) = switch (model.prefix) {
                    case (#R_MODEL) { executeRModel(state, model.name, ctx) };
                    case (#U_MODEL) { executeUModel(state, model.name, ctx) };
                    case (#D_MODEL) { executeDModel(state, model.name, ctx) };
                    case (#N_MODEL) { executeNModel(state, model.name, 1, ctx) };
                };
                (updatedState, result)
            };
            case (null) {
                (state, {
                    output = "Model not found: " # modelId;
                    success = false;
                    execution_time_ns = Time.now() - startTime;
                    model_id = "";
                    coherence_at_execution = ctx.coherence;
                })
            };
        }
    };
}
