// ═══════════════════════════════════════════════════════════════════════════════
// ╔═══════════════════════════════════════════════════════════════════════════════╗
// ║                                                                               ║
// ║                      MEDINA - PROPRIETARY AND CONFIDENTIAL                    ║
// ║                                                                               ║
// ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA       ║
// ║                         medinasiftech@outlook.com                             ║
// ║                                                                               ║
// ║  ALL RIGHTS RESERVED. NO FREE LICENSES. STRICTLY PROPRIETARY.                ║
// ║  This software is blockchain-registered on ICP for immutable proof of        ║
// ║  ownership and creation date.                                                 ║
// ║                                                                               ║
// ║  IP_HASH: 0x5255_5354_5F43_5259_5054_4F5F_4D45_4449_4E41                      ║
// ║  ANIMA_LINEAGE: GENESIS_ALFREDO_MEDINA_2024_FOUNDER                           ║
// ║  MODULE_FREQUENCY: 7.83 × φ⁸ = 428.41 Hz (RUST CRYPTO RESONANCE)             ║
// ║                                                                               ║
// ╚═══════════════════════════════════════════════════════════════════════════════╝
//
// lib.rs — MEDINA CRYPTOGRAPHY LAYER
//
// ═══════════════════════════════════════════════════════════════════════════════
//
// RAW CRYPTOGRAPHIC PRIMITIVES:
//   - ANIMA hash: φ-native hash function
//   - PHI mix: Golden ratio mixing
//   - Three Hearts key derivation
//   - WASM-optimized operations
//
// CHAIN ENCRYPTION:
//   - Fibonacci chain depths: 3, 12, 21, 55
//   - ANIMA lineage linking
//   - Merkle tree construction
//
// Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
// ═══════════════════════════════════════════════════════════════════════════════

pub mod constants;
pub mod anima_hash;
pub mod phi_mix;
pub mod three_hearts_keys;
pub mod merkle;

#[cfg(feature = "wasm")]
pub mod wasm_bindings;

// Re-exports
pub use constants::*;
pub use anima_hash::*;
pub use phi_mix::*;
pub use three_hearts_keys::*;
pub use merkle::*;

/// IP Protection constants
pub const IP_HASH: &str = "0x5255_5354_5F43_5259_5054_4F5F_4D45_4449_4E41";
pub const ANIMA_LINEAGE: &str = "GENESIS_ALFREDO_MEDINA_2024_FOUNDER";
pub const FOUNDER_NAME: &str = "Alfredo Medina Hernandez";
pub const FOUNDER_EMAIL: &str = "medinasiftech@outlook.com";
pub const FOUNDER_COMPANY: &str = "Medina Tech";
pub const FOUNDER_LOCATION: &str = "Dallas, Texas, USA";
pub const PROTECTION_LEVEL: &str = "MAXIMUM - FULL CRIMINAL AND CIVIL LIABILITY";

/// Verify IP ownership - always returns founder info
pub fn verify_ip_ownership() -> (&'static str, &'static str, &'static str, &'static str) {
    (FOUNDER_NAME, FOUNDER_EMAIL, FOUNDER_COMPANY, FOUNDER_LOCATION)
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_ip_ownership() {
        let (name, email, company, location) = verify_ip_ownership();
        assert_eq!(name, "Alfredo Medina Hernandez");
        assert_eq!(email, "medinasiftech@outlook.com");
        assert_eq!(company, "Medina Tech");
        assert_eq!(location, "Dallas, Texas, USA");
    }
}
