"""
Kernel Compression System — Compressed Symbolic Intelligence
=============================================================
The kernel is the compressed symbolic representation of a document's
full intelligence. When a document is written, its content is compressed
into a kernel symbol that holds everything. When the kernel is called,
it expands back to the complete document and re-executes.

Core Concepts:
- KernelSymbol: The compressed intelligence payload + metadata + integrity hash
- KernelCompressor: Compress full documents to kernel symbols
- KernelExpander: Expand kernel symbols back to full intelligence
- KernelExecutor: Re-execute expanded kernels in context

The symbol holds everything. The organism reads the symbol and knows
everything behind it.
"""

from .symbol import (
    KernelSymbol,
    KernelMetadata,
    KernelIntegrity,
    CompressionLevel,
)
from .compressor import (
    KernelCompressor,
    CompressionResult,
    CompressionStrategy,
)
from .expander import (
    KernelExpander,
    ExpansionResult,
    ExpansionContext,
)
from .executor import (
    KernelExecutor,
    ExecutionResult,
    ExecutionContext,
)
from .registry import (
    KernelRegistry,
    KernelLookup,
)

__all__ = [
    # Symbol
    "KernelSymbol",
    "KernelMetadata",
    "KernelIntegrity",
    "CompressionLevel",
    # Compressor
    "KernelCompressor",
    "CompressionResult",
    "CompressionStrategy",
    # Expander
    "KernelExpander",
    "ExpansionResult",
    "ExpansionContext",
    # Executor
    "KernelExecutor",
    "ExecutionResult",
    "ExecutionContext",
    # Registry
    "KernelRegistry",
    "KernelLookup",
]
