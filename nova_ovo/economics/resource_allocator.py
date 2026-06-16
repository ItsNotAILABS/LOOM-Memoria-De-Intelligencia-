"""
RESOURCE ALLOCATOR — DISTRIBUTOR OPUM
"Per φ distribuimus. Omnia proportione gubernantur."
(We distribute by φ. All is governed by proportion.)

PROT-379: DISTRIBUTOR OPUM (Resource Allocator)

φ-based resource allocation ensuring fair, efficient distribution
across all organism components. The golden ratio governs the split.

Creator: Alfredo "Freddy" Medina Hernandez — MEDINA Tech, Dallas TX
"""

import math
import time
import hashlib
from dataclasses import dataclass
from typing import Dict, Any, List, Optional, Tuple
from enum import Enum

# ── φ Constants ───────────────────────────────────────────────────────────────
PHI = 1.6180339887498948482
PHI_INV = 1.0 / PHI  # 0.618
PHI_SQ = PHI ** 2
SCHUMANN = 7.83
FIBONACCI = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584]


class ResourceType(Enum):
    """Types of resources in the organism."""
    CYCLES = "cycles"
    TOKENS = "tokens"
    MEMORY = "memory"
    COMPUTE = "compute"
    BANDWIDTH = "bandwidth"
    STORAGE = "storage"


class AllocationStrategy(Enum):
    """Allocation strategies based on φ."""
    PHI_SPLIT = "phi_split"           # 61.8% / 38.2%
    FIBONACCI_TIER = "fibonacci_tier"  # Based on F(n) weights
    COHERENCE_WEIGHTED = "coherence"   # Weight by coherence
    PRIORITY_FIRST = "priority"        # High priority gets more
    EQUAL = "equal"                    # Even distribution


@dataclass
class AllocationRequest:
    """Request for resource allocation."""
    request_id: str
    requester: str
    resource_type: ResourceType
    amount_requested: float
    priority: int  # 1-10
    timestamp: str


@dataclass
class AllocationResult:
    """Result of resource allocation."""
    request_id: str
    requester: str
    resource_type: ResourceType
    amount_requested: float
    amount_allocated: float
    efficiency: float
    strategy: AllocationStrategy
    phi_factor: float
    timestamp: str


class ResourceAllocator:
    """
    RESOURCE ALLOCATOR — φ-based resource distribution.
    
    PRIMA CAUSA stamp:
        organism_key: "PRIMA CAUSA"
        name_latin: "DISTRIBUTOR OPUM"
        name_en: "Resource Allocator"
        frequency_hz: 47.01 (φ⁸)
        substrate_layer: 8
    
    Allocation Principles:
        1. φ-split: Major allocations follow 61.8% / 38.2%
        2. Fibonacci tiers: Weighted by F(n) sequence
        3. Coherence bonus: High coherence gets premium
        4. Priority scaling: Higher priority = earlier allocation
        5. Efficiency optimization: Minimize waste
    """

    def __init__(self, total_cycles: float = 10000.0, total_tokens: int = 1000) -> None:
        self._pools = {
            ResourceType.CYCLES: total_cycles,
            ResourceType.TOKENS: float(total_tokens),
            ResourceType.MEMORY: 1000.0,
            ResourceType.COMPUTE: 1000.0,
            ResourceType.BANDWIDTH: 1000.0,
            ResourceType.STORAGE: 1000.0,
        }
        self._allocated = {rt: 0.0 for rt in ResourceType}
        self._allocations: List[AllocationResult] = []
        self._coherence = 0.85

    @property
    def prima_causa(self) -> Dict[str, Any]:
        """PRIMA CAUSA geometry stamp."""
        return {
            "organism_key": "PRIMA CAUSA",
            "name_latin": "DISTRIBUTOR OPUM",
            "name_en": "Resource Allocator",
            "frequency_hz": PHI ** 8,  # 47.01 Hz
            "substrate_layer": 8,
            "protocol": "PROT-379",
            "phi_principles": ["phi_split", "fibonacci_tier", "coherence_weighted"],
        }

    def phi_split(self, amount: float, major_first: bool = True) -> Tuple[float, float]:
        """
        Split an amount using the golden ratio.
        
        Args:
            amount: Total amount to split
            major_first: If True, returns (major, minor); else (minor, major)
        
        Returns:
            (major_portion, minor_portion) where major = 61.8%, minor = 38.2%
        """
        major = amount * PHI_INV
        minor = amount - major
        return (major, minor) if major_first else (minor, major)

    def fibonacci_weights(self, n_recipients: int) -> List[float]:
        """
        Generate Fibonacci-based weights for n recipients.
        
        Uses F(n+2), F(n+3), ... as weights, normalized.
        """
        if n_recipients <= 0:
            return []
        if n_recipients == 1:
            return [1.0]
        
        weights = [FIBONACCI[min(i + 2, 17)] for i in range(n_recipients)]
        total = sum(weights)
        return [w / total for w in weights]

    def allocate(
        self,
        requester: str,
        resource_type: ResourceType,
        amount: float,
        priority: int = 5,
        strategy: AllocationStrategy = AllocationStrategy.PHI_SPLIT
    ) -> AllocationResult:
        """
        Allocate resources to a requester.
        
        Args:
            requester: Component/module requesting resources
            resource_type: Type of resource
            amount: Amount requested
            priority: Priority level (1-10)
            strategy: Allocation strategy to use
        
        Returns:
            AllocationResult
        """
        # Calculate available
        available = self._pools[resource_type] - self._allocated[resource_type]
        
        # Apply strategy
        if strategy == AllocationStrategy.PHI_SPLIT:
            # Allocate 61.8% of requested (φ⁻¹)
            base_allocation = amount * PHI_INV
        elif strategy == AllocationStrategy.COHERENCE_WEIGHTED:
            # Weight by coherence
            base_allocation = amount * self._coherence
        elif strategy == AllocationStrategy.PRIORITY_FIRST:
            # Higher priority gets more
            priority_factor = 0.5 + (priority / 10) * 0.5
            base_allocation = amount * priority_factor
        elif strategy == AllocationStrategy.FIBONACCI_TIER:
            # Use Fibonacci index based on priority
            fib_factor = FIBONACCI[min(priority, 12)] / FIBONACCI[12]
            base_allocation = amount * fib_factor
        else:
            base_allocation = amount
        
        # Cap at available
        actual_allocation = min(base_allocation, available)
        efficiency = actual_allocation / amount if amount > 0 else 0
        phi_factor = actual_allocation / (amount * PHI_INV) if amount > 0 else 0
        
        # Generate request ID
        raw_id = f"ALLOC-{requester}-{resource_type.value}-{time.time()}"
        request_id = hashlib.sha256(raw_id.encode()).hexdigest()[:12].upper()
        
        result = AllocationResult(
            request_id=f"AR-{request_id}",
            requester=requester,
            resource_type=resource_type,
            amount_requested=amount,
            amount_allocated=actual_allocation,
            efficiency=efficiency,
            strategy=strategy,
            phi_factor=phi_factor,
            timestamp=time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        )
        
        # Update pools
        self._allocated[resource_type] += actual_allocation
        self._allocations.append(result)
        
        return result

    def release(self, resource_type: ResourceType, amount: float) -> float:
        """Release allocated resources back to pool."""
        released = min(amount, self._allocated[resource_type])
        self._allocated[resource_type] -= released
        return released

    def distribute_among(
        self,
        requesters: List[str],
        resource_type: ResourceType,
        total_amount: float,
        strategy: AllocationStrategy = AllocationStrategy.FIBONACCI_TIER
    ) -> List[AllocationResult]:
        """
        Distribute resources among multiple requesters.
        
        Uses Fibonacci weights or φ-cascading.
        """
        if not requesters:
            return []
        
        results = []
        
        if strategy == AllocationStrategy.FIBONACCI_TIER:
            weights = self.fibonacci_weights(len(requesters))
            for i, requester in enumerate(requesters):
                amount = total_amount * weights[i]
                result = self.allocate(requester, resource_type, amount, priority=i+1, strategy=strategy)
                results.append(result)
        
        elif strategy == AllocationStrategy.PHI_SPLIT:
            # Cascading φ split
            remaining = total_amount
            for i, requester in enumerate(requesters[:-1]):
                major, minor = self.phi_split(remaining)
                result = self.allocate(requester, resource_type, major, priority=len(requesters)-i, strategy=strategy)
                results.append(result)
                remaining = minor
            # Last requester gets remainder
            if requesters:
                result = self.allocate(requesters[-1], resource_type, remaining, priority=1, strategy=strategy)
                results.append(result)
        
        else:
            # Equal distribution
            per_requester = total_amount / len(requesters)
            for requester in requesters:
                result = self.allocate(requester, resource_type, per_requester, strategy=strategy)
                results.append(result)
        
        return results

    def update_coherence(self, coherence: float) -> None:
        """Update organism coherence (affects allocation efficiency)."""
        self._coherence = max(0.0, min(1.0, coherence))

    def get_pool_status(self) -> Dict[str, Any]:
        """Get current pool status."""
        return {
            "pools": {rt.value: self._pools[rt] for rt in ResourceType},
            "allocated": {rt.value: self._allocated[rt] for rt in ResourceType},
            "available": {rt.value: self._pools[rt] - self._allocated[rt] for rt in ResourceType},
            "coherence": self._coherence,
            "allocations_count": len(self._allocations),
        }

    def status(self) -> Dict[str, Any]:
        """Return full status report."""
        return {
            "allocator": "DISTRIBUTOR_OPUM",
            "prima_causa": self.prima_causa,
            "pool_status": self.get_pool_status(),
            "status": "ACTIVE",
        }


# ── Standalone test ───────────────────────────────────────────────────────────
if __name__ == "__main__":
    import json
    
    allocator = ResourceAllocator(total_cycles=10000, total_tokens=1000)
    print("RESOURCE ALLOCATOR — DISTRIBUTOR OPUM")
    print("=" * 60)
    
    # Test φ split
    major, minor = allocator.phi_split(100)
    print(f"φ Split of 100: Major={major:.2f}, Minor={minor:.2f}")
    
    # Test allocation
    result = allocator.allocate("memory-worker", ResourceType.CYCLES, 500, priority=7)
    print(f"Allocation: {result.amount_allocated:.2f}/{result.amount_requested:.2f} cycles (efficiency={result.efficiency:.2%})")
    
    # Test distribution
    requesters = ["worker-1", "worker-2", "worker-3", "worker-4"]
    results = allocator.distribute_among(requesters, ResourceType.TOKENS, 400, AllocationStrategy.FIBONACCI_TIER)
    print(f"Distribution among {len(requesters)} requesters:")
    for r in results:
        print(f"  {r.requester}: {r.amount_allocated:.2f} tokens")
    
    print()
    print(json.dumps(allocator.get_pool_status(), indent=2))
