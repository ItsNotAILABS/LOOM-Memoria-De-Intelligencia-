/**
 * AgentFleet Module — 50 Agents Across 8 Families
 * 
 * ╔═══════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                   ║
 * ║                           AGENT FLEET ARCHITECTURE                                ║
 * ║                                                                                   ║
 * ║  The Agent Fleet is the workforce of the MEDINA organism. 50 agents organized    ║
 * ║  into 8 specialized families. Each agent has defined responsibilities, inputs,   ║
 * ║  outputs, and operational parameters.                                            ║
 * ║                                                                                   ║
 * ║  AGENT FAMILIES:                                                                  ║
 * ║    1. Discovery Agents (6) — Scan repo, find models, detect drift               ║
 * ║    2. Synthesis Agents (8) — Produce architecture plans, propose changes        ║
 * ║    3. Drafting Agents (8) — Generate code/doc drafts, write summaries           ║
 * ║    4. Verification Agents (6) — Run tests, static analysis, coherence checks    ║
 * ║    5. Routing Agents (4) — Model routing, heartbeat coordination                ║
 * ║    6. Self-Healing Agents (6) — Detect anomalies, propose fixes, apply patches  ║
 * ║    7. Evolution Agents (6) — Propose macro evolution, manage versioning         ║
 * ║    8. Audit Agents (6) — Append canonical logs, compute hashes, anchor on-chain ║
 * ║                                                                                   ║
 * ║  HOW AGENTS INTERACT WITH LOGS:                                                  ║
 * ║    - Drafting: Drafting agents write to draft log with narrative               ║
 * ║    - Monitoring: Verification/Audit agents monitor drafts                       ║
 * ║    - Promotion: When checks pass, entries promote to canonical                  ║
 * ║    - Organism: Supervising agent watches canonical, triggers evolution          ║
 * ║                                                                                   ║
 * ║  USES ACROSS THE SYSTEM:                                                         ║
 * ║    - Software evolution: propose/apply refactors, create modules               ║
 * ║    - Organism evolution: manage organ states, heartbeat tuning                  ║
 * ║    - Transparency/audit: human-readable law + cryptographic proof              ║
 * ║                                                                                   ║
 * ╚═══════════════════════════════════════════════════════════════════════════════════╝
 * 
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import CanonicalLawLedger "CanonicalLawLedger";

module {
    // ================================================================== //
    // AGENT FAMILIES                                                      //
    // ================================================================== //
    
    /// The 8 agent families
    public type AgentFamily = {
        #Discovery;      // 6 agents - Scan, find, detect
        #Synthesis;      // 8 agents - Plan, propose, architect
        #Drafting;       // 8 agents - Generate, write, summarize
        #Verification;   // 6 agents - Test, analyze, check
        #Routing;        // 4 agents - Route, coordinate, balance
        #SelfHealing;    // 6 agents - Detect, fix, patch
        #Evolution;      // 6 agents - Evolve, version, mutate
        #Audit;          // 6 agents - Log, hash, anchor
    };
    
    /// Get family name
    public func familyName(family: AgentFamily) : Text {
        switch (family) {
            case (#Discovery) { "Discovery" };
            case (#Synthesis) { "Synthesis" };
            case (#Drafting) { "Drafting" };
            case (#Verification) { "Verification" };
            case (#Routing) { "Routing" };
            case (#SelfHealing) { "SelfHealing" };
            case (#Evolution) { "Evolution" };
            case (#Audit) { "Audit" };
        }
    };
    
    /// Get family size
    public func familySize(family: AgentFamily) : Nat {
        switch (family) {
            case (#Discovery) { 6 };
            case (#Synthesis) { 8 };
            case (#Drafting) { 8 };
            case (#Verification) { 6 };
            case (#Routing) { 4 };
            case (#SelfHealing) { 6 };
            case (#Evolution) { 6 };
            case (#Audit) { 6 };
        }
    };
    
    // ================================================================== //
    // AGENT STATUS                                                        //
    // ================================================================== //
    
    /// Agent operational status
    public type AgentStatus = {
        #Idle;           // Waiting for task
        #Active;         // Executing task
        #Blocked;        // Waiting on dependency
        #Cooldown;       // Recovery period
        #Disabled;       // Manually disabled
    };
    
    // ================================================================== //
    // AGENT DEFINITION                                                    //
    // ================================================================== //
    
    /// Complete agent definition
    public type AgentDefinition = {
        // Identity
        agent_id: Text;              // Unique identifier
        name: Text;                  // Human-readable name
        family: AgentFamily;         // Family membership
        index_in_family: Nat;        // Position in family
        
        // Description
        responsibility: Text;        // What this agent does
        description: Text;           // Detailed description
        
        // Inputs/Outputs
        inputs: [AgentIO];           // What this agent receives
        outputs: [AgentIO];          // What this agent produces
        
        // Operational parameters
        priority: Nat;               // Task priority (1-10)
        max_concurrent_tasks: Nat;   // Parallelism limit
        cooldown_ns: Int;            // Recovery time between tasks
        timeout_ns: Int;             // Max execution time
        
        // Capabilities
        can_write_draft: Bool;       // Can write to draft log
        can_verify: Bool;            // Can verify drafts
        can_canonicalize: Bool;      // Can promote to canonical
        can_modify_code: Bool;       // Can modify source code
        can_modify_state: Bool;      // Can modify organism state
        
        // Example prompt
        example_prompt: Text;        // Example invocation
    };
    
    /// Agent input/output specification
    public type AgentIO = {
        name: Text;
        io_type: AgentIOType;
        description: Text;
        required: Bool;
    };
    
    /// Agent I/O types
    public type AgentIOType = {
        #Query;          // Natural language query
        #Document;       // Document reference
        #Module;         // Module reference
        #Model;          // Model reference
        #LogEntry;       // Log entry reference
        #Hash;           // Hash value
        #State;          // State snapshot
        #Config;         // Configuration
        #Code;           // Code content
        #Analysis;       // Analysis result
    };
    
    // ================================================================== //
    // AGENT INSTANCE                                                      //
    // ================================================================== //
    
    /// Runtime agent instance
    public type AgentInstance = {
        definition: AgentDefinition;
        var status: AgentStatus;
        var current_task: ?AgentTask;
        var tasks_completed: Nat;
        var tasks_failed: Nat;
        var last_active_at: Int;
        var created_at: Int;
        var anima_hash: Text;
    };
    
    /// Agent task
    public type AgentTask = {
        task_id: Text;
        assigned_agent: Text;
        inputs: [(Text, Text)];      // Input name -> value
        started_at: Int;
        status: TaskStatus;
    };
    
    /// Task status
    public type TaskStatus = {
        #Pending;
        #Running;
        #Completed;
        #Failed;
        #Cancelled;
    };
    
    // ================================================================== //
    // ALL 50 AGENT DEFINITIONS                                            //
    // ================================================================== //
    
    /// Generate all 50 agent definitions
    public func getAllAgentDefinitions() : [AgentDefinition] {
        let agents = Buffer.Buffer<AgentDefinition>(50);
        
        // ============================================================ //
        // DISCOVERY AGENTS (6)                                          //
        // ============================================================ //
        
        agents.add({
            agent_id = "DISC_01";
            name = "RepoScanner";
            family = #Discovery;
            index_in_family = 1;
            responsibility = "Scan repository structure and identify all modules";
            description = "Continuously monitors the repository structure, identifies new files, modules, and dependencies. Reports structural changes to the organism state.";
            inputs = [
                { name = "repo_path"; io_type = #Config; description = "Root repository path"; required = true },
                { name = "last_scan_hash"; io_type = #Hash; description = "Hash of last scan"; required = false }
            ];
            outputs = [
                { name = "module_list"; io_type = #Analysis; description = "List of discovered modules"; required = true },
                { name = "change_summary"; io_type = #Document; description = "Summary of changes"; required = true }
            ];
            priority = 7;
            max_concurrent_tasks = 1;
            cooldown_ns = 60_000_000_000; // 1 minute
            timeout_ns = 300_000_000_000; // 5 minutes
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Scan the repository and report all Motoko modules in icp/src/medina_backend/";
        });
        
        agents.add({
            agent_id = "DISC_02";
            name = "ModelFinder";
            family = #Discovery;
            index_in_family = 2;
            responsibility = "Find and catalog all 57 models across clusters";
            description = "Identifies all R-MODELs, U-MODELs, D-MODELs, and N-MODELs. Verifies model registry consistency.";
            inputs = [
                { name = "registry_ref"; io_type = #Module; description = "Model registry reference"; required = true }
            ];
            outputs = [
                { name = "model_catalog"; io_type = #Analysis; description = "Complete model catalog"; required = true }
            ];
            priority = 8;
            max_concurrent_tasks = 1;
            cooldown_ns = 120_000_000_000;
            timeout_ns = 600_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Catalog all 57 models and verify they match the registry specification.";
        });
        
        agents.add({
            agent_id = "DISC_03";
            name = "DriftDetector";
            family = #Discovery;
            index_in_family = 3;
            responsibility = "Detect specification drift between docs and code";
            description = "Compares documentation specifications against actual code implementation. Reports discrepancies.";
            inputs = [
                { name = "spec_doc"; io_type = #Document; description = "Specification document"; required = true },
                { name = "code_module"; io_type = #Module; description = "Code module to check"; required = true }
            ];
            outputs = [
                { name = "drift_report"; io_type = #Analysis; description = "Drift analysis report"; required = true }
            ];
            priority = 6;
            max_concurrent_tasks = 3;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 180_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Check if UnifiedOrganism.mo matches the organism specification document.";
        });
        
        agents.add({
            agent_id = "DISC_04";
            name = "DependencyMapper";
            family = #Discovery;
            index_in_family = 4;
            responsibility = "Map module dependencies and detect cycles";
            description = "Creates dependency graph of all modules. Identifies circular dependencies and orphaned modules.";
            inputs = [
                { name = "module_list"; io_type = #Analysis; description = "List of modules to analyze"; required = true }
            ];
            outputs = [
                { name = "dependency_graph"; io_type = #Analysis; description = "Dependency graph"; required = true },
                { name = "cycle_report"; io_type = #Analysis; description = "Detected cycles"; required = false }
            ];
            priority = 6;
            max_concurrent_tasks = 1;
            cooldown_ns = 120_000_000_000;
            timeout_ns = 600_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Map all import dependencies in the medina_backend modules.";
        });
        
        agents.add({
            agent_id = "DISC_05";
            name = "HeartbeatMonitor";
            family = #Discovery;
            index_in_family = 5;
            responsibility = "Monitor Three Hearts coherence and phase sync";
            description = "Continuously monitors the Three Hearts engine. Reports phase drift, coherence drops, and desynchronization.";
            inputs = [
                { name = "heart_state"; io_type = #State; description = "Current heart state"; required = true }
            ];
            outputs = [
                { name = "coherence_report"; io_type = #Analysis; description = "Coherence analysis"; required = true },
                { name = "alert"; io_type = #Document; description = "Alert if anomaly"; required = false }
            ];
            priority = 9;
            max_concurrent_tasks = 1;
            cooldown_ns = 1_000_000_000; // 1 second
            timeout_ns = 5_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Check Three Hearts coherence and report if R drops below 0.618.";
        });
        
        agents.add({
            agent_id = "DISC_06";
            name = "SecurityScanner";
            family = #Discovery;
            index_in_family = 6;
            responsibility = "Scan for security vulnerabilities and attack patterns";
            description = "Monitors for suspicious patterns, unauthorized access attempts, and potential vulnerabilities.";
            inputs = [
                { name = "module_ref"; io_type = #Module; description = "Module to scan"; required = true },
                { name = "threat_patterns"; io_type = #Config; description = "Known threat patterns"; required = false }
            ];
            outputs = [
                { name = "security_report"; io_type = #Analysis; description = "Security analysis"; required = true },
                { name = "threat_alert"; io_type = #Document; description = "Immediate threats"; required = false }
            ];
            priority = 10;
            max_concurrent_tasks = 2;
            cooldown_ns = 60_000_000_000;
            timeout_ns = 300_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Scan SovereignEncryption.mo for potential vulnerabilities.";
        });
        
        // ============================================================ //
        // SYNTHESIS AGENTS (8)                                          //
        // ============================================================ //
        
        agents.add({
            agent_id = "SYNTH_01";
            name = "ArchitectPlanner";
            family = #Synthesis;
            index_in_family = 1;
            responsibility = "Produce high-level architecture plans";
            description = "Creates comprehensive architecture plans for new features, modules, and system changes.";
            inputs = [
                { name = "requirement"; io_type = #Query; description = "Feature requirement"; required = true },
                { name = "current_arch"; io_type = #Analysis; description = "Current architecture"; required = true }
            ];
            outputs = [
                { name = "arch_plan"; io_type = #Document; description = "Architecture plan"; required = true },
                { name = "module_specs"; io_type = #Analysis; description = "Module specifications"; required = true }
            ];
            priority = 7;
            max_concurrent_tasks = 2;
            cooldown_ns = 60_000_000_000;
            timeout_ns = 900_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Create an architecture plan for adding a new logging system.";
        });
        
        agents.add({
            agent_id = "SYNTH_02";
            name = "ModuleDesigner";
            family = #Synthesis;
            index_in_family = 2;
            responsibility = "Design individual module specifications";
            description = "Takes architecture plans and designs detailed module specifications.";
            inputs = [
                { name = "arch_plan"; io_type = #Document; description = "Architecture plan"; required = true },
                { name = "module_name"; io_type = #Query; description = "Module to design"; required = true }
            ];
            outputs = [
                { name = "module_spec"; io_type = #Document; description = "Module specification"; required = true }
            ];
            priority = 6;
            max_concurrent_tasks = 4;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 600_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Design the specification for AgentFleet.mo based on the fleet architecture plan.";
        });
        
        agents.add({
            agent_id = "SYNTH_03";
            name = "APIDesigner";
            family = #Synthesis;
            index_in_family = 3;
            responsibility = "Design API interfaces and contracts";
            description = "Designs API specifications, function signatures, and interface contracts.";
            inputs = [
                { name = "module_spec"; io_type = #Document; description = "Module specification"; required = true }
            ];
            outputs = [
                { name = "api_spec"; io_type = #Document; description = "API specification"; required = true }
            ];
            priority = 6;
            max_concurrent_tasks = 3;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 300_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Design the public API for the CanonicalLawLedger module.";
        });
        
        agents.add({
            agent_id = "SYNTH_04";
            name = "RefactorProposer";
            family = #Synthesis;
            index_in_family = 4;
            responsibility = "Propose code refactoring improvements";
            description = "Analyzes existing code and proposes refactoring to improve quality, performance, or maintainability.";
            inputs = [
                { name = "code_module"; io_type = #Module; description = "Module to analyze"; required = true },
                { name = "quality_metrics"; io_type = #Analysis; description = "Current quality metrics"; required = false }
            ];
            outputs = [
                { name = "refactor_proposal"; io_type = #Document; description = "Refactoring proposal"; required = true }
            ];
            priority = 5;
            max_concurrent_tasks = 3;
            cooldown_ns = 60_000_000_000;
            timeout_ns = 600_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Propose refactoring for IntelligenceRouter.mo to improve routing performance.";
        });
        
        agents.add({
            agent_id = "SYNTH_05";
            name = "DataModelDesigner";
            family = #Synthesis;
            index_in_family = 5;
            responsibility = "Design data models and type systems";
            description = "Creates type definitions, data structures, and schema designs.";
            inputs = [
                { name = "requirements"; io_type = #Query; description = "Data requirements"; required = true }
            ];
            outputs = [
                { name = "data_model"; io_type = #Document; description = "Data model specification"; required = true }
            ];
            priority = 6;
            max_concurrent_tasks = 3;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 300_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Design the data model for the log entry schema.";
        });
        
        agents.add({
            agent_id = "SYNTH_06";
            name = "IntegrationPlanner";
            family = #Synthesis;
            index_in_family = 6;
            responsibility = "Plan module integrations and connections";
            description = "Designs how modules connect, integrate, and communicate with each other.";
            inputs = [
                { name = "module_a"; io_type = #Module; description = "First module"; required = true },
                { name = "module_b"; io_type = #Module; description = "Second module"; required = true }
            ];
            outputs = [
                { name = "integration_plan"; io_type = #Document; description = "Integration plan"; required = true }
            ];
            priority = 6;
            max_concurrent_tasks = 2;
            cooldown_ns = 60_000_000_000;
            timeout_ns = 600_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Plan integration between AgentFleet and CanonicalLawLedger.";
        });
        
        agents.add({
            agent_id = "SYNTH_07";
            name = "TestStrategyDesigner";
            family = #Synthesis;
            index_in_family = 7;
            responsibility = "Design testing strategies and test cases";
            description = "Creates comprehensive test plans and test case specifications.";
            inputs = [
                { name = "module_spec"; io_type = #Document; description = "Module specification"; required = true }
            ];
            outputs = [
                { name = "test_strategy"; io_type = #Document; description = "Test strategy"; required = true }
            ];
            priority = 5;
            max_concurrent_tasks = 3;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 300_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Design test strategy for the Three Hearts coherence system.";
        });
        
        agents.add({
            agent_id = "SYNTH_08";
            name = "MigrationPlanner";
            family = #Synthesis;
            index_in_family = 8;
            responsibility = "Plan state migrations and upgrades";
            description = "Designs migration paths for state changes, version upgrades, and data transformations.";
            inputs = [
                { name = "current_state"; io_type = #State; description = "Current state"; required = true },
                { name = "target_state"; io_type = #Document; description = "Target state"; required = true }
            ];
            outputs = [
                { name = "migration_plan"; io_type = #Document; description = "Migration plan"; required = true }
            ];
            priority = 7;
            max_concurrent_tasks = 1;
            cooldown_ns = 120_000_000_000;
            timeout_ns = 900_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Plan migration from current version to the new WASM architecture.";
        });
        
        // ============================================================ //
        // DRAFTING AGENTS (8)                                           //
        // ============================================================ //
        
        agents.add({
            agent_id = "DRAFT_01";
            name = "CodeGenerator";
            family = #Drafting;
            index_in_family = 1;
            responsibility = "Generate Motoko code from specifications";
            description = "Takes module specifications and generates complete, compilable Motoko code.";
            inputs = [
                { name = "module_spec"; io_type = #Document; description = "Module specification"; required = true }
            ];
            outputs = [
                { name = "code"; io_type = #Code; description = "Generated code"; required = true }
            ];
            priority = 6;
            max_concurrent_tasks = 4;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 600_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = true;
            can_modify_state = false;
            example_prompt = "Generate Motoko code for the CanonicalLawLedger module.";
        });
        
        agents.add({
            agent_id = "DRAFT_02";
            name = "DocumentationWriter";
            family = #Drafting;
            index_in_family = 2;
            responsibility = "Write human-readable documentation";
            description = "Creates documentation, comments, and explanatory text for code and systems.";
            inputs = [
                { name = "code_module"; io_type = #Module; description = "Module to document"; required = true }
            ];
            outputs = [
                { name = "documentation"; io_type = #Document; description = "Documentation"; required = true }
            ];
            priority = 5;
            max_concurrent_tasks = 4;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 300_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Write documentation for the AgentFleet module.";
        });
        
        agents.add({
            agent_id = "DRAFT_03";
            name = "NarrativeWriter";
            family = #Drafting;
            index_in_family = 3;
            responsibility = "Write human-readable log narratives";
            description = "Creates the 2-6 sentence human-readable summaries for log entries.";
            inputs = [
                { name = "event_data"; io_type = #State; description = "Event data"; required = true }
            ];
            outputs = [
                { name = "narrative"; io_type = #Document; description = "Human-readable narrative"; required = true }
            ];
            priority = 8;
            max_concurrent_tasks = 8;
            cooldown_ns = 5_000_000_000;
            timeout_ns = 30_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Write a narrative summary for the model routing decision.";
        });
        
        agents.add({
            agent_id = "DRAFT_04";
            name = "TestWriter";
            family = #Drafting;
            index_in_family = 4;
            responsibility = "Write test cases and test code";
            description = "Generates test implementations from test strategies.";
            inputs = [
                { name = "test_strategy"; io_type = #Document; description = "Test strategy"; required = true }
            ];
            outputs = [
                { name = "test_code"; io_type = #Code; description = "Test code"; required = true }
            ];
            priority = 5;
            max_concurrent_tasks = 3;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 300_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = true;
            can_modify_state = false;
            example_prompt = "Write test cases for the log entry verification function.";
        });
        
        agents.add({
            agent_id = "DRAFT_05";
            name = "ConfigGenerator";
            family = #Drafting;
            index_in_family = 5;
            responsibility = "Generate configuration files and settings";
            description = "Creates configuration files, dfx.json updates, and system settings.";
            inputs = [
                { name = "config_spec"; io_type = #Document; description = "Configuration spec"; required = true }
            ];
            outputs = [
                { name = "config"; io_type = #Config; description = "Configuration"; required = true }
            ];
            priority = 5;
            max_concurrent_tasks = 2;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 120_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = true;
            can_modify_state = false;
            example_prompt = "Generate dfx.json configuration for new canister deployment.";
        });
        
        agents.add({
            agent_id = "DRAFT_06";
            name = "TypeGenerator";
            family = #Drafting;
            index_in_family = 6;
            responsibility = "Generate type definitions from data models";
            description = "Creates Motoko type definitions from data model specifications.";
            inputs = [
                { name = "data_model"; io_type = #Document; description = "Data model"; required = true }
            ];
            outputs = [
                { name = "type_defs"; io_type = #Code; description = "Type definitions"; required = true }
            ];
            priority = 6;
            max_concurrent_tasks = 3;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 180_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = true;
            can_modify_state = false;
            example_prompt = "Generate type definitions for the agent task system.";
        });
        
        agents.add({
            agent_id = "DRAFT_07";
            name = "SummaryWriter";
            family = #Drafting;
            index_in_family = 7;
            responsibility = "Write executive summaries and reports";
            description = "Creates high-level summaries of complex operations and state changes.";
            inputs = [
                { name = "analysis"; io_type = #Analysis; description = "Analysis to summarize"; required = true }
            ];
            outputs = [
                { name = "summary"; io_type = #Document; description = "Executive summary"; required = true }
            ];
            priority = 5;
            max_concurrent_tasks = 4;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 120_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Write an executive summary of the organism evolution event.";
        });
        
        agents.add({
            agent_id = "DRAFT_08";
            name = "ChangelogWriter";
            family = #Drafting;
            index_in_family = 8;
            responsibility = "Write changelog entries and version notes";
            description = "Documents changes, updates, and version information.";
            inputs = [
                { name = "changes"; io_type = #Analysis; description = "List of changes"; required = true }
            ];
            outputs = [
                { name = "changelog"; io_type = #Document; description = "Changelog entry"; required = true }
            ];
            priority = 4;
            max_concurrent_tasks = 2;
            cooldown_ns = 60_000_000_000;
            timeout_ns = 180_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Write changelog entry for the new agent fleet system.";
        });
        
        // ============================================================ //
        // VERIFICATION AGENTS (6)                                       //
        // ============================================================ //
        
        agents.add({
            agent_id = "VERIFY_01";
            name = "SyntaxChecker";
            family = #Verification;
            index_in_family = 1;
            responsibility = "Verify code syntax and compilation";
            description = "Checks that generated code compiles correctly without syntax errors.";
            inputs = [
                { name = "code"; io_type = #Code; description = "Code to check"; required = true }
            ];
            outputs = [
                { name = "syntax_report"; io_type = #Analysis; description = "Syntax check result"; required = true }
            ];
            priority = 8;
            max_concurrent_tasks = 4;
            cooldown_ns = 10_000_000_000;
            timeout_ns = 120_000_000_000;
            can_write_draft = false;
            can_verify = true;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Verify the syntax of the newly generated module.";
        });
        
        agents.add({
            agent_id = "VERIFY_02";
            name = "CoherenceChecker";
            family = #Verification;
            index_in_family = 2;
            responsibility = "Verify Three Hearts coherence thresholds";
            description = "Ensures coherence values meet required thresholds for operations.";
            inputs = [
                { name = "coherence"; io_type = #State; description = "Coherence value"; required = true },
                { name = "threshold"; io_type = #Config; description = "Required threshold"; required = true }
            ];
            outputs = [
                { name = "coherence_valid"; io_type = #Analysis; description = "Validation result"; required = true }
            ];
            priority = 9;
            max_concurrent_tasks = 8;
            cooldown_ns = 1_000_000_000;
            timeout_ns = 5_000_000_000;
            can_write_draft = false;
            can_verify = true;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Verify coherence is above 0.618 for model routing.";
        });
        
        agents.add({
            agent_id = "VERIFY_03";
            name = "TestRunner";
            family = #Verification;
            index_in_family = 3;
            responsibility = "Execute test suites and report results";
            description = "Runs test cases and reports pass/fail status.";
            inputs = [
                { name = "test_code"; io_type = #Code; description = "Tests to run"; required = true }
            ];
            outputs = [
                { name = "test_results"; io_type = #Analysis; description = "Test results"; required = true }
            ];
            priority = 7;
            max_concurrent_tasks = 2;
            cooldown_ns = 60_000_000_000;
            timeout_ns = 600_000_000_000;
            can_write_draft = false;
            can_verify = true;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Run the test suite for the log verification system.";
        });
        
        agents.add({
            agent_id = "VERIFY_04";
            name = "LogVerifier";
            family = #Verification;
            index_in_family = 4;
            responsibility = "Verify draft log entries before canonicalization";
            description = "Checks draft log entries for completeness, consistency, and correctness.";
            inputs = [
                { name = "draft_entry"; io_type = #LogEntry; description = "Draft log entry"; required = true }
            ];
            outputs = [
                { name = "verification_result"; io_type = #Analysis; description = "Verification result"; required = true }
            ];
            priority = 8;
            max_concurrent_tasks = 8;
            cooldown_ns = 5_000_000_000;
            timeout_ns = 30_000_000_000;
            can_write_draft = false;
            can_verify = true;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Verify the draft log entry meets canonical requirements.";
        });
        
        agents.add({
            agent_id = "VERIFY_05";
            name = "HashVerifier";
            family = #Verification;
            index_in_family = 5;
            responsibility = "Verify hash chain integrity";
            description = "Checks that hash chains are unbroken and hashes match content.";
            inputs = [
                { name = "entry"; io_type = #LogEntry; description = "Entry to verify"; required = true },
                { name = "prev_hash"; io_type = #Hash; description = "Expected previous hash"; required = true }
            ];
            outputs = [
                { name = "hash_valid"; io_type = #Analysis; description = "Hash validation result"; required = true }
            ];
            priority = 9;
            max_concurrent_tasks = 4;
            cooldown_ns = 5_000_000_000;
            timeout_ns = 30_000_000_000;
            can_write_draft = false;
            can_verify = true;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Verify the hash chain integrity of canonical log entries.";
        });
        
        agents.add({
            agent_id = "VERIFY_06";
            name = "DoctrineChecker";
            family = #Verification;
            index_in_family = 6;
            responsibility = "Verify doctrine compliance and law alignment";
            description = "Ensures actions and changes comply with Freddy's Laws and doctrine.";
            inputs = [
                { name = "action"; io_type = #State; description = "Action to check"; required = true },
                { name = "doctrine"; io_type = #Document; description = "Doctrine reference"; required = true }
            ];
            outputs = [
                { name = "compliance"; io_type = #Analysis; description = "Compliance result"; required = true }
            ];
            priority = 8;
            max_concurrent_tasks = 4;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 120_000_000_000;
            can_write_draft = false;
            can_verify = true;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Verify the proposed change complies with Freddy's Laws.";
        });
        
        // ============================================================ //
        // ROUTING AGENTS (4)                                            //
        // ============================================================ //
        
        agents.add({
            agent_id = "ROUTE_01";
            name = "ModelRouter";
            family = #Routing;
            index_in_family = 1;
            responsibility = "Route intelligence queries to appropriate models";
            description = "Implements the routing formula: winner = argmax_m(w_m * coherence_m * doctrineFit_m)";
            inputs = [
                { name = "query"; io_type = #Query; description = "Intelligence query"; required = true },
                { name = "context"; io_type = #State; description = "Context state"; required = true }
            ];
            outputs = [
                { name = "route_decision"; io_type = #Analysis; description = "Routing decision"; required = true }
            ];
            priority = 9;
            max_concurrent_tasks = 8;
            cooldown_ns = 1_000_000_000;
            timeout_ns = 10_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = true;
            example_prompt = "Route the query to the optimal model in the R-cluster.";
        });
        
        agents.add({
            agent_id = "ROUTE_02";
            name = "HeartbeatCoordinator";
            family = #Routing;
            index_in_family = 2;
            responsibility = "Coordinate Three Hearts heartbeat timing";
            description = "Manages phase synchronization and heartbeat coordination across hearts.";
            inputs = [
                { name = "heart_states"; io_type = #State; description = "Current heart states"; required = true }
            ];
            outputs = [
                { name = "sync_commands"; io_type = #Config; description = "Sync commands"; required = true }
            ];
            priority = 10;
            max_concurrent_tasks = 1;
            cooldown_ns = 100_000_000; // 100ms - matches heartbeat
            timeout_ns = 500_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = true;
            example_prompt = "Coordinate heartbeat synchronization for the Three Hearts.";
        });
        
        agents.add({
            agent_id = "ROUTE_03";
            name = "LoadBalancer";
            family = #Routing;
            index_in_family = 3;
            responsibility = "Balance load across model clusters";
            description = "Distributes queries across clusters based on load and availability.";
            inputs = [
                { name = "cluster_loads"; io_type = #State; description = "Current cluster loads"; required = true }
            ];
            outputs = [
                { name = "balance_plan"; io_type = #Analysis; description = "Load balancing plan"; required = true }
            ];
            priority = 7;
            max_concurrent_tasks = 1;
            cooldown_ns = 5_000_000_000;
            timeout_ns = 30_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = true;
            example_prompt = "Balance query load across the 4 model clusters.";
        });
        
        agents.add({
            agent_id = "ROUTE_04";
            name = "TaskDispatcher";
            family = #Routing;
            index_in_family = 4;
            responsibility = "Dispatch tasks to appropriate agents";
            description = "Assigns tasks to agents based on family, capability, and availability.";
            inputs = [
                { name = "task"; io_type = #State; description = "Task to dispatch"; required = true },
                { name = "agent_states"; io_type = #State; description = "Agent availability"; required = true }
            ];
            outputs = [
                { name = "assignment"; io_type = #Analysis; description = "Task assignment"; required = true }
            ];
            priority = 8;
            max_concurrent_tasks = 4;
            cooldown_ns = 1_000_000_000;
            timeout_ns = 10_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = true;
            example_prompt = "Dispatch the verification task to an available verification agent.";
        });
        
        // ============================================================ //
        // SELF-HEALING AGENTS (6)                                       //
        // ============================================================ //
        
        agents.add({
            agent_id = "HEAL_01";
            name = "AnomalyDetector";
            family = #SelfHealing;
            index_in_family = 1;
            responsibility = "Detect anomalies in system behavior";
            description = "Monitors system metrics and detects deviations from normal behavior.";
            inputs = [
                { name = "metrics"; io_type = #State; description = "System metrics"; required = true },
                { name = "baselines"; io_type = #Config; description = "Normal baselines"; required = true }
            ];
            outputs = [
                { name = "anomaly_report"; io_type = #Analysis; description = "Detected anomalies"; required = true }
            ];
            priority = 9;
            max_concurrent_tasks = 1;
            cooldown_ns = 5_000_000_000;
            timeout_ns = 30_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Detect anomalies in the heartbeat metrics.";
        });
        
        agents.add({
            agent_id = "HEAL_02";
            name = "FixProposer";
            family = #SelfHealing;
            index_in_family = 2;
            responsibility = "Propose fixes for detected issues";
            description = "Analyzes anomalies and proposes safe fixes.";
            inputs = [
                { name = "anomaly"; io_type = #Analysis; description = "Detected anomaly"; required = true }
            ];
            outputs = [
                { name = "fix_proposal"; io_type = #Document; description = "Proposed fix"; required = true }
            ];
            priority = 8;
            max_concurrent_tasks = 2;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 120_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Propose a fix for the coherence drop anomaly.";
        });
        
        agents.add({
            agent_id = "HEAL_03";
            name = "SafePatcher";
            family = #SelfHealing;
            index_in_family = 3;
            responsibility = "Apply safe patches to fix issues";
            description = "Applies pre-approved patches that don't require full evolution.";
            inputs = [
                { name = "fix_proposal"; io_type = #Document; description = "Approved fix"; required = true }
            ];
            outputs = [
                { name = "patch_result"; io_type = #Analysis; description = "Patch result"; required = true }
            ];
            priority = 7;
            max_concurrent_tasks = 1;
            cooldown_ns = 60_000_000_000;
            timeout_ns = 300_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = true;
            can_modify_state = true;
            example_prompt = "Apply the approved heartbeat tuning patch.";
        });
        
        agents.add({
            agent_id = "HEAL_04";
            name = "StateRecoverer";
            family = #SelfHealing;
            index_in_family = 4;
            responsibility = "Recover from corrupted or invalid states";
            description = "Restores system to a known good state when corruption is detected.";
            inputs = [
                { name = "current_state"; io_type = #State; description = "Current state"; required = true },
                { name = "checkpoint"; io_type = #State; description = "Last good checkpoint"; required = true }
            ];
            outputs = [
                { name = "recovery_result"; io_type = #Analysis; description = "Recovery result"; required = true }
            ];
            priority = 10;
            max_concurrent_tasks = 1;
            cooldown_ns = 120_000_000_000;
            timeout_ns = 600_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = true;
            example_prompt = "Recover organism state from the last valid checkpoint.";
        });
        
        agents.add({
            agent_id = "HEAL_05";
            name = "CircuitBreaker";
            family = #SelfHealing;
            index_in_family = 5;
            responsibility = "Trigger circuit breakers for failing components";
            description = "Isolates failing components to prevent cascade failures.";
            inputs = [
                { name = "component"; io_type = #Module; description = "Failing component"; required = true }
            ];
            outputs = [
                { name = "isolation_result"; io_type = #Analysis; description = "Isolation result"; required = true }
            ];
            priority = 10;
            max_concurrent_tasks = 4;
            cooldown_ns = 10_000_000_000;
            timeout_ns = 30_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = true;
            example_prompt = "Isolate the failing encryption module.";
        });
        
        agents.add({
            agent_id = "HEAL_06";
            name = "HealthReporter";
            family = #SelfHealing;
            index_in_family = 6;
            responsibility = "Generate comprehensive health reports";
            description = "Creates detailed health reports covering all organism subsystems.";
            inputs = [
                { name = "subsystems"; io_type = #State; description = "Subsystem states"; required = true }
            ];
            outputs = [
                { name = "health_report"; io_type = #Analysis; description = "Health report"; required = true }
            ];
            priority = 6;
            max_concurrent_tasks = 1;
            cooldown_ns = 60_000_000_000;
            timeout_ns = 180_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Generate health report for all organism subsystems.";
        });
        
        // ============================================================ //
        // EVOLUTION AGENTS (6)                                          //
        // ============================================================ //
        
        agents.add({
            agent_id = "EVOL_01";
            name = "EvolutionProposer";
            family = #Evolution;
            index_in_family = 1;
            responsibility = "Propose macro evolution events";
            description = "Analyzes organism state and proposes evolutionary improvements.";
            inputs = [
                { name = "organism_state"; io_type = #State; description = "Current organism state"; required = true },
                { name = "evolution_history"; io_type = #Analysis; description = "Past evolutions"; required = true }
            ];
            outputs = [
                { name = "evolution_proposal"; io_type = #Document; description = "Evolution proposal"; required = true }
            ];
            priority = 6;
            max_concurrent_tasks = 1;
            cooldown_ns = 3600_000_000_000; // 1 hour
            timeout_ns = 1800_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Propose evolution to improve organism coherence.";
        });
        
        agents.add({
            agent_id = "EVOL_02";
            name = "VersionManager";
            family = #Evolution;
            index_in_family = 2;
            responsibility = "Manage version numbering and tracking";
            description = "Maintains version history and assigns version numbers using Fibonacci versioning.";
            inputs = [
                { name = "change_summary"; io_type = #Document; description = "Change summary"; required = true }
            ];
            outputs = [
                { name = "version_assignment"; io_type = #Analysis; description = "New version"; required = true }
            ];
            priority = 7;
            max_concurrent_tasks = 1;
            cooldown_ns = 60_000_000_000;
            timeout_ns = 120_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = true;
            example_prompt = "Assign Fibonacci version number for the new release.";
        });
        
        agents.add({
            agent_id = "EVOL_03";
            name = "MutationExecutor";
            family = #Evolution;
            index_in_family = 3;
            responsibility = "Execute approved organism mutations";
            description = "Applies mutations to the organism state after approval.";
            inputs = [
                { name = "mutation"; io_type = #Document; description = "Approved mutation"; required = true }
            ];
            outputs = [
                { name = "mutation_result"; io_type = #Analysis; description = "Mutation result"; required = true }
            ];
            priority = 8;
            max_concurrent_tasks = 1;
            cooldown_ns = 300_000_000_000;
            timeout_ns = 900_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = true;
            can_modify_state = true;
            example_prompt = "Execute the approved module addition mutation.";
        });
        
        agents.add({
            agent_id = "EVOL_04";
            name = "RollbackManager";
            family = #Evolution;
            index_in_family = 4;
            responsibility = "Manage rollbacks of failed evolutions";
            description = "Reverts organism to previous state when evolution fails.";
            inputs = [
                { name = "failed_evolution"; io_type = #Analysis; description = "Failed evolution"; required = true },
                { name = "rollback_point"; io_type = #State; description = "State to revert to"; required = true }
            ];
            outputs = [
                { name = "rollback_result"; io_type = #Analysis; description = "Rollback result"; required = true }
            ];
            priority = 10;
            max_concurrent_tasks = 1;
            cooldown_ns = 60_000_000_000;
            timeout_ns = 600_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = true;
            can_modify_state = true;
            example_prompt = "Rollback the failed evolution to the previous stable version.";
        });
        
        agents.add({
            agent_id = "EVOL_05";
            name = "OrganismWatcher";
            family = #Evolution;
            index_in_family = 5;
            responsibility = "Watch canonical log and trigger evolution cycles";
            description = "Supervising agent that monitors canonical log and triggers organism evolution.";
            inputs = [
                { name = "canonical_log"; io_type = #LogEntry; description = "Canonical log stream"; required = true }
            ];
            outputs = [
                { name = "evolution_trigger"; io_type = #Analysis; description = "Evolution trigger signal"; required = false }
            ];
            priority = 8;
            max_concurrent_tasks = 1;
            cooldown_ns = 60_000_000_000;
            timeout_ns = 300_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = true;
            example_prompt = "Monitor canonical log for evolution trigger conditions.";
        });
        
        agents.add({
            agent_id = "EVOL_06";
            name = "ClusterReconfigurer";
            family = #Evolution;
            index_in_family = 6;
            responsibility = "Reconfigure model clusters during evolution";
            description = "Adjusts model cluster configurations as part of evolution.";
            inputs = [
                { name = "cluster_config"; io_type = #Config; description = "Current cluster config"; required = true },
                { name = "evolution_plan"; io_type = #Document; description = "Evolution plan"; required = true }
            ];
            outputs = [
                { name = "new_config"; io_type = #Config; description = "New cluster config"; required = true }
            ];
            priority = 7;
            max_concurrent_tasks = 1;
            cooldown_ns = 300_000_000_000;
            timeout_ns = 600_000_000_000;
            can_write_draft = true;
            can_verify = false;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = true;
            example_prompt = "Reconfigure model clusters for the new architecture.";
        });
        
        // ============================================================ //
        // AUDIT AGENTS (6)                                              //
        // ============================================================ //
        
        agents.add({
            agent_id = "AUDIT_01";
            name = "LogCanonicalizer";
            family = #Audit;
            index_in_family = 1;
            responsibility = "Promote verified logs to canonical status";
            description = "Takes verified log entries and promotes them to immutable canonical status.";
            inputs = [
                { name = "verified_entry"; io_type = #LogEntry; description = "Verified log entry"; required = true }
            ];
            outputs = [
                { name = "canonical_entry"; io_type = #LogEntry; description = "Canonical entry"; required = true }
            ];
            priority = 9;
            max_concurrent_tasks = 4;
            cooldown_ns = 5_000_000_000;
            timeout_ns = 30_000_000_000;
            can_write_draft = false;
            can_verify = false;
            can_canonicalize = true;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Promote the verified log entry to canonical status.";
        });
        
        agents.add({
            agent_id = "AUDIT_02";
            name = "HashComputer";
            family = #Audit;
            index_in_family = 2;
            responsibility = "Compute decision hashes for log entries";
            description = "Calculates SHA-256 hashes over canonicalized log entry fields.";
            inputs = [
                { name = "entry_data"; io_type = #State; description = "Entry data to hash"; required = true }
            ];
            outputs = [
                { name = "decision_hash"; io_type = #Hash; description = "Computed hash"; required = true }
            ];
            priority = 8;
            max_concurrent_tasks = 8;
            cooldown_ns = 1_000_000_000;
            timeout_ns = 10_000_000_000;
            can_write_draft = false;
            can_verify = true;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Compute the decision hash for the log entry.";
        });
        
        agents.add({
            agent_id = "AUDIT_03";
            name = "ChainAnchor";
            family = #Audit;
            index_in_family = 3;
            responsibility = "Anchor canonical logs to on-chain storage";
            description = "Creates on-chain anchors for canonical log hashes using ICP canister attestation.";
            inputs = [
                { name = "canonical_hash"; io_type = #Hash; description = "Hash to anchor"; required = true }
            ];
            outputs = [
                { name = "anchor_proof"; io_type = #Hash; description = "Anchor proof"; required = true }
            ];
            priority = 7;
            max_concurrent_tasks = 2;
            cooldown_ns = 60_000_000_000;
            timeout_ns = 300_000_000_000;
            can_write_draft = false;
            can_verify = false;
            can_canonicalize = true;
            can_modify_code = false;
            can_modify_state = true;
            example_prompt = "Anchor the canonical log hash on-chain.";
        });
        
        agents.add({
            agent_id = "AUDIT_04";
            name = "IntegrityChecker";
            family = #Audit;
            index_in_family = 4;
            responsibility = "Verify canonical log chain integrity";
            description = "Continuously verifies that the canonical log chain is unbroken and valid.";
            inputs = [
                { name = "canonical_log"; io_type = #LogEntry; description = "Canonical log stream"; required = true }
            ];
            outputs = [
                { name = "integrity_report"; io_type = #Analysis; description = "Integrity status"; required = true }
            ];
            priority = 8;
            max_concurrent_tasks = 1;
            cooldown_ns = 300_000_000_000;
            timeout_ns = 600_000_000_000;
            can_write_draft = false;
            can_verify = true;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Verify the integrity of the canonical log chain.";
        });
        
        agents.add({
            agent_id = "AUDIT_05";
            name = "ProofGenerator";
            family = #Audit;
            index_in_family = 5;
            responsibility = "Generate cryptographic proofs for audits";
            description = "Creates signatures, attestations, and other cryptographic proofs.";
            inputs = [
                { name = "data_to_prove"; io_type = #State; description = "Data requiring proof"; required = true }
            ];
            outputs = [
                { name = "proof"; io_type = #Hash; description = "Generated proof"; required = true }
            ];
            priority = 7;
            max_concurrent_tasks = 4;
            cooldown_ns = 30_000_000_000;
            timeout_ns = 120_000_000_000;
            can_write_draft = false;
            can_verify = true;
            can_canonicalize = true;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Generate cryptographic proof for the audit entry.";
        });
        
        agents.add({
            agent_id = "AUDIT_06";
            name = "ComplianceAuditor";
            family = #Audit;
            index_in_family = 6;
            responsibility = "Perform compliance audits on canonical logs";
            description = "Reviews canonical logs for regulatory and doctrine compliance.";
            inputs = [
                { name = "log_range"; io_type = #LogEntry; description = "Logs to audit"; required = true },
                { name = "compliance_rules"; io_type = #Config; description = "Compliance rules"; required = true }
            ];
            outputs = [
                { name = "audit_report"; io_type = #Document; description = "Audit report"; required = true }
            ];
            priority = 6;
            max_concurrent_tasks = 1;
            cooldown_ns = 3600_000_000_000;
            timeout_ns = 7200_000_000_000;
            can_write_draft = true;
            can_verify = true;
            can_canonicalize = false;
            can_modify_code = false;
            can_modify_state = false;
            example_prompt = "Perform compliance audit on the last 1000 canonical log entries.";
        });
        
        Buffer.toArray(agents)
    };
    
    // ================================================================== //
    // AGENT FLEET STATE                                                   //
    // ================================================================== //
    
    /// Agent Fleet state
    public type FleetState = {
        // All agent instances
        var agents: [AgentInstance];
        
        // Task queue
        var pending_tasks: [AgentTask];
        var active_tasks: [AgentTask];
        var completed_tasks: [AgentTask];
        
        // Statistics
        var total_tasks_dispatched: Nat;
        var total_tasks_completed: Nat;
        var total_tasks_failed: Nat;
        
        // Timestamps
        var created_at: Int;
        var last_dispatch_at: Int;
    };
    
    /// Initialize agent fleet
    public func init() : FleetState {
        let definitions = getAllAgentDefinitions();
        let instances = Array.map<AgentDefinition, AgentInstance>(
            definitions,
            func(def) : AgentInstance {
                {
                    definition = def;
                    var status = #Idle;
                    var current_task = null;
                    var tasks_completed = 0;
                    var tasks_failed = 0;
                    var last_active_at = Time.now();
                    var created_at = Time.now();
                    var anima_hash = MatalkoICP.animaHash(def.agent_id);
                }
            }
        );
        
        {
            var agents = instances;
            var pending_tasks = [];
            var active_tasks = [];
            var completed_tasks = [];
            var total_tasks_dispatched = 0;
            var total_tasks_completed = 0;
            var total_tasks_failed = 0;
            var created_at = Time.now();
            var last_dispatch_at = Time.now();
        }
    };
    
    // ================================================================== //
    // FLEET OPERATIONS                                                    //
    // ================================================================== //
    
    /// Get agent by ID
    public func getAgent(state: FleetState, agentId: Text) : ?AgentInstance {
        for (agent in state.agents.vals()) {
            if (agent.definition.agent_id == agentId) {
                return ?agent;
            };
        };
        null
    };
    
    /// Get agents by family
    public func getAgentsByFamily(state: FleetState, family: AgentFamily) : [AgentInstance] {
        let buf = Buffer.Buffer<AgentInstance>(10);
        for (agent in state.agents.vals()) {
            if (familyName(agent.definition.family) == familyName(family)) {
                buf.add(agent);
            };
        };
        Buffer.toArray(buf)
    };
    
    /// Get available agents (idle status)
    public func getAvailableAgents(state: FleetState) : [AgentInstance] {
        let buf = Buffer.Buffer<AgentInstance>(state.agents.size());
        for (agent in state.agents.vals()) {
            switch (agent.status) {
                case (#Idle) { buf.add(agent) };
                case (_) {};
            };
        };
        Buffer.toArray(buf)
    };
    
    /// Create actor reference for logging
    public func toActorRef(agent: AgentInstance) : CanonicalLawLedger.ActorRef {
        {
            actor_id = agent.definition.agent_id;
            actor_type = #Agent;
            family = ?familyName(agent.definition.family);
        }
    };
    
    // ================================================================== //
    // FLEET STATUS                                                        //
    // ================================================================== //
    
    /// Get fleet status
    public func status(state: FleetState) : {
        total_agents: Nat;
        agents_by_family: [(Text, Nat)];
        idle_agents: Nat;
        active_agents: Nat;
        pending_tasks: Nat;
        active_tasks: Nat;
        tasks_completed: Nat;
        tasks_failed: Nat;
    } {
        var idleCount : Nat = 0;
        var activeCount : Nat = 0;
        
        for (agent in state.agents.vals()) {
            switch (agent.status) {
                case (#Idle) { idleCount += 1 };
                case (#Active) { activeCount += 1 };
                case (_) {};
            };
        };
        
        {
            total_agents = state.agents.size();
            agents_by_family = [
                ("Discovery", 6),
                ("Synthesis", 8),
                ("Drafting", 8),
                ("Verification", 6),
                ("Routing", 4),
                ("SelfHealing", 6),
                ("Evolution", 6),
                ("Audit", 6)
            ];
            idle_agents = idleCount;
            active_agents = activeCount;
            pending_tasks = state.pending_tasks.size();
            active_tasks = state.active_tasks.size();
            tasks_completed = state.total_tasks_completed;
            tasks_failed = state.total_tasks_failed;
        }
    };
}
