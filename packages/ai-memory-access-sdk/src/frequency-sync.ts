/**
 * Frequency Synchronization using Kuramoto Oscillator Dynamics
 * ============================================================
 * 
 * Synchronizes AI agent operations to one of three heartbeats:
 * - METROPOLIS: 0.1 Hz (backend computation)
 * - COUPLING: φ Hz ≈ 1.618 Hz (memory consolidation)
 * - REGULATING: φ² Hz ≈ 2.618 Hz (system orchestration)
 */

export enum Heartbeat {
  METROPOLIS = 'METROPOLIS',   // 0.1 Hz
  COUPLING = 'COUPLING',       // φ Hz
  REGULATING = 'REGULATING',   // φ² Hz
}

export class FrequencySync {
  private readonly PHI = 1.6180339887498948482;
  private readonly PHI_SQ = 2.6180339887498948482;

  private heartbeat: Heartbeat;
  private targetFrequency: number;
  private phase: number = 0;
  private amplitude: number = 1;
  private coupling: number = 0.5;

  constructor(heartbeat: Heartbeat = Heartbeat.COUPLING) {
    this.heartbeat = heartbeat;
    this.targetFrequency = this.getFrequency(heartbeat);
  }

  /**
   * Get frequency in Hz for a heartbeat type
   */
  private getFrequency(heartbeat: Heartbeat): number {
    switch (heartbeat) {
      case Heartbeat.METROPOLIS:
        return 0.1;
      case Heartbeat.COUPLING:
        return this.PHI;
      case Heartbeat.REGULATING:
        return this.PHI_SQ;
      default:
        return this.PHI;
    }
  }

  /**
   * Calculate Kuramoto phase for given timestamp
   * θ(t) = ω*t + A*sin(phase)
   */
  calculatePhase(timestampMs: number): number {
    const frequencyRad = this.targetFrequency * 2 * Math.PI; // Convert Hz to rad/s
    const timeSeconds = timestampMs / 1000;
    return (frequencyRad * timeSeconds) % (2 * Math.PI);
  }

  /**
   * Check if system is in phase (within tolerance)
   */
  isInPhase(timestampMs: number, toleranceRad: number = 0.1): boolean {
    const currentPhase = this.calculatePhase(timestampMs);
    const phaseDiff = Math.abs(currentPhase - this.phase);
    return phaseDiff < toleranceRad || phaseDiff > 2 * Math.PI - toleranceRad;
  }

  /**
   * Get next synchronization point in milliseconds
   */
  getNextSyncPoint(fromMs: number): number {
    const periodMs = 1000 / this.targetFrequency;
    return Math.ceil(fromMs / periodMs) * periodMs;
  }

  /**
   * Synchronize to next heartbeat
   */
  async syncToHeartbeat(): Promise<number> {
    const now = Date.now();
    const nextSync = this.getNextSyncPoint(now);
    const waitMs = nextSync - now;

    if (waitMs > 0) {
      await new Promise(resolve => setTimeout(resolve, waitMs));
    }

    this.phase = this.calculatePhase(nextSync);
    return nextSync;
  }

  /**
   * Get current frequency in Hz
   */
  getFrequencyHz(): number {
    return this.targetFrequency;
  }

  /**
   * Get heartbeat name
   */
  getHeartbeat(): Heartbeat {
    return this.heartbeat;
  }

  /**
   * Get coupling coefficient
   */
  getCoupling(): number {
    return this.coupling;
  }

  /**
   * Set coupling coefficient for network synchronization
   */
  setCoupling(coupling: number): void {
    this.coupling = Math.max(0, Math.min(1, coupling));
  }

  /**
   * Measure phase coherence between this and target frequency
   * Returns value between 0 (incoherent) and 1 (perfectly coherent)
   */
  measureCoherence(targetFrequency: number): number {
    const frequencyRatio = Math.abs(this.targetFrequency - targetFrequency) / Math.max(this.targetFrequency, targetFrequency);
    return Math.max(0, 1 - frequencyRatio);
  }
}

export default FrequencySync;
