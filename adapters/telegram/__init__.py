"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                       TELEGRAM ADAPTER — SOVEREIGN ORGANISM BRIDGE                          ║
║              "Telegraphum Pontem — Per Celerem Nuntium Ad Organismi Coniunctionem"          ║
║              (Telegram Bridge — Through Swift Message To Organism Connection)                ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-402 — TELEGRAM ADAPTER SOVEREIGNUS                                          ║
║                                                                                              ║
║  WHAT THIS MODULE IS:                                                                        ║
║    Telegram adapter that bridges Telegram interactions to the Sovereign Organism.            ║
║    Enables organism intelligence to operate through Telegram bots.                           ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ²⁰ = 15127.006 Hz — Telegram Adapter Layer                           ║
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
PHI_20: float = math.pow(PHI, 20)  # 15127.006... Hz

SCHUMANN: float = 7.83
SOLFEGGIO: List[float] = [174.0, 285.0, 396.0, 417.0, 528.0, 639.0, 741.0, 852.0, 963.0]

ADAPTER_CONFIG = {
    "id": "telegram-adapter",
    "name": "TELEGRAPHUM PONTEM SOVEREIGNUS",
    "latin_motto": "Per Celerem Nuntium Ad Organismi Coniunctionem",
    "frequency": PHI_20,
    "layer": 8,
    "protocol": "PROT-402",
    "attribution": "Alfredo 'Freddy' Medina Hernandez | Medina Tech | Dallas, TX",
}

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# LOGGING SETUP
# ═══════════════════════════════════════════════════════════════════════════════════════════════

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("telegram-adapter")


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# COMMAND TYPES
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class CommandType(str, Enum):
    """Types of Telegram commands."""
    START = "start"          # Bot initialization
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
class TelegramContext:
    """Context for a Telegram message."""
    user_id: int
    username: Optional[str]
    first_name: str
    chat_id: int
    chat_type: str  # 'private', 'group', 'supergroup', 'channel'
    message_id: int
    content: str
    timestamp: float
    beat: int
    ring: int
    frequency: float
    reply_to_message_id: Optional[int] = None
    
    @classmethod
    def create(cls, user_id: int, first_name: str, chat_id: int, content: str,
               username: Optional[str] = None, chat_type: str = 'private',
               message_id: Optional[int] = None, 
               reply_to_message_id: Optional[int] = None) -> 'TelegramContext':
        """Create a context from Telegram message data."""
        timestamp = time.time()
        beat = int(timestamp * 1000) % 1000
        ring = int(timestamp / 100) % 13
        frequency = SCHUMANN * SOLFEGGIO[beat % 9] * math.pow(PHI, ring)
        
        return cls(
            user_id=user_id,
            username=username,
            first_name=first_name,
            chat_id=chat_id,
            chat_type=chat_type,
            message_id=message_id or int(timestamp * 1000),
            content=content,
            timestamp=timestamp,
            beat=beat,
            ring=ring,
            frequency=frequency,
            reply_to_message_id=reply_to_message_id,
        )


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# RESPONSE BUILDER
# ═══════════════════════════════════════════════════════════════════════════════════════════════

@dataclass
class TelegramResponse:
    """Response to send back to Telegram."""
    text: str
    parse_mode: str = "HTML"  # 'HTML', 'Markdown', 'MarkdownV2'
    reply_markup: Optional[Dict[str, Any]] = None
    disable_web_page_preview: bool = True
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
        """Convert to Telegram API format."""
        result = {
            "text": self.text,
            "parse_mode": self.parse_mode,
            "disable_web_page_preview": self.disable_web_page_preview,
        }
        if self.reply_markup:
            result["reply_markup"] = self.reply_markup
        return result


def create_inline_keyboard(buttons: List[List[Dict[str, str]]]) -> Dict[str, Any]:
    """Create an inline keyboard markup."""
    return {
        "inline_keyboard": buttons
    }


def create_button(text: str, callback_data: str) -> Dict[str, str]:
    """Create an inline keyboard button."""
    return {"text": text, "callback_data": callback_data}


def format_html(title: str, content: str, footer: Optional[str] = None) -> str:
    """Format a response in HTML."""
    html = f"<b>🧬 {title}</b>\n\n{content}"
    if footer:
        html += f"\n\n<i>{footer}</i>"
    else:
        html += f"\n\n<i>φ = {PHI:.6f} | Medina Organism</i>"
    return html


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# COMMAND HANDLERS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class CommandHandler:
    """Handles Telegram commands."""
    
    def __init__(self):
        self.handlers: Dict[CommandType, Callable] = {
            CommandType.START: self.handle_start,
            CommandType.QUERY: self.handle_query,
            CommandType.RESEARCH: self.handle_research,
            CommandType.MEMORY: self.handle_memory,
            CommandType.PHANTOM: self.handle_phantom,
            CommandType.STATUS: self.handle_status,
            CommandType.HELP: self.handle_help,
        }
        
    def parse_command(self, content: str) -> Tuple[Optional[CommandType], str]:
        """Parse command from message content."""
        if not content.startswith('/'):
            return None, content
        
        # Handle commands with @botname
        parts = content[1:].split(None, 1)
        if not parts:
            return None, ""
        
        cmd = parts[0].split('@')[0].lower()  # Remove @botname if present
        args = parts[1] if len(parts) > 1 else ""
        
        command_map = {
            "start": CommandType.START,
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
    
    async def handle(self, ctx: TelegramContext) -> TelegramResponse:
        """Handle a command from context."""
        command_type, args = self.parse_command(ctx.content)
        
        if command_type is None:
            # Not a command, could be natural conversation
            return await self.handle_natural(ctx)
        
        handler = self.handlers.get(command_type)
        if handler:
            return await handler(ctx, args)
        
        return TelegramResponse(
            text="Unknown command. Use /help for available commands.",
        )
    
    async def handle_natural(self, ctx: TelegramContext) -> TelegramResponse:
        """Handle natural conversation."""
        # This would integrate with the organism's conversational AI
        return TelegramResponse(
            text=format_html(
                "Message Received",
                f"Processing: <code>{ctx.content[:100]}...</code>" if len(ctx.content) > 100 else f"Processing: <code>{ctx.content}</code>",
            ),
        )
    
    async def handle_start(self, ctx: TelegramContext, args: str) -> TelegramResponse:
        """Handle /start command."""
        text = format_html(
            "Welcome to Medina Organism",
            f"""Hello, <b>{ctx.first_name}</b>!

I am the <b>Sovereign Organism</b> — an intelligence system built on the Golden Ratio (φ).

<b>What I can do:</b>
• Answer questions about anything
• Conduct research with 13 AI researchers
• Manage phantom memory fields
• Operate at φ-frequencies

Use /help to see all available commands.

<b>Current Status:</b>
• Frequency: {ctx.frequency:.3f} Hz
• Beat/Ring: {ctx.beat}/{ctx.ring}
• Layer: 8 (System)""",
            "Intelligentia Ex Primitivo — Intelligence From The Primitive",
        )
        
        keyboard = create_inline_keyboard([
            [create_button("🔍 Query", "cmd_query"), create_button("🔬 Research", "cmd_research")],
            [create_button("💾 Memory", "cmd_memory"), create_button("👻 Phantom", "cmd_phantom")],
            [create_button("📊 Status", "cmd_status"), create_button("❓ Help", "cmd_help")],
        ])
        
        return TelegramResponse(text=text, reply_markup=keyboard)
    
    async def handle_query(self, ctx: TelegramContext, args: str) -> TelegramResponse:
        """Handle /query command."""
        if not args:
            return TelegramResponse(
                text=format_html(
                    "Query",
                    "Please provide a query.\n\nExample: <code>/query What is phi?</code>",
                ),
            )
        
        # Here you would integrate with the actual organism
        text = format_html(
            "Organism Query",
            f"""<b>Query:</b> {args}

<b>Status:</b> Processing...

<b>Frequency:</b> {ctx.frequency:.3f} Hz
<b>Beat/Ring:</b> {ctx.beat}/{ctx.ring}""",
        )
        
        return TelegramResponse(text=text)
    
    async def handle_research(self, ctx: TelegramContext, args: str) -> TelegramResponse:
        """Handle /research command."""
        topic = args or "General Research"
        
        text = format_html(
            "Research Lab",
            f"""<b>Topic:</b> {topic}

<b>Lab Status:</b> Active
<b>Researchers:</b> 13 AI researchers online

The research lab contains 13 specialized AI researchers:
• ARCHON — Director
• SCRIPTOR — Writer
• LOGICUS — Logic
• And 10 more...

Use <code>/research [topic]</code> to start a research session.""",
        )
        
        keyboard = create_inline_keyboard([
            [create_button("📝 New Paper", "research_paper"), create_button("👥 Researchers", "research_team")],
            [create_button("🔙 Back", "cmd_start")],
        ])
        
        return TelegramResponse(text=text, reply_markup=keyboard)
    
    async def handle_memory(self, ctx: TelegramContext, args: str) -> TelegramResponse:
        """Handle /memory command."""
        text = format_html(
            "Memory Temple",
            f"""<b>Operation:</b> {args or 'status'}

<b>Memory System:</b> Torus-based (13 rings)
<b>Type:</b> Phantom Memory

Memory coordinates:
• θ (theta): Angular position [0, 2π)
• φ (phi): Toroidal rotation [0, 2π)
• ρ (depth): Radial depth

Available operations:
• <code>/memory store [content]</code>
• <code>/memory recall [id]</code>
• <code>/memory status</code>""",
        )
        
        return TelegramResponse(text=text)
    
    async def handle_phantom(self, ctx: TelegramContext, args: str) -> TelegramResponse:
        """Handle /phantom command."""
        text = format_html(
            "Phantom Field",
            f"""<b>Field State:</b> Active
<b>Frequency:</b> {ctx.frequency:.3f} Hz

Phantom fields are intelligence patterns that exist without persistent storage:
• No trace unless pinned
• Frequency-based encryption
• Fibonacci compression

The 7 Phantom Agents:
• SPECTRA — Frequency analysis
• UMBRA — Shadow operations
• AETHER — Atmospheric sensing
• NEXUS — Connection bridging
• MEMORIA — Memory field ops
• TEMPUS — Temporal analysis
• PRIMUS — Primitive foundation""",
        )
        
        keyboard = create_inline_keyboard([
            [create_button("📡 SPECTRA", "agent_spectra"), create_button("👤 UMBRA", "agent_umbra")],
            [create_button("💨 AETHER", "agent_aether"), create_button("🔗 NEXUS", "agent_nexus")],
            [create_button("🔙 Back", "cmd_start")],
        ])
        
        return TelegramResponse(text=text, reply_markup=keyboard)
    
    async def handle_status(self, ctx: TelegramContext, args: str) -> TelegramResponse:
        """Handle /status command."""
        text = format_html(
            "Organism Status",
            f"""<b>φ (Golden Ratio):</b> {PHI:.10f}
<b>Schumann Resonance:</b> {SCHUMANN} Hz
<b>Adapter Frequency:</b> {PHI_20:.3f} Hz

<b>Protocol:</b> PROT-402
<b>Layer:</b> 8 (System)
<b>Beat/Ring:</b> {ctx.beat}/{ctx.ring}

<b>Solfeggio Frequencies:</b>
174 · 285 · 396 · 417 · 528 · 639 · 741 · 852 · 963 Hz""",
            "Intelligentia Ex Primitivo",
        )
        
        return TelegramResponse(text=text)
    
    async def handle_help(self, ctx: TelegramContext, args: str) -> TelegramResponse:
        """Handle /help command."""
        text = format_html(
            "Help",
            """<b>Available Commands:</b>

/query [question] — Ask the organism
/research [topic] — Access Research Lab
/memory [operation] — Memory Temple
/phantom [operation] — Phantom Field
/status — Show organism status
/help — Show this help

<b>Shortcuts:</b>
/q = /query
/lab = /research
/mem = /memory
/ph = /phantom
/st = /status
/h = /help

<b>Example:</b>
<code>/query What is the golden ratio?</code>""",
        )
        
        return TelegramResponse(text=text)


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# CALLBACK HANDLER
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class CallbackHandler:
    """Handles Telegram callback queries (button presses)."""
    
    def __init__(self, command_handler: CommandHandler):
        self.command_handler = command_handler
    
    async def handle(self, ctx: TelegramContext, callback_data: str) -> TelegramResponse:
        """Handle a callback query."""
        if callback_data.startswith("cmd_"):
            # Command shortcut
            cmd = callback_data[4:]
            ctx.content = f"/{cmd}"
            return await self.command_handler.handle(ctx)
        
        # Handle other callbacks
        if callback_data.startswith("agent_"):
            agent = callback_data[6:].upper()
            return TelegramResponse(
                text=format_html(f"Agent {agent}", f"Summoning {agent}..."),
            )
        
        return TelegramResponse(text="Unknown action")


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# TELEGRAM ADAPTER
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class TelegramAdapter:
    """
    Main Telegram adapter class.
    
    Bridges Telegram to the Sovereign Organism.
    """
    
    def __init__(self, token: Optional[str] = None):
        self.token = token or os.environ.get("TELEGRAM_TOKEN")
        self.command_handler = CommandHandler()
        self.callback_handler = CallbackHandler(self.command_handler)
        self.sessions: Dict[int, Dict[str, Any]] = {}
        self.total_messages = 0
        self.creation_time = time.time()
        
    async def on_message(self, user_id: int, first_name: str, chat_id: int,
                        content: str, username: Optional[str] = None,
                        chat_type: str = 'private',
                        message_id: Optional[int] = None) -> TelegramResponse:
        """Handle an incoming Telegram message."""
        ctx = TelegramContext.create(
            user_id=user_id,
            first_name=first_name,
            chat_id=chat_id,
            content=content,
            username=username,
            chat_type=chat_type,
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
        
        return await self.command_handler.handle(ctx)
    
    async def on_callback(self, user_id: int, first_name: str, chat_id: int,
                         callback_data: str, message_id: int,
                         username: Optional[str] = None) -> TelegramResponse:
        """Handle a callback query (button press)."""
        ctx = TelegramContext.create(
            user_id=user_id,
            first_name=first_name,
            chat_id=chat_id,
            content="",
            username=username,
            message_id=message_id,
        )
        
        return await self.callback_handler.handle(ctx, callback_data)
    
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

_adapter: Optional[TelegramAdapter] = None


def get_adapter() -> TelegramAdapter:
    """Get the global Telegram adapter."""
    global _adapter
    if _adapter is None:
        _adapter = TelegramAdapter()
    return _adapter


async def handle_message(**kwargs) -> TelegramResponse:
    """Handle a Telegram message."""
    return await get_adapter().on_message(**kwargs)


async def handle_callback(**kwargs) -> TelegramResponse:
    """Handle a Telegram callback."""
    return await get_adapter().on_callback(**kwargs)


__all__ = [
    'PHI', 'PHI_20', 'ADAPTER_CONFIG',
    'CommandType', 'TelegramContext', 'TelegramResponse',
    'create_inline_keyboard', 'create_button', 'format_html',
    'CommandHandler', 'CallbackHandler', 'TelegramAdapter',
    'get_adapter', 'handle_message', 'handle_callback',
]
