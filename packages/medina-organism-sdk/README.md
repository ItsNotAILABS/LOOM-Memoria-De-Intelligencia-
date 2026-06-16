# Medina Organism SDK

**Intelligentia Ex Primitivo — Intelligence From The Primitive**

The official Python SDK for the Medina Sovereign Organism.

## Installation

```bash
pip install medina-organism-sdk
```

## Quick Start

```python
from medina import ResearchLab, PhantomField, MemoryTemple
from medina.constants import PHI, SCHUMANN, SOLFEGGIO

# Access the Research Lab
lab = ResearchLab()
result = lab.research("quantum computing")

# Create a Phantom Memory Field
phantom = PhantomField()
field_id = phantom.store(b"secret data", memory_type="ephemeral")

# Use the Memory Temple
temple = MemoryTemple()
memory = temple.store("knowledge", ring=5)
```

## Features

- **Research Lab** — 13 specialized AI researchers
- **Phantom Memory** — Field-based memory (no persistent storage)
- **Memory Temple** — Torus-based memory navigation
- **Sovereign Beings** — Autonomous agent architecture
- **Phantom Agents** — Field presence intelligences

## Constants

The SDK includes fundamental constants:

```python
from medina.constants import (
    PHI,         # 1.618033988749895 — Golden Ratio
    PHI_SQ,      # 2.618033988749895 — φ²
    SCHUMANN,    # 7.83 Hz — Earth's resonance
    SOLFEGGIO,   # [174, 285, 396, 417, 528, 639, 741, 852, 963] Hz
    FIBONACCI,   # [1, 1, 2, 3, 5, 8, 13, 21, ...]
)
```

## License

ISIL-1.0 — Medina Tech

## Author

Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
