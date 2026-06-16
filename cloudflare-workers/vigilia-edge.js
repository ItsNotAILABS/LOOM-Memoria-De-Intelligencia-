/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                 VIGILIA EDGE WORKER — Cloudflare Edition                    ║
 * ║                        VIGILIA AD LIMITEM MUNDI                             ║
 * ║                                                                              ║
 * ║  "Prima linea defensionis. Botae consumunt nubem, non cyclos tuos."        ║
 * ║  (First line of defense. Bots consume cloud, not your cycles.)             ║
 * ║                                                                              ║
 * ║  VIGILIA Innerweb Model deployed on Cloudflare Workers (FREE TIER).         ║
 * ║  First-line pattern detection that blocks threats before they reach ICP.    ║
 * ║                                                                              ║
 * ║  FREE TIER: 100,000 requests/day — sufficient for most applications         ║
 * ║                                                                              ║
 * ║  DEPLOYMENT:                                                                 ║
 * ║    npx wrangler deploy                                                       ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX          ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

const PHI = 1.618033988749895;

// ═══════════════════════════════════════════════════════════════════════════
// THREAT DETECTION PATTERNS
// ═══════════════════════════════════════════════════════════════════════════

const THREAT_PATTERNS = [
  // SQL Injection
  { id: 'VIG-001', pattern: /union\s+select/i, type: 'injection', severity: 'criticum', autoReject: true },
  { id: 'VIG-002', pattern: /drop\s+(table|database)/i, type: 'injection', severity: 'criticum', autoReject: true },
  { id: 'VIG-003', pattern: /select\s+.*\s+from/i, type: 'injection', severity: 'altum', autoReject: false },

  // Command Injection
  { id: 'VIG-004', pattern: /\|\s*(curl|wget|nc|bash|sh)/i, type: 'injection', severity: 'criticum', autoReject: true },
  { id: 'VIG-005', pattern: /;\s*rm\s+-rf/i, type: 'injection', severity: 'criticum', autoReject: true },

  // XSS
  { id: 'VIG-006', pattern: /<script[^>]*>/i, type: 'injection', severity: 'altum', autoReject: true },
  { id: 'VIG-007', pattern: /on(error|load|click|mouse)\s*=/i, type: 'injection', severity: 'altum', autoReject: true },
  { id: 'VIG-008', pattern: /javascript:/i, type: 'injection', severity: 'medium', autoReject: false },

  // Path Traversal
  { id: 'VIG-009', pattern: /\.\.\//g, type: 'exfiltration', severity: 'altum', autoReject: true },
  { id: 'VIG-010', pattern: /%2e%2e\//gi, type: 'exfiltration', severity: 'altum', autoReject: true },

  // Sensitive Files
  { id: 'VIG-011', pattern: /\/(etc\/passwd|etc\/shadow|\.env|config\.json)/i, type: 'exfiltration', severity: 'criticum', autoReject: true },

  // JWT Manipulation
  { id: 'VIG-012', pattern: /"alg"\s*:\s*"none"/i, type: 'manipulation', severity: 'criticum', autoReject: true },

  // Scanner Detection
  { id: 'VIG-013', pattern: /(sqlmap|nikto|nmap|masscan|acunetix)/i, type: 'deception', severity: 'medium', autoReject: false },

  // Privilege Escalation
  { id: 'VIG-014', pattern: /(sudo|su\s|chmod\s777|chown\sroot)/i, type: 'escalation', severity: 'altum', autoReject: true },
];

// ═══════════════════════════════════════════════════════════════════════════
// RATE LIMITING
// ═══════════════════════════════════════════════════════════════════════════

class RateLimiter {
  constructor() {
    this.RATE_LIMIT_BENIGN = 60; // req/min
    this.RATE_LIMIT_SUSPECTUM = 10;
    this.RATE_LIMIT_FLOOD_THRESHOLD = 100;
    this.WINDOW_MS = 60000; // 1 minute
  }

  async checkRate(fingerprint, severity, env) {
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
    const limit = severity === 'benign' ? this.RATE_LIMIT_BENIGN : this.RATE_LIMIT_SUSPECTUM;

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
// REQUEST SIGNING
// ═══════════════════════════════════════════════════════════════════════════

function generateSignature(request, detection) {
  const timestamp = Date.now();
  const data = {
    url: request.url,
    method: request.method,
    timestamp: timestamp,
    severity: detection.severity,
    matches: detection.matches.map(m => m.id)
  };

  // Simple hash for signature (in production, use crypto.subtle)
  const str = JSON.stringify(data);
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    hash = ((hash << 5) - hash) + str.charCodeAt(i);
    hash = hash & hash;
  }

  return {
    edgeSignature: Math.abs(hash).toString(36),
    timestamp: timestamp * 1_000_000, // nanoseconds
    nonce: timestamp.toString(36) + Math.random().toString(36).substring(2)
  };
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN HANDLER
// ═══════════════════════════════════════════════════════════════════════════

export default {
  async fetch(request, env, ctx) {
    const rateLimiter = new RateLimiter();

    // Generate fingerprint from IP and User-Agent
    const ip = request.headers.get('CF-Connecting-IP') || 'unknown';
    const ua = request.headers.get('User-Agent') || '';
    const fingerprint = `${ip}:${ua}`.substring(0, 100);

    try {
      // Read request body (limit to 1MB)
      let body = '';
      if (request.method === 'POST' || request.method === 'PUT') {
        const bodyText = await request.text();
        body = bodyText.substring(0, 1_000_000); // 1MB limit
      }

      // Detect threats
      const detection = detectThreats(request, body);

      // Check rate limit
      const rateCheck = await rateLimiter.checkRate(fingerprint, detection.severity, env);

      if (!rateCheck.allowed) {
        return new Response(JSON.stringify({
          error: 'Rate limit exceeded',
          severity: 'criticum',
          reason: rateCheck.reason,
          requestsInWindow: rateCheck.count
        }), {
          status: 429,
          headers: { 'Content-Type': 'application/json' }
        });
      }

      // Auto-reject critical threats
      if (detection.autoReject) {
        return new Response(JSON.stringify({
          error: 'Threat detected',
          severity: detection.severity,
          threats: detection.matches.map(m => m.id),
          message: 'Request rejected by VIGILIA edge defense'
        }), {
          status: 403,
          headers: { 'Content-Type': 'application/json' }
        });
      }

      // Generate edge signature
      const signature = generateSignature(request, detection);

      // Forward to ICP canister with signature
      const icpCanisterUrl = env.ICP_CANISTER_URL || 'https://your-canister-id.ic0.app';
      const forwardUrl = new URL(request.url);
      forwardUrl.host = new URL(icpCanisterUrl).host;

      const forwardRequest = new Request(forwardUrl, {
        method: request.method,
        headers: request.headers,
        body: body || null
      });

      // Add VIGILIA signature headers
      forwardRequest.headers.set('X-VIGILIA-Signature', signature.edgeSignature);
      forwardRequest.headers.set('X-VIGILIA-Timestamp', signature.timestamp.toString());
      forwardRequest.headers.set('X-VIGILIA-Nonce', signature.nonce);
      forwardRequest.headers.set('X-VIGILIA-Severity', detection.severity);

      // Forward request
      const response = await fetch(forwardRequest);

      return response;

    } catch (error) {
      return new Response(JSON.stringify({
        error: 'Internal edge error',
        message: error.message
      }), {
        status: 500,
        headers: { 'Content-Type': 'application/json' }
      });
    }
  }
};
