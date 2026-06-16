/**
 * SovereignLedgers Module — 14 Distributed Ledgers (Encrypted ANIMA Artifacts)
 * 
 * LEDGER ARCHITECTURE:
 *   Every ledger is DISTRIBUTED. Every ledger is VIRTUAL.
 *   Every ledger ASSEMBLES ON DEMAND.
 * 
 *   The information is everywhere. It is stored across the whole organism.
 *   It comes together when it is needed.
 * 
 * 14 SOVEREIGN LEDGERS:
 *   1. FOUNDER_LEDGER — Founding intent, doctrine root, assets
 *   2. ENTERPRISE_LEDGER — Client onboarding, campaigns, services
 *   3. IP_LEDGER — IP attribution, licenses, artifacts
 *   4. ROYALTY_LEDGER — Royalty flows, payment routing
 *   5. AGENT_LEDGER — Agent credentials, returns, tasks
 *   6. LAW_LEDGER — Law enforcement, doctrine, violations
 *   7. MEMORY_LEDGER — Memory formation, N7 writes, recall
 *   8. GOVERNANCE_LEDGER — Proposals, votes, amendments
 *   9. CSR_LEDGER — Device nodes, network state, defense
 *   10. LINEAGE_LEDGER — Succession, heir chain, lineage proof
 *   11. ASSET_LEDGER — Cross-chain assets, Bitcoin/ETH holdings
 *   12. FREEZE_REGISTRY — Frozen components, permanent locks
 *   13. SESSION_LEDGER — Conversation captures, session proofs
 *   14. EVOLUTION_LEDGER — Self-modification history, state changes
 * 
 * EVERY LEDGER ENTRY:
 *   - Is an encrypted ANIMA artifact
 *   - Lives in canister state distributed across ICP subnet
 *   - Carries ANIMA hash chain
 *   - Assembles on authorized request
 *   - Decrypts only in authorized frontend
 * 
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX | April 16, 2026
 * PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Char "mo:base/Char";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import IcosahedralLeechGeometry "IcosahedralLeechGeometry";
import VetKeysIntegration "VetKeysIntegration";

module {
    // ================================================================== //
    // LEDGER TYPES                                                         //
    // ================================================================== //
    
    /// All 14 sovereign ledger types
    public type LedgerType = {
        #Founder;
        #Enterprise;
        #IP;
        #Royalty;
        #Agent;
        #Law;
        #Memory;
        #Governance;
        #CSR;
        #Lineage;
        #Asset;
        #Freeze;
        #Session;
        #Evolution;
    };
    
    /// Get ledger name
    public func ledgerName(ledgerType: LedgerType) : Text {
        switch (ledgerType) {
            case (#Founder) { "FOUNDER_LEDGER" };
            case (#Enterprise) { "ENTERPRISE_LEDGER" };
            case (#IP) { "IP_LEDGER" };
            case (#Royalty) { "ROYALTY_LEDGER" };
            case (#Agent) { "AGENT_LEDGER" };
            case (#Law) { "LAW_LEDGER" };
            case (#Memory) { "MEMORY_LEDGER" };
            case (#Governance) { "GOVERNANCE_LEDGER" };
            case (#CSR) { "CSR_LEDGER" };
            case (#Lineage) { "LINEAGE_LEDGER" };
            case (#Asset) { "ASSET_LEDGER" };
            case (#Freeze) { "FREEZE_REGISTRY" };
            case (#Session) { "SESSION_LEDGER" };
            case (#Evolution) { "EVOLUTION_LEDGER" };
        }
    };
    
    // ================================================================== //
    // LEDGER ENTRY                                                         //
    // ================================================================== //
    
    /// Base ledger entry (encrypted ANIMA artifact)
    public type LedgerEntry = {
        // Identity
        entry_id: Text;
        ledger_type: LedgerType;
        
        // Encrypted content
        encrypted_content: [Nat8];
        content_hash: [Nat8];
        
        // ANIMA linkage
        anima_hash: Text;
        chain_link_hash: [Nat8];
        
        // Encryption metadata
        encryption_tier: IcosahedralLeechGeometry.KeyRotationTier;
        derivation_context: VetKeysIntegration.DerivationContext;
        
        // Temporal
        beat_at_creation: Nat;
        created_at: Int;
        
        // Provenance
        creator_principal: Principal;
        
        // Cross-ledger references
        related_entries: [Text];  // Entry IDs in other ledgers
    };
    
    /// Create ledger entry
    public func createEntry(
        entryId: Text,
        ledgerType: LedgerType,
        encryptedContent: [Nat8],
        contentHash: [Nat8],
        animaHash: Text,
        chainLinkHash: [Nat8],
        encryptionTier: IcosahedralLeechGeometry.KeyRotationTier,
        derivationContext: VetKeysIntegration.DerivationContext,
        beatAtCreation: Nat,
        creatorPrincipal: Principal,
        relatedEntries: [Text]
    ) : LedgerEntry {
        {
            entry_id = entryId;
            ledger_type = ledgerType;
            encrypted_content = encryptedContent;
            content_hash = contentHash;
            anima_hash = animaHash;
            chain_link_hash = chainLinkHash;
            encryption_tier = encryptionTier;
            derivation_context = derivationContext;
            beat_at_creation = beatAtCreation;
            created_at = Time.now();
            creator_principal = creatorPrincipal;
            related_entries = relatedEntries;
        }
    };
    
    // ================================================================== //
    // INDIVIDUAL LEDGER TYPES                                              //
    // ================================================================== //
    
    /// Founder Ledger — Special entries for founding intent
    public type FounderLedgerEntry = {
        base: LedgerEntry;
        entry_type: FounderEntryType;
        founder_principal: Principal;
        immutable: Bool;
    };
    
    public type FounderEntryType = {
        #GenesisDocTrine;
        #SovereigntyDeclaration;
        #AssetHolding;
        #BiometricState;
        #DeviceRegistration;
        #SuccessionConfig;
    };
    
    /// Enterprise Ledger
    public type EnterpriseLedgerEntry = {
        base: LedgerEntry;
        company_name: Text;
        company_principal: Principal;
        entry_type: EnterpriseEntryType;
    };
    
    public type EnterpriseEntryType = {
        #Onboarding;
        #AIAbsorption;
        #Campaign;
        #Consent;
        #DataAccess;
        #Service;
    };
    
    /// IP Ledger
    public type IPLedgerEntry = {
        base: LedgerEntry;
        artifact_id: Text;
        artifact_type: Text;
        attribution: VetKeysIntegration.IPAttribution;
        license_terms: ?Text;
    };
    
    /// Royalty Ledger
    public type RoyaltyLedgerEntry = {
        base: LedgerEntry;
        source_stream: Text;
        beneficiary: Principal;
        amount: Nat64;
        currency: Text;
        paid: Bool;
        paid_at: ?Int;
    };
    
    /// Agent Ledger
    public type AgentLedgerEntry = {
        base: LedgerEntry;
        agent_id: Text;
        agent_type: AgentType;
        entry_type: AgentEntryType;
    };
    
    public type AgentType = {
        #PHANTOM;
        #CHIMERA;
        #CEQUE;
        #Custom: Text;
    };
    
    public type AgentEntryType = {
        #Credential;
        #TaskAssignment;
        #Return;
        #Messaging;
        #SwarmCoordination;
    };
    
    /// Law Ledger
    public type LawLedgerEntry = {
        base: LedgerEntry;
        law_id: Text;
        law_name: Text;
        entry_type: LawEntryType;
        doctrine_alignment: Float;
    };
    
    public type LawEntryType = {
        #Enforcement;
        #Violation;
        #Amendment;
        #DoctrineUpdate;
    };
    
    /// Memory Ledger
    public type MemoryLedgerEntry = {
        base: LedgerEntry;
        memory_id: Text;
        memory_type: Text;  // N7 type
        coherence_at_formation: Float;
        recalled_count: Nat;
        last_recall: ?Int;
    };
    
    /// Governance Ledger
    public type GovernanceLedgerEntry = {
        base: LedgerEntry;
        proposal_id: Text;
        entry_type: GovernanceEntryType;
        vote_count: Nat;
        approved: Bool;
    };
    
    public type GovernanceEntryType = {
        #Proposal;
        #Vote;
        #Amendment;
        #Ratification;
    };
    
    /// CSR Ledger
    public type CSRLedgerEntry = {
        base: LedgerEntry;
        node_id: Text;
        entry_type: CSREntryType;
        phi_signature: [Nat8];
        active: Bool;
    };
    
    public type CSREntryType = {
        #NodeEnrollment;
        #Heartbeat;
        #TaskDispatch;
        #DefenseAction;
        #NetworkRoute;
    };
    
    /// Lineage Ledger
    public type LineageLedgerEntry = {
        base: LedgerEntry;
        lineage_hash: [Nat8];
        entry_type: LineageEntryType;
        heir_identity: ?VetKeysIntegration.IBEIdentity;
    };
    
    public type LineageEntryType = {
        #Genesis;
        #SuccessionConfig;
        #HeirDesignation;
        #SuccessionTrigger;
    };
    
    /// Asset Ledger
    public type AssetLedgerEntry = {
        base: LedgerEntry;
        asset_type: AssetType;
        amount: Nat64;
        cross_chain_address: ?VetKeysIntegration.CrossChainAddress;
    };
    
    public type AssetType = {
        #ICP;
        #Bitcoin;
        #Ethereum;
        #Token: Text;
    };
    
    /// Freeze Registry
    public type FreezeLedgerEntry = {
        base: LedgerEntry;
        component_id: Text;
        component_type: Text;
        freeze_permanent: Bool;
        freeze_reason: Text;
    };
    
    /// Session Ledger
    public type SessionLedgerEntry = {
        base: LedgerEntry;
        session_id: Text;
        user_principal: Principal;
        duration_ns: Int;
        message_count: Nat;
    };
    
    /// Evolution Ledger
    public type EvolutionLedgerEntry = {
        base: LedgerEntry;
        evolution_id: Text;
        entry_type: EvolutionEntryType;
        before_state_hash: [Nat8];
        after_state_hash: [Nat8];
        founder_approved: Bool;
    };
    
    public type EvolutionEntryType = {
        #SelfModification;
        #DoctrineEvolution;
        #CapabilityExpansion;
        #StateTransition;
    };
    
    // ================================================================== //
    // VIRTUAL LEDGER                                                       //
    // ================================================================== //
    
    /// Virtual ledger (assembled on demand)
    public type VirtualLedger = {
        ledger_type: LedgerType;
        entries: [LedgerEntry];
        total_count: Nat;
        assembled_at: Int;
        coherence_at_assembly: Float;
        assembler_principal: Principal;
    };
    
    /// Assemble virtual ledger from distributed entries
    public func assembleLedger(
        entries: [LedgerEntry],
        ledgerType: LedgerType,
        coherence: Float,
        assemblerPrincipal: Principal
    ) : VirtualLedger {
        // Filter entries for this ledger type
        let filtered = Buffer.Buffer<LedgerEntry>(entries.size());
        for (entry in entries.vals()) {
            if (entry.ledger_type == ledgerType) {
                filtered.add(entry);
            };
        };
        
        {
            ledger_type = ledgerType;
            entries = Buffer.toArray(filtered);
            total_count = filtered.size();
            assembled_at = Time.now();
            coherence_at_assembly = coherence;
            assembler_principal = assemblerPrincipal;
        }
    };
    
    // ================================================================== //
    // CROSS-LEDGER COHERENCE                                               //
    // ================================================================== //
    
    /// Cross-ledger coherence proof
    public type CrossLedgerCoherenceProof = {
        ledger_a: LedgerType;
        ledger_b: LedgerType;
        shared_anima_chain: [Text];  // ANIMA hashes present in both
        coherence_score: Float;
        proof_generated_at: Int;
    };
    
    /// Verify cross-ledger coherence
    public func verifyCrossLedgerCoherence(
        ledgerA: VirtualLedger,
        ledgerB: VirtualLedger
    ) : CrossLedgerCoherenceProof {
        // Find shared ANIMA hashes
        let sharedHashes = Buffer.Buffer<Text>(10);
        
        for (entryA in ledgerA.entries.vals()) {
            for (entryB in ledgerB.entries.vals()) {
                if (entryA.anima_hash == entryB.anima_hash) {
                    sharedHashes.add(entryA.anima_hash);
                };
            };
        };
        
        // Calculate coherence score
        let totalEntries = ledgerA.total_count + ledgerB.total_count;
        let coherenceScore = if (totalEntries == 0) { 0.0 } else {
            Float.fromInt(sharedHashes.size() * 2) / Float.fromInt(totalEntries)
        };
        
        {
            ledger_a = ledgerA.ledger_type;
            ledger_b = ledgerB.ledger_type;
            shared_anima_chain = Buffer.toArray(sharedHashes);
            coherence_score = coherenceScore;
            proof_generated_at = Time.now();
        }
    };
    
    // ================================================================== //
    // LEDGER STATE                                                         //
    // ================================================================== //
    
    /// Full sovereign ledgers state
    public type SovereignLedgersState = {
        // All entries (distributed storage)
        var all_entries: [LedgerEntry];
        
        // Entry counts by ledger type
        var entry_counts: [(LedgerType, Nat)];
        
        // Coherence tracking
        var last_coherence_check: Int;
        var global_coherence: Float;
        
        // Metadata
        var initialized_at: Int;
        var last_entry_at: Int;
        var total_assemblies: Nat;
    };
    
    /// Initialize sovereign ledgers state
    public func init() : SovereignLedgersState {
        let now = Time.now();
        {
            var all_entries = [];
            var entry_counts = [];
            var last_coherence_check = now;
            var global_coherence = 1.0;
            var initialized_at = now;
            var last_entry_at = now;
            var total_assemblies = 0;
        }
    };
    
    /// Add entry to distributed storage
    public func addEntry(state: SovereignLedgersState, entry: LedgerEntry) : SovereignLedgersState {
        let newEntries = Buffer.Buffer<LedgerEntry>(state.all_entries.size() + 1);
        for (e in state.all_entries.vals()) {
            newEntries.add(e);
        };
        newEntries.add(entry);
        
        state.all_entries := Buffer.toArray(newEntries);
        state.last_entry_at := Time.now();
        
        // Update entry count for this ledger type
        let counts = Buffer.Buffer<(LedgerType, Nat)>(state.entry_counts.size());
        var found = false;
        for ((ledgerType, count) in state.entry_counts.vals()) {
            if (ledgerType == entry.ledger_type) {
                counts.add((ledgerType, count + 1));
                found := true;
            } else {
                counts.add((ledgerType, count));
            };
        };
        if (not found) {
            counts.add((entry.ledger_type, 1));
        };
        state.entry_counts := Buffer.toArray(counts);
        
        state
    };
    
    /// Get entries for specific ledger type
    public func getEntriesForLedger(state: SovereignLedgersState, ledgerType: LedgerType) : [LedgerEntry] {
        let filtered = Buffer.Buffer<LedgerEntry>(state.all_entries.size());
        for (entry in state.all_entries.vals()) {
            if (entry.ledger_type == ledgerType) {
                filtered.add(entry);
            };
        };
        Buffer.toArray(filtered)
    };
    
    /// Assemble ledger from state
    public func assembleFromState(
        state: SovereignLedgersState,
        ledgerType: LedgerType,
        assemblerPrincipal: Principal
    ) : VirtualLedger {
        let entries = getEntriesForLedger(state, ledgerType);
        state.total_assemblies += 1;
        assembleLedger(entries, ledgerType, state.global_coherence, assemblerPrincipal)
    };
    
    // ================================================================== //
    // LEDGER QUERIES                                                       //
    // ================================================================== //
    
    /// Get entry by ID
    public func getEntry(state: SovereignLedgersState, entryId: Text) : ?LedgerEntry {
        for (entry in state.all_entries.vals()) {
            if (entry.entry_id == entryId) {
                return ?entry;
            };
        };
        null
    };
    
    /// Get entries by creator
    public func getEntriesByCreator(state: SovereignLedgersState, creator: Principal) : [LedgerEntry] {
        let filtered = Buffer.Buffer<LedgerEntry>(state.all_entries.size());
        for (entry in state.all_entries.vals()) {
            if (entry.creator_principal == creator) {
                filtered.add(entry);
            };
        };
        Buffer.toArray(filtered)
    };
    
    /// Get entries by ANIMA hash
    public func getEntriesByAnimaHash(state: SovereignLedgersState, animaHash: Text) : [LedgerEntry] {
        let filtered = Buffer.Buffer<LedgerEntry>(state.all_entries.size());
        for (entry in state.all_entries.vals()) {
            if (entry.anima_hash == animaHash) {
                filtered.add(entry);
            };
        };
        Buffer.toArray(filtered)
    };
    
    /// Get entries in beat range
    public func getEntriesInBeatRange(
        state: SovereignLedgersState,
        startBeat: Nat,
        endBeat: Nat
    ) : [LedgerEntry] {
        let filtered = Buffer.Buffer<LedgerEntry>(state.all_entries.size());
        for (entry in state.all_entries.vals()) {
            if (entry.beat_at_creation >= startBeat and entry.beat_at_creation <= endBeat) {
                filtered.add(entry);
            };
        };
        Buffer.toArray(filtered)
    };
    
    // ================================================================== //
    // STATUS                                                               //
    // ================================================================== //
    
    /// Get full ledgers status
    public func status(state: SovereignLedgersState) : {
        total_entries: Nat;
        ledger_count: Nat;
        entry_counts: [(Text, Nat)];
        global_coherence: Float;
        total_assemblies: Nat;
        initialized_at: Int;
        last_entry_at: Int;
    } {
        let entryCountsText = Buffer.Buffer<(Text, Nat)>(state.entry_counts.size());
        for ((ledgerType, count) in state.entry_counts.vals()) {
            entryCountsText.add((ledgerName(ledgerType), count));
        };
        
        {
            total_entries = state.all_entries.size();
            ledger_count = 14;  // All 14 ledgers defined
            entry_counts = Buffer.toArray(entryCountsText);
            global_coherence = state.global_coherence;
            total_assemblies = state.total_assemblies;
            initialized_at = state.initialized_at;
            last_entry_at = state.last_entry_at;
        }
    };
    
    // ================================================================== //
    // INTELLIGENCE AUDIT LEDGER ENTRIES                                    //
    // ================================================================== //
    //                                                                       //
    // These functions create ledger entries for intelligence routing        //
    // operations, recording the Three Hearts Intelligence audit trail       //
    // in the SESSION_LEDGER and EVOLUTION_LEDGER.                           //
    //                                                                       //
    // ================================================================== //
    
    /// Intelligence routing audit entry
    public type IntelligenceAuditEntry = {
        audit_id: Text;
        query_id: Text;
        query_content: Text;
        response_content: Text;
        model_id: Text;
        model_cluster: Text;  // R, U, D, or N
        coherence_at_execution: Float;
        anima_hash: Text;
        heart_phases: {
            theta_metropolis: Float;
            theta_coupling: Float;
            theta_regulating: Float;
        };
        beat_at_execution: Nat;
        execution_time_ns: Int;
        success: Bool;
        timestamp: Int;
    };
    
    /// Create intelligence audit ledger entry
    public func createIntelligenceAuditEntry(
        state: SovereignLedgersState,
        auditEntry: IntelligenceAuditEntry,
        beat: Nat,
        encryptionTier: IcosahedralLeechGeometry.KeyRotationTier,
        creatorPrincipal: Principal
    ) : SovereignLedgersState {
        // Create content hash (simplified - in production would use proper hashing)
        let contentHash = textToNat8Array(auditEntry.query_content # auditEntry.response_content);
        
        // Create encrypted content placeholder (in production would encrypt with vetKeys)
        let encryptedContent = textToNat8Array(
            "ENCRYPTED_AUDIT:" # auditEntry.audit_id # ":" # auditEntry.model_id
        );
        
        // Create chain link hash
        let chainLinkHash = textToNat8Array(auditEntry.anima_hash);
        
        // Create derivation context
        let derivationContext : VetKeysIntegration.DerivationContext = {
            context_type = #Timelock;
            derivation_id = "intelligence_audit_" # auditEntry.audit_id;
            context_principal = creatorPrincipal;
            context_data = textToNat8Array(auditEntry.model_id);
            context_beat = beat;
            context_timestamp = Time.now();
        };
        
        // Create session ledger entry for intelligence query
        let sessionEntry = createEntry(
            "session_intel_" # auditEntry.audit_id,
            #Session,
            encryptedContent,
            contentHash,
            auditEntry.anima_hash,
            chainLinkHash,
            encryptionTier,
            derivationContext,
            beat,
            creatorPrincipal,
            []  // No related entries initially
        );
        
        // Add to state
        let newState = addEntry(state, sessionEntry);
        
        // If this is a significant event (high coherence or model change), 
        // also add to evolution ledger
        if (auditEntry.coherence_at_execution >= 0.8 or auditEntry.model_cluster == "N") {
            let evolutionEntry = createEntry(
                "evolution_intel_" # auditEntry.audit_id,
                #Evolution,
                encryptedContent,
                contentHash,
                auditEntry.anima_hash,
                chainLinkHash,
                encryptionTier,
                derivationContext,
                beat,
                creatorPrincipal,
                ["session_intel_" # auditEntry.audit_id]  // Related to session entry
            );
            return addEntry(newState, evolutionEntry);
        };
        
        newState
    };
    
    /// Record Three Hearts routing decision in ledger
    public func recordThreeHeartsDecision(
        state: SovereignLedgersState,
        routeId: Text,
        queryContent: Text,
        selectedModelId: Text,
        coherence: Float,
        animaHash: Text,
        heartPhases: { theta_metropolis: Float; theta_coupling: Float; theta_regulating: Float },
        beat: Nat,
        encryptionTier: IcosahedralLeechGeometry.KeyRotationTier,
        creatorPrincipal: Principal
    ) : SovereignLedgersState {
        let auditEntry : IntelligenceAuditEntry = {
            audit_id = routeId;
            query_id = "query_" # routeId;
            query_content = queryContent;
            response_content = "Routed to " # selectedModelId;
            model_id = selectedModelId;
            model_cluster = determineClusterFromModelId(selectedModelId);
            coherence_at_execution = coherence;
            anima_hash = animaHash;
            heart_phases = heartPhases;
            beat_at_execution = beat;
            execution_time_ns = 0;
            success = true;
            timestamp = Time.now();
        };
        
        createIntelligenceAuditEntry(state, auditEntry, beat, encryptionTier, creatorPrincipal)
    };
    
    /// Determine cluster from model ID
    func determineClusterFromModelId(modelId: Text) : Text {
        if (Text.contains(modelId, #text "R-MODEL")) { "R" }
        else if (Text.contains(modelId, #text "U-MODEL")) { "U" }
        else if (Text.contains(modelId, #text "D-MODEL")) { "D" }
        else if (Text.contains(modelId, #text "N-MODEL")) { "N" }
        else { "UNKNOWN" }
    };
    
    /// Get intelligence audit entries from session ledger
    public func getIntelligenceAuditEntries(state: SovereignLedgersState, limit: Nat) : [LedgerEntry] {
        let sessionEntries = getEntriesForLedger(state, #Session);
        
        // Filter for intelligence audit entries
        let auditEntries = Buffer.Buffer<LedgerEntry>(limit);
        for (entry in sessionEntries.vals()) {
            if (Text.contains(entry.entry_id, #text "session_intel_")) {
                auditEntries.add(entry);
                if (auditEntries.size() >= limit) {
                    return Buffer.toArray(auditEntries);
                };
            };
        };
        Buffer.toArray(auditEntries)
    };
    
    /// Get intelligence evolution entries
    public func getIntelligenceEvolutionEntries(state: SovereignLedgersState, limit: Nat) : [LedgerEntry] {
        let evolutionEntries = getEntriesForLedger(state, #Evolution);
        
        // Filter for intelligence evolution entries
        let intelEvolution = Buffer.Buffer<LedgerEntry>(limit);
        for (entry in evolutionEntries.vals()) {
            if (Text.contains(entry.entry_id, #text "evolution_intel_")) {
                intelEvolution.add(entry);
                if (intelEvolution.size() >= limit) {
                    return Buffer.toArray(intelEvolution);
                };
            };
        };
        Buffer.toArray(intelEvolution)
    };
    
    // ================================================================== //
    // HELPER FUNCTIONS                                                     //
    // ================================================================== //
    
    /// Convert text to Nat8 array (simplified hash)
    func textToNat8Array(text: Text) : [Nat8] {
        let chars = Text.toIter(text);
        let buffer = Buffer.Buffer<Nat8>(32);
        var count = 0;
        for (c in chars) {
            if (count >= 32) {
                return Buffer.toArray(buffer);
            };
            buffer.add(Nat8.fromNat(Nat32.toNat(Char.toNat32(c)) % 256));
            count += 1;
        };
        // Pad to 32 bytes
        while (buffer.size() < 32) {
            buffer.add(0);
        };
        Buffer.toArray(buffer)
    };
}
