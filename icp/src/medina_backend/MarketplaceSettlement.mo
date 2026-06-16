/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║          MARKETPLACE SETTLEMENT — COMPOSITIO MERCATUS                       ║
 * ║                                                                              ║
 * ║  "Omnis vocatio habet pretium. Omnis pretium habet veritatem."              ║
 * ║  (Every call has a price. Every price has a truth.)                          ║
 * ║                                                                              ║
 * ║  Phase 6: Settlement layer — usage tracking, reward routing, billing,        ║
 * ║  token-flow, and tiered market expansion from INTERNAL to PUBLIC.           ║
 * ║                                                                              ║
 * ║  The marketplace is three things at once:                                    ║
 * ║    1. Registry — searchable map of callable tools (CallableToolMarketplace)  ║
 * ║    2. Protocol surface — standard invocation patterns (MarketplaceProtocol) ║
 * ║    3. Settlement layer — usage, reward, billing (THIS MODULE)               ║
 * ║                                                                              ║
 * ║  Three parallel market surfaces:                                             ║
 * ║    A. Internal call market — organisms, agents, SDK organisms               ║
 * ║    B. Developer call market — SDKs, API keys, docs                          ║
 * ║    C. Enterprise call market — production contracts, SLAs                   ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every settlement traces to primitive φ                   ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module MarketplaceSettlement {

    // ═══════════════════════════════════════════════════════════════════════
    // ROOT CONSTANTS
    // ═══════════════════════════════════════════════════════════════════════

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;
    public let PHI_INV : Float = 0.618033988749895;

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: DOCTRINE
    // ═══════════════════════════════════════════════════════════════════════

    public let DOCTRINE = {
        name = "MARKETPLACE-SETTLEMENT";
        latinName = "COMPOSITIO MERCATUS";
        motto = "Omnis vocatio habet pretium. Omnis pretium habet veritatem.";
        mottoEN = "Every call has a price. Every price has a truth.";
        principle = "The settlement layer tracks usage, routes rewards, and manages billing for every tool invocation across all market tiers.";
        totalBillingClasses = 5;
        totalMarketSurfaces = 3;
        totalTierExpansionPhases = 5;
        totalRewardModels = 4;
        totalSettlementEngines = 5;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type BillingClass = {
        id: Text;
        name: Text;
        latinName: Text;
        billingModel: Text;
        baseCostWeight: Float;
        description: Text;
        applicableTrustTiers: [Text];
        primitiveTrace: Text;
    };

    public type MarketSurface = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        surfaceType: Text;
        description: Text;
        participants: [Text];
        capabilities: [Text];
        billingModel: Text;
        accessMethod: Text;
        primitiveTrace: Text;
        isActive: Bool;
    };

    public type TierExpansionPhase = {
        phase: Nat;
        tierName: Text;
        latinName: Text;
        description: Text;
        prerequisites: [Text];
        marketSurfaces: [Text];
        billingClasses: [Text];
        primitiveTrace: Text;
    };

    public type RewardModel = {
        id: Text;
        name: Text;
        latinName: Text;
        rewardType: Text;
        description: Text;
        formula: Text;
        frequency_Hz: Float;
        primitiveTrace: Text;
    };

    public type SettlementEngine = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        role: Text;
        inputs: [Text];
        outputs: [Text];
        frequency_Hz: Float;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    public type SettlementRecord = {
        callId: Text;
        toolName: Text;
        callerTier: Text;
        billingClass: Text;
        costWeight: Float;
        rewardModel: Text;
        settlementEngine: Text;
        timestamp: Text;
        status: Text;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: BILLING CLASSES (5)
    // ═══════════════════════════════════════════════════════════════════════

    public let BILLING_CLASSES : [BillingClass] = [
        {
            id = "BILL-001";
            name = "HEARTBEAT";
            latinName = "PULSUS PRETII";
            billingModel = "PER_CALL";
            baseCostWeight = PHI * 0.001;
            description = "Micro-cost per heartbeat-class call";
            applicableTrustTiers = ["INTERNAL", "INTERNAL-SOVEREIGN", "PARTNER", "ENTERPRISE", "PUBLIC"];
            primitiveTrace = "φ → Repetition → Address → Heartbeat cost pulse";
        },
        {
            id = "BILL-002";
            name = "COMPUTE";
            latinName = "COMPUTATIO PRETII";
            billingModel = "PER_CALL";
            baseCostWeight = PHI * 0.01;
            description = "Standard compute cost per invocation";
            applicableTrustTiers = ["INTERNAL-SOVEREIGN", "PARTNER", "ENTERPRISE", "PUBLIC"];
            primitiveTrace = "φ → Logic → Distinction → Compute cost calculation";
        },
        {
            id = "BILL-003";
            name = "MEMORY";
            latinName = "MEMORIA PRETII";
            billingModel = "WEIGHT_BASED";
            baseCostWeight = PHI * 0.005;
            description = "Cost scaled by memory footprint";
            applicableTrustTiers = ["INTERNAL", "INTERNAL-SOVEREIGN", "PARTNER", "ENTERPRISE"];
            primitiveTrace = "φ → Persistence → Relation → Memory cost weighting";
        },
        {
            id = "BILL-004";
            name = "SECURITY";
            latinName = "SECURITAS PRETII";
            billingModel = "TOKEN_METERED";
            baseCostWeight = PHI * 0.02;
            description = "Token-metered security operations";
            applicableTrustTiers = ["INTERNAL-SOVEREIGN", "PARTNER", "ENTERPRISE"];
            primitiveTrace = "φ → Integrity → Distinction → Security cost metering";
        },
        {
            id = "BILL-005";
            name = "ROUTING";
            latinName = "DIRECTIO PRETII";
            billingModel = "FREE_TIER";
            baseCostWeight = 0.0;
            description = "Routing calls are free — routing is infrastructure";
            applicableTrustTiers = ["INTERNAL", "INTERNAL-SOVEREIGN", "PARTNER", "ENTERPRISE", "PUBLIC"];
            primitiveTrace = "φ → Address → Relation → Routing is free infrastructure";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: MARKET SURFACES (3)
    // ═══════════════════════════════════════════════════════════════════════

    public let MARKET_SURFACES : [MarketSurface] = [
        {
            id = "MKT-001";
            name = "INTERNAL CALL MARKET";
            latinName = "MERCATUS INTERNUS";
            latinMotto = "Intra muros, omnia vocabilia sunt.";
            latinMottoEN = "Within the walls, all things are callable.";
            surfaceType = "INTERNAL";
            description = "Internal call market for organisms, agents, SDK organisms, branch systems, and internal routers.";
            participants = ["organisms", "agents", "SDK organisms", "branch systems", "internal routers"];
            capabilities = ["call_internal_tools", "virtual_pricing", "weight_based_billing", "experiment_sandbox", "internal_routing"];
            billingModel = "WEIGHT_BASED";
            accessMethod = "Direct canister call or internal orchestration";
            primitiveTrace = "φ → Field → Repetition → Internal market heartbeat";
            isActive = true;
        },
        {
            id = "MKT-002";
            name = "DEVELOPER CALL MARKET";
            latinName = "MERCATUS FABRICATORUM";
            latinMotto = "Fabricator instrumentum invocat per protocollum.";
            latinMottoEN = "The builder invokes the tool through protocol.";
            surfaceType = "DEVELOPER";
            description = "Developer call market for external developers, partner builders, SDK consumers, and API integrators.";
            participants = ["external_developers", "partner_builders", "SDK_consumers", "API_integrators"];
            capabilities = ["callable_SDKs", "registry_browsing", "API_key_access", "standard_call_contracts", "documentation", "examples"];
            billingModel = "PER_CALL";
            accessMethod = "SDK + API key + principal authentication";
            primitiveTrace = "φ → Language → Address → Developer protocol surface";
            isActive = false;
        },
        {
            id = "MKT-003";
            name = "ENTERPRISE CALL MARKET";
            latinName = "MERCATUS IMPERII";
            latinMotto = "Imperium per contractum, non per spem.";
            latinMottoEN = "Enterprise through contract, not through hope.";
            surfaceType = "ENTERPRISE";
            description = "Enterprise call market for enterprise clients, production integrators, SLA holders, and bulk consumers.";
            participants = ["enterprise_clients", "production_integrators", "SLA_holders", "bulk_consumers"];
            capabilities = ["production_SLAs", "bulk_invocations", "dedicated_endpoints", "priority_routing", "custom_billing"];
            billingModel = "SUBSCRIPTION";
            accessMethod = "Enterprise contract + sovereign principal + SLA agreement";
            primitiveTrace = "φ → Integrity → Persistence → Enterprise sovereign contract";
            isActive = false;
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: TIER EXPANSION PHASES (5)
    // ═══════════════════════════════════════════════════════════════════════

    public let TIER_EXPANSION_PHASES : [TierExpansionPhase] = [
        {
            phase = 1;
            tierName = "INTERNAL";
            latinName = "INTERNUS";
            description = "Launch internal call market";
            prerequisites = ["callable_tool_registry", "internal_routing", "weight_based_billing"];
            marketSurfaces = ["MERCATUS INTERNUS"];
            billingClasses = ["HEARTBEAT", "ROUTING"];
            primitiveTrace = "φ → Field → Repetition → Internal market genesis";
        },
        {
            phase = 2;
            tierName = "INTERNAL-SOVEREIGN";
            latinName = "INTERNUS SUPREMUS";
            description = "Elevate to sovereign internal with security tools";
            prerequisites = ["security_orchestrator", "seal_verification", "integrity_checks"];
            marketSurfaces = ["MERCATUS INTERNUS"];
            billingClasses = ["HEARTBEAT", "COMPUTE", "MEMORY", "SECURITY", "ROUTING"];
            primitiveTrace = "φ → Integrity → Distinction → Sovereign elevation";
        },
        {
            phase = 3;
            tierName = "PARTNER";
            latinName = "SOCIUS";
            description = "Open to verified partners";
            prerequisites = ["partner_auth_system", "API_key_issuance", "partner_billing_engine"];
            marketSurfaces = ["MERCATUS INTERNUS", "MERCATUS FABRICATORUM"];
            billingClasses = ["HEARTBEAT", "COMPUTE", "MEMORY", "SECURITY", "ROUTING"];
            primitiveTrace = "φ → Relation → Address → Partner gate opening";
        },
        {
            phase = 4;
            tierName = "ENTERPRISE";
            latinName = "IMPERIUM";
            description = "Enterprise production access";
            prerequisites = ["SLA_framework", "dedicated_endpoints", "enterprise_billing", "production_monitoring"];
            marketSurfaces = ["MERCATUS INTERNUS", "MERCATUS FABRICATORUM", "MERCATUS IMPERII"];
            billingClasses = ["HEARTBEAT", "COMPUTE", "MEMORY", "SECURITY", "ROUTING"];
            primitiveTrace = "φ → Persistence → Integrity → Enterprise production launch";
        },
        {
            phase = 5;
            tierName = "PUBLIC";
            latinName = "PUBLICUS";
            description = "Public open access";
            prerequisites = ["public_auth_gateway", "rate_limiting", "public_documentation", "abuse_prevention"];
            marketSurfaces = ["MERCATUS INTERNUS", "MERCATUS FABRICATORUM", "MERCATUS IMPERII"];
            billingClasses = ["HEARTBEAT", "COMPUTE", "MEMORY", "SECURITY", "ROUTING"];
            primitiveTrace = "φ → Language → Field → Public market expansion";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 6: REWARD MODELS (4)
    // ═══════════════════════════════════════════════════════════════════════

    public let REWARD_MODELS : [RewardModel] = [
        {
            id = "RWD-001";
            name = "TOKEN_MINT";
            latinName = "CUDERE NUMMUM";
            rewardType = "TOKEN_MINT";
            description = "Mint MASA tokens for tool usage contributions";
            formula = "reward = calls * costWeight * PHI_INV";
            frequency_Hz = 1.618033988749895;
            primitiveTrace = "φ → Repetition → Address → Token mint cycle";
        },
        {
            id = "RWD-002";
            name = "USAGE_CREDIT";
            latinName = "CREDITUM USUS";
            rewardType = "USAGE_CREDIT";
            description = "Credit callers for high-value usage patterns";
            formula = "credit = totalCost * (1 - PHI_INV)";
            frequency_Hz = 1.618033988749895;
            primitiveTrace = "φ → Logic → Relation → Usage credit calculation";
        },
        {
            id = "RWD-003";
            name = "REVENUE_SHARE";
            latinName = "PARS REDITUS";
            rewardType = "REVENUE_SHARE";
            description = "Share revenue with tool creators and maintainers";
            formula = "share = revenue * PHI_INV * creatorWeight";
            frequency_Hz = 2.618033988749895;
            primitiveTrace = "φ → Distinction → Persistence → Revenue share distribution";
        },
        {
            id = "RWD-004";
            name = "STAKE_REWARD";
            latinName = "PRAEMIUM PIGNORIS";
            rewardType = "STAKE_REWARD";
            description = "Reward token stakers who back tool availability";
            formula = "reward = stakedTokens * uptimeRatio * PHI_INV^2";
            frequency_Hz = 1.618033988749895;
            primitiveTrace = "φ → Persistence → Integrity → Stake reward accrual";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 7: SETTLEMENT ENGINES (5)
    // ═══════════════════════════════════════════════════════════════════════

    public let SETTLEMENT_ENGINES : [SettlementEngine] = [
        {
            id = "SETTLE-001";
            name = "METERING ENGINE";
            latinName = "MACHINA MENSURAE";
            latinMotto = "Quod non mensuratur, non existit.";
            latinMottoEN = "What is not measured does not exist.";
            role = "Tracks and meters every tool call";
            inputs = ["invocation_records", "call_contracts", "billing_classes"];
            outputs = ["usage_metrics", "cost_calculations", "metering_logs"];
            frequency_Hz = 1.618033988749895;
            primitiveTrace = "φ → Repetition → Distinction → Metering pulse";
            isAlwaysOn = true;
        },
        {
            id = "SETTLE-002";
            name = "BILLING ENGINE";
            latinName = "MACHINA RATIONUM";
            latinMotto = "Ratio clara, solutio certa.";
            latinMottoEN = "Clear accounting, certain settlement.";
            role = "Calculates and applies billing for each call";
            inputs = ["usage_metrics", "billing_classes", "trust_tiers"];
            outputs = ["invoices", "billing_records", "payment_requests"];
            frequency_Hz = 1.618033988749895;
            primitiveTrace = "φ → Logic → Address → Billing calculation";
            isAlwaysOn = true;
        },
        {
            id = "SETTLE-003";
            name = "REWARD ENGINE";
            latinName = "MACHINA PRAEMIORUM";
            latinMotto = "Labor dignus est praemio suo.";
            latinMottoEN = "Labor is worthy of its reward.";
            role = "Distributes rewards to tool creators and stakers";
            inputs = ["usage_metrics", "reward_models", "creator_registry"];
            outputs = ["reward_distributions", "token_mints", "credit_grants"];
            frequency_Hz = 1.618033988749895;
            primitiveTrace = "φ → Relation → Persistence → Reward distribution";
            isAlwaysOn = true;
        },
        {
            id = "SETTLE-004";
            name = "AUDIT ENGINE";
            latinName = "MACHINA AUDITIONIS";
            latinMotto = "Veritas in rationibus latet.";
            latinMottoEN = "Truth hides in the accounts.";
            role = "Audits all settlement records for integrity";
            inputs = ["settlement_records", "billing_records", "reward_distributions"];
            outputs = ["audit_reports", "integrity_flags", "compliance_logs"];
            frequency_Hz = 2.618033988749895;
            primitiveTrace = "φ → Integrity → Logic → Audit verification";
            isAlwaysOn = true;
        },
        {
            id = "SETTLE-005";
            name = "RECONCILIATION ENGINE";
            latinName = "MACHINA RECONCILIATIONIS";
            latinMotto = "Omnia ad unum reducenda sunt.";
            latinMottoEN = "All things must be reduced to one.";
            role = "Reconciles all accounts at settlement intervals";
            inputs = ["invoices", "payments", "rewards", "credits"];
            outputs = ["reconciled_balances", "discrepancy_reports", "final_settlements"];
            frequency_Hz = 1.618033988749895;
            primitiveTrace = "φ → Field → Integrity → Final reconciliation";
            isAlwaysOn = true;
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 8: PUBLIC FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func summary() : {
        totalBillingClasses: Nat;
        totalMarketSurfaces: Nat;
        totalTierPhases: Nat;
        totalRewardModels: Nat;
        totalSettlementEngines: Nat;
        activeMarkets: Nat;
        currentPhase: Text;
        doctrine: Text;
        motto: Text;
    } {
        let active = Array.filter<MarketSurface>(MARKET_SURFACES, func(ms : MarketSurface) : Bool {
            ms.isActive;
        });
        {
            totalBillingClasses = BILLING_CLASSES.size();
            totalMarketSurfaces = MARKET_SURFACES.size();
            totalTierPhases = TIER_EXPANSION_PHASES.size();
            totalRewardModels = REWARD_MODELS.size();
            totalSettlementEngines = SETTLEMENT_ENGINES.size();
            activeMarkets = active.size();
            currentPhase = "INTERNAL";
            doctrine = DOCTRINE.name;
            motto = DOCTRINE.motto;
        };
    };

    public func getBillingClasses() : [{
        id: Text;
        name: Text;
        billingModel: Text;
        baseCostWeight: Float;
    }] {
        Array.map<BillingClass, {
            id: Text;
            name: Text;
            billingModel: Text;
            baseCostWeight: Float;
        }>(BILLING_CLASSES, func(bc : BillingClass) {
            {
                id = bc.id;
                name = bc.name;
                billingModel = bc.billingModel;
                baseCostWeight = bc.baseCostWeight;
            };
        });
    };

    public func getMarketSurfaces() : [{
        id: Text;
        name: Text;
        surfaceType: Text;
        billingModel: Text;
        isActive: Bool;
    }] {
        Array.map<MarketSurface, {
            id: Text;
            name: Text;
            surfaceType: Text;
            billingModel: Text;
            isActive: Bool;
        }>(MARKET_SURFACES, func(ms : MarketSurface) {
            {
                id = ms.id;
                name = ms.name;
                surfaceType = ms.surfaceType;
                billingModel = ms.billingModel;
                isActive = ms.isActive;
            };
        });
    };

    public func getActiveMarkets() : [MarketSurface] {
        Array.filter<MarketSurface>(MARKET_SURFACES, func(ms : MarketSurface) : Bool {
            ms.isActive;
        });
    };

    public func getTierExpansionPhases() : [{
        phase: Nat;
        tierName: Text;
        description: Text;
        marketSurfaces: [Text];
        billingClasses: [Text];
    }] {
        Array.map<TierExpansionPhase, {
            phase: Nat;
            tierName: Text;
            description: Text;
            marketSurfaces: [Text];
            billingClasses: [Text];
        }>(TIER_EXPANSION_PHASES, func(tp : TierExpansionPhase) {
            {
                phase = tp.phase;
                tierName = tp.tierName;
                description = tp.description;
                marketSurfaces = tp.marketSurfaces;
                billingClasses = tp.billingClasses;
            };
        });
    };

    public func getRewardModels() : [{
        id: Text;
        name: Text;
        rewardType: Text;
        formula: Text;
    }] {
        Array.map<RewardModel, {
            id: Text;
            name: Text;
            rewardType: Text;
            formula: Text;
        }>(REWARD_MODELS, func(rm : RewardModel) {
            {
                id = rm.id;
                name = rm.name;
                rewardType = rm.rewardType;
                formula = rm.formula;
            };
        });
    };

    public func getSettlementEngines() : [{
        id: Text;
        name: Text;
        role: Text;
        isAlwaysOn: Bool;
    }] {
        Array.map<SettlementEngine, {
            id: Text;
            name: Text;
            role: Text;
            isAlwaysOn: Bool;
        }>(SETTLEMENT_ENGINES, func(se : SettlementEngine) {
            {
                id = se.id;
                name = se.name;
                role = se.role;
                isAlwaysOn = se.isAlwaysOn;
            };
        });
    };

    public func renderSettlementManifest() : Text {
        var manifest = "╔══════════════════════════════════════════════════════════════╗\n";
        manifest #= "║         MARKETPLACE SETTLEMENT MANIFEST                      ║\n";
        manifest #= "║         COMPOSITIO MERCATUS — MANIFESTUM                     ║\n";
        manifest #= "╚══════════════════════════════════════════════════════════════╝\n\n";

        manifest #= "DOCTRINE: " # DOCTRINE.name # "\n";
        manifest #= "LATIN: " # DOCTRINE.latinName # "\n";
        manifest #= "MOTTO: " # DOCTRINE.motto # "\n";
        manifest #= "PRINCIPLE: " # DOCTRINE.principle # "\n\n";

        manifest #= "═══════════════════════════════════════════════════════════════\n";
        manifest #= "BILLING CLASSES (" # Nat.toText(BILLING_CLASSES.size()) # ")\n";
        manifest #= "═══════════════════════════════════════════════════════════════\n";
        for (bc in BILLING_CLASSES.vals()) {
            manifest #= "  [" # bc.id # "] " # bc.name # " (" # bc.latinName # ")\n";
            manifest #= "    Model: " # bc.billingModel # " | Base Cost: " # Float.toText(bc.baseCostWeight) # "\n";
            manifest #= "    " # bc.description # "\n";
            manifest #= "    Trace: " # bc.primitiveTrace # "\n\n";
        };

        manifest #= "═══════════════════════════════════════════════════════════════\n";
        manifest #= "MARKET SURFACES (" # Nat.toText(MARKET_SURFACES.size()) # ")\n";
        manifest #= "═══════════════════════════════════════════════════════════════\n";
        for (ms in MARKET_SURFACES.vals()) {
            manifest #= "  [" # ms.id # "] " # ms.name # " (" # ms.latinName # ")\n";
            manifest #= "    Type: " # ms.surfaceType # " | Billing: " # ms.billingModel # " | Active: " # (if (ms.isActive) "YES" else "NO") # "\n";
            manifest #= "    Access: " # ms.accessMethod # "\n";
            manifest #= "    Motto: " # ms.latinMotto # "\n";
            manifest #= "    Trace: " # ms.primitiveTrace # "\n\n";
        };

        manifest #= "═══════════════════════════════════════════════════════════════\n";
        manifest #= "TIER EXPANSION PHASES (" # Nat.toText(TIER_EXPANSION_PHASES.size()) # ")\n";
        manifest #= "═══════════════════════════════════════════════════════════════\n";
        for (tp in TIER_EXPANSION_PHASES.vals()) {
            manifest #= "  Phase " # Nat.toText(tp.phase) # ": " # tp.tierName # " (" # tp.latinName # ")\n";
            manifest #= "    " # tp.description # "\n";
            manifest #= "    Surfaces: " # Text.join(", ", tp.marketSurfaces.vals()) # "\n";
            manifest #= "    Billing: " # Text.join(", ", tp.billingClasses.vals()) # "\n";
            manifest #= "    Trace: " # tp.primitiveTrace # "\n\n";
        };

        manifest #= "═══════════════════════════════════════════════════════════════\n";
        manifest #= "REWARD MODELS (" # Nat.toText(REWARD_MODELS.size()) # ")\n";
        manifest #= "═══════════════════════════════════════════════════════════════\n";
        for (rm in REWARD_MODELS.vals()) {
            manifest #= "  [" # rm.id # "] " # rm.name # " (" # rm.latinName # ")\n";
            manifest #= "    Type: " # rm.rewardType # " | Freq: " # Float.toText(rm.frequency_Hz) # " Hz\n";
            manifest #= "    Formula: " # rm.formula # "\n";
            manifest #= "    " # rm.description # "\n";
            manifest #= "    Trace: " # rm.primitiveTrace # "\n\n";
        };

        manifest #= "═══════════════════════════════════════════════════════════════\n";
        manifest #= "SETTLEMENT ENGINES (" # Nat.toText(SETTLEMENT_ENGINES.size()) # ")\n";
        manifest #= "═══════════════════════════════════════════════════════════════\n";
        for (se in SETTLEMENT_ENGINES.vals()) {
            manifest #= "  [" # se.id # "] " # se.name # " (" # se.latinName # ")\n";
            manifest #= "    Role: " # se.role # " | Always On: " # (if (se.isAlwaysOn) "YES" else "NO") # " | Freq: " # Float.toText(se.frequency_Hz) # " Hz\n";
            manifest #= "    Motto: " # se.latinMotto # "\n";
            manifest #= "    Inputs: " # Text.join(", ", se.inputs.vals()) # "\n";
            manifest #= "    Outputs: " # Text.join(", ", se.outputs.vals()) # "\n";
            manifest #= "    Trace: " # se.primitiveTrace # "\n\n";
        };

        manifest #= "═══════════════════════════════════════════════════════════════\n";
        manifest #= "φ = " # Float.toText(PHI) # " — All settlements trace to φ\n";
        manifest #= "═══════════════════════════════════════════════════════════════\n";

        manifest;
    };
};
