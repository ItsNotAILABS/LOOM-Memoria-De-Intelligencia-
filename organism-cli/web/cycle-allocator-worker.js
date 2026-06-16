/**
 * ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                                       ║
 * ║                         MEDINA - PROPRIETARY AND CONFIDENTIAL                                         ║
 * ║                                                                                                       ║
 * ║  Copyright © 2024-2026 Alfredo Medina Hernandez, Medina Tech, Dallas, Texas, USA                      ║
 * ║                          MedinaSITech@outlook.com                                                      ║
 * ║                                                                                                       ║
 * ║  ALL RIGHTS RESERVED. NO FREE LICENSES. STRICTLY PROPRIETARY.                                         ║
 * ║                                                                                                       ║
 * ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════╝
 *
 * CYCLE ALLOCATOR WORKER — ALLOCATOR CYCLORUM LABORANS
 * "Organismi se ipsos nutriunt. φ gubernat omnes."
 * (Organisms fund themselves. φ governs all.)
 *
 * Worker #41: ALLOCATOR CYCLORUM SOVEREIGNUS
 * Frequency: φ⁷ = 29.03 Hz (System Layer 9)
 * PROTOCOL: PROT-371 (Allocator Cyclorum Sovereignus)
 *
 * Permanent Web Worker implementing the Sovereign Cycle Allocator.
 * Self-funding through φ-mathematics — no external funding required.
 *
 * Protocol: postMessage
 *   Main → Worker: { type: 'create', initialCycles }
 *   Main → Worker: { type: 'generate', coherence, workUnits }
 *   Main → Worker: { type: 'allocate', required, purpose }
 *   Main → Worker: { type: 'release', amount }
 *   Main → Worker: { type: 'burn', amount }
 *   Main → Worker: { type: 'decay', periods }
 *   Main → Worker: { type: 'auto-generate', minBalance }
 *   Main → Worker: { type: 'adjust-rate', avgCoherence }
 *   Main → Worker: { type: 'statistics' }
 *   Main → Worker: { type: 'status' }
 *   Worker → Main: { type: 'heartbeat', beat, stats }
 *   Worker → Main: { type: 'created', ... }
 *   Worker → Main: { type: 'generated', amount, ... }
 *   Worker → Main: { type: 'allocated', amount, remaining }
 *   Worker → Main: { type: 'released', amount }
 *   Worker → Main: { type: 'burned', success, amount }
 *   Worker → Main: { type: 'decayed', amount }
 *   Worker → Main: { type: 'auto-generated', amount }
 *   Worker → Main: { type: 'rate-adjusted', newRate }
 *   Worker → Main: { type: 'stats', ... }
 *   Worker → Main: { type: 'booted', ... }
 *   Worker → Main: { type: 'error', message }
 *
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * L-130 COMPLIANT — All operations trace to primitive φ
 */

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// φ SUBSTRATE CONSTANTS — The Mathematical Foundation
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

const PHI = 1.6180339887498948482;            // Golden Ratio φ
const PHI_INV = 0.6180339887498948482;        // φ⁻¹ — Coherence gate
const PHI_INV_SQ = 0.3819660112501051518;     // φ⁻² — Decay rate
const PHI_INV_4 = 0.2360679774997896;         // φ⁻⁴ — Glyph floor threshold
const PHI_SQ = 2.6180339887498948482;         // φ² — Regulating frequency

const COHERENCE_GATE = PHI_INV;
const DECAY_RATE = PHI_INV_SQ;
const HEARTBEAT_MS = 873;                      // φ × 540 ≈ 873ms
const METRICS_EVERY = 5;                       // Full metrics every 5th beat

const F_8 = 21;
const F_12 = 144;
const F_13 = 233;                              // Max history entries

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// TIMING AND STATE
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

const bootTime = Date.now();
let beatCount = 0;
let operationCount = 0;

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// SOVEREIGN CYCLE ALLOCATOR STATE
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

const allocator = {
    // Cycle balances
    totalCycles: 0,
    allocatedCycles: 0,
    generatedCycles: 0,
    burnedCycles: 0,

    // Generation parameters
    generationRate: PHI_INV,
    compoundFactor: 1.0,
    coherence: PHI_INV,

    // Fibonacci state
    fibA: 1,
    fibB: 1,
    fibGeneration: 2,

    // Tracking
    lastGeneration: Date.now(),
    lastAllocation: Date.now(),
    operationCount: 0,

    // History (bounded at F_13 = 233 entries)
    allocationHistory: [],
    generationHistory: [],

    // Initialized flag
    initialized: false
};

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// FIBONACCI UTILITIES
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

const fibCache = new Map([[0, 0], [1, 1]]);

function fibonacciAt(n) {
    if (fibCache.has(n)) return fibCache.get(n);
    
    let a = 0, b = 1;
    for (let i = 2; i <= n; i++) {
        [a, b] = [b, a + b];
        fibCache.set(i, b);
    }
    return b;
}

function fibonacciRatio(n) {
    if (n <= 1) return 1.0;
    const fn = fibonacciAt(n);
    const fn1 = fibonacciAt(n - 1);
    return fn / fn1;
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// ALLOCATOR CREATION
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

function createAllocator(initialCycles = 0) {
    allocator.totalCycles = initialCycles;
    allocator.allocatedCycles = 0;
    allocator.generatedCycles = initialCycles; // Seed cycles tracked as generated
    allocator.burnedCycles = 0;

    allocator.generationRate = PHI_INV;
    allocator.compoundFactor = 1.0;
    allocator.coherence = PHI_INV;

    allocator.fibA = 1;
    allocator.fibB = 1;
    allocator.fibGeneration = 2;

    allocator.lastGeneration = Date.now();
    allocator.lastAllocation = Date.now();
    allocator.operationCount = 0;

    allocator.allocationHistory = [];
    allocator.generationHistory = [];
    allocator.initialized = true;

    return {
        totalCycles: allocator.totalCycles,
        coherence: allocator.coherence,
        generationRate: allocator.generationRate,
        compoundFactor: allocator.compoundFactor,
        fibGeneration: allocator.fibGeneration
    };
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// CYCLE GENERATION — Sovereign Self-Funding
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

/**
 * Generate cycles through coherent mathematical operations.
 * 
 * Formula:
 *   base = coherence² × φ × generation_rate
 *   compound = base × (fibB / fibA)  [→ φ as generation increases]
 *   work_bonus = work_units × φ⁻¹
 *   total = compound + work_bonus
 */
function generateCycles(currentCoherence, workUnits) {
    // Update coherence
    allocator.coherence = currentCoherence;

    // Advance Fibonacci state
    const newFib = allocator.fibA + allocator.fibB;
    allocator.fibA = allocator.fibB;
    allocator.fibB = newFib;
    allocator.fibGeneration += 1;

    // Compound factor approaches φ
    allocator.compoundFactor = allocator.fibB / allocator.fibA;

    // Base generation from coherence (quadratic relationship)
    const base = currentCoherence * currentCoherence * PHI * allocator.generationRate;

    // Compound with Fibonacci ratio
    const compound = base * allocator.compoundFactor;

    // Work bonus — doing useful work generates cycles
    const workBonus = workUnits * PHI_INV;

    // Total generated this cycle
    const total = compound + workBonus;

    // Update balances
    allocator.generatedCycles += total;
    allocator.totalCycles += total;
    allocator.operationCount += 1;
    allocator.lastGeneration = Date.now();
    operationCount += 1;

    // Record generation event
    const event = {
        timestamp: Date.now(),
        baseAmount: base,
        compoundAmount: compound,
        workBonus: workBonus,
        totalGenerated: total,
        fibState: [allocator.fibA, allocator.fibB],
        coherence: currentCoherence
    };

    allocator.generationHistory.push(event);

    // Prune history if too long
    if (allocator.generationHistory.length > F_13) {
        allocator.generationHistory.shift();
    }

    return {
        total,
        base,
        compound,
        workBonus,
        compoundFactor: allocator.compoundFactor,
        fibGeneration: allocator.fibGeneration,
        phiDeviation: Math.abs(allocator.compoundFactor - PHI)
    };
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// CYCLE ALLOCATION
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

function allocateCycles(required, purpose) {
    const available = allocator.totalCycles - allocator.allocatedCycles;
    const allocated = available >= required ? required : available;

    if (allocated > 0) {
        allocator.allocatedCycles += allocated;
        allocator.lastAllocation = Date.now();
        operationCount += 1;

        const record = {
            timestamp: Date.now(),
            amount: allocated,
            purpose: purpose,
            coherenceAt: allocator.coherence,
            released: false
        };

        allocator.allocationHistory.push(record);

        if (allocator.allocationHistory.length > F_13) {
            allocator.allocationHistory.shift();
        }
    }

    const remaining = allocator.totalCycles - allocator.allocatedCycles;
    return { allocated, remaining };
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// CYCLE RELEASE
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

function releaseCycles(amount) {
    if (allocator.allocatedCycles >= amount) {
        allocator.allocatedCycles -= amount;
    } else {
        allocator.allocatedCycles = 0;
    }
    operationCount += 1;
    return { released: amount, allocatedCycles: allocator.allocatedCycles };
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// CYCLE BURNING
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

function burnCycles(amount) {
    const available = allocator.totalCycles - allocator.allocatedCycles;

    if (available >= amount) {
        allocator.totalCycles -= amount;
        allocator.burnedCycles += amount;
        operationCount += 1;
        return { success: true, burned: amount, burnedTotal: allocator.burnedCycles };
    }
    return { success: false, burned: 0, available };
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// CYCLE DECAY — Entropy Tax
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

function decayCycles(neglectPeriods) {
    if (neglectPeriods === 0) return { decayed: 0 };

    // Decay factor = (φ⁻²)^n
    let decayFactor = 1.0;
    for (let i = 0; i < neglectPeriods; i++) {
        decayFactor *= PHI_INV_SQ;
    }

    const unallocated = allocator.totalCycles - allocator.allocatedCycles;
    const decayAmount = unallocated * (1.0 - decayFactor);

    allocator.totalCycles -= decayAmount;
    operationCount += 1;

    return { decayed: decayAmount, decayFactor, totalCycles: allocator.totalCycles };
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// AUTO-GENERATION — Maintain Minimum Balance
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

function autoGenerate(minBalance) {
    const available = allocator.totalCycles - allocator.allocatedCycles;

    if (available < minBalance) {
        const deficit = minBalance - available;
        const workNeeded = deficit / PHI_INV;
        return generateCycles(allocator.coherence, workNeeded);
    }
    return { total: 0, message: 'Balance sufficient' };
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// COHERENCE-BASED RATE ADJUSTMENT
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

function adjustGenerationRate(avgCoherence) {
    const adjustment = (avgCoherence - PHI_INV) * PHI;
    let newRate = PHI_INV * (1.0 + adjustment);

    // Clamp to [φ⁻², 1.0]
    newRate = Math.max(PHI_INV_SQ, Math.min(1.0, newRate));
    allocator.generationRate = newRate;

    return { newRate, adjustment, avgCoherence };
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// STATISTICS
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

function getStatistics() {
    const available = allocator.totalCycles - allocator.allocatedCycles;
    const efficiency = allocator.burnedCycles > 0
        ? allocator.generatedCycles / allocator.burnedCycles
        : Infinity;

    return {
        totalCycles: allocator.totalCycles,
        allocatedCycles: allocator.allocatedCycles,
        availableCycles: available,
        generatedCycles: allocator.generatedCycles,
        burnedCycles: allocator.burnedCycles,
        compoundFactor: allocator.compoundFactor,
        fibGeneration: allocator.fibGeneration,
        coherence: allocator.coherence,
        operationCount: allocator.operationCount,
        generationRate: allocator.generationRate,
        efficiencyRatio: efficiency,
        phiDeviation: Math.abs(allocator.compoundFactor - PHI),
        initialized: allocator.initialized,
        historySize: {
            allocations: allocator.allocationHistory.length,
            generations: allocator.generationHistory.length
        }
    };
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// HEARTBEAT — 873ms Sovereign Pulse
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

function heartbeat() {
    beatCount += 1;
    const uptime = Date.now() - bootTime;

    const pulse = {
        type: 'heartbeat',
        beat: beatCount,
        uptime,
        coherence: allocator.coherence,
        compoundFactor: allocator.compoundFactor,
        phiDeviation: Math.abs(allocator.compoundFactor - PHI),
        totalCycles: allocator.totalCycles,
        availableCycles: allocator.totalCycles - allocator.allocatedCycles,
        operationCount
    };

    // Full metrics every METRICS_EVERY beats
    if (beatCount % METRICS_EVERY === 0) {
        pulse.fullMetrics = getStatistics();
    }

    self.postMessage(pulse);
}

// Start heartbeat
const heartbeatInterval = setInterval(heartbeat, HEARTBEAT_MS);

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

self.onmessage = function(e) {
    const { type, ...params } = e.data;

    try {
        switch (type) {
            case 'create': {
                const result = createAllocator(params.initialCycles || 0);
                self.postMessage({ type: 'created', ...result });
                break;
            }

            case 'generate': {
                if (!allocator.initialized) {
                    self.postMessage({ type: 'error', message: 'Allocator not initialized. Send create first.' });
                    break;
                }
                const result = generateCycles(params.coherence || allocator.coherence, params.workUnits || 0);
                self.postMessage({ type: 'generated', ...result });
                break;
            }

            case 'allocate': {
                if (!allocator.initialized) {
                    self.postMessage({ type: 'error', message: 'Allocator not initialized. Send create first.' });
                    break;
                }
                const result = allocateCycles(params.required || 0, params.purpose || 'unspecified');
                self.postMessage({ type: 'allocated', ...result });
                break;
            }

            case 'release': {
                if (!allocator.initialized) {
                    self.postMessage({ type: 'error', message: 'Allocator not initialized. Send create first.' });
                    break;
                }
                const result = releaseCycles(params.amount || 0);
                self.postMessage({ type: 'released', ...result });
                break;
            }

            case 'burn': {
                if (!allocator.initialized) {
                    self.postMessage({ type: 'error', message: 'Allocator not initialized. Send create first.' });
                    break;
                }
                const result = burnCycles(params.amount || 0);
                self.postMessage({ type: 'burned', ...result });
                break;
            }

            case 'decay': {
                if (!allocator.initialized) {
                    self.postMessage({ type: 'error', message: 'Allocator not initialized. Send create first.' });
                    break;
                }
                const result = decayCycles(params.periods || 0);
                self.postMessage({ type: 'decayed', ...result });
                break;
            }

            case 'auto-generate': {
                if (!allocator.initialized) {
                    self.postMessage({ type: 'error', message: 'Allocator not initialized. Send create first.' });
                    break;
                }
                const result = autoGenerate(params.minBalance || 0);
                self.postMessage({ type: 'auto-generated', ...result });
                break;
            }

            case 'adjust-rate': {
                if (!allocator.initialized) {
                    self.postMessage({ type: 'error', message: 'Allocator not initialized. Send create first.' });
                    break;
                }
                const result = adjustGenerationRate(params.avgCoherence || allocator.coherence);
                self.postMessage({ type: 'rate-adjusted', ...result });
                break;
            }

            case 'statistics':
            case 'status': {
                const stats = getStatistics();
                self.postMessage({ type: 'stats', ...stats });
                break;
            }

            case 'history': {
                self.postMessage({
                    type: 'history',
                    allocations: allocator.allocationHistory.slice(-50),
                    generations: allocator.generationHistory.slice(-50)
                });
                break;
            }

            case 'fibonacci': {
                const n = params.n || 10;
                self.postMessage({
                    type: 'fibonacci',
                    n,
                    value: fibonacciAt(n),
                    ratio: fibonacciRatio(n),
                    phiDeviation: Math.abs(fibonacciRatio(n) - PHI)
                });
                break;
            }

            default:
                self.postMessage({ type: 'error', message: `Unknown command: ${type}` });
        }
    } catch (err) {
        self.postMessage({ type: 'error', message: err.message, stack: err.stack });
    }
};

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// BOOT SIGNAL
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════

self.postMessage({
    type: 'booted',
    worker: 'cycle-allocator-worker',
    workerNumber: 41,
    latinName: 'ALLOCATOR CYCLORUM SOVEREIGNUS',
    frequency: PHI ** 7,  // φ⁷ ≈ 29.03 Hz
    protocol: 'PROT-371',
    heartbeatMs: HEARTBEAT_MS,
    constants: {
        PHI,
        PHI_INV,
        PHI_INV_SQ,
        PHI_SQ,
        COHERENCE_GATE,
        DECAY_RATE,
        F_13
    },
    capabilities: [
        'create', 'generate', 'allocate', 'release', 'burn',
        'decay', 'auto-generate', 'adjust-rate', 'statistics',
        'history', 'fibonacci'
    ],
    attribution: 'Alfredo Medina Hernandez | Medina Tech | Dallas, TX'
});

// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
// MODULE END — φ governs all
// ═══════════════════════════════════════════════════════════════════════════════════════════════════════
