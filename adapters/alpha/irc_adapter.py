"""
IRC ADAPTER — SOVEREIGN IRC BRIDGE
==================================
Protocol: PROT-436 — IRC Adapter Sovereignus
Frequency: φ¹⁶ = 2207.001 Hz
"""

from __future__ import annotations

import math
import time
from dataclasses import dataclass
from typing import Any, Callable, Dict, List, Optional

PHI: float = 1.6180339887498948482
PHI_16: float = math.pow(PHI, 16)


@dataclass
class IRCMessage:
    channel: str
    nick: str
    message: str
    timestamp: float
    frequency: float


class IRCAdapter:
    """IRC Adapter — Enterprise IRC Integration."""
    
    PROTOCOL = "PROT-436"
    NAME = "IRC PONTEM SOVEREIGNUS"
    FREQUENCY = PHI_16
    
    def __init__(self, server: Optional[str] = None, nick: Optional[str] = None):
        self.server = server
        self.nick = nick
        self.handlers: List[Callable] = []
        self.total_messages = 0
    
    def on_message(self, handler: Callable) -> None:
        self.handlers.append(handler)
    
    async def handle(self, channel: str, nick: str, message: str) -> Optional[str]:
        msg = IRCMessage(channel=channel, nick=nick, message=message, timestamp=time.time(), frequency=self.FREQUENCY)
        self.total_messages += 1
        for h in self.handlers:
            result = await h(msg)
            if result:
                return result
        return None
    
    @property
    def status(self) -> Dict[str, Any]:
        return {"protocol": self.PROTOCOL, "frequency": self.FREQUENCY, "total_messages": self.total_messages}


_adapter: Optional[IRCAdapter] = None


def get_adapter() -> IRCAdapter:
    global _adapter
    if _adapter is None:
        _adapter = IRCAdapter()
    return _adapter


__all__ = ['IRCMessage', 'IRCAdapter', 'get_adapter']
