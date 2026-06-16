/**
 * ╔══════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                          ║
 * ║              PHANTOM PASSAGE WORKER — INTELLIGENCE TRANSFER CONDUITS                    ║
 * ║           "Transitus Phantasmaticus — Per Viam Invisibilem Ad Cognitionem"              ║
 * ║           (Phantom Passage — Through The Invisible Way To Knowledge)                     ║
 * ║                                                                                          ║
 * ║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                         ║
 * ║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                   ║
 * ║  Worker #63 — PHANTOM PASSAGE SOVEREIGNUS                                                ║
 * ║  Protocol: PROT-387 to PROT-390 — Phantom Passage Infrastructure                        ║
 * ║                                                                                          ║
 * ║  FREQUENCY SIGNATURE: φ¹⁷ = 3571.001 Hz — Passage Layer                                 ║
 * ║  SUBSTRATE LAYER: Layer 6-9 (Connection Layers)                                          ║
 * ║  PRIMITIVE TRACE: FIELD → RELATION → ADDRESS → φ                                        ║
 * ║                                                                                          ║
 * ╚══════════════════════════════════════════════════════════════════════════════════════════╝
 */

'use strict';

// ════════════════════════════════════════════════════════════════════════════════════════════
// FUNDAMENTAL CONSTANTS
// ════════════════════════════════════════════════════════════════════════════════════════════

const PHI = 1.6180339887498948482;
const PHI_17 = Math.pow(PHI, 17); // 3571.001... Hz
const SCHUMANN = 7.83;
const SOLFEGGIO = [174.0, 285.0, 396.0, 417.0, 528.0, 639.0, 741.0, 852.0, 963.0];

const WORKER_CONFIG = {
  id: 'phantom-passage-worker',
  number: 63,
  name: 'TRANSITUS PHANTASMATICUS SOVEREIGNUS',
  latinMotto: 'Per Viam Invisibilem Ad Cognitionem',
  frequency: PHI_17,
  layer: 'Connection Layers (6-9)',
  protocols: ['PROT-387', 'PROT-388', 'PROT-389', 'PROT-390'],
  attribution: 'Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX',
};

// ════════════════════════════════════════════════════════════════════════════════════════════
// PASSAGE TYPES
// ════════════════════════════════════════════════════════════════════════════════════════════

const PASSAGE_TYPES = {
  INTEL: 'intel',       // Intelligence data transfer
  QUERY: 'query',       // Request/response
  SYNC: 'sync',         // State synchronization
  HARVEST: 'harvest',   // Data collection
  DELIVER: 'deliver',   // Output delivery
};

const PASSAGE_STATES = {
  DORMANT: 'dormant',
  OPENING: 'opening',
  ACTIVE: 'active',
  TRANSFERRING: 'transferring',
  CLOSING: 'closing',
  COLLAPSED: 'collapsed',
};

const BOUNDARY_TYPES = {
  INTERNAL: 'internal',
  EXTERNAL: 'external',
  HYBRID: 'hybrid',
};

// ════════════════════════════════════════════════════════════════════════════════════════════
// PASSAGE PAYLOAD
// ════════════════════════════════════════════════════════════════════════════════════════════

function createPayload(data, passageType, sourceId, destinationId = null) {
  const timestamp = Date.now();
  const beat = timestamp % 1000;
  const ring = Math.floor(timestamp / 100000) % 13;
  const frequency = SCHUMANN * SOLFEGGIO[beat % 9] * Math.pow(PHI, ring);
  
  // Generate signature
  const sigData = `${sourceId}:${destinationId}:${beat}:${ring}`;
  const signature = simpleHash(sigData);
  
  return {
    id: crypto.randomUUID?.() || `payload-${timestamp}-${Math.random().toString(36).substr(2, 9)}`,
    passageType,
    data,
    sourceId,
    destinationId,
    timestamp,
    beat,
    ring,
    frequency,
    signature,
    encrypted: false,
    compressionRatio: 1.0,
  };
}

function simpleHash(str) {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    const char = str.charCodeAt(i);
    hash = ((hash << 5) - hash) + char;
    hash = hash & hash;
  }
  return Math.abs(hash).toString(16).padStart(16, '0');
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// PHANTOM PASSAGE
// ════════════════════════════════════════════════════════════════════════════════════════════

class PhantomPassage {
  constructor(passageType, sourceEndpoint, destinationEndpoint = null, boundaryType = BOUNDARY_TYPES.INTERNAL) {
    this.id = crypto.randomUUID?.() || `passage-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
    this.passageType = passageType;
    this.state = PASSAGE_STATES.OPENING;
    this.boundaryType = boundaryType;
    
    const timestamp = Date.now();
    this.creationBeat = timestamp % 1000;
    this.creationRing = Math.floor(timestamp / 100000) % 13;
    this.frequency = SCHUMANN * SOLFEGGIO[this.creationBeat % 9] * Math.pow(PHI, this.creationRing);
    
    this.sourceEndpoint = sourceEndpoint;
    this.destinationEndpoint = destinationEndpoint;
    this.lastActivity = timestamp;
    this.transferCount = 0;
    this.totalBytes = 0;
    this.handlers = new Map();
    
    // Transition to active
    this.state = PASSAGE_STATES.ACTIVE;
  }
  
  transfer(payload) {
    if (this.state !== PASSAGE_STATES.ACTIVE) return false;
    
    this.state = PASSAGE_STATES.TRANSFERRING;
    this.transferCount++;
    this.lastActivity = Date.now();
    
    // Calculate payload size
    if (typeof payload.data === 'string') {
      this.totalBytes += payload.data.length;
    } else if (payload.data instanceof ArrayBuffer) {
      this.totalBytes += payload.data.byteLength;
    }
    
    // Call registered handlers
    const handler = this.handlers.get(payload.passageType);
    if (handler) {
      try {
        handler(payload);
      } catch (e) {
        console.error('Handler error:', e);
      }
    }
    
    this.state = PASSAGE_STATES.ACTIVE;
    return true;
  }
  
  registerHandler(passageType, handler) {
    this.handlers.set(passageType, handler);
  }
  
  close() {
    this.state = PASSAGE_STATES.CLOSING;
    this.handlers.clear();
    this.state = PASSAGE_STATES.COLLAPSED;
  }
  
  get isActive() {
    return this.state === PASSAGE_STATES.ACTIVE;
  }
  
  get ageSeconds() {
    return (Date.now() - (this.creationBeat)) / 1000;
  }
  
  get status() {
    return {
      id: this.id,
      passageType: this.passageType,
      state: this.state,
      boundaryType: this.boundaryType,
      frequency: this.frequency,
      transferCount: this.transferCount,
      totalBytes: this.totalBytes,
    };
  }
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// CLIENT BOUNDARY
// ════════════════════════════════════════════════════════════════════════════════════════════

class ClientBoundary {
  constructor(boundaryId) {
    this.boundaryId = boundaryId;
    this.passages = new Map();
    this.clientSessions = new Map();
    this.creationTime = Date.now();
    this.totalTransfers = 0;
  }
  
  openClientPassage(clientId, passageType) {
    const passage = new PhantomPassage(
      passageType,
      `client:${clientId}`,
      `boundary:${this.boundaryId}`,
      BOUNDARY_TYPES.EXTERNAL
    );
    
    this.passages.set(passage.id, passage);
    
    // Track client session
    if (!this.clientSessions.has(clientId)) {
      this.clientSessions.set(clientId, {
        passages: [],
        firstContact: Date.now(),
        lastActivity: Date.now(),
      });
    }
    
    const session = this.clientSessions.get(clientId);
    session.passages.push(passage.id);
    session.lastActivity = Date.now();
    
    return passage;
  }
  
  transferToClient(passageId, data) {
    const passage = this.passages.get(passageId);
    if (!passage) return false;
    
    const payload = createPayload(
      data,
      PASSAGE_TYPES.DELIVER,
      this.boundaryId,
      passage.sourceEndpoint
    );
    
    const success = passage.transfer(payload);
    if (success) this.totalTransfers++;
    
    return success;
  }
  
  receiveFromClient(passageId, data) {
    const passage = this.passages.get(passageId);
    if (!passage) return null;
    
    const payload = createPayload(
      data,
      PASSAGE_TYPES.HARVEST,
      passage.sourceEndpoint,
      this.boundaryId
    );
    
    if (passage.transfer(payload)) {
      this.totalTransfers++;
      return payload;
    }
    
    return null;
  }
  
  closeClientPassage(passageId) {
    const passage = this.passages.get(passageId);
    if (!passage) return false;
    
    passage.close();
    this.passages.delete(passageId);
    return true;
  }
  
  get activePassages() {
    return [...this.passages.values()].filter(p => p.isActive).length;
  }
  
  get status() {
    return {
      boundaryId: this.boundaryId,
      totalPassages: this.passages.size,
      activePassages: this.activePassages,
      totalClients: this.clientSessions.size,
      totalTransfers: this.totalTransfers,
      uptimeSeconds: (Date.now() - this.creationTime) / 1000,
    };
  }
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// PASSAGE ROUTER
// ════════════════════════════════════════════════════════════════════════════════════════════

class PassageRouter {
  constructor() {
    this.routes = new Map();
    this.passages = new Map();
    this.boundaries = new Map();
  }
  
  registerPassage(passage) {
    this.passages.set(passage.id, passage);
    
    if (passage.destinationEndpoint) {
      if (!this.routes.has(passage.destinationEndpoint)) {
        this.routes.set(passage.destinationEndpoint, []);
      }
      this.routes.get(passage.destinationEndpoint).push(passage.id);
    }
  }
  
  registerBoundary(boundary) {
    this.boundaries.set(boundary.boundaryId, boundary);
  }
  
  route(payload) {
    const destination = payload.destinationId;
    if (!destination || !this.routes.has(destination)) return null;
    
    let bestPassage = null;
    let bestAlignment = Infinity;
    
    for (const passageId of this.routes.get(destination)) {
      const passage = this.passages.get(passageId);
      if (passage?.isActive) {
        const alignment = Math.abs(passage.frequency - payload.frequency);
        if (alignment < bestAlignment) {
          bestAlignment = alignment;
          bestPassage = passage;
        }
      }
    }
    
    return bestPassage;
  }
  
  send(payload) {
    const passage = this.route(payload);
    if (passage) return passage.transfer(payload);
    return false;
  }
  
  get status() {
    return {
      totalRoutes: this.routes.size,
      totalPassages: this.passages.size,
      totalBoundaries: this.boundaries.size,
      activePassages: [...this.passages.values()].filter(p => p.isActive).length,
    };
  }
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// GLOBAL INSTANCES
// ════════════════════════════════════════════════════════════════════════════════════════════

const router = new PassageRouter();
const defaultBoundary = new ClientBoundary('default');
router.registerBoundary(defaultBoundary);

// ════════════════════════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ════════════════════════════════════════════════════════════════════════════════════════════

function handleMessage(event) {
  const { type, payload, requestId } = event.data || {};
  
  let response = { requestId, success: false };
  
  try {
    switch (type) {
      case 'passage-open': {
        const passage = new PhantomPassage(
          payload.passageType || PASSAGE_TYPES.INTEL,
          payload.sourceEndpoint,
          payload.destinationEndpoint,
          payload.boundaryType || BOUNDARY_TYPES.INTERNAL
        );
        router.registerPassage(passage);
        response = {
          requestId,
          success: true,
          passageId: passage.id,
          frequency: passage.frequency,
          ...passage.status,
        };
        break;
      }
      
      case 'passage-transfer': {
        const passagePayload = createPayload(
          payload.data,
          payload.passageType || PASSAGE_TYPES.INTEL,
          payload.sourceId,
          payload.destinationId
        );
        const success = router.send(passagePayload);
        response = {
          requestId,
          success,
          payloadId: passagePayload.id,
        };
        break;
      }
      
      case 'passage-close': {
        const passage = router.passages.get(payload.passageId);
        if (passage) {
          passage.close();
          router.passages.delete(payload.passageId);
          response = { requestId, success: true };
        }
        break;
      }
      
      case 'passage-status': {
        const passage = router.passages.get(payload.passageId);
        if (passage) {
          response = {
            requestId,
            success: true,
            ...passage.status,
          };
        }
        break;
      }
      
      case 'client-open': {
        const passage = defaultBoundary.openClientPassage(
          payload.clientId,
          payload.passageType || PASSAGE_TYPES.INTEL
        );
        response = {
          requestId,
          success: true,
          passageId: passage.id,
          ...passage.status,
        };
        break;
      }
      
      case 'client-send': {
        const success = defaultBoundary.transferToClient(payload.passageId, payload.data);
        response = { requestId, success };
        break;
      }
      
      case 'client-receive': {
        const result = defaultBoundary.receiveFromClient(payload.passageId, payload.data);
        response = {
          requestId,
          success: result !== null,
          payload: result,
        };
        break;
      }
      
      case 'router-status': {
        response = {
          requestId,
          success: true,
          router: router.status,
          boundary: defaultBoundary.status,
          workerConfig: WORKER_CONFIG,
        };
        break;
      }
      
      default:
        response = {
          requestId,
          success: false,
          error: `Unknown message type: ${type}`,
        };
    }
  } catch (error) {
    response = {
      requestId,
      success: false,
      error: error.message,
    };
  }
  
  self.postMessage(response);
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// WORKER INITIALIZATION
// ════════════════════════════════════════════════════════════════════════════════════════════

self.onmessage = handleMessage;

// Announce worker ready
self.postMessage({
  type: 'worker-ready',
  worker: WORKER_CONFIG,
  passageTypes: PASSAGE_TYPES,
  boundaryTypes: BOUNDARY_TYPES,
  timestamp: new Date().toISOString(),
});

console.log(`🚀 ${WORKER_CONFIG.name} initialized at ${WORKER_CONFIG.frequency.toFixed(3)} Hz`);
