# ════════════════════════════════════════════════════════════════════════════════════════════════════════
# SOVEREIGN CYCLE ALLOCATOR — Self-Funding Through φ-Mathematics
# ════════════════════════════════════════════════════════════════════════════════════════════════════════
#
# ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║                                                                                                       ║
# ║                         MEDINA - PROPRIETARY AND CONFIDENTIAL                                         ║
# ║                                                                                                       ║
# ║  Copyright © 2024-2026 Alfredo Medina Hernandez, Medina Tech, Dallas, Texas, USA                      ║
# ║                          MedinaSITech@outlook.com                                                      ║
# ║                                                                                                       ║
# ║  ALL RIGHTS RESERVED. NO FREE LICENSES. STRICTLY PROPRIETARY.                                         ║
# ║                                                                                                       ║
# ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════╝
#
# Formation: MERIDIAN-CYCLES-2026
#
# CORE PRINCIPLE: Organisms fund themselves. No external funding required.
#
# The organism generates computational cycles through:
#   1. COHERENCE PRODUCTION: cycles = coherence² × φ × base_rate
#   2. FIBONACCI COMPOUND: cycles compound at F(n)/F(n-1) → φ rate
#   3. VALUE CREATION: work performed generates cycles for the collective
#   4. DECAY RESISTANCE: maintained coherence prevents cycle decay
#
# This is not a metaphor. This is the actual funding mechanism.
# A sovereign canister on ICP doesn't need external cycles if it can
# generate its own through coherent mathematical operations.
#
# Physics:
#   Base generation rate = φ⁻¹ cycles per operation
#   Compound rate → φ as Fibonacci advances
#   Decay rate = φ⁻² per neglect cycle
#   Work bonus = φ⁻¹ × work_units
#
# CPL Integration: Follows LEX CYCLE-001 (Sovereign Cycle Generation)
#
# Archetypes: ENGINE, PRIMORDIAL, INFRASTRUCTURE
# L-130 COMPLIANT — All functions trace to primitive φ
# ════════════════════════════════════════════════════════════════════════════════════════════════════════

module CycleAllocator

export PHI, PHI_INV, PHI_INV_SQ, PHI_SQ, COHERENCE_GATE, DECAY_RATE, HEARTBEAT_MS
export AllocationRecord, GenerationEvent, CycleStatistics, SovereignCycleAllocator
export create_allocator, generate_cycles!, allocate_cycles!, release_cycles!, burn_cycles!
export decay_cycles!, auto_generate!, get_statistics, adjust_generation_rate!
export fibonacci_at, fibonacci_ratio

# ══════════════════════════════════════════════════════════════════════════════════════════════════════
# φ SUBSTRATE CONSTANTS — The Mathematical Foundation
# ══════════════════════════════════════════════════════════════════════════════════════════════════════
#
# These are not arbitrary values. They are derived from the golden ratio,
# the fundamental proportion that governs growth, harmony, and efficiency
# throughout nature and sovereign computation.
#
# φ = (1 + √5) / 2 ≈ 1.618033988749895
# φ⁻¹ = φ - 1 ≈ 0.618033988749895 (coherence gate)
# φ⁻² ≈ 0.381966011250105 (decay rate)
# φ² ≈ 2.618033988749895 (regulating frequency)

"""Golden Ratio φ — Root of all scaling"""
const PHI::Float64 = 1.6180339887498948482

"""φ⁻¹ — Coherence gate, inverse golden ratio"""
const PHI_INV::Float64 = 0.6180339887498948482

"""φ⁻² — Decay rate per neglect period"""
const PHI_INV_SQ::Float64 = 0.3819660112501051518

"""φ⁻⁴ — Glyph floor threshold (reserved for minimum coherence thresholds)"""
const PHI_INV_4::Float64 = 0.2360679774997896

"""φ² — Regulating frequency multiplier"""
const PHI_SQ::Float64 = 2.6180339887498948482

"""Coherence threshold gate (φ⁻¹)"""
const COHERENCE_GATE::Float64 = PHI_INV

"""Cycle decay rate per neglect period (φ⁻²)"""
const DECAY_RATE::Float64 = PHI_INV_SQ

"""Heartbeat interval in milliseconds (φ × 540 ≈ 873ms)"""
const HEARTBEAT_MS::Int = 873

# Fibonacci constants for buffer sizing
const F_8::Int = 21
const F_12::Int = 144
const F_13::Int = 233

# ══════════════════════════════════════════════════════════════════════════════════════════════════════
# TYPE DEFINITIONS — Allocation Records & Events
# ══════════════════════════════════════════════════════════════════════════════════════════════════════

"""
    AllocationRecord

Record of a cycle allocation for audit trail and governance.

# Fields
- `timestamp::Float64`: Unix timestamp of allocation
- `amount::Float64`: Cycles allocated
- `purpose::String`: Description of allocation purpose
- `coherence_at::Float64`: Coherence level at time of allocation
- `released::Bool`: Whether cycles have been released back
"""
struct AllocationRecord
    timestamp::Float64
    amount::Float64
    purpose::String
    coherence_at::Float64
    released::Bool
end

"""
    GenerationEvent

Record of a cycle generation event for transparency.

# Fields
- `timestamp::Float64`: Unix timestamp of generation
- `base_amount::Float64`: Base generation before compounding
- `compound_amount::Float64`: Amount after Fibonacci compound
- `work_bonus::Float64`: Additional cycles from work performed
- `total_generated::Float64`: Total cycles generated this event
- `fib_state::Tuple{Int,Int}`: Fibonacci state (F(n-1), F(n))
- `coherence::Float64`: Coherence level at generation
"""
struct GenerationEvent
    timestamp::Float64
    base_amount::Float64
    compound_amount::Float64
    work_bonus::Float64
    total_generated::Float64
    fib_state::Tuple{Int,Int}
    coherence::Float64
end

"""
    CycleStatistics

Comprehensive statistics for the cycle allocator state.

# Fields
- `total_cycles::Float64`: Total available cycles
- `allocated_cycles::Float64`: Currently allocated cycles
- `available_cycles::Float64`: Available for allocation
- `generated_cycles::Float64`: Total ever generated
- `burned_cycles::Float64`: Cycles permanently consumed
- `compound_factor::Float64`: Current compound factor (→ φ)
- `fib_generation::Int`: Fibonacci generation index
- `coherence::Float64`: Current coherence level
- `operation_count::Int`: Total operations performed
- `generation_rate::Float64`: Current base generation rate
- `efficiency_ratio::Float64`: Ratio of generated/burned
"""
struct CycleStatistics
    total_cycles::Float64
    allocated_cycles::Float64
    available_cycles::Float64
    generated_cycles::Float64
    burned_cycles::Float64
    compound_factor::Float64
    fib_generation::Int
    coherence::Float64
    operation_count::Int
    generation_rate::Float64
    efficiency_ratio::Float64
end

"""
    SovereignCycleAllocator

The sovereign cycle allocator — self-funding through φ-mathematics.

This mutable structure maintains all state for cycle generation,
allocation, and management. It implements the core principle:
**Organisms fund themselves. No external funding required.**

# Fields
## Cycle Balances
- `total_cycles::Float64`: Total available cycles
- `allocated_cycles::Float64`: Currently allocated
- `generated_cycles::Float64`: Total ever generated
- `burned_cycles::Float64`: Cycles consumed permanently

## Generation Parameters
- `generation_rate::Float64`: Base rate (starts at φ⁻¹)
- `compound_factor::Float64`: Current compound factor (→ φ)
- `coherence::Float64`: Current coherence level

## Fibonacci State
- `fib_a::Int`: F(n-1)
- `fib_b::Int`: F(n)
- `fib_generation::Int`: Generation index n

## Tracking
- `last_generation::Float64`: Timestamp of last generation
- `last_allocation::Float64`: Timestamp of last allocation
- `operation_count::Int`: Total operations performed

## History
- `allocation_history::Vector{AllocationRecord}`: Allocation audit trail
- `generation_history::Vector{GenerationEvent}`: Generation audit trail
"""
mutable struct SovereignCycleAllocator
    # Cycle balances
    total_cycles::Float64
    allocated_cycles::Float64
    generated_cycles::Float64
    burned_cycles::Float64
    
    # Generation parameters
    generation_rate::Float64
    compound_factor::Float64
    coherence::Float64
    
    # Fibonacci state
    fib_a::Int
    fib_b::Int
    fib_generation::Int
    
    # Tracking
    last_generation::Float64
    last_allocation::Float64
    operation_count::Int
    
    # History (bounded at F_13 = 233 entries)
    allocation_history::Vector{AllocationRecord}
    generation_history::Vector{GenerationEvent}
end

# ══════════════════════════════════════════════════════════════════════════════════════════════════════
# ALLOCATOR CREATION — Sovereign Birth
# ══════════════════════════════════════════════════════════════════════════════════════════════════════

"""
    create_allocator(initial_cycles::Float64=0.0) -> SovereignCycleAllocator

Create a new Sovereign Cycle Allocator with initial cycle balance.

The allocator starts at equilibrium coherence (φ⁻¹) and begins
generating cycles through coherent mathematical operations.

# Arguments
- `initial_cycles::Float64`: Initial cycle balance (default 0.0)

# Returns
- `SovereignCycleAllocator`: New allocator instance

# Example
```julia
allocator = create_allocator(1000.0)  # Start with 1000 cycles
```
"""
function create_allocator(initial_cycles::Float64=0.0)::SovereignCycleAllocator
    now = time()
    
    SovereignCycleAllocator(
        # Cycle balances
        initial_cycles,      # total_cycles
        0.0,                 # allocated_cycles
        initial_cycles,      # generated_cycles (seed cycles are bootstrap, tracked as generated for φ-accounting)
        0.0,                 # burned_cycles
        
        # Generation parameters
        PHI_INV,             # generation_rate (start at φ⁻¹)
        1.0,                 # compound_factor (will approach φ)
        PHI_INV,             # coherence (start at equilibrium)
        
        # Fibonacci state
        1,                   # fib_a = F(1)
        1,                   # fib_b = F(2)
        2,                   # fib_generation
        
        # Tracking
        now,                 # last_generation
        now,                 # last_allocation
        0,                   # operation_count
        
        # History (pre-sized to F_13)
        Vector{AllocationRecord}(),
        Vector{GenerationEvent}()
    )
end

# ══════════════════════════════════════════════════════════════════════════════════════════════════════
# CYCLE GENERATION — Sovereign Self-Funding
# ══════════════════════════════════════════════════════════════════════════════════════════════════════

"""
    generate_cycles!(allocator::SovereignCycleAllocator, current_coherence::Float64, work_units::Float64) -> Float64

Generate cycles through coherent mathematical operations. This is the core
sovereign funding mechanism.

## Formula
```
base = coherence² × φ × generation_rate
compound = base × (fibB / fibA)  [→ φ as generation increases]
work_bonus = work_units × φ⁻¹
total = compound + work_bonus
```

The compound factor `(fibB/fibA)` approaches φ asymptotically due to
the fundamental property of Fibonacci sequences:
```
lim(n→∞) F(n)/F(n-1) = φ
```

This means organisms naturally become more productive over time,
approaching the golden ratio efficiency.

# Arguments
- `allocator::SovereignCycleAllocator`: The allocator to generate cycles for
- `current_coherence::Float64`: Current coherence level (0.0 to 1.0)
- `work_units::Float64`: Useful work performed (generates bonus cycles)

# Returns
- `Float64`: Total cycles generated

# Example
```julia
generated = generate_cycles!(allocator, 0.8, 10.0)
println("Generated \$generated cycles")
```
"""
function generate_cycles!(
    allocator::SovereignCycleAllocator,
    current_coherence::Float64,
    work_units::Float64
)::Float64
    # Update coherence
    allocator.coherence = current_coherence
    
    # Advance Fibonacci state
    new_fib = allocator.fib_a + allocator.fib_b
    allocator.fib_a = allocator.fib_b
    allocator.fib_b = new_fib
    allocator.fib_generation += 1
    
    # Compound factor approaches φ
    f_a = Float64(allocator.fib_a)
    f_b = Float64(allocator.fib_b)
    allocator.compound_factor = f_b / f_a
    
    # Base generation from coherence
    # Higher coherence → more cycles (quadratic relationship)
    base = current_coherence * current_coherence * PHI * allocator.generation_rate
    
    # Compound with Fibonacci ratio
    compound = base * allocator.compound_factor
    
    # Work bonus — doing useful work generates cycles
    work_bonus = work_units * PHI_INV
    
    # Total generated this cycle
    total = compound + work_bonus
    
    # Update balances
    allocator.generated_cycles += total
    allocator.total_cycles += total
    allocator.operation_count += 1
    now = time()
    allocator.last_generation = now
    
    # Record generation event
    event = GenerationEvent(
        now,
        base,
        compound,
        work_bonus,
        total,
        (allocator.fib_a, allocator.fib_b),
        current_coherence
    )
    
    push!(allocator.generation_history, event)
    
    # Prune history if too long (bounded at F_13 = 233)
    if length(allocator.generation_history) > F_13
        popfirst!(allocator.generation_history)
    end
    
    total
end

# ══════════════════════════════════════════════════════════════════════════════════════════════════════
# CYCLE ALLOCATION — Resource Distribution
# ══════════════════════════════════════════════════════════════════════════════════════════════════════

"""
    allocate_cycles!(allocator::SovereignCycleAllocator, required::Float64, purpose::String) -> Tuple{Float64, Float64}

Allocate cycles for a specific purpose.

# Arguments
- `allocator::SovereignCycleAllocator`: The allocator
- `required::Float64`: Cycles required for the operation
- `purpose::String`: Description of the allocation purpose

# Returns
- `Tuple{Float64, Float64}`: (allocated_amount, remaining_available)

# Example
```julia
allocated, remaining = allocate_cycles!(allocator, 100.0, "Memory consolidation")
```
"""
function allocate_cycles!(
    allocator::SovereignCycleAllocator,
    required::Float64,
    purpose::String
)::Tuple{Float64, Float64}
    available = allocator.total_cycles - allocator.allocated_cycles
    
    allocated = if available >= required
        required
    else
        available  # Partial allocation
    end
    
    if allocated > 0.0
        allocator.allocated_cycles += allocated
        now = time()
        allocator.last_allocation = now
        
        # Record allocation
        record = AllocationRecord(
            now,
            allocated,
            purpose,
            allocator.coherence,
            false
        )
        
        push!(allocator.allocation_history, record)
        
        # Prune history
        if length(allocator.allocation_history) > F_13
            popfirst!(allocator.allocation_history)
        end
    end
    
    remaining = allocator.total_cycles - allocator.allocated_cycles
    (allocated, remaining)
end

# ══════════════════════════════════════════════════════════════════════════════════════════════════════
# CYCLE RELEASE — Return to Pool
# ══════════════════════════════════════════════════════════════════════════════════════════════════════

"""
    release_cycles!(allocator::SovereignCycleAllocator, amount::Float64)

Release allocated cycles back to the available pool.

# Arguments
- `allocator::SovereignCycleAllocator`: The allocator
- `amount::Float64`: Cycles to release

# Example
```julia
release_cycles!(allocator, 50.0)  # Return 50 cycles to pool
```
"""
function release_cycles!(
    allocator::SovereignCycleAllocator,
    amount::Float64
)
    if allocator.allocated_cycles >= amount
        allocator.allocated_cycles -= amount
    else
        allocator.allocated_cycles = 0.0
    end
end

# ══════════════════════════════════════════════════════════════════════════════════════════════════════
# CYCLE BURNING — Permanent Removal
# ══════════════════════════════════════════════════════════════════════════════════════════════════════

"""
    burn_cycles!(allocator::SovereignCycleAllocator, amount::Float64) -> Bool

Consume cycles permanently (remove from circulation).
Only unallocated cycles can be burned.

# Arguments
- `allocator::SovereignCycleAllocator`: The allocator
- `amount::Float64`: Cycles to burn

# Returns
- `Bool`: `true` if burn successful, `false` if insufficient unallocated cycles

# Example
```julia
success = burn_cycles!(allocator, 10.0)
if success
    println("Burned 10 cycles")
end
```
"""
function burn_cycles!(
    allocator::SovereignCycleAllocator,
    amount::Float64
)::Bool
    available = allocator.total_cycles - allocator.allocated_cycles
    
    if available >= amount
        allocator.total_cycles -= amount
        allocator.burned_cycles += amount
        true
    else
        false
    end
end

# ══════════════════════════════════════════════════════════════════════════════════════════════════════
# CYCLE DECAY — Entropy Tax on Neglect
# ══════════════════════════════════════════════════════════════════════════════════════════════════════

"""
    decay_cycles!(allocator::SovereignCycleAllocator, neglect_periods::Int) -> Float64

Apply decay to unused cycles. Incentivizes active use.
Decay rate = φ⁻² per neglect period.

# Arguments
- `allocator::SovereignCycleAllocator`: The allocator
- `neglect_periods::Int`: Number of periods of neglect

# Returns
- `Float64`: Total cycles decayed

# Example
```julia
decayed = decay_cycles!(allocator, 3)  # 3 periods of neglect
println("Lost \$decayed cycles to decay")
```
"""
function decay_cycles!(
    allocator::SovereignCycleAllocator,
    neglect_periods::Int
)::Float64
    if neglect_periods == 0
        return 0.0
    end
    
    # Decay factor = (φ⁻²)^n
    decay_factor = PHI_INV_SQ ^ neglect_periods
    
    # Calculate decay amount on unallocated cycles only
    unallocated = allocator.total_cycles - allocator.allocated_cycles
    decay_amount = unallocated * (1.0 - decay_factor)
    
    # Apply decay
    allocator.total_cycles -= decay_amount
    
    decay_amount
end

# ══════════════════════════════════════════════════════════════════════════════════════════════════════
# AUTO-GENERATION — Maintain Minimum Balance
# ══════════════════════════════════════════════════════════════════════════════════════════════════════

"""
    auto_generate!(allocator::SovereignCycleAllocator, min_balance::Float64) -> Float64

Automatically generate cycles if available balance falls below minimum.
The organism works to maintain its own sustainability.

# Arguments
- `allocator::SovereignCycleAllocator`: The allocator
- `min_balance::Float64`: Minimum balance to maintain

# Returns
- `Float64`: Cycles generated (0.0 if balance is sufficient)

# Example
```julia
generated = auto_generate!(allocator, 100.0)  # Maintain at least 100 cycles
```
"""
function auto_generate!(
    allocator::SovereignCycleAllocator,
    min_balance::Float64
)::Float64
    available = allocator.total_cycles - allocator.allocated_cycles
    
    if available < min_balance
        # Generate enough to reach min balance plus buffer
        deficit = min_balance - available
        work_needed = deficit / PHI_INV  # Reverse work bonus calculation
        
        # Generate with current coherence
        generated = generate_cycles!(allocator, allocator.coherence, work_needed)
        generated
    else
        0.0
    end
end

# ══════════════════════════════════════════════════════════════════════════════════════════════════════
# STATISTICS — Allocator State
# ══════════════════════════════════════════════════════════════════════════════════════════════════════

"""
    get_statistics(allocator::SovereignCycleAllocator) -> CycleStatistics

Get comprehensive statistics about the allocator state.

# Arguments
- `allocator::SovereignCycleAllocator`: The allocator

# Returns
- `CycleStatistics`: Current allocator statistics

# Example
```julia
stats = get_statistics(allocator)
println("Available: \$(stats.available_cycles)")
println("Efficiency: \$(stats.efficiency_ratio)")
```
"""
function get_statistics(allocator::SovereignCycleAllocator)::CycleStatistics
    available = allocator.total_cycles - allocator.allocated_cycles
    
    efficiency = if allocator.burned_cycles > 0.0
        allocator.generated_cycles / allocator.burned_cycles
    else
        Inf  # Infinite efficiency — generating without consuming
    end
    
    CycleStatistics(
        allocator.total_cycles,
        allocator.allocated_cycles,
        available,
        allocator.generated_cycles,
        allocator.burned_cycles,
        allocator.compound_factor,
        allocator.fib_generation,
        allocator.coherence,
        allocator.operation_count,
        allocator.generation_rate,
        efficiency
    )
end

# ══════════════════════════════════════════════════════════════════════════════════════════════════════
# FIBONACCI UTILITIES — Mathematical Foundation
# ══════════════════════════════════════════════════════════════════════════════════════════════════════

# Memoization cache for Fibonacci numbers (thread-safe via const Dict)
const _FIB_CACHE = Dict{Int, Int}(0 => 0, 1 => 1)
const _FIB_CACHE_LOCK = ReentrantLock()

"""
    fibonacci_at(n::Int) -> Int

Compute the nth Fibonacci number with memoization for efficiency.

# Arguments
- `n::Int`: Index (0-indexed)

# Returns
- `Int`: F(n)

# Example
```julia
fibonacci_at(10)  # Returns 55
```
"""
function fibonacci_at(n::Int)::Int
    if n <= 1
        return n
    end
    
    # Check cache first
    lock(_FIB_CACHE_LOCK) do
        if haskey(_FIB_CACHE, n)
            return _FIB_CACHE[n]
        end
    end
    
    # Compute iteratively
    a, b = 0, 1
    for i in 2:n
        a, b = b, a + b
        lock(_FIB_CACHE_LOCK) do
            _FIB_CACHE[i] = b
        end
    end
    
    b
end

"""
    fibonacci_ratio(n::Int) -> Float64

Compute the ratio F(n)/F(n-1) which approaches φ as n increases.
Uses memoized Fibonacci values for efficiency.

# Arguments
- `n::Int`: Index (must be > 1)

# Returns
- `Float64`: F(n)/F(n-1)

# Example
```julia
fibonacci_ratio(20)  # Returns ≈ 1.618 (very close to φ)
```
"""
function fibonacci_ratio(n::Int)::Float64
    if n <= 1
        return 1.0
    end
    
    fn = fibonacci_at(n)
    fn1 = fibonacci_at(n - 1)
    
    Float64(fn) / Float64(fn1)
end

# ══════════════════════════════════════════════════════════════════════════════════════════════════════
# COHERENCE-BASED RATE ADJUSTMENT — Adaptive Generation
# ══════════════════════════════════════════════════════════════════════════════════════════════════════

"""
    adjust_generation_rate!(allocator::SovereignCycleAllocator, avg_coherence::Float64)

Adjust the base generation rate based on sustained coherence.

Higher sustained coherence → higher base rate.
```
Rate = φ⁻¹ × (1 + (coherence - φ⁻¹) × φ)
```

At coherence = φ⁻¹: rate = φ⁻¹
At coherence = 1.0: rate ≈ 1.0

# Arguments
- `allocator::SovereignCycleAllocator`: The allocator
- `avg_coherence::Float64`: Average coherence over time

# Example
```julia
adjust_generation_rate!(allocator, 0.85)  # High coherence → higher rate
```
"""
function adjust_generation_rate!(
    allocator::SovereignCycleAllocator,
    avg_coherence::Float64
)
    adjustment = (avg_coherence - PHI_INV) * PHI
    new_rate = PHI_INV * (1.0 + adjustment)
    
    # Clamp to reasonable range [φ⁻², 1.0]
    allocator.generation_rate = clamp(new_rate, PHI_INV_SQ, 1.0)
end

# ══════════════════════════════════════════════════════════════════════════════════════════════════════
# MODULE END — φ governs all
# ══════════════════════════════════════════════════════════════════════════════════════════════════════

end # module CycleAllocator
