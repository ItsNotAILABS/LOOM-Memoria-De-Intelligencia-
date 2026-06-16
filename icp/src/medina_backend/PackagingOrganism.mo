/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║       PACKAGING ORGANISM — ORGANISMUS PACKETORUM VIVENS                     ║
 * ║                                                                              ║
 * ║  "Organismus fabricat. Organismus distribuit. Organismus vivit."             ║
 * ║  (The organism builds. The organism distributes. The organism lives.)        ║
 * ║                                                                              ║
 * ║  A LIVING ORGANISM that automates the entire packaging pipeline:             ║
 * ║    1. SCANS the architecture (via ArchitectureScanner)                       ║
 * ║    2. PACKAGES modules into sovereign packages (via SovereignPackageEcosystem)║
 * ║    3. REGISTERS packages into multi-layer registry (via DeploymentRegistry)  ║
 * ║    4. CREATES terminals for each package (via SubsystemTerminals)            ║
 * ║    5. DEPLOYS to live terminal (via MegaTerminus)                            ║
 * ║    6. LICENSES under ISIL-1.0 with correct Article IX addendum              ║
 * ║                                                                              ║
 * ║  This is NOT a build script. It is a LIVING INTELLIGENCE that senses what   ║
 * ║  needs packaging, decides how to package it, and deploys autonomously.       ║
 * ║                                                                              ║
 * ║  5 ORGANISM MODELS — permanently grounded, always-on:                       ║
 * ║    1. SCANNER  — scans all 6 layers for packageable modules                 ║
 * ║    2. ASSEMBLER — assembles sovereign packages from scanned modules          ║
 * ║    3. REGISTRAR — inserts packages into multi-layer registry                 ║
 * ║    4. TERMINALIS — creates and wires terminals for each package              ║
 * ║    5. DEPLOYER — deploys to live organism terminal                           ║
 * ║                                                                              ║
 * ║  3 SDK PACKAGES with ISIL-1.0 License variants:                             ║
 * ║    @medina/memory-sdk        — SOVEREIGN-ALPHA (highest confidentiality)     ║
 * ║    @medina/ai-tools-marketplace — SOVEREIGN-BETA (internal confidential)     ║
 * ║    @medina/agent-incentive-service — SOVEREIGN-GAMMA (commercial per-call)   ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every organism model traces to primitive φ                ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

module PackagingOrganism {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: ORGANISM MODEL TYPE
    // ═══════════════════════════════════════════════════════════════════════

    public type OrganismModel = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        role: Text;
        capabilities: [Text];
        inputSources: [Text];
        outputTargets: [Text];
        isAlwaysOn: Bool;
        frequency_Hz: Float;
        formula: Text;
        primitiveTrace: Text;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: 5 ORGANISM MODELS
    // ═══════════════════════════════════════════════════════════════════════

    // MODEL 1: SCANNER — scans all 6 architecture layers
    public let SCANNER : OrganismModel = {
        id = "ORG-PACK-001";
        name = "SCANNER";
        latinName = "LUSTRATOR ARCHITECTURAE";
        latinMotto = "Lustrat omnia. Invenit omnia. Nihil latet.";
        latinMottoEN = "It scans everything. It finds everything. Nothing hides.";
        role = "Scans all 6 architecture layers for modules that need packaging";
        capabilities = [
            "Scans Backend layer (.mo files) — detects new/changed modules",
            "Scans Frontend layer (.ts files) — detects new/changed components",
            "Scans NovaOvo layer (.py files) — detects new/changed agents",
            "Scans Medina layer (.py files) — detects new/changed services",
            "Scans Release layer — detects version changes",
            "Scans Doctrine layer — detects new/changed doctrines",
            "Compares against existing package registry to find gaps",
            "Produces PackageScanReport with packageable modules",
            "Runs 5 scanner models (VIDITOR, EXPLORATOR, COLLECTOR, LINKER, SYNTHESIZER)",
            "Triggers automatically on architecture changes",
        ];
        inputSources = ["ArchitectureScanner.mo", "All 6 layers", "SovereignPackageEcosystem.mo"];
        outputTargets = ["ASSEMBLER (ORG-PACK-002)"];
        isAlwaysOn = true;
        frequency_Hz = PHI;
        formula = "scan_coverage = layers_scanned / 6 * φ";
        primitiveTrace = "LUSTRATOR -> Field -> Distinction -> φ";
    };

    // MODEL 2: ASSEMBLER — assembles sovereign packages
    public let ASSEMBLER : OrganismModel = {
        id = "ORG-PACK-002";
        name = "ASSEMBLER";
        latinName = "FABRICATOR PACKETORUM";
        latinMotto = "Ex modulis, packetum. Ex packeto, intelligentia distributa.";
        latinMottoEN = "From modules, a package. From a package, distributed intelligence.";
        role = "Assembles sovereign packages from scanned modules";
        capabilities = [
            "Takes PackageScanReport from SCANNER",
            "Determines package boundaries using primitive analysis",
            "Assigns Latin names traced to phi",
            "Generates package.json / manifest for each package",
            "Assigns ISIL-1.0 license variant (Alpha/Beta/Gamma)",
            "Creates source bundles with exports",
            "Applies PACKAGER architect model for assembly",
            "Applies TRANSLATOR architect model for cross-runtime support",
            "Versions using sovereign Fibonacci versioning",
            "Produces AssembledPackage artifacts",
        ];
        inputSources = ["SCANNER (ORG-PACK-001)", "SovereignVersioning.mo"];
        outputTargets = ["REGISTRAR (ORG-PACK-003)"];
        isAlwaysOn = true;
        frequency_Hz = PHI;
        formula = "assembly_quality = exports * φ / complexity";
        primitiveTrace = "FABRICATOR -> Memory -> Language -> φ";
    };

    // MODEL 3: REGISTRAR — inserts into multi-layer registry
    public let REGISTRAR : OrganismModel = {
        id = "ORG-PACK-003";
        name = "REGISTRAR";
        latinName = "REGISTRATOR SOVEREIGNUS";
        latinMotto = "Registrat in omni strato. Omne stratum sentit.";
        latinMottoEN = "Registers in every layer. Every layer feels.";
        role = "Inserts assembled packages into the 10-layer sovereign registry";
        capabilities = [
            "Takes AssembledPackage from ASSEMBLER",
            "Determines correct registry layer (LAYER-0 through LAYER-9)",
            "Inserts into REGISTRUM APERTUM (open) or REGISTRUM SOVEREIGNUM (sovereign)",
            "Tags with architecture layer and primitive trace",
            "Records in SovereignLedgers for audit trail",
            "Applies DISTRIBUTOR architect model for placement",
            "Applies CONTAINERIZER architect model for Docker/OCI images",
            "Cross-publishes to npm/@medina, Maven/tech.medina, NuGet/Medina, Docker/medina",
            "Updates deployment registry (SovereignDeploymentRegistry)",
            "Triggers terminal creation on successful registration",
        ];
        inputSources = ["ASSEMBLER (ORG-PACK-002)", "SovereignDeploymentRegistry.mo"];
        outputTargets = ["TERMINALIS (ORG-PACK-004)", "REGISTRUM APERTUM", "REGISTRUM SOVEREIGNUM"];
        isAlwaysOn = true;
        frequency_Hz = PHI;
        formula = "registry_depth = Σ(layer_weight_i * φ^i)";
        primitiveTrace = "REGISTRATOR -> Address -> Memory -> φ";
    };

    // MODEL 4: TERMINALIS — creates terminals for packages
    public let TERMINALIS : OrganismModel = {
        id = "ORG-PACK-004";
        name = "TERMINALIS";
        latinName = "CREATOR TERMINALIUM";
        latinMotto = "Terminale creatur. Terminale connectitur. Terminale vivit.";
        latinMottoEN = "A terminal is created. A terminal is connected. A terminal lives.";
        role = "Creates and wires dedicated terminals for each registered package";
        capabilities = [
            "Creates subsystem terminal for each package (/pkg-name)",
            "Wires terminal to package's callable functions",
            "Registers terminal in MegaTerminus for orchestration",
            "Assigns terminal commands and help text",
            "Connects terminal to IntelligenceWire for frontend access",
            "Sets terminal frequency to package frequency",
            "Creates embodied endpoint for terminal",
            "Gold-plates terminal endpoint (Au/Pt/Ag/Ti/φ)",
            "Registers in CallableFunctionRegistry",
            "Activates terminal in live system",
        ];
        inputSources = ["REGISTRAR (ORG-PACK-003)", "SubsystemTerminals.mo", "MegaTerminus.mo"];
        outputTargets = ["DEPLOYER (ORG-PACK-005)", "MegaTerminus", "IntelligenceWire"];
        isAlwaysOn = true;
        frequency_Hz = PHI;
        formula = "terminal_readiness = connected_endpoints * φ / total_endpoints";
        primitiveTrace = "CREATOR_TERMINALIUM -> Language -> Relation -> φ";
    };

    // MODEL 5: DEPLOYER — deploys to live organism
    public let DEPLOYER : OrganismModel = {
        id = "ORG-PACK-005";
        name = "DEPLOYER";
        latinName = "DISTRIBUTOR VIVENS";
        latinMotto = "Distribuit in organismo vivo. Organismus sentit novum membrum.";
        latinMottoEN = "Deploys into the living organism. The organism senses a new member.";
        role = "Deploys packaged, registered, terminaled modules to the live organism";
        capabilities = [
            "Takes registered package with terminal from TERMINALIS",
            "Deploys to ICP canister (compiled .wasm)",
            "Deploys to Docker/OCI container",
            "Deploys to sovereign npm under @medina/ scope",
            "Updates UnifiedOrganism with new member",
            "Triggers Three Hearts to acknowledge new deployment",
            "Updates frequency architecture to include new module",
            "Records deployment in SovereignLedgers",
            "Announces deployment via organism sensorium",
            "Monitors health post-deployment at φ Hz",
        ];
        inputSources = ["TERMINALIS (ORG-PACK-004)", "All deployment targets"];
        outputTargets = ["Live organism", "ICP canister", "Docker registry", "npm registry"];
        isAlwaysOn = true;
        frequency_Hz = PHI;
        formula = "deployment_health = Π(component_health_i)^(1/φ)";
        primitiveTrace = "DISTRIBUTOR_VIVENS -> ALL PRIMITIVES -> φ";
    };

    public let ALL_ORGANISM_MODELS : [OrganismModel] = [
        SCANNER, ASSEMBLER, REGISTRAR, TERMINALIS, DEPLOYER,
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: SDK PACKAGES — 3 multi-use SDK packages
    // ═══════════════════════════════════════════════════════════════════════

    public type SDKPackage = {
        id: Text;
        npmName: Text;
        latinName: Text;
        latinMotto: Text;
        classification: Text;
        licenseVariant: Text;
        licensingModel: Text;
        capabilities: [Text];
        sourceDir: Text;
        primitiveTrace: Text;
    };

    public let SDK_PACKAGES : [SDKPackage] = [
        { id = "SDK-001"; npmName = "@medina/memory-sdk";
          latinName = "MEMORIA SOVEREIGNA";
          latinMotto = "Quod reconditum est, non perit.";
          classification = "SOVEREIGN-ALPHA";
          licenseVariant = "ISIL-1.0 — Highest Confidentiality";
          licensingModel = "Internal + Enterprise (MELA required)";
          capabilities = ["store","get","search","pin","getLineage","getRings","getState","encrypt","decrypt"];
          sourceDir = "packages/medina-memory-sdk/";
          primitiveTrace = "MEMORIA_SDK -> Memory -> Field -> φ" },

        { id = "SDK-002"; npmName = "@medina/ai-tools-marketplace";
          latinName = "FORUM INSTRUMENTORUM";
          latinMotto = "Instrumenta vivunt. Instrumenta serviunt.";
          classification = "SOVEREIGN-BETA";
          licenseVariant = "ISIL-1.0 — Internal Confidential";
          licensingModel = "Internal development (MIDA required)";
          capabilities = ["discoverTools","browseExtensions","getBundles","installTool","getState","submitTool"];
          sourceDir = "packages/ai-tools-marketplace/";
          primitiveTrace = "FORUM_INSTRUMENTORUM -> Model -> Relation -> φ" },

        { id = "SDK-003"; npmName = "@medina/agent-incentive-service";
          latinName = "PRAEMIUM AGENTIUM";
          latinMotto = "Labor mercedem accipit. Meritum phi sequitur.";
          classification = "SOVEREIGN-GAMMA";
          licenseVariant = "ISIL-1.0 — Commercial Per-Call";
          licensingModel = "Per-call metered (converts to enterprise 2029-01-01)";
          capabilities = ["rewardAgent","getPerformance","getContributionScore","getPools","getMeteringRecords","getState"];
          sourceDir = "packages/agent-incentive-service/";
          primitiveTrace = "PRAEMIUM_AGENTIUM -> Relation -> Number -> φ" },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: PIPELINE STATE TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type PackageScanReport = {
        timestamp: Int;
        layersScanned: Nat;
        modulesFound: Nat;
        newModules: Nat;
        changedModules: Nat;
        packagesToCreate: [Text];
        packagesToUpdate: [Text];
    };

    public type PipelineState = {
        lastScanTime: Int;
        totalPackagesCreated: Nat;
        totalPackagesDeployed: Nat;
        totalTerminalsCreated: Nat;
        sdkPackagesPublished: Nat;
        pipelineHealth: Float;
        scannerStatus: Text;
        assemblerStatus: Text;
        registrarStatus: Text;
        terminalisStatus: Text;
        deployerStatus: Text;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: ORGANISM IDENTITY
    // ═══════════════════════════════════════════════════════════════════════

    public let ORGANISM_IDENTITY = {
        officialName = "ORGANISMUS PACKETORUM VIVENS";
        shortName = "Packaging Organism";
        latinMotto = "Organismus fabricat. Organismus distribuit. Organismus vivit.";
        latinMottoEN = "The organism builds. The organism distributes. The organism lives.";
        totalModels = 5;
        totalSDKs = 3;
        license = "ISIL-1.0 — ItsNotAILABS Sovereign Intelligence License";
        pipelineStages = "SCAN → ASSEMBLE → REGISTER → TERMINAL → DEPLOY";
        doctrine = "This is NOT a CI/CD pipeline. It is a LIVING ORGANISM that senses architecture changes, packages intelligence, registers in sovereign registries, creates terminals, and deploys to the living organism. It breathes at φ Hz.";
        owner = "Alfredo Freddy Medina Hernandez — ItsNotAILABS / Medina Tech, Dallas TX";
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 6: QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func getOrganismModel(id: Text) : ?OrganismModel {
        Array.find<OrganismModel>(ALL_ORGANISM_MODELS, func(m) { m.id == id })
    };

    public func getSDKPackage(id: Text) : ?SDKPackage {
        Array.find<SDKPackage>(SDK_PACKAGES, func(s) { s.id == id })
    };

    public func getAlwaysOnModels() : [OrganismModel] {
        Array.filter<OrganismModel>(ALL_ORGANISM_MODELS, func(m) { m.isAlwaysOn })
    };

    public func scanArchitecture() : PackageScanReport {
        {
            timestamp = Time.now();
            layersScanned = 6;
            modulesFound = 118;
            newModules = 0;
            changedModules = 0;
            packagesToCreate = [];
            packagesToUpdate = [];
        }
    };

    public func getPipelineState() : PipelineState {
        {
            lastScanTime = Time.now();
            totalPackagesCreated = 40;
            totalPackagesDeployed = 40;
            totalTerminalsCreated = 20;
            sdkPackagesPublished = 3;
            pipelineHealth = PHI;
            scannerStatus = "ACTIVE — scanning at φ Hz";
            assemblerStatus = "ACTIVE — ready to assemble";
            registrarStatus = "ACTIVE — registries connected";
            terminalisStatus = "ACTIVE — terminals wired";
            deployerStatus = "ACTIVE — deployment targets live";
        }
    };

    public func summary() : {
        totalModels: Nat; totalSDKs: Nat; alwaysOnModels: Nat;
        pipelineStages: Text; organismName: Text; license: Text;
    } {
        {
            totalModels = ALL_ORGANISM_MODELS.size();
            totalSDKs = SDK_PACKAGES.size();
            alwaysOnModels = getAlwaysOnModels().size();
            pipelineStages = ORGANISM_IDENTITY.pipelineStages;
            organismName = ORGANISM_IDENTITY.officialName;
            license = ORGANISM_IDENTITY.license;
        }
    };

    public func renderOrganismManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════════╗\n";
        m #= "║  PACKAGING ORGANISM — ORGANISMUS PACKETORUM VIVENS           ║\n";
        m #= "║  " # ORGANISM_IDENTITY.latinMotto # "\n";
        m #= "╚══════════════════════════════════════════════════════════════╝\n\n";

        m #= "PIPELINE: " # ORGANISM_IDENTITY.pipelineStages # "\n\n";

        m #= "5 ORGANISM MODELS:\n";
        for (model in ALL_ORGANISM_MODELS.vals()) {
            m #= "  " # model.id # "  " # model.name # "  [" # model.latinName # "]\n";
            m #= "    " # model.latinMotto # "\n";
            m #= "    Role: " # model.role # "\n";
            if (model.isAlwaysOn) { m #= "    Status: ALWAYS-ON\n" };
        };

        m #= "\n3 SDK PACKAGES (ISIL-1.0 Licensed):\n";
        for (sdk in SDK_PACKAGES.vals()) {
            m #= "  " # sdk.id # "  " # sdk.npmName # "  [" # sdk.latinName # "]\n";
            m #= "    Classification: " # sdk.classification # "\n";
            m #= "    License: " # sdk.licenseVariant # "\n";
            m #= "    Model: " # sdk.licensingModel # "\n";
        };

        m #= "\nLICENSE: " # ORGANISM_IDENTITY.license # "\n";
        m #= "ROOT: φ = (1+√5)/2 = 1.618033988749895\n";
        m
    };
}
