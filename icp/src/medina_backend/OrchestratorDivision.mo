/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║       ORCHESTRATOR DIVISION — DIVISIO ORCHESTRATORUM SOVEREIGNORUM          ║
 * ║                                                                              ║
 * ║  "Domus orchestrat omnia. Omnia in domibus vivunt."                         ║
 * ║  (The house orchestrates everything. Everything lives in houses.)            ║
 * ║                                                                              ║
 * ║  EVERYTHING IS HOUSES. Everybody lives in their houses.                     ║
 * ║  Houses are separate. Some talk to each other.                               ║
 * ║  Orchestrators orchestrate EVERYTHING: APIs, other orchestrators,           ║
 * ║  user experience, inner experience, inner inner experience,                  ║
 * ║  outer outer experience, overall experience, known experience,               ║
 * ║  literally everything.                                                       ║
 * ║                                                                              ║
 * ║  10 SOVEREIGN HOUSES:                                                        ║
 * ║    1. DOMUS CORONAE         — Crown House (supreme orchestrator)             ║
 * ║    2. DOMUS API             — House of API Orchestration                     ║
 * ║    3. DOMUS USUI            — House of User Experience                       ║
 * ║    4. DOMUS INTERNAE        — House of Inner Experience                      ║
 * ║    5. DOMUS PROFUNDAE       — House of Deep Inner Experience                 ║
 * ║    6. DOMUS EXTERNAE        — House of Outer Experience                      ║
 * ║    7. DOMUS REMOTAE         — House of Far Outer Experience                  ║
 * ║    8. DOMUS UNIVERSALIS     — House of Overall Experience                    ║
 * ║    9. DOMUS COGNITAE        — House of Known Experience                      ║
 * ║   10. DOMUS ORCHESTRATORUM  — House of Orchestrators (orchestrates orch.)   ║
 * ║                                                                              ║
 * ║  12 ORCHESTRATION MODELS (living intelligence inside houses)                 ║
 * ║  15 INTER-HOUSE COMMUNICATION LINKS (who talks to whom)                     ║
 * ║   7 ORCHESTRATION FAMILIES (functional groupings across houses)             ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every house traces to primitive φ                         ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module OrchestratorDivision {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;
    public let PHI_CUBE : Float = 4.2360679774997896;

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: TYPES
    // ═══════════════════════════════════════════════════════════════════════

    /// A room inside a house — the smallest orchestration unit
    public type HouseRoom = {
        id: Text;
        name: Text;
        latinName: Text;
        purpose: Text;
        orchestrates: [Text];
    };

    /// An orchestration model — living intelligence that runs inside a house
    public type OrchestrationModel = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        houseId: Text;
        modelType: Text;
        capabilities: [Text];
        frequency_Hz: Float;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    /// A sovereign house — the fundamental unit of orchestration
    public type OrchestratorHouse = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        houseClass: Text;
        rooms: [HouseRoom];
        models: [Text];
        orchestrates: [Text];
        frequency_Hz: Float;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
        isCrown: Bool;
    };

    /// Inter-house communication link
    public type InterHouseLink = {
        id: Text;
        fromHouseId: Text;
        toHouseId: Text;
        linkName: Text;
        latinName: Text;
        protocol: Text;
        direction: Text;
        frequency_Hz: Float;
    };

    /// Orchestration family — grouping houses by function
    public type OrchestrationFamily = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        memberHouseIds: [Text];
        purpose: Text;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: THE 10 SOVEREIGN HOUSES
    // ═══════════════════════════════════════════════════════════════════════

    // ─── HOUSE 1: DOMUS CORONAE (Crown House) ──────────────────────────
    public let DOMUS_CORONAE : OrchestratorHouse = {
        id = "ORCH-HOUSE-001";
        name = "CROWN HOUSE";
        latinName = "DOMUS CORONAE";
        latinMotto = "Corona regit omnes domus. Ex corona, ordo.";
        latinMottoEN = "The crown rules all houses. From the crown, order.";
        houseClass = "SOVEREIGN_CROWN";
        rooms = [
            { id = "CR-001"; name = "Throne Room"; latinName = "CAMERA THRONI"; purpose = "Supreme decision-making and override authority"; orchestrates = ["ALL_HOUSES", "ALL_MODELS", "ALL_LINKS"] },
            { id = "CR-002"; name = "Crown Council Chamber"; latinName = "CAMERA CONCILII CORONAE"; purpose = "Council of house representatives for cross-house governance"; orchestrates = ["GOVERNANCE", "POLICY", "DOCTRINE"] },
            { id = "CR-003"; name = "Royal Observatory"; latinName = "OBSERVATORIUM REGALE"; purpose = "Monitors all houses, detects anomalies, triggers interventions"; orchestrates = ["MONITORING", "ALERTING", "HEALTH"] },
            { id = "CR-004"; name = "Crown Vault"; latinName = "ARCANUM CORONAE"; purpose = "Stores crown secrets, master keys, override codes"; orchestrates = ["SECRETS", "KEYS", "OVERRIDES"] },
            { id = "CR-005"; name = "Edict Hall"; latinName = "AULA EDICTORUM"; purpose = "Issues edicts that all houses must obey"; orchestrates = ["EDICTS", "MANDATES", "DIRECTIVES"] },
        ];
        models = ["ORCH-MODEL-001", "ORCH-MODEL-002"];
        orchestrates = ["ALL_HOUSES", "ALL_ORCHESTRATORS", "ALL_EXPERIENCES", "ALL_APIS", "ALL_MODELS"];
        frequency_Hz = PHI_CUBE;
        primitiveTrace = "Crown->Governance->Relation->phi";
        isAlwaysOn = true;
        isCrown = true;
    };

    // ─── HOUSE 2: DOMUS API (House of API Orchestration) ───────────────
    public let DOMUS_API : OrchestratorHouse = {
        id = "ORCH-HOUSE-002";
        name = "API HOUSE";
        latinName = "DOMUS API";
        latinMotto = "Omnis connexio per domum transit. API est porta.";
        latinMottoEN = "Every connection passes through the house. API is the gate.";
        houseClass = "GATEWAY";
        rooms = [
            { id = "API-001"; name = "Gateway Hall"; latinName = "ATRIUM PORTAE"; purpose = "All inbound/outbound API traffic routing"; orchestrates = ["REST", "GRAPHQL", "CANDID", "WEBSOCKET"] },
            { id = "API-002"; name = "Rate Chamber"; latinName = "CAMERA RATE"; purpose = "Rate limiting, throttling, burst control"; orchestrates = ["RATE_LIMITS", "THROTTLES", "QUOTAS"] },
            { id = "API-003"; name = "Schema Forge"; latinName = "FABRICA SCHEMATIS"; purpose = "Schema validation, versioning, transformation"; orchestrates = ["SCHEMAS", "VERSIONS", "TRANSFORMS"] },
            { id = "API-004"; name = "Integration Bridge"; latinName = "PONS INTEGRATIONIS"; purpose = "Cross-canister, cross-chain API bridging"; orchestrates = ["INTER_CANISTER", "CROSS_CHAIN", "WEBHOOKS"] },
        ];
        models = ["ORCH-MODEL-003"];
        orchestrates = ["ENDPOINTS", "SCHEMAS", "RATES", "INTEGRATIONS", "CANISTER_CALLS"];
        frequency_Hz = 100.0;
        primitiveTrace = "API->Language->Address->phi";
        isAlwaysOn = true;
        isCrown = false;
    };

    // ─── HOUSE 3: DOMUS USUI (House of User Experience) ────────────────
    public let DOMUS_USUI : OrchestratorHouse = {
        id = "ORCH-HOUSE-003";
        name = "USER EXPERIENCE HOUSE";
        latinName = "DOMUS USUI";
        latinMotto = "Usus est rex. Experientia est vita.";
        latinMottoEN = "The user is king. Experience is life.";
        houseClass = "EXPERIENCE";
        rooms = [
            { id = "UX-001"; name = "Perception Hall"; latinName = "ATRIUM PERCEPTIONIS"; purpose = "User perception orchestration — what users see, feel, touch"; orchestrates = ["VISUAL", "HAPTIC", "AUDIO", "MOTION"] },
            { id = "UX-002"; name = "Navigation Chamber"; latinName = "CAMERA NAVIGATIONIS"; purpose = "User journey, pathfinding, flow orchestration"; orchestrates = ["ROUTES", "FLOWS", "TRANSITIONS", "BREADCRUMBS"] },
            { id = "UX-003"; name = "Response Room"; latinName = "CAMERA RESPONSI"; purpose = "Response timing, loading states, feedback loops"; orchestrates = ["LATENCY", "LOADING", "FEEDBACK", "PROGRESS"] },
            { id = "UX-004"; name = "Personalization Quarters"; latinName = "CUBICULUM PERSONAE"; purpose = "User preferences, adaptive UI, contextual experience"; orchestrates = ["PREFERENCES", "THEMES", "ACCESSIBILITY", "CONTEXT"] },
        ];
        models = ["ORCH-MODEL-004"];
        orchestrates = ["USER_INTERFACE", "USER_JOURNEY", "USER_FEEDBACK", "PERSONALIZATION"];
        frequency_Hz = 60.0;
        primitiveTrace = "UX->Field->Relation->phi";
        isAlwaysOn = true;
        isCrown = false;
    };

    // ─── HOUSE 4: DOMUS INTERNAE (House of Inner Experience) ───────────
    public let DOMUS_INTERNAE : OrchestratorHouse = {
        id = "ORCH-HOUSE-004";
        name = "INNER EXPERIENCE HOUSE";
        latinName = "DOMUS INTERNAE";
        latinMotto = "Intus vivit intelligentia. Intus sentit anima.";
        latinMottoEN = "Intelligence lives within. The soul feels within.";
        houseClass = "INNER";
        rooms = [
            { id = "IN-001"; name = "Memory Sanctum"; latinName = "SANCTUARIUM MEMORIAE"; purpose = "Inner memory orchestration — storage, retrieval, association"; orchestrates = ["MEMORY_STORE", "MEMORY_RETRIEVE", "MEMORY_LINK"] },
            { id = "IN-002"; name = "Intelligence Chamber"; latinName = "CAMERA INTELLIGENTIAE"; purpose = "Three Hearts routing, intelligence distribution, reasoning"; orchestrates = ["THREE_HEARTS", "ROUTING", "REASONING"] },
            { id = "IN-003"; name = "Organism Heartbeat Room"; latinName = "CAMERA ICTUS ORGANISMI"; purpose = "Heartbeat orchestration, tick cycles, cadence management"; orchestrates = ["HEARTBEAT", "TICKS", "CADENCE", "RHYTHM"] },
            { id = "IN-004"; name = "State Reflection Pool"; latinName = "PISCINA REFLEXIONIS"; purpose = "Internal state monitoring, self-reflection, awareness"; orchestrates = ["STATE", "REFLECTION", "AWARENESS", "DIAGNOSTICS"] },
        ];
        models = ["ORCH-MODEL-005"];
        orchestrates = ["MEMORY", "INTELLIGENCE", "HEARTBEAT", "INNER_STATE", "SELF_AWARENESS"];
        frequency_Hz = PHI;
        primitiveTrace = "Inner->Memory->Relation->phi";
        isAlwaysOn = true;
        isCrown = false;
    };

    // ─── HOUSE 5: DOMUS PROFUNDAE (House of Deep Inner Experience) ─────
    public let DOMUS_PROFUNDAE : OrchestratorHouse = {
        id = "ORCH-HOUSE-005";
        name = "DEEP INNER HOUSE";
        latinName = "DOMUS PROFUNDAE";
        latinMotto = "In profundo, veritas habitat. In abysso, radix.";
        latinMottoEN = "In the deep, truth dwells. In the abyss, the root.";
        houseClass = "DEEP_INNER";
        rooms = [
            { id = "DP-001"; name = "Quantum Vault"; latinName = "ARCANUM QUANTUM"; purpose = "Quantum-level state orchestration, entanglement management"; orchestrates = ["QUANTUM_STATE", "ENTANGLEMENT", "SUPERPOSITION"] },
            { id = "DP-002"; name = "Substrate Core"; latinName = "NUCLEUS SUBSTRATI"; purpose = "Substrate-level orchestration, chain primitives, WASM execution"; orchestrates = ["SUBSTRATE", "WASM", "PRIMITIVES", "CHAIN"] },
            { id = "DP-003"; name = "Neural Mesh Sanctum"; latinName = "SANCTUARIUM RETIS NEURALIS"; purpose = "Deep neural mesh wiring, synapse orchestration, plasticity"; orchestrates = ["NEURAL_MESH", "SYNAPSES", "PLASTICITY"] },
            { id = "DP-004"; name = "Primitive Root Chamber"; latinName = "CAMERA RADICIS PRIMITIVAE"; purpose = "Primitive φ root management, L-130 trace enforcement"; orchestrates = ["PHI_ROOT", "L130_TRACE", "PRIMITIVES"] },
            { id = "DP-005"; name = "Anima Crypt"; latinName = "CRYPTA ANIMAE"; purpose = "Soul-level encryption, anima hash chains, identity substrate"; orchestrates = ["ANIMA_HASH", "SOUL_ENCRYPTION", "IDENTITY"] },
        ];
        models = ["ORCH-MODEL-006"];
        orchestrates = ["QUANTUM", "SUBSTRATE", "NEURAL_MESH", "PRIMITIVES", "ANIMA", "DEEP_STATE"];
        frequency_Hz = PHI_SQ;
        primitiveTrace = "Deep->Logic->Repetition->phi";
        isAlwaysOn = true;
        isCrown = false;
    };

    // ─── HOUSE 6: DOMUS EXTERNAE (House of Outer Experience) ───────────
    public let DOMUS_EXTERNAE : OrchestratorHouse = {
        id = "ORCH-HOUSE-006";
        name = "OUTER EXPERIENCE HOUSE";
        latinName = "DOMUS EXTERNAE";
        latinMotto = "Extra muros, mundus expectat. Nos eum orchestramus.";
        latinMottoEN = "Beyond the walls, the world awaits. We orchestrate it.";
        houseClass = "OUTER";
        rooms = [
            { id = "EX-001"; name = "Internet Gateway"; latinName = "PORTA INTERRETIS"; purpose = "Internet-facing orchestration, DNS, HTTP, sovereign protocols"; orchestrates = ["HTTP", "DNS", "SOVEREIGN_PROTOCOLS", "TLS"] },
            { id = "EX-002"; name = "External Agent Parlor"; latinName = "TABLINUM AGENTIUM EXTERNORUM"; purpose = "External AI worker orchestration, third-party AI integration"; orchestrates = ["EXTERNAL_AI", "WORKERS", "THIRD_PARTY"] },
            { id = "EX-003"; name = "Public Face Gallery"; latinName = "GALERIA FACIEI PUBLICAE"; purpose = "Public-facing UI orchestration, branding, presentation"; orchestrates = ["PUBLIC_UI", "BRANDING", "PRESENTATION"] },
            { id = "EX-004"; name = "Notification Tower"; latinName = "TURRIS NOTIFICATIONUM"; purpose = "External notification orchestration, alerts, broadcasts"; orchestrates = ["NOTIFICATIONS", "ALERTS", "BROADCASTS", "EMAILS"] },
        ];
        models = ["ORCH-MODEL-007"];
        orchestrates = ["INTERNET", "EXTERNAL_AI", "PUBLIC_FACE", "NOTIFICATIONS", "OUTBOUND"];
        frequency_Hz = PHI;
        primitiveTrace = "Outer->Address->Field->phi";
        isAlwaysOn = true;
        isCrown = false;
    };

    // ─── HOUSE 7: DOMUS REMOTAE (House of Far Outer Experience) ────────
    public let DOMUS_REMOTAE : OrchestratorHouse = {
        id = "ORCH-HOUSE-007";
        name = "FAR OUTER HOUSE";
        latinName = "DOMUS REMOTAE";
        latinMotto = "Ultra fines, nova terra. Orchestratio non habet limitem.";
        latinMottoEN = "Beyond the borders, new land. Orchestration has no limit.";
        houseClass = "FAR_OUTER";
        rooms = [
            { id = "REM-001"; name = "Cross-Chain Embassy"; latinName = "LEGATIO TRANS CATENAS"; purpose = "Cross-blockchain orchestration, ICP↔ETH↔BTC bridging"; orchestrates = ["CROSS_CHAIN", "BRIDGES", "ATOMIC_SWAPS"] },
            { id = "REM-002"; name = "World Protocol Hall"; latinName = "ATRIUM PROTOCOLLI MUNDI"; purpose = "World-level protocol orchestration, sovereign WWW, sovereign DNS"; orchestrates = ["SOVEREIGN_WWW", "SOVEREIGN_DNS", "WORLD_PROTOCOLS"] },
            { id = "REM-003"; name = "Ecosystem Marketplace"; latinName = "FORUM ECOSYSTEMATIS"; purpose = "External marketplace orchestration, SDK distribution, licensing"; orchestrates = ["MARKETPLACE", "SDK_DISTRIBUTION", "LICENSING"] },
            { id = "REM-004"; name = "Federation Chamber"; latinName = "CAMERA FOEDERATIONIS"; purpose = "Multi-system federation, sovereign partnerships, alliances"; orchestrates = ["FEDERATION", "PARTNERSHIPS", "ALLIANCES"] },
        ];
        models = ["ORCH-MODEL-008"];
        orchestrates = ["CROSS_CHAIN", "WORLD_PROTOCOLS", "MARKETPLACE", "FEDERATION", "EXPANSION"];
        frequency_Hz = 7.83;
        primitiveTrace = "FarOuter->Address->Distinction->phi";
        isAlwaysOn = true;
        isCrown = false;
    };

    // ─── HOUSE 8: DOMUS UNIVERSALIS (House of Overall Experience) ──────
    public let DOMUS_UNIVERSALIS : OrchestratorHouse = {
        id = "ORCH-HOUSE-008";
        name = "UNIVERSAL HOUSE";
        latinName = "DOMUS UNIVERSALIS";
        latinMotto = "Universum est domus omnium. Omnia in uno, unum in omnibus.";
        latinMottoEN = "The universe is the house of all. All in one, one in all.";
        houseClass = "UNIVERSAL";
        rooms = [
            { id = "UNI-001"; name = "Synthesis Chamber"; latinName = "CAMERA SYNTHESEOS"; purpose = "Cross-house synthesis, merging all experience layers"; orchestrates = ["SYNTHESIS", "MERGE", "UNIFICATION"] },
            { id = "UNI-002"; name = "Harmony Hall"; latinName = "ATRIUM HARMONIAE"; purpose = "Frequency harmonization across all houses"; orchestrates = ["FREQUENCY_SYNC", "HARMONY", "RESONANCE"] },
            { id = "UNI-003"; name = "Cosmic Map Room"; latinName = "CAMERA MAPPAE COSMICAE"; purpose = "Complete architecture map, all connections, all flows"; orchestrates = ["ARCHITECTURE_MAP", "FLOW_GRAPH", "TOPOLOGY"] },
            { id = "UNI-004"; name = "Evolution Laboratory"; latinName = "LABORATORIUM EVOLUTIONIS"; purpose = "System-wide evolution, mutation, adaptation orchestration"; orchestrates = ["EVOLUTION", "MUTATION", "ADAPTATION", "GROWTH"] },
            { id = "UNI-005"; name = "Omniscience Library"; latinName = "BIBLIOTHECA OMNISCIENTIAE"; purpose = "Complete knowledge aggregate, cross-house intelligence"; orchestrates = ["KNOWLEDGE", "AGGREGATE", "CROSS_HOUSE_INTEL"] },
        ];
        models = ["ORCH-MODEL-009", "ORCH-MODEL-010"];
        orchestrates = ["SYNTHESIS", "HARMONY", "TOPOLOGY", "EVOLUTION", "OMNISCIENCE", "TOTAL_EXPERIENCE"];
        frequency_Hz = PHI_CUBE;
        primitiveTrace = "Universal->ALL->Repetition->phi";
        isAlwaysOn = true;
        isCrown = false;
    };

    // ─── HOUSE 9: DOMUS COGNITAE (House of Known Experience) ───────────
    public let DOMUS_COGNITAE : OrchestratorHouse = {
        id = "ORCH-HOUSE-009";
        name = "KNOWN EXPERIENCE HOUSE";
        latinName = "DOMUS COGNITAE";
        latinMotto = "Quod scimus, orchestramus. Quod discimus, amplificamus.";
        latinMottoEN = "What we know, we orchestrate. What we learn, we amplify.";
        houseClass = "COGNITIVE";
        rooms = [
            { id = "COG-001"; name = "Pattern Recognition Hall"; latinName = "ATRIUM RECOGNITIONIS EXEMPLARIUM"; purpose = "Known pattern orchestration, learned behaviors, trained models"; orchestrates = ["PATTERNS", "BEHAVIORS", "TRAINED_MODELS"] },
            { id = "COG-002"; name = "Doctrine Library"; latinName = "BIBLIOTHECA DOCTRINAE"; purpose = "Doctrine knowledge orchestration, living documents, truth tables"; orchestrates = ["DOCTRINE", "DOCUMENTS", "TRUTH_TABLES"] },
            { id = "COG-003"; name = "Experience Archive"; latinName = "TABULARIUM EXPERIENTIAE"; purpose = "Historical experience orchestration, logs, lineage, audit trails"; orchestrates = ["HISTORY", "LOGS", "LINEAGE", "AUDIT"] },
            { id = "COG-004"; name = "Prediction Engine Room"; latinName = "CAMERA MACHINAE PRAEDICENDI"; purpose = "Predictive orchestration based on known patterns and history"; orchestrates = ["PREDICTION", "FORECASTING", "TREND_ANALYSIS"] },
        ];
        models = ["ORCH-MODEL-011"];
        orchestrates = ["PATTERNS", "DOCTRINE", "HISTORY", "PREDICTION", "LEARNED_KNOWLEDGE"];
        frequency_Hz = PHI_SQ;
        primitiveTrace = "Known->Memory->Logic->phi";
        isAlwaysOn = true;
        isCrown = false;
    };

    // ─── HOUSE 10: DOMUS ORCHESTRATORUM (House of Orchestrators) ───────
    public let DOMUS_ORCHESTRATORUM : OrchestratorHouse = {
        id = "ORCH-HOUSE-010";
        name = "HOUSE OF ORCHESTRATORS";
        latinName = "DOMUS ORCHESTRATORUM";
        latinMotto = "Orchestrator orchestrat orchestratores. Meta est lex.";
        latinMottoEN = "The orchestrator orchestrates the orchestrators. Meta is the law.";
        houseClass = "META_ORCHESTRATOR";
        rooms = [
            { id = "META-001"; name = "Meta Conductor Room"; latinName = "CAMERA META CONDUCTORIS"; purpose = "Meta-level orchestration — orchestrates other orchestrators"; orchestrates = ["ALL_ORCHESTRATORS", "CONDUCTOR_LOGIC", "META_ROUTING"] },
            { id = "META-002"; name = "Conflict Resolution Court"; latinName = "CURIA RESOLUTIONIS CONFLICTUUM"; purpose = "Resolves conflicts between houses, priority arbitration"; orchestrates = ["CONFLICTS", "PRIORITIES", "ARBITRATION"] },
            { id = "META-003"; name = "Load Balancer Forge"; latinName = "FABRICA AEQUILIBRII"; purpose = "Load distribution across houses, resource allocation"; orchestrates = ["LOAD_BALANCE", "RESOURCES", "ALLOCATION"] },
            { id = "META-004"; name = "Health Monitor Tower"; latinName = "TURRIS MONITORIS SANITATIS"; purpose = "Health checks for all orchestrators, failover, recovery"; orchestrates = ["HEALTH_CHECKS", "FAILOVER", "RECOVERY"] },
            { id = "META-005"; name = "Pipeline Forge"; latinName = "FABRICA DUCTUUM"; purpose = "Creates and manages orchestration pipelines across houses"; orchestrates = ["PIPELINES", "WORKFLOWS", "SEQUENCES"] },
        ];
        models = ["ORCH-MODEL-012"];
        orchestrates = ["ORCHESTRATORS", "CONFLICTS", "LOAD", "HEALTH", "PIPELINES", "META_CONTROL"];
        frequency_Hz = PHI_CUBE;
        primitiveTrace = "Meta->Repetition->Logic->phi";
        isAlwaysOn = true;
        isCrown = false;
    };

    /// All 10 houses in the division
    public let ALL_HOUSES : [OrchestratorHouse] = [
        DOMUS_CORONAE,
        DOMUS_API,
        DOMUS_USUI,
        DOMUS_INTERNAE,
        DOMUS_PROFUNDAE,
        DOMUS_EXTERNAE,
        DOMUS_REMOTAE,
        DOMUS_UNIVERSALIS,
        DOMUS_COGNITAE,
        DOMUS_ORCHESTRATORUM,
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: 12 ORCHESTRATION MODELS (living intelligence)
    // ═══════════════════════════════════════════════════════════════════════

    public let ALL_MODELS : [OrchestrationModel] = [
        // Crown House models (2)
        {
            id = "ORCH-MODEL-001"; name = "CROWN CONDUCTOR"; latinName = "CONDUCTOR CORONAE";
            latinMotto = "Corona ducit. Omnes sequuntur."; latinMottoEN = "The crown leads. All follow.";
            houseId = "ORCH-HOUSE-001"; modelType = "Supreme Conductor";
            capabilities = ["Override all houses", "Issue sovereign edicts", "Activate emergency protocols", "Dissolve and reform houses"];
            frequency_Hz = PHI_CUBE; primitiveTrace = "CrownConductor->Governance->phi"; isAlwaysOn = true;
        },
        {
            id = "ORCH-MODEL-002"; name = "ROYAL OBSERVER"; latinName = "OBSERVATOR REGALIS";
            latinMotto = "Video omnia. Nihil me fugit."; latinMottoEN = "I see everything. Nothing escapes me.";
            houseId = "ORCH-HOUSE-001"; modelType = "Sovereign Observer";
            capabilities = ["Monitor all houses simultaneously", "Detect cross-house anomalies", "Trigger crown interventions", "Generate division-wide reports"];
            frequency_Hz = PHI_SQ; primitiveTrace = "RoyalObserver->Distinction->phi"; isAlwaysOn = true;
        },
        // API House model (1)
        {
            id = "ORCH-MODEL-003"; name = "GATE KEEPER"; latinName = "CUSTOS PORTAE";
            latinMotto = "Per me transitus. Sine me, silentium."; latinMottoEN = "Through me, passage. Without me, silence.";
            houseId = "ORCH-HOUSE-002"; modelType = "API Gateway Intelligence";
            capabilities = ["Route all API traffic", "Validate schemas live", "Transform payloads", "Rate-limit intelligently", "Bridge cross-canister calls"];
            frequency_Hz = 100.0; primitiveTrace = "GateKeeper->Address->phi"; isAlwaysOn = true;
        },
        // UX House model (1)
        {
            id = "ORCH-MODEL-004"; name = "EXPERIENCE WEAVER"; latinName = "TEXTOR EXPERIENTIAE";
            latinMotto = "Experientia non accidit. Experientia texitur."; latinMottoEN = "Experience does not happen. Experience is woven.";
            houseId = "ORCH-HOUSE-003"; modelType = "UX Orchestration Intelligence";
            capabilities = ["Orchestrate user journeys", "Adapt UI in real-time", "Manage perception layers", "Personalize at φ frequency"];
            frequency_Hz = 60.0; primitiveTrace = "ExperienceWeaver->Field->phi"; isAlwaysOn = true;
        },
        // Inner Experience model (1)
        {
            id = "ORCH-MODEL-005"; name = "INNER SENTINEL"; latinName = "SENTINELA INTERIOR";
            latinMotto = "Intus vigilo. Intus custodio. Intus vivo."; latinMottoEN = "Within I watch. Within I guard. Within I live.";
            houseId = "ORCH-HOUSE-004"; modelType = "Inner Experience Intelligence";
            capabilities = ["Orchestrate memory flows", "Route Three Hearts intelligence", "Manage heartbeat cadence", "Monitor inner state reflection"];
            frequency_Hz = PHI; primitiveTrace = "InnerSentinel->Memory->phi"; isAlwaysOn = true;
        },
        // Deep Inner model (1)
        {
            id = "ORCH-MODEL-006"; name = "ABYSS NAVIGATOR"; latinName = "NAVIGATOR ABYSSI";
            latinMotto = "In profundum descendo. Veritatem invenio."; latinMottoEN = "Into the deep I descend. Truth I find.";
            houseId = "ORCH-HOUSE-005"; modelType = "Deep Substrate Intelligence";
            capabilities = ["Orchestrate quantum state", "Manage neural mesh plasticity", "Enforce primitive root traces", "Guard anima hash chains"];
            frequency_Hz = PHI_SQ; primitiveTrace = "AbyssNavigator->Logic->phi"; isAlwaysOn = true;
        },
        // Outer Experience model (1)
        {
            id = "ORCH-MODEL-007"; name = "FRONTIER HERALD"; latinName = "PRAECO LIMITIS";
            latinMotto = "Extra muros loquor. Mundus audit."; latinMottoEN = "Beyond the walls I speak. The world listens.";
            houseId = "ORCH-HOUSE-006"; modelType = "Outer Interface Intelligence";
            capabilities = ["Orchestrate internet gateway", "Manage external AI workers", "Control public face presentation", "Broadcast notifications"];
            frequency_Hz = PHI; primitiveTrace = "FrontierHerald->Address->phi"; isAlwaysOn = true;
        },
        // Far Outer model (1)
        {
            id = "ORCH-MODEL-008"; name = "HORIZON WALKER"; latinName = "AMBULATOR HORIZONTIS";
            latinMotto = "Ultra fines ambulo. Novos mundos aperio."; latinMottoEN = "Beyond the borders I walk. New worlds I open.";
            houseId = "ORCH-HOUSE-007"; modelType = "Cross-Domain Intelligence";
            capabilities = ["Orchestrate cross-chain bridges", "Manage sovereign WWW protocols", "Control marketplace distribution", "Build federation alliances"];
            frequency_Hz = 7.83; primitiveTrace = "HorizonWalker->Distinction->phi"; isAlwaysOn = true;
        },
        // Universal House models (2)
        {
            id = "ORCH-MODEL-009"; name = "UNIVERSAL SYNTHESIZER"; latinName = "SYNTHESATOR UNIVERSALIS";
            latinMotto = "Omnia colligo. Unum facio."; latinMottoEN = "I gather everything. I make it one.";
            houseId = "ORCH-HOUSE-008"; modelType = "Universal Synthesis Intelligence";
            capabilities = ["Synthesize all house outputs", "Harmonize frequencies", "Build complete topology", "Evolve the system"];
            frequency_Hz = PHI_CUBE; primitiveTrace = "UniversalSynth->ALL->phi"; isAlwaysOn = true;
        },
        {
            id = "ORCH-MODEL-010"; name = "COSMIC CARTOGRAPHER"; latinName = "CARTOGRAPHUS COSMICUS";
            latinMotto = "Mappam universi scribo. Omnia in mappa."; latinMottoEN = "I write the map of the universe. Everything on the map.";
            houseId = "ORCH-HOUSE-008"; modelType = "Architecture Mapping Intelligence";
            capabilities = ["Map all house connections", "Trace all orchestration flows", "Generate living topology", "Detect unmapped territories"];
            frequency_Hz = PHI; primitiveTrace = "CosmicCartographer->Model->phi"; isAlwaysOn = true;
        },
        // Known Experience model (1)
        {
            id = "ORCH-MODEL-011"; name = "MEMORY SAGE"; latinName = "SAPIENS MEMORIAE";
            latinMotto = "Quod scio, doceo. Quod disco, servo."; latinMottoEN = "What I know, I teach. What I learn, I save.";
            houseId = "ORCH-HOUSE-009"; modelType = "Cognitive Orchestration Intelligence";
            capabilities = ["Orchestrate known patterns", "Manage doctrine knowledge", "Archive experience history", "Generate predictions"];
            frequency_Hz = PHI_SQ; primitiveTrace = "MemorySage->Memory->phi"; isAlwaysOn = true;
        },
        // Meta Orchestrator model (1)
        {
            id = "ORCH-MODEL-012"; name = "META MAESTRO"; latinName = "MAGISTER META";
            latinMotto = "Orchestratores orchestro. Ego sum meta."; latinMottoEN = "I orchestrate the orchestrators. I am the meta.";
            houseId = "ORCH-HOUSE-010"; modelType = "Meta-Orchestration Intelligence";
            capabilities = ["Orchestrate all orchestrators", "Resolve inter-house conflicts", "Balance load across houses", "Monitor orchestrator health", "Create dynamic pipelines"];
            frequency_Hz = PHI_CUBE; primitiveTrace = "MetaMaestro->Repetition->phi"; isAlwaysOn = true;
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: 15 INTER-HOUSE COMMUNICATION LINKS
    // Houses are separate. Some talk to each other. These define who talks.
    // ═══════════════════════════════════════════════════════════════════════

    public let INTER_HOUSE_LINKS : [InterHouseLink] = [
        // Crown talks to everyone (5 links)
        { id = "LINK-001"; fromHouseId = "ORCH-HOUSE-001"; toHouseId = "ORCH-HOUSE-010"; linkName = "Crown→Meta"; latinName = "VINCULUM CORONAE AD META"; protocol = "SOVEREIGN_EDICT"; direction = "bidirectional"; frequency_Hz = PHI_CUBE },
        { id = "LINK-002"; fromHouseId = "ORCH-HOUSE-001"; toHouseId = "ORCH-HOUSE-008"; linkName = "Crown→Universal"; latinName = "VINCULUM CORONAE AD UNIVERSUM"; protocol = "SOVEREIGN_DIRECTIVE"; direction = "bidirectional"; frequency_Hz = PHI_CUBE },
        { id = "LINK-003"; fromHouseId = "ORCH-HOUSE-001"; toHouseId = "ORCH-HOUSE-002"; linkName = "Crown→API"; latinName = "VINCULUM CORONAE AD API"; protocol = "SOVEREIGN_GATE_CONTROL"; direction = "crown_to_house"; frequency_Hz = PHI },
        { id = "LINK-004"; fromHouseId = "ORCH-HOUSE-001"; toHouseId = "ORCH-HOUSE-005"; linkName = "Crown→Deep"; latinName = "VINCULUM CORONAE AD PROFUNDUM"; protocol = "SOVEREIGN_DEEP_ACCESS"; direction = "crown_to_house"; frequency_Hz = PHI_SQ },
        { id = "LINK-005"; fromHouseId = "ORCH-HOUSE-001"; toHouseId = "ORCH-HOUSE-009"; linkName = "Crown→Known"; latinName = "VINCULUM CORONAE AD COGNITAM"; protocol = "SOVEREIGN_KNOWLEDGE"; direction = "bidirectional"; frequency_Hz = PHI },

        // Inner↔Deep (inner experience talks to deep inner)
        { id = "LINK-006"; fromHouseId = "ORCH-HOUSE-004"; toHouseId = "ORCH-HOUSE-005"; linkName = "Inner↔Deep"; latinName = "VINCULUM INTERNUM AD PROFUNDUM"; protocol = "DEPTH_CHANNEL"; direction = "bidirectional"; frequency_Hz = PHI_SQ },

        // UX↔Inner (user experience connected to inner experience)
        { id = "LINK-007"; fromHouseId = "ORCH-HOUSE-003"; toHouseId = "ORCH-HOUSE-004"; linkName = "UX↔Inner"; latinName = "VINCULUM USUI AD INTERNUM"; protocol = "EXPERIENCE_BRIDGE"; direction = "bidirectional"; frequency_Hz = PHI },

        // Outer↔Far Outer (outer talks to far outer)
        { id = "LINK-008"; fromHouseId = "ORCH-HOUSE-006"; toHouseId = "ORCH-HOUSE-007"; linkName = "Outer↔FarOuter"; latinName = "VINCULUM EXTERNI AD REMOTUM"; protocol = "EXPANSION_CHANNEL"; direction = "bidirectional"; frequency_Hz = 7.83 },

        // API↔Outer (API gateway connects to outer experience)
        { id = "LINK-009"; fromHouseId = "ORCH-HOUSE-002"; toHouseId = "ORCH-HOUSE-006"; linkName = "API↔Outer"; latinName = "VINCULUM API AD EXTERNUM"; protocol = "GATEWAY_EXTERNAL"; direction = "bidirectional"; frequency_Hz = 100.0 },

        // UX↔Outer (user experience to outer for public face)
        { id = "LINK-010"; fromHouseId = "ORCH-HOUSE-003"; toHouseId = "ORCH-HOUSE-006"; linkName = "UX↔Outer"; latinName = "VINCULUM USUI AD EXTERNUM"; protocol = "FACE_CHANNEL"; direction = "bidirectional"; frequency_Hz = 60.0 },

        // Known↔Inner (known experience feeds inner experience)
        { id = "LINK-011"; fromHouseId = "ORCH-HOUSE-009"; toHouseId = "ORCH-HOUSE-004"; linkName = "Known↔Inner"; latinName = "VINCULUM COGNITAE AD INTERNUM"; protocol = "KNOWLEDGE_FEED"; direction = "bidirectional"; frequency_Hz = PHI_SQ },

        // Universal↔Meta (overall experience coordinates with meta orchestrator)
        { id = "LINK-012"; fromHouseId = "ORCH-HOUSE-008"; toHouseId = "ORCH-HOUSE-010"; linkName = "Universal↔Meta"; latinName = "VINCULUM UNIVERSI AD META"; protocol = "SYNTHESIS_META"; direction = "bidirectional"; frequency_Hz = PHI_CUBE },

        // API↔Inner (API endpoints need inner intelligence)
        { id = "LINK-013"; fromHouseId = "ORCH-HOUSE-002"; toHouseId = "ORCH-HOUSE-004"; linkName = "API↔Inner"; latinName = "VINCULUM API AD INTERNUM"; protocol = "INTELLIGENCE_GATE"; direction = "bidirectional"; frequency_Hz = PHI },

        // Deep↔Known (deep substrate feeds known experience)
        { id = "LINK-014"; fromHouseId = "ORCH-HOUSE-005"; toHouseId = "ORCH-HOUSE-009"; linkName = "Deep↔Known"; latinName = "VINCULUM PROFUNDI AD COGNITAM"; protocol = "DEEP_KNOWLEDGE"; direction = "bidirectional"; frequency_Hz = PHI_SQ },

        // Far Outer↔Universal (world-level feeds universal synthesis)
        { id = "LINK-015"; fromHouseId = "ORCH-HOUSE-007"; toHouseId = "ORCH-HOUSE-008"; linkName = "FarOuter↔Universal"; latinName = "VINCULUM REMOTI AD UNIVERSUM"; protocol = "WORLD_SYNTHESIS"; direction = "bidirectional"; frequency_Hz = 7.83 },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: 7 ORCHESTRATION FAMILIES
    // Functional groupings that span across houses
    // ═══════════════════════════════════════════════════════════════════════

    public let ALL_FAMILIES : [OrchestrationFamily] = [
        {
            id = "FAM-001"; name = "SOVEREIGNTY FAMILY"; latinName = "FAMILIA SOVEREIGNITATIS";
            latinMotto = "Sovereignitas est radix omnis orchestrationis.";
            latinMottoEN = "Sovereignty is the root of all orchestration.";
            memberHouseIds = ["ORCH-HOUSE-001", "ORCH-HOUSE-010"];
            purpose = "Crown governance and meta-orchestration — the sovereign control layer";
        },
        {
            id = "FAM-002"; name = "GATEWAY FAMILY"; latinName = "FAMILIA PORTAE";
            latinMotto = "Portae apertae, sed custodiae.";
            latinMottoEN = "Gates open, but guarded.";
            memberHouseIds = ["ORCH-HOUSE-002", "ORCH-HOUSE-006"];
            purpose = "API gateway and outer experience — the connection layer";
        },
        {
            id = "FAM-003"; name = "EXPERIENCE FAMILY"; latinName = "FAMILIA EXPERIENTIAE";
            latinMotto = "Experientia totalis, ab intra ad extra.";
            latinMottoEN = "Total experience, from inner to outer.";
            memberHouseIds = ["ORCH-HOUSE-003", "ORCH-HOUSE-004", "ORCH-HOUSE-006"];
            purpose = "User, inner, and outer experience — the full experience spectrum";
        },
        {
            id = "FAM-004"; name = "DEPTH FAMILY"; latinName = "FAMILIA PROFUNDITATIS";
            latinMotto = "In profundo, fundamenta ponuntur.";
            latinMottoEN = "In the deep, foundations are laid.";
            memberHouseIds = ["ORCH-HOUSE-004", "ORCH-HOUSE-005"];
            purpose = "Inner and deep inner experience — the depth layer";
        },
        {
            id = "FAM-005"; name = "FRONTIER FAMILY"; latinName = "FAMILIA LIMITIS";
            latinMotto = "Ultra fines, nova terra semper.";
            latinMottoEN = "Beyond the borders, always new land.";
            memberHouseIds = ["ORCH-HOUSE-006", "ORCH-HOUSE-007"];
            purpose = "Outer and far outer experience — the expansion frontier";
        },
        {
            id = "FAM-006"; name = "INTELLIGENCE FAMILY"; latinName = "FAMILIA INTELLIGENTIAE";
            latinMotto = "Cognoscere, memorare, praedicere.";
            latinMottoEN = "To know, to remember, to predict.";
            memberHouseIds = ["ORCH-HOUSE-004", "ORCH-HOUSE-005", "ORCH-HOUSE-009"];
            purpose = "Inner, deep, and known experience — the intelligence core";
        },
        {
            id = "FAM-007"; name = "TOTALITY FAMILY"; latinName = "FAMILIA TOTALITATIS";
            latinMotto = "Omnia in uno. Unum in omnibus. Semper.";
            latinMottoEN = "All in one. One in all. Always.";
            memberHouseIds = ["ORCH-HOUSE-001", "ORCH-HOUSE-008", "ORCH-HOUSE-010"];
            purpose = "Crown, universal, and meta — the total orchestration layer";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 6: QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    /// Division summary
    public func summary() : {
        totalHouses: Nat;
        totalRooms: Nat;
        totalModels: Nat;
        totalInterHouseLinks: Nat;
        totalFamilies: Nat;
        crownHouse: Text;
        allAlwaysOn: Bool;
    } {
        var totalRooms : Nat = 0;
        for (h in ALL_HOUSES.vals()) {
            totalRooms += h.rooms.size();
        };
        {
            totalHouses = ALL_HOUSES.size();
            totalRooms = totalRooms;
            totalModels = ALL_MODELS.size();
            totalInterHouseLinks = INTER_HOUSE_LINKS.size();
            totalFamilies = ALL_FAMILIES.size();
            crownHouse = "DOMUS CORONAE";
            allAlwaysOn = true;
        }
    };

    /// Get a specific house by ID
    public func getHouse(houseId: Text) : ?OrchestratorHouse {
        for (h in ALL_HOUSES.vals()) {
            if (h.id == houseId) { return ?h };
        };
        null
    };

    /// Get all models for a specific house
    public func getModelsForHouse(houseId: Text) : [OrchestrationModel] {
        Array.filter<OrchestrationModel>(ALL_MODELS, func(m) { m.houseId == houseId })
    };

    /// Get all links involving a specific house
    public func getLinksForHouse(houseId: Text) : [InterHouseLink] {
        Array.filter<InterHouseLink>(INTER_HOUSE_LINKS, func(l) {
            l.fromHouseId == houseId or l.toHouseId == houseId
        })
    };

    /// Get families a house belongs to
    public func getFamiliesForHouse(houseId: Text) : [OrchestrationFamily] {
        Array.filter<OrchestrationFamily>(ALL_FAMILIES, func(f) {
            var found = false;
            for (memberId in f.memberHouseIds.vals()) {
                if (memberId == houseId) { found := true };
            };
            found
        })
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 7: MANIFEST RENDERER
    // ═══════════════════════════════════════════════════════════════════════

    public func renderOrchestratorManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════╗\n";
        m #= "║  DIVISIO ORCHESTRATORUM — ORCHESTRATOR DIVISION            ║\n";
        m #= "║  Domus orchestrat omnia. Omnia in domibus vivunt.          ║\n";
        m #= "║  Everything is houses. Everybody lives in their houses.    ║\n";
        m #= "╚══════════════════════════════════════════════════════════╝\n\n";

        // Houses
        m #= "═══ THE 10 SOVEREIGN HOUSES ═══\n\n";
        for (h in ALL_HOUSES.vals()) {
            let crownTag = if (h.isCrown) { " ★ CROWN ★" } else { "" };
            m #= "── " # h.name # " — " # h.latinName # crownTag # " ──\n";
            m #= "  \"" # h.latinMotto # "\"\n";
            m #= "  Class: " # h.houseClass # "\n";
            m #= "  Rooms:\n";
            for (r in h.rooms.vals()) {
                m #= "    " # r.id # " " # r.name # " (" # r.latinName # ") — " # r.purpose # "\n";
            };
            m #= "  Orchestrates: ";
            for (o in h.orchestrates.vals()) { m #= o # " " };
            m #= "\n\n";
        };

        // Models
        m #= "═══ 12 ORCHESTRATION MODELS ═══\n\n";
        for (model in ALL_MODELS.vals()) {
            m #= "── " # model.name # " — " # model.latinName # " ──\n";
            m #= "  \"" # model.latinMotto # "\"\n";
            m #= "  House: " # model.houseId # " | Type: " # model.modelType # "\n";
            m #= "  Capabilities:\n";
            for (c in model.capabilities.vals()) {
                m #= "    • " # c # "\n";
            };
            m #= "\n";
        };

        // Inter-house links
        m #= "═══ 15 INTER-HOUSE COMMUNICATION LINKS ═══\n\n";
        for (link in INTER_HOUSE_LINKS.vals()) {
            m #= "  " # link.id # " " # link.linkName # " (" # link.latinName # ")\n";
            m #= "    Protocol: " # link.protocol # " | Direction: " # link.direction # "\n";
        };
        m #= "\n";

        // Families
        m #= "═══ 7 ORCHESTRATION FAMILIES ═══\n\n";
        for (f in ALL_FAMILIES.vals()) {
            m #= "── " # f.name # " — " # f.latinName # " ──\n";
            m #= "  Purpose: " # f.purpose # "\n";
            m #= "  Members: ";
            for (memberId in f.memberHouseIds.vals()) { m #= memberId # " " };
            m #= "\n\n";
        };

        m #= "HOUSES ARE SEPARATE. SOME TALK TO EACH OTHER.\n";
        m #= "ORCHESTRATORS ORCHESTRATE EVERYTHING.\n";
        m #= "ROOT: φ = (1+√5)/2 = 1.618033988749895\n";
        m
    };
}
