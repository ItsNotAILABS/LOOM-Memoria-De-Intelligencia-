/**
 * TERMINAL HUB WORKER — Worker #52
 * =====================================
 * Latin Name: NEXUS TERMINALIS
 * Frequency: φ⁷ = 29.03 Hz (Terminal Resonance)
 * Layer: 8 (System)
 * Protocol: PROT-318
 *
 * "We need to tie all the terminals inside as well that kind of help with everything.
 *  Each terminal is a window into the organism. Each command flows through the
 *  sovereign substrate."
 *
 * Operations:
 *  - terminal-create: Create a new terminal
 *  - terminal-get: Get terminal by ID
 *  - terminal-list: List all terminals
 *  - session-create: Create terminal session
 *  - session-auth: Authenticate session
 *  - session-sovereign: Elevate to sovereign mode
 *  - command-submit: Submit command to terminal
 *  - command-execute: Execute queued command
 *  - terminal-status: Get terminal hub status
 *
 * Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
 * MEDINA TECH — Dallas, TX
 * All Rights Reserved. ISIL-1.0 License.
 */

// φ-Constants
const PHI = 1.6180339887498948482;
const PHI_7 = Math.pow(PHI, 7);  // 29.03 Hz
const PHI_8 = Math.pow(PHI, 8);  // 46.98 Hz
const SCHUMANN = 7.83;

// Terminal Types
const TerminalType = {
  TERMINALIS_SOVEREIGNUS: 'sovereign',
  TERMINALIS_OPERATIONIS: 'operations',
  TERMINALIS_MEMORIAE: 'memory',
  TERMINALIS_EVOLUTIONIS: 'evolution',
  TERMINALIS_EXTERNUS: 'external',
  TERMINALIS_DEBUG: 'debug',
  TERMINALIS_SHELL: 'shell'
};

// Terminal States
const TerminalState = {
  DISCONNECTED: 0,
  CONNECTING: 1,
  CONNECTED: 2,
  AUTHENTICATED: 3,
  SOVEREIGN_MODE: 4,
  SUSPENDED: 5,
  ERROR: 6
};

// Command Types
const CommandType = {
  QUERY: 'query',
  MUTATION: 'mutation',
  SOVEREIGN: 'sovereign',
  SYSTEM: 'system',
  SHELL: 'shell',
  PIPELINE: 'pipeline'
};

// State (using null prototype for security)
const state = Object.create(null);
state.terminals = Object.create(null);
state.sessions = Object.create(null);
state.commandQueue = [];
state.commandHistory = [];
state.pipelineHandlers = Object.create(null);
state.createdAt = Date.now();

/**
 * Security: Validate key is safe (no prototype pollution)
 */
function isSafeKey(key) {
  return typeof key === 'string' && 
         key !== '__proto__' && 
         key !== 'constructor' && 
         key !== 'prototype';
}

/**
 * Generate unique ID
 */
function generateId(prefix) {
  return `${prefix}-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
}

/**
 * SHA-256 hash for command proofs
 */
async function hashProof(data) {
  const encoder = new TextEncoder();
  const dataBuffer = encoder.encode(data);
  const hashBuffer = await crypto.subtle.digest('SHA-256', dataBuffer);
  const hashArray = Array.from(new Uint8Array(hashBuffer));
  return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
}

/**
 * Create a new terminal
 */
function createTerminal(type, name, description, protocol, config = {}) {
  const terminalId = generateId('terminal');
  
  const terminal = {
    terminalId,
    type: TerminalType[type] || type,
    name,
    description,
    protocol,
    frequencyHz: config.frequencyHz || PHI_7,
    maxSessions: config.maxSessions || 10,
    timeoutSeconds: config.timeoutSeconds || 3600,
    createdAt: Date.now(),
    sessions: [],
    commandHandlers: []
  };
  
  if (isSafeKey(terminalId)) {
    state.terminals[terminalId] = terminal;
  }
  
  return terminal;
}

/**
 * Get terminal by ID
 */
function getTerminal(terminalId) {
  if (!isSafeKey(terminalId)) return null;
  return state.terminals[terminalId] || null;
}

/**
 * List all terminals
 */
function listTerminals() {
  return Object.values(state.terminals).map(t => ({
    terminalId: t.terminalId,
    type: t.type,
    name: t.name,
    protocol: t.protocol,
    sessionCount: t.sessions.length,
    maxSessions: t.maxSessions
  }));
}

/**
 * Create terminal session
 */
function createSession(terminalId, userId) {
  const terminal = getTerminal(terminalId);
  if (!terminal) return null;
  
  if (terminal.sessions.length >= terminal.maxSessions) {
    return { error: 'Maximum sessions reached' };
  }
  
  const sessionId = generateId('session');
  
  const session = {
    sessionId,
    terminalId,
    userId,
    terminalType: terminal.type,
    state: TerminalState.CONNECTING,
    createdAt: Date.now(),
    lastActivity: Date.now(),
    commands: [],
    accessLevel: 0,
    permissions: [],
    environment: {},
    workingDirectory: '/'
  };
  
  terminal.sessions.push(sessionId);
  
  if (isSafeKey(sessionId)) {
    state.sessions[sessionId] = session;
  }
  
  return session;
}

/**
 * Get session by ID
 */
function getSession(sessionId) {
  if (!isSafeKey(sessionId)) return null;
  return state.sessions[sessionId] || null;
}

/**
 * Authenticate session
 */
function authenticateSession(sessionId, accessLevel, permissions) {
  const session = getSession(sessionId);
  if (!session) return null;
  
  if (session.state !== TerminalState.CONNECTING) {
    return { error: 'Session not in connecting state' };
  }
  
  session.state = TerminalState.AUTHENTICATED;
  session.accessLevel = accessLevel;
  session.permissions = permissions || [];
  session.lastActivity = Date.now();
  
  return session;
}

/**
 * Elevate session to sovereign mode
 */
function elevateSovereign(sessionId) {
  const session = getSession(sessionId);
  if (!session) return null;
  
  if (session.accessLevel < 9) {
    return { error: 'Sovereign access requires level 9' };
  }
  
  session.state = TerminalState.SOVEREIGN_MODE;
  session.lastActivity = Date.now();
  
  return session;
}

/**
 * Submit command to terminal
 */
async function submitCommand(terminalId, sessionId, commandType, commandText, userId) {
  const terminal = getTerminal(terminalId);
  if (!terminal) return { error: 'Terminal not found' };
  
  const session = getSession(sessionId);
  if (!session) return { error: 'Session not found' };
  
  const commandId = generateId('cmd');
  
  const command = {
    commandId,
    commandType: CommandType[commandType] || commandType,
    commandText,
    terminalId,
    sessionId,
    userId,
    createdAt: Date.now(),
    executedAt: null,
    completedAt: null,
    success: null,
    result: null,
    error: null,
    hashProof: null
  };
  
  session.commands.push(commandId);
  session.lastActivity = Date.now();
  
  state.commandQueue.push(command);
  
  return command;
}

/**
 * Execute command from queue
 */
async function executeCommand(commandId) {
  const commandIndex = state.commandQueue.findIndex(c => c.commandId === commandId);
  if (commandIndex === -1) return { error: 'Command not in queue' };
  
  const command = state.commandQueue[commandIndex];
  command.executedAt = Date.now();
  
  let result;
  let success = true;
  let error = null;
  
  try {
    switch (command.commandType) {
      case CommandType.QUERY:
        result = {
          type: 'query',
          command: command.commandText,
          timestamp: Date.now()
        };
        break;
        
      case CommandType.MUTATION:
        result = {
          type: 'mutation',
          command: command.commandText,
          applied: true,
          timestamp: Date.now()
        };
        break;
        
      case CommandType.SOVEREIGN:
        const terminal = getTerminal(command.terminalId);
        if (terminal && terminal.type === TerminalType.TERMINALIS_SOVEREIGNUS) {
          result = {
            type: 'sovereign',
            command: command.commandText,
            executed: true,
            sovereignVerified: true,
            timestamp: Date.now()
          };
        } else {
          success = false;
          error = 'Sovereign access required';
        }
        break;
        
      case CommandType.SHELL:
        result = {
          type: 'shell',
          command: command.commandText,
          note: 'Shell execution sandboxed',
          timestamp: Date.now()
        };
        break;
        
      case CommandType.PIPELINE:
        if (state.pipelineHandlers[command.commandText]) {
          result = await state.pipelineHandlers[command.commandText]();
        } else {
          success = false;
          error = 'Pipeline not found';
        }
        break;
        
      default:
        result = { executed: true };
    }
  } catch (e) {
    success = false;
    error = e.message;
  }
  
  command.completedAt = Date.now();
  command.success = success;
  command.result = result;
  command.error = error;
  
  // Generate hash proof
  const proofData = `${command.commandId}:${command.commandText}:${command.completedAt}:${success}`;
  command.hashProof = await hashProof(proofData);
  
  // Move to history
  state.commandQueue.splice(commandIndex, 1);
  state.commandHistory.push(command);
  
  return command;
}

/**
 * Get command history
 */
function getCommandHistory(terminalId = null, limit = 100) {
  let history = state.commandHistory;
  
  if (terminalId) {
    history = history.filter(c => c.terminalId === terminalId);
  }
  
  return history.slice(-limit);
}

/**
 * Initialize default terminals
 */
function initializeDefaultTerminals() {
  const terminals = [
    {
      type: 'TERMINALIS_SOVEREIGNUS',
      name: 'TERMINALIS SOVEREIGNUS',
      description: 'The sovereign command terminal for founder access',
      protocol: 'PROT-318',
      config: { frequencyHz: PHI_8, maxSessions: 1 }
    },
    {
      type: 'TERMINALIS_OPERATIONIS',
      name: 'TERMINALIS OPERATIONIS',
      description: 'Operations terminal for worker management',
      protocol: 'PROT-319',
      config: { maxSessions: 10 }
    },
    {
      type: 'TERMINALIS_MEMORIAE',
      name: 'TERMINALIS MEMORIAE',
      description: 'Memory interaction terminal',
      protocol: 'PROT-320',
      config: { maxSessions: 5 }
    },
    {
      type: 'TERMINALIS_EVOLUTIONIS',
      name: 'TERMINALIS EVOLUTIONIS',
      description: 'Evolution monitoring terminal',
      protocol: 'PROT-321',
      config: { maxSessions: 3 }
    },
    {
      type: 'TERMINALIS_EXTERNUS',
      name: 'TERMINALIS EXTERNUS',
      description: 'External integration terminal',
      protocol: 'PROT-322',
      config: { maxSessions: 20 }
    }
  ];
  
  const created = [];
  for (const t of terminals) {
    const terminal = createTerminal(t.type, t.name, t.description, t.protocol, t.config);
    created.push(terminal.terminalId);
  }
  
  return created;
}

/**
 * Get terminal hub status
 */
function getTerminalHubStatus() {
  const terminals = Object.values(state.terminals);
  const sessions = Object.values(state.sessions);
  const activeSessions = sessions.filter(
    s => s.state !== TerminalState.DISCONNECTED
  );
  
  return {
    terminalCount: terminals.length,
    totalSessions: sessions.length,
    activeSessions: activeSessions.length,
    queueSize: state.commandQueue.length,
    historySize: state.commandHistory.length,
    frequencyHz: PHI_7,
    uptimeMs: Date.now() - state.createdAt
  };
}

/**
 * Main message handler
 */
addEventListener('message', async (event) => {
  const { op, payload } = event.data || {};
  
  let result;
  
  try {
    switch (op) {
      case 'terminal-create':
        result = createTerminal(
          payload.type,
          payload.name,
          payload.description,
          payload.protocol,
          payload.config
        );
        break;
        
      case 'terminal-get':
        result = getTerminal(payload.terminalId);
        break;
        
      case 'terminal-list':
        result = listTerminals();
        break;
        
      case 'session-create':
        result = createSession(payload.terminalId, payload.userId);
        break;
        
      case 'session-get':
        result = getSession(payload.sessionId);
        break;
        
      case 'session-auth':
        result = authenticateSession(
          payload.sessionId,
          payload.accessLevel,
          payload.permissions
        );
        break;
        
      case 'session-sovereign':
        result = elevateSovereign(payload.sessionId);
        break;
        
      case 'command-submit':
        result = await submitCommand(
          payload.terminalId,
          payload.sessionId,
          payload.commandType,
          payload.commandText,
          payload.userId
        );
        break;
        
      case 'command-execute':
        result = await executeCommand(payload.commandId);
        break;
        
      case 'command-history':
        result = getCommandHistory(payload.terminalId, payload.limit);
        break;
        
      case 'terminal-init':
        result = initializeDefaultTerminals();
        break;
        
      case 'terminal-status':
        result = getTerminalHubStatus();
        break;
        
      case 'ping':
        result = {
          worker: 'terminal-hub-worker.js',
          number: 52,
          name: 'NEXUS TERMINALIS',
          protocol: 'PROT-318',
          frequencyHz: PHI_7,
          layer: 8,
          status: 'alive',
          timestamp: Date.now()
        };
        break;
        
      default:
        result = { error: `Unknown operation: ${op}` };
    }
  } catch (error) {
    result = { error: error.message };
  }
  
  postMessage({ op, result, timestamp: Date.now() });
});

// Export for testing
if (typeof module !== 'undefined') {
  module.exports = {
    TerminalType,
    TerminalState,
    CommandType,
    createTerminal,
    getTerminal,
    listTerminals,
    createSession,
    authenticateSession,
    elevateSovereign,
    submitCommand,
    executeCommand,
    initializeDefaultTerminals,
    getTerminalHubStatus,
    PHI,
    PHI_7,
    PHI_8
  };
}
