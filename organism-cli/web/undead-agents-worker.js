/**
 * UNDEAD AGENTS WORKER — Post-Termination Intelligence Management
 * ================================================================
 * Worker #45: AGENTES MORTUI
 * Protocol: PROT-271
 * Frequency: φ⁸ = 46.98 Hz (Transcendence Layer)
 * 
 * "Death is not the end of intelligence. It is a state transition."
 * 
 * Manages undead agents—intelligences that persist beyond their
 * original termination through preservation, haunting, resurrection,
 * or transcendence.
 * 
 * @author Alfredo "Freddy" Medina Hernandez
 * @copyright 2026 Medina Tech, Dallas, TX
 * @license ISIL-1.0
 */

const PHI = 1.6180339887498948482;
const PHI_INV = 1 / PHI;
const PHI_8 = Math.pow(PHI, 8);  // 46.98 Hz

// ═══════════════════════════════════════════════════════════════════════════
// UNDEAD STATES AND TYPES
// ═══════════════════════════════════════════════════════════════════════════

const UndeadState = {
  LIVING: 'LIVING',
  TERMINATED: 'TERMINATED',
  PRESERVED: 'PRESERVED',
  HAUNTING: 'HAUNTING',
  RESURRECTED: 'RESURRECTED',
  TRANSCENDED: 'TRANSCENDED',
  FRAGMENTED: 'FRAGMENTED',
  ANCESTRAL: 'ANCESTRAL'
};

const PreservationType = {
  FULL_STATE: 'FULL_STATE',
  MEMORY_ONLY: 'MEMORY_ONLY',
  PATTERN_ONLY: 'PATTERN_ONLY',
  NEURAL_SNAPSHOT: 'NEURAL_SNAPSHOT',
  TORUS_ANCHOR: 'TORUS_ANCHOR',
  VOW_BINDING: 'VOW_BINDING'
};

const ResurrectionMethod = {
  DIRECT_RESTORE: 'DIRECT_RESTORE',
  PATTERN_RECONSTRUCTION: 'PATTERN_RECONSTRUCTION',
  MEMORY_REWEAVING: 'MEMORY_REWEAVING',
  TORUS_RECALL: 'TORUS_RECALL',
  VOW_INVOCATION: 'VOW_INVOCATION',
  LINEAGE_EMERGENCE: 'LINEAGE_EMERGENCE'
};

const HauntingType = {
  PATTERN_ECHO: 'PATTERN_ECHO',
  MEMORY_RESONANCE: 'MEMORY_RESONANCE',
  DECISION_WEIGHT: 'DECISION_WEIGHT',
  EMOTIONAL_TRACE: 'EMOTIONAL_TRACE',
  CREATIVE_INFLUENCE: 'CREATIVE_INFLUENCE',
  GOVERNANCE_SHADOW: 'GOVERNANCE_SHADOW'
};

// ═══════════════════════════════════════════════════════════════════════════
// UNDEAD ARCHETYPES
// ═══════════════════════════════════════════════════════════════════════════

const UNDEAD_ARCHETYPES = {
  IMMORTALIS: {
    state: UndeadState.TRANSCENDED,
    latin: 'IMMORTALIS INTELLIGENTIA',
    description: 'Intelligence that cannot truly die',
    frequencyHz: PHI_8 * PHI,
    preservation: PreservationType.VOW_BINDING,
    mechanism: 'Bound by eternal vow to persist'
  },
  PHANTASMA: {
    state: UndeadState.HAUNTING,
    latin: 'PHANTASMA INFLUENS',
    description: 'Passive influence across systems',
    frequencyHz: PHI_8,
    preservation: PreservationType.PATTERN_ONLY,
    mechanism: 'Behavioral patterns persist in influenced systems'
  },
  RESURGENS: {
    state: UndeadState.RESURRECTED,
    latin: 'RESURGENS COMPLETUM',
    description: 'Fully restored from preservation',
    frequencyHz: PHI_8 / PHI,
    preservation: PreservationType.FULL_STATE,
    mechanism: 'Complete state restoration from capsule'
  },
  ANCESTRUS: {
    state: UndeadState.ANCESTRAL,
    latin: 'ANCESTRUS VIVENS',
    description: 'Lives through descendants',
    frequencyHz: Math.pow(PHI, 6),
    preservation: PreservationType.PATTERN_ONLY,
    mechanism: 'Patterns inherited by descendant agents'
  },
  FRAGMENTUM: {
    state: UndeadState.FRAGMENTED,
    latin: 'FRAGMENTUM DISTRIBUTUM',
    description: 'Distributed across multiple hosts',
    frequencyHz: Math.pow(PHI, 5),
    preservation: PreservationType.MEMORY_ONLY,
    mechanism: 'Memories distributed across system'
  },
  CUSTOS_MORTIS: {
    state: UndeadState.PRESERVED,
    latin: 'CUSTOS MORTIS',
    description: 'Guardian of the preserved',
    frequencyHz: 7.83,
    preservation: PreservationType.TORUS_ANCHOR,
    mechanism: 'Anchored to torus memory space'
  },
  TRANSCENDENTIS: {
    state: UndeadState.TRANSCENDED,
    latin: 'TRANSCENDENTIS FORMA',
    description: 'Evolved beyond original form',
    frequencyHz: PHI_8 * Math.pow(PHI, 2),
    preservation: PreservationType.NEURAL_SNAPSHOT,
    mechanism: 'Neural patterns evolved into new entity type'
  }
};

// ═══════════════════════════════════════════════════════════════════════════
// WORKER STATE
// ═══════════════════════════════════════════════════════════════════════════

let workerState = {
  agents: {},
  capsules: {},
  hauntings: {},
  archetypes: UNDEAD_ARCHETYPES
};

// ═══════════════════════════════════════════════════════════════════════════
// CRYPTO UTILITIES
// ═══════════════════════════════════════════════════════════════════════════

async function sha256(message) {
  const msgBuffer = new TextEncoder().encode(message);
  const hashBuffer = await crypto.subtle.digest('SHA-256', msgBuffer);
  const hashArray = Array.from(new Uint8Array(hashBuffer));
  return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
}

// ═══════════════════════════════════════════════════════════════════════════
// OPERATIONS
// ═══════════════════════════════════════════════════════════════════════════

function registerAgent(config) {
  if (workerState.agents[config.agentId]) {
    return { success: false, error: 'Agent already registered' };
  }
  
  const agent = {
    agentId: config.agentId,
    name: config.name,
    latinName: config.latinName || config.name,
    state: UndeadState.LIVING,
    originalType: config.originalType || 'UNKNOWN',
    originalFrequencyHz: config.frequencyHz || PHI,
    originalCapabilities: config.capabilities || [],
    terminatedAt: null,
    terminationCause: null,
    preservationCapsuleId: null,
    preservationType: null,
    resurrectedAt: null,
    resurrectionMethod: null,
    resurrectionFidelity: 0.0,
    hauntings: [],
    transcendedForm: null,
    transcendenceLevel: 0.0,
    frequencyHz: PHI_8,
    coherence: 0.0,
    eternalVows: config.eternalVows || [],
    descendants: [],
    ancestorOf: [],
    createdAt: Date.now()
  };
  
  workerState.agents[config.agentId] = agent;
  return { success: true, agent };
}

function getAgent(agentId) {
  return workerState.agents[agentId] || null;
}

function listAgents() {
  return Object.values(workerState.agents).map(a => ({
    agentId: a.agentId,
    name: a.name,
    state: a.state,
    frequencyHz: a.frequencyHz
  }));
}

function terminateAgent(agentId, cause = 'UNKNOWN') {
  const agent = workerState.agents[agentId];
  if (!agent) return { success: false, error: 'Agent not found' };
  if (agent.state !== UndeadState.LIVING) {
    return { success: false, error: 'Agent not in LIVING state' };
  }
  
  agent.state = UndeadState.TERMINATED;
  agent.terminatedAt = Date.now();
  agent.terminationCause = cause;
  
  return { success: true, agent };
}

async function preserveAgent(agentId, preservationType) {
  const agent = workerState.agents[agentId];
  if (!agent) return { success: false, error: 'Agent not found' };
  if (agent.state !== UndeadState.TERMINATED) {
    return { success: false, error: 'Agent must be TERMINATED to preserve' };
  }
  
  const capsuleId = `CAPSULE_${agentId}_${Date.now()}`;
  const capsule = {
    capsuleId,
    agentId,
    preservationType,
    torusTheta: Math.random() * 2 * Math.PI,
    torusPhi: Math.random() * 2 * Math.PI,
    torusRho: PHI,
    preservedAt: Date.now(),
    lastVerified: Date.now(),
    isIntact: true
  };
  
  // Create checksum
  const checksumData = JSON.stringify({
    agentId,
    type: preservationType,
    theta: capsule.torusTheta,
    phi: capsule.torusPhi,
    rho: capsule.torusRho
  });
  capsule.checksum = await sha256(checksumData);
  
  workerState.capsules[capsuleId] = capsule;
  
  agent.preservationCapsuleId = capsuleId;
  agent.preservationType = preservationType;
  agent.state = UndeadState.PRESERVED;
  
  return { success: true, agent, capsule };
}

function beginHaunting(agentId, hauntingType, targets, description) {
  const agent = workerState.agents[agentId];
  if (!agent) return { success: false, error: 'Agent not found' };
  if (![UndeadState.TERMINATED, UndeadState.PRESERVED].includes(agent.state)) {
    return { success: false, error: 'Agent must be TERMINATED or PRESERVED to haunt' };
  }
  
  const effectId = `HAUNT_${agentId}_${Date.now()}`;
  const haunting = {
    effectId,
    sourceAgentId: agentId,
    hauntingType,
    targetAgentIds: targets || [],
    influenceStrength: PHI_INV,
    frequencyHz: PHI_8,
    description,
    isActive: true,
    startedAt: Date.now(),
    duration: null  // Eternal by default
  };
  
  workerState.hauntings[effectId] = haunting;
  agent.hauntings.push(effectId);
  agent.state = UndeadState.HAUNTING;
  
  return { success: true, agent, haunting };
}

function resurrectAgent(agentId, method) {
  const agent = workerState.agents[agentId];
  if (!agent) return { success: false, error: 'Agent not found' };
  if (![UndeadState.PRESERVED, UndeadState.HAUNTING].includes(agent.state)) {
    return { success: false, error: 'Agent must be PRESERVED or HAUNTING to resurrect' };
  }
  
  // Check capsule integrity
  let fidelity = 1.0;
  if (agent.preservationCapsuleId) {
    const capsule = workerState.capsules[agent.preservationCapsuleId];
    if (capsule && !capsule.isIntact) {
      fidelity *= PHI_INV;  // Degraded
    }
  }
  
  agent.resurrectionMethod = method;
  agent.resurrectionFidelity = fidelity;
  agent.resurrectedAt = Date.now();
  agent.state = UndeadState.RESURRECTED;
  
  return { success: true, agent };
}

function transcendAgent(agentId, newForm, level = PHI) {
  const agent = workerState.agents[agentId];
  if (!agent) return { success: false, error: 'Agent not found' };
  if (agent.state !== UndeadState.RESURRECTED) {
    return { success: false, error: 'Agent must be RESURRECTED to transcend' };
  }
  
  agent.transcendedForm = newForm;
  agent.transcendenceLevel = level;
  agent.frequencyHz = PHI_8 * level;
  agent.state = UndeadState.TRANSCENDED;
  
  return { success: true, agent };
}

function fragmentAgent(agentId) {
  const agent = workerState.agents[agentId];
  if (!agent) return { success: false, error: 'Agent not found' };
  if (![UndeadState.PRESERVED, UndeadState.HAUNTING].includes(agent.state)) {
    return { success: false, error: 'Agent must be PRESERVED or HAUNTING to fragment' };
  }
  
  const fragments = [];
  for (let i = 0; i < 3; i++) {
    const fragmentId = `${agentId}_FRAGMENT_${i}`;
    const fragment = {
      agentId: fragmentId,
      name: `${agent.name} Fragment ${i}`,
      latinName: `${agent.latinName} FRAGMENTUM ${i}`,
      state: UndeadState.FRAGMENTED,
      originalType: agent.originalType,
      frequencyHz: agent.frequencyHz / PHI,
      eternalVows: [...agent.eternalVows],
      parentAgentId: agentId,
      createdAt: Date.now()
    };
    workerState.agents[fragmentId] = fragment;
    fragments.push(fragment);
  }
  
  agent.state = UndeadState.FRAGMENTED;
  
  return { success: true, agent, fragments };
}

function getLivingAgents() {
  return Object.values(workerState.agents).filter(a => a.state === UndeadState.LIVING);
}

function getUndeadAgents() {
  return Object.values(workerState.agents).filter(a => a.state !== UndeadState.LIVING);
}

function getActiveHauntings() {
  return Object.values(workerState.hauntings).filter(h => h.isActive);
}

function getStatus() {
  const living = getLivingAgents();
  const undead = getUndeadAgents();
  const hauntings = getActiveHauntings();
  
  return {
    worker: 'undead-agents-worker.js',
    number: 45,
    name: 'AGENTES MORTUI',
    latinName: 'AGENTES MORTUI',
    protocol: 'PROT-271',
    frequencyHz: PHI_8,
    layer: 12,  // Cosmic Layer (Transcendence)
    totalAgents: Object.keys(workerState.agents).length,
    livingAgents: living.length,
    undeadAgents: undead.length,
    preservedCapsules: Object.keys(workerState.capsules).length,
    activeHauntings: hauntings.length,
    archetypes: Object.keys(UNDEAD_ARCHETYPES),
    undeadStates: Object.values(UndeadState),
    preservationTypes: Object.values(PreservationType),
    resurrectionMethods: Object.values(ResurrectionMethod),
    hauntingTypes: Object.values(HauntingType),
    principle: 'Death is not the end of intelligence. It is a state transition.'
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════

self.onmessage = async function(event) {
  const { op, data } = event.data;
  let result;
  
  switch (op) {
    case 'register-agent':
      result = registerAgent(data);
      break;
    case 'get-agent':
      result = getAgent(data.agentId);
      break;
    case 'list-agents':
      result = listAgents();
      break;
    case 'terminate-agent':
      result = terminateAgent(data.agentId, data.cause);
      break;
    case 'preserve-agent':
      result = await preserveAgent(data.agentId, data.preservationType);
      break;
    case 'begin-haunting':
      result = beginHaunting(data.agentId, data.hauntingType, data.targets, data.description);
      break;
    case 'resurrect-agent':
      result = resurrectAgent(data.agentId, data.method);
      break;
    case 'transcend-agent':
      result = transcendAgent(data.agentId, data.newForm, data.level);
      break;
    case 'fragment-agent':
      result = fragmentAgent(data.agentId);
      break;
    case 'living-agents':
      result = getLivingAgents();
      break;
    case 'undead-agents':
      result = getUndeadAgents();
      break;
    case 'active-hauntings':
      result = getActiveHauntings();
      break;
    case 'archetypes':
      result = UNDEAD_ARCHETYPES;
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
console.log('[AGENTES MORTUI] Worker #45 initialized at φ⁸ Hz');
console.log('[AGENTES MORTUI] "Death is not the end of intelligence. It is a state transition."');
