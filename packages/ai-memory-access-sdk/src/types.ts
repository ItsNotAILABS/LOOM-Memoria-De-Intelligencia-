/**
 * MEMORIA ACCESSU SDK — Core Types
 * ================================
 * Type definitions for PROT-380+ Memory Access Protocol
 * 
 * @author Alfredo "Freddy" Medina Hernandez
 * @copyright 2026 Medina Tech, Dallas, TX
 * @license ISIL-1.0
 */

/**
 * Memory token issued by the memory token service (PROT-293)
 */
export interface MemoryToken {
  token_id: string;
  issuer: 'MEMORIA_ACCESSU';
  agent_id: string;
  agent_type: 'LLM' | 'WORKER' | 'ECOSYSTEM';
  public_key_hash: string;
  scope: AccessScope;
  permissions: string[];
  issued_at: number;
  expires_at: number;
  frequency_hz: number;
  signature: string;
  heartbeat_alignment: 1 | 2 | 3;
}

/**
 * Defines what a token can access
 */
export interface AccessScope {
  memory_rings: number[];
  coordinate_range: CoordinateRange;
  salience_floor: number;
  max_memory_atoms: number;
  max_consolidation_depth: number;
  operations: OperationPermissions;
  doctrine_binding: string;
}

export interface CoordinateRange {
  theta_min: number;
  theta_max: number;
  phi_min: number;
  phi_max: number;
  rho_min: number;
  rho_max: number;
}

export interface OperationPermissions {
  query: boolean;
  store: boolean;
  consolidate: boolean;
  traverse: boolean;
  pin: boolean;
  delete: boolean;
}

/**
 * Torus coordinates for memory location
 */
export interface TorusCoordinates {
  theta: number;      // Angular position on helix [0, 2π)
  phi: number;        // Toroidal rotation [0, 2π)
  rho: number;        // Radial depth / salience
  ring: number;       // Temporal ring (0-12)
  beat: number;       // Creation beat/timestamp
}

/**
 * Memory atom - single unit of stored information
 */
export interface MemoryAtom {
  memory_id: string;
  torus_coordinates: TorusCoordinates;
  content: unknown;
  salience: number;
  memory_type: 'EPISODIC' | 'SEMANTIC' | 'PROCEDURAL' | 'WORKING' | 'DOCTRINE';
  created_at: number;
  last_accessed: number;
  lineage: string[];
  tags: string[];
}

/**
 * Query request (PROT-383)
 */
export interface QueryRequest {
  operation: 'query';
  token: MemoryToken;
  query: {
    pattern: string;
    search_type: 'semantic' | 'lexical' | 'lineage';
    filters: QueryFilters;
    limit: number;
    ordering: 'salience' | 'age' | 'distance';
  };
}

export interface QueryFilters {
  memory_type?: 'EPISODIC' | 'SEMANTIC' | 'PROCEDURAL' | 'WORKING' | 'DOCTRINE';
  min_salience?: number;
  max_age_seconds?: number;
  tags?: string[];
}

export interface QueryResponse {
  request_id: string;
  timestamp: number;
  token_id: string;
  results: MemoryAtom[];
  total_available: number;
  audit_entry_id: string;
}

/**
 * Store request (PROT-383)
 */
export interface StoreRequest {
  operation: 'store';
  token: MemoryToken;
  memory: {
    content: unknown;
    memory_type: 'EPISODIC' | 'SEMANTIC' | 'PROCEDURAL' | 'WORKING' | 'DOCTRINE';
    tags: string[];
    parent_lineage: string[];
    doctrine_binding: string;
    retention_policy: 'ephemeral' | 'working' | 'long_term' | 'permanent';
  };
}

export interface StoreResponse {
  request_id: string;
  timestamp: number;
  token_id: string;
  memory_id: string;
  torus_coordinates: TorusCoordinates;
  salience_initial: number;
  audit_entry_id: string;
}

/**
 * Consolidate request (PROT-384)
 */
export interface ConsolidateRequest {
  operation: 'consolidate';
  token: MemoryToken;
  consolidation: {
    memory_ids: string[];
    consolidation_type: 'merge' | 'abstract' | 'summarize';
    output_memory_type: string;
    doctrine_binding: string;
  };
}

export interface ConsolidateResponse {
  request_id: string;
  timestamp: number;
  token_id: string;
  consolidated_memory_id: string;
  consumed_memories: string[];
  torus_coordinates: TorusCoordinates;
  compression_ratio: number;
  audit_entry_id: string;
}

/**
 * Traverse request (PROT-385)
 */
export interface TraverseRequest {
  operation: 'traverse';
  token: MemoryToken;
  traversal: {
    start_memory_id: string;
    direction: 'parents' | 'children' | 'siblings' | 'related';
    depth: number;
    filter: TraverseFilter;
  };
}

export interface TraverseFilter {
  memory_type?: string;
  min_salience?: number;
}

export interface TraverseResponse {
  request_id: string;
  timestamp: number;
  token_id: string;
  graph: {
    nodes: TraverseNode[];
    edges: TraverseEdge[];
  };
  audit_entry_id: string;
}

export interface TraverseNode {
  memory_id: string;
  salience: number;
  memory_type: string;
  brief_content: string;
}

export interface TraverseEdge {
  from_memory_id: string;
  to_memory_id: string;
  relationship_type: string;
}

/**
 * Pin request (PROT-386)
 */
export interface PinRequest {
  operation: 'pin';
  token: MemoryToken;
  pin: {
    memory_id: string;
    pin_duration_seconds: number;
    pin_reason: string;
  };
}

export interface PinResponse {
  request_id: string;
  timestamp: number;
  token_id: string;
  memory_id: string;
  pinned_until: number;
  audit_entry_id: string;
}

/**
 * Error response codes (Section VII in protocol)
 */
export enum MemoryErrorCode {
  TOKEN_INVALID = 2001,
  TOKEN_EXPIRED = 2002,
  SCOPE_DENIED = 2003,
  QUOTA_EXCEEDED = 2004,
  DOCTRINE_VIOLATION = 2005,
  MEMORY_NOT_FOUND = 2006,
  OPERATION_UNSUPPORTED = 2007,
}

export interface MemoryError {
  code: MemoryErrorCode;
  message: string;
  recovery_action?: string;
}

/**
 * Unified response type
 */
export type MemoryResponse =
  | QueryResponse
  | StoreResponse
  | ConsolidateResponse
  | TraverseResponse
  | PinResponse
  | { error: MemoryError };

/**
 * Heartbeat alignment for Kuramoto synchronization
 */
export enum HeartbeatAlignment {
  METROPOLIS = 1,    // 0.1 Hz
  COUPLING = 2,      // φ Hz ≈ 1.618 Hz
  REGULATING = 3,    // φ² Hz ≈ 2.618 Hz
}

/**
 * Configuration for SDK client
 */
export interface MemorySDKConfig {
  api_url: string;
  token: MemoryToken;
  timeout_ms?: number;
  retry_count?: number;
  log_requests?: boolean;
  frequency_sync?: boolean;
}

export interface MemorySDKOptions {
  api_url?: string;
  timeout_ms?: number;
  retry_count?: number;
  log_requests?: boolean;
  frequency_sync?: boolean;
}
