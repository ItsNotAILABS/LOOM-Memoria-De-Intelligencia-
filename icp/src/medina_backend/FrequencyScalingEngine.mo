/**
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                    MEDINA - PROPRIETARY AND CONFIDENTIAL                  ║
 * ║                                                                           ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA   ║
 * ║                       medinasiftech@outlook.com                           ║
 * ║                                                                           ║
 * ║  ALL RIGHTS RESERVED. NO FREE LICENSES. STRICTLY PROPRIETARY.            ║
 * ║                                                                           ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 *
 * FREQUENCY SCALING ENGINE — SCALA FREQUENTIAE MOTORIS
 * "Omnes machinae una frequentia canunt. φ gubernat omnes."
 * (All engines sing one frequency. φ governs all.)
 *
 * AIS-025: FREQUENCY SCALING ENGINE (VIA FREQUENTIAE)
 * Orchestrates 0.01Hz to 900Hz across ALL organism engines.
 *
 * PURPOSE:
 *   - Assigns frequency to EVERY operation in the organism
 *   - Routes requests through frequency-scaled engines
 *   - Harmonizes all computation using φ, Fibonacci, Schumann resonance
 *   - Scales from ultra-slow (blockchain consensus) to ultra-fast (validation)
 *
 * FREQUENCY SPECTRUM:
 *   0.01 - 1 Hz    : ULTRA_SLOW (blockchain consensus, long-term storage)
 *   1 - 10 Hz      : SLOW (analytics, batch processing, archival)
 *   10 - 100 Hz    : STANDARD (normal compute, API calls, queries)
 *   100 - 500 Hz   : FAST (real-time streams, live updates, ML inference)
 *   500 - 900 Hz   : ULTRA_FAST (validation, auth, signature checks)
 *
 * KEY FREQUENCIES:
 *   φ = 1.618 Hz        : Base harmonic (VIGILIA pattern detection)
 *   φ² = 2.618 Hz       : Behavioral analysis (UMBRA)
 *   φ³ = 4.236 Hz       : Circuit breaking (IRONVEIL)
 *   7.83 Hz             : Schumann resonance (Earth sync, consensus)
 *   13, 21, 34 Hz       : Fibonacci checkpoints
 *   55, 89, 144 Hz      : Higher Fibonacci harmonics
 *   432 Hz              : Musical octave (gateway routing)
 *   618 Hz              : φ × 1000 / φ (compute optimization)
 *   900 Hz              : Upper limit (instant validation)
 *
 * PROTOCOL: PROT-111 (Via Frequentiae)
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

module FrequencyScalingEngine {

    // ═══════════════════════════════════════════════════════════════════════
    // CONSTANTS — φ-BASED HARMONICS
    // ═══════════════════════════════════════════════════════════════════════

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895; // φ²
    public let PHI_CUBED : Float = 4.236067977499790; // φ³
    public let SCHUMANN : Float = 7.83; // Earth's resonance
    public let MUSICAL_OCTAVE : Float = 432.0; // Ancient tuning

    // Frequency tier boundaries
    public let ULTRA_SLOW_MIN : Float = 0.01;
    public let ULTRA_SLOW_MAX : Float = 1.0;
    public let SLOW_MIN : Float = 1.0;
    public let SLOW_MAX : Float = 10.0;
    public let STANDARD_MIN : Float = 10.0;
    public let STANDARD_MAX : Float = 100.0;
    public let FAST_MIN : Float = 100.0;
    public let FAST_MAX : Float = 500.0;
    public let ULTRA_FAST_MIN : Float = 500.0;
    public let ULTRA_FAST_MAX : Float = 900.0;

    // Fibonacci checkpoints (Hz)
    public let FIBONACCI_FREQS : [Float] = [
        1.0, 1.0, 2.0, 3.0, 5.0, 8.0, 13.0, 21.0, 34.0, 55.0, 89.0, 144.0
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // TYPE DEFINITIONS
    // ═══════════════════════════════════════════════════════════════════════

    public type FrequencyTier = {
        #ULTRA_SLOW;  // 0.01-1 Hz
        #SLOW;        // 1-10 Hz
        #STANDARD;    // 10-100 Hz
        #FAST;        // 100-500 Hz
        #ULTRA_FAST;  // 500-900 Hz
    };

    public type FrequencyAssignment = {
        frequency : Float;           // Exact frequency in Hz
        tier : FrequencyTier;        // Frequency tier
        timeout : Nat;               // Timeout in milliseconds
        retries : Nat;               // Number of retries allowed
        priority : Float;            // φ-weighted priority score
        harmonicMatch : ?Float;      // Nearest harmonic frequency
    };

    public type EngineFrequency = {
        engineName : Text;
        baseFrequency : Float;
        allowedRange : (Float, Float);
        isPrimary : Bool;
    };

    public type ScalingMetrics = {
        totalRequests : Nat;
        frequencyDistribution : [(FrequencyTier, Nat)];
        avgFrequency : Float;
        harmonicAlignment : Float;  // 0-1 score of φ-harmonic alignment
        peakFrequency : Float;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // ENGINE FREQUENCY REGISTRY
    // ═══════════════════════════════════════════════════════════════════════

    public let ENGINE_FREQUENCIES : [EngineFrequency] = [
        // Edge Engines
        { engineName = "VIGILIA"; baseFrequency = PHI; allowedRange = (PHI, PHI); isPrimary = true },
        { engineName = "UMBRA"; baseFrequency = PHI_SQ; allowedRange = (PHI_SQ, PHI_SQ); isPrimary = true },
        { engineName = "IRONVEIL"; baseFrequency = PHI_CUBED; allowedRange = (PHI_CUBED, PHI_CUBED); isPrimary = true },
        { engineName = "LIMITES_MUNDI_GATEWAY"; baseFrequency = MUSICAL_OCTAVE; allowedRange = (400.0, 450.0); isPrimary = true },
        { engineName = "LIMITES_MUNDI_COMPUTE"; baseFrequency = 618.0; allowedRange = (600.0, 650.0); isPrimary = true },

        // Core Organism
        { engineName = "ORO"; baseFrequency = SCHUMANN; allowedRange = (7.0, 8.5); isPrimary = true },
        { engineName = "NOVA"; baseFrequency = SCHUMANN; allowedRange = (7.0, 8.5); isPrimary = true },

        // Computational Engines
        { engineName = "MatalkoICP"; baseFrequency = PHI; allowedRange = (1.0, 2.0); isPrimary = false },
        { engineName = "CPL"; baseFrequency = 5.0; allowedRange = (3.0, 8.0); isPrimary = false },
        { engineName = "AncientMathEngine"; baseFrequency = 13.0; allowedRange = (10.0, 20.0); isPrimary = false },
        { engineName = "FieldPhysicsEngine"; baseFrequency = 21.0; allowedRange = (15.0, 30.0); isPrimary = false },

        // ML Models (Sovereign)
        { engineName = "VISIO"; baseFrequency = 240.0; allowedRange = (200.0, 300.0); isPrimary = true },
        { engineName = "AUDIO"; baseFrequency = 161.8; allowedRange = (150.0, 180.0); isPrimary = true },
        { engineName = "LINGUA"; baseFrequency = 100.0; allowedRange = (90.0, 120.0); isPrimary = true },
        { engineName = "IMAGO"; baseFrequency = 80.9; allowedRange = (70.0, 90.0); isPrimary = true },
        { engineName = "NUMERUS"; baseFrequency = MUSICAL_OCTAVE; allowedRange = (400.0, 450.0); isPrimary = true },

        // Blockchain Edges
        { engineName = "ETHEREUM_EDGE"; baseFrequency = 0.1; allowedRange = (0.05, 0.5); isPrimary = false },
        { engineName = "BITCOIN_EDGE"; baseFrequency = 0.01; allowedRange = (0.01, 0.1); isPrimary = false },
        { engineName = "ICP_EDGE"; baseFrequency = 1.0; allowedRange = (0.5, 2.0); isPrimary = false },

        // Data Layer
        { engineName = "EDGE_STORAGE"; baseFrequency = 13.0; allowedRange = (10.0, 20.0); isPrimary = false },
        { engineName = "EDGE_ANALYTICS"; baseFrequency = 21.0; allowedRange = (15.0, 30.0); isPrimary = false },
        { engineName = "EDGE_STREAMING"; baseFrequency = 240.0; allowedRange = (200.0, 300.0); isPrimary = false },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // FREQUENCY CALCULATION
    // ═══════════════════════════════════════════════════════════════════════

    /// Calculate optimal frequency for a request
    public func calculateFrequency(
        requestType : Text,
        urgency : Float,
        priority : Float,
        payloadSize : Nat
    ) : FrequencyAssignment {
        // Base frequency from urgency and priority
        let urgencyNorm = Float.min(1.0, Float.max(0.0, urgency));
        let priorityNorm = Float.min(1.0, Float.max(0.0, priority));
        let combined = urgencyNorm * priorityNorm;

        // Scale to 0.01-900 Hz range
        let baseFreq = ULTRA_SLOW_MIN + (combined * (ULTRA_FAST_MAX - ULTRA_SLOW_MIN));

        // Adjust for request type
        let typeMultiplier = getTypeMultiplier(requestType);
        let adjustedFreq = baseFreq * typeMultiplier;

        // Snap to nearest harmonic if close enough
        let harmonic = findNearestHarmonic(adjustedFreq);
        let finalFreq = if (Float.abs(adjustedFreq - harmonic) < 0.5) {
            harmonic
        } else {
            adjustedFreq
        };

        // Determine tier
        let tier = getTier(finalFreq);

        // Calculate timeout: 1000ms / frequency = period in ms
        let timeout = Float.toInt(1000.0 / finalFreq);

        // Calculate retries based on tier
        let retries = getRetries(tier);

        // φ-weighted priority
        let phiPriority = priorityNorm * PHI;

        {
            frequency = finalFreq;
            tier = tier;
            timeout = Int.abs(timeout);
            retries = retries;
            priority = phiPriority;
            harmonicMatch = if (Float.abs(adjustedFreq - harmonic) < 0.5) {
                ?harmonic
            } else {
                null
            };
        }
    };

    /// Get request type multiplier
    func getTypeMultiplier(requestType : Text) : Float {
        switch (requestType) {
            case "validation" { 5.0 };      // Ultra-fast
            case "auth" { 4.5 };            // Very fast
            case "query" { 2.0 };           // Fast
            case "compute" { 1.0 };         // Standard
            case "ml_inference" { 1.5 };    // Fast
            case "storage" { 0.5 };         // Slow
            case "analytics" { 0.3 };       // Slow
            case "blockchain" { 0.1 };      // Ultra-slow
            case _ { 1.0 };                 // Default: standard
        }
    };

    /// Find nearest harmonic frequency (φ, Fibonacci, Schumann, etc.)
    func findNearestHarmonic(freq : Float) : Float {
        let harmonics : [Float] = [
            PHI, PHI_SQ, PHI_CUBED,
            SCHUMANN,
            13.0, 21.0, 34.0, 55.0, 89.0, 144.0,
            MUSICAL_OCTAVE,
            618.0
        ];

        var nearest = harmonics[0];
        var minDist = Float.abs(freq - harmonics[0]);

        for (h in harmonics.vals()) {
            let dist = Float.abs(freq - h);
            if (dist < minDist) {
                minDist := dist;
                nearest := h;
            };
        };

        nearest
    };

    /// Determine frequency tier
    func getTier(freq : Float) : FrequencyTier {
        if (freq >= ULTRA_FAST_MIN and freq <= ULTRA_FAST_MAX) {
            #ULTRA_FAST
        } else if (freq >= FAST_MIN and freq < ULTRA_FAST_MIN) {
            #FAST
        } else if (freq >= STANDARD_MIN and freq < FAST_MIN) {
            #STANDARD
        } else if (freq >= SLOW_MIN and freq < STANDARD_MIN) {
            #SLOW
        } else {
            #ULTRA_SLOW
        }
    };

    /// Get retries based on tier
    func getRetries(tier : FrequencyTier) : Nat {
        switch (tier) {
            case (#ULTRA_SLOW) { 8 };  // Many retries for slow operations
            case (#SLOW) { 5 };
            case (#STANDARD) { 3 };
            case (#FAST) { 2 };
            case (#ULTRA_FAST) { 1 };  // Minimal retries for fast validation
        }
    };

    // ═══════════════════════════════════════════════════════════════════════
    // ENGINE ROUTING
    // ═══════════════════════════════════════════════════════════════════════

    /// Route request to optimal engine based on frequency
    public func routeToEngine(frequency : Float) : ?EngineFrequency {
        var bestEngine : ?EngineFrequency = null;
        var minDist : Float = 1000000.0;

        for (engine in ENGINE_FREQUENCIES.vals()) {
            let dist = Float.abs(frequency - engine.baseFrequency);

            // Check if frequency is within allowed range
            let (minRange, maxRange) = engine.allowedRange;
            let inRange = frequency >= minRange and frequency <= maxRange;

            if (inRange and dist < minDist) {
                minDist := dist;
                bestEngine := ?engine;
            };
        };

        bestEngine
    };

    /// Get engine by name
    public func getEngineByName(name : Text) : ?EngineFrequency {
        Array.find<EngineFrequency>(ENGINE_FREQUENCIES, func(e) { e.engineName == name })
    };

    // ═══════════════════════════════════════════════════════════════════════
    // HARMONIC ANALYSIS
    // ═══════════════════════════════════════════════════════════════════════

    /// Calculate harmonic alignment score (0-1)
    /// How well does the frequency align with φ-based harmonics?
    public func calculateHarmonicAlignment(freq : Float) : Float {
        let nearest = findNearestHarmonic(freq);
        let distance = Float.abs(freq - nearest);
        let maxDistance = 10.0; // Consider within 10Hz as aligned

        let alignment = 1.0 - Float.min(1.0, distance / maxDistance);
        alignment
    };

    /// Get all Fibonacci frequencies up to limit
    public func getFibonacciFrequencies(maxHz : Float) : [Float] {
        Array.filter<Float>(FIBONACCI_FREQS, func(f) { f <= maxHz })
    };

    // ═══════════════════════════════════════════════════════════════════════
    // FREQUENCY SCALING ORCHESTRATION
    // ═══════════════════════════════════════════════════════════════════════

    /// Scale frequency up by φ factor
    public func scaleUp(freq : Float, factor : Nat) : Float {
        var scaled = freq;
        for (i in Int.abs(0)..Int.abs(Int.abs(factor) - 1)) {
            scaled := scaled * PHI;
            if (scaled > ULTRA_FAST_MAX) {
                scaled := ULTRA_FAST_MAX;
            };
        };
        scaled
    };

    /// Scale frequency down by φ factor
    public func scaleDown(freq : Float, factor : Nat) : Float {
        var scaled = freq;
        for (i in Int.abs(0)..Int.abs(Int.abs(factor) - 1)) {
            scaled := scaled / PHI;
            if (scaled < ULTRA_SLOW_MIN) {
                scaled := ULTRA_SLOW_MIN;
            };
        };
        scaled
    };

    /// Convert frequency to human-readable description
    public func frequencyToDescription(freq : Float) : Text {
        if (freq >= ULTRA_FAST_MIN) {
            "ULTRA-FAST: Instant validation, auth, signatures"
        } else if (freq >= FAST_MIN) {
            "FAST: Real-time streams, live updates, ML inference"
        } else if (freq >= STANDARD_MIN) {
            "STANDARD: Normal compute, API calls, queries"
        } else if (freq >= SLOW_MIN) {
            "SLOW: Analytics, batch processing, archival"
        } else {
            "ULTRA-SLOW: Blockchain consensus, long-term storage"
        }
    };

    // ═══════════════════════════════════════════════════════════════════════
    // MANIFEST
    // ═══════════════════════════════════════════════════════════════════════

    public func renderManifest() : Text {
        "╔═══════════════════════════════════════════════════════════════════════╗\n" #
        "║                                                                       ║\n" #
        "║  FREQUENCY SCALING ENGINE — SCALA FREQUENTIAE MOTORIS               ║\n" #
        "║  \"Omnes machinae una frequentia canunt. φ gubernat omnes.\"           ║\n" #
        "║  (All engines sing one frequency. φ governs all.)                    ║\n" #
        "║                                                                       ║\n" #
        "╚═══════════════════════════════════════════════════════════════════════╝\n" #
        "\n" #
        "PROTOCOL: PROT-111 (Via Frequentiae)\n" #
        "AIS-025: Frequency Scaling Engine\n" #
        "\n" #
        "PURPOSE:\n" #
        "  Orchestrates 0.01Hz to 900Hz across ALL organism engines.\n" #
        "  Harmonizes computation using φ, Fibonacci, Schumann resonance.\n" #
        "  Routes requests through frequency-scaled engines.\n" #
        "\n" #
        "FREQUENCY SPECTRUM:\n" #
        "  0.01 - 1 Hz    : ULTRA_SLOW (blockchain consensus, storage)\n" #
        "  1 - 10 Hz      : SLOW (analytics, batch, archival)\n" #
        "  10 - 100 Hz    : STANDARD (compute, APIs, queries)\n" #
        "  100 - 500 Hz   : FAST (real-time, ML inference)\n" #
        "  500 - 900 Hz   : ULTRA_FAST (validation, auth, signatures)\n" #
        "\n" #
        "KEY FREQUENCIES:\n" #
        "  φ = 1.618 Hz      : Base harmonic (VIGILIA)\n" #
        "  φ² = 2.618 Hz     : Behavioral (UMBRA)\n" #
        "  φ³ = 4.236 Hz     : Circuit breaking (IRONVEIL)\n" #
        "  7.83 Hz           : Schumann resonance (ORO/NOVA)\n" #
        "  13, 21, 34 Hz     : Fibonacci checkpoints\n" #
        "  55, 89, 144 Hz    : Higher Fibonacci\n" #
        "  432 Hz            : Musical octave (gateway)\n" #
        "  618 Hz            : φ × 1000 / φ (compute)\n" #
        "  900 Hz            : Upper limit (instant)\n" #
        "\n" #
        "REGISTERED ENGINES: " # Nat.toText(ENGINE_FREQUENCIES.size()) # "\n" #
        "  - Edge: VIGILIA, UMBRA, IRONVEIL, LIMITES_MUNDI\n" #
        "  - Core: ORO, NOVA\n" #
        "  - Compute: MatalkoICP, CPL, AncientMath, FieldPhysics\n" #
        "  - ML: VISIO, AUDIO, LINGUA, IMAGO, NUMERUS\n" #
        "  - Blockchain: Ethereum, Bitcoin, ICP edges\n" #
        "  - Data: Storage, Analytics, Streaming\n" #
        "\n" #
        "CAPABILITIES:\n" #
        "  ✓ Frequency assignment (0.01-900Hz)\n" #
        "  ✓ Harmonic alignment to φ, Fibonacci, Schumann\n" #
        "  ✓ Engine routing based on frequency\n" #
        "  ✓ Timeout/retry calculation per tier\n" #
        "  ✓ φ-based scaling (up/down)\n" #
        "  ✓ Harmonic alignment scoring\n" #
        "\n" #
        "MATHEMATICS:\n" #
        "  f_optimal = 0.01 + (urgency × priority × 899.99)\n" #
        "  timeout = 1000 / f_optimal ms\n" #
        "  harmonic_alignment = 1 - min(1, |f - f_harmonic| / 10)\n" #
        "  scale_up = f × φⁿ (capped at 900Hz)\n" #
        "  scale_down = f / φⁿ (floored at 0.01Hz)\n" #
        "\n" #
        "Attribution: Alfredo Medina | Medina Tech | Dallas, TX\n"
    };
}
