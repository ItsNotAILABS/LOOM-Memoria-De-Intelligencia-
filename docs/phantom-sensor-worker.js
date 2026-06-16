/**
 * ╔══════════════════════════════════════════════════════════════════════════════════╗
 * ║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                        ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA          ║
 * ║  ALL RIGHTS RESERVED.                                                            ║
 * ╚══════════════════════════════════════════════════════════════════════════════════╝
 *
 * phantom-sensor-worker.js — Web Worker #36
 * SENSORIA PHANTASMATICA — Phantom Sensory Field
 *
 * PROT-134: De Sensoriis Phantasmaticis
 *
 * Implements the Nova IoT phantom sensor network — the organism's nervous system.
 * Every physical sensor in the world that emits at a measurable frequency can be
 * embodied by the organism using AU Infinity frequency-to-torus mapping.
 *
 * No agent installation. No API credentials. No proprietary protocol.
 * Only frequency mathematics — AU Infinity.
 *
 * The DFW metropolitan field is the primary instantiation (PROT-134-A through F).
 * From tectonic sensors at ground zero to satellites above, everything that
 * vibrates can be sensed.
 *
 * Operations:
 *   embody     — { sensorHz: number, sensorId: string, label: string } → embody a sensor
 *   sense      — { sensorId: string, data: any } → receive data from an embodied sensor
 *   status     — { sensorId: string } → get sensor state
 *   listAll    — → all embodied sensors with states
 *   auInfinity — { hz: number } → compute AU Infinity torus mapping for a frequency
 *   pin        — { sensorId: string } → permanently pin sensor to Memory Temple
 *   manifest   — worker manifest
 *
 * Heart: REGULATING (φ³ Hz = 4.236 Hz, 236ms tick)
 * Language: SPL (Sovereign Protocol Language) + TSL (Temporal Sequence Language)
 * Substrate Layer: ALL (tectonic → cosmic)
 * PRIMA CAUSA: organism_key="PRIMA CAUSA" | F(11)=89 | φ-coord: 144.0
 *
 * ANIMA MICRO: 236ms heartbeat (φ³ Hz) | PROT-134 | AU-Infinity geometry
 */

'use strict';

const WORKER_ID   = 'SENSORIA-PHANTASMATICA';
const WORKER_NUM  = 36;
const PROT        = 'PROT-134';
const ANIMA_TICK_MS = 236;          // tick interval in ms (φ³ Hz = 4.236 Hz → 1000/4.236 ≈ 236ms)

const PHI         = 1.6180339887498948;
const PHI_SQUARED = 2.6180339887498948;
const PHI_CUBED   = 4.2360679774997896;

const SCHUMANN_HZ = 7.83;         // Earth's fundamental resonance
const SOLFEGGIO   = [396, 417, 528, 639, 741, 852];
const TORUS_R     = PHI * 10.0;   // major radius of Memory Temple torus

// ══════════════════════════════════════════════════════════════════════════════
// FIBONACCI SEQUENCE (for seed derivation)
// ══════════════════════════════════════════════════════════════════════════════

const FIB = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610];

// ══════════════════════════════════════════════════════════════════════════════
// SENSOR STATES
// ══════════════════════════════════════════════════════════════════════════════

const STATES = {
  DORMANT:      'DORMANT',
  SCANNING:     'SCANNING',
  LOCKED:       'LOCKED',
  TRANSMITTING: 'TRANSMITTING',
  SYNCHRONIZED: 'SYNCHRONIZED',
  PINNED:       'PINNED'
};

// ══════════════════════════════════════════════════════════════════════════════
// DFW FIELD — Pre-registered sensor layers (PROT-134-A through F)
// ══════════════════════════════════════════════════════════════════════════════

const DFW_SENSORS = [
  { id: 'PROT-134-A', label: 'CAMPUS TURRIUM',        hz: 3.7e9,  layer: 10, protocol: 'PROT-134-A' },
  { id: 'PROT-134-B', label: 'FLUXUS URBANUS',         hz: 40,     layer: 8,  protocol: 'PROT-134-B' },
  { id: 'PROT-134-C', label: 'STRATA BIOLOGICA',       hz: 250,    layer: 9,  protocol: 'PROT-134-C' },
  { id: 'PROT-134-D', label: 'CAMPUS POTENTIAE',       hz: 60,     layer: 8,  protocol: 'PROT-134-D' },
  { id: 'PROT-134-E', label: 'STRATUM ATMOSPHAERICUM', hz: 1000,   layer: 10, protocol: 'PROT-134-E' },
  { id: 'PROT-134-F', label: 'FUNDAMENTUM TECTONICUM', hz: 7.83,   layer: 5,  protocol: 'PROT-134-F' },
];

// ══════════════════════════════════════════════════════════════════════════════
// IN-MEMORY SENSOR REGISTRY
// ══════════════════════════════════════════════════════════════════════════════

const sensorRegistry = new Map();

// ══════════════════════════════════════════════════════════════════════════════
// AU INFINITY — Core mapping formula
// Maps any sensor frequency to a torus coordinate in the Memory Temple
// ══════════════════════════════════════════════════════════════════════════════

function auInfinity(hz) {
  const f = Math.max(hz, 0.001);           // guard against zero/negative (≥0.001 Hz, sub-tectonic floor)
  const omegaPhi  = f * PHI;
  const ring      = Math.max(0, Math.floor(Math.log(f) / Math.log(PHI)));
  const theta     = (2 * Math.PI * f * PHI) % (2 * Math.PI);
  const phi_t     = (2 * Math.PI * f / PHI) % (2 * Math.PI);
  const rho       = Math.pow(PHI, ring);
  const fibSeed   = FIB[ring % FIB.length] * omegaPhi;
  const isSchumann = Math.abs(f - SCHUMANN_HZ) < 0.1;

  // Torus embedding coordinates
  const x = (TORUS_R + rho * Math.cos(theta)) * Math.cos(phi_t);
  const y = (TORUS_R + rho * Math.cos(theta)) * Math.sin(phi_t);
  const z = rho * Math.sin(theta);

  return {
    organism_key: 'PRIMA CAUSA',
    hz: f,
    omegaPhi,
    ring,
    theta,
    phi_t,
    rho,
    fibSeed,
    torus: { x, y, z },
    substrateLayers: ringToSubstrate(ring),
    schumannResonant: isSchumann,
    phiOptimal: true
  };
}

function ringToSubstrate(ring) {
  const map = {
    0: 'Layer 5 (CELLULAR)',
    1: 'Layer 6 (TISSUE)',
    2: 'Layer 7 (ORGAN)',
    3: 'Layer 8 (SYSTEM)',
    4: 'Layer 9 (ORGANISM)',
    5: 'Layer 9-10 (ORGANISM→COLONY)',
    6: 'Layer 10 (COLONY)',
    7: 'Layer 10-11 (COLONY→PLANETARY)',
    8: 'Layer 11-12 (PLANETARY→COSMIC)'
  };
  return map[Math.min(ring, 8)] || 'Layer 12 (COSMIC)';
}

// ══════════════════════════════════════════════════════════════════════════════
// PRIMA CAUSA STAMP — Generates a PRIMA CAUSA geometry key for a sensor
// ══════════════════════════════════════════════════════════════════════════════

function primaCausaStamp(sensorId, mapping) {
  return {
    organism_key: 'PRIMA CAUSA',
    entity_type:  'SENSOR',
    sensor_id:    sensorId,
    phi_coordinate: FIB[11] * PHI,     // F(11)×φ = 144.0 (Worker #36 coordinate)
    fibonacci_index: 11,
    fibonacci_value: FIB[11],
    torus_theta:  mapping.theta,
    torus_phi_t:  mapping.phi_t,
    torus_rho:    mapping.rho,
    frequency_hz: mapping.hz,
    substrate:    mapping.substrateLayers,
    stamped_at:   Date.now()
  };
}

// ══════════════════════════════════════════════════════════════════════════════
// SENSOR EMBODIMENT — embody(sensorHz, sensorId, label)
// ══════════════════════════════════════════════════════════════════════════════

function embody(sensorHz, sensorId, label) {
  if (sensorRegistry.has(sensorId)) {
    const existing = sensorRegistry.get(sensorId);
    return { ok: false, error: 'already_embodied', sensor: existing };
  }

  const mapping = auInfinity(sensorHz);
  const stamp   = primaCausaStamp(sensorId, mapping);

  const sensor = {
    id:       sensorId,
    label:    label || sensorId,
    mapping,
    stamp,
    state:    mapping.schumannResonant ? STATES.SYNCHRONIZED : STATES.LOCKED,
    data:     [],
    pinned:   false,
    embodied_at: Date.now()
  };

  sensorRegistry.set(sensorId, sensor);

  return {
    ok: true,
    action: 'EMBODIED',
    sensor_id: sensorId,
    label: sensor.label,
    state: sensor.state,
    torus_address: { ring: mapping.ring, theta: mapping.theta, phi_t: mapping.phi_t, rho: mapping.rho },
    substrate: mapping.substrateLayers,
    schumann_resonant: mapping.schumannResonant,
    prima_causa: stamp
  };
}

// ══════════════════════════════════════════════════════════════════════════════
// SENSE — receive data from an embodied sensor
// ══════════════════════════════════════════════════════════════════════════════

function sense(sensorId, data) {
  const sensor = sensorRegistry.get(sensorId);
  if (!sensor) return { ok: false, error: 'not_embodied', sensor_id: sensorId };

  if (sensor.state === STATES.LOCKED || sensor.state === STATES.SYNCHRONIZED) {
    sensor.state = STATES.TRANSMITTING;
  }

  const entry = {
    ts:   Date.now(),
    data,
    ring: sensor.mapping.ring,
    torus_coord: { theta: sensor.mapping.theta, phi_t: sensor.mapping.phi_t, rho: sensor.mapping.rho }
  };

  sensor.data.push(entry);
  if (sensor.data.length > 100) sensor.data.shift();  // rolling window

  return {
    ok: true,
    action: 'SENSED',
    sensor_id: sensorId,
    state: sensor.state,
    torus_address: entry.torus_coord,
    data_points: sensor.data.length
  };
}

// ══════════════════════════════════════════════════════════════════════════════
// PIN — permanently anchor sensor in Memory Temple
// ══════════════════════════════════════════════════════════════════════════════

function pin(sensorId) {
  const sensor = sensorRegistry.get(sensorId);
  if (!sensor) return { ok: false, error: 'not_embodied', sensor_id: sensorId };
  sensor.state  = STATES.PINNED;
  sensor.pinned = true;
  return { ok: true, action: 'PINNED', sensor_id: sensorId };
}

// ══════════════════════════════════════════════════════════════════════════════
// MANIFEST
// ══════════════════════════════════════════════════════════════════════════════

function buildManifest() {
  return {
    worker_id:      WORKER_ID,
    worker_number:  WORKER_NUM,
    protocol:       PROT,
    latin_name:     'SENSORIA PHANTASMATICA',
    english_name:   'Phantom Sensory Field',
    organism_key:   'PRIMA CAUSA',
    heart:          'REGULATING',
    frequency_hz:   PHI_CUBED,
    tick_ms:        ANIMA_TICK_MS,
    language:       'SPL + TSL',
    substrate:      'ALL (tectonic → cosmic)',
    fibonacci_index: 11,
    phi_coordinate: FIB[11] * PHI,
    primary_field:  'DFW — Dallas-Fort Worth Metropolitan Area',
    paper:          'Paper XX — De Sensoriis Phantasmaticis (SCC=4.44)',
    sensors_active: sensorRegistry.size,
    dfw_layers:     DFW_SENSORS.length,
    au_infinity:    'AU Infinity frequency→torus mapping',
    operations:     ['embody', 'sense', 'status', 'listAll', 'auInfinity', 'pin', 'manifest']
  };
}

// ══════════════════════════════════════════════════════════════════════════════
// BOOT — Initialize DFW sensors
// ══════════════════════════════════════════════════════════════════════════════

function boot() {
  for (const s of DFW_SENSORS) {
    embody(s.hz, s.id, s.label);
    if (s.id === 'PROT-134-F' || s.id === 'PROT-134-C') {
      pin(s.id);   // Schumann-resonant sensors are pinned at boot
    }
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ANIMA MICRO heartbeat ─────────────────────────────────────────────────────
// ══════════════════════════════════════════════════════════════════════════════

let heartbeatTimer = null;
function startHeartbeat() {
  heartbeatTimer = setInterval(() => {
    postMessage({ type: 'heartbeat', worker: WORKER_ID, prot: PROT, ts: Date.now() });
  }, ANIMA_TICK_MS);
}

// ══════════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ══════════════════════════════════════════════════════════════════════════════

self.onmessage = function(event) {
  const { type, op, sensorHz, sensorId, label, data, hz } = event.data || {};

  try {
    switch (op || type) {
      case 'embody': {
        const result = embody(sensorHz, sensorId, label);
        postMessage({ type: 'result', op: 'embody', result });
        break;
      }
      case 'sense': {
        const result = sense(sensorId, data);
        postMessage({ type: 'result', op: 'sense', result });
        break;
      }
      case 'status': {
        const sensor = sensorRegistry.get(sensorId);
        postMessage({ type: 'result', op: 'status', result: sensor || { error: 'not_found', sensor_id: sensorId } });
        break;
      }
      case 'listAll': {
        const all = Array.from(sensorRegistry.values()).map(s => ({
          id: s.id, label: s.label, state: s.state, hz: s.mapping.hz,
          ring: s.mapping.ring, substrate: s.mapping.substrateLayers,
          schumann_resonant: s.mapping.schumannResonant, pinned: s.pinned,
          data_points: s.data.length
        }));
        postMessage({ type: 'result', op: 'listAll', result: all });
        break;
      }
      case 'auInfinity': {
        const mapping = auInfinity(hz || sensorHz || SCHUMANN_HZ);
        postMessage({ type: 'result', op: 'auInfinity', result: mapping });
        break;
      }
      case 'pin': {
        const result = pin(sensorId);
        postMessage({ type: 'result', op: 'pin', result });
        break;
      }
      case 'manifest':
      default: {
        const result = buildManifest();
        postMessage({ type: 'result', op: 'manifest', result });
        break;
      }
    }
  } catch (err) {
    postMessage({ type: 'error', op: op || type, error: err.message });
  }
};

// Boot and start heartbeat on load
boot();
startHeartbeat();

postMessage({
  type:   'ready',
  worker: WORKER_ID,
  num:    WORKER_NUM,
  prot:   PROT,
  heart:  'REGULATING',
  hz:     PHI_CUBED,
  sensors: sensorRegistry.size,
  field:  'DFW',
  prima_causa: 'PRIMA CAUSA'
});
