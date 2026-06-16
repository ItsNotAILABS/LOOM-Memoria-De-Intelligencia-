/**
 * ╔═══════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                           ║
 * ║                              TOKEN LEDGER                                                 ║
 * ║               "Liber Tokenorum — The 15th Sovereign Ledger"                               ║
 * ║                                                                                           ║
 * ║  "Omnis fluxus notatus. Omnis genesis scripta. Omnis evolutio memorata."                  ║
 * ║  (Every flow recorded. Every genesis written. Every evolution remembered.)                 ║
 * ║                                                                                           ║
 * ║  THE 15TH LEDGER - TOKEN LEDGER                                                           ║
 * ║  ┌───────────────────────────────────────────────────────────────────────────────────┐   ║
 * ║  │  ORIGINAL 14 SOVEREIGN LEDGERS:                                                    │   ║
 * ║  │    1. Founder    2. Enterprise    3. IP         4. Royalty     5. Agent           │   ║
 * ║  │    6. Law        7. Memory        8. Governance  9. CSR       10. Lineage          │   ║
 * ║  │   11. Asset     12. Freeze       13. Session    14. Evolution                      │   ║
 * ║  │                                                                                    │   ║
 * ║  │  15. TOKEN LEDGER — Records all token operations in the organism                   │   ║
 * ║  │      • Foundation genesis and heartbeats                                           │   ║
 * ║  │      • Token model creation and evolution                                          │   ║
 * ║  │      • Civilization births and growth                                              │   ║
 * ║  │      • Workflow token allocations                                                  │   ║
 * ║  │      • Enterprise token distributions                                              │   ║
 * ║  │      • Microscopic token flows                                                     │   ║
 * ║  └───────────────────────────────────────────────────────────────────────────────────┘   ║
 * ║                                                                                           ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez                                           ║
 * ║  PROPRIETARY AND CONFIDENTIAL - MAXIMUM SECRECY                                           ║
 * ╚═══════════════════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Hash "mo:base/Hash";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import TokenFoundation "TokenFoundation";
import TokenCivilization "TokenCivilization";
import EnterpriseWorkflows "EnterpriseWorkflows";

module {
    // ================================================================== //
    // LEDGER CONSTANTS                                                    //
    // ================================================================== //
    
    /// Ledger doctrine - Latin
    public let LEDGER_DOCTRINE : Text = "Omnis fluxus notatus. Omnis genesis scripta. Omnis evolutio memorata.";
    
    /// Ledger doctrine - English
    public let LEDGER_DOCTRINE_EN : Text = "Every flow recorded. Every genesis written. Every evolution remembered.";
    
    /// Ledger name
    public let LEDGER_NAME : Text = "TOKEN_LEDGER";
    
    /// Ledger number in sovereign ledger system
    public let LEDGER_NUMBER : Nat = 15;
    
    /// Golden constants
    public let PHI : Float = MatalkoICP.PHI;
    
    // ================================================================== //
    // LEDGER ENTRY TYPES                                                  //
    // ================================================================== //
    
    /// Token ledger entry type
    public type EntryType = {
        #FoundationGenesis;      // Foundation created
        #FoundationHeartbeat;    // Foundation heartbeat
        #ModelCreation;          // Token model created
        #ModelEvolution;         // Token model evolved
        #CivilizationBirth;      // Civilization born
        #CivilizationGrowth;     // Civilization population growth
        #TokenGeneration;        // Tokens generated
        #TokenMint;              // Tokens minted
        #TokenTransfer;          // Tokens transferred
        #TokenBurn;              // Tokens burned
        #WorkflowAllocation;     // Tokens allocated to workflow
        #EnterpriseDistribution; // Tokens distributed to enterprise
        #ChannelCreation;        // Workflow channel created
        #BundleActivation;       // Workflow bundle activated
        #OrganismReading;        // Organism reading performed
        #MicroscopicFlow;        // Microscopic token flow
    };
    
    /// Token ledger entry
    public type TokenLedgerEntry = {
        entry_id: Text;
        entry_type: EntryType;
        
        // Timestamps
        timestamp: Int;
        sequence_number: Nat;
        
        // Context
        foundation_id: ?Text;
        model_id: ?Text;
        civilization_id: ?Text;
        workflow_id: ?Text;
        channel_id: ?Text;
        
        // Token data
        tokens_involved: Nat;
        from_entity: ?Text;
        to_entity: ?Text;
        
        // Metadata
        metadata: [(Text, Text)];
        
        // Verification
        anima_hash: Text;
        previous_hash: ?Text;
    };
    
    // ================================================================== //
    // TOKEN LEDGER STATE                                                  //
    // ================================================================== //
    
    /// Token ledger state
    public type TokenLedger = {
        ledger_id: Text;
        ledger_name: Text;
        ledger_number: Nat;
        
        // Entries
        entries: [TokenLedgerEntry];
        entry_count: Nat;
        
        // Aggregate stats
        total_tokens_recorded: Nat;
        total_generations: Nat;
        total_mints: Nat;
        total_transfers: Nat;
        total_burns: Nat;
        
        // Foundation tracking
        foundations_tracked: Nat;
        models_tracked: Nat;
        civilizations_tracked: Nat;
        
        // Workflow tracking
        workflows_tracked: Nat;
        channels_tracked: Nat;
        bundles_tracked: Nat;
        
        // Chain
        chain_head: Text;
        chain_length: Nat;
        
        // Timestamps
        genesis_time: Int;
        last_entry_time: Int;
    };
    
    // ================================================================== //
    // LEDGER INITIALIZATION                                               //
    // ================================================================== //
    
    /// Initialize the token ledger
    public func initLedger() : TokenLedger {
        let now = Time.now();
        let ledger_id = "TOKEN-LEDGER-" # Int.toText(now);
        
        // Create genesis entry
        let genesis_hash = MatalkoICP.animaHash(ledger_id # Int.toText(now));
        
        let genesis_entry : TokenLedgerEntry = {
            entry_id = ledger_id # "-GENESIS";
            entry_type = #FoundationGenesis;
            
            timestamp = now;
            sequence_number = 0;
            
            foundation_id = null;
            model_id = null;
            civilization_id = null;
            workflow_id = null;
            channel_id = null;
            
            tokens_involved = 0;
            from_entity = null;
            to_entity = null;
            
            metadata = [
                ("event", "LEDGER_GENESIS"),
                ("doctrine", LEDGER_DOCTRINE)
            ];
            
            anima_hash = genesis_hash;
            previous_hash = null;
        };
        
        {
            ledger_id = ledger_id;
            ledger_name = LEDGER_NAME;
            ledger_number = LEDGER_NUMBER;
            
            entries = [genesis_entry];
            entry_count = 1;
            
            total_tokens_recorded = 0;
            total_generations = 0;
            total_mints = 0;
            total_transfers = 0;
            total_burns = 0;
            
            foundations_tracked = 0;
            models_tracked = 0;
            civilizations_tracked = 0;
            
            workflows_tracked = 0;
            channels_tracked = 0;
            bundles_tracked = 0;
            
            chain_head = genesis_hash;
            chain_length = 1;
            
            genesis_time = now;
            last_entry_time = now;
        }
    };
    
    // ================================================================== //
    // LEDGER RECORDING                                                    //
    // ================================================================== //
    
    /// Record foundation genesis
    public func recordFoundationGenesis(
        ledger: TokenLedger,
        foundation: TokenFoundation.TokenFoundation
    ) : TokenLedger {
        let entry = createEntry(
            ledger,
            #FoundationGenesis,
            ?foundation.foundation_id,
            null,
            null,
            null,
            null,
            0,
            null,
            null,
            [
                ("event", "FOUNDATION_GENESIS"),
                ("models_spawned", Nat.toText(foundation.models_spawned)),
                ("civilizations_created", Nat.toText(foundation.civilizations_created))
            ]
        );
        
        appendEntry(ledger, entry, true, false, false)
    };
    
    /// Record foundation heartbeat
    public func recordHeartbeat(
        ledger: TokenLedger,
        foundation_id: Text,
        tokens_generated: Nat
    ) : TokenLedger {
        let entry = createEntry(
            ledger,
            #FoundationHeartbeat,
            ?foundation_id,
            null,
            null,
            null,
            null,
            tokens_generated,
            ?foundation_id,
            null,
            [
                ("event", "HEARTBEAT"),
                ("tokens_generated", Nat.toText(tokens_generated))
            ]
        );
        
        appendEntry(ledger, entry, false, true, false)
    };
    
    /// Record model creation
    public func recordModelCreation(
        ledger: TokenLedger,
        model: TokenCivilization.AutonomousModel
    ) : TokenLedger {
        let entry = createEntry(
            ledger,
            #ModelCreation,
            null,
            ?model.model_id,
            ?model.internal_civilization.civilization_id,
            null,
            null,
            0,
            null,
            ?model.model_id,
            [
                ("event", "MODEL_CREATED"),
                ("model_name", model.model_name),
                ("autonomous", if (model.autonomy_enabled) { "true" } else { "false" }),
                ("hours_active", Nat.toText(model.hours_active))
            ]
        );
        
        appendEntry({ ledger with models_tracked = ledger.models_tracked + 1 }, entry, false, false, false)
    };
    
    /// Record civilization birth
    public func recordCivilizationBirth(
        ledger: TokenLedger,
        civilization: TokenCivilization.Civilization
    ) : TokenLedger {
        let entry = createEntry(
            ledger,
            #CivilizationBirth,
            null,
            null,
            ?civilization.civilization_id,
            null,
            null,
            0,
            null,
            ?civilization.civilization_id,
            [
                ("event", "CIVILIZATION_BIRTH"),
                ("name", civilization.name),
                ("population", Nat.toText(civilization.total_entities)),
                ("autonomous_entities", Nat.toText(civilization.autonomous_entities))
            ]
        );
        
        appendEntry({ ledger with civilizations_tracked = ledger.civilizations_tracked + 1 }, entry, false, false, false)
    };
    
    /// Record token generation
    public func recordTokenGeneration(
        ledger: TokenLedger,
        model_id: Text,
        tokens: Nat
    ) : TokenLedger {
        let entry = createEntry(
            ledger,
            #TokenGeneration,
            null,
            ?model_id,
            null,
            null,
            null,
            tokens,
            ?model_id,
            null,
            [
                ("event", "TOKEN_GENERATION"),
                ("tokens", Nat.toText(tokens))
            ]
        );
        
        appendEntry(ledger, entry, false, true, false)
    };
    
    /// Record workflow allocation
    public func recordWorkflowAllocation(
        ledger: TokenLedger,
        workflow_id: Text,
        channel_id: Text,
        tokens: Nat
    ) : TokenLedger {
        let entry = createEntry(
            ledger,
            #WorkflowAllocation,
            null,
            null,
            null,
            ?workflow_id,
            ?channel_id,
            tokens,
            null,
            ?workflow_id,
            [
                ("event", "WORKFLOW_ALLOCATION"),
                ("tokens_allocated", Nat.toText(tokens))
            ]
        );
        
        appendEntry({ ledger with workflows_tracked = ledger.workflows_tracked + 1 }, entry, false, false, false)
    };
    
    /// Record bundle activation
    public func recordBundleActivation(
        ledger: TokenLedger,
        bundle: EnterpriseWorkflows.WorkflowBundle
    ) : TokenLedger {
        let entry = createEntry(
            ledger,
            #BundleActivation,
            null,
            null,
            null,
            null,
            null,
            bundle.token_budget,
            null,
            ?bundle.bundle_id,
            [
                ("event", "BUNDLE_ACTIVATION"),
                ("bundle_name", bundle.name),
                ("workflow_count", Nat.toText(bundle.workflow_count)),
                ("token_budget", Nat.toText(bundle.token_budget))
            ]
        );
        
        appendEntry({ ledger with bundles_tracked = ledger.bundles_tracked + 1 }, entry, false, false, false)
    };
    
    /// Record organism reading
    public func recordOrganismReading(
        ledger: TokenLedger,
        reading: TokenCivilization.OrganismReading
    ) : TokenLedger {
        let entry = createEntry(
            ledger,
            #OrganismReading,
            null,
            ?reading.model_id,
            null,
            null,
            null,
            reading.tokens_manifested,
            ?reading.model_id,
            null,
            [
                ("event", "ORGANISM_READING"),
                ("components_read", Nat.toText(Array.size(reading.components_read))),
                ("tokens_manifested", Nat.toText(reading.tokens_manifested))
            ]
        );
        
        appendEntry(ledger, entry, false, true, false)
    };
    
    /// Record microscopic token flow
    public func recordMicroscopicFlow(
        ledger: TokenLedger,
        model_id: Text,
        tokens: [TokenCivilization.MicroscopicToken]
    ) : TokenLedger {
        let entry = createEntry(
            ledger,
            #MicroscopicFlow,
            null,
            ?model_id,
            null,
            null,
            null,
            Array.size(tokens),
            ?model_id,
            null,
            [
                ("event", "MICROSCOPIC_FLOW"),
                ("micro_tokens", Nat.toText(Array.size(tokens)))
            ]
        );
        
        appendEntry(ledger, entry, false, true, false)
    };
    
    // ================================================================== //
    // HELPER FUNCTIONS                                                    //
    // ================================================================== //
    
    /// Create a ledger entry
    func createEntry(
        ledger: TokenLedger,
        entry_type: EntryType,
        foundation_id: ?Text,
        model_id: ?Text,
        civilization_id: ?Text,
        workflow_id: ?Text,
        channel_id: ?Text,
        tokens: Nat,
        from_entity: ?Text,
        to_entity: ?Text,
        metadata: [(Text, Text)]
    ) : TokenLedgerEntry {
        let now = Time.now();
        let entry_id = ledger.ledger_id # "-" # Nat.toText(ledger.entry_count);
        
        // Calculate ANIMA hash
        let hash_input = entry_id # ledger.chain_head # Int.toText(now);
        let anima_hash = MatalkoICP.animaHash(hash_input);
        
        {
            entry_id = entry_id;
            entry_type = entry_type;
            
            timestamp = now;
            sequence_number = ledger.entry_count;
            
            foundation_id = foundation_id;
            model_id = model_id;
            civilization_id = civilization_id;
            workflow_id = workflow_id;
            channel_id = channel_id;
            
            tokens_involved = tokens;
            from_entity = from_entity;
            to_entity = to_entity;
            
            metadata = metadata;
            
            anima_hash = anima_hash;
            previous_hash = ?ledger.chain_head;
        }
    };
    
    /// Append entry to ledger
    func appendEntry(
        ledger: TokenLedger,
        entry: TokenLedgerEntry,
        is_foundation: Bool,
        is_generation: Bool,
        is_mint: Bool
    ) : TokenLedger {
        let entries = Buffer.fromArray<TokenLedgerEntry>(ledger.entries);
        entries.add(entry);
        
        {
            ledger with
            entries = Buffer.toArray(entries);
            entry_count = ledger.entry_count + 1;
            
            total_tokens_recorded = ledger.total_tokens_recorded + entry.tokens_involved;
            total_generations = if (is_generation) { ledger.total_generations + 1 } else { ledger.total_generations };
            total_mints = if (is_mint) { ledger.total_mints + 1 } else { ledger.total_mints };
            foundations_tracked = if (is_foundation) { ledger.foundations_tracked + 1 } else { ledger.foundations_tracked };
            
            chain_head = entry.anima_hash;
            chain_length = ledger.chain_length + 1;
            
            last_entry_time = entry.timestamp;
        }
    };
    
    // ================================================================== //
    // LEDGER QUERIES                                                      //
    // ================================================================== //
    
    /// Get ledger statistics
    public func getLedgerStats(ledger: TokenLedger) : LedgerStats {
        let now = Time.now();
        let age_ns = Int.abs(now - ledger.genesis_time);
        
        {
            ledger_id = ledger.ledger_id;
            ledger_name = ledger.ledger_name;
            ledger_number = ledger.ledger_number;
            
            entry_count = ledger.entry_count;
            chain_length = ledger.chain_length;
            
            total_tokens_recorded = ledger.total_tokens_recorded;
            total_generations = ledger.total_generations;
            total_mints = ledger.total_mints;
            total_transfers = ledger.total_transfers;
            total_burns = ledger.total_burns;
            
            foundations_tracked = ledger.foundations_tracked;
            models_tracked = ledger.models_tracked;
            civilizations_tracked = ledger.civilizations_tracked;
            
            workflows_tracked = ledger.workflows_tracked;
            channels_tracked = ledger.channels_tracked;
            bundles_tracked = ledger.bundles_tracked;
            
            age_ns = age_ns;
            entries_per_second = Float.fromInt(ledger.entry_count) / Float.fromInt(age_ns / 1_000_000_000);
            
            chain_head = ledger.chain_head;
        }
    };
    
    /// Ledger statistics
    public type LedgerStats = {
        ledger_id: Text;
        ledger_name: Text;
        ledger_number: Nat;
        
        entry_count: Nat;
        chain_length: Nat;
        
        total_tokens_recorded: Nat;
        total_generations: Nat;
        total_mints: Nat;
        total_transfers: Nat;
        total_burns: Nat;
        
        foundations_tracked: Nat;
        models_tracked: Nat;
        civilizations_tracked: Nat;
        
        workflows_tracked: Nat;
        channels_tracked: Nat;
        bundles_tracked: Nat;
        
        age_ns: Nat;
        entries_per_second: Float;
        
        chain_head: Text;
    };
    
    /// Get entries by type
    public func getEntriesByType(ledger: TokenLedger, entry_type: EntryType) : [TokenLedgerEntry] {
        Array.filter<TokenLedgerEntry>(
            ledger.entries,
            func(e: TokenLedgerEntry) : Bool {
                e.entry_type == entry_type
            }
        )
    };
    
    /// Get entries for model
    public func getEntriesForModel(ledger: TokenLedger, model_id: Text) : [TokenLedgerEntry] {
        Array.filter<TokenLedgerEntry>(
            ledger.entries,
            func(e: TokenLedgerEntry) : Bool {
                switch (e.model_id) {
                    case (?id) { id == model_id };
                    case null { false };
                }
            }
        )
    };
    
    /// Get entries for workflow
    public func getEntriesForWorkflow(ledger: TokenLedger, workflow_id: Text) : [TokenLedgerEntry] {
        Array.filter<TokenLedgerEntry>(
            ledger.entries,
            func(e: TokenLedgerEntry) : Bool {
                switch (e.workflow_id) {
                    case (?id) { id == workflow_id };
                    case null { false };
                }
            }
        )
    };
    
    /// Get token flow summary
    public func getTokenFlowSummary(ledger: TokenLedger) : TokenFlowSummary {
        var generated : Nat = 0;
        var minted : Nat = 0;
        var transferred : Nat = 0;
        var allocated : Nat = 0;
        var manifested : Nat = 0;
        
        for (entry in ledger.entries.vals()) {
            switch (entry.entry_type) {
                case (#TokenGeneration) { generated += entry.tokens_involved };
                case (#TokenMint) { minted += entry.tokens_involved };
                case (#TokenTransfer) { transferred += entry.tokens_involved };
                case (#WorkflowAllocation) { allocated += entry.tokens_involved };
                case (#OrganismReading) { manifested += entry.tokens_involved };
                case (_) { };
            }
        };
        
        {
            total_generated = generated;
            total_minted = minted;
            total_transferred = transferred;
            total_allocated = allocated;
            total_manifested = manifested;
            grand_total = generated + minted + transferred + allocated + manifested;
        }
    };
    
    /// Token flow summary
    public type TokenFlowSummary = {
        total_generated: Nat;
        total_minted: Nat;
        total_transferred: Nat;
        total_allocated: Nat;
        total_manifested: Nat;
        grand_total: Nat;
    };
    
    // ================================================================== //
    // CHAIN VERIFICATION                                                  //
    // ================================================================== //
    
    /// Verify chain integrity
    public func verifyChain(ledger: TokenLedger) : ChainVerification {
        var valid = true;
        var breaks : Nat = 0;
        var last_hash = "";
        
        for (entry in ledger.entries.vals()) {
            switch (entry.previous_hash) {
                case (?prev) {
                    if (prev != last_hash and last_hash != "") {
                        valid := false;
                        breaks += 1;
                    };
                };
                case null {
                    // Genesis entry, no previous hash
                };
            };
            last_hash := entry.anima_hash;
        };
        
        {
            is_valid = valid;
            chain_breaks = breaks;
            chain_length = ledger.chain_length;
            head_hash = ledger.chain_head;
            verification_time = Time.now();
        }
    };
    
    /// Chain verification result
    public type ChainVerification = {
        is_valid: Bool;
        chain_breaks: Nat;
        chain_length: Nat;
        head_hash: Text;
        verification_time: Int;
    };
}
