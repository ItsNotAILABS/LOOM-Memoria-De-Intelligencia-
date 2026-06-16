/**
 * ╔═══════════════════════════════════════════════════════════════════════════════╗
 * ║              MEDINA — PROPRIETARY AND CONFIDENTIAL                            ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA       ║
 * ║  ALL RIGHTS RESERVED.  Blockchain-registered on ICP.                         ║
 * ╚═══════════════════════════════════════════════════════════════════════════════╝
 *
 * FractalSovereignty.ts
 *
 * Paper IV — "De Lege Fractalica"
 *
 * SOVEREIGNTY_FLOOR = 0.75 — enforced identically at all four scales.
 *
 * Components:
 *   KuramotoEngine           — phase-coupled oscillator network
 *     dθᵢ/dt = ωᵢ + (K/N) × Σⱼ sin(θⱼ − θᵢ)
 *     order parameter R ∈ [0,1]
 *     Fibonacci-spaced initial phases
 *
 *   FractalSovereigntyRegistry — register nodes at any of four scales
 *     Scales: micro | meso | macro | sovereign
 *     validate()        → per-scale stats + Kuramoto R
 *     proveFractalLaw() → signed proof certificate with Latin verdict
 *
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 */

// ─── constants ────────────────────────────────────────────────────────────────

const PHI     = 1.618033988749895;
const PHI_INV = 0.6180339887498949;

/** Minimum sovereignty score that every scale must maintain. */
export const SOVEREIGNTY_FLOOR = 0.75;

export type Scale = 'micro' | 'meso' | 'macro' | 'sovereign';
export const ALL_SCALES: Scale[] = ['micro', 'meso', 'macro', 'sovereign'];

// ─── Fibonacci sequence helper ────────────────────────────────────────────────

function fibonacciSequence(count: number): number[] {
    const seq: number[] = [1, 1];
    while (seq.length < count) {
        seq.push(seq[seq.length - 1] + seq[seq.length - 2]);
    }
    return seq.slice(0, count);
}

/** Fibonacci-spaced initial phases in [0, 2π]. */
function fibonacciPhases(n: number): number[] {
    const fibs = fibonacciSequence(Math.max(n, 2));
    const max  = fibs[n - 1];
    return fibs.slice(0, n).map(f => (f / max) * 2 * Math.PI);
}

// ─── Kuramoto state ───────────────────────────────────────────────────────────

export interface KuramotoState {
    phases   : number[];   // θᵢ for each oscillator (radians)
    omegas   : number[];   // ωᵢ natural frequencies
    R        : number;     // order parameter ∈ [0,1]  (synchrony)
    psi      : number;     // mean phase angle
    tick     : number;
    N        : number;     // number of oscillators
    K        : number;     // coupling strength
}

// ─── KuramotoEngine ──────────────────────────────────────────────────────────

/**
 * Kuramoto model (Euler integration, Fibonacci-seeded phases).
 *
 * dθᵢ/dt = ωᵢ + (K/N) × Σⱼ sin(θⱼ − θᵢ)
 *
 * Order parameter R (synchrony):
 *   R·e^(iψ) = (1/N) × Σⱼ e^(i·θⱼ)
 *   R = | (1/N) × Σⱼ e^(i·θⱼ) |
 */
export class KuramotoEngine {
    private state: KuramotoState;
    private dt   : number;

    constructor(opts?: { N?: number; K?: number; dt?: number; omegas?: number[] }) {
        const N  = opts?.N  ?? 8;
        const K  = opts?.K  ?? 2.0;
        this.dt  = opts?.dt ?? 0.01;

        const phases = fibonacciPhases(N);
        const omegas = opts?.omegas ?? phases.map((_, i) => 1 + (i * PHI_INV) % 1);

        const { R, psi } = this._orderParameter(phases);

        this.state = { phases, omegas, R, psi, tick: 0, N, K };
    }

    /** One Euler integration step. */
    step(): KuramotoState {
        const { phases, omegas, N, K } = this.state;
        const newPhases = phases.map((theta_i, i) => {
            let coupling = 0;
            for (let j = 0; j < N; j++) {
                if (j !== i) coupling += Math.sin(phases[j] - theta_i);
            }
            const dTheta = omegas[i] + (K / N) * coupling;
            return theta_i + dTheta * this.dt;
        });

        const { R, psi } = this._orderParameter(newPhases);
        this.state = { ...this.state, phases: newPhases, R, psi, tick: this.state.tick + 1 };
        return { ...this.state, phases: [...newPhases] };
    }

    /** Run n steps, return final state. */
    run(n: number): KuramotoState {
        for (let i = 0; i < n; i++) this.step();
        return { ...this.state, phases: [...this.state.phases] };
    }

    getState(): KuramotoState { return { ...this.state, phases: [...this.state.phases] }; }

    private _orderParameter(phases: number[]): { R: number; psi: number } {
        const N    = phases.length;
        let sumCos = 0, sumSin = 0;
        for (const theta of phases) { sumCos += Math.cos(theta); sumSin += Math.sin(theta); }
        const R   = Math.sqrt((sumCos / N) ** 2 + (sumSin / N) ** 2);
        const psi = Math.atan2(sumSin / N, sumCos / N);
        return { R, psi };
    }
}

// ─── Fractal node ─────────────────────────────────────────────────────────────

export interface FractalNode {
    id             : string;
    scale          : Scale;
    sovereigntyScore: number;   // 0–1; must be ≥ SOVEREIGNTY_FLOOR
    phiAlignment   : number;   // 0–1; alignment to φ-harmonic
    registeredAt   : number;   // tick
    tags           : string[];
}

export interface ScaleStats {
    scale            : Scale;
    count            : number;
    violations       : number;
    avgSovereignty   : number;
    minSovereignty   : number;
    kuramotoR        : number;
    sovereigntyFloor : number;
    healthy          : boolean;
}

export interface ValidationResult {
    valid      : boolean;
    scales     : ScaleStats[];
    kuramotoR  : number;
    tick       : number;
    violations : FractalNode[];
}

export interface FractalLawCertificate {
    id             : string;
    issuedAt       : number;
    issuedAtISO    : string;
    lawVersion     : 'IV.1';
    sovereigntyFloor: number;
    kuramotoR      : number;
    valid          : boolean;
    latinVerdict   : string;
    scales         : ScaleStats[];
    violations     : string[];   // node ids
    signature      : string;     // deterministic hash
}

// ─── FractalSovereigntyRegistry ───────────────────────────────────────────────

export class FractalSovereigntyRegistry {
    private nodes    : Map<string, FractalNode>  = new Map();
    private kuramoto : KuramotoEngine;
    private tick     : number = 0;

    constructor(kuramotoOpts?: ConstructorParameters<typeof KuramotoEngine>[0]) {
        this.kuramoto = new KuramotoEngine(kuramotoOpts);
    }

    // ── Registration ─────────────────────────────────────────────────────────

    /**
     * Register a node at any scale.
     * Immediately checked for SOVEREIGNTY_FLOOR violation.
     */
    register(node: Omit<FractalNode, 'registeredAt'>): { node: FractalNode; violates: boolean } {
        this.tick++;
        const full: FractalNode = { ...node, registeredAt: this.tick };
        this.nodes.set(node.id, full);
        return { node: full, violates: full.sovereigntyScore < SOVEREIGNTY_FLOOR };
    }

    /** Update an existing node's sovereignty score. */
    updateScore(id: string, sovereigntyScore: number): boolean {
        const node = this.nodes.get(id);
        if (!node) return false;
        node.sovereigntyScore = sovereigntyScore;
        return true;
    }

    getNode(id: string): FractalNode | undefined { return this.nodes.get(id); }

    allNodes(): FractalNode[] { return Array.from(this.nodes.values()); }

    // ── Validation ───────────────────────────────────────────────────────────

    /**
     * Validate all nodes across all four scales.
     * Advances the Kuramoto engine one step and captures R.
     * Returns per-scale stats + overall validity.
     */
    validate(): ValidationResult {
        this.tick++;
        const ks = this.kuramoto.step();

        const violations: FractalNode[] = [];
        const scaleMap = new Map<Scale, FractalNode[]>();
        for (const s of ALL_SCALES) scaleMap.set(s, []);

        for (const node of this.nodes.values()) {
            scaleMap.get(node.scale)!.push(node);
            if (node.sovereigntyScore < SOVEREIGNTY_FLOOR) violations.push(node);
        }

        const scales: ScaleStats[] = ALL_SCALES.map(scale => {
            const group = scaleMap.get(scale)!;
            const count = group.length;
            const scaleViolations = group.filter(n => n.sovereigntyScore < SOVEREIGNTY_FLOOR);
            const avgSov = count === 0 ? 1 : group.reduce((s, n) => s + n.sovereigntyScore, 0) / count;
            const minSov = count === 0 ? 1 : Math.min(...group.map(n => n.sovereigntyScore));
            return {
                scale,
                count,
                violations      : scaleViolations.length,
                avgSovereignty  : avgSov,
                minSovereignty  : minSov,
                kuramotoR       : ks.R,
                sovereigntyFloor: SOVEREIGNTY_FLOOR,
                healthy         : scaleViolations.length === 0,
            };
        });

        return {
            valid      : violations.length === 0,
            scales,
            kuramotoR  : ks.R,
            tick       : this.tick,
            violations,
        };
    }

    // ── Proof Certificate ────────────────────────────────────────────────────

    /**
     * proveFractalLaw() — returns a signed proof certificate with Latin verdict.
     *
     * Latin verdicts:
     *   "LEX FRACTALICA PROBATA"       — all scales sovereign, R ≥ 0.75
     *   "LEX FRACTALICA PARTIM PROBATA" — valid but R < 0.75
     *   "LEX FRACTALICA VIOLATA"       — sovereignty violations present
     */
    proveFractalLaw(): FractalLawCertificate {
        const validation   = this.validate();
        const ks           = this.kuramoto.getState();
        const now          = Date.now();
        const isoNow       = new Date(now).toISOString();

        let latinVerdict: string;
        if (!validation.valid) {
            latinVerdict = 'LEX FRACTALICA VIOLATA';
        } else if (ks.R >= SOVEREIGNTY_FLOOR) {
            latinVerdict = 'LEX FRACTALICA PROBATA';
        } else {
            latinVerdict = 'LEX FRACTALICA PARTIM PROBATA';
        }

        const violationIds = validation.violations.map(n => n.id);

        // Deterministic signature: hash of key fields
        const sigPayload = [
            now,
            validation.valid,
            ks.R.toFixed(6),
            violationIds.join(','),
            SOVEREIGNTY_FLOOR,
        ].join('|');
        const signature = `SL0::FRACTAL::${this._simpleHash(sigPayload)}`;

        return {
            id               : `CERT-${now}-${this.tick}`,
            issuedAt         : now,
            issuedAtISO      : isoNow,
            lawVersion       : 'IV.1',
            sovereigntyFloor : SOVEREIGNTY_FLOOR,
            kuramotoR        : ks.R,
            valid            : validation.valid,
            latinVerdict,
            scales           : validation.scales,
            violations       : violationIds,
            signature,
        };
    }

    // ── helpers ──────────────────────────────────────────────────────────────

    /** Simple deterministic string hash (djb2-style). */
    private _simpleHash(str: string): string {
        let h = 5381;
        for (let i = 0; i < str.length; i++) {
            h = ((h << 5) + h) ^ str.charCodeAt(i);
            h = h >>> 0;   // keep unsigned 32-bit
        }
        return h.toString(16).toUpperCase().padStart(8, '0');
    }

    manifest(): object {
        const ks = this.kuramoto.getState();
        return {
            name             : 'FractalSovereigntyRegistry',
            paper            : 'IV — De Lege Fractalica',
            sovereigntyFloor : SOVEREIGNTY_FLOOR,
            scales           : ALL_SCALES,
            totalNodes       : this.nodes.size,
            kuramotoOscillators: ks.N,
            kuramotoR        : ks.R,
            kuramotoTick     : ks.tick,
            tick             : this.tick,
            constants        : { PHI, PHI_INV },
            latinVerdicts    : [
                'LEX FRACTALICA PROBATA',
                'LEX FRACTALICA PARTIM PROBATA',
                'LEX FRACTALICA VIOLATA',
            ],
            attribution      : 'Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX',
        };
    }
}

// ─── module manifest ─────────────────────────────────────────────────────────

export const FRACTAL_SOVEREIGNTY_MODULE = {
    paper            : 'IV — De Lege Fractalica',
    sovereigntyFloor : SOVEREIGNTY_FLOOR,
    scales           : ALL_SCALES,
    engines          : ['KuramotoEngine', 'FractalSovereigntyRegistry'],
    kuramotoFormula  : 'dθᵢ/dt = ωᵢ + (K/N) × Σⱼ sin(θⱼ − θᵢ)',
    orderParameter   : 'R ∈ [0,1]',
    initialPhases    : 'Fibonacci-spaced',
    constants        : { PHI, PHI_INV, SOVEREIGNTY_FLOOR },
    attribution      : 'Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX',
};
