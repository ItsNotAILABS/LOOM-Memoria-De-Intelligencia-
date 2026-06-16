# 🤖 Bot Fleet Proof Index — Pass 1

> **ORGANISM BOT FLEET PASS 1: PROOF, RECONCILIATION, AND COMMAND INTEGRITY**
> Generated: 2026-05-04 | Law: L-005 — Agent Existence Law | φ = 1.6180339887

---

## BotProofRecord — All 5 Sovereign Bill Bots

A **BotProofRecord** is the authoritative attestation of a bot's existence, identity, and operational boundaries. Every bot must have one.

---

### BOT-001 — AEDIFICATOR

```
BotProofRecord {
  id:           "AEDIFICATOR"
  latin:        "Aedificator Perpetuus"
  name:         "The Perpetual Builder"
  emoji:        🧱
  role:         auto-build
  house:        Engines
  law:          L-005 — Always-on, not alive
  workflow:     .github/workflows/aedificator-build.yml
  triggers:     push (all branches), pull_request (all branches)
  permissions:  contents:read
  outputs:      build validation results per substrate
  proof_hash:   SHA of aedificator-build.yml at Pass 1 commit
  authority:    OBSERVE + REPORT + FAIL_BUILD
  prohibited:   mutate files, open issues, dispatch workflows
  status:       ACTIVE ✅
}
```

**Coverage:** Validates ICP Canister (Motoko), Browser Extensions, SDK Packages, Organism CLI, Distribution Scripts, Rust Crate.

---

### BOT-002 — FASCICULUS

```
BotProofRecord {
  id:           "FASCICULUS"
  latin:        "Fasciculus Automaticus"
  name:         "The Automatic Packager"
  emoji:        📦
  role:         auto-package
  house:        Delivery
  law:          L-005 — Always-on, not alive
  workflow:     .github/workflows/fasciculus-package.yml
  triggers:     push:main only
  permissions:  contents:write
  outputs:      packaged artifacts committed to main
  proof_hash:   SHA of fasciculus-package.yml at Pass 1 commit
  authority:    OBSERVE + PACKAGE + COMMIT (low-risk artifact files only)
  prohibited:   modify source code, delete files, open issues
  status:       ACTIVE ✅
}
```

---

### BOT-003 — MEDICUS

```
BotProofRecord {
  id:           "MEDICUS"
  latin:        "Medicus Machinae"
  name:         "Doctor of the Machine"
  emoji:        💊
  role:         auto-fix
  house:        Observer Solvers
  law:          L-005 — Always-on, not alive
  workflow:     .github/workflows/medicus-autofix.yml
  triggers:     push, schedule (cron every 6h)
  permissions:  contents:write
  engine:       nova_ovo/agents/bill_bots/medicus_bot.py
  outputs:      auto-committed fixes to main
  auto_fixes:   trailing whitespace, missing __init__.py, JSON syntax,
                manifest errors, line-ending normalization
  proof_hash:   SHA of medicus-autofix.yml at Pass 1 commit
  authority:    OBSERVE + FIX (whitespace/syntax only) + COMMIT
  prohibited:   rewrite logic, delete source files, modify high-risk files
                (main.mo, organism-bridge.js, papers-worker.js),
                open issues, dispatch workflows
  high_risk_files:
    - icp/src/medina_backend/main.mo
    - organism-cli/web/organism-bridge.js
    - organism-cli/web/papers-worker.js
    - organism-cli/web/context-worker.js
    - cloudflare-workers/vigilia-edge.js
    - .github/workflows/*.yml
  status:       ACTIVE ✅
}
```

---

### BOT-004 — CUSTOS

```
BotProofRecord {
  id:           "CUSTOS"
  latin:        "Custos Repositorii"
  name:         "Guardian of the Repository"
  emoji:        🛡️
  role:         guardian / health-check
  house:        Nova AI
  law:          L-005 — Always-on, not alive
  workflow:     .github/workflows/custos-guardian.yml
  triggers:     push:main, schedule (cron daily at 06:18 UTC)
  permissions:  contents:read, issues:write
  engine:       nova_ovo/agents/bill_bots/custos_bot.py
  outputs:      custos-report.json (artifact), GitHub Issues on drift
  drift_checks:
    1. Motoko module count vs main.mo import count
    2. Web Worker count vs organism-bridge.js boot list
    3. Protocol count consistency (protocol-papers.js)
    4. docs/ mirror consistency with organism-cli/web/
    5. Package.json / workspace consistency
  proof_hash:   SHA of custos-guardian.yml at Pass 1 commit
  authority:    OBSERVE + REPORT + OPEN_ISSUES (labeled drift alerts)
  prohibited:   mutate source files, commit to main, delete files,
                dispatch other workflows
  status:       ACTIVE ✅
}
```

---

### BOT-005 — PRAETOR

```
BotProofRecord {
  id:           "PRAETOR"
  latin:        "Praetor Botorum"
  name:         "Commander of the Bots"
  emoji:        ⚔️
  role:         orchestrator / commander
  house:        Alpha Agent
  law:          L-005 — Always-on, not alive
  workflow:     .github/workflows/praetor-orchestrate.yml
  triggers:     workflow_run (after AEDIFICATOR/FASCICULUS/MEDICUS/CUSTOS),
                schedule (cron every 12h)
  permissions:  contents:write, actions:read
  outputs:      BILL_BOTS_STATUS.md committed to main
  proof_hash:   SHA of praetor-orchestrate.yml at Pass 1 commit
  authority:    OBSERVE + AGGREGATE_STATUS + REPORT + DISPATCH (approved workflows only)
                + ESCALATE (via BILL_BOTS_STATUS.md + GitHub Issues if critical)
  prohibited:   mutate source code, modify high-risk files, delete files,
                create new bot identities, create new workflow files,
                dispatch unapproved/unknown workflows,
                silently mutate high-risk files without BotProofRecord attestation
  high_risk_files (must not touch without explicit approval):
    - icp/src/medina_backend/main.mo
    - organism-cli/web/organism-bridge.js
    - organism-cli/web/papers-worker.js
    - organism-cli/web/context-worker.js
    - cloudflare-workers/vigilia-edge.js
    - .github/workflows/*.yml
    - docs/bot-fleet/proof-index.md  (this file)
  escalation_path:
    1. Write drift/issue to BILL_BOTS_STATUS.md
    2. Open GitHub Issue with label "organism-bot"
    3. Do NOT auto-fix — wait for human approval
  status:       ACTIVE ✅
}
```

---

## Known Gap — organism-build-bot

| Field | Value |
|-------|-------|
| Reported ID | `organism-build-bot` |
| Expected workflow | `organism-build-bot.yml` |
| Actual workflow | **NOT FOUND** |
| Resolution | **SUPERSEDED** — AEDIFICATOR (`aedificator-build.yml`) subsumes all build validation functions that organism-build-bot performed |
| Health status | **NOT A FAILURE** — gap was caused by architecture map drift, not missing functionality |
| Action required | ✅ Update any architecture-map references from `organism-build-bot` → `AEDIFICATOR (aedificator-build.yml)` |

This resolves the reported **15/16 bot health issue**: the Organism has exactly **5 active Bill Bots**. Any registry claiming 15 or 16 bots reflects an earlier, pre-Bill-Bot architecture where individual feature bots (build-bot, neural-bot, sdk-bot, etc.) existed. Those were **superseded** by the 5 sovereign Bill Bots.

---

## Architecture Map Reconciliation

Previous architecture maps referenced these workflow names:

| Old name | Status | Current replacement |
|----------|--------|---------------------|
| `organism-build-bot.yml` (🧬 extensions) | SUPERSEDED | `aedificator-build.yml` |
| `organism-neural-bot.yml` (🧠 architecture) | SUPERSEDED | `aedificator-build.yml` (canister check) |
| `organism-sdk-bot.yml` (📦 packages) | SUPERSEDED | `fasciculus-package.yml` |
| `organism-protocol-bot.yml` (🔬 protocols) | SUPERSEDED | `aedificator-build.yml` |
| `organism-test-bot.yml` (🧪 Node matrix) | SUPERSEDED | `aedificator-build.yml` |
| `organism-docs-bot.yml` (📚 auto-docs) | SUPERSEDED | `fasciculus-package.yml` |
| `organism-release-bot.yml` (🚀 v* tags) | SUPERSEDED | `fasciculus-package.yml` |
| `organism-deploy-bot.yml` (🌐 ICP/CF) | SUPERSEDED | `fasciculus-package.yml` |
| `organism-sentinel-bot.yml` (🛡️ security) | SUPERSEDED | `custos-guardian.yml` |
| `organism-alpha-bot.yml` | SUPERSEDED | `praetor-orchestrate.yml` |

**Current canonical bot count: 5**

---

## Orphan File & Dead Link Classification Protocol

CUSTOS checks detect orphan files and dead links. Rather than deleting blindly, classify each as:

| Class | Meaning | Action |
|-------|---------|--------|
| `ACTIVE` | Used by organism, current | Preserve |
| `SUPERSEDED` | Replaced by newer component | Archive in `docs/archive/`, remove source reference |
| `ORPHAN` | No known consumer, no known superseder | Flag in escalation-log.md, await human decision |
| `DEAD_LINK` | Reference points to non-existent file | Fix reference or remove link |
| `BUILD_ARTIFACT` | Generated file, should not be committed | Add to .gitignore |

CUSTOS should never delete an ORPHAN or SUPERSEDED file in a single pass. It must:
1. Log to `docs/bot-fleet/escalation-log.md`
2. Open a labeled GitHub Issue
3. Await human approval before deletion

---

*Pass 1 complete. φ = 1.6180339887. "Imperium per ordinem." — Command through order.*
