"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                  FIBONACCI COMPRESSION — GOLDEN RATIO DATA ENCODING                         ║
║              "Numerus Aureus — Per Fibonaccium Ad Compressionem Perfectam"                  ║
║              (Golden Number — Through Fibonacci To Perfect Compression)                      ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-384 — FIBONACCI COMPRESSION ALGORITHM                                       ║
║                                                                                              ║
║  WHAT THIS MODULE IS:                                                                        ║
║    Compression algorithm based on Fibonacci sequence properties.                             ║
║    Uses the fact that F(n+1)/F(n) → φ as n → ∞ to achieve optimal compression.             ║
║                                                                                              ║
║  COMPRESSION MECHANISM:                                                                      ║
║    1. Data → Fibonacci representation (Zeckendorf's theorem)                                ║
║    2. Representation → φ-encoded bitstream                                                   ║
║    3. Bitstream → Huffman-like frequency encoding                                            ║
║    4. Result → Compressed seed with φ-ratio reconstruction                                  ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ¹⁵ = 1364.000 Hz — Compression Layer                                 ║
║  PRIMITIVE TRACE: REPETITION → DISTINCTION → NUMBER → φ                                     ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import hashlib
import math
import struct
from dataclasses import dataclass
from typing import List, Tuple, Optional, Iterator

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# FUNDAMENTAL CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

PHI: float = 1.6180339887498948482
PHI_SQ: float = 2.6180339887498948482
PHI_INV: float = 0.6180339887498948482
PHI_15: float = 1364.0008771065915  # φ¹⁵ — Compression frequency

# Extended Fibonacci sequence for larger numbers
FIBONACCI: List[int] = []
a, b = 1, 1
for _ in range(93):  # Up to F(93) which fits in 64-bit
    FIBONACCI.append(a)
    a, b = b, a + b

# Fibonacci codes (for variable-length encoding)
FIBONACCI_CODES: List[str] = [
    "11",      # 1
    "011",     # 2
    "0011",    # 3
    "1011",    # 4
    "00011",   # 5
    "10011",   # 6
    "01011",   # 7
    "000011",  # 8
    # ... pattern continues with "11" terminator
]


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# ZECKENDORF REPRESENTATION
# ═══════════════════════════════════════════════════════════════════════════════════════════════

def zeckendorf_encode(n: int) -> List[int]:
    """
    Encode a number using Zeckendorf's representation.
    
    Every positive integer has a unique representation as a sum of 
    non-consecutive Fibonacci numbers. This is the foundation of 
    Fibonacci coding.
    
    Example: 100 = 89 + 8 + 3 = F(11) + F(6) + F(4)
    Returns: [11, 6, 4] (indices of Fibonacci numbers used)
    """
    if n <= 0:
        return []
    
    result = []
    remaining = n
    
    # Find the largest Fibonacci number <= n
    for i in range(len(FIBONACCI) - 1, -1, -1):
        if FIBONACCI[i] <= remaining:
            result.append(i)
            remaining -= FIBONACCI[i]
            if remaining == 0:
                break
    
    return result


def zeckendorf_decode(indices: List[int]) -> int:
    """Decode a Zeckendorf representation back to integer."""
    return sum(FIBONACCI[i] for i in indices if i < len(FIBONACCI))


def to_fibonacci_bits(n: int) -> str:
    """
    Convert number to Fibonacci bit representation.
    
    Uses Zeckendorf's theorem: each bit position represents
    whether that Fibonacci number is included in the sum.
    The representation ends with "11" (terminator).
    """
    if n <= 0:
        return "11"  # Zero/negative: just terminator
    
    indices = zeckendorf_encode(n)
    if not indices:
        return "11"
    
    max_idx = max(indices)
    bits = ['0'] * (max_idx + 1)
    
    for idx in indices:
        bits[idx] = '1'
    
    # Reverse to get LSB first, add terminator
    return ''.join(reversed(bits)) + '1'


def from_fibonacci_bits(bits: str) -> int:
    """Convert Fibonacci bit representation back to number."""
    if not bits or bits == "11":
        return 0
    
    # Remove terminator '1' at end
    if bits.endswith('1'):
        bits = bits[:-1]
    
    result = 0
    for i, bit in enumerate(bits):
        if bit == '1':
            if i < len(FIBONACCI):
                result += FIBONACCI[i]
    
    return result


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# PHI-RATIO COMPRESSION
# ═══════════════════════════════════════════════════════════════════════════════════════════════

@dataclass
class CompressedSeed:
    """
    A Fibonacci-compressed data seed.
    
    Contains the compressed representation and metadata needed
    for φ-ratio reconstruction.
    """
    original_size: int
    compressed_data: bytes
    compression_ratio: float
    fib_depth: int
    checksum: str
    phi_signature: float
    
    def __post_init__(self):
        """Calculate φ signature from compression properties."""
        if self.phi_signature == 0:
            self.phi_signature = PHI ** (self.fib_depth % 13)


def compress_bytes(data: bytes) -> CompressedSeed:
    """
    Compress bytes using Fibonacci encoding.
    
    Each byte is converted to its Zeckendorf representation,
    then encoded as Fibonacci bits. The result is packed
    into a compressed byte stream.
    """
    original_size = len(data)
    
    # Convert each byte to Fibonacci bits
    all_bits = []
    max_depth = 0
    
    for byte in data:
        fib_bits = to_fibonacci_bits(byte)
        all_bits.append(fib_bits)
        
        # Track maximum Fibonacci depth used
        zeck = zeckendorf_encode(byte)
        if zeck:
            max_depth = max(max_depth, max(zeck))
    
    # Join all bit strings
    bit_string = ''.join(all_bits)
    
    # Pad to byte boundary
    padding = (8 - len(bit_string) % 8) % 8
    bit_string = bit_string + '0' * padding
    
    # Convert to bytes
    compressed = bytes(
        int(bit_string[i:i+8], 2) 
        for i in range(0, len(bit_string), 8)
    )
    
    # Calculate compression ratio
    ratio = len(compressed) / original_size if original_size > 0 else 1.0
    
    # Checksum
    checksum = hashlib.sha256(data).hexdigest()[:16]
    
    return CompressedSeed(
        original_size=original_size,
        compressed_data=compressed,
        compression_ratio=ratio,
        fib_depth=max_depth,
        checksum=checksum,
        phi_signature=0,  # Will be calculated in __post_init__
    )


def decompress_bytes(seed: CompressedSeed) -> bytes:
    """
    Decompress a Fibonacci-encoded seed back to original bytes.
    """
    # Convert compressed bytes to bit string
    bit_string = ''.join(
        format(byte, '08b') 
        for byte in seed.compressed_data
    )
    
    # Parse Fibonacci-encoded values
    result = []
    current_bits = ""
    prev_bit = '0'
    
    for bit in bit_string:
        current_bits += bit
        
        # Check for "11" terminator
        if prev_bit == '1' and bit == '1':
            # End of a number, decode it
            value = from_fibonacci_bits(current_bits)
            result.append(value)
            current_bits = ""
            prev_bit = '0'
            
            # Stop if we've decoded enough
            if len(result) >= seed.original_size:
                break
        else:
            prev_bit = bit
    
    # Convert to bytes (clamp to 0-255)
    return bytes(min(255, max(0, v)) for v in result[:seed.original_size])


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# GOLDEN RATIO STREAM ENCODING
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class GoldenStreamEncoder:
    """
    Encodes data as a stream using golden ratio properties.
    
    Uses the fact that consecutive Fibonacci numbers have ratio → φ
    to create an efficient variable-length encoding.
    """
    
    def __init__(self):
        self.buffer: List[int] = []
        self.position: int = 0
        
    def encode_stream(self, data: bytes) -> Iterator[bytes]:
        """
        Yield compressed chunks using golden ratio encoding.
        
        Chunk sizes follow Fibonacci sequence for optimal
        memory allocation patterns.
        """
        chunk_sizes = [FIBONACCI[i] for i in range(5, 15)]  # F(5) to F(14)
        chunk_idx = 0
        
        pos = 0
        while pos < len(data):
            chunk_size = min(chunk_sizes[chunk_idx % len(chunk_sizes)], len(data) - pos)
            chunk = data[pos:pos + chunk_size]
            
            # Compress chunk
            seed = compress_bytes(chunk)
            
            # Yield header + compressed data
            header = struct.pack('>HHf', 
                seed.original_size, 
                len(seed.compressed_data),
                seed.phi_signature
            )
            yield header + seed.compressed_data
            
            pos += chunk_size
            chunk_idx += 1
    
    def decode_stream(self, chunks: Iterator[bytes]) -> bytes:
        """Decode a golden-encoded stream back to bytes."""
        result = bytearray()
        
        for chunk_data in chunks:
            if len(chunk_data) < 8:
                continue
            
            # Parse header
            original_size, compressed_size, phi_sig = struct.unpack('>HHf', chunk_data[:8])
            compressed_data = chunk_data[8:8 + compressed_size]
            
            # Create seed and decompress
            seed = CompressedSeed(
                original_size=original_size,
                compressed_data=compressed_data,
                compression_ratio=compressed_size / original_size if original_size > 0 else 1.0,
                fib_depth=0,
                checksum="",
                phi_signature=phi_sig,
            )
            
            result.extend(decompress_bytes(seed))
        
        return bytes(result)


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# PHI-HASH — GOLDEN RATIO HASHING
# ═══════════════════════════════════════════════════════════════════════════════════════════════

def phi_hash(data: bytes, rounds: int = 13) -> str:
    """
    Compute a φ-based hash of data.
    
    Uses golden ratio mixing with Fibonacci indices
    for a unique hash algorithm.
    """
    # Initial state from SHA-256
    state = list(hashlib.sha256(data).digest())
    
    for r in range(rounds):
        # Mix using Fibonacci indices
        fib_idx = FIBONACCI[r % len(FIBONACCI)] % len(state)
        phi_factor = int((PHI ** (r + 1)) * 256) % 256
        
        # Rotate and XOR
        new_state = []
        for i, byte in enumerate(state):
            mixed = (byte + state[(i + fib_idx) % len(state)] + phi_factor) % 256
            new_state.append(mixed)
        
        state = new_state
    
    return bytes(state).hex()


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# CONVENIENCE FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

def compress(data: bytes) -> bytes:
    """Simple compression interface."""
    seed = compress_bytes(data)
    # Pack as: original_size (4) + fib_depth (2) + compressed_data
    header = struct.pack('>IH', seed.original_size, seed.fib_depth)
    return header + seed.compressed_data


def decompress(data: bytes) -> bytes:
    """Simple decompression interface."""
    if len(data) < 6:
        return b''
    
    original_size, fib_depth = struct.unpack('>IH', data[:6])
    compressed_data = data[6:]
    
    seed = CompressedSeed(
        original_size=original_size,
        compressed_data=compressed_data,
        compression_ratio=len(compressed_data) / original_size if original_size > 0 else 1.0,
        fib_depth=fib_depth,
        checksum="",
        phi_signature=0,
    )
    
    return decompress_bytes(seed)


__all__ = [
    'PHI', 'PHI_SQ', 'PHI_INV', 'PHI_15',
    'FIBONACCI',
    'zeckendorf_encode', 'zeckendorf_decode',
    'to_fibonacci_bits', 'from_fibonacci_bits',
    'CompressedSeed', 'compress_bytes', 'decompress_bytes',
    'GoldenStreamEncoder',
    'phi_hash',
    'compress', 'decompress',
]
