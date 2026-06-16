/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║       ECOSYSTEM ORGANISMS — ORGANISMI ECOSYSTEMATIS SOVEREIGNI              ║
 * ║                                                                              ║
 * ║  "Ecosystema est summa. Continet omnia. Est organismus organismorum."        ║
 * ║  (The ecosystem is the totality. It contains everything. It is the organism  ║
 * ║   of organisms.)                                                             ║
 * ║                                                                              ║
 * ║  An ECOSYSTEM ORGANISM is the highest organizational unit.                   ║
 * ║  It contains: packages, organisms, councils, registries, terminals,         ║
 * ║  render surfaces, and proof structures.                                      ║
 * ║                                                                              ║
 * ║  HIERARCHY:                                                                  ║
 * ║    Package → SDK Organism → Council → ECOSYSTEM ORGANISM                     ║
 * ║                                                                              ║
 * ║  THE MEDINA ECOSYSTEM ORGANISM — CORPUS INTELLIGENTIAE VIVAE                ║
 * ║    The entire MEDINA intelligence architecture as ONE living organism         ║
 * ║    containing all packages, organisms, councils, registries, terminals,      ║
 * ║    render surfaces, and proof structures.                                    ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every ecosystem element traces to primitive φ             ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module EcosystemOrganisms {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type EcosystemPackageRef = {
        id: Text;
        name: Text;
        category: Text;
    };

    public type EcosystemOrganismRef = {
        id: Text;
        name: Text;
        latinName: Text;
        kind: Text; // "sdk-organism" | "packaging-organism" | "document-organism"
    };

    public type EcosystemCouncilRef = {
        id: Text;
        name: Text;
        memberCount: Nat;
    };

    public type EcosystemRegistry = {
        id: Text;
        name: Text;
        latinName: Text;
        layers: Nat;
        components: Nat;
    };

    public type EcosystemTerminal = {
        id: Text;
        name: Text;
        prefix: Text;
        commandCount: Nat;
    };

    public type RenderSurface = {
        id: Text;
        name: Text;
        latinName: Text;
        renderType: Text;
    };

    public type ProofStructure = {
        id: Text;
        name: Text;
        latinName: Text;
        proofType: Text;
        verifiable: Bool;
    };

    public type EcosystemOrganism = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        packageFace: Text;
        packages: [EcosystemPackageRef];
        organisms: [EcosystemOrganismRef];
        councils: [EcosystemCouncilRef];
        registries: [EcosystemRegistry];
        terminals: [EcosystemTerminal];
        renderSurfaces: [RenderSurface];
        proofStructures: [ProofStructure];
        heartbeat_Hz: Float;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: THE MEDINA ECOSYSTEM ORGANISM
    // CORPUS INTELLIGENTIAE VIVAE — The Living Body of Intelligence
    // ═══════════════════════════════════════════════════════════════════════

    public let MEDINA_ECOSYSTEM : EcosystemOrganism = {
        id = "ECO-001";
        name = "MEDINA ECOSYSTEM";
        latinName = "CORPUS INTELLIGENTIAE VIVAE";
        latinMotto = "Ecosystema est organismus organismorum. Vivit, sentit, crescit.";
        latinMottoEN = "The ecosystem is the organism of organisms. It lives, senses, grows.";
        packageFace = "@medina/ecosystem-organism";

        // All sovereign packages
        packages = [
            { id = "PKG-FAMILY-001"; name = "Memory Packages"; category = "memory" },
            { id = "PKG-FAMILY-002"; name = "Intelligence Packages"; category = "intelligence" },
            { id = "PKG-FAMILY-003"; name = "Defense Packages"; category = "defense" },
            { id = "PKG-FAMILY-004"; name = "Runtime Packages"; category = "runtime" },
            { id = "PKG-FAMILY-005"; name = "Governance Packages"; category = "governance" },
            { id = "PKG-FAMILY-006"; name = "Formula Packages"; category = "formula" },
            { id = "PKG-FAMILY-007"; name = "Organism Packages"; category = "organism" },
            { id = "PKG-FAMILY-008"; name = "Quantum Packages"; category = "quantum" },
            { id = "PKG-FAMILY-009"; name = "SDK Packages"; category = "sdk" },
            { id = "PKG-FAMILY-010"; name = "Enterprise Packages"; category = "enterprise" }
        ];

        // All organisms (SDK organisms + existing organisms)
        organisms = [
            { id = "SDK-ORG-001"; name = "MEMORIA"; latinName = "MEMORIA VIVENS";
              kind = "sdk-organism" },
            { id = "SDK-ORG-002"; name = "FORUM"; latinName = "FORUM INSTRUMENTORUM VIVENS";
              kind = "sdk-organism" },
            { id = "SDK-ORG-003"; name = "PRAEMIUM"; latinName = "PRAEMIUM AGENTIUM VIVENS";
              kind = "sdk-organism" },
            { id = "PACK-ORG"; name = "PACKAGING ORGANISM"; latinName = "ORGANISMUS PACKETORUM VIVENS";
              kind = "packaging-organism" },
            { id = "DOC-ORG"; name = "DOCUMENT ORGANISM"; latinName = "ORGANISMUS DOCUMENTORUM";
              kind = "document-organism" },
            { id = "UNIFIED-ORG"; name = "UNIFIED ORGANISM"; latinName = "ORGANISMUS UNIFICATUS";
              kind = "unified-organism" },
            { id = "COMPLETE-ORG"; name = "COMPLETE ORGANISM BODY"; latinName = "CORPUS COMPLETUM";
              kind = "body-organism" }
        ];

        // All councils
        councils = [
            { id = "COUNCIL-001"; name = "LUMEN COUNCIL"; memberCount = 4 },
            { id = "COUNCIL-002"; name = "ARCHON COUNCIL"; memberCount = 5 },
            { id = "COUNCIL-003"; name = "FORGE LABS"; memberCount = 5 },
            { id = "COUNCIL-004"; name = "VECTOR GATE"; memberCount = 5 }
        ];

        // All registries
        registries = [
            { id = "REG-001"; name = "REGISTRUM APERTUM"; latinName = "REGISTRUM APERTUM";
              layers = 1; components = 42 },
            { id = "REG-002"; name = "REGISTRUM SOVEREIGNUM"; latinName = "REGISTRUM SOVEREIGNUM";
              layers = 1; components = 18 },
            { id = "REG-003"; name = "DEPLOYMENT REGISTRY"; latinName = "REGISTRUM DISTRIBUTIONIS";
              layers = 10; components = 20 },
            { id = "REG-004"; name = "CALLABLE FUNCTION REGISTRY"; latinName = "TABULA FUNCTIONUM";
              layers = 10; components = 61 },
            { id = "REG-005"; name = "L-130 ARCHITECTURE REGISTRY"; latinName = "REGISTRUM ARCHITECTURAE";
              layers = 6; components = 130 },
            { id = "REG-006"; name = "PRIMITIVE REGISTRY"; latinName = "REGISTRUM PRIMITIVORUM";
              layers = 1; components = 12 },
            { id = "REG-007"; name = "IP HASH REGISTRY"; latinName = "REGISTRUM HASHIUM";
              layers = 1; components = 50 },
            { id = "REG-008"; name = "MODEL REGISTRY"; latinName = "REGISTRUM MODELLORUM";
              layers = 1; components = 100 }
        ];

        // All terminals
        terminals = [
            { id = "TERM-001"; name = "MEGA TERMINUS"; prefix = "/magnus"; commandCount = 9 },
            { id = "TERM-002"; name = "MEMORIA Terminal"; prefix = "/mem"; commandCount = 7 },
            { id = "TERM-003"; name = "FORUM Terminal"; prefix = "/market"; commandCount = 6 },
            { id = "TERM-004"; name = "PRAEMIUM Terminal"; prefix = "/reward"; commandCount = 6 },
            { id = "TERM-005"; name = "LUMEN Terminal"; prefix = "/lumen"; commandCount = 3 },
            { id = "TERM-006"; name = "ARCHON Terminal"; prefix = "/archon"; commandCount = 3 },
            { id = "TERM-007"; name = "FORGE Terminal"; prefix = "/forge"; commandCount = 3 },
            { id = "TERM-008"; name = "VECTOR Terminal"; prefix = "/gate"; commandCount = 3 },
            { id = "TERM-009"; name = "10 Terminal Stations"; prefix = "/station"; commandCount = 61 },
            { id = "TERM-010"; name = "Subsystem Terminals"; prefix = "/sub"; commandCount = 20 }
        ];

        // Render surfaces
        renderSurfaces = [
            { id = "RENDER-001"; name = "Memory Explorer"; latinName = "EXPLORATOR MEMORIAE";
              renderType = "Ring visualization + lineage tree + search" },
            { id = "RENDER-002"; name = "Marketplace Browser"; latinName = "NAVIGATOR FORI";
              renderType = "Card grid + category filter + bundles" },
            { id = "RENDER-003"; name = "Incentive Dashboard"; latinName = "TABULA PRAEMIORUM";
              renderType = "Leaderboard + pools + earnings + conversion clock" },
            { id = "RENDER-004"; name = "Architecture Map"; latinName = "MAPPA ARCHITECTURAE";
              renderType = "6-layer interactive architecture visualization" },
            { id = "RENDER-005"; name = "Package Ecosystem View"; latinName = "VISIO ECOSYSTEMATIS";
              renderType = "Package graph + registry browser + deployment status" },
            { id = "RENDER-006"; name = "Council Chamber"; latinName = "AULA CONCILII";
              renderType = "Council voting + decision history + member status" },
            { id = "RENDER-007"; name = "Design Studio"; latinName = "STUDIO DESIGNI";
              renderType = "10 design models + 50 phi-traced uses" },
            { id = "RENDER-008"; name = "Terminal Emulator"; latinName = "AEMULATOR TERMINALIS";
              renderType = "Full terminal with all commands across all organisms" }
        ];

        // Proof structures
        proofStructures = [
            { id = "PROOF-001"; name = "ICP Blockchain Registration"; latinName = "REGISTRATIO CATENA";
              proofType = "Immutable ownership and creation proof on Internet Computer";
              verifiable = true },
            { id = "PROOF-002"; name = "Decision Hash Blockchain"; latinName = "CATENA DECISIONUM";
              proofType = "Every decision recorded with hash chain";
              verifiable = true },
            { id = "PROOF-003"; name = "IP Hash Registry"; latinName = "REGISTRUM HASHIUM IP";
              proofType = "Intellectual property hash fingerprints";
              verifiable = true },
            { id = "PROOF-004"; name = "Lineage Hash Chain"; latinName = "CATENA LINEAE";
              proofType = "Every memory/entity traces back to genesis";
              verifiable = true },
            { id = "PROOF-005"; name = "ISIL-1.0 License Binding"; latinName = "VINCULUM LICENTIAE";
              proofType = "Self-executing sovereign contract — binds on first access";
              verifiable = true },
            { id = "PROOF-006"; name = "Phi Primitive Trace"; latinName = "VESTIGIUM PRIMITIVUM";
              proofType = "Every element traces to φ = (1+√5)/2";
              verifiable = true }
        ];

        heartbeat_Hz = PHI;
        primitiveTrace = "CORPUS INTELLIGENTIAE VIVAE -> ALL PRIMITIVES -> φ";
        isAlwaysOn = true;
    };

    public let ALL_ECOSYSTEMS : [EcosystemOrganism] = [MEDINA_ECOSYSTEM];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func getEcosystem(id: Text) : ?EcosystemOrganism {
        Array.find<EcosystemOrganism>(ALL_ECOSYSTEMS, func(e) { e.id == id })
    };

    public func getEcosystemPackages() : [EcosystemPackageRef] {
        MEDINA_ECOSYSTEM.packages
    };

    public func getEcosystemOrganisms() : [EcosystemOrganismRef] {
        MEDINA_ECOSYSTEM.organisms
    };

    public func getEcosystemCouncils() : [EcosystemCouncilRef] {
        MEDINA_ECOSYSTEM.councils
    };

    public func getEcosystemRegistries() : [EcosystemRegistry] {
        MEDINA_ECOSYSTEM.registries
    };

    public func getEcosystemTerminals() : [EcosystemTerminal] {
        MEDINA_ECOSYSTEM.terminals
    };

    public func getEcosystemRenderSurfaces() : [RenderSurface] {
        MEDINA_ECOSYSTEM.renderSurfaces
    };

    public func getEcosystemProofStructures() : [ProofStructure] {
        MEDINA_ECOSYSTEM.proofStructures
    };

    public func summary() : {
        totalPackageFamilies: Nat; totalOrganisms: Nat; totalCouncils: Nat;
        totalRegistries: Nat; totalTerminals: Nat; totalRenderSurfaces: Nat;
        totalProofStructures: Nat;
    } {
        {
            totalPackageFamilies = MEDINA_ECOSYSTEM.packages.size();
            totalOrganisms = MEDINA_ECOSYSTEM.organisms.size();
            totalCouncils = MEDINA_ECOSYSTEM.councils.size();
            totalRegistries = MEDINA_ECOSYSTEM.registries.size();
            totalTerminals = MEDINA_ECOSYSTEM.terminals.size();
            totalRenderSurfaces = MEDINA_ECOSYSTEM.renderSurfaces.size();
            totalProofStructures = MEDINA_ECOSYSTEM.proofStructures.size();
        }
    };

    public func renderEcosystemManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════╗\n";
        m #= "║  MEDINA ECOSYSTEM — CORPUS INTELLIGENTIAE VIVAE           ║\n";
        m #= "║  Ecosystema est organismus organismorum.                  ║\n";
        m #= "╚══════════════════════════════════════════════════════════╝\n\n";

        m #= "HIERARCHY: Package → Organism → Council → Ecosystem\n\n";

        m #= "10 PACKAGE FAMILIES:\n";
        for (p in MEDINA_ECOSYSTEM.packages.vals()) {
            m #= "  " # p.id # " — " # p.name # " [" # p.category # "]\n";
        };

        m #= "\n7 ORGANISMS:\n";
        for (o in MEDINA_ECOSYSTEM.organisms.vals()) {
            m #= "  " # o.id # " — " # o.name # " [" # o.latinName # "] (" # o.kind # ")\n";
        };

        m #= "\n4 COUNCILS:\n";
        for (c in MEDINA_ECOSYSTEM.councils.vals()) {
            m #= "  " # c.id # " — " # c.name # "\n";
        };

        m #= "\n8 REGISTRIES:\n";
        for (r in MEDINA_ECOSYSTEM.registries.vals()) {
            m #= "  " # r.id # " — " # r.name # " [" # r.latinName # "]\n";
        };

        m #= "\n10 TERMINALS:\n";
        for (t in MEDINA_ECOSYSTEM.terminals.vals()) {
            m #= "  " # t.id # " — " # t.name # " (" # t.prefix # ")\n";
        };

        m #= "\n8 RENDER SURFACES:\n";
        for (rs in MEDINA_ECOSYSTEM.renderSurfaces.vals()) {
            m #= "  " # rs.id # " — " # rs.name # " [" # rs.latinName # "]\n";
        };

        m #= "\n6 PROOF STRUCTURES:\n";
        for (ps in MEDINA_ECOSYSTEM.proofStructures.vals()) {
            m #= "  " # ps.id # " — " # ps.name # " [" # ps.latinName # "]\n";
        };

        m #= "\nROOT: φ = (1+√5)/2 = 1.618033988749895\n";
        m
    };
}
