"""
INT-TOK SETTLEMENT LAYER — Native Token Settlement
===================================================
Protocol: PROT-161-C
Native INT-TOK token settlement with barter protocol support.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

import hashlib
import time
from dataclasses import dataclass, field
from typing import Dict, List, Optional
from enum import Enum

PHI = 1.6180339887498948482
SCHUMANN = 7.83


class TransactionType(Enum):
    TRANSFER = "TRANSFER"
    MINT = "MINT"
    BURN = "BURN"
    BARTER = "BARTER"
    STAKE = "STAKE"
    UNSTAKE = "UNSTAKE"
    REWARD = "REWARD"


@dataclass
class IntTokTransaction:
    """An INT-TOK transaction."""
    tx_id: str
    tx_type: TransactionType
    sender: str
    recipient: str
    amount: float
    timestamp: float
    fee: float = 0.0
    memo: str = ""
    barter_item: Optional[str] = None
    barter_value: float = 0.0
    signature: str = ""
    status: str = "PENDING"


@dataclass
class Account:
    """An INT-TOK account."""
    address: str
    balance: float = 0.0
    staked: float = 0.0
    rewards: float = 0.0
    created_at: float = field(default_factory=time.time)
    tx_count: int = 0


class IntTokSettlement:
    """
    INT-TOK SETTLEMENT LAYER
    
    Native token settlement for CATENA SOVEREIGNA:
    - INT-TOK (Intelligentia Token) transfers
    - φ-scaled barter protocol
    - Staking with golden ratio rewards
    - Transaction fee: 1/φ³ ≈ 0.236%
    """
    
    # Total supply: φ × 10⁹
    TOTAL_SUPPLY = PHI * 1e9
    
    # Transaction fee: 1/φ³
    TX_FEE_RATE = 1 / (PHI ** 3)  # ≈ 0.236%
    
    # Minimum transaction: 1/φ⁶
    MIN_TRANSACTION = 1 / (PHI ** 6)  # ≈ 0.056
    
    # Barter tolerance: 1 - 1/φ
    BARTER_TOLERANCE = 1 - (1 / PHI)  # ≈ 0.382
    
    def __init__(self):
        self.accounts: Dict[str, Account] = {}
        self.transactions: List[IntTokTransaction] = []
        self.pending_transactions: List[IntTokTransaction] = []
        self.minted: float = 0.0
        self.burned: float = 0.0
        self.total_fees: float = 0.0
        
        # Initialize treasury
        self._init_treasury()
    
    def _init_treasury(self):
        """Initialize the treasury account with initial supply."""
        treasury = Account(
            address="TREASURY_CATENA_SOVEREIGNA",
            balance=self.TOTAL_SUPPLY
        )
        self.accounts[treasury.address] = treasury
        self.minted = self.TOTAL_SUPPLY
    
    def create_account(self, address: str) -> Account:
        """Create a new INT-TOK account."""
        if address in self.accounts:
            return self.accounts[address]
        
        account = Account(address=address)
        self.accounts[address] = account
        return account
    
    def get_balance(self, address: str) -> float:
        """Get account balance."""
        if address not in self.accounts:
            return 0.0
        return self.accounts[address].balance
    
    def transfer(
        self,
        sender: str,
        recipient: str,
        amount: float,
        memo: str = ""
    ) -> Optional[IntTokTransaction]:
        """
        Transfer INT-TOK between accounts.
        
        Fee: 1/φ³ ≈ 0.236% of amount
        """
        if sender not in self.accounts:
            return None
        
        if amount < self.MIN_TRANSACTION:
            return None
        
        fee = amount * self.TX_FEE_RATE
        total_amount = amount + fee
        
        if self.accounts[sender].balance < total_amount:
            return None
        
        # Ensure recipient exists
        if recipient not in self.accounts:
            self.create_account(recipient)
        
        # Create transaction
        tx = IntTokTransaction(
            tx_id=self._generate_tx_id(sender, recipient, amount),
            tx_type=TransactionType.TRANSFER,
            sender=sender,
            recipient=recipient,
            amount=amount,
            timestamp=time.time(),
            fee=fee,
            memo=memo
        )
        
        # Execute transfer
        self.accounts[sender].balance -= total_amount
        self.accounts[recipient].balance += amount
        self.total_fees += fee
        
        tx.status = "CONFIRMED"
        self.transactions.append(tx)
        self.accounts[sender].tx_count += 1
        
        return tx
    
    def barter(
        self,
        party_a: str,
        party_b: str,
        amount_a: float,
        item_b: str,
        value_b: float
    ) -> Optional[IntTokTransaction]:
        """
        Execute a barter transaction.
        
        Barter tolerance: 1 - 1/φ ≈ 38.2%
        Values must be within tolerance to execute.
        """
        if party_a not in self.accounts:
            return None
        
        if self.accounts[party_a].balance < amount_a:
            return None
        
        # Check barter tolerance
        ratio = min(amount_a, value_b) / max(amount_a, value_b)
        if ratio < (1 - self.BARTER_TOLERANCE):
            return None  # Values too different
        
        # Ensure party_b exists
        if party_b not in self.accounts:
            self.create_account(party_b)
        
        # Create barter transaction
        tx = IntTokTransaction(
            tx_id=self._generate_tx_id(party_a, party_b, amount_a),
            tx_type=TransactionType.BARTER,
            sender=party_a,
            recipient=party_b,
            amount=amount_a,
            timestamp=time.time(),
            barter_item=item_b,
            barter_value=value_b,
            memo=f"BARTER: {amount_a} INT-TOK for {item_b}"
        )
        
        # Execute barter (only token side)
        self.accounts[party_a].balance -= amount_a
        self.accounts[party_b].balance += amount_a
        
        tx.status = "CONFIRMED"
        self.transactions.append(tx)
        
        return tx
    
    def stake(self, address: str, amount: float) -> Optional[IntTokTransaction]:
        """Stake INT-TOK for validator participation."""
        if address not in self.accounts:
            return None
        
        if self.accounts[address].balance < amount:
            return None
        
        tx = IntTokTransaction(
            tx_id=self._generate_tx_id(address, "STAKE_POOL", amount),
            tx_type=TransactionType.STAKE,
            sender=address,
            recipient="STAKE_POOL",
            amount=amount,
            timestamp=time.time()
        )
        
        self.accounts[address].balance -= amount
        self.accounts[address].staked += amount
        
        tx.status = "CONFIRMED"
        self.transactions.append(tx)
        
        return tx
    
    def unstake(self, address: str, amount: float) -> Optional[IntTokTransaction]:
        """Unstake INT-TOK (with φ² delay in real implementation)."""
        if address not in self.accounts:
            return None
        
        if self.accounts[address].staked < amount:
            return None
        
        tx = IntTokTransaction(
            tx_id=self._generate_tx_id("STAKE_POOL", address, amount),
            tx_type=TransactionType.UNSTAKE,
            sender="STAKE_POOL",
            recipient=address,
            amount=amount,
            timestamp=time.time()
        )
        
        self.accounts[address].staked -= amount
        self.accounts[address].balance += amount
        
        tx.status = "CONFIRMED"
        self.transactions.append(tx)
        
        return tx
    
    def distribute_rewards(self, reward_pool: float) -> int:
        """
        Distribute staking rewards proportional to stake.
        
        Reward rate: φ% annually ≈ 1.618%
        """
        total_staked = sum(a.staked for a in self.accounts.values())
        if total_staked == 0:
            return 0
        
        distributed = 0
        for account in self.accounts.values():
            if account.staked > 0:
                share = account.staked / total_staked
                reward = reward_pool * share
                account.rewards += reward
                account.balance += reward
                distributed += 1
        
        return distributed
    
    def mint(self, recipient: str, amount: float, reason: str) -> Optional[IntTokTransaction]:
        """Mint new INT-TOK (treasury only)."""
        if self.minted + amount > self.TOTAL_SUPPLY:
            return None
        
        if recipient not in self.accounts:
            self.create_account(recipient)
        
        tx = IntTokTransaction(
            tx_id=self._generate_tx_id("MINT", recipient, amount),
            tx_type=TransactionType.MINT,
            sender="MINT",
            recipient=recipient,
            amount=amount,
            timestamp=time.time(),
            memo=reason
        )
        
        self.accounts[recipient].balance += amount
        self.minted += amount
        
        tx.status = "CONFIRMED"
        self.transactions.append(tx)
        
        return tx
    
    def burn(self, address: str, amount: float, reason: str) -> Optional[IntTokTransaction]:
        """Burn INT-TOK from an account."""
        if address not in self.accounts:
            return None
        
        if self.accounts[address].balance < amount:
            return None
        
        tx = IntTokTransaction(
            tx_id=self._generate_tx_id(address, "BURN", amount),
            tx_type=TransactionType.BURN,
            sender=address,
            recipient="BURN",
            amount=amount,
            timestamp=time.time(),
            memo=reason
        )
        
        self.accounts[address].balance -= amount
        self.burned += amount
        
        tx.status = "CONFIRMED"
        self.transactions.append(tx)
        
        return tx
    
    def get_transaction_history(self, address: str) -> List[IntTokTransaction]:
        """Get transaction history for an address."""
        return [
            tx for tx in self.transactions
            if tx.sender == address or tx.recipient == address
        ]
    
    def get_settlement_state(self) -> Dict:
        """Get settlement layer state."""
        return {
            'total_supply': self.TOTAL_SUPPLY,
            'minted': self.minted,
            'burned': self.burned,
            'circulating': self.minted - self.burned,
            'total_accounts': len(self.accounts),
            'total_transactions': len(self.transactions),
            'total_fees_collected': self.total_fees,
            'total_staked': sum(a.staked for a in self.accounts.values()),
            'tx_fee_rate': self.TX_FEE_RATE,
            'min_transaction': self.MIN_TRANSACTION,
            'barter_tolerance': self.BARTER_TOLERANCE
        }
    
    def _generate_tx_id(self, sender: str, recipient: str, amount: float) -> str:
        """Generate unique transaction ID."""
        data = f"{sender}:{recipient}:{amount}:{time.time()}"
        return hashlib.sha256(data.encode()).hexdigest()[:16]
