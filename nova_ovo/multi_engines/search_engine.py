"""
Multi-Engine — Search Engine (PROT-601)
Semantic + vector + knowledge graph search.
"""

from __future__ import annotations
from typing import Any, Dict, List, Optional, Tuple
from dataclasses import dataclass, field
from enum import Enum
from datetime import datetime

PHI: float = 1.6180339887498948482


class SearchMode(Enum):
    SEMANTIC = "semantic"
    KEYWORD = "keyword"
    VECTOR = "vector"
    GRAPH = "graph"
    HYBRID = "hybrid"
    FUZZY = "fuzzy"


@dataclass
class SearchResult:
    """A single search result."""
    id: str
    title: str
    content: str
    score: float
    source: str
    metadata: Dict[str, Any] = field(default_factory=dict)
    highlights: List[str] = field(default_factory=list)


@dataclass
class SearchQuery:
    """A structured search query."""
    query: str
    mode: SearchMode = SearchMode.HYBRID
    filters: Dict[str, Any] = field(default_factory=dict)
    limit: int = 10
    offset: int = 0
    boost_fields: List[str] = field(default_factory=list)
    min_score: float = 0.0


class SearchEngine:
    """
    Sovereign Search Engine — PROT-601
    Multi-modal search across memory, knowledge, and vector stores.
    """

    def __init__(self):
        self.index: Dict[str, Dict[str, Any]] = {}
        self.search_history: List[SearchQuery] = []
        self.total_searches: int = 0

    def index_document(self, doc_id: str, title: str, content: str,
                       source: str = "organism", metadata: Optional[Dict[str, Any]] = None) -> None:
        """Index a document for search."""
        self.index[doc_id] = {
            "id": doc_id,
            "title": title,
            "content": content,
            "source": source,
            "metadata": metadata or {},
            "indexed_at": datetime.utcnow().isoformat(),
            "tokens": set(content.lower().split() + title.lower().split()),
        }

    def search(self, query: SearchQuery) -> List[SearchResult]:
        """Execute a search query."""
        self.search_history.append(query)
        self.total_searches += 1

        results = []
        query_tokens = set(query.query.lower().split())

        for doc_id, doc in self.index.items():
            # Apply filters
            if query.filters:
                skip = False
                for key, value in query.filters.items():
                    if doc.get("metadata", {}).get(key) != value:
                        skip = True
                        break
                if skip:
                    continue

            # Score calculation
            score = self._calculate_score(query_tokens, doc, query.mode)

            if score >= query.min_score:
                highlights = self._generate_highlights(query.query, doc["content"])
                results.append(SearchResult(
                    id=doc_id,
                    title=doc["title"],
                    content=doc["content"][:200],
                    score=score,
                    source=doc["source"],
                    metadata=doc["metadata"],
                    highlights=highlights,
                ))

        # Sort by score descending
        results.sort(key=lambda r: r.score, reverse=True)
        return results[query.offset:query.offset + query.limit]

    def _calculate_score(self, query_tokens: set, doc: Dict[str, Any], mode: SearchMode) -> float:
        """Calculate relevance score."""
        doc_tokens = doc.get("tokens", set())

        if mode == SearchMode.KEYWORD:
            if not query_tokens:
                return 0.0
            overlap = len(query_tokens & doc_tokens)
            return overlap / len(query_tokens)

        elif mode == SearchMode.SEMANTIC:
            # Simplified semantic scoring (word overlap + position bonus)
            overlap = len(query_tokens & doc_tokens)
            total = len(query_tokens | doc_tokens) or 1
            jaccard = overlap / total
            # Title bonus
            title_tokens = set(doc["title"].lower().split())
            title_overlap = len(query_tokens & title_tokens) / max(1, len(query_tokens))
            return (jaccard + title_overlap * PHI) / (1 + PHI)

        elif mode == SearchMode.HYBRID:
            keyword_score = self._calculate_score(query_tokens, doc, SearchMode.KEYWORD)
            semantic_score = self._calculate_score(query_tokens, doc, SearchMode.SEMANTIC)
            # Phi-weighted combination
            return (keyword_score + semantic_score * PHI) / (1 + PHI)

        elif mode == SearchMode.FUZZY:
            # Character n-gram overlap
            query_str = " ".join(query_tokens)
            doc_str = doc["content"].lower()[:500]
            q_ngrams = set(query_str[i:i+3] for i in range(len(query_str)-2))
            d_ngrams = set(doc_str[i:i+3] for i in range(len(doc_str)-2))
            if not q_ngrams:
                return 0.0
            return len(q_ngrams & d_ngrams) / len(q_ngrams)

        return 0.0

    def _generate_highlights(self, query: str, content: str) -> List[str]:
        """Generate highlighted snippets."""
        highlights = []
        query_words = query.lower().split()
        sentences = content.split(".")

        for sentence in sentences[:10]:
            if any(word in sentence.lower() for word in query_words):
                highlights.append(sentence.strip()[:100])
                if len(highlights) >= 3:
                    break

        return highlights

    def suggest(self, partial_query: str, limit: int = 5) -> List[str]:
        """Suggest completions for a partial query."""
        suggestions = set()
        partial_lower = partial_query.lower()

        for doc in self.index.values():
            for token in doc["tokens"]:
                if token.startswith(partial_lower) and token != partial_lower:
                    suggestions.add(token)
                    if len(suggestions) >= limit:
                        return list(suggestions)

        return list(suggestions)[:limit]

    def status(self) -> Dict[str, Any]:
        return {
            "protocol": "PROT-601",
            "documents_indexed": len(self.index),
            "total_searches": self.total_searches,
            "modes_available": [m.value for m in SearchMode],
        }


# Singleton
search_engine = SearchEngine()

__all__ = ["SearchEngine", "SearchResult", "SearchQuery", "SearchMode", "search_engine"]
