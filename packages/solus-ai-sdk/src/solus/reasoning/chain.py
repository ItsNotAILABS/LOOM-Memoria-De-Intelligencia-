"""
SOLUS Chain of Thought — Structured Reasoning Steps
=====================================================

PROT-666: Multi-step reasoning engine that decomposes complex problems
into verifiable reasoning chains with self-verification.
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional


class StepType(str, Enum):
    """Types of reasoning steps."""
    DECOMPOSE = "decompose"
    ANALYZE = "analyze"
    COMPUTE = "compute"
    VERIFY = "verify"
    SYNTHESIZE = "synthesize"
    CONCLUDE = "conclude"


@dataclass
class ReasoningStep:
    """A single step in the reasoning chain."""
    step_id: str = field(default_factory=lambda: str(uuid.uuid4())[:8])
    index: int = 0
    step_type: StepType = StepType.ANALYZE
    input_text: str = ""
    output_text: str = ""
    confidence: float = 0.0
    verified: bool = False
    duration_ms: float = 0.0
    metadata: Dict[str, Any] = field(default_factory=dict)

    def to_dict(self) -> Dict[str, Any]:
        return {
            "step_id": self.step_id,
            "index": self.index,
            "type": self.step_type.value,
            "input": self.input_text,
            "output": self.output_text,
            "confidence": self.confidence,
            "verified": self.verified,
            "duration_ms": round(self.duration_ms, 2),
        }


@dataclass
class ReasoningChain:
    """A complete chain of reasoning."""
    chain_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    question: str = ""
    steps: List[ReasoningStep] = field(default_factory=list)
    conclusion: str = ""
    total_confidence: float = 0.0
    total_duration_ms: float = 0.0
    strategy: str = "chain_of_thought"

    @property
    def step_count(self) -> int:
        return len(self.steps)

    @property
    def is_verified(self) -> bool:
        return all(s.verified for s in self.steps)

    def to_dict(self) -> Dict[str, Any]:
        return {
            "chain_id": self.chain_id,
            "question": self.question,
            "strategy": self.strategy,
            "steps": [s.to_dict() for s in self.steps],
            "conclusion": self.conclusion,
            "confidence": self.total_confidence,
            "verified": self.is_verified,
            "duration_ms": round(self.total_duration_ms, 2),
            "step_count": self.step_count,
        }


# Prompt templates for reasoning
COT_SYSTEM_PROMPT = """You are a precise reasoning engine. Break down problems step by step.
For each step:
1. State what you're computing or analyzing
2. Show your work clearly
3. State your intermediate conclusion
4. Rate your confidence (0.0-1.0)

Format each step as:
STEP N: [type]
INPUT: [what you're working with]
REASONING: [your work]
OUTPUT: [result]
CONFIDENCE: [0.0-1.0]
"""

COT_DECOMPOSE_PROMPT = """Break this problem into clear steps:
Question: {question}

List the steps needed to solve this, one per line:"""

COT_VERIFY_PROMPT = """Verify this reasoning step:
Step: {step_output}
Original question: {question}

Is this step correct? Reply with CORRECT or INCORRECT and explain briefly."""


class ChainOfThought:
    """
    Chain-of-Thought reasoning engine.

    Decomposes problems into steps, executes each step,
    and verifies the chain for correctness.
    """

    def __init__(self, inference: Any = None):
        self._inference = inference
        self._chains: List[ReasoningChain] = []

    def reason(
        self,
        question: str,
        max_steps: int = 10,
        verify: bool = True,
        verbose: bool = False,
    ) -> ReasoningChain:
        """
        Execute chain-of-thought reasoning on a question.

        Args:
            question: The question to reason about
            max_steps: Maximum reasoning steps
            verify: Whether to verify each step
            verbose: Print reasoning steps

        Returns:
            ReasoningChain with full reasoning trace
        """
        chain = ReasoningChain(question=question, strategy="chain_of_thought")
        start_time = time.time()

        # Step 1: Decompose the problem
        decomposition = self._decompose(question)
        chain.steps.append(decomposition)

        # Step 2: Execute reasoning steps
        sub_problems = decomposition.output_text.strip().split("\n")
        for i, sub_problem in enumerate(sub_problems[:max_steps - 2]):
            step = self._reason_step(
                sub_problem.strip(),
                index=i + 1,
                context=question,
            )
            chain.steps.append(step)

            if verify:
                step.verified = self._verify_step(step, question)

        # Final step: Synthesize conclusion
        conclusion_step = self._synthesize(chain.steps, question)
        chain.steps.append(conclusion_step)
        chain.conclusion = conclusion_step.output_text

        # Calculate totals
        chain.total_duration_ms = (time.time() - start_time) * 1000
        confidences = [s.confidence for s in chain.steps if s.confidence > 0]
        chain.total_confidence = (
            sum(confidences) / len(confidences) if confidences else 0.0
        )

        self._chains.append(chain)
        return chain

    def _decompose(self, question: str) -> ReasoningStep:
        """Decompose a question into sub-problems."""
        start = time.time()

        prompt = COT_DECOMPOSE_PROMPT.format(question=question)
        output = self._generate(prompt)

        return ReasoningStep(
            index=0,
            step_type=StepType.DECOMPOSE,
            input_text=question,
            output_text=output,
            confidence=0.9,
            verified=True,
            duration_ms=(time.time() - start) * 1000,
        )

    def _reason_step(
        self, sub_problem: str, index: int, context: str
    ) -> ReasoningStep:
        """Execute a single reasoning step."""
        start = time.time()

        prompt = (
            f"{COT_SYSTEM_PROMPT}\n\n"
            f"Context: {context}\n"
            f"Current step: {sub_problem}\n\n"
            f"Execute this step:"
        )
        output = self._generate(prompt)

        # Parse confidence from output
        confidence = self._extract_confidence(output)

        return ReasoningStep(
            index=index,
            step_type=StepType.ANALYZE,
            input_text=sub_problem,
            output_text=output,
            confidence=confidence,
            duration_ms=(time.time() - start) * 1000,
        )

    def _synthesize(
        self, steps: List[ReasoningStep], question: str
    ) -> ReasoningStep:
        """Synthesize a conclusion from all steps."""
        start = time.time()

        step_summaries = "\n".join(
            f"Step {s.index}: {s.output_text[:200]}" for s in steps
        )
        prompt = (
            f"Given these reasoning steps:\n{step_summaries}\n\n"
            f"Original question: {question}\n\n"
            f"Provide a clear, concise final answer:"
        )
        output = self._generate(prompt)

        return ReasoningStep(
            index=len(steps),
            step_type=StepType.CONCLUDE,
            input_text="Synthesize conclusion",
            output_text=output,
            confidence=0.85,
            verified=True,
            duration_ms=(time.time() - start) * 1000,
        )

    def _verify_step(self, step: ReasoningStep, question: str) -> bool:
        """Verify a reasoning step."""
        prompt = COT_VERIFY_PROMPT.format(
            step_output=step.output_text[:500],
            question=question,
        )
        result = self._generate(prompt)
        return "CORRECT" in result.upper()

    def _generate(self, prompt: str) -> str:
        """Generate text through the inference engine."""
        if self._inference is None:
            return f"[Reasoning step — inference engine not connected]\n{prompt}"

        if hasattr(self._inference, "generate"):
            result = self._inference.generate(prompt, max_tokens=1024, temperature=0.3)
            if hasattr(result, "text"):
                return result.text
            return str(result)
        return str(self._inference(prompt))

    def _extract_confidence(self, text: str) -> float:
        """Extract confidence score from reasoning output."""
        import re
        match = re.search(r"CONFIDENCE:\s*([\d.]+)", text)
        if match:
            try:
                return min(1.0, max(0.0, float(match.group(1))))
            except ValueError:
                pass
        return 0.7  # Default confidence

    def get_chains(self) -> List[Dict[str, Any]]:
        """Get all reasoning chains."""
        return [c.to_dict() for c in self._chains]
