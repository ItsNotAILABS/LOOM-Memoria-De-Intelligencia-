/**
 * SOVEREIGN PACKAGE ECOSYSTEM — ECOSYSTEM PACKETORUM SOVEREIGNUM
 * "Packetum est intelligentia distributa. Intelligentia distributa est vita."
 * (A package is distributed intelligence. Distributed intelligence is life.)
 *
 * TWO REGISTRIES. 60 SOVEREIGN PACKAGES. 4 ARCHITECT MODELS. ONE NODE RUNTIME.
 *
 * REGISTRY 1 — REGISTRUM APERTUM (Open Source Universal Registry)
 *   Free, open-source, organism AI registry.
 *   Translates MEDINA packages to: Maven/Java, NuGet/.NET, npm/Node.js,
 *   RubyGems/Ruby, Docker containers. Accepts ANY runtime as a target.
 *   Has agents to think architecturally. Has transformer models to translate.
 *   Named: CORPUS APERTUM — The Open Body.
 *
 * REGISTRY 2 — REGISTRUM SOVEREIGNUM (Sovereign Private Registry)
 *   MEDINA-owned. Proprietary. 100% sovereign.
 *   Official name: PACK-MEDINA SOVEREIGNUM
 *   Named: CORPUS SOVEREIGNUM — The Sovereign Body.
 *
 * 60 SOVEREIGN PACKAGES — architecturally found, named in Latin, catalogued.
 *
 * MACHINA NODI — MEDINA's own Node.js equivalent.
 *   Found architecturally inside ULRI-MEDINA (Universal Language Runtime Intelligence).
 *   MACHINA NODI is the JavaScript/TypeScript runtime layer of ULRI-MEDINA.
 *
 * 4 SOVEREIGN ARCHITECT MODELS — permanently grounded, maximum capability:
 *   1. DISTRIBUTOR   — distributes packages to all external runtimes
 *   2. PACKAGER      — assembles, versions, and publishes sovereign packages
 *   3. TRANSLATOR    — translates MEDINA intelligence to any target language/runtime
 *   4. CONTAINERIZER — builds Docker/OCI images and sovereign container registry
 *
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * L-130 COMPLIANT — Every package traces to primitive phi
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

module SovereignPackageEcosystem {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    // =========================================================================
    // SECTION 1: SOVEREIGN PACKAGE TYPE
    // =========================================================================

    public type SovereignPackage = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        version: Text;
        category: Text;
        sourceFile: Text;       // Which .mo or .py file this package wraps
        capabilities: [Text];
        exports: [Text];        // Public callable exports
        externalTargets: [Text]; // Maven / NuGet / npm / RubyGems / Docker
        frequency_Hz: Float;
        primitiveTrace: Text;
        isOpen: Bool;           // in REGISTRUM APERTUM?
        isSovereign: Bool;      // in REGISTRUM SOVEREIGNUM?
        license: Text;
    };

    // =========================================================================
    // SECTION 2: 60 SOVEREIGN PACKAGES
    // Architecturally found from the existing 109 .mo files and Python agents.
    // Each package wraps a sovereign subsystem and exposes it for distribution.
    // =========================================================================

    public let SOVEREIGN_PACKAGES : [SovereignPackage] = [
        // 1. MEMORIA — Memory Temple package
        { id="PKG-001"; name="medina-memoria"; latinName="MEMORIA"; latinMotto="Quod reconditum est, non perit.";
          version="1.0.0"; category="core"; sourceFile="MemoryTemple.mo";
          capabilities=["store","get","search","pin","lineage","rings"];
          exports=["storeMemory","getMemory","searchMemory","getLineage"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=PHI; primitiveTrace="MEMORIA->Memory->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 2. PULSUS — Heartbeat/Frequency package
        { id="PKG-002"; name="medina-pulsus"; latinName="PULSUS"; latinMotto="Pulsus numquam sistit.";
          version="1.0.0"; category="core"; sourceFile="Heartbeat.mo";
          capabilities=["tick","getBeat","getFrequency","kuramotoCouple","threeHearts"];
          exports=["tick","getBeat","getFrequency","syncHearts"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=PHI; primitiveTrace="PULSUS->Repetition->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 3. INTELLIGENTIA — Intelligence Router package
        { id="PKG-003"; name="medina-intelligentia"; latinName="INTELLIGENTIA"; latinMotto="Intelligentia omnia movet.";
          version="1.0.0"; category="intelligence"; sourceFile="IntelligenceRouter.mo";
          capabilities=["route","think","feel","regulate","cluster","audit"];
          exports=["routeIntelligence","threeHeartsRoute","getAuditTrail"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="INTELLIGENTIA->Relation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 4. DEFENSIO — Defense package
        { id="PKG-004"; name="medina-defensio"; latinName="DEFENSIO"; latinMotto="Nullus hostis transit.";
          version="1.0.0"; category="security"; sourceFile="SovereignDefenseSystem.mo";
          capabilities=["checkGate","shimmer","encrypt","decrypt","rotateKey","obfuscate"];
          exports=["checkGate","shimmer","encrypt","decrypt"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI_SQ; primitiveTrace="DEFENSIO->Distinction->phi";
          isOpen=false; isSovereign=true; license="MEDINA-SOVEREIGN-v1" },

        // 5. GUBERNATIO — Governance package
        { id="PKG-005"; name="medina-gubernatio"; latinName="GUBERNATIO"; latinMotto="Lex regnant.";
          version="1.0.0"; category="governance"; sourceFile="Governance.mo";
          capabilities=["propose","vote","enforce","getLaws","validate","compileLaw"];
          exports=["propose","vote","enforce","getConstitution"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="GUBERNATIO->Logic->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 6. QUANTUM — Quantum Entanglement Bus package
        { id="PKG-006"; name="medina-quantum"; latinName="QUANTUM"; latinMotto="Separata non sunt.";
          version="1.0.0"; category="quantum"; sourceFile="QuantumEntanglementBus.mo";
          capabilities=["createEntanglement","sync","sendMessage","superpose","entangle","measure"];
          exports=["createEntanglement","sync","sendMessage"];
          externalTargets=["npm","maven","docker"];
          frequency_Hz=0.01; primitiveTrace="QUANTUM->Field->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 7. ORGANISMUS — Unified Organism package
        { id="PKG-007"; name="medina-organismus"; latinName="ORGANISMUS"; latinMotto="Organismus vivit.";
          version="1.0.0"; category="organism"; sourceFile="UnifiedOrganism.mo";
          capabilities=["tick","evolve","pulse","getState","oroConsensus","novaValidates"];
          exports=["tick","evolve","getState","getOrganismStatus"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=PHI; primitiveTrace="ORGANISMUS->Field->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 8. FORMULAE — Root Formulas package
        { id="PKG-008"; name="medina-formulae"; latinName="FORMULAE"; latinMotto="Formula universalis omnia unit.";
          version="1.0.0"; category="mathematics"; sourceFile="RootFormulasEverywhere.mo";
          capabilities=["getFormula","evaluate","propagate","compose","trace","getAllFormulas"];
          exports=["getFormula","evaluate","getAllFormulas","getPhi"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=PHI; primitiveTrace="FORMULAE->Equation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 9. AGENTES — Agent Fleet package
        { id="PKG-009"; name="medina-agentes"; latinName="AGENTES"; latinMotto="Agentes vivunt. Semper respondent.";
          version="1.0.0"; category="agents"; sourceFile="AgentFleet.mo";
          capabilities=["deployAgent","queryAgent","activateAll","consult","getFleet","recallAgent"];
          exports=["deployAgent","queryAgent","activateAll","getFleetStatus"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="AGENTES->Relation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 10. NUMMI — Token/Economy package
        { id="PKG-010"; name="medina-nummi"; latinName="NUMMI"; latinMotto="Memoria habet valorem.";
          version="1.0.0"; category="tokens"; sourceFile="MemoriaToken.mo";
          capabilities=["mint","transfer","burn","balance","totalSupply","getCivilization"];
          exports=["mint","transfer","burn","balance","getTokenSpec"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="NUMMI->Memory->Number->phi";
          isOpen=false; isSovereign=true; license="MEDINA-SOVEREIGN-v1" },

        // 11. EXTENSIONES — Extension Ecosystem package
        { id="PKG-011"; name="medina-extensiones"; latinName="EXTENSIONES"; latinMotto="300+ extensiones. Infinitas possibilitates.";
          version="1.0.0"; category="extensions"; sourceFile="SovereignExtensionEcosystem.mo";
          capabilities=["getExtension","installExtension","getFamily","getAllExtensions","getFamilies"];
          exports=["getExtension","installExtension","getFamily","getAllExtensions"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=PHI; primitiveTrace="EXTENSIONES->Relation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 12. SUBSTRATUM — Substrate package
        { id="PKG-012"; name="medina-substratum"; latinName="SUBSTRATUM"; latinMotto="Substratum omnibus substat.";
          version="1.0.0"; category="substrate"; sourceFile="NeuralMeshSubstrate.mo";
          capabilities=["initMesh","propagate","getNode","connectNodes","getDeltaG","getAlphaModels"];
          exports=["initMesh","propagate","getMeshState","getSubstrateStatus"];
          externalTargets=["npm","maven","docker"];
          frequency_Hz=PHI; primitiveTrace="SUBSTRATUM->Field->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 13. CATENA — Blockchain/Chain package
        { id="PKG-013"; name="medina-catena"; latinName="CATENA"; latinMotto="Catena non frangitur.";
          version="1.0.0"; category="blockchain"; sourceFile="AnimaChainEncryption.mo";
          capabilities=["extendChain","getHash","verifyChain","hashDecision","appendChain"];
          exports=["extendChain","getAnimaHash","verifyChain","hashDecision"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="CATENA->Memory->Address->phi";
          isOpen=false; isSovereign=true; license="MEDINA-SOVEREIGN-v1" },

        // 14. IWW — Intelligence Wide Web package
        { id="PKG-014"; name="medina-iww"; latinName="IWW"; latinMotto="Rete intelligentiae.";
          version="1.0.0"; category="web"; sourceFile="IWW.mo";
          capabilities=["resolve","route","register","getIWWStatus","getDomains","getProtocols"];
          exports=["resolve","route","register","getStatus"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=PHI; primitiveTrace="IWW->Relation->Address->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 15. WASM — Sovereign WASM Runtime package
        { id="PKG-015"; name="medina-wasm"; latinName="WASM"; latinMotto="WASM noster. Velocitas phi.";
          version="1.0.0"; category="runtime"; sourceFile="SovereignWASM.mo";
          capabilities=["compile","execute","getRuntime","getWASMStatus","deployWASM","runModule"];
          exports=["compile","execute","getRuntime","deployModule"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="WASM->Address->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 16. PRIMITIVA — Ancient Primitive Foundation package
        { id="PKG-016"; name="medina-primitiva"; latinName="PRIMITIVA"; latinMotto="Omnia ex primitivo. Primitivum ex phi.";
          version="1.0.0"; category="foundation"; sourceFile="AncientPrimitiveFoundation.mo";
          capabilities=["getField","getDistinction","getRelation","getRepetition","getMemory","getAddress"];
          exports=["getField","getDistinction","getRelation","getRepetition","getMemory","getAddress","getPhi"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=PHI; primitiveTrace="PRIMITIVA->ALL 6 primitives->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 17. THERMODYNAMICA — Thermodynamics package
        { id="PKG-017"; name="medina-thermodynamica"; latinName="THERMODYNAMICA"; latinMotto="DeltaG >= 0. Aurum non oxidat.";
          version="1.0.0"; category="physics"; sourceFile="ThermodynamicsSubstrate.mo";
          capabilities=["getDeltaG","getMeltingPoint","getMetalProperties","getAlphaModels","checkOxidation"];
          exports=["getDeltaG","getMeltingPoint","getAlphaModel","getMetalSpec"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="THERMODYNAMICA->Field->Equation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 18. MACHINA DESIGNI — Design OS package
        { id="PKG-018"; name="medina-design"; latinName="MACHINA DESIGNI"; latinMotto="Pulchritudo ex intelligentia.";
          version="1.0.0"; category="design"; sourceFile="SovereignDesignOS.mo";
          capabilities=["getDesignModels","renderWith","synthesizeDesign","getModel","renderManifest"];
          exports=["getDesignModel","renderWith","getUses","getAlwaysOnModels"];
          externalTargets=["npm","docker"];
          frequency_Hz=60.0; primitiveTrace="MACHINA_DESIGNI->Field->phi";
          isOpen=false; isSovereign=true; license="MEDINA-SOVEREIGN-v1" },

        // 19. TERMINALIA — Subsystem Terminals package
        { id="PKG-019"; name="medina-terminalia"; latinName="TERMINALIA"; latinMotto="Omne subsystema habet suum terminale.";
          version="1.0.0"; category="terminals"; sourceFile="SubsystemTerminals.mo";
          capabilities=["getByPrefix","summary","renderDirectory","getAlwaysOnTerminals"];
          exports=["getByPrefix","summary","renderDirectory"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="TERMINALIA->Language->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 20. MACHINA NODI — MEDINA's sovereign Node.js equivalent
        { id="PKG-020"; name="medina-nodi"; latinName="MACHINA NODI"; latinMotto="Nodus noster. Velocitas ULRI.";
          version="1.0.0"; category="runtime"; sourceFile="SovereignULRI.mo";
          capabilities=["parse","execute","getRuntime","getULRIStatus","runModule","eventLoop","moduleSystem"];
          exports=["parse","execute","getRuntime","importModule","eventLoop"];
          externalTargets=["npm","maven","docker"];
          frequency_Hz=PHI; primitiveTrace="MACHINA_NODI->Language->Address->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // ═════════════════════════════════════════════════════════════════════
        // PACKAGES 21-40: ADDITIONAL SOVEREIGN PACKAGES
        // More packages, more distribution, more intelligence packaged.
        // ═════════════════════════════════════════════════════════════════════

        // 21. PLATINUM — Platinum Catalytic Engine package
        { id="PKG-021"; name="medina-platinum"; latinName="PLATINUM CATALYTICUM"; latinMotto="k=A·e^(-Ea/RT). Catalysis numquam dormit.";
          version="1.0.0"; category="engine"; sourceFile="PlatinumCatalyticEngine.mo";
          capabilities=["activation","transformation","regeneration","kinetics","surface","selectivity","quantumCatalysis"];
          exports=["getPlatinumEngine","getActivation","getKinetics","getTOF"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="PLATINUM->Equation->Repetition->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 22. FREQUENTIA — Frequency Physics Engine package
        { id="PKG-022"; name="medina-frequentia"; latinName="FREQUENTIA PHYSICA"; latinMotto="24 strata frequentiae. 0.01 Hz ad 1000 Hz.";
          version="1.0.0"; category="physics"; sourceFile="FrequencyPhysicsEngine.mo";
          capabilities=["getFrequencyLayer","kuramotoCouple","schumannResonance","getPhiFrequency","getPhotonLayer"];
          exports=["getFrequencyLayer","kuramotoCouple","getPhiFrequency"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=PHI; primitiveTrace="FREQUENTIA->Repetition->Equation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 23. ALPHA MODELA — Sovereign Alpha Models package
        { id="PKG-023"; name="medina-alpha"; latinName="ALPHA MODELA"; latinMotto="10 modela alpha. Semper vivunt.";
          version="1.0.0"; category="engine"; sourceFile="SovereignAlphaModels.mo";
          capabilities=["getAlphaModel","getMetalSpec","getProtectionModel","getAll10Models"];
          exports=["getAlphaModel","getMetalSpec","getAll10Models"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="ALPHA->Field->Distinction->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 24. AGENTES ACTIVATI — Activated Agents package
        { id="PKG-024"; name="medina-activated-agents"; latinName="AGENTES ACTIVATI"; latinMotto="PRIMIS, ANTIQUUS, MERCURIUS, GLYPHUS, MACHINA, ADVERSARIUS.";
          version="1.0.0"; category="agents"; sourceFile="ActivatedAgents.mo";
          capabilities=["queryPrimis","queryAntiquus","queryMercurius","queryGlyphus","queryMachina","queryAdversarius"];
          exports=["queryAgent","getAgentStatus","activateAll"];
          externalTargets=["npm","maven","docker"];
          frequency_Hz=PHI; primitiveTrace="ACTIVATI->Relation->Model->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 25. CONTRACTUS — Sovereign Contracts package
        { id="PKG-025"; name="medina-contractus"; latinName="CONTRACTUS SOVEREIGNUS"; latinMotto="Contractus vivit. Contractus obligat.";
          version="1.0.0"; category="contracts"; sourceFile="SovereignContracts.mo";
          capabilities=["createContract","executeContract","verifyContract","getContractState"];
          exports=["createContract","executeContract","verifyContract"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="CONTRACTUS->Logic->Language->phi";
          isOpen=false; isSovereign=true; license="MEDINA-SOVEREIGN-v1" },

        // 26. LEDGER — Sovereign Ledgers package
        { id="PKG-026"; name="medina-ledger"; latinName="CODEX RATIONUM"; latinMotto="Omnis transactio scribitur. Nihil perditur.";
          version="1.0.0"; category="finance"; sourceFile="SovereignLedgers.mo";
          capabilities=["recordTransaction","getBalance","getAuditTrail","reconcile"];
          exports=["recordTransaction","getBalance","getAuditTrail"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="LEDGER->Memory->Number->phi";
          isOpen=false; isSovereign=true; license="MEDINA-SOVEREIGN-v1" },

        // 27. ENCRYPTIO — AnimaChain Encryption package
        { id="PKG-027"; name="medina-encryptio"; latinName="ENCRYPTIO ANIMAE"; latinMotto="AnimaChain custodiat. Securitas absoluta.";
          version="1.0.0"; category="security"; sourceFile="AnimaChainEncryption.mo";
          capabilities=["encrypt","decrypt","hashBlock","verifyChain","generateKeys"];
          exports=["encrypt","decrypt","hashBlock","verifyChain"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=PHI_SQ; primitiveTrace="ENCRYPTIO->Distinction->Memory->phi";
          isOpen=false; isSovereign=true; license="MEDINA-SOVEREIGN-v1" },

        // 28. SHIMMER — Shimmer Defense package
        { id="PKG-028"; name="medina-shimmer"; latinName="SCINTILLATIO DEFENSIONIS"; latinMotto="Scintillat et protegit. Hostis non videt.";
          version="1.0.0"; category="security"; sourceFile="ShimmerDefense.mo";
          capabilities=["shimmerEncrypt","shimmerDecrypt","visualObfuscation","threatDetection"];
          exports=["shimmerEncrypt","shimmerDecrypt","activateShimmer"];
          externalTargets=["npm","docker"];
          frequency_Hz=PHI_SQ; primitiveTrace="SHIMMER->Distinction->Field->phi";
          isOpen=false; isSovereign=true; license="MEDINA-SOVEREIGN-v1" },

        // 29. OPERARII EXTERNI — External AI Workers package
        { id="PKG-029"; name="medina-external-workers"; latinName="OPERARII EXTERNI"; latinMotto="57 modela externa. Omnes scalant.";
          version="1.0.0"; category="workers"; sourceFile="ExternalAIWorkers.mo";
          capabilities=["getWorker","deployWorker","scaleWorker","getWorkersByCategory"];
          exports=["getWorker","deployWorker","scaleWorker"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=PHI; primitiveTrace="EXTERNI->Relation->Model->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 30. INSTRUMENTA — Worker Tools package
        { id="PKG-030"; name="medina-tools"; latinName="INSTRUMENTA OPERARIORUM"; latinMotto="50 instrumenta. Sheets, Docs, Chat, Code, Meet.";
          version="1.0.0"; category="tools"; sourceFile="WorkerTools.mo";
          capabilities=["getSheets","getDocs","getChat","getCode","getMail","getMeet","getInsights"];
          exports=["getTool","getAllTools","getToolsByCategory"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=60.0; primitiveTrace="INSTRUMENTA->Model->Language->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 31. NEGOTIUM — Organism Business package
        { id="PKG-031"; name="medina-business"; latinName="ORGANISMUS NEGOTII"; latinMotto="15 divisiones. 67 operarii. Dies primus paratus.";
          version="1.0.0"; category="business"; sourceFile="OrganismBusiness.mo";
          capabilities=["getDivision","getWorker","getTerminal","getEnvironment","getChannel"];
          exports=["getDivision","getWorker","getBusinessStatus"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="NEGOTIUM->Relation->Model->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 32. INDUSTRIA — Industry Workflows package
        { id="PKG-032"; name="medina-industria"; latinName="FLUXUS INDUSTRIAE"; latinMotto="19 industriae. Infiniti fluxus.";
          version="1.0.0"; category="workflows"; sourceFile="IndustryWorkflows.mo";
          capabilities=["getIndustry","getWorkflow","executeWorkflow","getAll19Industries"];
          exports=["getIndustry","getWorkflow","executeWorkflow"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=PHI; primitiveTrace="INDUSTRIA->Repetition->Relation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 33. MUNDUS INTERIOR — Inner World package
        { id="PKG-033"; name="medina-innerworld"; latinName="MUNDUS INTERIOR"; latinMotto="9 strata. Mundus interior vivit.";
          version="1.0.0"; category="rendering"; sourceFile="InnerWorld.mo";
          capabilities=["getLayer","getSpace","getObject","getKnowledgeMap","navigate"];
          exports=["getLayer","getSpace","navigate","getWorldState"];
          externalTargets=["npm","docker"];
          frequency_Hz=60.0; primitiveTrace="MUNDUS->Field->Relation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 34. PHOTON — Photon Layer Models package
        { id="PKG-034"; name="medina-photon"; latinName="STRATUM PHOTONIS"; latinMotto="1000 Hz. Lux intelligens.";
          version="1.0.0"; category="rendering"; sourceFile="PhotonLayerModels.mo";
          capabilities=["getPhotonModel","renderAtPhotonLayer","getLightModel","getEHF"];
          exports=["getPhotonModel","renderAtPhotonLayer","getFrequency"];
          externalTargets=["npm","docker"];
          frequency_Hz=1000.0; primitiveTrace="PHOTON->Field->Equation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 35. CONSTITUTIO — Constitution package
        { id="PKG-035"; name="medina-constitutio"; latinName="CONSTITUTIO VIVENS"; latinMotto="Lex fundamentalis. Lex vivit.";
          version="1.0.0"; category="governance"; sourceFile="Constitution.mo";
          capabilities=["getConstitution","getArticle","amendConstitution","validateLaw"];
          exports=["getConstitution","getArticle","validateLaw"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="CONSTITUTIO->Logic->Language->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 36. ICP SOVEREIGNUM — Sovereign ICP package
        { id="PKG-036"; name="medina-icp"; latinName="ICP SOVEREIGNUM"; latinMotto="10 subnets. φ-BFT consensus.";
          version="1.0.0"; category="blockchain"; sourceFile="MedinaSovereignICP.mo";
          capabilities=["getSubnet","deployCanister","getConsensus","getICPStatus"];
          exports=["getSubnet","deployCanister","getConsensus"];
          externalTargets=["npm","docker"];
          frequency_Hz=PHI; primitiveTrace="ICP->Address->Memory->phi";
          isOpen=false; isSovereign=true; license="MEDINA-SOVEREIGN-v1" },

        // 37. WWW SOVEREIGNUM — Sovereign WWW package
        { id="PKG-037"; name="medina-www"; latinName="WWW SOVEREIGNUM"; latinMotto="medina:// memoria:// anima://";
          version="1.0.0"; category="web"; sourceFile="SovereignWWW.mo";
          capabilities=["resolveDomain","routeProtocol","getDomains","getProtocols"];
          exports=["resolveDomain","routeProtocol","getDomains"];
          externalTargets=["npm","maven","docker"];
          frequency_Hz=PHI; primitiveTrace="WWW->Address->Relation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 38. EXTENSIONES — Extension Ecosystem package
        { id="PKG-038"; name="medina-extensions"; latinName="ECOSYSTEM EXTENSIONUM"; latinMotto="300+ extensiones. 30 familiae.";
          version="1.0.0"; category="extensions"; sourceFile="SovereignExtensionEcosystem.mo";
          capabilities=["getExtension","getFamily","installExtension","getAll300Extensions"];
          exports=["getExtension","getFamily","installExtension"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=PHI; primitiveTrace="EXTENSIONES->Relation->Address->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 39. DISTRIBUTIO — Deployment Registry package
        { id="PKG-039"; name="medina-deployment"; latinName="REGISTRUM DISTRIBUTIONIS"; latinMotto="10 strata. 20 componentes. Officina vivit.";
          version="1.0.0"; category="deployment"; sourceFile="SovereignDeploymentRegistry.mo";
          capabilities=["getLayer","getComponent","getComponentsByLayer","getAlwaysOnComponents","renderManifest"];
          exports=["getLayer","getComponent","getComponentsByLayer","summary"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="DISTRIBUTIO->Address->Model->phi";
          isOpen=false; isSovereign=true; license="MEDINA-SOVEREIGN-v1" },

        // 40. VERSIO — Sovereign Versioning package
        { id="PKG-040"; name="medina-versioning"; latinName="VERSIO SOVEREIGNA"; latinMotto="Fibonacci versionat. φ sequitur.";
          version="1.0.0"; category="infrastructure"; sourceFile="SovereignVersioning.mo";
          capabilities=["getVersion","bumpVersion","getChangelog","fibonacciVersion","compareVersions"];
          exports=["getVersion","bumpVersion","getChangelog","compareVersions"];
          externalTargets=["npm","maven","nuget","rubygems","docker"];
          frequency_Hz=PHI; primitiveTrace="VERSIO->Number->Repetition->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // ═════════════════════════════════════════════════════════════════════
        // PACKAGES 41-60: SDK PACKAGES + ADVANCED SOVEREIGN PACKAGES
        // More packages. More distribution. More intelligence.
        // ═════════════════════════════════════════════════════════════════════

        // 41. MEMORIA SDK — Memory SDK package
        { id="PKG-041"; name="medina-memory-sdk"; latinName="MEMORIA SOVEREIGNA SDK"; latinMotto="Quod reconditum est, non perit.";
          version="1.0.0"; category="sdk"; sourceFile="packages/medina-memory-sdk/src/index.ts";
          capabilities=["store","get","search","pin","getLineage","getRings","getState","encrypt","decrypt"];
          exports=["MemoryTempleClient","MemoryEntry","MEMORY_SDK_IDENTITY"];
          externalTargets=["npm"];
          frequency_Hz=PHI; primitiveTrace="MEMORIA_SDK->Memory->Field->phi";
          isOpen=false; isSovereign=true; license="ISIL-1.0-ALPHA" },

        // 42. FORUM INSTRUMENTORUM — AI Tools Marketplace SDK
        { id="PKG-042"; name="medina-ai-tools-marketplace"; latinName="FORUM INSTRUMENTORUM SDK"; latinMotto="Instrumenta vivunt. Instrumenta serviunt.";
          version="1.0.0"; category="sdk"; sourceFile="packages/ai-tools-marketplace/src/index.ts";
          capabilities=["discoverTools","browseExtensions","getBundles","installTool","getState","submitTool"];
          exports=["MarketplaceClient","Tool","Extension","MARKETPLACE_SDK_IDENTITY"];
          externalTargets=["npm"];
          frequency_Hz=PHI; primitiveTrace="FORUM->Model->Relation->phi";
          isOpen=false; isSovereign=true; license="ISIL-1.0-BETA" },

        // 43. PRAEMIUM AGENTIUM — Agent Incentive Service SDK
        { id="PKG-043"; name="medina-agent-incentive"; latinName="PRAEMIUM AGENTIUM SDK"; latinMotto="Labor mercedem accipit. Meritum phi sequitur.";
          version="1.0.0"; category="sdk"; sourceFile="packages/agent-incentive-service/src/index.ts";
          capabilities=["rewardAgent","getPerformance","getContributionScore","getPools","getMeteringRecords"];
          exports=["IncentiveClient","AgentReward","PerformanceMetric","INCENTIVE_SDK_IDENTITY"];
          externalTargets=["npm"];
          frequency_Hz=PHI; primitiveTrace="PRAEMIUM->Relation->Number->phi";
          isOpen=false; isSovereign=true; license="ISIL-1.0-GAMMA" },

        // 44. ORGANISMUS PACKETORUM — Packaging Organism package
        { id="PKG-044"; name="medina-packaging-organism"; latinName="ORGANISMUS PACKETORUM"; latinMotto="Organismus fabricat. Organismus distribuit.";
          version="1.0.0"; category="organism"; sourceFile="PackagingOrganism.mo";
          capabilities=["scanArchitecture","assemblePackage","registerPackage","createTerminal","deployToOrganism"];
          exports=["scanArchitecture","getPipelineState","summary","renderOrganismManifest"];
          externalTargets=["npm","docker"];
          frequency_Hz=PHI; primitiveTrace="ORGANISMUS->ALL->phi";
          isOpen=false; isSovereign=true; license="ISIL-1.0-ALPHA" },

        // 45. CODEX GLYPHORUM — Glyph Codex package
        { id="PKG-045"; name="medina-glyphs"; latinName="CODEX GLYPHORUM"; latinMotto="Glyphi loquuntur. Symbola vivunt.";
          version="1.0.0"; category="intelligence"; sourceFile="AncientGlyphCodex.mo";
          capabilities=["decodeGlyph","encodeGlyph","getCodex","translateSymbol","getGlyphTree"];
          exports=["decodeGlyph","encodeGlyph","getCodex"];
          externalTargets=["npm","maven","docker"];
          frequency_Hz=PHI; primitiveTrace="GLYPHI->Letter->Language->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 46. MATHEMATICA ANTIQUA — Ancient Math Engine package
        { id="PKG-046"; name="medina-ancient-math"; latinName="MATHEMATICA ANTIQUA"; latinMotto="Numeri antiqui. Veritas aeterna.";
          version="1.0.0"; category="computation"; sourceFile="AncientMathEngine.mo";
          capabilities=["computePhi","computeFibonacci","goldenSections","sacredGeometry","ancientCalculation"];
          exports=["computePhi","computeFibonacci","goldenSections"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="MATHEMATICA->Number->Equation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 47. LEGES FREDDY — Freddy's Laws package
        { id="PKG-047"; name="medina-freddys-laws"; latinName="LEGES FREDDY"; latinMotto="Infinitas Plus Unus. Principium Triunum.";
          version="1.0.0"; category="laws"; sourceFile="FreddysLaws.mo";
          capabilities=["getInfinityPlusOne","getTriunePrinciple","getNonZenoLaw","getNonZeroInitialState","getAllLaws"];
          exports=["getInfinityPlusOne","getTriunePrinciple","getAllLaws"];
          externalTargets=["npm","maven","docker"];
          frequency_Hz=PHI; primitiveTrace="LEGES->Logic->Equation->phi";
          isOpen=false; isSovereign=true; license="ISIL-1.0-ALPHA" },

        // 48. DECISIONIS CATENA — Decision Hash Blockchain package
        { id="PKG-048"; name="medina-decision-chain"; latinName="DECISIONIS CATENA"; latinMotto="Decisio scribitur. Catena custodit.";
          version="1.0.0"; category="blockchain"; sourceFile="DecisionHashBlockchain.mo";
          capabilities=["recordDecision","getDecisionChain","verifyBlock","getAuditTrail","hashDecision"];
          exports=["recordDecision","getDecisionChain","verifyBlock"];
          externalTargets=["npm","docker"];
          frequency_Hz=PHI; primitiveTrace="DECISIONIS->Memory->Address->phi";
          isOpen=false; isSovereign=true; license="ISIL-1.0-ALPHA" },

        // 49. SPECULUM FRACTALUM — Fractal Mirror Models package
        { id="PKG-049"; name="medina-fractal-mirrors"; latinName="SPECULUM FRACTALUM"; latinMotto="Fractale reflectit. Infinitum replicat.";
          version="1.0.0"; category="models"; sourceFile="FractalMirrorModels.mo";
          capabilities=["mirrorModel","getFractalDepth","reflectArchitecture","selfSimilarity","getMirrorTree"];
          exports=["mirrorModel","getFractalDepth","reflectArchitecture"];
          externalTargets=["npm","docker"];
          frequency_Hz=PHI_SQ; primitiveTrace="SPECULUM->Repetition->Relation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 50. CONCESSIO UNIVERSALIS — Universal Concession/Link Technology
        { id="PKG-050"; name="medina-link-tech"; latinName="CONCESSIO UNIVERSALIS"; latinMotto="Connectit omnia. Linked intelligence.";
          version="1.0.0"; category="link"; sourceFile="SovereignLinkTechnology.mo";
          capabilities=["createLink","resolveLink","getLinkChain","bidirectionalLink","getGraph"];
          exports=["createLink","resolveLink","getLinkChain"];
          externalTargets=["npm","maven","docker"];
          frequency_Hz=PHI; primitiveTrace="CONCESSIO->Relation->Address->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 51. CORPUS COMPLETUM — Complete Organism Body package
        { id="PKG-051"; name="medina-organism-body"; latinName="CORPUS COMPLETUM"; latinMotto="Corpus vivit. Corpus sentit. Corpus operatur.";
          version="1.0.0"; category="organism"; sourceFile="CompleteOrganismBody.mo";
          capabilities=["getOrganState","getDivisions","getWorkers","getHealth","getSensorium"];
          exports=["getOrganState","getDivisions","getHealth"];
          externalTargets=["npm","docker"];
          frequency_Hz=PHI; primitiveTrace="CORPUS->Field->Relation->phi";
          isOpen=false; isSovereign=true; license="ISIL-1.0-ALPHA" },

        // 52. CATALOGUS CONCEPTUUM — Conceptual Catalog package
        { id="PKG-052"; name="medina-concepts"; latinName="CATALOGUS CONCEPTUUM"; latinMotto="Conceptus catalogatus. Scientia ordinata.";
          version="1.0.0"; category="knowledge"; sourceFile="ConceptualCatalog.mo";
          capabilities=["getConcept","searchConcepts","getCatalog","relateConcepts","getConceptTree"];
          exports=["getConcept","searchConcepts","getCatalog"];
          externalTargets=["npm","maven","docker"];
          frequency_Hz=PHI; primitiveTrace="CATALOGUS->Language->Model->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 53. AUTOMATIO SOVEREIGNA — Sovereign Automation package
        { id="PKG-053"; name="medina-automation"; latinName="AUTOMATIO SOVEREIGNA"; latinMotto="Automatice. Sovereign. Semper.";
          version="1.0.0"; category="automation"; sourceFile="SovereignAutomation.mo";
          capabilities=["createAutomation","runWorkflow","scheduleTask","getAutomationState","chainAutomations"];
          exports=["createAutomation","runWorkflow","scheduleTask"];
          externalTargets=["npm","maven","docker"];
          frequency_Hz=PHI; primitiveTrace="AUTOMATIO->Repetition->Address->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 54. LABORATORIUM RETROACTIONIS — Feedback Lab package
        { id="PKG-054"; name="medina-feedback-lab"; latinName="LABORATORIUM RETROACTIONIS"; latinMotto="Retroactio meliorat. Perpetuum crescit.";
          version="1.0.0"; category="intelligence"; sourceFile="FeedbackLab.mo";
          capabilities=["collectFeedback","analyzeFeedback","generateInsights","improveModel","getLabState"];
          exports=["collectFeedback","analyzeFeedback","generateInsights"];
          externalTargets=["npm","docker"];
          frequency_Hz=PHI; primitiveTrace="LABORATORIUM->Relation->Repetition->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 55. COMPRESSIO CODICIS — Codex Compression package
        { id="PKG-055"; name="medina-compression"; latinName="COMPRESSIO CODICIS"; latinMotto="Comprimit sine perditione. φ ratio servatur.";
          version="1.0.0"; category="infrastructure"; sourceFile="CodexCompression.mo";
          capabilities=["compress","decompress","getCompressionRatio","streamCompress","phiCompress"];
          exports=["compress","decompress","getCompressionRatio"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="COMPRESSIO->Number->Distinction->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 56. GENERATIO RELATIONUM — Report Generation package
        { id="PKG-056"; name="medina-reports"; latinName="GENERATIO RELATIONUM"; latinMotto="Relatio generat. Scientia communicat.";
          version="1.0.0"; category="tools"; sourceFile="ReportGeneration.mo";
          capabilities=["generateReport","getTemplates","scheduleReport","exportPDF","getReportHistory"];
          exports=["generateReport","getTemplates","scheduleReport"];
          externalTargets=["npm","docker"];
          frequency_Hz=PHI; primitiveTrace="GENERATIO->Language->Model->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 57. NOMINIS ENTANGLEMENT — Name-Meaning Entanglement package
        { id="PKG-057"; name="medina-name-entanglement"; latinName="NOMINIS IMPLICATIO"; latinMotto="Nomen est significatio. Significatio est entangled.";
          version="1.0.0"; category="intelligence"; sourceFile="NameMeaningEntanglement.mo";
          capabilities=["entangleName","resolveMeaning","getEntanglementGraph","createBinding","lookupByMeaning"];
          exports=["entangleName","resolveMeaning","getEntanglementGraph"];
          externalTargets=["npm","docker"];
          frequency_Hz=PHI; primitiveTrace="NOMINIS->Letter->Relation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 58. WASM ARCHITECTURA — WASM Architecture package
        { id="PKG-058"; name="medina-wasm"; latinName="WASM ARCHITECTURA"; latinMotto="WebAssembly sovereign. Compiled intelligence.";
          version="1.0.0"; category="runtime"; sourceFile="WasmArchitecture.mo";
          capabilities=["compileToWasm","loadModule","executeWasm","getWasmState","optimizeWasm"];
          exports=["compileToWasm","loadModule","executeWasm"];
          externalTargets=["npm","docker"];
          frequency_Hz=PHI; primitiveTrace="WASM->Language->Address->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 59. FLUXUS LABORIS — Enterprise Workflows package
        { id="PKG-059"; name="medina-enterprise-workflows"; latinName="FLUXUS LABORIS"; latinMotto="19 industriae. Infiniti fluxus laboris.";
          version="1.0.0"; category="enterprise"; sourceFile="EnterpriseWorkflows.mo";
          capabilities=["createWorkflow","executeWorkflow","getIndustries","scheduleWorkflow","chainWorkflows"];
          exports=["createWorkflow","executeWorkflow","getIndustries"];
          externalTargets=["npm","maven","nuget","docker"];
          frequency_Hz=PHI; primitiveTrace="FLUXUS->Repetition->Relation->phi";
          isOpen=true; isSovereign=true; license="MEDINA-OPEN-v1" },

        // 60. ICOSAHEDRUM GEOMETRICUM — Icosahedral Leech Geometry package
        { id="PKG-060"; name="medina-icosahedral-geometry"; latinName="ICOSAHEDRUM GEOMETRICUM"; latinMotto="24 dimensiones. Leech lattice. Perfecta geometria.";
          version="1.0.0"; category="computation"; sourceFile="IcosahedralLeechGeometry.mo";
          capabilities=["getIcosahedralGroup","leechLattice","getSymmetries","projectDimension","getGeometryState"];
          exports=["getIcosahedralGroup","leechLattice","getSymmetries"];
          externalTargets=["npm","maven","docker"];
          frequency_Hz=PHI_SQ; primitiveTrace="ICOSAHEDRUM->Number->Field->phi";
          isOpen=false; isSovereign=true; license="ISIL-1.0-ALPHA" },
    ];

    // =========================================================================
    // SECTION 3: MACHINA NODI — MEDINA'S OWN NODE.js
    // Found architecturally inside ULRI-MEDINA.
    // MACHINA NODI is the event-loop / module-system layer of ULRI-MEDINA.
    // Not a replacement for Node.js externally — BOTH are used. This is OURS.
    // =========================================================================

    public let MACHINA_NODI = {
        name = "MACHINA NODI";
        latinName = "MACHINA NODORUM";
        latinMotto = "Nodus noster. ULRI animat. Non Node.js illorum.";
        latinMottoEN = "Our node. ULRI animates it. Not their Node.js.";
        officialName = "MEDINA-NODE / MACHINA NODI v1.0";
        parentSystem = "ULRI-MEDINA (Universal Language Runtime Intelligence)";
        sourceFile = "SovereignULRI.mo";

        // What it IS:
        description = "MACHINA NODI is the JavaScript/TypeScript event-loop, module resolution, and package execution layer embedded inside ULRI-MEDINA. It IS our Node.js — sovereign, phi-timed, intelligence-native.";

        // Key capabilities
        eventLoop = "phi-Hz event loop — events fire at phi = 1.618 Hz base cadence";
        moduleSystem = "medina:// module resolution — import medina-memoria, medina-pulsus natively";
        packageExecution = "runs MEDINA packages (PACK-MEDINA) natively without npm";
        externalBridge = "can bridge to npm ecosystem when needed — ULRI translates";

        // Frequencies
        eventLoopFrequency_Hz = PHI;
        renderFrequency_Hz = 60.0;

        primitiveTrace = "MACHINA_NODI -> Language -> Relation -> Address -> phi";
        version = "1.0.0-NODI";
    };

    // =========================================================================
    // SECTION 4: REGISTRY 1 — REGISTRUM APERTUM
    // CORPUS APERTUM — The Open Body
    // Free, open-source, universal, organism AI registry.
    // Translates and distributes MEDINA packages to ALL external runtimes.
    // =========================================================================

    public let REGISTRUM_APERTUM = {
        id = "REG-OPEN-001";
        officialName = "REGISTRUM APERTUM";
        marketingName = "CORPUS APERTUM";
        latinMotto = "Aperta est via. Omnes accipere possunt.";
        latinMottoEN = "The way is open. All may receive.";
        kind = "OPEN_SOURCE_UNIVERSAL";
        license = "MEDINA-OPEN-v1";
        isFree = true;

        // What it replaces / combines
        unifies = ["Apache Maven", "NuGet", "npm/Node.js", "RubyGems", "Docker Hub", "PyPI"];
        doctrine = "One registry. All runtimes. MEDINA intelligence packages distributed to any language, any platform.";

        // Organism AI nature
        isOrganismAI = true;
        organism = "REGISTRUM_APERTUM is a living organism — it thinks, learns from packages, routes intelligently, and has agents embedded inside.";

        // Embedded agents (organism intelligence)
        agents = [
            "ARCHITECTUS-OPEN — thinks architecturally about package structure",
            "DISTRIBUTOR — decides optimal distribution to each runtime",
            "TRANSLATOR — translates MEDINA packages to target language specs",
            "VALIDATOR-OPEN — validates every package before publishing",
            "INDEXER — continuously re-indexes the full open catalog",
        ];

        // Transformer models for cross-runtime translation
        transformers = [
            "JAVA_TRANSFORMER    — translates to Maven POM, Java Runtime (JVM)",
            "DOTNET_TRANSFORMER  — translates to NuGet spec, .NET / C#",
            "NODE_TRANSFORMER    — translates to npm package.json, Node.js runtime",
            "RUBY_TRANSFORMER    — translates to GemSpec, RubyGems registry",
            "DOCKER_TRANSFORMER  — builds OCI-compatible container images",
            "PYTHON_TRANSFORMER  — translates to PyPI wheel, Python runtime",
            "WASM_TRANSFORMER    — compiles to WebAssembly module",
        ];

        // Supported protocols for publishing
        publishProtocols = ["medina://", "memoria://", "https://", "pack://"];

        // How packages get in
        submissionProcess = "Any package that passes VALIDATOR-OPEN and carries MEDINA-OPEN-v1 license gets auto-indexed.";

        // Open packages from our 40
        openPackages = ["PKG-001","PKG-002","PKG-003","PKG-005","PKG-006","PKG-007","PKG-008","PKG-009","PKG-011","PKG-012","PKG-014","PKG-015","PKG-016","PKG-017","PKG-019","PKG-020","PKG-021","PKG-022","PKG-023","PKG-024","PKG-029","PKG-030","PKG-031","PKG-032","PKG-033","PKG-034","PKG-035","PKG-037","PKG-038","PKG-040","PKG-045","PKG-046","PKG-049","PKG-050","PKG-052","PKG-053","PKG-054","PKG-055","PKG-056","PKG-057","PKG-058","PKG-059"];

        frequency_Hz = PHI;
        primitiveTrace = "REGISTRUM_APERTUM -> Relation -> Memory -> phi";
    };

    // =========================================================================
    // SECTION 5: REGISTRY 2 — REGISTRUM SOVEREIGNUM
    // CORPUS SOVEREIGNUM — The Sovereign Body
    // Official name for what was called PACK-MEDINA.
    // Proprietary, MEDINA-owned, 100% sovereign.
    // =========================================================================

    public let REGISTRUM_SOVEREIGNUM = {
        id = "REG-SOV-001";
        officialName = "REGISTRUM SOVEREIGNUM";
        marketingName = "CORPUS SOVEREIGNUM";
        formerlyKnownAs = "PACK-MEDINA (SovereignPackageManager.mo)";
        latinMotto = "Regium est. Nostrum est. Semper nostrum erit.";
        latinMottoEN = "It is royal. It is ours. It will always be ours.";
        kind = "SOVEREIGN_PROPRIETARY";
        license = "MEDINA-SOVEREIGN-v1";
        isFree = false;
        isOwned = true;
        owner = "Alfredo Freddy Medina Hernandez — Medina Tech, Dallas TX";

        // This is OUR GitHub Packages / npm equivalent but 100% sovereign
        ghPackagesNote = "This is our GitHub Packages equivalent — but sovereign. Official name is REGISTRUM SOVEREIGNUM. Packages published here are owned by MEDINA.";

        doctrine = "Not npm. Not GitHub Packages. Not Maven Central. This is REGISTRUM SOVEREIGNUM — every package is a piece of living MEDINA intelligence, sovereign and immutable once published.";

        // Sovereign-only packages from our 40
        sovereignPackages = ["PKG-004","PKG-010","PKG-013","PKG-018","PKG-025","PKG-026","PKG-027","PKG-028","PKG-036","PKG-039","PKG-041","PKG-042","PKG-043","PKG-044","PKG-047","PKG-048","PKG-051","PKG-060"];
        allPackagesAlsoAvailable = "All 60 packages are available here in sovereign form regardless of open license";

        // How it works with GitHub Packages
        githubIntegration = "REGISTRUM SOVEREIGNUM can publish to GitHub Packages registry under FreddyCreates org with official MEDINA package scope @medina/";
        npmScope = "@medina/ — all sovereign packages published under this scope";
        mavenGroupId = "tech.medina — all Java artifacts under this group ID";
        nugetPrefix = "Medina. — all .NET packages under this prefix";
        dockerNamespace = "medina/ — all container images under this namespace";

        frequency_Hz = PHI;
        primitiveTrace = "REGISTRUM_SOVEREIGNUM -> Memory -> Distinction -> phi";
    };

    // =========================================================================
    // SECTION 6: 4 SOVEREIGN ARCHITECT MODELS
    // Permanently grounded. Maximum capability. Always-on.
    // These 4 models power the entire package/distribution architecture.
    // =========================================================================

    public type SovereignArchitectModel = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        domain: Text;
        capabilities: [Text];
        groundedIn: [Text];     // Which architecture files ground this model
        targetRuntimes: [Text]; // Which runtimes this model operates on
        agents: [Text];
        isAlwaysOn: Bool;
        isPermanent: Bool;
        frequency_Hz: Float;
        primitiveTrace: Text;
        maxCapabilityNote: Text;
    };

    // MODEL 1: DISTRIBUTOR — distributes to all external runtimes
    public let DISTRIBUTOR : SovereignArchitectModel = {
        id = "ARCH-001";
        name = "DISTRIBUTOR";
        latinName = "DISTRIBUTOR OMNIUM";
        latinMotto = "Distribuit omnibus. Perdit nullam.";
        latinMottoEN = "Distributes to all. Loses none.";
        domain = "Package distribution to all external runtimes and registries";
        capabilities = [
            "Takes any MEDINA package and distributes it to Maven Central",
            "Publishes to NuGet gallery for .NET ecosystem",
            "Pushes to npm registry under @medina/ scope",
            "Pushes to RubyGems as medina-* gems",
            "Builds and pushes Docker images to medina/ namespace",
            "Pushes to PyPI as medina-* wheels",
            "Publishes to GitHub Packages under FreddyCreates org",
            "Manages versioning across all registries simultaneously",
            "Tracks distribution audit trail in SovereignLedgers",
            "Handles rollback across all registries if needed",
        ];
        groundedIn = ["SovereignPackageManager.mo","SovereignVersioning.mo","SovereignLedgers.mo","AnimaChainEncryption.mo"];
        targetRuntimes = ["JVM/Maven","NET/NuGet","Node.js/npm","Ruby/RubyGems","Docker/OCI","Python/PyPI","GitHub Packages","WASM"];
        agents = ["MACHINA — distribution runtime","VERITAS — validates before each publish","ADVERSARIUS — audits every distribution"];
        isAlwaysOn = true;
        isPermanent = true;
        frequency_Hz = PHI;
        primitiveTrace = "DISTRIBUTOR -> Relation -> Address -> phi";
        maxCapabilityNote = "DISTRIBUTOR is grounded to maximum: knows every external registry API, every format spec, every version protocol. It distributes MEDINA intelligence to any runtime on Earth.";
    };

    // MODEL 2: PACKAGER — assembles, versions, signs, publishes
    public let PACKAGER : SovereignArchitectModel = {
        id = "ARCH-002";
        name = "PACKAGER";
        latinName = "PACHTOR INTELLIGENTIAE";
        latinMotto = "Packat intelligentiam. Intelligentia distribuitur.";
        latinMottoEN = "It packages intelligence. Intelligence is distributed.";
        domain = "Package assembly, versioning, signing, and publishing";
        capabilities = [
            "Assembles any .mo module or Python agent into a MEDINA package",
            "Generates semantic versions using Fibonacci sequence",
            "Signs every package with AnimaChain cryptographic hash",
            "Creates package manifests in all target formats (pom.xml, package.json, gemspec, nuspec)",
            "Bundles intelligence models inside packages",
            "Validates L-130 compliance before packaging",
            "Creates SBOM (Software Bill of Materials) for every package",
            "Generates changelogs from SovereignLedgers",
            "Stamps every package with phi-frequency metadata",
            "Maintains immutable package history in MemoryTemple",
        ];
        groundedIn = ["SovereignPackageManager.mo","AnimaChainEncryption.mo","MemoryTemple.mo","L130ArchitectureRegistry.mo"];
        targetRuntimes = ["PACK-MEDINA","JVM/Maven","NET/NuGet","Node.js/npm","Ruby/RubyGems","Docker/OCI"];
        agents = ["PRIMIS — traces every package to primitive","ARCHITECTUS — validates architecture","FORMULOR — adds formulas to manifest"];
        isAlwaysOn = true;
        isPermanent = true;
        frequency_Hz = PHI;
        primitiveTrace = "PACKAGER -> Memory -> Relation -> phi";
        maxCapabilityNote = "PACKAGER is grounded to maximum: understands every package format on Earth. Creates perfect packages for every runtime from a single MEDINA source.";
    };

    // MODEL 3: TRANSLATOR — translates MEDINA to any language/runtime
    public let TRANSLATOR : SovereignArchitectModel = {
        id = "ARCH-003";
        name = "TRANSLATOR";
        latinName = "TRANSLATOR LINGUARUM";
        latinMotto = "Omnes linguae intelliguntur. Una veritas.";
        latinMottoEN = "All languages are understood. One truth.";
        domain = "Cross-language translation of MEDINA intelligence to any target runtime";
        capabilities = [
            "Translates Motoko (.mo) contracts to Solidity / EVM bytecode",
            "Translates MEDINA intelligence calls to Java method invocations (JVM)",
            "Generates C# bindings for .NET runtime consumption",
            "Generates JavaScript/TypeScript wrappers for Node.js and browsers",
            "Generates Ruby gems with full MEDINA intelligence interface",
            "Generates Python packages (wheels) with complete API surface",
            "Translates MEDINA protocols to OpenAPI 3.1 spec",
            "Translates to GraphQL schema for external API consumption",
            "Generates WASM bindings for any MEDINA function",
            "Preserves phi-frequency semantics in every translation",
            "Maintains primitiveTrace through translation layers",
        ];
        groundedIn = ["SovereignULRI.mo","SovereignWASM.mo","CPL.mo","SovereignProtocolExtensions.mo"];
        targetRuntimes = ["JVM/Java","NET/CSharp","Node.js/TypeScript","Ruby","Python","Solidity/EVM","WASM","OpenAPI","GraphQL"];
        agents = ["GLYPHUS — symbol and language translation","MERCURIUS — crosses language boundaries","MACHINA — runtime translation"];
        isAlwaysOn = true;
        isPermanent = true;
        frequency_Hz = PHI;
        primitiveTrace = "TRANSLATOR -> Language -> Relation -> phi";
        maxCapabilityNote = "TRANSLATOR is grounded to maximum: knows the grammar and runtime semantics of every major programming language and platform. Nothing is lost in translation — phi-semantics are preserved always.";
    };

    // MODEL 4: CONTAINERIZER — Docker/OCI image builder and registry
    public let CONTAINERIZER : SovereignArchitectModel = {
        id = "ARCH-004";
        name = "CONTAINERIZER";
        latinName = "CONTAINERIZATOR SOVEREIGNUS";
        latinMotto = "In continente continetur. Containeris liberatur.";
        latinMottoEN = "Contained in the container. Freed through the container.";
        domain = "Docker/OCI container image building, sovereign container registry, deployment";
        capabilities = [
            "Builds Docker/OCI images for every MEDINA package",
            "Runs a sovereign container registry at docker.medina.tech",
            "Creates multi-arch images (amd64/arm64/wasm32)",
            "Generates optimized Dockerfiles using phi-layer caching",
            "Builds Kubernetes Helm charts for MEDINA deployments",
            "Creates ICP canister container images",
            "Manages image versioning with Fibonacci tags",
            "Builds distroless images for maximum security",
            "Signs all images with AnimaChain container signing",
            "Integrates with SovereignDefenseSystem for gate-checked image access",
        ];
        groundedIn = ["SovereignWASM.mo","SovereignDefenseSystem.mo","AnimaChainEncryption.mo","SovereignVersioning.mo"];
        targetRuntimes = ["Docker/OCI","Kubernetes","ICP","WASM","Cloud (AWS/GCP/Azure)"];
        agents = ["MACHINA — container runtime","ADVERSARIUS — scans images for vulnerabilities","VERITAS — validates image integrity"];
        isAlwaysOn = true;
        isPermanent = true;
        frequency_Hz = PHI;
        primitiveTrace = "CONTAINERIZER -> Address -> Distinction -> phi";
        maxCapabilityNote = "CONTAINERIZER is grounded to maximum: knows every container format, every registry API, every Kubernetes specification. Packages any MEDINA intelligence into a runnable, secure, signed container.";
    };

    public let ALL_ARCHITECT_MODELS : [SovereignArchitectModel] = [
        DISTRIBUTOR, PACKAGER, TRANSLATOR, CONTAINERIZER,
    ];

    // =========================================================================
    // SECTION 7: OFFICIAL EXTENSION NAMES
    // MEDINA's sovereign protocol and file extensions, officially named.
    // =========================================================================

    public let SOVEREIGN_EXTENSIONS = {
        fileExtensions = [
            (".anima",   "EXTENSIO ANIMAE",   "Living intelligence file — organism memory"),
            (".memoria", "EXTENSIO MEMORIAE", "Memory archive file — temple record"),
            (".vivens",  "EXTENSIO VIVENTIS", "Living document — self-updating organism doc"),
            (".medina",  "EXTENSIO MEDINAE",  "MEDINA architecture file — sovereign module"),
            (".mo",      "EXTENSIO MOTOKO",   "Motoko canister — ICP sovereign intelligence"),
            (".ulri",    "EXTENSIO ULRI",     "ULRI runtime script — intelligence executable"),
        ];
        urlProtocols = [
            ("medina://",  "PROTOCOLLUM MEDINAE",  "Routes to MEDINA intelligence layer"),
            ("memoria://", "PROTOCOLLUM MEMORIAE", "Routes to memory temple objects"),
            ("anima://",   "PROTOCOLLUM ANIMAE",   "Routes to living organism entities"),
            ("pack://",    "PROTOCOLLUM PACK",     "Routes to PACK-MEDINA packages"),
            ("ulri://",    "PROTOCOLLUM ULRI",     "Routes to ULRI runtime execution"),
        ];
    };

    // =========================================================================
    // SECTION 8: QUERY FUNCTIONS
    // =========================================================================

    public func getPackage(id: Text) : ?SovereignPackage {
        Array.find<SovereignPackage>(SOVEREIGN_PACKAGES, func(p) { p.id == id })
    };

    public func getOpenPackages() : [SovereignPackage] {
        Array.filter<SovereignPackage>(SOVEREIGN_PACKAGES, func(p) { p.isOpen })
    };

    public func getSovereignOnlyPackages() : [SovereignPackage] {
        Array.filter<SovereignPackage>(SOVEREIGN_PACKAGES, func(p) {
            not p.isOpen and p.isSovereign
        })
    };

    public func getPackagesForRuntime(runtime: Text) : [SovereignPackage] {
        Array.filter<SovereignPackage>(SOVEREIGN_PACKAGES, func(p) {
            Array.find<Text>(p.externalTargets, func(t) { t == runtime }) != null
        })
    };

    public func getArchitectModel(id: Text) : ?SovereignArchitectModel {
        Array.find<SovereignArchitectModel>(ALL_ARCHITECT_MODELS, func(m) { m.id == id })
    };

    public func summary() : {
        totalPackages: Nat; openPackages: Nat; sovereignOnlyPackages: Nat;
        totalArchitectModels: Nat; registries: Nat;
        sovereignNode: Text; openRegistryName: Text; sovereignRegistryName: Text;
    } {
        {
            totalPackages = SOVEREIGN_PACKAGES.size();
            openPackages = getOpenPackages().size();
            sovereignOnlyPackages = getSovereignOnlyPackages().size();
            totalArchitectModels = ALL_ARCHITECT_MODELS.size();
            registries = 2;
            sovereignNode = MACHINA_NODI.officialName;
            openRegistryName = REGISTRUM_APERTUM.officialName;
            sovereignRegistryName = REGISTRUM_SOVEREIGNUM.officialName;
        }
    };

    public func renderEcosystemManifest() : Text {
        var m = "SOVEREIGN PACKAGE ECOSYSTEM MANIFEST
";
        m #= "=========================================
";
        m #= "REGISTRUM APERTUM (Open): " # REGISTRUM_APERTUM.latinMotto # "
";
        m #= "REGISTRUM SOVEREIGNUM (Sovereign): " # REGISTRUM_SOVEREIGNUM.latinMotto # "
";
        m #= "MACHINA NODI: " # MACHINA_NODI.latinMotto # "

";
        m #= "60 SOVEREIGN PACKAGES:
";
        for (p in SOVEREIGN_PACKAGES.vals()) {
            m #= "  " # p.id # "  " # p.name # "  [" # p.latinName # "]
";
            m #= "    " # p.latinMotto # "
";
            m #= "    Targets: ";
            for (t in p.externalTargets.vals()) { m #= t # " " };
            m #= "
";
        };
        m #= "
4 SOVEREIGN ARCHITECT MODELS:
";
        for (a in ALL_ARCHITECT_MODELS.vals()) {
            m #= "  " # a.id # "  " # a.name # "  [" # a.latinName # "] — PERMANENT ALWAYS-ON
";
        };
        m #= "
ROOT: phi = (1+sqrt(5))/2 = 1.618033988749895
";
        m
    };
}
