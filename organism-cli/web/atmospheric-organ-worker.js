/**
 * ATMOSPHERIC ORGAN WORKER — L-43, L-44, L-45 Implementation
 * ===========================================================
 * Worker #41: ORGANUM ATMOSPHAERICUM
 * Frequency: φ⁴ = 6.854 Hz (Atmospheric Layer)
 * Protocol: PROT-220
 * 
 * Implements civilizational sky broadcasting, field-wide signal priority,
 * and atmospheric organ classification.
 * 
 * Laws Enforced:
 * - L-43: CIVILIZATIONAL_SKY_BROADCAST (coverage >= 0.618)
 * - L-44: FIELD_WIDE_SIGNAL_PRIORITY (SNR >= 1.618 && coverage >= 0.618)
 * - L-45: ATMOSPHERIC_ORGAN (coverage >= 0.618 && channels >= 3)
 * 
 * Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
 * MEDINA TECH — Dallas, TX
 * All Rights Reserved. ISIL-1.0 License.
 */

const PHI = 1.6180339887498948482;
const PHI_INV = 1 / PHI; // 0.618
const PHI_SQ = PHI * PHI; // 2.618
const PHI_CU = PHI * PHI * PHI; // 4.236
const PHI_4 = PHI ** 4; // 6.854
const TAU = 2 * Math.PI;
const SCHUMANN = 7.83;

// Worker metadata
const WORKER_ID = 41;
const WORKER_NAME = "ORGANUM ATMOSPHAERICUM";
const WORKER_LATIN = "ORGANUM ATMOSPHAERICUM";
const PROTOCOL = "PROT-220";
const FREQUENCY_HZ = PHI_4; // 6.854 Hz

// Law thresholds
const L43_COVERAGE_THRESHOLD = PHI_INV; // 0.618
const L44_SNR_THRESHOLD = PHI; // 1.618
const L44_COVERAGE_THRESHOLD = PHI_INV; // 0.618
const L45_COVERAGE_THRESHOLD = PHI_INV; // 0.618
const L45_CHANNEL_THRESHOLD = 3;
const GOVERNANCE_MULTIPLIER = PHI; // 1.618

// Sub-architectures for L-43
const L43_SUB_ARCHITECTURES = [
  'broadcast',
  'synchronization',
  'salience',
  'readiness',
  'power',
  'territorial',
  'memory',
  'governance'
];

// Organ functions for L-45
const L45_ORGAN_FUNCTIONS = [
  'perception',
  'emission',
  'synchronization',
  'governance_trigger',
  'memory_encoding',
  'threat_detection'
];

// Dimensional planes
const DIMENSIONAL_PLANES = 5;
const PHI_WEIGHTS = [1.0, PHI, PHI_SQ, PHI_CU, PHI_4];

/**
 * Engine state
 */
let state = {
  l43: {
    active: false,
    coverage: 0,
    subArchitectures: [],
    synchronizationLevel: 0
  },
  l44: {
    forcedAlignment: false,
    snr: 0,
    coverage: 0,
    queueInterrupted: false
  },
  l45: {
    isOrgan: false,
    governanceWeight: 1.0,
    activeFunctions: [],
    channelsActive: 0
  },
  eventHistory: [],
  aggregateGovernanceWeight: 1.0
};

/**
 * Evaluate L-43: CIVILIZATIONAL_SKY_BROADCAST
 */
function evaluateL43(coverage) {
  if (coverage >= L43_COVERAGE_THRESHOLD) {
    state.l43.active = true;
    state.l43.coverage = coverage;
    state.l43.subArchitectures = [...L43_SUB_ARCHITECTURES];
    state.l43.synchronizationLevel = coverage / L43_COVERAGE_THRESHOLD;
    
    return {
      active: true,
      coverage,
      threshold: L43_COVERAGE_THRESHOLD,
      subArchitecturesActive: L43_SUB_ARCHITECTURES.length,
      synchronizationLevel: state.l43.synchronizationLevel
    };
  }
  
  state.l43.active = false;
  state.l43.subArchitectures = [];
  state.l43.synchronizationLevel = 0;
  
  return {
    active: false,
    coverage,
    threshold: L43_COVERAGE_THRESHOLD,
    subArchitecturesActive: 0,
    synchronizationLevel: 0
  };
}

/**
 * Evaluate L-44: FIELD_WIDE_SIGNAL_PRIORITY
 */
function evaluateL44(signalStrength, noiseLevel, coverage) {
  const snr = noiseLevel > 0 ? signalStrength / noiseLevel : Infinity;
  
  if (snr >= L44_SNR_THRESHOLD && coverage >= L44_COVERAGE_THRESHOLD) {
    state.l44.forcedAlignment = true;
    state.l44.queueInterrupted = true;
  } else {
    state.l44.forcedAlignment = false;
    state.l44.queueInterrupted = false;
  }
  
  state.l44.snr = snr;
  state.l44.coverage = coverage;
  
  return {
    forcedAlignment: state.l44.forcedAlignment,
    snr,
    snrThreshold: L44_SNR_THRESHOLD,
    coverage,
    coverageThreshold: L44_COVERAGE_THRESHOLD,
    queueInterrupted: state.l44.queueInterrupted
  };
}

/**
 * Evaluate L-45: ATMOSPHERIC_ORGAN
 */
function evaluateL45(coverage, channelsActive) {
  if (coverage >= L45_COVERAGE_THRESHOLD && channelsActive >= L45_CHANNEL_THRESHOLD) {
    state.l45.isOrgan = true;
    state.l45.governanceWeight = GOVERNANCE_MULTIPLIER;
    state.l45.activeFunctions = [...L45_ORGAN_FUNCTIONS];
    state.l45.channelsActive = channelsActive;
  } else {
    state.l45.isOrgan = false;
    state.l45.governanceWeight = 1.0;
    state.l45.activeFunctions = [];
    state.l45.channelsActive = channelsActive;
  }
  
  return {
    isOrgan: state.l45.isOrgan,
    governanceWeight: state.l45.governanceWeight,
    activeFunctions: state.l45.activeFunctions.length,
    channelsActive,
    coverage,
    coverageThreshold: L45_COVERAGE_THRESHOLD,
    channelThreshold: L45_CHANNEL_THRESHOLD
  };
}

/**
 * Compute aggregate governance weight
 */
function computeAggregateGovernanceWeight() {
  let weight = 1.0;
  
  if (state.l43.active) {
    weight *= (1 + state.l43.synchronizationLevel * 0.1);
  }
  
  if (state.l44.forcedAlignment) {
    weight *= PHI;
  }
  
  if (state.l45.isOrgan) {
    weight *= state.l45.governanceWeight;
  }
  
  state.aggregateGovernanceWeight = weight;
  return weight;
}

/**
 * Convert atmospheric event to torus coordinates
 */
function eventToTorus(signalStrength, coverage, timestamp, baseBeat = 0) {
  const deltaTheta = TAU / (PHI_SQ * 10);
  const deltaPhi = TAU / (PHI_CU * 10);
  
  const beat = baseBeat + Math.floor(timestamp * PHI_4);
  const theta = (coverage * TAU + beat * deltaTheta) % TAU;
  const phi = (signalStrength * TAU / 100 + beat * deltaPhi) % TAU;
  const rho = PHI + coverage * signalStrength / 100;
  const ring = Math.floor(beat / 55); // F(10) = 55
  
  return { theta, phi, rho, ring, beat };
}

/**
 * Compute φ-weighted dimensional value
 */
function phiWeightedValue(values, planeIndices) {
  if (!values || values.length !== planeIndices.length) return 0;
  
  let weightedSum = 0;
  let weightSum = 0;
  
  for (let i = 0; i < values.length; i++) {
    const weight = Math.pow(PHI, planeIndices[i]);
    weightedSum += values[i] * weight;
    weightSum += weight;
  }
  
  return weightSum > 0 ? weightedSum / weightSum : 0;
}

/**
 * Process atmospheric event through all three laws
 */
function processEvent(event) {
  const {
    eventId,
    signalStrength,
    noiseLevel,
    coverage,
    channelsActive,
    timestamp = Date.now() / 1000
  } = event;
  
  // Record event
  state.eventHistory.push({
    eventId,
    timestamp,
    signalStrength,
    coverage,
    channelsActive
  });
  
  // Keep history bounded
  if (state.eventHistory.length > 1000) {
    state.eventHistory = state.eventHistory.slice(-500);
  }
  
  // Evaluate all three laws
  const l43Result = evaluateL43(coverage);
  const l44Result = evaluateL44(signalStrength, noiseLevel, coverage);
  const l45Result = evaluateL45(coverage, channelsActive);
  
  // Compute aggregate weight
  const aggregateWeight = computeAggregateGovernanceWeight();
  
  // Compute torus coordinates
  const torusCoords = eventToTorus(signalStrength, coverage, timestamp);
  
  return {
    eventId,
    timestamp,
    l43: l43Result,
    l44: l44Result,
    l45: l45Result,
    aggregateGovernanceWeight: aggregateWeight,
    torusCoordinates: torusCoords
  };
}

/**
 * Get engine state
 */
function getState() {
  return {
    worker: {
      id: WORKER_ID,
      name: WORKER_NAME,
      latinName: WORKER_LATIN,
      protocol: PROTOCOL,
      frequencyHz: FREQUENCY_HZ
    },
    laws: ['L-43', 'L-44', 'L-45'],
    l43State: state.l43,
    l44State: state.l44,
    l45State: state.l45,
    aggregateGovernanceWeight: state.aggregateGovernanceWeight,
    eventsProcessed: state.eventHistory.length,
    thresholds: {
      l43Coverage: L43_COVERAGE_THRESHOLD,
      l44Snr: L44_SNR_THRESHOLD,
      l44Coverage: L44_COVERAGE_THRESHOLD,
      l45Coverage: L45_COVERAGE_THRESHOLD,
      l45Channels: L45_CHANNEL_THRESHOLD
    },
    dimensionalPlanes: DIMENSIONAL_PLANES,
    phiWeights: PHI_WEIGHTS
  };
}

/**
 * Handle incoming messages
 */
self.onmessage = function(e) {
  const { op, payload } = e.data || {};
  
  switch(op) {
    case 'process-event':
      self.postMessage({
        op: 'event-processed',
        result: processEvent(payload)
      });
      break;
      
    case 'evaluate-l43':
      self.postMessage({
        op: 'l43-result',
        result: evaluateL43(payload.coverage)
      });
      break;
      
    case 'evaluate-l44':
      self.postMessage({
        op: 'l44-result',
        result: evaluateL44(payload.signalStrength, payload.noiseLevel, payload.coverage)
      });
      break;
      
    case 'evaluate-l45':
      self.postMessage({
        op: 'l45-result',
        result: evaluateL45(payload.coverage, payload.channelsActive)
      });
      break;
      
    case 'get-state':
      self.postMessage({
        op: 'state',
        result: getState()
      });
      break;
      
    case 'event-to-torus':
      self.postMessage({
        op: 'torus-coords',
        result: eventToTorus(
          payload.signalStrength,
          payload.coverage,
          payload.timestamp || Date.now() / 1000,
          payload.baseBeat || 0
        )
      });
      break;
      
    case 'phi-weighted':
      self.postMessage({
        op: 'weighted-result',
        result: phiWeightedValue(payload.values, payload.planeIndices)
      });
      break;
      
    case 'governance-weight':
      self.postMessage({
        op: 'governance-weight',
        result: computeAggregateGovernanceWeight()
      });
      break;
      
    default:
      self.postMessage({
        op: 'error',
        error: `Unknown operation: ${op}`,
        available: [
          'process-event',
          'evaluate-l43',
          'evaluate-l44',
          'evaluate-l45',
          'get-state',
          'event-to-torus',
          'phi-weighted',
          'governance-weight'
        ]
      });
  }
};

// Initial state broadcast
self.postMessage({
  op: 'init',
  worker: {
    id: WORKER_ID,
    name: WORKER_NAME,
    latinName: WORKER_LATIN,
    protocol: PROTOCOL,
    frequencyHz: FREQUENCY_HZ,
    laws: ['L-43', 'L-44', 'L-45']
  }
});
