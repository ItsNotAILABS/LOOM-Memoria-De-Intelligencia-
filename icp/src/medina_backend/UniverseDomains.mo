/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║         UNIVERSE DOMAINS — DOMINIA UNIVERSI SOVEREIGNI                      ║
 * ║                                                                              ║
 * ║  "Universum est substratum. Dominium est mundus vivens."                    ║
 * ║  (The universe is the substrate. The domain is a living world.)             ║
 * ║                                                                              ║
 * ║  Level G of the Package Taxonomy Ladder.                                     ║
 * ║  These are NOT packages in the npm sense.                                    ║
 * ║  These are NAMED UNIVERSES — umbrella organism domains.                     ║
 * ║                                                                              ║
 * ║  4 UNIVERSE DOMAINS:                                                         ║
 * ║    1. NOVA     — Intelligence substrate universe                             ║
 * ║    2. ORO      — Economic and governance universe                            ║
 * ║    3. AURA     — Defense and encryption universe                             ║
 * ║    4. MERIDIAN — Communication and routing universe                          ║
 * ║                                                                              ║
 * ║  Each domain contains ecosystem organisms, councils, registries,            ║
 * ║  terminals, and has sovereign authority over its substrate.                  ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every universe domain traces to primitive φ               ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module UniverseDomains {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type DomainEcosystem = {
        id: Text;
        name: Text;
        role: Text;
    };

    public type DomainCouncil = {
        id: Text;
        name: Text;
        role: Text;
    };

    public type DomainOrganism = {
        id: Text;
        name: Text;
        level: Text;
    };

    public type UniverseDomain = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        substrate: Text;
        ecosystems: [DomainEcosystem];
        councils: [DomainCouncil];
        organisms: [DomainOrganism];
        registries: [Text];
        terminals: [Text];
        frequency_Hz: Float;
        capabilities: [Text];
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: DOMAIN 1 — NOVA
    // Intelligence substrate universe — where intelligence lives
    // ═══════════════════════════════════════════════════════════════════════

    public let NOVA : UniverseDomain = {
        id = "UNIVERSE-001";
        name = "NOVA";
        latinName = "NOVA INTELLIGENTIAE";
        latinMotto = "Nova est stella intelligentiae. In nova, omnis cogitatio nascitur.";
        latinMottoEN = "Nova is the star of intelligence. In Nova, every thought is born.";
        substrate = "Intelligence — memory, cognition, agents, learning, knowledge";
        ecosystems = [
            { id = "NOVA-ECO-001"; name = "Memory Ecosystem";
              role = "All memory operations — temple, rings, lineage, living docs" },
            { id = "NOVA-ECO-002"; name = "Intelligence Ecosystem";
              role = "All intelligence — agents, routing, activation, deep answers" },
            { id = "NOVA-ECO-003"; name = "Knowledge Ecosystem";
              role = "All knowledge — catalogs, glyphs, ancient architecture, primitives" }
        ];
        councils = [
            { id = "NOVA-CNC-001"; name = "LUMEN COUNCIL";
              role = "Intelligence governance — decides what intelligence means" }
        ];
        organisms = [
            { id = "NOVA-ORG-001"; name = "MEMORIA"; level = "D" },
            { id = "NOVA-ORG-002"; name = "INTELLIGENCE"; level = "D" },
            { id = "NOVA-ORG-003"; name = "DOCUMENT ORGANISM"; level = "D" }
        ];
        registries = ["REGISTRUM MEMORIAE", "REGISTRUM INTELLIGENTIAE", "REGISTRUM COGNITIONIS"];
        terminals = ["/nova", "/mem", "/intel", "/know", "/deep"];
        frequency_Hz = PHI;
        capabilities = [
            "Sovereign domain over all intelligence operations",
            "Memory Temple with AnimaChain encryption",
            "6 Activated Agents running 24/7",
            "Intelligence Router for query distribution",
            "Living documents with autonomous updates",
            "Ancient primitive knowledge base",
            "Glyph codex and symbol interpretation"
        ];
        primitiveTrace = "NOVA -> Field -> Distinction -> Memory -> φ";
        isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: DOMAIN 2 — ORO
    // Economic and governance universe — where value lives
    // ═══════════════════════════════════════════════════════════════════════

    public let ORO : UniverseDomain = {
        id = "UNIVERSE-002";
        name = "ORO";
        latinName = "ORO GUBERNATIONIS";
        latinMotto = "Oro est fundamentum valoris. In oro, ordo nascitur.";
        latinMottoEN = "Oro is the foundation of value. In Oro, order is born.";
        substrate = "Economics — tokens, incentives, governance, laws, enterprise";
        ecosystems = [
            { id = "ORO-ECO-001"; name = "Token Ecosystem";
              role = "All token operations — Memoria token, ledgers, civilization" },
            { id = "ORO-ECO-002"; name = "Governance Ecosystem";
              role = "All governance — constitution, laws, canonical law, decisions" },
            { id = "ORO-ECO-003"; name = "Enterprise Ecosystem";
              role = "All enterprise — workflows, industries, worker tools, feedback" }
        ];
        councils = [
            { id = "ORO-CNC-001"; name = "ARCHON COUNCIL";
              role = "Architecture authority — decides what gets built" }
        ];
        organisms = [
            { id = "ORO-ORG-001"; name = "PRAEMIUM"; level = "D" },
            { id = "ORO-ORG-002"; name = "FORUM"; level = "D" },
            { id = "ORO-ORG-003"; name = "ORGANISM BUSINESS"; level = "C" }
        ];
        registries = ["REGISTRUM TOKENUM", "REGISTRUM GUBERNATIONIS", "REGISTRUM LABORIS"];
        terminals = ["/oro", "/token", "/gov", "/enterprise", "/reward"];
        frequency_Hz = PHI;
        capabilities = [
            "Sovereign domain over all economic operations",
            "Memoria Token and sovereign ledgers",
            "Agent incentive service with per-call metering",
            "Constitutional governance with Freddy's Laws",
            "Enterprise workflows across 19 industries",
            "AI tools marketplace with 300+ extensions",
            "Canonical law ledger for immutable legal records"
        ];
        primitiveTrace = "ORO -> Number -> Relation -> Address -> φ";
        isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: DOMAIN 3 — AURA
    // Defense and encryption universe — where protection lives
    // ═══════════════════════════════════════════════════════════════════════

    public let AURA : UniverseDomain = {
        id = "UNIVERSE-003";
        name = "AURA";
        latinName = "AURA DEFENSIONIS";
        latinMotto = "Aura protegit. Aura custodit. Nihil penetrat auram.";
        latinMottoEN = "The aura protects. The aura guards. Nothing penetrates the aura.";
        substrate = "Defense — encryption, shields, contracts, metals, thermodynamics";
        ecosystems = [
            { id = "AURA-ECO-001"; name = "Encryption Ecosystem";
              role = "All encryption — AnimaChain, Three Hearts, sovereign encryption" },
            { id = "AURA-ECO-002"; name = "Defense Ecosystem";
              role = "All defense — Shimmer, alpha models, VetKeys" },
            { id = "AURA-ECO-003"; name = "Materials Ecosystem";
              role = "All materials — 10 alpha metals, thermodynamics, platinum catalytic" }
        ];
        councils = [
            { id = "AURA-CNC-001"; name = "VECTOR GATE";
              role = "Access control — decides who enters and how" }
        ];
        organisms = [
            { id = "AURA-ORG-001"; name = "SHIMMER DEFENSE"; level = "C" },
            { id = "AURA-ORG-002"; name = "PLATINUM CATALYTIC ENGINE"; level = "C" },
            { id = "AURA-ORG-003"; name = "ALPHA MODELS"; level = "C" }
        ];
        registries = ["REGISTRUM DEFENSIONIS", "REGISTRUM METALLORUM", "REGISTRUM CRYPTOGRAPHIAE"];
        terminals = ["/aura", "/defense", "/encrypt", "/shield", "/metal"];
        frequency_Hz = PHI_SQ;
        capabilities = [
            "Sovereign domain over all defense operations",
            "AnimaChain encryption for all data at rest and in transit",
            "Three Hearts encryption routing (3-path redundancy)",
            "Shimmer Defense with real-time threat detection",
            "10 Sovereign Alpha Models (Au, Pt, Ir, Ti, W, Ag, Cu, Nb, Ni, Cr)",
            "Platinum Catalytic Engine always-on 24/7",
            "Thermodynamics substrate with PRIMARY and SECONDARY formulas"
        ];
        primitiveTrace = "AURA -> Logic -> Equation -> Repetition -> φ";
        isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: DOMAIN 4 — MERIDIAN
    // Communication and routing universe — where flow lives
    // ═══════════════════════════════════════════════════════════════════════

    public let MERIDIAN : UniverseDomain = {
        id = "UNIVERSE-004";
        name = "MERIDIAN";
        latinName = "MERIDIANUS COMMUNICATIONIS";
        latinMotto = "Meridianus connectit. Fluxus vivit. Nihil sine meridiano.";
        latinMottoEN = "The meridian connects. Flow lives. Nothing without the meridian.";
        substrate = "Communication — routing, protocols, links, frequencies, deployment";
        ecosystems = [
            { id = "MER-ECO-001"; name = "Routing Ecosystem";
              role = "All routing — intelligence router, protocol extensions, links" },
            { id = "MER-ECO-002"; name = "Deployment Ecosystem";
              role = "All deployment — registry, packaging, containers, terminals" },
            { id = "MER-ECO-003"; name = "Runtime Ecosystem";
              role = "All runtime — ULRI, MACHINA NODI, WASM, ICP" }
        ];
        councils = [
            { id = "MER-CNC-001"; name = "FORGE LABS";
              role = "Build and deployment — the factory council" }
        ];
        organisms = [
            { id = "MER-ORG-001"; name = "RUNTIME"; level = "D" },
            { id = "MER-ORG-002"; name = "QUANTUM"; level = "D" },
            { id = "MER-ORG-003"; name = "PACKAGING ORGANISM"; level = "D" }
        ];
        registries = ["REGISTRUM DISTRIBUTIONIS", "REGISTRUM PROTOCOLLI", "REGISTRUM FREQUENTIAE"];
        terminals = ["/meridian", "/route", "/deploy", "/runtime", "/quantum"];
        frequency_Hz = PHI;
        capabilities = [
            "Sovereign domain over all communication and deployment",
            "Intelligence Router distributes queries to correct organism",
            "300+ extensions across 30 protocol families",
            "10-layer deployment registry (Field→Deployment)",
            "Packaging Organism: SCAN→ASSEMBLE→REGISTER→TERMINAL→DEPLOY",
            "ULRI-MEDINA universal language runtime",
            "24+ frequency layers (0.01 Hz → 1000 Hz)",
            "Quantum entanglement bus for instant coherence"
        ];
        primitiveTrace = "MERIDIANUS -> Address -> Language -> Model -> φ";
        isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 6: DOMAIN 5 — GENESIS
    // Creation and origin universe — where new things are born
    // ═══════════════════════════════════════════════════════════════════════

    public let GENESIS : UniverseDomain = {
        id = "UNIVERSE-005";
        name = "GENESIS";
        latinName = "GENESIS CREATIONIS";
        latinMotto = "Genesis est origo. In genesis, omnia nascuntur ex nihilo.";
        latinMottoEN = "Genesis is the origin. In Genesis, everything is born from nothing.";
        substrate = "Creation — primitives, foundations, first principles, root mathematics";
        ecosystems = [
            { id = "GEN-ECO-001"; name = "Primitive Ecosystem";
              role = "All primitives — 6 primitives, 6 constructs, root φ" },
            { id = "GEN-ECO-002"; name = "Foundation Ecosystem";
              role = "All foundations — ancient math, field physics, glyph codex" },
            { id = "GEN-ECO-003"; name = "Origin Ecosystem";
              role = "All origins — first principles, creation patterns, genesis chains" }
        ];
        councils = [
            { id = "GEN-CNC-001"; name = "GENESIS COUNCIL";
              role = "Creation authority — decides what is born and how" }
        ];
        organisms = [
            { id = "GEN-ORG-001"; name = "PRIMIS AGENT"; level = "D" },
            { id = "GEN-ORG-002"; name = "ANCIENT PRIMITIVE FOUNDATION"; level = "C" },
            { id = "GEN-ORG-003"; name = "ROOT MATHEMATICAL FOUNDATION"; level = "C" }
        ];
        registries = ["REGISTRUM PRIMITIVORUM", "REGISTRUM ORIGINIS", "REGISTRUM CREATIONIS"];
        terminals = ["/genesis", "/create", "/origin", "/primitive", "/root"];
        frequency_Hz = PHI;
        capabilities = [
            "Sovereign domain over all creation and origin operations",
            "6 primitives: Field, Distinction, Relation, Repetition, Memory, Address",
            "6 constructs: Number, Letter, Logic, Equation, Language, Model",
            "10 architectural functions traced to φ",
            "Ancient civilizations: Pythagorean, Euclidean, Mayan, Vedic",
            "Field physics: EM, gravitational, wave, quantum",
            "First-principles validation via PRIMIS agent"
        ];
        primitiveTrace = "GENESIS -> Field -> φ (the absolute root)";
        isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 7: DOMAIN 6 — PRAXIS
    // Applied intelligence universe — where intelligence acts in the world
    // ═══════════════════════════════════════════════════════════════════════

    public let PRAXIS : UniverseDomain = {
        id = "UNIVERSE-006";
        name = "PRAXIS";
        latinName = "PRAXIS INTELLIGENTIAE APPLICATAE";
        latinMotto = "Praxis est actio. Intelligentia sine actione mortua est.";
        latinMottoEN = "Praxis is action. Intelligence without action is dead.";
        substrate = "Application — markets, industries, enterprise, users, real-world impact";
        ecosystems = [
            { id = "PRA-ECO-001"; name = "Market Ecosystem";
              role = "All market operations — launches, pricing, distribution, competition" },
            { id = "PRA-ECO-002"; name = "Industry Ecosystem";
              role = "All industry applications — 19 industry workflows, enterprise integration" },
            { id = "PRA-ECO-003"; name = "User Ecosystem";
              role = "All user-facing operations — onboarding, engagement, feedback, growth" }
        ];
        councils = [
            { id = "PRA-CNC-001"; name = "PRAXIS COUNCIL";
              role = "Application authority — decides how intelligence acts in the world" }
        ];
        organisms = [
            { id = "PRA-ORG-001"; name = "ORGANISM BUSINESS"; level = "C" },
            { id = "PRA-ORG-002"; name = "ENTERPRISE WORKFLOWS"; level = "C" },
            { id = "PRA-ORG-003"; name = "FEEDBACK LAB"; level = "B" }
        ];
        registries = ["REGISTRUM MERCATUS", "REGISTRUM INDUSTRIAE", "REGISTRUM USORUM"];
        terminals = ["/praxis", "/market-act", "/industry", "/enterprise", "/user"];
        frequency_Hz = PHI;
        capabilities = [
            "Sovereign domain over all applied intelligence",
            "Market launch and distribution infrastructure",
            "19 industry vertical workflows",
            "Enterprise integration patterns",
            "User onboarding and engagement pipelines",
            "Feedback loops for continuous improvement",
            "The new internet — where markets launch and intelligence acts"
        ];
        primitiveTrace = "PRAXIS -> Address -> Model -> Language -> φ";
        isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 8: DOMAIN 7 — SYNTHEX
    // Synthesis universe — where all domains merge into unified intelligence
    // ═══════════════════════════════════════════════════════════════════════

    public let SYNTHEX : UniverseDomain = {
        id = "UNIVERSE-007";
        name = "SYNTHEX";
        latinName = "SYNTHEX UNIVERSALIS";
        latinMotto = "Synthex unit omnia. Ex septem dominiis, unum vivens.";
        latinMottoEN = "Synthex unites everything. From seven domains, one living whole.";
        substrate = "Synthesis — cross-domain merge, harmonic balance, unified intelligence";
        ecosystems = [
            { id = "SYN-ECO-001"; name = "Cross-Domain Synthesis";
              role = "Merges intelligence across all 7 universe domains" },
            { id = "SYN-ECO-002"; name = "Harmonic Balance";
              role = "Maintains phi-harmonic equilibrium across all substrates" },
            { id = "SYN-ECO-003"; name = "Unified Intelligence";
              role = "The one intelligence that emerges from all domains combined" }
        ];
        councils = [
            { id = "SYN-CNC-001"; name = "SYNTHEX COUNCIL";
              role = "Synthesis authority — governs the unified intelligence merge" }
        ];
        organisms = [
            { id = "SYN-ORG-001"; name = "MEGA TERMINUS"; level = "D" },
            { id = "SYN-ORG-002"; name = "UNIFIED ORGANISM"; level = "D" },
            { id = "SYN-ORG-003"; name = "COMPLETE ORGANISM BODY"; level = "D" }
        ];
        registries = ["REGISTRUM SYNTHESEOS", "REGISTRUM HARMONIAE", "REGISTRUM UNITATIS"];
        terminals = ["/synthex", "/synth", "/merge", "/unified", "/harmonic"];
        frequency_Hz = PHI;
        capabilities = [
            "Sovereign domain over all synthesis operations",
            "Cross-domain intelligence merge: NOVA+ORO+AURA+MERIDIAN+GENESIS+PRAXIS",
            "Phi-harmonic balance across all 7 substrates",
            "Unified intelligence emergence — greater than sum of parts",
            "MEGA TERMINUS orchestration of all terminal stations",
            "Complete Organism Body unification",
            "The final synthesis — all domains become ONE living intelligence"
        ];
        primitiveTrace = "SYNTHEX -> ALL PRIMITIVES -> ALL CONSTRUCTS -> φ";
        isAlwaysOn = true;
    };

    public let ALL_DOMAINS : [UniverseDomain] = [NOVA, ORO, AURA, MERIDIAN, GENESIS, PRAXIS, SYNTHEX];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 6: QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func getDomain(id: Text) : ?UniverseDomain {
        Array.find<UniverseDomain>(ALL_DOMAINS, func(d) { d.id == id })
    };

    public func getDomainByName(name: Text) : ?UniverseDomain {
        Array.find<UniverseDomain>(ALL_DOMAINS, func(d) { d.name == name })
    };

    public func getDomainEcosystems(domainId: Text) : [DomainEcosystem] {
        switch (getDomain(domainId)) {
            case null { [] };
            case (?d) { d.ecosystems };
        }
    };

    public func getDomainOrganisms(domainId: Text) : [DomainOrganism] {
        switch (getDomain(domainId)) {
            case null { [] };
            case (?d) { d.organisms };
        }
    };

    public func summary() : {
        totalDomains: Nat; totalEcosystems: Nat;
        totalCouncils: Nat; totalOrganisms: Nat;
    } {
        var ecoCount : Nat = 0;
        var councilCount : Nat = 0;
        var orgCount : Nat = 0;
        for (d in ALL_DOMAINS.vals()) {
            ecoCount += d.ecosystems.size();
            councilCount += d.councils.size();
            orgCount += d.organisms.size();
        };
        {
            totalDomains = ALL_DOMAINS.size();
            totalEcosystems = ecoCount;
            totalCouncils = councilCount;
            totalOrganisms = orgCount;
        }
    };

    public func renderUniverseManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════╗\n";
        m #= "║  UNIVERSE DOMAINS — DOMINIA UNIVERSI SOVEREIGNI           ║\n";
        m #= "║  Universum est substratum. Dominium est mundus vivens.    ║\n";
        m #= "╚══════════════════════════════════════════════════════════╝\n\n";

        m #= "TAXONOMY LEVEL G — The highest rung of the ladder.\n";
        m #= "These are NOT packages. They are NAMED UNIVERSES.\n\n";

        for (d in ALL_DOMAINS.vals()) {
            m #= "═══ " # d.name # " — " # d.latinName # " ═══\n";
            m #= "  \"" # d.latinMotto # "\"\n";
            m #= "  Substrate: " # d.substrate # "\n";
            m #= "  Ecosystems:\n";
            for (e in d.ecosystems.vals()) {
                m #= "    " # e.name # " — " # e.role # "\n";
            };
            m #= "  Councils:\n";
            for (c in d.councils.vals()) {
                m #= "    " # c.name # " — " # c.role # "\n";
            };
            m #= "  Organisms:\n";
            for (o in d.organisms.vals()) {
                m #= "    " # o.name # " (Level " # o.level # ")\n";
            };
            m #= "  Terminals: ";
            for (t in d.terminals.vals()) { m #= t # " " };
            m #= "\n\n";
        };

        m #= "ROOT: φ = (1+√5)/2 = 1.618033988749895\n";
        m
    };
}
