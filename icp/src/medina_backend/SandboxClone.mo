/**
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                         SANDBOX CLONE SYSTEM                              ║
 * ║                                                                           ║
 * ║  "Umbra est, non corpus. Corpus occultum est."                           ║
 * ║  (It is a shadow, not the body. The body is hidden.)                     ║
 * ║                                                                           ║
 * ║  EVERY USER INTERACTION IS WITH A SANDBOX, NEVER THE CORE ORGANISM       ║
 * ║                                                                           ║
 * ║  Architecture:                                                            ║
 * ║  ┌─────────────────────────────────────────────────────────────────────┐ ║
 * ║  │                     CORE ORGANISM (NEVER EXPOSED)                   │ ║
 * ║  │  ┌───────────────────────────────────────────────────────────────┐ │ ║
 * ║  │  │  Full Intelligence │ All Models │ All Encryption │ All Laws  │ │ ║
 * ║  │  └───────────────────────────────────────────────────────────────┘ │ ║
 * ║  │                              │                                      │ ║
 * ║  │                     ┌────────┴────────┐                            │ ║
 * ║  │                     │  SANDBOX FACTORY │                           │ ║
 * ║  │                     └────────┬────────┘                            │ ║
 * ║  │                              │                                      │ ║
 * ║  │  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐          │ ║
 * ║  │  │Clone 1 │ │Clone 2 │ │Clone 3 │ │Clone 4 │ │Clone N │          │ ║
 * ║  │  │(User A)│ │(User B)│ │(User C)│ │(User D)│ │(User N)│          │ ║
 * ║  │  └────────┘ └────────┘ └────────┘ └────────┘ └────────┘          │ ║
 * ║  └─────────────────────────────────────────────────────────────────────┘ ║
 * ║                                                                           ║
 * ║  SANDBOX PROPERTIES:                                                      ║
 * ║  • Complete isolation from core organism                                  ║
 * ║  • Full SaaS functionality within bounded scope                          ║
 * ║  • No access to settings, code, docs, architecture                       ║
 * ║  • Controlled by internal maintenance organisms                          ║
 * ║  • Golden ratio scaling (can serve 1 or 1,000,000 users)                 ║
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
import SemperMemoria "SemperMemoria";

module {
    // ================================================================== //
    // SANDBOX CONSTANTS                                                    //
    // ================================================================== //
    
    /// Latin doctrine
    public let SHADOW_DOCTRINE : Text = "Umbra est, non corpus. Corpus occultum est.";
    
    /// English doctrine
    public let SHADOW_DOCTRINE_EN : Text = "It is a shadow, not the body. The body is hidden.";
    
    /// Golden ratio for scaling
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Maximum concurrent sandboxes per organism instance
    public let MAX_CONCURRENT : Nat = 144; // Fibonacci number
    
    // ================================================================== //
    // SANDBOX CLONE TYPES                                                  //
    // ================================================================== //
    
    /// Sandbox clone - isolated user environment
    public type SandboxClone = {
        // Identity
        clone_id: Text;
        parent_organism_hash: Text;  // Hash of core organism (never revealed)
        
        // Configuration
        config: SemperMemoria.SandboxConfig;
        
        // Boundaries
        boundaries: SandboxBoundaries;
        
        // Runtime state
        state: SandboxRuntimeState;
        
        // Maintenance
        maintenance: MaintenanceState;
    };
    
    /// Sandbox boundaries - what the clone can access
    public type SandboxBoundaries = {
        // API boundaries
        allowed_endpoints: [Text];
        blocked_endpoints: [Text];  // Includes all internal endpoints
        
        // UI boundaries
        allowed_components: [Text];
        blocked_components: [Text]; // Includes settings, docs, code views
        
        // Data boundaries
        can_read_own_data: Bool;     // Yes
        can_write_own_data: Bool;    // Yes
        can_read_other_data: Bool;   // No
        can_read_core_data: Bool;    // NEVER
        
        // Feature boundaries
        features_enabled: [Text];
        features_disabled: [Text];
        
        // Resource limits
        max_storage_bytes: Nat;
        max_compute_cycles: Nat;
        max_bandwidth_bytes: Nat;
    };
    
    /// Runtime state of sandbox
    public type SandboxRuntimeState = {
        // Activity
        created_at: Int;
        last_active: Int;
        total_requests: Nat;
        
        // Health
        health: Float;           // 0-1 sandbox health
        coherence: Float;        // 0-1 coherence with parent
        
        // Resources used
        storage_used: Nat;
        compute_used: Nat;
        bandwidth_used: Nat;
        
        // Feedback
        feedback_submitted: Nat;
        rewards_earned: Nat;
    };
    
    /// Maintenance state - internal organism maintenance
    public type MaintenanceState = {
        // Maintenance organism assigned
        maintainer_id: Text;
        
        // Last maintenance
        last_check: Int;
        last_update: Int;
        
        // Status
        needs_update: Bool;
        pending_patches: Nat;
        
        // Lab assignments
        assigned_lab: Text;       // Which internal lab maintains this
        lab_priority: Nat;        // Priority in maintenance queue
    };
    
    // ================================================================== //
    // SANDBOX FACTORY                                                      //
    // ================================================================== //
    
    /// Sandbox factory - creates isolated clones
    public type SandboxFactory = {
        factory_id: Text;
        organism_hash: Text;         // Hash of parent organism (secret)
        
        // Production stats
        clones_created: Nat;
        clones_active: Nat;
        clones_terminated: Nat;
        
        // Capacity
        max_capacity: Nat;
        current_load: Float;
        
        // Labs
        maintenance_labs: [MaintenanceLab];
    };
    
    /// Internal maintenance lab
    public type MaintenanceLab = {
        lab_id: Text;
        name: Text;
        
        // Responsibilities
        sandboxes_assigned: Nat;
        models_available: Nat;
        
        // Status
        active: Bool;
        workload: Float;
        
        // Feedback processing
        feedback_queue: Nat;
        feedback_processed_today: Nat;
    };
    
    // ================================================================== //
    // SANDBOX CREATION                                                     //
    // ================================================================== //
    
    /// Create a new sandbox clone
    public func createSandboxClone(
        product: SemperMemoria.SaaSProduct,
        access_level: SemperMemoria.AccessLevel,
        user_hash: Text,
        organism_hash: Text,
        gate_version: Nat
    ) : SandboxClone {
        let config = SemperMemoria.createSandboxConfig(
            product, access_level, user_hash, gate_version
        );
        
        let clone_id = "CLONE-" # config.sandbox_id;
        
        {
            clone_id = clone_id;
            parent_organism_hash = hashForClone(organism_hash);
            config = config;
            boundaries = createDefaultBoundaries(product, access_level);
            state = initRuntimeState();
            maintenance = initMaintenanceState(product);
        }
    };
    
    /// Hash organism reference for clone (additional obfuscation)
    func hashForClone(organism_hash: Text) : Text {
        // Double-hash to further obscure origin
        let base = MatalkoICP.animaHash(
            organism_hash,
            Time.now(),
            0  // genesis link
        );
        MatalkoICP.animaHash(base, Time.now(), 1)
    };
    
    /// Create default boundaries for product
    func createDefaultBoundaries(
        product: SemperMemoria.SaaSProduct,
        access_level: SemperMemoria.AccessLevel
    ) : SandboxBoundaries {
        // Get allowed endpoints for this product
        let product_endpoints = getProductEndpoints(product);
        
        // Always blocked (internal) endpoints
        let blocked = [
            "/internal/*",
            "/core/*",
            "/organism/*",
            "/settings/*",
            "/config/*",
            "/admin/*",
            "/debug/*",
            "/source/*",
            "/models/internal/*",
            "/encryption/*",
            "/doctrine/*",
            "/law/*"
        ];
        
        // Get allowed UI components
        let product_components = getProductComponents(product);
        
        // Always blocked components
        let blocked_components = [
            "settings-panel",
            "config-editor",
            "source-viewer",
            "debug-console",
            "admin-dashboard",
            "internal-docs",
            "architecture-view",
            "model-inspector",
            "encryption-settings"
        ];
        
        // Resource limits based on access level
        let (storage, compute, bandwidth) = switch (access_level) {
            case (#Trial) { (1_000_000, 100_000, 10_000_000) };        // 1MB, 100K cycles, 10MB
            case (#Standard) { (100_000_000, 10_000_000, 1_000_000_000) }; // 100MB, 10M cycles, 1GB
            case (#Enterprise) { (10_000_000_000, 1_000_000_000, 100_000_000_000) }; // 10GB, 1B cycles, 100GB
            case (#Sovereign) { (1_000_000_000_000, 100_000_000_000, 10_000_000_000_000) }; // 1TB, 100B cycles, 10TB
        };
        
        {
            allowed_endpoints = product_endpoints;
            blocked_endpoints = blocked;
            allowed_components = product_components;
            blocked_components = blocked_components;
            
            can_read_own_data = true;
            can_write_own_data = true;
            can_read_other_data = false;
            can_read_core_data = false;  // NEVER
            
            features_enabled = getEnabledFeatures(product, access_level);
            features_disabled = getDisabledFeatures(access_level);
            
            max_storage_bytes = storage;
            max_compute_cycles = compute;
            max_bandwidth_bytes = bandwidth;
        }
    };
    
    /// Get product-specific endpoints
    func getProductEndpoints(product: SemperMemoria.SaaSProduct) : [Text] {
        switch (product) {
            case (#MemoriaPerpetua) {
                ["/api/v1/memory/*", "/api/v1/search/*", "/api/v1/navigate/*"]
            };
            case (#Cognitio) {
                ["/api/v1/intelligence/*", "/api/v1/route/*", "/api/v1/query/*"]
            };
            case (#Custodia) {
                ["/api/v1/governance/*", "/api/v1/audit/*", "/api/v1/compliance/*"]
            };
            case (#DocumentumVivum) {
                ["/api/v1/document/*", "/api/v1/chain/*", "/api/v1/verify/*"]
            };
            case (#TresCorda) {
                ["/api/v1/hearts/*", "/api/v1/routing/*", "/api/v1/orchestrate/*"]
            };
            case (#CatenaAnima) {
                ["/api/v1/anima/*", "/api/v1/lineage/*", "/api/v1/verify/*"]
            };
            case (#Templum) {
                ["/api/v1/temple/*", "/api/v1/spatial/*", "/api/v1/3d/*"]
            };
            case (#Socius) {
                ["/api/v1/agents/*", "/api/v1/fleet/*", "/api/v1/task/*"]
            };
            case (#Praesidium) {
                ["/api/v1/defense/*", "/api/v1/protect/*", "/api/v1/scan/*"]
            };
            case (#Infinitas) {
                ["/api/v1/scale/*", "/api/v1/balance/*", "/api/v1/allocate/*"]
            };
        }
    };
    
    /// Get product-specific UI components
    func getProductComponents(product: SemperMemoria.SaaSProduct) : [Text] {
        let base = ["sidebar", "feedback-box", "workspace", "header"];
        
        let specific = switch (product) {
            case (#MemoriaPerpetua) { ["memory-grid", "search-bar", "timeline", "navigator"] };
            case (#Cognitio) { ["query-input", "routing-display", "result-panel"] };
            case (#Custodia) { ["audit-log", "approval-queue", "compliance-status"] };
            case (#DocumentumVivum) { ["document-editor", "chain-view", "version-tree"] };
            case (#TresCorda) { ["heart-display", "routing-viz", "query-composer"] };
            case (#CatenaAnima) { ["chain-explorer", "lineage-tree", "verification-badge"] };
            case (#Templum) { ["3d-viewport", "spatial-grid", "memory-nodes"] };
            case (#Socius) { ["fleet-map", "agent-cards", "task-board"] };
            case (#Praesidium) { ["threat-monitor", "gate-display", "defense-log"] };
            case (#Infinitas) { ["scale-graph", "load-meter", "resource-allocation"] };
        };
        
        Array.append(base, specific)
    };
    
    /// Get enabled features for access level
    func getEnabledFeatures(
        product: SemperMemoria.SaaSProduct,
        access_level: SemperMemoria.AccessLevel
    ) : [Text] {
        let base = ["basic-operations", "feedback", "help"];
        
        let level_features = switch (access_level) {
            case (#Trial) { ["limited-storage", "basic-api"] };
            case (#Standard) { ["full-api", "standard-storage", "priority-support"] };
            case (#Enterprise) { ["unlimited-api", "unlimited-storage", "dedicated-support", "custom-integration"] };
            case (#Sovereign) { ["self-hosted", "full-control", "source-deployment", "custom-organism"] };
        };
        
        Array.append(base, level_features)
    };
    
    /// Get disabled features (always hidden)
    func getDisabledFeatures(access_level: SemperMemoria.AccessLevel) : [Text] {
        // These are ALWAYS disabled regardless of access level
        [
            "view-source-code",
            "access-settings",
            "view-architecture",
            "inspect-models",
            "view-encryption",
            "access-doctrine",
            "view-internal-docs",
            "debug-mode",
            "admin-access"
        ]
    };
    
    /// Initialize runtime state
    func initRuntimeState() : SandboxRuntimeState {
        {
            created_at = Time.now();
            last_active = Time.now();
            total_requests = 0;
            health = 1.0;
            coherence = 1.0;
            storage_used = 0;
            compute_used = 0;
            bandwidth_used = 0;
            feedback_submitted = 0;
            rewards_earned = 0;
        }
    };
    
    /// Initialize maintenance state
    func initMaintenanceState(product: SemperMemoria.SaaSProduct) : MaintenanceState {
        let lab = assignLab(product);
        
        {
            maintainer_id = "MAINT-" # SemperMemoria.productCode(product) # "-PRIMARY";
            last_check = Time.now();
            last_update = Time.now();
            needs_update = false;
            pending_patches = 0;
            assigned_lab = lab;
            lab_priority = 1;
        }
    };
    
    /// Assign maintenance lab based on product
    func assignLab(product: SemperMemoria.SaaSProduct) : Text {
        switch (product) {
            case (#MemoriaPerpetua) { "LAB-MEMORIA" };
            case (#Cognitio) { "LAB-INTELLIGENTIA" };
            case (#Custodia) { "LAB-GOVERNANCE" };
            case (#DocumentumVivum) { "LAB-DOCUMENTUM" };
            case (#TresCorda) { "LAB-CORDA" };
            case (#CatenaAnima) { "LAB-CATENA" };
            case (#Templum) { "LAB-TEMPLUM" };
            case (#Socius) { "LAB-SOCIUS" };
            case (#Praesidium) { "LAB-PRAESIDIUM" };
            case (#Infinitas) { "LAB-INFINITAS" };
        }
    };
    
    // ================================================================== //
    // SANDBOX OPERATIONS                                                   //
    // ================================================================== //
    
    /// Process request through sandbox (with boundary enforcement)
    public func processRequest(
        clone: SandboxClone,
        endpoint: Text,
        payload: Text
    ) : {#Ok: Text; #Blocked: Text; #Error: Text} {
        // Check if endpoint is blocked
        for (blocked in clone.boundaries.blocked_endpoints.vals()) {
            if (matchesPattern(endpoint, blocked)) {
                // Return mirage response
                return #Blocked(SemperMemoria.mirageResponse());
            };
        };
        
        // Check if endpoint is allowed
        var allowed = false;
        for (allow in clone.boundaries.allowed_endpoints.vals()) {
            if (matchesPattern(endpoint, allow)) {
                allowed := true;
            };
        };
        
        if (not allowed) {
            return #Blocked(SemperMemoria.mirageResponse());
        };
        
        // Process through sandbox (isolated)
        #Ok("{\"status\":\"processed\",\"sandbox\":\"" # clone.clone_id # "\"}")
    };
    
    /// Check if path matches pattern (supports wildcards)
    func matchesPattern(path: Text, pattern: Text) : Bool {
        // Simple wildcard matching
        if (Text.endsWith(pattern, #text("/*"))) {
            let prefix = Text.trimEnd(pattern, #text("/*"));
            return Text.startsWith(path, #text(prefix));
        };
        path == pattern
    };
    
    /// Check if component is allowed
    public func isComponentAllowed(clone: SandboxClone, component: Text) : Bool {
        // Check blocked first
        for (blocked in clone.boundaries.blocked_components.vals()) {
            if (component == blocked) {
                return false;
            };
        };
        
        // Check allowed
        for (allowed in clone.boundaries.allowed_components.vals()) {
            if (component == allowed) {
                return true;
            };
        };
        
        false
    };
    
    // ================================================================== //
    // MAINTENANCE OPERATIONS                                               //
    // ================================================================== //
    
    /// Check if sandbox needs maintenance
    public func needsMaintenance(clone: SandboxClone) : Bool {
        let now = Time.now();
        let maintenance_interval : Int = 3600_000_000_000; // 1 hour in nanoseconds
        
        (now - clone.maintenance.last_check) > maintenance_interval or
        clone.maintenance.needs_update or
        clone.maintenance.pending_patches > 0 or
        clone.state.health < 0.9 or
        clone.state.coherence < 0.95
    };
    
    /// Update sandbox from parent organism (controlled update)
    public func syncWithParent(
        clone: SandboxClone,
        new_gate_version: Nat
    ) : SandboxClone {
        // Only update if new version is higher
        if (new_gate_version <= clone.config.gate_version) {
            return clone;
        };
        
        // Create updated config
        let new_config = {
            clone.config with
            gate_version = new_gate_version
        };
        
        // Create updated maintenance state
        let new_maintenance = {
            clone.maintenance with
            last_update = Time.now();
            needs_update = false;
            pending_patches = 0;
        };
        
        {
            clone with
            config = new_config;
            maintenance = new_maintenance;
        }
    };
}
