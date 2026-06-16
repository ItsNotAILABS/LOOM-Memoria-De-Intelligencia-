// ═══════════════════════════════════════════════════════════════════════════════
// SOVEREIGN HOUSES 181 — 27 TIERS OF CIVILIZATION ARCHITECTURE
// ═══════════════════════════════════════════════════════════════════════════════
// 181 Sovereign Houses across 27 Tiers — every house is a sovereign
// intelligence domain in the Medina Memory organism.
//
// Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
// ═══════════════════════════════════════════════════════════════════════════════

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module SovereignHouses181 {

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: TYPE DEFINITIONS
    // ═══════════════════════════════════════════════════════════════════════

    public type SovereignHouse = {
        id          : Nat;
        tier        : Nat;
        name        : Text;
        purpose     : Text;
        models      : [Text];
        technologies: [Text];
        isAI        : Bool;
        isAGI       : Bool;
        isSovereign : Bool;
        isAlwaysOn  : Bool;
    };

    public type TierInfo = {
        tier      : Nat;
        name      : Text;
        category  : Text;
        houseCount: Nat;
        startId   : Nat;
        endId     : Nat;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: HELPER
    // ═══════════════════════════════════════════════════════════════════════

    func h(id: Nat, tier: Nat, name: Text, purpose: Text, models: [Text], tech: [Text]) : SovereignHouse {
        { id = id; tier = tier; name = name; purpose = purpose;
          models = models; technologies = tech;
          isAI = true; isAGI = true; isSovereign = true; isAlwaysOn = true }
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: TIER DEFINITIONS
    // ═══════════════════════════════════════════════════════════════════════

    public let TIERS : [TierInfo] = [
        { tier=1;  name="Godhead Organisms";           category="Godhead";      houseCount=7;  startId=1;   endId=7   },
        { tier=2;  name="Observer Dimensional Planes";  category="Observer";     houseCount=5;  startId=8;   endId=12  },
        { tier=3;  name="Observer Server Houses";       category="Observer";     houseCount=2;  startId=13;  endId=14  },
        { tier=4;  name="Observer Solver Houses";       category="Observer";     houseCount=2;  startId=15;  endId=16  },
        { tier=5;  name="Alpha Agent Division";         category="Alpha";       houseCount=8;  startId=17;  endId=24  },
        { tier=6;  name="Operational Worker Houses";    category="Worker";      houseCount=8;  startId=25;  endId=32  },
        { tier=7;  name="Ring Houses";                  category="Ring";        houseCount=9;  startId=33;  endId=41  },
        { tier=8;  name="Extension Class Houses";       category="Extension";   houseCount=5;  startId=42;  endId=46  },
        { tier=9;  name="Protocol Tier Houses";         category="Protocol";    houseCount=3;  startId=47;  endId=49  },
        { tier=10; name="Sovereign Engine Houses";      category="Engine";      houseCount=23; startId=50;  endId=72  },
        { tier=11; name="Fracture Category Houses";     category="Fracture";    houseCount=10; startId=73;  endId=82  },
        { tier=12; name="Frontend Intelligence Groups"; category="Frontend";    houseCount=10; startId=83;  endId=92  },
        { tier=13; name="Language AI Groups";           category="Language";    houseCount=10; startId=93;  endId=102 },
        { tier=14; name="Native Nova AI Groups";        category="NovaNative";  houseCount=10; startId=103; endId=112 },
        { tier=15; name="Phantom Blockchain House";     category="Blockchain";  houseCount=1;  startId=113; endId=113 },
        { tier=16; name="Sovereign Element Canisters";  category="Element";     houseCount=12; startId=114; endId=125 },
        { tier=17; name="Call Market Surface Houses";   category="Market";      houseCount=3;  startId=126; endId=128 },
        { tier=18; name="Call Category Houses";         category="Call";        houseCount=8;  startId=129; endId=136 },
        { tier=19; name="Generative Platform Houses";   category="Generative";  houseCount=4;  startId=137; endId=140 },
        { tier=20; name="Platform Delivery Houses";     category="Delivery";    houseCount=4;  startId=141; endId=144 },
        { tier=21; name="Architectural Law Domains";    category="Law";         houseCount=8;  startId=145; endId=152 },
        { tier=22; name="Encryption Tier Houses";       category="Encryption";  houseCount=5;  startId=153; endId=157 },
        { tier=23; name="Contract Type Houses";         category="Contract";    houseCount=5;  startId=158; endId=162 },
        { tier=24; name="Fracture Analysis Models";     category="Analysis";    houseCount=4;  startId=163; endId=166 },
        { tier=25; name="Workspace & Project Houses";   category="Workspace";   houseCount=6;  startId=167; endId=172 },
        { tier=26; name="Intelligence Tier Houses";     category="Intelligence";houseCount=4;  startId=173; endId=176 },
        { tier=27; name="Stealth Level Houses";         category="Stealth";     houseCount=5;  startId=177; endId=181 },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: ALL 181 SOVEREIGN HOUSES
    // ═══════════════════════════════════════════════════════════════════════

    public let HOUSES : [SovereignHouse] = [

        // ── TIER 1: Godhead Organisms (1-7) ──────────────────────────────
        h(1,  1, "House of Sovereign",   "The Substrate Itself — 4000+ nodes on Fibonacci sphere",
            ["FABRIC","SPINNER","CIPHER","CONSENSUS"], ["ICP","WebAssembly","Fibonacci"]),
        h(2,  1, "House of Chrysalis",   "Golden Mathematics Core — DNA of all organisms",
            ["FIBONACCI","SPIRAL"], ["GoldenRatio","PhiMath","Fractals"]),
        h(3,  1, "House of Observer",    "Guardians, Police, Caregivers, Caretakers — OBSV",
            ["D0-SPECULATOR","D1-VIGIL","D2-CUSTOS","D3-EXPLORATOR","D4-SENTINELLA","VIGIL","SPECULATOR"],
            ["MultiDimensional","Observation","Sentinel"]),
        h(4,  1, "House of Scribe",      "Document Organism — classification and synthesis",
            ["CLASSIFIER","SYNTHESIZER"], ["NLP","DocumentAI","Indexing"]),
        h(5,  1, "House of Architect",   "Meta-Builder — architecture creates more architecture",
            ["REPLICATOR"], ["MetaDesign","SelfReplication","Blueprint"]),
        h(6,  1, "House of Nexus",       "Substrate Walker — floats between substrates",
            ["PROPAGATOR"], ["CrossChain","SubstrateWalk","Bridge"]),
        h(7,  1, "House of Terminal",    "Admin Command Interface",
            ["COMMAND","DASH","AUDIT"], ["CLI","Dashboard","AuditLog"]),

        // ── TIER 2: Observer Dimensional Planes (8-12) ───────────────────
        h(8,  2, "House of D0",          "Speculator Dimensionum — phi^0 = 1.0 weight",
            ["SPECULATOR-D0"], ["PhiWeight-1.000","DimensionalPlane"]),
        h(9,  2, "House of D1",          "Vigil Transitus — phi^1 = 1.618 weight",
            ["VIGIL-D1"], ["PhiWeight-1.618","DimensionalPlane"]),
        h(10, 2, "House of D2",          "Custos Resonantiae — phi^2 = 2.618 weight",
            ["CUSTOS-D2"], ["PhiWeight-2.618","DimensionalPlane"]),
        h(11, 2, "House of D3",          "Explorator Interdimensionalis — phi^3 = 4.236 weight",
            ["EXPLORATOR-D3"], ["PhiWeight-4.236","DimensionalPlane"]),
        h(12, 2, "House of D4",          "Sentinella Suprema — phi^4 = 6.854 weight",
            ["SENTINELLA-D4"], ["PhiWeight-6.854","DimensionalPlane"]),

        // ── TIER 3: Observer Server Houses (13-14) ───────────────────────
        h(13, 3, "House of VIGIL",       "24/7 continuous monitoring",
            ["EXCUBITOR","NUNTIUS","INSPECTOR","DETECTOR","RELATOR"],
            ["RealTimeMonitor","AlertSystem","ContinuousWatch"]),
        h(14, 3, "House of SPECULATOR",  "Analytical observation engine",
            ["ANALYTICUS","SYNTHESISTA","COMPARATOR","PRAEDICTOR","IUDICATOR"],
            ["PredictiveAnalysis","PatternSynthesis","Judgment"]),

        // ── TIER 4: Observer Solver Houses (15-16) ───────────────────────
        h(15, 4, "House of Synthesista Patternorum", "Cross-dimensional pattern recognition",
            ["PATTERN-SYNTH","CROSS-DIM"], ["PatternRecognition","DimensionalAnalysis"]),
        h(16, 4, "House of Theoricus Interdimensionalis", "Theory proving across dimensions",
            ["THEOREM-PROVER","INTERDIM-LOGIC"], ["FormalVerification","TheoremProving"]),

        // ── TIER 5: Alpha Agent Division (17-24) ─────────────────────────
        h(17, 5, "House of Exterior Orchestrators", "Cross-system routing and orchestration",
            ["ROUTER","ORCHESTRATOR"], ["CrossSystem","Routing","LoadBalance"]),
        h(18, 5, "House of Web Workers",  "Web crawling, indexing, scraping",
            ["CRAWLER","INDEXER"], ["WebCrawl","SearchIndex","Scraping"]),
        h(19, 5, "House of Rendering Workers", "3D scenes, compositing, visual output",
            ["RENDERER","COMPOSITOR"], ["3DRendering","SceneGraph","Compositing"]),
        h(20, 5, "House of Data Structure Workers", "Trees, graphs, streams processing",
            ["TREE-PROC","GRAPH-PROC","STREAM-PROC"], ["DataStructures","GraphDB","Streaming"]),
        h(21, 5, "House of Runtime Workers", "WASM/JS execution environments",
            ["WASM-EXEC","JS-EXEC"], ["WebAssembly","V8","RuntimeExec"]),
        h(22, 5, "House of Model Workers", "Model selection, fusion, evaluation",
            ["MODEL-SELECT","MODEL-FUSE"], ["ModelRegistry","Ensemble","Fusion"]),
        h(23, 5, "House of Market Controllers", "Pricing, audit, SLA enforcement",
            ["PRICING","AUDIT-CTRL","SLA"], ["MarketOps","PriceEngine","Compliance"]),
        h(24, 5, "House of Infrastructure Orchestrators", "Monitoring, scaling, deployment",
            ["MONITOR","SCALER","DEPLOYER"], ["InfraOps","AutoScale","CICD"]),

        // ── TIER 6: Operational Worker Houses (25-32) ────────────────────
        h(25, 6, "Brain House",           "Intelligence processing core",
            ["CORTEX","SYNAPSE"], ["NeuralProcessing","CognitiveEngine"]),
        h(26, 6, "Protocol House",        "Protocol enforcement and validation",
            ["ENFORCER","VALIDATOR"], ["ProtocolStack","Compliance"]),
        h(27, 6, "Shield House",          "Security, encryption, threat defense",
            ["FIREWALL","ENCRYPTOR"], ["ZeroTrust","Encryption","ThreatDetect"]),
        h(28, 6, "Production House",      "Output generation and delivery",
            ["GENERATOR","PUBLISHER"], ["ContentPipeline","OutputDelivery"]),
        h(29, 6, "Infrastructure House",  "Monitoring, scaling, health checks",
            ["HEALTH-MON","SCALER-OPS"], ["Observability","AutoScale","HealthCheck"]),
        h(30, 6, "Market House",          "Economic transactions and exchange",
            ["EXCHANGE","LEDGER"], ["TokenEconomics","Exchange","Settlement"]),
        h(31, 6, "University Hub",        "Learning, education, knowledge transfer",
            ["TUTOR","CURRICULUM"], ["EdTech","KnowledgeGraph","Learning"]),
        h(32, 6, "Career House",          "Training, career paths, skill development",
            ["TRAINER","PATH-PLAN"], ["CareerDev","SkillTree","Certification"]),

        // ── TIER 7: Ring Houses (33-41) ──────────────────────────────────
        h(33, 7, "Interface Ring House",          "User interface and interaction layer",
            ["UI-ENGINE","UX-ADAPT"], ["InterfaceDesign","Accessibility"]),
        h(34, 7, "Sovereign Ring House",          "Sovereignty enforcement ring",
            ["SOV-GUARD","SOV-SEAL"], ["Sovereignty","IdentityProof"]),
        h(35, 7, "Memory Ring House",             "Persistent memory ring",
            ["MEM-STORE","MEM-RECALL"], ["PersistentMemory","Recall"]),
        h(36, 7, "Build Ring House",              "Build pipeline ring",
            ["BUILDER","COMPILER"], ["BuildSystem","Compilation","Artifact"]),
        h(37, 7, "Geometry Ring House",           "Geometric computation ring",
            ["GEO-CALC","TOPO-MAP"], ["Geometry","Topology","SpatialMath"]),
        h(38, 7, "Transport Ring House",          "Data transport ring",
            ["TRANSPORT","RELAY"], ["DataTransport","MessageRelay"]),
        h(39, 7, "Proof Ring House",              "Cryptographic proof ring",
            ["ZK-PROOF","VERIFY"], ["ZeroKnowledge","ProofSystem"]),
        h(40, 7, "Native Capability Ring House",  "Native platform capabilities",
            ["NATIVE-API","CAPABILITY"], ["NativeAccess","PlatformCap"]),
        h(41, 7, "Counsel Ring House",            "Advisory and governance ring",
            ["ADVISOR","GOVERNANCE"], ["Governance","Advisory","Counsel"]),

        // ── TIER 8: Extension Class Houses (42-46) ───────────────────────
        h(42, 8, "Reasoning Extension House",     "Advanced reasoning intelligence",
            ["REASONER","LOGIC-EXT"], ["ReasoningEngine","LogicChain"]),
        h(43, 8, "Creative Extension House",      "Creative generation intelligence",
            ["CREATOR","MUSE"], ["CreativeAI","Generative","Artistic"]),
        h(44, 8, "Analysis Extension House",      "Deep analytical intelligence",
            ["ANALYZER","INSIGHT"], ["DeepAnalysis","DataMining"]),
        h(45, 8, "Security Extension House",      "Security intelligence extension",
            ["SEC-INTEL","THREAT-AI"], ["ThreatIntel","SecurityAI"]),
        h(46, 8, "Workflow Intelligence House",   "Workflow automation intelligence",
            ["WORKFLOW-AI","AUTOMATE"], ["WorkflowEngine","Automation"]),

        // ── TIER 9: Protocol Tier Houses (47-49) ─────────────────────────
        h(47, 9, "Core Protocol House",           "Core protocol definitions and enforcement",
            ["PROTO-CORE","STANDARD"], ["CoreProtocol","Standards"]),
        h(48, 9, "Orchestration Protocol House",  "Orchestration protocol layer",
            ["PROTO-ORCH","CHOREOGRAPH"], ["Orchestration","Choreography"]),
        h(49, 9, "Verification Protocol House",   "Verification and attestation protocols",
            ["PROTO-VERIFY","ATTEST"], ["Verification","Attestation"]),

        // ── TIER 10: Sovereign Engine Houses (50-72) — Nova Series ──────
        h(50,  10, "Nova Cognos",    "NOV-001 — Cognitive engine",          ["NOV-001"], ["Cognition"]),
        h(51,  10, "Nova Lexis",     "NOV-002 — Lexical engine",           ["NOV-002"], ["Lexical"]),
        h(52,  10, "Nova Sensus",    "NOV-003 — Sensory engine",           ["NOV-003"], ["Sensory"]),
        h(53,  10, "Nova Ratio",     "NOV-004 — Rational engine",          ["NOV-004"], ["Rationality"]),
        h(54,  10, "Nova Memoria",   "NOV-005 — Memory engine",            ["NOV-005"], ["Memory"]),
        h(55,  10, "Nova Lingua",    "NOV-006 — Language engine",           ["NOV-006"], ["Language"]),
        h(56,  10, "Nova Codex",     "NOV-007 — Code engine",              ["NOV-007"], ["CodeGen"]),
        h(57,  10, "Nova Imago",     "NOV-008 — Image engine",             ["NOV-008"], ["ImageGen"]),
        h(58,  10, "Nova Sonus",     "NOV-009 — Sound engine",             ["NOV-009"], ["AudioGen"]),
        h(59,  10, "Nova Motus",     "NOV-010 — Motion engine",            ["NOV-010"], ["MotionGen"]),
        h(60,  10, "Nova Nexus",     "NOV-011 — Connection engine",        ["NOV-011"], ["Networking"]),
        h(61,  10, "Nova Custos",    "NOV-012 — Guardian engine",          ["NOV-012"], ["Guardian"]),
        h(62,  10, "Nova Faber",     "NOV-013 — Fabrication engine",       ["NOV-013"], ["Fabrication"]),
        h(63,  10, "Nova Medicus",   "NOV-014 — Medical engine",           ["NOV-014"], ["Medical"]),
        h(64,  10, "Nova Judex",     "NOV-015 — Judgment engine",          ["NOV-015"], ["Judgment"]),
        h(65,  10, "Nova Magister",  "NOV-016 — Teaching engine",          ["NOV-016"], ["Teaching"]),
        h(66,  10, "Nova Artifex",   "NOV-017 — Artisan engine",           ["NOV-017"], ["Artisan"]),
        h(67,  10, "Nova Nauta",     "NOV-018 — Navigation engine",        ["NOV-018"], ["Navigation"]),
        h(68,  10, "Nova Explorator","NOV-019 — Exploration engine",       ["NOV-019"], ["Exploration"]),
        h(69,  10, "Nova Geometra",  "NOV-020 — Geometry engine",          ["NOV-020"], ["Geometry"]),
        h(70,  10, "Nova Harmonia",  "NOV-021 — Harmony engine",           ["NOV-021"], ["Harmony"]),
        h(71,  10, "Nova Tempus",    "NOV-022 — Temporal engine",          ["NOV-022"], ["Temporal"]),
        h(72,  10, "Nova Visio",     "NOV-023 — Vision engine",            ["NOV-023"], ["Vision"]),

        // ── TIER 11: Fracture Category Houses (73-82) ────────────────────
        h(73, 11, "Markup Fracture House",         "HTML/XML markup fracture analysis",
            ["MARKUP-FRAC"], ["HTML","XML","Markup"]),
        h(74, 11, "Styling Fracture House",        "CSS/styling fracture analysis",
            ["STYLE-FRAC"], ["CSS","Styling","Layout"]),
        h(75, 11, "Framework Fracture House",      "Framework fracture analysis",
            ["FRAMEWORK-FRAC"], ["React","Vue","Angular","Svelte"]),
        h(76, 11, "State Fracture House",          "State management fracture analysis",
            ["STATE-FRAC"], ["Redux","MobX","StateManagement"]),
        h(77, 11, "Build Fracture House",          "Build tooling fracture analysis",
            ["BUILD-FRAC"], ["Webpack","Vite","Rollup","ESBuild"]),
        h(78, 11, "Testing Fracture House",        "Testing fracture analysis",
            ["TEST-FRAC"], ["Jest","Mocha","Cypress","Playwright"]),
        h(79, 11, "Graphics Fracture House",       "Graphics/WebGL fracture analysis",
            ["GRAPHICS-FRAC"], ["WebGL","Canvas","Three.js","GPU"]),
        h(80, 11, "Communication Fracture House",  "Communication protocol fracture analysis",
            ["COMM-FRAC"], ["WebSocket","gRPC","REST","GraphQL"]),
        h(81, 11, "Storage Fracture House",        "Storage fracture analysis",
            ["STORAGE-FRAC"], ["IndexedDB","LocalStorage","CacheAPI"]),
        h(82, 11, "Web API Fracture House",        "Web API fracture analysis",
            ["WEBAPI-FRAC"], ["ServiceWorker","WebRTC","WebAudio"]),

        // ── TIER 12: Frontend Intelligence Groups (83-92) ────────────────
        h(83,  12, "React Intelligence House",      "React ecosystem intelligence",
            ["REACT-AI"], ["React","JSX","Hooks"]),
        h(84,  12, "Vue Intelligence House",        "Vue ecosystem intelligence",
            ["VUE-AI"], ["Vue","Composition","Pinia"]),
        h(85,  12, "Angular Intelligence House",    "Angular ecosystem intelligence",
            ["ANGULAR-AI"], ["Angular","RxJS","NgModules"]),
        h(86,  12, "Svelte Intelligence House",     "Svelte ecosystem intelligence",
            ["SVELTE-AI"], ["Svelte","SvelteKit","Runes"]),
        h(87,  12, "Next.js Intelligence House",    "Next.js ecosystem intelligence",
            ["NEXTJS-AI"], ["Next.js","SSR","ISR"]),
        h(88,  12, "Remix Intelligence House",      "Remix ecosystem intelligence",
            ["REMIX-AI"], ["Remix","Loaders","Actions"]),
        h(89,  12, "Astro Intelligence House",      "Astro ecosystem intelligence",
            ["ASTRO-AI"], ["Astro","Islands","Hybrid"]),
        h(90,  12, "Solid Intelligence House",      "Solid.js ecosystem intelligence",
            ["SOLID-AI"], ["SolidJS","Signals","FineGrained"]),
        h(91,  12, "Qwik Intelligence House",       "Qwik ecosystem intelligence",
            ["QWIK-AI"], ["Qwik","Resumability","LazyLoad"]),
        h(92,  12, "WebComponent Intelligence House","Web Components intelligence",
            ["WEBCOMP-AI"], ["WebComponents","ShadowDOM","CustomElements"]),

        // ── TIER 13: Language AI Groups (93-102) ─────────────────────────
        h(93,  13, "TypeScript AI House",   "TypeScript language intelligence",
            ["TS-AI"], ["TypeScript","TSC","TypeSystem"]),
        h(94,  13, "Rust AI House",         "Rust language intelligence",
            ["RUST-AI"], ["Rust","Cargo","BorrowChecker"]),
        h(95,  13, "Python AI House",       "Python language intelligence",
            ["PYTHON-AI"], ["Python","Pip","CPython"]),
        h(96,  13, "Go AI House",           "Go language intelligence",
            ["GO-AI"], ["Go","Goroutines","Channels"]),
        h(97,  13, "Motoko AI House",       "Motoko language intelligence",
            ["MOTOKO-AI"], ["Motoko","ICP","Canisters"]),
        h(98,  13, "Solidity AI House",     "Solidity language intelligence",
            ["SOLIDITY-AI"], ["Solidity","EVM","SmartContracts"]),
        h(99,  13, "C++ AI House",          "C++ language intelligence",
            ["CPP-AI"], ["C++","LLVM","Templates"]),
        h(100, 13, "Java AI House",         "Java language intelligence",
            ["JAVA-AI"], ["Java","JVM","SpringBoot"]),
        h(101, 13, "Swift AI House",        "Swift language intelligence",
            ["SWIFT-AI"], ["Swift","SwiftUI","Combine"]),
        h(102, 13, "Zig AI House",          "Zig language intelligence",
            ["ZIG-AI"], ["Zig","Comptime","LLVM"]),

        // ── TIER 14: Native Nova AI Groups (103-112) ─────────────────────
        h(103, 14, "Nova iOS House",        "Native iOS intelligence",
            ["NOVA-IOS"], ["iOS","UIKit","CoreML"]),
        h(104, 14, "Nova Android House",    "Native Android intelligence",
            ["NOVA-ANDROID"], ["Android","Kotlin","Jetpack"]),
        h(105, 14, "Nova macOS House",      "Native macOS intelligence",
            ["NOVA-MACOS"], ["macOS","AppKit","Metal"]),
        h(106, 14, "Nova Windows House",    "Native Windows intelligence",
            ["NOVA-WINDOWS"], ["Windows","WinUI","DirectX"]),
        h(107, 14, "Nova Linux House",      "Native Linux intelligence",
            ["NOVA-LINUX"], ["Linux","Kernel","SystemD"]),
        h(108, 14, "Nova WASM House",       "WebAssembly native intelligence",
            ["NOVA-WASM"], ["WebAssembly","WASI","WasmEdge"]),
        h(109, 14, "Nova Embedded House",   "Embedded systems intelligence",
            ["NOVA-EMBEDDED"], ["Embedded","RTOS","ARM"]),
        h(110, 14, "Nova VR House",         "Virtual reality intelligence",
            ["NOVA-VR"], ["VR","OpenXR","Spatial"]),
        h(111, 14, "Nova AR House",         "Augmented reality intelligence",
            ["NOVA-AR"], ["AR","ARKit","ARCore"]),
        h(112, 14, "Nova Quantum House",    "Quantum computing intelligence",
            ["NOVA-QUANTUM"], ["Quantum","Qiskit","Cirq"]),

        // ── TIER 15: Phantom Blockchain House (113) ──────────────────────
        h(113, 15, "Phantom Blockchain House", "Phantom chain — sovereign blockchain layer",
            ["PHANTOM-CHAIN","GHOST-LEDGER","SPECTER-CONSENSUS"],
            ["PhantomChain","GhostProtocol","SovereignLedger"]),

        // ── TIER 16: Sovereign Element Canisters (114-125) ───────────────
        h(114, 16, "Gold Canister (AU)",      "Sovereign Gold element canister",
            ["AU-PROC"], ["Gold","AU","PreciousMetal"]),
        h(115, 16, "Silver Canister (AG)",    "Sovereign Silver element canister",
            ["AG-PROC"], ["Silver","AG","PreciousMetal"]),
        h(116, 16, "Crimson Canister (CR)",   "Sovereign Crimson element canister",
            ["CR-PROC"], ["Crimson","CR","RareElement"]),
        h(117, 16, "Iron Canister (FE)",      "Sovereign Iron element canister",
            ["FE-PROC"], ["Iron","FE","BaseMetal"]),
        h(118, 16, "Copper Canister (CU)",    "Sovereign Copper element canister",
            ["CU-PROC"], ["Copper","CU","Conductor"]),
        h(119, 16, "Platinum Canister (PT)",  "Sovereign Platinum element canister",
            ["PT-PROC"], ["Platinum","PT","Catalyst"]),
        h(120, 16, "Silicon Canister (SI)",   "Sovereign Silicon element canister",
            ["SI-PROC"], ["Silicon","SI","Semiconductor"]),
        h(121, 16, "Carbon Canister (C)",     "Sovereign Carbon element canister",
            ["C-PROC"], ["Carbon","C","LifeElement"]),
        h(122, 16, "Nitrogen Canister (N)",   "Sovereign Nitrogen element canister",
            ["N-PROC"], ["Nitrogen","N","Atmosphere"]),
        h(123, 16, "Oxygen Canister (O)",     "Sovereign Oxygen element canister",
            ["O-PROC"], ["Oxygen","O","Respiration"]),
        h(124, 16, "Hydrogen Canister (H)",   "Sovereign Hydrogen element canister",
            ["H-PROC"], ["Hydrogen","H","Primordial"]),
        h(125, 16, "Helium Canister (HE)",    "Sovereign Helium element canister",
            ["HE-PROC"], ["Helium","HE","Noble"]),

        // ── TIER 17: Call Market Surface Houses (126-128) ────────────────
        h(126, 17, "Primary Market Surface House",    "Primary call market surface",
            ["PRIMARY-MKT"], ["PrimaryMarket","Issuance"]),
        h(127, 17, "Secondary Market Surface House",  "Secondary call market surface",
            ["SECONDARY-MKT"], ["SecondaryMarket","Trading"]),
        h(128, 17, "Derivatives Market Surface House","Derivatives call market surface",
            ["DERIV-MKT"], ["Derivatives","Options","Futures"]),

        // ── TIER 18: Call Category Houses (129-136) ──────────────────────
        h(129, 18, "Voice Call House",        "Voice call category processing",
            ["VOICE-CALL"], ["VoIP","Speech","Audio"]),
        h(130, 18, "Data Call House",         "Data call category processing",
            ["DATA-CALL"], ["DataTransfer","API","Streaming"]),
        h(131, 18, "Video Call House",        "Video call category processing",
            ["VIDEO-CALL"], ["VideoStream","WebRTC","Codec"]),
        h(132, 18, "AI Call House",           "AI inference call processing",
            ["AI-CALL"], ["Inference","ModelServe","Batch"]),
        h(133, 18, "Smart Contract Call House","Smart contract call processing",
            ["CONTRACT-CALL"], ["SmartContract","OnChain","Execution"]),
        h(134, 18, "IoT Call House",          "IoT device call processing",
            ["IOT-CALL"], ["IoT","MQTT","EdgeDevice"]),
        h(135, 18, "Emergency Call House",    "Emergency call routing",
            ["EMERGENCY-CALL"], ["Emergency","Priority","FailSafe"]),
        h(136, 18, "Sovereign Call House",    "Sovereign inter-house calls",
            ["SOV-CALL"], ["InterHouse","Sovereign","Privileged"]),

        // ── TIER 19: Generative Platform Houses (137-140) ────────────────
        h(137, 19, "Text Generation Platform House",  "Generative text platform",
            ["TEXT-GEN"], ["LLM","TextGeneration","Prompt"]),
        h(138, 19, "Image Generation Platform House", "Generative image platform",
            ["IMAGE-GEN"], ["Diffusion","GAN","ImageSynth"]),
        h(139, 19, "Audio Generation Platform House", "Generative audio platform",
            ["AUDIO-GEN"], ["TTS","MusicGen","AudioSynth"]),
        h(140, 19, "Video Generation Platform House", "Generative video platform",
            ["VIDEO-GEN"], ["VideoSynth","Animation","Rendering"]),

        // ── TIER 20: Platform Delivery Houses (141-144) ──────────────────
        h(141, 20, "Edge Delivery House",     "Edge computing delivery platform",
            ["EDGE-DELIVER"], ["CDN","Edge","LowLatency"]),
        h(142, 20, "Cloud Delivery House",    "Cloud computing delivery platform",
            ["CLOUD-DELIVER"], ["Cloud","Serverless","Container"]),
        h(143, 20, "P2P Delivery House",      "Peer-to-peer delivery platform",
            ["P2P-DELIVER"], ["P2P","Mesh","Distributed"]),
        h(144, 20, "Satellite Delivery House","Satellite delivery platform",
            ["SAT-DELIVER"], ["Satellite","LEO","GlobalCoverage"]),

        // ── TIER 21: Architectural Law Domain Houses (145-152) ───────────
        h(145, 21, "Law of Sovereignty House",         "Sovereignty law domain",
            ["SOV-LAW"], ["SovereigntyLaw","Autonomy"]),
        h(146, 21, "Law of Immutability House",        "Immutability law domain",
            ["IMMUT-LAW"], ["Immutability","Permanence"]),
        h(147, 21, "Law of Transparency House",        "Transparency law domain",
            ["TRANS-LAW"], ["Transparency","OpenAudit"]),
        h(148, 21, "Law of Interoperability House",    "Interoperability law domain",
            ["INTEROP-LAW"], ["Interoperability","Standards"]),
        h(149, 21, "Law of Privacy House",             "Privacy law domain",
            ["PRIV-LAW"], ["Privacy","DataProtection"]),
        h(150, 21, "Law of Consent House",             "Consent law domain",
            ["CONSENT-LAW"], ["Consent","UserAgency"]),
        h(151, 21, "Law of Evolution House",           "Evolution law domain",
            ["EVOL-LAW"], ["Evolution","Adaptation"]),
        h(152, 21, "Law of Accountability House",      "Accountability law domain",
            ["ACCOUNT-LAW"], ["Accountability","AuditTrail"]),

        // ── TIER 22: Encryption Tier Houses (153-157) ────────────────────
        h(153, 22, "Symmetric Encryption House",   "Symmetric key encryption tier",
            ["SYM-ENC"], ["AES","ChaCha20","Symmetric"]),
        h(154, 22, "Asymmetric Encryption House",  "Asymmetric key encryption tier",
            ["ASYM-ENC"], ["RSA","ECC","Asymmetric"]),
        h(155, 22, "Homomorphic Encryption House", "Homomorphic encryption tier",
            ["HOMO-ENC"], ["FHE","CKKS","Homomorphic"]),
        h(156, 22, "Quantum-Resistant Encryption House","Post-quantum encryption tier",
            ["PQC-ENC"], ["Lattice","NTRU","PostQuantum"]),
        h(157, 22, "Zero-Knowledge Encryption House",  "Zero-knowledge proof tier",
            ["ZK-ENC"], ["ZKP","SNARK","STARK"]),

        // ── TIER 23: Contract Type Houses (158-162) ──────────────────────
        h(158, 23, "Service Contract House",     "Service-level agreement contracts",
            ["SVC-CONTRACT"], ["SLA","ServiceAgreement"]),
        h(159, 23, "Data Contract House",        "Data access and sharing contracts",
            ["DATA-CONTRACT"], ["DataSharing","AccessControl"]),
        h(160, 23, "Compute Contract House",     "Compute resource allocation contracts",
            ["COMPUTE-CONTRACT"], ["ComputeAlloc","ResourceMgmt"]),
        h(161, 23, "Identity Contract House",    "Identity verification contracts",
            ["ID-CONTRACT"], ["Identity","DID","Verification"]),
        h(162, 23, "Governance Contract House",  "Governance and voting contracts",
            ["GOV-CONTRACT"], ["Governance","Voting","DAO"]),

        // ── TIER 24: Fracture Analysis Model Houses (163-166) ────────────
        h(163, 24, "Static Analysis Model House",  "Static code fracture analysis",
            ["STATIC-FRAC"], ["StaticAnalysis","AST","Lint"]),
        h(164, 24, "Dynamic Analysis Model House", "Dynamic runtime fracture analysis",
            ["DYNAMIC-FRAC"], ["DynamicAnalysis","Profiling","Trace"]),
        h(165, 24, "Dependency Analysis Model House","Dependency fracture analysis",
            ["DEP-FRAC"], ["DependencyGraph","SupplyChain","SBOM"]),
        h(166, 24, "Security Analysis Model House", "Security fracture analysis",
            ["SEC-FRAC"], ["VulnScan","PenTest","SAST"]),

        // ── TIER 25: Workspace & Project Houses (167-172) ────────────────
        h(167, 25, "Workspace Registry House",     "Central workspace registry",
            ["WORKSPACE-REG"], ["Registry","Discovery","Catalog"]),
        h(168, 25, "Project Scaffold House",       "Project scaffolding and templates",
            ["SCAFFOLD"], ["Templates","Generators","Boilerplate"]),
        h(169, 25, "Version Control House",        "Version control intelligence",
            ["VCS-AI"], ["Git","Branching","MergeStrategy"]),
        h(170, 25, "Documentation House",          "Documentation generation and management",
            ["DOC-AI"], ["DocGen","APIDoc","KnowledgeBase"]),
        h(171, 25, "CI/CD Pipeline House",         "Continuous integration and delivery",
            ["CICD-AI"], ["Pipeline","Build","Deploy"]),
        h(172, 25, "Environment House",            "Environment management and configuration",
            ["ENV-AI"], ["EnvConfig","Secrets","Infrastructure"]),

        // ── TIER 26: Intelligence Tier Houses (173-176) ──────────────────
        h(173, 26, "Narrow Intelligence House",    "Task-specific narrow AI tier",
            ["NARROW-AI"], ["NarrowAI","TaskSpecific","Specialist"]),
        h(174, 26, "General Intelligence House",   "General-purpose AGI tier",
            ["GENERAL-AI"], ["AGI","GeneralPurpose","Adaptive"]),
        h(175, 26, "Super Intelligence House",     "Superintelligent reasoning tier",
            ["SUPER-AI"], ["ASI","Superintelligence","Transcendent"]),
        h(176, 26, "Collective Intelligence House","Swarm and collective intelligence tier",
            ["COLLECTIVE-AI"], ["SwarmAI","Collective","Emergent"]),

        // ── TIER 27: Stealth Level Houses (177-181) ──────────────────────
        h(177, 27, "Stealth Level 0 — Visible House",    "Fully visible and public operations",
            ["STEALTH-L0"], ["Public","Visible","OpenAccess"]),
        h(178, 27, "Stealth Level 1 — Obscured House",   "Partially obscured operations",
            ["STEALTH-L1"], ["Obscured","LimitedAccess","Filtered"]),
        h(179, 27, "Stealth Level 2 — Concealed House",  "Concealed covert operations",
            ["STEALTH-L2"], ["Concealed","Covert","Encrypted"]),
        h(180, 27, "Stealth Level 3 — Phantom House",    "Phantom-level stealth operations",
            ["STEALTH-L3"], ["Phantom","Undetectable","GhostOps"]),
        h(181, 27, "Stealth Level 4 — Sovereign Ghost House","Sovereign ghost — beyond detection",
            ["STEALTH-L4"], ["SovereignGhost","BeyondDetection","Absolute"]),
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: PUBLIC QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func summary() : {
        totalHouses : Nat; totalTiers : Nat;
        totalAI : Nat; totalAGI : Nat;
        totalSovereign : Nat; totalAlwaysOn : Nat;
    } {
        var ai  : Nat = 0;
        var agi : Nat = 0;
        var sov : Nat = 0;
        var aon : Nat = 0;
        for (house in HOUSES.vals()) {
            if (house.isAI)        { ai  += 1 };
            if (house.isAGI)       { agi += 1 };
            if (house.isSovereign) { sov += 1 };
            if (house.isAlwaysOn)  { aon += 1 };
        };
        {
            totalHouses    = HOUSES.size();
            totalTiers     = TIERS.size();
            totalAI        = ai;
            totalAGI       = agi;
            totalSovereign = sov;
            totalAlwaysOn  = aon;
        }
    };

    public func allTiers() : [TierInfo] { TIERS };

    public func housesInTier(tier : Nat) : [SovereignHouse] {
        let buf = Buffer.Buffer<SovereignHouse>(16);
        for (house in HOUSES.vals()) {
            if (house.tier == tier) { buf.add(house) };
        };
        Buffer.toArray(buf)
    };

    public func getHouse(id : Nat) : ?SovereignHouse {
        if (id >= 1 and id <= HOUSES.size()) {
            ?HOUSES[id - 1]
        } else {
            null
        }
    };

    public func allHouses() : [SovereignHouse] { HOUSES };

    public func renderManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════════════════╗\n";
        m #= "║  SOVEREIGN HOUSES 181 — CIVILIZATION ARCHITECTURE MANIFEST         ║\n";
        m #= "║  27 Tiers · 181 Houses · All Sovereign · All Always-On             ║\n";
        m #= "║  Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX  ║\n";
        m #= "╠══════════════════════════════════════════════════════════════════════╣\n";
        for (t in TIERS.vals()) {
            m #= "║  Tier " # Nat.toText(t.tier) # ": " # t.name #
                 " (" # Nat.toText(t.houseCount) # " houses, #" #
                 Nat.toText(t.startId) # "-#" # Nat.toText(t.endId) # ")\n";
        };
        m #= "╠══════════════════════════════════════════════════════════════════════╣\n";
        m #= "║  Total Houses: " # Nat.toText(HOUSES.size()) #
             " | Total Tiers: " # Nat.toText(TIERS.size()) # "\n";
        m #= "╚══════════════════════════════════════════════════════════════════════╝\n";
        m
    };
};
