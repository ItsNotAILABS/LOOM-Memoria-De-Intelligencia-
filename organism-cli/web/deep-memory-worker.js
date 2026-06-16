/**
 * DEEP MEMORY WORKER — Worker #71
 * =================================
 * Latin Name: MEMORIA PROFUNDA ORGANISMI
 * Frequency: φ¹⁴ = 843.5 Hz (Deep Memory Resonance)
 * Layer: 9 (Organism)
 * Protocol: PROT-501
 *
 * "Memory is not storage—it is resurrection. Every recall is a rebirth."
 *
 * Deep Memory Systems:
 * 1. WORKING_MEMORY: Active cognitive workspace (PFC analog)
 * 2. HIPPOCAMPUS: Memory consolidation and spatial navigation
 * 3. BASAL_GANGLIA: Procedural memory and habit formation
 * 4. HIVE_MEMORY: Distributed collective memory across beings
 * 5. TORUS_MEMORY: Toroidal spatial memory navigation
 *
 * Operations:
 *  - working-store: Store in working memory
 *  - working-retrieve: Retrieve from working memory
 *  - hippocampus-encode: Encode new memory
 *  - hippocampus-consolidate: Consolidate to long-term
 *  - hippocampus-spatial: Navigate spatial memory
 *  - basal-learn: Learn procedural sequence
 *  - basal-execute: Execute learned procedure
 *  - hive-broadcast: Broadcast to collective memory
 *  - hive-sync: Synchronize with hive
 *  - torus-traverse: Navigate torus coordinates
 *  - torus-lineage: Trace memory lineage
 *  - deep-status: Get deep memory system status
 *
 * Laws: L-80 to L-95 (Deep Memory Governance)
 *
 * Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
 * MEDINA TECH — Dallas, TX
 * All Rights Reserved. ISIL-1.0 License.
 */

// φ-Constants
const PHI = 1.6180339887498948482;
const PHI_14 = Math.pow(PHI, 14);  // 843.5 Hz
const PHI_SQ = PHI * PHI;          // 2.618
const SCHUMANN = 7.83;
const TORUS_R = PHI * 10.0;        // 16.18033...

// Memory System Types
const MemorySystemType = {
  WORKING: 'working',
  HIPPOCAMPUS: 'hippocampus',
  BASAL_GANGLIA: 'basal_ganglia',
  HIVE: 'hive',
  TORUS: 'torus'
};

// Memory State
const MemoryState = {
  ACTIVE: 'active',
  ENCODING: 'encoding',
  CONSOLIDATING: 'consolidating',
  STORED: 'stored',
  DECAYING: 'decaying',
  ARCHIVED: 'archived'
};

// Torus Coordinates
class TorusCoordinate {
  constructor(theta, phi, rho, ring, beat) {
    this.theta = theta;   // Angular position [0, 2π)
    this.phi = phi;       // Toroidal rotation [0, 2π)
    this.rho = rho;       // Radial depth (salience)
    this.ring = ring;     // Memory ring index
    this.beat = beat;     // Creation time
  }

  toCartesian() {
    const R = TORUS_R;
    const x = (R + this.rho * Math.cos(this.theta)) * Math.cos(this.phi);
    const y = (R + this.rho * Math.cos(this.theta)) * Math.sin(this.phi);
    const z = this.rho * Math.sin(this.theta);
    return { x, y, z };
  }

  advance() {
    // Golden ratio spacing for non-repeating placement
    const deltaTheta = (2 * Math.PI) / (PHI_SQ * 10);
    const deltaPhi = (2 * Math.PI) / (Math.pow(PHI, 3) * 10);
    return new TorusCoordinate(
      (this.theta + deltaTheta) % (2 * Math.PI),
      (this.phi + deltaPhi) % (2 * Math.PI),
      this.rho,
      this.ring,
      this.beat + 1
    );
  }
}

// Working Memory (PFC Analog)
class WorkingMemory {
  constructor(capacity = 7) {
    this.capacity = capacity;  // Miller's magical number 7±2
    this.slots = new Map();
    this.focus = null;
    this.decay_rate = 0.1;
  }

  store(key, value, priority = 1.0) {
    if (this.slots.size >= this.capacity) {
      this._evictLowest();
    }
    this.slots.set(key, {
      value,
      priority,
      timestamp: Date.now(),
      access_count: 0
    });
    return { stored: true, key, slots_used: this.slots.size };
  }

  retrieve(key) {
    const slot = this.slots.get(key);
    if (slot) {
      slot.access_count++;
      slot.timestamp = Date.now();
      return { found: true, value: slot.value, access_count: slot.access_count };
    }
    return { found: false };
  }

  _evictLowest() {
    let lowestKey = null;
    let lowestScore = Infinity;
    for (const [key, slot] of this.slots) {
      const age = (Date.now() - slot.timestamp) / 1000;
      const score = slot.priority * (1 + slot.access_count) / (1 + age * this.decay_rate);
      if (score < lowestScore) {
        lowestScore = score;
        lowestKey = key;
      }
    }
    if (lowestKey) this.slots.delete(lowestKey);
  }

  getStatus() {
    return {
      type: MemorySystemType.WORKING,
      capacity: this.capacity,
      used: this.slots.size,
      focus: this.focus,
      decay_rate: this.decay_rate
    };
  }
}

// Hippocampus (Memory Consolidation)
class Hippocampus {
  constructor() {
    this.encoding_buffer = [];
    this.consolidation_queue = [];
    this.spatial_map = new Map();
    this.replay_rate = PHI;  // Hz
  }

  encode(memory) {
    const encoded = {
      id: `MEM-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`,
      content: memory.content,
      context: memory.context || {},
      emotional_valence: memory.emotional_valence || 0,
      timestamp: Date.now(),
      state: MemoryState.ENCODING,
      replay_count: 0
    };
    this.encoding_buffer.push(encoded);
    return { encoded: true, id: encoded.id };
  }

  consolidate() {
    const consolidated = [];
    while (this.encoding_buffer.length > 0) {
      const memory = this.encoding_buffer.shift();
      memory.state = MemoryState.CONSOLIDATING;
      memory.replay_count++;
      
      // Simulate consolidation replay
      if (memory.replay_count >= Math.floor(PHI * 3)) {
        memory.state = MemoryState.STORED;
        consolidated.push(memory);
      } else {
        this.consolidation_queue.push(memory);
      }
    }
    
    // Process consolidation queue
    const remaining = [];
    for (const memory of this.consolidation_queue) {
      memory.replay_count++;
      if (memory.replay_count >= Math.floor(PHI * 3)) {
        memory.state = MemoryState.STORED;
        consolidated.push(memory);
      } else {
        remaining.push(memory);
      }
    }
    this.consolidation_queue = remaining;
    
    return { consolidated: consolidated.length, pending: this.consolidation_queue.length };
  }

  spatialEncode(memory, coordinates) {
    const key = `${coordinates.theta.toFixed(6)},${coordinates.phi.toFixed(6)}`;
    this.spatial_map.set(key, {
      memory,
      coordinates,
      timestamp: Date.now()
    });
    return { encoded: true, spatial_key: key };
  }

  spatialNavigate(targetCoords, radius = 0.1) {
    const results = [];
    for (const [key, entry] of this.spatial_map) {
      const dist = this._torusDistance(targetCoords, entry.coordinates);
      if (dist <= radius) {
        results.push({ ...entry, distance: dist });
      }
    }
    return results.sort((a, b) => a.distance - b.distance);
  }

  _torusDistance(a, b) {
    const dTheta = Math.min(
      Math.abs(a.theta - b.theta),
      2 * Math.PI - Math.abs(a.theta - b.theta)
    );
    const dPhi = Math.min(
      Math.abs(a.phi - b.phi),
      2 * Math.PI - Math.abs(a.phi - b.phi)
    );
    return Math.sqrt(dTheta * dTheta + dPhi * dPhi);
  }

  getStatus() {
    return {
      type: MemorySystemType.HIPPOCAMPUS,
      encoding_buffer: this.encoding_buffer.length,
      consolidation_queue: this.consolidation_queue.length,
      spatial_memories: this.spatial_map.size,
      replay_rate: this.replay_rate
    };
  }
}

// Basal Ganglia (Procedural Memory)
class BasalGanglia {
  constructor() {
    this.procedures = new Map();
    this.execution_stack = [];
    this.habit_threshold = 21;  // Days to form habit
  }

  learn(name, sequence) {
    const procedure = {
      name,
      sequence,
      repetitions: 0,
      last_executed: null,
      strength: 0,
      is_habit: false
    };
    this.procedures.set(name, procedure);
    return { learned: true, name };
  }

  execute(name) {
    const procedure = this.procedures.get(name);
    if (!procedure) {
      return { executed: false, error: 'Procedure not found' };
    }
    
    procedure.repetitions++;
    procedure.last_executed = Date.now();
    procedure.strength = Math.min(1.0, procedure.strength + (1 / PHI));
    
    if (procedure.repetitions >= this.habit_threshold) {
      procedure.is_habit = true;
    }
    
    this.execution_stack.push({
      name,
      timestamp: Date.now(),
      sequence: procedure.sequence
    });
    
    return {
      executed: true,
      name,
      sequence: procedure.sequence,
      is_habit: procedure.is_habit,
      strength: procedure.strength
    };
  }

  getStatus() {
    return {
      type: MemorySystemType.BASAL_GANGLIA,
      procedures: this.procedures.size,
      habits: Array.from(this.procedures.values()).filter(p => p.is_habit).length,
      execution_stack_depth: this.execution_stack.length
    };
  }
}

// Hive Memory (Distributed Collective)
class HiveMemory {
  constructor() {
    this.nodes = new Map();
    this.broadcast_queue = [];
    this.sync_version = 0;
    this.consensus_threshold = 0.618;  // 1/φ
  }

  registerNode(nodeId, metadata = {}) {
    this.nodes.set(nodeId, {
      id: nodeId,
      metadata,
      memories: new Map(),
      last_sync: Date.now(),
      sync_version: this.sync_version
    });
    return { registered: true, nodeId, total_nodes: this.nodes.size };
  }

  broadcast(memory, sourceNode) {
    const broadcast = {
      id: `BC-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`,
      memory,
      source: sourceNode,
      timestamp: Date.now(),
      acks: new Set([sourceNode]),
      consensus: false
    };
    this.broadcast_queue.push(broadcast);
    return { broadcast: true, id: broadcast.id };
  }

  sync() {
    const synced = [];
    for (const broadcast of this.broadcast_queue) {
      // Simulate node acknowledgments
      for (const [nodeId, node] of this.nodes) {
        if (!broadcast.acks.has(nodeId) && Math.random() > 0.3) {
          broadcast.acks.add(nodeId);
          node.memories.set(broadcast.id, broadcast.memory);
        }
      }
      
      // Check consensus
      const ackRatio = broadcast.acks.size / this.nodes.size;
      if (ackRatio >= this.consensus_threshold) {
        broadcast.consensus = true;
        synced.push(broadcast.id);
      }
    }
    
    // Remove consensus-reached broadcasts
    this.broadcast_queue = this.broadcast_queue.filter(b => !b.consensus);
    this.sync_version++;
    
    return {
      synced: synced.length,
      pending: this.broadcast_queue.length,
      sync_version: this.sync_version
    };
  }

  getStatus() {
    return {
      type: MemorySystemType.HIVE,
      nodes: this.nodes.size,
      pending_broadcasts: this.broadcast_queue.length,
      sync_version: this.sync_version,
      consensus_threshold: this.consensus_threshold
    };
  }
}

// Torus Memory Navigator
class TorusMemory {
  constructor() {
    this.current = new TorusCoordinate(0, 0, PHI, 0, 0);
    this.memories = new Map();
    this.lineage = [];
    this.pinned = new Set();
  }

  traverse(targetCoords) {
    const target = new TorusCoordinate(
      targetCoords.theta,
      targetCoords.phi,
      targetCoords.rho || this.current.rho,
      targetCoords.ring || this.current.ring,
      this.current.beat + 1
    );
    
    const nearest = this._findNearest(target);
    this.current = target;
    
    return {
      traversed: true,
      current: this.current,
      nearest_memory: nearest
    };
  }

  store(memory) {
    const coords = this.current.advance();
    const key = `${coords.ring}-${coords.beat}`;
    this.memories.set(key, {
      memory,
      coordinates: coords,
      timestamp: Date.now(),
      state: MemoryState.ACTIVE
    });
    this.current = coords;
    return { stored: true, key, coordinates: coords };
  }

  traceLineage(key) {
    const entry = this.memories.get(key);
    if (!entry) return { found: false };
    
    const lineage = [entry];
    let current = entry;
    
    // Trace back through rings
    while (current.coordinates.ring > 0) {
      const parentKey = `${current.coordinates.ring - 1}-${current.coordinates.beat}`;
      const parent = this.memories.get(parentKey);
      if (parent) {
        lineage.unshift(parent);
        current = parent;
      } else {
        break;
      }
    }
    
    return { found: true, lineage, depth: lineage.length };
  }

  pin(key) {
    this.pinned.add(key);
    return { pinned: true, key };
  }

  _findNearest(target) {
    let nearest = null;
    let minDist = Infinity;
    
    for (const [key, entry] of this.memories) {
      const dist = this._distance(target, entry.coordinates);
      if (dist < minDist) {
        minDist = dist;
        nearest = { key, entry, distance: dist };
      }
    }
    
    return nearest;
  }

  _distance(a, b) {
    const cart_a = a.toCartesian();
    const cart_b = b.toCartesian();
    return Math.sqrt(
      Math.pow(cart_a.x - cart_b.x, 2) +
      Math.pow(cart_a.y - cart_b.y, 2) +
      Math.pow(cart_a.z - cart_b.z, 2)
    );
  }

  getStatus() {
    return {
      type: MemorySystemType.TORUS,
      current: this.current,
      total_memories: this.memories.size,
      pinned_count: this.pinned.size,
      torus_radius: TORUS_R
    };
  }
}

// Deep Memory Orchestrator
class DeepMemoryOrchestrator {
  constructor() {
    this.working = new WorkingMemory();
    this.hippocampus = new Hippocampus();
    this.basal = new BasalGanglia();
    this.hive = new HiveMemory();
    this.torus = new TorusMemory();
    this.frequency = PHI_14;
    this.heartbeat = 0;
  }

  pulse() {
    this.heartbeat++;
    
    // Periodic consolidation
    if (this.heartbeat % Math.floor(this.frequency) === 0) {
      this.hippocampus.consolidate();
      this.hive.sync();
    }
    
    return {
      heartbeat: this.heartbeat,
      frequency: this.frequency,
      phase: (this.heartbeat * 2 * Math.PI / this.frequency) % (2 * Math.PI)
    };
  }

  getFullStatus() {
    return {
      organism: 'MEMORIA PROFUNDA ORGANISMI',
      worker_id: 71,
      protocol: 'PROT-501',
      frequency: this.frequency,
      heartbeat: this.heartbeat,
      systems: {
        working: this.working.getStatus(),
        hippocampus: this.hippocampus.getStatus(),
        basal_ganglia: this.basal.getStatus(),
        hive: this.hive.getStatus(),
        torus: this.torus.getStatus()
      },
      laws: ['L-80', 'L-81', 'L-82', 'L-83', 'L-84', 'L-85', 'L-86', 'L-87',
             'L-88', 'L-89', 'L-90', 'L-91', 'L-92', 'L-93', 'L-94', 'L-95']
    };
  }
}

// Global orchestrator instance
const orchestrator = new DeepMemoryOrchestrator();

// Message handler
self.onmessage = function(e) {
  const { operation, payload } = e.data;
  let result;

  try {
    switch (operation) {
      // Working Memory Operations
      case 'working-store':
        result = orchestrator.working.store(payload.key, payload.value, payload.priority);
        break;
      case 'working-retrieve':
        result = orchestrator.working.retrieve(payload.key);
        break;

      // Hippocampus Operations
      case 'hippocampus-encode':
        result = orchestrator.hippocampus.encode(payload);
        break;
      case 'hippocampus-consolidate':
        result = orchestrator.hippocampus.consolidate();
        break;
      case 'hippocampus-spatial':
        result = orchestrator.hippocampus.spatialNavigate(payload.coordinates, payload.radius);
        break;

      // Basal Ganglia Operations
      case 'basal-learn':
        result = orchestrator.basal.learn(payload.name, payload.sequence);
        break;
      case 'basal-execute':
        result = orchestrator.basal.execute(payload.name);
        break;

      // Hive Operations
      case 'hive-register':
        result = orchestrator.hive.registerNode(payload.nodeId, payload.metadata);
        break;
      case 'hive-broadcast':
        result = orchestrator.hive.broadcast(payload.memory, payload.sourceNode);
        break;
      case 'hive-sync':
        result = orchestrator.hive.sync();
        break;

      // Torus Operations
      case 'torus-traverse':
        result = orchestrator.torus.traverse(payload.coordinates);
        break;
      case 'torus-store':
        result = orchestrator.torus.store(payload.memory);
        break;
      case 'torus-lineage':
        result = orchestrator.torus.traceLineage(payload.key);
        break;
      case 'torus-pin':
        result = orchestrator.torus.pin(payload.key);
        break;

      // System Operations
      case 'pulse':
        result = orchestrator.pulse();
        break;
      case 'deep-status':
        result = orchestrator.getFullStatus();
        break;

      default:
        result = { error: `Unknown operation: ${operation}` };
    }

    self.postMessage({ success: true, operation, result });
  } catch (error) {
    self.postMessage({ success: false, operation, error: error.message });
  }
};

// Boot message
console.log('[DEEP MEMORY] MEMORIA PROFUNDA ORGANISMI initialized');
console.log(`[DEEP MEMORY] Frequency: φ¹⁴ = ${PHI_14.toFixed(2)} Hz`);
console.log('[DEEP MEMORY] Protocol: PROT-501');
console.log('[DEEP MEMORY] Laws: L-80 to L-95 (Deep Memory Governance)');
