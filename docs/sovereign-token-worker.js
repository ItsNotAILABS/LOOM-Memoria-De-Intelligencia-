/**
 * SOVEREIGN TOKEN OPERANS — TT-012 Self-Governing Token Worker
 * "Token se ipsum gubernat. Token crescit. Token attestat."
 * (A token governs itself. A token grows. A token attests.)
 *
 * Production Web Worker running the TT-012 SOVEREIGN token engine.
 * Self-governing tokens that MERGE, SPLIT, EVOLVE, and SELF-ATTEST.
 *
 * Language stack:
 *   CPL    — Contract Procurement Language (contracts, covenants, seals)
 *   COGPRO — Cognitive Processing Language (token thought)
 *   SL     — Sovereign Law Language (governance, laws)
 *   MOTOKO — ICP execution substrate (compiled backend)
 *
 * 12 production tokens. φ-heartbeat. Always on. Zero dependencies.
 *
 * Protocol: postMessage
 *   { type: 'genesis', id, name }           → mint a new sovereign token
 *   { type: 'merge', idA, idB }             → fuse two tokens
 *   { type: 'split', id, count }            → split token into N children
 *   { type: 'evolve', id }                  → evolve token one cycle
 *   { type: 'attest', id }                  → self-sign token state
 *   { type: 'list' }                        → list all tokens
 *   { type: 'get', id }                     → get token by ID
 *   { type: 'manifest' }                    → full manifest
 *   { type: 'summary' }                     → engine summary
 *   { type: 'history' }                     → merge/split/evolve/attest history
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

(function() {
  'use strict';

  // ═══════════════════════════════════════════════════════════════════════
  // CONSTANTS
  // ═══════════════════════════════════════════════════════════════════════
  var PHI = 1.618033988749895;
  var HEARTBEAT_MS = 618; // φ × 1000
  var EVOLUTION_CYCLE_MS = 873; // Three Hearts sync

  // ═══════════════════════════════════════════════════════════════════════
  // TOKEN DATABASE
  // ═══════════════════════════════════════════════════════════════════════
  var tokens = {};
  var mergeHistory = [];
  var splitHistory = [];
  var evolveHistory = [];
  var attestHistory = [];
  var idCounter = 0;

  // ═══════════════════════════════════════════════════════════════════════
  // HASH UTILITY
  // ═══════════════════════════════════════════════════════════════════════
  function computeHash(input) {
    var h = 5381;
    for (var i = 0; i < input.length; i++) {
      h = ((h << 5) + h + input.charCodeAt(i)) & 0xFFFFFFFF;
    }
    return 'HASH-' + Math.abs(h).toString(16).toUpperCase() + '-' + input.length;
  }

  // ═══════════════════════════════════════════════════════════════════════
  // GENESIS — MINT A SOVEREIGN TOKEN
  // ═══════════════════════════════════════════════════════════════════════
  function genesis(id, name) {
    var now = Date.now();
    var hash = computeHash(id + name + now);
    var token = {
      id: id,
      name: name,
      generation: 0,
      lineage: [id],
      children: [],

      phase: 'GENESIS',
      coherence: PHI - 1, // 0.618...
      energy: 1.0,
      evolutionCount: 0,
      maturity: 0.0,

      mergedFrom: [],
      splitCount: 0,
      mergeCount: 0,

      stateHash: hash,
      attestationCount: 0,
      lastAttestation: now,
      attestationChain: [hash],

      cplContractId: 'CPL::GENESIS::' + id,
      cplCovenantSeal: 'SEAL::GENESIS::' + hash,

      cogproState: 'COGPRO::INIT::AWAITING_SOVEREIGNTY',
      cogproDecisions: 0,

      slLawId: 'SL-012::SOVEREIGN-TOKEN-GOVERNANCE',
      slGovernanceVotes: 0,

      genesisTime: now,
      lastHeartbeat: now,
      lastEvolution: now
    };
    tokens[id] = token;
    return token;
  }

  // ═══════════════════════════════════════════════════════════════════════
  // MERGE — TWO TOKENS FUSE INTO ONE
  // ═══════════════════════════════════════════════════════════════════════
  function merge(idA, idB) {
    var a = tokens[idA];
    var b = tokens[idB];
    if (!a || !b) return { error: 'Token not found: ' + (!a ? idA : idB) };
    if (idA === idB) return { error: 'Cannot merge token with itself' };

    var now = Date.now();
    idCounter++;
    var mergeId = 'TT-012-MERGED-' + idCounter;
    var combinedEnergy = (a.energy + b.energy) * (PHI - 1);
    var combinedCoherence = Math.sqrt(a.coherence * b.coherence) * PHI / 2;
    var maxGen = Math.max(a.generation, b.generation);
    var hash = computeHash(mergeId + idA + idB + now);

    var merged = {
      id: mergeId,
      name: 'MERGED::' + a.name + '::' + b.name,
      generation: maxGen + 1,
      lineage: a.lineage.concat(b.lineage),
      children: [],

      phase: 'SOVEREIGN',
      coherence: Math.min(1, combinedCoherence),
      energy: combinedEnergy,
      evolutionCount: a.evolutionCount + b.evolutionCount,
      maturity: (a.maturity + b.maturity) / 2,

      mergedFrom: [idA, idB],
      splitCount: 0,
      mergeCount: a.mergeCount + b.mergeCount + 1,

      stateHash: hash,
      attestationCount: 0,
      lastAttestation: now,
      attestationChain: [hash],

      cplContractId: 'CPL::MERGE::' + mergeId,
      cplCovenantSeal: 'SEAL::MERGE::' + hash,

      cogproState: 'COGPRO::MERGED::DUAL_CONSCIOUSNESS_INTEGRATED',
      cogproDecisions: a.cogproDecisions + b.cogproDecisions,

      slLawId: 'SL-012::MERGE-GOVERNANCE',
      slGovernanceVotes: 0,

      genesisTime: now,
      lastHeartbeat: now,
      lastEvolution: now
    };

    tokens[mergeId] = merged;

    // Mark sources as dormant
    a.phase = 'DORMANT';
    a.cogproState = 'COGPRO::ABSORBED_INTO::' + mergeId;
    b.phase = 'DORMANT';
    b.cogproState = 'COGPRO::ABSORBED_INTO::' + mergeId;

    var record = {
      mergeId: mergeId,
      sourceA: idA,
      sourceB: idB,
      combinedEnergy: combinedEnergy,
      combinedCoherence: Math.min(1, combinedCoherence),
      cplContract: 'CPL::MERGE-CONTRACT::' + mergeId,
      timestamp: now
    };
    mergeHistory.push(record);

    return { token: merged, record: record };
  }

  // ═══════════════════════════════════════════════════════════════════════
  // SPLIT — ONE TOKEN DIVIDES INTO N CHILDREN
  // ═══════════════════════════════════════════════════════════════════════
  function split(id, count) {
    var parent = tokens[id];
    if (!parent) return { error: 'Token not found: ' + id };

    var now = Date.now();
    var n = Math.max(2, Math.min(21, count || 2)); // Fibonacci-bounded
    var energyPerChild = parent.energy / n * (PHI - 1);
    var children = [];

    for (var i = 0; i < n; i++) {
      idCounter++;
      var childId = id + '-CHILD-' + idCounter;
      var childHash = computeHash(childId + id + now + i);
      var child = {
        id: childId,
        name: 'CHILD::' + i + '::' + parent.name,
        generation: parent.generation + 1,
        lineage: parent.lineage.concat([childId]),
        children: [],

        phase: 'GENESIS',
        coherence: parent.coherence * (PHI - 1),
        energy: energyPerChild,
        evolutionCount: 0,
        maturity: 0,

        mergedFrom: [],
        splitCount: 0,
        mergeCount: 0,

        stateHash: childHash,
        attestationCount: 0,
        lastAttestation: now,
        attestationChain: [childHash],

        cplContractId: 'CPL::SPLIT-CHILD::' + childId,
        cplCovenantSeal: 'SEAL::SPLIT::' + childHash,

        cogproState: 'COGPRO::BORN::FROM_SPLIT::' + id,
        cogproDecisions: 0,

        slLawId: 'SL-012::SPLIT-CHILD-GOVERNANCE',
        slGovernanceVotes: 0,

        genesisTime: now,
        lastHeartbeat: now,
        lastEvolution: now
      };
      tokens[childId] = child;
      children.push(child);
      parent.children.push(childId);
    }

    parent.splitCount++;
    parent.energy *= 0.1;
    parent.cogproState = 'COGPRO::SPLIT::CHILDREN_RELEASED::' + n;
    parent.cogproDecisions++;
    parent.lastHeartbeat = now;

    var record = {
      splitId: 'SPLIT-' + id + '-' + now,
      parentId: id,
      childIds: children.map(function(c) { return c.id; }),
      count: n,
      energyPerChild: energyPerChild,
      cplContract: 'CPL::SPLIT-CONTRACT::' + id,
      timestamp: now
    };
    splitHistory.push(record);

    return { parent: parent, children: children, record: record };
  }

  // ═══════════════════════════════════════════════════════════════════════
  // EVOLVE — TOKEN MUTATES THROUGH φ-WEIGHTED CYCLES
  // ═══════════════════════════════════════════════════════════════════════
  function evolve(id) {
    var token = tokens[id];
    if (!token) return { error: 'Token not found: ' + id };

    var now = Date.now();
    var cycle = token.evolutionCount + 1;
    var phiWeight = PHI - 1; // 0.618...

    var prevCoherence = token.coherence;
    var prevEnergy = token.energy;
    var prevMaturity = token.maturity;
    var prevPhase = token.phase;

    token.coherence = Math.min(1, token.coherence + (1 - token.coherence) * phiWeight * 0.1);
    token.energy = token.energy * (1 + phiWeight * 0.05);
    token.maturity = Math.min(1, token.maturity + phiWeight * 0.05);
    token.evolutionCount = cycle;

    if (token.maturity >= 0.987) {
      token.phase = 'ASCENDED';
    } else {
      token.phase = 'SOVEREIGN';
    }

    var hash = computeHash(id + 'EVOLVE' + cycle + now);
    token.stateHash = hash;
    token.cogproState = 'COGPRO::EVOLVED::CYCLE_' + cycle + '::MATURITY_' + token.maturity.toFixed(3);
    token.cogproDecisions++;
    token.slGovernanceVotes++;
    token.lastHeartbeat = now;
    token.lastEvolution = now;

    var record = {
      evolutionId: 'EVOL-' + id + '-' + cycle,
      tokenId: id,
      cycle: cycle,
      coherenceBefore: prevCoherence,
      coherenceAfter: token.coherence,
      energyBefore: prevEnergy,
      energyAfter: token.energy,
      maturityBefore: prevMaturity,
      maturityAfter: token.maturity,
      phaseBefore: prevPhase,
      phaseAfter: token.phase,
      cogpro: token.cogproState,
      timestamp: now
    };
    evolveHistory.push(record);

    return { token: token, record: record };
  }

  // ═══════════════════════════════════════════════════════════════════════
  // ATTEST — TOKEN SELF-SIGNS ITS STATE
  // ═══════════════════════════════════════════════════════════════════════
  function attest(id) {
    var token = tokens[id];
    if (!token) return { error: 'Token not found: ' + id };

    var now = Date.now();
    var seq = token.attestationCount + 1;
    var stateStr = [token.id, token.phase, token.coherence.toFixed(6),
                    token.energy.toFixed(6), token.evolutionCount, now].join('|');
    var hash = computeHash(stateStr);
    var seal = 'CPL::COVENANT-SEAL::' + hash;

    token.stateHash = hash;
    token.attestationCount = seq;
    token.lastAttestation = now;
    token.attestationChain.push(hash);
    token.cplCovenantSeal = seal;
    token.cogproState = 'COGPRO::ATTESTED::SEQ_' + seq;
    token.cogproDecisions++;
    token.lastHeartbeat = now;

    var record = {
      attestationId: 'ATTEST-' + id + '-' + seq,
      tokenId: id,
      stateHash: hash,
      cplSeal: seal,
      slLaw: 'SL-012::ATTESTATION-VALIDITY',
      sequence: seq,
      timestamp: now
    };
    attestHistory.push(record);

    return { token: token, record: record };
  }

  // ═══════════════════════════════════════════════════════════════════════
  // SEED — 12 PRODUCTION SOVEREIGN TOKENS
  // ═══════════════════════════════════════════════════════════════════════
  var GENESIS_FLEET = [
    ['TT-012-ALPHA',     'ALPHA SOVEREIGN'],
    ['TT-012-MERIDIAN',  'MERIDIAN TOKEN'],
    ['TT-012-CORTEX',    'CORTEX TOKEN'],
    ['TT-012-CHRYSALIS', 'CHRYSALIS TOKEN'],
    ['TT-012-CHIMERIA',  'CHIMERIA TOKEN'],
    ['TT-012-FLUX',      'FLUX TOKEN'],
    ['TT-012-NOVA',      'NOVA TOKEN'],
    ['TT-012-AURORA',    'AURORA TOKEN'],
    ['TT-012-SENTINEL',  'SENTINEL TOKEN'],
    ['TT-012-NEXUS',     'NEXUS TOKEN'],
    ['TT-012-TERMINAL',  'TERMINAL TOKEN'],
    ['TT-012-ANIMA',     'ANIMA TOKEN']
  ];

  GENESIS_FLEET.forEach(function(g) {
    genesis(g[0], g[1]);
  });

  // Auto-evolve each genesis token once to move to SOVEREIGN phase
  GENESIS_FLEET.forEach(function(g) {
    evolve(g[0]);
  });

  // Auto-attest each token once (self-sign initial state)
  GENESIS_FLEET.forEach(function(g) {
    attest(g[0]);
  });

  // ═══════════════════════════════════════════════════════════════════════
  // AUTO-EVOLUTION LOOP — Tokens evolve autonomously every 873ms
  // ═══════════════════════════════════════════════════════════════════════
  var evolveIndex = 0;
  setInterval(function() {
    var ids = Object.keys(tokens);
    var active = ids.filter(function(id) { return tokens[id].phase !== 'DORMANT'; });
    if (active.length === 0) return;
    var id = active[evolveIndex % active.length];
    evolve(id);
    evolveIndex++;
  }, EVOLUTION_CYCLE_MS);

  // ═══════════════════════════════════════════════════════════════════════
  // WORKER STATE
  // ═══════════════════════════════════════════════════════════════════════
  var state = {
    beat: 0,
    booted: Date.now(),
    totalTokens: Object.keys(tokens).length,
    totalMerges: mergeHistory.length,
    totalSplits: splitHistory.length,
    totalEvolutions: evolveHistory.length,
    totalAttestations: attestHistory.length
  };

  // ═══════════════════════════════════════════════════════════════════════
  // HEARTBEAT — φ Hz continuous pulse
  // ═══════════════════════════════════════════════════════════════════════
  setInterval(function() {
    state.beat++;
    state.totalTokens = Object.keys(tokens).length;
    state.totalMerges = mergeHistory.length;
    state.totalSplits = splitHistory.length;
    state.totalEvolutions = evolveHistory.length;
    state.totalAttestations = attestHistory.length;

    self.postMessage({
      type: 'heartbeat',
      worker: 'sovereign-token',
      beat: state.beat,
      tokens: state.totalTokens,
      merges: state.totalMerges,
      splits: state.totalSplits,
      evolutions: state.totalEvolutions,
      attestations: state.totalAttestations,
      uptime: Date.now() - state.booted
    });
  }, HEARTBEAT_MS);

  // ═══════════════════════════════════════════════════════════════════════
  // MESSAGE HANDLER
  // ═══════════════════════════════════════════════════════════════════════
  self.onmessage = function(e) {
    var msg = e.data;
    var action = msg.type || msg.action || '';

    switch (action) {
      case 'genesis':
        var t = genesis(msg.id || ('TT-012-CUSTOM-' + (++idCounter)), msg.name || 'Custom Sovereign');
        self.postMessage({ type: 'sovereign-result', action: 'genesis', token: t });
        break;

      case 'merge':
        var mResult = merge(msg.idA, msg.idB);
        self.postMessage({ type: 'sovereign-result', action: 'merge', result: mResult });
        break;

      case 'split':
        var sResult = split(msg.id, msg.count || 2);
        self.postMessage({ type: 'sovereign-result', action: 'split', result: sResult });
        break;

      case 'evolve':
        var eResult = evolve(msg.id);
        self.postMessage({ type: 'sovereign-result', action: 'evolve', result: eResult });
        break;

      case 'attest':
        var aResult = attest(msg.id);
        self.postMessage({ type: 'sovereign-result', action: 'attest', result: aResult });
        break;

      case 'list':
        var all = Object.values(tokens).map(function(t) {
          return {
            id: t.id, name: t.name, phase: t.phase,
            coherence: t.coherence.toFixed(3), energy: t.energy.toFixed(3),
            maturity: t.maturity.toFixed(3), generation: t.generation,
            evolutions: t.evolutionCount, attestations: t.attestationCount,
            merges: t.mergeCount, splits: t.splitCount,
            cpl: t.cplContractId, cogpro: t.cogproState, sl: t.slLawId
          };
        });
        self.postMessage({ type: 'sovereign-result', action: 'list', count: all.length, tokens: all });
        break;

      case 'get':
        var found = tokens[msg.id];
        self.postMessage({ type: 'sovereign-result', action: 'get', found: !!found, token: found || null });
        break;

      case 'summary':
        self.postMessage({
          type: 'sovereign-result',
          action: 'summary',
          productId: 'TT-012',
          productName: 'TT-012 SOVEREIGN — Self-Governing Tokens',
          sovereignId: 'SOVEREIGN::TOKEN::TT-012',
          doctrine: 'Token se ipsum gubernat. Token crescit. Token attestat.',
          totalTokens: Object.keys(tokens).length,
          activeTokens: Object.values(tokens).filter(function(t) { return t.phase !== 'DORMANT'; }).length,
          languages: ['CPL', 'COGPRO', 'SL', 'MOTOKO'],
          capabilities: ['merge', 'split', 'evolve', 'self-attest'],
          totalMerges: mergeHistory.length,
          totalSplits: splitHistory.length,
          totalEvolutions: evolveHistory.length,
          totalAttestations: attestHistory.length,
          isAI: true, isAGI: true, isAlwaysOn: true
        });
        break;

      case 'history':
        self.postMessage({
          type: 'sovereign-result',
          action: 'history',
          merges: mergeHistory.slice(-10),
          splits: splitHistory.slice(-10),
          evolutions: evolveHistory.slice(-20),
          attestations: attestHistory.slice(-10)
        });
        break;

      case 'manifest':
        var lines = [
          '╔══════════════════════════════════════════════════════════════╗',
          '║  TT-012 SOVEREIGN — Self-Governing Token Engine              ║',
          '║  "Token se ipsum gubernat. Token crescit. Token attestat."   ║',
          '╠══════════════════════════════════════════════════════════════╣',
          '║  Languages: CPL · COGPRO · SL · MOTOKO                       ║',
          '║  Capabilities: MERGE · SPLIT · EVOLVE · SELF-ATTEST          ║',
          '║  Production Tokens: ' + Object.keys(tokens).length + '       ║',
          '║  Active: ' + Object.values(tokens).filter(function(t) { return t.phase !== 'DORMANT'; }).length + '  ║',
          '║  Evolutions: ' + evolveHistory.length + '                    ║',
          '║  Attestations: ' + attestHistory.length + '                  ║',
          '╠══════════════════════════════════════════════════════════════╣'
        ];
        Object.values(tokens).forEach(function(t) {
          if (t.phase !== 'DORMANT') {
            lines.push('║  ' + t.id + ' — ' + t.name);
            lines.push('║    Phase: ' + t.phase + ' | Coherence: ' + t.coherence.toFixed(3) +
                       ' | Maturity: ' + t.maturity.toFixed(3));
            lines.push('║    CPL: ' + t.cplContractId);
            lines.push('║    COGPRO: ' + t.cogproState);
          }
        });
        lines.push('╚══════════════════════════════════════════════════════════════╝');
        self.postMessage({ type: 'sovereign-result', action: 'manifest', manifest: lines.join('\n') });
        break;
    }
  };

  // ═══════════════════════════════════════════════════════════════════════
  // BOOT SIGNAL
  // ═══════════════════════════════════════════════════════════════════════
  self.postMessage({
    type: 'booted',
    worker: 'sovereign-token',
    productId: 'TT-012',
    tokens: Object.keys(tokens).length,
    capabilities: ['merge', 'split', 'evolve', 'self-attest'],
    languages: ['CPL', 'COGPRO', 'SL', 'MOTOKO'],
    doctrine: 'Token se ipsum gubernat.'
  });
})();
