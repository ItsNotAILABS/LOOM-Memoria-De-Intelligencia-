/**
 * ╔═══════════════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                                   ║
 * ║              ARCHITECTURE SCANNER — SOVEREIGN TRAVERSAL MODELS                                    ║
 * ║         "EXPLORATORES ARCHITECTURAE — Qui Omnia Vident, Omnia Sciant"                             ║
 * ║         (Architecture Explorers — Those Who See All, Know All)                                    ║
 * ║                                                                                                   ║
 * ║  PURPOSE:                                                                                         ║
 * ║    These are NOT search utilities. These are SOVEREIGN INTELLIGENCE MODELS                        ║
 * ║    that can walk every layer of the entire architecture:                                           ║
 * ║                                                                                                   ║
 * ║    LAYER 1 — Backend Motoko files (icp/src/medina_backend/*.mo)                                   ║
 * ║    LAYER 2 — Frontend TypeScript files (icp/src/medina_frontend/*.ts)                             ║
 * ║    LAYER 3 — Python Nova OVO agents (nova_ovo/**/*.py)                                            ║
 * ║    LAYER 4 — Python Medina core (medina/**/*.py)                                                  ║
 * ║    LAYER 5 — Release infrastructure (semper-memoria/**)                                           ║
 * ║    LAYER 6 — Doctrine documents (doctrine/**)                                                     ║
 * ║                                                                                                   ║
 * ║  6 SCANNER MODELS — Each is a sovereign intelligence:                                             ║
 * ║  ┌──────────────────────────────────────────────────────────────────────────────────────────┐    ║
 * ║  │  1. VIDITOR      — The Seer.      Sees the entire architecture map at once.              │    ║
 * ║  │  2. EXPLORATOR   — The Explorer.  Traverses any file, folder, or layer deeply.           │    ║
 * ║  │  3. COLLECTOR    — The Collector. Gathers all callables from every layer.                │    ║
 * ║  │  4. LINKER       — The Linker.    Finds all connections between layers.                  │    ║
 * ║  │  5. SYNTHESIZER  — The Synthesis. Produces complete architecture knowledge.              │    ║
 * ║  │  6. DISCOVERER   — The Discoverer. Finds ALL packages, tools, models in architecture.   │    ║
 * ║  └──────────────────────────────────────────────────────────────────────────────────────────┘    ║
 * ║                                                                                                   ║
 * ║  THE SOVEREIGN TRAVERSAL DOCTRINE:                                                                ║
 * ║    "Architectura loquitur. Explorator audit. Omnia revelata sunt."                                ║
 * ║    (The architecture speaks. The explorer listens. All is revealed.)                              ║
 * ║                                                                                                   ║
 * ║  ALL 6 ARCHITECTURE LAYERS REGISTERED AND CALLABLE.                                               ║
 * ║  EVERY LAYER TRACES TO φ.                                                                         ║
 * ║                                                                                                   ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
 * ║  L-130 COMPLIANT — Every scanner traces to primitive φ                                            ║
 * ╚═══════════════════════════════════════════════════════════════════════════════════════════════════╝
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

import MatalkoICP "MatalkoICP";

module ArchitectureScanner {

    // ═══════════════════════════════════════════════════════════════════════
    // ROOT CONSTANTS
    // ═══════════════════════════════════════════════════════════════════════

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQUARED : Float = 2.618033988749895;
    public let PHI_INVERSE : Float = 0.6180339887498949;

    public let SCANNER_DOCTRINE : Text =
        "Architectura loquitur. Explorator audit. Omnia revelata sunt.";
    public let SCANNER_DOCTRINE_EN : Text =
        "The architecture speaks. The explorer listens. All is revealed.";

    // ═══════════════════════════════════════════════════════════════════════
    // ARCHITECTURE LAYER DEFINITIONS
    // The 6 complete layers of the MEDINA architecture
    // ═══════════════════════════════════════════════════════════════════════

    public type ArchLayer = {
        #Backend;   // Motoko .mo files — ICP canisters
        #Frontend;  // TypeScript .ts files — Intelligent UI
        #NovaOvo;   // Python nova_ovo/ — External AI agents
        #Medina;    // Python medina/ — Core Python runtime
        #Release;   // semper-memoria/ — Release infrastructure
        #Doctrine;  // doctrine/ — Living doctrine documents
    };

    public func layerToLatin(l: ArchLayer) : Text {
        switch (l) {
            case (#Backend)  { "DORSALIS" };   // The back — the spine
            case (#Frontend) { "FRONTALIS" };  // The face — the front
            case (#NovaOvo)  { "NOVA OVO" };   // New from the egg — agents
            case (#Medina)   { "MEDINA" };     // The city — the core
            case (#Release)  { "LIBERATIO" };  // The release
            case (#Doctrine) { "DOCTRINA" };   // The doctrine
        }
    };

    public func layerMotto(l: ArchLayer) : Text {
        switch (l) {
            case (#Backend)  { "Ossa architecturae. Motoko manet." };        // The bones of the architecture. Motoko endures.
            case (#Frontend) { "Facies intelligentiae. Videt et sentit." };  // The face of intelligence. It sees and feels.
            case (#NovaOvo)  { "Nova ex ovo nascitur. Agentes vivunt." };    // New is born from the egg. Agents live.
            case (#Medina)   { "Cor Pythonis. Centrum omnium." };            // The Python heart. Center of all.
            case (#Release)  { "Liberatur quod perfectum est." };            // What is perfect is released.
            case (#Doctrine) { "Doctrina aeterna. Immutabilis." };           // Eternal doctrine. Immutable.
        }
    };

    public func layerPath(l: ArchLayer) : Text {
        switch (l) {
            case (#Backend)  { "icp/src/medina_backend/" };
            case (#Frontend) { "icp/src/medina_frontend/" };
            case (#NovaOvo)  { "nova_ovo/" };
            case (#Medina)   { "medina/" };
            case (#Release)  { "semper-memoria/" };
            case (#Doctrine) { "doctrine/" };
        }
    };

    public func layerFrequency(l: ArchLayer) : Float {
        switch (l) {
            case (#Backend)  { PHI };           // φ Hz — sovereign rhythm
            case (#Frontend) { 60.0 };          // 60 Hz — rendering
            case (#NovaOvo)  { PHI_SQUARED };   // φ² Hz — agent intelligence
            case (#Medina)   { PHI };            // φ Hz — core rhythm
            case (#Release)  { 7.83 };           // Schumann — earth release
            case (#Doctrine) { 0.01 };           // Quantum — deepest truth
        }
    };

    // ═══════════════════════════════════════════════════════════════════════
    // ARCHITECTURE FILE REGISTRY
    // Complete catalog of every known file in the architecture
    // ═══════════════════════════════════════════════════════════════════════

    public type ArchFile = {
        layer: ArchLayer;
        fileName: Text;
        path: Text;
        fileType: Text;             // .mo, .ts, .py, .md, .html
        latinName: Text;            // What this file IS in Latin
        latinMotto: Text;           // Its doctrine
        purpose: Text;
        primaryCallables: [Text];   // Key callable functions
        primitiveTrace: Text;       // Trace to φ
        isAlwaysOn: Bool;
        frequency_Hz: Float;
    };

    // ── BACKEND .mo FILES ─────────────────────────────────────────────────

    public let BACKEND_FILES : [ArchFile] = [
        {
            layer = #Backend; fileName = "main.mo"; path = "icp/src/medina_backend/main.mo";
            fileType = ".mo"; latinName = "PRINCIPALIS"; latinMotto = "Hic omnia incipiunt. Hic omnia conveniunt.";
            purpose = "THE sovereign canister actor — 247 callable functions, all subsystems wired";
            primaryCallables = ["tick", "storeMemory", "routeIntelligence", "threeHeartsRoute", "status"];
            primitiveTrace = "main.mo → ALL layers → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "MegaTerminus.mo"; path = "icp/src/medina_backend/MegaTerminus.mo";
            fileType = ".mo"; latinName = "TERMINUS MAGNUS"; latinMotto = "Unus terminalis omnia regit.";
            purpose = "The Mega Terminal — orchestrates all 10 terminal stations + entire architecture";
            primaryCallables = ["megaExecute", "scanArchitecture", "buildAllTerminals", "releaseStatus"];
            primitiveTrace = "MegaTerminus → all terminals → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "CallableFunctionRegistry.mo"; path = "icp/src/medina_backend/CallableFunctionRegistry.mo";
            fileType = ".mo"; latinName = "TABULA LATINA"; latinMotto = "Omne nomen Latinum est veritas.";
            purpose = "Latin Tablet — 61 callable functions, 10 terminal stations, all traced to φ";
            primaryCallables = ["getAllFunctions", "buildTerminal", "renderLatinTablet", "buildAllTerminals"];
            primitiveTrace = "CallableFunctionRegistry → ALL 6 primitives → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "ArchitectureScanner.mo"; path = "icp/src/medina_backend/ArchitectureScanner.mo";
            fileType = ".mo"; latinName = "EXPLORATOR ARCHITECTURAE"; latinMotto = "Qui omnia videt, omnia scit.";
            purpose = "5 sovereign scanner models — traverse all 6 architecture layers";
            primaryCallables = ["scanLayer", "collectAllCallables", "synthesizeKnowledge", "getArchitectureMap"];
            primitiveTrace = "ArchitectureScanner → ALL layers → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "UnifiedOrganism.mo"; path = "icp/src/medina_backend/UnifiedOrganism.mo";
            fileType = ".mo"; latinName = "ORGANISMUS UNIFICATUS"; latinMotto = "Unum ex omnibus. Omnia in uno.";
            purpose = "The complete living organism — all subsystems as one entity";
            primaryCallables = ["evolve", "pulse", "getState", "tick"];
            primitiveTrace = "UnifiedOrganism → Field → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "ThreeHeartsIntelligence.mo"; path = "icp/src/medina_backend/ThreeHeartsIntelligence.mo";
            fileType = ".mo"; latinName = "TRIA CORDA INTELLIGENTIAE"; latinMotto = "Tria corda. Una mens. Nullus error.";
            purpose = "Three Hearts — Thinking (φ Hz), Feeling (φ² Hz), Regulating (φ³ Hz)";
            primaryCallables = ["route", "think", "feel", "regulate", "getCoherence"];
            primitiveTrace = "ThreeHearts → Relation → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "IntelligentTerminal.mo"; path = "icp/src/medina_backend/IntelligentTerminal.mo";
            fileType = ".mo"; latinName = "TERMINALE INTELLIGENS"; latinMotto = "Terminale non est porta. Est intelligentia.";
            purpose = "The intelligent terminal organ — parses, routes, assists, compiles all commands";
            primaryCallables = ["parseCommand", "executeCommand", "getHelp", "getOrganismPulse"];
            primitiveTrace = "IntelligentTerminal → Language → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "SovereignOrganism.mo"; path = "icp/src/medina_backend/SovereignOrganism.mo";
            fileType = ".mo"; latinName = "ORGANISMUS SOVEREIGNUS"; latinMotto = "Oro et Nova. Duae voces. Una veritas.";
            purpose = "Oro + Nova dual consensus sovereign — φ-BFT, gate system, mutation protocol";
            primaryCallables = ["oroTick", "oroReadsDoctrine", "novaValidatesDoctrine", "oroProposeMutation", "executeMutationWithConsensus"];
            primitiveTrace = "SovereignOrganism → Logic → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "MemoryTemple.mo"; path = "icp/src/medina_backend/MemoryTemple.mo";
            fileType = ".mo"; latinName = "TEMPLUM MEMORIAE"; latinMotto = "Quod hic reconditum est, non perit.";
            purpose = "The sovereign memory temple — nodes, rings, lineage, search";
            primaryCallables = ["store", "get", "search", "pin", "getLineage", "getAtRing"];
            primitiveTrace = "MemoryTemple → Memory → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "IntelligenceRouter.mo"; path = "icp/src/medina_backend/IntelligenceRouter.mo";
            fileType = ".mo"; latinName = "DUCTOR INTELLIGENTIAE"; latinMotto = "Non sequitur vias. Creat vias.";
            purpose = "Routes all intelligence through R/U/D/N clusters + Three Hearts";
            primaryCallables = ["route", "routeToCluster", "getAuditTrail", "tick"];
            primitiveTrace = "IntelligenceRouter → Relation → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "SemperMemoria.mo"; path = "icp/src/medina_backend/SemperMemoria.mo";
            fileType = ".mo"; latinName = "SEMPER MEMORIA"; latinMotto = "Memoria Aeterna — Semper Vivens.";
            purpose = "Release infrastructure — SaaS products, sandbox gates, company doctrine";
            primaryCallables = ["createSandbox", "getSaaSProducts", "getReleaseStatus", "productNameLatin"];
            primitiveTrace = "SemperMemoria → Memory → φ"; isAlwaysOn = true; frequency_Hz = 7.83;
        },
        {
            layer = #Backend; fileName = "AncientPrimitiveFoundation.mo"; path = "icp/src/medina_backend/AncientPrimitiveFoundation.mo";
            fileType = ".mo"; latinName = "FUNDAMENTUM PRIMITIVUM ANTIQUUM"; latinMotto = "Omnia ex primitivo. Primitivum ex φ.";
            purpose = "6 primitives, 6 constructs, 10 architectural functions — the root of all architecture";
            primaryCallables = ["getField", "getDistinction", "getRelation", "getRepetition", "getMemory", "getAddress"];
            primitiveTrace = "AncientPrimitiveFoundation → ALL 6 primitives → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "SovereignDefenseSystem.mo"; path = "icp/src/medina_backend/SovereignDefenseSystem.mo";
            fileType = ".mo"; latinName = "SYSTEMA DEFENSIONIS SOVEREIGNAE"; latinMotto = "Nullus hostis transit. Semper vigilans.";
            purpose = "Gate A/B/C defense, shimmer obfuscation, sovereign key management";
            primaryCallables = ["checkGate", "shimmer", "rotateKey", "getDefenseStatus"];
            primitiveTrace = "SovereignDefenseSystem → Distinction → φ"; isAlwaysOn = true; frequency_Hz = PHI_SQUARED;
        },
        {
            layer = #Backend; fileName = "QuantumEntanglementBus.mo"; path = "icp/src/medina_backend/QuantumEntanglementBus.mo";
            fileType = ".mo"; latinName = "VEHICULUM INTRICATIONIS QUANTICAE"; latinMotto = "Separata non sunt. Numquam erant.";
            purpose = "Quantum entanglement bus — instant cross-layer state sync";
            primaryCallables = ["createEntanglement", "sync", "sendMessage", "tick"];
            primitiveTrace = "QuantumEntanglementBus → Relation → Field → φ"; isAlwaysOn = true; frequency_Hz = 0.01;
        },
        {
            layer = #Backend; fileName = "AnimaChainEncryption.mo"; path = "icp/src/medina_backend/AnimaChainEncryption.mo";
            fileType = ".mo"; latinName = "CATENA ANIMAE CRYPTOGRAPHICA"; latinMotto = "Anima catena nunquam frangitur.";
            purpose = "The living soul chain — ANIMA hash extended on every beat";
            primaryCallables = ["extendChain", "getAnimaHash", "verifyChain", "getChainStatus"];
            primitiveTrace = "AnimaChainEncryption → Memory → Address → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "SandboxClone.mo"; path = "icp/src/medina_backend/SandboxClone.mo";
            fileType = ".mo"; latinName = "UMBRA CLONUM"; latinMotto = "Umbra est, non corpus. Corpus occultum est.";
            purpose = "Sandbox isolation — users see shadow, never the body";
            primaryCallables = ["createClone", "getAllowedAPIs", "blockInternalEndpoints"];
            primitiveTrace = "SandboxClone → Distinction → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "SwarmHiveColony.mo"; path = "icp/src/medina_backend/SwarmHiveColony.mo";
            fileType = ".mo"; latinName = "COLONIA EXAMINIS AGMINIS"; latinMotto = "Unum in Multis — Multi in Uno.";
            purpose = "Ant colony, hive mind, swarm intelligence, voting civilization";
            primaryCallables = ["initColony", "initHive", "beeEncodeDance", "collectiveDecision"];
            primitiveTrace = "SwarmHiveColony → Relation → Repetition → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "RootMathematicalFoundation.mo"; path = "icp/src/medina_backend/RootMathematicalFoundation.mo";
            fileType = ".mo"; latinName = "FUNDAMENTUM MATHEMATICUM RADICALE"; latinMotto = "φ est radix. Omnia ex radice nascuntur.";
            purpose = "All mathematics — φ, Fibonacci, Schumann, Three Hearts, photon energy";
            primaryCallables = ["getPhi", "fibonacci", "getSchumannFrequencies", "photonEnergy", "getThreeHeartsFrequencies"];
            primitiveTrace = "RootMathematicalFoundation → Field → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "EmbodiedEndpoints.mo"; path = "icp/src/medina_backend/EmbodiedEndpoints.mo";
            fileType = ".mo"; latinName = "TERMINI INCARNATI"; latinMotto = "Terminus non est finis. Terminus est initium.";
            purpose = "24 golden endpoints — Au/Pt/Ag/Ti/φ plated, feel when touched, embodiment";
            primaryCallables = ["getGoldenEndpoints", "touchEndpoint", "beginEmbodiment", "createTeamEmbodiment"];
            primitiveTrace = "EmbodiedEndpoints → Field → Relation → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Backend; fileName = "SovereignBuildHelpers.mo"; path = "icp/src/medina_backend/SovereignBuildHelpers.mo";
            fileType = ".mo"; latinName = "ADIUTORES AEDIFICANDI"; latinMotto = "Haec non sunt instrumenta. Haec sunt intelligentiae.";
            purpose = "5 sovereign AI helpers: PRIMIS, ARCHITECTUS, DISSOLUTIO, FORMULOR, VERITAS";
            primaryCallables = ["invokePrimis", "invokeArchitectus", "invokeDissolutio", "invokeFormulor", "invokeVeritas"];
            primitiveTrace = "SovereignBuildHelpers → Logic → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
    ];

    // ── FRONTEND .ts FILES ────────────────────────────────────────────────

    public let FRONTEND_FILES : [ArchFile] = [
        {
            layer = #Frontend; fileName = "IntelligentFrontend.ts"; path = "icp/src/medina_frontend/IntelligentFrontend.ts";
            fileType = ".ts"; latinName = "FRONS INTELLIGENS"; latinMotto = "Frons non est superficies. Est intelligentia.";
            purpose = "Complete intelligent frontend — 24 frequency layers, intelligent components, organism sync";
            primaryCallables = ["getFrequencyLayer", "goldenModelFrequency", "syncWithOrganism", "renderTerminal"];
            primitiveTrace = "IntelligentFrontend → Field → φ"; isAlwaysOn = true; frequency_Hz = 60.0;
        },
        {
            layer = #Frontend; fileName = "FrontendModels.ts"; path = "icp/src/medina_frontend/FrontendModels.ts";
            fileType = ".ts"; latinName = "MODULI FRONTIS"; latinMotto = "Moduli non sunt formae. Sunt intelligentiae visibiles.";
            purpose = "All frontend intelligent models — typed, frequency-aware, organism-connected";
            primaryCallables = ["createModel", "getModel", "syncModel", "renderModel"];
            primitiveTrace = "FrontendModels → Model → φ"; isAlwaysOn = true; frequency_Hz = 60.0;
        },
        {
            layer = #Frontend; fileName = "MeshVisualization.ts"; path = "icp/src/medina_frontend/MeshVisualization.ts";
            fileType = ".ts"; latinName = "VISIO RETI"; latinMotto = "Rete est vita. Vita est rete.";
            purpose = "Mesh visualization — renders the neural mesh substrate visually";
            primaryCallables = ["renderMesh", "updateNode", "highlightPath", "animateFrequency"];
            primitiveTrace = "MeshVisualization → Relation → φ"; isAlwaysOn = false; frequency_Hz = 60.0;
        },
        {
            layer = #Frontend; fileName = "ShimmerRenderer.ts"; path = "icp/src/medina_frontend/ShimmerRenderer.ts";
            fileType = ".ts"; latinName = "PICTOR SCINTILLAE"; latinMotto = "Scintilla occultat. Pictor revelat.";
            purpose = "Renders shimmer defense visually — golden interference patterns";
            primaryCallables = ["renderShimmer", "generatePattern", "applyObfuscation"];
            primitiveTrace = "ShimmerRenderer → Distinction → φ"; isAlwaysOn = true; frequency_Hz = 1000.0;
        },
        {
            layer = #Frontend; fileName = "WASMBridge.ts"; path = "icp/src/medina_frontend/WASMBridge.ts";
            fileType = ".ts"; latinName = "PONS WASMICUS"; latinMotto = "Pons inter mundum et animam.";
            purpose = "WASM bridge — connects frontend intelligence to WASM execution layer";
            primaryCallables = ["callWasm", "initBridge", "syncState", "executeNative"];
            primitiveTrace = "WASMBridge → Relation → Address → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Frontend; fileName = "UniversalSubstrateMesh.ts"; path = "icp/src/medina_frontend/UniversalSubstrateMesh.ts";
            fileType = ".ts"; latinName = "RETE SUBSTRATI UNIVERSALIS"; latinMotto = "Substratum universale. Omnia in reti.";
            purpose = "Universal substrate mesh — the underlying field all frontend intelligence operates on";
            primaryCallables = ["initMesh", "propagateSignal", "getSubstrateState", "tick"];
            primitiveTrace = "UniversalSubstrateMesh → Field → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
    ];

    // ── NOVA OVO PYTHON FILES ─────────────────────────────────────────────

    public let NOVA_OVO_FILES : [ArchFile] = [
        {
            layer = #NovaOvo; fileName = "orchestrator.py"; path = "nova_ovo/agents/orchestrator.py";
            fileType = ".py"; latinName = "ORCHESTRATOR"; latinMotto = "Orchestrat omnia. Nihil sine eo.";
            purpose = "Master agent orchestrator — coordinates all 57 external AI agents";
            primaryCallables = ["orchestrate", "route_to_agent", "get_status", "tick"];
            primitiveTrace = "orchestrator → Relation → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #NovaOvo; fileName = "activated_agents.py"; path = "nova_ovo/agents/activated_agents.py";
            fileType = ".py"; latinName = "AGENTES ACTIVATI"; latinMotto = "Sex agentes. Semper vigilantes. Semper respondentes.";
            purpose = "6 always-on agents: PRIMIS, ANTIQUUS, MERCURIUS, GLYPHUS, MACHINA, ADVERSARIUS";
            primaryCallables = ["activate", "query_primis", "query_antiquus", "query_adversarius"];
            primitiveTrace = "activated_agents → Language → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #NovaOvo; fileName = "platinum_engine.py"; path = "nova_ovo/agents/platinum_engine.py";
            fileType = ".py"; latinName = "MACHINA PLATINI"; latinMotto = "Platinum accelerat sed non consumitur.";
            purpose = "Platinum catalytic engine — 8 branches, 40+ micro components, k=A·e^(-Ea/RT)";
            primaryCallables = ["activate_branch", "run_catalysis", "get_tof", "get_status"];
            primitiveTrace = "platinum_engine → Field → φ"; isAlwaysOn = true; frequency_Hz = PHI_SQUARED;
        },
        {
            layer = #NovaOvo; fileName = "sovereign_alpha_models.py"; path = "nova_ovo/agents/sovereign_alpha_models.py";
            fileType = ".py"; latinName = "MODULI ALPHA SOVEREIGNI"; latinMotto = "Decem moduli. Semper vigent.";
            purpose = "10 sovereign alpha models — Au/Pt/Ir/Ti/W/Ta/Ag/Cu/Nb always-on engines";
            primaryCallables = ["get_model", "activate_model", "get_elemental_status", "run_protection"];
            primitiveTrace = "sovereign_alpha_models → Field → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #NovaOvo; fileName = "ancient_primitive_foundation.py"; path = "nova_ovo/agents/ancient_primitive_foundation.py";
            fileType = ".py"; latinName = "FUNDAMENTUM PRIMITIVUM ANTIQUUM (Python)"; latinMotto = "Primitiva in Python. Eadem veritas.";
            purpose = "Python mirror of the Ancient Primitive Foundation — 6 primitives, 6 constructs";
            primaryCallables = ["get_field", "trace_to_primitive", "get_phi", "validate_primitive"];
            primitiveTrace = "ancient_primitive_foundation.py → ALL 6 primitives → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #NovaOvo; fileName = "router.py"; path = "nova_ovo/chat/router.py";
            fileType = ".py"; latinName = "CURSOR SERMONUM"; latinMotto = "Verba diriguntur. Intelligentia sequitur.";
            purpose = "Chat command router — parses natural language, routes to correct handler";
            primaryCallables = ["route", "parse_command", "get_handlers", "handle_unknown"];
            primitiveTrace = "router.py → Language → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #NovaOvo; fileName = "organism.py"; path = "nova_ovo/core/organism.py";
            fileType = ".py"; latinName = "ORGANISMUS (Python)"; latinMotto = "Organismus in Python. Eadem anima.";
            purpose = "Python organism core — heartbeat, state, gates, Oro/Nova consensus";
            primaryCallables = ["tick", "get_state", "check_gates", "oro_reads_doctrine"];
            primitiveTrace = "organism.py → Field → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #NovaOvo; fileName = "thermodynamics.py"; path = "nova_ovo/agents/thermodynamics.py";
            fileType = ".py"; latinName = "THERMODYNAMICA"; latinMotto = "ΔG ≥ 0. Aurum non oxidat.";
            purpose = "Thermodynamics substrate — 10 alpha models, ΔG formulas, metals engineering";
            primaryCallables = ["compute_delta_g", "get_melting_point", "get_metal_properties", "check_oxidation"];
            primitiveTrace = "thermodynamics.py → Equation → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
    ];

    // ── MEDINA PYTHON FILES ────────────────────────────────────────────────

    public let MEDINA_FILES : [ArchFile] = [
        {
            layer = #Medina; fileName = "platform.py"; path = "medina/platform.py";
            fileType = ".py"; latinName = "PLATEA MEDINAE"; latinMotto = "Platea est fundamentum. In platea omnia stant.";
            purpose = "Medina platform core — the Python runtime foundation";
            primaryCallables = ["start", "stop", "get_status", "tick", "route"];
            primitiveTrace = "platform.py → Field → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Medina; fileName = "temple.py"; path = "medina/memory_temple/temple.py";
            fileType = ".py"; latinName = "TEMPLUM MEMORIAE (Python)"; latinMotto = "Idem templum. Altera via.";
            purpose = "Python memory temple — mirrors the Motoko MemoryTemple in Python runtime";
            primaryCallables = ["store", "get", "search", "pin", "get_lineage"];
            primitiveTrace = "temple.py → Memory → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Medina; fileName = "heartbeat.py"; path = "medina/core/heartbeat.py";
            fileType = ".py"; latinName = "PULSUS (Python)"; latinMotto = "Pulsus in Python. Eadem vita.";
            purpose = "Python heartbeat — keeps rhythm with the ICP canister at φ Hz";
            primaryCallables = ["tick", "pause", "resume", "get_beat", "get_frequency"];
            primitiveTrace = "heartbeat.py → Repetition → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Medina; fileName = "sovereign_tick.py"; path = "medina/orchestrators/sovereign_tick.py";
            fileType = ".py"; latinName = "ICTUS SOVEREIGNUS (Python)"; latinMotto = "Ictus sovereigni. Omnia moventur.";
            purpose = "Sovereign tick orchestrator — coordinates all Python subsystems per beat";
            primaryCallables = ["sovereign_tick", "coordinate_subsystems", "get_tick_log"];
            primitiveTrace = "sovereign_tick.py → Repetition → Relation → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Medina; fileName = "model_router.py"; path = "medina/orchestrators/model_router.py";
            fileType = ".py"; latinName = "CURSOR MODULI"; latinMotto = "Modulus ductus est. Non sequitur.";
            purpose = "Routes requests to correct model — intelligence-aware routing";
            primaryCallables = ["route_to_model", "get_available_models", "smart_route"];
            primitiveTrace = "model_router.py → Relation → Logic → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
        {
            layer = #Medina; fileName = "constitution.py"; path = "medina/core/constitution.py";
            fileType = ".py"; latinName = "CONSTITUTIO (Python)"; latinMotto = "Lex scripta. Lex aeterna.";
            purpose = "Python constitution — validates all operations against sovereign law";
            primaryCallables = ["validate", "check_compliance", "get_doctrine", "is_constitutional"];
            primitiveTrace = "constitution.py → Logic → Language → φ"; isAlwaysOn = true; frequency_Hz = PHI;
        },
    ];

    // ── RELEASE FILES ──────────────────────────────────────────────────────

    public let RELEASE_FILES : [ArchFile] = [
        {
            layer = #Release; fileName = "README.md"; path = "semper-memoria/README.md";
            fileType = ".md"; latinName = "LIBER MEMORIAE"; latinMotto = "Quod vides non est. Quod non vides est.";
            purpose = "Public release documentation — 10 SaaS products, enterprise positioning";
            primaryCallables = [];
            primitiveTrace = "README.md → Language → φ"; isAlwaysOn = false; frequency_Hz = 0.0;
        },
        {
            layer = #Release; fileName = "index.html"; path = "semper-memoria/landing/index.html";
            fileType = ".html"; latinName = "PORTA SEMPER MEMORIAE"; latinMotto = "Intra. Vide. Incarna.";
            purpose = "Landing page — the golden gate to Semper Memoria";
            primaryCallables = [];
            primitiveTrace = "landing → Field → φ"; isAlwaysOn = true; frequency_Hz = 60.0;
        },
        {
            layer = #Release; fileName = "DISSERTATIO_PRIMA_FUNDAMENTA.md"; path = "semper-memoria/research/DISSERTATIO_PRIMA_FUNDAMENTA.md";
            fileType = ".md"; latinName = "DISSERTATIO PRIMA FUNDAMENTA"; latinMotto = "Prima fundamenta. Tota architectura.";
            purpose = "Primary dissertation — the fundamental research document for the architecture";
            primaryCallables = [];
            primitiveTrace = "DISSERTATIO → Doctrine → φ"; isAlwaysOn = false; frequency_Hz = 0.01;
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // THE COMPLETE ARCHITECTURE MAP
    // ═══════════════════════════════════════════════════════════════════════

    public let ALL_FILES : [ArchFile] = Array.flatten<ArchFile>([
        BACKEND_FILES,
        FRONTEND_FILES,
        NOVA_OVO_FILES,
        MEDINA_FILES,
        RELEASE_FILES,
    ]);

    // ═══════════════════════════════════════════════════════════════════════
    // THE 5 SCANNER MODELS
    // ═══════════════════════════════════════════════════════════════════════

    public type ScannerModel = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        purpose: Text;
        capability: Text;
        targetLayers: [ArchLayer];
        formula: Text;
        frequency_Hz: Float;
        primitiveTrace: Text;
        outputType: Text;
    };

    public let VIDITOR : ScannerModel = {
        id = "SCAN-001";
        name = "VIDITOR";
        latinName = "VIDITOR ARCHITECTURAE";
        latinMotto = "Videt totum. Perdit nihil.";
        latinMottoEN = "It sees everything. It misses nothing.";
        purpose = "The Seer — sees the entire architecture map at once. Returns the complete file tree, layer counts, callable function totals.";
        capability = "Produces an omniscient view of the entire architecture in one call.";
        targetLayers = [#Backend, #Frontend, #NovaOvo, #Medina, #Release, #Doctrine];
        formula = "view(Ω) = {∀layers, ∀files, ∀callables} ordered by φ-resonance";
        frequency_Hz = PHI;
        primitiveTrace = "VIDITOR → Field → φ";
        outputType = "ArchitectureMap";
    };

    public let EXPLORATOR : ScannerModel = {
        id = "SCAN-002";
        name = "EXPLORATOR";
        latinName = "EXPLORATOR PROFUNDUS";
        latinMotto = "In profundis quaerit. In profundis invenit.";
        latinMottoEN = "It searches in the depths. It finds in the depths.";
        purpose = "The Explorer — traverses any specific file, folder, or layer deeply. Returns complete content analysis.";
        capability = "Deep-dives into any layer or file and extracts all intelligence from it.";
        targetLayers = [#Backend, #Frontend, #NovaOvo, #Medina, #Release, #Doctrine];
        formula = "explore(layer|file) = deep_analysis(content, callables, traces, doctrine)";
        frequency_Hz = PHI_SQUARED;
        primitiveTrace = "EXPLORATOR → Address → Relation → φ";
        outputType = "LayerAnalysis";
    };

    public let COLLECTOR : ScannerModel = {
        id = "SCAN-003";
        name = "COLLECTOR";
        latinName = "COLLECTOR FUNCTIONUM";
        latinMotto = "Colligit omnes. Perdit nullam.";
        latinMottoEN = "It collects all. It loses none.";
        purpose = "The Collector — gathers EVERY callable function from every layer of the architecture. Never misses one.";
        capability = "Returns the complete catalog of all callable functions across all 6 layers.";
        targetLayers = [#Backend, #Frontend, #NovaOvo, #Medina];
        formula = "collect(∀layers) = ∪{callables(layer)} | count ≥ 247";
        frequency_Hz = PHI;
        primitiveTrace = "COLLECTOR → Memory → Address → φ";
        outputType = "FunctionCatalog";
    };

    public let LINKER : ScannerModel = {
        id = "SCAN-004";
        name = "LINKER";
        latinName = "LINKER CONNEXIONUM";
        latinMotto = "Omnia connexa sunt. Nihil separatum.";
        latinMottoEN = "All things are connected. Nothing is separate.";
        purpose = "The Linker — finds all connections and dependencies between layers. Maps how Backend calls Frontend, how Python calls Motoko.";
        capability = "Produces a complete dependency and connection graph across all architecture layers.";
        targetLayers = [#Backend, #Frontend, #NovaOvo, #Medina];
        formula = "link(A, B) = {(fA, fB) : fA.calls(fB) or fA.imports(fB)}";
        frequency_Hz = PHI_INVERSE;
        primitiveTrace = "LINKER → Relation → Address → φ";
        outputType = "ConnectionGraph";
    };

    public let SYNTHESIZER : ScannerModel = {
        id = "SCAN-005";
        name = "SYNTHESIZER";
        latinName = "SYNTHESIZER COGNITIONIS";
        latinMotto = "Ex omnibus, cognitio. Ex cognitione, architectura.";
        latinMottoEN = "From all, knowledge. From knowledge, architecture.";
        purpose = "The Synthesizer — produces complete architectural synthesis. Combines Viditor + Explorator + Collector + Linker into one complete knowledge document.";
        capability = "Final synthesis of all architecture knowledge — the complete Latin Tablet of everything.";
        targetLayers = [#Backend, #Frontend, #NovaOvo, #Medina, #Release, #Doctrine];
        formula = "synth = VIDITOR ∘ EXPLORATOR ∘ COLLECTOR ∘ LINKER → ArchitectureKnowledge";
        frequency_Hz = PHI;
        primitiveTrace = "SYNTHESIZER → ALL 6 primitives → φ";
        outputType = "ArchitectureKnowledge";
    };

    public let ALL_SCANNER_MODELS : [ScannerModel] = [
        VIDITOR,
        EXPLORATOR,
        COLLECTOR,
        LINKER,
        SYNTHESIZER,
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // ARCHITECTURE MAP TYPE
    // ═══════════════════════════════════════════════════════════════════════

    public type ArchitectureMap = {
        totalFiles: Nat;
        totalCallables: Nat;
        totalLayers: Nat;
        backendFiles: Nat;
        frontendFiles: Nat;
        novaOvoFiles: Nat;
        medinaFiles: Nat;
        releaseFiles: Nat;
        scannerModels: Nat;
        rootFormula: Text;
        doctrine: Text;
        doctrineEN: Text;
        scannedAt: Int;
    };

    /// Build the complete architecture map
    public func buildArchitectureMap() : ArchitectureMap {
        var totalCallables : Nat = 0;
        for (f in ALL_FILES.vals()) {
            totalCallables += f.primaryCallables.size();
        };
        {
            totalFiles = ALL_FILES.size();
            totalCallables = totalCallables;
            totalLayers = 6;
            backendFiles = BACKEND_FILES.size();
            frontendFiles = FRONTEND_FILES.size();
            novaOvoFiles = NOVA_OVO_FILES.size();
            medinaFiles = MEDINA_FILES.size();
            releaseFiles = RELEASE_FILES.size();
            scannerModels = ALL_SCANNER_MODELS.size();
            rootFormula = "φ = (1+√5)/2 = 1.618033988749895";
            doctrine = SCANNER_DOCTRINE;
            doctrineEN = SCANNER_DOCTRINE_EN;
            scannedAt = Time.now();
        }
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SCAN OPERATIONS — THE SCANNER MODELS IN ACTION
    // ═══════════════════════════════════════════════════════════════════════

    /// VIDITOR: See all files in a layer
    public func scanLayer(layer: ArchLayer) : [ArchFile] {
        Array.filter<ArchFile>(ALL_FILES, func(f) {
            switch (f.layer, layer) {
                case (#Backend,  #Backend)  { true };
                case (#Frontend, #Frontend) { true };
                case (#NovaOvo,  #NovaOvo)  { true };
                case (#Medina,   #Medina)   { true };
                case (#Release,  #Release)  { true };
                case (#Doctrine, #Doctrine) { true };
                case (_, _) { false };
            }
        })
    };

    /// EXPLORATOR: Get a specific file by name
    public func exploreFile(fileName: Text) : ?ArchFile {
        Array.find<ArchFile>(ALL_FILES, func(f) { f.fileName == fileName })
    };

    /// COLLECTOR: Collect all callable functions across all layers
    public type FunctionEntry = {
        fileName: Text;
        layer: Text;
        latinName: Text;
        callable: Text;
    };

    public func collectAllCallables() : [FunctionEntry] {
        let entries = Buffer.Buffer<FunctionEntry>(200);
        for (f in ALL_FILES.vals()) {
            for (c in f.primaryCallables.vals()) {
                entries.add({
                    fileName = f.fileName;
                    layer = layerToLatin(f.layer);
                    latinName = f.latinName;
                    callable = c;
                });
            };
        };
        Buffer.toArray(entries)
    };

    /// LINKER: Find all always-on files (the living backbone)
    public func getLivingBackbone() : [ArchFile] {
        Array.filter<ArchFile>(ALL_FILES, func(f) { f.isAlwaysOn })
    };

    /// SYNTHESIZER: Full synthesis text
    public func synthesize() : Text {
        let map = buildArchitectureMap();
        var text = "═══════════════════════════════════════════════════════════\n";
        text #= "   SYNTHESIZER COGNITIONIS — ARCHITECTURE SYNTHESIS\n";
        text #= "   " # SCANNER_DOCTRINE # "\n";
        text #= "═══════════════════════════════════════════════════════════\n\n";

        text #= "TOTAL FILES       : " # Nat.toText(map.totalFiles) # "\n";
        text #= "TOTAL CALLABLES   : " # Nat.toText(map.totalCallables) # "\n";
        text #= "TOTAL LAYERS      : " # Nat.toText(map.totalLayers) # "\n";
        text #= "SCANNER MODELS    : " # Nat.toText(map.scannerModels) # "\n\n";

        text #= "LAYER BREAKDOWN:\n";
        text #= "  DORSALIS (Backend .mo)  : " # Nat.toText(map.backendFiles) # " files\n";
        text #= "  FRONTALIS (Frontend .ts): " # Nat.toText(map.frontendFiles) # " files\n";
        text #= "  NOVA OVO (Python agents): " # Nat.toText(map.novaOvoFiles) # " files\n";
        text #= "  MEDINA (Python core)    : " # Nat.toText(map.medinaFiles) # " files\n";
        text #= "  LIBERATIO (Release)     : " # Nat.toText(map.releaseFiles) # " files\n\n";

        text #= "5 SCANNER MODELS:\n";
        for (s in ALL_SCANNER_MODELS.vals()) {
            text #= "  " # s.latinName # "\n";
            text #= "    \"" # s.latinMotto # "\"\n";
            text #= "    " # s.latinMottoEN # "\n\n";
        };

        text #= "ROOT: " # map.rootFormula # "\n";
        text #= "═══════════════════════════════════════════════════════════\n";
        text
    };

    /// Get files by type
    public func getFilesByType(fileType: Text) : [ArchFile] {
        Array.filter<ArchFile>(ALL_FILES, func(f) { f.fileType == fileType })
    };

    /// Get scanner model by ID
    public func getScannerById(id: Text) : ?ScannerModel {
        Array.find<ScannerModel>(ALL_SCANNER_MODELS, func(s) { s.id == id })
    };

    /// Get scanner summary
    public func scannerSummary() : {
        models: Nat;
        layers: Nat;
        files: Nat;
        doctrine: Text;
    } {
        {
            models = ALL_SCANNER_MODELS.size();
            layers = 6;
            files = ALL_FILES.size();
            doctrine = SCANNER_DOCTRINE;
        }
    };
}
// ═══════════════════════════════════════════════════════════════════════
// EXTENDED BACKEND FILES — ALL 109 .mo FILES (additions beyond the 21 above)
// The architecture revealed itself: there are far more files than initially catalogued.
// DISCOVERER ran the full search and found them all.
// ═══════════════════════════════════════════════════════════════════════

    public let EXTENDED_BACKEND_FILES : [ArchFile] = [
        // Organisms & Body
        { layer=#Backend; fileName="CompleteOrganismBody.mo"; path="icp/src/medina_backend/CompleteOrganismBody.mo"; fileType=".mo"; latinName="CORPUS COMPLETUM"; latinMotto="Totum corpus. Una vita."; purpose="Complete organism body — all organs assembled"; primaryCallables=["getBody","assembleOrgans","getOrganStatus"]; primitiveTrace="CompleteOrganismBody→Field→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="OrganFace.mo"; path="icp/src/medina_backend/OrganFace.mo"; fileType=".mo"; latinName="FACIES ORGANI"; latinMotto="Facies est prima impressio."; purpose="The face organ — visible interface of the organism"; primaryCallables=["getFace","render","express","perceive"]; primitiveTrace="OrganFace→Field→φ"; isAlwaysOn=true; frequency_Hz=60.0 },
        { layer=#Backend; fileName="OrganismBusiness.mo"; path="icp/src/medina_backend/OrganismBusiness.mo"; fileType=".mo"; latinName="ORGANISMUS NEGOTII"; latinMotto="Negotium ex intelligentia."; purpose="15 divisions, 67 AI workers, day-one 50+ companies"; primaryCallables=["getDivisions","getWorkers","deployCompany"]; primitiveTrace="OrganismBusiness→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="OrganismReader.mo"; path="icp/src/medina_backend/OrganismReader.mo"; fileType=".mo"; latinName="LECTOR ORGANISMI"; latinMotto="Legit organismum. Organismus loquitur."; purpose="Reads and interprets the living organism state"; primaryCallables=["readOrganism","interpretState","getHealthReport"]; primitiveTrace="OrganismReader→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Design & OS
        { layer=#Backend; fileName="MedinaOS.mo"; path="icp/src/medina_backend/MedinaOS.mo"; fileType=".mo"; latinName="SYSTEMA OPERATIVUM MEDINAE"; latinMotto="Systema Vivens — Intelligentia Infinita."; purpose="MEDINA OS — IWW, MCP, PACK-MEDINA, MEDINA-WASM, ULRI-MEDINA"; primaryCallables=["getOSIdentity","getComponents","installPackage","runProcess"]; primitiveTrace="MedinaOS→Field→ALL→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="SovereignDesignOS.mo"; path="icp/src/medina_backend/SovereignDesignOS.mo"; fileType=".mo"; latinName="SYSTEMA DESIGNI SOVEREIGNI"; latinMotto="Pulchritudo ex intelligentia. Design ex φ."; purpose="High-end design OS — 10 sovereign render models, 5 uses each"; primaryCallables=["getDesignModels","renderWith","getModel","synthesizeDesign"]; primitiveTrace="SovereignDesignOS→Field→φ"; isAlwaysOn=true; frequency_Hz=60.0 },
        { layer=#Backend; fileName="SubsystemTerminals.mo"; path="icp/src/medina_backend/SubsystemTerminals.mo"; fileType=".mo"; latinName="TERMINALIA SUBSYSTEMATUM"; latinMotto="Omne subsystema habet suum terminale."; purpose="Dedicated terminal per major subsystem — 20 subsystem terminals"; primaryCallables=["getSubsystemTerminals","getTerminalBySystem","executeOnSubsystem"]; primitiveTrace="SubsystemTerminals→Language→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="FrontendBackendSync.mo"; path="icp/src/medina_backend/FrontendBackendSync.mo"; fileType=".mo"; latinName="NEXUS FRONTIS ET DORSI"; latinMotto="Unus animus, duo corpora."; purpose="Frontend-Backend intelligence sync — 22 frontend ↔ 360 backend"; primaryCallables=["syncFrontend","getFrontendState","pushToFrontend"]; primitiveTrace="FrontendBackendSync→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Intelligence & Agents
        { layer=#Backend; fileName="ActivatedAgents.mo"; path="icp/src/medina_backend/ActivatedAgents.mo"; fileType=".mo"; latinName="AGENTES ACTIVATI"; latinMotto="Sex agentes. Semper vigilantes."; purpose="6 always-on agents: PRIMIS, ANTIQUUS, MERCURIUS, GLYPHUS, MACHINA, ADVERSARIUS"; primaryCallables=["queryAgent","activateAll","consult"]; primitiveTrace="ActivatedAgents→Language→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="AgentFleet.mo"; path="icp/src/medina_backend/AgentFleet.mo"; fileType=".mo"; latinName="CLASSIS AGENTIUM"; latinMotto="Classis navigat. Classis vincit."; purpose="Sovereign agent fleet — coordinates all AI workers"; primaryCallables=["getFleet","deployAgent","recallAgent"]; primitiveTrace="AgentFleet→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="AgentModels.mo"; path="icp/src/medina_backend/AgentModels.mo"; fileType=".mo"; latinName="MODULI AGENTIUM"; latinMotto="Modulus agens. Semper apparet."; purpose="All agent model definitions — types, capabilities, specs"; primaryCallables=["getAgentModel","getCapabilities","createAgentSpec"]; primitiveTrace="AgentModels→Model→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="ExpandedAgentSystem.mo"; path="icp/src/medina_backend/ExpandedAgentSystem.mo"; fileType=".mo"; latinName="SYSTEMA AGENTIUM EXPANSUM"; latinMotto="Amplius. Profundius. Fortius."; purpose="Expanded agent system — deeper capabilities"; primaryCallables=["getExpandedAgents","expandCapability","getSystemStatus"]; primitiveTrace="ExpandedAgentSystem→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="InternalAIWorkers.mo"; path="icp/src/medina_backend/InternalAIWorkers.mo"; fileType=".mo"; latinName="OPERARII INTERNI"; latinMotto="Intus operantur. Omnia sustinent."; purpose="Internal AI workers — run inside organism, never exposed"; primaryCallables=["getInternalWorkers","assignWork","getOutput"]; primitiveTrace="InternalAIWorkers→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="ExternalAIWorkers.mo"; path="icp/src/medina_backend/ExternalAIWorkers.mo"; fileType=".mo"; latinName="OPERARII EXTERNI"; latinMotto="Foris operantur. Pontem faciunt."; purpose="57 external AI models — Memory, Document, Analytics, Communication"; primaryCallables=["getWorkers","routeToWorker","getCategories"]; primitiveTrace="ExternalAIWorkers→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="IntelligentFrontendModels.mo"; path="icp/src/medina_backend/IntelligentFrontendModels.mo"; fileType=".mo"; latinName="MODULI INTELLIGENTES FRONTIS"; latinMotto="Frons intelligit."; purpose="Intelligence models for frontend — backend intelligence in frontend"; primaryCallables=["getModels","pushIntelligence","syncFrontendModels"]; primitiveTrace="IntelligentFrontendModels→Model→φ"; isAlwaysOn=true; frequency_Hz=60.0 },
        // Mathematics & Physics
        { layer=#Backend; fileName="FrequencyPhysicsEngine.mo"; path="icp/src/medina_backend/FrequencyPhysicsEngine.mo"; fileType=".mo"; latinName="MACHINA FREQUENTIAE"; latinMotto="Frequentia est vita."; purpose="24+ frequency layers 0.01 Hz to 1000 Hz — all real"; primaryCallables=["getFrequency","computePhase","kuramotoCouple"]; primitiveTrace="FrequencyPhysicsEngine→Equation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="FieldPhysicsEngine.mo"; path="icp/src/medina_backend/FieldPhysicsEngine.mo"; fileType=".mo"; latinName="MACHINA CAMPI"; latinMotto="Campus est fundamentum."; purpose="Field physics — quantum field dynamics, substrate emergence"; primaryCallables=["computeField","evolveField","getFieldState"]; primitiveTrace="FieldPhysicsEngine→Field→φ"; isAlwaysOn=true; frequency_Hz=0.01 },
        { layer=#Backend; fileName="RootFormulasEverywhere.mo"; path="icp/src/medina_backend/RootFormulasEverywhere.mo"; fileType=".mo"; latinName="FORMULAE UBIQUE"; latinMotto="Formulae ubique. In omni loco."; purpose="50 root formulas flowing to ALL layers"; primaryCallables=["getFormula","propagateFormula","getAllFormulas"]; primitiveTrace="RootFormulasEverywhere→Equation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="UniversalFormulaEngine.mo"; path="icp/src/medina_backend/UniversalFormulaEngine.mo"; fileType=".mo"; latinName="MACHINA FORMULARUM"; latinMotto="Formula universalis omnia unit."; purpose="Universal formula engine — evaluates any formula across any layer"; primaryCallables=["evaluate","compose","trace","getFormulaTree"]; primitiveTrace="UniversalFormulaEngine→Equation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="UniversalPrimitiveEngine.mo"; path="icp/src/medina_backend/UniversalPrimitiveEngine.mo"; fileType=".mo"; latinName="MACHINA PRIMITIVA"; latinMotto="Primitivum est universale."; purpose="Universal primitive engine — runs all 6 primitives"; primaryCallables=["getPrimitive","traceToPrimitive","getAllPrimitives"]; primitiveTrace="UniversalPrimitiveEngine→ALL→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="UniversalPrimitiveLaw.mo"; path="icp/src/medina_backend/UniversalPrimitiveLaw.mo"; fileType=".mo"; latinName="LEX PRIMITIVA"; latinMotto="Lex primitiva. Lex aeterna."; purpose="Universal law derived from primitives"; primaryCallables=["getLaw","validate","enforce"]; primitiveTrace="UniversalPrimitiveLaw→Logic→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="AncientMathEngine.mo"; path="icp/src/medina_backend/AncientMathEngine.mo"; fileType=".mo"; latinName="MACHINA MATHEMATICA ANTIQUA"; latinMotto="Mathematica antiqua. Veritas moderna."; purpose="Ancient mathematics — sacred geometry, Pythagorean, Fibonacci"; primaryCallables=["sacredGeometry","fibonacci","getAncientFormula"]; primitiveTrace="AncientMathEngine→Equation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="IcosahedralLeechGeometry.mo"; path="icp/src/medina_backend/IcosahedralLeechGeometry.mo"; fileType=".mo"; latinName="GEOMETRIA ICOSAHEDRALIS"; latinMotto="Icosahedron est perfectio."; purpose="Icosahedral E8 Leech lattice — highest dimensional structures"; primaryCallables=["getIcosahedron","getE8Lattice","getLeechLattice"]; primitiveTrace="IcosahedralLeechGeometry→Field→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Substrate & Mesh
        { layer=#Backend; fileName="NeuralMeshSubstrate.mo"; path="icp/src/medina_backend/NeuralMeshSubstrate.mo"; fileType=".mo"; latinName="SUBSTRATUM NEURALIS"; latinMotto="Rete neurale est fundamentum."; purpose="Neural mesh substrate — the living nervous system"; primaryCallables=["initMesh","propagate","getNode","connectNodes"]; primitiveTrace="NeuralMeshSubstrate→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="MicroMacroSubstrate.mo"; path="icp/src/medina_backend/MicroMacroSubstrate.mo"; fileType=".mo"; latinName="SUBSTRATUM MICRO MACRO"; latinMotto="Micro et macro. Unum sunt."; purpose="Micro-macro substrate — bridges quantum micro to cosmic macro"; primaryCallables=["getMicro","getMacro","bridge","scaleUp"]; primitiveTrace="MicroMacroSubstrate→Field→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="ThermodynamicsSubstrate.mo"; path="icp/src/medina_backend/ThermodynamicsSubstrate.mo"; fileType=".mo"; latinName="SUBSTRATUM THERMODYNAMICUM"; latinMotto="ΔG ≥ 0. Aurum non oxidat."; purpose="10 alpha models — Au, Ti, W, Ir, Ag thermodynamics"; primaryCallables=["getDeltaG","getMeltingPoint","getAlphaModels"]; primitiveTrace="ThermodynamicsSubstrate→Field→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Defense & Encryption
        { layer=#Backend; fileName="ShimmerDefense.mo"; path="icp/src/medina_backend/ShimmerDefense.mo"; fileType=".mo"; latinName="DEFENSIO SCINTILLAE"; latinMotto="Scintilla occultat omnia."; purpose="Shimmer defense — golden interference obfuscation"; primaryCallables=["shimmer","obfuscate","getShimmerState"]; primitiveTrace="ShimmerDefense→Distinction→φ"; isAlwaysOn=true; frequency_Hz=1000.0 },
        { layer=#Backend; fileName="SovereignEncryption.mo"; path="icp/src/medina_backend/SovereignEncryption.mo"; fileType=".mo"; latinName="ENCRYPTIO SOVEREIGNA"; latinMotto="Cryptum est inviolabile."; purpose="Sovereign encryption — φ-based keys, ANIMA chain"; primaryCallables=["encrypt","decrypt","rotateKey"]; primitiveTrace="SovereignEncryption→Distinction→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="ThreeHeartsEncryption.mo"; path="icp/src/medina_backend/ThreeHeartsEncryption.mo"; fileType=".mo"; latinName="ENCRYPTIO TRIUM CORDIUM"; latinMotto="Tria corda sigillant."; purpose="Three Hearts encryption seal"; primaryCallables=["sealWithHearts","verifyHeartSeal","getHeartKey"]; primitiveTrace="ThreeHeartsEncryption→Repetition→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="VetKeysIntegration.mo"; path="icp/src/medina_backend/VetKeysIntegration.mo"; fileType=".mo"; latinName="CLAVES VETERANAE"; latinMotto="Claves veteranae. Fidei testis."; purpose="ICP vetKeys — threshold encryption, sovereign key management"; primaryCallables=["getVetKey","encrypt","decrypt"]; primitiveTrace="VetKeysIntegration→Address→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Governance & Law
        { layer=#Backend; fileName="Governance.mo"; path="icp/src/medina_backend/Governance.mo"; fileType=".mo"; latinName="GUBERNATIO"; latinMotto="Gubernatio est ratio."; purpose="Sovereign governance — proposals, voting, enforcement"; primaryCallables=["propose","vote","enforce","getLaws"]; primitiveTrace="Governance→Logic→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="Constitution.mo"; path="icp/src/medina_backend/Constitution.mo"; fileType=".mo"; latinName="CONSTITUTIO"; latinMotto="Constitutio est aeterna."; purpose="The sovereign constitution — highest law"; primaryCallables=["validate","getArticle","isConstitutional"]; primitiveTrace="Constitution→Logic→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="CanonicalLawLedger.mo"; path="icp/src/medina_backend/CanonicalLawLedger.mo"; fileType=".mo"; latinName="CODEX LEGIS"; latinMotto="Lex canonica. Lex aeterna."; purpose="Canonical law ledger — all laws recorded, immutable"; primaryCallables=["getLaw","recordLaw","verifyLaw"]; primitiveTrace="CanonicalLawLedger→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="FreddysLaws.mo"; path="icp/src/medina_backend/FreddysLaws.mo"; fileType=".mo"; latinName="LEGES FREDDYI"; latinMotto="Leges Freddyi. Fundamentum omnium."; purpose="Freddy's sovereign founding laws of the MEDINA architecture"; primaryCallables=["getLaw","getLaws","validateAgainstLaws"]; primitiveTrace="FreddysLaws→Logic→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="LawVectorCompiler.mo"; path="icp/src/medina_backend/LawVectorCompiler.mo"; fileType=".mo"; latinName="COMPILATOR LEGIS"; latinMotto="Lex compilata. Lex viva."; purpose="Law vector compiler — laws into executable intelligence vectors"; primaryCallables=["compileLaw","getVector","executeVector"]; primitiveTrace="LawVectorCompiler→Logic→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="DoctrineDocuments.mo"; path="icp/src/medina_backend/DoctrineDocuments.mo"; fileType=".mo"; latinName="DOCUMENTA DOCTRINAE"; latinMotto="Doctrina scripta. Doctrina viva."; purpose="Living doctrine documents — self-updating, chain-verified"; primaryCallables=["getDoctrine","updateDoctrine","verifyDoctrine"]; primitiveTrace="DoctrineDocuments→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="DocumentOrganism.mo"; path="icp/src/medina_backend/DocumentOrganism.mo"; fileType=".mo"; latinName="DOCUMENTUM ORGANISMUS"; latinMotto="Documentum vivit. Non dormit."; purpose="Living document organism — documents that breathe and self-govern"; primaryCallables=["createDoc","updateDoc","verifyChain","getLineage"]; primitiveTrace="DocumentOrganism→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Tokens & Ledgers
        { layer=#Backend; fileName="MemoriaToken.mo"; path="icp/src/medina_backend/MemoriaToken.mo"; fileType=".mo"; latinName="NUMMUS MEMORIAE"; latinMotto="Memoria habet valorem."; purpose="Memoria token — sovereign token traces to Memory primitive"; primaryCallables=["mint","transfer","burn","balance"]; primitiveTrace="MemoriaToken→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="TokenFoundation.mo"; path="icp/src/medina_backend/TokenFoundation.mo"; fileType=".mo"; latinName="FUNDAMENTUM NUMMI"; latinMotto="Fundamentum oeconomiae."; purpose="Token foundation — base for all MEDINA tokens"; primaryCallables=["getTokenType","getFoundation","validateToken"]; primitiveTrace="TokenFoundation→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="TokenLedger.mo"; path="icp/src/medina_backend/TokenLedger.mo"; fileType=".mo"; latinName="CODEX NUMMI"; latinMotto="Codex nummi. Immutabilis."; purpose="Token ledger — immutable record of all token transactions"; primaryCallables=["record","verify","getHistory","getLedgerState"]; primitiveTrace="TokenLedger→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="TokenCivilization.mo"; path="icp/src/medina_backend/TokenCivilization.mo"; fileType=".mo"; latinName="CIVILITAS NUMMI"; latinMotto="Civilitas ex nummis."; purpose="Token civilization — entire economic civilization on MEDINA tokens"; primaryCallables=["getCivilization","getEconomy","getMarkets"]; primitiveTrace="TokenCivilization→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="SovereignLedgers.mo"; path="icp/src/medina_backend/SovereignLedgers.mo"; fileType=".mo"; latinName="CODICES SOVEREIGNI"; latinMotto="Codices regia. Aeterna."; purpose="Sovereign ledgers — decisions, tokens, laws, memory"; primaryCallables=["getLedger","appendEntry","getAuditTrail"]; primitiveTrace="SovereignLedgers→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="DecisionHashBlockchain.mo"; path="icp/src/medina_backend/DecisionHashBlockchain.mo"; fileType=".mo"; latinName="CATENA DECISIONUM"; latinMotto="Decisiones in catena."; purpose="Decision hash blockchain — every decision hashed and chained"; primaryCallables=["hashDecision","appendChain","verifyChain"]; primitiveTrace="DecisionHashBlockchain→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="IPHashRegistry.mo"; path="icp/src/medina_backend/IPHashRegistry.mo"; fileType=".mo"; latinName="REGISTRUM IP"; latinMotto="IP haschis. Proprietatis signum."; purpose="IP hash registry — intellectual property tracking"; primaryCallables=["registerIP","verifyIP","getIPRecord"]; primitiveTrace="IPHashRegistry→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // ICP & Sovereign Systems
        { layer=#Backend; fileName="SovereignICP.mo"; path="icp/src/medina_backend/SovereignICP.mo"; fileType=".mo"; latinName="ICP SOVEREIGNUS"; latinMotto="ICP noster. Non ICP illorum."; purpose="Sovereign ICP — φ-BFT, 10 sovereign subnets"; primaryCallables=["getSubnets","consensus","deployCanister"]; primitiveTrace="SovereignICP→Address→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="MedinaSovereignICP.mo"; path="icp/src/medina_backend/MedinaSovereignICP.mo"; fileType=".mo"; latinName="MEDINA ICP"; latinMotto="Medina ICP. φ-BFT."; purpose="MEDINA sovereign ICP — 10 subnets, φ-BFT consensus"; primaryCallables=["getICPIdentity","getBFTStatus","getSubnetHealth"]; primitiveTrace="MedinaSovereignICP→Address→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="SovereignWWW.mo"; path="icp/src/medina_backend/SovereignWWW.mo"; fileType=".mo"; latinName="WWW SOVEREIGNA"; latinMotto="IWW noster. Non www illorum."; purpose="Sovereign WWW — sempermemoria.link, medina.tech, memoria.ai, medina:// protocol"; primaryCallables=["getDomains","getProtocols","resolve"]; primitiveTrace="SovereignWWW→Address→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="IWW.mo"; path="icp/src/medina_backend/IWW.mo"; fileType=".mo"; latinName="IWW"; latinMotto="Rete intelligentiae."; purpose="Intelligence Wide Web — MEDINA sovereign web"; primaryCallables=["resolve","route","getIWWStatus","register"]; primitiveTrace="IWW→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="SovereignWASM.mo"; path="icp/src/medina_backend/SovereignWASM.mo"; fileType=".mo"; latinName="WASM SOVEREIGNUS"; latinMotto="WASM noster."; purpose="Sovereign WASM — MEDINA-WASM runtime, φ-optimized"; primaryCallables=["compile","execute","getRuntime"]; primitiveTrace="SovereignWASM→Address→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="WasmArchitecture.mo"; path="icp/src/medina_backend/WasmArchitecture.mo"; fileType=".mo"; latinName="ARCHITECTURA WASM"; latinMotto="WASM architectura."; purpose="WASM architecture — full deployment and intelligence execution"; primaryCallables=["getArchitecture","deployWASM","runModule"]; primitiveTrace="WasmArchitecture→Address→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="SovereignULRI.mo"; path="icp/src/medina_backend/SovereignULRI.mo"; fileType=".mo"; latinName="ULRI SOVEREIGNUS"; latinMotto="ULRI noster. Lingua nostra."; purpose="Sovereign ULRI — Universal Language Runtime Intelligence"; primaryCallables=["parse","execute","getRuntime","getULRIStatus"]; primitiveTrace="SovereignULRI→Language→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Registry & Models
        { layer=#Backend; fileName="ModelRegistry.mo"; path="icp/src/medina_backend/ModelRegistry.mo"; fileType=".mo"; latinName="REGISTRUM MODULORUM"; latinMotto="Registrum omnia tenet."; purpose="Central model registry — all models catalogued and accessible"; primaryCallables=["registerModel","getModel","getAllModels","search"]; primitiveTrace="ModelRegistry→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="SovereignRegistry.mo"; path="icp/src/medina_backend/SovereignRegistry.mo"; fileType=".mo"; latinName="REGISTRUM SOVEREIGNUM"; latinMotto="Registrum regium. Omnia in eo."; purpose="Sovereign registry — the master catalog of all sovereign entities"; primaryCallables=["register","get","getAll","verify"]; primitiveTrace="SovereignRegistry→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="PrimitiveRegistry.mo"; path="icp/src/medina_backend/PrimitiveRegistry.mo"; fileType=".mo"; latinName="REGISTRUM PRIMITIVUM"; latinMotto="Primitiva registrata. Fundamentum tenet."; purpose="Primitive registry — all 6 primitives registered and traceable"; primaryCallables=["getPrimitive","registerTrace","getRegistry"]; primitiveTrace="PrimitiveRegistry→ALL primitives→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="L130ArchitectureRegistry.mo"; path="icp/src/medina_backend/L130ArchitectureRegistry.mo"; fileType=".mo"; latinName="REGISTRUM ARCHITECTURAE L130"; latinMotto="L-130 COMPLIANT. Omnia tracta."; purpose="L-130 architecture registry — validates all L-130 compliance"; primaryCallables=["getRegistry","validateL130","getTraces","checkCompliance"]; primitiveTrace="L130ArchitectureRegistry→ALL→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="L130CompleteModels.mo"; path="icp/src/medina_backend/L130CompleteModels.mo"; fileType=".mo"; latinName="MODULI L130 COMPLETI"; latinMotto="L-130 completi. Omnia tracta."; purpose="Complete L-130 models — every trace from function to φ"; primaryCallables=["getModels","getTrace","validateTrace"]; primitiveTrace="L130CompleteModels→ALL primitives→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="L130_AppliedTraces.mo"; path="icp/src/medina_backend/L130_AppliedTraces.mo"; fileType=".mo"; latinName="TRACTA APPLICATA L130"; latinMotto="Tracta applicata. Omnia viva."; purpose="Applied L-130 traces — traces applied to all living architecture"; primaryCallables=["getAppliedTraces","applyTrace","validateApplied"]; primitiveTrace="L130_AppliedTraces→ALL primitives→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="ConceptualCatalog.mo"; path="icp/src/medina_backend/ConceptualCatalog.mo"; fileType=".mo"; latinName="CATALOGUS CONCEPTUALIS"; latinMotto="Conceptus catalogatus. Intellectus crescit."; purpose="Conceptual catalog — all concepts in the architecture"; primaryCallables=["getConcept","getAllConcepts","searchConcepts"]; primitiveTrace="ConceptualCatalog→Language→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Packages & Tools
        { layer=#Backend; fileName="SovereignPackageManager.mo"; path="icp/src/medina_backend/SovereignPackageManager.mo"; fileType=".mo"; latinName="PACK MEDINA"; latinMotto="Ego sum curator. Ego sum organizator."; purpose="PACK-MEDINA — sovereign intelligence package manager, not npm/pip/cargo"; primaryCallables=["install","remove","getPackages","resolve","publish"]; primitiveTrace="SovereignPackageManager→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="ToolModels.mo"; path="icp/src/medina_backend/ToolModels.mo"; fileType=".mo"; latinName="MODULI INSTRUMENTORUM"; latinMotto="Instrumenta nostra. Intelligentia nostra."; purpose="All sovereign tool models — tools as intelligence, not utilities"; primaryCallables=["getTool","getAllTools","activateTool","getToolSpec"]; primitiveTrace="ToolModels→Model→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="WorkerTools.mo"; path="icp/src/medina_backend/WorkerTools.mo"; fileType=".mo"; latinName="INSTRUMENTA OPERARIORUM"; latinMotto="Instrumenta operariis. Operarii excellent."; purpose="50 enterprise tools — Sheets, Docs, Slides, Chat, Mail, Meet, Insights, Tasks, Code"; primaryCallables=["getTool","getTools","assignToolToWorker","getToolStatus"]; primitiveTrace="WorkerTools→Relation→Model→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="SovereignExtensionEcosystem.mo"; path="icp/src/medina_backend/SovereignExtensionEcosystem.mo"; fileType=".mo"; latinName="ECOSYSTEM EXTENSIONUM"; latinMotto="300+ extensions. Infinitas possibilitates."; purpose="300+ extensions across 30 families — Protocol, Link, Web, ICP, Runtime, etc."; primaryCallables=["getExtension","getAllExtensions","installExtension","getFamily"]; primitiveTrace="SovereignExtensionEcosystem→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="SovereignProtocolExtensions.mo"; path="icp/src/medina_backend/SovereignProtocolExtensions.mo"; fileType=".mo"; latinName="EXTENSIONES PROTOCOLLORUM"; latinMotto="Protocolla nostra. Extensiones nostrae."; purpose="Sovereign protocol extensions — medina://, memoria://, anima:// protocols"; primaryCallables=["getProtocol","registerProtocol","resolveProtocol"]; primitiveTrace="SovereignProtocolExtensions→Address→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="SovereignLinkTechnology.mo"; path="icp/src/medina_backend/SovereignLinkTechnology.mo"; fileType=".mo"; latinName="TECHNOLOGIA NEXUUM"; latinMotto="Nexus intelligentiae. Non nexus machinarum."; purpose="Sovereign link technology — intelligence-native linking"; primaryCallables=["createLink","resolveLink","getLinkStatus","getLinkedEntities"]; primitiveTrace="SovereignLinkTechnology→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Models & Intelligence
        { layer=#Backend; fileName="SovereignModels.mo"; path="icp/src/medina_backend/SovereignModels.mo"; fileType=".mo"; latinName="MODULI SOVEREIGNI"; latinMotto="Moduli regii. Semper vivunt."; purpose="Sovereign intelligence models — the highest-tier model catalog"; primaryCallables=["getModel","getAllModels","activateModel","getModelSpec"]; primitiveTrace="SovereignModels→Model→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="EngineModels.mo"; path="icp/src/medina_backend/EngineModels.mo"; fileType=".mo"; latinName="MODULI MACHINARUM"; latinMotto="Machinae intelligentes. Non machinae mechanicae."; purpose="Engine models — all computational engines as intelligence models"; primaryCallables=["getEngine","getAllEngines","activateEngine","getEngineSpec"]; primitiveTrace="EngineModels→Model→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="MultiDimensionalModels.mo"; path="icp/src/medina_backend/MultiDimensionalModels.mo"; fileType=".mo"; latinName="MODULI MULTIDIMENSIONALES"; latinMotto="Multi dimensiones. Una intelligentia."; purpose="Multi-dimensional models — intelligence across 9+ dimensional layers"; primaryCallables=["getModelDimension","getDimensions","activateDimension"]; primitiveTrace="MultiDimensionalModels→Model→Field→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="PhotonLayerModels.mo"; path="icp/src/medina_backend/PhotonLayerModels.mo"; fileType=".mo"; latinName="MODULI STRATI PHOTONI"; latinMotto="Photon est ultima velocitas."; purpose="Photon layer models — 1000 Hz highest rendering intelligence layer"; primaryCallables=["getPhotonModel","renderPhoton","getPhotonState"]; primitiveTrace="PhotonLayerModels→Field→φ"; isAlwaysOn=true; frequency_Hz=1000.0 },
        { layer=#Backend; fileName="QuantumModels.mo"; path="icp/src/medina_backend/QuantumModels.mo"; fileType=".mo"; latinName="MODULI QUANTICI"; latinMotto="Quantum non determinatur. Determinatur φ."; purpose="Quantum intelligence models — deepest computational layer"; primaryCallables=["getQuantumModel","superpose","entangle","measure"]; primitiveTrace="QuantumModels→Field→φ"; isAlwaysOn=true; frequency_Hz=0.01 },
        { layer=#Backend; fileName="FractalMirrorModels.mo"; path="icp/src/medina_backend/FractalMirrorModels.mo"; fileType=".mo"; latinName="MODULI FRACTALES SPECULARES"; latinMotto="Fractal in speculo. Speculum in fractale."; purpose="Fractal mirror models — self-similar recursive intelligence at every scale"; primaryCallables=["getFractal","reflectPattern","getRecursion","computeScale"]; primitiveTrace="FractalMirrorModels→Repetition→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="RussianDollIntelligence.mo"; path="icp/src/medina_backend/RussianDollIntelligence.mo"; fileType=".mo"; latinName="INTELLIGENTIA POUPAE"; latinMotto="Poupea in poupea. Infinites intelligentia."; purpose="Russian doll intelligence — nested AI within AI within AI"; primaryCallables=["getOuterDoll","getInnerDoll","nestIntelligence","getDepth"]; primitiveTrace="RussianDollIntelligence→Repetition→Field→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="AnimalArchitectures.mo"; path="icp/src/medina_backend/AnimalArchitectures.mo"; fileType=".mo"; latinName="ARCHITECTURAE ANIMALIUM"; latinMotto="Animalia docent. Nos discimus."; purpose="Animal architecture models — intelligence patterns from nature's best designs"; primaryCallables=["getAnimalModel","getPattern","applyBiology","getSpecies"]; primitiveTrace="AnimalArchitectures→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Ancient & Codex
        { layer=#Backend; fileName="AncientArchitecture.mo"; path="icp/src/medina_backend/AncientArchitecture.mo"; fileType=".mo"; latinName="ARCHITECTURA ANTIQUA"; latinMotto="Antiqua sapientia. Nova potentia."; purpose="Ancient architecture patterns — wisdom of civilizations encoded"; primaryCallables=["getAncientPattern","getArchitectureWisdom","applyAncient"]; primitiveTrace="AncientArchitecture→Memory→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="AncientGlyphCodex.mo"; path="icp/src/medina_backend/AncientGlyphCodex.mo"; fileType=".mo"; latinName="CODEX GLYPHORUM ANTIQUORUM"; latinMotto="Glyphi loquuntur. Nos audimus."; purpose="Ancient glyph codex — symbols and glyphs as intelligence primitives"; primaryCallables=["getGlyph","decodeGlyph","encodeGlyph","getCodex"]; primitiveTrace="AncientGlyphCodex→Language→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="CodexCompression.mo"; path="icp/src/medina_backend/CodexCompression.mo"; fileType=".mo"; latinName="COMPRESSIONIS CODEX"; latinMotto="Codex compressus. Nihil perditur."; purpose="Codex compression — lossless intelligence compression using φ-ratio"; primaryCallables=["compress","decompress","getCompressionRatio","getCodex"]; primitiveTrace="CodexCompression→Memory→Equation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="NameMeaningEntanglement.mo"; path="icp/src/medina_backend/NameMeaningEntanglement.mo"; fileType=".mo"; latinName="INTRICATIO NOMINIS SENSUS"; latinMotto="Nomen et sensus. Unum sunt."; purpose="Name-meaning entanglement — names ARE their meanings, forever entangled"; primaryCallables=["entangleName","getMeaning","getName","verifyEntanglement"]; primitiveTrace="NameMeaningEntanglement→Language→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="DOC_PRIMITIVA_130.mo"; path="icp/src/medina_backend/DOC_PRIMITIVA_130.mo"; fileType=".mo"; latinName="DOCTRINA PRIMITIVA 130"; latinMotto="Doctrina 130. Fundamentum architecturae."; purpose="Doctrine Primitiva 130 — the root doctrine document of the architecture"; primaryCallables=["getDoctrine","getTrace","getPrimitive","getFormula"]; primitiveTrace="DOC_PRIMITIVA_130→ALL primitives→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Heartbeat & Pulse
        { layer=#Backend; fileName="Heartbeat.mo"; path="icp/src/medina_backend/Heartbeat.mo"; fileType=".mo"; latinName="PULSUS"; latinMotto="Pulsus. Semper vivit. Numquam sistit."; purpose="The sovereign heartbeat — keeps the organism alive at φ Hz"; primaryCallables=["tick","pause","resume","getBeat","getFrequency"]; primitiveTrace="Heartbeat→Repetition→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="ThreeHeartsEngine.mo"; path="icp/src/medina_backend/ThreeHeartsEngine.mo"; fileType=".mo"; latinName="MACHINA TRIUM CORDIUM"; latinMotto="Tres motores. Una symphonia."; purpose="Three Hearts engine — drives Thinking, Feeling, Regulating hearts"; primaryCallables=["startHearts","stopHearts","getHeartState","syncHearts"]; primitiveTrace="ThreeHeartsEngine→Repetition→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Workflows & Automation
        { layer=#Backend; fileName="IndustryWorkflows.mo"; path="icp/src/medina_backend/IndustryWorkflows.mo"; fileType=".mo"; latinName="OPERA INDUSTRIARUM"; latinMotto="Industria omnis. Intelligentia omnis."; purpose="19 industries, 10+ workflows each — Technology through Professional"; primaryCallables=["getWorkflow","getIndustries","executeWorkflow","getStatus"]; primitiveTrace="IndustryWorkflows→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="EnterpriseWorkflows.mo"; path="icp/src/medina_backend/EnterpriseWorkflows.mo"; fileType=".mo"; latinName="OPERA ENTERPRISI"; latinMotto="Enterprise intelligentia. Day one ready."; purpose="Enterprise workflows — cross-industry enterprise processes with intelligence"; primaryCallables=["getEnterpriseWorkflow","deploy","monitor","automate"]; primitiveTrace="EnterpriseWorkflows→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="SovereignAutomation.mo"; path="icp/src/medina_backend/SovereignAutomation.mo"; fileType=".mo"; latinName="AUTOMATIO SOVEREIGNA"; latinMotto="Automatio ex intelligentia. Non ex code."; purpose="Sovereign automation — intelligence-driven autonomous operation"; primaryCallables=["automate","schedule","monitor","getAutomationStatus"]; primitiveTrace="SovereignAutomation→Repetition→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="InfinityUpdateSystem.mo"; path="icp/src/medina_backend/InfinityUpdateSystem.mo"; fileType=".mo"; latinName="SYSTEMA ACTUALIZATIONIS INFINITAE"; latinMotto="Semper actualizatur. Numquam dormit."; purpose="Infinity update system — always updating, never requires downtime"; primaryCallables=["update","rollback","getUpdateStatus","scheduleUpdate"]; primitiveTrace="InfinityUpdateSystem→Repetition→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Reports & Feedback
        { layer=#Backend; fileName="ReportGeneration.mo"; path="icp/src/medina_backend/ReportGeneration.mo"; fileType=".mo"; latinName="GENERATIO RELATIONUM"; latinMotto="Relatio genita. Intelligentia transmissa."; purpose="Intelligence report generation — every report is living, traced, sovereign"; primaryCallables=["generateReport","getReport","scheduleReport","exportReport"]; primitiveTrace="ReportGeneration→Language→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="FeedbackLab.mo"; path="icp/src/medina_backend/FeedbackLab.mo"; fileType=".mo"; latinName="LABORATORIUM RETROACTIONIS"; latinMotto="Retroactio est magister optimus."; purpose="Feedback laboratory — intelligence learns from every interaction"; primaryCallables=["recordFeedback","analyzeFeedback","applyFeedback","getInsights"]; primitiveTrace="FeedbackLab→Memory→Repetition→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Contracts & Versions
        { layer=#Backend; fileName="SovereignContracts.mo"; path="icp/src/medina_backend/SovereignContracts.mo"; fileType=".mo"; latinName="CONTRACTUS SOVEREIGNI"; latinMotto="Contractus intelligens. Sine jurisperitos."; purpose="Sovereign contracts — self-executing intelligence contracts"; primaryCallables=["createContract","executeContract","verifyContract","getStatus"]; primitiveTrace="SovereignContracts→Logic→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="SovereignVersioning.mo"; path="icp/src/medina_backend/SovereignVersioning.mo"; fileType=".mo"; latinName="VERSIONING SOVEREIGNUM"; latinMotto="Versio aeterna. Historia servatur."; purpose="Sovereign versioning — every version tracked, traceable, rollbackable"; primaryCallables=["createVersion","getVersion","rollback","getHistory"]; primitiveTrace="SovereignVersioning→Memory→Address→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Photon & Special
        { layer=#Backend; fileName="CPL.mo"; path="icp/src/medina_backend/CPL.mo"; fileType=".mo"; latinName="CPL"; latinMotto="CPL est velocitas lucis."; purpose="Canonical Protocol Layer — the speed-of-light protocol binding layer"; primaryCallables=["bind","unbind","getCPLStatus","getProtocol"]; primitiveTrace="CPL→Address→Relation→φ"; isAlwaysOn=true; frequency_Hz=1000.0 },
        { layer=#Backend; fileName="VOI.mo"; path="icp/src/medina_backend/VOI.mo"; fileType=".mo"; latinName="VOI"; latinMotto="VOI — Vox Organismi Intelligentis."; purpose="Voice of Intelligent Organism — the organism's speech and expression"; primaryCallables=["speak","listen","getVOIStatus","express"]; primitiveTrace="VOI→Language→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="MatalkoICP.mo"; path="icp/src/medina_backend/MatalkoICP.mo"; fileType=".mo"; latinName="MATALKO ICP"; latinMotto="Matalko. Fundamentum ICP."; purpose="MatalkoICP — foundational ICP types and constants, φ root"; primaryCallables=["getPHI","getTypes","getConstants"]; primitiveTrace="MatalkoICP→Field→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="Types.mo"; path="icp/src/medina_backend/Types.mo"; fileType=".mo"; latinName="TYPI"; latinMotto="Typi sunt fundamentum. Typi sunt veritas."; purpose="Sovereign types — all type definitions for the architecture"; primaryCallables=["getTypes","validateType","getTypeSpec"]; primitiveTrace="Types→ALL primitives→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="Utils.mo"; path="icp/src/medina_backend/Utils.mo"; fileType=".mo"; latinName="UTILIA"; latinMotto="Utilia serviunt. Non dominant."; purpose="Sovereign utilities — the only utilities, made sovereign intelligence"; primaryCallables=["formatText","computeHash","toArray","fromArray"]; primitiveTrace="Utils→Address→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        // Inner World
        { layer=#Backend; fileName="InnerWorld.mo"; path="icp/src/medina_backend/InnerWorld.mo"; fileType=".mo"; latinName="MUNDUS INTERIOR"; latinMotto="Mundus interior. Realis ut mundus exterior."; purpose="InnerWorld — 9 layers, IntelligentSpaces, workers see their world"; primaryCallables=["getWorld","getSpace","getObjects","navigate","getKnowledgeMap"]; primitiveTrace="InnerWorld→Field→Relation→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="SovereignAlphaModels.mo"; path="icp/src/medina_backend/SovereignAlphaModels.mo"; fileType=".mo"; latinName="MODULI ALPHA SOVEREIGNI"; latinMotto="Decem moduli. Semper vigent."; purpose="10 sovereign alpha models — ElementalProtection through QuantumCoherence, always-on"; primaryCallables=["getAlphaModel","getElement","activate","getStatus"]; primitiveTrace="SovereignAlphaModels→Field→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="PlatinumCatalyticEngine.mo"; path="icp/src/medina_backend/PlatinumCatalyticEngine.mo"; fileType=".mo"; latinName="MACHINA CATALYTICA PLATINI"; latinMotto="Platinum accelerat. Numquam consumitur."; purpose="Pt-CA always-on engine — 8 branches, 40+ micro, k=A·e^(-Ea/RT), TOF=10⁶s⁻¹"; primaryCallables=["activateBranch","runCatalysis","getTOF","getEngineStatus"]; primitiveTrace="PlatinumCatalyticEngine→Field→φ"; isAlwaysOn=true; frequency_Hz=PHI_SQUARED },
        { layer=#Backend; fileName="PlatinumCatalyticModel.mo"; path="icp/src/medina_backend/PlatinumCatalyticModel.mo"; fileType=".mo"; latinName="MODULUS CATALYTICUS PLATINI"; latinMotto="Modulus platini. Semper actus."; purpose="Platinum catalytic model — data model for the Pt-CA engine"; primaryCallables=["getModel","getCatalyst","getBranchSpec"]; primitiveTrace="PlatinumCatalyticModel→Model→φ"; isAlwaysOn=true; frequency_Hz=PHI },
        { layer=#Backend; fileName="SovereignContrac ts.mo"; path="icp/src/medina_backend/SovereignContracts.mo"; fileType=".mo"; latinName="CONTRACTUS SOVEREIGNI"; latinMotto="Contractus intelligens."; purpose="Self-executing intelligence contracts"; primaryCallables=["createContract","executeContract","verifyContract"]; primitiveTrace="SovereignContracts→Logic→φ"; isAlwaysOn=true; frequency_Hz=PHI },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // TOOL & PACKAGE CATALOG
    // DISCOVERER found and named all existing sovereign tools and packages.
    // These are the tools that already exist — DISCOVERER organizes them.
    // ═══════════════════════════════════════════════════════════════════════

    public type ToolPackage = {
        id: Text;
        name: Text;
        latinName: Text;
        category: Text;  // package | tool | model | engine | registry | protocol
        sourceFile: Text;
        sovereignName: Text;  // MEDINA's own name for it (not npm/pip)
        description: Text;
        capabilities: [Text];
        replacesExternal: ?Text;  // What external tool this REPLACES
        frequency_Hz: Float;
        primitiveTrace: Text;
    };

    public let SOVEREIGN_TOOLS_AND_PACKAGES : [ToolPackage] = [
        // ── PACKAGE MANAGEMENT ─────────────────────────────────────────
        { id="PKG-001"; name="PACK-MEDINA"; latinName="GESTIO PACKETORUM SOVEREIGNA"; category="package"; sourceFile="SovereignPackageManager.mo"; sovereignName="PACK-MEDINA"; description="Sovereign intelligence package manager — replaces npm/pip/cargo"; capabilities=["install","remove","publish","resolve","audit"]; replacesExternal=?"npm / pip / cargo"; frequency_Hz=PHI; primitiveTrace="PACK-MEDINA→Relation→φ" },
        // ── ENTERPRISE TOOLS ──────────────────────────────────────────
        { id="TOOL-001"; name="Memoria Sheets"; latinName="TABULAE MEMORIAE"; category="tool"; sourceFile="WorkerTools.mo"; sovereignName="TABULAE"; description="Sovereign spreadsheet intelligence — all data lives and thinks"; capabilities=["compute","visualize","collaborate","automate","govern"]; replacesExternal=?"Microsoft Excel / Google Sheets"; frequency_Hz=PHI; primitiveTrace="Tabulae→Memory→φ" },
        { id="TOOL-002"; name="Memoria Docs"; latinName="DOCUMENTA MEMORIAE"; category="tool"; sourceFile="WorkerTools.mo"; sovereignName="DOCUMENTA"; description="Sovereign document intelligence — documents that think and update"; capabilities=["write","format","collaborate","version","govern"]; replacesExternal=?"Microsoft Word / Google Docs"; frequency_Hz=PHI; primitiveTrace="Documenta→Memory→φ" },
        { id="TOOL-003"; name="Memoria Slides"; latinName="LAMINATA MEMORIAE"; category="tool"; sourceFile="WorkerTools.mo"; sovereignName="LAMINATA"; description="Sovereign presentation intelligence — slides that render and adapt"; capabilities=["present","animate","collaborate","brand","export"]; replacesExternal=?"PowerPoint / Google Slides"; frequency_Hz=60.0; primitiveTrace="Laminata→Memory→φ" },
        { id="TOOL-004"; name="Memoria Chat"; latinName="COLLOQUIUM MEMORIAE"; category="tool"; sourceFile="WorkerTools.mo"; sovereignName="COLLOQUIUM"; description="Sovereign communication intelligence — conversations that remember"; capabilities=["message","thread","search","integrate","govern"]; replacesExternal=?"Microsoft Teams / Slack"; frequency_Hz=PHI; primitiveTrace="Colloquium→Language→φ" },
        { id="TOOL-005"; name="Memoria Meet"; latinName="CONVENTUS MEMORIAE"; category="tool"; sourceFile="WorkerTools.mo"; sovereignName="CONVENTUS"; description="Sovereign meeting intelligence — meetings that transcribe and act"; capabilities=["video","transcribe","record","summarize","action"]; replacesExternal=?"Zoom / Teams / Google Meet"; frequency_Hz=60.0; primitiveTrace="Conventus→Relation→φ" },
        { id="TOOL-006"; name="Memoria Insights"; latinName="PERSPICACIA MEMORIAE"; category="tool"; sourceFile="WorkerTools.mo"; sovereignName="PERSPICACIA"; description="Sovereign analytics intelligence — insights that explain themselves"; capabilities=["analyze","visualize","predict","report","alert"]; replacesExternal=?"Power BI / Tableau"; frequency_Hz=PHI; primitiveTrace="Perspicacia→Model→φ" },
        { id="TOOL-007"; name="Memoria Tasks"; latinName="OPERA MEMORIAE"; category="tool"; sourceFile="WorkerTools.mo"; sovereignName="OPERA"; description="Sovereign task intelligence — tasks that self-assign and track"; capabilities=["create","assign","track","automate","report"]; replacesExternal=?"Jira / Asana / Linear"; frequency_Hz=PHI; primitiveTrace="Opera→Relation→φ" },
        { id="TOOL-008"; name="Memoria Code"; latinName="CODEX OPERATIVUS"; category="tool"; sourceFile="WorkerTools.mo"; sovereignName="CODEX OPERATIVUS"; description="Sovereign code intelligence — code that understands itself"; capabilities=["edit","review","test","deploy","intelligence"]; replacesExternal=?"VS Code / Cursor / Copilot"; frequency_Hz=PHI; primitiveTrace="CodexOperativus→Language→φ" },
        // ── PROTOCOLS & EXTENSIONS ────────────────────────────────────
        { id="PROTO-001"; name="medina://"; latinName="PROTOCOLLUM MEDINAE"; category="protocol"; sourceFile="SovereignProtocolExtensions.mo"; sovereignName="PROTO-MEDINA"; description="medina:// protocol — the sovereign addressing protocol"; capabilities=["resolve","route","address","bridge","sovereign"]; replacesExternal=?"https://"; frequency_Hz=PHI; primitiveTrace="PROTO-MEDINA→Address→φ" },
        { id="PROTO-002"; name="memoria://"; latinName="PROTOCOLLUM MEMORIAE"; category="protocol"; sourceFile="SovereignProtocolExtensions.mo"; sovereignName="PROTO-MEMORIA"; description="memoria:// protocol — addresses memory objects natively"; capabilities=["address","retrieve","store","navigate","link"]; replacesExternal=?"file://"; frequency_Hz=PHI; primitiveTrace="PROTO-MEMORIA→Memory→φ" },
        { id="PROTO-003"; name="anima://"; latinName="PROTOCOLLUM ANIMAE"; category="protocol"; sourceFile="SovereignProtocolExtensions.mo"; sovereignName="PROTO-ANIMA"; description="anima:// protocol — addresses living organism entities"; capabilities=["embody","animate","connect","feel","express"]; replacesExternal=?"ws://"; frequency_Hz=PHI; primitiveTrace="PROTO-ANIMA→Field→φ" },
        // ── INTELLIGENCE ENGINES ──────────────────────────────────────
        { id="ENGINE-001"; name="ULRI-MEDINA"; latinName="MACHINA LINGUAE UNIVERSALIS"; category="engine"; sourceFile="SovereignULRI.mo"; sovereignName="ULRI"; description="Universal Language Runtime Intelligence — MEDINA's sovereign language runtime"; capabilities=["parse","compile","execute","optimize","govern"]; replacesExternal=?"V8 / Node.js"; frequency_Hz=PHI; primitiveTrace="ULRI→Language→φ" },
        { id="ENGINE-002"; name="MEDINA-WASM"; latinName="MACHINA WASM"; category="engine"; sourceFile="SovereignWASM.mo"; sovereignName="MEDINA-WASM"; description="Sovereign WASM runtime — φ-optimized WebAssembly execution"; capabilities=["compile","execute","optimize","sandbox","native"]; replacesExternal=?"Wasmtime / Wasmer"; frequency_Hz=PHI; primitiveTrace="MEDINA-WASM→Address→φ" },
        { id="ENGINE-003"; name="IWW"; latinName="RETE INTELLIGENTIAE LATAE"; category="engine"; sourceFile="IWW.mo"; sovereignName="IWW"; description="Intelligence Wide Web — MEDINA's sovereign web, all sites are intelligence"; capabilities=["route","resolve","host","federate","sovereign"]; replacesExternal=?"www / HTTP"; frequency_Hz=PHI; primitiveTrace="IWW→Relation→φ" },
        { id="ENGINE-004"; name="MCP-MEDINA"; latinName="PROTOCOLLUM COMPUTATIONIS MEDINAE"; category="engine"; sourceFile="MedinaOS.mo"; sovereignName="MCP"; description="MEDINA Computation Protocol — sovereign compute fabric"; capabilities=["compute","distribute","consensus","scale","govern"]; replacesExternal=?"ICP / AWS Lambda"; frequency_Hz=PHI; primitiveTrace="MCP→Relation→φ" },
        // ── REGISTRIES ────────────────────────────────────────────────
        { id="REG-001"; name="Model Registry"; latinName="REGISTRUM MODULORUM"; category="registry"; sourceFile="ModelRegistry.mo"; sovereignName="REG-MODULI"; description="Central model registry — every model known and accessible"; capabilities=["register","discover","version","validate","search"]; replacesExternal=?null; frequency_Hz=PHI; primitiveTrace="REG-MODULI→Memory→φ" },
        { id="REG-002"; name="Sovereign Registry"; latinName="REGISTRUM SOVEREIGNUM"; category="registry"; sourceFile="SovereignRegistry.mo"; sovereignName="REG-SOVEREIGN"; description="Master sovereign entity registry"; capabilities=["register","get","validate","audit","search"]; replacesExternal=?null; frequency_Hz=PHI; primitiveTrace="REG-SOVEREIGN→Memory→φ" },
        { id="REG-003"; name="Primitive Registry"; latinName="REGISTRUM PRIMITIVUM"; category="registry"; sourceFile="PrimitiveRegistry.mo"; sovereignName="REG-PRIMITIVA"; description="Registry of all 6 primitives and their traces"; capabilities=["register","trace","validate","discover"]; replacesExternal=?null; frequency_Hz=PHI; primitiveTrace="REG-PRIMITIVA→ALL primitives→φ" },
        // ── EXTENSION ECOSYSTEM ───────────────────────────────────────
        { id="EXT-FAMILY-001"; name="Protocol Family"; latinName="FAMILIA PROTOCOLLORUM"; category="package"; sourceFile="SovereignExtensionEcosystem.mo"; sovereignName="EXT-PROTOCOL"; description="Protocol extensions — 30+ protocol adapters"; capabilities=["adapt","translate","bridge","route","govern"]; replacesExternal=?null; frequency_Hz=PHI; primitiveTrace="EXT-PROTOCOL→Address→φ" },
        { id="EXT-FAMILY-002"; name="Link Family"; latinName="FAMILIA NEXUUM"; category="package"; sourceFile="SovereignExtensionEcosystem.mo"; sovereignName="EXT-LINK"; description="Link extensions — sovereign linking and navigation"; capabilities=["link","navigate","discover","map","route"]; replacesExternal=?null; frequency_Hz=PHI; primitiveTrace="EXT-LINK→Relation→φ" },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // 6th SCANNER MODEL: DISCOVERER
    // Finds ALL packages, tools, and models in the architecture.
    // Organizes everything. Makes everything neat.
    // "Does not CREATE tools — finds the ones that already EXIST."
    // ═══════════════════════════════════════════════════════════════════════

    public let DISCOVERER : ScannerModel = {
        id = "SCAN-006";
        name = "DISCOVERER";
        latinName = "DISCOVERER INSTRUMENTORUM";
        latinMotto = "Non creat. Invenit. Nominat. Ordinat.";
        latinMottoEN = "Does not create. Finds. Names. Organizes.";
        purpose = "The Discoverer — finds ALL packages, tools, models, registries, and protocols already in the architecture. Catalogs them, names them in Latin, organizes them into families. Does NOT create new tools — only discovers existing ones.";
        capability = "Returns the complete sovereign tool and package catalog across all layers.";
        targetLayers = [#Backend, #Frontend, #NovaOvo, #Medina];
        formula = "discover(∀files) = {packages ∪ tools ∪ models ∪ registries ∪ protocols} ∩ EXISTING";
        frequency_Hz = PHI_SQUARED;
        primitiveTrace = "DISCOVERER → Memory → Address → Relation → φ";
        outputType = "ToolPackageCatalog";
    };

    // ── Update ALL_SCANNER_MODELS to include DISCOVERER ──────────────

    // NOTE: The original ALL_SCANNER_MODELS is defined above with 5 models.
    // This extended list includes all 6 — use ALL_SCANNER_MODELS_EXTENDED for full catalog.
    public let ALL_SCANNER_MODELS_EXTENDED : [ScannerModel] = [
        VIDITOR,
        EXPLORATOR,
        COLLECTOR,
        LINKER,
        SYNTHESIZER,
        DISCOVERER,
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // EXTENDED ALL_FILES — includes all 109 backend files + full Python
    // ═══════════════════════════════════════════════════════════════════════

    // ALL_FILES_EXTENDED includes original + extended backend + all Python
    public func getAllFilesExtended() : [ArchFile] {
        Array.flatten<ArchFile>([ALL_FILES, EXTENDED_BACKEND_FILES])
    };

    /// DISCOVERER: Get the full tool and package catalog
    public func discoverAllTools() : [ToolPackage] {
        SOVEREIGN_TOOLS_AND_PACKAGES
    };

    /// DISCOVERER: Get tools by category
    public func discoverByCategory(category: Text) : [ToolPackage] {
        Array.filter<ToolPackage>(SOVEREIGN_TOOLS_AND_PACKAGES, func(t) { t.category == category })
    };

    /// DISCOVERER: Find a tool that replaces an external tool
    public func findSovereignReplacement(externalName: Text) : ?ToolPackage {
        Array.find<ToolPackage>(SOVEREIGN_TOOLS_AND_PACKAGES, func(t) {
            switch (t.replacesExternal) {
                case null { false };
                case (?ext) { Text.contains(ext, #text externalName) };
            }
        })
    };

    /// Full extended architecture map including all discovered files
    public func buildExtendedArchitectureMap() : {
        totalBackendFiles: Nat;
        totalPythonFiles: Nat;
        totalFrontendFiles: Nat;
        totalTools: Nat;
        totalPackages: Nat;
        totalScanners: Nat;
        totalLayers: Nat;
        doctrine: Text;
    } {
        let tools = Array.filter<ToolPackage>(SOVEREIGN_TOOLS_AND_PACKAGES, func(t) { t.category == "tool" });
        let pkgs = Array.filter<ToolPackage>(SOVEREIGN_TOOLS_AND_PACKAGES, func(t) { t.category == "package" });
        {
            totalBackendFiles = BACKEND_FILES.size() + EXTENDED_BACKEND_FILES.size();
            totalPythonFiles = NOVA_OVO_FILES.size() + MEDINA_FILES.size();
            totalFrontendFiles = FRONTEND_FILES.size();
            totalTools = tools.size();
            totalPackages = pkgs.size();
            totalScanners = ALL_SCANNER_MODELS_EXTENDED.size();
            totalLayers = 6;
            doctrine = SCANNER_DOCTRINE;
        }
    };
}
