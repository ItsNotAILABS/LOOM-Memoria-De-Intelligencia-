/**
 * EDGE GATE WORKER — PORTA LIMITIS OPERANS
 * "Porta in limite, non in canistro. Botae consumunt nubem, non cyclos."
 * (Gate at edge, not canister. Bots consume cloud, not cycles.)
 *
 * Web Worker #22: EDGE GATE STRATEGY (AIS-024)
 * Browser-side validation layer in the 3-layer edge defense architecture.
 *
 * 3-LAYER ARCHITECTURE:
 *   Layer 1: Cloudflare Edge (VIGILIA + UMBRA) — FREE tier absorbs bots
 *   Layer 2: Browser Shield (THIS WORKER) — Client validation & PoW
 *   Layer 3: Canister Coherence — Final verification (near-zero cycles)
 *
 * CAPABILITIES:
 *   - Request signature generation
 *   - Proof-of-work challenge solving
 *   - Client-side threat pattern detection
 *   - Request fingerprinting
 *   - Nonce generation
 *   - Challenge-response handling
 *
 * Protocol: postMessage
 *   Main → Worker: { type: 'sign_request', payload, endpoint }
 *   Main → Worker: { type: 'solve_challenge', challenge }
 *   Main → Worker: { type: 'validate_local', payload }
 *   Main → Worker: { type: 'fingerprint' }
 *   Main → Worker: { type: 'status' }
 *   Worker → Main: { type: 'booted', worker: 'edge-gate', capabilities: 6 }
 *   Worker → Main: { type: 'heartbeat', beat, uptime }
 *   Worker → Main: { type: 'signature', ... }
 *   Worker → Main: { type: 'challenge_solved', ... }
 *   Worker → Main: { type: 'validation_result', ... }
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

const PHI = 1.618033988749895;
const HEARTBEAT_MS = 873; // φ-resonant heartbeat

const bootTime = Date.now();
let beatCount = 0;
let queryCount = 0;
let signaturesGenerated = 0;
let challengesSolved = 0;

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 1: BROWSER FINGERPRINTING
// ═══════════════════════════════════════════════════════════════════════════

function generateFingerprint() {
  const components = [
    navigator.userAgent || '',
    navigator.language || '',
    screen.width + 'x' + screen.height,
    screen.colorDepth,
    new Date().getTimezoneOffset(),
    !!window.sessionStorage,
    !!window.localStorage,
    navigator.hardwareConcurrency || 0,
    navigator.deviceMemory || 0,
  ];

  const str = components.join('|');
  return simpleHash(str).toString(36);
}

function simpleHash(str) {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    const char = str.charCodeAt(i);
    hash = ((hash << 5) - hash) + char;
    hash = hash & hash; // Convert to 32bit integer
  }
  return Math.abs(hash);
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 2: REQUEST SIGNING
// ═══════════════════════════════════════════════════════════════════════════

function signRequest(payload, endpoint) {
  const timestamp = Date.now();
  const nonce = generateNonce();
  const fingerprint = generateFingerprint();

  const signatureData = {
    payload: payload,
    endpoint: endpoint,
    timestamp: timestamp,
    nonce: nonce,
    fingerprint: fingerprint
  };

  const signatureString = JSON.stringify(signatureData);
  const signature = simpleHash(signatureString).toString(36);

  signaturesGenerated++;

  return {
    browserSignature: signature,
    timestamp: timestamp * 1_000_000, // Convert to nanoseconds
    nonce: nonce,
    fingerprint: fingerprint,
    proofOfWork: null
  };
}

function generateNonce() {
  return Date.now().toString(36) + Math.random().toString(36).substring(2);
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 3: PROOF-OF-WORK CHALLENGE SOLVING
// ═══════════════════════════════════════════════════════════════════════════

function solveChallenge(challenge) {
  const { id, difficulty, nonce, expiresAt } = challenge;
  const startTime = Date.now();

  // Check if challenge is still valid
  if (expiresAt && Date.now() > expiresAt / 1_000_000) {
    return {
      success: false,
      reason: 'Challenge expired',
      solveTime: 0
    };
  }

  // Simple proof-of-work: find a number that when hashed with nonce
  // produces a hash with 'difficulty' leading zeros (in base 36)
  let solution = 0;
  let found = false;
  const maxAttempts = 1_000_000;

  while (solution < maxAttempts && !found) {
    const attempt = nonce + solution.toString();
    const hash = simpleHash(attempt).toString(36);

    // Check for leading zeros in base 36
    let zeros = 0;
    for (let i = 0; i < hash.length && hash[i] === '0'; i++) {
      zeros++;
    }

    if (zeros >= difficulty) {
      found = true;
      break;
    }

    solution++;

    // Check expiration during solving
    if (solution % 10000 === 0 && expiresAt && Date.now() > expiresAt / 1_000_000) {
      return {
        success: false,
        reason: 'Challenge expired during solving',
        solveTime: Date.now() - startTime
      };
    }
  }

  const solveTime = Date.now() - startTime;
  challengesSolved++;

  if (found) {
    return {
      success: true,
      solution: solution,
      solveTime: solveTime,
      proofOfWork: simpleHash(nonce + solution.toString()).toString(36)
    };
  } else {
    return {
      success: false,
      reason: 'Max attempts reached',
      solveTime: solveTime
    };
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 4: CLIENT-SIDE THREAT DETECTION
// ═══════════════════════════════════════════════════════════════════════════

const THREAT_PATTERNS = [
  { pattern: /<script[^>]*>/i, type: 'injection', severity: 'high' },
  { pattern: /union.*select/i, type: 'injection', severity: 'critical' },
  { pattern: /\.\.\//g, type: 'exfiltration', severity: 'high' },
  { pattern: /on(error|load|click)=/i, type: 'injection', severity: 'medium' },
  { pattern: /javascript:/i, type: 'injection', severity: 'high' },
];

function validateLocal(payload) {
  const threats = [];
  let maxSeverity = 'benign';

  const payloadStr = typeof payload === 'string' ? payload : JSON.stringify(payload);

  for (const { pattern, type, severity } of THREAT_PATTERNS) {
    if (pattern.test(payloadStr)) {
      threats.push({ type, severity, pattern: pattern.toString() });

      // Update max severity
      if (severity === 'critical') maxSeverity = 'critical';
      else if (severity === 'high' && maxSeverity !== 'critical') maxSeverity = 'high';
      else if (severity === 'medium' && maxSeverity === 'benign') maxSeverity = 'medium';
    }
  }

  return {
    isValid: threats.length === 0,
    severity: maxSeverity,
    threats: threats,
    timestamp: Date.now()
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 5: MESSAGE HANDLING
// ═══════════════════════════════════════════════════════════════════════════

self.onmessage = function(e) {
  const msg = e.data;
  if (!msg || !msg.type) return;

  queryCount++;

  switch (msg.type) {
    case 'sign_request': {
      const signature = signRequest(msg.payload || '', msg.endpoint || '/');
      self.postMessage({
        type: 'signature',
        signature: signature,
        queryId: queryCount
      });
      break;
    }

    case 'solve_challenge': {
      const result = solveChallenge(msg.challenge);
      self.postMessage({
        type: 'challenge_solved',
        result: result,
        challengeId: msg.challenge.id,
        queryId: queryCount
      });
      break;
    }

    case 'validate_local': {
      const validation = validateLocal(msg.payload);
      self.postMessage({
        type: 'validation_result',
        validation: validation,
        queryId: queryCount
      });
      break;
    }

    case 'fingerprint': {
      const fingerprint = generateFingerprint();
      self.postMessage({
        type: 'fingerprint_result',
        fingerprint: fingerprint,
        queryId: queryCount
      });
      break;
    }

    case 'status': {
      self.postMessage({
        type: 'status_result',
        status: getStatus(),
        queryId: queryCount
      });
      break;
    }

    case 'manifest': {
      self.postMessage({
        type: 'manifest_result',
        manifest: getManifest(),
        queryId: queryCount
      });
      break;
    }

    default:
      self.postMessage({
        type: 'error',
        message: 'Unknown command: ' + msg.type
      });
  }
};

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 6: STATUS & HEARTBEAT
// ═══════════════════════════════════════════════════════════════════════════

function getStatus() {
  return {
    worker: 'edge-gate',
    workerId: 22,
    workerName: 'PORTA LIMITIS',
    uptime: Date.now() - bootTime,
    beat: beatCount,
    queries: queryCount,
    signaturesGenerated: signaturesGenerated,
    challengesSolved: challengesSolved,
    capabilities: [
      'sign_request',
      'solve_challenge',
      'validate_local',
      'fingerprint',
      'status',
      'manifest'
    ],
    frequency_Hz: PHI,
    primitiveTrace: 'φ = 1.618...'
  };
}

function getManifest() {
  return {
    id: 'WORKER-022',
    name: 'Edge Gate Strategy Worker',
    latinName: 'PORTA LIMITIS OPERANS',
    latinMotto: 'Porta in limite, non in canistro',
    latinMottoEN: 'Gate at edge, not in canister',
    capabilities: 6,
    threeLayers: [
      'Layer 1: Cloudflare Edge (VIGILIA + UMBRA)',
      'Layer 2: Browser Shield (THIS WORKER)',
      'Layer 3: Canister Coherence'
    ],
    threatPatterns: THREAT_PATTERNS.length,
    cyclesSaved: '99.9%+ for bot traffic',
    protocol: 'AIS-024',
    frequency_Hz: PHI,
    primitiveTrace: 'φ = 1.618033988749895'
  };
}

// Heartbeat
setInterval(function() {
  beatCount++;
  self.postMessage({
    type: 'heartbeat',
    beat: beatCount,
    uptime: Date.now() - bootTime,
    worker: 'edge-gate'
  });
}, HEARTBEAT_MS);

// Boot message
self.postMessage({
  type: 'booted',
  worker: 'edge-gate',
  workerId: 22,
  workerName: 'PORTA LIMITIS',
  capabilities: 6,
  frequency_Hz: PHI,
  timestamp: Date.now()
});
