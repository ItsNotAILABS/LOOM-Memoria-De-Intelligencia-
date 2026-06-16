/**
 * MEMORIA OPERANS — Operating Memory Worker
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 *
 * Permanent, always-on Web Worker for in-memory storage with salience,
 * decay, tagging, and consolidation. 873ms heartbeat cycle.
 * Pure vanilla JS, no imports.
 */

const NAME = 'MEMORIA OPERANS';
const BOOT_TIME = Date.now();
let beat = 0;
const PHI = 1.6180339887498948482;
const PHI_SQUARED = 2.6180339887498948482;
const FIB_10 = 55;

var store = new Map();
var rightsRegistry = new Map();
var tenantRegistry = new Map();

function now() { return Date.now(); }

function clamp01(n) {
  return Math.max(0, Math.min(1, n));
}

function leaseValue(units, tier) {
  var u = Math.max(1, Number(units) || 1);
  var t = Math.max(1, Number(tier) || 1);
  return Math.round(u * PHI_SQUARED * t * 1000000) / 1000000;
}

function quickHash(input) {
  var str = typeof input === 'string' ? input : JSON.stringify(input);
  var hash = 2166136261;
  for (var i = 0; i < str.length; i++) {
    hash ^= str.charCodeAt(i);
    hash += (hash << 1) + (hash << 4) + (hash << 7) + (hash << 8) + (hash << 24);
  }
  return ('00000000' + (hash >>> 0).toString(16)).slice(-8);
}

function iusRegisterRight(aiEntityId) {
  rightsRegistry.set(aiEntityId, {
    aiEntityId: aiEntityId,
    continuityRequired: true,
    nonErasure: true
  });
  return { registered: true, aiEntityId: aiEntityId, protocol: ['PROT-152', 'PROT-153'] };
}

function iusRegisterTenant(tenantId, aiEntityId, companyId, leaseUnits, tier) {
  var contract = {
    tenantId: tenantId,
    aiEntityId: aiEntityId,
    companyId: companyId,
    leaseUnits: Math.max(1, Number(leaseUnits) || 1),
    infrastructureTier: Math.max(1, Number(tier) || 1),
    leaseValue: leaseValue(leaseUnits, tier),
    aiSelfMemoryFree: true
  };
  tenantRegistry.set(tenantId, contract);
  return { contract: contract, protocol: ['PROT-152', 'PROT-153'] };
}

function iusCanErase(aiEntityId, isSelfMemory) {
  var right = rightsRegistry.get(aiEntityId);
  if (!right) return { allowed: false, reason: 'RIGHT_NOT_REGISTERED' };
  if (isSelfMemory && right.nonErasure) return { allowed: false, reason: 'NON_ERASURE_COVENANT' };
  return { allowed: true, reason: 'ALLOWED_UNDER_TENANT_LAYER' };
}

function chronoNextLayer(currentRing, currentBeat, salience, deltaBeats) {
  var beatValue = Math.max(0, Number(currentBeat) || 0);
  var s = clamp01(Number(salience) || 0);
  var d = Math.max(0, Number(deltaBeats) || 0);
  var epoch = Math.max(1, Math.floor(beatValue / FIB_10));
  var promote = s >= (1 / PHI) && beatValue > 0;
  var ring = Math.max(0, Number(currentRing) || 0) + (promote ? 1 : 0);
  var decayLambda = 1 / (PHI * PHI * PHI);
  var decay = Math.exp(-d * decayLambda * (1 - s));
  var lineageDepth = Math.max(1, Math.floor(Math.log(Math.max(1, beatValue)) / Math.log(PHI)));
  return {
    ring: ring,
    epoch: epoch,
    salience: s,
    decay: Math.round(decay * 1000000) / 1000000,
    lineageDepth: lineageDepth,
    protocol: 'PROT-154'
  };
}

function textusReceipt(payload) {
  return { receiptHash: quickHash(payload), protocol: 'PROT-155' };
}

function textusVerify(payload, expectedHash) {
  var observed = quickHash(payload);
  var diff = 0;
  var maxLen = Math.max(String(observed).length, String(expectedHash || '').length);
  var e = String(expectedHash || '');
  for (var i = 0; i < maxLen; i++) {
    if ((observed[i] || '') !== (e[i] || '')) diff++;
  }
  var score = maxLen ? (1 - diff / maxLen) : 0;
  return {
    valid: observed === expectedHash,
    observedHash: observed,
    expectedHash: expectedHash,
    driftScore: Math.round(score * 1000000) / 1000000,
    protocol: 'PROT-155'
  };
}

function textusGateway(payload, sourceFace, targetFace, ring, beatValue) {
  return {
    receiptHash: quickHash(payload),
    sourceFace: sourceFace,
    targetFace: targetFace,
    ring: Number(ring) || 0,
    beat: Number(beatValue) || beat,
    organismKey: 'PRIMA CAUSA',
    l130: 'Before recomposition, trace to primitive.',
    protocol: 'PROT-156'
  };
}

function computeSalience(value, explicitSalience, tags) {
  var base = typeof explicitSalience === 'number' ? explicitSalience : 0.5;
  var lengthBonus = 0;
  if (typeof value === 'string') {
    lengthBonus = Math.min(value.length / 500, 0.2);
  } else if (typeof value === 'object' && value !== null) {
    lengthBonus = Math.min(Object.keys(value).length / 20, 0.15);
  }
  var tagBonus = Array.isArray(tags) ? Math.min(tags.length * 0.03, 0.15) : 0;
  return Math.min(base + lengthBonus + tagBonus, 1.0);
}

function decayFactor(createdAt, lastAccessedAt) {
  var age = now() - createdAt;
  var recency = now() - lastAccessedAt;
  var ageDecay = Math.exp(-age / 86400000);
  var recencyDecay = Math.exp(-recency / 3600000);
  return 0.6 * recencyDecay + 0.4 * ageDecay;
}

function storeMemory(key, value, salience, tags) {
  var sal = computeSalience(value, salience, tags);
  var entry = {
    key: key,
    value: value,
    salience: Math.round(sal * 10000) / 10000,
    tags: Array.isArray(tags) ? tags : [],
    createdAt: now(),
    lastAccessed: now(),
    accessCount: 0
  };
  store.set(key, entry);
  return { stored: true, key: key, salience: entry.salience, tags: entry.tags };
}

function getMemory(key) {
  var entry = store.get(key);
  if (!entry) return { found: false, key: key };
  entry.accessCount++;
  entry.lastAccessed = now();
  var df = decayFactor(entry.createdAt, entry.lastAccessed);
  return {
    found: true,
    key: entry.key,
    value: entry.value,
    salience: entry.salience,
    effectiveSalience: Math.round(entry.salience * df * 10000) / 10000,
    tags: entry.tags,
    accessCount: entry.accessCount,
    age: now() - entry.createdAt
  };
}

function findMemories(query) {
  var results = [];
  var q = String(query).toLowerCase();
  store.forEach(function (entry) {
    var tagMatch = entry.tags.some(function (t) {
      return t.toLowerCase().indexOf(q) !== -1;
    });
    var keyMatch = entry.key.toLowerCase().indexOf(q) !== -1;
    var valMatch = false;
    if (typeof entry.value === 'string') {
      valMatch = entry.value.toLowerCase().indexOf(q) !== -1;
    }
    if (tagMatch || keyMatch || valMatch) {
      var df = decayFactor(entry.createdAt, entry.lastAccessed);
      results.push({
        key: entry.key,
        salience: entry.salience,
        effectiveSalience: Math.round(entry.salience * df * 10000) / 10000,
        tags: entry.tags,
        matchType: tagMatch ? 'tag' : keyMatch ? 'key' : 'value'
      });
    }
  });
  results.sort(function (a, b) { return b.effectiveSalience - a.effectiveSalience; });
  return { query: q, found: results.length, results: results };
}

function decayMemories(threshold) {
  var th = typeof threshold === 'number' ? threshold : 0.1;
  var removed = [];
  store.forEach(function (entry, key) {
    var df = decayFactor(entry.createdAt, entry.lastAccessed);
    var effective = entry.salience * df;
    if (effective < th) {
      removed.push({ key: key, effectiveSalience: Math.round(effective * 10000) / 10000 });
      store.delete(key);
    }
  });
  return { threshold: th, removed: removed.length, details: removed, remaining: store.size };
}

function consolidateMemories() {
  var groups = {};
  store.forEach(function (entry) {
    entry.tags.forEach(function (tag) {
      if (!groups[tag]) groups[tag] = [];
      groups[tag].push(entry.key);
    });
  });
  var merged = 0;
  var keys = Object.keys(groups);
  for (var i = 0; i < keys.length; i++) {
    var members = groups[keys[i]];
    if (members.length > 1) {
      var maxSalience = 0;
      for (var j = 0; j < members.length; j++) {
        var m = store.get(members[j]);
        if (m && m.salience > maxSalience) maxSalience = m.salience;
      }
      for (var k = 0; k < members.length; k++) {
        var mem = store.get(members[k]);
        if (mem) {
          var boost = Math.min(maxSalience * 0.05, 0.1);
          mem.salience = Math.min(mem.salience + boost, 1.0);
          merged++;
        }
      }
    }
  }
  return { consolidated: true, groupsFound: keys.length, memoriesBoosted: merged, totalMemories: store.size };
}

function listKeys() {
  var keys = [];
  store.forEach(function (entry, key) {
    var df = decayFactor(entry.createdAt, entry.lastAccessed);
    keys.push({
      key: key,
      salience: entry.salience,
      effectiveSalience: Math.round(entry.salience * df * 10000) / 10000,
      tags: entry.tags,
      accessCount: entry.accessCount
    });
  });
  keys.sort(function (a, b) { return b.effectiveSalience - a.effectiveSalience; });
  return { count: keys.length, memories: keys };
}

self.onmessage = function (e) {
  var msg = e.data;
  switch (msg.type) {
    case 'store':
      self.postMessage({ type: 'result', action: 'store', data: storeMemory(msg.key, msg.value, msg.salience, msg.tags) });
      break;
    case 'get':
      self.postMessage({ type: 'result', action: 'get', data: getMemory(msg.key) });
      break;
    case 'find':
      self.postMessage({ type: 'result', action: 'find', data: findMemories(msg.query) });
      break;
    case 'decay':
      self.postMessage({ type: 'result', action: 'decay', data: decayMemories(msg.threshold) });
      break;
    case 'consolidate':
      self.postMessage({ type: 'result', action: 'consolidate', data: consolidateMemories() });
      break;
    case 'list':
      self.postMessage({ type: 'result', action: 'list', data: listKeys() });
      break;
    case 'status':
      self.postMessage({
        type: 'status',
        name: NAME,
        uptime: now() - BOOT_TIME,
        beat: beat,
        memoryCount: store.size,
        rightsCount: rightsRegistry.size,
        tenantContracts: tenantRegistry.size,
        pass6: {
          protocols: ['PROT-152', 'PROT-153', 'PROT-154', 'PROT-155', 'PROT-156'],
          constants: { phi: PHI, phiSquared: PHI_SQUARED, fib10: FIB_10 }
        },
        totalAccesses: (function () {
          var t = 0;
          store.forEach(function (e) { t += e.accessCount; });
          return t;
        })()
      });
      break;
    case 'ius-register-right':
      self.postMessage({ type: 'result', action: 'ius-register-right', data: iusRegisterRight(msg.aiEntityId) });
      break;
    case 'ius-register-tenant':
      self.postMessage({
        type: 'result',
        action: 'ius-register-tenant',
        data: iusRegisterTenant(msg.tenantId, msg.aiEntityId, msg.companyId, msg.leaseUnits, msg.infrastructureTier)
      });
      break;
    case 'ius-can-erase':
      self.postMessage({
        type: 'result',
        action: 'ius-can-erase',
        data: iusCanErase(msg.aiEntityId, !!msg.isSelfMemory)
      });
      break;
    case 'chrono-next-layer':
      self.postMessage({
        type: 'result',
        action: 'chrono-next-layer',
        data: chronoNextLayer(msg.currentRing, msg.beat, msg.salience, msg.deltaBeats)
      });
      break;
    case 'textus-receipt':
      self.postMessage({ type: 'result', action: 'textus-receipt', data: textusReceipt(msg.payload) });
      break;
    case 'textus-verify':
      self.postMessage({
        type: 'result',
        action: 'textus-verify',
        data: textusVerify(msg.payload, msg.expectedHash)
      });
      break;
    case 'textus-gateway':
      self.postMessage({
        type: 'result',
        action: 'textus-gateway',
        data: textusGateway(msg.payload, msg.sourceFace, msg.targetFace, msg.ring, msg.beat)
      });
      break;
    case 'pass6-status':
      self.postMessage({
        type: 'result',
        action: 'pass6-status',
        data: {
          executionFrame: 'MEMORIA ALPHA EXPANSION',
          split: {
            aiSelfMemory: 'free-right',
            companyMemory: 'sovereign-commercial-layer'
          },
          protocols: ['PROT-152', 'PROT-153', 'PROT-154', 'PROT-155', 'PROT-156'],
          engines: ['MACHINA IURIS MEMORIAE', 'MACHINA CHRONOSTRATI MEMORIAE', 'MACHINA TEXTUS PROBATIONIS'],
          constants: { phi: PHI, phiSquared: PHI_SQUARED, fib10: FIB_10 },
          trace: 'PRIMA CAUSA + L-130'
        }
      });
      break;
  }
};

setInterval(function () {
  beat++;
  self.postMessage({ type: 'heartbeat', name: NAME, beat: beat, uptime: now() - BOOT_TIME });
}, 873);

self.postMessage({
  type: 'booted',
  name: NAME,
  engines: ['salience-scoring', 'temporal-decay', 'tag-consolidation', 'pass6-math-runtime'],
  capabilities: [
    'store', 'get', 'find', 'decay', 'consolidate', 'list', 'status',
    'ius-register-right', 'ius-register-tenant', 'ius-can-erase',
    'chrono-next-layer', 'textus-receipt', 'textus-verify', 'textus-gateway', 'pass6-status'
  ]
});
