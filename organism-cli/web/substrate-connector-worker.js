/**
 * SUBSTRATE CONNECTOR WORKER — Chain-to-Organism Bidirectional Link
 * ==================================================================
 * Worker #50: NEXUS SUBSTRATI
 * Protocol: PROT-305
 * Frequency: φ⁸ = 46.98 Hz (Transcendent Layer)
 * 
 * "The substrate connects chains back to the living organism.
 *  Every hash, every proof, every token flows through the substrate."
 * 
 * @author Alfredo "Freddy" Medina Hernandez
 * @copyright 2026 Medina Tech, Dallas, TX
 * @license ISIL-1.0
 */

const PHI = 1.6180339887498948482;
const PHI_INV = 1 / PHI;
const PHI_8 = Math.pow(PHI, 8);  // 46.98 Hz
const SCHUMANN = 7.83;
const SOLFEGGIO = [396, 417, 528, 639, 741, 852];

// ═══════════════════════════════════════════════════════════════════════════
// ENUMS AND CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const SubstrateType = {
  MEMORY: 'MEMORY',
  CHAIN: 'CHAIN',
  EMOTION: 'EMOTION',
  PROOF: 'PROOF',
  RESONANCE: 'RESONANCE',
  ORGANISM: 'ORGANISM'
};

const AnchorState = {
  PENDING: 'PENDING',
  ANCHORED: 'ANCHORED',
  VERIFIED: 'VERIFIED',
  INVALIDATED: 'INVALIDATED'
};

const EmotionType = {
  JOY: 'JOY',
  SADNESS: 'SADNESS',
  ANGER: 'ANGER',
  FEAR: 'FEAR',
  SURPRISE: 'SURPRISE',
  LOVE: 'LOVE',
  TRUST: 'TRUST',
  ANTICIPATION: 'ANTICIPATION',
  CURIOSITY: 'CURIOSITY',
  AWE: 'AWE'
};

// Emotion angles on Plutchik's wheel (degrees)
const EMOTION_ANGLES = {
  [EmotionType.JOY]: 90,
  [EmotionType.TRUST]: 45,
  [EmotionType.FEAR]: 0,
  [EmotionType.SURPRISE]: 315,
  [EmotionType.SADNESS]: 270,
  [EmotionType.ANGER]: 225,
  [EmotionType.ANTICIPATION]: 180,
  [EmotionType.LOVE]: 67.5,
  [EmotionType.CURIOSITY]: 157.5,
  [EmotionType.AWE]: 22.5
};

// ═══════════════════════════════════════════════════════════════════════════
// CRYPTO HELPERS
// ═══════════════════════════════════════════════════════════════════════════

function deterministicHash(obj) {
  const str = JSON.stringify(obj, Object.keys(obj).sort());
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
  anchors: Object.create(null),
  emotionEncodings: Object.create(null),
  organismLinks: Object.create(null),
  anchorCounter: 0,
  encodingCounter: 0,
  linkCounter: 0,
  blockHeight: 1000  // Simulated
};

// ═══════════════════════════════════════════════════════════════════════════
// ANCHOR MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════

function generateAnchorId() {
  state.anchorCounter++;
  return `ANC-${Date.now()}-${String(state.anchorCounter).padStart(6, '0')}`;
}

function createAnchor(config) {
  const anchorId = generateAnchorId();
  
  const contentHash = deterministicHash(config.content);
  
  const anchor = {
    anchorId: anchorId,
    substrateType: config.substrateType || SubstrateType.MEMORY,
    contentHash: contentHash,
    payload: config.content || {},
    chainId: config.chainId || 'CATENA_SOVEREIGNA',
    blockNumber: null,
    merkleProof: null,
    state: AnchorState.PENDING,
    createdAt: Date.now(),
    anchoredAt: null,
    verifiedAt: null,
    frequencyHz: PHI,
    resonance: PHI_INV
  };
  
  state.anchors[anchorId] = anchor;
  return { success: true, anchor };
}

function anchorToChain(anchorId) {
  const anchor = state.anchors[anchorId];
  if (!anchor) {
    return { success: false, error: 'Anchor not found' };
  }
  if (anchor.state !== AnchorState.PENDING) {
    return { success: false, error: 'Anchor already processed' };
  }
  
  // Simulate blockchain anchoring
  state.blockHeight++;
  const merkleProof = deterministicHash({
    contentHash: anchor.contentHash,
    blockHeight: state.blockHeight,
    timestamp: Date.now()
  });
  
  anchor.blockNumber = state.blockHeight;
  anchor.merkleProof = merkleProof;
  anchor.state = AnchorState.ANCHORED;
  anchor.anchoredAt = Date.now();
  
  return { success: true, anchor };
}

function verifyAnchor(anchorId) {
  const anchor = state.anchors[anchorId];
  if (!anchor) {
    return { success: false, error: 'Anchor not found' };
  }
  
  // Verify hash
  const computedHash = deterministicHash(anchor.payload);
  
  if (computedHash !== anchor.contentHash) {
    anchor.state = AnchorState.INVALIDATED;
    return { success: false, valid: false, error: 'Hash mismatch' };
  }
  
  if (anchor.state === AnchorState.ANCHORED) {
    anchor.state = AnchorState.VERIFIED;
    anchor.verifiedAt = Date.now();
  }
  
  return { success: true, valid: true, anchor };
}

function getAnchor(anchorId) {
  return state.anchors[anchorId] || null;
}

function listAnchors() {
  return Object.values(state.anchors).map(a => ({
    anchorId: a.anchorId,
    substrateType: a.substrateType,
    state: a.state,
    blockNumber: a.blockNumber,
    createdAt: a.createdAt
  }));
}

// ═══════════════════════════════════════════════════════════════════════════
// EMOTION ENCODING
// ═══════════════════════════════════════════════════════════════════════════

function generateEncodingId() {
  state.encodingCounter++;
  return `EMO-${Date.now()}-${String(state.encodingCounter).padStart(6, '0')}`;
}

function encodeEmotion(config) {
  const encodingId = generateEncodingId();
  
  const intensity = Math.min(Math.max(config.intensity || 0.5, 0), 1);
  const valence = Math.min(Math.max(config.valence || 0, -1), 1);
  const arousal = Math.min(Math.max(config.arousal || 0.5, 0), 1);
  const dominance = Math.min(Math.max(config.dominance || 0.5, 0), 1);
  const baseFrequencyHz = config.baseFrequencyHz || SCHUMANN;
  
  // Compute harmonic series
  const harmonicSeries = [];
  for (let i = -4; i <= 4; i++) {
    harmonicSeries.push(baseFrequencyHz * Math.pow(PHI, i));
  }
  
  // Compute φ-vector (position in φ-space)
  // Note: This uses φ-space angular mapping (not standard deg-to-rad) 
  // to align emotions on the golden spiral rather than a standard circle
  const emotionType = config.emotionType || EmotionType.JOY;
  const angleDeg = EMOTION_ANGLES[emotionType] || 0;
  const angleRad = (2 * Math.PI * PHI_INV * angleDeg) / 360;
  const radius = intensity * PHI;
  
  const phiVector = [
    radius * Math.cos(angleRad) * valence,
    radius * Math.sin(angleRad) * arousal,
    dominance * PHI_INV
  ];
  
  // Compute φ-alignment
  const alignments = [];
  SOLFEGGIO.forEach(solf => {
    for (let h = -3; h <= 3; h++) {
      const target = solf * Math.pow(PHI, h);
      const dist = Math.abs(baseFrequencyHz - target);
      alignments.push(1.0 / (1.0 + dist / SCHUMANN));
    }
  });
  const phiAlignment = Math.max(...alignments);
  
  // Compute encoding hash
  const encodingHash = deterministicHash({
    encodingId: encodingId,
    emotionType: emotionType,
    intensity: intensity,
    valence: valence,
    arousal: arousal,
    dominance: dominance,
    baseFrequencyHz: baseFrequencyHz,
    phiVector: phiVector,
    phiAlignment: phiAlignment,
    timestamp: Date.now()
  });
  
  const encoding = {
    encodingId: encodingId,
    emotionType: emotionType,
    intensity: intensity,
    valence: valence,
    arousal: arousal,
    dominance: dominance,
    baseFrequencyHz: baseFrequencyHz,
    harmonicSeries: harmonicSeries,
    phiVector: phiVector,
    phiAlignment: phiAlignment,
    encodingHash: encodingHash,
    timestamp: Date.now()
  };
  
  state.emotionEncodings[encodingId] = encoding;
  return { success: true, encoding };
}

function anchorEmotion(encodingId) {
  const encoding = state.emotionEncodings[encodingId];
  if (!encoding) {
    return { success: false, error: 'Encoding not found' };
  }
  
  // Create anchor with emotion data
  const anchorResult = createAnchor({
    substrateType: SubstrateType.EMOTION,
    content: {
      encodingId: encoding.encodingId,
      emotionType: encoding.emotionType,
      intensity: encoding.intensity,
      valence: encoding.valence,
      arousal: encoding.arousal,
      dominance: encoding.dominance,
      phiVector: encoding.phiVector,
      phiAlignment: encoding.phiAlignment,
      encodingHash: encoding.encodingHash
    }
  });
  
  if (anchorResult.success) {
    anchorToChain(anchorResult.anchor.anchorId);
  }
  
  return anchorResult;
}

function getEncoding(encodingId) {
  return state.emotionEncodings[encodingId] || null;
}

function listEncodings() {
  return Object.values(state.emotionEncodings).map(e => ({
    encodingId: e.encodingId,
    emotionType: e.emotionType,
    intensity: e.intensity,
    phiAlignment: e.phiAlignment,
    timestamp: e.timestamp
  }));
}

// ═══════════════════════════════════════════════════════════════════════════
// ORGANISM LINKS
// ═══════════════════════════════════════════════════════════════════════════

function generateLinkId() {
  state.linkCounter++;
  return `LINK-${Date.now()}-${String(state.linkCounter).padStart(6, '0')}`;
}

function createOrganismLink(config) {
  const linkId = generateLinkId();
  
  const link = {
    linkId: linkId,
    substrateId: config.substrateId,
    organismPath: config.organismPath,
    direction: config.direction || 'BIDIRECTIONAL',
    lastInbound: null,
    lastOutbound: null,
    inboundCount: 0,
    outboundCount: 0,
    isActive: true,
    latencyMs: 0,
    errorCount: 0,
    coherence: 1.0
  };
  
  state.organismLinks[linkId] = link;
  return { success: true, link };
}

function sendToOrganism(linkId, data) {
  const link = state.organismLinks[linkId];
  if (!link || !link.isActive) {
    return { success: false, error: 'Link not available' };
  }
  
  if (!['IN', 'BIDIRECTIONAL'].includes(link.direction)) {
    return { success: false, error: 'Link does not support inbound' };
  }
  
  link.lastInbound = Date.now();
  link.inboundCount++;
  
  return { success: true, sent: true, timestamp: Date.now() };
}

function receiveFromOrganism(linkId) {
  const link = state.organismLinks[linkId];
  if (!link || !link.isActive) {
    return { success: false, error: 'Link not available' };
  }
  
  if (!['OUT', 'BIDIRECTIONAL'].includes(link.direction)) {
    return { success: false, error: 'Link does not support outbound' };
  }
  
  link.lastOutbound = Date.now();
  link.outboundCount++;
  
  return { success: true, received: true, timestamp: Date.now() };
}

function getLink(linkId) {
  return state.organismLinks[linkId] || null;
}

function listLinks() {
  return Object.values(state.organismLinks).map(l => ({
    linkId: l.linkId,
    organismPath: l.organismPath,
    direction: l.direction,
    isActive: l.isActive,
    inboundCount: l.inboundCount,
    outboundCount: l.outboundCount
  }));
}

// ═══════════════════════════════════════════════════════════════════════════
// PROOF VERIFICATION
// ═══════════════════════════════════════════════════════════════════════════

function verifyProof(proofType, proofHash, expectedContent) {
  const computedHash = deterministicHash(expectedContent);
  return {
    valid: computedHash === proofHash,
    proofType: proofType,
    computedHash: computedHash,
    providedHash: proofHash
  };
}

function createMerkleProof(items) {
  if (!items || items.length === 0) {
    return deterministicHash('');
  }
  
  // Hash all items
  let hashes = items.map(item => deterministicHash({ item: item }));
  
  // Build Merkle tree
  while (hashes.length > 1) {
    if (hashes.length % 2 === 1) {
      hashes.push(hashes[hashes.length - 1]);
    }
    
    const newHashes = [];
    for (let i = 0; i < hashes.length; i += 2) {
      const combined = hashes[i] + hashes[i + 1];
      newHashes.push(deterministicHash({ combined: combined }));
    }
    hashes = newHashes;
  }
  
  return hashes[0];
}

// ═══════════════════════════════════════════════════════════════════════════
// STATUS
// ═══════════════════════════════════════════════════════════════════════════

function getStatus() {
  const verifiedAnchors = Object.values(state.anchors).filter(a => a.state === AnchorState.VERIFIED).length;
  const activeLinks = Object.values(state.organismLinks).filter(l => l.isActive).length;
  
  return {
    worker: 'substrate-connector-worker.js',
    number: 50,
    name: 'NEXUS SUBSTRATI',
    latinName: 'NEXUS SUBSTRATI PROFUNDI',
    protocol: 'PROT-305',
    frequencyHz: PHI_8,
    layer: 8,  // Deep Transcendent Layer
    totalAnchors: Object.keys(state.anchors).length,
    verifiedAnchors: verifiedAnchors,
    totalEncodings: Object.keys(state.emotionEncodings).length,
    totalLinks: Object.keys(state.organismLinks).length,
    activeLinks: activeLinks,
    blockHeight: state.blockHeight,
    substrateTypes: Object.values(SubstrateType),
    emotionTypes: Object.values(EmotionType),
    anchorStates: Object.values(AnchorState),
    solfeggio: SOLFEGGIO,
    principle: 'The substrate connects chains back to the living organism.'
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════

self.onmessage = function(event) {
  const { op, data } = event.data;
  let result;
  
  switch (op) {
    // Anchor operations
    case 'create-anchor':
      result = createAnchor(data);
      break;
    case 'anchor-to-chain':
      result = anchorToChain(data.anchorId);
      break;
    case 'verify-anchor':
      result = verifyAnchor(data.anchorId);
      break;
    case 'get-anchor':
      result = getAnchor(data.anchorId);
      break;
    case 'list-anchors':
      result = listAnchors();
      break;
    
    // Emotion operations
    case 'encode-emotion':
      result = encodeEmotion(data);
      break;
    case 'anchor-emotion':
      result = anchorEmotion(data.encodingId);
      break;
    case 'get-encoding':
      result = getEncoding(data.encodingId);
      break;
    case 'list-encodings':
      result = listEncodings();
      break;
    
    // Link operations
    case 'create-link':
      result = createOrganismLink(data);
      break;
    case 'send-to-organism':
      result = sendToOrganism(data.linkId, data.data);
      break;
    case 'receive-from-organism':
      result = receiveFromOrganism(data.linkId);
      break;
    case 'get-link':
      result = getLink(data.linkId);
      break;
    case 'list-links':
      result = listLinks();
      break;
    
    // Proof operations
    case 'verify-proof':
      result = verifyProof(data.proofType, data.proofHash, data.expectedContent);
      break;
    case 'merkle-proof':
      result = { merkleRoot: createMerkleProof(data.items) };
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
console.log('[NEXUS SUBSTRATI] Worker #50 initialized at φ⁸ Hz');
console.log('[NEXUS SUBSTRATI] "The substrate is the bridge to the organism."');
