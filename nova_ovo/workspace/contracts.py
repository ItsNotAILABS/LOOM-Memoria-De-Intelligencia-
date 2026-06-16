"""
Integration Contracts — Workspace Fabric
========================================
Contracts governing integration between components.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional


class ContractStatus(str, Enum):
    """Contract lifecycle status."""
    DRAFT = "draft"
    ACTIVE = "active"
    SUSPENDED = "suspended"
    TERMINATED = "terminated"
    EXPIRED = "expired"


class ContractType(str, Enum):
    """Types of integration contracts."""
    API = "api"
    DATA = "data"
    EVENT = "event"
    SERVICE = "service"
    GATEWAY = "gateway"


@dataclass
class ContractTerm:
    """A single term in a contract."""
    
    term_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    term_type: str = ""
    description: str = ""
    required: bool = True
    validation_rule: str = ""
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "term_id": self.term_id,
            "term_type": self.term_type,
            "description": self.description,
            "required": self.required,
            "validation_rule": self.validation_rule,
        }


@dataclass
class IntegrationContract:
    """
    Contract defining integration between components.
    
    Contracts specify:
    - Interface requirements
    - Data formats
    - Quality of service
    - Compliance requirements
    """
    
    contract_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    contract_type: ContractType = ContractType.API
    status: ContractStatus = ContractStatus.DRAFT
    
    # Parties
    provider: str = ""
    consumer: str = ""
    
    # Terms
    terms: List[ContractTerm] = field(default_factory=list)
    
    # Interface specification
    interface_spec: Dict[str, Any] = field(default_factory=dict)
    
    # Quality of service
    sla: Dict[str, Any] = field(default_factory=dict)
    
    # Compliance
    compliance_requirements: List[str] = field(default_factory=list)
    
    # Versioning
    version: str = "1.0.0"
    previous_version_id: Optional[str] = None
    
    # Lifecycle
    created_at: float = field(default_factory=time.time)
    activated_at: Optional[float] = None
    expires_at: Optional[float] = None
    
    def activate(self) -> None:
        """Activate the contract."""
        self.status = ContractStatus.ACTIVE
        self.activated_at = time.time()
    
    def suspend(self) -> None:
        """Suspend the contract."""
        self.status = ContractStatus.SUSPENDED
    
    def terminate(self) -> None:
        """Terminate the contract."""
        self.status = ContractStatus.TERMINATED
    
    def add_term(
        self,
        term_type: str,
        description: str,
        required: bool = True,
        validation_rule: str = "",
    ) -> ContractTerm:
        """Add a term to the contract."""
        term = ContractTerm(
            term_type=term_type,
            description=description,
            required=required,
            validation_rule=validation_rule,
        )
        self.terms.append(term)
        return term
    
    def validate_against(self, data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Validate data against contract terms."""
        violations: List[Dict[str, Any]] = []
        
        for term in self.terms:
            if term.required:
                # Simple presence check
                if term.term_type not in data:
                    violations.append({
                        "term_id": term.term_id,
                        "term_type": term.term_type,
                        "violation": "missing_required",
                    })
        
        return violations
    
    def is_valid(self) -> bool:
        """Check if contract is currently valid."""
        if self.status != ContractStatus.ACTIVE:
            return False
        if self.expires_at and time.time() > self.expires_at:
            return False
        return True
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "contract_id": self.contract_id,
            "name": self.name,
            "contract_type": self.contract_type.value,
            "status": self.status.value,
            "provider": self.provider,
            "consumer": self.consumer,
            "terms": [t.to_dict() for t in self.terms],
            "interface_spec": self.interface_spec,
            "sla": self.sla,
            "compliance_requirements": self.compliance_requirements,
            "version": self.version,
            "previous_version_id": self.previous_version_id,
            "created_at": self.created_at,
            "activated_at": self.activated_at,
            "expires_at": self.expires_at,
            "is_valid": self.is_valid(),
        }


class ContractRegistry:
    """Registry for integration contracts."""
    
    def __init__(self) -> None:
        self._contracts: Dict[str, IntegrationContract] = {}
    
    def register(self, contract: IntegrationContract) -> None:
        """Register a contract."""
        self._contracts[contract.contract_id] = contract
    
    def get(self, contract_id: str) -> Optional[IntegrationContract]:
        """Get a contract by ID."""
        return self._contracts.get(contract_id)
    
    def find_by_parties(
        self,
        provider: Optional[str] = None,
        consumer: Optional[str] = None,
    ) -> List[IntegrationContract]:
        """Find contracts by parties."""
        contracts = list(self._contracts.values())
        
        if provider:
            contracts = [c for c in contracts if c.provider == provider]
        
        if consumer:
            contracts = [c for c in contracts if c.consumer == consumer]
        
        return contracts
    
    def get_active(self) -> List[IntegrationContract]:
        """Get all active contracts."""
        return [c for c in self._contracts.values() if c.is_valid()]
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get registry statistics."""
        contracts = list(self._contracts.values())
        
        by_type: Dict[str, int] = {}
        by_status: Dict[str, int] = {}
        
        for c in contracts:
            by_type[c.contract_type.value] = by_type.get(c.contract_type.value, 0) + 1
            by_status[c.status.value] = by_status.get(c.status.value, 0) + 1
        
        return {
            "total": len(contracts),
            "active": len(self.get_active()),
            "by_type": by_type,
            "by_status": by_status,
        }
