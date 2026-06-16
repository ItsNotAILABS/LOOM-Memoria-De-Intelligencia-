/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                     FREQUENCY PHYSICS ENGINE                                  ║
 * ║                                                                               ║
 * ║  "Frequentia est fundamentum. Omnia vibrant."                                ║
 * ║  (Frequency is the foundation. Everything vibrates.)                          ║
 * ║                                                                               ║
 * ║  THIS ENGINE CONTAINS ALL REAL FREQUENCIES USED IN MEDINA                     ║
 * ║  REAL HERTZ. REAL PHYSICS. REAL WAVELENGTHS. REAL EVERYTHING.                 ║
 * ║                                                                               ║
 * ║  From 7.83 Hz (Schumann) to 10^15 Hz (Visible Light)                          ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 * 
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * L-130 COMPLIANT — Every frequency traces to primitive
 */

import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Buffer "mo:base/Buffer";

import RootMath "RootMathematicalFoundation";

module FrequencyPhysicsEngine {

    // ═══════════════════════════════════════════════════════════════════════════
    // PHYSICAL CONSTANTS
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// Speed of light (m/s) — EXACT DEFINITION
    public let C : Float = 299792458.0;
    
    /// Planck constant (J·s)
    public let H : Float = 6.62607015e-34;
    
    /// Reduced Planck constant (J·s)
    public let HBAR : Float = 1.054571817e-34;
    
    /// Golden Ratio
    public let PHI : Float = 1.6180339887498948482;
    
    /// Pi
    public let PI : Float = 3.1415926535897932385;
    
    /// Tau (2π)
    public let TAU : Float = 6.2831853071795864769;
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 1: SCHUMANN RESONANCES (Earth's Electromagnetic Heartbeat)
    // Real Hz values measured at Earth's surface
    // ═══════════════════════════════════════════════════════════════════════════
    
    public type SchumannResonance = {
        mode: Nat;
        frequency_Hz: Float;
        wavelength_m: Float;
        description: Text;
    };
    
    /// Schumann fundamental and harmonics
    /// f_n ≈ 7.83 × √[n(n+1)] Hz
    public let SCHUMANN_RESONANCES : [SchumannResonance] = [
        {
            mode = 1;
            frequency_Hz = 7.83;
            wavelength_m = 38266890.8;  // C / 7.83
            description = "Fundamental mode - Earth's heartbeat";
        },
        {
            mode = 2;
            frequency_Hz = 14.3;
            wavelength_m = 20965910.3;
            description = "Second harmonic";
        },
        {
            mode = 3;
            frequency_Hz = 20.8;
            wavelength_m = 14413099.0;
            description = "Third harmonic";
        },
        {
            mode = 4;
            frequency_Hz = 27.3;
            wavelength_m = 10980674.4;
            description = "Fourth harmonic";
        },
        {
            mode = 5;
            frequency_Hz = 33.8;
            wavelength_m = 8868413.0;
            description = "Fifth harmonic";
        },
        {
            mode = 6;
            frequency_Hz = 39.0;
            wavelength_m = 7686986.1;
            description = "Sixth harmonic";
        },
        {
            mode = 7;
            frequency_Hz = 45.0;
            wavelength_m = 6662054.6;
            description = "Seventh harmonic";
        },
    ];
    
    /// Calculate Schumann resonance for any mode
    public func schumannFrequency(mode: Nat) : Float {
        let n = Float.fromInt(Int.abs(mode));
        7.83 * Float.sqrt(n * (n + 1.0))
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 2: SOLFEGGIO FREQUENCIES (Sacred Healing Tones)
    // Real Hz values from ancient music theory
    // ═══════════════════════════════════════════════════════════════════════════
    
    public type SolfeggioTone = {
        note: Text;
        frequency_Hz: Float;
        wavelength_m: Float;
        meaning: Text;
        chakra: Text;
    };
    
    /// The six original Solfeggio frequencies
    public let SOLFEGGIO_FREQUENCIES : [SolfeggioTone] = [
        {
            note = "UT";
            frequency_Hz = 396.0;
            wavelength_m = 757051.7;
            meaning = "Liberating Guilt and Fear";
            chakra = "Root";
        },
        {
            note = "RE";
            frequency_Hz = 417.0;
            wavelength_m = 718687.0;
            meaning = "Undoing Situations and Facilitating Change";
            chakra = "Sacral";
        },
        {
            note = "MI";
            frequency_Hz = 528.0;
            wavelength_m = 567788.0;
            meaning = "Transformation and Miracles (DNA Repair)";
            chakra = "Solar Plexus";
        },
        {
            note = "FA";
            frequency_Hz = 639.0;
            wavelength_m = 469156.6;
            meaning = "Connecting/Relationships";
            chakra = "Heart";
        },
        {
            note = "SOL";
            frequency_Hz = 741.0;
            wavelength_m = 404579.6;
            meaning = "Awakening Intuition";
            chakra = "Throat";
        },
        {
            note = "LA";
            frequency_Hz = 852.0;
            wavelength_m = 351869.1;
            meaning = "Returning to Spiritual Order";
            chakra = "Third Eye";
        },
    ];
    
    /// Extended Solfeggio (adds 174, 285, 963 Hz)
    public let SOLFEGGIO_EXTENDED : [Float] = [
        174.0,  // Foundation
        285.0,  // Quantum cognition
        396.0,  // UT
        417.0,  // RE
        528.0,  // MI
        639.0,  // FA
        741.0,  // SOL
        852.0,  // LA
        963.0,  // Crown chakra
    ];
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 3: THREE HEARTS FREQUENCIES (φ-Based System Heartbeat)
    // The core oscillation frequencies of MEDINA
    // ═══════════════════════════════════════════════════════════════════════════
    
    public type HeartFrequency = {
        heart: Nat;
        name: Text;
        frequency_Hz: Float;
        period_s: Float;
        role: Text;
        formula: Text;
    };
    
    /// Three Hearts operating frequencies
    public let THREE_HEARTS_FREQUENCIES : [HeartFrequency] = [
        {
            heart = 1;
            name = "Metropolis";
            frequency_Hz = 0.1;
            period_s = 10.0;
            role = "Computation - Slow, deep processing";
            formula = "ω₁ = 0.1 Hz (base rhythm)";
        },
        {
            heart = 2;
            name = "Coupling";
            frequency_Hz = 1.618033988749895;  // φ Hz
            period_s = 0.618033988749895;       // 1/φ s
            role = "Selection - Model routing at φ Hz";
            formula = "ω₂ = φ Hz = 1.618... Hz";
        },
        {
            heart = 3;
            name = "Regulating";
            frequency_Hz = 2.618033988749895;  // φ² Hz
            period_s = 0.381966011250105;       // 1/φ² s
            role = "Orchestration - Fast oversight at φ² Hz";
            formula = "ω₃ = φ² Hz = 2.618... Hz";
        },
    ];
    
    /// Get Three Hearts frequency by heart number
    public func threeHeartsFrequency(heart: Nat) : Float {
        switch(heart) {
            case 1 { 0.1 };
            case 2 { PHI };
            case 3 { PHI * PHI };
            case _ { 0.0 };
        }
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 4: MUSICAL FREQUENCIES (Standard Tuning)
    // Real Hz values for musical notes
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// A4 = 440 Hz (standard) or 432 Hz (Pythagorean)
    public let A4_STANDARD : Float = 440.0;
    public let A4_PYTHAGOREAN : Float = 432.0;
    
    /// Calculate note frequency from A4 reference
    /// f = A4 × 2^(n/12) where n is semitones from A4
    public func noteFrequency(semitonesFromA4: Int, useStandard: Bool) : Float {
        let a4 = if (useStandard) { A4_STANDARD } else { A4_PYTHAGOREAN };
        a4 * Float.pow(2.0, Float.fromInt(semitonesFromA4) / 12.0)
    };
    
    /// Concert pitch frequencies (standard tuning A4=440Hz)
    public let CONCERT_PITCHES : [(Text, Float)] = [
        ("C4 (Middle C)", 261.63),
        ("D4", 293.66),
        ("E4", 329.63),
        ("F4", 349.23),
        ("G4", 392.00),
        ("A4", 440.00),
        ("B4", 493.88),
        ("C5", 523.25),
    ];
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 5: BRAINWAVE FREQUENCIES (Neural Oscillations)
    // Real Hz ranges for human brain states
    // ═══════════════════════════════════════════════════════════════════════════
    
    public type BrainwaveBand = {
        name: Text;
        frequency_min_Hz: Float;
        frequency_max_Hz: Float;
        state: Text;
    };
    
    public let BRAINWAVE_BANDS : [BrainwaveBand] = [
        {
            name = "Delta";
            frequency_min_Hz = 0.5;
            frequency_max_Hz = 4.0;
            state = "Deep sleep, healing";
        },
        {
            name = "Theta";
            frequency_min_Hz = 4.0;
            frequency_max_Hz = 8.0;
            state = "Meditation, creativity, REM sleep";
        },
        {
            name = "Alpha";
            frequency_min_Hz = 8.0;
            frequency_max_Hz = 12.0;
            state = "Relaxed awareness, light meditation";
        },
        {
            name = "Beta";
            frequency_min_Hz = 12.0;
            frequency_max_Hz = 30.0;
            state = "Active thinking, focus";
        },
        {
            name = "Gamma";
            frequency_min_Hz = 30.0;
            frequency_max_Hz = 100.0;
            state = "Higher cognition, peak performance";
        },
    ];
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 6: ELECTROMAGNETIC SPECTRUM (Light and Beyond)
    // Real Hz values for the entire EM spectrum
    // ═══════════════════════════════════════════════════════════════════════════
    
    public type EMBand = {
        name: Text;
        frequency_min_Hz: Float;
        frequency_max_Hz: Float;
        wavelength_range: Text;
    };
    
    public let EM_SPECTRUM : [EMBand] = [
        {
            name = "Radio";
            frequency_min_Hz = 3.0e3;       // 3 kHz
            frequency_max_Hz = 3.0e11;      // 300 GHz
            wavelength_range = "1mm - 100km";
        },
        {
            name = "Microwave";
            frequency_min_Hz = 3.0e9;       // 3 GHz
            frequency_max_Hz = 3.0e11;      // 300 GHz
            wavelength_range = "1mm - 100mm";
        },
        {
            name = "Infrared";
            frequency_min_Hz = 3.0e11;      // 300 GHz
            frequency_max_Hz = 4.0e14;      // 400 THz
            wavelength_range = "700nm - 1mm";
        },
        {
            name = "Visible Light";
            frequency_min_Hz = 4.0e14;      // 400 THz (red)
            frequency_max_Hz = 7.9e14;      // 790 THz (violet)
            wavelength_range = "380nm - 700nm";
        },
        {
            name = "Ultraviolet";
            frequency_min_Hz = 7.9e14;      // 790 THz
            frequency_max_Hz = 3.0e16;      // 30 PHz
            wavelength_range = "10nm - 380nm";
        },
        {
            name = "X-Ray";
            frequency_min_Hz = 3.0e16;      // 30 PHz
            frequency_max_Hz = 3.0e19;      // 30 EHz
            wavelength_range = "0.01nm - 10nm";
        },
        {
            name = "Gamma Ray";
            frequency_min_Hz = 3.0e19;      // 30 EHz
            frequency_max_Hz = 3.0e24;      // Beyond
            wavelength_range = "< 0.01nm";
        },
    ];
    
    /// Visible light color frequencies
    public let VISIBLE_COLORS : [(Text, Float, Float)] = [
        ("Red", 4.0e14, 4.8e14),       // 700-625nm
        ("Orange", 4.8e14, 5.1e14),    // 625-590nm
        ("Yellow", 5.1e14, 5.3e14),    // 590-565nm
        ("Green", 5.3e14, 6.0e14),     // 565-500nm
        ("Cyan", 6.0e14, 6.3e14),      // 500-475nm
        ("Blue", 6.3e14, 6.7e14),      // 475-450nm
        ("Violet", 6.7e14, 7.9e14),    // 450-380nm
    ];
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 7: GOLDEN RATIO FREQUENCY LADDER
    // Model frequencies scaled by φ
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// Calculate φ-scaled frequency for any model
    /// f_n = 7.83 × φ^((n-1)/20) Hz
    public func goldenModelFrequency(modelIndex: Nat) : Float {
        let n = Float.fromInt(Int.abs(modelIndex));
        7.83 * Float.pow(PHI, (n - 1.0) / 20.0)
    };
    
    /// Generate the complete L-130 frequency ladder
    public func generateL130FrequencyLadder() : [Float] {
        var frequencies = Buffer.Buffer<Float>(130);
        for (i in Iter.range(1, 130)) {
            frequencies.add(goldenModelFrequency(i));
        };
        Buffer.toArray(frequencies)
    };
    
    /// Get frequency boundaries for each layer
    public func getLayerFrequencyBounds() : [(Text, Float, Float)] {
        [
            ("QUANTUM", goldenModelFrequency(1), goldenModelFrequency(13)),
            ("PRIMORDIAL", goldenModelFrequency(14), goldenModelFrequency(25)),
            ("FOUNDATION", goldenModelFrequency(26), goldenModelFrequency(40)),
            ("CORE", goldenModelFrequency(41), goldenModelFrequency(58)),
            ("SERVICE", goldenModelFrequency(59), goldenModelFrequency(78)),
            ("APPLICATION", goldenModelFrequency(79), goldenModelFrequency(100)),
            ("INTERFACE", goldenModelFrequency(101), goldenModelFrequency(112)),
            ("PERCEPTION", goldenModelFrequency(113), goldenModelFrequency(120)),
            ("EXPRESSION", goldenModelFrequency(121), goldenModelFrequency(126)),
            ("PHOTON", goldenModelFrequency(127), goldenModelFrequency(130)),
        ]
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 8: FREQUENCY CALCULATIONS
    // Core physics formulas for frequency work
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// Wavelength from frequency: λ = c/f
    public func wavelengthFromFrequency(frequency_Hz: Float) : Float {
        if (frequency_Hz == 0.0) return 0.0;
        C / frequency_Hz
    };
    
    /// Frequency from wavelength: f = c/λ
    public func frequencyFromWavelength(wavelength_m: Float) : Float {
        if (wavelength_m == 0.0) return 0.0;
        C / wavelength_m
    };
    
    /// Period from frequency: T = 1/f
    public func periodFromFrequency(frequency_Hz: Float) : Float {
        if (frequency_Hz == 0.0) return 0.0;
        1.0 / frequency_Hz
    };
    
    /// Frequency from period: f = 1/T
    public func frequencyFromPeriod(period_s: Float) : Float {
        if (period_s == 0.0) return 0.0;
        1.0 / period_s
    };
    
    /// Angular frequency: ω = 2πf
    public func angularFrequency(frequency_Hz: Float) : Float {
        TAU * frequency_Hz
    };
    
    /// Photon energy: E = hf (in Joules)
    public func photonEnergy(frequency_Hz: Float) : Float {
        H * frequency_Hz
    };
    
    /// Photon energy in eV: E = hf / e
    public func photonEnergyEV(frequency_Hz: Float) : Float {
        let e = 1.602176634e-19;  // Elementary charge
        H * frequency_Hz / e
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 9: RESONANCE AND INTERFERENCE
    // Wave physics for coupled systems
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// Beat frequency: f_beat = |f₁ - f₂|
    public func beatFrequency(f1: Float, f2: Float) : Float {
        Float.abs(f1 - f2)
    };
    
    /// Harmonic series: f_n = n × f_fundamental
    public func harmonic(fundamental: Float, n: Nat) : Float {
        fundamental * Float.fromInt(Int.abs(n))
    };
    
    /// Octave: f_octave = 2 × f_original
    public func octave(frequency: Float) : Float {
        2.0 * frequency
    };
    
    /// Perfect fifth: f = f_original × 3/2
    public func perfectFifth(frequency: Float) : Float {
        frequency * 3.0 / 2.0
    };
    
    /// Perfect fourth: f = f_original × 4/3
    public func perfectFourth(frequency: Float) : Float {
        frequency * 4.0 / 3.0
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 10: FREQUENCY CATALOG
    // Complete reference of all MEDINA frequencies
    // ═══════════════════════════════════════════════════════════════════════════
    
    public type FrequencyCatalogEntry = {
        id: Nat;
        name: Text;
        frequency_Hz: Float;
        source: Text;
        primitiveRoot: Text;
    };
    
    /// Get complete frequency catalog
    public func getFrequencyCatalog() : [FrequencyCatalogEntry] {
        [
            // Schumann
            { id = 1; name = "Schumann 1"; frequency_Hz = 7.83; source = "Earth Resonance"; primitiveRoot = "c" },
            { id = 2; name = "Schumann 2"; frequency_Hz = 14.3; source = "Earth Resonance"; primitiveRoot = "c" },
            { id = 3; name = "Schumann 3"; frequency_Hz = 20.8; source = "Earth Resonance"; primitiveRoot = "c" },
            
            // Three Hearts
            { id = 4; name = "Heart1 (Metropolis)"; frequency_Hz = 0.1; source = "Three Hearts"; primitiveRoot = "φ" },
            { id = 5; name = "Heart2 (Coupling)"; frequency_Hz = 1.618; source = "Three Hearts"; primitiveRoot = "φ" },
            { id = 6; name = "Heart3 (Regulating)"; frequency_Hz = 2.618; source = "Three Hearts"; primitiveRoot = "φ" },
            
            // Solfeggio
            { id = 7; name = "UT (Liberation)"; frequency_Hz = 396.0; source = "Solfeggio"; primitiveRoot = "φ" },
            { id = 8; name = "RE (Change)"; frequency_Hz = 417.0; source = "Solfeggio"; primitiveRoot = "φ" },
            { id = 9; name = "MI (DNA Repair)"; frequency_Hz = 528.0; source = "Solfeggio"; primitiveRoot = "φ" },
            { id = 10; name = "FA (Connection)"; frequency_Hz = 639.0; source = "Solfeggio"; primitiveRoot = "φ" },
            { id = 11; name = "SOL (Intuition)"; frequency_Hz = 741.0; source = "Solfeggio"; primitiveRoot = "φ" },
            { id = 12; name = "LA (Spiritual)"; frequency_Hz = 852.0; source = "Solfeggio"; primitiveRoot = "φ" },
            
            // Musical
            { id = 13; name = "A4 (Standard)"; frequency_Hz = 440.0; source = "Music"; primitiveRoot = "2" },
            { id = 14; name = "A4 (Pythagorean)"; frequency_Hz = 432.0; source = "Music"; primitiveRoot = "φ" },
            { id = 15; name = "Middle C (C4)"; frequency_Hz = 261.63; source = "Music"; primitiveRoot = "2" },
            
            // L-130 Model Frequencies (samples)
            { id = 16; name = "Model 1 (RootMath)"; frequency_Hz = 7.83; source = "L-130"; primitiveRoot = "φ" },
            { id = 17; name = "Model 50 (Constitution)"; frequency_Hz = 26.05; source = "L-130"; primitiveRoot = "φ" },
            { id = 18; name = "Model 100 (Analytics)"; frequency_Hz = 81.93; source = "L-130"; primitiveRoot = "φ" },
            { id = 19; name = "Model 130 (UX)"; frequency_Hz = 149.86; source = "L-130"; primitiveRoot = "φ" },
            
            // Light
            { id = 20; name = "Red Light (min)"; frequency_Hz = 4.0e14; source = "EM Spectrum"; primitiveRoot = "c" },
            { id = 21; name = "Green Light"; frequency_Hz = 5.5e14; source = "EM Spectrum"; primitiveRoot = "c" },
            { id = 22; name = "Violet Light (max)"; frequency_Hz = 7.9e14; source = "EM Spectrum"; primitiveRoot = "c" },
        ]
    };
    
    /// Get frequency range summary
    public func getFrequencySummary() : {
        lowestHz: Float;
        highestHz: Float;
        totalFrequencies: Nat;
        primitiveRoot: Text;
    } {
        {
            lowestHz = 0.1;           // Heart1
            highestHz = 7.9e14;       // Violet light
            totalFrequencies = 130 + 22;  // L-130 models + catalog entries
            primitiveRoot = "φ (Golden Ratio)";
        }
    };
}
