/**
 * DocumentOrganism Module — 24/7 Autonomous Self-Mutating Documents
 * 
 * NOT static text. NOT just content that resonates. LIVING ENTITIES with
 * lifecycle phases, metabolic processes, and self-mutation capabilities.
 * 
 * DOCUMENT LIFECYCLE PHASES:
 *   Germinating   — Initial creation, forming structure
 *   Growing       — Expanding content and connections
 *   Mature        — Stable, full functionality
 *   Reproducing   — Spawning child documents
 *   Mutating      — Undergoing self-modification
 *   Dormant       — Low energy, minimal activity
 *   Transcribing  — Being read/transmitted
 * 
 * PROPERTIES:
 *   phase           — Current lifecycle phase
 *   metabolicRate   — Processing speed (0.1 slow - 0.9 fast)
 *   energyLevel     — Current energy for operations [0,1]
 *   resonanceCharge — Accumulated resonance from being READ
 *   mutationPotential — Capacity for self-change (depletes with use)
 *   mutationHistory — Full record of all self-mutations
 * 
 * SELF-MUTATION TYPES:
 *   ContentExpansion  — Adds new content autonomously
 *   ContentRefinement — Improves existing content
 *   StructureChange   — Reorganizes internal structure
 *   LinkFormation     — Creates connections to other documents
 *   Reproduction      — Spawns child document
 *   Consolidation     — Absorbs child documents
 * 
 * MUTATION TRIGGERS:
 *   ScheduledCycle      — Regular metabolic cycle
 *   ResonanceThreshold  — Enough reads accumulated
 *   ExternalStimulus    — Another organism triggered it
 *   GrowthPressure      — Natural expansion need
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Char "mo:base/Char";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";

module {
    // ================================================================== //
    // DOCUMENT ORGANISM TYPES                                              //
    // ================================================================== //
    
    /// Document lifecycle phase
    public type LifecyclePhase = {
        #Germinating;
        #Growing;
        #Mature;
        #Reproducing;
        #Mutating;
        #Dormant;
        #Transcribing;
    };
    
    /// Self-mutation type
    public type MutationType = {
        #ContentExpansion;
        #ContentRefinement;
        #StructureChange;
        #LinkFormation;
        #Reproduction;
        #Consolidation;
    };
    
    /// Mutation trigger
    public type MutationTrigger = {
        #ScheduledCycle;
        #ResonanceThreshold;
        #ExternalStimulus;
        #GrowthPressure;
        #ManualInvocation;
    };
    
    /// Mutation record
    public type MutationRecord = {
        mutation_id: Text;
        mutation_type: MutationType;
        trigger: MutationTrigger;
        timestamp: Int;
        beat: Nat;
        description: Text;
        energy_cost: Float;
        potential_spent: Float;
        success: Bool;
    };
    
    /// Document content section
    public type ContentSection = {
        section_id: Text;
        title: Text;
        content: Text;
        order: Nat;
        created_at: Int;
        updated_at: Int;
    };
    
    /// Document link to another organism
    public type DocumentLink = {
        link_id: Text;
        target_id: Text;
        link_type: Text;  // "reference", "parent", "child", "sibling"
        strength: Float;  // [0,1] connection strength
        created_at: Int;
    };
    
    /// Reading event
    public type ReadingEvent = {
        read_id: Text;
        reader_id: Text;  // Who/what read the document
        timestamp: Int;
        beat: Nat;
        resonance_gained: Float;
        sections_read: [Text];  // Section IDs that were read
    };
    
    /// Document Organism - A living document entity
    public type DocumentOrganism = {
        // Identity
        organism_id: Text;
        name: Text;
        doc_type: Text;  // "constitution", "doctrine", "spec", "log", etc.
        
        // Lifecycle
        phase: LifecyclePhase;
        created_at: Int;
        last_activity: Int;
        age_beats: Nat;
        
        // Energy and metabolism
        metabolicRate: Float;      // [0.1, 0.9]
        energyLevel: Float;        // [0, 1]
        energyCapacity: Float;     // Maximum energy
        
        // Resonance
        resonanceCharge: Float;    // Accumulated from reads
        resonanceDecayRate: Float; // Per-beat decay
        
        // Mutation
        mutationPotential: Float;  // [0, 1] capacity for change
        mutationHistory: [MutationRecord];
        totalMutations: Nat;
        
        // Content
        sections: [ContentSection];
        contentHash: Text;
        
        // Connections
        links: [DocumentLink];
        parent_id: ?Text;
        child_ids: [Text];
        
        // Reading history
        readingHistory: [ReadingEvent];
        totalReads: Nat;
        
        // Torus coordinates
        theta: Float;
        phi: Float;
        depth: Float;
        ring: Nat;
    };
    
    // ================================================================== //
    // INITIALIZATION                                                       //
    // ================================================================== //
    
    /// Create a new document organism
    public func create(
        id: Text,
        name: Text,
        docType: Text,
        metabolicRate: Float,
        initialContent: Text
    ) : DocumentOrganism {
        let now = Time.now();
        
        // Create initial section
        let initialSection : ContentSection = {
            section_id = id # "_sec_0";
            title = "Introduction";
            content = initialContent;
            order = 0;
            created_at = now;
            updated_at = now;
        };
        
        // Calculate initial torus position using golden angle
        let theta = MatalkoICP.GOLDEN_ANGLE * 0.0;
        let phi = 0.0;
        
        {
            organism_id = id;
            name = name;
            doc_type = docType;
            phase = #Germinating;
            created_at = now;
            last_activity = now;
            age_beats = 0;
            metabolicRate = clamp(metabolicRate, 0.1, 0.9);
            energyLevel = 1.0;
            energyCapacity = 1.0;
            resonanceCharge = 0.0;
            resonanceDecayRate = 0.01;
            mutationPotential = 1.0;
            mutationHistory = [];
            totalMutations = 0;
            sections = [initialSection];
            contentHash = simpleHash(initialContent);
            links = [];
            parent_id = null;
            child_ids = [];
            readingHistory = [];
            totalReads = 0;
            theta = theta;
            phi = phi;
            depth = 1.0;
            ring = 0;
        }
    };
    
    /// Clamp value to range
    func clamp(v: Float, min: Float, max: Float) : Float {
        if (v < min) { min }
        else if (v > max) { max }
        else { v }
    };
    
    /// Simple hash function for content
    func simpleHash(content: Text) : Text {
        var hash : Nat32 = 0;
        for (char in content.chars()) {
            let charCode = Char.toNat32(char);
            hash := hash ^ (hash << 5);
            hash := hash +% charCode;
        };
        "hash_" # Nat32.toText(hash)
    };
    
    // ================================================================== //
    // LIFECYCLE OPERATIONS                                                 //
    // ================================================================== //
    
    /// Advance organism by one beat
    public func tick(organism: DocumentOrganism, beat: Nat) : DocumentOrganism {
        var updated = organism;
        
        // Update age
        updated := { updated with 
            age_beats = beat;
            last_activity = Time.now();
        };
        
        // Apply resonance decay
        let newResonance = Float.max(0.0, updated.resonanceCharge - updated.resonanceDecayRate);
        updated := { updated with resonanceCharge = newResonance };
        
        // Energy regeneration based on metabolic rate
        let energyRegen = updated.metabolicRate * 0.01;
        let newEnergy = Float.min(updated.energyCapacity, updated.energyLevel + energyRegen);
        updated := { updated with energyLevel = newEnergy };
        
        // Phase transitions based on state
        updated := updatePhase(updated);
        
        // Advance torus position using consistent scale factor from MatalkoICP
        let deltaTheta = MatalkoICP.TAU / (MatalkoICP.PHI ** 2.0 * MatalkoICP.PHASE_SCALE_FACTOR);
        let deltaPhi = MatalkoICP.TAU / (MatalkoICP.PHI ** 3.0 * MatalkoICP.PHASE_SCALE_FACTOR);
        let newTheta = updated.theta + deltaTheta * updated.metabolicRate;
        let newPhi = updated.phi + deltaPhi * updated.metabolicRate;
        let moduloTheta = newTheta - Float.floor(newTheta / MatalkoICP.TAU) * MatalkoICP.TAU;
        let moduloPhi = newPhi - Float.floor(newPhi / MatalkoICP.TAU) * MatalkoICP.TAU;
        let newRing = if (moduloPhi < updated.phi) { updated.ring + 1 } else { updated.ring };
        
        { updated with 
            theta = moduloTheta;
            phi = moduloPhi;
            ring = newRing;
        }
    };
    
    /// Update lifecycle phase based on organism state
    func updatePhase(organism: DocumentOrganism) : DocumentOrganism {
        let currentPhase = organism.phase;
        
        // Determine new phase based on metrics
        let newPhase : LifecyclePhase = if (organism.energyLevel < 0.1) {
            #Dormant
        } else if (organism.age_beats < 10) {
            #Germinating
        } else if (organism.mutationPotential > 0.7 and organism.resonanceCharge > 0.5) {
            #Growing
        } else if (organism.child_ids.size() > 0 or organism.mutationPotential < 0.3) {
            #Reproducing
        } else if (organism.resonanceCharge > 0.8) {
            #Transcribing
        } else if (organism.mutationPotential > 0.5) {
            #Mature
        } else {
            #Mutating
        };
        
        { organism with phase = newPhase }
    };
    
    /// Check if organism should trigger mutation
    public func shouldMutate(organism: DocumentOrganism) : (Bool, MutationTrigger) {
        // Check resonance threshold
        if (organism.resonanceCharge > 0.8 and organism.mutationPotential > 0.2) {
            return (true, #ResonanceThreshold);
        };
        
        // Check growth pressure (many reads, growing phase)
        switch (organism.phase) {
            case (#Growing) {
                if (organism.totalReads > 5 and organism.energyLevel > 0.5) {
                    return (true, #GrowthPressure);
                };
            };
            case (_) {};
        };
        
        // Scheduled cycle based on age
        if (organism.age_beats > 0 and organism.age_beats % 100 == 0) {
            if (organism.mutationPotential > 0.3 and organism.energyLevel > 0.3) {
                return (true, #ScheduledCycle);
            };
        };
        
        (false, #ScheduledCycle)
    };
    
    // ================================================================== //
    // READING OPERATIONS                                                   //
    // ================================================================== //
    
    /// Record that this document was read
    public func recordRead(
        organism: DocumentOrganism,
        readerId: Text,
        sectionIds: [Text],
        beat: Nat
    ) : DocumentOrganism {
        let now = Time.now();
        
        // Calculate resonance gained from read
        let baseResonance = 0.1;
        let sectionBonus = Float.fromInt(sectionIds.size()) * 0.02;
        let resonanceGained = baseResonance + sectionBonus;
        
        let readEvent : ReadingEvent = {
            read_id = organism.organism_id # "_read_" # Nat.toText(organism.totalReads);
            reader_id = readerId;
            timestamp = now;
            beat = beat;
            resonance_gained = resonanceGained;
            sections_read = sectionIds;
        };
        
        // Update reading history (keep last 100)
        let historyBuffer = Buffer.fromArray<ReadingEvent>(organism.readingHistory);
        historyBuffer.add(readEvent);
        let newHistory = if (historyBuffer.size() > 100) {
            let arr = Buffer.toArray(historyBuffer);
            let start = arr.size() - 100;
            Array.tabulate<ReadingEvent>(100, func(i: Nat) : ReadingEvent { arr[start + i] })
        } else {
            Buffer.toArray(historyBuffer)
        };
        
        { organism with
            resonanceCharge = Float.min(1.0, organism.resonanceCharge + resonanceGained);
            readingHistory = newHistory;
            totalReads = organism.totalReads + 1;
            last_activity = now;
            phase = #Transcribing;
        }
    };
    
    // ================================================================== //
    // MUTATION OPERATIONS                                                  //
    // ================================================================== //
    
    /// Perform content expansion mutation
    public func mutateContentExpansion(
        organism: DocumentOrganism,
        newContent: Text,
        sectionTitle: Text,
        beat: Nat
    ) : DocumentOrganism {
        let energyCost = 0.2;
        let potentialCost = 0.1;
        
        // Check resources
        if (organism.energyLevel < energyCost or organism.mutationPotential < potentialCost) {
            return organism;  // Cannot mutate
        };
        
        let now = Time.now();
        
        // Create new section
        let newSection : ContentSection = {
            section_id = organism.organism_id # "_sec_" # Nat.toText(organism.sections.size());
            title = sectionTitle;
            content = newContent;
            order = organism.sections.size();
            created_at = now;
            updated_at = now;
        };
        
        // Create mutation record
        let record : MutationRecord = {
            mutation_id = organism.organism_id # "_mut_" # Nat.toText(organism.totalMutations);
            mutation_type = #ContentExpansion;
            trigger = #ManualInvocation;
            timestamp = now;
            beat = beat;
            description = "Added section: " # sectionTitle;
            energy_cost = energyCost;
            potential_spent = potentialCost;
            success = true;
        };
        
        // Update sections
        let sectionsBuffer = Buffer.fromArray<ContentSection>(organism.sections);
        sectionsBuffer.add(newSection);
        
        // Update mutation history
        let historyBuffer = Buffer.fromArray<MutationRecord>(organism.mutationHistory);
        historyBuffer.add(record);
        
        { organism with
            sections = Buffer.toArray(sectionsBuffer);
            mutationHistory = Buffer.toArray(historyBuffer);
            totalMutations = organism.totalMutations + 1;
            energyLevel = organism.energyLevel - energyCost;
            mutationPotential = organism.mutationPotential - potentialCost;
            contentHash = simpleHash(newContent);
            last_activity = now;
            phase = #Mutating;
        }
    };
    
    /// Perform content refinement mutation
    public func mutateContentRefinement(
        organism: DocumentOrganism,
        sectionId: Text,
        refinedContent: Text,
        beat: Nat
    ) : DocumentOrganism {
        let energyCost = 0.15;
        let potentialCost = 0.05;
        
        if (organism.energyLevel < energyCost or organism.mutationPotential < potentialCost) {
            return organism;
        };
        
        let now = Time.now();
        
        // Find and update section
        var found = false;
        let updatedSections = Array.map<ContentSection, ContentSection>(
            organism.sections,
            func(sec: ContentSection) : ContentSection {
                if (sec.section_id == sectionId) {
                    found := true;
                    { sec with content = refinedContent; updated_at = now }
                } else {
                    sec
                }
            }
        );
        
        if (not found) {
            return organism;
        };
        
        let record : MutationRecord = {
            mutation_id = organism.organism_id # "_mut_" # Nat.toText(organism.totalMutations);
            mutation_type = #ContentRefinement;
            trigger = #ManualInvocation;
            timestamp = now;
            beat = beat;
            description = "Refined section: " # sectionId;
            energy_cost = energyCost;
            potential_spent = potentialCost;
            success = true;
        };
        
        let historyBuffer = Buffer.fromArray<MutationRecord>(organism.mutationHistory);
        historyBuffer.add(record);
        
        { organism with
            sections = updatedSections;
            mutationHistory = Buffer.toArray(historyBuffer);
            totalMutations = organism.totalMutations + 1;
            energyLevel = organism.energyLevel - energyCost;
            mutationPotential = organism.mutationPotential - potentialCost;
            contentHash = simpleHash(refinedContent);
            last_activity = now;
            phase = #Mutating;
        }
    };
    
    /// Form a link to another document
    public func mutateFormLink(
        organism: DocumentOrganism,
        targetId: Text,
        linkType: Text,
        strength: Float,
        beat: Nat
    ) : DocumentOrganism {
        let energyCost = 0.1;
        let potentialCost = 0.03;
        
        if (organism.energyLevel < energyCost or organism.mutationPotential < potentialCost) {
            return organism;
        };
        
        let now = Time.now();
        
        let newLink : DocumentLink = {
            link_id = organism.organism_id # "_link_" # Nat.toText(organism.links.size());
            target_id = targetId;
            link_type = linkType;
            strength = clamp(strength, 0.0, 1.0);
            created_at = now;
        };
        
        let record : MutationRecord = {
            mutation_id = organism.organism_id # "_mut_" # Nat.toText(organism.totalMutations);
            mutation_type = #LinkFormation;
            trigger = #ManualInvocation;
            timestamp = now;
            beat = beat;
            description = "Formed link to: " # targetId;
            energy_cost = energyCost;
            potential_spent = potentialCost;
            success = true;
        };
        
        let linksBuffer = Buffer.fromArray<DocumentLink>(organism.links);
        linksBuffer.add(newLink);
        
        let historyBuffer = Buffer.fromArray<MutationRecord>(organism.mutationHistory);
        historyBuffer.add(record);
        
        { organism with
            links = Buffer.toArray(linksBuffer);
            mutationHistory = Buffer.toArray(historyBuffer);
            totalMutations = organism.totalMutations + 1;
            energyLevel = organism.energyLevel - energyCost;
            mutationPotential = organism.mutationPotential - potentialCost;
            last_activity = now;
            phase = #Mutating;
        }
    };
    
    /// Reproduce - spawn a child document
    public func reproduce(
        organism: DocumentOrganism,
        childId: Text,
        childName: Text,
        beat: Nat
    ) : (DocumentOrganism, DocumentOrganism) {
        let energyCost = 0.4;
        let potentialCost = 0.2;
        
        let now = Time.now();
        
        // Create child with inherited traits
        let child = {
            organism_id = childId;
            name = childName;
            doc_type = organism.doc_type;
            phase = #Germinating;
            created_at = now;
            last_activity = now;
            age_beats = beat;
            metabolicRate = organism.metabolicRate * 0.9 + 0.05;  // Slight variation
            energyLevel = 0.5;  // Start with half energy
            energyCapacity = organism.energyCapacity;
            resonanceCharge = 0.0;
            resonanceDecayRate = organism.resonanceDecayRate;
            mutationPotential = 1.0;
            mutationHistory = [];
            totalMutations = 0;
            sections = [];  // Empty initially
            contentHash = "";
            links = [];
            parent_id = ?organism.organism_id;
            child_ids = [];
            readingHistory = [];
            totalReads = 0;
            theta = organism.theta + MatalkoICP.GOLDEN_ANGLE;
            phi = organism.phi + MatalkoICP.GOLDEN_ANGLE * MatalkoICP.PHI;
            depth = organism.depth * 0.8;
            ring = organism.ring;
        };
        
        let record : MutationRecord = {
            mutation_id = organism.organism_id # "_mut_" # Nat.toText(organism.totalMutations);
            mutation_type = #Reproduction;
            trigger = #ManualInvocation;
            timestamp = now;
            beat = beat;
            description = "Spawned child: " # childId;
            energy_cost = energyCost;
            potential_spent = potentialCost;
            success = true;
        };
        
        let childIdsBuffer = Buffer.fromArray<Text>(organism.child_ids);
        childIdsBuffer.add(childId);
        
        let historyBuffer = Buffer.fromArray<MutationRecord>(organism.mutationHistory);
        historyBuffer.add(record);
        
        let updatedParent = { organism with
            child_ids = Buffer.toArray(childIdsBuffer);
            mutationHistory = Buffer.toArray(historyBuffer);
            totalMutations = organism.totalMutations + 1;
            energyLevel = Float.max(0.1, organism.energyLevel - energyCost);
            mutationPotential = Float.max(0.1, organism.mutationPotential - potentialCost);
            last_activity = now;
            phase = #Reproducing;
        };
        
        (updatedParent, child)
    };
    
    // ================================================================== //
    // QUERY OPERATIONS                                                     //
    // ================================================================== //
    
    /// Get organism status summary
    public func status(organism: DocumentOrganism) : {
        id: Text;
        name: Text;
        phase: LifecyclePhase;
        age: Nat;
        energy: Float;
        resonance: Float;
        mutationPotential: Float;
        totalMutations: Nat;
        totalReads: Nat;
        sectionCount: Nat;
        linkCount: Nat;
        childCount: Nat;
    } {
        {
            id = organism.organism_id;
            name = organism.name;
            phase = organism.phase;
            age = organism.age_beats;
            energy = organism.energyLevel;
            resonance = organism.resonanceCharge;
            mutationPotential = organism.mutationPotential;
            totalMutations = organism.totalMutations;
            totalReads = organism.totalReads;
            sectionCount = organism.sections.size();
            linkCount = organism.links.size();
            childCount = organism.child_ids.size();
        }
    };
    
    /// Get all content as single text
    public func getAllContent(organism: DocumentOrganism) : Text {
        var content = "";
        for (section in organism.sections.vals()) {
            content := content # "## " # section.title # "\n\n" # section.content # "\n\n";
        };
        content
    };
    
    /// Calculate total resonance from reading history
    public func totalResonanceGained(organism: DocumentOrganism) : Float {
        var total : Float = 0.0;
        for (event in organism.readingHistory.vals()) {
            total += event.resonance_gained;
        };
        total
    };
}
