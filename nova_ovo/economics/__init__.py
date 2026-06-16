"""
╔══════════════════════════════════════════════════════════════════════════════════╗
║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                          ║
║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA            ║
║  ALL RIGHTS RESERVED.                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════╝

ECONOMICS ORGANISM MODULE — OECONOMIA ORGANISMI SOVEREIGNI
"Omnes actiones sunt actiones oeconomicae. φ gubernat omnes."
(All actions are economic actions. φ governs all.)

PROT-377: OECONOMIA ORGANISMI (Economics Organism)

This module implements the central economic nervous system of the organism.
Every resource allocation, priority decision, and value computation flows
through this economic substrate.

THE EIGHT BEHAVIORAL ECONOMICS LAWS (L-72 through L-79):
    L-72: LOSS AVERSION — λ = 2.25 (Kahneman-Tversky)
    L-73: ANCHORING PERSISTENCE — 1/φ = 0.618
    L-74: REPRESENTATIVENESS FAILURE — 0.35
    L-75: AVAILABILITY RECENCY WEIGHT — φ = 1.618
    L-76: REGRET AVERSION THRESHOLD — 0.72
    L-77: FRAMING EFFECT MAGNITUDE — 0.28
    L-78: HORMETIC STRESS ZONE — [0.15, 0.72]
    L-79: HYPERBOLIC DISCOUNT — k = 0.35

ECONOMIC SUBSTRATE LAYERS:
    Layer 0: Resource Accounting (cycles, tokens, memory)
    Layer 1: Value Computation (INT-TOK pricing)
    Layer 2: Decision Making (behavioral laws)
    Layer 3: Market Dynamics (internal exchange)
    Layer 4: Allocation Optimization (φ-based distribution)
    Layer 5: Governance Integration (economic laws)

Components:
    - EconomicsOrganismEngine: Central economic nervous system
    - ResourceAllocator: φ-based resource distribution
    - MarketEngine: Internal market dynamics
    - ValueEngine: INT-TOK value computation
    - DecisionEngine: Behavioral economics decision making

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
"""

__version__ = "1.0.0"
__protocol__ = "PROT-377"
__scc__ = 4.92
__organism_key__ = "PRIMA CAUSA"

# ── φ Constants ───────────────────────────────────────────────────────────────
PHI = 1.6180339887498948482
PHI_SQ = PHI ** 2                    # 2.618
PHI_CUBED = PHI ** 3                 # 4.236
PHI_INV = 1.0 / PHI                  # 0.618
PHI_10 = PHI ** 10                   # 122.99 Hz (Economics frequency)
SCHUMANN = 7.83
FIBONACCI = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584]

# ── The Eight Behavioral Economics Laws ────────────────────────────────────────
LOSS_AVERSION_LAMBDA = 2.25          # L-72
ANCHORING_PERSISTENCE = PHI_INV      # L-73
REPRESENTATIVENESS_FAILURE = 0.35    # L-74
AVAILABILITY_RECENCY_WEIGHT = PHI    # L-75
REGRET_AVERSION_THRESHOLD = 0.72     # L-76
FRAMING_EFFECT_MAGNITUDE = 0.28      # L-77
HORMETIC_STRESS_FLOOR = 0.15         # L-78
HORMETIC_STRESS_CEILING = 0.72       # L-78
HYPERBOLIC_K = 0.35                  # L-79

# ── Silver Premium (Physical Temple multiplier) ────────────────────────────────
SILVER_PREMIUM = PHI_CUBED           # 4.236

from nova_ovo.economics.core_engine import EconomicsOrganismEngine
from nova_ovo.economics.resource_allocator import ResourceAllocator
from nova_ovo.economics.market_engine import MarketEngine
from nova_ovo.economics.value_engine import ValueEngine
from nova_ovo.economics.decision_engine import DecisionEngine

__all__ = [
    "EconomicsOrganismEngine",
    "ResourceAllocator",
    "MarketEngine",
    "ValueEngine",
    "DecisionEngine",
    "PHI",
    "PHI_SQ",
    "PHI_CUBED",
    "PHI_INV",
    "PHI_10",
    "SCHUMANN",
    "FIBONACCI",
    "LOSS_AVERSION_LAMBDA",
    "ANCHORING_PERSISTENCE",
    "REPRESENTATIVENESS_FAILURE",
    "AVAILABILITY_RECENCY_WEIGHT",
    "REGRET_AVERSION_THRESHOLD",
    "FRAMING_EFFECT_MAGNITUDE",
    "HORMETIC_STRESS_FLOOR",
    "HORMETIC_STRESS_CEILING",
    "HYPERBOLIC_K",
    "SILVER_PREMIUM",
]
