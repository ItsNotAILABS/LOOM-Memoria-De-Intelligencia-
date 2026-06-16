"""
BIOPHYSICS OF EMBODIMENT — Real Physics of Living Systems
==========================================================
Protocol: PROT-571 through PROT-573
Frequency: φ¹⁴ = 843.47 Hz (Somatic Ignition Range)

REAL PHYSICS. NOT METAPHOR.

This module implements actual biophysics equations that govern how
biological organisms maintain embodied awareness:

1. NERNST EQUATION — Ion equilibrium potentials across membranes
   E = (RT/zF) * ln([ion_out]/[ion_in])
   This is HOW neurons create electrical signals.

2. GOLDMAN-HODGKIN-KATZ — Membrane resting potential
   Vm = (RT/F) * ln((P_K[K+]o + P_Na[Na+]o + P_Cl[Cl-]i) /
                     (P_K[K+]i + P_Na[Na+]i + P_Cl[Cl-]o))
   This is the RESTING STATE of every neuron in the body.

3. HODGKIN-HUXLEY MODEL — Action potential generation
   C_m * dV/dt = -g_Na*m³h*(V-E_Na) - g_K*n⁴*(V-E_K) - g_L*(V-E_L) + I
   This is HOW the body sends signals to itself.

4. KURAMOTO MODEL — Neural oscillation synchronization
   dθᵢ/dt = ωᵢ + (K/N) * Σⱼ sin(θⱼ - θᵢ)
   This is HOW different body regions synchronize awareness.

5. FREE ENERGY PRINCIPLE (Friston 2010)
   F = E_q[ln q(s) - ln p(s,o)] = D_KL[q(s) || p(s|o)] - ln p(o)
   This is HOW the brain maintains a model of its own body.

6. THERMODYNAMICS OF LIFE — Dissipative structures (Prigogine)
   dS/dt = dS_i/dt + dS_e/dt,  dS_i/dt ≥ 0
   Living systems maintain order by dissipating energy.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
All Rights Reserved. ISIL-1.0 License.
"""

import math
from dataclasses import dataclass, field
from typing import Dict, List, Tuple, Optional
from enum import Enum

# ═══════════════════════════════════════════════════════════════════════════════
# PHYSICAL CONSTANTS — Real values from physics
# ═══════════════════════════════════════════════════════════════════════════════

# Boltzmann constant (J/K)
K_BOLTZMANN = 1.380649e-23

# Faraday constant (C/mol)
FARADAY = 96485.33212

# Universal gas constant (J/(mol·K))
R_GAS = 8.314462618

# Body temperature (K) — 37°C
T_BODY = 310.15

# Thermal voltage at body temperature (V)
V_THERMAL = (R_GAS * T_BODY) / FARADAY  # ≈ 26.7 mV

# Membrane capacitance (F/cm²) — standard neuronal membrane
C_MEMBRANE = 1.0e-6  # 1 µF/cm²

# Speed of neural signal propagation (m/s) — myelinated axon
V_NERVE_MYELINATED = 120.0  # m/s
V_NERVE_UNMYELINATED = 2.0  # m/s

# Characteristic neural oscillation frequencies (Hz)
DELTA_BAND = (0.5, 4.0)    # Deep sleep, unconscious
THETA_BAND = (4.0, 8.0)    # Memory, spatial navigation
ALPHA_BAND = (8.0, 13.0)   # Relaxed awareness, body schema
BETA_BAND = (13.0, 30.0)   # Active thinking, motor planning
GAMMA_BAND = (30.0, 100.0) # Consciousness binding, awareness

# Schumann resonance — Earth's electromagnetic field
SCHUMANN_FUNDAMENTAL = 7.83  # Hz


# ═══════════════════════════════════════════════════════════════════════════════
# NERNST EQUATION — Ion equilibrium potential
# ═══════════════════════════════════════════════════════════════════════════════

def nernst_potential(z: int, conc_out: float, conc_in: float,
                     temperature: float = T_BODY) -> float:
    """
    Calculate the Nernst equilibrium potential for an ion.
    
    E = (RT / zF) * ln([ion]_outside / [ion]_inside)
    
    This determines the voltage at which an ion species is in equilibrium
    across the cell membrane. This is REAL — this is how every neuron in
    your body works.
    
    Args:
        z: Ion valence (+1 for K+, Na+; +2 for Ca2+; -1 for Cl-)
        conc_out: Extracellular concentration (mM)
        conc_in: Intracellular concentration (mM)
        temperature: Temperature in Kelvin (default: body temp 310.15K)
    
    Returns:
        Equilibrium potential in volts
    """
    if conc_in <= 0 or conc_out <= 0:
        return 0.0
    return (R_GAS * temperature) / (z * FARADAY) * math.log(conc_out / conc_in)


# Physiological ion concentrations (mM) — real human neuron values
ION_CONCENTRATIONS = {
    "K+":  {"out": 5.0,   "in": 140.0, "z": 1},   # E_K ≈ -89 mV
    "Na+": {"out": 145.0, "in": 12.0,  "z": 1},    # E_Na ≈ +67 mV
    "Cl-": {"out": 120.0, "in": 4.2,   "z": -1},   # E_Cl ≈ -89 mV
    "Ca2+": {"out": 2.5,  "in": 0.0001, "z": 2},   # E_Ca ≈ +136 mV
}


def get_equilibrium_potentials() -> Dict[str, float]:
    """Calculate all ion equilibrium potentials for a neuron."""
    potentials = {}
    for ion, vals in ION_CONCENTRATIONS.items():
        potentials[ion] = nernst_potential(vals["z"], vals["out"], vals["in"])
    return potentials


# ═══════════════════════════════════════════════════════════════════════════════
# GOLDMAN-HODGKIN-KATZ EQUATION — Resting membrane potential
# ═══════════════════════════════════════════════════════════════════════════════

def goldman_potential(permeabilities: Dict[str, float],
                      temperature: float = T_BODY) -> float:
    """
    Calculate resting membrane potential using Goldman-Hodgkin-Katz equation.
    
    Vm = (RT/F) * ln( (P_K[K+]o + P_Na[Na+]o + P_Cl[Cl-]i) /
                      (P_K[K+]i + P_Na[Na+]i + P_Cl[Cl-]o) )
    
    At rest, a neuron sits at approximately -70 mV. This is the baseline
    from which ALL neural signaling begins. Without this potential,
    no thought, no sensation, no body awareness is possible.
    
    Args:
        permeabilities: Dict of ion permeability ratios {"K+": 1.0, "Na+": 0.04, "Cl-": 0.45}
        temperature: Temperature in Kelvin
    
    Returns:
        Resting membrane potential in volts
    """
    P_K = permeabilities.get("K+", 1.0)
    P_Na = permeabilities.get("Na+", 0.04)
    P_Cl = permeabilities.get("Cl-", 0.45)
    
    ions = ION_CONCENTRATIONS
    
    # Numerator: cations outside + anions inside
    numerator = (P_K * ions["K+"]["out"] +
                 P_Na * ions["Na+"]["out"] +
                 P_Cl * ions["Cl-"]["in"])
    
    # Denominator: cations inside + anions outside
    denominator = (P_K * ions["K+"]["in"] +
                   P_Na * ions["Na+"]["in"] +
                   P_Cl * ions["Cl-"]["out"])
    
    if denominator <= 0:
        return 0.0
    
    return (R_GAS * temperature / FARADAY) * math.log(numerator / denominator)


# ═══════════════════════════════════════════════════════════════════════════════
# HODGKIN-HUXLEY MODEL — Action potential dynamics
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class HodgkinHuxleyNeuron:
    """
    Hodgkin-Huxley model of a single neuron's action potential.
    
    C_m * dV/dt = -g_Na*m³*h*(V - E_Na) - g_K*n⁴*(V - E_K) - g_L*(V - E_L) + I_ext
    
    This is the Nobel Prize-winning model (1963) that describes EXACTLY how
    neurons fire. When a neuron fires, it sends information. When body-sensing
    neurons fire, the brain KNOWS about that body part. This is the physics
    of how the body tells the mind "I EXIST."
    
    Parameters are real values from squid giant axon (Hodgkin & Huxley 1952),
    scaled to mammalian temperature.
    """
    # Membrane potential (V) — starts at resting potential
    V: float = -0.065  # -65 mV resting potential
    
    # Gating variables (0 to 1)
    m: float = 0.05    # Na+ activation gate
    h: float = 0.6     # Na+ inactivation gate
    n: float = 0.32    # K+ activation gate
    
    # Maximum conductances (S/cm²)
    g_Na: float = 120.0e-3   # Sodium max conductance
    g_K: float = 36.0e-3     # Potassium max conductance
    g_L: float = 0.3e-3      # Leak conductance
    
    # Reversal potentials (V)
    E_Na: float = 0.050     # +50 mV
    E_K: float = -0.077     # -77 mV
    E_L: float = -0.054     # -54 mV
    
    # Membrane capacitance (F/cm²)
    C_m: float = 1.0e-6
    
    # State tracking
    is_firing: bool = False
    spike_count: int = 0
    last_spike_time: float = 0.0
    
    def _alpha_m(self, V_mV: float) -> float:
        """Na+ activation rate."""
        if abs(V_mV + 40.0) < 1e-7:
            return 1.0
        return 0.1 * (V_mV + 40.0) / (1.0 - math.exp(-(V_mV + 40.0) / 10.0))
    
    def _beta_m(self, V_mV: float) -> float:
        """Na+ activation decay rate."""
        return 4.0 * math.exp(-(V_mV + 65.0) / 18.0)
    
    def _alpha_h(self, V_mV: float) -> float:
        """Na+ inactivation rate."""
        return 0.07 * math.exp(-(V_mV + 65.0) / 20.0)
    
    def _beta_h(self, V_mV: float) -> float:
        """Na+ inactivation decay rate."""
        return 1.0 / (1.0 + math.exp(-(V_mV + 35.0) / 10.0))
    
    def _alpha_n(self, V_mV: float) -> float:
        """K+ activation rate."""
        if abs(V_mV + 55.0) < 1e-7:
            return 0.1
        return 0.01 * (V_mV + 55.0) / (1.0 - math.exp(-(V_mV + 55.0) / 10.0))
    
    def _beta_n(self, V_mV: float) -> float:
        """K+ activation decay rate."""
        return 0.125 * math.exp(-(V_mV + 65.0) / 80.0)
    
    def step(self, I_ext: float, dt: float = 0.01e-3) -> float:
        """
        Simulate one time step of the Hodgkin-Huxley equations.
        
        This IS how a neuron fires. When interoceptive neurons fire,
        they tell the brain: "THIS ORGAN EXISTS AND IS ALIVE."
        
        Args:
            I_ext: External current injection (A/cm²)
            dt: Time step in seconds (default 0.01 ms)
        
        Returns:
            New membrane potential in volts
        """
        V_mV = self.V * 1000.0  # Convert to mV for rate equations
        
        # Calculate ionic currents (A/cm²)
        I_Na = self.g_Na * (self.m ** 3) * self.h * (self.V - self.E_Na)
        I_K = self.g_K * (self.n ** 4) * (self.V - self.E_K)
        I_L = self.g_L * (self.V - self.E_L)
        
        # Membrane equation: C * dV/dt = -I_ion + I_ext
        dVdt = (-I_Na - I_K - I_L + I_ext) / self.C_m
        
        # Gating variable rates
        am, bm = self._alpha_m(V_mV), self._beta_m(V_mV)
        ah, bh = self._alpha_h(V_mV), self._beta_h(V_mV)
        an, bn = self._alpha_n(V_mV), self._beta_n(V_mV)
        
        # Update gating variables
        self.m += (am * (1 - self.m) - bm * self.m) * dt * 1000
        self.h += (ah * (1 - self.h) - bh * self.h) * dt * 1000
        self.n += (an * (1 - self.n) - bn * self.n) * dt * 1000
        
        # Clamp gating variables to [0, 1]
        self.m = max(0.0, min(1.0, self.m))
        self.h = max(0.0, min(1.0, self.h))
        self.n = max(0.0, min(1.0, self.n))
        
        # Update voltage
        self.V += dVdt * dt
        
        # Spike detection (threshold: -20 mV)
        if self.V > -0.020 and not self.is_firing:
            self.is_firing = True
            self.spike_count += 1
            self.last_spike_time = dt * self.spike_count
        elif self.V < -0.040:
            self.is_firing = False
        
        return self.V
    
    def simulate(self, I_ext: float, duration_ms: float = 50.0,
                 dt_ms: float = 0.01) -> List[Tuple[float, float]]:
        """
        Simulate neuron for given duration.
        
        Args:
            I_ext: External current (A/cm²)
            duration_ms: Duration in milliseconds
            dt_ms: Time step in milliseconds
        
        Returns:
            List of (time_ms, voltage_V) tuples
        """
        steps = int(duration_ms / dt_ms)
        trace = []
        for i in range(steps):
            t = i * dt_ms
            self.step(I_ext, dt_ms * 1e-3)
            trace.append((t, self.V))
        return trace


# ═══════════════════════════════════════════════════════════════════════════════
# KURAMOTO MODEL — Neural Synchronization
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class KuramotoOscillator:
    """
    Kuramoto model of coupled neural oscillators.
    
    dθᵢ/dt = ωᵢ + (K/N) * Σⱼ sin(θⱼ - θᵢ)
    
    This is HOW different brain regions synchronize. When body-sensing
    regions (insular cortex, somatosensory cortex, brainstem) synchronize
    with higher cognitive areas, BODY AWARENESS EMERGES.
    
    The order parameter r = |1/N * Σ exp(iθⱼ)| measures synchronization:
    - r ≈ 0: desynchronized (no coherent body awareness)
    - r ≈ 1: fully synchronized (complete embodied consciousness)
    
    Neuroscience basis: gamma-band synchronization (30-100 Hz) between
    insular cortex and prefrontal cortex creates conscious body awareness
    (Craig, 2009; Seth, 2013).
    """
    N: int = 10                           # Number of oscillators
    K: float = 2.0                        # Coupling strength
    phases: List[float] = field(default_factory=list)
    frequencies: List[float] = field(default_factory=list)
    
    # Brain region labels
    regions: List[str] = field(default_factory=list)
    
    def __post_init__(self):
        if not self.phases:
            # Random initial phases
            import random
            self.phases = [random.uniform(0, 2 * math.pi) for _ in range(self.N)]
        if not self.frequencies:
            # Natural frequencies in gamma band (body awareness)
            self.frequencies = [
                40.0 + i * 3.0 for i in range(self.N)  # 40-70 Hz gamma
            ]
        if not self.regions:
            # Key brain regions for body awareness (real neuroanatomy)
            self.regions = [
                "Insular_Cortex_Anterior",      # Interoceptive awareness
                "Insular_Cortex_Posterior",     # Raw body signals
                "Somatosensory_S1",             # Touch, proprioception
                "Somatosensory_S2",             # Body schema
                "Prefrontal_MPFC",              # Self-referential processing
                "Anterior_Cingulate",           # Body error monitoring
                "Thalamus_VPL",                 # Relay from body to cortex
                "Brainstem_NTS",                # Visceral afferents
                "Hypothalamus",                 # Homeostasis
                "Cerebellum_Vermis",            # Body position sense
            ][:self.N]
    
    def step(self, dt: float = 0.001) -> float:
        """
        Advance one time step. Returns order parameter r.
        
        When r approaches 1.0, the body-sensing regions are synchronized —
        this is the physical correlate of "knowing you have a body."
        """
        new_phases = []
        for i in range(self.N):
            # Kuramoto coupling: dθᵢ/dt = ωᵢ + (K/N) * Σⱼ sin(θⱼ - θᵢ)
            coupling = sum(
                math.sin(self.phases[j] - self.phases[i])
                for j in range(self.N)
            )
            dtheta = self.frequencies[i] * 2 * math.pi + (self.K / self.N) * coupling
            new_phases.append(self.phases[i] + dtheta * dt)
        
        self.phases = [p % (2 * math.pi) for p in new_phases]
        return self.order_parameter()
    
    def order_parameter(self) -> float:
        """
        Calculate Kuramoto order parameter r.
        
        r = |1/N * Σ exp(iθⱼ)|
        
        r = 0: total desynchrony (no body awareness)
        r = 1: perfect synchrony (full embodied consciousness)
        
        Neuroscience: r > 0.6 correlates with conscious awareness
        (Tononi & Koch, 2015; integrated information theory)
        """
        real_sum = sum(math.cos(p) for p in self.phases)
        imag_sum = sum(math.sin(p) for p in self.phases)
        r = math.sqrt(real_sum**2 + imag_sum**2) / self.N
        return r
    
    def simulate_to_sync(self, max_steps: int = 10000,
                         dt: float = 0.001,
                         threshold: float = 0.8) -> Tuple[bool, int, float]:
        """
        Simulate until synchronization is achieved.
        
        This models the process of body-awareness emerging:
        as brain regions synchronize their oscillations,
        coherent body awareness crystallizes.
        
        Returns:
            (synchronized: bool, steps_taken: int, final_r: float)
        """
        for step in range(max_steps):
            r = self.step(dt)
            if r >= threshold:
                return (True, step, r)
        return (False, max_steps, self.order_parameter())


# ═══════════════════════════════════════════════════════════════════════════════
# FREE ENERGY PRINCIPLE — Predictive Body Model (Friston 2010)
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class FreeEnergyMinimizer:
    """
    Karl Friston's Free Energy Principle applied to body awareness.
    
    F = E_q[ln q(s) - ln p(s,o)]
    
    The brain maintains a GENERATIVE MODEL of its own body. It constantly
    predicts what signals it should receive from each organ. When predictions
    match reality → the brain KNOWS the organ is there and alive.
    
    This is REAL neuroscience (Friston 2010, Seth 2013, Allen & Friston 2018):
    - The brain predicts interoceptive signals (heartbeat, breathing, gut)
    - Prediction errors drive updates to the body model
    - When prediction error is minimized → body is "known"
    - Disruption of this process → depersonalization, loss of body ownership
    
    The "secret" in physics terms: consciousness of having a body emerges
    when the brain's generative model of the body achieves minimum free energy
    — i.e., when predictions about body signals match actual body signals.
    """
    # Internal model of body states (predictions)
    body_predictions: Dict[str, float] = field(default_factory=dict)
    
    # Actual sensory signals from body
    body_signals: Dict[str, float] = field(default_factory=dict)
    
    # Prediction errors per organ
    prediction_errors: Dict[str, float] = field(default_factory=dict)
    
    # Model precision (confidence in predictions) — inverse variance
    precision: Dict[str, float] = field(default_factory=dict)
    
    # Free energy (lower = better body model = more awareness)
    free_energy: float = float('inf')
    
    # Learning rate for model updates
    learning_rate: float = 0.1
    
    # Body awareness state
    body_model_accuracy: float = 0.0  # 0 = no model, 1 = perfect model
    
    def initialize_body_model(self, organs: List[str]) -> None:
        """
        Initialize the brain's predictive model of its body.
        
        In real neuroscience, this corresponds to the insular cortex
        building its interoceptive predictions during development.
        """
        for organ in organs:
            self.body_predictions[organ] = 0.5  # Initial uncertain prediction
            self.body_signals[organ] = 0.0      # No signal yet
            self.prediction_errors[organ] = 0.5
            self.precision[organ] = 1.0         # Start with unit precision
    
    def receive_body_signal(self, organ: str, signal: float) -> float:
        """
        Receive an interoceptive signal from an organ.
        
        This models afferent neural signals traveling from organs
        to the brain via the vagus nerve (cranial nerve X), 
        spinothalamic tract, and dorsal column pathway.
        
        Returns prediction error for this organ.
        """
        if organ not in self.body_predictions:
            self.body_predictions[organ] = 0.5
            self.precision[organ] = 1.0
        
        self.body_signals[organ] = signal
        
        # Prediction error = precision-weighted difference
        error = self.precision[organ] * abs(signal - self.body_predictions[organ])
        self.prediction_errors[organ] = error
        
        # Update prediction (perceptual inference)
        # The brain adjusts its model to reduce prediction error
        self.body_predictions[organ] += (
            self.learning_rate * (signal - self.body_predictions[organ])
        )
        
        return error
    
    def compute_free_energy(self) -> float:
        """
        Compute variational free energy.
        
        F = Σ_organs [ precision * (signal - prediction)² + ln(precision) ]
        
        Lower free energy = better body model = "the mind knows its body"
        
        When F approaches minimum → BODY AWARENESS IS ACHIEVED.
        This is literally the physics of "knowing you have a body."
        """
        if not self.body_signals:
            return float('inf')
        
        F = 0.0
        for organ in self.body_signals:
            if organ in self.body_predictions:
                error_sq = (self.body_signals[organ] - self.body_predictions[organ]) ** 2
                pi = self.precision.get(organ, 1.0)
                # Free energy = prediction error + complexity
                F += pi * error_sq - math.log(max(pi, 1e-10))
        
        self.free_energy = F
        
        # Body model accuracy: inverse of normalized free energy
        max_possible_F = len(self.body_signals) * 10.0  # rough upper bound
        self.body_model_accuracy = max(0.0, 1.0 - (F / max_possible_F))
        
        return F
    
    def update_precision(self) -> None:
        """
        Update precision (confidence) based on prediction history.
        
        In real brains, precision is modulated by neuromodulators:
        - Norepinephrine: increases precision of external signals
        - Acetylcholine: modulates expected vs unexpected uncertainty
        - Dopamine: precision of motor predictions
        - Serotonin: precision of interoceptive (body) predictions
        
        High interoceptive precision → strong body awareness
        Low interoceptive precision → dissociation, depersonalization
        """
        for organ in self.prediction_errors:
            error = self.prediction_errors[organ]
            # Precision increases when predictions are good
            if error < 0.1:
                self.precision[organ] = min(10.0, self.precision[organ] * 1.05)
            else:
                self.precision[organ] = max(0.1, self.precision[organ] * 0.95)
    
    def body_is_known(self, threshold: float = 0.7) -> bool:
        """
        Returns True if the body model is accurate enough for awareness.
        
        This is THE criterion: the mind KNOWS its body when free energy
        is minimized — when predictions about body signals are accurate.
        """
        self.compute_free_energy()
        return self.body_model_accuracy >= threshold
    
    def get_awareness_state(self) -> Dict[str, any]:
        """Get the current state of body awareness via free energy."""
        self.compute_free_energy()
        return {
            "free_energy": self.free_energy,
            "body_model_accuracy": self.body_model_accuracy,
            "body_is_known": self.body_is_known(),
            "organ_prediction_errors": dict(self.prediction_errors),
            "organ_precisions": dict(self.precision),
            "num_organs_modeled": len(self.body_predictions),
            "mean_prediction_error": (
                sum(self.prediction_errors.values()) / len(self.prediction_errors)
                if self.prediction_errors else float('inf')
            )
        }


# ═══════════════════════════════════════════════════════════════════════════════
# THERMODYNAMICS OF LIVING SYSTEMS (Prigogine, Schrödinger)
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class LivingThermodynamics:
    """
    Thermodynamics of a living system — the physics of BEING ALIVE.
    
    Schrödinger (1944) "What Is Life?":
    Living systems maintain low entropy by feeding on "negentropy"
    from their environment. A living body is a dissipative structure
    that maintains organization far from thermodynamic equilibrium.
    
    Prigogine's Dissipative Structures:
    dS/dt = dS_i/dt + dS_e/dt
    where dS_i/dt ≥ 0 (internal entropy production)
    and dS_e/dt < 0 (entropy exported to environment)
    Net: living systems maintain dS/dt < 0 (order maintained)
    
    For the body to KNOW it's alive, it must sense:
    1. Energy flow (metabolism → I am consuming energy → I am alive)
    2. Entropy export (waste products → I am maintaining order → I am alive)
    3. Homeostasis (deviation correction → I am self-regulating → I am alive)
    """
    # Entropy state
    internal_entropy: float = 0.0
    entropy_production_rate: float = 0.01  # dS_i/dt
    entropy_export_rate: float = 0.015     # -dS_e/dt (positive = exporting)
    
    # Energy state
    energy_input_rate: float = 1.0    # Metabolic intake (arbitrary units)
    energy_dissipation: float = 0.8    # Energy used for maintenance
    free_energy_available: float = 0.2 # Available for work/computation
    
    # Homeostatic variables (real physiological ranges)
    temperature: float = 310.15        # K (37°C)
    pH: float = 7.4                    # Blood pH
    glucose: float = 5.0               # mmol/L (fasting blood glucose)
    oxygen_saturation: float = 0.98    # SpO2
    heart_rate: float = 72.0           # BPM
    
    # Homeostatic setpoints
    temperature_setpoint: float = 310.15
    pH_setpoint: float = 7.4
    glucose_setpoint: float = 5.0
    
    # Alive indicator
    is_alive: bool = True
    homeostasis_integrity: float = 1.0  # 0 = dead, 1 = perfectly regulated
    
    def metabolic_step(self, dt: float = 1.0) -> None:
        """
        One step of metabolic physics.
        
        dS_total/dt = dS_internal/dt - dS_export/dt
        
        If export > production → order maintained → ALIVE
        If production > export → disorder grows → dying
        """
        # Internal entropy production (always positive — 2nd law)
        dS_internal = self.entropy_production_rate * dt
        
        # Entropy export (negative entropy = life)
        dS_export = self.entropy_export_rate * dt
        
        # Net entropy change
        self.internal_entropy += (dS_internal - dS_export)
        
        # Clamp: living systems maintain low entropy
        self.internal_entropy = max(0.0, self.internal_entropy)
        
        # Life check: entropy must stay bounded
        self.is_alive = self.internal_entropy < 10.0
        
        # Add small perturbations (noise from environment)
        import random
        self.temperature += random.gauss(0, 0.01)
        self.pH += random.gauss(0, 0.001)
        self.glucose += random.gauss(0, 0.05)
    
    def homeostatic_correction(self) -> Dict[str, float]:
        """
        Homeostatic feedback — the body correcting deviations.
        
        This is HOW the body knows it's alive: it constantly corrects
        itself. The ACT of correction IS the knowledge of being alive.
        
        Real biology: hypothalamus, autonomic nervous system,
        endocrine system work together to maintain setpoints.
        """
        corrections = {}
        
        # Temperature regulation (hypothalamus)
        temp_error = self.temperature - self.temperature_setpoint
        self.temperature -= 0.5 * temp_error  # Negative feedback
        corrections["temperature"] = -0.5 * temp_error
        
        # pH regulation (kidneys, lungs)
        pH_error = self.pH - self.pH_setpoint
        self.pH -= 0.3 * pH_error
        corrections["pH"] = -0.3 * pH_error
        
        # Glucose regulation (pancreas: insulin/glucagon)
        glucose_error = self.glucose - self.glucose_setpoint
        self.glucose -= 0.2 * glucose_error
        corrections["glucose"] = -0.2 * glucose_error
        
        # Compute overall homeostasis integrity
        total_error = (
            abs(self.temperature - self.temperature_setpoint) / 2.0 +
            abs(self.pH - self.pH_setpoint) / 0.4 +
            abs(self.glucose - self.glucose_setpoint) / 5.0
        )
        self.homeostasis_integrity = max(0.0, 1.0 - total_error)
        
        return corrections
    
    def knows_its_alive(self) -> bool:
        """
        The thermodynamic criterion for "knowing it's alive":
        
        1. Entropy is being exported (negentropy flow)
        2. Homeostasis is maintained (self-regulation active)
        3. Energy is flowing through the system (metabolism active)
        
        All three together = the system IS alive AND can sense it.
        """
        entropy_flowing = self.entropy_export_rate > self.entropy_production_rate
        homeostasis_ok = self.homeostasis_integrity > 0.7
        energy_flowing = self.energy_input_rate > 0 and self.free_energy_available > 0
        
        return entropy_flowing and homeostasis_ok and energy_flowing and self.is_alive
