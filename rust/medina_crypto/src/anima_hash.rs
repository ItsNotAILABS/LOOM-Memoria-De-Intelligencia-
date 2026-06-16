// ═══════════════════════════════════════════════════════════════════════════════
// MEDINA - PROPRIETARY AND CONFIDENTIAL
// Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA
// medinasiftech@outlook.com | ALL RIGHTS RESERVED
// ═══════════════════════════════════════════════════════════════════════════════
//
// anima_hash.rs — ANIMA φ-NATIVE HASH FUNCTION
//
// The ANIMA hash is the core hash function of the MEDINA system.
// It incorporates φ-native mathematics into standard cryptographic primitives.
//
// ═══════════════════════════════════════════════════════════════════════════════

use sha2::{Sha256, Digest};
use crate::constants::{PHI, PHI_INV, ANIMA_LINEAGE};

/// ANIMA hash output size (32 bytes / 256 bits)
pub const ANIMA_HASH_SIZE: usize = 32;

/// ANIMA hash result
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct AnimaHash {
    pub bytes: [u8; ANIMA_HASH_SIZE],
}

impl AnimaHash {
    /// Create from byte array
    pub fn from_bytes(bytes: [u8; ANIMA_HASH_SIZE]) -> Self {
        Self { bytes }
    }
    
    /// Create from slice (panics if wrong length)
    pub fn from_slice(slice: &[u8]) -> Self {
        let mut bytes = [0u8; ANIMA_HASH_SIZE];
        bytes.copy_from_slice(&slice[..ANIMA_HASH_SIZE]);
        Self { bytes }
    }
    
    /// Convert to hex string
    pub fn to_hex(&self) -> String {
        hex::encode(&self.bytes)
    }
    
    /// Convert to bytes
    pub fn as_bytes(&self) -> &[u8; ANIMA_HASH_SIZE] {
        &self.bytes
    }
}

impl std::fmt::Display for AnimaHash {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "ANIMA:{}", &self.to_hex()[..16])
    }
}

/// Compute ANIMA hash of data
/// 
/// ANIMA hash incorporates:
/// - Standard SHA-256 as base
/// - φ-mixing of intermediate states
/// - ANIMA lineage binding
/// 
pub fn anima_hash(data: &[u8]) -> AnimaHash {
    // First pass: SHA-256 of data
    let mut hasher1 = Sha256::new();
    hasher1.update(data);
    let hash1 = hasher1.finalize();
    
    // φ-mix the hash
    let mixed = phi_mix_bytes(&hash1);
    
    // Second pass: SHA-256 with lineage binding
    let mut hasher2 = Sha256::new();
    hasher2.update(&mixed);
    hasher2.update(ANIMA_LINEAGE.as_bytes());
    let final_hash = hasher2.finalize();
    
    AnimaHash::from_slice(&final_hash)
}

/// Compute ANIMA hash of text
pub fn anima_hash_text(text: &str) -> AnimaHash {
    anima_hash(text.as_bytes())
}

/// Compute ANIMA hash with context
pub fn anima_hash_with_context(data: &[u8], context: &[u8]) -> AnimaHash {
    let mut combined = Vec::with_capacity(data.len() + context.len());
    combined.extend_from_slice(data);
    combined.extend_from_slice(context);
    anima_hash(&combined)
}

/// Apply φ-mixing to bytes
/// 
/// This function mixes the bytes using the golden ratio,
/// creating a unique φ-native transformation.
/// 
fn phi_mix_bytes(input: &[u8]) -> Vec<u8> {
    let mut output = Vec::with_capacity(input.len());
    
    for (i, byte) in input.iter().enumerate() {
        // φ-transformation for each byte position
        let phi_factor = ((PHI * (i as f64 + 1.0)) % 256.0) as u8;
        let inv_factor = ((PHI_INV * (i as f64 + 1.0)) % 256.0) as u8;
        
        // Mix the byte
        let mixed = byte.wrapping_add(phi_factor).wrapping_mul(inv_factor.wrapping_add(1));
        output.push(mixed);
    }
    
    output
}

/// Combine two ANIMA hashes into one (for Merkle tree construction)
pub fn combine_hashes(left: &AnimaHash, right: &AnimaHash) -> AnimaHash {
    let mut combined = Vec::with_capacity(ANIMA_HASH_SIZE * 2);
    combined.extend_from_slice(&left.bytes);
    combined.extend_from_slice(&right.bytes);
    anima_hash(&combined)
}

/// Verify if data produces expected hash
pub fn verify_hash(data: &[u8], expected: &AnimaHash) -> bool {
    let computed = anima_hash(data);
    computed.bytes == expected.bytes
}

/// Compute chain hash for ANIMA chain encryption
/// Links hashes together with Fibonacci depth
pub fn chain_hash(previous: &AnimaHash, data: &[u8], depth: u64) -> AnimaHash {
    let mut chain_data = Vec::new();
    
    // Include previous hash
    chain_data.extend_from_slice(&previous.bytes);
    
    // Include depth as bytes
    chain_data.extend_from_slice(&depth.to_le_bytes());
    
    // Include data
    chain_data.extend_from_slice(data);
    
    // Apply repeated hashing based on depth
    let mut result = anima_hash(&chain_data);
    for _ in 1..depth {
        result = anima_hash(&result.bytes);
    }
    
    result
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_anima_hash_deterministic() {
        let data = b"test data";
        let hash1 = anima_hash(data);
        let hash2 = anima_hash(data);
        assert_eq!(hash1, hash2);
    }
    
    #[test]
    fn test_anima_hash_different_inputs() {
        let hash1 = anima_hash(b"input1");
        let hash2 = anima_hash(b"input2");
        assert_ne!(hash1, hash2);
    }
    
    #[test]
    fn test_anima_hash_text() {
        let hash = anima_hash_text("Hello MEDINA");
        assert_eq!(hash.bytes.len(), ANIMA_HASH_SIZE);
    }
    
    #[test]
    fn test_combine_hashes() {
        let hash1 = anima_hash(b"left");
        let hash2 = anima_hash(b"right");
        let combined = combine_hashes(&hash1, &hash2);
        
        // Combining should be deterministic
        let combined2 = combine_hashes(&hash1, &hash2);
        assert_eq!(combined, combined2);
        
        // Order matters
        let combined_reverse = combine_hashes(&hash2, &hash1);
        assert_ne!(combined, combined_reverse);
    }
    
    #[test]
    fn test_verify_hash() {
        let data = b"verify this";
        let hash = anima_hash(data);
        assert!(verify_hash(data, &hash));
        assert!(!verify_hash(b"different", &hash));
    }
    
    #[test]
    fn test_chain_hash() {
        let genesis = anima_hash(b"genesis");
        let chain1 = chain_hash(&genesis, b"block1", 3);
        let chain2 = chain_hash(&chain1, b"block2", 3);
        
        // Chain hashes should be different
        assert_ne!(chain1, chain2);
        
        // Same inputs should produce same output
        let chain1_again = chain_hash(&genesis, b"block1", 3);
        assert_eq!(chain1, chain1_again);
    }
}
