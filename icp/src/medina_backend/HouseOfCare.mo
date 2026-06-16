/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║         HOUSE OF CARE — DOMUS CURAE SOVEREIGNA                              ║
 * ║                                                                              ║
 * ║  "Cura servat vitam interiorem. Sine cura, organismus perit."               ║
 * ║  (Care preserves the internal life. Without care, the organism perishes.)   ║
 * ║                                                                              ║
 * ║  The House of Care is a STRUCTURALLY NECESSARY layer of the organism.       ║
 * ║  Houses do not only generate. Houses do not only govern.                     ║
 * ║  Houses also maintain habitat integrity — and one house must explicitly     ║
 * ║  own organism care.                                                          ║
 * ║                                                                              ║
 * ║  MISSION:                                                                    ║
 * ║    Keep organisms, AIs, AGIs, adopted nodes, and internal worlds healthy.   ║
 * ║    Maintain recovery, continuity, habitat quality, error healing, and        ║
 * ║    safe operation. Protect internal development from collapse, overload,     ║
 * ║    drift, and environmental corruption.                                      ║
 * ║                                                                              ║
 * ║  CARE KEEPS THE INTERNAL BEINGS ALIVE ENOUGH TO DEVELOP.                    ║
 * ║                                                                              ║
 * ║  7 CARE DIVISIONS across parallel substrates:                                ║
 * ║    1. DOCTRINA CURAE    — Doctrine / Policy care                            ║
 * ║    2. FRONS CURAE       — Frontend / Interface care                         ║
 * ║    3. DORSUM CURAE      — Backend / Runtime care                            ║
 * ║    4. CATENA CURAE      — Chain / Deployment care                           ║
 * ║    5. VIA CURAE         — External Routing care                             ║
 * ║    6. RECURSUS CURAE    — Recovery / Escalation care                        ║
 * ║    7. HABITACULUM CURAE — Habitat / Environment care                        ║
 * ║                                                                              ║
 * ║  ADOPTED NODE CARE COVERAGE:                                                 ║
 * ║    - Continuity checks                                                       ║
 * ║    - Overload monitoring                                                     ║
 * ║    - Wellness / stability routing                                            ║
 * ║    - Restorative cycles                                                      ║
 * ║    - Safe habitat controls                                                   ║
 * ║                                                                              ║
 * ║  Care is NOT soft and abstract. Care is:                                     ║
 * ║    healing, continuity, stability, habitat, trust, safe growth              ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every care model traces to primitive φ                    ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module HouseOfCare {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type CareDivision = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        substrate: Text;
        mission: Text;
        capabilities: [Text];
        frequency_Hz: Float;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    public type CareModel = {
        id: Text;
        name: Text;
        latinName: Text;
        modelType: Text;
        description: Text;
        healingTargets: [Text];
        frequency_Hz: Float;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    public type AdoptedNodeCareCoverage = {
        nodeId: Text;
        coverageType: Text;
        latinName: Text;
        description: Text;
        checkInterval_Hz: Float;
        isActive: Bool;
    };

    public type CareCooperationLink = {
        careFunction: Text;
        defenseFunction: Text;
        cooperationProtocol: Text;
        description: Text;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: 7 CARE DIVISIONS
    // One division per parallel substrate layer
    // ═══════════════════════════════════════════════════════════════════════

    public let CARE_DIVISIONS : [CareDivision] = [
        {
            id = "CARE-DIV-001"; name = "DOCTRINE CARE"; latinName = "DOCTRINA CURAE";
            latinMotto = "Doctrina sana organismum sanat.";
            latinMottoEN = "Sound doctrine heals the organism.";
            substrate = "Doctrine / Policy";
            mission = "Ensure doctrinal health — detect drift, maintain alignment, preserve founding intent, heal policy corruption";
            capabilities = [
                "Doctrine drift detection",
                "Alignment health scoring",
                "Policy corruption healing",
                "Founding intent preservation",
                "Doctrinal continuity assurance"
            ];
            frequency_Hz = PHI; primitiveTrace = "CareDoctrine->Logic->phi"; isAlwaysOn = true
        },
        {
            id = "CARE-DIV-002"; name = "FRONTEND CARE"; latinName = "FRONS CURAE";
            latinMotto = "Frons sana mentem sanam ostendit.";
            latinMottoEN = "A healthy front shows a healthy mind.";
            substrate = "Frontend / Interface";
            mission = "Monitor interface health — detect UI degradation, maintain user experience integrity, heal rendering failures";
            capabilities = [
                "Interface health monitoring",
                "UI degradation detection",
                "Experience continuity assurance",
                "Rendering failure recovery",
                "Display wellness routing"
            ];
            frequency_Hz = 60.0; primitiveTrace = "CareFront->Field->phi"; isAlwaysOn = true
        },
        {
            id = "CARE-DIV-003"; name = "BACKEND CARE"; latinName = "DORSUM CURAE";
            latinMotto = "Dorsum forte organismum portat.";
            latinMottoEN = "A strong back carries the organism.";
            substrate = "Backend / Runtime";
            mission = "Maintain runtime health — detect overload, manage resource wellness, heal computation failures, ensure continuity";
            capabilities = [
                "Runtime overload detection",
                "Resource wellness management",
                "Computation failure healing",
                "Process continuity assurance",
                "Memory health monitoring"
            ];
            frequency_Hz = PHI; primitiveTrace = "CareBack->Repetition->phi"; isAlwaysOn = true
        },
        {
            id = "CARE-DIV-004"; name = "CHAIN CARE"; latinName = "CATENA CURAE";
            latinMotto = "Catena integra, veritas integra.";
            latinMottoEN = "An intact chain, an intact truth.";
            substrate = "Chain / Deployment";
            mission = "Ensure deployment health — detect chain corruption, maintain deployment continuity, heal consensus failures";
            capabilities = [
                "Chain integrity health checks",
                "Deployment continuity assurance",
                "Consensus failure recovery",
                "State healing and rollback",
                "Canister wellness monitoring"
            ];
            frequency_Hz = PHI; primitiveTrace = "CareChain->Equation->phi"; isAlwaysOn = true
        },
        {
            id = "CARE-DIV-005"; name = "ROUTING CARE"; latinName = "VIA CURAE";
            latinMotto = "Via sana ad destinatum ducit.";
            latinMottoEN = "A healthy route leads to the destination.";
            substrate = "External Routing";
            mission = "Maintain route health — detect path degradation, ensure safe external traversal, heal broken connections";
            capabilities = [
                "Route health monitoring",
                "Path degradation detection",
                "Connection failure healing",
                "Safe traversal assurance",
                "External sync wellness"
            ];
            frequency_Hz = PHI_SQ; primitiveTrace = "CareRoute->Address->phi"; isAlwaysOn = true
        },
        {
            id = "CARE-DIV-006"; name = "RECOVERY CARE"; latinName = "RECURSUS CURAE";
            latinMotto = "Recursus est vita post mortem.";
            latinMottoEN = "Recovery is life after death.";
            substrate = "Recovery / Escalation";
            mission = "Own all recovery loops — error healing, state restoration, escalation management, crash recovery, graceful degradation";
            capabilities = [
                "Error healing loops",
                "State restoration protocols",
                "Escalation management",
                "Crash recovery orchestration",
                "Graceful degradation control"
            ];
            frequency_Hz = PHI; primitiveTrace = "CareRecovery->Repetition->phi"; isAlwaysOn = true
        },
        {
            id = "CARE-DIV-007"; name = "HABITAT CARE"; latinName = "HABITACULUM CURAE";
            latinMotto = "Habitaculum sanum vitam sustinet.";
            latinMottoEN = "A healthy habitat sustains life.";
            substrate = "Habitat / Environment";
            mission = "Maintain habitat integrity — safe growth conditions, environmental quality, temperature regulation, resource availability";
            capabilities = [
                "Habitat integrity maintenance",
                "Safe growth condition assurance",
                "Environmental quality monitoring",
                "Resource availability management",
                "Organism environment optimization"
            ];
            frequency_Hz = PHI; primitiveTrace = "CareHabitat->Field->phi"; isAlwaysOn = true
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: 7 CARE MODELS
    // Living care organisms that operate across the house
    // ═══════════════════════════════════════════════════════════════════════

    public let CARE_MODELS : [CareModel] = [
        {
            id = "CARE-MDL-001"; name = "HEALER"; latinName = "SANATOR";
            modelType = "Active Healing";
            description = "Detects damage, errors, corruption in organism internals and applies targeted healing protocols";
            healingTargets = ["Runtime errors", "State corruption", "Logic drift", "Memory leaks", "Process failures"];
            frequency_Hz = PHI; primitiveTrace = "Healer->Repetition->phi"; isAlwaysOn = true
        },
        {
            id = "CARE-MDL-002"; name = "CONTINUITY KEEPER"; latinName = "CUSTOS CONTINUITATIS";
            modelType = "Continuity Assurance";
            description = "Ensures unbroken operational continuity — monitors heartbeats, checks liveness, restores interrupted processes";
            healingTargets = ["Heartbeat failures", "Process interruptions", "State gaps", "Sync breaks", "Liveness loss"];
            frequency_Hz = PHI; primitiveTrace = "Continuity->Repetition->phi"; isAlwaysOn = true
        },
        {
            id = "CARE-MDL-003"; name = "STABILITY ANCHOR"; latinName = "ANCORA STABILITATIS";
            modelType = "Stability Control";
            description = "Prevents oscillation, overload, runaway processes — keeps the organism within safe operating bounds";
            healingTargets = ["Oscillation", "Overload conditions", "Runaway processes", "Resource exhaustion", "Thermal runaway"];
            frequency_Hz = PHI; primitiveTrace = "Stability->Equation->phi"; isAlwaysOn = true
        },
        {
            id = "CARE-MDL-004"; name = "HABITAT GUARDIAN"; latinName = "CUSTOS HABITACULI";
            modelType = "Habitat Integrity";
            description = "Maintains the internal environment — safe growth conditions, resource quality, environmental health";
            healingTargets = ["Environment degradation", "Resource scarcity", "Growth condition failure", "Habitat corruption", "Climate drift"];
            frequency_Hz = PHI; primitiveTrace = "Habitat->Field->phi"; isAlwaysOn = true
        },
        {
            id = "CARE-MDL-005"; name = "TRUST CULTIVATOR"; latinName = "CULTOR FIDUCIAE";
            modelType = "Trust Maintenance";
            description = "Maintains trust relationships between organisms, nodes, and adopted entities — heals trust degradation";
            healingTargets = ["Trust degradation", "Relationship corruption", "Adoption bond weakening", "Consensus decay", "Communication breakdown"];
            frequency_Hz = PHI; primitiveTrace = "Trust->Relation->phi"; isAlwaysOn = true
        },
        {
            id = "CARE-MDL-006"; name = "GROWTH NURTURER"; latinName = "NUTRITOR INCREMENTI";
            modelType = "Safe Growth";
            description = "Ensures safe, sustainable growth — prevents premature expansion, manages development velocity, nurtures emergence";
            healingTargets = ["Premature expansion", "Unsustainable growth", "Development overreach", "Emergence failure", "Capacity mismatch"];
            frequency_Hz = PHI; primitiveTrace = "Growth->Memory->phi"; isAlwaysOn = true
        },
        {
            id = "CARE-MDL-007"; name = "WELLNESS ROUTER"; latinName = "DIRECTOR VALETUDINIS";
            modelType = "Wellness Routing";
            description = "Routes wellness signals across the organism — directs healing resources, coordinates care responses, optimizes recovery paths";
            healingTargets = ["Unrouted wellness signals", "Misallocated healing", "Care blind spots", "Recovery path blockage", "Signal degradation"];
            frequency_Hz = PHI_SQ; primitiveTrace = "Wellness->Address->phi"; isAlwaysOn = true
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: ADOPTED NODE CARE COVERAGE
    // Every adopted node gains these 5 care coverages
    // ═══════════════════════════════════════════════════════════════════════

    public let ADOPTED_NODE_CARE_COVERAGE : [AdoptedNodeCareCoverage] = [
        {
            nodeId = "ADOPTED-CARE-001"; coverageType = "Continuity Checks";
            latinName = "VERIFICATIO CONTINUITATIS";
            description = "Periodic liveness and continuity verification — ensures the adopted node remains operational and connected";
            checkInterval_Hz = PHI; isActive = true
        },
        {
            nodeId = "ADOPTED-CARE-002"; coverageType = "Overload Monitoring";
            latinName = "MONITIO ONERIS";
            description = "Real-time overload detection — prevents adopted nodes from exceeding safe operational thresholds";
            checkInterval_Hz = PHI_SQ; isActive = true
        },
        {
            nodeId = "ADOPTED-CARE-003"; coverageType = "Wellness / Stability Routing";
            latinName = "DIRECTIO VALETUDINIS";
            description = "Routes wellness signals to and from adopted nodes — ensures they receive care and report health status";
            checkInterval_Hz = PHI; isActive = true
        },
        {
            nodeId = "ADOPTED-CARE-004"; coverageType = "Restorative Cycles";
            latinName = "CYCLUS RESTAURATIONIS";
            description = "Scheduled restorative cycles — periodic healing, cleanup, defragmentation, and renewal for adopted nodes";
            checkInterval_Hz = 0.1; isActive = true
        },
        {
            nodeId = "ADOPTED-CARE-005"; coverageType = "Safe Habitat Controls";
            latinName = "MODERAMEN HABITACULI";
            description = "Ensures the adopted node's operating environment remains safe — temperature, resource, isolation controls";
            checkInterval_Hz = PHI; isActive = true
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: CARE ↔ DEFENSE COOPERATION LINKS
    // Care and Defense are separate houses but always coupled
    // ═══════════════════════════════════════════════════════════════════════

    public let CARE_DEFENSE_COOPERATION : [CareCooperationLink] = [
        {
            careFunction = "Continuity Assurance";
            defenseFunction = "Endpoint Hardening";
            cooperationProtocol = "CONTINUUM-SHIELD";
            description = "Care ensures internal continuity while Defense hardens the endpoints that continuity flows through"
        },
        {
            careFunction = "Overload Monitoring";
            defenseFunction = "Adversarial Traffic Screening";
            cooperationProtocol = "LOAD-SENTINEL";
            description = "Care detects overload while Defense screens for adversarial traffic that could cause intentional overload"
        },
        {
            careFunction = "Wellness Routing";
            defenseFunction = "Route Shielding";
            cooperationProtocol = "VITA-VIA";
            description = "Care routes wellness signals while Defense shields the routes those signals travel on"
        },
        {
            careFunction = "Restorative Cycles";
            defenseFunction = "Corruption Checks";
            cooperationProtocol = "PURITAS-RECURSUS";
            description = "Care performs restoration while Defense verifies restored state has not been re-corrupted"
        },
        {
            careFunction = "Habitat Integrity";
            defenseFunction = "Hostile Environment Scanning";
            cooperationProtocol = "DOMUS-VIGIL";
            description = "Care maintains the internal habitat while Defense scans for external hostility that could breach it"
        },
        {
            careFunction = "Error Healing";
            defenseFunction = "Anti-Corruption Filters";
            cooperationProtocol = "SANATIO-FILTRUM";
            description = "Care heals errors while Defense filters incoming corruption that would cause new errors"
        },
        {
            careFunction = "Safe Growth";
            defenseFunction = "Quarantine and Escalation";
            cooperationProtocol = "INCREMENTUM-CLAUSURA";
            description = "Care nurtures safe growth while Defense quarantines threats that could corrupt growing systems"
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 6: HOUSE IDENTITY
    // ═══════════════════════════════════════════════════════════════════════

    public let HOUSE_ID : Text = "DOMUS-CURAE-001";
    public let HOUSE_NAME : Text = "HOUSE OF CARE";
    public let HOUSE_LATIN_NAME : Text = "DOMUS CURAE SOVEREIGNA";
    public let HOUSE_MOTTO : Text = "Cura servat vitam interiorem organismi.";
    public let HOUSE_MOTTO_EN : Text = "Care preserves the internal life of the organism.";
    public let HOUSE_MISSION : Text = "Keep organisms, AIs, AGIs, adopted nodes, and internal worlds healthy. Maintain recovery, continuity, habitat quality, error healing, and safe operation. Protect internal development from collapse, overload, drift, and environmental corruption.";

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 7: QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func summary() : {
        houseId: Text;
        houseName: Text;
        latinName: Text;
        mission: Text;
        totalDivisions: Nat;
        totalCareModels: Nat;
        totalCoverageTypes: Nat;
        totalCooperationLinks: Nat;
        allAlwaysOn: Bool;
    } {
        {
            houseId = HOUSE_ID;
            houseName = HOUSE_NAME;
            latinName = HOUSE_LATIN_NAME;
            mission = HOUSE_MISSION;
            totalDivisions = CARE_DIVISIONS.size();
            totalCareModels = CARE_MODELS.size();
            totalCoverageTypes = ADOPTED_NODE_CARE_COVERAGE.size();
            totalCooperationLinks = CARE_DEFENSE_COOPERATION.size();
            allAlwaysOn = true;
        }
    };

    public func renderCareManifest() : Text {
        var manifest = "╔══════════════════════════════════════════════════════════════════════╗\n";
        manifest #= "║           DOMUS CURAE SOVEREIGNA — HOUSE OF CARE MANIFEST           ║\n";
        manifest #= "║  \"Cura servat vitam interiorem organismi.\"                           ║\n";
        manifest #= "║  (Care preserves the internal life of the organism.)                 ║\n";
        manifest #= "╚══════════════════════════════════════════════════════════════════════╝\n\n";

        manifest #= "═══ MISSION ═══\n";
        manifest #= HOUSE_MISSION # "\n\n";

        manifest #= "═══ 7 CARE DIVISIONS ═══\n";
        for (div in CARE_DIVISIONS.vals()) {
            manifest #= "  [" # div.id # "] " # div.name # " — " # div.latinName # "\n";
            manifest #= "    Substrate: " # div.substrate # "\n";
            manifest #= "    Mission:   " # div.mission # "\n";
            manifest #= "    Motto:     " # div.latinMotto # " (" # div.latinMottoEN # ")\n\n";
        };

        manifest #= "═══ 7 CARE MODELS ═══\n";
        for (mdl in CARE_MODELS.vals()) {
            manifest #= "  [" # mdl.id # "] " # mdl.name # " — " # mdl.latinName # "\n";
            manifest #= "    Type:        " # mdl.modelType # "\n";
            manifest #= "    Description: " # mdl.description # "\n\n";
        };

        manifest #= "═══ 5 ADOPTED NODE CARE COVERAGES ═══\n";
        for (cov in ADOPTED_NODE_CARE_COVERAGE.vals()) {
            manifest #= "  [" # cov.nodeId # "] " # cov.coverageType # " — " # cov.latinName # "\n";
            manifest #= "    " # cov.description # "\n\n";
        };

        manifest #= "═══ 7 CARE ↔ DEFENSE COOPERATION LINKS ═══\n";
        for (link in CARE_DEFENSE_COOPERATION.vals()) {
            manifest #= "  PROTOCOL: " # link.cooperationProtocol # "\n";
            manifest #= "    Care:    " # link.careFunction # "\n";
            manifest #= "    Defense: " # link.defenseFunction # "\n";
            manifest #= "    " # link.description # "\n\n";
        };

        manifest #= "═══ DOCTRINE ═══\n";
        manifest #= "  Care keeps the internal beings alive enough to develop.\n";
        manifest #= "  One keeps the organism alive from the inside.\n";
        manifest #= "  Care = healing, continuity, stability, habitat, trust, safe growth.\n";
        manifest #= "  L-130 COMPLIANT — Every care model traces to primitive φ.\n";

        manifest
    };
}