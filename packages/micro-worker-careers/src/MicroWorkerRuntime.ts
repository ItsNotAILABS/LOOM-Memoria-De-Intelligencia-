/**
 * MicroWorkerRuntime.ts
 *
 * Client-side career mirror — a lighter version of ServerWorkerRuntime
 * that runs in the browser. Same career model, browser-compatible timers.
 * Syncs state from the server; career flow cycles still run at 618ms.
 *
 * © 2024-2026 Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 */

import type { MicroWorkerEntry } from './MicroWorkerManifest';
import { MICRO_WORKERS, PHI } from './MicroWorkerManifest';
import type { CareerStage, WorkerState, WorkerStatus } from './ServerWorkerRuntime';

// ─── Stage progression order ─────────────────────────────────────────────────

const STAGE_ORDER: CareerStage[] = [
  'APPRENTICE',
  'JOURNEYMAN',
  'MASTER',
  'SOVEREIGN',
];

// ─── Runtime ─────────────────────────────────────────────────────────────────

export class MicroWorkerRuntime {
  /** Plain object store for easy serialization (not Map) */
  private workers: Record<string, WorkerState> = {};
  private manifest: MicroWorkerEntry[];
  private timerId: number | null = null;
  private useRAF = false;
  private lastTickTime = 0;

  /** φ pulse interval in milliseconds */
  private readonly HEARTBEAT_MS = 618;

  private bootTimestamp = 0;

  constructor(options?: { useRequestAnimationFrame?: boolean }) {
    this.manifest = MICRO_WORKERS;
    this.useRAF = options?.useRequestAnimationFrame ?? false;

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
      this.workers[entry.id] = state;
    }
  }

  // ─── Lifecycle ───────────────────────────────────────────────────────────

  boot(): void {
    this.bootTimestamp = Date.now();
    this.lastTickTime = this.bootTimestamp;

    if (this.useRAF && typeof requestAnimationFrame !== 'undefined') {
      const tick = (timestamp: number): void => {
        const elapsed = timestamp - this.lastTickTime;
        if (elapsed >= this.HEARTBEAT_MS) {
          this.lastTickTime = timestamp;
          this.runAllCareerFlows();
        }
        this.timerId = requestAnimationFrame(tick);
      };
      this.timerId = requestAnimationFrame(tick);
    } else {
      this.timerId = setInterval(() => {
        this.runAllCareerFlows();
      }, this.HEARTBEAT_MS) as unknown as number;
    }
  }

  shutdown(): void {
    if (this.timerId !== null) {
      if (this.useRAF && typeof cancelAnimationFrame !== 'undefined') {
        cancelAnimationFrame(this.timerId);
      } else {
        clearInterval(this.timerId);
      }
      this.timerId = null;
    }
  }

  // ─── Server Sync ────────────────────────────────────────────────────────

  /**
   * Replace local state with authoritative server data.
   * Accepts an array of WorkerState objects from the server runtime.
   */
  syncFromServer(states: WorkerState[]): void {
    for (const s of states) {
      this.workers[s.id] = { ...s };
    }
  }

  // ─── Core Flow Engine ────────────────────────────────────────────────────

  private runAllCareerFlows(): void {
    const ids = Object.keys(this.workers);
    for (const id of ids) {
      this.runCareerFlowCycle(this.workers[id]);
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
    return this.workers[id];
  }

  getAllWorkers(): WorkerState[] {
    return Object.values(this.workers);
  }

  getStageDistribution(): Record<CareerStage, number> {
    const dist: Record<CareerStage, number> = {
      APPRENTICE: 0,
      JOURNEYMAN: 0,
      MASTER: 0,
      SOVEREIGN: 0,
    };
    for (const w of Object.values(this.workers)) {
      dist[w.stage]++;
    }
    return dist;
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

    const all = Object.values(this.workers);
    for (const w of all) {
      totalFlowCycles += w.flowCycles;
      totalThoughts += w.thoughts;
      totalHeartbeats += w.heartbeats;
    }

    const workerCount = all.length || 1;
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
