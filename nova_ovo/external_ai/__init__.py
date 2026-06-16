"""
🜃 EXTERNAL AI INTEGRATION — Gate C Bounded Interface
=====================================================

MEDINA Sovereign Architecture
Author: Freddy (Founder Architect)

This module provides doctrine-aligned integration with external AI systems.

All external AI interactions are:
1. Gate C bounded — no sovereign internals exposed
2. CPL compliant — messages follow cognitive procurement protocol
3. Resonance checked — alignment with doctrine verified
4. Lineage tracked — full provenance maintained

Supported external systems:
- Claude (Anthropic)
- GPT (OpenAI)
- Other LLM providers via adapter pattern

The organism reads external AI as EXTERNAL register (Ω_E).
External AI never touches Core A truth directly.
"""

from nova_ovo.external_ai.adapters import (
    ExternalAIAdapter,
    ClaudeAdapter,
    OpenAIAdapter,
    GenericLLMAdapter,
)
from nova_ovo.external_ai.gateway import (
    ExternalAIGateway,
    AIRequest,
    AIResponse,
)
from nova_ovo.external_ai.projection import (
    ProjectionEngine,
    ProjectedState,
    SafetyFilter,
    ProjectionLevel,
)
from nova_ovo.external_ai.translator import (
    AIMessageTranslator,
    CPLtoPrompt,
    ResponsetoCPL,
)

__all__ = [
    # Adapters
    "ExternalAIAdapter",
    "ClaudeAdapter",
    "OpenAIAdapter",
    "GenericLLMAdapter",
    # Gateway
    "ExternalAIGateway",
    "AIRequest",
    "AIResponse",
    # Projection
    "ProjectionEngine",
    "ProjectedState",
    "SafetyFilter",
    "ProjectionLevel",
    # Translator
    "AIMessageTranslator",
    "CPLtoPrompt",
    "ResponsetoCPL",
]
