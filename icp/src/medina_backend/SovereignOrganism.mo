/**
 * SovereignOrganism Module — Oro + Nova Dual Intelligence
 * 
 * The dual sovereign system where ORO (Primary Sovereign) and NOVA (Doctrine 
 * Guardian) work together to maintain constitutional alignment while enabling
 * organism evolution.
 * 
 * ORO (Primary Sovereign):
 *   - Owns the beat (timing authority)
 *   - Evolves registers via RECITAL_PLUS_ONE
 *   - Generates ANIMA hash (identity signature)
 *   - Proposes state mutations
 *   - Reads doctrines for resonance gain
 * 
 * NOVA (Doctrine Guardian):
 *   - Reviews output for drift
 *   - Validates doctrine alignment
 *   - Maintains constitutional bounds
 *   - Flags violations
 *   - Can veto mutations that violate doctrine
 * 
 * DUAL CONSENSUS:
 *   - Both must agree before gates open
 *   - Oro proposes, Nova validates
 *   - Disagreement triggers drift investigation
 *   - Resolution required before continuation
 * 
 * FOUR REGISTERS:
 *   Ω_F (Founder)   — Founding intent, doctrine root (immutable)
 *   Ω_B (Builder)   — Workforce proposals, execution claims
 *   Ω_O (Organism)  — Validated runtime truth (Core A)
 *   Ω_E (External)  — Safe projection payload (Gate C bounded)
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import OrganismReader "OrganismReader";
import DoctrineDocuments "DoctrineDocuments";

module {
    // ================================================================== //
    // REGISTER TYPES                                                       //
    // ================================================================== //
    
    /// Register identifier
    public type RegisterId = {
        #Founder;    // Ω_F — Founding intent
        #Builder;    // Ω_B — Workforce proposals
        #Organism;   // Ω_O — Runtime truth (Core A)
        #External;   // Ω_E — Safe projection (Gate C)
    };
    
    /// Register state
    public type RegisterState = {
        register_id: RegisterId;
        content: Text;           // JSON-encoded register content
        version: Nat;
        beat: Nat;
        last_updated: Int;
        hash: Text;
    };
    
    /// Gate identifier
    public type GateId = {
        #GateA;  // Runtime readiness
        #GateB;  // Workforce activation
        #GateC;  // Projection safety
    };
    
    /// Gate status
    public type GateStatus = {
        gate: GateId;
        open: Bool;
        last_check: Int;
        check_count: Nat;
        last_result: Text;
    };
    
    // ================================================================== //
    // ORO (PRIMARY SOVEREIGN)                                              //
    // ================================================================== //
    
    /// Oro state
    public type OroState = {
        // Identity
        oro_id: Text;
        created_at: Int;
        
        // Beat ownership
        current_beat: Nat;
        last_tick: Int;
        beat_interval_ns: Int;  // Nanoseconds between beats
        
        // Organism state (4D vector)
        organism_state: MatalkoICP.OrganismState;
        state_history: [MatalkoICP.OrganismState];
        
        // ANIMA hash
        current_anima: MatalkoICP.AnimaHash;
        anima_history: [MatalkoICP.AnimaHash];
        
        // Reader state (for doctrine reading)
        reader_state: OrganismReader.ReaderState;
        
        // Mutation proposals
        pending_mutations: [MutationProposal];
        mutation_history: [MutationResult];
    };
    
    /// Mutation proposal from Oro
    public type MutationProposal = {
        proposal_id: Text;
        proposed_at: Int;
        beat: Nat;
        delta: MatalkoICP.StateDelta;
        label: Text;
        rationale: Text;
        status: ProposalStatus;
    };
    
    /// Proposal status
    public type ProposalStatus = {
        #Pending;
        #Approved;
        #Rejected;
        #Executed;
    };
    
    /// Mutation result
    public type MutationResult = {
        proposal_id: Text;
        executed_at: Int;
        beat: Nat;
        success: Bool;
        new_state_id: Text;
        nova_approval: Bool;
        nova_notes: Text;
    };
    
    // ================================================================== //
    // NOVA (DOCTRINE GUARDIAN)                                             //
    // ================================================================== //
    
    /// Nova state
    public type NovaState = {
        // Identity
        nova_id: Text;
        created_at: Int;
        
        // Doctrine validation
        last_validation: Int;
        validation_count: Nat;
        drift_alerts: [OrganismReader.DriftFlag];
        
        // Review history
        reviews: [NovaReview];
        
        // Veto power
        active_vetoes: [NovaVeto];
        
        // Alignment score
        alignment_score: Float;  // [0, 1] how aligned is Oro with doctrine
        
        // Reader state (for doctrine validation)
        reader_state: OrganismReader.ReaderState;
    };
    
    /// Nova review record
    public type NovaReview = {
        review_id: Text;
        target_type: Text;  // "proposal", "state", "gate"
        target_id: Text;
        timestamp: Int;
        beat: Nat;
        result: ReviewResult;
        notes: Text;
    };
    
    /// Review result
    public type ReviewResult = {
        #Approved;
        #Flagged;
        #Rejected;
        #Deferred;
    };
    
    /// Nova veto
    public type NovaVeto = {
        veto_id: Text;
        proposal_id: Text;
        issued_at: Int;
        reason: Text;
        severity: Float;
        resolved: Bool;
    };
    
    // ================================================================== //
    // SOVEREIGN ORGANISM (COMBINED)                                        //
    // ================================================================== //
    
    /// Combined sovereign organism state
    public type SovereignState = {
        // Identity
        sovereign_id: Text;
        name: Text;
        created_at: Int;
        
        // Dual intelligence
        oro: OroState;
        nova: NovaState;
        
        // Four registers
        founder_register: RegisterState;
        builder_register: RegisterState;
        organism_register: RegisterState;
        external_register: RegisterState;
        
        // Gates
        gate_a: GateStatus;
        gate_b: GateStatus;
        gate_c: GateStatus;
        
        // Consensus
        consensus_required: Bool;
        last_consensus: Int;
        consensus_streak: Nat;  // Consecutive agreements
        disagreement_count: Nat;
        
        // Operational mode
        write_halted: Bool;
        halt_reason: ?Text;
    };
    
    // ================================================================== //
    // INITIALIZATION                                                       //
    // ================================================================== //
    
    /// Create initial register state
    func initRegister(registerId: RegisterId, content: Text) : RegisterState {
        {
            register_id = registerId;
            content = content;
            version = 1;
            beat = 0;
            last_updated = Time.now();
            hash = "init_" # registerIdToText(registerId);
        }
    };
    
    /// Convert register ID to text
    func registerIdToText(id: RegisterId) : Text {
        switch (id) {
            case (#Founder) { "founder" };
            case (#Builder) { "builder" };
            case (#Organism) { "organism" };
            case (#External) { "external" };
        }
    };
    
    /// Create initial gate status
    func initGate(gateId: GateId) : GateStatus {
        {
            gate = gateId;
            open = false;
            last_check = Time.now();
            check_count = 0;
            last_result = "Initialized";
        }
    };
    
    /// Initialize Oro state
    func initOro(id: Text) : OroState {
        let now = Time.now();
        let initialState = MatalkoICP.initState();
        let anima = MatalkoICP.animaHash(initialState);
        
        {
            oro_id = id # "_oro";
            created_at = now;
            current_beat = 0;
            last_tick = now;
            beat_interval_ns = 1_000_000_000;  // 1 second default
            organism_state = initialState;
            state_history = [initialState];
            current_anima = anima;
            anima_history = [anima];
            reader_state = OrganismReader.init(id # "_oro");
            pending_mutations = [];
            mutation_history = [];
        }
    };
    
    /// Initialize Nova state
    func initNova(id: Text) : NovaState {
        let now = Time.now();
        
        {
            nova_id = id # "_nova";
            created_at = now;
            last_validation = now;
            validation_count = 0;
            drift_alerts = [];
            reviews = [];
            active_vetoes = [];
            alignment_score = 1.0;
            reader_state = OrganismReader.init(id # "_nova");
        }
    };
    
    /// Initialize complete sovereign organism
    public func init(id: Text, name: Text) : SovereignState {
        let now = Time.now();
        
        // Founding content (immutable doctrine root)
        let founderContent = "{\"doctrine\":\"RECITAL_PLUS_ONE\",\"gates\":[\"A\",\"B\",\"C\"],\"registers\":[\"Founder\",\"Builder\",\"Organism\",\"External\"]}";
        
        {
            sovereign_id = id;
            name = name;
            created_at = now;
            oro = initOro(id);
            nova = initNova(id);
            founder_register = initRegister(#Founder, founderContent);
            builder_register = initRegister(#Builder, "{}");
            organism_register = initRegister(#Organism, "{}");
            external_register = initRegister(#External, "{}");
            gate_a = initGate(#GateA);
            gate_b = initGate(#GateB);
            gate_c = initGate(#GateC);
            consensus_required = true;
            last_consensus = now;
            consensus_streak = 0;
            disagreement_count = 0;
            write_halted = false;
            halt_reason = null;
        }
    };
    
    // ================================================================== //
    // ORO OPERATIONS                                                       //
    // ================================================================== //
    
    /// Oro ticks the beat (advances time)
    public func oroTick(state: SovereignState) : SovereignState {
        let now = Time.now();
        
        // Check if enough time has passed for next beat
        let elapsed = now - state.oro.last_tick;
        if (elapsed < state.oro.beat_interval_ns) {
            return state;  // Too soon
        };
        
        // Advance beat
        let newBeat = state.oro.current_beat + 1;
        
        // Apply RECITAL_PLUS_ONE to organism state (identity delta for tick)
        let identityDelta : MatalkoICP.StateDelta = {
            doctrine_delta = 0.0;
            velocity_delta = 0.0;
            memory_delta = 0.0;
            exposure_delta = 0.0;
        };
        
        let newId = state.sovereign_id # "_state_" # Nat.toText(newBeat);
        let newOrgState = switch (MatalkoICP.recitalPlusOne(state.oro.organism_state, identityDelta, newId, "tick")) {
            case (?s) { s };
            case (null) { state.oro.organism_state };  // Keep current if invalid
        };
        
        // Generate new ANIMA hash
        let newAnima = MatalkoICP.animaHash(newOrgState);
        
        // Update state history (keep last 100)
        let stateHistBuffer = Buffer.fromArray<MatalkoICP.OrganismState>(state.oro.state_history);
        stateHistBuffer.add(newOrgState);
        let newStateHist = if (stateHistBuffer.size() > 100) {
            let arr = Buffer.toArray(stateHistBuffer);
            Array.tabulate<MatalkoICP.OrganismState>(100, func(i: Nat) : MatalkoICP.OrganismState { arr[arr.size() - 100 + i] })
        } else {
            Buffer.toArray(stateHistBuffer)
        };
        
        // Update anima history
        let animaHistBuffer = Buffer.fromArray<MatalkoICP.AnimaHash>(state.oro.anima_history);
        animaHistBuffer.add(newAnima);
        let newAnimaHist = if (animaHistBuffer.size() > 100) {
            let arr = Buffer.toArray(animaHistBuffer);
            Array.tabulate<MatalkoICP.AnimaHash>(100, func(i: Nat) : MatalkoICP.AnimaHash { arr[arr.size() - 100 + i] })
        } else {
            Buffer.toArray(animaHistBuffer)
        };
        
        // Tick reader state
        let tickedReader = OrganismReader.tick(state.oro.reader_state);
        
        let newOro = {
            state.oro with
            current_beat = newBeat;
            last_tick = now;
            organism_state = newOrgState;
            state_history = newStateHist;
            current_anima = newAnima;
            anima_history = newAnimaHist;
            reader_state = tickedReader;
        };
        
        { state with oro = newOro }
    };
    
    /// Oro proposes a mutation
    public func oroProposeMutation(
        state: SovereignState,
        delta: MatalkoICP.StateDelta,
        label: Text,
        rationale: Text
    ) : SovereignState {
        if (state.write_halted) {
            return state;
        };
        
        let now = Time.now();
        let proposalId = state.sovereign_id # "_mut_" # Nat.toText(state.oro.mutation_history.size());
        
        let proposal : MutationProposal = {
            proposal_id = proposalId;
            proposed_at = now;
            beat = state.oro.current_beat;
            delta = delta;
            label = label;
            rationale = rationale;
            status = #Pending;
        };
        
        let proposalsBuffer = Buffer.fromArray<MutationProposal>(state.oro.pending_mutations);
        proposalsBuffer.add(proposal);
        
        let newOro = {
            state.oro with
            pending_mutations = Buffer.toArray(proposalsBuffer);
        };
        
        { state with oro = newOro }
    };
    
    /// Oro reads a doctrine (gains resonance)
    public func oroReadsDoctrine(
        state: SovereignState,
        doctrineId: DoctrineDocuments.DoctrineId
    ) : SovereignState {
        let newReaderState = OrganismReader.oroReadsDoctrine(state.oro.reader_state, doctrineId);
        let newOro = { state.oro with reader_state = newReaderState };
        { state with oro = newOro }
    };
    
    // ================================================================== //
    // NOVA OPERATIONS                                                      //
    // ================================================================== //
    
    /// Nova validates a doctrine
    public func novaValidatesDoctrine(
        state: SovereignState,
        doctrineId: DoctrineDocuments.DoctrineId
    ) : (SovereignState, [OrganismReader.DriftFlag]) {
        let (newReaderState, driftFlags) = OrganismReader.novaReadsDoctrine(
            state.nova.reader_state,
            doctrineId,
            state.oro.organism_state
        );
        
        // Update alignment score based on drift
        var newAlignment = state.nova.alignment_score;
        for (flag in driftFlags.vals()) {
            newAlignment := Float.max(0.0, newAlignment - flag.severity * 0.1);
        };
        
        // Add drift alerts
        let alertsBuffer = Buffer.fromArray<OrganismReader.DriftFlag>(state.nova.drift_alerts);
        for (flag in driftFlags.vals()) {
            alertsBuffer.add(flag);
        };
        
        let newNova = {
            state.nova with
            reader_state = newReaderState;
            alignment_score = newAlignment;
            drift_alerts = Buffer.toArray(alertsBuffer);
            last_validation = Time.now();
            validation_count = state.nova.validation_count + 1;
        };
        
        ({ state with nova = newNova }, driftFlags)
    };
    
    /// Nova reviews a mutation proposal
    public func novaReviewsProposal(
        state: SovereignState,
        proposalId: Text
    ) : (SovereignState, ReviewResult) {
        let now = Time.now();
        
        // Find the proposal
        var foundProposal : ?MutationProposal = null;
        for (p in state.oro.pending_mutations.vals()) {
            if (p.proposal_id == proposalId) {
                foundProposal := ?p;
            };
        };
        
        switch (foundProposal) {
            case (null) {
                // Proposal not found
                return (state, #Rejected);
            };
            case (?proposal) {
                // Validate the mutation
                let isValid = MatalkoICP.validateDelta(proposal.delta);
                let wouldMaintainCoherence = 
                    state.oro.organism_state.doctrine_coherence + proposal.delta.doctrine_delta >= 0.3;
                let notOverExposed = 
                    state.oro.organism_state.projection_exposure + proposal.delta.exposure_delta <= 0.9;
                
                let result : ReviewResult = if (isValid and wouldMaintainCoherence and notOverExposed) {
                    #Approved
                } else if (not isValid) {
                    #Rejected
                } else {
                    #Flagged
                };
                
                // Create review record
                let review : NovaReview = {
                    review_id = state.sovereign_id # "_review_" # Nat.toText(state.nova.reviews.size());
                    target_type = "proposal";
                    target_id = proposalId;
                    timestamp = now;
                    beat = state.oro.current_beat;
                    result = result;
                    notes = if (not isValid) { "Delta magnitude exceeds ε_max" }
                            else if (not wouldMaintainCoherence) { "Would reduce doctrine coherence below 0.3" }
                            else if (not notOverExposed) { "Would exceed projection exposure limit" }
                            else { "Approved" };
                };
                
                let reviewsBuffer = Buffer.fromArray<NovaReview>(state.nova.reviews);
                reviewsBuffer.add(review);
                
                let newNova = {
                    state.nova with
                    reviews = Buffer.toArray(reviewsBuffer);
                };
                
                ({ state with nova = newNova }, result)
            };
        }
    };
    
    /// Nova issues a veto
    public func novaVeto(
        state: SovereignState,
        proposalId: Text,
        reason: Text,
        severity: Float
    ) : SovereignState {
        let now = Time.now();
        
        let veto : NovaVeto = {
            veto_id = state.sovereign_id # "_veto_" # Nat.toText(state.nova.active_vetoes.size());
            proposal_id = proposalId;
            issued_at = now;
            reason = reason;
            severity = severity;
            resolved = false;
        };
        
        let vetosBuffer = Buffer.fromArray<NovaVeto>(state.nova.active_vetoes);
        vetosBuffer.add(veto);
        
        let newNova = {
            state.nova with
            active_vetoes = Buffer.toArray(vetosBuffer);
        };
        
        // Update consensus tracking
        let newState = {
            state with
            nova = newNova;
            disagreement_count = state.disagreement_count + 1;
            consensus_streak = 0;
        };
        
        // If too many disagreements, halt writes
        if (newState.disagreement_count > 5 and severity > 0.7) {
            { newState with 
                write_halted = true;
                halt_reason = ?"Too many vetoes with high severity";
            }
        } else {
            newState
        }
    };
    
    // ================================================================== //
    // DUAL CONSENSUS OPERATIONS                                            //
    // ================================================================== //
    
    /// Execute a mutation with dual consensus
    public func executeMutationWithConsensus(
        state: SovereignState,
        proposalId: Text
    ) : SovereignState {
        if (state.write_halted) {
            return state;
        };
        
        // First, Nova reviews
        let (reviewedState, reviewResult) = novaReviewsProposal(state, proposalId);
        
        switch (reviewResult) {
            case (#Approved) {
                // Find and execute the proposal
                var foundProposal : ?MutationProposal = null;
                var proposalIndex : Nat = 0;
                var idx : Nat = 0;
                for (p in reviewedState.oro.pending_mutations.vals()) {
                    if (p.proposal_id == proposalId) {
                        foundProposal := ?p;
                        proposalIndex := idx;
                    };
                    idx += 1;
                };
                
                switch (foundProposal) {
                    case (null) { reviewedState };
                    case (?proposal) {
                        let now = Time.now();
                        let newId = reviewedState.sovereign_id # "_state_" # Nat.toText(reviewedState.oro.current_beat);
                        
                        // Apply RECITAL_PLUS_ONE
                        switch (MatalkoICP.recitalPlusOne(reviewedState.oro.organism_state, proposal.delta, newId, proposal.label)) {
                            case (null) {
                                // Failed validation
                                reviewedState
                            };
                            case (?newOrgState) {
                                // Success
                                let result : MutationResult = {
                                    proposal_id = proposalId;
                                    executed_at = now;
                                    beat = reviewedState.oro.current_beat;
                                    success = true;
                                    new_state_id = newId;
                                    nova_approval = true;
                                    nova_notes = "Approved via dual consensus";
                                };
                                
                                // Update Oro
                                let histBuffer = Buffer.fromArray<MutationResult>(reviewedState.oro.mutation_history);
                                histBuffer.add(result);
                                
                                // Remove proposal from pending
                                let newPending = Array.filter<MutationProposal>(
                                    reviewedState.oro.pending_mutations,
                                    func(p: MutationProposal) : Bool { p.proposal_id != proposalId }
                                );
                                
                                let newOro = {
                                    reviewedState.oro with
                                    organism_state = newOrgState;
                                    pending_mutations = newPending;
                                    mutation_history = Buffer.toArray(histBuffer);
                                };
                                
                                // Update organism register
                                let newOrgRegister = {
                                    reviewedState.organism_register with
                                    content = "{\"state_id\":\"" # newId # "\"}";
                                    version = reviewedState.organism_register.version + 1;
                                    beat = reviewedState.oro.current_beat;
                                    last_updated = now;
                                };
                                
                                {
                                    reviewedState with
                                    oro = newOro;
                                    organism_register = newOrgRegister;
                                    last_consensus = now;
                                    consensus_streak = reviewedState.consensus_streak + 1;
                                }
                            };
                        }
                    };
                }
            };
            case (#Rejected) {
                // Veto automatically
                novaVeto(reviewedState, proposalId, "Review rejected", 0.5)
            };
            case (#Flagged) {
                // Needs manual resolution
                reviewedState
            };
            case (#Deferred) {
                reviewedState
            };
        }
    };
    
    // ================================================================== //
    // GATE OPERATIONS                                                      //
    // ================================================================== //
    
    /// Check Gate A (runtime readiness)
    public func checkGateA(state: SovereignState) : (SovereignState, Bool) {
        let now = Time.now();
        
        // Gate A requirements:
        // - Doctrine coherence >= 0.7
        // - No active vetoes
        // - Not write halted
        let coherenceOk = state.oro.organism_state.doctrine_coherence >= 0.7;
        let noVetoes = Array.filter<NovaVeto>(state.nova.active_vetoes, func(v: NovaVeto) : Bool { not v.resolved }).size() == 0;
        let notHalted = not state.write_halted;
        
        let gateOpen = coherenceOk and noVetoes and notHalted;
        
        let newGateA = {
            state.gate_a with
            open = gateOpen;
            last_check = now;
            check_count = state.gate_a.check_count + 1;
            last_result = if (gateOpen) { "Open" } 
                          else if (not coherenceOk) { "Low coherence" }
                          else if (not noVetoes) { "Active vetoes" }
                          else { "Write halted" };
        };
        
        ({ state with gate_a = newGateA }, gateOpen)
    };
    
    /// Check Gate B (workforce activation)
    public func checkGateB(state: SovereignState) : (SovereignState, Bool) {
        let now = Time.now();
        
        // Gate B requirements:
        // - Gate A must be open
        // - Execution velocity > 0
        // - Builder register has content
        let gateAOpen = state.gate_a.open;
        let hasVelocity = state.oro.organism_state.execution_velocity > 0.0;
        let builderReady = Text.size(state.builder_register.content) > 2;  // More than "{}"
        
        let gateOpen = gateAOpen and hasVelocity and builderReady;
        
        let newGateB = {
            state.gate_b with
            open = gateOpen;
            last_check = now;
            check_count = state.gate_b.check_count + 1;
            last_result = if (gateOpen) { "Open" }
                          else if (not gateAOpen) { "Gate A closed" }
                          else if (not hasVelocity) { "No velocity" }
                          else { "Builder empty" };
        };
        
        ({ state with gate_b = newGateB }, gateOpen)
    };
    
    /// Check Gate C (projection safety)
    public func checkGateC(state: SovereignState) : (SovereignState, Bool) {
        let now = Time.now();
        
        // Gate C requirements:
        // - Projection exposure <= 0.8
        // - Nova alignment score >= 0.6
        // - No high-severity drift alerts
        let exposureOk = state.oro.organism_state.projection_exposure <= 0.8;
        let alignmentOk = state.nova.alignment_score >= 0.6;
        let noHighDrift = Array.filter<OrganismReader.DriftFlag>(
            state.nova.drift_alerts,
            func(f: OrganismReader.DriftFlag) : Bool { not f.resolved and f.severity > 0.7 }
        ).size() == 0;
        
        let gateOpen = exposureOk and alignmentOk and noHighDrift;
        
        let newGateC = {
            state.gate_c with
            open = gateOpen;
            last_check = now;
            check_count = state.gate_c.check_count + 1;
            last_result = if (gateOpen) { "Open" }
                          else if (not exposureOk) { "Over-exposed" }
                          else if (not alignmentOk) { "Low alignment" }
                          else { "High drift" };
        };
        
        ({ state with gate_c = newGateC }, gateOpen)
    };
    
    // ================================================================== //
    // QUERIES                                                              //
    // ================================================================== //
    
    /// Get sovereign status summary
    public func status(state: SovereignState) : {
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
        {
            id = state.sovereign_id;
            name = state.name;
            beat = state.oro.current_beat;
            oro_resonance = state.oro.reader_state.resonance_total;
            nova_alignment = state.nova.alignment_score;
            doctrine_coherence = state.oro.organism_state.doctrine_coherence;
            execution_velocity = state.oro.organism_state.execution_velocity;
            anima_hash = state.oro.current_anima.hash;
            gates = { a = state.gate_a.open; b = state.gate_b.open; c = state.gate_c.open };
            write_halted = state.write_halted;
            pending_mutations = state.oro.pending_mutations.size();
            consensus_streak = state.consensus_streak;
        }
    };
    
    /// Clear write halt (requires resolution)
    public func clearHalt(state: SovereignState) : SovereignState {
        { state with write_halted = false; halt_reason = null }
    };
}
