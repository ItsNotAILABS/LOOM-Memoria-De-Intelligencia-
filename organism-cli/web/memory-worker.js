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

var store = new Map();

function now() { return Date.now(); }

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
        totalAccesses: (function () {
          var t = 0;
          store.forEach(function (e) { t += e.accessCount; });
          return t;
        })()
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
  engines: ['salience-scoring', 'temporal-decay', 'tag-consolidation'],
  capabilities: ['store', 'get', 'find', 'decay', 'consolidate', 'list', 'status']
});
