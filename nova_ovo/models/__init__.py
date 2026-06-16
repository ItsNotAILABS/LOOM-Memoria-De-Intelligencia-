"""
Models — MEDINA V1 Multi-Model Runtime
======================================
Multi-model runtime with role-specialized models:
- strategist, builder, analyst, governance
- memory curator, operations, defense/risk, projection

Architecture naming:
- R-MODEL-* runtime organism models
- U-MODEL-* interface operation models
- D-MODEL-* document intelligence models
- N-MODEL-* sovereign macro-node models

D1–D10 document organisms remain active workforce.
N1–N12 sovereign macro hierarchy remains control topology.
"""

from .registry import ModelRegistry, ModelDefinition, ModelFamily
from .router import ModelRouter, RoutingDecision

__all__ = [
    "ModelRegistry",
    "ModelDefinition",
    "ModelFamily",
    "ModelRouter",
    "RoutingDecision",
]
