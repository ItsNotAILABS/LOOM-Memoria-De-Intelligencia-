/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                     MEDINA FRONTEND INTELLIGENCE                              ║
 * ║                                                                               ║
 * ║  "Intelligentia ubique. Frequentia in omnibus."                              ║
 * ║  (Intelligence everywhere. Frequency in everything.)                          ║
 * ║                                                                               ║
 * ║  THIS IS THE COMPLETE INTELLIGENT FRONTEND                                    ║
 * ║  Every component has: REAL Hz • Math • Physics • Intelligence                 ║
 * ║                                                                               ║
 * ║  From 0.01 Hz quantum to 60 Hz render — FREQUENCIES ARE REAL                  ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 * 
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * L-130 COMPLIANT — Every component traces to primitive φ
 */

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 1: ROOT MATHEMATICAL CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

/** Golden Ratio φ = (1 + √5) / 2 */
export const PHI: number = 1.6180339887498948482;

/** Inverse Golden Ratio φ⁻¹ = φ - 1 */
export const PHI_INV: number = 0.6180339887498948482;

/** Golden Ratio Squared φ² = φ + 1 */
export const PHI_SQ: number = 2.6180339887498948482;

/** Golden Ratio Cubed φ³ = 2φ + 1 */
export const PHI_CUBE: number = 4.2360679774997896964;

/** Pi π */
export const PI: number = 3.1415926535897932385;

/** Tau τ = 2π */
export const TAU: number = 6.2831853071795864769;

/** Euler's Number e */
export const E: number = 2.7182818284590452354;

/** Schumann Resonance (Hz) */
export const SCHUMANN: number = 7.83;

/** Speed of Light (m/s) */
export const C: number = 299792458;

/** Planck Constant (J·s) */
export const H: number = 6.62607015e-34;

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 2: FREQUENCY LAYER SYSTEM
// Every layer operates at a specific REAL frequency
// ═══════════════════════════════════════════════════════════════════════════

export interface FrequencyLayer {
    name: string;
    frequency_Hz: number;
    period_ms: number;
    purpose: string;
    formula: string;
    primitiveTrace: string;
}

/** Complete frequency layer ladder */
export const FREQUENCY_LAYERS: FrequencyLayer[] = [
    // Quantum/Deep layers (0.01 - 0.1 Hz)
    { name: "QUANTUM_CORE", frequency_Hz: 0.01, period_ms: 100000,
      purpose: "Deepest state computation", formula: "T = 100s",
      primitiveTrace: "QUANTUM_CORE → φ" },
    { name: "PRIMORDIAL", frequency_Hz: 0.02, period_ms: 50000,
      purpose: "Primordial pattern emergence", formula: "T = 50s",
      primitiveTrace: "PRIMORDIAL → φ" },
    { name: "FOUNDATION", frequency_Hz: 0.05, period_ms: 20000,
      purpose: "Foundation operations", formula: "T = 20s",
      primitiveTrace: "FOUNDATION → φ" },
    { name: "CONSENSUS", frequency_Hz: 0.1, period_ms: 10000,
      purpose: "Deep consensus (Heart1)", formula: "ω₁ = 0.1 Hz",
      primitiveTrace: "CONSENSUS → Heart1 → φ" },
      
    // Low frequency layers (0.1 - 1 Hz)
    { name: "STATE_SYNC", frequency_Hz: 0.2, period_ms: 5000,
      purpose: "State synchronization", formula: "T = 5s",
      primitiveTrace: "STATE_SYNC → φ" },
    { name: "MEMORY_COMMIT", frequency_Hz: 0.5, period_ms: 2000,
      purpose: "Memory commit cycle", formula: "T = 2s",
      primitiveTrace: "MEMORY_COMMIT → φ" },
    { name: "PHI_INVERSE", frequency_Hz: PHI_INV, period_ms: 1618,
      purpose: "φ⁻¹ rhythm", formula: "f = φ⁻¹ = 0.618 Hz",
      primitiveTrace: "PHI_INVERSE → φ" },
    { name: "BASE_RHYTHM", frequency_Hz: 1.0, period_ms: 1000,
      purpose: "Base system rhythm", formula: "f = 1 Hz",
      primitiveTrace: "BASE_RHYTHM → φ" },
      
    // Golden ratio layers (1 - 5 Hz)
    { name: "COUPLING_HEART", frequency_Hz: PHI, period_ms: 618,
      purpose: "Three Hearts coupling (Heart2)", formula: "ω₂ = φ Hz",
      primitiveTrace: "COUPLING_HEART → Heart2 → φ" },
    { name: "DOCUMENT_UPDATE", frequency_Hz: 2.0, period_ms: 500,
      purpose: "Living document updates", formula: "f = 2 Hz",
      primitiveTrace: "DOCUMENT_UPDATE → φ" },
    { name: "REGULATING_HEART", frequency_Hz: PHI_SQ, period_ms: 382,
      purpose: "Three Hearts regulating (Heart3)", formula: "ω₃ = φ² Hz",
      primitiveTrace: "REGULATING_HEART → Heart3 → φ" },
    { name: "AGENT_DISPATCH", frequency_Hz: 3.0, period_ms: 333,
      purpose: "Agent task dispatch", formula: "f = 3 Hz",
      primitiveTrace: "AGENT_DISPATCH → φ" },
    { name: "INTELLIGENCE_ROUTE", frequency_Hz: PHI_CUBE, period_ms: 236,
      purpose: "Intelligence routing", formula: "f = φ³ Hz",
      primitiveTrace: "INTELLIGENCE_ROUTE → φ" },
    { name: "MESSAGE_LAYER", frequency_Hz: 5.0, period_ms: 200,
      purpose: "Message passing", formula: "f = 5 Hz",
      primitiveTrace: "MESSAGE_LAYER → φ" },
      
    // Earth/Mid frequency layers (5 - 20 Hz)
    { name: "SCHUMANN_SYNC", frequency_Hz: SCHUMANN, period_ms: 128,
      purpose: "Earth resonance sync", formula: "f = 7.83 Hz",
      primitiveTrace: "SCHUMANN_SYNC → Earth → φ" },
    { name: "QUERY_RESPONSE", frequency_Hz: 10.0, period_ms: 100,
      purpose: "Fast query response", formula: "f = 10 Hz",
      primitiveTrace: "QUERY_RESPONSE → φ" },
    { name: "DATA_STREAM", frequency_Hz: 20.0, period_ms: 50,
      purpose: "Data streaming", formula: "f = 20 Hz",
      primitiveTrace: "DATA_STREAM → φ" },
      
    // High frequency/UI layers (20 - 100 Hz)
    { name: "ANIMATION_30FPS", frequency_Hz: 30.0, period_ms: 33.3,
      purpose: "30fps animation", formula: "f = 30 Hz",
      primitiveTrace: "ANIMATION_30FPS → φ" },
    { name: "PERCEPTION_INPUT", frequency_Hz: 50.0, period_ms: 20,
      purpose: "Perception/input processing", formula: "f = 50 Hz",
      primitiveTrace: "PERCEPTION_INPUT → φ" },
    { name: "ANIMATION_60FPS", frequency_Hz: 60.0, period_ms: 16.67,
      purpose: "60fps smooth animation", formula: "f = 60 Hz",
      primitiveTrace: "ANIMATION_60FPS → φ" },
    { name: "USER_RESPONSE", frequency_Hz: 100.0, period_ms: 10,
      purpose: "User interaction response", formula: "f = 100 Hz",
      primitiveTrace: "USER_RESPONSE → φ" },
      
    // Ultra-high frequency (100+ Hz)
    { name: "EDGE_CACHE", frequency_Hz: 200.0, period_ms: 5,
      purpose: "Edge cache retrieval", formula: "f = 200 Hz",
      primitiveTrace: "EDGE_CACHE → φ" },
    { name: "MEMORY_ACCESS", frequency_Hz: 500.0, period_ms: 2,
      purpose: "In-memory access", formula: "f = 500 Hz",
      primitiveTrace: "MEMORY_ACCESS → φ" },
    { name: "PHOTON_SURFACE", frequency_Hz: 1000.0, period_ms: 1,
      purpose: "Photon layer (1ms)", formula: "f = 1000 Hz",
      primitiveTrace: "PHOTON_SURFACE → φ" },
];

/** Get frequency layer by name */
export function getFrequencyLayer(name: string): FrequencyLayer | undefined {
    return FREQUENCY_LAYERS.find(l => l.name === name);
}

/** Calculate model frequency based on golden ratio scaling */
export function goldenModelFrequency(modelIndex: number, baseHz: number = SCHUMANN): number {
    // f_n = base × φ^((n-1)/20)
    return baseHz * Math.pow(PHI, (modelIndex - 1) / 20);
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 3: INTELLIGENT COMPONENT SYSTEM
// Every UI component is intelligent with its own frequency
// ═══════════════════════════════════════════════════════════════════════════

export interface IntelligentComponent {
    id: string;
    name: string;
    type: ComponentType;
    frequency_Hz: number;
    formula: string;
    inputs: string[];
    outputs: string[];
    intelligence: ComponentIntelligence;
    primitiveTrace: string;
}

export type ComponentType = 
    | 'button' | 'input' | 'form' | 'modal' | 'card'
    | 'list' | 'table' | 'chart' | 'terminal' | 'editor'
    | 'viewer' | 'player' | 'navigator' | 'menu' | 'panel';

export interface ComponentIntelligence {
    model: string;           // AI model backing this component
    routing: string;         // Intelligence routing
    coherence: number;       // Current coherence (0-1)
    heartSync: boolean;      // Synced with Three Hearts
}

/** Intelligent UI Components */
export const INTELLIGENT_COMPONENTS: IntelligentComponent[] = [
    // Input Components
    {
        id: "medina-button",
        name: "MEDINA Button",
        type: "button",
        frequency_Hz: 100.0,  // Fast response
        formula: "click → action(φ-weighted)",
        inputs: ["click", "hover", "focus"],
        outputs: ["action", "feedback", "state"],
        intelligence: {
            model: "ButtonIntelligence",
            routing: "Direct",
            coherence: 1.0,
            heartSync: true
        },
        primitiveTrace: "Button → Component → φ"
    },
    {
        id: "medina-input",
        name: "MEDINA Input",
        type: "input",
        frequency_Hz: 60.0,  // Smooth typing
        formula: "keypress → validate(φ) → emit",
        inputs: ["keydown", "keyup", "change", "focus"],
        outputs: ["value", "valid", "suggestions"],
        intelligence: {
            model: "InputIntelligence",
            routing: "Validated",
            coherence: 1.0,
            heartSync: true
        },
        primitiveTrace: "Input → Component → φ"
    },
    {
        id: "medina-form",
        name: "MEDINA Form",
        type: "form",
        frequency_Hz: 30.0,  // Form-level validation
        formula: "inputs → validate_all → submit",
        inputs: ["fields", "submit", "reset"],
        outputs: ["data", "errors", "submitted"],
        intelligence: {
            model: "FormIntelligence",
            routing: "Orchestrated",
            coherence: 1.0,
            heartSync: true
        },
        primitiveTrace: "Form → Component → φ"
    },
    
    // Display Components
    {
        id: "medina-card",
        name: "MEDINA Card",
        type: "card",
        frequency_Hz: 30.0,
        formula: "data → render(φ-layout)",
        inputs: ["data", "style", "actions"],
        outputs: ["display", "interactions"],
        intelligence: {
            model: "CardIntelligence",
            routing: "Layout",
            coherence: 1.0,
            heartSync: false
        },
        primitiveTrace: "Card → Component → φ"
    },
    {
        id: "medina-list",
        name: "MEDINA List",
        type: "list",
        frequency_Hz: 60.0,  // Virtual scrolling
        formula: "items → virtualize(φ-window) → render",
        inputs: ["items", "filter", "sort"],
        outputs: ["visible", "selected", "scrollPos"],
        intelligence: {
            model: "ListIntelligence",
            routing: "Virtualized",
            coherence: 1.0,
            heartSync: false
        },
        primitiveTrace: "List → Component → φ"
    },
    {
        id: "medina-table",
        name: "MEDINA Table",
        type: "table",
        frequency_Hz: 30.0,
        formula: "rows × cols → grid(φ-proportions)",
        inputs: ["data", "columns", "sorting", "pagination"],
        outputs: ["display", "selected", "sorted"],
        intelligence: {
            model: "TableIntelligence",
            routing: "Tabular",
            coherence: 1.0,
            heartSync: false
        },
        primitiveTrace: "Table → Component → φ"
    },
    
    // Interactive Components
    {
        id: "medina-terminal",
        name: "MEDINA Terminal",
        type: "terminal",
        frequency_Hz: 100.0,  // Fast command response
        formula: "input → parse → route → execute → output",
        inputs: ["command", "stdin"],
        outputs: ["stdout", "stderr", "result"],
        intelligence: {
            model: "TerminalIntelligence",
            routing: "Command",
            coherence: 1.0,
            heartSync: true
        },
        primitiveTrace: "Terminal → Organ → φ"
    },
    {
        id: "medina-editor",
        name: "MEDINA Editor",
        type: "editor",
        frequency_Hz: 60.0,  // Smooth editing
        formula: "keystrokes → buffer → render(φ)",
        inputs: ["text", "commands", "selections"],
        outputs: ["content", "cursor", "highlights"],
        intelligence: {
            model: "EditorIntelligence",
            routing: "Document",
            coherence: 1.0,
            heartSync: true
        },
        primitiveTrace: "Editor → Component → φ"
    },
    {
        id: "medina-chart",
        name: "MEDINA Chart",
        type: "chart",
        frequency_Hz: 30.0,  // Data visualization
        formula: "data → scale(φ) → render",
        inputs: ["data", "type", "options"],
        outputs: ["visualization", "tooltips", "interactions"],
        intelligence: {
            model: "ChartIntelligence",
            routing: "Analytical",
            coherence: 1.0,
            heartSync: false
        },
        primitiveTrace: "Chart → Component → φ"
    },
    
    // Media Components
    {
        id: "medina-viewer",
        name: "MEDINA Viewer",
        type: "viewer",
        frequency_Hz: 60.0,
        formula: "content → render(format)",
        inputs: ["content", "format", "zoom"],
        outputs: ["display", "annotations"],
        intelligence: {
            model: "ViewerIntelligence",
            routing: "Content",
            coherence: 1.0,
            heartSync: false
        },
        primitiveTrace: "Viewer → Component → φ"
    },
    {
        id: "medina-player",
        name: "MEDINA Player",
        type: "player",
        frequency_Hz: 60.0,  // Media playback
        formula: "media → decode → render",
        inputs: ["source", "controls"],
        outputs: ["playback", "time", "state"],
        intelligence: {
            model: "PlayerIntelligence",
            routing: "Media",
            coherence: 1.0,
            heartSync: false
        },
        primitiveTrace: "Player → Component → φ"
    },
    
    // Navigation Components
    {
        id: "medina-navigator",
        name: "MEDINA Navigator",
        type: "navigator",
        frequency_Hz: 100.0,  // Fast navigation
        formula: "route → resolve → navigate",
        inputs: ["path", "params"],
        outputs: ["view", "state", "history"],
        intelligence: {
            model: "NavigatorIntelligence",
            routing: "Navigation",
            coherence: 1.0,
            heartSync: true
        },
        primitiveTrace: "Navigator → Organ → φ"
    },
    {
        id: "medina-menu",
        name: "MEDINA Menu",
        type: "menu",
        frequency_Hz: 60.0,
        formula: "items → render(φ-hierarchy)",
        inputs: ["items", "selected"],
        outputs: ["selection", "expanded"],
        intelligence: {
            model: "MenuIntelligence",
            routing: "Hierarchical",
            coherence: 1.0,
            heartSync: false
        },
        primitiveTrace: "Menu → Component → φ"
    },
    {
        id: "medina-panel",
        name: "MEDINA Panel",
        type: "panel",
        frequency_Hz: 30.0,
        formula: "content → layout(φ-grid)",
        inputs: ["content", "layout"],
        outputs: ["rendered", "resized"],
        intelligence: {
            model: "PanelIntelligence",
            routing: "Layout",
            coherence: 1.0,
            heartSync: false
        },
        primitiveTrace: "Panel → Component → φ"
    },
    {
        id: "medina-modal",
        name: "MEDINA Modal",
        type: "modal",
        frequency_Hz: 60.0,
        formula: "show → animate(φ) → focus",
        inputs: ["content", "trigger"],
        outputs: ["visible", "result"],
        intelligence: {
            model: "ModalIntelligence",
            routing: "Focus",
            coherence: 1.0,
            heartSync: false
        },
        primitiveTrace: "Modal → Component → φ"
    },
];

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 4: THREE HEARTS BROWSER SYSTEM
// The heartbeat of the frontend
// ═══════════════════════════════════════════════════════════════════════════

export interface ThreeHeartsState {
    heart1: HeartState;  // Metropolis (0.1 Hz)
    heart2: HeartState;  // Coupling (φ Hz)
    heart3: HeartState;  // Regulating (φ² Hz)
    coherence: number;   // Overall coherence
    timestamp: number;
}

export interface HeartState {
    name: string;
    frequency_Hz: number;
    phase: number;       // Current phase (radians)
    amplitude: number;   // Current amplitude
    active: boolean;
}

/** Three Hearts frequencies */
export const THREE_HEARTS = {
    HEART1: { name: "Metropolis", frequency_Hz: 0.1, period_ms: 10000 },
    HEART2: { name: "Coupling", frequency_Hz: PHI, period_ms: 618 },
    HEART3: { name: "Regulating", frequency_Hz: PHI_SQ, period_ms: 382 },
};

/** Initialize Three Hearts state */
export function initThreeHearts(): ThreeHeartsState {
    return {
        heart1: {
            name: "Metropolis",
            frequency_Hz: 0.1,
            phase: 0,
            amplitude: 1.0,
            active: true
        },
        heart2: {
            name: "Coupling",
            frequency_Hz: PHI,
            phase: 0,
            amplitude: 1.0,
            active: true
        },
        heart3: {
            name: "Regulating",
            frequency_Hz: PHI_SQ,
            phase: 0,
            amplitude: 1.0,
            active: true
        },
        coherence: 1.0,
        timestamp: Date.now()
    };
}

/** Calculate Kuramoto order parameter (coherence) */
export function calculateCoherence(hearts: ThreeHeartsState): number {
    // R = |Σ e^(iθ)| / N
    const phases = [hearts.heart1.phase, hearts.heart2.phase, hearts.heart3.phase];
    let cosSum = 0;
    let sinSum = 0;
    
    for (const phase of phases) {
        cosSum += Math.cos(phase);
        sinSum += Math.sin(phase);
    }
    
    return Math.sqrt(cosSum * cosSum + sinSum * sinSum) / 3;
}

/** Update Three Hearts phases */
export function updateThreeHearts(state: ThreeHeartsState, deltaTime_ms: number): ThreeHeartsState {
    const dt = deltaTime_ms / 1000;  // Convert to seconds
    
    // Update phases: θ(t) = θ₀ + ωt
    const newHeart1: HeartState = {
        ...state.heart1,
        phase: (state.heart1.phase + TAU * state.heart1.frequency_Hz * dt) % TAU
    };
    const newHeart2: HeartState = {
        ...state.heart2,
        phase: (state.heart2.phase + TAU * state.heart2.frequency_Hz * dt) % TAU
    };
    const newHeart3: HeartState = {
        ...state.heart3,
        phase: (state.heart3.phase + TAU * state.heart3.frequency_Hz * dt) % TAU
    };
    
    const newState: ThreeHeartsState = {
        heart1: newHeart1,
        heart2: newHeart2,
        heart3: newHeart3,
        coherence: 0,
        timestamp: Date.now()
    };
    
    newState.coherence = calculateCoherence(newState);
    
    return newState;
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 5: INTELLIGENCE ROUTING
// ═══════════════════════════════════════════════════════════════════════════

export interface IntelligenceQuery {
    input: string;
    context: Record<string, unknown>;
    frequency_Hz: number;
    routing: RoutingType;
}

export type RoutingType = 
    | 'HEART3_ORCHESTRATE'  // φ² Hz - High-level orchestration
    | 'HEART2_SELECT'       // φ Hz - Model selection
    | 'HEART1_COMPUTE'      // 0.1 Hz - Deep computation
    | 'DIRECT';             // Direct to model

export interface IntelligenceResponse {
    output: string;
    modelUsed: string;
    frequency_Hz: number;
    coherence: number;
    animaHash: string;
}

/** Route intelligence query based on complexity */
export function routeIntelligence(query: IntelligenceQuery): RoutingType {
    // Simple queries → DIRECT
    // Medium complexity → HEART2_SELECT
    // High complexity → HEART3_ORCHESTRATE
    // Deep computation → HEART1_COMPUTE
    
    const complexity = estimateComplexity(query.input);
    
    if (complexity < 0.2) return 'DIRECT';
    if (complexity < 0.5) return 'HEART2_SELECT';
    if (complexity < 0.8) return 'HEART3_ORCHESTRATE';
    return 'HEART1_COMPUTE';
}

/** Estimate query complexity (0-1) */
function estimateComplexity(input: string): number {
    // Simple heuristic: length + special tokens
    const length = input.length;
    const hasQuestion = input.includes('?');
    const hasMultiple = input.includes(' and ') || input.includes(' or ');
    
    let complexity = Math.min(length / 500, 0.5);
    if (hasQuestion) complexity += 0.2;
    if (hasMultiple) complexity += 0.3;
    
    return Math.min(complexity, 1.0);
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 6: GOLDEN RATIO LAYOUT SYSTEM
// ═══════════════════════════════════════════════════════════════════════════

export interface GoldenLayout {
    columns: number[];
    rows: number[];
    aspectRatio: number;
    formula: string;
}

/** Generate φ-based grid layout */
export function goldenGrid(totalWidth: number, columns: number): GoldenLayout {
    const columnWidths: number[] = [];
    let remaining = totalWidth;
    
    // Each column is φ⁻¹ times the previous
    for (let i = 0; i < columns; i++) {
        const width = remaining * PHI_INV;
        columnWidths.push(width);
        remaining -= width;
    }
    
    return {
        columns: columnWidths,
        rows: [],
        aspectRatio: PHI,
        formula: `width[i] = total × φ^(-i)`
    };
}

/** Calculate golden rectangle dimensions */
export function goldenRectangle(width: number): { width: number; height: number } {
    return {
        width: width,
        height: width / PHI
    };
}

/** Calculate golden spiral point */
export function goldenSpiralPoint(angle: number, scale: number = 1): { x: number; y: number } {
    // r(θ) = scale × φ^(θ/(π/2))
    const r = scale * Math.pow(PHI, angle / (PI / 2));
    return {
        x: r * Math.cos(angle),
        y: r * Math.sin(angle)
    };
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 7: EXPORT ALL
// ═══════════════════════════════════════════════════════════════════════════

export default {
    // Constants
    PHI, PHI_INV, PHI_SQ, PHI_CUBE, PI, TAU, E, SCHUMANN, C, H,
    
    // Frequency system
    FREQUENCY_LAYERS,
    getFrequencyLayer,
    goldenModelFrequency,
    
    // Components
    INTELLIGENT_COMPONENTS,
    
    // Three Hearts
    THREE_HEARTS,
    initThreeHearts,
    calculateCoherence,
    updateThreeHearts,
    
    // Intelligence
    routeIntelligence,
    
    // Layout
    goldenGrid,
    goldenRectangle,
    goldenSpiralPoint,
};
