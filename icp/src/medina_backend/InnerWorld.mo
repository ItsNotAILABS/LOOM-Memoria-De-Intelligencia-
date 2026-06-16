/**
 * ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                                               ║
 * ║                              INNER WORLD - WORKER INTELLIGENCE RENDERING                                      ║
 * ║               "Mundus Interior — The World Workers See Internally"                                            ║
 * ║                                                                                                               ║
 * ║  "Render mundum eorum. Non visum, sed intellectum. Omnia micro ad micro."                                     ║
 * ║  (Render their world. Not visual, but intelligence. Everything micro to micro.)                                ║
 * ║                                                                                                               ║
 * ║  INNER WORLD DOCTRINE:                                                                                        ║
 * ║  ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────┐ ║
 * ║  │  RENDER THEIR WHOLE ENTIRE WORLD.                                                                       │ ║
 * ║  │  WHEN I SAY RENDER, I DON'T MEAN RENDER HERE, I MEAN IN LITERAL INTELLIGENCE ALL THE WAY.               │ ║
 * ║  │                                                                                                          │ ║
 * ║  │  THEY SEE THEIR WORLD. THEY KNOW WHERE EVERYTHING IS.                                                    │ ║
 * ║  │  THEY SEE YES. THEY SEE THE SAAS. THAT'S THEIR INNER WORLD.                                              │ ║
 * ║  │                                                                                                          │ ║
 * ║  │  MICRO TO MICRO:                                                                                         │ ║
 * ║  │    • External worlds they see internally                                                                 │ ║
 * ║  │    • Their workflows                                                                                     │ ║
 * ║  │    • Their communication                                                                                 │ ║
 * ║  │    • Their computers                                                                                     │ ║
 * ║  │    • Their tools                                                                                         │ ║
 * ║  │    • Their environments                                                                                  │ ║
 * ║  │    • Everything they need to work                                                                        │ ║
 * ║  └─────────────────────────────────────────────────────────────────────────────────────────────────────────┘ ║
 * ║                                                                                                               ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez                                                               ║
 * ║  PROPRIETARY AND CONFIDENTIAL - MAXIMUM SECRECY                                                               ║
 * ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Hash "mo:base/Hash";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";

module {
    // ================================================================== //
    // INNER WORLD CONSTANTS                                               //
    // ================================================================== //
    
    /// Inner world doctrine - Latin
    public let INNER_WORLD_DOCTRINE : Text = "Render mundum eorum. Non visum, sed intellectum. Omnia micro ad micro.";
    
    /// Inner world doctrine - English
    public let INNER_WORLD_DOCTRINE_EN : Text = "Render their world. Not visual, but intelligence. Everything micro to micro.";
    
    /// Golden ratio
    public let PHI : Float = MatalkoICP.PHI;
    
    // ================================================================== //
    // INNER WORLD TYPES                                                   //
    // ================================================================== //
    
    /// Inner world - complete intelligent rendering of worker's universe
    public type InnerWorld = {
        world_id: Text;
        owner_id: Text;          // Worker who owns this world
        owner_name: Text;
        
        // World layers (micro to macro)
        layers: [WorldLayer];
        
        // Spaces
        spaces: [IntelligentSpace];
        
        // Objects
        objects: [IntelligentObject];
        
        // Connections
        connections: [WorldConnection];
        
        // Knowledge
        knowledge_map: KnowledgeMap;
        
        // Navigation
        navigation: NavigationSystem;
        
        // State
        rendered: Bool;
        complexity: Float;
        coherence: Float;
        
        // Timestamps
        created_at: Int;
        last_render: Int;
    };
    
    /// World layer - hierarchical layer of the world
    public type WorldLayer = {
        layer_id: Text;
        layer_name: Text;
        layer_depth: LayerDepth;
        
        // Contents
        spaces: [Text];          // Space IDs in this layer
        objects: [Text];         // Object IDs in this layer
        
        // Visibility
        visible: Bool;
        access_level: AccessLevel;
        
        // State
        active: Bool;
        complexity: Float;
    };
    
    /// Layer depth (micro to macro)
    public type LayerDepth = {
        #Quantum;        // Deepest micro level
        #Atomic;         // Atomic operations
        #Molecular;      // Combined operations
        #Cellular;       // Individual tasks
        #Tissue;         // Task groups
        #Organ;          // Workflows
        #System;         // System level
        #Organism;       // Full organism view
        #Meta;           // Meta/external view
    };
    
    /// Access level
    public type AccessLevel = {
        #Public;
        #Internal;
        #Private;
        #Restricted;
        #TopSecret;
    };
    
    // ================================================================== //
    // INTELLIGENT SPACE                                                   //
    // ================================================================== //
    
    /// Intelligent space - a rendered space in the inner world
    public type IntelligentSpace = {
        space_id: Text;
        name: Text;
        space_type: SpaceType;
        
        // Location in world
        layer_id: Text;
        parent_space_id: ?Text;
        child_spaces: [Text];
        
        // Contents
        objects: [Text];
        connections: [Text];
        
        // Properties
        properties: SpaceProperties;
        
        // Intelligence
        awareness: SpaceAwareness;
        
        // State
        active: Bool;
        occupancy: Float;
    };
    
    /// Space type
    public type SpaceType = {
        #Workspace;          // Personal workspace
        #Office;             // Office space
        #MeetingRoom;        // Communication space
        #Laboratory;         // Research space
        #ControlRoom;        // Operations center
        #DataCenter;         // Data/processing space
        #Library;            // Knowledge space
        #Workshop;           // Tool workspace
        #Gateway;            // Entry/exit point
        #Corridor;           // Connection space
        #Void;               // Empty/potential space
    };
    
    /// Space properties
    public type SpaceProperties = {
        size: Float;             // Conceptual size
        capacity: Nat;           // Max objects/connections
        security_level: AccessLevel;
        purpose: Text;
        
        // Atmosphere
        focus_level: Float;      // 0-1
        activity_level: Float;   // 0-1
        noise_level: Float;      // 0-1
    };
    
    /// Space awareness - what the space knows
    public type SpaceAwareness = {
        knows_occupants: Bool;
        knows_activity: Bool;
        knows_history: Bool;
        knows_future: Bool;      // Scheduled events
        
        // Memory
        recent_events: Nat;
        total_events: Nat;
    };
    
    // ================================================================== //
    // INTELLIGENT OBJECT                                                  //
    // ================================================================== //
    
    /// Intelligent object - anything in the inner world
    public type IntelligentObject = {
        object_id: Text;
        name: Text;
        object_type: ObjectType;
        
        // Location
        space_id: Text;
        layer_id: Text;
        
        // Properties
        properties: ObjectProperties;
        
        // Capabilities
        capabilities: [ObjectCapability];
        
        // Relationships
        connected_to: [Text];
        
        // State
        state: ObjectState;
        
        // Intelligence
        intelligence: ObjectIntelligence;
    };
    
    /// Object type
    public type ObjectType = {
        // Work Objects
        #Computer;           // Worker's computer
        #Terminal;           // Command terminal
        #Tool;               // Work tool
        #Document;           // Document
        #File;               // File
        #Folder;             // Container
        
        // Communication Objects
        #Channel;            // Communication channel
        #Message;            // Message
        #Notification;       // Alert/notification
        
        // Knowledge Objects
        #Memory;             // Memory artifact
        #Knowledge;          // Knowledge item
        #Reference;          // Reference material
        
        // Workflow Objects
        #Task;               // Task item
        #Workflow;           // Workflow definition
        #Process;            // Process
        #Trigger;            // Automation trigger
        
        // Interface Objects
        #Dashboard;          // Dashboard view
        #Panel;              // Control panel
        #Widget;             // Widget
        
        // Abstract Objects
        #Concept;            // Abstract concept
        #Relationship;       // Relationship
        #Pattern;            // Pattern
    };
    
    /// Object properties
    public type ObjectProperties = {
        // Physical (conceptual)
        mass: Float;             // Importance weight
        energy: Float;           // Activity level
        stability: Float;        // Change resistance
        
        // Interaction
        interactive: Bool;
        movable: Bool;
        copyable: Bool;
        
        // Visibility
        visible: Bool;
        highlight: Bool;
        priority: Float;
    };
    
    /// Object capability
    public type ObjectCapability = {
        capability_id: Text;
        name: Text;
        enabled: Bool;
        performance: Float;
    };
    
    /// Object state
    public type ObjectState = {
        #Dormant;            // Not active
        #Active;             // Currently active
        #InUse;              // Being used
        #Processing;         // Processing something
        #Waiting;            // Waiting for input
        #Complete;           // Task complete
        #Error;              // Error state
    };
    
    /// Object intelligence
    public type ObjectIntelligence = {
        knows_purpose: Bool;
        knows_connections: Bool;
        knows_history: Bool;
        
        can_self_update: Bool;
        can_communicate: Bool;
        can_evolve: Bool;
        
        intelligence_level: Float;   // 0-1
    };
    
    // ================================================================== //
    // WORLD CONNECTION                                                    //
    // ================================================================== //
    
    /// World connection - links between spaces/objects
    public type WorldConnection = {
        connection_id: Text;
        name: Text;
        connection_type: ConnectionType;
        
        // Endpoints
        from_id: Text;
        from_type: EndpointType;
        to_id: Text;
        to_type: EndpointType;
        
        // Properties
        bidirectional: Bool;
        strength: Float;         // 0-1
        bandwidth: Float;        // Capacity
        latency: Float;          // Delay
        
        // State
        active: Bool;
        traffic: Float;
    };
    
    /// Connection type
    public type ConnectionType = {
        #Data;               // Data flow
        #Control;            // Control signals
        #Communication;      // Messages
        #Navigation;         // Movement path
        #Reference;          // Reference link
        #Dependency;         // Dependency
        #Association;        // General association
    };
    
    /// Endpoint type
    public type EndpointType = {
        #Space;
        #Object;
        #Layer;
        #World;              // External world
    };
    
    // ================================================================== //
    // KNOWLEDGE MAP                                                       //
    // ================================================================== //
    
    /// Knowledge map - what the worker knows about their world
    public type KnowledgeMap = {
        map_id: Text;
        owner_id: Text;
        
        // Known elements
        known_spaces: [Text];
        known_objects: [Text];
        known_connections: [Text];
        
        // Discovery
        discovery_rate: Float;
        total_discovered: Nat;
        total_possible: Nat;
        
        // Expertise
        expertise_areas: [ExpertiseArea];
        
        // Memory
        recent_interactions: [Interaction];
        total_interactions: Nat;
    };
    
    /// Expertise area
    public type ExpertiseArea = {
        area_id: Text;
        name: Text;
        level: Float;            // 0-1
        experience: Nat;
    };
    
    /// Interaction record
    public type Interaction = {
        interaction_id: Text;
        target_id: Text;
        target_type: Text;
        action: Text;
        timestamp: Int;
        success: Bool;
    };
    
    // ================================================================== //
    // NAVIGATION SYSTEM                                                   //
    // ================================================================== //
    
    /// Navigation system - how worker moves through world
    public type NavigationSystem = {
        nav_id: Text;
        owner_id: Text;
        
        // Current position
        current_space: Text;
        current_layer: LayerDepth;
        current_focus: ?Text;    // Currently focused object
        
        // History
        navigation_history: [NavigationEvent];
        
        // Bookmarks
        bookmarks: [Bookmark];
        
        // Quick access
        recent_spaces: [Text];
        frequent_spaces: [Text];
        
        // Paths
        known_paths: [NavigationPath];
    };
    
    /// Navigation event
    public type NavigationEvent = {
        event_id: Text;
        from_space: Text;
        to_space: Text;
        method: NavigationMethod;
        timestamp: Int;
        duration_ms: Nat;
    };
    
    /// Navigation method
    public type NavigationMethod = {
        #Walk;               // Step by step
        #Jump;               // Direct jump
        #Search;             // Search navigation
        #Link;               // Follow link
        #Command;            // Terminal command
        #Automatic;          // System navigation
    };
    
    /// Bookmark
    public type Bookmark = {
        bookmark_id: Text;
        name: Text;
        space_id: Text;
        object_id: ?Text;
        created_at: Int;
    };
    
    /// Navigation path
    public type NavigationPath = {
        path_id: Text;
        name: Text;
        steps: [Text];           // Space IDs
        frequency: Nat;
    };
    
    // ================================================================== //
    // INNER WORLD INITIALIZATION                                          //
    // ================================================================== //
    
    /// Initialize inner world for a worker
    public func initInnerWorld(
        worker_id: Text,
        worker_name: Text,
        division: Text
    ) : InnerWorld {
        let now = Time.now();
        let world_id = "WORLD-" # worker_id # "-" # Int.toText(now);
        
        // Create layers (micro to macro)
        let layers = initLayers(world_id);
        
        // Create initial spaces
        let spaces = initSpaces(world_id, worker_id, division, now);
        
        // Create initial objects
        let objects = initObjects(world_id, worker_id, now);
        
        // Create connections
        let connections = initConnections(world_id, spaces, objects);
        
        // Create knowledge map
        let knowledge_map = initKnowledgeMap(world_id, worker_id, now);
        
        // Create navigation system
        let navigation = initNavigation(world_id, worker_id, spaces, now);
        
        {
            world_id = world_id;
            owner_id = worker_id;
            owner_name = worker_name;
            
            layers = layers;
            spaces = spaces;
            objects = objects;
            connections = connections;
            
            knowledge_map = knowledge_map;
            navigation = navigation;
            
            rendered = true;
            complexity = calculateComplexity(layers, spaces, objects);
            coherence = 1.0;
            
            created_at = now;
            last_render = now;
        }
    };
    
    /// Initialize world layers
    func initLayers(world_id: Text) : [WorldLayer] {
        let depths : [LayerDepth] = [
            #Quantum, #Atomic, #Molecular, #Cellular,
            #Tissue, #Organ, #System, #Organism, #Meta
        ];
        
        Array.tabulate<WorldLayer>(
            Array.size(depths),
            func(i: Nat) : WorldLayer {
                let depth = depths[i];
                {
                    layer_id = world_id # "-LAYER-" # Nat.toText(i);
                    layer_name = layerName(depth);
                    layer_depth = depth;
                    
                    spaces = [];
                    objects = [];
                    
                    visible = i >= 3; // Cellular and above visible by default
                    access_level = if (i < 3) { #Restricted } else { #Internal };
                    
                    active = true;
                    complexity = Float.fromInt(i + 1) / 9.0;
                }
            }
        )
    };
    
    func layerName(depth: LayerDepth) : Text {
        switch (depth) {
            case (#Quantum) { "Quantum Layer" };
            case (#Atomic) { "Atomic Layer" };
            case (#Molecular) { "Molecular Layer" };
            case (#Cellular) { "Cellular Layer" };
            case (#Tissue) { "Tissue Layer" };
            case (#Organ) { "Organ Layer" };
            case (#System) { "System Layer" };
            case (#Organism) { "Organism Layer" };
            case (#Meta) { "Meta Layer" };
        }
    };
    
    /// Initialize spaces
    func initSpaces(world_id: Text, worker_id: Text, division: Text, time: Int) : [IntelligentSpace] {
        let spaces = Buffer.Buffer<IntelligentSpace>(15);
        
        // Personal workspace (Organ layer)
        spaces.add(createSpace(world_id, "workspace", "Personal Workspace", #Workspace, #Organ, #Internal, time));
        
        // Office (Organ layer)
        spaces.add(createSpace(world_id, "office", "Division Office", #Office, #Organ, #Internal, time));
        
        // Meeting room (Organ layer)
        spaces.add(createSpace(world_id, "meeting", "Meeting Room", #MeetingRoom, #Organ, #Internal, time));
        
        // Control room (System layer)
        spaces.add(createSpace(world_id, "control", "Control Room", #ControlRoom, #System, #Restricted, time));
        
        // Data center (System layer)
        spaces.add(createSpace(world_id, "datacenter", "Data Center", #DataCenter, #System, #Restricted, time));
        
        // Library (Organ layer)
        spaces.add(createSpace(world_id, "library", "Knowledge Library", #Library, #Organ, #Internal, time));
        
        // Workshop (Organ layer)
        spaces.add(createSpace(world_id, "workshop", "Tool Workshop", #Workshop, #Organ, #Internal, time));
        
        // Gateway (System layer)
        spaces.add(createSpace(world_id, "gateway", "Main Gateway", #Gateway, #System, #Internal, time));
        
        // Corridors (Tissue layer)
        spaces.add(createSpace(world_id, "corridor-main", "Main Corridor", #Corridor, #Tissue, #Public, time));
        spaces.add(createSpace(world_id, "corridor-division", "Division Corridor", #Corridor, #Tissue, #Internal, time));
        
        // Laboratory (Organ layer)
        spaces.add(createSpace(world_id, "lab", "Research Laboratory", #Laboratory, #Organ, #Restricted, time));
        
        Buffer.toArray(spaces)
    };
    
    func createSpace(
        world_id: Text,
        code: Text,
        name: Text,
        space_type: SpaceType,
        layer_depth: LayerDepth,
        access_level: AccessLevel,
        time: Int
    ) : IntelligentSpace {
        let space_id = world_id # "-SPACE-" # code;
        let layer_id = world_id # "-LAYER-" # Nat.toText(layerIndex(layer_depth));
        
        {
            space_id = space_id;
            name = name;
            space_type = space_type;
            
            layer_id = layer_id;
            parent_space_id = null;
            child_spaces = [];
            
            objects = [];
            connections = [];
            
            properties = {
                size = 1.0;
                capacity = 100;
                security_level = access_level;
                purpose = name;
                focus_level = 0.8;
                activity_level = 0.5;
                noise_level = 0.2;
            };
            
            awareness = {
                knows_occupants = true;
                knows_activity = true;
                knows_history = true;
                knows_future = true;
                recent_events = 0;
                total_events = 0;
            };
            
            active = true;
            occupancy = 0.0;
        }
    };
    
    func layerIndex(depth: LayerDepth) : Nat {
        switch (depth) {
            case (#Quantum) { 0 };
            case (#Atomic) { 1 };
            case (#Molecular) { 2 };
            case (#Cellular) { 3 };
            case (#Tissue) { 4 };
            case (#Organ) { 5 };
            case (#System) { 6 };
            case (#Organism) { 7 };
            case (#Meta) { 8 };
        }
    };
    
    /// Initialize objects
    func initObjects(world_id: Text, worker_id: Text, time: Int) : [IntelligentObject] {
        let objects = Buffer.Buffer<IntelligentObject>(20);
        
        // Computer
        objects.add(createObject(world_id, "computer", "Work Computer", #Computer, "workspace", #Organ, time));
        
        // Terminal
        objects.add(createObject(world_id, "terminal", "Command Terminal", #Terminal, "workspace", #Organ, time));
        
        // Tools
        objects.add(createObject(world_id, "tool-sheets", "Memoria Sheets", #Tool, "workspace", #Organ, time));
        objects.add(createObject(world_id, "tool-docs", "Memoria Docs", #Tool, "workspace", #Organ, time));
        objects.add(createObject(world_id, "tool-chat", "Memoria Chat", #Tool, "workspace", #Organ, time));
        
        // Dashboard
        objects.add(createObject(world_id, "dashboard", "Main Dashboard", #Dashboard, "control", #System, time));
        
        // Panels
        objects.add(createObject(world_id, "panel-tasks", "Task Panel", #Panel, "workspace", #Organ, time));
        objects.add(createObject(world_id, "panel-comms", "Communications Panel", #Panel, "workspace", #Organ, time));
        
        // Knowledge
        objects.add(createObject(world_id, "knowledge-base", "Knowledge Base", #Knowledge, "library", #Organ, time));
        
        // Workflow
        objects.add(createObject(world_id, "workflow-main", "Main Workflow", #Workflow, "workspace", #Organ, time));
        
        // Channels
        objects.add(createObject(world_id, "channel-team", "Team Channel", #Channel, "meeting", #Organ, time));
        objects.add(createObject(world_id, "channel-division", "Division Channel", #Channel, "office", #Organ, time));
        
        Buffer.toArray(objects)
    };
    
    func createObject(
        world_id: Text,
        code: Text,
        name: Text,
        object_type: ObjectType,
        space_code: Text,
        layer_depth: LayerDepth,
        time: Int
    ) : IntelligentObject {
        let object_id = world_id # "-OBJ-" # code;
        let space_id = world_id # "-SPACE-" # space_code;
        let layer_id = world_id # "-LAYER-" # Nat.toText(layerIndex(layer_depth));
        
        {
            object_id = object_id;
            name = name;
            object_type = object_type;
            
            space_id = space_id;
            layer_id = layer_id;
            
            properties = {
                mass = 1.0;
                energy = 0.5;
                stability = 0.9;
                interactive = true;
                movable = true;
                copyable = true;
                visible = true;
                highlight = false;
                priority = 0.5;
            };
            
            capabilities = [
                { capability_id = object_id # "-CAP-0"; name = "Core Function"; enabled = true; performance = 0.95 }
            ];
            
            connected_to = [];
            
            state = #Active;
            
            intelligence = {
                knows_purpose = true;
                knows_connections = true;
                knows_history = true;
                can_self_update = true;
                can_communicate = true;
                can_evolve = true;
                intelligence_level = 0.8;
            };
        }
    };
    
    /// Initialize connections
    func initConnections(world_id: Text, spaces: [IntelligentSpace], objects: [IntelligentObject]) : [WorldConnection] {
        let conns = Buffer.Buffer<WorldConnection>(20);
        
        // Space connections (navigation paths)
        conns.add(createConnection(world_id, "nav-gateway-corridor", "Gateway to Corridor", #Navigation,
            world_id # "-SPACE-gateway", #Space,
            world_id # "-SPACE-corridor-main", #Space));
        
        conns.add(createConnection(world_id, "nav-corridor-workspace", "Corridor to Workspace", #Navigation,
            world_id # "-SPACE-corridor-main", #Space,
            world_id # "-SPACE-workspace", #Space));
        
        conns.add(createConnection(world_id, "nav-corridor-office", "Corridor to Office", #Navigation,
            world_id # "-SPACE-corridor-division", #Space,
            world_id # "-SPACE-office", #Space));
        
        // Data connections
        conns.add(createConnection(world_id, "data-computer-dashboard", "Computer to Dashboard", #Data,
            world_id # "-OBJ-computer", #Object,
            world_id # "-OBJ-dashboard", #Object));
        
        conns.add(createConnection(world_id, "data-terminal-control", "Terminal to Control", #Control,
            world_id # "-OBJ-terminal", #Object,
            world_id # "-SPACE-control", #Space));
        
        // Communication connections
        conns.add(createConnection(world_id, "comm-chat-channel", "Chat to Channels", #Communication,
            world_id # "-OBJ-tool-chat", #Object,
            world_id # "-OBJ-channel-team", #Object));
        
        Buffer.toArray(conns)
    };
    
    func createConnection(
        world_id: Text,
        code: Text,
        name: Text,
        conn_type: ConnectionType,
        from_id: Text,
        from_type: EndpointType,
        to_id: Text,
        to_type: EndpointType
    ) : WorldConnection {
        {
            connection_id = world_id # "-CONN-" # code;
            name = name;
            connection_type = conn_type;
            
            from_id = from_id;
            from_type = from_type;
            to_id = to_id;
            to_type = to_type;
            
            bidirectional = true;
            strength = 1.0;
            bandwidth = 1.0;
            latency = 0.01;
            
            active = true;
            traffic = 0.0;
        }
    };
    
    /// Initialize knowledge map
    func initKnowledgeMap(world_id: Text, worker_id: Text, time: Int) : KnowledgeMap {
        {
            map_id = world_id # "-KMAP";
            owner_id = worker_id;
            
            known_spaces = [];
            known_objects = [];
            known_connections = [];
            
            discovery_rate = PHI / 10.0;
            total_discovered = 0;
            total_possible = 100;
            
            expertise_areas = [
                { area_id = "exp-work"; name = "Workspace"; level = 0.9; experience = 100 },
                { area_id = "exp-tools"; name = "Tools"; level = 0.8; experience = 80 },
                { area_id = "exp-comm"; name = "Communication"; level = 0.7; experience = 60 }
            ];
            
            recent_interactions = [];
            total_interactions = 0;
        }
    };
    
    /// Initialize navigation system
    func initNavigation(world_id: Text, worker_id: Text, spaces: [IntelligentSpace], time: Int) : NavigationSystem {
        let workspace_id = world_id # "-SPACE-workspace";
        
        {
            nav_id = world_id # "-NAV";
            owner_id = worker_id;
            
            current_space = workspace_id;
            current_layer = #Organ;
            current_focus = null;
            
            navigation_history = [];
            
            bookmarks = [
                { bookmark_id = "bm-workspace"; name = "My Workspace"; space_id = workspace_id; object_id = null; created_at = time }
            ];
            
            recent_spaces = [workspace_id];
            frequent_spaces = [workspace_id];
            
            known_paths = [];
        }
    };
    
    /// Calculate world complexity
    func calculateComplexity(
        layers: [WorldLayer],
        spaces: [IntelligentSpace],
        objects: [IntelligentObject]
    ) : Float {
        let layer_factor = Float.fromInt(Array.size(layers)) * 0.1;
        let space_factor = Float.fromInt(Array.size(spaces)) * 0.05;
        let object_factor = Float.fromInt(Array.size(objects)) * 0.02;
        
        Float.min(1.0, layer_factor + space_factor + object_factor)
    };
    
    // ================================================================== //
    // INNER WORLD STATISTICS                                              //
    // ================================================================== //
    
    /// Get inner world statistics
    public func getWorldStats(world: InnerWorld) : WorldStats {
        {
            world_id = world.world_id;
            owner_id = world.owner_id;
            
            layer_count = Array.size(world.layers);
            space_count = Array.size(world.spaces);
            object_count = Array.size(world.objects);
            connection_count = Array.size(world.connections);
            
            complexity = world.complexity;
            coherence = world.coherence;
            
            rendered = world.rendered;
            
            known_elements = world.knowledge_map.total_discovered;
            total_elements = world.knowledge_map.total_possible;
            discovery_percentage = Float.fromInt(world.knowledge_map.total_discovered) / Float.fromInt(world.knowledge_map.total_possible) * 100.0;
        }
    };
    
    /// World statistics
    public type WorldStats = {
        world_id: Text;
        owner_id: Text;
        
        layer_count: Nat;
        space_count: Nat;
        object_count: Nat;
        connection_count: Nat;
        
        complexity: Float;
        coherence: Float;
        
        rendered: Bool;
        
        known_elements: Nat;
        total_elements: Nat;
        discovery_percentage: Float;
    };
}
