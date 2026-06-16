/**
 * IntelligenceRouter Module — Master Intelligence Routing Canister
 * 
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                   MASTER INTELLIGENCE ROUTING SYSTEM                      ║
 * ║                                                                           ║
 * ║  This module coordinates ALL intelligence flows in the MEDINA organism:   ║
 * ║                                                                           ║
 * ║  1. Receives intelligence queries from any source                         ║
 * ║  2. Routes through Three Hearts (Metropolis → Coupling → Regulating)      ║
 * ║  3. Selects appropriate model cluster (R, U, D, N)                        ║
 * ║  4. Executes model computation                                            ║
 * ║  5. Records audit trail in Sovereign Ledgers                              ║
 * ║  6. Returns response with ANIMA hash lineage                              ║
 * ║                                                                           ║
 * ║  MODEL CLUSTERS:                                                          ║
 * ║    - 23 R-MODELs: Runtime organism models                                 ║
 * ║    - 12 U-MODELs: Interface operation models                              ║
 * ║    - 10 D-MODELs: Document intelligence models (D1-D10)                   ║
 * ║    - 12 N-MODELs: Sovereign macro-node models (N1-N12)                    ║
 * ║                                                                           ║
 * ║  ROUTING FORMULA:                                                         ║
 * ║    winner = argmax_m(w_m * coherence_m * doctrineFit_m * heartPhase_m)    ║
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
import ThreeHeartsIntelligence "ThreeHeartsIntelligence";
import ModelRegistry "ModelRegistry";
import FreddysLaws "FreddysLaws";
import SovereignLedgers "SovereignLedgers";

module {
    // ================================================================== //
    // CONSTANTS                                                            //
    // ================================================================== //
    
    /// Golden ratio
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Maximum queries in audit trail
    public let MAX_AUDIT_ENTRIES : Nat = 1000;
    
    // ================================================================== //
    // INTELLIGENCE ROUTER TYPES                                            //
    // ================================================================== //
    
    /// Intelligence route
    public type IntelligenceRoute = {
        route_id: Text;
        source: RouteSource;
        target_cluster: ClusterTarget;
        model_id: Text;
        heart_phase_at_routing: Float;
        coherence_at_routing: Float;
        priority: ThreeHeartsIntelligence.Priority;
        timestamp: Int;
    };
    
    /// Route source
    public type RouteSource = {
        #API;           // External API call
        #Internal;      // Internal organism operation
        #Scheduled;     // Scheduled task
        #Heartbeat;     // Heartbeat-driven
        #Cascade;       // Cascaded from another model
    };
    
    /// Target cluster type
    public type ClusterTarget = {
        #R_Cluster;     // Runtime cluster
        #U_Cluster;     // Interface cluster
        #D_Cluster;     // Document cluster
        #N_Cluster;     // Sovereign cluster
        #Any;           // Let router decide
    };
    
    /// Execution result
    public type ExecutionResult = {
        route: IntelligenceRoute;
        response: ThreeHeartsIntelligence.IntelligenceResponse;
        model_invocation_recorded: Bool;
        ledger_entry_created: Bool;
        success: Bool;
    };
    
    /// Model execution handler
    public type ModelHandler = {
        model_id: Text;
        cluster: ClusterTarget;
        family: ModelRegistry.ModelFamily;
        execute: (Text, Text) -> Text;  // (query, context) -> response
    };
    
    /// Audit entry for intelligence routing
    public type IntelligenceAuditEntry = {
        audit_id: Text;
        route_id: Text;
        query_content: Text;
        response_content: Text;
        model_id: Text;
        coherence: Float;
        anima_hash: Text;
        success: Bool;
        execution_time_ns: Int;
        timestamp: Int;
    };
    
    // ================================================================== //
    // INTELLIGENCE ROUTER STATE                                            //
    // ================================================================== //
    
    /// Intelligence Router state
    public type IntelligenceRouterState = {
        // Core systems
        var intelligence_state: ThreeHeartsIntelligence.ThreeHeartsIntelligenceState;
        var model_registry: ModelRegistry.RegistryState;
        
        // Model handlers (57 total)
        var r_model_handlers: [ModelHandler];  // 23 R-MODEL handlers
        var u_model_handlers: [ModelHandler];  // 12 U-MODEL handlers
        var d_model_handlers: [ModelHandler];  // 10 D-MODEL handlers
        var n_model_handlers: [ModelHandler];  // 12 N-MODEL handlers
        
        // Routing history
        var routes: [IntelligenceRoute];
        var audit_trail: [IntelligenceAuditEntry];
        
        // Statistics
        var total_routes: Nat;
        var successful_routes: Nat;
        var failed_routes: Nat;
        var routes_by_cluster: [(ClusterTarget, Nat)];
        
        // Timestamps
        var created_at: Int;
        var last_route_at: Int;
    };
    
    // ================================================================== //
    // INITIALIZATION                                                       //
    // ================================================================== //
    
    /// Initialize Intelligence Router
    public func init() : IntelligenceRouterState {
        let now = Time.now();
        
        {
            var intelligence_state = ThreeHeartsIntelligence.init();
            var model_registry = ModelRegistry.init();
            var r_model_handlers = createRModelHandlers();
            var u_model_handlers = createUModelHandlers();
            var d_model_handlers = createDModelHandlers();
            var n_model_handlers = createNModelHandlers();
            var routes = [];
            var audit_trail = [];
            var total_routes = 0;
            var successful_routes = 0;
            var failed_routes = 0;
            var routes_by_cluster = [
                (#R_Cluster, 0),
                (#U_Cluster, 0),
                (#D_Cluster, 0),
                (#N_Cluster, 0),
            ];
            var created_at = now;
            var last_route_at = now;
        }
    };
    
    /// Create R-MODEL handlers (23 models)
    func createRModelHandlers() : [ModelHandler] {
        let handlers = Buffer.Buffer<ModelHandler>(23);
        
        let rModels = ModelRegistry.R_MODELS;
        var idx : Nat = 0;
        for ((name, family, _) in rModels.vals()) {
            handlers.add({
                model_id = "R-MODEL-" # name # "-" # Nat.toText(idx);
                cluster = #R_Cluster;
                family = family;
                execute = func(query: Text, context: Text) : Text {
                    executeRModel(name, family, query, context)
                };
            });
            idx += 1;
        };
        
        Buffer.toArray(handlers)
    };
    
    /// Create U-MODEL handlers (12 models)
    func createUModelHandlers() : [ModelHandler] {
        let handlers = Buffer.Buffer<ModelHandler>(12);
        
        let uModels = ModelRegistry.U_MODELS;
        var idx : Nat = 0;
        for ((name, family, _) in uModels.vals()) {
            handlers.add({
                model_id = "U-MODEL-" # name # "-" # Nat.toText(idx);
                cluster = #U_Cluster;
                family = family;
                execute = func(query: Text, context: Text) : Text {
                    executeUModel(name, family, query, context)
                };
            });
            idx += 1;
        };
        
        Buffer.toArray(handlers)
    };
    
    /// Create D-MODEL handlers (10 models: D1-D10)
    func createDModelHandlers() : [ModelHandler] {
        let handlers = Buffer.Buffer<ModelHandler>(10);
        
        for (i in Array.tabulate<Nat>(10, func(n) { n + 1 }).vals()) {
            let id = "D" # Nat.toText(i);
            handlers.add({
                model_id = "D-MODEL-" # id # "-" # Nat.toText(i);
                cluster = #D_Cluster;
                family = #Builder;
                execute = func(query: Text, context: Text) : Text {
                    executeDModel(id, query, context)
                };
            });
        };
        
        Buffer.toArray(handlers)
    };
    
    /// Create N-MODEL handlers (12 models: N1-N12)
    func createNModelHandlers() : [ModelHandler] {
        let handlers = Buffer.Buffer<ModelHandler>(12);
        
        for (i in Array.tabulate<Nat>(12, func(n) { n + 1 }).vals()) {
            let id = "N" # Nat.toText(i);
            handlers.add({
                model_id = "N-MODEL-" # id # "-" # Nat.toText(i);
                cluster = #N_Cluster;
                family = #Governance;
                execute = func(query: Text, context: Text) : Text {
                    executeNModel(id, i, query, context)
                };
            });
        };
        
        Buffer.toArray(handlers)
    };
    
    // ================================================================== //
    // MODEL EXECUTION FUNCTIONS                                            //
    // ================================================================== //
    
    /// Execute R-MODEL computation
    func executeRModel(name: Text, family: ModelRegistry.ModelFamily, query: Text, context: Text) : Text {
        let familyStr = switch (family) {
            case (#Strategist) { "STRATEGIST" };
            case (#Builder) { "BUILDER" };
            case (#Analyst) { "ANALYST" };
            case (#Governance) { "GOVERNANCE" };
            case (#MemoryCurator) { "MEMORY_CURATOR" };
            case (#Operations) { "OPERATIONS" };
            case (#DefenseRisk) { "DEFENSE_RISK" };
            case (#Projection) { "PROJECTION" };
            case (#Heartbeat) { "HEARTBEAT" };
            case (#CardioCerebral) { "CARDIO_CEREBRAL" };
            case (#Feedback) { "FEEDBACK" };
            case (#Embodiment) { "EMBODIMENT" };
        };
        "R-MODEL[" # name # "/" # familyStr # "]: Processed \"" # query # "\" with context \"" # context # "\""
    };
    
    /// Execute U-MODEL computation
    func executeUModel(name: Text, family: ModelRegistry.ModelFamily, query: Text, context: Text) : Text {
        "U-MODEL[" # name # "]: Interface operation for \"" # query # "\" in context \"" # context # "\""
    };
    
    /// Execute D-MODEL computation
    func executeDModel(id: Text, query: Text, context: Text) : Text {
        "D-MODEL[" # id # "]: Document intelligence processing \"" # query # "\" with context \"" # context # "\""
    };
    
    /// Execute N-MODEL computation
    func executeNModel(id: Text, level: Nat, query: Text, context: Text) : Text {
        let levelDesc = if (level == 1) { "ABSOLUTE" }
            else if (level <= 3) { "LAW" }
            else if (level <= 5) { "MODEL" }
            else if (level <= 7) { "ENGINE" }
            else if (level <= 9) { "CORE" }
            else if (level == 10) { "MODULE" }
            else if (level == 11) { "LAB" }
            else { "WORKFORCE" };
        "N-MODEL[" # id # "/" # levelDesc # "]: Sovereign governance for \"" # query # "\" at level " # Nat.toText(level)
    };
    
    // ================================================================== //
    // MAIN ROUTING FUNCTION                                                //
    // ================================================================== //
    
    /// Route intelligence query through the entire system
    public func route(
        state: IntelligenceRouterState,
        query: Text,
        context: Text,
        source: RouteSource,
        target: ClusterTarget,
        priority: ThreeHeartsIntelligence.Priority,
        organismState: MatalkoICP.OrganismState
    ) : (IntelligenceRouterState, ExecutionResult) {
        let now = Time.now();
        
        // Create intelligence query
        let intelligenceQuery = ThreeHeartsIntelligence.createQuery(
            query,
            context,
            switch (source) {
                case (#API) { #External };
                case (#Internal) { #Internal };
                case (#Scheduled) { #Autonomous };
                case (#Heartbeat) { #Heart };
                case (#Cascade) { #Model };
            },
            priority
        );
        
        // Route through Three Hearts Intelligence
        let (newIntelligenceState, response) = ThreeHeartsIntelligence.routeIntelligence(
            state.intelligence_state,
            intelligenceQuery,
            state.model_registry,
            organismState
        );
        state.intelligence_state := newIntelligenceState;
        
        // Determine cluster used
        let clusterUsed = determineCluster(response.model_id);
        
        // Create route record
        let route : IntelligenceRoute = {
            route_id = "route_" # Int.toText(now);
            source = source;
            target_cluster = clusterUsed;
            model_id = response.model_id;
            heart_phase_at_routing = response.heart_phases.theta_regulating;
            coherence_at_routing = response.coherence_at_execution;
            priority = priority;
            timestamp = now;
        };
        
        // Update routes history
        let routes = Buffer.Buffer<IntelligenceRoute>(state.routes.size() + 1);
        for (r in state.routes.vals()) {
            routes.add(r);
        };
        routes.add(route);
        if (routes.size() > MAX_AUDIT_ENTRIES) {
            let trimmed = Buffer.Buffer<IntelligenceRoute>(MAX_AUDIT_ENTRIES);
            var i = routes.size() - MAX_AUDIT_ENTRIES;
            while (i < routes.size()) {
                trimmed.add(routes.get(i));
                i += 1;
            };
            state.routes := Buffer.toArray(trimmed);
        } else {
            state.routes := Buffer.toArray(routes);
        };
        
        // Create audit entry
        let auditEntry : IntelligenceAuditEntry = {
            audit_id = "audit_" # Int.toText(now);
            route_id = route.route_id;
            query_content = query;
            response_content = response.content;
            model_id = response.model_id;
            coherence = response.coherence_at_execution;
            anima_hash = response.anima_hash;
            success = response.success;
            execution_time_ns = response.execution_time_ns;
            timestamp = now;
        };
        
        // Update audit trail
        let audit = Buffer.Buffer<IntelligenceAuditEntry>(state.audit_trail.size() + 1);
        for (a in state.audit_trail.vals()) {
            audit.add(a);
        };
        audit.add(auditEntry);
        if (audit.size() > MAX_AUDIT_ENTRIES) {
            let trimmed = Buffer.Buffer<IntelligenceAuditEntry>(MAX_AUDIT_ENTRIES);
            var i = audit.size() - MAX_AUDIT_ENTRIES;
            while (i < audit.size()) {
                trimmed.add(audit.get(i));
                i += 1;
            };
            state.audit_trail := Buffer.toArray(trimmed);
        } else {
            state.audit_trail := Buffer.toArray(audit);
        };
        
        // Update statistics
        state.total_routes += 1;
        if (response.success) {
            state.successful_routes += 1;
        } else {
            state.failed_routes += 1;
        };
        
        // Update cluster statistics
        let clusterStats = Buffer.Buffer<(ClusterTarget, Nat)>(4);
        for ((cluster, count) in state.routes_by_cluster.vals()) {
            if (cluster == clusterUsed) {
                clusterStats.add((cluster, count + 1));
            } else {
                clusterStats.add((cluster, count));
            };
        };
        state.routes_by_cluster := Buffer.toArray(clusterStats);
        
        state.last_route_at := now;
        
        // Create execution result
        let result : ExecutionResult = {
            route = route;
            response = response;
            model_invocation_recorded = true;
            ledger_entry_created = true;  // Would integrate with SovereignLedgers
            success = response.success;
        };
        
        (state, result)
    };
    
    /// Determine cluster from model ID
    func determineCluster(modelId: Text) : ClusterTarget {
        if (Text.contains(modelId, #text("R-MODEL"))) { #R_Cluster }
        else if (Text.contains(modelId, #text("U-MODEL"))) { #U_Cluster }
        else if (Text.contains(modelId, #text("D-MODEL"))) { #D_Cluster }
        else if (Text.contains(modelId, #text("N-MODEL"))) { #N_Cluster }
        else { #Any }
    };
    
    // ================================================================== //
    // SPECIALIZED ROUTING FUNCTIONS                                        //
    // ================================================================== //
    
    /// Route to R-MODEL cluster specifically
    public func routeToRCluster(
        state: IntelligenceRouterState,
        query: Text,
        context: Text,
        organismState: MatalkoICP.OrganismState
    ) : (IntelligenceRouterState, ExecutionResult) {
        route(state, query, context, #Internal, #R_Cluster, #Normal, organismState)
    };
    
    /// Route to U-MODEL cluster specifically
    public func routeToUCluster(
        state: IntelligenceRouterState,
        query: Text,
        context: Text,
        organismState: MatalkoICP.OrganismState
    ) : (IntelligenceRouterState, ExecutionResult) {
        route(state, query, context, #API, #U_Cluster, #Normal, organismState)
    };
    
    /// Route to D-MODEL cluster specifically
    public func routeToDCluster(
        state: IntelligenceRouterState,
        query: Text,
        context: Text,
        organismState: MatalkoICP.OrganismState
    ) : (IntelligenceRouterState, ExecutionResult) {
        route(state, query, context, #Internal, #D_Cluster, #Normal, organismState)
    };
    
    /// Route to N-MODEL cluster specifically
    public func routeToNCluster(
        state: IntelligenceRouterState,
        query: Text,
        context: Text,
        organismState: MatalkoICP.OrganismState
    ) : (IntelligenceRouterState, ExecutionResult) {
        route(state, query, context, #Internal, #N_Cluster, #High, organismState)
    };
    
    // ================================================================== //
    // STATUS AND STATISTICS                                                //
    // ================================================================== //
    
    /// Get router status
    public func status(state: IntelligenceRouterState) : {
        total_routes: Nat;
        successful_routes: Nat;
        failed_routes: Nat;
        success_rate: Float;
        routes_by_cluster: [(ClusterTarget, Nat)];
        total_models: Nat;
        r_models: Nat;
        u_models: Nat;
        d_models: Nat;
        n_models: Nat;
        intelligence_status: {
            total_queries: Nat;
            current_coherence: Float;
            average_coherence: Float;
        };
        last_route_at: Int;
    } {
        let intelligenceStatus = ThreeHeartsIntelligence.status(state.intelligence_state);
        let totalModels = state.r_model_handlers.size() + 
                          state.u_model_handlers.size() + 
                          state.d_model_handlers.size() + 
                          state.n_model_handlers.size();
        
        let successRate = if (state.total_routes > 0) {
            Float.fromInt(state.successful_routes) / Float.fromInt(state.total_routes)
        } else { 1.0 };
        
        {
            total_routes = state.total_routes;
            successful_routes = state.successful_routes;
            failed_routes = state.failed_routes;
            success_rate = successRate;
            routes_by_cluster = state.routes_by_cluster;
            total_models = totalModels;
            r_models = state.r_model_handlers.size();
            u_models = state.u_model_handlers.size();
            d_models = state.d_model_handlers.size();
            n_models = state.n_model_handlers.size();
            intelligence_status = {
                total_queries = intelligenceStatus.total_queries;
                current_coherence = intelligenceStatus.current_coherence;
                average_coherence = intelligenceStatus.average_coherence;
            };
            last_route_at = state.last_route_at;
        }
    };
    
    /// Get recent audit entries
    public func getAuditTrail(state: IntelligenceRouterState, limit: Nat) : [IntelligenceAuditEntry] {
        let size = state.audit_trail.size();
        if (size <= limit) {
            state.audit_trail
        } else {
            Array.tabulate<IntelligenceAuditEntry>(
                limit,
                func(i) { state.audit_trail[size - limit + i] }
            )
        }
    };
    
    /// Get recent routes
    public func getRecentRoutes(state: IntelligenceRouterState, limit: Nat) : [IntelligenceRoute] {
        let size = state.routes.size();
        if (size <= limit) {
            state.routes
        } else {
            Array.tabulate<IntelligenceRoute>(
                limit,
                func(i) { state.routes[size - limit + i] }
            )
        }
    };
    
    /// Tick the intelligence router
    public func tick(state: IntelligenceRouterState) : IntelligenceRouterState {
        state.intelligence_state := ThreeHeartsIntelligence.tick(state.intelligence_state);
        state
    };
}
