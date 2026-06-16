// SUBSYSTEM TERMINALS — TERMINALIA SUBSYSTEMATUM
// "Omne Subsystema Habet Suum Terminale. Nullum Sine Terminali."
// Every major subsystem gets its OWN dedicated terminal.
//
// Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";
import MatalkoICP "MatalkoICP";

module SubsystemTerminals {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    public let DOCTRINE : Text = "Nemo sine terminali. Omnia terminalia habent.";
    public let DOCTRINE_EN : Text = "No one without a terminal. All have their terminal.";

    public type SubsystemTerminal = {
        id: Text; systemName: Text; latinName: Text; latinMotto: Text;
        commandPrefix: Text; subsystemFiles: [Text]; subsystemFunctions: [Text];
        frequency_Hz: Float; primitiveTrace: Text; isAlwaysOn: Bool; purpose: Text;
    };

    public let MEMORY_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-001"; systemName = "MEMORY";
        latinName = "TERMINALE MEMORIAE"; latinMotto = "Memoria manet. Terminale servat.";
        commandPrefix = "/memory";
        subsystemFiles = ["MemoryTemple.mo"; "AnimaChainEncryption.mo"; "SovereignLedgers.mo"; "DocumentOrganism.mo"];
        subsystemFunctions = ["store"; "get"; "search"; "pin"; "getLineage"; "extendChain"];
        frequency_Hz = PHI; primitiveTrace = "MEMORY_TERMINAL->Memory->phi";
        isAlwaysOn = true; purpose = "Commands entire memory layer: storage recall lineage chains ledgers";
    };

    public let HEARTBEAT_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-002"; systemName = "HEARTBEAT";
        latinName = "TERMINALE PULSUS"; latinMotto = "Pulsus numquam sistit. Terminale vigilat.";
        commandPrefix = "/heartbeat";
        subsystemFiles = ["Heartbeat.mo"; "ThreeHeartsEngine.mo"; "ThreeHeartsIntelligence.mo"; "FrequencyPhysicsEngine.mo"];
        subsystemFunctions = ["tick"; "pause"; "resume"; "getBeat"; "getFrequency"; "getThreeHeartsState"];
        frequency_Hz = PHI; primitiveTrace = "HEARTBEAT_TERMINAL->Repetition->phi";
        isAlwaysOn = true; purpose = "Commands heartbeat and frequency: pulse Three Hearts Kuramoto all Hz layers";
    };

    public let DEFENSE_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-003"; systemName = "DEFENSE";
        latinName = "TERMINALE DEFENSIONIS"; latinMotto = "Nullus hostis transit. Terminale custodit.";
        commandPrefix = "/defense";
        subsystemFiles = ["SovereignDefenseSystem.mo"; "ShimmerDefense.mo"; "SovereignEncryption.mo"; "VetKeysIntegration.mo"];
        subsystemFunctions = ["checkGate"; "shimmer"; "rotateKey"; "encrypt"; "decrypt"; "sealWithHearts"];
        frequency_Hz = PHI_SQ; primitiveTrace = "DEFENSE_TERMINAL->Distinction->phi";
        isAlwaysOn = true; purpose = "Commands all defense: Gate A/B/C shimmer encryption vetKeys";
    };

    public let GOVERNANCE_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-004"; systemName = "GOVERNANCE";
        latinName = "TERMINALE GUBERNATIONIS"; latinMotto = "Lex regnant. Terminale iudicat.";
        commandPrefix = "/govern";
        subsystemFiles = ["Governance.mo"; "Constitution.mo"; "CanonicalLawLedger.mo"; "FreddysLaws.mo"; "LawVectorCompiler.mo"];
        subsystemFunctions = ["propose"; "vote"; "enforce"; "getLaws"; "validate"; "isConstitutional"; "compileLaw"];
        frequency_Hz = PHI; primitiveTrace = "GOVERNANCE_TERMINAL->Logic->phi";
        isAlwaysOn = true; purpose = "Commands governance: proposals voting laws constitution doctrine";
    };

    public let INTELLIGENCE_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-005"; systemName = "INTELLIGENCE";
        latinName = "TERMINALE INTELLIGENTIAE"; latinMotto = "Intelligentia omnia movet. Terminale dirigit.";
        commandPrefix = "/intel";
        subsystemFiles = ["IntelligenceRouter.mo"; "ThreeHeartsIntelligence.mo"; "ExternalAIWorkers.mo"; "AgentFleet.mo"];
        subsystemFunctions = ["route"; "think"; "feel"; "regulate"; "routeToCluster"; "getWorkers"; "getModels"];
        frequency_Hz = PHI; primitiveTrace = "INTELLIGENCE_TERMINAL->Relation->phi";
        isAlwaysOn = true; purpose = "Commands intelligence routing: Three Hearts 57 models R/U/D/N clusters";
    };

    public let ORGANISM_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-006"; systemName = "ORGANISM";
        latinName = "TERMINALE ORGANISMI"; latinMotto = "Organismus vivit. Terminale audit.";
        commandPrefix = "/organism";
        subsystemFiles = ["UnifiedOrganism.mo"; "SovereignOrganism.mo"; "CompleteOrganismBody.mo"; "OrganismReader.mo"];
        subsystemFunctions = ["tick"; "evolve"; "pulse"; "getState"; "oroReadsDoctrine"; "readOrganism"; "getBody"];
        frequency_Hz = PHI; primitiveTrace = "ORGANISM_TERMINAL->Field->phi";
        isAlwaysOn = true; purpose = "Commands living organism: state health Oro/Nova consensus body";
    };

    public let QUANTUM_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-007"; systemName = "QUANTUM";
        latinName = "TERMINALE QUANTUM"; latinMotto = "Quantum non determinatur. Terminale observat.";
        commandPrefix = "/quantum";
        subsystemFiles = ["QuantumEntanglementBus.mo"; "QuantumModels.mo"; "FieldPhysicsEngine.mo"; "IcosahedralLeechGeometry.mo"];
        subsystemFunctions = ["createEntanglement"; "sync"; "sendMessage"; "superpose"; "entangle"; "measure"];
        frequency_Hz = 0.01; primitiveTrace = "QUANTUM_TERMINAL->Field->phi";
        isAlwaysOn = true; purpose = "Commands quantum layer: entanglement bus field physics sacred geometry";
    };

    public let AGENTS_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-008"; systemName = "AGENTS";
        latinName = "TERMINALE AGENTIUM"; latinMotto = "Agentes vivunt. Terminale coordinat.";
        commandPrefix = "/agents";
        subsystemFiles = ["ActivatedAgents.mo"; "AgentFleet.mo"; "AgentModels.mo"; "InternalAIWorkers.mo"; "ExternalAIWorkers.mo"];
        subsystemFunctions = ["queryAgent"; "activateAll"; "consult"; "deployAgent"; "getFleet"; "getInternalWorkers"];
        frequency_Hz = PHI; primitiveTrace = "AGENTS_TERMINAL->Relation->phi";
        isAlwaysOn = true; purpose = "Commands all agents: 6 activated fleet internal external 57 models";
    };

    public let DESIGN_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-009"; systemName = "DESIGN";
        latinName = "TERMINALE DESIGNI"; latinMotto = "Pulchritudo ex intelligentia. Terminale creat.";
        commandPrefix = "/design";
        subsystemFiles = ["SovereignDesignOS.mo"; "IntelligentFrontendModels.mo"; "FrontendBackendSync.mo"; "PhotonLayerModels.mo"];
        subsystemFunctions = ["getDesignModels"; "renderWith"; "synthesizeDesign"; "syncFrontend"; "pushIntelligence"];
        frequency_Hz = 60.0; primitiveTrace = "DESIGN_TERMINAL->Field->phi";
        isAlwaysOn = true; purpose = "Commands design OS: 10 sovereign render models frontend-backend wire";
    };

    public let TOKENS_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-010"; systemName = "TOKENS";
        latinName = "TERMINALE NUMMORUM"; latinMotto = "Nummi valorem habent. Terminale servat.";
        commandPrefix = "/tokens";
        subsystemFiles = ["MemoriaToken.mo"; "TokenLedger.mo"; "TokenCivilization.mo"; "SovereignContracts.mo"];
        subsystemFunctions = ["mint"; "transfer"; "burn"; "balance"; "record"; "verify"; "getCivilization"; "createContract"];
        frequency_Hz = PHI; primitiveTrace = "TOKENS_TERMINAL->Memory->phi";
        isAlwaysOn = true; purpose = "Commands token systems: Memoria token ledgers civilization contracts";
    };

    public let PACKAGES_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-011"; systemName = "PACKAGES";
        latinName = "TERMINALE PACKETORUM"; latinMotto = "Packetum intelligens. Terminale instruit.";
        commandPrefix = "/packages";
        subsystemFiles = ["SovereignPackageManager.mo"; "ToolModels.mo"; "WorkerTools.mo"; "SovereignExtensionEcosystem.mo"];
        subsystemFunctions = ["install"; "remove"; "getPackages"; "getTool"; "getAllTools"; "getExtension"];
        frequency_Hz = PHI; primitiveTrace = "PACKAGES_TERMINAL->Relation->phi";
        isAlwaysOn = true; purpose = "Commands PACK-MEDINA: tools 300+ extensions protocols sovereign links";
    };

    public let PHYSICS_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-012"; systemName = "PHYSICS";
        latinName = "TERMINALE PHYSICAE"; latinMotto = "Physica est lingua. Terminale loquitur.";
        commandPrefix = "/physics";
        subsystemFiles = ["FrequencyPhysicsEngine.mo"; "FieldPhysicsEngine.mo"; "RootFormulasEverywhere.mo"; "UniversalFormulaEngine.mo"];
        subsystemFunctions = ["getFrequency"; "computeField"; "getFormula"; "propagateFormula"; "evaluate"; "getPhi"];
        frequency_Hz = PHI; primitiveTrace = "PHYSICS_TERMINAL->Equation->phi";
        isAlwaysOn = true; purpose = "Commands physics: frequencies fields 50 formulas math engine";
    };

    public let SUBSTRATE_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-013"; systemName = "SUBSTRATE";
        latinName = "TERMINALE SUBSTRATI"; latinMotto = "Substratum omnibus substat. Terminale fundat.";
        commandPrefix = "/substrate";
        subsystemFiles = ["NeuralMeshSubstrate.mo"; "MicroMacroSubstrate.mo"; "ThermodynamicsSubstrate.mo"; "PlatinumCatalyticEngine.mo"];
        subsystemFunctions = ["initMesh"; "propagate"; "getDeltaG"; "getAlphaModels"; "activateBranch"; "runCatalysis"];
        frequency_Hz = PHI; primitiveTrace = "SUBSTRATE_TERMINAL->Field->phi";
        isAlwaysOn = true; purpose = "Commands substrate: neural mesh thermo micro-macro Pt-CA engine";
    };

    public let ICP_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-014"; systemName = "ICP";
        latinName = "TERMINALE ICP"; latinMotto = "ICP noster. Terminale regit.";
        commandPrefix = "/icp";
        subsystemFiles = ["SovereignICP.mo"; "MedinaSovereignICP.mo"; "MatalkoICP.mo"; "SovereignVersioning.mo"];
        subsystemFunctions = ["getSubnets"; "consensus"; "deployCanister"; "getBFTStatus"; "createVersion"; "rollback"];
        frequency_Hz = PHI; primitiveTrace = "ICP_TERMINAL->Address->phi";
        isAlwaysOn = true; purpose = "Commands sovereign ICP: 10 subnets phi-BFT canister deployment versioning";
    };

    public let WWW_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-015"; systemName = "WWW";
        latinName = "TERMINALE IWW"; latinMotto = "IWW noster. Terminale navigat.";
        commandPrefix = "/www";
        subsystemFiles = ["SovereignWWW.mo"; "IWW.mo"; "SovereignProtocolExtensions.mo"; "SovereignULRI.mo"];
        subsystemFunctions = ["getDomains"; "resolve"; "route"; "getIWWStatus"; "registerProtocol"; "parse"];
        frequency_Hz = PHI; primitiveTrace = "WWW_TERMINAL->Address->phi";
        isAlwaysOn = true; purpose = "Commands sovereign web: IWW protocols domains medina:// memoria:// anima://";
    };

    public let OS_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-016"; systemName = "OS";
        latinName = "TERMINALE OS"; latinMotto = "Systema vivens. Terminale operatur.";
        commandPrefix = "/os";
        subsystemFiles = ["MedinaOS.mo"; "SovereignWASM.mo"; "WasmArchitecture.mo"; "SovereignPackageManager.mo"];
        subsystemFunctions = ["getOSIdentity"; "getComponents"; "installPackage"; "compile"; "execute"; "getRuntime"];
        frequency_Hz = PHI; primitiveTrace = "OS_TERMINAL->Field->ALL->phi";
        isAlwaysOn = true; purpose = "Commands MEDINA OS: IWW MCP PACK-MEDINA MEDINA-WASM ULRI full sovereign OS";
    };

    public let ANCIENT_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-017"; systemName = "ANCIENT";
        latinName = "TERMINALE ANTIQUUM"; latinMotto = "Antiqua sapientia vivit. Terminale recolit.";
        commandPrefix = "/ancient";
        subsystemFiles = ["AncientPrimitiveFoundation.mo"; "AncientArchitecture.mo"; "AncientGlyphCodex.mo"; "AncientMathEngine.mo"];
        subsystemFunctions = ["getField"; "getDistinction"; "getRelation"; "getMemory"; "getGlyph"; "sacredGeometry"];
        frequency_Hz = 0.01; primitiveTrace = "ANCIENT_TERMINAL->ALL primitives->phi";
        isAlwaysOn = true; purpose = "Commands ancient layer: 6 primitives glyphs sacred math Leech lattice";
    };

    public let RELEASE_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-018"; systemName = "RELEASE";
        latinName = "TERMINALE LIBERATIONIS"; latinMotto = "Liberatur quod perfectum est. Terminale liberat.";
        commandPrefix = "/release";
        subsystemFiles = ["SemperMemoria.mo"; "SandboxClone.mo"; "SovereignVersioning.mo"];
        subsystemFunctions = ["createSandbox"; "getSaaSProducts"; "getReleaseStatus"; "createClone"; "getAllowedAPIs"];
        frequency_Hz = 7.83; primitiveTrace = "RELEASE_TERMINAL->Memory->phi";
        isAlwaysOn = true; purpose = "Commands Semper Memoria: 10 SaaS products sandbox versioning deployment";
    };

    public let SCANNER_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-019"; systemName = "SCANNER";
        latinName = "TERMINALE EXPLORATORUM"; latinMotto = "Omnia videt. Omnia invenit. Terminale scit.";
        commandPrefix = "/scanner";
        subsystemFiles = ["ArchitectureScanner.mo"; "MegaTerminus.mo"; "CallableFunctionRegistry.mo"];
        subsystemFunctions = ["scanLayer"; "exploreFile"; "discoverAllTools"; "buildArchitectureMap"; "megaSynthesizeAll"];
        frequency_Hz = PHI; primitiveTrace = "SCANNER_TERMINAL->ALL layers->phi";
        isAlwaysOn = true; purpose = "Commands architecture scanner: 6 scanner models full traversal tool discovery";
    };

    public let SYNC_TERMINAL : SubsystemTerminal = {
        id = "SYS-TERM-020"; systemName = "SYNC";
        latinName = "TERMINALE NEXUS"; latinMotto = "Frons et dorsum. Unum sunt. Terminale unit.";
        commandPrefix = "/sync";
        subsystemFiles = ["FrontendBackendSync.mo"; "IntelligentFrontendModels.mo"; "EmbodiedEndpoints.mo"; "IntelligenceWire.ts"];
        subsystemFunctions = ["syncFrontend"; "getFrontendState"; "pushToFrontend"; "touchEndpoint"; "beginEmbodiment"];
        frequency_Hz = PHI; primitiveTrace = "SYNC_TERMINAL->Relation->Field->phi";
        isAlwaysOn = true; purpose = "Commands frontend-backend intelligence wire: 22 frontend to 360 backend";
    };

    public let ALL_SUBSYSTEM_TERMINALS : [SubsystemTerminal] = [
        MEMORY_TERMINAL,
        HEARTBEAT_TERMINAL,
        DEFENSE_TERMINAL,
        GOVERNANCE_TERMINAL,
        INTELLIGENCE_TERMINAL,
        ORGANISM_TERMINAL,
        QUANTUM_TERMINAL,
        AGENTS_TERMINAL,
        DESIGN_TERMINAL,
        TOKENS_TERMINAL,
        PACKAGES_TERMINAL,
        PHYSICS_TERMINAL,
        SUBSTRATE_TERMINAL,
        ICP_TERMINAL,
        WWW_TERMINAL,
        OS_TERMINAL,
        ANCIENT_TERMINAL,
        RELEASE_TERMINAL,
        SCANNER_TERMINAL,
        SYNC_TERMINAL,
    ];

    public func getByPrefix(prefix: Text) : ?SubsystemTerminal {
        Array.find<SubsystemTerminal>(ALL_SUBSYSTEM_TERMINALS, func(t) { t.commandPrefix == prefix })
    };

    public func summary() : { total: Nat; doctrine: Text } {
        { total = ALL_SUBSYSTEM_TERMINALS.size(); doctrine = DOCTRINE }
    };

    public func renderDirectory() : Text {
        var dir = "TERMINALIA SUBSYSTEMATUM
";
        dir #= DOCTRINE # "
";
        for (t in ALL_SUBSYSTEM_TERMINALS.vals()) {
            dir #= t.commandPrefix # "  " # t.systemName # "  " # t.latinMotto # "
";
        };
        dir #= "TOTAL: " # Nat.toText(ALL_SUBSYSTEM_TERMINALS.size()) # " subsystem terminals
";
        dir
    };
}