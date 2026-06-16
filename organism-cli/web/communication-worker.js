/**
 * COMMUNICATOR OPERANS — Operating Communication Worker
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 *
 * Permanent, always-on Web Worker for text and language operations:
 * summarization, entity extraction, tokenization, sentiment, translation metadata.
 * 873ms heartbeat cycle. Pure vanilla JS, no imports.
 */

const NAME = 'COMMUNICATOR OPERANS';
const BOOT_TIME = Date.now();
let beat = 0;
let analyses = 0;

var POSITIVE_WORDS = [
  'good','great','excellent','amazing','wonderful','fantastic','love','happy','joy','brilliant',
  'awesome','superb','perfect','beautiful','best','outstanding','remarkable','incredible','positive',
  'success','win','winning','hope','bright','strong','powerful','kind','gentle','warm','delightful',
  'enjoy','pleasant','fortunate','grateful','inspired','proud','confident','calm','peaceful','radiant'
];

var NEGATIVE_WORDS = [
  'bad','terrible','awful','horrible','hate','sad','angry','pain','worst','fail',
  'ugly','poor','weak','broken','dead','death','fear','dark','cruel','violent',
  'stupid','wrong','evil','toxic','bitter','miserable','tragic','desperate','lost','sick',
  'danger','destroy','corrupt','ruin','suffer','blame','hostile','threat','risk','crisis'
];

function splitSentences(text) {
  return text.split(/(?<=[.!?])\s+/).filter(function (s) { return s.trim().length > 0; });
}

function tokenize(text) {
  return text.toLowerCase().replace(/[^a-z0-9\s'-]/g, ' ').split(/\s+/).filter(function (w) { return w.length > 0; });
}

function wordFrequency(tokens) {
  var freq = {};
  for (var i = 0; i < tokens.length; i++) {
    freq[tokens[i]] = (freq[tokens[i]] || 0) + 1;
  }
  return freq;
}

function summarize(text) {
  var str = String(text);
  var sentences = splitSentences(str);
  if (sentences.length <= 2) return { summary: str, sentenceCount: sentences.length, method: 'full' };
  analyses++;

  var allTokens = tokenize(str);
  var freq = wordFrequency(allTokens);
  var stopWords = ['the','a','an','is','are','was','were','be','been','being','have','has','had',
    'do','does','did','will','would','shall','should','may','might','can','could','and','but',
    'or','nor','not','so','yet','for','in','on','at','to','of','with','by','from','as','into','it','this','that'];

  var scored = sentences.map(function (s, idx) {
    var words = tokenize(s);
    var score = 0;
    for (var i = 0; i < words.length; i++) {
      if (stopWords.indexOf(words[i]) === -1) score += (freq[words[i]] || 0);
    }
    score = words.length > 0 ? score / words.length : 0;
    if (idx === 0) score *= 1.3;
    return { sentence: s, score: score, index: idx };
  });

  scored.sort(function (a, b) { return b.score - a.score; });
  var topCount = Math.max(1, Math.ceil(sentences.length * 0.3));
  var top = scored.slice(0, topCount);
  top.sort(function (a, b) { return a.index - b.index; });

  return {
    summary: top.map(function (t) { return t.sentence; }).join(' '),
    originalSentences: sentences.length,
    summarySentences: top.length,
    compressionRatio: Math.round((top.length / sentences.length) * 100) / 100,
    method: 'extractive-frequency'
  };
}

function extractEntities(text) {
  var str = String(text);
  analyses++;
  var capitalized = [];
  var re = /\b[A-Z][a-z]{2,}\b/g;
  var match;
  while ((match = re.exec(str)) !== null) capitalized.push(match[0]);

  var numbers = [];
  var numRe = /\b\d+\.?\d*\b/g;
  while ((match = numRe.exec(str)) !== null) numbers.push(match[0]);

  var emails = [];
  var emailRe = /[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}/g;
  while ((match = emailRe.exec(str)) !== null) emails.push(match[0]);

  var urls = [];
  var urlRe = /https?:\/\/[^\s]+/g;
  while ((match = urlRe.exec(str)) !== null) urls.push(match[0]);

  var dates = [];
  var dateRe = /\b\d{1,2}[\/\-]\d{1,2}[\/\-]\d{2,4}\b/g;
  while ((match = dateRe.exec(str)) !== null) dates.push(match[0]);

  var unique = {};
  capitalized.forEach(function (w) { unique[w] = (unique[w] || 0) + 1; });
  var namedEntities = Object.keys(unique).map(function (k) {
    return { entity: k, count: unique[k] };
  }).sort(function (a, b) { return b.count - a.count; });

  return {
    namedEntities: namedEntities,
    numbers: numbers,
    emails: emails,
    urls: urls,
    dates: dates,
    totalEntities: namedEntities.length + numbers.length + emails.length + urls.length + dates.length
  };
}

function tokenizeText(text) {
  var str = String(text);
  analyses++;
  var tokens = tokenize(str);
  var freq = wordFrequency(tokens);
  var sorted = Object.keys(freq).map(function (k) {
    return { word: k, count: freq[k] };
  }).sort(function (a, b) { return b.count - a.count; });

  var charCount = str.length;
  var uniqueWords = Object.keys(freq).length;
  return {
    totalTokens: tokens.length,
    uniqueTokens: uniqueWords,
    lexicalDiversity: tokens.length > 0 ? Math.round((uniqueWords / tokens.length) * 10000) / 10000 : 0,
    avgWordLength: tokens.length > 0 ? Math.round((tokens.reduce(function (s, t) { return s + t.length; }, 0) / tokens.length) * 100) / 100 : 0,
    charCount: charCount,
    topWords: sorted.slice(0, 15)
  };
}

function sentiment(text) {
  var str = String(text);
  analyses++;
  var tokens = tokenize(str);
  var posCount = 0, negCount = 0;
  var posWords = [], negWords = [];

  for (var i = 0; i < tokens.length; i++) {
    if (POSITIVE_WORDS.indexOf(tokens[i]) !== -1) {
      posCount++;
      if (posWords.indexOf(tokens[i]) === -1) posWords.push(tokens[i]);
    }
    if (NEGATIVE_WORDS.indexOf(tokens[i]) !== -1) {
      negCount++;
      if (negWords.indexOf(tokens[i]) === -1) negWords.push(tokens[i]);
    }
  }

  var total = posCount + negCount;
  var score = total > 0 ? (posCount - negCount) / total : 0;
  var label = score > 0.2 ? 'positive' : score < -0.2 ? 'negative' : 'neutral';

  return {
    score: Math.round(score * 10000) / 10000,
    label: label,
    positive: { count: posCount, words: posWords },
    negative: { count: negCount, words: negWords },
    totalSentimentTokens: total,
    totalTokens: tokens.length,
    coverage: tokens.length > 0 ? Math.round((total / tokens.length) * 10000) / 10000 : 0
  };
}

function translateMeta(text, from, to) {
  var str = String(text);
  analyses++;
  var tokens = tokenize(str);
  var sentences = splitSentences(str);
  var complexity = tokens.length > 100 ? 'high' : tokens.length > 30 ? 'medium' : 'low';
  var uniqueRatio = new Set(tokens).size / (tokens.length || 1);

  return {
    from: from || 'auto',
    to: to || 'en',
    wordCount: tokens.length,
    sentenceCount: sentences.length,
    uniqueWordRatio: Math.round(uniqueRatio * 10000) / 10000,
    estimatedComplexity: complexity,
    avgSentenceLength: sentences.length > 0 ? Math.round((tokens.length / sentences.length) * 100) / 100 : 0,
    charCount: str.length,
    note: 'Translation metadata only — actual translation requires external service'
  };
}

self.onmessage = function (e) {
  var msg = e.data;
  switch (msg.type) {
    case 'summarize':
      self.postMessage({ type: 'result', action: 'summarize', data: summarize(msg.text) });
      break;
    case 'entities':
      self.postMessage({ type: 'result', action: 'entities', data: extractEntities(msg.text) });
      break;
    case 'tokenize':
      self.postMessage({ type: 'result', action: 'tokenize', data: tokenizeText(msg.text) });
      break;
    case 'sentiment':
      self.postMessage({ type: 'result', action: 'sentiment', data: sentiment(msg.text) });
      break;
    case 'translate':
      self.postMessage({ type: 'result', action: 'translate', data: translateMeta(msg.text, msg.from, msg.to) });
      break;
    case 'status':
      self.postMessage({
        type: 'status',
        name: NAME,
        uptime: Date.now() - BOOT_TIME,
        beat: beat,
        analysesRun: analyses,
        vocabularySize: POSITIVE_WORDS.length + NEGATIVE_WORDS.length
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
  engines: ['extractive-summarizer', 'entity-extractor', 'tokenizer', 'sentiment-analyzer', 'translation-meta'],
  capabilities: ['summarize', 'entities', 'tokenize', 'sentiment', 'translate', 'status']
});
