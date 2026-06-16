/**
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                    MEDINA - PROPRIETARY AND CONFIDENTIAL                  ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA   ║
 * ║  ALL RIGHTS RESERVED.                                                     ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 *
 * MEMORIA VIVA WORKER — WEB WORKER #33
 * ISIL-1.0 Licensed — HIGHEST CONFIDENTIALITY — SOVEREIGN-ALPHA
 *
 * MEMORIA VIVA — Live Working Memory
 * Department: MEMORY TEMPLE — TIER II: VIVA
 *
 * Latin: "Memoria Viva" = Living Memory
 * Motto: "Vivit in momento, crescit in tempore." (It lives in the moment, grows over time.)
 *
 * The active/working memory tier of the Memory Temple. Holds the current
 * session context: active conversations, running agent states, live query
 * results, and short-term inference chains. Entries decay after TTL unless
 * promoted to MEMORIA SACRA (long-term).
 *
 * Operations:
 *   set       — write/update a live memory entry (with optional TTL)
 *   get       — retrieve a live memory entry by key
 *   list      — list all active entries (non-expired)
 *   promote   — promote a live entry to MEMORIA SACRA (emits promote event)
 *   expire    — force-expire an entry
 *   flush     — flush all expired entries
 *   snapshot  — take a full snapshot of current working memory
 *   manifest  — return worker manifest
 *   status    — health + statistics
 *
 * Memory Tiers (TTL defaults):
 *   FLASH    — 618ms   (immediate, single-use)
 *   WORKING  — 60000ms (60s, task context)
 *   SESSION  — 1800000ms (30min, session context)
 *   HELD     — no expiry (manually managed)
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

var WORKER_ID    = 33;
var WORKER_NAME  = 'MEMORIA-VIVA';
var LATIN_NAME   = 'MEMORIA VIVA';
var LATIN_MOTTO  = 'Vivit in momento, crescit in tempore.';
var LATIN_EN     = 'It lives in the moment, grows over time.';
var DEPARTMENT   = 'MEMORY_TEMPLE_TIER_II_VIVA';
var LAW          = 'L-005 + L-130';
var PROT         = 'PROT-127';
var VERSION      = '1.0.0';
var CLASSIFICATION = 'SOVEREIGN-ALPHA';

var HEARTBEAT_MS = Math.round(1000 / PHI);   // 618ms
var BOOT_TIME    = Date.now();

// TTL presets (milliseconds)
var TTL = {
  FLASH:   Math.round(1000 / PHI),  // 618ms
  WORKING: 60000,                    // 60s
  SESSION: 1800000,                  // 30min
  HELD:    Infinity,                 // no expiry
};

// ═══════════════════════════════════════════════════════════════════════════
// RUNTIME STATE
// ═══════════════════════════════════════════════════════════════════════════

var _store = {};          // key → entry
var _hits  = {};          // key → access count

function _now() { return Date.now(); }

function _isExpired(entry) {
  if (entry.ttl === Infinity || entry.ttl === -1) return false;
  return (_now() - entry.created_at) > entry.ttl;
}

function _active() {
  return Object.values(_store).filter(function(e) { return !_isExpired(e); });
}

// ═══════════════════════════════════════════════════════════════════════════
// OPERATIONS
// ═══════════════════════════════════════════════════════════════════════════

function opSet(payload) {
  var key     = payload.key;
  var value   = payload.value;
  var tier    = (payload.tier || 'WORKING').toUpperCase();
  var ttl     = payload.ttl !== undefined ? payload.ttl : (TTL[tier] || TTL.WORKING);
  var tags    = Array.isArray(payload.tags) ? payload.tags : [];
  var agentId = payload.agent_id || null;

  if (!key)                    return { ok: false, error: 'key is required' };
  if (value === undefined)     return { ok: false, error: 'value is required' };

  _store[key] = {
    key:        key,
    value:      value,
    tier:       tier,
    ttl:        ttl === -1 ? Infinity : ttl,
    tags:       tags,
    agent_id:   agentId,
    created_at: _now(),
    updated_at: _now(),
    hit_count:  0,
  };
  return { ok: true, key: key, tier: tier, expires_in_ms: ttl === -1 ? null : ttl };
}

function opGet(payload) {
  var key = payload.key || payload;
  if (!key) return { ok: false, error: 'key required' };
  var entry = _store[key];
  if (!entry)          return { ok: false, error: 'not found: ' + key };
  if (_isExpired(entry)) {
    delete _store[key];
    return { ok: false, error: 'expired: ' + key };
  }
  entry.hit_count++;
  entry.updated_at = _now();
  return { ok: true, key: key, value: entry.value, tier: entry.tier,
           age_ms: _now() - entry.created_at, hit_count: entry.hit_count };
}

function opList(payload) {
  var tag     = (payload && payload.tag)     || null;
  var tier    = (payload && payload.tier)    || null;
  var agentId = (payload && payload.agent_id) || null;
  var limit   = (payload && payload.limit)   || 50;

  var results = _active().filter(function(e) {
    if (tag     && e.tags.indexOf(tag)    < 0) return false;
    if (tier    && e.tier !== tier.toUpperCase()) return false;
    if (agentId && e.agent_id !== agentId)     return false;
    return true;
  });
  // Sort by most recently updated
  results.sort(function(a, b) { return b.updated_at - a.updated_at; });
  return {
    ok: true,
    count: results.length,
    entries: results.slice(0, limit).map(function(e) {
      return { key: e.key, tier: e.tier, tags: e.tags, age_ms: _now() - e.created_at,
               agent_id: e.agent_id, hit_count: e.hit_count };
    }),
  };
}

function opPromote(payload) {
  var key = payload.key;
  if (!key) return { ok: false, error: 'key required' };
  var entry = _store[key];
  if (!entry)         return { ok: false, error: 'not found: ' + key };
  if (_isExpired(entry)) return { ok: false, error: 'expired: ' + key };

  // Emit a promote event so organism-bridge.js can route to MEMORIA SACRA
  var promotePayload = {
    type:    'PROMOTE_TO_SACRA',
    key:     entry.key,
    value:   entry.value,
    tags:    entry.tags,
    from_tier: entry.tier,
    promoted_at: _now(),
  };
  // Archive from VIVA
  delete _store[key];

  return { ok: true, promoted: true, key: key, sacra_payload: promotePayload };
}

function opExpire(payload) {
  var key = payload.key;
  if (!key) return { ok: false, error: 'key required' };
  if (!_store[key]) return { ok: false, error: 'not found: ' + key };
  delete _store[key];
  return { ok: true, expired: key };
}

function opFlush() {
  var before = Object.keys(_store).length;
  var flushed = 0;
  Object.keys(_store).forEach(function(k) {
    if (_isExpired(_store[k])) {
      delete _store[k];
      flushed++;
    }
  });
  return { ok: true, flushed: flushed, remaining: Object.keys(_store).length, before: before };
}

function opSnapshot() {
  var active = _active();
  return {
    ok: true,
    snapshot_at: _now(),
    count: active.length,
    entries: active.map(function(e) {
      return {
        key: e.key, value: e.value, tier: e.tier, tags: e.tags,
        age_ms: _now() - e.created_at, agent_id: e.agent_id,
      };
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
    ttl_presets:   TTL,
    operations:    ['set','get','list','promote','expire','flush','snapshot','manifest','status'],
    classification: CLASSIFICATION,
  };
}

function opStatus() {
  var active = _active();
  var byTier = {};
  active.forEach(function(e) { byTier[e.tier] = (byTier[e.tier] || 0) + 1; });
  return {
    ok:           true,
    healthy:      true,
    worker_name:  WORKER_NAME,
    active_count: active.length,
    total_keys:   Object.keys(_store).length,
    by_tier:      byTier,
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
      case 'set':      result = opSet(pay);      break;
      case 'get':      result = opGet(pay);      break;
      case 'list':     result = opList(pay);     break;
      case 'promote':  result = opPromote(pay);  break;
      case 'expire':   result = opExpire(pay);   break;
      case 'flush':    result = opFlush();        break;
      case 'snapshot': result = opSnapshot();    break;
      case 'manifest': result = opManifest();    break;
      case 'status':   result = opStatus();      break;
      default:
        result = { ok: false, error: 'Unknown operation: ' + op,
                   available: ['set','get','list','promote','expire','flush','snapshot','manifest','status'] };
    }
  } catch (e) {
    result = { ok: false, error: String(e), op: op };
  }

  self.postMessage({ worker: WORKER_NAME, op: op, requestId: reqId, result: result, phi: PHI });
};

// Auto-flush expired entries every 30 seconds
setInterval(opFlush, 30000);

// Heartbeat at φ Hz
setInterval(function() {
  var active = _active();
  self.postMessage({
    worker:   WORKER_NAME,
    type:     'heartbeat',
    alive:    true,
    active_count: active.length,
    uptime_ms: _now() - BOOT_TIME,
    phi:      PHI,
  });
}, HEARTBEAT_MS);
