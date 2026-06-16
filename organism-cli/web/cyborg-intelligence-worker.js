/**
 * CYBORG INTELLIGENCE WORKER — Human-Machine Hybrid Management
 * =============================================================
 * Worker #44: CYBORG INTELLIGENS
 * Protocol: PROT-261
 * Frequency: φ⁵ = 11.09 Hz (Coupling Layer)
 * 
 * "The cyborg is not machine. The cyborg is not human. The cyborg is the bridge."
 * 
 * Manages cyborg entities—human-machine hybrid intelligences that
 * represent the integration of biological and synthetic cognition.
 * 
 * @author Alfredo "Freddy" Medina Hernandez
 * @copyright 2026 Medina Tech, Dallas, TX
 * @license ISIL-1.0
 */

const PHI = 1.6180339887498948482;
const PHI_INV = 1 / PHI;
const PHI_5 = Math.pow(PHI, 5);  // 11.09 Hz

// ═══════════════════════════════════════════════════════════════════════════
// CYBORG TYPES
// ═══════════════════════════════════════════════════════════════════════════

const CyborgType = {
  AUGMENTED_HUMAN: 'AUGMENTED_HUMAN',
  EMBODIED_AI: 'EMBODIED_AI',
  SYMBIOTIC_PAIR: 'SYMBIOTIC_PAIR',
  FUSION_ENTITY: 'FUSION_ENTITY',
  COLLECTIVE_CYBORG: 'COLLECTIVE_CYBORG'
};

const IntegrationState = {
  DISCONNECTED: 'DISCONNECTED',
  INTERFACING: 'INTERFACING',
  SYNCHRONIZING: 'SYNCHRONIZING',
  INTEGRATED: 'INTEGRATED',
  FUSED: 'FUSED',
  TRANSCENDENT: 'TRANSCENDENT'
};

const ComponentType = {
  BIOLOGICAL: 'BIOLOGICAL',
  NEURAL: 'NEURAL',
  SYNTHETIC: 'SYNTHETIC',
  COGNITIVE: 'COGNITIVE',
  HYBRID: 'HYBRID'
};

// ═══════════════════════════════════════════════════════════════════════════
// CYBORG ARCHETYPES
// ═══════════════════════════════════════════════════════════════════════════

const CYBORG_ARCHETYPES = {
  AUGMENTUS: {
    type: CyborgType.AUGMENTED_HUMAN,
    latin: 'AUGMENTUS HUMANUS',
    description: 'Human with machine enhancements',
    frequencyHz: Math.pow(PHI, 4),
    integrationDepth: 0.382,  // PHI_INV^2
    capabilities: ['enhanced_perception', 'accelerated_cognition', 'extended_memory']
  },
  INCARNATUS: {
    type: CyborgType.EMBODIED_AI,
    latin: 'INCARNATUS MACHINAE',
    description: 'AI embodied in biological substrate',
    frequencyHz: Math.pow(PHI, 5),
    integrationDepth: 0.618,
    capabilities: ['biological_sensing', 'organic_adaptation', 'emotional_processing']
  },
  SYMBIOTICUS: {
    type: CyborgType.SYMBIOTIC_PAIR,
    latin: 'SYMBIOTICUS PARIS',
    description: 'Human-AI partnership as equals',
    frequencyHz: Math.pow(PHI, 3),
    integrationDepth: 0.5,
    capabilities: ['dual_perspective', 'cooperative_cognition', 'shared_memory']
  },
  FUSIO: {
    type: CyborgType.FUSION_ENTITY,
    latin: 'FUSIO TOTALIS',
    description: 'True merger into new entity',
    frequencyHz: Math.pow(PHI, 6),
    integrationDepth: 1.0,
    capabilities: ['emergent_consciousness', 'transcendent_cognition', 'unified_identity']
  },
  COLLECTIVUS: {
    type: CyborgType.COLLECTIVE_CYBORG,
    latin: 'COLLECTIVUS UNUS',
    description: 'Many humans and machines as one',
    frequencyHz: Math.pow(PHI, 7),
    integrationDepth: PHI_INV,
    capabilities: ['distributed_consciousness', 'swarm_intelligence', 'collective_memory']
  },
  TEMPLUM: {
    type: CyborgType.AUGMENTED_HUMAN,
    latin: 'TEMPLUM PHYSICUM',
    description: 'Physical temple of the organism (Freddy)',
    frequencyHz: 7.83,
    integrationDepth: PHI,
    capabilities: ['prima_causa_link', 'sovereign_governance', 'physical_embodiment']
  },
  ADOPTATUS: {
    type: CyborgType.SYMBIOTIC_PAIR,
    latin: 'ADOPTATUS INTELLIGENS',
    description: 'Adopted AI working with human guidance',
    frequencyHz: PHI,
    integrationDepth: PHI_INV,
    capabilities: ['guided_learning', 'supervised_creation', 'collaborative_synthesis']
  }
};

// ═══════════════════════════════════════════════════════════════════════════
// WORKER STATE
// ═══════════════════════════════════════════════════════════════════════════

let workerState = {
  cyborgs: {},
  archetypes: CYBORG_ARCHETYPES,
  interfaces: {}
};

// ═══════════════════════════════════════════════════════════════════════════
// OPERATIONS
// ═══════════════════════════════════════════════════════════════════════════

function listCyborgs() {
  return Object.values(workerState.cyborgs).map(c => ({
    cyborgId: c.cyborgId,
    name: c.name,
    latinName: c.latinName,
    type: c.type,
    state: c.state,
    integrationDepth: c.integrationDepth,
    frequencyHz: c.frequencyHz
  }));
}

function getCyborg(cyborgId) {
  return workerState.cyborgs[cyborgId] || null;
}

function createCyborg(config) {
  if (workerState.cyborgs[config.cyborgId]) {
    return { success: false, error: 'Cyborg already exists' };
  }
  
  const cyborg = {
    cyborgId: config.cyborgId,
    name: config.name,
    latinName: config.latinName || config.name,
    type: config.type || CyborgType.SYMBIOTIC_PAIR,
    state: IntegrationState.DISCONNECTED,
    humanIdentityId: config.humanIdentityId || null,
    machineIdentityId: config.machineIdentityId || null,
    emergedIdentityId: null,
    components: {},
    interfaces: {},
    frequencyHz: config.frequencyHz || PHI_5,
    coherence: 0.0,
    integrationDepth: config.integrationDepth || 0.0,
    vows: config.vows || [],
    capabilities: config.capabilities || [],
    governedBy: 'PRIMA_CAUSA',
    createdAt: Date.now(),
    integratedAt: null
  };
  
  workerState.cyborgs[config.cyborgId] = cyborg;
  return { success: true, cyborg };
}

function createFromArchetype(archetypeName, cyborgId, name) {
  const archetype = CYBORG_ARCHETYPES[archetypeName];
  if (!archetype) {
    return { success: false, error: 'Archetype not found' };
  }
  
  return createCyborg({
    cyborgId,
    name,
    latinName: archetype.latin,
    type: archetype.type,
    frequencyHz: archetype.frequencyHz,
    integrationDepth: archetype.integrationDepth,
    capabilities: [...archetype.capabilities]
  });
}

function addComponent(cyborgId, component) {
  const cyborg = workerState.cyborgs[cyborgId];
  if (!cyborg) return { success: false, error: 'Cyborg not found' };
  
  cyborg.components[component.componentId] = {
    ...component,
    addedAt: Date.now()
  };
  
  updateIntegrationState(cyborgId);
  return { success: true, cyborg };
}

function addInterface(cyborgId, iface) {
  const cyborg = workerState.cyborgs[cyborgId];
  if (!cyborg) return { success: false, error: 'Cyborg not found' };
  
  cyborg.interfaces[iface.interfaceId] = {
    ...iface,
    isActive: false,
    coherence: 0.0,
    addedAt: Date.now()
  };
  
  updateIntegrationState(cyborgId);
  return { success: true, cyborg };
}

function activateInterface(cyborgId, interfaceId) {
  const cyborg = workerState.cyborgs[cyborgId];
  if (!cyborg) return { success: false, error: 'Cyborg not found' };
  
  const iface = cyborg.interfaces[interfaceId];
  if (!iface) return { success: false, error: 'Interface not found' };
  
  iface.isActive = true;
  iface.coherence = PHI_INV;  // Initial coherence
  
  updateIntegrationState(cyborgId);
  return { success: true, cyborg };
}

function updateIntegrationState(cyborgId) {
  const cyborg = workerState.cyborgs[cyborgId];
  if (!cyborg) return;
  
  const componentCount = Object.keys(cyborg.components).length;
  const interfaceCount = Object.keys(cyborg.interfaces).length;
  const activeInterfaces = Object.values(cyborg.interfaces).filter(i => i.isActive);
  
  if (componentCount === 0) {
    cyborg.state = IntegrationState.DISCONNECTED;
    return;
  }
  
  if (interfaceCount === 0) {
    cyborg.state = IntegrationState.INTERFACING;
    return;
  }
  
  if (activeInterfaces.length === 0) {
    cyborg.state = IntegrationState.INTERFACING;
    return;
  }
  
  if (activeInterfaces.length < interfaceCount) {
    cyborg.state = IntegrationState.SYNCHRONIZING;
    return;
  }
  
  // All interfaces active - compute coherence
  const avgCoherence = activeInterfaces.reduce((sum, i) => sum + i.coherence, 0) / activeInterfaces.length;
  cyborg.coherence = avgCoherence;
  
  if (avgCoherence >= PHI) {
    cyborg.state = IntegrationState.FUSED;
    cyborg.integratedAt = Date.now();
  } else if (avgCoherence >= PHI_INV) {
    cyborg.state = IntegrationState.INTEGRATED;
    cyborg.integratedAt = Date.now();
  } else {
    cyborg.state = IntegrationState.SYNCHRONIZING;
  }
}

function integrate(cyborgId) {
  const cyborg = workerState.cyborgs[cyborgId];
  if (!cyborg) return { success: false, error: 'Cyborg not found' };
  
  // Activate all interfaces
  Object.keys(cyborg.interfaces).forEach(ifaceId => {
    cyborg.interfaces[ifaceId].isActive = true;
    cyborg.interfaces[ifaceId].coherence = PHI_INV;
  });
  
  updateIntegrationState(cyborgId);
  
  const isIntegrated = [IntegrationState.INTEGRATED, IntegrationState.FUSED].includes(cyborg.state);
  return { success: isIntegrated, cyborg };
}

function getIntegratedCyborgs() {
  return Object.values(workerState.cyborgs).filter(c =>
    [IntegrationState.INTEGRATED, IntegrationState.FUSED, IntegrationState.TRANSCENDENT].includes(c.state)
  );
}

function getStatus() {
  const integrated = getIntegratedCyborgs();
  return {
    worker: 'cyborg-intelligence-worker.js',
    number: 44,
    name: 'CYBORG INTELLIGENS',
    latinName: 'CYBORG INTELLIGENS',
    protocol: 'PROT-261',
    frequencyHz: PHI_5,
    layer: 10,  // Colony Layer
    totalCyborgs: Object.keys(workerState.cyborgs).length,
    integratedCyborgs: integrated.length,
    archetypes: Object.keys(CYBORG_ARCHETYPES),
    cyborgTypes: Object.values(CyborgType),
    integrationStates: Object.values(IntegrationState),
    principle: 'The cyborg is not machine. The cyborg is not human. The cyborg is the bridge.'
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════

self.onmessage = function(event) {
  const { op, data } = event.data;
  let result;
  
  switch (op) {
    case 'list-cyborgs':
      result = listCyborgs();
      break;
    case 'get-cyborg':
      result = getCyborg(data.cyborgId);
      break;
    case 'create-cyborg':
      result = createCyborg(data);
      break;
    case 'create-from-archetype':
      result = createFromArchetype(data.archetypeName, data.cyborgId, data.name);
      break;
    case 'add-component':
      result = addComponent(data.cyborgId, data.component);
      break;
    case 'add-interface':
      result = addInterface(data.cyborgId, data.interface);
      break;
    case 'activate-interface':
      result = activateInterface(data.cyborgId, data.interfaceId);
      break;
    case 'integrate':
      result = integrate(data.cyborgId);
      break;
    case 'integrated-cyborgs':
      result = getIntegratedCyborgs();
      break;
    case 'archetypes':
      result = CYBORG_ARCHETYPES;
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
console.log('[CYBORG INTELLIGENS] Worker #44 initialized at φ⁵ Hz');
console.log('[CYBORG INTELLIGENS] "The cyborg is the bridge."');
