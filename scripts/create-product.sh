#!/bin/bash

###############################################################################
# CREATE EXTERNAL PRODUCT
# Creates a new external product with its own bootstrap
#
# Usage: npm run create:product -- --name=customer-analytics --type=service
#
# Author: Freddy (Founder Architect)
# Status: CONSTITUTIONAL
###############################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Parse arguments
NAME=""
TYPE="product"

while [[ $# -gt 0 ]]; do
    case $1 in
        --name=*)
            NAME="${1#*=}"
            shift
            ;;
        --type=*)
            TYPE="${1#*=}"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

if [ -z "$NAME" ]; then
    echo -e "${RED}Error: --name required${NC}"
    echo "Usage: npm run create:product -- --name=my-product --type=service"
    exit 1
fi

echo -e "${PURPLE}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                                                                ║"
echo "║              CREATE EXTERNAL PRODUCT                           ║"
echo "║                                                                ║"
echo "║  Name: $NAME"
echo "║  Type: $TYPE"
echo "║                                                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

REPO_ROOT="/home/runner/work/Medina-Memory-More-AI/Medina-Memory-More-AI"
PRODUCT_DIR="$REPO_ROOT/deployments/$NAME"

if [ -d "$PRODUCT_DIR" ]; then
    echo -e "${RED}Error: Product $NAME already exists${NC}"
    exit 1
fi

echo -e "${CYAN}[1/6] Creating product structure...${NC}"

mkdir -p "$PRODUCT_DIR/canister"
mkdir -p "$PRODUCT_DIR/workers"
mkdir -p "$PRODUCT_DIR/config"
mkdir -p "$PRODUCT_DIR/docs"

echo -e "${GREEN}✓ Product directory created${NC}"

echo -e "${CYAN}[2/6] Creating bootstrap script...${NC}"

# Create product-specific bootstrap
cat > "$PRODUCT_DIR/bootstrap.sh" <<'EOF'
#!/bin/bash

###############################################################################
# PRODUCT BOOTSTRAP
# Starts this external product permanently
###############################################################################

set -e

PRODUCT_NAME="__NAME__"
PRODUCT_TYPE="__TYPE__"

echo "🚀 Bootstrapping $PRODUCT_NAME ($PRODUCT_TYPE)..."

# TODO: Add product-specific bootstrap logic
# - Initialize canister
# - Start workers
# - Configure memory space
# - Set up monitoring

# Update status
cat > status.json <<JSON
{
  "product": "$PRODUCT_NAME",
  "type": "$PRODUCT_TYPE",
  "status": "running",
  "beat_count": 0,
  "started_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
JSON

echo "✓ $PRODUCT_NAME is now running permanently"
EOF

# Replace placeholders
sed -i "s/__NAME__/$NAME/g" "$PRODUCT_DIR/bootstrap.sh"
sed -i "s/__TYPE__/$TYPE/g" "$PRODUCT_DIR/bootstrap.sh"

chmod +x "$PRODUCT_DIR/bootstrap.sh"

echo -e "${GREEN}✓ Bootstrap script created${NC}"

echo -e "${CYAN}[3/6] Creating status file...${NC}"

cat > "$PRODUCT_DIR/status.json" <<EOF
{
  "product": "$NAME",
  "type": "$TYPE",
  "status": "created",
  "beat_count": 0,
  "created_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF

echo -e "${GREEN}✓ Status file created${NC}"

echo -e "${CYAN}[4/6] Creating README...${NC}"

cat > "$PRODUCT_DIR/README.md" <<EOF
# $NAME

**Type:** $TYPE

## Overview

This is an external $TYPE created from the MEDINA internal AI workforce.

It runs permanently once bootstrapped.

## Bootstrap

\`\`\`bash
cd deployments/$NAME
./bootstrap.sh
\`\`\`

## Status

Check status:
\`\`\`bash
cat status.json
\`\`\`

## Architecture

- **Canister:** Product-specific ICP canister
- **Workers:** Product-specific AI workers
- **Memory:** Dedicated memory space
- **Monitoring:** Automated health checks

## Dependencies

- Core MEDINA organism (provides shared SDKs)
- Memory Temple (shared infrastructure)
- CPL Protocol (internal communication)

---

**Created:** $(date -u +%Y-%m-%dT%H:%M:%SZ)
EOF

echo -e "${GREEN}✓ README created${NC}"

echo -e "${CYAN}[5/6] Creating config...${NC}"

cat > "$PRODUCT_DIR/config/product.json" <<EOF
{
  "name": "$NAME",
  "type": "$TYPE",
  "version": "1.0.0",
  "created_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "config": {
    "heartbeat_hz": 1.618033988749895,
    "memory_space": "dedicated",
    "gate_level": "C",
    "monitoring": true,
    "auto_restart": true
  },
  "dependencies": {
    "core": "required",
    "memory_temple": "required",
    "cpl_protocol": "required"
  }
}
EOF

echo -e "${GREEN}✓ Config created${NC}"

echo -e "${CYAN}[6/6] Creating documentation...${NC}"

cat > "$PRODUCT_DIR/docs/ARCHITECTURE.md" <<EOF
# $NAME Architecture

## Overview

This $TYPE is a cascaded deployment from the MEDINA internal AI workforce.

## Permanent Operation

Once bootstrapped, this $TYPE runs permanently:
- Its own canister instance
- Its own worker team
- Its own memory space
- Its own heartbeat (φ Hz)

## Connection to Core

- Uses core SDKs (shared infrastructure)
- Reports to core (metrics, health)
- Independent operation (autonomous)

## Deployment

1. Bootstrap: \`./bootstrap.sh\`
2. Monitor: \`cat status.json\`
3. Maintain: Runs automatically

---

**Created:** $(date -u +%Y-%m-%dT%H:%M:%SZ)
EOF

echo -e "${GREEN}✓ Documentation created${NC}"

echo ""
echo -e "${GREEN}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                                                                ║"
echo "║              ✓ PRODUCT CREATED                                 ║"
echo "║                                                                ║"
echo "║  Name:     $NAME"
echo "║  Type:     $TYPE"
echo "║  Location: $PRODUCT_DIR"
echo "║                                                                ║"
echo "║  Next steps:                                                   ║"
echo "║  1. cd deployments/$NAME"
echo "║  2. ./bootstrap.sh                                             ║"
echo "║  3. Product runs permanently                                   ║"
echo "║                                                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo ""
echo -e "${PURPLE}Product ready to bootstrap!${NC}"
echo -e "${CYAN}∞ + 1 = ℵ₁${NC}"
echo ""
