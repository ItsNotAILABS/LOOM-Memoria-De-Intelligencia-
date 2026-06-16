#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
# MEDINA RUNNER SYSTEM — Setup Script
# Provisions a self-hosted GitHub Actions runner for the Organism
#
# Usage:
#   bash .github/runner-system/setup-runner.sh \
#     --token <REGISTRATION_TOKEN> \
#     --name <runner-name> \
#     --labels <comma-separated-labels>
#
# Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
# ═══════════════════════════════════════════════════════════════════════════

set -euo pipefail

# ── Defaults ──────────────────────────────────────────────────────────────
RUNNER_VERSION="2.321.0"
REPO_URL="https://github.com/FreddyCreates/Medina-Memory-More-AI"
RUNNER_DIR="${HOME}/actions-runner"
RUNNER_NAME="medina-runner-$(hostname)"
RUNNER_LABELS="medina-runner,self-hosted,linux,x64"
RUNNER_TOKEN=""

# ── Parse Arguments ───────────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
    case $1 in
        --token)  RUNNER_TOKEN="$2"; shift 2 ;;
        --name)   RUNNER_NAME="$2"; shift 2 ;;
        --labels) RUNNER_LABELS="$2"; shift 2 ;;
        --dir)    RUNNER_DIR="$2"; shift 2 ;;
        *)        echo "Unknown option: $1"; exit 1 ;;
    esac
done

if [ -z "$RUNNER_TOKEN" ]; then
    echo "Error: --token is required"
    echo ""
    echo "Get a token with:"
    echo "  gh api -X POST /repos/FreddyCreates/Medina-Memory-More-AI/actions/runners/registration-token --jq '.token'"
    exit 1
fi

# ── Banner ────────────────────────────────────────────────────────────────
echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║          MEDINA RUNNER SYSTEM — Setup                    ║"
echo "║     φ = 1.618033988749895                                ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo "  Runner:  $RUNNER_NAME"
echo "  Labels:  $RUNNER_LABELS"
echo "  Dir:     $RUNNER_DIR"
echo ""

# ── Install Dependencies ──────────────────────────────────────────────────
echo "Installing system dependencies..."
sudo apt-get update -qq
sudo apt-get install -y -qq curl jq git docker.io nodejs npm python3 python3-pip

# Install Node 20
if ! node --version 2>/dev/null | grep -q "v20"; then
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y -qq nodejs
fi

# ── Download Runner ───────────────────────────────────────────────────────
echo "Downloading GitHub Actions Runner v${RUNNER_VERSION}..."
mkdir -p "$RUNNER_DIR"
cd "$RUNNER_DIR"

TARBALL="actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"
if [ ! -f "$TARBALL" ]; then
    curl -sL -o "$TARBALL" \
        "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/${TARBALL}"
fi
tar xzf "$TARBALL"

# ── Configure Runner ─────────────────────────────────────────────────────
echo "Configuring runner..."
./config.sh \
    --url "$REPO_URL" \
    --token "$RUNNER_TOKEN" \
    --name "$RUNNER_NAME" \
    --labels "$RUNNER_LABELS" \
    --work "_work" \
    --unattended \
    --replace

# ── Install as Service ────────────────────────────────────────────────────
echo "Installing runner as systemd service..."
sudo ./svc.sh install
sudo ./svc.sh start

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║   ✓ Runner installed and started successfully            ║"
echo "║   Name:   $RUNNER_NAME"
echo "║   Labels: $RUNNER_LABELS"
echo "║   φ = 1.618033988749895                                  ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
