"""
╔══════════════════════════════════════════════════════════════════════════════════╗
║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                          ║
║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA            ║
║  ALL RIGHTS RESERVED.                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════╝

SVA BOUNDARY GENERATOR — PROTO-SVA-AUTE-002 Boundary Discovery Protocol
========================================================================

PROT-405: Boundary Generation System

Continuously challenge targets with edge cases and malformed inputs.

Boundary classes:
    - null
    - undefined
    - empty string
    - empty array
    - empty object
    - negative values
    - zero
    - max integer
    - precision edge cases
    - special characters
    - Unicode edge cases
    - large payloads
    - malformed schema
    - adversarial values

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
"""

from __future__ import annotations

import math
import random
import string
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any


# ═══════════════════════════════════════════════════════════════════════════════
# BOUNDARY CLASSES
# ═══════════════════════════════════════════════════════════════════════════════

class BoundaryClass(Enum):
    """Classification of boundary values."""
    NULL = "null"
    UNDEFINED = "undefined"
    EMPTY_STRING = "empty_string"
    EMPTY_ARRAY = "empty_array"
    EMPTY_OBJECT = "empty_object"
    NEGATIVE = "negative"
    ZERO = "zero"
    MAX_INT = "max_int"
    MIN_INT = "min_int"
    PRECISION = "precision"
    SPECIAL_CHARS = "special_chars"
    UNICODE = "unicode"
    LARGE_PAYLOAD = "large_payload"
    MALFORMED = "malformed"
    ADVERSARIAL = "adversarial"
    INJECTION = "injection"
    OVERFLOW = "overflow"
    UNDERFLOW = "underflow"
    NAN = "nan"
    INFINITY = "infinity"


# ═══════════════════════════════════════════════════════════════════════════════
# BOUNDARY VALUE
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class BoundaryValue:
    """
    A generated boundary value for testing.
    """
    value_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    boundary_class: BoundaryClass = BoundaryClass.NULL
    value: Any = None
    description: str = ""
    target_type: str = ""  # "string" | "number" | "array" | "object" | "any"
    severity: str = "medium"  # "low" | "medium" | "high" | "critical"
    
    def to_dict(self) -> dict:
        """Convert to dictionary for serialization."""
        return {
            "value_id": self.value_id,
            "boundary_class": self.boundary_class.value,
            "value": self.value,
            "description": self.description,
            "target_type": self.target_type,
            "severity": self.severity,
        }


# ═══════════════════════════════════════════════════════════════════════════════
# BOUNDARY GENERATOR
# ═══════════════════════════════════════════════════════════════════════════════

class BoundaryGenerator:
    """
    AUTE Boundary Discovery Engine.
    
    PROTO-SVA-AUTE-002: Boundary Discovery Protocol
    
    Generates boundary values to challenge target capabilities.
    """
    
    # Maximum integer values
    MAX_INT_32 = 2147483647
    MIN_INT_32 = -2147483648
    MAX_INT_64 = 9223372036854775807
    MIN_INT_64 = -9223372036854775808
    
    # Common injection payloads
    SQL_INJECTION_PAYLOADS = [
        "'; DROP TABLE users; --",
        "1' OR '1'='1",
        "1; SELECT * FROM users",
        "' UNION SELECT * FROM passwords --",
        "admin'--",
    ]
    
    XSS_PAYLOADS = [
        "<script>alert('xss')</script>",
        "<img src=x onerror=alert('xss')>",
        "javascript:alert('xss')",
        "<svg onload=alert('xss')>",
        "'-alert('xss')-'",
    ]
    
    PATH_TRAVERSAL_PAYLOADS = [
        "../../../etc/passwd",
        "..\\..\\..\\windows\\system32\\config\\sam",
        "....//....//....//etc/passwd",
        "%2e%2e%2f%2e%2e%2f%2e%2e%2fetc%2fpasswd",
    ]
    
    COMMAND_INJECTION_PAYLOADS = [
        "; ls -la",
        "| cat /etc/passwd",
        "$(whoami)",
        "`id`",
        "&& rm -rf /",
    ]
    
    # Unicode edge cases
    UNICODE_EDGE_CASES = [
        "\u0000",  # Null character
        "\u200B",  # Zero-width space
        "\u200D",  # Zero-width joiner
        "\uFEFF",  # BOM
        "\u202E",  # Right-to-left override
        "𝕳𝖊𝖑𝖑𝖔",  # Mathematical bold fraktur
        "🏳️‍🌈",   # Flag with ZWJ sequence
        "👨‍👩‍👧‍👦",  # Family emoji
        "\uD800",  # Lone surrogate (invalid)
    ]
    
    # Special characters
    SPECIAL_CHARS = [
        "\n", "\r", "\t", "\0",
        "\\", "/", "\"", "'",
        "<", ">", "&", "|",
        ";", ":", "$", "`",
        "(", ")", "[", "]",
        "{", "}", "!", "@",
        "#", "%", "^", "*",
    ]
    
    def __init__(self, seed: int | None = None):
        """Initialize with optional random seed for reproducibility."""
        self.rng = random.Random(seed)
    
    # ── Null/Empty Boundaries ─────────────────────────────────────────────────
    
    def generate_null_boundaries(self) -> list[BoundaryValue]:
        """Generate null and undefined boundary values."""
        return [
            BoundaryValue(
                boundary_class=BoundaryClass.NULL,
                value=None,
                description="Python None / null",
                target_type="any",
                severity="high",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.EMPTY_STRING,
                value="",
                description="Empty string",
                target_type="string",
                severity="medium",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.EMPTY_ARRAY,
                value=[],
                description="Empty array/list",
                target_type="array",
                severity="medium",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.EMPTY_OBJECT,
                value={},
                description="Empty object/dict",
                target_type="object",
                severity="medium",
            ),
        ]
    
    # ── Numeric Boundaries ────────────────────────────────────────────────────
    
    def generate_numeric_boundaries(self) -> list[BoundaryValue]:
        """Generate numeric edge case boundary values."""
        return [
            BoundaryValue(
                boundary_class=BoundaryClass.ZERO,
                value=0,
                description="Zero",
                target_type="number",
                severity="medium",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.ZERO,
                value=0.0,
                description="Zero float",
                target_type="number",
                severity="medium",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.NEGATIVE,
                value=-1,
                description="Negative one",
                target_type="number",
                severity="medium",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.MAX_INT,
                value=self.MAX_INT_32,
                description="Max 32-bit signed int",
                target_type="number",
                severity="high",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.MIN_INT,
                value=self.MIN_INT_32,
                description="Min 32-bit signed int",
                target_type="number",
                severity="high",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.MAX_INT,
                value=self.MAX_INT_64,
                description="Max 64-bit signed int",
                target_type="number",
                severity="high",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.MIN_INT,
                value=self.MIN_INT_64,
                description="Min 64-bit signed int",
                target_type="number",
                severity="high",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.OVERFLOW,
                value=self.MAX_INT_64 + 1,
                description="64-bit overflow",
                target_type="number",
                severity="critical",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.UNDERFLOW,
                value=self.MIN_INT_64 - 1,
                description="64-bit underflow",
                target_type="number",
                severity="critical",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.NAN,
                value=float('nan'),
                description="Not a Number",
                target_type="number",
                severity="high",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.INFINITY,
                value=float('inf'),
                description="Positive infinity",
                target_type="number",
                severity="high",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.INFINITY,
                value=float('-inf'),
                description="Negative infinity",
                target_type="number",
                severity="high",
            ),
        ]
    
    def generate_precision_boundaries(self) -> list[BoundaryValue]:
        """Generate floating-point precision edge cases."""
        return [
            BoundaryValue(
                boundary_class=BoundaryClass.PRECISION,
                value=0.1 + 0.2,  # Famous floating point issue
                description="0.1 + 0.2 precision test",
                target_type="number",
                severity="medium",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.PRECISION,
                value=1e-308,
                description="Near minimum positive float",
                target_type="number",
                severity="high",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.PRECISION,
                value=1e308,
                description="Near maximum positive float",
                target_type="number",
                severity="high",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.PRECISION,
                value=math.pi,
                description="Pi (irrational number)",
                target_type="number",
                severity="low",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.PRECISION,
                value=1.6180339887498948482,  # φ
                description="Golden ratio (phi)",
                target_type="number",
                severity="low",
            ),
        ]
    
    # ── String Boundaries ─────────────────────────────────────────────────────
    
    def generate_string_boundaries(self) -> list[BoundaryValue]:
        """Generate string edge case boundary values."""
        boundaries = [
            BoundaryValue(
                boundary_class=BoundaryClass.EMPTY_STRING,
                value="",
                description="Empty string",
                target_type="string",
                severity="medium",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.SPECIAL_CHARS,
                value=" ",
                description="Single space",
                target_type="string",
                severity="low",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.SPECIAL_CHARS,
                value="   ",
                description="Multiple spaces",
                target_type="string",
                severity="low",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.SPECIAL_CHARS,
                value="\t\n\r",
                description="Whitespace characters",
                target_type="string",
                severity="medium",
            ),
        ]
        
        # Add special characters
        for char in self.SPECIAL_CHARS:
            boundaries.append(BoundaryValue(
                boundary_class=BoundaryClass.SPECIAL_CHARS,
                value=char,
                description=f"Special char: {repr(char)}",
                target_type="string",
                severity="medium",
            ))
        
        return boundaries
    
    def generate_unicode_boundaries(self) -> list[BoundaryValue]:
        """Generate Unicode edge case boundary values."""
        boundaries = []
        for i, char in enumerate(self.UNICODE_EDGE_CASES):
            boundaries.append(BoundaryValue(
                boundary_class=BoundaryClass.UNICODE,
                value=char,
                description=f"Unicode edge case #{i}",
                target_type="string",
                severity="high",
            ))
        return boundaries
    
    def generate_large_string(self, size: int = 10000) -> BoundaryValue:
        """Generate a large string payload."""
        value = "A" * size
        return BoundaryValue(
            boundary_class=BoundaryClass.LARGE_PAYLOAD,
            value=value,
            description=f"Large string ({size} chars)",
            target_type="string",
            severity="high",
        )
    
    # ── Injection Boundaries ──────────────────────────────────────────────────
    
    def generate_sql_injection_boundaries(self) -> list[BoundaryValue]:
        """Generate SQL injection payloads."""
        return [
            BoundaryValue(
                boundary_class=BoundaryClass.INJECTION,
                value=payload,
                description="SQL injection payload",
                target_type="string",
                severity="critical",
            )
            for payload in self.SQL_INJECTION_PAYLOADS
        ]
    
    def generate_xss_boundaries(self) -> list[BoundaryValue]:
        """Generate XSS payloads."""
        return [
            BoundaryValue(
                boundary_class=BoundaryClass.INJECTION,
                value=payload,
                description="XSS payload",
                target_type="string",
                severity="critical",
            )
            for payload in self.XSS_PAYLOADS
        ]
    
    def generate_path_traversal_boundaries(self) -> list[BoundaryValue]:
        """Generate path traversal payloads."""
        return [
            BoundaryValue(
                boundary_class=BoundaryClass.INJECTION,
                value=payload,
                description="Path traversal payload",
                target_type="string",
                severity="critical",
            )
            for payload in self.PATH_TRAVERSAL_PAYLOADS
        ]
    
    def generate_command_injection_boundaries(self) -> list[BoundaryValue]:
        """Generate command injection payloads."""
        return [
            BoundaryValue(
                boundary_class=BoundaryClass.INJECTION,
                value=payload,
                description="Command injection payload",
                target_type="string",
                severity="critical",
            )
            for payload in self.COMMAND_INJECTION_PAYLOADS
        ]
    
    # ── Array/Object Boundaries ───────────────────────────────────────────────
    
    def generate_array_boundaries(self) -> list[BoundaryValue]:
        """Generate array edge case boundary values."""
        return [
            BoundaryValue(
                boundary_class=BoundaryClass.EMPTY_ARRAY,
                value=[],
                description="Empty array",
                target_type="array",
                severity="medium",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.MALFORMED,
                value=[None],
                description="Array with null",
                target_type="array",
                severity="medium",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.LARGE_PAYLOAD,
                value=list(range(10000)),
                description="Large array (10k elements)",
                target_type="array",
                severity="high",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.MALFORMED,
                value=[1, "two", 3.0, None, [], {}],
                description="Mixed type array",
                target_type="array",
                severity="medium",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.MALFORMED,
                value=[[[[[[[[[[]]]]]]]]],
                description="Deeply nested array",
                target_type="array",
                severity="high",
            ),
        ]
    
    def generate_object_boundaries(self) -> list[BoundaryValue]:
        """Generate object edge case boundary values."""
        return [
            BoundaryValue(
                boundary_class=BoundaryClass.EMPTY_OBJECT,
                value={},
                description="Empty object",
                target_type="object",
                severity="medium",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.MALFORMED,
                value={"": "empty key"},
                description="Object with empty key",
                target_type="object",
                severity="medium",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.MALFORMED,
                value={" ": "space key"},
                description="Object with space key",
                target_type="object",
                severity="medium",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.MALFORMED,
                value={"a": {"b": {"c": {"d": {"e": {"f": {}}}}}}},
                description="Deeply nested object",
                target_type="object",
                severity="high",
            ),
            BoundaryValue(
                boundary_class=BoundaryClass.LARGE_PAYLOAD,
                value={f"key_{i}": i for i in range(1000)},
                description="Large object (1k keys)",
                target_type="object",
                severity="high",
            ),
        ]
    
    # ── Combined Generation ───────────────────────────────────────────────────
    
    def generate_all_boundaries(self) -> list[BoundaryValue]:
        """Generate all boundary values."""
        boundaries = []
        boundaries.extend(self.generate_null_boundaries())
        boundaries.extend(self.generate_numeric_boundaries())
        boundaries.extend(self.generate_precision_boundaries())
        boundaries.extend(self.generate_string_boundaries())
        boundaries.extend(self.generate_unicode_boundaries())
        boundaries.extend(self.generate_array_boundaries())
        boundaries.extend(self.generate_object_boundaries())
        return boundaries
    
    def generate_security_boundaries(self) -> list[BoundaryValue]:
        """Generate security-focused boundary values."""
        boundaries = []
        boundaries.extend(self.generate_sql_injection_boundaries())
        boundaries.extend(self.generate_xss_boundaries())
        boundaries.extend(self.generate_path_traversal_boundaries())
        boundaries.extend(self.generate_command_injection_boundaries())
        return boundaries
    
    def generate_for_type(self, target_type: str) -> list[BoundaryValue]:
        """Generate boundaries for a specific type."""
        if target_type == "string":
            return (
                self.generate_string_boundaries() +
                self.generate_unicode_boundaries() +
                [self.generate_large_string()]
            )
        elif target_type == "number":
            return (
                self.generate_numeric_boundaries() +
                self.generate_precision_boundaries()
            )
        elif target_type == "array":
            return self.generate_array_boundaries()
        elif target_type == "object":
            return self.generate_object_boundaries()
        else:
            return self.generate_all_boundaries()
    
    def generate_random_boundaries(self, count: int = 10) -> list[BoundaryValue]:
        """Generate a random selection of boundary values."""
        all_boundaries = self.generate_all_boundaries()
        if count >= len(all_boundaries):
            return all_boundaries
        return self.rng.sample(all_boundaries, count)
