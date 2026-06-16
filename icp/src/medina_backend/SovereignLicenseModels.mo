/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║         SOVEREIGN LICENSE MODELS — MODELLI LICENTIAE SOVEREIGNAE            ║
 * ║                                                                              ║
 * ║  "Lex est fundamentum. Licentia est scutum. Protectio est absoluta."        ║
 * ║  (Law is the foundation. License is the shield. Protection is absolute.)    ║
 * ║                                                                              ║
 * ║  ISIL-1.0 — ItsNotAILABS Sovereign Intelligence License                     ║
 * ║  Completely original. Zero borrowed text. Nine articles.                     ║
 * ║  Four variants. Three classification tiers.                                  ║
 * ║                                                                              ║
 * ║  9 ARTICLES:                                                                 ║
 * ║    I.   Declaration of Sovereign Origin                                      ║
 * ║    II.  Sovereign Reservation of All Rights                                  ║
 * ║    III. Eight Absolute Prohibitions                                          ║
 * ║    IV.  Trade Secret Declaration (DTSA + Texas UTSA)                         ║
 * ║    V.   Sovereign Intelligent Contract Binding                               ║
 * ║    VI.  Patent Rights Assertion                                              ║
 * ║    VII. Full Enforcement Suite                                               ║
 * ║    VIII.Severability (Maximum Protection)                                    ║
 * ║    IX.  Authorized Use Addendum (per-package)                                ║
 * ║                                                                              ║
 * ║  4 VARIANTS:                                                                 ║
 * ║    ROOT          — all non-MIT works                                         ║
 * ║    SOVEREIGN-ALPHA — highest confidentiality (medina-memory-sdk)              ║
 * ║    SOVEREIGN-BETA  — internal confidential (ai-tools-marketplace)             ║
 * ║    SOVEREIGN-GAMMA — commercial per-call (agent-incentive-service)            ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every license article traces to primitive φ               ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module SovereignLicenseModels {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;
    public let LICENSE_VERSION : Text = "ISIL-1.0";
    public let LICENSE_NAME : Text = "ItsNotAILABS Sovereign Intelligence License";

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 1: TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type LicenseArticle = {
        number: Nat;
        romanNumeral: Text;
        title: Text;
        latinName: Text;
        summary: Text;
        prohibitions: [Text];
        statutes: [Text];
        primitiveTrace: Text;
    };

    public type LicenseVariant = {
        id: Text;
        name: Text;
        classification: Text;
        clearanceLevel: Text;
        scope: Text;
        commercialModel: Text;
        conversionDate: Text;
        packageTarget: Text;
        primitiveTrace: Text;
    };

    public type Prohibition = {
        id: Text;
        name: Text;
        latinName: Text;
        description: Text;
        isAbsolute: Bool;
    };

    public type EnforcementMechanism = {
        id: Text;
        name: Text;
        latinName: Text;
        statute: Text;
        maxDamages: Text;
        criminal: Bool;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 2: 9 LICENSE ARTICLES
    // ═══════════════════════════════════════════════════════════════════════

    public let ARTICLE_I : LicenseArticle = {
        number = 1;
        romanNumeral = "I";
        title = "Declaration of Sovereign Origin";
        latinName = "DECLARATIO ORIGINIS SOVEREIGNAE";
        summary = "This license is entirely original. No framework, template, or existing license text was used. Zero borrowed text. Sovereign creation.";
        prohibitions = [];
        statutes = [];
        primitiveTrace = "DECLARATIO -> Field -> φ";
    };

    public let ARTICLE_II : LicenseArticle = {
        number = 2;
        romanNumeral = "II";
        title = "Sovereign Reservation of All Rights";
        latinName = "RESERVATIO IURIUM SOVEREIGNORUM";
        summary = "All rights reserved. Publication does not grant rights. Accessibility does not imply license. Course of dealing creates no entitlement.";
        prohibitions = [];
        statutes = [];
        primitiveTrace = "RESERVATIO -> Distinction -> φ";
    };

    public let ARTICLE_III : LicenseArticle = {
        number = 3;
        romanNumeral = "III";
        title = "Eight Absolute Prohibitions";
        latinName = "OCTO PROHIBITIONES ABSOLUTAE";
        summary = "Eight absolute prohibitions that apply regardless of method, intent, jurisdiction, or purpose.";
        prohibitions = [
            "Reproduction — no copying, cloning, forking, downloading",
            "Distribution — no sharing, transmitting, publishing, mirroring",
            "Modification — no altering, adapting, translating, derivative works",
            "Reverse Engineering — no decompiling, disassembling, analyzing",
            "Commercial Use — no selling, licensing, leasing, service offering",
            "AI Training — absolute ban regardless of method or intent",
            "Pattern Extraction — no extracting, abstracting, summarizing patterns",
            "Automated Access — no bots, crawlers, scrapers, automated tools"
        ];
        statutes = [];
        primitiveTrace = "PROHIBITIONES -> Relation -> φ";
    };

    public let ARTICLE_IV : LicenseArticle = {
        number = 4;
        romanNumeral = "IV";
        title = "Trade Secret Declaration";
        latinName = "DECLARATIO SECRETI COMMERCIALIS";
        summary = "All source code, algorithms, formulas, and architectural patterns constitute trade secrets under DTSA and Texas UTSA.";
        prohibitions = [];
        statutes = [
            "Defend Trade Secrets Act (DTSA) — 18 U.S.C. §§ 1831-1839",
            "Texas Uniform Trade Secrets Act (TUTSA) — Tex. Civ. Prac. & Rem. Code §§ 134A.001-134A.008"
        ];
        primitiveTrace = "SECRETUM -> Memory -> φ";
    };

    public let ARTICLE_V : LicenseArticle = {
        number = 5;
        romanNumeral = "V";
        title = "Sovereign Intelligent Contract Binding";
        latinName = "CONTRACTUS INTELLIGENS SOVEREIGNUS";
        summary = "Self-executing, self-enforcing. Binds on first access. References sovereign contract technology (SovereignContracts.mo).";
        prohibitions = [];
        statutes = [];
        primitiveTrace = "CONTRACTUS -> Address -> φ";
    };

    public let ARTICLE_VI : LicenseArticle = {
        number = 6;
        romanNumeral = "VI";
        title = "Patent Rights Assertion";
        latinName = "ASSERTIO IURIUM PATENTIUM";
        summary = "Patent rights asserted over all novel methods, processes, systems, and architectures. Phi-traced computation, Three Hearts routing, frequency-layered computation, AnimaChain encryption.";
        prohibitions = [];
        statutes = [];
        primitiveTrace = "ASSERTIO -> Repetition -> φ";
    };

    public let ARTICLE_VII : LicenseArticle = {
        number = 7;
        romanNumeral = "VII";
        title = "Full Enforcement Suite";
        latinName = "EXECUTIO PLENA";
        summary = "Injunctive relief without bond. DTSA exemplary damages (2×). Criminal referral under 18 U.S.C. § 1832. Attorney fees. Cumulative remedies. Dallas County, Texas jurisdiction.";
        prohibitions = [];
        statutes = [
            "18 U.S.C. § 1832 — Theft of Trade Secrets (criminal, up to 10 years, $5M fine)",
            "18 U.S.C. § 1836(b)(3)(C) — DTSA exemplary damages (2× actual damages)",
            "Texas UTSA — injunctive relief and damages"
        ];
        primitiveTrace = "EXECUTIO -> Logic -> φ";
    };

    public let ARTICLE_VIII : LicenseArticle = {
        number = 8;
        romanNumeral = "VIII";
        title = "Severability";
        latinName = "SEPARABILITAS MAXIMA";
        summary = "Maximum protection construction. Invalid provisions reformed to preserve maximum Author protection. Construed in favor of Author's rights.";
        prohibitions = [];
        statutes = [];
        primitiveTrace = "SEPARABILITAS -> Equation -> φ";
    };

    public let ARTICLE_IX : LicenseArticle = {
        number = 9;
        romanNumeral = "IX";
        title = "Authorized Use Addendum";
        latinName = "ADDENDUM USUS AUCTORIZATI";
        summary = "Customized per package. Each package has its own Article IX variant specifying authorized parties, scope, duration, fees, and termination conditions.";
        prohibitions = [];
        statutes = [];
        primitiveTrace = "ADDENDUM -> Model -> φ";
    };

    public let ALL_ARTICLES : [LicenseArticle] = [
        ARTICLE_I, ARTICLE_II, ARTICLE_III, ARTICLE_IV, ARTICLE_V,
        ARTICLE_VI, ARTICLE_VII, ARTICLE_VIII, ARTICLE_IX
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 3: 4 LICENSE VARIANTS
    // ═══════════════════════════════════════════════════════════════════════

    public let VARIANT_ROOT : LicenseVariant = {
        id = "ISIL-ROOT";
        name = "Root License";
        classification = "UNIVERSAL";
        clearanceLevel = "ALL";
        scope = "All non-MIT works in the repository";
        commercialModel = "No commercial use permitted";
        conversionDate = "N/A";
        packageTarget = "LICENSE (root)";
        primitiveTrace = "ROOT -> Field -> φ";
    };

    public let VARIANT_ALPHA : LicenseVariant = {
        id = "ISIL-ALPHA";
        name = "Sovereign Alpha — Highest Confidentiality";
        classification = "SOVEREIGN-ALPHA";
        clearanceLevel = "ALPHA — Internal + Enterprise Only";
        scope = "medina-memory-sdk: Memory Temple, lineage, rings, AnimaChain persistence";
        commercialModel = "Enterprise license only (MELA required)";
        conversionDate = "N/A";
        packageTarget = "packages/medina-memory-sdk/LICENSE";
        primitiveTrace = "ALPHA -> Memory -> φ";
    };

    public let VARIANT_BETA : LicenseVariant = {
        id = "ISIL-BETA";
        name = "Sovereign Beta — Internal Confidential";
        classification = "SOVEREIGN-BETA";
        clearanceLevel = "BETA — Internal Development Only";
        scope = "ai-tools-marketplace: Tool discovery, extensions, worker bundles";
        commercialModel = "Internal development license (MIDA required)";
        conversionDate = "N/A";
        packageTarget = "packages/ai-tools-marketplace/LICENSE";
        primitiveTrace = "BETA -> Relation -> φ";
    };

    public let VARIANT_GAMMA : LicenseVariant = {
        id = "ISIL-GAMMA";
        name = "Sovereign Gamma — Commercial Per-Call";
        classification = "SOVEREIGN-GAMMA";
        clearanceLevel = "GAMMA — Commercial Per-Call Access";
        scope = "agent-incentive-service: Agent rewards, performance metrics, incentive pools";
        commercialModel = "Per-call metered (MASA required). Converts to enterprise January 1, 2029";
        conversionDate = "2029-01-01";
        packageTarget = "packages/agent-incentive-service/LICENSE";
        primitiveTrace = "GAMMA -> Number -> φ";
    };

    public let VARIANT_DELTA : LicenseVariant = {
        id = "ISIL-DELTA";
        name = "Sovereign Delta — Council Organism License";
        classification = "SOVEREIGN-DELTA";
        clearanceLevel = "DELTA — Council-Level Organism Access";
        scope = "Council SDK organisms: LUMEN, ARCHON, FORGE, VECTOR council SDK packages";
        commercialModel = "Council-governed access (MECA required). Council vote to grant.";
        conversionDate = "N/A";
        packageTarget = "packages/council-sdk-organisms/*";
        primitiveTrace = "DELTA -> Logic -> φ";
    };

    public let VARIANT_EPSILON : LicenseVariant = {
        id = "ISIL-EPSILON";
        name = "Sovereign Epsilon — Ecosystem SDK License";
        classification = "SOVEREIGN-EPSILON";
        clearanceLevel = "EPSILON — Ecosystem-Level SDK Access";
        scope = "Ecosystem SDK organisms: NOVA, ORO, AURA, MERIDIAN ecosystem SDK packages";
        commercialModel = "Domain-governed access (MEDA required). Universe domain authority.";
        conversionDate = "N/A";
        packageTarget = "packages/ecosystem-sdk-organisms/*";
        primitiveTrace = "EPSILON -> Equation -> φ";
    };

    public let VARIANT_ZETA : LicenseVariant = {
        id = "ISIL-ZETA";
        name = "Sovereign Zeta — Node Creative License";
        classification = "SOVEREIGN-ZETA";
        clearanceLevel = "ZETA — Adopted Node Creative Authority";
        scope = "Adopted agent nodes with creative license contracts — vault-locked, 1M token binding";
        commercialModel = "Creative authority grant (Freddy approval). Eternal contract.";
        conversionDate = "ETERNAL";
        packageTarget = "SovereignCreativeLicense.mo";
        primitiveTrace = "ZETA -> Language -> φ";
    };

    public let VARIANT_ETA : LicenseVariant = {
        id = "ISIL-ETA";
        name = "Sovereign Eta — Universe Domain License";
        classification = "SOVEREIGN-ETA";
        clearanceLevel = "ETA — Universe Domain Sovereign Authority";
        scope = "Universe domains: NOVA, ORO, AURA, MERIDIAN, GENESIS, PRAXIS, SYNTHEX";
        commercialModel = "Domain sovereignty (non-transferable). Substrate-level authority.";
        conversionDate = "N/A";
        packageTarget = "UniverseDomains.mo";
        primitiveTrace = "ETA -> Model -> φ";
    };

    public let VARIANT_THETA : LicenseVariant = {
        id = "ISIL-THETA";
        name = "Sovereign Theta — Substrate Node License";
        classification = "SOVEREIGN-THETA";
        clearanceLevel = "THETA — Substrate Node Operating License";
        scope = "All 25 substrate nodes (10 substrate + 8 eco-grid + 7 runtime) with embedded AIs";
        commercialModel = "Node operating authority (organism-bound). Always-on, always-absorbing.";
        conversionDate = "N/A";
        packageTarget = "SubstrateNodes.mo";
        primitiveTrace = "THETA -> Address -> φ";
    };

    public let ALL_VARIANTS : [LicenseVariant] = [
        VARIANT_ROOT, VARIANT_ALPHA, VARIANT_BETA, VARIANT_GAMMA,
        VARIANT_DELTA, VARIANT_EPSILON, VARIANT_ZETA, VARIANT_ETA, VARIANT_THETA
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 4: 8 ABSOLUTE PROHIBITIONS
    // ═══════════════════════════════════════════════════════════════════════

    public let ALL_PROHIBITIONS : [Prohibition] = [
        { id = "PROHIB-001"; name = "Reproduction"; latinName = "REPRODUCTIO VETITA";
          description = "No copying, cloning, forking, downloading, caching, screenshotting, photographing, transcribing, or reproducing";
          isAbsolute = true },
        { id = "PROHIB-002"; name = "Distribution"; latinName = "DISTRIBUTIO VETITA";
          description = "No distributing, sharing, transmitting, publishing, mirroring, hosting, serving, relaying";
          isAbsolute = true },
        { id = "PROHIB-003"; name = "Modification"; latinName = "MODIFICATIO VETITA";
          description = "No modifying, altering, adapting, translating, annotating, extending, refactoring, rewriting, or derivative works";
          isAbsolute = true },
        { id = "PROHIB-004"; name = "Reverse Engineering"; latinName = "RETROINGENIATIO VETITA";
          description = "No reverse engineering, decompiling, disassembling, analyzing, inspecting, probing, tracing, debugging";
          isAbsolute = true },
        { id = "PROHIB-005"; name = "Commercial Use"; latinName = "USUS COMMERCIALIS VETITUS";
          description = "No selling, licensing, leasing, offering as service, incorporating into products, deriving revenue";
          isAbsolute = true },
        { id = "PROHIB-006"; name = "AI Training"; latinName = "EXERCITATIO IA VETITA";
          description = "Absolute ban regardless of method or intent. No training data, fine-tuning, evaluation, benchmark, RAG source, prompt context";
          isAbsolute = true },
        { id = "PROHIB-007"; name = "Pattern Extraction"; latinName = "EXTRACTIO EXEMPLARIUM VETITA";
          description = "No extracting, abstracting, summarizing, cataloguing, indexing patterns, architectures, design principles";
          isAbsolute = true },
        { id = "PROHIB-008"; name = "Automated Access"; latinName = "ACCESSUS AUTOMATICUS VETITUS";
          description = "No bots, crawlers, spiders, scrapers, agents, automated tools, CI/CD pipelines (other than Author's)";
          isAbsolute = true }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 5: ENFORCEMENT MECHANISMS
    // ═══════════════════════════════════════════════════════════════════════

    public let ENFORCEMENT_MECHANISMS : [EnforcementMechanism] = [
        { id = "ENF-001"; name = "Injunctive Relief Without Bond";
          latinName = "INTERDICTUM SINE CAUTIONE";
          statute = "Federal and Texas state courts";
          maxDamages = "Immediate TRO and preliminary injunction";
          criminal = false },
        { id = "ENF-002"; name = "DTSA Exemplary Damages";
          latinName = "DAMNA EXEMPLARIA DTSA";
          statute = "18 U.S.C. § 1836(b)(3)(C)";
          maxDamages = "2× actual damages for willful misappropriation";
          criminal = false },
        { id = "ENF-003"; name = "Criminal Referral — Trade Secret Theft";
          latinName = "RELATIO CRIMINALIS";
          statute = "18 U.S.C. § 1832";
          maxDamages = "10 years imprisonment, $5,000,000 fine";
          criminal = true },
        { id = "ENF-004"; name = "Attorney Fees Recovery";
          latinName = "RECUPERATIO HONORARIORUM";
          statute = "Prevailing party provision";
          maxDamages = "Full reasonable attorney fees, costs, expenses";
          criminal = false },
        { id = "ENF-005"; name = "Dallas County Jurisdiction";
          latinName = "IURISDICTIO DALLASIANA";
          statute = "Texas state and federal courts, Dallas County";
          maxDamages = "Exclusive venue";
          criminal = false }
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // SECTION 6: QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func getArticle(romanNumeral: Text) : ?LicenseArticle {
        Array.find<LicenseArticle>(ALL_ARTICLES, func(a) { a.romanNumeral == romanNumeral })
    };

    public func getVariant(id: Text) : ?LicenseVariant {
        Array.find<LicenseVariant>(ALL_VARIANTS, func(v) { v.id == id })
    };

    public func getProhibition(id: Text) : ?Prohibition {
        Array.find<Prohibition>(ALL_PROHIBITIONS, func(p) { p.id == id })
    };

    public func summary() : {
        licenseVersion: Text; licenseName: Text;
        totalArticles: Nat; totalVariants: Nat;
        totalProhibitions: Nat; totalEnforcements: Nat;
    } {
        {
            licenseVersion = LICENSE_VERSION;
            licenseName = LICENSE_NAME;
            totalArticles = ALL_ARTICLES.size();
            totalVariants = ALL_VARIANTS.size();
            totalProhibitions = ALL_PROHIBITIONS.size();
            totalEnforcements = ENFORCEMENT_MECHANISMS.size();
        }
    };

    public func renderLicenseManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════╗\n";
        m #= "║  ISIL-1.0 — ItsNotAILABS Sovereign Intelligence License  ║\n";
        m #= "║  Lex est fundamentum. Licentia est scutum.                ║\n";
        m #= "╚══════════════════════════════════════════════════════════╝\n\n";

        m #= "9 ARTICLES:\n";
        for (article in ALL_ARTICLES.vals()) {
            m #= "  Art. " # article.romanNumeral # " — " # article.title # "\n";
            m #= "    [" # article.latinName # "]\n";
        };

        m #= "\n4 VARIANTS:\n";
        for (variant in ALL_VARIANTS.vals()) {
            m #= "  " # variant.id # " — " # variant.classification # "\n";
            m #= "    Target: " # variant.packageTarget # "\n";
        };

        m #= "\n8 ABSOLUTE PROHIBITIONS:\n";
        for (p in ALL_PROHIBITIONS.vals()) {
            m #= "  " # p.id # " — " # p.name # " [" # p.latinName # "]\n";
        };

        m #= "\n5 ENFORCEMENT MECHANISMS:\n";
        for (e in ENFORCEMENT_MECHANISMS.vals()) {
            m #= "  " # e.id # " — " # e.name # "\n";
            m #= "    Statute: " # e.statute # "\n";
        };

        m #= "\nROOT: φ = (1+√5)/2 = 1.618033988749895\n";
        m
    };
}
