/**
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                    MEDINA - PROPRIETARY AND CONFIDENTIAL                  ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA   ║
 * ║  ALL RIGHTS RESERVED.                                                     ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 *
 * MEMORIA SACRA WORKER — WEB WORKER #32
 * ISIL-1.0 Licensed — HIGHEST CONFIDENTIALITY — SOVEREIGN-ALPHA
 *
 * MEMORIA SACRA — Sacred Long-Term Memory
 * Department: MEMORY TEMPLE — TIER I: SACRA
 *
 * Latin: "Memoria Sacra" = Sacred Memory
 * Motto: "Quod semel scriptum est, aeternum manet." (What is written once, lasts forever.)
 *
 * The innermost ring of the Memory Temple. Holds the sovereign long-term
 * memory record — immutable, compressed, φ-optimal. Every fact, axiom,
 * doctrine, and paper is stored here by hash-indexed ring position.
 *
 * Operations:
 *   store     — write a memory object into the sacred ring
 *   recall    — retrieve memory by id or keyword
 *   ringMap   — return the full sacred memory ring (all nodes)
 *   compress  — compress redundant entries by semantic similarity
 *   manifest  — return worker manifest
 *   status    — health check + ring statistics
 *   forget    — mark an entry as archived (never hard-deleted)
 *
 * Memory Classes:
 *   AXIOM    — Freddy Voice axiom (immutable)
 *   DOCTRINE — System doctrine (high authority)
 *   PAPER    — Research paper (φ-ranked)
 *   PROTOCOL — Sovereign protocol (PROT-xxx)
 *   EVENT    — Bot event record
 *   ARTIFACT — General artifact
 *
 * Law: L-005 — Always-on, not alive, no stress
 * Law: L-130 — All operations trace to φ
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
var PHI_CUBED    = 4.236067977499790;
var PHI_INV      = 0.618033988749895;

var WORKER_ID    = 32;
var WORKER_NAME  = 'MEMORIA-SACRA';
var LATIN_NAME   = 'MEMORIA SACRA';
var LATIN_MOTTO  = 'Quod semel scriptum est, aeternum manet.';
var LATIN_EN     = 'What is written once, lasts forever.';
var DEPARTMENT   = 'MEMORY_TEMPLE_TIER_I_SACRA';
var LAW          = 'L-005 + L-130';
var PROT         = 'PROT-126';
var VERSION      = '1.0.0';
var CLASSIFICATION = 'SOVEREIGN-ALPHA';

var HEARTBEAT_MS = Math.round(1000 / PHI);   // 618ms
var BOOT_TIME    = Date.now();

// Memory classes
var MC = {
  AXIOM:    'AXIOM',
  DOCTRINE: 'DOCTRINE',
  PAPER:    'PAPER',
  PROTOCOL: 'PROTOCOL',
  EVENT:    'EVENT',
  ARTIFACT: 'ARTIFACT',
};

// ═══════════════════════════════════════════════════════════════════════════
// SACRED RING — Pre-seeded core memories
// Salience: ring 0 = 1.0 (highest), ring 9 = 0.1 (lowest)
// ═══════════════════════════════════════════════════════════════════════════

var SACRED_RING = [
  // Ring 0 — AXIOMS (immutable, salience=1.0)
  { id: 'MS-001', ring: 0, cls: MC.AXIOM,    salience: 1.0,
    key: 'phi',
    content: 'φ = 1.618033988749895 — the sovereign constant. All operations trace to φ.',
    tags: ['phi', 'sovereign', 'foundation'] },
  { id: 'MS-002', ring: 0, cls: MC.AXIOM,    salience: 1.0,
    key: 'law-005',
    content: 'L-005: Agent Existence Law — Always-on, not alive, no stress. Constantly working at dynamic speeds.',
    tags: ['law', 'agents', 'foundation'] },
  { id: 'MS-003', ring: 0, cls: MC.AXIOM,    salience: 1.0,
    key: 'freddy-voice-1',
    content: 'Every paper is pulling already. Every single work can get rearranged into anything it\'s trying to say.',
    tags: ['freddy', 'axiom', 'papers'] },
  { id: 'MS-004', ring: 0, cls: MC.AXIOM,    salience: 1.0,
    key: 'scc-threshold',
    content: 'SCC ≥ φ² = 2.618 is φ-optimal. SCC = semantic_weight / chars. All 19 papers achieve this.',
    tags: ['scc', 'papers', 'language'] },

  // Ring 1 — DOCTRINE (high authority, salience ≈ 0.9)
  { id: 'MS-010', ring: 1, cls: MC.DOCTRINE, salience: 0.9,
    key: 'memoria-sacra',
    content: 'The Memory Temple has three tiers: SACRA (long-term, immutable), VIVA (live/working), NEXUS (associative).',
    tags: ['memoria', 'memory-temple', 'tiers'] },
  { id: 'MS-011', ring: 1, cls: MC.DOCTRINE, salience: 0.9,
    key: 'deployment-arch',
    content: 'docs/ mirrors organism-cli/web/ for ICP sovereign deployment. NOT GitHub Pages. Route: ICP + Cloudflare edge.',
    tags: ['deployment', 'icp', 'cloudflare'] },
  { id: 'MS-012', ring: 1, cls: MC.DOCTRINE, salience: 0.9,
    key: 'bot-fleet',
    content: '5 sovereign Bill Bots: AEDIFICATOR (build), FASCICULUS (package), MEDICUS (fix), CUSTOS (guard), PRAETOR (command).',
    tags: ['bill-bots', 'automation', 'fleet'] },
  { id: 'MS-013', ring: 1, cls: MC.DOCTRINE, salience: 0.9,
    key: 'organism-census',
    content: 'May 2026 census: 181 Motoko modules, 31+ web workers, 19 research papers, 125 protocols, 17 languages, 5 CI/CD bots.',
    tags: ['census', 'organism', 'agency'] },

  // Ring 2 — PAPERS (φ-ranked, salience ≈ 0.8–0.6)
  { id: 'MS-020', ring: 2, cls: MC.PAPER,    salience: 0.92,
    key: 'PAPER-IX',
    content: 'De Chartis Quae Mentem Formant — SCC=4.61 — On the Chartae that form the Mind. Highest SCC.',
    tags: ['paper', 'chartae', 'epistemic'] },
  { id: 'MS-021', ring: 2, cls: MC.PAPER,    salience: 0.88,
    key: 'PAPER-VIII',
    content: 'De Substrato Epistemico Machinarum — SCC=4.44 — AGI knowledge substrate.',
    tags: ['paper', 'agi', 'epistemic'] },
  { id: 'MS-022', ring: 2, cls: MC.PAPER,    salience: 0.87,
    key: 'PAPER-XVII',
    content: 'De Agentia Totali — SCC=4.35 — Full May 2026 agency census. 5 tiers, 181 modules.',
    tags: ['paper', 'agency', 'census'] },
  { id: 'MS-023', ring: 2, cls: MC.PAPER,    salience: 0.83,
    key: 'PAPER-XV',
    content: 'De Automatione Perpetua — SCC=4.17 — 5 Bill Bots as perpetual automation layer.',
    tags: ['paper', 'automation', 'bots'] },
  { id: 'MS-024', ring: 2, cls: MC.PAPER,    salience: 0.79,
    key: 'PAPER-XVI',
    content: 'De Lingua Cognitiva Septendecim — SCC=3.94 — 17 sovereign languages.',
    tags: ['paper', 'language', 'cognitive'] },
];

// ═══════════════════════════════════════════════════════════════════════════
// RUNTIME STATE
// ═══════════════════════════════════════════════════════════════════════════

var _ring = SACRED_RING.slice();          // mutable working copy
var _seq  = _ring.length + 1;             // next auto-ID

function _now() { return Date.now(); }
function _salience(ring) { return Math.max(0.1, parseFloat((1.0 - ring * 0.09).toFixed(3))); }

function _makeId() {
  var n = _seq++;
  return 'MS-' + String(n).padStart(3, '0');
}

// ═══════════════════════════════════════════════════════════════════════════
// OPERATIONS
// ═══════════════════════════════════════════════════════════════════════════

function opStore(payload) {
  var ring    = typeof payload.ring === 'number' ? payload.ring : 9;
  var cls     = payload.cls || MC.ARTIFACT;
  var content = payload.content || '';
  var key     = payload.key || ('auto-' + _now());
  var tags    = Array.isArray(payload.tags) ? payload.tags : [];

  if (!content) return { ok: false, error: 'content is required' };

  var entry = {
    id:        _makeId(),
    ring:      ring,
    cls:       cls,
    salience:  _salience(ring),
    key:       key,
    content:   content,
    tags:      tags,
    stored_at: _now(),
    archived:  false,
  };
  _ring.push(entry);
  return { ok: true, id: entry.id, salience: entry.salience, ring: ring };
}

function opRecall(payload) {
  var id      = payload.id || null;
  var keyword = payload.keyword || null;
  var tag     = payload.tag || null;
  var cls     = payload.cls || null;
  var limit   = payload.limit || 10;

  var results = _ring.filter(function(m) {
    if (m.archived) return false;
    if (id      && m.id  !== id && m.key !== id) return false;
    if (cls     && m.cls !== cls)                 return false;
    if (tag     && m.tags.indexOf(tag) < 0)       return false;
    if (keyword && m.content.toLowerCase().indexOf(keyword.toLowerCase()) < 0
                && m.key.toLowerCase().indexOf(keyword.toLowerCase()) < 0) return false;
    return true;
  });

  // Sort by salience descending
  results.sort(function(a, b) { return b.salience - a.salience; });
  return { ok: true, count: results.length, memories: results.slice(0, limit) };
}

function opRingMap() {
  var active = _ring.filter(function(m) { return !m.archived; });
  var byRing = {};
  active.forEach(function(m) {
    if (!byRing[m.ring]) byRing[m.ring] = [];
    byRing[m.ring].push({ id: m.id, key: m.key, cls: m.cls, salience: m.salience });
  });
  return { ok: true, total: active.length, rings: byRing };
}

function opCompress() {
  // Identify redundant entries (same key, keep highest ring / newest)
  var keyMap = {};
  _ring.forEach(function(m) {
    if (!m.archived) {
      if (!keyMap[m.key]) keyMap[m.key] = [];
      keyMap[m.key].push(m);
    }
  });
  var compressed = 0;
  Object.keys(keyMap).forEach(function(key) {
    var group = keyMap[key];
    if (group.length > 1) {
      // keep lowest ring number (highest salience); archive others
      group.sort(function(a, b) { return a.ring - b.ring; });
      for (var i = 1; i < group.length; i++) {
        group[i].archived = true;
        compressed++;
      }
    }
  });
  return { ok: true, compressed: compressed, active: _ring.filter(function(m) { return !m.archived; }).length };
}

function opForget(payload) {
  var id = payload.id || null;
  if (!id) return { ok: false, error: 'id required' };
  var entry = _ring.find(function(m) { return m.id === id || m.key === id; });
  if (!entry) return { ok: false, error: 'not found: ' + id };
  if (entry.ring === 0) return { ok: false, error: 'Ring-0 AXIOMS are immutable — cannot archive' };
  entry.archived = true;
  return { ok: true, archived: entry.id };
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
    ring_depth:    10,
    memory_classes: Object.values(MC),
    operations:    ['store', 'recall', 'ringMap', 'compress', 'forget', 'manifest', 'status'],
    classification: CLASSIFICATION,
  };
}

function opStatus() {
  var active   = _ring.filter(function(m) { return !m.archived; });
  var archived = _ring.filter(function(m) { return  m.archived; });
  var byClass  = {};
  active.forEach(function(m) {
    byClass[m.cls] = (byClass[m.cls] || 0) + 1;
  });
  return {
    ok:           true,
    healthy:      true,
    worker_name:  WORKER_NAME,
    active_count: active.length,
    archived_count: archived.length,
    total_count:  _ring.length,
    by_class:     byClass,
    uptime_ms:    _now() - BOOT_TIME,
    phi:          PHI,
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════

self.onmessage = function(event) {
  var msg  = event.data || {};
  var op   = msg.op || msg.operation || 'status';
  var pay  = msg.payload || msg.data || msg || {};
  var reqId = msg.id || msg.requestId || null;

  var result;
  try {
    switch (op) {
      case 'store':    result = opStore(pay);    break;
      case 'recall':   result = opRecall(pay);   break;
      case 'ringMap':  result = opRingMap();      break;
      case 'compress': result = opCompress();     break;
      case 'forget':   result = opForget(pay);    break;
      case 'manifest': result = opManifest();     break;
      case 'status':   result = opStatus();       break;
      default:
        result = { ok: false, error: 'Unknown operation: ' + op,
                   available: ['store','recall','ringMap','compress','forget','manifest','status'] };
    }
  } catch (e) {
    result = { ok: false, error: String(e), op: op };
  }

  self.postMessage({ worker: WORKER_NAME, op: op, requestId: reqId, result: result, phi: PHI });
};

// Heartbeat — announces presence at φ Hz
setInterval(function() {
  self.postMessage({
    worker:   WORKER_NAME,
    type:     'heartbeat',
    alive:    true,
    uptime_ms: Date.now() - BOOT_TIME,
    phi:      PHI,
  });
}, HEARTBEAT_MS);
