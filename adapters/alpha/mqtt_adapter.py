"""
MQTT ADAPTER — SOVEREIGN MQTT BRIDGE
====================================
Protocol: PROT-440 — MQTT Adapter Sovereignus
Frequency: φ¹² = 321.997 Hz
"""

from __future__ import annotations

import math
import time
from dataclasses import dataclass
from typing import Any, Callable, Dict, List, Optional

PHI: float = 1.6180339887498948482
PHI_12: float = math.pow(PHI, 12)


@dataclass
class MQTTMessage:
    topic: str
    payload: bytes
    qos: int
    timestamp: float
    frequency: float
    retain: bool = False


class MQTTAdapter:
    """MQTT Adapter — Enterprise MQTT/IoT Integration."""
    
    PROTOCOL = "PROT-440"
    NAME = "MQTT PONTEM SOVEREIGNUS"
    FREQUENCY = PHI_12
    
    def __init__(self, broker: Optional[str] = None):
        self.broker = broker
        self.subscriptions: Dict[str, List[Callable]] = {}
        self.total_messages = 0
    
    def subscribe(self, topic: str, handler: Callable) -> None:
        if topic not in self.subscriptions:
            self.subscriptions[topic] = []
        self.subscriptions[topic].append(handler)
    
    async def publish(self, topic: str, payload: bytes, qos: int = 0) -> bool:
        msg = MQTTMessage(topic=topic, payload=payload, qos=qos, timestamp=time.time(), frequency=self.FREQUENCY)
        self.total_messages += 1
        return True
    
    async def handle(self, topic: str, payload: bytes) -> None:
        msg = MQTTMessage(topic=topic, payload=payload, qos=0, timestamp=time.time(), frequency=self.FREQUENCY)
        self.total_messages += 1
        for handler in self.subscriptions.get(topic, []):
            await handler(msg)
    
    @property
    def status(self) -> Dict[str, Any]:
        return {"protocol": self.PROTOCOL, "frequency": self.FREQUENCY, "total_messages": self.total_messages}


_adapter: Optional[MQTTAdapter] = None


def get_adapter() -> MQTTAdapter:
    global _adapter
    if _adapter is None:
        _adapter = MQTTAdapter()
    return _adapter


__all__ = ['MQTTMessage', 'MQTTAdapter', 'get_adapter']
