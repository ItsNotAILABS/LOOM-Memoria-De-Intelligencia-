/**
 * MatalkoICP Module — φ, harmonics, RECITAL_PLUS_ONE, animaHash
 * 
 * Core mathematical substrate encoding the golden ratio, harmonic frequencies,
 * and the fundamental state evolution law. This module provides the mathematical
 * foundation that bridges ancient wisdom to executable canister intelligence.
 * 
 * MATHEMATICAL CONSTANTS:
 *   φ (PHI) = (1 + √5) / 2 ≈ 1.618033988749895 — Golden ratio
 *   π (PI) = 3.141592653589793
 *   τ (TAU) = 2π ≈ 6.283185307179586
 *   e (E) = 2.718281828459045 — Euler's number
 *   √2 (SQRT2) = 1.4142135623730951
 *   √3 (SQRT3) = 1.7320508075688772
 * 
 * HARMONIC FREQUENCIES (Hz):
 *   SCHUMANN = 7.83 — Earth's fundamental resonance
 *   BASE_432 = 432.0 — Pythagorean tuning base
 *   SOLFEGGIO = [396, 417, 528, 639, 741, 852] — Ancient healing frequencies
 * 
 * RECITAL_PLUS_ONE LAW:
 *   state(n+1) = recital(Ψ_n) ⊕ Δ_lawful
 *   Where Δ_lawful iff ‖Δ‖ ≤ ε_max AND gate_A(Δ) passes
 * 
 * ANIMA HASH:
 *   A unique resonance signature derived from organism state vector,
 *   combining golden ratio scaling with beat-phase encoding.
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Time "mo:base/Time";

module {
    // ================================================================== //
    // MATHEMATICAL CONSTANTS                                               //
    // ================================================================== //
    
    /// Golden ratio φ = (1 + √5) / 2
    public let PHI : Float = 1.618033988749895;
    
    /// Inverse golden ratio 1/φ
    public let PHI_INV : Float = 0.618033988749895;
    
    /// Golden angle in radians (2π / φ²)
    public let GOLDEN_ANGLE : Float = 2.399963229728653;
    
    /// Pi constant
    public let PI : Float = 3.141592653589793;
    
    /// Tau (2π)
    public let TAU : Float = 6.283185307179586;
    
    /// Euler's number
    public let E : Float = 2.718281828459045;
    
    /// Square root of 2
    public let SQRT2 : Float = 1.4142135623730951;
    
    /// Square root of 3
    public let SQRT3 : Float = 1.7320508075688772;
    
    /// Square root of 5
    public let SQRT5 : Float = 2.23606797749979;
    
    // ================================================================== //
    // HARMONIC FREQUENCIES                                                 //
    // ================================================================== //
    
    /// Schumann resonance — Earth's fundamental frequency
    public let SCHUMANN : Float = 7.83;
    
    /// Pythagorean tuning base frequency
    public let BASE_432 : Float = 432.0;
    
    /// Standard concert pitch
    public let A440 : Float = 440.0;
    
    /// Solfeggio frequencies (ancient healing tones)
    public let SOLFEGGIO : [Float] = [396.0, 417.0, 528.0, 639.0, 741.0, 852.0];
    
    /// Solfeggio with extended scale
    public let SOLFEGGIO_EXTENDED : [Float] = [
        174.0, 285.0, 396.0, 417.0, 528.0, 639.0, 741.0, 852.0, 963.0
    ];
    
    /// Chakra frequencies
    public let CHAKRA_FREQUENCIES : [Float] = [
        256.0,   // Root (C)
        288.0,   // Sacral (D)
        320.0,   // Solar Plexus (E)
        341.3,   // Heart (F)
        384.0,   // Throat (G)
        426.7,   // Third Eye (A)
        480.0    // Crown (B)
    ];
    
    // ================================================================== //
    // RECITAL_PLUS_ONE LAW                                                 //
    // ================================================================== //
    
    /// Maximum single-beat expansion magnitude
    public let EPSILON_MAX : Float = 1.0;
    
    /// Phase scale factor for torus geometry
    public let PHASE_SCALE_FACTOR : Float = 10.0;
    
    /// Major torus radius (PHI-scaled)
    public let TORUS_R : Float = 16.18033988749895; // PHI * PHASE_SCALE_FACTOR
    
    /// Constitution matrix coefficient (PHI identity scaling)
    public let CONSTITUTION_SCALE : Float = 1.618033988749895;
    
    /// 4-dimensional organism state vector
    public type OrganismState = {
        beat: Nat;
        doctrine_coherence: Float;    // ψ₀ ∈ [0,1]
        execution_velocity: Float;    // ψ₁ ∈ [0,∞)
        memory_depth: Float;          // ψ₂ ∈ [0,∞)
        projection_exposure: Float;   // ψ₃ ∈ [0,1]
        theta: Float;                 // helix angle θ ∈ [0, 2π)
        phi: Float;                   // toroidal rotation φ ∈ [0, 2π)
        depth: Float;                 // radial depth ρ
        ring: Nat;                    // memory ring index
        state_id: Text;
        parent_id: ?Text;
        timestamp: Int;
        expansion_label: Text;
    };
    
    /// State expansion delta
    public type StateDelta = {
        doctrine_delta: Float;
        velocity_delta: Float;
        memory_delta: Float;
        exposure_delta: Float;
    };
    
    /// Harmonic state for frequency-based operations
    public type HarmonicState = {
        fundamental: Float;
        harmonics: [Float];
        phase: Float;
        amplitude: Float;
        resonance_score: Float;
    };
    
    /// Initialize a new organism state
    public func initState() : OrganismState {
        {
            beat = 0;
            doctrine_coherence = 1.0;
            execution_velocity = 0.0;
            memory_depth = 0.0;
            projection_exposure = 0.0;
            theta = 0.0;
            phi = 0.0;
            depth = 1.0;
            ring = 0;
            state_id = "";
            parent_id = null;
            timestamp = Time.now();
            expansion_label = "genesis";
        }
    };
    
    /// Calculate state vector magnitude ‖Ψ‖
    public func stateMagnitude(state: OrganismState) : Float {
        Float.sqrt(
            state.doctrine_coherence ** 2.0 +
            state.execution_velocity ** 2.0 +
            state.memory_depth ** 2.0 +
            state.projection_exposure ** 2.0
        )
    };
    
    /// Calculate delta magnitude ‖Δ‖
    public func deltaMagnitude(delta: StateDelta) : Float {
        Float.sqrt(
            delta.doctrine_delta ** 2.0 +
            delta.velocity_delta ** 2.0 +
            delta.memory_delta ** 2.0 +
            delta.exposure_delta ** 2.0
        )
    };
    
    /// Validate expansion delta (‖Δ‖ ≤ ε_max)
    public func validateDelta(delta: StateDelta) : Bool {
        deltaMagnitude(delta) <= EPSILON_MAX
    };
    
    /// Clamp value to range [min, max]
    func clamp(value: Float, min: Float, max: Float) : Float {
        if (value < min) { min }
        else if (value > max) { max }
        else { value }
    };
    
    /// Apply recital operator R to state
    public func recital(state: OrganismState) : OrganismState {
        // Clamp bounded dimensions
        let d = clamp(state.doctrine_coherence, 0.0, 1.0);
        let e = clamp(state.projection_exposure, 0.0, 1.0);
        
        // Advance torus phase by φ-scaled increment
        let deltaTheta = TAU / (PHI ** 2.0 * PHASE_SCALE_FACTOR);
        let deltaPhi = TAU / (PHI ** 3.0 * PHASE_SCALE_FACTOR);
        
        // Calculate modulo for torus coordinates
        let moduloTheta = state.theta + deltaTheta - Float.floor((state.theta + deltaTheta) / TAU) * TAU;
        let moduloPhi = state.phi + deltaPhi - Float.floor((state.phi + deltaPhi) / TAU) * TAU;
        
        // Ring advances every full toroidal cycle
        let newRing = if (moduloPhi < state.phi) { state.ring + 1 } else { state.ring };
        
        {
            beat = state.beat;
            doctrine_coherence = d;
            execution_velocity = state.execution_velocity;
            memory_depth = state.memory_depth;
            projection_exposure = e;
            theta = moduloTheta;
            phi = moduloPhi;
            depth = state.depth;
            ring = newRing;
            state_id = state.state_id;
            parent_id = state.parent_id;
            timestamp = state.timestamp;
            expansion_label = state.expansion_label;
        }
    };
    
    /// Apply RECITAL_PLUS_ONE: state(n+1) = recital(Ψ_n) ⊕ Δ_lawful
    public func recitalPlusOne(
        state: OrganismState, 
        delta: StateDelta, 
        newId: Text, 
        label: Text
    ) : ?OrganismState {
        // Validate expansion
        if (not validateDelta(delta)) {
            return null;
        };
        
        // Apply recital operator
        let recited = recital(state);
        
        // Apply expansion
        ?{
            beat = recited.beat + 1;
            doctrine_coherence = clamp(recited.doctrine_coherence + delta.doctrine_delta, 0.0, 1.0);
            execution_velocity = Float.max(0.0, recited.execution_velocity + delta.velocity_delta);
            memory_depth = Float.max(0.0, recited.memory_depth + delta.memory_delta);
            projection_exposure = clamp(recited.projection_exposure + delta.exposure_delta, 0.0, 1.0);
            theta = recited.theta;
            phi = recited.phi;
            depth = recited.depth;
            ring = recited.ring;
            state_id = newId;
            parent_id = ?recited.state_id;
            timestamp = Time.now();
            expansion_label = label;
        }
    };
    
    // ================================================================== //
    // ANIMA HASH                                                           //
    // ================================================================== //
    
    /// ANIMA hash result
    public type AnimaHash = {
        hash: Text;
        resonance_signature: Float;
        beat_phase: Float;
        golden_factor: Float;
    };
    
    /// Simple hash function for integers
    func hashInt(n: Int) : Nat32 {
        let abs = if (n < 0) { -n } else { n };
        var h : Nat32 = Nat32.fromNat(Int.abs(abs) % 2147483647);
        h := h ^ (h >> 16);
        h := h *% 0x85ebca6b;
        h := h ^ (h >> 13);
        h := h *% 0xc2b2ae35;
        h := h ^ (h >> 16);
        h
    };
    
    /// Mix two hash values
    func mixHash(a: Nat32, b: Nat32) : Nat32 {
        var h = a ^ b;
        h := h ^ (h >> 16);
        h := h *% 0x7feb352d;
        h := h ^ (h >> 15);
        h := h *% 0x846ca68b;
        h := h ^ (h >> 16);
        h
    };
    
    /// Convert Nat32 to hex string
    func toHex(n: Nat32) : Text {
        let hexChars = "0123456789abcdef";
        var result = "";
        var val = n;
        for (_ in [1, 2, 3, 4, 5, 6, 7, 8].vals()) {
            let digit = Nat32.toNat(val & 0xf);
            let charArray = Text.toArray(hexChars);
            result := Text.fromChar(charArray[digit]) # result;
            val := val >> 4;
        };
        result
    };
    
    /// Generate ANIMA hash from organism state
    public func animaHash(state: OrganismState) : AnimaHash {
        // Encode state vector components into hash
        let docHash = hashInt(Float.toInt(state.doctrine_coherence * 1000000.0));
        let velHash = hashInt(Float.toInt(state.execution_velocity * 1000000.0));
        let memHash = hashInt(Float.toInt(state.memory_depth * 1000000.0));
        let expHash = hashInt(Float.toInt(state.projection_exposure * 1000000.0));
        
        // Mix with torus coordinates
        let thetaHash = hashInt(Float.toInt(state.theta * 1000000.0));
        let phiHash = hashInt(Float.toInt(state.phi * 1000000.0));
        let beatHash = hashInt(state.beat);
        let ringHash = hashInt(state.ring);
        
        // Combine hashes
        var h1 = mixHash(docHash, velHash);
        var h2 = mixHash(memHash, expHash);
        var h3 = mixHash(thetaHash, phiHash);
        var h4 = mixHash(beatHash, ringHash);
        
        let final1 = mixHash(h1, h2);
        let final2 = mixHash(h3, h4);
        let finalHash = mixHash(final1, final2);
        
        // Calculate resonance signature (golden-ratio weighted)
        let resonance = (state.doctrine_coherence * PHI +
                        state.execution_velocity * PHI_INV +
                        state.memory_depth * (1.0 / PHI ** 2.0) +
                        state.projection_exposure * (1.0 / PHI ** 3.0)) / 4.0;
        
        // Beat phase in golden angle increments
        let beatPhaseFloat : Float = Float.fromInt(state.beat);
        let beatPhase = beatPhaseFloat * GOLDEN_ANGLE - 
                        Float.floor(beatPhaseFloat * GOLDEN_ANGLE / TAU) * TAU;
        
        // Golden factor based on depth and ring
        let goldenFactor = state.depth * PHI ** Float.fromInt(state.ring);
        
        {
            hash = "anima_" # toHex(finalHash);
            resonance_signature = resonance;
            beat_phase = beatPhase;
            golden_factor = goldenFactor;
        }
    };
    
    // ================================================================== //
    // HARMONIC FUNCTIONS                                                   //
    // ================================================================== //
    
    /// Calculate nth Fibonacci number
    public func fibonacci(n: Nat) : Nat {
        if (n <= 1) { return n };
        var a : Nat = 0;
        var b : Nat = 1;
        var i : Nat = 2;
        while (i <= n) {
            let c = a + b;
            a := b;
            b := c;
            i += 1;
        };
        b
    };
    
    /// Calculate Fibonacci ratio (approaches PHI as n increases)
    public func fibonacciRatio(n: Nat) : Float {
        if (n < 2) { return 1.0 };
        let fn = fibonacci(n);
        let fn1 = fibonacci(n - 1);
        if (fn1 == 0) { return 0.0 };
        Float.fromInt(fn) / Float.fromInt(fn1)
    };
    
    /// Generate harmonic series from fundamental
    public func harmonicSeries(fundamental: Float, count: Nat) : [Float] {
        if (count == 0) { return [] };
        let harmonics = Buffer.Buffer<Float>(count);
        var i : Nat = 1;
        while (i <= count) {
            harmonics.add(fundamental * Float.fromInt(i));
            i += 1;
        };
        Buffer.toArray(harmonics)
    };
    
    /// Generate golden ratio scaled harmonics
    public func goldenHarmonics(fundamental: Float, count: Nat) : [Float] {
        if (count == 0) { return [] };
        let harmonics = Buffer.Buffer<Float>(count);
        var freq = fundamental;
        var i : Nat = 0;
        while (i < count) {
            harmonics.add(freq);
            freq := freq * PHI;
            i += 1;
        };
        Buffer.toArray(harmonics)
    };
    
    /// Calculate resonance between two frequencies
    public func resonanceScore(freq1: Float, freq2: Float) : Float {
        let ratio = if (freq1 > freq2) { freq1 / freq2 } else { freq2 / freq1 };
        
        // Check against simple ratios (consonant intervals)
        let simpleRatios : [(Float, Float)] = [
            (1.0, 1.0),   // Unison
            (2.0, 1.0),   // Octave
            (3.0, 2.0),   // Perfect fifth
            (4.0, 3.0),   // Perfect fourth
            (5.0, 4.0),   // Major third
            (PHI, 1.0),   // Golden ratio
        ];
        
        var maxScore : Float = 0.0;
        for ((num, den) in simpleRatios.vals()) {
            let target = num / den;
            let diff = Float.abs(ratio - target);
            let score = 1.0 / (1.0 + diff * 10.0);
            if (score > maxScore) {
                maxScore := score;
            };
        };
        
        maxScore
    };
    
    /// Calculate Schumann-based harmonic alignment
    public func schumannAlignment(freq: Float) : Float {
        let ratio = freq / SCHUMANN;
        let harmonic = Float.nearest(ratio);
        let deviation = Float.abs(ratio - harmonic);
        1.0 / (1.0 + deviation)
    };
    
    /// Generate Solfeggio harmonic state
    public func solfeggioHarmonic(index: Nat, phase: Float, amplitude: Float) : HarmonicState {
        let fundamental = if (index < SOLFEGGIO.size()) { 
            SOLFEGGIO[index] 
        } else { 
            SOLFEGGIO[0] 
        };
        
        let harmonics = harmonicSeries(fundamental, 8);
        let resonance = schumannAlignment(fundamental);
        
        {
            fundamental = fundamental;
            harmonics = harmonics;
            phase = phase;
            amplitude = amplitude;
            resonance_score = resonance;
        }
    };
    
    // ================================================================== //
    // TORUS GEOMETRY                                                       //
    // ================================================================== //
    
    /// Calculate Cartesian coordinates on torus
    public func torusXYZ(theta: Float, phi: Float, depth: Float) : (Float, Float, Float) {
        let r = TORUS_R;
        let x = (r + depth * Float.cos(theta)) * Float.cos(phi);
        let y = (r + depth * Float.cos(theta)) * Float.sin(phi);
        let z = depth * Float.sin(theta);
        (x, y, z)
    };
    
    /// Calculate distance between two points on torus
    public func torusDistance(
        theta1: Float, phi1: Float, depth1: Float,
        theta2: Float, phi2: Float, depth2: Float
    ) : Float {
        let (x1, y1, z1) = torusXYZ(theta1, phi1, depth1);
        let (x2, y2, z2) = torusXYZ(theta2, phi2, depth2);
        Float.sqrt(
            (x2 - x1) ** 2.0 +
            (y2 - y1) ** 2.0 +
            (z2 - z1) ** 2.0
        )
    };
    
    /// Calculate angular distance on torus (geodesic approximation)
    public func torusAngularDistance(
        theta1: Float, phi1: Float,
        theta2: Float, phi2: Float
    ) : Float {
        let dTheta = theta2 - theta1;
        let dPhi = phi2 - phi1;
        Float.sqrt(dTheta ** 2.0 + dPhi ** 2.0)
    };
    
    // ================================================================== //
    // ITERATOR SUPPORT                                                     //
    // ================================================================== //
    
    // Import Iter module for iteration support
    private module Iter = {
        public func range(start: Nat, end: Nat) : { next : () -> ?Nat } {
            var i = start;
            {
                next = func() : ?Nat {
                    if (i <= end) {
                        let result = i;
                        i += 1;
                        ?result
                    } else {
                        null
                    }
                }
            }
        };
    };
}
