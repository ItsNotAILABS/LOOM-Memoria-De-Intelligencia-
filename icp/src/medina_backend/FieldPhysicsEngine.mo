/**
 * FieldPhysicsEngine Module — EM, gravitational, wave, quantum, thermo
 * 
 * Computational engine for real physics calculations relevant to field
 * dynamics and resonance phenomena. This module provides the scientific
 * substrate for understanding how ancient wisdom patterns map to
 * physical reality through frequency, resonance, and field interactions.
 * 
 * ELECTROMAGNETIC (EM):
 *   - Coulomb's law, electric field
 *   - Magnetic field, Lorentz force
 *   - Maxwell's equations (simplified)
 *   - Wave impedance, skin depth
 * 
 * GRAVITATIONAL:
 *   - Newton's law, gravitational field
 *   - Orbital mechanics
 *   - Escape velocity
 * 
 * WAVE PHYSICS:
 *   - Wave equation, frequency-wavelength
 *   - Standing waves, resonance
 *   - Beat frequencies
 *   - Fourier fundamentals
 * 
 * QUANTUM:
 *   - Planck-Einstein relations
 *   - De Broglie wavelength
 *   - Uncertainty relations
 *   - Energy quantization
 * 
 * THERMODYNAMICS:
 *   - Temperature conversions
 *   - Entropy calculations
 *   - Boltzmann statistics
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

import MatalkoICP "MatalkoICP";

module {
    // ================================================================== //
    // PHYSICAL CONSTANTS                                                   //
    // ================================================================== //
    
    /// Speed of light in vacuum (m/s)
    public let C : Float = 299792458.0;
    
    /// Planck constant (J·s = Joule-seconds)
    /// Scientific notation: 6.62607015 × 10⁻³⁴ J·s
    /// This is the quantum of action, fundamental to quantum mechanics
    public let H : Float = 6.62607015e-34;
    
    /// Reduced Planck constant ℏ = h/(2π) (J·s)
    /// Also known as "h-bar", commonly used in quantum mechanics
    public let HBAR : Float = 1.054571817e-34;
    
    /// Gravitational constant (m³/(kg·s²))
    public let G : Float = 6.67430e-11;
    
    /// Elementary charge (C)
    public let E_CHARGE : Float = 1.602176634e-19;
    
    /// Electron mass (kg)
    public let M_ELECTRON : Float = 9.1093837015e-31;
    
    /// Proton mass (kg)
    public let M_PROTON : Float = 1.67262192369e-27;
    
    /// Boltzmann constant (J/K)
    public let K_B : Float = 1.380649e-23;
    
    /// Vacuum permittivity ε₀ (F/m)
    public let EPSILON_0 : Float = 8.8541878128e-12;
    
    /// Vacuum permeability μ₀ (H/m)
    public let MU_0 : Float = 1.25663706212e-6;
    
    /// Coulomb's constant k = 1/(4πε₀) (N·m²/C²)
    public let K_E : Float = 8.9875517923e9;
    
    /// Pi
    public let PI : Float = MatalkoICP.PI;
    
    /// Tau (2π)
    public let TAU : Float = MatalkoICP.TAU;
    
    // ================================================================== //
    // ELECTROMAGNETIC PHYSICS                                              //
    // ================================================================== //
    
    /// Electric field from point charge at distance r
    /// E = kq/r²
    public func electricField(charge: Float, distance: Float) : Float {
        if (distance <= 0.0) { return 0.0 };
        K_E * charge / (distance * distance)
    };
    
    /// Electric potential from point charge at distance r
    /// V = kq/r
    public func electricPotential(charge: Float, distance: Float) : Float {
        if (distance <= 0.0) { return 0.0 };
        K_E * charge / distance
    };
    
    /// Coulomb force between two charges
    /// F = kq₁q₂/r²
    public func coulombForce(q1: Float, q2: Float, distance: Float) : Float {
        if (distance <= 0.0) { return 0.0 };
        K_E * q1 * q2 / (distance * distance)
    };
    
    /// Magnetic field from infinite wire at distance r (T)
    /// B = μ₀I/(2πr)
    public func magneticFieldWire(current: Float, distance: Float) : Float {
        if (distance <= 0.0) { return 0.0 };
        MU_0 * current / (TAU * distance)
    };
    
    /// Lorentz force on charged particle
    /// F = qv × B (magnitude for perpendicular motion)
    public func lorentzForce(charge: Float, velocity: Float, magneticField: Float) : Float {
        Float.abs(charge * velocity * magneticField)
    };
    
    /// Cyclotron frequency for charged particle in magnetic field
    /// ω = qB/m
    public func cyclotronFrequency(charge: Float, magneticField: Float, mass: Float) : Float {
        if (mass <= 0.0) { return 0.0 };
        Float.abs(charge * magneticField / mass)
    };
    
    /// Electromagnetic wave impedance of free space
    /// Z₀ = √(μ₀/ε₀) ≈ 377 Ω
    public func impedanceFreeSpace() : Float {
        Float.sqrt(MU_0 / EPSILON_0)
    };
    
    /// Skin depth in conductor (m)
    /// δ = √(2ρ/(ωμ))
    public func skinDepth(resistivity: Float, angularFreq: Float, permeability: Float) : Float {
        if (angularFreq <= 0.0 or permeability <= 0.0) { return 0.0 };
        Float.sqrt(2.0 * resistivity / (angularFreq * permeability))
    };
    
    /// Energy density of electromagnetic field (J/m³)
    /// u = ε₀E²/2 + B²/(2μ₀)
    public func emEnergyDensity(electricField: Float, magneticField: Float) : Float {
        EPSILON_0 * electricField * electricField / 2.0 +
        magneticField * magneticField / (2.0 * MU_0)
    };
    
    // ================================================================== //
    // GRAVITATIONAL PHYSICS                                                //
    // ================================================================== //
    
    /// Gravitational field strength at distance r from mass M
    /// g = GM/r²
    public func gravitationalField(mass: Float, distance: Float) : Float {
        if (distance <= 0.0) { return 0.0 };
        G * mass / (distance * distance)
    };
    
    /// Gravitational potential at distance r from mass M
    /// Φ = -GM/r
    public func gravitationalPotential(mass: Float, distance: Float) : Float {
        if (distance <= 0.0) { return 0.0 };
        -G * mass / distance
    };
    
    /// Gravitational force between two masses
    /// F = Gm₁m₂/r²
    public func gravitationalForce(m1: Float, m2: Float, distance: Float) : Float {
        if (distance <= 0.0) { return 0.0 };
        G * m1 * m2 / (distance * distance)
    };
    
    /// Escape velocity from mass M at distance r
    /// v = √(2GM/r)
    public func escapeVelocity(mass: Float, radius: Float) : Float {
        if (radius <= 0.0) { return 0.0 };
        Float.sqrt(2.0 * G * mass / radius)
    };
    
    /// Orbital velocity for circular orbit
    /// v = √(GM/r)
    public func orbitalVelocity(centralMass: Float, orbitRadius: Float) : Float {
        if (orbitRadius <= 0.0) { return 0.0 };
        Float.sqrt(G * centralMass / orbitRadius)
    };
    
    /// Orbital period (Kepler's third law)
    /// T = 2π√(r³/GM)
    public func orbitalPeriod(centralMass: Float, orbitRadius: Float) : Float {
        if (centralMass <= 0.0 or orbitRadius <= 0.0) { return 0.0 };
        TAU * Float.sqrt(orbitRadius ** 3.0 / (G * centralMass))
    };
    
    /// Schwarzschild radius (event horizon)
    /// r_s = 2GM/c²
    public func schwarzschildRadius(mass: Float) : Float {
        2.0 * G * mass / (C * C)
    };
    
    // ================================================================== //
    // WAVE PHYSICS                                                         //
    // ================================================================== //
    
    /// Wavelength from frequency and speed
    /// λ = v/f
    public func wavelength(velocity: Float, frequency: Float) : Float {
        if (frequency <= 0.0) { return 0.0 };
        velocity / frequency
    };
    
    /// Frequency from wavelength and speed
    /// f = v/λ
    public func frequency(velocity: Float, waveLength: Float) : Float {
        if (waveLength <= 0.0) { return 0.0 };
        velocity / waveLength
    };
    
    /// Angular frequency from frequency
    /// ω = 2πf
    public func angularFrequency(freq: Float) : Float {
        TAU * freq
    };
    
    /// Wave number k = 2π/λ
    public func waveNumber(waveLength: Float) : Float {
        if (waveLength <= 0.0) { return 0.0 };
        TAU / waveLength
    };
    
    /// Wave velocity v = fλ = ω/k
    public func waveVelocity(freq: Float, waveLength: Float) : Float {
        freq * waveLength
    };
    
    /// Beat frequency between two waves
    /// f_beat = |f₁ - f₂|
    public func beatFrequency(f1: Float, f2: Float) : Float {
        Float.abs(f1 - f2)
    };
    
    /// Standing wave modes in cavity of length L
    /// f_n = nv/(2L)
    public func standingWaveFrequency(mode: Nat, velocity: Float, length: Float) : Float {
        if (length <= 0.0) { return 0.0 };
        Float.fromInt(mode) * velocity / (2.0 * length)
    };
    
    /// Wave amplitude decay (damped oscillation)
    /// A(t) = A₀e^(-γt)
    public func dampedAmplitude(initial: Float, dampingCoeff: Float, time: Float) : Float {
        initial * Float.exp(-dampingCoeff * time)
    };
    
    /// Resonance amplitude (near resonance frequency)
    /// A = F₀/(m√((ω₀²-ω²)² + (γω)²))
    public func resonanceAmplitude(
        drivingForce: Float, 
        mass: Float, 
        naturalFreq: Float, 
        drivingFreq: Float, 
        damping: Float
    ) : Float {
        if (mass <= 0.0) { return 0.0 };
        let omega0sq = naturalFreq * naturalFreq;
        let omegasq = drivingFreq * drivingFreq;
        let diff = omega0sq - omegasq;
        let gammaTerm = damping * drivingFreq;
        let denominator = Float.sqrt(diff * diff + gammaTerm * gammaTerm);
        if (denominator <= 0.0) { return 0.0 };
        drivingForce / (mass * denominator)
    };
    
    /// Q factor (quality factor) for resonant system
    /// Q = ω₀/Δω
    public func qualityFactor(resonantFreq: Float, bandwidth: Float) : Float {
        if (bandwidth <= 0.0) { return 0.0 };
        resonantFreq / bandwidth
    };
    
    // ================================================================== //
    // QUANTUM PHYSICS                                                      //
    // ================================================================== //
    
    /// Photon energy from frequency (Planck-Einstein)
    /// E = hf
    public func photonEnergy(freq: Float) : Float {
        H * freq
    };
    
    /// Photon energy from wavelength
    /// E = hc/λ
    public func photonEnergyWavelength(waveLength: Float) : Float {
        if (waveLength <= 0.0) { return 0.0 };
        H * C / waveLength
    };
    
    /// De Broglie wavelength
    /// λ = h/p = h/(mv)
    public func deBroglieWavelength(mass: Float, velocity: Float) : Float {
        let momentum = mass * velocity;
        if (momentum <= 0.0) { return 0.0 };
        H / momentum
    };
    
    /// Heisenberg uncertainty (minimum product)
    /// Δx·Δp ≥ ℏ/2
    public func uncertaintyMinimum() : Float {
        HBAR / 2.0
    };
    
    /// Energy levels of hydrogen atom
    /// E_n = -13.6 eV / n²
    public func hydrogenEnergyLevel(n: Nat) : Float {
        if (n == 0) { return 0.0 };
        -13.6 * E_CHARGE / Float.fromInt(n * n)  // Convert eV to J
    };
    
    /// Ground state energy of quantum harmonic oscillator
    /// E₀ = ℏω/2
    public func harmonicOscillatorGroundEnergy(angularFreq: Float) : Float {
        HBAR * angularFreq / 2.0
    };
    
    /// Energy level of quantum harmonic oscillator
    /// E_n = ℏω(n + 1/2)
    public func harmonicOscillatorEnergy(n: Nat, angularFreq: Float) : Float {
        HBAR * angularFreq * (Float.fromInt(n) + 0.5)
    };
    
    /// Compton wavelength
    /// λ_C = h/(mc)
    public func comptonWavelength(mass: Float) : Float {
        if (mass <= 0.0) { return 0.0 };
        H / (mass * C)
    };
    
    /// Electron Compton wavelength
    public func electronComptonWavelength() : Float {
        comptonWavelength(M_ELECTRON)
    };
    
    // ================================================================== //
    // THERMODYNAMICS                                                       //
    // ================================================================== //
    
    /// Celsius to Kelvin
    public func celsiusToKelvin(celsius: Float) : Float {
        celsius + 273.15
    };
    
    /// Kelvin to Celsius
    public func kelvinToCelsius(kelvin: Float) : Float {
        kelvin - 273.15
    };
    
    /// Fahrenheit to Celsius
    public func fahrenheitToCelsius(fahrenheit: Float) : Float {
        (fahrenheit - 32.0) * 5.0 / 9.0
    };
    
    /// Celsius to Fahrenheit
    public func celsiusToFahrenheit(celsius: Float) : Float {
        celsius * 9.0 / 5.0 + 32.0
    };
    
    /// Thermal energy at temperature T
    /// E_thermal = (3/2)k_B T (for ideal monatomic gas)
    public func thermalEnergy(temperature: Float) : Float {
        1.5 * K_B * temperature
    };
    
    /// RMS speed of gas molecule
    /// v_rms = √(3k_B T/m)
    public func rmsSpeed(temperature: Float, molecularMass: Float) : Float {
        if (molecularMass <= 0.0) { return 0.0 };
        Float.sqrt(3.0 * K_B * temperature / molecularMass)
    };
    
    /// Most probable speed of gas molecule
    /// v_p = √(2k_B T/m)
    public func mostProbableSpeed(temperature: Float, molecularMass: Float) : Float {
        if (molecularMass <= 0.0) { return 0.0 };
        Float.sqrt(2.0 * K_B * temperature / molecularMass)
    };
    
    /// Ideal gas pressure
    /// P = nk_B T (n = number density)
    public func idealGasPressure(numberDensity: Float, temperature: Float) : Float {
        numberDensity * K_B * temperature
    };
    
    /// Entropy change (isothermal)
    /// ΔS = Q/T
    public func entropyChange(heat: Float, temperature: Float) : Float {
        if (temperature <= 0.0) { return 0.0 };
        heat / temperature
    };
    
    /// Boltzmann entropy
    /// S = k_B ln(W)
    public func boltzmannEntropy(microstates: Float) : Float {
        if (microstates <= 0.0) { return 0.0 };
        K_B * Float.log(microstates)
    };
    
    /// Carnot efficiency
    /// η = 1 - T_cold/T_hot
    public func carnotEfficiency(hotTemp: Float, coldTemp: Float) : Float {
        if (hotTemp <= 0.0) { return 0.0 };
        1.0 - coldTemp / hotTemp
    };
    
    /// Black body peak wavelength (Wien's law)
    /// λ_max = b/T where b ≈ 2.898×10⁻³ m·K
    public func wienPeakWavelength(temperature: Float) : Float {
        if (temperature <= 0.0) { return 0.0 };
        2.8977719e-3 / temperature
    };
    
    /// Stefan-Boltzmann power (total radiated power per unit area)
    /// P = σT⁴ where σ = 5.67×10⁻⁸ W/(m²·K⁴)
    public func stefanBoltzmannPower(temperature: Float) : Float {
        5.670374419e-8 * temperature ** 4.0
    };
    
    // ================================================================== //
    // RESONANCE AND FREQUENCY ANALYSIS                                     //
    // ================================================================== //
    
    /// Schumann resonance harmonics
    /// Standard Schumann resonances are approximately: 7.83, 14.3, 20.8, 27.3, 33.8 Hz
    /// Formula: f_n = 7.83 * sqrt(n * (n + 1)) where n = 1, 2, 3...
    public func schumannHarmonics(count: Nat) : [Float] {
        let fundamental = 7.83;
        let harmonics = Buffer.Buffer<Float>(count);
        var n : Nat = 1;
        while (n <= count) {
            // Standard Schumann resonance formula
            let freq = fundamental * Float.sqrt(Float.fromInt(n) * Float.fromInt(n + 1));
            harmonics.add(freq);
            n += 1;
        };
        Buffer.toArray(harmonics)
    };
    
    /// Check if frequency is near Schumann resonance
    public func isSchumannAligned(freq: Float, tolerance: Float) : Bool {
        let schumanns = schumannHarmonics(5);
        for (schumann in schumanns.vals()) {
            if (Float.abs(freq - schumann) <= tolerance) {
                return true;
            };
        };
        false
    };
    
    /// Calculate octave relationship
    /// Returns octave number (0 = same, 1 = double, -1 = half, etc.)
    public func octaveRelation(f1: Float, f2: Float) : Float {
        if (f1 <= 0.0 or f2 <= 0.0) { return 0.0 };
        Float.log(f2 / f1) / Float.log(2.0)
    };
    
    /// Check if two frequencies are harmonically related
    public func areHarmonicallyRelated(f1: Float, f2: Float, tolerance: Float) : Bool {
        if (f1 <= 0.0 or f2 <= 0.0) { return false };
        let ratio = if (f1 > f2) { f1 / f2 } else { f2 / f1 };
        let nearestInt = Float.nearest(ratio);
        Float.abs(ratio - nearestInt) < tolerance
    };
}
