# AI Memory Access Layer — Integration & Deployment Guide

## Quick Reference

### What Was Built

A complete **AI Memory Access System** enabling artificial intelligence agents to interact with MEDINA's sovereign memory architecture.

### Where Are the Files?

| Component | Location | Purpose |
|-----------|----------|---------|
| **Protocol** | `research/MEMORIA_ACCESSU_PROTOCOL.md` | PROT-380+ specification |
| **Examples** | `research/MEMORIA_ACCESSU_EXAMPLES.md` | Usage guide with 30+ examples |
| **SDK** | `packages/ai-memory-access-sdk/` | TypeScript client library |
| **Token Service** | `nova_ovo/memoria_accessu_token_generator.js` | Token lifecycle management |
| **Coordinator** | `nova_ovo/memoria_coordinator.js` | Multi-agent synchronization |
| **Public API** | `organism-cli/web/memoria-accessu-api.js` | REST + WebSocket endpoints |
| **Docs** | `AI_MEMORY_ACCESS_LAYER_COMPLETE.md` | Implementation overview |
| **SDK Docs** | `packages/ai-memory-access-sdk/README.md` | SDK reference |

---

## Getting Started (5 Minutes)

### 1. Request a Token

```bash
curl -X POST https://memory.medina.ai/api/v1/memory/token/request \
  -H "Content-Type: application/json" \
  -d '{
    "agent_id": "my-ai-agent",
    "agent_type": "LLM",
    "public_key": "-----BEGIN PUBLIC KEY-----\n...",
    "heartbeat_alignment": 2
  }'
```

### 2. Install SDK

```bash
npm install @medina/ai-memory-access-sdk
```

### 3. Use in Your Code

```typescript
import { MemoryAccessClient } from '@medina/ai-memory-access-sdk';

const client = new MemoryAccessClient(token);

// Query
const results = await client.query('research topic');

// Store
const id = await client.store({ finding: 'discovery' });

// Consolidate
const consolidated = await client.consolidate(['mem1', 'mem2']);
```

---

## For Each LLM Platform

### Claude (Anthropic)

```typescript
import Anthropic from '@anthropic-ai/sdk';
import { MemoryAccessClient } from '@medina/ai-memory-access-sdk';

const memory = new MemoryAccessClient(token);
const client = new Anthropic();

// Get context from memory
const context = await memory.query(userQuestion);

// Use in Claude
const response = await client.messages.create({
  model: 'claude-3-5-sonnet-20241022',
  system: `Context:\n${context.map(m => m.content).join('\n')}`,
  messages: [{ role: 'user', content: userQuestion }]
});

// Store response
await memory.store(
  { question: userQuestion, response: response.content[0].text },
  { memory_type: 'EPISODIC' }
);
```

### GPT-4o (OpenAI)

```typescript
import OpenAI from 'openai';
import { MemoryAccessClient } from '@medina/ai-memory-access-sdk';

const memory = new MemoryAccessClient(token);
const openai = new OpenAI();

const context = await memory.query(userQuestion);

const response = await openai.chat.completions.create({
  model: 'gpt-4o',
  system: `Context:\n${context.map(m => m.content).join('\n')}`,
  messages: [{ role: 'user', content: userQuestion }]
});

await memory.store(
  { question: userQuestion, response: response.choices[0].message.content },
  { memory_type: 'EPISODIC' }
);
```

### Gemini (Google)

```typescript
import { GoogleGenerativeAI } from '@google/generative-ai';
import { MemoryAccessClient } from '@medina/ai-memory-access-sdk';

const memory = new MemoryAccessClient(token);
const genAI = new GoogleGenerativeAI(process.env.GOOGLE_API_KEY);
const model = genAI.getGenerativeModel({ model: 'gemini-1.5-pro' });

const context = await memory.query(userQuestion);

const result = await model.generateContent({
  contents: [{
    role: 'user',
    parts: [{
      text: `Context:\n${context.map(m => m.content).join('\n')}\n\nQuestion: ${userQuestion}`
    }]
  }]
});

await memory.store(
  { question: userQuestion, response: result.response.text() },
  { memory_type: 'EPISODIC' }
);
```

---

## For Multi-Agent Workflows

### Research Collaboration

```typescript
// Agent 1: Form Hypothesis
const hypothesis = await agent1Memory.store(
  { hypothesis: 'Novel approach to optimization' },
  { tags: ['hypothesis'], memory_type: 'SEMANTIC' }
);

// Agent 2: Test Hypothesis
const testResults = await agent2Memory.query('hypothesis');
const results = await agent2Memory.store(
  { test_results: data, success: true },
  { parent_lineage: [testResults[0].memory_id] }
);

// Agent 3: Review and Consolidate
const review = await agent3Memory.traverse(hypothesis.memory_id, {
  direction: 'children',
  depth: 5
});
```

### Worker Coordination

```javascript
const { MemoryCoordinator } = require('memoria_coordinator');

const coordinator = new MemoryCoordinator();

// Register workers
coordinator.registerAgent('worker-1', 1, 0.1);  // METROPOLIS heartbeat
coordinator.registerAgent('worker-2', 1, 0.1);

// Synchronize heartbeats
coordinator.synchronizeHeartbeats();

// Consolidate shared work
const consolidated = await coordinator.consolidateMemories(
  ['work_item_1', 'work_item_2', 'work_item_3']
);
```

---

## Deployment Options

### Option 1: Local Development

```bash
# Start API server locally
node ./organism-cli/web/memoria-accessu-api.js

# Server runs on http://localhost:3000
# Test: curl http://localhost:3000/api/health
```

### Option 2: ICP Canister

Deploy to Internet Computer:

```bash
# Build SDK
cd packages/ai-memory-access-sdk
npm run build

# Deploy as canister
dfx deploy memoria_accessu
```

### Option 3: Docker Container

```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3000
CMD ["node", "./organism-cli/web/memoria-accessu-api.js"]
```

```bash
docker build -t medina-memory-api .
docker run -p 3000:3000 medina-memory-api
```

### Option 4: Cloudflare Workers

Deploy to edge:

```javascript
// In Cloudflare Worker environment
import { MemoryAccessClient } from '@medina/ai-memory-access-sdk';

export default {
  async fetch(request) {
    const token = request.headers.get('X-Token');
    const client = new MemoryAccessClient(token);
    const results = await client.query(request.body);
    return new Response(JSON.stringify(results));
  }
};
```

---

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    AI Agents                                 │
│     ┌──────────┐  ┌──────────┐  ┌──────────┐               │
│     │  Claude  │  │  GPT-4o  │  │  Gemini  │               │
│     └─────┬────┘  └─────┬────┘  └─────┬────┘               │
│           │            │            │                        │
│           └────────────┴────────────┘                        │
└─────────────────────────────────────────────────────────────┘
                          ▲
                          │ HTTP/WebSocket
                          ▼
┌─────────────────────────────────────────────────────────────┐
│          Public API (memoria-accessu-api.js)                │
│  POST /api/memory/query                                     │
│  POST /api/memory/token/request                             │
│  POST /api/memory/token/refresh                             │
│  WebSocket /ws/memory                                       │
└──────────────┬──────────────────────────────┬───────────────┘
               │                              │
               ▼                              ▼
┌─────────────────────────┐    ┌──────────────────────────────┐
│   Token Registry        │    │  Memory Coordinator          │
│ (PROT-293/380)          │    │ (Kuramoto sync, Conflicts)   │
│                         │    │                              │
│ • Token generation      │    │ • Agent registration         │
│ • Token validation      │    │ • Heartbeat synchronization  │
│ • Token refresh         │    │ • Conflict resolution        │
│ • Audit logging         │    │ • Memory consolidation       │
└──────────────┬──────────┘    └──────────────┬───────────────┘
               │                              │
               └──────────────┬───────────────┘
                              │
                              ▼
                    ┌─────────────────────┐
                    │  Memory Temple      │
                    │ (ICP Canister)      │
                    │                     │
                    │ • Torus topology    │
                    │ • Memory atoms      │
                    │ • Lineage chains    │
                    │ • Governance audit  │
                    └─────────────────────┘
```

---

## Heartbeat Synchronization

Agents automatically sync to one of three heartbeats using Kuramoto dynamics:

```
METROPOLIS (0.1 Hz)
    ├─ Backend computation
    ├─ Data processing workers
    └─ High-throughput operations

COUPLING (φ Hz ≈ 1.618 Hz)
    ├─ Memory consolidation
    ├─ Standard AI agents (Claude, GPT-4o)
    └─ Resonance and synchronization

REGULATING (φ² Hz ≈ 2.618 Hz)
    ├─ System orchestration
    ├─ Supervisor agents
    └─ High-level coordination
```

**Default heartbeat for LLMs: COUPLING (φ Hz)**

---

## Error Handling

```typescript
try {
  const results = await client.query('something');
} catch (error) {
  switch (error.code) {
    case 2001: // TOKEN_INVALID
      console.log('Get new token');
      break;
    case 2002: // TOKEN_EXPIRED
      console.log('Refresh token');
      break;
    case 2003: // SCOPE_DENIED
      console.log('Request broader scope');
      break;
    case 2004: // QUOTA_EXCEEDED
      console.log('Backoff and retry');
      await sleep(Math.pow(2, attempt) * 1000);
      break;
    case 2005: // DOCTRINE_VIOLATION
      console.log('Operation not permitted by governance');
      break;
  }
}
```

---

## Monitoring

```bash
# Check service health
curl https://memory.medina.ai/api/health

# Response includes:
# - Token registry status
# - Memory coordinator status
# - Agent count and coherence
# - Performance metrics
```

---

## Common Patterns

### Pattern 1: Research Pipeline

```
Agent 1: Generate Hypothesis → Store
Agent 2: Test Hypothesis → Query, Store
Agent 3: Consolidate Results → Consolidate
```

### Pattern 2: Multi-Turn Conversation

```
User Question → Query Memory → Agent Response → Store
Next Question  → Query Memory → Agent Response → Store
Consolidation  → Consolidate memories periodically
```

### Pattern 3: Background Processing

```
Worker 1: Query work items → Process
Worker 2: Query work items → Process
Coordinator: Consolidate results
```

### Pattern 4: External Integration

```
External System → Request Token
→ Query Memory
→ Store Results
→ Verify Audit Trail
```

---

## FAQ

**Q: Can multiple agents access the same memory?**
A: Yes, via the Memory Coordinator. Conflicts are automatically resolved using phase alignment.

**Q: How long do tokens last?**
A: Default 90 days. Use the refresh endpoint to extend before expiration.

**Q: What happens when agents are out of phase?**
A: The Kuramoto dynamics gradually synchronize them. Out-of-phase operations are throttled.

**Q: Can I use this offline?**
A: The SDK can be used offline for local operations, but requires connectivity for memory persistence.

**Q: How are memories organized?**
A: In a torus topology with coordinates (θ, φ, ρ, ring, beat) using Fibonacci spacing.

**Q: What's the maximum consolidation depth?**
A: Token-dependent. LLM tokens: 5, Workers: 10, Ecosystem: 1.

---

## Performance Benchmarks

```
Operation          Latency    Throughput
─────────────────────────────────────────
Query              100-300ms  60 req/min (LLM)
Store              50-150ms   10 ops/hr (LLM)
Consolidate        500-2000ms 5 ops/hr (LLM)
Traverse           200-800ms  N/A
Pin                30-50ms    N/A
Heartbeat Sync     <10ms      Continuous
```

---

## Support

- **Documentation:** See files in `research/MEMORIA_*.md`
- **Examples:** See `research/MEMORIA_ACCESSU_EXAMPLES.md`
- **SDK Docs:** See `packages/ai-memory-access-sdk/README.md`
- **Issues:** GitHub issues on FreddyCreates/Medina-Memory-More-AI

---

## Next Steps

1. ✅ Request a memory token
2. ✅ Install the SDK
3. ✅ Integrate with your LLM
4. ✅ Query and store memory
5. ✅ Monitor via health endpoint

---

**You now have everything needed to build AI agents that **remember**.**

*Quod vides non est. Quod non vides, est.*

---

Created: 2026-06-14 | License: ISIL-1.0 | Attribution: Alfredo "Freddy" Medina Hernandez
