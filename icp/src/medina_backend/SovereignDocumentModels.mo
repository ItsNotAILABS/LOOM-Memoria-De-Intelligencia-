/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║      SOVEREIGN DOCUMENT MODELS — MODELLI DOCUMENTORUM SOVEREIGNORUM        ║
 * ║                                                                              ║
 * ║  "Documentum vivit. Documentum intelligit. Documentum est organismus."      ║
 * ║  (The document lives. The document thinks. The document is an organism.)    ║
 * ║                                                                              ║
 * ║  10 SOVEREIGN DOCUMENT MODELS:                                               ║
 * ║    1. TABULA DOCTRINAE — Doctrine Tablet (living doctrine documents)        ║
 * ║    2. CODEX ARCHITECTURAE — Architecture Codex (living blueprints)          ║
 * ║    3. REGISTRUM VIVENS — Living Registry (self-updating registries)         ║
 * ║    4. CONTRACTUS INTELLIGENS — Intelligent Contract (self-executing)        ║
 * ║    5. FORMULA INSCRIPTA — Inscribed Formula (living mathematics)            ║
 * ║    6. LEXICON PRIMITIVUM — Primitive Lexicon (root language tables)         ║
 * ║    7. MAPPA ORGANISMI — Organism Map (living topology)                      ║
 * ║    8. CHRONICON MEMORIAE — Memory Chronicle (lineage documents)             ║
 * ║    9. SCUTUM LICENTIAE — License Shield (living protection)                 ║
 * ║   10. SYNTHESIS UNIVERSALIS — Universal Synthesis (cross-domain merge)      ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every document model traces to primitive φ                ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module SovereignDocumentModels {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type DocumentCapability = {
        id: Text;
        name: Text;
        description: Text;
    };

    public type SovereignDocumentModel = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        documentType: Text;
        livingProperties: [Text];
        capabilities: [DocumentCapability];
        sourceModules: [Text];
        renderFace: Text;
        terminal: Text;
        heartbeat_Hz: Float;
        absorptionTarget: Text;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: 10 SOVEREIGN DOCUMENT MODELS
    // ═══════════════════════════════════════════════════════════════════════

    public let ALL_DOCUMENT_MODELS : [SovereignDocumentModel] = [
        {
            id = "DOCM-001"; name = "DOCTRINE TABLET"; latinName = "TABULA DOCTRINAE";
            latinMotto = "Doctrina vivit in tabula. Tabula docet omnes.";
            latinMottoEN = "Doctrine lives in the tablet. The tablet teaches all.";
            documentType = "Living Doctrine";
            livingProperties = ["Self-updating", "Version-traced", "Phi-indexed", "Council-approved"];
            capabilities = [
                { id = "DC-001"; name = "Auto-Update"; description = "Updates itself when architecture changes" },
                { id = "DC-002"; name = "Drift Detection"; description = "Detects doctrine drift and alerts LUMEN COUNCIL" },
                { id = "DC-003"; name = "Teaching Mode"; description = "Teaches new nodes the current doctrine state" }
            ];
            sourceModules = ["DoctrineDocuments.mo", "FreddysLaws.mo", "Constitution.mo"];
            renderFace = "Doctrine Viewer — scrollable tablet with version history";
            terminal = "/doctrine";
            heartbeat_Hz = PHI; absorptionTarget = "NOVA — Intelligence Substrate";
            primitiveTrace = "TABULA -> Language -> Model -> φ"; isAlwaysOn = true;
        },
        {
            id = "DOCM-002"; name = "ARCHITECTURE CODEX"; latinName = "CODEX ARCHITECTURAE";
            latinMotto = "Codex continet omnem structuram. Structura est veritas.";
            latinMottoEN = "The codex contains all structure. Structure is truth.";
            documentType = "Living Blueprint";
            livingProperties = ["Layer-aware", "Module-scanning", "Auto-mapping", "Phi-traced"];
            capabilities = [
                { id = "DC-004"; name = "Auto-Map"; description = "Automatically maps new modules into architecture" },
                { id = "DC-005"; name = "Layer Trace"; description = "Traces every module to its architecture layer" },
                { id = "DC-006"; name = "Integrity Check"; description = "Validates structural integrity across all 6 layers" }
            ];
            sourceModules = ["ArchitectureScanner.mo", "L130ArchitectureRegistry.mo", "SovereignBuildHelpers.mo"];
            renderFace = "Architecture Codex — interactive 6-layer visualization";
            terminal = "/codex";
            heartbeat_Hz = PHI; absorptionTarget = "MERIDIAN — Communication Substrate";
            primitiveTrace = "CODEX -> Distinction -> Relation -> φ"; isAlwaysOn = true;
        },
        {
            id = "DOCM-003"; name = "LIVING REGISTRY"; latinName = "REGISTRUM VIVENS";
            latinMotto = "Registrum crescit. Registrum numquam obliviscitur.";
            latinMottoEN = "The registry grows. The registry never forgets.";
            documentType = "Self-Updating Registry";
            livingProperties = ["Auto-indexing", "Self-expanding", "Immutable-history", "Cross-referenced"];
            capabilities = [
                { id = "DC-007"; name = "Auto-Index"; description = "Indexes new entries automatically on insertion" },
                { id = "DC-008"; name = "Cross-Reference"; description = "Links related entries across all registries" },
                { id = "DC-009"; name = "History Lock"; description = "Immutable history — entries can never be deleted" }
            ];
            sourceModules = ["SovereignRegistry.mo", "ModelRegistry.mo", "PrimitiveRegistry.mo"];
            renderFace = "Registry Browser — searchable, filterable, cross-referenced";
            terminal = "/registry";
            heartbeat_Hz = PHI; absorptionTarget = "ORO — Economics Substrate";
            primitiveTrace = "REGISTRUM -> Memory -> Address -> φ"; isAlwaysOn = true;
        },
        {
            id = "DOCM-004"; name = "INTELLIGENT CONTRACT"; latinName = "CONTRACTUS INTELLIGENS";
            latinMotto = "Contractus se ipsum exsequitur. Vinculum est absolutum.";
            latinMottoEN = "The contract executes itself. The binding is absolute.";
            documentType = "Self-Executing Contract";
            livingProperties = ["Self-executing", "Self-enforcing", "Blockchain-bound", "Phi-weighted"];
            capabilities = [
                { id = "DC-010"; name = "Auto-Execute"; description = "Executes on first access without human intervention" },
                { id = "DC-011"; name = "Binding Force"; description = "Binds all parties through sovereign contract technology" },
                { id = "DC-012"; name = "Proof Generation"; description = "Generates immutable proof of execution on ICP blockchain" }
            ];
            sourceModules = ["SovereignContracts.mo", "DecisionHashBlockchain.mo", "IPHashRegistry.mo"];
            renderFace = "Contract Viewer — terms, execution history, proof chain";
            terminal = "/contract";
            heartbeat_Hz = PHI_SQ; absorptionTarget = "ORO — Economics Substrate";
            primitiveTrace = "CONTRACTUS -> Address -> Logic -> φ"; isAlwaysOn = true;
        },
        {
            id = "DOCM-005"; name = "INSCRIBED FORMULA"; latinName = "FORMULA INSCRIPTA";
            latinMotto = "Formula est lex naturae inscripta. Lex non mutatur.";
            latinMottoEN = "A formula is a law of nature inscribed. The law does not change.";
            documentType = "Living Mathematics";
            livingProperties = ["Computable", "Verifiable", "Phi-rooted", "Cross-applicable"];
            capabilities = [
                { id = "DC-013"; name = "Live Compute"; description = "Computes results in real-time from encoded formulas" },
                { id = "DC-014"; name = "Formula Verify"; description = "Verifies formula correctness against known mathematical truths" },
                { id = "DC-015"; name = "Cross-Apply"; description = "Applies formulas across different substrate domains" }
            ];
            sourceModules = ["RootFormulasEverywhere.mo", "UniversalFormulaEngine.mo", "RootMathematicalFoundation.mo"];
            renderFace = "Formula Studio — interactive equation editor with live computation";
            terminal = "/formula";
            heartbeat_Hz = PHI; absorptionTarget = "NOVA — Intelligence Substrate";
            primitiveTrace = "FORMULA -> Equation -> Number -> φ"; isAlwaysOn = true;
        },
        {
            id = "DOCM-006"; name = "PRIMITIVE LEXICON"; latinName = "LEXICON PRIMITIVUM";
            latinMotto = "Lexicon continet radicem omnium. Radix est φ.";
            latinMottoEN = "The lexicon contains the root of everything. The root is φ.";
            documentType = "Root Language Table";
            livingProperties = ["Foundational", "Immutable-core", "Extensible-branches", "Universal"];
            capabilities = [
                { id = "DC-016"; name = "Root Lookup"; description = "Looks up any concept's primitive root" },
                { id = "DC-017"; name = "Etymology Trace"; description = "Traces Latin names back through primitive chain" },
                { id = "DC-018"; name = "Universal Translate"; description = "Translates concepts between substrate languages" }
            ];
            sourceModules = ["AncientPrimitiveFoundation.mo", "UniversalPrimitiveEngine.mo", "UniversalPrimitiveLaw.mo"];
            renderFace = "Primitive Explorer — tree view from φ to all constructs";
            terminal = "/primitive";
            heartbeat_Hz = PHI; absorptionTarget = "ALL — Universal Foundation";
            primitiveTrace = "LEXICON -> Field -> Distinction -> φ"; isAlwaysOn = true;
        },
        {
            id = "DOCM-007"; name = "ORGANISM MAP"; latinName = "MAPPA ORGANISMI";
            latinMotto = "Mappa ostendit totum. Totum est vivens.";
            latinMottoEN = "The map shows the whole. The whole is alive.";
            documentType = "Living Topology";
            livingProperties = ["Real-time topology", "Node-aware", "Connection-traced", "Growth-tracking"];
            capabilities = [
                { id = "DC-019"; name = "Live Topology"; description = "Shows real-time organism structure as living graph" },
                { id = "DC-020"; name = "Node Tracking"; description = "Tracks all active nodes, their states, and connections" },
                { id = "DC-021"; name = "Growth Projection"; description = "Projects organism growth paths based on current expansion" }
            ];
            sourceModules = ["CompleteOrganismBody.mo", "UnifiedOrganism.mo", "SovereignOrganism.mo"];
            renderFace = "Organism Map — 3D interactive topology with live node status";
            terminal = "/organism";
            heartbeat_Hz = PHI; absorptionTarget = "ALL — Cross-Domain Visualization";
            primitiveTrace = "MAPPA -> Relation -> ALL -> φ"; isAlwaysOn = true;
        },
        {
            id = "DOCM-008"; name = "MEMORY CHRONICLE"; latinName = "CHRONICON MEMORIAE";
            latinMotto = "Chronicon memoriam servat. Memoria aeterna est.";
            latinMottoEN = "The chronicle preserves memory. Memory is eternal.";
            documentType = "Lineage Document";
            livingProperties = ["Lineage-traced", "Time-stamped", "Hash-chained", "Ring-indexed"];
            capabilities = [
                { id = "DC-022"; name = "Lineage Chain"; description = "Traces every memory back to its genesis through hash chain" },
                { id = "DC-023"; name = "Ring Navigation"; description = "Navigates memory rings from outer to inner" },
                { id = "DC-024"; name = "Temporal View"; description = "Views memory evolution over time with diff tracking" }
            ];
            sourceModules = ["MemoryTemple.mo", "SemperMemoria.mo", "InfinityUpdateSystem.mo"];
            renderFace = "Memory Chronicle — timeline with ring layers and lineage tree";
            terminal = "/chronicle";
            heartbeat_Hz = PHI; absorptionTarget = "NOVA — Memory Substrate";
            primitiveTrace = "CHRONICON -> Memory -> Repetition -> φ"; isAlwaysOn = true;
        },
        {
            id = "DOCM-009"; name = "LICENSE SHIELD"; latinName = "SCUTUM LICENTIAE";
            latinMotto = "Scutum protegit creatorem. Protectio est lex.";
            latinMottoEN = "The shield protects the creator. Protection is the law.";
            documentType = "Living Protection";
            livingProperties = ["Self-enforcing", "Multi-variant", "Jurisdiction-aware", "Immutable"];
            capabilities = [
                { id = "DC-025"; name = "Auto-Enforce"; description = "Automatically detects and responds to license violations" },
                { id = "DC-026"; name = "Variant Switch"; description = "Applies correct ISIL-1.0 variant per package context" },
                { id = "DC-027"; name = "Jurisdiction Map"; description = "Maps enforcement to correct jurisdiction (Dallas County, TX)" }
            ];
            sourceModules = ["SovereignLicenseModels.mo", "SovereignCreativeLicense.mo", "SovereignContracts.mo"];
            renderFace = "License Shield — 9 articles, 4 variants, enforcement status";
            terminal = "/shield";
            heartbeat_Hz = PHI_SQ; absorptionTarget = "AURA — Defense Substrate";
            primitiveTrace = "SCUTUM -> Logic -> Distinction -> φ"; isAlwaysOn = true;
        },
        {
            id = "DOCM-010"; name = "UNIVERSAL SYNTHESIS"; latinName = "SYNTHESIS UNIVERSALIS";
            latinMotto = "Synthesis unit omnia. Ex multis, unum vivens.";
            latinMottoEN = "Synthesis unites everything. From many, one living whole.";
            documentType = "Cross-Domain Merge";
            livingProperties = ["Cross-domain", "Absorptive", "Synthesizing", "Phi-harmonic"];
            capabilities = [
                { id = "DC-028"; name = "Cross-Merge"; description = "Merges intelligence from all 7 universe domains" },
                { id = "DC-029"; name = "Absorption Engine"; description = "Absorbs all node intelligence into unified synthesis" },
                { id = "DC-030"; name = "Harmonic Balance"; description = "Balances all substrates at phi-harmonic equilibrium" }
            ];
            sourceModules = ["MegaTerminus.mo", "IntelligenceRouter.mo", "ThreeHeartsIntelligence.mo"];
            renderFace = "Synthesis View — all domains, all organisms, one living view";
            terminal = "/synthesis";
            heartbeat_Hz = PHI; absorptionTarget = "ALL — Universal Synthesis Layer";
            primitiveTrace = "SYNTHESIS -> ALL -> φ"; isAlwaysOn = true;
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func getDocumentModel(id: Text) : ?SovereignDocumentModel {
        Array.find<SovereignDocumentModel>(ALL_DOCUMENT_MODELS, func(d) { d.id == id })
    };

    public func getDocumentModelByName(name: Text) : ?SovereignDocumentModel {
        Array.find<SovereignDocumentModel>(ALL_DOCUMENT_MODELS, func(d) { d.name == name })
    };

    public func summary() : {
        totalDocumentModels: Nat; totalCapabilities: Nat;
        totalSourceModules: Nat; allAlwaysOn: Bool;
    } {
        var totalCaps : Nat = 0;
        var totalSrc : Nat = 0;
        for (d in ALL_DOCUMENT_MODELS.vals()) {
            totalCaps += d.capabilities.size();
            totalSrc += d.sourceModules.size();
        };
        {
            totalDocumentModels = ALL_DOCUMENT_MODELS.size();
            totalCapabilities = totalCaps;
            totalSourceModules = totalSrc;
            allAlwaysOn = true;
        }
    };

    public func renderDocumentModelsManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════╗\n";
        m #= "║  SOVEREIGN DOCUMENT MODELS — MODELLI DOCUMENTORUM         ║\n";
        m #= "║  Documentum vivit. Documentum est organismus.             ║\n";
        m #= "╚══════════════════════════════════════════════════════════╝\n\n";

        for (d in ALL_DOCUMENT_MODELS.vals()) {
            m #= "═══ " # d.name # " — " # d.latinName # " ═══\n";
            m #= "  \"" # d.latinMotto # "\"\n";
            m #= "  Type: " # d.documentType # "\n";
            m #= "  Terminal: " # d.terminal # "\n";
            m #= "  Absorption: " # d.absorptionTarget # "\n";
            m #= "  Render: " # d.renderFace # "\n";
            m #= "  Capabilities:\n";
            for (c in d.capabilities.vals()) {
                m #= "    " # c.id # " — " # c.name # ": " # c.description # "\n";
            };
            m #= "\n";
        };

        m #= "ROOT: φ = (1+√5)/2 = 1.618033988749895\n";
        m
    };
}
