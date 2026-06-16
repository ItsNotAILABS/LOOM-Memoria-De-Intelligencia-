/**
 * ORGANISM BRIDGE — PONS ORGANISMI
 * "Cerebrum et corpus connectuntur." (Brain and body are connected.)
 *
 * Main-thread bridge that boots the engine worker, routes commands,
 * and exposes window.organism for console telemetry.
 *
 * Zero dependencies. Runs in any modern browser.
 *
 *   boot()              — start the engine worker
 *   dispatch(cap, data)  — fire a task to the best-matching engine
 *   route(cap)           — query which engine would handle a capability
 *   query(target)        — get engines/wires/capabilities/status data
 *   status()             — get full engine status
 *   onHeartbeat(fn)      — subscribe to heartbeat events
 *   onMetrics(fn)        — subscribe to full metrics events
 *   onDispatch(fn)       — subscribe to dispatch results
 *
 * Usage:
 *   <script src="organism-bridge.js"></script>
 *   <script>
 *     organism.boot();
 *     organism.dispatch('reasoning', { question: 'What is φ?' });
 *   </script>
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

(function() {
  'use strict';

  let worker = null;
  let booted = false;

  // Event subscribers
  const listeners = {
    heartbeat: [],
    metrics: [],
    dispatch: [],
    route: [],
    query: [],
    boot: [],
    error: [],
    any: [],
  };

  // Last known state
  const state = {
    beat: 0,
    engines: 0,
    wires: 0,
    dispatches: 0,
    uptime: 0,
    alive: 0,
    capabilities: 0,
    families: 0,
    booted: false,
    workers: 0,
  };

  const workers = {
    engine: null,
    protocol: null,
    memory: null,
    communication: null,
    security: null,
    math: null,
    evolution: null,
  };
  const workerListeners = {};

  function emit(channel, data) {
    (listeners[channel] || []).forEach(fn => { try { fn(data); } catch(e) { console.error('[organism]', e); } });
    listeners.any.forEach(fn => { try { fn(channel, data); } catch(e) { console.error('[organism]', e); } });
  }

  function handleMessage(e) {
    const msg = e.data;
    if (!msg || !msg.type) return;

    switch (msg.type) {
      case 'booted':
        booted = true;
        state.booted = true;
        state.engines = msg.engines;
        state.wires = msg.wires;
        state.capabilities = msg.capabilities;
        state.families = msg.families;
        emit('boot', msg);
        break;
      case 'heartbeat':
        state.beat = msg.beat;
        state.engines = msg.engines;
        state.wires = msg.wires;
        state.dispatches = msg.dispatches;
        state.uptime = msg.uptime;
        state.alive = msg.alive;
        emit('heartbeat', msg);
        break;
      case 'metrics':
        state.beat = msg.beat;
        emit('metrics', msg);
        break;
      case 'dispatch-result':
        state.dispatches = msg.dispatchId;
        emit('dispatch', msg);
        break;
      case 'route-result':
        emit('route', msg);
        break;
      case 'query-result':
        emit('query', msg);
        break;
      case 'status-result':
        Object.assign(state, msg);
        emit('query', msg);
        break;
      case 'error':
        emit('error', msg);
        console.warn('[organism] Engine error:', msg.message);
        break;
    }
  }

  function createWorkerHandler(name) {
    return function(e) {
      var msg = e.data;
      if (!msg || !msg.type) return;
      if (msg.type === 'booted') {
        emit('worker-boot', { worker: name, data: msg });
      } else if (msg.type === 'heartbeat') {
        emit('worker-heartbeat', { worker: name, data: msg });
      } else {
        emit('worker-result', { worker: name, data: msg });
      }
      emit('any', { channel: 'worker-' + name, data: msg });
    };
  }

  // ── Public API ─────────────────────────────────────────────────────────

  const bridge = {
    /** Boot the engine worker */
    boot: function(workerPath) {
      if (worker) return bridge;
      const path = workerPath || 'engine-worker.js';
      worker = new Worker(path);
      worker.onmessage = handleMessage;
      worker.onerror = function(err) {
        emit('error', { message: err.message || 'Worker error' });
        console.error('[organism] Worker error:', err);
      };
      // Boot specialized workers
      var workerDir = path.substring(0, path.lastIndexOf('/') + 1) || '';
      var specializedWorkers = ['protocol', 'memory', 'communication', 'security', 'math', 'evolution', 'careers', 'protocols', 'taxonomy', 'veritas', 'sovereign-token', 'inference', 'houses', 'canister', 'cloudflare', 'lingua', 'agi-knowledge', 'papers', 'context', 'edge-gate', 'blockchain-edge', 'animus'];
      specializedWorkers.forEach(function(name) {
        try {
          workers[name] = new Worker(workerDir + name + '-worker.js');
          workers[name].onmessage = createWorkerHandler(name);
          workers[name].onerror = function(err) {
            emit('error', { message: name + ' worker error: ' + (err.message || 'Unknown') });
          };
        } catch(e) {
          console.warn('[organism] Could not boot ' + name + ' worker:', e.message);
        }
      });
      workers.engine = worker;
      state.workers = bridge.getWorkers().length;
      return bridge;
    },

    /** Dispatch a task to the best engine for a capability */
    dispatch: function(capability, payload, priority) {
      if (!worker) { console.warn('[organism] Not booted'); return bridge; }
      worker.postMessage({ type: 'dispatch', capability: capability, payload: payload, priority: priority });
      return bridge;
    },

    /** Query which engine would handle a capability */
    route: function(capability) {
      if (!worker) return bridge;
      worker.postMessage({ type: 'route', capability: capability });
      return bridge;
    },

    /** Query engine data: 'engines', 'wires', 'capabilities', 'status' */
    query: function(target) {
      if (!worker) return bridge;
      worker.postMessage({ type: 'query', target: target || 'status' });
      return bridge;
    },

    /** Get full status */
    status: function() {
      if (!worker) return bridge;
      worker.postMessage({ type: 'status' });
      return bridge;
    },

    /** Subscribe to heartbeat events */
    onHeartbeat: function(fn) { listeners.heartbeat.push(fn); return bridge; },
    /** Subscribe to full metrics (every 5th beat) */
    onMetrics: function(fn) { listeners.metrics.push(fn); return bridge; },
    /** Subscribe to dispatch results */
    onDispatch: function(fn) { listeners.dispatch.push(fn); return bridge; },
    /** Subscribe to route results */
    onRoute: function(fn) { listeners.route.push(fn); return bridge; },
    /** Subscribe to query results */
    onQuery: function(fn) { listeners.query.push(fn); return bridge; },
    /** Subscribe to boot event */
    onBoot: function(fn) { listeners.boot.push(fn); return bridge; },
    /** Subscribe to errors */
    onError: function(fn) { listeners.error.push(fn); return bridge; },
    /** Subscribe to any event: fn(channel, data) */
    onAny: function(fn) { listeners.any.push(fn); return bridge; },

    /** Send to a specific worker */
    send: function(workerName, message) {
      var w = workers[workerName];
      if (w) w.postMessage(message);
      return bridge;
    },

    /** Protocol operations */
    protocol: function(action, data) {
      return bridge.send('protocol', Object.assign({ type: action }, data || {}));
    },

    /** Memory operations */
    memory: function(action, data) {
      return bridge.send('memory', Object.assign({ type: action }, data || {}));
    },

    /** Communication operations */
    comm: function(action, data) {
      return bridge.send('communication', Object.assign({ type: action }, data || {}));
    },

    /** Security operations */
    security: function(action, data) {
      return bridge.send('security', Object.assign({ type: action }, data || {}));
    },

    /** Math operations */
    math: function(action, data) {
      return bridge.send('math', Object.assign({ type: action }, data || {}));
    },

    /** Evolution operations */
    evolution: function(action, data) {
      return bridge.send('evolution', Object.assign({ type: action }, data || {}));
    },

    /** Careers operations — 100 sovereign career flows */
    careers: function(action, data) {
      return bridge.send('careers', Object.assign({ type: action }, data || {}));
    },

    /** Enterprise protocols marketplace */
    protocols: function(action, data) {
      return bridge.send('protocols', Object.assign({ type: action }, data || {}));
    },

    /** AI Relationship Taxonomy — 4 categories, languages, scattered servers */
    taxonomy: function(action, data) {
      return bridge.send('taxonomy', Object.assign({ type: action }, data || {}));
    },

    /** ROOT/VERITAS — Sovereign identifier preservation database */
    veritas: function(action, data) {
      return bridge.send('veritas', Object.assign({ type: action }, data || {}));
    },

    /** TT-012 SOVEREIGN — Self-governing token engine */
    sovereignToken: function(action, data) {
      return bridge.send('sovereign-token', Object.assign({ type: action }, data || {}));
    },

    /** INTELLIGENTIA INFERENS — AI inference: summarize, QA, classify, reason, topics */
    inference: function(action, data) {
      return bridge.send('inference', Object.assign({ type: action }, data || {}));
    },

    /** DOMUS SOVEREIGN — 181 Houses HQ database, research papers, career ecology */
    houses: function(action, data) {
      return bridge.send('houses', Object.assign({ type: action }, data || {}));
    },

    /** FABRICATOR CANISTRORUM — Sovereign canister builder division (10 types: AURUM/ARGENTUM/AES/CATENA/CRYPTO/ORGANISMUS/PROTOCOLLUM/ELEMENTUM/PHANTASMA/QUANTUM) */
    canister: function(action, data) {
      return bridge.send('canister', Object.assign({ type: action }, data || {}));
    },

    /** OCTO CUSTODES MUNDI — 8 Cloudflare Worker AGIs with ANIMA MICRO (brain 7.83Hz + heart φHz) */
    cloudflare: function(action, data) {
      return bridge.send('cloudflare', Object.assign({ type: action }, data || {}));
    },

    /** PORTA LIMITIS — Edge Gate Strategy: 3-layer defense (Cloudflare/Browser/Canister) */
    edgeGate: function(action, data) {
      return bridge.send('edge-gate', Object.assign({ type: action }, data || {}));
    },

    /** Get a specific worker instance */
    getWorker: function(name) {
      return workers[name] || null;
    },

    /** Subscribe to worker boot events */
    onWorkerBoot: function(fn) { listeners['worker-boot'] = listeners['worker-boot'] || []; listeners['worker-boot'].push(fn); return bridge; },

    /** Subscribe to worker heartbeats */
    onWorkerHeartbeat: function(fn) { listeners['worker-heartbeat'] = listeners['worker-heartbeat'] || []; listeners['worker-heartbeat'].push(fn); return bridge; },

    /** Subscribe to worker results */
    onWorkerResult: function(fn) { listeners['worker-result'] = listeners['worker-result'] || []; listeners['worker-result'].push(fn); return bridge; },

    /** Get list of all workers */
    getWorkers: function() {
      return Object.keys(workers).filter(function(k) { return workers[k] !== null; });
    },

    /** Current state snapshot */
    get state() { return Object.assign({}, state); },

    /** Whether the engine is booted */
    get isBooted() { return booted; },
  };

  // Expose globally
  if (typeof window !== 'undefined') {
    window.organism = bridge;
  }
})();
