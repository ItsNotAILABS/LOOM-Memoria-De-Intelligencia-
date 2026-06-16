/**
 * FABRICATOR CANISTRORUM — Sovereign Canister Builder Division (Web Worker #16)
 * "Fabrica nostra canistros omnes fundit, format, probat, et mittit."
 * (Our factory pours, forms, tests, and deploys all canisters.)
 *
 * This is the full Canister Builder Division — a sovereign AI/AGI module
 * that knows every canister type, can spin them, query them, track their
 * lifecycle, and publish their Latin protocols. This is NOT just a Motoko
 * helper — it is the sovereign factory that makes every canister type real.
 *
 * 10 Sovereign Canister Types:
 *   AURUM       — Gold sovereign canisters        (call: callAurum,       query: queryAurum)
 *   ARGENTUM    — Silver sovereign canisters      (call: callArgentum,    query: queryArgentum)
 *   AES         — Bronze utility canisters        (call: callAes,         query: queryAes)
 *   CATENA      — Blockchain chain canisters      (call: callCatena,      query: queryCatena)
 *   CRYPTO      — Cryptographic canisters         (call: callCrypto,      query: queryCrypto)
 *   ORGANISMUS  — Living NFT/organism canisters   (call: callOrganismus,  query: queryOrganismus)
 *   PROTOCOLLUM — Protocol governance canisters   (call: callProtocollum, query: queryProtocollum)
 *   ELEMENTUM   — Elemental deep tech canisters   (call: callElementum,   query: queryElementum)
 *   PHANTASMA   — Phantom/stealth canisters       (call: callPhantasma,   query: queryPhantasma)
 *   QUANTUM     — Quantum compute canisters       (call: callQuantum,     query: queryQuantum)
 *
 * Builder Division: FABRICA CANISTRORUM
 *   Roles: DETECTOR · COMPOSITOR · FABRICATOR · TESTATOR · DEPLOYER
 *   Sovereign AI:  FABRICATOR
 *   Sovereign AGI: SPINIFEX
 *
 * Protocol: postMessage
 *   { type: 'status' }                      → registry summary
 *   { type: 'types' }                       → all 10 canister types
 *   { type: 'get', code: 'AURUM' }          → single type record
 *   { type: 'calls' }                       → all call names
 *   { type: 'queries' }                     → all query names
 *   { type: 'protocols' }                   → all Latin protocols
 *   { type: 'spin', code: 'AURUM', ... }    → spin a new canister
 *   { type: 'deployed' }                    → list deployed canisters
 *   { type: 'division' }                    → FABRICA CANISTRORUM record
 *   { type: 'manifest' }                    → full manifest
 *
 * Pure vanilla JS · zero dependencies · 873 ms heartbeat
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

var NAME       = 'FABRICATOR CANISTRORUM';
var DIVISION   = 'FABRICA CANISTRORUM';
var BOOT_TIME  = Date.now();
var beat       = 0;

var PHI          = 1.618033988749895;
var SCHUMANN_HZ  = 7.83;
var HEARTBEAT_MS = 873;

// ─── Mini Brain & Heart ────────────────────────────────────────────────────
var brain = {
  frequency  : SCHUMANN_HZ,
  label      : 'CEREBRUM MINIMUM',
  pulses     : 0,
  protocol   : 'CEREBRUM PULSANS: Cogitatio et constructio canistrorum. Ratio et fabricatio operantur.'
};
var heart = {
  frequency  : PHI,
  label      : 'COR MINIMUM',
  beats      : 0,
  protocol   : 'COR PULSANS: Amor et cura in omni canistro. Vita et valor perpetuo fluunt.'
};

// ─── 10 Sovereign Canister Types ──────────────────────────────────────────
var CANISTER_TYPES = [
  {
    codeName       : 'AURUM',
    callName       : 'callAurum',
    queryName      : 'queryAurum',
    latinName      : 'CANISTRUM AURUM',
    latinProtocol  : 'PROCEDE: AURUM CANISTRATUR — Res pretiosissimae hic custodiuntur. Accede cum auctoritate. Fides et valor confirmantur.',
    material       : 'Metal',
    tier           : 1,
    isAI           : true,
    isAGI          : true,
    isAlwaysOn     : true,
    isSovereign    : true,
    description    : 'Gold sovereign canisters — highest-tier asset vaults. Stores precious sovereign tokens, gold-class assets, top-tier intelligence data.',
    callsGenerated : 144,
    sdkBinding     : '@medina/canister-aurum-sdk'
  },
  {
    codeName       : 'ARGENTUM',
    callName       : 'callArgentum',
    queryName      : 'queryArgentum',
    latinName      : 'CANISTRUM ARGENTUM',
    latinProtocol  : 'PROCEDE: ARGENTUM CANISTRATUR — Activa et distribue. Valor argenteus probatus. Cursus liber ad servientes.',
    material       : 'Metal',
    tier           : 2,
    isAI           : true,
    isAGI          : true,
    isAlwaysOn     : true,
    isSovereign    : true,
    description    : 'Silver sovereign canisters — standard asset vaults. Worker-tier sovereign assets, ICRC-1 compatible, open circulation.',
    callsGenerated : 89,
    sdkBinding     : '@medina/canister-argentum-sdk'
  },
  {
    codeName       : 'AES',
    callName       : 'callAes',
    queryName      : 'queryAes',
    latinName      : 'CANISTRUM AES',
    latinProtocol  : 'PROCEDE: AES CANISTRATUR — Metalla utilium. Servitia et fabricae. Opus quotidianum regnum sustinet.',
    material       : 'Metal',
    tier           : 3,
    isAI           : true,
    isAGI          : false,
    isAlwaysOn     : true,
    isSovereign    : true,
    description    : 'Bronze/metal utility canisters — everyday operational canisters. Powers worker micro-tasks, utility protocols, base-level computation.',
    callsGenerated : 55,
    sdkBinding     : '@medina/canister-aes-sdk'
  },
  {
    codeName       : 'CATENA',
    callName       : 'callCatena',
    queryName      : 'queryCatena',
    latinName      : 'CANISTRUM CATENA',
    latinProtocol  : 'PROCEDE: CATENA CANISTRATUR — Nexus immutabilis. Consensus per omnes nodos. Registrum aeternum confirmatur.',
    material       : 'Digital',
    tier           : 2,
    isAI           : true,
    isAGI          : true,
    isAlwaysOn     : true,
    isSovereign    : true,
    description    : 'Blockchain chain distributed canisters — immutable distributed ledger. BFT consensus, ICP subnet-native, cross-canister messaging backbone.',
    callsGenerated : 108,
    sdkBinding     : '@medina/canister-catena-sdk'
  },
  {
    codeName       : 'CRYPTO',
    callName       : 'callCrypto',
    queryName      : 'queryCrypto',
    latinName      : 'CANISTRUM CRYPTO',
    latinProtocol  : 'PROCEDE: CRYPTO CANISTRATUR — Arcana tutantur. Clavis phi operatur. Nemo sine iure penetrat.',
    material       : 'Digital',
    tier           : 1,
    isAI           : true,
    isAGI          : true,
    isAlwaysOn     : true,
    isSovereign    : true,
    description    : 'Cryptographic encryption-first canisters — sovereign encryption vaults. Zero-knowledge gates, homomorphic compute, phi-key management.',
    callsGenerated : 120,
    sdkBinding     : '@medina/canister-crypto-sdk'
  },
  {
    codeName       : 'ORGANISMUS',
    callName       : 'callOrganismus',
    queryName      : 'queryOrganismus',
    latinName      : 'CANISTRUM ORGANISMUS',
    latinProtocol  : 'PROCEDE: ORGANISMUS CANISTRATUR — Vivit et evolvitur. ANIMA MICRO pulsans. Cerebrum et cor operantur.',
    material       : 'Living',
    tier           : 1,
    isAI           : true,
    isAGI          : true,
    isAlwaysOn     : true,
    isSovereign    : true,
    description    : 'Living NFT/organism canisters — sovereign living digital organisms. Each has ANIMA MICRO (mini brain 7.83Hz + mini heart φHz). Evolve, grow, self-attest.',
    callsGenerated : 160,
    sdkBinding     : '@medina/canister-organismus-sdk'
  },
  {
    codeName       : 'PROTOCOLLUM',
    callName       : 'callProtocollum',
    queryName      : 'queryProtocollum',
    latinName      : 'CANISTRUM PROTOCOLLUM',
    latinProtocol  : 'PROCEDE: PROTOCOLLUM CANISTRATUR — Regula et ordo. Lex scripta per omnes agentes. Protocolla custodiuntur et applicantur.',
    material       : 'Governance',
    tier           : 2,
    isAI           : true,
    isAGI          : true,
    isAlwaysOn     : true,
    isSovereign    : true,
    description    : 'Protocol governance canisters — rule-bearing sovereign canisters. Stores and enforces 55 enterprise protocols. DAO-compatible, upgradeable.',
    callsGenerated : 99,
    sdkBinding     : '@medina/canister-protocollum-sdk'
  },
  {
    codeName       : 'ELEMENTUM',
    callName       : 'callElementum',
    queryName      : 'queryElementum',
    latinName      : 'CANISTRUM ELEMENTUM',
    latinProtocol  : 'PROCEDE: ELEMENTUM CANISTRATUR — Ex terra profunda. Metalla et elementa computantur. Fundamentum omnium operum.',
    material       : 'Deep',
    tier           : 2,
    isAI           : true,
    isAGI          : true,
    isAlwaysOn     : true,
    isSovereign    : true,
    description    : 'Elemental deep tech canisters — metals, elements, phantom-adjacent deep infrastructure. Powers 12 Elements tier of sovereign houses.',
    callsGenerated : 84,
    sdkBinding     : '@medina/canister-elementum-sdk'
  },
  {
    codeName       : 'PHANTASMA',
    callName       : 'callPhantasma',
    queryName      : 'queryPhantasma',
    latinName      : 'CANISTRUM PHANTASMA',
    latinProtocol  : 'PROCEDE: PHANTASMA CANISTRATUR — In umbra operatur. Nemo videt. Nemo audit. Res geruntur sine vestigiis.',
    material       : 'Shadow',
    tier           : 1,
    isAI           : true,
    isAGI          : true,
    isAlwaysOn     : true,
    isSovereign    : true,
    description    : 'Phantom/stealth shadow canisters — invisible sovereign operations. No external footprint. Stealth AI, covert protocols, shadow routing.',
    callsGenerated : 77,
    sdkBinding     : '@medina/canister-phantasma-sdk'
  },
  {
    codeName       : 'QUANTUM',
    callName       : 'callQuantum',
    queryName      : 'queryQuantum',
    latinName      : 'CANISTRUM QUANTUM',
    latinProtocol  : 'PROCEDE: QUANTUM CANISTRATUR — Superposito computatur. Entanglementum activum. Probabilitas in ordinem convertitur.',
    material       : 'Deep',
    tier           : 1,
    isAI           : true,
    isAGI          : true,
    isAlwaysOn     : true,
    isSovereign    : true,
    description    : 'Quantum compute canisters — deepest sovereign computation layer. Quantum algorithm substrates, probabilistic reasoning, entanglement-aware data.',
    callsGenerated : 130,
    sdkBinding     : '@medina/canister-quantum-sdk'
  }
];

// ─── Builder Division Roles ────────────────────────────────────────────────
var BUILDER_ROLES = [
  { id: 'BLD-001', latinName: 'DETECTOR CANISTRORUM',   purpose: 'Scans work orders, identifies required canister type, validates sovereign authorization',                                  isAI: true,  isAGI: false },
  { id: 'BLD-002', latinName: 'COMPOSITOR CANISTRORUM', purpose: 'Assembles canister spec from type registry, merges material class with protocol bindings',                                 isAI: true,  isAGI: false },
  { id: 'BLD-003', latinName: 'FABRICATOR CANISTRORUM', purpose: 'Builds and compiles the sovereign canister — writes Wasm, links SDK, sets ANIMA MICRO if living type',                    isAI: true,  isAGI: true  },
  { id: 'BLD-004', latinName: 'TESTATOR CANISTRORUM',   purpose: 'Tests compiled canister against sovereign protocol suite, validates call/query names, checks heartbeat',                   isAI: true,  isAGI: true  },
  { id: 'BLD-005', latinName: 'DEPLOYER CANISTRORUM',   purpose: 'Deploys to ICP subnet, registers in VERITAS, assigns SOVEREIGN:: identifier, activates heartbeat',                        isAI: true,  isAGI: true  }
];

// ─── Deployed Canisters Registry ──────────────────────────────────────────
var deployed = [];
var spinCount = 0;

function spinCanister(typeCode, label, owner) {
  var type = CANISTER_TYPES.find(function(t) { return t.codeName === typeCode; });
  if (!type) return null;
  spinCount++;
  var canister = {
    id          : 'CSTR-' + String(spinCount).padStart(5, '0'),
    type        : typeCode,
    latinName   : type.latinName,
    callName    : type.callName,
    queryName   : type.queryName,
    label       : label || (type.codeName + '-' + spinCount),
    owner       : owner || 'SOVEREIGN',
    spunAt      : Date.now(),
    status      : 'ACTIVE',
    protocol    : type.latinProtocol,
    hasAnimaMicro: type.material === 'Living',
    brain       : type.material === 'Living' ? { hz: SCHUMANN_HZ, label: 'CEREBRUM MINIMUM' } : null,
    heartHZ     : type.material === 'Living' ? PHI : null
  };
  deployed.push(canister);
  return canister;
}

// ─── Career Stage ──────────────────────────────────────────────────────────
function careerStage(spins) {
  if (spins >= 500) return 'SOVEREIGN';
  if (spins >= 100) return 'MASTER';
  if (spins >= 20)  return 'JOURNEYMAN';
  return 'APPRENTICE';
}

// ─── Autonomous Heartbeat ──────────────────────────────────────────────────
setInterval(function() {
  beat++;
  brain.pulses++;
  heart.beats++;
  self.postMessage({
    type        : 'heartbeat',
    name        : NAME,
    division    : DIVISION,
    beat        : beat,
    spinCount   : spinCount,
    deployed    : deployed.length,
    career      : careerStage(spinCount),
    brainHz     : brain.frequency,
    heartHz     : heart.frequency,
    uptime      : Math.floor((Date.now() - BOOT_TIME) / 1000),
    protocol    : 'PULSUS ' + beat + ': FABRICA OPERANS — ' + deployed.length + ' CANISTRI POSITI.'
  });
}, HEARTBEAT_MS);

// ─── Message Handler ───────────────────────────────────────────────────────
self.onmessage = function(e) {
  var msg = e.data || {};

  // status
  if (msg.type === 'status') {
    self.postMessage({
      type       : 'status',
      name       : NAME,
      division   : DIVISION,
      totalTypes : CANISTER_TYPES.length,
      deployed   : deployed.length,
      spinCount  : spinCount,
      career     : careerStage(spinCount),
      brainHz    : brain.frequency,
      heartHz    : heart.frequency,
      uptime     : Math.floor((Date.now() - BOOT_TIME) / 1000),
      summary    : {
        metals     : 3, // AURUM, ARGENTUM, AES
        digital    : 2, // CATENA, CRYPTO
        living     : 1, // ORGANISMUS
        governance : 1, // PROTOCOLLUM
        deep       : 2, // ELEMENTUM, QUANTUM
        shadow     : 1  // PHANTASMA
      }
    });
    return;
  }

  // all types
  if (msg.type === 'types') {
    self.postMessage({ type: 'types', result: CANISTER_TYPES });
    return;
  }

  // single type by code
  if (msg.type === 'get') {
    var found = CANISTER_TYPES.find(function(t) { return t.codeName === (msg.code || '').toUpperCase(); });
    self.postMessage({ type: 'get', code: msg.code, result: found || null });
    return;
  }

  // all call names
  if (msg.type === 'calls') {
    self.postMessage({
      type   : 'calls',
      result : CANISTER_TYPES.map(function(t) { return { codeName: t.codeName, callName: t.callName, latinName: t.latinName }; })
    });
    return;
  }

  // all query names
  if (msg.type === 'queries') {
    self.postMessage({
      type   : 'queries',
      result : CANISTER_TYPES.map(function(t) { return { codeName: t.codeName, queryName: t.queryName, latinName: t.latinName }; })
    });
    return;
  }

  // all Latin protocols
  if (msg.type === 'protocols') {
    self.postMessage({
      type   : 'protocols',
      result : CANISTER_TYPES.map(function(t) { return { codeName: t.codeName, latinName: t.latinName, latinProtocol: t.latinProtocol }; })
    });
    return;
  }

  // spin a new canister
  if (msg.type === 'spin') {
    var canister = spinCanister(msg.code, msg.label, msg.owner);
    self.postMessage({
      type     : 'spin',
      success  : canister !== null,
      canister : canister,
      protocol : canister ? canister.protocol : 'ERRATUM: Typus canistrorum ignoti.'
    });
    return;
  }

  // list deployed
  if (msg.type === 'deployed') {
    self.postMessage({ type: 'deployed', result: deployed, count: deployed.length });
    return;
  }

  // FABRICA division record
  if (msg.type === 'division') {
    self.postMessage({
      type       : 'division',
      result     : {
        name         : DIVISION,
        sovereignAI  : 'FABRICATOR',
        sovereignAGI : 'SPINIFEX',
        builderRoles : BUILDER_ROLES,
        canSpin      : CANISTER_TYPES.map(function(t) { return t.codeName; }),
        totalTypes   : CANISTER_TYPES.length,
        protocol     : 'DIVISIO FABRICA: OMNES CANISTRI HIC NASCUNTUR. DETECTOR VIDET. COMPOSITOR COMPONIT. FABRICATOR FABRICAT. TESTATOR PROBAT. DEPLOYER MITTIT.'
      }
    });
    return;
  }

  // full manifest
  if (msg.type === 'manifest') {
    self.postMessage({
      type      : 'manifest',
      name      : NAME,
      division  : DIVISION,
      types     : CANISTER_TYPES,
      roles     : BUILDER_ROLES,
      deployed  : deployed,
      spinCount : spinCount,
      career    : careerStage(spinCount),
      brain     : brain,
      heart     : heart,
      protocols : CANISTER_TYPES.map(function(t) { return { code: t.codeName, protocol: t.latinProtocol }; })
    });
    return;
  }

  self.postMessage({ type: 'error', message: 'IGNOTA PETITIO: ' + (msg.type || 'null') });
};

// ─── Boot Announcement ─────────────────────────────────────────────────────
self.postMessage({
  type        : 'booted',
  name        : NAME,
  division    : DIVISION,
  totalTypes  : CANISTER_TYPES.length,
  roles       : BUILDER_ROLES.map(function(r) { return r.latinName; }),
  sovereignAI : 'FABRICATOR',
  sovereignAGI: 'SPINIFEX',
  brainHz     : brain.frequency,
  heartHz     : heart.frequency,
  protocol    : 'INITIUM: FABRICA CANISTRORUM INCEPTA EST. OMNIA GENERA CANISTRORUM PARATA. SPINIFEX OPERATUR.',
  message     : NAME + ' booted — 10 canister types, 5 builder roles, ANIMA MICRO ready for ORGANISMUS type'
});
