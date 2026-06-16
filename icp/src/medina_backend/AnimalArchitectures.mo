/**
 * AnimalArchitectures Module — Biomimetic Brain Pattern Synthesis
 * 
 * MEDINA synthesizes animal brain architectures for specialized processing:
 * 
 * CAT — Visual Edge Detection
 *   Pattern: Sharp boundary recognition, contrast detection
 *   Application: Semantic boundaries, concept edges, category limits
 * 
 * DOG — Semantic Trace Following
 *   Pattern: Scent tracking, trace persistence, loyalty patterns
 *   Application: Memory lineage, provenance chains, relationship tracking
 * 
 * DOLPHIN — 3D Torus Mapping
 *   Pattern: Echolocation in 3D space, social coordination
 *   Application: Memory temple navigation, toroidal geometry, spatial memory
 * 
 * OCTOPUS — Distributed Multi-Agent
 *   Pattern: 8 semi-autonomous arms, distributed intelligence
 *   Application: Workforce organisms, D1-D10 documents, parallel processing
 * 
 * EAGLE — Long-Range Detection
 *   Pattern: Far sight, precision targeting, high-altitude view
 *   Application: Strategic planning, threat detection, pattern recognition
 * 
 * BAT — Resonance Calibration
 *   Pattern: Echolocation, frequency discrimination, night navigation
 *   Application: Harmonic calibration, resonance gates, frequency matching
 * 
 * WHALE — CPL Routing
 *   Pattern: Long-distance communication, song propagation, pod coordination
 *   Application: CPL message routing, inter-organism communication
 * 
 * BEE — Symbol-to-Action
 *   Pattern: Waggle dance, symbol encoding, hive coordination
 *   Application: Glyph processing, command execution, swarm intelligence
 * 
 * Attribution: Freddy — Architect of the MEDINA biomimetic synthesis
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
    // ANIMAL TYPES                                                         //
    // ================================================================== //
    
    /// Animal architecture type
    public type AnimalType = {
        #Cat;       // Visual edge detection
        #Dog;       // Semantic trace following
        #Dolphin;   // 3D torus mapping
        #Octopus;   // Distributed multi-agent
        #Eagle;     // Long-range detection
        #Bat;       // Resonance calibration
        #Whale;     // CPL routing
        #Bee;       // Symbol-to-action
    };
    
    /// Pattern domain for application
    public type PatternDomain = {
        #SemanticBoundary;     // Cat
        #MemoryLineage;        // Dog
        #SpatialNavigation;    // Dolphin
        #ParallelProcessing;   // Octopus
        #StrategicPlanning;    // Eagle
        #HarmonicCalibration;  // Bat
        #Communication;        // Whale
        #CommandExecution;     // Bee
    };
    
    // ================================================================== //
    // CAT ARCHITECTURE — Visual Edge Detection                             //
    // ================================================================== //
    
    /// Edge detection result
    public type EdgeDetectionResult = {
        edges: [(Float, Float)];  // (position, strength) pairs
        sharpest_edge: Float;
        edge_count: Nat;
        contrast_ratio: Float;
    };
    
    /// Detect edges in a value sequence (semantic boundaries)
    public func catDetectEdges(values: [Float], threshold: Float) : EdgeDetectionResult {
        let edges = Buffer.Buffer<(Float, Float)>(values.size());
        var maxEdge : Float = 0.0;
        
        var i : Nat = 1;
        while (i < values.size()) {
            let diff = Float.abs(values[i] - values[i - 1]);
            if (diff >= threshold) {
                edges.add((Float.fromInt(i), diff));
                if (diff > maxEdge) {
                    maxEdge := diff;
                };
            };
            i += 1;
        };
        
        let contrastRatio = if (values.size() > 0) {
            var minV = values[0];
            var maxV = values[0];
            for (v in values.vals()) {
                if (v < minV) { minV := v };
                if (v > maxV) { maxV := v };
            };
            if (minV > 0.0) { maxV / minV } else { maxV }
        } else { 1.0 };
        
        {
            edges = Buffer.toArray(edges);
            sharpest_edge = maxEdge;
            edge_count = edges.size();
            contrast_ratio = contrastRatio;
        }
    };
    
    // ================================================================== //
    // DOG ARCHITECTURE — Semantic Trace Following                          //
    // ================================================================== //
    
    /// Trace following state
    public type TraceState = {
        trace_id: Text;
        current_position: Nat;
        trace_path: [Text];
        strength: Float;
        last_scent_time: Int;
    };
    
    /// Create a new trace to follow
    public func dogCreateTrace(traceId: Text, initialNode: Text) : TraceState {
        {
            trace_id = traceId;
            current_position = 0;
            trace_path = [initialNode];
            strength = 1.0;
            last_scent_time = Time.now();
        }
    };
    
    /// Follow trace to next node
    public func dogFollowTrace(state: TraceState, nextNode: Text) : TraceState {
        let newPath = Buffer.Buffer<Text>(state.trace_path.size() + 1);
        for (n in state.trace_path.vals()) {
            newPath.add(n);
        };
        newPath.add(nextNode);
        
        // Strength decays slightly with each step
        let newStrength = state.strength * 0.95;
        
        {
            trace_id = state.trace_id;
            current_position = state.current_position + 1;
            trace_path = Buffer.toArray(newPath);
            strength = newStrength;
            last_scent_time = Time.now();
        }
    };
    
    /// Check if trace is still strong (not lost scent)
    public func dogTraceActive(state: TraceState) : Bool {
        state.strength > 0.1
    };
    
    // ================================================================== //
    // DOLPHIN ARCHITECTURE — 3D Torus Mapping                              //
    // ================================================================== //
    
    /// 3D sonar ping result
    public type SonarPing = {
        theta: Float;
        phi: Float;
        distance: Float;
        echo_strength: Float;
        detected_object: ?Text;
    };
    
    /// Dolphin navigation state
    public type DolphinNavState = {
        current_theta: Float;
        current_phi: Float;
        current_depth: Float;
        ping_history: [SonarPing];
        pod_position: ?{theta: Float; phi: Float};
    };
    
    /// Initialize dolphin navigator
    public func dolphinInit() : DolphinNavState {
        {
            current_theta = 0.0;
            current_phi = 0.0;
            current_depth = 1.0;
            ping_history = [];
            pod_position = null;
        }
    };
    
    /// Send sonar ping in direction
    public func dolphinPing(
        state: DolphinNavState,
        target_theta: Float,
        target_phi: Float
    ) : (DolphinNavState, SonarPing) {
        // Calculate distance on torus
        let dTheta = target_theta - state.current_theta;
        let dPhi = target_phi - state.current_phi;
        let distance = Float.sqrt(dTheta * dTheta + dPhi * dPhi);
        
        // Echo strength inversely proportional to distance
        let echoStrength = 1.0 / (1.0 + distance);
        
        let ping : SonarPing = {
            theta = target_theta;
            phi = target_phi;
            distance = distance;
            echo_strength = echoStrength;
            detected_object = null;
        };
        
        let newHistory = Buffer.Buffer<SonarPing>(state.ping_history.size() + 1);
        for (p in state.ping_history.vals()) {
            newHistory.add(p);
        };
        newHistory.add(ping);
        
        let newState : DolphinNavState = {
            current_theta = state.current_theta;
            current_phi = state.current_phi;
            current_depth = state.current_depth;
            ping_history = Buffer.toArray(newHistory);
            pod_position = state.pod_position;
        };
        
        (newState, ping)
    };
    
    /// Navigate dolphin to new position
    public func dolphinNavigate(
        state: DolphinNavState,
        new_theta: Float,
        new_phi: Float
    ) : DolphinNavState {
        {
            current_theta = new_theta;
            current_phi = new_phi;
            current_depth = state.current_depth;
            ping_history = state.ping_history;
            pod_position = state.pod_position;
        }
    };
    
    // ================================================================== //
    // OCTOPUS ARCHITECTURE — Distributed Multi-Agent                       //
    // ================================================================== //
    
    /// Arm state (semi-autonomous agent)
    public type OctopusArm = {
        arm_id: Nat;
        task: ?Text;
        status: {#Idle; #Working; #Done; #Error};
        local_memory: [Text];
        coordination_signal: Float;
    };
    
    /// Octopus multi-agent state
    public type OctopusState = {
        arms: [OctopusArm];
        central_brain: Text;
        coordination_mode: {#Independent; #Coordinated; #Synchronized};
    };
    
    /// Initialize octopus with 8 arms
    public func octopusInit() : OctopusState {
        let arms = Array.tabulate<OctopusArm>(8, func(i) {
            {
                arm_id = i;
                task = null;
                status = #Idle;
                local_memory = [];
                coordination_signal = 1.0;
            }
        });
        {
            arms = arms;
            central_brain = "";
            coordination_mode = #Independent;
        }
    };
    
    /// Assign task to specific arm
    public func octopusAssignTask(state: OctopusState, armId: Nat, task: Text) : OctopusState {
        let updatedArms = Array.map<OctopusArm, OctopusArm>(state.arms, func(arm) {
            if (arm.arm_id == armId) {
                {
                    arm_id = arm.arm_id;
                    task = ?task;
                    status = #Working;
                    local_memory = arm.local_memory;
                    coordination_signal = arm.coordination_signal;
                }
            } else { arm }
        });
        {
            arms = updatedArms;
            central_brain = state.central_brain;
            coordination_mode = state.coordination_mode;
        }
    };
    
    /// Get idle arms
    public func octopusGetIdleArms(state: OctopusState) : [Nat] {
        Array.mapFilter<OctopusArm, Nat>(state.arms, func(arm) {
            if (arm.status == #Idle) { ?arm.arm_id } else { null }
        })
    };
    
    // ================================================================== //
    // EAGLE ARCHITECTURE — Long-Range Detection                            //
    // ================================================================== //
    
    /// Eagle scan result
    public type EagleScanResult = {
        detected_targets: [{ distance: Float; direction: Float; type_: Text }];
        threat_level: Float;
        strategic_view: Text;
        scan_altitude: Float;
    };
    
    /// Eagle scanning state
    public type EagleState = {
        altitude: Float;
        scan_radius: Float;
        focus_point: ?{x: Float; y: Float};
        detected_patterns: [Text];
    };
    
    /// Initialize eagle at high altitude
    public func eagleInit(altitude: Float) : EagleState {
        {
            altitude = altitude;
            scan_radius = altitude * 10.0; // Higher = wider view
            focus_point = null;
            detected_patterns = [];
        }
    };
    
    /// Eagle wide-area scan
    public func eagleScan(state: EagleState) : EagleScanResult {
        // Higher altitude = more detected, less detail
        let detectionCount = Float.toInt(state.altitude);
        
        {
            detected_targets = [];
            threat_level = 0.0;
            strategic_view = "altitude_" # Float.toText(state.altitude);
            scan_altitude = state.altitude;
        }
    };
    
    /// Eagle focus on specific point (dive)
    public func eagleFocus(state: EagleState, x: Float, y: Float) : EagleState {
        {
            altitude = state.altitude * 0.5; // Descend when focusing
            scan_radius = state.scan_radius * 0.3;
            focus_point = ?{x = x; y = y};
            detected_patterns = state.detected_patterns;
        }
    };
    
    // ================================================================== //
    // BAT ARCHITECTURE — Resonance Calibration                             //
    // ================================================================== //
    
    /// Bat echolocation result
    public type EcholocationResult = {
        emitted_frequency: Float;
        returned_frequency: Float;
        doppler_shift: Float;
        distance_estimate: Float;
        resonance_match: Bool;
    };
    
    /// Bat calibration state
    public type BatState = {
        current_frequency: Float;
        frequency_range: (Float, Float);
        calibration_targets: [Float];
        resonance_gates: [Bool];
    };
    
    /// Initialize bat with Schumann-based frequencies
    public func batInit() : BatState {
        {
            current_frequency = MatalkoICP.SCHUMANN;
            frequency_range = (7.0, 900.0);
            calibration_targets = MatalkoICP.SOLFEGGIO;
            resonance_gates = Array.tabulate<Bool>(6, func(_) { false });
        }
    };
    
    /// Emit frequency and detect return
    public func batEcholocate(state: BatState, targetFreq: Float) : EcholocationResult {
        let emitted = state.current_frequency;
        let returned = targetFreq; // In real impl, would simulate echo
        let shift = returned - emitted;
        let distance = Float.abs(shift) / emitted * 340.0; // Speed of sound
        
        // Check if resonance achieved
        let resonance = Float.abs(shift) < emitted * 0.01;
        
        {
            emitted_frequency = emitted;
            returned_frequency = returned;
            doppler_shift = shift;
            distance_estimate = distance;
            resonance_match = resonance;
        }
    };
    
    /// Calibrate to solfeggio frequency
    public func batCalibrate(state: BatState, targetIndex: Nat) : BatState {
        let newFreq = if (targetIndex < state.calibration_targets.size()) {
            state.calibration_targets[targetIndex]
        } else {
            state.current_frequency
        };
        
        {
            current_frequency = newFreq;
            frequency_range = state.frequency_range;
            calibration_targets = state.calibration_targets;
            resonance_gates = state.resonance_gates;
        }
    };
    
    // ================================================================== //
    // WHALE ARCHITECTURE — CPL Routing                                     //
    // ================================================================== //
    
    /// Whale song message
    public type WhaleSong = {
        song_id: Text;
        source_pod: Text;
        target_pod: ?Text;
        frequency: Float;
        duration: Float;
        payload: Text;
        hop_count: Nat;
    };
    
    /// Whale routing state
    public type WhaleState = {
        pod_id: Text;
        known_pods: [Text];
        song_queue: [WhaleSong];
        transmission_range: Float;
    };
    
    /// Initialize whale router
    public func whaleInit(podId: Text) : WhaleState {
        {
            pod_id = podId;
            known_pods = [];
            song_queue = [];
            transmission_range = 1000.0; // Can reach far
        }
    };
    
    /// Create and queue a song message
    public func whaleSing(state: WhaleState, targetPod: ?Text, payload: Text) : (WhaleState, WhaleSong) {
        let song : WhaleSong = {
            song_id = state.pod_id # "_" # Int.toText(Time.now());
            source_pod = state.pod_id;
            target_pod = targetPod;
            frequency = 52.0; // 52 Hz whale frequency
            duration = 10.0;
            payload = payload;
            hop_count = 0;
        };
        
        let newQueue = Buffer.Buffer<WhaleSong>(state.song_queue.size() + 1);
        for (s in state.song_queue.vals()) {
            newQueue.add(s);
        };
        newQueue.add(song);
        
        let newState : WhaleState = {
            pod_id = state.pod_id;
            known_pods = state.known_pods;
            song_queue = Buffer.toArray(newQueue);
            transmission_range = state.transmission_range;
        };
        
        (newState, song)
    };
    
    /// Forward a received song
    public func whaleRelay(state: WhaleState, song: WhaleSong) : WhaleSong {
        {
            song_id = song.song_id;
            source_pod = song.source_pod;
            target_pod = song.target_pod;
            frequency = song.frequency;
            duration = song.duration;
            payload = song.payload;
            hop_count = song.hop_count + 1;
        }
    };
    
    // ================================================================== //
    // BEE ARCHITECTURE — Symbol-to-Action                                  //
    // ================================================================== //
    
    /// Waggle dance command
    public type WaggleDance = {
        dance_id: Text;
        direction: Float;      // Angle in radians
        distance: Float;       // Duration indicates distance
        quality: Float;        // Waggle intensity
        command: Text;         // Decoded action
    };
    
    /// Bee hive state
    public type BeeState = {
        hive_id: Text;
        current_dances: [WaggleDance];
        action_queue: [Text];
        swarm_coherence: Float;
    };
    
    /// Initialize bee processor
    public func beeInit(hiveId: Text) : BeeState {
        {
            hive_id = hiveId;
            current_dances = [];
            action_queue = [];
            swarm_coherence = 1.0;
        }
    };
    
    /// Encode command as waggle dance
    public func beeEncodeDance(command: Text, direction: Float, importance: Float) : WaggleDance {
        {
            dance_id = "dance_" # Int.toText(Time.now());
            direction = direction;
            distance = importance * 10.0;
            quality = importance;
            command = command;
        }
    };
    
    /// Decode dance to action
    public func beeDecodeDance(dance: WaggleDance) : Text {
        dance.command
    };
    
    /// Add dance and extract action
    public func beeProcessDance(state: BeeState, dance: WaggleDance) : BeeState {
        let newDances = Buffer.Buffer<WaggleDance>(state.current_dances.size() + 1);
        for (d in state.current_dances.vals()) {
            newDances.add(d);
        };
        newDances.add(dance);
        
        let action = beeDecodeDance(dance);
        let newActions = Buffer.Buffer<Text>(state.action_queue.size() + 1);
        for (a in state.action_queue.vals()) {
            newActions.add(a);
        };
        newActions.add(action);
        
        {
            hive_id = state.hive_id;
            current_dances = Buffer.toArray(newDances);
            action_queue = Buffer.toArray(newActions);
            swarm_coherence = state.swarm_coherence;
        }
    };
    
    // ================================================================== //
    // SYNTHESIZER — COMBINE ALL ARCHITECTURES                              //
    // ================================================================== //
    
    /// Combined animal brain synthesis
    public type AnimalSynthesis = {
        cat_active: Bool;
        dog_active: Bool;
        dolphin_active: Bool;
        octopus_active: Bool;
        eagle_active: Bool;
        bat_active: Bool;
        whale_active: Bool;
        bee_active: Bool;
        synthesis_coherence: Float;
    };
    
    /// Get all active animal architectures for a domain
    public func getArchitecturesForDomain(domain: PatternDomain) : [AnimalType] {
        switch (domain) {
            case (#SemanticBoundary) { [#Cat] };
            case (#MemoryLineage) { [#Dog] };
            case (#SpatialNavigation) { [#Dolphin] };
            case (#ParallelProcessing) { [#Octopus] };
            case (#StrategicPlanning) { [#Eagle] };
            case (#HarmonicCalibration) { [#Bat] };
            case (#Communication) { [#Whale] };
            case (#CommandExecution) { [#Bee] };
        }
    };
    
    /// Create full synthesis status
    public func synthesisStatus() : AnimalSynthesis {
        {
            cat_active = true;
            dog_active = true;
            dolphin_active = true;
            octopus_active = true;
            eagle_active = true;
            bat_active = true;
            whale_active = true;
            bee_active = true;
            synthesis_coherence = 1.0;
        }
    };
}
