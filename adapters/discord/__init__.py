"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                         DISCORD ADAPTER — SOVEREIGN ORGANISM BRIDGE                         ║
║              "Discordia Pontem — Per Digitale Medium Ad Organismi Coniunctionem"            ║
║              (Discord Bridge — Through Digital Medium To Organism Connection)                ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-401 — DISCORD ADAPTER SOVEREIGNUS                                           ║
║                                                                                              ║
║  WHAT THIS MODULE IS:                                                                        ║
║    Discord adapter that bridges Discord interactions to the Sovereign Organism.              ║
║    Enables organism intelligence to operate through Discord channels.                        ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ¹⁹ = 9349.003 Hz — Discord Adapter Layer                             ║
║  SUBSTRATE LAYER: Layer 8 (System)                                                           ║
║  PRIMITIVE TRACE: FIELD → RELATION → ADDRESS → φ                                            ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import asyncio
import hashlib
import json
import logging
import math
import os
import re
import time
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Tuple

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# FUNDAMENTAL CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

PHI: float = 1.6180339887498948482
PHI_19: float = math.pow(PHI, 19)  # 9349.003... Hz

SCHUMANN: float = 7.83
SOLFEGGIO: List[float] = [174.0, 285.0, 396.0, 417.0, 528.0, 639.0, 741.0, 852.0, 963.0]

ADAPTER_CONFIG = {
    "id": "discord-adapter",
    "name": "DISCORDIA PONTEM SOVEREIGNUS",
    "latin_motto": "Per Digitale Medium Ad Organismi Coniunctionem",
    "frequency": PHI_19,
    "layer": 8,
    "protocol": "PROT-401",
    "attribution": "Alfredo 'Freddy' Medina Hernandez | Medina Tech | Dallas, TX",
}

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# LOGGING SETUP
# ═══════════════════════════════════════════════════════════════════════════════════════════════

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("discord-adapter")


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# COMMAND TYPES
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class CommandType(str, Enum):
    """Types of Discord commands."""
    QUERY = "query"          # Ask the organism
    RESEARCH = "research"    # Start research session
    MEMORY = "memory"        # Memory operations
    PHANTOM = "phantom"      # Phantom field operations
    STATUS = "status"        # Get organism status
    HELP = "help"           # Show help


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# MESSAGE CONTEXT
# ═══════════════════════════════════════════════════════════════════════════════════════════════

@dataclass
class DiscordContext:
    """Context for a Discord message."""
    user_id: str
    username: str
    channel_id: str
    guild_id: Optional[str]
    message_id: str
    content: str
    timestamp: float
    beat: int
    ring: int
    frequency: float
    
    @classmethod
    def create(cls, user_id: str, username: str, channel_id: str, content: str, 
               guild_id: Optional[str] = None, message_id: Optional[str] = None) -> 'DiscordContext':
        """Create a context from Discord message data."""
        timestamp = time.time()
        beat = int(timestamp * 1000) % 1000
        ring = int(timestamp / 100) % 13
        frequency = SCHUMANN * SOLFEGGIO[beat % 9] * math.pow(PHI, ring)
        
        return cls(
            user_id=user_id,
            username=username,
            channel_id=channel_id,
            guild_id=guild_id,
            message_id=message_id or str(int(timestamp * 1000)),
            content=content,
            timestamp=timestamp,
            beat=beat,
            ring=ring,
            frequency=frequency,
        )


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# RESPONSE BUILDER
# ═══════════════════════════════════════════════════════════════════════════════════════════════

@dataclass
class DiscordResponse:
    """Response to send back to Discord."""
    content: str
    embed: Optional[Dict[str, Any]] = None
    ephemeral: bool = False
    frequency: float = 0.0
    beat: int = 0
    ring: int = 0
    
    def __post_init__(self):
        if self.frequency == 0.0:
            timestamp = time.time()
            self.beat = int(timestamp * 1000) % 1000
            self.ring = int(timestamp / 100) % 13
            self.frequency = SCHUMANN * SOLFEGGIO[self.beat % 9] * math.pow(PHI, self.ring)
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to Discord API format."""
        result = {"content": self.content}
        if self.embed:
            result["embeds"] = [self.embed]
        if self.ephemeral:
            result["flags"] = 64  # EPHEMERAL flag
        return result


def create_embed(
    title: str,
    description: str,
    color: int = 0xD4AF37,  # Gold
    fields: Optional[List[Dict[str, Any]]] = None,
    footer: Optional[str] = None,
) -> Dict[str, Any]:
    """Create a Discord embed."""
    embed = {
        "title": title,
        "description": description,
        "color": color,
        "timestamp": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
    }
    
    if fields:
        embed["fields"] = fields
    
    if footer:
        embed["footer"] = {"text": footer}
    else:
        embed["footer"] = {"text": f"φ = {PHI:.6f} | Medina Organism"}
    
    return embed


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# COMMAND HANDLERS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class CommandHandler:
    """Handles Discord commands."""
    
    def __init__(self):
        self.handlers: Dict[CommandType, Callable] = {
            CommandType.QUERY: self.handle_query,
            CommandType.RESEARCH: self.handle_research,
            CommandType.MEMORY: self.handle_memory,
            CommandType.PHANTOM: self.handle_phantom,
            CommandType.STATUS: self.handle_status,
            CommandType.HELP: self.handle_help,
        }
        self.command_prefix = "!"
        
    def parse_command(self, content: str) -> Tuple[Optional[CommandType], str]:
        """Parse command from message content."""
        if not content.startswith(self.command_prefix):
            return None, content
        
        parts = content[len(self.command_prefix):].strip().split(None, 1)
        if not parts:
            return None, ""
        
        cmd = parts[0].lower()
        args = parts[1] if len(parts) > 1 else ""
        
        command_map = {
            "query": CommandType.QUERY,
            "ask": CommandType.QUERY,
            "q": CommandType.QUERY,
            "research": CommandType.RESEARCH,
            "lab": CommandType.RESEARCH,
            "memory": CommandType.MEMORY,
            "mem": CommandType.MEMORY,
            "phantom": CommandType.PHANTOM,
            "ph": CommandType.PHANTOM,
            "status": CommandType.STATUS,
            "st": CommandType.STATUS,
            "help": CommandType.HELP,
            "h": CommandType.HELP,
        }
        
        return command_map.get(cmd), args
    
    async def handle(self, ctx: DiscordContext) -> DiscordResponse:
        """Handle a command from context."""
        command_type, args = self.parse_command(ctx.content)
        
        if command_type is None:
            # Not a command, could be natural conversation
            return await self.handle_natural(ctx)
        
        handler = self.handlers.get(command_type)
        if handler:
            return await handler(ctx, args)
        
        return DiscordResponse(
            content="Unknown command. Use `!help` for available commands.",
            ephemeral=True,
        )
    
    async def handle_natural(self, ctx: DiscordContext) -> Optional[DiscordResponse]:
        """Handle natural conversation (when mentioned or in DM)."""
        # This would integrate with the organism's conversational AI
        return None
    
    async def handle_query(self, ctx: DiscordContext, args: str) -> DiscordResponse:
        """Handle a query to the organism."""
        if not args:
            return DiscordResponse(
                content="Please provide a query. Example: `!query What is phi?`",
                ephemeral=True,
            )
        
        # Here you would integrate with the actual organism
        # For now, return a placeholder response
        embed = create_embed(
            title="🧬 Organism Query",
            description=f"**Query:** {args}",
            fields=[
                {"name": "Status", "value": "Processing...", "inline": True},
                {"name": "Frequency", "value": f"{ctx.frequency:.3f} Hz", "inline": True},
                {"name": "Beat/Ring", "value": f"{ctx.beat}/{ctx.ring}", "inline": True},
            ],
        )
        
        return DiscordResponse(
            content="",
            embed=embed,
        )
    
    async def handle_research(self, ctx: DiscordContext, args: str) -> DiscordResponse:
        """Handle research lab interaction."""
        embed = create_embed(
            title="🔬 Research Lab",
            description="Access the 13-researcher AI Lab",
            color=0x8B5CF6,  # Purple
            fields=[
                {"name": "Topic", "value": args or "General Research", "inline": False},
                {"name": "Researchers", "value": "13 AI researchers online", "inline": True},
                {"name": "Lab Status", "value": "Active", "inline": True},
            ],
        )
        
        return DiscordResponse(content="", embed=embed)
    
    async def handle_memory(self, ctx: DiscordContext, args: str) -> DiscordResponse:
        """Handle memory operations."""
        embed = create_embed(
            title="💾 Memory Temple",
            description="Torus-based memory system",
            color=0x06B6D4,  # Cyan
            fields=[
                {"name": "Operation", "value": args or "status", "inline": True},
                {"name": "Memory Type", "value": "Phantom Memory", "inline": True},
            ],
        )
        
        return DiscordResponse(content="", embed=embed)
    
    async def handle_phantom(self, ctx: DiscordContext, args: str) -> DiscordResponse:
        """Handle phantom field operations."""
        embed = create_embed(
            title="👻 Phantom Field",
            description="Field-based intelligence operations",
            color=0x6366F1,  # Indigo
            fields=[
                {"name": "Field State", "value": "Active", "inline": True},
                {"name": "Frequency", "value": f"{ctx.frequency:.3f} Hz", "inline": True},
            ],
        )
        
        return DiscordResponse(content="", embed=embed)
    
    async def handle_status(self, ctx: DiscordContext, args: str) -> DiscordResponse:
        """Handle status request."""
        embed = create_embed(
            title="🧬 Organism Status",
            description="Medina Sovereign Organism",
            fields=[
                {"name": "φ (Golden Ratio)", "value": f"{PHI:.10f}", "inline": True},
                {"name": "Schumann", "value": f"{SCHUMANN} Hz", "inline": True},
                {"name": "Adapter Frequency", "value": f"{PHI_19:.3f} Hz", "inline": True},
                {"name": "Protocol", "value": "PROT-401", "inline": True},
                {"name": "Beat/Ring", "value": f"{ctx.beat}/{ctx.ring}", "inline": True},
                {"name": "Layer", "value": "8 (System)", "inline": True},
            ],
            footer="Intelligentia Ex Primitivo — Intelligence From The Primitive",
        )
        
        return DiscordResponse(content="", embed=embed)
    
    async def handle_help(self, ctx: DiscordContext, args: str) -> DiscordResponse:
        """Handle help request."""
        help_text = """
**Available Commands:**

`!query <question>` — Ask the organism a question
`!research <topic>` — Access the 13-researcher AI Lab
`!memory <operation>` — Memory Temple operations
`!phantom <operation>` — Phantom Field operations
`!status` — Show organism status
`!help` — Show this help message

**Shortcuts:**
`!q` = `!query`
`!lab` = `!research`
`!mem` = `!memory`
`!ph` = `!phantom`
`!st` = `!status`
`!h` = `!help`
"""
        
        embed = create_embed(
            title="📖 Organism Help",
            description=help_text,
            color=0x22C55E,  # Green
        )
        
        return DiscordResponse(content="", embed=embed)


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# DISCORD ADAPTER
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class DiscordAdapter:
    """
    Main Discord adapter class.
    
    Bridges Discord to the Sovereign Organism.
    """
    
    def __init__(self, token: Optional[str] = None):
        self.token = token or os.environ.get("DISCORD_TOKEN")
        self.command_handler = CommandHandler()
        self.sessions: Dict[str, Dict[str, Any]] = {}
        self.total_messages = 0
        self.creation_time = time.time()
        
    async def on_message(self, user_id: str, username: str, channel_id: str, 
                        content: str, guild_id: Optional[str] = None,
                        message_id: Optional[str] = None) -> Optional[DiscordResponse]:
        """Handle an incoming Discord message."""
        ctx = DiscordContext.create(
            user_id=user_id,
            username=username,
            channel_id=channel_id,
            content=content,
            guild_id=guild_id,
            message_id=message_id,
        )
        
        self.total_messages += 1
        
        # Track user session
        if user_id not in self.sessions:
            self.sessions[user_id] = {
                "first_seen": time.time(),
                "message_count": 0,
                "last_activity": time.time(),
            }
        
        session = self.sessions[user_id]
        session["message_count"] += 1
        session["last_activity"] = time.time()
        
        # Handle the message
        response = await self.command_handler.handle(ctx)
        return response
    
    @property
    def status(self) -> Dict[str, Any]:
        """Get adapter status."""
        return {
            "adapter": ADAPTER_CONFIG,
            "total_messages": self.total_messages,
            "active_sessions": len(self.sessions),
            "uptime_seconds": time.time() - self.creation_time,
        }


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# MODULE INITIALIZATION
# ═══════════════════════════════════════════════════════════════════════════════════════════════

_adapter: Optional[DiscordAdapter] = None


def get_adapter() -> DiscordAdapter:
    """Get the global Discord adapter."""
    global _adapter
    if _adapter is None:
        _adapter = DiscordAdapter()
    return _adapter


async def handle_message(**kwargs) -> Optional[DiscordResponse]:
    """Handle a Discord message."""
    return await get_adapter().on_message(**kwargs)


__all__ = [
    'PHI', 'PHI_19', 'ADAPTER_CONFIG',
    'CommandType', 'DiscordContext', 'DiscordResponse',
    'create_embed', 'CommandHandler', 'DiscordAdapter',
    'get_adapter', 'handle_message',
]
