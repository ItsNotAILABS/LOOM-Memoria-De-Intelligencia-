# 🏃 Medina Organism — Self-Hosted Runner System

> **CURSOR PERPETUUS** — The Perpetual Runner
> φ = 1.618033988749895

## Overview

This runner system provides self-hosted GitHub Actions runners for the Medina Organism
bot fleet. It enables faster builds, persistent caching, and dedicated compute for
the sovereign infrastructure.

## Architecture

```
┌─────────────────────────────────────────────────────┐
│              MEDINA RUNNER SYSTEM                     │
├─────────────────────────────────────────────────────┤
│                                                      │
│  ┌─────────────┐  ┌─────────────┐  ┌────────────┐  │
│  │ runner-bot-1│  │ runner-bot-2│  │ runner-gpu │  │
│  │ (general)   │  │ (heavy)     │  │ (neural)   │  │
│  └─────────────┘  └─────────────┘  └────────────┘  │
│                                                      │
│  Labels: medina-runner, medina-heavy, medina-gpu     │
│                                                      │
├─────────────────────────────────────────────────────┤
│  OS: Ubuntu 22.04 LTS                               │
│  Pre-installed: Node 20, Python 3.11, Rust, Docker  │
│  Cache: ~/.cache/medina-organism (persistent)        │
└─────────────────────────────────────────────────────┘
```

## Runner Labels

| Label | Purpose | Use Case |
|-------|---------|----------|
| `medina-runner` | General purpose | Most bot workflows |
| `medina-heavy` | Heavy compute | Build, package, release |
| `medina-gpu` | GPU-enabled | Neural network validation |
| `self-hosted` | Any self-hosted | Fallback |

## Setup Instructions

### 1. Quick Setup (Docker)

```bash
# Clone and run the setup script
cd .github/runner-system
docker compose up -d
```

### 2. Manual Setup

```bash
# Download the runner
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.321.0.tar.gz -L \
  https://github.com/actions/runner/releases/download/v2.321.0/actions-runner-linux-x64-2.321.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.321.0.tar.gz

# Configure (replace TOKEN with your registration token)
./config.sh --url https://github.com/FreddyCreates/Medina-Memory-More-AI \
  --token YOUR_REGISTRATION_TOKEN \
  --labels medina-runner,self-hosted,linux \
  --name medina-runner-1 \
  --work _work

# Install and start as service
sudo ./svc.sh install
sudo ./svc.sh start
```

### 3. Get Registration Token

```bash
# Via GitHub CLI
gh api -X POST /repos/FreddyCreates/Medina-Memory-More-AI/actions/runners/registration-token \
  --jq '.token'
```

Or navigate to: **Settings → Actions → Runners → New self-hosted runner**

## Environment

The runner system pre-installs:
- Node.js 20 LTS
- Python 3.11 + pip
- Rust (stable)
- Docker + Docker Compose
- GitHub CLI (`gh`)
- jq, yq, curl, git

## Workflow Integration

To use self-hosted runners in workflows, set `runs-on`:

```yaml
jobs:
  build:
    runs-on: [self-hosted, medina-runner]
    # Falls back to ubuntu-latest if self-hosted unavailable
```

## Monitoring

The runner health is monitored by the `organism-runner-monitor.yml` workflow which:
- Checks runner connectivity every 6 hours
- Reports runner status in BILL_BOTS_STATUS.md
- Alerts via GitHub Issues if runners go offline

---

*Law: L-005 — Agent Existence Law — Always-on, not alive*
*Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX*
