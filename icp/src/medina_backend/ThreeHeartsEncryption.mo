/**
 * ThreeHeartsEncryption Module — Phase-Derived Keys from Kuramoto Coupling
 * 
 * PHASE-DERIVED KEYS:
 *   Keys derive from Three Hearts phase differences:
 *   - delta_mc = sin(θ_metro - θ_couple)
 *   - delta_cr = sin(θ_couple - θ_regulate)
 *   - delta_rm = sin(θ_regulate - θ_metro)
 * 
 * KEY TIER SELECTION:
 *   Selected by global coherence R from Three Hearts:
 *   - R < 0.618: Survival/Icosahedral tier
 *   - 0.618 ≤ R < 0.854: E8 tier
 *   - R ≥ 0.854: Leech tier
 * 
 * KURAMOTO COUPLING MATRIX:
 *   Heart 1 (Metropolis): 0.1 Hz — Backend computation
 *   Heart 2 (Coupling): φ Hz — Resonance
 *   Heart 3 (Regulating): φ² Hz — Orchestration
 * 
 *   d(θ_i)/dt = ω_i + Σ K_ij sin(θ_j - θ_i)
 * 
 * THE ENCRYPTION IS THE COMPUTATION:
 *   Every Kuramoto phase update IS an encryption event.
 *   The cognitive state IS the cryptographic state.
 *   They are the same field.
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
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import ThreeHeartsEngine "ThreeHeartsEngine";
import IcosahedralLeechGeometry "IcosahedralLeechGeometry";

module {
    // ================================================================== //
    // CONSTANTS                                                            //
    // ================================================================== //
    
    /// Golden ratio
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Tau (2π)
    public let TAU : Float = MatalkoICP.TAU;
    
    /// Encryption key derivation iterations
    public let KEY_DERIVATION_ROUNDS : Nat = 8;
    
    // ================================================================== //
    // PHASE-DERIVED KEY TYPES                                              //
    // ================================================================== //
    
    /// Phase differences between hearts
    public type PhaseDifferences = {
        delta_mc: Float;  // sin(θ_metro - θ_couple)
        delta_cr: Float;  // sin(θ_couple - θ_regulate)
        delta_rm: Float;  // sin(θ_regulate - θ_metro)
    };
    
    /// Three Hearts encryption state
    public type ThreeHeartsKeyState = {
        // Phase differences
        phases: PhaseDifferences;
        
        // Global coherence (order parameter)
        global_coherence: Float;
        
        // Key tier based on coherence
        key_tier: IcosahedralLeechGeometry.KeyRotationTier;
        
        // Derived key material
        key_material: [Nat8];
        
        // Heart beat counts
        metro_beats: Nat;
        coupling_beats: Nat;
        regulating_beats: Nat;
        
        // Timestamp
        derived_at: Int;
    };
    
    // ================================================================== //
    // PHASE EXTRACTION                                                     //
    // ================================================================== //
    
    /// Extract phase differences from Three Hearts state
    public func extractPhaseDifferences(heartsState: ThreeHeartsEngine.ThreeHeartsState) : PhaseDifferences {
        let theta_m = heartsState.metropolis.theta;
        let theta_c = heartsState.coupling.theta;
        let theta_r = heartsState.regulating.theta;
        
        {
            delta_mc = Float.sin(theta_m - theta_c);
            delta_cr = Float.sin(theta_c - theta_r);
            delta_rm = Float.sin(theta_r - theta_m);
        }
    };
    
    /// Calculate global coherence from Three Hearts
    public func calculateGlobalCoherence(heartsState: ThreeHeartsEngine.ThreeHeartsState) : Float {
        let metrics = ThreeHeartsEngine.calculateCoherence(heartsState);
        metrics.global_coherence
    };
    
    // ================================================================== //
    // KEY DERIVATION                                                       //
    // ================================================================== //
    
    /// Mix function for key derivation
    func keyMix(a: Nat32, b: Nat32) : Nat32 {
        var h = a ^ b;
        h := h ^ (h >> 16);
        h := h *% 0x7feb352d;
        h := h ^ (h >> 15);
        h := h *% 0x846ca68b;
        h := h ^ (h >> 16);
        h
    };
    
    /// Convert phase difference to hash value
    func phaseToHash(phase: Float) : Nat32 {
        // Scale phase [-1, 1] to [0, 2^32-1]
        let scaled = (phase + 1.0) * 2147483647.5;
        Nat32.fromNat(Int.abs(Float.toInt(scaled)) % 4_294_967_295)
    };
    
    /// Derive key material from phase differences
    public func deriveKeyFromPhases(
        phases: PhaseDifferences,
        coherence: Float,
        keyLength: Nat
    ) : [Nat8] {
        // Initial hash from phases
        let h_mc = phaseToHash(phases.delta_mc);
        let h_cr = phaseToHash(phases.delta_cr);
        let h_rm = phaseToHash(phases.delta_rm);
        let h_coh = phaseToHash(coherence);
        
        // Mix all phase hashes
        var mixed = keyMix(h_mc, h_cr);
        mixed := keyMix(mixed, h_rm);
        mixed := keyMix(mixed, h_coh);
        
        // Apply phi-scaling
        let phiScaled = phaseToHash(Float.fromInt(Nat32.toNat(mixed)) / 4_294_967_295.0 * PHI);
        mixed := keyMix(mixed, phiScaled);
        
        // Generate key bytes
        let key = Buffer.Buffer<Nat8>(keyLength);
        var current = mixed;
        var i : Nat = 0;
        
        while (i < keyLength) {
            // Extract bytes from current hash
            key.add(Nat8.fromNat(Nat32.toNat(current) % 256));
            
            // Advance using Fibonacci-style mixing
            let fibVal = MatalkoICP.fibonacci((i + 2) % 30);
            let fibHash = Nat32.fromNat(fibVal % 4_294_967_295);
            current := keyMix(current, fibHash);
            
            // Add phi-Beatty influence
            let beattyBit = IcosahedralLeechGeometry.phiBeattyBit(i + 1);
            if (beattyBit == 1) {
                current := keyMix(current, phiScaled);
            };
            
            i += 1;
        };
        
        Buffer.toArray(key)
    };
    
    /// Full key derivation with multiple rounds
    public func deriveKeyFullRounds(
        heartsState: ThreeHeartsEngine.ThreeHeartsState,
        baseKeyLength: Nat
    ) : ThreeHeartsKeyState {
        let phases = extractPhaseDifferences(heartsState);
        let coherence = calculateGlobalCoherence(heartsState);
        let tier = IcosahedralLeechGeometry.selectTier(coherence);
        
        // Adjust key length based on tier
        let tierMultiplier = switch (tier) {
            case (#Icosahedral) { 1 };
            case (#E8) { 2 };
            case (#Leech) { 4 };
        };
        let keyLength = baseKeyLength * tierMultiplier;
        
        // Derive initial key
        var key = deriveKeyFromPhases(phases, coherence, keyLength);
        
        // Apply multiple derivation rounds
        var round : Nat = 0;
        while (round < KEY_DERIVATION_ROUNDS) {
            // Each round mixes key with phase-rotated values
            let rotatedPhases : PhaseDifferences = {
                delta_mc = Float.sin(phases.delta_mc * Float.fromInt(round + 1) * PHI);
                delta_cr = Float.sin(phases.delta_cr * Float.fromInt(round + 1) * PHI);
                delta_rm = Float.sin(phases.delta_rm * Float.fromInt(round + 1) * PHI);
            };
            
            let roundKey = deriveKeyFromPhases(rotatedPhases, coherence, keyLength);
            
            // XOR round key with accumulated key
            let mixed = Buffer.Buffer<Nat8>(keyLength);
            var j : Nat = 0;
            while (j < keyLength) {
                mixed.add(key[j] ^ roundKey[j]);
                j += 1;
            };
            key := Buffer.toArray(mixed);
            
            round += 1;
        };
        
        {
            phases = phases;
            global_coherence = coherence;
            key_tier = tier;
            key_material = key;
            metro_beats = heartsState.metropolis.beat_count;
            coupling_beats = heartsState.coupling.beat_count;
            regulating_beats = heartsState.regulating.beat_count;
            derived_at = Time.now();
        }
    };
    
    // ================================================================== //
    // PHASE VECTOR FOR FREQUENCY SIGNATURE                                 //
    // ================================================================== //
    
    /// Extract phase vector for frequency signature (Kuramoto phases)
    public func extractPhaseVector(heartsState: ThreeHeartsEngine.ThreeHeartsState) : [Float] {
        [
            heartsState.metropolis.theta,
            heartsState.coupling.theta,
            heartsState.regulating.theta,
            Float.sin(heartsState.metropolis.theta - heartsState.coupling.theta),
            Float.sin(heartsState.coupling.theta - heartsState.regulating.theta),
            Float.sin(heartsState.regulating.theta - heartsState.metropolis.theta),
            Float.cos(heartsState.metropolis.theta + heartsState.coupling.theta),
            Float.cos(heartsState.coupling.theta + heartsState.regulating.theta),
        ]
    };
    
    /// Generate Three Hearts frequency signature
    public func generateHeartFrequencySignature(
        heartsState: ThreeHeartsEngine.ThreeHeartsState,
        length: Nat
    ) : [Nat8] {
        let phaseVector = extractPhaseVector(heartsState);
        IcosahedralLeechGeometry.phiBeattyXorPhase(length, phaseVector)
    };
    
    // ================================================================== //
    // COGNITIVE ENCRYPTION                                                 //
    // ================================================================== //
    
    /// Encrypt cognitive artifact using Three Hearts state
    public type CognitiveArtifact = {
        ciphertext: [Nat8];
        phase_snapshot: PhaseDifferences;
        coherence_at_encryption: Float;
        key_tier: IcosahedralLeechGeometry.KeyRotationTier;
        heart_beats: (Nat, Nat, Nat);  // (metro, coupling, regulating)
        artifact_type: Text;
        created_at: Int;
    };
    
    /// Encrypt data using Three Hearts key
    public func encryptCognitive(
        heartsState: ThreeHeartsEngine.ThreeHeartsState,
        plaintext: [Nat8],
        artifactType: Text
    ) : CognitiveArtifact {
        let keyState = deriveKeyFullRounds(heartsState, 32);
        let key = keyState.key_material;
        
        // XOR encryption
        let ciphertext = Buffer.Buffer<Nat8>(plaintext.size());
        var i : Nat = 0;
        while (i < plaintext.size()) {
            ciphertext.add(plaintext[i] ^ key[i % key.size()]);
            i += 1;
        };
        
        {
            ciphertext = Buffer.toArray(ciphertext);
            phase_snapshot = keyState.phases;
            coherence_at_encryption = keyState.global_coherence;
            key_tier = keyState.key_tier;
            heart_beats = (keyState.metro_beats, keyState.coupling_beats, keyState.regulating_beats);
            artifact_type = artifactType;
            created_at = Time.now();
        }
    };
    
    /// Decrypt cognitive artifact
    public func decryptCognitive(
        key: [Nat8],
        artifact: CognitiveArtifact
    ) : [Nat8] {
        let plaintext = Buffer.Buffer<Nat8>(artifact.ciphertext.size());
        var i : Nat = 0;
        while (i < artifact.ciphertext.size()) {
            plaintext.add(artifact.ciphertext[i] ^ key[i % key.size()]);
            i += 1;
        };
        Buffer.toArray(plaintext)
    };
    
    // ================================================================== //
    // COHERENCE-GATED OPERATIONS                                           //
    // ================================================================== //
    
    /// Check if coherence is sufficient for tier
    public func isCoherenceSufficient(
        heartsState: ThreeHeartsEngine.ThreeHeartsState,
        requiredTier: IcosahedralLeechGeometry.KeyRotationTier
    ) : Bool {
        let coherence = calculateGlobalCoherence(heartsState);
        let currentTier = IcosahedralLeechGeometry.selectTier(coherence);
        
        switch (requiredTier, currentTier) {
            case (#Icosahedral, _) { true };
            case (#E8, #E8) { true };
            case (#E8, #Leech) { true };
            case (#Leech, #Leech) { true };
            case (_, _) { false };
        }
    };
    
    /// Execute operation only if coherence meets requirement
    public func coherenceGatedOperation<T>(
        heartsState: ThreeHeartsEngine.ThreeHeartsState,
        requiredTier: IcosahedralLeechGeometry.KeyRotationTier,
        operation: () -> T,
        fallback: T
    ) : T {
        if (isCoherenceSufficient(heartsState, requiredTier)) {
            operation()
        } else {
            fallback
        }
    };
    
    // ================================================================== //
    // STATUS                                                               //
    // ================================================================== //
    
    /// Get Three Hearts encryption status
    public func status(heartsState: ThreeHeartsEngine.ThreeHeartsState) : {
        coherence: Float;
        tier: Text;
        phases: PhaseDifferences;
        metro_phase: Float;
        coupling_phase: Float;
        regulating_phase: Float;
        metro_beats: Nat;
        coupling_beats: Nat;
        regulating_beats: Nat;
    } {
        let phases = extractPhaseDifferences(heartsState);
        let coherence = calculateGlobalCoherence(heartsState);
        let tier = IcosahedralLeechGeometry.selectTier(coherence);
        
        {
            coherence = coherence;
            tier = IcosahedralLeechGeometry.tierName(tier);
            phases = phases;
            metro_phase = heartsState.metropolis.theta;
            coupling_phase = heartsState.coupling.theta;
            regulating_phase = heartsState.regulating.theta;
            metro_beats = heartsState.metropolis.beat_count;
            coupling_beats = heartsState.coupling.beat_count;
            regulating_beats = heartsState.regulating.beat_count;
        }
    };
}
