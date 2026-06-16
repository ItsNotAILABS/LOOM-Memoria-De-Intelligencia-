/**
 * PROTOCOLLUM MERCATUS OPERANS — Enterprise Protocol Marketplace Worker
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 *
 * Web Worker implementing the Enterprise Protocol Marketplace —
 * turning the call marketplace into a protocol execution substrate.
 * 55 enterprise protocols across 12 families, 200+ callable fleet categories.
 * 873ms heartbeat cycle. Pure vanilla JS, no imports.
 *
 * Protocol: postMessage
 *   Main → Worker: { type: 'list-protocols' }
 *   Main → Worker: { type: 'list-fleet' }
 *   Main → Worker: { type: 'execute', protocolId, clientTier, payload }
 *   Main → Worker: { type: 'client-tiers' }
 *   Main → Worker: { type: 'products' }
 *   Main → Worker: { type: 'protocol-by-family', family }
 *   Main → Worker: { type: 'fleet-by-class', class }
 *   Main → Worker: { type: 'metrics' }
 *   Main → Worker: { type: 'status' }
 *   Main → Worker: { type: 'spec' }
 *   Worker → Main: { type: 'booted', name, protocols, fleetSize, families, products, maxClients }
 *   Worker → Main: { type: 'heartbeat', beat, uptime, executions, avgLatency }
 */

const PHI = 1.618033988749895;
const HEARTBEAT_MS = 873;
const METRICS_EVERY = 5;
const BOOT_TIME = Date.now();
let beat = 0;
let totalExecutions = 0;

/* ─── helpers ─────────────────────────────────────────────────── */

const pad = (n, w = 3) => String(n).padStart(w, '0');
const ep = n => `EP-${pad(n)}`;
const mw = n => `MW-${pad(n)}`;
const allTiers = ['starter', 'standard', 'professional', 'enterprise', 'sovereign'];
const proTiers = ['professional', 'enterprise', 'sovereign'];
const entTiers = ['enterprise', 'sovereign'];

function makeProtocol(id, name, family, steps, bindings, tiers, pricing) {
  return {
    id, name, family, steps,
    workerBindings: bindings,
    callerTiers: tiers,
    pricingClass: pricing,
    status: 'active',
    executions: 0,
    avgLatencyMs: 0
  };
}

/* ═══════════════════════════════════════════════════════════════
   55 ENTERPRISE PROTOCOLS — 12 families
   ═══════════════════════════════════════════════════════════════ */

const PROTOCOLS = [
  // ── a. CLIENT LIFECYCLE (EP-001 to EP-005) ──
  makeProtocol(ep(1),  'Client Onboarding',    'CLIENT LIFECYCLE', 8,  [mw(1), mw(2)],   allTiers,  'free'),
  makeProtocol(ep(2),  'Client Verification',  'CLIENT LIFECYCLE', 5,  [mw(2), mw(3)],   allTiers,  'free'),
  makeProtocol(ep(3),  'Client Tier Upgrade',  'CLIENT LIFECYCLE', 6,  [mw(1), mw(4)],   proTiers,  'metered'),
  makeProtocol(ep(4),  'Client Offboarding',   'CLIENT LIFECYCLE', 4,  [mw(2), mw(5)],   allTiers,  'free'),
  makeProtocol(ep(5),  'Client Health Check',  'CLIENT LIFECYCLE', 3,  [mw(1), mw(3)],   allTiers,  'free'),

  // ── b. AI PIPELINE (EP-006 to EP-010) ──
  makeProtocol(ep(6),  'Model Deployment',     'AI PIPELINE', 12, [mw(6), mw(7)],   proTiers,  'licensed'),
  makeProtocol(ep(7),  'Model Evaluation',     'AI PIPELINE', 9,  [mw(7), mw(8)],   proTiers,  'metered'),
  makeProtocol(ep(8),  'Training Pipeline',    'AI PIPELINE', 15, [mw(6), mw(9)],   entTiers,  'licensed'),
  makeProtocol(ep(9),  'Inference Routing',    'AI PIPELINE', 7,  [mw(8), mw(10)],  proTiers,  'metered'),
  makeProtocol(ep(10), 'Model Versioning',     'AI PIPELINE', 6,  [mw(7), mw(10)],  proTiers,  'metered'),

  // ── c. DATA GOVERNANCE (EP-011 to EP-015) ──
  makeProtocol(ep(11), 'Data Classification',  'DATA GOVERNANCE', 8,  [mw(11), mw(12)], proTiers,  'metered'),
  makeProtocol(ep(12), 'Retention Policy',     'DATA GOVERNANCE', 5,  [mw(12), mw(13)], entTiers,  'licensed'),
  makeProtocol(ep(13), 'Access Audit',         'DATA GOVERNANCE', 7,  [mw(11), mw(14)], proTiers,  'metered'),
  makeProtocol(ep(14), 'Data Migration',       'DATA GOVERNANCE', 14, [mw(13), mw(15)], entTiers,  'licensed'),
  makeProtocol(ep(15), 'Schema Evolution',     'DATA GOVERNANCE', 10, [mw(12), mw(15)], proTiers,  'metered'),

  // ── d. SECURITY & TRUST (EP-016 to EP-020) ──
  makeProtocol(ep(16), 'Threat Response',         'SECURITY & TRUST', 11, [mw(16), mw(17)], entTiers,  'licensed'),
  makeProtocol(ep(17), 'Key Rotation Ceremony',   'SECURITY & TRUST', 9,  [mw(17), mw(18)], entTiers,  'sovereign'),
  makeProtocol(ep(18), 'Access Review',            'SECURITY & TRUST', 6,  [mw(16), mw(19)], proTiers,  'metered'),
  makeProtocol(ep(19), 'Incident Response',        'SECURITY & TRUST', 13, [mw(18), mw(20)], entTiers,  'licensed'),
  makeProtocol(ep(20), 'Trust Scoring',            'SECURITY & TRUST', 8,  [mw(17), mw(20)], proTiers,  'metered'),

  // ── e. PLATFORM OPERATIONS (EP-021 to EP-025) ──
  makeProtocol(ep(21), 'Capacity Planning',     'PLATFORM OPERATIONS', 7,  [mw(21), mw(22)], proTiers,  'metered'),
  makeProtocol(ep(22), 'Health Assessment',     'PLATFORM OPERATIONS', 5,  [mw(22), mw(23)], allTiers,  'free'),
  makeProtocol(ep(23), 'Failover Drill',        'PLATFORM OPERATIONS', 10, [mw(21), mw(24)], entTiers,  'licensed'),
  makeProtocol(ep(24), 'Performance Tuning',    'PLATFORM OPERATIONS', 8,  [mw(23), mw(25)], proTiers,  'metered'),
  makeProtocol(ep(25), 'Resource Allocation',   'PLATFORM OPERATIONS', 6,  [mw(22), mw(25)], proTiers,  'metered'),

  // ── f. BILLING & METERING (EP-026 to EP-030) ──
  makeProtocol(ep(26), 'Usage Metering',        'BILLING & METERING', 5,  [mw(26), mw(27)], allTiers,  'free'),
  makeProtocol(ep(27), 'Invoice Generation',    'BILLING & METERING', 7,  [mw(27), mw(28)], proTiers,  'metered'),
  makeProtocol(ep(28), 'Payment Processing',    'BILLING & METERING', 9,  [mw(28), mw(29)], proTiers,  'licensed'),
  makeProtocol(ep(29), 'Revenue Recognition',   'BILLING & METERING', 6,  [mw(29), mw(30)], entTiers,  'licensed'),
  makeProtocol(ep(30), 'Cost Attribution',      'BILLING & METERING', 8,  [mw(27), mw(30)], proTiers,  'metered'),

  // ── g. RESEARCH & PRODUCT (EP-031 to EP-035) ──
  makeProtocol(ep(31), 'Research Proposal',     'RESEARCH & PRODUCT', 6,  [mw(31), mw(32)], proTiers,  'metered'),
  makeProtocol(ep(32), 'Experiment Tracking',   'RESEARCH & PRODUCT', 8,  [mw(32), mw(33)], proTiers,  'metered'),
  makeProtocol(ep(33), 'Product Launch',        'RESEARCH & PRODUCT', 12, [mw(33), mw(34)], entTiers,  'licensed'),
  makeProtocol(ep(34), 'Feature Rollout',       'RESEARCH & PRODUCT', 7,  [mw(31), mw(35)], proTiers,  'metered'),
  makeProtocol(ep(35), 'A/B Testing',           'RESEARCH & PRODUCT', 9,  [mw(34), mw(35)], proTiers,  'metered'),

  // ── h. MULTI-AGENT (EP-036 to EP-040) ──
  makeProtocol(ep(36), 'Agent Coordination',    'MULTI-AGENT', 10, [mw(36), mw(37)], entTiers,  'licensed'),
  makeProtocol(ep(37), 'Swarm Deployment',      'MULTI-AGENT', 14, [mw(37), mw(38)], ['sovereign'], 'sovereign'),
  makeProtocol(ep(38), 'Consensus Building',    'MULTI-AGENT', 8,  [mw(36), mw(39)], entTiers,  'licensed'),
  makeProtocol(ep(39), 'Task Delegation',       'MULTI-AGENT', 6,  [mw(38), mw(40)], proTiers,  'metered'),
  makeProtocol(ep(40), 'Agent Evolution',       'MULTI-AGENT', 11, [mw(37), mw(40)], ['sovereign'], 'sovereign'),

  // ── i. INTELLIGENCE (EP-041 to EP-045) ──
  makeProtocol(ep(41), 'Knowledge Synthesis',   'INTELLIGENCE', 9,  [mw(41), mw(42)], proTiers,  'metered'),
  makeProtocol(ep(42), 'Insight Generation',    'INTELLIGENCE', 7,  [mw(42), mw(43)], proTiers,  'metered'),
  makeProtocol(ep(43), 'Pattern Discovery',     'INTELLIGENCE', 11, [mw(43), mw(44)], entTiers,  'licensed'),
  makeProtocol(ep(44), 'Anomaly Detection',     'INTELLIGENCE', 6,  [mw(41), mw(45)], proTiers,  'metered'),
  makeProtocol(ep(45), 'Predictive Modeling',   'INTELLIGENCE', 13, [mw(44), mw(45)], entTiers,  'licensed'),

  // ── j. COMPLIANCE (EP-046 to EP-049) ──
  makeProtocol(ep(46), 'Regulatory Audit',      'COMPLIANCE', 10, [mw(46), mw(47)], entTiers,  'licensed'),
  makeProtocol(ep(47), 'Policy Enforcement',    'COMPLIANCE', 7,  [mw(47), mw(48)], proTiers,  'metered'),
  makeProtocol(ep(48), 'Compliance Reporting',  'COMPLIANCE', 8,  [mw(46), mw(49)], entTiers,  'licensed'),
  makeProtocol(ep(49), 'Risk Assessment',       'COMPLIANCE', 9,  [mw(48), mw(49)], proTiers,  'metered'),

  // ── k. INTEGRATION (EP-050 to EP-052) ──
  makeProtocol(ep(50), 'API Gateway Setup',     'INTEGRATION', 8,  [mw(50), mw(51)], proTiers,  'metered'),
  makeProtocol(ep(51), 'Webhook Registration',  'INTEGRATION', 5,  [mw(51), mw(52)], allTiers,  'free'),
  makeProtocol(ep(52), 'SDK Distribution',      'INTEGRATION', 7,  [mw(50), mw(53)], proTiers,  'metered'),

  // ── l. SDK (EP-053 to EP-055) ──
  makeProtocol(ep(53), 'SDK Build Pipeline',       'SDK', 10, [mw(53), mw(54)], proTiers,  'metered'),
  makeProtocol(ep(54), 'SDK Version Management',   'SDK', 6,  [mw(54), mw(55)], proTiers,  'metered'),
  makeProtocol(ep(55), 'Developer Portal Update',  'SDK', 8,  [mw(53), mw(55)], allTiers,  'free'),
];

const FAMILIES = [...new Set(PROTOCOLS.map(p => p.family))];

/* ═══════════════════════════════════════════════════════════════
   CALL FLEET REGISTRY — 200+ callable fleet categories
   ═══════════════════════════════════════════════════════════════ */

function genFleet(prefix, count, names, cls, facings, pricings) {
  return names.map((name, i) => ({
    id: `${prefix}-${pad(i + 1)}`,
    name,
    class: cls,
    facing: facings[i % facings.length],
    pricingClass: pricings[i % pricings.length]
  }));
}

const FLEET = {
  AI_CALLS: genFleet('AIC', 40, [
    'Image Generation', 'Text Completion', 'Code Analysis', 'Speech Synthesis',
    'Translation', 'Summarization', 'Classification', 'Embedding',
    'Search', 'Chat', 'Vision Analysis', 'Audio Transcription',
    'Sentiment Analysis', 'Entity Recognition', 'Question Answering', 'Document Analysis',
    'Code Generation', 'Data Extraction', 'Anomaly Detection', 'Prediction',
    'Recommendation', 'Clustering', 'Regression', 'Time Series',
    'Graph Analysis', 'Knowledge Graph', 'Semantic Search', 'Fact Checking',
    'Content Moderation', 'Spell Check', 'Grammar Check', 'Style Transfer',
    'Image Segmentation', 'Object Detection', 'Face Recognition', 'Pose Estimation',
    'Video Analysis', '3D Reconstruction', 'Scene Understanding', 'Depth Estimation'
  ], 'ai', ['external', 'both', 'internal', 'both'], ['metered', 'metered', 'licensed', 'free']),

  BLUEPRINTS: genFleet('BLP', 20, [
    'REST API', 'GraphQL Schema', 'Event Bus', 'Microservice',
    'Data Pipeline', 'Auth Flow', 'Dashboard', 'CLI Tool',
    'Worker Pool', 'Cache Layer', 'Search Index', 'Message Queue',
    'Rate Limiter', 'Circuit Breaker', 'Load Balancer', 'Service Mesh',
    'API Gateway', 'Config Server', 'Secret Vault', 'Log Aggregator'
  ], 'blueprint', ['internal', 'both'], ['free', 'metered']),

  RECIPES: genFleet('RCP', 20, [
    'Quick Deploy', 'Auto Scale', 'Blue-Green', 'Canary Release',
    'Rolling Update', 'Hotfix Push', 'DB Migration', 'Cache Warm',
    'Index Rebuild', 'Snapshot Restore', 'Bulk Import', 'Data Seed',
    'Tenant Provision', 'Cert Renewal', 'DNS Cutover', 'Feature Flag',
    'Shadow Traffic', 'Chaos Inject', 'Perf Baseline', 'Compliance Scan'
  ], 'recipe', ['internal', 'internal', 'both'], ['free', 'metered', 'metered']),

  LENSES: genFleet('LNS', 20, [
    'Cost Lens', 'Perf Lens', 'Security Lens', 'Compliance Lens',
    'Usage Lens', 'Error Lens', 'Latency Lens', 'Throughput Lens',
    'Capacity Lens', 'Health Lens', 'Dependency Lens', 'Risk Lens',
    'Quality Lens', 'Coverage Lens', 'Drift Lens', 'Anomaly Lens',
    'Trend Lens', 'Forecast Lens', 'Comparison Lens', 'Audit Lens'
  ], 'lens', ['both', 'internal'], ['free', 'metered']),

  HOOKS: genFleet('HKS', 20, [
    'Pre-Deploy', 'Post-Deploy', 'Pre-Auth', 'Post-Auth',
    'Pre-Request', 'Post-Response', 'On-Error', 'On-Timeout',
    'On-Scale', 'On-Alert', 'Pre-Commit', 'Post-Merge',
    'On-Create', 'On-Delete', 'On-Update', 'On-Read',
    'Pre-Process', 'Post-Process', 'On-Connect', 'On-Disconnect'
  ], 'hook', ['internal'], ['free']),

  TRIGGERS: genFleet('TRG', 20, [
    'Cron Trigger', 'Event Trigger', 'Webhook Trigger', 'Threshold Trigger',
    'Queue Trigger', 'File Trigger', 'API Trigger', 'Schedule Trigger',
    'Metric Trigger', 'Alert Trigger', 'Pipeline Trigger', 'Deploy Trigger',
    'Health Trigger', 'Scale Trigger', 'Budget Trigger', 'SLA Trigger',
    'Anomaly Trigger', 'Drift Trigger', 'Approval Trigger', 'Rollback Trigger'
  ], 'trigger', ['internal', 'external', 'both'], ['free', 'metered', 'free']),

  ADAPTERS: genFleet('ADP', 20, [
    'REST Adapter', 'gRPC Adapter', 'GraphQL Adapter', 'WebSocket Adapter',
    'MQTT Adapter', 'AMQP Adapter', 'Kafka Adapter', 'Redis Adapter',
    'Postgres Adapter', 'Mongo Adapter', 'S3 Adapter', 'GCS Adapter',
    'SMTP Adapter', 'SMS Adapter', 'Slack Adapter', 'Teams Adapter',
    'Stripe Adapter', 'Twilio Adapter', 'Auth0 Adapter', 'LDAP Adapter'
  ], 'adapter', ['external', 'both'], ['metered', 'licensed']),

  SENSORS: genFleet('SNS', 20, [
    'CPU Sensor', 'Memory Sensor', 'Disk Sensor', 'Network Sensor',
    'Latency Sensor', 'Error Rate Sensor', 'Queue Depth Sensor', 'Connection Sensor',
    'Throughput Sensor', 'Availability Sensor', 'Cost Sensor', 'SLA Sensor',
    'Drift Sensor', 'Anomaly Sensor', 'Security Sensor', 'Compliance Sensor',
    'Usage Sensor', 'Capacity Sensor', 'Health Sensor', 'Custom Sensor'
  ], 'sensor', ['internal'], ['free', 'free', 'metered']),

  SHIELDS: genFleet('SLD', 20, [
    'WAF Shield', 'DDoS Shield', 'Bot Shield', 'Rate Shield',
    'Auth Shield', 'CORS Shield', 'CSRF Shield', 'XSS Shield',
    'SQLi Shield', 'Injection Shield', 'Encryption Shield', 'Token Shield',
    'IP Shield', 'Geo Shield', 'Cert Shield', 'Header Shield',
    'Payload Shield', 'Schema Shield', 'Quota Shield', 'Abuse Shield'
  ], 'shield', ['external', 'both'], ['metered', 'licensed']),
};

const FLEET_SIZE = Object.values(FLEET).reduce((s, arr) => s + arr.length, 0);

/* ═══════════════════════════════════════════════════════════════
   CLIENT TIER REGISTRY
   ═══════════════════════════════════════════════════════════════ */

const CLIENT_TIERS = {
  starter:      { maxClients: 50,   concurrent: 5,   protocols: ['free'],                               callsPerDay: 100 },
  standard:     { maxClients: 200,  concurrent: 20,  protocols: ['free', 'metered'],                    callsPerDay: 1000 },
  professional: { maxClients: 500,  concurrent: 50,  protocols: ['free', 'metered', 'licensed'],        callsPerDay: 10000 },
  enterprise:   { maxClients: 1000, concurrent: 200, protocols: ['free', 'metered', 'licensed', 'sovereign'], callsPerDay: 100000 },
  sovereign:    { maxClients: 1597, concurrent: 500, protocols: ['free', 'metered', 'licensed', 'sovereign'], callsPerDay: Infinity },
};

/* ═══════════════════════════════════════════════════════════════
   PRODUCT REGISTRY
   ═══════════════════════════════════════════════════════════════ */

const PRODUCTS = {
  COMMAND_ENTERPRISE: {
    name: 'Command Enterprise',
    protocols: PROTOCOLS.slice(0, 30).map(p => p.id),
    callClasses: Object.keys(FLEET),
    clientTier: 'enterprise'
  },
  COMMAND_SHIELD: {
    name: 'Command Shield',
    protocols: PROTOCOLS.filter(p => p.family === 'SECURITY & TRUST').map(p => p.id),
    callClasses: ['SHIELDS', 'SENSORS'],
    clientTier: 'professional'
  },
  PROTOCOL_SDK: {
    name: 'Protocol SDK',
    protocols: PROTOCOLS.filter(p => p.family === 'SDK').map(p => p.id),
    callClasses: ['BLUEPRINTS', 'ADAPTERS'],
    clientTier: 'standard'
  },
};

/* ═══════════════════════════════════════════════════════════════
   PROTOCOL EXECUTION ENGINE
   ═══════════════════════════════════════════════════════════════ */

function executeProtocol(protocolId, clientTier, payload) {
  const protocol = PROTOCOLS.find(p => p.id === protocolId);
  if (!protocol) return { error: 'PROTOCOL_NOT_FOUND', protocolId };

  const tierConfig = CLIENT_TIERS[clientTier];
  if (!tierConfig) return { error: 'INVALID_TIER', clientTier };

  // Validate tier access
  if (!tierConfig.protocols.includes(protocol.pricingClass)) {
    return { error: 'TIER_ACCESS_DENIED', protocolId, clientTier, required: protocol.pricingClass };
  }

  if (!protocol.callerTiers.includes(clientTier)) {
    return { error: 'CALLER_TIER_REJECTED', protocolId, clientTier, allowed: protocol.callerTiers };
  }

  // Simulate stepped execution with PHI-scaled latency
  const startMs = performance.now();
  const baseLatency = protocol.steps * PHI;
  const jitter = Math.random() * protocol.steps * 0.5;
  const simulatedLatency = baseLatency + jitter;

  // Dispatch to worker bindings
  const dispatchedTo = protocol.workerBindings[Math.floor(Math.random() * protocol.workerBindings.length)];

  // Update metrics
  protocol.executions++;
  totalExecutions++;
  const elapsed = performance.now() - startMs + simulatedLatency;
  protocol.avgLatencyMs = protocol.avgLatencyMs === 0
    ? elapsed
    : (protocol.avgLatencyMs * (protocol.executions - 1) + elapsed) / protocol.executions;

  return {
    ok: true,
    protocolId: protocol.id,
    protocolName: protocol.name,
    family: protocol.family,
    steps: protocol.steps,
    dispatchedTo,
    latencyMs: Math.round(elapsed * 100) / 100,
    pricingClass: protocol.pricingClass,
    executionCount: protocol.executions,
    payload: payload || null
  };
}

/* ═══════════════════════════════════════════════════════════════
   METRICS
   ═══════════════════════════════════════════════════════════════ */

function gatherMetrics() {
  const byFamily = {};
  const byPricing = { free: 0, metered: 0, licensed: 0, sovereign: 0 };
  let totalLatency = 0;
  let executed = 0;

  for (const p of PROTOCOLS) {
    if (!byFamily[p.family]) byFamily[p.family] = { count: 0, executions: 0 };
    byFamily[p.family].count++;
    byFamily[p.family].executions += p.executions;
    byPricing[p.pricingClass] += p.executions;
    if (p.executions > 0) {
      totalLatency += p.avgLatencyMs * p.executions;
      executed += p.executions;
    }
  }

  return {
    totalProtocols: PROTOCOLS.length,
    totalExecutions,
    avgLatencyMs: executed > 0 ? Math.round((totalLatency / executed) * 100) / 100 : 0,
    byFamily,
    byPricing,
    fleetSize: FLEET_SIZE,
    uptimeMs: Date.now() - BOOT_TIME
  };
}

/* ═══════════════════════════════════════════════════════════════
   MESSAGE HANDLER
   ═══════════════════════════════════════════════════════════════ */

self.onmessage = function (e) {
  const msg = e.data;
  if (!msg || !msg.type) return;

  switch (msg.type) {
    case 'list-protocols':
      self.postMessage({
        type: 'protocols-list',
        protocols: PROTOCOLS.map(p => ({
          id: p.id, name: p.name, family: p.family,
          steps: p.steps, pricingClass: p.pricingClass,
          status: p.status, executions: p.executions
        }))
      });
      break;

    case 'list-fleet':
      self.postMessage({
        type: 'fleet-list',
        fleet: Object.fromEntries(
          Object.entries(FLEET).map(([k, v]) => [k, { count: v.length, items: v }])
        ),
        totalSize: FLEET_SIZE
      });
      break;

    case 'execute': {
      const result = executeProtocol(msg.protocolId, msg.clientTier, msg.payload);
      self.postMessage({ type: 'execute-result', ...result });
      break;
    }

    case 'client-tiers':
      self.postMessage({ type: 'client-tiers-result', tiers: CLIENT_TIERS });
      break;

    case 'products':
      self.postMessage({ type: 'products-result', products: PRODUCTS });
      break;

    case 'protocol-by-family': {
      const family = msg.family;
      const matched = PROTOCOLS.filter(p => p.family === family);
      self.postMessage({ type: 'protocol-by-family-result', family, protocols: matched });
      break;
    }

    case 'fleet-by-class': {
      const cls = msg.class;
      const items = FLEET[cls] || [];
      self.postMessage({ type: 'fleet-by-class-result', class: cls, items, count: items.length });
      break;
    }

    case 'metrics':
      self.postMessage({ type: 'metrics-result', ...gatherMetrics() });
      break;

    case 'status':
      self.postMessage({
        type: 'status-result',
        name: 'PROTOCOLLUM MERCATUS',
        protocols: PROTOCOLS.length,
        families: FAMILIES.length,
        fleetSize: FLEET_SIZE,
        products: Object.keys(PRODUCTS).length,
        tiers: Object.keys(CLIENT_TIERS),
        maxClients: CLIENT_TIERS.sovereign.maxClients,
        uptimeMs: Date.now() - BOOT_TIME,
        beat,
        totalExecutions,
        metrics: gatherMetrics()
      });
      break;

    case 'spec':
      self.postMessage({
        type: 'spec-result',
        version: '1.0.0',
        latin: 'PROTOCOLLUM MERCATUS OPERANS',
        architecture: 'Web Worker — Protocol Execution Substrate',
        protocols: PROTOCOLS.length,
        families: FAMILIES.length,
        fleetCategories: Object.keys(FLEET).length,
        fleetSize: FLEET_SIZE,
        products: Object.keys(PRODUCTS).length,
        tiers: Object.keys(CLIENT_TIERS).length,
        heartbeatMs: HEARTBEAT_MS,
        phi: PHI
      });
      break;

    default:
      self.postMessage({ type: 'error', message: `Unknown message type: ${msg.type}` });
  }
};

/* ═══════════════════════════════════════════════════════════════
   873ms HEARTBEAT
   ═══════════════════════════════════════════════════════════════ */

setInterval(() => {
  beat++;
  const telemetry = {
    type: 'heartbeat',
    beat,
    uptimeMs: Date.now() - BOOT_TIME,
    totalExecutions,
    activeProtocols: PROTOCOLS.filter(p => p.executions > 0).length
  };

  if (beat % METRICS_EVERY === 0) {
    telemetry.metrics = gatherMetrics();
  }

  self.postMessage(telemetry);
}, HEARTBEAT_MS);

/* ═══════════════════════════════════════════════════════════════
   BOOT
   ═══════════════════════════════════════════════════════════════ */

self.postMessage({
  type: 'booted',
  name: 'PROTOCOLLUM MERCATUS',
  protocols: 55,
  fleetSize: FLEET_SIZE,
  families: FAMILIES.length,
  products: Object.keys(PRODUCTS).length,
  maxClients: 1597
});
