/**
 * MEDINA Types Module — Core type definitions for ICP implementation.
 * 
 * Mirrors the Python architecture with ICP-native types.
 */

import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

module {
    // ================================================================== //
    // CONSTANTS                                                            //
    // ================================================================== //
    
    /// Golden ratio for natural scaling
    public let PHI : Float = 1.618033988749895;
    
    /// Major torus radius
    public let TORUS_R : Float = 16.18033988749895; // PHI * 10
    
    // ================================================================== //
    // DOCTRINE TYPES                                                       //
    // ================================================================== //
    
    /// Non-collapsible doctrine hierarchy levels
    public type DoctrineLevel = {
        #ABSOLUTE;    // Immutable founding truth
        #LAW;         // Constitutional laws
        #MODEL;       // Runtime model contracts
        #ENGINE;      // Execution engine specs
        #CORE;        // Core A/B boundaries
        #MODULE;      // Module capabilities
        #LAB;         // Experimental scope
        #WORKFORCE;   // Document/agent workforce
        #PRODUCT;     // External product surface
    };
    
    /// Single entry in the constitution registry
    public type DoctrineEntry = {
        entry_id: Text;
        level: DoctrineLevel;
        key: Text;
        value: Text;
        rationale: Text;
        created_at: Int;
        updated_at: Int;
        version: Nat;
        immutable: Bool;
    };
    
    // ================================================================== //
    // MEMORY TYPES                                                         //
    // ================================================================== //
    
    /// Classification of memory nodes
    public type MemoryType = {
        #EPISODIC;     // Event/experience memory
        #SEMANTIC;     // Knowledge/fact memory
        #PROCEDURAL;   // How-to/skill memory
        #WORKING;      // Active/temporary memory
        #DOCTRINE;     // Constitutional/law memory
    };
    
    /// Memory consolidation lifecycle states
    public type ConsolidationState = {
        #FRESH;          // Newly created
        #STABLE;         // Verified and settled
        #CONSOLIDATING;  // In merge process
        #CONSOLIDATED;   // Merged into parent
        #PROMOTED;       // Elevated to higher salience
        #ARCHIVED;       // Moved to cold storage
    };
    
    /// Toroidal coordinate system for memory geometry
    public type MemoryCoordinates = {
        theta: Float;    // [0, 2π) - angular position on helix
        phi: Float;      // [0, 2π) - toroidal rotation
        depth: Float;    // ρ > 0 - radial depth (salience indicator)
        ring: Nat;       // ring ≥ 0 - memory ring index
        beat: Nat;       // beat ≥ 0 - creation beat
    };
    
    /// A single memory node in the temple
    public type MemoryNode = {
        node_id: Text;
        parent_id: ?Text;
        content: Text;           // JSON-encoded content
        summary: Text;
        tags: [Text];
        memory_type: MemoryType;
        state: ConsolidationState;
        coordinates: MemoryCoordinates;
        salience_score: Float;   // [0, 1]
        pinned: Bool;
        created_at: Int;
        updated_at: Int;
        accessed_at: Int;
    };
    
    /// Query specification for memory retrieval
    public type MemoryQuery = {
        text: ?Text;
        tags: ?[Text];
        memory_type: ?MemoryType;
        state: ?ConsolidationState;
        min_salience: Float;
        max_salience: Float;
        pinned_only: Bool;
        ring: ?Nat;
        from_beat: ?Nat;
        to_beat: ?Nat;
        limit: Nat;
    };
    
    // ================================================================== //
    // HEARTBEAT TYPES                                                      //
    // ================================================================== //
    
    /// Beat execution cadence for orchestrated operations
    public type CadenceClass = {
        #EVERY_BEAT;    // Execute on every tick
        #N_BEAT;        // Execute every N beats
        #EVENT_DRIVEN;  // Execute only on trigger
    };
    
    /// Event emitted by a heartbeat tick
    public type BeatEvent = {
        event_id: Text;
        beat: Nat;
        timestamp: Int;
        phase: Text;      // pre_beat, tick, post_beat
        payload: Text;    // JSON-encoded payload
    };
    
    /// Metrics collected during a heartbeat cycle
    public type BeatMetrics = {
        beat: Nat;
        start_time: Int;
        end_time: Int;
        tasks_executed: Nat;
        tasks_skipped: Nat;
        events_emitted: Nat;
        budget_exceeded: Bool;
    };
    
    // ================================================================== //
    // GOVERNANCE TYPES                                                     //
    // ================================================================== //
    
    /// Proposal status in governance workflow
    public type ProposalStatus = {
        #DRAFT;
        #SUBMITTED;
        #UNDER_REVIEW;
        #APPROVED;
        #REJECTED;
        #EXECUTED;
        #WITHDRAWN;
    };
    
    /// Proposal category
    public type ProposalCategory = {
        #RUNTIME_MUTATION;
        #CONSTITUTIONAL;
        #MEMORY_OPERATION;
        #MODEL_ROUTING;
        #COMPANY_ONBOARDING;
    };
    
    /// A governance proposal
    public type Proposal = {
        proposal_id: Text;
        title: Text;
        description: Text;
        category: ProposalCategory;
        status: ProposalStatus;
        proposer: Principal;
        created_at: Int;
        updated_at: Int;
        votes_for: Nat;
        votes_against: Nat;
    };
    
    // ================================================================== //
    // PLATFORM TYPES                                                       //
    // ================================================================== //
    
    /// Command result from platform operations
    public type CommandResult = {
        success: Bool;
        output: Text;       // JSON-encoded output
        error: ?Text;
    };
    
    /// Platform status snapshot
    public type PlatformStatus = {
        platform: Text;
        current_beat: Nat;
        total_memories: Nat;
        total_proposals: Nat;
        constitution_entries: Nat;
        uptime_ns: Int;
        healthy: Bool;
    };
    
    // ================================================================== //
    // COMPANY TYPES                                                        //
    // ================================================================== //
    
    /// Company onboarding mode
    public type OnboardingMode = {
        #CONNECT;       // External API connection
        #INTERNALIZE;   // Full data internalization
        #HYBRID;        // Mixed approach
    };
    
    /// Company record
    public type Company = {
        company_id: Text;
        name: Text;
        domain: Text;
        mode: OnboardingMode;
        onboarded_at: Int;
        active: Bool;
    };
    
    // ================================================================== //
    // MODEL TYPES                                                          //
    // ================================================================== //
    
    /// Model family classification
    public type ModelFamily = {
        #R_MODEL;   // Runtime organism models
        #U_MODEL;   // Interface operation models
        #D_MODEL;   // Document intelligence models
        #N_MODEL;   // Sovereign macro-node models
    };
    
    /// Model registration
    public type ModelRegistration = {
        model_id: Text;
        family: ModelFamily;
        name: Text;
        version: Text;
        active: Bool;
        registered_at: Int;
    };
}
