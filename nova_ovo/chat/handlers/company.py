"""
Company Handler — /company command operations
==============================================
Handles enterprise company onboarding operations:
- /company onboard <name> — start onboarding flow
- /company connect <name> — CONNECT mode (integrate current systems)
- /company internalize <name> — INTERNALIZE mode (replicate into MEDINA)
- /company hybrid <name> — HYBRID mode (dual run + reconciliation)
- /company status — show onboarding status
- /company list — list onboarded companies

All 3 modes mandatory:
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
from typing import Any, Dict, List, Optional, TYPE_CHECKING

if TYPE_CHECKING:
    from ..parser import ParsedCommand
    from ..router import CommandResult


class OnboardingMode(str, Enum):
    CONNECT = "connect"
    INTERNALIZE = "internalize"
    HYBRID = "hybrid"


class OnboardingStatus(str, Enum):
    PENDING = "pending"
    IN_PROGRESS = "in_progress"
    ACTIVE = "active"
    SUSPENDED = "suspended"
    OFFBOARDED = "offboarded"


@dataclass
class PolicyControl:
    """A policy control for tenant governance."""
    
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
    mode: Optional[OnboardingMode] = None
    status: OnboardingStatus = OnboardingStatus.PENDING
    created_at: float = field(default_factory=time.time)
    activated_at: Optional[float] = None
    policies: List[PolicyControl] = field(default_factory=list)
    replay_trails: List[ReplayTrail] = field(default_factory=list)
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    # Tenant isolation boundaries
    data_boundary: str = ""
    compute_boundary: str = ""
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "company_id": self.company_id,
            "name": self.name,
            "mode": self.mode.value if self.mode else None,
            "status": self.status.value,
            "created_at": self.created_at,
            "activated_at": self.activated_at,
            "policy_count": len(self.policies),
            "trail_count": len(self.replay_trails),
            "data_boundary": self.data_boundary,
            "compute_boundary": self.compute_boundary,
            "metadata": self.metadata,
        }


# Default policies for new tenants
DEFAULT_POLICIES = [
    PolicyControl(name="data_isolation", enabled=True, scope="tenant", rules={"isolation_level": "strict"}),
    PolicyControl(name="audit_logging", enabled=True, scope="tenant", rules={"retention_days": 90}),
    PolicyControl(name="access_control", enabled=True, scope="tenant", rules={"rbac_enabled": True}),
    PolicyControl(name="projection_safety", enabled=True, scope="tenant", rules={"gate_c_enforced": True}),
]


class CompanyHandler:
    """
    Handler for /company command domain.
    
    Enterprise company onboarding with 3 modes:
    - CONNECT: integrate current systems
    - INTERNALIZE: replicate into MEDINA-native substrate
    - HYBRID: dual run + reconciliation
    """
    
    def __init__(self) -> None:
        self._companies: Dict[str, Company] = {}
    
    def __call__(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Route to appropriate company action."""
        from ..router import CommandResult
        
        action = command.action
        
        if action == "onboard":
            return self._onboard(command, ctx)
        elif action == "connect":
            return self._connect(command, ctx)
        elif action == "internalize":
            return self._internalize(command, ctx)
        elif action == "hybrid":
            return self._hybrid(command, ctx)
        elif action == "status":
            return self._status(command, ctx)
        elif action == "list":
            return self._list(command, ctx)
        else:
            return CommandResult(
                success=False,
                error=f"Unknown company action: {action}",
                message="Valid actions: onboard, connect, internalize, hybrid, status, list",
            )
    
    def _create_company(self, name: str, mode: OnboardingMode, kwargs: Dict[str, Any]) -> Company:
        """Create a new company with default policies."""
        company = Company(
            name=name,
            mode=mode,
            status=OnboardingStatus.IN_PROGRESS,
            data_boundary=f"tenant-{uuid.uuid4().hex[:8]}",
            compute_boundary=f"compute-{uuid.uuid4().hex[:8]}",
            metadata=kwargs,
        )
        
        # Add default policies
        for policy in DEFAULT_POLICIES:
            company.policies.append(PolicyControl(
                name=policy.name,
                enabled=policy.enabled,
                scope=policy.scope,
                rules=dict(policy.rules),
            ))
        
        # Add initial replay trail
        company.replay_trails.append(ReplayTrail(
            event_type="onboarding_started",
            company_id=company.company_id,
            payload={"mode": mode.value, "name": name},
        ))
        
        return company
    
    def _onboard(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Start onboarding flow (mode selection)."""
        from ..router import CommandResult
        
        if not command.args:
            return CommandResult(
                success=False,
                error="Company name required for onboarding",
            )
        
        name = command.args[0]
        
        # Check if already exists
        existing = next((c for c in self._companies.values() if c.name == name), None)
        if existing:
            return CommandResult(
                success=False,
                error=f"Company already exists: {name}",
                data={"company": existing.to_dict()},
            )
        
        return CommandResult(
            success=True,
            data={
                "company_name": name,
                "available_modes": [m.value for m in OnboardingMode],
                "next_step": "Use /company connect|internalize|hybrid <name> to choose mode",
            },
            message=f"Ready to onboard: {name}. Select mode: connect, internalize, or hybrid",
        )
    
    def _connect(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """CONNECT mode — integrate current systems."""
        from ..router import CommandResult
        
        if not command.args:
            return CommandResult(
                success=False,
                error="Company name required",
            )
        
        name = command.args[0]
        company = self._create_company(name, OnboardingMode.CONNECT, command.kwargs)
        
        # CONNECT-specific setup
        company.replay_trails.append(ReplayTrail(
            event_type="connect_mode_configured",
            company_id=company.company_id,
            payload={
                "integration_type": "api_bridge",
                "sync_direction": "bidirectional",
            },
        ))
        
        company.status = OnboardingStatus.ACTIVE
        company.activated_at = time.time()
        
        self._companies[company.company_id] = company
        
        return CommandResult(
            success=True,
            data={"company": company.to_dict()},
            message=f"Company onboarded in CONNECT mode: {name}",
        )
    
    def _internalize(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """INTERNALIZE mode — replicate into MEDINA-native substrate."""
        from ..router import CommandResult
        
        if not command.args:
            return CommandResult(
                success=False,
                error="Company name required",
            )
        
        name = command.args[0]
        company = self._create_company(name, OnboardingMode.INTERNALIZE, command.kwargs)
        
        # INTERNALIZE-specific setup
        company.replay_trails.append(ReplayTrail(
            event_type="internalize_mode_configured",
            company_id=company.company_id,
            payload={
                "migration_type": "full_replication",
                "native_substrate": True,
            },
        ))
        
        company.status = OnboardingStatus.ACTIVE
        company.activated_at = time.time()
        
        self._companies[company.company_id] = company
        
        return CommandResult(
            success=True,
            data={"company": company.to_dict()},
            message=f"Company onboarded in INTERNALIZE mode: {name}",
        )
    
    def _hybrid(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """HYBRID mode — dual run + reconciliation."""
        from ..router import CommandResult
        
        if not command.args:
            return CommandResult(
                success=False,
                error="Company name required",
            )
        
        name = command.args[0]
        company = self._create_company(name, OnboardingMode.HYBRID, command.kwargs)
        
        # HYBRID-specific setup
        company.replay_trails.append(ReplayTrail(
            event_type="hybrid_mode_configured",
            company_id=company.company_id,
            payload={
                "dual_run": True,
                "reconciliation_enabled": True,
                "sync_interval_s": 300,
            },
        ))
        
        company.status = OnboardingStatus.ACTIVE
        company.activated_at = time.time()
        
        self._companies[company.company_id] = company
        
        return CommandResult(
            success=True,
            data={"company": company.to_dict()},
            message=f"Company onboarded in HYBRID mode: {name}",
        )
    
    def _status(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """Show company status."""
        from ..router import CommandResult
        
        if command.args:
            # Status of specific company
            identifier = command.args[0]
            company = self._companies.get(identifier)
            if company is None:
                company = next((c for c in self._companies.values() if c.name == identifier), None)
            
            if company is None:
                return CommandResult(
                    success=False,
                    error=f"Company not found: {identifier}",
                )
            
            return CommandResult(
                success=True,
                data={
                    "company": company.to_dict(),
                    "policies": [p.to_dict() for p in company.policies],
                    "recent_trails": [t.to_dict() for t in company.replay_trails[-10:]],
                },
                message=f"Company status: {company.name}",
            )
        
        # Overall status
        by_mode: Dict[str, int] = {}
        by_status: Dict[str, int] = {}
        
        for c in self._companies.values():
            mode = c.mode.value if c.mode else "none"
            by_mode[mode] = by_mode.get(mode, 0) + 1
            by_status[c.status.value] = by_status.get(c.status.value, 0) + 1
        
        return CommandResult(
            success=True,
            data={
                "total_companies": len(self._companies),
                "by_mode": by_mode,
                "by_status": by_status,
            },
            message=f"Companies: {len(self._companies)} total",
        )
    
    def _list(self, command: "ParsedCommand", ctx: Dict[str, Any]) -> "CommandResult":
        """List onboarded companies."""
        from ..router import CommandResult
        
        mode_filter = command.kwargs.get("mode")
        status_filter = command.kwargs.get("status")
        
        companies = list(self._companies.values())
        
        if mode_filter:
            companies = [c for c in companies if c.mode and c.mode.value == mode_filter]
        
        if status_filter:
            companies = [c for c in companies if c.status.value == status_filter]
        
        return CommandResult(
            success=True,
            data={
                "companies": [c.to_dict() for c in companies],
                "total": len(companies),
            },
            message=f"Listed {len(companies)} companies",
        )
