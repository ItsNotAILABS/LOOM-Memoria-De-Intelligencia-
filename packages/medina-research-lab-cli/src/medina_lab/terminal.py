"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                        MEDINA-LAB CLI — INTERACTIVE TERMINAL                                 ║
║               "Intelligentia Ex Primitivo — Intelligence From The Primitive"                 ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-412 — INTERACTIVE TERMINAL                                                  ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import asyncio
from typing import Optional

from prompt_toolkit import PromptSession
from prompt_toolkit.history import InMemoryHistory
from prompt_toolkit.completion import WordCompleter
from rich.console import Console
from rich.panel import Panel

from .constants import PHI, PHI_POWERS
from .lab import ResearchLab


class LabTerminal:
    """
    Interactive terminal for the Research Lab.
    
    FREQUENCY SIGNATURE: φ¹³ = 521.002 Hz
    """
    
    COMMANDS = [
        "help", "exit", "quit", "status", "researchers", "research",
        "paper", "list", "view", "create", "assign", "frequency", "clear",
    ]
    
    def __init__(self, console: Console, verbose: bool = False) -> None:
        self.console = console
        self.verbose = verbose
        self.lab = ResearchLab()
        self.running = True
        
        self.completer = WordCompleter(self.COMMANDS, ignore_case=True)
        self.session: PromptSession[str] = PromptSession(
            history=InMemoryHistory(),
            completer=self.completer,
        )
    
    async def run(self) -> None:
        """Run the interactive terminal loop."""
        while self.running:
            try:
                # Get input with prompt
                prompt = f"[φ¹³] lab > "
                user_input = await self.session.prompt_async(prompt)
                
                # Process command
                await self.process_command(user_input.strip())
                
            except KeyboardInterrupt:
                self.console.print("\n[yellow]Use 'exit' to leave the lab[/yellow]")
            except EOFError:
                break
        
        self.console.print("\n[dim]Exiting lab...[/dim]")
    
    async def process_command(self, command: str) -> None:
        """Process a terminal command."""
        if not command:
            return
        
        parts = command.lower().split()
        cmd = parts[0]
        args = parts[1:]
        
        handlers = {
            "help": self.cmd_help,
            "exit": self.cmd_exit,
            "quit": self.cmd_exit,
            "status": self.cmd_status,
            "researchers": self.cmd_researchers,
            "research": self.cmd_research,
            "paper": self.cmd_paper,
            "list": self.cmd_list,
            "frequency": self.cmd_frequency,
            "clear": self.cmd_clear,
        }
        
        handler = handlers.get(cmd)
        if handler:
            await handler(args)
        else:
            self.console.print(f"[red]Unknown command: {cmd}[/red]")
            self.console.print("[dim]Type 'help' for available commands[/dim]")
    
    async def cmd_help(self, args: list[str]) -> None:
        """Show help information."""
        help_text = """
[bold gold1]Available Commands:[/bold gold1]

  [cyan]help[/cyan]           Show this help message
  [cyan]status[/cyan]         Show lab status
  [cyan]researchers[/cyan]    List all researchers
  [cyan]research[/cyan] <topic>  Conduct research on a topic
  [cyan]paper[/cyan] new <title>  Create a new paper
  [cyan]paper[/cyan] list     List all papers
  [cyan]list[/cyan]           List recent items
  [cyan]frequency[/cyan]      Show current frequency state
  [cyan]clear[/cyan]          Clear the screen
  [cyan]exit[/cyan]           Exit the terminal

[dim]φ¹³ = 521.002 Hz | PROT-412[/dim]
"""
        self.console.print(Panel(help_text, title="Help", border_style="gold1"))
    
    async def cmd_exit(self, args: list[str]) -> None:
        """Exit the terminal."""
        self.running = False
    
    async def cmd_status(self, args: list[str]) -> None:
        """Show lab status."""
        status = self.lab.get_status()
        
        status_text = f"""
[bold]LABORATORIUM SOVEREIGNUS[/bold]

Frequency: [cyan]{status['frequency']:.3f} Hz[/cyan]
Researchers: [green]{status['researcher_count']}[/green]
Papers: [green]{status['paper_count']}[/green]
Active Sessions: [yellow]{status['active_sessions']}[/yellow]
Protocol: [magenta]{status['protocol']}[/magenta]
"""
        self.console.print(Panel(status_text, border_style="cyan"))
    
    async def cmd_researchers(self, args: list[str]) -> None:
        """List researchers."""
        from rich.table import Table
        
        researchers = self.lab.get_researchers()
        
        table = Table(title="Lab Researchers", show_header=True, header_style="bold gold1")
        table.add_column("#", style="dim", width=3)
        table.add_column("Name", style="cyan")
        table.add_column("Domain", style="magenta")
        table.add_column("Frequency", style="green", justify="right")
        
        for i, r in enumerate(researchers, 1):
            table.add_row(str(i), r["name"], r["domain"], f"{r['frequency']:.3f} Hz")
        
        self.console.print(table)
    
    async def cmd_research(self, args: list[str]) -> None:
        """Conduct research."""
        if not args:
            self.console.print("[red]Usage: research <topic>[/red]")
            return
        
        topic = " ".join(args)
        self.console.print(f"\n[bold]Researching:[/bold] {topic}")
        
        with self.console.status("[bold green]Conducting research..."):
            result = await self.lab.conduct_research(topic)
        
        if result:
            self.console.print(Panel(result["summary"], title="Research Results", border_style="green"))
    
    async def cmd_paper(self, args: list[str]) -> None:
        """Paper management."""
        if not args:
            self.console.print("[red]Usage: paper [new|list|view] ...[/red]")
            return
        
        subcmd = args[0]
        subargs = args[1:]
        
        if subcmd == "new":
            if not subargs:
                self.console.print("[red]Usage: paper new <title>[/red]")
                return
            title = " ".join(subargs)
            paper_id = self.lab.create_paper(title)
            self.console.print(f"[green]✓[/green] Paper created: [bold]{paper_id}[/bold]")
        
        elif subcmd == "list":
            papers = self.lab.list_papers()
            if papers:
                from rich.table import Table
                table = Table(title="Papers")
                table.add_column("ID", style="cyan")
                table.add_column("Title")
                table.add_column("Status")
                for p in papers:
                    table.add_row(p["id"], p["title"], p["status"])
                self.console.print(table)
            else:
                self.console.print("[dim]No papers found[/dim]")
    
    async def cmd_list(self, args: list[str]) -> None:
        """List recent items."""
        await self.cmd_paper(["list"])
    
    async def cmd_frequency(self, args: list[str]) -> None:
        """Show frequency information."""
        import time
        
        beat = int(time.time()) % 1000
        ring = beat // 100
        
        freq_text = f"""
[bold gold1]Frequency State[/bold gold1]

Base Frequency: [cyan]{PHI_POWERS[13]:.6f} Hz[/cyan]
φ Power: [green]φ¹³[/green]
Current Beat: [yellow]{beat}[/yellow]
Current Ring: [magenta]{ring}[/magenta]

[dim]φ = {PHI}[/dim]
"""
        self.console.print(Panel(freq_text, border_style="gold1"))
    
    async def cmd_clear(self, args: list[str]) -> None:
        """Clear the screen."""
        self.console.clear()
