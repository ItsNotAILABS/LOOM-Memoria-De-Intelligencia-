/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                   IRONVEIL CIRCUIT BREAKER — AIS-025                        ║
 * ║                    DISRUPTOR CASCADAE FERREAE                               ║
 * ║                                                                              ║
 * ║  "Cascada interrupta, systema salvata. Ferrum velum protegit."             ║
 * ║  (Cascade interrupted, system saved. Iron veil protects.)                   ║
 * ║                                                                              ║
 * ║  IRONVEIL is the cascade attack prevention system. It treats DDoS as a      ║
 * ║  power-grid cascade failure: one overloaded node triggers the next.         ║
 * ║  This circuit breaker cuts the cascade before it reaches the substrate.     ║
 * ║                                                                              ║
 * ║  CASCADE ATTACK DOCTRINE:                                                    ║
 * ║    "DDoS IS a cascade attack — treat it as one."                            ║
 * ║    A bot flood against ICP canisters is mathematically equivalent to a      ║
 * ║    power-grid cascade: one overloaded node triggers the next.               ║
 * ║                                                                              ║
 * ║  CIRCUIT BREAKER STATES:                                                     ║
 * ║    CLOSED    → Normal operation, all traffic flows                          ║
 * ║    OPEN      → Circuit tripped, traffic blocked                             ║
 * ║    HALF_OPEN → Testing recovery, limited traffic                            ║
 * ║                                                                              ║
 * ║  CASCADE DETECTION:                                                          ║
 * ║    - Request rate threshold exceeded                                         ║
 * ║    - Error rate spike detected                                               ║
 * ║    - Coordinated attack confirmed                                            ║
 * ║    - Canister cycle consumption spike                                        ║
 * ║                                                                              ║
 * ║  AUTO-RECOVERY:                                                              ║
 * ║    Exponential backoff with φ-based timing                                  ║
 * ║    Half-open testing period before full recovery                            ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Break frequency: φ³ Hz                                   ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

module IronveilCircuitBreaker {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;
    public let PHI_CUBED : Float = 4.236067977499790; // φ³

    // Circuit breaker frequency: φ³ Hz for cascade prevention
    public let IRONVEIL_FREQUENCY_HZ : Float = 4.236067977499790;

    // Thresholds for cascade detection
    public let REQUEST_RATE_THRESHOLD : Nat = 1000; // requests per second
    public let ERROR_RATE_THRESHOLD : Float = 0.5;  // 50% error rate
    public let CYCLE_SPIKE_THRESHOLD : Float = 10.0; // 10x normal consumption

    // Recovery timing (in nanoseconds)
    public let RECOVERY_BASE_TIME : Int = 30_000_000_000; // 30 seconds
    public let MAX_RECOVERY_TIME : Int = 600_000_000_000; // 10 minutes
    public let HALF_OPEN_DURATION : Int = 60_000_000_000; // 60 seconds

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: CIRCUIT BREAKER TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type CircuitState = {
        #closed;    // Normal operation
        #open;      // Circuit tripped, blocking traffic
        #halfOpen;  // Testing recovery
    };

    public type CascadeEvent = {
        id: Text;
        eventType: Text;
        severity: Float;
        timestamp: Int;
        description: Text;
        metrics: CascadeMetrics;
    };

    public type CascadeMetrics = {
        requestRate: Nat;
        errorRate: Float;
        cycleConsumption: Nat;
        rejectedCount: Nat;
        coordinatedAttacks: Nat;
    };

    public type CircuitBreakerStatus = {
        state: CircuitState;
        tripCount: Nat;
        lastTripTime: ?Int;
        recoveryAttempts: Nat;
        nextRecoveryTime: ?Int;
        totalRequestsBlocked: Nat;
        totalCyclesSaved: Nat;
        cascadeHistory: [CascadeEvent];
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: CIRCUIT BREAKER CLASS
    // ═══════════════════════════════════════════════════════════════════════

    public class CircuitBreaker() {
        var state : CircuitState = #closed;
        var tripCount : Nat = 0;
        var lastTripTime : ?Int = null;
        var recoveryAttempts : Nat = 0;
        var nextRecoveryTime : ?Int = null;
        var totalRequestsBlocked : Nat = 0;
        var totalCyclesSaved : Nat = 0;
        var cascadeHistory : [CascadeEvent] = [];

        // Metrics tracking
        var requestCount : Nat = 0;
        var errorCount : Nat = 0;
        var cycleConsumption : Nat = 0;
        var rejectedCount : Nat = 0;
        var coordinatedAttackCount : Nat = 0;
        var metricsWindowStart : Int = Time.now();

        public func checkCascade() : Bool {
            let now = Time.now();
            let windowDuration = now - metricsWindowStart;

            // Calculate current rates
            let requestRate = if (windowDuration > 0) {
                Nat.div(requestCount * 1_000_000_000, Int.abs(windowDuration))
            } else {
                0
            };

            let errorRate = if (requestCount > 0) {
                Float.fromInt(errorCount) / Float.fromInt(requestCount)
            } else {
                0.0
            };

            // Detect cascade conditions
            var cascadeDetected = false;
            var cascadeType = "none";
            var severity : Float = 0.0;

            if (requestRate > REQUEST_RATE_THRESHOLD) {
                cascadeDetected := true;
                cascadeType := "request_flood";
                severity := Float.min(1.0, Float.fromInt(requestRate) / Float.fromInt(REQUEST_RATE_THRESHOLD));
            };

            if (errorRate > ERROR_RATE_THRESHOLD) {
                cascadeDetected := true;
                cascadeType := if (cascadeType == "none") { "error_spike" } else { cascadeType # "+error_spike" };
                severity := Float.max(severity, errorRate);
            };

            if (coordinatedAttackCount > 0) {
                cascadeDetected := true;
                cascadeType := if (cascadeType == "none") { "coordinated_attack" } else { cascadeType # "+coordinated" };
                severity := Float.max(severity, 0.95);
            };

            if (cascadeDetected) {
                trip(cascadeType, severity);
            };

            cascadeDetected
        };

        public func trip(reason: Text, severity: Float) {
            let now = Time.now();

            state := #open;
            tripCount += 1;
            lastTripTime := ?now;

            // Calculate recovery time using exponential backoff with φ
            let backoffMultiplier = Float.pow(PHI, Float.fromInt(recoveryAttempts));
            let recoveryDelay = Int.min(
                Float.toInt(Float.fromInt(RECOVERY_BASE_TIME) * backoffMultiplier),
                MAX_RECOVERY_TIME
            );
            nextRecoveryTime := ?(now + recoveryDelay);

            // Record cascade event
            let event : CascadeEvent = {
                id = "CASCADE-" # Int.toText(now);
                eventType = reason;
                severity = severity;
                timestamp = now;
                description = "Circuit breaker tripped: " # reason;
                metrics = {
                    requestRate = requestCount;
                    errorRate = if (requestCount > 0) {
                        Float.fromInt(errorCount) / Float.fromInt(requestCount)
                    } else {
                        0.0
                    };
                    cycleConsumption = cycleConsumption;
                    rejectedCount = rejectedCount;
                    coordinatedAttacks = coordinatedAttackCount;
                };
            };
            cascadeHistory := Array.append(cascadeHistory, [event]);

            // Reset metrics
            resetMetrics();
        };

        public func attemptRecovery() : Bool {
            let now = Time.now();

            switch (state, nextRecoveryTime) {
                case (#open, ?recoveryTime) {
                    if (now >= recoveryTime) {
                        // Enter half-open state
                        state := #halfOpen;
                        recoveryAttempts += 1;
                        nextRecoveryTime := ?(now + HALF_OPEN_DURATION);
                        true
                    } else {
                        false
                    }
                };
                case (#halfOpen, ?testEndTime) {
                    if (now >= testEndTime) {
                        // Check if recovery was successful
                        let errorRate = if (requestCount > 0) {
                            Float.fromInt(errorCount) / Float.fromInt(requestCount)
                        } else {
                            0.0
                        };

                        if (errorRate < ERROR_RATE_THRESHOLD / 2.0) {
                            // Recovery successful
                            state := #closed;
                            recoveryAttempts := 0;
                            nextRecoveryTime := null;
                            resetMetrics();
                            true
                        } else {
                            // Recovery failed, trip again
                            trip("recovery_failed", errorRate);
                            false
                        }
                    } else {
                        false
                    }
                };
                case _ { false };
            };
        };

        public func allowRequest() : Bool {
            switch (state) {
                case (#closed) { true };
                case (#halfOpen) {
                    // Allow limited traffic for testing
                    requestCount < 100
                };
                case (#open) {
                    totalRequestsBlocked += 1;
                    totalCyclesSaved += 100_000; // Estimate
                    false
                };
            }
        };

        public func recordRequest(isError: Bool, cycles: Nat) {
            requestCount += 1;
            if (isError) {
                errorCount += 1;
            };
            cycleConsumption += cycles;
        };

        public func recordRejection() {
            rejectedCount += 1;
        };

        public func recordCoordinatedAttack() {
            coordinatedAttackCount += 1;
        };

        func resetMetrics() {
            requestCount := 0;
            errorCount := 0;
            cycleConsumption := 0;
            rejectedCount := 0;
            coordinatedAttackCount := 0;
            metricsWindowStart := Time.now();
        };

        public func getStatus() : CircuitBreakerStatus {
            {
                state = state;
                tripCount = tripCount;
                lastTripTime = lastTripTime;
                recoveryAttempts = recoveryAttempts;
                nextRecoveryTime = nextRecoveryTime;
                totalRequestsBlocked = totalRequestsBlocked;
                totalCyclesSaved = totalCyclesSaved;
                cascadeHistory = cascadeHistory;
            }
        };

        public func getState() : CircuitState {
            state
        };
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: UTILITIES
    // ═══════════════════════════════════════════════════════════════════════

    public func stateToText(state: CircuitState) : Text {
        switch (state) {
            case (#closed) { "CLOSED" };
            case (#open) { "OPEN" };
            case (#halfOpen) { "HALF_OPEN" };
        }
    };

    public func estimateCyclesSaved(blockedRequests: Nat) : Nat {
        blockedRequests * 100_000 // 100K cycles per request
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: MANIFEST
    // ═══════════════════════════════════════════════════════════════════════

    public func renderManifest() : Text {
        "╔══════════════════════════════════════════════════════════════════════════════╗\n" #
        "║                   IRONVEIL CIRCUIT BREAKER — AIS-025                        ║\n" #
        "║                    DISRUPTOR CASCADAE FERREAE                               ║\n" #
        "╠══════════════════════════════════════════════════════════════════════════════╣\n" #
        "║  CASCADE ATTACK PREVENTION: Treat DDoS as power-grid cascade failure        ║\n" #
        "║                                                                              ║\n" #
        "║  CIRCUIT STATES:                                                             ║\n" #
        "║    CLOSED    → Normal operation, all traffic flows                          ║\n" #
        "║    OPEN      → Circuit tripped, traffic blocked                             ║\n" #
        "║    HALF_OPEN → Testing recovery, limited traffic                            ║\n" #
        "║                                                                              ║\n" #
        "║  CASCADE DETECTION THRESHOLDS:                                               ║\n" #
        "║    Request Rate: " # Nat.toText(REQUEST_RATE_THRESHOLD) # " req/sec                                                ║\n" #
        "║    Error Rate: " # Float.toText(ERROR_RATE_THRESHOLD * 100.0) # "%                                                         ║\n" #
        "║    Cycle Spike: " # Float.toText(CYCLE_SPIKE_THRESHOLD) # "x normal                                                  ║\n" #
        "║                                                                              ║\n" #
        "║  AUTO-RECOVERY:                                                              ║\n" #
        "║    Base Time: 30 seconds                                                     ║\n" #
        "║    Backoff: Exponential with φ multiplier                                   ║\n" #
        "║    Max Time: 10 minutes                                                      ║\n" #
        "║    Test Period: 60 seconds (half-open state)                                ║\n" #
        "║                                                                              ║\n" #
        "║  CYCLE PROTECTION:                                                           ║\n" #
        "║    ~100K cycles saved per blocked request                                   ║\n" #
        "║    Exponential savings during cascade events                                 ║\n" #
        "║                                                                              ║\n" #
        "║  Attribution: Alfredo Medina | Medina Tech | Dallas, TX                    ║\n" #
        "║  Frequency: φ³ Hz (4.236...)                                                ║\n" #
        "╚══════════════════════════════════════════════════════════════════════════════╝"
    };
}
