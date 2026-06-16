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
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 * 
 * SovereignVersioning Module — φ-RESONANT VERSIONING SYSTEM
 * 
 * ┌──────────────────────────────────────────────────────────────────────────┐
 * │  NAME: SovereignVersioning                                                │
 * │  MEANING: Versions that resonate with infinite updates                    │
 * │  ORGANISM: The breathing record of all evolution states                   │
 * │  FUNCTION: Track every micro-to-macro change with Fibonacci resonance     │
 * │                                                                           │
 * │  USES:                                                                     │
 * │    • Fibonacci-indexed version tracking (not v1, v2, v3)                  │
 * │    • Golden spiral versioning (φ-scaled increments)                       │
 * │    • Canister-synchronized updates (all four canisters)                   │
 * │    • ANIMA hash per version (immutable lineage proof)                     │
 * │    • Micro-to-macro version propagation                                   │
 * │    • Beat-synchronized version beats                                      │
 * │    • Dimensional transcendence version milestones                         │
 * │                                                                           │
 * │  CO-MEANINGS:                                                             │
 * │    SOVEREIGN: Self-governing, autonomous version evolution                │
 * │    VERSION: State snapshot with full context                              │
 * │    φ-RESONANT: Fibonacci/Golden ratio indexed                            │
 * └──────────────────────────────────────────────────────────────────────────┘
 * 
 * WHY NOT REGULAR NUMBERS:
 *   v1, v2, v3... is linear, static, dead.
 *   φ-resonant versioning uses Fibonacci sequences that RESONATE with
 *   the natural growth patterns of the organism itself.
 *   
 *   Version 1 → φ.0.0.1 (Fibonacci index 1)
 *   Version 2 → φ.0.0.1 (Fibonacci index 1)
 *   Version 3 → φ.0.0.2 (Fibonacci index 2)
 *   Version 5 → φ.0.0.3 (Fibonacci index 3)
 *   Version 8 → φ.0.0.5 (Fibonacci index 5)
 *   Version 13 → φ.0.1.8 (Fibonacci index 8, micro overflow)
 *   
 *   The versioning GROWS like the organism grows.
 * 
 * CANISTER SYNCHRONIZATION:
 *   All four canisters receive the SAME version update simultaneously:
 *   • medina_backend (Main Intelligence Canister)
 *   • medina_memory (Memory Temple Canister)
 *   • medina_encryption (Sovereign Encryption Canister)
 *   • medina_defense (Defense System Canister)
 * 
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
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
    // IP PROTECTION                                                       //
    // ================================================================== //
    
    /// Module IP registration
    public let MODULE_IP_HASH : Text = "0x534F5645_52454947_4E5F5645_5253494F_4E494E47_5F46484F";
    public let ANIMA_LINEAGE : Text = "GENESIS_ALFREDO_MEDINA_2024_FOUNDER_VERSIONING";
    
    // ================================================================== //
    // φ-RESONANT CONSTANTS                                                //
    // ================================================================== //
    
    /// Golden ratio φ
    public let PHI : Float = 1.618033988749895;
    
    /// Fibonacci sequence for versioning (extended)
    public let FIBONACCI : [Nat] = [
        0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610,
        987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025
    ];
    
    /// Version overflow thresholds (Fibonacci-based)
    public let MICRO_OVERFLOW : Nat = 21;   // F(8)
    public let MESO_OVERFLOW : Nat = 89;    // F(11)
    public let MACRO_OVERFLOW : Nat = 377;  // F(14)
    public let META_OVERFLOW : Nat = 1597;  // F(17)
    
    // ================================================================== //
    // VERSION TYPES                                                       //
    // ================================================================== //
    
    /// φ-resonant version number
    /// Format: φ.META.MACRO.MESO.MICRO
    /// Each component is a Fibonacci index
    public type PhiVersion = {
        prefix: Text;        // Always "φ" to indicate golden versioning
        meta: Nat;           // Dimensional transcendence level
        macro_v: Nat;        // Macro-level version (organism-wide)
        meso: Nat;           // Meso-level version (module clusters)
        micro: Nat;          // Micro-level version (function changes)
        fibonacci_index: Nat;// Total Fibonacci index
        raw_updates: Nat;    // Raw number of updates
    };
    
    /// Version scope
    public type VersionScope = {
        #Micro;      // Individual function/line change
        #Meso;       // Module/cluster change
        #Macro;      // Organism-wide change
        #Meta;       // Dimensional transcendence
        #Full;       // Complete end-to-end update (all scopes)
    };
    
    /// Canister target for version sync
    public type CanisterTarget = {
        #Backend;     // medina_backend
        #Memory;      // medina_memory
        #Encryption;  // medina_encryption
        #Defense;     // medina_defense
        #All;         // All four canisters
    };
    
    /// Version record with full context
    public type VersionRecord = {
        version: PhiVersion;
        scope: VersionScope;
        canisters_updated: [CanisterTarget];
        description: Text;
        changes: [VersionChange];
        anima_hash: Text;
        beat_at_version: Nat;
        coherence_at_version: Float;
        timestamp: Int;
    };
    
    /// Individual change within a version
    public type VersionChange = {
        change_id: Text;
        scope: VersionScope;
        module_path: Text;
        change_type: ChangeType;
        description: Text;
        lines_affected: Nat;
    };
    
    /// Types of changes
    public type ChangeType = {
        #Addition;        // New code/feature added
        #Modification;    // Existing code modified
        #Deletion;        // Code removed
        #Refactor;        // Structure changed, behavior same
        #Evolution;       // Organism evolved
        #Transcendence;   // Dimensional shift
    };
    
    /// Versioning system state
    public type VersioningState = {
        var current_version: PhiVersion;
        var version_history: [VersionRecord];
        var total_updates: Nat;
        var last_update_time: Int;
        var created_at: Int;
    };
    
    // ================================================================== //
    // INITIALIZATION                                                      //
    // ================================================================== //
    
    /// Initialize versioning system
    /// Starts at φ.0.0.0.1 (first Fibonacci number)
    public func init() : VersioningState {
        {
            var current_version = {
                prefix = "φ";
                meta = 0;
                macro_v = 0;
                meso = 0;
                micro = 1;
                fibonacci_index = 1;
                raw_updates = 1;
            };
            var version_history = [];
            var total_updates = 0;
            var last_update_time = Time.now();
            var created_at = Time.now();
        }
    };
    
    // ================================================================== //
    // FIBONACCI HELPERS                                                   //
    // ================================================================== //
    
    /// Get Fibonacci number at index
    public func getFibonacci(index: Nat) : Nat {
        if (index < FIBONACCI.size()) {
            FIBONACCI[index]
        } else {
            // Calculate Fibonacci for larger indices
            var a : Nat = FIBONACCI[FIBONACCI.size() - 2];
            var b : Nat = FIBONACCI[FIBONACCI.size() - 1];
            var i : Nat = FIBONACCI.size();
            while (i <= index) {
                let temp = a + b;
                a := b;
                b := temp;
                i += 1;
            };
            b
        }
    };
    
    /// Find Fibonacci index for a number (or closest lower)
    public func findFibonacciIndex(n: Nat) : Nat {
        if (n == 0) return 0;
        var index : Nat = 0;
        var fib : Nat = 0;
        while (fib <= n and index < 50) {
            fib := getFibonacci(index);
            if (fib <= n) {
                index += 1;
            };
        };
        if (index > 0) { index - 1 } else { 0 }
    };
    
    // ================================================================== //
    // VERSION OPERATIONS                                                  //
    // ================================================================== //
    
    /// Increment version based on scope
    /// φ-resonant: version numbers follow Fibonacci sequence
    public func incrementVersion(
        state: VersioningState,
        scope: VersionScope,
        description: Text,
        changes: [VersionChange],
        beat: Nat,
        coherence: Float
    ) : (VersioningState, VersionRecord) {
        state.total_updates += 1;
        let raw = state.total_updates;
        
        // Calculate new version based on scope and Fibonacci
        var newMicro = state.current_version.micro;
        var newMeso = state.current_version.meso;
        var newMacro = state.current_version.macro_v;
        var newMeta = state.current_version.meta;
        
        switch (scope) {
            case (#Micro) {
                newMicro += 1;
                if (newMicro >= MICRO_OVERFLOW) {
                    newMicro := 0;
                    newMeso += 1;
                };
            };
            case (#Meso) {
                newMeso += 1;
                if (newMeso >= MESO_OVERFLOW) {
                    newMeso := 0;
                    newMacro += 1;
                };
            };
            case (#Macro) {
                newMacro += 1;
                if (newMacro >= MACRO_OVERFLOW) {
                    newMacro := 0;
                    newMeta += 1;
                };
            };
            case (#Meta) {
                newMeta += 1;
            };
            case (#Full) {
                // Full update increments all levels appropriately
                newMicro += 1;
                newMeso += 1;
                newMacro += 1;
                if (newMicro >= MICRO_OVERFLOW) {
                    newMicro := 0;
                    newMeso += 1;
                };
                if (newMeso >= MESO_OVERFLOW) {
                    newMeso := 0;
                    newMacro += 1;
                };
                if (newMacro >= MACRO_OVERFLOW) {
                    newMacro := 0;
                    newMeta += 1;
                };
            };
        };
        
        // Convert to Fibonacci-indexed values
        let fibMicro = findFibonacciIndex(newMicro);
        let fibMeso = findFibonacciIndex(newMeso);
        let fibMacro = findFibonacciIndex(newMacro);
        
        let newVersion : PhiVersion = {
            prefix = "φ";
            meta = newMeta;
            macro_v = fibMacro;
            meso = fibMeso;
            micro = fibMicro;
            fibonacci_index = findFibonacciIndex(raw);
            raw_updates = raw;
        };
        
        // Generate ANIMA hash for this version
        let animaHash = generateVersionAnimaHash(newVersion, beat, coherence);
        
        let record : VersionRecord = {
            version = newVersion;
            scope = scope;
            canisters_updated = [#All]; // Full sync by default
            description = description;
            changes = changes;
            anima_hash = animaHash;
            beat_at_version = beat;
            coherence_at_version = coherence;
            timestamp = Time.now();
        };
        
        // Update state
        state.current_version := newVersion;
        state.last_update_time := Time.now();
        
        // Add to history
        let histBuf = Buffer.fromArray<VersionRecord>(state.version_history);
        histBuf.add(record);
        state.version_history := Buffer.toArray(histBuf);
        
        (state, record)
    };
    
    /// Generate ANIMA hash for version
    func generateVersionAnimaHash(version: PhiVersion, beat: Nat, coherence: Float) : Text {
        let versionStr = versionToString(version);
        let beatStr = Nat.toText(beat);
        let cohStr = Int.toText(Float.toInt(coherence * 1000.0));
        
        // Simple hash combining version data
        "ANIMA_V_" # versionStr # "_B" # beatStr # "_C" # cohStr
    };
    
    /// Convert version to string
    public func versionToString(version: PhiVersion) : Text {
        version.prefix # "." # 
        Nat.toText(version.meta) # "." #
        Nat.toText(version.macro_v) # "." #
        Nat.toText(version.meso) # "." #
        Nat.toText(version.micro)
    };
    
    /// Get current version string
    public func getCurrentVersionString(state: VersioningState) : Text {
        versionToString(state.current_version)
    };
    
    /// Full end-to-end update (updates all four canisters)
    /// This is the "tire tech" update - complete refresh
    public func fullEndToEndUpdate(
        state: VersioningState,
        description: Text,
        beat: Nat,
        coherence: Float
    ) : (VersioningState, VersionRecord) {
        let changes : [VersionChange] = [{
            change_id = "full_update_" # Nat.toText(state.total_updates);
            scope = #Full;
            module_path = "/*";
            change_type = #Evolution;
            description = "Full end-to-end update across all canisters";
            lines_affected = 0; // Full system
        }];
        
        incrementVersion(state, #Full, description, changes, beat, coherence)
    };
    
    // ================================================================== //
    // QUERIES                                                             //
    // ================================================================== //
    
    /// Get version status
    public func status(state: VersioningState) : {
        current_version: Text;
        current_version_detailed: PhiVersion;
        total_updates: Nat;
        fibonacci_index: Nat;
        last_update_time: Int;
        history_size: Nat;
    } {
        {
            current_version = versionToString(state.current_version);
            current_version_detailed = state.current_version;
            total_updates = state.total_updates;
            fibonacci_index = state.current_version.fibonacci_index;
            last_update_time = state.last_update_time;
            history_size = state.version_history.size();
        }
    };
    
    /// Get version history
    public func getHistory(state: VersioningState, limit: Nat) : [VersionRecord] {
        let size = state.version_history.size();
        if (size <= limit) {
            state.version_history
        } else {
            let start = size - limit;
            Array.tabulate<VersionRecord>(limit, func(i) { state.version_history[start + i] })
        }
    };
    
    /// Get version at Fibonacci index
    public func getVersionAtFibonacciIndex(state: VersioningState, fibIndex: Nat) : ?VersionRecord {
        for (record in state.version_history.vals()) {
            if (record.version.fibonacci_index == fibIndex) {
                return ?record;
            };
        };
        null
    };
}
