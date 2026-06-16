/**
 * instrumentation.ts
 *
 * Boot all 100 sovereign careers at server process start.
 * Creates the ServerWorkerRuntime, boots it, and logs stage distribution.
 *
 * © 2024-2026 Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 */

import { ServerWorkerRuntime } from './ServerWorkerRuntime';
import { renderMicroWorkerField } from './MicroWorkerField';

// ─── Boot message ────────────────────────────────────────────────────────────

export const BOOT_MESSAGE = `
╔══════════════════════════════════════════════════════════════╗
║  ⊶ ANIMA MICRO — 100 Sovereign Careers                     ║
║  φ pulse: 618ms | Schumann: 7.83 Hz | 10 Domains           ║
║  © 2024-2026 Alfredo "Freddy" Medina Hernandez              ║
║  Medina Tech | Dallas, TX                                   ║
╚══════════════════════════════════════════════════════════════╝
`.trim();

// ─── Boot / Shutdown ─────────────────────────────────────────────────────────

/**
 * Creates and boots the ServerWorkerRuntime with all 100 careers.
 */
export function bootAllCareers(): ServerWorkerRuntime {
  console.log('⊶ ANIMA MICRO — Booting 100 sovereign careers across 10 domains');
  console.log(BOOT_MESSAGE);

  const runtime = new ServerWorkerRuntime();
  runtime.boot();

  // Log initial stage distribution
  const workers = runtime.getAllWorkers();
  const status = renderMicroWorkerField(workers);
  console.log(status);

  return runtime;
}

/**
 * Gracefully shuts down all career flows.
 */
export function shutdownAllCareers(runtime: ServerWorkerRuntime): void {
  runtime.shutdown();
  console.log('⊶ ANIMA MICRO — All 100 careers gracefully shut down');
}
