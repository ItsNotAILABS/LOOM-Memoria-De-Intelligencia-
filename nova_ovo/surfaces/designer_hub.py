"""
Designer Hub — Project Intelligence and Manufacturer Catalog
=============================================================
Central hub for designers with:
- Manufacturer catalog
- Project intelligence
- CEU (Continuing Education Unit) tracker
- Design team presets

The Designer Hub aggregates design-related capabilities
into a unified surface.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional


class CEUCategory(str, Enum):
    """CEU categories for professional development."""
    HEALTH_SAFETY = "health_safety"
    SUSTAINABILITY = "sustainability"
    ACCESSIBILITY = "accessibility"
    TECHNOLOGY = "technology"
    DESIGN_PRACTICE = "design_practice"
    PROJECT_MANAGEMENT = "project_management"


@dataclass
class ManufacturerEntry:
    """A manufacturer in the catalog."""
    
    manufacturer_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    category: str = ""
    subcategory: str = ""
    
    # Contact
    website: str = ""
    contact_email: str = ""
    contact_phone: str = ""
    
    # Products
    product_count: int = 0
    featured_products: List[str] = field(default_factory=list)
    
    # Certifications
    certifications: List[str] = field(default_factory=list)
    
    # Ratings
    quality_rating: float = 0.0
    service_rating: float = 0.0
    sustainability_rating: float = 0.0
    
    # Metadata
    added_at: float = field(default_factory=time.time)
    last_updated: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "manufacturer_id": self.manufacturer_id,
            "name": self.name,
            "category": self.category,
            "subcategory": self.subcategory,
            "website": self.website,
            "product_count": self.product_count,
            "certifications": self.certifications,
            "ratings": {
                "quality": self.quality_rating,
                "service": self.service_rating,
                "sustainability": self.sustainability_rating,
            },
        }


class ManufacturerCatalog:
    """Manufacturer catalog with search and filtering."""
    
    def __init__(self) -> None:
        self._manufacturers: Dict[str, ManufacturerEntry] = {}
        self._by_category: Dict[str, List[str]] = {}
    
    def add(self, manufacturer: ManufacturerEntry) -> None:
        """Add a manufacturer to the catalog."""
        self._manufacturers[manufacturer.manufacturer_id] = manufacturer
        
        cat = manufacturer.category
        if cat not in self._by_category:
            self._by_category[cat] = []
        self._by_category[cat].append(manufacturer.manufacturer_id)
    
    def get(self, manufacturer_id: str) -> Optional[ManufacturerEntry]:
        """Get manufacturer by ID."""
        return self._manufacturers.get(manufacturer_id)
    
    def search(
        self,
        query: str = "",
        category: Optional[str] = None,
        min_rating: float = 0.0,
    ) -> List[ManufacturerEntry]:
        """Search manufacturers."""
        results = list(self._manufacturers.values())
        
        if query:
            query_lower = query.lower()
            results = [m for m in results if query_lower in m.name.lower()]
        
        if category:
            results = [m for m in results if m.category == category]
        
        if min_rating > 0:
            results = [m for m in results if m.quality_rating >= min_rating]
        
        return results
    
    def get_categories(self) -> List[str]:
        """Get all categories."""
        return list(self._by_category.keys())
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get catalog statistics."""
        return {
            "total_manufacturers": len(self._manufacturers),
            "categories": len(self._by_category),
            "by_category": {k: len(v) for k, v in self._by_category.items()},
        }


@dataclass
class ProjectEntry:
    """A design project entry."""
    
    project_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    client: str = ""
    project_type: str = ""
    
    # Status
    status: str = "active"  # "planning", "active", "completed", "archived"
    progress: float = 0.0  # 0-100%
    
    # Timeline
    start_date: Optional[float] = None
    due_date: Optional[float] = None
    completed_date: Optional[float] = None
    
    # Team
    team_members: List[str] = field(default_factory=list)
    lead_designer: str = ""
    
    # Intelligence
    risk_score: float = 0.0  # 0-1, higher = more risk
    health_score: float = 1.0  # 0-1, higher = healthier
    predicted_completion: Optional[float] = None
    
    # Metadata
    created_at: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "project_id": self.project_id,
            "name": self.name,
            "client": self.client,
            "type": self.project_type,
            "status": self.status,
            "progress": self.progress,
            "timeline": {
                "start": self.start_date,
                "due": self.due_date,
                "completed": self.completed_date,
            },
            "team_size": len(self.team_members),
            "intelligence": {
                "risk": self.risk_score,
                "health": self.health_score,
                "predicted_completion": self.predicted_completion,
            },
        }


class ProjectIntelligence:
    """Project intelligence and analytics."""
    
    def __init__(self) -> None:
        self._projects: Dict[str, ProjectEntry] = {}
    
    def add_project(self, project: ProjectEntry) -> None:
        """Add a project."""
        self._projects[project.project_id] = project
    
    def get_project(self, project_id: str) -> Optional[ProjectEntry]:
        """Get project by ID."""
        return self._projects.get(project_id)
    
    def analyze_project(self, project_id: str) -> Dict[str, Any]:
        """Analyze project health and risk."""
        project = self._projects.get(project_id)
        if not project:
            return {"error": "Project not found"}
        
        # Simple analysis
        risk_factors = []
        
        if project.progress < 50 and project.due_date:
            time_remaining = project.due_date - time.time()
            if time_remaining < 0:
                risk_factors.append("overdue")
                project.risk_score = min(1.0, project.risk_score + 0.3)
            elif time_remaining < 7 * 24 * 3600:  # Less than 7 days
                risk_factors.append("tight_deadline")
                project.risk_score = min(1.0, project.risk_score + 0.1)
        
        if len(project.team_members) == 0:
            risk_factors.append("no_team")
            project.risk_score = min(1.0, project.risk_score + 0.2)
        
        project.health_score = 1.0 - project.risk_score
        
        return {
            "project_id": project_id,
            "risk_score": project.risk_score,
            "health_score": project.health_score,
            "risk_factors": risk_factors,
        }
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get project statistics."""
        projects = list(self._projects.values())
        
        by_status: Dict[str, int] = {}
        for p in projects:
            by_status[p.status] = by_status.get(p.status, 0) + 1
        
        avg_progress = sum(p.progress for p in projects) / max(len(projects), 1)
        at_risk = sum(1 for p in projects if p.risk_score > 0.5)
        
        return {
            "total_projects": len(projects),
            "by_status": by_status,
            "average_progress": round(avg_progress, 1),
            "at_risk_count": at_risk,
        }


@dataclass
class CEURecord:
    """A CEU credit record."""
    
    record_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    user_id: str = ""
    
    # Course info
    course_name: str = ""
    provider: str = ""
    category: CEUCategory = CEUCategory.DESIGN_PRACTICE
    
    # Credits
    credits: float = 0.0
    
    # Completion
    completed_at: float = field(default_factory=time.time)
    certificate_id: str = ""
    
    # Verification
    verified: bool = False
    verified_at: Optional[float] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "record_id": self.record_id,
            "user_id": self.user_id,
            "course_name": self.course_name,
            "provider": self.provider,
            "category": self.category.value,
            "credits": self.credits,
            "completed_at": self.completed_at,
            "verified": self.verified,
        }


class CEUTracker:
    """CEU tracking and management."""
    
    def __init__(self) -> None:
        self._records: Dict[str, CEURecord] = {}
        self._by_user: Dict[str, List[str]] = {}
    
    def add_record(self, record: CEURecord) -> None:
        """Add a CEU record."""
        self._records[record.record_id] = record
        
        user = record.user_id
        if user not in self._by_user:
            self._by_user[user] = []
        self._by_user[user].append(record.record_id)
    
    def get_user_credits(self, user_id: str) -> Dict[str, float]:
        """Get total credits by category for a user."""
        record_ids = self._by_user.get(user_id, [])
        
        by_category: Dict[str, float] = {}
        for rid in record_ids:
            record = self._records.get(rid)
            if record:
                cat = record.category.value
                by_category[cat] = by_category.get(cat, 0) + record.credits
        
        return by_category
    
    def get_user_total(self, user_id: str) -> float:
        """Get total credits for a user."""
        credits = self.get_user_credits(user_id)
        return sum(credits.values())
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get tracker statistics."""
        return {
            "total_records": len(self._records),
            "total_users": len(self._by_user),
            "total_credits": sum(r.credits for r in self._records.values()),
        }


@dataclass
class DesignTeamPreset:
    """A saved design team configuration preset."""
    
    preset_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    description: str = ""
    
    # Team structure
    roles: List[str] = field(default_factory=list)
    team_size: int = 0
    
    # Settings
    workflow: str = ""
    tools: List[str] = field(default_factory=list)
    standards: List[str] = field(default_factory=list)
    
    # Metadata
    created_by: str = ""
    created_at: float = field(default_factory=time.time)
    usage_count: int = 0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "preset_id": self.preset_id,
            "name": self.name,
            "description": self.description,
            "team_size": self.team_size,
            "roles": self.roles,
            "workflow": self.workflow,
            "tools": self.tools,
            "usage_count": self.usage_count,
        }


@dataclass
class DesignerHub:
    """
    Designer Hub — Unified design management surface.
    
    Features:
    - Manufacturer catalog
    - Project intelligence
    - CEU tracking
    - Team presets
    """
    
    enabled: bool = True
    name: str = "Designer Hub"
    
    # Components
    catalog: ManufacturerCatalog = field(default_factory=ManufacturerCatalog)
    projects: ProjectIntelligence = field(default_factory=ProjectIntelligence)
    ceu: CEUTracker = field(default_factory=CEUTracker)
    
    # Team presets
    presets: Dict[str, DesignTeamPreset] = field(default_factory=dict)
    
    # Metadata
    created_at: float = field(default_factory=time.time)
    
    def add_preset(self, preset: DesignTeamPreset) -> None:
        """Add a team preset."""
        self.presets[preset.preset_id] = preset
    
    def get_preset(self, preset_id: str) -> Optional[DesignTeamPreset]:
        """Get a preset by ID."""
        return self.presets.get(preset_id)
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get hub statistics."""
        return {
            "name": self.name,
            "enabled": self.enabled,
            "catalog": self.catalog.get_statistics(),
            "projects": self.projects.get_statistics(),
            "ceu": self.ceu.get_statistics(),
            "presets_count": len(self.presets),
        }
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "enabled": self.enabled,
            "statistics": self.get_statistics(),
            "created_at": self.created_at,
        }
