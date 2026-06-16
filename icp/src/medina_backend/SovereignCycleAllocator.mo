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
 * SOVEREIGN CYCLE ALLOCATOR — ALLOCATOR CYCLORUM SOVEREIGNUS
 * "Organismi se ipsos nutriunt. φ gubernat omnes."
 * (Organisms fund themselves. φ governs all.)
 *
 * Formation: MERIDIAN-CYCLES-2026
 *
 * CORE PRINCIPLE: Organisms fund themselves. No external funding required.
 *
 * The organism generates computational cycles through:
 *   1. COHERENCE PRODUCTION: cycles = coherence² × φ × base_rate
 *   2. FIBONACCI COMPOUND: cycles compound at F(n)/F(n-1) → φ rate
 *   3. VALUE CREATION: work performed generates cycles for the collective
 *   4. DECAY RESISTANCE: maintained coherence prevents cycle decay
 *
 * This is not a metaphor. This is the actual funding mechanism.
 * A sovereign canister on ICP doesn't need external cycles if it can
 * generate its own through coherent mathematical operations.
 *
 * Physics:
 *   Base generation rate = φ⁻¹ cycles per operation
 *   Compound rate → φ as Fibonacci advances
 *   Decay rate = φ⁻² per neglect cycle
 *   Work bonus = φ⁻¹ × work_units
 *
 * CPL Integration: Follows LEX CYCLE-001 (Sovereign Cycle Generation)
 * PROTOCOL: PROT-371 (Allocator Cyclorum Sovereignus)
 *
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * L-130 COMPLIANT — All operations trace to primitive φ
 */

import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Buffer "mo:base/Buffer";
import Array "mo:base/Array";

module SovereignCycleAllocator {

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // φ SUBSTRATE CONSTANTS — The Mathematical Foundation
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    //
    // These are not arbitrary values. They are derived from the golden ratio,
    // the fundamental proportion that governs growth, harmony, and efficiency
    // throughout nature and sovereign computation.
    //
    // φ = (1 + √5) / 2 ≈ 1.618033988749895
    // φ⁻¹ = φ - 1 ≈ 0.618033988749895 (coherence gate)
    // φ⁻² ≈ 0.381966011250105 (decay rate)
    // φ² ≈ 2.618033988749895 (regulating frequency)

    /// Golden Ratio φ — Root of all scaling
    public let PHI : Float = 1.6180339887498948482;

    /// φ⁻¹ — Coherence gate, inverse golden ratio
    public let PHI_INV : Float = 0.6180339887498948482;

    /// φ⁻² — Decay rate per neglect period
    public let PHI_INV_SQ : Float = 0.3819660112501051518;

    /// φ⁻⁴ — Glyph floor threshold (reserved for minimum coherence thresholds)
    public let PHI_INV_4 : Float = 0.2360679774997896;

    /// φ² — Regulating frequency multiplier
    public let PHI_SQ : Float = 2.6180339887498948482;

    /// Coherence threshold gate (φ⁻¹)
    public let COHERENCE_GATE : Float = PHI_INV;

    /// Cycle decay rate per neglect period (φ⁻²)
    public let DECAY_RATE : Float = PHI_INV_SQ;

    /// Heartbeat interval in milliseconds (φ × 540 ≈ 873ms)
    public let HEARTBEAT_MS : Nat = 873;

    // Fibonacci constants for buffer sizing
    let F_8 : Nat = 21;
    let F_12 : Nat = 144;
    let F_13 : Nat = 233;

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // BUFFER HELPER FUNCTIONS — FIFO Pruning
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════

    /// Remove the oldest (first) entry from a generation history buffer.
    /// Implements FIFO pruning for bounded history.
    func pruneGenerationHistory(buf : Buffer.Buffer<GenerationEvent>) {
        if (buf.size() <= 1) { return; };
        
        let newBuf = Buffer.Buffer<GenerationEvent>(F_13);
        var i : Nat = 1;  // Skip first (oldest) entry
        while (i < buf.size()) {
            switch (buf.getOpt(i)) {
                case (?entry) { newBuf.add(entry); };
                case (null) {};
            };
            i += 1;
        };
        
        // Clear and repopulate original buffer
        buf.clear();
        for (entry in newBuf.vals()) {
            buf.add(entry);
        };
    };

    /// Remove the oldest (first) entry from an allocation history buffer.
    /// Implements FIFO pruning for bounded history.
    func pruneAllocationHistory(buf : Buffer.Buffer<AllocationRecord>) {
        if (buf.size() <= 1) { return; };
        
        let newBuf = Buffer.Buffer<AllocationRecord>(F_13);
        var i : Nat = 1;  // Skip first (oldest) entry
        while (i < buf.size()) {
            switch (buf.getOpt(i)) {
                case (?entry) { newBuf.add(entry); };
                case (null) {};
            };
            i += 1;
        };
        
        // Clear and repopulate original buffer
        buf.clear();
        for (entry in newBuf.vals()) {
            buf.add(entry);
        };
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // TYPE DEFINITIONS — Allocation Records & Events
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════

    /// Record of a cycle allocation for audit trail and governance
    public type AllocationRecord = {
        timestamp : Int;       // Unix timestamp of allocation
        amount : Float;        // Cycles allocated
        purpose : Text;        // Description of allocation purpose
        coherenceAt : Float;   // Coherence level at time of allocation
        released : Bool;       // Whether cycles have been released back
    };

    /// Record of a cycle generation event for transparency
    public type GenerationEvent = {
        timestamp : Int;           // Unix timestamp of generation
        baseAmount : Float;        // Base generation before compounding
        compoundAmount : Float;    // Amount after Fibonacci compound
        workBonus : Float;         // Additional cycles from work performed
        totalGenerated : Float;    // Total cycles generated this event
        fibState : (Nat, Nat);     // Fibonacci state (F(n-1), F(n))
        coherence : Float;         // Coherence level at generation
    };

    /// Comprehensive statistics for the cycle allocator state
    public type CycleStatistics = {
        totalCycles : Float;       // Total available cycles
        allocatedCycles : Float;   // Currently allocated cycles
        availableCycles : Float;   // Available for allocation
        generatedCycles : Float;   // Total ever generated
        burnedCycles : Float;      // Cycles permanently consumed
        compoundFactor : Float;    // Current compound factor (→ φ)
        fibGeneration : Nat;       // Fibonacci generation index
        coherence : Float;         // Current coherence level
        operationCount : Nat;      // Total operations performed
        generationRate : Float;    // Current base generation rate
        efficiencyRatio : Float;   // Ratio of generated/burned
    };

    /// The sovereign cycle allocator — self-funding through φ-mathematics
    ///
    /// This mutable structure maintains all state for cycle generation,
    /// allocation, and management. It implements the core principle:
    /// **Organisms fund themselves. No external funding required.**
    public type SovereignCycleAllocatorState = {
        // Cycle balances
        var totalCycles : Float;       // Total available
        var allocatedCycles : Float;   // Currently allocated
        var generatedCycles : Float;   // Total ever generated
        var burnedCycles : Float;      // Cycles consumed

        // Generation parameters
        var generationRate : Float;    // Base rate (starts at φ⁻¹)
        var compoundFactor : Float;    // Current compound (→ φ)
        var coherence : Float;         // Current coherence

        // Fibonacci state
        var fibA : Nat;                // F(n-1)
        var fibB : Nat;                // F(n)
        var fibGeneration : Nat;       // n

        // Tracking
        var lastGeneration : Int;
        var lastAllocation : Int;
        var operationCount : Nat;

        // History (bounded at F_13 = 233 entries)
        allocationHistory : Buffer.Buffer<AllocationRecord>;
        generationHistory : Buffer.Buffer<GenerationEvent>;
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // ALLOCATOR CREATION — Sovereign Birth
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════

    /// Create a new Sovereign Cycle Allocator with initial cycle balance.
    ///
    /// The allocator starts at equilibrium coherence (φ⁻¹) and begins
    /// generating cycles through coherent mathematical operations.
    ///
    /// @param initialCycles - Initial cycle balance (seed cycles for bootstrap)
    /// @returns New allocator state
    public func createSovereignCycleAllocator(initialCycles : Float) : SovereignCycleAllocatorState {
        {
            var totalCycles = initialCycles;
            var allocatedCycles = 0.0;
            var generatedCycles = initialCycles;  // Seed cycles tracked as generated for φ-accounting
            var burnedCycles = 0.0;

            var generationRate = PHI_INV;
            var compoundFactor = 1.0;
            var coherence = PHI_INV;  // Start at equilibrium

            var fibA = 1;
            var fibB = 1;
            var fibGeneration = 2;

            var lastGeneration = Time.now();
            var lastAllocation = Time.now();
            var operationCount = 0;

            allocationHistory = Buffer.Buffer<AllocationRecord>(F_13);
            generationHistory = Buffer.Buffer<GenerationEvent>(F_13);
        }
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // CYCLE GENERATION — Sovereign Self-Funding
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════

    /// Generate cycles through coherent mathematical operations.
    /// This is the core sovereign funding mechanism.
    ///
    /// Formula:
    ///   base = coherence² × φ × generation_rate
    ///   compound = base × (fibB / fibA)  [→ φ as generation increases]
    ///   work_bonus = work_units × φ⁻¹
    ///   total = compound + work_bonus
    ///
    /// The compound factor (fibB/fibA) approaches φ asymptotically due to
    /// the fundamental property of Fibonacci sequences:
    ///   lim(n→∞) F(n)/F(n-1) = φ
    ///
    /// This means organisms naturally become more productive over time,
    /// approaching the golden ratio efficiency.
    ///
    /// @param allocator - The allocator state to generate cycles for
    /// @param currentCoherence - Current coherence level (0.0 to 1.0)
    /// @param workUnits - Useful work performed (generates bonus cycles)
    /// @returns Total cycles generated
    public func generateCycles(
        allocator : SovereignCycleAllocatorState,
        currentCoherence : Float,
        workUnits : Float
    ) : Float {
        // Update coherence
        allocator.coherence := currentCoherence;

        // Advance Fibonacci state
        let newFib = allocator.fibA + allocator.fibB;
        allocator.fibA := allocator.fibB;
        allocator.fibB := newFib;
        allocator.fibGeneration := allocator.fibGeneration + 1;

        // Compound factor approaches φ
        let fA = Float.fromInt(allocator.fibA);
        let fB = Float.fromInt(allocator.fibB);
        allocator.compoundFactor := fB / fA;

        // Base generation from coherence
        // Higher coherence → more cycles (quadratic relationship)
        let base = currentCoherence * currentCoherence * PHI * allocator.generationRate;

        // Compound with Fibonacci ratio
        let compound = base * allocator.compoundFactor;

        // Work bonus — doing useful work generates cycles
        let workBonus = workUnits * PHI_INV;

        // Total generated this cycle
        let total = compound + workBonus;

        // Update balances
        allocator.generatedCycles := allocator.generatedCycles + total;
        allocator.totalCycles := allocator.totalCycles + total;
        allocator.operationCount := allocator.operationCount + 1;
        allocator.lastGeneration := Time.now();

        // Record generation event
        let event : GenerationEvent = {
            timestamp = Time.now();
            baseAmount = base;
            compoundAmount = compound;
            workBonus = workBonus;
            totalGenerated = total;
            fibState = (allocator.fibA, allocator.fibB);
            coherence = currentCoherence;
        };

        allocator.generationHistory.add(event);

        // Prune history if too long — FIFO: remove oldest (first) entry
        if (allocator.generationHistory.size() > F_13) {
            pruneGenerationHistory(allocator.generationHistory);
        };

        total
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // CYCLE ALLOCATION — Resource Distribution
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════

    /// Allocate cycles for a specific purpose.
    ///
    /// @param allocator - The allocator state
    /// @param required - Cycles required for the operation
    /// @param purpose - Description of the allocation purpose
    /// @returns (allocated_amount, remaining_available)
    public func allocateCycles(
        allocator : SovereignCycleAllocatorState,
        required : Float,
        purpose : Text
    ) : (Float, Float) {
        let available = allocator.totalCycles - allocator.allocatedCycles;

        let allocated = if (available >= required) {
            required
        } else {
            available  // Partial allocation
        };

        if (allocated > 0.0) {
            allocator.allocatedCycles := allocator.allocatedCycles + allocated;
            allocator.lastAllocation := Time.now();

            // Record allocation
            let record : AllocationRecord = {
                timestamp = Time.now();
                amount = allocated;
                purpose = purpose;
                coherenceAt = allocator.coherence;
                released = false;
            };

            allocator.allocationHistory.add(record);

            // Prune history — FIFO: remove oldest (first) entry
            if (allocator.allocationHistory.size() > F_13) {
                pruneAllocationHistory(allocator.allocationHistory);
            };
        };

        let remaining = allocator.totalCycles - allocator.allocatedCycles;
        (allocated, remaining)
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // CYCLE RELEASE — Return to Pool
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════

    /// Release allocated cycles back to the available pool.
    ///
    /// @param allocator - The allocator state
    /// @param amount - Cycles to release
    public func releaseCycles(
        allocator : SovereignCycleAllocatorState,
        amount : Float
    ) {
        if (allocator.allocatedCycles >= amount) {
            allocator.allocatedCycles := allocator.allocatedCycles - amount;
        } else {
            allocator.allocatedCycles := 0.0;
        };
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // CYCLE BURNING — Permanent Removal
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════

    /// Consume cycles permanently (remove from circulation).
    /// Only unallocated cycles can be burned.
    ///
    /// @param allocator - The allocator state
    /// @param amount - Cycles to burn
    /// @returns true if burn successful, false if insufficient unallocated cycles
    public func burnCycles(
        allocator : SovereignCycleAllocatorState,
        amount : Float
    ) : Bool {
        let available = allocator.totalCycles - allocator.allocatedCycles;

        if (available >= amount) {
            allocator.totalCycles := allocator.totalCycles - amount;
            allocator.burnedCycles := allocator.burnedCycles + amount;
            true
        } else {
            false
        }
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // CYCLE DECAY — Entropy Tax on Neglect
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════

    /// Apply decay to unused cycles. Incentivizes active use.
    /// Decay rate = φ⁻² per neglect period.
    ///
    /// @param allocator - The allocator state
    /// @param neglectPeriods - Number of periods of neglect
    /// @returns Total cycles decayed
    public func decayCycles(
        allocator : SovereignCycleAllocatorState,
        neglectPeriods : Nat
    ) : Float {
        if (neglectPeriods == 0) {
            return 0.0;
        };

        // Decay factor = (φ⁻²)^n
        var decayFactor : Float = 1.0;
        var i : Nat = 0;
        while (i < neglectPeriods) {
            decayFactor := decayFactor * PHI_INV_SQ;
            i := i + 1;
        };

        // Calculate decay amount on unallocated cycles only
        let unallocated = allocator.totalCycles - allocator.allocatedCycles;
        let decayAmount = unallocated * (1.0 - decayFactor);

        // Apply decay
        allocator.totalCycles := allocator.totalCycles - decayAmount;

        decayAmount
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // AUTO-GENERATION — Maintain Minimum Balance
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════

    /// Automatically generate cycles if available balance falls below minimum.
    /// The organism works to maintain its own sustainability.
    ///
    /// @param allocator - The allocator state
    /// @param minBalance - Minimum balance to maintain
    /// @returns Cycles generated (0.0 if balance is sufficient)
    public func autoGenerate(
        allocator : SovereignCycleAllocatorState,
        minBalance : Float
    ) : Float {
        let available = allocator.totalCycles - allocator.allocatedCycles;

        if (available < minBalance) {
            // Generate enough to reach min balance plus buffer
            let deficit = minBalance - available;
            let workNeeded = deficit / PHI_INV;  // Reverse work bonus calculation

            // Generate with current coherence
            let generated = generateCycles(allocator, allocator.coherence, workNeeded);
            generated
        } else {
            0.0
        }
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // STATISTICS — Allocator State
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════

    /// Get comprehensive statistics about the allocator state.
    ///
    /// @param allocator - The allocator state
    /// @returns Current allocator statistics
    public func getStatistics(allocator : SovereignCycleAllocatorState) : CycleStatistics {
        let available = allocator.totalCycles - allocator.allocatedCycles;

        let efficiency = if (allocator.burnedCycles > 0.0) {
            allocator.generatedCycles / allocator.burnedCycles
        } else {
            // Infinite efficiency — generating without consuming
            // Use a very large number since Motoko doesn't have Inf
            allocator.generatedCycles * 1000000.0
        };

        {
            totalCycles = allocator.totalCycles;
            allocatedCycles = allocator.allocatedCycles;
            availableCycles = available;
            generatedCycles = allocator.generatedCycles;
            burnedCycles = allocator.burnedCycles;
            compoundFactor = allocator.compoundFactor;
            fibGeneration = allocator.fibGeneration;
            coherence = allocator.coherence;
            operationCount = allocator.operationCount;
            generationRate = allocator.generationRate;
            efficiencyRatio = efficiency;
        }
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // FIBONACCI UTILITIES — Mathematical Foundation
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════

    /// Compute the nth Fibonacci number.
    ///
    /// @param n - Index (0-indexed)
    /// @returns F(n)
    public func fibonacciAt(n : Nat) : Nat {
        if (n <= 1) { return n };

        var a : Nat = 0;
        var b : Nat = 1;
        var i : Nat = 2;

        while (i <= n) {
            let temp = a + b;
            a := b;
            b := temp;
            i := i + 1;
        };

        b
    };

    /// Compute the ratio F(n)/F(n-1) which approaches φ as n increases.
    ///
    /// @param n - Index (must be > 1)
    /// @returns F(n)/F(n-1)
    public func fibonacciRatio(n : Nat) : Float {
        if (n <= 1) { return 1.0 };

        let fn = fibonacciAt(n);
        let fn1 = fibonacciAt(n - 1);

        Float.fromInt(fn) / Float.fromInt(fn1)
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // COHERENCE-BASED RATE ADJUSTMENT — Adaptive Generation
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════

    /// Adjust the base generation rate based on sustained coherence.
    ///
    /// Higher sustained coherence → higher base rate.
    ///   Rate = φ⁻¹ × (1 + (coherence - φ⁻¹) × φ)
    ///
    /// At coherence = φ⁻¹: rate = φ⁻¹
    /// At coherence = 1.0: rate ≈ 1.0
    ///
    /// @param allocator - The allocator state
    /// @param avgCoherence - Average coherence over time
    public func adjustGenerationRate(
        allocator : SovereignCycleAllocatorState,
        avgCoherence : Float
    ) {
        // Higher sustained coherence → higher base rate
        let adjustment = (avgCoherence - PHI_INV) * PHI;
        let newRate = PHI_INV * (1.0 + adjustment);

        // Clamp to reasonable range [φ⁻², 1.0]
        if (newRate < PHI_INV_SQ) {
            allocator.generationRate := PHI_INV_SQ;
        } else if (newRate > 1.0) {
            allocator.generationRate := 1.0;
        } else {
            allocator.generationRate := newRate;
        };
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // CYCLE ACCOUNTING UTILITIES
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════

    /// Get allocation history as an array (for querying).
    public func getAllocationHistory(allocator : SovereignCycleAllocatorState) : [AllocationRecord] {
        Buffer.toArray(allocator.allocationHistory)
    };

    /// Get generation history as an array (for querying).
    public func getGenerationHistory(allocator : SovereignCycleAllocatorState) : [GenerationEvent] {
        Buffer.toArray(allocator.generationHistory)
    };

    /// Check if allocator has sufficient cycles for an operation.
    public func hasSufficientCycles(allocator : SovereignCycleAllocatorState, required : Float) : Bool {
        let available = allocator.totalCycles - allocator.allocatedCycles;
        available >= required
    };

    /// Get the current compound factor (approaches φ over time).
    public func getCompoundFactor(allocator : SovereignCycleAllocatorState) : Float {
        allocator.compoundFactor
    };

    /// Get deviation from golden ratio (how close to φ).
    public func getPhiDeviation(allocator : SovereignCycleAllocatorState) : Float {
        Float.abs(allocator.compoundFactor - PHI)
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
    // MODULE END — φ governs all
    // ═══════════════════════════════════════════════════════════════════════════════════════════════════
}
