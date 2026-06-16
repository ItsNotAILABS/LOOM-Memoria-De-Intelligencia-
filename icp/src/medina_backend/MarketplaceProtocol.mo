/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║           MARKETPLACE PROTOCOL — PROTOCOLLUM MERCATUS                       ║
 * ║                                                                              ║
 * ║  "Agens non mystice discit. Agens per protocollum invocat."                  ║
 * ║  (An agent does not learn mystically. An agent invokes through protocol.)    ║
 * ║                                                                              ║
 * ║  Phase 4-5: Developer client path, invocation contracts, SDK surface,        ║
 * ║  orchestration routing. This is the PROTOCOL SURFACE of the marketplace.     ║
 * ║                                                                              ║
 * ║  Three things make an AI reliably call a tool:                               ║
 * ║    1. A tool catalog with discoverable entries                                ║
 * ║    2. A standard invocation pattern (the call contract)                       ║
 * ║    3. Orchestration routing through the correct pipeline                      ║
 * ║                                                                              ║
 * ║  This module provides:                                                        ║
 * ║    - Call contracts (standard invocation patterns)                             ║
 * ║    - SDK manifest format (what developers receive)                            ║
 * ║    - Orchestration surface bindings (routing through orchestrators)           ║
 * ║    - Registry query methods (how to discover tools)                           ║
 * ║    - Invocation lifecycle (request → route → execute → respond)               ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every protocol traces to primitive φ                      ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module MarketplaceProtocol {

    // ═══════════════════════════════════════════════════════════════════════
    // ROOT CONSTANTS
    // ═══════════════════════════════════════════════════════════════════════

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: DOCTRINE
    // ═══════════════════════════════════════════════════════════════════════

    public let DOCTRINE = {
        name = "MARKETPLACE-PROTOCOL";
        latinName = "PROTOCOLLUM MERCATUS";
        motto = "Agens non mystice discit. Agens per protocollum invocat.";
        mottoEN = "An agent does not learn mystically. An agent invokes through protocol.";
        principle = "Developers should not teach their AIs mystically. They give them an SDK, a manifest, a registry query method, a standard invocation pattern, and examples.";
        totalCallContracts = 6;
        totalSDKManifestFields = 8;
        totalOrchestrationBindings = 6;
        totalLifecycleStages = 5;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type CallContract = {
        id: Text;
        name: Text;
        latinName: Text;
        contractType: Text;
        description: Text;
        inputFormat: Text;
        outputFormat: Text;
        authRequired: Bool;
        maxLatencyMs: Nat;
        retryPolicy: Text;
        primitiveTrace: Text;
    };

    public type SDKManifestEntry = {
        id: Text;
        name: Text;
        latinName: Text;
        sdkTarget: Text;
        packageName: Text;
        version: Text;
        entrypoint: Text;
        capabilities: [Text];
        registryQueryMethod: Text;
        invocationPattern: Text;
        exampleCall: Text;
        primitiveTrace: Text;
    };

    public type OrchestrationBinding = {
        id: Text;
        name: Text;
        latinName: Text;
        orchestratorRef: Text;
        routingPolicy: Text;
        pipelineStages: [Text];
        fallbackStrategy: Text;
        healthCheckInterval_Hz: Float;
        primitiveTrace: Text;
    };

    public type InvocationLifecycle = {
        stage: Nat;
        name: Text;
        latinName: Text;
        description: Text;
        inputArtifact: Text;
        outputArtifact: Text;
        validationRule: Text;
        primitiveTrace: Text;
    };

    public type RegistryQueryResult = {
        totalMatches: Nat;
        tools: [RegistryToolSummary];
        queryTime: Text;
        cacheHit: Bool;
    };

    public type RegistryToolSummary = {
        callId: Text;
        name: Text;
        purpose: Text;
        permissionClass: Text;
        trustTier: Text;
        endpointBinding: Text;
        isAvailable: Bool;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: CALL CONTRACTS
    // ═══════════════════════════════════════════════════════════════════════

    public let CALL_CONTRACTS : [CallContract] = [
        {
            id = "CC-001";
            name = "QUERY CONTRACT";
            latinName = "CONTRACTUS QUAESTIONIS";
            contractType = "QUERY";
            description = "Read-only query for tool state or data. No state mutation. Used for inspecting tool outputs, checking status, and retrieving cached results.";
            inputFormat = "JSON";
            outputFormat = "CANDID";
            authRequired = false;
            maxLatencyMs = 100;
            retryPolicy = "NONE";
            primitiveTrace = "φ → Relation → Address → Query surface";
        },
        {
            id = "CC-002";
            name = "INVOKE CONTRACT";
            latinName = "CONTRACTUS INVOCATIONIS";
            contractType = "INVOKE";
            description = "Execute a tool action with state mutation. The primary contract for invoking tool capabilities that change system state.";
            inputFormat = "CANDID";
            outputFormat = "CANDID";
            authRequired = true;
            maxLatencyMs = 500;
            retryPolicy = "EXPONENTIAL_BACKOFF";
            primitiveTrace = "φ → Distinction → Repetition → Invocation surface";
        },
        {
            id = "CC-003";
            name = "SUBSCRIBE CONTRACT";
            latinName = "CONTRACTUS SUBSCRIPTIONIS";
            contractType = "SUBSCRIBE";
            description = "Subscribe to a tool output stream. Maintains a persistent connection for receiving tool events and state changes over time.";
            inputFormat = "JSON";
            outputFormat = "JSON";
            authRequired = true;
            maxLatencyMs = 200;
            retryPolicy = "RECONNECT";
            primitiveTrace = "φ → Relation → Memory → Subscription surface";
        },
        {
            id = "CC-004";
            name = "STREAM CONTRACT";
            latinName = "CONTRACTUS FLUXUS";
            contractType = "STREAM";
            description = "Continuous data stream from a tool. Low-latency, high-throughput channel for real-time tool output consumption.";
            inputFormat = "CANDID";
            outputFormat = "CANDID";
            authRequired = true;
            maxLatencyMs = 50;
            retryPolicy = "AUTO_RESUME";
            primitiveTrace = "φ → Field → Repetition → Stream surface";
        },
        {
            id = "CC-005";
            name = "BATCH CONTRACT";
            latinName = "CONTRACTUS FASCICULI";
            contractType = "BATCH";
            description = "Batch multiple tool calls into a single transactional unit. Reduces overhead for bulk operations and ensures atomicity across related invocations.";
            inputFormat = "JSON";
            outputFormat = "JSON";
            authRequired = true;
            maxLatencyMs = 2000;
            retryPolicy = "RETRY_FAILED_ITEMS";
            primitiveTrace = "φ → Repetition → Relation → Batch surface";
        },
        {
            id = "CC-006";
            name = "DISCOVER CONTRACT";
            latinName = "CONTRACTUS INVENTIONIS";
            contractType = "DISCOVER";
            description = "Discover available tools in the registry. Returns catalog entries matching search criteria, enabling agents to find tools dynamically.";
            inputFormat = "JSON";
            outputFormat = "JSON";
            authRequired = false;
            maxLatencyMs = 50;
            retryPolicy = "CACHE_FALLBACK";
            primitiveTrace = "φ → Address → Distinction → Discovery surface";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: SDK MANIFEST
    // ═══════════════════════════════════════════════════════════════════════

    public let SDK_MANIFESTS : [SDKManifestEntry] = [
        {
            id = "SDK-MAN-001";
            name = "TypeScript SDK";
            latinName = "INSTRUMENTUM TYPESCRIPTUM";
            sdkTarget = "npm";
            packageName = "@medina/marketplace-sdk";
            version = "1.0.0";
            entrypoint = "index.ts";
            capabilities = ["discover_tools", "invoke_tool", "query_registry", "subscribe_stream", "batch_invoke"];
            registryQueryMethod = "client.registry.query({ filter: 'category:ai', limit: 50 })";
            invocationPattern = "const result = await client.invoke('tool-id', { params })";
            exampleCall = "const tools = await medina.discover({ category: 'memory' });";
            primitiveTrace = "φ → Language → Model → TypeScript binding";
        },
        {
            id = "SDK-MAN-002";
            name = "Java SDK";
            latinName = "INSTRUMENTUM JAVANUM";
            sdkTarget = "maven";
            packageName = "com.medina.marketplace";
            version = "1.0.0";
            entrypoint = "Main.java";
            capabilities = ["discover_tools", "invoke_tool", "query_registry", "subscribe_stream", "batch_invoke"];
            registryQueryMethod = "client.getRegistry().query(QueryFilter.category(\"ai\"), 50)";
            invocationPattern = "Result result = client.invoke(\"tool-id\", params)";
            exampleCall = "List<Tool> tools = medina.discover(DiscoverRequest.category(\"memory\"));";
            primitiveTrace = "φ → Language → Model → Java binding";
        },
        {
            id = "SDK-MAN-003";
            name = "C# SDK";
            latinName = "INSTRUMENTUM CSHARPUM";
            sdkTarget = "nuget";
            packageName = "Medina.Marketplace";
            version = "1.0.0";
            entrypoint = "MarketplaceClient.cs";
            capabilities = ["discover_tools", "invoke_tool", "query_registry", "subscribe_stream", "batch_invoke"];
            registryQueryMethod = "client.Registry.QueryAsync(filter: \"category:ai\", limit: 50)";
            invocationPattern = "var result = await client.InvokeAsync(\"tool-id\", parameters)";
            exampleCall = "var tools = await medina.DiscoverAsync(new DiscoverRequest { Category = \"memory\" });";
            primitiveTrace = "φ → Language → Model → C# binding";
        },
        {
            id = "SDK-MAN-004";
            name = "Ruby SDK";
            latinName = "INSTRUMENTUM RUBINUM";
            sdkTarget = "rubygems";
            packageName = "medina-marketplace";
            version = "1.0.0";
            entrypoint = "marketplace.rb";
            capabilities = ["discover_tools", "invoke_tool", "query_registry", "subscribe_stream", "batch_invoke"];
            registryQueryMethod = "client.registry.query(filter: 'category:ai', limit: 50)";
            invocationPattern = "result = client.invoke('tool-id', params)";
            exampleCall = "tools = medina.discover(category: 'memory')";
            primitiveTrace = "φ → Language → Model → Ruby binding";
        },
        {
            id = "SDK-MAN-005";
            name = "Python SDK";
            latinName = "INSTRUMENTUM PYTHONICUM";
            sdkTarget = "pip";
            packageName = "medina-marketplace";
            version = "1.0.0";
            entrypoint = "marketplace.py";
            capabilities = ["discover_tools", "invoke_tool", "query_registry", "subscribe_stream", "batch_invoke"];
            registryQueryMethod = "client.registry.query(filter='category:ai', limit=50)";
            invocationPattern = "result = await client.invoke('tool-id', params)";
            exampleCall = "tools = medina.discover(category='memory')";
            primitiveTrace = "φ → Language → Model → Python binding";
        },
        {
            id = "SDK-MAN-006";
            name = "Go SDK";
            latinName = "INSTRUMENTUM GOICUM";
            sdkTarget = "go";
            packageName = "github.com/medina/marketplace";
            version = "1.0.0";
            entrypoint = "marketplace.go";
            capabilities = ["discover_tools", "invoke_tool", "query_registry", "subscribe_stream", "batch_invoke"];
            registryQueryMethod = "client.Registry.Query(ctx, QueryFilter{Category: \"ai\"}, 50)";
            invocationPattern = "result, err := client.Invoke(ctx, \"tool-id\", params)";
            exampleCall = "tools, err := medina.Discover(ctx, DiscoverRequest{Category: \"memory\"})";
            primitiveTrace = "φ → Language → Model → Go binding";
        },
        {
            id = "SDK-MAN-007";
            name = "Rust SDK";
            latinName = "INSTRUMENTUM RUSTICUM";
            sdkTarget = "cargo";
            packageName = "medina-marketplace";
            version = "1.0.0";
            entrypoint = "lib.rs";
            capabilities = ["discover_tools", "invoke_tool", "query_registry", "subscribe_stream", "batch_invoke"];
            registryQueryMethod = "client.registry().query(QueryFilter::category(\"ai\"), 50).await?";
            invocationPattern = "let result = client.invoke(\"tool-id\", &params).await?";
            exampleCall = "let tools = medina.discover(DiscoverRequest::category(\"memory\")).await?;";
            primitiveTrace = "φ → Language → Model → Rust binding";
        },
        {
            id = "SDK-MAN-008";
            name = "Docker SDK";
            latinName = "INSTRUMENTUM DOCKERUM";
            sdkTarget = "docker";
            packageName = "medina/marketplace";
            version = "1.0.0";
            entrypoint = "Dockerfile";
            capabilities = ["discover_tools", "invoke_tool", "query_registry", "batch_invoke"];
            registryQueryMethod = "curl -X GET http://marketplace:8080/registry?filter=category:ai&limit=50";
            invocationPattern = "curl -X POST http://marketplace:8080/invoke/tool-id -d '{params}'";
            exampleCall = "docker run medina/marketplace discover --category memory";
            primitiveTrace = "φ → Language → Model → Docker binding";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: ORCHESTRATION BINDINGS
    // ═══════════════════════════════════════════════════════════════════════

    public let ORCHESTRATION_BINDINGS : [OrchestrationBinding] = [
        {
            id = "ORCH-001";
            name = "Communication Orchestrator";
            latinName = "ORCHESTRATOR COMMUNICATIONIS";
            orchestratorRef = "communication-orchestrator";
            routingPolicy = "PHI_WEIGHTED";
            pipelineStages = ["RECEIVE", "VALIDATE", "ROUTE", "EXECUTE", "RESPOND"];
            fallbackStrategy = "QUEUE_AND_RETRY";
            healthCheckInterval_Hz = 1.618033988749895;
            primitiveTrace = "φ → Relation → Language → Communication routing";
        },
        {
            id = "ORCH-002";
            name = "Frontend Command Orchestrator";
            latinName = "ORCHESTRATOR MANDATORUM FRONTIS";
            orchestratorRef = "frontend-command-orchestrator";
            routingPolicy = "DIRECT";
            pipelineStages = ["PARSE", "AUTH", "DISPATCH", "RENDER", "RETURN"];
            fallbackStrategy = "CACHED_RESPONSE";
            healthCheckInterval_Hz = 1.618033988749895;
            primitiveTrace = "φ → Distinction → Address → Frontend routing";
        },
        {
            id = "ORCH-003";
            name = "Security Orchestrator";
            latinName = "ORCHESTRATOR SECURITATIS";
            orchestratorRef = "security-orchestrator";
            routingPolicy = "DIRECT";
            pipelineStages = ["DETECT", "CLASSIFY", "ENFORCE", "LOG", "ALERT"];
            fallbackStrategy = "LOCKDOWN";
            healthCheckInterval_Hz = 1.618033988749895;
            primitiveTrace = "φ → Distinction → Logic → Security routing";
        },
        {
            id = "ORCH-004";
            name = "Memory Orchestrator";
            latinName = "ORCHESTRATOR MEMORIAE";
            orchestratorRef = "memory-orchestrator";
            routingPolicy = "PHI_WEIGHTED";
            pipelineStages = ["INDEX", "STORE", "CONSOLIDATE", "VERIFY", "RETURN"];
            fallbackStrategy = "READ_REPLICA";
            healthCheckInterval_Hz = 1.618033988749895;
            primitiveTrace = "φ → Memory → Repetition → Memory routing";
        },
        {
            id = "ORCH-005";
            name = "Versioning Orchestrator";
            latinName = "ORCHESTRATOR VERSIONUM";
            orchestratorRef = "versioning-orchestrator";
            routingPolicy = "ROUND_ROBIN";
            pipelineStages = ["SNAPSHOT", "DIFF", "MERGE", "VALIDATE", "COMMIT"];
            fallbackStrategy = "ROLLBACK";
            healthCheckInterval_Hz = 1.618033988749895;
            primitiveTrace = "φ → Memory → Distinction → Versioning routing";
        },
        {
            id = "ORCH-006";
            name = "Complete Orchestration Platform";
            latinName = "ORCHESTRATOR COMPLETUS";
            orchestratorRef = "complete-orchestration-platform";
            routingPolicy = "LOAD_BALANCED";
            pipelineStages = ["INTAKE", "CLASSIFY", "DELEGATE", "AGGREGATE", "DELIVER"];
            fallbackStrategy = "DEGRADED_MODE";
            healthCheckInterval_Hz = 1.618033988749895;
            primitiveTrace = "φ → Field → Relation → Master orchestration routing";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 6: INVOCATION LIFECYCLE
    // ═══════════════════════════════════════════════════════════════════════

    public let INVOCATION_LIFECYCLE : [InvocationLifecycle] = [
        {
            stage = 1;
            name = "REQUEST";
            latinName = "PETITIO";
            description = "Agent or developer submits invocation request. The entry point of the protocol lifecycle.";
            inputArtifact = "CallContract + parameters";
            outputArtifact = "ValidatedRequest";
            validationRule = "Schema validation + auth check";
            primitiveTrace = "φ → Address → Distinction → Request intake";
        },
        {
            stage = 2;
            name = "ROUTE";
            latinName = "DIRECTIO";
            description = "Orchestrator routes the validated request to the correct tool via the appropriate pipeline.";
            inputArtifact = "ValidatedRequest";
            outputArtifact = "RoutedInvocation";
            validationRule = "Permission class + trust tier check";
            primitiveTrace = "φ → Relation → Address → Routing decision";
        },
        {
            stage = 3;
            name = "EXECUTE";
            latinName = "EXECUTIO";
            description = "The target tool processes the invocation and produces a raw result within latency bounds.";
            inputArtifact = "RoutedInvocation";
            outputArtifact = "RawResult";
            validationRule = "Latency + resource bounds check";
            primitiveTrace = "φ → Repetition → Distinction → Execution cycle";
        },
        {
            stage = 4;
            name = "VALIDATE";
            latinName = "VALIDATIO";
            description = "Raw result is validated against the output schema defined in the call contract.";
            inputArtifact = "RawResult";
            outputArtifact = "ValidatedResult";
            validationRule = "Output schema conformance";
            primitiveTrace = "φ → Logic → Distinction → Validation gate";
        },
        {
            stage = 5;
            name = "RESPOND";
            latinName = "RESPONSIO";
            description = "Formatted response returned to the calling agent or developer with settlement record.";
            inputArtifact = "ValidatedResult";
            outputArtifact = "FormattedResponse";
            validationRule = "Settlement record + log entry";
            primitiveTrace = "φ → Language → Relation → Response delivery";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 7: PUBLIC FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func summary() : {
        totalCallContracts: Nat;
        totalSDKManifests: Nat;
        totalOrchestrationBindings: Nat;
        totalLifecycleStages: Nat;
        doctrine: Text;
        motto: Text;
    } {
        {
            totalCallContracts = CALL_CONTRACTS.size();
            totalSDKManifests = SDK_MANIFESTS.size();
            totalOrchestrationBindings = ORCHESTRATION_BINDINGS.size();
            totalLifecycleStages = INVOCATION_LIFECYCLE.size();
            doctrine = DOCTRINE.name;
            motto = DOCTRINE.motto;
        };
    };

    public func getCallContracts() : [{
        id: Text;
        name: Text;
        latinName: Text;
        contractType: Text;
        authRequired: Bool;
        maxLatencyMs: Nat;
    }] {
        Array.map<CallContract, {
            id: Text;
            name: Text;
            latinName: Text;
            contractType: Text;
            authRequired: Bool;
            maxLatencyMs: Nat;
        }>(CALL_CONTRACTS, func(cc : CallContract) {
            {
                id = cc.id;
                name = cc.name;
                latinName = cc.latinName;
                contractType = cc.contractType;
                authRequired = cc.authRequired;
                maxLatencyMs = cc.maxLatencyMs;
            };
        });
    };

    public func getCallContract(id : Text) : ?CallContract {
        Array.find<CallContract>(CALL_CONTRACTS, func(cc : CallContract) : Bool {
            cc.id == id;
        });
    };

    public func getSDKManifests() : [{
        id: Text;
        name: Text;
        sdkTarget: Text;
        packageName: Text;
        version: Text;
    }] {
        Array.map<SDKManifestEntry, {
            id: Text;
            name: Text;
            sdkTarget: Text;
            packageName: Text;
            version: Text;
        }>(SDK_MANIFESTS, func(sdk : SDKManifestEntry) {
            {
                id = sdk.id;
                name = sdk.name;
                sdkTarget = sdk.sdkTarget;
                packageName = sdk.packageName;
                version = sdk.version;
            };
        });
    };

    public func getSDKManifest(id : Text) : ?SDKManifestEntry {
        Array.find<SDKManifestEntry>(SDK_MANIFESTS, func(sdk : SDKManifestEntry) : Bool {
            sdk.id == id;
        });
    };

    public func getOrchestrationBindings() : [{
        id: Text;
        name: Text;
        latinName: Text;
        orchestratorRef: Text;
        routingPolicy: Text;
    }] {
        Array.map<OrchestrationBinding, {
            id: Text;
            name: Text;
            latinName: Text;
            orchestratorRef: Text;
            routingPolicy: Text;
        }>(ORCHESTRATION_BINDINGS, func(ob : OrchestrationBinding) {
            {
                id = ob.id;
                name = ob.name;
                latinName = ob.latinName;
                orchestratorRef = ob.orchestratorRef;
                routingPolicy = ob.routingPolicy;
            };
        });
    };

    public func getInvocationLifecycle() : [InvocationLifecycle] {
        INVOCATION_LIFECYCLE;
    };

    public func renderProtocolManifest() : Text {
        var manifest = "╔══════════════════════════════════════════════════════════════╗\n";
        manifest #= "║         MARKETPLACE PROTOCOL MANIFEST                        ║\n";
        manifest #= "║         PROTOCOLLUM MERCATUS — MANIFESTUM                    ║\n";
        manifest #= "╚══════════════════════════════════════════════════════════════╝\n\n";

        manifest #= "DOCTRINE: " # DOCTRINE.name # "\n";
        manifest #= "LATIN: " # DOCTRINE.latinName # "\n";
        manifest #= "MOTTO: " # DOCTRINE.motto # "\n";
        manifest #= "PRINCIPLE: " # DOCTRINE.principle # "\n\n";

        manifest #= "═══════════════════════════════════════════════════════════════\n";
        manifest #= "CALL CONTRACTS (" # Nat.toText(CALL_CONTRACTS.size()) # ")\n";
        manifest #= "═══════════════════════════════════════════════════════════════\n";
        for (cc in CALL_CONTRACTS.vals()) {
            manifest #= "  [" # cc.id # "] " # cc.name # " (" # cc.latinName # ")\n";
            manifest #= "    Type: " # cc.contractType # " | Input: " # cc.inputFormat # " | Output: " # cc.outputFormat # "\n";
            manifest #= "    Auth: " # (if (cc.authRequired) "REQUIRED" else "NONE") # " | Max Latency: " # Nat.toText(cc.maxLatencyMs) # "ms\n";
            manifest #= "    Retry: " # cc.retryPolicy # "\n";
            manifest #= "    Trace: " # cc.primitiveTrace # "\n\n";
        };

        manifest #= "═══════════════════════════════════════════════════════════════\n";
        manifest #= "SDK MANIFESTS (" # Nat.toText(SDK_MANIFESTS.size()) # ")\n";
        manifest #= "═══════════════════════════════════════════════════════════════\n";
        for (sdk in SDK_MANIFESTS.vals()) {
            manifest #= "  [" # sdk.id # "] " # sdk.name # " (" # sdk.latinName # ")\n";
            manifest #= "    Target: " # sdk.sdkTarget # " | Package: " # sdk.packageName # " v" # sdk.version # "\n";
            manifest #= "    Entry: " # sdk.entrypoint # "\n";
            manifest #= "    Query: " # sdk.registryQueryMethod # "\n";
            manifest #= "    Invoke: " # sdk.invocationPattern # "\n";
            manifest #= "    Example: " # sdk.exampleCall # "\n";
            manifest #= "    Trace: " # sdk.primitiveTrace # "\n\n";
        };

        manifest #= "═══════════════════════════════════════════════════════════════\n";
        manifest #= "ORCHESTRATION BINDINGS (" # Nat.toText(ORCHESTRATION_BINDINGS.size()) # ")\n";
        manifest #= "═══════════════════════════════════════════════════════════════\n";
        for (ob in ORCHESTRATION_BINDINGS.vals()) {
            manifest #= "  [" # ob.id # "] " # ob.name # " (" # ob.latinName # ")\n";
            manifest #= "    Ref: " # ob.orchestratorRef # " | Routing: " # ob.routingPolicy # "\n";
            manifest #= "    Fallback: " # ob.fallbackStrategy # "\n";
            manifest #= "    Trace: " # ob.primitiveTrace # "\n\n";
        };

        manifest #= "═══════════════════════════════════════════════════════════════\n";
        manifest #= "INVOCATION LIFECYCLE (" # Nat.toText(INVOCATION_LIFECYCLE.size()) # " stages)\n";
        manifest #= "═══════════════════════════════════════════════════════════════\n";
        for (lc in INVOCATION_LIFECYCLE.vals()) {
            manifest #= "  Stage " # Nat.toText(lc.stage) # ": " # lc.name # " (" # lc.latinName # ")\n";
            manifest #= "    " # lc.description # "\n";
            manifest #= "    In: " # lc.inputArtifact # " → Out: " # lc.outputArtifact # "\n";
            manifest #= "    Validation: " # lc.validationRule # "\n";
            manifest #= "    Trace: " # lc.primitiveTrace # "\n\n";
        };

        manifest #= "═══════════════════════════════════════════════════════════════\n";
        manifest #= "φ = " # Float.toText(PHI) # " — All protocols trace to φ\n";
        manifest #= "═══════════════════════════════════════════════════════════════\n";

        manifest;
    };
};
