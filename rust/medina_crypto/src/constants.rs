// ═══════════════════════════════════════════════════════════════════════════════
// MEDINA - PROPRIETARY AND CONFIDENTIAL
// Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA
// medinasiftech@outlook.com | ALL RIGHTS RESERVED
// ═══════════════════════════════════════════════════════════════════════════════
//
// constants.rs — FUNDAMENTAL φ-NATIVE CONSTANTS
//
// ═══════════════════════════════════════════════════════════════════════════════

/// ANIMA lineage identifier (immutable founder chain)
pub const ANIMA_LINEAGE: &str = "GENESIS_ALFREDO_MEDINA_2024_FOUNDER";

/// Golden ratio φ
pub const PHI: f64 = 1.618033988749895;

/// Inverse golden ratio 1/φ
pub const PHI_INV: f64 = 0.618033988749895;

/// Golden ratio squared φ²
pub const PHI_SQUARED: f64 = 2.618033988749895;

/// Golden ratio cubed φ³
pub const PHI_CUBED: f64 = 4.236067977499790;

/// φ⁴
pub const PHI_4: f64 = 6.854101966249685;

/// φ⁵
pub const PHI_5: f64 = 11.090169943749474;

/// Schumann resonance (Earth's fundamental frequency)
pub const SCHUMANN: f64 = 7.83;

/// Sovereign frequency (Schumann × φ)
pub const SOVEREIGN_FREQUENCY: f64 = 12.6705;

/// Tau (2π)
pub const TAU: f64 = 6.283185307179586;

/// Pi
pub const PI: f64 = 3.141592653589793;

/// Fibonacci sequence for chain depths
pub const FIBONACCI: [u64; 16] = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987];

/// ANIMA chain depths (Fibonacci-based)
pub const SURVIVAL_DEPTH: u64 = 3;
pub const ICOSAHEDRAL_DEPTH: u64 = 12;
pub const E8_DEPTH: u64 = 21;
pub const LEECH_DEPTH: u64 = 55;

/// Key rotation geometry
pub const ICOSAHEDRAL_STEPS: u64 = 120;
pub const E8_STEPS: u64 = 240;
pub const LEECH_STEPS: u64 = 196_560;

/// Coherence thresholds
pub const SURVIVAL_THRESHOLD: f64 = 0.0;
pub const ICOSAHEDRAL_THRESHOLD: f64 = 0.618;
pub const E8_THRESHOLD: f64 = 0.854;
pub const LEECH_THRESHOLD: f64 = 0.927;

/// Three Hearts frequencies
pub const METROPOLIS_FREQUENCY: f64 = 0.1;  // 0.1 Hz
pub const COUPLING_FREQUENCY: f64 = PHI;     // φ Hz
pub const REGULATING_FREQUENCY: f64 = PHI_SQUARED; // φ² Hz

/// Key rotation interval (milliseconds)
pub const KEY_ROTATION_INTERVAL_MS: u64 = 873;

/// Get PHI power
pub fn phi_power(n: u32) -> f64 {
    PHI.powi(n as i32)
}

/// Get inverse PHI power
pub fn phi_inv_power(n: u32) -> f64 {
    PHI_INV.powi(n as i32)
}

/// Calculate Fibonacci number
pub fn fibonacci(n: usize) -> u64 {
    if n < FIBONACCI.len() {
        FIBONACCI[n]
    } else {
        // Calculate for larger n
        let mut a = FIBONACCI[FIBONACCI.len() - 2];
        let mut b = FIBONACCI[FIBONACCI.len() - 1];
        for _ in FIBONACCI.len()..=n {
            let c = a + b;
            a = b;
            b = c;
        }
        b
    }
}

/// Get chain depth tier based on coherence
pub fn get_depth_tier(coherence: f64) -> u64 {
    if coherence >= LEECH_THRESHOLD {
        LEECH_DEPTH
    } else if coherence >= E8_THRESHOLD {
        E8_DEPTH
    } else if coherence >= ICOSAHEDRAL_THRESHOLD {
        ICOSAHEDRAL_DEPTH
    } else {
        SURVIVAL_DEPTH
    }
}

/// Get rotation steps based on coherence
pub fn get_rotation_steps(coherence: f64) -> u64 {
    if coherence >= LEECH_THRESHOLD {
        LEECH_STEPS
    } else if coherence >= E8_THRESHOLD {
        E8_STEPS
    } else {
        ICOSAHEDRAL_STEPS
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_phi_properties() {
        // φ² = φ + 1
        assert!((PHI_SQUARED - (PHI + 1.0)).abs() < 1e-10);
        
        // 1/φ = φ - 1
        assert!((PHI_INV - (PHI - 1.0)).abs() < 1e-10);
    }
    
    #[test]
    fn test_fibonacci() {
        assert_eq!(fibonacci(0), 1);
        assert_eq!(fibonacci(1), 1);
        assert_eq!(fibonacci(2), 2);
        assert_eq!(fibonacci(6), 13);
        assert_eq!(fibonacci(9), 55);
    }
    
    #[test]
    fn test_depth_tiers() {
        assert_eq!(get_depth_tier(0.5), SURVIVAL_DEPTH);
        assert_eq!(get_depth_tier(0.7), ICOSAHEDRAL_DEPTH);
        assert_eq!(get_depth_tier(0.9), E8_DEPTH);
        assert_eq!(get_depth_tier(0.95), LEECH_DEPTH);
    }
}
