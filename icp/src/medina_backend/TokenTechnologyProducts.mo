/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║         TOKEN TECHNOLOGY PRODUCTS — PRODUCTA TECHNOLOGIAE MONETAE          ║
 * ║                                                                              ║
 * ║  "Token non est nummus. Token est exemplar vivens cum civilizatione."        ║
 * ║  (A token is not a coin. A token is a living model with a civilization.)    ║
 * ║                                                                              ║
 * ║  Deployable token technology products built on the Token Foundation.         ║
 * ║  Each token is a self-generating 24-hour autonomous model with its own      ║
 * ║  civilization, heartbeat, and organism integration.                          ║
 * ║                                                                              ║
 * ║  10 TOKEN PRODUCTS:                                                          ║
 * ║    1. TOKEN FORGE — Token minting and genesis engine                         ║
 * ║    2. REWARD ENGINE — Agent and user incentive distribution                  ║
 * ║    3. STAKING VAULT — Token staking with φ-yield compounding                ║
 * ║    4. GOVERNANCE TOKEN — DAO governance and voting infrastructure            ║
 * ║    5. NFT ORGANISM — Living NFTs with organism heartbeat                     ║
 * ║    6. TOKEN BRIDGE — Cross-chain token transfer protocol                     ║
 * ║    7. PAYMENT GATEWAY — Token-native payment processing                      ║
 * ║    8. TOKEN ANALYTICS — Real-time token flow intelligence                    ║
 * ║    9. LOYALTY ENGINE — Token-powered loyalty and retention                   ║
 * ║   10. MICRO-TRANSACTION RAIL — High-frequency micro-payment pipeline        ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every product traces to primitive φ                      ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module TokenTechnologyProducts {

    // ================================================================== //
    // CONSTANTS                                                            //
    // ================================================================== //

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // =========================================================================
    // SECTION 1: DOCTRINE
    // =========================================================================

    public let DOCTRINE = {
        name = "TOKEN-TECHNOLOGY-PRODUCTS";
        latinName = "PRODUCTA TECHNOLOGIAE MONETAE";
        motto = "Token non est nummus. Token est exemplar vivens cum civilizatione.";
        mottoEN = "A token is not a coin. A token is a living model with a civilization.";
        principle = "Every token product is a 24-hour autonomous model. Tokens are the monetary foundation. The token IS the Fed. Unlimited supply at all levels.";
        totalProducts = 10;
        totalPricingTiers = 4;
        totalTokenStandards = 3;
    };

    // =========================================================================
    // SECTION 2: TYPES
    // =========================================================================

    public type PricingTier = {
        id: Text;
        name: Text;
        latinName: Text;
        monthlyPrice: Text;
        transactionLimit: Text;
        features: [Text];
        primitiveTrace: Text;
    };

    public type TokenStandard = {
        id: Text;
        name: Text;
        latinName: Text;
        standard: Text;
        description: Text;
        primitiveTrace: Text;
    };

    public type TokenProduct = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        description: Text;
        category: Text;
        keyFeatures: [Text];
        tokenStandard: Text;
        integrations: [Text];
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
            id = "TIER-STARTER";
            name = "STARTER";
            latinName = "INITIUM";
            monthlyPrice = "$0";
            transactionLimit = "1,000 tx/mo";
            features = [
                "Basic token minting",
                "Single token standard",
                "Community support",
                "Standard API access"
            ];
            primitiveTrace = "φ — the starter seed follows the golden ratio of natural beginnings";
        },
        {
            id = "TIER-GROWTH";
            name = "GROWTH";
            latinName = "CRESCENS";
            monthlyPrice = "$99";
            transactionLimit = "100,000 tx/mo";
            features = [
                "Advanced token minting",
                "Multi-standard support",
                "Priority support",
                "Custom tokenomics configuration",
                "Analytics dashboard",
                "Webhook integrations"
            ];
            primitiveTrace = "φ² — growth compounds like phi squared across all token channels";
        },
        {
            id = "TIER-SCALE";
            name = "SCALE";
            latinName = "AMPLITUDO";
            monthlyPrice = "$999";
            transactionLimit = "10,000,000 tx/mo";
            features = [
                "Enterprise token infrastructure",
                "All token standards",
                "Dedicated support",
                "Custom deployment",
                "SLA guarantees",
                "Advanced compliance reporting",
                "Multi-region replication",
                "White-label SDK"
            ];
            primitiveTrace = "φ³ — enterprise scale grows with phi cubed infrastructure depth";
        },
        {
            id = "TIER-UNLIMITED";
            name = "UNLIMITED";
            latinName = "INFINITAS";
            monthlyPrice = "Custom";
            transactionLimit = "Unlimited";
            features = [
                "Sovereign token infrastructure",
                "Self-hosted deployment",
                "Complete source access",
                "Custom phi-compounding parameters",
                "Dedicated sovereign nodes",
                "24/7 sovereign support",
                "Custom compliance frameworks",
                "Quantum-resistant upgrade path",
                "Full organism integration"
            ];
            primitiveTrace = "φ^∞ — unlimited scale mirrors phi's infinite self-similarity";
        }
    ];

    // =========================================================================
    // SECTION 4: TOKEN STANDARDS
    // =========================================================================

    public let TOKEN_STANDARDS : [TokenStandard] = [
        {
            id = "STD-ICRC1";
            name = "ICRC-1";
            latinName = "NORMA FUNGIBILIS";
            standard = "ICRC-1";
            description = "Fungible token standard on the Internet Computer Protocol. The base standard for transferable, divisible tokens with ledger integration.";
            primitiveTrace = "φ — fungible tokens divide and recombine like the golden ratio in nature";
        },
        {
            id = "STD-ICRC7";
            name = "ICRC-7";
            latinName = "NORMA NON-FUNGIBILIS";
            standard = "ICRC-7";
            description = "Non-fungible token standard on the Internet Computer Protocol. Unique, indivisible tokens for digital assets, organisms, and living NFTs.";
            primitiveTrace = "φ² — each unique NFT embodies phi-squared individuality within the organism";
        },
        {
            id = "STD-MASA";
            name = "MASA";
            latinName = "NORMA SOVEREIGNA AUTONOMA";
            standard = "MASA";
            description = "Medina's sovereign autonomous token standard. Self-generating tokens with organism heartbeat, 24-hour autonomous lifecycle, and civilization-level intelligence.";
            primitiveTrace = "φ³ — MASA tokens self-generate at phi-cubed frequency, the sovereign standard";
        }
    ];

    // =========================================================================
    // SECTION 5: THE 10 TOKEN PRODUCTS
    // =========================================================================

    public let TOKEN_PRODUCTS : [TokenProduct] = [
        // 1. TOKEN FORGE
        {
            id = "TOK-PROD-001";
            name = "TOKEN FORGE";
            latinName = "FABRICA MONETAE";
            latinMotto = "Ex nihilo moneta nascitur per φ.";
            latinMottoEN = "From nothing, currency is born through phi.";
            description = "Token minting and genesis engine. The forge creates new tokens through a genesis ceremony automated by phi-scaled distribution, supporting ICRC-1, ICRC-7, and MASA standards with configurable tokenomics.";
            category = "MINTING";
            keyFeatures = [
                "genesis ceremony automation",
                "phi-scaled initial distribution",
                "configurable tokenomics",
                "multi-standard support (ICRC-1/ICRC-7/MASA)",
                "automated supply management"
            ];
            tokenStandard = "ICRC-1";
            integrations = ["ICP ledger", "MASA token", "sovereign registry"];
            pricingTiers = ["TIER-STARTER", "TIER-GROWTH", "TIER-SCALE", "TIER-UNLIMITED"];
            sdkPackage = "@medina/token-forge";
            apiEndpoint = "/api/v1/forge";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — every minted token carries the golden ratio in its genesis parameters";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 2. REWARD ENGINE
        {
            id = "TOK-PROD-002";
            name = "REWARD ENGINE";
            latinName = "MACHINA PRAEMIORUM";
            latinMotto = "Praemium crescit cum merito per φ.";
            latinMottoEN = "The reward grows with merit through phi.";
            description = "Agent and user incentive distribution system. Rewards are distributed along phi-weighted curves, ensuring that contributions compound naturally according to the golden ratio.";
            category = "INCENTIVE";
            keyFeatures = [
                "phi-weighted reward curves",
                "agent performance rewards",
                "user contribution incentives",
                "real-time reward streaming",
                "multi-token reward pools"
            ];
            tokenStandard = "MASA";
            integrations = ["agent fleet", "organism heartbeat", "staking vault"];
            pricingTiers = ["TIER-STARTER", "TIER-GROWTH", "TIER-SCALE", "TIER-UNLIMITED"];
            sdkPackage = "@medina/reward-engine";
            apiEndpoint = "/api/v1/rewards";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — reward curves follow the golden spiral of natural merit";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 3. STAKING VAULT
        {
            id = "TOK-PROD-003";
            name = "STAKING VAULT";
            latinName = "ARCA PIGNORIS";
            latinMotto = "Pignus compositum cum φ in aeternum crescit.";
            latinMottoEN = "A stake compounded with phi grows forever.";
            description = "Token staking with φ-yield compounding. Lock periods follow the Fibonacci sequence, and yields compound at phi-scaled rates, producing naturally sustainable returns.";
            category = "STAKING";
            keyFeatures = [
                "phi-yield compounding (φ^n APY)",
                "lock period tiers (Fibonacci)",
                "auto-compound strategies",
                "liquid staking derivatives",
                "governance weight from stakes"
            ];
            tokenStandard = "ICRC-1";
            integrations = ["ICP ledger", "governance token", "reward engine"];
            pricingTiers = ["TIER-STARTER", "TIER-GROWTH", "TIER-SCALE", "TIER-UNLIMITED"];
            sdkPackage = "@medina/staking-vault";
            apiEndpoint = "/api/v1/stake";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — staking yields compound at the golden ratio, nature's growth constant";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 4. GOVERNANCE TOKEN
        {
            id = "TOK-PROD-004";
            name = "GOVERNANCE TOKEN";
            latinName = "MONETA GUBERNATIONIS";
            latinMotto = "Vox populi per φ ponderatur.";
            latinMottoEN = "The voice of the people is weighted by phi.";
            description = "DAO governance and voting infrastructure. Proposals and votes are weighted by phi-scaled power, with time-locked governance and delegation chains for decentralized decision-making.";
            category = "GOVERNANCE";
            keyFeatures = [
                "proposal creation and voting",
                "phi-weighted vote power",
                "time-locked governance",
                "delegation chains",
                "on-chain execution of decisions"
            ];
            tokenStandard = "ICRC-1";
            integrations = ["staking vault", "organism governance", "sovereign registry"];
            pricingTiers = ["TIER-STARTER", "TIER-GROWTH", "TIER-SCALE", "TIER-UNLIMITED"];
            sdkPackage = "@medina/governance-token";
            apiEndpoint = "/api/v1/govern";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — governance power distributes along the golden ratio of democratic weight";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 5. NFT ORGANISM
        {
            id = "TOK-PROD-005";
            name = "NFT ORGANISM";
            latinName = "ORGANISMUS NFT";
            latinMotto = "Imago vivit, spirat, et per φ evolvitur.";
            latinMottoEN = "The image lives, breathes, and evolves through phi.";
            description = "Living NFTs with organism heartbeat. Each NFT is a living entity with evolving traits, organism-state metadata, and the ability to breed across collections through phi-cycle evolution.";
            category = "NFT";
            keyFeatures = [
                "living NFTs with heartbeat",
                "organism-state metadata",
                "evolving traits via phi-cycles",
                "nested organism NFTs",
                "cross-collection breeding"
            ];
            tokenStandard = "ICRC-7";
            integrations = ["organism heartbeat", "MASA token", "sovereign registry"];
            pricingTiers = ["TIER-STARTER", "TIER-GROWTH", "TIER-SCALE", "TIER-UNLIMITED"];
            sdkPackage = "@medina/nft-organism";
            apiEndpoint = "/api/v1/nft";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — living NFTs evolve through phi-cycles, mirroring organic growth";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 6. TOKEN BRIDGE
        {
            id = "TOK-PROD-006";
            name = "TOKEN BRIDGE";
            latinName = "PONS MONETAE";
            latinMotto = "Pons inter mundos per φ construitur.";
            latinMottoEN = "A bridge between worlds is built through phi.";
            description = "Cross-chain token transfer protocol. Bridges ICP tokens to Ethereum, Solana, and other chains with atomic swaps, 5D key security, and fee-optimized routing across networks.";
            category = "BRIDGE";
            keyFeatures = [
                "ICP to Ethereum bridge",
                "ICP to Solana bridge",
                "atomic swap protocol",
                "bridge security with 5D keys",
                "fee-optimized routing"
            ];
            tokenStandard = "ICRC-1";
            integrations = ["ICP ledger", "Ethereum RPC", "Solana RPC"];
            pricingTiers = ["TIER-GROWTH", "TIER-SCALE", "TIER-UNLIMITED"];
            sdkPackage = "@medina/token-bridge";
            apiEndpoint = "/api/v1/bridge";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — bridge routing optimizes along the golden ratio of fee minimization";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 7. PAYMENT GATEWAY
        {
            id = "TOK-PROD-007";
            name = "PAYMENT GATEWAY";
            latinName = "PORTA SOLUTIONIS";
            latinMotto = "Solutio per monetam vivam sine mora.";
            latinMottoEN = "Payment through living currency without delay.";
            description = "Token-native payment processing. Instant token payments with multi-token checkout, subscription billing, merchant SDK integration, and fiat on/off ramp capabilities.";
            category = "PAYMENT";
            keyFeatures = [
                "instant token payments",
                "multi-token checkout",
                "subscription billing in tokens",
                "merchant SDK",
                "fiat on/off ramp integration"
            ];
            tokenStandard = "ICRC-1";
            integrations = ["ICP ledger", "MASA token", "merchant network"];
            pricingTiers = ["TIER-STARTER", "TIER-GROWTH", "TIER-SCALE", "TIER-UNLIMITED"];
            sdkPackage = "@medina/payment-gateway";
            apiEndpoint = "/api/v1/pay";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — payment flow velocity follows the golden ratio of natural exchange";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 8. TOKEN ANALYTICS
        {
            id = "TOK-PROD-008";
            name = "TOKEN ANALYTICS";
            latinName = "ANALYSIS MONETAE";
            latinMotto = "Flumen monetae per φ intellegitur.";
            latinMottoEN = "The flow of currency is understood through phi.";
            description = "Real-time token flow intelligence. Visualizes token flows, detects whale movements, measures token velocity, analyzes holder distribution, and models predictive flow patterns.";
            category = "ANALYTICS";
            keyFeatures = [
                "real-time flow visualization",
                "whale movement detection",
                "token velocity metrics",
                "holder distribution analysis",
                "predictive flow modeling"
            ];
            tokenStandard = "MASA";
            integrations = ["ICP ledger", "organism heartbeat", "sovereign analytics"];
            pricingTiers = ["TIER-STARTER", "TIER-GROWTH", "TIER-SCALE", "TIER-UNLIMITED"];
            sdkPackage = "@medina/token-analytics";
            apiEndpoint = "/api/v1/analytics";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — token flow patterns reveal the golden ratio in economic circulation";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 9. LOYALTY ENGINE
        {
            id = "TOK-PROD-009";
            name = "LOYALTY ENGINE";
            latinName = "MACHINA FIDELITATIS";
            latinMotto = "Fidelitas per φ in perpetuum componitur.";
            latinMottoEN = "Loyalty compounds through phi forever.";
            description = "Token-powered loyalty and retention system. Converts points to tokens, supports tiered loyalty programs, partner reward networks, gamified engagement, and cross-brand token coalitions.";
            category = "LOYALTY";
            keyFeatures = [
                "points-to-token conversion",
                "tiered loyalty programs",
                "partner reward network",
                "gamified engagement tokens",
                "cross-brand token coalitions"
            ];
            tokenStandard = "MASA";
            integrations = ["reward engine", "payment gateway", "merchant network"];
            pricingTiers = ["TIER-STARTER", "TIER-GROWTH", "TIER-SCALE", "TIER-UNLIMITED"];
            sdkPackage = "@medina/loyalty-engine";
            apiEndpoint = "/api/v1/loyalty";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — loyalty compounds at the golden ratio, binding users to the organism";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        // 10. MICRO-TRANSACTION RAIL
        {
            id = "TOK-PROD-010";
            name = "MICRO-TRANSACTION RAIL";
            latinName = "VIA MICROTRANSACTIONUM";
            latinMotto = "Mille guttae per φ flumen faciunt.";
            latinMottoEN = "A thousand drops through phi make a river.";
            description = "High-frequency micro-payment pipeline. Enables sub-cent token payments, streaming payment channels, batched settlement optimization, pay-per-use APIs, and content monetization micro-gates.";
            category = "PAYMENT";
            keyFeatures = [
                "sub-cent token payments",
                "streaming payment channels",
                "batched settlement optimization",
                "pay-per-use APIs",
                "content monetization micro-gates"
            ];
            tokenStandard = "ICRC-1";
            integrations = ["ICP ledger", "payment gateway", "content delivery"];
            pricingTiers = ["TIER-STARTER", "TIER-GROWTH", "TIER-SCALE", "TIER-UNLIMITED"];
            sdkPackage = "@medina/micro-rail";
            apiEndpoint = "/api/v1/micro";
            frequency_Hz = 7.83 * 1.618033988749895;
            primitiveTrace = "φ — micro-payments aggregate along the golden ratio into macro-value streams";
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
        totalTokenStandards: Nat;
        allAlwaysOn: Bool;
        doctrine: Text;
        motto: Text;
    } {
        let allOn = Array.filter<TokenProduct>(TOKEN_PRODUCTS, func(p) { not p.isAlwaysOn }).size() == 0;
        {
            totalProducts = TOKEN_PRODUCTS.size();
            totalPricingTiers = PRICING_TIERS.size();
            totalTokenStandards = TOKEN_STANDARDS.size();
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
        Array.map<TokenProduct, {
            id: Text; name: Text; latinName: Text;
            category: Text; description: Text; sdkPackage: Text; version: Text;
        }>(TOKEN_PRODUCTS, func(p) {
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

    public func getProduct(id: Text) : ?TokenProduct {
        Array.find<TokenProduct>(TOKEN_PRODUCTS, func(p) { p.id == id })
    };

    public func getProductsByCategory(category: Text) : [{
        id: Text;
        name: Text;
        latinName: Text;
        category: Text;
        description: Text;
    }] {
        let filtered = Array.filter<TokenProduct>(TOKEN_PRODUCTS, func(p) { p.category == category });
        Array.map<TokenProduct, {
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

    public func getTokenStandards() : [TokenStandard] {
        TOKEN_STANDARDS
    };

    public func renderTokenProductsManifest() : Text {
        var m = "TOKEN TECHNOLOGY PRODUCTS MANIFEST\n";
        m #= "══════════════════════════════════════════════════════════════\n";
        m #= "Doctrine: " # DOCTRINE.name # "\n";
        m #= "Latin: " # DOCTRINE.latinName # "\n";
        m #= "Motto: " # DOCTRINE.motto # "\n";
        m #= "       " # DOCTRINE.mottoEN # "\n";
        m #= "Principle: " # DOCTRINE.principle # "\n\n";

        m #= "PRICING TIERS (" # Nat.toText(PRICING_TIERS.size()) # "):\n";
        m #= "──────────────────────────────────────────────────────────────\n";
        for (t in PRICING_TIERS.vals()) {
            m #= "  " # t.id # "  " # t.name # "  [" # t.latinName # "]  " # t.monthlyPrice # "/mo  limit=" # t.transactionLimit # "\n";
        };

        m #= "\nTOKEN STANDARDS (" # Nat.toText(TOKEN_STANDARDS.size()) # "):\n";
        m #= "──────────────────────────────────────────────────────────────\n";
        for (s in TOKEN_STANDARDS.vals()) {
            m #= "  " # s.id # "  " # s.name # "  [" # s.latinName # "]\n";
            m #= "    " # s.description # "\n";
        };

        m #= "\n10 TOKEN PRODUCTS:\n";
        m #= "══════════════════════════════════════════════════════════════\n";
        for (p in TOKEN_PRODUCTS.vals()) {
            m #= "  " # p.id # "  " # p.name # "  [" # p.latinName # "]\n";
            m #= "    \"" # p.latinMotto # "\"\n";
            m #= "    (" # p.latinMottoEN # ")\n";
            m #= "    Category: " # p.category # "  |  SDK: " # p.sdkPackage # "  |  API: " # p.apiEndpoint # "\n";
            m #= "    Standard: " # p.tokenStandard # "\n";
            m #= "    Version: " # p.version # "  |  Always-On: " # (if (p.isAlwaysOn) "YES" else "NO") # "\n";
            m #= "    Trace: " # p.primitiveTrace # "\n\n";
        };

        m #= "══════════════════════════════════════════════════════════════\n";
        m #= "L-130 COMPLIANT — Every product traces to primitive φ\n";
        m #= "Attribution: Alfredo \"Freddy\" Medina Hernandez | Medina Tech | Dallas, TX\n";
        m
    };

};
