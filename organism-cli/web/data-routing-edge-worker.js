/**
 * DATA ROUTING EDGE WORKER — VIA DATA LIMITIS
 * "Data sua via invenit. Frequentia dirigit omnia."
 * (Data finds its way. Frequency directs all.)
 *
 * Web Worker #25: EDGE DATA ROUTING (PROT-107 extension)
 * Routes data through optimal edge storage/compute based on frequency.
 *
 * ROUTING TIERS:
 *   KV Cache (500-900Hz)      : Hot data, sub-millisecond access
 *   Durable Objects (100-500Hz): Stateful compute, consistent data
 *   R2 Storage (10-100Hz)     : Blob storage, images, files
 *   D1 SQL (1-10Hz)           : Relational queries, analytics
 *   Canister (0.01-1Hz)       : Long-term, consensus-critical data
 *
 * FREQUENCIES:
 *   Ultra-fast: 500-900Hz (KV cache hits)
 *   Fast: 100-500Hz (Durable Objects, real-time)
 *   Standard: 10-100Hz (R2 reads, D1 queries)
 *   Slow: 1-10Hz (D1 analytics, batch)
 *   Ultra-slow: 0.01-1Hz (canister writes, blockchain)
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

const PHI = 1.618033988749895;
const HEARTBEAT_MS = 873;

const bootTime = Date.now();
let beatCount = 0;
let queryCount = 0;
let routingDecisions = 0;

// Storage tier metadata
const STORAGE_TIERS = {
  KV: {
    name: 'Cloudflare KV',
    frequency: 750.0,
    latency: 1,
    cost: 0.5,
    bestFor: ['cache', 'session', 'config']
  },
  DURABLE_OBJECTS: {
    name: 'Durable Objects',
    frequency: 300.0,
    latency: 5,
    cost: 2.0,
    bestFor: ['state', 'coordination', 'locks']
  },
  R2: {
    name: 'Cloudflare R2',
    frequency: 50.0,
    latency: 20,
    cost: 0.1,
    bestFor: ['blobs', 'images', 'files', 'media']
  },
  D1: {
    name: 'Cloudflare D1',
    frequency: 5.0,
    latency: 50,
    cost: 1.0,
    bestFor: ['relational', 'sql', 'analytics']
  },
  CANISTER: {
    name: 'ICP Canister',
    frequency: 0.5,
    latency: 2000,
    cost: 10.0,
    bestFor: ['consensus', 'blockchain', 'permanent']
  }
};

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 1: ROUTING ALGORITHM
// ═══════════════════════════════════════════════════════════════════════════

function routeData(dataType, size, urgency, consistency) {
  routingDecisions++;

  // Calculate optimal frequency
  const urgencyNorm = Math.min(1.0, Math.max(0.0, urgency));
  const baseFreq = 0.01 + (urgencyNorm * 899.99);

  // Calculate φ-weighted scores for each tier
  const scores = {};

  for (const [tier, meta] of Object.entries(STORAGE_TIERS)) {
    // Base score from frequency match
    const freqDiff = Math.abs(baseFreq - meta.frequency);
    const freqScore = 1.0 / (1.0 + freqDiff / 100.0);

    // Latency penalty (scaled by φ)
    const latencyPenalty = meta.latency * PHI / 1000.0;

    // Cost factor (scaled by φ²)
    const costFactor = meta.cost * (PHI * PHI) / 100.0;

    // Consistency bonus for CANISTER/DURABLE_OBJECTS
    const consistencyBonus = consistency ?
      (tier === 'CANISTER' ? 0.5 : tier === 'DURABLE_OBJECTS' ? 0.3 : 0.0) : 0.0;

    // Size penalty for KV (limited to 25MB)
    const sizePenalty = (tier === 'KV' && size > 25000000) ? 1.0 : 0.0;

    // Calculate final score
    scores[tier] = freqScore - latencyPenalty - costFactor + consistencyBonus - sizePenalty;
  }

  // Find best tier
  let bestTier = 'CANISTER';
  let bestScore = -Infinity;

  for (const [tier, score] of Object.entries(scores)) {
    if (score > bestScore) {
      bestScore = score;
      bestTier = tier;
    }
  }

  return {
    tier: bestTier,
    tierMeta: STORAGE_TIERS[bestTier],
    frequency: STORAGE_TIERS[bestTier].frequency,
    score: bestScore,
    allScores: scores,
    reasoning: generateReasoning(bestTier, dataType, size, urgency, consistency)
  };
}

function generateReasoning(tier, dataType, size, urgency, consistency) {
  const reasons = [];

  switch (tier) {
    case 'KV':
      reasons.push('Ultra-fast access required (500-900Hz)');
      reasons.push('Small data size fits KV limits');
      if (urgency > 0.8) reasons.push('High urgency demands sub-ms latency');
      break;

    case 'DURABLE_OBJECTS':
      reasons.push('Stateful compute needed (100-500Hz)');
      if (consistency) reasons.push('Strong consistency required');
      reasons.push('Real-time coordination');
      break;

    case 'R2':
      reasons.push('Blob storage optimal for this data type');
      reasons.push('Standard frequency tier (10-100Hz)');
      if (size > 25000000) reasons.push('Large size requires R2');
      break;

    case 'D1':
      reasons.push('Relational queries needed');
      reasons.push('Analytics/SQL workload (1-10Hz)');
      break;

    case 'CANISTER':
      reasons.push('Blockchain consensus required');
      if (consistency) reasons.push('Permanent, immutable storage');
      reasons.push('Ultra-slow frequency (0.01-1Hz)');
      break;
  }

  return reasons;
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 2: FREQUENCY-BASED CACHING
// ═══════════════════════════════════════════════════════════════════════════

function calculateCacheTTL(frequency) {
  // Higher frequency = shorter TTL (data changes fast)
  // Lower frequency = longer TTL (data stable)

  if (frequency >= 500) {
    return 60; // 1 minute for ultra-fast
  } else if (frequency >= 100) {
    return 300; // 5 minutes for fast
  } else if (frequency >= 10) {
    return 3600; // 1 hour for standard
  } else if (frequency >= 1) {
    return 86400; // 1 day for slow
  } else {
    return 604800; // 1 week for ultra-slow
  }
}

function getCacheStrategy(tier, frequency) {
  const ttl = calculateCacheTTL(frequency);

  return {
    tier: tier,
    frequency: frequency,
    ttl: ttl,
    strategy: frequency >= 100 ? 'write-through' : 'write-back',
    eviction: 'LRU',
    phiScaling: `TTL scaled by φ-harmonic alignment`,
    revalidate: Math.floor(ttl / PHI) // Revalidate at φ fraction of TTL
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 3: MULTI-TIER ROUTING
// ═══════════════════════════════════════════════════════════════════════════

function routeMultiTier(dataType, size, urgency, consistency) {
  // Route to primary + fallback tiers
  const primary = routeData(dataType, size, urgency, consistency);

  // Calculate fallback (second-best)
  const scores = primary.allScores;
  delete scores[primary.tier];

  let fallbackTier = 'CANISTER';
  let fallbackScore = -Infinity;

  for (const [tier, score] of Object.entries(scores)) {
    if (score > fallbackScore) {
      fallbackScore = score;
      fallbackTier = tier;
    }
  }

  return {
    primary: primary,
    fallback: {
      tier: fallbackTier,
      tierMeta: STORAGE_TIERS[fallbackTier],
      score: fallbackScore
    },
    strategy: {
      write: primary.tier,
      read: [primary.tier, fallbackTier],
      cache: primary.frequency >= 100 ? 'KV' : null
    }
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 4: DATA REPLICATION
// ═══════════════════════════════════════════════════════════════════════════

function calculateReplication(importance, consistency, frequency) {
  // Higher importance = more replicas
  // Higher frequency = fewer replicas (updates expensive)

  const importanceScore = importance || 0.5;
  const freqFactor = 1.0 / (1.0 + frequency / 100.0);

  let replicas = Math.floor(importanceScore * freqFactor * 5) + 1;
  replicas = Math.min(5, Math.max(1, replicas));

  return {
    replicas: replicas,
    regions: replicas === 1 ? ['primary'] :
             replicas === 2 ? ['primary', 'secondary'] :
             replicas === 3 ? ['us-east', 'us-west', 'eu-central'] :
             replicas === 4 ? ['us-east', 'us-west', 'eu-central', 'ap-southeast'] :
             ['us-east', 'us-west', 'eu-central', 'ap-southeast', 'ap-northeast'],
    consistency: consistency ? 'strong' : 'eventual',
    syncFrequency: frequency / replicas
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
    case 'route': {
      const result = routeData(
        msg.dataType,
        msg.size || 0,
        msg.urgency || 0.5,
        msg.consistency || false
      );
      self.postMessage({
        type: 'routing_result',
        result: result,
        queryId: queryCount
      });
      break;
    }

    case 'route_multi': {
      const result = routeMultiTier(
        msg.dataType,
        msg.size || 0,
        msg.urgency || 0.5,
        msg.consistency || false
      );
      self.postMessage({
        type: 'multi_routing_result',
        result: result,
        queryId: queryCount
      });
      break;
    }

    case 'cache_strategy': {
      const strategy = getCacheStrategy(msg.tier, msg.frequency);
      self.postMessage({
        type: 'cache_strategy_result',
        strategy: strategy,
        queryId: queryCount
      });
      break;
    }

    case 'replication': {
      const replication = calculateReplication(
        msg.importance,
        msg.consistency,
        msg.frequency
      );
      self.postMessage({
        type: 'replication_result',
        replication: replication,
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
    worker: 'data-routing-edge',
    workerId: 25,
    workerName: 'VIA DATA LIMITIS',
    uptime: Date.now() - bootTime,
    beat: beatCount,
    queries: queryCount,
    routingDecisions: routingDecisions,
    storageTiers: 5,
    capabilities: ['route', 'route_multi', 'cache_strategy', 'replication', 'status', 'manifest'],
    frequency_Hz: PHI,
    primitiveTrace: 'φ = 1.618...'
  };
}

function getManifest() {
  return {
    id: 'WORKER-025',
    name: 'Data Routing Edge Worker',
    latinName: 'VIA DATA LIMITIS',
    latinMotto: 'Data sua via invenit',
    latinMottoEN: 'Data finds its way',
    protocol: 'PROT-107',
    storageTiers: Object.keys(STORAGE_TIERS),
    frequencies: {
      ultraFast: '500-900Hz (KV)',
      fast: '100-500Hz (Durable Objects)',
      standard: '10-100Hz (R2)',
      slow: '1-10Hz (D1)',
      ultraSlow: '0.01-1Hz (Canister)'
    },
    routing: 'φ-weighted scoring algorithm',
    caching: 'Frequency-based TTL with φ-scaling',
    replication: 'Importance and frequency-driven',
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
    worker: 'data-routing-edge'
  });
}, HEARTBEAT_MS);

// Boot message
self.postMessage({
  type: 'booted',
  worker: 'data-routing-edge',
  workerId: 25,
  workerName: 'VIA DATA LIMITIS',
  storageTiers: 5,
  frequency_Hz: PHI,
  timestamp: Date.now()
});
