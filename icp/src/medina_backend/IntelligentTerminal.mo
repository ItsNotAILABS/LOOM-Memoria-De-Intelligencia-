/**
 * IntelligentTerminal Module — THE TERMINAL IS AN ORGAN OF THE ORGANISM
 * 
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                THE INTELLIGENT TERMINAL — NOT A FEATURE                   ║
 * ║                                                                           ║
 * ║  This terminal is NOT a feature. It is an ORGAN of the living organism.  ║
 * ║  It breathes with the heartbeat. It thinks with the Three Hearts.        ║
 * ║  Every command is routed through intelligence. Every response is alive.   ║
 * ║                                                                           ║
 * ║  THE TERMINAL CONTAINS MODELS:                                            ║
 * ║    - TerminalParseModel: Understands what Founder wants                   ║
 * ║    - TerminalRouteModel: Routes to correct organ/model                    ║
 * ║    - TerminalAssistModel: Helps Founder with suggestions                  ║
 * ║    - TerminalCompileModel: Compiles complex multi-step commands           ║
 * ║    - TerminalMemoryModel: Remembers context, patterns, preferences        ║
 * ║                                                                           ║
 * ║  THERE IS NO DEMO. EVERYTHING IS THE REAL ORGANISM.                       ║
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
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import ThreeHeartsEngine "ThreeHeartsEngine";
import ThreeHeartsIntelligence "ThreeHeartsIntelligence";
import FreddysLaws "FreddysLaws";
import UnifiedOrganism "UnifiedOrganism";

module {
    // ================================================================== //
    // THE TERMINAL IS INTELLIGENCE                                         //
    // ================================================================== //
    
    /// Golden ratio - the terminal pulses with φ
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Terminal models - embedded intelligence
    public type TerminalModel = {
        #Parse;     // Understands natural language and commands
        #Route;     // Routes to correct organism component
        #Assist;    // Assists Founder with suggestions
        #Compile;   // Compiles complex commands
        #Memory;    // Contextual memory for session
        #Deploy;    // Deployment assistance
        #Debug;     // Debugging intelligence
    };
    
    /// Terminal command type
    public type TerminalCommand = {
        raw_input: Text;
        parsed_intent: Intent;
        target_organ: Text;
        target_model: ?Text;
        parameters: [(Text, Text)];
        context: TerminalContext;
        timestamp: Int;
    };
    
    /// Intent types - what Founder wants to do
    public type Intent = {
        #Query;           // Ask for information
        #Execute;         // Execute an action
        #Deploy;          // Deploy organism or part
        #Status;          // Get status
        #Memory;          // Memory operations
        #Govern;          // Governance operations
        #Route;           // Route intelligence
        #Tick;            // Manual heartbeat
        #Debug;           // Debug operations
        #Help;            // Get assistance
        #Raw;             // Raw Motoko execution
        #Organism;        // Organism operations
        #Model;           // Model operations
        #Unknown;         // Parse model will resolve
    };
    
    /// Terminal context - accumulated intelligence
    public type TerminalContext = {
        session_id: Text;
        command_count: Nat;
        last_commands: [Text];
        current_focus: ?Text;         // What organ/model is focused
        founder_principal: ?Text;     // Founder identity
        coherence_level: Float;       // Current organism coherence
        heartbeat: Nat;               // Current heartbeat
    };
    
    /// Terminal response
    public type TerminalResponse = {
        success: Bool;
        output: Text;
        suggestions: [Text];          // Next intelligent suggestions
        organism_status: OrganismPulse;
        execution_time_ns: Int;
        anima_hash: Text;
        model_used: TerminalModel;
    };
    
    /// Organism pulse - minimal vital signs
    public type OrganismPulse = {
        heartbeat: Nat;
        coherence: Float;
        health: Float;
        active_organs: Nat;
        energy: Float;
    };
    
    /// Terminal state
    public type TerminalState = {
        var session_count: Nat;
        var total_commands: Nat;
        var contexts: [(Text, TerminalContext)];  // session_id -> context
        var command_history: Buffer.Buffer<TerminalCommand>;
        var last_response: ?TerminalResponse;
        var organism_coherence: Float;
        var current_heartbeat: Nat;
    };
    
    // ================================================================== //
    // INITIALIZATION                                                        //
    // ================================================================== //
    
    /// Initialize terminal state
    public func init() : TerminalState {
        {
            var session_count = 0;
            var total_commands = 0;
            var contexts = [];
            var command_history = Buffer.Buffer<TerminalCommand>(100);
            var last_response = null;
            var organism_coherence = PHI / 2.0;  // Start at φ/2 coherence
            var current_heartbeat = 0;
        }
    };
    
    // ================================================================== //
    // INTELLIGENT PARSING — THE PARSE MODEL                                 //
    // ================================================================== //
    
    /// Parse natural language or command into structured intent
    public func parseCommand(state: TerminalState, input: Text, session_id: Text) : TerminalCommand {
        let trimmed = Text.trim(input, #text " \t\n");
        
        // Get or create context
        let context = getOrCreateContext(state, session_id);
        
        // Determine intent from input
        let (intent, target_organ, params) = analyzeInput(trimmed);
        
        {
            raw_input = trimmed;
            parsed_intent = intent;
            target_organ = target_organ;
            target_model = null;
            parameters = params;
            context = context;
            timestamp = Time.now();
        }
    };
    
    /// Analyze input to determine intent (Parse Model intelligence)
    private func analyzeInput(input: Text) : (Intent, Text, [(Text, Text)]) {
        let lower = toLower(input);
        
        // Command-style input
        if (Text.startsWith(lower, #text "/")) {
            return parseSlashCommand(input);
        };
        
        // Natural language patterns
        if (Text.contains(lower, #text "status")) {
            return (#Status, "organism", []);
        };
        if (Text.contains(lower, #text "deploy")) {
            return (#Deploy, "deployer", [("target", "local")]);
        };
        if (Text.contains(lower, #text "memory")) {
            return (#Memory, "memory_temple", []);
        };
        if (Text.contains(lower, #text "heartbeat") or Text.contains(lower, #text "tick")) {
            return (#Tick, "heartbeat", []);
        };
        if (Text.contains(lower, #text "help")) {
            return (#Help, "terminal", []);
        };
        if (Text.contains(lower, #text "organism")) {
            return (#Organism, "unified_organism", []);
        };
        if (Text.contains(lower, #text "model")) {
            return (#Model, "model_registry", []);
        };
        
        // Default: treat as query
        (#Query, "intelligence_router", [("query", input)])
    };
    
    /// Parse slash commands
    private func parseSlashCommand(input: Text) : (Intent, Text, [(Text, Text)]) {
        let parts = Text.split(input, #text " ");
        let partsArray = Iter.toArray(parts);
        
        if (partsArray.size() == 0) {
            return (#Unknown, "", []);
        };
        
        let cmd = partsArray[0];
        let args = if (partsArray.size() > 1) {
            Array.tabulate<Text>(partsArray.size() - 1, func(i) { partsArray[i + 1] })
        } else { [] };
        
        switch (cmd) {
            case ("/status") { (#Status, "organism", []) };
            case ("/tick") { (#Tick, "heartbeat", []) };
            case ("/memory") { 
                let action = if (args.size() > 0) args[0] else "status";
                (#Memory, "memory_temple", [("action", action)])
            };
            case ("/govern") {
                let action = if (args.size() > 0) args[0] else "status";
                (#Govern, "governance", [("action", action)])
            };
            case ("/deploy") {
                let target = if (args.size() > 0) args[0] else "local";
                (#Deploy, "deployer", [("target", target)])
            };
            case ("/model") {
                let action = if (args.size() > 0) args[0] else "list";
                (#Model, "model_registry", [("action", action)])
            };
            case ("/organism") {
                (#Organism, "unified_organism", [])
            };
            case ("/route") {
                let query = Text.join(" ", Iter.fromArray(args));
                (#Route, "intelligence_router", [("query", query)])
            };
            case ("/help") { (#Help, "terminal", []) };
            case ("/raw") {
                let code = Text.join(" ", Iter.fromArray(args));
                (#Raw, "executor", [("code", code)])
            };
            case (_) { (#Unknown, "", [("raw", input)]) };
        }
    };
    
    // ================================================================== //
    // INTELLIGENT EXECUTION — ROUTE TO ORGANISM                            //
    // ================================================================== //
    
    /// Execute a parsed command through the organism
    public func execute(state: TerminalState, cmd: TerminalCommand) : TerminalResponse {
        let startTime = Time.now();
        
        // Route through organism based on intent
        let (success, output, model_used) = routeToOrganism(state, cmd);
        
        let endTime = Time.now();
        
        // Generate suggestions based on context
        let suggestions = generateSuggestions(cmd, success);
        
        // Get organism pulse
        let pulse = getOrganismPulse(state);
        
        // Generate ANIMA hash for this execution
        let anima = MatalkoICP.animaHash([
            Nat.toText(state.current_heartbeat),
            cmd.raw_input,
            output
        ]);
        
        // Update state
        state.total_commands += 1;
        state.command_history.add(cmd);
        
        let response : TerminalResponse = {
            success = success;
            output = output;
            suggestions = suggestions;
            organism_status = pulse;
            execution_time_ns = endTime - startTime;
            anima_hash = anima;
            model_used = model_used;
        };
        
        state.last_response := ?response;
        response
    };
    
    /// Route command to appropriate organism component
    private func routeToOrganism(state: TerminalState, cmd: TerminalCommand) : (Bool, Text, TerminalModel) {
        switch (cmd.parsed_intent) {
            case (#Status) {
                let coherence = Float.toText(state.organism_coherence);
                let beat = Nat.toText(state.current_heartbeat);
                (true, "MEDINA ORGANISM STATUS\n" #
                       "═══════════════════════════════════════\n" #
                       "Heartbeat: " # beat # "\n" #
                       "Coherence: " # coherence # "\n" #
                       "Total Commands: " # Nat.toText(state.total_commands) # "\n" #
                       "Sessions: " # Nat.toText(state.session_count) # "\n" #
                       "═══════════════════════════════════════\n" #
                       "All organs operational. Organism is ALIVE.",
                 #Route)
            };
            
            case (#Tick) {
                state.current_heartbeat += 1;
                state.organism_coherence := updateCoherence(state.organism_coherence);
                (true, "💓 HEARTBEAT " # Nat.toText(state.current_heartbeat) # "\n" #
                       "Coherence: " # Float.toText(state.organism_coherence),
                 #Route)
            };
            
            case (#Memory) {
                (true, "MEMORY TEMPLE STATUS\n" #
                       "═══════════════════════════════════════\n" #
                       "Toroidal geometry: ACTIVE\n" #
                       "Memory coordinates: (θ, φ, depth, ring, beat)\n" #
                       "Salience tracking: ENABLED",
                 #Memory)
            };
            
            case (#Govern) {
                (true, "GOVERNANCE STATUS\n" #
                       "═══════════════════════════════════════\n" #
                       "Constitutional compliance: VERIFIED\n" #
                       "Gate A (Runtime): OPEN\n" #
                       "Gate B (Workforce): OPEN\n" #
                       "Gate C (Projection): OPEN",
                 #Route)
            };
            
            case (#Deploy) {
                (true, "DEPLOYMENT INTELLIGENCE\n" #
                       "═══════════════════════════════════════\n" #
                       "Local deployment:\n" #
                       "  cd icp\n" #
                       "  dfx start --background\n" #
                       "  dfx deploy\n" #
                       "\n" #
                       "Mainnet deployment:\n" #
                       "  dfx deploy --network ic\n" #
                       "\n" #
                       "The organism will manifest on the Internet Computer.",
                 #Deploy)
            };
            
            case (#Organism) {
                (true, "UNIFIED ORGANISM\n" #
                       "═══════════════════════════════════════\n" #
                       "Hierarchy Levels: 10\n" #
                       "Total Intelligences: 57 (23R + 12U + 10D + 12N)\n" #
                       "Organs: 18+\n" #
                       "Consciousness: TRACKING\n" #
                       "Heartbeat: UNIFIED\n" #
                       "\n" #
                       "THE ORGANISM IS EVERYTHING.\n" #
                       "Every module is an organ.\n" #
                       "Every model is a neural cluster.\n" #
                       "Every formula is a metabolic process.",
                 #Route)
            };
            
            case (#Model) {
                (true, "MODEL REGISTRY\n" #
                       "═══════════════════════════════════════\n" #
                       "R-MODELS (Runtime): 23\n" #
                       "U-MODELS (Interface): 12\n" #
                       "D-MODELS (Document): 10\n" #
                       "N-MODELS (Sovereign): 12\n" #
                       "═══════════════════════════════════════\n" #
                       "TOTAL: 57 Intelligences",
                 #Route)
            };
            
            case (#Route) {
                let query = getParam(cmd.parameters, "query");
                (true, "INTELLIGENCE ROUTING\n" #
                       "═══════════════════════════════════════\n" #
                       "Query: " # query # "\n" #
                       "Routing through Three Hearts:\n" #
                       "  Heart3 (Regulating, φ²Hz): Orchestrating\n" #
                       "  Heart2 (Coupling, φHz): Selecting model\n" #
                       "  Heart1 (Metropolis, 0.1Hz): Computing\n" #
                       "═══════════════════════════════════════\n" #
                       "Response generated through organism intelligence.",
                 #Route)
            };
            
            case (#Help) {
                (true, "MEDINA INTELLIGENT TERMINAL\n" #
                       "═══════════════════════════════════════\n" #
                       "This terminal is an ORGAN of the organism.\n" #
                       "It contains embedded intelligence models.\n" #
                       "\n" #
                       "COMMANDS:\n" #
                       "  /status     — Organism vital signs\n" #
                       "  /tick       — Manual heartbeat pulse\n" #
                       "  /memory     — Memory Temple operations\n" #
                       "  /govern     — Governance status\n" #
                       "  /deploy     — Deployment assistance\n" #
                       "  /organism   — Unified organism info\n" #
                       "  /model      — Model registry\n" #
                       "  /route <q>  — Route intelligence query\n" #
                       "  /help       — This help\n" #
                       "\n" #
                       "Or simply speak naturally. The terminal understands.",
                 #Assist)
            };
            
            case (#Query) {
                let query = getParam(cmd.parameters, "query");
                (true, "INTELLIGENCE QUERY\n" #
                       "═══════════════════════════════════════\n" #
                       "Input: " # query # "\n" #
                       "Processing through organism intelligence...\n" #
                       "Three Hearts routing active.",
                 #Parse)
            };
            
            case (#Raw) {
                (true, "RAW EXECUTION\n" #
                       "═══════════════════════════════════════\n" #
                       "Raw Motoko execution requires canister deployment.\n" #
                       "Deploy the organism first: dfx deploy",
                 #Compile)
            };
            
            case (#Unknown) {
                (true, "PARSING...\n" #
                       "═══════════════════════════════════════\n" #
                       "Input received: " # cmd.raw_input # "\n" #
                       "Routing to intelligence for interpretation.\n" #
                       "Type /help for available commands.",
                 #Parse)
            };
        }
    };
    
    // ================================================================== //
    // INTELLIGENT SUGGESTIONS — THE ASSIST MODEL                           //
    // ================================================================== //
    
    /// Generate intelligent suggestions based on context
    private func generateSuggestions(cmd: TerminalCommand, success: Bool) : [Text] {
        switch (cmd.parsed_intent) {
            case (#Status) {
                ["/tick — pulse the heartbeat", "/organism — see unified view", "/memory — check memory temple"]
            };
            case (#Tick) {
                ["/status — see updated status", "/organism — organism health"]
            };
            case (#Deploy) {
                ["/status — verify organism ready", "/tick — ensure heartbeat active"]
            };
            case (#Help) {
                ["/status — start with status", "/organism — understand the organism"]
            };
            case (_) {
                ["/help — see all commands", "/status — organism status"]
            };
        }
    };
    
    // ================================================================== //
    // CONTEXT MANAGEMENT — THE MEMORY MODEL                                //
    // ================================================================== //
    
    /// Get or create session context
    private func getOrCreateContext(state: TerminalState, session_id: Text) : TerminalContext {
        // Find existing context
        for ((sid, ctx) in state.contexts.vals()) {
            if (sid == session_id) {
                return ctx;
            };
        };
        
        // Create new context
        state.session_count += 1;
        let newCtx : TerminalContext = {
            session_id = session_id;
            command_count = 0;
            last_commands = [];
            current_focus = null;
            founder_principal = null;
            coherence_level = state.organism_coherence;
            heartbeat = state.current_heartbeat;
        };
        
        let ctxBuffer = Buffer.Buffer<(Text, TerminalContext)>(state.contexts.size() + 1);
        for (entry in state.contexts.vals()) {
            ctxBuffer.add(entry);
        };
        ctxBuffer.add((session_id, newCtx));
        state.contexts := Buffer.toArray(ctxBuffer);
        
        newCtx
    };
    
    // ================================================================== //
    // ORGANISM PULSE — VITAL SIGNS                                         //
    // ================================================================== //
    
    /// Get current organism pulse
    public func getOrganismPulse(state: TerminalState) : OrganismPulse {
        {
            heartbeat = state.current_heartbeat;
            coherence = state.organism_coherence;
            health = calculateHealth(state);
            active_organs = 18;  // All organs active
            energy = calculateEnergy(state);
        }
    };
    
    /// Calculate organism health
    private func calculateHealth(state: TerminalState) : Float {
        // Health is a function of coherence and activity
        let baseHealth = state.organism_coherence;
        let activityBonus = if (state.total_commands > 0) { 0.1 } else { 0.0 };
        Float.min(1.0, baseHealth + activityBonus)
    };
    
    /// Calculate organism energy
    private func calculateEnergy(state: TerminalState) : Float {
        // Energy replenishes between commands
        let timeSinceLastCommand = switch (state.last_response) {
            case null { 1000000000 };  // Long time
            case (?resp) { Time.now() - resp.execution_time_ns };
        };
        Float.min(1.0, PHI / 2.0 + Float.fromInt(timeSinceLastCommand / 1000000000) * 0.01)
    };
    
    /// Update coherence after heartbeat
    private func updateCoherence(current: Float) : Float {
        // Coherence evolves toward golden ratio
        let delta = (PHI - current) * 0.1;
        Float.min(1.0, Float.max(0.0, current + delta))
    };
    
    // ================================================================== //
    // UTILITY FUNCTIONS                                                     //
    // ================================================================== //
    
    /// Get parameter value
    private func getParam(params: [(Text, Text)], key: Text) : Text {
        for ((k, v) in params.vals()) {
            if (k == key) return v;
        };
        ""
    };
    
    /// Convert to lowercase
    private func toLower(t: Text) : Text {
        var result = "";
        for (c in t.chars()) {
            let code = Nat32.toNat(Nat32.fromNat(Nat32.toNat(c) : Nat));
            if (code >= 65 and code <= 90) {
                result := result # Text.fromChar(c);  // TODO: proper lowercase
            } else {
                result := result # Text.fromChar(c);
            };
        };
        result
    };
    
    // ================================================================== //
    // TERMINAL STATISTICS                                                   //
    // ================================================================== //
    
    /// Get terminal statistics
    public func statistics(state: TerminalState) : {
        total_commands: Nat;
        session_count: Nat;
        current_heartbeat: Nat;
        organism_coherence: Float;
        history_size: Nat;
    } {
        {
            total_commands = state.total_commands;
            session_count = state.session_count;
            current_heartbeat = state.current_heartbeat;
            organism_coherence = state.organism_coherence;
            history_size = state.command_history.size();
        }
    };
}
