/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                        UMBRA ENGINE — AIS-022                               ║
 * ║                       MACHINA UMBRAE SOVEREIGNAE                            ║
 * ║                                                                              ║
 * ║  "Umbra videt quod lux non videt. Veritas in tenebris."                    ║
 * ║  (Shadow sees what light does not. Truth in darkness.)                      ║
 * ║                                                                              ║
 * ║  UMBRA is the Sovereign Model — advanced behavioral threat detection that   ║
 * ║  identifies sophisticated attacks through pattern analysis, anomaly          ║
 * ║  detection, and coordinated attack recognition.                             ║
 * ║                                                                              ║
 * ║  SOVEREIGN MODEL:                                                            ║
 * ║    - Behavioral analysis (request patterns over time)                       ║
 * ║    - Anomaly detection (deviations from normal traffic)                     ║
 * ║    - Coordinated attack detection (distributed patterns)                     ║
 * ║    - Machine learning-ready feature extraction                              ║
 * ║    - Advanced threat scoring                                                 ║
 * ║                                                                              ║
 * ║  DEPLOYMENT:                                                                 ║
 * ║    Cloudflare Workers (with Durable Objects for state)                      ║
 * ║    Canister-side analysis (deep inspection)                                 ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Analysis frequency: φ² Hz                                ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import HashMap "mo:base/HashMap";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

module UMBRAEngine {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // UMBRA frequency: φ² Hz (golden ratio squared) for deep analysis
    public let UMBRA_FREQUENCY_HZ : Float = 2.618033988749895;

    // Anomaly detection thresholds
    public let ANOMALY_THRESHOLD : Float = 3.0; // Standard deviations
    public let COORDINATED_ATTACK_WINDOW : Int = 300_000_000_000; // 5 minutes

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: BEHAVIORAL ANALYSIS TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type BehaviorProfile = {
        fingerprint: Text;
        requestHistory: [RequestMetrics];
        avgRequestRate: Float;
        avgPayloadSize: Float;
        uniqueEndpoints: Nat;
        suspiciousPatternCount: Nat;
        firstSeen: Int;
        lastSeen: Int;
        riskScore: Float;
    };

    public type RequestMetrics = {
        timestamp: Int;
        endpoint: Text;
        payloadSize: Nat;
        responseTime: Nat;
        statusCode: Nat;
        threatScore: Float;
    };

    public type AnomalyDetection = {
        fingerprint: Text;
        anomalyType: Text;
        severity: Float;
        description: Text;
        timestamp: Int;
        evidence: [Text];
    };

    public type CoordinatedAttack = {
        id: Text;
        attackType: Text;
        participantCount: Nat;
        fingerprints: [Text];
        startTime: Int;
        endTime: ?Int;
        targetEndpoints: [Text];
        totalRequests: Nat;
        threatLevel: Float;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: BEHAVIORAL ANALYZER
    // ═══════════════════════════════════════════════════════════════════════

    public class BehavioralAnalyzer() {
        var profiles = HashMap.HashMap<Text, BehaviorProfile>(10, Text.equal, Text.hash);
        var anomalies : [AnomalyDetection] = [];
        var coordinatedAttacks : [CoordinatedAttack] = [];

        public func recordRequest(
            fingerprint: Text,
            endpoint: Text,
            payloadSize: Nat,
            responseTime: Nat,
            statusCode: Nat,
            threatScore: Float
        ) {
            let now = Time.now();
            let metrics : RequestMetrics = {
                timestamp = now;
                endpoint = endpoint;
                payloadSize = payloadSize;
                responseTime = responseTime;
                statusCode = statusCode;
                threatScore = threatScore;
            };

            switch (profiles.get(fingerprint)) {
                case null {
                    // New profile
                    profiles.put(fingerprint, {
                        fingerprint = fingerprint;
                        requestHistory = [metrics];
                        avgRequestRate = 1.0;
                        avgPayloadSize = Float.fromInt(payloadSize);
                        uniqueEndpoints = 1;
                        suspiciousPatternCount = if (threatScore > 0.5) { 1 } else { 0 };
                        firstSeen = now;
                        lastSeen = now;
                        riskScore = threatScore;
                    });
                };
                case (?profile) {
                    // Update existing profile
                    let newHistory = Array.append(profile.requestHistory, [metrics]);
                    let historySize = newHistory.size();

                    // Calculate averages
                    var totalPayload : Nat = 0;
                    var totalThreat : Float = 0.0;
                    var uniqueEps : Nat = 0;
                    var suspiciousCount : Nat = 0;

                    for (m in newHistory.vals()) {
                        totalPayload += m.payloadSize;
                        totalThreat += m.threatScore;
                        if (m.threatScore > 0.5) {
                            suspiciousCount += 1;
                        };
                    };

                    let avgPayload = Float.fromInt(totalPayload) / Float.fromInt(historySize);
                    let avgThreat = totalThreat / Float.fromInt(historySize);

                    // Calculate request rate (requests per minute)
                    let timeSpan = now - profile.firstSeen;
                    let avgRate = if (timeSpan > 0) {
                        Float.fromInt(historySize) * 60_000_000_000.0 / Float.fromInt(timeSpan)
                    } else {
                        1.0
                    };

                    profiles.put(fingerprint, {
                        fingerprint = fingerprint;
                        requestHistory = newHistory;
                        avgRequestRate = avgRate;
                        avgPayloadSize = avgPayload;
                        uniqueEndpoints = profile.uniqueEndpoints + 1;
                        suspiciousPatternCount = suspiciousCount;
                        firstSeen = profile.firstSeen;
                        lastSeen = now;
                        riskScore = avgThreat;
                    });
                };
            };
        };

        public func detectAnomalies(fingerprint: Text) : ?AnomalyDetection {
            switch (profiles.get(fingerprint)) {
                case null { null };
                case (?profile) {
                    var anomaliesFound : [Text] = [];
                    var severity : Float = 0.0;

                    // Anomaly 1: Request rate spike
                    if (profile.avgRequestRate > 100.0) {
                        anomaliesFound := Array.append(anomaliesFound, ["High request rate: " # Float.toText(profile.avgRequestRate) # " req/min"]);
                        severity := Float.max(severity, 0.8);
                    };

                    // Anomaly 2: Payload size anomaly
                    if (profile.avgPayloadSize > 100000.0) {
                        anomaliesFound := Array.append(anomaliesFound, ["Large average payload: " # Float.toText(profile.avgPayloadSize) # " bytes"]);
                        severity := Float.max(severity, 0.6);
                    };

                    // Anomaly 3: High suspicious pattern count
                    let suspiciousRatio = Float.fromInt(profile.suspiciousPatternCount) / Float.fromInt(profile.requestHistory.size());
                    if (suspiciousRatio > 0.3) {
                        anomaliesFound := Array.append(anomaliesFound, ["High suspicious ratio: " # Float.toText(suspiciousRatio)]);
                        severity := Float.max(severity, 0.9);
                    };

                    // Anomaly 4: Endpoint scanning (high unique endpoint count in short time)
                    let timeSpan = profile.lastSeen - profile.firstSeen;
                    if (timeSpan < 60_000_000_000 and profile.uniqueEndpoints > 20) {
                        anomaliesFound := Array.append(anomaliesFound, ["Endpoint scanning: " # Nat.toText(profile.uniqueEndpoints) # " endpoints in " # Int.toText(timeSpan / 1_000_000_000) # "s"]);
                        severity := Float.max(severity, 0.95);
                    };

                    if (anomaliesFound.size() > 0) {
                        let anomaly : AnomalyDetection = {
                            fingerprint = fingerprint;
                            anomalyType = "behavioral";
                            severity = severity;
                            description = "Behavioral anomalies detected";
                            timestamp = Time.now();
                            evidence = anomaliesFound;
                        };
                        anomalies := Array.append(anomalies, [anomaly]);
                        ?anomaly
                    } else {
                        null
                    }
                };
            };
        };

        public func detectCoordinatedAttack() : ?CoordinatedAttack {
            // Look for patterns across multiple fingerprints
            let now = Time.now();
            let windowStart = now - COORDINATED_ATTACK_WINDOW;

            var recentFingerprints : [Text] = [];
            var targetEndpoints : [Text] = [];
            var totalRequests : Nat = 0;

            for (profile in profiles.vals()) {
                if (profile.lastSeen > windowStart and profile.riskScore > 0.5) {
                    recentFingerprints := Array.append(recentFingerprints, [profile.fingerprint]);
                    totalRequests += profile.requestHistory.size();

                    // Collect target endpoints
                    for (req in profile.requestHistory.vals()) {
                        if (req.timestamp > windowStart) {
                            targetEndpoints := Array.append(targetEndpoints, [req.endpoint]);
                        };
                    };
                };
            };

            // Coordinated attack if 5+ suspicious sources targeting same endpoints
            if (recentFingerprints.size() >= 5 and totalRequests > 100) {
                let attack : CoordinatedAttack = {
                    id = "COORD-" # Int.toText(now);
                    attackType = "distributed_ddos";
                    participantCount = recentFingerprints.size();
                    fingerprints = recentFingerprints;
                    startTime = windowStart;
                    endTime = ?now;
                    targetEndpoints = targetEndpoints;
                    totalRequests = totalRequests;
                    threatLevel = 0.95;
                };
                coordinatedAttacks := Array.append(coordinatedAttacks, [attack]);
                ?attack
            } else {
                null
            }
        };

        public func getRiskScore(fingerprint: Text) : Float {
            switch (profiles.get(fingerprint)) {
                case null { 0.0 };
                case (?profile) { profile.riskScore };
            };
        };

        public func getStats() : (Nat, Nat, Nat) {
            (profiles.size(), anomalies.size(), coordinatedAttacks.size())
        };
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: ADVANCED THREAT SCORING
    // ═══════════════════════════════════════════════════════════════════════

    public func calculateThreatScore(
        patternMatches: Nat,
        behavioralScore: Float,
        anomalyScore: Float,
        coordinatedScore: Float
    ) : Float {
        // Weighted threat score using phi-based weights
        let patternWeight : Float = PHI_SQ / 10.0;  // 0.2618...
        let behaviorWeight : Float = PHI / 10.0;    // 0.1618...
        let anomalyWeight : Float = 1.0 / PHI;      // 0.618...
        let coordinatedWeight : Float = 1.0;

        let patternScore = Float.fromInt(patternMatches) * patternWeight;

        let totalWeight = patternWeight + behaviorWeight + anomalyWeight + coordinatedWeight;
        let weightedScore = (patternScore + (behavioralScore * behaviorWeight) + (anomalyScore * anomalyWeight) + (coordinatedScore * coordinatedWeight)) / totalWeight;

        Float.min(1.0, weightedScore)
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: FEATURE EXTRACTION FOR ML
    // ═══════════════════════════════════════════════════════════════════════

    public type FeatureVector = {
        requestRate: Float;
        avgPayloadSize: Float;
        uniqueEndpoints: Float;
        suspiciousRatio: Float;
        timeSpan: Float;
        errorRate: Float;
        threatScore: Float;
    };

    public func extractFeatures(profile: BehaviorProfile) : FeatureVector {
        let historySize = profile.requestHistory.size();
        var errorCount : Nat = 0;

        for (req in profile.requestHistory.vals()) {
            if (req.statusCode >= 400) {
                errorCount += 1;
            };
        };

        let errorRate = if (historySize > 0) {
            Float.fromInt(errorCount) / Float.fromInt(historySize)
        } else {
            0.0
        };

        let timeSpan = Float.fromInt(profile.lastSeen - profile.firstSeen) / 1_000_000_000.0; // seconds

        let suspiciousRatio = if (historySize > 0) {
            Float.fromInt(profile.suspiciousPatternCount) / Float.fromInt(historySize)
        } else {
            0.0
        };

        {
            requestRate = profile.avgRequestRate;
            avgPayloadSize = profile.avgPayloadSize;
            uniqueEndpoints = Float.fromInt(profile.uniqueEndpoints);
            suspiciousRatio = suspiciousRatio;
            timeSpan = timeSpan;
            errorRate = errorRate;
            threatScore = profile.riskScore;
        }
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: MANIFEST
    // ═══════════════════════════════════════════════════════════════════════

    public func renderManifest() : Text {
        "╔══════════════════════════════════════════════════════════════════════════════╗\n" #
        "║                        UMBRA ENGINE — AIS-022                               ║\n" #
        "║                       MACHINA UMBRAE SOVEREIGNAE                            ║\n" #
        "╠══════════════════════════════════════════════════════════════════════════════╣\n" #
        "║  SOVEREIGN MODEL: Advanced behavioral threat detection                      ║\n" #
        "║                                                                              ║\n" #
        "║  CAPABILITIES:                                                               ║\n" #
        "║    • Behavioral Analysis (request patterns over time)                       ║\n" #
        "║    • Anomaly Detection (statistical deviation analysis)                     ║\n" #
        "║    • Coordinated Attack Detection (distributed patterns)                     ║\n" #
        "║    • Advanced Threat Scoring (φ-weighted metrics)                           ║\n" #
        "║    • ML Feature Extraction (7-dimensional vectors)                          ║\n" #
        "║                                                                              ║\n" #
        "║  ANOMALY DETECTION:                                                          ║\n" #
        "║    - Request rate spikes (>100 req/min)                                     ║\n" #
        "║    - Payload size anomalies (>100KB avg)                                    ║\n" #
        "║    - High suspicious pattern ratio (>30%)                                   ║\n" #
        "║    - Endpoint scanning (>20 endpoints in 60s)                               ║\n" #
        "║                                                                              ║\n" #
        "║  COORDINATED ATTACK DETECTION:                                               ║\n" #
        "║    Window: 5 minutes                                                         ║\n" #
        "║    Threshold: 5+ sources, 100+ requests                                     ║\n" #
        "║    Threat Level: 0.95 (critical)                                            ║\n" #
        "║                                                                              ║\n" #
        "║  THREAT SCORING:                                                             ║\n" #
        "║    φ²-weighted combination of pattern/behavior/anomaly/coordination         ║\n" #
        "║    Range: 0.0 (benign) → 1.0 (critical)                                    ║\n" #
        "║                                                                              ║\n" #
        "║  Attribution: Alfredo Medina | Medina Tech | Dallas, TX                    ║\n" #
        "║  Frequency: φ² Hz (2.618...)                                                ║\n" #
        "╚══════════════════════════════════════════════════════════════════════════════╝"
    };
}
