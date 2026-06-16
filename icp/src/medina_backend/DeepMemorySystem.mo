/**
 * ╔══════════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                              ║
 * ║                         DEEP MEMORY SYSTEM — MEMORIA PROFUNDA                               ║
 * ║                   Biomimetic Memory Architecture on Internet Computer                        ║
 * ║                                                                                              ║
 * ║  "Quod Cerebrum Animalium Docet, Machina Intelligens Discit"                                ║
 * ║  (What Animal Brains Teach, Intelligent Machines Learn)                                      ║
 * ║                                                                                              ║
 * ║  Protocol: PROT-501 through PROT-512 — DEEP MEMORY INFRASTRUCTURE                           ║
 * ║  Frequency: φ¹⁵ = 1364.0 Hz — Deep Memory Layer                                             ║
 * ║  Primitive Trace: FIELD → DISTINCTION → MEMORY → ADDRESS → REPETITION → RELATION → φ        ║
 * ║                                                                                              ║
 * ║  COMPONENTS:                                                                                 ║
 * ║    1. WorkingMemory — Prefrontal cortex model (PROT-501)                                    ║
 * ║    2. Hippocampus — Long-term memory consolidation (PROT-502)                               ║
 * ║    3. BasalGanglia — Procedural memory & habits (PROT-503)                                  ║
 * ║    4. HiveMemory — Distributed consensus memory (PROT-504)                                  ║
 * ║    5. AnimalSynthesis — Cross-species memory integration (PROT-505)                         ║
 * ║                                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                  ║
 * ║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
 * ╚══════════════════════════════════════════════════════════════════════════════════════════════╝
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
import Text "mo:base/Text";
import Time "mo:base/Time";

import Types "Types";
import Utils "Utils";
import MatalkoICP "MatalkoICP";

module DeepMemorySystem {
    
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    // MATHEMATICAL CONSTANTS — The Substrate
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    
    public let PHI : Float = 1.6180339887498948482;
    public let PHI_SQUARED : Float = 2.6180339887498948482;
    public let PHI_INVERSE : Float = 0.6180339887498948482;
    public let PHI_15 : Float = 1364.000660676265;  // φ¹⁵ — Deep Memory frequency
    public let PHI_12 : Float = 321.9968643232382;  // φ¹² — Hippocampal theta
    public let PHI_11 : Float = 199.0050154405025;  // φ¹¹ — Motor rhythm
    public let PHI_10 : Float = 122.9918688644118;  // φ¹⁰ — Hive resonance
    public let PHI_8 : Float = 46.97871376374721;   // φ⁸ — Working memory gamma
    
    // Miller's Law: 7 ± 2 items — we use φ-based capacity
    public let WORKING_MEMORY_CAPACITY : Nat = 7;  // φ⁴ ≈ 6.854 rounded
    public let ATTENTION_DECAY_RATE : Float = PHI_INVERSE;
    public let REHEARSAL_BOOST : Float = PHI_INVERSE;
    
    // Habit formation thresholds
    public let CHUNKING_THRESHOLD : Nat = 5;
    public let HABIT_THRESHOLD : Nat = 21;
    public let QUORUM_THRESHOLD : Float = PHI_INVERSE;  // ~0.618
    
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    // TYPES — Deep Memory Hierarchy
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    
    /// Memory hierarchy levels
    public type MemoryHierarchy = {
        #SensoryBuffer;    // Ultra-short: iconic/echoic
        #WorkingMemory;    // Active manipulation
        #ShortTerm;        // Temporary holding
        #LongTerm;         // Consolidated storage
        #Procedural;       // Skill memory
        #Semantic;         // Factual knowledge
        #Episodic;         // Event memory
        #Hive;             // Distributed consensus
    };
    
    /// Working memory item types (Baddeley model)
    public type WorkingMemoryType = {
        #Phonological;     // Verbal/acoustic
        #Visuospatial;     // Visual/spatial
        #Episodic;         // Integrated episodes
        #Executive;        // Control coordination
    };
    
    /// Attention gating states
    public type AttentionGate = {
        #Open;             // Full attention
        #Partial;          // Selective
        #Closed;           // Maintenance mode
        #Refresh;          // Active refreshing
    };
    
    /// Skill acquisition phases (Fitts & Posner)
    public type SkillPhase = {
        #Cognitive;        // Learning what
        #Associative;      // Practicing how
        #Autonomous;       // Automatic execution
    };
    
    /// Habit formation states
    public type HabitState = {
        #Novel;            // New behavior
        #Learning;         // Being learned
        #Chunked;          // Chunked sequence
        #Habitual;         // Automatic habit
        #Overlearned;      // Deeply ingrained
    };
    
    /// Consolidation phases
    public type ConsolidationPhase = {
        #Encoding;         // Initial registration
        #Binding;          // Feature binding
        #ShortTerm;        // Hippocampal holding
        #Replay;           // Offline replay
        #Transfer;         // Moving to cortex
        #Consolidated;     // Long-term storage
    };
    
    /// Hive node roles
    public type HiveNodeRole = {
        #Queen;            // Central coordinator
        #Scout;            // Discovers information
        #Forager;          // Retrieves information
        #Nurse;            // Maintains local memory
        #Guard;            // Validates data
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    // WORKING MEMORY — Prefrontal Cortex Model (PROT-501)
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    
    /// Working memory item
    public type WorkingMemoryItem = {
        itemId: Text;
        content: Text;
        itemType: WorkingMemoryType;
        activation: Float;
        createdAt: Int;
        lastAccessed: Int;
        accessCount: Nat;
        bindings: [Text];
        source: Text;
    };
    
    /// Central Executive state
    public type CentralExecutive = {
        executiveId: Text;
        totalCapacity: Float;
        availableCapacity: Float;
        focusedSlots: [Text];
        focusIntensity: Float;
        currentTask: ?Text;
        taskStack: [Text];
        bindingActive: Bool;
        retrievalMode: Bool;
        encodingMode: Bool;
    };
    
    /// Working Memory System state
    public type WorkingMemoryState = {
        systemId: Text;
        frequency: Float;
        phonologicalLoop: [(Text, WorkingMemoryItem)];
        visuospatialSketchpad: [(Text, WorkingMemoryItem)];
        episodicBuffer: [(Text, WorkingMemoryItem)];
        executive: CentralExecutive;
        gateState: AttentionGate;
        totalStored: Nat;
        totalDecayed: Nat;
        totalConsolidated: Nat;
    };
    
    /// Initialize Working Memory System
    public func initWorkingMemory(organismId: Text) : WorkingMemoryState {
        let systemId = "WMS-" # organismId;
        {
            systemId = systemId;
            frequency = PHI_8;
            phonologicalLoop = [];
            visuospatialSketchpad = [];
            episodicBuffer = [];
            executive = {
                executiveId = "CE-" # systemId;
                totalCapacity = 1.0;
                availableCapacity = 1.0;
                focusedSlots = [];
                focusIntensity = 1.0;
                currentTask = null;
                taskStack = [];
                bindingActive = false;
                retrievalMode = false;
                encodingMode = false;
            };
            gateState = #Open;
            totalStored = 0;
            totalDecayed = 0;
            totalConsolidated = 0;
        }
    };
    
    /// Calculate decay for working memory item
    public func calculateDecay(item: WorkingMemoryItem, currentTime: Int) : Float {
        let timeDelta = Float.fromInt(currentTime - item.lastAccessed) / 1_000_000_000.0;  // nanoseconds to seconds
        let decayFactor = Float.exp(-ATTENTION_DECAY_RATE * timeDelta);
        item.activation * decayFactor
    };
    
    /// Rehearse item to prevent decay
    public func rehearseItem(item: WorkingMemoryItem) : WorkingMemoryItem {
        {
            itemId = item.itemId;
            content = item.content;
            itemType = item.itemType;
            activation = Float.min(1.0, item.activation + REHEARSAL_BOOST);
            createdAt = item.createdAt;
            lastAccessed = Time.now();
            accessCount = item.accessCount + 1;
            bindings = item.bindings;
            source = item.source;
        }
    };
    
    /// Should gate new item (prefrontal decision)
    public func shouldGate(currentLoad: Nat, itemActivation: Float) : AttentionGate {
        if (currentLoad >= WORKING_MEMORY_CAPACITY - 1) {
            if (itemActivation > PHI_INVERSE) { #Partial } else { #Closed }
        } else {
            if (itemActivation > 0.3) { #Open } else { #Partial }
        }
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    // HIPPOCAMPUS — Long-Term Memory Consolidation (PROT-502)
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    
    /// Place cell — fires at specific torus location
    public type PlaceCell = {
        cellId: Text;
        centerTheta: Float;
        centerPhi: Float;
        fieldRadius: Float;
        currentFiringRate: Float;
        peakFiringRate: Float;
        boundMemories: [Text];
        totalActivations: Nat;
        createdAt: Int;
    };
    
    /// Grid cell — hexagonal spatial mapping
    public type GridCell = {
        cellId: Text;
        gridSpacing: Float;
        gridOrientation: Float;
        phaseOffsetX: Float;
        phaseOffsetY: Float;
        currentFiringRate: Float;
        peakFiringRate: Float;
    };
    
    /// Time cell — temporal sequence encoding
    public type TimeCell = {
        cellId: Text;
        preferredTime: Float;
        temporalWidth: Float;
        currentFiringRate: Float;
        peakFiringRate: Float;
        sequenceId: ?Text;
        sequencePosition: Nat;
    };
    
    /// Episodic memory record
    public type EpisodicMemory = {
        memoryId: Text;
        content: Text;
        semanticTags: [Text];
        theta: Float;
        phi: Float;
        depth: Float;
        timestamp: Int;
        sequenceId: ?Text;
        sequencePosition: Nat;
        duration: Float;
        boundPlaceCells: [Text];
        boundTimeCells: [Text];
        associatedMemories: [Text];
        phase: ConsolidationPhase;
        consolidationStrength: Float;
        replayCount: Nat;
        accessCount: Nat;
        lastAccessed: Int;
        retrievalStrength: Float;
    };
    
    /// Hippocampal System state
    public type HippocampalState = {
        systemId: Text;
        frequency: Float;
        placeCells: [(Text, PlaceCell)];
        gridCells: [(Text, GridCell)];
        timeCells: [(Text, TimeCell)];
        episodicMemories: [(Text, EpisodicMemory)];
        memoryIndex: [(Text, [Text])];  // tag -> memory_ids
        currentTheta: Float;
        currentPhi: Float;
        currentSequence: ?Text;
        sequenceStartTime: Int;
        totalEncoded: Nat;
        totalConsolidated: Nat;
        totalReplays: Nat;
    };
    
    /// Initialize Hippocampal System
    public func initHippocampus(organismId: Text) : HippocampalState {
        {
            systemId = "HIPP-" # organismId;
            frequency = PHI_12;
            placeCells = [];
            gridCells = [];
            timeCells = [];
            episodicMemories = [];
            memoryIndex = [];
            currentTheta = 0.0;
            currentPhi = 0.0;
            currentSequence = null;
            sequenceStartTime = 0;
            totalEncoded = 0;
            totalConsolidated = 0;
            totalReplays = 0;
        }
    };
    
    /// Compute place cell firing rate
    public func computePlaceCellFiring(cell: PlaceCell, theta: Float, phi: Float) : Float {
        let dTheta = Float.abs(theta - cell.centerTheta);
        let dPhi = Float.abs(phi - cell.centerPhi);
        let distance = Float.sqrt(dTheta * dTheta + dPhi * dPhi);
        cell.peakFiringRate * Float.exp(-(distance * distance) / (2.0 * cell.fieldRadius * cell.fieldRadius))
    };
    
    /// Compute time cell firing rate
    public func computeTimeCellFiring(cell: TimeCell, elapsedTime: Float) : Float {
        let timeDiff = Float.abs(elapsedTime - cell.preferredTime);
        cell.peakFiringRate * Float.exp(-(timeDiff * timeDiff) / (2.0 * cell.temporalWidth * cell.temporalWidth))
    };
    
    /// Replay episodic memory (consolidation strengthening)
    public func replayMemory(memory: EpisodicMemory) : EpisodicMemory {
        {
            memoryId = memory.memoryId;
            content = memory.content;
            semanticTags = memory.semanticTags;
            theta = memory.theta;
            phi = memory.phi;
            depth = memory.depth;
            timestamp = memory.timestamp;
            sequenceId = memory.sequenceId;
            sequencePosition = memory.sequencePosition;
            duration = memory.duration;
            boundPlaceCells = memory.boundPlaceCells;
            boundTimeCells = memory.boundTimeCells;
            associatedMemories = memory.associatedMemories;
            phase = memory.phase;
            consolidationStrength = Float.min(1.0, memory.consolidationStrength + 0.1);
            replayCount = memory.replayCount + 1;
            accessCount = memory.accessCount;
            lastAccessed = memory.lastAccessed;
            retrievalStrength = memory.retrievalStrength;
        }
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    // BASAL GANGLIA — Procedural Memory & Habits (PROT-503)
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    
    /// Action unit
    public type Action = {
        actionId: Text;
        name: Text;
        parameters: [(Text, Text)];
        duration: Float;
        qValue: Float;
        executionCount: Nat;
        successCount: Nat;
        lastExecuted: Int;
        averageLatency: Float;
    };
    
    /// Motor program — stored action sequence
    public type MotorProgram = {
        programId: Text;
        name: Text;
        actions: [Text];
        timing: [Float];
        currentStep: Nat;
        isRunning: Bool;
        phase: SkillPhase;
        executionCount: Nat;
        errorCount: Nat;
        isChunked: Bool;
        parentChunk: ?Text;
        subPrograms: [Text];
    };
    
    /// Procedural skill
    public type ProceduralSkill = {
        skillId: Text;
        name: Text;
        description: Text;
        motorPrograms: [Text];
        contextCues: [Text];
        phase: SkillPhase;
        totalPracticeTime: Float;
        masteryLevel: Float;
        createdAt: Int;
        lastPracticed: Int;
    };
    
    /// Habit formation loop
    public type HabitFormation = {
        habitId: Text;
        name: Text;
        cue: Text;
        routine: Text;
        reward: Text;
        state: HabitState;
        repetitions: Nat;
        consecutiveSuccesses: Nat;
        cueRoutineStrength: Float;
        routineRewardStrength: Float;
        formedAt: ?Int;
        lastTriggered: Int;
    };
    
    /// Basal Ganglia System state
    public type BasalGangliaState = {
        systemId: Text;
        frequency: Float;
        actions: [(Text, Action)];
        motorPrograms: [(Text, MotorProgram)];
        skills: [(Text, ProceduralSkill)];
        habits: [(Text, HabitFormation)];
        qTable: [(Text, [(Text, Float)])];  // state -> [(action, value)]
        currentState: Text;
        currentProgram: ?Text;
        explorationRate: Float;
        totalActionsExecuted: Nat;
        totalProgramsCompleted: Nat;
        totalHabitsFormed: Nat;
    };
    
    /// Initialize Basal Ganglia System
    public func initBasalGanglia(organismId: Text) : BasalGangliaState {
        {
            systemId = "BG-" # organismId;
            frequency = PHI_11;
            actions = [];
            motorPrograms = [];
            skills = [];
            habits = [];
            qTable = [];
            currentState = "IDLE";
            currentProgram = null;
            explorationRate = PHI_INVERSE * 0.5;  // ~0.309
            totalActionsExecuted = 0;
            totalProgramsCompleted = 0;
            totalHabitsFormed = 0;
        }
    };
    
    /// Update Q-value using TD learning
    public func updateQValue(
        currentQ: Float,
        reward: Float,
        nextQ: Float,
        learningRate: Float,
        discountFactor: Float
    ) : Float {
        let tdError = reward + discountFactor * nextQ - currentQ;
        currentQ + learningRate * tdError
    };
    
    /// Update habit state based on repetitions
    public func updateHabitState(habit: HabitFormation) : HabitState {
        if (habit.repetitions >= HABIT_THRESHOLD * 3 and habit.cueRoutineStrength > 0.95) {
            #Overlearned
        } else if (habit.repetitions >= HABIT_THRESHOLD and habit.cueRoutineStrength > 0.8) {
            #Habitual
        } else if (habit.repetitions >= CHUNKING_THRESHOLD and habit.cueRoutineStrength > 0.5) {
            #Chunked
        } else if (habit.repetitions > 0) {
            #Learning
        } else {
            #Novel
        }
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    // HIVE MEMORY — Distributed Consensus (PROT-504)
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    
    /// Hive node
    public type HiveNode = {
        nodeId: Text;
        role: HiveNodeRole;
        localMemory: [(Text, Text)];
        neighbors: [Text];
        pheromoneTrails: [(Text, Float)];
        messagesSent: Nat;
        messagesReceived: Nat;
        memoriesStored: Nat;
    };
    
    /// Waggle dance — bee-style location encoding
    public type WaggleDance = {
        danceId: Text;
        dancerId: Text;
        angle: Float;
        duration: Float;
        vigor: Float;
        resourceType: Text;
        resourceId: Text;
        startedAt: Int;
        followers: [Text];
    };
    
    /// Hive Memory System state
    public type HiveMemoryState = {
        systemId: Text;
        frequency: Float;
        nodes: [(Text, HiveNode)];
        queenId: ?Text;
        globalMemory: [(Text, Text)];
        activeDances: [(Text, WaggleDance)];
        totalWrites: Nat;
        totalReads: Nat;
        consensusAchieved: Nat;
        consensusFailed: Nat;
    };
    
    /// Initialize Hive Memory System
    public func initHiveMemory(organismId: Text) : HiveMemoryState {
        {
            systemId = "HIVE-" # organismId;
            frequency = PHI_10;
            nodes = [];
            queenId = null;
            globalMemory = [];
            activeDances = [];
            totalWrites = 0;
            totalReads = 0;
            consensusAchieved = 0;
            consensusFailed = 0;
        }
    };
    
    /// Check if quorum reached
    public func hasQuorum(votes: [Bool]) : Bool {
        if (votes.size() == 0) { return false };
        var yesCount : Nat = 0;
        for (v in votes.vals()) {
            if (v) { yesCount += 1 };
        };
        let agreement = Float.fromInt(yesCount) / Float.fromInt(votes.size());
        agreement >= QUORUM_THRESHOLD
    };
    
    /// Encode location to waggle dance parameters
    public func encodeWaggleDance(theta: Float, phi: Float, distance: Float) : (Float, Float) {
        let angle = theta;
        let waggleDuration = distance / 100.0;  // WAGGLE_DISTANCE_SCALE
        (angle, waggleDuration)
    };
    
    /// Decode waggle dance to location
    public func decodeWaggleDance(angle: Float, duration: Float, vigor: Float) : (Float, Float, Float) {
        let theta = angle;
        let distance = duration * 100.0;
        let phi = vigor * 2.0 * Utils.PI;  // Use PI constant
        (theta, phi, distance)
    };
    
    /// Evaporate pheromone trail
    public func evaporatePheromone(strength: Float, rate: Float) : Float {
        let newStrength = strength * (1.0 - rate);
        if (newStrength < 0.01) { 0.0 } else { newStrength }
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    // INTEGRATED DEEP MEMORY SYSTEM (PROT-505)
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    
    /// Complete Deep Memory System state
    public type DeepMemoryState = {
        organismId: Text;
        frequency: Float;
        workingMemory: WorkingMemoryState;
        hippocampus: HippocampalState;
        basalGanglia: BasalGangliaState;
        hiveMemory: HiveMemoryState;
        createdAt: Int;
        lastActivity: Int;
        totalOperations: Nat;
    };
    
    /// Initialize complete Deep Memory System
    public func init(organismId: Text) : DeepMemoryState {
        {
            organismId = organismId;
            frequency = PHI_15;
            workingMemory = initWorkingMemory(organismId);
            hippocampus = initHippocampus(organismId);
            basalGanglia = initBasalGanglia(organismId);
            hiveMemory = initHiveMemory(organismId);
            createdAt = Time.now();
            lastActivity = Time.now();
            totalOperations = 0;
        }
    };
    
    /// Get system status
    public func getStatus(state: DeepMemoryState) : {
        organismId: Text;
        frequency: Float;
        workingMemoryLoad: Nat;
        episodicMemoryCount: Nat;
        skillCount: Nat;
        habitCount: Nat;
        hiveNodeCount: Nat;
        totalOperations: Nat;
    } {
        {
            organismId = state.organismId;
            frequency = state.frequency;
            workingMemoryLoad = state.workingMemory.phonologicalLoop.size() +
                               state.workingMemory.visuospatialSketchpad.size() +
                               state.workingMemory.episodicBuffer.size();
            episodicMemoryCount = state.hippocampus.episodicMemories.size();
            skillCount = state.basalGanglia.skills.size();
            habitCount = state.basalGanglia.habits.size();
            hiveNodeCount = state.hiveMemory.nodes.size();
            totalOperations = state.totalOperations;
        }
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    // LAWS INTERFACE — Governance Integration
    // ═══════════════════════════════════════════════════════════════════════════════════════════════
    
    /// Memory governance law identifiers
    public let MEMORY_LAWS : [Text] = [
        "L-80",  // LAW_OF_MEMORY_HIERARCHY
        "L-81",  // LAW_OF_WORKING_MEMORY_CAPACITY
        "L-82",  // LAW_OF_CONSOLIDATION
        "L-83",  // LAW_OF_HIPPOCAMPAL_REPLAY
        "L-84",  // LAW_OF_PROCEDURAL_CHUNKING
        "L-85",  // LAW_OF_HABIT_FORMATION
        "L-86",  // LAW_OF_HIVE_CONSENSUS
        "L-87",  // LAW_OF_PHEROMONE_DECAY
        "L-88",  // LAW_OF_ATTENTION_GATING
        "L-89",  // LAW_OF_MEMORY_BINDING
        "L-90",  // LAW_OF_PATTERN_COMPLETION
        "L-91",  // LAW_OF_NEURAL_FREQUENCY
        "L-92",  // LAW_OF_SPATIAL_ENCODING
        "L-93",  // LAW_OF_TEMPORAL_ENCODING
        "L-94",  // LAW_OF_REWARD_PREDICTION
        "L-95",  // LAW_OF_DISTRIBUTED_MEMORY
    ];
    
    /// Check if operation complies with memory laws
    public func checkLawCompliance(
        lawId: Text,
        context: [(Text, Text)]
    ) : Bool {
        // Law enforcement logic would go here
        // This is a simplified version
        switch (lawId) {
            case "L-80" { true };  // Always allow hierarchy operations
            case "L-81" { true };  // Capacity checked elsewhere
            case "L-86" { true };  // Consensus checked in hive operations
            case _ { true };
        }
    };
}
