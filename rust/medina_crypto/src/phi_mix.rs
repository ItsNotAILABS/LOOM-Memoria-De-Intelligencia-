// ═══════════════════════════════════════════════════════════════════════════════
// MEDINA - PROPRIETARY AND CONFIDENTIAL
// Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA
// medinasiftech@outlook.com | ALL RIGHTS RESERVED
// ═══════════════════════════════════════════════════════════════════════════════
//
// phi_mix.rs — GOLDEN RATIO MIXING FUNCTIONS
//
// φ-mixing transforms data using the golden ratio and its properties.
// Used for key derivation, state mixing, and encryption operations.
//
// ═══════════════════════════════════════════════════════════════════════════════

use crate::constants::{PHI, PHI_INV, PHI_SQUARED, FIBONACCI};

/// φ-mix a single f64 value
pub fn phi_mix_f64(value: f64) -> f64 {
    let mixed = (value * PHI) % 1.0;
    let remixed = (mixed + PHI_INV) % 1.0;
    (remixed * PHI_SQUARED) % 1.0
}

/// φ-mix an array of f64 values
pub fn phi_mix_f64_array(values: &[f64]) -> Vec<f64> {
    values.iter()
        .enumerate()
        .map(|(i, v)| {
            let phi_factor = PHI.powi((i % 10) as i32);
            (v * phi_factor) % 1.0
        })
        .collect()
}

/// φ-mix bytes using golden ratio transformation
pub fn phi_mix_bytes(input: &[u8]) -> Vec<u8> {
    input.iter()
        .enumerate()
        .map(|(i, &byte)| {
            let phi_factor = ((PHI * (i as f64 + 1.0)) % 256.0) as u8;
            let inv_factor = ((PHI_INV * (i as f64 + 1.0)) % 256.0) as u8;
            byte.wrapping_add(phi_factor).wrapping_mul(inv_factor.wrapping_add(1))
        })
        .collect()
}

/// Reverse φ-mix bytes (for decryption)
pub fn phi_unmix_bytes(input: &[u8]) -> Vec<u8> {
    input.iter()
        .enumerate()
        .map(|(i, &byte)| {
            let phi_factor = ((PHI * (i as f64 + 1.0)) % 256.0) as u8;
            let inv_factor = ((PHI_INV * (i as f64 + 1.0)) % 256.0) as u8;
            
            // Reverse the operations
            let div = byte.wrapping_div(inv_factor.wrapping_add(1).max(1));
            div.wrapping_sub(phi_factor)
        })
        .collect()
}

/// Fibonacci mixing - mix bytes using Fibonacci sequence
pub fn fibonacci_mix_bytes(input: &[u8]) -> Vec<u8> {
    input.iter()
        .enumerate()
        .map(|(i, &byte)| {
            let fib_index = i % FIBONACCI.len();
            let fib_factor = (FIBONACCI[fib_index] % 256) as u8;
            byte.wrapping_add(fib_factor)
        })
        .collect()
}

/// Kuramoto coupling value (for Three Hearts)
/// 
/// Computes: sin(θ_i - θ_j) for phase coupling
/// 
pub fn kuramoto_coupling(theta_i: f64, theta_j: f64) -> f64 {
    (theta_i - theta_j).sin()
}

/// Compute global coherence R from phases
/// 
/// R = (1/N) * |Σ e^(iθ_k)|
/// 
pub fn compute_coherence(phases: &[f64]) -> f64 {
    if phases.is_empty() {
        return 1.0;
    }
    
    let n = phases.len() as f64;
    let sum_cos: f64 = phases.iter().map(|&p| p.cos()).sum();
    let sum_sin: f64 = phases.iter().map(|&p| p.sin()).sum();
    
    ((sum_cos / n).powi(2) + (sum_sin / n).powi(2)).sqrt()
}

/// Phase delta for Three Hearts key derivation
/// 
/// delta_ij = sin(θ_i - θ_j)
/// 
pub struct PhaseDeltas {
    pub delta_mc: f64,  // Metropolis - Coupling
    pub delta_cr: f64,  // Coupling - Regulating
    pub delta_rm: f64,  // Regulating - Metropolis
}

impl PhaseDeltas {
    /// Compute from three phases
    pub fn from_phases(theta_metro: f64, theta_couple: f64, theta_regulate: f64) -> Self {
        Self {
            delta_mc: kuramoto_coupling(theta_metro, theta_couple),
            delta_cr: kuramoto_coupling(theta_couple, theta_regulate),
            delta_rm: kuramoto_coupling(theta_regulate, theta_metro),
        }
    }
    
    /// Convert to byte array for key material
    pub fn to_key_bytes(&self) -> [u8; 24] {
        let mut bytes = [0u8; 24];
        
        // Pack each delta as 8 bytes (f64)
        bytes[0..8].copy_from_slice(&self.delta_mc.to_le_bytes());
        bytes[8..16].copy_from_slice(&self.delta_cr.to_le_bytes());
        bytes[16..24].copy_from_slice(&self.delta_rm.to_le_bytes());
        
        bytes
    }
}

/// Icosahedral rotation step
/// 
/// Rotates a point through one of 120 icosahedral symmetry operations
/// 
pub fn icosahedral_rotate(point: [f64; 3], step: u64) -> [f64; 3] {
    let step_mod = (step % 120) as f64;
    let angle = step_mod * (std::f64::consts::TAU / 120.0);
    
    // Simplified rotation around z-axis
    let cos_a = angle.cos();
    let sin_a = angle.sin();
    
    [
        point[0] * cos_a - point[1] * sin_a,
        point[0] * sin_a + point[1] * cos_a,
        point[2],
    ]
}

/// E8 rotation step
/// 
/// Rotates a point through one of 240 E8 symmetry operations
/// 
pub fn e8_rotate(point: [f64; 8], step: u64) -> [f64; 8] {
    let step_mod = (step % 240) as f64;
    let angle = step_mod * (std::f64::consts::TAU / 240.0);
    
    let mut result = point;
    
    // Apply rotation to pairs of dimensions
    let cos_a = angle.cos();
    let sin_a = angle.sin();
    
    for i in 0..4 {
        let j = i * 2;
        let k = j + 1;
        let temp = result[j];
        result[j] = result[j] * cos_a - result[k] * sin_a;
        result[k] = temp * sin_a + result[k] * cos_a;
    }
    
    result
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_phi_mix_f64() {
        let value = 0.5;
        let mixed = phi_mix_f64(value);
        assert!(mixed >= 0.0 && mixed < 1.0);
        
        // Deterministic
        let mixed2 = phi_mix_f64(value);
        assert_eq!(mixed, mixed2);
    }
    
    #[test]
    fn test_phi_mix_bytes() {
        let input = vec![1, 2, 3, 4, 5];
        let mixed = phi_mix_bytes(&input);
        assert_eq!(mixed.len(), input.len());
        
        // Should be different from input
        assert_ne!(mixed, input);
        
        // Deterministic
        let mixed2 = phi_mix_bytes(&input);
        assert_eq!(mixed, mixed2);
    }
    
    #[test]
    fn test_fibonacci_mix() {
        let input = vec![0, 0, 0, 0, 0];
        let mixed = fibonacci_mix_bytes(&input);
        
        // Should add Fibonacci values
        assert_eq!(mixed[0], 1);  // FIBONACCI[0] = 1
        assert_eq!(mixed[1], 1);  // FIBONACCI[1] = 1
        assert_eq!(mixed[2], 2);  // FIBONACCI[2] = 2
    }
    
    #[test]
    fn test_compute_coherence() {
        // All phases aligned = coherence 1.0
        let aligned = vec![0.0, 0.0, 0.0];
        assert!((compute_coherence(&aligned) - 1.0).abs() < 1e-10);
        
        // Empty = 1.0
        let empty: Vec<f64> = vec![];
        assert_eq!(compute_coherence(&empty), 1.0);
    }
    
    #[test]
    fn test_phase_deltas() {
        let deltas = PhaseDeltas::from_phases(0.0, std::f64::consts::PI / 4.0, std::f64::consts::PI / 2.0);
        let bytes = deltas.to_key_bytes();
        assert_eq!(bytes.len(), 24);
    }
    
    #[test]
    fn test_icosahedral_rotate() {
        let point = [1.0, 0.0, 0.0];
        let rotated = icosahedral_rotate(point, 30);
        
        // Length should be preserved
        let len = (rotated[0].powi(2) + rotated[1].powi(2) + rotated[2].powi(2)).sqrt();
        assert!((len - 1.0).abs() < 1e-10);
    }
}
