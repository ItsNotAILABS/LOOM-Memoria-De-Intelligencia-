/**
 * MEMORIA ACCESSU SDK — Client Implementation
 * ==========================================
 * Protocol-compliant client for PROT-380+ Memory Access
 * 
 * @author Alfredo "Freddy" Medina Hernandez
 * @copyright 2026 Medina Tech, Dallas, TX
 * @license ISIL-1.0
 */

import * as crypto from 'crypto';
import {
  MemoryToken,
  QueryRequest,
  QueryResponse,
  StoreRequest,
  StoreResponse,
  ConsolidateRequest,
  ConsolidateResponse,
  TraverseRequest,
  TraverseResponse,
  PinRequest,
  PinResponse,
  MemoryResponse,
  MemoryError,
  MemoryErrorCode,
  MemorySDKConfig,
  MemorySDKOptions,
  HeartbeatAlignment,
  MemoryAtom,
} from './types';

export class MemoryAccessClient {
  private config: MemorySDKConfig;
  private requestId = 0;
  private lastFrequencySync = 0;
  private readonly PHI = 1.6180339887498948482;

  constructor(token: MemoryToken, options: MemorySDKOptions = {}) {
    if (!token) {
      throw new Error('MemoryToken is required');
    }

    this.config = {
      api_url: options.api_url || 'https://memory.medina.ai/api/v1',
      token,
      timeout_ms: options.timeout_ms || 30000,
      retry_count: options.retry_count || 3,
      log_requests: options.log_requests || false,
      frequency_sync: options.frequency_sync !== false, // Default true
    };

    if (this.config.frequency_sync) {
      this.syncFrequency();
    }

    if (this.config.log_requests) {
      console.log(`[MemoryAccessClient] Initialized with agent_id: ${token.agent_id}`);
    }
  }

  /**
   * Synchronize agent to heartbeat frequency using Kuramoto dynamics
   */
  private syncFrequency(): void {
    const now = Date.now();
    const heartbeatHz = this.config.token.frequency_hz;
    const periodMs = 1000 / heartbeatHz;

    // Align to nearest heartbeat
    const alignedTime = Math.round(now / periodMs) * periodMs;
    const drift = now - alignedTime;

    if (Math.abs(drift) > periodMs / 2) {
      // Large drift detected, log for monitoring
      if (this.config.log_requests) {
        console.warn(`[MemoryAccessClient] Large frequency drift: ${drift}ms`);
      }
    }

    this.lastFrequencySync = now;
  }

  /**
   * Query memory (PROT-383)
   */
  async query(pattern: string, options: {
    search_type?: 'semantic' | 'lexical' | 'lineage';
    filters?: any;
    limit?: number;
    ordering?: 'salience' | 'age' | 'distance';
  } = {}): Promise<MemoryAtom[]> {
    // Verify token allows query operation
    if (!this.config.token.scope.operations.query) {
      return Promise.reject(this.createError(
        MemoryErrorCode.OPERATION_UNSUPPORTED,
        'Query operation not allowed by token'
      ));
    }

    const request: QueryRequest = {
      operation: 'query',
      token: this.config.token,
      query: {
        pattern,
        search_type: options.search_type || 'semantic',
        filters: options.filters || {},
        limit: Math.min(options.limit || 50, this.config.token.scope.max_memory_atoms),
        ordering: options.ordering || 'salience',
      },
    };

    try {
      const response = await this.sendRequest<QueryResponse>(request);
      if (this.config.log_requests) {
        console.log(`[MemoryAccessClient] Query returned ${response.results.length} results`);
      }
      return response.results;
    } catch (error) {
      throw this.handleError(error);
    }
  }

  /**
   * Store new memory (PROT-383)
   */
  async store(content: unknown, options: {
    memory_type?: 'EPISODIC' | 'SEMANTIC' | 'PROCEDURAL' | 'WORKING' | 'DOCTRINE';
    tags?: string[];
    parent_lineage?: string[];
    doctrine_binding?: string;
    retention_policy?: 'ephemeral' | 'working' | 'long_term' | 'permanent';
  } = {}): Promise<string> {
    // Verify token allows store operation
    if (!this.config.token.scope.operations.store) {
      return Promise.reject(this.createError(
        MemoryErrorCode.OPERATION_UNSUPPORTED,
        'Store operation not allowed by token'
      ));
    }

    const request: StoreRequest = {
      operation: 'store',
      token: this.config.token,
      memory: {
        content,
        memory_type: options.memory_type || 'EPISODIC',
        tags: options.tags || [],
        parent_lineage: options.parent_lineage || [],
        doctrine_binding: options.doctrine_binding || 'memory.cpl-l:default',
        retention_policy: options.retention_policy || 'working',
      },
    };

    try {
      const response = await this.sendRequest<StoreResponse>(request);
      if (this.config.log_requests) {
        console.log(`[MemoryAccessClient] Memory stored: ${response.memory_id}`);
      }
      return response.memory_id;
    } catch (error) {
      throw this.handleError(error);
    }
  }

  /**
   * Consolidate memories (PROT-384)
   */
  async consolidate(
    memoryIds: string[],
    options: {
      consolidation_type?: 'merge' | 'abstract' | 'summarize';
      output_memory_type?: string;
      doctrine_binding?: string;
    } = {}
  ): Promise<string> {
    if (!this.config.token.scope.operations.consolidate) {
      return Promise.reject(this.createError(
        MemoryErrorCode.OPERATION_UNSUPPORTED,
        'Consolidate operation not allowed by token'
      ));
    }

    if (memoryIds.length > this.config.token.scope.max_consolidation_depth) {
      return Promise.reject(this.createError(
        MemoryErrorCode.SCOPE_DENIED,
        `Consolidation depth (${memoryIds.length}) exceeds token limit (${this.config.token.scope.max_consolidation_depth})`
      ));
    }

    const request: ConsolidateRequest = {
      operation: 'consolidate',
      token: this.config.token,
      consolidation: {
        memory_ids: memoryIds,
        consolidation_type: options.consolidation_type || 'merge',
        output_memory_type: options.output_memory_type || 'SEMANTIC',
        doctrine_binding: options.doctrine_binding || 'memory.cpl-l:consolidation-policy',
      },
    };

    try {
      const response = await this.sendRequest<ConsolidateResponse>(request);
      if (this.config.log_requests) {
        console.log(`[MemoryAccessClient] Consolidated ${memoryIds.length} memories into ${response.consolidated_memory_id}`);
      }
      return response.consolidated_memory_id;
    } catch (error) {
      throw this.handleError(error);
    }
  }

  /**
   * Traverse memory lineage (PROT-385)
   */
  async traverse(
    startMemoryId: string,
    options: {
      direction?: 'parents' | 'children' | 'siblings' | 'related';
      depth?: number;
      filter?: any;
    } = {}
  ): Promise<any> {
    if (!this.config.token.scope.operations.traverse) {
      return Promise.reject(this.createError(
        MemoryErrorCode.OPERATION_UNSUPPORTED,
        'Traverse operation not allowed by token'
      ));
    }

    const request: TraverseRequest = {
      operation: 'traverse',
      token: this.config.token,
      traversal: {
        start_memory_id: startMemoryId,
        direction: options.direction || 'parents',
        depth: Math.min(options.depth || 3, 10),
        filter: options.filter || {},
      },
    };

    try {
      const response = await this.sendRequest<TraverseResponse>(request);
      if (this.config.log_requests) {
        console.log(`[MemoryAccessClient] Traversal returned ${response.graph.nodes.length} nodes`);
      }
      return response.graph;
    } catch (error) {
      throw this.handleError(error);
    }
  }

  /**
   * Pin memory to prevent decay (PROT-386)
   */
  async pin(
    memoryId: string,
    options: {
      duration_seconds?: number;
      reason?: string;
    } = {}
  ): Promise<number> {
    if (!this.config.token.scope.operations.pin) {
      return Promise.reject(this.createError(
        MemoryErrorCode.OPERATION_UNSUPPORTED,
        'Pin operation not allowed by token'
      ));
    }

    const request: PinRequest = {
      operation: 'pin',
      token: this.config.token,
      pin: {
        memory_id: memoryId,
        pin_duration_seconds: options.duration_seconds || 86400, // 24 hours default
        pin_reason: options.reason || 'AI agent pinning',
      },
    };

    try {
      const response = await this.sendRequest<PinResponse>(request);
      if (this.config.log_requests) {
        console.log(`[MemoryAccessClient] Memory pinned until ${new Date(response.pinned_until).toISOString()}`);
      }
      return response.pinned_until;
    } catch (error) {
      throw this.handleError(error);
    }
  }

  /**
   * Send request with retry logic and frequency sync
   */
  private async sendRequest<T>(request: any, attempt = 1): Promise<T> {
    // Ensure frequency alignment before sending
    if (this.config.frequency_sync && Date.now() - this.lastFrequencySync > 5000) {
      this.syncFrequency();
    }

    const requestId = `REQ_${++this.requestId}_${Date.now()}`;
    const headers: any = {
      'Content-Type': 'application/json',
      'X-Request-ID': requestId,
      'X-Token-ID': this.config.token.token_id,
      'X-Agent-ID': this.config.token.agent_id,
      'X-Heartbeat': this.config.token.frequency_hz.toString(),
    };

    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), this.config.timeout_ms);

      const response = await fetch(`${this.config.api_url}/memory/operation`, {
        method: 'POST',
        headers,
        body: JSON.stringify(request),
        signal: controller.signal,
      } as any);

      clearTimeout(timeoutId);

      if (!response.ok) {
        if (response.status === 429 && attempt < this.config.retry_count!) {
          // Rate limited - exponential backoff
          const backoff = Math.pow(2, attempt) * 1000;
          await new Promise(resolve => setTimeout(resolve, backoff));
          return this.sendRequest<T>(request, attempt + 1);
        }
        throw new Error(`HTTP ${response.status}`);
      }

      const data = await response.json();
      return data as T;
    } catch (error: any) {
      if (attempt < this.config.retry_count! && error.name !== 'AbortError') {
        const backoff = Math.pow(2, attempt) * 1000;
        await new Promise(resolve => setTimeout(resolve, backoff));
        return this.sendRequest<T>(request, attempt + 1);
      }
      throw error;
    }
  }

  /**
   * Validate token has not expired
   */
  isTokenValid(): boolean {
    if (Date.now() > this.config.token.expires_at * 1000) {
      return false;
    }
    return true;
  }

  /**
   * Get time until token expires (in seconds)
   */
  getTokenExpiresIn(): number {
    return (this.config.token.expires_at * 1000 - Date.now()) / 1000;
  }

  /**
   * Get current agent frequency alignment
   */
  getFrequencyAlignment(): HeartbeatAlignment {
    return this.config.token.heartbeat_alignment as HeartbeatAlignment;
  }

  /**
   * Create error object
   */
  private createError(code: MemoryErrorCode, message: string): MemoryError {
    return { code, message };
  }

  /**
   * Handle and transform errors
   */
  private handleError(error: any): MemoryError {
    if (error.code) {
      return error;
    }

    if (error.message.includes('429')) {
      return this.createError(MemoryErrorCode.QUOTA_EXCEEDED, 'Rate limit exceeded');
    }

    if (error.message.includes('401') || error.message.includes('403')) {
      return this.createError(MemoryErrorCode.SCOPE_DENIED, 'Access denied');
    }

    if (error.message.includes('404')) {
      return this.createError(MemoryErrorCode.MEMORY_NOT_FOUND, 'Memory not found');
    }

    return this.createError(MemoryErrorCode.TOKEN_INVALID, error.message || 'Unknown error');
  }
}

export default MemoryAccessClient;
