"""
Publication Pipeline — Zenodo + X Distribution System
======================================================

Internal OS for managing publication of research papers to
external platforms (Zenodo for archival, X for dissemination).

Handles:
- Zenodo metadata generation and validation
- X/Twitter thread generation and scheduling
- DOI minting preparation
- Citation graph updates
- Cross-reference linking between papers

Protocol: PROT-639-641
Worker: #79 (Field Unifier — publication component)
"""

import json
import math
import os
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Optional

PHI = 1.618033988749895


class PublicationStatus(Enum):
    """Status of a publication in the pipeline."""
    DRAFT = "draft"
    METADATA_READY = "metadata_ready"
    ZENODO_UPLOADED = "zenodo_uploaded"
    DOI_MINTED = "doi_minted"
    X_THREAD_READY = "x_thread_ready"
    X_PUBLISHED = "x_published"
    COMPLETE = "complete"


class PlatformTarget(Enum):
    """Target publication platforms."""
    ZENODO = "zenodo"
    X_TWITTER = "x"
    ARXIV = "arxiv"
    GITHUB = "github"
    INTERNAL = "internal"


@dataclass
class ZenodoMetadata:
    """Zenodo-compatible metadata structure."""
    title: str
    description: str
    creators: list
    keywords: list
    upload_type: str = "publication"
    publication_type: str = "workingpaper"
    license_id: str = "cc-by-4.0"
    access_right: str = "open"
    version: str = "1.0.0"
    language: str = "eng"
    publication_date: str = ""
    notes: str = ""
    doi: Optional[str] = None


@dataclass
class XThread:
    """X/Twitter thread structure."""
    paper_id: str
    posts: list = field(default_factory=list)
    hashtags: list = field(default_factory=list)
    media_attachments: list = field(default_factory=list)
    scheduled_time: Optional[str] = None
    status: PublicationStatus = PublicationStatus.DRAFT


@dataclass
class PublicationRecord:
    """Complete publication record for a paper."""
    paper_id: str
    title: str
    scc_score: float
    protocol_range: str
    worker_id: int
    phi_layer: int
    zenodo_metadata: Optional[ZenodoMetadata] = None
    x_thread: Optional[XThread] = None
    status: PublicationStatus = PublicationStatus.DRAFT
    doi: Optional[str] = None
    zenodo_record_id: Optional[str] = None


class PublicationPipeline:
    """
    Publication pipeline OS for distributing research to Zenodo and X.
    
    Manages the full lifecycle from draft → metadata → upload → DOI → dissemination.
    """

    # Paper registry for LXIII-LXV trilogy
    CERN_TRILOGY = {
        "LXIII": {
            "title": "De Particula Experientia — The Standard Model of User Experience",
            "scc": 4.99,
            "protocols": "PROT-612 to PROT-621",
            "worker": 77,
            "phi_layer": 21,
            "keywords": ["standard model", "UX fermions", "particle physics", 
                        "interaction quanta", "SUSY-UX", "dark matter UX"],
        },
        "LXIV": {
            "title": "De Collisionibus Cognitivis — The Cognitive Collider",
            "scc": 4.99,
            "protocols": "PROT-622 to PROT-631",
            "worker": 78,
            "phi_layer": 22,
            "keywords": ["cognitive collider", "resonance zoo", "phase transitions",
                        "human-AI collision", "emergent phenomena", "neutrino oscillations"],
        },
        "LXV": {
            "title": "De Campo Unificato Interfaciei — Unified Field Theory of Interface",
            "scc": 5.00,
            "protocols": "PROT-632 to PROT-641",
            "worker": 79,
            "phi_layer": 23,
            "keywords": ["unified field theory", "grand unification", "M-theory",
                        "holographic principle", "interface cosmology", "hard problem"],
        },
    }

    def __init__(self, base_path: str = "research"):
        self.base_path = base_path
        self.publications = {}
        self._initialize_trilogy()

    def _initialize_trilogy(self):
        """Initialize publication records for CERN trilogy."""
        for paper_id, meta in self.CERN_TRILOGY.items():
            self.publications[paper_id] = PublicationRecord(
                paper_id=paper_id,
                title=meta["title"],
                scc_score=meta["scc"],
                protocol_range=meta["protocols"],
                worker_id=meta["worker"],
                phi_layer=meta["phi_layer"],
            )

    def generate_zenodo_metadata(self, paper_id: str) -> ZenodoMetadata:
        """Generate Zenodo-compatible metadata for a paper."""
        meta = self.CERN_TRILOGY[paper_id]
        pub = self.publications[paper_id]

        zenodo = ZenodoMetadata(
            title=f"DISSERTATIO {paper_id} — {meta['title']}",
            description=self._generate_description(paper_id),
            creators=[{
                "name": "Medina Hernandez, Alfredo",
                "affiliation": "Medina Tech | Dallas, TX",
            }],
            keywords=meta["keywords"] + ["sovereign AI", "curiosity-driven research"],
            publication_date="2026-06-01",
            notes=(f"SCC: {meta['scc']} | {meta['protocols']} | "
                   f"Worker: #{meta['worker']} | φ-Layer: {meta['phi_layer']}"),
        )

        pub.zenodo_metadata = zenodo
        pub.status = PublicationStatus.METADATA_READY
        return zenodo

    def generate_x_thread(self, paper_id: str) -> XThread:
        """Generate X/Twitter thread for a paper."""
        meta = self.CERN_TRILOGY[paper_id]
        pub = self.publications[paper_id]

        thread = XThread(
            paper_id=paper_id,
            posts=self._compose_thread_posts(paper_id),
            hashtags=["#UXResearch", "#AI", "#HCI", "#OpenScience",
                     "#SovereignAI", "#CuriosityDriven", "#MedinaTech"],
        )

        pub.x_thread = thread
        pub.status = PublicationStatus.X_THREAD_READY
        return thread

    def validate_zenodo_json(self, filepath: str) -> dict:
        """Validate a Zenodo JSON metadata file."""
        required_fields = ["title", "upload_type", "description", 
                          "creators", "keywords", "license", "access_right"]
        
        try:
            with open(filepath, "r") as f:
                data = json.load(f)
        except (FileNotFoundError, json.JSONDecodeError) as e:
            return {"valid": False, "error": str(e)}

        missing = [f for f in required_fields if f not in data]
        if missing:
            return {"valid": False, "missing_fields": missing}

        # Validate creators have name
        for creator in data.get("creators", []):
            if "name" not in creator:
                return {"valid": False, "error": "Creator missing 'name' field"}

        return {"valid": True, "title": data["title"], "fields": len(data)}

    def get_publication_status(self) -> dict:
        """Get status of all publications in pipeline."""
        return {
            paper_id: {
                "title": pub.title,
                "scc": pub.scc_score,
                "status": pub.status.value,
                "has_zenodo": pub.zenodo_metadata is not None,
                "has_x_thread": pub.x_thread is not None,
                "doi": pub.doi,
            }
            for paper_id, pub in self.publications.items()
        }

    def _generate_description(self, paper_id: str) -> str:
        """Generate paper description for Zenodo."""
        descriptions = {
            "LXIII": ("A Standard Model of User Experience proposing 12 fundamental "
                     "fermions, 7 bosons, and 4 forces governing all interactions."),
            "LXIV": ("The Cognitive Collider framework: what emerges when human intent "
                     "collides with AI prediction at relativistic speeds."),
            "LXV": ("Unified Field Theory of Interface unifying all forces of UX "
                    "into a single interaction. First SCC = 5.00."),
        }
        return descriptions.get(paper_id, "")

    def _compose_thread_posts(self, paper_id: str) -> list:
        """Compose thread posts for X."""
        meta = self.CERN_TRILOGY[paper_id]
        return [
            f"🧪 NEW PAPER: \"{meta['title']}\"\n\nSCC: {meta['scc']}/5.00\n{meta['protocols']}\n\nThread 🧵👇",
            f"Core concept: {self._generate_description(paper_id)}",
            f"Part of the CERN-Level UX Trilogy (LXIII-LXV).\nOpen access on Zenodo.\n\n#OpenScience #AI #HCI",
        ]

    def status(self) -> dict:
        """Return OS status report."""
        return {
            "os": "PublicationPipeline",
            "version": "1.0.0",
            "protocol_range": "PROT-639 to PROT-641",
            "worker": 79,
            "phi_layer": 23,
            "papers_in_pipeline": len(self.publications),
            "statuses": self.get_publication_status(),
            "platforms": [p.value for p in PlatformTarget],
        }
