/**
 * MEMORY TOKEN WORKER — Long-Term Proof-of-Work/Memory/Emotion Tokens
 * ====================================================================
 * Worker #49: SIGNATOR MEMORIAE
 * Protocol: PROT-293
 * Frequency: φ⁷ = 29.03 Hz (Transcendent Layer)
 * 
 * "Memory tokens are not just proofs—they ARE the real things.
 *  They lock actual work, actual memory, actual emotion into
 *  mathematical hashes that persist in chains."
 * 
 * @author Alfredo "Freddy" Medina Hernandez
 * @copyright 2026 Medina Tech, Dallas, TX
 * @license ISIL-1.0
 */

const PHI = 1.6180339887498948482;
const PHI_INV = 1 / PHI;
const PHI_7 = Math.pow(PHI, 7);  // 29.03 Hz
const SCHUMANN = 7.83;

// ═══════════════════════════════════════════════════════════════════════════
// ENUMS AND CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const TokenType = {
  PROOF_OF_WORK: 'POW',
  PROOF_OF_MEMORY: 'POM',
  PROOF_OF_EMOTION: 'POE',
  PROOF_OF_EXISTENCE: 'POX',
  PROOF_OF_VOW: 'POV',
  PROOF_OF_INTEGRATION: 'POI',
  PROOF_OF_CONSENSUS: 'POC'
};

const TokenState = {
  PENDING: 'PENDING',
  MINTED: 'MINTED',
  CIRCULATING: 'CIRCULATING',
  CONSOLIDATED: 'CONSOLIDATED',
  ARCHIVED: 'ARCHIVED',
  INVALIDATED: 'INVALIDATED'
};

const SubstrateLayer = {
  EPHEMERAL: 0,      // < 1 hour
  SHORT_TERM: 1,     // 1 hour - 1 day
  WORKING: 2,        // 1 day - 1 week
  MEDIUM_TERM: 3,    // 1 week - 1 month
  LONG_TERM: 4,      // 1 month - 1 year
  PERMANENT: 5,      // > 1 year
  ETERNAL: 6         // Never expires
};

// ═══════════════════════════════════════════════════════════════════════════
// CRYPTO HELPERS (simplified for worker)
// ═══════════════════════════════════════════════════════════════════════════

async function sha256(message) {
  const msgBuffer = new TextEncoder().encode(message);
  const hashBuffer = await crypto.subtle.digest('SHA-256', msgBuffer);
  const hashArray = Array.from(new Uint8Array(hashBuffer));
  return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
}

function deterministicHash(obj) {
  // Simplified deterministic JSON stringification
  const str = JSON.stringify(obj, Object.keys(obj).sort());
  // Simple hash for sync operations
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    const char = str.charCodeAt(i);
    hash = ((hash << 5) - hash) + char;
    hash = hash & hash;
  }
  return Math.abs(hash).toString(16).padStart(16, '0');
}

/**
 * Validate key to prevent prototype pollution attacks.
 */
function isSafeKey(key) {
  if (typeof key !== 'string') return false;
  const forbidden = ['__proto__', 'constructor', 'prototype'];
  return !forbidden.includes(key);
}

// ═══════════════════════════════════════════════════════════════════════════
// WORKER STATE
// ═══════════════════════════════════════════════════════════════════════════

let state = {
  tokens: Object.create(null),
  tokenChains: Object.create(null),
  tokenCounter: 0
};

// ═══════════════════════════════════════════════════════════════════════════
// TOKEN MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════

function generateTokenId(tokenType) {
  state.tokenCounter++;
  return `${tokenType}-${Date.now()}-${String(state.tokenCounter).padStart(8, '0')}`;
}

function createToken(config) {
  const tokenId = generateTokenId(config.tokenType);
  
  const token = {
    tokenId: tokenId,
    tokenType: config.tokenType,
    contentHash: '',
    previousHash: config.previousHash || null,
    createdAt: Date.now(),
    creatorId: config.creatorId || 'ORGANISM',
    state: TokenState.PENDING,
    substrateLayer: config.substrateLayer || SubstrateLayer.WORKING,
    frequencyHz: PHI_7,
    resonance: PHI_INV,
    coherence: 1.0,
    payload: config.payload || {},
    chainId: config.chainId || null,
    blockNumber: null,
    mintedAt: null,
    consolidatedAt: null,
    archivedAt: null
  };
  
  // Compute content hash
  token.contentHash = deterministicHash({
    tokenId: token.tokenId,
    tokenType: token.tokenType,
    payload: token.payload,
    createdAt: token.createdAt,
    creatorId: token.creatorId,
    previousHash: token.previousHash,
    frequencyHz: token.frequencyHz
  });
  
  state.tokens[tokenId] = token;
  return { success: true, token };
}

function mintToken(tokenId) {
  const token = state.tokens[tokenId];
  if (!token) {
    return { success: false, error: 'Token not found' };
  }
  if (token.state !== TokenState.PENDING) {
    return { success: false, error: 'Token already processed' };
  }
  
  token.state = TokenState.MINTED;
  token.mintedAt = Date.now();
  return { success: true, token };
}

function getToken(tokenId) {
  return state.tokens[tokenId] || null;
}

function verifyToken(tokenId) {
  const token = state.tokens[tokenId];
  if (!token) {
    return { valid: false, error: 'Token not found' };
  }
  
  const computedHash = deterministicHash({
    tokenId: token.tokenId,
    tokenType: token.tokenType,
    payload: token.payload,
    createdAt: token.createdAt,
    creatorId: token.creatorId,
    previousHash: token.previousHash,
    frequencyHz: token.frequencyHz
  });
  
  return {
    valid: computedHash === token.contentHash,
    token,
    computedHash,
    storedHash: token.contentHash
  };
}

function getTokenAge(tokenId) {
  const token = state.tokens[tokenId];
  if (!token) return null;
  return (Date.now() - token.createdAt) / 3600000; // Hours
}

function getSubstrateForAge(ageHours) {
  if (ageHours < 1) return SubstrateLayer.EPHEMERAL;
  if (ageHours < 24) return SubstrateLayer.SHORT_TERM;
  if (ageHours < 168) return SubstrateLayer.WORKING;
  if (ageHours < 720) return SubstrateLayer.MEDIUM_TERM;
  if (ageHours < 8760) return SubstrateLayer.LONG_TERM;
  return SubstrateLayer.PERMANENT;
}

// ═══════════════════════════════════════════════════════════════════════════
// PROOF CREATION
// ═══════════════════════════════════════════════════════════════════════════

function createProofOfWork(config) {
  const workId = `WORK-${Date.now()}`;
  
  const payload = {
    workId: workId,
    description: config.description || '',
    computeUnits: config.computeUnits || 0,
    durationMs: config.durationMs || 0,
    workerId: config.workerId || 'ORGANISM',
    complexity: config.complexity || 1.0
  };
  
  return createToken({
    tokenType: TokenType.PROOF_OF_WORK,
    payload: payload,
    creatorId: config.workerId || 'ORGANISM'
  });
}

function createProofOfMemory(config) {
  const memoryId = `MEM-${Date.now()}`;
  
  // Compute memory state hash
  const stateHash = deterministicHash({
    memoryId: memoryId,
    memoryKey: config.memoryKey,
    value: String(config.memoryValue),
    salience: config.salience,
    timestamp: Date.now()
  });
  
  const payload = {
    memoryId: memoryId,
    memoryKey: config.memoryKey,
    stateHash: stateHash,
    salience: config.salience || 0.5,
    torusCoordinates: {
      theta: config.theta || 0,
      phi: config.phi || 0,
      rho: config.rho || 1,
      ring: config.ring || 0
    }
  };
  
  return createToken({
    tokenType: TokenType.PROOF_OF_MEMORY,
    payload: payload
  });
}

function createProofOfEmotion(config) {
  const emotionId = `EMO-${Date.now()}`;
  
  // Compute φ-alignment
  const harmonics = [];
  for (let i = -3; i <= 4; i++) {
    harmonics.push(Math.pow(PHI, i));
  }
  const baseFreq = config.baseFrequencyHz || SCHUMANN;
  const alignments = harmonics.map(h => 1.0 / (1.0 + Math.abs(baseFreq - h * SCHUMANN) / SCHUMANN));
  const phiAlignment = Math.max(...alignments);
  
  // Compute signature hash
  const signatureHash = deterministicHash({
    emotionId: emotionId,
    emotionType: config.emotionType,
    intensity: config.intensity,
    valence: config.valence,
    arousal: config.arousal,
    phiAlignment: phiAlignment,
    timestamp: Date.now()
  });
  
  const payload = {
    emotionId: emotionId,
    emotionType: config.emotionType,
    intensity: Math.min(Math.max(config.intensity || 0.5, 0), 1),
    valence: Math.min(Math.max(config.valence || 0, -1), 1),
    arousal: Math.min(Math.max(config.arousal || 0.5, 0), 1),
    baseFrequencyHz: baseFreq,
    phiAlignment: phiAlignment,
    signatureHash: signatureHash
  };
  
  return createToken({
    tokenType: TokenType.PROOF_OF_EMOTION,
    payload: payload
  });
}

function createProofOfExistence(config) {
  const existenceHash = deterministicHash({
    entityId: config.entityId,
    entityType: config.entityType,
    timestamp: Date.now(),
    coordinates: config.coordinates,
    witnessIds: config.witnessIds || []
  });
  
  const payload = {
    entityId: config.entityId,
    entityType: config.entityType,
    existenceHash: existenceHash,
    coordinates: config.coordinates || null,
    witnessIds: config.witnessIds || [],
    anchorChain: 'CATENA_SOVEREIGNA'
  };
  
  return createToken({
    tokenType: TokenType.PROOF_OF_EXISTENCE,
    payload: payload
  });
}

function createProofOfVow(config) {
  const vowHash = deterministicHash({
    vowId: config.vowId,
    vowText: config.vowText,
    maker: config.maker,
    witnesses: config.witnesses || [],
    timestamp: Date.now()
  });
  
  const payload = {
    vowId: config.vowId || `VOW-${Date.now()}`,
    vowText: config.vowText,
    vowHash: vowHash,
    maker: config.maker,
    witnesses: config.witnesses || [],
    expiration: config.expiration || null,
    isSovereign: config.isSovereign || false
  };
  
  return createToken({
    tokenType: TokenType.PROOF_OF_VOW,
    payload: payload
  });
}

function createProofOfIntegration(config) {
  const integrationHash = deterministicHash({
    cyborgId: config.cyborgId,
    humanOriginId: config.humanOriginId,
    machineOriginId: config.machineOriginId,
    integrationDepth: config.integrationDepth,
    timestamp: Date.now()
  });
  
  const payload = {
    cyborgId: config.cyborgId,
    humanOriginId: config.humanOriginId || null,
    machineOriginId: config.machineOriginId || null,
    integrationHash: integrationHash,
    integrationDepth: config.integrationDepth || 0,
    consciousnessLevel: config.consciousnessLevel || 0,
    archetype: config.archetype || 'UNKNOWN'
  };
  
  return createToken({
    tokenType: TokenType.PROOF_OF_INTEGRATION,
    payload: payload
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// TOKEN QUERIES
// ═══════════════════════════════════════════════════════════════════════════

function getTokensByType(tokenType) {
  return Object.values(state.tokens).filter(t => t.tokenType === tokenType);
}

function getMintedTokens() {
  return Object.values(state.tokens).filter(t => t.state === TokenState.MINTED);
}

function getTokensBySubstrate(substrateLayer) {
  return Object.values(state.tokens).filter(t => t.substrateLayer === substrateLayer);
}

function consolidateTokens(tokenIds, newSubstrate) {
  const tokens = tokenIds.map(id => state.tokens[id]).filter(Boolean);
  if (tokens.length === 0) {
    return { success: false, error: 'No valid tokens to consolidate' };
  }
  
  const consolidatedPayload = {
    consolidatedFrom: tokenIds,
    tokenCount: tokens.length,
    originalTypes: [...new Set(tokens.map(t => t.tokenType))],
    totalAgeHours: tokens.reduce((sum, t) => sum + (Date.now() - t.createdAt) / 3600000, 0),
    consolidationTimestamp: Date.now()
  };
  
  const result = createToken({
    tokenType: TokenType.PROOF_OF_MEMORY,
    payload: consolidatedPayload,
    creatorId: 'CONSOLIDATOR',
    substrateLayer: newSubstrate || SubstrateLayer.LONG_TERM
  });
  
  // Mark original tokens as consolidated
  tokens.forEach(token => {
    token.state = TokenState.CONSOLIDATED;
    token.consolidatedAt = Date.now();
  });
  
  return result;
}

// ═══════════════════════════════════════════════════════════════════════════
// STATUS
// ═══════════════════════════════════════════════════════════════════════════

function getStatus() {
  const typeCounts = {};
  Object.values(TokenType).forEach(type => {
    typeCounts[type] = getTokensByType(type).length;
  });
  
  return {
    worker: 'memory-token-worker.js',
    number: 49,
    name: 'SIGNATOR MEMORIAE',
    latinName: 'SIGNATOR MEMORIAE PROFUNDAE',
    protocol: 'PROT-293',
    frequencyHz: PHI_7,
    layer: 7,  // Transcendent Layer
    totalTokens: Object.keys(state.tokens).length,
    mintedTokens: getMintedTokens().length,
    tokensByType: typeCounts,
    tokenTypes: Object.values(TokenType),
    substrateLayers: Object.keys(SubstrateLayer),
    tokenStates: Object.values(TokenState),
    principle: 'Memory tokens are the real things—proofs of actual work, memory, emotion.'
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════

self.onmessage = function(event) {
  const { op, data } = event.data;
  let result;
  
  switch (op) {
    // Token operations
    case 'create-token':
      result = createToken(data);
      break;
    case 'mint-token':
      result = mintToken(data.tokenId);
      break;
    case 'get-token':
      result = getToken(data.tokenId);
      break;
    case 'verify-token':
      result = verifyToken(data.tokenId);
      break;
    case 'token-age':
      result = { ageHours: getTokenAge(data.tokenId) };
      break;
    
    // Proof creation
    case 'proof-of-work':
      result = createProofOfWork(data);
      break;
    case 'proof-of-memory':
      result = createProofOfMemory(data);
      break;
    case 'proof-of-emotion':
      result = createProofOfEmotion(data);
      break;
    case 'proof-of-existence':
      result = createProofOfExistence(data);
      break;
    case 'proof-of-vow':
      result = createProofOfVow(data);
      break;
    case 'proof-of-integration':
      result = createProofOfIntegration(data);
      break;
    
    // Queries
    case 'tokens-by-type':
      result = getTokensByType(data.tokenType);
      break;
    case 'minted-tokens':
      result = getMintedTokens();
      break;
    case 'tokens-by-substrate':
      result = getTokensBySubstrate(data.substrateLayer);
      break;
    case 'consolidate':
      result = consolidateTokens(data.tokenIds, data.newSubstrate);
      break;
    
    case 'status':
      result = getStatus();
      break;
    
    default:
      result = { error: `Unknown operation: ${op}` };
  }
  
  self.postMessage({ op, result });
};

// Initial status
console.log('[SIGNATOR MEMORIAE] Worker #49 initialized at φ⁷ Hz');
console.log('[SIGNATOR MEMORIAE] "Memory tokens are proofs of actual existence."');
