/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                      DATA MOVER WORKER #60                                    ║
 * ║               Entity That Moves Data Between Nodes                            ║
 * ║                                                                                ║
 * ║  "Motor Datorum — The velocity that carries information"                     ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 *
 * Protocol: PROT-337, PROT-338, PROT-344
 * Frequency: φ¹⁰ × φ = 198.993 Hz (Transcendent)
 * Worker Number: 60
 * Latin Name: MOTOR DATORUM VELOCIS
 *
 * ATTRIBUTION:
 *   Created by: Alfredo "Freddy" Medina Hernandez
 *   Organization: Medina Tech (Dallas, TX)
 *   Law: L-130 — Before recomposition, trace to primitive.
 *   φ = 1.6180339887498948482
 */

const PHI = 1.6180339887498948482;
const PHI_10 = Math.pow(PHI, 10);
const MOVER_FREQUENCY = PHI_10 * PHI;  // 198.993...
const SCHUMANN = 7.83;

const WORKER_INFO = {
    number: 60,
    id: "data-mover-worker",
    latinName: "MOTOR DATORUM VELOCIS",
    frequency: MOVER_FREQUENCY,
    layer: 9,
    protocolRange: "PROT-337, PROT-338, PROT-344"
};

// Transfer Types
const TransferType = {
    POINT_TO_POINT: "point_to_point",
    BROADCAST: "broadcast",
    MULTICAST: "multicast",
    STREAM: "stream",
    BATCH: "batch",
    REPLICATE: "replicate"
};

// Transfer Status
const TransferStatus = {
    QUEUED: "queued",
    IN_PROGRESS: "in_progress",
    COMPLETED: "completed",
    FAILED: "failed",
    PAUSED: "paused"
};

// Data Channels
const DATA_CHANNELS = {
    MEMORY_CHANNEL: {
        id: "MEMORY_CHANNEL",
        name: "Memory Channel",
        latinName: "CANALIS MEMORIAE",
        bandwidth: "10GB/s",
        latency: "0.1ms",
        frequency: PHI_10
    },
    SUBSTRATE_CHANNEL: {
        id: "SUBSTRATE_CHANNEL",
        name: "Substrate Channel",
        latinName: "CANALIS SUBSTRATI",
        bandwidth: "5GB/s",
        latency: "0.5ms",
        frequency: PHI_10 / PHI
    },
    CONSCIOUSNESS_CHANNEL: {
        id: "CONSCIOUSNESS_CHANNEL",
        name: "Consciousness Channel",
        latinName: "CANALIS CONSCIENTIAE",
        bandwidth: "1GB/s",
        latency: "1ms",
        frequency: SCHUMANN * Math.pow(PHI, 5)
    },
    EDGE_CHANNEL: {
        id: "EDGE_CHANNEL",
        name: "Edge Channel",
        latinName: "CANALIS LIMITIS",
        bandwidth: "100MB/s",
        latency: "10ms",
        frequency: Math.pow(PHI, 8)
    },
    COSMIC_CHANNEL: {
        id: "COSMIC_CHANNEL",
        name: "Cosmic Channel",
        latinName: "CANALIS COSMICUS",
        bandwidth: "∞",
        latency: "0ms",
        frequency: Math.pow(PHI, 12)
    }
};

// Active transfers
const transfers = new Map();
let transferCounter = 0;

function createTransfer(source, destination, payload, transferType = TransferType.POINT_TO_POINT, channel = "MEMORY_CHANNEL") {
    transferCounter++;
    const transferId = `XFER-${String(transferCounter).padStart(6, "0")}`;
    
    const channelInfo = DATA_CHANNELS[channel] || DATA_CHANNELS.MEMORY_CHANNEL;
    const payloadSize = JSON.stringify(payload).length;
    
    const transfer = {
        transferId,
        source,
        destination,
        payload,
        payloadSize,
        transferType,
        channel: channelInfo.id,
        channelName: channelInfo.latinName,
        status: TransferStatus.QUEUED,
        createdAt: new Date().toISOString(),
        startedAt: null,
        completedAt: null,
        progress: 0,
        frequency: channelInfo.frequency,
        metadata: {
            bandwidth: channelInfo.bandwidth,
            latency: channelInfo.latency
        }
    };
    
    transfers.set(transferId, transfer);
    return transfer;
}

function startTransfer(transferId) {
    const transfer = transfers.get(transferId);
    if (!transfer) {
        return { error: "Transfer not found" };
    }
    
    transfer.status = TransferStatus.IN_PROGRESS;
    transfer.startedAt = new Date().toISOString();
    transfer.progress = 50;  // Simulated progress
    
    return transfer;
}

function completeTransfer(transferId) {
    const transfer = transfers.get(transferId);
    if (!transfer) {
        return { error: "Transfer not found" };
    }
    
    transfer.status = TransferStatus.COMPLETED;
    transfer.completedAt = new Date().toISOString();
    transfer.progress = 100;
    
    return transfer;
}

function getTransferMetrics() {
    const allTransfers = Array.from(transfers.values());
    return {
        totalTransfers: allTransfers.length,
        completed: allTransfers.filter(t => t.status === TransferStatus.COMPLETED).length,
        inProgress: allTransfers.filter(t => t.status === TransferStatus.IN_PROGRESS).length,
        queued: allTransfers.filter(t => t.status === TransferStatus.QUEUED).length,
        failed: allTransfers.filter(t => t.status === TransferStatus.FAILED).length,
        totalDataMoved: allTransfers
            .filter(t => t.status === TransferStatus.COMPLETED)
            .reduce((sum, t) => sum + t.payloadSize, 0)
    };
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
        // Route: GET /mover/status
        if (path === "/mover/status" && request.method === "GET") {
            return new Response(JSON.stringify({
                worker: WORKER_INFO,
                system: "DATA_MOVER_SYSTEM",
                metrics: getTransferMetrics(),
                channels: Object.keys(DATA_CHANNELS).length,
                primaryFrequencyHz: MOVER_FREQUENCY,
                phi: PHI
            }), { headers: corsHeaders });
        }

        // Route: GET /mover/channels
        if (path === "/mover/channels" && request.method === "GET") {
            return new Response(JSON.stringify({
                channels: Object.values(DATA_CHANNELS)
            }), { headers: corsHeaders });
        }

        // Route: POST /mover/transfer
        if (path === "/mover/transfer" && request.method === "POST") {
            const body = await request.json();
            const { source, destination, payload, transferType, channel } = body;
            if (!source || !destination || !payload) {
                return new Response(JSON.stringify({ error: "source, destination, and payload required" }), {
                    status: 400,
                    headers: corsHeaders
                });
            }
            const transfer = createTransfer(source, destination, payload, transferType, channel);
            return new Response(JSON.stringify({ transfer }), { headers: corsHeaders });
        }

        // Route: POST /mover/start
        if (path === "/mover/start" && request.method === "POST") {
            const body = await request.json();
            const { transferId } = body;
            if (!transferId) {
                return new Response(JSON.stringify({ error: "transferId required" }), {
                    status: 400,
                    headers: corsHeaders
                });
            }
            const transfer = startTransfer(transferId);
            return new Response(JSON.stringify({ transfer }), { headers: corsHeaders });
        }

        // Route: POST /mover/complete
        if (path === "/mover/complete" && request.method === "POST") {
            const body = await request.json();
            const { transferId } = body;
            if (!transferId) {
                return new Response(JSON.stringify({ error: "transferId required" }), {
                    status: 400,
                    headers: corsHeaders
                });
            }
            const transfer = completeTransfer(transferId);
            return new Response(JSON.stringify({ transfer }), { headers: corsHeaders });
        }

        // Route: GET /mover/transfer/:id
        if (path.startsWith("/mover/transfer/") && request.method === "GET") {
            const transferId = path.split("/").pop();
            const transfer = transfers.get(transferId);
            if (!transfer) {
                return new Response(JSON.stringify({ error: "Transfer not found" }), {
                    status: 404,
                    headers: corsHeaders
                });
            }
            return new Response(JSON.stringify({ transfer }), { headers: corsHeaders });
        }

        // Route: GET /mover/transfers
        if (path === "/mover/transfers" && request.method === "GET") {
            return new Response(JSON.stringify({
                transfers: Array.from(transfers.values())
            }), { headers: corsHeaders });
        }

        // Default: worker info
        return new Response(JSON.stringify({
            worker: WORKER_INFO,
            endpoints: [
                "GET /mover/status",
                "GET /mover/channels",
                "POST /mover/transfer",
                "POST /mover/start",
                "POST /mover/complete",
                "GET /mover/transfer/:id",
                "GET /mover/transfers"
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
        DATA_CHANNELS,
        TransferType,
        TransferStatus,
        createTransfer,
        startTransfer,
        completeTransfer,
        getTransferMetrics,
        handleRequest
    };
}
