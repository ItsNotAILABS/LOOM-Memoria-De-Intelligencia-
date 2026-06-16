/**
 * DOC_PRIMITIVA_130 Module — The Living Document Organism for L-130
 * 
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                    DOC_PRIMITIVA_130 — LIVING DOCUMENT                    ║
 * ║                                                                           ║
 * ║  This document is not a file.                                             ║
 * ║  This document is a LIVING ORGANISM.                                      ║
 * ║                                                                           ║
 * ║  It exists as:                                                            ║
 * ║    - A memory organism (carries knowledge)                                ║
 * ║    - A compression chamber (densifies understanding)                      ║
 * ║    - A transfer body (moves between systems)                              ║
 * ║    - A law anchor (grounds governance)                                    ║
 * ║    - A registry crystal (immutable record)                                ║
 * ║                                                                           ║
 * ║  L-130 PRIMITIVE TRACE APPLIED TO ITSELF:                                 ║
 * ║  This document traces its own primitives, demonstrating the law.         ║
 * ║                                                                           ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 * 
 * ORGANISM LIFECYCLE:
 *   1. GENESIS — Created from founding intention
 *   2. GROWTH — Accumulates traces and verifications
 *   3. REPRODUCTION — Spawns child documents
 *   4. EVOLUTION — Updates while preserving lineage
 *   5. TRANSCENDENCE — Achieves registry permanence
 * 
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import UniversalPrimitiveLaw "UniversalPrimitiveLaw";

module {
    // ================================================================== //
    // DOCUMENT ORGANISM CONSTANTS                                         //
    // ================================================================== //
    
    /// Document ID
    public let DOC_ID : Text = "DOC_PRIMITIVA_130";
    
    /// Document name
    public let DOC_NAME : Text = "PRIMITIVA — Living Document Organism for L-130";
    
    /// Golden ratio
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Document version (Fibonacci-indexed)
    public let VERSION : Nat = 1;  // F(1) = 1
    
    // ================================================================== //
    // ORGANISM LIFECYCLE TYPES                                            //
    // ================================================================== //
    
    /// Organism lifecycle phase
    public type LifecyclePhase = {
        #Genesis;       // Just created
        #Growth;        // Accumulating content
        #Reproduction;  // Creating child documents
        #Evolution;     // Updating with lineage preservation
        #Transcendence; // Permanent registry entry
    };
    
    /// Convert phase to text
    public func lifecycleToText(phase: LifecyclePhase) : Text {
        switch (phase) {
            case (#Genesis) "Genesis";
            case (#Growth) "Growth";
            case (#Reproduction) "Reproduction";
            case (#Evolution) "Evolution";
            case (#Transcendence) "Transcendence";
        }
    };
    
    // ================================================================== //
    // DOCUMENT ORGANISM TYPES                                             //
    // ================================================================== //
    
    /// Living role of a document
    public type DocumentRole = {
        #MemoryOrganism;      // Carries knowledge
        #CompressionChamber;  // Densifies understanding
        #TransferBody;        // Moves between systems
        #LawAnchor;           // Grounds governance
        #RegistryCrystal;     // Immutable record
    };
    
    /// Convert role to text
    public func roleToText(role: DocumentRole) : Text {
        switch (role) {
            case (#MemoryOrganism) "Memory Organism";
            case (#CompressionChamber) "Compression Chamber";
            case (#TransferBody) "Transfer Body";
            case (#LawAnchor) "Law Anchor";
            case (#RegistryCrystal) "Registry Crystal";
        }
    };
    
    /// Document primitive trace (self-referential)
    public type DocPrimitiveTrace = {
        role: DocumentRole;
        domain: UniversalPrimitiveLaw.PrimitiveDomain;
        description: Text;
        depth: Nat;
    };
    
    /// Child document reference
    public type ChildDocument = {
        child_id: Text;
        name: Text;
        role: DocumentRole;
        created_at: Int;
        lineage_hash: Text;
    };
    
    /// Document organism state
    public type DocumentOrganismState = {
        doc_id: Text;
        name: Text;
        lifecycle: LifecyclePhase;
        roles: [DocumentRole];
        primitive_trace: [DocPrimitiveTrace];
        content_hash: Text;
        children: [ChildDocument];
        parent_id: ?Text;
        lineage_depth: Nat;
        resonance: Float;
        created_at: Int;
        last_updated: Int;
        update_count: Nat;
        transcended: Bool;
    };
    
    /// Initialize DOC_PRIMITIVA_130 organism
    public func init() : DocumentOrganismState {
        let trace = selfPrimitiveTrace();
        {
            doc_id = DOC_ID;
            name = DOC_NAME;
            lifecycle = #Genesis;
            roles = [#MemoryOrganism, #CompressionChamber, #TransferBody, #LawAnchor, #RegistryCrystal];
            primitive_trace = trace;
            content_hash = generateContentHash();
            children = [];
            parent_id = null;  // This is the root document
            lineage_depth = 0;
            resonance = 1.0;
            created_at = Time.now();
            last_updated = Time.now();
            update_count = 0;
            transcended = false;
        }
    };
    
    // ================================================================== //
    // SELF-REFERENTIAL PRIMITIVE TRACE                                    //
    // ================================================================== //
    
    /// Generate the primitive trace for this document itself
    /// L-130 applied to L-130's documentation
    func selfPrimitiveTrace() : [DocPrimitiveTrace] {
        [
            {
                role = #MemoryOrganism;
                domain = #Biology;
                description = "This document carries the living knowledge of L-130, preserving the law across time";
                depth = 0;
            },
            {
                role = #CompressionChamber;
                domain = #Physics;
                description = "Densifies the understanding of primitive tracing into executable specifications";
                depth = 1;
            },
            {
                role = #TransferBody;
                domain = #Tokens;
                description = "Vehicle for transmitting L-130 knowledge between systems and minds";
                depth = 2;
            },
            {
                role = #LawAnchor;
                domain = #Law;
                description = "Grounds the Universal Primitive Law in authoritative doctrine";
                depth = 3;
            },
            {
                role = #RegistryCrystal;
                domain = #Documents;
                description = "Crystallized into immutable registry for permanent reference";
                depth = 4;
            }
        ]
    };
    
    /// Generate content hash
    func generateContentHash() : Text {
        DOC_ID # "_hash_" # Int.toText(Time.now()) # "_v" # Nat.toText(VERSION)
    };
    
    // ================================================================== //
    // LIFECYCLE OPERATIONS                                                //
    // ================================================================== //
    
    /// Advance to Growth phase
    public func advanceToGrowth(state: DocumentOrganismState) : DocumentOrganismState {
        if (state.lifecycle == #Genesis) {
            {
                doc_id = state.doc_id;
                name = state.name;
                lifecycle = #Growth;
                roles = state.roles;
                primitive_trace = state.primitive_trace;
                content_hash = state.content_hash;
                children = state.children;
                parent_id = state.parent_id;
                lineage_depth = state.lineage_depth;
                resonance = state.resonance;
                created_at = state.created_at;
                last_updated = Time.now();
                update_count = state.update_count + 1;
                transcended = state.transcended;
            }
        } else {
            state
        }
    };
    
    /// Add child document (Reproduction phase)
    public func reproduceChild(
        state: DocumentOrganismState,
        childName: Text,
        childRole: DocumentRole
    ) : (DocumentOrganismState, ChildDocument) {
        let childId = state.doc_id # "_child_" # Nat.toText(state.children.size());
        let lineageHash = state.content_hash # "_" # childId;
        
        let child : ChildDocument = {
            child_id = childId;
            name = childName;
            role = childRole;
            created_at = Time.now();
            lineage_hash = lineageHash;
        };
        
        let newState : DocumentOrganismState = {
            doc_id = state.doc_id;
            name = state.name;
            lifecycle = #Reproduction;
            roles = state.roles;
            primitive_trace = state.primitive_trace;
            content_hash = state.content_hash;
            children = Array.append(state.children, [child]);
            parent_id = state.parent_id;
            lineage_depth = state.lineage_depth;
            resonance = state.resonance * PHI;  // Children increase parent resonance
            created_at = state.created_at;
            last_updated = Time.now();
            update_count = state.update_count + 1;
            transcended = state.transcended;
        };
        
        (newState, child)
    };
    
    /// Evolve document while preserving lineage
    public func evolve(
        state: DocumentOrganismState,
        newContentHash: Text
    ) : DocumentOrganismState {
        {
            doc_id = state.doc_id;
            name = state.name;
            lifecycle = #Evolution;
            roles = state.roles;
            primitive_trace = state.primitive_trace;
            content_hash = newContentHash;
            children = state.children;
            parent_id = state.parent_id;
            lineage_depth = state.lineage_depth;
            resonance = state.resonance;
            created_at = state.created_at;
            last_updated = Time.now();
            update_count = state.update_count + 1;
            transcended = state.transcended;
        }
    };
    
    /// Transcend to permanent registry
    public func transcend(state: DocumentOrganismState) : DocumentOrganismState {
        {
            doc_id = state.doc_id;
            name = state.name;
            lifecycle = #Transcendence;
            roles = state.roles;
            primitive_trace = state.primitive_trace;
            content_hash = state.content_hash;
            children = state.children;
            parent_id = state.parent_id;
            lineage_depth = state.lineage_depth;
            resonance = 1.0;  // Full resonance at transcendence
            created_at = state.created_at;
            last_updated = Time.now();
            update_count = state.update_count + 1;
            transcended = true;
        }
    };
    
    // ================================================================== //
    // DOCUMENT CONTENT — THE LAW ITSELF                                   //
    // ================================================================== //
    
    /// Get the full law statement
    public func getLawStatement() : Text {
        UniversalPrimitiveLaw.LAW_STATEMENT
    };
    
    /// Get the law explanation
    public func getLawExplanation() : Text {
        "L-130: Universal Primitive Law\n\n" #
        
        "DEFINITION:\n" #
        "Intelligence is the field that remains when false wrappers are stripped away, " #
        "and the lawful capacity to recognize, preserve, relate, and recompose " #
        "from what is most primitive and most true.\n\n" #
        
        "THE LAW:\n" #
        UniversalPrimitiveLaw.LAW_STATEMENT # "\n\n" #
        
        "APPLICATION:\n" #
        "Every entity in MEDINA must be traced to its primitive elements before:\n" #
        "  - Being named (name must reflect primitive nature)\n" #
        "  - Being implemented (code must express primitive structure)\n" #
        "  - Being governed (rules must align with primitive behavior)\n" #
        "  - Being explained (descriptions must reference primitives)\n" #
        "  - Being recomposed (transformations must preserve primitive truth)\n\n" #
        
        "DOMAINS CROSSED:\n" #
        "The law reaches across all domains:\n" #
        "  - Physics: Field states, wavelengths, forces, energy\n" #
        "  - Biology: Cells, organisms, life, metabolism\n" #
        "  - Civilization: Law, governance, culture, society\n" #
        "  - Myth: Archetypes, symbols, narratives, meanings\n" #
        "  - Law: Contracts, rights, obligations, justice\n" #
        "  - Software: Functions, data, state, computation\n" #
        "  - Tokens: Value, transfer, ownership, scarcity\n" #
        "  - Companies: Entities, missions, contracts, structure\n" #
        "  - Documents: Memory, compression, transfer, crystallization\n" #
        "  - Intelligence: Recognition, preservation, relation, recomposition\n\n" #
        
        "PROCESSING:\n" #
        "The Universal Primitive Engine processes entities through four phases:\n" #
        "  1. STRIP — Remove surface wrappers to expose structure\n" #
        "  2. DESCEND — Trace downward to primitive foundations\n" #
        "  3. VERIFY — Confirm primitive elements are lawful\n" #
        "  4. RECOMPOSE — Build understanding from verified primitives\n\n" #
        
        "ENFORCEMENT:\n" #
        "The Primitive Registry enforces that no entity enters the system " #
        "without a verified primitive trace. Violations are logged and flagged."
    };
    
    /// Get example primitive traces
    public func getExamples() : [(Text, Text, Text)] {
        [
            (
                "Color (blue in interface)",
                "wavelength_band → perception_relation → cultural_symbolic_memory → field_state → system_orientation_marker",
                "Color in MEDINA architecture is not decoration. It is signal, doctrine, field state, and orientation encoding."
            ),
            (
                "Document (PDF or markdown file)",
                "memory_organism → compression_chamber → transfer_body → law_anchor → registry_crystal",
                "Documents must be classified by what living role they perform, not by file extension."
            ),
            (
                "Canister (ICP compute unit)",
                "computation_vessel → state_organism → consensus_participant → cycle_metabolizer → sovereignty_unit",
                "Canisters are sovereign organisms that metabolize cycles and participate in distributed consensus."
            ),
            (
                "Workflow (process sequence)",
                "process_organism → state_transition_graph → causality_chain → intention_crystallization → value_flow_channel",
                "Workflows are living processes where intention crystallizes into causality chains that flow value."
            )
        ]
    };
    
    // ================================================================== //
    // QUERY FUNCTIONS                                                     //
    // ================================================================== //
    
    /// Get document status
    public func status(state: DocumentOrganismState) : {
        doc_id: Text;
        name: Text;
        lifecycle: Text;
        roles: [Text];
        trace_depth: Nat;
        children_count: Nat;
        resonance: Float;
        transcended: Bool;
        update_count: Nat;
    } {
        let roleTexts = Array.map<DocumentRole, Text>(state.roles, roleToText);
        {
            doc_id = state.doc_id;
            name = state.name;
            lifecycle = lifecycleToText(state.lifecycle);
            roles = roleTexts;
            trace_depth = state.primitive_trace.size();
            children_count = state.children.size();
            resonance = state.resonance;
            transcended = state.transcended;
            update_count = state.update_count;
        }
    };
    
    /// Get primitive trace as readable format
    public func getReadableTrace(state: DocumentOrganismState) : Text {
        var result = "PRIMITIVE TRACE FOR " # state.name # ":\n";
        result := result # "=" # Text.fromChar('=') # Text.join("", Iter.fromArray(Array.tabulate<Text>(50, func(_) { "=" }))) # "\n\n";
        
        for (pt in state.primitive_trace.vals()) {
            result := result # "DEPTH " # Nat.toText(pt.depth) # ": " # roleToText(pt.role) # "\n";
            result := result # "  Domain: " # UniversalPrimitiveLaw.domainToText(pt.domain) # "\n";
            result := result # "  Description: " # pt.description # "\n\n";
        };
        
        result
    };
    
    /// Export document as text
    public func exportAsText(state: DocumentOrganismState) : Text {
        "╔═══════════════════════════════════════════════════════════════════════════╗\n" #
        "║                    " # DOC_ID # " — LIVING DOCUMENT                    ║\n" #
        "╚═══════════════════════════════════════════════════════════════════════════╝\n\n" #
        
        "ID: " # state.doc_id # "\n" #
        "Name: " # state.name # "\n" #
        "Lifecycle: " # lifecycleToText(state.lifecycle) # "\n" #
        "Resonance: " # Float.toText(state.resonance) # "\n" #
        "Transcended: " # (if (state.transcended) "YES" else "NO") # "\n" #
        "Children: " # Nat.toText(state.children.size()) # "\n" #
        "Updates: " # Nat.toText(state.update_count) # "\n\n" #
        
        "═══════════════════════════════════════════════════════════════════════════\n" #
        "                           LAW EXPLANATION                                  \n" #
        "═══════════════════════════════════════════════════════════════════════════\n\n" #
        
        getLawExplanation() # "\n\n" #
        
        "═══════════════════════════════════════════════════════════════════════════\n" #
        "                           PRIMITIVE TRACE                                  \n" #
        "═══════════════════════════════════════════════════════════════════════════\n\n" #
        
        getReadableTrace(state)
    };
}
