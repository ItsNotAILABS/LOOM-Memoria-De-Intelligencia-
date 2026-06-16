/**
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                    MEDINA - PROPRIETARY AND CONFIDENTIAL                  ║
 * ║                                                                           ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA   ║
 * ║                       medinasiftech@outlook.com                           ║
 * ║                                                                           ║
 * ║  ALL RIGHTS RESERVED. NO FREE LICENSES. STRICTLY PROPRIETARY.            ║
 * ║                                                                           ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 * 
 * DOC-PRIMITIVA-130 — The Universal Primitive Organism
 * 
 * ═══════════════════════════════════════════════════════════════════════════
 * 
 * A LIVING DOCUMENT ORGANISM whose function is to trace any object in the 
 * architecture back to its primitive form and produce lawful recomposition maps.
 * 
 * ORGANISM MANDATE:
 *   - Detect primitives
 *   - Expose false surfaces
 *   - Trace backward through layers
 *   - Preserve origin continuity
 *   - Generate recomposition maps
 *   - Feed corrected structures back into doctrine, code, business, and documents
 * 
 * ORGANISM CLASS (Multi-Class):
 *   - Doctrine Organism      — Holds and applies L-130 law
 *   - Analysis Organism      — Analyzes entities for primitives
 *   - Registry Organism      — Maintains primitive registry
 *   - Anti-Drift Organism    — Detects and corrects drift
 *   - Architectural Recovery Organism — Recovers lost primitives
 * 
 * PRIMARY RELATIONS (Connects to):
 *   - Law Registry
 *   - Engine Registry
 *   - Organism Registry
 *   - Document Registry
 *   - Architecture Registry
 *   - Workflow Registry
 *   - Business Registry
 *   - Symbol Registry
 *   - Color Registry
 *   - Substrate Registry
 * 
 * ═══════════════════════════════════════════════════════════════════════════
 * 
 * DOCUMENT STRUCTURE:
 *   1. Header Identity
 *   2. Core Statement
 *   3. Primitive Ontology
 *   4. Primitive Detection Protocol
 *   5. Primitive Descent Maps
 *   6. Primitive Recomposition Protocol
 *   7. Drift Signatures
 *   8. Related Engines and Organisms
 *   9. Applications
 *   10. Expansion Queue
 * 
 * ═══════════════════════════════════════════════════════════════════════════
 * 
 * Attribution: Alfredo Medina Hernandez — Founder, Architect of MEDINA
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import DocumentOrganism "DocumentOrganism";
import UniversalPrimitiveLaw "UniversalPrimitiveLaw";
import UniversalPrimitiveEngine "UniversalPrimitiveEngine";

module {
    // ================================================================== //
    // ORGANISM IDENTITY                                                    //
    // ================================================================== //
    
    /// Organism name
    public let ORGANISM_NAME : Text = "DOC-PRIMITIVA-130";
    
    /// Organism full name
    public let ORGANISM_FULL_NAME : Text = "The Universal Primitive Organism";
    
    /// Law reference
    public let LAW_REFERENCE : Text = "L-130 — Universal Primitive Law";
    
    /// Status
    public let STATUS : Text = "Active";
    
    /// Attribution
    public let ATTRIBUTION : Text = "Alfredo Medina Hernandez — Founder, Philosopher, Visionary, Architect, Creator of MEDINA";
    
    /// Formation timestamp (immutable once set)
    public let FORMATION_TIMESTAMP : Int = 1713415200000000000; // April 18, 2024 in nanoseconds
    
    // ================================================================== //
    // ORGANISM CLASS TYPES                                                 //
    // ================================================================== //
    
    /// Organism class classification
    public type OrganismClass = {
        #DoctrineOrganism;              // Holds and applies law
        #AnalysisOrganism;              // Analyzes for primitives
        #RegistryOrganism;              // Maintains primitive registry
        #AntiDriftOrganism;             // Detects and corrects drift
        #ArchitecturalRecoveryOrganism; // Recovers lost primitives
    };
    
    /// All classes this organism belongs to
    public let ORGANISM_CLASSES : [OrganismClass] = [
        #DoctrineOrganism,
        #AnalysisOrganism,
        #RegistryOrganism,
        #AntiDriftOrganism,
        #ArchitecturalRecoveryOrganism
    ];
    
    // ================================================================== //
    // REGISTRY CONNECTIONS                                                 //
    // ================================================================== //
    
    /// Registry type that this organism connects to
    public type RegistryConnection = {
        #LawRegistry;
        #EngineRegistry;
        #OrganismRegistry;
        #DocumentRegistry;
        #ArchitectureRegistry;
        #WorkflowRegistry;
        #BusinessRegistry;
        #SymbolRegistry;
        #ColorRegistry;
        #SubstrateRegistry;
    };
    
    /// All registries this organism connects to
    public let PRIMARY_RELATIONS : [RegistryConnection] = [
        #LawRegistry,
        #EngineRegistry,
        #OrganismRegistry,
        #DocumentRegistry,
        #ArchitectureRegistry,
        #WorkflowRegistry,
        #BusinessRegistry,
        #SymbolRegistry,
        #ColorRegistry,
        #SubstrateRegistry
    ];
    
    // ================================================================== //
    // DOCUMENT SECTIONS (Living Document Structure)                        //
    // ================================================================== //
    
    /// Section 1: Header Identity
    public type HeaderIdentity = {
        name: Text;
        index: Text;
        status: Text;
        doc_type: [Text];
        attribution: Text;
        registry_anchor: Text;
        formation_timestamp: Int;
    };
    
    /// Section 2: Core Statement
    public type CoreStatement = {
        law_text: Text;
        four_nested_statements: [Text];
        operational_movement: [Text];
    };
    
    /// Section 3: Primitive Ontology
    public type PrimitiveOntologySection = {
        domains: [UniversalPrimitiveLaw.PrimitiveOntology];
        domain_count: Nat;
    };
    
    /// Section 4: Detection Protocol
    public type DetectionProtocol = {
        questions: [Text];
        tests: [Text];
        process_steps: [Text];
    };
    
    /// Section 5: Descent Maps
    public type DescentMapsSection = {
        code_descent: PrimitiveDescentMap;
        company_descent: PrimitiveDescentMap;
        token_descent: PrimitiveDescentMap;
        law_descent: PrimitiveDescentMap;
        document_descent: PrimitiveDescentMap;
        civilization_descent: PrimitiveDescentMap;
        color_descent: PrimitiveDescentMap;
        human_body_descent: PrimitiveDescentMap;
        intelligence_descent: PrimitiveDescentMap;
        market_descent: PrimitiveDescentMap;
        workflow_descent: PrimitiveDescentMap;
    };
    
    /// Individual descent map
    public type PrimitiveDescentMap = {
        domain: Text;
        surface_form: Text;
        intermediate_layers: [Text];
        primitive_form: Text;
        historical_traces: [Text];
    };
    
    /// Section 6: Recomposition Protocol
    public type RecompositionProtocol = {
        principles: [Text];
        steps: [Text];
        continuity_checks: [Text];
    };
    
    /// Section 7: Drift Signatures
    public type DriftSignaturesSection = {
        drift_types: [UniversalPrimitiveLaw.DriftType];
        detection_markers: [Text];
        correction_paths: [Text];
    };
    
    /// Section 8: Related Engines and Organisms
    public type RelatedSystemsSection = {
        engines: [Text];
        organisms: [Text];
        laws: [Text];
    };
    
    /// Section 9: Applications
    public type ApplicationsSection = {
        company_design: Text;
        token_design: Text;
        doctrine_design: Text;
        code_audits: Text;
        architecture_reading: Text;
        legal_packet_prep: Text;
        investor_packet_filtering: Text;
        scientific_framing: Text;
        civilization_analysis: Text;
    };
    
    /// Section 10: Expansion Queue
    public type ExpansionQueue = {
        pending_items: [Text];
        priority_items: [Text];
        completed_items: [Text];
    };
    
    // ================================================================== //
    // PRIMITIVE REGISTRY ENTRY                                             //
    // ================================================================== //
    
    /// A single entry in the primitive registry
    public type PrimitiveRegistryEntry = {
        entry_id: Text;
        entity_id: Text;
        entity_type: UniversalPrimitiveLaw.EntityDomain;
        primitive_form: Text;
        primitive_state: UniversalPrimitiveLaw.PrimitiveState;
        confidence: Float;
        descent_depth: Nat;
        recomposition_available: Bool;
        drift_status: ?UniversalPrimitiveLaw.DriftType;
        related_laws: [Text];
        related_engines: [Text];
        created_at: Int;
        updated_at: Int;
        traced_by: Text;  // Who/what performed the trace
    };
    
    // ================================================================== //
    // ORGANISM STATE                                                       //
    // ================================================================== //
    
    /// Complete organism state
    public type PrimitivaOrganismState = {
        // Identity
        var organism_id: Text;
        var base_organism: DocumentOrganism.DocumentOrganism;
        
        // Content sections
        var header: HeaderIdentity;
        var core_statement: CoreStatement;
        var primitive_ontology: PrimitiveOntologySection;
        var detection_protocol: DetectionProtocol;
        var descent_maps: DescentMapsSection;
        var recomposition_protocol: RecompositionProtocol;
        var drift_signatures: DriftSignaturesSection;
        var related_systems: RelatedSystemsSection;
        var applications: ApplicationsSection;
        var expansion_queue: ExpansionQueue;
        
        // Primitive registry
        var primitive_registry: [PrimitiveRegistryEntry];
        
        // Statistics
        var total_traces: Nat;
        var primitives_found: Nat;
        var drifts_detected: Nat;
        var recompositions_generated: Nat;
        
        // Engine reference
        var engine_state: UniversalPrimitiveEngine.EngineState;
    };
    
    // ================================================================== //
    // INITIALIZATION                                                       //
    // ================================================================== //
    
    /// Initialize the PRIMITIVA organism
    public func init() : PrimitivaOrganismState {
        let now = Time.now();
        
        // Create base document organism
        let baseOrganism = DocumentOrganism.create(
            ORGANISM_NAME,
            ORGANISM_FULL_NAME,
            "doctrine_organism",
            0.8,  // High metabolic rate for active analysis
            UniversalPrimitiveLaw.lawStatement()
        );
        
        // Initialize all sections
        let header = initHeader();
        let coreStatement = initCoreStatement();
        let ontology = initPrimitiveOntology();
        let detection = initDetectionProtocol();
        let descent = initDescentMaps();
        let recomposition = initRecompositionProtocol();
        let drift = initDriftSignatures();
        let related = initRelatedSystems();
        let apps = initApplications();
        let expansion = initExpansionQueue();
        
        {
            var organism_id = ORGANISM_NAME # "_" # Int.toText(now);
            var base_organism = baseOrganism;
            var header = header;
            var core_statement = coreStatement;
            var primitive_ontology = ontology;
            var detection_protocol = detection;
            var descent_maps = descent;
            var recomposition_protocol = recomposition;
            var drift_signatures = drift;
            var related_systems = related;
            var applications = apps;
            var expansion_queue = expansion;
            var primitive_registry = [];
            var total_traces = 0;
            var primitives_found = 0;
            var drifts_detected = 0;
            var recompositions_generated = 0;
            var engine_state = UniversalPrimitiveEngine.init();
        }
    };
    
    /// Initialize header identity
    func initHeader() : HeaderIdentity {
        {
            name = ORGANISM_NAME;
            index = "L-130";
            status = STATUS;
            doc_type = ["Foundational", "Recursive", "Sovereignty", "Analysis"];
            attribution = ATTRIBUTION;
            registry_anchor = "law_registry_L130";
            formation_timestamp = FORMATION_TIMESTAMP;
        }
    };
    
    /// Initialize core statement
    func initCoreStatement() : CoreStatement {
        {
            law_text = UniversalPrimitiveLaw.lawStatement();
            four_nested_statements = [
                "1. Primitive Precedes Expression — No expression is original at the surface. Every expression is downstream of a primitive.",
                "2. Primitive Governs Recomposition — A thing can only be rebuilt truthfully if its primitive has been recovered first.",
                "3. Primitive Drift Causes Architectural Falsehood — If a system forgets its primitive, it begins optimizing the wrong layer.",
                "4. Primitive Recovery Restores Sovereignty — To recover the primitive is to regain command over the thing."
            ];
            operational_movement = [
                "1. Detect current form",
                "2. Strip away inherited wrappers",
                "3. Trace backward through layers",
                "4. Find the primitive",
                "5. Check primitive state (alive, false, damaged, split, hybridized, inverted, concealed)",
                "6. Rebuild the thing from primitive outward"
            ];
        }
    };
    
    /// Initialize primitive ontology
    func initPrimitiveOntology() : PrimitiveOntologySection {
        {
            domains = UniversalPrimitiveLaw.getAllOntologies();
            domain_count = 5;  // Initial count, can expand
        }
    };
    
    /// Initialize detection protocol
    func initDetectionProtocol() : DetectionProtocol {
        {
            questions = [
                "What is the irreducible active reality here?",
                "What would remain if all wrappers were removed?",
                "What function exists independent of current form?",
                "What came before this current expression?",
                "Is this actually irreducible, or can it be traced further back?",
                "Is this active (functional) or just historical?",
                "Does identity persist if this is removed?",
                "Is this contaminated with downstream additions?"
            ];
            tests = UniversalPrimitiveLaw.primitiveValidationTests();
            process_steps = [
                "1. Gather entity information (type, current expression, known layers)",
                "2. Strip all wrappers (naming, abstraction, convenience, marketing, etc.)",
                "3. Descend through architectural layers",
                "4. Identify primitive candidate",
                "5. Run verification tests",
                "6. Determine primitive state",
                "7. Generate recomposition blueprint if verified"
            ];
        }
    };
    
    /// Initialize descent maps
    func initDescentMaps() : DescentMapsSection {
        {
            code_descent = {
                domain = "Code/Software";
                surface_form = "Modern application with frameworks";
                intermediate_layers = [
                    "Framework layer",
                    "Library layer",
                    "Language constructs",
                    "Algorithms",
                    "Data structures",
                    "Control flow",
                    "Memory operations"
                ];
                primitive_form = "Binary operations, state transitions";
                historical_traces = [
                    "AI → algorithms → computation → counting → tally marks",
                    "Database → storage → memory → persistence → inscription",
                    "Network → communication → signal → pattern → rhythm"
                ];
            };
            company_descent = {
                domain = "Company/Organization";
                surface_form = "Modern corporation with org chart";
                intermediate_layers = [
                    "Legal structure",
                    "Operational processes",
                    "Value proposition",
                    "Coordination mechanism",
                    "Trust relationships"
                ];
                primitive_form = "Core function: revenue extraction, protection, transformation, coordination, creation, sovereignty, infrastructure, or signal routing";
                historical_traces = [
                    "Corporation → guild → trade pact → trust network → family unit",
                    "Business → exchange → reciprocity → survival cooperation"
                ];
            };
            token_descent = {
                domain = "Token/Digital Asset";
                surface_form = "Modern cryptocurrency or token";
                intermediate_layers = [
                    "Smart contract implementation",
                    "Economic model",
                    "Rights representation",
                    "Trust encoding"
                ];
                primitive_form = "Receipt, pressure, memory, governance, claim, exchange medium, access gate, reward trace, or survival reserve";
                historical_traces = [
                    "Crypto → digital record → ledger → tally → memory",
                    "Token → claim → promise → oath → sacred bond"
                ];
            };
            law_descent = {
                domain = "Law/Governance";
                surface_form = "Modern legal code";
                intermediate_layers = [
                    "Statutory framework",
                    "Precedent system",
                    "Enforcement mechanism",
                    "Authority source"
                ];
                primitive_form = "Authority source, consent mechanism, enforcement capability, legitimacy basis";
                historical_traces = [
                    "Law → custom → taboo → survival rule → boundary",
                    "Democracy → tribal council → oath system → sacred assembly → elder wisdom"
                ];
            };
            document_descent = {
                domain = "Document";
                surface_form = "Modern digital document";
                intermediate_layers = [
                    "Format and structure",
                    "Content organization",
                    "Knowledge encoding",
                    "Information function"
                ];
                primitive_form = "Registry, memory crystal, law anchor, transfer mechanism, formation shell, world-model surface, symbolic compression, living organism";
                historical_traces = [
                    "PDF → text file → manuscript → inscription → memory trace",
                    "Contract → agreement → promise → spoken oath"
                ];
            };
            civilization_descent = {
                domain = "Civilization";
                surface_form = "Modern nation-state";
                intermediate_layers = [
                    "Political structure",
                    "Economic system",
                    "Cultural institutions",
                    "Social organization",
                    "Coordination mechanisms"
                ];
                primitive_form = "Collective survival, resource coordination, meaning-making, territory";
                historical_traces = [
                    "Nation → kingdom → city-state → tribe → band → family",
                    "Economy → market → exchange → gift → sharing"
                ];
            };
            color_descent = {
                domain = "Color";
                surface_form = "Named color (e.g., 'Royal Blue')";
                intermediate_layers = [
                    "Color naming system",
                    "Cultural associations",
                    "Perceptual experience",
                    "Light frequency"
                ];
                primitive_form = "Electromagnetic frequency, photoreceptor activation";
                historical_traces = [
                    "Color name → cultural meaning → perception → light → frequency",
                    "Pigment → mineral → earth chemistry"
                ];
            };
            human_body_descent = {
                domain = "Human Body/Medicine";
                surface_form = "Medical diagnosis and treatment";
                intermediate_layers = [
                    "Diagnostic categories",
                    "Symptom patterns",
                    "Physiological systems",
                    "Cellular processes"
                ];
                primitive_form = "Body-field observation, balance, recovery cycle, vital force";
                historical_traces = [
                    "Medicine → body observation → humoral balance → plant intelligence → ritual healing",
                    "Surgery → wound care → trauma response → survival instinct"
                ];
            };
            intelligence_descent = {
                domain = "Intelligence";
                surface_form = "Modern AI system";
                intermediate_layers = [
                    "Machine learning models",
                    "Neural network architectures",
                    "Pattern recognition algorithms",
                    "Statistical inference",
                    "Symbol manipulation"
                ];
                primitive_form = "Field of relation, distinction, resonance, orientation, memory, and recomposition capacity";
                historical_traces = [
                    "AI → computation → logic → reasoning → cognition → awareness",
                    "Neural network → brain model → nervous system → cellular signaling"
                ];
            };
            market_descent = {
                domain = "Market/Economy";
                surface_form = "Modern financial market";
                intermediate_layers = [
                    "Trading platforms",
                    "Financial instruments",
                    "Price discovery mechanisms",
                    "Exchange systems"
                ];
                primitive_form = "Trust, debt, memory, exchange, tribute, sovereignty";
                historical_traces = [
                    "Stock market → exchange → bazaar → trade gathering → gift exchange",
                    "Money → trust → debt → memory → sacrifice accounting"
                ];
            };
            workflow_descent = {
                domain = "Workflow/Process";
                surface_form = "Modern business process";
                intermediate_layers = [
                    "Automation system",
                    "Process documentation",
                    "Task sequences",
                    "Coordination rules"
                ];
                primitive_form = "Goal-directed action sequence, coordination mechanism";
                historical_traces = [
                    "BPM → procedure → routine → habit → instinct",
                    "Automation → tool use → technique → skill"
                ];
            };
        }
    };
    
    /// Initialize recomposition protocol
    func initRecompositionProtocol() : RecompositionProtocol {
        {
            principles = [
                "Start from verified primitive",
                "Build outward layer by layer",
                "Preserve primitive identity at each transition",
                "Minimize abstraction additions",
                "Maintain functional continuity",
                "Check for drift at each layer"
            ];
            steps = [
                "1. Confirm primitive is verified",
                "2. Build substrate layer from primitive",
                "3. Construct structure layer from substrate",
                "4. Add signal/communication layer",
                "5. Create interface layer",
                "6. Manifest expression layer",
                "7. Compare to original expression",
                "8. Document any drift"
            ];
            continuity_checks = [
                "Does the primitive identity persist to this layer?",
                "Is the function still traceable to the primitive?",
                "Have unnecessary abstractions been added?",
                "Is there naming drift?",
                "Is there function drift?"
            ];
        }
    };
    
    /// Initialize drift signatures
    func initDriftSignatures() : DriftSignaturesSection {
        {
            drift_types = [
                #PrimitiveForgotten,
                #WrongLayerOptimization,
                #InversionDrift,
                #FragmentationDrift,
                #HybridizationDrift,
                #AbstractionDrift,
                #NamingDrift,
                #FunctionDrift
            ];
            detection_markers = [
                "System no longer references its primitive",
                "Optimization targets surface metrics, not primitive function",
                "Cause and effect appear reversed",
                "Primitive has been split across multiple systems",
                "Incompatible primitives have been merged",
                "Too many layers hide the primitive",
                "Name no longer reflects primitive function",
                "Current function diverges from primitive purpose"
            ];
            correction_paths = [
                "Re-trace to primitive using descent protocol",
                "Re-align optimization to primitive-derived metrics",
                "Restore correct causal direction",
                "Reunify fragmented primitive",
                "Separate hybridized primitives",
                "Remove unnecessary abstraction layers",
                "Rename to reflect primitive",
                "Realign function to primitive purpose"
            ];
        }
    };
    
    /// Initialize related systems
    func initRelatedSystems() : RelatedSystemsSection {
        {
            engines = [
                "Universal Primitive Engine",
                "Primitive Drift Detector",
                "Primitive Recomposition Engine",
                "Anti-Inversion Engine"
            ];
            organisms = [
                "DOC-PRIMITIVA-130 (this organism)",
                "Primitive Registry Organism",
                "Drift Detection Organism",
                "Architectural Recovery Organism"
            ];
            laws = [
                "L-130 — Universal Primitive Law",
                "L-130.1 — Primitive Precedes Expression",
                "L-130.2 — Primitive Governs Recomposition",
                "L-130.3 — Primitive Drift Causes Architectural Falsehood",
                "L-130.4 — Primitive Recovery Restores Sovereignty"
            ];
        }
    };
    
    /// Initialize applications
    func initApplications() : ApplicationsSection {
        {
            company_design = "Before designing a company, trace to its primitive function. Is it revenue extraction, protection, transformation, coordination, creation, sovereignty, infrastructure, or signal routing? Build all structures from that primitive.";
            token_design = "Before creating a token, identify its primitive. Is it receipt, pressure, memory, governance, claim, exchange medium, access gate, reward trace, or survival reserve? All tokenomics must derive from primitive.";
            doctrine_design = "Before writing doctrine, find the primitive truth it encodes. Build upward from that truth to surface statements. Verify continuity at each layer.";
            code_audits = "Audit code by tracing each component to its primitive computation. Identify abstraction drift, naming drift, function drift. Recommend primitive-aligned refactoring.";
            architecture_reading = "Read any architecture by descending to primitives first. Understanding comes from primitives, not surface expressions.";
            legal_packet_prep = "Prepare legal packets by establishing primitive claims first. Surface legal language must trace continuously to primitive rights/obligations.";
            investor_packet_filtering = "Filter investor materials by checking primitive alignment. Reject packets where surface claims disconnect from primitive value.";
            scientific_framing = "Frame scientific inquiry by identifying the primitive phenomenon. Surface theories must trace to primitive observations.";
            civilization_analysis = "Analyze civilizations by tracing current forms to primitive functions: survival, coordination, meaning-making, territory.";
        }
    };
    
    /// Initialize expansion queue
    func initExpansionQueue() : ExpansionQueue {
        {
            pending_items = [
                "Add primitive ontology for more domains",
                "Develop automated primitive detection heuristics",
                "Create primitive-to-primitive mapping system",
                "Build cross-domain primitive correlation engine"
            ];
            priority_items = [
                "Integrate with entity registration workflow",
                "Add primitive trace metadata requirement to all registries"
            ];
            completed_items = [
                "Initial law statement",
                "Four nested statements",
                "Core descent maps",
                "Detection protocol"
            ];
        }
    };
    
    // ================================================================== //
    // ORGANISM MANDATE FUNCTIONS                                           //
    // ================================================================== //
    
    /// Detect primitive for an entity
    public func detectPrimitive(
        state: PrimitivaOrganismState,
        entity_id: Text,
        entity_type: UniversalPrimitiveLaw.EntityDomain,
        current_expression: Text,
        known_layers: [Text]
    ) : (PrimitivaOrganismState, ?Text) {
        let input : UniversalPrimitiveEngine.EngineInput = {
            entity_id = entity_id;
            entity_type = entity_type;
            current_expression = current_expression;
            known_layers = known_layers;
            doctrine_context = null;
            history_context = null;
            cross_domain_references = [];
        };
        
        let (newEngineState, primitive) = UniversalPrimitiveEngine.detectPrimitive(
            state.engine_state, input
        );
        
        state.engine_state := newEngineState;
        state.total_traces += 1;
        if (primitive != null) {
            state.primitives_found += 1;
        };
        
        (state, primitive)
    };
    
    /// Expose false surface (detect drift)
    public func exposeFalseSurface(
        state: PrimitivaOrganismState,
        entity_id: Text,
        entity_type: UniversalPrimitiveLaw.EntityDomain,
        claimed_primitive: Text,
        current_expression: Text
    ) : (PrimitivaOrganismState, ?UniversalPrimitiveLaw.DriftSignature) {
        // Use law function to detect drift
        let drift = UniversalPrimitiveLaw.detectPrimitiveDrift(
            entity_id,
            claimed_primitive,
            current_expression
        );
        
        switch (drift) {
            case (?d) { state.drifts_detected += 1; };
            case (null) {};
        };
        
        (state, drift)
    };
    
    /// Trace backward through layers
    public func traceBackward(
        state: PrimitivaOrganismState,
        entity_id: Text,
        entity_type: UniversalPrimitiveLaw.EntityDomain,
        current_expression: Text,
        known_layers: [Text]
    ) : (PrimitivaOrganismState, UniversalPrimitiveEngine.DescendResult) {
        let input : UniversalPrimitiveEngine.EngineInput = {
            entity_id = entity_id;
            entity_type = entity_type;
            current_expression = current_expression;
            known_layers = known_layers;
            doctrine_context = null;
            history_context = null;
            cross_domain_references = [];
        };
        
        let result = UniversalPrimitiveEngine.descendLayers(state.engine_state, input);
        state.total_traces += 1;
        
        (state, result)
    };
    
    /// Generate recomposition map
    public func generateRecompositionMap(
        state: PrimitivaOrganismState,
        entity_id: Text,
        entity_type: UniversalPrimitiveLaw.EntityDomain,
        current_expression: Text,
        known_layers: [Text]
    ) : (PrimitivaOrganismState, ?UniversalPrimitiveLaw.RecompositionBlueprint) {
        let input : UniversalPrimitiveEngine.EngineInput = {
            entity_id = entity_id;
            entity_type = entity_type;
            current_expression = current_expression;
            known_layers = known_layers;
            doctrine_context = null;
            history_context = null;
            cross_domain_references = [];
        };
        
        let result = UniversalPrimitiveEngine.mapRecomposition(state.engine_state, input);
        
        switch (result.blueprint) {
            case (?b) { state.recompositions_generated += 1; };
            case (null) {};
        };
        
        (state, result.blueprint)
    };
    
    /// Full primitive trace (runs complete engine)
    public func fullPrimitiveTrace(
        state: PrimitivaOrganismState,
        entity_id: Text,
        entity_type: UniversalPrimitiveLaw.EntityDomain,
        current_expression: Text,
        known_layers: [Text],
        doctrine_context: ?Text,
        history_context: ?Text
    ) : (PrimitivaOrganismState, UniversalPrimitiveEngine.EngineOutput) {
        let input : UniversalPrimitiveEngine.EngineInput = {
            entity_id = entity_id;
            entity_type = entity_type;
            current_expression = current_expression;
            known_layers = known_layers;
            doctrine_context = doctrine_context;
            history_context = history_context;
            cross_domain_references = [];
        };
        
        let (newEngineState, output) = UniversalPrimitiveEngine.processEntity(
            state.engine_state, input
        );
        
        state.engine_state := newEngineState;
        state.total_traces += 1;
        
        if (output.primitive_form != null) {
            state.primitives_found += 1;
        };
        
        if (output.drift_map.size() > 0) {
            state.drifts_detected += 1;
        };
        
        if (output.recomposition_blueprint != null) {
            state.recompositions_generated += 1;
        };
        
        // Add to registry
        let entry : PrimitiveRegistryEntry = {
            entry_id = "prim_" # entity_id # "_" # Int.toText(Time.now());
            entity_id = entity_id;
            entity_type = entity_type;
            primitive_form = switch (output.primitive_form) {
                case (?p) { p };
                case (null) { "UNREACHED" };
            };
            primitive_state = output.primitive_state;
            confidence = output.primitive_confidence_score;
            descent_depth = output.phase_results.descend_result.descent_depth;
            recomposition_available = output.recomposition_blueprint != null;
            drift_status = if (output.drift_map.size() > 0) {
                ?output.drift_map[0].drift_type
            } else { null };
            related_laws = output.related_laws;
            related_engines = ["Universal Primitive Engine"];
            created_at = Time.now();
            updated_at = Time.now();
            traced_by = ORGANISM_NAME;
        };
        
        let registry = Buffer.fromArray<PrimitiveRegistryEntry>(state.primitive_registry);
        registry.add(entry);
        state.primitive_registry := Buffer.toArray(registry);
        
        (state, output)
    };
    
    // ================================================================== //
    // REGISTRY RULE: NO ENTITY WITHOUT PRIMITIVE TRACE                    //
    // ================================================================== //
    
    /// Check if entity has primitive trace metadata
    public func hasPrimitiveTrace(state: PrimitivaOrganismState, entity_id: Text) : Bool {
        for (entry in state.primitive_registry.vals()) {
            if (entry.entity_id == entity_id) {
                return true;
            };
        };
        false
    };
    
    /// Get primitive trace for entity
    public func getPrimitiveTrace(
        state: PrimitivaOrganismState, 
        entity_id: Text
    ) : ?PrimitiveRegistryEntry {
        for (entry in state.primitive_registry.vals()) {
            if (entry.entity_id == entity_id) {
                return ?entry;
            };
        };
        null
    };
    
    /// Require primitive trace before registration
    /// Returns (success, error_message)
    public func requirePrimitiveTraceForRegistration(
        state: PrimitivaOrganismState,
        entity_id: Text,
        entity_type: UniversalPrimitiveLaw.EntityDomain,
        current_expression: Text,
        known_layers: [Text]
    ) : (PrimitivaOrganismState, Bool, Text) {
        // First check if trace already exists
        if (hasPrimitiveTrace(state, entity_id)) {
            return (state, true, "Primitive trace already exists");
        };
        
        // Run full primitive trace
        let (newState, output) = fullPrimitiveTrace(
            state,
            entity_id,
            entity_type,
            current_expression,
            known_layers,
            null,
            null
        );
        
        // Check if primitive was found
        switch (output.primitive_form) {
            case (?_) {
                (newState, true, "Primitive trace completed successfully")
            };
            case (null) {
                (newState, false, "Could not trace primitive - registration blocked by L-130")
            };
        }
    };
    
    // ================================================================== //
    // ORGANISM STATISTICS                                                  //
    // ================================================================== //
    
    /// Get organism statistics
    public func getStatistics(state: PrimitivaOrganismState) : {
        organism_id: Text;
        total_traces: Nat;
        primitives_found: Nat;
        drifts_detected: Nat;
        recompositions_generated: Nat;
        registry_size: Nat;
        engine_stats: {
            total_processed: Nat;
            primitives_verified: Nat;
            verification_rate: Float;
        };
    } {
        let engineStats = UniversalPrimitiveEngine.getStatistics(state.engine_state);
        
        {
            organism_id = state.organism_id;
            total_traces = state.total_traces;
            primitives_found = state.primitives_found;
            drifts_detected = state.drifts_detected;
            recompositions_generated = state.recompositions_generated;
            registry_size = state.primitive_registry.size();
            engine_stats = {
                total_processed = engineStats.total_processed;
                primitives_verified = engineStats.primitives_verified;
                verification_rate = engineStats.verification_rate;
            };
        }
    };
    
    /// Get the law statement
    public func getLawStatement() : Text {
        UniversalPrimitiveLaw.lawStatement()
    };
    
    /// Attribution
    public func attribution() : Text {
        ATTRIBUTION
    };
}
