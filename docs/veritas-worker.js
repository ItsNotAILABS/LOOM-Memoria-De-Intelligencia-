/**
 * VERITAS OPERANS — ROOT/VERITAS Preservation Protocol Worker
 * "Veritas numquam perit." (Truth never perishes.)
 *
 * The immutable sovereign identifier database.
 * Every concept, language, engine, law, and named artifact gets
 * a SOVEREIGN:: identifier that is:
 *   - Stored permanently in ROOT/VERITAS
 *   - Callable by that code from anywhere in the organism
 *   - Referenced by that code in every build prompt
 *
 * Format: SOVEREIGN::<DOMAIN>::<NAME>
 *
 * This is the preservation protocol — how work never gets lost.
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
  var HEARTBEAT_MS = 618;

  // ═══════════════════════════════════════════════════════════════════════
  // ROOT/VERITAS — The Immutable Sovereign Identifier Database
  // ═══════════════════════════════════════════════════════════════════════
  var VERITAS = {};
  var VERITAS_LOG = [];

  function store(id, type, name, description, metadata) {
    if (VERITAS[id]) {
      return { success: false, reason: 'SOVEREIGN:: id already exists (immutable)', id: id };
    }
    var entry = {
      id: id,
      type: type,
      name: name,
      description: description,
      metadata: metadata || {},
      storedAt: Date.now(),
      immutable: true,
      callable: true,
      version: 1
    };
    VERITAS[id] = entry;
    VERITAS_LOG.push({ action: 'STORE', id: id, at: entry.storedAt });
    return { success: true, id: id, entry: entry };
  }

  function lookup(id) {
    return VERITAS[id] || null;
  }

  function search(query) {
    var q = (query || '').toLowerCase();
    return Object.values(VERITAS).filter(function(e) {
      return e.id.toLowerCase().indexOf(q) !== -1 ||
             e.name.toLowerCase().indexOf(q) !== -1 ||
             e.description.toLowerCase().indexOf(q) !== -1;
    });
  }

  function listByType(type) {
    return Object.values(VERITAS).filter(function(e) { return e.type === type; });
  }

  function allTypes() {
    var types = {};
    Object.values(VERITAS).forEach(function(e) { types[e.type] = (types[e.type] || 0) + 1; });
    return types;
  }

  // ═══════════════════════════════════════════════════════════════════════
  // SEED — All known sovereign identifiers from the organism
  // ═══════════════════════════════════════════════════════════════════════

  // ── ALPHAS (Sovereign Alpha Models) ──────────────────────────────────
  var ALPHAS = [
    ['SOVEREIGN::ALPHA::MERIDIAN', 'ALPHA', 'MERIDIAN', 'The sovereign organism itself'],
    ['SOVEREIGN::ALPHA::CORTEX', 'ALPHA', 'CORTEX', 'Central processing cortex'],
    ['SOVEREIGN::ALPHA::CHRYSALIS', 'ALPHA', 'CHRYSALIS', 'Transformation and metamorphosis engine'],
    ['SOVEREIGN::ALPHA::CHIMERIA', 'ALPHA', 'CHIMERIA', 'Multi-model AI routing and fusion'],
    ['SOVEREIGN::ALPHA::NEXUS', 'ALPHA', 'NEXUS', 'Connection and integration hub'],
    ['SOVEREIGN::ALPHA::SENTINEL', 'ALPHA', 'SENTINEL', 'Security and protection guardian'],
    ['SOVEREIGN::ALPHA::FLUX', 'ALPHA', 'FLUX', 'State flow and transition engine'],
    ['SOVEREIGN::ALPHA::NOVA', 'ALPHA', 'NOVA', 'Innovation and emergence engine'],
    ['SOVEREIGN::ALPHA::AURORA', 'ALPHA', 'AURORA', 'Scientific computation and analysis'],
    ['SOVEREIGN::ALPHA::TERMINAL', 'ALPHA', 'TERMINAL', 'Universal command interface']
  ];

  // ── ORGANS (SDK AIs — Endogenous) ────────────────────────────────────
  var ORGANS = [
    ['SOVEREIGN::ORGAN::VISIO', 'ORGAN', 'VISIO', 'Visual processing organ'],
    ['SOVEREIGN::ORGAN::LEXIS', 'ORGAN', 'LEXIS', 'Language processing organ'],
    ['SOVEREIGN::ORGAN::NUMERUS', 'ORGAN', 'NUMERUS', 'Numerical computation organ'],
    ['SOVEREIGN::ORGAN::SONUS', 'ORGAN', 'SONUS', 'Audio processing organ'],
    ['SOVEREIGN::ORGAN::CUSTOS', 'ORGAN', 'CUSTOS', 'Security sentinel organ'],
    ['SOVEREIGN::ORGAN::RETICULUM', 'ORGAN', 'RETICULUM', 'Network routing organ'],
    ['SOVEREIGN::ORGAN::SCHEDULA', 'ORGAN', 'SCHEDULA', 'Scheduling organ'],
    ['SOVEREIGN::ORGAN::FABRICATOR', 'ORGAN', 'FABRICATOR', 'Build generation organ'],
    ['SOVEREIGN::ORGAN::SENSUS', 'ORGAN', 'SENSUS', 'External sense organ (reaches EXOGENOUS AIs)'],
    ['SOVEREIGN::ORGAN::GRAPHUS', 'ORGAN', 'GRAPHUS', 'Graph computation organ'],
    ['SOVEREIGN::ORGAN::DOCUMENTUM', 'ORGAN', 'DOCUMENTUM', 'Document processing organ'],
    ['SOVEREIGN::ORGAN::NEGOTIUM', 'ORGAN', 'NEGOTIUM', 'Business logic organ'],
    ['SOVEREIGN::ORGAN::SPATIUM', 'ORGAN', 'SPATIUM', 'Spatial computation organ'],
    ['SOVEREIGN::ORGAN::TEMPORIS', 'ORGAN', 'TEMPORIS', 'Temporal processing organ'],
    ['SOVEREIGN::ORGAN::COMMUNICATOR', 'ORGAN', 'COMMUNICATOR', 'Inter-organ communication organ']
  ];

  // ── WORKERS (Symbiotic) ──────────────────────────────────────────────
  var WORKERS = [
    ['SOVEREIGN::WORKER::PROTOCOLLUM', 'WORKER', 'PROTOCOLLUM OPERANS', 'Protocol execution worker'],
    ['SOVEREIGN::WORKER::MEMORIA', 'WORKER', 'MEMORIA OPERANS', 'Memory Temple worker'],
    ['SOVEREIGN::WORKER::SECURITAS', 'WORKER', 'SECURITAS OPERANS', 'Security sentinel worker'],
    ['SOVEREIGN::WORKER::MATHEMATICUS', 'WORKER', 'MATHEMATICUS OPERANS', 'Mathematical computation worker'],
    ['SOVEREIGN::WORKER::COMMUNICATIO', 'WORKER', 'COMMUNICATIO OPERANS', 'Communication bridge worker'],
    ['SOVEREIGN::WORKER::EVOLUTIO', 'WORKER', 'EVOLUTIO OPERANS', 'Evolution and adaptation worker'],
    ['SOVEREIGN::WORKER::CARRIERA', 'WORKER', 'CARRIERA OPERANS', '100 career flow execution worker'],
    ['SOVEREIGN::WORKER::MERCATUS', 'WORKER', 'PROTOCOLLUM MERCATUS OPERANS', 'Enterprise protocol marketplace worker'],
    ['SOVEREIGN::WORKER::TAXONOMIA', 'WORKER', 'TAXONOMIA OPERANS', 'AI relationship taxonomy worker'],
    ['SOVEREIGN::WORKER::VERITAS', 'WORKER', 'VERITAS OPERANS', 'Preservation protocol database worker'],
    ['SOVEREIGN::WORKER::ENGINE', 'WORKER', 'ENGINE OPERANS', 'Core engine worker (40 AI families)']
  ];

  // ── LANGUAGES ────────────────────────────────────────────────────────
  var LANGS = [
    ['SOVEREIGN::LANG::CPL', 'LANGUAGE', 'Contract Procurement Language', 'Contracts, covenants, token agreements, sovereign binding instruments'],
    ['SOVEREIGN::LANG::COGPRO', 'LANGUAGE', 'Cognitive Processing Language', 'Organism thought expression, BRAIN-FLUX communication, CORTEX routing'],
    ['SOVEREIGN::LANG::SL', 'LANGUAGE', 'Sovereign Law Language', 'Doctrine, law attribution, governance, SL-N laws'],
    ['SOVEREIGN::LANG::MOTOKO', 'LANGUAGE', 'Motoko', 'ICP execution substrate, implementation layer']
  ];

  // ── TAXONOMY CATEGORIES ──────────────────────────────────────────────
  var CATEGORIES = [
    ['SOVEREIGN::TAXONOMY::ENDOGENOUS', 'TAXONOMY', 'Endogenous', 'Inside alphas, unconscious of containment — organs'],
    ['SOVEREIGN::TAXONOMY::SYMBIOTIC', 'TAXONOMY', 'Symbiotic', 'Attached to organism, aware of boundary — workers'],
    ['SOVEREIGN::TAXONOMY::EXOGENOUS', 'TAXONOMY', 'Exogenous', 'External AIs reached via SENSUS/ENTANGLA'],
    ['SOVEREIGN::TAXONOMY::GRAVITATIONAL', 'TAXONOMY', 'Gravitational', 'Observers orbiting, no direct coupling — fans']
  ];

  // ── PROTOCOLS ────────────────────────────────────────────────────────
  var PROTOCOLS = [
    ['SOVEREIGN::PROTOCOL::ANIMA-MICRO', 'PROTOCOL', 'ANIMA MICROSCOPICA', 'Mini brain (7.83Hz) + mini heart (φHz) spec — protocol, database, callable'],
    ['SOVEREIGN::PROTOCOL::THREE-HEARTS', 'PROTOCOL', 'Three Hearts Protocol', 'Triple heartbeat consensus mechanism'],
    ['SOVEREIGN::PROTOCOL::ICP-BFT', 'PROTOCOL', 'ICP-BFT', 'Internet Computer Byzantine Fault Tolerance'],
    ['SOVEREIGN::PROTOCOL::PRESERVATION', 'PROTOCOL', 'Preservation Protocol', 'SOVEREIGN:: identifier permanence system']
  ];

  // ── PRODUCTS ─────────────────────────────────────────────────────────
  var PRODUCTS = [
    ['SOVEREIGN::PRODUCT::COMMAND-ENTERPRISE', 'PRODUCT', 'COMMAND ENTERPRISE', 'Enterprise protocol orchestration product'],
    ['SOVEREIGN::PRODUCT::COMMAND-SHIELD', 'PRODUCT', 'COMMAND SHIELD', 'Enterprise security and protection product'],
    ['SOVEREIGN::PRODUCT::PROTOCOL-SDK', 'PRODUCT', 'PROTOCOL SDK', 'Developer SDK for protocol integration'],
    ['SOVEREIGN::TOKEN::TT-012', 'TOKEN', 'TT-012 SOVEREIGN', 'Self-governing tokens: merge, split, evolve, self-attest. CPL/COGPRO/SL/Motoko']
  ];

  // ── 181 SOVEREIGN HOUSES ──────────────────────────────────────────────
  var HOUSES = [
    ['SOVEREIGN::HOUSE::SOVEREIGN', 'HOUSE', 'House of Sovereign', 'The Substrate Itself — 4000+ Fibonacci sphere nodes, golden-weighted voting'],
    ['SOVEREIGN::HOUSE::CHRYSALIS', 'HOUSE', 'House of Chrysalis', 'Golden Mathematics Core — Binet, spiral, Zeckendorf, phyllotaxis'],
    ['SOVEREIGN::HOUSE::OBSERVER', 'HOUSE', 'House of Observer', 'Guardians — 5 dimensional sub-intelligences, Kuramoto coupling, E8/Leech'],
    ['SOVEREIGN::HOUSE::SCRIBE', 'HOUSE', 'House of Scribe', 'Document Organism — golden-weighted classification, research synthesis'],
    ['SOVEREIGN::HOUSE::ARCHITECT', 'HOUSE', 'House of Architect', 'Meta-Builder — phyllotaxis positioning, Fibonacci generation thresholds'],
    ['SOVEREIGN::HOUSE::NEXUS', 'HOUSE', 'House of Nexus', 'Substrate Walker — golden-decay authority, cross-substrate routing'],
    ['SOVEREIGN::HOUSE::TERMINAL', 'HOUSE', 'House of Terminal', 'Admin Command Interface — command routing, dashboard, audit trails'],
    ['SOVEREIGN::HOUSE::D0-SPECULATOR', 'HOUSE', 'House of D0', 'Foundational observation — φ⁰ = 1.0 weight first-plane perception'],
    ['SOVEREIGN::HOUSE::D1-VIGIL', 'HOUSE', 'House of D1', 'Temporal observation — φ¹ = 1.618 weight time-series monitoring'],
    ['SOVEREIGN::HOUSE::D2-CUSTOS', 'HOUSE', 'House of D2', 'Harmonic observation — φ² = 2.618 weight resonance detection'],
    ['SOVEREIGN::HOUSE::D3-EXPLORATOR', 'HOUSE', 'House of D3', 'Cross-dimensional — φ³ = 4.236 weight cross-dimensional correlation'],
    ['SOVEREIGN::HOUSE::D4-SENTINELLA', 'HOUSE', 'House of D4', 'Transcendent — φ⁴ = 6.854 weight ultimate watchguard'],
    ['SOVEREIGN::HOUSE::VIGIL', 'HOUSE', 'House of VIGIL', '24/7 continuous monitoring — EXCUBITOR, NUNTIUS, INSPECTOR, DETECTOR, RELATOR'],
    ['SOVEREIGN::HOUSE::SPECULATOR', 'HOUSE', 'House of SPECULATOR', 'Analytical observation — ANALYTICUS, SYNTHESISTA, COMPARATOR, PRAEDICTOR, IUDICATOR'],
    ['SOVEREIGN::HOUSE::SYNTHESISTA', 'HOUSE', 'House of Synthesista Patternorum', 'Cross-dimensional pattern recognition — φ-harmonic bands'],
    ['SOVEREIGN::HOUSE::THEORICUS', 'HOUSE', 'House of Theoricus Interdimensionalis', 'Interdimensional theory proving — Hypothesize→Validate→Test→Refine'],
    ['SOVEREIGN::HOUSE::BRAIN', 'HOUSE', 'House of Brain', 'Intelligence processing — 40 AI engines, φ-weighted recall, inference'],
    ['SOVEREIGN::HOUSE::PROTOCOL', 'HOUSE', 'House of Protocol', 'Protocol enforcement — 10 AI protocols, Kuramoto sync'],
    ['SOVEREIGN::HOUSE::SHIELD', 'HOUSE', 'House of Shield', 'Security — 5 defense layers, ZK proofs, E8/Leech encryption'],
    ['SOVEREIGN::HOUSE::PRODUCTION', 'HOUSE', 'House of Production', 'Output generation — 3D phyllotaxis rendering, 7-stage CI/CD'],
    ['SOVEREIGN::HOUSE::INFRASTRUCTURE', 'HOUSE', 'House of Infrastructure', 'Monitoring — ring-buffer metrics, Fibonacci auto-scaling'],
    ['SOVEREIGN::HOUSE::MARKET', 'HOUSE', 'House of Market', 'Economic — 8 SLAs, Fibonacci pricing, 40 calls, 3 surfaces'],
    ['SOVEREIGN::HOUSE::UNIVERSITY', 'HOUSE', 'House of University', 'Learning — 8 faculties, 40 courses, knowledge graph'],
    ['SOVEREIGN::HOUSE::CAREER', 'HOUSE', 'House of Career', 'Training — 20 skills, 8 tracks, φ-scored role matching'],
    ['SOVEREIGN::HOUSE::PHANTOM-BLOCKCHAIN', 'HOUSE', 'House of Phantom Blockchain', 'Invisible quantum-encrypted blockchain — φ-cascade hash, ZK proofs'],
    ['SOVEREIGN::HOUSE::GOLD', 'HOUSE', 'House of Gold (AU)', 'Immutable state canister — Z=79, never corrodes, φ⁶ orbital weight'],
    ['SOVEREIGN::HOUSE::SILVER', 'HOUSE', 'House of Silver (AG)', 'Fastest message passing — Z=47, best conductor canister'],
    ['SOVEREIGN::HOUSE::CRIMSON', 'HOUSE', 'House of Crimson (CR)', 'Living organism canister — 680nm wavelength, 5 φ-orbitals, self-replicating'],
    ['SOVEREIGN::HOUSE::NOVA-OS', 'HOUSE', 'House of NOVA-OS', 'Sovereign Desktop AGI OS — 5-layer kernel, 23 engine fleet, Fibonacci attestation'],
    ['SOVEREIGN::HOUSE::181-TOTAL', 'ARCHITECTURE', '181 Sovereign Houses', '27 tiers × 181 houses = complete sovereign civilization architecture']
  ];

  // ── ARCHITECTURES ────────────────────────────────────────────────────
  var ARCHITECTURES = [
    ['SOVEREIGN::ARCH::SCATTERED-SERVERS', 'ARCHITECTURE', 'Scattered Servers', '80 field+generator nodes across all substrates'],
    ['SOVEREIGN::ARCH::MEMORY-TEMPLE', 'ARCHITECTURE', 'Memory Temple', 'Phi-geometric memory storage with rings and beats'],
    ['SOVEREIGN::ARCH::CALL-MARKETPLACE', 'ARCHITECTURE', 'Call & Protocol Marketplace', '200+ callable fleet, 55 enterprise protocols']
  ];

  // ── MATH CONSTANTS ───────────────────────────────────────────────────
  var MATH = [
    ['SOVEREIGN::MATH::PHI', 'CONSTANT', 'φ (Phi)', 'Golden ratio 1.618033988749895'],
    ['SOVEREIGN::MATH::SCHUMANN', 'CONSTANT', 'Schumann Resonance', '7.83 Hz Earth-ionosphere cavity resonance'],
    ['SOVEREIGN::MATH::FIBONACCI', 'CONSTANT', 'Fibonacci Sequence', 'F(n) = F(n-1) + F(n-2), basis of golden spiral'],
    ['SOVEREIGN::MATH::E', 'CONSTANT', 'Euler Number', '2.718281828459045, natural exponential base'],
    ['SOVEREIGN::MATH::PI', 'CONSTANT', 'Pi', '3.141592653589793, circle ratio'],
    ['SOVEREIGN::MATH::PLANCK', 'CONSTANT', 'Planck Constant', '6.62607015e-34 J⋅s, quantum of action']
  ];

  // ── LICENSES ─────────────────────────────────────────────────────────
  var LICENSES = [
    ['SOVEREIGN::LICENSE::CPEL-1.0', 'LICENSE', 'CPEL-1.0', 'Community Protocol Enterprise License v1.0'],
    ['SOVEREIGN::LICENSE::SOVEREIGN', 'LICENSE', 'Sovereign License', 'Full sovereign deployment license']
  ];

  // Seed all entries
  var ALL_SEEDS = [].concat(ALPHAS, ORGANS, WORKERS, LANGS, CATEGORIES, PROTOCOLS, PRODUCTS, HOUSES, ARCHITECTURES, MATH, LICENSES);
  ALL_SEEDS.forEach(function(seed) {
    store(seed[0], seed[1], seed[2], seed[3]);
  });

  // ═══════════════════════════════════════════════════════════════════════
  // WORKER STATE
  // ═══════════════════════════════════════════════════════════════════════
  var state = {
    beat: 0,
    booted: Date.now(),
    totalEntries: Object.keys(VERITAS).length,
    totalSeeded: ALL_SEEDS.length,
    logEntries: VERITAS_LOG.length,
    types: allTypes()
  };

  // ═══════════════════════════════════════════════════════════════════════
  // HEARTBEAT — φ Hz continuous pulse
  // ═══════════════════════════════════════════════════════════════════════
  function heartbeat() {
    state.beat++;
    state.totalEntries = Object.keys(VERITAS).length;
    state.types = allTypes();

    self.postMessage({
      type: 'heartbeat',
      worker: 'veritas',
      beat: state.beat,
      entries: state.totalEntries,
      types: Object.keys(state.types).length,
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
      case 'store':
        var result = store(msg.id, msg.entryType || 'CUSTOM', msg.name, msg.description, msg.metadata);
        self.postMessage({ type: 'veritas-result', action: 'store', result: result });
        break;

      case 'lookup':
        var entry = lookup(msg.id);
        self.postMessage({
          type: 'veritas-result',
          action: 'lookup',
          found: !!entry,
          entry: entry
        });
        break;

      case 'search':
        var results = search(msg.query);
        self.postMessage({
          type: 'veritas-result',
          action: 'search',
          query: msg.query,
          count: results.length,
          results: results.slice(0, 50)
        });
        break;

      case 'list':
      case 'list-type':
        var typeFilter = msg.entryType || msg.filterType;
        var list = typeFilter ? listByType(typeFilter) : Object.values(VERITAS);
        self.postMessage({
          type: 'veritas-result',
          action: 'list',
          filterType: typeFilter || 'ALL',
          count: list.length,
          entries: list.slice(0, 100).map(function(e) { return { id: e.id, type: e.type, name: e.name }; })
        });
        break;

      case 'types':
        self.postMessage({
          type: 'veritas-result',
          action: 'types',
          types: allTypes()
        });
        break;

      case 'log':
        self.postMessage({
          type: 'veritas-result',
          action: 'log',
          total: VERITAS_LOG.length,
          recent: VERITAS_LOG.slice(-20)
        });
        break;

      case 'count':
        self.postMessage({
          type: 'veritas-result',
          action: 'count',
          total: Object.keys(VERITAS).length,
          types: allTypes()
        });
        break;

      case 'manifest':
        self.postMessage({
          type: 'veritas-result',
          action: 'manifest',
          manifest: {
            name: 'ROOT/VERITAS',
            purpose: 'Immutable sovereign identifier preservation database',
            format: 'SOVEREIGN::<DOMAIN>::<NAME>',
            totalEntries: Object.keys(VERITAS).length,
            types: allTypes(),
            seeded: ALL_SEEDS.length,
            immutable: true,
            callable: true,
            domains: ['ALPHA', 'ORGAN', 'WORKER', 'LANG', 'TAXONOMY', 'PROTOCOL', 'PRODUCT', 'ARCH', 'MATH', 'LICENSE', 'NODE', 'FIELD', 'GENERATOR']
          }
        });
        break;

      case 'status':
        self.postMessage({
          type: 'veritas-result',
          action: 'status',
          state: state
        });
        break;

      default:
        self.postMessage({
          type: 'veritas-result',
          action: 'help',
          commands: [
            'store {id, entryType, name, description} — Store new SOVEREIGN:: entry (immutable)',
            'lookup {id} — Look up a SOVEREIGN:: identifier',
            'search {query} — Search entries by name/id/description',
            'list [filterType] — List all entries or filter by type',
            'types — List all entry types and counts',
            'log — View recent storage log',
            'count — Total entries and type breakdown',
            'manifest — Full ROOT/VERITAS manifest',
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
    worker: 'veritas',
    name: 'VERITAS OPERANS',
    latin: 'Veritas numquam perit.',
    entries: Object.keys(VERITAS).length,
    types: Object.keys(allTypes()).length,
    seeded: ALL_SEEDS.length
  });

  setInterval(heartbeat, HEARTBEAT_MS);
})();
