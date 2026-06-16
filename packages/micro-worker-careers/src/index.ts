/**
 * @medina/micro-worker-careers
 *
 * 100 sovereign micro-workers with career flows — ANIMA MICRO.
 * Package entry point — re-exports all modules.
 *
 * © 2024-2026 Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 */

// ─── Manifest: types, constants, and worker definitions ──────────────────────
export {
  PHI,
  SCHUMANN_HZ,
  PULSE_MS,
  MICRO_WORKERS,
} from './MicroWorkerManifest';
export type {
  CareerStages,
  MicroWorkerCareer,
  MicroWorkerEntry,
} from './MicroWorkerManifest';

// ─── Server runtime: class and types ─────────────────────────────────────────
export { ServerWorkerRuntime } from './ServerWorkerRuntime';
export type {
  CareerStage,
  WorkerStatus,
  WorkerState,
} from './ServerWorkerRuntime';

// ─── Client runtime: browser-compatible mirror ──────────────────────────────
export { MicroWorkerRuntime } from './MicroWorkerRuntime';

// ─── Field display: render functions and props ──────────────────────────────
export {
  renderMicroWorkerField,
  renderDomainGrid,
} from './MicroWorkerField';
export type { MicroWorkerFieldProps } from './MicroWorkerField';

// ─── Instrumentation: boot/shutdown helpers ─────────────────────────────────
export {
  bootAllCareers,
  shutdownAllCareers,
  BOOT_MESSAGE,
} from './instrumentation';
