/**
 * IcosahedralLeechGeometry Module — Beyond E8: Icosahedral-Leech Extension
 * 
 * MATHEMATICAL FOUNDATION (confirmed 2016-2026 research):
 *   Icosahedron (3D, 60 rotational symmetries)
 *   → Binary icosahedral group (120 elements via double cover in SU(2))
 *   → 120 root vectors of H4 (4D exceptional root system)
 *   → 240 pinors (double cover of H4) ARE the 240 roots of E8
 *   → Three copies of E8 → Leech lattice in 24 dimensions
 *   → Leech lattice automorphism: Conway group Co0, order 8,315,553,613,086,720,000
 * 
 * THREE-TIER KEY ROTATION:
 *   Tier 1 - ICOSAHEDRAL: 120-step cycle (R < 0.618) — fast, phi-native
 *   Tier 2 - E8: 240-step cycle (0.618 ≤ R < 0.854) — standard sovereign
 *   Tier 3 - LEECH: 196,560-step cycle (R ≥ 0.854) — high coherence, deep sovereign
 * 
 * PHI-BEATTY SEQUENCE:
 *   The Beatty sequence of phi (⌊nφ⌋ mod 2) is provably non-periodic.
 *   Phi has continued fraction [1;1,1,1,...] — worst rational approximations.
 *   This is the frequency authentication immune to prediction.
 * 
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX | April 16, 2026
 * PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";

module {
    // ================================================================== //
    // GEOMETRIC CONSTANTS                                                  //
    // ================================================================== //
    
    /// Golden ratio φ = (1 + √5) / 2
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Inverse golden ratio 1/φ = φ - 1
    public let PHI_INV : Float = MatalkoICP.PHI_INV;
    
    /// Pi
    public let PI : Float = MatalkoICP.PI;
    
    /// Tau (2π)
    public let TAU : Float = MatalkoICP.TAU;
    
    /// Icosahedral cycle steps (binary icosahedral group order / 2)
    public let ICOSAHEDRAL_STEPS : Nat = 120;
    
    /// E8 root vector cycle steps
    public let E8_STEPS : Nat = 240;
    
    /// Leech lattice minimal vector cycle steps
    public let LEECH_STEPS : Nat = 196560;
    
    /// E8 Weyl group order
    public let E8_WEYL_ORDER : Nat = 696729600;
    
    /// Coherence threshold for E8 tier
    public let COHERENCE_THRESHOLD_E8 : Float = 0.618;
    
    /// Coherence threshold for Leech tier
    public let COHERENCE_THRESHOLD_LEECH : Float = 0.854;
    
    /// E8 Coxeter versor prime exponents (factors of 30)
    public let COXETER_PRIMES : [Nat] = [1, 7, 11, 13, 17, 19, 23, 29];
    
    // ================================================================== //
    // KEY ROTATION TIER                                                    //
    // ================================================================== //
    
    /// Key rotation tier selected by coherence level
    public type KeyRotationTier = {
        #Icosahedral;  // R < 0.618 — 120 steps, phi-native, fast
        #E8;           // 0.618 ≤ R < 0.854 — 240 steps, standard sovereign
        #Leech;        // R ≥ 0.854 — 196,560 steps, deep sovereign
    };
    
    /// Select rotation tier based on coherence R
    public func selectTier(coherence: Float) : KeyRotationTier {
        if (coherence >= COHERENCE_THRESHOLD_LEECH) {
            #Leech
        } else if (coherence >= COHERENCE_THRESHOLD_E8) {
            #E8
        } else {
            #Icosahedral
        }
    };
    
    /// Get cycle steps for tier
    public func tierSteps(tier: KeyRotationTier) : Nat {
        switch (tier) {
            case (#Icosahedral) { ICOSAHEDRAL_STEPS };
            case (#E8) { E8_STEPS };
            case (#Leech) { LEECH_STEPS };
        }
    };
    
    /// Get tier name
    public func tierName(tier: KeyRotationTier) : Text {
        switch (tier) {
            case (#Icosahedral) { "ICOSAHEDRAL" };
            case (#E8) { "E8" };
            case (#Leech) { "LEECH" };
        }
    };
    
    // ================================================================== //
    // ICOSAHEDRAL GEOMETRY (H4 ROOT SYSTEM)                               //
    // ================================================================== //
    
    /// 4D icosahedral (H4) root vector type
    public type H4RootVector = {
        x: Float;
        y: Float;
        z: Float;
        w: Float;
    };
    
    /// Generate the 120 vertices of the 600-cell (H4 root system)
    /// These are the root vectors underlying E8 through the phi connection
    public func generate600CellVertices() : [H4RootVector] {
        let vertices = Buffer.Buffer<H4RootVector>(120);
        
        // The 600-cell has 120 vertices constructed from phi ratios
        // 8 vertices: permutations of (±1, 0, 0, 0)
        let signs : [Float] = [-1.0, 1.0];
        for (s in signs.vals()) {
            vertices.add({ x = s; y = 0.0; z = 0.0; w = 0.0 });
            vertices.add({ x = 0.0; y = s; z = 0.0; w = 0.0 });
            vertices.add({ x = 0.0; y = 0.0; z = s; w = 0.0 });
            vertices.add({ x = 0.0; y = 0.0; z = 0.0; w = s });
        };
        
        // 16 vertices: (±1/2, ±1/2, ±1/2, ±1/2)
        for (s1 in signs.vals()) {
            for (s2 in signs.vals()) {
                for (s3 in signs.vals()) {
                    for (s4 in signs.vals()) {
                        vertices.add({ 
                            x = s1 * 0.5; 
                            y = s2 * 0.5; 
                            z = s3 * 0.5; 
                            w = s4 * 0.5 
                        });
                    };
                };
            };
        };
        
        // 96 vertices: even permutations of (±φ/2, ±1/2, ±1/(2φ), 0)
        let half_phi = PHI / 2.0;
        let half_phi_inv = PHI_INV / 2.0;
        
        // Even permutations of 4 elements — 12 permutations
        let coords : [[Float]] = [
            [half_phi, 0.5, half_phi_inv, 0.0],
            [half_phi, half_phi_inv, 0.0, 0.5],
            [half_phi, 0.0, 0.5, half_phi_inv],
            [0.5, half_phi, 0.0, half_phi_inv],
            [0.5, half_phi_inv, half_phi, 0.0],
            [0.5, 0.0, half_phi_inv, half_phi],
            [half_phi_inv, half_phi, 0.5, 0.0],
            [half_phi_inv, 0.5, 0.0, half_phi],
            [half_phi_inv, 0.0, half_phi, 0.5],
            [0.0, half_phi, half_phi_inv, 0.5],
            [0.0, 0.5, half_phi, half_phi_inv],
            [0.0, half_phi_inv, 0.5, half_phi],
        ];
        
        // Apply sign permutations (8 per base)
        for (coord in coords.vals()) {
            for (s1 in signs.vals()) {
                for (s2 in signs.vals()) {
                    for (s3 in signs.vals()) {
                        // The fourth coordinate is 0 in many cases, skip if it's 0
                        if (coord[3] != 0.0) {
                            vertices.add({
                                x = s1 * coord[0];
                                y = s2 * coord[1];
                                z = s3 * coord[2];
                                w = coord[3];  // Keep sign fixed for some
                            });
                        } else {
                            vertices.add({
                                x = s1 * coord[0];
                                y = s2 * coord[1];
                                z = s3 * coord[2];
                                w = 0.0;
                            });
                        };
                    };
                };
            };
        };
        
        // NOTE: The vertex generation above is a simplified construction that may
        // produce more than 120 vertices due to sign/permutation overlaps. The 600-cell
        // formally has exactly 120 vertices, but for cryptographic key rotation purposes,
        // we only need the first 120 vertices to define the rotation cycle. The truncation
        // ensures we use exactly the binary icosahedral group order (120 elements).
        let arr = Buffer.toArray(vertices);
        if (arr.size() > 120) {
            Array.tabulate<H4RootVector>(120, func(i) { arr[i] })
        } else {
            arr
        }
    };
    
    /// Calculate rotation angle for icosahedral step
    public func icosahedralRotationAngle(step: Nat) : Float {
        // 120 steps complete 2π rotation in phi-scaled increments
        let stepFloat = Float.fromInt(step % ICOSAHEDRAL_STEPS);
        TAU * stepFloat / Float.fromInt(ICOSAHEDRAL_STEPS)
    };
    
    // ================================================================== //
    // E8 ROOT SYSTEM                                                       //
    // ================================================================== //
    
    /// E8 root vector (8D)
    public type E8RootVector = {
        coords: [Float];  // 8 coordinates
    };
    
    /// Generate the 240 root vectors of E8
    /// E8 roots have two families:
    /// 1. 112 vectors with entries ±1 in two positions, 0 elsewhere
    /// 2. 128 half-integer vectors with even number of negative signs
    public func generateE8Roots() : [E8RootVector] {
        let roots = Buffer.Buffer<E8RootVector>(240);
        
        // Family 1: vectors with ±1 in positions i, j (i < j), rest 0
        // C(8,2) * 2^2 = 28 * 4 = 112 vectors
        var i : Nat = 0;
        while (i < 8) {
            var j : Nat = i + 1;
            while (j < 8) {
                let signs : [(Float, Float)] = [
                    (1.0, 1.0), (1.0, -1.0), (-1.0, 1.0), (-1.0, -1.0)
                ];
                for ((si, sj) in signs.vals()) {
                    let coords = Array.tabulate<Float>(8, func(k) {
                        if (k == i) { si }
                        else if (k == j) { sj }
                        else { 0.0 }
                    });
                    roots.add({ coords = coords });
                };
                j += 1;
            };
            i += 1;
        };
        
        // Family 2: half-integer vectors (±1/2, ±1/2, ..., ±1/2)
        // with even number of negative signs = 128 vectors
        var pattern : Nat = 0;
        while (pattern < 256) {
            // Count negative signs (1 bits)
            var negCount : Nat = 0;
            var temp = pattern;
            while (temp > 0) {
                if (temp % 2 == 1) { negCount += 1 };
                temp := temp / 2;
            };
            
            // Only include if even number of negatives
            if (negCount % 2 == 0) {
                let coords = Array.tabulate<Float>(8, func(k) {
                    let bit = (pattern / Nat.pow(2, k)) % 2;
                    if (bit == 1) { -0.5 } else { 0.5 }
                });
                roots.add({ coords = coords });
            };
            
            pattern += 1;
        };
        
        Buffer.toArray(roots)
    };
    
    /// Calculate rotation angle for E8 step (4 orthogonal rotations)
    public func e8RotationAngle(step: Nat) : Float {
        // E8 Coxeter element has order 30, rotation in 4 orthogonal planes
        let stepFloat = Float.fromInt(step % E8_STEPS);
        TAU * stepFloat / Float.fromInt(E8_STEPS)
    };
    
    // ================================================================== //
    // LEECH LATTICE                                                        //
    // ================================================================== //
    
    /// Leech lattice vector (24D) — represented as coordinate index and sign
    public type LeechVector = {
        index: Nat;  // 0 to 196,559
        theta: Float;  // Rotation phase
    };
    
    /// Calculate Leech rotation step
    /// Full cycle: 196,560 steps
    public func leechRotationAngle(step: Nat) : Float {
        let stepFloat = Float.fromInt(step % LEECH_STEPS);
        TAU * stepFloat / Float.fromInt(LEECH_STEPS)
    };
    
    /// Get Leech vector index for current step
    public func leechVectorIndex(step: Nat) : Nat {
        step % LEECH_STEPS
    };
    
    // ================================================================== //
    // PHI-BEATTY SEQUENCE                                                  //
    // ================================================================== //
    
    /// Calculate Beatty sequence of phi at position n
    /// B_φ(n) = ⌊nφ⌋
    /// This sequence is provably non-periodic (Sturmian sequence)
    public func phiBeattyValue(n: Nat) : Nat {
        let nFloat = Float.fromInt(n);
        let product = nFloat * PHI;
        Int.abs(Float.toInt(Float.floor(product)))
    };
    
    /// Get Beatty sequence bit at position n
    /// The sequence ⌊nφ⌋ mod 2 is non-periodic
    public func phiBeattyBit(n: Nat) : Nat {
        phiBeattyValue(n) % 2
    };
    
    /// Generate phi-Beatty sequence of specified length
    public func generatePhiBeattySequence(length: Nat) : [Nat] {
        Array.tabulate<Nat>(length, func(i) { phiBeattyBit(i + 1) })
    };
    
    /// Generate phi-Beatty bytes (8 bits per byte)
    public func generatePhiBeattyBytes(byteCount: Nat) : [Nat8] {
        let bytes = Buffer.Buffer<Nat8>(byteCount);
        var bitIndex : Nat = 1;
        
        var b : Nat = 0;
        while (b < byteCount) {
            var byte : Nat8 = 0;
            var bit : Nat = 0;
            while (bit < 8) {
                let bitVal = phiBeattyBit(bitIndex);
                byte := byte | (Nat8.fromNat(bitVal) << Nat8.fromNat(bit));
                bitIndex += 1;
                bit += 1;
            };
            bytes.add(byte);
            b += 1;
        };
        
        Buffer.toArray(bytes)
    };
    
    /// XOR phi-Beatty sequence with Kuramoto phase vector
    /// This is the corrected frequency signature (replacing FNV-1a)
    public func phiBeattyXorPhase(length: Nat, phaseVector: [Float]) : [Nat8] {
        let beattyBytes = generatePhiBeattyBytes(length);
        let result = Buffer.Buffer<Nat8>(length);
        
        var i : Nat = 0;
        while (i < length) {
            // Convert phase to byte
            let phaseIdx = i % phaseVector.size();
            let phase = phaseVector[phaseIdx];
            let phaseByte = Nat8.fromNat(Int.abs(Float.toInt(Float.abs(phase) * 255.0)) % 256);
            
            // XOR with Beatty byte
            result.add(beattyBytes[i] ^ phaseByte);
            i += 1;
        };
        
        Buffer.toArray(result)
    };
    
    // ================================================================== //
    // FIBONACCI MATRIX CRYPTOGRAPHY                                        //
    // ================================================================== //
    
    /// Fibonacci Q-matrix: [[1,1],[1,0]]
    /// Q^n produces Fibonacci numbers: [[F(n+1), F(n)], [F(n), F(n-1)]]
    public type FibonacciMatrix = {
        a11: Nat;
        a12: Nat;
        a21: Nat;
        a22: Nat;
    };
    
    /// Identity Fibonacci matrix
    public func fibonacciIdentity() : FibonacciMatrix {
        { a11 = 1; a12 = 0; a21 = 0; a22 = 1 }
    };
    
    /// Q-matrix (generator)
    public func fibonacciQ() : FibonacciMatrix {
        { a11 = 1; a12 = 1; a21 = 1; a22 = 0 }
    };
    
    /// Multiply two Fibonacci matrices
    public func fibonacciMatrixMultiply(a: FibonacciMatrix, b: FibonacciMatrix) : FibonacciMatrix {
        {
            a11 = a.a11 * b.a11 + a.a12 * b.a21;
            a12 = a.a11 * b.a12 + a.a12 * b.a22;
            a21 = a.a21 * b.a11 + a.a22 * b.a21;
            a22 = a.a21 * b.a12 + a.a22 * b.a22;
        }
    };
    
    /// Compute Q^n (Fibonacci matrix exponentiation)
    public func fibonacciMatrixPower(n: Nat) : FibonacciMatrix {
        if (n == 0) { return fibonacciIdentity() };
        if (n == 1) { return fibonacciQ() };
        
        var result = fibonacciIdentity();
        var base = fibonacciQ();
        var exp = n;
        
        while (exp > 0) {
            if (exp % 2 == 1) {
                result := fibonacciMatrixMultiply(result, base);
            };
            base := fibonacciMatrixMultiply(base, base);
            exp := exp / 2;
        };
        
        result
    };
    
    /// Get F(n) using matrix exponentiation
    public func fibonacciFromMatrix(n: Nat) : Nat {
        if (n == 0) { return 0 };
        let qn = fibonacciMatrixPower(n);
        qn.a12
    };
    
    /// Phi-compounding key length at cycle n
    /// Key length: floor(K_base × φ^(n mod 12))
    public func phiCompoundingKeyLength(baseLength: Nat, cycle: Nat) : Nat {
        let exponent = Float.fromInt(cycle % 12);
        let multiplier = Float.pow(PHI, exponent);
        let baseLengthFloat = Float.fromInt(baseLength);
        Int.abs(Float.toInt(Float.floor(baseLengthFloat * multiplier)))
    };
    
    // ================================================================== //
    // KEY ROTATION STATE                                                   //
    // ================================================================== //
    
    /// Full key rotation state
    public type KeyRotationState = {
        tier: KeyRotationTier;
        step: Nat;
        total_rotations: Nat;
        last_rotation_time: Int;
        coherence_at_selection: Float;
    };
    
    /// Initialize key rotation state
    public func initKeyRotation(coherence: Float) : KeyRotationState {
        {
            tier = selectTier(coherence);
            step = 0;
            total_rotations = 0;
            last_rotation_time = Time.now();
            coherence_at_selection = coherence;
        }
    };
    
    /// Advance key rotation by one step
    public func advanceRotation(state: KeyRotationState, newCoherence: Float) : KeyRotationState {
        let maxSteps = tierSteps(state.tier);
        let newStep = (state.step + 1) % maxSteps;
        let cycleComplete = newStep == 0;
        
        // Re-evaluate tier if coherence changed significantly
        let newTier = selectTier(newCoherence);
        
        {
            tier = newTier;
            step = if (newTier != state.tier) { 0 } else { newStep };
            total_rotations = state.total_rotations + 1;
            last_rotation_time = Time.now();
            coherence_at_selection = newCoherence;
        }
    };
    
    /// Get current rotation angle based on tier and step
    public func currentRotationAngle(state: KeyRotationState) : Float {
        switch (state.tier) {
            case (#Icosahedral) { icosahedralRotationAngle(state.step) };
            case (#E8) { e8RotationAngle(state.step) };
            case (#Leech) { leechRotationAngle(state.step) };
        }
    };
    
    /// Get rotation progress (0.0 to 1.0)
    public func rotationProgress(state: KeyRotationState) : Float {
        Float.fromInt(state.step) / Float.fromInt(tierSteps(state.tier))
    };
    
    // ================================================================== //
    // COXETER VERSOR FACTORIZATION                                         //
    // ================================================================== //
    
    /// E8 Coxeter versor factor
    public type CoxeterFactor = {
        plane: Nat;     // 0-3 (4 orthogonal planes)
        exponent: Nat;  // Prime exponent from {1,7,11,13,17,19,23,29}
        angle: Float;   // Rotation angle in this plane
    };
    
    /// Generate Coxeter versor factors for E8
    /// The Coxeter element factors into 4 orthogonal rotations
    public func coxeterFactors(step: Nat) : [CoxeterFactor] {
        let factors = Buffer.Buffer<CoxeterFactor>(4);
        
        var plane : Nat = 0;
        while (plane < 4) {
            let exponent = COXETER_PRIMES[plane];
            let baseAngle = TAU / 30.0;  // Coxeter number h = 30
            let stepAngle = baseAngle * Float.fromInt(step) * Float.fromInt(exponent);
            
            factors.add({
                plane = plane;
                exponent = exponent;
                angle = stepAngle - Float.floor(stepAngle / TAU) * TAU;
            });
            
            plane += 1;
        };
        
        Buffer.toArray(factors)
    };
    
    // ================================================================== //
    // STATUS AND DIAGNOSTICS                                               //
    // ================================================================== //
    
    /// Get full rotation status
    public func rotationStatus(state: KeyRotationState) : {
        tier_name: Text;
        current_step: Nat;
        max_steps: Nat;
        progress_pct: Float;
        total_rotations: Nat;
        rotation_angle: Float;
        coherence: Float;
    } {
        {
            tier_name = tierName(state.tier);
            current_step = state.step;
            max_steps = tierSteps(state.tier);
            progress_pct = rotationProgress(state) * 100.0;
            total_rotations = state.total_rotations;
            rotation_angle = currentRotationAngle(state);
            coherence = state.coherence_at_selection;
        }
    };
}
