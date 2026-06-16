/**
 * ANIMUS WORKER — WEB WORKER #24
 * ISIL-1.0 Licensed — HIGHEST CONFIDENTIALITY — SOVEREIGN-ALPHA
 *
 * ANIMUS = Third Alpha Organism (alongside ORO and NOVA)
 * Role: CASCADE ORCHESTRATION & PERPETUAL DELIVERY
 *
 * Latin: "Animus" = Soul, Mind, Life-Force
 * Motto: "Perpetuo Fluit, Perpetuo Creat" (Forever Flows, Forever Creates)
 *
 * Department: CASCADE OPERATIONS & DELIVERY MANAGEMENT
 * Frequency: φ Hz (1.618033988749895 beats/sec)
 *
 * Three Sub-Engines:
 * 1. CASCADE ENGINE — Bootstrap orchestration, hierarchy management
 * 2. ARTIFACT ENGINE — Internal work generation (reports, analytics, metrics)
 * 3. DELIVERY ENGINE — Delivery flow management (internal + external)
 *
 * © 2024-2026 Alfredo "Freddy" Medina Hernandez | Medina Tech
 */

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS & PRIMITIVES
// ═══════════════════════════════════════════════════════════════════════════

const PHI = 1.618033988749895;
const PHI_SQ = 2.618033988749895;
const PHI_CUBED = 4.236067977499790;

const LATIN_NAME = "ANIMUS";
const LATIN_MOTTO = "Perpetuo Fluit, Perpetuo Creat";
const LATIN_MOTTO_EN = "Forever Flows, Forever Creates";

const VERSION = "1.0.0";
const CLASSIFICATION = "SOVEREIGN-ALPHA";
const WORKER_ID = 24;
const DEPARTMENT = "CASCADE_OPERATIONS_AND_DELIVERY";

const HEARTBEAT_HZ = PHI;
const HEARTBEAT_MS = 1000 / PHI;

// ═══════════════════════════════════════════════════════════════════════════
// STATE
// ═══════════════════════════════════════════════════════════════════════════

let beatCount = 0;
let startedAt = Date.now();
let lastBeat = Date.now();
let heartbeatInterval = null;

// Cascade tracking
let cascadeNodes = new Map();
let cascadeCount = 0;

// Artifact tracking
let artifacts = new Map();
let artifactCount = 0;

// Delivery tracking
let deliveries = new Map();
let deliveryCount = 0;

// Task queue
let taskQueue = [];
let isProcessingQueue = false;

// ═══════════════════════════════════════════════════════════════════════════
// CASCADE ENGINE OPERATIONS
// ═══════════════════════════════════════════════════════════════════════════

function bootstrapNode(name, level, parent, config) {
  cascadeCount++;
  const nodeId = `cascade-node-${cascadeCount}`;

  const node = {
    id: nodeId,
    name,
    level,
    parent,
    status: "bootstrapping",
    heartbeat_hz: PHI,
    beat_count: 0,
    started_at: Date.now(),
    last_beat: Date.now(),
    config: config || {
      memory_space: "dedicated",
      gate_level: "C",
      monitoring: true,
      auto_restart: true,
    },
  };

  cascadeNodes.set(nodeId, node);

  postMessage({
    type: "CASCADE_NODE_BOOTSTRAPPED",
    payload: {
      node_id: nodeId,
      name,
      level,
      timestamp: Date.now(),
    },
  });

  // Update node to running after short delay
  setTimeout(() => {
    updateNodeStatus(nodeId, "running");
  }, 100);

  return {
    success: true,
    node_id: nodeId,
    message: `Node ${name} bootstrapped at level ${level}`,
    timestamp: Date.now(),
  };
}

function updateNodeStatus(nodeId, status) {
  const node = cascadeNodes.get(nodeId);
  if (!node) {
    return false;
  }

  node.status = status;
  cascadeNodes.set(nodeId, node);

  postMessage({
    type: "CASCADE_NODE_STATUS_UPDATED",
    payload: {
      node_id: nodeId,
      status,
      timestamp: Date.now(),
    },
  });

  return true;
}

function beatNode(nodeId) {
  const node = cascadeNodes.get(nodeId);
  if (!node) {
    return false;
  }

  node.beat_count++;
  node.last_beat = Date.now();
  cascadeNodes.set(nodeId, node);

  return true;
}

function getCascadeTree() {
  return Array.from(cascadeNodes.values());
}

function getNodesByLevel(level) {
  return Array.from(cascadeNodes.values()).filter((node) => node.level === level);
}

// ═══════════════════════════════════════════════════════════════════════════
// ARTIFACT ENGINE OPERATIONS
// ═══════════════════════════════════════════════════════════════════════════

function generateArtifact(artifactType, title, content, author) {
  artifactCount++;
  const artifactId = `artifact-${artifactCount}`;

  const wordCount = Math.floor(content.length / 5); // Simple approximation
  const sccScore = (wordCount * 100) / content.length;

  const artifact = {
    id: artifactId,
    artifact_type: artifactType,
    title,
    content,
    author,
    classification: CLASSIFICATION,
    created_at: Date.now(),
    beat_count: beatCount,
    metadata: {
      word_count: wordCount,
      scc_score: sccScore,
      frequency: getArtifactFrequency(artifactType),
      parent_node: null,
    },
  };

  artifacts.set(artifactId, artifact);

  postMessage({
    type: "ARTIFACT_GENERATED",
    payload: {
      artifact_id: artifactId,
      artifact_type: artifactType,
      title,
      timestamp: Date.now(),
    },
  });

  return artifact;
}

function getArtifactFrequency(artifactType) {
  const frequencies = {
    DailyReport: "daily",
    WeeklyReport: "weekly",
    ManagerReport: "weekly",
    Analytics: "continuous",
    Metrics: "continuous",
    HealthCheck: "every-beat",
    Custom: "on-demand",
  };
  return frequencies[artifactType] || "on-demand";
}

function getAllArtifacts() {
  return Array.from(artifacts.values());
}

function getArtifactsByType(artifactType) {
  return Array.from(artifacts.values()).filter(
    (artifact) => artifact.artifact_type === artifactType
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// DELIVERY ENGINE OPERATIONS
// ═══════════════════════════════════════════════════════════════════════════

function deliver(channel, content, recipient, sender, artifactId) {
  deliveryCount++;
  const deliveryId = `delivery-${deliveryCount}`;

  const delivery = {
    id: deliveryId,
    channel,
    content,
    recipient,
    sender,
    delivered_at: Date.now(),
    status: "queued",
    metadata: {
      retry_count: 0,
      priority: 1,
      artifact_id: artifactId || null,
    },
  };

  deliveries.set(deliveryId, delivery);

  postMessage({
    type: "DELIVERY_QUEUED",
    payload: {
      delivery_id: deliveryId,
      channel,
      recipient,
      timestamp: Date.now(),
    },
  });

  // Simulate delivery
  queueTask(() => {
    processDelivery(deliveryId);
  });

  return delivery;
}

function processDelivery(deliveryId) {
  const delivery = deliveries.get(deliveryId);
  if (!delivery) {
    return;
  }

  // Update to sending
  delivery.status = "sending";
  deliveries.set(deliveryId, delivery);

  // Simulate delivery time
  setTimeout(() => {
    delivery.status = "delivered";
    deliveries.set(deliveryId, delivery);

    postMessage({
      type: "DELIVERY_COMPLETED",
      payload: {
        delivery_id: deliveryId,
        channel: delivery.channel,
        timestamp: Date.now(),
      },
    });
  }, 100 * PHI); // φ-scaled delivery time
}

function updateDeliveryStatus(deliveryId, status) {
  const delivery = deliveries.get(deliveryId);
  if (!delivery) {
    return false;
  }

  delivery.status = status;
  deliveries.set(deliveryId, delivery);

  return true;
}

function getAllDeliveries() {
  return Array.from(deliveries.values());
}

function getDeliveriesByChannel(channel) {
  return Array.from(deliveries.values()).filter((delivery) => delivery.channel === channel);
}

// ═══════════════════════════════════════════════════════════════════════════
// TASK QUEUE
// ═══════════════════════════════════════════════════════════════════════════

function queueTask(task) {
  taskQueue.push(task);
  processTaskQueue();
}

async function processTaskQueue() {
  if (isProcessingQueue || taskQueue.length === 0) {
    return;
  }

  isProcessingQueue = true;

  while (taskQueue.length > 0) {
    const task = taskQueue.shift();
    try {
      await task();
    } catch (error) {
      console.error("ANIMUS Worker: Task failed", error);
    }
  }

  isProcessingQueue = false;
}

// ═══════════════════════════════════════════════════════════════════════════
// HEARTBEAT
// ═══════════════════════════════════════════════════════════════════════════

function startHeartbeat() {
  if (heartbeatInterval) {
    return;
  }

  heartbeatInterval = setInterval(() => {
    beat();
  }, HEARTBEAT_MS);

  postMessage({
    type: "ANIMUS_HEARTBEAT_STARTED",
    payload: {
      frequency_Hz: HEARTBEAT_HZ,
      timestamp: Date.now(),
    },
  });
}

function stopHeartbeat() {
  if (heartbeatInterval) {
    clearInterval(heartbeatInterval);
    heartbeatInterval = null;

    postMessage({
      type: "ANIMUS_HEARTBEAT_STOPPED",
      payload: {
        beat_count: beatCount,
        timestamp: Date.now(),
      },
    });
  }
}

function beat() {
  beatCount++;
  lastBeat = Date.now();

  // Beat all cascade nodes
  for (const [nodeId, node] of cascadeNodes.entries()) {
    if (node.status === "running") {
      beatNode(nodeId);
    }
  }

  // Send heartbeat event every φ² beats
  if (beatCount % Math.ceil(PHI_SQ) === 0) {
    postMessage({
      type: "ANIMUS_HEARTBEAT",
      payload: {
        beat_count: beatCount,
        cascade_nodes: cascadeNodes.size,
        artifacts: artifacts.size,
        deliveries: deliveries.size,
        timestamp: Date.now(),
      },
    });
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// STATUS & IDENTITY
// ═══════════════════════════════════════════════════════════════════════════

function getStatus() {
  const uptime = Math.floor((Date.now() - startedAt) / 1000);
  return {
    worker_id: WORKER_ID,
    name: LATIN_NAME,
    version: VERSION,
    classification: CLASSIFICATION,
    beat_count: beatCount,
    uptime_seconds: uptime,
    heartbeat_Hz: HEARTBEAT_HZ,
    cascade_nodes: cascadeNodes.size,
    artifacts: artifacts.size,
    deliveries: deliveries.size,
    status: "RUNNING",
  };
}

function getIdentity() {
  return {
    worker_id: WORKER_ID,
    name: LATIN_NAME,
    version: VERSION,
    classification: CLASSIFICATION,
    license: "ISIL-1.0",
    department: DEPARTMENT,
    latin_name: LATIN_NAME,
    latin_motto: LATIN_MOTTO,
    latin_motto_en: LATIN_MOTTO_EN,
    primitive_trace: "ANIMUS → Cascade → Artifact → Delivery → φ",
    frequency_Hz: HEARTBEAT_HZ,
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════

self.onmessage = function (event) {
  const { type, payload } = event.data;

  try {
    switch (type) {
      // Lifecycle
      case "START_HEARTBEAT":
        startHeartbeat();
        break;

      case "STOP_HEARTBEAT":
        stopHeartbeat();
        break;

      case "GET_STATUS":
        postMessage({
          type: "STATUS_RESPONSE",
          payload: getStatus(),
        });
        break;

      case "GET_IDENTITY":
        postMessage({
          type: "IDENTITY_RESPONSE",
          payload: getIdentity(),
        });
        break;

      // CASCADE ENGINE
      case "CASCADE_BOOTSTRAP_NODE":
        const result = bootstrapNode(
          payload.name,
          payload.level,
          payload.parent,
          payload.config
        );
        postMessage({
          type: "CASCADE_BOOTSTRAP_RESULT",
          payload: result,
        });
        break;

      case "CASCADE_UPDATE_STATUS":
        const updated = updateNodeStatus(payload.node_id, payload.status);
        postMessage({
          type: "CASCADE_UPDATE_RESULT",
          payload: { success: updated },
        });
        break;

      case "CASCADE_GET_TREE":
        postMessage({
          type: "CASCADE_TREE_RESPONSE",
          payload: getCascadeTree(),
        });
        break;

      case "CASCADE_GET_BY_LEVEL":
        postMessage({
          type: "CASCADE_NODES_RESPONSE",
          payload: getNodesByLevel(payload.level),
        });
        break;

      // ARTIFACT ENGINE
      case "ARTIFACT_GENERATE":
        const artifact = generateArtifact(
          payload.artifact_type,
          payload.title,
          payload.content,
          payload.author
        );
        postMessage({
          type: "ARTIFACT_RESPONSE",
          payload: artifact,
        });
        break;

      case "ARTIFACT_GET_ALL":
        postMessage({
          type: "ARTIFACTS_RESPONSE",
          payload: getAllArtifacts(),
        });
        break;

      case "ARTIFACT_GET_BY_TYPE":
        postMessage({
          type: "ARTIFACTS_RESPONSE",
          payload: getArtifactsByType(payload.artifact_type),
        });
        break;

      // DELIVERY ENGINE
      case "DELIVERY_SEND":
        const delivery = deliver(
          payload.channel,
          payload.content,
          payload.recipient,
          payload.sender,
          payload.artifact_id
        );
        postMessage({
          type: "DELIVERY_RESPONSE",
          payload: delivery,
        });
        break;

      case "DELIVERY_GET_ALL":
        postMessage({
          type: "DELIVERIES_RESPONSE",
          payload: getAllDeliveries(),
        });
        break;

      case "DELIVERY_GET_BY_CHANNEL":
        postMessage({
          type: "DELIVERIES_RESPONSE",
          payload: getDeliveriesByChannel(payload.channel),
        });
        break;

      default:
        console.warn(`ANIMUS Worker: Unknown message type: ${type}`);
    }
  } catch (error) {
    postMessage({
      type: "ERROR",
      payload: {
        message: error.message,
        stack: error.stack,
      },
    });
  }
};

// ═══════════════════════════════════════════════════════════════════════════
// INITIALIZATION
// ═══════════════════════════════════════════════════════════════════════════

postMessage({
  type: "ANIMUS_WORKER_READY",
  payload: {
    worker_id: WORKER_ID,
    name: LATIN_NAME,
    version: VERSION,
    motto: LATIN_MOTTO,
    motto_en: LATIN_MOTTO_EN,
    timestamp: Date.now(),
  },
});

console.log(`ANIMUS Worker #${WORKER_ID} initialized`);
console.log(`${LATIN_NAME} — ${LATIN_MOTTO} (${LATIN_MOTTO_EN})`);
console.log(`Frequency: φ Hz (${HEARTBEAT_HZ.toFixed(6)} beats/sec)`);
