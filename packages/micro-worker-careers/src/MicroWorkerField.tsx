/**
 * MicroWorkerField.tsx
 *
 * Career stage distribution display — renders ASCII/Unicode status lines
 * showing how 100 sovereign careers are distributed across stages and domains.
 *
 * © 2024-2026 Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 */

import type { CareerStage, WorkerState } from './ServerWorkerRuntime';

// ─── Stage symbols ───────────────────────────────────────────────────────────

const STAGE_SYMBOLS: Record<CareerStage, string> = {
  APPRENTICE: '◇',
  JOURNEYMAN: '◈',
  MASTER: '◆',
  SOVEREIGN: '𓂀',
};

// ─── Props interface ─────────────────────────────────────────────────────────

export interface MicroWorkerFieldProps {
  workers: WorkerState[];
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

function formatNumber(n: number): string {
  return n.toLocaleString('en-US');
}

function countByStage(workers: WorkerState[]): Record<CareerStage, number> {
  const dist: Record<CareerStage, number> = {
    APPRENTICE: 0,
    JOURNEYMAN: 0,
    MASTER: 0,
    SOVEREIGN: 0,
  };
  for (const w of workers) {
    dist[w.stage]++;
  }
  return dist;
}

function totalFlowCycles(workers: WorkerState[]): number {
  let sum = 0;
  for (const w of workers) {
    sum += w.flowCycles;
  }
  return sum;
}

// ─── Render functions ────────────────────────────────────────────────────────

/**
 * Returns a single-line ASCII/Unicode status showing career stage distribution.
 *
 * Example output:
 *   ◇ 25 APPRENTICE | ◈ 30 JOURNEYMAN | ◆ 35 MASTER | 𓂀 10 SOVEREIGN — 100 careers — 45,280 flow cycles
 */
export function renderMicroWorkerField(workers: WorkerState[]): string {
  const dist = countByStage(workers);
  const total = workers.length;
  const cycles = totalFlowCycles(workers);

  const parts = (Object.keys(STAGE_SYMBOLS) as CareerStage[]).map(
    (stage) => `${STAGE_SYMBOLS[stage]} ${dist[stage]} ${stage}`,
  );

  return `${parts.join(' | ')} — ${total} careers — ${formatNumber(cycles)} flow cycles`;
}

/**
 * Returns a multi-line domain breakdown grid.
 *
 * Example output:
 *   MEMORY      ◇ 4 ◈ 3 ◆ 2 𓂀 1 — 10 careers
 *   PROTOCOL    ◇ 5 ◈ 2 ◆ 2 𓂀 1 — 10 careers
 *   ...
 */
export function renderDomainGrid(workers: WorkerState[]): string {
  const domainMap = new Map<string, WorkerState[]>();
  for (const w of workers) {
    const list = domainMap.get(w.domain) ?? [];
    list.push(w);
    domainMap.set(w.domain, list);
  }

  const lines: string[] = [];
  const maxDomainLen = Math.max(
    ...Array.from(domainMap.keys()).map((d) => d.length),
  );

  for (const [domain, domainWorkers] of domainMap.entries()) {
    const dist = countByStage(domainWorkers);
    const padded = domain.padEnd(maxDomainLen);
    const stageParts = (Object.keys(STAGE_SYMBOLS) as CareerStage[]).map(
      (stage) => `${STAGE_SYMBOLS[stage]} ${dist[stage]}`,
    );
    lines.push(
      `  ${padded}  ${stageParts.join(' ')} — ${domainWorkers.length} careers`,
    );
  }

  return lines.join('\n');
}
