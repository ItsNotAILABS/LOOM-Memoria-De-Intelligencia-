#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
# MEDINA DEPLOY CANISTER — DEPLOYMENTUM CANISTRI
# "In catena immutabilis est." (On-chain it is immutable.)
#
# Deploy Motoko canister to ICP (local replica or mainnet).
# Usage: bash scripts/deploy-canister.sh [local|ic]
#
# Prerequisites:
#   - dfx CLI installed (https://internetcomputer.org/docs/current/developer-docs/setup/install)
#   - For mainnet: configured identity with cycles
#
# Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
# ═══════════════════════════════════════════════════════════════════════════

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NETWORK="${1:-local}"

RED='\033[0;31m'
GREEN='\033[0;32m'
GOLD='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo -e "${GOLD}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GOLD}║          MEDINA CANISTER DEPLOY — ${NETWORK}$(printf '%*s' $((20 - ${#NETWORK})) '')        ║${NC}"
echo -e "${GOLD}╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check dfx
if ! command -v dfx &>/dev/null; then
    echo -e "${RED}✗ dfx CLI not found${NC}"
    echo "  Install: sh -ci \"\$(curl -fsSL https://internetcomputer.org/install.sh)\""
    exit 1
fi

DFX_VER=$(dfx --version 2>/dev/null || echo "unknown")
echo -e "  ${GREEN}✓${NC} dfx ${DFX_VER}"

cd "$ROOT/icp"

case "$NETWORK" in
    local)
        echo -e "  ${CYAN}▸${NC} Starting local replica..."
        dfx start --background --clean 2>/dev/null || true
        echo -e "  ${CYAN}▸${NC} Deploying to local replica..."
        dfx deploy --network local
        echo ""
        echo -e "  ${GREEN}✓${NC} Canister deployed to local replica"
        echo -e "  ${CYAN}▸${NC} Backend ID: $(dfx canister --network local id medina_backend 2>/dev/null || echo 'pending')"
        ;;
    ic)
        echo -e "  ${CYAN}▸${NC} Deploying to ICP mainnet..."
        echo -e "  ${GOLD}⚠${NC} This requires cycles. Make sure your identity has sufficient balance."
        echo ""
        dfx deploy --network ic
        echo ""
        echo -e "  ${GREEN}✓${NC} Canister deployed to ICP mainnet"
        echo -e "  ${CYAN}▸${NC} Backend ID: $(dfx canister --network ic id medina_backend 2>/dev/null || echo 'pending')"
        ;;
    *)
        echo "Usage: bash scripts/deploy-canister.sh [local|ic]"
        exit 1
        ;;
esac

echo ""
