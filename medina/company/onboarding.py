"""
MEDINA Company Onboarding — Enterprise integration system.

Implements the three mandatory onboarding modes:

CONNECT MODE:
- API bridges to existing systems
- Data federation (no replication)
- Minimal migration required
- Quick time-to-value

INTERNALIZE MODE:
- Full replication into MEDINA substrate
- Native memory temple storage
- Complete governance control
- Maximum sovereignty

HYBRID MODE:
- Dual-run with reconciliation
- Gradual migration path
- Comparison and validation
- Risk-balanced transition
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional


class OnboardingMode(Enum):
    """Company onboarding modes."""
    
    CONNECT = "connect"         # Integrate current systems
    INTERNALIZE = "internalize" # Replicate to MEDINA-native
    HYBRID = "hybrid"           # Dual run + reconciliation


class OnboardingStatus(Enum):
    """Onboarding lifecycle states."""
    
    PENDING = "pending"           # Awaiting start
    IN_PROGRESS = "in_progress"   # Active onboarding
    VALIDATING = "validating"     # Running validation
    COMPLETED = "completed"       # Successfully onboarded
    FAILED = "failed"             # Onboarding failed
    SUSPENDED = "suspended"       # Temporarily halted


class DataSourceType(Enum):
    """Types of data sources for integration."""
    
    DATABASE = "database"
    API = "api"
    FILE_SYSTEM = "file_system"
    CLOUD_STORAGE = "cloud_storage"
    SAAS = "saas"
    LEGACY = "legacy"


@dataclass
class IntegrationConfig:
    """Configuration for a single integration."""
    
    config_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    source_type: DataSourceType = DataSourceType.API
    
    # Connection
    endpoint: str = ""
    credentials_ref: str = ""  # Reference to secure credential store
    
    # Mapping
    data_mapping: Dict[str, str] = field(default_factory=dict)
    transform_rules: List[Dict[str, Any]] = field(default_factory=list)
    
    # Sync settings
    sync_frequency_minutes: int = 60
    last_sync: Optional[float] = None
    
    # Status
    active: bool = True
    error_count: int = 0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "config_id": self.config_id,
            "name": self.name,
            "source_type": self.source_type.value,
            "endpoint": self.endpoint[:50] + "..." if len(self.endpoint) > 50 else self.endpoint,
            "sync_frequency_minutes": self.sync_frequency_minutes,
            "last_sync": self.last_sync,
            "active": self.active,
            "error_count": self.error_count,
        }


@dataclass
class CompanyProfile:
    """Profile for an onboarded company."""
    
    company_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    domain: str = ""
    
    # Onboarding
    mode: OnboardingMode = OnboardingMode.CONNECT
    status: OnboardingStatus = OnboardingStatus.PENDING
    
    # Configuration
    integrations: List[IntegrationConfig] = field(default_factory=list)
    policies: Dict[str, Any] = field(default_factory=dict)
    
    # Tenant isolation
    tenant_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    namespace: str = ""
    
    # Timestamps
    created_at: float = field(default_factory=time.time)
    onboarded_at: Optional[float] = None
    
    # Replay trails
    onboarding_evidence: List[Dict[str, Any]] = field(default_factory=list)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "company_id": self.company_id,
            "name": self.name,
            "domain": self.domain,
            "mode": self.mode.value,
            "status": self.status.value,
            "tenant_id": self.tenant_id,
            "namespace": self.namespace,
            "integration_count": len(self.integrations),
            "created_at": self.created_at,
            "onboarded_at": self.onboarded_at,
        }


@dataclass
class OnboardingStep:
    """A single step in the onboarding process."""
    
    step_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    description: str = ""
    order: int = 0
    required: bool = True
    
    # Status
    completed: bool = False
    started_at: Optional[float] = None
    completed_at: Optional[float] = None
    error: Optional[str] = None
    
    # Evidence
    evidence: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "step_id": self.step_id,
            "name": self.name,
            "order": self.order,
            "required": self.required,
            "completed": self.completed,
            "started_at": self.started_at,
            "completed_at": self.completed_at,
            "error": self.error,
        }


class CompanyOnboarding:
    """
    MEDINA Company Onboarding System.
    
    Provides native company onboarding in three modes:
    - CONNECT: API integration
    - INTERNALIZE: Full migration
    - HYBRID: Parallel operation
    
    Features:
    - Tenant isolation
    - Policy controls
    - Replay trails
    - Real company workflows from day 1
    """
    
    # Standard onboarding steps by mode
    CONNECT_STEPS = [
        ("discovery", "Discover existing systems", True),
        ("api_bridge", "Configure API bridges", True),
        ("data_mapping", "Define data mappings", True),
        ("auth_setup", "Setup authentication", True),
        ("test_sync", "Test synchronization", True),
        ("policy_config", "Configure policies", False),
        ("activate", "Activate connection", True),
    ]
    
    INTERNALIZE_STEPS = [
        ("discovery", "Discover existing systems", True),
        ("schema_design", "Design MEDINA schema", True),
        ("data_export", "Export source data", True),
        ("data_transform", "Transform to MEDINA format", True),
        ("data_import", "Import to Memory Temple", True),
        ("validation", "Validate imported data", True),
        ("decommission", "Decommission legacy system", False),
        ("activate", "Activate internalized system", True),
    ]
    
    HYBRID_STEPS = [
        ("discovery", "Discover existing systems", True),
        ("parallel_setup", "Setup parallel infrastructure", True),
        ("data_replication", "Configure data replication", True),
        ("reconciliation", "Setup reconciliation rules", True),
        ("dual_run", "Start dual-run operation", True),
        ("comparison", "Compare outputs", True),
        ("gradual_migration", "Gradual traffic migration", False),
        ("cutover", "Final cutover", False),
    ]
    
    def __init__(self) -> None:
        self._companies: Dict[str, CompanyProfile] = {}
        self._onboarding_processes: Dict[str, List[OnboardingStep]] = {}
    
    # ------------------------------------------------------------------ #
    # Company Management                                                    #
    # ------------------------------------------------------------------ #
    
    def create_company(
        self,
        name: str,
        domain: str,
        mode: OnboardingMode,
    ) -> CompanyProfile:
        """Create a new company profile."""
        company = CompanyProfile(
            name=name,
            domain=domain,
            mode=mode,
            namespace=f"company_{name.lower().replace(' ', '_')}",
        )
        self._companies[company.company_id] = company
        
        # Initialize onboarding steps
        self._initialize_onboarding(company)
        
        return company
    
    def _initialize_onboarding(self, company: CompanyProfile) -> None:
        """Initialize onboarding steps based on mode."""
        steps_def = {
            OnboardingMode.CONNECT: self.CONNECT_STEPS,
            OnboardingMode.INTERNALIZE: self.INTERNALIZE_STEPS,
            OnboardingMode.HYBRID: self.HYBRID_STEPS,
        }[company.mode]
        
        steps: List[OnboardingStep] = []
        for i, (name, desc, required) in enumerate(steps_def):
            step = OnboardingStep(
                name=name,
                description=desc,
                order=i,
                required=required,
            )
            steps.append(step)
        
        self._onboarding_processes[company.company_id] = steps
    
    def get_company(self, company_id: str) -> Optional[CompanyProfile]:
        """Get company by ID."""
        return self._companies.get(company_id)
    
    def list_companies(
        self,
        status: Optional[OnboardingStatus] = None,
        mode: Optional[OnboardingMode] = None,
    ) -> List[CompanyProfile]:
        """List companies with optional filters."""
        companies = list(self._companies.values())
        
        if status:
            companies = [c for c in companies if c.status == status]
        if mode:
            companies = [c for c in companies if c.mode == mode]
        
        return companies
    
    # ------------------------------------------------------------------ #
    # Onboarding Workflow                                                   #
    # ------------------------------------------------------------------ #
    
    def start_onboarding(self, company_id: str) -> bool:
        """Start the onboarding process for a company."""
        if company_id not in self._companies:
            return False
        
        company = self._companies[company_id]
        if company.status != OnboardingStatus.PENDING:
            return False
        
        company.status = OnboardingStatus.IN_PROGRESS
        
        # Record evidence
        company.onboarding_evidence.append({
            "event": "onboarding_started",
            "timestamp": time.time(),
            "mode": company.mode.value,
        })
        
        return True
    
    def complete_step(
        self,
        company_id: str,
        step_name: str,
        evidence: Optional[Dict[str, Any]] = None,
    ) -> bool:
        """Mark an onboarding step as complete."""
        if company_id not in self._onboarding_processes:
            return False
        
        steps = self._onboarding_processes[company_id]
        
        for step in steps:
            if step.name == step_name:
                if step.completed:
                    return False
                
                step.completed = True
                step.completed_at = time.time()
                if evidence:
                    step.evidence = evidence
                
                # Record in company evidence
                company = self._companies[company_id]
                company.onboarding_evidence.append({
                    "event": "step_completed",
                    "step": step_name,
                    "timestamp": time.time(),
                })
                
                # Check if onboarding complete
                self._check_onboarding_completion(company_id)
                
                return True
        
        return False
    
    def fail_step(
        self,
        company_id: str,
        step_name: str,
        error: str,
    ) -> bool:
        """Mark an onboarding step as failed."""
        if company_id not in self._onboarding_processes:
            return False
        
        steps = self._onboarding_processes[company_id]
        
        for step in steps:
            if step.name == step_name:
                step.error = error
                
                # Mark company as failed if required step
                if step.required:
                    company = self._companies[company_id]
                    company.status = OnboardingStatus.FAILED
                    company.onboarding_evidence.append({
                        "event": "onboarding_failed",
                        "step": step_name,
                        "error": error,
                        "timestamp": time.time(),
                    })
                
                return True
        
        return False
    
    def _check_onboarding_completion(self, company_id: str) -> None:
        """Check if all required steps are complete."""
        steps = self._onboarding_processes.get(company_id, [])
        company = self._companies.get(company_id)
        
        if not company:
            return
        
        all_required_complete = all(
            step.completed for step in steps if step.required
        )
        
        if all_required_complete:
            company.status = OnboardingStatus.COMPLETED
            company.onboarded_at = time.time()
            company.onboarding_evidence.append({
                "event": "onboarding_completed",
                "timestamp": time.time(),
            })
    
    def get_onboarding_progress(
        self,
        company_id: str,
    ) -> Dict[str, Any]:
        """Get onboarding progress for a company."""
        company = self._companies.get(company_id)
        steps = self._onboarding_processes.get(company_id, [])
        
        if not company:
            return {"error": "Company not found"}
        
        completed = sum(1 for s in steps if s.completed)
        required = sum(1 for s in steps if s.required)
        required_completed = sum(1 for s in steps if s.required and s.completed)
        
        return {
            "company_id": company_id,
            "company_name": company.name,
            "mode": company.mode.value,
            "status": company.status.value,
            "total_steps": len(steps),
            "completed_steps": completed,
            "required_steps": required,
            "required_completed": required_completed,
            "progress_percent": round((required_completed / required) * 100, 1) if required > 0 else 0,
            "steps": [s.to_dict() for s in steps],
        }
    
    # ------------------------------------------------------------------ #
    # Integration Management                                                #
    # ------------------------------------------------------------------ #
    
    def add_integration(
        self,
        company_id: str,
        config: IntegrationConfig,
    ) -> bool:
        """Add an integration configuration to a company."""
        company = self._companies.get(company_id)
        if not company:
            return False
        
        company.integrations.append(config)
        return True
    
    def remove_integration(
        self,
        company_id: str,
        config_id: str,
    ) -> bool:
        """Remove an integration configuration."""
        company = self._companies.get(company_id)
        if not company:
            return False
        
        company.integrations = [
            i for i in company.integrations if i.config_id != config_id
        ]
        return True
    
    def list_integrations(
        self,
        company_id: str,
    ) -> List[IntegrationConfig]:
        """List integrations for a company."""
        company = self._companies.get(company_id)
        if not company:
            return []
        return company.integrations
    
    # ------------------------------------------------------------------ #
    # Replay / Evidence                                                     #
    # ------------------------------------------------------------------ #
    
    def get_evidence_trail(
        self,
        company_id: str,
    ) -> List[Dict[str, Any]]:
        """Get the full onboarding evidence trail."""
        company = self._companies.get(company_id)
        if not company:
            return []
        return company.onboarding_evidence
    
    # ------------------------------------------------------------------ #
    # Status                                                                #
    # ------------------------------------------------------------------ #
    
    def status(self) -> Dict[str, Any]:
        """System-wide onboarding status."""
        by_status: Dict[str, int] = {}
        by_mode: Dict[str, int] = {}
        
        for company in self._companies.values():
            by_status[company.status.value] = by_status.get(company.status.value, 0) + 1
            by_mode[company.mode.value] = by_mode.get(company.mode.value, 0) + 1
        
        return {
            "total_companies": len(self._companies),
            "by_status": by_status,
            "by_mode": by_mode,
        }
