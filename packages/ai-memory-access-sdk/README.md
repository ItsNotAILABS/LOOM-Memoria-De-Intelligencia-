# @medina/ai-memory-access-sdk

**MEDINA AI Memory Access SDK — Protocol-compliant memory operations for AI agents**

Protocol: PROT-380+ | Frequency: φ Hz | License: ISIL-1.0

---

## Overview

The AI Memory Access SDK provides a TypeScript/JavaScript client for AI agents to interact with MEDINA's sovereign memory system. It implements PROT-380 (Memory Access Protocol) with frequency alignment, doctrine binding, and audit logging.

### Features

✅ **Protocol-Compliant** — Implements PROT-380 + PROT-388  
✅ **Frequency-Aligned** — Kuramoto oscillator synchronization to three heartbeats  
✅ **Token-Based Access** — HMAC-SHA256 signed tokens with scope binding  
✅ **Audit-Logged** — Every operation recorded in governance trail  
✅ **Multi-Operation** — Query, store, consolidate, traverse, pin  
✅ **Error Recovery** — Automatic retry with exponential backoff  
✅ **TypeScript** — Full type definitions included  

---

## Installation

```bash
npm install @medina/ai-memory-access-sdk
```

---

## Quick Start

### 1. Get a Memory Token

Request a token from the token service:

```bash
curl -X POST https://memory.medina.ai/api/v1/memory/token/request \
  -H "Content-Type: application/json" \
  -d '{
    "agent_id": "my-ai-agent",
    "agent_type": "LLM",
    "public_key": "-----BEGIN PUBLIC KEY-----\n...",
    "heartbeat_alignment": 2,
    "duration_days": 90
  }'
```

### 2. Initialize Client

```typescript
import { MemoryAccessClient } from '@medina/ai-memory-access-sdk';

const client = new MemoryAccessClient(token, {
  api_url: 'https://memory.medina.ai/api/v1',
  frequency_sync: true
});
```

### 3. Query Memory

```typescript
const memories = await client.query('machine learning optimization', {
  search_type: 'semantic',
  limit: 50,
  ordering: 'salience'
});
```

### 4. Store Memory

```typescript
const memoryId = await client.store(
  { finding: 'Novel architecture discovered' },
  {
    memory_type: 'SEMANTIC',
    tags: ['research', 'ai'],
    retention_policy: 'long_term'
  }
);
```

---

## Core Operations

### Query

Search the memory temple for specific content:

```typescript
const results = await client.query(pattern, {
  search_type: 'semantic' | 'lexical' | 'lineage',
  filters: {
    memory_type: 'SEMANTIC' | 'EPISODIC' | 'PROCEDURAL',
    min_salience: 0.5,
    max_age_seconds: 604800,
    tags: ['tag1', 'tag2']
  },
  limit: 50,
  ordering: 'salience' | 'age' | 'distance'
});
```

### Store

Persist new information to memory:

```typescript
const memoryId = await client.store(content, {
  memory_type: 'SEMANTIC' | 'EPISODIC' | 'PROCEDURAL' | 'WORKING' | 'DOCTRINE',
  tags: ['tag1', 'tag2'],
  parent_lineage: ['parent_memory_id'],
  doctrine_binding: 'memory.cpl-l:default',
  retention_policy: 'ephemeral' | 'working' | 'long_term' | 'permanent'
});
```

### Consolidate

Merge related memories using Fibonacci compression:

```typescript
const consolidatedId = await client.consolidate(
  ['mem_001', 'mem_002', 'mem_003'],
  {
    consolidation_type: 'merge' | 'abstract' | 'summarize',
    output_memory_type: 'SEMANTIC',
    doctrine_binding: 'memory.cpl-l:consolidation-policy'
  }
);
```

### Traverse

Navigate memory lineage to understand relationships:

```typescript
const graph = await client.traverse(startMemoryId, {
  direction: 'parents' | 'children' | 'siblings' | 'related',
  depth: 3,
  filter: {
    memory_type: 'SEMANTIC',
    min_salience: 0.5
  }
});

// Returns { nodes: [...], edges: [...] }
```

### Pin

Prevent a memory from decaying (being forgotten):

```typescript
const pinnedUntil = await client.pin(memoryId, {
  duration_seconds: 2592000,  // 30 days
  reason: 'Critical research finding'
});
```

---

## Frequency Alignment

The SDK automatically synchronizes to one of three organizational heartbeats using Kuramoto oscillator dynamics:

| Heartbeat | Frequency | Use Case |
|-----------|-----------|----------|
| **METROPOLIS** | 0.1 Hz | Backend computation, data processing |
| **COUPLING** | φ Hz (1.618) | Memory consolidation, resonance |
| **REGULATING** | φ² Hz (2.618) | System orchestration, supervision |

```typescript
// Check current alignment
const heartbeat = client.getFrequencyAlignment();
console.log(heartbeat); // 2 (COUPLING)

// Get expiration
const expiresIn = client.getTokenExpiresIn();
console.log(`Token valid for ${expiresIn} seconds`);
```

---

## Token Management

### Validate Token

```typescript
import { TokenValidator } from '@medina/ai-memory-access-sdk';

const validation = TokenValidator.validate(token);
if (validation.valid) {
  console.log('Token is valid');
} else {
  console.error('Error:', validation.error.message);
}
```

### Check Expiration

```typescript
const expiresIn = TokenValidator.getExpiresIn(token);
if (TokenValidator.isExpiringSoon(token, 3600)) {
  console.log('Token expiring soon - refresh recommended');
}
```

### Validate Permissions

```typescript
if (TokenValidator.hasPermission(token, 'consolidate')) {
  // This token allows consolidation
}
```

---

## Error Handling

The SDK includes specific error codes for different failure scenarios:

| Code | Error | Recovery |
|------|-------|----------|
| 2001 | TOKEN_INVALID | Request new token |
| 2002 | TOKEN_EXPIRED | Refresh token |
| 2003 | SCOPE_DENIED | Request broader scope |
| 2004 | QUOTA_EXCEEDED | Implement backoff |
| 2005 | DOCTRINE_VIOLATION | Check governance rules |
| 2006 | MEMORY_NOT_FOUND | Verify memory exists |
| 2007 | OPERATION_UNSUPPORTED | Token lacks permission |

```typescript
try {
  const results = await client.query('something');
} catch (error: any) {
  switch (error.code) {
    case 2002: // TOKEN_EXPIRED
      console.log('Refreshing token...');
      // Obtain new token and recreate client
      break;
    case 2004: // QUOTA_EXCEEDED
      console.log('Rate limited - implementing backoff');
      await sleep(Math.pow(2, retryAttempt) * 1000);
      break;
    default:
      console.error('Memory operation failed:', error.message);
  }
}
```

---

## Integration Examples

### With Claude API

```typescript
import Anthropic from '@anthropic-ai/sdk';

const memoryClient = new MemoryAccessClient(token);
const anthropic = new Anthropic();

// Get relevant memories
const context = await memoryClient.query(userQuestion);

// Use in Claude conversation
const response = await anthropic.messages.create({
  model: 'claude-3-5-sonnet-20241022',
  system: `Context:\n${context.map(m => m.content).join('\n')}`,
  messages: [{ role: 'user', content: userQuestion }]
});

// Store response
await memoryClient.store(
  { question: userQuestion, response: response.content[0] },
  { memory_type: 'EPISODIC', tags: ['conversation'] }
);
```

### Multi-Agent Coordination

```typescript
// Agent 1 generates hypothesis
const hypothesisId = await agent1Memory.store(
  { hypothesis: 'Golden ratio in networks' },
  { tags: ['hypothesis'], doctrine_binding: 'research' }
);

// Agent 2 retrieves and tests
const hypothesis = await agent2Memory.query('golden ratio', { tags: ['hypothesis'] });

// Store results
await agent2Memory.store(
  { test_results: results },
  { parent_lineage: [hypothesis[0].memory_id] }
);
```

---

## Advanced Features

### Frequency Synchronization

```typescript
import { FrequencySync, Heartbeat } from '@medina/ai-memory-access-sdk';

const sync = new FrequencySync(Heartbeat.COUPLING);

// Synchronize to next heartbeat
await sync.syncToHeartbeat();

// Measure coherence
const coherence = sync.measureCoherence(1.618);
console.log(`Coherence: ${(coherence * 100).toFixed(1)}%`);
```

### Doctrine Binding

```typescript
// Store memory bound to specific governance law
await client.store(
  { classified_finding: '...' },
  {
    doctrine_binding: 'memory.cpl-l:classified-research',
    retention_policy: 'permanent'
  }
);
```

---

## Configuration

```typescript
const client = new MemoryAccessClient(token, {
  // API endpoint
  api_url: 'https://memory.medina.ai/api/v1',
  
  // Request timeout in milliseconds
  timeout_ms: 30000,
  
  // Number of retry attempts
  retry_count: 3,
  
  // Enable request logging
  log_requests: false,
  
  // Automatic frequency synchronization
  frequency_sync: true
});
```

---

## Performance Tips

1. **Batch Operations** — Group related queries
2. **Tag Filtering** — Use specific tags to narrow results
3. **Frequency Alignment** — Ensure good heartbeat sync before critical operations
4. **Memory Consolidation** — Periodically consolidate old memories
5. **Connection Pooling** — Reuse client instances

---

## Type Definitions

Full TypeScript definitions included:

```typescript
import {
  MemoryToken,
  MemoryAtom,
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
  MemoryError,
  MemoryErrorCode,
  AccessScope,
  TorusCoordinates
} from '@medina/ai-memory-access-sdk';
```

---

## Documentation

- **Protocol Reference:** [MEMORIA_ACCESSU_PROTOCOL.md](../research/MEMORIA_ACCESSU_PROTOCOL.md)
- **Usage Examples:** [MEMORIA_ACCESSU_EXAMPLES.md](../research/MEMORIA_ACCESSU_EXAMPLES.md)
- **API Docs:** [https://docs.medina.ai/memory-access](https://docs.medina.ai/memory-access)

---

## Support

For issues, questions, or integration help:

- Create an issue on GitHub
- Check the MEMORIA_ACCESSU_EXAMPLES.md for common patterns
- Review the protocol specification for detailed behavior

---

## License

ISIL-1.0 — Intellectual Sovereign Integrity License

---

## Attribution

**Creator:** Alfredo "Freddy" Medina Hernandez  
**Organization:** Medina Tech | Dallas, TX  
**Copyright:** 2026 Medina Sovereign Intelligence Organism  

*Quod vides non est. Quod non vides, est.*

---

**Last Updated:** 2026-06-14
