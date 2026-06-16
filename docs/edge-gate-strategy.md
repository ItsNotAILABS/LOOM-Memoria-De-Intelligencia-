# Edge Gate Strategy — Complete Implementation Guide

## Overview

The Edge Gate Strategy (AIS-024) is a 3-layer DDoS prevention architecture that treats bot attacks as cascade failures and cuts them at the edge before they consume ICP canister cycles.

**Doctrine:** "Don't put the gate at the canister. Put it at the edge. Bots burn Cloudflare's CPU, not your cycles."

## Architecture

### 3-Layer Defense

```
┌─────────────────────────────────────────────────────────┐
│ Layer 1: Cloudflare Edge (VIGILIA + UMBRA)             │
│ - FREE tier: 100K requests/day                          │
│ - Pattern detection: 15+ rules, 8 threat types          │
│ - Auto-reject critical threats                          │
│ - Rate limiting per IP/fingerprint                      │
│ - Cloudflare absorbs the compute cost                   │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ Layer 2: Browser Shield (Client-Side)                   │
│ - Request signing & fingerprinting                      │
│ - Proof-of-work challenge solving                       │
│ - Client-side threat detection                          │
│ - Nonce generation                                       │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ Layer 3: Canister Coherence (ICP Backend)               │
│ - Signature validation                                   │
│ - Final threat check                                     │
│ - Circuit breaker monitoring                             │
│ - Near-zero cycles (traffic pre-filtered)               │
└─────────────────────────────────────────────────────────┘
```

## Components

### Backend Engines (Motoko)

1. **EdgeGateStrategy.mo** — Core strategy module
   - Threat classification (8 types)
   - Severity levels (5 tiers: benign → criticum)
   - Request validation
   - Cycle savings tracking
   - Manifest rendering

2. **VIGILIAEngine.mo** (AIS-006) — Innerweb Model
   - Pattern detection (15+ rules)
   - Rate limiting engine
   - Challenge generation
   - Auto-rejection logic
   - Frequency: φ Hz (1.618...)

3. **UMBRAEngine.mo** (AIS-022) — Sovereign Model
   - Behavioral analysis
   - Anomaly detection
   - Coordinated attack detection
   - ML-ready feature extraction
   - Frequency: φ² Hz (2.618...)

4. **IronveilCircuitBreaker.mo** (AIS-025) — Cascade Prevention
   - Circuit breaker (CLOSED/OPEN/HALF_OPEN)
   - Cascade detection
   - φ-based exponential backoff
   - Auto-recovery system
   - Frequency: φ³ Hz (4.236...)

### Frontend Components

5. **edge-gate-worker.js** — Browser Shield (Web Worker #22)
   - Request signing
   - Browser fingerprinting
   - PoW challenge solving
   - Client-side threat detection
   - Nonce generation

6. **organism-bridge.js** — Integration
   - Boots edge-gate worker
   - Provides `organism.edgeGate()` API
   - Event handling

### Edge Deployment

7. **cloudflare-workers/vigilia-edge.js** — Cloudflare Worker
   - VIGILIA pattern detection at edge
   - Rate limiting with KV (optional)
   - Request signing
   - Forward to canister with signatures

8. **cloudflare-workers/wrangler.toml** — Configuration
   - Worker settings
   - Environment variables
   - KV bindings (optional)

### Protocols

9. **protocol-papers.js** — Research Protocols
   - PROT-103: Edge Gate Strategy
   - PROT-104: VIGILIA Engine
   - PROT-105: UMBRA Engine
   - PROT-106: IRONVEIL Circuit Breaker

## Threat Types

The system classifies 8 threat categories:

1. **Injection** — SQL, Command, XSS attacks
2. **Exfiltration** — Path traversal, sensitive file access
3. **Manipulation** — JWT tampering, data corruption
4. **Deception** — Impersonation, spoofing
5. **Denial** — DDoS, resource exhaustion
6. **Escalation** — Privilege escalation attempts
7. **Persistence** — Backdoor installation
8. **Lateral Movement** — Network traversal attempts

## Severity Levels

```
benign → suspectum → medium → altum → CRITICUM
  ↓          ↓          ↓        ↓        ↓
Pass    Monitor    Challenge  Strict   Reject
```

## Deployment

### 1. Deploy Cloudflare Worker

```bash
cd cloudflare-workers
npm install -g wrangler
wrangler login
wrangler deploy
```

Update `wrangler.toml` with your ICP canister URL.

### 2. Deploy ICP Canister

The backend engines are already integrated into `main.mo`. Deploy as usual:

```bash
dfx deploy
```

### 3. Frontend Integration

The edge-gate worker is automatically loaded by `organism-bridge.js`:

```javascript
// Boot the organism (includes edge-gate worker)
organism.boot();

// Sign a request before sending to canister
organism.edgeGate('sign_request', {
  payload: requestData,
  endpoint: '/api/endpoint'
});

// Solve a challenge if required
organism.edgeGate('solve_challenge', {
  challenge: challengeData
});
```

## API Endpoints (Canister)

### Edge Gate Strategy

```motoko
// Validate request with edge gate coherence check
edgeGateCoherenceCheck(
  edgeSignature: Text,
  browserSignature: Text,
  timestamp: Int,
  nonce: Text,
  payload: Text
) : async EdgeValidationResult

// Get threat patterns library
getEdgeGateThreatPatterns() : async [ThreatPattern]

// Estimate cycles saved
estimateEdgeGateCyclesSaved(
  totalRequests: Nat,
  blockedAtEdge: Nat,
  challengedAtBrowser: Nat
) : async Nat

// Get detection rules
getVIGILIADetectionRules() : async [DetectionRule]

// Generate challenge
generateVIGILIAChallenge(severity: Text) : async Challenge

// Manifests
renderEdgeGateManifest() : async Text
renderVIGILIAManifest() : async Text
renderUMBRAManifest() : async Text
renderIronveilManifest() : async Text
```

## Cycle Economics

### Without Edge Gate

```
1,000,000 bot requests × 100,000 cycles/request
= 100,000,000,000 cycles consumed
```

### With Edge Gate

```
Layer 1 (Cloudflare): 999,000 requests blocked = 0 cycles
Layer 2 (Browser): 900 challenges solved = 9,000,000 cycles
Layer 3 (Canister): 100 legitimate requests = 10,000,000 cycles
─────────────────────────────────────────────────────────
Total: 19,000,000 cycles (99.98% savings)
```

## Rate Limiting

- **Benign traffic**: 60 requests/minute
- **Suspicious traffic**: 10 requests/minute
- **Flood threshold**: 100 requests/minute → circuit breaker trips

## Circuit Breaker

### States

- **CLOSED**: Normal operation, all traffic flows
- **OPEN**: Circuit tripped, traffic blocked
- **HALF_OPEN**: Testing recovery, limited traffic

### Recovery

- Base time: 30 seconds
- Exponential backoff: `base_time × φⁿ` (n = recovery attempts)
- Max time: 10 minutes
- Test period: 60 seconds in HALF_OPEN

### Trip Conditions

- Request rate > 1000 req/sec
- Error rate > 50%
- Coordinated attack detected

## Performance

- **Cloudflare Edge**: <5ms latency per request
- **Browser Shield**: 10-50ms for signing/fingerprinting
- **PoW Challenges**: 100-500ms depending on difficulty
- **Canister Check**: <1ms (signature validation only)

## Security

### Edge Signatures

Every request forwarded from Cloudflare includes:
- `X-VIGILIA-Signature`: Edge signature
- `X-VIGILIA-Timestamp`: Nanosecond timestamp
- `X-VIGILIA-Nonce`: Unique nonce
- `X-VIGILIA-Severity`: Threat severity

### Browser Signatures

Every request from browser includes:
- Browser signature (fingerprint-based)
- Timestamp (within 60 second window)
- Nonce (replay prevention)
- Optional proof-of-work solution

### Validation

Canister validates:
1. Edge signature present and valid
2. Browser signature present and valid
3. Timestamps within acceptable window
4. Nonces are fresh (not replayed)
5. PoW solution correct (if challenge required)

## Monitoring

### Metrics to Track

- Total requests received
- Requests blocked at edge
- Challenges issued
- Circuit breaker trips
- Cycles saved
- Average latency

### Logs

All three layers log:
- Threat detections
- Rate limit violations
- Circuit breaker state changes
- Signature validation failures

## Testing

### Local Testing

```bash
# Test Cloudflare Worker locally
cd cloudflare-workers
wrangler dev

# Test browser worker
organism.edgeGate('status');

# Test canister endpoints
dfx canister call medina_backend renderEdgeGateManifest
```

### Simulating Attacks

```javascript
// Test SQL injection detection
organism.edgeGate('validate_local', {
  payload: "SELECT * FROM users WHERE id = 1 UNION SELECT * FROM passwords"
});

// Test rate limiting
for (let i = 0; i < 100; i++) {
  organism.edgeGate('sign_request', { payload: 'test', endpoint: '/api/test' });
}
```

## Best Practices

1. **Always validate on all 3 layers** — defense in depth
2. **Monitor circuit breaker state** — auto-recovery may fail
3. **Tune rate limits** — based on legitimate traffic patterns
4. **Update threat patterns** — as new attack vectors emerge
5. **Track cycle savings** — demonstrate ROI
6. **Challenge sparingly** — only for suspicious patterns
7. **Log everything** — for forensics and tuning

## Troubleshooting

### High False Positive Rate

- Review VIGILIA detection rules
- Adjust severity thresholds
- Tune rate limits higher

### Bots Still Reaching Canister

- Verify Cloudflare Worker is deployed
- Check edge signature validation
- Add more threat patterns

### Circuit Breaker Stuck Open

- Check recovery attempt count
- Verify error rate has dropped
- Manually reset if needed

## Attribution

Alfredo "Freddy" Medina Hernandez
Medina Tech | Dallas, TX

Protocol: AIS-024 (Edge Gate Strategy)
Frequencies: φ Hz (VIGILIA), φ² Hz (UMBRA), φ³ Hz (IRONVEIL)
Primitive: φ = 1.618... (Golden Ratio)

## References

- PROT-103: Edge Gate Strategy — 3-Layer DDoS Prevention Architecture
- PROT-104: VIGILIA Engine — Innerweb Model for Edge Pattern Detection
- PROT-105: UMBRA Engine — Sovereign Model for Advanced Threat Detection
- PROT-106: IRONVEIL Circuit Breaker — Cascade Attack Prevention System
- AIS-006: VIGILIA Specification
- AIS-022: UMBRA Specification
- AIS-024: Edge Gate Strategy Specification
- AIS-025: IRONVEIL Circuit Breaker Specification
