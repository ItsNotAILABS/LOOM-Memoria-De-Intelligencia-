# Edge Gate Strategy — Cloudflare Workers Deployment

This directory contains the Cloudflare Workers implementation of the VIGILIA Edge Gate Strategy.

## Architecture

**3-Layer Defense:**
1. **Cloudflare Edge (THIS LAYER)**: VIGILIA + UMBRA pattern detection
2. **Browser Shield**: Client-side validation and proof-of-work
3. **Canister Coherence**: Final verification on ICP

## Files

- `vigilia-edge.js` — Main Cloudflare Worker with VIGILIA pattern detection
- `wrangler.toml` — Configuration for Cloudflare deployment
- `README.md` — This file

## Deployment

### Prerequisites

```bash
npm install -g wrangler
wrangler login
```

### Deploy to Cloudflare

```bash
cd cloudflare-workers
wrangler deploy
```

### Test Locally

```bash
wrangler dev
```

## Configuration

Edit `wrangler.toml` to set:

- `ICP_CANISTER_URL`: Your ICP canister URL (e.g., `https://xxxxx-xxxxx-xxxxx-xxxxx-xxx.ic0.app`)
- `VIGILIA_KV`: Optional KV namespace for persistent rate limiting (requires paid plan)

## Free Tier

Cloudflare Workers free tier includes:
- **100,000 requests/day**
- **10ms CPU time per request**
- **No credit card required**

This is sufficient for most applications and provides **99.9%+ cycle cost reduction** by blocking bots at the edge.

## How It Works

1. **Request arrives** at Cloudflare edge
2. **VIGILIA scans** for 15+ threat patterns across 8 categories
3. **Rate limiting** applied per IP/fingerprint
4. **Auto-reject** critical threats (SQL injection, command injection, etc.)
5. **Challenge** suspicious requests (requires browser proof-of-work)
6. **Forward valid** requests to ICP canister with edge signature
7. **Canister validates** signature and performs final coherence check

## Threat Categories

- **Injection**: SQL, Command, XSS
- **Exfiltration**: Path traversal, sensitive files
- **Manipulation**: JWT tampering, prototype pollution
- **Deception**: Scanner detection, spoofing
- **Denial**: Flood attacks, large payloads
- **Escalation**: Privilege escalation attempts
- **Persistence**: Backdoor attempts
- **Lateral Movement**: Network traversal

## Severity Levels

1. **benign** → Normal traffic
2. **suspectum** → Suspicious, monitored
3. **medium** → Challenge required
4. **altum** → High threat, strict validation
5. **criticum** → Critical, auto-reject

## Cycle Economics

**Without Edge Gate:**
- 1M bot requests × 100K cycles/request = 100B cycles consumed

**With Edge Gate:**
- 1M bot requests blocked at Cloudflare = 0 cycles
- Only ~1K legitimate requests reach canister = 100M cycles
- **Savings: 99.9%+ reduction**

## Attribution

Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX

Protocol: AIS-024 (Edge Gate Strategy)
Frequency: φ Hz (1.618...)
Primitive: φ = Golden Ratio
