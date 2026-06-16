"""
╔══════════════════════════════════════════════════════════════════════════════════╗
║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                          ║
║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA            ║
║  ALL RIGHTS RESERVED.                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════╝

SVA FITNESS EVALUATOR — PROTO-SVA-AUTE-003 Test Fitness Protocol
=================================================================

PROT-406: Fitness Evaluation System

Score test genes across multiple fitness strategies.

Fitness axes:
    - coverage
    - branch diversity
    - bug discovery
    - boundary hit rate
    - invariant verification
    - mutation kill score
    - performance sensitivity
    - regression prevention
    - semantic relevance

Core invariant:
    High fitness is evidence, not universal truth.

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from typing import Optional

from nova_ovo.sva.schemas import (
    TestGene,
    FitnessStrategy,
)

# ── φ Constants ───────────────────────────────────────────────────────────────
PHI = 1.6180339887498948482
PHI_INV = 1.0 / PHI  # 0.618


# ═══════════════════════════════════════════════════════════════════════════════
# FITNESS SCORE
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class FitnessScore:
    """
    Individual fitness score for a test gene.
    """
    score_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    gene_id: str = ""
    strategy: FitnessStrategy = FitnessStrategy.COVERAGE_DRIVEN
    score: float = 0.0
    components: dict = field(default_factory=dict)
    computed_at: int = field(default_factory=lambda: int(time.time() * 1000))
    
    def to_dict(self) -> dict:
        """Convert to dictionary."""
        return {
            "score_id": self.score_id,
            "gene_id": self.gene_id,
            "strategy": self.strategy.value,
            "score": self.score,
            "components": self.components,
            "computed_at": self.computed_at,
        }


# ═══════════════════════════════════════════════════════════════════════════════
# FITNESS REPORT
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class FitnessReport:
    """
    Comprehensive fitness report for a population.
    """
    report_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    population_id: str = ""
    generation: int = 0
    scores: list[FitnessScore] = field(default_factory=list)
    best_score: float = 0.0
    average_score: float = 0.0
    worst_score: float = 0.0
    diversity_index: float = 0.0
    coverage_estimate: float = 0.0
    failure_discovery_count: int = 0
    boundary_hit_count: int = 0
    computed_at: int = field(default_factory=lambda: int(time.time() * 1000))
    
    def to_dict(self) -> dict:
        """Convert to dictionary."""
        return {
            "report_id": self.report_id,
            "population_id": self.population_id,
            "generation": self.generation,
            "scores": [s.to_dict() for s in self.scores],
            "best_score": self.best_score,
            "average_score": self.average_score,
            "worst_score": self.worst_score,
            "diversity_index": self.diversity_index,
            "coverage_estimate": self.coverage_estimate,
            "failure_discovery_count": self.failure_discovery_count,
            "boundary_hit_count": self.boundary_hit_count,
            "computed_at": self.computed_at,
        }


# ═══════════════════════════════════════════════════════════════════════════════
# FITNESS EVALUATOR
# ═══════════════════════════════════════════════════════════════════════════════

class FitnessEvaluator:
    """
    AUTE Test Fitness Evaluation Engine.
    
    PROTO-SVA-AUTE-003: Test Fitness Protocol
    
    Evaluates test genes across multiple fitness dimensions.
    
    Core invariant:
        High fitness is evidence, not universal truth.
    """
    
    def __init__(
        self,
        default_strategy: FitnessStrategy = FitnessStrategy.COVERAGE_DRIVEN,
        weights: Optional[dict] = None,
    ):
        """
        Initialize evaluator with strategy and weights.
        
        Args:
            default_strategy: Default fitness strategy to use
            weights: Optional weight overrides for fitness components
        """
        self.default_strategy = default_strategy
        self.weights = weights or self._default_weights()
    
    def _default_weights(self) -> dict:
        """Get default weights for fitness components."""
        return {
            "coverage": PHI_INV,      # 0.618
            "branch_diversity": 0.15,
            "bug_discovery": 0.30,
            "boundary_hit_rate": 0.20,
            "invariant_verification": 0.25,
            "mutation_kill": 0.20,
            "performance": 0.10,
            "regression": 0.15,
            "semantic_relevance": 0.15,
        }
    
    # ── Strategy-Specific Evaluators ──────────────────────────────────────────
    
    def evaluate_coverage_driven(self, gene: TestGene, coverage_data: dict) -> FitnessScore:
        """
        Evaluate gene fitness using coverage-driven strategy.
        
        Coverage metrics:
            - line_coverage: Lines executed / total lines
            - branch_coverage: Branches taken / total branches
            - path_coverage: Paths traversed / estimated paths
        """
        line_cov = coverage_data.get("line_coverage", 0.0)
        branch_cov = coverage_data.get("branch_coverage", 0.0)
        path_cov = coverage_data.get("path_coverage", 0.0)
        
        # Weighted combination (φ-based)
        score = (
            line_cov * PHI_INV +
            branch_cov * 0.25 +
            path_cov * 0.15
        )
        
        # Normalize to [0, 1]
        score = min(1.0, max(0.0, score))
        
        return FitnessScore(
            gene_id=gene.gene_id,
            strategy=FitnessStrategy.COVERAGE_DRIVEN,
            score=score,
            components={
                "line_coverage": line_cov,
                "branch_coverage": branch_cov,
                "path_coverage": path_cov,
            },
        )
    
    def evaluate_failure_driven(self, gene: TestGene, failure_data: dict) -> FitnessScore:
        """
        Evaluate gene fitness using failure-driven strategy.
        
        Failure metrics:
            - bugs_found: Number of bugs discovered
            - unique_failures: Unique failure modes triggered
            - crash_triggers: Crashes or exceptions caused
        """
        bugs_found = failure_data.get("bugs_found", 0)
        unique_failures = failure_data.get("unique_failures", 0)
        crash_triggers = failure_data.get("crash_triggers", 0)
        
        # Higher is better for failure discovery
        # Diminishing returns after 10 bugs
        bug_score = min(1.0, bugs_found / 10.0)
        failure_score = min(1.0, unique_failures / 5.0)
        crash_score = min(1.0, crash_triggers / 3.0)
        
        score = (
            bug_score * 0.5 +
            failure_score * 0.3 +
            crash_score * 0.2
        )
        
        return FitnessScore(
            gene_id=gene.gene_id,
            strategy=FitnessStrategy.FAILURE_DRIVEN,
            score=score,
            components={
                "bugs_found": bugs_found,
                "unique_failures": unique_failures,
                "crash_triggers": crash_triggers,
            },
        )
    
    def evaluate_boundary_driven(self, gene: TestGene, boundary_data: dict) -> FitnessScore:
        """
        Evaluate gene fitness using boundary-driven strategy.
        
        Boundary metrics:
            - boundaries_tested: Number of boundary cases tested
            - edge_cases_found: Edge cases that caused failures
            - coverage_of_boundary_classes: Coverage of boundary class types
        """
        boundaries_tested = boundary_data.get("boundaries_tested", 0)
        edge_cases_found = boundary_data.get("edge_cases_found", 0)
        class_coverage = boundary_data.get("class_coverage", 0.0)
        
        # Score based on boundary exploration
        boundary_score = min(1.0, boundaries_tested / 20.0)
        edge_score = min(1.0, edge_cases_found / 5.0)
        
        score = (
            boundary_score * 0.4 +
            edge_score * 0.4 +
            class_coverage * 0.2
        )
        
        return FitnessScore(
            gene_id=gene.gene_id,
            strategy=FitnessStrategy.BOUNDARY_DRIVEN,
            score=score,
            components={
                "boundaries_tested": boundaries_tested,
                "edge_cases_found": edge_cases_found,
                "class_coverage": class_coverage,
            },
        )
    
    def evaluate_mutation_driven(self, gene: TestGene, mutation_data: dict) -> FitnessScore:
        """
        Evaluate gene fitness using mutation-driven strategy.
        
        Mutation metrics:
            - mutants_killed: Mutants detected by the test
            - total_mutants: Total mutants generated
            - mutation_score: mutants_killed / total_mutants
        """
        mutants_killed = mutation_data.get("mutants_killed", 0)
        total_mutants = mutation_data.get("total_mutants", 1)
        survived_mutants = mutation_data.get("survived_mutants", 0)
        
        mutation_score = mutants_killed / max(1, total_mutants)
        
        return FitnessScore(
            gene_id=gene.gene_id,
            strategy=FitnessStrategy.MUTATION_DRIVEN,
            score=mutation_score,
            components={
                "mutants_killed": mutants_killed,
                "total_mutants": total_mutants,
                "survived_mutants": survived_mutants,
                "mutation_score": mutation_score,
            },
        )
    
    def evaluate_performance_driven(self, gene: TestGene, performance_data: dict) -> FitnessScore:
        """
        Evaluate gene fitness using performance-driven strategy.
        
        Performance metrics:
            - execution_time_ms: Time to execute the test
            - memory_usage_mb: Memory consumed
            - throughput: Operations per second
        """
        exec_time = performance_data.get("execution_time_ms", 1000.0)
        memory_mb = performance_data.get("memory_usage_mb", 100.0)
        throughput = performance_data.get("throughput", 1.0)
        
        # Lower time and memory is better
        time_score = 1.0 / (1.0 + exec_time / 100.0)  # Normalize around 100ms
        memory_score = 1.0 / (1.0 + memory_mb / 50.0)  # Normalize around 50MB
        throughput_score = min(1.0, throughput / 1000.0)  # Normalize around 1000 ops/s
        
        score = (
            time_score * 0.4 +
            memory_score * 0.3 +
            throughput_score * 0.3
        )
        
        return FitnessScore(
            gene_id=gene.gene_id,
            strategy=FitnessStrategy.PERFORMANCE_DRIVEN,
            score=score,
            components={
                "execution_time_ms": exec_time,
                "memory_usage_mb": memory_mb,
                "throughput": throughput,
                "time_score": time_score,
                "memory_score": memory_score,
                "throughput_score": throughput_score,
            },
        )
    
    def evaluate_security_driven(self, gene: TestGene, security_data: dict) -> FitnessScore:
        """
        Evaluate gene fitness using security-driven strategy.
        
        Security metrics:
            - vulnerabilities_found: Security issues discovered
            - injection_success: Successful injection attempts
            - authorization_bypass: Auth bypass attempts
        """
        vulns_found = security_data.get("vulnerabilities_found", 0)
        injection_success = security_data.get("injection_success", 0)
        auth_bypass = security_data.get("authorization_bypass", 0)
        
        # Higher is better for security testing
        vuln_score = min(1.0, vulns_found / 3.0)
        injection_score = min(1.0, injection_success / 2.0)
        auth_score = min(1.0, auth_bypass / 1.0)
        
        score = (
            vuln_score * 0.5 +
            injection_score * 0.3 +
            auth_score * 0.2
        )
        
        return FitnessScore(
            gene_id=gene.gene_id,
            strategy=FitnessStrategy.SECURITY_DRIVEN,
            score=score,
            components={
                "vulnerabilities_found": vulns_found,
                "injection_success": injection_success,
                "authorization_bypass": auth_bypass,
            },
        )
    
    def evaluate_regression_driven(self, gene: TestGene, regression_data: dict) -> FitnessScore:
        """
        Evaluate gene fitness using regression-driven strategy.
        
        Regression metrics:
            - regressions_caught: Previously passing tests now failing
            - stability_score: Consistency across runs
            - historical_failures: Known failures prevented
        """
        regressions_caught = regression_data.get("regressions_caught", 0)
        stability_score = regression_data.get("stability_score", 1.0)
        historical_failures = regression_data.get("historical_failures_prevented", 0)
        
        regression_score = min(1.0, regressions_caught / 5.0)
        historical_score = min(1.0, historical_failures / 10.0)
        
        score = (
            regression_score * 0.4 +
            stability_score * 0.3 +
            historical_score * 0.3
        )
        
        return FitnessScore(
            gene_id=gene.gene_id,
            strategy=FitnessStrategy.REGRESSION_DRIVEN,
            score=score,
            components={
                "regressions_caught": regressions_caught,
                "stability_score": stability_score,
                "historical_failures_prevented": historical_failures,
            },
        )
    
    def evaluate_capability_driven(self, gene: TestGene, capability_data: dict) -> FitnessScore:
        """
        Evaluate gene fitness using capability-driven strategy.
        
        Capability metrics:
            - capability_coverage: Percentage of capability exercised
            - assertion_strength: Strength of assertions
            - invariant_verification: Invariants verified
        """
        cap_coverage = capability_data.get("capability_coverage", 0.0)
        assertion_strength = capability_data.get("assertion_strength", 0.0)
        invariant_verified = capability_data.get("invariants_verified", 0)
        total_invariants = capability_data.get("total_invariants", 1)
        
        invariant_score = invariant_verified / max(1, total_invariants)
        
        score = (
            cap_coverage * 0.4 +
            assertion_strength * 0.3 +
            invariant_score * 0.3
        )
        
        return FitnessScore(
            gene_id=gene.gene_id,
            strategy=FitnessStrategy.CAPABILITY_DRIVEN,
            score=score,
            components={
                "capability_coverage": cap_coverage,
                "assertion_strength": assertion_strength,
                "invariants_verified": invariant_verified,
                "total_invariants": total_invariants,
                "invariant_score": invariant_score,
            },
        )
    
    # ── Main Evaluation ───────────────────────────────────────────────────────
    
    def evaluate(
        self,
        gene: TestGene,
        data: dict,
        strategy: Optional[FitnessStrategy] = None,
    ) -> FitnessScore:
        """
        Evaluate a test gene's fitness.
        
        Args:
            gene: The test gene to evaluate
            data: Metrics data for evaluation
            strategy: Strategy to use (defaults to evaluator's default)
        
        Returns:
            FitnessScore with the evaluation result
        """
        strategy = strategy or self.default_strategy
        
        evaluators = {
            FitnessStrategy.COVERAGE_DRIVEN: self.evaluate_coverage_driven,
            FitnessStrategy.FAILURE_DRIVEN: self.evaluate_failure_driven,
            FitnessStrategy.BOUNDARY_DRIVEN: self.evaluate_boundary_driven,
            FitnessStrategy.MUTATION_DRIVEN: self.evaluate_mutation_driven,
            FitnessStrategy.PERFORMANCE_DRIVEN: self.evaluate_performance_driven,
            FitnessStrategy.SECURITY_DRIVEN: self.evaluate_security_driven,
            FitnessStrategy.REGRESSION_DRIVEN: self.evaluate_regression_driven,
            FitnessStrategy.CAPABILITY_DRIVEN: self.evaluate_capability_driven,
        }
        
        evaluator = evaluators.get(strategy)
        if evaluator:
            return evaluator(gene, data)
        
        # Default to coverage-driven
        return self.evaluate_coverage_driven(gene, data)
    
    def evaluate_population(
        self,
        genes: list[TestGene],
        data_map: dict[str, dict],
        strategy: Optional[FitnessStrategy] = None,
        population_id: str = "",
        generation: int = 0,
    ) -> FitnessReport:
        """
        Evaluate fitness for an entire population.
        
        Args:
            genes: List of test genes to evaluate
            data_map: Map of gene_id -> evaluation data
            strategy: Strategy to use
            population_id: ID of the population
            generation: Current generation number
        
        Returns:
            FitnessReport with all scores and statistics
        """
        scores = []
        for gene in genes:
            data = data_map.get(gene.gene_id, {})
            score = self.evaluate(gene, data, strategy)
            scores.append(score)
            # Update gene's fitness
            gene.fitness = score.score
            gene.strategy = score.strategy
        
        # Compute statistics
        score_values = [s.score for s in scores]
        best_score = max(score_values) if score_values else 0.0
        worst_score = min(score_values) if score_values else 0.0
        average_score = sum(score_values) / len(score_values) if score_values else 0.0
        
        # Diversity index (variance of scores)
        if len(score_values) > 1:
            mean = average_score
            variance = sum((s - mean) ** 2 for s in score_values) / len(score_values)
            diversity_index = variance ** 0.5
        else:
            diversity_index = 0.0
        
        return FitnessReport(
            population_id=population_id,
            generation=generation,
            scores=scores,
            best_score=best_score,
            average_score=average_score,
            worst_score=worst_score,
            diversity_index=diversity_index,
        )
    
    def compute_combined_fitness(
        self,
        gene: TestGene,
        data: dict,
        strategies: list[FitnessStrategy],
        strategy_weights: Optional[dict] = None,
    ) -> float:
        """
        Compute combined fitness across multiple strategies.
        
        Args:
            gene: Test gene to evaluate
            data: Evaluation data
            strategies: List of strategies to combine
            strategy_weights: Optional weights for each strategy
        
        Returns:
            Combined fitness score
        """
        strategy_weights = strategy_weights or {}
        total_weight = 0.0
        weighted_sum = 0.0
        
        for strategy in strategies:
            score = self.evaluate(gene, data, strategy)
            weight = strategy_weights.get(strategy, 1.0)
            weighted_sum += score.score * weight
            total_weight += weight
        
        if total_weight > 0:
            return weighted_sum / total_weight
        return 0.0
