"""
Company Onboarding — Enterprise Operations
==========================================
Three mandatory onboarding modes:
1. CONNECT — integrate current systems
2. INTERNALIZE — replicate into MEDINA-native substrate
3. HYBRID — dual run + reconciliation

Tenant isolation, policy controls, replay trails.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional


class OnboardingMode(str, Enum):
    """Company onboarding modes."""
    CONNECT = "connect"
    INTERNALIZE = "internalize"
    HYBRID = "hybrid"


class OnboardingStatus(str, Enum):
    """Onboarding lifecycle status."""
    PENDING = "pending"
    IN_PROGRESS = "in_progress"
    ACTIVE = "active"
    SUSPENDED = "suspended"
    OFFBOARDED = "offboarded"


class TenantIsolationLevel(str, Enum):
    """Tenant isolation levels."""
    STRICT = "strict"       # Full isolation
    STANDARD = "standard"   # Logical isolation
    SHARED = "shared"       # Shared with boundaries


@dataclass
class TenantBoundary:
    """Defines tenant isolation boundaries."""
    
    boundary_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    tenant_id: str = ""
    isolation_level: TenantIsolationLevel = TenantIsolationLevel.STANDARD
    data_namespace: str = ""
    compute_namespace: str = ""
    network_segment: str = ""
    created_at: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "boundary_id": self.boundary_id,
            "tenant_id": self.tenant_id,
            "isolation_level": self.isolation_level.value,
            "data_namespace": self.data_namespace,
            "compute_namespace": self.compute_namespace,
            "network_segment": self.network_segment,
            "created_at": self.created_at,
        }


@dataclass
class PolicyControl:
    """A policy control for a tenant."""
    
    policy_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    enabled: bool = True
    scope: str = "tenant"
    rules: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "policy_id": self.policy_id,
            "name": self.name,
            "enabled": self.enabled,
            "scope": self.scope,
            "rules": self.rules,
        }


@dataclass
class ReplayTrail:
    """A replay trail entry for audit."""
    
    trail_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    event_type: str = ""
    company_id: str = ""
    actor: str = "system"
    payload: Dict[str, Any] = field(default_factory=dict)
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "trail_id": self.trail_id,
            "event_type": self.event_type,
            "company_id": self.company_id,
            "actor": self.actor,
            "payload": self.payload,
            "timestamp": self.timestamp,
        }


@dataclass
class Company:
    """An onboarded company/tenant."""
    
    company_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    mode: OnboardingMode = OnboardingMode.CONNECT
    status: OnboardingStatus = OnboardingStatus.PENDING
    
    # Tenant isolation
    boundary: Optional[TenantBoundary] = None
    
    # Policy controls
    policies: List[PolicyControl] = field(default_factory=list)
    
    # Replay trails
    replay_trails: List[ReplayTrail] = field(default_factory=list)
    
    # Mode-specific config
    connect_config: Dict[str, Any] = field(default_factory=dict)
    internalize_config: Dict[str, Any] = field(default_factory=dict)
    hybrid_config: Dict[str, Any] = field(default_factory=dict)
    
    # Metadata
    metadata: Dict[str, Any] = field(default_factory=dict)
    created_at: float = field(default_factory=time.time)
    activated_at: Optional[float] = None
    
    def add_trail(self, event_type: str, payload: Dict[str, Any], actor: str = "system") -> ReplayTrail:
        """Add a replay trail entry."""
        trail = ReplayTrail(
            event_type=event_type,
            company_id=self.company_id,
            actor=actor,
            payload=payload,
        )
        self.replay_trails.append(trail)
        return trail
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "company_id": self.company_id,
            "name": self.name,
            "mode": self.mode.value,
            "status": self.status.value,
            "boundary": self.boundary.to_dict() if self.boundary else None,
            "policy_count": len(self.policies),
            "trail_count": len(self.replay_trails),
            "created_at": self.created_at,
            "activated_at": self.activated_at,
        }


# Default policies for all tenants
DEFAULT_POLICIES = [
    PolicyControl(name="data_isolation", enabled=True, scope="tenant", rules={"isolation_level": "strict"}),
    PolicyControl(name="audit_logging", enabled=True, scope="tenant", rules={"retention_days": 90}),
    PolicyControl(name="access_control", enabled=True, scope="tenant", rules={"rbac_enabled": True}),
    PolicyControl(name="projection_safety", enabled=True, scope="tenant", rules={"gate_c_enforced": True}),
]


class CompanyOnboarder:
    """
    Manager for company onboarding.
    
    Handles all three onboarding modes:
    - CONNECT: API bridge integration
    - INTERNALIZE: Full migration to MEDINA substrate
    - HYBRID: Dual-run with reconciliation
    """
    
    def __init__(self) -> None:
        self._companies: Dict[str, Company] = {}
    
    def onboard(
        self,
        name: str,
        mode: OnboardingMode,
        isolation_level: TenantIsolationLevel = TenantIsolationLevel.STANDARD,
        metadata: Optional[Dict[str, Any]] = None,
    ) -> Company:
        """
        Onboard a new company.
        
        Creates tenant boundary, applies default policies,
        and initializes mode-specific configuration.
        """
        company = Company(
            name=name,
            mode=mode,
            status=OnboardingStatus.IN_PROGRESS,
            metadata=metadata or {},
        )
        
        # Create tenant boundary
        company.boundary = TenantBoundary(
            tenant_id=company.company_id,
            isolation_level=isolation_level,
            data_namespace=f"tenant-{company.company_id[:8]}",
            compute_namespace=f"compute-{company.company_id[:8]}",
            network_segment=f"net-{company.company_id[:8]}",
        )
        
        # Apply default policies
        for policy in DEFAULT_POLICIES:
            company.policies.append(PolicyControl(
                name=policy.name,
                enabled=policy.enabled,
                scope=policy.scope,
                rules=dict(policy.rules),
            ))
        
        # Initialize mode-specific configuration
        if mode == OnboardingMode.CONNECT:
            company.connect_config = self._init_connect_config()
        elif mode == OnboardingMode.INTERNALIZE:
            company.internalize_config = self._init_internalize_config()
        elif mode == OnboardingMode.HYBRID:
            company.hybrid_config = self._init_hybrid_config()
        
        # Add trail
        company.add_trail("onboarding_started", {
            "mode": mode.value,
            "isolation_level": isolation_level.value,
        })
        
        self._companies[company.company_id] = company
        return company
    
    def _init_connect_config(self) -> Dict[str, Any]:
        """Initialize CONNECT mode configuration."""
        return {
            "integration_type": "api_bridge",
            "sync_direction": "bidirectional",
            "polling_interval_s": 60,
            "webhook_enabled": True,
            "auth_method": "oauth2",
        }
    
    def _init_internalize_config(self) -> Dict[str, Any]:
        """Initialize INTERNALIZE mode configuration."""
        return {
            "migration_type": "full_replication",
            "native_substrate": True,
            "legacy_bridge": False,
            "data_transform": "medina_native",
        }
    
    def _init_hybrid_config(self) -> Dict[str, Any]:
        """Initialize HYBRID mode configuration."""
        return {
            "dual_run": True,
            "reconciliation_enabled": True,
            "sync_interval_s": 300,
            "conflict_resolution": "medina_primary",
            "rollback_enabled": True,
        }
    
    def activate(self, company_id: str) -> bool:
        """Activate an onboarded company."""
        company = self._companies.get(company_id)
        if not company:
            return False
        
        company.status = OnboardingStatus.ACTIVE
        company.activated_at = time.time()
        company.add_trail("company_activated", {})
        
        return True
    
    def suspend(self, company_id: str, reason: str = "") -> bool:
        """Suspend a company."""
        company = self._companies.get(company_id)
        if not company:
            return False
        
        company.status = OnboardingStatus.SUSPENDED
        company.add_trail("company_suspended", {"reason": reason})
        
        return True
    
    def offboard(self, company_id: str, reason: str = "") -> bool:
        """Offboard a company."""
        company = self._companies.get(company_id)
        if not company:
            return False
        
        company.status = OnboardingStatus.OFFBOARDED
        company.add_trail("company_offboarded", {"reason": reason})
        
        return True
    
    def get_company(self, company_id: str) -> Optional[Company]:
        """Get a company by ID."""
        return self._companies.get(company_id)
    
    def get_by_name(self, name: str) -> Optional[Company]:
        """Get a company by name."""
        for company in self._companies.values():
            if company.name == name:
                return company
        return None
    
    def list_companies(
        self,
        mode: Optional[OnboardingMode] = None,
        status: Optional[OnboardingStatus] = None,
    ) -> List[Company]:
        """List companies with optional filters."""
        companies = list(self._companies.values())
        
        if mode:
            companies = [c for c in companies if c.mode == mode]
        
        if status:
            companies = [c for c in companies if c.status == status]
        
        return companies
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get onboarding statistics."""
        companies = list(self._companies.values())
        
        by_mode: Dict[str, int] = {}
        by_status: Dict[str, int] = {}
        
        for c in companies:
            by_mode[c.mode.value] = by_mode.get(c.mode.value, 0) + 1
            by_status[c.status.value] = by_status.get(c.status.value, 0) + 1
        
        return {
            "total_companies": len(companies),
            "by_mode": by_mode,
            "by_status": by_status,
            "total_trails": sum(len(c.replay_trails) for c in companies),
        }
