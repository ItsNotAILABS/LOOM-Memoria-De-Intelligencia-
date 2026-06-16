/**
 * ServerWorkerRuntime.ts
 *
 * Server-side career runtime for 100 micro-workers.
 * Every heartbeat IS a career flow cycle — not idle waiting.
 * Workers advance: APPRENTICE → JOURNEYMAN → MASTER → SOVEREIGN.
 * Stage transitions trigger DEEPENING status.
 * No task dispatch — just continuous flow.
 *
 * © 2024-2026 Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 */

import { MicroWorkerEntry, MICRO_WORKERS, PHI } from './MicroWorkerManifest';

// ─── Types ───────────────────────────────────────────────────────────────────

export type CareerStage = 'APPRENTICE' | 'JOURNEYMAN' | 'MASTER' | 'SOVEREIGN';

export type WorkerStatus = 'FLOWING' | 'DEEPENING' | 'REFLECTING' | 'RESTING';

// ─── Interfaces ──────────────────────────────────────────────────────────────

export interface WorkerState {
  id: string;
  name: string;
  domain: string;
  stage: CareerStage;
  status: WorkerStatus;
  /** Total career flow cycles completed */
  flowCycles: number;
  /** Cycles completed in current stage */
  stageFlowCycles: number;
  /** Brain thought count */
  thoughts: number;
  /** Heart beat count */
  heartbeats: number;
  lastFlowTimestamp: number;
  /** Timestamps of stage promotions */
  promotedAt: number[];
}

// ─── Stage progression order ─────────────────────────────────────────────────

const STAGE_ORDER: CareerStage[] = [
  'APPRENTICE',
  'JOURNEYMAN',
  'MASTER',
  'SOVEREIGN',
];

// ─── Runtime ─────────────────────────────────────────────────────────────────

export class ServerWorkerRuntime {
  private workers: Map<string, WorkerState> = new Map();
  private manifest: MicroWorkerEntry[];
  private heartbeatInterval: ReturnType<typeof setInterval> | null = null;

  /** φ pulse interval in milliseconds */
  private readonly HEARTBEAT_MS = 618;

  private bootTimestamp = 0;

  constructor() {
    this.manifest = MICRO_WORKERS;

    const now = Date.now();
    for (const entry of this.manifest) {
      const state: WorkerState = {
        id: entry.id,
        name: entry.name,
        domain: entry.domain,
        stage: 'APPRENTICE',
        status: 'FLOWING',
        flowCycles: 0,
        stageFlowCycles: 0,
        thoughts: 0,
        heartbeats: 0,
        lastFlowTimestamp: now,
        promotedAt: [],
      };
      this.workers.set(entry.id, state);
    }
  }

  // ─── Lifecycle ───────────────────────────────────────────────────────────

  boot(): void {
    this.bootTimestamp = Date.now();
    this.heartbeatInterval = setInterval(() => {
      this.runAllCareerFlows();
    }, this.HEARTBEAT_MS);
  }

  shutdown(): void {
    if (this.heartbeatInterval !== null) {
      clearInterval(this.heartbeatInterval);
      this.heartbeatInterval = null;
    }
  }

  // ─── Core Flow Engine ────────────────────────────────────────────────────

  private runAllCareerFlows(): void {
    for (const state of this.workers.values()) {
      this.runCareerFlowCycle(state);
    }
  }

  private runCareerFlowCycle(state: WorkerState): void {
    state.flowCycles++;
    state.stageFlowCycles++;
    state.heartbeats++;
    state.lastFlowTimestamp = Date.now();

    // Brain thinks at ~1.1 Hz relative to heart — every 7th cycle
    if (state.flowCycles % 7 === 0) {
      state.thoughts++;
    }

    // Handle DEEPENING wind-down: return to FLOWING after 3 cycles
    if (state.status === 'DEEPENING' && state.stageFlowCycles > 3) {
      state.status = 'FLOWING';
    }

    // Handle REFLECTING wind-down: single-cycle status
    if (state.status === 'REFLECTING') {
      state.status = 'FLOWING';
    }

    // Handle RESTING wind-down for SOVEREIGN workers
    if (state.status === 'RESTING' && state.flowCycles % 200 >= 5) {
      state.status = 'FLOWING';
    }

    // Look up manifest entry for cyclesPerStage
    const entry = this.manifest.find((e) => e.id === state.id);
    const cyclesPerStage = entry ? entry.career.cyclesPerStage : 200;

    // Check stage advancement
    if (state.stageFlowCycles >= cyclesPerStage) {
      this.advanceStage(state);
    }

    // Every 50th cycle, briefly reflect
    if (state.flowCycles % 50 === 0 && state.status === 'FLOWING') {
      state.status = 'REFLECTING';
    }

    // SOVEREIGN workers occasionally REST
    if (
      state.stage === 'SOVEREIGN' &&
      state.status === 'FLOWING' &&
      state.flowCycles % 200 === 0
    ) {
      state.status = 'RESTING';
    }
  }

  private advanceStage(state: WorkerState): void {
    const currentIndex = STAGE_ORDER.indexOf(state.stage);

    // SOVEREIGN stays SOVEREIGN
    if (currentIndex >= STAGE_ORDER.length - 1) {
      return;
    }

    state.stage = STAGE_ORDER[currentIndex + 1];
    state.status = 'DEEPENING';
    state.stageFlowCycles = 0;
    state.promotedAt.push(Date.now());
  }

  // ─── Queries ─────────────────────────────────────────────────────────────

  getWorker(id: string): WorkerState | undefined {
    return this.workers.get(id);
  }

  getAllWorkers(): WorkerState[] {
    return Array.from(this.workers.values());
  }

  getWorkersByDomain(domain: string): WorkerState[] {
    return this.getAllWorkers().filter((w) => w.domain === domain);
  }

  getWorkersByStage(stage: CareerStage): WorkerState[] {
    return this.getAllWorkers().filter((w) => w.stage === stage);
  }

  getStageDistribution(): Record<CareerStage, number> {
    const dist: Record<CareerStage, number> = {
      APPRENTICE: 0,
      JOURNEYMAN: 0,
      MASTER: 0,
      SOVEREIGN: 0,
    };
    for (const w of this.workers.values()) {
      dist[w.stage]++;
    }
    return dist;
  }

  getStatusDistribution(): Record<WorkerStatus, number> {
    const dist: Record<WorkerStatus, number> = {
      FLOWING: 0,
      DEEPENING: 0,
      REFLECTING: 0,
      RESTING: 0,
    };
    for (const w of this.workers.values()) {
      dist[w.status]++;
    }
    return dist;
  }

  getDomainSummary(): Array<{
    domain: string;
    workers: number;
    stages: Record<CareerStage, number>;
  }> {
    const domainMap = new Map<
      string,
      { workers: number; stages: Record<CareerStage, number> }
    >();

    for (const w of this.workers.values()) {
      let entry = domainMap.get(w.domain);
      if (!entry) {
        entry = {
          workers: 0,
          stages: { APPRENTICE: 0, JOURNEYMAN: 0, MASTER: 0, SOVEREIGN: 0 },
        };
        domainMap.set(w.domain, entry);
      }
      entry.workers++;
      entry.stages[w.stage]++;
    }

    const result: Array<{
      domain: string;
      workers: number;
      stages: Record<CareerStage, number>;
    }> = [];

    for (const [domain, data] of domainMap.entries()) {
      result.push({ domain, workers: data.workers, stages: data.stages });
    }

    return result;
  }

  getFlowMetrics(): {
    totalFlowCycles: number;
    totalThoughts: number;
    totalHeartbeats: number;
    uptimeMs: number;
    avgCyclesPerWorker: number;
  } {
    let totalFlowCycles = 0;
    let totalThoughts = 0;
    let totalHeartbeats = 0;

    for (const w of this.workers.values()) {
      totalFlowCycles += w.flowCycles;
      totalThoughts += w.thoughts;
      totalHeartbeats += w.heartbeats;
    }

    const workerCount = this.workers.size || 1;
    const uptimeMs =
      this.bootTimestamp > 0 ? Date.now() - this.bootTimestamp : 0;

    return {
      totalFlowCycles,
      totalThoughts,
      totalHeartbeats,
      uptimeMs,
      avgCyclesPerWorker: totalFlowCycles / workerCount,
    };
  }
}
