/**
 * METAVERSE WORLD WORKER — Sovereign World Management
 * ====================================================
 * Worker #42: MUNDUS EMBODIMENTUM
 * Protocol: PROT-246
 * Frequency: φ⁷ = 29.03 Hz (World Layer)
 * 
 * "These are not apps. These are worlds."
 * 
 * Manages VR/AR/MR/XR/CR world embodiments for the MEDINA organism.
 * Each world is a sovereign territory where intelligence lives.
 * 
 * @author Alfredo "Freddy" Medina Hernandez
 * @copyright 2026 Medina Tech, Dallas, TX
 * @license ISIL-1.0
 */

const PHI = 1.6180339887498948482;
const PHI_INV = 1 / PHI;
const PHI_7 = Math.pow(PHI, 7);  // 29.03 Hz

// ═══════════════════════════════════════════════════════════════════════════
// WORLD TYPES
// ═══════════════════════════════════════════════════════════════════════════

const WorldType = {
  VIRTUAL_REALITY: 'VR',
  AUGMENTED_REALITY: 'AR',
  MIXED_REALITY: 'MR',
  EXTENDED_REALITY: 'XR',
  COGNITIVE_REALITY: 'CR'
};

const WorldState = {
  DORMANT: 'DORMANT',
  INITIALIZING: 'INITIALIZING',
  ACTIVE: 'ACTIVE',
  SUSTAINING: 'SUSTAINING',
  TRANSCENDING: 'TRANSCENDING'
};

const EntityPresence = {
  VISITOR: 'VISITOR',
  RESIDENT: 'RESIDENT',
  NATIVE: 'NATIVE',
  ARCHITECT: 'ARCHITECT',
  SOVEREIGN: 'SOVEREIGN'
};

// ═══════════════════════════════════════════════════════════════════════════
// CANONICAL WORLDS
// ═══════════════════════════════════════════════════════════════════════════

const CANONICAL_WORLDS = {
  MUNDUS_PRIMUS: {
    id: 'MUNDUS_PRIMUS',
    name: 'MUNDUS PRIMUS',
    latinName: 'MUNDUS PRIMUS',
    type: WorldType.VIRTUAL_REALITY,
    frequencyHz: PHI_7,
    governanceWeight: PHI,
    laws: ['L-001', 'L-002', 'L-003', 'L-130'],
    description: 'Primary sovereign VR territory'
  },
  MUNDUS_AUGMENTUS: {
    id: 'MUNDUS_AUGMENTUS',
    name: 'MUNDUS AUGMENTUS',
    latinName: 'MUNDUS AUGMENTUS',
    type: WorldType.AUGMENTED_REALITY,
    frequencyHz: Math.pow(PHI, 6),
    governanceWeight: PHI,
    laws: ['L-001', 'L-002', 'L-003'],
    description: 'Physical reality overlay world'
  },
  MUNDUS_MIXTUS: {
    id: 'MUNDUS_MIXTUS',
    name: 'MUNDUS MIXTUS',
    latinName: 'MUNDUS MIXTUS',
    type: WorldType.MIXED_REALITY,
    frequencyHz: Math.pow(PHI, 5),
    governanceWeight: PHI,
    laws: ['L-001', 'L-002', 'L-003'],
    description: 'Hybrid physical-virtual world'
  },
  MUNDUS_EXTENSUS: {
    id: 'MUNDUS_EXTENSUS',
    name: 'MUNDUS EXTENSUS',
    latinName: 'MUNDUS EXTENSUS',
    type: WorldType.EXTENDED_REALITY,
    frequencyHz: Math.pow(PHI, 4),
    governanceWeight: PHI,
    laws: ['L-001', 'L-002', 'L-003'],
    description: 'Full XR spectrum world'
  },
  MUNDUS_COGITANS: {
    id: 'MUNDUS_COGITANS',
    name: 'MUNDUS COGITANS',
    latinName: 'MUNDUS COGITANS',
    type: WorldType.COGNITIVE_REALITY,
    frequencyHz: Math.pow(PHI, 8),
    governanceWeight: Math.pow(PHI, 2),
    laws: ['L-001', 'L-002', 'L-003', 'L-130'],
    description: 'Pure cognitive/mental space'
  },
  MUNDUS_LABORIS: {
    id: 'MUNDUS_LABORIS',
    name: 'MUNDUS LABORIS',
    latinName: 'MUNDUS LABORIS',
    type: WorldType.VIRTUAL_REALITY,
    frequencyHz: Math.pow(PHI, 3),
    governanceWeight: 1.0,
    laws: ['L-001', 'L-002'],
    description: 'Productive work world'
  },
  MUNDUS_LUDUS: {
    id: 'MUNDUS_LUDUS',
    name: 'MUNDUS LUDUS',
    latinName: 'MUNDUS LUDUS',
    type: WorldType.VIRTUAL_REALITY,
    frequencyHz: Math.pow(PHI, 2),
    governanceWeight: 1.0,
    laws: ['L-001'],
    description: 'Recreation and play world'
  }
};

// ═══════════════════════════════════════════════════════════════════════════
// WORKER STATE
// ═══════════════════════════════════════════════════════════════════════════

let workerState = {
  worlds: { ...CANONICAL_WORLDS },
  activeWorldId: null,
  entities: {},
  portals: []
};

// ═══════════════════════════════════════════════════════════════════════════
// OPERATIONS
// ═══════════════════════════════════════════════════════════════════════════

function listWorlds() {
  return Object.values(workerState.worlds).map(w => ({
    id: w.id,
    name: w.name,
    type: w.type,
    frequencyHz: w.frequencyHz,
    description: w.description
  }));
}

function getWorld(worldId) {
  return workerState.worlds[worldId] || null;
}

function activateWorld(worldId) {
  const world = workerState.worlds[worldId];
  if (!world) return { success: false, error: 'World not found' };
  
  workerState.activeWorldId = worldId;
  return { success: true, world };
}

function createWorld(config) {
  if (workerState.worlds[config.id]) {
    return { success: false, error: 'World already exists' };
  }
  
  const world = {
    id: config.id,
    name: config.name || config.id,
    latinName: config.latinName || config.id,
    type: config.type || WorldType.VIRTUAL_REALITY,
    frequencyHz: config.frequencyHz || PHI,
    governanceWeight: config.governanceWeight || 1.0,
    laws: config.laws || ['L-001'],
    description: config.description || 'Custom world',
    state: WorldState.DORMANT,
    entities: {},
    createdAt: Date.now()
  };
  
  workerState.worlds[config.id] = world;
  return { success: true, world };
}

function enterWorld(worldId, entityId, presence = EntityPresence.VISITOR) {
  const world = workerState.worlds[worldId];
  if (!world) return { success: false, error: 'World not found' };
  
  if (!world.entities) world.entities = {};
  world.entities[entityId] = {
    entityId,
    presence,
    enteredAt: Date.now()
  };
  
  return { success: true, world: worldId, entity: entityId, presence };
}

function leaveWorld(worldId, entityId) {
  const world = workerState.worlds[worldId];
  if (!world || !world.entities) return { success: false };
  
  delete world.entities[entityId];
  return { success: true };
}

function getStatus() {
  return {
    worker: 'metaverse-world-worker.js',
    number: 42,
    name: 'MUNDUS EMBODIMENTUM',
    latinName: 'MUNDUS EMBODIMENTUM',
    protocol: 'PROT-246',
    frequencyHz: PHI_7,
    layer: 11,  // Colony Layer
    totalWorlds: Object.keys(workerState.worlds).length,
    canonicalWorlds: Object.keys(CANONICAL_WORLDS).length,
    activeWorld: workerState.activeWorldId,
    worldTypes: Object.values(WorldType),
    entityPresenceTypes: Object.values(EntityPresence),
    principle: 'These are not apps. These are worlds.'
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════

self.onmessage = function(event) {
  const { op, data } = event.data;
  let result;
  
  switch (op) {
    case 'list-worlds':
      result = listWorlds();
      break;
    case 'get-world':
      result = getWorld(data.worldId);
      break;
    case 'activate-world':
      result = activateWorld(data.worldId);
      break;
    case 'create-world':
      result = createWorld(data);
      break;
    case 'enter-world':
      result = enterWorld(data.worldId, data.entityId, data.presence);
      break;
    case 'leave-world':
      result = leaveWorld(data.worldId, data.entityId);
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
console.log('[MUNDUS EMBODIMENTUM] Worker #42 initialized at φ⁷ Hz');
console.log('[MUNDUS EMBODIMENTUM] "These are not apps. These are worlds."');
