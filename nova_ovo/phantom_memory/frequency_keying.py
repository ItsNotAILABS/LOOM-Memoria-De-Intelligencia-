"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                  FREQUENCY KEYING — SCHUMANN + SOLFEGGIO ENCRYPTION                         ║
║              "Clavis Frequentiae — Per Resonantiam Ad Securitatem"                          ║
║              (Frequency Key — Through Resonance To Security)                                 ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-385 — FREQUENCY KEYING ENCRYPTION                                           ║
║                                                                                              ║
║  WHAT THIS MODULE IS:                                                                        ║
║    Encryption system based on natural frequency constants:                                   ║
║    - Schumann resonance (7.83 Hz) — Earth's electromagnetic heartbeat                       ║
║    - Solfeggio frequencies — Ancient healing tones                                           ║
║    - Golden ratio (φ) — Universal scaling constant                                           ║
║                                                                                              ║
║  KEYING MECHANISM:                                                                           ║
║    key = SCHUMANN × SOLFEGGIO[beat mod 9] × φ^ring                                          ║
║    The key is NEVER stored — derived on-demand from physical constants.                      ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ¹⁶ = 2207.000 Hz — Encryption Layer                                  ║
║  PRIMITIVE TRACE: FIELD → DISTINCTION → RELATION → φ                                        ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import hashlib
import hmac
import math
import os
import struct
import time
from dataclasses import dataclass
from enum import Enum
from typing import List, Tuple, Optional

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# FUNDAMENTAL CONSTANTS — THE GROUND OF ALL ENCRYPTION
# ═══════════════════════════════════════════════════════════════════════════════════════════════

PHI: float = 1.6180339887498948482
PHI_SQ: float = 2.6180339887498948482
PHI_INV: float = 0.6180339887498948482
PHI_16: float = 2207.0003956874326  # φ¹⁶ — Encryption frequency

# Schumann resonance — Earth's electromagnetic heartbeat
SCHUMANN: float = 7.83

# Solfeggio frequencies — Ancient healing/sacred tones
SOLFEGGIO: List[float] = [
    174.0,   # Ut — Foundation
    285.0,   # Re — Healing
    396.0,   # Mi — Liberation
    417.0,   # Fa — Change
    528.0,   # Sol — Miracles (DNA repair frequency)
    639.0,   # La — Connection
    741.0,   # Si — Awakening
    852.0,   # Ti — Intuition
    963.0,   # Do — Transcendence
]

# Extended Solfeggio (with additional sacred frequencies)
SOLFEGGIO_EXTENDED: List[float] = [
    *SOLFEGGIO,
    432.0,   # Verdi's A — Universal tuning
    440.0,   # Concert A — Modern standard
    444.0,   # Healing A — 12 Hz above 432
    111.0,   # Cell regeneration
    222.0,   # Harmony
    333.0,   # Christ consciousness
    555.0,   # Transformation
    666.0,   # Carbon (6 protons, 6 neutrons, 6 electrons)
    777.0,   # Divine completion
    888.0,   # Abundance
    999.0,   # Completion
]


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# KEY DERIVATION MODES
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class KeyMode(str, Enum):
    """Modes for frequency key derivation."""
    TEMPORAL = "temporal"      # Time-based (beat/ring derived from timestamp)
    FIXED = "fixed"           # Fixed beat/ring (for reproducible keys)
    RESONANT = "resonant"     # Frequency-matched (derives from content)
    HARMONIC = "harmonic"     # Uses full Solfeggio stack
    QUANTUM = "quantum"       # Superposition of multiple keys


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# FREQUENCY KEY — THE CORE ENCRYPTION UNIT
# ═══════════════════════════════════════════════════════════════════════════════════════════════

@dataclass
class FrequencyKey:
    """
    A frequency-derived encryption key.
    
    The key is computed from natural constants and never stored.
    The same beat/ring will always produce the same key.
    """
    frequency: float
    beat: int
    ring: int
    mode: KeyMode
    schumann_component: float
    solfeggio_component: float
    phi_component: float
    key_bytes: bytes
    nonce: bytes
    
    @classmethod
    def derive(
        cls,
        beat: Optional[int] = None,
        ring: Optional[int] = None,
        mode: KeyMode = KeyMode.TEMPORAL,
        salt: Optional[bytes] = None,
    ) -> 'FrequencyKey':
        """
        Derive a frequency key from natural constants.
        
        Args:
            beat: Time position (0-999), auto-derived if None
            ring: Ring position (0-12), auto-derived if None
            mode: Key derivation mode
            salt: Optional salt for additional entropy
        """
        # Derive beat and ring from time if not provided
        if beat is None:
            beat = int(time.time() * 1000) % 1000
        if ring is None:
            ring = int(time.time() / 100) % 13
        
        # Calculate frequency components
        schumann_component = SCHUMANN
        solfeggio_component = SOLFEGGIO[beat % 9]
        phi_component = math.pow(PHI, ring)
        
        # Combined frequency
        frequency = schumann_component * solfeggio_component * phi_component
        
        # Generate key material
        freq_bytes = struct.pack('>ddd', frequency, schumann_component, solfeggio_component)
        beat_bytes = struct.pack('>II', beat, ring)
        
        # Add salt if provided
        if salt:
            freq_bytes = freq_bytes + salt
        
        # Derive key bytes using HKDF-like expansion
        key_material = hashlib.sha256(freq_bytes + beat_bytes).digest()
        nonce = hashlib.sha256(beat_bytes + freq_bytes).digest()[:12]
        
        return cls(
            frequency=frequency,
            beat=beat,
            ring=ring,
            mode=mode,
            schumann_component=schumann_component,
            solfeggio_component=solfeggio_component,
            phi_component=phi_component,
            key_bytes=key_material,
            nonce=nonce,
        )
    
    @classmethod
    def from_content(cls, content: bytes) -> 'FrequencyKey':
        """Derive a resonant key from content itself."""
        content_hash = hashlib.sha256(content).digest()
        beat = int.from_bytes(content_hash[:2], 'big') % 1000
        ring = int.from_bytes(content_hash[2:4], 'big') % 13
        
        return cls.derive(beat=beat, ring=ring, mode=KeyMode.RESONANT, salt=content_hash)
    
    def encrypt(self, plaintext: bytes) -> bytes:
        """
        Encrypt data using frequency-keyed XOR with rotation.
        
        Uses a simple but effective stream cipher approach:
        - XOR with expanded key stream
        - Rotate bytes by Fibonacci amount
        """
        # Expand key to match plaintext length
        key_stream = self._expand_key(len(plaintext))
        
        # XOR encryption
        encrypted = bytes(p ^ k for p, k in zip(plaintext, key_stream))
        
        # Fibonacci rotation
        fib_amount = [1, 1, 2, 3, 5, 8, 13][self.beat % 7]
        rotated = self._rotate_bytes(encrypted, fib_amount)
        
        return rotated
    
    def decrypt(self, ciphertext: bytes) -> bytes:
        """Decrypt data (reverse of encrypt)."""
        # Reverse Fibonacci rotation
        fib_amount = [1, 1, 2, 3, 5, 8, 13][self.beat % 7]
        unrotated = self._rotate_bytes(ciphertext, -fib_amount)
        
        # XOR decryption (same as encryption)
        key_stream = self._expand_key(len(unrotated))
        decrypted = bytes(c ^ k for c, k in zip(unrotated, key_stream))
        
        return decrypted
    
    def _expand_key(self, length: int) -> bytes:
        """Expand key to required length using φ-based PRNG."""
        expanded = bytearray()
        state = list(self.key_bytes)
        
        while len(expanded) < length:
            # Mix state using φ
            for i in range(len(state)):
                phi_mix = int(PHI * (i + 1) * 256) % 256
                state[i] = (state[i] + phi_mix + state[(i + 1) % len(state)]) % 256
            
            expanded.extend(state)
        
        return bytes(expanded[:length])
    
    def _rotate_bytes(self, data: bytes, amount: int) -> bytes:
        """Rotate byte array by amount (circular shift)."""
        if not data or amount == 0:
            return data
        
        amount = amount % len(data)
        return data[amount:] + data[:amount]
    
    @property
    def frequency_signature(self) -> str:
        """Get a string signature of the frequency parameters."""
        return f"{self.frequency:.6f}Hz|B{self.beat}|R{self.ring}"


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# HARMONIC KEY STACK — MULTIPLE FREQUENCY LAYERS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class HarmonicKeyStack:
    """
    A stack of frequency keys for layered encryption.
    
    Uses all 9 Solfeggio frequencies for 9-layer encryption.
    Each layer adds another frequency component.
    """
    
    def __init__(self, base_beat: int, base_ring: int):
        self.base_beat = base_beat
        self.base_ring = base_ring
        self.keys: List[FrequencyKey] = []
        
        # Generate a key for each Solfeggio frequency
        for i, solfeggio in enumerate(SOLFEGGIO):
            # Each key uses a different ring position
            ring = (base_ring + i) % 13
            beat = (base_beat + int(solfeggio)) % 1000
            
            key = FrequencyKey.derive(
                beat=beat,
                ring=ring,
                mode=KeyMode.HARMONIC,
            )
            self.keys.append(key)
    
    def encrypt_layered(self, plaintext: bytes) -> bytes:
        """Encrypt through all 9 Solfeggio layers."""
        data = plaintext
        for key in self.keys:
            data = key.encrypt(data)
        return data
    
    def decrypt_layered(self, ciphertext: bytes) -> bytes:
        """Decrypt through all 9 Solfeggio layers (reverse order)."""
        data = ciphertext
        for key in reversed(self.keys):
            data = key.decrypt(data)
        return data
    
    @property
    def combined_frequency(self) -> float:
        """Get the combined harmonic frequency."""
        return sum(k.frequency for k in self.keys)


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# CONVENIENCE FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

def frequency_encrypt(
    plaintext: bytes,
    beat: Optional[int] = None,
    ring: Optional[int] = None,
) -> Tuple[bytes, FrequencyKey]:
    """
    Encrypt data using frequency keying.
    
    Returns the ciphertext and the key used (for later decryption).
    """
    key = FrequencyKey.derive(beat=beat, ring=ring)
    ciphertext = key.encrypt(plaintext)
    return ciphertext, key


def frequency_decrypt(
    ciphertext: bytes,
    beat: int,
    ring: int,
) -> bytes:
    """
    Decrypt data using frequency keying.
    
    Requires the same beat/ring used for encryption.
    """
    key = FrequencyKey.derive(beat=beat, ring=ring, mode=KeyMode.FIXED)
    return key.decrypt(ciphertext)


def content_encrypt(content: bytes) -> Tuple[bytes, int, int]:
    """
    Encrypt content using content-derived key.
    
    The beat/ring are derived from the content itself,
    so only the content hash is needed for decryption.
    """
    key = FrequencyKey.from_content(content)
    ciphertext = key.encrypt(content)
    return ciphertext, key.beat, key.ring


def harmonic_encrypt(plaintext: bytes, beat: int = 0, ring: int = 0) -> bytes:
    """Encrypt with full 9-layer Solfeggio stack."""
    stack = HarmonicKeyStack(beat, ring)
    return stack.encrypt_layered(plaintext)


def harmonic_decrypt(ciphertext: bytes, beat: int = 0, ring: int = 0) -> bytes:
    """Decrypt from full 9-layer Solfeggio stack."""
    stack = HarmonicKeyStack(beat, ring)
    return stack.decrypt_layered(ciphertext)


__all__ = [
    'PHI', 'PHI_SQ', 'PHI_INV', 'PHI_16',
    'SCHUMANN', 'SOLFEGGIO', 'SOLFEGGIO_EXTENDED',
    'KeyMode', 'FrequencyKey', 'HarmonicKeyStack',
    'frequency_encrypt', 'frequency_decrypt',
    'content_encrypt',
    'harmonic_encrypt', 'harmonic_decrypt',
]
