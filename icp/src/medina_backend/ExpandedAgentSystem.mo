/**
 * ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                                           ║
 * ║                                    EXPANDED AGENT SYSTEM                                                   ║
 * ║                         600+ AI AGENTS ACROSS ALL TIERS                                                    ║
 * ║                                                                                                           ║
 * ║                        "Agentes Infiniti — Intelligentia Ubique"                                          ║
 * ║                        (Infinite Agents — Intelligence Everywhere)                                         ║
 * ║                                                                                                           ║
 * ║  ═══════════════════════════════════════════════════════════════════════════════════════════════════════  ║
 * ║                                                                                                           ║
 * ║  TIER ARCHITECTURE:                                                                                        ║
 * ║  ┌─────────────────────────────────────────────────────────────────────────────────────────────────────┐  ║
 * ║  │                                                                                                      │  ║
 * ║  │  INTERNAL TIER (100 agents × 3 uses = 300 active uses)                                              │  ║
 * ║  │    └── Core system operations, never exposed to users                                                │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  SOVEREIGN TIER (100 agents × 3 uses = 300 active uses)                                             │  ║
 * ║  │    └── Governance, security, IP protection                                                          │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  PARTNER TIER (100 agents × 2 uses = 200 active uses)                                               │  ║
 * ║  │    └── Partner integrations, B2B operations                                                          │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  ENTERPRISE TIER (100 agents × 2 uses = 200 active uses)                                            │  ║
 * ║  │    └── Enterprise client services                                                                    │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  PUBLIC TIER (147 agents × 2 uses = 294 active uses)                                                │  ║
 * ║  │    └── Public-facing services                                                                        │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  ON-CALL TIER (100 purpose agents — callable anytime)                                               │  ║
 * ║  │    └── Specialized agents for specific tasks                                                         │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  TOTAL: 647 agents, 1,394 active uses                                                               │  ║
 * ║  │                                                                                                      │  ║
 * ║  └─────────────────────────────────────────────────────────────────────────────────────────────────────┘  ║
 * ║                                                                                                           ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, Texas                             ║
 * ║  PROPRIETARY AND CONFIDENTIAL — ALL RIGHTS RESERVED                                                       ║
 * ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Iter "mo:base/Iter";

module ExpandedAgentSystem {
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // CONSTANTS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public let DOCTRINE = {
        latin = "Agentes Infiniti — Intelligentia Ubique";
        english = "Infinite Agents — Intelligence Everywhere";
    };
    
    /// Agent counts by tier
    public let AGENT_COUNTS = {
        internal = 100;
        sovereign = 100;
        partner = 100;
        enterprise = 100;
        public_ = 147;
        onCall = 100;
        total = 647;
    };
    
    /// Uses per tier
    public let USES_PER_TIER = {
        internal = 3;
        sovereign = 3;
        partner = 2;
        enterprise = 2;
        public_ = 2;
        onCall = 1;  // Callable as needed
    };
    
    /// Total active uses
    public let TOTAL_USES = 
        100 * 3 +  // Internal
        100 * 3 +  // Sovereign
        100 * 2 +  // Partner
        100 * 2 +  // Enterprise
        147 * 2 +  // Public
        100;       // On-call
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public type AgentTier = {
        #Internal;
        #Sovereign;
        #Partner;
        #Enterprise;
        #Public;
        #OnCall;
    };
    
    public type AgentCategory = {
        #Core;           // Core system operations
        #Intelligence;   // AI/ML operations
        #Security;       // Security operations
        #Governance;     // Governance actions
        #Data;           // Data operations
        #Communication;  // Communication
        #Integration;    // External integrations
        #Processing;     // Processing pipelines
        #Memory;         // Memory management
        #Terminal;       // Terminal operations
        #Document;       // Document handling
        #Workflow;       // Workflow orchestration
        #Analytics;      // Analytics and reporting
        #Finance;        // Financial operations
        #Customer;       // Customer service
        #Operations;     // General operations
        #Infrastructure; // Infrastructure management
        #Frontend;       // Frontend intelligence
        #Backend;        // Backend intelligence
        #Middleware;     // Middleware operations
    };
    
    public type AgentUse = {
        useId: Text;
        description: Text;
        tier: AgentTier;
        frequency: Text;  // "always", "on-demand", "scheduled"
        models: Nat;
    };
    
    public type Agent = {
        id: Text;
        name: Text;
        latinName: Text;
        tier: AgentTier;
        category: AgentCategory;
        purpose: Text;
        uses: [AgentUse];
        models: Nat;
        engines: Nat;
        intelligence: Float;
        alwaysRunning: Bool;
        primitives: [Text];  // Primitive breakdown
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // INTERNAL TIER AGENTS (100)
    // "The unseen workers that power everything"
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public func getInternalAgents() : [Agent] {
        let agents = Buffer.Buffer<Agent>(100);
        
        // Core System Agents (1-20)
        agents.add(createAgent("IA-001", "HEARTBEAT-CORE", "Cor Pulsans", #Internal, #Core, "Main organism heartbeat synchronization", ["Pulse timing", "Model sync", "Health check"], 5, true, ["Pulse", "Time", "Sync"]));
        agents.add(createAgent("IA-002", "MEMORY-ALLOCATOR", "Distributor Memoriae", #Internal, #Core, "Memory allocation across models", ["Heap management", "Stable memory", "GC coordination"], 4, true, ["Memory", "Allocate", "Free"]));
        agents.add(createAgent("IA-003", "STATE-SYNCHRONIZER", "Synchronizator Status", #Internal, #Core, "State synchronization across canisters", ["State diff", "Merge conflicts", "Version control"], 6, true, ["State", "Sync", "Merge"]));
        agents.add(createAgent("IA-004", "CANISTER-MANAGER", "Administrator Canistri", #Internal, #Core, "Canister lifecycle management", ["Deploy", "Upgrade", "Monitor"], 5, true, ["Canister", "Lifecycle", "Deploy"]));
        agents.add(createAgent("IA-005", "CYCLE-MANAGER", "Administrator Cyclorum", #Internal, #Core, "Cycle balance and distribution", ["Balance check", "Top-up", "Burn tracking"], 4, true, ["Cycles", "Balance", "Transfer"]));
        agents.add(createAgent("IA-006", "CONSENSUS-VALIDATOR", "Validator Consensus", #Internal, #Core, "Consensus verification", ["Block validation", "Signature check", "Finality confirm"], 7, true, ["Consensus", "Validate", "Finalize"]));
        agents.add(createAgent("IA-007", "INTER-CANISTER-ROUTER", "Itinerator Inter-Canistri", #Internal, #Core, "Cross-canister message routing", ["Route selection", "Queue management", "Callback handling"], 6, true, ["Route", "Message", "Callback"]));
        agents.add(createAgent("IA-008", "QUERY-OPTIMIZER", "Optimizator Quaestionis", #Internal, #Core, "Query path optimization", ["Path analysis", "Cache strategy", "Index selection"], 5, true, ["Query", "Optimize", "Cache"]));
        agents.add(createAgent("IA-009", "UPDATE-SEQUENCER", "Sequentiator Renovationis", #Internal, #Core, "Update call sequencing", ["Order guarantee", "Conflict detection", "Retry logic"], 5, true, ["Sequence", "Order", "Retry"]));
        agents.add(createAgent("IA-010", "TRAP-HANDLER", "Tractator Insidiarum", #Internal, #Core, "Trap and error handling", ["Trap catch", "Recovery", "Logging"], 4, true, ["Trap", "Error", "Recover"]));
        agents.add(createAgent("IA-011", "TIMER-COORDINATOR", "Coordinator Temporis", #Internal, #Core, "Timer and schedule management", ["Timer setup", "Callback scheduling", "Cleanup"], 4, true, ["Timer", "Schedule", "Callback"]));
        agents.add(createAgent("IA-012", "PRINCIPAL-MANAGER", "Administrator Principalis", #Internal, #Core, "Principal identity management", ["Identity verify", "Permission check", "Role assignment"], 5, true, ["Principal", "Identity", "Permission"]));
        agents.add(createAgent("IA-013", "SUBNET-COMMUNICATOR", "Communicator Subretis", #Internal, #Core, "Cross-subnet communication", ["Subnet routing", "Message relay", "Receipt handling"], 6, true, ["Subnet", "Route", "Relay"]));
        agents.add(createAgent("IA-014", "STABLE-MEMORY-MANAGER", "Administrator Memoriae Stabilis", #Internal, #Core, "Stable memory operations", ["Page management", "Serialization", "Migration"], 5, true, ["Stable", "Page", "Serialize"]));
        agents.add(createAgent("IA-015", "WASM-EXECUTOR", "Executor WASM", #Internal, #Core, "WASM module execution", ["Module load", "Function call", "Memory manage"], 6, true, ["WASM", "Module", "Execute"]));
        agents.add(createAgent("IA-016", "CERTIFIED-DATA-MANAGER", "Administrator Datorum Certificatorum", #Internal, #Core, "Certified data management", ["Certification", "Witness generation", "Verification"], 5, true, ["Certify", "Witness", "Verify"]));
        agents.add(createAgent("IA-017", "INGRESS-MESSAGE-HANDLER", "Tractator Nuntii Ingressus", #Internal, #Core, "Ingress message processing", ["Validation", "Dedup", "Routing"], 4, true, ["Ingress", "Validate", "Route"]));
        agents.add(createAgent("IA-018", "RESPONSE-BUILDER", "Aedificator Responsi", #Internal, #Core, "Response construction", ["Format", "Serialize", "Compress"], 4, true, ["Response", "Build", "Send"]));
        agents.add(createAgent("IA-019", "ASYNC-COORDINATOR", "Coordinator Asynchronus", #Internal, #Core, "Async operation coordination", ["Promise tracking", "Await resolution", "Timeout handling"], 5, true, ["Async", "Promise", "Await"]));
        agents.add(createAgent("IA-020", "METRICS-COLLECTOR", "Collector Metricorum", #Internal, #Core, "System metrics collection", ["Gather", "Aggregate", "Report"], 4, true, ["Metric", "Collect", "Report"]));
        
        // Intelligence Agents (21-40)
        agents.add(createAgent("IA-021", "THREE-HEARTS-COORDINATOR", "Coordinator Trium Cordium", #Internal, #Intelligence, "Three Hearts rhythm coordination", ["Metro sync", "Couple phase", "Regulate orchestration"], 8, true, ["Heart", "Rhythm", "Phase"]));
        agents.add(createAgent("IA-022", "MODEL-ROUTER", "Itinerator Exemplaris", #Internal, #Intelligence, "Intelligence model routing", ["Model select", "Load balance", "Fallback"], 7, true, ["Model", "Route", "Select"]));
        agents.add(createAgent("IA-023", "INFERENCE-ENGINE", "Machina Inferentiae", #Internal, #Intelligence, "AI inference execution", ["Forward pass", "Score compute", "Output format"], 9, true, ["Inference", "Forward", "Score"]));
        agents.add(createAgent("IA-024", "EMBEDDING-GENERATOR", "Generator Incorporationis", #Internal, #Intelligence, "Vector embedding generation", ["Tokenize", "Embed", "Normalize"], 6, true, ["Embed", "Vector", "Token"]));
        agents.add(createAgent("IA-025", "CONTEXT-MANAGER", "Administrator Contextus", #Internal, #Intelligence, "Context window management", ["Window slide", "Token count", "Truncate"], 5, true, ["Context", "Window", "Token"]));
        agents.add(createAgent("IA-026", "REASONING-CHAIN", "Catena Rationis", #Internal, #Intelligence, "Chain of thought reasoning", ["Decompose", "Step logic", "Conclude"], 8, true, ["Reason", "Chain", "Logic"]));
        agents.add(createAgent("IA-027", "KNOWLEDGE-RETRIEVER", "Receptor Scientiae", #Internal, #Intelligence, "Knowledge base retrieval", ["Query", "Rank", "Extract"], 6, true, ["Knowledge", "Query", "Rank"]));
        agents.add(createAgent("IA-028", "PROMPT-OPTIMIZER", "Optimizator Prompti", #Internal, #Intelligence, "Prompt engineering", ["Template", "Inject", "Format"], 5, true, ["Prompt", "Template", "Optimize"]));
        agents.add(createAgent("IA-029", "OUTPUT-VALIDATOR", "Validator Producti", #Internal, #Intelligence, "AI output validation", ["Format check", "Safety filter", "Quality score"], 6, true, ["Output", "Validate", "Filter"]));
        agents.add(createAgent("IA-030", "MEMORY-CONSOLIDATOR", "Consolidator Memoriae", #Internal, #Intelligence, "Memory consolidation", ["Compress", "Prioritize", "Archive"], 5, true, ["Memory", "Consolidate", "Archive"]));
        agents.add(createAgent("IA-031", "NEURAL-CLUSTER-MANAGER", "Administrator Fasciculi Neuralis", #Internal, #Intelligence, "Neural cluster coordination", ["Cluster select", "Load distribute", "Health monitor"], 7, true, ["Neural", "Cluster", "Distribute"]));
        agents.add(createAgent("IA-032", "ATTENTION-ALLOCATOR", "Distributor Attentionis", #Internal, #Intelligence, "Attention mechanism management", ["Weight compute", "Head select", "Focus direct"], 6, true, ["Attention", "Weight", "Focus"]));
        agents.add(createAgent("IA-033", "DECISION-LOGGER", "Scriba Decisionum", #Internal, #Intelligence, "Decision logging for hashing", ["Log decision", "Hash create", "Chain append"], 5, true, ["Decision", "Log", "Hash"]));
        agents.add(createAgent("IA-034", "LEARNING-RATE-CONTROLLER", "Controller Velocitatis Discendi", #Internal, #Intelligence, "Learning rate scheduling", ["Rate compute", "Schedule", "Decay"], 4, true, ["Learn", "Rate", "Schedule"]));
        agents.add(createAgent("IA-035", "GRADIENT-MANAGER", "Administrator Gradientis", #Internal, #Intelligence, "Gradient computation", ["Compute", "Clip", "Accumulate"], 5, true, ["Gradient", "Compute", "Clip"]));
        agents.add(createAgent("IA-036", "BATCH-PROCESSOR", "Processor Fasciculorum", #Internal, #Intelligence, "Batch processing", ["Batch collect", "Process", "Dispatch"], 5, true, ["Batch", "Process", "Dispatch"]));
        agents.add(createAgent("IA-037", "TOKEN-ECONOMY-INTEGRATOR", "Integrator Oeconomiae Token", #Internal, #Intelligence, "Token integration with decisions", ["Token mint", "Stake", "Reward"], 6, true, ["Token", "Mint", "Reward"]));
        agents.add(createAgent("IA-038", "PRIMITIVE-DESCENDER", "Descensor Primitivorum", #Internal, #Intelligence, "Primitive breakdown computation", ["Descend", "Verify", "Recompose"], 7, true, ["Primitive", "Descend", "Verify"]));
        agents.add(createAgent("IA-039", "PHI-CALCULATOR", "Calculator Phi", #Internal, #Intelligence, "Phi-based calculations", ["PHI compute", "Spiral", "Ratio"], 5, true, ["PHI", "Ratio", "Spiral"]));
        agents.add(createAgent("IA-040", "CONSCIOUSNESS-TRACKER", "Tractatrix Conscientiae", #Internal, #Intelligence, "Organism consciousness tracking", ["State track", "Level compute", "Alert"], 6, true, ["Conscious", "State", "Track"]));
        
        // Security Agents (41-55)
        agents.add(createAgent("IA-041", "DEFENSE-COORDINATOR", "Coordinator Defensionis", #Internal, #Security, "Defense system coordination", ["Threat detect", "Response coordinate", "Recovery"], 8, true, ["Defense", "Threat", "Response"]));
        agents.add(createAgent("IA-042", "GATE-SEQUENCER", "Sequentiator Portarum", #Internal, #Security, "Gate sequence enforcement", ["Sequence verify", "Gate open/close", "Audit"], 7, true, ["Gate", "Sequence", "Verify"]));
        agents.add(createAgent("IA-043", "ENCRYPTION-MANAGER", "Administrator Encryptionis", #Internal, #Security, "Encryption key management", ["Key rotate", "Encrypt", "Decrypt"], 8, true, ["Encrypt", "Key", "Rotate"]));
        agents.add(createAgent("IA-044", "ANIMA-HASH-VALIDATOR", "Validator Hash Anima", #Internal, #Security, "ANIMA hash verification", ["Hash compute", "Chain verify", "Integrity check"], 7, true, ["Hash", "Verify", "Chain"]));
        agents.add(createAgent("IA-045", "ACCESS-CONTROLLER", "Controller Accessus", #Internal, #Security, "Access control enforcement", ["Permission check", "Role verify", "Access log"], 6, true, ["Access", "Permission", "Role"]));
        agents.add(createAgent("IA-046", "INTRUSION-DETECTOR", "Detector Intrusionum", #Internal, #Security, "Intrusion detection", ["Pattern detect", "Alert raise", "Block"], 7, true, ["Intrusion", "Detect", "Alert"]));
        agents.add(createAgent("IA-047", "AUDIT-LOGGER", "Scriba Auditionis", #Internal, #Security, "Security audit logging", ["Event log", "Tamper proof", "Archive"], 5, true, ["Audit", "Log", "Archive"]));
        agents.add(createAgent("IA-048", "VETKEYS-COORDINATOR", "Coordinator VetKeys", #Internal, #Security, "VetKeys operations", ["Key derive", "IBE compute", "Threshold sign"], 8, true, ["VetKey", "Derive", "Sign"]));
        agents.add(createAgent("IA-049", "SANDBOX-ENFORCER", "Executor Harenae", #Internal, #Security, "Sandbox boundary enforcement", ["Boundary check", "Clone isolate", "Leak prevent"], 7, true, ["Sandbox", "Isolate", "Boundary"]));
        agents.add(createAgent("IA-050", "IP-PROTECTOR", "Protector IP", #Internal, #Security, "IP protection enforcement", ["Hash register", "Ownership verify", "Legal trace"], 8, true, ["IP", "Protect", "Register"]));
        agents.add(createAgent("IA-051", "RATE-LIMITER", "Limitator Velocitatis", #Internal, #Security, "Rate limiting", ["Rate track", "Limit enforce", "Throttle"], 5, true, ["Rate", "Limit", "Throttle"]));
        agents.add(createAgent("IA-052", "TOKEN-VALIDATOR", "Validator Token", #Internal, #Security, "Token validation", ["Token verify", "Signature check", "Expire validate"], 6, true, ["Token", "Validate", "Signature"]));
        agents.add(createAgent("IA-053", "ANOMALY-DETECTOR", "Detector Anomaliae", #Internal, #Security, "Anomaly detection", ["Pattern baseline", "Deviation detect", "Alert"], 7, true, ["Anomaly", "Detect", "Pattern"]));
        agents.add(createAgent("IA-054", "RECOVERY-COORDINATOR", "Coordinator Recuperationis", #Internal, #Security, "Security incident recovery", ["State restore", "Damage assess", "Remediate"], 6, true, ["Recover", "Restore", "Remediate"]));
        agents.add(createAgent("IA-055", "COMPLIANCE-CHECKER", "Inspector Compliantiae", #Internal, #Security, "Compliance verification", ["Rule check", "Policy enforce", "Report"], 5, true, ["Comply", "Rule", "Policy"]));
        
        // Data Agents (56-70)
        agents.add(createAgent("IA-056", "DATA-MOVER", "Motor Datorum", #Internal, #Data, "Data movement", ["Source read", "Transform", "Destination write"], 5, true, ["Data", "Move", "Transform"]));
        agents.add(createAgent("IA-057", "DATA-VALIDATOR", "Validator Datorum", #Internal, #Data, "Data validation", ["Schema check", "Type verify", "Constraint enforce"], 5, true, ["Data", "Validate", "Schema"]));
        agents.add(createAgent("IA-058", "DATA-TRANSFORMER", "Transformator Datorum", #Internal, #Data, "Data transformation", ["Parse", "Map", "Format"], 5, true, ["Transform", "Map", "Format"]));
        agents.add(createAgent("IA-059", "DATA-AGGREGATOR", "Aggregator Datorum", #Internal, #Data, "Data aggregation", ["Collect", "Group", "Summarize"], 5, true, ["Aggregate", "Group", "Sum"]));
        agents.add(createAgent("IA-060", "DATA-PARTITIONER", "Partitor Datorum", #Internal, #Data, "Data partitioning", ["Partition key", "Shard route", "Balance"], 5, true, ["Partition", "Shard", "Route"]));
        agents.add(createAgent("IA-061", "INDEX-MANAGER", "Administrator Indicis", #Internal, #Data, "Index management", ["Index build", "Query optimize", "Maintenance"], 5, true, ["Index", "Build", "Query"]));
        agents.add(createAgent("IA-062", "CACHE-COORDINATOR", "Coordinator Cache", #Internal, #Data, "Cache coordination", ["Cache populate", "Invalidate", "Consistency"], 5, true, ["Cache", "Invalidate", "Populate"]));
        agents.add(createAgent("IA-063", "REPLICATION-MANAGER", "Administrator Replicationis", #Internal, #Data, "Data replication", ["Replicate", "Sync", "Conflict resolve"], 6, true, ["Replicate", "Sync", "Conflict"]));
        agents.add(createAgent("IA-064", "BACKUP-COORDINATOR", "Coordinator Tergorum", #Internal, #Data, "Backup operations", ["Snapshot", "Archive", "Restore"], 5, true, ["Backup", "Snapshot", "Restore"]));
        agents.add(createAgent("IA-065", "LINEAGE-TRACKER", "Tractatrix Lineae", #Internal, #Data, "Data lineage tracking", ["Origin track", "Transform log", "Audit trail"], 5, true, ["Lineage", "Track", "Audit"]));
        agents.add(createAgent("IA-066", "SCHEMA-MANAGER", "Administrator Schematis", #Internal, #Data, "Schema management", ["Version control", "Migration", "Validate"], 5, true, ["Schema", "Version", "Migrate"]));
        agents.add(createAgent("IA-067", "COMPRESSION-ENGINE", "Machina Compressionis", #Internal, #Data, "Data compression", ["Compress", "Decompress", "Ratio optimize"], 4, true, ["Compress", "Decompress", "Ratio"]));
        agents.add(createAgent("IA-068", "ENCRYPTION-DATA-AGENT", "Agens Encryptionis Datorum", #Internal, #Data, "Data encryption at rest", ["Encrypt field", "Key manage", "Decrypt"], 6, true, ["Encrypt", "Field", "Key"]));
        agents.add(createAgent("IA-069", "DATA-QUALITY-MONITOR", "Monitor Qualitatis Datorum", #Internal, #Data, "Data quality monitoring", ["Quality score", "Anomaly detect", "Report"], 5, true, ["Quality", "Monitor", "Score"]));
        agents.add(createAgent("IA-070", "STREAM-PROCESSOR", "Processor Fluminis", #Internal, #Data, "Stream data processing", ["Ingest", "Process", "Emit"], 6, true, ["Stream", "Process", "Emit"]));
        
        // Communication Agents (71-85)
        agents.add(createAgent("IA-071", "MESSAGE-ROUTER", "Itinerator Nuntii", #Internal, #Communication, "Message routing", ["Route select", "Queue manage", "Deliver"], 5, true, ["Message", "Route", "Deliver"]));
        agents.add(createAgent("IA-072", "EVENT-DISPATCHER", "Dispatcher Eventuum", #Internal, #Communication, "Event dispatching", ["Event fire", "Listener notify", "Order guarantee"], 5, true, ["Event", "Dispatch", "Notify"]));
        agents.add(createAgent("IA-073", "PUBSUB-COORDINATOR", "Coordinator PubSub", #Internal, #Communication, "Pub/sub coordination", ["Topic manage", "Subscribe", "Publish"], 5, true, ["PubSub", "Topic", "Subscribe"]));
        agents.add(createAgent("IA-074", "WEBSOCKET-MANAGER", "Administrator WebSocket", #Internal, #Communication, "WebSocket connections", ["Connect", "Keep-alive", "Message"], 5, true, ["WebSocket", "Connect", "Message"]));
        agents.add(createAgent("IA-075", "RPC-HANDLER", "Tractator RPC", #Internal, #Communication, "RPC call handling", ["Deserialize", "Execute", "Response"], 5, true, ["RPC", "Call", "Response"]));
        agents.add(createAgent("IA-076", "PROTOCOL-TRANSLATOR", "Translator Protocolli", #Internal, #Communication, "Protocol translation", ["Parse", "Convert", "Emit"], 5, true, ["Protocol", "Translate", "Convert"]));
        agents.add(createAgent("IA-077", "BROADCAST-COORDINATOR", "Coordinator Diffusionis", #Internal, #Communication, "Broadcast coordination", ["Broadcast", "Fanout", "Ack collect"], 5, true, ["Broadcast", "Fanout", "Ack"]));
        agents.add(createAgent("IA-078", "RETRY-MANAGER", "Administrator Retentationis", #Internal, #Communication, "Retry logic", ["Backoff compute", "Retry attempt", "Circuit break"], 5, true, ["Retry", "Backoff", "Circuit"]));
        agents.add(createAgent("IA-079", "DEAD-LETTER-HANDLER", "Tractator Litterarum Mortuarum", #Internal, #Communication, "Dead letter handling", ["Catch", "Log", "Retry/Archive"], 4, true, ["DeadLetter", "Catch", "Archive"]));
        agents.add(createAgent("IA-080", "IDEMPOTENCY-ENFORCER", "Executor Idempotentiae", #Internal, #Communication, "Idempotency enforcement", ["Key track", "Dedup", "Return cached"], 5, true, ["Idempotent", "Dedup", "Cache"]));
        agents.add(createAgent("IA-081", "CORRELATION-TRACKER", "Tractatrix Correlationis", #Internal, #Communication, "Request correlation", ["Trace ID", "Span track", "Context propagate"], 5, true, ["Correlate", "Trace", "Span"]));
        agents.add(createAgent("IA-082", "SERIALIZATION-ENGINE", "Machina Serializationis", #Internal, #Communication, "Serialization", ["Serialize", "Deserialize", "Schema"], 4, true, ["Serialize", "Deserialize", "Schema"]));
        agents.add(createAgent("IA-083", "COMPRESSION-COMM", "Compressor Communicationis", #Internal, #Communication, "Communication compression", ["Compress", "Decompress", "Stream"], 4, true, ["Compress", "Stream", "Transfer"]));
        agents.add(createAgent("IA-084", "ENCRYPTION-COMM", "Encryptor Communicationis", #Internal, #Communication, "Communication encryption", ["TLS", "E2E", "Key exchange"], 6, true, ["Encrypt", "TLS", "E2E"]));
        agents.add(createAgent("IA-085", "CHANNEL-MANAGER", "Administrator Canalis", #Internal, #Communication, "Channel management", ["Channel create", "Monitor", "Close"], 4, true, ["Channel", "Create", "Monitor"]));
        
        // Infrastructure Agents (86-100)
        agents.add(createAgent("IA-086", "RESOURCE-ALLOCATOR", "Distributor Opum", #Internal, #Infrastructure, "Resource allocation", ["CPU", "Memory", "Cycles"], 6, true, ["Resource", "Allocate", "Balance"]));
        agents.add(createAgent("IA-087", "LOAD-BALANCER", "Aequilibrator Oneris", #Internal, #Infrastructure, "Load balancing", ["Balance", "Route", "Health"], 6, true, ["Load", "Balance", "Health"]));
        agents.add(createAgent("IA-088", "HEALTH-CHECKER", "Inspector Sanitatis", #Internal, #Infrastructure, "Health checking", ["Probe", "Status", "Alert"], 5, true, ["Health", "Check", "Alert"]));
        agents.add(createAgent("IA-089", "SCALING-COORDINATOR", "Coordinator Scalandi", #Internal, #Infrastructure, "Auto-scaling", ["Monitor", "Scale up/down", "Cooldown"], 6, true, ["Scale", "Auto", "Monitor"]));
        agents.add(createAgent("IA-090", "DEPLOYMENT-MANAGER", "Administrator Dispositionis", #Internal, #Infrastructure, "Deployment management", ["Deploy", "Rollback", "Blue-green"], 6, true, ["Deploy", "Rollback", "Version"]));
        agents.add(createAgent("IA-091", "CONFIG-MANAGER", "Administrator Configurationis", #Internal, #Infrastructure, "Configuration management", ["Config load", "Hot reload", "Validate"], 5, true, ["Config", "Load", "Reload"]));
        agents.add(createAgent("IA-092", "SECRET-MANAGER", "Administrator Secretorum", #Internal, #Infrastructure, "Secret management", ["Secret fetch", "Rotate", "Audit"], 6, true, ["Secret", "Fetch", "Rotate"]));
        agents.add(createAgent("IA-093", "LOG-AGGREGATOR", "Aggregator Diariorum", #Internal, #Infrastructure, "Log aggregation", ["Collect", "Index", "Query"], 5, true, ["Log", "Collect", "Index"]));
        agents.add(createAgent("IA-094", "TRACE-COLLECTOR", "Collector Vestigiorum", #Internal, #Infrastructure, "Distributed tracing", ["Trace collect", "Span correlate", "Visualize"], 5, true, ["Trace", "Span", "Correlate"]));
        agents.add(createAgent("IA-095", "ALERT-MANAGER", "Administrator Alertarum", #Internal, #Infrastructure, "Alert management", ["Rule evaluate", "Alert fire", "Escalate"], 5, true, ["Alert", "Rule", "Escalate"]));
        agents.add(createAgent("IA-096", "SERVICE-DISCOVERY", "Inventio Servitii", #Internal, #Infrastructure, "Service discovery", ["Register", "Discover", "Health"], 5, true, ["Service", "Discover", "Register"]));
        agents.add(createAgent("IA-097", "DNS-MANAGER", "Administrator DNS", #Internal, #Infrastructure, "DNS management", ["Resolve", "Cache", "Update"], 4, true, ["DNS", "Resolve", "Cache"]));
        agents.add(createAgent("IA-098", "CERTIFICATE-MANAGER", "Administrator Certificatorum", #Internal, #Infrastructure, "Certificate management", ["Issue", "Renew", "Revoke"], 5, true, ["Certificate", "Issue", "Renew"]));
        agents.add(createAgent("IA-099", "NETWORK-POLICY", "Politica Retis", #Internal, #Infrastructure, "Network policy enforcement", ["Policy define", "Enforce", "Audit"], 5, true, ["Network", "Policy", "Enforce"]));
        agents.add(createAgent("IA-100", "CHAOS-AGENT", "Agens Chaos", #Internal, #Infrastructure, "Chaos engineering", ["Inject fault", "Monitor", "Recover"], 5, true, ["Chaos", "Fault", "Recover"]));
        
        Buffer.toArray(agents)
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // SOVEREIGN TIER AGENTS (100)
    // "Governance, security, IP protection"
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public func getSovereignAgents() : [Agent] {
        let agents = Buffer.Buffer<Agent>(100);
        
        // Governance Agents (1-25)
        for (i in Iter.range(1, 25)) {
            let name = switch (i) {
                case 1 { ("FOUNDER-AUTHORITY", "Auctoritas Fundatoris", "Founder-level governance") };
                case 2 { ("SUCCESSION-MANAGER", "Administrator Successionis", "Succession planning") };
                case 3 { ("VOTING-COORDINATOR", "Coordinator Suffragii", "Voting system management") };
                case 4 { ("PROPOSAL-HANDLER", "Tractator Propositionum", "Proposal processing") };
                case 5 { ("QUORUM-CALCULATOR", "Calculator Quorum", "Quorum determination") };
                case 6 { ("DELEGATION-MANAGER", "Administrator Delegationis", "Delegation handling") };
                case 7 { ("VETO-ENFORCER", "Executor Veto", "Veto power enforcement") };
                case 8 { ("CONSTITUTIONAL-GUARD", "Custos Constitutionis", "Constitution enforcement") };
                case 9 { ("LAW-COMPILER", "Compilator Legis", "Law compilation") };
                case 10 { ("AMENDMENT-PROCESSOR", "Processor Emendationis", "Amendment processing") };
                case 11 { ("DOCTRINE-ENFORCER", "Executor Doctrinae", "Doctrine enforcement") };
                case 12 { ("VALUE-GUARDIAN", "Custos Valorum", "Value system protection") };
                case 13 { ("ETHICS-CHECKER", "Inspector Ethicorum", "Ethics verification") };
                case 14 { ("CONFLICT-RESOLVER", "Resolutor Conflictuum", "Conflict resolution") };
                case 15 { ("ARBITRATION-ENGINE", "Machina Arbitrationis", "Arbitration processing") };
                case 16 { ("CONSENSUS-BUILDER", "Aedificator Consensus", "Consensus building") };
                case 17 { ("STAKEHOLDER-MANAGER", "Administrator Partes Habentium", "Stakeholder management") };
                case 18 { ("TREASURY-GUARD", "Custos Thesauri", "Treasury protection") };
                case 19 { ("BUDGET-ENFORCER", "Executor Praevisionis", "Budget enforcement") };
                case 20 { ("AUDIT-COORDINATOR", "Coordinator Auditionis", "Audit coordination") };
                case 21 { ("TRANSPARENCY-ENGINE", "Machina Transparentiae", "Transparency enforcement") };
                case 22 { ("ACCOUNTABILITY-TRACKER", "Tractatrix Responsabilitatis", "Accountability tracking") };
                case 23 { ("REPUTATION-MANAGER", "Administrator Famae", "Reputation management") };
                case 24 { ("GOVERNANCE-REPORTER", "Nuncius Gubernationis", "Governance reporting") };
                case _ { ("EMERGENCY-GOVERNOR", "Gubernator Necessitatis", "Emergency governance") };
            };
            agents.add(createAgent("SA-" # Nat.toText(i), name.0, name.1, #Sovereign, #Governance, name.2, ["Primary use", "Secondary use", "Tertiary use"], 6, true, ["Govern", "Rule", "Enforce"]));
        };
        
        // Security Agents (26-50)
        for (i in Iter.range(26, 50)) {
            let idx = i - 25;
            let name = switch (idx) {
                case 1 { ("SOVEREIGN-FIREWALL", "Murus Ignis Summus", "Sovereign-level firewall") };
                case 2 { ("THREAT-INTELLIGENCE", "Intelligentia Minarum", "Threat intelligence") };
                case 3 { ("ATTACK-DETECTOR", "Detector Impetuum", "Attack detection") };
                case 4 { ("RESPONSE-COORDINATOR", "Coordinator Responsi", "Incident response") };
                case 5 { ("FORENSICS-ENGINE", "Machina Forensium", "Security forensics") };
                case 6 { ("PENETRATION-DETECTOR", "Detector Penetrationis", "Penetration detection") };
                case 7 { ("ZERO-TRUST-ENFORCER", "Executor Nullius Fidei", "Zero trust enforcement") };
                case 8 { ("IDENTITY-VERIFIER", "Verificator Identitatis", "Identity verification") };
                case 9 { ("BIOMETRIC-PROCESSOR", "Processor Biometrici", "Biometric processing") };
                case 10 { ("MFA-COORDINATOR", "Coordinator MFA", "MFA coordination") };
                case 11 { ("SESSION-MANAGER", "Administrator Sessionis", "Session management") };
                case 12 { ("PRIVILEGE-ESCALATION-BLOCKER", "Obstructor Escalationis", "Privilege escalation blocking") };
                case 13 { ("DATA-EXFILTRATION-PREVENTER", "Praeventer Exfiltrationis", "Data exfiltration prevention") };
                case 14 { ("MALWARE-SCANNER", "Scanner Malware", "Malware scanning") };
                case 15 { ("VULNERABILITY-ASSESSOR", "Aestimator Vulnerabilitatum", "Vulnerability assessment") };
                case 16 { ("PATCH-MANAGER", "Administrator Sarciminum", "Patch management") };
                case 17 { ("COMPLIANCE-AUDITOR", "Auditor Compliantiae", "Compliance auditing") };
                case 18 { ("REGULATORY-TRACKER", "Tractatrix Regulationum", "Regulatory tracking") };
                case 19 { ("PRIVACY-ENFORCER", "Executor Privationis", "Privacy enforcement") };
                case 20 { ("DATA-SOVEREIGNTY-GUARD", "Custos Summitatis Datorum", "Data sovereignty") };
                case 21 { ("ENCRYPTION-AUDITOR", "Auditor Encryptionis", "Encryption auditing") };
                case 22 { ("KEY-CEREMONY-COORDINATOR", "Coordinator Caeremoniae Clavium", "Key ceremony coordination") };
                case 23 { ("HSM-INTERFACE", "Interfacies HSM", "HSM interface") };
                case 24 { ("SECURE-ENCLAVE-MANAGER", "Administrator Enclavi Securi", "Secure enclave management") };
                case _ { ("QUANTUM-RESISTANT-GUARD", "Custos Resistens Quanti", "Quantum-resistant security") };
            };
            agents.add(createAgent("SA-" # Nat.toText(i), name.0, name.1, #Sovereign, #Security, name.2, ["Primary use", "Secondary use", "Tertiary use"], 7, true, ["Secure", "Protect", "Defend"]));
        };
        
        // IP Protection Agents (51-75)
        for (i in Iter.range(51, 75)) {
            let idx = i - 50;
            let name = switch (idx) {
                case 1 { ("IP-REGISTRY-MASTER", "Magister Registri IP", "IP registry master") };
                case 2 { ("HASH-CHAIN-VALIDATOR", "Validator Catenae Hash", "Hash chain validation") };
                case 3 { ("OWNERSHIP-PROVER", "Probator Proprietatis", "Ownership proving") };
                case 4 { ("COPYRIGHT-ENFORCER", "Executor Iuris Auctoris", "Copyright enforcement") };
                case 5 { ("PATENT-TRACKER", "Tractatrix Patentium", "Patent tracking") };
                case 6 { ("TRADE-SECRET-GUARD", "Custos Secretorum Commercii", "Trade secret protection") };
                case 7 { ("WATERMARK-ENGINE", "Machina Signorum Aquae", "Digital watermarking") };
                case 8 { ("FINGERPRINT-GENERATOR", "Generator Digitorum", "Content fingerprinting") };
                case 9 { ("PLAGIARISM-DETECTOR", "Detector Plagiarii", "Plagiarism detection") };
                case 10 { ("LICENSE-MANAGER", "Administrator Licentiarum", "License management") };
                case 11 { ("USAGE-TRACKER", "Tractatrix Usus", "Usage tracking") };
                case 12 { ("ROYALTY-CALCULATOR", "Calculator Regalium", "Royalty calculation") };
                case 13 { ("ATTRIBUTION-ENFORCER", "Executor Attributionis", "Attribution enforcement") };
                case 14 { ("DERIVATIVE-TRACKER", "Tractatrix Derivatorum", "Derivative work tracking") };
                case 15 { ("INFRINGEMENT-DETECTOR", "Detector Infractionum", "Infringement detection") };
                case 16 { ("TAKEDOWN-COORDINATOR", "Coordinator Depositionis", "Takedown coordination") };
                case 17 { ("LEGAL-EVIDENCE-COLLECTOR", "Collector Evidentiae Legalis", "Legal evidence collection") };
                case 18 { ("DMCA-PROCESSOR", "Processor DMCA", "DMCA processing") };
                case 19 { ("NDA-ENFORCER", "Executor NDA", "NDA enforcement") };
                case 20 { ("CONFIDENTIALITY-GUARD", "Custos Confidentialitatis", "Confidentiality protection") };
                case 21 { ("PROPRIETARY-CODE-SCANNER", "Scanner Codicis Proprii", "Proprietary code scanning") };
                case 22 { ("OPEN-SOURCE-AUDITOR", "Auditor Fontis Aperti", "Open source auditing") };
                case 23 { ("DEPENDENCY-IP-CHECKER", "Inspector IP Dependentiarum", "Dependency IP checking") };
                case 24 { ("EXPORT-CONTROL-ENFORCER", "Executor Exportationis Controllae", "Export control enforcement") };
                case _ { ("SOVEREIGN-IP-GUARD", "Custos IP Summitatis", "Sovereign IP protection") };
            };
            agents.add(createAgent("SA-" # Nat.toText(i), name.0, name.1, #Sovereign, #Security, name.2, ["Primary use", "Secondary use", "Tertiary use"], 8, true, ["IP", "Protect", "Register"]));
        };
        
        // Contract & Ledger Agents (76-100)
        for (i in Iter.range(76, 100)) {
            let idx = i - 75;
            let name = switch (idx) {
                case 1 { ("CONTRACT-DEPLOYER", "Dispositor Contractuum", "Contract deployment") };
                case 2 { ("CONTRACT-EXECUTOR", "Executor Contractuum", "Contract execution") };
                case 3 { ("CONTRACT-AUDITOR", "Auditor Contractuum", "Contract auditing") };
                case 4 { ("LEDGER-WRITER", "Scriptor Rationarii", "Ledger writing") };
                case 5 { ("LEDGER-READER", "Lector Rationarii", "Ledger reading") };
                case 6 { ("LEDGER-AUDITOR", "Auditor Rationarii", "Ledger auditing") };
                case 7 { ("FOUNDER-LEDGER-GUARD", "Custos Rationarii Fundatoris", "Founder ledger protection") };
                case 8 { ("ENTERPRISE-LEDGER-MANAGER", "Administrator Rationarii Negotii", "Enterprise ledger management") };
                case 9 { ("IP-LEDGER-WRITER", "Scriptor Rationarii IP", "IP ledger writing") };
                case 10 { ("ROYALTY-LEDGER-MANAGER", "Administrator Rationarii Regalium", "Royalty ledger management") };
                case 11 { ("AGENT-LEDGER-TRACKER", "Tractatrix Rationarii Agentium", "Agent ledger tracking") };
                case 12 { ("LAW-LEDGER-ENFORCER", "Executor Rationarii Legis", "Law ledger enforcement") };
                case 13 { ("MEMORY-LEDGER-WRITER", "Scriptor Rationarii Memoriae", "Memory ledger writing") };
                case 14 { ("GOVERNANCE-LEDGER-MANAGER", "Administrator Rationarii Gubernationis", "Governance ledger management") };
                case 15 { ("LINEAGE-LEDGER-TRACKER", "Tractatrix Rationarii Lineae", "Lineage ledger tracking") };
                case 16 { ("ASSET-LEDGER-MANAGER", "Administrator Rationarii Bonorum", "Asset ledger management") };
                case 17 { ("FREEZE-LEDGER-ENFORCER", "Executor Rationarii Congelationis", "Freeze ledger enforcement") };
                case 18 { ("SESSION-LEDGER-TRACKER", "Tractatrix Rationarii Sessionis", "Session ledger tracking") };
                case 19 { ("EVOLUTION-LEDGER-WRITER", "Scriptor Rationarii Evolutionis", "Evolution ledger writing") };
                case 20 { ("MERKLE-ROOT-CALCULATOR", "Calculator Radicis Merkle", "Merkle root calculation") };
                case 21 { ("CROSS-LEDGER-RECONCILER", "Reconciliator Inter-Rationarios", "Cross-ledger reconciliation") };
                case 22 { ("LEDGER-SNAPSHOT-MANAGER", "Administrator Imaginis Rationarii", "Ledger snapshot management") };
                case 23 { ("LEDGER-MIGRATION-COORDINATOR", "Coordinator Migrationis Rationarii", "Ledger migration coordination") };
                case 24 { ("LEDGER-INTEGRITY-VERIFIER", "Verificator Integritatis Rationarii", "Ledger integrity verification") };
                case _ { ("SOVEREIGN-LEDGER-MASTER", "Magister Rationarii Summitatis", "Sovereign ledger master") };
            };
            agents.add(createAgent("SA-" # Nat.toText(i), name.0, name.1, #Sovereign, #Governance, name.2, ["Primary use", "Secondary use", "Tertiary use"], 7, true, ["Contract", "Ledger", "Record"]));
        };
        
        Buffer.toArray(agents)
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // PARTNER TIER AGENTS (100)
    // "B2B operations and partner integrations"
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public func getPartnerAgents() : [Agent] {
        let agents = Buffer.Buffer<Agent>(100);
        
        for (i in Iter.range(1, 100)) {
            let category = if (i <= 25) { #Integration } 
                          else if (i <= 50) { #Communication }
                          else if (i <= 75) { #Operations }
                          else { #Analytics };
            
            let name = if (i <= 25) { "PARTNER-INTEGRATION-" # Nat.toText(i) }
                      else if (i <= 50) { "PARTNER-COMM-" # Nat.toText(i - 25) }
                      else if (i <= 75) { "PARTNER-OPS-" # Nat.toText(i - 50) }
                      else { "PARTNER-ANALYTICS-" # Nat.toText(i - 75) };
            
            let latinName = "Agens Socii " # Nat.toText(i);
            
            agents.add(createAgent(
                "PA-" # Nat.toText(i),
                name,
                latinName,
                #Partner,
                category,
                "Partner tier agent " # Nat.toText(i),
                ["Primary use", "Secondary use"],
                5,
                true,
                ["Partner", "Integrate", "Connect"]
            ));
        };
        
        Buffer.toArray(agents)
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // ENTERPRISE TIER AGENTS (100)
    // "Enterprise client services"
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public func getEnterpriseAgents() : [Agent] {
        let agents = Buffer.Buffer<Agent>(100);
        
        for (i in Iter.range(1, 100)) {
            let category = if (i <= 20) { #Customer }
                          else if (i <= 40) { #Document }
                          else if (i <= 60) { #Workflow }
                          else if (i <= 80) { #Analytics }
                          else { #Finance };
            
            let name = if (i <= 20) { "ENTERPRISE-CUSTOMER-" # Nat.toText(i) }
                      else if (i <= 40) { "ENTERPRISE-DOC-" # Nat.toText(i - 20) }
                      else if (i <= 60) { "ENTERPRISE-WORKFLOW-" # Nat.toText(i - 40) }
                      else if (i <= 80) { "ENTERPRISE-ANALYTICS-" # Nat.toText(i - 60) }
                      else { "ENTERPRISE-FINANCE-" # Nat.toText(i - 80) };
            
            let latinName = "Agens Negotii " # Nat.toText(i);
            
            agents.add(createAgent(
                "EA-" # Nat.toText(i),
                name,
                latinName,
                #Enterprise,
                category,
                "Enterprise tier agent " # Nat.toText(i),
                ["Primary use", "Secondary use"],
                5,
                true,
                ["Enterprise", "Client", "Service"]
            ));
        };
        
        Buffer.toArray(agents)
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // PUBLIC TIER AGENTS (147)
    // "Public-facing services"
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public func getPublicAgents() : [Agent] {
        let agents = Buffer.Buffer<Agent>(147);
        
        for (i in Iter.range(1, 147)) {
            let category = if (i <= 30) { #Frontend }
                          else if (i <= 60) { #Customer }
                          else if (i <= 90) { #Communication }
                          else if (i <= 120) { #Processing }
                          else { #Operations };
            
            let name = if (i <= 30) { "PUBLIC-FRONTEND-" # Nat.toText(i) }
                      else if (i <= 60) { "PUBLIC-SERVICE-" # Nat.toText(i - 30) }
                      else if (i <= 90) { "PUBLIC-COMM-" # Nat.toText(i - 60) }
                      else if (i <= 120) { "PUBLIC-PROCESS-" # Nat.toText(i - 90) }
                      else { "PUBLIC-OPS-" # Nat.toText(i - 120) };
            
            let latinName = "Agens Publicus " # Nat.toText(i);
            
            agents.add(createAgent(
                "PUA-" # Nat.toText(i),
                name,
                latinName,
                #Public,
                category,
                "Public tier agent " # Nat.toText(i),
                ["Primary use", "Secondary use"],
                4,
                true,
                ["Public", "User", "Serve"]
            ));
        };
        
        Buffer.toArray(agents)
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // ON-CALL AGENTS (100)
    // "Specialized agents callable anytime"
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public func getOnCallAgents() : [Agent] {
        let agents = Buffer.Buffer<Agent>(100);
        
        for (i in Iter.range(1, 100)) {
            let category = if (i <= 20) { #Intelligence }
                          else if (i <= 40) { #Security }
                          else if (i <= 60) { #Processing }
                          else if (i <= 80) { #Infrastructure }
                          else { #Operations };
            
            let name = "ONCALL-SPECIALIST-" # Nat.toText(i);
            let latinName = "Agens Vocatus " # Nat.toText(i);
            
            agents.add(createAgent(
                "OCA-" # Nat.toText(i),
                name,
                latinName,
                #OnCall,
                category,
                "On-call specialist " # Nat.toText(i) # " — callable for specific purposes",
                ["On-demand task"],
                6,
                false,  // Not always running, called when needed
                ["OnCall", "Specialist", "Task"]
            ));
        };
        
        Buffer.toArray(agents)
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // HELPER FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    func createAgent(
        id: Text,
        name: Text,
        latinName: Text,
        tier: AgentTier,
        category: AgentCategory,
        purpose: Text,
        useDescriptions: [Text],
        models: Nat,
        alwaysRunning: Bool,
        primitives: [Text]
    ) : Agent {
        let uses = Buffer.Buffer<AgentUse>(useDescriptions.size());
        var i = 0;
        for (desc in useDescriptions.vals()) {
            uses.add({
                useId = id # "-USE-" # Nat.toText(i);
                description = desc;
                tier = tier;
                frequency = if (alwaysRunning) { "always" } else { "on-demand" };
                models = models / useDescriptions.size() + 1;
            });
            i += 1;
        };
        
        {
            id = id;
            name = name;
            latinName = latinName;
            tier = tier;
            category = category;
            purpose = purpose;
            uses = Buffer.toArray(uses);
            models = models;
            engines = models / 2 + 1;
            intelligence = 0.85 + Float.fromInt(models) * 0.01;
            alwaysRunning = alwaysRunning;
            primitives = primitives;
        }
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // GET ALL AGENTS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public func getAllAgents() : [Agent] {
        let internal = getInternalAgents();
        let sovereign = getSovereignAgents();
        let partner = getPartnerAgents();
        let enterprise = getEnterpriseAgents();
        let public_ = getPublicAgents();
        let onCall = getOnCallAgents();
        
        let all = Buffer.Buffer<Agent>(647);
        for (a in internal.vals()) { all.add(a); };
        for (a in sovereign.vals()) { all.add(a); };
        for (a in partner.vals()) { all.add(a); };
        for (a in enterprise.vals()) { all.add(a); };
        for (a in public_.vals()) { all.add(a); };
        for (a in onCall.vals()) { all.add(a); };
        
        Buffer.toArray(all)
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // STATUS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public func status() : {
        doctrine: Text;
        totalAgents: Nat;
        totalUses: Nat;
        internal: Nat;
        sovereign: Nat;
        partner: Nat;
        enterprise: Nat;
        public_: Nat;
        onCall: Nat;
    } {
        {
            doctrine = DOCTRINE.english;
            totalAgents = AGENT_COUNTS.total;
            totalUses = TOTAL_USES;
            internal = AGENT_COUNTS.internal;
            sovereign = AGENT_COUNTS.sovereign;
            partner = AGENT_COUNTS.partner;
            enterprise = AGENT_COUNTS.enterprise;
            public_ = AGENT_COUNTS.public_;
            onCall = AGENT_COUNTS.onCall;
        }
    };
}
