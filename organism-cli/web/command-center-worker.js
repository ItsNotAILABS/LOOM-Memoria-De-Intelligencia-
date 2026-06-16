/**
 * COMMAND CENTER WORKER — Multi-Terminal Dashboard Orchestration
 * ===============================================================
 * Worker #48: CENTRUM IMPERII
 * Protocol: PROT-299
 * Frequency: φ⁶ = 17.94 Hz (Organism Layer)
 * 
 * "The Command Center is the sovereign bridge to all terminals.
 *  Through it, the Founder orchestrates the entire MEDINA organism."
 * 
 * @author Alfredo "Freddy" Medina Hernandez
 * @copyright 2026 Medina Tech, Dallas, TX
 * @license ISIL-1.0
 */

const PHI = 1.6180339887498948482;
const PHI_INV = 1 / PHI;
const PHI_6 = Math.pow(PHI, 6);  // 17.94 Hz
const SCHUMANN = 7.83;

// ═══════════════════════════════════════════════════════════════════════════
// ENUMS AND CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const TerminalType = {
  WORKER: 'WORKER',
  BOT: 'BOT',
  CANISTER: 'CANISTER',
  CLOUDFLARE: 'CLOUDFLARE',
  API: 'API',
  CLI: 'CLI',
  DASHBOARD: 'DASHBOARD',
  SOVEREIGN: 'SOVEREIGN'
};

const TerminalState = {
  OFFLINE: 'OFFLINE',
  INITIALIZING: 'INITIALIZING',
  ONLINE: 'ONLINE',
  BUSY: 'BUSY',
  ERROR: 'ERROR',
  MAINTENANCE: 'MAINTENANCE'
};

const CommandPriority = {
  LOW: 1,
  NORMAL: 2,
  HIGH: 3,
  URGENT: 4,
  SOVEREIGN: 5
};

// ═══════════════════════════════════════════════════════════════════════════
// SECURITY HELPERS
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Validate key to prevent prototype pollution attacks.
 * Rejects keys that could modify Object prototype.
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
  terminals: Object.create(null),  // Null prototype to prevent pollution
  commands: Object.create(null),
  commandQueue: [],
  dashboards: Object.create(null),
  commandCounter: 0
};

// ═══════════════════════════════════════════════════════════════════════════
// TERMINAL MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════

function registerTerminal(config) {
  if (!isSafeKey(config.terminalId)) {
    return { success: false, error: 'Invalid terminal ID' };
  }
  
  const terminal = {
    terminalId: config.terminalId,
    name: config.name,
    latinName: config.latinName || config.name,
    terminalType: config.terminalType || TerminalType.WORKER,
    state: TerminalState.ONLINE,
    endpoint: config.endpoint || '',
    protocol: config.protocol || 'PROT-299',
    capabilities: config.capabilities || [],
    supportedCommands: config.supportedCommands || [],
    healthScore: 1.0,
    lastHeartbeat: Date.now(),
    errorCount: 0,
    commandsExecuted: 0,
    avgResponseMs: 0,
    frequencyHz: config.frequencyHz || PHI,
    coherence: 1.0
  };
  
  state.terminals[config.terminalId] = terminal;
  return { success: true, terminal };
}

function unregisterTerminal(terminalId) {
  if (!isSafeKey(terminalId)) {
    return { success: false, error: 'Invalid terminal ID' };
  }
  if (state.terminals[terminalId]) {
    delete state.terminals[terminalId];
    return { success: true };
  }
  return { success: false, error: 'Terminal not found' };
}

function heartbeatTerminal(terminalId) {
  const terminal = state.terminals[terminalId];
  if (!terminal) {
    return { success: false, error: 'Terminal not found' };
  }
  terminal.lastHeartbeat = Date.now();
  if (terminal.state === TerminalState.OFFLINE) {
    terminal.state = TerminalState.ONLINE;
  }
  return { success: true, terminal };
}

function getTerminal(terminalId) {
  return state.terminals[terminalId] || null;
}

function listTerminals() {
  return Object.values(state.terminals).map(t => ({
    terminalId: t.terminalId,
    name: t.name,
    terminalType: t.terminalType,
    state: t.state,
    healthScore: t.healthScore,
    lastHeartbeat: t.lastHeartbeat
  }));
}

function getHealthyTerminals() {
  const now = Date.now();
  return Object.values(state.terminals).filter(t => {
    const healthy = (
      [TerminalState.ONLINE, TerminalState.BUSY].includes(t.state) &&
      (now - t.lastHeartbeat) < 60000 &&
      t.healthScore >= PHI_INV
    );
    return healthy;
  });
}

function getTerminalsByType(terminalType) {
  return Object.values(state.terminals).filter(t => t.terminalType === terminalType);
}

// ═══════════════════════════════════════════════════════════════════════════
// COMMAND MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════

function generateCommandId() {
  state.commandCounter++;
  return `CMD-${Date.now()}-${String(state.commandCounter).padStart(6, '0')}`;
}

function createCommand(config) {
  const commandId = generateCommandId();
  
  let targets = [];
  if (config.broadcast) {
    targets = Object.keys(state.terminals);
  } else if (config.targetTerminals) {
    targets = config.targetTerminals;
  }
  
  const command = {
    commandId: commandId,
    commandType: config.commandType || 'STANDARD',
    targetTerminals: targets,
    broadcast: config.broadcast || false,
    operation: config.operation || '',
    parameters: config.parameters || {},
    priority: config.priority || CommandPriority.NORMAL,
    sourceTerminalId: config.sourceTerminalId || 'SOVEREIGN',
    timestamp: Date.now(),
    executed: false,
    results: {}
  };
  
  state.commands[commandId] = command;
  state.commandQueue.push(commandId);
  
  // Sort by priority
  state.commandQueue.sort((a, b) => {
    return (state.commands[b]?.priority || 0) - (state.commands[a]?.priority || 0);
  });
  
  return { success: true, command };
}

function executeCommand(commandId) {
  const command = state.commands[commandId];
  if (!command) {
    return { success: false, error: 'Command not found' };
  }
  
  const results = {};
  for (const terminalId of command.targetTerminals) {
    const terminal = state.terminals[terminalId];
    if (terminal && [TerminalState.ONLINE, TerminalState.BUSY].includes(terminal.state)) {
      results[terminalId] = {
        status: 'executed',
        terminalState: terminal.state,
        timestamp: Date.now()
      };
      terminal.commandsExecuted++;
    } else {
      results[terminalId] = {
        status: 'terminal_unavailable',
        timestamp: Date.now()
      };
    }
  }
  
  command.executed = true;
  command.results = results;
  
  // Remove from queue
  const queueIndex = state.commandQueue.indexOf(commandId);
  if (queueIndex > -1) {
    state.commandQueue.splice(queueIndex, 1);
  }
  
  return { success: true, results };
}

function broadcastCommand(operation, parameters, priority) {
  return createCommand({
    commandType: 'BROADCAST',
    operation,
    parameters,
    broadcast: true,
    priority: priority || CommandPriority.NORMAL
  });
}

function sovereignCommand(operation, parameters, targetTerminals) {
  return createCommand({
    commandType: 'SOVEREIGN',
    operation,
    parameters,
    targetTerminals: targetTerminals || null,
    broadcast: !targetTerminals,
    priority: CommandPriority.SOVEREIGN
  });
}

function getCommandQueue() {
  return state.commandQueue.map(id => state.commands[id]).filter(Boolean);
}

// ═══════════════════════════════════════════════════════════════════════════
// DASHBOARD MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════

function createDashboard(config) {
  const dashboardId = `DASH-${Date.now()}`;
  
  const dashboard = {
    dashboardId: dashboardId,
    name: config.name,
    latinName: config.latinName || config.name,
    panels: {},
    gridRows: config.gridRows || 4,
    gridCols: config.gridCols || 4,
    theme: config.theme || 'SOVEREIGN',
    ownerId: config.ownerId || 'FOUNDER'
  };
  
  state.dashboards[dashboardId] = dashboard;
  return { success: true, dashboard };
}

function addPanel(dashboardId, panel) {
  const dashboard = state.dashboards[dashboardId];
  if (!dashboard) {
    return { success: false, error: 'Dashboard not found' };
  }
  
  dashboard.panels[panel.panelId] = {
    ...panel,
    isActive: true,
    lastRefresh: 0,
    currentData: {}
  };
  
  return { success: true, dashboard };
}

function createStandardPanels(dashboardId) {
  const panels = [
    { panelId: 'PANEL-HEALTH', name: 'Organism Health', panelType: 'health', position: [0, 0], size: [1, 2] },
    { panelId: 'PANEL-TERMINALS', name: 'Terminal Status', panelType: 'terminals', position: [0, 2], size: [1, 2] },
    { panelId: 'PANEL-TOKENS', name: 'Token Flow', panelType: 'tokens', position: [1, 0], size: [1, 2] },
    { panelId: 'PANEL-CYBORGS', name: 'Cyborg Entities', panelType: 'cyborgs', position: [1, 2], size: [1, 2] },
    { panelId: 'PANEL-COMMANDS', name: 'Command Queue', panelType: 'commands', position: [2, 0], size: [1, 4] },
    { panelId: 'PANEL-METRICS', name: 'System Metrics', panelType: 'metrics', position: [3, 0], size: [1, 2] },
    { panelId: 'PANEL-LOGS', name: 'Activity Logs', panelType: 'logs', position: [3, 2], size: [1, 2] }
  ];
  
  panels.forEach(panel => addPanel(dashboardId, panel));
  return panels;
}

function createSovereignDashboard() {
  const result = createDashboard({
    name: 'Sovereign Command Center',
    latinName: 'CENTRUM IMPERII SOVEREIGNUM'
  });
  
  if (result.success) {
    createStandardPanels(result.dashboard.dashboardId);
  }
  
  return result;
}

// ═══════════════════════════════════════════════════════════════════════════
// ORGANISM HEALTH
// ═══════════════════════════════════════════════════════════════════════════

function getOrganismHealth() {
  const healthyTerminals = getHealthyTerminals();
  const totalTerminals = Object.keys(state.terminals).length;
  
  const terminalHealth = totalTerminals > 0 ? healthyTerminals.length / totalTerminals : 0;
  
  let avgCoherence = 0;
  if (healthyTerminals.length > 0) {
    avgCoherence = healthyTerminals.reduce((sum, t) => sum + t.coherence, 0) / healthyTerminals.length;
  }
  
  const healthScore = (terminalHealth * 0.6) + (avgCoherence * 0.4);
  
  return {
    healthScore: healthScore,
    terminalHealth: terminalHealth,
    coherence: avgCoherence,
    healthyTerminals: healthyTerminals.length,
    totalTerminals: totalTerminals,
    pendingCommands: state.commandQueue.length,
    frequencyHz: PHI_6,
    status: healthScore >= PHI_INV ? 'HEALTHY' : 'DEGRADED'
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// STATUS
// ═══════════════════════════════════════════════════════════════════════════

function getStatus() {
  const health = getOrganismHealth();
  
  return {
    worker: 'command-center-worker.js',
    number: 48,
    name: 'CENTRUM IMPERII',
    latinName: 'CENTRUM IMPERII SOVEREIGNUM',
    protocol: 'PROT-299',
    frequencyHz: PHI_6,
    layer: 9,  // Organism Layer
    totalTerminals: Object.keys(state.terminals).length,
    healthyTerminals: health.healthyTerminals,
    totalCommands: Object.keys(state.commands).length,
    pendingCommands: state.commandQueue.length,
    totalDashboards: Object.keys(state.dashboards).length,
    organismHealth: health.healthScore,
    terminalTypes: Object.values(TerminalType),
    commandPriorities: Object.keys(CommandPriority),
    principle: 'The Command Center is the sovereign bridge to all terminals.'
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════

self.onmessage = function(event) {
  const { op, data } = event.data;
  let result;
  
  switch (op) {
    // Terminal operations
    case 'register-terminal':
      result = registerTerminal(data);
      break;
    case 'unregister-terminal':
      result = unregisterTerminal(data.terminalId);
      break;
    case 'heartbeat':
      result = heartbeatTerminal(data.terminalId);
      break;
    case 'get-terminal':
      result = getTerminal(data.terminalId);
      break;
    case 'list-terminals':
      result = listTerminals();
      break;
    case 'healthy-terminals':
      result = getHealthyTerminals();
      break;
    case 'terminals-by-type':
      result = getTerminalsByType(data.terminalType);
      break;
    
    // Command operations
    case 'create-command':
      result = createCommand(data);
      break;
    case 'execute-command':
      result = executeCommand(data.commandId);
      break;
    case 'broadcast':
      result = broadcastCommand(data.operation, data.parameters, data.priority);
      break;
    case 'sovereign-command':
      result = sovereignCommand(data.operation, data.parameters, data.targetTerminals);
      break;
    case 'command-queue':
      result = getCommandQueue();
      break;
    
    // Dashboard operations
    case 'create-dashboard':
      result = createDashboard(data);
      break;
    case 'add-panel':
      result = addPanel(data.dashboardId, data.panel);
      break;
    case 'create-sovereign-dashboard':
      result = createSovereignDashboard();
      break;
    
    // Health operations
    case 'organism-health':
      result = getOrganismHealth();
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
console.log('[CENTRUM IMPERII] Worker #48 initialized at φ⁶ Hz');
console.log('[CENTRUM IMPERII] "The Command Center is the sovereign bridge."');
