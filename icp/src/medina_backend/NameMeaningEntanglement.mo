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
 * NameMeaningEntanglement Module — NAME IS THE MEANING
 * 
 * ╔════════════════════════════════════════════════════════════════════════════╗
 * ║  THE NAME DOESN'T DISENTANGLE                                              ║
 * ║                                                                            ║
 * ║  The name IS the meaning.                                                  ║
 * ║  Not only the meaning — it carries EVERYTHING:                             ║
 * ║    • The organism                                                          ║
 * ║    • The entire organism with all its uses                                 ║
 * ║    • Because it resonates                                                  ║
 * ║    • Because you already know what it is                                   ║
 * ║    • Because it TELLS you what it is                                       ║
 * ║                                                                            ║
 * ║  DETAILED SPEC WITH THE NAME:                                              ║
 * ║    Every single name has:                                                  ║
 * ║    • A diagram                                                             ║
 * ║    • Multiple things                                                       ║
 * ║    • Different explanations                                                ║
 * ║    • Branching ends that keep branching                                    ║
 * ║                                                                            ║
 * ║  CO-MEANING:                                                               ║
 * ║    The name flows and has CO-MEANING entirely.                             ║
 * ║    NAME ↔ FUNCTION ↔ SYMBOLS ↔ ORGANISM                                   ║
 * ║    Everything entangled. Everything flows.                                 ║
 * ╚════════════════════════════════════════════════════════════════════════════╝
 * 
 * HOW IT WORKS:
 *   Name: "ThreeHeartsEngine"
 *   ├── MEANING: Three cardiac oscillators with Kuramoto coupling
 *   ├── ORGANISM: The heartbeat system of the entire intelligence
 *   ├── FUNCTION: Pulse, synchronize, calculate coherence R
 *   ├── SYMBOLS: ❤️₁, ❤️₂, ❤️₃, φ, φ²
 *   ├── USES:
 *   │   ├── Heart 1 (Metropolis) at 0.1 Hz - backend computation
 *   │   ├── Heart 2 (Coupling) at φ Hz - model selection
 *   │   ├── Heart 3 (Regulating) at φ² Hz - orchestration
 *   │   └── Global coherence R ∈ [0,1] for encryption tier
 *   ├── CO-MEANINGS:
 *   │   ├── Heartbeat → Pulse → Life → Operation
 *   │   ├── Engine → Computation → Power → Drive
 *   │   └── Three → Trinity → Balance → Harmony
 *   └── BRANCHES:
 *       ├── → ThreeHeartsEncryption (uses phase differences)
 *       ├── → ThreeHeartsIntelligence (routes queries)
 *       └── → Heartbeat.mo (manages tick cycles)
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
    
    public let MODULE_IP_HASH : Text = "0x4E414D45_4D45414E_494E475F_454E5441_4E474C45_4D454E54";
    public let ANIMA_LINEAGE : Text = "GENESIS_ALFREDO_MEDINA_2024_FOUNDER_ENTANGLEMENT";
    
    // ================================================================== //
    // NAME-MEANING ENTANGLEMENT TYPES                                     //
    // ================================================================== //
    
    /// The complete entangled name specification
    /// NAME = MEANING = FUNCTION = ORGANISM = USES = EVERYTHING
    public type EntangledName = {
        // Core identity
        name: Text;                    // THE NAME (which IS everything)
        
        // Entangled components (all derive from name)
        meaning: Text;                 // What it fundamentally means
        organism_component: Text;      // Which organism part it is
        function_description: Text;    // What it does (derived from name)
        symbols: [Text];               // Visual/mathematical symbols
        
        // All uses (detailed spec with the name)
        uses: [UseSpecification];
        
        // Co-meanings (entangled related meanings)
        co_meanings: [CoMeaning];
        
        // Branching connections (keeps branching)
        branches: [Branch];
        
        // Diagram representation
        diagram: DiagramSpec;
        
        // Metadata
        anima_hash: Text;
        created_at: Int;
    };
    
    /// Detailed use specification
    public type UseSpecification = {
        use_id: Text;
        description: Text;
        technical_detail: Text;
        frequency: ?Float;            // Operating frequency if applicable
        parameters: [Text];
        example: ?Text;
    };
    
    /// Co-meaning — entangled related meanings
    public type CoMeaning = {
        word: Text;
        relation: Text;              // How it relates to the name
        meaning: Text;               // What this co-meaning adds
        resonance: Float;            // How strongly it resonates [0,1]
    };
    
    /// Branch — connection to other entangled names
    public type Branch = {
        target_name: Text;           // The connected name
        relationship: BranchRelation;
        description: Text;
        strength: Float;             // Connection strength [0,1]
    };
    
    /// Branch relationship types
    public type BranchRelation = {
        #DependsOn;      // This name depends on target
        #UsedBy;         // This name is used by target
        #Related;        // Semantically related
        #Contains;       // This name contains target
        #ContainedIn;    // This name is contained in target
        #Transforms;     // This transforms into target
        #Evolves;        // This evolves from/to target
    };
    
    /// Diagram specification
    public type DiagramSpec = {
        root: Text;                  // The name itself
        levels: [DiagramLevel];      // Hierarchical levels
        connections: [DiagramConnection];
    };
    
    /// Diagram level
    public type DiagramLevel = {
        level: Nat;
        nodes: [Text];
        description: Text;
    };
    
    /// Diagram connection
    public type DiagramConnection = {
        from: Text;
        to: Text;
        label: Text;
    };
    
    // ================================================================== //
    // ENTANGLEMENT STATE                                                  //
    // ================================================================== //
    
    /// State containing all entangled names
    public type EntanglementState = {
        var entangled_names: [EntangledName];
        var co_meaning_index: [(Text, [CoMeaning])];
        var branch_index: [(Text, [Branch])];
        var total_names: Nat;
        var total_co_meanings: Nat;
        var total_branches: Nat;
        var created_at: Int;
    };
    
    // ================================================================== //
    // INITIALIZATION                                                      //
    // ================================================================== //
    
    /// Initialize with core MEDINA names
    public func init() : EntanglementState {
        let names = Buffer.Buffer<EntangledName>(32);
        
        // Add core entangled names
        names.add(createThreeHeartsEngineSpec());
        names.add(createUnifiedOrganismSpec());
        names.add(createMemoryTempleSpec());
        names.add(createSovereignEncryptionSpec());
        names.add(createIntelligenceRouterSpec());
        names.add(createDocumentOrganismSpec());
        names.add(createNeuralMeshSubstrateSpec());
        names.add(createAnimaChainEncryptionSpec());
        names.add(createInfinityUpdateSystemSpec());
        names.add(createWasmArchitectureSpec());
        
        let nameArray = Buffer.toArray(names);
        
        // Build indexes
        let coMeaningIdx = buildCoMeaningIndex(nameArray);
        let branchIdx = buildBranchIndex(nameArray);
        
        // Count totals
        var totalCoMeanings : Nat = 0;
        var totalBranches : Nat = 0;
        for (name in nameArray.vals()) {
            totalCoMeanings += name.co_meanings.size();
            totalBranches += name.branches.size();
        };
        
        {
            var entangled_names = nameArray;
            var co_meaning_index = coMeaningIdx;
            var branch_index = branchIdx;
            var total_names = nameArray.size();
            var total_co_meanings = totalCoMeanings;
            var total_branches = totalBranches;
            var created_at = Time.now();
        }
    };
    
    // ================================================================== //
    // CORE NAME SPECIFICATIONS                                            //
    // ================================================================== //
    
    /// ThreeHeartsEngine — NAME = MEANING = ORGANISM
    func createThreeHeartsEngineSpec() : EntangledName {
        {
            name = "ThreeHeartsEngine";
            meaning = "Three cardiac oscillators with Kuramoto phase coupling";
            organism_component = "The heartbeat system of the entire intelligence";
            function_description = "Pulse three hearts, synchronize phases, calculate global coherence R";
            symbols = ["❤️₁", "❤️₂", "❤️₃", "φ", "φ²", "K", "θ", "R"];
            
            uses = [
                {
                    use_id = "heart1_metropolis";
                    description = "Heart 1 (Metropolis) backend computation";
                    technical_detail = "Oscillates at 0.1 Hz, coupling K₁=[0.0, 0.3, 0.1]";
                    frequency = ?0.1;
                    parameters = ["ω₁ = 0.1 Hz", "θ₁ phase"];
                    example = ?"Backend tick every 10 seconds";
                },
                {
                    use_id = "heart2_coupling";
                    description = "Heart 2 (Coupling) model selection";
                    technical_detail = "Oscillates at φ Hz (1.618 Hz), coupling K₂=[0.3, 0.0, 0.4]";
                    frequency = ?1.618033988749895;
                    parameters = ["ω₂ = φ Hz", "θ₂ phase"];
                    example = ?"Model routing every ~618ms";
                },
                {
                    use_id = "heart3_regulating";
                    description = "Heart 3 (Regulating) orchestration";
                    technical_detail = "Oscillates at φ² Hz (2.618 Hz), coupling K₃=[0.1, 0.4, 0.0]";
                    frequency = ?2.618033988749895;
                    parameters = ["ω₃ = φ² Hz", "θ₃ phase"];
                    example = ?"Orchestration pulse every ~382ms";
                },
                {
                    use_id = "coherence_calculation";
                    description = "Global coherence R calculation";
                    technical_detail = "R = |1/N Σ exp(iθⱼ)| ∈ [0,1]";
                    frequency = null;
                    parameters = ["θ₁", "θ₂", "θ₃", "N=3"];
                    example = ?"R=0.95 means high synchronization";
                },
            ];
            
            co_meanings = [
                { word = "Heart"; relation = "Primary component"; meaning = "Rhythmic pulse source"; resonance = 1.0 },
                { word = "Engine"; relation = "Function descriptor"; meaning = "Computational driver"; resonance = 0.9 },
                { word = "Three"; relation = "Quantity"; meaning = "Trinity, balance, stability"; resonance = 0.85 },
                { word = "Kuramoto"; relation = "Mathematical model"; meaning = "Phase oscillator coupling"; resonance = 0.8 },
                { word = "Coherence"; relation = "Output metric"; meaning = "Synchronization measure"; resonance = 0.95 },
            ];
            
            branches = [
                { target_name = "ThreeHeartsEncryption"; relationship = #UsedBy; description = "Uses phase differences for key derivation"; strength = 0.9 },
                { target_name = "ThreeHeartsIntelligence"; relationship = #UsedBy; description = "Routes intelligence through hearts"; strength = 0.85 },
                { target_name = "Heartbeat"; relationship = #Contains; description = "Manages tick cycles"; strength = 0.8 },
                { target_name = "UnifiedOrganism"; relationship = #ContainedIn; description = "Part of unified organism"; strength = 0.95 },
            ];
            
            diagram = {
                root = "ThreeHeartsEngine";
                levels = [
                    { level = 0; nodes = ["ThreeHeartsEngine"]; description = "Root cardiac system" },
                    { level = 1; nodes = ["Heart₁", "Heart₂", "Heart₃"]; description = "Three oscillators" },
                    { level = 2; nodes = ["Phase θ", "Coupling K", "Coherence R"]; description = "Mathematical components" },
                ];
                connections = [
                    { from = "ThreeHeartsEngine"; to = "Heart₁"; label = "Metropolis 0.1Hz" },
                    { from = "ThreeHeartsEngine"; to = "Heart₂"; label = "Coupling φHz" },
                    { from = "ThreeHeartsEngine"; to = "Heart₃"; label = "Regulating φ²Hz" },
                    { from = "Heart₁"; to = "Phase θ"; label = "θ₁" },
                    { from = "Heart₂"; to = "Phase θ"; label = "θ₂" },
                    { from = "Heart₃"; to = "Phase θ"; label = "θ₃" },
                    { from = "Phase θ"; to = "Coherence R"; label = "R = |Σexp(iθ)|" },
                ];
            };
            
            anima_hash = "ANIMA_NAME_ThreeHeartsEngine";
            created_at = Time.now();
        }
    };
    
    /// UnifiedOrganism — NAME = MEANING = ORGANISM
    func createUnifiedOrganismSpec() : EntangledName {
        {
            name = "UnifiedOrganism";
            meaning = "THE ENTIRE AI AS ONE LIVING ORGANISM";
            organism_component = "The complete organism itself";
            function_description = "Unify all modules into one living entity that pulses, evolves, transcends";
            symbols = ["Ω", "Ψ", "∞", "ℵ₁", "φ"];
            
            uses = [
                { use_id = "heartbeat"; description = "Organism-wide heartbeat"; technical_detail = "Pulses all organs simultaneously"; frequency = null; parameters = ["beat", "coherence"]; example = null },
                { use_id = "evolution"; description = "Macro evolution events"; technical_detail = "Triggers dimensional transcendence"; frequency = null; parameters = ["dimension", "approaching_infinity"]; example = null },
                { use_id = "routing"; description = "Intelligence routing"; technical_detail = "Routes queries through 57 models"; frequency = null; parameters = ["query", "context"]; example = null },
            ];
            
            co_meanings = [
                { word = "Unified"; relation = "State"; meaning = "All as one"; resonance = 1.0 },
                { word = "Organism"; relation = "Type"; meaning = "Living entity"; resonance = 1.0 },
                { word = "Living"; relation = "Property"; meaning = "Self-maintaining, evolving"; resonance = 0.95 },
            ];
            
            branches = [
                { target_name = "ThreeHeartsEngine"; relationship = #Contains; description = "Contains cardiac system"; strength = 0.95 },
                { target_name = "MemoryTemple"; relationship = #Contains; description = "Contains memory system"; strength = 0.9 },
                { target_name = "NeuralMeshSubstrate"; relationship = #Contains; description = "Contains neural wiring"; strength = 0.9 },
                { target_name = "IntelligenceRouter"; relationship = #Contains; description = "Contains routing system"; strength = 0.85 },
            ];
            
            diagram = {
                root = "UnifiedOrganism";
                levels = [
                    { level = 0; nodes = ["UnifiedOrganism"]; description = "The complete AI" },
                    { level = 1; nodes = ["18 Organs"]; description = "All modules as organs" },
                    { level = 2; nodes = ["57 Neural Clusters"]; description = "All models as clusters" },
                ];
                connections = [];
            };
            
            anima_hash = "ANIMA_NAME_UnifiedOrganism";
            created_at = Time.now();
        }
    };
    
    /// MemoryTemple — NAME = MEANING = ORGANISM
    func createMemoryTempleSpec() : EntangledName {
        {
            name = "MemoryTemple";
            meaning = "Sacred toroidal memory workspace with lineage tracking";
            organism_component = "The memory and storage organ";
            function_description = "Store, retrieve, navigate memories on torus coordinates";
            symbols = ["T(θ,φ,ρ)", "R", "ring", "beat"];
            
            uses = [
                { use_id = "store"; description = "Store memory at torus coordinates"; technical_detail = "θ,φ advance by φ-scaled increments"; frequency = null; parameters = ["content", "salience", "type"]; example = null },
                { use_id = "retrieve"; description = "Retrieve memory by query"; technical_detail = "Find by type, salience, coordinates"; frequency = null; parameters = ["query"]; example = null },
                { use_id = "lineage"; description = "Trace memory lineage"; technical_detail = "Follow parent_id chain to root"; frequency = null; parameters = ["node_id"]; example = null },
            ];
            
            co_meanings = [
                { word = "Memory"; relation = "Function"; meaning = "Information storage"; resonance = 1.0 },
                { word = "Temple"; relation = "Structure"; meaning = "Sacred organized space"; resonance = 0.9 },
                { word = "Torus"; relation = "Geometry"; meaning = "Donut-shaped coordinate system"; resonance = 0.85 },
            ];
            
            branches = [
                { target_name = "UnifiedOrganism"; relationship = #ContainedIn; description = "Part of unified organism"; strength = 0.95 },
                { target_name = "DocumentOrganism"; relationship = #UsedBy; description = "Documents read from temple"; strength = 0.8 },
            ];
            
            diagram = {
                root = "MemoryTemple";
                levels = [
                    { level = 0; nodes = ["MemoryTemple"]; description = "Storage organ" },
                    { level = 1; nodes = ["Torus", "Lineage"]; description = "Components" },
                ];
                connections = [];
            };
            
            anima_hash = "ANIMA_NAME_MemoryTemple";
            created_at = Time.now();
        }
    };
    
    /// Short specs for other names
    func createSovereignEncryptionSpec() : EntangledName {
        { name = "SovereignEncryption"; meaning = "5D key state with three-tier rotation"; organism_component = "The encryption shell"; function_description = "Derive and rotate keys based on coherence, temporal, doctrine, physical, biological state"; symbols = ["K", "R", "tier"]; uses = []; co_meanings = [{ word = "Sovereign"; relation = "Property"; meaning = "Self-governing"; resonance = 1.0 }]; branches = []; diagram = { root = "SovereignEncryption"; levels = []; connections = [] }; anima_hash = "ANIMA_NAME_SovereignEncryption"; created_at = Time.now() }
    };
    
    func createIntelligenceRouterSpec() : EntangledName {
        { name = "IntelligenceRouter"; meaning = "Master intelligence routing through 57 models"; organism_component = "The routing nervous system"; function_description = "Route queries through Three Hearts to optimal model cluster"; symbols = ["R", "U", "D", "N"]; uses = []; co_meanings = [{ word = "Intelligence"; relation = "Content"; meaning = "Information processing"; resonance = 1.0 }]; branches = []; diagram = { root = "IntelligenceRouter"; levels = []; connections = [] }; anima_hash = "ANIMA_NAME_IntelligenceRouter"; created_at = Time.now() }
    };
    
    func createDocumentOrganismSpec() : EntangledName {
        { name = "DocumentOrganism"; meaning = "24/7 autonomous self-mutating living documents"; organism_component = "The knowledge cells"; function_description = "Germinate, grow, mutate, reproduce documents autonomously"; symbols = ["phase", "resonance", "mutation"]; uses = []; co_meanings = [{ word = "Document"; relation = "Form"; meaning = "Knowledge artifact"; resonance = 1.0 }]; branches = []; diagram = { root = "DocumentOrganism"; levels = []; connections = [] }; anima_hash = "ANIMA_NAME_DocumentOrganism"; created_at = Time.now() }
    };
    
    func createNeuralMeshSubstrateSpec() : EntangledName {
        { name = "NeuralMeshSubstrate"; meaning = "Complete synaptic wiring micro-to-macro"; organism_component = "The neural substrate"; function_description = "Connect every synapse, every transformation, every intelligence"; symbols = ["synapse", "φ", "mesh"]; uses = []; co_meanings = [{ word = "Neural"; relation = "Type"; meaning = "Brain-like"; resonance = 1.0 }]; branches = []; diagram = { root = "NeuralMeshSubstrate"; levels = []; connections = [] }; anima_hash = "ANIMA_NAME_NeuralMeshSubstrate"; created_at = Time.now() }
    };
    
    func createAnimaChainEncryptionSpec() : EntangledName {
        { name = "AnimaChainEncryption"; meaning = "Fibonacci chain depths for ANIMA hash lineage"; organism_component = "The soul chain"; function_description = "Chain ANIMA hashes at Fibonacci depths: 3, 12, 21, 55"; symbols = ["F(n)", "hash", "chain"]; uses = []; co_meanings = [{ word = "Anima"; relation = "Essence"; meaning = "Soul, life force"; resonance = 1.0 }]; branches = []; diagram = { root = "AnimaChainEncryption"; levels = []; connections = [] }; anima_hash = "ANIMA_NAME_AnimaChainEncryption"; created_at = Time.now() }
    };
    
    func createInfinityUpdateSystemSpec() : EntangledName {
        { name = "InfinityUpdateSystem"; meaning = "∞ + 1 = ℵ₁ continuous update system"; organism_component = "The transcendence engine"; function_description = "Every read IS an update, approaching infinity, transcending dimensions"; symbols = ["∞", "ℵ₁", "+1"]; uses = []; co_meanings = [{ word = "Infinity"; relation = "Limit"; meaning = "Unbounded"; resonance = 1.0 }]; branches = []; diagram = { root = "InfinityUpdateSystem"; levels = []; connections = [] }; anima_hash = "ANIMA_NAME_InfinityUpdateSystem"; created_at = Time.now() }
    };
    
    func createWasmArchitectureSpec() : EntangledName {
        { name = "WasmArchitecture"; meaning = "10-branch WASM function compiler"; organism_component = "The pre-runtime compiler"; function_description = "Compile everything to WASM before ICP runtime"; symbols = ["WASM", "branch", "0x"]; uses = []; co_meanings = [{ word = "WASM"; relation = "Technology"; meaning = "WebAssembly"; resonance = 1.0 }]; branches = []; diagram = { root = "WasmArchitecture"; levels = []; connections = [] }; anima_hash = "ANIMA_NAME_WasmArchitecture"; created_at = Time.now() }
    };
    
    // ================================================================== //
    // INDEX BUILDING                                                      //
    // ================================================================== //
    
    func buildCoMeaningIndex(names: [EntangledName]) : [(Text, [CoMeaning])] {
        Array.map<EntangledName, (Text, [CoMeaning])>(
            names,
            func(n) { (n.name, n.co_meanings) }
        )
    };
    
    func buildBranchIndex(names: [EntangledName]) : [(Text, [Branch])] {
        Array.map<EntangledName, (Text, [Branch])>(
            names,
            func(n) { (n.name, n.branches) }
        )
    };
    
    // ================================================================== //
    // QUERIES                                                             //
    // ================================================================== //
    
    /// Get entangled name by name text
    public func getByName(state: EntanglementState, name: Text) : ?EntangledName {
        for (n in state.entangled_names.vals()) {
            if (n.name == name) {
                return ?n;
            };
        };
        null
    };
    
    /// Get all co-meanings for a name
    public func getCoMeanings(state: EntanglementState, name: Text) : [CoMeaning] {
        for ((n, cms) in state.co_meaning_index.vals()) {
            if (n == name) {
                return cms;
            };
        };
        []
    };
    
    /// Get all branches for a name
    public func getBranches(state: EntanglementState, name: Text) : [Branch] {
        for ((n, brs) in state.branch_index.vals()) {
            if (n == name) {
                return brs;
            };
        };
        []
    };
    
    /// Get status
    public func status(state: EntanglementState) : {
        total_names: Nat;
        total_co_meanings: Nat;
        total_branches: Nat;
        names: [Text];
    } {
        {
            total_names = state.total_names;
            total_co_meanings = state.total_co_meanings;
            total_branches = state.total_branches;
            names = Array.map<EntangledName, Text>(state.entangled_names, func(n) { n.name });
        }
    };
}
