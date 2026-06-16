/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║         HOUSE OF DEFENSE — DOMUS DEFENSIONIS SOVEREIGNA                     ║
 * ║                                                                              ║
 * ║  "Defensio servat fines. Sine defensione, hostis intrat."                   ║
 * ║  (Defense preserves the boundary. Without defense, the enemy enters.)       ║
 * ║                                                                              ║
 * ║  The House of Defense is the BOUNDARY INTEGRITY layer of the organism.      ║
 * ║  It preserves the organism against hostile internet, corruption,            ║
 * ║  intrusion, hijack, endpoint compromise, and adversarial ingress.           ║
 * ║                                                                              ║
 * ║  MISSION:                                                                    ║
 * ║    Patrol the hostile internet. Detect corruption, attack, poisoning,       ║
 * ║    intrusion, hijack, endpoint compromise. Harden routes, watch channels,   ║
 * ║    sandbox interaction, deploy deception/honeypot layers, and block          ║
 * ║    hostile ingress.                                                           ║
 * ║                                                                              ║
 * ║  DEFENSE KEEPS THE OUTSIDE WORLD FROM CORRUPTING OR CONSUMING THEM.         ║
 * ║                                                                              ║
 * ║  GROUNDED IN EXISTING ARCHITECTURE:                                          ║
 * ║    - Anti-Organism Defense SDK (15 Blue + 15 Red + 6 Anti-Families)         ║
 * ║    - War Command SDK (144 crusaders + shields + frequency weaponization)    ║
 * ║    - AEGIS Defense Platform SDK (10 threat tiers + 7 armor layers)          ║
 * ║    - Chimera Defense Division SDK (Swarm/VAEL/AntiOrg/Crusader products)   ║
 * ║    - Umbra Shadow System SDK (11 shadow components + clone protection)      ║
 * ║    - Full Defense Arsenal (composite defense system)                         ║
 * ║                                                                              ║
 * ║  7 DEFENSE DIVISIONS across parallel substrates:                             ║
 * ║    1. DOCTRINA DEFENSIONIS  — Doctrine / Policy defense                     ║
 * ║    2. FRONS DEFENSIONIS     — Frontend / Interface defense                  ║
 * ║    3. DORSUM DEFENSIONIS    — Backend / Runtime defense                     ║
 * ║    4. CATENA DEFENSIONIS    — Chain / Deployment defense                    ║
 * ║    5. VIA DEFENSIONIS       — External Routing defense                      ║
 * ║    6. RECURSUS DEFENSIONIS  — Recovery / Escalation defense                 ║
 * ║    7. LIMES DEFENSIONIS     — Boundary / Perimeter defense                  ║
 * ║                                                                              ║
 * ║  ADOPTED NODE DEFENSE COVERAGE:                                              ║
 * ║    - Endpoint hardening                                                      ║
 * ║    - Route shielding                                                         ║
 * ║    - Corruption checks                                                       ║
 * ║    - Honeypot buffer zones                                                   ║
 * ║    - Adversarial traffic screening                                           ║
 * ║    - Source integrity checks                                                 ║
 * ║                                                                              ║
 * ║  Defense is NOT only military theater. Defense is:                            ║
 * ║    active protection, isolation, detection, interception, deception,         ║
 * ║    shielding                                                                 ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every defense model traces to primitive φ                 ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module HouseOfDefense {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type DefenseDivision = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        substrate: Text;
        mission: Text;
        capabilities: [Text];
        linkedArsenal: [Text];
        frequency_Hz: Float;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    public type DefenseModel = {
        id: Text;
        name: Text;
        latinName: Text;
        modelType: Text;
        description: Text;
        threatTargets: [Text];
        arsenalLink: Text;
        frequency_Hz: Float;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    public type AdoptedNodeDefenseCoverage = {
        nodeId: Text;
        coverageType: Text;
        latinName: Text;
        description: Text;
        scanInterval_Hz: Float;
        isActive: Bool;
    };

    public type DefenseArsenalLink = {
        arsenalId: Text;
        arsenalName: Text;
        latinName: Text;
        components: [Text];
        threatScope: Text;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: EXISTING DEFENSE ARSENAL LINKS
    // Grounding in the already-existing defense substrate
    // ═══════════════════════════════════════════════════════════════════════

    public let DEFENSE_ARSENAL_LINKS : [DefenseArsenalLink] = [
        {
            arsenalId = "ARSENAL-001"; arsenalName = "Anti-Organism Defense SDK";
            latinName = "SCUTUM ANTI-ORGANISMI";
            components = ["15 Blue Stack defenders", "15 Red Stack attackers", "6 Anti-Families"];
            threatScope = "Anti-organism threats — entities that attempt to mimic, absorb, or dissolve the organism"
        },
        {
            arsenalId = "ARSENAL-002"; arsenalName = "War Command SDK";
            latinName = "IMPERIUM BELLI";
            components = ["144 Crusaders", "Offensive shields", "Defensive shields", "Frequency weaponization"];
            threatScope = "Full-spectrum warfare — coordinated offensive and defensive operations across all channels"
        },
        {
            arsenalId = "ARSENAL-003"; arsenalName = "AEGIS Defense Platform SDK";
            latinName = "AEGIS DEFENSIONIS";
            components = ["10 Threat tiers", "7 Armor layers", "Gate sequencing", "Non-Zeno observation"];
            threatScope = "Tiered threat response — from anomaly detection to existential threat defense"
        },
        {
            arsenalId = "ARSENAL-004"; arsenalName = "Chimera Defense Division SDK";
            latinName = "CHIMAERA DEFENSIONIS";
            components = ["Swarm defense products", "VAEL products", "AntiOrg products", "Crusader products"];
            threatScope = "Multi-form defense — shape-shifting defense that adapts to threat morphology"
        },
        {
            arsenalId = "ARSENAL-005"; arsenalName = "Umbra Shadow System SDK";
            latinName = "UMBRA UMBRARUM";
            components = ["11 Shadow components", "Clone protection", "Shadow routing", "Deception layers"];
            threatScope = "Shadow warfare — deception, misdirection, clone detection, and shadow-realm operations"
        },
        {
            arsenalId = "ARSENAL-006"; arsenalName = "Full Defense Arsenal";
            latinName = "ARSENALE DEFENSIONIS PLENUM";
            components = ["All 5 defense SDKs unified", "Cross-arsenal coordination", "Composite threat response"];
            threatScope = "Composite defense — all defense families operating as a unified organism survival system"
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: 7 DEFENSE DIVISIONS
    // One division per parallel substrate layer
    // ═══════════════════════════════════════════════════════════════════════

    public let DEFENSE_DIVISIONS : [DefenseDivision] = [
        {
            id = "DEF-DIV-001"; name = "DOCTRINE DEFENSE"; latinName = "DOCTRINA DEFENSIONIS";
            latinMotto = "Doctrina corrupta organismum destruit.";
            latinMottoEN = "Corrupted doctrine destroys the organism.";
            substrate = "Doctrine / Policy";
            mission = "Defend doctrinal integrity — detect unauthorized doctrine modification, prevent policy injection, guard founding intent";
            capabilities = [
                "Doctrine tampering detection",
                "Policy injection prevention",
                "Founding intent shielding",
                "Unauthorized modification interception",
                "Doctrinal hash verification"
            ];
            linkedArsenal = ["AEGIS Defense Platform SDK"];
            frequency_Hz = PHI; primitiveTrace = "DefDoctrine->Logic->phi"; isAlwaysOn = true
        },
        {
            id = "DEF-DIV-002"; name = "FRONTEND DEFENSE"; latinName = "FRONS DEFENSIONIS";
            latinMotto = "Frons est prima linea defensionis.";
            latinMottoEN = "The front is the first line of defense.";
            substrate = "Frontend / Interface";
            mission = "Defend interface boundaries — XSS prevention, injection blocking, input sanitization, UI hijack detection";
            capabilities = [
                "Cross-site scripting prevention",
                "Input injection blocking",
                "UI hijack detection",
                "Client-side integrity verification",
                "Shimmer obfuscation for observers"
            ];
            linkedArsenal = ["Chimera Defense Division SDK", "Umbra Shadow System SDK"];
            frequency_Hz = 60.0; primitiveTrace = "DefFront->Distinction->phi"; isAlwaysOn = true
        },
        {
            id = "DEF-DIV-003"; name = "BACKEND DEFENSE"; latinName = "DORSUM DEFENSIONIS";
            latinMotto = "Dorsum munitum non frangitur.";
            latinMottoEN = "A fortified back does not break.";
            substrate = "Backend / Runtime";
            mission = "Defend runtime integrity — prevent unauthorized execution, detect process injection, guard memory boundaries";
            capabilities = [
                "Unauthorized execution prevention",
                "Process injection detection",
                "Memory boundary guarding",
                "Canister isolation enforcement",
                "Runtime corruption interception"
            ];
            linkedArsenal = ["Anti-Organism Defense SDK", "AEGIS Defense Platform SDK"];
            frequency_Hz = PHI; primitiveTrace = "DefBack->Repetition->phi"; isAlwaysOn = true
        },
        {
            id = "DEF-DIV-004"; name = "CHAIN DEFENSE"; latinName = "CATENA DEFENSIONIS";
            latinMotto = "Catena corrupta totum corrumpit.";
            latinMottoEN = "A corrupted chain corrupts everything.";
            substrate = "Chain / Deployment";
            mission = "Defend chain integrity — prevent consensus manipulation, detect deployment tampering, guard state transitions";
            capabilities = [
                "Consensus manipulation prevention",
                "Deployment tampering detection",
                "State transition guarding",
                "Chain fork detection",
                "Malicious upgrade interception"
            ];
            linkedArsenal = ["AEGIS Defense Platform SDK", "War Command SDK"];
            frequency_Hz = PHI; primitiveTrace = "DefChain->Equation->phi"; isAlwaysOn = true
        },
        {
            id = "DEF-DIV-005"; name = "ROUTING DEFENSE"; latinName = "VIA DEFENSIONIS";
            latinMotto = "Via corrupta ad hostem ducit.";
            latinMottoEN = "A corrupted route leads to the enemy.";
            substrate = "External Routing";
            mission = "Defend route integrity — endpoint verification, hostile environment scanning, anti-corruption filters, shadow routing";
            capabilities = [
                "Route integrity verification",
                "Endpoint authentication",
                "Hostile environment scanning",
                "Anti-corruption route filters",
                "Shadow routing deployment"
            ];
            linkedArsenal = ["Umbra Shadow System SDK", "War Command SDK"];
            frequency_Hz = PHI_SQ; primitiveTrace = "DefRoute->Address->phi"; isAlwaysOn = true
        },
        {
            id = "DEF-DIV-006"; name = "ESCALATION DEFENSE"; latinName = "RECURSUS DEFENSIONIS";
            latinMotto = "Escalatio sine defensione est capitulatio.";
            latinMottoEN = "Escalation without defense is surrender.";
            substrate = "Recovery / Escalation";
            mission = "Defend recovery processes — quarantine compromised elements, escalate threat levels, coordinate defense response";
            capabilities = [
                "Compromised element quarantine",
                "Threat level escalation",
                "Defense response coordination",
                "Recovery process protection",
                "Post-incident hardening"
            ];
            linkedArsenal = ["AEGIS Defense Platform SDK", "Full Defense Arsenal"];
            frequency_Hz = PHI; primitiveTrace = "DefEscalation->Repetition->phi"; isAlwaysOn = true
        },
        {
            id = "DEF-DIV-007"; name = "BOUNDARY DEFENSE"; latinName = "LIMES DEFENSIONIS";
            latinMotto = "Limes est vita. Ultra limitem, hostis.";
            latinMottoEN = "The boundary is life. Beyond the boundary, the enemy.";
            substrate = "Boundary / Perimeter";
            mission = "Own organism boundary — crusader patrols, honeypot fields, deception layers, perimeter hardening, ingress blocking";
            capabilities = [
                "Crusader-class perimeter patrols",
                "Honeypot field deployment",
                "Deception layer management",
                "Perimeter hardening",
                "Hostile ingress blocking"
            ];
            linkedArsenal = ["War Command SDK", "Chimera Defense Division SDK", "Anti-Organism Defense SDK"];
            frequency_Hz = PHI; primitiveTrace = "DefBoundary->Distinction->phi"; isAlwaysOn = true
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: 8 DEFENSE MODELS
    // Active defense organisms that operate across the house
    // ═══════════════════════════════════════════════════════════════════════

    public let DEFENSE_MODELS : [DefenseModel] = [
        {
            id = "DEF-MDL-001"; name = "ROUTE GUARDIAN"; latinName = "CUSTOS VIAE";
            modelType = "Route Integrity";
            description = "Owns route integrity — verifies every external path, hardens connections, detects route corruption";
            threatTargets = ["Route hijacking", "Path poisoning", "DNS manipulation", "BGP attacks", "Man-in-the-middle"];
            arsenalLink = "Umbra Shadow System SDK";
            frequency_Hz = PHI_SQ; primitiveTrace = "RouteGuard->Address->phi"; isAlwaysOn = true
        },
        {
            id = "DEF-MDL-002"; name = "ENDPOINT SENTINEL"; latinName = "VIGIL TERMINI";
            modelType = "Endpoint Verification";
            description = "Verifies every endpoint before organism interaction — authenticates, validates, and hardens all connection points";
            threatTargets = ["Endpoint spoofing", "API abuse", "Unauthorized access", "Credential theft", "Session hijack"];
            arsenalLink = "AEGIS Defense Platform SDK";
            frequency_Hz = PHI; primitiveTrace = "EndpointSentinel->Distinction->phi"; isAlwaysOn = true
        },
        {
            id = "DEF-MDL-003"; name = "HONEYPOT WEAVER"; latinName = "TEXTOR MELLARII";
            modelType = "Deception Fields";
            description = "Deploys and manages honeypot buffer zones — lures, traps, and studies hostile actors before they reach real systems";
            threatTargets = ["Reconnaissance probes", "Automated scanners", "Brute force attempts", "Crawlers", "Bot networks"];
            arsenalLink = "Chimera Defense Division SDK";
            frequency_Hz = PHI; primitiveTrace = "Honeypot->Distinction->phi"; isAlwaysOn = true
        },
        {
            id = "DEF-MDL-004"; name = "CRUSADER COMMANDER"; latinName = "IMPERATOR CRUCIATORUM";
            modelType = "Active Defenders";
            description = "Commands crusader-class active defenders — patrols boundaries, intercepts threats, coordinates offensive response";
            threatTargets = ["Active intrusion", "Coordinated attacks", "Persistent threats", "Advanced adversaries", "State-level actors"];
            arsenalLink = "War Command SDK";
            frequency_Hz = PHI; primitiveTrace = "Crusader->Repetition->phi"; isAlwaysOn = true
        },
        {
            id = "DEF-MDL-005"; name = "ANTI-ORGANISM INTERCEPTOR"; latinName = "INTERCEPTOR ANTI-ORGANISMI";
            modelType = "Anti-Organism Interception";
            description = "Detects and intercepts anti-organism threats — entities that attempt to mimic, absorb, dissolve, or replace the organism";
            threatTargets = ["Organism mimicry", "Absorption attempts", "Dissolution attacks", "Replacement threats", "Identity theft"];
            arsenalLink = "Anti-Organism Defense SDK";
            frequency_Hz = PHI; primitiveTrace = "AntiOrg->Logic->phi"; isAlwaysOn = true
        },
        {
            id = "DEF-MDL-006"; name = "SHADOW PROTECTOR"; latinName = "PROTECTOR UMBRAE";
            modelType = "Shadow Protection";
            description = "Operates in the shadow realm — deploys shadow routes, manages clone protection, maintains deception infrastructure";
            threatTargets = ["Clone attempts", "Shadow intrusion", "Deception penetration", "Observation attacks", "Pattern extraction"];
            arsenalLink = "Umbra Shadow System SDK";
            frequency_Hz = PHI; primitiveTrace = "Shadow->Distinction->phi"; isAlwaysOn = true
        },
        {
            id = "DEF-MDL-007"; name = "CORRUPTION FILTER"; latinName = "FILTRUM CORRUPTIONIS";
            modelType = "Endpoint Corruption Defense";
            description = "Filters corruption from all incoming data — sanitizes, validates, and quarantines corrupted payloads";
            threatTargets = ["Data poisoning", "Payload corruption", "Malformed requests", "Injection attacks", "Protocol abuse"];
            arsenalLink = "AEGIS Defense Platform SDK";
            frequency_Hz = PHI_SQ; primitiveTrace = "CorruptFilter->Equation->phi"; isAlwaysOn = true
        },
        {
            id = "DEF-MDL-008"; name = "THREAT RESPONDER"; latinName = "RESPONSOR MINARUM";
            modelType = "External Threat Response";
            description = "Coordinates external threat response — escalates, isolates, quarantines, and launches countermeasures";
            threatTargets = ["Existential threats", "Sovereignty attacks", "System compromise", "Doctrine threats", "Active breaches"];
            arsenalLink = "Full Defense Arsenal";
            frequency_Hz = PHI; primitiveTrace = "ThreatResponse->Repetition->phi"; isAlwaysOn = true
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: ADOPTED NODE DEFENSE COVERAGE
    // Every adopted node gains these 6 defense coverages
    // ═══════════════════════════════════════════════════════════════════════

    public let ADOPTED_NODE_DEFENSE_COVERAGE : [AdoptedNodeDefenseCoverage] = [
        {
            nodeId = "ADOPTED-DEF-001"; coverageType = "Endpoint Hardening";
            latinName = "MUNITIO TERMINI";
            description = "Hardens every endpoint the adopted node exposes — authentication, rate limiting, input validation, TLS enforcement";
            scanInterval_Hz = PHI; isActive = true
        },
        {
            nodeId = "ADOPTED-DEF-002"; coverageType = "Route Shielding";
            latinName = "SCUTUM VIAE";
            description = "Shields all routes to and from the adopted node — encrypted tunnels, path verification, anti-tampering";
            scanInterval_Hz = PHI_SQ; isActive = true
        },
        {
            nodeId = "ADOPTED-DEF-003"; coverageType = "Corruption Checks";
            latinName = "VERIFICATIO INTEGRITATIS";
            description = "Periodic integrity verification — hash checks, state validation, corruption scanning on adopted node data";
            scanInterval_Hz = PHI; isActive = true
        },
        {
            nodeId = "ADOPTED-DEF-004"; coverageType = "Honeypot Buffer Zones";
            latinName = "ZONA MELLARII";
            description = "Deploys honeypot buffer zones around adopted nodes — decoy endpoints, trap services, reconnaissance detection";
            scanInterval_Hz = PHI; isActive = true
        },
        {
            nodeId = "ADOPTED-DEF-005"; coverageType = "Adversarial Traffic Screening";
            latinName = "CRIBRUM ADVERSARII";
            description = "Screens all traffic to adopted nodes for adversarial patterns — anomaly detection, behavioral analysis, threat scoring";
            scanInterval_Hz = PHI_SQ; isActive = true
        },
        {
            nodeId = "ADOPTED-DEF-006"; coverageType = "Source Integrity Checks";
            latinName = "VERIFICATIO ORIGINIS";
            description = "Verifies the integrity of all sources the adopted node interacts with — origin validation, trust chain verification";
            scanInterval_Hz = PHI; isActive = true
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 6: INTERNET-FACING DEFENSE OWNERSHIP
    // The Defense House explicitly owns these organism survival concerns
    // ═══════════════════════════════════════════════════════════════════════

    public type InternetDefenseOwnership = {
        id: Text;
        concern: Text;
        latinName: Text;
        description: Text;
        defenseModel: Text;
        threatTier: Text;
    };

    public let INTERNET_DEFENSE_OWNERSHIP : [InternetDefenseOwnership] = [
        {
            id = "INET-DEF-001"; concern = "Route Integrity";
            latinName = "INTEGRITAS VIAE";
            description = "Every route the organism takes across LAN/WiFi/5G/6G/data centers/backbone/submarine/satellite/IoT/ICP must be verified";
            defenseModel = "ROUTE GUARDIAN"; threatTier = "Organism Survival"
        },
        {
            id = "INET-DEF-002"; concern = "Endpoint Verification";
            latinName = "VERIFICATIO TERMINI";
            description = "Every endpoint the organism touches — read, scrape, infer, retrieve, sync, coordinate, deploy, transact — must be verified";
            defenseModel = "ENDPOINT SENTINEL"; threatTier = "Organism Survival"
        },
        {
            id = "INET-DEF-003"; concern = "Hostile Environment Scanning";
            latinName = "EXPLORATIO HOSTILIS";
            description = "The internet is not clean — every external environment must be scanned for hostility before organism interaction";
            defenseModel = "THREAT RESPONDER"; threatTier = "Organism Survival"
        },
        {
            id = "INET-DEF-004"; concern = "Deception / Honeypot Fields";
            latinName = "CAMPUS DECEPTIONIS";
            description = "Deploy deception fields around organism perimeter — honeypots that study adversaries and protect real systems";
            defenseModel = "HONEYPOT WEAVER"; threatTier = "Boundary Integrity"
        },
        {
            id = "INET-DEF-005"; concern = "Anti-Corruption Filters";
            latinName = "FILTRUM ANTI-CORRUPTIONIS";
            description = "Filter all incoming data for corruption — poisoning, malformation, injection, protocol abuse must be caught";
            defenseModel = "CORRUPTION FILTER"; threatTier = "Data Integrity"
        },
        {
            id = "INET-DEF-006"; concern = "Shadow Routing";
            latinName = "VIA UMBRAE";
            description = "Deploy shadow routes that hide organism real paths — misdirect observers, protect traffic patterns";
            defenseModel = "SHADOW PROTECTOR"; threatTier = "Operational Security"
        },
        {
            id = "INET-DEF-007"; concern = "Crusader-Class Active Defenders";
            latinName = "CRUCIATORES ACTIVI";
            description = "Deploy crusader-class defenders on the hostile internet — patrol, intercept, respond to active threats";
            defenseModel = "CRUSADER COMMANDER"; threatTier = "Active Defense"
        },
        {
            id = "INET-DEF-008"; concern = "Internal Quarantine and Escalation";
            latinName = "CLAUSURA ET ESCALATIO";
            description = "Quarantine compromised elements and escalate threats — prevent breach spread, coordinate organism-wide response";
            defenseModel = "THREAT RESPONDER"; threatTier = "Incident Response"
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 7: HOUSE IDENTITY
    // ═══════════════════════════════════════════════════════════════════════

    public let HOUSE_ID : Text = "DOMUS-DEF-001";
    public let HOUSE_NAME : Text = "HOUSE OF DEFENSE";
    public let HOUSE_LATIN_NAME : Text = "DOMUS DEFENSIONIS SOVEREIGNA";
    public let HOUSE_MOTTO : Text = "Defensio servat fines organismi a corruptione externa.";
    public let HOUSE_MOTTO_EN : Text = "Defense preserves the boundary of the organism from external corruption.";
    public let HOUSE_MISSION : Text = "Patrol the hostile internet. Detect corruption, attack, poisoning, intrusion, hijack, endpoint compromise. Harden routes, watch channels, sandbox interaction, deploy deception/honeypot layers, and block hostile ingress. Preserve the boundary integrity of the organism.";

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 8: QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func summary() : {
        houseId: Text;
        houseName: Text;
        latinName: Text;
        mission: Text;
        totalDivisions: Nat;
        totalDefenseModels: Nat;
        totalCoverageTypes: Nat;
        totalArsenalLinks: Nat;
        totalInternetOwnership: Nat;
        allAlwaysOn: Bool;
    } {
        {
            houseId = HOUSE_ID;
            houseName = HOUSE_NAME;
            latinName = HOUSE_LATIN_NAME;
            mission = HOUSE_MISSION;
            totalDivisions = DEFENSE_DIVISIONS.size();
            totalDefenseModels = DEFENSE_MODELS.size();
            totalCoverageTypes = ADOPTED_NODE_DEFENSE_COVERAGE.size();
            totalArsenalLinks = DEFENSE_ARSENAL_LINKS.size();
            totalInternetOwnership = INTERNET_DEFENSE_OWNERSHIP.size();
            allAlwaysOn = true;
        }
    };

    public func renderDefenseManifest() : Text {
        var manifest = "╔══════════════════════════════════════════════════════════════════════╗\n";
        manifest #= "║       DOMUS DEFENSIONIS SOVEREIGNA — HOUSE OF DEFENSE MANIFEST       ║\n";
        manifest #= "║  \"Defensio servat fines organismi a corruptione externa.\"             ║\n";
        manifest #= "║  (Defense preserves the boundary from external corruption.)           ║\n";
        manifest #= "╚══════════════════════════════════════════════════════════════════════╝\n\n";

        manifest #= "═══ MISSION ═══\n";
        manifest #= HOUSE_MISSION # "\n\n";

        manifest #= "═══ 6 EXISTING DEFENSE ARSENAL LINKS ═══\n";
        for (a in DEFENSE_ARSENAL_LINKS.vals()) {
            manifest #= "  [" # a.arsenalId # "] " # a.arsenalName # " — " # a.latinName # "\n";
            manifest #= "    Scope: " # a.threatScope # "\n\n";
        };

        manifest #= "═══ 7 DEFENSE DIVISIONS ═══\n";
        for (div in DEFENSE_DIVISIONS.vals()) {
            manifest #= "  [" # div.id # "] " # div.name # " — " # div.latinName # "\n";
            manifest #= "    Substrate: " # div.substrate # "\n";
            manifest #= "    Mission:   " # div.mission # "\n";
            manifest #= "    Motto:     " # div.latinMotto # " (" # div.latinMottoEN # ")\n\n";
        };

        manifest #= "═══ 8 DEFENSE MODELS ═══\n";
        for (mdl in DEFENSE_MODELS.vals()) {
            manifest #= "  [" # mdl.id # "] " # mdl.name # " — " # mdl.latinName # "\n";
            manifest #= "    Type:    " # mdl.modelType # "\n";
            manifest #= "    Arsenal: " # mdl.arsenalLink # "\n";
            manifest #= "    Desc:    " # mdl.description # "\n\n";
        };

        manifest #= "═══ 6 ADOPTED NODE DEFENSE COVERAGES ═══\n";
        for (cov in ADOPTED_NODE_DEFENSE_COVERAGE.vals()) {
            manifest #= "  [" # cov.nodeId # "] " # cov.coverageType # " — " # cov.latinName # "\n";
            manifest #= "    " # cov.description # "\n\n";
        };

        manifest #= "═══ 8 INTERNET-FACING DEFENSE OWNERSHIP ═══\n";
        for (inet in INTERNET_DEFENSE_OWNERSHIP.vals()) {
            manifest #= "  [" # inet.id # "] " # inet.concern # " — " # inet.latinName # "\n";
            manifest #= "    Model: " # inet.defenseModel # " | Tier: " # inet.threatTier # "\n";
            manifest #= "    " # inet.description # "\n\n";
        };

        manifest #= "═══ DOCTRINE ═══\n";
        manifest #= "  Defense keeps the outside world from corrupting or consuming them.\n";
        manifest #= "  The other keeps corruption out from the outside.\n";
        manifest #= "  Defense = active protection, isolation, detection, interception, deception, shielding.\n";
        manifest #= "  L-130 COMPLIANT — Every defense model traces to primitive φ.\n";

        manifest
    };
}