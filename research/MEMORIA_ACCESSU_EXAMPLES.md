# AI MEMORY ACCESS — Usage Guide & Examples

## De Exemplis Practicum — On Practical Examples

**Protocol:** PROT-380+ (Memory Access Protocol)  
**Version:** 1.0.0  
**Last Updated:** 2026-06-14  

---

## I. GETTING STARTED

### 1.1 Request a Memory Access Token

Before any AI agent can access memory, it must obtain a token from the token service.

**Endpoint:** `POST /api/memory/token/request`

```bash
curl -X POST https://memory.medina.ai/api/v1/memory/token/request \
  -H "Content-Type: application/json" \
  -d '{
    "agent_id": "gpt-4o-research-agent",
    "agent_type": "LLM",
    "public_key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0B...",
    "heartbeat_alignment": 2,
    "duration_days": 90,
    "requested_scope": {
      "memory_rings": [9, 10, 11],
      "coordinate_range": {
        "theta_min": 0,
        "theta_max": 6.283,
        "phi_min": 0,
        "phi_max": 6.283,
        "rho_min": 0.7,
        "rho_max": 1.0
      },
      "operations": {
        "query": true,
        "store": true,
        "consolidate": false,
        "traverse": true,
        "pin": false,
        "delete": false
      }
    }
  }'
```

**Response:**

```json
{
  "token_id": "MEM_abcdef123456_xyz789",
  "agent_id": "gpt-4o-research-agent",
  "token": {
    "token_id": "MEM_abcdef123456_xyz789",
    "issuer": "MEMORIA_ACCESSU",
    "agent_id": "gpt-4o-research-agent",
    "agent_type": "LLM",
    "frequency_hz": 1.618,
    "heartbeat_alignment": 2,
    "issued_at": 1718383200,
    "expires_at": 1726159200,
    "signature": "abc123def456..."
  },
  "issued_at": "2026-06-14T01:00:00Z",
  "expires_at": "2026-09-12T01:00:00Z",
  "documentation": "https://docs.medina.ai/memory-access-protocol"
}
```

---

## II. TYPESCRIPT/JAVASCRIPT EXAMPLES

### 2.1 Import and Initialize SDK

```typescript
import { MemoryAccessClient, MemoryToken } from '@medina/ai-memory-access-sdk';

// Assume you have obtained a token from the token service
const token: MemoryToken = {
  token_id: "MEM_abcdef_xyz789",
  issuer: "MEMORIA_ACCESSU",
  agent_id: "gpt-4o-research-agent",
  agent_type: "LLM",
  public_key_hash: "sha256_hash_here",
  frequency_hz: 1.618,
  heartbeat_alignment: 2,
  issued_at: Math.floor(Date.now() / 1000),
  expires_at: Math.floor(Date.now() / 1000) + 7776000, // 90 days
  signature: "signature_here",
  scope: {
    memory_rings: [9, 10, 11],
    coordinate_range: {
      theta_min: 0, theta_max: 6.283,
      phi_min: 0, phi_max: 6.283,
      rho_min: 0.7, rho_max: 1.0
    },
    salience_floor: 0.1,
    max_memory_atoms: 1000,
    max_consolidation_depth: 5,
    operations: {
      query: true,
      store: true,
      consolidate: false,
      traverse: true,
      pin: false,
      delete: false
    },
    doctrine_binding: "memory.cpl-l:default"
  },
  permissions: []
};

// Initialize client
const client = new MemoryAccessClient(token, {
  api_url: 'https://memory.medina.ai/api/v1',
  timeout_ms: 30000,
  frequency_sync: true,
  log_requests: true
});

console.log(`Connected. Token expires in ${client.getTokenExpiresIn()}s`);
```

### 2.2 Query Memory — Semantic Search

```typescript
// Query for memories about "machine learning optimization"
const results = await client.query(
  'machine learning optimization',
  {
    search_type: 'semantic',
    filters: {
      memory_type: 'SEMANTIC',
      max_age_seconds: 604800, // Last 7 days
      tags: ['research', 'published']
    },
    limit: 50,
    ordering: 'salience'
  }
);

console.log(`Found ${results.length} memories:`);
results.forEach(memory => {
  console.log(`  - ${memory.memory_id} (salience: ${memory.salience})`);
  console.log(`    Content: ${JSON.stringify(memory.content).substring(0, 100)}...`);
  console.log(`    Created: ${new Date(memory.created_at * 1000).toISOString()}`);
});
```

### 2.3 Store Memory — Save Research Findings

```typescript
// Store a research finding
const memoryId = await client.store(
  {
    title: 'Novel Optimization Technique',
    finding: 'Fibonacci-spaced learning rates improve convergence',
    confidence: 0.94,
    methodology: 'Empirical testing across 50 datasets'
  },
  {
    memory_type: 'SEMANTIC',
    tags: ['research', 'optimization', 'phi-aligned'],
    parent_lineage: ['MEM_SEQ_001_initial_hypothesis'],
    doctrine_binding: 'memory.cpl-l:research-findings',
    retention_policy: 'long_term'
  }
);

console.log(`Memory stored with ID: ${memoryId}`);
```

### 2.4 Traverse Memory Lineage — Understand Context

```typescript
// Navigate the lineage of a memory to understand how it was derived
const graph = await client.traverse(
  'MEM_SEQ_001_initial_hypothesis',
  {
    direction: 'children',
    depth: 3,
    filter: {
      memory_type: 'SEMANTIC',
      min_salience: 0.5
    }
  }
);

console.log('Memory lineage graph:');
console.log(`  Nodes: ${graph.nodes.length}`);
graph.nodes.forEach(node => {
  console.log(`    - ${node.memory_id}: ${node.brief_content}`);
});

console.log(`  Edges: ${graph.edges.length}`);
graph.edges.forEach(edge => {
  console.log(`    - ${edge.from_memory_id} → ${edge.to_memory_id}`);
});
```

### 2.5 Pin Memory — Prevent Decay

```typescript
// Pin a critical memory to prevent it from fading
const pinnedUntil = await client.pin(
  'MEM_CRITICAL_001_theorem',
  {
    duration_seconds: 2592000, // 30 days
    reason: 'Critical theorem - foundational to research program'
  }
);

console.log(`Memory pinned until ${new Date(pinnedUntil).toISOString()}`);
```

### 2.6 Consolidate Memories — Merge Related Findings

```typescript
// Consolidate multiple related memories using Fibonacci compression
const consolidatedId = await client.consolidate(
  [
    'MEM_FINDING_001_phi_learning_rates',
    'MEM_FINDING_002_convergence_patterns',
    'MEM_FINDING_003_statistical_validation'
  ],
  {
    consolidation_type: 'summarize',
    output_memory_type: 'SEMANTIC',
    doctrine_binding: 'memory.cpl-l:consolidation-policy'
  }
);

console.log(`Consolidated into: ${consolidatedId}`);
```

---

## III. PYTHON EXAMPLES

### 3.1 Python SDK Usage

```python
from medina_memory_sdk import MemoryAccessClient, MemoryToken

# Initialize client with token
token = MemoryToken(
    token_id="MEM_abcdef_xyz789",
    issuer="MEMORIA_ACCESSU",
    agent_id="claude-research-agent",
    agent_type="LLM",
    frequency_hz=1.618,
    heartbeat_alignment=2,
    expires_at=1726159200
)

client = MemoryAccessClient(
    token,
    api_url='https://memory.medina.ai/api/v1',
    frequency_sync=True
)

# Query memory
results = client.query(
    pattern='neural network architecture',
    search_type='semantic',
    limit=25
)

for memory in results:
    print(f"Found: {memory.memory_id}")
    print(f"  Salience: {memory.salience}")
    print(f"  Tags: {', '.join(memory.tags)}")

# Store finding
memory_id = client.store(
    content={
        'discovery': 'Transformer efficiency optimization',
        'technique': 'Attention head pruning',
        'improvement': '23% reduction in parameters'
    },
    memory_type='SEMANTIC',
    tags=['ai-research', 'transformers', 'optimization']
)

print(f"Stored: {memory_id}")

# Consolidate related memories
consolidated = client.consolidate(
    memory_ids=['MEM_001', 'MEM_002', 'MEM_003'],
    consolidation_type='merge'
)

print(f"Consolidated: {consolidated}")
```

---

## IV. MULTI-AGENT COORDINATION EXAMPLES

### 4.1 Two AI Agents Coordinating Research

```typescript
// Agent 1: Hypothesis Formation (Claude)
const agent1 = new MemoryAccessClient(token1);

const hypothesisId = await agent1.store(
  {
    hypothesis: 'Golden ratio appears in optimal network architectures',
    basis: 'Mathematical theory of scale-free networks'
  },
  {
    memory_type: 'SEMANTIC',
    tags: ['hypothesis', 'neural-networks']
  }
);

// Agent 2: Empirical Testing (GPT-4o)
const agent2 = new MemoryAccessClient(token2);

// Retrieve hypothesis from shared memory
const hypotheses = await agent2.query('golden ratio network', {
  search_type: 'semantic',
  tags: ['hypothesis']
});

const testingResults = {
  hypothesis_id: hypotheses[0].memory_id,
  test_count: 1000,
  success_rate: 0.87,
  confidence: 0.92
};

const testId = await agent2.store(
  testingResults,
  {
    memory_type: 'SEMANTIC',
    tags: ['empirical-testing', 'results'],
    parent_lineage: [hypotheses[0].memory_id],
    doctrine_binding: 'memory.cpl-l:research-findings'
  }
);

// Agent 1: Review Results
const results = await agent1.query('hypothesis_' + hypothesisId, {
  search_type: 'lineage',
  filters: { memory_type: 'SEMANTIC' }
});

console.log('Research pipeline complete:');
console.log(`  Hypothesis: ${hypothesisId}`);
console.log(`  Testing Results: ${testId}`);
console.log(`  Success Rate: ${testingResults.success_rate}`);
```

---

## V. ERROR HANDLING & RECOVERY

### 5.1 Handle Expired Token

```typescript
try {
  const results = await client.query('something');
} catch (error: any) {
  if (error.code === 2002) { // TOKEN_EXPIRED
    console.log('Token expired. Refreshing...');
    
    const refreshResponse = await fetch(
      'https://memory.medina.ai/api/v1/memory/token/refresh',
      {
        method: 'POST',
        headers: {
          'X-Token-ID': oldToken.token_id,
          'X-Agent-ID': oldToken.agent_id
        },
        body: JSON.stringify({ additional_days: 90 })
      }
    );
    
    const { new_token } = await refreshResponse.json();
    client = new MemoryAccessClient(new_token);
    
    // Retry operation
    const results = await client.query('something');
  }
}
```

### 5.2 Handle Rate Limiting

```typescript
async function queryWithRetry(
  client: MemoryAccessClient,
  pattern: string,
  maxRetries: number = 3
): Promise<any[]> {
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await client.query(pattern);
    } catch (error: any) {
      if (error.code === 2004) { // QUOTA_EXCEEDED
        const backoffMs = Math.pow(2, attempt) * 1000;
        console.log(`Rate limited. Retrying in ${backoffMs}ms...`);
        await new Promise(resolve => setTimeout(resolve, backoffMs));
      } else {
        throw error;
      }
    }
  }
  throw new Error('Max retries exceeded');
}
```

---

## VI. FREQUENCY ALIGNMENT & HEARTBEAT SYNC

### 6.1 Check Frequency Status

```typescript
// Check which heartbeat the agent is synchronized to
const heartbeat = client.getFrequencyAlignment();
console.log(`Agent synchronized to heartbeat: ${heartbeat}`);
// Output: 2 (COUPLING - φ Hz ≈ 1.618 Hz)

// Get token expiration
const expiresIn = client.getTokenExpiresIn();
console.log(`Token expires in ${expiresIn} seconds`);
```

### 6.2 Monitor Coherence

```typescript
// Use the FrequencySync utility to monitor coherence
import { FrequencySync, Heartbeat } from '@medina/ai-memory-access-sdk';

const sync = new FrequencySync(Heartbeat.COUPLING);

// Get next synchronization point
const nextSync = sync.getNextSyncPoint(Date.now());
console.log(`Next sync point in ${nextSync - Date.now()}ms`);

// Synchronize to heartbeat
await sync.syncToHeartbeat();
console.log('Synchronized to heartbeat');

// Measure coherence with target frequency
const coherence = sync.measureCoherence(1.618);
console.log(`Coherence: ${(coherence * 100).toFixed(1)}%`);
```

---

## VII. GOVERNANCE & DOCTRINE BINDING

### 7.1 Query with Doctrine Constraint

```typescript
// Query must respect applicable doctrine
const results = await client.query(
  'proprietary research',
  {
    filters: {
      // Only query memories bound to specific doctrine
      tags: ['doctrine-compliant']
    }
  }
);
```

### 7.2 Store with Doctrine Binding

```typescript
// Bind stored memory to governance law
const memoryId = await client.store(
  {
    sensitive_finding: 'Classified optimization technique'
  },
  {
    memory_type: 'SEMANTIC',
    doctrine_binding: 'memory.cpl-l:classified-research',
    retention_policy: 'permanent' // Permanent retention for compliance
  }
);
```

---

## VIII. INTEGRATION PATTERNS

### 8.1 LLM Integration (OpenAI/Anthropic)

```typescript
// Integrate memory access with Claude API
import Anthropic from '@anthropic-ai/sdk';
import { MemoryAccessClient } from '@medina/ai-memory-access-sdk';

const memoryClient = new MemoryAccessClient(token);
const anthropic = new Anthropic();

async function researchWithMemory(question: string) {
  // Query relevant memory
  const memories = await memoryClient.query(question);
  
  const context = memories
    .slice(0, 5)
    .map(m => `- [${m.memory_id}] ${JSON.stringify(m.content)}`)
    .join('\n');

  // Use memory in Claude conversation
  const message = await anthropic.messages.create({
    model: 'claude-3-5-sonnet-20241022',
    max_tokens: 1024,
    system: `You have access to the following research memory:\n\n${context}`,
    messages: [
      { role: 'user', content: question }
    ]
  });

  // Store Claude's response as new memory
  const response = message.content[0];
  if (response.type === 'text') {
    await memoryClient.store(
      {
        question: question,
        response: response.text,
        model: 'claude-3-5-sonnet'
      },
      {
        memory_type: 'EPISODIC',
        tags: ['ai-conversation', 'research'],
        parent_lineage: memories.map(m => m.memory_id)
      }
    );
  }

  return message;
}
```

### 8.2 Worker Agent Integration

```typescript
// Memory access in background worker
const { MemoryAccessClient } = require('@medina/ai-memory-access-sdk');

class ResearchWorker {
  constructor(token) {
    this.memory = new MemoryAccessClient(token);
  }

  async runBatch() {
    // Query work items from memory
    const workItems = await this.memory.query('pending research tasks');
    
    for (const item of workItems) {
      const result = await this.processItem(item);
      
      // Store results
      await this.memory.store(
        {
          work_item_id: item.memory_id,
          result: result,
          completed_at: new Date().toISOString()
        },
        {
          memory_type: 'EPISODIC',
          parent_lineage: [item.memory_id]
        }
      );
    }
  }

  async processItem(item) {
    // Process work item
    return { status: 'completed', work_done: true };
  }
}
```

---

## IX. TROUBLESHOOTING

| Problem | Solution |
|---------|----------|
| **TOKEN_EXPIRED** | Call `/api/memory/token/refresh` to get new token |
| **QUOTA_EXCEEDED** | Implement exponential backoff; upgrade token tier |
| **SCOPE_DENIED** | Query is outside token's scope; check coordinate_range |
| **MEMORY_NOT_FOUND** | Verify memory_id exists; check lineage |
| **DOCTRINE_VIOLATION** | Memory is restricted by governance; check tags |

---

## X. PERFORMANCE TIPS

1. **Batch Operations** — Group multiple queries into single request
2. **Frequency Alignment** — Ensure agent heartbeat syncs before operations
3. **Memory Consolidation** — Periodically consolidate old memories to reduce query time
4. **Tag Filtering** — Use specific tags to narrow query scope
5. **Heartbeat Tuning** — Workers use heartbeat 1 (0.1 Hz) for reliability

---

**End of Usage Guide**

*Quod vides non est. Quod non vides, est.*  
(What you see is not. What you don't see, is.)

---

**Attribution:** Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  
**License:** ISIL-1.0  
**Last Updated:** 2026-06-14T01:41 UTC
