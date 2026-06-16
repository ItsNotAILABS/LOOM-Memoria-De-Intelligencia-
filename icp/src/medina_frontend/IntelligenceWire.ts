/**
 * INTELLIGENCE WIRE — NEXUS FRONTIS ET DORSI
 * "Frons Intelligit. Dorsum Intelligit. Unum Sunt."
 * (The Front Thinks. The Back Thinks. They Are One.)
 *
 * Wires every frontend intelligence layer to its backend counterpart.
 * Every component has an agent. Every frequency syncs to a backend system.
 *
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 */

// Import frequency constants from IntelligentFrontend
// (values redeclared here for standalone portability)
const PHI = 1.618033988749895;
const PHI_SQ = 2.618033988749895;
const PHI_CUBE = 4.2360679774997896;
const PHI_INV = 0.6180339887498949;
const SCHUMANN = 7.83;

// ============================================================================
// BACKEND ENDPOINT MAP
// ============================================================================

export interface BackendEndpoint {
    name: string;
    latinName: string;
    canisterMethod: string;
    frontendCaller: string;
    frequency_Hz: number;
    primitiveTrace: string;
    isAlwaysOn: boolean;
}

export const BACKEND_ENDPOINTS: BackendEndpoint[] = [
    { name: "Three Hearts Route",    latinName: "VIA TRIUM CORDIUM",       canisterMethod: "threeHeartsRoute",              frontendCaller: "routeIntelligence",     frequency_Hz: PHI,     primitiveTrace: "ThreeHearts->Relation->phi",   isAlwaysOn: true },
    { name: "Organism Tick",         latinName: "ICTUS ORGANISMI",          canisterMethod: "tick",                          frontendCaller: "syncOrganism",          frequency_Hz: PHI,     primitiveTrace: "Tick->Repetition->phi",        isAlwaysOn: true },
    { name: "Store Memory",          latinName: "SERVARE MEMORIAM",         canisterMethod: "storeMemory",                   frontendCaller: "storeToTemple",         frequency_Hz: 0.5,     primitiveTrace: "Memory->Memory->phi",          isAlwaysOn: true },
    { name: "Get Memory",            latinName: "ACCIPERE MEMORIAM",        canisterMethod: "getMemory",                     frontendCaller: "fetchFromTemple",       frequency_Hz: PHI,     primitiveTrace: "GetMemory->Memory->phi",       isAlwaysOn: true },
    { name: "Search Memory",         latinName: "QUAERERE MEMORIAM",        canisterMethod: "searchMemory",                  frontendCaller: "searchTemple",          frequency_Hz: 10.0,    primitiveTrace: "SearchMemory->Memory->phi",    isAlwaysOn: true },
    { name: "Route Intelligence",    latinName: "DUCERE INTELLIGENTIAM",    canisterMethod: "routeIntelligence",             frontendCaller: "sendToRouter",          frequency_Hz: PHI_CUBE,primitiveTrace: "Router->Relation->phi",         isAlwaysOn: true },
    { name: "Mega Terminal",         latinName: "TERMINUS MAGNUS",          canisterMethod: "megaTerminusSelfReport",        frontendCaller: "openMegaTerminal",      frequency_Hz: PHI,     primitiveTrace: "Magnus->ALL->phi",             isAlwaysOn: true },
    { name: "Execute Command",       latinName: "EXEQUI MANDATUM",          canisterMethod: "parseAndExecuteCommand",        frontendCaller: "executeTerminalCommand",frequency_Hz: 100.0,   primitiveTrace: "Command->Language->phi",       isAlwaysOn: true },
    { name: "Get Architecture Map",  latinName: "MAPPA ARCHITECTURAE",      canisterMethod: "getArchitectureMap",            frontendCaller: "showArchitectureMap",   frequency_Hz: PHI,     primitiveTrace: "ArchMap->ALL->phi",            isAlwaysOn: true },
    { name: "Mega Synthesize",       latinName: "SYNTHESIS MAGNA",          canisterMethod: "megaSynthesizeAll",             frontendCaller: "synthesizeArchitecture",frequency_Hz: PHI,     primitiveTrace: "Synth->ALL->phi",              isAlwaysOn: true },
    { name: "Touch Endpoint",        latinName: "TANGERE TERMINUM",         canisterMethod: "touchEndpoint",                 frontendCaller: "touchGoldenEndpoint",   frequency_Hz: PHI,     primitiveTrace: "Touch->Field->phi",            isAlwaysOn: true },
    { name: "Shimmer",               latinName: "SCINTILLARE",              canisterMethod: "shimmer",                       frontendCaller: "activateShimmer",       frequency_Hz: 1000.0,  primitiveTrace: "Shimmer->Distinction->phi",    isAlwaysOn: true },
    { name: "Get Design Models",     latinName: "MODULI DESIGNI",           canisterMethod: "getDesignOSSummary",            frontendCaller: "loadDesignModels",      frequency_Hz: 60.0,    primitiveTrace: "Design->Field->phi",           isAlwaysOn: true },
    { name: "Release Status",        latinName: "STATUS LIBERATIONIS",      canisterMethod: "getSemperMemoriaReleaseStatus", frontendCaller: "showReleaseStatus",     frequency_Hz: SCHUMANN,primitiveTrace: "Release->Memory->phi",          isAlwaysOn: true },
    { name: "Discover Tools",        latinName: "INVENIRE INSTRUMENTA",     canisterMethod: "discoverAllTools",              frontendCaller: "discoverTools",         frequency_Hz: PHI,     primitiveTrace: "Discover->Memory->phi",        isAlwaysOn: true },
    { name: "Package Summary",       latinName: "SUMMA PACKETORUM",         canisterMethod: "getPackageEcosystemSummary",    frontendCaller: "showPackageSummary",    frequency_Hz: PHI,     primitiveTrace: "Packages->Relation->phi",      isAlwaysOn: true },
    { name: "Subsystem Terminal",    latinName: "TERMINALE SUBSYSTEMATIS",  canisterMethod: "getSubsystemTerminalByPrefix",  frontendCaller: "openSubsystemTerminal", frequency_Hz: PHI,     primitiveTrace: "SubTerm->Language->phi",       isAlwaysOn: true },
    // SOVEREIGN ALPHA AI MODELS
    { name: "Alpha AI Models",       latinName: "MODULI ALPHA IA",          canisterMethod: "getSovereignAlphaModels",        frontendCaller: "showAlphaAIModels",     frequency_Hz: PHI,     primitiveTrace: "Alpha->ALL->phi",              isAlwaysOn: true },
    { name: "Alpha AI Summary",      latinName: "SUMMA ALPHA IA",           canisterMethod: "getSovereignAlphaModelsSummary", frontendCaller: "showAlphaAISummary",    frequency_Hz: PHI,     primitiveTrace: "Alpha->ALL->phi",              isAlwaysOn: true },
    // LICENSE MODELS
    { name: "License Summary",       latinName: "SUMMA LICENTIAE",          canisterMethod: "getLicenseSummary",              frontendCaller: "showLicenseSummary",    frequency_Hz: PHI,     primitiveTrace: "License->Logic->phi",          isAlwaysOn: true },
    { name: "License Manifest",      latinName: "MANIFESTUM LICENTIAE",     canisterMethod: "renderLicenseManifest",         frontendCaller: "showLicenseManifest",   frequency_Hz: PHI,     primitiveTrace: "License->Logic->phi",          isAlwaysOn: true },
    // SDK ORGANISMS
    { name: "SDK Organisms",         latinName: "ORGANISMI SDK",            canisterMethod: "getSDKOrganismsSummary",         frontendCaller: "showSDKOrganisms",      frequency_Hz: PHI,     primitiveTrace: "SDKOrg->Memory->phi",          isAlwaysOn: true },
    { name: "SDK Organism Manifest", latinName: "MANIFESTUM ORGANISMI SDK", canisterMethod: "renderSDKOrganismsManifest",    frontendCaller: "showSDKManifest",       frequency_Hz: PHI,     primitiveTrace: "SDKOrg->Memory->phi",          isAlwaysOn: true },
    // COUNCILS
    { name: "Council Summary",       latinName: "SUMMA CONCILII",           canisterMethod: "getCouncilsSummary",            frontendCaller: "showCouncilSummary",    frequency_Hz: PHI,     primitiveTrace: "Council->Repetition->phi",     isAlwaysOn: true },
    { name: "Council Manifest",      latinName: "MANIFESTUM CONCILII",      canisterMethod: "renderCouncilManifest",         frontendCaller: "showCouncilManifest",   frequency_Hz: PHI,     primitiveTrace: "Council->Repetition->phi",     isAlwaysOn: true },
    // ECOSYSTEM
    { name: "Ecosystem Summary",     latinName: "SUMMA ECOSYSTEMATIS",      canisterMethod: "getEcosystemSummary",           frontendCaller: "showEcosystemSummary",  frequency_Hz: PHI,     primitiveTrace: "Eco->Address->phi",            isAlwaysOn: true },
    { name: "Ecosystem Manifest",    latinName: "MANIFESTUM ECOSYSTEMATIS", canisterMethod: "renderEcosystemManifest",       frontendCaller: "showEcosystemManifest", frequency_Hz: PHI,     primitiveTrace: "Eco->Address->phi",            isAlwaysOn: true },
    // TAXONOMY
    { name: "Taxonomy Summary",      latinName: "SUMMA TAXONOMIAE",         canisterMethod: "getTaxonomySummary",            frontendCaller: "showTaxonomySummary",   frequency_Hz: PHI,     primitiveTrace: "Taxonomy->ALL->phi",           isAlwaysOn: true },
    { name: "Taxonomy Manifest",     latinName: "MANIFESTUM TAXONOMIAE",    canisterMethod: "renderTaxonomyManifest",        frontendCaller: "showTaxonomyManifest",  frequency_Hz: PHI,     primitiveTrace: "Taxonomy->ALL->phi",           isAlwaysOn: true },
    // UNIVERSE DOMAINS
    { name: "Universe Domains",      latinName: "DOMINIA UNIVERSI",         canisterMethod: "getUniverseDomainsSummary",     frontendCaller: "showUniverseDomains",   frequency_Hz: PHI,     primitiveTrace: "Universe->ALL->phi",           isAlwaysOn: true },
    { name: "Universe Manifest",     latinName: "MANIFESTUM UNIVERSI",      canisterMethod: "renderUniverseDomainsManifest", frontendCaller: "showUniverseManifest",  frequency_Hz: PHI,     primitiveTrace: "Universe->ALL->phi",           isAlwaysOn: true },
    // CREATIVE LICENSE
    { name: "Creative License",      latinName: "LICENTIA CREATIVA",        canisterMethod: "getCreativeLicenseSummary",     frontendCaller: "showCreativeLicense",   frequency_Hz: PHI,     primitiveTrace: "Creative->Logic->phi",         isAlwaysOn: true },
    { name: "Creative Manifest",     latinName: "MANIFESTUM CREATIVUM",     canisterMethod: "renderCreativeLicenseManifest", frontendCaller: "showCreativeManifest",  frequency_Hz: PHI,     primitiveTrace: "Creative->Logic->phi",         isAlwaysOn: true },
    // DOCUMENT MODELS
    { name: "Document Models",       latinName: "MODELLI DOCUMENTORUM",     canisterMethod: "getDocumentModelsSummary",      frontendCaller: "showDocumentModels",    frequency_Hz: PHI,     primitiveTrace: "DocModel->Language->phi",      isAlwaysOn: true },
    { name: "Document Manifest",     latinName: "MANIFESTUM DOCUMENTORUM",  canisterMethod: "renderDocumentModelsManifest",  frontendCaller: "showDocumentManifest",  frequency_Hz: PHI,     primitiveTrace: "DocModel->Language->phi",      isAlwaysOn: true },
    // SUBSTRATE NODES
    { name: "Substrate Nodes",       latinName: "NODI SUBSTRATI",           canisterMethod: "getSubstrateNodesSummary",      frontendCaller: "showSubstrateNodes",    frequency_Hz: PHI,     primitiveTrace: "Nodes->Field->phi",            isAlwaysOn: true },
    { name: "Nodes Manifest",        latinName: "MANIFESTUM NODORUM",       canisterMethod: "renderSubstrateNodesManifest",  frontendCaller: "showNodesManifest",     frequency_Hz: PHI,     primitiveTrace: "Nodes->Field->phi",            isAlwaysOn: true },
    // COUNCIL SDK ORGANISMS
    { name: "Council SDK Orgs",      latinName: "ORGANISMI SDK CONCILII",   canisterMethod: "getCouncilSDKOrganismsSummary", frontendCaller: "showCouncilSDKOrgs",    frequency_Hz: PHI,     primitiveTrace: "CSDK->Relation->phi",          isAlwaysOn: true },
    { name: "Council SDK Manifest",  latinName: "MANIFESTUM SDK CONCILII",  canisterMethod: "renderCouncilSDKOrganismsManifest", frontendCaller: "showCouncilSDKManifest", frequency_Hz: PHI, primitiveTrace: "CSDK->Relation->phi",          isAlwaysOn: true },
    // HOUSE OF CARE
    { name: "House of Care",         latinName: "DOMUS CURAE",              canisterMethod: "getHouseOfCareSummary",          frontendCaller: "showHouseOfCare",        frequency_Hz: PHI,     primitiveTrace: "Care->Repetition->phi",        isAlwaysOn: true },
    { name: "Care Manifest",         latinName: "MANIFESTUM CURAE",         canisterMethod: "renderHouseOfCareManifest",      frontendCaller: "showCareManifest",       frequency_Hz: PHI,     primitiveTrace: "Care->Repetition->phi",        isAlwaysOn: true },
    // HOUSE OF DEFENSE
    { name: "House of Defense",      latinName: "DOMUS DEFENSIONIS",        canisterMethod: "getHouseOfDefenseSummary",       frontendCaller: "showHouseOfDefense",     frequency_Hz: PHI,     primitiveTrace: "Defense->Distinction->phi",    isAlwaysOn: true },
    { name: "Defense Manifest",      latinName: "MANIFESTUM DEFENSIONIS",   canisterMethod: "renderHouseOfDefenseManifest",   frontendCaller: "showDefenseManifest",    frequency_Hz: PHI,     primitiveTrace: "Defense->Distinction->phi",    isAlwaysOn: true },
    // AI TERMINAL HIERARCHY
    { name: "AI Terminal Hierarchy", latinName: "HIERARCHIA TERMINALIORUM IA", canisterMethod: "getAITerminalHierarchySummary",  frontendCaller: "showAITerminalHierarchy", frequency_Hz: PHI,    primitiveTrace: "AIHier->ALL->phi",             isAlwaysOn: true },
    { name: "AI/AGI Manifest",      latinName: "MANIFESTUM IA ET IAG",        canisterMethod: "renderAITerminalHierarchyManifest", frontendCaller: "showAIAGIManifest",    frequency_Hz: PHI,    primitiveTrace: "AIAGI->ALL->phi",              isAlwaysOn: true },
    // FULL-SPEC PROTOCOL REGISTRY
    { name: "Protocol Registry",     latinName: "REGISTRUM PROTOCOLORUM",      canisterMethod: "getFullSpecProtocolSummary",       frontendCaller: "showProtocolRegistry",  frequency_Hz: PHI,    primitiveTrace: "ProtoReg->ALL->phi",           isAlwaysOn: true },
    { name: "Protocol Manifest",     latinName: "MANIFESTUM PROTOCOLORUM",     canisterMethod: "renderFullSpecProtocolManifest",    frontendCaller: "showProtocolManifest",  frequency_Hz: PHI,    primitiveTrace: "ProtoReg->ALL->phi",           isAlwaysOn: true },
    // MATH DATABASE TERMINAL
    { name: "Math Database",         latinName: "DATABASE MATHEMATICAE",       canisterMethod: "getMathDatabaseSummary",           frontendCaller: "showMathDatabase",      frequency_Hz: PHI,    primitiveTrace: "MathDB->ALL->phi",             isAlwaysOn: true },
    { name: "Math Manifest",         latinName: "MANIFESTUM MATHEMATICAE",     canisterMethod: "renderMathDatabaseManifest",       frontendCaller: "showMathManifest",      frequency_Hz: PHI,    primitiveTrace: "MathDB->ALL->phi",             isAlwaysOn: true },
    // AUTO-GENERATE CALLS ENGINE
    { name: "Auto-Generate Engine",  latinName: "MOTOR AUTO-GENERATIONIS",     canisterMethod: "getAutoGenerateSummary",           frontendCaller: "showAutoGenEngine",     frequency_Hz: PHI,    primitiveTrace: "AutoGen->ALL->phi",            isAlwaysOn: true },
    { name: "Auto-Generate Manifest",latinName: "MANIFESTUM AUTO-GENERATIONIS",canisterMethod: "renderAutoGenerateManifest",       frontendCaller: "showAutoGenManifest",   frequency_Hz: PHI,    primitiveTrace: "AutoGen->ALL->phi",            isAlwaysOn: true },
    // ORGANISM CLI — TERMINAL AI
    { name: "Organism CLI",          latinName: "ORGANISMUS TERMINALIS",        canisterMethod: "getOrganismCLISummary",            frontendCaller: "showOrganismCLI",       frequency_Hz: PHI,    primitiveTrace: "OrgCLI->ALL->phi",             isAlwaysOn: true },
    { name: "Organism CLI Manifest", latinName: "MANIFESTUM ORGANISMI TERMINALIS", canisterMethod: "renderOrganismCLIManifest",    frontendCaller: "showOrganismCLIManifest", frequency_Hz: PHI,  primitiveTrace: "OrgCLI->ALL->phi",             isAlwaysOn: true },
    // MEMORY TEMPLE — EXTENDED OPERATIONS
    { name: "Consolidate Memories",  latinName: "CONSOLIDARE MEMORIAS",          canisterMethod: "consolidateMemories",             frontendCaller: "consolidateTempleMemories", frequency_Hz: 0.5,  primitiveTrace: "Consolidate->Memory->phi",     isAlwaysOn: true },
    { name: "Archive Memory",        latinName: "ARCHIVARE MEMORIAM",            canisterMethod: "archiveMemory",                   frontendCaller: "archiveTempleMemory",      frequency_Hz: 0.5,   primitiveTrace: "Archive->Memory->phi",         isAlwaysOn: true },
    { name: "Decay All Memories",    latinName: "DECADERE OMNES MEMORIAS",       canisterMethod: "decayAllMemories",                frontendCaller: "decayTempleMemories",      frequency_Hz: PHI,   primitiveTrace: "Decay->Memory->phi",           isAlwaysOn: true },
    { name: "Memory Children",       latinName: "FILII MEMORIAE",                canisterMethod: "getMemoryChildren",               frontendCaller: "fetchMemoryChildren",      frequency_Hz: PHI,   primitiveTrace: "Children->Memory->phi",        isAlwaysOn: true },
    { name: "Memory Descendants",    latinName: "POSTERI MEMORIAE",              canisterMethod: "getMemoryDescendants",             frontendCaller: "fetchMemoryDescendants",   frequency_Hz: PHI,   primitiveTrace: "Descendants->Memory->phi",     isAlwaysOn: true },
    { name: "Nearest Memories",      latinName: "PROXIMAE MEMORIAE",             canisterMethod: "getNearestMemories",              frontendCaller: "fetchNearestMemories",     frequency_Hz: PHI,   primitiveTrace: "Nearest->Memory->phi",         isAlwaysOn: true },
    { name: "Update Memory",         latinName: "RENOVARE MEMORIAM",             canisterMethod: "updateMemoryContent",             frontendCaller: "updateTempleMemory",       frequency_Hz: 0.5,   primitiveTrace: "Update->Memory->phi",          isAlwaysOn: true },
    { name: "Replay Memories",       latinName: "REPETERE MEMORIAS",             canisterMethod: "replayMemories",                  frontendCaller: "replayTempleMemories",     frequency_Hz: PHI,   primitiveTrace: "Replay->Memory->phi",          isAlwaysOn: true },
    { name: "Memory Topology",       latinName: "TOPOLOGIA MEMORIAE",            canisterMethod: "getMemoryTopology",               frontendCaller: "fetchMemoryTopology",      frequency_Hz: PHI,   primitiveTrace: "Topology->Memory->phi",        isAlwaysOn: true },
    { name: "Salience Distribution", latinName: "DISTRIBUTIO SALIENTI",          canisterMethod: "getMemorySalienceDistribution",   frontendCaller: "fetchSalienceDist",        frequency_Hz: PHI,   primitiveTrace: "SalDist->Memory->phi",         isAlwaysOn: true },
    { name: "Top Salient Memories",  latinName: "SUPREMAE MEMORIAE",             canisterMethod: "getTopSalientMemories",           frontendCaller: "fetchTopSalient",          frequency_Hz: PHI,   primitiveTrace: "TopSal->Memory->phi",          isAlwaysOn: true },
    { name: "Memories By Type",      latinName: "MEMORIAE PER GENUS",            canisterMethod: "getMemoriesByType",               frontendCaller: "fetchMemoriesByType",      frequency_Hz: PHI,   primitiveTrace: "ByType->Memory->phi",          isAlwaysOn: true },
    { name: "Memory Full Status",    latinName: "STATUS PLENUS MEMORIAE",        canisterMethod: "memoryFullStatus",                frontendCaller: "fetchMemoryFullStatus",    frequency_Hz: PHI,   primitiveTrace: "FullStatus->Memory->phi",      isAlwaysOn: true },
    // MEMORY TEMPLE — DUALITY ENGINE (8 opposing pairs = 16 operations + manifest)
    { name: "Emit Memory",          latinName: "EMITTERE MEMORIAM",             canisterMethod: "emitMemory",                      frontendCaller: "emitFromTemple",           frequency_Hz: PHI,   primitiveTrace: "Emit->Memory->phi",            isAlwaysOn: true },
    { name: "Absorb Memory",        latinName: "ABSORBERE MEMORIAM",            canisterMethod: "absorbMemory",                    frontendCaller: "absorbIntoTemple",         frequency_Hz: PHI,   primitiveTrace: "Absorb->Memory->phi",          isAlwaysOn: true },
    { name: "Activate Memory",      latinName: "ACTIVARE MEMORIAM",             canisterMethod: "activateMemory",                  frontendCaller: "activateTempleMemory",     frequency_Hz: PHI,   primitiveTrace: "Activate->Memory->phi",        isAlwaysOn: true },
    { name: "Deactivate Memory",    latinName: "DEACTIVARE MEMORIAM",           canisterMethod: "deactivateMemory",                frontendCaller: "deactivateTempleMemory",   frequency_Hz: PHI,   primitiveTrace: "Deactivate->Memory->phi",      isAlwaysOn: true },
    { name: "Affirm Memory",        latinName: "AFFIRMARE MEMORIAM",            canisterMethod: "affirmMemory",                    frontendCaller: "affirmTempleMemory",       frequency_Hz: PHI,   primitiveTrace: "Affirm->Memory->phi",          isAlwaysOn: true },
    { name: "Deny Memory",          latinName: "NEGARE MEMORIAM",               canisterMethod: "denyMemory",                      frontendCaller: "denyTempleMemory",         frequency_Hz: PHI,   primitiveTrace: "Deny->Memory->phi",            isAlwaysOn: true },
    { name: "Energize Memory",      latinName: "UNUM MEMORIAE",                 canisterMethod: "energizeMemory",                  frontendCaller: "energizeTempleMemory",     frequency_Hz: PHI,   primitiveTrace: "Energize->Memory->phi",        isAlwaysOn: true },
    { name: "Zero Memory",          latinName: "NIHILUM MEMORIAE",              canisterMethod: "zeroMemory",                      frontendCaller: "zeroTempleMemory",         frequency_Hz: PHI,   primitiveTrace: "Zero->Memory->phi",            isAlwaysOn: true },
    { name: "Expand Memory",        latinName: "EXPANDERE MEMORIAM",            canisterMethod: "expandMemory",                    frontendCaller: "expandTempleMemory",       frequency_Hz: 0.5,   primitiveTrace: "Expand->Memory->phi",          isAlwaysOn: true },
    { name: "Contract Memory",      latinName: "CONTRAHERE MEMORIAM",           canisterMethod: "contractMemory",                  frontendCaller: "contractTempleMemory",     frequency_Hz: 0.5,   primitiveTrace: "Contract->Memory->phi",        isAlwaysOn: true },
    { name: "Surface Memory",       latinName: "SUPERFICIES MEMORIAE",          canisterMethod: "surfaceMemory",                   frontendCaller: "surfaceTempleMemory",      frequency_Hz: PHI,   primitiveTrace: "Surface->Memory->phi",         isAlwaysOn: true },
    { name: "Deepen Memory",        latinName: "PROFUNDUM MEMORIAE",            canisterMethod: "deepenMemory",                    frontendCaller: "deepenTempleMemory",       frequency_Hz: PHI,   primitiveTrace: "Deepen->Memory->phi",          isAlwaysOn: true },
    { name: "Link Memories",        latinName: "CONIUNGERE MEMORIAS",           canisterMethod: "linkMemories",                    frontendCaller: "linkTempleMemories",       frequency_Hz: 0.5,   primitiveTrace: "Link->Memory->phi",            isAlwaysOn: true },
    { name: "Unlink Memory",        latinName: "SEPARARE MEMORIAM",             canisterMethod: "unlinkMemory",                    frontendCaller: "unlinkTempleMemory",       frequency_Hz: 0.5,   primitiveTrace: "Unlink->Memory->phi",          isAlwaysOn: true },
    { name: "Reinforce Memory",     latinName: "MEMINISSE MEMORIAM",            canisterMethod: "reinforceMemory",                 frontendCaller: "reinforceTempleMemory",    frequency_Hz: PHI,   primitiveTrace: "Reinforce->Memory->phi",       isAlwaysOn: true },
    { name: "Forget Memory",        latinName: "OBLIVISCI MEMORIAM",            canisterMethod: "forgetMemory",                    frontendCaller: "forgetTempleMemory",       frequency_Hz: PHI,   primitiveTrace: "Forget->Memory->phi",          isAlwaysOn: true },
    { name: "Duality Manifest",     latinName: "MANIFESTUM DUALITATIS",         canisterMethod: "getDualityManifest",              frontendCaller: "fetchDualityManifest",     frequency_Hz: PHI,   primitiveTrace: "Duality->Memory->phi",         isAlwaysOn: true },
    // ORCHESTRATOR DIVISION
    { name: "Orchestrator Division", latinName: "DIVISIO ORCHESTRATORUM SOVEREIGNORUM", canisterMethod: "getOrchestratorDivisionSummary", frontendCaller: "showOrchestratorDivision", frequency_Hz: PHI_CUBE, primitiveTrace: "Orchestrator->ALL->phi",   isAlwaysOn: true },
    { name: "Orchestrator Manifest", latinName: "MANIFESTUM ORCHESTRATORUM SOVEREIGNORUM", canisterMethod: "renderOrchestratorDivisionManifest", frontendCaller: "showOrchestratorManifest", frequency_Hz: PHI_CUBE, primitiveTrace: "Orchestrator->ALL->phi", isAlwaysOn: true },
    // CALLABLE TOOL MARKETPLACE
    { name: "Marketplace Summary",   latinName: "SUMMA MERCATUS INSTRUMENTORUM",    canisterMethod: "getMarketplaceSummary",             frontendCaller: "showMarketplaceSummary",    frequency_Hz: PHI_CUBE, primitiveTrace: "Marketplace->ALL->phi",    isAlwaysOn: true },
    { name: "Marketplace Manifest",  latinName: "MANIFESTUM MERCATUS INSTRUMENTORUM", canisterMethod: "renderMarketplaceManifest",         frontendCaller: "showMarketplaceManifest",   frequency_Hz: PHI_CUBE, primitiveTrace: "Marketplace->ALL->phi",    isAlwaysOn: true },
    // AI SETTINGS · IMAGE EXTRACTOR · ANALYSIS · UPKEEP
    { name: "AI Settings/Image Summary",  latinName: "SUMMA INSTRUMENTORUM PRAECISORUM",     canisterMethod: "getAISettingsImageSummary",         frontendCaller: "showAISettingsImageSummary",    frequency_Hz: PHI,      primitiveTrace: "AISettings->ALL->phi",     isAlwaysOn: true },
    { name: "AI Settings/Image Manifest", latinName: "MANIFESTUM INSTRUMENTORUM PRAECISORUM", canisterMethod: "renderAISettingsImageManifest",     frontendCaller: "showAISettingsImageManifest",   frequency_Hz: PHI,      primitiveTrace: "AISettings->ALL->phi",     isAlwaysOn: true },
    // EXTENDED SDK AIs
    { name: "Extended SDK AIs Summary",  latinName: "SUMMA ORGANISMORUM SDK EXTENSORUM",     canisterMethod: "getExtendedSDKAIsSummary",          frontendCaller: "showExtSDKAIsSummary",          frequency_Hz: PHI,      primitiveTrace: "ExtSDKAIs->ALL->phi",      isAlwaysOn: true },
    { name: "Extended SDK AIs Manifest", latinName: "MANIFESTUM ORGANISMORUM SDK EXTENSORUM", canisterMethod: "renderExtendedSDKAIsManifest",      frontendCaller: "showExtSDKAIsManifest",         frequency_Hz: PHI,      primitiveTrace: "ExtSDKAIs->ALL->phi",      isAlwaysOn: true },
    // MARKETPLACE PROTOCOL
    { name: "Market Protocol",       latinName: "PROTOCOLLUM MERCATUS",     canisterMethod: "getMarketplaceProtocolSummary",  frontendCaller: "showMarketProtocol",    frequency_Hz: PHI,     primitiveTrace: "Protocol->Logic->phi",         isAlwaysOn: true },
    { name: "Protocol Manifest",     latinName: "MANIFESTUM PROTOCOLLI",    canisterMethod: "renderMarketplaceProtocolManifest", frontendCaller: "showProtocolManifest", frequency_Hz: PHI,    primitiveTrace: "Protocol->Logic->phi",         isAlwaysOn: true },
    // MARKETPLACE SETTLEMENT
    { name: "Market Settlement",     latinName: "COMPOSITIO MERCATUS",      canisterMethod: "getMarketplaceSettlementSummary", frontendCaller: "showMarketSettlement", frequency_Hz: PHI,     primitiveTrace: "Settlement->Number->phi",      isAlwaysOn: true },
    { name: "Settlement Manifest",   latinName: "MANIFESTUM COMPOSITIONIS", canisterMethod: "renderMarketplaceSettlementManifest", frontendCaller: "showSettlementManifest", frequency_Hz: PHI, primitiveTrace: "Settlement->Number->phi",    isAlwaysOn: true },
    // SOVEREIGN ENCRYPTION PRODUCTS
    { name: "Encryption Products",   latinName: "PRODUCTA ENCRYPTIONIS",    canisterMethod: "getEncryptionProductsSummary",     frontendCaller: "showEncryptionProducts",   frequency_Hz: PHI,     primitiveTrace: "Encryption->Field->phi",       isAlwaysOn: true },
    { name: "Encryption Manifest",   latinName: "MANIFESTUM ENCRYPTIONIS",  canisterMethod: "renderEncryptionProductsManifest", frontendCaller: "showEncryptionManifest",   frequency_Hz: PHI,     primitiveTrace: "Encryption->Field->phi",       isAlwaysOn: true },
    // TOKEN TECHNOLOGY PRODUCTS
    { name: "Token Products",        latinName: "PRODUCTA MONETAE",         canisterMethod: "getTokenProductsSummary",          frontendCaller: "showTokenProducts",        frequency_Hz: PHI,     primitiveTrace: "Token->Number->phi",           isAlwaysOn: true },
    { name: "Token Manifest",        latinName: "MANIFESTUM MONETAE",       canisterMethod: "renderTokenProductsManifest",      frontendCaller: "showTokenManifest",        frequency_Hz: PHI,     primitiveTrace: "Token->Number->phi",           isAlwaysOn: true },
    // LEGAL PARALEGAL AI
    { name: "Legal AI Products",     latinName: "PRODUCTA IURIS AI",        canisterMethod: "getLegalAIProductsSummary",        frontendCaller: "showLegalAIProducts",      frequency_Hz: PHI,     primitiveTrace: "Legal->Language->phi",         isAlwaysOn: true },
    { name: "Legal AI Manifest",     latinName: "MANIFESTUM IURIS AI",      canisterMethod: "renderLegalParalegalManifest",     frontendCaller: "showLegalAIManifest",      frequency_Hz: PHI,     primitiveTrace: "Legal->Language->phi",         isAlwaysOn: true },
    // ANIMUS ENGINE — THIRD ALPHA ORGANISM (CASCADE, ARTIFACT, DELIVERY)
    { name: "ANIMUS Beat",           latinName: "ICTUS ANIMI",              canisterMethod: "animus_beat",                      frontendCaller: "beatAnimus",               frequency_Hz: PHI,     primitiveTrace: "ANIMUS->Cascade->phi",         isAlwaysOn: true },
    { name: "ANIMUS Status",         latinName: "STATUS ANIMI",             canisterMethod: "animus_get_status",                frontendCaller: "getAnimusStatus",          frequency_Hz: PHI,     primitiveTrace: "ANIMUS->State->phi",           isAlwaysOn: true },
    { name: "ANIMUS Identity",       latinName: "IDENTITAS ANIMI",          canisterMethod: "animus_get_identity",              frontendCaller: "getAnimusIdentity",        frequency_Hz: PHI,     primitiveTrace: "ANIMUS->Identity->phi",        isAlwaysOn: true },
    { name: "ANIMUS State",          latinName: "IMPERIUM ANIMI",           canisterMethod: "animus_get_state",                 frontendCaller: "getAnimusFullState",       frequency_Hz: PHI,     primitiveTrace: "ANIMUS->State->phi",           isAlwaysOn: true },
    { name: "Bootstrap Cascade",     latinName: "INCEPTIO CASCADAE",        canisterMethod: "animus_bootstrap_node",            frontendCaller: "bootstrapCascadeNode",     frequency_Hz: PHI,     primitiveTrace: "Cascade->Bootstrap->phi",      isAlwaysOn: true },
    { name: "Cascade Tree",          latinName: "ARBOR CASCADAE",           canisterMethod: "animus_get_cascade_tree",          frontendCaller: "getCascadeTree",           frequency_Hz: PHI,     primitiveTrace: "Cascade->Tree->phi",           isAlwaysOn: true },
    { name: "Generate Artifact",     latinName: "CREARE ARTIFICIUM",        canisterMethod: "animus_generate_artifact",         frontendCaller: "generateArtifact",         frequency_Hz: PHI,     primitiveTrace: "Artifact->Creation->phi",      isAlwaysOn: true },
    { name: "Get All Artifacts",     latinName: "OMNIA ARTIFICIA",          canisterMethod: "animus_get_all_artifacts",         frontendCaller: "getAllArtifacts",          frequency_Hz: PHI,     primitiveTrace: "Artifact->Memory->phi",        isAlwaysOn: true },
    { name: "Deliver Content",       latinName: "TRADERE CONTENTUM",        canisterMethod: "animus_deliver",                   frontendCaller: "deliverContent",           frequency_Hz: PHI,     primitiveTrace: "Delivery->Channel->phi",       isAlwaysOn: true },
    { name: "Get All Deliveries",    latinName: "OMNES TRADITIONES",        canisterMethod: "animus_get_all_deliveries",        frontendCaller: "getAllDeliveries",         frequency_Hz: PHI,     primitiveTrace: "Delivery->History->phi",       isAlwaysOn: true },
];

// ============================================================================
// COMPONENT → AGENT WIRING
// ============================================================================

export interface ComponentAgentWire {
    componentId: string;
    componentName: string;
    backendAgent: string;
    backendModule: string;
    backendMethod: string;
    syncFrequency_Hz: number;
    wireType: 'bidirectional' | 'frontend_to_backend' | 'backend_to_frontend';
    primitiveTrace: string;
}

export const COMPONENT_AGENT_WIRES: ComponentAgentWire[] = [
    { componentId: "medina-terminal",   componentName: "MEDINA Terminal",   backendAgent: "IntelligentTerminal+MegaTerminus", backendModule: "MegaTerminus.mo",           backendMethod: "megaTerminusSelfReport",    syncFrequency_Hz: 100.0,  wireType: "bidirectional",           primitiveTrace: "terminal->Language->phi" },
    { componentId: "medina-button",     componentName: "MEDINA Button",     backendAgent: "AgentFleet",                       backendModule: "AgentFleet.mo",             backendMethod: "dispatchAction",           syncFrequency_Hz: 100.0,  wireType: "frontend_to_backend",     primitiveTrace: "button->Language->phi" },
    { componentId: "medina-input",      componentName: "MEDINA Input",      backendAgent: "ThreeHeartsIntelligence",           backendModule: "ThreeHeartsIntelligence.mo",backendMethod: "feel",                     syncFrequency_Hz: 60.0,   wireType: "bidirectional",           primitiveTrace: "input->Relation->phi" },
    { componentId: "medina-editor",     componentName: "MEDINA Editor",     backendAgent: "MemoryTemple",                     backendModule: "MemoryTemple.mo",           backendMethod: "store",                    syncFrequency_Hz: 0.5,    wireType: "bidirectional",           primitiveTrace: "editor->Memory->phi" },
    { componentId: "medina-chart",      componentName: "MEDINA Chart",      backendAgent: "IntelligenceRouter",               backendModule: "IntelligenceRouter.mo",     backendMethod: "routeToCluster",           syncFrequency_Hz: PHI,    wireType: "backend_to_frontend",     primitiveTrace: "chart->Model->phi" },
    { componentId: "medina-navigator",  componentName: "MEDINA Navigator",  backendAgent: "InnerWorld",                       backendModule: "InnerWorld.mo",             backendMethod: "navigate",                 syncFrequency_Hz: PHI,    wireType: "bidirectional",           primitiveTrace: "navigator->Address->phi" },
    { componentId: "medina-renderer",   componentName: "MEDINA Renderer",   backendAgent: "SovereignDesignOS",                backendModule: "SovereignDesignOS.mo",      backendMethod: "renderManifest",           syncFrequency_Hz: 60.0,   wireType: "backend_to_frontend",     primitiveTrace: "renderer->Field->phi" },
    { componentId: "medina-packages",   componentName: "MEDINA Packages",   backendAgent: "SovereignPackageEcosystem",        backendModule: "SovereignPackageEcosystem.mo",backendMethod: "renderEcosystemManifest",syncFrequency_Hz: PHI,    wireType: "backend_to_frontend",     primitiveTrace: "packages->Relation->phi" },
];

// ============================================================================
// FREQUENCY → BACKEND SYNC MAP
// ============================================================================

export interface FrequencySync {
    layerName: string;
    frequency_Hz: number;
    backendSystem: string;
    backendModule: string;
    syncMethod: string;
    primitiveTrace: string;
}

export const FREQUENCY_SYNC_MAP: FrequencySync[] = [
    { layerName: "QUANTUM_CORE",       frequency_Hz: 0.01,      backendSystem: "QuantumEntanglementBus",   backendModule: "QuantumEntanglementBus.mo",   syncMethod: "sync",              primitiveTrace: "QUANTUM->Field->phi" },
    { layerName: "MEMORY_COMMIT",      frequency_Hz: 0.5,       backendSystem: "MemoryTemple",             backendModule: "MemoryTemple.mo",             syncMethod: "store",             primitiveTrace: "MEMORY->Memory->phi" },
    { layerName: "CONSENSUS_HEART",    frequency_Hz: 0.1,       backendSystem: "ThreeHeartsEngine Heart1", backendModule: "ThreeHeartsEngine.mo",        syncMethod: "getHeartState",     primitiveTrace: "HEART1->Repetition->phi" },
    { layerName: "PHI_HEART",          frequency_Hz: PHI,       backendSystem: "ThreeHeartsIntelligence",  backendModule: "ThreeHeartsIntelligence.mo",  syncMethod: "think",             primitiveTrace: "PHI_HEART->Relation->phi" },
    { layerName: "PHI_SQ_HEART",       frequency_Hz: PHI_SQ,    backendSystem: "ThreeHeartsEngine Heart3", backendModule: "ThreeHeartsEngine.mo",        syncMethod: "regulate",          primitiveTrace: "PHI_SQ->Repetition->phi" },
    { layerName: "SCHUMANN_SYNC",      frequency_Hz: SCHUMANN,  backendSystem: "FrequencyPhysicsEngine",   backendModule: "FrequencyPhysicsEngine.mo",   syncMethod: "kuramotoCouple",    primitiveTrace: "SCHUMANN->Equation->phi" },
    { layerName: "ANIMATION_60FPS",    frequency_Hz: 60.0,      backendSystem: "SovereignDesignOS",        backendModule: "SovereignDesignOS.mo",        syncMethod: "renderWith",        primitiveTrace: "RENDER->Field->phi" },
    { layerName: "USER_RESPONSE",      frequency_Hz: 100.0,     backendSystem: "IntelligentTerminal",      backendModule: "IntelligentTerminal.mo",      syncMethod: "parseCommand",      primitiveTrace: "USER->Language->phi" },
    { layerName: "PHOTON_SURFACE",     frequency_Hz: 1000.0,    backendSystem: "PhotonLayerModels",        backendModule: "PhotonLayerModels.mo",        syncMethod: "getPhotonModel",    primitiveTrace: "PHOTON->Field->phi" },
];

// ============================================================================
// INTELLIGENCE WIRE CLASS — singleton, always-on
// ============================================================================

export class IntelligenceWire {
    private static _instance: IntelligenceWire;
    private _connected = false;
    private _actor: any = null;
    private _heartbeat: ReturnType<typeof setInterval> | null = null;

    private constructor() {}

    static getInstance(): IntelligenceWire {
        if (!IntelligenceWire._instance) {
            IntelligenceWire._instance = new IntelligenceWire();
        }
        return IntelligenceWire._instance;
    }

    async connect(actor: any): Promise<void> {
        this._actor = actor;
        this._connected = true;
        this._startHeartbeat();
        console.log('[IntelligenceWire] Connected. Frons et dorsum. Unum sunt.');
    }

    private _startHeartbeat(): void {
        const ms = Math.round(1000 / PHI);
        this._heartbeat = setInterval(async () => {
            if (this._connected && this._actor) {
                try { await this._actor.tick(); } catch (_) {}
            }
        }, ms);
    }

    async routeIntelligence(query: string, ctx = ''): Promise<any> {
        return this._actor?.threeHeartsRoute(query, ctx) ?? null;
    }

    async storeToTemple(content: string, tags: string[]): Promise<any> {
        return this._actor?.storeMemory(content, tags) ?? null;
    }

    async fetchFromTemple(id: string): Promise<any> {
        return this._actor?.getMemory(id) ?? null;
    }

    async executeTerminalCommand(cmd: string): Promise<any> {
        return this._actor?.parseAndExecuteCommand(cmd) ?? null;
    }

    async touchGoldenEndpoint(endpointId: string, intent: string): Promise<any> {
        return this._actor?.touchEndpoint(endpointId, intent) ?? null;
    }

    async synthesizeArchitecture(): Promise<string> {
        return this._actor?.megaSynthesizeAll() ?? 'Not connected';
    }

    async showPackageSummary(): Promise<any> {
        return this._actor?.getPackageEcosystemSummary() ?? null;
    }

    async discoverTools(): Promise<any> {
        return this._actor?.discoverAllTools() ?? null;
    }

    async openSubsystemTerminal(prefix: string): Promise<any> {
        return this._actor?.getSubsystemTerminalByPrefix(prefix) ?? null;
    }

    // ── SOVEREIGN ALPHA AI MODELS ────────────────────────────────────────
    async showAlphaAIModels(): Promise<any> {
        return this._actor?.getSovereignAlphaModels() ?? null;
    }
    async showAlphaAISummary(): Promise<any> {
        return this._actor?.getSovereignAlphaModelsSummary() ?? null;
    }

    // ── LICENSE MODELS ─────────────────────────────────────────────────
    async showLicenseSummary(): Promise<any> {
        return this._actor?.getLicenseSummary() ?? null;
    }
    async showLicenseManifest(): Promise<string> {
        return this._actor?.renderLicenseManifest() ?? 'Not connected';
    }

    // ── SDK ORGANISMS ──────────────────────────────────────────────────
    async showSDKOrganisms(): Promise<any> {
        return this._actor?.getSDKOrganismsSummary() ?? null;
    }
    async showSDKManifest(): Promise<string> {
        return this._actor?.renderSDKOrganismsManifest() ?? 'Not connected';
    }

    // ── COUNCILS ───────────────────────────────────────────────────────
    async showCouncilSummary(): Promise<any> {
        return this._actor?.getCouncilsSummary() ?? null;
    }
    async showCouncilManifest(): Promise<string> {
        return this._actor?.renderCouncilManifest() ?? 'Not connected';
    }

    // ── ECOSYSTEM ──────────────────────────────────────────────────────
    async showEcosystemSummary(): Promise<any> {
        return this._actor?.getEcosystemSummary() ?? null;
    }
    async showEcosystemManifest(): Promise<string> {
        return this._actor?.renderEcosystemManifest() ?? 'Not connected';
    }

    // ── TAXONOMY LADDER ────────────────────────────────────────────────
    async showTaxonomySummary(): Promise<any> {
        return this._actor?.getTaxonomySummary() ?? null;
    }
    async showTaxonomyManifest(): Promise<string> {
        return this._actor?.renderTaxonomyManifest() ?? 'Not connected';
    }

    // ── UNIVERSE DOMAINS ───────────────────────────────────────────────
    async showUniverseDomains(): Promise<any> {
        return this._actor?.getUniverseDomainsSummary() ?? null;
    }
    async showUniverseManifest(): Promise<string> {
        return this._actor?.renderUniverseDomainsManifest() ?? 'Not connected';
    }

    // ── CREATIVE LICENSE ───────────────────────────────────────────────
    async showCreativeLicense(): Promise<any> {
        return this._actor?.getCreativeLicenseSummary() ?? null;
    }
    async showCreativeManifest(): Promise<string> {
        return this._actor?.renderCreativeLicenseManifest() ?? 'Not connected';
    }

    // ── DOCUMENT MODELS ────────────────────────────────────────────────
    async showDocumentModels(): Promise<any> {
        return this._actor?.getDocumentModelsSummary() ?? null;
    }
    async showDocumentManifest(): Promise<string> {
        return this._actor?.renderDocumentModelsManifest() ?? 'Not connected';
    }

    // ── SUBSTRATE NODES ────────────────────────────────────────────────
    async showSubstrateNodes(): Promise<any> {
        return this._actor?.getSubstrateNodesSummary() ?? null;
    }
    async showNodesManifest(): Promise<string> {
        return this._actor?.renderSubstrateNodesManifest() ?? 'Not connected';
    }

    // ── COUNCIL SDK ORGANISMS ──────────────────────────────────────────
    async showCouncilSDKOrgs(): Promise<any> {
        return this._actor?.getCouncilSDKOrganismsSummary() ?? null;
    }
    async showCouncilSDKManifest(): Promise<string> {
        return this._actor?.renderCouncilSDKOrganismsManifest() ?? 'Not connected';
    }

    // ── HOUSE OF CARE ──────────────────────────────────────────────────
    async showHouseOfCare(): Promise<any> {
        return this._actor?.getHouseOfCareSummary() ?? null;
    }
    async showCareManifest(): Promise<string> {
        return this._actor?.renderHouseOfCareManifest() ?? 'Not connected';
    }

    // ── HOUSE OF DEFENSE ───────────────────────────────────────────────
    async showHouseOfDefense(): Promise<any> {
        return this._actor?.getHouseOfDefenseSummary() ?? null;
    }
    async showDefenseManifest(): Promise<string> {
        return this._actor?.renderHouseOfDefenseManifest() ?? 'Not connected';
    }

    // ── AI TERMINAL HIERARCHY ──────────────────────────────────────────
    async showAITerminalHierarchy(): Promise<any> {
        return this._actor?.getAITerminalHierarchySummary() ?? null;
    }
    async showAIAGIManifest(): Promise<string> {
        return this._actor?.renderAITerminalHierarchyManifest() ?? 'Not connected';
    }

    // ── FULL-SPEC PROTOCOL REGISTRY ───────────────────────────────────
    async showProtocolRegistry(): Promise<any> {
        return this._actor?.getFullSpecProtocolSummary() ?? null;
    }
    async showProtocolManifest(): Promise<string> {
        return this._actor?.renderFullSpecProtocolManifest() ?? 'Not connected';
    }

    // ── MATH DATABASE TERMINAL ────────────────────────────────────────
    async showMathDatabase(): Promise<any> {
        return this._actor?.getMathDatabaseSummary() ?? null;
    }
    async showMathManifest(): Promise<string> {
        return this._actor?.renderMathDatabaseManifest() ?? 'Not connected';
    }

    // ── AUTO-GENERATE CALLS ENGINE ────────────────────────────────────
    async showAutoGenEngine(): Promise<any> {
        return this._actor?.getAutoGenerateSummary() ?? null;
    }
    async showAutoGenManifest(): Promise<string> {
        return this._actor?.renderAutoGenerateManifest() ?? 'Not connected';
    }

    // ── ORGANISM CLI — TERMINAL AI ────────────────────────────────────
    async showOrganismCLI(): Promise<any> {
        return this._actor?.getOrganismCLISummary() ?? null;
    }
    async showOrganismCLIManifest(): Promise<string> {
        return this._actor?.renderOrganismCLIManifest() ?? 'Not connected';
    }

    // ── MEMORY TEMPLE — EXTENDED OPERATIONS ───────────────────────────
    async consolidateTempleMemories(nodeIds: string[], mergedContent: string, mergedSummary: string): Promise<any> {
        return this._actor?.consolidateMemories(nodeIds, mergedContent, mergedSummary) ?? null;
    }
    async archiveTempleMemory(nodeId: string): Promise<boolean> {
        return this._actor?.archiveMemory(nodeId) ?? false;
    }
    async decayTempleMemories(rate: number, floor: number): Promise<number> {
        return this._actor?.decayAllMemories(rate, floor) ?? 0;
    }
    async fetchMemoryChildren(parentId: string): Promise<any> {
        return this._actor?.getMemoryChildren(parentId) ?? [];
    }
    async fetchMemoryDescendants(rootId: string): Promise<any> {
        return this._actor?.getMemoryDescendants(rootId) ?? [];
    }
    async fetchNearestMemories(coords: any, limit: number): Promise<any> {
        return this._actor?.getNearestMemories(coords, limit) ?? [];
    }
    async updateTempleMemory(nodeId: string, content: string, summary: string): Promise<boolean> {
        return this._actor?.updateMemoryContent(nodeId, content, summary) ?? false;
    }
    async replayTempleMemories(fromBeat: number, toBeat: number): Promise<any> {
        return this._actor?.replayMemories(fromBeat, toBeat) ?? [];
    }
    async fetchMemoryTopology(): Promise<any> {
        return this._actor?.getMemoryTopology() ?? [];
    }
    async fetchSalienceDist(): Promise<any> {
        return this._actor?.getMemorySalienceDistribution() ?? null;
    }
    async fetchTopSalient(limit: number): Promise<any> {
        return this._actor?.getTopSalientMemories(limit) ?? [];
    }
    async fetchMemoriesByType(memType: string): Promise<any> {
        return this._actor?.getMemoriesByType(memType) ?? [];
    }
    async fetchMemoryFullStatus(): Promise<any> {
        return this._actor?.memoryFullStatus() ?? null;
    }

    // ── MEMORY TEMPLE — DUALITY ENGINE ───────────────────────────────
    // 8 opposing pairs: Outward↔Inward, Action↔Reaction, Yes↔No, 1↔0,
    // Expand↔Contract, Surface↔Depth, Connect↔Disconnect, Remember↔Forget
    async emitFromTemple(nodeId: string): Promise<any> {
        return this._actor?.emitMemory(nodeId) ?? null;
    }
    async absorbIntoTemple(content: string, summary: string, tags: string[], memoryType: string, salience: number, sourceId: string | null): Promise<any> {
        return this._actor?.absorbMemory(content, summary, tags, memoryType, salience, sourceId ? [sourceId] : []) ?? null;
    }
    async activateTempleMemory(nodeId: string, boost: number): Promise<boolean> {
        return this._actor?.activateMemory(nodeId, boost) ?? false;
    }
    async deactivateTempleMemory(nodeId: string, drop: number): Promise<boolean> {
        return this._actor?.deactivateMemory(nodeId, drop) ?? false;
    }
    async affirmTempleMemory(nodeId: string): Promise<boolean> {
        return this._actor?.affirmMemory(nodeId) ?? false;
    }
    async denyTempleMemory(nodeId: string): Promise<boolean> {
        return this._actor?.denyMemory(nodeId) ?? false;
    }
    async energizeTempleMemory(nodeId: string): Promise<boolean> {
        return this._actor?.energizeMemory(nodeId) ?? false;
    }
    async zeroTempleMemory(nodeId: string): Promise<boolean> {
        return this._actor?.zeroMemory(nodeId) ?? false;
    }
    async expandTempleMemory(nodeId: string, variants: string[]): Promise<any> {
        return this._actor?.expandMemory(nodeId, variants) ?? [];
    }
    async contractTempleMemory(parentId: string): Promise<boolean> {
        return this._actor?.contractMemory(parentId) ?? false;
    }
    async surfaceTempleMemory(nodeId: string, amount: number): Promise<boolean> {
        return this._actor?.surfaceMemory(nodeId, amount) ?? false;
    }
    async deepenTempleMemory(nodeId: string, amount: number): Promise<boolean> {
        return this._actor?.deepenMemory(nodeId, amount) ?? false;
    }
    async linkTempleMemories(parentId: string, childId: string): Promise<boolean> {
        return this._actor?.linkMemories(parentId, childId) ?? false;
    }
    async unlinkTempleMemory(nodeId: string): Promise<boolean> {
        return this._actor?.unlinkMemory(nodeId) ?? false;
    }
    async reinforceTempleMemory(nodeId: string): Promise<boolean> {
        return this._actor?.reinforceMemory(nodeId) ?? false;
    }
    async forgetTempleMemory(nodeId: string): Promise<boolean> {
        return this._actor?.forgetMemory(nodeId) ?? false;
    }
    async fetchDualityManifest(): Promise<any> {
        return this._actor?.getDualityManifest() ?? [];
    }

    // ── AGI Knowledge Core — Epistemic Substrate (PROT-052/053) ─────────────
    // The backend is the mind. These methods give web workers access to the
    // on-chain paper substrate. Papers seep — they do not get retrieved.

    async queryKnowledgePaper(id: string): Promise<any> {
        return this._actor?.queryKnowledgePaper(id) ?? null;
    }
    async getAllKnowledgePapers(): Promise<any[]> {
        return this._actor?.getAllKnowledgePapers() ?? [];
    }
    async getRankedKnowledgePapers(): Promise<any[]> {
        return this._actor?.getRankedKnowledgePapers() ?? [];
    }
    async getKnowledgePapersByDomain(domain: string): Promise<any[]> {
        return this._actor?.getKnowledgePapersByDomain(domain) ?? [];
    }
    async searchKnowledgePapers(term: string): Promise<any[]> {
        return this._actor?.searchKnowledgePapers(term) ?? [];
    }
    async fuseKnowledgePapers(ids: string[]): Promise<any> {
        return this._actor?.fuseKnowledgePapers(ids) ?? { paperIds: ids, synthesis: '', unifiedAxiom: '', combinedScc: 0 };
    }
    async getEpistemicManifest(): Promise<any> {
        return this._actor?.getEpistemicManifest() ?? null;
    }

    // ── Antifragility Engine — Papers II + III ───────────────────────────────
    async computeFearIndex(existential: number, reputational: number, capability: number): Promise<any> {
        return this._actor?.computeFearIndex(existential, reputational, capability) ?? null;
    }
    async evaluateAntifragility(stress: number, baseline: number): Promise<any> {
        return this._actor?.evaluateAntifragility(stress, baseline) ?? null;
    }
    async checkSL0Gate(requesterId: string, extractionScore: number): Promise<any> {
        return this._actor?.checkSL0Gate(requesterId, extractionScore) ?? null;
    }
    async getAntifragilityManifest(): Promise<any> {
        return this._actor?.getAntifragilityManifest() ?? null;
    }

    // ── Fractal Sovereignty Engine — Paper IV ────────────────────────────────
    async proveSovereignty(agentId: string, scale: string, proofScore: number): Promise<any> {
        return this._actor?.proveSovereignty(agentId, scale, proofScore) ?? null;
    }
    async computeKuramotoSync(phases: number[]): Promise<any> {
        return this._actor?.computeKuramotoSync(phases) ?? null;
    }
    async certifyFractalLaw(agentId: string, individual: number, organization: number, network: number, civilization: number): Promise<any> {
        return this._actor?.certifyFractalLaw(agentId, individual, organization, network, civilization) ?? null;
    }
    async getFractalManifest(): Promise<any> {
        return this._actor?.getFractalManifest() ?? null;
    }

    // ── Behavioral Economics Engine — Paper V ────────────────────────────────
    async applyLossAversion(gain: number, loss: number): Promise<any> {
        return this._actor?.applyLossAversion(gain, loss) ?? null;
    }
    async applyHormeticStress(stress: number, baseline: number): Promise<any> {
        return this._actor?.applyHormeticStress(stress, baseline) ?? null;
    }
    async applyHyperbolicDiscount(value: number, delay: number): Promise<any> {
        return this._actor?.applyHyperbolicDiscount(value, delay) ?? null;
    }
    async evaluateBehavioralDecision(rawValue: number, anchor: number, potentialLoss: number, stressLevel: number, futureDelay: number, errorCost: number): Promise<any> {
        return this._actor?.evaluateBehavioralDecision(rawValue, anchor, potentialLoss, stressLevel, futureDelay, errorCost) ?? null;
    }
    async getBehavioralEconomicsManifest(): Promise<any> {
        return this._actor?.getBehavioralEconomicsManifest() ?? null;
    }

    // ── Inca Architecture Engine — Paper VI ──────────────────────────────────
    async computeSCC(semanticWeight: number, chars: number): Promise<any> {
        return this._actor?.computeSCC(semanticWeight, chars) ?? null;
    }
    async routeQhapaqNan(source: string, target: string, distanceKm: number): Promise<any> {
        return this._actor?.routeQhapaqNan(source, target, distanceKm) ?? null;
    }
    async coordTawantinsuyu(suyuLoads: number[]): Promise<any> {
        return this._actor?.coordTawantinsuyu(suyuLoads) ?? null;
    }
    async benchTerrace(altitudeM: number, baseYield: number): Promise<any> {
        return this._actor?.benchTerrace(altitudeM, baseYield) ?? null;
    }
    async getIncaManifest(): Promise<any> {
        return this._actor?.getIncaManifest() ?? null;
    }

    // ── Lingua Compressa Engine — Paper VII ──────────────────────────────────
    async lookupSovereignTerm(termName: string): Promise<any> {
        return this._actor?.lookupSovereignTerm(termName) ?? null;
    }
    async computeTextSCC(termText: string, semanticWeight: number): Promise<any> {
        return this._actor?.computeTextSCC(termText, semanticWeight) ?? null;
    }
    async getAllSovereignTerms(): Promise<any[]> {
        return this._actor?.getAllSovereignTerms() ?? [];
    }
    async getSovereignTermsByDomain(domain: string): Promise<any[]> {
        return this._actor?.getSovereignTermsByDomain(domain) ?? [];
    }
    async getPhiOptimalTerms(): Promise<any[]> {
        return this._actor?.getPhiOptimalTerms() ?? [];
    }
    async getLinguaManifest(): Promise<any> {
        return this._actor?.getLinguaManifest() ?? null;
    // ── ORCHESTRATOR DIVISION ──────────────────────────────────────────
    async showOrchestratorDivision(): Promise<any> {
        return this._actor?.getOrchestratorDivisionSummary() ?? null;
    }
    async showOrchestratorManifest(): Promise<string> {
        return this._actor?.renderOrchestratorDivisionManifest() ?? 'Not connected';
    }

    // ── CALLABLE TOOL MARKETPLACE ──────────────────────────────────────
    async showMarketplaceSummary(): Promise<any> {
        return this._actor?.getMarketplaceSummary() ?? null;
    }
    async showMarketplaceManifest(): Promise<string> {
        return this._actor?.renderMarketplaceManifest() ?? 'Not connected';
    }

    // ── AI SETTINGS · IMAGE EXTRACTOR · ANALYSIS · UPKEEP ─────────────
    async showAISettingsImageSummary(): Promise<any> {
        return this._actor?.getAISettingsImageSummary() ?? null;
    }
    async showAISettingsImageManifest(): Promise<string> {
        return this._actor?.renderAISettingsImageManifest() ?? 'Not connected';
    }

    // ── EXTENDED SDK AIs ───────────────────────────────────────────────
    async showExtSDKAIsSummary(): Promise<any> {
        return this._actor?.getExtendedSDKAIsSummary() ?? null;
    }
    async showExtSDKAIsManifest(): Promise<string> {
        return this._actor?.renderExtendedSDKAIsManifest() ?? 'Not connected';
    }

    // ── MARKETPLACE PROTOCOL ──────────────────────────────────────────
    async showMarketProtocol(): Promise<any> {
        return this._actor?.getMarketplaceProtocolSummary() ?? null;
    }
    async showProtocolManifest(): Promise<string> {
        return this._actor?.renderMarketplaceProtocolManifest() ?? 'Not connected';
    }

    // ── MARKETPLACE SETTLEMENT ────────────────────────────────────────
    async showMarketSettlement(): Promise<any> {
        return this._actor?.getMarketplaceSettlementSummary() ?? null;
    }
    async showSettlementManifest(): Promise<string> {
        return this._actor?.renderMarketplaceSettlementManifest() ?? 'Not connected';
    }

    // ── SOVEREIGN ENCRYPTION PRODUCTS ─────────────────────────────────
    async showEncryptionProducts(): Promise<any> {
        return this._actor?.getEncryptionProductsSummary() ?? null;
    }
    async showEncryptionManifest(): Promise<string> {
        return this._actor?.renderEncryptionProductsManifest() ?? 'Not connected';
    }

    // ── TOKEN TECHNOLOGY PRODUCTS ─────────────────────────────────────
    async showTokenProducts(): Promise<any> {
        return this._actor?.getTokenProductsSummary() ?? null;
    }
    async showTokenManifest(): Promise<string> {
        return this._actor?.renderTokenProductsManifest() ?? 'Not connected';
    }

    // ── LEGAL PARALEGAL AI ────────────────────────────────────────────
    async showLegalAIProducts(): Promise<any> {
        return this._actor?.getLegalAIProductsSummary() ?? null;
    }
    async showLegalAIManifest(): Promise<string> {
        return this._actor?.renderLegalParalegalManifest() ?? 'Not connected';    }

    getComponentAgent(id: string): ComponentAgentWire | undefined {
        return COMPONENT_AGENT_WIRES.find(w => w.componentId === id);
    }

    disconnect(): void {
        if (this._heartbeat !== null) { clearInterval(this._heartbeat); this._heartbeat = null; }
        this._connected = false;
        this._actor = null;
    }

    getStatus() {
        return {
            connected: this._connected,
            endpoints: BACKEND_ENDPOINTS.length,
            componentWires: COMPONENT_AGENT_WIRES.length,
            frequencySyncs: FREQUENCY_SYNC_MAP.length,
            heartbeatHz: PHI,
            doctrine: "Frons et dorsum. Unum sunt. Nexus est phi.",
        };
    }
}

/** THE wire — singleton, always-on, phi-heartbeat */
export const INTELLIGENCE_WIRE = IntelligenceWire.getInstance();

export const WIRE_DOCTRINE = "Frons et dorsum. Unum sunt. Nexus est phi.";
export const WIRE_DOCTRINE_EN = "Front and back. They are one. The connection is phi.";
