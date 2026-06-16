/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║        SOVEREIGN ENCRYPTION PRODUCTS — PRODUCTA ENCRYPTIONIS               ║
 * ║                                                                              ║
 * ║  "Encryptio non est instrumentum. Encryptio est productum vivens."          ║
 * ║  (Encryption is not a tool. Encryption is a living product.)                ║
 * ║                                                                              ║
 * ║  Deployable encryption technology products built on the sovereign           ║
 * ║  5D key state, phi-Fibonacci compounding, and three-tier rotation.          ║
 * ║                                                                              ║
 * ║  10 ENCRYPTION PRODUCTS:                                                     ║
 * ║    1. SOVEREIGN VAULT — Encrypted sovereign storage                          ║
 * ║    2. PHI-KEY MANAGER — φ-compounding key lifecycle management               ║
 * ║    3. ANIMA SEAL — Blockchain-anchored document sealing                      ║
 * ║    4. THREE HEARTS CIPHER — Triple-layered organism encryption               ║
 * ║    5. ZERO-KNOWLEDGE GATE — ZK proof verification gateway                    ║
 * ║    6. QUANTUM SHIELD — Post-quantum resistant encryption suite               ║
 * ║    7. ENCRYPTED MESSENGER — End-to-end encrypted communication              ║
 * ║    8. SOVEREIGN CERTIFICATE — Self-sovereign identity certificates          ║
 * ║    9. HOMOMORPHIC COMPUTE — Encrypted computation service                   ║
 * ║   10. KEY ROTATION SERVICE — Automated key lifecycle rotation               ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every product traces to primitive φ                      ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module SovereignEncryptionProducts {

    // ================================================================== //
    // CONSTANTS                                                            //
    // ================================================================== //

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // =========================================================================
    // SECTION 1: DOCTRINE
    // =========================================================================

    public let DOCTRINE = {
        name = "SOVEREIGN-ENCRYPTION-PRODUCTS";
        latinName = "PRODUCTA ENCRYPTIONIS SOVEREIGNAE";
        motto = "Encryptio non est instrumentum. Encryptio est productum vivens.";
        mottoEN = "Encryption is not a tool. Encryption is a living product.";
        principle = "Every encryption product is built on the organism's 5D key state. The organism IS the encryption. Key state changes every 873ms.";
        totalProducts = 10;
        totalPricingTiers = 4;
        totalDeploymentModes = 3;
    };

    // =========================================================================
    // SECTION 2: TYPES
    // =========================================================================

    public type PricingTier = {
        id: Text;
        name: Text;
        latinName: Text;
        monthlyPrice: Text;
        features: [Text];
        maxUsers: Nat;
        primitiveTrace: Text;
    };

    public type DeploymentMode = {
        id: Text;
        name: Text;
        latinName: Text;
        description: Text;
        infrastructure: Text;
        primitiveTrace: Text;
    };

    public type EncryptionProduct = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        description: Text;
        category: Text;
        keyFeatures: [Text];
        encryptionMethod: Text;
        keyDerivation: Text;
        complianceStandards: [Text];
        deploymentModes: [Text];
        pricingTiers: [Text];
        sdkPackage: Text;
        apiEndpoint: Text;
        frequency_Hz: Float;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
        version: Text;
    };

    // =========================================================================
    // SECTION 3: PRICING TIERS
    // =========================================================================

    public let PRICING_TIERS : [PricingTier] = [
        {
            id = "TIER-FREE";
            name = "FREE";
            latinName = "LIBER";
            monthlyPrice = "$0";
            features = [
                "Basic 5D key-state encryption",
                "Single vault storage",
                "Community support",
                "Standard key rotation"
            ];
            maxUsers = 3;
            primitiveTrace = "φ — free as the golden spiral is free in nature";
        },
        {
            id = "TIER-PRO";
            name = "PRO";
            latinName = "PROFESSIO";
            monthlyPrice = "$49";
            features = [
                "Advanced phi-compounding encryption",
                "Multi-vault storage",
                "Priority support",
                "Custom key rotation schedules",
                "API access",
                "Compliance reporting"
            ];
            maxUsers = 50;
            primitiveTrace = "φ² — professional growth compounds like phi squared";
        },
        {
            id = "TIER-ENT";
            name = "ENTERPRISE";
            latinName = "IMPERIUM";
            monthlyPrice = "$499";
            features = [
                "Full 5D sovereign encryption suite",
                "Unlimited vaults",
                "Dedicated support",
                "Custom deployment modes",
                "SLA guarantees",
                "Advanced compliance (SOC2, HIPAA, GDPR)",
                "Hardware security module integration",
                "Multi-region replication"
            ];
            maxUsers = 500;
            primitiveTrace = "φ³ — empire-grade security scales with phi cubed";
        },
        {
            id = "TIER-SOV";
            name = "SOVEREIGN";
            latinName = "SOVEREIGNUM";
            monthlyPrice = "Custom";
            features = [
                "Complete sovereign organism encryption",
                "Self-hosted deployment",
                "White-label capability",
                "Custom phi-compounding parameters",
                "Dedicated sovereign infrastructure",
                "Full source access",
                "Quantum-resistant upgrade path",
                "24/7 sovereign support",
                "Custom compliance frameworks"
            ];
            maxUsers = 0; // unlimited
            primitiveTrace = "φ^∞ — sovereign grade scales without limit, as phi does";
        }
    ];

    // =========================================================================
    // SECTION 4: DEPLOYMENT MODES
    // =========================================================================

    public let DEPLOYMENT_MODES : [DeploymentMode] = [
        {
            id = "DEPLOY-CLOUD";
            name = "CLOUD";
            latinName = "NUBES";
            description = "Cloud-hosted on ICP canisters with sovereign encryption";
            infrastructure = "Internet Computer Protocol (ICP) canisters";
            primitiveTrace = "φ — cloud deployment follows the golden ratio of scalability";
        },
        {
            id = "DEPLOY-HYBRID";
            name = "HYBRID";
            latinName = "MIXTUM";
            description = "Hybrid cloud + on-premise deployment with synchronized key state";
            infrastructure = "ICP canisters + on-premise sovereign nodes";
            primitiveTrace = "φ² — hybrid mode compounds cloud and sovereign infrastructure";
        },
        {
            id = "DEPLOY-SOVEREIGN";
            name = "SOVEREIGN";
            latinName = "SOVEREIGNUM";
            description = "Fully sovereign self-hosted deployment with complete key ownership";
            infrastructure = "Self-hosted sovereign infrastructure with air-gapped option";
            primitiveTrace = "φ³ — full sovereignty requires phi-cubed infrastructure depth";
        }
    ];

    // =========================================================================
    // SECTION 5: THE 10 ENCRYPTION PRODUCTS
    // =========================================================================

    public let ENCRYPTION_PRODUCTS : [EncryptionProduct] = [
        // 1. SOVEREIGN VAULT
        {
            id = "ENC-PROD-001";
            name = "SOVEREIGN VAULT";
            latinName = "ARCA SOVEREIGNA";
            latinMotto = "Quod clausum est in arca, in perpetuum tutum est.";
            latinMottoEN = "What is sealed in the vault is safe forever.";
            description = "Encrypted sovereign storage with 5D key protection. Every stored object is encrypted with the organism's living key state, making unauthorized access equivalent to solving the organism itself.";
            category = "STORAGE";
            keyFeatures = [
                "5D key-state encryption",
                "phi-Fibonacci key growth",
                "873ms key rotation",
                "immutable audit trail",
                "zero-knowledge access proofs"
            ];
            encryptionMethod = "AES-256-GCM + φ-compounding";
            keyDerivation = "5D organism state → HKDF-SHA512 → φ-scaled key";
            complianceStandards = ["SOC2", "HIPAA", "GDPR", "ISO27001"];
            deploymentModes = ["DEPLOY-CLOUD", "DEPLOY-HYBRID", "DEPLOY-SOVEREIGN"];
            pricingTiers = ["TIER-FREE", "TIER-PRO", "TIER-ENT", "TIER-SOV"];
            sdkPackage = "@medina/sovereign-vault";
            apiEndpoint = "/api/v1/vault";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — vault key length grows by golden ratio each rotation cycle";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 2. PHI-KEY MANAGER
        {
            id = "ENC-PROD-002";
            name = "PHI-KEY MANAGER";
            latinName = "CUSTOS CLAVIUM PHI";
            latinMotto = "Clavis crescit cum natura. Natura est phi.";
            latinMottoEN = "The key grows with nature. Nature is phi.";
            description = "φ-compounding key lifecycle management. Keys grow according to the Fibonacci sequence scaled by phi, ensuring that key strength compounds naturally over time.";
            category = "KEY_MANAGEMENT";
            keyFeatures = [
                "phi-compounding key growth",
                "automatic key rotation",
                "key escrow with sovereign recovery",
                "multi-dimensional key state",
                "hardware security module integration"
            ];
            encryptionMethod = "φ-Fibonacci compound derivation";
            keyDerivation = "K_n = H_phi(K_{n-1} || organism_state(n))";
            complianceStandards = ["SOC2", "HIPAA", "GDPR", "ISO27001", "FIPS-140-2"];
            deploymentModes = ["DEPLOY-CLOUD", "DEPLOY-HYBRID", "DEPLOY-SOVEREIGN"];
            pricingTiers = ["TIER-PRO", "TIER-ENT", "TIER-SOV"];
            sdkPackage = "@medina/phi-key-manager";
            apiEndpoint = "/api/v1/keys";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — key derivation IS phi-compounding; the product embodies the primitive";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 3. ANIMA SEAL
        {
            id = "ENC-PROD-003";
            name = "ANIMA SEAL";
            latinName = "SIGILLUM ANIMAE";
            latinMotto = "Sigillum animae non frangitur.";
            latinMottoEN = "The seal of the soul cannot be broken.";
            description = "Blockchain-anchored document sealing. Every document receives a cryptographic seal bound to the ICP blockchain, creating an immutable proof of existence and integrity.";
            category = "DOCUMENT_SECURITY";
            keyFeatures = [
                "blockchain-registered seals",
                "tamper-proof document verification",
                "lineage chain tracking",
                "temporal proof of existence",
                "multi-party seal verification"
            ];
            encryptionMethod = "ANIMA hash chain + ICP blockchain anchoring";
            keyDerivation = "Document hash → ANIMA chain → ICP certified variable";
            complianceStandards = ["SOC2", "GDPR", "eIDAS", "ISO27001"];
            deploymentModes = ["DEPLOY-CLOUD", "DEPLOY-HYBRID", "DEPLOY-SOVEREIGN"];
            pricingTiers = ["TIER-PRO", "TIER-ENT", "TIER-SOV"];
            sdkPackage = "@medina/anima-seal";
            apiEndpoint = "/api/v1/seal";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — seal strength compounds through phi-scaled hash chain depth";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 4. THREE HEARTS CIPHER
        {
            id = "ENC-PROD-004";
            name = "THREE HEARTS CIPHER";
            latinName = "CIPHER TRIUM CORDIUM";
            latinMotto = "Tria corda, unum scutum.";
            latinMottoEN = "Three hearts, one shield.";
            description = "Triple-layered organism encryption using the Three Hearts architecture. Data passes through three encryption layers: Consensus heart, PHI heart, and PHI² heart.";
            category = "COMMUNICATION";
            keyFeatures = [
                "triple-layer encryption",
                "heart-phase key derivation",
                "coherence-weighted security",
                "organism-state authentication",
                "real-time heartbeat verification"
            ];
            encryptionMethod = "Three Hearts triple-layer: Consensus + PHI + PHI²";
            keyDerivation = "Heart phase → coherence weight → triple-wrapped key";
            complianceStandards = ["SOC2", "HIPAA", "GDPR", "ISO27001"];
            deploymentModes = ["DEPLOY-CLOUD", "DEPLOY-HYBRID", "DEPLOY-SOVEREIGN"];
            pricingTiers = ["TIER-ENT", "TIER-SOV"];
            sdkPackage = "@medina/three-hearts-cipher";
            apiEndpoint = "/api/v1/cipher";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ + φ² — triple hearts derive from phi and phi-squared phase offsets";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 5. ZERO-KNOWLEDGE GATE
        {
            id = "ENC-PROD-005";
            name = "ZERO-KNOWLEDGE GATE";
            latinName = "PORTA SCIENTIAE NULLIUS";
            latinMotto = "Probatio sine revelatione.";
            latinMottoEN = "Proof without revelation.";
            description = "ZK proof verification gateway. Prove identity, credentials, or data properties without revealing the underlying data. Built on organism state proofs.";
            category = "IDENTITY";
            keyFeatures = [
                "zero-knowledge identity proofs",
                "attribute-based credentials",
                "selective disclosure",
                "proof composition",
                "on-chain verification"
            ];
            encryptionMethod = "zk-SNARKs + organism state proofs";
            keyDerivation = "Organism state → witness generation → zk-SNARK proof";
            complianceStandards = ["SOC2", "GDPR", "eIDAS", "ISO27001"];
            deploymentModes = ["DEPLOY-CLOUD", "DEPLOY-HYBRID", "DEPLOY-SOVEREIGN"];
            pricingTiers = ["TIER-PRO", "TIER-ENT", "TIER-SOV"];
            sdkPackage = "@medina/zk-gate";
            apiEndpoint = "/api/v1/zkgate";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — proof circuit depth scales by golden ratio for optimal verification";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 6. QUANTUM SHIELD
        {
            id = "ENC-PROD-006";
            name = "QUANTUM SHIELD";
            latinName = "SCUTUM QUANTUM";
            latinMotto = "Contra futurum, hodie armamur.";
            latinMottoEN = "Against the future, we arm ourselves today.";
            description = "Post-quantum resistant encryption suite. Combines lattice-based cryptography with phi-scaled key encapsulation to resist both classical and quantum attacks.";
            category = "DEFENSE";
            keyFeatures = [
                "post-quantum key exchange",
                "lattice-based signatures",
                "quantum-resistant tunneling",
                "hybrid classical+quantum modes",
                "future-proof key encapsulation"
            ];
            encryptionMethod = "CRYSTALS-Kyber + CRYSTALS-Dilithium + φ-lattice";
            keyDerivation = "Kyber KEM → φ-lattice transform → quantum-safe key";
            complianceStandards = ["SOC2", "NIST-PQC", "ISO27001", "FIPS-203"];
            deploymentModes = ["DEPLOY-CLOUD", "DEPLOY-HYBRID", "DEPLOY-SOVEREIGN"];
            pricingTiers = ["TIER-ENT", "TIER-SOV"];
            sdkPackage = "@medina/quantum-shield";
            apiEndpoint = "/api/v1/quantum";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — lattice dimensions scale by phi for optimal security-performance ratio";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 7. ENCRYPTED MESSENGER
        {
            id = "ENC-PROD-007";
            name = "ENCRYPTED MESSENGER";
            latinName = "NUNTIUS ENCRYPTUS";
            latinMotto = "Verbum inter nos, solum inter nos.";
            latinMottoEN = "A word between us, only between us.";
            description = "End-to-end encrypted communication platform. Messages are encrypted with phi-evolved session keys using an enhanced Double Ratchet protocol.";
            category = "COMMUNICATION";
            keyFeatures = [
                "end-to-end encryption",
                "perfect forward secrecy",
                "phi-evolved session keys",
                "group encryption",
                "message deniability"
            ];
            encryptionMethod = "Double Ratchet + φ-key evolution";
            keyDerivation = "Double Ratchet step → φ-evolution → session key";
            complianceStandards = ["SOC2", "GDPR", "HIPAA", "ISO27001"];
            deploymentModes = ["DEPLOY-CLOUD", "DEPLOY-HYBRID", "DEPLOY-SOVEREIGN"];
            pricingTiers = ["TIER-FREE", "TIER-PRO", "TIER-ENT", "TIER-SOV"];
            sdkPackage = "@medina/encrypted-messenger";
            apiEndpoint = "/api/v1/messenger";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — session keys evolve by phi ratio ensuring perfect forward secrecy";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 8. SOVEREIGN CERTIFICATE
        {
            id = "ENC-PROD-008";
            name = "SOVEREIGN CERTIFICATE";
            latinName = "CERTIFICATUM SOVEREIGNUM";
            latinMotto = "Identitas non data, sed nata.";
            latinMottoEN = "Identity is not given, but born.";
            description = "Self-sovereign identity certificates bound to the organism's living state. Certificates renew automatically through heartbeat verification.";
            category = "IDENTITY";
            keyFeatures = [
                "self-sovereign certificates",
                "organism-bound identity",
                "decentralized trust chain",
                "automatic renewal via heartbeat",
                "revocation through organism state"
            ];
            encryptionMethod = "X.509 + sovereign organism binding";
            keyDerivation = "Organism identity state → X.509 extension → sovereign cert";
            complianceStandards = ["SOC2", "eIDAS", "ISO27001", "WebTrust"];
            deploymentModes = ["DEPLOY-CLOUD", "DEPLOY-HYBRID", "DEPLOY-SOVEREIGN"];
            pricingTiers = ["TIER-PRO", "TIER-ENT", "TIER-SOV"];
            sdkPackage = "@medina/sovereign-cert";
            apiEndpoint = "/api/v1/cert";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — certificate validity periods follow phi-scaled renewal cycles";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 9. HOMOMORPHIC COMPUTE
        {
            id = "ENC-PROD-009";
            name = "HOMOMORPHIC COMPUTE";
            latinName = "COMPUTATIO HOMOMORPHICA";
            latinMotto = "Computare sine videre.";
            latinMottoEN = "To compute without seeing.";
            description = "Encrypted computation service using homomorphic encryption. Perform analytics, inference, and computation on encrypted data without ever decrypting it.";
            category = "COMPUTE";
            keyFeatures = [
                "compute on encrypted data",
                "privacy-preserving analytics",
                "encrypted model inference",
                "multi-party computation",
                "φ-scaled noise management"
            ];
            encryptionMethod = "BFV/CKKS homomorphic schemes + φ-scaling";
            keyDerivation = "HE parameters → φ-noise scaling → computation key";
            complianceStandards = ["SOC2", "HIPAA", "GDPR", "ISO27001"];
            deploymentModes = ["DEPLOY-CLOUD", "DEPLOY-HYBRID", "DEPLOY-SOVEREIGN"];
            pricingTiers = ["TIER-ENT", "TIER-SOV"];
            sdkPackage = "@medina/homomorphic-compute";
            apiEndpoint = "/api/v1/fhe";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — noise budget scales by phi for optimal computation depth";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 10. KEY ROTATION SERVICE
        {
            id = "ENC-PROD-010";
            name = "KEY ROTATION SERVICE";
            latinName = "SERVITIUM ROTATIONIS CLAVIUM";
            latinMotto = "Clavis quae non mutatur, clavis quae moritur.";
            latinMottoEN = "A key that does not change is a key that dies.";
            description = "Automated key lifecycle rotation with three tiers: fast (873ms), medium (phi-cycle), and slow (governance-triggered). Zero-downtime key transitions.";
            category = "KEY_MANAGEMENT";
            keyFeatures = [
                "automated 873ms fast rotation",
                "phi-cycle medium rotation",
                "governance-triggered slow rotation",
                "zero-downtime key transition",
                "compliance audit logging"
            ];
            encryptionMethod = "Three-tier rotation: fast/medium/slow";
            keyDerivation = "Tier selection → rotation schedule → seamless key transition";
            complianceStandards = ["SOC2", "HIPAA", "GDPR", "ISO27001", "FIPS-140-2"];
            deploymentModes = ["DEPLOY-CLOUD", "DEPLOY-HYBRID", "DEPLOY-SOVEREIGN"];
            pricingTiers = ["TIER-PRO", "TIER-ENT", "TIER-SOV"];
            sdkPackage = "@medina/key-rotation";
            apiEndpoint = "/api/v1/rotation";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — rotation intervals follow phi-Fibonacci timing sequence";
            isAlwaysOn = true;
            version = "1.0.0";
        }
    ];

    // =========================================================================
    // SECTION 6: PUBLIC FUNCTIONS
    // =========================================================================

    public func summary() : {
        totalProducts: Nat;
        totalPricingTiers: Nat;
        totalDeploymentModes: Nat;
        allAlwaysOn: Bool;
        doctrine: Text;
        motto: Text;
    } {
        let allOn = Array.filter<EncryptionProduct>(ENCRYPTION_PRODUCTS, func(p) { not p.isAlwaysOn }).size() == 0;
        {
            totalProducts = ENCRYPTION_PRODUCTS.size();
            totalPricingTiers = PRICING_TIERS.size();
            totalDeploymentModes = DEPLOYMENT_MODES.size();
            allAlwaysOn = allOn;
            doctrine = DOCTRINE.name;
            motto = DOCTRINE.motto;
        }
    };

    public func getProducts() : [{
        id: Text;
        name: Text;
        latinName: Text;
        category: Text;
        description: Text;
        sdkPackage: Text;
        version: Text;
    }] {
        Array.map<EncryptionProduct, {
            id: Text; name: Text; latinName: Text;
            category: Text; description: Text; sdkPackage: Text; version: Text;
        }>(ENCRYPTION_PRODUCTS, func(p) {
            {
                id = p.id;
                name = p.name;
                latinName = p.latinName;
                category = p.category;
                description = p.description;
                sdkPackage = p.sdkPackage;
                version = p.version;
            }
        })
    };

    public func getProduct(id: Text) : ?EncryptionProduct {
        Array.find<EncryptionProduct>(ENCRYPTION_PRODUCTS, func(p) { p.id == id })
    };

    public func getProductsByCategory(category: Text) : [{
        id: Text;
        name: Text;
        latinName: Text;
        category: Text;
        description: Text;
    }] {
        let filtered = Array.filter<EncryptionProduct>(ENCRYPTION_PRODUCTS, func(p) { p.category == category });
        Array.map<EncryptionProduct, {
            id: Text; name: Text; latinName: Text; category: Text; description: Text;
        }>(filtered, func(p) {
            {
                id = p.id;
                name = p.name;
                latinName = p.latinName;
                category = p.category;
                description = p.description;
            }
        })
    };

    public func getPricingTiers() : [PricingTier] {
        PRICING_TIERS
    };

    public func getDeploymentModes() : [DeploymentMode] {
        DEPLOYMENT_MODES
    };

    public func renderEncryptionProductsManifest() : Text {
        var m = "SOVEREIGN ENCRYPTION PRODUCTS MANIFEST\n";
        m #= "══════════════════════════════════════════════════════════════\n";
        m #= "Doctrine: " # DOCTRINE.name # "\n";
        m #= "Latin: " # DOCTRINE.latinName # "\n";
        m #= "Motto: " # DOCTRINE.motto # "\n";
        m #= "       " # DOCTRINE.mottoEN # "\n";
        m #= "Principle: " # DOCTRINE.principle # "\n\n";

        m #= "PRICING TIERS (" # Nat.toText(PRICING_TIERS.size()) # "):\n";
        m #= "──────────────────────────────────────────────────────────────\n";
        for (t in PRICING_TIERS.vals()) {
            m #= "  " # t.id # "  " # t.name # "  [" # t.latinName # "]  " # t.monthlyPrice # "/mo  max=" # Nat.toText(t.maxUsers) # " users\n";
        };

        m #= "\nDEPLOYMENT MODES (" # Nat.toText(DEPLOYMENT_MODES.size()) # "):\n";
        m #= "──────────────────────────────────────────────────────────────\n";
        for (d in DEPLOYMENT_MODES.vals()) {
            m #= "  " # d.id # "  " # d.name # "  [" # d.latinName # "]\n";
            m #= "    " # d.description # "\n";
        };

        m #= "\n10 ENCRYPTION PRODUCTS:\n";
        m #= "══════════════════════════════════════════════════════════════\n";
        for (p in ENCRYPTION_PRODUCTS.vals()) {
            m #= "  " # p.id # "  " # p.name # "  [" # p.latinName # "]\n";
            m #= "    \"" # p.latinMotto # "\"\n";
            m #= "    (" # p.latinMottoEN # ")\n";
            m #= "    Category: " # p.category # "  |  SDK: " # p.sdkPackage # "  |  API: " # p.apiEndpoint # "\n";
            m #= "    Encryption: " # p.encryptionMethod # "\n";
            m #= "    Version: " # p.version # "  |  Always-On: " # (if (p.isAlwaysOn) "YES" else "NO") # "\n";
            m #= "    Trace: " # p.primitiveTrace # "\n\n";
        };

        m #= "══════════════════════════════════════════════════════════════\n";
        m #= "L-130 COMPLIANT — Every product traces to primitive φ\n";
        m #= "Attribution: Alfredo \"Freddy\" Medina Hernandez | Medina Tech | Dallas, TX\n";
        m
    };

};
