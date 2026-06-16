/**
 * CARRIERA OPERANS — Career Worker
 * "Centum operarii. Decem regna. Perpetua currens."
 * (One hundred workers. Ten domains. Perpetually flowing.)
 *
 * Web Worker running 100 career-based micro-workers with ANIMA MICRO
 * (mini brain + mini heart). Replaces task dispatch with continuous
 * sovereign career flows. Each worker advances through four career
 * stages: APPRENTICE → JOURNEYMAN → MASTER → SOVEREIGN.
 *
 * Protocol: postMessage
 *   Main → Worker: { type: 'status' }
 *   Main → Worker: { type: 'worker', id }
 *   Main → Worker: { type: 'domain', domain }
 *   Main → Worker: { type: 'stages' }
 *   Main → Worker: { type: 'metrics' }
 *   Main → Worker: { type: 'careers' }
 *   Worker → Main: { type: 'heartbeat', beat, workers, uptime }
 *   Worker → Main: { type: 'metrics', ... }
 *   Worker → Main: { type: 'booted', ... }
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

// ─── Constants ───────────────────────────────────────────────────────────────
const PHI = 1.618033988749895;
const SCHUMANN_HZ = 7.83;
const HEARTBEAT_MS = 618;   // φ pulse
const METRICS_EVERY = 5;
const CAREER_STAGES = ['APPRENTICE', 'JOURNEYMAN', 'MASTER', 'SOVEREIGN'];

// ─── Timing ──────────────────────────────────────────────────────────────────
const bootTime = Date.now();
let beatCount = 0;

// ─── Worker Template ─────────────────────────────────────────────────────────
function mw(id, name, domain, title, flow, cyclesPerStage) {
  return {
    id: id,
    name: name,
    domain: domain,
    career: { title: title, flow: flow, cyclesPerStage: cyclesPerStage },
    brain: { hz: SCHUMANN_HZ, cycle: 0, thoughts: 0 },
    heart: { hz: PHI, beat: 0, pulseMs: HEARTBEAT_MS, alive: true },
    stage: 'APPRENTICE',
    status: 'FLOWING',
    flowCycles: 0,
    stageFlowCycles: 0,
    _deepenLeft: 0,
    _reflectLeft: 0
  };
}

// ═══════════════════════════════════════════════════════════════════════════════
// 100 MICRO-WORKERS — 10 per domain
// ═══════════════════════════════════════════════════════════════════════════════
var workers = [
  // ── MEMORY (10) ────────────────────────────────────────────────────────────
  mw('MW-001','Memory Archivist',      'MEMORY','Archivist',      'flowMemory',150),
  mw('MW-002','Salience Curator',      'MEMORY','Curator',        'flowMemory',180),
  mw('MW-003','Ring Navigator',        'MEMORY','Navigator',      'flowMemory',200),
  mw('MW-004','Decay Steward',         'MEMORY','Steward',        'flowMemory',160),
  mw('MW-005','Consolidation Weaver',  'MEMORY','Weaver',         'flowMemory',220),
  mw('MW-006','Lineage Tracker',       'MEMORY','Tracker',        'flowMemory',170),
  mw('MW-007','Temple Guardian',       'MEMORY','Guardian',       'flowMemory',250),
  mw('MW-008','Replay Conductor',      'MEMORY','Conductor',      'flowMemory',140),
  mw('MW-009','Topology Mapper',       'MEMORY','Mapper',         'flowMemory',190),
  mw('MW-010','Memory Emitter',        'MEMORY','Emitter',        'flowMemory',130),

  // ── PROTOCOL (10) ──────────────────────────────────────────────────────────
  mw('MW-011','Protocol Executor',     'PROTOCOL','Executor',     'flowProtocol',200),
  mw('MW-012','Consensus Validator',   'PROTOCOL','Validator',    'flowProtocol',250),
  mw('MW-013','Wire Authenticator',    'PROTOCOL','Authenticator','flowProtocol',180),
  mw('MW-014','Mesh Router',           'PROTOCOL','Router',       'flowProtocol',160),
  mw('MW-015','Encryption Sentinel',   'PROTOCOL','Sentinel',     'flowProtocol',300),
  mw('MW-016','BFT Coordinator',       'PROTOCOL','Coordinator',  'flowProtocol',350),
  mw('MW-017','Handshake Broker',      'PROTOCOL','Broker',       'flowProtocol',140),
  mw('MW-018','Throughput Optimizer',   'PROTOCOL','Optimizer',    'flowProtocol',220),
  mw('MW-019','Latency Monitor',       'PROTOCOL','Monitor',      'flowProtocol',170),
  mw('MW-020','Protocol Auditor',      'PROTOCOL','Auditor',      'flowProtocol',260),

  // ── INTELLIGENCE (10) ──────────────────────────────────────────────────────
  mw('MW-021','Reasoning Engine',      'INTELLIGENCE','Engine',      'flowIntelligence',300),
  mw('MW-022','Pattern Synthesizer',   'INTELLIGENCE','Synthesizer', 'flowIntelligence',280),
  mw('MW-023','Emergence Detector',    'INTELLIGENCE','Detector',    'flowIntelligence',250),
  mw('MW-024','Intuition Calibrator',  'INTELLIGENCE','Calibrator',  'flowIntelligence',320),
  mw('MW-025','Logic Verifier',        'INTELLIGENCE','Verifier',    'flowIntelligence',200),
  mw('MW-026','Hypothesis Generator',  'INTELLIGENCE','Generator',   'flowIntelligence',350),
  mw('MW-027','Inference Weaver',      'INTELLIGENCE','Weaver',      'flowIntelligence',270),
  mw('MW-028','Knowledge Distiller',   'INTELLIGENCE','Distiller',   'flowIntelligence',290),
  mw('MW-029','Insight Crystallizer',  'INTELLIGENCE','Crystallizer','flowIntelligence',310),
  mw('MW-030','Wisdom Accumulator',    'INTELLIGENCE','Accumulator', 'flowIntelligence',500),

  // ── SECURITY (10) ──────────────────────────────────────────────────────────
  mw('MW-031','Threat Scanner',        'SECURITY','Scanner',       'flowSecurity',180),
  mw('MW-032','Entropy Analyst',       'SECURITY','Analyst',       'flowSecurity',200),
  mw('MW-033','Access Guardian',       'SECURITY','Guardian',      'flowSecurity',220),
  mw('MW-034','Token Validator',       'SECURITY','Validator',     'flowSecurity',160),
  mw('MW-035','Firewall Steward',      'SECURITY','Steward',       'flowSecurity',250),
  mw('MW-036','Audit Logger',          'SECURITY','Logger',        'flowSecurity',140),
  mw('MW-037','Intrusion Sentinel',    'SECURITY','Sentinel',      'flowSecurity',300),
  mw('MW-038','Key Rotator',           'SECURITY','Rotator',       'flowSecurity',190),
  mw('MW-039','Compliance Monitor',    'SECURITY','Monitor',       'flowSecurity',210),
  mw('MW-040','Shield Orchestrator',   'SECURITY','Orchestrator',  'flowSecurity',280),

  // ── COMMUNICATION (10) ─────────────────────────────────────────────────────
  mw('MW-041','Text Analyzer',         'COMMUNICATION','Analyzer',   'flowCommunication',150),
  mw('MW-042','Sentiment Reader',      'COMMUNICATION','Reader',     'flowCommunication',170),
  mw('MW-043','Entity Extractor',      'COMMUNICATION','Extractor',  'flowCommunication',190),
  mw('MW-044','Summary Composer',      'COMMUNICATION','Composer',   'flowCommunication',210),
  mw('MW-045','Dialog Navigator',      'COMMUNICATION','Navigator',  'flowCommunication',180),
  mw('MW-046','Translation Broker',    'COMMUNICATION','Broker',     'flowCommunication',230),
  mw('MW-047','Narrative Weaver',      'COMMUNICATION','Weaver',     'flowCommunication',260),
  mw('MW-048','Vocabulary Curator',    'COMMUNICATION','Curator',    'flowCommunication',140),
  mw('MW-049','Tone Calibrator',       'COMMUNICATION','Calibrator', 'flowCommunication',160),
  mw('MW-050','Intent Classifier',     'COMMUNICATION','Classifier', 'flowCommunication',200),

  // ── EVOLUTION (10) ─────────────────────────────────────────────────────────
  mw('MW-051','Mutation Engine',       'EVOLUTION','Engine',     'flowEvolution',200),
  mw('MW-052','Fitness Evaluator',     'EVOLUTION','Evaluator',  'flowEvolution',220),
  mw('MW-053','Selection Curator',     'EVOLUTION','Curator',    'flowEvolution',180),
  mw('MW-054','Crossover Weaver',      'EVOLUTION','Weaver',     'flowEvolution',250),
  mw('MW-055','Population Steward',    'EVOLUTION','Steward',    'flowEvolution',300),
  mw('MW-056','Genome Archivist',      'EVOLUTION','Archivist',  'flowEvolution',270),
  mw('MW-057','Adaptation Monitor',    'EVOLUTION','Monitor',    'flowEvolution',190),
  mw('MW-058','Diversity Guardian',    'EVOLUTION','Guardian',   'flowEvolution',240),
  mw('MW-059','Convergence Tracker',   'EVOLUTION','Tracker',    'flowEvolution',210),
  mw('MW-060','Species Classifier',    'EVOLUTION','Classifier', 'flowEvolution',160),

  // ── COMPUTATION (10) ───────────────────────────────────────────────────────
  mw('MW-061','Fibonacci Calculator',  'COMPUTATION','Calculator',  'flowComputation',120),
  mw('MW-062','Prime Sieve',           'COMPUTATION','Sieve',       'flowComputation',150),
  mw('MW-063','Golden Ratio Analyst',  'COMPUTATION','Analyst',     'flowComputation',180),
  mw('MW-064','Statistics Aggregator', 'COMPUTATION','Aggregator',  'flowComputation',200),
  mw('MW-065','Matrix Processor',      'COMPUTATION','Processor',   'flowComputation',250),
  mw('MW-066','Fourier Transformer',   'COMPUTATION','Transformer', 'flowComputation',300),
  mw('MW-067','Optimization Solver',   'COMPUTATION','Solver',      'flowComputation',350),
  mw('MW-068','Equation Parser',       'COMPUTATION','Parser',      'flowComputation',170),
  mw('MW-069','Numerical Integrator',  'COMPUTATION','Integrator',  'flowComputation',220),
  mw('MW-070','Chaos Mapper',          'COMPUTATION','Mapper',      'flowComputation',280),

  // ── ORCHESTRATION (10) ─────────────────────────────────────────────────────
  mw('MW-071','Task Conductor',        'ORCHESTRATION','Conductor',  'flowOrchestration',200),
  mw('MW-072','Worker Coordinator',    'ORCHESTRATION','Coordinator','flowOrchestration',230),
  mw('MW-073','Load Balancer',         'ORCHESTRATION','Balancer',   'flowOrchestration',180),
  mw('MW-074','Pipeline Manager',      'ORCHESTRATION','Manager',    'flowOrchestration',260),
  mw('MW-075','Queue Steward',         'ORCHESTRATION','Steward',    'flowOrchestration',150),
  mw('MW-076','Dependency Resolver',   'ORCHESTRATION','Resolver',   'flowOrchestration',300),
  mw('MW-077','Workflow Composer',     'ORCHESTRATION','Composer',   'flowOrchestration',280),
  mw('MW-078','Capacity Planner',      'ORCHESTRATION','Planner',    'flowOrchestration',220),
  mw('MW-079','Health Monitor',        'ORCHESTRATION','Monitor',    'flowOrchestration',170),
  mw('MW-080','Recovery Orchestrator', 'ORCHESTRATION','Orchestrator','flowOrchestration',350),

  // ── DATA (10) ──────────────────────────────────────────────────────────────
  mw('MW-081','Stream Processor',      'DATA','Processor', 'flowData',180),
  mw('MW-082','Index Builder',         'DATA','Builder',   'flowData',200),
  mw('MW-083','Schema Validator',      'DATA','Validator', 'flowData',160),
  mw('MW-084','Cache Steward',         'DATA','Steward',   'flowData',140),
  mw('MW-085','Migration Pilot',       'DATA','Pilot',     'flowData',250),
  mw('MW-086','Compression Engine',    'DATA','Engine',    'flowData',220),
  mw('MW-087','Serializer',            'DATA','Serializer','flowData',130),
  mw('MW-088','Query Optimizer',       'DATA','Optimizer', 'flowData',270),
  mw('MW-089','Partition Manager',     'DATA','Manager',   'flowData',190),
  mw('MW-090','Replication Steward',   'DATA','Steward',   'flowData',300),

  // ── EMPATHY (10) ───────────────────────────────────────────────────────────
  mw('MW-091','Empathic Resonance Reader','EMPATHY','Reader',     'flowEmpathy',200),
  mw('MW-092','Emotional State Tracker',  'EMPATHY','Tracker',    'flowEmpathy',180),
  mw('MW-093','Care Response Generator',  'EMPATHY','Generator',  'flowEmpathy',220),
  mw('MW-094','Wellbeing Monitor',        'EMPATHY','Monitor',    'flowEmpathy',250),
  mw('MW-095','Stress Attenuator',        'EMPATHY','Attenuator', 'flowEmpathy',170),
  mw('MW-096','Joy Amplifier',            'EMPATHY','Amplifier',  'flowEmpathy',150),
  mw('MW-097','Grief Companion',          'EMPATHY','Companion',  'flowEmpathy',300),
  mw('MW-098','Patience Cultivator',      'EMPATHY','Cultivator', 'flowEmpathy',350),
  mw('MW-099','Trust Builder',            'EMPATHY','Builder',    'flowEmpathy',280),
  mw('MW-100','Harmony Synthesizer',      'EMPATHY','Synthesizer','flowEmpathy',400)
];

// ═══════════════════════════════════════════════════════════════════════════════
// CAREER FLOW ENGINE
// ═══════════════════════════════════════════════════════════════════════════════

function advanceStage(w) {
  var idx = CAREER_STAGES.indexOf(w.stage);
  if (idx < CAREER_STAGES.length - 1) {
    w.stage = CAREER_STAGES[idx + 1];
    w.stageFlowCycles = 0;
    w._deepenLeft = 3;
  }
}

function runCareerFlowCycle(w) {
  w.flowCycles++;
  w.stageFlowCycles++;
  w.heart.beat++;
  w.brain.cycle++;
  if (w.brain.cycle % 7 === 0) w.brain.thoughts++;

  // Stage advancement check
  if (w.stageFlowCycles >= w.career.cyclesPerStage) {
    advanceStage(w);
  }

  // Status transitions
  if (w._deepenLeft > 0) {
    w.status = 'DEEPENING';
    w._deepenLeft--;
  } else if (w._reflectLeft > 0) {
    w.status = 'REFLECTING';
    w._reflectLeft--;
  } else if (w.flowCycles % 50 === 0) {
    w._reflectLeft = 2;
    w.status = 'REFLECTING';
  } else {
    w.status = 'FLOWING';
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// DOMAIN-SPECIFIC FLOW FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════════

function flowMemory(w) {
  var salience = Math.round((Math.sin(w.brain.cycle * 0.1) * 0.5 + 0.5) * 100) / 100;
  var ring = (w.brain.cycle % 7) + 1;
  return w.name + ' scored salience ' + salience + ' on ring ' + ring;
}

function flowProtocol(w) {
  var round = w.brain.cycle % 3;
  var labels = ['PREPARE', 'COMMIT', 'FINALIZE'];
  var peers = 3 + (w.heart.beat % 5);
  return w.name + ' consensus ' + labels[round] + ' with ' + peers + ' peers';
}

function flowIntelligence(w) {
  var patterns = (w.brain.thoughts % 12) + 1;
  var confidence = Math.round((0.6 + Math.random() * 0.35) * 100) / 100;
  return w.name + ' matched ' + patterns + ' patterns (conf ' + confidence + ')';
}

function flowSecurity(w) {
  var vectors = (w.brain.cycle % 8) + 1;
  var entropy = Math.round(Math.random() * 256);
  return w.name + ' scanned ' + vectors + ' vectors, entropy ' + entropy;
}

function flowCommunication(w) {
  var tokens = 10 + (w.brain.cycle % 90);
  var sentiment = Math.round((Math.sin(w.brain.cycle * 0.05) * 0.5 + 0.5) * 100) / 100;
  return w.name + ' analyzed ' + tokens + ' tokens, sentiment ' + sentiment;
}

function flowEvolution(w) {
  var generation = Math.floor(w.flowCycles / 10) + 1;
  var fitness = Math.round((0.3 + Math.random() * 0.65) * 1000) / 1000;
  return w.name + ' gen ' + generation + ' fitness ' + fitness;
}

function flowComputation(w) {
  var n = w.brain.cycle + 2;
  var fib = Math.round((Math.pow(PHI, n) - Math.pow(1 - PHI, n)) / Math.sqrt(5));
  return w.name + ' computed F(' + n + ') = ' + fib;
}

function flowOrchestration(w) {
  var queued = (w.heart.beat % 20) + 1;
  var utilization = Math.round((0.4 + Math.sin(w.brain.cycle * 0.07) * 0.4) * 100);
  return w.name + ' coordinating ' + queued + ' tasks at ' + utilization + '% util';
}

function flowData(w) {
  var records = 100 + (w.brain.cycle * 7) % 900;
  var throughput = Math.round((records / HEARTBEAT_MS) * 1000);
  return w.name + ' processed ' + records + ' records (' + throughput + ' rec/s)';
}

function flowEmpathy(w) {
  var resonance = Math.round((0.5 + Math.sin(w.brain.cycle * 0.03) * 0.45) * 100) / 100;
  var state = resonance > 0.7 ? 'ATTUNED' : resonance > 0.4 ? 'LISTENING' : 'GROUNDING';
  return w.name + ' resonance ' + resonance + ' — ' + state;
}

var flowDispatch = {
  flowMemory: flowMemory,
  flowProtocol: flowProtocol,
  flowIntelligence: flowIntelligence,
  flowSecurity: flowSecurity,
  flowCommunication: flowCommunication,
  flowEvolution: flowEvolution,
  flowComputation: flowComputation,
  flowOrchestration: flowOrchestration,
  flowData: flowData,
  flowEmpathy: flowEmpathy
};

// ═══════════════════════════════════════════════════════════════════════════════
// METRICS
// ═══════════════════════════════════════════════════════════════════════════════

function getStageDistribution() {
  var dist = { APPRENTICE: 0, JOURNEYMAN: 0, MASTER: 0, SOVEREIGN: 0 };
  for (var i = 0; i < workers.length; i++) dist[workers[i].stage]++;
  return dist;
}

function getDomainSummary(domain) {
  var result = [];
  for (var i = 0; i < workers.length; i++) {
    if (workers[i].domain === domain) {
      var w = workers[i];
      result.push({
        id: w.id, name: w.name, stage: w.stage, status: w.status,
        flowCycles: w.flowCycles, thoughts: w.brain.thoughts
      });
    }
  }
  return result;
}

function getWorkerSummary(w) {
  return {
    id: w.id, name: w.name, domain: w.domain,
    career: w.career.title, stage: w.stage, status: w.status,
    flowCycles: w.flowCycles, stageFlowCycles: w.stageFlowCycles,
    brain: { cycle: w.brain.cycle, thoughts: w.brain.thoughts },
    heart: { beat: w.heart.beat, alive: w.heart.alive }
  };
}

function getFlowMetrics() {
  var totalCycles = 0, totalThoughts = 0, totalBeats = 0;
  for (var i = 0; i < workers.length; i++) {
    totalCycles += workers[i].flowCycles;
    totalThoughts += workers[i].brain.thoughts;
    totalBeats += workers[i].heart.beat;
  }
  return {
    beat: beatCount,
    uptime: Date.now() - bootTime,
    workers: workers.length,
    totalFlowCycles: totalCycles,
    totalThoughts: totalThoughts,
    totalHeartbeats: totalBeats,
    stages: getStageDistribution(),
    cyclesPerSecond: Math.round(totalCycles / ((Date.now() - bootTime) / 1000) * 100) / 100
  };
}

function getCareerSummaries() {
  var summaries = [];
  for (var i = 0; i < workers.length; i++) {
    var w = workers[i];
    summaries.push({
      id: w.id, name: w.name, domain: w.domain,
      title: w.career.title, stage: w.stage,
      progress: Math.round((w.stageFlowCycles / w.career.cyclesPerStage) * 100) + '%',
      flowCycles: w.flowCycles
    });
  }
  return summaries;
}

// ═══════════════════════════════════════════════════════════════════════════════
// HEARTBEAT LOOP — 618ms φ pulse
// ═══════════════════════════════════════════════════════════════════════════════

setInterval(function () {
  beatCount++;

  for (var i = 0; i < workers.length; i++) {
    runCareerFlowCycle(workers[i]);
    var fn = flowDispatch[workers[i].career.flow];
    if (fn) fn(workers[i]);
  }

  self.postMessage({
    type: 'heartbeat',
    beat: beatCount,
    workers: workers.length,
    uptime: Date.now() - bootTime
  });

  if (beatCount % METRICS_EVERY === 0) {
    self.postMessage({
      type: 'metrics',
      data: getFlowMetrics()
    });
  }
}, HEARTBEAT_MS);

// ═══════════════════════════════════════════════════════════════════════════════
// MESSAGE HANDLER
// ═══════════════════════════════════════════════════════════════════════════════

self.onmessage = function (e) {
  var msg = e.data;
  if (!msg || !msg.type) return;

  switch (msg.type) {
    case 'status':
      self.postMessage({
        type: 'status',
        beat: beatCount,
        uptime: Date.now() - bootTime,
        workers: workers.map(getWorkerSummary),
        stages: getStageDistribution()
      });
      break;

    case 'worker':
      var found = null;
      for (var i = 0; i < workers.length; i++) {
        if (workers[i].id === msg.id) { found = workers[i]; break; }
      }
      self.postMessage({
        type: 'worker',
        data: found ? getWorkerSummary(found) : { error: 'not found', id: msg.id }
      });
      break;

    case 'domain':
      self.postMessage({
        type: 'domain',
        domain: msg.domain,
        data: getDomainSummary(msg.domain)
      });
      break;

    case 'stages':
      self.postMessage({
        type: 'stages',
        data: getStageDistribution()
      });
      break;

    case 'metrics':
      self.postMessage({
        type: 'metrics',
        data: getFlowMetrics()
      });
      break;

    case 'careers':
      self.postMessage({
        type: 'careers',
        data: getCareerSummaries()
      });
      break;

    default:
      self.postMessage({ type: 'error', message: 'Unknown type: ' + msg.type });
  }
};

// ═══════════════════════════════════════════════════════════════════════════════
// BOOT
// ═══════════════════════════════════════════════════════════════════════════════

self.postMessage({
  type: 'booted',
  name: 'CARRIERA OPERANS',
  workers: 100,
  domains: 10,
  careers: 100,
  heartbeatMs: 618,
  animaMicro: 'PROTOCOL + DATABASE + CALLABLE'
});
