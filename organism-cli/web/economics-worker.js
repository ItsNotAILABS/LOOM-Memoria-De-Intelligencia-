/**
 * ╔══════════════════════════════════════════════════════════════════════════════════╗
 * ║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                          ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA            ║
 * ║  ALL RIGHTS RESERVED.                                                              ║
 * ╚══════════════════════════════════════════════════════════════════════════════════╝
 *
 * ECONOMICS WORKER — NERVUS OECONOMICUS ORGANISMI
 * "Centrum oeconomicum organismi. Omnes actiones sunt actiones oeconomicae."
 * (Economic nervous center of the organism. All actions are economic actions.)
 *
 * Worker #42: NERVUS OECONOMICUS ORGANISMI
 * Frequency: φ¹⁰ = 122.99 Hz (Organism Layer 9)
 * PROTOCOL: PROT-377 to PROT-382 (Economics Organism)
 *
 * Central economic worker implementing:
 *   - The Eight Behavioral Economics Laws (L-72 through L-79)
 *   - INT-TOK Value Computation
 *   - Resource Allocation (φ-based)
 *   - Internal Market Dynamics
 *   - Economic Decision Making
 *
 * Protocol: postMessage
 *   Main → Worker: { type: 'compute-value', scc, layer, fibIdx }
 *   Main → Worker: { type: 'apply-law', law, params }
 *   Main → Worker: { type: 'allocate', resource, amount, strategy }
 *   Main → Worker: { type: 'decide', decisionType, value, context }
 *   Main → Worker: { type: 'trade', assetIn, amountIn, assetOut }
 *   Main → Worker: { type: 'status' }
 *   Worker → Main: { type: 'heartbeat', beat, stats }
 *   Worker → Main: { type: 'result', ... }
 *   Worker → Main: { type: 'booted', ... }
 *   Worker → Main: { type: 'error', message }
 *
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * L-130 COMPLIANT — All operations trace to primitive φ
 */

// ═══════════════════════════════════════════════════════════════════════════════
// φ SUBSTRATE CONSTANTS — The Mathematical Foundation
// ═══════════════════════════════════════════════════════════════════════════════

const PHI = 1.6180339887498948482;
const PHI_INV = 0.6180339887498948482;     // 1/φ
const PHI_SQ = 2.6180339887498948482;      // φ²
const PHI_CUBED = 4.2360679774997896;      // φ³
const PHI_10 = 122.9918694876056;          // φ¹⁰ (Economics frequency)
const SCHUMANN = 7.83;
const FIBONACCI = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584];

// ── The Eight Behavioral Economics Laws ────────────────────────────────────────
const LOSS_AVERSION_LAMBDA = 2.25;          // L-72
const ANCHORING_PERSISTENCE = PHI_INV;      // L-73
const REPRESENTATIVENESS_FAILURE = 0.35;    // L-74
const AVAILABILITY_RECENCY_WEIGHT = PHI;    // L-75
const REGRET_AVERSION_THRESHOLD = 0.72;     // L-76
const FRAMING_EFFECT_MAGNITUDE = 0.28;      // L-77
const HORMETIC_STRESS_FLOOR = 0.15;         // L-78
const HORMETIC_STRESS_CEILING = 0.72;       // L-78
const HYPERBOLIC_K = 0.35;                  // L-79

// Silver Premium (Physical Temple multiplier)
const SILVER_PREMIUM = PHI_CUBED;           // 4.236

// Barter tolerance (±38.2% = 1 - 1/φ)
const BARTER_TOLERANCE = 1 - PHI_INV;       // 0.382

const HEARTBEAT_MS = 873;                   // φ × 540 ≈ 873ms

// ═══════════════════════════════════════════════════════════════════════════════
// STATE
// ═══════════════════════════════════════════════════════════════════════════════

const bootTime = Date.now();
let beatCount = 0;
let operationCount = 0;

const state = {
    coherence: 0.85,
    stress: 0.35,
    totalCycles: 10000,
    allocatedCycles: 0,
    totalTokens: 1000,
    reservedTokens: 0,
    decisionCount: 0,
    tradeCount: 0,
    valueCreated: 0,
    fibIndex: 10,
};

// Asset prices in INT-TOK
const prices = {
    'INT-TOK': 1.0,
    'cycles': 0.001,
    'memory': 0.01,
    'compute': 0.005,
    'bandwidth': 0.002,
    'context': 0.1,
    'inference': 0.05,
};

// ═══════════════════════════════════════════════════════════════════════════════
// VALUE COMPUTATION — INT-TOK Formula
// ═══════════════════════════════════════════════════════════════════════════════

/**
 * Compute INT-TOK value: VALUE(K) = SCC × φ^L × F(n) / SCHUMANN
 */
function computeValue(scc, layer, fibIdx) {
    const fibVal = FIBONACCI[Math.min(fibIdx, 17)];
    return (scc * Math.pow(PHI, layer) * fibVal) / SCHUMANN;
}

/**
 * Compute value with Silver Premium
 */
function computeValueWithPremium(scc, layer, fibIdx) {
    const base = computeValue(scc, layer, fibIdx);
    const premiumApplied = state.coherence >= 0.90;
    const premium = premiumApplied ? base * SILVER_PREMIUM : base;
    return { base, premium, premiumApplied };
}

// ═══════════════════════════════════════════════════════════════════════════════
// BEHAVIORAL ECONOMICS LAWS — L-72 through L-79
// ═══════════════════════════════════════════════════════════════════════════════

/**
 * L-72: Loss Aversion — Losses weighted 2.25× gains
 */
function applyLossAversion(gain, loss) {
    const perceivedLoss = loss * LOSS_AVERSION_LAMBDA;
    const netUtility = gain - perceivedLoss;
    return {
        law: 'L-72',
        name: 'LOSS_AVERSION',
        lambda: LOSS_AVERSION_LAMBDA,
        rawGain: gain,
        rawLoss: loss,
        perceivedGain: gain,
        perceivedLoss,
        netUtility,
        dominated: perceivedLoss > gain,
        recommendation: perceivedLoss > gain ? 'AVOID' : 'PROCEED',
    };
}

/**
 * L-73: Anchoring — First value persists with weight 1/φ
 */
function applyAnchoring(anchor, newValue) {
    const perceivedValue = (ANCHORING_PERSISTENCE * anchor) + ((1 - ANCHORING_PERSISTENCE) * newValue);
    const bias = Math.abs(perceivedValue - newValue) / Math.max(Math.abs(newValue), 0.001);
    return {
        law: 'L-73',
        name: 'ANCHORING',
        persistence: ANCHORING_PERSISTENCE,
        anchor,
        newValue,
        perceivedValue,
        bias,
        biasDirection: bias > 0.1 ? 'toward_anchor' : 'neutral',
    };
}

/**
 * L-75: Availability Bias — Recent events overweighted by φ
 */
function applyAvailabilityBias(baseValue, recencyWeight) {
    const weightedValue = baseValue * (1 + (recencyWeight - 0.5) * AVAILABILITY_RECENCY_WEIGHT);
    return {
        law: 'L-75',
        name: 'AVAILABILITY_BIAS',
        recencyMultiplier: AVAILABILITY_RECENCY_WEIGHT,
        recencyWeight,
        baseValue,
        weightedValue,
        recencyEffect: weightedValue / Math.max(baseValue, 0.001),
    };
}

/**
 * L-76: Regret Aversion — Above threshold 0.72, decision freezes
 */
function applyRegretAversion(probability) {
    const paralysis = probability > REGRET_AVERSION_THRESHOLD;
    return {
        law: 'L-76',
        name: 'REGRET_AVERSION',
        threshold: REGRET_AVERSION_THRESHOLD,
        probability,
        paralysis,
        action: paralysis ? 'FREEZE' : 'DECIDE',
        margin: Math.abs(probability - REGRET_AVERSION_THRESHOLD),
    };
}

/**
 * L-77: Framing Effect — Frame-dependent perception ±28%
 */
function applyFramingEffect(value, frame) {
    let adjustment;
    if (frame === 'gain') {
        adjustment = 1 + FRAMING_EFFECT_MAGNITUDE;
    } else if (frame === 'loss') {
        adjustment = 1 - FRAMING_EFFECT_MAGNITUDE;
    } else {
        adjustment = 1.0;
    }
    const perceivedValue = value * adjustment;
    return {
        law: 'L-77',
        name: 'FRAMING_EFFECT',
        magnitude: FRAMING_EFFECT_MAGNITUDE,
        rawValue: value,
        frame,
        adjustment,
        perceivedValue,
    };
}

/**
 * L-78: Hormetic Stress — Performance improves in [0.15, 0.72] zone
 */
function applyHormeticStress(stress, baseline) {
    const inZone = stress >= HORMETIC_STRESS_FLOOR && stress <= HORMETIC_STRESS_CEILING;
    let output, zoneStatus;
    
    if (inZone) {
        const zoneCenter = (HORMETIC_STRESS_FLOOR + HORMETIC_STRESS_CEILING) / 2;
        const zoneWidth = HORMETIC_STRESS_CEILING - HORMETIC_STRESS_FLOOR;
        const normalized = (stress - zoneCenter) / (zoneWidth / 2);
        const boost = 1 + (PHI_INV * (1 - normalized * normalized));
        output = baseline * boost;
        zoneStatus = 'OPTIMAL';
    } else if (stress < HORMETIC_STRESS_FLOOR) {
        output = baseline * (0.9 + stress / HORMETIC_STRESS_FLOOR * 0.1);
        zoneStatus = 'STAGNATION';
    } else {
        const overage = stress - HORMETIC_STRESS_CEILING;
        const degradation = overage * LOSS_AVERSION_LAMBDA;
        output = baseline * Math.max(0.5, 1 - degradation);
        zoneStatus = 'DEGRADATION';
    }
    
    return {
        law: 'L-78',
        name: 'HORMETIC_STRESS',
        zone: [HORMETIC_STRESS_FLOOR, HORMETIC_STRESS_CEILING],
        stressInput: stress,
        baseline,
        output,
        gain: output - baseline,
        inHormeticZone: inZone,
        zoneStatus,
    };
}

/**
 * L-79: Hyperbolic Discount — Future rewards discounted at 1/(1 + 0.35×delay)
 */
function applyHyperbolicDiscount(value, delay) {
    const discounted = value / (1 + HYPERBOLIC_K * delay);
    return {
        law: 'L-79',
        name: 'HYPERBOLIC_DISCOUNT',
        k: HYPERBOLIC_K,
        nominalValue: value,
        delay,
        discountedValue: discounted,
        discountRate: value > 0 ? 1 - (discounted / value) : 0,
    };
}

// ═══════════════════════════════════════════════════════════════════════════════
// RESOURCE ALLOCATION — φ-based Distribution
// ═══════════════════════════════════════════════════════════════════════════════

/**
 * φ-split: Split amount into 61.8% / 38.2%
 */
function phiSplit(amount) {
    const major = amount * PHI_INV;
    const minor = amount - major;
    return { major, minor };
}

/**
 * Allocate resources
 */
function allocate(resource, amount, strategy = 'phi_split') {
    let allocated;
    const available = state.totalCycles - state.allocatedCycles;
    
    if (strategy === 'phi_split') {
        allocated = Math.min(amount * PHI_INV, available);
    } else if (strategy === 'coherence') {
        allocated = Math.min(amount * state.coherence, available);
    } else if (strategy === 'fibonacci') {
        const fibFactor = FIBONACCI[Math.min(state.fibIndex, 12)] / FIBONACCI[12];
        allocated = Math.min(amount * fibFactor, available);
    } else {
        allocated = Math.min(amount, available);
    }
    
    if (resource === 'cycles') {
        state.allocatedCycles += allocated;
    } else if (resource === 'tokens') {
        state.reservedTokens += Math.floor(allocated);
    }
    
    operationCount++;
    
    return {
        resource,
        requested: amount,
        allocated,
        efficiency: amount > 0 ? allocated / amount : 0,
        strategy,
        remaining: state.totalCycles - state.allocatedCycles,
    };
}

// ═══════════════════════════════════════════════════════════════════════════════
// ECONOMIC DECISIONS
// ═══════════════════════════════════════════════════════════════════════════════

/**
 * Make an economic decision applying relevant laws
 */
function makeDecision(decisionType, value, context = {}) {
    const lawsApplied = [];
    const reasoning = [];
    let output = value;
    let outcome = 'APPROVE';
    
    if (decisionType === 'allocation' || decisionType === 'investment') {
        // L-72: Loss Aversion
        const gain = context.expectedGain || value * 0.1;
        const loss = context.expectedLoss || value * 0.05;
        const lossResult = applyLossAversion(gain, loss);
        lawsApplied.push('L-72');
        reasoning.push(`L-72: Net utility = ${lossResult.netUtility.toFixed(2)}`);
        
        if (lossResult.dominated) {
            output *= 0.5;
            reasoning.push(`Loss-dominated → reduce to ${output.toFixed(2)}`);
        }
        
        // L-79: Hyperbolic Discount
        const delay = context.delay || 0;
        if (delay > 0) {
            const discountResult = applyHyperbolicDiscount(output, delay);
            output = discountResult.discountedValue;
            lawsApplied.push('L-79');
            reasoning.push(`L-79: Delay ${delay} → ${output.toFixed(2)}`);
        }
    } else if (decisionType === 'pricing') {
        // L-73: Anchoring
        if (context.anchor) {
            const anchorResult = applyAnchoring(context.anchor, output);
            output = anchorResult.perceivedValue;
            lawsApplied.push('L-73');
            reasoning.push(`L-73: Anchored → ${output.toFixed(2)}`);
        }
        
        // L-77: Framing
        const frame = context.frame || 'neutral';
        const frameResult = applyFramingEffect(output, frame);
        output = frameResult.perceivedValue;
        lawsApplied.push('L-77');
        reasoning.push(`L-77: Frame '${frame}' → ${output.toFixed(2)}`);
    } else if (decisionType === 'risk') {
        // L-76: Regret Aversion
        const probability = context.regretProbability || 0.5;
        const regretResult = applyRegretAversion(probability);
        lawsApplied.push('L-76');
        
        if (regretResult.paralysis) {
            output *= 0.3;
            outcome = 'DEFER';
            reasoning.push(`L-76: Regret ${probability.toFixed(2)} > 0.72 → FREEZE`);
        } else {
            reasoning.push(`L-76: Regret ${probability.toFixed(2)} ≤ 0.72 → PROCEED`);
        }
    } else if (decisionType === 'performance') {
        // L-78: Hormetic Stress
        const stress = context.stress || state.stress;
        const stressResult = applyHormeticStress(stress, output);
        output = stressResult.output;
        lawsApplied.push('L-78');
        reasoning.push(`L-78: Stress ${stress.toFixed(2)} → ${output.toFixed(2)} (${stressResult.zoneStatus})`);
    }
    
    state.decisionCount++;
    state.valueCreated += Math.max(0, output - value);
    operationCount++;
    
    return {
        decisionType,
        input: value,
        output,
        outcome,
        lawsApplied,
        reasoning,
        netUtility: output - value,
        coherence: state.coherence,
        timestamp: new Date().toISOString(),
    };
}

// ═══════════════════════════════════════════════════════════════════════════════
// TRADE / SWAP
// ═══════════════════════════════════════════════════════════════════════════════

/**
 * Swap one asset for another
 */
function swap(assetIn, amountIn, assetOut) {
    const priceIn = prices[assetIn] || 1;
    const priceOut = prices[assetOut] || 1;
    
    const valueIn = amountIn * priceIn;
    let amountOut = valueIn / priceOut;
    
    // Apply φ efficiency
    amountOut *= PHI_INV;
    
    state.tradeCount++;
    operationCount++;
    
    return {
        assetIn,
        amountIn,
        assetOut,
        amountOut,
        rate: amountOut / amountIn,
        phiEfficiency: PHI_INV,
        timestamp: new Date().toISOString(),
    };
}

// ═══════════════════════════════════════════════════════════════════════════════
// STATISTICS
// ═══════════════════════════════════════════════════════════════════════════════

function getStatistics() {
    return {
        coherence: state.coherence,
        stress: state.stress,
        totalCycles: state.totalCycles,
        allocatedCycles: state.allocatedCycles,
        availableCycles: state.totalCycles - state.allocatedCycles,
        totalTokens: state.totalTokens,
        reservedTokens: state.reservedTokens,
        availableTokens: state.totalTokens - state.reservedTokens,
        decisionCount: state.decisionCount,
        tradeCount: state.tradeCount,
        valueCreated: state.valueCreated,
        fibIndex: state.fibIndex,
        operationCount,
        silverPremiumActive: state.coherence >= 0.90,
        uptime: Date.now() - bootTime,
    };
}

function getLawManifest() {
    return {
        'L-72': { name: 'LOSS_AVERSION', constant: 'λ', value: LOSS_AVERSION_LAMBDA, effect: 'Losses weighted 2.25× gains' },
        'L-73': { name: 'ANCHORING', constant: 'persistence', value: ANCHORING_PERSISTENCE, effect: 'First value persists with weight 1/φ' },
        'L-74': { name: 'REPRESENTATIVENESS_FAILURE', constant: 'failure_rate', value: REPRESENTATIVENESS_FAILURE, effect: '35% failure rate under novel conditions' },
        'L-75': { name: 'AVAILABILITY_BIAS', constant: 'recency_weight', value: AVAILABILITY_RECENCY_WEIGHT, effect: 'Recent events overweighted by φ' },
        'L-76': { name: 'REGRET_AVERSION', constant: 'threshold', value: REGRET_AVERSION_THRESHOLD, effect: 'Decision freezes above 0.72 regret probability' },
        'L-77': { name: 'FRAMING_EFFECT', constant: 'magnitude', value: FRAMING_EFFECT_MAGNITUDE, effect: 'Identical choices, different frames → 28% swing' },
        'L-78': { name: 'HORMETIC_STRESS', constant: 'zone', value: [HORMETIC_STRESS_FLOOR, HORMETIC_STRESS_CEILING], effect: 'Performance improves in [0.15, 0.72] stress zone' },
        'L-79': { name: 'HYPERBOLIC_DISCOUNT', constant: 'k', value: HYPERBOLIC_K, effect: 'Future rewards discounted at 1/(1 + 0.35×delay)' },
    };
}

// ═══════════════════════════════════════════════════════════════════════════════
// HEARTBEAT — 873ms Sovereign Pulse
// ═══════════════════════════════════════════════════════════════════════════════

function heartbeat() {
    beatCount++;
    
    self.postMessage({
        type: 'heartbeat',
        beat: beatCount,
        uptime: Date.now() - bootTime,
        coherence: state.coherence,
        stress: state.stress,
        decisionCount: state.decisionCount,
        valueCreated: state.valueCreated,
        operationCount,
        phi10: PHI_10,
    });
}

setInterval(heartbeat, HEARTBEAT_MS);

// ═══════════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════════

self.onmessage = function(e) {
    const { type, ...params } = e.data;
    
    try {
        switch (type) {
            case 'compute-value': {
                const { scc, layer, fibIdx } = params;
                const result = computeValueWithPremium(scc || 4.0, layer || 9, fibIdx || state.fibIndex);
                self.postMessage({ type: 'result', operation: 'compute-value', ...result });
                break;
            }
            
            case 'apply-law': {
                const { law, ...lawParams } = params;
                let result;
                
                switch (law) {
                    case 'L-72':
                        result = applyLossAversion(lawParams.gain || 100, lawParams.loss || 50);
                        break;
                    case 'L-73':
                        result = applyAnchoring(lawParams.anchor || 100, lawParams.newValue || 150);
                        break;
                    case 'L-75':
                        result = applyAvailabilityBias(lawParams.baseValue || 100, lawParams.recency || 0.7);
                        break;
                    case 'L-76':
                        result = applyRegretAversion(lawParams.probability || 0.5);
                        break;
                    case 'L-77':
                        result = applyFramingEffect(lawParams.value || 100, lawParams.frame || 'neutral');
                        break;
                    case 'L-78':
                        result = applyHormeticStress(lawParams.stress || 0.4, lawParams.baseline || 100);
                        break;
                    case 'L-79':
                        result = applyHyperbolicDiscount(lawParams.value || 100, lawParams.delay || 1);
                        break;
                    default:
                        result = { error: `Unknown law: ${law}` };
                }
                
                self.postMessage({ type: 'result', operation: 'apply-law', ...result });
                break;
            }
            
            case 'allocate': {
                const result = allocate(params.resource || 'cycles', params.amount || 100, params.strategy || 'phi_split');
                self.postMessage({ type: 'result', operation: 'allocate', ...result });
                break;
            }
            
            case 'decide': {
                const result = makeDecision(params.decisionType || 'allocation', params.value || 100, params.context || {});
                self.postMessage({ type: 'result', operation: 'decide', ...result });
                break;
            }
            
            case 'trade':
            case 'swap': {
                const result = swap(params.assetIn || 'INT-TOK', params.amountIn || 10, params.assetOut || 'cycles');
                self.postMessage({ type: 'result', operation: 'swap', ...result });
                break;
            }
            
            case 'phi-split': {
                const result = phiSplit(params.amount || 100);
                self.postMessage({ type: 'result', operation: 'phi-split', ...result });
                break;
            }
            
            case 'update-coherence': {
                state.coherence = Math.max(0, Math.min(1, params.coherence || 0.85));
                self.postMessage({ type: 'result', operation: 'update-coherence', coherence: state.coherence });
                break;
            }
            
            case 'update-stress': {
                state.stress = Math.max(0, Math.min(1, params.stress || 0.35));
                self.postMessage({ type: 'result', operation: 'update-stress', stress: state.stress });
                break;
            }
            
            case 'laws': {
                self.postMessage({ type: 'result', operation: 'laws', manifest: getLawManifest() });
                break;
            }
            
            case 'statistics':
            case 'status': {
                self.postMessage({ type: 'result', operation: 'status', ...getStatistics() });
                break;
            }
            
            default:
                self.postMessage({ type: 'error', message: `Unknown command: ${type}` });
        }
    } catch (err) {
        self.postMessage({ type: 'error', message: err.message, stack: err.stack });
    }
};

// ═══════════════════════════════════════════════════════════════════════════════
// BOOT SIGNAL
// ═══════════════════════════════════════════════════════════════════════════════

self.postMessage({
    type: 'booted',
    worker: 'economics-worker',
    workerNumber: 42,
    latinName: 'NERVUS OECONOMICUS ORGANISMI',
    englishName: 'Economic Nervous System',
    frequency: PHI_10,
    protocols: ['PROT-377', 'PROT-378', 'PROT-379', 'PROT-380', 'PROT-381', 'PROT-382'],
    heartbeatMs: HEARTBEAT_MS,
    constants: {
        PHI,
        PHI_INV,
        PHI_SQ,
        PHI_CUBED,
        PHI_10,
        SCHUMANN,
        SILVER_PREMIUM,
        BARTER_TOLERANCE,
    },
    laws: Object.keys(getLawManifest()),
    capabilities: [
        'compute-value', 'apply-law', 'allocate', 'decide',
        'trade', 'swap', 'phi-split', 'laws', 'status'
    ],
    attribution: 'Alfredo Medina Hernandez | Medina Tech | Dallas, TX',
});

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE END — φ governs all
// ═══════════════════════════════════════════════════════════════════════════════
