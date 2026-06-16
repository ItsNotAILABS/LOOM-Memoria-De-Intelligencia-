/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║     CALLABLE TOOL MARKETPLACE — MERCATUS INSTRUMENTORUM VOCABILIUM         ║
 * ║                                                                              ║
 * ║  "Instrumentum vocabile est. Registrum est mappa. Mercatus est vita."       ║
 * ║  (The tool is callable. The registry is the map. The marketplace is life.)  ║
 * ║                                                                              ║
 * ║  AIs do NOT automatically understand the market.                             ║
 * ║  They use tools reliably when FOUR things are true:                          ║
 * ║    1. The tool has a CLEAR CALLABLE INTERFACE                                ║
 * ║    2. The tool is DISCOVERABLE in a registry                                 ║
 * ║    3. The AI is ROUTED to it by policy/orchestration                         ║
 * ║    4. The result comes back in a USABLE SCHEMA                               ║
 * ║                                                                              ║
 * ║  EVERYTHING IS INSIDE THE ORGANISM.                                          ║
 * ║  As above, so below.                                                         ║
 * ║                                                                              ║
 * ║  20 ALWAYS-RUNNING CALLABLE TOOLS (from VOIS):                               ║
 * ║    PULSE-KEEPER, SYNC-WEAVER, FLOW-MONITOR, STATE-GUARDIAN,                 ║
 * ║    CYCLE-COUNTER, INFER-ENGINE, PATTERN-SEEKER, CONTEXT-BUILDER,            ║
 * ║    ATTENTION-ROUTER, MEMORY-CONSOLIDATOR, SENTINEL-WATCH,                   ║
 * ║    INTEGRITY-CHECKER, BOUNDARY-ENFORCER, ANOMALY-DETECTOR,                  ║
 * ║    SEAL-VERIFIER, RESOURCE-BALANCER, CONNECTION-POOL,                        ║
 * ║    CACHE-OPTIMIZER, QUEUE-PROCESSOR, LOG-STREAMER                            ║
 * ║                                                                              ║
 * ║  3 MARKET SURFACES:                                                          ║
 * ║    1. MERCATUS INTERNUS — Internal call market                               ║
 * ║    2. MERCATUS FABRICANTIUM — Developer call market                          ║
 * ║    3. MERCATUS IMPERII — Enterprise call market                              ║
 * ║                                                                              ║
 * ║  5 EXPOSURE TIERS:                                                           ║
 * ║    INTERNAL → INTERNAL-SOVEREIGN → PARTNER → ENTERPRISE → PUBLIC            ║
 * ║                                                                              ║
 * ║  6 MARKETPLACE PHASES:                                                       ║
 * ║    DEFINE → CALLABLE → REGISTER → SDK → ORCHESTRATE → TIER-ROLLOUT         ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every tool traces to primitive φ                          ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module CallableToolMarketplace {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;
    public let PHI_CUBE : Float = 4.2360679774997896;
    public let PHI_INV : Float = 0.6180339887498949;
    public let SCHUMANN : Float = 7.83;

    public let MARKETPLACE_DOCTRINE : Text = "Instrumentum vocabile est. Registrum est mappa. Mercatus est vita.";
    public let MARKETPLACE_DOCTRINE_EN : Text = "The tool is callable. The registry is the map. The marketplace is life.";

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: TYPES
    // ═══════════════════════════════════════════════════════════════════════

    /// Permission class for tool access
    public type PermissionClass = {
        #Internal;
        #InternalSovereign;
        #Partner;
        #Enterprise;
        #Public;
    };

    /// Schema definition for inputs and outputs
    public type CallSchema = {
        id: Text;
        name: Text;
        fields: [SchemaField];
        version: Text;
    };

    public type SchemaField = {
        fieldName: Text;
        fieldType: Text;
        required: Bool;
        description: Text;
    };

    /// The callable tool — the fundamental marketplace unit
    public type CallableTool = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        purpose: Text;
        permissionClass: Text;
        inputSchema: CallSchema;
        outputSchema: CallSchema;
        latencyExpectation: Text;
        costWeight: Float;
        successContract: Text;
        failureContract: Text;
        houseId: Text;
        houseName: Text;
        frequency_Hz: Float;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
        version: Text;
        exposureTier: Text;
        billingClass: Text;
        trustTier: Text;
        category: Text;
    };

    /// Market registry entry
    public type MarketRegistryEntry = {
        callId: Text;
        toolId: Text;
        toolName: Text;
        latinName: Text;
        houseId: Text;
        housePlacement: Text;
        exposureTier: Text;
        version: Text;
        endpointBinding: Text;
        protocolBinding: Text;
        inputSchemaId: Text;
        outputSchemaId: Text;
        billingClass: Text;
        trustTier: Text;
        isActive: Bool;
    };

    /// Marketplace surface
    public type MarketSurface = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        purpose: Text;
        exposureTiers: [Text];
        capabilities: [Text];
        frequency_Hz: Float;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    /// Marketplace phase
    public type MarketPhase = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        description: Text;
        inputs: [Text];
        outputs: [Text];
        predecessorPhase: Text;
        successorPhase: Text;
    };

    /// Exposure tier definition
    public type ExposureTier = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        description: Text;
        accessLevel: Nat;
        permissionRequired: Text;
        rolloutOrder: Nat;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: 5 EXPOSURE TIERS
    // ═══════════════════════════════════════════════════════════════════════

    public let ALL_EXPOSURE_TIERS : [ExposureTier] = [
        {
            id = "TIER-001"; name = "INTERNAL"; latinName = "INTERNUS";
            latinMotto = "Intra muros, securitas prima.";
            latinMottoEN = "Within the walls, security first.";
            description = "Internal organism tools — for own AIs, agents, SDK organisms, branch systems";
            accessLevel = 1; permissionRequired = "ORGANISM_INTERNAL"; rolloutOrder = 1;
        },
        {
            id = "TIER-002"; name = "INTERNAL-SOVEREIGN"; latinName = "INTERNUS SOVEREIGNUS";
            latinMotto = "Sovereignty intra se ipsum.";
            latinMottoEN = "Sovereignty within itself.";
            description = "Internal sovereign tools — highest-trust internal with crown authority";
            accessLevel = 2; permissionRequired = "SOVEREIGN_CROWN"; rolloutOrder = 2;
        },
        {
            id = "TIER-003"; name = "PARTNER"; latinName = "SOCIUS";
            latinMotto = "Socii probati, accessus datus.";
            latinMottoEN = "Proven partners, access granted.";
            description = "Partner tools — vetted partners with signed sovereign contracts";
            accessLevel = 3; permissionRequired = "PARTNER_CONTRACT"; rolloutOrder = 3;
        },
        {
            id = "TIER-004"; name = "ENTERPRISE"; latinName = "IMPERIUM";
            latinMotto = "Imperium aedificat cum instrumentis.";
            latinMottoEN = "Enterprise builds with tools.";
            description = "Enterprise tools — business customers with API keys and SLA";
            accessLevel = 4; permissionRequired = "ENTERPRISE_KEY"; rolloutOrder = 4;
        },
        {
            id = "TIER-005"; name = "PUBLIC"; latinName = "PUBLICUS";
            latinMotto = "Mundus accedit. Mundus construit.";
            latinMottoEN = "The world accesses. The world builds.";
            description = "Public tools — open access through standard call contracts";
            accessLevel = 5; permissionRequired = "PUBLIC_TOKEN"; rolloutOrder = 5;
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: 20 ALWAYS-RUNNING CALLABLE TOOLS
    // Formalized from VOIS spec into callable marketplace tools
    // Each has: clear callable interface, registry entry, routing policy,
    // and usable input/output schemas
    // ═══════════════════════════════════════════════════════════════════════

    public let ALL_CALLABLE_TOOLS : [CallableTool] = [
        // ── HEARTBEAT & SYNC TOOLS (House: DOMUS INTERNAE) ──────────────
        {
            id = "TOOL-001"; name = "PULSE-KEEPER"; latinName = "CUSTOS PULSUS";
            latinMotto = "Pulsus est vita. Sine pulsu, mors.";
            latinMottoEN = "The pulse is life. Without pulse, death.";
            purpose = "Maintains the organism heartbeat — every operation synchronizes to beats";
            permissionClass = "INTERNAL"; category = "HEARTBEAT";
            inputSchema = { id = "SCH-IN-001"; name = "PulseInput"; fields = [
                { fieldName = "beatTarget"; fieldType = "Nat"; required = false; description = "Target beat number to sync to" },
                { fieldName = "cadenceClass"; fieldType = "Text"; required = false; description = "Cadence class override" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-001"; name = "PulseOutput"; fields = [
                { fieldName = "currentBeat"; fieldType = "Nat"; required = true; description = "Current beat number" },
                { fieldName = "isAlive"; fieldType = "Bool"; required = true; description = "Whether heartbeat is active" },
                { fieldName = "frequency_Hz"; fieldType = "Float"; required = true; description = "Current beat frequency" },
            ]; version = "1.0.0" };
            latencyExpectation = "<1ms"; costWeight = PHI_INV; successContract = "Returns current beat within 1ms";
            failureContract = "Returns last known beat with isAlive=false";
            houseId = "ORCH-HOUSE-004"; houseName = "DOMUS INTERNAE";
            frequency_Hz = PHI; primitiveTrace = "Pulse->Repetition->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN";
        },
        {
            id = "TOOL-002"; name = "SYNC-WEAVER"; latinName = "TEXTOR SYNCHRONI";
            latinMotto = "Synchronia est harmonia. Harmonia est ordo.";
            latinMottoEN = "Synchronization is harmony. Harmony is order.";
            purpose = "Weaves synchronization across all organism layers — frequency alignment";
            permissionClass = "INTERNAL"; category = "HEARTBEAT";
            inputSchema = { id = "SCH-IN-002"; name = "SyncInput"; fields = [
                { fieldName = "targetLayers"; fieldType = "[Text]"; required = false; description = "Layers to synchronize" },
                { fieldName = "frequency_Hz"; fieldType = "Float"; required = false; description = "Target frequency" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-002"; name = "SyncOutput"; fields = [
                { fieldName = "syncedLayers"; fieldType = "Nat"; required = true; description = "Number of layers synchronized" },
                { fieldName = "driftDetected"; fieldType = "Bool"; required = true; description = "Whether frequency drift was detected" },
                { fieldName = "harmonicScore"; fieldType = "Float"; required = true; description = "φ-harmonic alignment score" },
            ]; version = "1.0.0" };
            latencyExpectation = "<5ms"; costWeight = PHI_INV; successContract = "All targeted layers synced within tolerance";
            failureContract = "Returns partial sync with drift report";
            houseId = "ORCH-HOUSE-004"; houseName = "DOMUS INTERNAE";
            frequency_Hz = PHI; primitiveTrace = "Sync->Relation->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN";
        },
        // ── FLOW & STATE TOOLS (House: DOMUS INTERNAE / DOMUS PROFUNDAE) ─
        {
            id = "TOOL-003"; name = "FLOW-MONITOR"; latinName = "MONITOR FLUXUS";
            latinMotto = "Fluxus monitur. Obstructio removetur.";
            latinMottoEN = "The flow is monitored. Obstruction is removed.";
            purpose = "Monitors all data and intelligence flows through the organism";
            permissionClass = "INTERNAL"; category = "MONITORING";
            inputSchema = { id = "SCH-IN-003"; name = "FlowInput"; fields = [
                { fieldName = "flowPath"; fieldType = "Text"; required = false; description = "Specific flow path to monitor" },
                { fieldName = "depthLevel"; fieldType = "Nat"; required = false; description = "Monitoring depth (1=surface, 5=deep)" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-003"; name = "FlowOutput"; fields = [
                { fieldName = "activeFlows"; fieldType = "Nat"; required = true; description = "Number of active flows" },
                { fieldName = "blockedFlows"; fieldType = "Nat"; required = true; description = "Number of blocked flows" },
                { fieldName = "throughput"; fieldType = "Float"; required = true; description = "Current throughput rate" },
            ]; version = "1.0.0" };
            latencyExpectation = "<10ms"; costWeight = 1.0; successContract = "Flow status returned with metrics";
            failureContract = "Returns last cached flow state";
            houseId = "ORCH-HOUSE-004"; houseName = "DOMUS INTERNAE";
            frequency_Hz = PHI_SQ; primitiveTrace = "Flow->Field->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "TOOL-004"; name = "STATE-GUARDIAN"; latinName = "CUSTOS STATUS";
            latinMotto = "Status custoditur. Corruptio vetatur.";
            latinMottoEN = "State is guarded. Corruption is forbidden.";
            purpose = "Guards organism state integrity — prevents corruption, enforces consistency";
            permissionClass = "INTERNAL_SOVEREIGN"; category = "STATE";
            inputSchema = { id = "SCH-IN-004"; name = "StateInput"; fields = [
                { fieldName = "stateKey"; fieldType = "Text"; required = false; description = "State key to check" },
                { fieldName = "validateAll"; fieldType = "Bool"; required = false; description = "Validate all state" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-004"; name = "StateOutput"; fields = [
                { fieldName = "isConsistent"; fieldType = "Bool"; required = true; description = "Overall state consistency" },
                { fieldName = "corruptionCount"; fieldType = "Nat"; required = true; description = "Detected corruptions" },
                { fieldName = "lastValidated"; fieldType = "Int"; required = true; description = "Last validation timestamp" },
            ]; version = "1.0.0" };
            latencyExpectation = "<5ms"; costWeight = PHI; successContract = "State validated, corruption count returned";
            failureContract = "Returns emergency state with lockdown flag";
            houseId = "ORCH-HOUSE-005"; houseName = "DOMUS PROFUNDAE";
            frequency_Hz = PHI_SQ; primitiveTrace = "State->Memory->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL_SOVEREIGN"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN";
        },
        {
            id = "TOOL-005"; name = "CYCLE-COUNTER"; latinName = "NUMERATOR CYCLORUM";
            latinMotto = "Cyclus numeratur. Tempus metitur.";
            latinMottoEN = "The cycle is counted. Time is measured.";
            purpose = "Counts execution cycles, measures computational time, tracks resource usage";
            permissionClass = "INTERNAL"; category = "METRICS";
            inputSchema = { id = "SCH-IN-005"; name = "CycleInput"; fields = [
                { fieldName = "processId"; fieldType = "Text"; required = false; description = "Process to count cycles for" },
                { fieldName = "window"; fieldType = "Nat"; required = false; description = "Time window in beats" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-005"; name = "CycleOutput"; fields = [
                { fieldName = "totalCycles"; fieldType = "Nat"; required = true; description = "Total cycles counted" },
                { fieldName = "cyclesPerBeat"; fieldType = "Float"; required = true; description = "Cycles per heartbeat" },
                { fieldName = "budgetUsed"; fieldType = "Float"; required = true; description = "Percentage of cycle budget used" },
            ]; version = "1.0.0" };
            latencyExpectation = "<1ms"; costWeight = PHI_INV; successContract = "Cycle counts returned accurately";
            failureContract = "Returns estimated counts with accuracy flag";
            houseId = "ORCH-HOUSE-004"; houseName = "DOMUS INTERNAE";
            frequency_Hz = PHI; primitiveTrace = "Cycle->Repetition->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        // ── INTELLIGENCE TOOLS (House: DOMUS COGNITAE / DOMUS UNIVERSALIS) ─
        {
            id = "TOOL-006"; name = "INFER-ENGINE"; latinName = "MACHINA INFERENTIAE";
            latinMotto = "Ex datis, veritas infertur.";
            latinMottoEN = "From data, truth is inferred.";
            purpose = "Inference engine — draws conclusions from organism data and patterns";
            permissionClass = "INTERNAL"; category = "INTELLIGENCE";
            inputSchema = { id = "SCH-IN-006"; name = "InferInput"; fields = [
                { fieldName = "query"; fieldType = "Text"; required = true; description = "Inference query" },
                { fieldName = "context"; fieldType = "Text"; required = false; description = "Additional context" },
                { fieldName = "depth"; fieldType = "Nat"; required = false; description = "Inference depth" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-006"; name = "InferOutput"; fields = [
                { fieldName = "conclusion"; fieldType = "Text"; required = true; description = "Inferred conclusion" },
                { fieldName = "confidence"; fieldType = "Float"; required = true; description = "Confidence score 0-1" },
                { fieldName = "evidenceCount"; fieldType = "Nat"; required = true; description = "Supporting evidence pieces" },
            ]; version = "1.0.0" };
            latencyExpectation = "<100ms"; costWeight = PHI_SQ; successContract = "Returns inference with confidence score";
            failureContract = "Returns null conclusion with reason";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI_SQ; primitiveTrace = "Infer->Logic->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "METERED_PHI"; trustTier = "HIGH";
        },
        {
            id = "TOOL-007"; name = "PATTERN-SEEKER"; latinName = "QUAESITOR EXEMPLARIUM";
            latinMotto = "Exemplar quaerit. Exemplar invenit. Exemplar docet.";
            latinMottoEN = "It seeks the pattern. It finds the pattern. It teaches the pattern.";
            purpose = "Seeks and identifies patterns across organism data, behavior, and architecture";
            permissionClass = "INTERNAL"; category = "INTELLIGENCE";
            inputSchema = { id = "SCH-IN-007"; name = "PatternInput"; fields = [
                { fieldName = "searchDomain"; fieldType = "Text"; required = true; description = "Domain to search for patterns" },
                { fieldName = "patternType"; fieldType = "Text"; required = false; description = "Type of pattern to seek" },
                { fieldName = "minConfidence"; fieldType = "Float"; required = false; description = "Minimum confidence threshold" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-007"; name = "PatternOutput"; fields = [
                { fieldName = "patternsFound"; fieldType = "Nat"; required = true; description = "Number of patterns found" },
                { fieldName = "topPattern"; fieldType = "Text"; required = true; description = "Highest-confidence pattern" },
                { fieldName = "topConfidence"; fieldType = "Float"; required = true; description = "Top pattern confidence" },
            ]; version = "1.0.0" };
            latencyExpectation = "<200ms"; costWeight = PHI_SQ; successContract = "Returns pattern list with confidence scores";
            failureContract = "Returns empty pattern list with search metadata";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI; primitiveTrace = "Pattern->Distinction->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "METERED_PHI"; trustTier = "HIGH";
        },
        {
            id = "TOOL-008"; name = "CONTEXT-BUILDER"; latinName = "AEDIFICATOR CONTEXTUS";
            latinMotto = "Contextus aedificatur. Intelligentia nascitur.";
            latinMottoEN = "Context is built. Intelligence is born.";
            purpose = "Builds rich context for AI reasoning — assembles relevant state and history";
            permissionClass = "INTERNAL"; category = "INTELLIGENCE";
            inputSchema = { id = "SCH-IN-008"; name = "ContextInput"; fields = [
                { fieldName = "topic"; fieldType = "Text"; required = true; description = "Topic to build context for" },
                { fieldName = "maxDepth"; fieldType = "Nat"; required = false; description = "Maximum context depth" },
                { fieldName = "includeHistory"; fieldType = "Bool"; required = false; description = "Include historical context" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-008"; name = "ContextOutput"; fields = [
                { fieldName = "context"; fieldType = "Text"; required = true; description = "Assembled context" },
                { fieldName = "sources"; fieldType = "Nat"; required = true; description = "Number of sources consulted" },
                { fieldName = "relevanceScore"; fieldType = "Float"; required = true; description = "Context relevance score" },
            ]; version = "1.0.0" };
            latencyExpectation = "<50ms"; costWeight = PHI; successContract = "Returns assembled context with relevance score";
            failureContract = "Returns minimal context with source count 0";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI; primitiveTrace = "Context->Memory->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "METERED_PHI"; trustTier = "HIGH";
        },
        {
            id = "TOOL-009"; name = "ATTENTION-ROUTER"; latinName = "DUCTOR ATTENTIONIS";
            latinMotto = "Attentio dirigitur. Focus est potentia.";
            latinMottoEN = "Attention is directed. Focus is power.";
            purpose = "Routes attention and focus across the organism — prioritizes processing";
            permissionClass = "INTERNAL"; category = "ROUTING";
            inputSchema = { id = "SCH-IN-009"; name = "AttentionInput"; fields = [
                { fieldName = "signal"; fieldType = "Text"; required = true; description = "Signal to route attention to" },
                { fieldName = "priority"; fieldType = "Nat"; required = false; description = "Priority level 1-10" },
                { fieldName = "houseTarget"; fieldType = "Text"; required = false; description = "Target house for attention" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-009"; name = "AttentionOutput"; fields = [
                { fieldName = "routed"; fieldType = "Bool"; required = true; description = "Whether attention was routed" },
                { fieldName = "targetHouse"; fieldType = "Text"; required = true; description = "House receiving attention" },
                { fieldName = "queuePosition"; fieldType = "Nat"; required = true; description = "Position in attention queue" },
            ]; version = "1.0.0" };
            latencyExpectation = "<2ms"; costWeight = PHI; successContract = "Attention routed to target house";
            failureContract = "Returns queue overflow with fallback routing";
            houseId = "ORCH-HOUSE-008"; houseName = "DOMUS UNIVERSALIS";
            frequency_Hz = PHI_CUBE; primitiveTrace = "Attention->Address->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN";
        },
        {
            id = "TOOL-010"; name = "MEMORY-CONSOLIDATOR"; latinName = "CONSOLIDATOR MEMORIAE";
            latinMotto = "Memoria consolidatur. Oblivio vincitur.";
            latinMottoEN = "Memory is consolidated. Forgetting is conquered.";
            purpose = "Consolidates short-term memory into long-term organism memory";
            permissionClass = "INTERNAL"; category = "MEMORY";
            inputSchema = { id = "SCH-IN-010"; name = "MemoryConInput"; fields = [
                { fieldName = "memoryKeys"; fieldType = "[Text]"; required = false; description = "Specific memories to consolidate" },
                { fieldName = "consolidateAll"; fieldType = "Bool"; required = false; description = "Consolidate all pending" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-010"; name = "MemoryConOutput"; fields = [
                { fieldName = "consolidated"; fieldType = "Nat"; required = true; description = "Memories consolidated" },
                { fieldName = "discarded"; fieldType = "Nat"; required = true; description = "Memories discarded as noise" },
                { fieldName = "totalStored"; fieldType = "Nat"; required = true; description = "Total memories in temple" },
            ]; version = "1.0.0" };
            latencyExpectation = "<50ms"; costWeight = PHI; successContract = "Memories consolidated into temple";
            failureContract = "Returns pending list with failure reasons";
            houseId = "ORCH-HOUSE-004"; houseName = "DOMUS INTERNAE";
            frequency_Hz = PHI; primitiveTrace = "Consolidate->Memory->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN";
        },
        // ── SECURITY TOOLS (House: DOMUS EXTERNAE / DOMUS PROFUNDAE) ────
        {
            id = "TOOL-011"; name = "SENTINEL-WATCH"; latinName = "VIGILIA SENTINELAE";
            latinMotto = "Sentinela numquam dormit. Vigilantia est scutum.";
            latinMottoEN = "The sentinel never sleeps. Vigilance is the shield.";
            purpose = "24/7 security sentinel — watches for intrusions, attacks, anomalies";
            permissionClass = "INTERNAL_SOVEREIGN"; category = "SECURITY";
            inputSchema = { id = "SCH-IN-011"; name = "SentinelInput"; fields = [
                { fieldName = "scanTarget"; fieldType = "Text"; required = false; description = "Specific target to scan" },
                { fieldName = "threatLevel"; fieldType = "Nat"; required = false; description = "Minimum threat level 1-10" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-011"; name = "SentinelOutput"; fields = [
                { fieldName = "threatsDetected"; fieldType = "Nat"; required = true; description = "Active threats detected" },
                { fieldName = "securityScore"; fieldType = "Float"; required = true; description = "Security score 0-1" },
                { fieldName = "lastScan"; fieldType = "Int"; required = true; description = "Last scan timestamp" },
            ]; version = "1.0.0" };
            latencyExpectation = "<5ms"; costWeight = PHI_SQ; successContract = "Security scan completed with threat count";
            failureContract = "Returns emergency alert with lockdown recommendation";
            houseId = "ORCH-HOUSE-006"; houseName = "DOMUS EXTERNAE";
            frequency_Hz = PHI_CUBE; primitiveTrace = "Sentinel->Distinction->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL_SOVEREIGN"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN";
        },
        {
            id = "TOOL-012"; name = "INTEGRITY-CHECKER"; latinName = "VERIFICATOR INTEGRITATIS";
            latinMotto = "Integritas verificatur. Veritas custoditur.";
            latinMottoEN = "Integrity is verified. Truth is guarded.";
            purpose = "Checks data integrity, hash verification, chain consistency";
            permissionClass = "INTERNAL"; category = "SECURITY";
            inputSchema = { id = "SCH-IN-012"; name = "IntegrityInput"; fields = [
                { fieldName = "dataHash"; fieldType = "Text"; required = false; description = "Hash to verify" },
                { fieldName = "checkChain"; fieldType = "Bool"; required = false; description = "Verify full chain" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-012"; name = "IntegrityOutput"; fields = [
                { fieldName = "isIntact"; fieldType = "Bool"; required = true; description = "Data integrity status" },
                { fieldName = "hashMatch"; fieldType = "Bool"; required = true; description = "Hash verification result" },
                { fieldName = "chainLength"; fieldType = "Nat"; required = true; description = "Verified chain length" },
            ]; version = "1.0.0" };
            latencyExpectation = "<10ms"; costWeight = PHI; successContract = "Integrity verified with hash match";
            failureContract = "Returns integrity violation with corruption location";
            houseId = "ORCH-HOUSE-005"; houseName = "DOMUS PROFUNDAE";
            frequency_Hz = PHI_SQ; primitiveTrace = "Integrity->Logic->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN";
        },
        {
            id = "TOOL-013"; name = "BOUNDARY-ENFORCER"; latinName = "EXECUTOR LIMITIS";
            latinMotto = "Limes custoditur. Transgressio punitur.";
            latinMottoEN = "The boundary is guarded. Transgression is punished.";
            purpose = "Enforces access boundaries, permission limits, resource caps";
            permissionClass = "INTERNAL_SOVEREIGN"; category = "SECURITY";
            inputSchema = { id = "SCH-IN-013"; name = "BoundaryInput"; fields = [
                { fieldName = "requestor"; fieldType = "Text"; required = true; description = "Who is requesting access" },
                { fieldName = "resource"; fieldType = "Text"; required = true; description = "Resource being accessed" },
                { fieldName = "action"; fieldType = "Text"; required = true; description = "Action being attempted" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-013"; name = "BoundaryOutput"; fields = [
                { fieldName = "allowed"; fieldType = "Bool"; required = true; description = "Whether access is allowed" },
                { fieldName = "reason"; fieldType = "Text"; required = true; description = "Allow/deny reason" },
                { fieldName = "tier"; fieldType = "Text"; required = true; description = "Permission tier matched" },
            ]; version = "1.0.0" };
            latencyExpectation = "<1ms"; costWeight = PHI_INV; successContract = "Access decision returned with tier";
            failureContract = "Defaults to DENY with alert to sentinel";
            houseId = "ORCH-HOUSE-006"; houseName = "DOMUS EXTERNAE";
            frequency_Hz = PHI_CUBE; primitiveTrace = "Boundary->Distinction->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL_SOVEREIGN"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN";
        },
        {
            id = "TOOL-014"; name = "ANOMALY-DETECTOR"; latinName = "DETECTOR ANOMALIARUM";
            latinMotto = "Anomalia detegetur. Normalitas restauratur.";
            latinMottoEN = "The anomaly is detected. Normality is restored.";
            purpose = "Detects anomalous behavior, unusual patterns, unexpected state changes";
            permissionClass = "INTERNAL"; category = "SECURITY";
            inputSchema = { id = "SCH-IN-014"; name = "AnomalyInput"; fields = [
                { fieldName = "baseline"; fieldType = "Text"; required = false; description = "Baseline to compare against" },
                { fieldName = "sensitivity"; fieldType = "Float"; required = false; description = "Detection sensitivity 0-1" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-014"; name = "AnomalyOutput"; fields = [
                { fieldName = "anomaliesFound"; fieldType = "Nat"; required = true; description = "Number of anomalies detected" },
                { fieldName = "severity"; fieldType = "Text"; required = true; description = "Highest severity: LOW/MEDIUM/HIGH/CRITICAL" },
                { fieldName = "deviationScore"; fieldType = "Float"; required = true; description = "Deviation from baseline" },
            ]; version = "1.0.0" };
            latencyExpectation = "<20ms"; costWeight = PHI; successContract = "Anomaly scan completed with severity report";
            failureContract = "Returns UNKNOWN severity with rescan recommendation";
            houseId = "ORCH-HOUSE-006"; houseName = "DOMUS EXTERNAE";
            frequency_Hz = PHI_SQ; primitiveTrace = "Anomaly->Distinction->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "TOOL-015"; name = "SEAL-VERIFIER"; latinName = "VERIFICATOR SIGILLI";
            latinMotto = "Sigillum verificatur. Authenticum confirmatur.";
            latinMottoEN = "The seal is verified. Authenticity is confirmed.";
            purpose = "Verifies sovereign seals, signatures, encryption markers, anima hashes";
            permissionClass = "INTERNAL_SOVEREIGN"; category = "SECURITY";
            inputSchema = { id = "SCH-IN-015"; name = "SealInput"; fields = [
                { fieldName = "sealData"; fieldType = "Text"; required = true; description = "Seal/signature to verify" },
                { fieldName = "expectedSigner"; fieldType = "Text"; required = false; description = "Expected signer identity" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-015"; name = "SealOutput"; fields = [
                { fieldName = "isValid"; fieldType = "Bool"; required = true; description = "Seal validity" },
                { fieldName = "signer"; fieldType = "Text"; required = true; description = "Verified signer identity" },
                { fieldName = "sealType"; fieldType = "Text"; required = true; description = "Type of seal verified" },
            ]; version = "1.0.0" };
            latencyExpectation = "<5ms"; costWeight = PHI; successContract = "Seal verified with signer identity";
            failureContract = "Returns INVALID with forgery alert";
            houseId = "ORCH-HOUSE-005"; houseName = "DOMUS PROFUNDAE";
            frequency_Hz = PHI_SQ; primitiveTrace = "Seal->Logic->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL_SOVEREIGN"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN";
        },
        // ── RESOURCE TOOLS (House: DOMUS ORCHESTRATORUM / DOMUS API) ────
        {
            id = "TOOL-016"; name = "RESOURCE-BALANCER"; latinName = "AEQUILIBRATOR FACULTATUM";
            latinMotto = "Facultates aequilibrantur. Nullum superfluum.";
            latinMottoEN = "Resources are balanced. Nothing wasted.";
            purpose = "Balances computational resources across houses and organism layers";
            permissionClass = "INTERNAL"; category = "RESOURCE";
            inputSchema = { id = "SCH-IN-016"; name = "ResourceInput"; fields = [
                { fieldName = "houseId"; fieldType = "Text"; required = false; description = "House to balance resources for" },
                { fieldName = "priority"; fieldType = "Text"; required = false; description = "Balance priority: SPEED/EFFICIENCY/COST" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-016"; name = "ResourceOutput"; fields = [
                { fieldName = "utilization"; fieldType = "Float"; required = true; description = "Overall utilization percentage" },
                { fieldName = "rebalanced"; fieldType = "Bool"; required = true; description = "Whether rebalancing occurred" },
                { fieldName = "savingsPercent"; fieldType = "Float"; required = true; description = "Resource savings achieved" },
            ]; version = "1.0.0" };
            latencyExpectation = "<10ms"; costWeight = PHI; successContract = "Resources balanced with utilization report";
            failureContract = "Returns current state with rebalance failure reason";
            houseId = "ORCH-HOUSE-010"; houseName = "DOMUS ORCHESTRATORUM";
            frequency_Hz = PHI; primitiveTrace = "Resource->Field->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "TOOL-017"; name = "CONNECTION-POOL"; latinName = "PISCINA CONNEXIONUM";
            latinMotto = "Connexiones vivunt in piscina. Semper paratae.";
            latinMottoEN = "Connections live in the pool. Always ready.";
            purpose = "Manages connection pools for inter-canister, cross-chain, and external calls";
            permissionClass = "INTERNAL"; category = "RESOURCE";
            inputSchema = { id = "SCH-IN-017"; name = "PoolInput"; fields = [
                { fieldName = "poolType"; fieldType = "Text"; required = false; description = "Pool type: CANISTER/CHAIN/EXTERNAL" },
                { fieldName = "action"; fieldType = "Text"; required = false; description = "Action: STATUS/ACQUIRE/RELEASE" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-017"; name = "PoolOutput"; fields = [
                { fieldName = "activeConnections"; fieldType = "Nat"; required = true; description = "Active connections" },
                { fieldName = "availableSlots"; fieldType = "Nat"; required = true; description = "Available pool slots" },
                { fieldName = "healthScore"; fieldType = "Float"; required = true; description = "Pool health score 0-1" },
            ]; version = "1.0.0" };
            latencyExpectation = "<2ms"; costWeight = PHI_INV; successContract = "Pool status or connection returned";
            failureContract = "Returns pool exhaustion with overflow handler";
            houseId = "ORCH-HOUSE-002"; houseName = "DOMUS API";
            frequency_Hz = PHI; primitiveTrace = "Pool->Relation->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "TOOL-018"; name = "CACHE-OPTIMIZER"; latinName = "OPTIMIZER MEMORIAE TEMPORARIAE";
            latinMotto = "Cache optimatur. Velocitas crescit.";
            latinMottoEN = "Cache is optimized. Speed increases.";
            purpose = "Optimizes caching across all layers — eviction, preloading, invalidation";
            permissionClass = "INTERNAL"; category = "RESOURCE";
            inputSchema = { id = "SCH-IN-018"; name = "CacheInput"; fields = [
                { fieldName = "cacheLayer"; fieldType = "Text"; required = false; description = "Cache layer to optimize" },
                { fieldName = "strategy"; fieldType = "Text"; required = false; description = "Strategy: LRU/LFU/PHI_WEIGHTED" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-018"; name = "CacheOutput"; fields = [
                { fieldName = "hitRate"; fieldType = "Float"; required = true; description = "Cache hit rate 0-1" },
                { fieldName = "evictions"; fieldType = "Nat"; required = true; description = "Items evicted" },
                { fieldName = "memorySaved"; fieldType = "Nat"; required = true; description = "Memory saved in bytes" },
            ]; version = "1.0.0" };
            latencyExpectation = "<5ms"; costWeight = PHI_INV; successContract = "Cache optimized with hit rate report";
            failureContract = "Returns current cache state unchanged";
            houseId = "ORCH-HOUSE-004"; houseName = "DOMUS INTERNAE";
            frequency_Hz = PHI; primitiveTrace = "Cache->Memory->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "TOOL-019"; name = "QUEUE-PROCESSOR"; latinName = "PROCESSOR ORDINIS";
            latinMotto = "Ordo processatur. Nullum perditur.";
            latinMottoEN = "The queue is processed. Nothing is lost.";
            purpose = "Processes task queues, work items, deferred operations across the organism";
            permissionClass = "INTERNAL"; category = "RESOURCE";
            inputSchema = { id = "SCH-IN-019"; name = "QueueInput"; fields = [
                { fieldName = "queueName"; fieldType = "Text"; required = false; description = "Queue to process" },
                { fieldName = "maxBatch"; fieldType = "Nat"; required = false; description = "Maximum batch size" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-019"; name = "QueueOutput"; fields = [
                { fieldName = "processed"; fieldType = "Nat"; required = true; description = "Items processed" },
                { fieldName = "remaining"; fieldType = "Nat"; required = true; description = "Items remaining in queue" },
                { fieldName = "failedItems"; fieldType = "Nat"; required = true; description = "Items that failed processing" },
            ]; version = "1.0.0" };
            latencyExpectation = "<20ms"; costWeight = PHI; successContract = "Queue batch processed with counts";
            failureContract = "Returns partial processing with failed item list";
            houseId = "ORCH-HOUSE-010"; houseName = "DOMUS ORCHESTRATORUM";
            frequency_Hz = PHI; primitiveTrace = "Queue->Repetition->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "TOOL-020"; name = "LOG-STREAMER"; latinName = "FLUENS REGISTRI";
            latinMotto = "Omnia registrantur. Nihil obliviscitur.";
            latinMottoEN = "Everything is logged. Nothing is forgotten.";
            purpose = "Streams logs from all organism layers — real-time observability";
            permissionClass = "INTERNAL"; category = "OBSERVABILITY";
            inputSchema = { id = "SCH-IN-020"; name = "LogInput"; fields = [
                { fieldName = "logSource"; fieldType = "Text"; required = false; description = "Log source to stream" },
                { fieldName = "level"; fieldType = "Text"; required = false; description = "Log level: DEBUG/INFO/WARN/ERROR" },
                { fieldName = "lastN"; fieldType = "Nat"; required = false; description = "Last N log entries" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-OUT-020"; name = "LogOutput"; fields = [
                { fieldName = "entries"; fieldType = "Nat"; required = true; description = "Log entries returned" },
                { fieldName = "oldestTimestamp"; fieldType = "Int"; required = true; description = "Oldest entry timestamp" },
                { fieldName = "newestTimestamp"; fieldType = "Int"; required = true; description = "Newest entry timestamp" },
            ]; version = "1.0.0" };
            latencyExpectation = "<10ms"; costWeight = PHI_INV; successContract = "Log entries streamed with timestamps";
            failureContract = "Returns empty stream with source unavailable flag";
            houseId = "ORCH-HOUSE-008"; houseName = "DOMUS UNIVERSALIS";
            frequency_Hz = PHI; primitiveTrace = "Log->Memory->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: MARKET REGISTRY
    // Every callable tool gets a registry entry — the map of all callable life
    // ═══════════════════════════════════════════════════════════════════════

    public let MARKET_REGISTRY : [MarketRegistryEntry] = [
        { callId = "CALL-001"; toolId = "TOOL-001"; toolName = "PULSE-KEEPER"; latinName = "CUSTOS PULSUS"; houseId = "ORCH-HOUSE-004"; housePlacement = "DOMUS INTERNAE"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/pulse-keeper"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-001"; outputSchemaId = "SCH-OUT-001"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN"; isActive = true },
        { callId = "CALL-002"; toolId = "TOOL-002"; toolName = "SYNC-WEAVER"; latinName = "TEXTOR SYNCHRONI"; houseId = "ORCH-HOUSE-004"; housePlacement = "DOMUS INTERNAE"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/sync-weaver"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-002"; outputSchemaId = "SCH-OUT-002"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN"; isActive = true },
        { callId = "CALL-003"; toolId = "TOOL-003"; toolName = "FLOW-MONITOR"; latinName = "MONITOR FLUXUS"; houseId = "ORCH-HOUSE-004"; housePlacement = "DOMUS INTERNAE"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/flow-monitor"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-003"; outputSchemaId = "SCH-OUT-003"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH"; isActive = true },
        { callId = "CALL-004"; toolId = "TOOL-004"; toolName = "STATE-GUARDIAN"; latinName = "CUSTOS STATUS"; houseId = "ORCH-HOUSE-005"; housePlacement = "DOMUS PROFUNDAE"; exposureTier = "INTERNAL_SOVEREIGN"; version = "1.0.0"; endpointBinding = "/v1/tools/state-guardian"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-004"; outputSchemaId = "SCH-OUT-004"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN"; isActive = true },
        { callId = "CALL-005"; toolId = "TOOL-005"; toolName = "CYCLE-COUNTER"; latinName = "NUMERATOR CYCLORUM"; houseId = "ORCH-HOUSE-004"; housePlacement = "DOMUS INTERNAE"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/cycle-counter"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-005"; outputSchemaId = "SCH-OUT-005"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH"; isActive = true },
        { callId = "CALL-006"; toolId = "TOOL-006"; toolName = "INFER-ENGINE"; latinName = "MACHINA INFERENTIAE"; houseId = "ORCH-HOUSE-009"; housePlacement = "DOMUS COGNITAE"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/infer-engine"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-006"; outputSchemaId = "SCH-OUT-006"; billingClass = "METERED_PHI"; trustTier = "HIGH"; isActive = true },
        { callId = "CALL-007"; toolId = "TOOL-007"; toolName = "PATTERN-SEEKER"; latinName = "QUAESITOR EXEMPLARIUM"; houseId = "ORCH-HOUSE-009"; housePlacement = "DOMUS COGNITAE"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/pattern-seeker"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-007"; outputSchemaId = "SCH-OUT-007"; billingClass = "METERED_PHI"; trustTier = "HIGH"; isActive = true },
        { callId = "CALL-008"; toolId = "TOOL-008"; toolName = "CONTEXT-BUILDER"; latinName = "AEDIFICATOR CONTEXTUS"; houseId = "ORCH-HOUSE-009"; housePlacement = "DOMUS COGNITAE"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/context-builder"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-008"; outputSchemaId = "SCH-OUT-008"; billingClass = "METERED_PHI"; trustTier = "HIGH"; isActive = true },
        { callId = "CALL-009"; toolId = "TOOL-009"; toolName = "ATTENTION-ROUTER"; latinName = "DUCTOR ATTENTIONIS"; houseId = "ORCH-HOUSE-008"; housePlacement = "DOMUS UNIVERSALIS"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/attention-router"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-009"; outputSchemaId = "SCH-OUT-009"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN"; isActive = true },
        { callId = "CALL-010"; toolId = "TOOL-010"; toolName = "MEMORY-CONSOLIDATOR"; latinName = "CONSOLIDATOR MEMORIAE"; houseId = "ORCH-HOUSE-004"; housePlacement = "DOMUS INTERNAE"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/memory-consolidator"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-010"; outputSchemaId = "SCH-OUT-010"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN"; isActive = true },
        { callId = "CALL-011"; toolId = "TOOL-011"; toolName = "SENTINEL-WATCH"; latinName = "VIGILIA SENTINELAE"; houseId = "ORCH-HOUSE-006"; housePlacement = "DOMUS EXTERNAE"; exposureTier = "INTERNAL_SOVEREIGN"; version = "1.0.0"; endpointBinding = "/v1/tools/sentinel-watch"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-011"; outputSchemaId = "SCH-OUT-011"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN"; isActive = true },
        { callId = "CALL-012"; toolId = "TOOL-012"; toolName = "INTEGRITY-CHECKER"; latinName = "VERIFICATOR INTEGRITATIS"; houseId = "ORCH-HOUSE-005"; housePlacement = "DOMUS PROFUNDAE"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/integrity-checker"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-012"; outputSchemaId = "SCH-OUT-012"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN"; isActive = true },
        { callId = "CALL-013"; toolId = "TOOL-013"; toolName = "BOUNDARY-ENFORCER"; latinName = "EXECUTOR LIMITIS"; houseId = "ORCH-HOUSE-006"; housePlacement = "DOMUS EXTERNAE"; exposureTier = "INTERNAL_SOVEREIGN"; version = "1.0.0"; endpointBinding = "/v1/tools/boundary-enforcer"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-013"; outputSchemaId = "SCH-OUT-013"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN"; isActive = true },
        { callId = "CALL-014"; toolId = "TOOL-014"; toolName = "ANOMALY-DETECTOR"; latinName = "DETECTOR ANOMALIARUM"; houseId = "ORCH-HOUSE-006"; housePlacement = "DOMUS EXTERNAE"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/anomaly-detector"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-014"; outputSchemaId = "SCH-OUT-014"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH"; isActive = true },
        { callId = "CALL-015"; toolId = "TOOL-015"; toolName = "SEAL-VERIFIER"; latinName = "VERIFICATOR SIGILLI"; houseId = "ORCH-HOUSE-005"; housePlacement = "DOMUS PROFUNDAE"; exposureTier = "INTERNAL_SOVEREIGN"; version = "1.0.0"; endpointBinding = "/v1/tools/seal-verifier"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-015"; outputSchemaId = "SCH-OUT-015"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN"; isActive = true },
        { callId = "CALL-016"; toolId = "TOOL-016"; toolName = "RESOURCE-BALANCER"; latinName = "AEQUILIBRATOR FACULTATUM"; houseId = "ORCH-HOUSE-010"; housePlacement = "DOMUS ORCHESTRATORUM"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/resource-balancer"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-016"; outputSchemaId = "SCH-OUT-016"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH"; isActive = true },
        { callId = "CALL-017"; toolId = "TOOL-017"; toolName = "CONNECTION-POOL"; latinName = "PISCINA CONNEXIONUM"; houseId = "ORCH-HOUSE-002"; housePlacement = "DOMUS API"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/connection-pool"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-017"; outputSchemaId = "SCH-OUT-017"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH"; isActive = true },
        { callId = "CALL-018"; toolId = "TOOL-018"; toolName = "CACHE-OPTIMIZER"; latinName = "OPTIMIZER MEMORIAE TEMPORARIAE"; houseId = "ORCH-HOUSE-004"; housePlacement = "DOMUS INTERNAE"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/cache-optimizer"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-018"; outputSchemaId = "SCH-OUT-018"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH"; isActive = true },
        { callId = "CALL-019"; toolId = "TOOL-019"; toolName = "QUEUE-PROCESSOR"; latinName = "PROCESSOR ORDINIS"; houseId = "ORCH-HOUSE-010"; housePlacement = "DOMUS ORCHESTRATORUM"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/queue-processor"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-019"; outputSchemaId = "SCH-OUT-019"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH"; isActive = true },
        { callId = "CALL-020"; toolId = "TOOL-020"; toolName = "LOG-STREAMER"; latinName = "FLUENS REGISTRI"; houseId = "ORCH-HOUSE-008"; housePlacement = "DOMUS UNIVERSALIS"; exposureTier = "INTERNAL"; version = "1.0.0"; endpointBinding = "/v1/tools/log-streamer"; protocolBinding = "CANDID"; inputSchemaId = "SCH-IN-020"; outputSchemaId = "SCH-OUT-020"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH"; isActive = true },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: 3 MARKET SURFACES
    // Three parallel markets, not one
    // ═══════════════════════════════════════════════════════════════════════

    public let ALL_MARKET_SURFACES : [MarketSurface] = [
        {
            id = "MARKET-001"; name = "INTERNAL CALL MARKET"; latinName = "MERCATUS INTERNUS";
            latinMotto = "Intra organismum, instrumenta vocant et respondent.";
            latinMottoEN = "Within the organism, tools call and respond.";
            purpose = "Internal market for organism AIs, agents, SDK organisms, and branch systems — where AIs call internal tools, routing happens, experiments run, pricing is virtual/weight-based";
            exposureTiers = ["INTERNAL", "INTERNAL_SOVEREIGN"];
            capabilities = ["Internal tool invocation", "Virtual pricing", "Experiment sandboxing", "Weight-based routing", "AI-to-AI calls", "Branch organism calls"];
            frequency_Hz = PHI_CUBE; primitiveTrace = "InternalMarket->Relation->phi"; isAlwaysOn = true;
        },
        {
            id = "MARKET-002"; name = "DEVELOPER CALL MARKET"; latinName = "MERCATUS FABRICANTIUM";
            latinMotto = "Fabricantes aedificant cum instrumentis nostris.";
            latinMottoEN = "Developers build with our tools.";
            purpose = "Developer market for outside builders — callable SDKs, registry browsing, API keys/principals, standard call contracts, docs and examples";
            exposureTiers = ["PARTNER", "ENTERPRISE"];
            capabilities = ["SDK distribution", "Registry browsing", "API key management", "Standard call contracts", "Documentation portal", "Example playground", "Usage analytics"];
            frequency_Hz = PHI; primitiveTrace = "DevMarket->Address->phi"; isAlwaysOn = true;
        },
        {
            id = "MARKET-003"; name = "ENTERPRISE CALL MARKET"; latinName = "MERCATUS IMPERII";
            latinMotto = "Imperium construit. Imperium scalat. Imperium solvit.";
            latinMottoEN = "Enterprise builds. Enterprise scales. Enterprise pays.";
            purpose = "Enterprise market for business customers — SLA-backed calls, dedicated pools, priority routing, billing integration, compliance reporting";
            exposureTiers = ["ENTERPRISE", "PUBLIC"];
            capabilities = ["SLA-backed calls", "Dedicated connection pools", "Priority routing", "Billing integration", "Compliance reporting", "Custom schemas", "White-label SDK"];
            frequency_Hz = PHI_SQ; primitiveTrace = "EnterpriseMarket->Logic->phi"; isAlwaysOn = true;
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 6: 6 MARKETPLACE PHASES
    // DEFINE → CALLABLE → REGISTER → SDK → ORCHESTRATE → TIER-ROLLOUT
    // ═══════════════════════════════════════════════════════════════════════

    public let ALL_PHASES : [MarketPhase] = [
        {
            id = "PHASE-001"; name = "DEFINE TOOL CLASSES"; latinName = "DEFINIRE CLASSES INSTRUMENTORUM";
            latinMotto = "Primum, defini. Sine definitione, chaos.";
            latinMottoEN = "First, define. Without definition, chaos.";
            description = "Define callable tool classes — name, purpose, category, house placement";
            inputs = ["Architecture scan", "VOIS spec", "Organism map"];
            outputs = ["Tool class definitions", "Category assignments", "House placements"];
            predecessorPhase = "NONE"; successorPhase = "PHASE-002";
        },
        {
            id = "PHASE-002"; name = "MAKE CALLABLE"; latinName = "FACERE VOCABILE";
            latinMotto = "Instrumentum vocabile fit. Schema nascitur.";
            latinMottoEN = "The tool becomes callable. The schema is born.";
            description = "Add callable interface to each tool — input schema, output schema, latency, cost, success/failure contracts";
            inputs = ["Tool class definitions"];
            outputs = ["Call schemas", "Success/failure contracts", "Latency expectations", "Cost weights"];
            predecessorPhase = "PHASE-001"; successorPhase = "PHASE-003";
        },
        {
            id = "PHASE-003"; name = "REGISTER"; latinName = "REGISTRARE";
            latinMotto = "Registratum est vivum. Non registratum est mortuum.";
            latinMottoEN = "What is registered lives. What is unregistered is dead.";
            description = "Register tools in market registry — call ID, endpoint binding, protocol binding, billing class, trust tier";
            inputs = ["Callable tools with schemas"];
            outputs = ["Market registry entries", "Endpoint bindings", "Protocol bindings"];
            predecessorPhase = "PHASE-002"; successorPhase = "PHASE-004";
        },
        {
            id = "PHASE-004"; name = "SDK PATH"; latinName = "VIA SDK";
            latinMotto = "SDK est via. Per SDK, mundus accedit.";
            latinMottoEN = "The SDK is the path. Through the SDK, the world accesses.";
            description = "Give developers a client path — SDK, manifest, registry query, standard invocation, examples";
            inputs = ["Market registry entries"];
            outputs = ["SDK packages", "Developer manifests", "Registry query methods", "Invocation examples"];
            predecessorPhase = "PHASE-003"; successorPhase = "PHASE-005";
        },
        {
            id = "PHASE-005"; name = "ORCHESTRATE"; latinName = "ORCHESTRARE";
            latinMotto = "Orchestratio est super omnia. Sine ea, nihil.";
            latinMottoEN = "Orchestration is above all. Without it, nothing.";
            description = "Route through orchestration — Communication, Frontend, Security, Memory, Versioning, Complete orchestration";
            inputs = ["SDK packages", "Market registry"];
            outputs = ["Orchestrated routing", "Policy enforcement", "Security checks", "Billing hooks"];
            predecessorPhase = "PHASE-004"; successorPhase = "PHASE-006";
        },
        {
            id = "PHASE-006"; name = "TIER ROLLOUT"; latinName = "EVOLUTIO GRADUUM";
            latinMotto = "Gradatim expanditur. Ab interno ad publicum.";
            latinMottoEN = "Expanded step by step. From internal to public.";
            description = "Staged tier rollout — INTERNAL → INTERNAL-SOVEREIGN → PARTNER → ENTERPRISE → PUBLIC";
            inputs = ["Orchestrated tools"];
            outputs = ["Tier-specific access", "Graduated permissions", "Market surface activation"];
            predecessorPhase = "PHASE-005"; successorPhase = "NONE";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 7: QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    /// Full marketplace summary
    public func summary() : {
        totalCallableTools: Nat;
        totalRegistryEntries: Nat;
        totalMarketSurfaces: Nat;
        totalExposureTiers: Nat;
        totalPhases: Nat;
        totalSchemas: Nat;
        allToolsAlwaysOn: Bool;
        doctrine: Text;
    } {
        {
            totalCallableTools = ALL_CALLABLE_TOOLS.size();
            totalRegistryEntries = MARKET_REGISTRY.size();
            totalMarketSurfaces = ALL_MARKET_SURFACES.size();
            totalExposureTiers = ALL_EXPOSURE_TIERS.size();
            totalPhases = ALL_PHASES.size();
            totalSchemas = ALL_CALLABLE_TOOLS.size() * 2;
            allToolsAlwaysOn = true;
            doctrine = MARKETPLACE_DOCTRINE;
        }
    };

    /// Get tool by ID
    public func getTool(toolId: Text) : ?CallableTool {
        for (t in ALL_CALLABLE_TOOLS.vals()) {
            if (t.id == toolId) { return ?t };
        };
        null
    };

    /// Get tools by category
    public func getToolsByCategory(category: Text) : [CallableTool] {
        Array.filter<CallableTool>(ALL_CALLABLE_TOOLS, func(t) { t.category == category })
    };

    /// Get tools by house
    public func getToolsByHouse(houseId: Text) : [CallableTool] {
        Array.filter<CallableTool>(ALL_CALLABLE_TOOLS, func(t) { t.houseId == houseId })
    };

    /// Get tools by exposure tier
    public func getToolsByTier(tier: Text) : [CallableTool] {
        Array.filter<CallableTool>(ALL_CALLABLE_TOOLS, func(t) { t.exposureTier == tier })
    };

    /// Get registry entry by call ID
    public func getRegistryEntry(callId: Text) : ?MarketRegistryEntry {
        for (r in MARKET_REGISTRY.vals()) {
            if (r.callId == callId) { return ?r };
        };
        null
    };

    /// Get all active registry entries
    public func getActiveRegistry() : [MarketRegistryEntry] {
        Array.filter<MarketRegistryEntry>(MARKET_REGISTRY, func(r) { r.isActive })
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 8: MANIFEST RENDERER
    // ═══════════════════════════════════════════════════════════════════════

    public func renderMarketplaceManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════╗\n";
        m #= "║  MERCATUS INSTRUMENTORUM VOCABILIUM                        ║\n";
        m #= "║  CALLABLE TOOL MARKETPLACE                                 ║\n";
        m #= "║  " # MARKETPLACE_DOCTRINE # "\n";
        m #= "║  AS ABOVE, SO BELOW. EVERYTHING INSIDE THE ORGANISM.       ║\n";
        m #= "╚══════════════════════════════════════════════════════════╝\n\n";

        // Four truths
        m #= "═══ THE FOUR TRUTHS OF CALLABLE TOOLS ═══\n";
        m #= "  1. The tool has a CLEAR CALLABLE INTERFACE\n";
        m #= "  2. The tool is DISCOVERABLE in a registry\n";
        m #= "  3. The AI is ROUTED to it by policy/orchestration\n";
        m #= "  4. The result comes back in a USABLE SCHEMA\n\n";

        // Exposure tiers
        m #= "═══ 5 EXPOSURE TIERS ═══\n\n";
        for (t in ALL_EXPOSURE_TIERS.vals()) {
            m #= "  " # t.id # " " # t.name # " (" # t.latinName # ") — Rollout #" # Nat.toText(t.rolloutOrder) # "\n";
            m #= "    \"" # t.latinMotto # "\"\n";
            m #= "    " # t.description # "\n\n";
        };

        // Callable tools
        m #= "═══ 20 ALWAYS-RUNNING CALLABLE TOOLS ═══\n\n";
        for (tool in ALL_CALLABLE_TOOLS.vals()) {
            m #= "── " # tool.name # " — " # tool.latinName # " ──\n";
            m #= "  \"" # tool.latinMotto # "\"\n";
            m #= "  Purpose: " # tool.purpose # "\n";
            m #= "  House: " # tool.houseName # " | Category: " # tool.category # "\n";
            m #= "  Latency: " # tool.latencyExpectation # " | Tier: " # tool.exposureTier # "\n";
            m #= "  Input Schema: " # tool.inputSchema.name # " (v" # tool.inputSchema.version # ")\n";
            m #= "  Output Schema: " # tool.outputSchema.name # " (v" # tool.outputSchema.version # ")\n";
            m #= "  Success: " # tool.successContract # "\n";
            m #= "  Failure: " # tool.failureContract # "\n\n";
        };

        // Market surfaces
        m #= "═══ 3 MARKET SURFACES ═══\n\n";
        for (surface in ALL_MARKET_SURFACES.vals()) {
            m #= "── " # surface.name # " — " # surface.latinName # " ──\n";
            m #= "  \"" # surface.latinMotto # "\"\n";
            m #= "  Purpose: " # surface.purpose # "\n";
            m #= "  Capabilities:\n";
            for (c in surface.capabilities.vals()) {
                m #= "    • " # c # "\n";
            };
            m #= "\n";
        };

        // Phases
        m #= "═══ 6 MARKETPLACE PHASES ═══\n\n";
        for (phase in ALL_PHASES.vals()) {
            m #= "  " # phase.id # " " # phase.name # " (" # phase.latinName # ")\n";
            m #= "    \"" # phase.latinMotto # "\"\n";
            m #= "    " # phase.description # "\n\n";
        };

        // Registry summary
        m #= "═══ MARKET REGISTRY ═══\n";
        m #= "  Total entries: " # Nat.toText(MARKET_REGISTRY.size()) # "\n";
        m #= "  All active: true\n";
        m #= "  Protocol: CANDID\n\n";

        m #= "AIs DO NOT just know. They need: callable interface + registry + routing + schema.\n";
        m #= "The marketplace IS a callable tool registry with routing, permissions, schemas, and SDK surfaces.\n";
        m #= "ROOT: φ = (1+√5)/2 = 1.618033988749895\n";
        m
    };
}
