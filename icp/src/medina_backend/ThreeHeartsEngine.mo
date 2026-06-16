/**
 * ThreeHeartsEngine Module — Freddy's Three Hearts System
 * 
 * MEDINA has Three Hearts, inter-coupled via K matrix:
 * 
 * HEART 1: METROPOLIS (Backend/Computation)
 *   - Frequency: 0.1 Hz (slow, deliberate)
 *   - Role: Backend computation, Core A truth processing
 *   - Governs: State evolution, RECITAL_PLUS_ONE, law enforcement
 * 
 * HEART 2: COUPLING (Resonance/Communication)  
 *   - Frequency: φ Hz (golden ratio)
 *   - Role: Heart-brain coupling, resonance calibration
 *   - Governs: Phase synchronization, CPL routing, memory consolidation
 * 
 * HEART 3: REGULATING (Full System/Orchestration)
 *   - Frequency: φ² Hz (phi squared)
 *   - Role: Full system orchestration, sovereign tick
 *   - Governs: All model execution, gate coordination, projection
 * 
 * PHASE COUPLING DYNAMICS (Kuramoto):
 *   d(θ_i)/dt = ω_i + Σ K_ij sin(θ_j - θ_i)
 * 
 * INTER-HEART COUPLING MATRIX K:
 *   K = [[K_11, K_12, K_13],
 *        [K_21, K_22, K_23],
 *        [K_31, K_32, K_33]]
 * 
 * Attribution: Freddy — Founder, Visionary, Architect of MEDINA
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";

module {
    // ================================================================== //
    // CONSTANTS                                                            //
    // ================================================================== //
    
    /// Golden ratio
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Heart 1 (Metropolis) frequency: 0.1 Hz
    public let OMEGA_METROPOLIS : Float = 0.1;
    
    /// Heart 2 (Coupling) frequency: φ Hz
    public let OMEGA_COUPLING : Float = PHI;
    
    /// Heart 3 (Regulating) frequency: φ² Hz
    public let OMEGA_REGULATING : Float = PHI * PHI;
    
    /// Time step for phase integration
    public let DT : Float = 1.0 / (PHI * 10.0);
    
    // ================================================================== //
    // HEART TYPES                                                          //
    // ================================================================== //
    
    /// Heart identifier
    public type HeartId = {
        #Metropolis;   // Heart 1 — Backend computation
        #Coupling;     // Heart 2 — Resonance
        #Regulating;   // Heart 3 — Orchestration
    };
    
    /// Individual heart state
    public type HeartState = {
        heart_id: HeartId;
        theta: Float;         // Phase angle ∈ [0, 2π)
        omega: Float;         // Natural frequency
        amplitude: Float;     // Beat strength [0, 1]
        beat_count: Nat;      // Total beats
        last_tick: Int;
    };
    
    /// Coupling matrix row
    public type CouplingRow = {
        k_metro: Float;    // Coupling to Metropolis
        k_couple: Float;   // Coupling to Coupling
        k_regulate: Float; // Coupling to Regulating
    };
    
    /// Full coupling matrix K
    public type CouplingMatrix = {
        metro_row: CouplingRow;      // How Metropolis couples
        coupling_row: CouplingRow;   // How Coupling couples
        regulating_row: CouplingRow; // How Regulating couples
    };
    
    /// Three Hearts coherence metrics
    public type CoherenceMetrics = {
        global_coherence: Float;        // |Σ e^(iθ)| / 3
        metro_coupling_sync: Float;     // Heart 1-2 sync
        coupling_regulating_sync: Float; // Heart 2-3 sync
        metro_regulating_sync: Float;   // Heart 1-3 sync
        mean_phase: Float;              // Average phase
        phase_variance: Float;          // Phase spread
    };
    
    /// Full Three Hearts state
    public type ThreeHeartsState = {
        var metropolis: HeartState;
        var coupling: HeartState;
        var regulating: HeartState;
        var K: CouplingMatrix;
        var global_beat: Nat;
        var coherence_history: [CoherenceMetrics];
        var created_at: Int;
    };
    
    // ================================================================== //
    // INITIALIZATION                                                       //
    // ================================================================== //
    
    /// Create initial heart state
    func initHeart(heart_id: HeartId, omega: Float) : HeartState {
        {
            heart_id = heart_id;
            theta = 0.0;
            omega = omega;
            amplitude = 1.0;
            beat_count = 0;
            last_tick = Time.now();
        }
    };
    
    /// Default coupling matrix — balanced inter-heart coupling
    public func defaultCouplingMatrix() : CouplingMatrix {
        // Metropolis receives strong coupling from both others
        let metroRow : CouplingRow = {
            k_metro = 0.0;    // Self-coupling is 0
            k_couple = 0.4;   // Strong coupling from Heart 2
            k_regulate = 0.3; // Moderate coupling from Heart 3
        };
        
        // Coupling heart bridges the other two
        let couplingRow : CouplingRow = {
            k_metro = 0.3;    // Moderate from Heart 1
            k_couple = 0.0;   // Self-coupling is 0
            k_regulate = 0.5; // Strong from Heart 3
        };
        
        // Regulating drives the whole system
        let regulatingRow : CouplingRow = {
            k_metro = 0.2;    // Lighter coupling to Heart 1
            k_couple = 0.4;   // Strong to Heart 2
            k_regulate = 0.0; // Self-coupling is 0
        };
        
        {
            metro_row = metroRow;
            coupling_row = couplingRow;
            regulating_row = regulatingRow;
        }
    };
    
    /// Initialize Three Hearts system
    public func init() : ThreeHeartsState {
        {
            var metropolis = initHeart(#Metropolis, OMEGA_METROPOLIS);
            var coupling = initHeart(#Coupling, OMEGA_COUPLING);
            var regulating = initHeart(#Regulating, OMEGA_REGULATING);
            var K = defaultCouplingMatrix();
            var global_beat = 0;
            var coherence_history = [];
            var created_at = Time.now();
        }
    };
    
    // ================================================================== //
    // PHASE DYNAMICS                                                       //
    // ================================================================== //
    
    /// Calculate phase coupling term for a heart
    /// d(θ_i)/dt = ω_i + Σ K_ij sin(θ_j - θ_i)
    func phaseCouplingTerm(
        theta_i: Float, 
        theta_metro: Float,
        theta_couple: Float,
        theta_regulate: Float,
        row: CouplingRow
    ) : Float {
        row.k_metro * Float.sin(theta_metro - theta_i) +
        row.k_couple * Float.sin(theta_couple - theta_i) +
        row.k_regulate * Float.sin(theta_regulate - theta_i)
    };
    
    /// Modulo for phase (keep in [0, 2π))
    func modulo2Pi(theta: Float) : Float {
        theta - Float.floor(theta / MatalkoICP.TAU) * MatalkoICP.TAU
    };
    
    /// Calculate pairwise phase synchronization
    func pairSync(theta1: Float, theta2: Float) : Float {
        let diff = theta2 - theta1;
        (1.0 + Float.cos(diff)) / 2.0
    };
    
    // ================================================================== //
    // TICK OPERATIONS                                                      //
    // ================================================================== //
    
    /// Execute one tick of the Three Hearts system
    /// Applies Kuramoto phase coupling dynamics
    public func tick(state: ThreeHeartsState) : ThreeHeartsState {
        let theta_m = state.metropolis.theta;
        let theta_c = state.coupling.theta;
        let theta_r = state.regulating.theta;
        
        // Calculate phase derivatives
        let d_theta_m = state.metropolis.omega + 
            phaseCouplingTerm(theta_m, theta_m, theta_c, theta_r, state.K.metro_row);
        let d_theta_c = state.coupling.omega +
            phaseCouplingTerm(theta_c, theta_m, theta_c, theta_r, state.K.coupling_row);
        let d_theta_r = state.regulating.omega +
            phaseCouplingTerm(theta_r, theta_m, theta_c, theta_r, state.K.regulating_row);
        
        // Integrate phases
        let new_theta_m = modulo2Pi(theta_m + DT * d_theta_m);
        let new_theta_c = modulo2Pi(theta_c + DT * d_theta_c);
        let new_theta_r = modulo2Pi(theta_r + DT * d_theta_r);
        
        // Detect beat (phase crossing zero from above)
        let metro_beat = new_theta_m < theta_m;
        let coupling_beat = new_theta_c < theta_c;
        let regulating_beat = new_theta_r < theta_r;
        
        // Update heart states
        state.metropolis := {
            heart_id = #Metropolis;
            theta = new_theta_m;
            omega = state.metropolis.omega;
            amplitude = state.metropolis.amplitude;
            beat_count = state.metropolis.beat_count + (if metro_beat then 1 else 0);
            last_tick = Time.now();
        };
        
        state.coupling := {
            heart_id = #Coupling;
            theta = new_theta_c;
            omega = state.coupling.omega;
            amplitude = state.coupling.amplitude;
            beat_count = state.coupling.beat_count + (if coupling_beat then 1 else 0);
            last_tick = Time.now();
        };
        
        state.regulating := {
            heart_id = #Regulating;
            theta = new_theta_r;
            omega = state.regulating.omega;
            amplitude = state.regulating.amplitude;
            beat_count = state.regulating.beat_count + (if regulating_beat then 1 else 0);
            last_tick = Time.now();
        };
        
        state.global_beat += 1;
        
        // Record coherence
        let metrics = calculateCoherence(state);
        let newHistory = Buffer.Buffer<CoherenceMetrics>(state.coherence_history.size() + 1);
        for (m in state.coherence_history.vals()) {
            newHistory.add(m);
        };
        newHistory.add(metrics);
        // Keep only last 100 entries
        if (newHistory.size() > 100) {
            let trimmed = Buffer.Buffer<CoherenceMetrics>(100);
            var i = newHistory.size() - 100;
            while (i < newHistory.size()) {
                trimmed.add(newHistory.get(i));
                i += 1;
            };
            state.coherence_history := Buffer.toArray(trimmed);
        } else {
            state.coherence_history := Buffer.toArray(newHistory);
        };
        
        state
    };
    
    /// Execute N ticks
    public func tickN(state: ThreeHeartsState, n: Nat) : ThreeHeartsState {
        var current = state;
        var i : Nat = 0;
        while (i < n) {
            current := tick(current);
            i += 1;
        };
        current
    };
    
    // ================================================================== //
    // COHERENCE CALCULATION                                                //
    // ================================================================== //
    
    /// Calculate full coherence metrics
    public func calculateCoherence(state: ThreeHeartsState) : CoherenceMetrics {
        let theta_m = state.metropolis.theta;
        let theta_c = state.coupling.theta;
        let theta_r = state.regulating.theta;
        
        // Global coherence (order parameter)
        // r = |Σ e^(iθ)| / N = √[(Σcos θ)² + (Σsin θ)²] / N
        let cos_sum = Float.cos(theta_m) + Float.cos(theta_c) + Float.cos(theta_r);
        let sin_sum = Float.sin(theta_m) + Float.sin(theta_c) + Float.sin(theta_r);
        let global = Float.sqrt(cos_sum * cos_sum + sin_sum * sin_sum) / 3.0;
        
        // Pairwise synchronizations
        let mc_sync = pairSync(theta_m, theta_c);
        let cr_sync = pairSync(theta_c, theta_r);
        let mr_sync = pairSync(theta_m, theta_r);
        
        // Mean phase
        let mean = (theta_m + theta_c + theta_r) / 3.0;
        
        // Phase variance
        let var_m = (theta_m - mean) * (theta_m - mean);
        let var_c = (theta_c - mean) * (theta_c - mean);
        let var_r = (theta_r - mean) * (theta_r - mean);
        let variance = (var_m + var_c + var_r) / 3.0;
        
        {
            global_coherence = global;
            metro_coupling_sync = mc_sync;
            coupling_regulating_sync = cr_sync;
            metro_regulating_sync = mr_sync;
            mean_phase = mean;
            phase_variance = variance;
        }
    };
    
    // ================================================================== //
    // COUPLING ADJUSTMENT                                                  //
    // ================================================================== //
    
    /// Adjust coupling strength between two hearts
    public func adjustCoupling(
        state: ThreeHeartsState,
        from: HeartId,
        to: HeartId,
        newK: Float
    ) : ThreeHeartsState {
        let clampedK = Float.max(0.0, Float.min(1.0, newK));
        
        switch (from) {
            case (#Metropolis) {
                switch (to) {
                    case (#Coupling) {
                        state.K := {
                            metro_row = state.K.metro_row;
                            coupling_row = {
                                k_metro = clampedK;
                                k_couple = state.K.coupling_row.k_couple;
                                k_regulate = state.K.coupling_row.k_regulate;
                            };
                            regulating_row = state.K.regulating_row;
                        };
                    };
                    case (#Regulating) {
                        state.K := {
                            metro_row = state.K.metro_row;
                            coupling_row = state.K.coupling_row;
                            regulating_row = {
                                k_metro = clampedK;
                                k_couple = state.K.regulating_row.k_couple;
                                k_regulate = state.K.regulating_row.k_regulate;
                            };
                        };
                    };
                    case (#Metropolis) {};
                };
            };
            case (#Coupling) {
                switch (to) {
                    case (#Metropolis) {
                        state.K := {
                            metro_row = {
                                k_metro = state.K.metro_row.k_metro;
                                k_couple = clampedK;
                                k_regulate = state.K.metro_row.k_regulate;
                            };
                            coupling_row = state.K.coupling_row;
                            regulating_row = state.K.regulating_row;
                        };
                    };
                    case (#Regulating) {
                        state.K := {
                            metro_row = state.K.metro_row;
                            coupling_row = state.K.coupling_row;
                            regulating_row = {
                                k_metro = state.K.regulating_row.k_metro;
                                k_couple = clampedK;
                                k_regulate = state.K.regulating_row.k_regulate;
                            };
                        };
                    };
                    case (#Coupling) {};
                };
            };
            case (#Regulating) {
                switch (to) {
                    case (#Metropolis) {
                        state.K := {
                            metro_row = {
                                k_metro = state.K.metro_row.k_metro;
                                k_couple = state.K.metro_row.k_couple;
                                k_regulate = clampedK;
                            };
                            coupling_row = state.K.coupling_row;
                            regulating_row = state.K.regulating_row;
                        };
                    };
                    case (#Coupling) {
                        state.K := {
                            metro_row = state.K.metro_row;
                            coupling_row = {
                                k_metro = state.K.coupling_row.k_metro;
                                k_couple = state.K.coupling_row.k_couple;
                                k_regulate = clampedK;
                            };
                            regulating_row = state.K.regulating_row;
                        };
                    };
                    case (#Regulating) {};
                };
            };
        };
        state
    };
    
    // ================================================================== //
    // STATUS                                                               //
    // ================================================================== //
    
    /// Get full Three Hearts status
    public func status(state: ThreeHeartsState) : {
        global_beat: Nat;
        metropolis: { theta: Float; omega: Float; beats: Nat };
        coupling: { theta: Float; omega: Float; beats: Nat };
        regulating: { theta: Float; omega: Float; beats: Nat };
        coherence: CoherenceMetrics;
    } {
        {
            global_beat = state.global_beat;
            metropolis = {
                theta = state.metropolis.theta;
                omega = state.metropolis.omega;
                beats = state.metropolis.beat_count;
            };
            coupling = {
                theta = state.coupling.theta;
                omega = state.coupling.omega;
                beats = state.coupling.beat_count;
            };
            regulating = {
                theta = state.regulating.theta;
                omega = state.regulating.omega;
                beats = state.regulating.beat_count;
            };
            coherence = calculateCoherence(state);
        }
    };
}
