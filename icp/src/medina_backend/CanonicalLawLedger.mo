/**
 * CanonicalLawLedger Module — The Single Source of Truth for All Decisions
 * 
 * ╔═══════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                   ║
 * ║                        CANONICAL LAW LEDGER SYSTEM                                ║
 * ║                                                                                   ║
 * ║  This is THE canonical ledger that records every major decision, model routing   ║
 * ║  event, and evolution step. It is immutable, hash-linked, and human-readable.    ║
 * ║                                                                                   ║
 * ║  THREE PHASES:                                                                    ║
 * ║    1. DRAFT — Writable stream for agent drafts, iterative development            ║
 * ║    2. VERIFY — Verification checks, coherence validation, attestations           ║
 * ║    3. CANONICAL — Post-verified, hashed, append-only, immutable                  ║
 * ║                                                                                   ║
 * ║  EVERY ENTRY MUST HAVE:                                                          ║
 * ║    - Human-readable narrative (2-6 sentences)                                    ║
 * ║    - Decision hash (SHA-256 over canonicalized fields)                          ║
 * ║    - Actor list (agents/models involved)                                         ║
 * ║    - Input/output summaries                                                      ║
 * ║    - Optional proof/attestations                                                 ║
 * ║                                                                                   ║
 * ║  USES:                                                                           ║
 * ║    - Audit trail for all intelligence routing                                    ║
 * ║    - Evolution event logging                                                     ║
 * ║    - Model routing decisions                                                     ║
 * ║    - Agent task execution                                                        ║
 * ║    - Organism state changes                                                      ║
 * ║    - Cryptographic proof for transparency                                        ║
 * ║                                                                                   ║
 * ╚═══════════════════════════════════════════════════════════════════════════════════╝
 * 
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Blob "mo:base/Blob";
import Float "mo:base/Float";
import Hash "mo:base/Hash";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";

module {
    // ================================================================== //
    // LOG PHASES                                                          //
    // ================================================================== //
    
    /// The three phases of a log entry
    public type LogPhase = {
        #Draft;      // Writable, iterative, agent-generated
        #Verify;     // Under verification, coherence checks
        #Canonical;  // Immutable, hashed, append-only
        #Audit;      // External audit review (optional)
    };
    
    /// Phase transition rules
    public func canTransition(from: LogPhase, to: LogPhase) : Bool {
        switch (from, to) {
            case (#Draft, #Verify) { true };
            case (#Verify, #Canonical) { true };
            case (#Canonical, #Audit) { true };
            case (_, _) { false };
        }
    };
    
    // ================================================================== //
    // ACTION TYPES                                                        //
    // ================================================================== //
    
    /// Standard action verbs for logging
    public type ActionType = {
        #RouteIntelligence;     // Intelligence routing decision
        #MutateDocument;        // Document organism mutation
        #EvolveOrganism;        // Organism evolution step
        #CreateModule;          // New module creation
        #UpdateRegistry;        // Model registry update
        #ExecuteAgent;          // Agent task execution
        #VerifyCoherence;       // Coherence check
        #SyncHeartbeat;         // Heartbeat synchronization
        #EncryptArtifact;       // Encryption operation
        #DecryptArtifact;       // Decryption operation
        #CreateContract;        // Contract creation
        #SignContract;          // Contract signing
        #TransferAsset;         // Asset transfer
        #GovernanceVote;        // Governance voting
        #MemoryFormation;       // Memory creation
        #MemoryRecall;          // Memory retrieval
        #DefenseResponse;       // Defense system activation
        #SessionCapture;        // Session logging
        #ModelInvocation;       // Model execution
        #ClusterRouting;        // Cluster-level routing
        #PhaseTransition;       // Log phase transition
        #SystemInit;            // System initialization
        #SystemShutdown;        // System shutdown
        #AnomalyDetected;       // Anomaly detection
        #SelfHeal;              // Self-healing action
        #Custom : Text;         // Custom action
    };
    
    /// Get action name as text
    public func actionName(action: ActionType) : Text {
        switch (action) {
            case (#RouteIntelligence) { "route_intelligence" };
            case (#MutateDocument) { "mutate_document" };
            case (#EvolveOrganism) { "evolve_organism" };
            case (#CreateModule) { "create_module" };
            case (#UpdateRegistry) { "update_registry" };
            case (#ExecuteAgent) { "execute_agent" };
            case (#VerifyCoherence) { "verify_coherence" };
            case (#SyncHeartbeat) { "sync_heartbeat" };
            case (#EncryptArtifact) { "encrypt_artifact" };
            case (#DecryptArtifact) { "decrypt_artifact" };
            case (#CreateContract) { "create_contract" };
            case (#SignContract) { "sign_contract" };
            case (#TransferAsset) { "transfer_asset" };
            case (#GovernanceVote) { "governance_vote" };
            case (#MemoryFormation) { "memory_formation" };
            case (#MemoryRecall) { "memory_recall" };
            case (#DefenseResponse) { "defense_response" };
            case (#SessionCapture) { "session_capture" };
            case (#ModelInvocation) { "model_invocation" };
            case (#ClusterRouting) { "cluster_routing" };
            case (#PhaseTransition) { "phase_transition" };
            case (#SystemInit) { "system_init" };
            case (#SystemShutdown) { "system_shutdown" };
            case (#AnomalyDetected) { "anomaly_detected" };
            case (#SelfHeal) { "self_heal" };
            case (#Custom(name)) { name };
        }
    };
    
    // ================================================================== //
    // LOG ENTRY SCHEMA                                                    //
    // ================================================================== //
    
    /// Actor reference (agent or model)
    public type ActorRef = {
        actor_id: Text;
        actor_type: ActorType;
        family: ?Text;  // Agent family or model cluster
    };
    
    /// Actor types
    public type ActorType = {
        #Agent;
        #Model;
        #System;
        #Human;
    };
    
    /// Input/output summary
    public type IOSummary = {
        key: Text;
        value: Text;
        hash: ?[Nat8];  // Optional hash of full value
    };
    
    /// Proof/attestation
    public type Proof = {
        proof_type: ProofType;
        data: [Nat8];
        signer: ?Principal;
        timestamp: Int;
    };
    
    /// Proof types
    public type ProofType = {
        #Signature;         // Digital signature
        #CanisterAttestation;  // Canister attestation
        #HashChain;         // Hash chain link
        #CoherenceProof;    // Coherence verification
        #AnimaProof;        // ANIMA hash proof
    };
    
    /// The canonical log entry schema
    public type LogEntry = {
        // Identity
        id: Text;                   // UUID-style identifier
        sequence: Nat;              // Sequential number in ledger
        
        // Temporal
        timestamp: Int;             // ISO8601-compatible nanoseconds
        beat_at_creation: Nat;      // Heartbeat at creation
        
        // Phase
        phase: LogPhase;            // Current phase
        phase_history: [PhaseTransition];  // Transition history
        
        // Actors
        actors: [ActorRef];         // Agents/models involved
        
        // Action
        action: ActionType;         // What happened
        
        // REQUIRED: Human-readable narrative (2-6 sentences)
        summary: Text;              // Plain-English explanation
        
        // Inputs/Outputs
        inputs: [IOSummary];        // Key inputs
        outputs: [IOSummary];       // Key outputs
        
        // Hashing
        decision_hash: [Nat8];      // SHA-256 over canonicalized fields
        prev_hash: [Nat8];          // Previous entry hash (chain link)
        
        // Proofs
        proofs: [Proof];            // Optional signatures/attestations
        
        // Context
        anima_hash: Text;           // ANIMA lineage hash
        coherence_at_log: Float;    // Coherence when logged
        
        // References
        related_logs: [Text];       // Related log entry IDs
        source_module: Text;        // Originating module
    };
    
    /// Phase transition record
    public type PhaseTransition = {
        from_phase: LogPhase;
        to_phase: LogPhase;
        transitioned_at: Int;
        transitioned_by: ActorRef;
        verification_hash: [Nat8];
    };
    
    // ================================================================== //
    // LOG ENTRY BUILDERS                                                  //
    // ================================================================== //
    
    /// Create a draft log entry
    public func createDraftEntry(
        id: Text,
        sequence: Nat,
        actors: [ActorRef],
        action: ActionType,
        summary: Text,
        inputs: [IOSummary],
        outputs: [IOSummary],
        sourceModule: Text,
        beatAtCreation: Nat,
        coherence: Float,
        animaHash: Text,
        prevHash: [Nat8]
    ) : LogEntry {
        let timestamp = Time.now();
        
        // Calculate decision hash
        let decisionHash = calculateDecisionHash(
            id, timestamp, actors, action, summary, inputs, outputs
        );
        
        {
            id = id;
            sequence = sequence;
            timestamp = timestamp;
            beat_at_creation = beatAtCreation;
            phase = #Draft;
            phase_history = [];
            actors = actors;
            action = action;
            summary = summary;
            inputs = inputs;
            outputs = outputs;
            decision_hash = decisionHash;
            prev_hash = prevHash;
            proofs = [];
            anima_hash = animaHash;
            coherence_at_log = coherence;
            related_logs = [];
            source_module = sourceModule;
        }
    };
    
    /// Calculate decision hash (SHA-256 over canonicalized fields)
    public func calculateDecisionHash(
        id: Text,
        timestamp: Int,
        actors: [ActorRef],
        action: ActionType,
        summary: Text,
        inputs: [IOSummary],
        outputs: [IOSummary]
    ) : [Nat8] {
        // Canonicalize fields
        var canonical = id # "|" # Int.toText(timestamp) # "|";
        
        // Add actors
        for (actor in actors.vals()) {
            canonical := canonical # actor.actor_id # ",";
        };
        canonical := canonical # "|";
        
        // Add action
        canonical := canonical # actionName(action) # "|";
        
        // Add summary
        canonical := canonical # summary # "|";
        
        // Add inputs
        for (input in inputs.vals()) {
            canonical := canonical # input.key # ":" # input.value # ",";
        };
        canonical := canonical # "|";
        
        // Add outputs
        for (output in outputs.vals()) {
            canonical := canonical # output.key # ":" # output.value # ",";
        };
        
        // Hash using ANIMA hash function
        let hashText = MatalkoICP.animaHash(canonical);
        textToBytes(hashText)
    };
    
    /// Convert text to bytes
    func textToBytes(t: Text) : [Nat8] {
        let chars = Text.toIter(t);
        let buf = Buffer.Buffer<Nat8>(t.size());
        for (c in chars) {
            buf.add(Nat8.fromNat(Nat32.toNat(Char.toNat32(c)) % 256));
        };
        Buffer.toArray(buf)
    };
    
    // ================================================================== //
    // PHASE TRANSITIONS                                                   //
    // ================================================================== //
    
    /// Promote draft to verify phase
    public func promoteToVerify(
        entry: LogEntry,
        verifier: ActorRef
    ) : ?LogEntry {
        if (entry.phase != #Draft) {
            return null;
        };
        
        let transition : PhaseTransition = {
            from_phase = #Draft;
            to_phase = #Verify;
            transitioned_at = Time.now();
            transitioned_by = verifier;
            verification_hash = entry.decision_hash;
        };
        
        let newHistory = Array.append(entry.phase_history, [transition]);
        
        ?{
            entry with
            phase = #Verify;
            phase_history = newHistory;
        }
    };
    
    /// Promote verify to canonical phase
    public func promoteToCanonical(
        entry: LogEntry,
        auditor: ActorRef,
        proofs: [Proof]
    ) : ?LogEntry {
        if (entry.phase != #Verify) {
            return null;
        };
        
        let transition : PhaseTransition = {
            from_phase = #Verify;
            to_phase = #Canonical;
            transitioned_at = Time.now();
            transitioned_by = auditor;
            verification_hash = entry.decision_hash;
        };
        
        let newHistory = Array.append(entry.phase_history, [transition]);
        let allProofs = Array.append(entry.proofs, proofs);
        
        ?{
            entry with
            phase = #Canonical;
            phase_history = newHistory;
            proofs = allProofs;
        }
    };
    
    // ================================================================== //
    // LEDGER STATE                                                        //
    // ================================================================== //
    
    /// Canonical Law Ledger state
    public type LedgerState = {
        // Entry streams
        var draft_entries: [LogEntry];
        var verify_entries: [LogEntry];
        var canonical_entries: [LogEntry];
        var audit_entries: [LogEntry];
        
        // Sequence counters
        var next_sequence: Nat;
        var total_entries: Nat;
        
        // Hash chain
        var latest_canonical_hash: [Nat8];
        var genesis_hash: [Nat8];
        
        // Statistics
        var entries_by_action: [(ActionType, Nat)];
        var entries_by_actor: [(Text, Nat)];
        
        // Timestamps
        var created_at: Int;
        var last_entry_at: Int;
    };
    
    /// Initialize ledger state
    public func init() : LedgerState {
        let genesisHash = textToBytes(MatalkoICP.animaHash("GENESIS_LAW_LEDGER"));
        
        {
            var draft_entries = [];
            var verify_entries = [];
            var canonical_entries = [];
            var audit_entries = [];
            var next_sequence = 1;
            var total_entries = 0;
            var latest_canonical_hash = genesisHash;
            var genesis_hash = genesisHash;
            var entries_by_action = [];
            var entries_by_actor = [];
            var created_at = Time.now();
            var last_entry_at = Time.now();
        }
    };
    
    // ================================================================== //
    // LEDGER OPERATIONS                                                   //
    // ================================================================== //
    
    /// Add a draft entry to the ledger
    public func addDraftEntry(
        state: LedgerState,
        actors: [ActorRef],
        action: ActionType,
        summary: Text,
        inputs: [IOSummary],
        outputs: [IOSummary],
        sourceModule: Text,
        beatAtCreation: Nat,
        coherence: Float,
        animaHash: Text
    ) : (LedgerState, LogEntry) {
        let entryId = "LOG_" # Nat.toText(state.next_sequence) # "_" # Int.toText(Time.now());
        
        let entry = createDraftEntry(
            entryId,
            state.next_sequence,
            actors,
            action,
            summary,
            inputs,
            outputs,
            sourceModule,
            beatAtCreation,
            coherence,
            animaHash,
            state.latest_canonical_hash
        );
        
        // Update state
        state.draft_entries := Array.append(state.draft_entries, [entry]);
        state.next_sequence += 1;
        state.total_entries += 1;
        state.last_entry_at := Time.now();
        
        (state, entry)
    };
    
    /// Verify and promote a draft entry
    public func verifyEntry(
        state: LedgerState,
        entryId: Text,
        verifier: ActorRef
    ) : (LedgerState, ?LogEntry) {
        // Find draft entry
        var found : ?LogEntry = null;
        var remaining = Buffer.Buffer<LogEntry>(state.draft_entries.size());
        
        for (entry in state.draft_entries.vals()) {
            if (entry.id == entryId) {
                found := promoteToVerify(entry, verifier);
            } else {
                remaining.add(entry);
            };
        };
        
        switch (found) {
            case (?verifiedEntry) {
                state.draft_entries := Buffer.toArray(remaining);
                state.verify_entries := Array.append(state.verify_entries, [verifiedEntry]);
                (state, ?verifiedEntry)
            };
            case (null) {
                (state, null)
            };
        }
    };
    
    /// Canonicalize a verified entry
    public func canonicalizeEntry(
        state: LedgerState,
        entryId: Text,
        auditor: ActorRef,
        proofs: [Proof]
    ) : (LedgerState, ?LogEntry) {
        // Find verify entry
        var found : ?LogEntry = null;
        var remaining = Buffer.Buffer<LogEntry>(state.verify_entries.size());
        
        for (entry in state.verify_entries.vals()) {
            if (entry.id == entryId) {
                found := promoteToCanonical(entry, auditor, proofs);
            } else {
                remaining.add(entry);
            };
        };
        
        switch (found) {
            case (?canonicalEntry) {
                state.verify_entries := Buffer.toArray(remaining);
                state.canonical_entries := Array.append(state.canonical_entries, [canonicalEntry]);
                state.latest_canonical_hash := canonicalEntry.decision_hash;
                (state, ?canonicalEntry)
            };
            case (null) {
                (state, null)
            };
        }
    };
    
    /// Fast-track: Create and immediately canonicalize (for system events)
    public func logCanonical(
        state: LedgerState,
        actors: [ActorRef],
        action: ActionType,
        summary: Text,
        inputs: [IOSummary],
        outputs: [IOSummary],
        sourceModule: Text,
        beatAtCreation: Nat,
        coherence: Float,
        animaHash: Text,
        systemProof: Proof
    ) : (LedgerState, LogEntry) {
        let entryId = "LOG_" # Nat.toText(state.next_sequence) # "_" # Int.toText(Time.now());
        
        var entry = createDraftEntry(
            entryId,
            state.next_sequence,
            actors,
            action,
            summary,
            inputs,
            outputs,
            sourceModule,
            beatAtCreation,
            coherence,
            animaHash,
            state.latest_canonical_hash
        );
        
        // Auto-verify
        let systemActor : ActorRef = {
            actor_id = "SYSTEM";
            actor_type = #System;
            family = ?"CORE";
        };
        
        switch (promoteToVerify(entry, systemActor)) {
            case (?verified) {
                entry := verified;
            };
            case (null) {};
        };
        
        // Auto-canonicalize
        switch (promoteToCanonical(entry, systemActor, [systemProof])) {
            case (?canonical) {
                entry := canonical;
            };
            case (null) {};
        };
        
        // Update state
        state.canonical_entries := Array.append(state.canonical_entries, [entry]);
        state.next_sequence += 1;
        state.total_entries += 1;
        state.last_entry_at := Time.now();
        state.latest_canonical_hash := entry.decision_hash;
        
        (state, entry)
    };
    
    // ================================================================== //
    // QUERY FUNCTIONS                                                     //
    // ================================================================== //
    
    /// Get entry by ID
    public func getEntry(state: LedgerState, entryId: Text) : ?LogEntry {
        // Search all streams
        for (entry in state.draft_entries.vals()) {
            if (entry.id == entryId) return ?entry;
        };
        for (entry in state.verify_entries.vals()) {
            if (entry.id == entryId) return ?entry;
        };
        for (entry in state.canonical_entries.vals()) {
            if (entry.id == entryId) return ?entry;
        };
        for (entry in state.audit_entries.vals()) {
            if (entry.id == entryId) return ?entry;
        };
        null
    };
    
    /// Get entries by action type
    public func getEntriesByAction(state: LedgerState, action: ActionType) : [LogEntry] {
        let buf = Buffer.Buffer<LogEntry>(state.canonical_entries.size());
        for (entry in state.canonical_entries.vals()) {
            if (actionName(entry.action) == actionName(action)) {
                buf.add(entry);
            };
        };
        Buffer.toArray(buf)
    };
    
    /// Get entries by actor
    public func getEntriesByActor(state: LedgerState, actorId: Text) : [LogEntry] {
        let buf = Buffer.Buffer<LogEntry>(state.canonical_entries.size());
        for (entry in state.canonical_entries.vals()) {
            for (actor in entry.actors.vals()) {
                if (actor.actor_id == actorId) {
                    buf.add(entry);
                };
            };
        };
        Buffer.toArray(buf)
    };
    
    /// Get latest N canonical entries
    public func getLatestCanonical(state: LedgerState, n: Nat) : [LogEntry] {
        let total = state.canonical_entries.size();
        if (n >= total) {
            return state.canonical_entries;
        };
        Array.tabulate<LogEntry>(
            n,
            func(i) { state.canonical_entries[total - n + i] }
        )
    };
    
    /// Verify hash chain integrity
    public func verifyChainIntegrity(state: LedgerState) : Bool {
        if (state.canonical_entries.size() == 0) {
            return true;
        };
        
        var prevHash = state.genesis_hash;
        for (entry in state.canonical_entries.vals()) {
            // Check prev_hash matches expected
            if (not arrayEqual(entry.prev_hash, prevHash)) {
                return false;
            };
            prevHash := entry.decision_hash;
        };
        
        true
    };
    
    /// Array equality helper
    func arrayEqual(a: [Nat8], b: [Nat8]) : Bool {
        if (a.size() != b.size()) return false;
        for (i in Iter.range(0, a.size() - 1)) {
            if (a[i] != b[i]) return false;
        };
        true
    };
    
    // ================================================================== //
    // LEDGER STATUS                                                       //
    // ================================================================== //
    
    /// Get ledger status
    public func status(state: LedgerState) : {
        total_entries: Nat;
        draft_count: Nat;
        verify_count: Nat;
        canonical_count: Nat;
        audit_count: Nat;
        chain_valid: Bool;
        last_entry_at: Int;
        created_at: Int;
    } {
        {
            total_entries = state.total_entries;
            draft_count = state.draft_entries.size();
            verify_count = state.verify_entries.size();
            canonical_count = state.canonical_entries.size();
            audit_count = state.audit_entries.size();
            chain_valid = verifyChainIntegrity(state);
            last_entry_at = state.last_entry_at;
            created_at = state.created_at;
        }
    };
    
    // ================================================================== //
    // HUMAN-READABLE FORMATTING                                           //
    // ================================================================== //
    
    /// Format entry as human-readable text
    public func formatEntry(entry: LogEntry) : Text {
        var text = "═══════════════════════════════════════════════════════════════\n";
        text := text # "LOG ENTRY: " # entry.id # "\n";
        text := text # "───────────────────────────────────────────────────────────────\n";
        text := text # "Phase: " # phaseToText(entry.phase) # "\n";
        text := text # "Action: " # actionName(entry.action) # "\n";
        text := text # "Timestamp: " # Int.toText(entry.timestamp) # "\n";
        text := text # "Beat: " # Nat.toText(entry.beat_at_creation) # "\n";
        text := text # "Coherence: " # Float.toText(entry.coherence_at_log) # "\n";
        text := text # "───────────────────────────────────────────────────────────────\n";
        text := text # "SUMMARY:\n" # entry.summary # "\n";
        text := text # "───────────────────────────────────────────────────────────────\n";
        text := text # "ACTORS:\n";
        for (actor in entry.actors.vals()) {
            text := text # "  - " # actor.actor_id # " (" # actorTypeToText(actor.actor_type) # ")\n";
        };
        text := text # "───────────────────────────────────────────────────────────────\n";
        text := text # "INPUTS:\n";
        for (input in entry.inputs.vals()) {
            text := text # "  " # input.key # ": " # input.value # "\n";
        };
        text := text # "OUTPUTS:\n";
        for (output in entry.outputs.vals()) {
            text := text # "  " # output.key # ": " # output.value # "\n";
        };
        text := text # "───────────────────────────────────────────────────────────────\n";
        text := text # "ANIMA Hash: " # entry.anima_hash # "\n";
        text := text # "Source: " # entry.source_module # "\n";
        text := text # "═══════════════════════════════════════════════════════════════\n";
        text
    };
    
    /// Phase to text
    func phaseToText(phase: LogPhase) : Text {
        switch (phase) {
            case (#Draft) { "DRAFT" };
            case (#Verify) { "VERIFY" };
            case (#Canonical) { "CANONICAL" };
            case (#Audit) { "AUDIT" };
        }
    };
    
    /// Actor type to text
    func actorTypeToText(actorType: ActorType) : Text {
        switch (actorType) {
            case (#Agent) { "Agent" };
            case (#Model) { "Model" };
            case (#System) { "System" };
            case (#Human) { "Human" };
        }
    };
}
