"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                        MEDINA-LAB CLI — RESEARCH LAB INTERFACE                               ║
║               "Intelligentia Ex Primitivo — Intelligence From The Primitive"                 ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-412 — LAB INTERFACE                                                         ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import hashlib
import time
import uuid
from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional
from urllib.parse import urlparse

from .constants import PHI, PHI_POWERS, RESEARCH_DOMAINS, FIBONACCI


@dataclass
class Researcher:
    """A researcher in the lab."""
    
    name: str
    domain: str
    frequency: float
    status: str = "idle"
    specialties: List[str] = field(default_factory=list)


@dataclass
class Paper:
    """A research paper."""
    
    id: str
    title: str
    domain: str
    scc: float = 0.0
    protocol: str = ""
    abstract: str = ""
    status: str = "draft"
    created_at: float = field(default_factory=time.time)


class ResearchLab:
    """
    Interface to the Research Lab.
    
    FREQUENCY SIGNATURE: φ¹³ = 521.002 Hz
    """
    
    def __init__(self) -> None:
        self.frequency = PHI_POWERS[13]
        self.protocol = "PROT-346"
        self._init_researchers()
        self._papers: Dict[str, Paper] = {}
        self._organisms: Dict[str, Dict[str, Any]] = {}
    
    def _init_researchers(self) -> None:
        """Initialize the 13 researchers."""
        self.researchers: List[Researcher] = []
        
        for i, domain in enumerate(RESEARCH_DOMAINS):
            freq = PHI_POWERS.get(i + 1, PHI ** (i + 1))
            researcher = Researcher(
                name=f"DR-{domain[:3]}-{FIBONACCI[i + 3]}",
                domain=domain,
                frequency=freq,
                specialties=[domain.lower(), "analysis", "synthesis"],
            )
            self.researchers.append(researcher)
    
    def create_paper(
        self,
        title: str,
        domain: str = "GENERAL",
        researcher: Optional[str] = None,
    ) -> str:
        """Create a new research paper."""
        paper_id = f"PAPER-{uuid.uuid4().hex[:8].upper()}"
        
        paper = Paper(
            id=paper_id,
            title=title,
            domain=domain.upper(),
            protocol=f"PROT-{400 + len(self._papers)}",
        )
        
        self._papers[paper_id] = paper
        return paper_id
    
    def list_papers(
        self,
        domain: Optional[str] = None,
        limit: int = 20,
    ) -> List[Dict[str, Any]]:
        """List papers, optionally filtered by domain."""
        papers = list(self._papers.values())
        
        if domain:
            papers = [p for p in papers if p.domain == domain.upper()]
        
        return [
            {
                "id": p.id,
                "title": p.title,
                "domain": p.domain,
                "scc": p.scc,
                "status": p.status,
            }
            for p in papers[:limit]
        ]
    
    def get_paper(self, paper_id: str) -> Optional[Dict[str, Any]]:
        """Get a specific paper by ID."""
        paper = self._papers.get(paper_id)
        if not paper:
            return None
        
        return {
            "id": paper.id,
            "title": paper.title,
            "domain": paper.domain,
            "scc": paper.scc,
            "protocol": paper.protocol,
            "abstract": paper.abstract,
            "status": paper.status,
        }
    
    def get_status(self) -> Dict[str, Any]:
        """Get lab status."""
        return {
            "frequency": self.frequency,
            "researcher_count": len(self.researchers),
            "paper_count": len(self._papers),
            "active_sessions": 0,
            "protocol": self.protocol,
        }
    
    def get_researchers(self) -> List[Dict[str, Any]]:
        """Get all researchers."""
        return [
            {
                "name": r.name,
                "domain": r.domain,
                "frequency": r.frequency,
                "status": r.status,
            }
            for r in self.researchers
        ]

    def create_organism_from_url(
        self,
        website_url: str,
        canonical_target: str = "RESEARCH_WEBSITES",
        domain_pack: str = "infrastructure",
    ) -> Dict[str, Any]:
        """Create one live organism entry from URL."""
        parsed = urlparse(website_url)
        if not parsed.scheme or not parsed.netloc:
            raise ValueError("website_url must be absolute, like https://example.com")
        organism_id = f"ORG-WEB-{len(self._organisms) + 1:04d}"
        organism = {
            "organism_id": organism_id,
            "website_name": parsed.netloc,
            "website_url": website_url,
            "canonical_target": canonical_target,
            "lane_id": f"lane://{canonical_target.lower().replace('_', '-')}",
            "domain_pack": domain_pack,
            "runtime_status": "running",
            "frequency_hz": PHI,
            "created_at": time.time(),
        }
        self._organisms[organism_id] = organism
        return organism

    def list_organisms(self) -> List[Dict[str, Any]]:
        """List live organism entries."""
        return list(self._organisms.values())
    
    async def conduct_research(
        self,
        topic: str,
        depth: str = "standard",
    ) -> Optional[Dict[str, Any]]:
        """Conduct research on a topic."""
        # Simulate research process
        import asyncio
        
        depth_times = {"quick": 1, "standard": 3, "deep": 5}
        await asyncio.sleep(depth_times.get(depth, 3))
        
        # Generate a research result
        summary = f"Research completed on: {topic}\n\n"
        summary += f"Depth: {depth}\n"
        summary += f"Researchers involved: {len(self.researchers)}\n"
        summary += f"Frequency coherence: {self.frequency:.3f} Hz\n"
        
        return {
            "topic": topic,
            "depth": depth,
            "summary": summary,
            "full_report": f"# Research Report: {topic}\n\n{summary}\n\n[Full analysis would be here]",
        }
