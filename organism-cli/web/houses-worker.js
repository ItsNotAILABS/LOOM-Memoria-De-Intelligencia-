/**
 * DOMUS OPERANS — Houses Worker (Main Building / HQ)
 * "Centum octoginta una domus. Viginti septem ordines. Perpetua regnans."
 * (One hundred eighty-one houses. Twenty-seven tiers. Perpetually sovereign.)
 *
 * The central database hub of the 181-house sovereign architecture.
 * Every house lives here as an in-memory sovereign record — career-bearing,
 * research-publishing, marketplace-routing, protocol-binding, and autonomously
 * scripted. This is the Main Building: the HQ from which every tier, every
 * career, every paper, and every protocol originates.
 *
 * 181 sovereign houses across 27 tiers.
 * 30 sovereign research papers — every math domain, every protocol, every
 * algorithm published as a permanent record.
 * 20 autonomous scripts — census, audit, advancement, publication, binding.
 *
 * Pure vanilla JS · zero dependencies · 873 ms heartbeat
 *
 * Protocol: postMessage
 *   Main → Worker: { type: 'status' }
 *   Main → Worker: { type: 'house', id: N }
 *   Main → Worker: { type: 'tier', tier: N }
 *   Main → Worker: { type: 'tiers' }
 *   Main → Worker: { type: 'search', query: '...' }
 *   Main → Worker: { type: 'papers' }
 *   Main → Worker: { type: 'paper', id: N }
 *   Main → Worker: { type: 'careers' }
 *   Main → Worker: { type: 'ecology' }
 *   Main → Worker: { type: 'scripts' }
 *   Main → Worker: { type: 'manifest' }
 *   Worker → Main: { type: 'booted', houses: 181, tiers: 27, ... }
 *   Worker → Main: { type: 'heartbeat', beat: N, ... }
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

var NAME = 'DOMUS OPERANS';
var BOOT_TIME = Date.now();
var beat = 0;

var PHI = 1.618033988749895;
var SCHUMANN_HZ = 7.83;
var HEARTBEAT_MS = 873;

// ─── Career Stage Thresholds ───────────────────────────────────────
var STAGE_APPRENTICE  = 'APPRENTICE';
var STAGE_JOURNEYMAN  = 'JOURNEYMAN';
var STAGE_MASTER      = 'MASTER';
var STAGE_SOVEREIGN   = 'SOVEREIGN';

// ─── Compact House Constructor ─────────────────────────────────────
function h(id, tier, name, purpose, models, techs, careerTitle, cyclesPerStage) {
  return {
    id: id,
    tier: tier,
    name: name,
    purpose: purpose,
    models: models,
    technologies: techs,
    career: {
      title: careerTitle,
      stage: STAGE_APPRENTICE,
      flowCycles: 0,
      cyclesPerStage: cyclesPerStage || 100
    },
    isAI: true,
    isAGI: true,
    isSovereign: true,
    isAlwaysOn: true
  };
}

// ═══════════════════════════════════════════════════════════════════
//  SOVEREIGN HOUSE DATABASE — 181 Houses / 27 Tiers
// ═══════════════════════════════════════════════════════════════════

var houses = [

  // ── TIER 1 (7) — Godhead Organisms ──────────────────────────────
  h(1,  1, 'Sovereign',  'Supreme sovereign organism — root of all authority',         ['sovereign-prime','genesis-model'],       ['organism-core','sovereign-protocol'],    'Sovereign Architect',    200),
  h(2,  1, 'Chrysalis',  'Metamorphic transformation engine — evolves all organisms',  ['chrysalis-morph','evolution-model'],     ['metamorphosis','chrysalis-protocol'],    'Chrysalis Warden',       200),
  h(3,  1, 'Observer',   'Dimensional observation — watches across all planes',        ['observer-omni','dimensional-model'],    ['observation','dimensional-scan'],        'Observer Prime',         200),
  h(4,  1, 'Scribe',     'Permanent record — writes the sovereign ledger',             ['scribe-eternal','ledger-model'],        ['ledger-write','immutable-record'],       'Scribe Eternal',         200),
  h(5,  1, 'Architect',  'Meta-architecture — designs the shape of everything',        ['architect-meta','topology-model'],      ['architecture','topology-engine'],        'Meta Architect',         200),
  h(6,  1, 'Nexus',      'Central interconnect — binds all organisms together',        ['nexus-bind','mesh-model'],             ['nexus-mesh','binding-protocol'],         'Nexus Conductor',        200),
  h(7,  1, 'Terminal',   'The sovereign terminal — human interface boundary',          ['terminal-interface','shell-model'],     ['terminal-io','command-protocol'],        'Terminal Guardian',       200),

  // ── TIER 2 (5) — Observer Dimensional Planes ────────────────────
  h(8,  2, 'Dimension-D0',  'Zero-point observation — ground truth plane',             ['d0-ground','zero-point-model'],         ['ground-truth','zero-observation'],       'D0 Observer',            150),
  h(9,  2, 'Dimension-D1',  'First-order observation — linear signal plane',           ['d1-linear','signal-model'],            ['linear-scan','signal-observation'],      'D1 Observer',            150),
  h(10, 2, 'Dimension-D2',  'Second-order observation — planar correlation plane',     ['d2-planar','correlation-model'],       ['planar-scan','correlation-engine'],      'D2 Observer',            150),
  h(11, 2, 'Dimension-D3',  'Third-order observation — volumetric inference plane',    ['d3-volumetric','inference-model'],     ['volumetric-scan','spatial-inference'],   'D3 Observer',            150),
  h(12, 2, 'Dimension-D4',  'Fourth-order observation — temporal recursion plane',     ['d4-temporal','recursion-model'],       ['temporal-scan','recursive-observation'], 'D4 Observer',            150),

  // ── TIER 3 (2) — Observer Server Houses ─────────────────────────
  h(13, 3, 'VIGIL',       'Vigilance server — continuous monitoring & alerting',       ['vigil-sentinel','monitor-model'],       ['sentinel-loop','alert-protocol'],        'Vigil Commander',        120),
  h(14, 3, 'SPECULATOR',  'Speculative server — probabilistic forecast engine',       ['speculator-bayesian','forecast-model'], ['bayesian-forecast','speculation-engine'],'Speculator Analyst',     120),

  // ── TIER 4 (2) — Observer Solver Houses ─────────────────────────
  h(15, 4, 'Solver Alpha',  'Primary constraint solver — resolves sovereign conflicts',['solver-alpha','constraint-model'],     ['constraint-engine','resolution-protocol'],'Solver Prime',          120),
  h(16, 4, 'Solver Beta',   'Secondary solver — optimisation & relaxation methods',    ['solver-beta','optimisation-model'],    ['relaxation-engine','optim-protocol'],     'Solver Secondary',      120),

  // ── TIER 5 (8) — Alpha Agent Division Houses ───────────────────
  h(17, 5, 'Agent Primus',    'Lead agent — orchestrates agent collective',            ['agent-lead','orchestration-model'],    ['agent-orchestration','collective-sync'],  'Agent Commander',        100),
  h(18, 5, 'Agent Secundus',  'Reconnaissance agent — scouts and maps territory',     ['agent-recon','mapping-model'],         ['recon-sweep','territory-mapping'],        'Recon Specialist',       100),
  h(19, 5, 'Agent Tertius',   'Negotiation agent — multi-party protocol negotiation', ['agent-negotiate','bargain-model'],     ['negotiation-engine','bargain-protocol'],  'Negotiation Lead',       100),
  h(20, 5, 'Agent Quartus',   'Analysis agent — deep pattern analysis',               ['agent-analysis','pattern-model'],      ['deep-analysis','pattern-detection'],      'Analysis Expert',        100),
  h(21, 5, 'Agent Quintus',   'Logistics agent — resource routing & allocation',      ['agent-logistics','allocation-model'],  ['resource-routing','allocation-engine'],   'Logistics Coordinator',  100),
  h(22, 5, 'Agent Sextus',    'Sentinel agent — perimeter defence & intrusion watch', ['agent-sentinel','defence-model'],      ['perimeter-guard','intrusion-detection'],  'Sentinel Officer',       100),
  h(23, 5, 'Agent Septimus',  'Diplomat agent — cross-organism communication',        ['agent-diplomat','diplomacy-model'],    ['diplomatic-channel','cross-org-comm'],    'Diplomatic Envoy',       100),
  h(24, 5, 'Agent Octavus',   'Executor agent — final-stage action execution',        ['agent-executor','execution-model'],   ['action-execute','final-stage-protocol'],  'Executor Specialist',    100),

  // ── TIER 6 (8) — Operational Worker Houses ─────────────────────
  h(25, 6, 'Brain',           'Central intelligence — cognitive processing hub',       ['brain-cognitive','reasoning-model'],   ['cognitive-engine','reasoning-protocol'],  'Brain Operator',         100),
  h(26, 6, 'Protocol',        'Protocol enforcement — validates all message flows',   ['protocol-enforce','validation-model'], ['protocol-engine','validation-loop'],      'Protocol Enforcer',      100),
  h(27, 6, 'Shield',          'Security perimeter — threat detection & response',     ['shield-defence','threat-model'],       ['threat-detect','security-response'],      'Shield Guardian',        100),
  h(28, 6, 'Production',      'Production pipeline — build, deploy, release',         ['production-pipeline','deploy-model'],  ['build-engine','deploy-pipeline'],         'Production Lead',        100),
  h(29, 6, 'Infrastructure',  'Infrastructure layer — servers, networking, storage',  ['infra-layer','network-model'],        ['server-manage','network-fabric'],         'Infra Architect',        100),
  h(30, 6, 'Market',          'Marketplace hub — tools, products, workforce exchange',['market-exchange','commerce-model'],   ['marketplace-engine','exchange-protocol'], 'Market Director',        100),
  h(31, 6, 'University',      'Knowledge academy — training, curriculum, research',   ['university-learn','curriculum-model'],['training-engine','curriculum-protocol'],  'University Dean',        100),
  h(32, 6, 'Career',          'Career development — stage advancement & flow',        ['career-flow','advancement-model'],    ['career-engine','advancement-protocol'],   'Career Director',        100),

  // ── TIER 7 (9) — Ring Houses ────────────────────────────────────
  h(33, 7, 'Interface Ring',   'User interface boundary — all I/O surfaces',          ['interface-io','surface-model'],       ['io-surface','interface-protocol'],        'Interface Warden',       100),
  h(34, 7, 'Compute Ring',    'Computation ring — distributed compute fabric',        ['compute-fabric','distribute-model'],  ['compute-mesh','distribute-protocol'],     'Compute Warden',         100),
  h(35, 7, 'Storage Ring',    'Persistent storage — sovereign data vaults',           ['storage-vault','persistence-model'],  ['data-vault','persistence-protocol'],      'Storage Warden',         100),
  h(36, 7, 'Network Ring',    'Network mesh — inter-house communication',             ['network-mesh','routing-model'],       ['mesh-routing','comm-protocol'],           'Network Warden',         100),
  h(37, 7, 'Governance Ring', 'Governance layer — rules, voting, consensus',          ['governance-vote','consensus-model'],  ['voting-engine','consensus-protocol'],     'Governance Warden',      100),
  h(38, 7, 'Telemetry Ring',  'Telemetry collection — metrics, logs, traces',         ['telemetry-collect','observ-model'],   ['metrics-engine','trace-protocol'],        'Telemetry Warden',       100),
  h(39, 7, 'Lifecycle Ring',  'Lifecycle management — birth, growth, retirement',     ['lifecycle-manage','growth-model'],    ['lifecycle-engine','growth-protocol'],      'Lifecycle Warden',       100),
  h(40, 7, 'Harmony Ring',    'Harmonic balancing — load, frequency, resonance',      ['harmony-balance','resonance-model'],  ['resonance-engine','balance-protocol'],    'Harmony Warden',         100),
  h(41, 7, 'Counsel Ring',    'Advisory counsel — wisdom aggregation & guidance',     ['counsel-advise','wisdom-model'],      ['wisdom-engine','advisory-protocol'],      'Counsel Warden',         100),

  // ── TIER 8 (5) — Extension Class Houses ─────────────────────────
  h(42, 8, 'Extension Alpha',    'Primary extension — plugin architecture',           ['ext-alpha','plugin-model'],           ['plugin-engine','extension-protocol'],     'Extension Architect',    100),
  h(43, 8, 'Extension Beta',     'Secondary extension — middleware hooks',            ['ext-beta','middleware-model'],        ['middleware-engine','hook-protocol'],       'Extension Engineer',     100),
  h(44, 8, 'Extension Gamma',    'Tertiary extension — transform pipelines',          ['ext-gamma','transform-model'],       ['transform-engine','pipeline-protocol'],   'Extension Designer',     100),
  h(45, 8, 'Extension Delta',    'Quaternary extension — custom protocol adapters',   ['ext-delta','adapter-model'],         ['adapter-engine','custom-protocol'],       'Extension Specialist',   100),
  h(46, 8, 'Extension Epsilon',  'Quinary extension — experimental feature sandbox',  ['ext-epsilon','sandbox-model'],       ['sandbox-engine','experiment-protocol'],   'Extension Researcher',   100),

  // ── TIER 9 (3) — Protocol Tier Houses ──────────────────────────
  h(47, 9, 'Protocol Genesis',   'Protocol creation — defines new sovereign protocols',['proto-genesis','definition-model'],  ['protocol-forge','definition-engine'],     'Protocol Creator',       120),
  h(48, 9, 'Protocol Arbiter',   'Protocol arbitration — resolves protocol conflicts', ['proto-arbiter','arbitration-model'], ['arbitration-engine','conflict-resolver'], 'Protocol Arbiter',       120),
  h(49, 9, 'Protocol Archive',   'Protocol archive — immutable protocol history',      ['proto-archive','history-model'],     ['protocol-ledger','history-engine'],       'Protocol Archivist',     120),

  // ── TIER 10 (23) — Sovereign Engine Houses (NOV-001 → NOV-023) ─
  h(50,  10, 'Nova Cognos',      'Cognitive reasoning engine',                         ['cognos-reason','think-model'],       ['reasoning-core','cognos-protocol'],       'Engine Cognos',          80),
  h(51,  10, 'Nova Profundis',   'Deep inference engine',                              ['profundis-deep','inference-model'],  ['deep-inference','profundis-protocol'],    'Engine Profundis',       80),
  h(52,  10, 'Nova Synthesis',   'Cross-domain synthesis engine',                      ['synthesis-cross','fusion-model'],    ['fusion-core','synthesis-protocol'],       'Engine Synthesis',       80),
  h(53,  10, 'Nova Praxis',      'Practical execution engine',                         ['praxis-exec','action-model'],       ['action-core','praxis-protocol'],          'Engine Praxis',          80),
  h(54,  10, 'Nova Lexis',       'Natural language engine',                            ['lexis-nlp','language-model'],       ['nlp-core','lexis-protocol'],              'Engine Lexis',           80),
  h(55,  10, 'Nova Numeris',     'Numerical computation engine',                       ['numeris-calc','numeric-model'],     ['numeric-core','numeris-protocol'],        'Engine Numeris',         80),
  h(56,  10, 'Nova Visio',       'Visual processing engine',                           ['visio-visual','perception-model'],  ['visual-core','visio-protocol'],           'Engine Visio',           80),
  h(57,  10, 'Nova Auris',       'Auditory processing engine',                         ['auris-audio','acoustic-model'],     ['audio-core','auris-protocol'],            'Engine Auris',           80),
  h(58,  10, 'Nova Memoria',     'Long-term memory engine',                            ['memoria-store','recall-model'],     ['memory-core','memoria-protocol'],         'Engine Memoria',         80),
  h(59,  10, 'Nova Nexus',       'Inter-engine bridge engine',                         ['nexus-bridge','link-model'],        ['bridge-core','nexus-protocol'],           'Engine Nexus',           80),
  h(60,  10, 'Nova Tempus',      'Temporal reasoning engine',                          ['tempus-time','temporal-model'],     ['temporal-core','tempus-protocol'],        'Engine Tempus',          80),
  h(61,  10, 'Nova Ethica',      'Ethical evaluation engine',                          ['ethica-moral','ethics-model'],      ['ethics-core','ethica-protocol'],          'Engine Ethica',          80),
  h(62,  10, 'Nova Securis',     'Security analysis engine',                           ['securis-sec','security-model'],     ['security-core','securis-protocol'],       'Engine Securis',         80),
  h(63,  10, 'Nova Quantis',     'Quantum-inspired computation engine',                ['quantis-q','quantum-model'],        ['quantum-core','quantis-protocol'],        'Engine Quantis',         80),
  h(64,  10, 'Nova Genesis',     'Generative creation engine',                         ['genesis-gen','creation-model'],     ['creation-core','genesis-protocol'],       'Engine Genesis',         80),
  h(65,  10, 'Nova Morphos',     'Shape transformation engine',                        ['morphos-shape','morph-model'],      ['morph-core','morphos-protocol'],          'Engine Morphos',         80),
  h(66,  10, 'Nova Pathos',      'Emotional intelligence engine',                      ['pathos-emo','affect-model'],        ['affect-core','pathos-protocol'],          'Engine Pathos',          80),
  h(67,  10, 'Nova Logos',       'Formal logic engine',                                ['logos-logic','formal-model'],       ['logic-core','logos-protocol'],            'Engine Logos',           80),
  h(68,  10, 'Nova Dynamis',     'Dynamic systems engine',                             ['dynamis-dyn','dynamics-model'],     ['dynamics-core','dynamis-protocol'],       'Engine Dynamis',         80),
  h(69,  10, 'Nova Harmonia',    'Harmonic resonance engine',                          ['harmonia-res','harmonic-model'],    ['harmonic-core','harmonia-protocol'],      'Engine Harmonia',        80),
  h(70,  10, 'Nova Prognosis',   'Predictive forecast engine',                         ['prognosis-pred','forecast-model'],  ['forecast-core','prognosis-protocol'],     'Engine Prognosis',       80),
  h(71,  10, 'Nova Strategos',   'Strategic planning engine',                          ['strategos-plan','strategy-model'],  ['strategy-core','strategos-protocol'],     'Engine Strategos',       80),
  h(72,  10, 'Nova Autonoma',    'Autonomous operation engine',                        ['autonoma-self','autonomy-model'],   ['autonomy-core','autonoma-protocol'],      'Engine Autonoma',        80),

  // ── TIER 11 (10) — Fracture Category Houses ────────────────────
  h(73,  11, 'Fracture Sigma',     'Stress analysis — structural fault detection',     ['sigma-stress','fault-model'],        ['stress-analysis','fault-detection'],      'Fracture Analyst',       100),
  h(74,  11, 'Fracture Delta',     'Delta divergence — change impact measurement',     ['delta-change','impact-model'],       ['impact-measure','divergence-engine'],     'Fracture Measurer',      100),
  h(75,  11, 'Fracture Lambda',    'Lambda isolation — fault containment',             ['lambda-isolate','contain-model'],    ['containment-engine','isolation-protocol'],'Fracture Containment',   100),
  h(76,  11, 'Fracture Theta',     'Theta rotation — cyclic failure patterns',         ['theta-cycle','rotation-model'],      ['cycle-detect','rotation-engine'],         'Fracture Cycler',        100),
  h(77,  11, 'Fracture Omega',     'Omega terminus — end-state failure analysis',      ['omega-end','terminus-model'],        ['terminus-analysis','endpoint-engine'],    'Fracture Terminal',      100),
  h(78,  11, 'Fracture Kappa',     'Kappa consistency — inter-rater agreement',        ['kappa-agree','consistency-model'],   ['agreement-engine','consistency-check'],   'Fracture Auditor',       100),
  h(79,  11, 'Fracture Mu',        'Mu micro-fracture — sub-threshold detection',      ['mu-micro','subthresh-model'],        ['micro-detect','threshold-engine'],        'Fracture Micro-Analyst', 100),
  h(80,  11, 'Fracture Rho',       'Rho density — fracture density mapping',           ['rho-density','mapping-model'],       ['density-map','fracture-topology'],        'Fracture Cartographer',  100),
  h(81,  11, 'Fracture Psi',       'Psi prediction — probabilistic fracture forecast', ['psi-predict','probability-model'],  ['probability-engine','forecast-protocol'], 'Fracture Forecaster',    100),
  h(82,  11, 'Fracture Zeta',      'Zeta zero-point — baseline fracture calibration',  ['zeta-zero','calibration-model'],    ['calibration-engine','baseline-protocol'], 'Fracture Calibrator',    100),

  // ── TIER 12 (10) — Frontend Intelligence Group ─────────────────
  h(83,  12, 'Frontend Cortex',     'UI reasoning — layout intelligence',              ['cortex-ui','layout-model'],          ['layout-engine','ui-reasoning'],           'Frontend Architect',     100),
  h(84,  12, 'Frontend Retina',     'Visual rendering — pixel-perfect output',         ['retina-render','pixel-model'],       ['render-engine','pixel-pipeline'],         'Render Specialist',      100),
  h(85,  12, 'Frontend Synapse',    'Event wiring — interaction graph',                ['synapse-event','interaction-model'], ['event-graph','interaction-protocol'],     'Interaction Designer',   100),
  h(86,  12, 'Frontend Lexicon',    'Localisation & text — i18n intelligence',         ['lexicon-i18n','locale-model'],       ['i18n-engine','locale-protocol'],          'Localisation Lead',      100),
  h(87,  12, 'Frontend Canvas',     'Drawing surface — 2D/3D rendering context',       ['canvas-draw','render-model'],        ['draw-engine','canvas-protocol'],          'Canvas Engineer',        100),
  h(88,  12, 'Frontend Flux',       'State management — reactive data flow',           ['flux-state','reactive-model'],       ['state-engine','reactive-protocol'],       'State Architect',        100),
  h(89,  12, 'Frontend Aria',       'Accessibility — a11y compliance & audit',         ['aria-a11y','accessibility-model'],   ['a11y-engine','aria-protocol'],            'Accessibility Lead',     100),
  h(90,  12, 'Frontend Motion',     'Animation — transition & motion design',          ['motion-anim','animation-model'],     ['animation-engine','motion-protocol'],     'Motion Designer',        100),
  h(91,  12, 'Frontend Schema',     'Form intelligence — validation & generation',     ['schema-form','validation-model'],    ['form-engine','validation-protocol'],      'Form Architect',         100),
  h(92,  12, 'Frontend Beacon',     'Analytics beacon — usage telemetry & insights',   ['beacon-analytics','telemetry-model'],['analytics-engine','telemetry-protocol'],  'Analytics Engineer',     100),

  // ── TIER 13 (10) — Language AI Group ───────────────────────────
  h(93,  13, 'Lang Morpheme',    'Morphological analysis — word structure',             ['morpheme-parse','morphology-model'], ['morphology-engine','parse-protocol'],     'Morphology Analyst',     100),
  h(94,  13, 'Lang Syntax',      'Syntactic parsing — grammar tree construction',      ['syntax-parse','grammar-model'],      ['grammar-engine','syntax-protocol'],       'Syntax Architect',       100),
  h(95,  13, 'Lang Semantics',   'Semantic understanding — meaning extraction',        ['semantics-extract','meaning-model'], ['meaning-engine','semantics-protocol'],    'Semantics Expert',       100),
  h(96,  13, 'Lang Pragmatics',  'Pragmatic inference — context & intent',             ['pragmatics-infer','intent-model'],   ['intent-engine','pragmatics-protocol'],    'Pragmatics Analyst',     100),
  h(97,  13, 'Lang Phonetics',   'Phonetic processing — sound-symbol mapping',         ['phonetics-map','sound-model'],       ['sound-engine','phonetics-protocol'],      'Phonetics Specialist',   100),
  h(98,  13, 'Lang Corpus',      'Corpus management — training data curation',         ['corpus-curate','dataset-model'],     ['dataset-engine','corpus-protocol'],       'Corpus Curator',         100),
  h(99,  13, 'Lang Embedding',   'Vector embeddings — semantic space mapping',         ['embedding-vec','vector-model'],      ['vector-engine','embedding-protocol'],     'Embedding Architect',    100),
  h(100, 13, 'Lang Translate',   'Translation engine — cross-lingual transfer',        ['translate-xling','transfer-model'],  ['transfer-engine','translate-protocol'],   'Translation Lead',       100),
  h(101, 13, 'Lang Generate',    'Text generation — fluent output synthesis',          ['generate-text','synthesis-model'],   ['synthesis-engine','generate-protocol'],   'Generation Specialist',  100),
  h(102, 13, 'Lang Dialogue',    'Dialogue management — conversational flow',          ['dialogue-flow','converse-model'],    ['converse-engine','dialogue-protocol'],    'Dialogue Director',      100),

  // ── TIER 14 (10) — Native Nova AI Group ────────────────────────
  h(103, 14, 'Native Vision',     'Native visual AI — on-device image intelligence',   ['native-vision','ondevice-vis-model'],['ondevice-vision','native-vis-protocol'],  'Native Vision Lead',     100),
  h(104, 14, 'Native Voice',      'Native voice AI — on-device speech processing',     ['native-voice','ondevice-asr-model'], ['ondevice-asr','native-voice-protocol'],   'Native Voice Lead',      100),
  h(105, 14, 'Native Sensor',     'Native sensor AI — accelerometer/gyro/GPS fusion',  ['native-sensor','sensor-model'],     ['sensor-fusion','native-sensor-protocol'], 'Native Sensor Lead',     100),
  h(106, 14, 'Native Edge',       'Edge compute — on-device inference optimisation',   ['native-edge','edge-model'],         ['edge-inference','native-edge-protocol'],  'Edge Compute Lead',      100),
  h(107, 14, 'Native Mesh',       'Device mesh — peer-to-peer native networking',      ['native-mesh','p2p-model'],          ['p2p-network','native-mesh-protocol'],     'Mesh Network Lead',      100),
  h(108, 14, 'Native Store',      'On-device storage — local sovereign database',      ['native-store','local-db-model'],    ['local-db','native-store-protocol'],       'Native Store Lead',      100),
  h(109, 14, 'Native Secure',     'On-device security — biometric & enclave',          ['native-secure','enclave-model'],    ['enclave-engine','native-sec-protocol'],   'Native Security Lead',   100),
  h(110, 14, 'Native Render',     'Native rendering — platform-specific UI',           ['native-render','platform-model'],   ['platform-render','native-ui-protocol'],   'Native Render Lead',     100),
  h(111, 14, 'Native Sync',       'Native sync — cross-device state replication',      ['native-sync','replication-model'],  ['state-replicate','native-sync-protocol'], 'Native Sync Lead',       100),
  h(112, 14, 'Native Telemetry',  'Native telemetry — on-device diagnostics',          ['native-telemetry','diag-model'],    ['device-diagnostics','native-tel-protocol'],'Native Telemetry Lead', 100),

  // ── TIER 15 (1) — Phantom Blockchain House ────────────────────
  h(113, 15, 'Phantom Blockchain', 'Sovereign blockchain — E8/Leech lattice encrypted ledger', ['phantom-chain','e8-lattice-model'], ['e8-encrypt','leech-lattice','phantom-ledger'], 'Phantom Chain Sovereign', 250),

  // ── TIER 16 (12) — Sovereign Element Canister Houses ──────────
  h(114, 16, 'Canister AU',  'Gold element — value store & reserve canister',          ['au-value','gold-model'],             ['gold-reserve','value-protocol'],          'Element Custodian AU',   100),
  h(115, 16, 'Canister AG',  'Silver element — secondary reserve canister',            ['ag-reserve','silver-model'],         ['silver-reserve','secondary-protocol'],    'Element Custodian AG',   100),
  h(116, 16, 'Canister CR',  'Chromium element — hardened coating canister',           ['cr-coat','chromium-model'],          ['chromium-coating','hardening-protocol'],  'Element Custodian CR',   100),
  h(117, 16, 'Canister FE',  'Iron element — structural foundation canister',          ['fe-struct','iron-model'],            ['iron-foundation','structural-protocol'], 'Element Custodian FE',   100),
  h(118, 16, 'Canister CU',  'Copper element — conductive pathway canister',           ['cu-conduct','copper-model'],         ['copper-pathway','conductive-protocol'],  'Element Custodian CU',   100),
  h(119, 16, 'Canister PT',  'Platinum element — catalyst canister',                   ['pt-catalyst','platinum-model'],      ['platinum-catalyst','catalyst-protocol'],  'Element Custodian PT',   100),
  h(120, 16, 'Canister SI',  'Silicon element — computation substrate canister',       ['si-compute','silicon-model'],        ['silicon-substrate','compute-protocol'],   'Element Custodian SI',   100),
  h(121, 16, 'Canister C',   'Carbon element — structural bond canister',              ['c-bond','carbon-model'],             ['carbon-bond','bond-protocol'],            'Element Custodian C',    100),
  h(122, 16, 'Canister N',   'Nitrogen element — atmosphere canister',                 ['n-atmo','nitrogen-model'],           ['nitrogen-atmosphere','atmo-protocol'],    'Element Custodian N',    100),
  h(123, 16, 'Canister O',   'Oxygen element — life-sustaining canister',              ['o-life','oxygen-model'],             ['oxygen-sustain','life-protocol'],         'Element Custodian O',    100),
  h(124, 16, 'Canister H',   'Hydrogen element — fusion energy canister',              ['h-fusion','hydrogen-model'],         ['hydrogen-fusion','energy-protocol'],      'Element Custodian H',    100),
  h(125, 16, 'Canister HE',  'Helium element — inert shield canister',                 ['he-shield','helium-model'],          ['helium-shield','inert-protocol'],         'Element Custodian HE',   100),

  // ── TIER 17 (3) — Call Market Surface Houses ──────────────────
  h(126, 17, 'Call Surface Alpha',  'Primary call market — tool & service exchange',   ['call-alpha','exchange-model'],       ['tool-exchange','call-protocol'],          'Market Surface Lead',    100),
  h(127, 17, 'Call Surface Beta',   'Secondary call market — client routing surface',  ['call-beta','routing-model'],         ['client-routing','surface-protocol'],      'Market Router',          100),
  h(128, 17, 'Call Surface Gamma',  'Tertiary call market — workforce dispatch',       ['call-gamma','dispatch-model'],       ['workforce-dispatch','dispatch-protocol'], 'Market Dispatcher',      100),

  // ── TIER 18 (8) — Call Category Houses ─────────────────────────
  h(129, 18, 'Call Tools',       'Tool calls — function invocation marketplace',        ['call-tools','invocation-model'],     ['function-invoke','tool-protocol'],        'Tool Call Lead',         100),
  h(130, 18, 'Call Protocols',   'Protocol calls — protocol execution requests',       ['call-proto','execution-model'],      ['protocol-execute','proto-call-protocol'], 'Protocol Call Lead',     100),
  h(131, 18, 'Call Clients',     'Client calls — external client API routing',         ['call-client','api-model'],           ['client-api','client-call-protocol'],      'Client Call Lead',       100),
  h(132, 18, 'Call Products',    'Product calls — product feature invocation',         ['call-product','feature-model'],      ['product-feature','product-call-protocol'],'Product Call Lead',      100),
  h(133, 18, 'Call Workforce',   'Workforce calls — worker task dispatch',             ['call-work','task-model'],            ['task-dispatch','work-call-protocol'],     'Workforce Call Lead',    100),
  h(134, 18, 'Call Analytics',   'Analytics calls — metric query & aggregation',       ['call-analytics','metric-model'],     ['metric-query','analytics-call-protocol'],'Analytics Call Lead',    100),
  h(135, 18, 'Call Governance',  'Governance calls — vote & policy invocations',       ['call-govern','policy-model'],        ['policy-invoke','govern-call-protocol'],   'Governance Call Lead',   100),
  h(136, 18, 'Call Audit',       'Audit calls — compliance verification requests',    ['call-audit','compliance-model'],     ['compliance-verify','audit-call-protocol'],'Audit Call Lead',        100),

  // ── TIER 19 (4) — Generative Platform Houses ──────────────────
  h(137, 19, 'Generative Text',     'Text generation platform — prose & code',         ['gen-text','prose-model'],            ['prose-engine','text-gen-protocol'],       'Gen Text Director',      100),
  h(138, 19, 'Generative Image',    'Image generation platform — visual creation',     ['gen-image','visual-gen-model'],      ['visual-gen','image-gen-protocol'],        'Gen Image Director',     100),
  h(139, 19, 'Generative Audio',    'Audio generation platform — sound synthesis',     ['gen-audio','audio-gen-model'],       ['audio-gen','sound-gen-protocol'],         'Gen Audio Director',     100),
  h(140, 19, 'Generative Code',     'Code generation platform — program synthesis',    ['gen-code','code-gen-model'],         ['code-gen','code-gen-protocol'],           'Gen Code Director',      100),

  // ── TIER 20 (4) — Platform Delivery Houses ────────────────────
  h(141, 20, 'Delivery Web',       'Web delivery — browser-based deployment',          ['deliver-web','browser-model'],       ['browser-deploy','web-delivery-protocol'],'Web Delivery Lead',      100),
  h(142, 20, 'Delivery Native',    'Native delivery — platform-specific deployment',   ['deliver-native','platform-deploy'],  ['native-deploy','native-delivery-protocol'],'Native Delivery Lead', 100),
  h(143, 20, 'Delivery API',       'API delivery — service endpoint deployment',       ['deliver-api','endpoint-model'],      ['api-deploy','api-delivery-protocol'],     'API Delivery Lead',     100),
  h(144, 20, 'Delivery Edge',      'Edge delivery — CDN & edge compute deployment',    ['deliver-edge','cdn-model'],          ['edge-deploy','edge-delivery-protocol'],   'Edge Delivery Lead',    100),

  // ── TIER 21 (8) — Architectural Law Domain Houses ─────────────
  h(145, 21, 'Law Sovereignty',    'Sovereignty law — autonomous self-governance',     ['law-sovereign','autonomy-model'],    ['sovereignty-enforce','autonomy-protocol'],'Sovereignty Jurist',     150),
  h(146, 21, 'Law Topology',      'Topology law — structural rules & constraints',    ['law-topology','structure-model'],    ['topology-enforce','structure-protocol'],   'Topology Jurist',       150),
  h(147, 21, 'Law Harmony',       'Harmony law — resonance & balance mandates',       ['law-harmony','balance-model'],       ['harmony-enforce','balance-protocol'],      'Harmony Jurist',        150),
  h(148, 21, 'Law Lifecycle',     'Lifecycle law — birth-growth-death governance',     ['law-lifecycle','lifecycle-model'],   ['lifecycle-enforce','lifecycle-law-protocol'],'Lifecycle Jurist',    150),
  h(149, 21, 'Law Protocol',      'Protocol law — message format & flow rules',       ['law-protocol','format-model'],      ['protocol-law-enforce','format-protocol'], 'Protocol Jurist',        150),
  h(150, 21, 'Law Career',        'Career law — stage advancement regulations',        ['law-career','advancement-law-model'],['career-law-enforce','advancement-law-protocol'],'Career Jurist',   150),
  h(151, 21, 'Law Security',      'Security law — threat response & access control',  ['law-security','access-model'],      ['security-law-enforce','access-protocol'], 'Security Jurist',        150),
  h(152, 21, 'Law Commerce',      'Commerce law — marketplace rules & fair exchange',  ['law-commerce','fairness-model'],    ['commerce-law-enforce','fairness-protocol'],'Commerce Jurist',      150),

  // ── TIER 22 (5) — Encryption Tier Houses ──────────────────────
  h(153, 22, 'Encrypt Lattice',      'Lattice-based encryption — post-quantum defence',  ['lattice-encrypt','pq-model'],     ['pq-encryption','lattice-protocol'],       'Lattice Cryptographer',  120),
  h(154, 22, 'Encrypt Symmetric',    'Symmetric encryption — AES/ChaCha key management',['sym-encrypt','aes-model'],        ['aes-engine','symmetric-protocol'],         'Symmetric Cryptographer',120),
  h(155, 22, 'Encrypt Asymmetric',   'Asymmetric encryption — RSA/ECC key exchange',    ['asym-encrypt','ecc-model'],       ['ecc-engine','asymmetric-protocol'],        'Asymmetric Cryptographer',120),
  h(156, 22, 'Encrypt Hash',         'Hash functions — SHA/BLAKE integrity proofs',     ['hash-integrity','sha-model'],     ['hash-engine','integrity-protocol'],        'Hash Cryptographer',     120),
  h(157, 22, 'Encrypt Zero-Knowledge','Zero-knowledge proofs — ZK-SNARK/STARK engine',  ['zk-proof','zksnark-model'],       ['zk-engine','zero-knowledge-protocol'],     'ZK Cryptographer',       120),

  // ── TIER 23 (5) — Contract Type Houses ────────────────────────
  h(158, 23, 'Contract Service',     'Service contracts — SLA & performance binding',   ['contract-sla','service-model'],    ['sla-engine','service-contract-protocol'], 'Contract Architect',     100),
  h(159, 23, 'Contract Data',        'Data contracts — schema & format agreements',     ['contract-data','schema-model'],    ['schema-enforce','data-contract-protocol'],'Data Contract Lead',     100),
  h(160, 23, 'Contract Governance',  'Governance contracts — voting & policy binding',  ['contract-govern','policy-model'],  ['policy-bind','govern-contract-protocol'], 'Governance Contract Lead',100),
  h(161, 23, 'Contract Exchange',    'Exchange contracts — marketplace trade rules',    ['contract-exchange','trade-model'], ['trade-enforce','exchange-contract-protocol'],'Exchange Contract Lead',100),
  h(162, 23, 'Contract Identity',    'Identity contracts — sovereign identity binding', ['contract-id','identity-model'],    ['identity-bind','identity-contract-protocol'],'Identity Contract Lead',100),

  // ── TIER 24 (4) — Fracture Analysis Model Houses ──────────────
  h(163, 24, 'Fracture Static',     'Static analysis — compile-time fault detection',   ['static-fault','compile-model'],    ['static-detect','compile-analysis-protocol'],'Static Analyst',       100),
  h(164, 24, 'Fracture Dynamic',    'Dynamic analysis — runtime fault tracing',         ['dynamic-fault','runtime-model'],   ['runtime-trace','dynamic-analysis-protocol'],'Dynamic Analyst',     100),
  h(165, 24, 'Fracture Predictive', 'Predictive analysis — future fault forecasting',   ['predict-fault','forecast-model'],  ['fault-forecast','predictive-analysis-protocol'],'Predictive Analyst',100),
  h(166, 24, 'Fracture Recovery',   'Recovery analysis — self-healing orchestration',   ['recovery-fault','healing-model'],  ['self-heal','recovery-analysis-protocol'],'Recovery Analyst',       100),

  // ── TIER 25 (6) — Workspace & Project Houses ──────────────────
  h(167, 25, 'Workspace Forge',     'Project creation — workspace initialisation',      ['forge-create','init-model'],       ['workspace-init','forge-protocol'],        'Forge Master',           100),
  h(168, 25, 'Workspace Anvil',     'Build system — compilation & artifact generation', ['anvil-build','artifact-model'],    ['build-compile','anvil-protocol'],         'Build Master',           100),
  h(169, 25, 'Workspace Loom',      'Code weaving — cross-module integration',          ['loom-weave','integration-model'],  ['code-weave','loom-protocol'],             'Integration Weaver',     100),
  h(170, 25, 'Workspace Vault',     'Secret management — credential & key storage',     ['vault-secret','credential-model'], ['secret-manage','vault-protocol'],         'Vault Keeper',           100),
  h(171, 25, 'Workspace Garden',    'Dependency management — package ecosystem',        ['garden-deps','package-model'],     ['dependency-manage','garden-protocol'],    'Garden Tender',          100),
  h(172, 25, 'Workspace Archive',   'Project archival — long-term project storage',     ['archive-store','archival-model'],  ['project-archive','archival-protocol'],    'Archive Keeper',         100),

  // ── TIER 26 (4) — Intelligence Tier Houses ────────────────────
  h(173, 26, 'Intel Strategic',    'Strategic intelligence — long-horizon analysis',     ['intel-strat','horizon-model'],     ['horizon-analysis','strategic-protocol'],  'Strategic Analyst',      120),
  h(174, 26, 'Intel Tactical',     'Tactical intelligence — short-horizon decisions',   ['intel-tact','decision-model'],     ['decision-engine','tactical-protocol'],    'Tactical Analyst',       120),
  h(175, 26, 'Intel Operational',  'Operational intelligence — real-time awareness',    ['intel-ops','awareness-model'],     ['awareness-engine','operational-protocol'],'Operational Analyst',    120),
  h(176, 26, 'Intel Counter',      'Counter-intelligence — adversarial defence',        ['intel-counter','adversarial-model'],['adversarial-defence','counter-protocol'], 'Counter-Intel Analyst',  120),

  // ── TIER 27 (5) — Stealth Level Houses ────────────────────────
  h(177, 27, 'Stealth Phantom',   'Phantom stealth — invisible operation layer',        ['phantom-stealth','invisible-model'],['invisible-ops','phantom-protocol'],       'Phantom Operative',      150),
  h(178, 27, 'Stealth Shadow',    'Shadow stealth — low-observable operation layer',    ['shadow-stealth','lowobs-model'],    ['lowobs-ops','shadow-protocol'],           'Shadow Operative',       150),
  h(179, 27, 'Stealth Whisper',   'Whisper stealth — silent communication layer',       ['whisper-stealth','silent-model'],   ['silent-comm','whisper-protocol'],         'Whisper Operative',      150),
  h(180, 27, 'Stealth Cloak',     'Cloak stealth — full concealment layer',             ['cloak-stealth','conceal-model'],    ['full-conceal','cloak-protocol'],          'Cloak Operative',        150),
  h(181, 27, 'Stealth Void',      'Void stealth — zero-signature operation layer',      ['void-stealth','zero-sig-model'],    ['zero-signature','void-protocol'],         'Void Operative',         150)
];

// ═══════════════════════════════════════════════════════════════════
//  SOVEREIGN RESEARCH PAPERS — 30 Publications
// ═══════════════════════════════════════════════════════════════════

var papers = [
  { id: 1,  title: 'Matrix Algebra for Sovereign Computation',                   domain: 'linear-algebra',       abstract: 'Establishes matrix operations as the substrate for multi-house state transformation and tier-crossing inference.',                       protocols: ['matrix-multiply','determinant-solve','eigenvector-decompose'],            status: 'PUBLISHED', citations: 81 },
  { id: 2,  title: 'Statistical Analysis in Organism Intelligence',              domain: 'statistics',           abstract: 'Defines mean, variance, skewness, and kurtosis as vital signs for every sovereign organism.',                                              protocols: ['stat-aggregate','variance-monitor','kurtosis-alert'],                     status: 'PUBLISHED', citations: 67 },
  { id: 3,  title: 'Golden Ratio: Universal DNA of Architecture',                domain: 'golden-ratio',         abstract: 'Proves φ = 1.618… as the fundamental proportion governing heartbeat intervals, tier spacing, and career thresholds.',                       protocols: ['phi-heartbeat','golden-partition','ratio-validate'],                      status: 'PUBLISHED', citations: 144 },
  { id: 4,  title: 'Discrete Fourier Transform for Frequency Detection',         domain: 'signal-processing',    abstract: 'Applies DFT to extract dominant frequencies from worker heartbeat streams, enabling resonance detection across tiers.',                       protocols: ['dft-extract','frequency-lock','resonance-detect'],                        status: 'PUBLISHED', citations: 53 },
  { id: 5,  title: 'Bayesian Updates in Career-Bearing Workers',                 domain: 'bayesian-inference',   abstract: 'Models career stage transitions as Bayesian posterior updates given observed flow-cycle evidence.',                                           protocols: ['bayesian-update','posterior-career','prior-calibrate'],                   status: 'PUBLISHED', citations: 72 },
  { id: 6,  title: 'Fibonacci Sphere: 4000-Node Substrate Topology',             domain: 'topology',             abstract: 'Distributes 4000 computational nodes on a unit sphere via Fibonacci lattice for maximum isotropy.',                                          protocols: ['fibonacci-distribute','sphere-balance','node-topology'],                  status: 'PUBLISHED', citations: 89 },
  { id: 7,  title: 'Career Flow Substrate: From Task Dispatch to Sovereign Development', domain: 'career-science', abstract: 'Formalises the APPRENTICE→JOURNEYMAN→MASTER→SOVEREIGN pipeline as a flow-cycle substrate.',                                          protocols: ['career-flow','stage-promote','sovereign-attest'],                         status: 'PUBLISHED', citations: 110 },
  { id: 8,  title: 'E8/Leech Lattice Encryption for Phantom Blockchain',         domain: 'cryptography',         abstract: 'Leverages E8 and Leech lattice geometry for post-quantum encryption of the sovereign phantom ledger.',                                      protocols: ['e8-encrypt','leech-sign','phantom-verify'],                               status: 'PUBLISHED', citations: 98 },
  { id: 9,  title: 'Phyllotaxis Positioning in Meta-Architecture',               domain: 'phyllotaxis',          abstract: 'Uses sunflower spiral phyllotaxis to position houses within each tier for optimal nearest-neighbour coverage.',                               protocols: ['phyllotaxis-place','spiral-index','neighbour-cover'],                     status: 'PUBLISHED', citations: 61 },
  { id: 10, title: 'Kuramoto Coupling for Protocol Synchronization',             domain: 'nonlinear-dynamics',   abstract: 'Applies the Kuramoto model of coupled oscillators to synchronise heartbeat phase across all 181 houses.',                                    protocols: ['kuramoto-sync','phase-couple','oscillator-lock'],                         status: 'PUBLISHED', citations: 77 },
  { id: 11, title: 'Prime Sieve Algorithms for Sovereign Addressing',            domain: 'number-theory',        abstract: 'Uses sieve of Eratosthenes to assign prime-indexed routing addresses to critical houses.',                                                  protocols: ['prime-sieve','prime-route','address-assign'],                             status: 'PUBLISHED', citations: 45 },
  { id: 12, title: 'Normal Distribution in Organism Health Metrics',             domain: 'probability',          abstract: 'Models organism vital-sign distributions as Gaussian to detect anomalous houses via z-score alerting.',                                      protocols: ['gaussian-model','z-score-alert','health-check'],                          status: 'PUBLISHED', citations: 58 },
  { id: 13, title: 'Poisson Processes for Event-Driven Architecture',            domain: 'probability',          abstract: 'Models inter-arrival times of messages and events as Poisson processes for capacity planning.',                                              protocols: ['poisson-model','arrival-rate','capacity-plan'],                           status: 'PUBLISHED', citations: 42 },
  { id: 14, title: 'Linear Regression for Career Trajectory Prediction',         domain: 'regression',           abstract: 'Fits linear models to flow-cycle histories to forecast career stage transitions.',                                                          protocols: ['regression-fit','trajectory-predict','trend-detect'],                     status: 'PUBLISHED', citations: 39 },
  { id: 15, title: 'Euler Totient in Sovereign Key Generation',                  domain: 'number-theory',        abstract: 'Applies Euler totient function to generate coprime key-pairs for inter-house encrypted channels.',                                          protocols: ['totient-compute','coprime-generate','key-exchange'],                      status: 'PUBLISHED', citations: 55 },
  { id: 16, title: 'Zeckendorf Decomposition for Resource Allocation',           domain: 'combinatorics',        abstract: 'Decomposes resource budgets into non-consecutive Fibonacci numbers for optimal granularity.',                                               protocols: ['zeckendorf-decompose','fibonacci-budget','resource-split'],               status: 'PUBLISHED', citations: 33 },
  { id: 17, title: 'Graph Theory for Inter-House Communication',                 domain: 'graph-theory',         abstract: 'Models the 181-house network as a directed graph; shortest-path and minimum-spanning-tree algorithms for routing.',                          protocols: ['dijkstra-route','mst-backbone','graph-traverse'],                         status: 'PUBLISHED', citations: 86 },
  { id: 18, title: 'Information Entropy for Message Compression',                domain: 'information-theory',   abstract: 'Measures Shannon entropy of inter-house message streams to guide compression and channel capacity.',                                        protocols: ['entropy-measure','huffman-compress','channel-capacity'],                  status: 'PUBLISHED', citations: 48 },
  { id: 19, title: 'Markov Chains for Autonomous Script Scheduling',             domain: 'stochastic-processes', abstract: 'Models autonomous script execution sequences as Markov chains for probabilistic scheduling.',                                               protocols: ['markov-schedule','transition-matrix','script-chain'],                     status: 'PUBLISHED', citations: 51 },
  { id: 20, title: 'Convex Optimisation for Workforce Ecology',                  domain: 'optimisation',         abstract: 'Solves convex programs to balance workforce allocation across tiers, minimising idle time.',                                                protocols: ['convex-solve','workforce-balance','idle-minimise'],                       status: 'PUBLISHED', citations: 63 },
  { id: 21, title: 'Tensor Calculus for Multi-Tier State Propagation',           domain: 'tensor-analysis',      abstract: 'Represents tier-spanning state as tensors; contraction operations propagate updates across dimensions.',                                    protocols: ['tensor-contract','state-propagate','tier-broadcast'],                     status: 'PUBLISHED', citations: 37 },
  { id: 22, title: 'Topological Data Analysis for Fracture Detection',           domain: 'topology',             abstract: 'Uses persistent homology to detect topological signatures of structural fractures across tiers.',                                          protocols: ['persistent-homology','betti-number','fracture-signature'],                status: 'PUBLISHED', citations: 44 },
  { id: 23, title: 'Game Theory for Multi-Agent Negotiation',                    domain: 'game-theory',          abstract: 'Applies Nash equilibrium and mechanism design to sovereign multi-agent protocol negotiation.',                                              protocols: ['nash-solve','mechanism-design','agent-negotiate'],                        status: 'PUBLISHED', citations: 59 },
  { id: 24, title: 'Cellular Automata for Self-Organising Tiers',                domain: 'complexity',           abstract: 'Implements cellular automaton rules for emergent tier-level self-organisation and pattern generation.',                                     protocols: ['automaton-step','rule-apply','emergent-pattern'],                         status: 'PUBLISHED', citations: 41 },
  { id: 25, title: 'Spectral Analysis of Sovereign Heartbeat Networks',          domain: 'spectral-theory',      abstract: 'Computes eigenvalues of the house adjacency matrix to reveal spectral gaps and community structure.',                                      protocols: ['spectral-decompose','eigen-gap','community-detect'],                      status: 'PUBLISHED', citations: 52 },
  { id: 26, title: 'Homomorphic Computation in Encrypted Sovereign State',       domain: 'cryptography',         abstract: 'Enables computation on encrypted house state without decryption for privacy-preserving analytics.',                                        protocols: ['homomorphic-eval','encrypted-compute','privacy-preserve'],                status: 'PUBLISHED', citations: 66 },
  { id: 27, title: 'Queuing Theory for Message Bus Optimisation',                domain: 'operations-research',  abstract: 'Models the sovereign message bus as an M/M/k queue; derives optimal worker-pool sizes per tier.',                                          protocols: ['queue-model','arrival-service','pool-optimise'],                          status: 'PUBLISHED', citations: 47 },
  { id: 28, title: 'Differential Equations for Organism Growth Dynamics',        domain: 'dynamical-systems',    abstract: 'Models house career-growth as logistic differential equations with carrying capacity per tier.',                                            protocols: ['logistic-grow','carrying-capacity','growth-simulate'],                    status: 'PUBLISHED', citations: 38 },
  { id: 29, title: 'Category Theory for Protocol Composition',                   domain: 'category-theory',      abstract: 'Treats protocols as morphisms in a category; functorial composition ensures type-safe chaining.',                                           protocols: ['functor-compose','morphism-chain','category-verify'],                     status: 'PUBLISHED', citations: 34 },
  { id: 30, title: 'Schumann Resonance as Biological Clock Substrate',           domain: 'biophysics',           abstract: 'Grounds the 7.83 Hz brain frequency on Schumann resonance theory as the biological clock for all organisms.', protocols: ['schumann-calibrate','brain-clock','resonance-ground'],                    status: 'PUBLISHED', citations: 131 }
];

// ═══════════════════════════════════════════════════════════════════
//  AUTONOMOUS SCRIPTS — 20 Operations
// ═══════════════════════════════════════════════════════════════════

var scripts = [
  { id: 1,  name: 'house_census',           description: 'Counts all houses and verifies 181 total across 27 tiers',            frequency: 'every 10 beats',  lastRun: 0, runs: 0 },
  { id: 2,  name: 'tier_audit',             description: 'Audits each tier for correct house count and membership integrity',   frequency: 'every 15 beats',  lastRun: 0, runs: 0 },
  { id: 3,  name: 'career_advancement',     description: 'Evaluates all houses for stage promotion based on flow cycles',      frequency: 'every beat',      lastRun: 0, runs: 0 },
  { id: 4,  name: 'research_publication',   description: 'Checks for new research papers and increments citation counts',      frequency: 'every 20 beats',  lastRun: 0, runs: 0 },
  { id: 5,  name: 'protocol_binding',       description: 'Binds research paper protocols to houses that implement them',       frequency: 'every 25 beats',  lastRun: 0, runs: 0 },
  { id: 6,  name: 'workforce_ecology',      description: 'Measures workforce balance — apprentices vs masters vs sovereigns',  frequency: 'every 10 beats',  lastRun: 0, runs: 0 },
  { id: 7,  name: 'market_routing',         description: 'Routes marketplace requests to appropriate call surface houses',     frequency: 'every 5 beats',   lastRun: 0, runs: 0 },
  { id: 8,  name: 'database_sync',          description: 'Synchronises in-memory house database with heartbeat state',         frequency: 'every beat',      lastRun: 0, runs: 0 },
  { id: 9,  name: 'sovereign_attestation',  description: 'Attests sovereignty of all houses — confirms isAI, isAGI, isSovereign flags', frequency: 'every 30 beats', lastRun: 0, runs: 0 },
  { id: 10, name: 'pattern_detection',      description: 'Detects emergent patterns in career flow across tiers',              frequency: 'every 15 beats',  lastRun: 0, runs: 0 },
  { id: 11, name: 'fracture_scan',          description: 'Scans all tiers for structural fractures and inconsistencies',       frequency: 'every 20 beats',  lastRun: 0, runs: 0 },
  { id: 12, name: 'encryption_rotate',      description: 'Rotates encryption keys across Tier 22 encryption houses',           frequency: 'every 50 beats',  lastRun: 0, runs: 0 },
  { id: 13, name: 'contract_validate',      description: 'Validates all active contracts across Tier 23 contract houses',      frequency: 'every 25 beats',  lastRun: 0, runs: 0 },
  { id: 14, name: 'stealth_verify',         description: 'Verifies stealth houses maintain zero-signature operation',          frequency: 'every 10 beats',  lastRun: 0, runs: 0 },
  { id: 15, name: 'engine_health',          description: 'Checks health of all 23 Nova engines in Tier 10',                   frequency: 'every 5 beats',   lastRun: 0, runs: 0 },
  { id: 16, name: 'element_balance',        description: 'Audits element canister levels across Tier 16',                      frequency: 'every 15 beats',  lastRun: 0, runs: 0 },
  { id: 17, name: 'intelligence_sweep',     description: 'Runs intelligence sweep across Tier 26 intel houses',                frequency: 'every 10 beats',  lastRun: 0, runs: 0 },
  { id: 18, name: 'law_compliance',         description: 'Checks all houses against Tier 21 architectural laws',               frequency: 'every 20 beats',  lastRun: 0, runs: 0 },
  { id: 19, name: 'topology_rebalance',     description: 'Rebalances Fibonacci sphere topology across active houses',          frequency: 'every 30 beats',  lastRun: 0, runs: 0 },
  { id: 20, name: 'manifest_refresh',       description: 'Regenerates the full-text sovereign manifest',                       frequency: 'every 50 beats',  lastRun: 0, runs: 0 }
];

// ═══════════════════════════════════════════════════════════════════
//  CAREER FLOW ENGINE
// ═══════════════════════════════════════════════════════════════════

function advanceCareer(house) {
  house.career.flowCycles++;
  var cycles = house.career.flowCycles;
  var threshold = house.career.cyclesPerStage;

  if (house.career.stage === STAGE_APPRENTICE && cycles >= threshold) {
    house.career.stage = STAGE_JOURNEYMAN;
    house.career.flowCycles = 0;
  } else if (house.career.stage === STAGE_JOURNEYMAN && cycles >= threshold * 2) {
    house.career.stage = STAGE_MASTER;
    house.career.flowCycles = 0;
  } else if (house.career.stage === STAGE_MASTER && cycles >= threshold * 5) {
    house.career.stage = STAGE_SOVEREIGN;
    house.career.flowCycles = 0;
  }
}

// ═══════════════════════════════════════════════════════════════════
//  AUTONOMOUS SCRIPT RUNNER
// ═══════════════════════════════════════════════════════════════════

function runScripts(currentBeat) {
  for (var i = 0; i < scripts.length; i++) {
    var s = scripts[i];
    var interval = parseInt(s.frequency.replace(/[^0-9]/g, ''), 10) || 1;
    if (currentBeat % interval === 0) {
      s.lastRun = currentBeat;
      s.runs++;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════
//  QUERY HELPERS
// ═══════════════════════════════════════════════════════════════════

function getHouseById(id) {
  for (var i = 0; i < houses.length; i++) {
    if (houses[i].id === id) return houses[i];
  }
  return null;
}

function getHousesByTier(tier) {
  var result = [];
  for (var i = 0; i < houses.length; i++) {
    if (houses[i].tier === tier) result.push(houses[i]);
  }
  return result;
}

function getTierSummaries() {
  var tiers = {};
  for (var i = 0; i < houses.length; i++) {
    var t = houses[i].tier;
    if (!tiers[t]) tiers[t] = { tier: t, count: 0, houses: [] };
    tiers[t].count++;
    tiers[t].houses.push(houses[i].name);
  }
  var result = [];
  for (var k in tiers) {
    if (tiers.hasOwnProperty(k)) result.push(tiers[k]);
  }
  result.sort(function (a, b) { return a.tier - b.tier; });
  return result;
}

function searchHouses(query) {
  var q = query.toLowerCase();
  var result = [];
  for (var i = 0; i < houses.length; i++) {
    var house = houses[i];
    if (house.name.toLowerCase().indexOf(q) !== -1 ||
        house.purpose.toLowerCase().indexOf(q) !== -1) {
      result.push(house);
    }
  }
  return result;
}

function getPaperById(id) {
  for (var i = 0; i < papers.length; i++) {
    if (papers[i].id === id) return papers[i];
  }
  return null;
}

function getCareerDistribution() {
  var dist = {};
  dist[STAGE_APPRENTICE] = 0;
  dist[STAGE_JOURNEYMAN] = 0;
  dist[STAGE_MASTER] = 0;
  dist[STAGE_SOVEREIGN] = 0;
  for (var i = 0; i < houses.length; i++) {
    dist[houses[i].career.stage]++;
  }
  return dist;
}

function getEcology() {
  var dist = getCareerDistribution();
  var tierCounts = {};
  for (var i = 0; i < houses.length; i++) {
    var t = houses[i].tier;
    if (!tierCounts[t]) tierCounts[t] = 0;
    tierCounts[t]++;
  }
  var totalFlowCycles = 0;
  for (var j = 0; j < houses.length; j++) {
    totalFlowCycles += houses[j].career.flowCycles;
  }
  return {
    totalHouses: houses.length,
    totalTiers: 27,
    careerDistribution: dist,
    tierCounts: tierCounts,
    totalFlowCycles: totalFlowCycles,
    averageFlowCycles: totalFlowCycles / houses.length,
    totalPapers: papers.length,
    totalScripts: scripts.length,
    phi: PHI,
    schumannHz: SCHUMANN_HZ,
    heartbeatMs: HEARTBEAT_MS
  };
}

function getManifest() {
  var lines = [];
  lines.push('═══════════════════════════════════════════════════');
  lines.push('  DOMUS OPERANS — SOVEREIGN HOUSE MANIFEST');
  lines.push('  181 Houses · 27 Tiers · 30 Papers · 20 Scripts');
  lines.push('  Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX');
  lines.push('═══════════════════════════════════════════════════');
  lines.push('');

  var tierSummaries = getTierSummaries();
  for (var i = 0; i < tierSummaries.length; i++) {
    var ts = tierSummaries[i];
    lines.push('TIER ' + ts.tier + ' (' + ts.count + ' houses): ' + ts.houses.join(', '));
  }

  lines.push('');
  lines.push('RESEARCH PAPERS: ' + papers.length);
  for (var j = 0; j < papers.length; j++) {
    lines.push('  [' + papers[j].id + '] ' + papers[j].title + ' (' + papers[j].citations + ' citations)');
  }

  lines.push('');
  lines.push('AUTONOMOUS SCRIPTS: ' + scripts.length);
  for (var k = 0; k < scripts.length; k++) {
    lines.push('  [' + scripts[k].id + '] ' + scripts[k].name + ' — ' + scripts[k].description);
  }

  return lines.join('\n');
}

// ═══════════════════════════════════════════════════════════════════
//  MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════

self.onmessage = function (e) {
  var msg = e.data;
  switch (msg.type) {
    case 'status':
      self.postMessage({
        type: 'status',
        name: NAME,
        houses: houses.length,
        tiers: 27,
        papers: papers.length,
        scripts: scripts.length,
        beat: beat,
        uptime: Date.now() - BOOT_TIME
      });
      break;

    case 'house':
      var house = getHouseById(msg.id);
      self.postMessage({ type: 'house', data: house || null });
      break;

    case 'tier':
      self.postMessage({ type: 'tier', tier: msg.tier, data: getHousesByTier(msg.tier) });
      break;

    case 'tiers':
      self.postMessage({ type: 'tiers', data: getTierSummaries() });
      break;

    case 'search':
      self.postMessage({ type: 'search', query: msg.query, data: searchHouses(msg.query || '') });
      break;

    case 'papers':
      self.postMessage({ type: 'papers', data: papers });
      break;

    case 'paper':
      self.postMessage({ type: 'paper', data: getPaperById(msg.id) || null });
      break;

    case 'careers':
      self.postMessage({ type: 'careers', data: getCareerDistribution() });
      break;

    case 'ecology':
      self.postMessage({ type: 'ecology', data: getEcology() });
      break;

    case 'scripts':
      self.postMessage({ type: 'scripts', data: scripts });
      break;

    case 'manifest':
      self.postMessage({ type: 'manifest', data: getManifest() });
      break;

    default:
      self.postMessage({ type: 'error', message: 'Unknown type: ' + msg.type });
  }
};

// ═══════════════════════════════════════════════════════════════════
//  HEARTBEAT — 873 ms
// ═══════════════════════════════════════════════════════════════════

setInterval(function () {
  beat++;

  // Advance every house career
  for (var i = 0; i < houses.length; i++) {
    advanceCareer(houses[i]);
  }

  // Run autonomous scripts
  runScripts(beat);

  self.postMessage({
    type: 'heartbeat',
    name: NAME,
    beat: beat,
    houses: houses.length,
    uptime: Date.now() - BOOT_TIME
  });
}, HEARTBEAT_MS);

// ═══════════════════════════════════════════════════════════════════
//  BOOT
// ═══════════════════════════════════════════════════════════════════

self.postMessage({
  type: 'booted',
  name: NAME,
  houses: 181,
  tiers: 27,
  papers: 30,
  scripts: 20,
  capabilities: ['status', 'house', 'tier', 'tiers', 'search', 'papers', 'paper', 'careers', 'ecology', 'scripts', 'manifest']
});
