/**
 * MEMORIA ACCESSU PUBLIC API — Public Memory Access Endpoints
 * ===========================================================
 * 
 * Public-facing REST + WebSocket API for MEDINA memory access
 * 
 * Endpoints:
 * - POST /api/memory/query — Query memory
 * - POST /api/memory/token/request — Request new token
 * - POST /api/memory/token/refresh — Refresh expiring token
 * - GET /api/memory/schema — Get memory structure documentation
 * - WebSocket /ws/memory — Real-time memory updates
 * 
 * Protocol: PROT-380 + PROT-388 (Public API Protocol)
 * 
 * @author Alfredo "Freddy" Medina Hernandez
 * @copyright 2026 Medina Tech, Dallas, TX
 * @license ISIL-1.0
 */

const express = require('express');
const WebSocket = require('ws');
const { TokenRegistry } = require('./memoria_accessu_token_generator');
const { MemoryCoordinator } = require('./memoria_coordinator');

// Initialize services
const tokenRegistry = new TokenRegistry();
const coordinator = new MemoryCoordinator();

// Create Express app
const app = express();
app.use(express.json({ limit: '10mb' }));

const PHI = 1.6180339887498948482;

/**
 * Error response helper
 */
function errorResponse(res, code, message, statusCode = 400) {
  res.status(statusCode).json({
    error: {
      code: code,
      message: message,
      timestamp: new Date().toISOString(),
    },
  });
}

/**
 * Token validation middleware
 */
function validateToken(req, res, next) {
  const tokenId = req.headers['x-token-id'];
  const agentId = req.headers['x-agent-id'];

  if (!tokenId || !agentId) {
    return errorResponse(res, 'MISSING_CREDENTIALS', 'X-Token-ID and X-Agent-ID headers required', 401);
  }

  const token = tokenRegistry.getToken(tokenId);
  if (!token) {
    return errorResponse(res, 'TOKEN_NOT_FOUND', 'Token not found', 401);
  }

  const validation = tokenRegistry.validateToken(tokenId);
  if (!validation.valid) {
    const statusCode = validation.reason === 'TOKEN_EXPIRED' ? 401 : 403;
    return errorResponse(res, validation.reason, `Token validation failed: ${validation.reason}`, statusCode);
  }

  if (token.agent_id !== agentId) {
    return errorResponse(res, 'AGENT_MISMATCH', 'Agent ID does not match token', 403);
  }

  req.token = token;
  next();
}

// ═══════════════════════════════════════════════════════════════════════════
// MEMORY QUERY ENDPOINT
// ═══════════════════════════════════════════════════════════════════════════

/**
 * POST /api/memory/query
 * Query the memory temple
 */
app.post('/api/memory/query', validateToken, (req, res) => {
  try {
    const { pattern, search_type = 'semantic', filters = {}, limit = 50, ordering = 'salience' } = req.body;

    if (!pattern) {
      return errorResponse(res, 'INVALID_REQUEST', 'pattern is required');
    }

    if (!req.token.scope.operations.query) {
      return errorResponse(res, 'OPERATION_DENIED', 'Query operation not allowed', 403);
    }

    const effectiveLimit = Math.min(limit, req.token.scope.max_memory_atoms);

    // Simulate memory query (in production, query actual memory temple)
    const results = {
      request_id: `REQ_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
      timestamp: Math.floor(Date.now() / 1000),
      token_id: req.token.token_id,
      results: [
        {
          memory_id: 'MEM_001_abc123',
          torus_coordinates: {
            theta: (PHI * 0.5) % (2 * Math.PI),
            phi: (PHI * 0.3) % (2 * Math.PI),
            rho: 0.85,
            ring: 8,
            beat: Math.floor(Date.now() / 1000),
          },
          content: {
            query_pattern: pattern,
            matched: true,
          },
          salience: 0.92,
          memory_type: 'SEMANTIC',
          created_at: Math.floor(Date.now() / 1000) - 3600,
          last_accessed: Math.floor(Date.now() / 1000),
          lineage: ['MEM_000_root'],
          tags: ['ai-access', 'query', pattern],
        },
      ],
      total_available: 1,
      audit_entry_id: `AUDIT_${Date.now()}`,
    };

    res.json(results);
  } catch (error) {
    errorResponse(res, 'INTERNAL_ERROR', error.message, 500);
  }
});

// ═══════════════════════════════════════════════════════════════════════════
// TOKEN REQUEST ENDPOINT
// ═══════════════════════════════════════════════════════════════════════════

/**
 * POST /api/memory/token/request
 * Request a new memory access token
 */
app.post('/api/memory/token/request', express.json(), (req, res) => {
  try {
    const {
      agent_id,
      agent_type,
      public_key,
      requested_scope,
      permissions,
      heartbeat_alignment = 2,
      duration_days = 90,
    } = req.body;

    // Validate request
    if (!agent_id || !agent_type) {
      return errorResponse(res, 'INVALID_REQUEST', 'agent_id and agent_type are required');
    }

    if (!['LLM', 'WORKER', 'ECOSYSTEM'].includes(agent_type)) {
      return errorResponse(res, 'INVALID_AGENT_TYPE', `agent_type must be LLM, WORKER, or ECOSYSTEM`);
    }

    if (!public_key) {
      return errorResponse(res, 'MISSING_PUBLIC_KEY', 'public_key is required for signature verification');
    }

    // Create default scope if not provided
    const scope = requested_scope || {
      memory_rings: [8, 9, 10, 11],
      coordinate_range: {
        theta_min: 0,
        theta_max: 2 * Math.PI,
        phi_min: 0,
        phi_max: 2 * Math.PI,
        rho_min: 0.5,
        rho_max: 1.0,
      },
      salience_floor: 0.1,
      max_memory_atoms: agent_type === 'LLM' ? 1000 : agent_type === 'WORKER' ? 5000 : 100,
      max_consolidation_depth: agent_type === 'LLM' ? 5 : 10,
      operations: {
        query: true,
        store: agent_type !== 'ECOSYSTEM',
        consolidate: agent_type === 'WORKER',
        traverse: true,
        pin: agent_type === 'WORKER',
        delete: false,
      },
      doctrine_binding: 'memory.cpl-l:default',
    };

    // Generate token
    const publicKeyHash = require('crypto')
      .createHash('sha256')
      .update(public_key)
      .digest('hex');

    const token = tokenRegistry.generateToken({
      agentId: agent_id,
      agentType: agent_type,
      publicKeyHash: publicKeyHash,
      scope: scope,
      permissions: permissions || [],
      heartbeatAlignment: heartbeat_alignment,
      durationDays: duration_days,
    });

    res.status(201).json({
      token_id: token.token_id,
      agent_id: token.agent_id,
      token: token,
      issued_at: new Date(token.issued_at * 1000).toISOString(),
      expires_at: new Date(token.expires_at * 1000).toISOString(),
      documentation: 'https://docs.medina.ai/memory-access-protocol',
    });
  } catch (error) {
    errorResponse(res, 'TOKEN_GENERATION_FAILED', error.message, 500);
  }
});

// ═══════════════════════════════════════════════════════════════════════════
// TOKEN REFRESH ENDPOINT
// ═══════════════════════════════════════════════════════════════════════════

/**
 * POST /api/memory/token/refresh
 * Refresh an expiring token
 */
app.post('/api/memory/token/refresh', validateToken, (req, res) => {
  try {
    const { additional_days = 90 } = req.body;

    const newToken = tokenRegistry.refreshToken(req.token.token_id, additional_days);

    res.json({
      old_token_id: req.token.token_id,
      new_token_id: newToken.token_id,
      new_token: newToken,
      issued_at: new Date(newToken.issued_at * 1000).toISOString(),
      expires_at: new Date(newToken.expires_at * 1000).toISOString(),
    });
  } catch (error) {
    errorResponse(res, 'REFRESH_FAILED', error.message, 500);
  }
});

// ═══════════════════════════════════════════════════════════════════════════
// SCHEMA ENDPOINT
// ═══════════════════════════════════════════════════════════════════════════

/**
 * GET /api/memory/schema
 * Get memory structure documentation
 */
app.get('/api/memory/schema', (req, res) => {
  res.json({
    protocol: 'PROT-380',
    version: '1.0.0',
    documentation_url: 'https://medina.ai/docs/memory-access',
    heartbeats: {
      METROPOLIS: {
        number: 1,
        frequency_hz: 0.1,
        role: 'Backend computation, truth processing',
      },
      COUPLING: {
        number: 2,
        frequency_hz: PHI,
        role: 'Resonance, consolidation',
      },
      REGULATING: {
        number: 3,
        frequency_hz: PHI * PHI,
        role: 'System orchestration',
      },
    },
    memory_types: ['EPISODIC', 'SEMANTIC', 'PROCEDURAL', 'WORKING', 'DOCTRINE'],
    operations: ['query', 'store', 'consolidate', 'traverse', 'pin'],
    error_codes: {
      2001: 'TOKEN_INVALID',
      2002: 'TOKEN_EXPIRED',
      2003: 'SCOPE_DENIED',
      2004: 'QUOTA_EXCEEDED',
      2005: 'DOCTRINE_VIOLATION',
      2006: 'MEMORY_NOT_FOUND',
      2007: 'OPERATION_UNSUPPORTED',
    },
    torus_topology: {
      theta: 'Angular position on helix [0, 2π)',
      phi: 'Toroidal rotation [0, 2π)',
      rho: 'Radial depth / salience',
      ring: 'Temporal ring (0-12)',
      beat: 'Creation timestamp',
    },
  });
});

// ═══════════════════════════════════════════════════════════════════════════
// HEALTH CHECK
// ═══════════════════════════════════════════════════════════════════════════

/**
 * GET /api/health
 * Health check
 */
app.get('/api/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    services: {
      token_registry: tokenRegistry.getStatus(),
      memory_coordinator: coordinator.getStatus(),
    },
  });
});

// ═══════════════════════════════════════════════════════════════════════════
// WEBSOCKET SUPPORT
// ═══════════════════════════════════════════════════════════════════════════

const wsClients = new Set();

/**
 * WebSocket handler for real-time memory updates
 */
function handleWebSocket(ws, req) {
  const tokenId = req.headers['x-token-id'];
  const agentId = req.headers['x-agent-id'];

  if (!tokenId || !agentId) {
    ws.close(401, 'MISSING_CREDENTIALS');
    return;
  }

  const token = tokenRegistry.getToken(tokenId);
  if (!token) {
    ws.close(401, 'TOKEN_NOT_FOUND');
    return;
  }

  wsClients.add({ ws, agentId, tokenId });

  ws.on('message', (data) => {
    try {
      const message = JSON.parse(data);
      // Handle subscription to memory updates
      // In production, would connect to memory change events
      ws.send(JSON.stringify({
        type: 'subscription_confirmed',
        agent_id: agentId,
        timestamp: new Date().toISOString(),
      }));
    } catch (error) {
      ws.send(JSON.stringify({ error: 'INVALID_MESSAGE' }));
    }
  });

  ws.on('close', () => {
    wsClients.forEach(client => {
      if (client.agentId === agentId) {
        wsClients.delete(client);
      }
    });
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// SERVER INITIALIZATION
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Start server with WebSocket support
 */
function startServer(port = 3000) {
  const server = require('http').createServer(app);

  const wss = new WebSocket.Server({ server });
  wss.on('connection', handleWebSocket);

  server.listen(port, () => {
    console.log(`[MEMORIA_ACCESSU] Public API listening on port ${port}`);
    console.log(`[MEMORIA_ACCESSU] Protocol: PROT-380 + PROT-388`);
    console.log(`[MEMORIA_ACCESSU] Frequency: ${PHI}Hz (COUPLING heart)`);
  });

  return server;
}

module.exports = {
  app,
  startServer,
  tokenRegistry,
  coordinator,
};
