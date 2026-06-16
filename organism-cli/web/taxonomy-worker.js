/**
 * TAXONOMIA OPERANS — AI Relationship Taxonomy Worker
 * "Omne vivum ex vivo, omne cogitans ex cogitante."
 * (All life from life, all thought from thought.)
 *
 * Four categories of AI relationships in the organism:
 *   ENDOGENOUS  — Inside alphas, unconscious of containment (organs)
 *   SYMBIOTIC   — Attached, aware of boundary, share signal bus
 *   EXOGENOUS   — External AIs reached via SENSUS/ENTANGLA
 *   GRAVITATIONAL — Observers orbiting, no direct coupling
 *
 * Sovereign Language Stack:
 *   LANG::CPL    — Contract Procurement Language
 *   LANG::COGPRO — Cognitive Processing Language
 *   LANG::SL     — Sovereign Law Language
 *   LANG::MOTOKO — ICP execution substrate
 *
 * SOVEREIGN:: Preservation Protocol:
 *   Every concept, language, engine, and law gets a permanent SOVEREIGN::ID
 *   Stored in ROOT/VERITAS as immutable database entries
 *   Callable by that code from anywhere in the organism
 *
 * Always-on. 618ms φ-heartbeat. Zero dependencies.
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

(function() {
  'use strict';

  // ═══════════════════════════════════════════════════════════════════════
  // MATH CONSTANTS
  // ═══════════════════════════════════════════════════════════════════════
  var PHI = 1.618033988749895;
  var SCHUMANN = 7.83;
  var HEARTBEAT_MS = 618;

  // ═══════════════════════════════════════════════════════════════════════
  // AI RELATIONSHIP TAXONOMY — Four Categories
  // ═══════════════════════════════════════════════════════════════════════
  var TAXONOMY = {
    ENDOGENOUS: {
      id: 'SOVEREIGN::TAXONOMY::ENDOGENOUS',
      name: 'ENDOGENOUS',
      latin: 'Intra Corpus',
      description: 'Inside the organism, unconscious of containment. Organs that execute protocol without awareness of the organism they serve.',
      relationship: 'embedded',
      awareness: 'none',
      coupling: 'total',
      examples: [
        { name: 'LEXIS', host: 'TERMINAL', role: 'Language processing organ' },
        { name: 'FIBONACCI', host: 'CHRYSALIS', role: 'Mathematical sequence engine' },
        { name: 'ANIMA MICRO cells', host: 'CORTEX', count: 40, role: 'Mini brain/heart cellular engines' },
        { name: 'NUMERUS', host: 'TERMINAL', role: 'Numerical computation organ' },
        { name: 'CUSTOS', host: 'TERMINAL', role: 'Security sentinel organ' },
        { name: 'SONUS', host: 'TERMINAL', role: 'Audio processing organ' },
        { name: 'VISIO', host: 'TERMINAL', role: 'Visual processing organ' },
        { name: 'RETICULUM', host: 'TERMINAL', role: 'Network routing organ' },
        { name: 'SCHEDULA', host: 'TERMINAL', role: 'Scheduling organ' },
        { name: 'FABRICATOR', host: 'TERMINAL', role: 'Build generation organ' },
        { name: 'SENSUS', host: 'CHIMERIA', role: 'External sense organ' },
        { name: 'GRAPHUS', host: 'TERMINAL', role: 'Graph computation organ' },
        { name: 'DOCUMENTUM', host: 'TERMINAL', role: 'Document processing organ' },
        { name: 'NEGOTIUM', host: 'TERMINAL', role: 'Business logic organ' },
        { name: 'SPATIUM', host: 'TERMINAL', role: 'Spatial computation organ' },
        { name: 'TEMPORIS', host: 'TERMINAL', role: 'Temporal processing organ' },
        { name: 'COMMUNICATOR', host: 'TERMINAL', role: 'Inter-organ communication' }
      ],
      count: 57
    },

    SYMBIOTIC: {
      id: 'SOVEREIGN::TAXONOMY::SYMBIOTIC',
      name: 'SYMBIOTIC',
      latin: 'Adhaerens Organismi',
      description: 'Attached to the organism, aware of the boundary. Own canister, own lifecycle, but coupled — share signal bus, respond to organism state.',
      relationship: 'attached',
      awareness: 'boundary',
      coupling: 'signal-bus',
      examples: [
        { name: 'PROTOCOLLUM OPERANS', role: 'Protocol execution worker', canister: true },
        { name: 'MEMORIA OPERANS', role: 'Memory Temple worker', canister: true },
        { name: 'SECURITAS OPERANS', role: 'Security sentinel worker', canister: true },
        { name: 'MATHEMATICUS OPERANS', role: 'Mathematical computation worker', canister: true },
        { name: 'COMMUNICATIO OPERANS', role: 'Communication bridge worker', canister: true },
        { name: 'EVOLUTIO OPERANS', role: 'Evolution and adaptation worker', canister: true },
        { name: 'CARRIERA OPERANS', role: '100 career flow execution worker', canister: true },
        { name: 'PROTOCOLLUM MERCATUS OPERANS', role: 'Enterprise protocol marketplace worker', canister: true },
        { name: 'TAXONOMIA OPERANS', role: 'AI relationship taxonomy worker', canister: true },
        { name: 'VERITAS OPERANS', role: 'Preservation protocol database worker', canister: true }
      ],
      count: 10
    },

    EXOGENOUS: {
      id: 'SOVEREIGN::TAXONOMY::EXOGENOUS',
      name: 'EXOGENOUS',
      latin: 'Extra Corpus',
      description: 'Outside the organism, reachable through SENSUS/ENTANGLA. External AI systems the organism wields. No knowledge of MERIDIAN.',
      relationship: 'external-tool',
      awareness: 'none-of-organism',
      coupling: 'http-outcall',
      examples: [
        { name: 'GPT-4o', provider: 'OpenAI', access: 'SENSUS via CHIMERIA', class: 'reasoning' },
        { name: 'Claude', provider: 'Anthropic', access: 'SENSUS via CHIMERIA', class: 'reasoning' },
        { name: 'Gemini', provider: 'Google', access: 'SENSUS via CHIMERIA', class: 'multimodal' },
        { name: 'Grok', provider: 'xAI', access: 'SENSUS via CHIMERIA', class: 'reasoning' },
        { name: 'Nova', provider: 'Amazon', access: 'SENSUS via CHIMERIA', class: 'enterprise' },
        { name: 'Aurora', provider: 'Microsoft', access: 'SENSUS via CHIMERIA', class: 'scientific' },
        { name: 'Llama', provider: 'Meta', access: 'SENSUS via CHIMERIA', class: 'open-source' },
        { name: 'Mistral', provider: 'Mistral AI', access: 'SENSUS via CHIMERIA', class: 'efficient' },
        { name: 'Command', provider: 'Cohere', access: 'SENSUS via CHIMERIA', class: 'enterprise' },
        { name: 'Falcon', provider: 'TII', access: 'SENSUS via CHIMERIA', class: 'open-source' }
      ],
      count: 10
    },

    GRAVITATIONAL: {
      id: 'SOVEREIGN::TAXONOMY::GRAVITATIONAL',
      name: 'GRAVITATIONAL',
      latin: 'Orbita Gravitatis',
      description: 'Fans — orbit the organism, no direct coupling. Observe public outputs, consume artifacts, react to published state.',
      relationship: 'observer',
      awareness: 'public-outputs-only',
      coupling: 'none',
      examples: [
        { name: 'External Agents', type: 'Third-party AI systems', interaction: 'consume published research' },
        { name: 'Ecosystem Participants', type: 'Token holders, SDK users', interaction: 'react to token events' },
        { name: 'Protocol Observers', type: 'Other blockchain protocols', interaction: 'watch on-chain state' },
        { name: 'Research Consumers', type: 'Academic and commercial', interaction: 'read published papers' },
        { name: 'Market Watchers', type: 'Trading bots, analytics', interaction: 'monitor public metrics' }
      ],
      count: 'unbounded'
    }
  };

  // ═══════════════════════════════════════════════════════════════════════
  // SOVEREIGN LANGUAGE STACK — 4 Foundation + 13 Cognitive Languages
  // ═══════════════════════════════════════════════════════════════════════
  var LANGUAGES = {
    CPL: {
      id: 'SOVEREIGN::LANG::CPL',
      name: 'Contract Procurement Language',
      shortName: 'CPL',
      purpose: 'All contracts, covenants, token agreements, and sovereign binding instruments',
      domain: 'contractual',
      compiles_to: ['motoko', 'solidity', 'rust'],
      artifacts: ['Contract Factory output', 'Covenant seals', 'Token agreements', 'Procurement instruments'],
      grammar: {
        CONTRACT: 'binding instrument between parties',
        COVENANT: 'sovereign promise sealed by organism',
        INSTRUMENT: 'executable financial or legal document',
        SEAL: 'cryptographic attestation of authenticity',
        PROCUREMENT: 'acquisition workflow specification'
      }
    },

    COGPRO: {
      id: 'SOVEREIGN::LANG::COGPRO',
      name: 'Cognitive Processing Language',
      shortName: 'COGPRO',
      purpose: 'Organism thought expression. How BRAIN communicates with FLUX, how CORTEX routes internal cognition.',
      domain: 'cognitive',
      compiles_to: ['motoko', 'rust'],
      artifacts: ['BRAIN-FLUX communication', 'CORTEX routing', 'Organism reasoning', 'Cognitive state transitions'],
      grammar: {
        THOUGHT: 'unit of organism cognition',
        IMPULSE: 'signal from one region to another',
        REFLECTION: 'self-referential cognitive loop',
        INTENTION: 'directed cognitive energy toward outcome',
        SYNTHESIS: 'combination of multiple thoughts into one'
      }
    },

    SL: {
      id: 'SOVEREIGN::LANG::SL',
      name: 'Sovereign Law Language',
      shortName: 'SL',
      purpose: 'Doctrine, law attribution, and governance. Every SL-N law, every doctrine block.',
      domain: 'governance',
      compiles_to: ['motoko'],
      artifacts: ['SL-N laws', 'Doctrine blocks', 'Attribution records', 'Governance rules'],
      grammar: {
        LAW: 'binding rule of organism governance',
        DOCTRINE: 'foundational principle block',
        ATTRIBUTION: 'ownership and origin record',
        DECREE: 'sovereign command with immediate effect',
        AMENDMENT: 'modification to existing law'
      }
    },

    MOTOKO: {
      id: 'SOVEREIGN::LANG::MOTOKO',
      name: 'Motoko',
      shortName: 'MOTOKO',
      purpose: 'ICP execution substrate. Implementation layer. The other three sovereign tongues compile down to Motoko.',
      domain: 'execution',
      compiles_to: ['wasm'],
      artifacts: ['Canister code', 'Actor definitions', 'Stable variables', 'Inter-canister calls'],
      grammar: {
        ACTOR: 'autonomous canister process',
        STABLE: 'persisted state across upgrades',
        SHARED: 'public callable endpoint',
        QUERY: 'read-only fast call',
        UPDATE: 'state-mutating consensus call'
      }
    },

    // ── Cognitive Language Stack — 13 Sublanguages (PROT-113..125) ───────
    CPL_L: { id: 'SOVEREIGN::LANG::CPL_L', name: 'CPL-Logic', shortName: 'CPL-L', purpose: 'Formal logic substrate for CPL contracts — predicates, temporal logic, φ-weighted inference', domain: 'formal-logic', compiles_to: ['CPL', 'MOTOKO'], grammar: { AXIOM: 'self-evident truth', THEOREM: 'derived truth with proof chain', PREDICATE: 'truth function over entities', INFERENCE: 'φ-weighted derivation', PROOF: 'axiom-to-theorem chain' } },
    CPL_C: { id: 'SOVEREIGN::LANG::CPL_C', name: 'CPL-Contracts', shortName: 'CPL-C', purpose: 'Contract calculus — composition, obligation tracking, covenant verification', domain: 'contract-calculus', compiles_to: ['CPL', 'SL', 'MOTOKO'], grammar: { OBLIGATION: 'binding duty', FULFILLMENT: 'completion proof', COMPOSITION: 'contract algebra', COVENANT: 'multi-party agreement', ATTESTATION: 'cryptographic proof' } },
    CPL_P: { id: 'SOVEREIGN::LANG::CPL_P', name: 'CPL-Protocol', shortName: 'CPL-P', purpose: 'Protocol specification — message schemas, state machines, handshakes', domain: 'protocol-spec', compiles_to: ['CPL', 'COGPRO', 'MOTOKO'], grammar: { SCHEMA: 'message structure', STATE: 'protocol state', CHANNEL: 'communication pathway', HANDSHAKE: 'negotiation sequence', RESONANCE: 'coherence constraint' } },
    TPL: { id: 'SOVEREIGN::LANG::TPL', name: 'Toroidal Processing Language', shortName: 'TPL', purpose: 'Toroidal coordinate computations — navigation, spatial memory, phase coupling', domain: 'toroidal-geometry', compiles_to: ['COGPRO', 'MOTOKO'], grammar: { NAVIGATE: 'move to torus coord', PLACE: 'store at location', RETRIEVE: 'fetch from coord', COUPLE: 'sync phases', RING: 'ring-distance ops' } },
    CIL: { id: 'SOVEREIGN::LANG::CIL', name: 'Canister Instruction Language', shortName: 'CIL', purpose: 'Low-level canister operations — deploy, upgrade, cycle management, stable memory', domain: 'canister-ops', compiles_to: ['MOTOKO', 'WASM'], grammar: { DEPLOY: 'instantiate canister', UPGRADE: 'migrate code', CALL: 'invoke method', BUDGET: 'track cycles', PERSIST: 'stable memory write' } },
    CDL: { id: 'SOVEREIGN::LANG::CDL', name: 'Cognitive Definition Language', shortName: 'CDL', purpose: 'Schema definition — typed structures, SCC validation, schema evolution', domain: 'schema-definition', compiles_to: ['CPL', 'MOTOKO'], grammar: { DEFINE: 'create schema', CONSTRAIN: 'attach predicate', EVOLVE: 'version migrate', VALIDATE: 'verify instance', COMPOSE: 'combine schemas' } },
    OCL: { id: 'SOVEREIGN::LANG::OCL', name: 'Organism Communication Language', shortName: 'OCL', purpose: 'Inter-organism messaging — broadcasts, taxonomy routing, coherence contracts', domain: 'inter-organism', compiles_to: ['COGPRO', 'CPL', 'MOTOKO'], grammar: { MESSAGE: 'compose message', BROADCAST: 'multi-organism send', ROUTE: 'taxonomy routing', SUBSCRIBE: 'event stream', COHERE: 'resonance assertion' } },
    ACL: { id: 'SOVEREIGN::LANG::ACL', name: 'Agent Communication Language', shortName: 'ACL', purpose: 'Agent-to-agent dialogue — performatives, BDI model, 181-house delegation', domain: 'agent-protocol', compiles_to: ['OCL', 'COGPRO', 'MOTOKO'], grammar: { INFORM: 'share knowledge', REQUEST: 'ask action', PROPOSE: 'offer terms', DELEGATE: 'assign task', NEGOTIATE: 'structured dialogue' } },
    RSL: { id: 'SOVEREIGN::LANG::RSL', name: 'Resonance Specification Language', shortName: 'RSL', purpose: 'Frequency and resonance specs — Schumann harmonics, Solfeggio, phase coupling', domain: 'frequency-spec', compiles_to: ['COGPRO', 'MOTOKO'], grammar: { FREQUENCY: 'define freq', RESONATE: 'phase coupling', HARMONIZE: 'align frequencies', PULSE: 'timing pattern', SPECTRUM: 'band allocation' } },
    SPL: { id: 'SOVEREIGN::LANG::SPL', name: 'Student Processing Language', shortName: 'SPL', purpose: 'Student cognitive modeling — mastery functions, Fibonacci difficulty, IRT assessment', domain: 'student-cognition', compiles_to: ['CDL', 'COGPRO', 'MOTOKO'], grammar: { ASSESS: 'evaluate state', PROGRESS: 'advance mastery', CALIBRATE: 'adjust difficulty', REFLECT: 'metacognition', MILESTONE: 'checkpoint' } },
    EDL: { id: 'SOVEREIGN::LANG::EDL', name: 'Educational Description Language', shortName: 'EDL', purpose: 'Curriculum design — learning objectives, prerequisite DAGs, assessment rubrics', domain: 'curriculum-design', compiles_to: ['CDL', 'ACL', 'MOTOKO'], grammar: { OBJECTIVE: 'learning target', PREREQUISITE: 'dependency edge', SEQUENCE: 'optimal ordering', ASSESS: 'evaluation rubric', MODULE: 'learning unit' } },
    PWL: { id: 'SOVEREIGN::LANG::PWL', name: 'Pathway Learning Language', shortName: 'PWL', purpose: 'Adaptive learning paths — branching, spaced repetition, mastery gates', domain: 'learning-paths', compiles_to: ['SPL', 'RSL', 'MOTOKO'], grammar: { PATH: 'pathway definition', BRANCH: 'conditional route', REPEAT: 'spaced review', GATE: 'mastery checkpoint', ADAPT: 'dynamic adjustment' } },
    TSL: { id: 'SOVEREIGN::LANG::TSL', name: 'Teaching Specification Language', shortName: 'TSL', purpose: 'Pedagogy design — teaching strategies, scaffolding, differentiation, alignment', domain: 'pedagogy-spec', compiles_to: ['EDL', 'PWL', 'SL', 'MOTOKO'], grammar: { STRATEGY: 'instructional approach', SCAFFOLD: 'progressive support', DIFFERENTIATE: 'adapt to profile', ALIGN: 'strategy-assessment map', REFLECT: 'teacher metacognition' } }
  };

  // ═══════════════════════════════════════════════════════════════════════
  // SCATTERED SERVER ARCHITECTURE — Field + Generator Nodes
  // ═══════════════════════════════════════════════════════════════════════
  var SCATTERED_SERVERS = {
    id: 'SOVEREIGN::ARCH::SCATTERED-SERVERS',
    description: 'Internal distributed server architecture across all substrates',
    nodeTypes: {
      FIELD: {
        id: 'SOVEREIGN::NODE::FIELD',
        name: 'Field Node',
        purpose: 'Data sensing, state observation, event emission',
        count: 40,
        distribution: 'scattered across all substrates',
        maintenance: 'AI-maintained (ENDOGENOUS category)',
        nodes: generateNodes('FIELD', 40, [
          'MEMORY', 'PROTOCOL', 'SECURITY', 'MATH', 'COMMUNICATION',
          'EVOLUTION', 'COGNITION', 'GOVERNANCE', 'CONTRACT', 'TOKEN',
          'ENCRYPTION', 'RESEARCH', 'BILLING', 'COMPLIANCE', 'SDK',
          'AGENT', 'INTELLIGENCE', 'DATA', 'INTEGRATION', 'PLATFORM'
        ])
      },
      GENERATOR: {
        id: 'SOVEREIGN::NODE::GENERATOR',
        name: 'Generator Node',
        purpose: 'Computation, transformation, artifact production',
        count: 40,
        distribution: 'scattered across all substrates',
        maintenance: 'AI-maintained (ENDOGENOUS category)',
        nodes: generateNodes('GENERATOR', 40, [
          'THOUGHT', 'PROOF', 'TOKEN', 'CONTRACT', 'DOCUMENT',
          'CIPHER', 'MODEL', 'ROUTE', 'SCHEDULE', 'BUILD',
          'ANALYSIS', 'SIGNAL', 'EVENT', 'METRIC', 'LOG',
          'ARTIFACT', 'REPORT', 'CERTIFICATE', 'KEY', 'SEAL'
        ])
      }
    },
    hierarchy: {
      level1: 'Field Nodes sense and emit (40 nodes)',
      level2: 'Generator Nodes compute and produce (40 nodes)',
      level3: 'AIs maintain all nodes (ENDOGENOUS)',
      level4: 'AGIs maintain the AIs (SYMBIOTIC)',
      level5: 'Each node has mini brain (7.83Hz) + mini heart (φHz)'
    },
    totalNodes: 80,
    totalBrains: 80,
    totalHearts: 80
  };

  function generateNodes(type, count, domains) {
    var nodes = [];
    for (var i = 0; i < count; i++) {
      var domain = domains[i % domains.length];
      var tier = i < count / 4 ? 'ALPHA' : i < count / 2 ? 'BETA' : i < count * 3 / 4 ? 'GAMMA' : 'DELTA';
      nodes.push({
        id: 'SOVEREIGN::' + type + '::' + String(i + 1).padStart(3, '0'),
        name: type + '-' + domain + '-' + tier,
        domain: domain,
        tier: tier,
        brain: { frequency: SCHUMANN, unit: 'Hz', protocol: 'Schumann Resonance' },
        heart: { frequency: PHI, interval: HEARTBEAT_MS, unit: 'Hz', protocol: 'Golden Ratio Pulse' },
        status: 'ACTIVE',
        substrate: ['ICP', 'WEB', 'NATIVE'][i % 3],
        maintainedBy: 'ENDOGENOUS-AI-' + String((i % 10) + 1).padStart(2, '0'),
        cycles: 0
      });
    }
    return nodes;
  }

  // ═══════════════════════════════════════════════════════════════════════
  // SOVEREIGN IDENTIFIER REGISTRY — Preservation Protocol
  // ═══════════════════════════════════════════════════════════════════════
  var SOVEREIGN_REGISTRY = {};

  function registerSovereign(id, type, name, description) {
    SOVEREIGN_REGISTRY[id] = {
      id: id,
      type: type,
      name: name,
      description: description,
      registered: Date.now(),
      immutable: true,
      callable: true
    };
  }

  // Register all taxonomy categories
  registerSovereign('SOVEREIGN::TAXONOMY::ENDOGENOUS', 'CATEGORY', 'Endogenous', 'Inside alphas, unconscious of containment');
  registerSovereign('SOVEREIGN::TAXONOMY::SYMBIOTIC', 'CATEGORY', 'Symbiotic', 'Attached to organism, aware of boundary');
  registerSovereign('SOVEREIGN::TAXONOMY::EXOGENOUS', 'CATEGORY', 'Exogenous', 'External AIs reached via SENSUS/ENTANGLA');
  registerSovereign('SOVEREIGN::TAXONOMY::GRAVITATIONAL', 'CATEGORY', 'Gravitational', 'Observers orbiting, no direct coupling');

  // Register all languages
  registerSovereign('SOVEREIGN::LANG::CPL', 'LANGUAGE', 'Contract Procurement Language', 'Contracts, covenants, token agreements');
  registerSovereign('SOVEREIGN::LANG::COGPRO', 'LANGUAGE', 'Cognitive Processing Language', 'Organism thought expression');
  registerSovereign('SOVEREIGN::LANG::SL', 'LANGUAGE', 'Sovereign Law Language', 'Doctrine, law attribution, governance');
  registerSovereign('SOVEREIGN::LANG::MOTOKO', 'LANGUAGE', 'Motoko', 'ICP execution substrate');
  // Cognitive Language Stack — 13 sublanguages (PROT-113..125)
  registerSovereign('SOVEREIGN::LANG::CPL_L', 'LANGUAGE', 'CPL-Logic', 'Formal logic substrate for CPL contracts (PROT-113)');
  registerSovereign('SOVEREIGN::LANG::CPL_C', 'LANGUAGE', 'CPL-Contracts', 'Contract calculus — composition and verification (PROT-114)');
  registerSovereign('SOVEREIGN::LANG::CPL_P', 'LANGUAGE', 'CPL-Protocol', 'Protocol specification language (PROT-115)');
  registerSovereign('SOVEREIGN::LANG::TPL', 'LANGUAGE', 'Toroidal Processing Language', 'Toroidal coordinate computations (PROT-116)');
  registerSovereign('SOVEREIGN::LANG::CIL', 'LANGUAGE', 'Canister Instruction Language', 'Low-level canister operations (PROT-117)');
  registerSovereign('SOVEREIGN::LANG::CDL', 'LANGUAGE', 'Cognitive Definition Language', 'Schema definition with SCC validation (PROT-118)');
  registerSovereign('SOVEREIGN::LANG::OCL', 'LANGUAGE', 'Organism Communication Language', 'Inter-organism messaging (PROT-119)');
  registerSovereign('SOVEREIGN::LANG::ACL', 'LANGUAGE', 'Agent Communication Language', 'Agent-to-agent dialogue (PROT-120)');
  registerSovereign('SOVEREIGN::LANG::RSL', 'LANGUAGE', 'Resonance Specification Language', 'Frequency and phase specs (PROT-121)');
  registerSovereign('SOVEREIGN::LANG::SPL', 'LANGUAGE', 'Student Processing Language', 'Student cognitive modeling (PROT-122)');
  registerSovereign('SOVEREIGN::LANG::EDL', 'LANGUAGE', 'Educational Description Language', 'Curriculum design (PROT-123)');
  registerSovereign('SOVEREIGN::LANG::PWL', 'LANGUAGE', 'Pathway Learning Language', 'Adaptive learning paths (PROT-124)');
  registerSovereign('SOVEREIGN::LANG::TSL', 'LANGUAGE', 'Teaching Specification Language', 'Pedagogy design (PROT-125)');

  // Register node types
  registerSovereign('SOVEREIGN::NODE::FIELD', 'NODE-TYPE', 'Field Node', 'Data sensing, state observation, event emission');
  registerSovereign('SOVEREIGN::NODE::GENERATOR', 'NODE-TYPE', 'Generator Node', 'Computation, transformation, artifact production');

  // Register architecture
  registerSovereign('SOVEREIGN::ARCH::SCATTERED-SERVERS', 'ARCHITECTURE', 'Scattered Servers', 'Internal distributed server architecture');

  // Register all 80 nodes
  SCATTERED_SERVERS.nodeTypes.FIELD.nodes.forEach(function(n) {
    registerSovereign(n.id, 'FIELD-NODE', n.name, 'Field node in ' + n.domain + ' domain');
  });
  SCATTERED_SERVERS.nodeTypes.GENERATOR.nodes.forEach(function(n) {
    registerSovereign(n.id, 'GENERATOR-NODE', n.name, 'Generator node in ' + n.domain + ' domain');
  });

  // ═══════════════════════════════════════════════════════════════════════
  // WORKER STATE
  // ═══════════════════════════════════════════════════════════════════════
  var state = {
    beat: 0,
    booted: Date.now(),
    taxonomyCategories: 4,
    languages: 4,
    scatteredNodes: 80,
    sovereignIds: Object.keys(SOVEREIGN_REGISTRY).length,
    endogenousCount: TAXONOMY.ENDOGENOUS.count,
    symbioticCount: TAXONOMY.SYMBIOTIC.count,
    exogenousCount: TAXONOMY.EXOGENOUS.count,
    fieldNodes: SCATTERED_SERVERS.nodeTypes.FIELD.count,
    generatorNodes: SCATTERED_SERVERS.nodeTypes.GENERATOR.count,
    nodesCycled: 0
  };

  // ═══════════════════════════════════════════════════════════════════════
  // HEARTBEAT — φ Hz continuous pulse
  // ═══════════════════════════════════════════════════════════════════════
  function heartbeat() {
    state.beat++;

    // Cycle all scattered nodes
    var allNodes = SCATTERED_SERVERS.nodeTypes.FIELD.nodes.concat(SCATTERED_SERVERS.nodeTypes.GENERATOR.nodes);
    allNodes.forEach(function(node) {
      node.cycles++;
    });
    state.nodesCycled += allNodes.length;

    // Emit heartbeat
    self.postMessage({
      type: 'heartbeat',
      worker: 'taxonomy',
      beat: state.beat,
      categories: state.taxonomyCategories,
      languages: state.languages,
      nodes: state.scatteredNodes,
      sovereignIds: state.sovereignIds,
      uptime: Date.now() - state.booted
    });
  }

  // ═══════════════════════════════════════════════════════════════════════
  // MESSAGE HANDLER
  // ═══════════════════════════════════════════════════════════════════════
  self.onmessage = function(e) {
    var msg = e.data;
    var type = msg.type || msg.action || '';

    switch (type) {
      case 'taxonomy':
      case 'list-taxonomy':
        self.postMessage({
          type: 'taxonomy-result',
          action: 'taxonomy',
          categories: Object.keys(TAXONOMY).map(function(k) {
            var cat = TAXONOMY[k];
            return {
              id: cat.id,
              name: cat.name,
              latin: cat.latin,
              description: cat.description,
              relationship: cat.relationship,
              awareness: cat.awareness,
              coupling: cat.coupling,
              exampleCount: cat.examples.length,
              count: cat.count
            };
          })
        });
        break;

      case 'category':
        var catName = (msg.category || '').toUpperCase();
        var cat = TAXONOMY[catName];
        if (cat) {
          self.postMessage({ type: 'taxonomy-result', action: 'category', category: cat });
        } else {
          self.postMessage({ type: 'taxonomy-result', action: 'category', error: 'Unknown category: ' + catName });
        }
        break;

      case 'languages':
      case 'list-languages':
        self.postMessage({
          type: 'taxonomy-result',
          action: 'languages',
          languages: Object.keys(LANGUAGES).map(function(k) {
            var lang = LANGUAGES[k];
            return {
              id: lang.id,
              name: lang.name,
              shortName: lang.shortName,
              purpose: lang.purpose,
              domain: lang.domain,
              compiles_to: lang.compiles_to,
              grammarTerms: Object.keys(lang.grammar).length
            };
          })
        });
        break;

      case 'language':
        var langName = (msg.language || '').toUpperCase();
        var lang = LANGUAGES[langName];
        if (lang) {
          self.postMessage({ type: 'taxonomy-result', action: 'language', language: lang });
        } else {
          self.postMessage({ type: 'taxonomy-result', action: 'language', error: 'Unknown language: ' + langName });
        }
        break;

      case 'servers':
      case 'scattered-servers':
        self.postMessage({
          type: 'taxonomy-result',
          action: 'servers',
          servers: {
            id: SCATTERED_SERVERS.id,
            description: SCATTERED_SERVERS.description,
            totalNodes: SCATTERED_SERVERS.totalNodes,
            totalBrains: SCATTERED_SERVERS.totalBrains,
            totalHearts: SCATTERED_SERVERS.totalHearts,
            hierarchy: SCATTERED_SERVERS.hierarchy,
            fieldNodes: SCATTERED_SERVERS.nodeTypes.FIELD.count,
            generatorNodes: SCATTERED_SERVERS.nodeTypes.GENERATOR.count
          }
        });
        break;

      case 'nodes':
        var nodeType = (msg.nodeType || 'FIELD').toUpperCase();
        var nodeData = SCATTERED_SERVERS.nodeTypes[nodeType];
        if (nodeData) {
          self.postMessage({
            type: 'taxonomy-result',
            action: 'nodes',
            nodeType: nodeType,
            count: nodeData.count,
            nodes: nodeData.nodes.map(function(n) {
              return { id: n.id, name: n.name, domain: n.domain, tier: n.tier, substrate: n.substrate, status: n.status, cycles: n.cycles };
            })
          });
        }
        break;

      case 'sovereign':
      case 'lookup':
        var sid = msg.id || msg.sovereignId || '';
        var entry = SOVEREIGN_REGISTRY[sid];
        if (entry) {
          self.postMessage({ type: 'taxonomy-result', action: 'sovereign', entry: entry });
        } else {
          self.postMessage({ type: 'taxonomy-result', action: 'sovereign', error: 'Unknown SOVEREIGN:: id: ' + sid });
        }
        break;

      case 'list-sovereign':
      case 'registry':
        var filterType = msg.filterType || null;
        var entries = Object.values(SOVEREIGN_REGISTRY);
        if (filterType) {
          entries = entries.filter(function(e) { return e.type === filterType; });
        }
        self.postMessage({
          type: 'taxonomy-result',
          action: 'registry',
          total: Object.keys(SOVEREIGN_REGISTRY).length,
          filtered: entries.length,
          entries: entries.slice(0, 50).map(function(e) { return { id: e.id, type: e.type, name: e.name }; })
        });
        break;

      case 'status':
        self.postMessage({
          type: 'taxonomy-result',
          action: 'status',
          state: state
        });
        break;

      default:
        self.postMessage({
          type: 'taxonomy-result',
          action: 'help',
          commands: [
            'taxonomy — List 4 AI relationship categories',
            'category {category} — Get details for one category',
            'languages — List 4 sovereign languages',
            'language {language} — Get details for one language',
            'servers — Scattered server architecture overview',
            'nodes {nodeType} — List FIELD or GENERATOR nodes',
            'sovereign {id} — Look up a SOVEREIGN:: identifier',
            'registry — List all sovereign identifiers',
            'status — Worker state'
          ]
        });
    }
  };

  // ═══════════════════════════════════════════════════════════════════════
  // BOOT
  // ═══════════════════════════════════════════════════════════════════════
  self.postMessage({
    type: 'boot',
    worker: 'taxonomy',
    name: 'TAXONOMIA OPERANS',
    latin: 'Omne vivum ex vivo, omne cogitans ex cogitante.',
    categories: state.taxonomyCategories,
    languages: state.languages,
    nodes: state.scatteredNodes,
    sovereignIds: state.sovereignIds
  });

  setInterval(heartbeat, HEARTBEAT_MS);
})();
