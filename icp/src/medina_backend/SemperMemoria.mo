/**
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                         SEMPER MEMORIA                                    ║
 * ║                    "Memoria Aeterna — Semper Vivens"                     ║
 * ║                   (Eternal Memory — Always Living)                        ║
 * ║                                                                           ║
 * ║  MAXIMUM SECRECY RELEASE INFRASTRUCTURE                                   ║
 * ║                                                                           ║
 * ║  "Quod vides non est. Quod non vides est."                               ║
 * ║  (What you see is not. What you don't see, is.)                          ║
 * ║                                                                           ║
 * ║  ARCHITECTURE:                                                            ║
 * ║  ┌────────────────────────────────────────────────────────────────────┐  ║
 * ║  │                      CORE ORGANISM (HIDDEN)                        │  ║
 * ║  │  ┌──────────────────────────────────────────────────────────────┐ │  ║
 * ║  │  │  UnifiedOrganism │ ThreeHearts │ 57 Models │ ANIMA Chain     │ │  ║
 * ║  │  │  SovereignOrg    │ MemoryTemple │ Encryption │ Ledgers       │ │  ║
 * ║  │  └──────────────────────────────────────────────────────────────┘ │  ║
 * ║  │                              ↓                                     │  ║
 * ║  │                    RELEASE GATE SYSTEM                             │  ║
 * ║  │                              ↓                                     │  ║
 * ║  │  ┌──────────────────────────────────────────────────────────────┐ │  ║
 * ║  │  │              SANDBOX CLONES (USER-FACING)                    │ │  ║
 * ║  │  │  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐    │ │  ║
 * ║  │  │  │ SaaS 1 │ │ SaaS 2 │ │ SaaS 3 │ │ SaaS 4 │ │ SaaS N │    │ │  ║
 * ║  │  │  └────────┘ └────────┘ └────────┘ └────────┘ └────────┘    │ │  ║
 * ║  │  └──────────────────────────────────────────────────────────────┘ │  ║
 * ║  └────────────────────────────────────────────────────────────────────┘  ║
 * ║                                                                           ║
 * ║  USERS SEE: Sandbox → Mirage → No access to Core                         ║
 * ║  USERS GET: Full SaaS functionality within bounded sandbox               ║
 * ║  USERS NEVER: See code, settings, READMEs, internal docs                 ║
 * ║                                                                           ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez                          ║
 * ║  PROPRIETARY AND CONFIDENTIAL - MAXIMUM SECRECY                          ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Hash "mo:base/Hash";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import UnifiedOrganism "UnifiedOrganism";
import ThreeHeartsEncryption "ThreeHeartsEncryption";
import SovereignDefenseSystem "SovereignDefenseSystem";

module {
    // ================================================================== //
    // SEMPER MEMORIA CONSTANTS                                            //
    // ================================================================== //
    
    /// Company name in Latin
    public let COMPANY_NAME : Text = "Semper Memoria";
    
    /// Company motto - Latin
    public let MOTTO_LATIN : Text = "Memoria Aeterna — Semper Vivens";
    
    /// Company motto - English
    public let MOTTO_ENGLISH : Text = "Eternal Memory — Always Living";
    
    /// Company motto - Spanish
    public let MOTTO_SPANISH : Text = "Memoria Eterna — Siempre Viva";
    
    /// Secrecy principle
    public let SECRECY_DOCTRINE : Text = "Quod vides non est. Quod non vides est.";
    
    /// Golden ratio - scaling constant
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Maximum sandbox instances (Fibonacci)
    public let MAX_SANDBOXES : Nat = 144;
    
    /// Release version
    public let VERSION : Text = "1.0.0-semper";
    
    // ================================================================== //
    // RELEASE TYPES                                                        //
    // ================================================================== //
    
    /// SaaS Product identifier
    public type SaaSProduct = {
        #MemoriaPerpetua;    // Enterprise memory management
        #Cognitio;           // Intelligence routing as a service
        #Custodia;           // Governance and compliance automation
        #DocumentumVivum;    // Living document platform
        #TresCorda;          // Three Hearts intelligence API
        #CatenaAnima;        // ANIMA chain verification service
        #Templum;            // Memory Temple workspace
        #Socius;             // Agent fleet management
        #Praesidium;         // Sovereign defense service
        #Infinitas;          // Infinite scaling infrastructure
    };
    
    /// Sandbox access level
    public type AccessLevel = {
        #Trial;              // Limited trial access
        #Standard;           // Standard SaaS access
        #Enterprise;         // Full enterprise access
        #Sovereign;          // Self-hosted sovereign access
    };
    
    /// User visibility scope - what they can see
    public type VisibilityScope = {
        sidebar: Bool;           // Can see sidebar
        feedback_box: Bool;      // Can see feedback box
        landing_page: Bool;      // Can access landing page
        blog_link: Bool;         // Can access blog link (to landing only)
        
        // ALWAYS FALSE for public users
        settings: Bool;          // NO - hidden
        readmes: Bool;           // NO - hidden
        source_code: Bool;       // NO - hidden
        internal_docs: Bool;     // NO - hidden
        architecture: Bool;      // NO - hidden
        models: Bool;            // NO - hidden
        encryption: Bool;        // NO - hidden
    };
    
    /// Sandbox configuration
    public type SandboxConfig = {
        sandbox_id: Text;
        product: SaaSProduct;
        access_level: AccessLevel;
        visibility: VisibilityScope;
        created_at: Int;
        expires_at: ?Int;
        user_hash: Text;         // Anonymized user identifier
        gate_version: Nat;       // Which organism version gates are set to
    };
    
    /// Sandbox state
    public type SandboxState = {
        config: SandboxConfig;
        active: Bool;
        last_activity: Int;
        interaction_count: Nat;
        feedback_count: Nat;
        rewards_earned: Nat;     // Crypto rewards
    };
    
    // ================================================================== //
    // RELEASE GATE SYSTEM                                                  //
    // ================================================================== //
    
    /// Release gate - controls what version users see
    public type ReleaseGate = {
        gate_id: Text;
        product: SaaSProduct;
        version: Text;
        organism_version: Nat;   // Which organism version this maps to
        
        // Gate boundaries
        features_enabled: [Text];
        features_disabled: [Text];
        
        // Opacity settings
        code_visible: Bool;      // Always false
        docs_visible: Bool;      // Always false
        settings_visible: Bool;  // Always false
        
        // What users CAN access
        api_endpoints: [Text];
        ui_components: [Text];
        
        deployed_at: Int;
        status: GateStatus;
    };
    
    /// Gate status
    public type GateStatus = {
        #Draft;
        #Deployed;
        #Active;
        #Deprecated;
        #Sealed;
    };
    
    // ================================================================== //
    // FEEDBACK SYSTEM                                                      //
    // ================================================================== //
    
    /// Feedback entry
    public type Feedback = {
        feedback_id: Text;
        sandbox_id: Text;
        user_hash: Text;
        content: Text;
        category: FeedbackCategory;
        timestamp: Int;
        
        // Internal processing (never shown to user)
        grade: ?FeedbackGrade;
        processed: Bool;
        action_taken: ?Text;
        reward_issued: Bool;
        reward_amount: Nat;
    };
    
    /// Feedback category
    public type FeedbackCategory = {
        #Bug;
        #Feature;
        #Improvement;
        #Praise;
        #Question;
        #Other;
    };
    
    /// Internal feedback grade
    public type FeedbackGrade = {
        quality: Float;          // 0-1 quality score
        actionability: Float;    // 0-1 how actionable
        novelty: Float;          // 0-1 is this new insight
        urgency: Float;          // 0-1 how urgent
        overall: Float;          // Weighted average
        
        // Actions
        organism_update: Bool;   // Should update organism?
        new_model_research: Bool;// Should research new models?
        notify_founder: Bool;    // Should notify founder?
        branch_for_research: ?Text; // Research branch if any
    };
    
    // ================================================================== //
    // CORE FUNCTIONS                                                       //
    // ================================================================== //
    
    /// Create default public visibility - HIDES EVERYTHING INTERNAL
    public func defaultPublicVisibility() : VisibilityScope {
        {
            // What users CAN see
            sidebar = true;
            feedback_box = true;
            landing_page = true;
            blog_link = true;
            
            // What users CANNOT see - EVER
            settings = false;
            readmes = false;
            source_code = false;
            internal_docs = false;
            architecture = false;
            models = false;
            encryption = false;
        }
    };
    
    /// Create sandbox configuration
    public func createSandboxConfig(
        product: SaaSProduct,
        access_level: AccessLevel,
        user_hash: Text,
        gate_version: Nat
    ) : SandboxConfig {
        let sandbox_id = generateSandboxId(product, user_hash);
        
        {
            sandbox_id = sandbox_id;
            product = product;
            access_level = access_level;
            visibility = defaultPublicVisibility();
            created_at = Time.now();
            expires_at = calculateExpiry(access_level);
            user_hash = user_hash;
            gate_version = gate_version;
        }
    };
    
    /// Generate sandbox ID (anonymized)
    func generateSandboxId(product: SaaSProduct, user_hash: Text) : Text {
        let product_code = productCode(product);
        let timestamp = Int.toText(Time.now());
        let hash_suffix = Text.fromIter(
            Text.toIter(user_hash).take(8)
        );
        "SB-" # product_code # "-" # timestamp # "-" # hash_suffix
    };
    
    /// Get product code
    public func productCode(product: SaaSProduct) : Text {
        switch (product) {
            case (#MemoriaPerpetua) { "MPE" };
            case (#Cognitio) { "COG" };
            case (#Custodia) { "CUS" };
            case (#DocumentumVivum) { "DOC" };
            case (#TresCorda) { "TRC" };
            case (#CatenaAnima) { "CAN" };
            case (#Templum) { "TEM" };
            case (#Socius) { "SOC" };
            case (#Praesidium) { "PRA" };
            case (#Infinitas) { "INF" };
        }
    };
    
    /// Get product name in Latin
    public func productNameLatin(product: SaaSProduct) : Text {
        switch (product) {
            case (#MemoriaPerpetua) { "Memoria Perpetua" };
            case (#Cognitio) { "Cognitio" };
            case (#Custodia) { "Custodia" };
            case (#DocumentumVivum) { "Documentum Vivum" };
            case (#TresCorda) { "Tres Corda" };
            case (#CatenaAnima) { "Catena Anima" };
            case (#Templum) { "Templum" };
            case (#Socius) { "Socius" };
            case (#Praesidium) { "Praesidium" };
            case (#Infinitas) { "Infinitas" };
        }
    };
    
    /// Get product description in English
    public func productDescription(product: SaaSProduct) : Text {
        switch (product) {
            case (#MemoriaPerpetua) { 
                "Enterprise memory management. Perfect recall. Infinite retention. " #
                "Your organization's knowledge, navigable forever."
            };
            case (#Cognitio) { 
                "Intelligence routing as a service. 57 specialized models, " #
                "automatically orchestrated. Your queries find the right mind."
            };
            case (#Custodia) { 
                "Governance and compliance automation. Constitutional by design. " #
                "Every action traced, every decision auditable."
            };
            case (#DocumentumVivum) { 
                "Living document platform. Documents that update themselves, " #
                "chain together, verify their own compliance."
            };
            case (#TresCorda) { 
                "Three Hearts intelligence API. Metropolis computes. Coupling selects. " #
                "Regulating orchestrates. Unified intelligence access."
            };
            case (#CatenaAnima) { 
                "ANIMA chain verification service. Unbroken lineage proof. " #
                "Fibonacci-depth identity chains. Truth that traces to origin."
            };
            case (#Templum) { 
                "Memory Temple workspace. 3D navigable knowledge geometry. " #
                "Your data in sacred architecture, not flat files."
            };
            case (#Socius) { 
                "Agent fleet management. Autonomous workforce orchestration. " #
                "Intelligent agents that maintain themselves."
            };
            case (#Praesidium) { 
                "Sovereign defense service. Gate-controlled projection. " #
                "Non-Zeno observation response. Impenetrable by design."
            };
            case (#Infinitas) { 
                "Infinite scaling infrastructure. Golden ratio load balancing. " #
                "Fibonacci resource allocation. Scale without limits."
            };
        }
    };
    
    /// Calculate expiry based on access level
    func calculateExpiry(level: AccessLevel) : ?Int {
        let now = Time.now();
        let day_ns : Int = 86_400_000_000_000;
        
        switch (level) {
            case (#Trial) { ?(now + 14 * day_ns) };     // 14 days
            case (#Standard) { ?(now + 365 * day_ns) }; // 1 year
            case (#Enterprise) { null };                 // No expiry
            case (#Sovereign) { null };                  // No expiry
        }
    };
    
    // ================================================================== //
    // FEEDBACK PROCESSING                                                  //
    // ================================================================== //
    
    /// Grade feedback internally
    public func gradeFeedback(feedback: Feedback) : FeedbackGrade {
        // This would be processed by internal lab models
        // Here we show the structure
        
        let base_quality = 0.5; // Default mid-quality
        let base_actionability = 0.5;
        let base_novelty = 0.5;
        let base_urgency = 0.5;
        
        // Calculate overall using golden ratio weighting
        let overall = (
            base_quality * PHI +
            base_actionability * 1.0 +
            base_novelty * (PHI - 1.0) +
            base_urgency * (1.0 / PHI)
        ) / (PHI + 1.0 + (PHI - 1.0) + (1.0 / PHI));
        
        {
            quality = base_quality;
            actionability = base_actionability;
            novelty = base_novelty;
            urgency = base_urgency;
            overall = overall;
            
            // Decision thresholds
            organism_update = overall >= 0.7;
            new_model_research = base_novelty >= 0.8;
            notify_founder = overall >= 0.9 or base_urgency >= 0.95;
            branch_for_research = if (base_novelty >= 0.8) {
                ?("research/feedback-" # feedback.feedback_id)
            } else { null };
        }
    };
    
    /// Calculate crypto reward for feedback
    public func calculateReward(grade: FeedbackGrade) : Nat {
        // Base reward in smallest units
        let base_reward : Nat = 100;
        
        // Multiply by overall quality
        let quality_multiplier = Float.toInt(grade.overall * 10.0);
        let novelty_bonus = if (grade.novelty >= 0.8) { 50 } else { 0 };
        
        let total = base_reward + Int.abs(quality_multiplier) + novelty_bonus;
        total
    };
    
    // ================================================================== //
    // RELEASE GATE MANAGEMENT                                              //
    // ================================================================== //
    
    /// Create release gate for a product
    public func createReleaseGate(
        product: SaaSProduct,
        version: Text,
        organism_version: Nat,
        features: [Text]
    ) : ReleaseGate {
        let gate_id = "GATE-" # productCode(product) # "-" # version;
        
        {
            gate_id = gate_id;
            product = product;
            version = version;
            organism_version = organism_version;
            
            features_enabled = features;
            features_disabled = [];
            
            // ALWAYS OPAQUE
            code_visible = false;
            docs_visible = false;
            settings_visible = false;
            
            // API and UI components determined by product
            api_endpoints = getProductEndpoints(product);
            ui_components = getProductUIComponents(product);
            
            deployed_at = Time.now();
            status = #Draft;
        }
    };
    
    /// Get API endpoints for product (sandbox-safe)
    func getProductEndpoints(product: SaaSProduct) : [Text] {
        switch (product) {
            case (#MemoriaPerpetua) {
                ["/api/memory/store", "/api/memory/retrieve", "/api/memory/search", "/api/memory/navigate"]
            };
            case (#Cognitio) {
                ["/api/intelligence/route", "/api/intelligence/query", "/api/intelligence/analyze"]
            };
            case (#Custodia) {
                ["/api/governance/check", "/api/governance/approve", "/api/governance/audit"]
            };
            case (#DocumentumVivum) {
                ["/api/document/create", "/api/document/update", "/api/document/chain", "/api/document/verify"]
            };
            case (#TresCorda) {
                ["/api/hearts/query", "/api/hearts/route", "/api/hearts/status"]
            };
            case (#CatenaAnima) {
                ["/api/anima/verify", "/api/anima/chain", "/api/anima/trace"]
            };
            case (#Templum) {
                ["/api/temple/navigate", "/api/temple/store", "/api/temple/visualize"]
            };
            case (#Socius) {
                ["/api/agents/deploy", "/api/agents/status", "/api/agents/task"]
            };
            case (#Praesidium) {
                ["/api/defense/scan", "/api/defense/protect", "/api/defense/audit"]
            };
            case (#Infinitas) {
                ["/api/scale/allocate", "/api/scale/balance", "/api/scale/status"]
            };
        }
    };
    
    /// Get UI components for product
    func getProductUIComponents(product: SaaSProduct) : [Text] {
        // All products get these base components
        let base = ["sidebar", "feedback-box", "main-workspace"];
        
        // Product-specific components
        let specific = switch (product) {
            case (#MemoriaPerpetua) { ["memory-grid", "search-panel", "timeline-view"] };
            case (#Cognitio) { ["query-interface", "routing-viz", "model-status"] };
            case (#Custodia) { ["audit-trail", "approval-queue", "compliance-dash"] };
            case (#DocumentumVivum) { ["doc-editor", "chain-view", "version-history"] };
            case (#TresCorda) { ["heart-monitor", "query-composer", "routing-map"] };
            case (#CatenaAnima) { ["chain-explorer", "verification-panel", "lineage-tree"] };
            case (#Templum) { ["3d-navigator", "memory-grid", "spatial-search"] };
            case (#Socius) { ["fleet-dashboard", "agent-cards", "task-queue"] };
            case (#Praesidium) { ["security-monitor", "gate-status", "threat-log"] };
            case (#Infinitas) { ["scale-metrics", "resource-viz", "load-balancer"] };
        };
        
        Array.append(base, specific)
    };
    
    // ================================================================== //
    // OPACITY ENFORCEMENT                                                  //
    // ================================================================== //
    
    /// Check if request attempts to access hidden resources
    public func isHiddenResourceRequest(path: Text) : Bool {
        // Paths that are ALWAYS hidden
        let hidden_patterns = [
            "/settings",
            "/config",
            "/readme",
            "/docs/internal",
            "/source",
            "/code",
            "/architecture",
            "/models/internal",
            "/encryption",
            "/.git",
            "/doctrine",
            "/law",
            "/freddy",
            "/matalko",
            "/organism/internal"
        ];
        
        for (pattern in hidden_patterns.vals()) {
            if (Text.contains(path, #text(pattern))) {
                return true;
            };
        };
        
        false
    };
    
    /// Generate mirage response for hidden resource
    public func mirageResponse() : Text {
        // Return meaningless but syntactically valid response
        // "What you see is not. What you don't see, is."
        "{\"status\":\"ok\",\"message\":\"" # SECRECY_DOCTRINE # "\"}"
    };
    
    // ================================================================== //
    // CRYPTO REWARD TOKEN                                                  //
    // ================================================================== //
    
    /// Reward token name
    public let REWARD_TOKEN_NAME : Text = "Memoria Token";
    
    /// Reward token symbol
    public let REWARD_TOKEN_SYMBOL : Text = "MEMO";
    
    /// Reward token decimals
    public let REWARD_TOKEN_DECIMALS : Nat = 8;
    
    // ================================================================== //
    // VERSION MANIFEST                                                     //
    // ================================================================== //
    
    /// Get the release manifest
    public func getReleaseManifest() : Text {
        let manifest = "{\n" #
            "  \"company\": \"" # COMPANY_NAME # "\",\n" #
            "  \"version\": \"" # VERSION # "\",\n" #
            "  \"motto\": {\n" #
            "    \"latin\": \"" # MOTTO_LATIN # "\",\n" #
            "    \"english\": \"" # MOTTO_ENGLISH # "\",\n" #
            "    \"spanish\": \"" # MOTTO_SPANISH # "\"\n" #
            "  },\n" #
            "  \"products\": 10,\n" #
            "  \"architecture\": \"Sovereign Memory-Operating Intelligence\",\n" #
            "  \"scaling\": \"Fibonacci/Golden Ratio\",\n" #
            "  \"secrecy\": \"Maximum\"\n" #
            "}";
        manifest
    };
}
