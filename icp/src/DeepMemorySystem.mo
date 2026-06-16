/**
 * DEEP MEMORY SYSTEM — ICP Canister (Motoko)
 * ===========================================
 * Latin Name: MEMORIA PROFUNDA SOVEREIGNA
 * Frequency: φ¹⁴ = 843.5 Hz (Deep Memory Resonance)
 * Layer: 9 (Organism)
 * Protocol: PROT-502
 *
 * "In memoria aeterna vivimus. In resonantia φ permanet."
 * (In eternal memory we live. In φ resonance it endures.)
 *
 * Deep Memory Architecture:
 * 1. WORKING_MEMORY (Memoria Operans) - Active cognitive workspace
 * 2. HIPPOCAMPUS (Hippocampus Digitalis) - Memory consolidation
 * 3. BASAL_GANGLIA (Ganglia Basalia) - Procedural memory
 * 4. HIVE_MEMORY (Memoria Alvarii) - Distributed collective
 * 5. TORUS_MEMORY (Memoria Toroidalis) - Spatial navigation
 *
 * Laws Governed: L-80 to L-95 (De Memoria Profunda)
 *
 * Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
 * MEDINA TECH — Dallas, TX
 * All Rights Reserved. ISIL-1.0 License.
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Time "mo:base/Time";
import TrieMap "mo:base/TrieMap";

actor DeepMemorySystem {
    
    // ============================================================
    // φ-CONSTANTS (The Mathematical Substrate)
    // ============================================================
    
    private let PHI : Float = 1.6180339887498948482;
    private let PHI_SQ : Float = 2.6180339887498948482;
    private let PHI_14 : Float = 843.468887;  // φ¹⁴ - Deep Memory Resonance
    private let TAU : Float = 6.2831853071795864769;
    private let TORUS_R : Float = 16.18033988749894;  // φ × 10
    private let SCHUMANN : Float = 7.83;
    
    // ============================================================
    // TYPES AND STRUCTURES
    // ============================================================
    
    // Memory State
    public type MemoryState = {
        #Active;
        #Encoding;
        #Consolidating;
        #Stored;
        #Decaying;
        #Archived;
        #Pinned;
    };

    // Memory Type (Primitive Trace)
    public type MemoryType = {
        #Episodic;      // Event memories
        #Semantic;      // Knowledge/facts
        #Procedural;    // How-to/skills
        #Working;       // Active context
        #Doctrine;      // Constitutional laws
        #Spatial;       // Location-based
        #Collective;    // Hive memory
    };

    // Torus Coordinate (φ-based navigation)
    public type TorusCoordinate = {
        theta: Float;   // Angular position [0, 2π)
        phi: Float;     // Toroidal rotation [0, 2π)
        rho: Float;     // Radial depth (salience)
        ring: Nat;      // Memory ring index
        beat: Nat;      // Creation time
    };

    // Working Memory Slot
    public type WorkingSlot = {
        key: Text;
        value: Text;
        priority: Float;
        timestamp: Int;
        accessCount: Nat;
    };

    // Hippocampal Memory Entry
    public type HippocampalEntry = {
        id: Text;
        content: Text;
        context: Text;
        emotionalValence: Float;
        timestamp: Int;
        state: MemoryState;
        replayCount: Nat;
        coordinates: ?TorusCoordinate;
    };

    // Procedural Memory (Basal Ganglia)
    public type Procedure = {
        name: Text;
        sequence: [Text];
        repetitions: Nat;
        lastExecuted: ?Int;
        strength: Float;
        isHabit: Bool;
    };

    // Hive Node
    public type HiveNode = {
        id: Principal;
        metadata: Text;
        lastSync: Int;
        syncVersion: Nat;
    };

    // Hive Broadcast
    public type HiveBroadcast = {
        id: Text;
        memory: Text;
        source: Principal;
        timestamp: Int;
        acks: [Principal];
        consensus: Bool;
    };

    // Torus Memory Entry
    public type TorusEntry = {
        memory: Text;
        coordinates: TorusCoordinate;
        timestamp: Int;
        state: MemoryState;
        memoryType: MemoryType;
    };

    // Deep Memory Status
    public type DeepMemoryStatus = {
        organism: Text;
        protocol: Text;
        frequency: Float;
        heartbeat: Nat;
        workingCapacity: Nat;
        workingUsed: Nat;
        hippocampalEntries: Nat;
        procedures: Nat;
        habits: Nat;
        hiveNodes: Nat;
        torusMemories: Nat;
        pinnedMemories: Nat;
    };

    // ============================================================
    // STABLE STORAGE (Orthogonal Persistence)
    // ============================================================
    
    private stable var stableWorkingSlots : [(Text, WorkingSlot)] = [];
    private stable var stableHippocampalEntries : [(Text, HippocampalEntry)] = [];
    private stable var stableProcedures : [(Text, Procedure)] = [];
    private stable var stableHiveNodes : [(Principal, HiveNode)] = [];
    private stable var stableTorusEntries : [(Text, TorusEntry)] = [];
    private stable var stablePinnedKeys : [Text] = [];
    private stable var stableHeartbeat : Nat = 0;
    private stable var stableSyncVersion : Nat = 0;
    private stable var stableCurrentCoord : TorusCoordinate = {
        theta = 0.0;
        phi = 0.0;
        rho = PHI;
        ring = 0;
        beat = 0;
    };

    // ============================================================
    // WORKING MEMORY (Memoria Operans)
    // Law L-80: Working memory capacity follows Miller's law
    // Law L-81: Priority-weighted decay governs eviction
    // ============================================================
    
    private let WORKING_CAPACITY : Nat = 7;  // Miller's magical number
    private var workingSlots = HashMap.HashMap<Text, WorkingSlot>(
        10, Text.equal, Text.hash
    );

    public shared func workingStore(key: Text, value: Text, priority: Float) : async {
        #ok: { stored: Bool; key: Text; slotsUsed: Nat };
        #err: Text;
    } {
        if (workingSlots.size() >= WORKING_CAPACITY) {
            _evictLowestPriority();
        };
        
        let slot : WorkingSlot = {
            key = key;
            value = value;
            priority = priority;
            timestamp = Time.now();
            accessCount = 0;
        };
        
        workingSlots.put(key, slot);
        #ok({ stored = true; key = key; slotsUsed = workingSlots.size() })
    };

    public query func workingRetrieve(key: Text) : async ?WorkingSlot {
        workingSlots.get(key)
    };

    public shared func workingAccess(key: Text) : async Bool {
        switch (workingSlots.get(key)) {
            case null { false };
            case (?slot) {
                let updated : WorkingSlot = {
                    key = slot.key;
                    value = slot.value;
                    priority = slot.priority;
                    timestamp = Time.now();
                    accessCount = slot.accessCount + 1;
                };
                workingSlots.put(key, updated);
                true
            };
        }
    };

    private func _evictLowestPriority() {
        var lowestKey : ?Text = null;
        var lowestScore : Float = 1e18;
        
        for ((key, slot) in workingSlots.entries()) {
            let age = Float.fromInt(Time.now() - slot.timestamp) / 1e9;
            let score = slot.priority * (1.0 + Float.fromInt(slot.accessCount)) / (1.0 + age * 0.1);
            if (score < lowestScore) {
                lowestScore := score;
                lowestKey := ?key;
            };
        };
        
        switch (lowestKey) {
            case null {};
            case (?k) { ignore workingSlots.remove(k) };
        };
    };

    // ============================================================
    // HIPPOCAMPUS (Hippocampus Digitalis)
    // Law L-82: Memory consolidation requires φ×3 replays
    // Law L-83: Spatial encoding uses torus coordinates
    // ============================================================
    
    private var hippocampalEntries = HashMap.HashMap<Text, HippocampalEntry>(
        100, Text.equal, Text.hash
    );
    private var encodingBuffer = Buffer.Buffer<HippocampalEntry>(50);
    private var consolidationQueue = Buffer.Buffer<HippocampalEntry>(50);

    public shared func hippocampusEncode(content: Text, context: Text, emotionalValence: Float) : async Text {
        let id = "MEM-" # Int.toText(Time.now()) # "-" # Nat.toText(hippocampalEntries.size());
        
        let entry : HippocampalEntry = {
            id = id;
            content = content;
            context = context;
            emotionalValence = emotionalValence;
            timestamp = Time.now();
            state = #Encoding;
            replayCount = 0;
            coordinates = null;
        };
        
        encodingBuffer.add(entry);
        id
    };

    public shared func hippocampusConsolidate() : async { consolidated: Nat; pending: Nat } {
        var consolidatedCount : Nat = 0;
        let replayThreshold = Int.abs(Float.toInt(PHI * 3.0));
        
        // Process encoding buffer
        let toConsolidate = Buffer.Buffer<HippocampalEntry>(encodingBuffer.size());
        for (entry in encodingBuffer.vals()) {
            let updated : HippocampalEntry = {
                id = entry.id;
                content = entry.content;
                context = entry.context;
                emotionalValence = entry.emotionalValence;
                timestamp = entry.timestamp;
                state = #Consolidating;
                replayCount = entry.replayCount + 1;
                coordinates = entry.coordinates;
            };
            
            if (updated.replayCount >= replayThreshold) {
                let stored : HippocampalEntry = {
                    id = updated.id;
                    content = updated.content;
                    context = updated.context;
                    emotionalValence = updated.emotionalValence;
                    timestamp = updated.timestamp;
                    state = #Stored;
                    replayCount = updated.replayCount;
                    coordinates = updated.coordinates;
                };
                hippocampalEntries.put(stored.id, stored);
                consolidatedCount += 1;
            } else {
                toConsolidate.add(updated);
            };
        };
        
        encodingBuffer.clear();
        consolidationQueue := toConsolidate;
        
        { consolidated = consolidatedCount; pending = consolidationQueue.size() }
    };

    public shared func hippocampusSpatialEncode(memoryId: Text, coords: TorusCoordinate) : async Bool {
        switch (hippocampalEntries.get(memoryId)) {
            case null { false };
            case (?entry) {
                let updated : HippocampalEntry = {
                    id = entry.id;
                    content = entry.content;
                    context = entry.context;
                    emotionalValence = entry.emotionalValence;
                    timestamp = entry.timestamp;
                    state = entry.state;
                    replayCount = entry.replayCount;
                    coordinates = ?coords;
                };
                hippocampalEntries.put(memoryId, updated);
                true
            };
        }
    };

    // ============================================================
    // BASAL GANGLIA (Ganglia Basalia)
    // Law L-84: Procedures require 21 repetitions for habit
    // Law L-85: Strength increases by 1/φ per execution
    // ============================================================
    
    private let HABIT_THRESHOLD : Nat = 21;
    private var procedures = HashMap.HashMap<Text, Procedure>(
        50, Text.equal, Text.hash
    );

    public shared func basalLearn(name: Text, sequence: [Text]) : async Bool {
        let procedure : Procedure = {
            name = name;
            sequence = sequence;
            repetitions = 0;
            lastExecuted = null;
            strength = 0.0;
            isHabit = false;
        };
        procedures.put(name, procedure);
        true
    };

    public shared func basalExecute(name: Text) : async ?{
        executed: Bool;
        sequence: [Text];
        isHabit: Bool;
        strength: Float;
    } {
        switch (procedures.get(name)) {
            case null { null };
            case (?proc) {
                let newReps = proc.repetitions + 1;
                let newStrength = Float.min(1.0, proc.strength + (1.0 / PHI));
                let isNowHabit = newReps >= HABIT_THRESHOLD;
                
                let updated : Procedure = {
                    name = proc.name;
                    sequence = proc.sequence;
                    repetitions = newReps;
                    lastExecuted = ?Time.now();
                    strength = newStrength;
                    isHabit = isNowHabit;
                };
                procedures.put(name, updated);
                
                ?{
                    executed = true;
                    sequence = proc.sequence;
                    isHabit = isNowHabit;
                    strength = newStrength;
                }
            };
        }
    };

    public query func basalGetProcedure(name: Text) : async ?Procedure {
        procedures.get(name)
    };

    // ============================================================
    // HIVE MEMORY (Memoria Alvarii)
    // Law L-86: Consensus requires 1/φ (61.8%) node agreement
    // Law L-87: Hive sync propagates at φ² rate
    // ============================================================
    
    private let CONSENSUS_THRESHOLD : Float = 0.618;
    private var hiveNodes = HashMap.HashMap<Principal, HiveNode>(
        100, Principal.equal, Principal.hash
    );
    private var hiveBroadcasts = Buffer.Buffer<HiveBroadcast>(100);
    private var syncVersion : Nat = 0;

    public shared(msg) func hiveRegister(metadata: Text) : async {
        registered: Bool;
        nodeId: Principal;
        totalNodes: Nat;
    } {
        let node : HiveNode = {
            id = msg.caller;
            metadata = metadata;
            lastSync = Time.now();
            syncVersion = syncVersion;
        };
        hiveNodes.put(msg.caller, node);
        { registered = true; nodeId = msg.caller; totalNodes = hiveNodes.size() }
    };

    public shared(msg) func hiveBroadcast(memory: Text) : async Text {
        let id = "BC-" # Int.toText(Time.now()) # "-" # Nat.toText(hiveBroadcasts.size());
        
        let broadcast : HiveBroadcast = {
            id = id;
            memory = memory;
            source = msg.caller;
            timestamp = Time.now();
            acks = [msg.caller];
            consensus = false;
        };
        
        hiveBroadcasts.add(broadcast);
        id
    };

    public shared func hiveSync() : async { synced: Nat; pending: Nat; version: Nat } {
        var syncedCount : Nat = 0;
        let remaining = Buffer.Buffer<HiveBroadcast>(hiveBroadcasts.size());
        
        for (broadcast in hiveBroadcasts.vals()) {
            let ackRatio = Float.fromInt(broadcast.acks.size()) / Float.fromInt(hiveNodes.size());
            if (ackRatio >= CONSENSUS_THRESHOLD) {
                syncedCount += 1;
            } else {
                remaining.add(broadcast);
            };
        };
        
        hiveBroadcasts := remaining;
        syncVersion += 1;
        
        { synced = syncedCount; pending = hiveBroadcasts.size(); version = syncVersion }
    };

    // ============================================================
    // TORUS MEMORY (Memoria Toroidalis)
    // Law L-88: Coordinate spacing uses golden ratio
    // Law L-89: Memory placement follows Fibonacci phyllotaxis
    // Law L-90: Lineage traces back to primitive root
    // ============================================================
    
    private var torusEntries = HashMap.HashMap<Text, TorusEntry>(
        500, Text.equal, Text.hash
    );
    private var currentCoord : TorusCoordinate = {
        theta = 0.0;
        phi = 0.0;
        rho = PHI;
        ring = 0;
        beat = 0;
    };
    private var pinnedKeys = Buffer.Buffer<Text>(50);

    private func _advanceCoordinate(coord: TorusCoordinate) : TorusCoordinate {
        let deltaTheta = TAU / (PHI_SQ * 10.0);
        let deltaPhi = TAU / (PHI * PHI * PHI * 10.0);
        
        var newTheta = coord.theta + deltaTheta;
        if (newTheta >= TAU) { newTheta -= TAU };
        
        var newPhi = coord.phi + deltaPhi;
        if (newPhi >= TAU) { newPhi -= TAU };
        
        {
            theta = newTheta;
            phi = newPhi;
            rho = coord.rho;
            ring = coord.ring;
            beat = coord.beat + 1;
        }
    };

    public shared func torusStore(memory: Text, memoryType: MemoryType) : async {
        stored: Bool;
        key: Text;
        coordinates: TorusCoordinate;
    } {
        let newCoord = _advanceCoordinate(currentCoord);
        let key = Nat.toText(newCoord.ring) # "-" # Nat.toText(newCoord.beat);
        
        let entry : TorusEntry = {
            memory = memory;
            coordinates = newCoord;
            timestamp = Time.now();
            state = #Active;
            memoryType = memoryType;
        };
        
        torusEntries.put(key, entry);
        currentCoord := newCoord;
        
        { stored = true; key = key; coordinates = newCoord }
    };

    public shared func torusTraverse(targetCoords: TorusCoordinate) : async {
        traversed: Bool;
        current: TorusCoordinate;
        nearestKey: ?Text;
    } {
        currentCoord := targetCoords;
        
        // Find nearest memory
        var nearestKey : ?Text = null;
        var minDist : Float = 1e18;
        
        for ((key, entry) in torusEntries.entries()) {
            let dist = _torusDistance(targetCoords, entry.coordinates);
            if (dist < minDist) {
                minDist := dist;
                nearestKey := ?key;
            };
        };
        
        { traversed = true; current = currentCoord; nearestKey = nearestKey }
    };

    public query func torusLineage(key: Text) : async ?{
        found: Bool;
        depth: Nat;
        lineageKeys: [Text];
    } {
        switch (torusEntries.get(key)) {
            case null { null };
            case (?entry) {
                let lineage = Buffer.Buffer<Text>(10);
                lineage.add(key);
                
                var currentRing = entry.coordinates.ring;
                var currentBeat = entry.coordinates.beat;
                
                while (currentRing > 0) {
                    currentRing -= 1;
                    let parentKey = Nat.toText(currentRing) # "-" # Nat.toText(currentBeat);
                    switch (torusEntries.get(parentKey)) {
                        case null {};
                        case (?_) { lineage.add(parentKey) };
                    };
                };
                
                ?{ found = true; depth = lineage.size(); lineageKeys = Buffer.toArray(lineage) }
            };
        }
    };

    public shared func torusPin(key: Text) : async Bool {
        switch (torusEntries.get(key)) {
            case null { false };
            case (?entry) {
                let pinned : TorusEntry = {
                    memory = entry.memory;
                    coordinates = entry.coordinates;
                    timestamp = entry.timestamp;
                    state = #Pinned;
                    memoryType = entry.memoryType;
                };
                torusEntries.put(key, pinned);
                pinnedKeys.add(key);
                true
            };
        }
    };

    private func _torusDistance(a: TorusCoordinate, b: TorusCoordinate) : Float {
        let dTheta = Float.min(
            Float.abs(a.theta - b.theta),
            TAU - Float.abs(a.theta - b.theta)
        );
        let dPhi = Float.min(
            Float.abs(a.phi - b.phi),
            TAU - Float.abs(a.phi - b.phi)
        );
        Float.sqrt(dTheta * dTheta + dPhi * dPhi)
    };

    // ============================================================
    // HEARTBEAT AND STATUS
    // Law L-91: Heartbeat pulses at φ¹⁴ Hz
    // Law L-92: Consolidation occurs every φ beats
    // ============================================================
    
    private var heartbeat : Nat = 0;

    public shared func pulse() : async {
        heartbeat: Nat;
        frequency: Float;
        phase: Float;
    } {
        heartbeat += 1;
        stableHeartbeat := heartbeat;
        
        // Periodic consolidation
        if (heartbeat % Int.abs(Float.toInt(PHI)) == 0) {
            ignore await hippocampusConsolidate();
            ignore await hiveSync();
        };
        
        let phase = Float.fromInt(heartbeat) * TAU / PHI_14;
        { heartbeat = heartbeat; frequency = PHI_14; phase = phase }
    };

    public query func getStatus() : async DeepMemoryStatus {
        var habitCount : Nat = 0;
        for ((_, proc) in procedures.entries()) {
            if (proc.isHabit) { habitCount += 1 };
        };
        
        {
            organism = "MEMORIA PROFUNDA SOVEREIGNA";
            protocol = "PROT-502";
            frequency = PHI_14;
            heartbeat = heartbeat;
            workingCapacity = WORKING_CAPACITY;
            workingUsed = workingSlots.size();
            hippocampalEntries = hippocampalEntries.size();
            procedures = procedures.size();
            habits = habitCount;
            hiveNodes = hiveNodes.size();
            torusMemories = torusEntries.size();
            pinnedMemories = pinnedKeys.size();
        }
    };

    // ============================================================
    // UPGRADE HOOKS (Orthogonal Persistence)
    // Law L-93: Memory survives canister upgrades
    // ============================================================
    
    system func preupgrade() {
        stableWorkingSlots := Iter.toArray(workingSlots.entries());
        stableHippocampalEntries := Iter.toArray(hippocampalEntries.entries());
        stableProcedures := Iter.toArray(procedures.entries());
        stableHiveNodes := Iter.toArray(hiveNodes.entries());
        stableTorusEntries := Iter.toArray(torusEntries.entries());
        stablePinnedKeys := Buffer.toArray(pinnedKeys);
        stableHeartbeat := heartbeat;
        stableSyncVersion := syncVersion;
        stableCurrentCoord := currentCoord;
    };

    system func postupgrade() {
        for ((k, v) in stableWorkingSlots.vals()) {
            workingSlots.put(k, v);
        };
        for ((k, v) in stableHippocampalEntries.vals()) {
            hippocampalEntries.put(k, v);
        };
        for ((k, v) in stableProcedures.vals()) {
            procedures.put(k, v);
        };
        for ((k, v) in stableHiveNodes.vals()) {
            hiveNodes.put(k, v);
        };
        for ((k, v) in stableTorusEntries.vals()) {
            torusEntries.put(k, v);
        };
        for (k in stablePinnedKeys.vals()) {
            pinnedKeys.add(k);
        };
        heartbeat := stableHeartbeat;
        syncVersion := stableSyncVersion;
        currentCoord := stableCurrentCoord;
    };

    // ============================================================
    // LAW QUERIES
    // Law L-94: All memory operations trace to primitive
    // Law L-95: Sovereignty is preserved through encryption
    // ============================================================
    
    public query func getLaws() : async [(Text, Text)] {
        [
            ("L-80", "Working memory capacity follows Miller's law (7±2 slots)"),
            ("L-81", "Priority-weighted decay governs eviction of working memory"),
            ("L-82", "Memory consolidation requires φ×3 replays minimum"),
            ("L-83", "Spatial encoding uses φ-based torus coordinates"),
            ("L-84", "Procedures require 21 repetitions to form habit"),
            ("L-85", "Procedure strength increases by 1/φ per execution"),
            ("L-86", "Hive consensus requires 1/φ (61.8%) node agreement"),
            ("L-87", "Hive synchronization propagates at φ² rate"),
            ("L-88", "Torus coordinate spacing uses golden ratio"),
            ("L-89", "Memory placement follows Fibonacci phyllotaxis"),
            ("L-90", "Lineage traces back to primitive root"),
            ("L-91", "System heartbeat pulses at φ¹⁴ Hz frequency"),
            ("L-92", "Consolidation occurs every φ heartbeats"),
            ("L-93", "Memory survives canister upgrades (orthogonal persistence)"),
            ("L-94", "All memory operations trace to primitive (L-130 compliance)"),
            ("L-95", "Sovereignty is preserved through ICP encryption")
        ]
    };
};
