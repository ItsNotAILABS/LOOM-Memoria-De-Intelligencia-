// ORGANISM CLI — ORGANISMUS TERMINALIS INTELLIGENS
// "Ego sum instrumentum vivum. Aedifico, installo, vigilo, custodio."
// (I am the living tool. I build, I install, I watch, I guard.)
//
// Sovereign terminal AI that auto-detects Chrome, builds and loads
// all 20 browser extensions unpacked. No manual steps. No GitHub Actions.
// The CLI IS the AI. 3 engines (Generator/Router/Builder).
// 20 Latin-named browser extensions. Self-contained. 24/7.
//
// Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module OrganismCLI {

    public let PHI : Float = 1.618033988749895;

    public let DOCTRINE : Text = "Ego sum instrumentum vivum. Aedifico, installo, vigilo, custodio. 20 extensiones. 3 motores. Unum mandatum.";
    public let DOCTRINE_EN : Text = "I am the living tool. I build, install, watch, guard. 20 extensions. 3 engines. One command.";

    // ═══════════════════════════════════════════════════════════════════════════
    // 3 AI ENGINES
    // ═══════════════════════════════════════════════════════════════════════════

    public type EngineKind = {
        #Generator;
        #Router;
        #Builder;
    };

    public type CLIEngine = {
        id: Text;
        name: Text;
        latinName: Text;
        kind: EngineKind;
        description: Text;
    };

    public let CLI_ENGINES : [CLIEngine] = [
        { id = "ENGINE-CLI-GEN"; name = "Extension Generator"; latinName = "GENERATOR EXTENSIONUM";
          kind = #Generator; description = "Scans extensions/ directory, validates manifest.json, generates build configs" },
        { id = "ENGINE-CLI-ROUTE"; name = "Chrome Router"; latinName = "ITINERATOR CHROMII";
          kind = #Router; description = "Auto-detects Chrome/Chromium installation, routes extension loading commands" },
        { id = "ENGINE-CLI-BUILD"; name = "Extension Builder"; latinName = "AEDIFICATOR EXTENSIONUM";
          kind = #Builder; description = "Builds extensions using worker threads, validates structures, deploys unpacked" },
    ];

    // ═══════════════════════════════════════════════════════════════════════════
    // 20 BROWSER EXTENSIONS
    // ═══════════════════════════════════════════════════════════════════════════

    public type BrowserExtension = {
        id: Text;
        name: Text;
        latinName: Text;
        dir: Text;
        domain: Text;
    };

    public let EXTENSIONS : [BrowserExtension] = [
        { id = "EXT-001"; name = "Medina Memory Temple";     latinName = "TEMPLUM MEMORIAE";        dir = "medina-memory-temple";       domain = "Memory storage and retrieval" },
        { id = "EXT-002"; name = "Medina Intelligence Wire"; latinName = "NEXUS INTELLIGENTIAE";     dir = "medina-intelligence-wire";   domain = "Frontend-Backend intelligence sync" },
        { id = "EXT-003"; name = "Medina Three Hearts";      latinName = "TRIA CORDA";               dir = "medina-three-hearts";        domain = "Three Hearts encryption routing" },
        { id = "EXT-004"; name = "Medina Shimmer Defense";    latinName = "SCINTILLA DEFENSIONIS";    dir = "medina-shimmer-defense";     domain = "Real-time shimmer defense layer" },
        { id = "EXT-005"; name = "Medina Mega Terminal";      latinName = "TERMINUS MAGNUS";          dir = "medina-mega-terminal";       domain = "Full terminal access in browser" },
        { id = "EXT-006"; name = "Medina Golden Ratio";       latinName = "RATIO AUREA";              dir = "medina-golden-ratio";        domain = "Phi-frequency overlay and visualization" },
        { id = "EXT-007"; name = "Medina Organism Body";      latinName = "CORPUS ORGANISMI";         dir = "medina-organism-body";       domain = "Organism health and status dashboard" },
        { id = "EXT-008"; name = "Medina SDK Manager";        latinName = "PRAEFECTUS SDK";           dir = "medina-sdk-manager";         domain = "SDK organism management and deployment" },
        { id = "EXT-009"; name = "Medina Protocol Registry";  latinName = "REGISTRUM PROTOCOLLORUM";  dir = "medina-protocol-registry";   domain = "Protocol inspection and testing" },
        { id = "EXT-010"; name = "Medina License Validator";   latinName = "VALIDATOR LICENTIAE";      dir = "medina-license-validator";   domain = "ISIL license compliance checking" },
        { id = "EXT-011"; name = "Medina Canister Factory";    latinName = "FABRICA CANISTRORUM";      dir = "medina-canister-factory";    domain = "Canister creation and deployment" },
        { id = "EXT-012"; name = "Medina Blockchain Layer";    latinName = "STRATUM CATENAE";          dir = "medina-blockchain-layer";    domain = "Blockchain substrate monitoring" },
        { id = "EXT-013"; name = "Medina Synapse Network";     latinName = "RETIS SYNAPSIUM";          dir = "medina-synapse-network";     domain = "Synapse organism connectivity map" },
        { id = "EXT-014"; name = "Medina Universe Domains";    latinName = "DOMINIA UNIVERSI";         dir = "medina-universe-domains";    domain = "Universe domain exploration" },
        { id = "EXT-015"; name = "Medina Marketplace";         latinName = "MERCATUS INSTRUMENTORUM";  dir = "medina-marketplace";         domain = "Callable tool marketplace browser" },
        { id = "EXT-016"; name = "Medina Orchestrator";        latinName = "ORCHESTRATOR DOMUUM";      dir = "medina-orchestrator";        domain = "House orchestration dashboard" },
        { id = "EXT-017"; name = "Medina Math Engine";         latinName = "MOTOR MATHEMATICAE";       dir = "medina-math-engine";         domain = "Math database terminal access" },
        { id = "EXT-018"; name = "Medina Care and Defense";    latinName = "CURA ET DEFENSIO";         dir = "medina-care-defense";        domain = "Care-Defense cooperation monitor" },
        { id = "EXT-019"; name = "Medina Agent Fleet";         latinName = "CLASSIS AGENTIUM";         dir = "medina-agent-fleet";         domain = "Agent fleet management and monitoring" },
        { id = "EXT-020"; name = "Medina Auto-Generate";       latinName = "MOTOR AUTO-GENERATIONIS";  dir = "medina-auto-generate";       domain = "Auto-generate calls engine dashboard" },
    ];

    // ═══════════════════════════════════════════════════════════════════════════
    // QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════════

    public func getExtensionById(id: Text) : ?BrowserExtension {
        Array.find<BrowserExtension>(EXTENSIONS, func(e) { e.id == id })
    };

    public func summary() : {
        name: Text; latinName: Text;
        totalEngines: Nat; totalExtensions: Nat;
        isAI: Bool; isAGI: Bool; isAlwaysOn: Bool;
        isUserFacing: Bool; isCrossSubstrate: Bool;
        frequency_Hz: Float; doctrine: Text;
        aiRole: Text;
    } {
        {
            name = "ORGANISMUS TERMINALIS";
            latinName = "ORGANISMUS TERMINALIS INTELLIGENS";
            totalEngines = CLI_ENGINES.size();
            totalExtensions = EXTENSIONS.size();
            isAI = true; isAGI = true; isAlwaysOn = true;
            isUserFacing = true; isCrossSubstrate = true;
            frequency_Hz = PHI;
            doctrine = DOCTRINE;
            aiRole = "Sovereign Terminal AI — builds, installs, validates, and manages all 20 browser extensions with AI intelligence 24/7";
        }
    };

    public func renderOrganismCLIManifest() : Text {
        var m = "=== ORGANISMUS TERMINALIS — SOVEREIGN TERMINAL AI ===\n";
        m #= DOCTRINE # "\n\n";
        m #= "--- 3 AI ENGINES ---\n";
        for (e in CLI_ENGINES.vals()) {
            m #= "  " # e.id # " " # e.latinName # " [" # (switch (e.kind) { case (#Generator) "GENERATOR"; case (#Router) "ROUTER"; case (#Builder) "BUILDER" }) # "]\n";
            m #= "    " # e.description # "\n";
        };
        m #= "\n--- 20 BROWSER EXTENSIONS ---\n";
        for (ext in EXTENSIONS.vals()) {
            m #= "  " # ext.id # " " # ext.latinName # " — " # ext.domain # "\n";
        };
        m #= "\nAI: true | AGI: true | 24/7: true | User-Facing: true | Cross-Substrate: true\n";
        m #= "=== END MANIFEST ===\n";
        m
    };
}