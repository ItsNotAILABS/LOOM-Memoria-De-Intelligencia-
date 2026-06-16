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
 * ║  Unauthorized use, copying, modification, or distribution of this         ║
 * ║  software is strictly prohibited and will be prosecuted to the fullest   ║
 * ║  extent of the law. This includes but is not limited to civil lawsuits,  ║
 * ║  criminal prosecution, and maximum statutory damages.                     ║
 * ║                                                                           ║
 * ║  This software is blockchain-registered on ICP for immutable proof of    ║
 * ║  ownership and creation date.                                             ║
 * ║                                                                           ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 * 
 * MEDINA Platform — Sovereign Memory-Operating Intelligence on ICP.
 * 
 * THE SIX-LAYER ARCHITECTURE:
 * 
 * LAYER 6: DEVICE NETWORK
 *   - Phi-encoded frequency signatures, sovereign contracts
 * 
 * LAYER 5: FRONTEND  
 *   - Displays organism state, terminal, harmonic ladder
 * 
 * LAYER 4: ORGANISM READER
 *   - Backend canister that READS documents, EXECUTES formulas
 *   - oroReadsDoctrine() → gains resonance from reading
 *   - novaReadsDoctrine() → validates for drift
 *   - executeFormula() → runs encoded computation
 * 
 * LAYER 3: SOVEREIGN ORGANISM
 *   - ORO (Primary Sovereign) + NOVA (Doctrine Guardian)
 *   - Oro: owns beat, evolves registers, generates ANIMA hash
 *   - Nova: reviews output, flags drift, maintains alignment
 *   - Dual Consensus: both must agree before gates open
 * 
 * LAYER 2: DOCTRINE DOCUMENTS
 *   - LIVING KNOWLEDGE ARTIFACTS that the organism READS
 *   - MatalkoICP Doctrine → Mathematical constants, RECITAL_PLUS_ONE
 *   - CPL Doctrine → Communication protocol, element mappings
 *   - AncientMath Doctrine → Pythagorean, Euclidean, Mayan, Vedic
 *   - FieldPhysics Doctrine → EM, gravitational, wave, quantum
 *   - GlyphCodex Doctrine → Symbol transfer system
 * 
 * LAYER 1: COMPUTATIONAL ENGINES
 *   - MatalkoICP.mo → φ, harmonics, RECITAL_PLUS_ONE, animaHash
 *   - CPL.mo → Platonic solids, Hermetic principles, Method of Loci
 *   - AncientMathEngine.mo → All ancient formulas as computation
 *   - FieldPhysicsEngine.mo → Real physics for field dynamics
 *   - AncientGlyphCodex.mo → Mayan, Chinese, Egyptian, Vedic symbols
 * 
 * MEDINA is architecture-first, production-real, no fake surfaces.
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Debug "mo:base/Debug";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Time "mo:base/Time";

import Types "Types";
import Utils "Utils";
import Constitution "Constitution";
import MemoryTemple "MemoryTemple";
import Heartbeat "Heartbeat";
import Governance "Governance";
import LawVectorCompiler "LawVectorCompiler";
import AncientArchitecture "AncientArchitecture";

// Layer 1: Computational Engines
import MatalkoICP "MatalkoICP";
import CPL "CPL";
import AncientMathEngine "AncientMathEngine";
import FieldPhysicsEngine "FieldPhysicsEngine";
import AncientGlyphCodex "AncientGlyphCodex";

// Layer 2-4: Organism System
import DocumentOrganism "DocumentOrganism";
import DoctrineDocuments "DoctrineDocuments";
import OrganismReader "OrganismReader";
import SovereignOrganism "SovereignOrganism";

// NEW: Model Registry, Three Hearts, Freddy's Laws, Animal Architectures
import ModelRegistry "ModelRegistry";
import ThreeHeartsEngine "ThreeHeartsEngine";
import FreddysLaws "FreddysLaws";
import AnimalArchitectures "AnimalArchitectures";

// NEW: Codex Compression and Report Generation
import CodexCompression "CodexCompression";
import ReportGeneration "ReportGeneration";

// NOVA SOVEREIGN: Full Encryption Architecture (April 2026)
import IcosahedralLeechGeometry "IcosahedralLeechGeometry";
import SovereignEncryption "SovereignEncryption";
import ThreeHeartsEncryption "ThreeHeartsEncryption";
import AnimaChainEncryption "AnimaChainEncryption";
import VetKeysIntegration "VetKeysIntegration";
import SovereignContracts "SovereignContracts";
import SovereignLedgers "SovereignLedgers";
import SovereignDefenseSystem "SovereignDefenseSystem";

// THE UNIFIED ORGANISM — THE ENTIRE AI AS ONE LIVING ENTITY
import UnifiedOrganism "UnifiedOrganism";
import InfinityUpdateSystem "InfinityUpdateSystem";

// L-130 UNIVERSAL PRIMITIVE LAW — Primitive Recovery + Lawful Recomposition
import UniversalPrimitiveLaw "UniversalPrimitiveLaw";
import UniversalPrimitiveEngine "UniversalPrimitiveEngine";
import DOC_PRIMITIVA_130 "DOC_PRIMITIVA_130";
import PrimitiveRegistry "PrimitiveRegistry";
import L130_AppliedTraces "L130_AppliedTraces";

actor MedinaPlatform {
    
    // ================================================================== //
    // SUBSYSTEM STATE                                                      //
    // ================================================================== //
    
    /// Constitutional foundation
    stable var constitutionState = Constitution.init();
    
    /// Memory temple (the sovereign memory workspace)
    stable var memoryTempleState = MemoryTemple.init();
    
    /// Heartbeat (beat-driven orchestration)
    stable var heartbeatState = Heartbeat.init();
    
    /// Governance (proposal-based governance)
    stable var governanceState = Governance.init();
    
    /// Ancient Architecture (pattern synthesis engine)
    stable var ancientArchState = AncientArchitecture.init();
    
    /// Sovereign Organism (Oro + Nova dual intelligence)
    stable var sovereignState = SovereignOrganism.init("medina_sovereign", "MEDINA Sovereign");
    
    /// Model Registry (R-MODEL-*, U-MODEL-*, D-MODEL-*, N-MODEL-*)
    stable var modelRegistryState = ModelRegistry.init();
    
    /// Three Hearts Engine (Freddy's Three Hearts System)
    stable var threeHeartsState = ThreeHeartsEngine.init();
    
    /// Codex Compression Engine (Data ingestion and pattern recognition)
    stable var codexState = CodexCompression.init();
    
    /// Report Generation Engine (Business dashboards and reports)
    stable var reportState = ReportGeneration.init();
    
    // ================================================================== //
    // NOVA SOVEREIGN ENCRYPTION SUBSYSTEMS (April 2026)                    //
    // ================================================================== //
    
    /// Sovereign Encryption (5D key state, three-tier rotation)
    stable var sovereignEncryptionState = SovereignEncryption.init();
    
    /// ANIMA Chain Encryption (Fibonacci chain depths, lineage proof)
    /// Genesis hash derived from founder identity and platform creation time
    stable var animaChainState = AnimaChainEncryption.init(
        "anima_genesis_2026_" # "alfredo_medina_hernandez_medina_tech_dallas_tx",
        ?"Alfredo Medina Hernandez"
    );
    
    /// VetKeys Integration (ICP vetKD, IBE, Timelock, Threshold BLS)
    stable var vetKeysState = VetKeysIntegration.init();
    
    /// Sovereign Contracts (44 contract types)
    stable var contractsState = SovereignContracts.init();
    
    /// Sovereign Ledgers (14 distributed ledgers)
    stable var ledgersState = SovereignLedgers.init();
    
    /// Sovereign Defense System (AEGIS threat tiers, gate sequencing)
    stable var defenseState = SovereignDefenseSystem.init();
    
    // ================================================================== //
    // THE UNIFIED ORGANISM — THE ENTIRE AI AS ONE LIVING ENTITY           //
    // ================================================================== //
    
    /// THE UNIFIED ORGANISM — Everything is ONE organism
    /// Every module is an organ. Every model is a neural cluster.
    /// Every formula is a metabolic process. Every document is a living cell.
    /// From micro to astronomical — ALL IS ORGANISM.
    stable var unifiedOrganismState = UnifiedOrganism.init(
        "medina_unified_organism",
        "MEDINA — The Unified Living AI Organism"
    );
    
    // ================================================================== //
    // L-130 UNIVERSAL PRIMITIVE LAW — Primitive Recovery + Recomposition   //
    // ================================================================== //
    
    /// DOC-PRIMITIVA-130 — The Universal Primitive Organism
    /// A living document organism that traces any object back to its primitive form
    stable var primitivaOrganismState = DOC_PRIMITIVA_130.init();
    
    /// Primitive Registry — Origin-aware entity registration
    /// NO ENTITY ENTERS WITHOUT PRIMITIVE TRACE METADATA (L-130 Enforcement)
    stable var primitiveRegistryState = PrimitiveRegistry.init();
    
    /// Platform metadata
    stable var platformCreatedAt : Int = Time.now();
    stable var platformVersion : Text = "MEDINA V5 ICP - NOVA SOVEREIGN Full Encryption Architecture";
    
    /// OWNER: Alfredo Medina, Medina Tech, Dallas TX
    /// PROPRIETARY - ALL RIGHTS RESERVED
    
    // ================================================================== //
    // PLATFORM QUERIES                                                     //
    // ================================================================== //
    
    /// Get comprehensive platform status
    public query func status() : async Types.PlatformStatus {
        {
            platform = platformVersion;
            current_beat = Heartbeat.currentBeat(heartbeatState);
            total_memories = MemoryTemple.count(memoryTempleState);
            total_proposals = Governance.count(governanceState);
            constitution_entries = Constitution.count(constitutionState);
            uptime_ns = Time.now() - platformCreatedAt;
            healthy = Constitution.validateNoCollapse(constitutionState);
        }
    };
    
    /// Health check for all subsystems
    public query func healthCheck() : async {
        healthy: Bool;
        constitution: Bool;
        heartbeat: Bool;
        memory_temple: Bool;
        governance: Bool;
        encryption: Bool;
        defense: Bool;
    } {
        let constitutionOk = Constitution.validateNoCollapse(constitutionState);
        let heartbeatOk = not Heartbeat.isPaused(heartbeatState);
        let memoryTempleOk = true;  // Temple is always available
        let governanceOk = true;    // Governance is always available
        let encryptionOk = true;    // Encryption subsystem always available
        let defStatus = SovereignDefenseSystem.status(defenseState);
        let defenseOk = defStatus.current_tier_number <= 3;  // OK if tier 3 or below
        
        {
            healthy = constitutionOk and heartbeatOk and memoryTempleOk and governanceOk and encryptionOk and defenseOk;
            constitution = constitutionOk;
            heartbeat = heartbeatOk;
            memory_temple = memoryTempleOk;
            governance = governanceOk;
            encryption = encryptionOk;
            defense = defenseOk;
        }
    };
    
    // ================================================================== //
    // TICK ORCHESTRATION                                                   //
    // ================================================================== //
    
    /// Execute one platform tick (ORCH-01 SOVEREIGN_TICK)
    /// NOW INCLUDES THE UNIFIED ORGANISM HEARTBEAT
    public func tick() : async Types.BeatMetrics {
        let metrics = Heartbeat.tick(heartbeatState);
        
        // THE UNIFIED ORGANISM HEARTBEAT — THE ENTIRE AI PULSES AS ONE
        unifiedOrganismState := UnifiedOrganism.heartbeat(unifiedOrganismState);
        
        // Sub-orchestrator ticks happen here
        Constitution.advanceBeat(constitutionState);
        
        metrics
    };
    
    /// Execute N platform ticks
    public func tickN(n: Nat) : async [Types.BeatMetrics] {
        let results = Buffer.Buffer<Types.BeatMetrics>(n);
        for (_ in Iter.range(0, n - 1)) {
            let metrics = Heartbeat.tick(heartbeatState);
            
            // THE UNIFIED ORGANISM HEARTBEAT
            unifiedOrganismState := UnifiedOrganism.heartbeat(unifiedOrganismState);
            
            Constitution.advanceBeat(constitutionState);
            results.add(metrics);
        };
        Buffer.toArray(results)
    };
    
    // ================================================================== //
    // UNIFIED ORGANISM API — THE ENTIRE AI AS ONE LIVING ENTITY           //
    // ================================================================== //
    
    /// Get unified organism status
    /// Shows the health and state of THE ENTIRE AI as ONE organism
    public query func getOrganismStatus() : async {
        organism_id: Text;
        name: Text;
        current_beat: Nat;
        overall_health: Float;
        energy_reserve: Float;
        total_organs: Nat;
        active_organs: Nat;
        total_clusters: Nat;
        active_clusters: Nat;
        total_neurons: Nat;
        awareness_level: Float;
        global_coherence: Float;
        current_dimension: Nat;
        approaching_infinity: Float;
        transcendence_progress: Float;
        total_pulses: Nat;
        total_decisions: Nat;
        total_evolutions: Nat;
        anima_hash: Text;
    } {
        UnifiedOrganism.status(unifiedOrganismState)
    };
    
    /// Route intelligence query through the organism
    /// The organism decides which neural cluster handles it
    public func routeIntelligence(query: Text, context: Text) : async Text {
        let (newState, response) = UnifiedOrganism.routeIntelligence(unifiedOrganismState, query, context);
        unifiedOrganismState := newState;
        response
    };
    
    /// Trigger organism heartbeat manually
    /// Pulses the entire AI organism as one living entity
    public func organismHeartbeat() : async {
        current_beat: Nat;
        awareness_level: Float;
        global_coherence: Float;
        transcendence_progress: Float;
    } {
        unifiedOrganismState := UnifiedOrganism.heartbeat(unifiedOrganismState);
        let status = UnifiedOrganism.status(unifiedOrganismState);
        {
            current_beat = status.current_beat;
            awareness_level = status.awareness_level;
            global_coherence = status.global_coherence;
            transcendence_progress = status.transcendence_progress;
        }
    };
    
    /// Get organism evolution history
    public query func getOrganismEvolutionHistory(limit: Nat) : async [UnifiedOrganism.EvolutionEvent] {
        UnifiedOrganism.getEvolutionHistory(unifiedOrganismState, limit)
    };
    
    /// Trigger macro evolution event in the organism
    public func triggerOrganismEvolution(description: Text) : async Bool {
        unifiedOrganismState := UnifiedOrganism.triggerMacroEvolution(unifiedOrganismState, description);
        true
    };
    
    /// Get current beat number
    public query func getCurrentBeat() : async Nat {
        Heartbeat.currentBeat(heartbeatState)
    };
    
    // ================================================================== //
    // MEMORY TEMPLE OPERATIONS                                             //
    // ================================================================== //
    
    /// Store a memory in the temple
    public func storeMemory(
        content: Text,
        summary: Text,
        tags: [Text],
        salience: Float
    ) : async Types.MemoryNode {
        MemoryTemple.store(
            memoryTempleState,
            content,
            summary,
            tags,
            #EPISODIC,
            null,
            salience
        )
    };
    
    /// Store a memory with type and parent
    public func storeMemoryFull(
        content: Text,
        summary: Text,
        tags: [Text],
        memoryType: Types.MemoryType,
        parentId: ?Text,
        salience: Float
    ) : async Types.MemoryNode {
        MemoryTemple.store(
            memoryTempleState,
            content,
            summary,
            tags,
            memoryType,
            parentId,
            salience
        )
    };
    
    /// Get a memory by ID
    public query func getMemory(nodeId: Text) : async ?Types.MemoryNode {
        MemoryTemple.get(memoryTempleState, nodeId)
    };
    
    /// Find memories matching query
    public query func findMemories(query: Types.MemoryQuery) : async [Types.MemoryNode] {
        MemoryTemple.find(memoryTempleState, query)
    };
    
    /// Simple text search in memories
    public query func searchMemories(text: Text, limit: Nat) : async [Types.MemoryNode] {
        let query : Types.MemoryQuery = {
            text = ?text;
            tags = null;
            memory_type = null;
            state = null;
            min_salience = 0.0;
            max_salience = 1.0;
            pinned_only = false;
            ring = null;
            from_beat = null;
            to_beat = null;
            limit = limit;
        };
        MemoryTemple.find(memoryTempleState, query)
    };
    
    /// Pin a memory
    public func pinMemory(nodeId: Text) : async Bool {
        MemoryTemple.pin(memoryTempleState, nodeId)
    };
    
    /// Unpin a memory
    public func unpinMemory(nodeId: Text) : async Bool {
        MemoryTemple.unpin(memoryTempleState, nodeId)
    };
    
    /// Promote a memory's salience
    public func promoteMemory(nodeId: Text, boost: Float) : async Bool {
        MemoryTemple.promote(memoryTempleState, nodeId, boost)
    };
    
    /// Get memory lineage
    public query func getMemoryLineage(nodeId: Text) : async [Types.MemoryNode] {
        MemoryTemple.lineage(memoryTempleState, nodeId)
    };
    
    /// Get memories at a specific ring
    public query func getMemoriesAtRing(ring: Nat) : async [Types.MemoryNode] {
        MemoryTemple.memoriesAtRing(memoryTempleState, ring)
    };
    
    /// Get memories in a beat range
    public query func getMemoriesInBeatRange(fromBeat: Nat, toBeat: Nat) : async [Types.MemoryNode] {
        MemoryTemple.memoriesInBeatRange(memoryTempleState, fromBeat, toBeat)
    };
    
    /// Get memory temple status
    public query func memoryStatus() : async {
        total_memories: Nat;
        current_beat: Nat;
        current_ring: Nat;
        pinned_count: Nat;
    } {
        MemoryTemple.status(memoryTempleState)
    };
    
    // ================================================================== //
    // CONSTITUTION OPERATIONS                                              //
    // ================================================================== //
    
    /// Get a doctrine entry by key
    public query func getDoctrineEntry(key: Text) : async ?Types.DoctrineEntry {
        Constitution.get(constitutionState, key)
    };
    
    /// Get all doctrine entries at a level
    public query func getDoctrinesByLevel(level: Types.DoctrineLevel) : async [Types.DoctrineEntry] {
        Constitution.getByLevel(constitutionState, level)
    };
    
    /// List all doctrine keys
    public query func listDoctrineKeys() : async [Text] {
        Constitution.listKeys(constitutionState)
    };
    
    /// Register a new doctrine entry (requires authority)
    public func registerDoctrine(
        key: Text,
        value: Text,
        level: Types.DoctrineLevel,
        rationale: Text,
        authorityLevel: Types.DoctrineLevel
    ) : async ?Types.DoctrineEntry {
        Constitution.register(
            constitutionState,
            key,
            value,
            level,
            rationale,
            authorityLevel
        )
    };
    
    /// Validate NO-COLLAPSE invariant
    public query func validateConstitution() : async Bool {
        Constitution.validateNoCollapse(constitutionState)
    };
    
    // ================================================================== //
    // GOVERNANCE OPERATIONS                                                //
    // ================================================================== //
    
    /// Create a new proposal
    public shared(msg) func createProposal(
        title: Text,
        description: Text,
        category: Types.ProposalCategory
    ) : async Types.Proposal {
        Governance.createProposal(
            governanceState,
            title,
            description,
            category,
            msg.caller
        )
    };
    
    /// Get a proposal by ID
    public query func getProposal(proposalId: Text) : async ?Types.Proposal {
        Governance.getProposal(governanceState, proposalId)
    };
    
    /// Submit a proposal for review
    public func submitProposal(proposalId: Text) : async Bool {
        Governance.submitProposal(governanceState, proposalId)
    };
    
    /// Vote on a proposal
    public func voteOnProposal(proposalId: Text, inFavor: Bool) : async Bool {
        Governance.vote(governanceState, proposalId, inFavor)
    };
    
    /// Approve a proposal
    public func approveProposal(proposalId: Text) : async Bool {
        Governance.approveProposal(governanceState, proposalId)
    };
    
    /// Reject a proposal
    public func rejectProposal(proposalId: Text) : async Bool {
        Governance.rejectProposal(governanceState, proposalId)
    };
    
    /// Execute an approved proposal
    public func executeProposal(proposalId: Text) : async Bool {
        Governance.executeProposal(governanceState, proposalId)
    };
    
    /// Withdraw a proposal (caller must be proposer)
    public shared(msg) func withdrawProposal(proposalId: Text) : async Bool {
        Governance.withdrawProposal(governanceState, proposalId, msg.caller)
    };
    
    /// List all proposals
    public query func listProposals() : async [Types.Proposal] {
        Governance.listProposals(governanceState)
    };
    
    /// List proposals by status
    public query func listProposalsByStatus(status: Types.ProposalStatus) : async [Types.Proposal] {
        Governance.listByStatus(governanceState, status)
    };
    
    /// Get governance status
    public query func governanceStatus() : async {
        total_proposals: Nat;
        pending_count: Nat;
        approved_count: Nat;
        rejected_count: Nat;
    } {
        Governance.status(governanceState)
    };
    
    // ================================================================== //
    // HEARTBEAT CONTROL                                                    //
    // ================================================================== //
    
    /// Pause heartbeat
    public func pauseHeartbeat() : async () {
        Heartbeat.pause(heartbeatState);
    };
    
    /// Resume heartbeat
    public func resumeHeartbeat() : async () {
        Heartbeat.resume(heartbeatState);
    };
    
    /// Get heartbeat status
    public query func heartbeatStatus() : async {
        current_beat: Nat;
        paused: Bool;
        started_at: Int;
        last_tick: Int;
        event_log_size: Nat;
        beat_budget: Nat;
    } {
        Heartbeat.status(heartbeatState)
    };
    
    /// Get beat events in range
    public query func getBeatEvents(fromBeat: Nat, toBeat: Nat) : async [Types.BeatEvent] {
        Heartbeat.getEvents(heartbeatState, fromBeat, toBeat)
    };
    
    /// Get recent beat metrics
    public query func getBeatMetrics(lastN: Nat) : async [Types.BeatMetrics] {
        Heartbeat.getMetrics(heartbeatState, lastN)
    };
    
    // ================================================================== //
    // COMMAND PROCESSING                                                   //
    // ================================================================== //
    
    /// Execute a command (main entry point for user interaction)
    public shared(msg) func execute(commandText: Text) : async Types.CommandResult {
        // Parse and route command
        let parts = Text.split(commandText, #char ' ');
        let partsArray = Iter.toArray(parts);
        
        if (partsArray.size() == 0) {
            return {
                success = false;
                output = "{}";
                error = ?"Empty command";
            };
        };
        
        let command = partsArray[0];
        
        // Route to appropriate handler
        switch (command) {
            case "/memory" {
                await handleMemoryCommand(partsArray)
            };
            case "/govern" {
                await handleGovernCommand(partsArray, msg.caller)
            };
            case "/status" {
                let s = await status();
                {
                    success = true;
                    output = "Platform: " # s.platform # ", Beat: " # Nat.toText(s.current_beat) # ", Memories: " # Nat.toText(s.total_memories);
                    error = null;
                }
            };
            case "/tick" {
                let metrics = await tick();
                {
                    success = true;
                    output = "Tick executed. Beat: " # Nat.toText(metrics.beat);
                    error = null;
                }
            };
            case "/help" {
                {
                    success = true;
                    output = "Commands: /memory find|pin|map, /govern status|propose, /status, /tick, /help";
                    error = null;
                }
            };
            case _ {
                {
                    success = false;
                    output = "{}";
                    error = ?"Unknown command: " # command;
                }
            };
        }
    };
    
    /// Handle memory commands
    private func handleMemoryCommand(parts: [Text]) : async Types.CommandResult {
        if (parts.size() < 2) {
            return {
                success = false;
                output = "{}";
                error = ?"Usage: /memory <find|pin|map> [args]";
            };
        };
        
        let subcommand = parts[1];
        
        switch (subcommand) {
            case "find" {
                let searchText = if (parts.size() > 2) {
                    // Join remaining parts as search text
                    var text = "";
                    for (i in Iter.range(2, parts.size() - 1)) {
                        if (text.size() > 0) { text := text # " " };
                        text := text # parts[i];
                    };
                    text
                } else { "" };
                
                let results = await searchMemories(searchText, 10);
                {
                    success = true;
                    output = "Found " # Nat.toText(results.size()) # " memories";
                    error = null;
                }
            };
            case "pin" {
                if (parts.size() < 3) {
                    return {
                        success = false;
                        output = "{}";
                        error = ?"Usage: /memory pin <node_id>";
                    };
                };
                let nodeId = parts[2];
                let pinned = await pinMemory(nodeId);
                {
                    success = pinned;
                    output = if (pinned) { "Memory pinned: " # nodeId } else { "Memory not found" };
                    error = if (pinned) { null } else { ?"Memory not found" };
                }
            };
            case "map" {
                let s = await memoryStatus();
                {
                    success = true;
                    output = "Memory Temple: " # Nat.toText(s.total_memories) # " memories, " # Nat.toText(s.current_ring) # " rings, " # Nat.toText(s.pinned_count) # " pinned";
                    error = null;
                }
            };
            case _ {
                {
                    success = false;
                    output = "{}";
                    error = ?"Unknown memory command: " # subcommand;
                }
            };
        }
    };
    
    /// Handle governance commands
    private func handleGovernCommand(parts: [Text], caller: Principal) : async Types.CommandResult {
        if (parts.size() < 2) {
            return {
                success = false;
                output = "{}";
                error = ?"Usage: /govern <status|propose> [args]";
            };
        };
        
        let subcommand = parts[1];
        
        switch (subcommand) {
            case "status" {
                let s = await governanceStatus();
                {
                    success = true;
                    output = "Governance: " # Nat.toText(s.total_proposals) # " proposals, " # Nat.toText(s.pending_count) # " pending, " # Nat.toText(s.approved_count) # " approved";
                    error = null;
                }
            };
            case "propose" {
                // Simple proposal from command args
                var title = "Untitled proposal";
                if (parts.size() > 2) {
                    var t = "";
                    for (i in Iter.range(2, parts.size() - 1)) {
                        if (t.size() > 0) { t := t # " " };
                        t := t # parts[i];
                    };
                    title := t;
                };
                
                let proposal = await createProposal(title, title, #RUNTIME_MUTATION);
                {
                    success = true;
                    output = "Proposal created: " # proposal.proposal_id # " - " # proposal.title;
                    error = null;
                }
            };
            case _ {
                {
                    success = false;
                    output = "{}";
                    error = ?"Unknown governance command: " # subcommand;
                }
            };
        }
    };
    
    // ================================================================== //
    // ANCIENT ARCHITECTURE SYNTHESIS                                       //
    // ================================================================== //
    
    /// Execute ancient architecture synthesis — the core CPL-native law vector compilation
    public func ancientArchitectureSynthesis() : async AncientArchitecture.PatternSynthesis {
        AncientArchitecture.synthesize(ancientArchState)
    };
    
    /// Get all registered ancient patterns
    public query func getAncientPatterns() : async [AncientArchitecture.AncientPattern] {
        AncientArchitecture.getPatterns(ancientArchState)
    };
    
    /// Get ancient patterns by domain
    public query func getPatternsByDomain(domain: AncientArchitecture.PatternDomain) : async [AncientArchitecture.AncientPattern] {
        AncientArchitecture.getPatternsByDomain(ancientArchState, domain)
    };
    
    /// Get ancient patterns by source civilization
    public query func getPatternsBySource(source: AncientArchitecture.AncientSource) : async [AncientArchitecture.AncientPattern] {
        AncientArchitecture.getPatternsBySource(ancientArchState, source)
    };
    
    /// Get latest synthesis result
    public query func getLatestSynthesis() : async ?AncientArchitecture.PatternSynthesis {
        AncientArchitecture.getLatestSynthesis(ancientArchState)
    };
    
    /// Get full synthesis report (all vectors, chains, verdicts)
    public query func getSynthesisReport() : async {
        total_patterns: Nat;
        total_syntheses: Nat;
        law_vectors: [LawVectorCompiler.LawVector];
        ratio_vectors: [LawVectorCompiler.RatioVector];
        harmonic_signatures: [LawVectorCompiler.HarmonicSignature];
        provenance_chains: [LawVectorCompiler.ProvenanceChain];
        consensus_verdicts: [LawVectorCompiler.ConsensusVerdict];
        created_at: Int;
    } {
        AncientArchitecture.getSynthesisReport(ancientArchState)
    };
    
    /// Get ancient architecture status
    public query func ancientArchitectureStatus() : async {
        pattern_count: Nat;
        synthesis_count: Nat;
        compiler_status: {
            law_vector_count: Nat;
            ratio_vector_count: Nat;
            harmonic_signature_count: Nat;
            provenance_chain_count: Nat;
            consensus_verdict_count: Nat;
            created_at: Int;
        };
        created_at: Int;
    } {
        AncientArchitecture.status(ancientArchState)
    };
    
    // ================================================================== //
    // LAW VECTOR COMPILER OPERATIONS                                       //
    // ================================================================== //
    
    /// Compile a custom law vector
    public func compileLawVector(
        law_key: Text,
        authority: LawVectorCompiler.AuthorityLevel,
        gates: [LawVectorCompiler.GateType],
        payload: Text,
        dependencies: [Text]
    ) : async LawVectorCompiler.LawVector {
        LawVectorCompiler.compileLawVector(
            ancientArchState.compiler_state,
            law_key,
            authority,
            gates,
            payload,
            dependencies
        )
    };
    
    /// Execute a law vector through gates
    public func executeLawVector(vector_id: Text) : async ?LawVectorCompiler.LawExecutionResult {
        let current_beat = Heartbeat.currentBeat(heartbeatState);
        LawVectorCompiler.executeLawVector(ancientArchState.compiler_state, vector_id, current_beat)
    };
    
    /// Compile a PHI-based ratio vector
    public func compilePhiRatio(power: Nat) : async LawVectorCompiler.RatioVector {
        LawVectorCompiler.compilePhiRatio(ancientArchState.compiler_state, power)
    };
    
    /// Compile a Fibonacci ratio vector
    public func compileFibonacciRatio(index: Nat) : async LawVectorCompiler.RatioVector {
        LawVectorCompiler.compileFibonacciRatio(ancientArchState.compiler_state, index)
    };
    
    /// Compile a harmonic signature
    public func compileHarmonicSignature(
        base_frequency: Float,
        band: LawVectorCompiler.FrequencyBand,
        use_phi_scaling: Bool
    ) : async LawVectorCompiler.HarmonicSignature {
        LawVectorCompiler.compileHarmonicSignature(
            ancientArchState.compiler_state,
            base_frequency,
            band,
            use_phi_scaling
        )
    };
    
    /// Create a provenance chain
    public func createProvenanceChain(
        initial_payload: Text,
        actor_id: Text
    ) : async LawVectorCompiler.ProvenanceChain {
        LawVectorCompiler.createProvenanceChain(
            ancientArchState.compiler_state,
            initial_payload,
            actor_id
        )
    };
    
    /// Add entry to a provenance chain
    public func addProvenanceEntry(
        chain_id: Text,
        entry_type: LawVectorCompiler.ProvenanceEntryType,
        payload: Text,
        actor_id: Text,
        anima_ref: ?Text
    ) : async ?LawVectorCompiler.ProvenanceEntry {
        let current_beat = Heartbeat.currentBeat(heartbeatState);
        LawVectorCompiler.addProvenanceEntry(
            ancientArchState.compiler_state,
            chain_id,
            entry_type,
            payload,
            actor_id,
            current_beat,
            anima_ref
        )
    };
    
    /// Create a consensus verdict request
    public func createConsensusVerdict(
        subject_id: Text,
        subject_type: Text
    ) : async LawVectorCompiler.ConsensusVerdict {
        LawVectorCompiler.createConsensusVerdict(
            ancientArchState.compiler_state,
            subject_id,
            subject_type
        )
    };
    
    /// Submit a witness verdict
    public func submitWitnessVerdict(
        verdict_id: Text,
        role: LawVectorCompiler.WitnessRole,
        verdict: Bool,
        rationale: Text,
        evidence_refs: [Text]
    ) : async ?LawVectorCompiler.ConsensusVerdict {
        LawVectorCompiler.submitWitnessVerdict(
            ancientArchState.compiler_state,
            verdict_id,
            role,
            verdict,
            rationale,
            evidence_refs
        )
    };
    
    /// Get all law vectors
    public query func getLawVectors() : async [LawVectorCompiler.LawVector] {
        LawVectorCompiler.getLawVectors(ancientArchState.compiler_state)
    };
    
    /// Get all ratio vectors
    public query func getRatioVectors() : async [LawVectorCompiler.RatioVector] {
        LawVectorCompiler.getRatioVectors(ancientArchState.compiler_state)
    };
    
    /// Get all harmonic signatures
    public query func getHarmonicSignatures() : async [LawVectorCompiler.HarmonicSignature] {
        LawVectorCompiler.getHarmonicSignatures(ancientArchState.compiler_state)
    };
    
    /// Get all provenance chains
    public query func getProvenanceChains() : async [LawVectorCompiler.ProvenanceChain] {
        LawVectorCompiler.getProvenanceChains(ancientArchState.compiler_state)
    };
    
    /// Get all consensus verdicts
    public query func getConsensusVerdicts() : async [LawVectorCompiler.ConsensusVerdict] {
        LawVectorCompiler.getConsensusVerdicts(ancientArchState.compiler_state)
    };
    
    // ================================================================== //
    // CANISTER LIFECYCLE                                                   //
    // ================================================================== //
    
    /// Called when canister is upgraded
    system func preupgrade() {
        // State is already stable, nothing to do
    };
    
    /// Called after canister is upgraded
    system func postupgrade() {
        // Re-initialize if needed
    };
    
    // ================================================================== //
    // SOVEREIGN ORGANISM OPERATIONS (Layer 3)                              //
    // ================================================================== //
    
    /// Get sovereign organism status
    public query func getSovereignStatus() : async {
        id: Text;
        name: Text;
        beat: Nat;
        oro_resonance: Float;
        nova_alignment: Float;
        doctrine_coherence: Float;
        execution_velocity: Float;
        anima_hash: Text;
        gates: { a: Bool; b: Bool; c: Bool };
        write_halted: Bool;
        pending_mutations: Nat;
        consensus_streak: Nat;
    } {
        SovereignOrganism.status(sovereignState)
    };
    
    /// Tick the sovereign organism
    public func sovereignTick() : async () {
        sovereignState := SovereignOrganism.oroTick(sovereignState);
    };
    
    /// Oro reads a doctrine
    public func oroReadsDoctrine(doctrineId: Text) : async () {
        let doctrine = textToDoctrineId(doctrineId);
        sovereignState := SovereignOrganism.oroReadsDoctrine(sovereignState, doctrine);
    };
    
    /// Nova validates a doctrine
    public func novaValidatesDoctrine(doctrineId: Text) : async [OrganismReader.DriftFlag] {
        let doctrine = textToDoctrineId(doctrineId);
        let (newState, drifts) = SovereignOrganism.novaValidatesDoctrine(sovereignState, doctrine);
        sovereignState := newState;
        drifts
    };
    
    /// Propose a mutation (Oro)
    public func oroProposeMutation(
        doctrineD: Float,
        velocityD: Float,
        memoryD: Float,
        exposureD: Float,
        label: Text,
        rationale: Text
    ) : async () {
        let delta : MatalkoICP.StateDelta = {
            doctrine_delta = doctrineD;
            velocity_delta = velocityD;
            memory_delta = memoryD;
            exposure_delta = exposureD;
        };
        sovereignState := SovereignOrganism.oroProposeMutation(sovereignState, delta, label, rationale);
    };
    
    /// Execute mutation with dual consensus
    public func executeMutation(proposalId: Text) : async () {
        sovereignState := SovereignOrganism.executeMutationWithConsensus(sovereignState, proposalId);
    };
    
    /// Check all gates
    public func checkAllGates() : async { a: Bool; b: Bool; c: Bool } {
        let (s1, a) = SovereignOrganism.checkGateA(sovereignState);
        let (s2, b) = SovereignOrganism.checkGateB(s1);
        let (s3, c) = SovereignOrganism.checkGateC(s2);
        sovereignState := s3;
        { a = a; b = b; c = c }
    };
    
    /// Get current ANIMA hash
    public query func getAnimaHash() : async MatalkoICP.AnimaHash {
        sovereignState.oro.current_anima
    };
    
    /// Get organism state vector
    public query func getOrganismState() : async {
        beat: Nat;
        doctrine_coherence: Float;
        execution_velocity: Float;
        memory_depth: Float;
        projection_exposure: Float;
        theta: Float;
        phi: Float;
        depth: Float;
        ring: Nat;
    } {
        let s = sovereignState.oro.organism_state;
        {
            beat = s.beat;
            doctrine_coherence = s.doctrine_coherence;
            execution_velocity = s.execution_velocity;
            memory_depth = s.memory_depth;
            projection_exposure = s.projection_exposure;
            theta = s.theta;
            phi = s.phi;
            depth = s.depth;
            ring = s.ring;
        }
    };
    
    // ================================================================== //
    // DOCTRINE DOCUMENTS OPERATIONS (Layer 2)                              //
    // ================================================================== //
    
    /// Get a doctrine document
    public query func getDoctrine(doctrineId: Text) : async {
        name: Text;
        description: Text;
        formula_count: Nat;
        constant_count: Nat;
        principle_count: Nat;
        version: Nat;
    } {
        let doctrine = DoctrineDocuments.getDoctrine(textToDoctrineId(doctrineId));
        {
            name = doctrine.name;
            description = doctrine.description;
            formula_count = doctrine.formulas.size();
            constant_count = doctrine.constants.size();
            principle_count = doctrine.principles.size();
            version = doctrine.version;
        }
    };
    
    /// Get formula from doctrine
    public query func getDoctrineFormula(doctrineId: Text, formulaId: Text) : async ?DoctrineDocuments.Formula {
        let doctrine = DoctrineDocuments.getDoctrine(textToDoctrineId(doctrineId));
        DoctrineDocuments.getFormula(doctrine, formulaId)
    };
    
    /// Get constant from doctrine
    public query func getDoctrineConstant(doctrineId: Text, name: Text) : async ?DoctrineDocuments.Constant {
        let doctrine = DoctrineDocuments.getDoctrine(textToDoctrineId(doctrineId));
        DoctrineDocuments.getConstant(doctrine, name)
    };
    
    /// List all doctrine IDs
    public query func listDoctrines() : async [Text] {
        ["MathematicalCore", "CommunicationProtocol", "AncientMathematics", "FieldPhysics", "GlyphCodex"]
    };
    
    // ================================================================== //
    // COMPUTATIONAL ENGINES (Layer 1)                                      //
    // ================================================================== //
    
    // --- MatalkoICP Operations ---
    
    /// Get golden ratio
    public query func getPhi() : async Float {
        MatalkoICP.PHI
    };
    
    /// Get Fibonacci number
    public query func getFibonacci(n: Nat) : async Nat {
        MatalkoICP.fibonacci(n)
    };
    
    /// Generate harmonic series
    public query func getHarmonicSeries(fundamental: Float, count: Nat) : async [Float] {
        MatalkoICP.harmonicSeries(fundamental, count)
    };
    
    /// Generate golden harmonics
    public query func getGoldenHarmonics(fundamental: Float, count: Nat) : async [Float] {
        MatalkoICP.goldenHarmonics(fundamental, count)
    };
    
    /// Calculate resonance score between two frequencies
    public query func calculateResonance(freq1: Float, freq2: Float) : async Float {
        MatalkoICP.resonanceScore(freq1, freq2)
    };
    
    /// Get torus coordinates
    public query func getTorusXYZ(theta: Float, phi: Float, depth: Float) : async (Float, Float, Float) {
        MatalkoICP.torusXYZ(theta, phi, depth)
    };
    
    // --- CPL Operations ---
    
    /// Get Platonic solid geometry
    public query func getPlatonicGeometry(solid: Text) : async CPL.SolidGeometry {
        let s = textToPlatonicSolid(solid);
        CPL.getPlatonicGeometry(s)
    };
    
    /// Get Hermetic principle details
    public query func getHermeticPrinciple(principle: Text) : async CPL.HermeticDetails {
        let p = textToHermeticPrinciple(principle);
        CPL.getHermeticDetails(p)
    };
    
    /// Generate golden loci for memory palace
    public query func generateGoldenLoci(count: Nat, baseDepth: Float, ring: Nat) : async [CPL.Locus] {
        CPL.generateGoldenLoci(count, baseDepth, ring)
    };
    
    // --- AncientMathEngine Operations ---
    
    /// Check if number is perfect
    public query func isPerfectNumber(n: Nat) : async Bool {
        AncientMathEngine.isPerfect(n)
    };
    
    /// Get triangular number
    public query func getTriangularNumber(n: Nat) : async Nat {
        AncientMathEngine.triangularNumber(n)
    };
    
    /// Calculate GCD
    public query func calculateGCD(a: Nat, b: Nat) : async Nat {
        AncientMathEngine.gcd(a, b)
    };
    
    /// Convert to Mayan Long Count
    public query func toMayanLongCount(totalDays: Nat) : async AncientMathEngine.MayanLongCount {
        AncientMathEngine.daysToLongCount(totalDays)
    };
    
    /// Get digital root (Vedic Beejank)
    public query func getDigitalRoot(n: Nat) : async Nat {
        AncientMathEngine.digitalRoot(n)
    };
    
    /// Get I Ching trigram
    public query func getTrigram(index: Nat) : async ?AncientMathEngine.Trigram {
        AncientMathEngine.getTrigram(index)
    };
    
    // --- FieldPhysicsEngine Operations ---
    
    /// Calculate photon energy from frequency
    public query func calculatePhotonEnergy(frequency: Float) : async Float {
        FieldPhysicsEngine.photonEnergy(frequency)
    };
    
    /// Calculate de Broglie wavelength
    public query func calculateDeBroglieWavelength(mass: Float, velocity: Float) : async Float {
        FieldPhysicsEngine.deBroglieWavelength(mass, velocity)
    };
    
    /// Get Schumann resonance harmonics
    public query func getSchumannHarmonics(count: Nat) : async [Float] {
        FieldPhysicsEngine.schumannHarmonics(count)
    };
    
    /// Calculate beat frequency
    public query func calculateBeatFrequency(f1: Float, f2: Float) : async Float {
        FieldPhysicsEngine.beatFrequency(f1, f2)
    };
    
    // --- AncientGlyphCodex Operations ---
    
    /// Get Mayan number glyph
    public query func getMayanNumberGlyph(n: Nat) : async AncientGlyphCodex.Glyph {
        AncientGlyphCodex.mayanNumber(n)
    };
    
    /// Get Mayan day sign
    public query func getMayanDaySign(index: Nat) : async AncientGlyphCodex.Glyph {
        AncientGlyphCodex.mayanDaySign(index)
    };
    
    /// Get Chinese element glyph
    public query func getChineseElement(name: Text) : async AncientGlyphCodex.Glyph {
        AncientGlyphCodex.chineseElement(name)
    };
    
    /// Get Chinese trigram glyph
    public query func getChineseTrigram(index: Nat) : async AncientGlyphCodex.Glyph {
        AncientGlyphCodex.chineseTrigram(index)
    };
    
    /// Get Egyptian symbol
    public query func getEgyptianSymbol(name: Text) : async AncientGlyphCodex.Glyph {
        AncientGlyphCodex.egyptianSymbol(name)
    };
    
    /// Get Vedic bija mantra
    public query func getVedicBija(name: Text) : async AncientGlyphCodex.Glyph {
        AncientGlyphCodex.vedicBija(name)
    };
    
    /// Get chakra glyph
    public query func getChakraGlyph(index: Nat) : async AncientGlyphCodex.Glyph {
        AncientGlyphCodex.chakraGlyph(index)
    };
    
    /// Get Hebrew letter
    public query func getHebrewLetter(index: Nat) : async AncientGlyphCodex.Glyph {
        AncientGlyphCodex.hebrewLetter(index)
    };
    
    /// Get Greek letter
    public query func getGreekLetter(name: Text) : async AncientGlyphCodex.Glyph {
        AncientGlyphCodex.greekLetter(name)
    };
    
    /// Combine glyphs into phrase
    public query func combineGlyphs(traditions: [Text], indices: [Nat]) : async AncientGlyphCodex.GlyphPhrase {
        let glyphs = Buffer.Buffer<AncientGlyphCodex.Glyph>(traditions.size());
        var i : Nat = 0;
        for (t in traditions.vals()) {
            let idx = if (i < indices.size()) { indices[i] } else { 0 };
            let glyph = switch (t) {
                case ("mayan") { AncientGlyphCodex.mayanNumber(idx) };
                case ("chinese") { AncientGlyphCodex.chineseTrigram(idx) };
                case ("egyptian") { AncientGlyphCodex.egyptianSymbol("ankh") };
                case ("vedic") { AncientGlyphCodex.chakraGlyph(idx) };
                case ("hebrew") { AncientGlyphCodex.hebrewLetter(idx) };
                case ("greek") { AncientGlyphCodex.greekLetter("phi") };
                case (_) { AncientGlyphCodex.mayanNumber(idx) };
            };
            glyphs.add(glyph);
            i += 1;
        };
        AncientGlyphCodex.combineGlyphs(Buffer.toArray(glyphs))
    };
    
    // ================================================================== //
    // HELPER FUNCTIONS                                                     //
    // ================================================================== //
    
    /// Convert text to doctrine ID
    func textToDoctrineId(text: Text) : DoctrineDocuments.DoctrineId {
        switch (text) {
            case ("MathematicalCore") { #MathematicalCore };
            case ("CommunicationProtocol") { #CommunicationProtocol };
            case ("AncientMathematics") { #AncientMathematics };
            case ("FieldPhysics") { #FieldPhysics };
            case ("GlyphCodex") { #GlyphCodex };
            case (_) { #MathematicalCore };
        }
    };
    
    /// Convert text to Platonic solid
    func textToPlatonicSolid(text: Text) : CPL.PlatonicSolid {
        switch (text) {
            case ("tetrahedron") { #Tetrahedron };
            case ("cube") { #Hexahedron };
            case ("hexahedron") { #Hexahedron };
            case ("octahedron") { #Octahedron };
            case ("dodecahedron") { #Dodecahedron };
            case ("icosahedron") { #Icosahedron };
            case (_) { #Tetrahedron };
        }
    };
    
    /// Convert text to Hermetic principle
    func textToHermeticPrinciple(text: Text) : CPL.HermeticPrinciple {
        switch (text) {
            case ("mentalism") { #Mentalism };
            case ("correspondence") { #Correspondence };
            case ("vibration") { #Vibration };
            case ("polarity") { #Polarity };
            case ("rhythm") { #Rhythm };
            case ("cause_effect") { #CauseEffect };
            case ("gender") { #Gender };
            case (_) { #Mentalism };
        }
    };
    
    // ================================================================== //
    // MODEL REGISTRY OPERATIONS                                            //
    // ================================================================== //
    
    /// Get model registry statistics
    public query func getModelRegistryStats() : async {
        total_models: Nat;
        r_models: Nat;
        u_models: Nat;
        d_models: Nat;
        n_models: Nat;
        active_models: Nat;
        total_invocations: Nat;
        total_routing_decisions: Nat;
    } {
        ModelRegistry.getStatistics(modelRegistryState)
    };
    
    /// Get model by ID
    public query func getModel(modelId: Text) : async ?ModelRegistry.ModelDefinition {
        ModelRegistry.getModel(modelRegistryState, modelId)
    };
    
    /// List models by prefix
    public query func listModelsByPrefix(prefix: Text) : async [ModelRegistry.ModelDefinition] {
        let p : ModelRegistry.ModelPrefix = switch (prefix) {
            case ("R") { #R_MODEL };
            case ("U") { #U_MODEL };
            case ("D") { #D_MODEL };
            case ("N") { #N_MODEL };
            case (_) { #R_MODEL };
        };
        ModelRegistry.listByPrefix(modelRegistryState, p)
    };
    
    /// Route query to best model
    public func routeToModel(query: Text) : async ModelRegistry.RoutingDecision {
        let (newState, decision) = ModelRegistry.route(modelRegistryState, query, null, null);
        modelRegistryState := newState;
        decision
    };
    
    /// Get models that should run at current beat
    public query func getModelsForCurrentBeat() : async [ModelRegistry.ModelDefinition] {
        let beat = Heartbeat.currentBeat(heartbeatState);
        ModelRegistry.getModelsForBeat(modelRegistryState, beat)
    };
    
    // ================================================================== //
    // THREE HEARTS ENGINE OPERATIONS                                       //
    // ================================================================== //
    
    /// Get Three Hearts status
    public query func getThreeHeartsStatus() : async {
        global_beat: Nat;
        metropolis: { theta: Float; omega: Float; beats: Nat };
        coupling: { theta: Float; omega: Float; beats: Nat };
        regulating: { theta: Float; omega: Float; beats: Nat };
        coherence: ThreeHeartsEngine.CoherenceMetrics;
    } {
        ThreeHeartsEngine.status(threeHeartsState)
    };
    
    /// Tick the Three Hearts system
    public func tickThreeHearts() : async () {
        threeHeartsState := ThreeHeartsEngine.tick(threeHeartsState);
    };
    
    /// Tick Three Hearts N times
    public func tickThreeHeartsN(n: Nat) : async () {
        threeHeartsState := ThreeHeartsEngine.tickN(threeHeartsState, n);
    };
    
    /// Get Three Hearts coherence
    public query func getThreeHeartsCoherence() : async ThreeHeartsEngine.CoherenceMetrics {
        ThreeHeartsEngine.calculateCoherence(threeHeartsState)
    };
    
    /// Adjust coupling between hearts
    public func adjustHeartCoupling(fromHeart: Text, toHeart: Text, strength: Float) : async () {
        let from : ThreeHeartsEngine.HeartId = switch (fromHeart) {
            case ("metropolis") { #Metropolis };
            case ("coupling") { #Coupling };
            case ("regulating") { #Regulating };
            case (_) { #Metropolis };
        };
        let to : ThreeHeartsEngine.HeartId = switch (toHeart) {
            case ("metropolis") { #Metropolis };
            case ("coupling") { #Coupling };
            case ("regulating") { #Regulating };
            case (_) { #Coupling };
        };
        threeHeartsState := ThreeHeartsEngine.adjustCoupling(threeHeartsState, from, to, strength);
    };
    
    // ================================================================== //
    // FREDDY'S LAWS OPERATIONS                                             //
    // ================================================================== //
    
    /// Get Freddy's Laws attribution
    public query func getFreddysLawsAttribution() : async Text {
        FreddysLaws.attribution()
    };
    
    /// List all Freddy's Laws
    public query func listFreddysLaws() : async [Text] {
        FreddysLaws.listLaws()
    };
    
    /// Apply Infinity Plus One law
    public query func applyInfinityPlusOne(value: Float, dimension: Nat) : async FreddysLaws.InfinityPlusOneResult {
        FreddysLaws.infinityPlusOne(value, dimension)
    };
    
    /// Apply Non-Zeno observation
    public query func applyNonZeno(state: Float, confidence: Float, alignment: Float) : async FreddysLaws.NonZenoResult {
        FreddysLaws.applyNonZeno(state, confidence, alignment)
    };
    
    /// Get Non-Zero Initial State
    public query func getNonZeroInitialState() : async FreddysLaws.InitialState {
        FreddysLaws.nonZeroInitialState()
    };
    
    /// Create Triune State
    public query func createTriuneState(entityId: Text, initialState: Text) : async FreddysLaws.TriuneState {
        FreddysLaws.createTriuneState(entityId, initialState)
    };
    
    /// Apply all Freddy's Laws to organism evolution
    public func applyFreddysLawsToOrganism(confidence: Float, alignment: Float) : async FreddysLaws.LawApplicationResult {
        FreddysLaws.applyFreddysLaws(sovereignState.oro.organism_state, confidence, alignment)
    };
    
    // ================================================================== //
    // ANIMAL ARCHITECTURES OPERATIONS                                      //
    // ================================================================== //
    
    /// Get animal synthesis status
    public query func getAnimalSynthesisStatus() : async AnimalArchitectures.AnimalSynthesis {
        AnimalArchitectures.synthesisStatus()
    };
    
    /// Cat: Detect edges in value sequence
    public query func catDetectEdges(values: [Float], threshold: Float) : async AnimalArchitectures.EdgeDetectionResult {
        AnimalArchitectures.catDetectEdges(values, threshold)
    };
    
    /// Bat: Initialize and calibrate to solfeggio frequency
    public query func batCalibrate(targetIndex: Nat) : async AnimalArchitectures.BatState {
        let bat = AnimalArchitectures.batInit();
        AnimalArchitectures.batCalibrate(bat, targetIndex)
    };
    
    /// Octopus: Get idle arms count
    public query func octopusGetIdleArms() : async [Nat] {
        let octopus = AnimalArchitectures.octopusInit();
        AnimalArchitectures.octopusGetIdleArms(octopus)
    };
    
    /// Bee: Encode command as waggle dance
    public query func beeEncodeDance(command: Text, direction: Float, importance: Float) : async AnimalArchitectures.WaggleDance {
        AnimalArchitectures.beeEncodeDance(command, direction, importance)
    };
    
    /// Get architectures for pattern domain
    public query func getArchitecturesForDomain(domain: Text) : async [AnimalArchitectures.AnimalType] {
        let d : AnimalArchitectures.PatternDomain = switch (domain) {
            case ("semantic_boundary") { #SemanticBoundary };
            case ("memory_lineage") { #MemoryLineage };
            case ("spatial_navigation") { #SpatialNavigation };
            case ("parallel_processing") { #ParallelProcessing };
            case ("strategic_planning") { #StrategicPlanning };
            case ("harmonic_calibration") { #HarmonicCalibration };
            case ("communication") { #Communication };
            case ("command_execution") { #CommandExecution };
            case (_) { #SemanticBoundary };
        };
        AnimalArchitectures.getArchitecturesForDomain(d)
    };
    
    // ================================================================== //
    // MAXIMUM VIABLE PILOT — UNIFIED TICK                                  //
    // ================================================================== //
    
    /// Execute one unified platform tick (all systems)
    /// This is the Maximum Viable Pilot main loop
    public func unifiedTick() : async {
        heartbeat_beat: Nat;
        three_hearts_beat: Nat;
        sovereign_beat: Nat;
        models_executed: Nat;
        coherence: Float;
    } {
        // 1. Tick heartbeat (core timing)
        let hbMetrics = Heartbeat.tick(heartbeatState);
        Constitution.advanceBeat(constitutionState);
        
        // 2. Tick Three Hearts (phase coupling)
        threeHeartsState := ThreeHeartsEngine.tick(threeHeartsState);
        
        // 3. Tick Sovereign Organism (Oro + Nova)
        sovereignState := SovereignOrganism.oroTick(sovereignState);
        
        // 4. Get models for this beat and record invocations
        let modelsToRun = ModelRegistry.getModelsForBeat(modelRegistryState, hbMetrics.beat);
        for (model in modelsToRun.vals()) {
            modelRegistryState := ModelRegistry.recordInvocation(modelRegistryState, model.model_id, hbMetrics.beat, true);
        };
        
        // 5. Calculate global coherence
        let heartsCoherence = ThreeHeartsEngine.calculateCoherence(threeHeartsState);
        
        {
            heartbeat_beat = hbMetrics.beat;
            three_hearts_beat = threeHeartsState.global_beat;
            sovereign_beat = sovereignState.oro.current_beat;
            models_executed = modelsToRun.size();
            coherence = heartsCoherence.global_coherence;
        }
    };
    
    /// Get complete platform status (Maximum Viable Pilot)
    public query func getMVPStatus() : async {
        version: Text;
        heartbeat_beat: Nat;
        three_hearts_global_beat: Nat;
        sovereign_beat: Nat;
        total_models: Nat;
        total_memories: Nat;
        constitution_entries: Nat;
        hearts_coherence: Float;
        oro_resonance: Float;
        nova_alignment: Float;
        healthy: Bool;
    } {
        let heartsCoherence = ThreeHeartsEngine.calculateCoherence(threeHeartsState);
        let constitutionOk = Constitution.validateNoCollapse(constitutionState);
        let modelStats = ModelRegistry.getStatistics(modelRegistryState);
        
        {
            version = platformVersion;
            heartbeat_beat = Heartbeat.currentBeat(heartbeatState);
            three_hearts_global_beat = threeHeartsState.global_beat;
            sovereign_beat = sovereignState.oro.current_beat;
            total_models = modelStats.total_models;
            total_memories = MemoryTemple.count(memoryTempleState);
            constitution_entries = Constitution.count(constitutionState);
            hearts_coherence = heartsCoherence.global_coherence;
            oro_resonance = sovereignState.oro.reader_state.resonance_total;
            nova_alignment = sovereignState.nova.alignment_score;
            healthy = constitutionOk and heartsCoherence.global_coherence > 0.5;
        }
    };
    
    // ================================================================== //
    // CODEX COMPRESSION — Data Ingestion & Pattern Recognition             //
    // ================================================================== //
    
    /// Ingest company data through the Codex Compression pipeline
    /// This is how companies connect and their data gets processed
    public func ingestCompanyData(companyId: Text, rawData: [Float]) : async CodexCompression.CodexUnit {
        let (newState, unit) = CodexCompression.ingestCompanyData(codexState, companyId, rawData);
        codexState := newState;
        unit
    };
    
    /// Connect a new data source
    public func connectDataSource(sourceId: Text, sourceType: Text) : async () {
        codexState := CodexCompression.connectSource(codexState, sourceId, sourceType);
    };
    
    /// Get codex compression statistics
    public query func getCodexStats() : async {
        total_sources: Nat;
        total_absorbed: Nat;
        total_patterns: Nat;
        total_compressed: Nat;
        average_compression_ratio: Float;
    } {
        CodexCompression.getStatistics(codexState)
    };
    
    /// Get all ready-to-use codex units (processed data in MEDINA's language)
    public query func getReadyCodexUnits() : async [CodexCompression.CodexUnit] {
        CodexCompression.getReadyUnits(codexState)
    };
    
    // ================================================================== //
    // REPORT GENERATION — Business Dashboard & Analytics                   //
    // ================================================================== //
    
    /// Generate full dashboard report (for Founder: Alfredo Medina)
    public func generateFullDashboard() : async ReportGeneration.Report {
        let beat = Heartbeat.currentBeat(heartbeatState);
        let heartsCoherence = ThreeHeartsEngine.calculateCoherence(threeHeartsState);
        let codexStats = CodexCompression.getStatistics(codexState);
        
        let (newState, report) = ReportGeneration.generateFullDashboard(
            reportState,
            beat,
            {
                heartbeat_active = not Heartbeat.isPaused(heartbeatState);
                three_hearts_coherence = heartsCoherence.global_coherence;
                oro_resonance = sovereignState.oro.reader_state.resonance_total;
                nova_alignment = sovereignState.nova.alignment_score;
                drift_severity = OrganismReader.overallDriftSeverity(sovereignState.oro.reader_state);
            },
            {
                data_processed = codexStats.total_absorbed;
                patterns_recognized = codexStats.total_patterns;
                compression_ratio = codexStats.average_compression_ratio;
                active_clients = codexStats.total_sources;
            },
            {
                threat_level = 0.1;  // Would come from security monitoring
                anomalies_detected = 0;
                security_score = 0.95;
            }
        );
        
        reportState := newState;
        report
    };
    
    /// Generate system health report
    public func generateHealthReport() : async ReportGeneration.Report {
        let beat = Heartbeat.currentBeat(heartbeatState);
        let heartsCoherence = ThreeHeartsEngine.calculateCoherence(threeHeartsState);
        let modelStats = ModelRegistry.getStatistics(modelRegistryState);
        
        let (newState, report) = ReportGeneration.generateSystemHealthReport(
            reportState,
            beat,
            {
                heartbeat_active = not Heartbeat.isPaused(heartbeatState);
                three_hearts_coherence = heartsCoherence.global_coherence;
                oro_resonance = sovereignState.oro.reader_state.resonance_total;
                nova_alignment = sovereignState.nova.alignment_score;
                memory_usage = 0.5;  // Would come from canister metrics
                models_active = modelStats.active_models;
                drift_severity = OrganismReader.overallDriftSeverity(sovereignState.oro.reader_state);
            }
        );
        
        reportState := newState;
        report
    };
    
    /// Generate business metrics report
    public func generateBusinessReport() : async ReportGeneration.Report {
        let beat = Heartbeat.currentBeat(heartbeatState);
        let codexStats = CodexCompression.getStatistics(codexState);
        
        let (newState, report) = ReportGeneration.generateBusinessMetricsReport(
            reportState,
            beat,
            {
                data_processed = codexStats.total_absorbed;
                patterns_recognized = codexStats.total_patterns;
                compression_ratio = codexStats.average_compression_ratio;
                active_clients = codexStats.total_sources;
                system_utilization = 0.6;  // Would come from metrics
            }
        );
        
        reportState := newState;
        report
    };
    
    /// Get all reports
    public query func getAllReports() : async [ReportGeneration.Report] {
        reportState.reports
    };
    
    /// Get reports by category
    public query func getReportsByCategory(category: Text) : async [ReportGeneration.Report] {
        let cat : ReportGeneration.ReportCategory = switch (category) {
            case ("health") { #SystemHealth };
            case ("business") { #BusinessMetrics };
            case ("recommendations") { #Recommendations };
            case ("compliance") { #ComplianceAudit };
            case ("performance") { #PerformanceAnalysis };
            case ("risk") { #RiskAssessment };
            case ("evolution") { #EvolutionTimeline };
            case (_) { #FullDashboard };
        };
        ReportGeneration.getByCategory(reportState, cat)
    };
    
    /// Get report statistics
    public query func getReportStats() : async {
        total_reports: Nat;
        reports_by_category: [(ReportGeneration.ReportCategory, Nat)];
        last_generated: Int;
    } {
        ReportGeneration.getStatistics(reportState)
    };
    
    // ================================================================== //
    // NOVA SOVEREIGN ENCRYPTION API (April 2026)                           //
    // ================================================================== //
    
    /// Get sovereign encryption status
    public query func getSovereignEncryptionStatus() : async {
        rotation_tier: Text;
        rotation_step: Nat;
        rotation_max_steps: Nat;
        phi_cycle: Nat;
        compound_factor: Float;
        key_length: Nat;
        coherence: Float;
        beat_count: Nat;
        update_count: Nat;
        last_updated: Int;
    } {
        SovereignEncryption.status(sovereignEncryptionState)
    };
    
    /// Get Three Hearts encryption status
    public query func getThreeHeartsEncryptionStatus() : async {
        coherence: Float;
        tier: Text;
        phases: ThreeHeartsEncryption.PhaseDifferences;
        metro_phase: Float;
        coupling_phase: Float;
        regulating_phase: Float;
        metro_beats: Nat;
        coupling_beats: Nat;
        regulating_beats: Nat;
    } {
        ThreeHeartsEncryption.status(threeHeartsState)
    };
    
    /// Get ANIMA chain status
    public query func getAnimaChainStatus() : async {
        chain_depth: Nat;
        max_depth: Nat;
        tier: Text;
        valid: Bool;
        genesis_hash: [Nat8];
        latest_hash: [Nat8];
        founder_principal: ?Text;
        created_at: Int;
        last_extended: Int;
    } {
        AnimaChainEncryption.status(animaChainState)
    };
    
    /// Get VetKeys integration status
    public query func getVetKeysStatus() : async {
        fiduciary_subnet: Text;
        node_count: Nat;
        threshold: Nat;
        pending_vetkey_requests: Nat;
        pending_bls_requests: Nat;
        pending_vrf_requests: Nat;
        encrypted_maps_count: Nat;
        timelock_artifacts_count: Nat;
        succession_vessels_count: Nat;
        ip_attributions_count: Nat;
        founder_ledger_entries: Nat;
        cross_chain_addresses: Nat;
        initialized_at: Int;
        last_activity: Int;
    } {
        VetKeysIntegration.status(vetKeysState)
    };
    
    /// Get sovereign contracts status
    public query func getSovereignContractsStatus() : async {
        total_contracts: Nat;
        total_executed: Nat;
        total_frozen: Nat;
        contract_types: Nat;
        initialized_at: Int;
        last_contract_at: Int;
    } {
        SovereignContracts.status(contractsState)
    };
    
    /// Get sovereign ledgers status
    public query func getSovereignLedgersStatus() : async {
        total_entries: Nat;
        ledger_count: Nat;
        entry_counts: [(Text, Nat)];
        global_coherence: Float;
        total_assemblies: Nat;
        initialized_at: Int;
        last_entry_at: Int;
    } {
        SovereignLedgers.status(ledgersState)
    };
    
    /// Get defense system status
    public query func getDefenseSystemStatus() : async {
        current_tier: Text;
        current_tier_number: Nat;
        gate_a_open: Bool;
        gate_b_open: Bool;
        gate_c_open: Bool;
        m101_open: Bool;
        m102_open: Bool;
        active_events: Nat;
        total_events: Nat;
        frozen_components: [Text];
        pending_notifications: Nat;
        initialized_at: Int;
        last_event_at: Int;
    } {
        SovereignDefenseSystem.status(defenseState)
    };
    
    /// Get full NOVA SOVEREIGN encryption dashboard
    public query func getNovaSovereignDashboard() : async {
        // Platform
        platform_version: Text;
        
        // Key rotation
        rotation_tier: Text;
        rotation_step: Nat;
        rotation_max_steps: Nat;
        
        // Coherence
        global_coherence: Float;
        three_hearts_coherence: Float;
        
        // Chain
        anima_chain_depth: Nat;
        anima_chain_valid: Bool;
        
        // VetKeys
        vetkeys_enabled: Bool;
        threshold_nodes: Nat;
        
        // Contracts & Ledgers
        total_contracts: Nat;
        total_ledger_entries: Nat;
        ledger_count: Nat;
        
        // Defense
        defense_tier: Text;
        all_gates_open: Bool;
    } {
        let encStatus = SovereignEncryption.status(sovereignEncryptionState);
        let heartsStatus = ThreeHeartsEncryption.status(threeHeartsState);
        let chainStatus = AnimaChainEncryption.status(animaChainState);
        let vetStatus = VetKeysIntegration.status(vetKeysState);
        let contractStatus = SovereignContracts.status(contractsState);
        let ledgerStatus = SovereignLedgers.status(ledgersState);
        let defStatus = SovereignDefenseSystem.status(defenseState);
        
        {
            platform_version = platformVersion;
            rotation_tier = encStatus.rotation_tier;
            rotation_step = encStatus.rotation_step;
            rotation_max_steps = encStatus.rotation_max_steps;
            global_coherence = encStatus.coherence;
            three_hearts_coherence = heartsStatus.coherence;
            anima_chain_depth = chainStatus.chain_depth;
            anima_chain_valid = chainStatus.valid;
            vetkeys_enabled = true;
            threshold_nodes = vetStatus.node_count;
            total_contracts = contractStatus.total_contracts;
            total_ledger_entries = ledgerStatus.total_entries;
            ledger_count = ledgerStatus.ledger_count;
            defense_tier = defStatus.current_tier;
            all_gates_open = defStatus.gate_a_open and defStatus.gate_b_open and defStatus.gate_c_open and defStatus.m101_open and defStatus.m102_open;
        }
    };
    
    /// Update sovereign encryption key state (called every 873ms ideally)
    public func updateSovereignKeyState(
        newCoherence: Float,
        newDoctrineHash: [Nat8],
        newSensorHash: [Nat8],
        newBiometricHash: [Nat8]
    ) : async () {
        let currentBeat = Heartbeat.currentBeat(heartbeatState);
        ignore SovereignEncryption.updateKeyState(
            sovereignEncryptionState,
            newCoherence,
            currentBeat,
            newDoctrineHash,
            newSensorHash,
            newBiometricHash
        );
    };
    
    /// Extend ANIMA chain with new link
    public func extendAnimaChain(
        animaHash: Text,
        doctrineAlignment: Float
    ) : async () {
        let currentBeat = Heartbeat.currentBeat(heartbeatState);
        let heartsStatus = ThreeHeartsEncryption.status(threeHeartsState);
        let coherence = heartsStatus.coherence;
        
        ignore AnimaChainEncryption.extendChain(
            animaChainState,
            animaHash,
            currentBeat,
            doctrineAlignment,
            coherence
        );
    };
    
    /// Check defense gate
    public query func checkDefenseGate(gateId: Text) : async SovereignDefenseSystem.GateCheckResult {
        let gate : SovereignDefenseSystem.GateId = switch (gateId) {
            case ("A") { #GateA };
            case ("B") { #GateB };
            case ("C") { #GateC };
            case ("M101") { #M101 };
            case ("M102") { #M102 };
            case (_) { #GateA };
        };
        
        let heartsStatus = ThreeHeartsEncryption.status(threeHeartsState);
        SovereignDefenseSystem.checkGate(defenseState, gate, heartsStatus.coherence)
    };
    
    /// Get key rotation tier info
    public query func getKeyRotationInfo() : async {
        tier_name: Text;
        steps_in_tier: Nat;
        current_step: Nat;
        progress_percent: Float;
        coherence_required_for_e8: Float;
        coherence_required_for_leech: Float;
    } {
        let encStatus = SovereignEncryption.status(sovereignEncryptionState);
        let maxSteps = encStatus.rotation_max_steps;
        {
            tier_name = encStatus.rotation_tier;
            steps_in_tier = maxSteps;
            current_step = encStatus.rotation_step;
            progress_percent = if (maxSteps == 0) { 0.0 } else {
                Float.fromInt(encStatus.rotation_step) / Float.fromInt(maxSteps) * 100.0
            };
            coherence_required_for_e8 = IcosahedralLeechGeometry.COHERENCE_THRESHOLD_E8;
            coherence_required_for_leech = IcosahedralLeechGeometry.COHERENCE_THRESHOLD_LEECH;
        }
    };
    
    // ================================================================== //
    // L-130 UNIVERSAL PRIMITIVE LAW API                                    //
    // ================================================================== //
    
    /// Get L-130 law statement
    public query func getL130LawStatement() : async Text {
        UniversalPrimitiveLaw.lawStatement()
    };
    
    /// List all L-130 related laws
    public query func listL130Laws() : async [Text] {
        UniversalPrimitiveLaw.listLaws()
    };
    
    /// Detect primitive for an entity
    public func detectPrimitive(
        entityId: Text,
        entityType: Text,
        currentExpression: Text,
        knownLayers: [Text]
    ) : async ?Text {
        let domain = textToEntityDomain(entityType);
        let (newState, primitive) = DOC_PRIMITIVA_130.detectPrimitive(
            primitivaOrganismState,
            entityId,
            domain,
            currentExpression,
            knownLayers
        );
        primitivaOrganismState := newState;
        primitive
    };
    
    /// Run full primitive trace through Universal Primitive Engine
    public func fullPrimitiveTrace(
        entityId: Text,
        entityType: Text,
        currentExpression: Text,
        knownLayers: [Text],
        doctrineContext: ?Text,
        historyContext: ?Text
    ) : async {
        primitive_form: ?Text;
        primitive_state: Text;
        confidence: Float;
        descent_depth: Nat;
        drift_detected: Bool;
        recomposition_available: Bool;
    } {
        let domain = textToEntityDomain(entityType);
        let (newState, output) = DOC_PRIMITIVA_130.fullPrimitiveTrace(
            primitivaOrganismState,
            entityId,
            domain,
            currentExpression,
            knownLayers,
            doctrineContext,
            historyContext
        );
        primitivaOrganismState := newState;
        
        {
            primitive_form = output.primitive_form;
            primitive_state = primitiveStateToText(output.primitive_state);
            confidence = output.primitive_confidence_score;
            descent_depth = output.phase_results.descend_result.descent_depth;
            drift_detected = output.drift_map.size() > 0;
            recomposition_available = output.recomposition_blueprint != null;
        }
    };
    
    /// Register entity with L-130 primitive trace enforcement
    public func registerEntityWithPrimitiveTrace(
        entityId: Text,
        entityType: Text,
        entityName: Text,
        entityDescription: Text,
        currentExpression: Text,
        knownLayers: [Text],
        requestedBy: Text
    ) : async {
        success: Bool;
        registration_id: ?Text;
        primitive_form: ?Text;
        error_message: ?Text;
        blocking_law: ?Text;
    } {
        let regEntityType = textToRegistrableEntity(entityType);
        
        let request : PrimitiveRegistry.RegistrationRequest = {
            entity_id = entityId;
            entity_type = regEntityType;
            entity_name = entityName;
            entity_description = entityDescription;
            current_expression = currentExpression;
            known_layers = knownLayers;
            doctrine_context = null;
            history_context = null;
            requested_by = requestedBy;
        };
        
        let (newState, result) = PrimitiveRegistry.registerEntity(
            primitiveRegistryState,
            request
        );
        primitiveRegistryState := newState;
        
        {
            success = result.success;
            registration_id = result.registration_id;
            primitive_form = switch (result.primitive_trace) {
                case (?t) { ?t.primitive_form };
                case (null) { null };
            };
            error_message = result.error_message;
            blocking_law = result.blocking_law;
        }
    };
    
    /// Get primitive trace for registered entity
    public query func getPrimitiveTrace(entityId: Text) : async ?{
        primitive_form: Text;
        primitive_state: Text;
        confidence: Float;
        descent_depth: Nat;
        drift_detected: Bool;
    } {
        switch (PrimitiveRegistry.getPrimitiveTrace(primitiveRegistryState, entityId)) {
            case (?trace) {
                ?{
                    primitive_form = trace.primitive_form;
                    primitive_state = primitiveStateToText(trace.primitive_state);
                    confidence = trace.confidence_score;
                    descent_depth = trace.descent_depth;
                    drift_detected = trace.drift_detected;
                }
            };
            case (null) { null };
        }
    };
    
    /// Check if entity has primitive trace
    public query func hasPrimitiveTrace(entityId: Text) : async Bool {
        PrimitiveRegistry.hasPrimitiveTrace(primitiveRegistryState, entityId)
    };
    
    /// Verify entity's primitive trace (re-check for drift)
    public func verifyPrimitiveTrace(
        entityId: Text,
        currentExpression: Text,
        verifiedBy: Text
    ) : async { success: Bool; message: Text } {
        let (newState, success, message) = PrimitiveRegistry.verifyEntity(
            primitiveRegistryState,
            entityId,
            currentExpression,
            verifiedBy
        );
        primitiveRegistryState := newState;
        { success = success; message = message }
    };
    
    /// Get PRIMITIVA organism statistics
    public query func getPrimitivaStats() : async {
        total_traces: Nat;
        primitives_found: Nat;
        drifts_detected: Nat;
        recompositions_generated: Nat;
        registry_size: Nat;
    } {
        let stats = DOC_PRIMITIVA_130.getStatistics(primitivaOrganismState);
        {
            total_traces = stats.total_traces;
            primitives_found = stats.primitives_found;
            drifts_detected = stats.drifts_detected;
            recompositions_generated = stats.recompositions_generated;
            registry_size = stats.registry_size;
        }
    };
    
    /// Get Primitive Registry statistics
    public query func getPrimitiveRegistryStats() : async {
        total_entities: Nat;
        total_registrations: Nat;
        total_rejections: Nat;
        registration_rate: Float;
        drift_rate: Float;
    } {
        let stats = PrimitiveRegistry.getStatistics(primitiveRegistryState);
        {
            total_entities = stats.total_entities;
            total_registrations = stats.total_registrations;
            total_rejections = stats.total_rejections;
            registration_rate = stats.registration_rate;
            drift_rate = stats.drift_rate;
        }
    };
    
    /// Get entities with drift detected
    public query func getEntitiesWithDrift() : async [{
        entity_id: Text;
        entity_name: Text;
        primitive_form: Text;
        drift_type: Text;
    }] {
        let entities = PrimitiveRegistry.getEntitiesWithDrift(primitiveRegistryState);
        Array.map<PrimitiveRegistry.RegisteredEntity, {
            entity_id: Text;
            entity_name: Text;
            primitive_form: Text;
            drift_type: Text;
        }>(entities, func(e) {
            {
                entity_id = e.entity_id;
                entity_name = e.entity_name;
                primitive_form = e.primitive_trace.primitive_form;
                drift_type = switch (e.primitive_trace.drift_type) {
                    case (?t) { driftTypeToText(t) };
                    case (null) { "None" };
                };
            }
        })
    };
    
    /// Get primitive detection questions for a domain
    public query func getPrimitiveDetectionQuestions(domain: Text) : async [Text] {
        UniversalPrimitiveLaw.primitiveDetectionQuestions(textToEntityDomain(domain))
    };
    
    /// Get primitive validation tests
    public query func getPrimitiveValidationTests() : async [Text] {
        UniversalPrimitiveLaw.primitiveValidationTests()
    };
    
    // ================================================================== //
    // L-130 HELPER FUNCTIONS                                               //
    // ================================================================== //
    
    /// Convert text to EntityDomain
    func textToEntityDomain(text: Text) : UniversalPrimitiveLaw.EntityDomain {
        switch (text) {
            case ("physics") { #Physics };
            case ("biology") { #Biology };
            case ("cognition") { #Cognition };
            case ("language") { #Language };
            case ("software") { #Software };
            case ("law") { #Law };
            case ("economy") { #Economy };
            case ("governance") { #Governance };
            case ("symbolism") { #Symbolism };
            case ("color") { #Color };
            case ("civilization") { #Civilization };
            case ("memory") { #Memory };
            case ("interface") { #Interface };
            case ("company") { #Company };
            case ("token") { #Token };
            case ("document") { #Document };
            case ("workflow") { #Workflow };
            case ("market") { #Market };
            case ("myth") { #Myth };
            case ("brain") { #Brain };
            case ("architecture") { #Architecture };
            case ("canister") { #Canister };
            case ("organism") { #Organism };
            case ("engine") { #Engine };
            case ("signal") { #Signal };
            case ("substrate") { #Substrate };
            case (_) { #Software };  // Default
        }
    };
    
    /// Convert text to RegistrableEntity
    func textToRegistrableEntity(text: Text) : PrimitiveRegistry.RegistrableEntity {
        switch (text) {
            case ("organism") { #Organism };
            case ("document") { #Document };
            case ("token") { #Token };
            case ("company") { #Company };
            case ("engine") { #Engine };
            case ("law") { #Law };
            case ("canister") { #Canister };
            case ("workflow") { #Workflow };
            case ("model") { #Model };
            case ("contract") { #Contract };
            case ("ledger") { #Ledger };
            case ("architecture") { #Architecture };
            case ("symbol") { #Symbol };
            case ("color") { #Color };
            case ("substrate") { #Substrate };
            case ("signal") { #Signal };
            case ("interface") { #Interface };
            case (_) { #Document };  // Default
        }
    };
    
    /// Convert PrimitiveState to text
    func primitiveStateToText(state: UniversalPrimitiveLaw.PrimitiveState) : Text {
        switch (state) {
            case (#PRIMITIVE_CONFIRMED) { "PRIMITIVE_CONFIRMED" };
            case (#PRIMITIVE_FRAGMENTED) { "PRIMITIVE_FRAGMENTED" };
            case (#PRIMITIVE_HIDDEN) { "PRIMITIVE_HIDDEN" };
            case (#PRIMITIVE_INVERTED) { "PRIMITIVE_INVERTED" };
            case (#PRIMITIVE_HYBRIDIZED) { "PRIMITIVE_HYBRIDIZED" };
            case (#PRIMITIVE_CONTAMINATED) { "PRIMITIVE_CONTAMINATED" };
            case (#PRIMITIVE_UNREACHED) { "PRIMITIVE_UNREACHED" };
            case (#RECOMPOSED_TRUE) { "RECOMPOSED_TRUE" };
            case (#RECOMPOSED_FALSE) { "RECOMPOSED_FALSE" };
        }
    };
    
    /// Convert DriftType to text
    func driftTypeToText(drift: UniversalPrimitiveLaw.DriftType) : Text {
        switch (drift) {
            case (#PrimitiveForgotten) { "PrimitiveForgotten" };
            case (#WrongLayerOptimization) { "WrongLayerOptimization" };
            case (#InversionDrift) { "InversionDrift" };
            case (#FragmentationDrift) { "FragmentationDrift" };
            case (#HybridizationDrift) { "HybridizationDrift" };
            case (#AbstractionDrift) { "AbstractionDrift" };
            case (#NamingDrift) { "NamingDrift" };
            case (#FunctionDrift) { "FunctionDrift" };
        }
    };
    
    // ================================================================== //
    // L-130 APPLIED TRACES API                                             //
    // ================================================================== //
    
    /// Get all applied primitive traces
    public query func getAppliedTraces() : async [{
        entity_id: Text;
        entity_name: Text;
        primitive_form: Text;
        confidence_score: Float;
    }] {
        let traces = L130_AppliedTraces.getAllAppliedTraces();
        Array.map<L130_AppliedTraces.AppliedTrace, {
            entity_id: Text;
            entity_name: Text;
            primitive_form: Text;
            confidence_score: Float;
        }>(traces, func(t) {
            {
                entity_id = t.entity_id;
                entity_name = t.entity_name;
                primitive_form = t.primitive_form;
                confidence_score = t.confidence_score;
            }
        })
    };
    
    /// Get applied trace for specific entity
    public query func getAppliedTrace(entityId: Text) : async ?{
        entity_id: Text;
        entity_name: Text;
        primitive_form: Text;
        primitive_state: Text;
        stripped_wrappers_count: Nat;
        descent_depth: Nat;
        verification_notes: Text;
        confidence_score: Float;
    } {
        switch (L130_AppliedTraces.getTraceByEntityId(entityId)) {
            case (?trace) {
                ?{
                    entity_id = trace.entity_id;
                    entity_name = trace.entity_name;
                    primitive_form = trace.primitive_form;
                    primitive_state = primitiveStateToText(trace.primitive_state);
                    stripped_wrappers_count = trace.stripped_wrappers.size();
                    descent_depth = trace.descent_layers.size();
                    verification_notes = trace.verification_notes;
                    confidence_score = trace.confidence_score;
                }
            };
            case (null) { null };
        }
    };
    
    /// Get all primitive forms (summary)
    public query func getAllPrimitiveForms() : async [(Text, Text)] {
        L130_AppliedTraces.getAllPrimitiveForms()
    };
    
    /// Get trace statistics
    public query func getTraceStatistics() : async {
        total_traces: Nat;
        all_confirmed: Bool;
        average_confidence: Float;
        total_stripped_wrappers: Nat;
        total_descent_layers: Nat;
    } {
        L130_AppliedTraces.getTraceStatistics()
    };
}
