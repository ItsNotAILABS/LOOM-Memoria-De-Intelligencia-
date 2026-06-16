/**
 * INTELLIGENTIA INFERENS — Inference Worker
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 *
 * Permanent, always-on Web Worker for AI inference:
 * Text summarization, question answering, intent classification,
 * chain-of-thought reasoning, and topic modeling.
 * 873ms heartbeat cycle. Pure vanilla JS, no imports.
 */

var NAME = 'INTELLIGENTIA INFERENS';
var BOOT_TIME = Date.now();
var beat = 0;
var inferences = 0;

// ── Text Utilities ───────────────────────────────────────────────────

var STOP_WORDS = (
  'a an the is are was were be been being have has had do does did will would ' +
  'shall should may might can could of in to for on with at by from as into ' +
  'through during before after above below between out off over under again ' +
  'further then once here there when where why how all both each few more ' +
  'most other some such no nor not only own same so than too very and but or ' +
  'if it its this that these those i me my we our you your he him his she her ' +
  'they them their what which who whom'
).split(' ');

var STOP_SET = {};
for (var si = 0; si < STOP_WORDS.length; si++) STOP_SET[STOP_WORDS[si]] = 1;

function tokenize(text) {
  return text.toLowerCase().replace(/[^a-z0-9\s]/g, ' ').split(/\s+/).filter(function (w) {
    return w.length > 1;
  });
}

function tokenizeFiltered(text) {
  return tokenize(text).filter(function (w) { return !STOP_SET[w]; });
}

function splitSentences(text) {
  var raw = text.replace(/([.!?])\s+/g, '$1\n').split('\n');
  var sentences = [];
  for (var i = 0; i < raw.length; i++) {
    var s = raw[i].trim();
    if (s.length > 5) sentences.push(s);
  }
  return sentences.length > 0 ? sentences : [text.trim()];
}

function wordFrequency(words) {
  var freq = {};
  for (var i = 0; i < words.length; i++) {
    freq[words[i]] = (freq[words[i]] || 0) + 1;
  }
  return freq;
}

function cosineSimilarity(vecA, vecB) {
  var keys = {};
  var k;
  for (k in vecA) keys[k] = 1;
  for (k in vecB) keys[k] = 1;
  var dot = 0, magA = 0, magB = 0;
  for (k in keys) {
    var a = vecA[k] || 0;
    var b = vecB[k] || 0;
    dot += a * b;
    magA += a * a;
    magB += b * b;
  }
  var denom = Math.sqrt(magA) * Math.sqrt(magB);
  return denom === 0 ? 0 : dot / denom;
}

function bowVector(text) {
  var words = tokenizeFiltered(text);
  return wordFrequency(words);
}

function r4(v) { return Math.round(v * 10000) / 10000; }

// ── 1. Text Summarization (Extractive) ──────────────────────────────

function summarize(text, numSentences) {
  var n = (typeof numSentences === 'number' && numSentences > 0) ? numSentences : 3;
  var sentences = splitSentences(text);
  if (sentences.length <= n) {
    inferences++;
    return { summary: sentences.join(' '), sentenceCount: sentences.length, method: 'complete' };
  }

  var allWords = tokenizeFiltered(text);
  var globalFreq = wordFrequency(allWords);
  var maxFreq = 0;
  for (var w in globalFreq) {
    if (globalFreq[w] > maxFreq) maxFreq = globalFreq[w];
  }
  // Normalize frequencies
  if (maxFreq > 0) {
    for (var w2 in globalFreq) globalFreq[w2] = globalFreq[w2] / maxFreq;
  }

  var scored = [];
  for (var i = 0; i < sentences.length; i++) {
    var sWords = tokenizeFiltered(sentences[i]);
    // TF score
    var tfScore = 0;
    for (var j = 0; j < sWords.length; j++) {
      tfScore += globalFreq[sWords[j]] || 0;
    }
    tfScore = sWords.length > 0 ? tfScore / sWords.length : 0;

    // Position bonus: first and last sentences are more important
    var posBonus = 0;
    if (i === 0) posBonus = 0.25;
    else if (i === sentences.length - 1) posBonus = 0.15;
    else if (i === 1) posBonus = 0.1;

    // Length normality: prefer medium-length sentences (10-30 words)
    var wordCount = sWords.length;
    var lenScore = 0;
    if (wordCount >= 5 && wordCount <= 40) {
      lenScore = 1 - Math.abs(wordCount - 18) / 25;
      lenScore = Math.max(0, lenScore) * 0.2;
    }

    // Keyword density: ratio of non-stop words
    var rawWords = tokenize(sentences[i]);
    var density = rawWords.length > 0 ? sWords.length / rawWords.length : 0;
    var densityScore = density * 0.15;

    var total = r4(tfScore * 0.5 + posBonus + lenScore + densityScore);
    scored.push({ index: i, sentence: sentences[i], score: total });
  }

  scored.sort(function (a, b) { return b.score - a.score; });
  var top = scored.slice(0, n);
  // Restore original order
  top.sort(function (a, b) { return a.index - b.index; });

  var summary = [];
  var details = [];
  for (var t = 0; t < top.length; t++) {
    summary.push(top[t].sentence);
    details.push({ position: top[t].index, score: top[t].score });
  }

  inferences++;
  return {
    summary: summary.join(' '),
    sentenceCount: sentences.length,
    selectedCount: n,
    method: 'extractive-tf-position',
    details: details
  };
}

// ── 2. Question Answering (Context-Based Extraction) ────────────────

function answerQuestion(context, question) {
  var sentences = splitSentences(context);
  var qVec = bowVector(question);

  var best = { index: -1, score: -1, sentence: '' };
  var scores = [];

  for (var i = 0; i < sentences.length; i++) {
    var sVec = bowVector(sentences[i]);
    var sim = cosineSimilarity(qVec, sVec);

    // Bonus for question-word overlap
    var qWords = tokenizeFiltered(question);
    var sWords = tokenizeFiltered(sentences[i]);
    var overlap = 0;
    for (var j = 0; j < qWords.length; j++) {
      for (var k = 0; k < sWords.length; k++) {
        if (qWords[j] === sWords[k]) { overlap++; break; }
      }
    }
    var overlapBonus = qWords.length > 0 ? (overlap / qWords.length) * 0.3 : 0;
    var finalScore = r4(sim * 0.7 + overlapBonus);

    scores.push({ index: i, score: finalScore });
    if (finalScore > best.score) {
      best = { index: i, score: finalScore, sentence: sentences[i] };
    }
  }

  // Surrounding context
  var preceding = best.index > 0 ? sentences[best.index - 1] : null;
  var following = best.index < sentences.length - 1 ? sentences[best.index + 1] : null;

  inferences++;
  return {
    answer: best.sentence,
    confidence: r4(Math.min(best.score, 1.0)),
    sentenceIndex: best.index,
    totalSentences: sentences.length,
    context: { preceding: preceding, following: following },
    method: 'cosine-bow-extraction'
  };
}

// ── 3. Intent Classification (12 Intent Types) ─────────────────────

var INTENT_PATTERNS = {
  greeting:  { words: ['hello', 'hi', 'hey', 'greetings', 'howdy', 'morning', 'afternoon', 'evening', 'welcome', 'sup'], weight: 1.0 },
  farewell:  { words: ['bye', 'goodbye', 'farewell', 'later', 'cya', 'goodnight', 'see you', 'take care', 'adios', 'peace'], weight: 1.0 },
  question:  { words: ['what', 'how', 'why', 'when', 'where', 'who', 'which', 'does', 'could', 'would', 'should', 'is it', 'can you', 'tell me'], weight: 0.8 },
  command:   { words: ['do', 'run', 'execute', 'start', 'stop', 'create', 'delete', 'remove', 'install', 'open', 'close', 'show', 'list', 'set', 'update'], weight: 0.9 },
  code:      { words: ['function', 'variable', 'code', 'debug', 'compile', 'syntax', 'error', 'bug', 'class', 'api', 'import', 'module', 'refactor', 'deploy'], weight: 1.0 },
  math:      { words: ['calculate', 'compute', 'sum', 'average', 'multiply', 'divide', 'equation', 'formula', 'percent', 'ratio', 'integral', 'derivative', 'matrix', 'probability'], weight: 1.0 },
  search:    { words: ['find', 'search', 'look', 'lookup', 'locate', 'discover', 'query', 'filter', 'browse', 'explore'], weight: 0.9 },
  help:      { words: ['help', 'assist', 'support', 'guide', 'explain', 'tutorial', 'documentation', 'docs', 'manual', 'instructions', 'how to'], weight: 0.9 },
  feedback:  { words: ['thanks', 'thank', 'great', 'good', 'awesome', 'nice', 'love', 'excellent', 'perfect', 'amazing', 'well done', 'appreciate'], weight: 1.0 },
  complaint: { words: ['bad', 'wrong', 'broken', 'fail', 'hate', 'terrible', 'awful', 'poor', 'worst', 'useless', 'annoying', 'frustrating', 'disappointed'], weight: 1.0 },
  creative:  { words: ['write', 'compose', 'generate', 'create', 'design', 'imagine', 'story', 'poem', 'song', 'idea', 'brainstorm', 'invent', 'draft'], weight: 0.9 }
};

function classifyIntent(text) {
  var lower = text.toLowerCase();
  var words = tokenize(text);
  var scores = {};

  for (var intent in INTENT_PATTERNS) {
    var pattern = INTENT_PATTERNS[intent];
    var matchCount = 0;
    for (var p = 0; p < pattern.words.length; p++) {
      if (lower.indexOf(pattern.words[p]) !== -1) matchCount++;
    }
    var wordScore = pattern.words.length > 0 ? matchCount / pattern.words.length : 0;
    scores[intent] = r4(wordScore * pattern.weight);
  }

  // Structure analysis bonuses
  if (lower.charAt(lower.length - 1) === '?') {
    scores.question = r4((scores.question || 0) + 0.3);
  }
  if (lower.charAt(lower.length - 1) === '!') {
    scores.command = r4((scores.command || 0) + 0.15);
    scores.feedback = r4((scores.feedback || 0) + 0.1);
  }
  if (words.length <= 3) {
    scores.greeting = r4((scores.greeting || 0) + 0.1);
    scores.farewell = r4((scores.farewell || 0) + 0.1);
  }
  if (/\d[\+\-\*\/\^]\d/.test(text)) {
    scores.math = r4((scores.math || 0) + 0.4);
  }
  if (/[{}();=]/.test(text) || /\b(var|let|const|function|return|if|else)\b/.test(lower)) {
    scores.code = r4((scores.code || 0) + 0.35);
  }

  // Sort and pick top 3
  var ranked = [];
  for (var key in scores) {
    ranked.push({ intent: key, confidence: scores[key] });
  }
  ranked.sort(function (a, b) { return b.confidence - a.confidence; });

  // If all zero, mark unknown
  if (ranked.length === 0 || ranked[0].confidence === 0) {
    ranked = [{ intent: 'unknown', confidence: 0.5 }];
  }

  var top3 = ranked.slice(0, 3);
  // Normalize top-3 confidences
  var totalConf = 0;
  for (var c = 0; c < top3.length; c++) totalConf += top3[c].confidence;
  if (totalConf > 0) {
    for (var c2 = 0; c2 < top3.length; c2++) {
      top3[c2].confidence = r4(top3[c2].confidence / totalConf);
    }
  }

  inferences++;
  return {
    primary: top3[0].intent,
    intents: top3,
    wordCount: words.length,
    method: 'keyword-structure-analysis'
  };
}

// ── 4. Chain-of-Thought Reasoning (6-Step Decomposition) ────────────

var REASONING_STEPS = ['PARSE', 'DECOMPOSE', 'ANALYZE', 'SYNTHESIZE', 'VALIDATE', 'RESPOND'];

var CAPABILITY_KEYWORDS = {
  math:     ['calculate', 'compute', 'sum', 'equation', 'formula', 'number', 'add', 'subtract', 'multiply', 'divide', 'integral', 'matrix'],
  protocol: ['protocol', 'handshake', 'connect', 'message', 'packet', 'network', 'tcp', 'http', 'websocket', 'api'],
  memory:   ['remember', 'store', 'recall', 'memory', 'forget', 'save', 'cache', 'history', 'persist', 'data'],
  security: ['password', 'encrypt', 'decrypt', 'hash', 'token', 'auth', 'secure', 'threat', 'vulnerability', 'permission'],
  search:   ['find', 'search', 'lookup', 'query', 'locate', 'index', 'filter', 'match', 'retrieve'],
  creative: ['write', 'compose', 'generate', 'create', 'story', 'poem', 'imagine', 'design', 'idea'],
  inference:['summarize', 'classify', 'predict', 'analyze', 'understand', 'infer', 'reason', 'determine', 'topic']
};

function routeCapability(query) {
  var lower = query.toLowerCase();
  var best = { capability: 'inference', score: 0 };
  for (var cap in CAPABILITY_KEYWORDS) {
    var keywords = CAPABILITY_KEYWORDS[cap];
    var hits = 0;
    for (var i = 0; i < keywords.length; i++) {
      if (lower.indexOf(keywords[i]) !== -1) hits++;
    }
    var score = keywords.length > 0 ? hits / keywords.length : 0;
    if (score > best.score) {
      best = { capability: cap, score: r4(score) };
    }
  }
  return best;
}

function chainOfThought(query) {
  var words = tokenize(query);
  var filtered = tokenizeFiltered(query);
  var lower = query.toLowerCase();

  var steps = [];

  // Step 1: PARSE
  steps.push({
    step: 'PARSE',
    output: {
      rawLength: query.length,
      wordCount: words.length,
      contentWords: filtered.length,
      hasQuestion: lower.indexOf('?') !== -1,
      hasCommand: /^(do|run|show|create|find|compute|calculate|tell|explain)/i.test(query.trim()),
      sentenceCount: splitSentences(query).length
    }
  });

  // Step 2: DECOMPOSE — break into sub-problems
  var subProblems = [];
  var sentences = splitSentences(query);
  for (var i = 0; i < sentences.length; i++) {
    var intent = classifyIntent(sentences[i]);
    inferences--; // Don't double-count
    subProblems.push({ fragment: sentences[i], primaryIntent: intent.primary, confidence: intent.intents[0].confidence });
  }
  steps.push({
    step: 'DECOMPOSE',
    output: { subProblems: subProblems, count: subProblems.length }
  });

  // Step 3: ANALYZE — keyword extraction and frequency
  var freq = wordFrequency(filtered);
  var keyTerms = [];
  for (var w in freq) {
    keyTerms.push({ term: w, count: freq[w] });
  }
  keyTerms.sort(function (a, b) { return b.count - a.count; });
  keyTerms = keyTerms.slice(0, 8);
  steps.push({
    step: 'ANALYZE',
    output: { keyTerms: keyTerms, uniqueTerms: Object.keys(freq).length, totalTerms: filtered.length }
  });

  // Step 4: SYNTHESIZE — determine capability routing
  var routing = routeCapability(query);
  var complexity = 'simple';
  if (words.length > 20 || subProblems.length > 2) complexity = 'moderate';
  if (words.length > 50 || subProblems.length > 4) complexity = 'complex';
  steps.push({
    step: 'SYNTHESIZE',
    output: { routing: routing, complexity: complexity, estimatedWorkers: subProblems.length > 1 ? 'multi' : 'single' }
  });

  // Step 5: VALIDATE — check consistency
  var intentAgreement = true;
  if (subProblems.length > 1) {
    var first = subProblems[0].primaryIntent;
    for (var v = 1; v < subProblems.length; v++) {
      if (subProblems[v].primaryIntent !== first) { intentAgreement = false; break; }
    }
  }
  var avgConfidence = 0;
  for (var ac = 0; ac < subProblems.length; ac++) avgConfidence += subProblems[ac].confidence;
  avgConfidence = subProblems.length > 0 ? r4(avgConfidence / subProblems.length) : 0;
  steps.push({
    step: 'VALIDATE',
    output: { intentAgreement: intentAgreement, avgConfidence: avgConfidence, isCoherent: avgConfidence > 0.3 }
  });

  // Step 6: RESPOND — final recommendation
  steps.push({
    step: 'RESPOND',
    output: {
      recommendedWorker: routing.capability,
      routingConfidence: routing.score,
      summary: 'Query decomposed into ' + subProblems.length + ' sub-problem(s), routed to ' + routing.capability + ' worker with ' + complexity + ' complexity.',
      actionable: avgConfidence > 0.2
    }
  });

  inferences++;
  return {
    query: query,
    steps: steps,
    totalSteps: REASONING_STEPS.length,
    method: 'chain-of-thought-6step'
  };
}

// ── 5. Topic Modeling (K-Means on Bag-of-Words Vectors) ─────────────

function buildVocabulary(sentences) {
  var vocab = {};
  var idx = 0;
  for (var i = 0; i < sentences.length; i++) {
    var words = tokenizeFiltered(sentences[i]);
    for (var j = 0; j < words.length; j++) {
      if (vocab[words[j]] === undefined) {
        vocab[words[j]] = idx++;
      }
    }
  }
  return vocab;
}

function sentenceToVector(sentence, vocab) {
  var vec = [];
  var size = Object.keys(vocab).length;
  for (var i = 0; i < size; i++) vec.push(0);
  var words = tokenizeFiltered(sentence);
  for (var j = 0; j < words.length; j++) {
    var idx = vocab[words[j]];
    if (idx !== undefined) vec[idx]++;
  }
  return vec;
}

function vecDistance(a, b) {
  var sum = 0;
  for (var i = 0; i < a.length; i++) {
    var d = a[i] - b[i];
    sum += d * d;
  }
  return Math.sqrt(sum);
}

function vecAdd(a, b) {
  var r = [];
  for (var i = 0; i < a.length; i++) r.push(a[i] + b[i]);
  return r;
}

function vecScale(v, s) {
  var r = [];
  for (var i = 0; i < v.length; i++) r.push(v[i] * s);
  return r;
}

function zeroVec(dim) {
  var v = [];
  for (var i = 0; i < dim; i++) v.push(0);
  return v;
}

function topicModel(text, requestedK) {
  var sentences = splitSentences(text);
  if (sentences.length < 2) {
    inferences++;
    return { clusters: [{ id: 0, sentences: sentences, keywords: tokenizeFiltered(text).slice(0, 5) }], k: 1, method: 'single-cluster' };
  }

  var k = typeof requestedK === 'number' && requestedK > 0
    ? Math.min(requestedK, sentences.length)
    : Math.min(Math.max(Math.floor(sentences.length / 3), 2), 5);

  var vocab = buildVocabulary(sentences);
  var dim = Object.keys(vocab).length;
  if (dim === 0) {
    inferences++;
    return { clusters: [{ id: 0, sentences: sentences, keywords: [] }], k: 1, method: 'empty-vocab' };
  }

  var vocabKeys = Object.keys(vocab);

  // Build sentence vectors
  var vectors = [];
  for (var i = 0; i < sentences.length; i++) {
    vectors.push(sentenceToVector(sentences[i], vocab));
  }

  // Initialize centroids via spread selection
  var centroids = [];
  var step = Math.max(1, Math.floor(sentences.length / k));
  for (var c = 0; c < k; c++) {
    var pick = Math.min(c * step, sentences.length - 1);
    centroids.push(vectors[pick].slice());
  }

  // K-means iterations (max 20)
  var assignments = [];
  for (var iter = 0; iter < 20; iter++) {
    var changed = false;

    // Assign each sentence to nearest centroid
    var newAssignments = [];
    for (var s = 0; s < vectors.length; s++) {
      var minDist = Infinity;
      var minIdx = 0;
      for (var ci = 0; ci < centroids.length; ci++) {
        var d = vecDistance(vectors[s], centroids[ci]);
        if (d < minDist) { minDist = d; minIdx = ci; }
      }
      newAssignments.push(minIdx);
      if (assignments[s] !== minIdx) changed = true;
    }
    assignments = newAssignments;

    if (!changed && iter > 0) break;

    // Recompute centroids
    var counts = [];
    var sums = [];
    for (var nc = 0; nc < k; nc++) {
      counts.push(0);
      sums.push(zeroVec(dim));
    }
    for (var ns = 0; ns < vectors.length; ns++) {
      var a = assignments[ns];
      counts[a]++;
      sums[a] = vecAdd(sums[a], vectors[ns]);
    }
    for (var uc = 0; uc < k; uc++) {
      if (counts[uc] > 0) {
        centroids[uc] = vecScale(sums[uc], 1 / counts[uc]);
      }
    }
  }

  // Build cluster output with top keywords
  var clusters = [];
  for (var cl = 0; cl < k; cl++) {
    var clusterSentences = [];
    var clusterWordFreq = {};
    for (var cs = 0; cs < assignments.length; cs++) {
      if (assignments[cs] === cl) {
        clusterSentences.push(sentences[cs]);
        var cWords = tokenizeFiltered(sentences[cs]);
        for (var cw = 0; cw < cWords.length; cw++) {
          clusterWordFreq[cWords[cw]] = (clusterWordFreq[cWords[cw]] || 0) + 1;
        }
      }
    }
    // Top keywords per cluster
    var kwList = [];
    for (var kw in clusterWordFreq) {
      kwList.push({ word: kw, count: clusterWordFreq[kw] });
    }
    kwList.sort(function (a, b) { return b.count - a.count; });
    var topKw = [];
    for (var tk = 0; tk < Math.min(5, kwList.length); tk++) {
      topKw.push(kwList[tk].word);
    }

    // Representative sentence: closest to centroid
    var repSentence = clusterSentences.length > 0 ? clusterSentences[0] : '';
    var repDist = Infinity;
    for (var rs = 0; rs < assignments.length; rs++) {
      if (assignments[rs] === cl) {
        var rd = vecDistance(vectors[rs], centroids[cl]);
        if (rd < repDist) { repDist = rd; repSentence = sentences[rs]; }
      }
    }

    if (clusterSentences.length > 0) {
      clusters.push({
        id: cl,
        size: clusterSentences.length,
        representative: repSentence,
        keywords: topKw,
        sentences: clusterSentences
      });
    }
  }

  inferences++;
  return {
    clusters: clusters,
    k: k,
    totalSentences: sentences.length,
    vocabSize: dim,
    iterations: iter,
    method: 'kmeans-bow'
  };
}

// ── Message Handler ─────────────────────────────────────────────────

self.onmessage = function (e) {
  var msg = e.data;
  switch (msg.type) {
    case 'summarize':
      self.postMessage({ type: 'result', action: 'summarize', data: summarize(msg.text, msg.sentences) });
      break;
    case 'qa':
      self.postMessage({ type: 'result', action: 'qa', data: answerQuestion(msg.context, msg.question) });
      break;
    case 'classify':
      self.postMessage({ type: 'result', action: 'classify', data: classifyIntent(msg.text) });
      break;
    case 'reason':
      self.postMessage({ type: 'result', action: 'reason', data: chainOfThought(msg.query) });
      break;
    case 'topics':
      self.postMessage({ type: 'result', action: 'topics', data: topicModel(msg.text, msg.k) });
      break;
    case 'status':
      self.postMessage({
        type: 'status',
        name: NAME,
        uptime: Date.now() - BOOT_TIME,
        beat: beat,
        inferences: inferences,
        capabilities: ['summarize', 'qa', 'classify', 'reason', 'topics']
      });
      break;
  }
};

setInterval(function () {
  beat++;
  self.postMessage({ type: 'heartbeat', name: NAME, beat: beat, uptime: Date.now() - BOOT_TIME });
}, 873);

self.postMessage({
  type: 'booted',
  name: NAME,
  engines: [
    'extractive-summarization',
    'cosine-bow-qa',
    'keyword-intent-classifier',
    'chain-of-thought-reasoning',
    'kmeans-topic-modeling'
  ],
  capabilities: ['summarize', 'qa', 'classify', 'reason', 'topics', 'status']
});
