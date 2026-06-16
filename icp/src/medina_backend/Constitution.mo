/**
 * MEDINA Constitution Module — Root charter and doctrine hierarchy.
 * 
 * DOCTRINE LEVELS (non-collapsible):
 *   Absolute  — immutable founding truth
 *   Law       — constitutional laws (RECITAL_PLUS_ONE, Gates, etc.)
 *   Model     — runtime model contracts
 *   Engine    — execution engine specifications
 *   Core      — Core A/B authority boundaries
 *   Module    — modular capability contracts
 *   Lab       — experimental/sandbox scope
 *   Workforce — document/agent workforce
 *   Product   — external product surface
 * 
 * NO-COLLAPSE INVARIANT:
 *   Absolute ≠ Law ≠ Model ≠ Engine ≠ Core ≠ Module ≠ Lab ≠ Workforce ≠ Product
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

import Types "Types";
import Utils "Utils";

module {
    public type DoctrineLevel = Types.DoctrineLevel;
    public type DoctrineEntry = Types.DoctrineEntry;
    
    /// Constitution state
    public type ConstitutionState = {
        var entries: [(Text, DoctrineEntry)];
        var beat: Nat;
        var created_at: Int;
        var idCounter: Nat;
    };
    
    /// Initialize constitution with founding absolutes
    public func init() : ConstitutionState {
        let state : ConstitutionState = {
            var entries = [];
            var beat = 0;
            var created_at = Time.now();
            var idCounter = 0;
        };
        
        // Load founding absolutes (immutable)
        let foundingAbsolutes : [(Text, Text, Text)] = [
            ("RECITAL_PLUS_ONE", 
             "state(n+1) = recital(validated_state_n) + one_lawful_expansion",
             "Master generative law governing all state evolution"),
            ("FOUR_REGISTERS",
             "[\"Founder\", \"Builder\", \"Organism\", \"External\"]",
             "All critical artifacts preserve four registers"),
            ("DUAL_READ_ALWAYS_ON",
             "{\"semantic_read\": true, \"resonance_read\": true}",
             "Missing either mode degrades or halts autonomous write"),
            ("GATES_ABC",
             "{\"Gate_A\": \"runtime readiness\", \"Gate_B\": \"workforce activation\", \"Gate_C\": \"projection safety\"}",
             "No bypass allowed for any gate"),
            ("CORE_AUTHORITY",
             "{\"Core_A\": \"runtime truth\", \"Core_B\": \"industrial/workforce execution\"}",
             "Core B proposes; Core A accepts runtime-truth mutation"),
            ("NO_COLLAPSE_ONTOLOGY",
             "[\"Absolute\", \"Law\", \"Model\", \"Engine\", \"Core\", \"Module\", \"Lab\", \"Workforce\", \"Product\"]",
             "These nine levels must never collapse into each other")
        ];
        
        var entriesBuffer = Buffer.Buffer<(Text, DoctrineEntry)>(foundingAbsolutes.size());
        
        for ((key, value, rationale) in foundingAbsolutes.vals()) {
            state.idCounter += 1;
            let entry : DoctrineEntry = {
                entry_id = Utils.generateId("doctrine", state.idCounter);
                level = #ABSOLUTE;
                key = key;
                value = value;
                rationale = rationale;
                created_at = state.created_at;
                updated_at = state.created_at;
                version = 1;
                immutable = true;
            };
            entriesBuffer.add((key, entry));
        };
        
        state.entries := Buffer.toArray(entriesBuffer);
        state
    };
    
    /// Get a doctrine entry by key
    public func get(state: ConstitutionState, key: Text) : ?DoctrineEntry {
        for ((k, entry) in state.entries.vals()) {
            if (k == key) {
                return ?entry;
            };
        };
        null
    };
    
    /// Get all entries at a specific doctrine level
    public func getByLevel(state: ConstitutionState, level: DoctrineLevel) : [DoctrineEntry] {
        let results = Buffer.Buffer<DoctrineEntry>(8);
        for ((_, entry) in state.entries.vals()) {
            if (doctrineLevelEqual(entry.level, level)) {
                results.add(entry);
            };
        };
        Buffer.toArray(results)
    };
    
    /// List all keys
    public func listKeys(state: ConstitutionState) : [Text] {
        Array.map<(Text, DoctrineEntry), Text>(state.entries, func((k, _)) : Text { k })
    };
    
    /// Check if doctrine levels are equal
    public func doctrineLevelEqual(a: DoctrineLevel, b: DoctrineLevel) : Bool {
        switch (a, b) {
            case (#ABSOLUTE, #ABSOLUTE) true;
            case (#LAW, #LAW) true;
            case (#MODEL, #MODEL) true;
            case (#ENGINE, #ENGINE) true;
            case (#CORE, #CORE) true;
            case (#MODULE, #MODULE) true;
            case (#LAB, #LAB) true;
            case (#WORKFORCE, #WORKFORCE) true;
            case (#PRODUCT, #PRODUCT) true;
            case (_, _) false;
        }
    };
    
    /// Get numerical precedence for doctrine level (lower = higher authority)
    public func levelPrecedence(level: DoctrineLevel) : Nat {
        switch (level) {
            case (#ABSOLUTE) 0;
            case (#LAW) 1;
            case (#MODEL) 2;
            case (#ENGINE) 3;
            case (#CORE) 4;
            case (#MODULE) 5;
            case (#LAB) 6;
            case (#WORKFORCE) 7;
            case (#PRODUCT) 8;
        }
    };
    
    /// Check if authority level can govern target level
    public func canGovern(authority: DoctrineLevel, target: DoctrineLevel) : Bool {
        levelPrecedence(authority) < levelPrecedence(target)
    };
    
    /// Register a new doctrine entry
    public func register(
        state: ConstitutionState,
        key: Text,
        value: Text,
        level: DoctrineLevel,
        rationale: Text,
        authorityLevel: DoctrineLevel
    ) : ?DoctrineEntry {
        // Cannot register at ABSOLUTE level
        if (doctrineLevelEqual(level, #ABSOLUTE)) {
            return null;
        };
        
        // Check authority
        if (not canGovern(authorityLevel, level)) {
            return null;
        };
        
        // Check if key exists and is immutable
        for ((k, entry) in state.entries.vals()) {
            if (k == key and entry.immutable) {
                return null;
            };
        };
        
        state.idCounter += 1;
        let now = Time.now();
        
        let newEntry : DoctrineEntry = {
            entry_id = Utils.generateId("doctrine", state.idCounter);
            level = level;
            key = key;
            value = value;
            rationale = rationale;
            created_at = now;
            updated_at = now;
            version = 1;
            immutable = false;
        };
        
        // Add or replace entry
        var found = false;
        let updated = Array.map<(Text, DoctrineEntry), (Text, DoctrineEntry)>(
            state.entries,
            func((k, e)) : (Text, DoctrineEntry) {
                if (k == key) {
                    found := true;
                    (key, newEntry)
                } else {
                    (k, e)
                }
            }
        );
        
        if (found) {
            state.entries := updated;
        } else {
            let buffer = Buffer.fromArray<(Text, DoctrineEntry)>(state.entries);
            buffer.add((key, newEntry));
            state.entries := Buffer.toArray(buffer);
        };
        
        ?newEntry
    };
    
    /// Validate NO-COLLAPSE invariant
    public func validateNoCollapse(state: ConstitutionState) : Bool {
        // Each key should only appear at one level
        for ((k1, e1) in state.entries.vals()) {
            for ((k2, e2) in state.entries.vals()) {
                if (k1 == k2 and not doctrineLevelEqual(e1.level, e2.level)) {
                    return false;
                };
            };
        };
        true
    };
    
    /// Get total entry count
    public func count(state: ConstitutionState) : Nat {
        state.entries.size()
    };
    
    /// Advance beat counter
    public func advanceBeat(state: ConstitutionState) : Nat {
        state.beat += 1;
        state.beat
    };
}
