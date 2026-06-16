"""
Kernel Executor — Re-Execute Expanded Kernels
==============================================
Executes expanded kernel content in context.

When a kernel is called from any organism at any point in time,
it expands back into the complete document and executes.

Execution Types:
- READ: Simply restore and return content
- VALIDATE: Check content against rules
- TRANSFORM: Apply transformation and return result
- INJECT: Inject content into target organism
- CHAIN: Execute and chain to next kernel
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, TYPE_CHECKING

from .symbol import KernelSymbol, PHI
from .expander import KernelExpander, ExpansionContext, ExpansionResult

if TYPE_CHECKING:
    from ..documents.organisms import DocumentOrganism


class ExecutionType(str, Enum):
    """Types of kernel execution."""
    READ = "read"            # Expand and return content
    VALIDATE = "validate"    # Check against rules
    TRANSFORM = "transform"  # Apply transformation
    INJECT = "inject"        # Inject into organism
    CHAIN = "chain"          # Execute and chain
    REINJECT = "reinject"    # Reinject into continuity


@dataclass
class ExecutionContext:
    """
    Context for kernel execution.
    
    Provides execution environment:
    - Execution type and purpose
    - Target organism (for injection)
    - Transformation function
    - Validation rules
    - Chaining configuration
    """
    
    execution_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    execution_type: ExecutionType = ExecutionType.READ
    
    # Requester
    requester_id: str = ""
    requester_type: str = "system"
    
    # Target (for injection)
    target_organism_id: Optional[str] = None
    target_organism: Optional["DocumentOrganism"] = None
    
    # Transformation (for transform type)
    transform_fn: Optional[Callable[[str], str]] = None
    transform_name: str = ""
    
    # Validation (for validate type)
    validation_rules: List[Dict[str, Any]] = field(default_factory=list)
    
    # Chaining (for chain type)
    next_kernel_id: Optional[str] = None
    chain_depth: int = 0
    max_chain_depth: int = 10
    
    # Beat tracking
    current_beat: int = 0
    
    # Timestamp
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "execution_id": self.execution_id,
            "execution_type": self.execution_type.value,
            "requester_id": self.requester_id,
            "requester_type": self.requester_type,
            "target_organism_id": self.target_organism_id,
            "transform_name": self.transform_name,
            "validation_rules_count": len(self.validation_rules),
            "next_kernel_id": self.next_kernel_id,
            "chain_depth": self.chain_depth,
            "max_chain_depth": self.max_chain_depth,
            "current_beat": self.current_beat,
            "timestamp": self.timestamp,
        }


@dataclass
class ExecutionResult:
    """Result of kernel execution."""
    
    success: bool = True
    execution_id: str = ""
    execution_type: ExecutionType = ExecutionType.READ
    
    # Source kernel
    kernel_id: str = ""
    kernel_glyph: str = ""
    
    # Content
    content: str = ""
    transformed_content: Optional[str] = None
    
    # Validation results
    validation_passed: Optional[bool] = None
    validation_results: List[Dict[str, Any]] = field(default_factory=list)
    
    # Injection results
    injection_success: Optional[bool] = None
    target_organism_id: Optional[str] = None
    
    # Chain results
    chained_execution_ids: List[str] = field(default_factory=list)
    chain_depth: int = 0
    
    # Metrics
    execution_time_ms: float = 0.0
    
    # Errors
    error: Optional[str] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "success": self.success,
            "execution_id": self.execution_id,
            "execution_type": self.execution_type.value,
            "kernel_id": self.kernel_id,
            "kernel_glyph": self.kernel_glyph,
            "content_length": len(self.content),
            "transformed_content_length": len(self.transformed_content) if self.transformed_content else 0,
            "validation": {
                "passed": self.validation_passed,
                "results_count": len(self.validation_results),
            },
            "injection": {
                "success": self.injection_success,
                "target_organism_id": self.target_organism_id,
            },
            "chain": {
                "depth": self.chain_depth,
                "execution_ids": self.chained_execution_ids,
            },
            "execution_time_ms": self.execution_time_ms,
            "error": self.error,
        }


class KernelExecutor:
    """
    Executes kernel symbols in context.
    
    When a kernel is called, the executor:
    1. Expands the kernel to full content
    2. Applies the requested execution type
    3. Returns results with full provenance
    """
    
    def __init__(self) -> None:
        self.expander = KernelExpander(verify_integrity=True)
        self._execution_count = 0
        self._execution_history: List[ExecutionResult] = []
    
    def execute(
        self,
        kernel: KernelSymbol,
        context: Optional[ExecutionContext] = None,
    ) -> ExecutionResult:
        """
        Execute a kernel symbol.
        
        Args:
            kernel: The kernel to execute
            context: Execution context
        
        Returns:
            ExecutionResult with execution outcome
        """
        start_time = time.time()
        context = context or ExecutionContext()
        
        try:
            # 1. Expand kernel
            expansion_context = ExpansionContext(
                requester_id=context.requester_id,
                requester_type=context.requester_type,
                current_beat=context.current_beat,
                purpose=context.execution_type.value,
            )
            
            expansion_result = self.expander.expand(kernel, expansion_context)
            
            if not expansion_result.success:
                return ExecutionResult(
                    success=False,
                    execution_id=context.execution_id,
                    execution_type=context.execution_type,
                    kernel_id=kernel.kernel_id,
                    kernel_glyph=kernel.glyph,
                    error=f"Expansion failed: {expansion_result.error}",
                )
            
            content = expansion_result.content
            
            # 2. Update kernel execution tracking
            kernel.metadata.execution_count += 1
            kernel.metadata.last_executed_at = time.time()
            
            # 3. Execute based on type
            result = ExecutionResult(
                success=True,
                execution_id=context.execution_id,
                execution_type=context.execution_type,
                kernel_id=kernel.kernel_id,
                kernel_glyph=kernel.glyph,
                content=content,
            )
            
            if context.execution_type == ExecutionType.READ:
                # Just read - content already set
                pass
            
            elif context.execution_type == ExecutionType.VALIDATE:
                result = self._execute_validate(result, content, context)
            
            elif context.execution_type == ExecutionType.TRANSFORM:
                result = self._execute_transform(result, content, context)
            
            elif context.execution_type == ExecutionType.INJECT:
                result = self._execute_inject(result, content, context)
            
            elif context.execution_type == ExecutionType.CHAIN:
                result = self._execute_chain(result, kernel, context)
            
            elif context.execution_type == ExecutionType.REINJECT:
                result = self._execute_reinject(result, kernel, content)
            
            # Calculate metrics
            result.execution_time_ms = (time.time() - start_time) * 1000
            
            self._execution_count += 1
            self._execution_history.append(result)
            
            return result
            
        except Exception as e:
            return ExecutionResult(
                success=False,
                execution_id=context.execution_id,
                execution_type=context.execution_type,
                kernel_id=kernel.kernel_id,
                error=str(e),
            )
    
    def _execute_validate(
        self,
        result: ExecutionResult,
        content: str,
        context: ExecutionContext,
    ) -> ExecutionResult:
        """Execute validation against rules."""
        validation_results: List[Dict[str, Any]] = []
        all_passed = True
        
        for rule in context.validation_rules:
            rule_name = rule.get("name", "unnamed")
            rule_type = rule.get("type", "content")
            passed = True
            reason = "ok"
            
            if rule_type == "content":
                # Check content contains required elements
                required = rule.get("required", [])
                for req in required:
                    if req not in content:
                        passed = False
                        reason = f"Missing required: {req}"
                        break
            
            elif rule_type == "length":
                min_len = rule.get("min", 0)
                max_len = rule.get("max", float('inf'))
                if len(content) < min_len:
                    passed = False
                    reason = f"Content too short: {len(content)} < {min_len}"
                elif len(content) > max_len:
                    passed = False
                    reason = f"Content too long: {len(content)} > {max_len}"
            
            validation_results.append({
                "rule": rule_name,
                "passed": passed,
                "reason": reason,
            })
            
            if not passed:
                all_passed = False
        
        result.validation_passed = all_passed
        result.validation_results = validation_results
        return result
    
    def _execute_transform(
        self,
        result: ExecutionResult,
        content: str,
        context: ExecutionContext,
    ) -> ExecutionResult:
        """Execute transformation on content."""
        if context.transform_fn:
            try:
                result.transformed_content = context.transform_fn(content)
            except Exception as e:
                result.success = False
                result.error = f"Transform failed: {str(e)}"
        else:
            # Default: identity transform
            result.transformed_content = content
        
        return result
    
    def _execute_inject(
        self,
        result: ExecutionResult,
        content: str,
        context: ExecutionContext,
    ) -> ExecutionResult:
        """Execute injection into target organism."""
        if context.target_organism:
            try:
                # Write content to target document
                context.target_organism.write(
                    content,
                    author=f"kernel:{result.kernel_id[:8]}",
                )
                result.injection_success = True
                result.target_organism_id = context.target_organism.document_id
            except Exception as e:
                result.injection_success = False
                result.error = f"Injection failed: {str(e)}"
        else:
            result.injection_success = False
            result.error = "No target organism provided"
        
        return result
    
    def _execute_chain(
        self,
        result: ExecutionResult,
        kernel: KernelSymbol,
        context: ExecutionContext,
    ) -> ExecutionResult:
        """Execute and chain to next kernel."""
        result.chain_depth = context.chain_depth
        
        if context.chain_depth >= context.max_chain_depth:
            result.success = False
            result.error = f"Max chain depth reached: {context.max_chain_depth}"
            return result
        
        # Note: Actual chaining would require kernel registry lookup
        # This is a placeholder for the chaining logic
        result.chained_execution_ids = [context.execution_id]
        
        return result
    
    def _execute_reinject(
        self,
        result: ExecutionResult,
        kernel: KernelSymbol,
        content: str,
    ) -> ExecutionResult:
        """
        Reinject kernel content into continuity weave.
        
        Returns payload for reinjection into the system.
        """
        result.transformed_content = content
        # Reinjection is tracked in metadata
        return result
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get executor statistics."""
        type_counts: Dict[str, int] = {}
        for result in self._execution_history:
            t = result.execution_type.value
            type_counts[t] = type_counts.get(t, 0) + 1
        
        return {
            "total_executions": self._execution_count,
            "by_type": type_counts,
            "history_length": len(self._execution_history),
        }
    
    def get_history(self, limit: int = 100) -> List[ExecutionResult]:
        """Get execution history."""
        return self._execution_history[-limit:]
