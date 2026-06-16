/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║            COUNCIL PACKAGES — CONCILIA PACKETORUM SOVEREIGNORUM              ║
 * ║                                                                              ║
 * ║  "Concilium est consensus organismorum. Consensus est vis."                  ║
 * ║  (A council is the consensus of organisms. Consensus is power.)              ║
 * ║                                                                              ║
 * ║  A COUNCIL is multiple organisms that must agree or coordinate.              ║
 * ║  Councils are ABOVE organisms in the hierarchy:                              ║
 * ║    Package → Organism → Council → Ecosystem                                 ║
 * ║                                                                              ║
 * ║  4 COUNCIL PACKAGES:                                                         ║
 * ║    1. LUMEN COUNCIL  — Intelligence governance council                       ║
 * ║    2. ARCHON COUNCIL — Architecture authority council                        ║
 * ║    3. FORGE LABS     — Build and deployment council                          ║
 * ║    4. VECTOR GATE    — Access control and routing council                    ║
 * ║                                                                              ║
 * ║  Each council coordinates multiple organisms via voting, consensus,          ║
 * ║  and phi-weighted decision protocols.                                        ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every council traces to primitive φ                       ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module CouncilPackages {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type CouncilMember = {
        organismId: Text;
        organismName: Text;
        role: Text;
        votingWeight: Float;
    };

    public type DecisionProtocol = {
        name: Text;
        quorum: Float;
        method: Text;
    };

    public type Council = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        packageFace: Text;
        members: [CouncilMember];
        decisionProtocol: DecisionProtocol;
        jurisdiction: Text;
        terminals: [Text];
        registryId: Text;
        heartbeat_Hz: Float;
        capabilities: [Text];
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: COUNCIL 1 — LUMEN COUNCIL
    // Intelligence governance — decides what intelligence means
    // ═══════════════════════════════════════════════════════════════════════

    public let LUMEN_COUNCIL : Council = {
        id = "COUNCIL-001";
        name = "LUMEN COUNCIL";
        latinName = "CONCILIUM LUMINIS";
        latinMotto = "Lumen intelligentiam gubernat. Concilium veritatem decernit.";
        latinMottoEN = "Light governs intelligence. The council decides truth.";
        packageFace = "@medina/lumen-council";
        members = [
            { organismId = "SDK-ORG-001"; organismName = "MEMORIA";
              role = "Memory truth arbiter — decides what is remembered";
              votingWeight = PHI },
            { organismId = "MEGA-TERM"; organismName = "TERMINUS MAGNUS";
              role = "Terminal orchestration — routes council decisions";
              votingWeight = 1.0 },
            { organismId = "ARCH-SCAN"; organismName = "ARCHITECTURE SCANNER";
              role = "Architecture observer — reports what exists";
              votingWeight = 1.0 },
            { organismId = "ACT-PRIMIS"; organismName = "PRIMIS (Activated Agent)";
              role = "First principles validator — tests against primitives";
              votingWeight = PHI }
        ];
        decisionProtocol = {
            name = "PHI-CONSENSUS";
            quorum = 0.618; // φ - 1 = inverse golden ratio
            method = "Phi-weighted voting with primitive validation";
        };
        jurisdiction = "All intelligence routing, memory truth, knowledge classification";
        terminals = ["/lumen", "/council", "/truth"];
        registryId = "REGISTRUM-COUNCIL-001";
        heartbeat_Hz = PHI;
        capabilities = [
            "Governs what counts as 'intelligence' in the organism",
            "Arbitrates memory truth — resolves conflicting memories",
            "Classifies knowledge by doctrine class",
            "Routes intelligence queries through proper channels",
            "Validates against 6 primitives before accepting",
            "Phi-weighted consensus — no simple majority"
        ];
        primitiveTrace = "LUMEN -> Field -> Distinction -> φ";
        isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: COUNCIL 2 — ARCHON COUNCIL
    // Architecture authority — decides what gets built and how
    // ═══════════════════════════════════════════════════════════════════════

    public let ARCHON_COUNCIL : Council = {
        id = "COUNCIL-002";
        name = "ARCHON COUNCIL";
        latinName = "CONCILIUM ARCHONTUM";
        latinMotto = "Archon architecturam custodit. Nihil sine consilio aedificatur.";
        latinMottoEN = "The archon guards architecture. Nothing is built without counsel.";
        packageFace = "@medina/archon-council";
        members = [
            { organismId = "BUILD-HELPER"; organismName = "ARCHITECTUS (Build Helper)";
              role = "Architecture keeper — enforces structural rules";
              votingWeight = PHI },
            { organismId = "DEPLOY-REG"; organismName = "DEPLOYMENT REGISTRY";
              role = "Registry authority — tracks all deployments across 10 layers";
              votingWeight = 1.0 },
            { organismId = "PKG-ORG"; organismName = "PACKAGING ORGANISM";
              role = "Package assembler — builds and deploys packages";
              votingWeight = 1.0 },
            { organismId = "L130-REG"; organismName = "L-130 REGISTRY";
              role = "Primitive compliance — ensures phi-trace on everything";
              votingWeight = PHI },
            { organismId = "BUILD-VERITAS"; organismName = "VERITAS (Build Helper)";
              role = "Truth validator — final check before deployment";
              votingWeight = PHI_SQ }
        ];
        decisionProtocol = {
            name = "ARCHON-VETO";
            quorum = 0.75;
            method = "Phi-weighted with VERITAS veto power";
        };
        jurisdiction = "Architecture decisions, build approvals, deployment gates, structural integrity";
        terminals = ["/archon", "/arch", "/build"];
        registryId = "REGISTRUM-COUNCIL-002";
        heartbeat_Hz = PHI;
        capabilities = [
            "Approves or rejects architectural changes",
            "Gates deployments through 10-layer registry",
            "Enforces L-130 phi-trace compliance",
            "VERITAS has absolute veto on truth violations",
            "Coordinates PackagingOrganism pipeline",
            "Maintains architecture doctrine integrity"
        ];
        primitiveTrace = "ARCHON -> Distinction -> Relation -> φ";
        isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: COUNCIL 3 — FORGE LABS
    // Build and deployment — the factory council
    // ═══════════════════════════════════════════════════════════════════════

    public let FORGE_LABS : Council = {
        id = "COUNCIL-003";
        name = "FORGE LABS";
        latinName = "FABRICA LABORATORIUM";
        latinMotto = "Fabrica creat. Laboratorium probat. Forge distribuit.";
        latinMottoEN = "The forge creates. The lab tests. Forge distributes.";
        packageFace = "@medina/forge-labs";
        members = [
            { organismId = "PKG-ORG"; organismName = "PACKAGING ORGANISM";
              role = "Package builder — assembles, registers, deploys";
              votingWeight = PHI },
            { organismId = "SDK-ORG-002"; organismName = "FORUM (Marketplace)";
              role = "Tool provider — supplies build tools";
              votingWeight = 1.0 },
            { organismId = "PKG-ECO-PACKAGER"; organismName = "PACKAGER (Architect Model)";
              role = "Assembly specialist — versions and publishes";
              votingWeight = 1.0 },
            { organismId = "PKG-ECO-CONTAINERIZER"; organismName = "CONTAINERIZER (Architect Model)";
              role = "Container builder — Docker/OCI images";
              votingWeight = 1.0 },
            { organismId = "PKG-ECO-TRANSLATOR"; organismName = "TRANSLATOR (Architect Model)";
              role = "Cross-runtime translator — Maven/NuGet/npm/RubyGems";
              votingWeight = 1.0 }
        ];
        decisionProtocol = {
            name = "FORGE-PIPELINE";
            quorum = 0.6;
            method = "Sequential pipeline with PACKAGING ORGANISM as lead";
        };
        jurisdiction = "Package building, container creation, cross-runtime translation, deployment";
        terminals = ["/forge", "/labs", "/build"];
        registryId = "REGISTRUM-COUNCIL-003";
        heartbeat_Hz = PHI;
        capabilities = [
            "Runs the SCAN→ASSEMBLE→REGISTER→TERMINAL→DEPLOY pipeline",
            "Builds Docker/OCI containers via CONTAINERIZER",
            "Translates packages to all external runtimes via TRANSLATOR",
            "Publishes to REGISTRUM APERTUM and REGISTRUM SOVEREIGNUM",
            "Creates subsystem terminals for new packages",
            "Assigns ISIL-1.0 license variants automatically"
        ];
        primitiveTrace = "FABRICA -> Repetition -> Address -> φ";
        isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: COUNCIL 4 — VECTOR GATE
    // Access control and intelligent routing
    // ═══════════════════════════════════════════════════════════════════════

    public let VECTOR_GATE : Council = {
        id = "COUNCIL-004";
        name = "VECTOR GATE";
        latinName = "PORTA VECTORIS";
        latinMotto = "Porta decernit. Vector dirigit. Accessus sovereign est.";
        latinMottoEN = "The gate decides. The vector directs. Access is sovereign.";
        packageFace = "@medina/vector-gate";
        members = [
            { organismId = "DEF-SHIMMER"; organismName = "SHIMMER DEFENSE";
              role = "Defense layer — blocks unauthorized access";
              votingWeight = PHI_SQ },
            { organismId = "SDK-ORG-003"; organismName = "PRAEMIUM (Incentive)";
              role = "Metering authority — tracks per-call access";
              votingWeight = 1.0 },
            { organismId = "INTEL-ROUTER"; organismName = "INTELLIGENCE ROUTER";
              role = "Routing engine — directs queries to correct organism";
              votingWeight = PHI },
            { organismId = "ANIMA-ENCRYPT"; organismName = "ANIMACHAIN ENCRYPTION";
              role = "Encryption authority — secures all channels";
              votingWeight = PHI },
            { organismId = "EMBODIED-EP"; organismName = "EMBODIED ENDPOINTS";
              role = "Endpoint guardian — gold-plated access points";
              votingWeight = 1.0 }
        ];
        decisionProtocol = {
            name = "GATE-DEFENSE";
            quorum = 0.8;
            method = "SHIMMER DEFENSE has override authority on security";
        };
        jurisdiction = "Access control, routing, encryption, metering, endpoint protection";
        terminals = ["/gate", "/vector", "/access"];
        registryId = "REGISTRUM-COUNCIL-004";
        heartbeat_Hz = PHI_SQ;
        capabilities = [
            "Controls all access to sovereign intelligence",
            "Routes queries through IntelligenceRouter to correct organism",
            "Meters per-call access for SOVEREIGN-GAMMA packages",
            "AnimaChain encrypts all inter-organism communication",
            "SHIMMER DEFENSE has override on security decisions",
            "Gold-plated endpoints cannot oxidize or corrupt"
        ];
        primitiveTrace = "PORTA -> Address -> Memory -> φ";
        isAlwaysOn = true;
    };

    public let ALL_COUNCILS : [Council] = [
        LUMEN_COUNCIL, ARCHON_COUNCIL, FORGE_LABS, VECTOR_GATE
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 6: QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func getCouncil(id: Text) : ?Council {
        Array.find<Council>(ALL_COUNCILS, func(c) { c.id == id })
    };

    public func getCouncilByName(name: Text) : ?Council {
        Array.find<Council>(ALL_COUNCILS, func(c) { c.name == name })
    };

    public func getCouncilMembers(councilId: Text) : [CouncilMember] {
        switch (getCouncil(councilId)) {
            case null { [] };
            case (?c) { c.members };
        }
    };

    public func summary() : {
        totalCouncils: Nat; totalMembers: Nat; totalTerminals: Nat;
    } {
        var totalMem : Nat = 0;
        var totalTerm : Nat = 0;
        for (c in ALL_COUNCILS.vals()) {
            totalMem += c.members.size();
            totalTerm += c.terminals.size();
        };
        {
            totalCouncils = ALL_COUNCILS.size();
            totalMembers = totalMem;
            totalTerminals = totalTerm;
        }
    };

    public func renderCouncilManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════╗\n";
        m #= "║  COUNCIL PACKAGES — CONCILIA PACKETORUM SOVEREIGNORUM     ║\n";
        m #= "║  Concilium est consensus organismorum.                    ║\n";
        m #= "╚══════════════════════════════════════════════════════════╝\n\n";

        m #= "HIERARCHY: Package → Organism → Council → Ecosystem\n\n";

        for (c in ALL_COUNCILS.vals()) {
            m #= "═══ " # c.name # " — " # c.latinName # " ═══\n";
            m #= "  Package: " # c.packageFace # "\n";
            m #= "  Jurisdiction: " # c.jurisdiction # "\n";
            m #= "  Protocol: " # c.decisionProtocol.name # " (" # c.decisionProtocol.method # ")\n";
            m #= "  Members:\n";
            for (member in c.members.vals()) {
                m #= "    " # member.organismName # " — " # member.role # "\n";
            };
            m #= "  Terminals: ";
            for (t in c.terminals.vals()) { m #= t # " " };
            m #= "\n\n";
        };

        m #= "ROOT: φ = (1+√5)/2 = 1.618033988749895\n";
        m
    };
}
