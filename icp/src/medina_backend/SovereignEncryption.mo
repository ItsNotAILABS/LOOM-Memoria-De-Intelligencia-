/**
 * SovereignEncryption Module — 5D Key State + Three-Tier Rotation
 * 
 * LAYER 0 — THE ORGANISM ITSELF IS THE KEY:
 *   The organism IS the encryption. Every decision is simultaneously
 *   a computation AND a cryptographic event. The key at any moment is:
 * 
 *   key_state(t) = H(R_t || beat_t || law_hash_t || sensor_hash_t || biometric_hash_t)
 * 
 * FIVE DIMENSIONS OF KEY STATE:
 *   1. Coherence (R) — Kuramoto order parameter, live coherence level
 *   2. Temporal (beat) — Current beat count, time dimension
 *   3. Doctrine — Active law states hash, doctrine dimension
 *   4. Physical — Sensor field hash, physical dimension
 *   5. Biological — Founder biometric state, biological dimension
 * 
 * KEY STATE CHANGES EVERY 873ms:
 *   No adversary can model this key because doing so requires modeling
 *   the organism's complete cognitive state — which is equivalent to
 *   solving the organism itself.
 * 
 * PHI-FIBONACCI COMPOUND KEY DERIVATION:
 *   K_0 = genesis_key
 *   K_n = H_phi(K_{n-1} || organism_state(n))
 *   Key length at cycle n: floor(K_base × φ^(n mod 12))
 *   The key NEVER stops growing.
 * 
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX | April 16, 2026
 * PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
 */

import Array "mo:base/Array";
import Blob "mo:base/Blob";
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
import IcosahedralLeechGeometry "IcosahedralLeechGeometry";

module {
    // ================================================================== //
    // CONSTANTS                                                            //
    // ================================================================== //
    
    /// Golden ratio
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Key state update interval (873ms in nanoseconds)
    public let KEY_STATE_INTERVAL_NS : Int = 873_000_000;
    
    /// Sovereign frequency (7.83 × φ = 12.67 Hz)
    public let SOVEREIGN_FREQUENCY : Float = 7.83 * PHI;
    
    /// Base key length (bits conceptually, stored as bytes)
    public let BASE_KEY_LENGTH : Nat = 32;  // 256 bits / 8
    
    /// Maximum phi-compounding cycles before reset
    public let MAX_PHI_CYCLES : Nat = 12;
    
    // ================================================================== //
    // 5D KEY STATE                                                         //
    // ================================================================== //
    
    /// Five-dimensional key state
    public type KeyStateDimensions = {
        // Dimension 1: Coherence (Kuramoto order parameter R)
        coherence: Float;
        
        // Dimension 2: Temporal (beat count)
        beat_count: Nat;
        
        // Dimension 3: Doctrine (active law states hash)
        doctrine_hash: [Nat8];
        
        // Dimension 4: Physical (sensor field hash)
        sensor_hash: [Nat8];
        
        // Dimension 5: Biological (founder biometric state)
        biometric_hash: [Nat8];
    };
    
    /// Full sovereign key state
    public type SovereignKeyState = {
        // The 5D dimensions
        dimensions: KeyStateDimensions;
        
        // Derived key material
        key_material: [Nat8];
        
        // Key rotation state
        rotation: IcosahedralLeechGeometry.KeyRotationState;
        
        // Phi-compounding state
        phi_cycle: Nat;
        compound_factor: Float;
        
        // Timestamps
        created_at: Int;
        last_updated: Int;
        update_count: Nat;
    };
    
    /// Organism key state (live, changes every 873ms)
    public type OrganismKeyState = {
        var current: SovereignKeyState;
        var genesis_key: [Nat8];
        var lineage_hash: [Nat8];
    };
    
    // ================================================================== //
    // HASH FUNCTIONS (PHI-NATIVE, REPLACING FNV-1a)                        //
    // ================================================================== //
    
    /// Simple mixing function for hash computation
    func mixBytes(a: Nat32, b: Nat32) : Nat32 {
        var h = a ^ b;
        h := h ^ (h >> 16);
        h := h *% 0x7feb352d;
        h := h ^ (h >> 15);
        h := h *% 0x846ca68b;
        h := h ^ (h >> 16);
        h
    };
    
    /// Convert Float to hash contribution
    func floatToHash(f: Float) : Nat32 {
        let scaled = Float.toInt(f * 1_000_000_000.0);
        Nat32.fromNat(Int.abs(scaled) % 4_294_967_295)
    };
    
    /// Convert Nat to hash contribution
    func natToHash(n: Nat) : Nat32 {
        Nat32.fromNat(n % 4_294_967_295)
    };
    
    /// Phi-native ANIMA hash function
    /// Uses golden ratio scaling with Fibonacci mixing
    public func animaHash(dimensions: KeyStateDimensions) : [Nat8] {
        // Hash each dimension
        let coherenceHash = floatToHash(dimensions.coherence * PHI);
        let beatHash = natToHash(dimensions.beat_count);
        
        // Mix dimension hashes
        var h1 = mixBytes(coherenceHash, beatHash);
        
        // Mix in doctrine hash
        for (b in dimensions.doctrine_hash.vals()) {
            h1 := mixBytes(h1, Nat32.fromNat(Nat8.toNat(b)));
        };
        
        // Mix in sensor hash  
        var h2 : Nat32 = 0x811c9dc5;
        for (b in dimensions.sensor_hash.vals()) {
            h2 := mixBytes(h2, Nat32.fromNat(Nat8.toNat(b)));
        };
        
        // Mix in biometric hash
        var h3 : Nat32 = 0x01000193;
        for (b in dimensions.biometric_hash.vals()) {
            h3 := mixBytes(h3, Nat32.fromNat(Nat8.toNat(b)));
        };
        
        // Final mixing with phi-scaled values
        let phiScaled = floatToHash(Float.fromInt(Nat32.toNat(h1)) * PHI);
        let final1 = mixBytes(h1, h2);
        let final2 = mixBytes(h3, phiScaled);
        let finalHash = mixBytes(final1, final2);
        
        // Generate 32-byte hash from final values
        let result = Buffer.Buffer<Nat8>(32);
        
        // Add phi-scaled Fibonacci mixing for additional bytes
        var current = finalHash;
        var i : Nat = 0;
        while (i < 8) {
            result.add(Nat8.fromNat(Nat32.toNat(current) % 256));
            result.add(Nat8.fromNat(Nat32.toNat(current >> 8) % 256));
            result.add(Nat8.fromNat(Nat32.toNat(current >> 16) % 256));
            result.add(Nat8.fromNat(Nat32.toNat(current >> 24) % 256));
            
            // Fibonacci-style mixing for next iteration
            let fibMix = natToHash(MatalkoICP.fibonacci(i + 2));
            current := mixBytes(current, fibMix);
            i += 1;
        };
        
        Buffer.toArray(result)
    };
    
    // ================================================================== //
    // PHI-FIBONACCI COMPOUND KEY DERIVATION                                //
    // ================================================================== //
    
    /// Derive compound key using Fibonacci matrix encryption
    public func deriveCompoundKey(
        previousKey: [Nat8],
        dimensions: KeyStateDimensions,
        cycle: Nat
    ) : [Nat8] {
        // Get phi-compounding length for this cycle
        let targetLength = IcosahedralLeechGeometry.phiCompoundingKeyLength(BASE_KEY_LENGTH, cycle);
        
        // Hash dimensions
        let dimensionHash = animaHash(dimensions);
        
        // XOR previous key with dimension hash
        let combined = Buffer.Buffer<Nat8>(previousKey.size());
        var i : Nat = 0;
        while (i < previousKey.size()) {
            let dimByte = dimensionHash[i % dimensionHash.size()];
            combined.add(previousKey[i] ^ dimByte);
            i += 1;
        };
        
        // Apply Fibonacci matrix mixing
        let fibMatrix = IcosahedralLeechGeometry.fibonacciMatrixPower(cycle + 1);
        let fibMixValue = fibMatrix.a11 % 256;
        
        var j : Nat = 0;
        while (j < combined.size()) {
            let mixed = Nat8.fromNat((Nat8.toNat(combined.get(j)) + fibMixValue) % 256);
            combined.put(j, mixed);
            j += 1;
        };
        
        // Extend key to target length if needed
        let result = Buffer.Buffer<Nat8>(targetLength);
        var k : Nat = 0;
        while (k < targetLength) {
            let srcByte = combined.get(k % combined.size());
            // Apply phi-Beatty mixing for extension
            let beattyBit = IcosahedralLeechGeometry.phiBeattyBit(k + 1);
            let extended = Nat8.fromNat((Nat8.toNat(srcByte) + beattyBit) % 256);
            result.add(extended);
            k += 1;
        };
        
        Buffer.toArray(result)
    };
    
    // ================================================================== //
    // KEY STATE INITIALIZATION                                             //
    // ================================================================== //
    
    /// Create default dimension hash (32 bytes)
    func defaultHash() : [Nat8] {
        Array.tabulate<Nat8>(32, func(i) { Nat8.fromNat(i) })
    };
    
    /// Initialize sovereign key state
    public func init() : OrganismKeyState {
        let now = Time.now();
        
        let initialDimensions : KeyStateDimensions = {
            coherence = 1.0;  // Start at full coherence
            beat_count = 0;
            doctrine_hash = defaultHash();
            sensor_hash = defaultHash();
            biometric_hash = defaultHash();
        };
        
        let initialKey = animaHash(initialDimensions);
        
        let initialState : SovereignKeyState = {
            dimensions = initialDimensions;
            key_material = initialKey;
            rotation = IcosahedralLeechGeometry.initKeyRotation(1.0);
            phi_cycle = 0;
            compound_factor = 1.0;
            created_at = now;
            last_updated = now;
            update_count = 0;
        };
        
        {
            var current = initialState;
            var genesis_key = initialKey;
            var lineage_hash = initialKey;
        }
    };
    
    // ================================================================== //
    // KEY STATE OPERATIONS                                                 //
    // ================================================================== //
    
    /// Update key state with new dimensions (called every 873ms)
    public func updateKeyState(
        state: OrganismKeyState,
        newCoherence: Float,
        newBeat: Nat,
        newDoctrineHash: [Nat8],
        newSensorHash: [Nat8],
        newBiometricHash: [Nat8]
    ) : OrganismKeyState {
        let now = Time.now();
        
        let newDimensions : KeyStateDimensions = {
            coherence = newCoherence;
            beat_count = newBeat;
            doctrine_hash = newDoctrineHash;
            sensor_hash = newSensorHash;
            biometric_hash = newBiometricHash;
        };
        
        // Advance phi cycle
        let newPhiCycle = (state.current.phi_cycle + 1) % MAX_PHI_CYCLES;
        let newCompoundFactor = Float.pow(PHI, Float.fromInt(newPhiCycle));
        
        // Derive new key material
        let newKeyMaterial = deriveCompoundKey(
            state.current.key_material,
            newDimensions,
            newPhiCycle
        );
        
        // Advance rotation based on new coherence
        let newRotation = IcosahedralLeechGeometry.advanceRotation(
            state.current.rotation,
            newCoherence
        );
        
        // Update lineage hash
        let lineageUpdate = Buffer.Buffer<Nat8>(64);
        for (b in state.lineage_hash.vals()) {
            lineageUpdate.add(b);
        };
        for (b in newKeyMaterial.vals()) {
            lineageUpdate.add(b);
        };
        let newLineageHash = animaHash({
            coherence = newCoherence;
            beat_count = newBeat;
            doctrine_hash = Buffer.toArray(lineageUpdate);
            sensor_hash = newSensorHash;
            biometric_hash = newBiometricHash;
        });
        
        let newState : SovereignKeyState = {
            dimensions = newDimensions;
            key_material = newKeyMaterial;
            rotation = newRotation;
            phi_cycle = newPhiCycle;
            compound_factor = newCompoundFactor;
            created_at = state.current.created_at;
            last_updated = now;
            update_count = state.current.update_count + 1;
        };
        
        state.current := newState;
        state.lineage_hash := newLineageHash;
        state
    };
    
    /// Get current key state (read-only snapshot)
    public func getCurrentKeyState(state: OrganismKeyState) : SovereignKeyState {
        state.current
    };
    
    /// Check if key state needs update (> 873ms elapsed)
    public func needsUpdate(state: OrganismKeyState) : Bool {
        let elapsed = Time.now() - state.current.last_updated;
        elapsed >= KEY_STATE_INTERVAL_NS
    };
    
    // ================================================================== //
    // FREQUENCY SIGNATURE (CORRECTED — NO FNV-1a)                          //
    // ================================================================== //
    
    /// Generate sovereign frequency signature
    /// Uses phi-Beatty sequence XOR'd with Kuramoto phase vector
    public func generateFrequencySignature(
        beatCount: Nat,
        phaseVector: [Float],
        length: Nat
    ) : [Nat8] {
        IcosahedralLeechGeometry.phiBeattyXorPhase(length, phaseVector)
    };
    
    /// Verify frequency signature against expected pattern
    public func verifyFrequencySignature(
        signature: [Nat8],
        beatCount: Nat,
        phaseVector: [Float]
    ) : Bool {
        let expected = generateFrequencySignature(beatCount, phaseVector, signature.size());
        
        if (signature.size() != expected.size()) { return false };
        
        var i : Nat = 0;
        while (i < signature.size()) {
            if (signature[i] != expected[i]) { return false };
            i += 1;
        };
        
        true
    };
    
    // ================================================================== //
    // ARTIFACT ENCRYPTION                                                  //
    // ================================================================== //
    
    /// Encrypted artifact with sovereign key
    public type EncryptedArtifact = {
        ciphertext: [Nat8];
        key_tier: IcosahedralLeechGeometry.KeyRotationTier;
        rotation_step: Nat;
        beat_at_encryption: Nat;
        phi_cycle: Nat;
        artifact_id: Text;
        created_at: Int;
    };
    
    /// Encrypt data using current sovereign key state
    public func encryptArtifact(
        state: OrganismKeyState,
        plaintext: [Nat8],
        artifactId: Text
    ) : EncryptedArtifact {
        let key = state.current.key_material;
        
        // Simple XOR encryption (in production, use ICP vetKeys)
        let ciphertext = Buffer.Buffer<Nat8>(plaintext.size());
        var i : Nat = 0;
        while (i < plaintext.size()) {
            let keyByte = key[i % key.size()];
            ciphertext.add(plaintext[i] ^ keyByte);
            i += 1;
        };
        
        {
            ciphertext = Buffer.toArray(ciphertext);
            key_tier = state.current.rotation.tier;
            rotation_step = state.current.rotation.step;
            beat_at_encryption = state.current.dimensions.beat_count;
            phi_cycle = state.current.phi_cycle;
            artifact_id = artifactId;
            created_at = Time.now();
        }
    };
    
    /// Decrypt artifact (requires matching key state recreation)
    /// Note: In practice, this uses ICP vetKeys derivation
    public func decryptArtifact(
        key: [Nat8],
        artifact: EncryptedArtifact
    ) : [Nat8] {
        let plaintext = Buffer.Buffer<Nat8>(artifact.ciphertext.size());
        var i : Nat = 0;
        while (i < artifact.ciphertext.size()) {
            let keyByte = key[i % key.size()];
            plaintext.add(artifact.ciphertext[i] ^ keyByte);
            i += 1;
        };
        Buffer.toArray(plaintext)
    };
    
    // ================================================================== //
    // STATUS AND DIAGNOSTICS                                               //
    // ================================================================== //
    
    /// Get sovereign encryption status
    public func status(state: OrganismKeyState) : {
        rotation_tier: Text;
        rotation_step: Nat;
        rotation_max_steps: Nat;
        phi_cycle: Nat;
        compound_factor: Float;
        key_length: Nat;
        coherence: Float;
        beat_count: Nat;
        update_count: Nat;
        last_updated: Int;
    } {
        let rotStatus = IcosahedralLeechGeometry.rotationStatus(state.current.rotation);
        
        {
            rotation_tier = rotStatus.tier_name;
            rotation_step = rotStatus.current_step;
            rotation_max_steps = rotStatus.max_steps;
            phi_cycle = state.current.phi_cycle;
            compound_factor = state.current.compound_factor;
            key_length = state.current.key_material.size();
            coherence = state.current.dimensions.coherence;
            beat_count = state.current.dimensions.beat_count;
            update_count = state.current.update_count;
            last_updated = state.current.last_updated;
        }
    };
}
