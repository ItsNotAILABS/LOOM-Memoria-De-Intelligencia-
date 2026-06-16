/**
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                    MEDINA - PROPRIETARY AND CONFIDENTIAL                  ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA   ║
 * ║  ALL RIGHTS RESERVED.                                                     ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 *
 * MEMORIA NEXUS WORKER — WEB WORKER #34
 * ISIL-1.0 Licensed — HIGHEST CONFIDENTIALITY — SOVEREIGN-ALPHA
 *
 * MEMORIA NEXUS — Associative Memory Network
 * Department: MEMORY TEMPLE — TIER III: NEXUS
 *
 * Latin: "Memoria Nexus" = Memory Network / Weaving of Memory
 * Motto: "Omnia connectuntur per φ." (All things are connected through φ.)
 *
 * The associative memory tier — the web of connections between memories.
 * Builds a graph of memory nodes and their semantic relationships.
 * When you recall a node, NEXUS follows its edges to surface related ideas.
 * Powers the "comprehension" ability: the Organism doesn't just remember,
 * it understands connections.
 *
 * Operations:
 *   link      — create a directed edge between two memory nodes
 *   traverse  — follow edges from a node (BFS, max depth configurable)
 *   cluster   — find clusters of strongly connected nodes
 *   suggest   — given a query, suggest related memory nodes
 *   graph     — return the full adjacency graph
 *   degrees   — return in/out degree for each node
 *   manifest  — return worker manifest
 *   status    — health + graph statistics
 *
 * Edge Types:
 *   SIMILAR   — semantically similar content
 *   SUPPORTS  — one memory supports/grounds the other
 *   DERIVES   — derived/inferred from another
 *   REFERENCES — explicit citation or reference
 *   CONFLICTS  — conflicting or contradictory
 *
 * Law: L-005 — Always-on, not alive, no stress
 * Frequency: φ Hz (1.618033988749895 beats/sec)
 *
 * © 2024-2026 Alfredo "Freddy" Medina Hernandez | Medina Tech
 */

'use strict';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

var PHI          = 1.618033988749895;
var PHI_SQ       = 2.618033988749895;
var PHI_INV      = 0.618033988749895;

var WORKER_ID    = 34;
var WORKER_NAME  = 'MEMORIA-NEXUS';
var LATIN_NAME   = 'MEMORIA NEXUS';
var LATIN_MOTTO  = 'Omnia connectuntur per φ.';
var LATIN_EN     = 'All things are connected through φ.';
var DEPARTMENT   = 'MEMORY_TEMPLE_TIER_III_NEXUS';
var LAW          = 'L-005 + L-130';
var PROT         = 'PROT-128';
var VERSION      = '1.0.0';
var CLASSIFICATION = 'SOVEREIGN-ALPHA';

var HEARTBEAT_MS = Math.round(1000 / PHI);   // 618ms
var BOOT_TIME    = Date.now();

// Edge types
var ET = {
  SIMILAR:    'SIMILAR',
  SUPPORTS:   'SUPPORTS',
  DERIVES:    'DERIVES',
  REFERENCES: 'REFERENCES',
  CONFLICTS:  'CONFLICTS',
};

// ═══════════════════════════════════════════════════════════════════════════
// SEED GRAPH — Pre-seeded core connections
// ═══════════════════════════════════════════════════════════════════════════

var _nodes = {
  'phi':            { id: 'phi',            label: 'φ = 1.618 — Golden Ratio',                      domain: 'foundation' },
  'law-005':        { id: 'law-005',        label: 'L-005 — Agent Existence Law',                   domain: 'law'        },
  'PAPER-I':        { id: 'PAPER-I',        label: 'De Memoria Sacra — SCC=3.14',                   domain: 'memory'     },
  'PAPER-IX':       { id: 'PAPER-IX',       label: 'De Chartis — SCC=4.61',                         domain: 'epistemic'  },
  'PAPER-VIII':     { id: 'PAPER-VIII',     label: 'De Substrato Epistemico — SCC=4.44',            domain: 'epistemic'  },
  'PAPER-XVII':     { id: 'PAPER-XVII',     label: 'De Agentia Totali — SCC=4.35',                  domain: 'agency'     },
  'PAPER-XV':       { id: 'PAPER-XV',       label: 'De Automatione Perpetua — SCC=4.17',            domain: 'automation' },
  'PAPER-XVI':      { id: 'PAPER-XVI',      label: 'De Lingua Cognitiva — SCC=3.94',                domain: 'language'   },
  'bill-bots':      { id: 'bill-bots',      label: '5 Sovereign Bill Bots (AEDIFICATOR...PRAETOR)', domain: 'automation' },
  'memoria-sacra':  { id: 'memoria-sacra',  label: 'MEMORIA SACRA — Long-term memory tier',         domain: 'memory'     },
  'memoria-viva':   { id: 'memoria-viva',   label: 'MEMORIA VIVA — Live working memory tier',       domain: 'memory'     },
  'memoria-nexus':  { id: 'memoria-nexus',  label: 'MEMORIA NEXUS — Associative memory tier',       domain: 'memory'     },
  'context-worker': { id: 'context-worker', label: 'CONTEXTURA VIVA — Context synthesis engine',    domain: 'context'    },
  'icp':            { id: 'icp',            label: 'ICP — Internet Computer Protocol',              domain: 'deployment' },
  'cloudflare':     { id: 'cloudflare',     label: 'Cloudflare Edge (VIGILIA V2)',                  domain: 'deployment' },
};

// edges: { from, to, type, weight, label }
var _edges = [
  // φ is the root of all
  { from: 'phi',            to: 'law-005',        type: ET.SUPPORTS,   weight: 1.0,      label: 'φ-grounded' },
  { from: 'phi',            to: 'PAPER-IX',       type: ET.SUPPORTS,   weight: PHI,      label: 'SCC optimality' },
  { from: 'phi',            to: 'PAPER-VIII',     type: ET.SUPPORTS,   weight: PHI,      label: 'SCC optimality' },

  // Memory temple tiers connect
  { from: 'memoria-sacra',  to: 'memoria-nexus',  type: ET.REFERENCES, weight: PHI_INV,  label: 'long-term feeds nexus' },
  { from: 'memoria-viva',   to: 'memoria-sacra',  type: ET.DERIVES,    weight: PHI_INV,  label: 'promote to long-term' },
  { from: 'memoria-viva',   to: 'memoria-nexus',  type: ET.SUPPORTS,   weight: PHI_INV,  label: 'live context feeds nexus' },

  // Papers cross-link
  { from: 'PAPER-I',        to: 'memoria-sacra',  type: ET.SIMILAR,    weight: 1.0,      label: 'memory paper' },
  { from: 'PAPER-XV',       to: 'bill-bots',      type: ET.DERIVES,    weight: 1.0,      label: 'automation paper' },
  { from: 'PAPER-XVII',     to: 'bill-bots',      type: ET.REFERENCES, weight: PHI_INV,  label: 'agency census' },
  { from: 'PAPER-XVI',      to: 'PAPER-VII',      type: ET.SIMILAR,    weight: PHI_INV,  label: 'language domain' },
  { from: 'PAPER-VIII',     to: 'PAPER-IX',       type: ET.SUPPORTS,   weight: PHI,      label: 'knowledge substrate' },
  { from: 'PAPER-IX',       to: 'context-worker', type: ET.DERIVES,    weight: 1.0,      label: 'chartae → context' },

  // Context worker connects everything
  { from: 'context-worker', to: 'memoria-sacra',  type: ET.SUPPORTS,   weight: PHI_INV,  label: 'synthesis feeds memory' },

  // Deployment
  { from: 'icp',            to: 'cloudflare',     type: ET.SUPPORTS,   weight: PHI_INV,  label: 'sovereign route' },
];

var _edgeSeq = _edges.length + 1;
var _nodeSeq = Object.keys(_nodes).length + 1;

function _now() { return Date.now(); }

// ═══════════════════════════════════════════════════════════════════════════
// OPERATIONS
// ═══════════════════════════════════════════════════════════════════════════

function opLink(payload) {
  var from   = payload.from;
  var to     = payload.to;
  var type   = (payload.type || ET.SIMILAR).toUpperCase();
  var weight = typeof payload.weight === 'number' ? payload.weight : PHI_INV;
  var label  = payload.label || '';

  if (!from || !to) return { ok: false, error: 'from and to required' };

  // Auto-create nodes if they don't exist
  if (!_nodes[from]) _nodes[from] = { id: from, label: from, domain: 'user', created_at: _now() };
  if (!_nodes[to])   _nodes[to]   = { id: to,   label: to,   domain: 'user', created_at: _now() };

  // Avoid duplicate edges
  var exists = _edges.some(function(e) { return e.from === from && e.to === to && e.type === type; });
  if (exists) return { ok: false, error: 'edge already exists' };

  _edges.push({ from: from, to: to, type: type, weight: weight, label: label, created_at: _now() });
  return { ok: true, from: from, to: to, type: type, weight: weight };
}

function opTraverse(payload) {
  var start    = payload.start || payload.from;
  var maxDepth = payload.max_depth || 3;
  var edgeType = payload.edge_type || null;
  var limit    = payload.limit || 20;

  if (!start) return { ok: false, error: 'start node required' };

  var visited = {};
  var results = [];
  var queue   = [{ id: start, depth: 0, path: [] }];

  while (queue.length && results.length < limit) {
    var item   = queue.shift();
    var nodeId = item.id;
    if (visited[nodeId] || item.depth > maxDepth) continue;
    visited[nodeId] = true;

    var node = _nodes[nodeId];
    if (node) {
      results.push({
        id: nodeId, depth: item.depth,
        label: node.label, domain: node.domain,
        path: item.path,
      });
    }

    // Follow outbound edges
    _edges.forEach(function(e) {
      if (e.from !== nodeId) return;
      if (edgeType && e.type !== edgeType.toUpperCase()) return;
      if (!visited[e.to]) {
        queue.push({ id: e.to, depth: item.depth + 1, path: item.path.concat(nodeId) });
      }
    });
  }

  return { ok: true, start: start, visited_count: results.length, nodes: results };
}

function opCluster() {
  // Simple connected-component clustering
  var adj = {};
  Object.keys(_nodes).forEach(function(id) { adj[id] = []; });
  _edges.forEach(function(e) {
    if (adj[e.from]) adj[e.from].push(e.to);
    if (adj[e.to])   adj[e.to].push(e.from);
  });

  var visited = {};
  var clusters = [];

  Object.keys(_nodes).forEach(function(start) {
    if (visited[start]) return;
    var cluster = [];
    var q = [start];
    while (q.length) {
      var n = q.shift();
      if (visited[n]) continue;
      visited[n] = true;
      cluster.push(n);
      (adj[n] || []).forEach(function(nb) { if (!visited[nb]) q.push(nb); });
    }
    if (cluster.length) clusters.push(cluster);
  });

  clusters.sort(function(a, b) { return b.length - a.length; });
  return {
    ok: true,
    cluster_count: clusters.length,
    clusters: clusters.map(function(c, i) {
      return { cluster_id: i, size: c.length, nodes: c };
    }),
  };
}

function opSuggest(payload) {
  var query   = (payload.query || '').toLowerCase();
  var domain  = payload.domain || null;
  var limit   = payload.limit || 10;
  if (!query) return { ok: false, error: 'query required' };

  // Score nodes by keyword match in label + domain
  var scored = Object.values(_nodes).map(function(n) {
    var score = 0;
    var lbl   = (n.label || '').toLowerCase();
    var dom   = (n.domain || '').toLowerCase();
    query.split(' ').forEach(function(word) {
      if (word.length < 2) return;
      if (lbl.indexOf(word) >= 0) score += 2;
      if (dom.indexOf(word) >= 0) score += 1;
      if (n.id.toLowerCase().indexOf(word) >= 0) score += 1;
    });
    if (domain && dom !== domain.toLowerCase()) score = score * PHI_INV;
    return { id: n.id, label: n.label, domain: n.domain, score: score };
  });

  scored = scored.filter(function(s) { return s.score > 0; });
  scored.sort(function(a, b) { return b.score - a.score; });
  return { ok: true, query: query, count: scored.length, suggestions: scored.slice(0, limit) };
}

function opGraph() {
  return {
    ok: true,
    node_count: Object.keys(_nodes).length,
    edge_count: _edges.length,
    nodes: Object.values(_nodes),
    edges: _edges,
  };
}

function opDegrees() {
  var deg = {};
  Object.keys(_nodes).forEach(function(id) { deg[id] = { in: 0, out: 0, total: 0 }; });
  _edges.forEach(function(e) {
    if (deg[e.from]) { deg[e.from].out++; deg[e.from].total++; }
    if (deg[e.to])   { deg[e.to].in++;   deg[e.to].total++;   }
  });
  // Sort by total degree
  var sorted = Object.entries(deg).sort(function(a, b) { return b[1].total - a[1].total; });
  return {
    ok: true,
    degrees: sorted.map(function(kv) {
      return { id: kv[0], label: (_nodes[kv[0]] || {}).label || kv[0],
               in: kv[1].in, out: kv[1].out, total: kv[1].total };
    }),
  };
}

function opManifest() {
  return {
    ok: true,
    worker_id:     WORKER_ID,
    worker_name:   WORKER_NAME,
    latin_name:    LATIN_NAME,
    latin_motto:   LATIN_MOTTO,
    latin_en:      LATIN_EN,
    department:    DEPARTMENT,
    prot:          PROT,
    version:       VERSION,
    law:           LAW,
    phi:           PHI,
    heartbeat_ms:  HEARTBEAT_MS,
    boot_time:     BOOT_TIME,
    edge_types:    Object.values(ET),
    operations:    ['link','traverse','cluster','suggest','graph','degrees','manifest','status'],
    classification: CLASSIFICATION,
  };
}

function opStatus() {
  return {
    ok:           true,
    healthy:      true,
    worker_name:  WORKER_NAME,
    node_count:   Object.keys(_nodes).length,
    edge_count:   _edges.length,
    uptime_ms:    _now() - BOOT_TIME,
    phi:          PHI,
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════

self.onmessage = function(event) {
  var msg   = event.data || {};
  var op    = msg.op || msg.operation || 'status';
  var pay   = msg.payload || msg.data || msg || {};
  var reqId = msg.id || msg.requestId || null;

  var result;
  try {
    switch (op) {
      case 'link':     result = opLink(pay);     break;
      case 'traverse': result = opTraverse(pay); break;
      case 'cluster':  result = opCluster();     break;
      case 'suggest':  result = opSuggest(pay);  break;
      case 'graph':    result = opGraph();       break;
      case 'degrees':  result = opDegrees();     break;
      case 'manifest': result = opManifest();    break;
      case 'status':   result = opStatus();      break;
      default:
        result = { ok: false, error: 'Unknown operation: ' + op,
                   available: ['link','traverse','cluster','suggest','graph','degrees','manifest','status'] };
    }
  } catch (e) {
    result = { ok: false, error: String(e), op: op };
  }

  self.postMessage({ worker: WORKER_NAME, op: op, requestId: reqId, result: result, phi: PHI });
};

// Heartbeat at φ Hz
setInterval(function() {
  self.postMessage({
    worker:   WORKER_NAME,
    type:     'heartbeat',
    alive:    true,
    nodes:    Object.keys(_nodes).length,
    edges:    _edges.length,
    uptime_ms: _now() - BOOT_TIME,
    phi:      PHI,
  });
}, HEARTBEAT_MS);
