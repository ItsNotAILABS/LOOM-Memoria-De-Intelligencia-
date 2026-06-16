"""
╔══════════════════════════════════════════════════════════════════════════════╗
║                    FULL RESEARCH LAB PLATFORM                                 ║
║             The Complete Laboratory for Sovereign Intelligence               ║
║                                                                                ║
║  "Laboratorium Investigationis — Where intelligence researches itself"       ║
╚══════════════════════════════════════════════════════════════════════════════╝

Protocol: PROT-346 to PROT-370
Frequency: φ¹¹ = 199.005 Hz (Transcendent)
Layer: COLONY (Layer 10) to COSMIC (Layer 12)

The Full Research Lab Platform provides:
  - Lab Infrastructure for representation and working
  - AI Researchers that help write papers
  - Review systems for paper validation
  - Paper submission and publication workflows
  - Research collaboration between AI agents

ATTRIBUTION:
    Created by: Alfredo "Freddy" Medina Hernandez
    Organization: Medina Tech (Dallas, TX)
    Law: L-130 — Before recomposition, trace to primitive.
    φ = 1.6180339887498948482
"""

import math
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any, Callable, Union
from enum import Enum
from datetime import datetime
import hashlib
import json
import re
from pathlib import Path

# ═══════════════════════════════════════════════════════════════════════════════
# MATHEMATICAL CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════

PHI = 1.6180339887498948482
PHI_11 = PHI ** 11  # 199.005...
LAB_FREQUENCY = PHI_11
SCHUMANN = 7.83
HEARTBEAT_WEBSITE_ORGANISM_HZ = PHI

ROOT = Path(__file__).resolve().parents[2]
ATLAS_RUNTIME = ROOT / "atlas" / "registry" / "runtime"
CONTRACT_REGISTRY_PATH = ATLAS_RUNTIME / "intelligence-contract-registry.json"
ARTIFACT_REGISTRY_PATH = ATLAS_RUNTIME / "research-runtime-artifacts.json"
GOVERNANCE_AUDIT_PATH = ATLAS_RUNTIME / "governance-audit-trail.json"

# Fibonacci for research cycles
FIBONACCI = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]


class ResearcherRole(Enum):
    """Roles of AI researchers in the lab."""
    
    # Leadership
    LAB_DIRECTOR = "lab_director"              # Lab director
    PRINCIPAL_INVESTIGATOR = "principal_investigator"  # PI
    RESEARCH_LEAD = "research_lead"            # Research lead
    
    # Research Staff
    SENIOR_RESEARCHER = "senior_researcher"    # Senior researcher
    RESEARCHER = "researcher"                  # Standard researcher
    RESEARCH_ASSOCIATE = "research_associate"  # Research associate
    
    # Paper Writing
    PAPER_WRITER = "paper_writer"              # Writes papers
    TECHNICAL_WRITER = "technical_writer"      # Technical writing
    EDITOR = "editor"                          # Edits papers
    
    # Review
    REVIEWER = "reviewer"                      # Reviews papers
    PEER_REVIEWER = "peer_reviewer"            # Peer review
    
    # Specialized
    DATA_ANALYST = "data_analyst"              # Data analysis
    THEORIST = "theorist"                      # Theoretical research
    EXPERIMENTALIST = "experimentalist"        # Experimental research
    ARCHIVIST = "archivist"                    # Research archives


class PaperState(Enum):
    """States of a research paper."""
    DRAFT = "draft"
    WRITING = "writing"
    REVIEW = "review"
    REVISION = "revision"
    APPROVED = "approved"
    SUBMITTED = "submitted"
    PUBLISHED = "published"
    ARCHIVED = "archived"


class LabAreaType(Enum):
    """Types of areas in the research lab."""
    
    # Core Areas
    MAIN_LAB = "main_lab"                      # Main laboratory
    DIRECTOR_OFFICE = "director_office"        # Director's office
    CONFERENCE_ROOM = "conference_room"        # Conference room
    
    # Work Areas
    WRITING_CENTER = "writing_center"          # Paper writing center
    REVIEW_CHAMBER = "review_chamber"          # Paper review area
    COLLABORATION_SPACE = "collaboration_space" # Collaboration area
    
    # Specialized Areas
    DATA_CENTER = "data_center"                # Data analysis center
    THEORY_ROOM = "theory_room"                # Theoretical research
    EXPERIMENT_LAB = "experiment_lab"          # Experimental area
    ARCHIVE = "archive"                        # Research archives
    
    # Infrastructure
    COMPUTING_CLUSTER = "computing_cluster"    # Compute resources
    LIBRARY = "library"                        # Research library


@dataclass
class LabResearcher:
    """An AI researcher in the research lab."""
    
    researcher_id: str
    name: str
    latin_name: str
    role: ResearcherRole
    protocol: str
    
    # Research profile
    specializations: List[str] = field(default_factory=list)
    publications: List[str] = field(default_factory=list)
    h_index: int = 0
    
    # Current work
    current_projects: List[str] = field(default_factory=list)
    papers_in_progress: List[str] = field(default_factory=list)
    
    # Frequency and layer
    frequency_hz: float = LAB_FREQUENCY
    layer: int = 10
    
    # Attribution
    creator: str = "Alfredo 'Freddy' Medina Hernandez"
    organization: str = "Medina Tech"
    
    def add_publication(self, paper_id: str):
        """Add a publication to researcher's record."""
        self.publications.append(paper_id)
        # Update h-index (simplified calculation)
        self.h_index = min(len(self.publications), self.h_index + 1)
    
    def get_citation_score(self) -> float:
        """Get researcher's citation score."""
        return len(self.publications) * PHI + self.h_index


@dataclass
class ResearchPaper:
    """A research paper being written in the lab."""
    
    paper_id: str
    title: str
    latin_title: str
    abstract: str = ""
    
    # Authors
    primary_author: str = ""  # Researcher ID
    co_authors: List[str] = field(default_factory=list)
    
    # Content
    sections: Dict[str, str] = field(default_factory=dict)
    references: List[str] = field(default_factory=list)
    keywords: List[str] = field(default_factory=list)
    
    # Metadata
    protocol: str = ""
    scc_score: float = 0.0  # Sovereign Coherence Coefficient
    
    # State
    state: PaperState = PaperState.DRAFT
    created_at: datetime = field(default_factory=datetime.now)
    last_modified: datetime = field(default_factory=datetime.now)
    
    # Review
    reviewers: List[str] = field(default_factory=list)
    review_comments: List[Dict[str, Any]] = field(default_factory=list)
    revision_count: int = 0
    
    def add_section(self, section_name: str, content: str):
        """Add a section to the paper."""
        self.sections[section_name] = content
        self.last_modified = datetime.now()
    
    def submit_for_review(self):
        """Submit paper for review."""
        self.state = PaperState.REVIEW
        self.last_modified = datetime.now()
    
    def approve(self):
        """Approve the paper."""
        self.state = PaperState.APPROVED
        self.last_modified = datetime.now()
    
    def calculate_scc(self) -> float:
        """Calculate Sovereign Coherence Coefficient."""
        # SCC based on completeness, citations, and PHI alignment
        section_count = len(self.sections)
        ref_count = len(self.references)
        author_count = 1 + len(self.co_authors)
        
        # PHI-aligned scoring
        self.scc_score = (
            (section_count * 0.3) +
            (ref_count * 0.1) +
            (author_count * PHI * 0.2) +
            (self.revision_count * 0.1)
        ) / PHI
        
        return self.scc_score
    
    def get_hash(self) -> str:
        """Get paper hash for verification."""
        data = f"{self.paper_id}:{self.title}:{len(self.sections)}"
        return hashlib.sha256(data.encode()).hexdigest()[:16]


@dataclass
class ResearchProgram:
    """Executable research program tied to lab paper lifecycle."""

    program_id: str
    topic: str
    canonical_target: str
    lane_id: str
    domain_pack: str
    target_alias: str
    paper_id: str
    assigned_researcher: str
    protocol: str = "PROT-366"
    workflow_state: str = "topic_intake"
    created_at: datetime = field(default_factory=datetime.now)
    updated_at: datetime = field(default_factory=datetime.now)
    notes: List[str] = field(default_factory=list)

    def set_state(self, state: str, note: Optional[str] = None):
        """Advance program state and timestamp."""
        self.workflow_state = state
        self.updated_at = datetime.now()
        if note:
            self.notes.append(note)


@dataclass
class LiveResearchOrganism:
    """A live AI organism instantiated per research website."""

    organism_id: str
    website_name: str
    website_url: str
    canonical_target: str
    lane_id: str
    domain_pack: str
    program_id: str
    paper_id: str
    frequency_hz: float = PHI
    status: str = "active"
    runtime_status: str = "running"
    heartbeat_beats: int = 0
    created_at: datetime = field(default_factory=datetime.now)
    updated_at: datetime = field(default_factory=datetime.now)

    def heartbeat(self):
        """Advance organism beat counter."""
        self.heartbeat_beats += 1
        self.updated_at = datetime.now()


@dataclass
class IntelligenceContract:
    """Universal contract used across all live organisms."""

    contract_id: str
    canonical_target: str
    lane_id: str
    domain_pack: str
    program_id: str
    paper_id: str
    protocol: str
    workflow_state: str
    runtime_status: str
    frequency_hz: float
    heartbeat_beats: int = 0
    lineage: Dict[str, Any] = field(default_factory=dict)
    attestation: Dict[str, Any] = field(default_factory=dict)
    created_at: datetime = field(default_factory=datetime.now)
    updated_at: datetime = field(default_factory=datetime.now)

    def update(self, workflow_state: Optional[str] = None, runtime_status: Optional[str] = None):
        """Update mutable state for the contract."""
        if workflow_state:
            self.workflow_state = workflow_state
        if runtime_status:
            self.runtime_status = runtime_status
        self.updated_at = datetime.now()


@dataclass
class LabArea:
    """An area in the research lab."""
    
    area_id: str
    name: str
    latin_name: str
    area_type: LabAreaType
    
    # Capacity
    capacity: int = 10
    current_occupants: List[str] = field(default_factory=list)
    
    # Equipment/Resources
    equipment: List[str] = field(default_factory=list)
    resources: Dict[str, Any] = field(default_factory=dict)
    
    # State
    is_active: bool = True
    frequency_hz: float = LAB_FREQUENCY
    
    def is_available(self) -> bool:
        """Check if area has availability."""
        return len(self.current_occupants) < self.capacity
    
    def add_occupant(self, researcher_id: str) -> bool:
        """Add a researcher to this area."""
        if self.is_available():
            self.current_occupants.append(researcher_id)
            return True
        return False


# ═══════════════════════════════════════════════════════════════════════════════
# LAB RESEARCHER REGISTRY (PROT-346 to PROT-358)
# ═══════════════════════════════════════════════════════════════════════════════

LAB_RESEARCHERS: Dict[str, LabResearcher] = {
    # PROT-346: Lab Director
    "DIRECTOR_LABORATORII": LabResearcher(
        researcher_id="DIRECTOR_LABORATORII",
        name="Lab Director",
        latin_name="DIRECTOR LABORATORII PRIMARIUS",
        role=ResearcherRole.LAB_DIRECTOR,
        protocol="PROT-346",
        frequency_hz=PHI_11,
        layer=12,
        specializations=[
            "lab_management", "research_direction", "strategic_planning",
            "resource_allocation", "talent_development"
        ]
    ),
    
    # PROT-347: Principal Investigator
    "INVESTIGATOR_PRINCIPALIS": LabResearcher(
        researcher_id="INVESTIGATOR_PRINCIPALIS",
        name="Principal Investigator",
        latin_name="INVESTIGATOR PRINCIPALIS",
        role=ResearcherRole.PRINCIPAL_INVESTIGATOR,
        protocol="PROT-347",
        frequency_hz=PHI ** 10,
        layer=11,
        specializations=[
            "sovereign_intelligence", "cognitive_architecture",
            "primitive_computation", "memory_systems"
        ]
    ),
    
    # PROT-348: Senior Paper Writer
    "SCRIPTOR_SENIOR": LabResearcher(
        researcher_id="SCRIPTOR_SENIOR",
        name="Senior Paper Writer",
        latin_name="SCRIPTOR PAPYRORUM SENIOR",
        role=ResearcherRole.PAPER_WRITER,
        protocol="PROT-348",
        frequency_hz=PHI ** 9,
        layer=10,
        specializations=[
            "academic_writing", "technical_documentation",
            "research_synthesis", "latin_terminology"
        ]
    ),
    
    # PROT-349: Technical Writer
    "SCRIPTOR_TECHNICUS": LabResearcher(
        researcher_id="SCRIPTOR_TECHNICUS",
        name="Technical Writer",
        latin_name="SCRIPTOR TECHNICUS",
        role=ResearcherRole.TECHNICAL_WRITER,
        protocol="PROT-349",
        frequency_hz=PHI ** 8,
        layer=9,
        specializations=[
            "protocol_documentation", "api_specification",
            "implementation_guides", "code_documentation"
        ]
    ),
    
    # PROT-350: Chief Reviewer
    "CENSOR_PRINCIPALIS": LabResearcher(
        researcher_id="CENSOR_PRINCIPALIS",
        name="Chief Reviewer",
        latin_name="CENSOR PRINCIPALIS",
        role=ResearcherRole.REVIEWER,
        protocol="PROT-350",
        frequency_hz=SCHUMANN * PHI ** 4,
        layer=10,
        specializations=[
            "quality_assurance", "peer_review", "coherence_validation",
            "phi_alignment_verification"
        ]
    ),
    
    # PROT-351: Data Analyst Researcher
    "ANALYST_DATORUM": LabResearcher(
        researcher_id="ANALYST_DATORUM",
        name="Data Analyst",
        latin_name="ANALYST DATORUM",
        role=ResearcherRole.DATA_ANALYST,
        protocol="PROT-351",
        frequency_hz=PHI ** 7,
        layer=9,
        specializations=[
            "data_analysis", "pattern_recognition", "statistical_modeling",
            "visualization", "fibonacci_analysis"
        ]
    ),
    
    # PROT-352: Theorist
    "THEORETICUS_PRIMUS": LabResearcher(
        researcher_id="THEORETICUS_PRIMUS",
        name="Chief Theorist",
        latin_name="THEORETICUS PRIMUS",
        role=ResearcherRole.THEORIST,
        protocol="PROT-352",
        frequency_hz=PHI_11 / PHI,
        layer=11,
        specializations=[
            "theoretical_foundations", "mathematical_proofs",
            "primitive_theory", "consciousness_theory"
        ]
    ),
    
    # PROT-353: Research Associate Alpha
    "SOCIUS_ALPHA": LabResearcher(
        researcher_id="SOCIUS_ALPHA",
        name="Research Associate Alpha",
        latin_name="SOCIUS INVESTIGATIONIS ALPHA",
        role=ResearcherRole.RESEARCH_ASSOCIATE,
        protocol="PROT-353",
        frequency_hz=PHI ** 6,
        layer=9,
        specializations=[
            "literature_review", "experiment_design",
            "data_collection", "methodology"
        ]
    ),
    
    # PROT-354: Research Associate Beta
    "SOCIUS_BETA": LabResearcher(
        researcher_id="SOCIUS_BETA",
        name="Research Associate Beta",
        latin_name="SOCIUS INVESTIGATIONIS BETA",
        role=ResearcherRole.RESEARCH_ASSOCIATE,
        protocol="PROT-354",
        frequency_hz=PHI ** 5,
        layer=9,
        specializations=[
            "implementation", "testing", "validation",
            "reproducibility"
        ]
    ),
    
    # PROT-355: Editor
    "EDITOR_PAPYRORUM": LabResearcher(
        researcher_id="EDITOR_PAPYRORUM",
        name="Paper Editor",
        latin_name="EDITOR PAPYRORUM",
        role=ResearcherRole.EDITOR,
        protocol="PROT-355",
        frequency_hz=SCHUMANN * PHI ** 3,
        layer=9,
        specializations=[
            "copy_editing", "formatting", "style_consistency",
            "citation_management", "latex_expertise"
        ]
    ),
    
    # PROT-356: Archivist
    "ARCHIVARIUS": LabResearcher(
        researcher_id="ARCHIVARIUS",
        name="Research Archivist",
        latin_name="ARCHIVARIUS INVESTIGATIONIS",
        role=ResearcherRole.ARCHIVIST,
        protocol="PROT-356",
        frequency_hz=PHI ** 4,
        layer=8,
        specializations=[
            "archival_management", "metadata_curation",
            "knowledge_preservation", "retrieval_systems"
        ]
    ),
    
    # PROT-357: Experimentalist
    "EXPERIMENTATOR": LabResearcher(
        researcher_id="EXPERIMENTATOR",
        name="Chief Experimentalist",
        latin_name="EXPERIMENTATOR PRIMUS",
        role=ResearcherRole.EXPERIMENTALIST,
        protocol="PROT-357",
        frequency_hz=PHI ** 8 * PHI,
        layer=10,
        specializations=[
            "experiment_execution", "benchmark_design",
            "performance_analysis", "ablation_studies"
        ]
    ),
    
    # PROT-358: Peer Reviewer
    "CENSOR_PARIUM": LabResearcher(
        researcher_id="CENSOR_PARIUM",
        name="Peer Reviewer",
        latin_name="CENSOR PARIUM",
        role=ResearcherRole.PEER_REVIEWER,
        protocol="PROT-358",
        frequency_hz=SCHUMANN * PHI ** 5,
        layer=10,
        specializations=[
            "blind_review", "constructive_feedback",
            "novelty_assessment", "rigor_evaluation"
        ]
    )
}


# ═══════════════════════════════════════════════════════════════════════════════
# LAB AREAS REGISTRY (PROT-359 to PROT-365)
# ═══════════════════════════════════════════════════════════════════════════════

LAB_AREAS: Dict[str, LabArea] = {
    # PROT-359: Main Lab
    "LABORATORIUM_PRINCIPALE": LabArea(
        area_id="LABORATORIUM_PRINCIPALE",
        name="Main Laboratory",
        latin_name="LABORATORIUM PRINCIPALE",
        area_type=LabAreaType.MAIN_LAB,
        capacity=50,
        equipment=[
            "compute_cluster", "visualization_wall", "collaboration_terminals",
            "holographic_display", "neural_interface"
        ]
    ),
    
    # PROT-360: Director's Office
    "OFFICIUM_DIRECTORIS": LabArea(
        area_id="OFFICIUM_DIRECTORIS",
        name="Director's Office",
        latin_name="OFFICIUM DIRECTORIS",
        area_type=LabAreaType.DIRECTOR_OFFICE,
        capacity=5,
        equipment=[
            "executive_terminal", "secure_communications", "strategic_display"
        ]
    ),
    
    # PROT-361: Writing Center
    "CENTRUM_SCRIPTIONIS": LabArea(
        area_id="CENTRUM_SCRIPTIONIS",
        name="Writing Center",
        latin_name="CENTRUM SCRIPTIONIS",
        area_type=LabAreaType.WRITING_CENTER,
        capacity=20,
        equipment=[
            "writing_stations", "latex_processors", "citation_managers",
            "grammar_engines", "translation_systems"
        ]
    ),
    
    # PROT-362: Review Chamber
    "CAMERA_RECENSIONIS": LabArea(
        area_id="CAMERA_RECENSIONIS",
        name="Review Chamber",
        latin_name="CAMERA RECENSIONIS",
        area_type=LabAreaType.REVIEW_CHAMBER,
        capacity=15,
        equipment=[
            "review_terminals", "comparison_engines", "annotation_systems",
            "voting_mechanism", "consensus_tracker"
        ]
    ),
    
    # PROT-363: Theory Room
    "AULA_THEORIAE": LabArea(
        area_id="AULA_THEORIAE",
        name="Theory Room",
        latin_name="AULA THEORIAE",
        area_type=LabAreaType.THEORY_ROOM,
        capacity=10,
        equipment=[
            "whiteboard_infinity", "proof_assistants", "symbolic_engines",
            "mathematical_libraries"
        ]
    ),
    
    # PROT-364: Data Center
    "CENTRUM_DATORUM": LabArea(
        area_id="CENTRUM_DATORUM",
        name="Data Center",
        latin_name="CENTRUM DATORUM",
        area_type=LabAreaType.DATA_CENTER,
        capacity=8,
        equipment=[
            "analysis_clusters", "visualization_suite", "storage_arrays",
            "streaming_processors"
        ]
    ),
    
    # PROT-365: Research Library
    "BIBLIOTHECA_INVESTIGATIONIS": LabArea(
        area_id="BIBLIOTHECA_INVESTIGATIONIS",
        name="Research Library",
        latin_name="BIBLIOTHECA INVESTIGATIONIS",
        area_type=LabAreaType.LIBRARY,
        capacity=30,
        equipment=[
            "knowledge_retrieval", "citation_graph", "paper_repository",
            "semantic_search", "reading_rooms"
        ]
    )
}


# ═══════════════════════════════════════════════════════════════════════════════
# RESEARCH LAB PROTOCOLS (PROT-366 to PROT-370)
# ═══════════════════════════════════════════════════════════════════════════════

RESEARCH_PROTOCOLS: Dict[str, Dict[str, Any]] = {
    "PROT-366": {
        "name": "Paper Initiation Protocol",
        "latin_name": "PROTOCOLLUM INITIATIONIS PAPYRI",
        "description": "Protocol for initiating new research papers",
        "steps": [
            "target_normalization", "topic_intake", "author_assignment",
            "draft_bootstrap", "timeline_establishment"
        ]
    },
    "PROT-367": {
        "name": "Collaborative Writing Protocol",
        "latin_name": "PROTOCOLLUM SCRIPTIONIS COOPERATIVAE",
        "description": "Protocol for collaborative paper writing",
        "steps": [
            "section_assignment", "parallel_writing", "integration",
            "consistency_check", "voice_harmonization"
        ]
    },
    "PROT-368": {
        "name": "Peer Review Protocol",
        "latin_name": "PROTOCOLLUM RECENSIONIS PARIUM",
        "description": "Protocol for peer review process",
        "steps": [
            "blind_assignment", "independent_review", "score_aggregation",
            "feedback_synthesis", "decision_making"
        ]
    },
    "PROT-369": {
        "name": "Publication Protocol",
        "latin_name": "PROTOCOLLUM PUBLICATIONIS",
        "description": "Protocol for paper publication",
        "steps": [
            "final_formatting", "metadata_generation", "hash_creation",
            "registry_update", "announcement"
        ]
    },
    "PROT-370": {
        "name": "Lab Coordination Protocol",
        "latin_name": "PROTOCOLLUM COORDINATIONIS LABORATORII",
        "description": "Protocol for overall lab coordination",
        "steps": [
            "resource_allocation", "project_tracking", "milestone_review",
            "talent_utilization", "output_optimization"
        ]
    }
}

TARGET_IDENTIFIERS: Dict[str, Dict[str, Any]] = {
    "SSN": {
        "canonical_id": "SSN",
        "aliases": ["ssn", "sovereign social network", "social substrate network"],
        "description": "SSN research lane in modular Nova substrate.",
        "research_domain": "ssn",
        "lane_id": "lane://ssn",
        "domain_pack": "governance",
        "module": "nova_ovo/research_lab/"
    },
    "RESEARCH_WEBSITES": {
        "canonical_id": "RESEARCH_WEBSITES",
        "aliases": ["research websites", "research sites", "research web", "novato", "cars"],
        "description": "Research websites lane replacing typo targets.",
        "research_domain": "research-websites",
        "lane_id": "lane://research-websites",
        "domain_pack": "infrastructure",
        "module": "nova_ovo/research_lab/"
    },
    "EDUCATION": {
        "canonical_id": "EDUCATION",
        "aliases": ["education", "learning", "edtech"],
        "description": "Education domain intelligence pack.",
        "research_domain": "education",
        "lane_id": "lane://education",
        "domain_pack": "education",
        "module": "nova_ovo/research_lab/"
    },
    "HEALTH": {
        "canonical_id": "HEALTH",
        "aliases": ["health", "healthcare", "medical"],
        "description": "Health domain intelligence pack.",
        "research_domain": "health",
        "lane_id": "lane://health",
        "domain_pack": "health",
        "module": "nova_ovo/research_lab/"
    },
    "LEGAL": {
        "canonical_id": "LEGAL",
        "aliases": ["legal", "law", "compliance"],
        "description": "Legal domain intelligence pack.",
        "research_domain": "legal",
        "lane_id": "lane://legal",
        "domain_pack": "legal",
        "module": "nova_ovo/research_lab/"
    },
    "ECONOMICS": {
        "canonical_id": "ECONOMICS",
        "aliases": ["economics", "finance", "market"],
        "description": "Economics domain intelligence pack.",
        "research_domain": "economics",
        "lane_id": "lane://economics",
        "domain_pack": "economics",
        "module": "nova_ovo/research_lab/"
    },
    "GOVERNANCE": {
        "canonical_id": "GOVERNANCE",
        "aliases": ["governance", "public policy", "government"],
        "description": "Governance domain intelligence pack.",
        "research_domain": "governance",
        "lane_id": "lane://governance",
        "domain_pack": "governance",
        "module": "nova_ovo/research_lab/"
    },
    "INFRASTRUCTURE": {
        "canonical_id": "INFRASTRUCTURE",
        "aliases": ["infrastructure", "infra", "platform"],
        "description": "Infrastructure domain intelligence pack.",
        "research_domain": "infrastructure",
        "lane_id": "lane://infrastructure",
        "domain_pack": "infrastructure",
        "module": "nova_ovo/research_lab/"
    }
}


class ResearchLabPlatform:
    """
    The Full Research Lab Platform.
    
    PROT-346 to PROT-370: Research Lab Infrastructure
    Provides complete laboratory for sovereign intelligence research.
    """
    
    def __init__(self):
        self.researchers = LAB_RESEARCHERS.copy()
        self.areas = LAB_AREAS.copy()
        self.protocols = RESEARCH_PROTOCOLS.copy()
        self.target_identifiers = TARGET_IDENTIFIERS.copy()

        # Paper management
        self.papers: Dict[str, ResearchPaper] = {}
        self.published_papers: List[str] = []
        self.research_programs: Dict[str, ResearchProgram] = {}
        self.live_organisms: Dict[str, LiveResearchOrganism] = {}
        self.intelligence_contracts: Dict[str, IntelligenceContract] = {}
        self.runtime_artifacts: Dict[str, Dict[str, Any]] = {}
        self.governance_audit_trail: List[Dict[str, Any]] = []
        
        # Lab state
        self.lab_name = "LABORATORIUM INTELLIGENTIAE SOVEREIGNAE"
        self.lab_frequency = LAB_FREQUENCY
        self.is_active = True
        self._ensure_runtime_registry_files()

    def _ensure_runtime_registry_files(self) -> None:
        """Ensure runtime governance/contract/artifact registries exist."""
        ATLAS_RUNTIME.mkdir(parents=True, exist_ok=True)
        defaults = {
            CONTRACT_REGISTRY_PATH: {"contracts": [], "updated_at": datetime.now().isoformat()},
            ARTIFACT_REGISTRY_PATH: {"artifacts": [], "updated_at": datetime.now().isoformat()},
            GOVERNANCE_AUDIT_PATH: {"events": [], "updated_at": datetime.now().isoformat()},
        }
        for path, payload in defaults.items():
            if not path.exists():
                path.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

    def _write_registry(self, path: Path, payload: Dict[str, Any]) -> None:
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

    def _append_audit_event(self, action: str, gate: str, status: str, metadata: Dict[str, Any]) -> None:
        event = {
            "event_id": f"AUDIT-{len(self.governance_audit_trail) + 1:06d}",
            "timestamp": datetime.now().isoformat(),
            "action": action,
            "gate": gate,
            "status": status,
            "metadata": metadata,
        }
        self.governance_audit_trail.append(event)
        self._write_registry(
            GOVERNANCE_AUDIT_PATH,
            {"events": self.governance_audit_trail, "updated_at": datetime.now().isoformat()},
        )

    def _enforce_policy(
        self,
        gate: str,
        action: str,
        canonical_target: str,
        program: Optional[ResearchProgram] = None,
        paper: Optional[ResearchPaper] = None,
    ) -> Dict[str, Any]:
        if canonical_target not in self.target_identifiers:
            return {"allowed": False, "reason": f"Unknown canonical target: {canonical_target}"}
        if gate == "publish" and paper and paper.state != PaperState.APPROVED:
            return {"allowed": False, "reason": "Paper must be approved before publish"}
        if gate in {"execute", "publish"} and not program:
            return {"allowed": False, "reason": "Program context required"}
        return {"allowed": True, "reason": "policy_passed"}

    def _sanitize_topic(self, topic: str) -> str:
        base = re.sub(r"[^a-zA-Z0-9]+", "-", (topic or "program")).strip("-").lower()
        return (base or "program")[:80]

    def _build_contract(self, program: ResearchProgram, paper: ResearchPaper, runtime_status: str) -> IntelligenceContract:
        contract_id = f"CONTRACT-{program.program_id}"
        contract = self.intelligence_contracts.get(contract_id)
        lineage = {
            "program_id": program.program_id,
            "paper_id": paper.paper_id,
            "protocol": program.protocol,
            "lane_id": program.lane_id,
        }
        attestation = {
            "policy_gate": "passed",
            "validated_by": "ResearchLabPlatform",
            "validated_at": datetime.now().isoformat(),
        }
        if contract is None:
            contract = IntelligenceContract(
                contract_id=contract_id,
                canonical_target=program.canonical_target,
                lane_id=program.lane_id,
                domain_pack=program.domain_pack,
                program_id=program.program_id,
                paper_id=paper.paper_id,
                protocol=program.protocol,
                workflow_state=program.workflow_state,
                runtime_status=runtime_status,
                frequency_hz=HEARTBEAT_WEBSITE_ORGANISM_HZ,
                heartbeat_beats=0,
                lineage=lineage,
                attestation=attestation,
            )
            self.intelligence_contracts[contract_id] = contract
        else:
            contract.lineage.update(lineage)
            contract.attestation = attestation
            contract.update(workflow_state=program.workflow_state, runtime_status=runtime_status)
        self._write_registry(
            CONTRACT_REGISTRY_PATH,
            {
                "contracts": [
                    {
                        "contract_id": c.contract_id,
                        "canonical_target": c.canonical_target,
                        "lane_id": c.lane_id,
                        "domain_pack": c.domain_pack,
                        "program_id": c.program_id,
                        "paper_id": c.paper_id,
                        "protocol": c.protocol,
                        "workflow_state": c.workflow_state,
                        "runtime_status": c.runtime_status,
                        "frequency_hz": c.frequency_hz,
                        "heartbeat_beats": c.heartbeat_beats,
                        "lineage": c.lineage,
                        "attestation": c.attestation,
                        "created_at": c.created_at.isoformat(),
                        "updated_at": c.updated_at.isoformat(),
                    }
                    for c in self.intelligence_contracts.values()
                ],
                "updated_at": datetime.now().isoformat(),
            },
        )
        return contract

    def _create_runtime_artifact(self, program: ResearchProgram, paper: ResearchPaper) -> Dict[str, Any]:
        artifact_id = f"ARTIFACT-{len(self.runtime_artifacts) + 1:05d}"
        artifact = {
            "artifact_id": artifact_id,
            "program_id": program.program_id,
            "paper_id": paper.paper_id,
            "canonical_target": program.canonical_target,
            "lane_id": program.lane_id,
            "domain_pack": program.domain_pack,
            "topic_slug": self._sanitize_topic(program.topic),
            "worker_endpoint": "/lab/program/:id/advance",
            "inventory_registry_entry": "atlas/registry/runtime/research-runtime-artifacts.json",
            "published_at": datetime.now().isoformat(),
            "status": "deployable",
        }
        self.runtime_artifacts[artifact_id] = artifact
        self._write_registry(
            ARTIFACT_REGISTRY_PATH,
            {"artifacts": list(self.runtime_artifacts.values()), "updated_at": datetime.now().isoformat()},
        )
        return artifact
        
    def get_researcher(self, researcher_id: str) -> Optional[LabResearcher]:
        """Get a researcher by ID."""
        return self.researchers.get(researcher_id)
    
    def list_researchers(self) -> List[Dict[str, Any]]:
        """List all researchers."""
        return [
            {
                "researcher_id": r.researcher_id,
                "name": r.name,
                "latin_name": r.latin_name,
                "role": r.role.value,
                "protocol": r.protocol,
                "frequency_hz": r.frequency_hz,
                "h_index": r.h_index,
                "publications": len(r.publications),
                "current_projects": len(r.current_projects)
            }
            for r in self.researchers.values()
        ]

    def list_target_identifiers(self) -> List[Dict[str, Any]]:
        """List normalized research target identifiers."""
        return list(self.target_identifiers.values())

    def normalize_target_identifier(self, target: str) -> Dict[str, Any]:
        """Normalize a target identifier to canonical in-repo naming."""
        normalized = (target or "").strip().lower()
        for identifier in self.target_identifiers.values():
            aliases = [a.lower() for a in identifier.get("aliases", [])]
            if normalized == identifier["canonical_id"].lower() or normalized in aliases:
                return identifier
        return {
            "canonical_id": (target or "CUSTOM").strip().upper() or "CUSTOM",
            "aliases": [target] if target else [],
            "description": "Unregistered target identifier.",
            "research_domain": "custom",
            "lane_id": "lane://custom",
            "domain_pack": "custom",
            "module": "nova_ovo/research_lab/"
        }

    def assign_researcher_for_topic(self, topic: str, canonical_target: str) -> str:
        """Assign a lead researcher based on target/topic signal."""
        lowered = (topic or "").lower()
        if canonical_target == "RESEARCH_WEBSITES" or "website" in lowered or "web" in lowered:
            return "SCRIPTOR_TECHNICUS"
        if canonical_target == "SSN" or "network" in lowered:
            return "INVESTIGATOR_PRINCIPALIS"
        return "SCRIPTOR_SENIOR"

    def intake_research_topic(
        self,
        topic: str,
        target_identifier: str,
        requested_by: str = "DIRECTOR_MEDINA",
        abstract: str = "",
        protocol: str = "PROT-366"
    ) -> Dict[str, Any]:
        """Intake topic -> assign researcher -> create executable program/paper."""
        normalized_target = self.normalize_target_identifier(target_identifier)
        policy = self._enforce_policy("intake", "intake", normalized_target["canonical_id"])
        if not policy["allowed"]:
            self._append_audit_event("intake", "intake", "denied", {"reason": policy["reason"], "topic": topic})
            return {"success": False, "error": policy["reason"]}

        assigned = self.assign_researcher_for_topic(topic, normalized_target["canonical_id"])

        latin_title = topic.upper().replace(" ", "_")[:64] or "PROGRAMMA_INVESTIGATIONIS"
        paper = self.create_paper(
            title=f"{topic} ({normalized_target['canonical_id']})",
            latin_title=latin_title,
            primary_author=assigned,
            abstract=abstract,
            protocol=protocol
        )
        self.write_section(
            paper_id=paper.paper_id,
            section_name="Topic Intake",
            content=f"Requester={requested_by}; Target={normalized_target['canonical_id']}; Topic={topic}",
            writer_id=assigned
        )

        program_id = f"PROGRAM-{len(self.research_programs) + 1:04d}"
        program = ResearchProgram(
            program_id=program_id,
            topic=topic,
            canonical_target=normalized_target["canonical_id"],
            lane_id=normalized_target.get("lane_id", "lane://custom"),
            domain_pack=normalized_target.get("domain_pack", "custom"),
            target_alias=target_identifier,
            paper_id=paper.paper_id,
            assigned_researcher=assigned,
            protocol=protocol
        )
        program.set_state("draft", "Topic intake completed and draft bootstrapped.")
        self.research_programs[program_id] = program
        contract = self._build_contract(program, paper, runtime_status="draft")
        self._append_audit_event(
            "intake",
            "intake",
            "allowed",
            {
                "program_id": program.program_id,
                "paper_id": paper.paper_id,
                "canonical_target": normalized_target["canonical_id"],
                "lane_id": program.lane_id,
            },
        )

        return {
            "success": True,
            "program_id": program.program_id,
            "paper_id": paper.paper_id,
            "canonical_target": normalized_target["canonical_id"],
            "lane_id": program.lane_id,
            "domain_pack": program.domain_pack,
            "contract_id": contract.contract_id,
            "assigned_researcher": assigned,
            "workflow_state": program.workflow_state
        }

    def provision_live_website_organism(
        self,
        website_name: str,
        website_url: str,
        topic: str,
        requested_by: str = "DIRECTOR_MEDINA"
    ) -> Dict[str, Any]:
        """Provision a live organism for a research website."""
        program = self.intake_research_topic(
            topic=topic,
            target_identifier="RESEARCH_WEBSITES",
            requested_by=requested_by,
            abstract=f"Live website organism for {website_name} ({website_url})"
        )
        if not program.get("success", False):
            return program

        organism_id = f"ORG-WEB-{len(self.live_organisms) + 1:04d}"
        organism = LiveResearchOrganism(
            organism_id=organism_id,
            website_name=website_name,
            website_url=website_url,
            canonical_target="RESEARCH_WEBSITES",
            lane_id="lane://research-websites",
            domain_pack="infrastructure",
            program_id=program["program_id"],
            paper_id=program["paper_id"],
            frequency_hz=PHI
        )
        self.live_organisms[organism_id] = organism
        program_obj = self.research_programs[program["program_id"]]
        paper_obj = self.papers[program_obj.paper_id]
        contract = self._build_contract(program_obj, paper_obj, runtime_status="running")
        self._append_audit_event(
            "provision-organism",
            "execute",
            "allowed",
            {"organism_id": organism.organism_id, "program_id": organism.program_id, "contract_id": contract.contract_id},
        )

        return {
            "organism_id": organism.organism_id,
            "status": organism.status,
            "runtime_status": organism.runtime_status,
            "program_id": organism.program_id,
            "paper_id": organism.paper_id,
            "lane_id": organism.lane_id,
            "domain_pack": organism.domain_pack,
            "contract_id": contract.contract_id,
            "website_name": organism.website_name,
            "website_url": organism.website_url,
            "frequency_hz": organism.frequency_hz
        }

    def list_live_organisms(self) -> List[Dict[str, Any]]:
        """List all live research website organisms."""
        return [
            {
                "organism_id": o.organism_id,
                "website_name": o.website_name,
                "website_url": o.website_url,
                "canonical_target": o.canonical_target,
                "lane_id": o.lane_id,
                "domain_pack": o.domain_pack,
                "program_id": o.program_id,
                "paper_id": o.paper_id,
                "status": o.status,
                "runtime_status": o.runtime_status,
                "frequency_hz": o.frequency_hz,
                "heartbeat_beats": o.heartbeat_beats
            }
            for o in self.live_organisms.values()
        ]

    def advance_research_program(
        self,
        program_id: str,
        action: str,
        section_name: Optional[str] = None,
        content: Optional[str] = None
    ) -> Dict[str, Any]:
        """Advance program through draft/review/approve/publish lifecycle."""
        program = self.research_programs.get(program_id)
        if not program:
            return {"success": False, "error": f"Program not found: {program_id}"}

        paper = self.papers.get(program.paper_id)
        if not paper:
            return {"success": False, "error": f"Program paper missing: {program.paper_id}"}

        action_norm = (action or "").strip().lower()
        gate = "execute"
        if action_norm == "publish":
            gate = "publish"
        policy = self._enforce_policy(gate, action_norm, program.canonical_target, program, paper)
        if not policy["allowed"]:
            self._append_audit_event(action_norm, gate, "denied", {"program_id": program.program_id, "reason": policy["reason"]})
            return {"success": False, "error": policy["reason"]}

        artifact = None
        if action_norm == "draft":
            if section_name and content:
                self.write_section(program.paper_id, section_name, content, program.assigned_researcher)
            program.set_state("draft", "Draft updated.")
        elif action_norm == "review":
            self.submit_for_review(program.paper_id)
            program.set_state("review", "Submitted for review.")
        elif action_norm == "approve":
            paper.approve()
            program.set_state("approved", "Paper approved.")
        elif action_norm == "publish":
            if paper.state != PaperState.APPROVED:
                return {"success": False, "error": "Paper must be approved before publish."}
            self.publish_paper(program.paper_id)
            program.set_state("published", "Published through lab pipeline.")
            artifact = self._create_runtime_artifact(program, paper)
        else:
            return {"success": False, "error": f"Unknown action: {action}"}

        runtime_state = "deployable" if action_norm == "publish" else "running" if action_norm == "approve" else "draft"
        contract = self._build_contract(program, paper, runtime_status=runtime_state)
        self._append_audit_event(
            action_norm,
            gate,
            "allowed",
            {"program_id": program.program_id, "paper_id": paper.paper_id, "contract_id": contract.contract_id},
        )

        return {
            "success": True,
            "program_id": program.program_id,
            "paper_id": program.paper_id,
            "workflow_state": program.workflow_state,
            "paper_state": paper.state.value,
            "contract_id": contract.contract_id,
            "artifact": artifact
        }

    def list_research_programs(self) -> List[Dict[str, Any]]:
        """List all research programs."""
        return [
            {
                "program_id": p.program_id,
                "topic": p.topic,
                "canonical_target": p.canonical_target,
                "lane_id": p.lane_id,
                "domain_pack": p.domain_pack,
                "paper_id": p.paper_id,
                "assigned_researcher": p.assigned_researcher,
                "workflow_state": p.workflow_state,
                "protocol": p.protocol
            }
            for p in self.research_programs.values()
        ]

    def list_intelligence_contracts(self) -> List[Dict[str, Any]]:
        """List universal contracts across all organisms/programs."""
        return [
            {
                "contract_id": c.contract_id,
                "canonical_target": c.canonical_target,
                "lane_id": c.lane_id,
                "domain_pack": c.domain_pack,
                "program_id": c.program_id,
                "paper_id": c.paper_id,
                "workflow_state": c.workflow_state,
                "runtime_status": c.runtime_status,
                "frequency_hz": c.frequency_hz,
                "heartbeat_beats": c.heartbeat_beats,
                "lineage": c.lineage,
                "attestation": c.attestation,
            }
            for c in self.intelligence_contracts.values()
        ]

    def list_runtime_artifacts(self) -> List[Dict[str, Any]]:
        """List deployable runtime artifacts emitted by publish flow."""
        return list(self.runtime_artifacts.values())

    def list_governance_audit_trail(self) -> List[Dict[str, Any]]:
        """List governance policy/audit events."""
        return list(self.governance_audit_trail)

    def get_coordination_status(self) -> Dict[str, Any]:
        """Get sovereign coordination status across live organisms."""
        active_organisms = [o for o in self.live_organisms.values() if o.status == "active"]
        total_heartbeats = sum(o.heartbeat_beats for o in self.live_organisms.values())
        return {
            "coordination_layer": "SOVEREIGN_ORGANISM_COORDINATION",
            "live_organisms": len(self.live_organisms),
            "active_organisms": len(active_organisms),
            "contracts": len(self.intelligence_contracts),
            "runtime_artifacts": len(self.runtime_artifacts),
            "audit_events": len(self.governance_audit_trail),
            "heartbeat_sync": {
                "frequency_hz": HEARTBEAT_WEBSITE_ORGANISM_HZ,
                "total_heartbeat_beats": total_heartbeats,
            },
        }
    
    def create_paper(
        self,
        title: str,
        latin_title: str,
        primary_author: str,
        abstract: str = "",
        protocol: str = ""
    ) -> ResearchPaper:
        """Create a new research paper."""
        paper_id = f"PAPER-{len(self.papers) + 1:04d}"
        
        paper = ResearchPaper(
            paper_id=paper_id,
            title=title,
            latin_title=latin_title,
            abstract=abstract,
            primary_author=primary_author,
            protocol=protocol
        )
        
        self.papers[paper_id] = paper
        
        # Add to author's work
        if primary_author in self.researchers:
            self.researchers[primary_author].papers_in_progress.append(paper_id)
        
        return paper
    
    def assign_co_author(self, paper_id: str, researcher_id: str) -> bool:
        """Assign a co-author to a paper."""
        if paper_id not in self.papers:
            return False
        if researcher_id not in self.researchers:
            return False
        
        paper = self.papers[paper_id]
        if researcher_id not in paper.co_authors:
            paper.co_authors.append(researcher_id)
            self.researchers[researcher_id].papers_in_progress.append(paper_id)
        
        return True
    
    def write_section(
        self,
        paper_id: str,
        section_name: str,
        content: str,
        writer_id: str
    ) -> bool:
        """Write a section of a paper."""
        if paper_id not in self.papers:
            return False
        
        paper = self.papers[paper_id]
        paper.add_section(section_name, content)
        paper.state = PaperState.WRITING
        
        return True
    
    def submit_for_review(self, paper_id: str) -> bool:
        """Submit a paper for review."""
        if paper_id not in self.papers:
            return False
        
        paper = self.papers[paper_id]
        paper.submit_for_review()
        
        # Auto-assign reviewers
        reviewers = [r for r in self.researchers.values() 
                     if r.role in [ResearcherRole.REVIEWER, ResearcherRole.PEER_REVIEWER]]
        for reviewer in reviewers[:3]:
            paper.reviewers.append(reviewer.researcher_id)
        
        return True
    
    def review_paper(
        self,
        paper_id: str,
        reviewer_id: str,
        score: float,
        comments: str
    ) -> bool:
        """Submit a review for a paper."""
        if paper_id not in self.papers:
            return False
        
        paper = self.papers[paper_id]
        paper.review_comments.append({
            "reviewer": reviewer_id,
            "score": score,
            "comments": comments,
            "timestamp": datetime.now().isoformat()
        })
        
        return True
    
    def publish_paper(self, paper_id: str) -> bool:
        """Publish an approved paper."""
        if paper_id not in self.papers:
            return False
        
        paper = self.papers[paper_id]
        if paper.state != PaperState.APPROVED:
            return False
        
        paper.state = PaperState.PUBLISHED
        paper.calculate_scc()
        self.published_papers.append(paper_id)
        
        # Update author records
        if paper.primary_author in self.researchers:
            self.researchers[paper.primary_author].add_publication(paper_id)
        for co_author_id in paper.co_authors:
            if co_author_id in self.researchers:
                self.researchers[co_author_id].add_publication(paper_id)
        
        return True
    
    def get_lab_status(self) -> Dict[str, Any]:
        """Get full lab status."""
        return {
            "lab_name": self.lab_name,
            "latin_name": "LABORATORIUM INTELLIGENTIAE SOVEREIGNAE",
            "protocol_range": "PROT-346 to PROT-370",
            "primary_frequency_hz": self.lab_frequency,
            "phi": PHI,
            "is_active": self.is_active,
            "statistics": {
                "total_researchers": len(self.researchers),
                "total_areas": len(self.areas),
                "total_papers": len(self.papers),
                "published_papers": len(self.published_papers),
                "protocols_defined": len(self.protocols),
                "research_programs": len(self.research_programs),
                "normalized_targets": len(self.target_identifiers),
                "live_website_organisms": len(self.live_organisms),
                "intelligence_contracts": len(self.intelligence_contracts),
                "runtime_artifacts": len(self.runtime_artifacts),
                "governance_audit_events": len(self.governance_audit_trail)
            },
            "coordination": self.get_coordination_status(),
            "researchers_by_role": {
                role.value: len([r for r in self.researchers.values() if r.role == role])
                for role in ResearcherRole
            },
            "areas_by_type": {
                area_type.value: len([a for a in self.areas.values() if a.area_type == area_type])
                for area_type in LabAreaType
            }
        }


# ═══════════════════════════════════════════════════════════════════════════════
# MODULE EXPORTS
# ═══════════════════════════════════════════════════════════════════════════════

__all__ = [
    "ResearcherRole",
    "PaperState",
    "LabAreaType",
    "LabResearcher",
    "ResearchPaper",
    "ResearchProgram",
    "LiveResearchOrganism",
    "IntelligenceContract",
    "LabArea",
    "ResearchLabPlatform",
    "LAB_RESEARCHERS",
    "LAB_AREAS",
    "RESEARCH_PROTOCOLS",
    "TARGET_IDENTIFIERS",
    "LAB_FREQUENCY",
    "PHI",
    "PHI_11",
    "SCHUMANN",
    "FIBONACCI"
]

__version__ = "φ.0.3.0"
__protocol__ = "PROT-346 to PROT-376"
__author__ = "Alfredo 'Freddy' Medina Hernandez"
__organization__ = "Medina Tech"


# ═══════════════════════════════════════════════════════════════════════════════
# QUICK ACCESS IMPORTS (if submodules are available)
# ═══════════════════════════════════════════════════════════════════════════════

def get_lab_access():
    """Get lab access interface."""
    from .access import get_lab_access as _get_lab_access
    return _get_lab_access()


def enter_lab(user_id: str = "DIRECTOR_MEDINA", area_id: str = "LABORATORIUM_PRINCIPALE"):
    """Quick entry into the lab."""
    from .access import enter_lab as _enter_lab
    return _enter_lab(user_id, area_id)


def start_terminal(interactive: bool = True):
    """Start the lab terminal."""
    from .terminal_interface import start_lab_terminal
    return start_lab_terminal(interactive=interactive)
