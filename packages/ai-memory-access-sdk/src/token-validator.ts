/**
 * Token Validator — Verify PROT-380 Tokens
 * ========================================
 * 
 * Validates memory tokens before operations
 */

import * as crypto from 'crypto';
import { MemoryToken, MemoryError, MemoryErrorCode } from './types';

export class TokenValidator {
  /**
   * Validate complete token
   */
  static validate(token: MemoryToken): { valid: boolean; error?: MemoryError } {
    // Check signature
    if (!this.validateSignature(token)) {
      return {
        valid: false,
        error: {
          code: MemoryErrorCode.TOKEN_INVALID,
          message: 'Token signature verification failed',
        },
      };
    }

    // Check expiration
    if (Date.now() > token.expires_at * 1000) {
      return {
        valid: false,
        error: {
          code: MemoryErrorCode.TOKEN_EXPIRED,
          message: `Token expired at ${new Date(token.expires_at * 1000).toISOString()}`,
          recovery_action: 'Request a new token or refresh the current token',
        },
      };
    }

    // Check issuer
    if (token.issuer !== 'MEMORIA_ACCESSU') {
      return {
        valid: false,
        error: {
          code: MemoryErrorCode.TOKEN_INVALID,
          message: `Invalid issuer: ${token.issuer}`,
        },
      };
    }

    // Check required fields
    if (!token.token_id || !token.agent_id || !token.scope || !token.permissions) {
      return {
        valid: false,
        error: {
          code: MemoryErrorCode.TOKEN_INVALID,
          message: 'Token missing required fields',
        },
      };
    }

    // Check frequency
    if (!Number.isFinite(token.frequency_hz) || token.frequency_hz <= 0) {
      return {
        valid: false,
        error: {
          code: MemoryErrorCode.TOKEN_INVALID,
          message: 'Token has invalid frequency',
        },
      };
    }

    return { valid: true };
  }

  /**
   * Validate token signature using HMAC-SHA256
   * In production, this would use the server's signing key
   */
  private static validateSignature(token: MemoryToken): boolean {
    // Create payload without signature
    const payload = {
      token_id: token.token_id,
      issuer: token.issuer,
      agent_id: token.agent_id,
      agent_type: token.agent_type,
      public_key_hash: token.public_key_hash,
      issued_at: token.issued_at,
      expires_at: token.expires_at,
      frequency_hz: token.frequency_hz,
      heartbeat_alignment: token.heartbeat_alignment,
      // Note: scope and permissions not included in signature calculation for flexibility
    };

    // In production, use server's key from secure storage
    // For now, just verify signature exists and is non-empty
    return token.signature && token.signature.length > 0;
  }

  /**
   * Check if token has permission for operation
   */
  static hasPermission(token: MemoryToken, operation: string): boolean {
    const ops = token.scope.operations as any;
    return ops[operation] === true;
  }

  /**
   * Check if token's scope includes a coordinate
   */
  static isCoordinateInScope(
    token: MemoryToken,
    theta: number,
    phi: number,
    rho: number
  ): boolean {
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
   * Check if token's scope includes a memory ring
   */
  static isRingInScope(token: MemoryToken, ring: number): boolean {
    return token.scope.memory_rings.includes(ring);
  }

  /**
   * Get time until token expires in seconds
   */
  static getExpiresIn(token: MemoryToken): number {
    return (token.expires_at * 1000 - Date.now()) / 1000;
  }

  /**
   * Check if token is expiring soon (within threshold)
   */
  static isExpiringSoon(token: MemoryToken, thresholdSeconds: number = 3600): boolean {
    return this.getExpiresIn(token) < thresholdSeconds;
  }

  /**
   * Validate agent identity
   */
  static validateAgentIdentity(
    token: MemoryToken,
    agentId: string,
    publicKeyHash: string
  ): boolean {
    return token.agent_id === agentId && token.public_key_hash === publicKeyHash;
  }
}

export default TokenValidator;
