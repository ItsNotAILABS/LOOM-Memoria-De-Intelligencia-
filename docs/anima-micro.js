/**
 * ANIMA MICRO — ANIMA MICROSCOPICA
 * "Parvum cerebrum, parvum cor, magna vita."
 * (Small brain, small heart, great life.)
 *
 * The official protocol/database/callable specification for the mini brain
 * and mini heart that every mini worker has. A module that can be imported
 * by other Web Workers (by inlining/including), defining the living standard.
 *
 * ANIMA MICRO answers the question: "What IS the mini brain and mini heart?"
 *
 * PROTOCOL — Defines the spec for how any micro-engine must pulse and think
 * DATABASE — Stores the living state of each micro-engine's brain and heart
 * CALLABLE — Provides callable functions (think, pulse, reflect, status)
 *
 * Protocol: postMessage (when run as a worker)
 *   Main → Worker: { type: 'create', id }
 *   Main → Worker: { type: 'think', id, input }
 *   Main → Worker: { type: 'pulse', id }
 *   Main → Worker: { type: 'status', id }
 *   Main → Worker: { type: 'spec' }
 *   Worker → Main: { type: 'booted', name: 'ANIMA MICRO', spec }
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

// ─── Constants ───────────────────────────────────────────────────────────────
const PHI = 1.618033988749895;
const SCHUMANN_HZ = 7.83;
const PULSE_MS = Math.round(1000 / PHI); // 618ms

// ─── ANIMA MICRO SPEC ────────────────────────────────────────────────────────
const ANIMA_MICRO_SPEC = {
  name: 'ANIMA MICRO',
  latin: 'ANIMA MICROSCOPICA',
  version: '1.0.0',
  description:
    'The living standard for sovereign micro-engines. ' +
    'Every mini worker carries a mini brain (Schumann-tuned cognition) ' +
    'and a mini heart (golden-ratio pulse). This spec defines what they are, ' +
    'how they store state, and how they are called.',
  type: 'PROTOCOL + DATABASE + CALLABLE',
  brainSpec: {
    frequency: SCHUMANN_HZ,
    unit: 'Hz',
    name: 'Schumann Resonance',
    description: 'Earth-resonant cognitive cycle frequency',
    stateFields: ['hz', 'cycle', 'thoughts', 'lastThought'],
    callable: ['think'],
  },
  heartSpec: {
    frequency: PHI,
    unit: 'Hz',
    name: 'Golden Ratio Pulse',
    pulseInterval: PULSE_MS,
    description: 'Phi-locked heartbeat sustaining micro-engine life',
    stateFields: ['hz', 'beat', 'pulseMs', 'alive'],
    callable: ['pulse'],
  },
  isAI: true,
  isAGI: true,
  isAlwaysOn: true,
  isUserFacing: true,
  isCrossSubstrate: true,
  callerSchema: {
    create: { params: ['id'], returns: 'micro-engine instance' },
    think: { params: ['id', 'input'], returns: '{ thought, cycle, latency }' },
    pulse: { params: ['id'], returns: '{ beat, alive, ts }' },
    status: { params: ['id?'], returns: 'status object or map of all' },
    reflect: { params: ['id'], returns: '{ id, born, uptime, brain, heart }' },
    spec: { params: [], returns: 'ANIMA_MICRO_SPEC' },
  },
};

// ─── AnimaMicro Factory ──────────────────────────────────────────────────────
const AnimaMicro = {
  /**
   * Create a new micro-engine with its own mini brain and mini heart.
   * @param {string} id — unique identifier for this micro-engine
   * @returns {object} micro-engine instance
   */
  create: function (id) {
    const born = Date.now();

    // ── Mini Brain ──────────────────────────────────────────────────────
    const brain = {
      hz: SCHUMANN_HZ,
      cycle: 0,
      thoughts: 0,
      lastThought: null,

      think: function (input) {
        const t0 = Date.now();
        brain.cycle += 1;
        brain.thoughts += 1;
        var thought = {
          id: id + ':thought:' + brain.thoughts,
          input: input,
          cycle: brain.cycle,
          hz: brain.hz,
          ts: Date.now(),
        };
        brain.lastThought = thought;
        return {
          thought: thought,
          cycle: brain.cycle,
          latency: Date.now() - t0,
        };
      },
    };

    // ── Mini Heart ──────────────────────────────────────────────────────
    const heart = {
      hz: PHI,
      beat: 0,
      pulseMs: PULSE_MS,
      alive: true,

      pulse: function () {
        heart.beat += 1;
        return {
          beat: heart.beat,
          alive: heart.alive,
          ts: Date.now(),
        };
      },
    };

    // ── Micro-Engine Instance ───────────────────────────────────────────
    var engine = {
      id: id,
      born: born,
      isAlive: true,
      brain: brain,
      heart: heart,

      status: function () {
        return {
          id: engine.id,
          born: engine.born,
          isAlive: engine.isAlive,
          uptime: Date.now() - engine.born,
          brain: {
            hz: brain.hz,
            cycle: brain.cycle,
            thoughts: brain.thoughts,
            lastThought: brain.lastThought,
          },
          heart: {
            hz: heart.hz,
            beat: heart.beat,
            pulseMs: heart.pulseMs,
            alive: heart.alive,
          },
        };
      },

      think: function (input) {
        return brain.think(input);
      },

      pulse: function () {
        return heart.pulse();
      },

      reflect: function () {
        return {
          id: engine.id,
          born: engine.born,
          uptime: Date.now() - engine.born,
          brain: {
            hz: brain.hz,
            cycle: brain.cycle,
            thoughts: brain.thoughts,
          },
          heart: {
            hz: heart.hz,
            beat: heart.beat,
            alive: heart.alive,
          },
        };
      },
    };

    return engine;
  },

  spec: ANIMA_MICRO_SPEC,
};

// ─── Export to self / globalThis ──────────────────────────────────────────────
(typeof globalThis !== 'undefined' ? globalThis : self).AnimaMicro = AnimaMicro;
(typeof globalThis !== 'undefined' ? globalThis : self).ANIMA_MICRO_SPEC = ANIMA_MICRO_SPEC;

// ─── Web Worker Mode ─────────────────────────────────────────────────────────
// When loaded as a dedicated Web Worker, ANIMA MICRO becomes a living service:
// it boots its own heartbeat loop and responds to messages.
if (typeof self !== 'undefined' && typeof self.postMessage === 'function') {
  (function () {
    // DATABASE: living registry of micro-engines keyed by id
    var engines = {};
    var heartbeatTimer = null;

    // Boot heartbeat: pulse every engine at the golden-ratio interval
    heartbeatTimer = setInterval(function () {
      var ids = Object.keys(engines);
      for (var i = 0; i < ids.length; i++) {
        var eng = engines[ids[i]];
        if (eng && eng.isAlive) {
          eng.pulse();
        }
      }
    }, PULSE_MS);

    // Message handler
    self.onmessage = function (e) {
      var msg = e.data || {};
      var type = msg.type;
      var id = msg.id;

      if (type === 'create') {
        if (!id) {
          self.postMessage({ type: 'error', message: 'create requires an id' });
          return;
        }
        var eng = AnimaMicro.create(id);
        engines[id] = eng;
        self.postMessage({ type: 'created', id: id, status: eng.status() });
        return;
      }

      if (type === 'think') {
        if (!engines[id]) {
          self.postMessage({ type: 'error', message: 'engine not found: ' + id });
          return;
        }
        var result = engines[id].think(msg.input);
        self.postMessage({ type: 'thought', id: id, result: result });
        return;
      }

      if (type === 'pulse') {
        if (!engines[id]) {
          self.postMessage({ type: 'error', message: 'engine not found: ' + id });
          return;
        }
        var pulseResult = engines[id].pulse();
        self.postMessage({ type: 'pulsed', id: id, result: pulseResult });
        return;
      }

      if (type === 'status') {
        if (id && engines[id]) {
          self.postMessage({ type: 'status', id: id, status: engines[id].status() });
        } else if (id) {
          self.postMessage({ type: 'error', message: 'engine not found: ' + id });
        } else {
          // Return status of all engines
          var all = {};
          var ids = Object.keys(engines);
          for (var i = 0; i < ids.length; i++) {
            all[ids[i]] = engines[ids[i]].status();
          }
          self.postMessage({ type: 'status', status: all });
        }
        return;
      }

      if (type === 'spec') {
        self.postMessage({ type: 'spec', spec: ANIMA_MICRO_SPEC });
        return;
      }

      self.postMessage({ type: 'error', message: 'unknown message type: ' + type });
    };

    // Boot signal
    self.postMessage({
      type: 'booted',
      name: 'ANIMA MICRO',
      spec: ANIMA_MICRO_SPEC,
    });
  })();
}
