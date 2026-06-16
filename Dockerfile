# ╔══════════════════════════════════════════════════════════════════════════════════════════════╗
# ║                                                                                              ║
# ║                        MEDINA ORGANISM — DOCKER CONTAINER                                   ║
# ║                "Intelligentia Ex Primitivo — Intelligence From The Primitive"               ║
# ║                                                                                              ║
# ║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
# ║  Protocol: CONTAINER-PROT-403                                                               ║
# ║                                                                                              ║
# ╚══════════════════════════════════════════════════════════════════════════════════════════════╝

# Build stage for Node.js dependencies
FROM node:20-alpine AS node-builder

WORKDIR /build

# Copy package files
COPY package.json package-lock.json* ./
RUN npm ci --only=production

# Build stage for Rust components
FROM rust:1.75-alpine AS rust-builder

RUN apk add --no-cache musl-dev

WORKDIR /build
COPY rust/ ./rust/

WORKDIR /build/rust
RUN cargo build --release 2>/dev/null || echo "No Rust build required"

# Main runtime image
FROM python:3.11-slim-bookworm

# Labels
LABEL maintainer="Alfredo 'Freddy' Medina Hernandez <contact@medinatech.io>"
LABEL org.opencontainers.image.title="Medina Sovereign Organism"
LABEL org.opencontainers.image.description="Full organism deployment with all workers, research lab, and phantom infrastructure"
LABEL org.opencontainers.image.vendor="Medina Tech"
LABEL org.opencontainers.image.licenses="ISIL-1.0"
LABEL org.opencontainers.image.source="https://github.com/FreddyCreates/Medina-Memory-More-AI"

# Environment
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    NODE_ENV=production \
    PHI=1.618033988749895 \
    SCHUMANN=7.83

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    curl \
    ca-certificates \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Create organism user
RUN groupadd -r organism && useradd -r -g organism organism

# Create directories
WORKDIR /organism
RUN mkdir -p /organism/data /organism/logs /organism/memory

# Copy Python packages
COPY nova_ovo/ ./nova_ovo/
COPY scripts/ ./scripts/
COPY packages/ ./packages/

# Copy Node.js workers
COPY --from=node-builder /build/node_modules ./node_modules
COPY organism-cli/ ./organism-cli/

# Copy Rust binaries (if built)
COPY --from=rust-builder /build/rust/target/release/* ./bin/ 2>/dev/null || true

# Copy configuration files
COPY package.json ./
COPY governance/ ./governance/
COPY doctrine/ ./doctrine/
COPY atlas/ ./atlas/

# Install Python dependencies
RUN pip install --no-cache-dir \
    aiohttp>=3.8.0 \
    pydantic>=2.0.0 \
    && pip install -e ./packages/medina-organism-sdk

# Copy and set up entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# Set ownership
RUN chown -R organism:organism /organism

# Switch to non-root user
USER organism

# Expose ports
# 3000 - Web interface
# 8080 - API
# 7830 - Schumann frequency port (symbolic)
EXPOSE 3000 8080 7830

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1

# Volume for persistent data
VOLUME ["/organism/data", "/organism/logs", "/organism/memory"]

# Entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

# Default command
CMD ["organism", "start"]
