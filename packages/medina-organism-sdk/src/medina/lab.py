"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                          MEDINA SDK — RESEARCH LAB MODULE                                    ║
║               "Intelligentia Ex Primitivo — Intelligence From The Primitive"                 ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-346 — RESEARCH LAB SDK                                                      ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ¹³ = 521.002 Hz — Research Lab Layer                                 ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import asyncio
import hashlib
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Tuple

from .constants import PHI, PHI_POWERS, FIBONACCI, SOLFEGGIO


class ResearchDomain(str, Enum):
    """Research domains covered by the lab."""
    PHYSICS = "physics"
    MATHEMATICS = "mathematics"
    BIOLOGY = "biology"
    CHEMISTRY = "chemistry"
    ENGINEERING = "engineering"
    COMPUTER_SCIENCE = "computer_science"
    PHILOSOPHY = "philosophy"
    LINGUISTICS = "linguistics"
    ECONOMICS = "economics"
    PSYCHOLOGY = "psychology"
    SOCIOLOGY = "sociology"
    ANTHROPOLOGY = "anthropology"
    HISTORY = "history"


class ResearcherState(str, Enum):
    """State of a researcher."""
    IDLE = "idle"
    THINKING = "thinking"
    RESEARCHING = "researching"
    WRITING = "writing"
    REVIEWING = "reviewing"
    COLLABORATING = "collaborating"


@dataclass
class Researcher:
    """A researcher in the lab."""
    
    id: str
    name: str
    domain: ResearchDomain
    frequency: float
    state: ResearcherState = ResearcherState.IDLE
    specialties: List[str] = field(default_factory=list)
    papers_written: int = 0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.id,
            "name": self.name,
            "domain": self.domain.value,
            "frequency": self.frequency,
            "state": self.state.value,
            "specialties": self.specialties,
            "papers_written": self.papers_written,
        }


@dataclass
class Paper:
    """A research paper."""
    
    id: str
    title: str
    domain: ResearchDomain
    abstract: str = ""
    content: str = ""
    scc: float = 0.0
    protocol: str = ""
    status: str = "draft"
    lead_researcher: Optional[str] = None
    collaborators: List[str] = field(default_factory=list)
    created_at: float = field(default_factory=time.time)
    updated_at: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.id,
            "title": self.title,
            "domain": self.domain.value,
            "abstract": self.abstract,
            "scc": self.scc,
            "protocol": self.protocol,
            "status": self.status,
            "lead_researcher": self.lead_researcher,
            "collaborators": self.collaborators,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
        }


class ResearchLab:
    """
    The 13-Researcher AI Research Laboratory.
    
    FREQUENCY SIGNATURE: φ¹³ = 521.002 Hz
    PROTOCOL: PROT-346
    """
    
    def __init__(self, name: str = "LABORATORIUM SOVEREIGNUS") -> None:
        self.name = name
        self.frequency = PHI_POWERS[13]
        self.protocol = "PROT-346"
        
        # Initialize researchers
        self.researchers: Dict[str, Researcher] = {}
        self._init_researchers()
        
        # Papers repository
        self.papers: Dict[str, Paper] = {}
        
        # State
        self.active = True
        self.beat = 0
        self.ring = 0
    
    def _init_researchers(self) -> None:
        """Initialize the 13 researchers, one per domain."""
        domains = list(ResearchDomain)
        
        for i, domain in enumerate(domains):
            researcher_id = f"DR-{domain.value[:3].upper()}-{FIBONACCI[i + 3]}"
            freq = PHI_POWERS.get(i + 1, PHI ** (i + 1))
            
            researcher = Researcher(
                id=researcher_id,
                name=f"Dr. {domain.value.replace('_', ' ').title()}",
                domain=domain,
                frequency=freq,
                specialties=[
                    domain.value,
                    "analysis",
                    "synthesis",
                    f"phi-{i + 1}-methods",
                ],
            )
            self.researchers[researcher_id] = researcher
    
    def get_researcher(self, researcher_id: str) -> Optional[Researcher]:
        """Get a researcher by ID."""
        return self.researchers.get(researcher_id)
    
    def get_researcher_by_domain(self, domain: ResearchDomain) -> Optional[Researcher]:
        """Get the researcher for a specific domain."""
        for r in self.researchers.values():
            if r.domain == domain:
                return r
        return None
    
    def list_researchers(self) -> List[Dict[str, Any]]:
        """List all researchers."""
        return [r.to_dict() for r in self.researchers.values()]
    
    def create_paper(
        self,
        title: str,
        domain: ResearchDomain = ResearchDomain.COMPUTER_SCIENCE,
        abstract: str = "",
        lead_researcher: Optional[str] = None,
    ) -> Paper:
        """Create a new research paper."""
        paper_id = f"PAPER-{uuid.uuid4().hex[:8].upper()}"
        protocol_num = 400 + len(self.papers)
        
        paper = Paper(
            id=paper_id,
            title=title,
            domain=domain,
            abstract=abstract,
            protocol=f"PROT-{protocol_num}",
            lead_researcher=lead_researcher,
        )
        
        self.papers[paper_id] = paper
        
        # Update researcher if specified
        if lead_researcher and lead_researcher in self.researchers:
            self.researchers[lead_researcher].papers_written += 1
        
        return paper
    
    def get_paper(self, paper_id: str) -> Optional[Paper]:
        """Get a paper by ID."""
        return self.papers.get(paper_id)
    
    def list_papers(
        self,
        domain: Optional[ResearchDomain] = None,
        status: Optional[str] = None,
        limit: int = 20,
    ) -> List[Dict[str, Any]]:
        """List papers with optional filters."""
        papers = list(self.papers.values())
        
        if domain:
            papers = [p for p in papers if p.domain == domain]
        if status:
            papers = [p for p in papers if p.status == status]
        
        # Sort by created_at descending
        papers.sort(key=lambda p: p.created_at, reverse=True)
        
        return [p.to_dict() for p in papers[:limit]]
    
    async def conduct_research(
        self,
        topic: str,
        domain: Optional[ResearchDomain] = None,
        depth: str = "standard",
        callback: Optional[Callable[[str], None]] = None,
    ) -> Dict[str, Any]:
        """
        Conduct research on a topic.
        
        Args:
            topic: The research topic
            domain: Optional domain to focus on
            depth: Research depth (quick, standard, deep)
            callback: Optional progress callback
        
        Returns:
            Research results dictionary
        """
        depth_times = {"quick": 1, "standard": 3, "deep": 5}
        delay = depth_times.get(depth, 3)
        
        if callback:
            callback(f"Starting research on: {topic}")
        
        # Simulate research phases
        phases = ["gathering", "analyzing", "synthesizing", "concluding"]
        results_parts = []
        
        for i, phase in enumerate(phases):
            if callback:
                callback(f"Phase {i + 1}/{len(phases)}: {phase}...")
            
            await asyncio.sleep(delay / len(phases))
            results_parts.append(f"{phase.title()} complete for '{topic}'")
        
        # Calculate SCC (Sovereign Coherence Coefficient)
        scc = 4.5 + (PHI * 0.3)  # Base SCC with φ bonus
        
        return {
            "topic": topic,
            "domain": domain.value if domain else "general",
            "depth": depth,
            "scc": round(scc, 2),
            "frequency": self.frequency,
            "summary": f"Research completed on '{topic}' at depth '{depth}'.",
            "phases": results_parts,
            "full_report": f"# Research Report: {topic}\n\n" + "\n".join(results_parts),
        }
    
    def update_beat(self) -> Tuple[int, int]:
        """Update the lab's beat and ring."""
        now = int(time.time())
        self.beat = now % 1000
        self.ring = self.beat // 100
        return self.beat, self.ring
    
    def get_status(self) -> Dict[str, Any]:
        """Get lab status."""
        self.update_beat()
        
        return {
            "name": self.name,
            "frequency": self.frequency,
            "protocol": self.protocol,
            "active": self.active,
            "beat": self.beat,
            "ring": self.ring,
            "researcher_count": len(self.researchers),
            "paper_count": len(self.papers),
            "researchers_by_state": {
                state.value: sum(1 for r in self.researchers.values() if r.state == state)
                for state in ResearcherState
            },
        }


__all__ = [
    "ResearchLab",
    "Researcher",
    "Paper",
    "ResearchDomain",
    "ResearcherState",
]
