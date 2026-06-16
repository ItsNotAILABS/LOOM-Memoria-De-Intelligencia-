# MEDINA ICP — Sovereign Memory-Operating Intelligence on Internet Computer

> Production-ready Motoko implementation of the MEDINA platform for the Internet Computer Protocol (ICP).

## Overview

This is the ICP canister implementation of MEDINA — a sovereign memory-operating intelligence platform with:

- **Memory Temple** — Toroidal geometry workspace with lineage tracking
- **Universal Chat Control** — Command-based platform interaction
- **Built-in Governance** — Proposal-based decision workflow
- **Constitutional Foundation** — Non-collapsible doctrine hierarchy
- **Beat-Driven Orchestration** — Synchronized platform operations

## Architecture

### Canister Structure

```
icp/
├── dfx.json                     # DFX configuration
├── src/
│   ├── medina_backend/          # Main Motoko canister
│   │   ├── main.mo              # Platform actor (entry point)
│   │   ├── Types.mo             # Type definitions
│   │   ├── Utils.mo             # Utility functions
│   │   ├── Constitution.mo      # Doctrine registry
│   │   ├── MemoryTemple.mo      # Memory workspace
│   │   ├── Heartbeat.mo         # Beat orchestration
│   │   └── Governance.mo        # Proposal system
│   └── medina_frontend/         # Frontend assets
│       └── assets/
│           └── index.html       # Web interface
```

### Subsystems

| Module | Description |
|--------|-------------|
| **Constitution** | Non-collapsible doctrine hierarchy (Absolute → Product) |
| **MemoryTemple** | Toroidal coordinate memory storage with salience |
| **Heartbeat** | Beat-driven task orchestration |
| **Governance** | Proposal lifecycle management |

## Prerequisites

1. **Install DFX** (DFINITY SDK):
   ```bash
   sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
   ```

2. **Verify installation**:
   ```bash
   dfx --version
   ```

## Deployment

### Local Development

1. **Start local replica**:
   ```bash
   cd icp
   dfx start --background
   ```

2. **Deploy canisters**:
   ```bash
   dfx deploy
   ```

3. **Access the frontend**:
   - Open the URL shown in deploy output
   - Or use: `http://localhost:4943/?canisterId=$(dfx canister id medina_frontend)`

### Mainnet Deployment

1. **Get ICP for cycles**:
   - Acquire ICP tokens
   - Convert to cycles for canister operation

2. **Deploy to mainnet**:
   ```bash
   dfx deploy --network ic
   ```

3. **Note your canister IDs** for future interaction.

## Usage

### Command Interface

The platform provides a command-based interface:

```
/memory find <query>     — Search memories
/memory pin <id>         — Pin a memory
/memory map              — View memory topology
/govern status           — Governance status
/govern propose <title>  — Create proposal
/status                  — Platform status
/tick                    — Execute platform tick
/help                    — Show help
```

### Programmatic Access (Motoko/JavaScript)

```javascript
import { medina_backend } from "./declarations/medina_backend";

// Execute a command
const result = await medina_backend.execute("/status");

// Store a memory
const memory = await medina_backend.storeMemory(
  '{"data": "Important insight"}',
  "Key strategic insight",
  ["important", "strategy"],
  0.8
);

// Get platform status
const status = await medina_backend.status();

// Execute a tick
const metrics = await medina_backend.tick();
```

### Candid Interface

The full Candid interface is generated automatically. Key methods:

```candid
service : {
  // Platform
  status : () -> (PlatformStatus) query;
  healthCheck : () -> (HealthStatus) query;
  execute : (text) -> (CommandResult);
  tick : () -> (BeatMetrics);
  
  // Memory Temple
  storeMemory : (text, text, vec text, float64) -> (MemoryNode);
  getMemory : (text) -> (opt MemoryNode) query;
  findMemories : (MemoryQuery) -> (vec MemoryNode) query;
  searchMemories : (text, nat) -> (vec MemoryNode) query;
  pinMemory : (text) -> (bool);
  promoteMemory : (text, float64) -> (bool);
  
  // Constitution
  getDoctrineEntry : (text) -> (opt DoctrineEntry) query;
  listDoctrineKeys : () -> (vec text) query;
  validateConstitution : () -> (bool) query;
  
  // Governance
  createProposal : (text, text, ProposalCategory) -> (Proposal);
  getProposal : (text) -> (opt Proposal) query;
  voteOnProposal : (text, bool) -> (bool);
  listProposals : () -> (vec Proposal) query;
  
  // Heartbeat
  pauseHeartbeat : () -> ();
  resumeHeartbeat : () -> ();
  heartbeatStatus : () -> (HeartbeatStatus) query;
}
```

## Constitutional Laws

The platform enforces these non-negotiable laws:

1. **RECITAL_PLUS_ONE**: `state(n+1) = recital(validated_state_n) + one_lawful_expansion`
2. **FOUR REGISTERS**: All critical artifacts preserve Founder · Builder · Organism · External
3. **DUAL READ ALWAYS-ON**: semantic_read + resonance_read are both mandatory
4. **NO-COLLAPSE ONTOLOGY**: Absolute ≠ Law ≠ Model ≠ Engine ≠ Core ≠ Module ≠ Lab ≠ Workforce ≠ Product
5. **AUTHORITY**: Core A = runtime truth, Core B = industrial/workforce execution
6. **GATES A/B/C**: Runtime · Workforce · Projection — No bypass

## Memory Temple Geometry

Memories are positioned in a toroidal coordinate system:

- **θ (theta)**: Angular position on helix [0, 2π)
- **φ (phi)**: Toroidal rotation [0, 2π)
- **depth**: Radial depth (salience indicator)
- **ring**: Memory ring index (temporal grouping)
- **beat**: Creation beat (discrete time)

Coordinates use φ-scaled advancement for natural cadence.

## Development

### Running Tests

```bash
cd icp
dfx start --background
dfx test
```

### Upgrading Canisters

State is preserved across upgrades via `stable` variables:

```bash
dfx deploy --upgrade-unchanged
```

### Canister Management

```bash
# Check canister status
dfx canister status medina_backend

# Get canister ID
dfx canister id medina_backend

# Stop canister
dfx canister stop medina_backend

# Delete canister
dfx canister delete medina_backend
```

## Cost Estimation

On ICP mainnet:
- **Storage**: ~$5/GB/year (stable memory)
- **Compute**: Cycles consumed per instruction
- **Initial deployment**: ~1-2T cycles recommended

## Security

- All state mutations require canister calls (authenticated)
- Principal-based access control for governance
- Stable storage persists across upgrades
- No external dependencies (pure Motoko)

## License

Proprietary — MEDINA Sovereign Architecture

---

**MEDINA V1 ICP** — Sovereign Memory-Operating Intelligence on the Internet Computer
