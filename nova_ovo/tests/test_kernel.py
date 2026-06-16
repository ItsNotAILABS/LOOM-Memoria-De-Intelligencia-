"""
Kernel Compression Tests — Round-Trip Validation
=================================================
Tests for kernel compression, expansion, and execution.
"""

import unittest
from nova_ovo.kernel import (
    KernelSymbol,
    KernelMetadata,
    KernelIntegrity,
    CompressionLevel,
    KernelCompressor,
    CompressionResult,
    KernelExpander,
    ExpansionResult,
    ExpansionContext,
    KernelExecutor,
    ExecutionContext,
    ExecutionResult,
    KernelRegistry,
)


class TestKernelCompression(unittest.TestCase):
    """Test kernel compression functionality."""
    
    def setUp(self):
        self.compressor = KernelCompressor()
        self.expander = KernelExpander()
        self.executor = KernelExecutor()
        self.registry = KernelRegistry()
    
    def test_basic_compression(self):
        """Test basic content compression."""
        content = "This is test content for kernel compression. " * 100
        result = self.compressor.compress(content, document_id="test_doc")
        
        self.assertTrue(result.success)
        self.assertIsNotNone(result.kernel)
        self.assertGreater(result.compression_ratio, 1.0)
        self.assertGreater(result.original_size, result.compressed_size)
    
    def test_compression_levels(self):
        """Test different compression levels."""
        content = "Test content for compression level testing. " * 50
        
        for level in CompressionLevel:
            result = self.compressor.compress(content, level=level)
            self.assertTrue(result.success)
            self.assertIsNotNone(result.kernel)
    
    def test_pattern_recognition(self):
        """Test pattern archetype recognition."""
        # Content with hierarchy patterns
        content = """
        Level 1: Top level
            Level 2: Child
                Level 3: Grandchild
        Level 1: Another top
            Level 2: Another child
        """
        result = self.compressor.compress(content)
        
        self.assertTrue(result.success)
        self.assertIn("Hierarchy", result.archetypes_matched)
    
    def test_glyph_generation(self):
        """Test glyph generation for kernel."""
        content = "Content for glyph generation test."
        result = self.compressor.compress(content)
        
        self.assertTrue(result.success)
        self.assertIsNotNone(result.kernel.glyph)
        self.assertGreater(len(result.kernel.glyph), 0)
    
    def test_integrity_verification(self):
        """Test integrity hash computation and verification."""
        content = "Content for integrity testing."
        result = self.compressor.compress(content)
        
        self.assertTrue(result.success)
        kernel = result.kernel
        
        # Verify integrity
        self.assertTrue(kernel.integrity.is_valid)
        self.assertIsNotNone(kernel.integrity.content_hash)
        self.assertIsNotNone(kernel.integrity.combined_hash)
        self.assertIsNotNone(kernel.integrity.chain_hash)


class TestKernelExpansion(unittest.TestCase):
    """Test kernel expansion functionality."""
    
    def setUp(self):
        self.compressor = KernelCompressor()
        self.expander = KernelExpander()
    
    def test_basic_expansion(self):
        """Test basic kernel expansion."""
        original = "This is the original content for expansion testing."
        
        # Compress
        comp_result = self.compressor.compress(original)
        self.assertTrue(comp_result.success)
        
        # Expand
        exp_result = self.expander.expand(comp_result.kernel)
        self.assertTrue(exp_result.success)
        self.assertEqual(exp_result.content, original)
    
    def test_round_trip_integrity(self):
        """Test complete round-trip preserves content."""
        contents = [
            "Simple text content.",
            "Content with unicode: φ θ Ψ Ω Δ 🜃 🜂 🜁 🜄",
            "Multi-line\ncontent\nwith\nnewlines",
            "Special chars: <>&\"' tabs:\t\t and more",
            "Long content: " + "x" * 10000,
        ]
        
        for original in contents:
            comp_result = self.compressor.compress(original)
            self.assertTrue(comp_result.success, f"Compression failed for: {original[:50]}")
            
            exp_result = self.expander.expand(comp_result.kernel)
            self.assertTrue(exp_result.success, f"Expansion failed for: {original[:50]}")
            self.assertEqual(exp_result.content, original, f"Round-trip mismatch for: {original[:50]}")
    
    def test_expansion_context(self):
        """Test expansion with context."""
        content = "Content with context."
        comp_result = self.compressor.compress(content)
        
        context = ExpansionContext(
            requester_id="test_requester",
            requester_type="test",
            purpose="validate",
        )
        
        exp_result = self.expander.expand(comp_result.kernel, context)
        self.assertTrue(exp_result.success)
        self.assertIsNotNone(exp_result.context)
        self.assertEqual(exp_result.context.requester_id, "test_requester")


class TestKernelExecution(unittest.TestCase):
    """Test kernel execution functionality."""
    
    def setUp(self):
        self.compressor = KernelCompressor()
        self.executor = KernelExecutor()
    
    def test_read_execution(self):
        """Test read execution type."""
        content = "Content for read execution."
        comp_result = self.compressor.compress(content)
        
        exec_result = self.executor.execute(comp_result.kernel)
        self.assertTrue(exec_result.success)
        self.assertEqual(exec_result.content, content)
    
    def test_validate_execution(self):
        """Test validate execution with rules."""
        content = "This content contains required_keyword."
        comp_result = self.compressor.compress(content)
        
        from nova_ovo.kernel.executor import ExecutionType
        
        context = ExecutionContext(
            execution_type=ExecutionType.VALIDATE,
            validation_rules=[
                {"name": "has_keyword", "type": "content", "required": ["required_keyword"]}
            ],
        )
        
        exec_result = self.executor.execute(comp_result.kernel, context)
        self.assertTrue(exec_result.success)
        self.assertTrue(exec_result.validation_passed)
    
    def test_transform_execution(self):
        """Test transform execution."""
        content = "content to transform"
        comp_result = self.compressor.compress(content)
        
        from nova_ovo.kernel.executor import ExecutionType
        
        context = ExecutionContext(
            execution_type=ExecutionType.TRANSFORM,
            transform_fn=lambda x: x.upper(),
            transform_name="uppercase",
        )
        
        exec_result = self.executor.execute(comp_result.kernel, context)
        self.assertTrue(exec_result.success)
        self.assertEqual(exec_result.transformed_content, "CONTENT TO TRANSFORM")


class TestKernelRegistry(unittest.TestCase):
    """Test kernel registry functionality."""
    
    def setUp(self):
        self.compressor = KernelCompressor()
        self.registry = KernelRegistry()
    
    def test_store_and_retrieve(self):
        """Test storing and retrieving kernels."""
        content = "Content for registry test."
        result = self.compressor.compress(content, document_id="doc_1")
        kernel = result.kernel
        
        # Store
        stored = self.registry.store(kernel)
        self.assertTrue(stored)
        
        # Retrieve
        lookup = self.registry.get(kernel.kernel_id)
        self.assertTrue(lookup.found)
        self.assertEqual(lookup.kernel.kernel_id, kernel.kernel_id)
    
    def test_lookup_by_glyph(self):
        """Test lookup by glyph."""
        content = "Content for glyph lookup."
        result = self.compressor.compress(content)
        kernel = result.kernel
        
        self.registry.store(kernel)
        
        lookup = self.registry.get_by_glyph(kernel.glyph)
        self.assertTrue(lookup.found)
        self.assertEqual(lookup.kernel.kernel_id, kernel.kernel_id)
    
    def test_get_by_document(self):
        """Test getting all kernels for a document."""
        doc_id = "test_document"
        
        # Create multiple kernel versions
        for i in range(3):
            content = f"Version {i} content"
            result = self.compressor.compress(content, document_id=doc_id)
            self.registry.store(result.kernel)
        
        kernels = self.registry.get_by_document(doc_id)
        self.assertEqual(len(kernels), 3)
    
    def test_lineage_tracking(self):
        """Test lineage chain tracking."""
        # Create parent kernel
        parent_result = self.compressor.compress("Parent content", document_id="doc")
        parent_kernel = parent_result.kernel
        self.registry.store(parent_kernel)
        
        # Create child kernel with parent reference
        child_result = self.compressor.compress(
            "Child content",
            document_id="doc",
            parent_kernel_id=parent_kernel.kernel_id,
        )
        child_kernel = child_result.kernel
        self.registry.store(child_kernel)
        
        # Get lineage
        lineage = self.registry.get_lineage(child_kernel.kernel_id)
        self.assertEqual(len(lineage), 2)
        self.assertEqual(lineage[0].kernel_id, parent_kernel.kernel_id)
        self.assertEqual(lineage[1].kernel_id, child_kernel.kernel_id)


if __name__ == "__main__":
    unittest.main()
