"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                        MEDINA-LAB CLI — RESEARCH LABORATORY INTERFACE                        ║
║               "Intelligentia Ex Primitivo — Intelligence From The Primitive"                 ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-412 — LABORATORIUM CLI INTERFACE                                            ║
║                                                                                              ║
║  USAGE:                                                                                      ║
║    medina-lab enter        → Enter the interactive research lab terminal                    ║
║    medina-lab paper new    → Create a new research paper                                    ║
║    medina-lab paper list   → List all papers                                                ║
║    medina-lab status       → Show lab status                                                ║
║    medina-lab researchers  → List all researchers                                           ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ¹³ = 521.002 Hz — Research Lab Layer                                 ║
║  PRIMITIVE TRACE: FIELD → DISTINCTION → RELATION → REPETITION → MEMORY → ADDRESS → φ       ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import asyncio
import sys
from typing import Optional

import click
from rich.console import Console
from rich.panel import Panel
from rich.table import Table
from rich.text import Text

from .constants import PHI, PHI_POWERS, SCHUMANN, SOLFEGGIO, VERSION
from .lab import ResearchLab
from .terminal import LabTerminal

console = Console()


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# CLI GROUP
# ═══════════════════════════════════════════════════════════════════════════════════════════════


@click.group()
@click.version_option(version=VERSION, prog_name="medina-lab")
@click.option("--verbose", "-v", is_flag=True, help="Enable verbose output")
@click.pass_context
def main(ctx: click.Context, verbose: bool) -> None:
    """
    LABORATORIUM SOVEREIGNUS — The 13-Researcher AI Lab CLI
    
    φ¹³ = 521.002 Hz | PROT-412
    """
    ctx.ensure_object(dict)
    ctx.obj["verbose"] = verbose
    ctx.obj["console"] = console


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# ENTER COMMAND — Interactive Terminal
# ═══════════════════════════════════════════════════════════════════════════════════════════════


@main.command()
@click.pass_context
def enter(ctx: click.Context) -> None:
    """Enter the interactive research lab terminal."""
    console.print(
        Panel(
            Text.from_markup(
                "[bold gold1]LABORATORIUM SOVEREIGNUS[/bold gold1]\n"
                "[dim]The 13-Researcher AI Lab Terminal[/dim]\n\n"
                f"[cyan]φ¹³ = {PHI_POWERS[13]:.3f} Hz[/cyan] | "
                f"[magenta]PROT-412[/magenta]\n\n"
                "[dim]Type 'help' for commands, 'exit' to leave[/dim]"
            ),
            title="🧬 Welcome",
            border_style="gold1",
        )
    )
    
    terminal = LabTerminal(console, verbose=ctx.obj.get("verbose", False))
    asyncio.run(terminal.run())


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# PAPER COMMANDS — Paper Management
# ═══════════════════════════════════════════════════════════════════════════════════════════════


@main.group()
def paper() -> None:
    """Research paper management commands."""
    pass


@paper.command("new")
@click.argument("title")
@click.option("--domain", "-d", default="GENERAL", help="Research domain")
@click.option("--researcher", "-r", help="Lead researcher")
@click.pass_context
def paper_new(ctx: click.Context, title: str, domain: str, researcher: Optional[str]) -> None:
    """Create a new research paper."""
    lab = ResearchLab()
    
    console.print(f"\n[bold]Creating paper:[/bold] {title}")
    console.print(f"[dim]Domain: {domain}[/dim]")
    
    with console.status("[bold green]Initializing paper..."):
        paper_id = lab.create_paper(title, domain, researcher)
    
    console.print(f"\n[green]✓[/green] Paper created: [bold]{paper_id}[/bold]")
    console.print(f"[dim]Location: research/papers/{paper_id}.md[/dim]")


@paper.command("list")
@click.option("--domain", "-d", help="Filter by domain")
@click.option("--limit", "-n", default=20, help="Number of papers to show")
@click.pass_context
def paper_list(ctx: click.Context, domain: Optional[str], limit: int) -> None:
    """List all research papers."""
    lab = ResearchLab()
    papers = lab.list_papers(domain=domain, limit=limit)
    
    table = Table(title="Research Papers", show_header=True, header_style="bold gold1")
    table.add_column("ID", style="cyan", width=12)
    table.add_column("Title", style="white")
    table.add_column("Domain", style="magenta")
    table.add_column("SCC", style="green", justify="right")
    table.add_column("Status", style="yellow")
    
    for p in papers:
        table.add_row(
            p.get("id", ""),
            p.get("title", ""),
            p.get("domain", ""),
            f"{p.get('scc', 0):.2f}",
            p.get("status", "draft"),
        )
    
    console.print(table)
    console.print(f"\n[dim]Showing {len(papers)} papers[/dim]")


@paper.command("view")
@click.argument("paper_id")
@click.pass_context
def paper_view(ctx: click.Context, paper_id: str) -> None:
    """View a specific paper."""
    lab = ResearchLab()
    paper = lab.get_paper(paper_id)
    
    if not paper:
        console.print(f"[red]Paper not found: {paper_id}[/red]")
        return
    
    console.print(
        Panel(
            f"[bold]{paper.get('title', 'Untitled')}[/bold]\n\n"
            f"Domain: {paper.get('domain', 'GENERAL')}\n"
            f"SCC: {paper.get('scc', 0):.2f}\n"
            f"Protocol: {paper.get('protocol', 'N/A')}\n\n"
            f"[dim]{paper.get('abstract', 'No abstract available')}[/dim]",
            title=f"📄 {paper_id}",
            border_style="cyan",
        )
    )


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# STATUS COMMAND
# ═══════════════════════════════════════════════════════════════════════════════════════════════


@main.command()
@click.pass_context
def status(ctx: click.Context) -> None:
    """Show research lab status."""
    lab = ResearchLab()
    status_data = lab.get_status()
    
    # Header
    console.print(
        Panel(
            f"[bold gold1]LABORATORIUM SOVEREIGNUS[/bold gold1]\n"
            f"[dim]Status Report[/dim]",
            border_style="gold1",
        )
    )
    
    # Stats table
    table = Table(show_header=False, box=None)
    table.add_column("Metric", style="cyan")
    table.add_column("Value", style="green")
    
    table.add_row("Frequency", f"{status_data.get('frequency', PHI_POWERS[13]):.3f} Hz")
    table.add_row("Researchers", str(status_data.get("researcher_count", 13)))
    table.add_row("Papers", str(status_data.get("paper_count", 0)))
    table.add_row("Active Sessions", str(status_data.get("active_sessions", 0)))
    table.add_row("Protocol", status_data.get("protocol", "PROT-412"))
    table.add_row("φ Power", f"φ¹³ = {PHI_POWERS[13]:.6f}")
    
    console.print(table)


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# RESEARCHERS COMMAND
# ═══════════════════════════════════════════════════════════════════════════════════════════════


@main.command()
@click.pass_context
def researchers(ctx: click.Context) -> None:
    """List all researchers in the lab."""
    lab = ResearchLab()
    researcher_list = lab.get_researchers()
    
    table = Table(title="Lab Researchers", show_header=True, header_style="bold gold1")
    table.add_column("#", style="dim", width=3)
    table.add_column("Name", style="cyan")
    table.add_column("Domain", style="magenta")
    table.add_column("Frequency", style="green", justify="right")
    table.add_column("Status", style="yellow")
    
    for i, r in enumerate(researcher_list, 1):
        table.add_row(
            str(i),
            r.get("name", ""),
            r.get("domain", ""),
            f"{r.get('frequency', 0):.3f} Hz",
            r.get("status", "idle"),
        )
    
    console.print(table)


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# RESEARCH COMMAND — Execute Research
# ═══════════════════════════════════════════════════════════════════════════════════════════════


@main.command()
@click.argument("topic")
@click.option("--depth", "-d", default="standard", type=click.Choice(["quick", "standard", "deep"]))
@click.option("--output", "-o", help="Output file path")
@click.pass_context
def research(ctx: click.Context, topic: str, depth: str, output: Optional[str]) -> None:
    """Execute a research task on a given topic."""
    lab = ResearchLab()
    
    console.print(f"\n[bold]Research Topic:[/bold] {topic}")
    console.print(f"[dim]Depth: {depth}[/dim]\n")
    
    with console.status("[bold green]Conducting research...") as status:
        result = asyncio.run(lab.conduct_research(topic, depth))
    
    if result:
        console.print(Panel(result.get("summary", ""), title="Research Summary", border_style="green"))
        
        if output:
            with open(output, "w") as f:
                f.write(result.get("full_report", ""))
            console.print(f"\n[green]✓[/green] Full report saved to: {output}")
    else:
        console.print("[red]Research task failed[/red]")


@main.group()
def organism() -> None:
    """Live organism lifecycle commands."""
    pass


@organism.command("create")
@click.argument("website_url")
@click.option("--target", default="RESEARCH_WEBSITES", help="Canonical target identifier")
@click.option("--domain-pack", default="infrastructure", help="Domain pack identifier")
@click.pass_context
def organism_create(ctx: click.Context, website_url: str, target: str, domain_pack: str) -> None:
    """Create one live organism from a website URL."""
    lab = ResearchLab()
    try:
        organism = lab.create_organism_from_url(
            website_url=website_url,
            canonical_target=target,
            domain_pack=domain_pack,
        )
    except ValueError as exc:
        console.print(f"[red]{exc}[/red]")
        return

    console.print(
        Panel(
            f"[bold]Organism[/bold]: {organism['organism_id']}\n"
            f"URL: {organism['website_url']}\n"
            f"Target: {organism['canonical_target']}\n"
            f"Lane: {organism['lane_id']}\n"
            f"Domain Pack: {organism['domain_pack']}\n"
            f"Runtime: {organism['runtime_status']}",
            title="🧬 Live Organism Created",
            border_style="green",
        )
    )


@organism.command("list")
@click.pass_context
def organism_list(ctx: click.Context) -> None:
    """List live organisms."""
    lab = ResearchLab()
    organisms = lab.list_organisms()
    if not organisms:
        console.print("[dim]No live organisms created in this session[/dim]")
        return
    table = Table(title="Live Organisms", show_header=True, header_style="bold gold1")
    table.add_column("ID", style="cyan")
    table.add_column("URL", style="white")
    table.add_column("Target", style="magenta")
    table.add_column("Domain Pack", style="green")
    table.add_column("Runtime", style="yellow")
    for organism in organisms:
        table.add_row(
            organism.get("organism_id", ""),
            organism.get("website_url", ""),
            organism.get("canonical_target", ""),
            organism.get("domain_pack", ""),
            organism.get("runtime_status", ""),
        )
    console.print(table)


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# ENTRY POINT
# ═══════════════════════════════════════════════════════════════════════════════════════════════

if __name__ == "__main__":
    main()
