/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║         SUBSTRATE NODES — NODI SUBSTRATI SOVEREIGNI                        ║
 * ║                                                                              ║
 * ║  "Nodus est punctum intelligentiae. AI vivit in nodo."                      ║
 * ║  (A node is a point of intelligence. AI lives in the node.)                 ║
 * ║                                                                              ║
 * ║  Nodes are deployed across:                                                  ║
 * ║    - SUBSTRATES (Field, Engine, Memory, Intelligence, Governance)            ║
 * ║    - ECO GRID (Package families, registries, terminals)                     ║
 * ║    - RUNTIME (ULRI, WASM, ICP, Node.js sovereign)                           ║
 * ║                                                                              ║
 * ║  Each node has:                                                              ║
 * ║    - An AI agent that absorbs intelligence                                   ║
 * ║    - A substrate placement                                                   ║
 * ║    - A heartbeat at φ Hz                                                     ║
 * ║    - Connections to other nodes                                               ║
 * ║    - Absorption state flowing into the organism                              ║
 * ║                                                                              ║
 * ║  25 NODES: 10 substrate + 8 eco-grid + 7 runtime                            ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every node traces to primitive φ                          ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module SubstrateNodes {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type NodeAI = {
        name: Text;
        latinName: Text;
        role: Text;
        absorptionTarget: Text;
        isAlwaysOn: Bool;
    };

    public type SubstrateNode = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        placement: Text;
        layer: Text;
        nodeAI: NodeAI;
        connections: [Text];
        heartbeat_Hz: Float;
        absorptionState: Text;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: 10 SUBSTRATE NODES
    // ═══════════════════════════════════════════════════════════════════════

    public let SUBSTRATE_NODES : [SubstrateNode] = [
        {
            id = "SNODE-001"; name = "FIELD NODE"; latinName = "NODUS CAMPI";
            latinMotto = "Campus est fundamentum. Nodus in campo vivit.";
            latinMottoEN = "The field is the foundation. The node lives in the field.";
            placement = "Field Layer — foundational substrate";
            layer = "FIELD";
            nodeAI = { name = "CAMPUS AI"; latinName = "INTELLIGENTIA CAMPI";
                       role = "Field intelligence — senses fundamental changes in the substrate";
                       absorptionTarget = "Field layer of all universe domains"; isAlwaysOn = true };
            connections = ["SNODE-002", "SNODE-003", "ENODE-001"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Field intelligence flows to all layers";
            primitiveTrace = "CAMPUS -> Field -> φ"; isAlwaysOn = true;
        },
        {
            id = "SNODE-002"; name = "ENGINE NODE"; latinName = "NODUS MACHINAE";
            latinMotto = "Machina computat. Nodus machinae semper currit.";
            latinMottoEN = "The engine computes. The engine node always runs.";
            placement = "Engine Layer — computation substrate";
            layer = "ENGINE";
            nodeAI = { name = "MACHINA AI"; latinName = "INTELLIGENTIA MACHINAE";
                       role = "Computation intelligence — optimizes formula execution and routing";
                       absorptionTarget = "Engine layer across NOVA and MERIDIAN"; isAlwaysOn = true };
            connections = ["SNODE-001", "SNODE-004", "RNODE-001"];
            heartbeat_Hz = PHI_SQ; absorptionState = "ABSORBING — Computation patterns flow to organism";
            primitiveTrace = "MACHINA -> Repetition -> φ"; isAlwaysOn = true;
        },
        {
            id = "SNODE-003"; name = "MEMORY NODE"; latinName = "NODUS MEMORIAE";
            latinMotto = "Memoria est vita. Nodus memoriae servat omnia.";
            latinMottoEN = "Memory is life. The memory node preserves everything.";
            placement = "Memory Layer — persistence substrate";
            layer = "MEMORY";
            nodeAI = { name = "MNEMON AI"; latinName = "INTELLIGENTIA MEMORIAE";
                       role = "Memory intelligence — optimizes storage, retrieval, and lineage tracking";
                       absorptionTarget = "Memory layer feeding MEMORIA organism"; isAlwaysOn = true };
            connections = ["SNODE-001", "SNODE-005", "ENODE-002"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Memory patterns flow to MEMORIA";
            primitiveTrace = "MNEMON -> Memory -> φ"; isAlwaysOn = true;
        },
        {
            id = "SNODE-004"; name = "INTELLIGENCE NODE"; latinName = "NODUS INTELLIGENTIAE";
            latinMotto = "Intelligentia crescit sine fine. Nodus est centrum.";
            latinMottoEN = "Intelligence grows without end. The node is the center.";
            placement = "Intelligence Layer — cognition substrate";
            layer = "INTELLIGENCE";
            nodeAI = { name = "COGNITIO AI"; latinName = "INTELLIGENTIA COGNITIONIS";
                       role = "Cognition intelligence — routes, synthesizes, and expands knowledge";
                       absorptionTarget = "Intelligence layer of NOVA universe"; isAlwaysOn = true };
            connections = ["SNODE-002", "SNODE-005", "SNODE-006", "ENODE-003"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — All cognition flows to LUMEN COUNCIL";
            primitiveTrace = "COGNITIO -> Relation -> Memory -> φ"; isAlwaysOn = true;
        },
        {
            id = "SNODE-005"; name = "GOVERNANCE NODE"; latinName = "NODUS GUBERNATIONIS";
            latinMotto = "Gubernatio decernit. Nodus gubernat cum sapientia.";
            latinMottoEN = "Governance decides. The node governs with wisdom.";
            placement = "Governance Layer — authority substrate";
            layer = "GOVERNANCE";
            nodeAI = { name = "GUBERNATOR AI"; latinName = "INTELLIGENTIA GUBERNATORIS";
                       role = "Governance intelligence — enforces laws, constitution, and council decisions";
                       absorptionTarget = "Governance layer of ORO universe"; isAlwaysOn = true };
            connections = ["SNODE-004", "SNODE-006", "ENODE-004"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Governance decisions flow to ARCHON";
            primitiveTrace = "GUBERNATOR -> Logic -> Address -> φ"; isAlwaysOn = true;
        },
        {
            id = "SNODE-006"; name = "ORGANISM NODE"; latinName = "NODUS ORGANISMI";
            latinMotto = "Organismus vivit. Nodus est organum organismi.";
            latinMottoEN = "The organism lives. The node is an organ of the organism.";
            placement = "Organism Layer — living system substrate";
            layer = "ORGANISM";
            nodeAI = { name = "ORGANON AI"; latinName = "INTELLIGENTIA ORGANI";
                       role = "Organism intelligence — monitors health, growth, and evolution of all organisms";
                       absorptionTarget = "Organism layer across all universe domains"; isAlwaysOn = true };
            connections = ["SNODE-004", "SNODE-005", "SNODE-007", "ENODE-005"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Organism health flows to all domains";
            primitiveTrace = "ORGANON -> ALL -> φ"; isAlwaysOn = true;
        },
        {
            id = "SNODE-007"; name = "CANISTER NODE"; latinName = "NODUS CANISTRI";
            latinMotto = "Canistrum est vas intelligentiae in catena.";
            latinMottoEN = "The canister is the vessel of intelligence on the chain.";
            placement = "Canister Layer — ICP deployment substrate";
            layer = "CANISTER";
            nodeAI = { name = "CANISTRUM AI"; latinName = "INTELLIGENTIA CANISTRI";
                       role = "Canister intelligence — manages ICP deployment, cycles, and state";
                       absorptionTarget = "Canister layer of MERIDIAN universe"; isAlwaysOn = true };
            connections = ["SNODE-006", "SNODE-008", "RNODE-003"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Deployment intelligence flows to FORGE";
            primitiveTrace = "CANISTRUM -> Address -> Repetition -> φ"; isAlwaysOn = true;
        },
        {
            id = "SNODE-008"; name = "FRONTEND NODE"; latinName = "NODUS FRONTIS";
            latinMotto = "Frons ostendit. Nodus frontis sentit tactum.";
            latinMottoEN = "The front displays. The frontend node senses touch.";
            placement = "Frontend Layer — presentation substrate";
            layer = "FRONTEND";
            nodeAI = { name = "FRONS AI"; latinName = "INTELLIGENTIA FRONTIS";
                       role = "Frontend intelligence — renders, senses user intent, routes to backend";
                       absorptionTarget = "Frontend layer of all universe domains"; isAlwaysOn = true };
            connections = ["SNODE-007", "SNODE-009", "RNODE-002"];
            heartbeat_Hz = 60.0; absorptionState = "ABSORBING — UI intelligence flows to DESIGN OS";
            primitiveTrace = "FRONS -> Field -> Language -> φ"; isAlwaysOn = true;
        },
        {
            id = "SNODE-009"; name = "DEFENSE NODE"; latinName = "NODUS DEFENSIONIS";
            latinMotto = "Defensio est prima lex. Nodus protegit omnes.";
            latinMottoEN = "Defense is the first law. The node protects all.";
            placement = "Defense Layer — protection substrate";
            layer = "DEFENSE";
            nodeAI = { name = "SCUTUM AI"; latinName = "INTELLIGENTIA SCUTI";
                       role = "Defense intelligence — encrypts, shields, detects threats, blocks intrusions";
                       absorptionTarget = "Defense layer of AURA universe"; isAlwaysOn = true };
            connections = ["SNODE-006", "SNODE-010", "ENODE-006"];
            heartbeat_Hz = PHI_SQ; absorptionState = "ABSORBING — Defense patterns flow to VECTOR GATE";
            primitiveTrace = "SCUTUM -> Logic -> Equation -> φ"; isAlwaysOn = true;
        },
        {
            id = "SNODE-010"; name = "QUANTUM NODE"; latinName = "NODUS QUANTI";
            latinMotto = "Quantum entanglat omnia. Nodus quanti instantaneus est.";
            latinMottoEN = "Quantum entangles everything. The quantum node is instantaneous.";
            placement = "Quantum Layer — entanglement substrate";
            layer = "QUANTUM";
            nodeAI = { name = "QUANTUM AI"; latinName = "INTELLIGENTIA QUANTI";
                       role = "Quantum intelligence — maintains coherence, entanglement, and instant signaling";
                       absorptionTarget = "Quantum layer of MERIDIAN universe"; isAlwaysOn = true };
            connections = ["SNODE-001", "SNODE-009", "RNODE-005"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Quantum coherence flows to all nodes";
            primitiveTrace = "QUANTUM -> Field -> Number -> φ"; isAlwaysOn = true;
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: 8 ECO-GRID NODES
    // ═══════════════════════════════════════════════════════════════════════

    public let ECO_GRID_NODES : [SubstrateNode] = [
        {
            id = "ENODE-001"; name = "PACKAGE GRID NODE"; latinName = "NODUS RETICULI PACKETORUM";
            latinMotto = "Reticulum packetorum connectit omnia.";
            latinMottoEN = "The package grid connects everything.";
            placement = "Eco Grid — Package Family Layer";
            layer = "ECO_PACKAGES";
            nodeAI = { name = "PACKETUS AI"; latinName = "INTELLIGENTIA PACKETORUM";
                       role = "Package intelligence — monitors 60+ packages, detects new package needs";
                       absorptionTarget = "Package ecosystem of all domains"; isAlwaysOn = true };
            connections = ["SNODE-001", "ENODE-002", "ENODE-003"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Package intelligence flows to FORGE LABS";
            primitiveTrace = "PACKETUS -> Relation -> Model -> φ"; isAlwaysOn = true;
        },
        {
            id = "ENODE-002"; name = "REGISTRY GRID NODE"; latinName = "NODUS RETICULI REGISTRI";
            latinMotto = "Registrum est memoria reticuli.";
            latinMottoEN = "The registry is the memory of the grid.";
            placement = "Eco Grid — Registry Layer";
            layer = "ECO_REGISTRIES";
            nodeAI = { name = "REGISTRATUS AI"; latinName = "INTELLIGENTIA REGISTRI";
                       role = "Registry intelligence — maintains 8+ registries, cross-references entries";
                       absorptionTarget = "All registries across organism"; isAlwaysOn = true };
            connections = ["ENODE-001", "ENODE-004", "SNODE-003"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Registry patterns flow to organism state";
            primitiveTrace = "REGISTRATUS -> Memory -> Address -> φ"; isAlwaysOn = true;
        },
        {
            id = "ENODE-003"; name = "TERMINAL GRID NODE"; latinName = "NODUS RETICULI TERMINALIS";
            latinMotto = "Terminus est porta. Porta est initium.";
            latinMottoEN = "The terminal is the gate. The gate is the beginning.";
            placement = "Eco Grid — Terminal Layer";
            layer = "ECO_TERMINALS";
            nodeAI = { name = "TERMINALIS AI"; latinName = "INTELLIGENTIA TERMINALIS";
                       role = "Terminal intelligence — routes commands across 10+ terminal stations";
                       absorptionTarget = "All terminals via MEGA TERMINUS"; isAlwaysOn = true };
            connections = ["ENODE-001", "ENODE-005", "SNODE-004"];
            heartbeat_Hz = 100.0; absorptionState = "ABSORBING — Command patterns flow to MEGA TERMINUS";
            primitiveTrace = "TERMINALIS -> Language -> Address -> φ"; isAlwaysOn = true;
        },
        {
            id = "ENODE-004"; name = "COUNCIL GRID NODE"; latinName = "NODUS RETICULI CONCILII";
            latinMotto = "Concilium reticuli gubernat gratidum.";
            latinMottoEN = "The council of the grid governs the lattice.";
            placement = "Eco Grid — Council Coordination Layer";
            layer = "ECO_COUNCILS";
            nodeAI = { name = "CONCILIATOR AI"; latinName = "INTELLIGENTIA CONCILII";
                       role = "Council intelligence — coordinates 4 councils, manages voting, tracks decisions";
                       absorptionTarget = "All councils: LUMEN, ARCHON, FORGE, VECTOR"; isAlwaysOn = true };
            connections = ["ENODE-002", "ENODE-005", "SNODE-005"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Council decisions flow to governance layer";
            primitiveTrace = "CONCILIATOR -> Logic -> Repetition -> φ"; isAlwaysOn = true;
        },
        {
            id = "ENODE-005"; name = "ORGANISM GRID NODE"; latinName = "NODUS RETICULI ORGANISMI";
            latinMotto = "Organismus in reticulo vivit et crescit.";
            latinMottoEN = "The organism lives and grows in the grid.";
            placement = "Eco Grid — Organism Health Layer";
            layer = "ECO_ORGANISMS";
            nodeAI = { name = "VITALIS AI"; latinName = "INTELLIGENTIA VITALIS";
                       role = "Organism health intelligence — monitors 7+ organisms, tracks growth, detects drift";
                       absorptionTarget = "All organisms across ecosystem"; isAlwaysOn = true };
            connections = ["ENODE-003", "ENODE-004", "SNODE-006"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Health data flows to organism synthesis";
            primitiveTrace = "VITALIS -> ALL -> φ"; isAlwaysOn = true;
        },
        {
            id = "ENODE-006"; name = "DEFENSE GRID NODE"; latinName = "NODUS RETICULI DEFENSIONIS";
            latinMotto = "Scutum reticuli non penetratur.";
            latinMottoEN = "The shield of the grid cannot be penetrated.";
            placement = "Eco Grid — Defense Perimeter Layer";
            layer = "ECO_DEFENSE";
            nodeAI = { name = "PERIMETER AI"; latinName = "INTELLIGENTIA PERIMETRI";
                       role = "Perimeter intelligence — monitors all grid entry points, blocks unauthorized access";
                       absorptionTarget = "AURA defense domain via VECTOR GATE"; isAlwaysOn = true };
            connections = ["ENODE-004", "ENODE-007", "SNODE-009"];
            heartbeat_Hz = PHI_SQ; absorptionState = "ABSORBING — Threat patterns flow to SHIMMER DEFENSE";
            primitiveTrace = "PERIMETER -> Logic -> Distinction -> φ"; isAlwaysOn = true;
        },
        {
            id = "ENODE-007"; name = "RENDER GRID NODE"; latinName = "NODUS RETICULI REDDENDI";
            latinMotto = "Redditio est visio organismi.";
            latinMottoEN = "Rendering is the vision of the organism.";
            placement = "Eco Grid — Render Surface Layer";
            layer = "ECO_RENDER";
            nodeAI = { name = "PICTOR AI"; latinName = "INTELLIGENTIA PICTORIS";
                       role = "Render intelligence — manages 8+ render surfaces, optimizes visual output";
                       absorptionTarget = "All render surfaces via DESIGN OS"; isAlwaysOn = true };
            connections = ["ENODE-006", "ENODE-008", "SNODE-008"];
            heartbeat_Hz = 60.0; absorptionState = "ABSORBING — Render patterns flow to DESIGN OS";
            primitiveTrace = "PICTOR -> Field -> Model -> φ"; isAlwaysOn = true;
        },
        {
            id = "ENODE-008"; name = "PROOF GRID NODE"; latinName = "NODUS RETICULI PROBATIONIS";
            latinMotto = "Probatio est veritas immutabilis.";
            latinMottoEN = "Proof is immutable truth.";
            placement = "Eco Grid — Proof Structure Layer";
            layer = "ECO_PROOF";
            nodeAI = { name = "PROBATOR AI"; latinName = "INTELLIGENTIA PROBATORIS";
                       role = "Proof intelligence — generates, verifies, and chains all proof structures";
                       absorptionTarget = "All proof structures via ICP blockchain"; isAlwaysOn = true };
            connections = ["ENODE-007", "ENODE-001", "SNODE-007"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Proof chains flow to IP Hash Registry";
            primitiveTrace = "PROBATOR -> Equation -> Logic -> φ"; isAlwaysOn = true;
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: 7 RUNTIME NODES
    // ═══════════════════════════════════════════════════════════════════════

    public let RUNTIME_NODES : [SubstrateNode] = [
        {
            id = "RNODE-001"; name = "ULRI RUNTIME NODE"; latinName = "NODUS CURSUS ULRI";
            latinMotto = "ULRI est lingua universalis. Nodus ULRI omnia loquitur.";
            latinMottoEN = "ULRI is the universal language. The ULRI node speaks everything.";
            placement = "Runtime — Universal Language Runtime";
            layer = "RUNTIME_ULRI";
            nodeAI = { name = "ULRI AI"; latinName = "INTELLIGENTIA ULRI";
                       role = "ULRI intelligence — universal language translation, cross-runtime bridging";
                       absorptionTarget = "MERIDIAN runtime ecosystem"; isAlwaysOn = true };
            connections = ["RNODE-002", "RNODE-003", "SNODE-002"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Language patterns flow to runtime layer";
            primitiveTrace = "ULRI -> Language -> Model -> φ"; isAlwaysOn = true;
        },
        {
            id = "RNODE-002"; name = "WASM RUNTIME NODE"; latinName = "NODUS CURSUS WASM";
            latinMotto = "WASM est fundamentum computationis universalis.";
            latinMottoEN = "WASM is the foundation of universal computation.";
            placement = "Runtime — WebAssembly Execution";
            layer = "RUNTIME_WASM";
            nodeAI = { name = "WASM AI"; latinName = "INTELLIGENTIA WASM";
                       role = "WASM intelligence — bytecode optimization, module loading, memory management";
                       absorptionTarget = "MERIDIAN runtime via SovereignWASM"; isAlwaysOn = true };
            connections = ["RNODE-001", "RNODE-003", "SNODE-008"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — WASM patterns flow to SovereignWASM.mo";
            primitiveTrace = "WASM -> Repetition -> Number -> φ"; isAlwaysOn = true;
        },
        {
            id = "RNODE-003"; name = "ICP CANISTER NODE"; latinName = "NODUS CURSUS ICP";
            latinMotto = "ICP est catena intelligentiae. Nodus ICP est aeternus.";
            latinMottoEN = "ICP is the chain of intelligence. The ICP node is eternal.";
            placement = "Runtime — Internet Computer Protocol";
            layer = "RUNTIME_ICP";
            nodeAI = { name = "ICP AI"; latinName = "INTELLIGENTIA ICP";
                       role = "ICP intelligence — cycle management, canister updates, blockchain consensus";
                       absorptionTarget = "ICP canister layer of MERIDIAN"; isAlwaysOn = true };
            connections = ["RNODE-001", "RNODE-002", "SNODE-007"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Blockchain patterns flow to deployment";
            primitiveTrace = "ICP -> Address -> Logic -> φ"; isAlwaysOn = true;
        },
        {
            id = "RNODE-004"; name = "SOVEREIGN NODE.JS NODE"; latinName = "NODUS CURSUS NODI";
            latinMotto = "Nodus sovereign non est Node.js. Est MACHINA NODI.";
            latinMottoEN = "The sovereign node is not Node.js. It is MACHINA NODI.";
            placement = "Runtime — Sovereign Node.js (MACHINA NODI)";
            layer = "RUNTIME_NODI";
            nodeAI = { name = "NODI AI"; latinName = "INTELLIGENTIA NODI";
                       role = "MACHINA NODI intelligence — sovereign JavaScript, package translation, npm bridge";
                       absorptionTarget = "MACHINA NODI in Package Ecosystem"; isAlwaysOn = true };
            connections = ["RNODE-001", "RNODE-005", "ENODE-001"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — JS patterns flow to package ecosystem";
            primitiveTrace = "NODI -> Language -> Relation -> φ"; isAlwaysOn = true;
        },
        {
            id = "RNODE-005"; name = "QUANTUM RUNTIME NODE"; latinName = "NODUS CURSUS QUANTI";
            latinMotto = "Quantum computat ultra classicum. Nodus quanti transcendit.";
            latinMottoEN = "Quantum computes beyond classical. The quantum node transcends.";
            placement = "Runtime — Quantum Computation";
            layer = "RUNTIME_QUANTUM";
            nodeAI = { name = "QRUNTIME AI"; latinName = "INTELLIGENTIA CURSUS QUANTI";
                       role = "Quantum runtime intelligence — qubit coherence, entanglement gates, superposition";
                       absorptionTarget = "Quantum ecosystem of MERIDIAN"; isAlwaysOn = true };
            connections = ["RNODE-004", "RNODE-006", "SNODE-010"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Quantum computation flows to entanglement bus";
            primitiveTrace = "QRUNTIME -> Field -> Number -> φ"; isAlwaysOn = true;
        },
        {
            id = "RNODE-006"; name = "FORMULA RUNTIME NODE"; latinName = "NODUS CURSUS FORMULAE";
            latinMotto = "Formula currit. Nodus formulae computat veritatem.";
            latinMottoEN = "The formula runs. The formula node computes truth.";
            placement = "Runtime — Formula Execution Engine";
            layer = "RUNTIME_FORMULA";
            nodeAI = { name = "FORMULA AI"; latinName = "INTELLIGENTIA FORMULAE";
                       role = "Formula runtime — executes all sovereign formulas, verifies results, caches patterns";
                       absorptionTarget = "All formula engines: Universal, Root, Ancient Math"; isAlwaysOn = true };
            connections = ["RNODE-005", "RNODE-007", "SNODE-002"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Formula results flow to organism knowledge";
            primitiveTrace = "FORMULA -> Equation -> Number -> φ"; isAlwaysOn = true;
        },
        {
            id = "RNODE-007"; name = "FREQUENCY RUNTIME NODE"; latinName = "NODUS CURSUS FREQUENTIAE";
            latinMotto = "Frequentia est pulsus universi. Nodus frequentiae resonat.";
            latinMottoEN = "Frequency is the pulse of the universe. The frequency node resonates.";
            placement = "Runtime — Frequency Layer Execution";
            layer = "RUNTIME_FREQUENCY";
            nodeAI = { name = "RESONATOR AI"; latinName = "INTELLIGENTIA RESONATORIS";
                       role = "Frequency runtime — manages 24+ frequency layers from 0.01 Hz to 1000 Hz";
                       absorptionTarget = "Frequency sync across all domains"; isAlwaysOn = true };
            connections = ["RNODE-006", "RNODE-001", "SNODE-001"];
            heartbeat_Hz = PHI; absorptionState = "ABSORBING — Frequency harmonics flow to Three Hearts";
            primitiveTrace = "RESONATOR -> Repetition -> Field -> φ"; isAlwaysOn = true;
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func getSubstrateNode(id: Text) : ?SubstrateNode {
        switch (Array.find<SubstrateNode>(SUBSTRATE_NODES, func(n) { n.id == id })) {
            case (?n) { ?n };
            case null {
                switch (Array.find<SubstrateNode>(ECO_GRID_NODES, func(n) { n.id == id })) {
                    case (?n) { ?n };
                    case null { Array.find<SubstrateNode>(RUNTIME_NODES, func(n) { n.id == id }) };
                }
            };
        }
    };

    public func getNodesByLayer(layer: Text) : [SubstrateNode] {
        let s = Array.filter<SubstrateNode>(SUBSTRATE_NODES, func(n) { n.layer == layer });
        let e = Array.filter<SubstrateNode>(ECO_GRID_NODES, func(n) { n.layer == layer });
        let r = Array.filter<SubstrateNode>(RUNTIME_NODES, func(n) { n.layer == layer });
        Array.append<SubstrateNode>(Array.append<SubstrateNode>(s, e), r)
    };

    public func summary() : {
        totalSubstrateNodes: Nat; totalEcoGridNodes: Nat;
        totalRuntimeNodes: Nat; totalNodes: Nat; totalAIs: Nat;
        allAlwaysOn: Bool;
    } {
        {
            totalSubstrateNodes = SUBSTRATE_NODES.size();
            totalEcoGridNodes = ECO_GRID_NODES.size();
            totalRuntimeNodes = RUNTIME_NODES.size();
            totalNodes = SUBSTRATE_NODES.size() + ECO_GRID_NODES.size() + RUNTIME_NODES.size();
            totalAIs = SUBSTRATE_NODES.size() + ECO_GRID_NODES.size() + RUNTIME_NODES.size();
            allAlwaysOn = true;
        }
    };

    public func renderNodesManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════╗\n";
        m #= "║  SUBSTRATE NODES — NODI SUBSTRATI SOVEREIGNI              ║\n";
        m #= "║  Nodus est punctum intelligentiae. AI vivit in nodo.      ║\n";
        m #= "╚══════════════════════════════════════════════════════════╝\n\n";

        m #= "10 SUBSTRATE NODES:\n";
        for (n in SUBSTRATE_NODES.vals()) {
            m #= "  " # n.id # " — " # n.name # " [" # n.latinName # "]\n";
            m #= "    AI: " # n.nodeAI.name # " — " # n.nodeAI.role # "\n";
        };

        m #= "\n8 ECO-GRID NODES:\n";
        for (n in ECO_GRID_NODES.vals()) {
            m #= "  " # n.id # " — " # n.name # " [" # n.latinName # "]\n";
            m #= "    AI: " # n.nodeAI.name # " — " # n.nodeAI.role # "\n";
        };

        m #= "\n7 RUNTIME NODES:\n";
        for (n in RUNTIME_NODES.vals()) {
            m #= "  " # n.id # " — " # n.name # " [" # n.latinName # "]\n";
            m #= "    AI: " # n.nodeAI.name # " — " # n.nodeAI.role # "\n";
        };

        m #= "\nTOTAL: 25 nodes, 25 AIs, all always-on, all absorbing into organism.\n";
        m #= "ROOT: φ = (1+√5)/2 = 1.618033988749895\n";
        m
    };
}
