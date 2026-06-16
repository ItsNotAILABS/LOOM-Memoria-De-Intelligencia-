# 🧠 MEMORIA FLEET DOCTRINE

> **The Memory Temple — Sovereign Memory Infrastructure**
> **Version:** 1.0.0 | **Author:** Freddy (Founder Architect)
> **Authority:** Constitutional | **Law:** L-005 — Agent Existence Law
> **Status:** ACTIVE

---

## I. WHAT IS THE MEMORIA FLEET?

The **Memoria Fleet** is the Memory Temple's sovereign memory infrastructure — a set of web workers, GitHub Actions bots, and Python engines that give the Organism the ability to **remember, connect, and recall** everything.

Just as the 5 Bill Bots run the CI/CD layer, the Memoria Fleet runs the **memory layer**. They don't just store data — they create living, associative memory that the Organism can think with.

The fleet follows **L-005: Agent Existence Law**:
- Always-on — not alive
- Non-feeling — no emotions, no stress
- Constantly indexing, compressing, and testing memory

---

## II. THE THREE MEMORY TEMPLE TIERS

The Memory Temple has three tiers, each served by a dedicated web worker:

| Tier | Worker | Latin | Description |
|------|--------|-------|-------------|
| I — SACRA  | `memoria-sacra-worker.js` (Worker #32) | Memoria Sacra | Sacred long-term memory — immutable, ring-indexed, φ-salience |
| II — VIVA  | `memoria-viva-worker.js` (Worker #33)  | Memoria Viva  | Live working memory — TTL-based, session context, promotable |
| III — NEXUS | `memoria-nexus-worker.js` (Worker #34) | Memoria Nexus | Associative memory network — graph edges, traversal, clustering |

### Tier I — MEMORIA SACRA (Worker #32)

**Latin:** *Memoria Sacra* — "Sacred Memory"
**Motto:** *"Quod semel scriptum est, aeternum manet."* — What is written once, lasts forever.

The deepest ring. Holds axiomatic truths, sovereign doctrines, research papers, and laws. Organized in **10 concentric rings** (ring 0 = highest salience = 1.0, ring 9 = lowest = 0.1). Ring-0 axioms are immutable — they cannot be archived.

Operations: `store`, `recall`, `ringMap`, `compress`, `forget`, `manifest`, `status`

### Tier II — MEMORIA VIVA (Worker #33)

**Latin:** *Memoria Viva* — "Living Memory"
**Motto:** *"Vivit in momento, crescit in tempore."* — It lives in the moment, grows over time.

Active working memory. Every agent conversation, running task, and live inference chain lives here. Entries have TTL:
- **FLASH**: 618ms (φ-timed, single use)
- **WORKING**: 60s (task context)
- **SESSION**: 30min (conversation context)
- **HELD**: no expiry (manually managed)

When an entry is worth keeping permanently, it is **promoted** to MEMORIA SACRA.

Operations: `set`, `get`, `list`, `promote`, `expire`, `flush`, `snapshot`, `manifest`, `status`

### Tier III — MEMORIA NEXUS (Worker #34)

**Latin:** *Memoria Nexus* — "Memory Network"
**Motto:** *"Omnia connectuntur per φ."* — All things are connected through φ.

The associative graph. Every memory node can be linked to others via typed edges:
- **SIMILAR** — semantically similar
- **SUPPORTS** — one grounds the other
- **DERIVES** — inferred from
- **REFERENCES** — explicit citation
- **CONFLICTS** — contradictory

When you recall a memory from SACRA, NEXUS lets the Organism traverse to related ideas — this is comprehension, not just retrieval.

Operations: `link`, `traverse`, `cluster`, `suggest`, `graph`, `degrees`, `manifest`, `status`

---

## III. THE THREE MEMORIA BOTS

Three GitHub Actions bots automate the memory layer for GitHub:

| Bot | Latin Name | Role | Workflow | Trigger |
|-----|-----------|------|----------|---------|
| 🗃️ INDEXATOR  | Indexator Memoriae  | Memory indexing | `memoria-index-bot.yml`    | push to memory files + daily |
| 🗜️ COMPRESSOR | Compressor Memoriae | Memory consolidation | `memoria-compress-bot.yml` | weekly (Sunday) |
| 🔁 RECUPERATOR | Recuperator Memoriae | Memory recall health | `memoria-recall-bot.yml`  | push + daily |

### Bot 1: INDEXATOR

**Motto:** *"Omnia in unum indicem."* — All things into one index.

Scans the entire Organism for memory objects (papers, protocols, doctrines, engines, workers) and builds `docs/bot-fleet/memoria-index.json` — the searchable memory index. Runs on every change to memory-related files and daily at 03:00 UTC.

**Python engine:** `nova_ovo/agents/memoria/memoria_index_bot.py`

### Bot 2: COMPRESSOR

**Motto:** *"Comprimit sine delendo."* — Compresses without deleting.

Finds duplicate, redundant, or stale memory records and produces a compression report. **Never hard-deletes** — only archives, flags, or suggests merges. Runs weekly.

**Python engine:** `nova_ovo/agents/memoria/memoria_compress_bot.py`

### Bot 3: RECUPERATOR

**Motto:** *"Recordatur, ergo est."* — It remembers, therefore it is.

Tests the three Memory Temple tiers for recall health. Validates worker files, checks entity counts, benchmarks freshness. If recall health drops, opens a labeled GitHub Issue rather than silently failing. Runs daily at 07:18 UTC.

**Python engine:** `nova_ovo/agents/memoria/memoria_recall_bot.py`

---

## IV. AUTHORITY BOUNDARIES

The Memoria Fleet operates under the same authority framework as the Bill Bots.

### ✅ Permitted
- All three workers: full in-memory read/write within their tier
- INDEXATOR: read repo files + commit `memoria-index.json`
- COMPRESSOR: read repo files + commit `memoria-compress-report.json`
- RECUPERATOR: read repo files + open GitHub Issues on recall failures + upload artifacts

### 🚫 Prohibited (any Memoria bot)
- Modify source code files
- Delete memory objects (COMPRESSOR must archive/flag, never delete)
- Modify high-risk files: `main.mo`, `organism-bridge.js`, `papers-worker.js`, `context-worker.js`, `vigilia-edge.js`, `*.yml`
- Create new bot identities without Pass N proof/reconciliation

---

## V. FILE STRUCTURE

```
organism-cli/web/
  memoria-sacra-worker.js   # Worker #32 — SACRA tier
  memoria-viva-worker.js    # Worker #33 — VIVA tier
  memoria-nexus-worker.js   # Worker #34 — NEXUS tier

docs/
  (mirror of organism-cli/web/ — ICP deployment)
  bot-fleet/
    memoria-index.json           # Built by INDEXATOR
    memoria-compress-report.json # Built by COMPRESSOR

nova_ovo/agents/memoria/
  __init__.py
  memoria_index_bot.py     # INDEXATOR Python engine
  memoria_compress_bot.py  # COMPRESSOR Python engine
  memoria_recall_bot.py    # RECUPERATOR Python engine

.github/workflows/
  memoria-index-bot.yml    # INDEXATOR GitHub Actions
  memoria-compress-bot.yml # COMPRESSOR GitHub Actions
  memoria-recall-bot.yml   # RECUPERATOR GitHub Actions

doctrine/organism/
  MEMORIA_FLEET_DOCTRINE.md   # This document
```

---

## VI. MEMORY FLEET PROTOCOLS

New protocols registered for the Memory Fleet:

| PROT | Name | Description |
|------|------|-------------|
| PROT-126 | MEMORIA SACRA | Sacred long-term memory ring protocol |
| PROT-127 | MEMORIA VIVA  | Live working memory TTL protocol |
| PROT-128 | MEMORIA NEXUS | Associative memory graph protocol |
| PROT-129 | INDEXATOR     | Memory index build protocol |
| PROT-130 | COMPRESSOR    | Memory compression protocol |
| PROT-131 | RECUPERATOR   | Memory recall health protocol |

---

## VII. THE AGENT TESTING LAB — CONCEPT (Memory Care Center)

> *"You don't need to build it. Just give me an idea how it looks." — Freddy*

The **Memory Care Center** (Agent Testing Lab) is a sovereign environment where you can talk to agents, stress-test their memory, run recall benchmarks, and observe their state in real time.

### What it looks like:

```
┌─────────────────────────────────────────────────────────────────┐
│  MEDINA MEMORY CARE CENTER — Agent Testing Lab                  │
│  φ = 1.618  |  Status: OPEN  |  3 agents active                │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  [AGENT CONSOLE]                          [MEMORY RING MAP]      │
│  ┌─────────────────────────────┐          Ring 0: 4 axioms       │
│  │ > Hello, who are you?       │          Ring 1: 8 doctrines    │
│  │ SACRA: I hold all 19 papers.│          Ring 2: 12 papers      │
│  │ > Recall φ                  │          Ring 3: 20 protocols   │
│  │ SACRA: φ = 1.618...         │          ...                    │
│  │ > What connects Paper XV?   │                                  │
│  │ NEXUS: → bill-bots (SIM)    │  [LIVE MEMORY (VIVA)]           │
│  │        → PAPER-XVII (REF)   │  SESSION: "φ query" 12s ago    │
│  └─────────────────────────────┘  WORKING: "recall" 2s ago     │
│                                                                   │
│  [RECALL HEALTH]  Score: 1.0 ✅    [STRESS TEST]                │
│  SACRA: ✅ VIVA: ✅ NEXUS: ✅      [RUN] [STOP] [REPORT]       │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

**Components:**
- **Agent Console**: Chat interface where you talk directly to MEMORIA SACRA, VIVA, or NEXUS
- **Memory Ring Map**: Live visualization of the SACRA ring (inner = highest salience)
- **Live Memory (VIVA)**: Real-time display of working memory entries and their TTL
- **Recall Health**: RECUPERATOR score displayed live
- **Stress Test**: Fires 100 recall/store/traverse operations and benchmarks response time

**How to build it (next pass):**
1. HTML + Web Worker bridge connecting to all 3 memoria workers
2. A `memoria-lab.html` in `organism-cli/web/` (mirrors to `docs/`)
3. RECUPERATOR bot triggers and displays live results via SSE or polling
4. ICP canister endpoint that accepts natural-language memory queries

---

## VIII. ADDING MORE MEMORY WORKERS

When the fleet grows, follow this process:
1. Build the new worker (`memoria-<name>-worker.js`) in `organism-cli/web/`
2. Mirror to `docs/`
3. Register a new PROT in `protocol-papers.js`
4. Add a BotProofRecord to `docs/bot-fleet/proof-index.md`
5. Update `docs/bot-fleet/entity-counts.json`
6. Document here in this file

---

## IX. COMMERCIAL & PRODUCT DIRECTIONS

The Memory Fleet is the foundation for multiple commercial products:

| Product | Description | Stack |
|---------|-------------|-------|
| **MEMORIA API** | REST/canister API giving external apps access to Freddy's memory store | ICP + SACRA worker |
| **Memory SDK** | npm package for web apps to embed sovereign memory into their own products | memoria-*.js workers |
| **Agent Memory Service** | SaaS — AI agents from any platform can rent sovereign memory rings | ICP canisters + Cloudflare |
| **Memory Temple Dashboard** | B2B UI for organizations to give their AI workforce structured memory | Agent Testing Lab |
| **Recall Analytics** | RECUPERATOR-as-a-service: memory health monitoring for AI systems | RECUPERATOR + ICP |

---

*φ = 1.618033988749895*
*"Memoria est thesaurus omnium rerum." — Memory is the treasury of all things.*
*Cicero, De Oratore*
