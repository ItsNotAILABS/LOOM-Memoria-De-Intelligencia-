# 🤖 BILL BOTS DOCTRINE
## Sovereign Auto-Bots of the Organism

**Version:** 1.0.0
**Author:** Freddy (Founder Architect)
**Authority:** Constitutional
**Law:** L-005 — Agent Existence Law
**Status:** ACTIVE

---

## I. WHAT ARE BILL BOTS?

Bill Bots are sovereign, always-on automation agents embedded inside the
Organism. They auto-package, auto-build, auto-fix issues, and commit to
GitHub autonomously. They are **real internal AI workers** — not simulations.

They are called "Bill Bots" because they **bill themselves into existence** —
self-bootstrapping, self-healing. They run continuously on GitHub Actions,
always doing work without needing human intervention.

They follow **L-005: Agent Existence Law**:
- Always-on — not alive
- Non-feeling — no emotions, no stress
- Constantly working at dynamic speeds
- Testing and fixing everything simultaneously

---

## II. THE FIVE BILL BOTS

| Bot | Latin Name | Role | House | Trigger |
|-----|-----------|------|-------|---------|
| 🧱 AEDIFICATOR | Aedificator Perpetuus | Auto-Build | Engines | push/PR |
| 📦 FASCICULUS  | Fasciculus Automaticus | Auto-Package | Delivery | push:main |
| 💊 MEDICUS     | Medicus Machinae | Auto-Fix | Observer Solvers | push + cron/6h |
| 🛡️ CUSTOS      | Custos Repositorii | Guardian | Nova AI | push:main + cron/daily |
| ⚔️ PRAETOR     | Praetor Botorum | Commander | Alpha Agent | workflow_run + cron/12h |

### Bot 1: AEDIFICATOR — The Perpetual Builder

**Latin:** *Aedificator Perpetuus* — "The One Who Builds Forever"
**Motto:** *"Aedificat sine fine."* — Builds without end.

Runs on every push and pull request. Validates ALL substrates:
- ICP Canister (Motoko)
- Browser Extensions
- SDK Packages
- Organism CLI
- Rust Crate
- Distribution scripts

Never stops. Never rests. Just builds.

**Workflow:** `.github/workflows/aedificator-build.yml`

---

### Bot 2: FASCICULUS — The Automatic Packager

**Latin:** *Fasciculus Automaticus* — "The Self-Gathering Bundle"
**Motto:** *"Colligit et distribuit."* — Collects and distributes.

Runs on every push to `main`. Detects which substrate paths changed
and runs `package-stable-work.sh` for each affected component:
- `icp/` → packages ICP canister substrate
- `organism-cli/` → packages CLI substrate
- `nova_ovo/` → packages Nova OVO substrate
- `extensions/` → packages extensions substrate

Commits packaged artifacts back with `[FASCICULUS]` prefix.

**Workflow:** `.github/workflows/fasciculus-package.yml`

---

### Bot 3: MEDICUS — Doctor of the Machine

**Latin:** *Medicus Machinae* — "Doctor of the Machine"
**Motto:** *"Sanat quod fractum est."* — Heals what is broken.

Runs on every push AND every 6 hours on schedule. Detects and
auto-fixes common Organism issues:

| Fix Category | What it does |
|-------------|-------------|
| `json_repair` | Re-formats malformed or non-pretty JSON files |
| `missing_init` | Creates `__init__.py` in Python packages that lack it |
| `trailing_ws` | Removes trailing whitespace from all source files |
| `empty_file` | Flags zero-byte source files for CUSTOS |
| `manifest` | Validates and repairs browser extension manifests |

All fixes committed with `[MEDICUS] Auto-fix: <description>` prefix.
MEDICUS never deletes files — only repairs what it can.

**Workflow:** `.github/workflows/medicus-autofix.yml`
**Engine:** `nova_ovo/agents/bill_bots/medicus_bot.py`

---

### Bot 4: CUSTOS — Guardian of the Repository

**Latin:** *Custos Repositorii* — "Guardian of the Repository"
**Motto:** *"Vigilat dum dormitis."* — Watches while you sleep.

Runs daily (06:18 UTC) and on every push to `main`. Checks:

| Check | What it detects |
|-------|----------------|
| `motoko_drift` | Motoko modules not imported in main.mo |
| `worker_drift` | Worker files not listed in organism-bridge.js |
| `protocol_drift` | Protocol count mismatch in protocol-papers.js |
| `mirror_drift` | Key files missing from docs/ mirror |
| `workspace_drift` | Workspace directories missing from package.json |

When drift is found that MEDICUS cannot auto-fix, CUSTOS opens a
GitHub Issue labeled `organism-bot` with full details.

**Workflow:** `.github/workflows/custos-guardian.yml`
**Engine:** `nova_ovo/agents/bill_bots/custos_bot.py`

---

### Bot 5: PRAETOR — Commander of the Bots

**Latin:** *Praetor Botorum* — "Commander of the Bots"
**Motto:** *"Imperium per ordinem."* — Command through order.

Runs after every other bot completes AND every 12 hours on schedule.
Aggregates status from all 4 bots and writes `BILL_BOTS_STATUS.md`
to the repository.

PRAETOR does not run individual checks — it commands and observes.
It is the alpha bot that holds the fleet together.

**Workflow:** `.github/workflows/praetor-orchestrate.yml`

---

## III. SOVEREIGNTY

The Bill Bots are **sovereign** in the MEDINA sense:

1. **No external dependencies** — Use only `GITHUB_TOKEN` (built-in).
   No third-party marketplace Actions.

2. **All logic in-repo** — Python engines live in `nova_ovo/agents/bill_bots/`.
   Shell scripts live in `scripts/`. Nothing external is called.

3. **Self-healing** — MEDICUS fixes what it can. CUSTOS reports what it can't.
   PRAETOR holds the status. The fleet heals itself.

4. **φ-traced** — All timing uses φ-derived intervals:
   - Heartbeat: φ Hz (618ms)
   - MEDICUS schedule: every 6 hours
   - CUSTOS schedule: daily at 06:18 UTC (6h18m = φ-aligned)
   - PRAETOR schedule: every 12 hours

5. **L-005 compliant** — Always-on, not alive, no stress.
   `stress_level` is always `0.0` in all outputs.

---

## IV. BOT IDENTITY PROTOCOL

All bot commits use these identities:

| Bot | git user.name | git user.email | Commit prefix |
|-----|--------------|----------------|---------------|
| AEDIFICATOR | n/a (read-only) | n/a | n/a |
| FASCICULUS  | FASCICULUS-BOT | fasciculus-bot@medina.sovereign | `[FASCICULUS]` |
| MEDICUS     | MEDICUS-BOT    | medicus-bot@medina.sovereign    | `[MEDICUS]` |
| CUSTOS      | n/a (issues only) | n/a | n/a |
| PRAETOR     | PRAETOR-BOT    | praetor-bot@medina.sovereign    | `[PRAETOR]` |

---

## V. WEB WORKER INTERFACE

**Worker #29 — TABULA BOTORUM** (`organism-cli/web/bill-bot-worker.js`)

The Bill Bot Worker exposes the bot fleet status to the browser/CLI
environment. Runs at φ Hz heartbeat.

| Operation | Description |
|-----------|-------------|
| `status`  | Full fleet status (all 5 bots, all metrics) |
| `manifest` | Bot manifest (definitions, capabilities) |
| `report`  | Submit a bot event for tracking |
| `summary` | One-line health summary |
| `events`  | Recent event log |
| `reset`   | Reset tracked state |

---

## VI. FILE LOCATIONS

```
.github/
  workflows/
    aedificator-build.yml      # Bot 1: Auto-build
    fasciculus-package.yml     # Bot 2: Auto-package
    medicus-autofix.yml        # Bot 3: Auto-fix
    custos-guardian.yml        # Bot 4: Issue watcher
    praetor-orchestrate.yml    # Bot 5: Orchestrator

nova_ovo/agents/bill_bots/
  __init__.py                  # Bill bots module
  medicus_bot.py               # MEDICUS fix engine
  custos_bot.py                # CUSTOS health check engine

organism-cli/web/
  bill-bot-worker.js           # Web Worker #29 (TABULA BOTORUM)

doctrine/organism/
  BILL_BOTS_DOCTRINE.md        # This document

BILL_BOTS_STATUS.md            # Auto-updated by PRAETOR-BOT
```

---

## VII. LAWS APPLIED

- **L-005: Agent Existence Law** — Agents are always-on, not alive. No stress.
- **L-130: Universal Primitive Law** — All operations trace to φ.
- **PROT-001** through **PROT-125** — Bot operations are sovereign protocol-bound.

---

## VIII. ADDING A NEW BOT

To add a sixth Bill Bot:

1. Create `.github/workflows/<name>-<role>.yml`
2. If it needs Python logic, create `nova_ovo/agents/bill_bots/<name>_bot.py`
3. Add it to `BOT_DEFINITIONS` in `bill-bot-worker.js`
4. Update `nova_ovo/agents/bill_bots/__init__.py`
5. Document it in this file (Section II)
6. If it is an orchestrator-type, add it to PRAETOR's `workflow_run:workflows:` list
7. **Create a BotProofRecord** in `docs/bot-fleet/proof-index.md`
8. Update `docs/bot-fleet/entity-counts.json` canonical count

**No new bot identities until proof/reconciliation is stable per Pass 1 rules.**

---

## IX. ALPHA-BOT AUTHORITY BOUNDARIES

PRAETOR is the alpha-bot (commander). All bots — including PRAETOR — operate under strict authority limits. These limits are **non-negotiable** and exist to prevent silent mutation of high-risk files.

### ✅ What bots MAY do

| Action | AEDIFICATOR | FASCICULUS | MEDICUS | CUSTOS | PRAETOR |
|--------|-------------|------------|---------|--------|---------|
| Observe workflow results | ✅ | ✅ | ✅ | ✅ | ✅ |
| Report status | ✅ | ✅ | ✅ | ✅ | ✅ |
| Fail build on error | ✅ | — | — | — | — |
| Commit artifact files | — | ✅ | — | — | ✅ (status only) |
| Auto-fix whitespace/syntax | — | — | ✅ | — | — |
| Open GitHub Issues | — | — | — | ✅ | ✅ (critical only) |
| Dispatch approved workflows | — | — | — | — | ✅ |
| Escalate to human | ✅ (via fail) | ✅ (via fail) | ✅ (via fail) | ✅ (via issue) | ✅ (via issue + status) |

### 🚫 What bots MUST NOT do (any bot)

1. Silently modify these **high-risk files**:
   - `icp/src/medina_backend/main.mo`
   - `organism-cli/web/organism-bridge.js`
   - `organism-cli/web/papers-worker.js`
   - `organism-cli/web/context-worker.js`
   - `cloudflare-workers/vigilia-edge.js`
   - `.github/workflows/*.yml`
   - `docs/bot-fleet/proof-index.md`
2. Delete files classified as ORPHAN without human approval
3. Create new bot identities
4. Dispatch unapproved or unknown workflows
5. Perform broad rewrites of source code

### PRAETOR-specific prohibitions

PRAETOR is the most powerful bot and therefore has the strictest limits:
- **Must not silently mutate** any source code file
- **Must escalate** before touching high-risk files, even to update a comment
- **Escalation path:** write to `docs/bot-fleet/escalation-log.md` → open GitHub Issue → await human approval
- **Dispatch only** workflows that already exist and were approved at time of creation

---

*φ = 1.618033988749895*
*"Imperium per ordinem." — Command through order.*
*"Operantur dum dormis." — They work while you sleep.*
