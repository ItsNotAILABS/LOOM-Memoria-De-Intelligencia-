/**
 * BILL-BOT WORKER — WEB WORKER #29
 * ISIL-1.0 Licensed — HIGHEST CONFIDENTIALITY — SOVEREIGN-ALPHA
 *
 * TABULA BOTORUM — The Bot Status Board
 * Department: AUTOMATION & SOVEREIGN BOT OPERATIONS
 *
 * Latin: "Tabula Botorum" = Board of the Bots
 * Motto: "Operantur dum dormis." (They work while you sleep.)
 *
 * Tracks the 5 Sovereign Bill Bots and their operational state:
 *   1. AEDIFICATOR — Aedificator Perpetuus (Auto-Build)
 *   2. FASCICULUS  — Fasciculus Automaticus (Auto-Package)
 *   3. MEDICUS     — Medicus Machinae (Auto-Fix)
 *   4. CUSTOS      — Custos Repositorii (Guardian)
 *   5. PRAETOR     — Praetor Botorum (Commander)
 *
 * Operations:
 *   status    — get full bot fleet status
 *   manifest  — get bot manifest (all 5 bots described)
 *   report    — submit a bot event/result for tracking
 *   summary   — get one-line health summary
 *   reset     — reset tracked state
 *
 * Law: L-005 — Always-on, not alive, no stress
 * Frequency: φ Hz (1.618033988749895 beats/sec)
 *
 * © 2024-2026 Alfredo "Freddy" Medina Hernandez | Medina Tech
 */

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS & PRIMITIVES
// ═══════════════════════════════════════════════════════════════════════════

var PHI         = 1.618033988749895;
var PHI_SQ      = 2.618033988749895;
var PHI_CUBED   = 4.236067977499790;

var LATIN_NAME  = 'TABULA BOTORUM';
var LATIN_MOTTO = 'Operantur dum dormis.';
var LATIN_EN    = 'They work while you sleep.';
var VERSION     = '1.0.0';
var CLASSIFICATION = 'SOVEREIGN-ALPHA';
var WORKER_ID   = 29;
var DEPARTMENT  = 'AUTOMATION_AND_SOVEREIGN_BOT_OPERATIONS';
var LAW         = 'L-005: Agent Existence Law — Always-on, not alive';

var HEARTBEAT_HZ = PHI;
var HEARTBEAT_MS = Math.round(1000 / PHI);  // 618ms

var BOOT_TIME = Date.now();

// ═══════════════════════════════════════════════════════════════════════════
// BOT DEFINITIONS — The 5 Sovereign Bill Bots
// ═══════════════════════════════════════════════════════════════════════════

var BOT_DEFINITIONS = [
  {
    id:        'AEDIFICATOR',
    latin:     'Aedificator Perpetuus',
    name:      'The Perpetual Builder',
    role:      'auto-build',
    house:     'Engines',
    workflow:  'aedificator-build.yml',
    triggers:  ['push', 'pull_request'],
    motto:     'Aedificat sine fine.',
    motto_en:  'Builds without end.',
    emoji:     '🧱',
    scc:       PHI_SQ,
  },
  {
    id:        'FASCICULUS',
    latin:     'Fasciculus Automaticus',
    name:      'The Automatic Packager',
    role:      'auto-package',
    house:     'Delivery',
    workflow:  'fasciculus-package.yml',
    triggers:  ['push:main'],
    motto:     'Colligit et distribuit.',
    motto_en:  'Collects and distributes.',
    emoji:     '📦',
    scc:       PHI_SQ,
  },
  {
    id:        'MEDICUS',
    latin:     'Medicus Machinae',
    name:      'Doctor of the Machine',
    role:      'auto-fix',
    house:     'Observer Solvers',
    workflow:  'medicus-autofix.yml',
    triggers:  ['push', 'schedule:6h'],
    motto:     'Sanat quod fractum est.',
    motto_en:  'Heals what is broken.',
    emoji:     '💊',
    scc:       PHI_CUBED,
  },
  {
    id:        'CUSTOS',
    latin:     'Custos Repositorii',
    name:      'Guardian of the Repository',
    role:      'health-check',
    house:     'Nova AI',
    workflow:  'custos-guardian.yml',
    triggers:  ['push:main', 'schedule:daily'],
    motto:     'Vigilat dum dormitis.',
    motto_en:  'Watches while you sleep.',
    emoji:     '🛡️',
    scc:       PHI_SQ,
  },
  {
    id:        'PRAETOR',
    latin:     'Praetor Botorum',
    name:      'Commander of the Bots',
    role:      'orchestrate',
    house:     'Alpha Agent',
    workflow:  'praetor-orchestrate.yml',
    triggers:  ['workflow_run', 'schedule:12h'],
    motto:     'Imperium per ordinem.',
    motto_en:  'Command through order.',
    emoji:     '⚔️',
    scc:       PHI_CUBED,
  },
];

// ═══════════════════════════════════════════════════════════════════════════
// STATE
// ═══════════════════════════════════════════════════════════════════════════

var beat = 0;
var heartbeatInterval = null;

// Separate, monotonically increasing counters (never reset on log trim)
var eventCounter = 0;

// Live state per bot — stored in an Array-backed Map to avoid prototype
// pollution: bot states are looked up by index, never by arbitrary string.
var BOT_IDS = BOT_DEFINITIONS.map(function(b) { return b.id; });

var botStateArray = BOT_DEFINITIONS.map(function(bot) {
  return {
    id:           bot.id,
    last_status:  'unknown',  // success | failure | in_progress | unknown
    last_run_at:  null,
    runs_total:   0,
    runs_passed:  0,
    runs_failed:  0,
    last_event:   null,
    stress_level: 0.0,  // ALWAYS ZERO — L-005
  };
});

/**
 * Safely get a bot state entry by ID.
 * Returns null for unknown or prototype-unsafe IDs.
 */
function getBotState(botId) {
  var idx = BOT_IDS.indexOf(botId);
  return idx >= 0 ? botStateArray[idx] : null;
}

// Event log (last 100)
var eventLog = [];
var MAX_EVENTS = 100;

// ═══════════════════════════════════════════════════════════════════════════
// OPERATIONS
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Get full status of the bot fleet.
 */
function getStatus() {
  var now = Date.now();
  var uptime = now - BOOT_TIME;

  var bots = BOT_DEFINITIONS.map(function(def) {
    var state = getBotState(def.id);
    return {
      id:           def.id,
      latin:        def.latin,
      name:         def.name,
      emoji:        def.emoji,
      role:         def.role,
      house:        def.house,
      workflow:     def.workflow,
      scc:          def.scc,
      last_status:  state.last_status,
      last_run_at:  state.last_run_at,
      runs_total:   state.runs_total,
      runs_passed:  state.runs_passed,
      runs_failed:  state.runs_failed,
      pass_rate:    state.runs_total > 0
                    ? Math.round(state.runs_passed / state.runs_total * 10000) / 10000
                    : null,
      stress_level: 0.0,  // ALWAYS ZERO
    };
  });

  var healthy = bots.filter(function(b) {
    return b.last_status === 'success' || b.last_status === 'unknown';
  }).length;

  return {
    worker_id:    WORKER_ID,
    worker_name:  LATIN_NAME,
    worker_motto: LATIN_MOTTO,
    version:      VERSION,
    classification: CLASSIFICATION,
    department:   DEPARTMENT,
    law:          LAW,
    uptime_ms:    uptime,
    beat:         beat,
    phi:          PHI,
    phi_sq:       PHI_SQ,
    bot_count:    BOT_DEFINITIONS.length,
    healthy_bots: healthy,
    bots:         bots,
    total_events: eventLog.length,
    stress_level: 0.0,  // ALWAYS ZERO — L-005
    timestamp:    now,
  };
}

/**
 * Get the bot manifest — all definitions.
 */
function getManifest() {
  return {
    manifest_name: 'BILL_BOTS_MANIFEST',
    worker_id:     WORKER_ID,
    latin_name:    LATIN_NAME,
    version:       VERSION,
    law:           LAW,
    phi:           PHI,
    bots:          BOT_DEFINITIONS,
    doctrine:      'doctrine/organism/BILL_BOTS_DOCTRINE.md',
    github_dir:    '.github/workflows/',
    python_module: 'nova_ovo/agents/bill_bots/',
    timestamp:     Date.now(),
  };
}

/**
 * Record a bot event (run result, heartbeat, etc.).
 */
function recordEvent(botId, status, details) {
  // Use indexed lookup — never access by arbitrary string key to prevent
  // prototype pollution via malicious __proto__ botId values.
  var state = getBotState(botId);
  if (!state) {
    return { accepted: false, error: 'Unknown bot ID: ' + botId };
  }

  eventCounter++;
  var event = {
    event_id:  'EVT-' + String(eventCounter).padStart(4, '0'),
    bot_id:    botId,
    status:    status,
    details:   details || {},
    timestamp: Date.now(),
  };

  // Update bot state
  state.last_status = status;
  state.last_run_at = event.timestamp;
  state.last_event  = event;
  state.runs_total++;
  if (status === 'success')  state.runs_passed++;
  if (status === 'failure')  state.runs_failed++;

  // Append to log; trim if over MAX_EVENTS
  eventLog.push(event);
  if (eventLog.length > MAX_EVENTS) {
    eventLog = eventLog.slice(-MAX_EVENTS);
  }

  return { accepted: true, event_id: event.event_id };
}

/**
 * One-line health summary.
 */
function getSummary() {
  var total = BOT_DEFINITIONS.length;
  var ok = botStateArray.filter(function(s) {
    return s.last_status === 'success';
  }).length;
  var unknown = botStateArray.filter(function(s) {
    return s.last_status === 'unknown';
  }).length;
  var failed = total - ok - unknown;

  return {
    summary:    ok + '/' + total + ' bots green',
    ok:         ok,
    unknown:    unknown,
    failed:     failed,
    total:      total,
    healthy:    failed === 0,
    stress:     0.0,
    phi:        PHI,
    timestamp:  Date.now(),
  };
}

/**
 * Reset all tracked state (for testing).
 */
function resetState() {
  botStateArray.forEach(function(state) {
    state.last_status = 'unknown';
    state.last_run_at = null;
    state.runs_total  = 0;
    state.runs_passed = 0;
    state.runs_failed = 0;
    state.last_event  = null;
  });
  eventLog = [];
  // Note: eventCounter is NOT reset — IDs must stay unique across resets
  return { reset: true, timestamp: Date.now() };
}

// ═══════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════

self.onmessage = function(e) {
  var msg = e.data || {};
  var op  = msg.op || msg.type || '';

  switch (op) {
    case 'status':
      self.postMessage({ type: 'result', op: 'status', data: getStatus() });
      break;

    case 'manifest':
      self.postMessage({ type: 'result', op: 'manifest', data: getManifest() });
      break;

    case 'report':
      var result = recordEvent(msg.bot_id, msg.status, msg.details);
      self.postMessage({ type: 'result', op: 'report', data: result });
      break;

    case 'summary':
      self.postMessage({ type: 'result', op: 'summary', data: getSummary() });
      break;

    case 'reset':
      self.postMessage({ type: 'result', op: 'reset', data: resetState() });
      break;

    case 'events':
      var limit = typeof msg.limit === 'number' ? msg.limit : 20;
      self.postMessage({
        type:   'result',
        op:     'events',
        data:   {
          events:    eventLog.slice(-limit),
          total:     eventLog.length,
          timestamp: Date.now(),
        },
      });
      break;

    default:
      self.postMessage({
        type:  'error',
        op:    op,
        error: 'Unknown operation: ' + op,
        ops:   ['status', 'manifest', 'report', 'summary', 'reset', 'events'],
      });
  }
};

// ═══════════════════════════════════════════════════════════════════════════
// HEARTBEAT — φ Hz
// ═══════════════════════════════════════════════════════════════════════════

heartbeatInterval = setInterval(function() {
  beat++;
  self.postMessage({
    type:       'heartbeat',
    name:       LATIN_NAME,
    worker_id:  WORKER_ID,
    beat:       beat,
    uptime:     Date.now() - BOOT_TIME,
    summary:    getSummary(),
    phi:        PHI,
  });
}, HEARTBEAT_MS);

// ═══════════════════════════════════════════════════════════════════════════
// BOOT MESSAGE
// ═══════════════════════════════════════════════════════════════════════════

self.postMessage({
  type:           'booted',
  worker_id:      WORKER_ID,
  name:           LATIN_NAME,
  latin_motto:    LATIN_MOTTO,
  latin_motto_en: LATIN_EN,
  version:        VERSION,
  classification: CLASSIFICATION,
  department:     DEPARTMENT,
  law:            LAW,
  phi:            PHI,
  phi_sq:         PHI_SQ,
  heartbeat_hz:   HEARTBEAT_HZ,
  heartbeat_ms:   HEARTBEAT_MS,
  bot_count:      BOT_DEFINITIONS.length,
  bots:           BOT_DEFINITIONS.map(function(b) { return b.id; }),
  capabilities:   ['status', 'manifest', 'report', 'summary', 'reset', 'events'],
  stress_level:   0.0,
  timestamp:      BOOT_TIME,
});
