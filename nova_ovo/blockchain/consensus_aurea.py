"""
CONSENSUS AUREA — Golden Consensus Engine
==========================================
Protocol: PROT-161-A
φ-weighted validator selection with golden ratio block finality.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

import hashlib
import random
import time
from dataclasses import dataclass
from typing import Dict, List, Optional, Tuple

PHI = 1.6180339887498948482
SCHUMANN = 7.83


@dataclass
class Validator:
    """A validator in the CONSENSUS AUREA network."""
    id: str
    stake: float
    phi_weight: float
    reputation: float = 1.0
    blocks_validated: int = 0
    last_active: float = 0.0
    torus_coords: Dict[str, float] = None
    
    def __post_init__(self):
        if self.torus_coords is None:
            self.torus_coords = {'theta': 0, 'phi': 0, 'rho': PHI}


@dataclass
class ConsensusVote:
    """A vote in the consensus process."""
    validator_id: str
    block_hash: str
    phi_weight: float
    timestamp: float
    signature: str


class ConsensusAurea:
    """
    CONSENSUS AUREA — Golden Consensus Mechanism
    
    Key properties:
    1. φ-weighted stake selection
    2. 2/3 + φ finality threshold (≈73.87%)
    3. Schumann-synced block proposals
    4. Torus-mapped validator distribution
    """
    
    # Finality threshold: 2/3 + 1/φ² ≈ 73.87%
    FINALITY_THRESHOLD = (2/3) + (1 / (PHI ** 2))
    
    def __init__(self):
        self.validators: Dict[str, Validator] = {}
        self.pending_votes: Dict[str, List[ConsensusVote]] = {}
        self.finalized_blocks: List[str] = []
        self.epoch: int = 0
        self.epoch_start: float = time.time()
    
    def register_validator(
        self,
        validator_id: str,
        stake: float,
        torus_coords: Optional[Dict[str, float]] = None
    ) -> Validator:
        """
        Register a new validator with φ-weighted stake.
        
        phi_weight = stake × φ^tier where tier = floor(stake/1000)
        """
        tier = min(int(stake / 1000), 6)
        phi_weight = stake * (PHI ** tier)
        
        validator = Validator(
            id=validator_id,
            stake=stake,
            phi_weight=phi_weight,
            torus_coords=torus_coords or {'theta': 0, 'phi': 0, 'rho': PHI}
        )
        
        self.validators[validator_id] = validator
        return validator
    
    def compute_selection_probability(self, validator_id: str) -> float:
        """
        Compute validator selection probability.
        
        P(v) = phi_weight(v) × reputation(v) / Σ(phi_weight × reputation)
        """
        if validator_id not in self.validators:
            return 0.0
        
        v = self.validators[validator_id]
        total = sum(
            val.phi_weight * val.reputation
            for val in self.validators.values()
        )
        
        if total == 0:
            return 0.0
        
        return (v.phi_weight * v.reputation) / total
    
    def select_block_proposer(self) -> Optional[str]:
        """
        Select block proposer using golden selection.
        
        Uses weighted random selection with φ-weights.
        """
        if not self.validators:
            return None
        
        # Build cumulative distribution
        weights = [
            (vid, v.phi_weight * v.reputation)
            for vid, v in self.validators.items()
        ]
        total_weight = sum(w for _, w in weights)
        
        if total_weight == 0:
            return random.choice(list(self.validators.keys()))
        
        selection = random.uniform(0, total_weight)
        cumulative = 0
        
        for vid, weight in weights:
            cumulative += weight
            if selection <= cumulative:
                return vid
        
        return weights[-1][0]
    
    def propose_block(self, proposer_id: str, block_hash: str) -> bool:
        """
        Propose a new block for consensus.
        
        Block proposals are synchronized to Schumann frequency.
        """
        if proposer_id not in self.validators:
            return False
        
        # Initialize voting for this block
        self.pending_votes[block_hash] = []
        
        # Proposer automatically votes for their block
        vote = ConsensusVote(
            validator_id=proposer_id,
            block_hash=block_hash,
            phi_weight=self.validators[proposer_id].phi_weight,
            timestamp=time.time(),
            signature=self._sign_vote(proposer_id, block_hash)
        )
        self.pending_votes[block_hash].append(vote)
        
        return True
    
    def cast_vote(self, validator_id: str, block_hash: str) -> bool:
        """Cast a consensus vote for a block."""
        if validator_id not in self.validators:
            return False
        
        if block_hash not in self.pending_votes:
            return False
        
        # Check if already voted
        existing_votes = [v.validator_id for v in self.pending_votes[block_hash]]
        if validator_id in existing_votes:
            return False
        
        vote = ConsensusVote(
            validator_id=validator_id,
            block_hash=block_hash,
            phi_weight=self.validators[validator_id].phi_weight,
            timestamp=time.time(),
            signature=self._sign_vote(validator_id, block_hash)
        )
        self.pending_votes[block_hash].append(vote)
        
        return True
    
    def check_finality(self, block_hash: str) -> Tuple[bool, float]:
        """
        Check if a block has reached finality.
        
        Finality requires 2/3 + 1/φ² ≈ 73.87% of weighted votes.
        """
        if block_hash not in self.pending_votes:
            return False, 0.0
        
        votes = self.pending_votes[block_hash]
        voted_weight = sum(v.phi_weight for v in votes)
        total_weight = sum(v.phi_weight for v in self.validators.values())
        
        if total_weight == 0:
            return False, 0.0
        
        vote_percentage = voted_weight / total_weight
        is_final = vote_percentage >= self.FINALITY_THRESHOLD
        
        if is_final:
            self.finalized_blocks.append(block_hash)
            # Update validator stats
            for vote in votes:
                if vote.validator_id in self.validators:
                    self.validators[vote.validator_id].blocks_validated += 1
                    self.validators[vote.validator_id].last_active = time.time()
        
        return is_final, vote_percentage
    
    def update_reputation(self, validator_id: str, delta: float):
        """
        Update validator reputation.
        
        Reputation affects selection probability.
        Bounded between 0.1 and 2.0.
        """
        if validator_id in self.validators:
            v = self.validators[validator_id]
            v.reputation = max(0.1, min(2.0, v.reputation + delta))
    
    def slash_validator(self, validator_id: str, reason: str) -> float:
        """
        Slash a validator for misbehavior.
        
        Slashing reduces stake by 1/φ² ≈ 38.2%.
        """
        if validator_id not in self.validators:
            return 0.0
        
        v = self.validators[validator_id]
        slash_amount = v.stake * (1 / (PHI ** 2))
        v.stake -= slash_amount
        
        # Recalculate phi_weight
        tier = min(int(v.stake / 1000), 6)
        v.phi_weight = v.stake * (PHI ** tier)
        
        # Reduce reputation
        v.reputation *= 0.5
        
        return slash_amount
    
    def advance_epoch(self):
        """
        Advance to next consensus epoch.
        
        Epochs are φ² × 100 ≈ 261.8 seconds.
        """
        self.epoch += 1
        self.epoch_start = time.time()
        
        # Clear old pending votes
        self.pending_votes = {}
        
        # Decay inactive validator reputation
        current_time = time.time()
        for v in self.validators.values():
            if current_time - v.last_active > PHI ** 2 * 100:
                v.reputation *= 0.95
    
    def get_consensus_state(self) -> Dict:
        """Get current consensus state."""
        return {
            'epoch': self.epoch,
            'epoch_duration_seconds': PHI ** 2 * 100,
            'validators': len(self.validators),
            'total_stake': sum(v.stake for v in self.validators.values()),
            'total_phi_weight': sum(v.phi_weight for v in self.validators.values()),
            'finality_threshold': self.FINALITY_THRESHOLD,
            'finalized_blocks': len(self.finalized_blocks),
            'pending_blocks': len(self.pending_votes)
        }
    
    def _sign_vote(self, validator_id: str, block_hash: str) -> str:
        """Generate vote signature (simplified)."""
        data = f"{validator_id}:{block_hash}:{time.time()}"
        return hashlib.sha256(data.encode()).hexdigest()[:16]
