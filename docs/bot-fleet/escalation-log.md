# 🚨 Bot Fleet Escalation Log

> **CUSTOS REPOSITORII — Guardian of the Repository**
> Escalations are written here when drift cannot be auto-fixed and requires human decision.
> Law: L-005 — Agent Existence Law | φ = 1.6180339887

---

## How to Read This Log

Each entry has:
- **ESC-ID**: Sequential escalation identifier
- **Source**: Which bot detected the issue
- **Severity**: `warning` | `error` | `critical`
- **Class**: See [orphan classification protocol](proof-index.md)
- **Description**: What was found
- **Action Required**: What a human needs to decide/do
- **Status**: `open` | `resolved` | `deferred`

---

## Active Escalations

### ESC-001 — Architecture Map Drift

| Field | Value |
|-------|-------|
| ESC-ID | ESC-001 |
| Source | CUSTOS (Bot Fleet Pass 1 audit) |
| Severity | `warning` |
| Class | `SUPERSEDED` |
| Detected | 2026-05-04 |
| Status | `resolved` |

**Description:** Architecture maps and memory references cited 9–16 bot workflow files (organism-build-bot.yml, organism-neural-bot.yml, organism-sdk-bot.yml, organism-protocol-bot.yml, organism-test-bot.yml, organism-docs-bot.yml, organism-release-bot.yml, organism-deploy-bot.yml, organism-sentinel-bot.yml, organism-alpha-bot.yml) that do not exist on disk.

**Root Cause:** These workflows existed in an earlier architecture before the 5 sovereign Bill Bots were established. The memory/docs were never updated.

**Resolution:** All 9–16 prior workflows are classified as `SUPERSEDED`. Their functions are covered by the 5 Bill Bots. See `proof-index.md` for the complete reconciliation table.

**Human Action Required:** None. Resolved at Pass 1.

---

### ESC-002 — docs/ Mirror Out-of-Sync

| Field | Value |
|-------|-------|
| ESC-ID | ESC-002 |
| Source | CUSTOS mirror drift check |
| Severity | `warning` |
| Class | `DEAD_LINK` (stale mirror) |
| Detected | 2026-05-04 |
| Status | `resolved` |

**Description:** `docs/papers-worker.js` and `docs/context-worker.js` were 3 paper objects behind `organism-cli/web/` after Papers XV, XVI, XVII were added to source but the docs/ mirror was not synced.

**Resolution:** Synced at Bot Fleet Pass 1. Both files now reflect 19 papers.

**Human Action Required:** None. Resolved at Pass 1.

---

### ESC-003 — Orphan Files Pending Classification

| Field | Value |
|-------|-------|
| ESC-ID | ESC-003 |
| Source | CUSTOS (reported from previous audit) |
| Severity | `warning` |
| Class | `ORPHAN` (pending) |
| Detected | prior to 2026-05-04 |
| Status | `open — awaiting human classification` |

**Description:** An earlier audit reported approximately 211 orphan files and 95 dead links. These have not been individually classified.

**Classification Protocol Applied:**
- **DO NOT delete blindly.** Each file must be individually classified as: ACTIVE, SUPERSEDED, ORPHAN, DEAD_LINK, or BUILD_ARTIFACT.
- CUSTOS will identify and log each file in future passes.
- MEDICUS is **prohibited** from deleting files classified as ORPHAN without human approval.
- PRAETOR must escalate (GitHub Issue) before any bulk operation.

**Human Action Required:** Review upcoming CUSTOS report for itemized orphan/dead-link list. Approve each classification before deletion.

---

## Resolved Escalations Archive

| ESC-ID | Summary | Resolved By | Date |
|--------|---------|-------------|------|
| ESC-001 | Architecture map drift (9–16 stale workflow refs) | Pass 1 proof-index.md reconciliation | 2026-05-04 |
| ESC-002 | docs/ mirror stale (Papers XV–XVII missing) | Pass 1 sync | 2026-05-04 |

---

## Escalation Creation Rules for Bots

When a bot detects an issue it cannot safely auto-fix:

1. Write to this file (append-only — never delete existing entries)
2. Create a GitHub Issue with label `organism-bot` and title prefix `[CUSTOS]`
3. Set status to `open`
4. Do NOT attempt to fix — wait for human response

When an issue is resolved:
1. Update status to `resolved`
2. Move to Resolved Archive table
3. Close the GitHub Issue with reference to the commit that fixed it

---

*"Vigilat dum dormitis." — Watches while you sleep. | φ = 1.6180339887*
