"""
MARKET ENGINE — MOTOR MERCATUS
"Mercatus internus organismi. Omnia commercia per φ."
(Internal market of the organism. All commerce through φ.)

PROT-380: MOTOR MERCATUS (Market Engine)

Internal market dynamics for the organism — enables exchange
between components using INT-TOK pricing and φ-based matching.

Creator: Alfredo "Freddy" Medina Hernandez — MEDINA Tech, Dallas TX
"""

import math
import time
import hashlib
from dataclasses import dataclass, field
from typing import Dict, Any, List, Optional, Tuple
from enum import Enum

# ── φ Constants ───────────────────────────────────────────────────────────────
PHI = 1.6180339887498948482
PHI_INV = 1.0 / PHI
PHI_SQ = PHI ** 2
SCHUMANN = 7.83
FIBONACCI = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584]

# Barter tolerance (±38.2% = 1 - 1/φ)
BARTER_TOLERANCE = 1 - PHI_INV  # 0.382


class OrderType(Enum):
    """Types of market orders."""
    BID = "bid"      # Want to buy
    ASK = "ask"      # Want to sell
    SWAP = "swap"    # Exchange one for another


class AssetType(Enum):
    """Types of assets tradeable in the internal market."""
    INT_TOK = "INT-TOK"          # Intelligence token
    CYCLES = "cycles"            # Computation cycles
    MEMORY = "memory"            # Memory allocation
    COMPUTE = "compute"          # Compute time
    BANDWIDTH = "bandwidth"      # Data transfer
    CONTEXT = "context"          # Context window slots
    INFERENCE = "inference"      # Inference credits


@dataclass
class MarketOrder:
    """An order in the internal market."""
    order_id: str
    order_type: OrderType
    participant: str
    asset_type: AssetType
    quantity: float
    price: float  # In INT-TOK
    timestamp: str
    status: str = "open"
    filled_quantity: float = 0.0


@dataclass
class Trade:
    """A completed trade."""
    trade_id: str
    buyer: str
    seller: str
    asset_type: AssetType
    quantity: float
    price: float
    total_value: float
    phi_efficiency: float
    timestamp: str


class MarketEngine:
    """
    MARKET ENGINE — Internal market dynamics.
    
    PRIMA CAUSA stamp:
        organism_key: "PRIMA CAUSA"
        name_latin: "MOTOR MERCATUS"
        name_en: "Market Engine"
        frequency_hz: 29.03 (φ⁷)
        substrate_layer: 7
    
    Market Principles:
        1. All trades denominated in INT-TOK
        2. Price discovery through φ-convergence
        3. Barter tolerance: ±38.2% (1 - 1/φ)
        4. Matching uses coherence-weighted scoring
        5. Liquidity maintained through φ market making
    """

    def __init__(self) -> None:
        self._orders: Dict[str, MarketOrder] = {}
        self._trades: List[Trade] = []
        self._prices: Dict[AssetType, float] = {
            AssetType.INT_TOK: 1.0,
            AssetType.CYCLES: 0.001,     # 1000 cycles = 1 INT-TOK
            AssetType.MEMORY: 0.01,       # 100 memory = 1 INT-TOK
            AssetType.COMPUTE: 0.005,     # 200 compute = 1 INT-TOK
            AssetType.BANDWIDTH: 0.002,   # 500 bandwidth = 1 INT-TOK
            AssetType.CONTEXT: 0.1,       # 10 context = 1 INT-TOK
            AssetType.INFERENCE: 0.05,    # 20 inference = 1 INT-TOK
        }
        self._coherence = 0.85
        self._trade_count = 0

    @property
    def prima_causa(self) -> Dict[str, Any]:
        """PRIMA CAUSA geometry stamp."""
        return {
            "organism_key": "PRIMA CAUSA",
            "name_latin": "MOTOR MERCATUS",
            "name_en": "Market Engine",
            "frequency_hz": PHI ** 7,  # 29.03 Hz
            "substrate_layer": 7,
            "protocol": "PROT-380",
            "barter_tolerance": BARTER_TOLERANCE,
        }

    def get_price(self, asset_type: AssetType) -> float:
        """Get current price for an asset type in INT-TOK."""
        return self._prices.get(asset_type, 1.0)

    def set_price(self, asset_type: AssetType, price: float) -> None:
        """Set price for an asset type."""
        self._prices[asset_type] = max(0.0001, price)

    def phi_price_discovery(self, bids: List[float], asks: List[float]) -> float:
        """
        Discover price using φ-convergence.
        
        The equilibrium price converges to the φ-weighted mean
        of highest bid and lowest ask.
        """
        if not bids or not asks:
            return 1.0
        
        highest_bid = max(bids)
        lowest_ask = min(asks)
        
        if highest_bid >= lowest_ask:
            # Overlap — use φ-weighted midpoint
            return (PHI_INV * highest_bid) + ((1 - PHI_INV) * lowest_ask)
        else:
            # Gap — use midpoint
            return (highest_bid + lowest_ask) / 2

    def submit_order(
        self,
        participant: str,
        order_type: OrderType,
        asset_type: AssetType,
        quantity: float,
        price: Optional[float] = None
    ) -> MarketOrder:
        """
        Submit an order to the market.
        
        If price not specified, uses current market price.
        """
        if price is None:
            price = self.get_price(asset_type)
        
        # Generate order ID
        raw_id = f"ORD-{participant}-{order_type.value}-{time.time()}"
        order_id = hashlib.sha256(raw_id.encode()).hexdigest()[:12].upper()
        
        order = MarketOrder(
            order_id=f"MO-{order_id}",
            order_type=order_type,
            participant=participant,
            asset_type=asset_type,
            quantity=quantity,
            price=price,
            timestamp=time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        )
        
        self._orders[order.order_id] = order
        
        # Try to match immediately
        self._match_orders(asset_type)
        
        return order

    def _match_orders(self, asset_type: AssetType) -> List[Trade]:
        """Match bids and asks for a given asset type."""
        trades = []
        
        # Get open orders for this asset
        bids = [o for o in self._orders.values() 
                if o.asset_type == asset_type and o.order_type == OrderType.BID and o.status == "open"]
        asks = [o for o in self._orders.values() 
                if o.asset_type == asset_type and o.order_type == OrderType.ASK and o.status == "open"]
        
        # Sort bids descending, asks ascending
        bids.sort(key=lambda o: o.price, reverse=True)
        asks.sort(key=lambda o: o.price)
        
        for bid in bids:
            for ask in asks:
                if bid.status != "open" or ask.status != "open":
                    continue
                
                # Check if prices match within barter tolerance
                price_diff = abs(bid.price - ask.price) / max(bid.price, ask.price)
                if price_diff <= BARTER_TOLERANCE:
                    # Match!
                    match_quantity = min(
                        bid.quantity - bid.filled_quantity,
                        ask.quantity - ask.filled_quantity
                    )
                    
                    if match_quantity > 0:
                        # Execute trade
                        trade = self._execute_trade(bid, ask, match_quantity)
                        trades.append(trade)
                        
                        # Update filled quantities
                        bid.filled_quantity += match_quantity
                        ask.filled_quantity += match_quantity
                        
                        # Check if fully filled
                        if bid.filled_quantity >= bid.quantity:
                            bid.status = "filled"
                        if ask.filled_quantity >= ask.quantity:
                            ask.status = "filled"
        
        return trades

    def _execute_trade(self, bid: MarketOrder, ask: MarketOrder, quantity: float) -> Trade:
        """Execute a trade between a bid and ask."""
        # Trade price is φ-weighted average
        trade_price = (PHI_INV * bid.price) + ((1 - PHI_INV) * ask.price)
        total_value = quantity * trade_price
        
        # φ efficiency — how close to theoretical optimum
        theoretical_value = quantity * self.get_price(bid.asset_type)
        phi_efficiency = min(1.0, total_value / theoretical_value) if theoretical_value > 0 else 0
        
        # Generate trade ID
        raw_id = f"TRD-{bid.participant}-{ask.participant}-{time.time()}"
        trade_id = hashlib.sha256(raw_id.encode()).hexdigest()[:12].upper()
        
        trade = Trade(
            trade_id=f"TR-{trade_id}",
            buyer=bid.participant,
            seller=ask.participant,
            asset_type=bid.asset_type,
            quantity=quantity,
            price=trade_price,
            total_value=total_value,
            phi_efficiency=phi_efficiency,
            timestamp=time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        )
        
        self._trades.append(trade)
        self._trade_count += 1
        
        # Update market price toward trade price
        old_price = self.get_price(bid.asset_type)
        new_price = (PHI_INV * old_price) + ((1 - PHI_INV) * trade_price)
        self.set_price(bid.asset_type, new_price)
        
        return trade

    def swap(
        self,
        participant: str,
        give_asset: AssetType,
        give_quantity: float,
        receive_asset: AssetType
    ) -> Tuple[float, Trade]:
        """
        Swap one asset for another at current market rates.
        
        Returns:
            (received_quantity, trade_record)
        """
        # Calculate exchange value
        give_value = give_quantity * self.get_price(give_asset)
        receive_price = self.get_price(receive_asset)
        receive_quantity = give_value / receive_price
        
        # Apply φ efficiency
        receive_quantity *= PHI_INV
        
        # Generate trade ID
        raw_id = f"SWAP-{participant}-{give_asset.value}-{receive_asset.value}-{time.time()}"
        trade_id = hashlib.sha256(raw_id.encode()).hexdigest()[:12].upper()
        
        trade = Trade(
            trade_id=f"SW-{trade_id}",
            buyer=participant,
            seller="MARKET",
            asset_type=receive_asset,
            quantity=receive_quantity,
            price=receive_price,
            total_value=give_value,
            phi_efficiency=PHI_INV,
            timestamp=time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        )
        
        self._trades.append(trade)
        self._trade_count += 1
        
        return receive_quantity, trade

    def get_order_book(self, asset_type: AssetType) -> Dict[str, List[Dict]]:
        """Get order book for an asset type."""
        bids = [
            {"price": o.price, "quantity": o.quantity - o.filled_quantity, "participant": o.participant}
            for o in self._orders.values()
            if o.asset_type == asset_type and o.order_type == OrderType.BID and o.status == "open"
        ]
        asks = [
            {"price": o.price, "quantity": o.quantity - o.filled_quantity, "participant": o.participant}
            for o in self._orders.values()
            if o.asset_type == asset_type and o.order_type == OrderType.ASK and o.status == "open"
        ]
        
        bids.sort(key=lambda x: x["price"], reverse=True)
        asks.sort(key=lambda x: x["price"])
        
        return {"bids": bids, "asks": asks}

    def get_market_summary(self) -> Dict[str, Any]:
        """Get market summary."""
        return {
            "prices": {at.value: self._prices[at] for at in AssetType},
            "trade_count": self._trade_count,
            "open_orders": len([o for o in self._orders.values() if o.status == "open"]),
            "filled_orders": len([o for o in self._orders.values() if o.status == "filled"]),
            "recent_trades": len(self._trades[-10:]) if self._trades else 0,
            "barter_tolerance": BARTER_TOLERANCE,
            "coherence": self._coherence,
        }

    def update_coherence(self, coherence: float) -> None:
        """Update market coherence."""
        self._coherence = max(0.0, min(1.0, coherence))

    def status(self) -> Dict[str, Any]:
        """Return full status report."""
        return {
            "market": "MOTOR_MERCATUS",
            "prima_causa": self.prima_causa,
            "summary": self.get_market_summary(),
            "status": "ACTIVE",
        }


# ── Standalone test ───────────────────────────────────────────────────────────
if __name__ == "__main__":
    import json
    
    market = MarketEngine()
    print("MARKET ENGINE — MOTOR MERCATUS")
    print("=" * 60)
    
    # Submit orders
    bid1 = market.submit_order("worker-1", OrderType.BID, AssetType.CYCLES, 1000, 0.0012)
    ask1 = market.submit_order("worker-2", OrderType.ASK, AssetType.CYCLES, 800, 0.001)
    
    print(f"Bid: {bid1.order_id} - {bid1.quantity} cycles @ {bid1.price} INT-TOK")
    print(f"Ask: {ask1.order_id} - {ask1.quantity} cycles @ {ask1.price} INT-TOK")
    print(f"Bid status: {bid1.status}, filled: {bid1.filled_quantity}")
    print(f"Ask status: {ask1.status}, filled: {ask1.filled_quantity}")
    
    # Swap
    received, trade = market.swap("worker-3", AssetType.INT_TOK, 10, AssetType.COMPUTE)
    print(f"\nSwap: 10 INT-TOK → {received:.2f} compute")
    
    print("\nMarket Summary:")
    print(json.dumps(market.get_market_summary(), indent=2))
