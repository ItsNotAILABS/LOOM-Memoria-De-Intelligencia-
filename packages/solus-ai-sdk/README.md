# 🔮 SOLUS AI — Sovereign Local Universal System

**The open-source local AI SDK for autonomous inference, reasoning, and agents.**

SOLUS (Sovereign Open Local Universal System) runs entirely on your hardware — no cloud, no API keys, no data leaving your machine. It provides a complete AI development framework with local model inference, structured reasoning, autonomous agents, and an OpenAI-compatible API server.

## Features

- **🧠 Local Inference** — Run LLMs locally (GGUF, Transformers, ONNX)
- **⚡ OpenAI-Compatible API** — Drop-in replacement for OpenAI endpoints
- **🔗 Chain-of-Thought Reasoning** — Multi-step verified reasoning
- **🤖 Autonomous Agents** — Task-planning agents with tool use
- **🛠️ Function Calling** — Structured tool use with any model
- **💾 Memory System** — Short-term + long-term memory management
- **📦 Model Registry** — Pre-configured support for popular models
- **🖥️ CLI** — Full command-line interface
- **🌐 WebSocket Streaming** — Real-time token streaming

## Quick Start

```bash
# Install
pip install solus-ai

# With GPU support
pip install solus-ai[gpu]

# With GGUF support (recommended for local models)
pip install solus-ai[gguf]

# Everything
pip install solus-ai[all]
```

## Usage

### Python SDK

```python
from solus import Solus

# Initialize
ai = Solus()

# Load a local model
ai.load_model("mistral-7b-q4")

# Generate text
response = ai.generate("Explain quantum computing in simple terms")
print(response.text)
print(f"Tokens/sec: {response.tokens_per_second:.1f}")

# Chat
messages = [
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "What is the golden ratio?"},
]
reply = ai.chat(messages)
print(reply.text)

# Reasoning
answer = ai.reason("What is 127 * 43?", strategy="chain_of_thought")
print(f"Answer: {answer.answer}")
print(f"Confidence: {answer.confidence:.2f}")
print(f"Steps: {answer.chain.step_count}")

# Agents
agent = ai.create_agent("researcher", tools=["web_fetch", "calculate"])
result = agent.run("Find the population of Tokyo and calculate its density")
print(result.answer)

# Embeddings
embeddings = ai.embed(["Hello world", "Quantum physics"])
print(f"Dimensions: {embeddings.dimensions}")
```

### CLI

```bash
# Check status
solus status

# List models
solus models list

# Generate text
solus generate "Write a haiku about AI" --model mistral-7b

# Interactive chat
solus chat --model mistral-7b

# Reasoning
solus reason "What is the square root of 144?" --model mistral-7b

# Run an agent
solus agent "Summarize the README.md file" --model mistral-7b

# Start API server
solus serve --model mistral-7b --port 8741
```

### API Server

```bash
# Start server
solus serve --model mistral-7b

# Use with any OpenAI-compatible client
curl http://localhost:8741/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "mistral-7b",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

```python
# Works with the OpenAI Python client
from openai import OpenAI

client = OpenAI(base_url="http://localhost:8741/v1", api_key="not-needed")
response = client.chat.completions.create(
    model="mistral-7b",
    messages=[{"role": "user", "content": "Hello!"}],
)
print(response.choices[0].message.content)
```

## Supported Models

| Model | Parameters | RAM Required | Best For |
|-------|-----------|-------------|----------|
| Mistral 7B | 7B | 6 GB | General tasks |
| Llama 3 8B | 8B | 6 GB | Reasoning |
| Llama 3 70B | 70B | 48 GB | Complex tasks |
| Phi-3 Mini | 3.8B | 4 GB | Fast/efficient |
| Code Llama 13B | 13B | 10 GB | Programming |
| DeepSeek Coder | 6.7B | 6 GB | Code generation |
| Qwen 2 7B | 7B | 6 GB | Multilingual |
| Gemma 2 9B | 9B | 8 GB | Instruction |

Any GGUF model from Hugging Face works. Place `.gguf` files in `~/.solus/models/`.

## Architecture

```
solus/
├── engine/          # Core inference runtime
│   ├── runtime.py   # Hardware detection, memory management
│   └── inference.py # Generation, chat, embeddings, streaming
├── models/          # Model management
│   ├── registry.py  # Known model configurations
│   └── manager.py   # Load, serve, swap models
├── reasoning/       # Structured reasoning
│   ├── chain.py     # Chain-of-thought engine
│   └── planner.py   # Strategy selection & orchestration
├── memory/          # Memory systems
│   └── connector.py # Short-term + long-term + Semper Memoria
├── agents/          # Agent framework
│   ├── agent.py     # Autonomous agent with tool use
│   └── orchestrator.py # Multi-agent coordination
├── tools/           # Tool system
│   ├── registry.py  # Tool registration & discovery
│   └── function_call.py # Function calling parser
├── server/          # API server
│   └── app.py       # OpenAI-compatible REST + WebSocket
└── cli/             # Command-line interface
    └── main.py      # Full CLI with Click
```

## Configuration

Create `~/.solus/config.yaml`:

```yaml
model_dir: ~/.solus/models
max_context_length: 8192
num_threads: 0  # 0 = auto-detect
backend: auto   # auto, cpu, cuda, metal
gpu_layers: -1  # -1 = all layers on GPU
flash_attention: true
```

## API Reference

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/` | Server info |
| GET | `/health` | Health check |
| GET | `/v1/models` | List models |
| POST | `/v1/completions` | Text completion |
| POST | `/v1/chat/completions` | Chat completion |
| POST | `/v1/embeddings` | Generate embeddings |
| POST | `/v1/agents/run` | Run an agent |
| POST | `/v1/reasoning` | Structured reasoning |
| WS | `/v1/stream` | WebSocket streaming |
| GET | `/v1/status` | System status |

## Protocols

SOLUS AI covers protocols PROT-662 through PROT-681:

- **PROT-662** — Runtime environment & hardware detection
- **PROT-663** — Inference engine (generation, chat, embeddings)
- **PROT-664** — Model registry & configurations
- **PROT-665** — Model manager (load, serve, swap)
- **PROT-666** — Chain-of-thought reasoning
- **PROT-667** — Reasoning planner & strategy selection
- **PROT-668** — Memory connector (Semper Memoria integration)
- **PROT-669** — Autonomous agent framework
- **PROT-670** — Multi-agent orchestration
- **PROT-671** — Tool registry & built-in tools
- **PROT-672** — Function calling parser
- **PROT-673** — API server (OpenAI-compatible)
- **PROT-674** — CLI interface
- **PROT-675–681** — Extended capabilities (reserved)

## System Identity

- **Codename**: SOLUS
- **Latin**: SYSTEMA LOCALE UNIVERSALE SOVEREIGNUM
- **Worker**: #78
- **Layer**: 22
- **Frequency**: 4,870,847 Hz (φ²²)
- **License**: MIT (Open Source)

## License

MIT License — Free for personal and commercial use.

Built by **Alfredo 'Freddy' Medina Hernandez** | Medina Tech | Dallas, TX
