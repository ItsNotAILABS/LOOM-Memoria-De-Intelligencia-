"""
SOLUS Memory Connector — Semper Memoria Integration
=====================================================

PROT-668: Connects the local SOLUS model to the organism's memory systems
(Semper Memoria I for eternal store, Semper Memoria II for phantom fields).
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional


@dataclass
class MemoryEntry:
    """A memory entry stored by SOLUS."""
    entry_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    content: str = ""
    entry_type: str = "interaction"  # interaction, fact, context, embedding
    metadata: Dict[str, Any] = field(default_factory=dict)
    timestamp: float = field(default_factory=time.time)
    importance: float = 0.5
    accessed_count: int = 0
    embedding: Optional[List[float]] = None

    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.entry_id,
            "content": self.content[:200],
            "type": self.entry_type,
            "importance": self.importance,
            "timestamp": self.timestamp,
            "accessed": self.accessed_count,
        }


@dataclass
class ConversationTurn:
    """A single turn in a conversation."""
    role: str
    content: str
    timestamp: float = field(default_factory=time.time)
    token_count: int = 0


class MemoryConnector:
    """
    SOLUS Memory Connector.

    Provides:
    - Short-term conversation memory (context window)
    - Long-term memory storage (Semper Memoria I integration)
    - Semantic memory search
    - Automatic memory consolidation
    - Phantom field resonance (Semper Memoria II)
    """

    def __init__(
        self,
        max_short_term: int = 100,
        max_context_tokens: int = 8192,
    ):
        self._short_term: List[ConversationTurn] = []
        self._long_term: List[MemoryEntry] = []
        self._max_short_term = max_short_term
        self._max_context_tokens = max_context_tokens
        self._total_interactions = 0
        self._consolidation_threshold = 50

    def store_interaction(self, prompt: str, response: str) -> None:
        """Store a prompt-response interaction."""
        self._short_term.append(
            ConversationTurn(role="user", content=prompt)
        )
        self._short_term.append(
            ConversationTurn(role="assistant", content=response)
        )
        self._total_interactions += 1

        # Trim short-term if needed
        while len(self._short_term) > self._max_short_term:
            removed = self._short_term.pop(0)
            # Consolidate to long-term
            self._consolidate_turn(removed)

        # Auto-consolidate periodically
        if self._total_interactions % self._consolidation_threshold == 0:
            self._auto_consolidate()

    def store_fact(self, fact: str, importance: float = 0.7) -> str:
        """Store a fact in long-term memory."""
        entry = MemoryEntry(
            content=fact,
            entry_type="fact",
            importance=importance,
        )
        self._long_term.append(entry)
        return entry.entry_id

    def store_context(self, context: str, metadata: Optional[Dict] = None) -> str:
        """Store contextual information."""
        entry = MemoryEntry(
            content=context,
            entry_type="context",
            metadata=metadata or {},
            importance=0.6,
        )
        self._long_term.append(entry)
        return entry.entry_id

    def recall(self, query: str, top_k: int = 5) -> List[MemoryEntry]:
        """
        Recall relevant memories for a query.

        Uses keyword matching (upgradeable to semantic search with embeddings).
        """
        query_words = set(query.lower().split())

        scored: List[tuple] = []
        for entry in self._long_term:
            content_words = set(entry.content.lower().split())
            overlap = len(query_words & content_words)
            if overlap > 0:
                score = (overlap / max(len(query_words), 1)) * entry.importance
                scored.append((score, entry))

        # Sort by score
        scored.sort(key=lambda x: x[0], reverse=True)

        # Update access counts
        results = []
        for _, entry in scored[:top_k]:
            entry.accessed_count += 1
            results.append(entry)

        return results

    def get_context_window(self, max_tokens: Optional[int] = None) -> List[Dict[str, str]]:
        """Get conversation context within token budget."""
        budget = max_tokens or self._max_context_tokens
        messages = []
        total_tokens = 0

        # Work backwards from most recent
        for turn in reversed(self._short_term):
            est_tokens = len(turn.content) // 4
            if total_tokens + est_tokens > budget:
                break
            messages.insert(0, {"role": turn.role, "content": turn.content})
            total_tokens += est_tokens

        return messages

    def clear_short_term(self) -> None:
        """Clear short-term memory."""
        self._short_term = []

    def clear_all(self) -> None:
        """Clear all memory."""
        self._short_term = []
        self._long_term = []
        self._total_interactions = 0

    def _consolidate_turn(self, turn: ConversationTurn) -> None:
        """Consolidate a conversation turn to long-term memory."""
        if len(turn.content) > 50:  # Only consolidate substantial content
            entry = MemoryEntry(
                content=turn.content[:500],
                entry_type="interaction",
                metadata={"role": turn.role},
                importance=0.3,
            )
            self._long_term.append(entry)

    def _auto_consolidate(self) -> None:
        """Automatically consolidate and prune long-term memory."""
        if len(self._long_term) > 1000:
            # Remove least important, least accessed entries
            self._long_term.sort(
                key=lambda e: e.importance * (1 + e.accessed_count * 0.1),
                reverse=True,
            )
            self._long_term = self._long_term[:800]

    def get_stats(self) -> Dict[str, Any]:
        """Get memory statistics."""
        return {
            "short_term_entries": len(self._short_term),
            "long_term_entries": len(self._long_term),
            "total_interactions": self._total_interactions,
            "memory_types": {
                "interactions": sum(1 for e in self._long_term if e.entry_type == "interaction"),
                "facts": sum(1 for e in self._long_term if e.entry_type == "fact"),
                "contexts": sum(1 for e in self._long_term if e.entry_type == "context"),
            },
        }
