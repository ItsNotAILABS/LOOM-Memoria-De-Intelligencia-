"""
╔══════════════════════════════════════════════════════════════════════════════╗
║                        LAB ACCESS INTERFACE                                  ║
║          Direct Access to the Full Research Laboratory Platform             ║
║                                                                              ║
║  "Aditus Laboratorii — Gateway to Sovereign Intelligence Research"          ║
╚══════════════════════════════════════════════════════════════════════════════╝

Protocol: PROT-371 - Lab Access Protocol
Frequency: φ¹¹ = 199.005 Hz (Transcendent)
Layer: COLONY (Layer 10) to COSMIC (Layer 12)

The Lab Access Interface provides:
  - Direct entry into the research lab
  - Navigation between lab areas
  - Session management and tracking
  - Researcher interaction interface
  - Paper workflow commands

ATTRIBUTION:
    Created by: Alfredo "Freddy" Medina Hernandez
    Organization: Medina Tech (Dallas, TX)
    Law: L-130 — Before recomposition, trace to primitive.
    φ = 1.6180339887498948482
"""

import os
import json
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any, Callable
from enum import Enum
from datetime import datetime
import hashlib

from . import (
    PHI, PHI_11, LAB_FREQUENCY, SCHUMANN,
    ResearcherRole, PaperState, LabAreaType,
    LabResearcher, ResearchPaper, LabArea,
    LAB_RESEARCHERS, LAB_AREAS, RESEARCH_PROTOCOLS,
    ResearchLabPlatform
)


# ═══════════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════

ACCESS_PROTOCOL = "PROT-371"
ACCESS_FREQUENCY = PHI_11  # 199.005 Hz


class AccessLevel(Enum):
    """Lab access levels."""
    VISITOR = "visitor"           # Read-only access
    RESEARCHER = "researcher"     # Standard researcher access
    SENIOR = "senior"             # Senior researcher access
    DIRECTOR = "director"         # Director-level access
    ADMIN = "admin"               # Full administrative access


class SessionState(Enum):
    """Session states."""
    INACTIVE = "inactive"
    ACTIVE = "active"
    IN_AREA = "in_area"
    WORKING = "working"
    SUSPENDED = "suspended"


@dataclass
class LabSession:
    """A lab access session."""
    
    session_id: str
    user_id: str
    access_level: AccessLevel
    
    # Session state
    state: SessionState = SessionState.INACTIVE
    current_area: Optional[str] = None
    current_researcher: Optional[str] = None
    
    # Work tracking
    active_papers: List[str] = field(default_factory=list)
    commands_executed: int = 0
    
    # Timestamps
    started_at: datetime = field(default_factory=datetime.now)
    last_activity: datetime = field(default_factory=datetime.now)
    
    # Session frequency (aligned to PHI)
    frequency_hz: float = ACCESS_FREQUENCY
    
    def update_activity(self):
        """Update last activity timestamp."""
        self.last_activity = datetime.now()
        self.commands_executed += 1
    
    def get_duration_minutes(self) -> float:
        """Get session duration in minutes."""
        delta = datetime.now() - self.started_at
        return delta.total_seconds() / 60.0


class LabAccess:
    """
    Lab Access Interface.
    
    PROT-371: Provides direct access to the Research Lab Platform.
    """
    
    def __init__(self):
        self.platform = ResearchLabPlatform()
        self.sessions: Dict[str, LabSession] = {}
        self.active_session: Optional[str] = None
        
        # Access configuration
        self.protocol = ACCESS_PROTOCOL
        self.frequency = ACCESS_FREQUENCY
        self.latin_name = "ADITUS LABORATORII"
        
    # ═══════════════════════════════════════════════════════════════════════════
    # SESSION MANAGEMENT
    # ═══════════════════════════════════════════════════════════════════════════
    
    def create_session(
        self,
        user_id: str = "DIRECTOR_MEDINA",
        access_level: AccessLevel = AccessLevel.DIRECTOR
    ) -> LabSession:
        """Create a new lab session."""
        session_id = f"SESSION-{len(self.sessions) + 1:04d}-{datetime.now().strftime('%H%M%S')}"
        
        session = LabSession(
            session_id=session_id,
            user_id=user_id,
            access_level=access_level,
            state=SessionState.ACTIVE
        )
        
        self.sessions[session_id] = session
        self.active_session = session_id
        
        return session
    
    def get_session(self, session_id: Optional[str] = None) -> Optional[LabSession]:
        """Get a session by ID or the active session."""
        if session_id:
            return self.sessions.get(session_id)
        if self.active_session:
            return self.sessions.get(self.active_session)
        return None
    
    def end_session(self, session_id: Optional[str] = None) -> bool:
        """End a lab session."""
        session = self.get_session(session_id)
        if not session:
            return False
        
        session.state = SessionState.INACTIVE
        if self.active_session == session.session_id:
            self.active_session = None
        
        return True
    
    # ═══════════════════════════════════════════════════════════════════════════
    # LAB ENTRY
    # ═══════════════════════════════════════════════════════════════════════════
    
    def enter_lab(
        self,
        user_id: str = "DIRECTOR_MEDINA",
        area_id: str = "LABORATORIUM_PRINCIPALE"
    ) -> Dict[str, Any]:
        """
        Enter the research lab.
        
        This is the primary entry point for lab access.
        """
        # Create or get session
        session = self.get_session()
        if not session:
            session = self.create_session(user_id)
        
        # Enter the specified area
        return self.enter_area(area_id, session.session_id)
    
    def enter_area(
        self,
        area_id: str,
        session_id: Optional[str] = None
    ) -> Dict[str, Any]:
        """Enter a specific lab area."""
        session = self.get_session(session_id)
        if not session:
            return {"error": "No active session", "success": False}
        
        if area_id not in LAB_AREAS:
            return {"error": f"Unknown area: {area_id}", "success": False}
        
        area = LAB_AREAS[area_id]
        session.current_area = area_id
        session.state = SessionState.IN_AREA
        session.update_activity()
        
        # Get occupants (researchers in this area)
        occupants = self._get_area_occupants(area_id)
        
        return {
            "success": True,
            "area": {
                "id": area.area_id,
                "name": area.name,
                "latin_name": area.latin_name,
                "type": area.area_type.value,
                "capacity": area.capacity,
                "equipment": area.equipment
            },
            "occupants": occupants,
            "session_id": session.session_id,
            "message": f"Entered {area.name} ({area.latin_name})"
        }
    
    def _get_area_occupants(self, area_id: str) -> List[Dict[str, Any]]:
        """Get researchers associated with an area."""
        area = LAB_AREAS.get(area_id)
        if not area:
            return []
        
        # Map area types to typical researchers
        area_researcher_map = {
            LabAreaType.DIRECTOR_OFFICE: [ResearcherRole.LAB_DIRECTOR],
            LabAreaType.WRITING_CENTER: [ResearcherRole.PAPER_WRITER, ResearcherRole.TECHNICAL_WRITER, ResearcherRole.EDITOR],
            LabAreaType.REVIEW_CHAMBER: [ResearcherRole.REVIEWER, ResearcherRole.PEER_REVIEWER],
            LabAreaType.THEORY_ROOM: [ResearcherRole.THEORIST],
            LabAreaType.DATA_CENTER: [ResearcherRole.DATA_ANALYST],
            LabAreaType.LIBRARY: [ResearcherRole.ARCHIVIST],
            LabAreaType.MAIN_LAB: list(ResearcherRole),  # All roles welcome
        }
        
        roles = area_researcher_map.get(area.area_type, [])
        occupants = [
            {
                "id": r.researcher_id,
                "name": r.name,
                "latin_name": r.latin_name,
                "role": r.role.value,
                "specializations": r.specializations[:3]  # Top 3
            }
            for r in self.platform.researchers.values()
            if r.role in roles
        ]
        
        return occupants
    
    # ═══════════════════════════════════════════════════════════════════════════
    # RESEARCHER INTERACTION
    # ═══════════════════════════════════════════════════════════════════════════
    
    def list_researchers(self) -> List[Dict[str, Any]]:
        """List all lab researchers."""
        session = self.get_session()
        if session:
            session.update_activity()
        
        return self.platform.list_researchers()
    
    def get_researcher(self, researcher_id: str) -> Optional[Dict[str, Any]]:
        """Get detailed info about a researcher."""
        session = self.get_session()
        if session:
            session.update_activity()
        
        researcher = self.platform.get_researcher(researcher_id)
        if not researcher:
            return None
        
        return {
            "researcher_id": researcher.researcher_id,
            "name": researcher.name,
            "latin_name": researcher.latin_name,
            "role": researcher.role.value,
            "protocol": researcher.protocol,
            "frequency_hz": researcher.frequency_hz,
            "layer": researcher.layer,
            "specializations": researcher.specializations,
            "h_index": researcher.h_index,
            "publications_count": len(researcher.publications),
            "current_projects_count": len(researcher.current_projects),
            "papers_in_progress": researcher.papers_in_progress
        }
    
    def talk_to_researcher(
        self,
        researcher_id: str,
        message: str
    ) -> Dict[str, Any]:
        """Interact with a researcher."""
        session = self.get_session()
        if session:
            session.update_activity()
            session.current_researcher = researcher_id
        
        researcher = self.platform.get_researcher(researcher_id)
        if not researcher:
            return {"error": f"Researcher not found: {researcher_id}"}
        
        # Generate response based on researcher role
        response = self._generate_researcher_response(researcher, message)
        
        return {
            "researcher": researcher.name,
            "latin_name": researcher.latin_name,
            "role": researcher.role.value,
            "response": response,
            "specializations": researcher.specializations
        }
    
    def _generate_researcher_response(
        self,
        researcher: LabResearcher,
        message: str
    ) -> str:
        """Generate a response from a researcher based on their role."""
        role_responses = {
            ResearcherRole.LAB_DIRECTOR: f"As Director, I oversee all lab operations. {researcher.name} is ready to assist with strategic direction.",
            ResearcherRole.PRINCIPAL_INVESTIGATOR: f"I lead the core research initiatives on sovereign intelligence. What aspect would you like to explore?",
            ResearcherRole.PAPER_WRITER: f"I can help draft and structure your papers. My specializations: {', '.join(researcher.specializations[:3])}.",
            ResearcherRole.TECHNICAL_WRITER: f"I handle protocol documentation and technical specifications. Let me help with implementation details.",
            ResearcherRole.REVIEWER: f"I ensure quality and coherence in all publications. Ready to review your work.",
            ResearcherRole.THEORIST: f"I develop theoretical foundations. Let's explore the mathematical principles.",
            ResearcherRole.DATA_ANALYST: f"I analyze patterns and generate insights. What data would you like me to examine?",
            ResearcherRole.ARCHIVIST: f"I maintain the research archives. I can retrieve any historical papers or protocols."
        }
        
        base_response = role_responses.get(
            researcher.role,
            f"{researcher.name} acknowledges your message and is ready to assist."
        )
        
        return base_response
    
    # ═══════════════════════════════════════════════════════════════════════════
    # PAPER MANAGEMENT
    # ═══════════════════════════════════════════════════════════════════════════
    
    def list_papers(self) -> List[Dict[str, Any]]:
        """List all papers in the lab."""
        session = self.get_session()
        if session:
            session.update_activity()
        
        return [
            {
                "paper_id": p.paper_id,
                "title": p.title,
                "latin_title": p.latin_title,
                "state": p.state.value,
                "primary_author": p.primary_author,
                "sections_count": len(p.sections),
                "scc_score": p.scc_score
            }
            for p in self.platform.papers.values()
        ]
    
    def create_paper(
        self,
        title: str,
        latin_title: str,
        abstract: str = "",
        author_id: str = "SCRIPTOR_SENIOR",
        protocol: str = ""
    ) -> Dict[str, Any]:
        """Create a new research paper."""
        session = self.get_session()
        if session:
            session.update_activity()
        
        paper = self.platform.create_paper(
            title=title,
            latin_title=latin_title,
            primary_author=author_id,
            abstract=abstract,
            protocol=protocol
        )
        
        if session:
            session.active_papers.append(paper.paper_id)
        
        return {
            "success": True,
            "paper_id": paper.paper_id,
            "title": paper.title,
            "latin_title": paper.latin_title,
            "state": paper.state.value,
            "message": f"Paper '{title}' created successfully"
        }
    
    def write_paper_section(
        self,
        paper_id: str,
        section_name: str,
        content: str,
        writer_id: str = "SCRIPTOR_SENIOR"
    ) -> Dict[str, Any]:
        """Write a section of a paper."""
        session = self.get_session()
        if session:
            session.update_activity()
        
        success = self.platform.write_section(
            paper_id=paper_id,
            section_name=section_name,
            content=content,
            writer_id=writer_id
        )
        
        if not success:
            return {"error": f"Could not write section to paper {paper_id}", "success": False}
        
        return {
            "success": True,
            "paper_id": paper_id,
            "section": section_name,
            "content_length": len(content),
            "message": f"Section '{section_name}' written successfully"
        }
    
    def submit_paper(self, paper_id: str) -> Dict[str, Any]:
        """Submit a paper for review."""
        session = self.get_session()
        if session:
            session.update_activity()
        
        success = self.platform.submit_for_review(paper_id)
        
        if not success:
            return {"error": f"Could not submit paper {paper_id}", "success": False}
        
        paper = self.platform.papers.get(paper_id)
        return {
            "success": True,
            "paper_id": paper_id,
            "state": paper.state.value if paper else "unknown",
            "reviewers": paper.reviewers if paper else [],
            "message": f"Paper {paper_id} submitted for review"
        }
    
    # ═══════════════════════════════════════════════════════════════════════════
    # LAB STATUS
    # ═══════════════════════════════════════════════════════════════════════════
    
    def get_lab_status(self) -> Dict[str, Any]:
        """Get comprehensive lab status."""
        session = self.get_session()
        if session:
            session.update_activity()
        
        status = self.platform.get_lab_status()
        status["access"] = {
            "protocol": self.protocol,
            "latin_name": self.latin_name,
            "frequency_hz": self.frequency,
            "active_sessions": len([s for s in self.sessions.values() if s.state == SessionState.ACTIVE])
        }
        
        if session:
            status["current_session"] = {
                "session_id": session.session_id,
                "user_id": session.user_id,
                "state": session.state.value,
                "current_area": session.current_area,
                "duration_minutes": round(session.get_duration_minutes(), 2),
                "commands_executed": session.commands_executed
            }
        
        return status
    
    def list_areas(self) -> List[Dict[str, Any]]:
        """List all lab areas."""
        session = self.get_session()
        if session:
            session.update_activity()
        
        return [
            {
                "id": a.area_id,
                "name": a.name,
                "latin_name": a.latin_name,
                "type": a.area_type.value,
                "capacity": a.capacity,
                "equipment_count": len(a.equipment),
                "protocol": f"PROT-{359 + i}"
            }
            for i, a in enumerate(LAB_AREAS.values())
        ]

    def list_target_identifiers(self) -> List[Dict[str, Any]]:
        """List canonical research target identifiers."""
        return self.platform.list_target_identifiers()

    def intake_topic(
        self,
        topic: str,
        target_identifier: str = "RESEARCH_WEBSITES",
        requested_by: str = "DIRECTOR_MEDINA",
        abstract: str = ""
    ) -> Dict[str, Any]:
        """Intake a topic and create an executable research program."""
        session = self.get_session()
        if session:
            session.update_activity()

        if not topic:
            return {"success": False, "error": "topic is required"}

        result = self.platform.intake_research_topic(
            topic=topic,
            target_identifier=target_identifier,
            requested_by=requested_by,
            abstract=abstract
        )
        return {"success": True, "program": result}

    def list_programs(self) -> Dict[str, Any]:
        """List active research programs."""
        session = self.get_session()
        if session:
            session.update_activity()
        return {"programs": self.platform.list_research_programs()}

    def list_live_organisms(self) -> Dict[str, Any]:
        """List live research website organisms."""
        session = self.get_session()
        if session:
            session.update_activity()
        return {"live_organisms": self.platform.list_live_organisms()}

    def list_intelligence_contracts(self) -> Dict[str, Any]:
        """List universal organism intelligence contracts."""
        session = self.get_session()
        if session:
            session.update_activity()
        return {"contracts": self.platform.list_intelligence_contracts()}

    def list_runtime_artifacts(self) -> Dict[str, Any]:
        """List deployable runtime artifacts emitted by publication."""
        session = self.get_session()
        if session:
            session.update_activity()
        return {"artifacts": self.platform.list_runtime_artifacts()}

    def governance_audit(self) -> Dict[str, Any]:
        """List governance audit events across intake/execute/publish gates."""
        session = self.get_session()
        if session:
            session.update_activity()
        return {"audit_events": self.platform.list_governance_audit_trail()}

    def coordination_status(self) -> Dict[str, Any]:
        """Get sovereign coordination layer status."""
        session = self.get_session()
        if session:
            session.update_activity()
        return {"coordination": self.platform.get_coordination_status()}

    def provision_website_organism(
        self,
        website_name: str,
        website_url: str,
        topic: str,
        requested_by: str = "DIRECTOR_MEDINA"
    ) -> Dict[str, Any]:
        """Provision one live organism per research website."""
        session = self.get_session()
        if session:
            session.update_activity()

        if not website_name or not website_url or not topic:
            return {"success": False, "error": "website_name, website_url, and topic are required"}

        organism = self.platform.provision_live_website_organism(
            website_name=website_name,
            website_url=website_url,
            topic=topic,
            requested_by=requested_by
        )
        return {"success": True, "organism": organism}

    def advance_program(
        self,
        program_id: str,
        action: str,
        section_name: Optional[str] = None,
        content: Optional[str] = None
    ) -> Dict[str, Any]:
        """Advance an existing research program lifecycle."""
        session = self.get_session()
        if session:
            session.update_activity()
        return self.platform.advance_research_program(
            program_id=program_id,
            action=action,
            section_name=section_name,
            content=content
        )
    
    # ═══════════════════════════════════════════════════════════════════════════
    # COMMAND INTERFACE
    # ═══════════════════════════════════════════════════════════════════════════
    
    def execute_command(self, command: str, *args, **kwargs) -> Dict[str, Any]:
        """
        Execute a lab command.
        
        Commands:
            enter [area] - Enter the lab or a specific area
            status - Get lab status
            areas - List lab areas
            researchers - List researchers
            researcher <id> - Get researcher details
            papers - List papers
            targets - List normalized target identifiers
            programs - List research programs
            organisms - List live website organisms
            contracts - List intelligence contracts
            artifacts - List runtime artifacts
            audit - List governance audit events
            coordination - Coordination layer status
            intake-topic <topic> [target] - Intake new research program
            program-action <program_id> <action> - Advance program lifecycle
            provision-organism <website_name> <website_url> <topic> - Create live website organism
            create-paper <title> <latin_title> - Create a paper
            write <paper_id> <section> <content> - Write paper section
            submit <paper_id> - Submit paper for review
            exit - End session
        """
        session = self.get_session()
        if session:
            session.update_activity()
        
        command = command.lower().strip()
        
        command_map = {
            "enter": lambda: self.enter_lab(*args) if args else self.enter_lab(),
            "status": lambda: self.get_lab_status(),
            "areas": lambda: {"areas": self.list_areas()},
            "researchers": lambda: {"researchers": self.list_researchers()},
            "papers": lambda: {"papers": self.list_papers()},
            "targets": lambda: {"targets": self.list_target_identifiers()},
            "programs": lambda: self.list_programs(),
            "organisms": lambda: self.list_live_organisms(),
            "contracts": lambda: self.list_intelligence_contracts(),
            "artifacts": lambda: self.list_runtime_artifacts(),
            "audit": lambda: self.governance_audit(),
            "coordination": lambda: self.coordination_status(),
            "exit": lambda: {"ended": self.end_session(), "message": "Session ended"},
            "help": lambda: {"commands": list(command_map.keys())}
        }
        
        if command in command_map:
            return command_map[command]()
        
        # Handle parameterized commands
        if command.startswith("researcher ") and len(command.split()) > 1:
            researcher_id = command.split()[1].upper()
            result = self.get_researcher(researcher_id)
            return result if result else {"error": f"Researcher not found: {researcher_id}"}

        if command.startswith("intake-topic "):
            parts = command.split(maxsplit=2)
            if len(parts) < 2:
                return {"error": "Usage: intake-topic <topic> [target_identifier]"}
            topic = parts[1]
            target = parts[2] if len(parts) > 2 else "RESEARCH_WEBSITES"
            return self.intake_topic(topic=topic, target_identifier=target)

        if command.startswith("program-action "):
            parts = command.split(maxsplit=3)
            if len(parts) < 3:
                return {"error": "Usage: program-action <program_id> <action> [section:content]"}
            program_id = parts[1].upper()
            action = parts[2]
            section_name = None
            content = None
            if len(parts) == 4 and ":" in parts[3]:
                section_name, content = parts[3].split(":", 1)
            return self.advance_program(program_id, action, section_name, content)

        if command.startswith("provision-organism "):
            parts = command.split(maxsplit=3)
            if len(parts) < 4:
                return {"error": "Usage: provision-organism <website_name> <website_url> <topic>"}
            return self.provision_website_organism(
                website_name=parts[1],
                website_url=parts[2],
                topic=parts[3]
            )

        return {"error": f"Unknown command: {command}", "help": "Use 'help' for available commands"}


# ═══════════════════════════════════════════════════════════════════════════════
# GLOBAL LAB ACCESS INSTANCE
# ═══════════════════════════════════════════════════════════════════════════════

# Singleton lab access
_lab_access: Optional[LabAccess] = None


def get_lab_access() -> LabAccess:
    """Get or create the global lab access instance."""
    global _lab_access
    if _lab_access is None:
        _lab_access = LabAccess()
    return _lab_access


def enter_lab(
    user_id: str = "DIRECTOR_MEDINA",
    area_id: str = "LABORATORIUM_PRINCIPALE"
) -> Dict[str, Any]:
    """Quick entry into the lab."""
    return get_lab_access().enter_lab(user_id, area_id)


def lab_status() -> Dict[str, Any]:
    """Get lab status."""
    return get_lab_access().get_lab_status()


def lab_command(command: str, *args, **kwargs) -> Dict[str, Any]:
    """Execute a lab command."""
    return get_lab_access().execute_command(command, *args, **kwargs)


# ═══════════════════════════════════════════════════════════════════════════════
# MODULE EXPORTS
# ═══════════════════════════════════════════════════════════════════════════════

__all__ = [
    "AccessLevel",
    "SessionState",
    "LabSession",
    "LabAccess",
    "get_lab_access",
    "enter_lab",
    "lab_status",
    "lab_command",
    "ACCESS_PROTOCOL",
    "ACCESS_FREQUENCY"
]
