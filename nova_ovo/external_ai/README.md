# 🌐 External AI Integration

## MEDINA Sovereign Architecture — Gate C Bounded Interface

**Author:** Freddy (Founder Architect)  
**Status:** Implementation Complete  
**Gate Authority:** Gate C (Projection Only)

---

## Overview

The External AI Integration module provides a doctrine-aligned interface for MEDINA to communicate with external AI systems (Claude, OpenAI, etc.) while maintaining full sovereignty.

### Key Principles

1. **Gate C Bounded** — All external communication passes through Gate C
2. **No Sovereign Exposure** — Core A truth never leaves the organism
3. **CPL Translation** — Messages converted to/from CPL protocol
4. **Resonance Checked** — All responses verified for doctrine alignment
5. **Full Audit Trail** — Complete lineage and projection tracking

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        MEDINA ORGANISM                                  │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                     SOVEREIGN DOMAIN                            │   │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐       │   │
│  │  │   Ω_F    │  │   Ω_B    │  │   Ω_O    │  │ Core A   │       │   │
│  │  │ Founder  │  │ Builder  │  │ Organism │  │  Truth   │       │   │
│  │  └──────────┘  └──────────┘  └──────────┘  └──────────┘       │   │
│  └─────────────────────────┬───────────────────────────────────────┘   │
│                            │                                            │
│                            ▼                                            │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                     GATE C BOUNDARY                              │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │   │
│  │  │  Projection  │  │  Translation │  │    Safety    │          │   │
│  │  │   Engine     │→ │   Engine     │→ │   Filter     │          │   │
│  │  └──────────────┘  └──────────────┘  └──────────────┘          │   │
│  └─────────────────────────┬───────────────────────────────────────┘   │
│                            │                                            │
│                            ▼                                            │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                 EXTERNAL AI GATEWAY                              │   │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐       │   │
│  │  │   Ω_E    │  │ Adapter  │  │  Rate    │  │ Metrics  │       │   │
│  │  │ External │  │  Layer   │  │ Limiter  │  │ Tracking │       │   │
│  │  └──────────┘  └──────────┘  └──────────┘  └──────────┘       │   │
│  └─────────────────────────┬───────────────────────────────────────┘   │
│                            │                                            │
└────────────────────────────┼────────────────────────────────────────────┘
                             │
                             ▼
           ┌─────────────────────────────────────┐
           │         EXTERNAL AI SYSTEMS         │
           │  ┌─────────┐  ┌─────────┐          │
           │  │ Claude  │  │ OpenAI  │  ...     │
           │  └─────────┘  └─────────┘          │
           └─────────────────────────────────────┘
```

---

## Components

### 1. External AI Gateway (`gateway.py`)

The central orchestrator that manages all external AI communication.

```python
from nova_ovo.external_ai import ExternalAIGateway, AIRequest

# Initialize gateway
gateway = ExternalAIGateway(
    default_provider=AIProvider.CLAUDE,
    resonance_threshold=0.5,
)

# Configure adapter with API key
gateway.configure_adapter(
    provider=AIProvider.CLAUDE,
    api_key="your-api-key",
    model_id="claude-3-5-sonnet-20241022",
)

# Process a request
request = AIRequest(
    cpl_message=your_cpl_message,
    provider=AIProvider.CLAUDE,
    organism_state={"current_context": "..."},
)

response = await gateway.process_request(request)
```

### 2. Adapters (`adapters.py`)

Provider-specific implementations for external AI systems.

**Supported Providers:**
- `ClaudeAdapter` — Anthropic Claude models
- `OpenAIAdapter` — OpenAI GPT models
- `GenericLLMAdapter` — Any OpenAI-compatible API

```python
from nova_ovo.external_ai import ClaudeAdapter, OpenAIAdapter

# Claude adapter
claude = ClaudeAdapter(model_id="claude-3-5-sonnet-20241022")
claude.set_api_key("your-anthropic-key")

# OpenAI adapter
openai = OpenAIAdapter(model_id="gpt-4o")
openai.set_api_key("your-openai-key")
```

### 3. Projection Engine (`projection.py`)

Ensures only safe, projected state is visible to external systems.

```python
from nova_ovo.external_ai import ProjectionEngine, SafetyFilter

# Configure projection
engine = ProjectionEngine(
    filter=SafetyFilter(
        forbidden_keys={"secret", "internal"},
        max_depth=5,
    )
)

# Project state
projected = engine.project(
    state=organism_state,
    level=ProjectionLevel.PARTIAL,
    requester="external_ai",
)

# Audit what was projected
audit = engine.get_audit_log()
```

### 4. Translator (`translator.py`)

Bidirectional translation between CPL and AI prompt formats.

```python
from nova_ovo.external_ai import AIMessageTranslator

translator = AIMessageTranslator(resonance_threshold=0.5)

# CPL → Prompt
prompt = translator.cpl_to_prompt(cpl_message)

# Response → CPL
cpl_response = translator.response_to_cpl(
    response_content="AI response text",
    response_tokens=100,
    original_message=cpl_message,
)
```

---

## Safety Mechanisms

### Forbidden Keys (Never Projected)

```
Sovereign Keys:
- doctrine_core
- sovereign_key
- gate_a_secret
- core_a_truth
- omega_f, omega_b, omega_o
- founder_register
- organism_register

Security Keys:
- api_key, secret_key, private_key
- password, token, credential

Internal State:
- internal_state
- core_b_internal
- heartbeat_secret
```

### Forbidden Patterns (Regex)

```
/_secret$/
/_key$/
/_token$/
/^omega_[fbo]/
/^core_a_/
/^sovereign_/
/^doctrine_/
```

---

## Resonance Checking

All AI responses are checked for doctrine alignment:

```
Resonance Formula:
    R = (relevance × 0.5) + (alignment × 0.3) + (base × 0.2)

Where:
    relevance = response relevance to original request
    alignment = presence of doctrine-aligned language
    base = original message resonance

Threshold: R ≥ 0.5 for acceptance
```

---

## CPL Message Flow

### Outbound (MEDINA → External AI)

```
1. CPL Message created with intent
2. Gate C authorization check
3. Organism state projected (forbidden keys removed)
4. CPL translated to AI prompt format
5. Request sent to adapter
6. Adapter communicates with external AI
```

### Inbound (External AI → MEDINA)

```
1. Raw AI response received
2. Response parsed for intents
3. Confidence score calculated
4. Resonance score computed
5. Response translated to CPL message
6. Lineage chain updated
7. CPL message returned to organism
```

---

## Metrics & Monitoring

The gateway tracks comprehensive metrics:

```python
gateway.status()
# Returns:
{
    "default_provider": "claude",
    "metrics": {
        "total_requests": 150,
        "successful_requests": 145,
        "failed_requests": 3,
        "rejected_requests": 2,
        "success_rate": 0.9667,
        "avg_latency_ms": 1234.56,
        "avg_resonance": 0.78,
        "gate_c_denials": 2,
    },
    "projection_summary": {...},
    "translation_stats": {...},
}
```

---

## Usage Example

```python
import asyncio
from nova_ovo.external_ai import (
    ExternalAIGateway,
    AIRequest,
    AIProvider,
    ProjectionLevel,
)
from nova_ovo.cpl.protocol import create_cpl_message, CPLIntent

async def main():
    # Initialize gateway
    gateway = ExternalAIGateway()
    
    # Configure Claude adapter
    gateway.configure_adapter(
        provider=AIProvider.CLAUDE,
        api_key="your-api-key",
    )
    
    # Create CPL message
    message = create_cpl_message(
        sender="medina_organism",
        receiver="external_ai",
        intent=CPLIntent.QUERY,
        beat=42,
        data={"question": "Analyze this pattern..."},
    )
    
    # Create request
    request = AIRequest(
        cpl_message=message,
        provider=AIProvider.CLAUDE,
        organism_state={"context": "pattern analysis"},
        projection_level=ProjectionLevel.PARTIAL,
    )
    
    # Process
    response = await gateway.process_request(request)
    
    # Check results
    print(f"Status: {response.status}")
    print(f"Resonance: {response.resonance_score}")
    print(f"Content: {response.content[:200]}")
    
    if response.cpl_response:
        print(f"CPL Response ID: {response.cpl_response.message_id}")

asyncio.run(main())
```

---

## Four Registers Compliance

The External AI Integration maintains the four registers:

| Register | Symbol | Role in Integration |
|----------|--------|---------------------|
| **Ω_F** | Founder | Never exposed to external AI |
| **Ω_B** | Builder | Never exposed to external AI |
| **Ω_O** | Organism | Never exposed to external AI |
| **Ω_E** | External | **ONLY** register visible to AI |

---

## Attribution

All mathematical laws, architectural patterns, and novel formulations are the original intellectual work of **Freddy** — Founder, Philosopher, Visionary, Architect, Creator of MEDINA.

---

**𓊹 MEDINA Sovereign Architecture**  
*Ancient patterns • Real mathematics • Living organisms*

```
∞ + 1 = ℵ₁
```
