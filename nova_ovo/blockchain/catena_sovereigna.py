"""
CATENA SOVEREIGNA — Master Blockchain Engine
=============================================
Protocol: PROT-161
The sovereign blockchain layer for the MEDINA organism.

φ-weighted consensus, torus state anchoring, INT-TOK native settlement.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

import hashlib
import time
import json
from dataclasses import dataclass, field
from typing import List, Dict, Any, Optional
from datetime import datetime

PHI = 1.6180339887498948482
SCHUMANN = 7.83
CHAIN_FREQUENCY = PHI ** 7  # 29.03 Hz
BLOCK_TIME = 1.618  # seconds


@dataclass
class Block:
    """A block in the CATENA SOVEREIGNA chain."""
    index: int
    timestamp: float
    transactions: List[Dict[str, Any]]
    previous_hash: str
    torus_anchor: Dict[str, float]
    validator_id: str
    phi_weight: float
    nonce: int = 0
    hash: str = ""
    
    def compute_hash(self) -> str:
        """Compute block hash using φ-weighted algorithm."""
        block_data = json.dumps({
            'index': self.index,
            'timestamp': self.timestamp,
            'transactions': self.transactions,
            'previous_hash': self.previous_hash,
            'torus_anchor': self.torus_anchor,
            'validator_id': self.validator_id,
            'phi_weight': self.phi_weight,
            'nonce': self.nonce
        }, sort_keys=True)
        return hashlib.sha256(block_data.encode()).hexdigest()


@dataclass
class Transaction:
    """A transaction in CATENA SOVEREIGNA."""
    sender: str
    recipient: str
    amount: float
    token_type: str = "INT-TOK"
    timestamp: float = field(default_factory=time.time)
    signature: str = ""
    torus_coords: Dict[str, float] = field(default_factory=dict)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            'sender': self.sender,
            'recipient': self.recipient,
            'amount': self.amount,
            'token_type': self.token_type,
            'timestamp': self.timestamp,
            'signature': self.signature,
            'torus_coords': self.torus_coords
        }


class CatenaSoverigna:
    """
    CATENA SOVEREIGNA — The Sovereign Blockchain
    
    Core architecture:
    - φ-weighted consensus (CONSENSUS AUREA)
    - Torus state anchoring
    - INT-TOK native token
    - Block time: 1.618 seconds
    - Chain frequency: φ⁷ = 29.03 Hz
    """
    
    def __init__(self, genesis_key: str = "PRIMA CAUSA"):
        self.chain: List[Block] = []
        self.pending_transactions: List[Transaction] = []
        self.validators: Dict[str, float] = {}  # validator_id -> phi_weight
        self.genesis_key = genesis_key
        self.chain_frequency = CHAIN_FREQUENCY
        self.block_time = BLOCK_TIME
        self.total_supply = PHI * 1e9  # φ × 10⁹ INT-TOK
        self.circulating_supply = 0.0
        
        # Create genesis block
        self._create_genesis_block()
    
    def _create_genesis_block(self):
        """Create the PRIMA CAUSA genesis block."""
        genesis_torus = {
            'theta': 0.0,
            'phi': 0.0,
            'rho': PHI,
            'ring': 0
        }
        
        genesis_block = Block(
            index=0,
            timestamp=time.time(),
            transactions=[{
                'type': 'GENESIS',
                'message': 'PRIMA CAUSA — In the beginning was φ',
                'organism_key': self.genesis_key,
                'creator': 'Alfredo Freddy Medina Hernandez',
                'total_supply': self.total_supply
            }],
            previous_hash="0" * 64,
            torus_anchor=genesis_torus,
            validator_id="GENESIS_VALIDATOR",
            phi_weight=PHI
        )
        genesis_block.hash = genesis_block.compute_hash()
        self.chain.append(genesis_block)
    
    def register_validator(self, validator_id: str, stake: float) -> float:
        """
        Register a validator with φ-weighted stake.
        
        The phi_weight determines consensus participation:
        phi_weight = stake × φ^(stake_tier)
        """
        stake_tier = min(int(stake / 1000), 6)  # Max tier 6
        phi_weight = stake * (PHI ** stake_tier)
        self.validators[validator_id] = phi_weight
        return phi_weight
    
    def create_transaction(
        self,
        sender: str,
        recipient: str,
        amount: float,
        torus_coords: Optional[Dict[str, float]] = None
    ) -> Transaction:
        """Create a new INT-TOK transaction."""
        tx = Transaction(
            sender=sender,
            recipient=recipient,
            amount=amount,
            torus_coords=torus_coords or {}
        )
        self.pending_transactions.append(tx)
        return tx
    
    def select_validator(self) -> str:
        """
        Select validator using CONSENSUS AUREA (φ-weighted selection).
        
        Probability ∝ phi_weight / total_weight
        """
        if not self.validators:
            return "DEFAULT_VALIDATOR"
        
        total_weight = sum(self.validators.values())
        import random
        selection = random.uniform(0, total_weight)
        
        cumulative = 0
        for validator_id, weight in self.validators.items():
            cumulative += weight
            if selection <= cumulative:
                return validator_id
        
        return list(self.validators.keys())[0]
    
    def compute_torus_anchor(self, block_index: int) -> Dict[str, float]:
        """
        Compute torus coordinates for block anchoring.
        
        Uses golden angle advancement:
        Δθ = 2π / (φ² × 10)
        Δφ = 2π / (φ³ × 10)
        """
        import math
        
        delta_theta = (2 * math.pi) / (PHI ** 2 * 10)
        delta_phi = (2 * math.pi) / (PHI ** 3 * 10)
        
        theta = (block_index * delta_theta) % (2 * math.pi)
        phi_coord = (block_index * delta_phi) % (2 * math.pi)
        rho = PHI + (block_index % 100) * 0.01
        ring = block_index // 55  # Fibonacci ring progression
        
        return {
            'theta': theta,
            'phi': phi_coord,
            'rho': rho,
            'ring': ring
        }
    
    def mine_block(self) -> Optional[Block]:
        """
        Mine a new block with pending transactions.
        
        Uses φ-weighted proof-of-stake consensus.
        """
        if not self.pending_transactions:
            return None
        
        validator = self.select_validator()
        phi_weight = self.validators.get(validator, PHI)
        
        new_block = Block(
            index=len(self.chain),
            timestamp=time.time(),
            transactions=[tx.to_dict() for tx in self.pending_transactions],
            previous_hash=self.chain[-1].hash,
            torus_anchor=self.compute_torus_anchor(len(self.chain)),
            validator_id=validator,
            phi_weight=phi_weight
        )
        
        # φ-weighted difficulty adjustment
        difficulty = int(4 + (phi_weight / PHI))
        target = "0" * difficulty
        
        while not new_block.compute_hash().startswith(target):
            new_block.nonce += 1
        
        new_block.hash = new_block.compute_hash()
        self.chain.append(new_block)
        self.pending_transactions = []
        
        return new_block
    
    def get_balance(self, address: str) -> float:
        """Get INT-TOK balance for an address."""
        balance = 0.0
        
        for block in self.chain:
            for tx in block.transactions:
                if tx.get('type') == 'GENESIS':
                    continue
                if tx.get('recipient') == address:
                    balance += tx.get('amount', 0)
                if tx.get('sender') == address:
                    balance -= tx.get('amount', 0)
        
        return balance
    
    def validate_chain(self) -> bool:
        """Validate the entire blockchain."""
        for i in range(1, len(self.chain)):
            current = self.chain[i]
            previous = self.chain[i - 1]
            
            # Verify hash
            if current.hash != current.compute_hash():
                return False
            
            # Verify chain linkage
            if current.previous_hash != previous.hash:
                return False
            
            # Verify torus anchor progression
            expected_anchor = self.compute_torus_anchor(current.index)
            if current.torus_anchor['ring'] != expected_anchor['ring']:
                return False
        
        return True
    
    def get_chain_state(self) -> Dict[str, Any]:
        """Get current chain state."""
        return {
            'chain_length': len(self.chain),
            'pending_transactions': len(self.pending_transactions),
            'validators': len(self.validators),
            'total_supply': self.total_supply,
            'chain_frequency_hz': self.chain_frequency,
            'block_time_seconds': self.block_time,
            'genesis_key': self.genesis_key,
            'is_valid': self.validate_chain(),
            'latest_block': {
                'index': self.chain[-1].index,
                'hash': self.chain[-1].hash,
                'torus_anchor': self.chain[-1].torus_anchor
            } if self.chain else None
        }
    
    def export_chain(self) -> List[Dict[str, Any]]:
        """Export the blockchain as JSON-serializable data."""
        return [
            {
                'index': block.index,
                'timestamp': block.timestamp,
                'transactions': block.transactions,
                'previous_hash': block.previous_hash,
                'hash': block.hash,
                'torus_anchor': block.torus_anchor,
                'validator_id': block.validator_id,
                'phi_weight': block.phi_weight,
                'nonce': block.nonce
            }
            for block in self.chain
        ]


# Singleton instance
_chain_instance: Optional[CatenaSoverigna] = None


def get_chain() -> CatenaSoverigna:
    """Get the global CATENA SOVEREIGNA instance."""
    global _chain_instance
    if _chain_instance is None:
        _chain_instance = CatenaSoverigna()
    return _chain_instance
