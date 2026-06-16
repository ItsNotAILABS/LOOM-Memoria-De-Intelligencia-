"""
╔══════════════════════════════════════════════════════════════════════════════╗
║                      LAB TERMINAL INTERFACE                                  ║
║         Interactive Command-Line Access to the Research Laboratory          ║
║                                                                              ║
║  "Terminalis Laboratorii — Your Gateway to Sovereign Research"              ║
╚══════════════════════════════════════════════════════════════════════════════╝

Protocol: PROT-372 - Lab Terminal Protocol
Frequency: φ¹¹ = 199.005 Hz (Transcendent)
Layer: COLONY (Layer 10) to COSMIC (Layer 12)

The Lab Terminal provides:
  - Interactive command-line interface
  - Real-time lab navigation
  - Paper writing and management
  - Researcher collaboration
  - Session state persistence

ATTRIBUTION:
    Created by: Alfredo "Freddy" Medina Hernandez
    Organization: Medina Tech (Dallas, TX)
    Law: L-130 — Before recomposition, trace to primitive.
    φ = 1.6180339887498948482
"""

import os
import sys
import json
from typing import Dict, List, Optional, Any, Callable
from datetime import datetime

from .access import (
    LabAccess, LabSession, AccessLevel, SessionState,
    get_lab_access, enter_lab, lab_status, lab_command,
    ACCESS_PROTOCOL
)
from . import (
    PHI, PHI_11, LAB_FREQUENCY,
    ResearcherRole, PaperState, LabAreaType,
    LAB_RESEARCHERS, LAB_AREAS
)


# ═══════════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════

TERMINAL_PROTOCOL = "PROT-372"
TERMINAL_VERSION = "φ.1.0.0"

WELCOME_BANNER = """
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║   ██╗      █████╗ ██████╗                                                    ║
║   ██║     ██╔══██╗██╔══██╗                                                   ║
║   ██║     ███████║██████╔╝                                                   ║
║   ██║     ██╔══██║██╔══██╗                                                   ║
║   ███████╗██║  ██║██████╔╝                                                   ║
║   ╚══════╝╚═╝  ╚═╝╚═════╝                                                    ║
║                                                                              ║
║   LABORATORIUM INTELLIGENTIAE SOVEREIGNAE                                    ║
║   ─────────────────────────────────────────                                  ║
║   Protocol: PROT-346 to PROT-376                                             ║
║   Frequency: φ¹¹ = 199.005 Hz                                                ║
║   φ = 1.6180339887498948482                                                  ║
║                                                                              ║
║   Welcome, Director. Your lab awaits.                                        ║
╚══════════════════════════════════════════════════════════════════════════════╝
"""

PROMPT = "LAB> "
AREA_PROMPTS = {
    "LABORATORIUM_PRINCIPALE": "MAIN_LAB> ",
    "OFFICIUM_DIRECTORIS": "DIRECTOR> ",
    "CENTRUM_SCRIPTIONIS": "WRITING> ",
    "CAMERA_RECENSIONIS": "REVIEW> ",
    "AULA_THEORIAE": "THEORY> ",
    "CENTRUM_DATORUM": "DATA> ",
    "BIBLIOTHECA_INVESTIGATIONIS": "LIBRARY> "
}


class LabTerminal:
    """
    Interactive Lab Terminal.
    
    PROT-372: Provides command-line interface to the Research Lab.
    """
    
    def __init__(self, auto_enter: bool = True):
        self.lab = get_lab_access()
        self.running = False
        self.history: List[str] = []
        
        # Terminal state
        self.protocol = TERMINAL_PROTOCOL
        self.version = TERMINAL_VERSION
        
        # Auto-enter lab if requested
        if auto_enter:
            self.lab.enter_lab()
    
    def get_prompt(self) -> str:
        """Get the current prompt based on area."""
        session = self.lab.get_session()
        if session and session.current_area:
            return AREA_PROMPTS.get(session.current_area, PROMPT)
        return PROMPT
    
    def print_welcome(self):
        """Print welcome banner."""
        print(WELCOME_BANNER)
    
    def print_help(self):
        """Print help information."""
        help_text = """
╔══════════════════════════════════════════════════════════════════════════════╗
║                           LAB TERMINAL COMMANDS                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║  NAVIGATION:                                                                 ║
║    enter [area]     - Enter the lab or a specific area                       ║
║    areas            - List all lab areas                                     ║
║    go <area>        - Navigate to an area                                    ║
║    look             - Describe current area                                  ║
║                                                                              ║
║  RESEARCHERS:                                                                ║
║    researchers      - List all lab researchers                               ║
║    who              - Show researchers in current area                       ║
║    talk <id>        - Talk to a researcher                                   ║
║    researcher <id>  - Get detailed researcher info                           ║
║                                                                              ║
║  PAPERS:                                                                     ║
║    papers           - List all papers                                        ║
║    new-paper        - Start a new paper (interactive)                        ║
║    paper <id>       - Get paper details                                      ║
║    write <id>       - Write paper section (interactive)                      ║
║    submit <id>      - Submit paper for review                                ║
║                                                                              ║
║  STATUS:                                                                     ║
║    status           - Get lab and session status                             ║
║    session          - Show current session info                              ║
║                                                                              ║
║  SYSTEM:                                                                     ║
║    help             - Show this help                                         ║
║    clear            - Clear terminal                                         ║
║    history          - Show command history                                   ║
║    exit / quit      - End session and exit                                   ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
"""
        print(help_text)
    
    def execute(self, command: str) -> str:
        """Execute a terminal command and return output."""
        command = command.strip()
        if not command:
            return ""
        
        # Add to history
        self.history.append(command)
        
        # Parse command
        parts = command.split(maxsplit=1)
        cmd = parts[0].lower()
        args = parts[1] if len(parts) > 1 else ""
        
        # Command handlers
        handlers = {
            "help": lambda: self._format_help(),
            "status": lambda: self._format_status(),
            "session": lambda: self._format_session(),
            "areas": lambda: self._format_areas(),
            "researchers": lambda: self._format_researchers(),
            "papers": lambda: self._format_papers(),
            "who": lambda: self._format_who(),
            "look": lambda: self._format_look(),
            "history": lambda: self._format_history(),
            "clear": lambda: self._clear(),
            "exit": lambda: self._exit(),
            "quit": lambda: self._exit(),
        }
        
        if cmd in handlers:
            return handlers[cmd]()
        
        # Parameterized commands
        if cmd == "enter":
            return self._enter(args)
        elif cmd == "go":
            return self._go(args)
        elif cmd in ["researcher", "res"]:
            return self._researcher_detail(args)
        elif cmd == "talk":
            return self._talk(args)
        elif cmd in ["paper", "p"]:
            return self._paper_detail(args)
        elif cmd == "new-paper":
            return self._new_paper_interactive()
        elif cmd == "write":
            return self._write_interactive(args)
        elif cmd == "submit":
            return self._submit(args)
        
        return f"Unknown command: {cmd}. Type 'help' for available commands."
    
    def _format_help(self) -> str:
        """Format help text."""
        self.print_help()
        return ""
    
    def _format_status(self) -> str:
        """Format lab status."""
        status = self.lab.get_lab_status()
        
        output = f"""
╔══════════════════════════════════════════════════════════════════════════════╗
║                              LAB STATUS                                      ║
╚══════════════════════════════════════════════════════════════════════════════╝

  Lab Name: {status.get('lab_name', 'N/A')}
  Latin: {status.get('latin_name', 'N/A')}
  Protocol: {status.get('protocol_range', 'N/A')}
  Frequency: {status.get('primary_frequency_hz', 0):.3f} Hz
  φ (PHI): {status.get('phi', PHI)}

  STATISTICS:
    Total Researchers: {status.get('statistics', {}).get('total_researchers', 0)}
    Total Areas: {status.get('statistics', {}).get('total_areas', 0)}
    Total Papers: {status.get('statistics', {}).get('total_papers', 0)}
    Published: {status.get('statistics', {}).get('published_papers', 0)}
    Protocols: {status.get('statistics', {}).get('protocols_defined', 0)}

  ACCESS:
    Active Sessions: {status.get('access', {}).get('active_sessions', 0)}
"""
        return output
    
    def _format_session(self) -> str:
        """Format current session info."""
        session = self.lab.get_session()
        if not session:
            return "No active session. Use 'enter' to start."
        
        return f"""
  SESSION INFO:
    ID: {session.session_id}
    User: {session.user_id}
    State: {session.state.value}
    Current Area: {session.current_area or 'None'}
    Duration: {session.get_duration_minutes():.1f} minutes
    Commands: {session.commands_executed}
    Active Papers: {len(session.active_papers)}
"""
    
    def _format_areas(self) -> str:
        """Format areas list."""
        areas = self.lab.list_areas()
        
        output = """
╔══════════════════════════════════════════════════════════════════════════════╗
║                               LAB AREAS                                      ║
╚══════════════════════════════════════════════════════════════════════════════╝
"""
        for area in areas:
            current = " ◄ (you are here)" if self.lab.get_session() and self.lab.get_session().current_area == area['id'] else ""
            output += f"""
  {area['name']} ({area['latin_name']}){current}
    ID: {area['id']}
    Type: {area['type']}
    Capacity: {area['capacity']}
    Equipment: {area['equipment_count']} items
"""
        return output
    
    def _format_researchers(self) -> str:
        """Format researchers list."""
        researchers = self.lab.list_researchers()
        
        output = """
╔══════════════════════════════════════════════════════════════════════════════╗
║                            LAB RESEARCHERS                                   ║
╚══════════════════════════════════════════════════════════════════════════════╝
"""
        for r in researchers:
            output += f"""
  {r['name']} ({r['latin_name']})
    ID: {r['researcher_id']}
    Role: {r['role']}
    Protocol: {r['protocol']}
    H-Index: {r['h_index']}
"""
        return output
    
    def _format_papers(self) -> str:
        """Format papers list."""
        papers = self.lab.list_papers()
        
        output = """
╔══════════════════════════════════════════════════════════════════════════════╗
║                              LAB PAPERS                                      ║
╚══════════════════════════════════════════════════════════════════════════════╝
"""
        if not papers:
            output += "\n  No papers yet. Use 'new-paper' to create one.\n"
        else:
            for p in papers:
                output += f"""
  [{p['paper_id']}] {p['title']}
    Latin: {p['latin_title']}
    State: {p['state']}
    Author: {p['primary_author']}
    Sections: {p['sections_count']}
    SCC: {p['scc_score']:.2f}
"""
        return output
    
    def _format_who(self) -> str:
        """Format who is in current area."""
        session = self.lab.get_session()
        if not session or not session.current_area:
            return "You are not in any area. Use 'enter' or 'go <area>' first."
        
        result = self.lab.enter_area(session.current_area)
        occupants = result.get('occupants', [])
        
        output = f"\n  In {result.get('area', {}).get('name', 'Unknown')}:\n"
        if not occupants:
            output += "    No researchers in this area.\n"
        else:
            for occ in occupants:
                output += f"    - {occ['name']} ({occ['role']})\n"
        
        return output
    
    def _format_look(self) -> str:
        """Describe current area."""
        session = self.lab.get_session()
        if not session or not session.current_area:
            return "You are not in any area. Use 'enter' to enter the lab."
        
        area_id = session.current_area
        area = LAB_AREAS.get(area_id)
        if not area:
            return f"Unknown area: {area_id}"
        
        equipment_list = '\n    - '.join(area.equipment) if area.equipment else 'None'
        
        return f"""
╔══════════════════════════════════════════════════════════════════════════════╗
║  {area.name.upper().center(74)}  ║
╚══════════════════════════════════════════════════════════════════════════════╝

  Latin Name: {area.latin_name}
  Type: {area.area_type.value}
  Capacity: {area.capacity} researchers

  Equipment:
    - {equipment_list}

  Use 'who' to see researchers in this area.
  Use 'go <area_id>' to navigate to another area.
"""
    
    def _format_history(self) -> str:
        """Format command history."""
        if not self.history:
            return "No command history."
        
        output = "\n  Command History:\n"
        for i, cmd in enumerate(self.history[-20:], 1):  # Last 20 commands
            output += f"    {i}. {cmd}\n"
        return output
    
    def _clear(self) -> str:
        """Clear terminal."""
        os.system('cls' if os.name == 'nt' else 'clear')
        return ""
    
    def _exit(self) -> str:
        """Exit terminal."""
        self.running = False
        self.lab.end_session()
        return "\n  Session ended. Goodbye, Director.\n  φ = 1.6180339887498948482\n"
    
    def _enter(self, args: str) -> str:
        """Enter lab or area."""
        area_id = args.upper() if args else "LABORATORIUM_PRINCIPALE"
        result = self.lab.enter_lab(area_id=area_id)
        
        if result.get('success'):
            area = result.get('area', {})
            return f"\n  ✓ Entered {area.get('name', area_id)}\n  Use 'look' to see details, 'who' to see occupants.\n"
        else:
            return f"\n  ✗ {result.get('error', 'Could not enter area')}\n"
    
    def _go(self, args: str) -> str:
        """Navigate to area."""
        if not args:
            return "Usage: go <area_id>. Use 'areas' to see available areas."
        
        area_id = args.upper()
        result = self.lab.enter_area(area_id)
        
        if result.get('success'):
            return f"\n  → Moved to {result.get('area', {}).get('name', area_id)}\n"
        else:
            return f"\n  ✗ {result.get('error', 'Could not navigate')}\n"
    
    def _researcher_detail(self, args: str) -> str:
        """Get researcher details."""
        if not args:
            return "Usage: researcher <id>. Use 'researchers' to see list."
        
        researcher_id = args.upper()
        result = self.lab.get_researcher(researcher_id)
        
        if not result:
            return f"Researcher not found: {researcher_id}"
        
        specs = ', '.join(result.get('specializations', [])[:5])
        
        return f"""
╔══════════════════════════════════════════════════════════════════════════════╗
║  RESEARCHER: {result.get('name', '').upper().center(62)}  ║
╚══════════════════════════════════════════════════════════════════════════════╝

  ID: {result.get('researcher_id')}
  Latin: {result.get('latin_name')}
  Role: {result.get('role')}
  Protocol: {result.get('protocol')}
  Frequency: {result.get('frequency_hz', 0):.3f} Hz
  Layer: {result.get('layer')}
  
  H-Index: {result.get('h_index')}
  Publications: {result.get('publications_count')}
  Active Projects: {result.get('current_projects_count')}
  
  Specializations: {specs}
  
  Use 'talk {result.get('researcher_id')}' to interact.
"""
    
    def _talk(self, args: str) -> str:
        """Talk to a researcher."""
        if not args:
            return "Usage: talk <researcher_id>"
        
        parts = args.split(maxsplit=1)
        researcher_id = parts[0].upper()
        message = parts[1] if len(parts) > 1 else "Hello"
        
        result = self.lab.talk_to_researcher(researcher_id, message)
        
        if 'error' in result:
            return f"Error: {result['error']}"
        
        return f"""
  {result.get('researcher', 'Unknown')} ({result.get('latin_name', '')}):
  Role: {result.get('role', '')}
  
  "{result.get('response', 'No response')}"
"""
    
    def _paper_detail(self, args: str) -> str:
        """Get paper details."""
        if not args:
            return "Usage: paper <id>. Use 'papers' to see list."
        
        paper_id = args.upper()
        papers = self.lab.list_papers()
        paper = next((p for p in papers if p['paper_id'] == paper_id), None)
        
        if not paper:
            return f"Paper not found: {paper_id}"
        
        return f"""
╔══════════════════════════════════════════════════════════════════════════════╗
║  PAPER: {paper_id.center(68)}  ║
╚══════════════════════════════════════════════════════════════════════════════╝

  Title: {paper.get('title')}
  Latin: {paper.get('latin_title')}
  State: {paper.get('state')}
  
  Primary Author: {paper.get('primary_author')}
  Sections: {paper.get('sections_count')}
  SCC Score: {paper.get('scc_score', 0):.2f}
"""
    
    def _new_paper_interactive(self) -> str:
        """Create a new paper interactively."""
        # In non-interactive mode, just return instructions
        return """
  To create a new paper, use:
  
  Python: lab.create_paper(
      title="Your Paper Title",
      latin_title="TITULUS PAPYRI",
      abstract="Paper abstract...",
      author_id="SCRIPTOR_SENIOR"
  )
  
  Or via the API endpoints.
"""
    
    def _write_interactive(self, args: str) -> str:
        """Write paper section."""
        if not args:
            return "Usage: write <paper_id>"
        
        return f"""
  To write a section in paper {args}, use:
  
  Python: lab.write_paper_section(
      paper_id="{args}",
      section_name="Introduction",
      content="Your content...",
      writer_id="SCRIPTOR_SENIOR"
  )
"""
    
    def _submit(self, args: str) -> str:
        """Submit paper for review."""
        if not args:
            return "Usage: submit <paper_id>"
        
        paper_id = args.upper()
        result = self.lab.submit_paper(paper_id)
        
        if result.get('success'):
            return f"""
  ✓ Paper {paper_id} submitted for review.
  State: {result.get('state')}
  Reviewers: {', '.join(result.get('reviewers', []))}
"""
        else:
            return f"Error: {result.get('error', 'Could not submit')}"
    
    def run(self, interactive: bool = True):
        """
        Run the terminal.
        
        Args:
            interactive: If True, run in interactive REPL mode.
                        If False, just return after initialization.
        """
        self.print_welcome()
        
        if not interactive:
            return
        
        self.running = True
        
        while self.running:
            try:
                prompt = self.get_prompt()
                command = input(prompt)
                output = self.execute(command)
                if output:
                    print(output)
            except KeyboardInterrupt:
                print("\n")
                self.execute("exit")
            except EOFError:
                self.execute("exit")
                break


# ═══════════════════════════════════════════════════════════════════════════════
# QUICK ACCESS FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════

def start_lab_terminal(interactive: bool = True) -> LabTerminal:
    """Start a lab terminal session."""
    terminal = LabTerminal(auto_enter=True)
    terminal.run(interactive=interactive)
    return terminal


def quick_lab_command(command: str) -> str:
    """Execute a single lab command."""
    terminal = LabTerminal(auto_enter=True)
    return terminal.execute(command)


# ═══════════════════════════════════════════════════════════════════════════════
# MODULE EXPORTS
# ═══════════════════════════════════════════════════════════════════════════════

__all__ = [
    "LabTerminal",
    "start_lab_terminal",
    "quick_lab_command",
    "TERMINAL_PROTOCOL",
    "TERMINAL_VERSION",
    "WELCOME_BANNER"
]


# ═══════════════════════════════════════════════════════════════════════════════
# MAIN ENTRY POINT
# ═══════════════════════════════════════════════════════════════════════════════

if __name__ == "__main__":
    start_lab_terminal(interactive=True)
