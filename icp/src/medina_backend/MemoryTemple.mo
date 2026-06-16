/**
 * MEDINA Memory Temple Module — Operational memory workspace.
 * 
 * Memory as navigable geometry with lineage tracking.
 * Implements toroidal coordinate system for memory positioning.
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

import Types "Types";
import Utils "Utils";

module {
    public type MemoryNode = Types.MemoryNode;
    public type MemoryQuery = Types.MemoryQuery;
    public type MemoryType = Types.MemoryType;
    public type ConsolidationState = Types.ConsolidationState;
    public type MemoryCoordinates = Types.MemoryCoordinates;
    
    /// Memory Temple state
    public type TempleState = {
        var nodes: [(Text, MemoryNode)];
        var currentCoords: MemoryCoordinates;
        var beat: Nat;
        var ring: Nat;
        var created_at: Int;
        var idCounter: Nat;
    };
    
    /// Phase advancement rates (φ-scaled for natural cadence)
    let DELTA_THETA : Float = Utils.TWO_PI / (Types.PHI * Types.PHI * 10.0);
    let DELTA_PHI : Float = Utils.TWO_PI / (Types.PHI * Types.PHI * Types.PHI * 10.0);
    
    /// Initialize a new Memory Temple
    public func init() : TempleState {
        {
            var nodes = [];
            var currentCoords = {
                theta = 0.0;
                phi = 0.0;
                depth = 1.0;
                ring = 0;
                beat = 0;
            };
            var beat = 0;
            var ring = 0;
            var created_at = Time.now();
            var idCounter = 0;
        }
    };
    
    /// Advance coordinates by delta values
    func advanceCoords(coords: MemoryCoordinates, deltaTheta: Float, deltaPhi: Float, newBeat: Nat) : MemoryCoordinates {
        let newTheta = Utils.fmod(coords.theta + deltaTheta, Utils.TWO_PI);
        let newPhi = Utils.fmod(coords.phi + deltaPhi, Utils.TWO_PI);
        let newRing = if (newPhi < coords.phi) { coords.ring + 1 } else { coords.ring };
        
        {
            theta = newTheta;
            phi = newPhi;
            depth = coords.depth;
            ring = newRing;
            beat = newBeat;
        }
    };
    
    /// Convert toroidal coordinates to Cartesian (x, y, z)
    public func toXYZ(coords: MemoryCoordinates) : (Float, Float, Float) {
        let r = Types.TORUS_R;
        let x = (r + coords.depth * Float.cos(coords.theta)) * Float.cos(coords.phi);
        let y = (r + coords.depth * Float.cos(coords.theta)) * Float.sin(coords.phi);
        let z = coords.depth * Float.sin(coords.theta);
        (x, y, z)
    };
    
    /// Calculate Euclidean distance between two coordinates
    public func distance(c1: MemoryCoordinates, c2: MemoryCoordinates) : Float {
        let (x1, y1, z1) = toXYZ(c1);
        let (x2, y2, z2) = toXYZ(c2);
        let dx = x2 - x1;
        let dy = y2 - y1;
        let dz = z2 - z1;
        Float.sqrt(dx*dx + dy*dy + dz*dz)
    };
    
    /// Store a new memory in the temple
    public func store(
        state: TempleState,
        content: Text,
        summary: Text,
        tags: [Text],
        memoryType: MemoryType,
        parentId: ?Text,
        salience: Float
    ) : MemoryNode {
        // Advance coordinates for this memory
        let newCoords = advanceCoords(state.currentCoords, DELTA_THETA, DELTA_PHI, state.beat);
        
        state.idCounter += 1;
        let now = Time.now();
        
        let node : MemoryNode = {
            node_id = Utils.generateId("mem", state.idCounter);
            parent_id = parentId;
            content = content;
            summary = summary;
            tags = tags;
            memory_type = memoryType;
            state = #FRESH;
            coordinates = newCoords;
            salience_score = Utils.clamp(salience, 0.0, 1.0);
            pinned = false;
            created_at = now;
            updated_at = now;
            accessed_at = now;
        };
        
        // Add to nodes
        let buffer = Buffer.fromArray<(Text, MemoryNode)>(state.nodes);
        buffer.add((node.node_id, node));
        state.nodes := Buffer.toArray(buffer);
        
        state.currentCoords := newCoords;
        state.beat += 1;
        
        if (newCoords.ring > state.ring) {
            state.ring := newCoords.ring;
        };
        
        node
    };
    
    /// Get a memory by ID
    public func get(state: TempleState, nodeId: Text) : ?MemoryNode {
        for ((id, node) in state.nodes.vals()) {
            if (id == nodeId) {
                return ?node;
            };
        };
        null
    };
    
    /// Check if memory type matches
    func memoryTypeEqual(a: MemoryType, b: MemoryType) : Bool {
        switch (a, b) {
            case (#EPISODIC, #EPISODIC) true;
            case (#SEMANTIC, #SEMANTIC) true;
            case (#PROCEDURAL, #PROCEDURAL) true;
            case (#WORKING, #WORKING) true;
            case (#DOCTRINE, #DOCTRINE) true;
            case (_, _) false;
        }
    };
    
    /// Check if consolidation state matches
    func consolidationStateEqual(a: ConsolidationState, b: ConsolidationState) : Bool {
        switch (a, b) {
            case (#FRESH, #FRESH) true;
            case (#STABLE, #STABLE) true;
            case (#CONSOLIDATING, #CONSOLIDATING) true;
            case (#CONSOLIDATED, #CONSOLIDATED) true;
            case (#PROMOTED, #PROMOTED) true;
            case (#ARCHIVED, #ARCHIVED) true;
            case (_, _) false;
        }
    };
    
    /// Find memories matching query criteria
    public func find(state: TempleState, query: MemoryQuery) : [MemoryNode] {
        let results = Buffer.Buffer<MemoryNode>(16);
        
        for ((_, node) in state.nodes.vals()) {
            // Apply filters
            switch (query.memory_type) {
                case (?mt) {
                    if (not memoryTypeEqual(node.memory_type, mt)) {
                        continue results.vals();
                    };
                };
                case null {};
            };
            
            switch (query.state) {
                case (?s) {
                    if (not consolidationStateEqual(node.state, s)) {
                        continue results.vals();
                    };
                };
                case null {};
            };
            
            if (query.pinned_only and not node.pinned) {
                continue results.vals();
            };
            
            if (node.salience_score < query.min_salience or node.salience_score > query.max_salience) {
                continue results.vals();
            };
            
            switch (query.ring) {
                case (?r) {
                    if (node.coordinates.ring != r) {
                        continue results.vals();
                    };
                };
                case null {};
            };
            
            switch (query.from_beat) {
                case (?fb) {
                    if (node.coordinates.beat < fb) {
                        continue results.vals();
                    };
                };
                case null {};
            };
            
            switch (query.to_beat) {
                case (?tb) {
                    if (node.coordinates.beat > tb) {
                        continue results.vals();
                    };
                };
                case null {};
            };
            
            // Text search in summary and content
            switch (query.text) {
                case (?searchText) {
                    if (not Utils.containsIgnoreCase(node.summary, searchText) and
                        not Utils.containsIgnoreCase(node.content, searchText)) {
                        continue results.vals();
                    };
                };
                case null {};
            };
            
            // Tag filter
            switch (query.tags) {
                case (?searchTags) {
                    var found = false;
                    label tagLoop for (st in searchTags.vals()) {
                        for (nt in node.tags.vals()) {
                            if (Text.toLowercase(st) == Text.toLowercase(nt)) {
                                found := true;
                                break tagLoop;
                            };
                        };
                    };
                    if (not found) {
                        continue results.vals();
                    };
                };
                case null {};
            };
            
            results.add(node);
        };
        
        // Sort by salience descending (simple approach - return as-is for now)
        // In production, implement proper sorting
        let arr = Buffer.toArray(results);
        
        // Apply limit
        Utils.take(arr, query.limit)
    };
    
    /// Pin a memory
    public func pin(state: TempleState, nodeId: Text) : Bool {
        let now = Time.now();
        var found = false;
        
        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    (id, {
                        node with 
                        pinned = true;
                        updated_at = now;
                    })
                } else {
                    (id, node)
                }
            }
        );
        
        found
    };
    
    /// Unpin a memory
    public func unpin(state: TempleState, nodeId: Text) : Bool {
        let now = Time.now();
        var found = false;
        
        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    (id, {
                        node with 
                        pinned = false;
                        updated_at = now;
                    })
                } else {
                    (id, node)
                }
            }
        );
        
        found
    };
    
    /// Promote a memory to higher salience
    public func promote(state: TempleState, nodeId: Text, salienceBoost: Float) : Bool {
        let now = Time.now();
        var found = false;
        
        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    let newSalience = Utils.clamp(node.salience_score + salienceBoost, 0.0, 1.0);
                    (id, {
                        node with 
                        salience_score = newSalience;
                        state = #PROMOTED;
                        updated_at = now;
                    })
                } else {
                    (id, node)
                }
            }
        );
        
        found
    };
    
    /// Get memories at a specific ring
    public func memoriesAtRing(state: TempleState, ring: Nat) : [MemoryNode] {
        let results = Buffer.Buffer<MemoryNode>(8);
        for ((_, node) in state.nodes.vals()) {
            if (node.coordinates.ring == ring) {
                results.add(node);
            };
        };
        Buffer.toArray(results)
    };
    
    /// Get memories in a beat range
    public func memoriesInBeatRange(state: TempleState, fromBeat: Nat, toBeat: Nat) : [MemoryNode] {
        let results = Buffer.Buffer<MemoryNode>(16);
        for ((_, node) in state.nodes.vals()) {
            if (node.coordinates.beat >= fromBeat and node.coordinates.beat <= toBeat) {
                results.add(node);
            };
        };
        Buffer.toArray(results)
    };
    
    /// Trace lineage from a memory back to its root
    public func lineage(state: TempleState, nodeId: Text) : [MemoryNode] {
        let chain = Buffer.Buffer<MemoryNode>(8);
        var currentId : ?Text = ?nodeId;
        
        label lineageLoop while (Option.isSome(currentId)) {
            switch (currentId) {
                case (?id) {
                    switch (get(state, id)) {
                        case (?node) {
                            chain.add(node);
                            currentId := node.parent_id;
                        };
                        case null {
                            break lineageLoop;
                        };
                    };
                };
                case null {
                    break lineageLoop;
                };
            };
        };
        
        // Reverse to get root-to-node order
        let arr = Buffer.toArray(chain);
        Array.reverse(arr)
    };
    
    /// Get temple status
    public func status(state: TempleState) : {
        total_memories: Nat;
        current_beat: Nat;
        current_ring: Nat;
        pinned_count: Nat;
    } {
        var pinnedCount : Nat = 0;
        for ((_, node) in state.nodes.vals()) {
            if (node.pinned) {
                pinnedCount += 1;
            };
        };
        
        {
            total_memories = state.nodes.size();
            current_beat = state.beat;
            current_ring = state.ring;
            pinned_count = pinnedCount;
        }
    };
    
    /// Get total memory count
    public func count(state: TempleState) : Nat {
        state.nodes.size()
    };
}
