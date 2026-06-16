"""
SOLUS CLI — Command-Line Interface
====================================

PROT-674: Full CLI for interacting with SOLUS locally.
Provides model management, inference, chat, server, and agent commands.
"""

from __future__ import annotations

import sys
from typing import Optional

try:
    import click
    HAS_CLICK = True
except ImportError:
    HAS_CLICK = False


def _ensure_click():
    if not HAS_CLICK:
        print("Error: 'click' package required. Install with: pip install solus-ai")
        sys.exit(1)


if HAS_CLICK:

    @click.group()
    @click.version_option(version="1.0.0", prog_name="solus")
    def cli():
        """🔮 SOLUS AI — Sovereign Local Universal System

        Open-source local AI SDK for inference, reasoning, and agents.
        """
        pass

    @cli.command()
    @click.option("--model-dir", default="~/.solus/models", help="Model directory")
    def status(model_dir: str):
        """Show SOLUS system status."""
        from solus import Solus
        s = Solus(model_dir=model_dir)
        info = s.identity
        click.echo("🔮 SOLUS AI Status")
        click.echo(f"   Name: {info['name']}")
        click.echo(f"   Version: {info['version']}")
        click.echo(f"   Layer: {info['layer']}")
        click.echo(f"   Frequency: {info['frequency_hz']:,} Hz")
        click.echo(f"   Protocols: {info['protocols']}")
        click.echo(f"   License: {info['license']}")
        click.echo(f"   Model Loaded: {info['model_loaded']}")

    @cli.group()
    def models():
        """Manage local models."""
        pass

    @models.command("list")
    @click.option("--model-dir", default="~/.solus/models", help="Model directory")
    def models_list(model_dir: str):
        """List available models."""
        from solus.models.manager import ModelManager
        mgr = ModelManager(model_dir=model_dir)

        click.echo("📦 Local Models:")
        local = mgr.list_local()
        if local:
            for m in local:
                click.echo(f"  • {m}")
        else:
            click.echo("  (none found)")

        click.echo("\n📋 Known Models (registry):")
        for spec in mgr.registry.list_all():
            click.echo(f"  • {spec.model_id} ({spec.parameters}) — {spec.description}")

    @models.command("info")
    @click.argument("model_id")
    def models_info(model_id: str):
        """Show details about a model."""
        from solus.models.registry import ModelRegistry
        reg = ModelRegistry()
        spec = reg.get(model_id)
        if not spec:
            click.echo(f"Model '{model_id}' not found in registry.")
            return
        click.echo(f"Model: {spec.name}")
        click.echo(f"  Family: {spec.family}")
        click.echo(f"  Parameters: {spec.parameters}")
        click.echo(f"  Context: {spec.context_length:,} tokens")
        click.echo(f"  Min RAM: {spec.min_ram_gb} GB")
        click.echo(f"  Formats: {', '.join(f.value for f in spec.formats)}")
        click.echo(f"  Quantizations: {', '.join(q.value for q in spec.quantizations)}")
        click.echo(f"  License: {spec.license}")

    @cli.command()
    @click.argument("prompt")
    @click.option("--model", "-m", default=None, help="Model to use")
    @click.option("--max-tokens", "-t", default=2048, help="Max tokens")
    @click.option("--temperature", default=0.7, help="Temperature")
    @click.option("--model-dir", default="~/.solus/models", help="Model directory")
    def generate(prompt: str, model: str, max_tokens: int, temperature: float, model_dir: str):
        """Generate text from a prompt."""
        from solus import Solus
        s = Solus(model_dir=model_dir)
        if model:
            s.load_model(model)
        else:
            click.echo("Error: No model specified. Use --model <model_id>")
            return
        result = s.generate(prompt, max_tokens=max_tokens, temperature=temperature)
        click.echo(result.text)

    @cli.command()
    @click.option("--model", "-m", required=True, help="Model to use")
    @click.option("--model-dir", default="~/.solus/models", help="Model directory")
    def chat(model: str, model_dir: str):
        """Start an interactive chat session."""
        from solus import Solus
        s = Solus(model_dir=model_dir)
        s.load_model(model)

        click.echo(f"🔮 SOLUS Chat — Model: {model}")
        click.echo("   Type 'quit' to exit, 'clear' to reset context\n")

        messages = []
        while True:
            try:
                user_input = click.prompt("You", prompt_suffix="> ")
            except (EOFError, KeyboardInterrupt):
                break

            if user_input.lower() == "quit":
                break
            if user_input.lower() == "clear":
                messages = []
                click.echo("[Context cleared]")
                continue

            messages.append({"role": "user", "content": user_input})
            result = s.chat(messages, max_tokens=2048)
            messages.append({"role": "assistant", "content": result.text})

            click.echo(f"\nSolus> {result.text}\n")

    @cli.command()
    @click.argument("question")
    @click.option("--strategy", "-s", default="auto", help="Reasoning strategy")
    @click.option("--model", "-m", required=True, help="Model to use")
    @click.option("--model-dir", default="~/.solus/models", help="Model directory")
    def reason(question: str, strategy: str, model: str, model_dir: str):
        """Use structured reasoning to answer a question."""
        from solus import Solus
        s = Solus(model_dir=model_dir)
        s.load_model(model)

        result = s.reason(question, strategy=strategy)
        click.echo(f"Strategy: {result.strategy_used}")
        click.echo(f"Confidence: {result.confidence:.2f}")
        click.echo(f"Answer: {result.answer}")

    @cli.command()
    @click.option("--host", default="0.0.0.0", help="Bind address")
    @click.option("--port", default=8741, help="Port number")
    @click.option("--model", "-m", default=None, help="Model to load on startup")
    @click.option("--model-dir", default="~/.solus/models", help="Model directory")
    def serve(host: str, port: int, model: str, model_dir: str):
        """Start the SOLUS API server."""
        from solus.server.app import run as run_server
        run_server(host=host, port=port, model=model, model_dir=model_dir)

    @cli.command()
    @click.argument("task")
    @click.option("--model", "-m", required=True, help="Model to use")
    @click.option("--agent-name", default="cli-agent", help="Agent name")
    @click.option("--max-steps", default=20, help="Max agent steps")
    @click.option("--model-dir", default="~/.solus/models", help="Model directory")
    def agent(task: str, model: str, agent_name: str, max_steps: int, model_dir: str):
        """Run an autonomous agent on a task."""
        from solus import Solus
        s = Solus(model_dir=model_dir)
        s.load_model(model)

        ag = s.create_agent(agent_name, max_steps=max_steps)
        result = ag.run(task)

        click.echo(f"Agent: {agent_name}")
        click.echo(f"Status: {result.status.value}")
        click.echo(f"Steps: {len(result.steps)}")
        click.echo(f"Answer: {result.answer}")

else:
    def cli():
        """CLI stub when click is not installed."""
        print("Error: 'click' package required. Install with: pip install solus-ai")
        sys.exit(1)


if __name__ == "__main__":
    cli()
