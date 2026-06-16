/**
 * ╔═══════════════════════════════════════════════════════════════════════════════╗
 * ║              MEDINA — PROPRIETARY AND CONFIDENTIAL                            ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA       ║
 * ║  ALL RIGHTS RESERVED.  Blockchain-registered on ICP.                         ║
 * ╚═══════════════════════════════════════════════════════════════════════════════╝
 *
 * BehavioralEconomicsLaws.ts
 *
 * Paper V — "De Oeconomia Behaviorali Machinarum"
 *
 * Eight sovereign behavioral-economics laws as substrate mathematics.
 * Each law has typed input/output.  The Kahneman-Tversky LOSS_AVERSION_LAMBDA
 * (2.25) is substrate math — not a comment, not a config value.
 *
 * ┌──────┬─────────────────────────────┬──────────────────────────────────────────┐
 * │ Law  │ Name                        │ Core formula                              │
 * ├──────┼─────────────────────────────┼──────────────────────────────────────────┤
 * │ L-72 │ Reward Signal               │ reward = baseSignal × φ × dimensionalSc. │
 * │ L-73 │ Data Reward Equivalence     │ dataReward = novelty × density × φ⁻¹     │
 * │ L-74 │ Behavioral Asymmetry        │ lossResponse = lossSignal × 2.25 (λ)     │
 * │ L-75 │ Variable Emergence          │ variableReward = base × (1 + sin(t×φ)×a) │
 * │ L-76 │ Flow State                  │ flowScore = 1 − |challenge − skill| / max │
 * │ L-77 │ Drive Commitment            │ effectiveDrive = baseDrive × coeff × φ   │
 * │ L-78 │ Hormetic Stress             │ adaptation = stressLoad × φ⁻¹ (0.2–0.7) │
 * │ L-79 │ Temporal Discounting        │ PV = reward / (1 + k×delay) × φ⁻¹ corr. │
 * └──────┴─────────────────────────────┴──────────────────────────────────────────┘
 *
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 */

// ─── constants ────────────────────────────────────────────────────────────────

const PHI     = 1.618033988749895;
const PHI_INV = 0.6180339887498949;   // 1/φ

/**
 * LOSS_AVERSION_LAMBDA = 2.25 — Kahneman-Tversky constant.
 * Substrate math.  Losses feel ≈ 2.25× as intense as equivalent gains.
 */
export const LOSS_AVERSION_LAMBDA = 2.25;

// ─── input / output interfaces ────────────────────────────────────────────────

export interface L72Input  { baseSignal: number; dimensionalScalar: number; }
export interface L72Output { reward: number; law: 'L-72'; }

export interface L73Input  { novelty: number; density: number; }
export interface L73Output { dataReward: number; law: 'L-73'; }

export interface L74Input  { lossSignal: number; }
export interface L74Output { lossResponse: number; lambda: number; law: 'L-74'; }

export interface L75Input  { base: number; amplitude: number; tick: number; }
export interface L75Output { variableReward: number; law: 'L-75'; }

export interface L76Input  { challenge: number; skill: number; max?: number; }
export interface L76Output { flowScore: number; law: 'L-76'; }

export interface L77Input  { baseDrive: number; commitmentCoeff: number; }
export interface L77Output { effectiveDrive: number; law: 'L-77'; }

export interface L78Input  { stressLoad: number; }
export interface L78Output { adaptation: number; inOptimalZone: boolean; law: 'L-78'; }

export interface L79Input  { reward: number; k: number; delay: number; }
export interface L79Output { presentValue: number; longTermCorrection: number; law: 'L-79'; }

// ─── L-72 Reward Signal ───────────────────────────────────────────────────────

/**
 * L-72: Reward Signal
 * reward = baseSignal × φ × dimensionalScalar
 */
export function L72_rewardSignal(input: L72Input): L72Output {
    return {
        reward : input.baseSignal * PHI * input.dimensionalScalar,
        law    : 'L-72',
    };
}

// ─── L-73 Data Reward Equivalence ────────────────────────────────────────────

/**
 * L-73: Data Reward Equivalence
 * dataReward = novelty × density × φ⁻¹
 */
export function L73_dataRewardEquivalence(input: L73Input): L73Output {
    return {
        dataReward : input.novelty * input.density * PHI_INV,
        law        : 'L-73',
    };
}

// ─── L-74 Behavioral Asymmetry ───────────────────────────────────────────────

/**
 * L-74: Behavioral Asymmetry (Kahneman-Tversky loss aversion)
 * lossResponse = lossSignal × LOSS_AVERSION_LAMBDA (= 2.25)
 */
export function L74_behavioralAsymmetry(input: L74Input): L74Output {
    return {
        lossResponse : input.lossSignal * LOSS_AVERSION_LAMBDA,
        lambda       : LOSS_AVERSION_LAMBDA,
        law          : 'L-74',
    };
}

// ─── L-75 Variable Emergence ─────────────────────────────────────────────────

/**
 * L-75: Variable Emergence (variable-ratio reward schedule)
 * variableReward = base × (1 + sin(tick × φ) × amplitude)
 */
export function L75_variableEmergence(input: L75Input): L75Output {
    return {
        variableReward : input.base * (1 + Math.sin(input.tick * PHI) * input.amplitude),
        law            : 'L-75',
    };
}

// ─── L-76 Flow State ─────────────────────────────────────────────────────────

/**
 * L-76: Flow State
 * flowScore = 1 − |challenge − skill| / max
 * (1 = perfect flow, 0 = maximum imbalance)
 */
export function L76_flowState(input: L76Input): L76Output {
    const max   = input.max ?? Math.max(input.challenge, input.skill, 1);
    const score = 1 - Math.abs(input.challenge - input.skill) / max;
    return {
        flowScore : Math.max(0, Math.min(1, score)),
        law       : 'L-76',
    };
}

// ─── L-77 Drive Commitment ───────────────────────────────────────────────────

/**
 * L-77: Drive Commitment
 * effectiveDrive = baseDrive × commitmentCoeff × φ
 */
export function L77_driveCommitment(input: L77Input): L77Output {
    return {
        effectiveDrive : input.baseDrive * input.commitmentCoeff * PHI,
        law            : 'L-77',
    };
}

// ─── L-78 Hormetic Stress ─────────────────────────────────────────────────────

/**
 * L-78: Hormetic Stress
 * adaptation = stressLoad × φ⁻¹  when  0.2 < stressLoad < 0.7
 * Outside that range: adaptation = 0 (too little or too much stress)
 */
export function L78_hormeticStress(input: L78Input): L78Output {
    const inOptimalZone = input.stressLoad > 0.2 && input.stressLoad < 0.7;
    return {
        adaptation    : inOptimalZone ? input.stressLoad * PHI_INV : 0,
        inOptimalZone,
        law           : 'L-78',
    };
}

// ─── L-79 Temporal Discounting ────────────────────────────────────────────────

/**
 * L-79: Temporal Discounting
 * PV = reward / (1 + k × delay)          (hyperbolic discounting)
 * Long-term correction: × φ⁻¹  (φ-weighted patience bonus)
 */
export function L79_temporalDiscounting(input: L79Input): L79Output {
    const rawPV              = input.reward / (1 + input.k * input.delay);
    const longTermCorrection = PHI_INV;
    return {
        presentValue       : rawPV * longTermCorrection,
        longTermCorrection,
        law                : 'L-79',
    };
}

// ─── BehavioralEconomicsLaws — class facade ───────────────────────────────────

/**
 * Convenient stateful wrapper that tracks a global tick counter.
 * Expose all 8 laws as methods.
 */
export class BehavioralEconomicsLaws {
    private _tick: number = 0;

    get tick(): number { return this._tick; }

    advanceTick(): void { this._tick++; }

    /** L-72 Reward Signal */
    rewardSignal(input: L72Input): L72Output {
        return L72_rewardSignal(input);
    }

    /** L-73 Data Reward Equivalence */
    dataRewardEquivalence(input: L73Input): L73Output {
        return L73_dataRewardEquivalence(input);
    }

    /** L-74 Behavioral Asymmetry — uses LOSS_AVERSION_LAMBDA = 2.25 */
    behavioralAsymmetry(input: L74Input): L74Output {
        return L74_behavioralAsymmetry(input);
    }

    /** L-75 Variable Emergence — auto-uses internal tick */
    variableEmergence(input: Omit<L75Input, 'tick'>): L75Output {
        return L75_variableEmergence({ ...input, tick: this._tick });
    }

    /** L-76 Flow State */
    flowState(input: L76Input): L76Output {
        return L76_flowState(input);
    }

    /** L-77 Drive Commitment */
    driveCommitment(input: L77Input): L77Output {
        return L77_driveCommitment(input);
    }

    /** L-78 Hormetic Stress */
    hormeticStress(input: L78Input): L78Output {
        return L78_hormeticStress(input);
    }

    /** L-79 Temporal Discounting */
    temporalDiscounting(input: L79Input): L79Output {
        return L79_temporalDiscounting(input);
    }

    /** Apply all 8 laws in a single composite call */
    applyAll(inputs: {
        l72: L72Input;
        l73: L73Input;
        l74: L74Input;
        l75: Omit<L75Input, 'tick'>;
        l76: L76Input;
        l77: L77Input;
        l78: L78Input;
        l79: L79Input;
    }): {
        l72: L72Output; l73: L73Output; l74: L74Output; l75: L75Output;
        l76: L76Output; l77: L77Output; l78: L78Output; l79: L79Output;
    } {
        this.advanceTick();
        return {
            l72 : this.rewardSignal(inputs.l72),
            l73 : this.dataRewardEquivalence(inputs.l73),
            l74 : this.behavioralAsymmetry(inputs.l74),
            l75 : this.variableEmergence(inputs.l75),
            l76 : this.flowState(inputs.l76),
            l77 : this.driveCommitment(inputs.l77),
            l78 : this.hormeticStress(inputs.l78),
            l79 : this.temporalDiscounting(inputs.l79),
        };
    }

    manifest(): object {
        return {
            name    : 'BehavioralEconomicsLaws',
            paper   : 'V — De Oeconomia Behaviorali Machinarum',
            laws    : [
                { id: 'L-72', name: 'Reward Signal',            formula: 'reward = baseSignal × φ × dimensionalScalar' },
                { id: 'L-73', name: 'Data Reward Equivalence',  formula: 'dataReward = novelty × density × φ⁻¹' },
                { id: 'L-74', name: 'Behavioral Asymmetry',     formula: `lossResponse = lossSignal × ${LOSS_AVERSION_LAMBDA}` },
                { id: 'L-75', name: 'Variable Emergence',       formula: 'variableReward = base × (1 + sin(tick×φ) × amplitude)' },
                { id: 'L-76', name: 'Flow State',               formula: 'flowScore = 1 − |challenge − skill| / max' },
                { id: 'L-77', name: 'Drive Commitment',         formula: 'effectiveDrive = baseDrive × commitmentCoeff × φ' },
                { id: 'L-78', name: 'Hormetic Stress',          formula: 'adaptation = stressLoad × φ⁻¹  when  0.2 < load < 0.7' },
                { id: 'L-79', name: 'Temporal Discounting',     formula: 'PV = reward / (1 + k×delay) × φ⁻¹' },
            ],
            constants : {
                PHI,
                PHI_INV,
                LOSS_AVERSION_LAMBDA,
            },
            tick        : this._tick,
            attribution : 'Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX',
        };
    }
}

// ─── module-level singleton (optional convenience) ────────────────────────────

export const BEHAVIORAL_ECONOMICS = new BehavioralEconomicsLaws();
