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

    // ═══════════════════════════════════════════════════════════════════════
    // CONSOLIDATION — Merge related memories into one
    // ═══════════════════════════════════════════════════════════════════════

    /// Consolidate multiple memories into a single merged memory.
    /// Original nodes are marked CONSOLIDATED. New node inherits merged tags and avg salience.
    public func consolidate(
        state: TempleState,
        nodeIds: [Text],
        mergedContent: Text,
        mergedSummary: Text
    ) : ?MemoryNode {
        // Gather all valid nodes
        let validNodes = Buffer.Buffer<MemoryNode>(nodeIds.size());
        for (nid in nodeIds.vals()) {
            switch (get(state, nid)) {
                case (?node) { validNodes.add(node) };
                case null {};
            };
        };

        if (validNodes.size() == 0) { return null };

        // Merge tags (deduplicated)
        let allTags = Buffer.Buffer<Text>(16);
        for (node in validNodes.vals()) {
            for (tag in node.tags.vals()) {
                var found = false;
                for (existing in allTags.vals()) {
                    if (Text.toLowercase(tag) == Text.toLowercase(existing)) {
                        found := true;
                    };
                };
                if (not found) { allTags.add(tag) };
            };
        };

        // Calculate average salience + consolidation boost
        var totalSalience : Float = 0.0;
        for (node in validNodes.vals()) {
            totalSalience += node.salience_score;
        };
        let avgSalience = totalSalience / Float.fromInt(validNodes.size());
        let boostedSalience = Utils.clamp(avgSalience + 0.1, 0.0, 1.0);

        // Create consolidated node
        let consolidated = store(
            state,
            mergedContent,
            mergedSummary,
            Buffer.toArray(allTags),
            #SEMANTIC,
            null,
            boostedSalience
        );

        // Mark originals as CONSOLIDATED
        let now = Time.now();
        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                var isTarget = false;
                for (nid in nodeIds.vals()) {
                    if (id == nid) { isTarget := true };
                };
                if (isTarget) {
                    (id, { node with state = #CONSOLIDATED; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        ?consolidated
    };

    // ═══════════════════════════════════════════════════════════════════════
    // ARCHIVE — Move low-salience memories to cold storage
    // ═══════════════════════════════════════════════════════════════════════

    /// Archive a memory (mark as ARCHIVED)
    public func archive(state: TempleState, nodeId: Text) : Bool {
        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    (id, { node with state = #ARCHIVED; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    /// Bulk archive all memories below a salience threshold (skips pinned)
    public func archiveBelowSalience(state: TempleState, threshold: Float) : Nat {
        let now = Time.now();
        var count : Nat = 0;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (node.salience_score < threshold and not node.pinned and not consolidationStateEqual(node.state, #ARCHIVED)) {
                    count += 1;
                    (id, { node with state = #ARCHIVED; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        count
    };

    // ═══════════════════════════════════════════════════════════════════════
    // DECAY — Apply salience decay to all non-immune memories
    // ═══════════════════════════════════════════════════════════════════════

    /// Apply decay to a single memory's salience
    public func decay(state: TempleState, nodeId: Text, decayAmount: Float, floor: Float) : Bool {
        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId and not node.pinned) {
                    found := true;
                    let newSalience = Float.max(floor, node.salience_score - decayAmount);
                    (id, { node with salience_score = newSalience; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    /// Apply decay to ALL non-pinned, non-archived memories
    public func decayAll(state: TempleState, decayRate: Float, floor: Float) : Nat {
        let now = Time.now();
        var count : Nat = 0;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (not node.pinned and not consolidationStateEqual(node.state, #ARCHIVED)) {
                    let newSalience = Float.max(floor, node.salience_score - decayRate);
                    if (newSalience != node.salience_score) {
                        count += 1;
                    };
                    (id, { node with salience_score = newSalience; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        count
    };

    // ═══════════════════════════════════════════════════════════════════════
    // DESCENDANTS — Find all children of a memory node
    // ═══════════════════════════════════════════════════════════════════════

    /// Get immediate children of a memory
    public func children(state: TempleState, parentId: Text) : [MemoryNode] {
        let results = Buffer.Buffer<MemoryNode>(8);
        for ((_, node) in state.nodes.vals()) {
            switch (node.parent_id) {
                case (?pid) {
                    if (pid == parentId) {
                        results.add(node);
                    };
                };
                case null {};
            };
        };
        Buffer.toArray(results)
    };

    /// Get all descendants (children, grandchildren, etc.) recursively
    public func descendants(state: TempleState, rootId: Text) : [MemoryNode] {
        let results = Buffer.Buffer<MemoryNode>(16);
        let queue = Buffer.Buffer<Text>(8);
        queue.add(rootId);

        var i : Nat = 0;
        while (i < queue.size()) {
            let currentId = queue.get(i);
            for ((_, node) in state.nodes.vals()) {
                switch (node.parent_id) {
                    case (?pid) {
                        if (pid == currentId) {
                            results.add(node);
                            queue.add(node.node_id);
                        };
                    };
                    case null {};
                };
            };
            i += 1;
        };

        Buffer.toArray(results)
    };

    // ═══════════════════════════════════════════════════════════════════════
    // NEAREST — Proximity-based retrieval in torus geometry
    // ═══════════════════════════════════════════════════════════════════════

    /// Find the nearest memories to given coordinates
    public func nearestTo(state: TempleState, coords: MemoryCoordinates, limit: Nat) : [MemoryNode] {
        // Collect all nodes with distances
        let withDist = Buffer.Buffer<(MemoryNode, Float)>(state.nodes.size());
        for ((_, node) in state.nodes.vals()) {
            let dist = distance(coords, node.coordinates);
            withDist.add((node, dist));
        };

        // Sort by distance (simple insertion sort for correctness)
        let arr = Buffer.toArray(withDist);
        let sorted = Array.sort<(MemoryNode, Float)>(arr, func(a, b) {
            Float.compare(a.1, b.1)
        });

        // Take top N
        let results = Buffer.Buffer<MemoryNode>(limit);
        var taken : Nat = 0;
        for ((node, _) in sorted.vals()) {
            if (taken < limit) {
                results.add(node);
                taken += 1;
            };
        };
        Buffer.toArray(results)
    };

    // ═══════════════════════════════════════════════════════════════════════
    // UPDATE CONTENT — Modify an existing memory's content
    // ═══════════════════════════════════════════════════════════════════════

    /// Update a memory's content and summary
    public func updateContent(state: TempleState, nodeId: Text, newContent: Text, newSummary: Text) : Bool {
        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    (id, { node with content = newContent; summary = newSummary; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    /// Update a memory's tags
    public func updateTags(state: TempleState, nodeId: Text, newTags: [Text]) : Bool {
        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    (id, { node with tags = newTags; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    // ═══════════════════════════════════════════════════════════════════════
    // REPLAY — Generate ordered replay of memory operations
    // ═══════════════════════════════════════════════════════════════════════

    /// Generate replay bundle: all memories in beat range, ordered by beat
    public func replay(state: TempleState, fromBeat: Nat, toBeat: Nat) : [MemoryNode] {
        let results = Buffer.Buffer<MemoryNode>(16);
        for ((_, node) in state.nodes.vals()) {
            if (node.coordinates.beat >= fromBeat and node.coordinates.beat <= toBeat) {
                results.add(node);
            };
        };

        let arr = Buffer.toArray(results);
        Array.sort<MemoryNode>(arr, func(a, b) {
            Nat.compare(a.coordinates.beat, b.coordinates.beat)
        })
    };

    // ═══════════════════════════════════════════════════════════════════════
    // MAP TOPOLOGY — Visualize memory temple structure
    // ═══════════════════════════════════════════════════════════════════════

    /// Ring summary: how many memories in each ring
    public type RingSummary = {
        ring: Nat;
        count: Nat;
        avgSalience: Float;
        pinnedCount: Nat;
    };

    /// Get ring-by-ring summary of the memory topology
    public func mapTopology(state: TempleState) : [RingSummary] {
        // Find max ring
        var maxRing : Nat = 0;
        for ((_, node) in state.nodes.vals()) {
            if (node.coordinates.ring > maxRing) {
                maxRing := node.coordinates.ring;
            };
        };

        // Build per-ring summaries
        let summaries = Buffer.Buffer<RingSummary>(maxRing + 1);
        var r : Nat = 0;
        while (r <= maxRing) {
            var cnt : Nat = 0;
            var totalSalience : Float = 0.0;
            var pinCnt : Nat = 0;

            for ((_, node) in state.nodes.vals()) {
                if (node.coordinates.ring == r) {
                    cnt += 1;
                    totalSalience += node.salience_score;
                    if (node.pinned) { pinCnt += 1 };
                };
            };

            if (cnt > 0) {
                summaries.add({
                    ring = r;
                    count = cnt;
                    avgSalience = totalSalience / Float.fromInt(cnt);
                    pinnedCount = pinCnt;
                });
            };

            r += 1;
        };

        Buffer.toArray(summaries)
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SALIENCE ANALYSIS — Distribution and top-salient queries
    // ═══════════════════════════════════════════════════════════════════════

    /// Salience distribution across levels
    public type SalienceDistribution = {
        critical: Nat;   // 0.9 - 1.0
        high: Nat;       // 0.7 - 0.9
        medium: Nat;     // 0.4 - 0.7
        low: Nat;        // 0.2 - 0.4
        negligible: Nat; // 0.0 - 0.2
    };

    /// Get salience distribution
    public func salienceDistribution(state: TempleState) : SalienceDistribution {
        var critical : Nat = 0;
        var high : Nat = 0;
        var medium : Nat = 0;
        var low : Nat = 0;
        var negligible : Nat = 0;

        for ((_, node) in state.nodes.vals()) {
            let s = node.salience_score;
            if (s >= 0.9) { critical += 1 }
            else if (s >= 0.7) { high += 1 }
            else if (s >= 0.4) { medium += 1 }
            else if (s >= 0.2) { low += 1 }
            else { negligible += 1 };
        };

        { critical; high; medium; low; negligible }
    };

    /// Get top N most salient memories
    public func topSalient(state: TempleState, limit: Nat) : [MemoryNode] {
        let all = Buffer.Buffer<MemoryNode>(state.nodes.size());
        for ((_, node) in state.nodes.vals()) {
            all.add(node);
        };

        let arr = Buffer.toArray(all);
        let sorted = Array.sort<MemoryNode>(arr, func(a, b) {
            Float.compare(b.salience_score, a.salience_score) // descending
        });

        Utils.take(sorted, limit)
    };

    /// Get decay candidates: non-pinned memories below threshold
    public func decayCandidates(state: TempleState, threshold: Float) : [MemoryNode] {
        let results = Buffer.Buffer<MemoryNode>(8);
        for ((_, node) in state.nodes.vals()) {
            if (node.salience_score < threshold and not node.pinned) {
                results.add(node);
            };
        };
        Buffer.toArray(results)
    };

    // ═══════════════════════════════════════════════════════════════════════
    // TYPE-BASED QUERIES — Filter by memory type
    // ═══════════════════════════════════════════════════════════════════════

    /// Get all memories of a specific type
    public func memoriesByType(state: TempleState, memType: MemoryType) : [MemoryNode] {
        let results = Buffer.Buffer<MemoryNode>(8);
        for ((_, node) in state.nodes.vals()) {
            if (memoryTypeEqual(node.memory_type, memType)) {
                results.add(node);
            };
        };
        Buffer.toArray(results)
    };

    /// Get count of memories by type
    public type TypeDistribution = {
        episodic: Nat;
        semantic: Nat;
        procedural: Nat;
        working: Nat;
        doctrine: Nat;
    };

    public func typeDistribution(state: TempleState) : TypeDistribution {
        var episodic : Nat = 0;
        var semantic : Nat = 0;
        var procedural : Nat = 0;
        var working : Nat = 0;
        var doctrine : Nat = 0;

        for ((_, node) in state.nodes.vals()) {
            switch (node.memory_type) {
                case (#EPISODIC) { episodic += 1 };
                case (#SEMANTIC) { semantic += 1 };
                case (#PROCEDURAL) { procedural += 1 };
                case (#WORKING) { working += 1 };
                case (#DOCTRINE) { doctrine += 1 };
            };
        };

        { episodic; semantic; procedural; working; doctrine }
    };

    // ═══════════════════════════════════════════════════════════════════════
    // STATE-BASED QUERIES — Filter by consolidation state
    // ═══════════════════════════════════════════════════════════════════════

    /// Get all memories in a specific consolidation state
    public func memoriesByState(state: TempleState, queryState: ConsolidationState) : [MemoryNode] {
        let results = Buffer.Buffer<MemoryNode>(8);
        for ((_, node) in state.nodes.vals()) {
            if (consolidationStateEqual(node.state, queryState)) {
                results.add(node);
            };
        };
        Buffer.toArray(results)
    };

    // ═══════════════════════════════════════════════════════════════════════
    // EXTENDED STATUS — Full temple health report
    // ═══════════════════════════════════════════════════════════════════════

    /// Full temple status including type/state/salience distributions
    public type FullStatus = {
        total_memories: Nat;
        current_beat: Nat;
        current_ring: Nat;
        pinned_count: Nat;
        type_distribution: TypeDistribution;
        salience_distribution: SalienceDistribution;
        archived_count: Nat;
        consolidated_count: Nat;
    };

    public func fullStatus(state: TempleState) : FullStatus {
        let basic = status(state);
        let typeDist = typeDistribution(state);
        let salDist = salienceDistribution(state);

        var archivedCount : Nat = 0;
        var consolidatedCount : Nat = 0;

        for ((_, node) in state.nodes.vals()) {
            if (consolidationStateEqual(node.state, #ARCHIVED)) { archivedCount += 1 };
            if (consolidationStateEqual(node.state, #CONSOLIDATED)) { consolidatedCount += 1 };
        };

        {
            total_memories = basic.total_memories;
            current_beat = basic.current_beat;
            current_ring = basic.current_ring;
            pinned_count = basic.pinned_count;
            type_distribution = typeDist;
            salience_distribution = salDist;
            archived_count = archivedCount;
            consolidated_count = consolidatedCount;
        }
    };

    // ╔═══════════════════════════════════════════════════════════════════════╗
    // ║  DUALITY ENGINE — "Omnis actio habet reactionem."                    ║
    // ║  Every operation has its opposite. Every 1 has its 0.                ║
    // ║  Outward ↔ Inward · Action ↔ Reaction · Yes ↔ No · 1 ↔ 0           ║
    // ╚═══════════════════════════════════════════════════════════════════════╝

    // ═══════════════════════════════════════════════════════════════════════
    // PAIR 1: OUTWARD ↔ INWARD — Emit and Absorb
    // "Quod emittitur, absorbetur." (What is emitted, is absorbed.)
    // ═══════════════════════════════════════════════════════════════════════

    /// Emit: export a memory outward as a portable bundle (content + tags + salience + coordinates)
    public type EmittedMemory = {
        node_id: Text;
        content: Text;
        summary: Text;
        tags: [Text];
        memory_type: MemoryType;
        salience_score: Float;
        coordinates: MemoryCoordinates;
        emitted_at: Int;
    };

    public func emit(state: TempleState, nodeId: Text) : ?EmittedMemory {
        switch (get(state, nodeId)) {
            case (?node) {
                ?{
                    node_id = node.node_id;
                    content = node.content;
                    summary = node.summary;
                    tags = node.tags;
                    memory_type = node.memory_type;
                    salience_score = node.salience_score;
                    coordinates = node.coordinates;
                    emitted_at = Time.now();
                }
            };
            case null { null };
        }
    };

    /// Absorb: import an external memory bundle inward, creating a new node
    public func absorb(
        state: TempleState,
        content: Text,
        summary: Text,
        tags: [Text],
        memoryType: MemoryType,
        salience: Float,
        sourceId: ?Text
    ) : MemoryNode {
        // Absorb creates a new memory with an explicit parent reference to the source
        store(state, content, summary, tags, memoryType, sourceId, salience)
    };

    // ═══════════════════════════════════════════════════════════════════════
    // PAIR 2: ACTION ↔ REACTION — Activate and Deactivate
    // "Actio et reactio aequales sunt." (Action and reaction are equal.)
    // ═══════════════════════════════════════════════════════════════════════

    /// Activate: mark a memory as active/hot — set state to FRESH + salience boost
    public func activate(state: TempleState, nodeId: Text, boost: Float) : Bool {
        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    let newSalience = Utils.clamp(node.salience_score + boost, 0.0, 1.0);
                    (id, { node with state = #FRESH; salience_score = newSalience; accessed_at = now; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    /// Deactivate: mark a memory as dormant/cold — set state to STABLE + salience drop
    public func deactivate(state: TempleState, nodeId: Text, drop: Float) : Bool {
        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    let newSalience = Utils.clamp(node.salience_score - drop, 0.0, 1.0);
                    (id, { node with state = #STABLE; salience_score = newSalience; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    // ═══════════════════════════════════════════════════════════════════════
    // PAIR 3: YES ↔ NO — Affirm and Deny
    // "Sic et Non." (Yes and No.)
    // ═══════════════════════════════════════════════════════════════════════

    /// Affirm: strengthen a memory's salience by agreement (φ-scaled boost)
    public func affirm(state: TempleState, nodeId: Text) : Bool {
        let now = Time.now();
        var found = false;
        let PHI_BOOST : Float = 1.0 / Types.PHI; // ~0.618

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    let gap = 1.0 - node.salience_score;
                    let boost = gap * PHI_BOOST; // Approach 1.0 by φ-proportion
                    let newSalience = Utils.clamp(node.salience_score + boost, 0.0, 1.0);
                    (id, { node with salience_score = newSalience; state = #PROMOTED; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    /// Deny: weaken a memory's salience by contradiction (φ-scaled decay)
    public func deny(state: TempleState, nodeId: Text) : Bool {
        let now = Time.now();
        var found = false;
        let PHI_DECAY : Float = 1.0 / Types.PHI; // ~0.618

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId and not node.pinned) {
                    found := true;
                    let decay = node.salience_score * PHI_DECAY; // Lose φ-proportion
                    let newSalience = Utils.clamp(node.salience_score - decay, 0.0, 1.0);
                    (id, { node with salience_score = newSalience; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    // ═══════════════════════════════════════════════════════════════════════
    // PAIR 4: 1 ↔ 0 — Energize and Zero
    // "Unum et Nihilum." (One and Nothing.)
    // ═══════════════════════════════════════════════════════════════════════

    /// Energize: set salience to maximum 1.0 (full power)
    public func energize(state: TempleState, nodeId: Text) : Bool {
        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    (id, { node with salience_score = 1.0; state = #PROMOTED; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    /// Zero: set salience to minimum 0.0 (no power)
    public func zero(state: TempleState, nodeId: Text) : Bool {
        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId and not node.pinned) {
                    found := true;
                    (id, { node with salience_score = 0.0; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    // ═══════════════════════════════════════════════════════════════════════
    // PAIR 5: EXPAND ↔ CONTRACT — Fork and Merge children
    // "Expandere et contrahere." (To expand and to contract.)
    // ═══════════════════════════════════════════════════════════════════════

    /// Expand: fork a memory into N child variant copies (each inherits parent tags + salience)
    public func expand(state: TempleState, nodeId: Text, variants: [Text]) : [MemoryNode] {
        switch (get(state, nodeId)) {
            case (?parent) {
                let results = Buffer.Buffer<MemoryNode>(variants.size());
                for (variantContent in variants.vals()) {
                    let child = store(
                        state,
                        variantContent,
                        "Variant of: " # parent.summary,
                        parent.tags,
                        parent.memory_type,
                        ?parent.node_id,
                        parent.salience_score
                    );
                    results.add(child);
                };
                Buffer.toArray(results)
            };
            case null { [] };
        }
    };

    /// Contract: merge all children of a memory back into the parent (children get archived)
    public func contract(state: TempleState, parentId: Text) : Bool {
        let now = Time.now();
        let kids = children(state, parentId);
        if (kids.size() == 0) { return false };

        // Collect merged tags from children
        let mergedTags = Buffer.Buffer<Text>(16);
        var maxSalience : Float = 0.0;

        for (kid in kids.vals()) {
            for (tag in kid.tags.vals()) {
                var found = false;
                for (existing in mergedTags.vals()) {
                    if (Text.toLowercase(tag) == Text.toLowercase(existing)) { found := true };
                };
                if (not found) { mergedTags.add(tag) };
            };
            if (kid.salience_score > maxSalience) { maxSalience := kid.salience_score };
        };

        // Archive children, boost parent salience
        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                // Archive children
                var isChild = false;
                for (kid in kids.vals()) {
                    if (id == kid.node_id) { isChild := true };
                };
                if (isChild) {
                    (id, { node with state = #ARCHIVED; updated_at = now })
                } else if (id == parentId) {
                    // Boost parent to max child salience
                    let newSalience = Utils.clamp(Float.max(node.salience_score, maxSalience), 0.0, 1.0);
                    (id, { node with salience_score = newSalience; tags = Buffer.toArray(mergedTags); updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        true
    };

    // ═══════════════════════════════════════════════════════════════════════
    // PAIR 6: SURFACE ↔ DEPTH — Move memory shallow or deep
    // "Superficies et profundum." (Surface and depth.)
    // ═══════════════════════════════════════════════════════════════════════

    /// Surface: decrease depth (move memory to outer/shallower torus layer)
    public func surface(state: TempleState, nodeId: Text, amount: Float) : Bool {
        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    let newDepth = Float.max(0.1, node.coordinates.depth - amount);
                    let newCoords = { node.coordinates with depth = newDepth };
                    (id, { node with coordinates = newCoords; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    /// Deepen: increase depth (move memory to inner/deeper torus layer)
    public func deepen(state: TempleState, nodeId: Text, amount: Float) : Bool {
        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    let newDepth = Float.min(10.0, node.coordinates.depth + amount);
                    let newCoords = { node.coordinates with depth = newDepth };
                    (id, { node with coordinates = newCoords; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    // ═══════════════════════════════════════════════════════════════════════
    // PAIR 7: CONNECT ↔ DISCONNECT — Link and Unlink
    // "Coniungere et separare." (To join and to separate.)
    // ═══════════════════════════════════════════════════════════════════════

    /// Link: create a bidirectional parent-child relationship between two memories
    /// The second memory becomes a child of the first
    public func link(state: TempleState, parentId: Text, childId: Text) : Bool {
        switch (get(state, parentId)) {
            case null { return false };
            case _ {};
        };

        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == childId) {
                    found := true;
                    (id, { node with parent_id = ?parentId; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    /// Unlink: sever a memory's parent relationship (become orphan)
    public func unlink(state: TempleState, nodeId: Text) : Bool {
        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    (id, { node with parent_id = null; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    // ═══════════════════════════════════════════════════════════════════════
    // PAIR 8: REMEMBER ↔ FORGET — Reinforce and Forget
    // "Meminisse et oblivisci." (To remember and to forget.)
    // ═══════════════════════════════════════════════════════════════════════

    /// Reinforce: boost salience to max + pin (permanent remembering)
    public func reinforce(state: TempleState, nodeId: Text) : Bool {
        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    (id, { node with salience_score = 1.0; pinned = true; state = #PROMOTED; accessed_at = now; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    /// Forget: zero salience + unpin + archive (intentional forgetting)
    public func forget(state: TempleState, nodeId: Text) : Bool {
        let now = Time.now();
        var found = false;

        state.nodes := Array.map<(Text, MemoryNode), (Text, MemoryNode)>(
            state.nodes,
            func((id, node)) : (Text, MemoryNode) {
                if (id == nodeId) {
                    found := true;
                    (id, { node with salience_score = 0.0; pinned = false; state = #ARCHIVED; updated_at = now })
                } else {
                    (id, node)
                }
            }
        );

        found
    };

    // ═══════════════════════════════════════════════════════════════════════
    // DUALITY SUMMARY — Report on paired operations
    // ═══════════════════════════════════════════════════════════════════════

    /// Duality pair definition
    public type DualityPair = {
        name: Text;
        latinMotto: Text;
        outward: Text;
        inward: Text;
        symbol: Text;
    };

    /// Get all 8 duality pairs as a manifest
    public func dualityManifest() : [DualityPair] {
        [
            { name = "Outward ↔ Inward";   latinMotto = "Quod emittitur, absorbetur.";         outward = "emit";       inward = "absorb";    symbol = "⇌" },
            { name = "Action ↔ Reaction";   latinMotto = "Actio et reactio aequales sunt.";     outward = "activate";   inward = "deactivate"; symbol = "⟺" },
            { name = "Yes ↔ No";            latinMotto = "Sic et Non.";                         outward = "affirm";     inward = "deny";       symbol = "✓✗" },
            { name = "1 ↔ 0";              latinMotto = "Unum et Nihilum.";                    outward = "energize";   inward = "zero";       symbol = "1|0" },
            { name = "Expand ↔ Contract";   latinMotto = "Expandere et contrahere.";            outward = "expand";     inward = "contract";   symbol = "⟨⟩" },
            { name = "Surface ↔ Depth";     latinMotto = "Superficies et profundum.";           outward = "surface";    inward = "deepen";     symbol = "↕" },
            { name = "Connect ↔ Disconnect"; latinMotto = "Coniungere et separare.";            outward = "link";       inward = "unlink";     symbol = "⊶" },
            { name = "Remember ↔ Forget";   latinMotto = "Meminisse et oblivisci.";             outward = "reinforce";  inward = "forget";     symbol = "∞∅" }
        ]
    };
}
