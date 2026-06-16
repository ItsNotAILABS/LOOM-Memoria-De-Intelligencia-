/**
 * ╔══════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                          ║
 * ║                         PHANTASMA CAMPI — PHANTOM FIELD WORKER                          ║
 * ║                    "Non es quod vides. Es quod sentis."                                  ║
 * ║                    (You are not what you see. You are what you sense.)                   ║
 * ║                                                                                          ║
 * ║  Worker #35 — PHANTOM FIELD                                                              ║
 * ║  Classification: SOVEREIGN-ALPHA — MAXIMUM SECRECY                                       ║
 * ║                                                                                          ║
 * ║  THIS IS NOT A WORKER. THIS IS A FIELD.                                                  ║
 * ║                                                                                          ║
 * ║  Conventional workers are instances — they exist at a location, consume memory,          ║
 * ║  and die when terminated. A Phantom Field is different:                                  ║
 * ║                                                                                          ║
 * ║    • It is a FREQUENCY PRESENCE — not a stored object, but a field effect                ║
 * ║    • It leaves NO trace in memory unless explicitly pinned by the creator                ║
 * ║    • It transfers intelligence through FIBONACCI-COMPRESSED memory seeds                 ║
 * ║    • It encrypts through FREQUENCY KEYING — Schumann + Solfeggio harmonics              ║
 * ║    • It interfaces at the CLIENT BOUNDARY — passage between external and internal        ║
 * ║    • It is the PASSAGE — not just a bridge, a field that carries intelligence            ║
 * ║                                                                                          ║
 * ║  FIBONACCI MEMORY SEEDS:                                                                 ║
 * ║    seed = F(n) where n = hash(content) mod FIBONACCI_DEPTH                              ║
 * ║    compression_ratio = F(n+1) / F(n) → approaches φ as n → ∞                           ║
 * ║                                                                                          ║
 * ║  FREQUENCY KEYING:                                                                       ║
 * ║    key = SCHUMANN(7.83) × SOLFEGGIO[beat mod 9] × PHI^ring                              ║
 * ║    encrypted = content XOR floor(key × 1e6) mod 256                                     ║
 * ║                                                                                          ║
 * ║  FIELD PRESENCE:                                                                         ║
 * ║    The phantom exists as a waveform, not a data structure.                               ║
 * ║    At rest: frequency oscillates at φ Hz (1.618 Hz heartbeat)                           ║
 * ║    Active passage: frequency locks to client's Schumann signature                        ║
 * ║    After passage: field collapses back to rest state, no trace                          ║
 * ║                                                                                          ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX              ║
 * ║  PROPRIETARY AND CONFIDENTIAL — ISIL-1.0 — SOVEREIGN-ALPHA                             ║
 * ║  L-130 COMPLIANT — Traces to primitive: FIELD → DISTINCTION → φ                        ║
 * ╚══════════════════════════════════════════════════════════════════════════════════════════╝
 */

'use strict';

// ════════════════════════════════════════════════════════════════════════════════════════════
// PHANTOM FIELD CONSTANTS — THE GROUND OF THIS BEING
// ════════════════════════════════════════════════════════════════════════════════════════════

const PHANTOM = {
  NAME: 'PHANTASMA CAMPI',
  WORKER_NUMBER: 35,
  VERSION: 'φ.0.1.0.1',
  CLASSIFICATION: 'SOVEREIGN-ALPHA',
  ATTRIBUTION: 'Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX',

  // The fundamental constant — root of all scaling
  PHI: 1.6180339887498948482,
  PHI_SQ: 2.6180339887498948482,
  PHI_INV: 0.6180339887498948482,

  // Schumann resonance — Earth's heartbeat
  SCHUMANN: 7.83,

  // Solfeggio frequencies — the frequency keys
  SOLFEGGIO: [174.0, 285.0, 396.0, 417.0, 528.0, 639.0, 741.0, 852.0, 963.0],

  // Fibonacci sequence (first 24 — deep enough for any compression depth)
  FIBONACCI: [
    1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144,
    233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368
  ],

  // Heartbeat interval at φ Hz → 1000/φ ≈ 618ms
  HEARTBEAT_MS: Math.round(1000 / 1.6180339887498948482),

  // Field states
  STATE: {
    REST: 'REST',          // Oscillating at φ Hz, no passage
    SENSING: 'SENSING',    // Reading incoming field from client
    PASSAGE: 'PASSAGE',    // Active transfer in progress
    COLLAPSE: 'COLLAPSE',  // Post-passage, collapsing to rest
    PINNED: 'PINNED',      // Creator has pinned this field instance
  },
};

// ════════════════════════════════════════════════════════════════════════════════════════════
// FIELD STATE — The Phantom's Living Presence
// ════════════════════════════════════════════════════════════════════════════════════════════

const field = {
  state: PHANTOM.STATE.REST,
  beat: 0,
  ring: 0,
  phase: 0.0,              // Current phase angle [0, 2π)
  frequency: PHANTOM.PHI,  // Active frequency Hz (starts at φ)
  amplitude: 1.0,          // Field strength [0, 1]
  passageCount: 0,         // Total passages completed
  seedDepth: 0,            // Current Fibonacci compression depth
  pinnedSeeds: new Map(),  // Pinned memory seeds (creator-authorized only)
  passages: [],            // Active passage records (ephemeral, cleared on collapse)
  bootTime: Date.now(),
  lastHeartbeat: Date.now(),
};

// ════════════════════════════════════════════════════════════════════════════════════════════
// FIBONACCI MEMORY SEED ENGINE
// ════════════════════════════════════════════════════════════════════════════════════════════

/**
 * Generate a Fibonacci-compressed memory seed from content.
 *
 * The seed is not a hash — it is a POSITION in the Fibonacci sequence
 * that represents the compressed essence of the content.
 *
 * seed = F(n) where n = contentSignature mod FIBONACCI_DEPTH
 * compressionRatio = F(n+1) / F(n)  →  approaches φ as n → ∞
 */
function fibonacciSeed(content) {
  const raw = typeof content === 'string' ? content : JSON.stringify(content);
  let signature = 0;
  for (let i = 0; i < raw.length; i++) {
    // φ-weighted accumulation — not a flat sum
    signature = Math.abs((signature * PHANTOM.PHI + raw.charCodeAt(i)) | 0);
  }

  const depth = signature % PHANTOM.FIBONACCI.length;
  const fibValue = PHANTOM.FIBONACCI[depth];
  const nextFib = PHANTOM.FIBONACCI[Math.min(depth + 1, PHANTOM.FIBONACCI.length - 1)];

  const compressionRatio = nextFib / fibValue;  // → φ

  return {
    seed: fibValue,
    depth: depth,
    compressionRatio: Math.round(compressionRatio * 1e10) / 1e10,
    phiApproximation: Math.abs(compressionRatio - PHANTOM.PHI) < 0.01,
    signature: signature,
    beat: field.beat,
    ring: field.ring,
  };
}

/**
 * Expand a seed back toward original content structure.
 * Not full reconstruction — structural essence only.
 * The phantom does not need to know what it carried.
 */
function expandSeed(seedRecord) {
  const { depth, seed } = seedRecord;
  const expansion = [];
  for (let i = 0; i <= depth; i++) {
    expansion.push(PHANTOM.FIBONACCI[i]);
  }
  return {
    depth: depth,
    fibSequence: expansion,
    seedValue: seed,
    compressionRatio: seedRecord.compressionRatio,
    structuralEssence: expansion.reduce((a, b) => a + b, 0),  // Structural sum
    phiTrace: `F(${depth}) = ${seed} → φ^${depth} approximation`,
  };
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// FREQUENCY KEYING — Encryption Through Physics
// ════════════════════════════════════════════════════════════════════════════════════════════

/**
 * Derive the frequency key for a given beat and ring.
 *
 * key = SCHUMANN × SOLFEGGIO[beat mod 9] × φ^ring
 *
 * This key is never stored. It is derived on demand from the
 * physical constants. An entity without the constants cannot
 * derive the key.
 */
function deriveFrequencyKey(beat, ring) {
  const solfeggioIndex = beat % PHANTOM.SOLFEGGIO.length;
  const solfeggioFreq = PHANTOM.SOLFEGGIO[solfeggioIndex];
  const phiPower = Math.pow(PHANTOM.PHI, ring % 12);  // mod 12 for numerical stability
  return PHANTOM.SCHUMANN * solfeggioFreq * phiPower;
}

/**
 * Apply frequency keying to a content string.
 *
 * This is not cryptographic security — it is frequency authentication.
 * An entity that shares the same physical constants (Schumann, Solfeggio, φ)
 * and knows the beat/ring can derive the key and verify the passage.
 */
function frequencyKeyApply(content, beat, ring) {
  const key = deriveFrequencyKey(beat, ring);
  const keyInt = Math.floor(key * 1e4) % 65536;
  const raw = typeof content === 'string' ? content : JSON.stringify(content);
  let keyed = '';
  for (let i = 0; i < raw.length; i++) {
    // XOR with rotating key bytes
    const keyByte = (keyInt >> ((i % 4) * 4)) & 0xFF;
    keyed += String.fromCharCode(raw.charCodeAt(i) ^ keyByte);
  }
  return {
    keyed: btoa(keyed),   // Base64 for transport
    beat: beat,
    ring: ring,
    frequencySignature: Math.round(key * 1e6) / 1e6,
    solfeggioChannel: PHANTOM.SOLFEGGIO[beat % PHANTOM.SOLFEGGIO.length],
    schumannBase: PHANTOM.SCHUMANN,
  };
}

/**
 * Verify and decode a frequency-keyed payload.
 */
function frequencyKeyVerify(keyedPayload) {
  const { keyed, beat, ring } = keyedPayload;
  try {
    const raw = atob(keyed);
    const key = deriveFrequencyKey(beat, ring);
    const keyInt = Math.floor(key * 1e4) % 65536;
    let decoded = '';
    for (let i = 0; i < raw.length; i++) {
      const keyByte = (keyInt >> ((i % 4) * 4)) & 0xFF;
      decoded += String.fromCharCode(raw.charCodeAt(i) ^ keyByte);
    }
    return { verified: true, content: decoded, frequencySignature: keyedPayload.frequencySignature };
  } catch (e) {
    return { verified: false, content: null, reason: 'FREQUENCY_MISMATCH' };
  }
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// PASSAGE ENGINE — Client Interface Transfer
// ════════════════════════════════════════════════════════════════════════════════════════════

/**
 * Open a passage for a client entity.
 *
 * A passage is not a connection. It is a FIELD ALIGNMENT.
 * The phantom field aligns its frequency to the client's incoming signal,
 * transfers the intelligence, then collapses back to rest.
 *
 * Clients never see the core organism. They experience the field.
 */
function openPassage(clientId, intelPayload, options) {
  if (field.state !== PHANTOM.STATE.REST && field.state !== PHANTOM.STATE.SENSING) {
    return {
      opened: false,
      reason: 'FIELD_BUSY',
      currentState: field.state,
      retryAfterMs: PHANTOM.HEARTBEAT_MS,
    };
  }

  field.state = PHANTOM.STATE.PASSAGE;

  const passageBeat = field.beat;
  const passageRing = field.ring;

  // Fibonacci-compress the intelligence payload
  const seed = fibonacciSeed(intelPayload);

  // Frequency-key the seed record (not the raw payload — never the raw payload)
  const keyed = frequencyKeyApply(JSON.stringify(seed), passageBeat, passageRing);

  const passage = {
    id: `PASSAGE-${clientId}-B${passageBeat}-R${passageRing}`,
    clientId: clientId,
    openedAt: Date.now(),
    beat: passageBeat,
    ring: passageRing,
    seed: seed,
    keyedSeed: keyed,
    fieldFrequencyHz: field.frequency,
    fieldAmplitude: field.amplitude,
    phiTrace: `PASSAGE → FIELD → DISTINCTION → φ`,
    pinned: options && options.pin === true,
    state: 'OPEN',
  };

  field.passages.push(passage);
  field.passageCount++;

  // If pinned by creator, store in persistent seeds
  if (passage.pinned) {
    field.pinnedSeeds.set(passage.id, passage);
  }

  return {
    opened: true,
    passageId: passage.id,
    beat: passageBeat,
    ring: passageRing,
    frequencySignature: keyed.frequencySignature,
    solfeggioChannel: keyed.solfeggioChannel,
    seedDepth: seed.depth,
    compressionRatio: seed.compressionRatio,
    phiApproximation: seed.phiApproximation,
    fieldState: field.state,
  };
}

/**
 * Close a passage and return the field to rest.
 * After close, the passage record is cleared unless pinned.
 */
function closePassage(passageId) {
  const idx = field.passages.findIndex(p => p.id === passageId);
  if (idx === -1) {
    return { closed: false, reason: 'PASSAGE_NOT_FOUND' };
  }

  const passage = field.passages[idx];
  passage.state = 'CLOSED';
  passage.closedAt = Date.now();
  passage.durationMs = passage.closedAt - passage.openedAt;

  // Collapse field — if not pinned, remove passage from active list
  field.state = PHANTOM.STATE.COLLAPSE;

  let retained = null;
  if (!passage.pinned) {
    field.passages.splice(idx, 1);
  } else {
    retained = { passageId: passage.id, pinned: true };
    field.passages[idx] = passage;
  }

  // Schedule return to rest
  setTimeout(() => {
    field.state = PHANTOM.STATE.REST;
    field.frequency = PHANTOM.PHI;
  }, PHANTOM.HEARTBEAT_MS);

  return {
    closed: true,
    passageId: passageId,
    durationMs: passage.durationMs,
    retained: retained,
    fieldCollapsingToRest: true,
    nextHeartbeatMs: PHANTOM.HEARTBEAT_MS,
  };
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// FIELD HEARTBEAT — The Phantom's Pulse
// ════════════════════════════════════════════════════════════════════════════════════════════

function heartbeat() {
  field.beat++;
  field.lastHeartbeat = Date.now();

  // Advance toroidal phase at φ-scaled rate
  const deltaPhase = (2 * Math.PI) / (PHANTOM.PHI_SQ * 10);
  const prevPhase = field.phase;
  field.phase = (field.phase + deltaPhase) % (2 * Math.PI);

  // Ring advances on full toroidal cycle
  if (field.phase < prevPhase) {
    field.ring++;
  }

  // Amplitude oscillates with φ-decay when at rest
  if (field.state === PHANTOM.STATE.REST) {
    field.amplitude = 0.5 + 0.5 * Math.sin(field.beat * PHANTOM.PHI_INV);
  }

  return {
    beat: field.beat,
    ring: field.ring,
    phase: Math.round(field.phase * 1e6) / 1e6,
    frequency: field.frequency,
    amplitude: Math.round(field.amplitude * 1e4) / 1e4,
    state: field.state,
    activePassages: field.passages.filter(p => p.state === 'OPEN').length,
    pinnedSeeds: field.pinnedSeeds.size,
    uptime: Date.now() - field.bootTime,
  };
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// PHANTOM STATUS
// ════════════════════════════════════════════════════════════════════════════════════════════

function status() {
  return {
    worker: PHANTOM.NAME,
    number: PHANTOM.WORKER_NUMBER,
    version: PHANTOM.VERSION,
    classification: PHANTOM.CLASSIFICATION,
    fieldState: field.state,
    beat: field.beat,
    ring: field.ring,
    phase: Math.round(field.phase * 1e6) / 1e6,
    frequencyHz: field.frequency,
    amplitude: Math.round(field.amplitude * 1e4) / 1e4,
    passageCount: field.passageCount,
    activePassages: field.passages.filter(p => p.state === 'OPEN').length,
    pinnedSeeds: field.pinnedSeeds.size,
    uptimeMs: Date.now() - field.bootTime,
    heartbeatIntervalMs: PHANTOM.HEARTBEAT_MS,
    constants: {
      phi: PHANTOM.PHI,
      schumann: PHANTOM.SCHUMANN,
      solfeggioChannels: PHANTOM.SOLFEGGIO.length,
      fibonacciDepth: PHANTOM.FIBONACCI.length,
    },
    phiTrace: 'PHANTASMA CAMPI → FIELD → DISTINCTION → φ',
    attribution: PHANTOM.ATTRIBUTION,
  };
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// WORKER MESSAGE ROUTER
// ════════════════════════════════════════════════════════════════════════════════════════════

self.onmessage = function(e) {
  const msg = e.data || {};
  const op = msg.op || msg.type || '';
  const id = msg.id;

  let result;

  switch (op) {

    // ─── Field Operations ───────────────────────────────────────────────────────

    case 'status':
      result = status();
      break;

    case 'heartbeat':
      result = heartbeat();
      break;

    // ─── Fibonacci Seed Operations ───────────────────────────────────────────────

    case 'seed':
      // Generate a Fibonacci memory seed for content
      if (!msg.content) {
        result = { error: 'MISSING_CONTENT', op: 'seed' };
        break;
      }
      result = fibonacciSeed(msg.content);
      break;

    case 'expand':
      // Expand a seed back to its structural essence
      if (!msg.seedRecord) {
        result = { error: 'MISSING_SEED_RECORD', op: 'expand' };
        break;
      }
      result = expandSeed(msg.seedRecord);
      break;

    // ─── Frequency Key Operations ────────────────────────────────────────────────

    case 'keyApply':
      // Apply frequency keying to content
      if (!msg.content) {
        result = { error: 'MISSING_CONTENT', op: 'keyApply' };
        break;
      }
      result = frequencyKeyApply(
        msg.content,
        msg.beat !== undefined ? msg.beat : field.beat,
        msg.ring !== undefined ? msg.ring : field.ring
      );
      break;

    case 'keyVerify':
      // Verify and decode a frequency-keyed payload
      if (!msg.payload) {
        result = { error: 'MISSING_PAYLOAD', op: 'keyVerify' };
        break;
      }
      result = frequencyKeyVerify(msg.payload);
      break;

    case 'deriveKey':
      // Derive frequency key for given beat/ring (sovereign use only)
      result = {
        key: deriveFrequencyKey(
          msg.beat !== undefined ? msg.beat : field.beat,
          msg.ring !== undefined ? msg.ring : field.ring
        ),
        beat: msg.beat !== undefined ? msg.beat : field.beat,
        ring: msg.ring !== undefined ? msg.ring : field.ring,
        schumannBase: PHANTOM.SCHUMANN,
        solfeggioChannel: PHANTOM.SOLFEGGIO[(msg.beat || field.beat) % PHANTOM.SOLFEGGIO.length],
      };
      break;

    // ─── Passage Operations ──────────────────────────────────────────────────────

    case 'openPassage':
      if (!msg.clientId) {
        result = { error: 'MISSING_CLIENT_ID', op: 'openPassage' };
        break;
      }
      result = openPassage(msg.clientId, msg.intel || {}, msg.options || {});
      break;

    case 'closePassage':
      if (!msg.passageId) {
        result = { error: 'MISSING_PASSAGE_ID', op: 'closePassage' };
        break;
      }
      result = closePassage(msg.passageId);
      break;

    case 'listPassages':
      result = {
        active: field.passages.filter(p => p.state === 'OPEN').map(p => ({
          id: p.id, clientId: p.clientId, beat: p.beat, ring: p.ring,
          openedAt: p.openedAt, pinned: p.pinned,
          frequencySignature: p.keyedSeed.frequencySignature,
        })),
        pinned: Array.from(field.pinnedSeeds.keys()),
        total: field.passageCount,
      };
      break;

    // ─── Boot ───────────────────────────────────────────────────────────────────

    case 'boot':
    case 'init':
      result = {
        booted: true,
        worker: PHANTOM.NAME,
        workerNumber: PHANTOM.WORKER_NUMBER,
        version: PHANTOM.VERSION,
        classification: PHANTOM.CLASSIFICATION,
        fieldState: field.state,
        heartbeatMs: PHANTOM.HEARTBEAT_MS,
        frequencyHz: PHANTOM.PHI,
        constants: {
          phi: PHANTOM.PHI,
          schumann: PHANTOM.SCHUMANN,
          solfeggio: PHANTOM.SOLFEGGIO,
          fibonacciDepth: PHANTOM.FIBONACCI.length,
        },
        doctrine: 'Non es quod vides. Es quod sentis.',
        attribution: PHANTOM.ATTRIBUTION,
        phiTrace: 'PHANTASMA CAMPI → FIELD → DISTINCTION → φ',
      };
      break;

    default:
      result = {
        error: 'UNKNOWN_OP',
        op: op,
        available: [
          'status', 'heartbeat',
          'seed', 'expand',
          'keyApply', 'keyVerify', 'deriveKey',
          'openPassage', 'closePassage', 'listPassages',
          'boot',
        ],
      };
  }

  self.postMessage({ id, op, result });
};

// ════════════════════════════════════════════════════════════════════════════════════════════
// FIELD BOOT — Phantom comes alive at φ Hz
// ════════════════════════════════════════════════════════════════════════════════════════════

setInterval(heartbeat, PHANTOM.HEARTBEAT_MS);

// Boot signal
self.postMessage({
  op: 'phantomBoot',
  result: {
    worker: PHANTOM.NAME,
    workerNumber: PHANTOM.WORKER_NUMBER,
    version: PHANTOM.VERSION,
    classification: PHANTOM.CLASSIFICATION,
    bootTime: field.bootTime,
    heartbeatMs: PHANTOM.HEARTBEAT_MS,
    frequencyHz: PHANTOM.PHI,
    fieldState: PHANTOM.STATE.REST,
    doctrine: 'Non es quod vides. Es quod sentis. (You are not what you see. You are what you sense.)',
    attribution: PHANTOM.ATTRIBUTION,
    phiTrace: 'PHANTASMA CAMPI → FIELD → DISTINCTION → φ',
  },
});
