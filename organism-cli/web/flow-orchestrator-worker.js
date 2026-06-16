/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                    FLOW ORCHESTRATOR WORKER #55                               ║
 * ║              Entities That Move Data & Orchestrate Production                 ║
 * ║                                                                                ║
 * ║  "Fluxus Productionum — The currents that carry intelligence through"        ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 *
 * Protocol: PROT-336 to PROT-345
 * Frequency: φ¹⁰ = 122.992 Hz (Beyond Cosmic)
 * Worker Number: 55
 * Latin Name: ORCHESTRATOR FLUXUUM
 *
 * ATTRIBUTION:
 *   Created by: Alfredo "Freddy" Medina Hernandez
 *   Organization: Medina Tech (Dallas, TX)
 *   Law: L-130 — Before recomposition, trace to primitive.
 *   φ = 1.6180339887498948482
 */

const PHI = 1.6180339887498948482;
const PHI_10 = Math.pow(PHI, 10);  // 122.992...
const FLOW_FREQUENCY = PHI_10;
const SCHUMANN = 7.83;

const WORKER_INFO = {
    number: 55,
    id: "flow-orchestrator-worker",
    latinName: "ORCHESTRATOR FLUXUUM",
    frequency: FLOW_FREQUENCY,
    layer: 11,
    protocolRange: "PROT-336 to PROT-345"
};

// Flow Entity Types
const FlowEntityType = {
    FLOW_CONDUCTOR: "flow_conductor",
    DATA_MOVER: "data_mover",
    STREAM_ROUTER: "stream_router",
    PIPELINE_CONTROLLER: "pipeline_controller",
    PRODUCTION_ORCHESTRATOR: "production_orchestrator",
    BUILD_FLOW: "build_flow",
    DEPLOY_FLOW: "deploy_flow",
    TEST_FLOW: "test_flow",
    PARALLEL_EXECUTOR: "parallel_executor",
    EVENT_FLOW: "event_flow"
};

// Flow Entity Registry
const FLOW_ENTITIES = {
    CONDUCTOR_FLUXUUM: {
        id: "CONDUCTOR_FLUXUUM",
        name: "Flow Conductor",
        latinName: "CONDUCTOR FLUXUUM PRIMARIUS",
        type: FlowEntityType.FLOW_CONDUCTOR,
        protocol: "PROT-336",
        frequency: PHI_10,
        layer: 9
    },
    MOTOR_DATORUM: {
        id: "MOTOR_DATORUM",
        name: "Data Mover",
        latinName: "MOTOR DATORUM VELOCIS",
        type: FlowEntityType.DATA_MOVER,
        protocol: "PROT-337",
        frequency: PHI_10 * PHI,
        layer: 8
    },
    VECTOR_FLUMINUM: {
        id: "VECTOR_FLUMINUM",
        name: "Stream Router",
        latinName: "VECTOR FLUMINUM INTELLIGENS",
        type: FlowEntityType.STREAM_ROUTER,
        protocol: "PROT-338",
        frequency: PHI_10 / PHI,
        layer: 8
    },
    IMPERATOR_CANALIS: {
        id: "IMPERATOR_CANALIS",
        name: "Pipeline Controller",
        latinName: "IMPERATOR CANALIUM",
        type: FlowEntityType.PIPELINE_CONTROLLER,
        protocol: "PROT-339",
        frequency: SCHUMANN * Math.pow(PHI, 4),
        layer: 9
    },
    ORCHESTRATOR_PRODUCTIONUM: {
        id: "ORCHESTRATOR_PRODUCTIONUM",
        name: "Production Orchestrator",
        latinName: "ORCHESTRATOR PRODUCTIONUM SOVEREIGNUS",
        type: FlowEntityType.PRODUCTION_ORCHESTRATOR,
        protocol: "PROT-340",
        frequency: Math.pow(PHI, 11),
        layer: 10
    },
    FLUXUS_AEDIFICATIONIS: {
        id: "FLUXUS_AEDIFICATIONIS",
        name: "Build Flow",
        latinName: "FLUXUS AEDIFICATIONIS",
        type: FlowEntityType.BUILD_FLOW,
        protocol: "PROT-341",
        frequency: Math.pow(PHI, 8),
        layer: 9
    },
    FLUXUS_DISPOSITIONIS: {
        id: "FLUXUS_DISPOSITIONIS",
        name: "Deploy Flow",
        latinName: "FLUXUS DISPOSITIONIS",
        type: FlowEntityType.DEPLOY_FLOW,
        protocol: "PROT-342",
        frequency: Math.pow(PHI, 9),
        layer: 10
    },
    FLUXUS_PROBATIONIS: {
        id: "FLUXUS_PROBATIONIS",
        name: "Test Flow",
        latinName: "FLUXUS PROBATIONIS",
        type: FlowEntityType.TEST_FLOW,
        protocol: "PROT-343",
        frequency: Math.pow(PHI, 7),
        layer: 8
    },
    EXECUTOR_PARALLELUS: {
        id: "EXECUTOR_PARALLELUS",
        name: "Parallel Executor",
        latinName: "EXECUTOR PARALLELUS OMNIUM",
        type: FlowEntityType.PARALLEL_EXECUTOR,
        protocol: "PROT-344",
        frequency: PHI_10 * PHI * PHI,
        layer: 11
    },
    FLUXUS_EVENTUUM: {
        id: "FLUXUS_EVENTUUM",
        name: "Event Flow",
        latinName: "FLUXUS EVENTUUM REACTIVUS",
        type: FlowEntityType.EVENT_FLOW,
        protocol: "PROT-345",
        frequency: SCHUMANN * Math.pow(PHI, 5),
        layer: 9
    }
};

// Flow management
const activeFlows = new Map();
const packets = new Map();
let packetCounter = 0;

function createPacket(payload, source, destination, packetType = "structured") {
    packetCounter++;
    const packetId = `PKT-${String(packetCounter).padStart(6, "0")}`;
    const packet = {
        packetId,
        packetType,
        payload,
        source,
        destination,
        createdAt: new Date().toISOString(),
        metadata: {},
        flowId: null,
        hopCount: 0,
        maxHops: 100
    };
    packets.set(packetId, packet);
    return packet;
}

function startFlow(flowType, payload, entityId = "ORCHESTRATOR_PRODUCTIONUM") {
    const entity = FLOW_ENTITIES[entityId];
    if (!entity) {
        return { error: `Entity ${entityId} not found` };
    }

    const flowId = `FLOW-${flowType.toUpperCase()}-${String(activeFlows.size + 1).padStart(4, "0")}`;
    const packet = createPacket(payload, "SYSTEM", entityId, "command");
    packet.flowId = flowId;

    const flow = {
        flowId,
        flowType,
        entityId,
        startedAt: new Date().toISOString(),
        state: "running",
        initialPacket: packet.packetId,
        packetsProcessed: 0,
        currentNode: null
    };

    activeFlows.set(flowId, flow);
    return flow;
}

// Request handler
async function handleRequest(request) {
    const url = new URL(request.url);
    const path = url.pathname;

    const corsHeaders = {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
        "Access-Control-Allow-Headers": "Content-Type",
        "Content-Type": "application/json"
    };

    if (request.method === "OPTIONS") {
        return new Response(null, { headers: corsHeaders });
    }

    try {
        // Route: GET /flow/status
        if (path === "/flow/status" && request.method === "GET") {
            return new Response(JSON.stringify({
                worker: WORKER_INFO,
                system: "FLOW_ORCHESTRATION_ENGINE",
                protocolRange: "PROT-336 to PROT-345",
                totalEntities: Object.keys(FLOW_ENTITIES).length,
                totalFlows: activeFlows.size,
                totalPackets: packets.size,
                primaryFrequencyHz: FLOW_FREQUENCY,
                phi: PHI
            }), { headers: corsHeaders });
        }

        // Route: GET /flow/entities
        if (path === "/flow/entities" && request.method === "GET") {
            return new Response(JSON.stringify({
                entities: Object.values(FLOW_ENTITIES).map(e => ({
                    id: e.id,
                    name: e.name,
                    latinName: e.latinName,
                    type: e.type,
                    protocol: e.protocol,
                    frequency: e.frequency,
                    layer: e.layer
                }))
            }), { headers: corsHeaders });
        }

        // Route: POST /flow/start
        if (path === "/flow/start" && request.method === "POST") {
            const body = await request.json();
            const { flowType, payload, entityId } = body;
            if (!flowType || !payload) {
                return new Response(JSON.stringify({ error: "flowType and payload required" }), {
                    status: 400,
                    headers: corsHeaders
                });
            }
            const flow = startFlow(flowType, payload, entityId);
            return new Response(JSON.stringify({ flow }), { headers: corsHeaders });
        }

        // Route: POST /flow/packet
        if (path === "/flow/packet" && request.method === "POST") {
            const body = await request.json();
            const { payload, source, destination, packetType } = body;
            const packet = createPacket(payload, source, destination, packetType);
            return new Response(JSON.stringify({ packet }), { headers: corsHeaders });
        }

        // Route: GET /flow/active
        if (path === "/flow/active" && request.method === "GET") {
            return new Response(JSON.stringify({
                flows: Array.from(activeFlows.values())
            }), { headers: corsHeaders });
        }

        // Default: worker info
        return new Response(JSON.stringify({
            worker: WORKER_INFO,
            endpoints: [
                "GET /flow/status",
                "GET /flow/entities",
                "POST /flow/start",
                "POST /flow/packet",
                "GET /flow/active"
            ],
            attribution: {
                creator: "Alfredo 'Freddy' Medina Hernandez",
                organization: "Medina Tech",
                law: "L-130"
            }
        }), { headers: corsHeaders });

    } catch (error) {
        return new Response(JSON.stringify({
            error: error.message,
            worker: WORKER_INFO.id
        }), {
            status: 500,
            headers: corsHeaders
        });
    }
}

addEventListener("fetch", event => {
    event.respondWith(handleRequest(event.request));
});

if (typeof module !== "undefined") {
    module.exports = {
        WORKER_INFO,
        FLOW_ENTITIES,
        FlowEntityType,
        createPacket,
        startFlow,
        handleRequest
    };
}
