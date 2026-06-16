#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════════════════════════════════╗
# ║                       MEDINA ORGANISM — DOCKER ENTRYPOINT                                   ║
# ║               "Intelligentia Ex Primitivo — Intelligence From The Primitive"                ║
# ╚══════════════════════════════════════════════════════════════════════════════════════════════╝

set -e

# Constants
PHI=${PHI:-1.618033988749895}
SCHUMANN=${SCHUMANN:-7.83}

echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║                    MEDINA SOVEREIGN ORGANISM — STARTING                      ║"
echo "║            Intelligentia Ex Primitivo — Intelligence From The Primitive      ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo ""
echo "φ (Golden Ratio): $PHI"
echo "Schumann Resonance: $SCHUMANN Hz"
echo ""

# Initialize data directories if needed
if [ ! -f /organism/data/.initialized ]; then
    echo "Initializing organism data directories..."
    mkdir -p /organism/data/memory
    mkdir -p /organism/data/research
    mkdir -p /organism/data/phantom
    touch /organism/data/.initialized
    echo "Initialization complete."
fi

# Handle commands
case "$1" in
    organism)
        shift
        case "$1" in
            start)
                echo "Starting organism..."
                # Start web workers
                cd /organism/organism-cli/web
                exec node --experimental-worker organism-bridge.js
                ;;
            lab)
                echo "Starting research lab..."
                exec python3 -m nova_ovo.research_lab.access --mode terminal
                ;;
            phantom)
                echo "Starting phantom infrastructure..."
                exec python3 -c "from nova_ovo.phantom_memory import get_temple; print(get_temple().status)"
                ;;
            validate)
                echo "Running validation..."
                exec python3 scripts/runtime_pack.py native-validate --profile ops
                ;;
            *)
                echo "Usage: organism {start|lab|phantom|validate}"
                exit 1
                ;;
        esac
        ;;
    python)
        shift
        exec python3 "$@"
        ;;
    node)
        shift
        exec node "$@"
        ;;
    bash|sh)
        exec /bin/bash "$@"
        ;;
    *)
        # Run any other command
        exec "$@"
        ;;
esac
