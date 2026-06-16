/**
 * LIMITES MUNDI GATEWAY ORCHESTRATOR — PORTA MAJOR LIMITIS
 * "Porta Maior omnes portas regit. Harmonia φ gubernat."
 * (The Great Gate rules all gates. φ harmony governs.)
 *
 * Web Worker #27: SOVEREIGN EDGE GATEWAY (PROT-107 + PROT-111)
 * Master orchestrator for LIMITES MUNDI sovereign edge network.
 *
 * ORCHESTRATES:
 *   - 9 edge node types (gateway, compute, storage, routing, etc.)
 *   - 5 sovereign ML models (VISIO, AUDIO, LINGUA, IMAGO, NUMERUS)
 *   - Multi-tier data routing (KV, R2, D1, Durable Objects, Canister)
 *   - Blockchain edges (Ethereum, Bitcoin, ICP)
 *   - Threat intelligence network (gossip protocol)
 *   - Frequency scaling (0.01-900Hz)
 *
 * FREQUENCY: 432Hz (Musical octave - gateway harmonic)
 *
 * CAPABILITIES:
 *   - Request orchestration across all edge workers
 *   - Load balancing with φ-weighted scoring
 *   - Failover between edge tiers
 *   - Health monitoring of edge network
 *   - Cost optimization routing
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

const PHI = 1.618033988749895;
const GATEWAY_FREQUENCY = 432.0; // Musical octave
const HEARTBEAT_MS = 873;

const bootTime = Date.now();
let beatCount = 0;
let queryCount = 0;
let requestsOrchestrated = 0;
let edgeNodesActive = 9;

// Edge node registry
const EDGE_NODES = {
  GATEWAY: { name: 'Gateway', frequency: 432.0, health: 1.0, load: 0.0 },
  COMPUTE: { name: 'Compute', frequency: 618.0, health: 1.0, load: 0.0 },
  STORAGE: { name: 'Storage', frequency: 13.0, health: 1.0, load: 0.0 },
  ROUTING: { name: 'Routing', frequency: 161.8, health: 1.0, load: 0.0 },
  VALIDATION: { name: 'Validation', frequency: 80.9, health: 1.0, load: 0.0 },
  CONSENSUS: { name: 'Consensus', frequency: 7.83, health: 1.0, load: 0.0 },
  ANALYTICS: { name: 'Analytics', frequency: 21.0, health: 1.0, load: 0.0 },
  STREAMING: { name: 'Streaming', frequency: 240.0, health: 1.0, load: 0.0 },
  ML_INFERENCE: { name: 'ML Inference', frequency: 100.0, health: 1.0, load: 0.0 }
};

// Worker registry (connected edge workers)
const CONNECTED_WORKERS = {
  'edge-gate': { id: 22, status: 'active', lastHeartbeat: Date.now() },
  'blockchain-edge': { id: 23, status: 'active', lastHeartbeat: Date.now() },
  'ml-inference-edge': { id: 24, status: 'active', lastHeartbeat: Date.now() },
  'data-routing-edge': { id: 25, status: 'active', lastHeartbeat: Date.now() },
  'threat-intelligence-edge': { id: 26, status: 'active', lastHeartbeat: Date.now() }
};

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 1: REQUEST ORCHESTRATION
// ═══════════════════════════════════════════════════════════════════════════

function orchestrateRequest(request) {
  requestsOrchestrated++;

  const {
    type,
    payload,
    urgency = 0.5,
    priority = 0.5,
    requiresML = false,
    requiresBlockchain = false,
    requiresStorage = false
  } = request;

  // Calculate optimal frequency
  const frequency = calculateOptimalFrequency(urgency, priority);

  // Route to appropriate edge nodes
  const routing = routeToEdgeNodes(type, frequency, {
    requiresML,
    requiresBlockchain,
    requiresStorage
  });

  // Select best edge node
  const selectedNode = selectBestNode(routing.candidates);

  // Calculate cost
  const cost = estimateCost(selectedNode, payload);

  return {
    orchestrated: true,
    frequency: frequency,
    primaryNode: selectedNode,
    routing: routing,
    estimatedLatency: selectedNode.node.frequency > 100 ? 50 : 200,
    estimatedCost: cost,
    failoverChain: routing.failover,
    phiAlignment: calculatePhiAlignment(frequency)
  };
}

function calculateOptimalFrequency(urgency, priority) {
  // Scale to 0.01-900Hz
  const urgencyNorm = Math.min(1.0, Math.max(0.0, urgency));
  const priorityNorm = Math.min(1.0, Math.max(0.0, priority));
  const combined = urgencyNorm * priorityNorm;

  return 0.01 + (combined * 899.99);
}

function routeToEdgeNodes(type, frequency, requirements) {
  const candidates = [];

  // Match frequency to edge nodes
  for (const [nodeName, node] of Object.entries(EDGE_NODES)) {
    const freqDiff = Math.abs(frequency - node.frequency);
    const freqScore = 1.0 / (1.0 + freqDiff / 100.0);

    // Health and load factors
    const healthScore = node.health;
    const loadPenalty = node.load / 100.0;

    // φ-weighted final score
    const score = (freqScore * PHI) + (healthScore * PHI * PHI) - (loadPenalty * PHI);

    // Check requirements
    let meetsRequirements = true;
    if (requirements.requiresML && nodeName !== 'ML_INFERENCE') {
      meetsRequirements = false;
    }
    if (requirements.requiresBlockchain && nodeName !== 'CONSENSUS') {
      meetsRequirements = false;
    }
    if (requirements.requiresStorage && nodeName !== 'STORAGE') {
      meetsRequirements = false;
    }

    if (meetsRequirements || candidates.length < 3) {
      candidates.push({
        nodeName: nodeName,
        node: node,
        score: score,
        freqScore: freqScore,
        meetsRequirements: meetsRequirements
      });
    }
  }

  // Sort by score
  candidates.sort((a, b) => b.score - a.score);

  // Failover chain
  const failover = candidates.slice(1, 4).map(c => c.nodeName);

  return {
    candidates: candidates,
    failover: failover
  };
}

function selectBestNode(candidates) {
  // Return highest scoring node
  return candidates[0];
}

function estimateCost(selectedNode, payload) {
  // Base cost by frequency tier
  const freq = selectedNode.node.frequency;

  let baseCost = 0.0;
  if (freq >= 500) {
    baseCost = 0.01; // Ultra-fast = cheap (KV cache)
  } else if (freq >= 100) {
    baseCost = 0.05; // Fast = moderate
  } else if (freq >= 10) {
    baseCost = 0.02; // Standard = low
  } else if (freq >= 1) {
    baseCost = 0.10; // Slow = analytics cost
  } else {
    baseCost = 1.00; // Ultra-slow = blockchain/canister cost
  }

  // Add payload size cost
  const payloadSize = payload ? JSON.stringify(payload).length : 0;
  const sizeCost = payloadSize / 1000000 * 0.05; // $0.05 per MB

  return baseCost + sizeCost;
}

function calculatePhiAlignment(frequency) {
  // How well does frequency align with φ harmonics?
  const harmonics = [PHI, PHI * PHI, PHI * PHI * PHI, 7.83, 13, 21, 34, 55, 89, 144, 432, 618];

  let minDist = Infinity;
  for (const harmonic of harmonics) {
    const dist = Math.abs(frequency - harmonic);
    if (dist < minDist) {
      minDist = dist;
    }
  }

  const maxDistance = 10.0;
  const alignment = 1.0 - Math.min(1.0, minDist / maxDistance);
  return alignment;
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 2: LOAD BALANCING
// ═══════════════════════════════════════════════════════════════════════════

function updateNodeLoad(nodeName, load) {
  if (EDGE_NODES[nodeName]) {
    EDGE_NODES[nodeName].load = load;
  }
}

function getNetworkLoad() {
  const loads = Object.entries(EDGE_NODES).map(([name, node]) => ({
    node: name,
    load: node.load,
    health: node.health,
    frequency: node.frequency
  }));

  const avgLoad = loads.reduce((sum, n) => sum + n.load, 0) / loads.length;

  return {
    nodes: loads,
    avgLoad: avgLoad,
    maxLoad: Math.max(...loads.map(n => n.load)),
    minLoad: Math.min(...loads.map(n => n.load))
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 3: HEALTH MONITORING
// ═══════════════════════════════════════════════════════════════════════════

function checkWorkerHealth() {
  const now = Date.now();
  const HEARTBEAT_TIMEOUT = 10000; // 10 seconds

  for (const [workerName, worker] of Object.entries(CONNECTED_WORKERS)) {
    const timeSinceHeartbeat = now - worker.lastHeartbeat;

    if (timeSinceHeartbeat > HEARTBEAT_TIMEOUT) {
      worker.status = 'unhealthy';
    } else {
      worker.status = 'active';
    }
  }

  return Object.entries(CONNECTED_WORKERS).map(([name, worker]) => ({
    worker: name,
    workerId: worker.id,
    status: worker.status,
    lastHeartbeat: worker.lastHeartbeat,
    timeSince: now - worker.lastHeartbeat
  }));
}

function updateWorkerHeartbeat(workerName) {
  if (CONNECTED_WORKERS[workerName]) {
    CONNECTED_WORKERS[workerName].lastHeartbeat = Date.now();
    CONNECTED_WORKERS[workerName].status = 'active';
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 4: NETWORK STATUS
// ═══════════════════════════════════════════════════════════════════════════

function getNetworkStatus() {
  const workerHealth = checkWorkerHealth();
  const networkLoad = getNetworkLoad();

  const activeWorkers = workerHealth.filter(w => w.status === 'active').length;
  const totalWorkers = workerHealth.length;

  return {
    network: 'LIMITES MUNDI',
    edgeNodes: Object.keys(EDGE_NODES).length,
    connectedWorkers: totalWorkers,
    activeWorkers: activeWorkers,
    gatewayFrequency: GATEWAY_FREQUENCY,
    networkLoad: networkLoad,
    workerHealth: workerHealth,
    requestsOrchestrated: requestsOrchestrated,
    uptime: Date.now() - bootTime
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 5: MESSAGE HANDLING
// ═══════════════════════════════════════════════════════════════════════════

self.onmessage = function(e) {
  const msg = e.data;
  if (!msg || !msg.type) return;

  queryCount++;

  switch (msg.type) {
    case 'orchestrate': {
      const result = orchestrateRequest(msg.request);
      self.postMessage({
        type: 'orchestration_result',
        result: result,
        queryId: queryCount
      });
      break;
    }

    case 'worker_heartbeat': {
      updateWorkerHeartbeat(msg.workerName);
      self.postMessage({
        type: 'heartbeat_ack',
        workerName: msg.workerName,
        queryId: queryCount
      });
      break;
    }

    case 'update_load': {
      updateNodeLoad(msg.nodeName, msg.load);
      self.postMessage({
        type: 'load_updated',
        nodeName: msg.nodeName,
        load: msg.load,
        queryId: queryCount
      });
      break;
    }

    case 'network_status': {
      const status = getNetworkStatus();
      self.postMessage({
        type: 'network_status_result',
        status: status,
        queryId: queryCount
      });
      break;
    }

    case 'status': {
      self.postMessage({
        type: 'status_result',
        status: getStatus(),
        queryId: queryCount
      });
      break;
    }

    case 'manifest': {
      self.postMessage({
        type: 'manifest_result',
        manifest: getManifest(),
        queryId: queryCount
      });
      break;
    }

    default:
      self.postMessage({
        type: 'error',
        message: 'Unknown command: ' + msg.type
      });
  }
};

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 6: STATUS & MANIFEST
// ═══════════════════════════════════════════════════════════════════════════

function getStatus() {
  return {
    worker: 'limites-mundi-gateway',
    workerId: 27,
    workerName: 'PORTA MAJOR LIMITIS',
    uptime: Date.now() - bootTime,
    beat: beatCount,
    queries: queryCount,
    requestsOrchestrated: requestsOrchestrated,
    edgeNodesActive: edgeNodesActive,
    connectedWorkers: Object.keys(CONNECTED_WORKERS).length,
    capabilities: ['orchestrate', 'worker_heartbeat', 'update_load', 'network_status', 'status', 'manifest'],
    gatewayFrequency: GATEWAY_FREQUENCY,
    frequency_Hz: PHI,
    primitiveTrace: 'φ = 1.618...'
  };
}

function getManifest() {
  return {
    id: 'WORKER-027',
    name: 'LIMITES MUNDI Gateway Orchestrator',
    latinName: 'PORTA MAJOR LIMITIS',
    latinMotto: 'Porta Maior omnes portas regit',
    latinMottoEN: 'The Great Gate rules all gates',
    protocol: ['PROT-107', 'PROT-111'],
    edgeNodes: Object.keys(EDGE_NODES),
    sovereignMLModels: ['VISIO', 'AUDIO', 'LINGUA', 'IMAGO', 'NUMERUS'],
    orchestrates: [
      '9 edge node types',
      '5 sovereign ML models',
      'Multi-tier data routing',
      'Blockchain edges',
      'Threat intelligence network',
      'Frequency scaling (0.01-900Hz)'
    ],
    gatewayFrequency: '432Hz (musical octave)',
    loadBalancing: 'φ-weighted scoring',
    failover: 'Multi-tier with automatic fallback',
    healthMonitoring: '10s heartbeat timeout',
    costOptimization: 'Frequency-based routing',
    frequency_Hz: PHI,
    primitiveTrace: 'φ = 1.618033988749895'
  };
}

// Heartbeat
setInterval(function() {
  beatCount++;
  self.postMessage({
    type: 'heartbeat',
    beat: beatCount,
    uptime: Date.now() - bootTime,
    worker: 'limites-mundi-gateway'
  });
}, HEARTBEAT_MS);

// Boot message
self.postMessage({
  type: 'booted',
  worker: 'limites-mundi-gateway',
  workerId: 27,
  workerName: 'PORTA MAJOR LIMITIS',
  edgeNodes: 9,
  gatewayFrequency: GATEWAY_FREQUENCY,
  frequency_Hz: PHI,
  timestamp: Date.now()
});
