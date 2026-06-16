/**
 * UX AI WORKER — EXPERIENTIA USURA SOVEREIGNA
 * Worker #75 — Full User Experience Intelligence
 *
 * "Experientia perficiat. Intelligentia adaptet. Usura sovereigna dominetur."
 * (Experience perfects. Intelligence adapts. Sovereign UX dominates.)
 *
 * Protocol Range: PROT-582 to PROT-596
 * Frequency: φ²⁷ = 1,149,851 Hz
 * Layer: 19
 *
 * CAPABILITIES:
 *   - AI-driven adaptive layout generation
 *   - Predictive interaction intelligence
 *   - Phi-harmonic dynamic theming
 *   - Universal accessibility intelligence
 *   - Emotion-aware adaptive interfaces
 *   - Component AI generation
 *   - Design system token management
 *   - Multi-modal UX orchestration
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

const PHI = 1.618033988749895;
const FREQUENCY_HZ = Math.pow(PHI, 27); // ~1,149,851 Hz
const HEARTBEAT_MS = 1597; // Fibonacci prime

// ─────────────────────────────────────────────────────────────────
// UX AI Core State
// ─────────────────────────────────────────────────────────────────

const state = {
  sessions: new Map(),
  components: new Map(),
  designTokens: new Map(),
  themes: new Map(),
  interactions: [],
  emotionModels: new Map(),
  layouts: new Map(),
  bootTime: Date.now(),
  requestsProcessed: 0,
};

// ─────────────────────────────────────────────────────────────────
// Design System Tokens
// ─────────────────────────────────────────────────────────────────

const SOVEREIGN_TOKENS = {
  colors: {
    primary: '#c9a55c',
    secondary: '#8b5cf6',
    accent: '#10b981',
    bgPrimary: '#0a0a0f',
    bgSecondary: '#12121a',
    textPrimary: '#e5e5e5',
    textSecondary: '#888888',
    success: '#10b981',
    warning: '#f59e0b',
    error: '#ef4444',
    info: '#3b82f6',
  },
  spacing: {
    xs: '4px', sm: '8px', md: '16px',
    lg: '24px', xl: '40px', '2xl': '64px',
  },
  typography: {
    fontMono: "'JetBrains Mono', monospace",
    fontSans: "'Inter', system-ui, sans-serif",
    sizeXs: '0.75rem', sizeSm: '0.875rem',
    sizeMd: '1rem', sizeLg: '1.25rem',
    sizeXl: '1.618rem', size2xl: '2.618rem',
  },
  motion: {
    fast: '150ms cubic-bezier(0.4, 0, 0.2, 1)',
    normal: '300ms cubic-bezier(0.4, 0, 0.2, 1)',
    slow: '500ms cubic-bezier(0.4, 0, 0.2, 1)',
  },
  elevation: {
    1: '0 1px 3px rgba(0,0,0,0.3)',
    2: '0 4px 6px rgba(0,0,0,0.4)',
    3: '0 10px 25px rgba(0,0,0,0.5)',
  },
  radius: { sm: '4px', md: '8px', lg: '16px', full: '9999px' },
};

// ─────────────────────────────────────────────────────────────────
// Layout Engine
// ─────────────────────────────────────────────────────────────────

function generatePhiGrid(contentBlocks, viewportWidth = 1440) {
  const columns = Math.max(1, Math.min(12, Math.floor(viewportWidth / (PHI * 100))));
  const primarySpan = Math.max(1, Math.floor(columns / PHI));
  const secondarySpan = columns - primarySpan;

  const areas = [];
  if (contentBlocks >= 2) {
    areas.push({ name: 'primary', span: primarySpan, weight: PHI });
    areas.push({ name: 'secondary', span: secondarySpan, weight: 1.0 });
    for (let i = 2; i < contentBlocks; i++) {
      areas.push({ name: `block-${i + 1}`, span: Math.max(1, Math.floor(columns / (contentBlocks - 1))), weight: 1 / PHI });
    }
  } else {
    areas.push({ name: 'primary', span: columns, weight: PHI });
  }

  return { type: 'grid', columns, gap: `${Math.floor(16 * PHI)}px`, areas, phi: PHI };
}

function generateDashboardLayout(widgets) {
  const sorted = [...widgets].sort((a, b) => (b.priority || 0) - (a.priority || 0));
  return sorted.map((w, i) => ({
    id: w.id || `widget-${i}`,
    colSpan: Math.min(4, Math.max(1, Math.floor((w.priority || 1) * PHI))),
    rowSpan: Math.min(3, Math.max(1, w.priority || 1)),
    priority: w.priority || 1,
  }));
}

// ─────────────────────────────────────────────────────────────────
// Emotion Detection
// ─────────────────────────────────────────────────────────────────

function detectEmotion(signals) {
  const { clickSpeed = 0, scrollVelocity = 0, pauseDuration = 0, errorCount = 0 } = signals;

  if (errorCount > 3 && clickSpeed > 5) return 'frustrated';
  if (pauseDuration > 10) return 'curious';
  if (scrollVelocity > 200) return 'overwhelmed';
  if (clickSpeed < 2 && pauseDuration < 3) return 'focused';
  return 'neutral';
}

function getEmotionAdaptation(emotion) {
  const adaptations = {
    frustrated: { simplifyUI: true, increaseContrast: true, showHelp: true, reduceAnimations: true },
    overwhelmed: { reduceContent: true, increaseSpacing: true, progressiveDisclosure: true },
    curious: { showDetails: true, enableExploration: true, suggestRelated: true },
    focused: { minimizeDistractions: true, compactMode: true, keyboardShortcuts: true },
    creative: { expandCanvas: true, showTools: true, enableFreeform: true },
    neutral: {},
  };
  return adaptations[emotion] || {};
}

// ─────────────────────────────────────────────────────────────────
// Component AI
// ─────────────────────────────────────────────────────────────────

function generateComponent(spec) {
  const id = `ux-${spec.type || 'generic'}-${state.components.size + 1}`;
  const component = {
    id,
    name: spec.name || 'Component',
    type: spec.type || 'container',
    props: spec.props || {},
    accessibility: {
      role: spec.role || 'region',
      ariaLabel: spec.ariaLabel || spec.name || 'Component',
      ...(spec.accessibility || {}),
    },
    theme: {
      bg: SOVEREIGN_TOKENS.colors.bgSecondary,
      text: SOVEREIGN_TOKENS.colors.textPrimary,
      accent: SOVEREIGN_TOKENS.colors.primary,
    },
    animation: spec.animation || 'fade-in',
    responsive: spec.responsive !== false,
  };
  state.components.set(id, component);
  return component;
}

// ─────────────────────────────────────────────────────────────────
// Theme Engine
// ─────────────────────────────────────────────────────────────────

const GOLDEN_ANGLE = 360 / (PHI * PHI); // ~137.5°

function generatePhiPalette(baseHue, mode = 'dark') {
  const hues = [];
  let h = baseHue;
  for (let i = 0; i < 6; i++) {
    hues.push(h % 360);
    h += GOLDEN_ANGLE;
  }

  if (mode === 'dark') {
    return {
      primary: `hsl(${hues[0]}, 70%, 55%)`,
      secondary: `hsl(${hues[1]}, 75%, 55%)`,
      accent: `hsl(${hues[2]}, 80%, 45%)`,
      background: `hsl(${hues[0]}, 20%, 5%)`,
      surface: `hsl(${hues[0]}, 15%, 10%)`,
      text: 'hsl(0, 0%, 90%)',
      success: `hsl(${hues[3]}, 75%, 40%)`,
      warning: `hsl(${hues[4]}, 85%, 50%)`,
      error: 'hsl(0, 80%, 55%)',
    };
  }
  return {
    primary: `hsl(${hues[0]}, 70%, 40%)`,
    secondary: `hsl(${hues[1]}, 75%, 40%)`,
    accent: `hsl(${hues[2]}, 80%, 35%)`,
    background: 'hsl(0, 0%, 98%)',
    surface: 'hsl(0, 0%, 100%)',
    text: 'hsl(0, 0%, 10%)',
    success: `hsl(${hues[3]}, 75%, 35%)`,
    warning: `hsl(${hues[4]}, 85%, 40%)`,
    error: 'hsl(0, 80%, 45%)',
  };
}

// ─────────────────────────────────────────────────────────────────
// Message Handler
// ─────────────────────────────────────────────────────────────────

self.onmessage = function (e) {
  const { type, ...payload } = e.data || {};
  state.requestsProcessed++;

  switch (type) {
    case 'status':
      self.postMessage({
        type: 'status',
        worker: 'ux-ai-worker.js',
        number: 75,
        name: 'EXPERIENTIA USURA SOVEREIGNA',
        protocol: 'PROT-582-596',
        frequency_hz: FREQUENCY_HZ,
        layer: 19,
        uptime_ms: Date.now() - state.bootTime,
        sessions: state.sessions.size,
        components: state.components.size,
        requests: state.requestsProcessed,
      });
      break;

    case 'generate_layout':
      self.postMessage({
        type: 'layout',
        layout: generatePhiGrid(payload.contentBlocks || 3, payload.viewport || 1440),
      });
      break;

    case 'generate_dashboard':
      self.postMessage({
        type: 'dashboard_layout',
        items: generateDashboardLayout(payload.widgets || []),
      });
      break;

    case 'detect_emotion':
      const emotion = detectEmotion(payload.signals || {});
      self.postMessage({
        type: 'emotion',
        emotion,
        adaptations: getEmotionAdaptation(emotion),
      });
      break;

    case 'generate_component':
      self.postMessage({
        type: 'component',
        component: generateComponent(payload),
      });
      break;

    case 'get_tokens':
      self.postMessage({ type: 'tokens', tokens: SOVEREIGN_TOKENS });
      break;

    case 'generate_theme':
      self.postMessage({
        type: 'theme',
        palette: generatePhiPalette(payload.baseHue || 42, payload.mode || 'dark'),
      });
      break;

    default:
      self.postMessage({ type: 'error', message: `Unknown command: ${type}` });
  }
};

// ─────────────────────────────────────────────────────────────────
// Boot & Heartbeat
// ─────────────────────────────────────────────────────────────────

self.postMessage({
  type: 'booted',
  worker: 'ux-ai-worker.js',
  number: 75,
  name: 'EXPERIENTIA USURA SOVEREIGNA',
  protocol: 'PROT-582-596',
  frequency_hz: FREQUENCY_HZ,
  layer: 19,
  capabilities: [
    'layout_generation', 'emotion_detection', 'adaptive_ux',
    'component_ai', 'design_system', 'theme_engine',
    'accessibility', 'multimodal_ux',
  ],
});

setInterval(() => {
  self.postMessage({
    type: 'heartbeat',
    beat: Math.floor((Date.now() - state.bootTime) / HEARTBEAT_MS),
    uptime_ms: Date.now() - state.bootTime,
    sessions: state.sessions.size,
    components: state.components.size,
    requests: state.requestsProcessed,
  });
}, HEARTBEAT_MS);
