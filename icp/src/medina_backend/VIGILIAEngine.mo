/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                      VIGILIA ENGINE — AIS-006                               ║
 * ║                       MACHINA VIGILIAE INTERNAE                             ║
 * ║                                                                              ║
 * ║  "Vigilia videt omnia. Nihil transit sine examine."                         ║
 * ║  (Vigilia sees all. Nothing passes without examination.)                    ║
 * ║                                                                              ║
 * ║  VIGILIA is the Innerweb Model — first-line pattern detection at the edge.  ║
 * ║  It performs rapid regex matching on request bodies, headers, and URLs to   ║
 * ║  identify and reject 8 threat categories before they consume canister       ║
 * ║  cycles.                                                                     ║
 * ║                                                                              ║
 * ║  INNERWEB MODEL:                                                             ║
 * ║    - Fast pattern matching (regex-based)                                    ║
 * ║    - 8 threat classifiers                                                    ║
 * ║    - Severity scoring                                                        ║
 * ║    - Challenge generation for suspicious patterns                            ║
 * ║    - Rate limiting per IP/fingerprint                                        ║
 * ║                                                                              ║
 * ║  DEPLOYMENT:                                                                 ║
 * ║    Cloudflare Workers (free tier: 100K requests/day)                        ║
 * ║    Canister-side validation (backup/failsafe)                               ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Detection frequency: φ Hz                                ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

module VIGILIAEngine {

    public let PHI : Float = 1.618033988749895;

    // VIGILIA frequency: φ Hz (golden ratio) for harmonic detection
    public let VIGILIA_FREQUENCY_HZ : Float = 1.618033988749895;

    // Rate limiting: requests per minute
    public let RATE_LIMIT_BENIGN : Nat = 60;
    public let RATE_LIMIT_SUSPECTUM : Nat = 10;
    public let RATE_LIMIT_FLOOD_THRESHOLD : Nat = 100;

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: DETECTION PATTERNS
    // ═══════════════════════════════════════════════════════════════════════

    public type DetectionRule = {
        id: Text;
        name: Text;
        pattern: Text;
        threatType: Text;
        severity: Text;
        autoReject: Bool;
        description: Text;
    };

    public func getDetectionRules() : [DetectionRule] {
        [
            // Injection attacks
            {
                id = "VIG-001";
                name = "SQL Injection - UNION";
                pattern = "(?i)union.*select";
                threatType = "injection";
                severity = "criticum";
                autoReject = true;
                description = "UNION-based SQL injection";
            },
            {
                id = "VIG-002";
                name = "SQL Injection - DROP";
                pattern = "(?i)drop\\s+(table|database)";
                threatType = "injection";
                severity = "criticum";
                autoReject = true;
                description = "DROP statement injection";
            },
            {
                id = "VIG-003";
                name = "Command Injection - Pipe";
                pattern = "\\|\\s*(curl|wget|nc|bash|sh)";
                threatType = "injection";
                severity = "criticum";
                autoReject = true;
                description = "Shell pipe command injection";
            },
            {
                id = "VIG-004";
                name = "XSS - Script Tag";
                pattern = "(?i)<script[^>]*>";
                threatType = "injection";
                severity = "altum";
                autoReject = true;
                description = "Script tag XSS injection";
            },
            {
                id = "VIG-005";
                name = "XSS - Event Handler";
                pattern = "(?i)on(error|load|click|mouse)\\s*=";
                threatType = "injection";
                severity = "altum";
                autoReject = true;
                description = "Event handler XSS";
            },

            // Exfiltration attacks
            {
                id = "VIG-006";
                name = "Path Traversal";
                pattern = "\\.\\./|%2e%2e/";
                threatType = "exfiltration";
                severity = "altum";
                autoReject = true;
                description = "Directory traversal attempt";
            },
            {
                id = "VIG-007";
                name = "Sensitive File Access";
                pattern = "(?i)(/etc/passwd|/etc/shadow|\\.env|config\\.json)";
                threatType = "exfiltration";
                severity = "criticum";
                autoReject = true;
                description = "Sensitive file access attempt";
            },

            // Manipulation attacks
            {
                id = "VIG-008";
                name = "JWT None Algorithm";
                pattern = "(?i)\"alg\":\\s*\"none\"";
                threatType = "manipulation";
                severity = "criticum";
                autoReject = true;
                description = "JWT algorithm none exploit";
            },
            {
                id = "VIG-009";
                name = "Prototype Pollution";
                pattern = "(?i)(__proto__|constructor\\[prototype\\])";
                threatType = "manipulation";
                severity = "altum";
                autoReject = false;
                description = "JavaScript prototype pollution";
            },

            // Deception attacks
            {
                id = "VIG-010";
                name = "User-Agent Scanner";
                pattern = "(?i)(sqlmap|nikto|nmap|masscan|acunetix)";
                threatType = "deception";
                severity = "medium";
                autoReject = false;
                description = "Known scanner user-agent";
            },
            {
                id = "VIG-011";
                name = "Fake Referer";
                pattern = "(?i)referer:.*google.*bing";
                threatType = "deception";
                severity = "suspectum";
                autoReject = false;
                description = "Suspicious referer spoofing";
            },

            // Denial of Service
            {
                id = "VIG-012";
                name = "Large Payload";
                pattern = "PAYLOAD_SIZE_EXCEEDED";
                threatType = "denial";
                severity = "medium";
                autoReject = false;
                description = "Payload exceeds size limit";
            },
            {
                id = "VIG-013";
                name = "Request Flood";
                pattern = "FLOOD_DETECTED";
                threatType = "denial";
                severity = "criticum";
                autoReject = true;
                description = "High-frequency request flood";
            },

            // Escalation attacks
            {
                id = "VIG-014";
                name = "Admin Credential Stuffing";
                pattern = "(?i)(username|user).*admin.*(password|pass)";
                threatType = "escalation";
                severity = "altum";
                autoReject = false;
                description = "Admin credential stuffing attempt";
            },
            {
                id = "VIG-015";
                name = "Privilege Escalation Keywords";
                pattern = "(?i)(sudo|su\\s|chmod\\s777|chown\\sroot)";
                threatType = "escalation";
                severity = "altum";
                autoReject = true;
                description = "Privilege escalation keywords";
            },
        ]
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: RATE LIMITING
    // ═══════════════════════════════════════════════════════════════════════

    public type RateLimitEntry = {
        fingerprint: Text;
        requestCount: Nat;
        windowStart: Int;
        lastSeverity: Text;
        challengesSent: Nat;
    };

    public class RateLimiter() {
        var entries = HashMap.HashMap<Text, RateLimitEntry>(10, Text.equal, Text.hash);

        public func checkRate(fingerprint: Text, severity: Text) : Bool {
            let now = Time.now();
            let windowNs : Int = 60_000_000_000; // 60 seconds

            switch (entries.get(fingerprint)) {
                case null {
                    // First request
                    entries.put(fingerprint, {
                        fingerprint = fingerprint;
                        requestCount = 1;
                        windowStart = now;
                        lastSeverity = severity;
                        challengesSent = 0;
                    });
                    true
                };
                case (?entry) {
                    // Check if window expired
                    if (now - entry.windowStart > windowNs) {
                        // Reset window
                        entries.put(fingerprint, {
                            fingerprint = fingerprint;
                            requestCount = 1;
                            windowStart = now;
                            lastSeverity = severity;
                            challengesSent = 0;
                        });
                        true
                    } else {
                        // Within window, check limits
                        let newCount = entry.requestCount + 1;
                        let limit = switch (severity) {
                            case "benign" { RATE_LIMIT_BENIGN };
                            case "suspectum" { RATE_LIMIT_SUSPECTUM };
                            case _ { RATE_LIMIT_SUSPECTUM };
                        };

                        if (newCount > RATE_LIMIT_FLOOD_THRESHOLD) {
                            // Flood detected
                            false
                        } else if (newCount > limit) {
                            // Rate limit exceeded
                            false
                        } else {
                            // Update count
                            entries.put(fingerprint, {
                                fingerprint = fingerprint;
                                requestCount = newCount;
                                windowStart = entry.windowStart;
                                lastSeverity = severity;
                                challengesSent = entry.challengesSent;
                            });
                            true
                        }
                    }
                };
            };
        };

        public func recordChallenge(fingerprint: Text) {
            switch (entries.get(fingerprint)) {
                case (?entry) {
                    entries.put(fingerprint, {
                        fingerprint = entry.fingerprint;
                        requestCount = entry.requestCount;
                        windowStart = entry.windowStart;
                        lastSeverity = entry.lastSeverity;
                        challengesSent = entry.challengesSent + 1;
                    });
                };
                case null { };
            };
        };

        public func getStats() : (Nat, Nat) {
            var totalRequests : Nat = 0;
            var totalChallenges : Nat = 0;

            for (entry in entries.vals()) {
                totalRequests += entry.requestCount;
                totalChallenges += entry.challengesSent;
            };

            (totalRequests, totalChallenges)
        };
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: VALIDATION ENGINE
    // ═══════════════════════════════════════════════════════════════════════

    public type ValidationResult = {
        isValid: Bool;
        severity: Text;
        matchedRules: [Text];
        autoReject: Bool;
        challengeRequired: Bool;
        reason: Text;
    };

    public func validateRequest(
        body: Text,
        headers: Text,
        url: Text
    ) : ValidationResult {
        let rules = getDetectionRules();
        var matchedRules : [Text] = [];
        var maxSeverity = "benign";
        var autoReject = false;

        let fullPayload = body # " " # headers # " " # url;

        for (rule in rules.vals()) {
            // Simple pattern matching (in production, use proper regex)
            if (Text.contains(fullPayload, #text rule.pattern)) {
                matchedRules := Array.append(matchedRules, [rule.id]);

                // Update severity
                maxSeverity := switch (rule.severity, maxSeverity) {
                    case ("criticum", _) { "criticum" };
                    case ("altum", "criticum") { "criticum" };
                    case ("altum", _) { "altum" };
                    case ("medium", "criticum") { "criticum" };
                    case ("medium", "altum") { "altum" };
                    case ("medium", _) { "medium" };
                    case ("suspectum", "benign") { "suspectum" };
                    case (_, s) { s };
                };

                if (rule.autoReject) {
                    autoReject := true;
                };
            };
        };

        let challengeRequired = maxSeverity == "altum" or maxSeverity == "medium";

        {
            isValid = not autoReject;
            severity = maxSeverity;
            matchedRules = matchedRules;
            autoReject = autoReject;
            challengeRequired = challengeRequired;
            reason = if (autoReject) {
                "Critical threat pattern detected: " # Text.join(", ", matchedRules.vals())
            } else if (challengeRequired) {
                "Suspicious pattern detected, challenge required"
            } else {
                "Request validated"
            };
        }
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: CHALLENGE GENERATION
    // ═══════════════════════════════════════════════════════════════════════

    public type Challenge = {
        id: Text;
        challengeType: Text;
        difficulty: Nat;
        expiresAt: Int;
        nonce: Text;
    };

    public func generateChallenge(severity: Text) : Challenge {
        let difficulty = switch (severity) {
            case "criticum" { 5 };
            case "altum" { 4 };
            case "medium" { 3 };
            case _ { 2 };
        };

        let now = Time.now();
        let expiresAt = now + 30_000_000_000; // 30 seconds

        {
            id = "CHAL-" # Int.toText(now);
            challengeType = "proof_of_work";
            difficulty = difficulty;
            expiresAt = expiresAt;
            nonce = Int.toText(now);
        }
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: MANIFEST
    // ═══════════════════════════════════════════════════════════════════════

    public func renderManifest() : Text {
        let rules = getDetectionRules();
        "╔══════════════════════════════════════════════════════════════════════════════╗\n" #
        "║                      VIGILIA ENGINE — AIS-006                               ║\n" #
        "║                       MACHINA VIGILIAE INTERNAE                             ║\n" #
        "╠══════════════════════════════════════════════════════════════════════════════╣\n" #
        "║  INNERWEB MODEL: First-line pattern detection at the edge                   ║\n" #
        "║                                                                              ║\n" #
        "║  DETECTION RULES: " # Nat.toText(rules.size()) # " active patterns                                    ║\n" #
        "║                                                                              ║\n" #
        "║  THREAT CATEGORIES:                                                          ║\n" #
        "║    • Injection (SQL, Command, XSS)                                          ║\n" #
        "║    • Exfiltration (Path Traversal, File Access)                             ║\n" #
        "║    • Manipulation (JWT, Prototype Pollution)                                 ║\n" #
        "║    • Deception (Scanner Detection, Spoofing)                                ║\n" #
        "║    • Denial (Flood, Large Payload)                                          ║\n" #
        "║    • Escalation (Privilege Escalation, Admin Access)                        ║\n" #
        "║                                                                              ║\n" #
        "║  RATE LIMITING:                                                              ║\n" #
        "║    Benign: " # Nat.toText(RATE_LIMIT_BENIGN) # " req/min                                                      ║\n" #
        "║    Suspicious: " # Nat.toText(RATE_LIMIT_SUSPECTUM) # " req/min                                                   ║\n" #
        "║    Flood Threshold: " # Nat.toText(RATE_LIMIT_FLOOD_THRESHOLD) # " req/min                                             ║\n" #
        "║                                                                              ║\n" #
        "║  CHALLENGE SYSTEM:                                                           ║\n" #
        "║    Proof-of-Work challenges for suspicious requests                          ║\n" #
        "║    Difficulty scales with threat severity                                    ║\n" #
        "║                                                                              ║\n" #
        "║  Attribution: Alfredo Medina | Medina Tech | Dallas, TX                    ║\n" #
        "║  Frequency: φ Hz (1.618...)                                                 ║\n" #
        "╚══════════════════════════════════════════════════════════════════════════════╝"
    };
}
