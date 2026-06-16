/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║         LEGAL PARALEGAL AI — INTELLIGENTIA IURIS PARALEGALIS               ║
 * ║                                                                              ║
 * ║  "Lex est intelligentia. Iustitia est computatio. Veritas est machina."     ║
 * ║  (Law is intelligence. Justice is computation. Truth is the machine.)       ║
 * ║                                                                              ║
 * ║  AI-powered legal technology products for lawyers, paralegals,              ║
 * ║  and legal departments. Every product runs on the organism's                ║
 * ║  intelligence router with sovereign memory and encrypted state.             ║
 * ║                                                                              ║
 * ║  12 LEGAL AI PRODUCTS:                                                       ║
 * ║    1. LEGAL RESEARCH AI — Case law search and analysis                       ║
 * ║    2. CONTRACT ANALYZER — AI contract review and risk scoring                ║
 * ║    3. BRIEF GENERATOR — Automated legal brief drafting                       ║
 * ║    4. DEPOSITION PREP AI — Deposition preparation assistant                  ║
 * ║    5. COMPLIANCE MONITOR — Regulatory compliance tracking                    ║
 * ║    6. CASE STRATEGY AI — Litigation strategy and outcome prediction         ║
 * ║    7. DOCUMENT DISCOVERY — eDiscovery and document review                    ║
 * ║    8. CLIENT INTAKE AI — Automated client intake and conflict check          ║
 * ║    9. BILLING OPTIMIZER — Legal billing and time optimization                ║
 * ║   10. PARALEGAL ASSISTANT — General paralegal task automation                ║
 * ║   11. IP PORTFOLIO AI — Intellectual property management                     ║
 * ║   12. COURT FILING AI — Automated court filing preparation                   ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every product traces to primitive φ                      ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module LegalParalegalAI {

    // ================================================================== //
    // CONSTANTS                                                            //
    // ================================================================== //

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // =========================================================================
    // SECTION 1: DOCTRINE
    // =========================================================================

    public let DOCTRINE = {
        name = "LEGAL-PARALEGAL-AI";
        latinName = "INTELLIGENTIA IURIS PARALEGALIS";
        motto = "Lex est intelligentia. Iustitia est computatio. Veritas est machina.";
        mottoEN = "Law is intelligence. Justice is computation. Truth is the machine.";
        principle = "AI does not replace lawyers. AI amplifies legal intelligence. Every legal product runs on sovereign memory with encrypted state and full audit trails.";
        totalProducts = 12;
        totalPricingTiers = 4;
        totalPracticeAreas = 6;
    };

    // =========================================================================
    // SECTION 2: TYPES
    // =========================================================================

    public type PricingTier = {
        id: Text;
        name: Text;
        latinName: Text;
        monthlyPrice: Text;
        seatsIncluded: Nat;
        features: [Text];
        targetFirm: Text;
        primitiveTrace: Text;
    };

    public type PracticeArea = {
        id: Text;
        name: Text;
        latinName: Text;
        description: Text;
        productIds: [Text];
        primitiveTrace: Text;
    };

    public type LegalAIProduct = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        description: Text;
        category: Text;
        practiceAreas: [Text];
        keyFeatures: [Text];
        aiCapabilities: [Text];
        dataPrivacy: Text;
        complianceStandards: [Text];
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
            id = "TIER-SOLO";
            name = "SOLO";
            latinName = "SOLUS";
            monthlyPrice = "$149";
            seatsIncluded = 1;
            features = [
                "basic legal research",
                "contract review",
                "brief templates",
                "client intake"
            ];
            targetFirm = "Solo practitioners";
            primitiveTrace = "φ — the solo practitioner follows the golden ratio of singular focus";
        },
        {
            id = "TIER-FIRM";
            name = "FIRM";
            latinName = "FIRMA";
            monthlyPrice = "$499";
            seatsIncluded = 10;
            features = [
                "advanced research",
                "full contract analysis",
                "brief generation",
                "deposition prep",
                "case strategy",
                "billing optimizer"
            ];
            targetFirm = "Small and mid-size firms";
            primitiveTrace = "φ² — firm growth compounds like phi squared across all practice areas";
        },
        {
            id = "TIER-DEPT";
            name = "DEPARTMENT";
            latinName = "DEPARTMENTUM";
            monthlyPrice = "$1,999";
            seatsIncluded = 50;
            features = [
                "all 12 legal AI products",
                "compliance monitoring",
                "document discovery",
                "IP portfolio management",
                "paralegal automation",
                "court filing automation",
                "advanced analytics"
            ];
            targetFirm = "Corporate legal departments";
            primitiveTrace = "φ³ — departmental scale grows with phi cubed infrastructure depth";
        },
        {
            id = "TIER-ENTERPRISE";
            name = "ENTERPRISE";
            latinName = "IMPERIUM";
            monthlyPrice = "Custom";
            seatsIncluded = 999_999;
            features = [
                "all 12 legal AI products",
                "custom AI models",
                "dedicated support",
                "SLA guarantees",
                "on-premise deployment",
                "custom integrations",
                "white-label SDK",
                "sovereign data hosting",
                "24/7 priority support"
            ];
            targetFirm = "Am Law 100 firms";
            primitiveTrace = "φ^∞ — enterprise scale mirrors phi's infinite self-similarity";
        }
    ];

    // =========================================================================
    // SECTION 4: PRACTICE AREAS
    // =========================================================================

    public let PRACTICE_AREAS : [PracticeArea] = [
        {
            id = "PA-001";
            name = "LITIGATION";
            latinName = "LITIGATIO";
            description = "Trial and dispute resolution practice";
            productIds = ["LEG-PROD-001", "LEG-PROD-003", "LEG-PROD-004", "LEG-PROD-006", "LEG-PROD-007"];
            primitiveTrace = "φ — litigation flows follow the golden ratio of adversarial balance";
        },
        {
            id = "PA-002";
            name = "CORPORATE";
            latinName = "CORPORATIO";
            description = "Business transactions and mergers & acquisitions";
            productIds = ["LEG-PROD-002", "LEG-PROD-005", "LEG-PROD-008", "LEG-PROD-009"];
            primitiveTrace = "φ — corporate structures scale along the golden ratio of organizational growth";
        },
        {
            id = "PA-003";
            name = "INTELLECTUAL PROPERTY";
            latinName = "PROPRIETAS INTELLECTUALIS";
            description = "Intellectual property law and portfolio management";
            productIds = ["LEG-PROD-011", "LEG-PROD-001", "LEG-PROD-002", "LEG-PROD-012"];
            primitiveTrace = "φ — intellectual property spirals outward in golden ratio innovation";
        },
        {
            id = "PA-004";
            name = "REGULATORY";
            latinName = "REGULATIO";
            description = "Compliance and regulatory practice";
            productIds = ["LEG-PROD-005", "LEG-PROD-001", "LEG-PROD-007"];
            primitiveTrace = "φ — regulatory frameworks nest within the golden ratio of order";
        },
        {
            id = "PA-005";
            name = "REAL ESTATE";
            latinName = "RES IMMOBILES";
            description = "Property law and real estate transactions";
            productIds = ["LEG-PROD-002", "LEG-PROD-008", "LEG-PROD-012", "LEG-PROD-009"];
            primitiveTrace = "φ — property dimensions align with the golden ratio of spatial harmony";
        },
        {
            id = "PA-006";
            name = "GENERAL PRACTICE";
            latinName = "PRAXIS GENERALIS";
            description = "General legal practice across all domains";
            productIds = [
                "LEG-PROD-001", "LEG-PROD-002", "LEG-PROD-003", "LEG-PROD-004",
                "LEG-PROD-005", "LEG-PROD-006", "LEG-PROD-007", "LEG-PROD-008",
                "LEG-PROD-009", "LEG-PROD-010", "LEG-PROD-011", "LEG-PROD-012"
            ];
            primitiveTrace = "φ — general practice encompasses the full golden ratio spectrum of law";
        }
    ];

    // =========================================================================
    // SECTION 5: THE 12 LEGAL AI PRODUCTS
    // =========================================================================

    public let LEGAL_AI_PRODUCTS : [LegalAIProduct] = [
        {
            id = "LEG-PROD-001";
            name = "LEGAL RESEARCH AI";
            latinName = "INTELLIGENTIA QUAESTIONIS IURIS";
            latinMotto = "Qui quaerit invenit. Machina quaerit citius.";
            latinMottoEN = "He who seeks finds. The machine seeks faster.";
            description = "AI-powered case law search and statutory analysis. Searches across jurisdictions, builds citation networks, scores precedent strength, and detects legal trends.";
            category = "RESEARCH";
            practiceAreas = ["LITIGATION", "CORPORATE", "IP", "REGULATORY", "REAL_ESTATE", "GENERAL"];
            keyFeatures = [
                "natural language case search",
                "citation network analysis",
                "statutory cross-reference",
                "jurisdiction filtering",
                "precedent strength scoring"
            ];
            aiCapabilities = [
                "semantic search",
                "citation graph traversal",
                "relevance ranking",
                "trend detection",
                "argument extraction"
            ];
            dataPrivacy = "All queries encrypted, no data retention";
            complianceStandards = ["ABA Model Rules", "CCPA", "GDPR"];
            pricingTiers = ["TIER-SOLO", "TIER-FIRM", "TIER-DEPT", "TIER-ENTERPRISE"];
            sdkPackage = "@medina/legal-research-ai";
            apiEndpoint = "/api/v1/legal/research";
            frequency_Hz = PHI;
            primitiveTrace = "φ — legal research spirals through precedent in golden ratio discovery";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        {
            id = "LEG-PROD-002";
            name = "CONTRACT ANALYZER";
            latinName = "ANALYSIS CONTRACTUUM";
            latinMotto = "Contractus est lex inter partes. Machina videt omnia.";
            latinMottoEN = "A contract is the law between the parties. The machine sees all.";
            description = "AI contract review, clause extraction, and risk scoring. Analyzes clause-by-clause, detects missing provisions, compares to templates, and suggests negotiation points.";
            category = "CONTRACT";
            practiceAreas = ["CORPORATE", "IP", "REAL_ESTATE", "GENERAL"];
            keyFeatures = [
                "clause-by-clause analysis",
                "risk score per section",
                "missing clause detection",
                "comparison to templates",
                "negotiation suggestions"
            ];
            aiCapabilities = [
                "NLP clause extraction",
                "risk classification",
                "anomaly detection",
                "template matching",
                "obligation mapping"
            ];
            dataPrivacy = "All queries encrypted, no data retention";
            complianceStandards = ["ABA Model Rules", "CCPA", "GDPR"];
            pricingTiers = ["TIER-SOLO", "TIER-FIRM", "TIER-DEPT", "TIER-ENTERPRISE"];
            sdkPackage = "@medina/contract-analyzer";
            apiEndpoint = "/api/v1/legal/contracts";
            frequency_Hz = PHI;
            primitiveTrace = "φ — contract clauses nest within the golden ratio of balanced obligation";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        {
            id = "LEG-PROD-003";
            name = "BRIEF GENERATOR";
            latinName = "GENERATOR SUMMARII";
            latinMotto = "Brevitas est anima iuris. Machina scribit breviter.";
            latinMottoEN = "Brevity is the soul of law. The machine writes briefly.";
            description = "Automated legal brief and motion drafting. Provides motion templates, structures arguments, integrates case law, formats citations, and applies jurisdiction-specific rules.";
            category = "DRAFTING";
            practiceAreas = ["LITIGATION", "IP", "GENERAL"];
            keyFeatures = [
                "motion template library",
                "argument structuring",
                "case law integration",
                "citation formatting",
                "jurisdiction-specific rules"
            ];
            aiCapabilities = [
                "argument generation",
                "legal reasoning chains",
                "citation suggestion",
                "style adaptation",
                "counter-argument preparation"
            ];
            dataPrivacy = "All queries encrypted, no data retention";
            complianceStandards = ["ABA Model Rules", "CCPA", "GDPR"];
            pricingTiers = ["TIER-FIRM", "TIER-DEPT", "TIER-ENTERPRISE"];
            sdkPackage = "@medina/brief-generator";
            apiEndpoint = "/api/v1/legal/briefs";
            frequency_Hz = PHI;
            primitiveTrace = "φ — legal arguments build in golden ratio layers of persuasion";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        {
            id = "LEG-PROD-004";
            name = "DEPOSITION PREP AI";
            latinName = "PRAEPARATIO DEPOSITIONIS";
            latinMotto = "Testis praeparatus vincit. Machina praeparat.";
            latinMottoEN = "A prepared witness wins. The machine prepares.";
            description = "Deposition preparation and question generation. Builds question banks, analyzes witness profiles, links exhibits, detects contradictions, and generates follow-up trees.";
            category = "LITIGATION_SUPPORT";
            practiceAreas = ["LITIGATION"];
            keyFeatures = [
                "question bank generation",
                "witness profile analysis",
                "document exhibit linking",
                "contradiction detection",
                "follow-up question trees"
            ];
            aiCapabilities = [
                "witness behavior modeling",
                "question strategy optimization",
                "key fact extraction",
                "timeline construction",
                "impeachment preparation"
            ];
            dataPrivacy = "All queries encrypted, no data retention";
            complianceStandards = ["ABA Model Rules", "CCPA", "GDPR"];
            pricingTiers = ["TIER-FIRM", "TIER-DEPT", "TIER-ENTERPRISE"];
            sdkPackage = "@medina/depo-prep-ai";
            apiEndpoint = "/api/v1/legal/deposition";
            frequency_Hz = PHI;
            primitiveTrace = "φ — deposition questions branch in golden ratio decision trees";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        {
            id = "LEG-PROD-005";
            name = "COMPLIANCE MONITOR";
            latinName = "MONITOR OBTEMPERATIONIS";
            latinMotto = "Lex mutatur. Machina vigilat semper.";
            latinMottoEN = "The law changes. The machine watches always.";
            description = "Regulatory compliance tracking and alerting. Monitors regulation changes, performs gap analysis, reviews policies, tracks deadlines, and generates audit trails.";
            category = "COMPLIANCE";
            practiceAreas = ["REGULATORY", "CORPORATE"];
            keyFeatures = [
                "regulation change monitoring",
                "compliance gap analysis",
                "policy document review",
                "deadline tracking",
                "audit trail generation"
            ];
            aiCapabilities = [
                "regulation parsing",
                "gap detection",
                "risk scoring",
                "policy mapping",
                "change impact analysis"
            ];
            dataPrivacy = "All queries encrypted, no data retention";
            complianceStandards = ["ABA Model Rules", "CCPA", "GDPR"];
            pricingTiers = ["TIER-DEPT", "TIER-ENTERPRISE"];
            sdkPackage = "@medina/compliance-monitor";
            apiEndpoint = "/api/v1/legal/compliance";
            frequency_Hz = PHI;
            primitiveTrace = "φ — compliance cycles follow the golden ratio of regulatory rhythm";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        {
            id = "LEG-PROD-006";
            name = "CASE STRATEGY AI";
            latinName = "STRATEGIA CAUSAE";
            latinMotto = "Strategia est ars victoriae. Machina computat viam.";
            latinMottoEN = "Strategy is the art of victory. The machine computes the way.";
            description = "Litigation strategy and outcome prediction. Models outcome probabilities, analyzes judge patterns, estimates settlement ranges, provides jury insights, and runs cost-benefit analysis.";
            category = "STRATEGY";
            practiceAreas = ["LITIGATION"];
            keyFeatures = [
                "outcome probability modeling",
                "judge analytics",
                "settlement range estimation",
                "jury selection insights",
                "cost-benefit analysis"
            ];
            aiCapabilities = [
                "predictive modeling",
                "historical outcome analysis",
                "judge pattern recognition",
                "case similarity scoring",
                "strategy optimization"
            ];
            dataPrivacy = "All queries encrypted, no data retention";
            complianceStandards = ["ABA Model Rules", "CCPA", "GDPR"];
            pricingTiers = ["TIER-FIRM", "TIER-DEPT", "TIER-ENTERPRISE"];
            sdkPackage = "@medina/case-strategy-ai";
            apiEndpoint = "/api/v1/legal/strategy";
            frequency_Hz = PHI;
            primitiveTrace = "φ — case strategy unfolds along the golden ratio of optimal decision paths";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        {
            id = "LEG-PROD-007";
            name = "DOCUMENT DISCOVERY";
            latinName = "INVENTIO DOCUMENTORUM";
            latinMotto = "In documentis veritas latet. Machina invenit.";
            latinMottoEN = "Truth hides in documents. The machine finds it.";
            description = "eDiscovery and document review automation. Classifies documents, detects privilege, scores relevance, redacts PII, and generates production sets.";
            category = "DISCOVERY";
            practiceAreas = ["LITIGATION", "REGULATORY"];
            keyFeatures = [
                "automated document classification",
                "privilege detection",
                "relevance scoring",
                "PII redaction",
                "production set generation"
            ];
            aiCapabilities = [
                "document clustering",
                "privilege classification",
                "relevance ranking",
                "near-duplicate detection",
                "concept threading"
            ];
            dataPrivacy = "All queries encrypted, no data retention";
            complianceStandards = ["ABA Model Rules", "CCPA", "GDPR"];
            pricingTiers = ["TIER-DEPT", "TIER-ENTERPRISE"];
            sdkPackage = "@medina/ediscovery-ai";
            apiEndpoint = "/api/v1/legal/discovery";
            frequency_Hz = PHI;
            primitiveTrace = "φ — document discovery spirals inward through golden ratio relevance layers";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        {
            id = "LEG-PROD-008";
            name = "CLIENT INTAKE AI";
            latinName = "RECEPTIO CLIENTIS";
            latinMotto = "Primus contactus est fundamentum. Machina recipit.";
            latinMottoEN = "First contact is the foundation. The machine receives.";
            description = "Automated client intake and conflict checking. Provides intelligent intake forms, checks conflicts of interest, automates matter opening, integrates client portals, and generates engagement letters.";
            category = "OPERATIONS";
            practiceAreas = ["CORPORATE", "REAL_ESTATE", "GENERAL"];
            keyFeatures = [
                "intelligent intake forms",
                "conflict of interest checking",
                "matter opening automation",
                "client portal integration",
                "engagement letter generation"
            ];
            aiCapabilities = [
                "entity matching",
                "conflict detection",
                "information extraction",
                "risk assessment",
                "client categorization"
            ];
            dataPrivacy = "All queries encrypted, no data retention";
            complianceStandards = ["ABA Model Rules", "CCPA", "GDPR"];
            pricingTiers = ["TIER-SOLO", "TIER-FIRM", "TIER-DEPT", "TIER-ENTERPRISE"];
            sdkPackage = "@medina/client-intake-ai";
            apiEndpoint = "/api/v1/legal/intake";
            frequency_Hz = PHI;
            primitiveTrace = "φ — client intake flows follow the golden ratio of first impressions";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        {
            id = "LEG-PROD-009";
            name = "BILLING OPTIMIZER";
            latinName = "OPTIMATOR RATIONUM";
            latinMotto = "Tempus est pecunia. Machina optimat tempus.";
            latinMottoEN = "Time is money. The machine optimizes time.";
            description = "Legal billing and time optimization. Analyzes time entries, checks billing guideline compliance, optimizes rates, generates invoice narratives, and predicts write-offs.";
            category = "OPERATIONS";
            practiceAreas = ["CORPORATE", "REAL_ESTATE", "GENERAL"];
            keyFeatures = [
                "time entry analysis",
                "billing guideline compliance",
                "rate optimization",
                "invoice narrative generation",
                "write-off prediction"
            ];
            aiCapabilities = [
                "time pattern analysis",
                "billing compliance check",
                "rate benchmarking",
                "narrative generation",
                "revenue prediction"
            ];
            dataPrivacy = "All queries encrypted, no data retention";
            complianceStandards = ["ABA Model Rules", "CCPA", "GDPR"];
            pricingTiers = ["TIER-FIRM", "TIER-DEPT", "TIER-ENTERPRISE"];
            sdkPackage = "@medina/billing-optimizer";
            apiEndpoint = "/api/v1/legal/billing";
            frequency_Hz = PHI;
            primitiveTrace = "φ — billing cycles compound along the golden ratio of time value";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        {
            id = "LEG-PROD-010";
            name = "PARALEGAL ASSISTANT";
            latinName = "ASSISTENS PARALEGALIS";
            latinMotto = "Assistens fidelis multiplicat vires. Machina assistit.";
            latinMottoEN = "A faithful assistant multiplies strength. The machine assists.";
            description = "General paralegal task automation. Prioritizes tasks, manages deadline calendars, prepares documents, automates filing checklists, and drafts communications.";
            category = "ASSISTANT";
            practiceAreas = ["GENERAL"];
            keyFeatures = [
                "task prioritization",
                "deadline calendar management",
                "document preparation",
                "filing checklist automation",
                "communication drafting"
            ];
            aiCapabilities = [
                "task classification",
                "priority scoring",
                "template completion",
                "deadline prediction",
                "workflow optimization"
            ];
            dataPrivacy = "All queries encrypted, no data retention";
            complianceStandards = ["ABA Model Rules", "CCPA", "GDPR"];
            pricingTiers = ["TIER-SOLO", "TIER-FIRM", "TIER-DEPT", "TIER-ENTERPRISE"];
            sdkPackage = "@medina/paralegal-assistant";
            apiEndpoint = "/api/v1/legal/paralegal";
            frequency_Hz = PHI;
            primitiveTrace = "φ — paralegal workflows expand in golden ratio task spirals";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        {
            id = "LEG-PROD-011";
            name = "IP PORTFOLIO AI";
            latinName = "INTELLIGENTIA PORTFOLII IP";
            latinMotto = "Ingenium protegendum est. Machina custodit.";
            latinMottoEN = "Innovation must be protected. The machine guards.";
            description = "Intellectual property portfolio management. Analyzes patent landscapes, monitors trademarks, tracks filing deadlines, detects infringement, and valuates portfolios.";
            category = "IP_MANAGEMENT";
            practiceAreas = ["IP"];
            keyFeatures = [
                "patent landscape analysis",
                "trademark monitoring",
                "filing deadline tracking",
                "infringement detection",
                "portfolio valuation"
            ];
            aiCapabilities = [
                "prior art search",
                "trademark similarity scoring",
                "claim analysis",
                "market landscape mapping",
                "renewal optimization"
            ];
            dataPrivacy = "All queries encrypted, no data retention";
            complianceStandards = ["ABA Model Rules", "CCPA", "GDPR"];
            pricingTiers = ["TIER-DEPT", "TIER-ENTERPRISE"];
            sdkPackage = "@medina/ip-portfolio-ai";
            apiEndpoint = "/api/v1/legal/ip";
            frequency_Hz = PHI;
            primitiveTrace = "φ — IP portfolios grow in golden ratio spirals of protected innovation";
            isAlwaysOn = true;
            version = "1.0.0";
        },
        {
            id = "LEG-PROD-012";
            name = "COURT FILING AI";
            latinName = "INTELLIGENTIA DEPOSITIONIS IUDICIALIS";
            latinMotto = "Iudicium requirit ordinem. Machina ordinat.";
            latinMottoEN = "The court requires order. The machine orders.";
            description = "Automated court filing preparation. Fills jurisdiction-specific forms, calculates filing fees, checks deadline compliance, integrates electronic filing, and tracks service of process.";
            category = "FILING";
            practiceAreas = ["LITIGATION", "IP", "REAL_ESTATE", "GENERAL"];
            keyFeatures = [
                "jurisdiction-specific form filling",
                "filing fee calculation",
                "deadline compliance checking",
                "electronic filing integration",
                "service of process tracking"
            ];
            aiCapabilities = [
                "form field extraction",
                "requirement validation",
                "deadline computation",
                "format compliance",
                "document assembly"
            ];
            dataPrivacy = "All queries encrypted, no data retention";
            complianceStandards = ["ABA Model Rules", "CCPA", "GDPR"];
            pricingTiers = ["TIER-FIRM", "TIER-DEPT", "TIER-ENTERPRISE"];
            sdkPackage = "@medina/court-filing-ai";
            apiEndpoint = "/api/v1/legal/filing";
            frequency_Hz = PHI;
            primitiveTrace = "φ — court filings align along the golden ratio of procedural precision";
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
        totalPracticeAreas: Nat;
        allAlwaysOn: Bool;
        doctrine: Text;
        motto: Text;
    } {
        let allOn = Array.filter<LegalAIProduct>(LEGAL_AI_PRODUCTS, func(p) { not p.isAlwaysOn }).size() == 0;
        {
            totalProducts = LEGAL_AI_PRODUCTS.size();
            totalPricingTiers = PRICING_TIERS.size();
            totalPracticeAreas = PRACTICE_AREAS.size();
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
        Array.map<LegalAIProduct, {
            id: Text; name: Text; latinName: Text;
            category: Text; description: Text; sdkPackage: Text; version: Text;
        }>(LEGAL_AI_PRODUCTS, func(p) {
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

    public func getProduct(id: Text) : ?LegalAIProduct {
        Array.find<LegalAIProduct>(LEGAL_AI_PRODUCTS, func(p) { p.id == id })
    };

    public func getProductsByCategory(category: Text) : [{
        id: Text;
        name: Text;
        latinName: Text;
        category: Text;
        description: Text;
    }] {
        let filtered = Array.filter<LegalAIProduct>(LEGAL_AI_PRODUCTS, func(p) { p.category == category });
        Array.map<LegalAIProduct, {
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

    public func getProductsByPracticeArea(area: Text) : [{
        id: Text;
        name: Text;
        latinName: Text;
        category: Text;
        description: Text;
    }] {
        let filtered = Array.filter<LegalAIProduct>(LEGAL_AI_PRODUCTS, func(p) {
            Array.find<Text>(p.practiceAreas, func(a) { a == area }) != null
        });
        Array.map<LegalAIProduct, {
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

    public func getPracticeAreas() : [PracticeArea] {
        PRACTICE_AREAS
    };

    public func renderLegalParalegalManifest() : Text {
        var m = "LEGAL PARALEGAL AI MANIFEST\n";
        m #= "══════════════════════════════════════════════════════════════\n";
        m #= "Doctrine: " # DOCTRINE.name # "\n";
        m #= "Latin: " # DOCTRINE.latinName # "\n";
        m #= "Motto: " # DOCTRINE.motto # "\n";
        m #= "       " # DOCTRINE.mottoEN # "\n";
        m #= "Principle: " # DOCTRINE.principle # "\n\n";

        m #= "PRICING TIERS (" # Nat.toText(PRICING_TIERS.size()) # "):\n";
        m #= "──────────────────────────────────────────────────────────────\n";
        for (t in PRICING_TIERS.vals()) {
            m #= "  " # t.id # "  " # t.name # "  [" # t.latinName # "]  " # t.monthlyPrice # "/mo  seats=" # Nat.toText(t.seatsIncluded) # "  target=" # t.targetFirm # "\n";
        };

        m #= "\nPRACTICE AREAS (" # Nat.toText(PRACTICE_AREAS.size()) # "):\n";
        m #= "──────────────────────────────────────────────────────────────\n";
        for (a in PRACTICE_AREAS.vals()) {
            m #= "  " # a.id # "  " # a.name # "  [" # a.latinName # "]\n";
            m #= "    " # a.description # "\n";
        };

        m #= "\n12 LEGAL AI PRODUCTS:\n";
        m #= "══════════════════════════════════════════════════════════════\n";
        for (p in LEGAL_AI_PRODUCTS.vals()) {
            m #= "  " # p.id # "  " # p.name # "  [" # p.latinName # "]\n";
            m #= "    \"" # p.latinMotto # "\"\n";
            m #= "    (" # p.latinMottoEN # ")\n";
            m #= "    Category: " # p.category # "  |  SDK: " # p.sdkPackage # "  |  API: " # p.apiEndpoint # "\n";
            m #= "    Privacy: " # p.dataPrivacy # "\n";
            m #= "    Version: " # p.version # "  |  Always-On: " # (if (p.isAlwaysOn) "YES" else "NO") # "\n";
            m #= "    Trace: " # p.primitiveTrace # "\n\n";
        };

        m #= "══════════════════════════════════════════════════════════════\n";
        m #= "L-130 COMPLIANT — Every product traces to primitive φ\n";
        m #= "Attribution: Alfredo \"Freddy\" Medina Hernandez | Medina Tech | Dallas, TX\n";
        m
    };

};
