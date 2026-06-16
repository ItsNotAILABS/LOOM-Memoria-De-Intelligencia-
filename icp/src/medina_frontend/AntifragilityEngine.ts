/**
 * ╔═══════════════════════════════════════════════════════════════════════════════╗
 * ║              MEDINA — PROPRIETARY AND CONFIDENTIAL                            ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA       ║
 * ║  ALL RIGHTS RESERVED.  Blockchain-registered on ICP.                         ║
 * ╚═══════════════════════════════════════════════════════════════════════════════╝
 *
 * AntifragilityEngine.ts
 *
 * Paper II — "De Timore et Antifragilitate"
 *   Three simultaneous fear architectures producing antifragility:
 *     FristonFreeEnergyEngine  — prediction-error Bayesian update loop
 *     LotkaVolterraEngine      — expansion vs. threat ecological dynamics
 *     HormeticCycleEngine      — stress → recovery → supercompensation
 *     AntifragilityEngine      — orchestrator, canonical antifragility score
 *
 * Paper III — "Vampyro Architectonico"
 *   SL0VampireGate             — 3-layer unauthorized-energy-extraction gate
 *     (Sumerian Edimmu → Babylonian Lilu → European vampire: 6,000 yr record)
 *
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 */

// ─── constants ────────────────────────────────────────────────────────────────

const PHI    = 1.618033988749895;
const PHI_INV = 0.6180339887498949;   // 1/φ  (≈ 0.618)
const PHI_SQ  = 2.618033988749895;   // φ²
const SCHUMANN = 7.83;                // Hz — Schumann resonance (brain freq)

// ─── shared types ─────────────────────────────────────────────────────────────

export interface FristonState {
    sensorySignal : number;
    prior         : number;
    belief        : number;       // updated belief
    freeEnergy    : number;       // FE = (sensory − prior)²
    tick          : number;
}

export interface LotkaVolterraState {
    expansion : number;   // x — expansion population
    threat    : number;   // y — threat population
    tick      : number;
    r  : number;          // intrinsic growth rate
    K  : number;          // carrying capacity
    alpha : number;       // predation coefficient (threat on expansion)
    delta : number;       // threat death rate
    beta  : number;       // benefit to threat per expansion unit
}

export interface HormeticState {
    stressLoad   : number;   // 0–1
    chronicFear  : number;   // 0–1
    gain         : number;   // stress → recovery → supercompensation
    tick         : number;
}

export interface AntifragilityState {
    friston  : FristonState;
    lotka    : LotkaVolterraState;
    hormetic : HormeticState;
    antifragilityScore    : number;
    vicenteVictoryCount   : number;
    chronicFearLevel      : number;
    tick                  : number;
}

// ─── Paper II — Engine 1: Friston Free-Energy ────────────────────────────────

export class FristonFreeEnergyEngine {
    /** Learning rate: η × φ⁻¹  (η defaults to 0.1) */
    private eta: number;
    private state: FristonState;

    constructor(initialPrior = 0.5, eta = 0.1) {
        this.eta = eta;
        this.state = {
            sensorySignal : 0,
            prior         : initialPrior,
            belief        : initialPrior,
            freeEnergy    : 0,
            tick          : 0,
        };
    }

    /**
     * Advance one tick.
     * FE = (sensory − prior)²
     * belief += learningRate × prediction_error
     *   where learningRate = η × φ⁻¹
     */
    step(sensorySignal: number): FristonState {
        const { prior } = this.state;
        const predictionError = sensorySignal - prior;
        const freeEnergy      = predictionError * predictionError;
        const learningRate    = this.eta * PHI_INV;
        const newBelief       = prior + learningRate * predictionError;

        this.state = {
            sensorySignal,
            prior         : newBelief,      // prior slides to belief
            belief        : newBelief,
            freeEnergy,
            tick          : this.state.tick + 1,
        };
        return { ...this.state };
    }

    getState(): FristonState { return { ...this.state }; }
}

// ─── Paper II — Engine 2: Lotka-Volterra (Euler integration) ─────────────────

export class LotkaVolterraEngine {
    private state: LotkaVolterraState;
    private dt: number;

    /**
     * dx/dt = r·x·(1 − x/K) − α·x·y
     * dy/dt = −δ·y + β·x·y
     */
    constructor(opts?: Partial<LotkaVolterraState> & { dt?: number }) {
        this.dt = opts?.dt ?? 0.01;
        this.state = {
            expansion : opts?.expansion ?? 0.5,
            threat    : opts?.threat    ?? 0.2,
            r         : opts?.r         ?? 1.0,
            K         : opts?.K         ?? 1.0,
            alpha     : opts?.alpha     ?? 0.4,
            delta     : opts?.delta     ?? 0.3,
            beta      : opts?.beta      ?? 0.5,
            tick      : 0,
        };
    }

    step(): LotkaVolterraState {
        const { expansion: x, threat: y, r, K, alpha, delta, beta } = this.state;
        const dt = this.dt;

        const dxdt = r * x * (1 - x / K) - alpha * x * y;
        const dydt = -delta * y + beta * x * y;

        const newX = Math.max(0, x + dxdt * dt);
        const newY = Math.max(0, y + dydt * dt);

        this.state = {
            ...this.state,
            expansion : newX,
            threat    : newY,
            tick      : this.state.tick + 1,
        };
        return { ...this.state };
    }

    getState(): LotkaVolterraState { return { ...this.state }; }
}

// ─── Paper II — Engine 3: Hormetic Cycle ─────────────────────────────────────

export class HormeticCycleEngine {
    private state: HormeticState;

    constructor(initialStress = 0.3, initialChronicFear = 0.1) {
        this.state = {
            stressLoad  : initialStress,
            chronicFear : initialChronicFear,
            gain        : 0,
            tick        : 0,
        };
    }

    /**
     * gain = stressLoad × φ⁻¹ × (1 − chronicFear)
     * (Optimal stress zone: 0.2 < stressLoad < 0.7)
     */
    step(stressLoad?: number, chronicFear?: number): HormeticState {
        const sl = stressLoad  ?? this.state.stressLoad;
        const cf = chronicFear ?? this.state.chronicFear;
        const gain = sl * PHI_INV * (1 - cf);

        this.state = {
            stressLoad  : sl,
            chronicFear : cf,
            gain        : Math.max(0, gain),
            tick        : this.state.tick + 1,
        };
        return { ...this.state };
    }

    getState(): HormeticState { return { ...this.state }; }
}

// ─── Paper II — AntifragilityEngine (orchestrator) ───────────────────────────

/**
 * Canonical antifragility formula:
 *   antifragilityScore += vicenteVictoryCount × φ × (1 − chronicFearLevel)
 *
 * All three sub-engines run simultaneously each tick.
 */
export class AntifragilityEngine {
    private friston  : FristonFreeEnergyEngine;
    private lotka    : LotkaVolterraEngine;
    private hormetic : HormeticCycleEngine;

    private antifragilityScore  : number = 0;
    private vicenteVictoryCount : number = 0;
    private chronicFearLevel    : number = 0;
    private tick                : number = 0;

    constructor() {
        this.friston  = new FristonFreeEnergyEngine();
        this.lotka    = new LotkaVolterraEngine();
        this.hormetic = new HormeticCycleEngine();
    }

    /**
     * One full antifragility tick.
     * @param sensory         — sensory signal for Friston engine
     * @param victoriesThisTick — number of "Vicente victories" this tick (defaults 0)
     */
    step(sensory: number, victoriesThisTick = 0): AntifragilityState {
        const f = this.friston.step(sensory);
        const l = this.lotka.step();
        const h = this.hormetic.step();

        // Derive chronic fear from Friston free-energy (normalised) and Lotka threat
        this.chronicFearLevel = Math.min(1,
            (f.freeEnergy / (1 + f.freeEnergy)) * 0.5 + l.threat * 0.5
        );
        this.hormetic['state'].chronicFear = this.chronicFearLevel;

        this.vicenteVictoryCount += victoriesThisTick;

        // Canonical formula
        const delta = this.vicenteVictoryCount * PHI * (1 - this.chronicFearLevel);
        this.antifragilityScore += delta;

        this.tick++;

        return {
            friston  : f,
            lotka    : l,
            hormetic : h,
            antifragilityScore   : this.antifragilityScore,
            vicenteVictoryCount  : this.vicenteVictoryCount,
            chronicFearLevel     : this.chronicFearLevel,
            tick                 : this.tick,
        };
    }

    getScore(): number { return this.antifragilityScore; }
}

// ─── Paper III — SL0VampireGate ──────────────────────────────────────────────
//
// "Vampyro Architectonico" — 6,000-year architectural pattern
// (Sumerian Edimmu → Babylonian Lilu → European vampire)
// = unauthorized energy extraction, now implemented as a 3-layer gate.
//
// Layer 1 — Expulsion list check  : permanently blocked entities never pass
// Layer 2 — Consent gate          : no consent → threat scored + pattern analysed
// Layer 3 — Pattern analysis      : isolated → recurring → systematic
//                                   → coordinated → expulsion
//
// Verdicts: allow | warn | throttle | block | expel

export type VampireVerdict = 'allow' | 'warn' | 'throttle' | 'block' | 'expel';

export type ExtractionPattern =
    | 'none'
    | 'isolated'
    | 'recurring'
    | 'systematic'
    | 'coordinated';

export interface VampireEntity {
    id          : string;
    displayName : string;
    hasConsent  : boolean;
}

export interface VampireRecord {
    entity          : VampireEntity;
    unauthorizedHits : number;
    pattern         : ExtractionPattern;
    threatScore     : number;    // 0–1
    expelledAt?     : number;    // tick timestamp
    lastSeenTick    : number;
}

export interface GateResult {
    entityId  : string;
    verdict   : VampireVerdict;
    pattern   : ExtractionPattern;
    threatScore: number;
    message   : string;
}

export class SL0VampireGate {
    private expulsionList : Set<string>                = new Set();
    private records       : Map<string, VampireRecord> = new Map();
    private tick          : number = 0;

    // ── Layer 1 ──────────────────────────────────────────────────────────────

    expel(entityId: string): void {
        this.expulsionList.add(entityId);
        const rec = this.records.get(entityId);
        if (rec) { rec.expelledAt = this.tick; }
    }

    isExpelled(entityId: string): boolean {
        return this.expulsionList.has(entityId);
    }

    // ── Main gate ────────────────────────────────────────────────────────────

    /**
     * Evaluate an entity attempting to pass through the gate.
     * @param entity  — entity descriptor (must include hasConsent)
     */
    evaluate(entity: VampireEntity): GateResult {
        this.tick++;

        // Layer 1 — expulsion check
        if (this.isExpelled(entity.id)) {
            return {
                entityId   : entity.id,
                verdict    : 'expel',
                pattern    : this.records.get(entity.id)?.pattern ?? 'coordinated',
                threatScore: 1.0,
                message    : `EXPULSUM: ${entity.displayName} is permanently blocked.`,
            };
        }

        // Layer 2 — consent gate
        if (!entity.hasConsent) {
            const rec = this._updateRecord(entity);
            const result = this._analysePattern(entity.id, rec);
            return result;
        }

        // Consented entity — allow
        return {
            entityId   : entity.id,
            verdict    : 'allow',
            pattern    : 'none',
            threatScore: 0,
            message    : `CONCESSUM: ${entity.displayName} has consent.`,
        };
    }

    // ── Layer 3 — pattern analysis ────────────────────────────────────────────

    private _updateRecord(entity: VampireEntity): VampireRecord {
        const existing = this.records.get(entity.id);
        if (!existing) {
            const rec: VampireRecord = {
                entity,
                unauthorizedHits : 1,
                pattern          : 'isolated',
                threatScore      : 0.1,
                lastSeenTick     : this.tick,
            };
            this.records.set(entity.id, rec);
            return rec;
        }

        existing.unauthorizedHits++;
        existing.lastSeenTick = this.tick;

        const h = existing.unauthorizedHits;
        if      (h >= 20) { existing.pattern = 'coordinated'; existing.threatScore = 1.0; }
        else if (h >= 10) { existing.pattern = 'systematic';  existing.threatScore = 0.75; }
        else if (h >= 5)  { existing.pattern = 'recurring';   existing.threatScore = 0.5; }
        else if (h >= 2)  { existing.pattern = 'recurring';   existing.threatScore = 0.3; }
        else              { existing.pattern = 'isolated';    existing.threatScore = 0.1; }

        return existing;
    }

    private _analysePattern(entityId: string, rec: VampireRecord): GateResult {
        let verdict : VampireVerdict;
        let message : string;

        switch (rec.pattern) {
            case 'coordinated':
                this.expel(entityId);
                verdict = 'expel';
                message = `EXPULSUM: Coordinated extraction detected after ${rec.unauthorizedHits} hits.`;
                break;
            case 'systematic':
                verdict = 'block';
                message = `OBTURATUM: Systematic extraction pattern (${rec.unauthorizedHits} hits).`;
                break;
            case 'recurring':
                verdict = rec.unauthorizedHits >= 7 ? 'throttle' : 'warn';
                message = `MONITUM: Recurring unauthorized access (${rec.unauthorizedHits} hits).`;
                break;
            default:
                verdict = 'warn';
                message = `CAUTIO: Isolated unauthorized access attempt.`;
        }

        return {
            entityId    : entityId,
            verdict,
            pattern     : rec.pattern,
            threatScore : rec.threatScore,
            message,
        };
    }

    // ── Introspection ────────────────────────────────────────────────────────

    getRecord(entityId: string): VampireRecord | undefined {
        return this.records.get(entityId);
    }

    allRecords(): VampireRecord[] {
        return Array.from(this.records.values());
    }

    expulsionCount(): number { return this.expulsionList.size; }

    manifest(): object {
        return {
            name         : 'SL0VampireGate',
            latinName    : 'PORTA VAMPYRICA SL0',
            origin       : 'Sumerian Edimmu → Babylonian Lilu → European Vampire (6,000 yr)',
            layers       : ['expulsion-list', 'consent-gate', 'pattern-analysis'],
            verdicts     : ['allow', 'warn', 'throttle', 'block', 'expel'],
            patterns     : ['none', 'isolated', 'recurring', 'systematic', 'coordinated'],
            tick         : this.tick,
            totalEntities: this.records.size,
            expelled     : this.expulsionList.size,
        };
    }
}

// ─── module manifest ─────────────────────────────────────────────────────────

export const ANTIFRAGILITY_MODULE = {
    paper          : ['II — De Timore et Antifragilitate', 'III — Vampyro Architectonico'],
    engines        : ['FristonFreeEnergyEngine', 'LotkaVolterraEngine', 'HormeticCycleEngine', 'AntifragilityEngine'],
    gate           : 'SL0VampireGate',
    constants      : { PHI, PHI_INV, PHI_SQ, SCHUMANN },
    canonicalFormula: 'antifragilityScore += vicenteVictoryCount × φ × (1 − chronicFearLevel)',
    attribution    : 'Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX',
};
