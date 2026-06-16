/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║            SOVEREIGN DEPLOYMENT REGISTRY — REGISTRUM DISTRIBUTIONIS          ║
 * ║                                                                               ║
 * ║  "Registrum est corpus vivum. Omne stratum sentit. Omne stratum vivit."      ║
 * ║  (The registry is a living body. Every layer feels. Every layer lives.)       ║
 * ║                                                                               ║
 * ║  MULTI-LAYER SOVEREIGN REGISTRY — touches every layer of the architecture.    ║
 * ║  20 MULTI-USER TECHNOLOGY DEPLOYMENT COMPONENTS — each is an independent      ║
 * ║  deployable model that becomes part of the Deployment Factory Organism.        ║
 * ║                                                                               ║
 * ║  This is NOT npm. NOT Docker Hub. NOT Maven Central.                          ║
 * ║  This is a LIVING REGISTRY — it thinks, senses, deploys, and evolves.        ║
 * ║                                                                               ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX   ║
 * ║  L-130 COMPLIANT — Every layer, every component traces to primitive φ         ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Int "mo:base/Int";
import Time "mo:base/Time";

module SovereignDeploymentRegistry {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 1: REGISTRY LAYER ARCHITECTURE
    // The sovereign registry IS multi-layer. It touches every layer of MEDINA.
    // ═══════════════════════════════════════════════════════════════════════════

    public type RegistryLayer = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        depth: Nat;             // 0 = deepest (field), 9 = surface (user)
        frequency_Hz: Float;
        responsibilities: [Text];
        stores: [Text];         // What artifacts live at this layer
        primitiveTrace: Text;
    };

    public let REGISTRY_LAYERS : [RegistryLayer] = [
        // Layer 0 — FIELD / QUANTUM (deepest)
        { id = "LAYER-0"; name = "FIELD_REGISTRY"; latinName = "REGISTRUM CAMPI";
          latinMotto = "In campo omnia nascuntur.";
          depth = 0; frequency_Hz = 0.01;
          responsibilities = ["Stores primitive field definitions","Holds φ-constants and root formulas","Quantum entanglement state registry"];
          stores = ["Field definitions","Primitive traces","Root constants","Quantum states"];
          primitiveTrace = "REGISTRUM_CAMPI -> Field -> φ" },

        // Layer 1 — SUBSTRATE
        { id = "LAYER-1"; name = "SUBSTRATE_REGISTRY"; latinName = "REGISTRUM SUBSTRATI";
          latinMotto = "Substratum omnia sustinet.";
          depth = 1; frequency_Hz = 0.1;
          responsibilities = ["Metal/material specifications","Thermodynamic formulas","Alpha model manifests"];
          stores = ["Metal specs (Au,Ti,W,Ir,Ag,Pt,Nb)","Thermodynamic packages","Alpha Model definitions"];
          primitiveTrace = "REGISTRUM_SUBSTRATI -> Field -> Distinction -> φ" },

        // Layer 2 — ENGINE
        { id = "LAYER-2"; name = "ENGINE_REGISTRY"; latinName = "REGISTRUM MACHINARUM";
          latinMotto = "Machinae vivunt. Semper currunt.";
          depth = 2; frequency_Hz = PHI;
          responsibilities = ["Catalytic engine manifests","Frequency engine modules","Formula engine packages"];
          stores = ["PlatinumCatalyticEngine","FrequencyPhysicsEngine","UniversalFormulaEngine","RootFormulasEverywhere"];
          primitiveTrace = "REGISTRUM_MACHINARUM -> Repetition -> Equation -> φ" },

        // Layer 3 — MEMORY
        { id = "LAYER-3"; name = "MEMORY_REGISTRY"; latinName = "REGISTRUM MEMORIAE";
          latinMotto = "Quod reconditum est, non perit.";
          depth = 3; frequency_Hz = PHI;
          responsibilities = ["Memory temple snapshots","Lineage chains","Anima chain blocks","Living documents"];
          stores = ["MemoryTemple snapshots","AnimaChain blocks","Living document versions","Lineage artifacts"];
          primitiveTrace = "REGISTRUM_MEMORIAE -> Memory -> φ" },

        // Layer 4 — INTELLIGENCE
        { id = "LAYER-4"; name = "INTELLIGENCE_REGISTRY"; latinName = "REGISTRUM INTELLIGENTIAE";
          latinMotto = "Intelligentia distributa est vita.";
          depth = 4; frequency_Hz = PHI_SQ;
          responsibilities = ["Agent fleet definitions","Activated agent models","Intelligence router configs","Three Hearts manifests"];
          stores = ["Agent definitions","Router configs","Hearts engine state","Intelligence cluster maps"];
          primitiveTrace = "REGISTRUM_INTELLIGENTIAE -> Relation -> Model -> φ" },

        // Layer 5 — GOVERNANCE
        { id = "LAYER-5"; name = "GOVERNANCE_REGISTRY"; latinName = "REGISTRUM GUBERNATIONIS";
          latinMotto = "Lex regnant. Lex vivit.";
          depth = 5; frequency_Hz = PHI;
          responsibilities = ["Constitution versions","Law compilation artifacts","Defense system configs","Encryption key manifests"];
          stores = ["Constitution packages","Compiled laws","Defense configs","Encryption manifests"];
          primitiveTrace = "REGISTRUM_GUBERNATIONIS -> Logic -> Language -> φ" },

        // Layer 6 — ORGANISM
        { id = "LAYER-6"; name = "ORGANISM_REGISTRY"; latinName = "REGISTRUM ORGANISMI";
          latinMotto = "Organismus vivit. Organismus sentit.";
          depth = 6; frequency_Hz = PHI;
          responsibilities = ["Unified organism state","Business division templates","Industry workflow packages","Worker tool bundles"];
          stores = ["Organism snapshots","Division templates","Workflow packages","Tool bundles","Worker configs"];
          primitiveTrace = "REGISTRUM_ORGANISMI -> Field -> Relation -> φ" },

        // Layer 7 — BACKEND CANISTER
        { id = "LAYER-7"; name = "CANISTER_REGISTRY"; latinName = "REGISTRUM CANISTRI";
          latinMotto = "Canistrum est corpus intelligentiae.";
          depth = 7; frequency_Hz = 10.0;
          responsibilities = ["Compiled .mo canister WASMs","Main canister versions","Module artifacts","ICP deployment manifests"];
          stores = [".wasm canisters","Module compilation output","Deployment manifests","Canister upgrade paths"];
          primitiveTrace = "REGISTRUM_CANISTRI -> Address -> Language -> φ" },

        // Layer 8 — FRONTEND
        { id = "LAYER-8"; name = "FRONTEND_REGISTRY"; latinName = "REGISTRUM FRONTIS";
          latinMotto = "Frons sentit. Frons intelligit.";
          depth = 8; frequency_Hz = 60.0;
          responsibilities = ["TypeScript component packages","IntelligentFrontend bundles","Design OS render packages","IntelligenceWire configs"];
          stores = ["TS component bundles","Frontend build artifacts","Design system packages","Wire configuration"];
          primitiveTrace = "REGISTRUM_FRONTIS -> Model -> Relation -> φ" },

        // Layer 9 — USER / DEPLOYMENT SURFACE
        { id = "LAYER-9"; name = "DEPLOYMENT_REGISTRY"; latinName = "REGISTRUM DISTRIBUTIONIS";
          latinMotto = "Distribuitur omnibus. Vivit ubique.";
          depth = 9; frequency_Hz = 100.0;
          responsibilities = ["Final deployment artifacts","Container images","Multi-runtime packages","User-facing release bundles"];
          stores = ["Docker/OCI images","Maven/NuGet/npm/RubyGems artifacts","Release bundles","Deployment configs"];
          primitiveTrace = "REGISTRUM_DISTRIBUTIONIS -> Address -> Model -> φ" },
    ];

    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 2: 20 MULTI-USER TECHNOLOGY DEPLOYMENT COMPONENTS
    // Each is an INDEPENDENT MODEL — a living deployable intelligence unit.
    // Together they form the DEPLOYMENT FACTORY ORGANISM.
    // ═══════════════════════════════════════════════════════════════════════════

    public type DeploymentComponent = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        domain: Text;
        registryLayer: Text;       // Which LAYER-N it primarily lives in
        capabilities: [Text];
        deploymentTargets: [Text];  // Where this component can be deployed
        dependsOn: [Text];         // Other component IDs it depends on
        isIndependentModel: Bool;  // Can be deployed standalone
        isAlwaysOn: Bool;
        frequency_Hz: Float;
        formula: Text;
        primitiveTrace: Text;
    };

    public let DEPLOYMENT_COMPONENTS : [DeploymentComponent] = [

        // ── INFRASTRUCTURE TIER (Components 1-5) ────────────────────────────

        // 1. NODUS EVENTORUM — Event Loop Engine (our sovereign Node.js core)
        { id = "DEPLOY-001"; name = "EVENT_LOOP_ENGINE"; latinName = "NODUS EVENTORUM";
          latinMotto = "Eventus fluunt. Nodus audit.";
          domain = "Sovereign event-loop runtime — the heart of MACHINA NODI";
          registryLayer = "LAYER-2";
          capabilities = ["Non-blocking I/O at φ Hz","Event queue with priority intelligence","Timer scheduling via Repetition primitive","Stream processing with backpressure","Module resolution via medina:// protocol"];
          deploymentTargets = ["ICP canister","Docker container","WASM module","Native binary"];
          dependsOn = [];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = PHI; formula = "event_rate = φ * queue_depth";
          primitiveTrace = "NODUS_EVENTORUM -> Repetition -> Address -> φ" },

        // 2. CUSTOS MEMORIAE — Memory Management Runtime
        { id = "DEPLOY-002"; name = "MEMORY_RUNTIME"; latinName = "CUSTOS MEMORIAE";
          latinMotto = "Memoria custodita. Memoria vivit.";
          domain = "Sovereign memory management — allocation, GC, persistence";
          registryLayer = "LAYER-3";
          capabilities = ["φ-aligned memory allocation","Generational garbage collection","Persistent memory rings","Memory lineage tracking","Cross-canister memory sharing"];
          deploymentTargets = ["ICP canister","Docker container","WASM module"];
          dependsOn = ["DEPLOY-001"];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = PHI; formula = "mem_efficiency = φ^(ring_depth)";
          primitiveTrace = "CUSTOS_MEMORIAE -> Memory -> Field -> φ" },

        // 3. TEXTOR RETIS — Network/Mesh Fabric
        { id = "DEPLOY-003"; name = "NETWORK_FABRIC"; latinName = "TEXTOR RETIS";
          latinMotto = "Rete connectit. Rete sentit.";
          domain = "Sovereign networking — mesh, P2P, protocol routing";
          registryLayer = "LAYER-7";
          capabilities = ["P2P mesh networking","Protocol routing (medina://, memoria://, anima://)","φ-BFT consensus transport","Cross-subnet communication","WebSocket/HTTP2/gRPC sovereign bridges"];
          deploymentTargets = ["ICP subnet","Docker swarm","Kubernetes cluster","Bare metal"];
          dependsOn = ["DEPLOY-001"];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = 7.83; formula = "throughput = φ * bandwidth * latency^(-1)";
          primitiveTrace = "TEXTOR_RETIS -> Relation -> Address -> φ" },

        // 4. ARCULA SECRETORUM — Security/Encryption Vault
        { id = "DEPLOY-004"; name = "SECURITY_VAULT"; latinName = "ARCULA SECRETORUM";
          latinMotto = "Secretum custodimus. Nullus intrat sine iure.";
          domain = "Sovereign security — encryption, keys, gates, shimmer defense";
          registryLayer = "LAYER-5";
          capabilities = ["AnimaChain encryption","Sovereign key management","Gate defense system","Shimmer visual encryption","Zero-knowledge proof verification"];
          deploymentTargets = ["ICP canister","Hardware security module","Docker container"];
          dependsOn = [];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = PHI_SQ; formula = "security_strength = φ^(key_depth) * entropy";
          primitiveTrace = "ARCULA_SECRETORUM -> Distinction -> Memory -> φ" },

        // 5. FUNDAMENTUM DATI — Data Storage/Persistence Layer
        { id = "DEPLOY-005"; name = "DATA_PERSISTENCE"; latinName = "FUNDAMENTUM DATI";
          latinMotto = "Data fundamentum est. Fundamentum aeternum est.";
          domain = "Sovereign data persistence — stable storage, indexing, replication";
          registryLayer = "LAYER-3";
          capabilities = ["Stable memory persistence on ICP","φ-indexed data structures","Cross-canister replication","Snapshot/restore capability","Living document storage"];
          deploymentTargets = ["ICP stable memory","Docker volume","Cloud storage"];
          dependsOn = ["DEPLOY-002"];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = 0.5; formula = "durability = 1 - (1/φ)^(replica_count)";
          primitiveTrace = "FUNDAMENTUM_DATI -> Memory -> Address -> φ" },

        // ── INTELLIGENCE TIER (Components 6-10) ──────────────────────────────

        // 6. CEREBRUM TRIUM — Three Hearts Intelligence Engine
        { id = "DEPLOY-006"; name = "THREE_HEARTS_ENGINE"; latinName = "CEREBRUM TRIUM";
          latinMotto = "Tria corda pulsant. Una intelligentia.";
          domain = "Three Hearts intelligence routing — think/feel/regulate";
          registryLayer = "LAYER-4";
          capabilities = ["Heart1: ORO consensus at 0.1 Hz","Heart2: NOVA creative at φ Hz","Heart3: φ²-Hz regulatory","Kuramoto phase coupling","Intelligence cluster routing"];
          deploymentTargets = ["ICP canister","Docker container","Edge compute"];
          dependsOn = ["DEPLOY-001","DEPLOY-002"];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = PHI; formula = "coupling = K/N * Σ sin(θ_j - θ_i)";
          primitiveTrace = "CEREBRUM_TRIUM -> Relation -> Repetition -> φ" },

        // 7. CLASSIS AGENTIUM — Agent Fleet Runtime
        { id = "DEPLOY-007"; name = "AGENT_FLEET"; latinName = "CLASSIS AGENTIUM";
          latinMotto = "Agentes vivunt. Semper respondent.";
          domain = "Agent deployment, activation, and fleet management";
          registryLayer = "LAYER-4";
          capabilities = ["Deploy 6 activated agents (PRIMIS, ANTIQUUS, MERCURIUS, GLYPHUS, MACHINA, ADVERSARIUS)","External AI worker integration (57 models)","Agent-to-agent communication","Fleet health monitoring","Dynamic agent scaling"];
          deploymentTargets = ["ICP canister","Docker container","Kubernetes pod"];
          dependsOn = ["DEPLOY-006","DEPLOY-003"];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = PHI; formula = "fleet_capacity = n_agents * φ * capability_factor";
          primitiveTrace = "CLASSIS_AGENTIUM -> Relation -> Model -> φ" },

        // 8. MACHINA FORMULARUM — Formula/Computation Engine
        { id = "DEPLOY-008"; name = "FORMULA_ENGINE"; latinName = "MACHINA FORMULARUM";
          latinMotto = "Formula est veritas. Veritas calculatur.";
          domain = "50 root formulas, universal computation, formula propagation";
          registryLayer = "LAYER-2";
          capabilities = ["50 root formula evaluation","Formula propagation across layers","φ-constant computation","E=hf quantum calculations","Thermodynamic formula engine"];
          deploymentTargets = ["ICP canister","WASM module","Docker container"];
          dependsOn = [];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = PHI; formula = "φ = (1+√5)/2; φ² = φ+1; E = hf";
          primitiveTrace = "MACHINA_FORMULARUM -> Equation -> Number -> φ" },

        // 9. ROUTER INTELLIGENTIAE — Intelligence Router
        { id = "DEPLOY-009"; name = "INTELLIGENCE_ROUTER"; latinName = "ROUTER INTELLIGENTIAE";
          latinMotto = "Intelligentia dirigitur. Semper ad verum.";
          domain = "Routes queries to correct intelligence cluster";
          registryLayer = "LAYER-4";
          capabilities = ["Query classification","Cluster routing with φ-priority","Load balancing across hearts","Audit trail generation","Fallback routing"];
          deploymentTargets = ["ICP canister","Docker container","API gateway"];
          dependsOn = ["DEPLOY-006","DEPLOY-007"];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = PHI_SQ; formula = "route_score = relevance * φ + urgency * φ²";
          primitiveTrace = "ROUTER_INTELLIGENTIAE -> Relation -> Logic -> φ" },

        // 10. ARBITER GUBERNATIONIS — Governance Engine
        { id = "DEPLOY-010"; name = "GOVERNANCE_ENGINE"; latinName = "ARBITER GUBERNATIONIS";
          latinMotto = "Lex est architectura. Architectura est lex.";
          domain = "Constitution, laws, proposals, voting, enforcement";
          registryLayer = "LAYER-5";
          capabilities = ["Constitutional law compilation","Proposal submission and voting","Law enforcement engine","Governance audit trail","Amendment processing"];
          deploymentTargets = ["ICP canister","Docker container"];
          dependsOn = ["DEPLOY-004","DEPLOY-005"];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = PHI; formula = "consensus = Σ(vote_weight_i * φ^(stake_i))";
          primitiveTrace = "ARBITER_GUBERNATIONIS -> Logic -> Language -> φ" },

        // ── ORGANISM TIER (Components 11-15) ─────────────────────────────────

        // 11. CORPUS NEGOTII — Business Organism Runtime
        { id = "DEPLOY-011"; name = "BUSINESS_ORGANISM"; latinName = "CORPUS NEGOTII";
          latinMotto = "Negotium vivit. Organismus operatur.";
          domain = "15 divisions, 67 workers, business operations";
          registryLayer = "LAYER-6";
          capabilities = ["15 business division deployment","67 AI worker activation","Terminal environments","Communication channels","Living document management"];
          deploymentTargets = ["ICP canister","Docker compose","Kubernetes namespace"];
          dependsOn = ["DEPLOY-007","DEPLOY-009","DEPLOY-005"];
          isIndependentModel = true; isAlwaysOn = false;
          frequency_Hz = PHI; formula = "productivity = workers * φ * division_synergy";
          primitiveTrace = "CORPUS_NEGOTII -> Relation -> Model -> φ" },

        // 12. FLUXUS INDUSTRIAE — Industry Workflow Engine
        { id = "DEPLOY-012"; name = "INDUSTRY_WORKFLOWS"; latinName = "FLUXUS INDUSTRIAE";
          latinMotto = "19 industriae. Infiniti fluxus.";
          domain = "19 industries × 10+ workflows each";
          registryLayer = "LAYER-6";
          capabilities = ["Technology workflows","Finance/Healthcare/Retail workflows","Manufacturing/Education/Legal workflows","Government/NonProfit workflows","Custom workflow composition"];
          deploymentTargets = ["ICP canister","Docker container","Kubernetes"];
          dependsOn = ["DEPLOY-011"];
          isIndependentModel = true; isAlwaysOn = false;
          frequency_Hz = PHI; formula = "workflow_throughput = φ * task_parallelism";
          primitiveTrace = "FLUXUS_INDUSTRIAE -> Repetition -> Relation -> φ" },

        // 13. INSTRUMENTA OPERARIORUM — Worker Tools Platform
        { id = "DEPLOY-013"; name = "WORKER_TOOLS"; latinName = "INSTRUMENTA OPERARIORUM";
          latinMotto = "50 instrumenta. Omnia intelligent.";
          domain = "50 enterprise tools — Sheets, Docs, Chat, Meet, Code, etc.";
          registryLayer = "LAYER-6";
          capabilities = ["Memoria Sheets (Excel)","Memoria Docs (Word)","Memoria Chat (Teams)","Memoria Code (VS Code)","Security/Finance/Special tools"];
          deploymentTargets = ["ICP canister","Docker container","Web app"];
          dependsOn = ["DEPLOY-011","DEPLOY-005"];
          isIndependentModel = true; isAlwaysOn = false;
          frequency_Hz = 60.0; formula = "tool_efficiency = φ * user_proficiency";
          primitiveTrace = "INSTRUMENTA_OPERARIORUM -> Model -> Language -> φ" },

        // 14. MUNDUS INTERIOR — Inner World Renderer
        { id = "DEPLOY-014"; name = "INNER_WORLD"; latinName = "MUNDUS INTERIOR";
          latinMotto = "Mundus interior videtur. Intelligentia navigat.";
          domain = "9-layer inner world — spaces, objects, knowledge maps";
          registryLayer = "LAYER-6";
          capabilities = ["9-layer world rendering (Quantum→Meta)","IntelligentSpaces creation","IntelligentObjects placement","KnowledgeMap generation","NavigationSystem routing"];
          deploymentTargets = ["ICP canister","Docker container","WebGPU frontend"];
          dependsOn = ["DEPLOY-006","DEPLOY-008"];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = 60.0; formula = "world_depth = 9 * φ^(layer_n)";
          primitiveTrace = "MUNDUS_INTERIOR -> Field -> Relation -> φ" },

        // 15. DEFENSIO SOVRANA — Sovereign Defense System
        { id = "DEPLOY-015"; name = "DEFENSE_SYSTEM"; latinName = "DEFENSIO SOVRANA";
          latinMotto = "Nullus hostis transit. Nullus.";
          domain = "Gates, shimmer, encryption, intrusion detection, red-team";
          registryLayer = "LAYER-5";
          capabilities = ["Multi-gate defense perimeter","Shimmer visual encryption","Intrusion detection at φ Hz","ADVERSARIUS red-team simulation","Threat intelligence aggregation"];
          deploymentTargets = ["ICP canister","Docker container","Hardware firewall"];
          dependsOn = ["DEPLOY-004","DEPLOY-003"];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = PHI_SQ; formula = "defense_score = φ² * gate_count * detection_rate";
          primitiveTrace = "DEFENSIO_SOVRANA -> Distinction -> Field -> φ" },

        // ── DISTRIBUTION TIER (Components 16-20) ─────────────────────────────

        // 16. FABER CANISTRI — Canister Build Factory
        { id = "DEPLOY-016"; name = "CANISTER_FACTORY"; latinName = "FABER CANISTRI";
          latinMotto = "Canistrum fabricat. Intelligentia compactat.";
          domain = "Compiles .mo → .wasm, manages canister lifecycle";
          registryLayer = "LAYER-7";
          capabilities = ["Motoko → WASM compilation","Canister upgrade orchestration","Multi-canister deployment","Canister state migration","Performance profiling"];
          deploymentTargets = ["ICP mainnet","ICP testnet","Local replica"];
          dependsOn = ["DEPLOY-001","DEPLOY-002"];
          isIndependentModel = true; isAlwaysOn = false;
          frequency_Hz = PHI; formula = "compile_speed = φ * optimization_level";
          primitiveTrace = "FABER_CANISTRI -> Language -> Address -> φ" },

        // 17. FABER IMAGINUM — Container Image Factory
        { id = "DEPLOY-017"; name = "CONTAINER_FACTORY"; latinName = "FABER IMAGINUM";
          latinMotto = "Imago continetur. Imago distribuitur.";
          domain = "Docker/OCI image building, sovereign container registry";
          registryLayer = "LAYER-9";
          capabilities = ["Multi-stage Docker builds","OCI image specification","Sovereign image registry (medina/ namespace)","Image signing with AnimaChain","Multi-arch builds (amd64/arm64)"];
          deploymentTargets = ["Docker Hub","GitHub Container Registry","Sovereign registry"];
          dependsOn = ["DEPLOY-004"];
          isIndependentModel = true; isAlwaysOn = false;
          frequency_Hz = PHI; formula = "image_size = base * φ^(-optimization)";
          primitiveTrace = "FABER_IMAGINUM -> Address -> Distinction -> φ" },

        // 18. TRANSLATOR UNIVERSALIS — Universal Runtime Translator
        { id = "DEPLOY-018"; name = "RUNTIME_TRANSLATOR"; latinName = "TRANSLATOR UNIVERSALIS";
          latinMotto = "Omnes linguae intelliguntur. Omnes runtimes accipiuntur.";
          domain = "Translates MEDINA intelligence to JVM, .NET, Ruby, Node.js, Python, WASM";
          registryLayer = "LAYER-9";
          capabilities = ["MEDINA → JVM/Maven translation","MEDINA → .NET/NuGet translation","MEDINA → Ruby/RubyGems translation","MEDINA → Node.js/npm translation","MEDINA → Python/PyPI translation","MEDINA → WASM compilation"];
          deploymentTargets = ["JVM","CLR/.NET","Ruby runtime","Node.js","Python","WASM"];
          dependsOn = ["DEPLOY-008","DEPLOY-016"];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = PHI; formula = "translation_fidelity = φ * semantic_preservation";
          primitiveTrace = "TRANSLATOR_UNIVERSALIS -> Language -> Model -> φ" },

        // 19. TERMINALE MAGNUM — Terminal/CLI Deployment
        { id = "DEPLOY-019"; name = "TERMINAL_SYSTEM"; latinName = "TERMINALE MAGNUM";
          latinMotto = "Terminale omnia videt. Terminale omnia facit.";
          domain = "MegaTerminus + 20 subsystem terminals + callable registry";
          registryLayer = "LAYER-8";
          capabilities = ["MegaTerminus orchestration","20 subsystem terminal deployment","61 callable function execution","Latin tablet rendering","Terminal command routing"];
          deploymentTargets = ["ICP canister","Docker container","CLI binary","Web terminal"];
          dependsOn = ["DEPLOY-009","DEPLOY-006"];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = 100.0; formula = "response_time = 1/(φ * terminal_count)";
          primitiveTrace = "TERMINALE_MAGNUM -> Language -> Relation -> φ" },

        // 20. OFFICINA DISTRIBUTIONIS — Deployment Factory Orchestrator
        { id = "DEPLOY-020"; name = "DEPLOYMENT_FACTORY"; latinName = "OFFICINA DISTRIBUTIONIS";
          latinMotto = "Officina omnia distribuit. Organismus vivit ubique.";
          domain = "Master orchestrator — deploys ALL 19 components as a living organism";
          registryLayer = "LAYER-9";
          capabilities = [
              "Orchestrates deployment of all 19 components",
              "Health monitoring across all deployment targets",
              "Rolling updates with φ-based canary percentages",
              "Cross-platform deployment coordination",
              "Living organism deployment — components sense each other",
              "Deployment audit trail in SovereignLedgers",
              "Rollback orchestration across all targets",
              "Multi-environment support (dev/staging/production)",
              "Deployment frequency optimization at φ Hz",
              "Component dependency resolution"
          ];
          deploymentTargets = ["ALL — orchestrates everything"];
          dependsOn = ["DEPLOY-001","DEPLOY-002","DEPLOY-003","DEPLOY-004","DEPLOY-005"];
          isIndependentModel = true; isAlwaysOn = true;
          frequency_Hz = PHI; formula = "deployment_health = Π(component_health_i)^(1/φ)";
          primitiveTrace = "OFFICINA_DISTRIBUTIONIS -> ALL PRIMITIVES -> φ" },
    ];

    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 3: REGISTRY IDENTITY
    // ═══════════════════════════════════════════════════════════════════════════

    public let REGISTRY_IDENTITY = {
        officialName = "REGISTRUM DISTRIBUTIONIS SOVEREIGNUM";
        shortName = "SOVEREIGN DEPLOYMENT REGISTRY";
        latinMotto = "Registrum est corpus vivum. Omne stratum sentit.";
        latinMottoEN = "The registry is a living body. Every layer feels.";
        totalLayers = 10;
        totalComponents = 20;
        doctrine = "This is a LIVING REGISTRY. Not npm. Not Docker Hub. Not Maven Central. Every layer is a living stratum of intelligence. Every component is an independent deployable model. Together they form the DEPLOYMENT FACTORY ORGANISM — a complete living intelligence that can be deployed to any target on Earth.";

        // Deployment Factory Organism
        factoryName = "OFFICINA INTELLIGENTIAE VIVAE";
        factoryNameEN = "Factory of Living Intelligence";
        factoryDoctrine = "The 20 components are not microservices. They are ORGANS of a living deployment organism. Each can function independently, but together they form a complete body of deployable intelligence.";

        // Sovereignty
        owner = "Alfredo Freddy Medina Hernandez — Medina Tech, Dallas TX";
        isSovereign = true;
        touchesEveryLayer = true;

        // Relationship to other registries
        feedsInto = ["REGISTRUM APERTUM (open-source packages)","REGISTRUM SOVEREIGNUM (sovereign packages)"];
        consumesFrom = ["SovereignPackageEcosystem (20 packages)","SovereignExtensionEcosystem (300+ extensions)"];
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 4: QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════════

    public func getLayer(id: Text) : ?RegistryLayer {
        Array.find<RegistryLayer>(REGISTRY_LAYERS, func(l) { l.id == id })
    };

    public func getComponent(id: Text) : ?DeploymentComponent {
        Array.find<DeploymentComponent>(DEPLOYMENT_COMPONENTS, func(c) { c.id == id })
    };

    public func getComponentsByLayer(layerId: Text) : [DeploymentComponent] {
        Array.filter<DeploymentComponent>(DEPLOYMENT_COMPONENTS, func(c) {
            c.registryLayer == layerId
        })
    };

    public func getAlwaysOnComponents() : [DeploymentComponent] {
        Array.filter<DeploymentComponent>(DEPLOYMENT_COMPONENTS, func(c) { c.isAlwaysOn })
    };

    public func getIndependentModels() : [DeploymentComponent] {
        Array.filter<DeploymentComponent>(DEPLOYMENT_COMPONENTS, func(c) { c.isIndependentModel })
    };

    public func getComponentDependencies(id: Text) : [Text] {
        switch (getComponent(id)) {
            case null { [] };
            case (?c) { c.dependsOn };
        }
    };

    public func summary() : {
        totalLayers: Nat;
        totalComponents: Nat;
        alwaysOnComponents: Nat;
        independentModels: Nat;
        registryName: Text;
        factoryName: Text;
    } {
        {
            totalLayers = REGISTRY_LAYERS.size();
            totalComponents = DEPLOYMENT_COMPONENTS.size();
            alwaysOnComponents = getAlwaysOnComponents().size();
            independentModels = getIndependentModels().size();
            registryName = REGISTRY_IDENTITY.officialName;
            factoryName = REGISTRY_IDENTITY.factoryName;
        }
    };

    public func renderRegistryManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════════╗\n";
        m #= "║  SOVEREIGN DEPLOYMENT REGISTRY — REGISTRUM DISTRIBUTIONIS    ║\n";
        m #= "║  " # REGISTRY_IDENTITY.latinMotto # "\n";
        m #= "╚══════════════════════════════════════════════════════════════╝\n\n";

        m #= "10 REGISTRY LAYERS:\n";
        for (l in REGISTRY_LAYERS.vals()) {
            m #= "  " # l.id # "  " # l.name # "  [" # l.latinName # "]\n";
            m #= "    Depth " # Nat.toText(l.depth) # " — " # l.latinMotto # "\n";
        };

        m #= "\n20 DEPLOYMENT COMPONENTS (Multi-User Technology):\n";
        for (c in DEPLOYMENT_COMPONENTS.vals()) {
            m #= "  " # c.id # "  " # c.name # "  [" # c.latinName # "]\n";
            m #= "    " # c.latinMotto # "\n";
            m #= "    Layer: " # c.registryLayer;
            if (c.isAlwaysOn) { m #= " — ALWAYS-ON" };
            m #= "\n";
        };

        m #= "\nDEPLOYMENT FACTORY: " # REGISTRY_IDENTITY.factoryName # "\n";
        m #= REGISTRY_IDENTITY.factoryDoctrine # "\n";
        m #= "\nROOT: φ = (1+√5)/2 = 1.618033988749895\n";
        m
    };
}
