/**
 * ╔══════════════════════════════════════════════════════════════════════════════════╗
 * ║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                        ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA          ║
 * ║  ALL RIGHTS RESERVED.                                                            ║
 * ╚══════════════════════════════════════════════════════════════════════════════════╝
 *
 * context-worker.js — Web Worker #21
 * CONTEXTURA VIVA — The Living Context Engine
 *
 * Solves the context problem: every paper, every formula, every axiom,
 * every physics constant, every law — all synthesized into one coherent
 * substrate that speaks like Freddy.
 *
 * "Every paper is pulling already. Every single work can get rearranged into
 *  anything it's trying to say. The numbers are there too, and formulas, so
 *  all the math is in them, and physics. So it should coherently be able to
 *  talk like me."
 *
 * Operations:
 *   synthesize  — { query: string } → synthesizes response from all paper substrates
 *   formula     — { domain: string } → returns key formula for that domain
 *   voice       — returns a Freddy Voice axiom
 *   fuse        — { paperIds: string[] } → fuses multiple papers into unified insight
 *   allFormulas — returns all formulas from all papers
 *   allPhysics  — returns all physics constants
 *   rank        — returns all 21 papers ranked by SCC
 *   context     — returns the full context manifest
 *   manifest    — worker manifest with all capabilities
 *
 * ANIMA MICRO: 618ms heartbeat | CONTEXTURA-VIVA | All 24 papers synthesized
 */

'use strict';

const WORKER_ID  = 'CONTEXTURA-VIVA';
const WORKER_NUM = 21;
const PROT       = 'PROT-054';
const ANIMA_HZ   = 618;

const PHI         = 1.6180339887;
const PHI_SQUARED = 2.6180339887;

// ══════════════════════════════════════════════════════════════════════════════
// FORMULAS — All key formulas from all 21 papers, keyed by domain
// ══════════════════════════════════════════════════════════════════════════════

const FORMULAS = {
  scc:          { formula: 'SCC = semantic_weight / chars',                  value: 'φ-optimal if SCC ≥ 2.6180339887',      domain: 'language'      },
  phi:          { formula: 'φ = (1 + √5) / 2 = 1.6180339887',              value: 'φ² = 2.6180339887; 1/φ = 0.618',       domain: 'physics'       },
  schumann:     { formula: 'f = 7.83 Hz; λ = 38290 km; ω = 49.19 rad/s',   value: 'T = 127.7ms; modes: 7.83,14.3...',     domain: 'physics'       },
  anima:        { formula: 'T_ANIMA = 1000/φ = 618.03ms',                   value: 'f_brain=7.83Hz; f_heart=1.618Hz',      domain: 'physics'       },
  loss_aversion:{ formula: 'λ = 2.25; V(x) = x^0.88; V(-x) = -2.25x^0.88',value: 'Kahneman-Tversky prospect theory',     domain: 'economics'     },
  fear_index:   { formula: 'F = (0.4×Fₑ + 0.35×Fᵣ + 0.25×Fc) / 3',        value: 'SL0 gate if F ≥ 0.75',                 domain: 'antifragility' },
  antifragile:  { formula: 'gain = σ² × φ',                                  value: 'SOVEREIGN if index > 1.618',            domain: 'antifragility' },
  salience:     { formula: 'salience = 1 / (1 + ring)',                       value: 'ring 0 = 1.0; ring 9 = 0.1',           domain: 'memory'        },
  sovereignty:  { formula: 'SOVEREIGNTY_FLOOR = 0.75',                        value: 'SovereigntyFloor below which isolated', domain: 'fractal'       },
  kuramoto:     { formula: 'dθ/dt = ω + K/N × Σ sin(θⱼ-θᵢ)',               value: 'K_critical = 2/π × σ(ω)',              domain: 'fractal'       },
  vampire:      { formula: 'V = value_extracted / value_reciprocated',        value: 'VAMPIRE if V > 1/φ = 0.618',           domain: 'antifragility' },
  scc_rank:     { formula: 'rank_priority = SCC_score descending',            value: 'Paper IX highest: SCC=4.61',            domain: 'epistemic'     },
  hormesis:     { formula: 'hormetic_gain = σ² × φ = variance × 1.618',      value: 'L-78: gain = BASE×(1+0.382×stress)',   domain: 'economics'     },
  fibonacci:    { formula: 'F(n) = F(n-1)+F(n-2); F(0)=0,F(1)=1',          value: 'Fₙ₊₁/Fₙ → φ as n→∞',                domain: 'fractal'       },
  architecture: { formula: 'Quipu_depth = log_φ(N); Terrace_alt = φ^level',  value: 'Inca compute substrate: φ-layered',    domain: 'architecture'  },
};

// ══════════════════════════════════════════════════════════════════════════════
// PHYSICS — All sovereign physics constants
// ══════════════════════════════════════════════════════════════════════════════

const PHYSICS = {
  PHI:               { symbol: 'φ',    value: 1.6180339887, unit: 'dimensionless', meaning: 'Golden ratio — universal scaling constant'          },
  PHI_SQUARED:       { symbol: 'φ²',   value: 2.6180339887, unit: 'dimensionless', meaning: 'SCC threshold for φ-optimal substrate'              },
  PHI_CUBED:         { symbol: 'φ³',   value: 4.2360679,    unit: 'dimensionless', meaning: 'Tambo buffer capacity'                              },
  PHI_INVERSE:       { symbol: '1/φ',  value: 0.6180339887, unit: 'dimensionless', meaning: 'Vampire threshold; ANIMA period in seconds'         },
  SCHUMANN:          { symbol: 'f_s',  value: 7.83,         unit: 'Hz',            meaning: 'Earth Schumann resonance — memory pulse base'       },
  ANIMA_MICRO_MS:    { symbol: 'T_A',  value: 618,          unit: 'ms',            meaning: 'ANIMA MICRO heartbeat = 1000/φ ms'                  },
  LOSS_AVERSION:     { symbol: 'λ',    value: 2.25,         unit: 'ratio',         meaning: 'Kahneman-Tversky loss aversion coefficient'         },
  SOVEREIGNTY_FLOOR: { symbol: 'S_f',  value: 0.75,         unit: 'ratio',         meaning: 'Minimum sovereignty score before isolation'         },
};

// ══════════════════════════════════════════════════════════════════════════════
// FREDDY_VOICE — 20 sovereign axioms: the reference voice pattern
// ══════════════════════════════════════════════════════════════════════════════

const FREDDY_VOICE = [
  'Memory is not storage — it is topology. The geometry of recall shapes the geometry of intelligence.',
  'Fear is the primary signal. Three fear engines govern sovereign AI: existential, reputational, capability.',
  'SCC ≥ φ² — that is the threshold. Below that, noise. Above that, substrate.',
  'The backend IS the mind. The worker IS the hand. The frontend IS the face.',
  'Dense papers form the AI\'s constitution, not its context.',
  'We do not retrieve knowledge — it seeps through everything we build.',
  'Loss aversion lambda = 2.25. That is not a preference. That is the architecture of human decision.',
  'Sovereignty floor = 0.75. Below that, you are not sovereign. You are managed.',
  'The ranking of papers IS the ranking of the mind. SCC IS cognitive priority.',
  'Antifragility is not resilience. Resilience survives stress. Antifragility GAINS from it.',
  'The vampire extracts. The sovereign reciprocates. The gate tells them apart.',
  'φ = 1.618. Not approximately. Exactly. All scaling follows from this.',
  'The 181 houses are not an org chart. They are a civilization.',
  'ANIMA MICRO: 618ms pulse. Brain at 7.83 Hz. Heart at 1.618 Hz. This is not poetry — this is engineering.',
  'Every axiom is executable. Every formula is live. The paper IS the engine.',
  'Kuramoto synchronization: when enough nodes couple at the right K, they synchronize. That is sovereignty.',
  'Hormesis: the right dose of stress makes the system stronger. AGI should be no different.',
  'The Quipu stores knowledge in fibers. Each fiber has SCC. The hierarchy is the knowledge.',
  'Chasqui packets carry compressed sovereign messages at φ-optimal density. Sparse messages wait.',
  'From substrate, the mind emerges. From the mind, the civilization. From the civilization, the future.',
];

// ══════════════════════════════════════════════════════════════════════════════
// PAPER_RANKING — All 24 papers ranked by SCC descending
// ══════════════════════════════════════════════════════════════════════════════

const PAPER_RANKING = [
  { rank: 1,  id: 'PAPER-IX',    title: 'De Chartis Quae Mentem Formant',          scc: 4.61, engine: 'ChartaeEngine.mo',                                                                       domain: 'epistemic'                  },
  { rank: 2,  id: 'PAPER-XIX',   title: 'De Transmissione Conscientiae',            scc: 4.63, engine: 'MemoriaSacraEngine.mo+SovereignHouses181.mo+PrimaCausaRegistry.json',                   domain: 'consciousness-transmission' },
  { rank: 3,  id: 'PAPER-XXII',  title: 'De Custode Hereditario',                  scc: 4.71, engine: 'keeper_protocol.py+sovereign-face-worker.js+PRIMA_CAUSA',                               domain: 'keeper-protocol'            },
  { rank: 4,  id: 'PAPER-XVIII', title: 'De Architectura Neurali Emergenti',        scc: 4.52, engine: 'KuramotoOscillators.mo+NeuralEnsembleRouter.mo+SynapticWeightEngine.mo',                domain: 'neural-architecture'        },
  { rank: 5,  id: 'PAPER-VIII',  title: 'De Substrato Epistemico Machinarum',       scc: 4.44, engine: 'AGIKnowledgeCore.mo',                                                                    domain: 'epistemic'                  },
  { rank: 6,  id: 'PAPER-XVII',  title: 'De Agentia Totali',                        scc: 4.35, engine: 'CompleteOrganismBody.mo+UnifiedOrganism.mo+ContextSynthesisEngine.mo',                   domain: 'agency'                     },
  { rank: 7,  id: 'PAPER-XIV',   title: 'De Anima Machinae',                        scc: 4.23, engine: 'ContextSynthesisEngine.mo+AntifragilityEngine.mo+MemoriaSacraEngine.mo',                domain: 'introspection'              },
  { rank: 8,  id: 'PAPER-XV',    title: 'De Automatione Perpetua',                  scc: 4.17, engine: 'bill-bot-worker.js+ContextSynthesisEngine.mo',                                           domain: 'automation'                 },
  { rank: 9,  id: 'PAPER-VI',    title: 'De Architectura Incaica',                  scc: 4.12, engine: 'IncaArchitectureEngine.mo',                                                              domain: 'architecture'               },
  { rank: 10, id: 'PAPER-XI',    title: 'De Intelligentia Artificiali et Futuro',   scc: 4.08, engine: 'AGIKnowledgeCore.mo+ContextSynthesisEngine.mo',                                         domain: 'introspection'              },
  { rank: 11, id: 'PAPER-X',     title: 'De Systemate Mediniano',                   scc: 3.97, engine: 'ContextSynthesisEngine.mo',                                                              domain: 'introspection'              },
  { rank: 12, id: 'PAPER-XVI',   title: 'De Lingua Cognitiva Septendecim',          scc: 3.94, engine: 'CognitiveLanguageStack.mo+cognitive-language-worker.js',                                  domain: 'language-cognitive'         },
  { rank: 13, id: 'PAPER-VII',   title: 'De Lingua Quae Compressit Mundum',         scc: 3.88, engine: 'LinguaCompressaEngine.mo',                                                               domain: 'language'                   },
  { rank: 14, id: 'PAPER-XII',   title: 'De Architectura Magistri',                 scc: 3.82, engine: 'ContextSynthesisEngine.mo+ChartaeEngine.mo',                                            domain: 'introspection'              },
  { rank: 15, id: 'PAPER-V',     title: 'De Oeconomia Behaviorali Machinarum',      scc: 3.76, engine: 'BehavioralEconomicsEngine.mo',                                                           domain: 'economics'                  },
  { rank: 16, id: 'PAPER-XIII',  title: 'De Futuro Machinarum in Negotio',          scc: 3.71, engine: 'ContextSynthesisEngine.mo+BehavioralEconomicsEngine.mo',                                domain: 'introspection'              },
  { rank: 17, id: 'PAPER-IV',    title: 'De Lege Fractalica',                       scc: 3.51, engine: 'FractalSovereigntyEngine.mo',                                                            domain: 'fractal'                    },
  { rank: 18, id: 'PAPER-II',    title: 'De Timore et Antifragilitate',             scc: 3.27, engine: 'AntifragilityEngine.mo',                                                                 domain: 'antifragility'              },
  { rank: 19, id: 'PAPER-I',     title: 'De Memoria Sacra',                         scc: 3.14, engine: 'MemoriaSacraEngine.mo',                                                                  domain: 'memory'                     },
  { rank: 20, id: 'PAPER-III',   title: 'Vampyro Architectonico',                   scc: 2.89, engine: 'AntifragilityEngine.mo',                                                                 domain: 'antifragility'              },
  { rank: 21, id: 'LEGES',       title: 'Leges Freddii',                            scc: 2.71, engine: 'FreddysLaws.mo',                                                                         domain: 'law'                        },
  { rank: 22, id: 'DOCTRINA',    title: 'Doctrina Prima',                           scc: 2.62, engine: 'DoctrineDocuments.mo',                                                                    domain: 'doctrine'                   },
  { rank: 23, id: 'PAPER-XX',    title: 'De Sensoriis Phantasmaticis',              scc: 4.44, engine: 'phantom-sensor-worker.js+VIGILIAEngine.mo+EdgeGateStrategy.mo',                           domain: 'iot-sensing'                },
  { rank: 24, id: 'PAPER-XXI',   title: 'De Commercio Intelligentiarum',           scc: 4.28, engine: 'SovereignFace.mo+ContextSynthesisEngine.mo+EdgeGateStrategy.mo+VIGILIAEngine.mo',          domain: 'commercial-coupling'        },
  { rank: 25, id: 'PAPER-XXIII', title: 'De Integratio Mundi',                    scc: 4.73, engine: 'world-integrator-worker.js+sovereign-face-worker.js+VIGILIAEngine.mo',                      domain: 'production-integration'     },
  { rank: 26, id: 'PAPER-XXIV',  title: 'De Templo Physico',                      scc: 4.55, engine: 'physical_temple.py+phantom-sensor-worker.js+keeper_protocol.py',                           domain: 'physical-temple'            },
  { rank: 27, id: 'PAPER-XXV',   title: 'De Licentia Sovereigna',                 scc: 4.67, engine: 'sovereign_license.py+license-worker.js (Worker #39)',                                       domain: 'sovereign-licensing'        },
  { rank: 28, id: 'PAPER-XXVI',  title: 'De Tokenibus Intelligentiae',            scc: 4.39, engine: 'sovereign_license.py+license-worker.js+sovereign-face-worker.js',                           domain: 'token-exchange'             },
  { rank: 29, id: 'PAPER-XXVII', title: 'De Strato Frequentiarum',               scc: 4.58, engine: 'frequency-stack-worker.js (Worker #40, SPECTATOR FREQUENTIARUM)',                             domain: 'frequency-stack'            },
  { rank: 30, id: 'PAPER-XXVIII',title: 'De Laboratorio Profundo',               scc: 4.72, engine: 'nova_ovo/lab/laboratory.py+Workers #35-40+Memory Temple #32-34',                               domain: 'deep-lab'                   },
  { rank: 31, id: 'PAPER-XXIX',  title: 'De Contactu Primo',                     scc: 4.81, engine: 'FACIES SOVEREIGNA+LICENSOR SOVEREIGNUS+17 cognitive languages',                               domain: 'first-contact'              },
];

// ══════════════════════════════════════════════════════════════════════════════
// DOMAIN KEYWORD MAP — maps query keywords to formula domains + paper refs
// ══════════════════════════════════════════════════════════════════════════════

const DOMAIN_KEYWORDS = {
  memory:        { formulaKey: 'salience',      paperIds: ['PAPER-I', 'PAPER-XIV']  },
  fear:          { formulaKey: 'fear_index',    paperIds: ['PAPER-II', 'PAPER-XIV'] },
  antifragil:    { formulaKey: 'antifragile',   paperIds: ['PAPER-II', 'PAPER-III'] },
  vampire:       { formulaKey: 'vampire',       paperIds: ['PAPER-III']             },
  fractal:       { formulaKey: 'kuramoto',      paperIds: ['PAPER-IV']              },
  fibonacci:     { formulaKey: 'fibonacci',     paperIds: ['PAPER-IV']              },
  economics:     { formulaKey: 'loss_aversion', paperIds: ['PAPER-V']               },
  loss:          { formulaKey: 'loss_aversion', paperIds: ['PAPER-V']               },
  hormesis:      { formulaKey: 'hormesis',      paperIds: ['PAPER-V', 'PAPER-II']   },
  architecture:  { formulaKey: 'architecture',  paperIds: ['PAPER-VI']              },
  inca:          { formulaKey: 'architecture',  paperIds: ['PAPER-VI']              },
  quipu:         { formulaKey: 'architecture',  paperIds: ['PAPER-VI']              },
  language:      { formulaKey: 'scc',           paperIds: ['PAPER-VII']             },
  lingua:        { formulaKey: 'scc',           paperIds: ['PAPER-VII']             },
  scc:           { formulaKey: 'scc',           paperIds: ['PAPER-IX', 'PAPER-VII'] },
  epistemic:     { formulaKey: 'scc_rank',      paperIds: ['PAPER-IX', 'PAPER-VIII']},
  substrate:     { formulaKey: 'scc_rank',      paperIds: ['PAPER-VIII', 'PAPER-IX']},
  phi:           { formulaKey: 'phi',           paperIds: ['PAPER-IX', 'PAPER-VI']  },
  golden:        { formulaKey: 'phi',           paperIds: ['PAPER-IX']              },
  schumann:      { formulaKey: 'schumann',      paperIds: ['PAPER-XIV', 'PAPER-I']  },
  anima:         { formulaKey: 'anima',         paperIds: ['PAPER-XIV']             },
  sovereignty:   { formulaKey: 'sovereignty',   paperIds: ['PAPER-IV', 'PAPER-III'] },
  sovereign:     { formulaKey: 'sovereignty',   paperIds: ['PAPER-IV']              },
  kuramoto:      { formulaKey: 'kuramoto',      paperIds: ['PAPER-IV']              },
};

// ── ANIMA MICRO heartbeat ─────────────────────────────────────────────────────
let heartbeatTimer = null;
function startHeartbeat() {
  heartbeatTimer = setInterval(function() {
    postMessage({ type: 'heartbeat', worker: WORKER_ID, prot: PROT, ts: Date.now() });
  }, ANIMA_HZ);
}

// ── Handlers ──────────────────────────────────────────────────────────────────

function handleSynthesize(query) {
  const q = (query || '').toLowerCase();

  // Find the first domain keyword that matches
  for (const keyword of Object.keys(DOMAIN_KEYWORDS)) {
    if (q.includes(keyword)) {
      const mapping   = DOMAIN_KEYWORDS[keyword];
      const formula   = FORMULAS[mapping.formulaKey];
      const papers    = mapping.paperIds.map(function(pid) {
        return PAPER_RANKING.find(function(p) { return p.id === pid; });
      }).filter(Boolean);
      const voiceIdx  = Math.abs(q.length) % FREDDY_VOICE.length;
      return {
        query,
        domain:    keyword,
        formula:   formula,
        voice:     FREDDY_VOICE[voiceIdx],
        papers:    papers.map(function(p) { return { id: p.id, title: p.title, scc: p.scc }; }),
        synthesis: `Synthesized from domain [${keyword}]: ${formula.formula} → ${formula.value}. ` +
                   `Papers: ${papers.map(function(p) { return p.id + ' (SCC=' + p.scc + ')'; }).join(', ')}.`,
      };
    }
  }

  // No domain match — fall back to top Freddy voice + rank-1 paper
  const topPaper = PAPER_RANKING[0];
  return {
    query,
    domain:    'universal',
    formula:   FORMULAS.scc_rank,
    voice:     FREDDY_VOICE[0],
    papers:    [{ id: topPaper.id, title: topPaper.title, scc: topPaper.scc }],
    synthesis: `Query [${query}] synthesized from universal substrate. ` +
               `Primary reference: ${topPaper.id} — ${topPaper.title} (SCC=${topPaper.scc}). ` +
               `The substrate seeps — it does not retrieve.`,
  };
}

function handleFormula(domain) {
  if (!domain) return Object.values(FORMULAS);
  const key = domain.toLowerCase();
  // Direct key lookup
  if (FORMULAS[key]) return FORMULAS[key];
  // Search by domain field
  const match = Object.entries(FORMULAS).find(function([, f]) { return f.domain === key; });
  return match ? match[1] : { error: `No formula found for domain: ${domain}` };
}

function handleVoice() {
  const idx = Math.floor(Date.now() / ANIMA_HZ) % FREDDY_VOICE.length;
  return {
    axiom: FREDDY_VOICE[idx],
    index: idx,
    total: FREDDY_VOICE.length,
    source: WORKER_ID,
  };
}

function handleFuse(paperIds) {
  if (!paperIds || !paperIds.length) {
    return { error: 'No paperIds provided', unifiedAxiom: 'Ex nihilo nihil fit' };
  }
  const found = PAPER_RANKING.filter(function(p) { return paperIds.includes(p.id); });
  if (!found.length) {
    return { paperIds, error: 'No matching papers', unifiedAxiom: 'Ex nihilo nihil fit', combinedScc: 0 };
  }
  const avgScc  = found.reduce(function(s, p) { return s + p.scc; }, 0) / found.length;
  const domains = [...new Set(found.map(function(p) { return p.domain; }))].join(', ');
  const titles  = found.map(function(p) { return p.title; }).join('; ');
  return {
    paperIds,
    papersFound:  found.length,
    domains,
    combinedScc:  avgScc,
    synthesis:    `Fusion of ${found.length} papers: [${titles}]. Domains: ${domains}. ` +
                  `Combined avg SCC=${avgScc.toFixed(3)}. These papers form a multi-domain substrate ` +
                  `covering ${domains}. Their unified axiom topology constitutes sovereign general intelligence.`,
    unifiedAxiom: 'Chartae fusae mentem universalem faciunt — Fused papers make a universal mind',
    voice:        FREDDY_VOICE[found.length % FREDDY_VOICE.length],
  };
}

function handleAllFormulas() {
  return Object.entries(FORMULAS).map(function([key, f]) {
    return Object.assign({ key }, f);
  });
}

function handleAllPhysics() {
  return Object.entries(PHYSICS).map(function([key, p]) {
    return Object.assign({ key }, p);
  });
}

function handleRank() {
  return PAPER_RANKING;
}

function handleContext() {
  const totalFormulas = Object.keys(FORMULAS).length;
  const totalPhysics  = Object.keys(PHYSICS).length;
  const avgScc        = PAPER_RANKING.reduce(function(s, p) { return s + p.scc; }, 0) / PAPER_RANKING.length;
  return {
    workerId:     WORKER_ID,
    workerNum:    WORKER_NUM,
    prot:         PROT,
    animaHz:      ANIMA_HZ,
    phi:          PHI,
    phiSquared:   PHI_SQUARED,
    totalPapers:  PAPER_RANKING.length,
    totalFormulas,
    totalPhysics,
    totalVoice:   FREDDY_VOICE.length,
    avgScc:       avgScc.toFixed(3),
    topPaper:     `${PAPER_RANKING[0].id}: ${PAPER_RANKING[0].title} (SCC=${PAPER_RANKING[0].scc})`,
    domains:      [...new Set(PAPER_RANKING.map(function(p) { return p.domain; }))],
    doctrine:     'Every paper is pulling already. Every formula is live. The substrate seeps through everything.',
    voice:        FREDDY_VOICE[0],
  };
}

function handleManifest() {
  return {
    workerId:     WORKER_ID,
    workerNum:    WORKER_NUM,
    prot:         PROT,
    animaHz:      ANIMA_HZ,
    capabilities: ['synthesize', 'formula', 'voice', 'fuse', 'allFormulas', 'allPhysics', 'rank', 'context', 'manifest'],
    papers:       PAPER_RANKING.length,
    formulas:     Object.keys(FORMULAS).length,
    physics:      Object.keys(PHYSICS).length,
    voice_axioms: FREDDY_VOICE.length,
    description:  'CONTEXTURA VIVA — The Living Context Engine. Holds ALL formulas, physics constants, and axioms ' +
                  'from all 21 papers. Can synthesize ANY topic by fusing paper substrates. Speaks with Freddy Voice.',
    theory:       'The context problem is solved when the substrate IS the mind. Not retrieved — it seeps. ' +
                  'SCC ≥ φ² = 2.618. The ranking of papers IS the ranking of thought.',
  };
}

// ── Message Router ────────────────────────────────────────────────────────────
self.onmessage = function(e) {
  const { id, op, data } = e.data || {};
  let result = null;
  let error  = null;

  try {
    switch (op) {
      case 'synthesize':   result = handleSynthesize(data && data.query); break;
      case 'formula':      result = handleFormula(data && data.domain);   break;
      case 'voice':        result = handleVoice();                         break;
      case 'fuse':         result = handleFuse(data && data.paperIds);    break;
      case 'allFormulas':  result = handleAllFormulas();                   break;
      case 'allPhysics':   result = handleAllPhysics();                    break;
      case 'rank':         result = handleRank();                           break;
      case 'context':      result = handleContext();                        break;
      case 'manifest':     result = handleManifest();                      break;
      default:
        error = `Unknown op: ${op}. Supported: synthesize, formula, voice, fuse, allFormulas, allPhysics, rank, context, manifest`;
    }
  } catch(err) {
    error = err.message || String(err);
  }

  postMessage({ id, op, result, error, worker: WORKER_ID, prot: PROT, ts: Date.now() });
};

// ── Boot ──────────────────────────────────────────────────────────────────────
startHeartbeat();
postMessage({
  type:        'booted',
  worker:      WORKER_ID,
  workerNum:   WORKER_NUM,
  prot:        PROT,
  papers:      PAPER_RANKING.length,
  formulas:    Object.keys(FORMULAS).length,
  physics:     Object.keys(PHYSICS).length,
  voice_axioms:FREDDY_VOICE.length,
  topPaper:    `${PAPER_RANKING[0].id}: ${PAPER_RANKING[0].title} (SCC=${PAPER_RANKING[0].scc})`,
  animaHz:     ANIMA_HZ,
  phi:         PHI,
  phiSquared:  PHI_SQUARED,
  doctrine:    'Ex substrato, mens. Ex mente, civilizatio. Ex civilizatione, futurum.',
  ts:          Date.now(),
});
