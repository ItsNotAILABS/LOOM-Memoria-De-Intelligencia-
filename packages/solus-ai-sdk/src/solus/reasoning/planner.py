"""
SOLUS Reasoning Planner — Strategy Selection & Orchestration
=============================================================

PROT-667: Meta-reasoning system that selects and orchestrates reasoning
strategies (CoT, ToT, decomposition, analogy) based on question type.
"""

from __future__ import annotations

import time
from dataclasses import dataclass
from enum import Enum
from typing import Any, Dict, List, Optional

from solus.reasoning.chain import ChainOfThought, ReasoningChain


class ReasoningStrategy(str, Enum):
    """Available reasoning strategies."""
    CHAIN_OF_THOUGHT = "chain_of_thought"
    TREE_OF_THOUGHT = "tree_of_thought"
    DECOMPOSITION = "decomposition"
    ANALOGY = "analogy"
    FIRST_PRINCIPLES = "first_principles"
    VERIFICATION = "verification"
    AUTO = "auto"


@dataclass
class ReasoningResult:
    """Result of a reasoning operation."""
    answer: str
    strategy_used: str
    chain: Optional[ReasoningChain] = None
    confidence: float = 0.0
    duration_ms: float = 0.0
    alternatives: List[str] = None

    def __post_init__(self):
        if self.alternatives is None:
            self.alternatives = []

    def to_dict(self) -> Dict[str, Any]:
        return {
            "answer": self.answer,
            "strategy": self.strategy_used,
            "confidence": self.confidence,
            "duration_ms": round(self.duration_ms, 2),
            "chain": self.chain.to_dict() if self.chain else None,
            "alternatives": self.alternatives,
        }


# Strategy selection heuristics
MATH_KEYWORDS = {"calculate", "compute", "solve", "equation", "formula", "sum", "product", "integral"}
CODE_KEYWORDS = {"code", "program", "function", "implement", "algorithm", "debug", "fix"}
LOGIC_KEYWORDS = {"prove", "deduce", "infer", "implies", "therefore", "if", "given that"}
CREATIVE_KEYWORDS = {"imagine", "create", "design", "brainstorm", "invent", "story"}


class ReasoningPlanner:
    """
    Meta-reasoning planner that selects and executes reasoning strategies.

    Analyzes the input question to determine the best reasoning approach,
    then orchestrates execution through the appropriate engine.
    """

    def __init__(self, inference: Any = None):
        self._inference = inference
        self._cot = ChainOfThought(inference=inference)
        self._history: List[ReasoningResult] = []

    def reason(
        self,
        question: str,
        strategy: str = "auto",
        max_steps: int = 10,
        verify: bool = True,
        **kwargs,
    ) -> ReasoningResult:
        """
        Reason about a question using the best strategy.

        Args:
            question: Question to reason about
            strategy: Reasoning strategy ('auto' for automatic selection)
            max_steps: Maximum reasoning steps
            verify: Whether to verify reasoning

        Returns:
            ReasoningResult with answer and reasoning trace
        """
        start_time = time.time()

        # Select strategy
        if strategy == "auto":
            selected = self._select_strategy(question)
        else:
            selected = ReasoningStrategy(strategy)

        # Execute reasoning
        if selected == ReasoningStrategy.CHAIN_OF_THOUGHT:
            chain = self._cot.reason(question, max_steps=max_steps, verify=verify)
            result = ReasoningResult(
                answer=chain.conclusion,
                strategy_used=selected.value,
                chain=chain,
                confidence=chain.total_confidence,
            )
        elif selected == ReasoningStrategy.TREE_OF_THOUGHT:
            result = self._tree_of_thought(question, max_steps)
        elif selected == ReasoningStrategy.DECOMPOSITION:
            result = self._decomposition(question, max_steps)
        elif selected == ReasoningStrategy.FIRST_PRINCIPLES:
            result = self._first_principles(question)
        elif selected == ReasoningStrategy.ANALOGY:
            result = self._analogy(question)
        else:
            # Default to CoT
            chain = self._cot.reason(question, max_steps=max_steps, verify=verify)
            result = ReasoningResult(
                answer=chain.conclusion,
                strategy_used="chain_of_thought",
                chain=chain,
                confidence=chain.total_confidence,
            )

        result.duration_ms = (time.time() - start_time) * 1000
        self._history.append(result)
        return result

    def _select_strategy(self, question: str) -> ReasoningStrategy:
        """Automatically select the best reasoning strategy."""
        q_lower = question.lower()
        words = set(q_lower.split())

        if words & MATH_KEYWORDS:
            return ReasoningStrategy.CHAIN_OF_THOUGHT
        elif words & CODE_KEYWORDS:
            return ReasoningStrategy.DECOMPOSITION
        elif words & LOGIC_KEYWORDS:
            return ReasoningStrategy.FIRST_PRINCIPLES
        elif words & CREATIVE_KEYWORDS:
            return ReasoningStrategy.TREE_OF_THOUGHT
        elif len(question) > 200:
            return ReasoningStrategy.DECOMPOSITION
        else:
            return ReasoningStrategy.CHAIN_OF_THOUGHT

    def _tree_of_thought(self, question: str, max_branches: int = 3) -> ReasoningResult:
        """Tree-of-thought: explore multiple reasoning paths."""
        branches = []
        for i in range(min(max_branches, 3)):
            prompt = (
                f"Approach {i + 1} to solve: {question}\n"
                f"Think from a different angle than previous approaches.\n"
                f"Provide your reasoning and answer:"
            )
            output = self._generate(prompt)
            branches.append(output)

        # Select best branch
        best_prompt = (
            f"Question: {question}\n\n"
            f"Three approaches were considered:\n"
            + "\n".join(f"Approach {i+1}: {b[:300]}" for i, b in enumerate(branches))
            + "\n\nWhich approach gives the best answer? Provide the final answer:"
        )
        final = self._generate(best_prompt)

        return ReasoningResult(
            answer=final,
            strategy_used="tree_of_thought",
            confidence=0.8,
            alternatives=branches,
        )

    def _decomposition(self, question: str, max_parts: int = 5) -> ReasoningResult:
        """Decompose into sub-problems and solve each."""
        # Decompose
        prompt = f"Break this into {max_parts} sub-problems:\n{question}\n\nSub-problems:"
        parts = self._generate(prompt)

        # Solve
        solutions_prompt = (
            f"Original: {question}\nSub-problems: {parts}\n\n"
            f"Solve each and provide a unified answer:"
        )
        answer = self._generate(solutions_prompt)

        return ReasoningResult(
            answer=answer,
            strategy_used="decomposition",
            confidence=0.75,
        )

    def _first_principles(self, question: str) -> ReasoningResult:
        """Reason from first principles."""
        prompt = (
            f"Using first principles reasoning:\n"
            f"Question: {question}\n\n"
            f"1. What are the fundamental truths/axioms?\n"
            f"2. What can we derive from these?\n"
            f"3. What is the logical conclusion?\n\n"
            f"Reason step by step from basics:"
        )
        answer = self._generate(prompt)

        return ReasoningResult(
            answer=answer,
            strategy_used="first_principles",
            confidence=0.8,
        )

    def _analogy(self, question: str) -> ReasoningResult:
        """Reason by analogy."""
        prompt = (
            f"Find a good analogy to reason about:\n{question}\n\n"
            f"1. What is this similar to?\n"
            f"2. How does the analogy apply?\n"
            f"3. What answer does the analogy suggest?\n\n"
            f"Reason by analogy:"
        )
        answer = self._generate(prompt)

        return ReasoningResult(
            answer=answer,
            strategy_used="analogy",
            confidence=0.7,
        )

    def _generate(self, prompt: str) -> str:
        """Generate through inference engine."""
        if self._inference is None:
            return f"[Planner — no inference engine]\n{prompt}"
        if hasattr(self._inference, "generate"):
            result = self._inference.generate(prompt, max_tokens=1024, temperature=0.5)
            if hasattr(result, "text"):
                return result.text
            return str(result)
        return str(self._inference(prompt))

    def get_history(self) -> List[Dict[str, Any]]:
        """Get reasoning history."""
        return [r.to_dict() for r in self._history]
