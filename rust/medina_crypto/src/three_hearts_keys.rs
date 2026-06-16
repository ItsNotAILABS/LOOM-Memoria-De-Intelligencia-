// ═══════════════════════════════════════════════════════════════════════════════
// MEDINA - PROPRIETARY AND CONFIDENTIAL
// Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA
// medinasiftech@outlook.com | ALL RIGHTS RESERVED
// ═══════════════════════════════════════════════════════════════════════════════
//
// three_hearts_keys.rs — THREE HEARTS KEY DERIVATION
//
// Key derivation based on Three Hearts phase coupling:
//   - Heart 1 (Metropolis): 0.1 Hz
//   - Heart 2 (Coupling): φ Hz
//   - Heart 3 (Regulating): φ² Hz
//
// Keys are derived from phase differences using Kuramoto coupling.
//
// ═══════════════════════════════════════════════════════════════════════════════

use sha2::{Sha256, Digest};
use crate::constants::{
    PHI, PHI_INV, PHI_SQUARED,
    METROPOLIS_FREQUENCY, COUPLING_FREQUENCY, REGULATING_FREQUENCY,
    ICOSAHEDRAL_THRESHOLD, E8_THRESHOLD, LEECH_THRESHOLD,
    KEY_ROTATION_INTERVAL_MS,
};
use crate::anima_hash::{anima_hash, AnimaHash};
use crate::phi_mix::{PhaseDeltas, kuramoto_coupling, compute_coherence};

/// Key tier based on coherence
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum KeyTier {
    Survival,      // R < 0.618
    Icosahedral,   // 0.618 ≤ R < 0.854
    E8,            // 0.854 ≤ R < 0.927
    Leech,         // R ≥ 0.927
}

impl KeyTier {
    /// Get tier from coherence value
    pub fn from_coherence(r: f64) -> Self {
        if r >= LEECH_THRESHOLD {
            KeyTier::Leech
        } else if r >= E8_THRESHOLD {
            KeyTier::E8
        } else if r >= ICOSAHEDRAL_THRESHOLD {
            KeyTier::Icosahedral
        } else {
            KeyTier::Survival
        }
    }
    
    /// Get rotation steps for this tier
    pub fn rotation_steps(&self) -> u64 {
        match self {
            KeyTier::Survival => 3,
            KeyTier::Icosahedral => 120,
            KeyTier::E8 => 240,
            KeyTier::Leech => 196_560,
        }
    }
    
    /// Get chain depth for this tier
    pub fn chain_depth(&self) -> u64 {
        match self {
            KeyTier::Survival => 3,
            KeyTier::Icosahedral => 12,
            KeyTier::E8 => 21,
            KeyTier::Leech => 55,
        }
    }
}

/// Three Hearts state
#[derive(Clone, Debug)]
pub struct ThreeHeartsState {
    pub theta_metro: f64,    // Metropolis phase
    pub theta_couple: f64,   // Coupling phase
    pub theta_regulate: f64, // Regulating phase
    pub time_ns: u64,        // Current time in nanoseconds
}

impl ThreeHeartsState {
    /// Create new state at given time
    pub fn new(time_ns: u64) -> Self {
        // Initialize phases based on time
        let t = time_ns as f64 / 1_000_000_000.0;  // Convert to seconds
        
        Self {
            theta_metro: (t * METROPOLIS_FREQUENCY * 2.0 * std::f64::consts::PI) % (2.0 * std::f64::consts::PI),
            theta_couple: (t * COUPLING_FREQUENCY * 2.0 * std::f64::consts::PI) % (2.0 * std::f64::consts::PI),
            theta_regulate: (t * REGULATING_FREQUENCY * 2.0 * std::f64::consts::PI) % (2.0 * std::f64::consts::PI),
            time_ns,
        }
    }
    
    /// Advance state by dt nanoseconds
    pub fn advance(&mut self, dt_ns: u64) {
        let dt = dt_ns as f64 / 1_000_000_000.0;
        
        self.theta_metro = (self.theta_metro + dt * METROPOLIS_FREQUENCY * 2.0 * std::f64::consts::PI) 
            % (2.0 * std::f64::consts::PI);
        self.theta_couple = (self.theta_couple + dt * COUPLING_FREQUENCY * 2.0 * std::f64::consts::PI)
            % (2.0 * std::f64::consts::PI);
        self.theta_regulate = (self.theta_regulate + dt * REGULATING_FREQUENCY * 2.0 * std::f64::consts::PI)
            % (2.0 * std::f64::consts::PI);
        self.time_ns += dt_ns;
    }
    
    /// Get phase deltas
    pub fn get_deltas(&self) -> PhaseDeltas {
        PhaseDeltas::from_phases(self.theta_metro, self.theta_couple, self.theta_regulate)
    }
    
    /// Get global coherence
    pub fn get_coherence(&self) -> f64 {
        compute_coherence(&[self.theta_metro, self.theta_couple, self.theta_regulate])
    }
    
    /// Get current key tier
    pub fn get_tier(&self) -> KeyTier {
        KeyTier::from_coherence(self.get_coherence())
    }
}

/// Derived key from Three Hearts
#[derive(Clone, Debug)]
pub struct ThreeHeartsKey {
    pub key_bytes: [u8; 32],
    pub tier: KeyTier,
    pub coherence: f64,
    pub rotation_step: u64,
    pub created_at_ns: u64,
}

impl ThreeHeartsKey {
    /// Derive key from Three Hearts state
    pub fn derive(state: &ThreeHeartsState, context: &[u8]) -> Self {
        let coherence = state.get_coherence();
        let tier = KeyTier::from_coherence(coherence);
        let deltas = state.get_deltas();
        
        // Calculate rotation step
        let rotation_period_ns = KEY_ROTATION_INTERVAL_MS * 1_000_000;
        let rotation_step = (state.time_ns / rotation_period_ns) % tier.rotation_steps();
        
        // Derive key material
        let mut key_material = Vec::new();
        
        // Include phase deltas
        key_material.extend_from_slice(&deltas.to_key_bytes());
        
        // Include coherence
        key_material.extend_from_slice(&coherence.to_le_bytes());
        
        // Include tier
        key_material.push(tier as u8);
        
        // Include rotation step
        key_material.extend_from_slice(&rotation_step.to_le_bytes());
        
        // Include context
        key_material.extend_from_slice(context);
        
        // Hash to derive final key
        let hash = anima_hash(&key_material);
        
        Self {
            key_bytes: hash.bytes,
            tier,
            coherence,
            rotation_step,
            created_at_ns: state.time_ns,
        }
    }
    
    /// Check if key is still valid (hasn't rotated)
    pub fn is_valid(&self, current_time_ns: u64) -> bool {
        let rotation_period_ns = KEY_ROTATION_INTERVAL_MS * 1_000_000;
        let current_step = (current_time_ns / rotation_period_ns) % self.tier.rotation_steps();
        current_step == self.rotation_step
    }
    
    /// Get time until key rotation (in milliseconds)
    pub fn time_until_rotation(&self, current_time_ns: u64) -> u64 {
        let rotation_period_ns = KEY_ROTATION_INTERVAL_MS * 1_000_000;
        let next_rotation = ((current_time_ns / rotation_period_ns) + 1) * rotation_period_ns;
        (next_rotation - current_time_ns) / 1_000_000
    }
}

/// Key manager for continuous key rotation
pub struct ThreeHeartsKeyManager {
    state: ThreeHeartsState,
    current_key: Option<ThreeHeartsKey>,
    context: Vec<u8>,
}

impl ThreeHeartsKeyManager {
    /// Create new key manager
    pub fn new(initial_time_ns: u64, context: &[u8]) -> Self {
        Self {
            state: ThreeHeartsState::new(initial_time_ns),
            current_key: None,
            context: context.to_vec(),
        }
    }
    
    /// Update state and potentially rotate key
    pub fn update(&mut self, current_time_ns: u64) -> &ThreeHeartsKey {
        // Advance state
        if current_time_ns > self.state.time_ns {
            self.state.advance(current_time_ns - self.state.time_ns);
        }
        
        // Check if we need a new key
        let need_new_key = match &self.current_key {
            None => true,
            Some(key) => !key.is_valid(current_time_ns),
        };
        
        if need_new_key {
            self.current_key = Some(ThreeHeartsKey::derive(&self.state, &self.context));
        }
        
        self.current_key.as_ref().unwrap()
    }
    
    /// Get current coherence
    pub fn get_coherence(&self) -> f64 {
        self.state.get_coherence()
    }
    
    /// Get current tier
    pub fn get_tier(&self) -> KeyTier {
        self.state.get_tier()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_key_tier_from_coherence() {
        assert_eq!(KeyTier::from_coherence(0.5), KeyTier::Survival);
        assert_eq!(KeyTier::from_coherence(0.7), KeyTier::Icosahedral);
        assert_eq!(KeyTier::from_coherence(0.9), KeyTier::E8);
        assert_eq!(KeyTier::from_coherence(0.95), KeyTier::Leech);
    }
    
    #[test]
    fn test_three_hearts_state() {
        let state = ThreeHeartsState::new(0);
        assert_eq!(state.theta_metro, 0.0);
        assert_eq!(state.theta_couple, 0.0);
        assert_eq!(state.theta_regulate, 0.0);
        
        let coherence = state.get_coherence();
        assert!((coherence - 1.0).abs() < 1e-10);
    }
    
    #[test]
    fn test_key_derivation() {
        let state = ThreeHeartsState::new(1_000_000_000);  // 1 second
        let key = ThreeHeartsKey::derive(&state, b"test context");
        
        assert_eq!(key.key_bytes.len(), 32);
        assert!(key.coherence >= 0.0 && key.coherence <= 1.0);
    }
    
    #[test]
    fn test_key_deterministic() {
        let state = ThreeHeartsState::new(1_000_000_000);
        let key1 = ThreeHeartsKey::derive(&state, b"context");
        let key2 = ThreeHeartsKey::derive(&state, b"context");
        
        assert_eq!(key1.key_bytes, key2.key_bytes);
    }
    
    #[test]
    fn test_key_manager() {
        let mut manager = ThreeHeartsKeyManager::new(0, b"test");
        
        let key1 = manager.update(0);
        let key1_bytes = key1.key_bytes;
        
        // Same time should give same key
        let key2 = manager.update(0);
        assert_eq!(key1_bytes, key2.key_bytes);
    }
}
