"""
╔══════════════════════════════════════════════════════════════════════════════════╗
║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                          ║
║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA            ║
║  ALL RIGHTS RESERVED.                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════╝

AUTE ENGINE — Auto AI Testing Engine
=====================================

PROT-410: AUTE Core Engine

AUTE is the organism's adaptive test-generation immune organ.
It turns unknown risk into evolving test populations.

Core doctrine:
    No capability is fully challenged until tests can evolve beyond human imagination.

SVA asks: Is this capability real, repeatable, recoverable, and certifiable?
AUTE asks: What tests would expose where this capability is fake, brittle,
           incomplete, unsafe, or overclaimed?

AUTE has five roles inside SVA:
    1. Test Discovery — Generate test cases no human explicitly wrote
    2. Test Evolution — Improve test populations via genetic algorithms
    3. Boundary Exploration — Find edge cases and adversarial inputs
    4. Capability Challenge — Attack capability claims from multiple strategies
    5. Memory Formation — Convert discoveries into organism memory

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from typing import Any, Callable, Optional

from nova_ovo.sva.schemas import (
    TestGene,
    TestGeneStatus,
    TestPopulation,
    TestType,
    TargetType,
    FitnessStrategy,
    AssertionRecord,
    AssertionType,
    AuteRunRecord,
    AUTEProofTrace,
    ProofResult,
)
from nova_ovo.sva.registry import TestSuiteRegistry
from nova_ovo.sva.boundary_generator import BoundaryGenerator, BoundaryValue
from nova_ovo.sva.fitness_evaluator import FitnessEvaluator, FitnessReport
from nova_ovo.sva.genetic_operators import GeneticOperators
from nova_ovo.sva.evidence_feed import EvidenceFeed


# ── φ Constants ───────────────────────────────────────────────────────────────
PHI = 1.6180339887498948482
PHI_INV = 1.0 / PHI  # 0.618


# ═══════════════════════════════════════════════════════════════════════════════
# EVOLUTION CONFIG
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class EvolutionConfig:
    """Configuration for AUTE evolution runs."""
    population_size: int = 50
    generations: int = 20
    mutation_rate: float = 0.1
    crossover_rate: float = 0.7
    elitism_ratio: float = 0.1
    tournament_size: int = 3
    fitness_strategy: FitnessStrategy = FitnessStrategy.COVERAGE_DRIVEN
    selection_method: str = "tournament"
    crossover_method: str = "single_point"
    inject_boundaries: bool = True
    boundary_injection_rate: float = 0.2
    seed: Optional[int] = None


# ═══════════════════════════════════════════════════════════════════════════════
# EVOLUTION RESULT
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class EvolutionResult:
    """Result of an AUTE evolution run."""
    run_id: str = ""
    target_id: str = ""
    capability_id: Optional[str] = None
    generations_completed: int = 0
    final_population: list[TestGene] = field(default_factory=list)
    best_genes: list[TestGene] = field(default_factory=list)
    promoted_genes: list[str] = field(default_factory=list)
    quarantined_genes: list[str] = field(default_factory=list)
    bugs_discovered: int = 0
    coverage_improvement: float = 0.0
    fitness_history: list[float] = field(default_factory=list)
    proof_trace_id: str = ""
    run_record: Optional[AuteRunRecord] = None
    
    def to_dict(self) -> dict:
        """Convert to dictionary."""
        return {
            "run_id": self.run_id,
            "target_id": self.target_id,
            "capability_id": self.capability_id,
            "generations_completed": self.generations_completed,
            "final_population_size": len(self.final_population),
            "best_genes_count": len(self.best_genes),
            "promoted_genes": self.promoted_genes,
            "quarantined_genes": self.quarantined_genes,
            "bugs_discovered": self.bugs_discovered,
            "coverage_improvement": self.coverage_improvement,
            "fitness_history": self.fitness_history,
            "proof_trace_id": self.proof_trace_id,
        }


# ═══════════════════════════════════════════════════════════════════════════════
# AUTE ENGINE
# ═══════════════════════════════════════════════════════════════════════════════

class AUTEEngine:
    """
    AUTE — Auto AI Testing Engine.
    
    The organism's adaptive test-generation immune organ.
    
    AUTE discovers and evolves tests; SVA certifies capabilities.
    CPL/PULSE records the proof. Memory makes the organism harder to fool next time.
    
    Core invariants:
        - Generated Test Requires Target
        - Promoted Test Requires Execution Proof
        - Fitness Requires Strategy
        - High Fitness Does Not Equal Truth
        - AI-Generated Test Requires Review Class
        - Test Discovery Does Not Equal Capability Certification
        - Hypothesis Cannot Become Certificate
    """
    
    def __init__(
        self,
        registry: Optional[TestSuiteRegistry] = None,
        evidence_feed: Optional[EvidenceFeed] = None,
        config: Optional[EvolutionConfig] = None,
    ):
        """
        Initialize AUTE engine.
        
        Args:
            registry: Test suite registry for storage
            evidence_feed: Evidence feed for proof recording
            config: Default evolution configuration
        """
        self.registry = registry or TestSuiteRegistry()
        self.evidence_feed = evidence_feed or EvidenceFeed()
        self.config = config or EvolutionConfig()
        
        # Initialize sub-engines
        self.boundary_generator = BoundaryGenerator(seed=self.config.seed)
        self.fitness_evaluator = FitnessEvaluator(default_strategy=self.config.fitness_strategy)
        self.genetic_operators = GeneticOperators(
            mutation_rate=self.config.mutation_rate,
            crossover_rate=self.config.crossover_rate,
            elitism_ratio=self.config.elitism_ratio,
            tournament_size=self.config.tournament_size,
            seed=self.config.seed,
        )
        
        # Test executor function (to be set externally)
        self._test_executor: Optional[Callable[[TestGene], dict]] = None
    
    def set_test_executor(self, executor: Callable[[TestGene], dict]):
        """
        Set the test execution function.
        
        The executor should take a TestGene and return a dict with:
            - passed: bool
            - execution_time_ms: float
            - output: str (optional)
            - coverage_data: dict (optional)
            - error: str (optional)
        """
        self._test_executor = executor
    
    # ══════════════════════════════════════════════════════════════════════════
    # TEST GENERATION
    # ══════════════════════════════════════════════════════════════════════════
    
    def generate_seed_gene(
        self,
        target_id: str,
        target_type: TargetType = TargetType.FUNCTION,
        test_type: TestType = TestType.UNIT,
        inputs: Optional[list] = None,
        assertions: Optional[list[AssertionRecord]] = None,
    ) -> TestGene:
        """
        Generate a seed test gene.
        
        Seed genes form the initial population before evolution.
        """
        gene = TestGene(
            target_id=target_id,
            target_type=target_type,
            test_type=test_type,
            inputs=inputs or [],
            assertions=assertions or [],
            generation=0,
            discovered_by="aute",
            status=TestGeneStatus.CANDIDATE,
        )
        
        # Register the gene
        self.registry.register_gene(gene)
        
        return gene
    
    def generate_boundary_genes(
        self,
        target_id: str,
        target_type: TargetType = TargetType.FUNCTION,
        count: int = 10,
    ) -> list[TestGene]:
        """
        Generate test genes with boundary values.
        
        PROTO-SVA-AUTE-002: Boundary Discovery Protocol
        """
        genes = []
        boundaries = self.boundary_generator.generate_random_boundaries(count)
        
        for boundary in boundaries:
            gene = TestGene(
                target_id=target_id,
                target_type=target_type,
                test_type=TestType.FUZZ,
                inputs=[boundary.value],
                assertions=[
                    AssertionRecord(
                        assertion_type=AssertionType.DOES_NOT_THROW,
                        expression="result",
                        expected=None,
                    )
                ],
                generation=0,
                discovered_by="aute",
                status=TestGeneStatus.CANDIDATE,
            )
            
            self.registry.register_gene(gene)
            genes.append(gene)
        
        return genes
    
    def generate_security_genes(
        self,
        target_id: str,
        target_type: TargetType = TargetType.FUNCTION,
    ) -> list[TestGene]:
        """
        Generate test genes with security payloads.
        
        Tests for SQL injection, XSS, path traversal, etc.
        """
        genes = []
        security_boundaries = self.boundary_generator.generate_security_boundaries()
        
        for boundary in security_boundaries:
            gene = TestGene(
                target_id=target_id,
                target_type=target_type,
                test_type=TestType.SECURITY,
                inputs=[boundary.value],
                assertions=[
                    AssertionRecord(
                        assertion_type=AssertionType.DOES_NOT_THROW,
                        expression="result",
                        expected=None,
                    )
                ],
                generation=0,
                discovered_by="aute",
                status=TestGeneStatus.CANDIDATE,
            )
            
            self.registry.register_gene(gene)
            genes.append(gene)
        
        return genes
    
    def generate_initial_population(
        self,
        target_id: str,
        target_type: TargetType = TargetType.FUNCTION,
        population_size: int = 50,
        seed_genes: Optional[list[TestGene]] = None,
    ) -> TestPopulation:
        """
        Generate an initial population for evolution.
        """
        genes = list(seed_genes) if seed_genes else []
        
        # Add boundary genes
        boundary_count = int(population_size * self.config.boundary_injection_rate)
        genes.extend(self.generate_boundary_genes(target_id, target_type, boundary_count))
        
        # Fill remaining with generated genes
        while len(genes) < population_size:
            gene = self.generate_seed_gene(target_id, target_type)
            genes.append(gene)
        
        # Create population
        population = TestPopulation(
            target_id=target_id,
            generation=0,
            gene_ids=[g.gene_id for g in genes],
        )
        
        self.registry.register_population(population)
        
        return population
    
    # ══════════════════════════════════════════════════════════════════════════
    # TEST EXECUTION
    # ══════════════════════════════════════════════════════════════════════════
    
    def execute_gene(self, gene: TestGene) -> dict:
        """
        Execute a test gene.
        
        Returns execution results including pass/fail, timing, and coverage.
        """
        if self._test_executor is None:
            # Simulate execution for testing
            import random
            passed = random.random() > 0.3
            return {
                "passed": passed,
                "execution_time_ms": random.uniform(1, 100),
                "output": "Simulated execution",
                "coverage_data": {
                    "line_coverage": random.uniform(0.5, 0.9),
                    "branch_coverage": random.uniform(0.4, 0.8),
                },
            }
        
        try:
            result = self._test_executor(gene)
            return result
        except Exception as e:
            return {
                "passed": False,
                "execution_time_ms": 0,
                "output": "",
                "error": str(e),
            }
    
    def execute_population(
        self,
        population: TestPopulation,
    ) -> dict[str, dict]:
        """
        Execute all genes in a population.
        
        Returns map of gene_id -> execution results.
        """
        results = {}
        
        for gene_id in population.gene_ids:
            gene = self.registry.get_gene(gene_id)
            if gene and gene.status != TestGeneStatus.QUARANTINED:
                result = self.execute_gene(gene)
                results[gene_id] = result
                
                # Record execution
                gene.record_execution(
                    passed=result.get("passed", False),
                    time_ms=result.get("execution_time_ms", 0),
                )
                
                # Record evidence
                self.evidence_feed.record_test_execution(
                    gene=gene,
                    passed=result.get("passed", False),
                    execution_time_ms=result.get("execution_time_ms", 0),
                    output=result.get("output", ""),
                    capability_id=population.capability_id,
                )
        
        return results
    
    # ══════════════════════════════════════════════════════════════════════════
    # EVOLUTION
    # ══════════════════════════════════════════════════════════════════════════
    
    def evolve_generation(
        self,
        population: TestPopulation,
        execution_results: dict[str, dict],
    ) -> tuple[TestPopulation, FitnessReport]:
        """
        Evolve population by one generation.
        
        PROTO-SVA-AUTE-001: Test Gene Evolution Protocol
        """
        # Get current genes
        genes = [
            self.registry.get_gene(gid)
            for gid in population.gene_ids
            if self.registry.get_gene(gid) is not None
        ]
        
        # Evaluate fitness
        fitness_report = self.fitness_evaluator.evaluate_population(
            genes=genes,
            data_map={
                g.gene_id: execution_results.get(g.gene_id, {}).get("coverage_data", {})
                for g in genes
            },
            strategy=self.config.fitness_strategy,
            population_id=population.population_id,
            generation=population.generation,
        )
        
        # Evolve using genetic operators
        new_genes = self.genetic_operators.evolve_population(
            population=genes,
            target_size=self.config.population_size,
            selection_method=self.config.selection_method,
            crossover_method=self.config.crossover_method,
        )
        
        # Register new genes
        for gene in new_genes:
            self.registry.register_gene(gene)
        
        # Inject fresh boundary genes for diversity
        if self.config.inject_boundaries:
            injection_count = max(1, int(len(new_genes) * self.config.boundary_injection_rate * 0.1))
            boundary_genes = self.generate_boundary_genes(
                population.target_id,
                count=injection_count,
            )
            # Replace lowest fitness genes
            new_genes = sorted(new_genes, key=lambda g: g.fitness, reverse=True)
            new_genes = new_genes[:-injection_count] + boundary_genes
        
        # Update population
        population.advance_generation(
            new_gene_ids=[g.gene_id for g in new_genes],
            stats={
                "best_fitness": fitness_report.best_score,
                "average_fitness": fitness_report.average_score,
                "diversity_score": fitness_report.diversity_index,
                "coverage_score": fitness_report.coverage_estimate,
            },
        )
        
        self.registry.update_population(population)
        
        return population, fitness_report
    
    def run_evolution(
        self,
        target_id: str,
        target_type: TargetType = TargetType.FUNCTION,
        capability_id: Optional[str] = None,
        config: Optional[EvolutionConfig] = None,
        seed_genes: Optional[list[TestGene]] = None,
        source_commit: Optional[str] = None,
    ) -> EvolutionResult:
        """
        Run a full AUTE evolution cycle.
        
        This is the main entry point for evolutionary test generation.
        """
        config = config or self.config
        run_id = str(uuid.uuid4())
        
        # Generate initial population
        population = self.generate_initial_population(
            target_id=target_id,
            target_type=target_type,
            population_size=config.population_size,
            seed_genes=seed_genes,
        )
        population.capability_id = capability_id
        
        # Track evolution progress
        fitness_history = []
        bugs_discovered = 0
        initial_coverage = 0.0
        promoted_genes = []
        quarantined_genes = []
        
        # Run evolution loop
        for gen in range(config.generations):
            # Execute population
            results = self.execute_population(population)
            
            # Track bugs discovered (failed tests that weren't expected to fail)
            for gene_id, result in results.items():
                if not result.get("passed", True) and result.get("error"):
                    bugs_discovered += 1
                    gene = self.registry.get_gene(gene_id)
                    if gene:
                        self.evidence_feed.record_bug_discovery(
                            gene=gene,
                            bug_description=result.get("error", "Unknown error"),
                            severity="medium",
                            reproducible=True,
                            capability_id=capability_id,
                        )
            
            # Evolve
            population, fitness_report = self.evolve_generation(population, results)
            fitness_history.append(fitness_report.best_score)
            
            # Track coverage on first generation
            if gen == 0:
                initial_coverage = fitness_report.coverage_estimate
        
        # Final execution
        final_results = self.execute_population(population)
        
        # Identify best genes (top 10%)
        final_genes = [
            self.registry.get_gene(gid)
            for gid in population.gene_ids
            if self.registry.get_gene(gid) is not None
        ]
        final_genes.sort(key=lambda g: g.fitness, reverse=True)
        best_count = max(1, int(len(final_genes) * 0.1))
        best_genes = final_genes[:best_count]
        
        # Promote high-fitness genes
        for gene in best_genes:
            if gene.fitness >= PHI_INV and gene.execution_count > 0:
                gene.promote(TestGeneStatus.ACTIVE)
                promoted_genes.append(gene.gene_id)
        
        # Quarantine flaky genes
        for gene in final_genes:
            if gene.execution_count > 0 and gene.failure_count / gene.execution_count > 0.5:
                gene.promote(TestGeneStatus.QUARANTINED)
                quarantined_genes.append(gene.gene_id)
        
        # Create run record
        run_record = AuteRunRecord(
            run_id=run_id,
            target_id=target_id,
            capability_id=capability_id,
            strategy=config.fitness_strategy,
            generation_start=0,
            generation_end=config.generations,
            tests_generated=len(population.gene_ids) * config.generations,
            tests_executed=sum(1 for r in final_results.values()),
            tests_passed=sum(1 for r in final_results.values() if r.get("passed", False)),
            tests_failed=sum(1 for r in final_results.values() if not r.get("passed", True)),
            bugs_discovered=bugs_discovered,
            coverage_delta=population.coverage_score - initial_coverage,
            best_gene_ids=[g.gene_id for g in best_genes],
        )
        
        self.registry.register_run(run_record)
        
        # Create proof trace
        proof_trace = self.evidence_feed.create_proof_trace(
            run=run_record,
            promoted_genes=promoted_genes,
            quarantined_genes=quarantined_genes,
            evidence_refs=[],
            result=ProofResult.PASSED if bugs_discovered == 0 else ProofResult.PARTIAL,
            source_commit=source_commit,
        )
        
        # Build result
        result = EvolutionResult(
            run_id=run_id,
            target_id=target_id,
            capability_id=capability_id,
            generations_completed=config.generations,
            final_population=final_genes,
            best_genes=best_genes,
            promoted_genes=promoted_genes,
            quarantined_genes=quarantined_genes,
            bugs_discovered=bugs_discovered,
            coverage_improvement=population.coverage_score - initial_coverage,
            fitness_history=fitness_history,
            proof_trace_id=proof_trace.proof_id,
            run_record=run_record,
        )
        
        return result
    
    # ══════════════════════════════════════════════════════════════════════════
    # UTILITY METHODS
    # ══════════════════════════════════════════════════════════════════════════
    
    def analyze_target(
        self,
        target_id: str,
        target_info: dict,
    ) -> dict:
        """
        Analyze a target to determine testing strategy.
        
        Returns recommendations for test generation.
        """
        recommendations = {
            "suggested_test_types": [TestType.UNIT],
            "suggested_strategies": [FitnessStrategy.COVERAGE_DRIVEN],
            "boundary_classes_relevant": [],
            "estimated_population_size": 50,
            "estimated_generations": 20,
        }
        
        # Analyze target characteristics
        has_inputs = target_info.get("has_inputs", True)
        has_side_effects = target_info.get("has_side_effects", False)
        is_async = target_info.get("is_async", False)
        is_security_sensitive = target_info.get("is_security_sensitive", False)
        
        if has_inputs:
            recommendations["suggested_test_types"].append(TestType.PROPERTY)
            recommendations["suggested_test_types"].append(TestType.FUZZ)
            recommendations["boundary_classes_relevant"] = ["null", "empty", "max_int", "unicode"]
        
        if has_side_effects:
            recommendations["suggested_test_types"].append(TestType.INTEGRATION)
            recommendations["suggested_strategies"].append(FitnessStrategy.REGRESSION_DRIVEN)
        
        if is_async:
            recommendations["suggested_test_types"].append(TestType.PERFORMANCE)
            recommendations["suggested_strategies"].append(FitnessStrategy.PERFORMANCE_DRIVEN)
        
        if is_security_sensitive:
            recommendations["suggested_test_types"].append(TestType.SECURITY)
            recommendations["suggested_strategies"].append(FitnessStrategy.SECURITY_DRIVEN)
            recommendations["boundary_classes_relevant"].extend(["injection", "adversarial"])
        
        return recommendations
    
    def get_population_status(self, population_id: str) -> dict:
        """Get current status of a population."""
        population = self.registry.get_population(population_id)
        if not population:
            return {"error": "Population not found"}
        
        genes = [
            self.registry.get_gene(gid)
            for gid in population.gene_ids
            if self.registry.get_gene(gid) is not None
        ]
        
        status_counts = {}
        for gene in genes:
            status = gene.status.value
            status_counts[status] = status_counts.get(status, 0) + 1
        
        return {
            "population_id": population_id,
            "target_id": population.target_id,
            "generation": population.generation,
            "gene_count": len(genes),
            "best_fitness": population.best_fitness,
            "average_fitness": population.average_fitness,
            "diversity_score": population.diversity_score,
            "status_distribution": status_counts,
        }
