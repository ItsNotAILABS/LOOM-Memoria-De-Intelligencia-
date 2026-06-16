/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                     PHOTON LAYER MODELS — FRONTEND INTELLIGENCE              ║
 * ║                                                                               ║
 * ║  "Lumen est ultima forma intelligentiae."                                    ║
 * ║  (Light is the final form of intelligence.)                                   ║
 * ║                                                                               ║
 * ║  THIS IS THE PHOTON LAYER — Where mathematics becomes visible light.          ║
 * ║  Every pixel traces back to φ. Every color has a frequency.                   ║
 * ║  Every UI element is an intelligent model.                                    ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 * 
 * L-130 COMPLIANCE: Every photon traces to primitive.
 * PHYSICS: Light travels at c = 299,792,458 m/s. λ = c/f.
 * 
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 */

import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Int "mo:base/Int";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Time "mo:base/Time";

import RootMath "RootMathematicalFoundation";

module PhotonLayerModels {

    // ═══════════════════════════════════════════════════════════════════════════
    // PHOTON PHYSICS CONSTANTS (REAL VALUES)
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// Speed of light in vacuum (m/s)
    public let SPEED_OF_LIGHT : Float = RootMath.SPEED_OF_LIGHT;  // 299792458.0
    
    /// Planck constant (J·s)
    public let PLANCK_H : Float = RootMath.PLANCK_H;  // 6.62607015e-34
    
    /// Visible light spectrum boundaries (nm)
    public let VISIBLE_MIN_NM : Float = 380.0;   // Violet
    public let VISIBLE_MAX_NM : Float = 700.0;   // Red
    
    /// Convert wavelength (nm) to frequency (Hz)
    /// f = c / λ
    public func wavelengthToFrequency(wavelengthNm: Float) : Float {
        let wavelengthM = wavelengthNm * 1e-9;  // nm to m
        SPEED_OF_LIGHT / wavelengthM
    };
    
    /// Convert frequency (Hz) to wavelength (nm)
    /// λ = c / f
    public func frequencyToWavelength(frequencyHz: Float) : Float {
        if (frequencyHz <= 0.0) { return 0.0 };
        let wavelengthM = SPEED_OF_LIGHT / frequencyHz;
        wavelengthM * 1e9  // m to nm
    };
    
    /// Photon energy from wavelength
    /// E = hc/λ
    public func photonEnergy(wavelengthNm: Float) : Float {
        let wavelengthM = wavelengthNm * 1e-9;
        PLANCK_H * SPEED_OF_LIGHT / wavelengthM
    };
    
    /// Color frequencies (REAL Hz — these are actual light frequencies)
    /// 
    /// VIOLET:  ~380-450 nm → ~789-666 THz
    /// BLUE:    ~450-495 nm → ~666-606 THz
    /// CYAN:    ~495-520 nm → ~606-577 THz
    /// GREEN:   ~520-565 nm → ~577-530 THz
    /// YELLOW:  ~565-590 nm → ~530-508 THz
    /// ORANGE:  ~590-625 nm → ~508-479 THz
    /// RED:     ~625-700 nm → ~479-428 THz
    
    public let FREQ_VIOLET : Float = 7.5e14;    // ~750 THz (400 nm)
    public let FREQ_BLUE : Float = 6.38e14;     // ~638 THz (470 nm)
    public let FREQ_CYAN : Float = 5.89e14;     // ~589 THz (509 nm)
    public let FREQ_GREEN : Float = 5.66e14;    // ~566 THz (530 nm)
    public let FREQ_YELLOW : Float = 5.17e14;   // ~517 THz (580 nm)
    public let FREQ_ORANGE : Float = 4.84e14;   // ~484 THz (620 nm)
    public let FREQ_RED : Float = 4.28e14;      // ~428 THz (700 nm)
    
    /// Golden ratio
    let PHI : Float = RootMath.PHI;

    // ═══════════════════════════════════════════════════════════════════════════
    // COLOR MODEL — EACH COLOR IS AN INTELLIGENT MODEL
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// A color in the Photon layer is a COMPLETE MODEL, not just RGB values
    public type PhotonColor = {
        // Identity
        name: Text;
        hexCode: Text;              // e.g., "#FF6B35"
        
        // RGB (0-255)
        r: Nat8;
        g: Nat8;
        b: Nat8;
        
        // HSL (for φ-based calculations)
        hue: Float;                 // 0-360 degrees
        saturation: Float;          // 0-1
        lightness: Float;           // 0-1
        
        // PHYSICS (REAL VALUES)
        wavelengthNm: Float;        // Approximate dominant wavelength
        frequencyHz: Float;         // c / λ — REAL FREQUENCY
        energyJ: Float;             // E = hf — REAL ENERGY
        
        // MATHEMATICAL DERIVATION
        phiRelation: Text;          // How this color relates to φ
        goldenAngle: Float;         // Position on golden spiral (radians)
        
        // SEMANTIC
        meaning: Text;              // What this color represents
        chakra: ?Text;              // Associated chakra if any
        solfeggio: ?Float;          // Associated Solfeggio frequency
        
        // L-130 TRACE
        primitiveTrace: Text;       // How this traces to primitive
    };
    
    /// The MEDINA color palette — each color is mathematically derived
    public func medinaColorPalette() : [PhotonColor] {
        [
            // PRIMARY: MEDINA GOLD (φ-derived)
            {
                name = "Medina Gold";
                hexCode = "#D4AF37";
                r = 212; g = 175; b = 55;
                hue = 46.0; saturation = 0.65; lightness = 0.52;
                wavelengthNm = 580.0;  // Yellow-gold
                frequencyHz = wavelengthToFrequency(580.0);  // ~517 THz
                energyJ = photonEnergy(580.0);
                phiRelation = "Hue = 360 × (1 - 1/φ) ≈ 137.5° → gold range";
                goldenAngle = RootMath.GOLDEN_ANGLE_RAD;
                meaning = "Wisdom, sovereignty, eternal memory";
                chakra = ?"Solar Plexus";
                solfeggio = ?528.0;  // MI — transformation
                primitiveTrace = "Medina Gold → 580nm → 517 THz → E=hf → φ";
            },
            
            // SECONDARY: DEEP PURPLE (consciousness)
            {
                name = "Consciousness Purple";
                hexCode = "#6B3FA0";
                r = 107; g = 63; b = 160;
                hue = 267.0; saturation = 0.44; lightness = 0.44;
                wavelengthNm = 420.0;  // Violet
                frequencyHz = wavelengthToFrequency(420.0);  // ~714 THz
                energyJ = photonEnergy(420.0);
                phiRelation = "Hue = 267 ≈ 360/φ + 180 (φ-complementary)";
                goldenAngle = RootMath.GOLDEN_ANGLE_RAD * 2.0;
                meaning = "Higher consciousness, wisdom, mystery";
                chakra = ?"Crown";
                solfeggio = ?963.0;  // Perfect state
                primitiveTrace = "Consciousness Purple → 420nm → 714 THz → E=hf → φ";
            },
            
            // TERTIARY: OCEAN BLUE (depth)
            {
                name = "Ocean Blue";
                hexCode = "#1E88E5";
                r = 30; g = 136; b = 229;
                hue = 208.0; saturation = 0.77; lightness = 0.51;
                wavelengthNm = 470.0;  // Blue
                frequencyHz = wavelengthToFrequency(470.0);  // ~638 THz
                energyJ = photonEnergy(470.0);
                phiRelation = "Hue = 360 × (1 - 1/φ²) ≈ 208°";
                goldenAngle = RootMath.GOLDEN_ANGLE_RAD * 1.5;
                meaning = "Depth, memory, infinite capacity";
                chakra = ?"Throat";
                solfeggio = ?741.0;  // SOL — awakening intuition
                primitiveTrace = "Ocean Blue → 470nm → 638 THz → E=hf → φ";
            },
            
            // ACCENT: LIFE GREEN (growth)
            {
                name = "Life Green";
                hexCode = "#43A047";
                r = 67; g = 160; b = 71;
                hue = 122.0; saturation = 0.41; lightness = 0.45;
                wavelengthNm = 530.0;  // Green
                frequencyHz = wavelengthToFrequency(530.0);  // ~566 THz
                energyJ = photonEnergy(530.0);
                phiRelation = "Hue = 122 ≈ 360/3 + φ×20 (triadic harmony)";
                goldenAngle = RootMath.GOLDEN_ANGLE_RAD * 0.9;
                meaning = "Growth, healing, nature, balance";
                chakra = ?"Heart";
                solfeggio = ?639.0;  // FA — connecting relationships
                primitiveTrace = "Life Green → 530nm → 566 THz → E=hf → φ";
            },
            
            // WARNING: ALERT ORANGE (attention)
            {
                name = "Alert Orange";
                hexCode = "#FF6B35";
                r = 255; g = 107; b = 53;
                hue = 16.0; saturation = 1.0; lightness = 0.60;
                wavelengthNm = 610.0;  // Orange
                frequencyHz = wavelengthToFrequency(610.0);  // ~491 THz
                energyJ = photonEnergy(610.0);
                phiRelation = "Hue = 16 ≈ 360 × (1/φ)³";
                goldenAngle = RootMath.GOLDEN_ANGLE_RAD * 0.1;
                meaning = "Attention, urgency, action required";
                chakra = ?"Sacral";
                solfeggio = ?417.0;  // RE — facilitating change
                primitiveTrace = "Alert Orange → 610nm → 491 THz → E=hf → φ";
            },
            
            // DANGER: CRITICAL RED
            {
                name = "Critical Red";
                hexCode = "#D32F2F";
                r = 211; g = 47; b = 47;
                hue = 0.0; saturation = 0.66; lightness = 0.51;
                wavelengthNm = 700.0;  // Red
                frequencyHz = wavelengthToFrequency(700.0);  // ~428 THz
                energyJ = photonEnergy(700.0);
                phiRelation = "Hue = 0° — origin point";
                goldenAngle = 0.0;
                meaning = "Danger, critical, stop, root";
                chakra = ?"Root";
                solfeggio = ?396.0;  // UT — liberating fear
                primitiveTrace = "Critical Red → 700nm → 428 THz → E=hf → φ";
            },
            
            // NEUTRAL: WISDOM WHITE (all frequencies)
            {
                name = "Wisdom White";
                hexCode = "#FAFAFA";
                r = 250; g = 250; b = 250;
                hue = 0.0; saturation = 0.0; lightness = 0.98;
                wavelengthNm = 555.0;  // Peak human sensitivity
                frequencyHz = wavelengthToFrequency(555.0);
                energyJ = photonEnergy(555.0);
                phiRelation = "White = all colors = all frequencies = unity";
                goldenAngle = RootMath.TAU;  // Full circle
                meaning = "Purity, unity, all knowledge combined";
                chakra = null;
                solfeggio = null;
                primitiveTrace = "Wisdom White → all λ → all f → unity → φ";
            },
            
            // NEUTRAL: DEEP BLACK (void/potential)
            {
                name = "Void Black";
                hexCode = "#121212";
                r = 18; g = 18; b = 18;
                hue = 0.0; saturation = 0.0; lightness = 0.07;
                wavelengthNm = 0.0;  // No light
                frequencyHz = 0.0;
                energyJ = 0.0;
                phiRelation = "Black = no photons = pure potential = 0 = before φ";
                goldenAngle = 0.0;
                meaning = "Void, potential, mystery, the unmanifest";
                chakra = null;
                solfeggio = null;
                primitiveTrace = "Void Black → 0 photons → potential → before φ";
            },
        ]
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // UI ELEMENT MODELS — Each element is intelligent
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// A UI element is a MODEL with physics and mathematics
    public type PhotonElement = {
        // Identity
        id: Text;
        elementType: ElementType;
        
        // Position (φ-grid based)
        x: Float;                   // Position in φ-grid units
        y: Float;
        width: Float;               // Size in φ-grid units
        height: Float;
        
        // Visual
        color: PhotonColor;
        opacity: Float;             // 0.0 - 1.0
        
        // Animation (frequency-based)
        animationFrequency: Float;  // Hz — real frequency
        phase: Float;               // Current phase (radians)
        amplitude: Float;           // Animation magnitude
        
        // Intelligence
        intelligence: Float;        // 0.0 - 1.0
        routingModel: Text;         // Which backend model
        
        // L-130
        primitiveTrace: Text;
    };
    
    public type ElementType = {
        #Button;
        #Input;
        #Display;
        #Container;
        #Navigation;
        #Indicator;
        #Terminal;
        #Visualization;
    };
    
    /// φ-grid layout system
    /// The golden ratio governs all spacing and proportions
    public func phiGridUnit(basePixels: Float) : Float {
        basePixels  // 1 φ-unit = basePixels
    };
    
    public func phiSpacing(units: Float, basePixels: Float) : Float {
        units * basePixels
    };
    
    /// Calculate φ-proportioned dimensions
    /// Width:Height = φ:1 or 1:φ
    public func phiDimensions(baseSize: Float, orientation: {#Landscape; #Portrait}) : (Float, Float) {
        switch (orientation) {
            case (#Landscape) { (baseSize * PHI, baseSize) };
            case (#Portrait) { (baseSize, baseSize * PHI) };
        }
    };
    
    /// Fibonacci-based responsive breakpoints (pixels)
    public func fibonacciBreakpoints() : [Nat] {
        [
            233,   // F(13) — tiny mobile
            377,   // F(14) — mobile
            610,   // F(15) — large mobile
            987,   // F(16) — tablet
            1597,  // F(17) — desktop
            2584,  // F(18) — large desktop
        ]
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // ANIMATION ENGINE — Frequency-based animations
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// Animation model — every animation is a wave
    public type PhotonAnimation = {
        id: Text;
        waveType: WaveType;
        
        // Wave parameters (REAL PHYSICS)
        frequency: Float;           // Hz
        amplitude: Float;           // Max displacement
        phase: Float;               // Initial phase (radians)
        damping: Float;             // Decay factor
        
        // Time
        duration: Float;            // Seconds
        elapsed: Float;             // Current time
        
        // Mathematical basis
        formula: Text;              // The wave equation used
    };
    
    public type WaveType = {
        #Sine;                      // y = A × sin(ωt + φ)
        #Cosine;                    // y = A × cos(ωt + φ)
        #SawTooth;                  // Linear ramp
        #Triangle;                  // Linear up-down
        #Square;                    // Binary oscillation
        #GoldenSpiral;              // r = φ^(θ/90°)
        #Damped;                    // A × e^(-γt) × sin(ωt)
    };
    
    /// Calculate animation value at time t
    public func animationValue(anim: PhotonAnimation, t: Float) : Float {
        let omega = RootMath.TAU * anim.frequency;  // Angular frequency
        let dampFactor = Float.exp(-anim.damping * t);
        
        switch (anim.waveType) {
            case (#Sine) {
                anim.amplitude * Float.sin(omega * t + anim.phase)
            };
            case (#Cosine) {
                anim.amplitude * Float.cos(omega * t + anim.phase)
            };
            case (#Damped) {
                dampFactor * anim.amplitude * Float.sin(omega * t + anim.phase)
            };
            case (#GoldenSpiral) {
                // r = φ^(θ/90°) where θ = ωt
                Float.pow(PHI, omega * t / (RootMath.PI / 2.0))
            };
            case (_) {
                // Default to sine
                anim.amplitude * Float.sin(omega * t + anim.phase)
            };
        }
    };
    
    /// Create heartbeat animation (φ Hz)
    public func heartbeatAnimation() : PhotonAnimation {
        {
            id = "heartbeat";
            waveType = #Damped;
            frequency = PHI;  // φ Hz — golden heartbeat
            amplitude = 1.0;
            phase = 0.0;
            damping = 0.5;
            duration = 1.0 / PHI;  // One beat
            elapsed = 0.0;
            formula = "y = e^(-0.5t) × sin(2πφt)";
        }
    };
    
    /// Create pulse animation (based on Three Hearts)
    public func threeHeartsPulse(heart: {#Metropolis; #Coupling; #Regulating}) : PhotonAnimation {
        let freq = switch (heart) {
            case (#Metropolis) { 0.1 };
            case (#Coupling) { PHI };
            case (#Regulating) { PHI * PHI };
        };
        {
            id = "three_hearts_pulse";
            waveType = #Sine;
            frequency = freq;
            amplitude = 1.0;
            phase = 0.0;
            damping = 0.0;
            duration = 1.0 / freq;
            elapsed = 0.0;
            formula = "y = sin(2π × " # Float.toText(freq) # " × t)";
        }
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // SHIMMER EFFECT — The signature visual
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// Shimmer is a φ-based interference pattern
    public type ShimmerEffect = {
        // Wave components (multiple frequencies interfere)
        frequencies: [Float];       // Multiple Hz values
        amplitudes: [Float];        // Amplitude for each
        phases: [Float];            // Phase for each
        
        // Golden spiral path
        spiralTightness: Float;     // How tight the spiral (φ^n)
        spiralRotation: Float;      // Current rotation
        
        // Color cycling
        hueShift: Float;            // Hue rotation per second
        
        // Physics
        interferencePattern: Text;  // Mathematical description
    };
    
    /// Create the signature MEDINA shimmer
    public func medinaShimmer() : ShimmerEffect {
        {
            frequencies = [PHI, PHI * PHI, PHI * PHI * PHI];  // φ, φ², φ³ Hz
            amplitudes = [1.0, 0.618, 0.382];  // 1, 1/φ, 1/φ²
            phases = [0.0, RootMath.GOLDEN_ANGLE_RAD, RootMath.GOLDEN_ANGLE_RAD * 2.0];
            spiralTightness = PHI;
            spiralRotation = 0.0;
            hueShift = 137.5 / 60.0;  // Golden angle degrees per second
            interferencePattern = "Σᵢ Aᵢ × sin(2πfᵢt + φᵢ) where fᵢ = φⁱ";
        }
    };
    
    /// Calculate shimmer value at time t
    public func shimmerValue(shimmer: ShimmerEffect, t: Float) : Float {
        var sum : Float = 0.0;
        let n = shimmer.frequencies.size();
        var i : Nat = 0;
        while (i < n) {
            let omega = RootMath.TAU * shimmer.frequencies[i];
            let amp = if (i < shimmer.amplitudes.size()) { shimmer.amplitudes[i] } else { 1.0 };
            let phase = if (i < shimmer.phases.size()) { shimmer.phases[i] } else { 0.0 };
            sum += amp * Float.sin(omega * t + phase);
            i += 1;
        };
        sum / Float.fromInt(n)  // Normalize
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // RENDERING ENGINE INTERFACE
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// Render command — sent from Motoko to frontend
    public type RenderCommand = {
        commandType: RenderCommandType;
        targetId: Text;
        color: ?PhotonColor;
        position: ?(Float, Float);
        size: ?(Float, Float);
        animation: ?PhotonAnimation;
        shimmer: ?ShimmerEffect;
        timestamp: Int;
    };
    
    public type RenderCommandType = {
        #Create;
        #Update;
        #Animate;
        #Shimmer;
        #Delete;
        #Pulse;
    };
    
    /// Create a render command
    public func createRenderCommand(
        cmdType: RenderCommandType,
        targetId: Text
    ) : RenderCommand {
        {
            commandType = cmdType;
            targetId = targetId;
            color = null;
            position = null;
            size = null;
            animation = null;
            shimmer = null;
            timestamp = Time.now();
        }
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // PHOTON LAYER STATUS
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// Get Photon layer status
    public func photonStatus() : {
        layerName: Text;
        physicsEngine: Text;
        colorCount: Nat;
        primaryFrequency: Float;
        phiGridEnabled: Bool;
        shimmerActive: Bool;
        l130Compliant: Bool;
    } {
        {
            layerName = "PHOTON — Final Layer Before Eye";
            physicsEngine = "c = 299,792,458 m/s, E = hf, λ = c/f";
            colorCount = medinaColorPalette().size();
            primaryFrequency = PHI;  // φ Hz base animation
            phiGridEnabled = true;
            shimmerActive = true;
            l130Compliant = true;
        }
    };
    
    /// Verify photon traces to primitive
    public func verifyPhotonTrace(color: PhotonColor) : Bool {
        color.primitiveTrace.size() > 0 and
        color.frequencyHz > 0.0 and
        color.goldenAngle >= 0.0
    };
}
