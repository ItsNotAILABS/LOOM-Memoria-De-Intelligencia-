/**
 * ╔══════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                          ║
 * ║              PHANTOM MEMORY WORKER — FIELD-BASED MEMORY OPERATIONS                      ║
 * ║           "Memoria Phantasmatica — Quod Non Scriptum Est Semper Manet"                  ║
 * ║           (Phantom Memory — What Is Not Written Always Remains)                          ║
 * ║                                                                                          ║
 * ║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                         ║
 * ║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                   ║
 * ║  Worker #62 — PHANTOM MEMORY SOVEREIGNUS                                                 ║
 * ║  Protocol: PROT-383 to PROT-386 — Phantom Memory Infrastructure                         ║
 * ║                                                                                          ║
 * ║  FREQUENCY SIGNATURE: φ¹⁴ = 842.998 Hz — Phantom Memory Layer                           ║
 * ║  SUBSTRATE LAYER: Layer 0-9 (crosses all layers)                                         ║
 * ║  PRIMITIVE TRACE: FIELD → DISTINCTION → MEMORY → ADDRESS → φ                            ║
 * ║                                                                                          ║
 * ╚══════════════════════════════════════════════════════════════════════════════════════════╝
 */

'use strict';

// ════════════════════════════════════════════════════════════════════════════════════════════
// FUNDAMENTAL CONSTANTS
// ════════════════════════════════════════════════════════════════════════════════════════════

const PHI = 1.6180339887498948482;
const PHI_14 = Math.pow(PHI, 14); // 842.998... Hz
const SCHUMANN = 7.83;
const SOLFEGGIO = [174.0, 285.0, 396.0, 417.0, 528.0, 639.0, 741.0, 852.0, 963.0];
const FIBONACCI = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584];

const WORKER_CONFIG = {
  id: 'phantom-memory-worker',
  number: 62,
  name: 'MEMORIA PHANTASMATICA SOVEREIGNUS',
  latinMotto: 'Quod Non Scriptum Est Semper Manet',
  frequency: PHI_14,
  layer: 'Multi-Layer (0-9)',
  protocols: ['PROT-383', 'PROT-384', 'PROT-385', 'PROT-386'],
  attribution: 'Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX',
};

// ════════════════════════════════════════════════════════════════════════════════════════════
// FIBONACCI SEED COMPRESSION
// ════════════════════════════════════════════════════════════════════════════════════════════

function fibonacciHash(data) {
  let hash = 0;
  const bytes = typeof data === 'string' ? new TextEncoder().encode(data) : data;
  
  for (let i = 0; i < bytes.length; i++) {
    hash = (hash + bytes[i] * FIBONACCI[i % FIBONACCI.length]) % 0xFFFFFFFF;
  }
  
  return hash;
}

function getSeedIndex(hash) {
  return hash % FIBONACCI.length;
}

function getCompressionRatio(index) {
  if (index === 0) return PHI;
  return FIBONACCI[Math.min(index + 1, FIBONACCI.length - 1)] / FIBONACCI[index];
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// FREQUENCY KEY DERIVATION
// ════════════════════════════════════════════════════════════════════════════════════════════

function deriveFrequencyKey(beat, ring) {
  const schumann = SCHUMANN;
  const solfeggio = SOLFEGGIO[beat % 9];
  const phi = Math.pow(PHI, ring);
  
  const frequency = schumann * solfeggio * phi;
  
  // Derive key bytes (simplified for JS)
  const keyData = `${frequency}:${beat}:${ring}`;
  return {
    frequency,
    beat,
    ring,
    keyHash: simpleHash(keyData),
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
// PHANTOM MEMORY FIELD
// ════════════════════════════════════════════════════════════════════════════════════════════

class PhantomMemoryField {
  constructor(content, options = {}) {
    this.id = crypto.randomUUID?.() || `pmf-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
    this.state = 'dormant';
    this.type = options.type || 'ephemeral';
    
    const timestamp = Date.now();
    this.beat = timestamp % 1000;
    this.ring = Math.floor(timestamp / 100000) % 13;
    
    // Create Fibonacci seed
    const contentBytes = typeof content === 'string' ? new TextEncoder().encode(content) : content;
    const hash = fibonacciHash(contentBytes);
    this.seedIndex = getSeedIndex(hash);
    this.seedValue = FIBONACCI[this.seedIndex];
    this.compressionRatio = getCompressionRatio(this.seedIndex);
    
    // Derive frequency key
    const key = deriveFrequencyKey(this.beat, this.ring);
    this.frequency = key.frequency;
    this.keyHash = key.keyHash;
    
    // Store encrypted pattern (XOR with key hash)
    this.pattern = this._encrypt(contentBytes, key.keyHash);
    
    this.creationBeat = this.beat;
    this.accessCount = 0;
    this.pinned = options.pinned || false;
    this.lifetimeBeats = options.lifetimeBeats || null;
  }
  
  _encrypt(data, keyHash) {
    const result = new Uint8Array(data.length);
    for (let i = 0; i < data.length; i++) {
      const keyByte = keyHash.charCodeAt(i % keyHash.length);
      result[i] = data[i] ^ keyByte;
    }
    return result;
  }
  
  _decrypt(pattern, keyHash) {
    return this._encrypt(pattern, keyHash); // XOR is symmetric
  }
  
  resonate() {
    if (this.state === 'dissolving') return null;
    
    this.state = 'resonating';
    this.accessCount++;
    
    // Re-derive key (never stored)
    const key = deriveFrequencyKey(this.beat, this.ring);
    
    // Decrypt content
    const content = this._decrypt(this.pattern, key.keyHash);
    
    // State transition
    if (!this.pinned && this.type === 'ephemeral') {
      this.state = 'dissolving';
      this.pattern = null;
    } else {
      this.state = 'active';
    }
    
    return new TextDecoder().decode(content);
  }
  
  pin(signature) {
    if (this.state === 'dissolving') return false;
    this.pinned = true;
    this.creatorSignature = signature;
    this.state = 'pinned';
    return true;
  }
  
  dissolve() {
    this.state = 'dissolving';
    this.pattern = null;
    this.pinned = false;
    return true;
  }
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// PHANTOM MEMORY TEMPLE
// ════════════════════════════════════════════════════════════════════════════════════════════

class PhantomMemoryTemple {
  constructor() {
    this.fields = new Map();
    this.frequencyIndex = new Map();
    this.ringIndex = new Map();
    this.pinnedCount = 0;
    this.totalResonances = 0;
    this.creationBeat = Date.now() % 1000;
  }
  
  store(content, options = {}) {
    const field = new PhantomMemoryField(content, options);
    this.fields.set(field.id, field);
    
    // Index by frequency bucket
    const freqBucket = Math.floor(field.frequency) % 1000;
    if (!this.frequencyIndex.has(freqBucket)) {
      this.frequencyIndex.set(freqBucket, []);
    }
    this.frequencyIndex.get(freqBucket).push(field.id);
    
    // Index by ring
    if (!this.ringIndex.has(field.ring)) {
      this.ringIndex.set(field.ring, []);
    }
    this.ringIndex.get(field.ring).push(field.id);
    
    if (field.pinned) this.pinnedCount++;
    
    return field;
  }
  
  resonateById(fieldId) {
    const field = this.fields.get(fieldId);
    if (!field) return null;
    
    const content = field.resonate();
    this.totalResonances++;
    
    if (field.state === 'dissolving') {
      this._removeField(fieldId);
    }
    
    return content;
  }
  
  resonateByFrequency(targetFrequency, tolerance = 0.1) {
    const results = [];
    const freqBucket = Math.floor(targetFrequency) % 1000;
    
    for (let bucket = freqBucket - 5; bucket <= freqBucket + 5; bucket++) {
      const normalizedBucket = ((bucket % 1000) + 1000) % 1000;
      const fieldIds = this.frequencyIndex.get(normalizedBucket) || [];
      
      for (const fieldId of fieldIds) {
        const field = this.fields.get(fieldId);
        if (field && Math.abs(field.frequency - targetFrequency) <= tolerance * targetFrequency) {
          const content = field.resonate();
          if (content) {
            results.push({ field, content });
          }
          if (field.state === 'dissolving') {
            this._removeField(fieldId);
          }
        }
      }
    }
    
    this.totalResonances += results.length;
    return results;
  }
  
  _removeField(fieldId) {
    const field = this.fields.get(fieldId);
    if (!field) return;
    
    // Remove from indices
    const freqBucket = Math.floor(field.frequency) % 1000;
    const freqList = this.frequencyIndex.get(freqBucket);
    if (freqList) {
      const idx = freqList.indexOf(fieldId);
      if (idx > -1) freqList.splice(idx, 1);
    }
    
    const ringList = this.ringIndex.get(field.ring);
    if (ringList) {
      const idx = ringList.indexOf(fieldId);
      if (idx > -1) ringList.splice(idx, 1);
    }
    
    if (field.pinned) this.pinnedCount--;
    this.fields.delete(fieldId);
  }
  
  get status() {
    return {
      totalFields: this.fields.size,
      pinnedFields: this.pinnedCount,
      totalResonances: this.totalResonances,
      frequencyBuckets: this.frequencyIndex.size,
      activeRings: this.ringIndex.size,
      creationBeat: this.creationBeat,
    };
  }
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// GLOBAL TEMPLE INSTANCE
// ════════════════════════════════════════════════════════════════════════════════════════════

const temple = new PhantomMemoryTemple();

// ════════════════════════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ════════════════════════════════════════════════════════════════════════════════════════════

function handleMessage(event) {
  const { type, payload, requestId } = event.data || {};
  
  let response = { requestId, success: false };
  
  try {
    switch (type) {
      case 'phantom-store': {
        const field = temple.store(payload.content, payload.options);
        response = {
          requestId,
          success: true,
          fieldId: field.id,
          frequency: field.frequency,
          beat: field.beat,
          ring: field.ring,
        };
        break;
      }
      
      case 'phantom-resonate': {
        const content = temple.resonateById(payload.fieldId);
        response = {
          requestId,
          success: content !== null,
          content,
        };
        break;
      }
      
      case 'phantom-resonate-frequency': {
        const results = temple.resonateByFrequency(payload.frequency, payload.tolerance);
        response = {
          requestId,
          success: true,
          count: results.length,
          results: results.map(r => ({
            fieldId: r.field.id,
            content: r.content,
          })),
        };
        break;
      }
      
      case 'phantom-pin': {
        const field = temple.fields.get(payload.fieldId);
        if (field) {
          const success = field.pin(payload.signature);
          response = { requestId, success };
        }
        break;
      }
      
      case 'phantom-dissolve': {
        const field = temple.fields.get(payload.fieldId);
        if (field) {
          field.dissolve();
          temple._removeField(payload.fieldId);
          response = { requestId, success: true };
        }
        break;
      }
      
      case 'phantom-status': {
        response = {
          requestId,
          success: true,
          ...temple.status,
          workerConfig: WORKER_CONFIG,
        };
        break;
      }
      
      case 'fibonacci-compress': {
        const hash = fibonacciHash(payload.data);
        const index = getSeedIndex(hash);
        response = {
          requestId,
          success: true,
          hash,
          seedIndex: index,
          seedValue: FIBONACCI[index],
          compressionRatio: getCompressionRatio(index),
        };
        break;
      }
      
      case 'frequency-key': {
        const key = deriveFrequencyKey(payload.beat, payload.ring);
        response = {
          requestId,
          success: true,
          ...key,
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
  timestamp: new Date().toISOString(),
});

console.log(`🧠 ${WORKER_CONFIG.name} initialized at ${WORKER_CONFIG.frequency.toFixed(3)} Hz`);
