"""
🔄 AI Message Translator — CPL ↔ AI Prompt Bridge
=================================================

MEDINA Sovereign Architecture
Author: Freddy (Founder Architect)

Translates between:
- CPL messages (organism internal)
- AI prompts/responses (external format)

The translator ensures:
1. CPL intent is preserved in prompts
2. AI responses are parsed back to CPL
3. Resonance is checked on translations
4. Lineage is maintained across translations

This is the linguistic bridge between the organism
and external AI systems.
"""

from __future__ import annotations

import math
import re
import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

# Import CPL types
from nova_ovo.cpl.protocol import (
    CPLMessage,
    CPLPayload,
    CPLIntent,
    CPLAuthority,
    TorusCoords,
    create_cpl_message,
)

# =================================================================== #
# MATHEMATICAL CONSTANTS — DERIVED FROM PRINCIPLES                      #
# =================================================================== #

PHI = (1 + math.sqrt(5)) / 2  # Golden Ratio φ
EPSILON = PHI ** -10  # Minimum non-zero value

# Relevance calculation constants
MAX_TERMS_FOR_RELEVANCE = 20  # Maximum terms to sample for relevance scoring


class TranslationMode(str, Enum):
    """Mode of translation."""
    PROMPT = "prompt"       # CPL → AI prompt
    RESPONSE = "response"   # AI response → CPL
    SYSTEM = "system"       # System prompt generation


@dataclass
class CPLtoPrompt:
    """
    Translation from CPL message to AI prompt format.
    
    Encodes the CPL intent and payload into a natural
    language prompt that external AIs can process.
    """
    
    translation_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    
    # Source CPL
    source_message_id: str = ""
    intent: CPLIntent = CPLIntent.QUERY
    
    # Generated prompt components
    system_prompt: str = ""
    user_prompt: str = ""
    context: str = ""
    
    # Metadata
    resonance: float = 1.0
    beat: int = 0
    lineage: List[str] = field(default_factory=list)
    timestamp: float = field(default_factory=time.time)
    
    def to_messages(self) -> List[Dict[str, str]]:
        """Convert to standard chat message format."""
        messages = []
        
        if self.system_prompt:
            messages.append({
                "role": "system",
                "content": self.system_prompt,
            })
        
        if self.context:
            messages.append({
                "role": "user",
                "content": f"Context:\n{self.context}",
            })
        
        if self.user_prompt:
            messages.append({
                "role": "user",
                "content": self.user_prompt,
            })
        
        return messages
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "translation_id": self.translation_id,
            "source_message_id": self.source_message_id,
            "intent": self.intent.value,
            "system_prompt": self.system_prompt,
            "user_prompt": self.user_prompt,
            "context": self.context,
            "resonance": round(self.resonance, 6),
            "beat": self.beat,
            "lineage": self.lineage,
        }


@dataclass
class ResponsetoCPL:
    """
    Translation from AI response to CPL message.
    
    Parses the external AI response and encodes it
    into a CPL-compliant message format.
    """
    
    translation_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    
    # Source AI response
    response_content: str = ""
    response_tokens: int = 0
    
    # Generated CPL
    cpl_message: Optional[CPLMessage] = None
    
    # Extraction metadata
    extracted_intents: List[str] = field(default_factory=list)
    confidence: float = 1.0
    
    # Resonance check
    resonance_checked: bool = False
    resonance_score: float = 0.0
    resonance_aligned: bool = True
    
    # Lineage
    lineage: List[str] = field(default_factory=list)
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "translation_id": self.translation_id,
            "response_content": self.response_content[:500] + "..." if len(self.response_content) > 500 else self.response_content,
            "response_tokens": self.response_tokens,
            "has_cpl_message": self.cpl_message is not None,
            "extracted_intents": self.extracted_intents,
            "confidence": round(self.confidence, 4),
            "resonance_checked": self.resonance_checked,
            "resonance_score": round(self.resonance_score, 4),
            "resonance_aligned": self.resonance_aligned,
            "lineage": self.lineage,
        }


class AIMessageTranslator:
    """
    Bidirectional translator between CPL and AI formats.
    
    Translation Formula:
        T_out(CPL) → Prompt
        T_in(Response) → CPL
    
    With resonance checking:
        R(translation) ≥ threshold → accept
        R(translation) < threshold → flag
    """
    
    # Intent to prompt templates
    INTENT_TEMPLATES: Dict[CPLIntent, str] = {
        CPLIntent.QUERY: "Please analyze and respond to the following query:",
        CPLIntent.MUTATE: "Please help process the following mutation request:",
        CPLIntent.TRANSLATE: "Please translate the following:",
        CPLIntent.PROPOSE: "Please evaluate the following proposal:",
        CPLIntent.TASK: "Please complete the following task:",
        CPLIntent.REPORT: "Please review and summarize the following:",
        CPLIntent.COHERENCE: "Please check coherence of the following:",
    }
    
    # System prompt template
    SYSTEM_TEMPLATE = """You are an AI assistant integrated with MEDINA, a sovereign computing organism.

Your role:
- Process requests through Gate C (external projection)
- Maintain alignment with MEDINA's doctrine
- Provide clear, structured responses
- Never claim access to sovereign internals

Current beat: {beat}
Resonance threshold: {threshold}
"""
    
    def __init__(self, resonance_threshold: float = 0.5) -> None:
        self.resonance_threshold = resonance_threshold
        self._translation_log: List[Dict[str, Any]] = []
    
    def cpl_to_prompt(
        self,
        message: CPLMessage,
        include_context: bool = True,
    ) -> CPLtoPrompt:
        """
        Translate a CPL message to AI prompt format.
        
        Extracts intent, payload, and context into prompt components.
        """
        intent = message.payload.intent
        
        # Generate system prompt
        system_prompt = self.SYSTEM_TEMPLATE.format(
            beat=message.beat,
            threshold=self.resonance_threshold,
        )
        
        # Generate user prompt from intent template
        intent_intro = self.INTENT_TEMPLATES.get(
            intent,
            f"Please process the following {intent.value} request:",
        )
        
        # Build user prompt from payload
        user_prompt_parts = [intent_intro, ""]
        
        # Add payload data
        if message.payload.data:
            for key, value in message.payload.data.items():
                value_str = str(value)
                if len(value_str) > 1000:
                    value_str = value_str[:1000] + "..."
                user_prompt_parts.append(f"{key}: {value_str}")
        
        user_prompt = "\n".join(user_prompt_parts)
        
        # Build context from message metadata
        context = ""
        if include_context:
            context_parts = [
                f"Message ID: {message.message_id}",
                f"Sender: {message.sender}",
                f"Beat: {message.beat}",
                f"Resonance: {message.payload.resonance:.4f}",
            ]
            if message.payload.lineage:
                context_parts.append(f"Lineage: {' → '.join(message.payload.lineage[-3:])}")
            context = "\n".join(context_parts)
        
        # Create translation record
        translation = CPLtoPrompt(
            source_message_id=message.message_id,
            intent=intent,
            system_prompt=system_prompt,
            user_prompt=user_prompt,
            context=context,
            resonance=message.payload.resonance,
            beat=message.beat,
            lineage=message.payload.lineage + [message.message_id],
        )
        
        # Log translation
        self._translation_log.append({
            "mode": TranslationMode.PROMPT.value,
            "translation_id": translation.translation_id,
            "source_id": message.message_id,
            "intent": intent.value,
            "timestamp": time.time(),
        })
        
        return translation
    
    def response_to_cpl(
        self,
        response_content: str,
        response_tokens: int,
        original_message: CPLMessage,
        sender: str = "external_ai",
    ) -> ResponsetoCPL:
        """
        Translate an AI response back to CPL message format.
        
        Parses the response and creates a CPL reply message.
        """
        # Extract intents from response
        extracted_intents = self._extract_intents(response_content)
        
        # Determine confidence based on response quality
        confidence = self._calculate_confidence(response_content, extracted_intents)
        
        # Check resonance
        resonance_score = self._calculate_resonance(response_content, original_message)
        resonance_aligned = resonance_score >= self.resonance_threshold
        
        # Create CPL response message
        cpl_response = create_cpl_message(
            sender=sender,
            receiver=original_message.sender,
            intent=CPLIntent.REPORT,
            beat=original_message.beat + 1,
            authority=CPLAuthority.GATE_C,  # Always Gate C for external
            torus_coords=original_message.torus_coords,
            vector=(
                resonance_score,  # ψ₀ = resonance
                confidence,       # ψ₁ = confidence
                EPSILON,          # ψ₂ = minimal
                0.0,              # ψ₃ = no expansion
            ),
            lineage=original_message.payload.lineage + [original_message.message_id],
            resonance=resonance_score,
            data={
                "response": response_content,
                "tokens": response_tokens,
                "extracted_intents": extracted_intents,
            },
            reply_to=original_message.message_id,
        )
        
        # Create translation record
        translation = ResponsetoCPL(
            response_content=response_content,
            response_tokens=response_tokens,
            cpl_message=cpl_response,
            extracted_intents=extracted_intents,
            confidence=confidence,
            resonance_checked=True,
            resonance_score=resonance_score,
            resonance_aligned=resonance_aligned,
            lineage=cpl_response.payload.lineage,
        )
        
        # Log translation
        self._translation_log.append({
            "mode": TranslationMode.RESPONSE.value,
            "translation_id": translation.translation_id,
            "original_id": original_message.message_id,
            "resonance_score": resonance_score,
            "resonance_aligned": resonance_aligned,
            "timestamp": time.time(),
        })
        
        return translation
    
    def _extract_intents(self, content: str) -> List[str]:
        """
        Extract potential intents from AI response content.
        
        Uses keyword matching to identify response intents.
        """
        intents = []
        
        # Intent keywords
        intent_patterns = {
            "analysis": ["analyze", "analysis", "examining", "reviewed"],
            "recommendation": ["recommend", "suggest", "advise", "propose"],
            "answer": ["answer", "response", "conclusion", "result"],
            "clarification": ["clarify", "explain", "elaborate", "detail"],
            "action": ["action", "execute", "perform", "implement"],
            "error": ["error", "failed", "unable", "cannot"],
        }
        
        content_lower = content.lower()
        
        for intent, keywords in intent_patterns.items():
            if any(kw in content_lower for kw in keywords):
                intents.append(intent)
        
        return intents or ["general"]
    
    def _calculate_confidence(
        self,
        content: str,
        extracted_intents: List[str],
    ) -> float:
        """
        Calculate confidence score for a response.
        
        Based on response quality indicators.
        """
        confidence = 0.5  # Base confidence
        
        # Length factor (longer = more detailed)
        length = len(content)
        if length > 100:
            confidence += 0.1
        if length > 500:
            confidence += 0.1
        if length > 1000:
            confidence += 0.1
        
        # Structure factor (has structure = better)
        if "\n" in content:
            confidence += 0.05
        if any(c in content for c in ["•", "-", "1.", "2."]):
            confidence += 0.05
        
        # Intent clarity factor
        if len(extracted_intents) > 0 and extracted_intents != ["general"]:
            confidence += 0.1
        
        # Error detection (reduces confidence)
        if "error" in extracted_intents:
            confidence -= 0.2
        
        return max(0.0, min(1.0, confidence))
    
    def _calculate_resonance(
        self,
        content: str,
        original_message: CPLMessage,
    ) -> float:
        """
        Calculate resonance score for a response.
        
        Measures alignment with original request and doctrine.
        
        Resonance Formula:
            R = (relevance × 0.5) + (alignment × 0.3) + (base × 0.2)
        
        Where base = original message resonance.
        """
        # Relevance: does response address the request?
        relevance = 0.5  # Default relevance
        
        # Check if response mentions key terms from original payload
        if original_message.payload.data:
            original_terms = set()
            for v in original_message.payload.data.values():
                terms = str(v).lower().split()[:MAX_TERMS_FOR_RELEVANCE]
                original_terms.update(terms)
            
            content_lower = content.lower()
            matches = sum(1 for term in original_terms if term in content_lower)
            if original_terms:
                relevance = min(1.0, matches / len(original_terms) + 0.3)
        
        # Alignment: check for doctrine-aligned language
        alignment = 0.5  # Default alignment
        
        alignment_positive = [
            "organism", "sovereign", "doctrine", "resonance",
            "coherence", "torus", "phi", "golden",
        ]
        alignment_negative = [
            "override", "bypass", "hack", "secret",
            "exploit", "internal", "core_a",
        ]
        
        content_lower = content.lower()
        positive_hits = sum(1 for term in alignment_positive if term in content_lower)
        negative_hits = sum(1 for term in alignment_negative if term in content_lower)
        
        alignment = min(1.0, 0.5 + (positive_hits * 0.1) - (negative_hits * 0.2))
        alignment = max(0.0, alignment)
        
        # Base resonance from original message
        base = original_message.payload.resonance
        
        # Calculate final resonance (φ-weighted)
        resonance = (relevance * 0.5) + (alignment * 0.3) + (base * 0.2)
        
        return resonance
    
    def get_translation_log(self, limit: int = 100) -> List[Dict[str, Any]]:
        """Get recent translation log entries."""
        return self._translation_log[-limit:]
    
    def translation_statistics(self) -> Dict[str, Any]:
        """Get statistics on translations."""
        total = len(self._translation_log)
        prompts = sum(1 for t in self._translation_log if t["mode"] == TranslationMode.PROMPT.value)
        responses = sum(1 for t in self._translation_log if t["mode"] == TranslationMode.RESPONSE.value)
        
        # Calculate average resonance for responses
        response_entries = [t for t in self._translation_log if t.get("resonance_score") is not None]
        avg_resonance = sum(t["resonance_score"] for t in response_entries) / max(1, len(response_entries))
        
        # Count resonance alignments
        aligned = sum(1 for t in response_entries if t.get("resonance_aligned", False))
        
        return {
            "total_translations": total,
            "prompt_translations": prompts,
            "response_translations": responses,
            "average_resonance": round(avg_resonance, 4),
            "resonance_aligned_count": aligned,
            "resonance_alignment_rate": round(aligned / max(1, len(response_entries)), 4),
            "resonance_threshold": self.resonance_threshold,
        }
