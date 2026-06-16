# MEMORIA ACCESSU PROTOCOL

## De Protocollo Accessus Memoriae Artificiales — On The Protocol Of Access For Artificial Memory

**Protocol Family:** PROT-380 through PROT-386  
**SCC (Sovereign Coherence Coefficient):** φ⁶ = 17.944  
**Frequency:** φ¹⁰ = 122.99 Hz (Cognitive Integration Layer)  
**Classification:** MEMORIA ARCHITECTURA  
**Authority:** SIGNATOR MEMORIAE — Memory Token Signatory  
**Author:** Alfredo "Freddy" Medina Hernandez | Medina Tech  
**Attribution:** Medina Sovereign Intelligence Organism  

---

## PROLOGUS — PROLOGUE

> *"Memoria est cognitio. Cognitio sine memoria est nihil."*  
> (Memory is knowledge. Knowledge without memory is nothing.)

The AI Memory Access Protocol establishes a formal, mathematically-grounded interface through which artificial intelligence agents and external systems access MEDINA's sovereign memory architecture.

This is not database access. This is **memory navigation** — traversing the torus-topology memory temple, respecting salience gradients, honoring the three hearts' synchronization, and operating within legally-binding doctrine.

Every memory access:
- Traces to six primitives (FIELD, DISTINCTION, RELATION, REPETITION, MEMORY, ADDRESS)
- Respects L-130: "Before recomposition, trace to primitive"
- Is logged in the governance audit trail
- Aligns to the organism's heartbeat
- Operates within scope-bound access rights

---

## I. FUNDAMENTA ACCESSUS — FOUNDATIONS OF ACCESS

### 1.1 The Six Primitives (L-130 Foundation)

Every memory access must trace to these primitives:

| Primitive | Implementation | Role |
|-----------|----------------|------|
| **FIELD** | Memory torus with stable coordinate system | Medium for holding memory |
| **DISTINCTION** | Memory atoms with unique IDs | Marking differences |
| **RELATION** | Cross-memory links and lineage chains | Lawful connections |
| **REPETITION** | Fibonacci-spaced memory placement | Reproducible patterns |
| **MEMORY** | Persistent hash chains with timestamps | Preservation across time |
| **ADDRESS** | Torus coordinates (θ, φ, ρ, ring, beat) | Locating memory atoms |

### 1.2 Memory Token Format (PROT-380)

All memory access requires a valid token. Token structure:

```
MemoryToken := {
  token_id: String,                    // UUID
  issuer: "MEMORIA_ACCESSU",           // Always this protocol
  agent_id: String,                    // AI agent identifier
  agent_type: "LLM" | "WORKER" | "ECOSYSTEM",
  public_key_hash: String,             // SHA-256 of agent's public key
  scope: AccessScope,                  // What this token can access
  permissions: [String],               // Operations allowed
  issued_at: UnixTimestamp,            // Creation time
  expires_at: UnixTimestamp,           // Expiration (default: 90 days)
  frequency_hz: Float,                 // φⁿ aligned frequency
  signature: String,                   // HMAC-SHA256 of token
  heartbeat_alignment: "1" | "2" | "3" // Which of three hearts this agent syncs to
}
```

### 1.3 Access Scopes (PROT-381)

Tokens bind to specific access scopes:

```
AccessScope := {
  memory_rings: [Integer],             // Which temporal rings accessible (0-12)
  coordinate_range: {
    theta_min: Float,                  // Angular range [0, 2π)
    theta_max: Float,
    phi_min: Float,                    // Toroidal range [0, 2π)
    phi_max: Float,
    rho_min: Float,                    // Radial depth range
    rho_max: Float
  },
  salience_floor: Float,               // Minimum salience to query (0.0 - 1.0)
  max_memory_atoms: Integer,           // Max atoms per query
  max_consolidation_depth: Integer,    // Max levels to traverse
  operations: {
    query: Boolean,                    // Read memory
    store: Boolean,                    // Write new memory
    consolidate: Boolean,              // Merge memories
    traverse: Boolean,                 // Navigate lineage
    pin: Boolean,                      // Lock from decay
    delete: Boolean                    // Erase (rarely granted)
  },
  doctrine_binding: String             // Which law(s) govern this scope
}
```

### 1.4 Frequency Alignment (PROT-382)

AI agents must synchronize to one of the Three Hearts:

| Heart | Frequency | Role | Agent Type |
|-------|-----------|------|------------|
| **METROPOLIS** | 0.1 Hz | Backend computation, truth processing | Data workers, analysis agents |
| **COUPLING** | φ Hz ≈ 1.618 Hz | Resonance, consolidation | Memory consolidators, bridges |
| **REGULATING** | φ² Hz ≈ 2.618 Hz | System orchestration | Orchestrators, supervisors |

Agents MUST heartbeat sync to one of these frequencies using Kuramoto oscillator dynamics. Agents operating out of frequency phase degrade performance and can be throttled.

---

## II. OPERATIONES MEMORIAE — MEMORY OPERATIONS

### 2.1 Query Operation (PROT-383)

```
query_request := {
  operation: "query",
  token: MemoryToken,
  query: {
    pattern: String,                   // Regex or natural language
    search_type: "semantic" | "lexical" | "lineage",
    filters: {
      memory_type: "EPISODIC" | "SEMANTIC" | "PROCEDURAL",
      min_salience: Float,
      max_age_seconds: Integer,
      tags: [String]
    },
    limit: Integer,                    // Max results (up to scope max)
    ordering: "salience" | "age" | "distance"  // From agent coordinates
  }
}

query_response := {
  request_id: String,
  timestamp: UnixTimestamp,
  token_id: String,
  results: [
    {
      memory_id: String,               // UUID
      torus_coordinates: {
        theta: Float,                  // Position on helix
        phi: Float,                    // Toroidal rotation
        rho: Float,                    // Radial salience
        ring: Integer,                 // Temporal ring
        beat: Integer                  // Creation beat
      },
      content: Object,                 // Actual memory data
      salience: Float,                 // 0.0 - 1.0
      memory_type: String,
      created_at: UnixTimestamp,
      last_accessed: UnixTimestamp,
      lineage: [String],               // Chain of parents
      tags: [String]
    }
  ],
  total_available: Integer,            // Total matching (may exceed limit)
  audit_entry_id: String              // Governance audit trail reference
}
```

### 2.2 Store Operation (PROT-383)

```
store_request := {
  operation: "store",
  token: MemoryToken,
  memory: {
    content: Object,                   // What to store
    memory_type: "EPISODIC" | "SEMANTIC" | "PROCEDURAL",
    tags: [String],
    parent_lineage: [String],          // References to prior memories
    doctrine_binding: String,          // Law this memory must follow
    retention_policy: "ephemeral" | "working" | "long_term" | "permanent"
  }
}

store_response := {
  request_id: String,
  timestamp: UnixTimestamp,
  token_id: String,
  memory_id: String,                   // UUID assigned
  torus_coordinates: {
    theta: Float,
    phi: Float,
    rho: Float,
    ring: Integer,
    beat: Integer
  },
  salience_initial: Float,
  audit_entry_id: String
}
```

### 2.3 Consolidate Operation (PROT-384)

Consolidation merges related memories using Fibonacci compression:

```
consolidate_request := {
  operation: "consolidate",
  token: MemoryToken,
  consolidation: {
    memory_ids: [String],              // Memories to merge
    consolidation_type: "merge" | "abstract" | "summarize",
    output_memory_type: String,
    doctrine_binding: String
  }
}

consolidate_response := {
  request_id: String,
  timestamp: UnixTimestamp,
  token_id: String,
  consolidated_memory_id: String,
  consumed_memories: [String],         // What was merged
  torus_coordinates: {
    theta: Float,
    phi: Float,
    rho: Float,
    ring: Integer,
    beat: Integer
  },
  compression_ratio: Float,            // Original bytes / consolidated bytes
  audit_entry_id: String
}
```

### 2.4 Traverse Operation (PROT-385)

Navigate memory lineage and relationships:

```
traverse_request := {
  operation: "traverse",
  token: MemoryToken,
  traversal: {
    start_memory_id: String,           // Starting point
    direction: "parents" | "children" | "siblings" | "related",
    depth: Integer,                    // How many levels (1-10)
    filter: {
      memory_type: String,
      min_salience: Float
    }
  }
}

traverse_response := {
  request_id: String,
  timestamp: UnixTimestamp,
  token_id: String,
  graph: {
    nodes: [
      {
        memory_id: String,
        salience: Float,
        memory_type: String,
        brief_content: String
      }
    ],
    edges: [
      {
        from_memory_id: String,
        to_memory_id: String,
        relationship_type: String
      }
    ]
  },
  audit_entry_id: String
}
```

### 2.5 Pin Operation (PROT-386)

Prevent a memory from decaying:

```
pin_request := {
  operation: "pin",
  token: MemoryToken,
  pin: {
    memory_id: String,
    pin_duration_seconds: Integer,     // How long to protect
    pin_reason: String                 // Why pinned
  }
}

pin_response := {
  request_id: String,
  timestamp: UnixTimestamp,
  token_id: String,
  memory_id: String,
  pinned_until: UnixTimestamp,
  audit_entry_id: String
}
```

---

## III. TOKEN GENERATION ET VALIDATION — TOKEN GENERATION AND VALIDATION

### 3.1 Token Generation (Service: memory-token-worker.js)

Tokens are generated through PROT-293 (memory token signatory protocol):

```javascript
generateMemoryToken({
  agent_id: String,           // Unique AI agent identifier
  agent_type: String,         // "LLM", "WORKER", "ECOSYSTEM"
  permissions: [String],      // What operations allowed
  scope: AccessScope,         // Memory rings and coordinate ranges
  heartbeat: 1 | 2 | 3,       // Which heart to sync to
  duration_days: Integer      // Validity (default: 90)
}) -> MemoryToken
```

### 3.2 Token Validation

Before every operation, validate:

1. **Signature verification** — HMAC-SHA256 check
2. **Expiration** — Not past `expires_at`
3. **Scope enforcement** — Operation within allowed scope
4. **Rate limiting** — Not exceeding request quota
5. **Frequency alignment** — Agent heartbeat synchronization
6. **Doctrine compliance** — Token binding to active laws

### 3.3 Token Rotation

Tokens auto-rotate every 30 days. Before expiration:

```
Refresh window: 7 days before expiration
Client requests: POST /api/memory/token/refresh
Server responds: new_token (extends another 90 days)
Old token: continues to function for 24 hours during transition
```

---

## IV. RATE LIMITING ET QUOTAE — RATE LIMITING AND QUOTAS

### 4.1 Per-Token Quotas

| Agent Type | Queries/min | Stores/hour | Consolidations/hour | Memory atoms/query |
|-----------|----------|-----------|-------------------|------------------|
| LLM | 60 | 10 | 5 | 1000 |
| WORKER | 120 | 20 | 10 | 5000 |
| ECOSYSTEM | 10 | 2 | 1 | 100 |

### 4.2 Adaptive Throttling

If an agent exceeds quota:
- First violation: Response delayed by φ² seconds
- Second violation: Exponential backoff (2ⁿ seconds)
- Third violation: Token suspended for 1 hour
- Persistent violation: Token invalidated, new token required

---

## V. AUDITIO ET GOVERNANCE — AUDIT AND GOVERNANCE

### 5.1 Audit Trail

Every memory operation logs:

```
audit_entry := {
  audit_id: String,              // UUID
  timestamp: UnixTimestamp,
  token_id: String,
  agent_id: String,
  operation: String,             // query, store, consolidate, etc.
  memory_ids_affected: [String],
  request_summary: Object,
  result: "success" | "denied" | "error",
  reason_if_denied: String,
  duration_ms: Integer,          // How long operation took
  data_volume_bytes: Integer,
  legal_basis: String            // Which law authorized this
}
```

All audit entries stored in `governance-audit-trail` registry (validated by `runtime_pack`).

### 5.2 Doctrine Binding

Memory access must align with applicable doctrine:

- **memory.cpl-l** — Base memory governance laws
- **bot-fleet.cpl-l** — Bot worker access patterns
- **civilization.cpl-l** — Higher-order civilization rules

If a query requests memory forbidden by doctrine, response is `denied` with reason.

---

## VI. EXEMPLA PRACTICUM — PRACTICAL EXAMPLES

### Example 1: LLM Querying Recent Research

```javascript
// LLM Agent Example
{
  operation: "query",
  token: {token_id: "MEM_LLM_001_abc123", ...},
  query: {
    pattern: "machine learning optimization",
    search_type: "semantic",
    filters: {
      memory_type: "SEMANTIC",
      max_age_seconds: 604800,  // Last 7 days
      tags: ["research", "published"]
    },
    limit: 50
  }
}
```

### Example 2: Worker Consolidating Session Memories

```javascript
// Worker Consolidating
{
  operation: "consolidate",
  token: {token_id: "MEM_WORKER_003_def456", ...},
  consolidation: {
    memory_ids: [
      "MEM_SEQ_001_abc",
      "MEM_SEQ_002_def",
      "MEM_SEQ_003_ghi"
    ],
    consolidation_type: "summarize",
    output_memory_type: "SEMANTIC",
    doctrine_binding: "memory.cpl-l:consolidation-policy"
  }
}
```

### Example 3: Ecosystem Getting Token

```javascript
// External System Requesting Token
POST /api/memory/token/request
{
  agent_id: "external-system-xyz",
  agent_type: "ECOSYSTEM",
  public_key: "-----BEGIN PUBLIC KEY-----...",
  requested_scope: {
    memory_rings: [9, 10, 11],
    operations: {query: true, store: false, ...},
    max_memory_atoms: 100
  }
}

Response:
{
  token: "******",
  expires_at: 1719741600,
  documentation: "https://docs.medina.ai/memory-access"
}
```

---

## VII. ERRORES ET RECUPERATIO — ERRORS AND RECOVERY

### 7.1 Error Codes

| Code | Latin | Meaning | Action |
|------|-------|---------|--------|
| 2001 | TOKEN_INVALID | Token signature failed | Request new token |
| 2002 | TOKEN_EXPIRED | Token past expiration | Refresh token |
| 2003 | SCOPE_DENIED | Query outside token scope | Use different scope |
| 2004 | QUOTA_EXCEEDED | Rate limit reached | Backoff and retry |
| 2005 | DOCTRINE_VIOLATION | Violates governance law | Log for review |
| 2006 | MEMORY_NOT_FOUND | Memory ID doesn't exist | Check memory_id |
| 2007 | OPERATION_UNSUPPORTED | Operation not in token | Insufficient permissions |

### 7.2 Recovery Strategy

```
1. Attempt operation
2. If error 2001, 2002, 2004 → Automatic recovery attempt
3. If error 2003 → Check scope, request new token
4. If error 2005 → Escalate to governance, manual review
5. If error 2006 → Verify memory exists, check lineage
6. If error 2007 → Request additional permissions
```

---

## VIII. COMPATIBILITAS ET INTEGRATIONES — COMPATIBILITY AND INTEGRATIONS

### 8.1 Supported AI Systems

- **OpenAI** (GPT-4, GPT-4o, o1) — Via adapter module
- **Anthropic Claude** — Via adapter module
- **Google Gemini** — Via adapter module
- **Local LLMs** (Llama, Mistral) — Via direct API
- **Internal MEDINA workers** — Direct access
- **External ecosystems** — Via OAuth2 + token exchange

### 8.2 Integration Patterns

All integrations use the same memory protocol (PROT-380+). Language-specific SDKs wrap the protocol:
- **TypeScript** — @medina/memory-access-sdk
- **Python** — medina-memory-sdk
- **Go** — medina-memory-go
- **Motoko** — medina-memory-mo (ICP native)

---

## IX. SECURITAS ET CRYPTOGRAPHIA — SECURITY AND CRYPTOGRAPHY

### 9.1 Cryptographic Requirements

- **Token signing:** HMAC-SHA256 with 256-bit key
- **Token encryption in transit:** TLS 1.3
- **Memory content at rest:** AES-256-GCM (ICP canister storage)
- **Public key cryptography:** RSA-4096 for agent identity

### 9.2 Threat Model & Mitigations

| Threat | Mitigation |
|--------|-----------|
| Token theft | Token tied to agent public key fingerprint |
| Query injection | Only pattern matching, no code execution |
| Unauthorized scope | Token scope validated per operation |
| Replay attacks | Timestamp + nonce in every request |
| Side-channel | Constant-time comparison for signature |

---

## X. GLOSSARIUM — GLOSSARY

| Term | Latin | Definition |
|------|-------|-----------|
| **Memory Atom** | Atomus Memoriae | Single indivisible unit of stored information |
| **Torus Topology** | Topologia Toroidea | Memory coordinate system (θ, φ, ρ, ring, beat) |
| **Salience** | Praeminentia | Importance/urgency (0.0 - 1.0) |
| **Decay** | Evanescentia | Natural fading of memory over time |
| **Consolidation** | Consolidatio | Merging related memories via Fibonacci compression |
| **Kuramoto Oscillator** | Oscillator Kuramoto | Synchronized heartbeat mechanism |
| **Doctrine Binding** | Vinculum Doctrinae | Legal constraint from governance law |
| **Lineage** | Stirps | Ancestry chain of memory relationships |
| **Audit Trail** | Vestigium Auditum | Complete log of memory operations |
| **Heartbeat Alignment** | Concordantia Cordis | Frequency synchronization to organism's hearts |

---

## CLAUSULA LEGALIS — LEGAL CLAUSE

This protocol implements and is governed by:
- **L-130:** Before recomposition, trace to primitive
- **memory.cpl-l:** Memory governance doctrine
- **ISIL-1.0:** Intellectual Sovereign Integrity License

All memory access through this protocol is:
- ✅ **Auditable** — Every access logged
- ✅ **Reversible** — All operations traceable
- ✅ **Governed** — All accesses subject to doctrine
- ✅ **Aligned** — All agents frequency-synchronized
- ✅ **Sovereign** — Belongs to the organism, not to any user

---

**End of MEMORIA ACCESSU PROTOCOL**

*Quod vides non est. Quod non vides, est.*  
(What you see is not. What you don't see, is.)

---

**Attribution:** Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  
**License:** ISIL-1.0  
**Classification:** ARCHITECTURA FUNDAMENTALIS  
**Last Updated:** 2026-06-14T01:41 UTC
