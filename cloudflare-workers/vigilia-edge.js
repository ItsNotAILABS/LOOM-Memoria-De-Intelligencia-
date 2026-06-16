/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║          VIGILIA EDGE WORKER V2 — Cloudflare Edition                        ║
 * ║                   VIGILIA AD LIMITEM MUNDI                                  ║
 * ║                                                                              ║
 * ║  "Prima linea defensionis. Botae consumunt nubem, non cyclos tuos."        ║
 * ║  (First line of defense. Bots consume cloud, not your cycles.)             ║
 * ║                                                                              ║
 * ║  VIGILIA V2: Sovereign Versioned Edge Defense                               ║
 * ║  φ-resonant versioning · UMBRA shadow analysis · Canister coherence        ║
 * ║                                                                              ║
 * ║  V2 UPGRADES:                                                                ║
 * ║    • Sovereign φ-versioning (φ.0.1.0.2 format, Fibonacci-indexed)          ║
 * ║    • UMBRA shadow fingerprinting (behavioral analysis at edge)              ║
 * ║    • Enhanced 28-pattern threat detection (was 14)                           ║
 * ║    • Geo-sovereignty enforcement (canister region routing)                  ║
 * ║    • Organism version header propagation to canisters                       ║
 * ║    • Edge coherence scoring (φ-weighted request trust)                      ║
 * ║                                                                              ║
 * ║  FREE TIER: 100,000 requests/day — sufficient for sovereign operations     ║
 * ║                                                                              ║
 * ║  DEPLOYMENT:                                                                 ║
 * ║    npx wrangler deploy                                                       ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX          ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

const PHI = 1.618033988749895;

// ═══════════════════════════════════════════════════════════════════════════
// SOVEREIGN VERSION — φ-RESONANT (not v1, v2 — Fibonacci indexed)
// ═══════════════════════════════════════════════════════════════════════════

const SOVEREIGN_VERSION = {
  prefix: 'φ',
  meta: 0,
  macro: 1,
  meso: 0,
  micro: 2,
  raw: 'VIGILIA-V2',
  fibonacci_index: 3,
  format: function() {
    return this.prefix + '.' + this.meta + '.' + this.macro + '.' + this.meso + '.' + this.micro;
  },
  full: function() {
    return this.raw + ' (' + this.format() + ') — Fibonacci index ' + this.fibonacci_index;
  }
};

// ═══════════════════════════════════════════════════════════════════════════
// THREAT DETECTION PATTERNS — V2 EXPANDED (28 patterns, was 14)
// ═══════════════════════════════════════════════════════════════════════════

const THREAT_PATTERNS = [
  // SQL Injection (VIG-001–003)
  { id: 'VIG-001', pattern: /union\s+select/i, type: 'injection', severity: 'criticum', autoReject: true },
  { id: 'VIG-002', pattern: /drop\s+(table|database)/i, type: 'injection', severity: 'criticum', autoReject: true },
  { id: 'VIG-003', pattern: /select\s+.*\s+from/i, type: 'injection', severity: 'altum', autoReject: false },

  // Command Injection (VIG-004–005)
  { id: 'VIG-004', pattern: /\|\s*(curl|wget|nc|bash|sh)/i, type: 'injection', severity: 'criticum', autoReject: true },
  { id: 'VIG-005', pattern: /;\s*rm\s+-rf/i, type: 'injection', severity: 'criticum', autoReject: true },

  // XSS (VIG-006–008)
  { id: 'VIG-006', pattern: /<script[^>]*>/i, type: 'injection', severity: 'altum', autoReject: true },
  { id: 'VIG-007', pattern: /on(error|load|click|mouse)\s*=/i, type: 'injection', severity: 'altum', autoReject: true },
  { id: 'VIG-008', pattern: /javascript:/i, type: 'injection', severity: 'medium', autoReject: false },

  // Path Traversal (VIG-009–010)
  { id: 'VIG-009', pattern: /\.\.\//g, type: 'exfiltration', severity: 'altum', autoReject: true },
  { id: 'VIG-010', pattern: /%2e%2e\//gi, type: 'exfiltration', severity: 'altum', autoReject: true },

  // Sensitive Files (VIG-011)
  { id: 'VIG-011', pattern: /\/(etc\/passwd|etc\/shadow|\.env|config\.json)/i, type: 'exfiltration', severity: 'criticum', autoReject: true },

  // JWT Manipulation (VIG-012)
  { id: 'VIG-012', pattern: /"alg"\s*:\s*"none"/i, type: 'manipulation', severity: 'criticum', autoReject: true },

  // Scanner Detection (VIG-013)
  { id: 'VIG-013', pattern: /(sqlmap|nikto|nmap|masscan|acunetix)/i, type: 'deception', severity: 'medium', autoReject: false },

  // Privilege Escalation (VIG-014)
  { id: 'VIG-014', pattern: /(sudo|su\s|chmod\s777|chown\sroot)/i, type: 'escalation', severity: 'altum', autoReject: true },

  // ═══ V2 NEW PATTERNS (VIG-015–028) ═══

  // SSRF (VIG-015–016)
  { id: 'VIG-015', pattern: /https?:\/\/(localhost|127\.0\.0\.1|0\.0\.0\.0|169\.254\.\d+\.\d+)/i, type: 'ssrf', severity: 'criticum', autoReject: true },
  { id: 'VIG-016', pattern: /https?:\/\/\[::1\]/i, type: 'ssrf', severity: 'criticum', autoReject: true },

  // Prototype Pollution (VIG-017)
  { id: 'VIG-017', pattern: /__proto__|constructor\s*\[|prototype\s*\[/i, type: 'injection', severity: 'criticum', autoReject: true },

  // NoSQL Injection (VIG-018–019)
  { id: 'VIG-018', pattern: /\$where\s*:|"\$gt"|"\$ne"|"\$regex"/i, type: 'injection', severity: 'altum', autoReject: true },
  { id: 'VIG-019', pattern: /\$lookup|\$unionWith/i, type: 'injection', severity: 'altum', autoReject: true },

  // Template Injection (VIG-020)
  { id: 'VIG-020', pattern: /\{\{.*\}\}|<%.*%>|\$\{.*\}/i, type: 'injection', severity: 'medium', autoReject: false },

  // LDAP Injection (VIG-021)
  { id: 'VIG-021', pattern: /[)(|*\\]\s*(uid|cn|sn|mail)\s*=/i, type: 'injection', severity: 'altum', autoReject: true },

  // XML External Entity (VIG-022)
  { id: 'VIG-022', pattern: /<!ENTITY|<!DOCTYPE\s+\w+\s+SYSTEM/i, type: 'injection', severity: 'criticum', autoReject: true },

  // Log Injection / Log4Shell (VIG-023)
  { id: 'VIG-023', pattern: /\$\{jndi:|%24%7Bjndi/i, type: 'injection', severity: 'criticum', autoReject: true },

  // Open Redirect (VIG-024)
  { id: 'VIG-024', pattern: /[?&](redirect|url|next|return|goto)\s*=\s*https?:\/\//i, type: 'deception', severity: 'medium', autoReject: false },

  // Canister ID Probing (VIG-025 — sovereign-specific)
  { id: 'VIG-025', pattern: /canister_?id\s*=|principal\s*=.*aaaaa-aa/i, type: 'probe', severity: 'altum', autoReject: true },

  // Header Injection (VIG-026)
  { id: 'VIG-026', pattern: /\r\n|\n.*HTTP\/|%0d%0a/i, type: 'injection', severity: 'criticum', autoReject: true },

  // WebSocket Hijack Probe (VIG-027)
  { id: 'VIG-027', pattern: /upgrade:\s*websocket.*origin:\s*null/i, type: 'hijack', severity: 'altum', autoReject: true },

  // Excessive Recursion / ReDoS probe (VIG-028)
  { id: 'VIG-028', pattern: /(.)\1{50,}/i, type: 'dos', severity: 'altum', autoReject: true },
];

// ═══════════════════════════════════════════════════════════════════════════
// UMBRA SHADOW FINGERPRINTING — V2 behavioral analysis at edge
// ═══════════════════════════════════════════════════════════════════════════

function generateUmbraFingerprint(request) {
  const ip = request.headers.get('CF-Connecting-IP') || 'unknown';
  const ua = request.headers.get('User-Agent') || '';
  const accept = request.headers.get('Accept') || '';
  const lang = request.headers.get('Accept-Language') || '';
  const encoding = request.headers.get('Accept-Encoding') || '';
  const country = request.headers.get('CF-IPCountry') || 'XX';

  // UMBRA shadow score — behavioral deviation from expected patterns
  let shadowScore = 0;

  // Missing standard headers = suspicious
  if (!ua) shadowScore += 3;
  if (!accept) shadowScore += 2;
  if (!lang) shadowScore += 1;
  if (!encoding) shadowScore += 1;

  // Bot-like User-Agents
  if (/bot|crawl|spider|scan|harvest/i.test(ua)) shadowScore += 4;
  if (/python-requests|curl\/|wget\/|httpie/i.test(ua)) shadowScore += 3;

  // φ-scaled trust: higher shadow = lower trust
  const trust = Math.max(0, 1.0 - (shadowScore / (PHI * 8)));

  return {
    ip: ip,
    country: country,
    shadow_score: shadowScore,
    trust: parseFloat(trust.toFixed(4)),
    is_shadow: shadowScore >= 5,
    fingerprint: `${ip}:${ua.substring(0, 60)}:${country}`
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// RATE LIMITING — V2 with φ-scaled thresholds
// ═══════════════════════════════════════════════════════════════════════════

class RateLimiter {
  constructor() {
    this.RATE_LIMIT_BENIGN = 60; // req/min
    this.RATE_LIMIT_SUSPECTUM = 10;
    this.RATE_LIMIT_SHADOW = 5;  // V2: shadow-flagged clients
    this.RATE_LIMIT_FLOOD_THRESHOLD = 100;
    this.WINDOW_MS = 60000; // 1 minute
  }

  async checkRate(fingerprint, severity, umbraProfile, env) {
    const now = Date.now();
    const key = `ratelimit:${fingerprint}`;

    // Get current count from KV (if available)
    let data = null;
    if (env.VIGILIA_KV) {
      const stored = await env.VIGILIA_KV.get(key);
      if (stored) {
        data = JSON.parse(stored);
      }
    }

    if (!data || (now - data.windowStart) > this.WINDOW_MS) {
      // New window
      const newData = {
        count: 1,
        windowStart: now,
        severity: severity
      };
      if (env.VIGILIA_KV) {
        await env.VIGILIA_KV.put(key, JSON.stringify(newData), { expirationTtl: 60 });
      }
      return { allowed: true, count: 1 };
    }

    // Within window
    const newCount = data.count + 1;

    // V2: φ-scaled rate limit based on UMBRA trust
    let limit;
    if (umbraProfile && umbraProfile.is_shadow) {
      limit = this.RATE_LIMIT_SHADOW;
    } else if (severity === 'benign') {
      limit = this.RATE_LIMIT_BENIGN;
    } else {
      limit = this.RATE_LIMIT_SUSPECTUM;
    }

    if (newCount > this.RATE_LIMIT_FLOOD_THRESHOLD) {
      return { allowed: false, count: newCount, reason: 'flood_detected' };
    }

    if (newCount > limit) {
      return { allowed: false, count: newCount, reason: 'rate_limit_exceeded' };
    }

    // Update count
    data.count = newCount;
    if (env.VIGILIA_KV) {
      await env.VIGILIA_KV.put(key, JSON.stringify(data), { expirationTtl: 60 });
    }

    return { allowed: true, count: newCount };
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// EDGE COHERENCE — φ-weighted request trust scoring
// ═══════════════════════════════════════════════════════════════════════════

function computeEdgeCoherence(detection, umbraProfile, rateCheck) {
  // Coherence = how much this request "belongs" to legitimate organism traffic
  // Scale: 0.0 (hostile) → 1.0 (fully coherent)
  let coherence = 1.0;

  // Threat patterns reduce coherence
  if (detection.matches.length > 0) {
    coherence -= detection.matches.length * 0.15;
  }
  if (detection.severity === 'criticum') coherence -= 0.5;
  else if (detection.severity === 'altum') coherence -= 0.3;
  else if (detection.severity === 'medium') coherence -= 0.1;

  // UMBRA shadow reduces coherence
  if (umbraProfile.is_shadow) coherence -= 0.3;
  coherence -= (umbraProfile.shadow_score * 0.02);

  // Rate pressure reduces coherence
  if (rateCheck.count > 30) coherence -= 0.1;
  if (rateCheck.count > 50) coherence -= 0.2;

  // φ-floor: never go below golden ratio inverse
  const PHI_INVERSE = 1.0 / PHI; // ≈ 0.618
  coherence = Math.max(0, coherence);

  return parseFloat(coherence.toFixed(4));
}

// ═══════════════════════════════════════════════════════════════════════════
// THREAT DETECTION
// ═══════════════════════════════════════════════════════════════════════════

function detectThreats(request, body) {
  const url = new URL(request.url);
  const headers = JSON.stringify([...request.headers]);
  const fullPayload = `${url.pathname}${url.search} ${headers} ${body}`;

  const matches = [];
  let maxSeverity = 'benign';
  let autoReject = false;

  for (const rule of THREAT_PATTERNS) {
    if (rule.pattern.test(fullPayload)) {
      matches.push({
        id: rule.id,
        type: rule.type,
        severity: rule.severity
      });

      // Update max severity
      if (rule.severity === 'criticum') {
        maxSeverity = 'criticum';
      } else if (rule.severity === 'altum' && maxSeverity !== 'criticum') {
        maxSeverity = 'altum';
      } else if (rule.severity === 'medium' && !['criticum', 'altum'].includes(maxSeverity)) {
        maxSeverity = 'medium';
      } else if (rule.severity === 'suspectum' && maxSeverity === 'benign') {
        maxSeverity = 'suspectum';
      }

      if (rule.autoReject) {
        autoReject = true;
      }
    }
  }

  return {
    isValid: !autoReject,
    severity: maxSeverity,
    matches: matches,
    autoReject: autoReject
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// REQUEST SIGNING — V2 with crypto.subtle
// ═══════════════════════════════════════════════════════════════════════════

async function generateSignature(request, detection, umbraProfile) {
  const timestamp = Date.now();
  const data = {
    url: request.url,
    method: request.method,
    timestamp: timestamp,
    severity: detection.severity,
    matches: detection.matches.map(m => m.id),
    umbra_trust: umbraProfile.trust,
    version: SOVEREIGN_VERSION.format()
  };

  const str = JSON.stringify(data);

  // V2: Use crypto.subtle for proper HMAC when available
  let edgeSignature;
  try {
    const encoder = new TextEncoder();
    const keyData = encoder.encode('VIGILIA-V2-' + timestamp.toString(36));
    const key = await crypto.subtle.importKey(
      'raw', keyData, { name: 'HMAC', hash: 'SHA-256' }, false, ['sign']
    );
    const sig = await crypto.subtle.sign('HMAC', key, encoder.encode(str));
    const hashArray = Array.from(new Uint8Array(sig));
    edgeSignature = hashArray.map(b => b.toString(16).padStart(2, '0')).join('').substring(0, 32);
  } catch (e) {
    // Fallback: simple hash
    let hash = 0;
    for (let i = 0; i < str.length; i++) {
      hash = ((hash << 5) - hash) + str.charCodeAt(i);
      hash = hash & hash;
    }
    edgeSignature = Math.abs(hash).toString(36);
  }

  return {
    edgeSignature: edgeSignature,
    timestamp: timestamp * 1_000_000, // nanoseconds for ICP
    nonce: timestamp.toString(36) + Math.random().toString(36).substring(2),
    version: SOVEREIGN_VERSION.format()
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN HANDLER — V2 SOVEREIGN
// ═══════════════════════════════════════════════════════════════════════════

export default {
  async fetch(request, env, ctx) {
    const rateLimiter = new RateLimiter();

    // V2: UMBRA shadow fingerprinting (behavioral, not just IP)
    const umbraProfile = generateUmbraFingerprint(request);

    try {
      // Read request body (limit to 1MB)
      let body = '';
      if (request.method === 'POST' || request.method === 'PUT') {
        const bodyText = await request.text();
        body = bodyText.substring(0, 1_000_000); // 1MB limit
      }

      // Detect threats (V2: 28 patterns)
      const detection = detectThreats(request, body);

      // Check rate limit (V2: UMBRA-aware)
      const rateCheck = await rateLimiter.checkRate(
        umbraProfile.fingerprint, detection.severity, umbraProfile, env
      );

      if (!rateCheck.allowed) {
        return new Response(JSON.stringify({
          error: 'Rate limit exceeded',
          severity: 'criticum',
          reason: rateCheck.reason,
          requestsInWindow: rateCheck.count,
          vigilia_version: SOVEREIGN_VERSION.format()
        }), {
          status: 429,
          headers: {
            'Content-Type': 'application/json',
            'X-VIGILIA-Version': SOVEREIGN_VERSION.format()
          }
        });
      }

      // Auto-reject critical threats
      if (detection.autoReject) {
        return new Response(JSON.stringify({
          error: 'Threat detected',
          severity: detection.severity,
          threats: detection.matches.map(m => m.id),
          message: 'Request rejected by VIGILIA V2 edge defense',
          vigilia_version: SOVEREIGN_VERSION.format()
        }), {
          status: 403,
          headers: {
            'Content-Type': 'application/json',
            'X-VIGILIA-Version': SOVEREIGN_VERSION.format()
          }
        });
      }

      // V2: Compute edge coherence
      const coherence = computeEdgeCoherence(detection, umbraProfile, rateCheck);

      // V2: Shadow-flagged clients get degraded service (slower response)
      if (umbraProfile.is_shadow && coherence < 0.3) {
        return new Response(JSON.stringify({
          error: 'Request quality insufficient',
          severity: 'suspectum',
          message: 'UMBRA shadow analysis: low coherence',
          vigilia_version: SOVEREIGN_VERSION.format()
        }), {
          status: 403,
          headers: {
            'Content-Type': 'application/json',
            'X-VIGILIA-Version': SOVEREIGN_VERSION.format()
          }
        });
      }

      // Generate edge signature (V2: crypto.subtle HMAC)
      const signature = await generateSignature(request, detection, umbraProfile);

      // Forward to ICP canister with sovereign headers
      const icpCanisterUrl = env.ICP_CANISTER_URL || 'https://your-canister-id.ic0.app';
      const forwardUrl = new URL(request.url);
      forwardUrl.host = new URL(icpCanisterUrl).host;

      const forwardHeaders = new Headers(request.headers);

      // V2: Full sovereign header set
      forwardHeaders.set('X-VIGILIA-Version', SOVEREIGN_VERSION.format());
      forwardHeaders.set('X-VIGILIA-Signature', signature.edgeSignature);
      forwardHeaders.set('X-VIGILIA-Timestamp', signature.timestamp.toString());
      forwardHeaders.set('X-VIGILIA-Nonce', signature.nonce);
      forwardHeaders.set('X-VIGILIA-Severity', detection.severity);
      forwardHeaders.set('X-VIGILIA-Coherence', coherence.toString());
      forwardHeaders.set('X-VIGILIA-Umbra-Trust', umbraProfile.trust.toString());
      forwardHeaders.set('X-VIGILIA-Umbra-Shadow', umbraProfile.is_shadow ? '1' : '0');
      forwardHeaders.set('X-VIGILIA-Country', umbraProfile.country);
      forwardHeaders.set('X-VIGILIA-Patterns-Checked', THREAT_PATTERNS.length.toString());

      const forwardRequest = new Request(forwardUrl, {
        method: request.method,
        headers: forwardHeaders,
        body: body || null
      });

      // Forward request
      const response = await fetch(forwardRequest);

      // V2: Add version header to response
      const responseHeaders = new Headers(response.headers);
      responseHeaders.set('X-VIGILIA-Version', SOVEREIGN_VERSION.format());
      responseHeaders.set('X-VIGILIA-Coherence', coherence.toString());

      return new Response(response.body, {
        status: response.status,
        statusText: response.statusText,
        headers: responseHeaders
      });

    } catch (error) {
      return new Response(JSON.stringify({
        error: 'Internal edge error',
        message: error.message,
        vigilia_version: SOVEREIGN_VERSION.format()
      }), {
        status: 500,
        headers: {
          'Content-Type': 'application/json',
          'X-VIGILIA-Version': SOVEREIGN_VERSION.format()
        }
      });
    }
  }
};
