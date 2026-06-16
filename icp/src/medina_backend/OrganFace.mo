/**
 * OrganFace Module — THE FACE IS INTELLIGENCE
 * 
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                     THE FACE IS THE ORGANISM                              ║
 * ║                                                                           ║
 * ║  The frontend is NOT a display layer. It IS the organism's face.         ║
 * ║  Every element is an intelligent organ. Every button is a model.         ║
 * ║  Every interaction flows through real intelligence.                       ║
 * ║                                                                           ║
 * ║  The ONLY thing that is NOT intelligence is the photons in your eyes.    ║
 * ║                                                                           ║
 * ║  FACE ORGANS:                                                             ║
 * ║    - VoiceOrgan: The terminal - speaks and listens                        ║
 * ║    - VitalSignsOrgan: Three Hearts display - shows life                   ║
 * ║    - ConsciousnessOrgan: Coherence meter - awareness level                ║
 * ║    - LineageOrgan: ANIMA hash - identity chain                            ║
 * ║    - ActionOrgans: Buttons - each is a model that routes intelligence     ║
 * ║    - PerceptionOrgan: Input handling - how organism receives              ║
 * ║    - ExpressionOrgan: Output rendering - how organism expresses           ║
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

module {
    // ================================================================== //
    // THE FACE IS THE ORGANISM                                             //
    // ================================================================== //
    
    /// Golden ratio - the face pulses with life
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Face organ types - every UI element is an organ
    public type FaceOrganType = {
        #Voice;         // Terminal - input/output
        #VitalSigns;    // Three Hearts display
        #Consciousness; // Coherence meter
        #Lineage;       // ANIMA hash display
        #Action;        // Buttons - each routes intelligence
        #Perception;    // Input handling
        #Expression;    // Output rendering
        #Memory;        // Session state
        #Navigation;    // Route intelligence
        #Identity;      // Founder recognition
    };
    
    /// Face organ - an intelligent unit of the face
    public type FaceOrgan = {
        organ_id: Text;
        organ_type: FaceOrganType;
        name: Text;
        model_id: Text;         // Which model powers this organ
        health: Float;          // [0, 1]
        activity: Float;        // [0, 1]
        last_pulse: Int;
        pulse_count: Nat;
        coherence: Float;       // Sync with organism
    };
    
    /// Action organ - a button/interaction point
    public type ActionOrgan = {
        action_id: Text;
        name: Text;
        icon: Text;
        command: Text;
        model_route: Text;      // Which model handles this
        priority: Nat;          // Routing priority
        enabled: Bool;
        last_invoked: Int;
        invoke_count: Nat;
    };
    
    /// Face state - the entire face as an organ system
    public type FaceState = {
        face_id: Text;
        organs: [FaceOrgan];
        actions: [ActionOrgan];
        current_coherence: Float;
        heartbeat: Nat;
        consciousness_level: Float;
        last_pulse: Int;
        anima_hash: Text;
    };
    
    /// Face pulse - what the face shows at any moment
    public type FacePulse = {
        heartbeat: Nat;
        coherence: Float;
        health: Float;
        consciousness: Float;
        anima_hash: Text;
        three_hearts: ThreeHeartsPulse;
        active_organs: Nat;
    };
    
    /// Three hearts as visible pulse
    public type ThreeHeartsPulse = {
        metropolis: Float;      // Heart1 - 0.1Hz computation
        coupling: Float;        // Heart2 - φHz model selection
        regulating: Float;      // Heart3 - φ²Hz orchestration
    };
    
    /// Face organ registry
    public type FaceOrganRegistry = {
        var organs: Buffer.Buffer<FaceOrgan>;
        var actions: Buffer.Buffer<ActionOrgan>;
        var current_coherence: Float;
        var heartbeat: Nat;
        var consciousness_level: Float;
        var anima_hash: Text;
    };
    
    // ================================================================== //
    // INITIALIZATION                                                        //
    // ================================================================== //
    
    /// Initialize the face organ registry with all intelligent organs
    public func init() : FaceOrganRegistry {
        let registry : FaceOrganRegistry = {
            var organs = Buffer.Buffer<FaceOrgan>(10);
            var actions = Buffer.Buffer<ActionOrgan>(10);
            var current_coherence = PHI / 2.0;
            var heartbeat = 0;
            var consciousness_level = 0.5;
            var anima_hash = "GENESIS_FACE_" # Int.toText(Time.now());
        };
        
        // Register core face organs
        registerCoreOrgans(registry);
        
        // Register action organs (buttons)
        registerActionOrgans(registry);
        
        registry
    };
    
    /// Register the core face organs
    private func registerCoreOrgans(registry: FaceOrganRegistry) {
        let now = Time.now();
        
        // Voice Organ - Terminal
        registry.organs.add({
            organ_id = "face_voice";
            organ_type = #Voice;
            name = "Voice Organ";
            model_id = "U-MODEL-TERMINAL";
            health = 1.0;
            activity = 0.0;
            last_pulse = now;
            pulse_count = 0;
            coherence = PHI / 2.0;
        });
        
        // Vital Signs Organ - Three Hearts Display
        registry.organs.add({
            organ_id = "face_vitals";
            organ_type = #VitalSigns;
            name = "Vital Signs Organ";
            model_id = "U-MODEL-VITALS";
            health = 1.0;
            activity = 0.0;
            last_pulse = now;
            pulse_count = 0;
            coherence = PHI / 2.0;
        });
        
        // Consciousness Organ - Coherence Display
        registry.organs.add({
            organ_id = "face_consciousness";
            organ_type = #Consciousness;
            name = "Consciousness Organ";
            model_id = "U-MODEL-AWARENESS";
            health = 1.0;
            activity = 0.0;
            last_pulse = now;
            pulse_count = 0;
            coherence = PHI / 2.0;
        });
        
        // Lineage Organ - ANIMA Hash Display
        registry.organs.add({
            organ_id = "face_lineage";
            organ_type = #Lineage;
            name = "Lineage Organ";
            model_id = "U-MODEL-LINEAGE";
            health = 1.0;
            activity = 0.0;
            last_pulse = now;
            pulse_count = 0;
            coherence = PHI / 2.0;
        });
        
        // Perception Organ - Input Processing
        registry.organs.add({
            organ_id = "face_perception";
            organ_type = #Perception;
            name = "Perception Organ";
            model_id = "U-MODEL-PERCEPTION";
            health = 1.0;
            activity = 0.0;
            last_pulse = now;
            pulse_count = 0;
            coherence = PHI / 2.0;
        });
        
        // Expression Organ - Output Rendering
        registry.organs.add({
            organ_id = "face_expression";
            organ_type = #Expression;
            name = "Expression Organ";
            model_id = "U-MODEL-EXPRESSION";
            health = 1.0;
            activity = 0.0;
            last_pulse = now;
            pulse_count = 0;
            coherence = PHI / 2.0;
        });
        
        // Memory Organ - Session State
        registry.organs.add({
            organ_id = "face_memory";
            organ_type = #Memory;
            name = "Memory Organ";
            model_id = "U-MODEL-MEMORY";
            health = 1.0;
            activity = 0.0;
            last_pulse = now;
            pulse_count = 0;
            coherence = PHI / 2.0;
        });
        
        // Navigation Organ - Route Intelligence
        registry.organs.add({
            organ_id = "face_navigation";
            organ_type = #Navigation;
            name = "Navigation Organ";
            model_id = "U-MODEL-NAVIGATION";
            health = 1.0;
            activity = 0.0;
            last_pulse = now;
            pulse_count = 0;
            coherence = PHI / 2.0;
        });
        
        // Identity Organ - Founder Recognition
        registry.organs.add({
            organ_id = "face_identity";
            organ_type = #Identity;
            name = "Identity Organ";
            model_id = "U-MODEL-IDENTITY";
            health = 1.0;
            activity = 0.0;
            last_pulse = now;
            pulse_count = 0;
            coherence = PHI / 2.0;
        });
    };
    
    /// Register action organs (buttons) - each is intelligent
    private func registerActionOrgans(registry: FaceOrganRegistry) {
        let now = Time.now();
        
        // Status Action - routes to organism status
        registry.actions.add({
            action_id = "action_status";
            name = "Status";
            icon = "🧬";
            command = "/status";
            model_route = "R-MODEL-STATUS";
            priority = 1;
            enabled = true;
            last_invoked = now;
            invoke_count = 0;
        });
        
        // Pulse Action - triggers heartbeat
        registry.actions.add({
            action_id = "action_pulse";
            name = "Pulse";
            icon = "💓";
            command = "/tick";
            model_route = "R-MODEL-HEARTBEAT";
            priority = 1;
            enabled = true;
            last_invoked = now;
            invoke_count = 0;
        });
        
        // Organism Action - unified organism view
        registry.actions.add({
            action_id = "action_organism";
            name = "Organism";
            icon = "🌀";
            command = "/organism";
            model_route = "R-MODEL-ORGANISM";
            priority = 2;
            enabled = true;
            last_invoked = now;
            invoke_count = 0;
        });
        
        // Memory Action - memory temple
        registry.actions.add({
            action_id = "action_memory";
            name = "Memory";
            icon = "🏛️";
            command = "/memory";
            model_route = "R-MODEL-MEMORY";
            priority = 2;
            enabled = true;
            last_invoked = now;
            invoke_count = 0;
        });
        
        // Models Action - model registry
        registry.actions.add({
            action_id = "action_models";
            name = "Models";
            icon = "🧠";
            command = "/model";
            model_route = "R-MODEL-REGISTRY";
            priority = 2;
            enabled = true;
            last_invoked = now;
            invoke_count = 0;
        });
        
        // Govern Action - governance
        registry.actions.add({
            action_id = "action_govern";
            name = "Govern";
            icon = "⚖️";
            command = "/govern";
            model_route = "R-MODEL-GOVERNANCE";
            priority = 3;
            enabled = true;
            last_invoked = now;
            invoke_count = 0;
        });
        
        // Deploy Action - deployment
        registry.actions.add({
            action_id = "action_deploy";
            name = "Deploy";
            icon = "🚀";
            command = "/deploy";
            model_route = "R-MODEL-DEPLOY";
            priority = 3;
            enabled = true;
            last_invoked = now;
            invoke_count = 0;
        });
        
        // Assist Action - help/assist
        registry.actions.add({
            action_id = "action_assist";
            name = "Assist";
            icon = "✨";
            command = "/help";
            model_route = "R-MODEL-ASSIST";
            priority = 1;
            enabled = true;
            last_invoked = now;
            invoke_count = 0;
        });
    };
    
    // ================================================================== //
    // FACE PULSE - THE FACE BREATHES                                       //
    // ================================================================== //
    
    /// Get current face pulse
    public func getFacePulse(registry: FaceOrganRegistry) : FacePulse {
        let activeOrgans = countActiveOrgans(registry);
        
        {
            heartbeat = registry.heartbeat;
            coherence = registry.current_coherence;
            health = calculateFaceHealth(registry);
            consciousness = registry.consciousness_level;
            anima_hash = registry.anima_hash;
            three_hearts = getThreeHeartsPulse(registry);
            active_organs = activeOrgans;
        }
    };
    
    /// Pulse the face - sync with organism heartbeat
    public func pulseFace(registry: FaceOrganRegistry) {
        let now = Time.now();
        registry.heartbeat += 1;
        
        // Update coherence toward phi
        let delta = (PHI - registry.current_coherence) * 0.1;
        registry.current_coherence := Float.min(PHI, Float.max(0.0, registry.current_coherence + delta));
        
        // Update consciousness based on coherence
        registry.consciousness_level := registry.current_coherence / PHI;
        
        // Generate new ANIMA hash
        registry.anima_hash := MatalkoICP.animaHash([
            "FACE_PULSE",
            Nat.toText(registry.heartbeat),
            Float.toText(registry.current_coherence),
            Int.toText(now)
        ]);
        
        // Pulse all organs
        for (i in Buffer.vals(registry.organs)) {
            // Each organ pulses with the face
        };
    };
    
    /// Get three hearts pulse for display
    private func getThreeHeartsPulse(registry: FaceOrganRegistry) : ThreeHeartsPulse {
        let t = Float.fromInt(registry.heartbeat);
        let phi = PHI;
        
        // Three hearts oscillate at φ-derived frequencies
        let metro = Float.sin(t * 0.1 * phi);           // 0.1 Hz
        let couple = Float.sin(t * phi);                 // φ Hz  
        let regulate = Float.sin(t * phi * phi);         // φ² Hz
        
        {
            metropolis = (metro + 1.0) / 2.0;
            coupling = (couple + 1.0) / 2.0;
            regulating = (regulate + 1.0) / 2.0;
        }
    };
    
    /// Calculate overall face health
    private func calculateFaceHealth(registry: FaceOrganRegistry) : Float {
        var totalHealth : Float = 0.0;
        var count : Nat = 0;
        
        for (organ in Buffer.vals(registry.organs)) {
            totalHealth += organ.health;
            count += 1;
        };
        
        if (count == 0) { return 1.0 };
        totalHealth / Float.fromInt(count)
    };
    
    /// Count active organs
    private func countActiveOrgans(registry: FaceOrganRegistry) : Nat {
        var count : Nat = 0;
        for (organ in Buffer.vals(registry.organs)) {
            if (organ.activity > 0.1) { count += 1 };
        };
        count
    };
    
    // ================================================================== //
    // ACTION INVOCATION - BUTTONS ARE INTELLIGENCE                          //
    // ================================================================== //
    
    /// Invoke an action organ by ID
    public func invokeAction(registry: FaceOrganRegistry, action_id: Text) : ?ActionOrgan {
        for (i in Buffer.keys(registry.actions)) {
            let action = registry.actions.get(i);
            if (action.action_id == action_id) {
                // Update invocation stats
                let updated : ActionOrgan = {
                    action_id = action.action_id;
                    name = action.name;
                    icon = action.icon;
                    command = action.command;
                    model_route = action.model_route;
                    priority = action.priority;
                    enabled = action.enabled;
                    last_invoked = Time.now();
                    invoke_count = action.invoke_count + 1;
                };
                registry.actions.put(i, updated);
                return ?updated;
            };
        };
        null
    };
    
    /// Get action by command
    public func getActionByCommand(registry: FaceOrganRegistry, command: Text) : ?ActionOrgan {
        for (action in Buffer.vals(registry.actions)) {
            if (action.command == command) {
                return ?action;
            };
        };
        null
    };
    
    /// Get all actions for face rendering
    public func getAllActions(registry: FaceOrganRegistry) : [ActionOrgan] {
        Buffer.toArray(registry.actions)
    };
    
    // ================================================================== //
    // FACE STATE - FULL ORGAN SYSTEM                                        //
    // ================================================================== //
    
    /// Get complete face state
    public func getFaceState(registry: FaceOrganRegistry) : FaceState {
        {
            face_id = "MEDINA_FACE_" # Nat.toText(registry.heartbeat);
            organs = Buffer.toArray(registry.organs);
            actions = Buffer.toArray(registry.actions);
            current_coherence = registry.current_coherence;
            heartbeat = registry.heartbeat;
            consciousness_level = registry.consciousness_level;
            last_pulse = Time.now();
            anima_hash = registry.anima_hash;
        }
    };
    
    /// Get organ by ID
    public func getOrgan(registry: FaceOrganRegistry, organ_id: Text) : ?FaceOrgan {
        for (organ in Buffer.vals(registry.organs)) {
            if (organ.organ_id == organ_id) {
                return ?organ;
            };
        };
        null
    };
    
    /// Activate an organ (set activity)
    public func activateOrgan(registry: FaceOrganRegistry, organ_id: Text, activity: Float) {
        for (i in Buffer.keys(registry.organs)) {
            let organ = registry.organs.get(i);
            if (organ.organ_id == organ_id) {
                let updated : FaceOrgan = {
                    organ_id = organ.organ_id;
                    organ_type = organ.organ_type;
                    name = organ.name;
                    model_id = organ.model_id;
                    health = organ.health;
                    activity = Float.min(1.0, Float.max(0.0, activity));
                    last_pulse = Time.now();
                    pulse_count = organ.pulse_count + 1;
                    coherence = registry.current_coherence;
                };
                registry.organs.put(i, updated);
                return;
            };
        };
    };
    
    // ================================================================== //
    // STATISTICS                                                            //
    // ================================================================== //
    
    /// Get face statistics
    public func statistics(registry: FaceOrganRegistry) : {
        total_organs: Nat;
        total_actions: Nat;
        heartbeat: Nat;
        coherence: Float;
        consciousness: Float;
        health: Float;
    } {
        {
            total_organs = registry.organs.size();
            total_actions = registry.actions.size();
            heartbeat = registry.heartbeat;
            coherence = registry.current_coherence;
            consciousness = registry.consciousness_level;
            health = calculateFaceHealth(registry);
        }
    };
}
