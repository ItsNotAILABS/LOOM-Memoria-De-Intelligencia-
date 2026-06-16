/**
 * LINGUAE COGITANTES — Cognitive Language Stack Worker
 * "Tredecim linguae, una mens." (Thirteen languages, one mind.)
 *
 * Web Worker #28 | PROT-113 Live Implementation
 *
 * Permanent Web Worker serving the 13-language Cognitive Language Stack.
 * Three phases of sovereign cognitive sublanguages extending
 * CPL/COGPRO/SL/MOTOKO:
 *
 *   Phase 1 (Formal Specs):  CPL-L, CPL-C, CPL-P, TPL, CIL
 *   Phase 2 (Parsers):       CDL, OCL, ACL, RSL
 *   Phase 3 (Education):     SPL, EDL, PWL, TSL
 *
 * Protocol: postMessage
 *   Main → Worker: { type: 'list' }                      — all 13 language summaries
 *   Main → Worker: { type: 'get', id: 'CPL_L' }          — full spec by id
 *   Main → Worker: { type: 'phase', phase: 1|2|3 }       — filter by phase
 *   Main → Worker: { type: 'domain', domain: '...' }     — filter by domain
 *   Main → Worker: { type: 'parse', lang: 'TPL', code: 'NAVIGATE 1.5 2.3 0.8' }
 *   Main → Worker: { type: 'validate', name: '...', weight: N }
 *   Main → Worker: { type: 'deps' }                      — dependency graph
 *   Main → Worker: { type: 'manifest' }                  — full stack manifest
 *   Main → Worker: { type: 'status' }                    — worker status
 *   Worker → Main: { type: 'booted', languages: 13, phases: 3, protocols: 'PROT-113..125' }
 *   Worker → Main: { type: 'heartbeat', beat, languages, uptime }
 *
 * Zero dependencies. Always-on. 618ms φ-heartbeat.
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

'use strict';

// ── ANIMA MICRO ───────────────────────────────────────────────────────────────
const PHI       = 1.6180339887;
const PHI_SQ    = PHI * PHI;
const BEAT_MS   = Math.round(1000 / PHI); // ≈ 618ms
const SCHUMANN  = 7.83;

let beatCount = 0;
let queryCount = 0;
const startTime = Date.now();

// ═══════════════════════════════════════════════════════════════════════════════
// LANGUAGE DATABASE — 13 Cognitive Languages
// ═══════════════════════════════════════════════════════════════════════════════

const LANGUAGES = [
  // ── Phase 1: Formal Specification Languages ─────────────────────────────
  {
    id: 'CPL_L',
    sovereignId: 'SOVEREIGN::LANG::CPL_L',
    protocolId: 'PROT-113',
    fullName: 'CPL-Logic — Cognitive Procurement Logic',
    shortName: 'CPL-L',
    domain: 'formal-logic',
    phase: 1,
    dependsOn: ['CPL'],
    compilesTo: ['CPL', 'MOTOKO'],
    mathBasis: 'First-order predicate logic + temporal operators (□, ◇, U, R) + φ-weighted inference',
    scc: 2.84,
    primitives: {
      AXIOM: 'Self-evident truth requiring no proof',
      THEOREM: 'Derived truth with complete proof chain',
      PREDICATE: 'Truth function over sovereign entities',
      INFERENCE: 'φ-weighted logical derivation step',
      PROOF: 'Complete chain from axioms to theorem'
    },
    description: 'The formal logic substrate underlying all CPL contracts.'
  },
  {
    id: 'CPL_C',
    sovereignId: 'SOVEREIGN::LANG::CPL_C',
    protocolId: 'PROT-114',
    fullName: 'CPL-Contracts — Cognitive Contract Calculus',
    shortName: 'CPL-C',
    domain: 'contract-calculus',
    phase: 1,
    dependsOn: ['CPL', 'SL'],
    compilesTo: ['CPL', 'SL', 'MOTOKO'],
    mathBasis: 'Process algebra + obligation logic (O, F, P operators) + φ-calculus',
    scc: 2.90,
    primitives: {
      OBLIGATION: 'Binding duty with deadline and penalty',
      FULFILLMENT: 'Proof of obligation completion',
      COMPOSITION: 'Algebraic combination of contracts',
      COVENANT: 'Multi-party sovereign binding agreement',
      ATTESTATION: 'Cryptographic proof of contract state'
    },
    description: 'Formal calculus for contract composition, transformation, and verification.'
  },
  {
    id: 'CPL_P',
    sovereignId: 'SOVEREIGN::LANG::CPL_P',
    protocolId: 'PROT-115',
    fullName: 'CPL-Protocol — Cognitive Protocol Specification',
    shortName: 'CPL-P',
    domain: 'protocol-spec',
    phase: 1,
    dependsOn: ['CPL', 'COGPRO'],
    compilesTo: ['CPL', 'COGPRO', 'MOTOKO'],
    mathBasis: 'Communicating Sequential Processes (CSP) + torus topology mapping',
    scc: 2.86,
    primitives: {
      SCHEMA: 'Typed message structure with torus coordinate typing',
      STATE: 'Protocol state with φ-timed transition rules',
      CHANNEL: 'Typed communication pathway between organisms',
      HANDSHAKE: 'Negotiation sequence specification',
      RESONANCE: 'Frequency and coherence constraint'
    },
    description: 'Formal language for specifying organism communication protocols.'
  },
  {
    id: 'TPL',
    sovereignId: 'SOVEREIGN::LANG::TPL',
    protocolId: 'PROT-116',
    fullName: 'Toroidal Processing Language',
    shortName: 'TPL',
    domain: 'toroidal-geometry',
    phase: 1,
    dependsOn: ['COGPRO', 'CPL'],
    compilesTo: ['COGPRO', 'MOTOKO'],
    mathBasis: 'Toroidal geometry T²(θ,φ,ρ) + Kuramoto coupling + Method of Loci',
    scc: 2.93,
    primitives: {
      NAVIGATE: 'Move to torus coordinate (θ, φ, ρ)',
      PLACE: 'Store datum at spatial memory location',
      RETRIEVE: 'Fetch datum from torus coordinate',
      COUPLE: 'Synchronize phases between oscillators',
      RING: 'Operate on organisms at specified ring distance'
    },
    description: 'Specialized language for computations on toroidal coordinate space.'
  },
  {
    id: 'CIL',
    sovereignId: 'SOVEREIGN::LANG::CIL',
    protocolId: 'PROT-117',
    fullName: 'Canister Instruction Language',
    shortName: 'CIL',
    domain: 'canister-ops',
    phase: 1,
    dependsOn: ['MOTOKO'],
    compilesTo: ['MOTOKO', 'WASM'],
    mathBasis: 'Instruction set architecture + cycle accounting + φ-scaling',
    scc: 2.83,
    primitives: {
      DEPLOY: 'Instantiate canister with initial state',
      UPGRADE: 'Migrate canister preserving stable memory',
      CALL: 'Invoke method on target canister',
      BUDGET: 'Allocate and track cycle consumption',
      PERSIST: 'Write to stable memory with provenance'
    },
    description: 'Low-level instruction language for canister operations.'
  },

  // ── Phase 2: Parser & Communication Languages ───────────────────────────
  {
    id: 'CDL',
    sovereignId: 'SOVEREIGN::LANG::CDL',
    protocolId: 'PROT-118',
    fullName: 'Cognitive Definition Language',
    shortName: 'CDL',
    domain: 'schema-definition',
    phase: 2,
    dependsOn: ['CPL_L', 'CPL_C'],
    compilesTo: ['CPL', 'MOTOKO'],
    mathBasis: 'Type theory Γ ⊢ t : T + SCC optimization + schema evolution algebra',
    scc: 2.87,
    primitives: {
      DEFINE: 'Create new typed schema with SCC annotation',
      CONSTRAIN: 'Attach logical predicate to field',
      EVOLVE: 'Specify schema version migration',
      VALIDATE: 'Verify instance against schema + SCC',
      COMPOSE: 'Combine schemas into composite structure'
    },
    description: 'Schema definition language for all cognitive data structures.'
  },
  {
    id: 'OCL',
    sovereignId: 'SOVEREIGN::LANG::OCL',
    protocolId: 'PROT-119',
    fullName: 'Organism Communication Language',
    shortName: 'OCL',
    domain: 'inter-organism',
    phase: 2,
    dependsOn: ['CPL_P', 'COGPRO'],
    compilesTo: ['COGPRO', 'CPL', 'MOTOKO'],
    mathBasis: 'Coupled oscillator networks + taxonomy routing + resonance threshold',
    scc: 2.97,
    primitives: {
      MESSAGE: 'Compose typed inter-organism message',
      BROADCAST: 'Send to multiple organisms with coherence floor',
      ROUTE: 'Direct message via taxonomy-aware pathways',
      SUBSCRIBE: 'Register for organism event stream',
      COHERE: 'Assert minimum resonance for communication'
    },
    description: 'High-level language for inter-organism message composition.'
  },
  {
    id: 'ACL',
    sovereignId: 'SOVEREIGN::LANG::ACL',
    protocolId: 'PROT-120',
    fullName: 'Agent Communication Language',
    shortName: 'ACL',
    domain: 'agent-protocol',
    phase: 2,
    dependsOn: ['OCL', 'CIL'],
    compilesTo: ['OCL', 'COGPRO', 'MOTOKO'],
    mathBasis: 'Speech act theory + BDI logic + 181-house hierarchy',
    scc: 2.80,
    primitives: {
      INFORM: 'Share knowledge with target agent',
      REQUEST: 'Ask agent to perform action',
      PROPOSE: 'Offer terms for negotiation',
      DELEGATE: 'Assign task to subordinate house agent',
      NEGOTIATE: 'Multi-turn structured dialogue sequence'
    },
    description: 'Protocol for AI agent-to-agent structured dialogue.'
  },
  {
    id: 'RSL',
    sovereignId: 'SOVEREIGN::LANG::RSL',
    protocolId: 'PROT-121',
    fullName: 'Resonance Specification Language',
    shortName: 'RSL',
    domain: 'frequency-spec',
    phase: 2,
    dependsOn: ['TPL', 'COGPRO'],
    compilesTo: ['COGPRO', 'MOTOKO'],
    mathBasis: 'Fourier analysis + Schumann 7.83Hz + Solfeggio frequencies',
    scc: 2.90,
    primitives: {
      FREQUENCY: 'Define operating frequency with tolerance',
      RESONATE: 'Specify phase coupling between entities',
      HARMONIZE: 'Align multiple frequencies to harmonic series',
      PULSE: 'Define rhythmic timing pattern',
      SPECTRUM: 'Declare full frequency band allocation'
    },
    description: 'Language for defining frequency, resonance, and phase specifications.'
  },

  // ── Phase 3: Education Languages ────────────────────────────────────────
  {
    id: 'SPL',
    sovereignId: 'SOVEREIGN::LANG::SPL',
    protocolId: 'PROT-122',
    fullName: 'Student Processing Language',
    shortName: 'SPL',
    domain: 'student-cognition',
    phase: 3,
    dependsOn: ['CDL', 'EDL'],
    compilesTo: ['CDL', 'COGPRO', 'MOTOKO'],
    mathBasis: 'Item Response Theory + φ-mastery functions + Fibonacci difficulty',
    scc: 2.77,
    primitives: {
      ASSESS: 'Evaluate student knowledge state vector',
      PROGRESS: 'Advance student along φ-scaled mastery path',
      CALIBRATE: 'Adjust difficulty using Fibonacci scaling',
      REFLECT: 'Trigger student metacognitive reflection',
      MILESTONE: 'Mark mastery achievement checkpoint'
    },
    description: 'Cognitive modeling language for student learning states.'
  },
  {
    id: 'EDL',
    sovereignId: 'SOVEREIGN::LANG::EDL',
    protocolId: 'PROT-123',
    fullName: 'Educational Description Language',
    shortName: 'EDL',
    domain: 'curriculum-design',
    phase: 3,
    dependsOn: ['CDL', 'ACL'],
    compilesTo: ['CDL', 'ACL', 'MOTOKO'],
    mathBasis: 'Directed acyclic graphs + topological sort + φ-weighted edges',
    scc: 2.83,
    primitives: {
      OBJECTIVE: 'Define measurable learning target with SCC name',
      PREREQUISITE: 'Declare knowledge dependency edge',
      SEQUENCE: 'Order content for optimal learning path',
      ASSESS: 'Define evaluation rubric with mastery thresholds',
      MODULE: 'Compose objectives into coherent learning unit'
    },
    description: 'Curriculum and course design language.'
  },
  {
    id: 'PWL',
    sovereignId: 'SOVEREIGN::LANG::PWL',
    protocolId: 'PROT-124',
    fullName: 'Pathway Learning Language',
    shortName: 'PWL',
    domain: 'learning-paths',
    phase: 3,
    dependsOn: ['SPL', 'RSL'],
    compilesTo: ['SPL', 'RSL', 'MOTOKO'],
    mathBasis: 'Adaptive algorithms + spaced repetition + mastery gates',
    scc: 2.87,
    primitives: {
      PATH: 'Define learning pathway with branch points',
      BRANCH: 'Conditional route based on student state',
      REPEAT: 'Schedule Fibonacci-timed review',
      GATE: 'Mastery checkpoint requiring minimum resonance',
      ADAPT: 'Dynamically adjust path based on performance'
    },
    description: 'Adaptive learning pathway specification.'
  },
  {
    id: 'TSL',
    sovereignId: 'SOVEREIGN::LANG::TSL',
    protocolId: 'PROT-125',
    fullName: 'Teaching Specification Language',
    shortName: 'TSL',
    domain: 'pedagogy-spec',
    phase: 3,
    dependsOn: ['EDL', 'PWL'],
    compilesTo: ['EDL', 'PWL', 'SL', 'MOTOKO'],
    mathBasis: 'Pedagogical frameworks + scaffolding decay + φ-alignment',
    scc: 2.80,
    primitives: {
      STRATEGY: 'Define instructional approach with target outcomes',
      SCAFFOLD: 'Progressive support structure with φ-decay',
      DIFFERENTIATE: 'Adapt instruction based on student profile',
      ALIGN: 'Map teaching strategy to assessment criteria',
      REFLECT: 'Teacher metacognitive analysis specification'
    },
    description: 'Pedagogy and instruction design language.'
  }
];

// ═══════════════════════════════════════════════════════════════════════════════
// INDEXES
// ═══════════════════════════════════════════════════════════════════════════════

const idIndex = {};
const domainIndex = {};
const phaseIndex = { 1: [], 2: [], 3: [] };

for (const lang of LANGUAGES) {
  idIndex[lang.id] = lang;
  if (!domainIndex[lang.domain]) domainIndex[lang.domain] = [];
  domainIndex[lang.domain].push(lang);
  phaseIndex[lang.phase].push(lang);
}

// ═══════════════════════════════════════════════════════════════════════════════
// PARSER — Simple primitive expression parser
// ═══════════════════════════════════════════════════════════════════════════════

function parsePrimitive(langId, code) {
  const lang = idIndex[langId];
  if (!lang) return { success: false, error: 'Unknown language: ' + langId };

  const parts = (code || '').trim().split(/\s+/);
  if (parts.length === 0 || parts[0] === '') {
    return { success: false, error: 'Empty expression' };
  }

  const primName = parts[0];
  if (!lang.primitives[primName]) {
    return {
      success: false,
      language: langId,
      primitive: primName,
      error: 'Unknown primitive \'' + primName + '\' in language ' + langId +
             '. Valid: ' + Object.keys(lang.primitives).join(', ')
    };
  }

  return {
    success: true,
    language: langId,
    primitive: primName,
    definition: lang.primitives[primName],
    arguments: parts.slice(1),
    argCount: parts.length - 1
  };
}

// ═══════════════════════════════════════════════════════════════════════════════
// SCC VALIDATOR
// ═══════════════════════════════════════════════════════════════════════════════

function validateSCC(name, weight) {
  const chars = (name || '').length;
  if (chars === 0) return { scc: 0, phiOptimal: false };
  const scc = weight / chars;
  return { scc: scc, phiOptimal: scc >= PHI_SQ, threshold: PHI_SQ };
}

// ═══════════════════════════════════════════════════════════════════════════════
// DEPENDENCY GRAPH
// ═══════════════════════════════════════════════════════════════════════════════

function getDependencyGraph() {
  const edges = [];
  for (const lang of LANGUAGES) {
    for (const dep of lang.dependsOn) {
      edges.push({ from: lang.id, to: dep });
    }
  }
  return edges;
}

// ═══════════════════════════════════════════════════════════════════════════════
// MANIFEST
// ═══════════════════════════════════════════════════════════════════════════════

function getManifest() {
  return {
    totalLanguages: LANGUAGES.length,
    phases: 3,
    protocolRange: 'PROT-113..PROT-125',
    sccThreshold: PHI_SQ,
    allPhiOptimal: LANGUAGES.every(function(l) { return l.scc >= PHI_SQ; }),
    domains: Object.keys(domainIndex),
    phaseBreakdown: {
      'Phase 1 — Formal Specs': phaseIndex[1].map(function(l) { return l.shortName; }),
      'Phase 2 — Parsers': phaseIndex[2].map(function(l) { return l.shortName; }),
      'Phase 3 — Education': phaseIndex[3].map(function(l) { return l.shortName; })
    },
    languages: LANGUAGES.map(function(l) {
      return { id: l.id, name: l.fullName, phase: l.phase, domain: l.domain, protocol: l.protocolId, scc: l.scc };
    }),
    timestamp: Date.now()
  };
}

// ═══════════════════════════════════════════════════════════════════════════════
// STATUS
// ═══════════════════════════════════════════════════════════════════════════════

function getStatus() {
  return {
    worker: 'LINGUAE COGITANTES',
    workerNumber: 28,
    protocol: 'PROT-113',
    languages: LANGUAGES.length,
    phases: 3,
    domains: Object.keys(domainIndex).length,
    queries: queryCount,
    beat: beatCount,
    uptime: Date.now() - startTime,
    phi: PHI,
    heartbeatMs: BEAT_MS,
    isAlive: true
  };
}

// ═══════════════════════════════════════════════════════════════════════════════
// HEARTBEAT — 618ms permanent φ-pulse
// ═══════════════════════════════════════════════════════════════════════════════

setInterval(function() {
  beatCount++;
  postMessage({
    type: 'heartbeat',
    beat: beatCount,
    languages: LANGUAGES.length,
    phases: 3,
    uptime: Date.now() - startTime,
    phi: PHI
  });
}, BEAT_MS);

// ═══════════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════════

onmessage = function(e) {
  var msg = e.data;
  queryCount++;

  try {
    switch (msg.type) {
      case 'list':
        postMessage({
          type: 'list',
          languages: LANGUAGES.map(function(l) {
            return {
              id: l.id,
              shortName: l.shortName,
              fullName: l.fullName,
              domain: l.domain,
              phase: l.phase,
              scc: l.scc,
              protocol: l.protocolId
            };
          })
        });
        break;

      case 'get':
        var lang = idIndex[msg.id];
        postMessage({
          type: 'get',
          found: !!lang,
          language: lang || null
        });
        break;

      case 'phase':
        var phaseLangs = phaseIndex[msg.phase] || [];
        postMessage({
          type: 'phase',
          phase: msg.phase,
          languages: phaseLangs
        });
        break;

      case 'domain':
        var domainLangs = domainIndex[msg.domain] || [];
        postMessage({
          type: 'domain',
          domain: msg.domain,
          languages: domainLangs
        });
        break;

      case 'parse':
        postMessage({
          type: 'parse',
          result: parsePrimitive(msg.lang, msg.code)
        });
        break;

      case 'validate':
        postMessage({
          type: 'validate',
          result: validateSCC(msg.name, msg.weight)
        });
        break;

      case 'deps':
        postMessage({
          type: 'deps',
          edges: getDependencyGraph(),
          nodeCount: LANGUAGES.length
        });
        break;

      case 'manifest':
        postMessage({
          type: 'manifest',
          manifest: getManifest()
        });
        break;

      case 'status':
        postMessage({
          type: 'status',
          status: getStatus()
        });
        break;

      default:
        postMessage({
          type: 'error',
          message: 'Unknown command: ' + msg.type +
                   '. Valid: list, get, phase, domain, parse, validate, deps, manifest, status'
        });
    }
  } catch (err) {
    postMessage({
      type: 'error',
      message: err.message || String(err)
    });
  }
};

// ═══════════════════════════════════════════════════════════════════════════════
// BOOT SIGNAL
// ═══════════════════════════════════════════════════════════════════════════════

postMessage({
  type: 'booted',
  worker: 'LINGUAE COGITANTES',
  workerNumber: 28,
  languages: LANGUAGES.length,
  phases: 3,
  protocols: 'PROT-113..PROT-125',
  domains: Object.keys(domainIndex).length,
  phi: PHI,
  heartbeatMs: BEAT_MS
});
