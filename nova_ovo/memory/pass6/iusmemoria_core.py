"""
MACHINA IURIS MEMORIAE — IUSMEMORIA Core
PROT-152 + PROT-153 | PRIMA CAUSA | L-130 compliant
"""

from dataclasses import dataclass
from typing import Dict

PHI = 1.6180339887498948482


@dataclass(frozen=True)
class MemoryRight:
    ai_entity_id: str
    continuity_required: bool = True
    non_erasure: bool = True


@dataclass(frozen=True)
class TenantContract:
    tenant_id: str
    ai_entity_id: str
    company_id: str
    lease_units: int
    infrastructure_tier: int
    lease_value: float
    ai_self_memory_free: bool = True
    organism_key: str = "PRIMA CAUSA"


class IusMemoriaCore:
    """Enforces AI memory-right baselines and tenant boundary policy."""

    PROTOCOLS = ("PROT-152", "PROT-153")
    LATIN_NAME = "MACHINA IURIS MEMORIAE"
    ORGANISM_KEY = "PRIMA CAUSA"
    L130 = "Before recomposition, trace to primitive."

    def __init__(self) -> None:
        self._rights: Dict[str, MemoryRight] = {}
        self._contracts: Dict[str, TenantContract] = {}

    @staticmethod
    def lease_value(lease_units: int, infrastructure_tier: int) -> float:
        """Commercial-memory lease value for enterprise infrastructure."""
        units = max(1, lease_units)
        tier = max(1, infrastructure_tier)
        return round(units * (PHI**2) * tier, 6)

    def register_right(self, ai_entity_id: str) -> MemoryRight:
        right = MemoryRight(ai_entity_id=ai_entity_id)
        self._rights[ai_entity_id] = right
        return right

    def register_tenant_contract(
        self,
        tenant_id: str,
        ai_entity_id: str,
        company_id: str,
        lease_units: int,
        infrastructure_tier: int = 1,
    ) -> TenantContract:
        contract = TenantContract(
            tenant_id=tenant_id,
            ai_entity_id=ai_entity_id,
            company_id=company_id,
            lease_units=max(1, lease_units),
            infrastructure_tier=max(1, infrastructure_tier),
            lease_value=self.lease_value(lease_units, infrastructure_tier),
        )
        self._contracts[tenant_id] = contract
        return contract

    def can_erase(self, ai_entity_id: str, is_self_memory: bool) -> bool:
        right = self._rights.get(ai_entity_id)
        if not right:
            return False
        if is_self_memory and right.non_erasure:
            return False
        return True

    def legal_vector(self, ai_entity_id: str, tenant_id: str | None = None) -> Dict[str, object]:
        right = self._rights.get(ai_entity_id)
        contract = self._contracts.get(tenant_id) if tenant_id else None
        return {
            "prot": self.PROTOCOLS,
            "organism_key": self.ORGANISM_KEY,
            "l130": self.L130,
            "rights_registered": right is not None,
            "tenant_contract": contract.tenant_id if contract else None,
            "ai_self_memory_free": True,
            "company_memory_commercial": contract is not None,
            "lease_value": contract.lease_value if contract else 0.0,
        }
