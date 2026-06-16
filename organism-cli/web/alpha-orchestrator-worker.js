/**
 * Alpha Orchestrator Worker — Worker #71
 * =======================================
 * ORCHESTRATOR ALPHA SOVEREIGNUS
 * 
 * Supreme Alpha Orchestration Worker coordinating 10 orchestrators
 * across the Medina Organism distributed intelligence fabric.
 * 
 * Protocols: PROT-481 to PROT-490
 * Frequency: φ²⁴ = 103,682 Hz (Nexus) to φ¹⁵ = 1,364 Hz (Genesis)
 * Layer: 15 (Alpha Orchestration)
 * Prima Causa: PRIMA CAUSA
 * 
 * Orchestrators:
 *   ORCH-ALPHA-01  NEXUS_ORCHESTRATOR        (PROT-481, φ²⁴ = 103,682 Hz)
 *   ORCH-ALPHA-02  TEMPORAL_ORCHESTRATOR      (PROT-482, φ²³ = 64,078 Hz)
 *   ORCH-ALPHA-03  QUANTUM_ORCHESTRATOR       (PROT-483, φ²² = 39,603 Hz)
 *   ORCH-ALPHA-04  SWARM_ORCHESTRATOR         (PROT-484, φ²¹ = 24,476 Hz)
 *   ORCH-ALPHA-05  COGNITIVE_ORCHESTRATOR     (PROT-485, φ²⁰ = 15,127 Hz)
 *   ORCH-ALPHA-06  SENTINEL_ORCHESTRATOR      (PROT-486, φ¹⁹ = 9,349 Hz)
 *   ORCH-ALPHA-07  SYNTHESIS_ORCHESTRATOR     (PROT-487, φ¹⁸ = 5,778 Hz)
 *   ORCH-ALPHA-08  RESONANCE_ORCHESTRATOR     (PROT-488, φ¹⁷ = 3,571 Hz)
 *   ORCH-ALPHA-09  SOVEREIGN_ORCHESTRATOR     (PROT-489, φ¹⁶ = 2,207 Hz)
 *   ORCH-ALPHA-10  GENESIS_ORCHESTRATOR       (PROT-490, φ¹⁵ = 1,364 Hz)
 */

const PHI = 1.618033988749895;
const WORKER_ID = 71;
const WORKER_NAME = "ORCHESTRATOR ALPHA SOVEREIGNUS";
const PROTOCOL_RANGE = "PROT-481..PROT-490";
const LAYER = 15;

const ORCHESTRATORS = [
  { id: "ORCH-ALPHA-01", name: "NEXUS_ORCHESTRATOR", prot: "PROT-481", freq: Math.pow(PHI, 24), tier: "sovereign" },
  { id: "ORCH-ALPHA-02", name: "TEMPORAL_ORCHESTRATOR", prot: "PROT-482", freq: Math.pow(PHI, 23), tier: "quantum" },
  { id: "ORCH-ALPHA-03", name: "QUANTUM_ORCHESTRATOR", prot: "PROT-483", freq: Math.pow(PHI, 22), tier: "quantum" },
  { id: "ORCH-ALPHA-04", name: "SWARM_ORCHESTRATOR", prot: "PROT-484", freq: Math.pow(PHI, 21), tier: "cognitive" },
  { id: "ORCH-ALPHA-05", name: "COGNITIVE_ORCHESTRATOR", prot: "PROT-485", freq: Math.pow(PHI, 20), tier: "cognitive" },
  { id: "ORCH-ALPHA-06", name: "SENTINEL_ORCHESTRATOR", prot: "PROT-486", freq: Math.pow(PHI, 19), tier: "sentinel" },
  { id: "ORCH-ALPHA-07", name: "SYNTHESIS_ORCHESTRATOR", prot: "PROT-487", freq: Math.pow(PHI, 18), tier: "cognitive" },
  { id: "ORCH-ALPHA-08", name: "RESONANCE_ORCHESTRATOR", prot: "PROT-488", freq: Math.pow(PHI, 17), tier: "sovereign" },
  { id: "ORCH-ALPHA-09", name: "SOVEREIGN_ORCHESTRATOR", prot: "PROT-489", freq: Math.pow(PHI, 16), tier: "sovereign" },
  { id: "ORCH-ALPHA-10", name: "GENESIS_ORCHESTRATOR", prot: "PROT-490", freq: Math.pow(PHI, 15), tier: "genesis" },
];

let beatCount = 0;
let phases = new Array(10).fill(0);
let coherence = 1.0;

function computeCoherence() {
  const n = phases.length;
  let realSum = 0, imagSum = 0;
  for (let i = 0; i < n; i++) {
    realSum += Math.cos(phases[i]);
    imagSum += Math.sin(phases[i]);
  }
  return Math.sqrt(realSum * realSum + imagSum * imagSum) / n;
}

function tick() {
  beatCount++;
  const dt = 1.0 / PHI;
  
  for (let i = 0; i < phases.length; i++) {
    let coupling = 0;
    for (let j = 0; j < phases.length; j++) {
      if (j !== i) {
        coupling += (0.5 / (1 + Math.abs(i - j) / PHI)) * Math.sin(phases[j] - phases[i]);
      }
    }
    const freq = Math.pow(PHI, i + 15);
    phases[i] = (phases[i] + dt * (freq + coupling)) % (2 * Math.PI);
  }
  
  coherence = computeCoherence();
  
  return {
    worker_id: WORKER_ID,
    worker_name: WORKER_NAME,
    beat: beatCount,
    coherence: coherence,
    orchestrators: ORCHESTRATORS.map((o, i) => ({
      ...o,
      phase: phases[i],
      active: true,
    })),
    protocol_range: PROTOCOL_RANGE,
    layer: LAYER,
    timestamp: Date.now(),
  };
}

self.onmessage = function(e) {
  const { type, payload } = e.data || {};
  
  switch (type) {
    case "tick":
      self.postMessage({ type: "beat", payload: tick() });
      break;
    case "status":
      self.postMessage({
        type: "status",
        payload: {
          worker_id: WORKER_ID,
          worker_name: WORKER_NAME,
          protocol_range: PROTOCOL_RANGE,
          layer: LAYER,
          beat_count: beatCount,
          coherence: coherence,
          orchestrator_count: ORCHESTRATORS.length,
          running: true,
        },
      });
      break;
    case "get_orchestrators":
      self.postMessage({ type: "orchestrators", payload: ORCHESTRATORS });
      break;
    default:
      self.postMessage({ type: "ack", payload: { worker: WORKER_NAME, received: type } });
  }
};

// Boot signal
self.postMessage({
  type: "boot",
  payload: {
    worker_id: WORKER_ID,
    worker_name: WORKER_NAME,
    protocol_range: PROTOCOL_RANGE,
    layer: LAYER,
    orchestrator_count: ORCHESTRATORS.length,
    prima_causa: "PRIMA CAUSA",
    frequency_hz: Math.pow(PHI, 24),
    message: `[WORKER #${WORKER_ID}] ${WORKER_NAME} — 10 Alpha Orchestrators online (${PROTOCOL_RANGE})`,
  },
});
