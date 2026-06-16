/**
 * THREAT INTELLIGENCE EDGE WORKER — INTELLIGENTIA MINAX LIMITIS
 * "Scientia minacis propagatur. Rete defendit omnes."
 * (Threat knowledge propagates. Network defends all.)
 *
 * Web Worker #26: AUTONOMOUS EDGE INTELLIGENCE (PROT-109)
 * Self-learning threat patterns with inter-edge gossip protocol.
 *
 * LEARNING SOURCES:
 *   1. Observed attacks - Extracts patterns from blocked requests
 *   2. Inter-edge gossip - Shares intel across edge network at 7.83Hz
 *   3. Temporal analysis - Detects trends using Fibonacci windows
 *
 * GOSSIP PROTOCOL:
 *   Frequency: 7.83Hz (Schumann resonance)
 *   Vector encoding: φ-weighted feature vectors
 *   Update threshold: φ² (4.236) confidence
 *   Propagation: Exponential with φ decay
 *
 * FIBONACCI TIME WINDOWS:
 *   [1min, 1min, 2min, 3min, 5min, 8min, 13min, 21min]
 *   Detects attack patterns across ancient harmonic time scales
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

const PHI = 1.618033988749895;
const PHI_SQ = 2.618033988749895;
const SCHUMANN = 7.83;
const HEARTBEAT_MS = 873;
const GOSSIP_INTERVAL_MS = Math.floor(1000 / SCHUMANN); // 7.83Hz

const bootTime = Date.now();
let beatCount = 0;
let queryCount = 0;
let threatsLearned = 0;
let gossipsSent = 0;
let patternsShared = 0;

// Threat knowledge base (edge-local learning)
const threatKnowledgeBase = [];
const MAX_THREAT_PATTERNS = 1000;

// Fibonacci time windows (milliseconds)
const FIBONACCI_WINDOWS = [
  60000,    // 1 min
  60000,    // 1 min
  120000,   // 2 min
  180000,   // 3 min
  300000,   // 5 min
  480000,   // 8 min
  780000,   // 13 min
  1260000   // 21 min
];

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 1: THREAT PATTERN LEARNING
// ═══════════════════════════════════════════════════════════════════════════

function learnFromAttack(request, blocked) {
  if (!blocked) return null;

  // Extract features from blocked request
  const features = extractFeatures(request);

  // Encode as φ-weighted vector
  const threatVector = encodePhiVector(features);

  // Calculate confidence (based on similar past threats)
  const confidence = calculateConfidence(threatVector);

  const pattern = {
    id: `threat_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
    vector: threatVector,
    features: features,
    confidence: confidence,
    firstSeen: Date.now(),
    lastSeen: Date.now(),
    count: 1,
    source: 'observed'
  };

  // Add to knowledge base
  threatKnowledgeBase.push(pattern);
  threatsLearned++;

  // Prune if exceeds limit
  if (threatKnowledgeBase.length > MAX_THREAT_PATTERNS) {
    // Remove oldest, lowest confidence
    threatKnowledgeBase.sort((a, b) => {
      const scoreA = a.confidence * Math.pow(PHI, -(Date.now() - a.lastSeen) / 3600000);
      const scoreB = b.confidence * Math.pow(PHI, -(Date.now() - b.lastSeen) / 3600000);
      return scoreA - scoreB;
    });
    threatKnowledgeBase.shift();
  }

  // Share if confidence exceeds threshold
  if (confidence >= PHI_SQ) {
    queueForGossip(pattern);
  }

  return pattern;
}

function extractFeatures(request) {
  const features = {
    method: request.method || 'unknown',
    pathLength: (request.path || '').length,
    hasScript: /script/i.test(request.payload || ''),
    hasSqlInjection: /union.*select|drop.*table/i.test(request.payload || ''),
    hasXss: /<.*?>/i.test(request.payload || ''),
    hasPathTraversal: /\.\.\//g.test(request.payload || ''),
    payloadSize: (request.payload || '').length,
    headerCount: request.headers ? Object.keys(request.headers).length : 0,
    userAgentSuspicious: /bot|crawler|spider|scraper/i.test(request.userAgent || ''),
    rateLimitExceeded: request.rateLimitExceeded || false
  };

  return features;
}

function encodePhiVector(features) {
  // Encode features as φ-weighted vector
  return [
    features.pathLength * PHI,
    features.hasScript ? PHI_SQ : 0,
    features.hasSqlInjection ? PHI_SQ * PHI : 0,
    features.hasXss ? PHI_SQ : 0,
    features.hasPathTraversal ? PHI_SQ : 0,
    features.payloadSize / 1000 * PHI,
    features.headerCount * PHI,
    features.userAgentSuspicious ? PHI : 0,
    features.rateLimitExceeded ? PHI_SQ * PHI : 0
  ];
}

function calculateConfidence(vector) {
  // Calculate confidence based on similarity to existing threats
  if (threatKnowledgeBase.length === 0) return 1.0;

  let maxSimilarity = 0.0;

  for (const pattern of threatKnowledgeBase) {
    const similarity = cosineSimilarity(vector, pattern.vector);
    if (similarity > maxSimilarity) {
      maxSimilarity = similarity;
    }
  }

  // Confidence = similarity to known threats
  return maxSimilarity;
}

function cosineSimilarity(vecA, vecB) {
  if (vecA.length !== vecB.length) return 0.0;

  let dotProduct = 0.0;
  let normA = 0.0;
  let normB = 0.0;

  for (let i = 0; i < vecA.length; i++) {
    dotProduct += vecA[i] * vecB[i];
    normA += vecA[i] * vecA[i];
    normB += vecB[i] * vecB[i];
  }

  if (normA === 0 || normB === 0) return 0.0;

  return dotProduct / (Math.sqrt(normA) * Math.sqrt(normB));
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 2: INTER-EDGE GOSSIP PROTOCOL
// ═══════════════════════════════════════════════════════════════════════════

const gossipQueue = [];

function queueForGossip(pattern) {
  gossipQueue.push(pattern);
  patternsShared++;
}

function performGossip() {
  if (gossipQueue.length === 0) return;

  // Send gossip message (in real implementation, this would use BroadcastChannel or postMessage)
  const gossipMessage = {
    type: 'threat_gossip',
    workerId: 26,
    timestamp: Date.now(),
    patterns: gossipQueue.splice(0, Math.min(10, gossipQueue.length)), // Send up to 10 at a time
    frequency: SCHUMANN,
    phiSignature: PHI
  };

  gossipsSent++;

  // Simulate broadcasting (in production: send to other edge workers)
  self.postMessage({
    type: 'gossip_broadcast',
    message: gossipMessage
  });
}

function receiveGossip(gossipMessage) {
  if (!gossipMessage || !gossipMessage.patterns) return;

  let patternsAdded = 0;

  for (const pattern of gossipMessage.patterns) {
    // Check if pattern confidence exceeds threshold
    if (pattern.confidence >= PHI_SQ) {
      // Check if we already have similar pattern
      const hasSimilar = threatKnowledgeBase.some(existing => {
        const similarity = cosineSimilarity(pattern.vector, existing.vector);
        return similarity > 0.9;
      });

      if (!hasSimilar) {
        pattern.source = 'gossip';
        pattern.receivedAt = Date.now();
        threatKnowledgeBase.push(pattern);
        patternsAdded++;
      }
    }
  }

  return {
    received: gossipMessage.patterns.length,
    added: patternsAdded,
    timestamp: Date.now()
  };
}

// Start gossip protocol at Schumann frequency (7.83Hz)
setInterval(performGossip, GOSSIP_INTERVAL_MS);

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 3: TEMPORAL ANALYSIS (Fibonacci Windows)
// ═══════════════════════════════════════════════════════════════════════════

function analyzeTemporalTrends() {
  const now = Date.now();
  const trends = [];

  for (const window of FIBONACCI_WINDOWS) {
    const windowStart = now - window;

    // Count threats in this window
    const threatsInWindow = threatKnowledgeBase.filter(p => p.firstSeen >= windowStart);

    // Detect emerging patterns
    const emergingPatterns = detectEmergingPatterns(threatsInWindow);

    trends.push({
      window: window,
      windowName: `${window / 60000} min`,
      threatCount: threatsInWindow.length,
      emergingPatterns: emergingPatterns.length,
      patterns: emergingPatterns
    });
  }

  return trends;
}

function detectEmergingPatterns(threats) {
  // Group by similar vectors
  const clusters = [];

  for (const threat of threats) {
    let addedToCluster = false;

    for (const cluster of clusters) {
      const similarity = cosineSimilarity(threat.vector, cluster.centroid);
      if (similarity > 0.8) {
        cluster.threats.push(threat);
        addedToCluster = true;
        break;
      }
    }

    if (!addedToCluster) {
      clusters.push({
        centroid: threat.vector,
        threats: [threat]
      });
    }
  }

  // Return clusters with multiple occurrences (emerging patterns)
  return clusters
    .filter(c => c.threats.length >= 3)
    .map(c => ({
      threatCount: c.threats.length,
      confidence: c.threats.reduce((sum, t) => sum + t.confidence, 0) / c.threats.length,
      firstSeen: Math.min(...c.threats.map(t => t.firstSeen)),
      lastSeen: Math.max(...c.threats.map(t => t.lastSeen))
    }));
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 4: MESSAGE HANDLING
// ═══════════════════════════════════════════════════════════════════════════

self.onmessage = function(e) {
  const msg = e.data;
  if (!msg || !msg.type) return;

  queryCount++;

  switch (msg.type) {
    case 'learn': {
      const pattern = learnFromAttack(msg.request, msg.blocked);
      self.postMessage({
        type: 'learned',
        pattern: pattern,
        queryId: queryCount
      });
      break;
    }

    case 'gossip_receive': {
      const result = receiveGossip(msg.gossipMessage);
      self.postMessage({
        type: 'gossip_received',
        result: result,
        queryId: queryCount
      });
      break;
    }

    case 'analyze_trends': {
      const trends = analyzeTemporalTrends();
      self.postMessage({
        type: 'trends_result',
        trends: trends,
        queryId: queryCount
      });
      break;
    }

    case 'get_knowledge': {
      self.postMessage({
        type: 'knowledge_result',
        patterns: threatKnowledgeBase,
        count: threatKnowledgeBase.length,
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
// SECTION 5: STATUS & MANIFEST
// ═══════════════════════════════════════════════════════════════════════════

function getStatus() {
  return {
    worker: 'threat-intelligence-edge',
    workerId: 26,
    workerName: 'INTELLIGENTIA MINAX LIMITIS',
    uptime: Date.now() - bootTime,
    beat: beatCount,
    queries: queryCount,
    threatsLearned: threatsLearned,
    gossipsSent: gossipsSent,
    patternsShared: patternsShared,
    knowledgeBaseSize: threatKnowledgeBase.length,
    capabilities: ['learn', 'gossip_receive', 'analyze_trends', 'get_knowledge', 'status', 'manifest'],
    gossipFrequency: SCHUMANN,
    updateThreshold: PHI_SQ,
    frequency_Hz: PHI,
    primitiveTrace: 'φ = 1.618...'
  };
}

function getManifest() {
  return {
    id: 'WORKER-026',
    name: 'Threat Intelligence Edge Worker',
    latinName: 'INTELLIGENTIA MINAX LIMITIS',
    latinMotto: 'Scientia minacis propagatur',
    latinMottoEN: 'Threat knowledge propagates',
    protocol: 'PROT-109',
    learningSources: ['observed_attacks', 'inter_edge_gossip', 'temporal_analysis'],
    gossipProtocol: {
      frequency: '7.83Hz (Schumann)',
      encoding: 'φ-weighted vectors',
      updateThreshold: 'φ² = 4.236'
    },
    fibonacciWindows: FIBONACCI_WINDOWS.map(w => `${w / 60000}min`),
    knowledgeBase: 'Edge-local learning (max 1000 patterns)',
    propagation: 'Exponential with φ decay',
    cyclesSaved: 'Zero canister cycles for learning',
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
    worker: 'threat-intelligence-edge'
  });
}, HEARTBEAT_MS);

// Boot message
self.postMessage({
  type: 'booted',
  worker: 'threat-intelligence-edge',
  workerId: 26,
  workerName: 'INTELLIGENTIA MINAX LIMITIS',
  gossipFrequency: SCHUMANN,
  frequency_Hz: PHI,
  timestamp: Date.now()
});
