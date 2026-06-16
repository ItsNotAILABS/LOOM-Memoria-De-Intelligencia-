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
