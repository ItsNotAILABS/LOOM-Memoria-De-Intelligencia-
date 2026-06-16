/**
 * ORGANISM BRIDGE — PONS ORGANISMI
 * Registry-first runtime bridge with pack profiles + control plane.
 */

(function() {
  'use strict';

  const PHI = 1.618033988749895;
  const PHI_SQ = 2.618033988749895;
  const INV_PHI = 0.6180339887498948;

  const DEFAULT_SPECIALIZED_WORKERS = [
    'protocol', 'memory', 'communication', 'security', 'math', 'evolution',
    'careers', 'protocols', 'taxonomy', 'veritas', 'sovereign-token',
    'inference', 'houses', 'canister', 'cloudflare', 'lingua', 'agi-knowledge',
    'papers', 'context', 'edge-gate', 'blockchain-edge', 'animus',
    'cognitive-language', 'frequency-stack', 'license', 'world-integrator',
    'phantom-sensor', 'phantom-field', 'memoria-sacra', 'memoria-viva',
    'memoria-nexus', 'economics'
  ];

  let worker = null;
  let booted = false;
  const workers = { engine: null };

  const listeners = {
    heartbeat: [],
    metrics: [],
    dispatch: [],
    route: [],
    query: [],
    boot: [],
    error: [],
    any: [],
    'worker-boot': [],
    'worker-heartbeat': [],
    'worker-result': [],
    'registry-loaded': [],
    'pack-profile': [],
    'control-plane': [],
    'incident': [],
  };

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
    profile: 'full',
    registryFirst: true,
  };

  const runtimeRegistry = {
    source: 'builtin',
    loadedAt: null,
    registryFirst: true,
    foundationalWorkers: ['engine', 'memory', 'security', 'protocol'],
    workerCatalog: DEFAULT_SPECIALIZED_WORKERS.slice(),
    profiles: {
      full: { workers: 'all', allow_shutdown_foundational: false },
      ops: {
        workers: [
          'protocol', 'memory', 'communication', 'security', 'math', 'veritas',
          'inference', 'edge-gate', 'houses', 'cognitive-language', 'frequency-stack'
        ],
        allow_shutdown_foundational: false,
      },
      minimal: {
        workers: ['protocol', 'memory', 'security', 'math', 'context'],
        allow_shutdown_foundational: false,
      },
      rebuild: {
        workers: [
          'protocol', 'memory', 'security', 'math', 'context', 'papers',
          'canister', 'cloudflare', 'cognitive-language', 'frequency-stack'
        ],
        allow_shutdown_foundational: false,
      },
    },
    mathSurface: {
      phi: PHI,
      phi_sq: PHI_SQ,
      inv_phi: INV_PHI,
      heartbeat_ms: 618,
    },
  };

  const controlPlane = {
    profileHistory: [],
    actionHistory: [],
    workerState: {},
    incidents: [],
  };
  let incidentSeq = 0;

  function nowISO() {
    return new Date().toISOString();
  }

  function emit(channel, data) {
    (listeners[channel] || []).forEach(function(fn) {
      try { fn(data); } catch (e) { console.error('[organism]', e); }
    });
    listeners.any.forEach(function(fn) {
      try { fn(channel, data); } catch (e) { console.error('[organism]', e); }
    });
  }

  function addIncident(level, message, details) {
    incidentSeq += 1;
    const incidentId = (typeof crypto !== 'undefined' && crypto.randomUUID)
      ? crypto.randomUUID()
      : ('inc-' + Date.now() + '-' + incidentSeq);
    const incident = {
      id: incidentId,
      level: level,
      message: message,
      details: details || {},
      timestamp: nowISO(),
    };
    controlPlane.incidents.push(incident);
    if (controlPlane.incidents.length > 500) {
      controlPlane.incidents = controlPlane.incidents.slice(-500);
    }
    emit('incident', incident);
    if (level === 'error') {
      emit('error', { message: message, details: details || {} });
    }
  }

  function ensureWorkerState(name) {
    if (!controlPlane.workerState[name]) {
      controlPlane.workerState[name] = {
        name: name,
        desired: 'on',
        running: false,
        heartbeats: 0,
        failures: 0,
        lastHeartbeatAt: null,
        lastResultAt: null,
        lastAction: 'none',
        lastActionAt: null,
      };
    }
    return controlPlane.workerState[name];
  }

  function isFoundational(name) {
    return runtimeRegistry.foundationalWorkers.indexOf(name) !== -1;
  }

  function shouldAllowWorkerByRegistry(name) {
    if (!runtimeRegistry.registryFirst) return true;
    return runtimeRegistry.workerCatalog.indexOf(name) !== -1;
  }

  function desiredWorkersForProfile(profileName) {
    const profile = runtimeRegistry.profiles[profileName] || runtimeRegistry.profiles.full;
    if (!profile || profile.workers === 'all') {
      return runtimeRegistry.workerCatalog.slice();
    }
    return profile.workers.slice();
  }

  function updateWorkerCount() {
    state.workers = Object.keys(workers).filter(function(k) {
      return workers[k] !== null;
    }).length;
  }

  function createWorkerHandler(name) {
    return function(e) {
      const msg = e.data;
      const ws = ensureWorkerState(name);
      if (!msg || !msg.type) return;

      if (msg.type === 'booted') {
        ws.running = true;
        ws.lastResultAt = nowISO();
        emit('worker-boot', { worker: name, data: msg });
      } else if (msg.type === 'heartbeat') {
        ws.running = true;
        ws.heartbeats += 1;
        ws.lastHeartbeatAt = nowISO();
        emit('worker-heartbeat', { worker: name, data: msg });
      } else {
        ws.running = true;
        ws.lastResultAt = nowISO();
        emit('worker-result', { worker: name, data: msg });
      }
    };
  }

  function registerWorkerInstance(name, instance) {
    workers[name] = instance;
    const ws = ensureWorkerState(name);
    ws.running = true;
    ws.lastAction = 'on';
    ws.lastActionAt = nowISO();
    updateWorkerCount();
  }

  function bootOneWorker(name, workerDir) {
    if (!shouldAllowWorkerByRegistry(name)) {
      addIncident('warning', 'Registry blocked unregistered worker', { worker: name });
      return false;
    }
    if (workers[name]) return true;

    try {
      const instance = new Worker(workerDir + name + '-worker.js');
      instance.onmessage = createWorkerHandler(name);
      instance.onerror = function(err) {
        const ws = ensureWorkerState(name);
        ws.failures += 1;
        addIncident('error', name + ' worker error', { message: err.message || 'Unknown' });
      };
      registerWorkerInstance(name, instance);
      return true;
    } catch (e) {
      const ws = ensureWorkerState(name);
      ws.failures += 1;
      addIncident('error', 'Could not boot worker', { worker: name, message: e.message || 'Unknown' });
      return false;
    }
  }

  function terminateWorker(name) {
    const w = workers[name];
    if (!w) return true;
    try {
      w.terminate();
    } catch (_e) {
      return false;
    }
    workers[name] = null;
    const ws = ensureWorkerState(name);
    ws.running = false;
    updateWorkerCount();
    return true;
  }

  function applyProfileInternal(profileName, reason) {
    const selected = runtimeRegistry.profiles[profileName] ? profileName : 'full';
    const desiredSet = desiredWorkersForProfile(selected);
    const desiredLookup = {};

    desiredSet.forEach(function(name) { desiredLookup[name] = true; });

    runtimeRegistry.workerCatalog.forEach(function(name) {
      const ws = ensureWorkerState(name);
      ws.desired = desiredLookup[name] ? 'on' : 'off';
    });

    Object.keys(workers).forEach(function(name) {
      if (name === 'engine') return;
      if (!workers[name]) return;
      if (!desiredLookup[name]) {
        const allowedShutdown = runtimeRegistry.profiles[selected].allow_shutdown_foundational === true;
        if (isFoundational(name) && !allowedShutdown) {
          addIncident('warning', 'Profile attempted foundational shutdown and was blocked', { worker: name, profile: selected });
          return;
        }
        terminateWorker(name);
      }
    });

    const action = {
      action: 'apply-profile',
      profile: selected,
      reason: reason || 'manual',
      timestamp: nowISO(),
    };

    controlPlane.profileHistory.push(action);
    controlPlane.actionHistory.push(action);
    if (controlPlane.profileHistory.length > 200) {
      controlPlane.profileHistory = controlPlane.profileHistory.slice(-200);
    }
    if (controlPlane.actionHistory.length > 500) {
      controlPlane.actionHistory = controlPlane.actionHistory.slice(-500);
    }

    state.profile = selected;
    emit('pack-profile', action);
    emit('control-plane', bridge.controlPlaneStatus());

    return selected;
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
        addIncident('error', 'Engine error', msg);
        break;
    }
  }

  const bridge = {
    boot: function(workerPath) {
      if (worker) {
        applyProfileInternal(state.profile || 'full', 'boot-refresh');
        return bridge;
      }

      const path = workerPath || 'engine-worker.js';
      worker = new Worker(path);
      worker.onmessage = handleMessage;
      worker.onerror = function(err) {
        addIncident('error', 'Engine worker error', { message: err.message || 'Worker error' });
      };

      const workerDir = path.substring(0, path.lastIndexOf('/') + 1) || '';
      registerWorkerInstance('engine', worker);

      const profileWorkers = desiredWorkersForProfile(state.profile || 'full');
      profileWorkers.forEach(function(name) {
        bootOneWorker(name, workerDir);
      });

      applyProfileInternal(state.profile || 'full', 'boot');
      return bridge;
    },

    configureRegistry: function(config) {
      config = config || {};
      if (typeof config.registry_first === 'boolean') {
        runtimeRegistry.registryFirst = config.registry_first;
      }
      if (Array.isArray(config.foundational_workers)) {
        runtimeRegistry.foundationalWorkers = config.foundational_workers.slice();
      }
      if (Array.isArray(config.worker_catalog)) {
        runtimeRegistry.workerCatalog = config.worker_catalog.slice();
      }
      if (config.profiles && typeof config.profiles === 'object') {
        runtimeRegistry.profiles = Object.assign({}, runtimeRegistry.profiles, config.profiles);
      }
      if (config.math_surface && typeof config.math_surface === 'object') {
        runtimeRegistry.mathSurface = Object.assign({}, runtimeRegistry.mathSurface, config.math_surface);
      }
      runtimeRegistry.source = config.source || runtimeRegistry.source;
      runtimeRegistry.loadedAt = nowISO();
      state.registryFirst = runtimeRegistry.registryFirst;

      emit('registry-loaded', {
        source: runtimeRegistry.source,
        loadedAt: runtimeRegistry.loadedAt,
        registryFirst: runtimeRegistry.registryFirst,
      });
      emit('control-plane', bridge.controlPlaneStatus());
      return bridge;
    },

    loadAtlasRuntimeConfig: function(url) {
      const target = url || '../../atlas/registry/runtime/pack-profiles.json';
      return fetch(target)
        .then(function(res) {
          if (!res.ok) throw new Error('HTTP ' + res.status);
          return res.json();
        })
        .then(function(data) {
          data.source = target;
          bridge.configureRegistry(data);
          return data;
        })
        .catch(function(err) {
          addIncident('warning', 'Atlas runtime config load failed; using in-memory defaults', { url: target, message: err.message || String(err) });
          return null;
        });
    },

    applyPackProfile: function(profileName) {
      applyProfileInternal(profileName || 'full', 'api');
      if (worker) {
        const path = 'engine-worker.js';
        const workerDir = path.substring(0, path.lastIndexOf('/') + 1) || '';
        desiredWorkersForProfile(state.profile).forEach(function(name) {
          if (!workers[name]) bootOneWorker(name, workerDir);
        });
      }
      return bridge;
    },

    controlWorker: function(workerName, action) {
      const name = workerName;
      const act = (action || '').toLowerCase();
      const ws = ensureWorkerState(name);
      const profile = runtimeRegistry.profiles[state.profile] || {};
      const allowFoundationalShutdown = profile.allow_shutdown_foundational === true;

      if (act === 'off') {
        if (isFoundational(name) && !allowFoundationalShutdown) {
          addIncident('warning', 'Foundational shutdown blocked by policy guard', { worker: name, profile: state.profile });
          return { ok: false, reason: 'foundational_guard' };
        }
        ws.desired = 'off';
        ws.lastAction = 'off';
        ws.lastActionAt = nowISO();
        terminateWorker(name);
      } else if (act === 'on') {
        ws.desired = 'on';
        ws.lastAction = 'on';
        ws.lastActionAt = nowISO();
        if (worker) {
          const path = 'engine-worker.js';
          const workerDir = path.substring(0, path.lastIndexOf('/') + 1) || '';
          bootOneWorker(name, workerDir);
        }
      } else if (act === 'pause' || act === 'resume') {
        ws.lastAction = act;
        ws.lastActionAt = nowISO();
        const w = workers[name];
        if (w) w.postMessage({ type: act });
      } else {
        return { ok: false, reason: 'invalid_action' };
      }

      const actionRecord = {
        action: 'worker-' + act,
        worker: name,
        timestamp: nowISO(),
      };
      controlPlane.actionHistory.push(actionRecord);
      if (controlPlane.actionHistory.length > 500) {
        controlPlane.actionHistory = controlPlane.actionHistory.slice(-500);
      }

      emit('control-plane', bridge.controlPlaneStatus());
      return { ok: true };
    },

    dispatch: function(capability, payload, priority) {
      if (!worker) return bridge;
      worker.postMessage({ type: 'dispatch', capability: capability, payload: payload, priority: priority });
      return bridge;
    },

    route: function(capability) {
      if (!worker) return bridge;
      worker.postMessage({ type: 'route', capability: capability });
      return bridge;
    },

    query: function(target) {
      if (!worker) return bridge;
      worker.postMessage({ type: 'query', target: target || 'status' });
      return bridge;
    },

    status: function() {
      if (!worker) return bridge;
      worker.postMessage({ type: 'status' });
      return bridge;
    },

    controlPlaneStatus: function() {
      return {
        profile: state.profile,
        registry: {
          source: runtimeRegistry.source,
          loadedAt: runtimeRegistry.loadedAt,
          registryFirst: runtimeRegistry.registryFirst,
          foundationalWorkers: runtimeRegistry.foundationalWorkers.slice(),
        },
        workers: controlPlane.workerState,
        actions: controlPlane.actionHistory.slice(-100),
        incidents: controlPlane.incidents.slice(-100),
      };
    },

    getIncidents: function(limit) {
      const n = Math.max(1, limit || 50);
      return controlPlane.incidents.slice(-n);
    },

    mathSurface: function() {
      return Object.assign({}, runtimeRegistry.mathSurface);
    },

    send: function(workerName, message) {
      const w = workers[workerName];
      if (w) {
        w.postMessage(message);
      } else {
        addIncident('warning', 'Message dropped; worker unavailable', { worker: workerName, messageType: message && message.type });
      }
      return bridge;
    },

    protocol: function(action, data) { return bridge.send('protocol', Object.assign({ type: action }, data || {})); },
    memory: function(action, data) { return bridge.send('memory', Object.assign({ type: action }, data || {})); },
    comm: function(action, data) { return bridge.send('communication', Object.assign({ type: action }, data || {})); },
    security: function(action, data) { return bridge.send('security', Object.assign({ type: action }, data || {})); },
    math: function(action, data) { return bridge.send('math', Object.assign({ type: action }, data || {})); },
    evolution: function(action, data) { return bridge.send('evolution', Object.assign({ type: action }, data || {})); },
    careers: function(action, data) { return bridge.send('careers', Object.assign({ type: action }, data || {})); },
    protocols: function(action, data) { return bridge.send('protocols', Object.assign({ type: action }, data || {})); },
    taxonomy: function(action, data) { return bridge.send('taxonomy', Object.assign({ type: action }, data || {})); },
    veritas: function(action, data) { return bridge.send('veritas', Object.assign({ type: action }, data || {})); },
    sovereignToken: function(action, data) { return bridge.send('sovereign-token', Object.assign({ type: action }, data || {})); },
    inference: function(action, data) { return bridge.send('inference', Object.assign({ type: action }, data || {})); },
    houses: function(action, data) { return bridge.send('houses', Object.assign({ type: action }, data || {})); },
    canister: function(action, data) { return bridge.send('canister', Object.assign({ type: action }, data || {})); },
    cloudflare: function(action, data) { return bridge.send('cloudflare', Object.assign({ type: action }, data || {})); },
    edgeGate: function(action, data) { return bridge.send('edge-gate', Object.assign({ type: action }, data || {})); },

    getWorker: function(name) { return workers[name] || null; },
    getWorkers: function() {
      return Object.keys(workers).filter(function(k) { return workers[k] !== null; });
    },

    onHeartbeat: function(fn) { listeners.heartbeat.push(fn); return bridge; },
    onMetrics: function(fn) { listeners.metrics.push(fn); return bridge; },
    onDispatch: function(fn) { listeners.dispatch.push(fn); return bridge; },
    onRoute: function(fn) { listeners.route.push(fn); return bridge; },
    onQuery: function(fn) { listeners.query.push(fn); return bridge; },
    onBoot: function(fn) { listeners.boot.push(fn); return bridge; },
    onError: function(fn) { listeners.error.push(fn); return bridge; },
    onAny: function(fn) { listeners.any.push(fn); return bridge; },
    onWorkerBoot: function(fn) { listeners['worker-boot'].push(fn); return bridge; },
    onWorkerHeartbeat: function(fn) { listeners['worker-heartbeat'].push(fn); return bridge; },
    onWorkerResult: function(fn) { listeners['worker-result'].push(fn); return bridge; },
    onRegistryLoaded: function(fn) { listeners['registry-loaded'].push(fn); return bridge; },
    onPackProfile: function(fn) { listeners['pack-profile'].push(fn); return bridge; },
    onControlPlane: function(fn) { listeners['control-plane'].push(fn); return bridge; },
    onIncident: function(fn) { listeners['incident'].push(fn); return bridge; },

    get state() { return Object.assign({}, state); },
    get isBooted() { return booted; },
  };

  if (typeof window !== 'undefined') {
    window.organism = bridge;
  }
})();
