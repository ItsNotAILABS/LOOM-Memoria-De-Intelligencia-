/**
 * CUSTOS OPERANS — Operating Security Worker
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 *
 * Permanent, always-on Web Worker for security operations:
 * hashing, entropy analysis, threat scanning, token validation.
 * 873ms heartbeat cycle. Pure vanilla JS, no imports.
 */

const NAME = 'CUSTOS OPERANS';
const BOOT_TIME = Date.now();
let beat = 0;
let scanCount = 0;

// FNV-1a 32-bit hash — fast, deterministic, pure JS
function fnv1a32(str) {
  var hash = 0x811c9dc5;
  for (var i = 0; i < str.length; i++) {
    hash ^= str.charCodeAt(i);
    hash = (hash * 0x01000193) >>> 0;
  }
  return hash;
}

// FNV-1a 64-bit approximation via two 32-bit passes
function fnv1a64(str) {
  var h1 = fnv1a32(str);
  var h2 = fnv1a32(str + '\x00');
  return pad8(h1) + pad8(h2);
}

function pad8(n) {
  var s = (n >>> 0).toString(16);
  while (s.length < 8) s = '0' + s;
  return s;
}

// Full hash cascade: FNV-1a at 32, 64, and 128-bit widths
function hashInput(input) {
  var str = String(input);
  var h32 = fnv1a32(str);
  var h64 = fnv1a64(str);
  // 128-bit approximation via 4 seeded passes
  var parts = [];
  for (var i = 0; i < 4; i++) {
    parts.push(pad8(fnv1a32(str + String(i))));
  }
  return {
    input_length: str.length,
    fnv1a_32: pad8(h32),
    fnv1a_64: h64,
    fnv1a_128: parts.join(''),
    algorithm: 'FNV-1a',
    timestamp: Date.now()
  };
}

// Shannon entropy
function shannonEntropy(str) {
  if (!str || str.length === 0) return { entropy: 0, normalized: 0, length: 0 };
  var freq = {};
  for (var i = 0; i < str.length; i++) {
    var c = str[i];
    freq[c] = (freq[c] || 0) + 1;
  }
  var len = str.length;
  var entropy = 0;
  var chars = Object.keys(freq);
  for (var j = 0; j < chars.length; j++) {
    var p = freq[chars[j]] / len;
    if (p > 0) entropy -= p * Math.log2(p);
  }
  var maxEntropy = Math.log2(chars.length) || 1;
  return {
    entropy: Math.round(entropy * 10000) / 10000,
    normalized: Math.round((entropy / maxEntropy) * 10000) / 10000,
    maxPossible: Math.round(maxEntropy * 10000) / 10000,
    uniqueChars: chars.length,
    length: len,
    distribution: chars.slice(0, 20).map(function (c) {
      return { char: c === ' ' ? '<space>' : c, count: freq[c], freq: Math.round((freq[c] / len) * 10000) / 10000 };
    })
  };
}

var THREAT_PATTERNS = [
  { name: 'SQL Injection', pattern: /(\b(SELECT|INSERT|UPDATE|DELETE|DROP|UNION|ALTER)\b.*\b(FROM|INTO|TABLE|SET|WHERE)\b)/i },
  { name: 'XSS Script Tag', pattern: /<script[\s>]/i },
  { name: 'XSS Event Handler', pattern: /\bon\w+\s*=/i },
  { name: 'Path Traversal', pattern: /\.\.[\/\\]/g },
  { name: 'Command Injection', pattern: /[;&|`$]\s*(cat|ls|rm|wget|curl|bash|sh|python|node)\b/i },
  { name: 'Null Byte', pattern: /\x00/g },
  { name: 'LDAP Injection', pattern: /[()\\*\x00].*[=&|]/g },
  { name: 'Template Injection', pattern: /\{\{.*\}\}/g },
  { name: 'Excessive Length', pattern: /^.{10001,}$/s },
  { name: 'Encoded Payload', pattern: /%[0-9a-f]{2}%[0-9a-f]{2}%[0-9a-f]{2}/i },
  { name: 'Unicode Abuse', pattern: /[\u200b-\u200f\u2028-\u202f\ufeff]/g },
  { name: 'Base64 Block', pattern: /[A-Za-z0-9+\/]{50,}={0,2}/g }
];

function threatScan(input) {
  var str = String(input);
  scanCount++;
  var threats = [];
  var riskScore = 0;
  for (var i = 0; i < THREAT_PATTERNS.length; i++) {
    var tp = THREAT_PATTERNS[i];
    var re = new RegExp(tp.pattern.source, tp.pattern.flags);
    if (re.test(str)) {
      threats.push({ name: tp.name, severity: i < 6 ? 'high' : 'medium' });
      riskScore += i < 6 ? 25 : 10;
    }
  }
  riskScore = Math.min(riskScore, 100);
  return {
    clean: threats.length === 0,
    threats: threats,
    riskScore: riskScore,
    riskLevel: riskScore === 0 ? 'none' : riskScore < 30 ? 'low' : riskScore < 60 ? 'medium' : 'high',
    inputLength: str.length,
    entropy: shannonEntropy(str).entropy,
    scanId: scanCount,
    timestamp: Date.now()
  };
}

function validateToken(token) {
  var str = String(token);
  var issues = [];
  if (str.length < 16) issues.push('Token too short (min 16 chars)');
  if (str.length > 4096) issues.push('Token too long (max 4096 chars)');

  var parts = str.split('.');
  var isJWTFormat = parts.length === 3;
  if (isJWTFormat) {
    for (var i = 0; i < 3; i++) {
      if (!/^[A-Za-z0-9_-]+$/.test(parts[i])) {
        issues.push('JWT part ' + (i + 1) + ' contains invalid characters');
      }
    }
  }
  var ent = shannonEntropy(str);
  if (ent.normalized < 0.5) issues.push('Low entropy — possibly predictable');

  return {
    valid: issues.length === 0,
    format: isJWTFormat ? 'JWT-like' : 'opaque',
    length: str.length,
    entropy: ent.entropy,
    normalizedEntropy: ent.normalized,
    issues: issues,
    timestamp: Date.now()
  };
}

self.onmessage = function (e) {
  var msg = e.data;
  switch (msg.type) {
    case 'hash':
      self.postMessage({ type: 'result', action: 'hash', data: hashInput(msg.input) });
      break;
    case 'entropy':
      self.postMessage({ type: 'result', action: 'entropy', data: shannonEntropy(String(msg.input)) });
      break;
    case 'scan':
      self.postMessage({ type: 'result', action: 'scan', data: threatScan(msg.input) });
      break;
    case 'validate':
      self.postMessage({ type: 'result', action: 'validate', data: validateToken(msg.token) });
      break;
    case 'status':
      self.postMessage({
        type: 'status',
        name: NAME,
        uptime: Date.now() - BOOT_TIME,
        beat: beat,
        totalScans: scanCount,
        threatPatternsLoaded: THREAT_PATTERNS.length
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
  engines: ['fnv1a-hashing', 'shannon-entropy', 'threat-scanner', 'token-validator'],
  capabilities: ['hash', 'entropy', 'scan', 'validate', 'status']
});
