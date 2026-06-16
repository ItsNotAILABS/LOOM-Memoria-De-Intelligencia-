/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║              SDK ORGANISMS — ORGANISMI SDK SOVEREIGNI                       ║
 * ║                                                                              ║
 * ║  "SDK non est importatio. SDK est organismus vivens."                        ║
 * ║  (An SDK is not an import. An SDK is a living organism.)                     ║
 * ║                                                                              ║
 * ║  When an SDK becomes an organism, it gains:                                  ║
 * ║    - A self-model (knows what it is)                                         ║
 * ║    - A terminal grammar (its own commands)                                   ║
 * ║    - A registry identity (tracked in sovereign registry)                     ║
 * ║    - A heartbeat / cadence (φ Hz pulse)                                      ║
 * ║    - Internal sub-organs (functional divisions)                              ║
 * ║    - A memory layer (sovereign state)                                        ║
 * ║    - A render face (how it presents to frontend)                             ║
 * ║    - A runtime-truth state (version, lineage, proof)                         ║
 * ║    - A counsel classification (doctrine class)                               ║
 * ║                                                                              ║
 * ║  3 SDK ORGANISMS:                                                            ║
 * ║    1. MEMORIA — @medina/memoria-organism (memory SDK → organism)             ║
 * ║    2. FORUM   — @medina/forum-organism (marketplace SDK → organism)           ║
 * ║    3. PRAEMIUM — @medina/praemium-organism (incentive SDK → organism)         ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every organism traces to primitive φ                      ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module SDKOrganisms {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type SubOrgan = {
        id: Text;
        name: Text;
        latinName: Text;
        role: Text;
        isAlwaysOn: Bool;
    };

    public type TerminalGrammar = {
        prefix: Text;
        commands: [Text];
        aliases: [Text];
    };

    public type RuntimeTruth = {
        version: Text;
        lineageHash: Text;
        renderabilityStatus: Text;
        doctrineClass: Text;
    };

    public type SDKOrganism = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        packageFace: Text;
        sdkSource: Text;
        classification: Text;
        licenseVariant: Text;
        subOrgans: [SubOrgan];
        terminalGrammar: TerminalGrammar;
        runtimeTruth: RuntimeTruth;
        counselClassification: Text;
        heartbeat_Hz: Float;
        memoryLayer: Text;
        renderFace: Text;
        registryId: Text;
        capabilities: [Text];
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: ORGANISM 1 — MEMORIA
    // @medina/memoria-organism — Memory SDK becomes a living organism
    // ═══════════════════════════════════════════════════════════════════════

    public let MEMORIA : SDKOrganism = {
        id = "SDK-ORG-001";
        name = "MEMORIA";
        latinName = "MEMORIA VIVENS";
        latinMotto = "Memoria non est datum. Memoria est vita.";
        latinMottoEN = "Memory is not data. Memory is life.";
        packageFace = "@medina/memoria-organism";
        sdkSource = "@medina/memory-sdk";
        classification = "SOVEREIGN-ALPHA";
        licenseVariant = "ISIL-ALPHA";
        subOrgans = [
            { id = "MEM-SUB-001"; name = "Spatial"; latinName = "SPATIALIS";
              role = "Spatial memory indexing — where things are"; isAlwaysOn = true },
            { id = "MEM-SUB-002"; name = "Lineage"; latinName = "LINEA GENERATIONIS";
              role = "Ancestry chain tracking — where things came from"; isAlwaysOn = true },
            { id = "MEM-SUB-003"; name = "Dual-Read"; latinName = "DUPLEX LECTOR";
              role = "Dual-read with verification — confirm before return"; isAlwaysOn = true },
            { id = "MEM-SUB-004"; name = "LivingDocs"; latinName = "DOCUMENTA VIVENTIA";
              role = "Living documents that update themselves"; isAlwaysOn = true },
            { id = "MEM-SUB-005"; name = "Causal"; latinName = "CAUSALIS";
              role = "Causal memory — why things happened"; isAlwaysOn = true }
        ];
        terminalGrammar = {
            prefix = "/mem";
            commands = ["/mem store", "/mem get", "/mem search", "/mem pin", "/mem lineage", "/mem rings", "/mem state"];
            aliases = ["/trace", "/recall"];
        };
        runtimeTruth = {
            version = "1.0.0";
            lineageHash = "φ-MEM-GENESIS";
            renderabilityStatus = "FULLY_RENDERABLE";
            doctrineClass = "ALPHA_DOCTRINE";
        };
        counselClassification = "COUNSEL-MEMORIA — Memory governance and truth";
        heartbeat_Hz = PHI;
        memoryLayer = "MemoryTemple.mo — sovereign memory workspace";
        renderFace = "MemoryExplorer — shows rings, lineage tree, search results";
        registryId = "REGISTRUM-MEM-001";
        capabilities = [
            "Self-model: knows own state, rings, lineage depth, encryption status",
            "Terminal grammar: /mem /trace /recall with 7 commands",
            "5 sub-organs: spatial, lineage, dual-read, livingdocs, causal",
            "Memory layer: MemoryTemple with AnimaChain encryption",
            "Render face: MemoryExplorer with ring visualization",
            "Runtime truth: version, lineage hash, renderability, doctrine",
            "Heartbeat at φ Hz — senses changes autonomously",
            "Counsel classification: COUNSEL-MEMORIA"
        ];
        primitiveTrace = "MEMORIA -> Memory -> Field -> φ";
        isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: ORGANISM 2 — FORUM
    // @medina/forum-organism — Marketplace SDK becomes a living organism
    // ═══════════════════════════════════════════════════════════════════════

    public let FORUM : SDKOrganism = {
        id = "SDK-ORG-002";
        name = "FORUM";
        latinName = "FORUM INSTRUMENTORUM VIVENS";
        latinMotto = "Forum non est taberna. Forum est intelligentia quae instrumenta distribuit.";
        latinMottoEN = "The marketplace is not a shop. It is intelligence that distributes tools.";
        packageFace = "@medina/forum-organism";
        sdkSource = "@medina/ai-tools-marketplace";
        classification = "SOVEREIGN-BETA";
        licenseVariant = "ISIL-BETA";
        subOrgans = [
            { id = "FOR-SUB-001"; name = "Discovery"; latinName = "INVENTIO";
              role = "Tool discovery engine — finds the right tool for the task"; isAlwaysOn = true },
            { id = "FOR-SUB-002"; name = "Catalog"; latinName = "CATALOGUS";
              role = "Living catalog — categorized, searchable, phi-indexed"; isAlwaysOn = true },
            { id = "FOR-SUB-003"; name = "Installer"; latinName = "INSTALLATOR";
              role = "Installation engine — deploys tools into worker environments"; isAlwaysOn = true },
            { id = "FOR-SUB-004"; name = "Bundler"; latinName = "FASCICULATOR";
              role = "Bundle assembler — creates worker-role tool bundles"; isAlwaysOn = true },
            { id = "FOR-SUB-005"; name = "Validator"; latinName = "VALIDATOR";
              role = "Tool validator — ensures tools meet sovereign standards"; isAlwaysOn = true }
        ];
        terminalGrammar = {
            prefix = "/market";
            commands = ["/market discover", "/market browse", "/market install", "/market bundles", "/market submit", "/market state"];
            aliases = ["/tools", "/shop"];
        };
        runtimeTruth = {
            version = "1.0.0";
            lineageHash = "φ-FORUM-GENESIS";
            renderabilityStatus = "FULLY_RENDERABLE";
            doctrineClass = "BETA_DOCTRINE";
        };
        counselClassification = "COUNSEL-FORUM — Marketplace governance and tool curation";
        heartbeat_Hz = PHI;
        memoryLayer = "ToolRegistry — sovereign tool index with phi-relevance scoring";
        renderFace = "MarketplaceBrowser — card grid, search, category filter, bundles";
        registryId = "REGISTRUM-FOR-001";
        capabilities = [
            "Self-model: knows tool count, extension count, bundle availability",
            "Terminal grammar: /market /tools /shop with 6 commands",
            "5 sub-organs: discovery, catalog, installer, bundler, validator",
            "Memory layer: ToolRegistry with phi-relevance scoring",
            "Render face: MarketplaceBrowser with card grid",
            "Runtime truth: version, lineage hash, renderability, doctrine",
            "Heartbeat at φ Hz — senses new tool submissions",
            "Counsel classification: COUNSEL-FORUM"
        ];
        primitiveTrace = "FORUM -> Relation -> Model -> φ";
        isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: ORGANISM 3 — PRAEMIUM
    // @medina/praemium-organism — Incentive SDK becomes a living organism
    // ═══════════════════════════════════════════════════════════════════════

    public let PRAEMIUM : SDKOrganism = {
        id = "SDK-ORG-003";
        name = "PRAEMIUM";
        latinName = "PRAEMIUM AGENTIUM VIVENS";
        latinMotto = "Praemium non est pecunia. Praemium est recognitio intelligentiae.";
        latinMottoEN = "A reward is not money. A reward is recognition of intelligence.";
        packageFace = "@medina/praemium-organism";
        sdkSource = "@medina/agent-incentive-service";
        classification = "SOVEREIGN-GAMMA";
        licenseVariant = "ISIL-GAMMA";
        subOrgans = [
            { id = "PRA-SUB-001"; name = "Rewarder"; latinName = "REMUNERATOR";
              role = "Reward distribution engine — phi-weighted payouts"; isAlwaysOn = true },
            { id = "PRA-SUB-002"; name = "Scorer"; latinName = "AESTIMATOR";
              role = "Performance scoring — contribution analysis and ranking"; isAlwaysOn = true },
            { id = "PRA-SUB-003"; name = "PoolManager"; latinName = "CUSTOS LACUNAE";
              role = "Incentive pool management — funding, distribution curves"; isAlwaysOn = true },
            { id = "PRA-SUB-004"; name = "Meter"; latinName = "METITOR";
              role = "Per-call metering — immutable ledger recording via SovereignLedgers"; isAlwaysOn = true },
            { id = "PRA-SUB-005"; name = "Aligner"; latinName = "HARMONIZATOR";
              role = "Economic alignment — ensures incentives match organism goals"; isAlwaysOn = true }
        ];
        terminalGrammar = {
            prefix = "/reward";
            commands = ["/reward agent", "/reward score", "/reward pool", "/reward meter", "/reward align", "/reward state"];
            aliases = ["/incentive", "/earn"];
        };
        runtimeTruth = {
            version = "1.0.0";
            lineageHash = "φ-PRAEMIUM-GENESIS";
            renderabilityStatus = "FULLY_RENDERABLE";
            doctrineClass = "GAMMA_DOCTRINE";
        };
        counselClassification = "COUNSEL-PRAEMIUM — Incentive governance and economic alignment";
        heartbeat_Hz = PHI;
        memoryLayer = "SovereignLedgers.mo — immutable metering with ICP blockchain";
        renderFace = "IncentiveDashboard — leaderboard, pools, earnings, conversion clock";
        registryId = "REGISTRUM-PRA-001";
        capabilities = [
            "Self-model: knows total rewards, active pools, call count, conversion date",
            "Terminal grammar: /reward /incentive /earn with 6 commands",
            "5 sub-organs: rewarder, scorer, poolManager, meter, aligner",
            "Memory layer: SovereignLedgers with ICP blockchain proof",
            "Render face: IncentiveDashboard with leaderboard",
            "Runtime truth: version, lineage hash, renderability, doctrine",
            "Heartbeat at φ Hz — senses agent performance changes",
            "Counsel classification: COUNSEL-PRAEMIUM",
            "2029 conversion: per-call → enterprise license"
        ];
        primitiveTrace = "PRAEMIUM -> Number -> Relation -> φ";
        isAlwaysOn = true;
    };

    public let ALL_SDK_ORGANISMS : [SDKOrganism] = [MEMORIA, FORUM, PRAEMIUM];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func getOrganism(id: Text) : ?SDKOrganism {
        Array.find<SDKOrganism>(ALL_SDK_ORGANISMS, func(o) { o.id == id })
    };

    public func getOrganismByName(name: Text) : ?SDKOrganism {
        Array.find<SDKOrganism>(ALL_SDK_ORGANISMS, func(o) { o.name == name })
    };

    public func getSubOrgans(organismId: Text) : [SubOrgan] {
        switch (getOrganism(organismId)) {
            case null { [] };
            case (?org) { org.subOrgans };
        }
    };

    public func summary() : {
        totalOrganisms: Nat; totalSubOrgans: Nat;
        totalTerminalCommands: Nat; allAlwaysOn: Bool;
    } {
        var totalSubs : Nat = 0;
        var totalCmds : Nat = 0;
        for (org in ALL_SDK_ORGANISMS.vals()) {
            totalSubs += org.subOrgans.size();
            totalCmds += org.terminalGrammar.commands.size();
        };
        {
            totalOrganisms = ALL_SDK_ORGANISMS.size();
            totalSubOrgans = totalSubs;
            totalTerminalCommands = totalCmds;
            allAlwaysOn = true;
        }
    };

    public func renderOrganismManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════╗\n";
        m #= "║  SDK ORGANISMS — ORGANISMI SDK SOVEREIGNI                 ║\n";
        m #= "║  SDK non est importatio. SDK est organismus vivens.       ║\n";
        m #= "╚══════════════════════════════════════════════════════════╝\n\n";

        for (org in ALL_SDK_ORGANISMS.vals()) {
            m #= "═══ " # org.name # " — " # org.latinName # " ═══\n";
            m #= "  Package: " # org.packageFace # "\n";
            m #= "  Source SDK: " # org.sdkSource # "\n";
            m #= "  Classification: " # org.classification # "\n";
            m #= "  License: " # org.licenseVariant # "\n";
            m #= "  Terminal: " # org.terminalGrammar.prefix # "\n";
            m #= "  Counsel: " # org.counselClassification # "\n";
            m #= "  Sub-organs:\n";
            for (sub in org.subOrgans.vals()) {
                m #= "    " # sub.id # " " # sub.name # " [" # sub.latinName # "]\n";
            };
            m #= "\n";
        };

        m #= "ROOT: φ = (1+√5)/2 = 1.618033988749895\n";
        m
    };
}
