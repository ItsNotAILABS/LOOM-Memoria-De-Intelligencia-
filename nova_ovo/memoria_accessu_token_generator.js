/**
 * MEMORIA ACCESSU TOKEN GENERATOR — Memory Access Token Service
 * ==============================================================
 * 
 * Generates, validates, and manages PROT-380+ Memory Access Tokens
 * Extension to memory-token-worker.js focused on access tokens (not PoW tokens)
 * 
 * Protocol: PROT-293 + PROT-380
 * Frequency: φ⁷ = 29.03 Hz (Transcendent Layer)
 * 
 * @author Alfredo "Freddy" Medina Hernandez
 * @copyright 2026 Medina Tech, Dallas, TX
 * @license ISIL-1.0
 */

const crypto = require('crypto');

const PHI = 1.6180339887498948482;
const PHI_7 = Math.pow(PHI, 7);  // 29.03 Hz

/**
 * Access token state management
 */
class TokenRegistry {
  constructor() {
    this.tokens = new Map();
    this.tokensByAgent = new Map();
    this.auditLog = [];
  }

  /**
   * Generate new access token
   */
  generateToken({
    agentId,
    agentType,
    publicKeyHash,
    scope,
    permissions,
    heartbeatAlignment,
    durationDays = 90,
  }) {
    if (!agentId || !agentType || !scope) {
      throw new Error('Missing required token fields');
    }

    const tokenId = this.generateTokenId();
    const now = Math.floor(Date.now() / 1000);
    const expiresAt = now + (durationDays * 86400);

    // Create token payload
    const tokenPayload = {
      token_id: tokenId,
      issuer: 'MEMORIA_ACCESSU',
      agent_id: agentId,
      agent_type: agentType,
      public_key_hash: publicKeyHash,
      scope: scope,
      permissions: permissions,
      issued_at: now,
      expires_at: expiresAt,
      frequency_hz: this.getHeartbeatFrequency(heartbeatAlignment),
      signature: '',  // Will be signed
      heartbeat_alignment: heartbeatAlignment,
    };

    // Sign token (HMAC-SHA256)
    const signature = this.signToken(tokenPayload);
    tokenPayload.signature = signature;

    // Store token
    this.tokens.set(tokenId, tokenPayload);

    // Index by agent
    if (!this.tokensByAgent.has(agentId)) {
      this.tokensByAgent.set(agentId, []);
    }
    this.tokensByAgent.get(agentId).push(tokenId);

    // Audit log
    this.logAudit('token_generated', {
      token_id: tokenId,
      agent_id: agentId,
      agent_type: agentType,
      expires_at: expiresAt,
    });

    return tokenPayload;
  }

  /**
   * Validate token signature and expiration
   */
  validateToken(tokenId) {
    const token = this.tokens.get(tokenId);
    if (!token) {
      return { valid: false, reason: 'TOKEN_NOT_FOUND' };
    }

    // Check expiration
    if (Math.floor(Date.now() / 1000) > token.expires_at) {
      return { valid: false, reason: 'TOKEN_EXPIRED' };
    }

    // Verify signature
    const payload = { ...token };
    const storedSignature = payload.signature;
    payload.signature = '';
    const expectedSignature = this.signToken(payload);

    if (storedSignature !== expectedSignature) {
      return { valid: false, reason: 'INVALID_SIGNATURE' };
    }

    return { valid: true };
  }

  /**
   * Refresh token (extend expiration)
   */
  refreshToken(tokenId, additionalDays = 90) {
    const token = this.tokens.get(tokenId);
    if (!token) {
      throw new Error('Token not found');
    }

    const validation = this.validateToken(tokenId);
    if (!validation.valid && validation.reason !== 'TOKEN_EXPIRED') {
      throw new Error(`Cannot refresh token: ${validation.reason}`);
    }

    // Generate new token with same properties but extended expiration
    const newTokenId = this.generateTokenId();
    const now = Math.floor(Date.now() / 1000);
    const expiresAt = now + (additionalDays * 86400);

    const newToken = {
      ...token,
      token_id: newTokenId,
      issued_at: now,
      expires_at: expiresAt,
      signature: '',
    };

    const signature = this.signToken(newToken);
    newToken.signature = signature;

    // Store new token
    this.tokens.set(newTokenId, newToken);

    // Invalidate old token gracefully (keep for 24 hours during transition)
    const oldTokenTransitionEnd = token.expires_at + 86400;
    this.tokens.set(tokenId, { ...token, _deprecated: true, _transition_end: oldTokenTransitionEnd });

    // Audit
    this.logAudit('token_refreshed', {
      old_token_id: tokenId,
      new_token_id: newTokenId,
      agent_id: token.agent_id,
      new_expires_at: expiresAt,
    });

    return newToken;
  }

  /**
   * Revoke token immediately
   */
  revokeToken(tokenId, reason = 'admin_revocation') {
    const token = this.tokens.get(tokenId);
    if (!token) {
      throw new Error('Token not found');
    }

    this.tokens.delete(tokenId);

    // Audit
    this.logAudit('token_revoked', {
      token_id: tokenId,
      agent_id: token.agent_id,
      reason: reason,
    });
  }

  /**
   * Get token info
   */
  getToken(tokenId) {
    return this.tokens.get(tokenId);
  }

  /**
   * Get all tokens for an agent
   */
  getAgentTokens(agentId) {
    const tokenIds = this.tokensByAgent.get(agentId) || [];
    return tokenIds
      .map(id => this.tokens.get(id))
      .filter(token => token && !token._deprecated);
  }

  /**
   * Check scope permission for operation
   */
  hasPermission(tokenId, operation) {
    const token = this.tokens.get(tokenId);
    if (!token) return false;
    return token.scope.operations[operation] === true;
  }

  /**
   * Check if coordinate is within token scope
   */
  isCoordinateInScope(tokenId, theta, phi, rho) {
    const token = this.tokens.get(tokenId);
    if (!token) return false;

    const range = token.scope.coordinate_range;
    return (
      theta >= range.theta_min &&
      theta <= range.theta_max &&
      phi >= range.phi_min &&
      phi <= range.phi_max &&
      rho >= range.rho_min &&
      rho <= range.rho_max
    );
  }

  /**
   * Get audit trail
   */
  getAuditLog(filter = {}) {
    let log = this.auditLog;

    if (filter.agent_id) {
      log = log.filter(entry => entry.data.agent_id === filter.agent_id);
    }

    if (filter.event_type) {
      log = log.filter(entry => entry.event_type === filter.event_type);
    }

    if (filter.since) {
      log = log.filter(entry => entry.timestamp >= filter.since);
    }

    return log;
  }

  /**
   * Sign token payload with HMAC-SHA256
   */
  signToken(payload) {
    // In production, use key from secure storage
    const signingKey = process.env.MEMORIA_SIGNING_KEY || 'medina-default-signing-key';
    const payloadStr = JSON.stringify(payload);
    return crypto
      .createHmac('sha256', signingKey)
      .update(payloadStr)
      .digest('hex');
  }

  /**
   * Get heartbeat frequency for alignment
   */
  getHeartbeatFrequency(heartbeat) {
    switch (heartbeat) {
      case 1: return 0.1;          // METROPOLIS
      case 2: return PHI;           // COUPLING
      case 3: return PHI * PHI;     // REGULATING
      default: return PHI;
    }
  }

  /**
   * Generate unique token ID
   */
  generateTokenId() {
    const timestamp = Date.now().toString(36);
    const randomPart = crypto.randomBytes(8).toString('hex');
    return `MEM_${timestamp}_${randomPart}`.toUpperCase();
  }

  /**
   * Log audit entry
   */
  logAudit(eventType, data) {
    this.auditLog.push({
      audit_id: `AUDIT_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
      timestamp: Math.floor(Date.now() / 1000),
      event_type: eventType,
      data: data,
    });

    // Keep audit log to last 10,000 entries
    if (this.auditLog.length > 10000) {
      this.auditLog = this.auditLog.slice(-10000);
    }
  }

  /**
   * Get registry status
   */
  getStatus() {
    const validTokens = Array.from(this.tokens.values())
      .filter(token => !token._deprecated && Math.floor(Date.now() / 1000) <= token.expires_at);

    const tokensByType = {};
    validTokens.forEach(token => {
      const type = token.agent_type;
      tokensByType[type] = (tokensByType[type] || 0) + 1;
    });

    return {
      service: 'memoria-accessu-token-generator',
      protocol: 'PROT-293 + PROT-380',
      frequency_hz: PHI_7,
      total_tokens: this.tokens.size,
      valid_tokens: validTokens.length,
      tokens_by_type: tokensByType,
      agents_with_tokens: this.tokensByAgent.size,
      audit_log_entries: this.auditLog.length,
    };
  }
}

module.exports = { TokenRegistry, PHI_7 };
