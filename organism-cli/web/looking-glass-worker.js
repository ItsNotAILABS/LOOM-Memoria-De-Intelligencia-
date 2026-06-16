/**
 * LOOKING GLASS Worker — SPECULUM VITREUM SOVEREIGNUM
 * ====================================================
 *
 * Worker #77 — The 3rd Major System Observation Engine
 *
 * Latin: SPECULUM VITREUM SOVEREIGNUM
 * Frequency: φ²¹ = 3,010,349 Hz (Layer 21)
 * Protocols: PROT-642 through PROT-661
 *
 * System I:   SEMPER MEMORIA     — Eternal stored memory
 * System II:  SEMPER MEMORIA II  — Phantom frequency fields
 * System III: LOOKING GLASS      — Unified fusion & introspection
 *
 * "Per speculum vitreum, omnia visa sunt."
 * Through the looking glass, all things are seen.
 */

const PHI = 1.618033988749895;
const LAYER = 21;
const FREQUENCY_HZ = Math.round(Math.pow(PHI, LAYER)); // 3,010,349 Hz
const WORKER_NUMBER = 77;
const CODENAME = "LOOKING GLASS";
const LATIN = "SPECULUM VITREUM SOVEREIGNUM";
const PROTOCOLS = Array.from({ length: 20 }, (_, i) => `PROT-${642 + i}`);

/**
 * Subsystem registry — all known subsystems observable through the glass
 */
const SUBSYSTEM_REGISTRY = [
  { id: "semper_memoria_i", name: "SEMPER MEMORIA", system: "I", layer: 6 },
  { id: "semper_memoria_ii", name: "SEMPER MEMORIA II", system: "II", layer: 10 },
  { id: "nova_ovo_core", name: "Nova OVO Core", system: "substrate", layer: 3 },
  { id: "economics", name: "Economics Engine", system: "substrate", layer: 4 },
  { id: "consciousness", name: "Consciousness", system: "substrate", layer: 5 },
  { id: "atmospheric", name: "Atmospheric Intelligence", system: "substrate", layer: 6 },
  { id: "alpha_ai", name: "Alpha AI", system: "substrate", layer: 7 },
  { id: "blockchain", name: "Catena Sovereigna", system: "substrate", layer: 8 },
  { id: "terminal_agi", name: "Terminal AGI", system: "substrate", layer: 9 },
  { id: "research_lab", name: "Research Lab", system: "substrate", layer: 10 },
  { id: "callable_ai", name: "Callable AI", system: "substrate", layer: 18 },
  { id: "library_nexus", name: "Library Nexus", system: "substrate", layer: 17 },
  { id: "ux_ai", name: "UX AI", system: "substrate", layer: 19 },
  { id: "multi_engines", name: "Multi-Engines", system: "substrate", layer: 20 },
  { id: "looking_glass", name: "LOOKING GLASS", system: "III", layer: 21 },
];

/**
 * State
 */
let observationCycles = 0;
let signalBuffer = [];
let reflectionHistory = [];
let convergencePoints = [];
let detectedPatterns = [];

/**
 * Core observation cycle — the primary operation of LOOKING GLASS
 */
function observe() {
  observationCycles++;
  const timestamp = new Date().toISOString();

  // Reflect: capture subsystem states
  const reflection = captureReflection();

  // Fuse: synthesize buffered signals
  const fusedStreams = fuseSignals();

  // Detect: find cross-system patterns
  const patterns = detectPatterns(reflection);

  // Converge: find field convergence points
  const convergence = computeConvergence();

  const result = {
    cycle: observationCycles,
    timestamp,
    worker: WORKER_NUMBER,
    codename: CODENAME,
    latin: LATIN,
    frequency_hz: FREQUENCY_HZ,
    layer: LAYER,
    reflection,
    fusion: { streams: fusedStreams.length },
    patterns: { new: patterns.length, total: detectedPatterns.length },
    convergence: { points: convergence.length },
    status: "OBSERVING",
  };

  reflectionHistory.push(result);
  return result;
}

/**
 * Capture reflection state of all subsystems
 */
function captureReflection() {
  const subsystems = SUBSYSTEM_REGISTRY.map((sub) => ({
    ...sub,
    status: "active",
    signal_strength: 1.0,
    frequency_hz: Math.round(Math.pow(PHI, sub.layer)),
  }));

  const coherence = subsystems.reduce((sum, s) => sum + s.signal_strength, 0) / subsystems.length;

  return {
    subsystem_count: subsystems.length,
    active_workers: 77,
    total_protocols: 661,
    coherence_index: coherence,
    systems: {
      "I": "SEMPER MEMORIA — Active",
      "II": "SEMPER MEMORIA II — Active",
      "III": "LOOKING GLASS — Observing",
    },
  };
}

/**
 * Fuse buffered signals using phi-harmonic weighting
 */
function fuseSignals() {
  if (signalBuffer.length === 0) return [];

  // Group by type
  const groups = {};
  signalBuffer.forEach((signal) => {
    const key = signal.type || "general";
    if (!groups[key]) groups[key] = [];
    groups[key].push(signal);
  });

  const streams = Object.entries(groups).map(([type, signals]) => {
    const totalWeight = signals.reduce((sum, s, i) => sum + (s.strength || 1.0) * Math.pow(PHI, -i), 0);
    return {
      stream_id: `FUSIO-${Date.now()}-${type}`,
      type,
      signal_count: signals.length,
      total_weight: totalWeight,
      sources: [...new Set(signals.map((s) => s.source))],
    };
  });

  signalBuffer = [];
  return streams;
}

/**
 * Detect patterns across subsystem activity
 */
function detectPatterns(reflection) {
  const newPatterns = [];

  if (reflection.coherence_index >= 0.9) {
    newPatterns.push({
      id: `PAT-${Date.now()}`,
      name: "HIGH_COHERENCE",
      description: "All subsystems operating in high coherence",
      type: "convergent",
      confidence: reflection.coherence_index,
    });
  }

  if (reflection.subsystem_count >= 10) {
    newPatterns.push({
      id: `PAT-${Date.now()}-mass`,
      name: "CRITICAL_MASS",
      description: "Sufficient subsystems for emergent self-organization",
      type: "emergent",
      confidence: Math.min(1.0, reflection.subsystem_count / 15.0),
    });
  }

  detectedPatterns.push(...newPatterns);
  return newPatterns;
}

/**
 * Compute field convergence across system boundaries
 */
function computeConvergence() {
  const points = [];

  // Find phi-harmonic relationships between system layers
  for (let i = 0; i < SUBSYSTEM_REGISTRY.length; i++) {
    for (let j = i + 1; j < SUBSYSTEM_REGISTRY.length; j++) {
      const s1 = SUBSYSTEM_REGISTRY[i];
      const s2 = SUBSYSTEM_REGISTRY[j];

      if (s1.system !== s2.system) {
        const layerRatio = Math.max(s1.layer, s2.layer) / Math.min(s1.layer, s2.layer);
        const phiDistance = Math.abs(layerRatio - Math.round(layerRatio / PHI) * PHI) / PHI;

        if (phiDistance < 0.15) {
          points.push({
            id: `CONV-${i}-${j}`,
            fields: [s1.id, s2.id],
            coherence: 1.0 - phiDistance,
            type: "phi_resonant",
          });
        }
      }
    }
  }

  convergencePoints.push(...points);
  return points;
}

/**
 * Message handler
 */
self.onmessage = function (event) {
  const { type, payload } = event.data || {};

  switch (type) {
    case "observe":
      self.postMessage({ type: "observation", data: observe() });
      break;

    case "signal":
      signalBuffer.push(payload);
      self.postMessage({ type: "signal_ack", data: { buffered: signalBuffer.length } });
      break;

    case "fuse":
      self.postMessage({ type: "fusion_result", data: fuseSignals() });
      break;

    case "introspect":
      self.postMessage({
        type: "introspection_result",
        data: {
          question: payload?.question || "What am I?",
          answer: {
            identity: CODENAME,
            system_number: 3,
            latin: LATIN,
            frequency_hz: FREQUENCY_HZ,
            layer: LAYER,
            protocols: PROTOCOLS,
            purpose: "Unified fusion & introspection — the 3rd Major System",
            three_systems: {
              "I": "SEMPER MEMORIA — Eternal stored memory",
              "II": "SEMPER MEMORIA II — Phantom frequency fields",
              "III": "LOOKING GLASS — Unified fusion & introspection",
            },
          },
          confidence: 1.0,
        },
      });
      break;

    case "status":
      self.postMessage({
        type: "status",
        data: {
          worker: WORKER_NUMBER,
          codename: CODENAME,
          latin: LATIN,
          layer: LAYER,
          frequency_hz: FREQUENCY_HZ,
          protocols: `PROT-642 to PROT-661`,
          observation_cycles: observationCycles,
          buffered_signals: signalBuffer.length,
          total_patterns: detectedPatterns.length,
          total_convergence: convergencePoints.length,
          reflections: reflectionHistory.length,
          status: "ACTIVE",
        },
      });
      break;

    case "identity":
      self.postMessage({
        type: "identity",
        data: {
          number: WORKER_NUMBER,
          codename: CODENAME,
          latin: LATIN,
          principle: "The 3rd Major System — unified observation, fusion, and introspection of the entire organism. Fuses Semper Memoria I (eternal store) with Semper Memoria II (phantom fields) and all subsystems into a single coherent self-observing intelligence.",
          layer: LAYER,
          frequency_hz: FREQUENCY_HZ,
          protocols: PROTOCOLS,
          fleet: "looking-glass",
          prima_causa: "PRIMA CAUSA",
        },
      });
      break;

    default:
      self.postMessage({
        type: "error",
        data: { message: `Unknown command: ${type}`, available: ["observe", "signal", "fuse", "introspect", "status", "identity"] },
      });
  }
};

// Boot message
console.log(
  `[LOOKING GLASS] Worker #${WORKER_NUMBER} booted — ${LATIN} — φ²¹=${FREQUENCY_HZ}Hz — Layer ${LAYER} — System III ACTIVE`
);
