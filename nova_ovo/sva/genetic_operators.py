"""
╔══════════════════════════════════════════════════════════════════════════════════╗
║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                          ║
║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA            ║
║  ALL RIGHTS RESERVED.                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════╝

SVA GENETIC OPERATORS — PROTO-SVA-AUTE-004 Genetic Operator Protocol
=====================================================================

PROT-407: Genetic Operator System

Apply selection, crossover, mutation, and elitism to test populations.

Core rules:
    - Selection must prefer high-fitness genes but preserve diversity
    - Crossover must preserve valid target and assertion structure
    - Mutation must not erase lineage
    - Elitism must not freeze the population into monoculture

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
"""

from __future__ import annotations

import copy
import random
import time
import uuid
from dataclasses import dataclass, field
from typing import Optional

from nova_ovo.sva.schemas import (
    TestGene,
    TestGeneStatus,
    MutationRecord,
    MutationType,
    AssertionRecord,
    AssertionType,
)

# ── φ Constants ───────────────────────────────────────────────────────────────
PHI = 1.6180339887498948482
PHI_INV = 1.0 / PHI  # 0.618


# ═══════════════════════════════════════════════════════════════════════════════
# RESULT TYPES
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class SelectionResult:
    """Result of a selection operation."""
    selected_genes: list[TestGene] = field(default_factory=list)
    elite_genes: list[TestGene] = field(default_factory=list)
    selection_pressure: float = 0.0
    diversity_maintained: float = 0.0


@dataclass
class CrossoverResult:
    """Result of a crossover operation."""
    child1: Optional[TestGene] = None
    child2: Optional[TestGene] = None
    crossover_point: int = 0
    parent1_contribution: float = 0.0
    parent2_contribution: float = 0.0


@dataclass
class MutationResult:
    """Result of a mutation operation."""
    mutated_gene: TestGene = field(default_factory=TestGene)
    mutation_applied: MutationType = MutationType.INPUT_CHANGE
    mutation_strength: float = 0.0
    changes_made: list[str] = field(default_factory=list)


# ═══════════════════════════════════════════════════════════════════════════════
# GENETIC OPERATORS
# ═══════════════════════════════════════════════════════════════════════════════

class GeneticOperators:
    """
    AUTE Genetic Operators Engine.
    
    PROTO-SVA-AUTE-004: Genetic Operator Protocol
    
    Applies genetic algorithm operators to evolve test populations.
    
    Core rules:
        - Selection must prefer high-fitness genes but preserve diversity
        - Crossover must preserve valid target and assertion structure
        - Mutation must not erase lineage
        - Elitism must not freeze the population into monoculture
    """
    
    def __init__(
        self,
        mutation_rate: float = 0.1,
        crossover_rate: float = 0.7,
        elitism_ratio: float = 0.1,
        tournament_size: int = 3,
        diversity_pressure: float = 0.2,
        seed: Optional[int] = None,
    ):
        """
        Initialize genetic operators.
        
        Args:
            mutation_rate: Probability of mutation (0-1)
            crossover_rate: Probability of crossover (0-1)
            elitism_ratio: Fraction of population preserved as elite (0-1)
            tournament_size: Number of candidates in tournament selection
            diversity_pressure: Weight given to diversity preservation (0-1)
            seed: Random seed for reproducibility
        """
        self.mutation_rate = mutation_rate
        self.crossover_rate = crossover_rate
        self.elitism_ratio = elitism_ratio
        self.tournament_size = tournament_size
        self.diversity_pressure = diversity_pressure
        self.rng = random.Random(seed)
    
    # ══════════════════════════════════════════════════════════════════════════
    # SELECTION OPERATORS
    # ══════════════════════════════════════════════════════════════════════════
    
    def tournament_selection(
        self,
        population: list[TestGene],
        num_winners: int,
    ) -> list[TestGene]:
        """
        Select genes using tournament selection.
        
        Tournament selection picks random subsets and selects the best from each.
        This maintains selection pressure while preserving diversity.
        """
        winners = []
        for _ in range(num_winners):
            # Select random candidates for tournament
            candidates = self.rng.sample(
                population,
                min(self.tournament_size, len(population))
            )
            # Winner is the one with highest fitness
            winner = max(candidates, key=lambda g: g.fitness)
            winners.append(copy.deepcopy(winner))
        return winners
    
    def roulette_selection(
        self,
        population: list[TestGene],
        num_winners: int,
    ) -> list[TestGene]:
        """
        Select genes using roulette wheel selection.
        
        Selection probability is proportional to fitness.
        """
        if not population:
            return []
        
        # Calculate total fitness
        total_fitness = sum(g.fitness for g in population)
        if total_fitness <= 0:
            # Fall back to random selection
            return self.rng.sample(population, min(num_winners, len(population)))
        
        winners = []
        for _ in range(num_winners):
            # Spin the wheel
            spin = self.rng.random() * total_fitness
            cumulative = 0.0
            for gene in population:
                cumulative += gene.fitness
                if cumulative >= spin:
                    winners.append(copy.deepcopy(gene))
                    break
        
        return winners
    
    def rank_selection(
        self,
        population: list[TestGene],
        num_winners: int,
    ) -> list[TestGene]:
        """
        Select genes using rank-based selection.
        
        Selection probability is based on rank rather than raw fitness,
        which helps prevent premature convergence.
        """
        if not population:
            return []
        
        # Sort by fitness
        ranked = sorted(population, key=lambda g: g.fitness)
        n = len(ranked)
        
        # Assign selection probabilities based on rank
        # Linear ranking: P(i) = (2 * rank_i) / (n * (n + 1))
        total_rank = n * (n + 1) / 2
        
        winners = []
        for _ in range(num_winners):
            spin = self.rng.random() * total_rank
            cumulative = 0.0
            for rank, gene in enumerate(ranked, 1):
                cumulative += rank
                if cumulative >= spin:
                    winners.append(copy.deepcopy(gene))
                    break
        
        return winners
    
    def select(
        self,
        population: list[TestGene],
        num_parents: int,
        method: str = "tournament",
    ) -> SelectionResult:
        """
        Select parents from population.
        
        Args:
            population: Current population of test genes
            num_parents: Number of parents to select
            method: Selection method ("tournament", "roulette", "rank")
        
        Returns:
            SelectionResult with selected and elite genes
        """
        if not population:
            return SelectionResult()
        
        # Preserve elite genes
        sorted_pop = sorted(population, key=lambda g: g.fitness, reverse=True)
        num_elite = max(1, int(len(population) * self.elitism_ratio))
        elite_genes = [copy.deepcopy(g) for g in sorted_pop[:num_elite]]
        
        # Select remaining parents
        remaining = num_parents - len(elite_genes)
        if remaining <= 0:
            return SelectionResult(
                selected_genes=elite_genes,
                elite_genes=elite_genes,
                selection_pressure=1.0,
                diversity_maintained=0.0,
            )
        
        # Apply selection method
        if method == "roulette":
            selected = self.roulette_selection(population, remaining)
        elif method == "rank":
            selected = self.rank_selection(population, remaining)
        else:  # tournament
            selected = self.tournament_selection(population, remaining)
        
        all_selected = elite_genes + selected
        
        # Calculate diversity (unique genes / total)
        unique_ids = set(g.gene_id for g in all_selected)
        diversity = len(unique_ids) / len(all_selected) if all_selected else 0.0
        
        return SelectionResult(
            selected_genes=all_selected,
            elite_genes=elite_genes,
            selection_pressure=sum(g.fitness for g in elite_genes) / len(elite_genes) if elite_genes else 0.0,
            diversity_maintained=diversity,
        )
    
    # ══════════════════════════════════════════════════════════════════════════
    # CROSSOVER OPERATORS
    # ══════════════════════════════════════════════════════════════════════════
    
    def single_point_crossover(
        self,
        parent1: TestGene,
        parent2: TestGene,
    ) -> CrossoverResult:
        """
        Single-point crossover between two parent genes.
        
        Swaps inputs and assertions at a random crossover point.
        """
        if self.rng.random() > self.crossover_rate:
            # No crossover, return copies of parents
            return CrossoverResult(
                child1=copy.deepcopy(parent1),
                child2=copy.deepcopy(parent2),
                crossover_point=-1,
                parent1_contribution=1.0,
                parent2_contribution=1.0,
            )
        
        # Determine crossover point for inputs
        max_inputs = max(len(parent1.inputs), len(parent2.inputs))
        if max_inputs == 0:
            crossover_point = 0
        else:
            crossover_point = self.rng.randint(0, max_inputs)
        
        # Create children
        child1 = TestGene(
            gene_id=str(uuid.uuid4()),
            target_id=parent1.target_id,
            target_type=parent1.target_type,
            test_type=parent1.test_type,
            generation=max(parent1.generation, parent2.generation) + 1,
            parent_gene_ids=[parent1.gene_id, parent2.gene_id],
            discovered_by="aute",
            status=TestGeneStatus.CANDIDATE,
        )
        
        child2 = TestGene(
            gene_id=str(uuid.uuid4()),
            target_id=parent2.target_id,
            target_type=parent2.target_type,
            test_type=parent2.test_type,
            generation=max(parent1.generation, parent2.generation) + 1,
            parent_gene_ids=[parent1.gene_id, parent2.gene_id],
            discovered_by="aute",
            status=TestGeneStatus.CANDIDATE,
        )
        
        # Crossover inputs
        child1.inputs = parent1.inputs[:crossover_point] + parent2.inputs[crossover_point:]
        child2.inputs = parent2.inputs[:crossover_point] + parent1.inputs[crossover_point:]
        
        # Crossover assertions (similar logic)
        max_assertions = max(len(parent1.assertions), len(parent2.assertions))
        if max_assertions > 0:
            assertion_point = self.rng.randint(0, max_assertions)
            child1.assertions = parent1.assertions[:assertion_point] + parent2.assertions[assertion_point:]
            child2.assertions = parent2.assertions[:assertion_point] + parent1.assertions[assertion_point:]
        else:
            child1.assertions = []
            child2.assertions = []
        
        # Calculate contribution ratios
        p1_contrib = crossover_point / max_inputs if max_inputs > 0 else 0.5
        
        return CrossoverResult(
            child1=child1,
            child2=child2,
            crossover_point=crossover_point,
            parent1_contribution=p1_contrib,
            parent2_contribution=1.0 - p1_contrib,
        )
    
    def uniform_crossover(
        self,
        parent1: TestGene,
        parent2: TestGene,
    ) -> CrossoverResult:
        """
        Uniform crossover between two parent genes.
        
        Each input/assertion has 50% chance of coming from either parent.
        """
        if self.rng.random() > self.crossover_rate:
            return CrossoverResult(
                child1=copy.deepcopy(parent1),
                child2=copy.deepcopy(parent2),
                crossover_point=-1,
                parent1_contribution=1.0,
                parent2_contribution=1.0,
            )
        
        child1 = TestGene(
            gene_id=str(uuid.uuid4()),
            target_id=parent1.target_id,
            target_type=parent1.target_type,
            test_type=parent1.test_type,
            generation=max(parent1.generation, parent2.generation) + 1,
            parent_gene_ids=[parent1.gene_id, parent2.gene_id],
            discovered_by="aute",
            status=TestGeneStatus.CANDIDATE,
        )
        
        child2 = TestGene(
            gene_id=str(uuid.uuid4()),
            target_id=parent2.target_id,
            target_type=parent2.target_type,
            test_type=parent2.test_type,
            generation=max(parent1.generation, parent2.generation) + 1,
            parent_gene_ids=[parent1.gene_id, parent2.gene_id],
            discovered_by="aute",
            status=TestGeneStatus.CANDIDATE,
        )
        
        # Uniform crossover for inputs
        max_inputs = max(len(parent1.inputs), len(parent2.inputs))
        p1_count = 0
        for i in range(max_inputs):
            inp1 = parent1.inputs[i] if i < len(parent1.inputs) else None
            inp2 = parent2.inputs[i] if i < len(parent2.inputs) else None
            
            if self.rng.random() < 0.5:
                if inp1 is not None:
                    child1.inputs.append(inp1)
                    p1_count += 1
                if inp2 is not None:
                    child2.inputs.append(inp2)
            else:
                if inp2 is not None:
                    child1.inputs.append(inp2)
                if inp1 is not None:
                    child2.inputs.append(inp1)
                    p1_count += 1
        
        # Similar for assertions
        max_assertions = max(len(parent1.assertions), len(parent2.assertions))
        for i in range(max_assertions):
            a1 = parent1.assertions[i] if i < len(parent1.assertions) else None
            a2 = parent2.assertions[i] if i < len(parent2.assertions) else None
            
            if self.rng.random() < 0.5:
                if a1 is not None:
                    child1.assertions.append(a1)
                if a2 is not None:
                    child2.assertions.append(a2)
            else:
                if a2 is not None:
                    child1.assertions.append(a2)
                if a1 is not None:
                    child2.assertions.append(a1)
        
        p1_contrib = p1_count / max_inputs if max_inputs > 0 else 0.5
        
        return CrossoverResult(
            child1=child1,
            child2=child2,
            crossover_point=-1,  # N/A for uniform
            parent1_contribution=p1_contrib,
            parent2_contribution=1.0 - p1_contrib,
        )
    
    def crossover(
        self,
        parent1: TestGene,
        parent2: TestGene,
        method: str = "single_point",
    ) -> CrossoverResult:
        """
        Perform crossover between two parents.
        
        Args:
            parent1: First parent gene
            parent2: Second parent gene
            method: Crossover method ("single_point", "uniform")
        
        Returns:
            CrossoverResult with two child genes
        """
        if method == "uniform":
            return self.uniform_crossover(parent1, parent2)
        return self.single_point_crossover(parent1, parent2)
    
    # ══════════════════════════════════════════════════════════════════════════
    # MUTATION OPERATORS
    # ══════════════════════════════════════════════════════════════════════════
    
    def mutate_input(self, gene: TestGene) -> MutationResult:
        """Mutate an input value in the gene."""
        mutated = copy.deepcopy(gene)
        changes = []
        
        if mutated.inputs and self.rng.random() < self.mutation_rate:
            idx = self.rng.randint(0, len(mutated.inputs) - 1)
            old_value = mutated.inputs[idx]
            
            # Apply mutation based on input type
            if isinstance(old_value, (int, float)):
                # Numeric mutation
                delta = self.rng.gauss(0, abs(old_value) * 0.1 + 1)
                mutated.inputs[idx] = old_value + delta
            elif isinstance(old_value, str):
                # String mutation
                mutations = [
                    lambda s: s + self.rng.choice("abcdefghij"),
                    lambda s: s[:-1] if s else s,
                    lambda s: s.upper() if self.rng.random() < 0.5 else s.lower(),
                    lambda s: s + "\n",
                    lambda s: "",
                ]
                mutated.inputs[idx] = self.rng.choice(mutations)(old_value)
            elif isinstance(old_value, list):
                # Array mutation
                if old_value:
                    old_value.pop(self.rng.randint(0, len(old_value) - 1))
                else:
                    old_value.append(None)
                mutated.inputs[idx] = old_value
            
            changes.append(f"input[{idx}]: {old_value} -> {mutated.inputs[idx]}")
            
            # Record mutation
            mutated.add_mutation(MutationRecord(
                mutation_type=MutationType.INPUT_CHANGE,
                before_ref=str(old_value),
                after_ref=str(mutated.inputs[idx]),
                reason="Input mutation",
            ))
        
        return MutationResult(
            mutated_gene=mutated,
            mutation_applied=MutationType.INPUT_CHANGE,
            mutation_strength=self.mutation_rate,
            changes_made=changes,
        )
    
    def mutate_assertion(self, gene: TestGene) -> MutationResult:
        """Mutate an assertion in the gene."""
        mutated = copy.deepcopy(gene)
        changes = []
        
        if mutated.assertions and self.rng.random() < self.mutation_rate:
            idx = self.rng.randint(0, len(mutated.assertions) - 1)
            assertion = mutated.assertions[idx]
            
            # Mutate assertion type or expected value
            if self.rng.random() < 0.5:
                # Change assertion type
                old_type = assertion.assertion_type
                new_types = [t for t in AssertionType if t != old_type]
                assertion.assertion_type = self.rng.choice(new_types)
                changes.append(f"assertion[{idx}].type: {old_type.value} -> {assertion.assertion_type.value}")
            else:
                # Change expected value
                old_expected = assertion.expected
                if isinstance(old_expected, (int, float)):
                    assertion.expected = old_expected + self.rng.gauss(0, 1)
                elif isinstance(old_expected, bool):
                    assertion.expected = not old_expected
                elif isinstance(old_expected, str):
                    assertion.expected = old_expected + "_mutated"
                changes.append(f"assertion[{idx}].expected: {old_expected} -> {assertion.expected}")
            
            mutated.add_mutation(MutationRecord(
                mutation_type=MutationType.ASSERTION_CHANGE,
                before_ref=str(idx),
                after_ref=assertion.to_dict().__str__(),
                reason="Assertion mutation",
            ))
        
        return MutationResult(
            mutated_gene=mutated,
            mutation_applied=MutationType.ASSERTION_CHANGE,
            mutation_strength=self.mutation_rate,
            changes_made=changes,
        )
    
    def mutate_boundary(self, gene: TestGene) -> MutationResult:
        """Inject boundary values into gene inputs."""
        mutated = copy.deepcopy(gene)
        changes = []
        
        if self.rng.random() < self.mutation_rate:
            # Boundary values to inject
            boundaries = [
                None, 0, -1, 2147483647, -2147483648,
                "", " ", "\n", "null", "undefined",
                [], {}, float('inf'), float('-inf'),
            ]
            
            boundary = self.rng.choice(boundaries)
            
            if mutated.inputs:
                idx = self.rng.randint(0, len(mutated.inputs) - 1)
                old_value = mutated.inputs[idx]
                mutated.inputs[idx] = boundary
                changes.append(f"input[{idx}]: {old_value} -> {boundary} (boundary)")
            else:
                mutated.inputs.append(boundary)
                changes.append(f"input[new]: {boundary} (boundary)")
            
            mutated.add_mutation(MutationRecord(
                mutation_type=MutationType.BOUNDARY_INJECTION,
                before_ref="inputs",
                after_ref=str(boundary),
                reason="Boundary injection",
            ))
        
        return MutationResult(
            mutated_gene=mutated,
            mutation_applied=MutationType.BOUNDARY_INJECTION,
            mutation_strength=self.mutation_rate,
            changes_made=changes,
        )
    
    def mutate(
        self,
        gene: TestGene,
        mutation_type: Optional[MutationType] = None,
    ) -> MutationResult:
        """
        Apply mutation to a test gene.
        
        Args:
            gene: Gene to mutate
            mutation_type: Specific mutation type, or random if None
        
        Returns:
            MutationResult with mutated gene
        """
        if mutation_type is None:
            mutation_type = self.rng.choice([
                MutationType.INPUT_CHANGE,
                MutationType.ASSERTION_CHANGE,
                MutationType.BOUNDARY_INJECTION,
            ])
        
        if mutation_type == MutationType.INPUT_CHANGE:
            return self.mutate_input(gene)
        elif mutation_type == MutationType.ASSERTION_CHANGE:
            return self.mutate_assertion(gene)
        elif mutation_type == MutationType.BOUNDARY_INJECTION:
            return self.mutate_boundary(gene)
        
        # Default to input mutation
        return self.mutate_input(gene)
    
    # ══════════════════════════════════════════════════════════════════════════
    # POPULATION EVOLUTION
    # ══════════════════════════════════════════════════════════════════════════
    
    def evolve_population(
        self,
        population: list[TestGene],
        target_size: int,
        selection_method: str = "tournament",
        crossover_method: str = "single_point",
    ) -> list[TestGene]:
        """
        Evolve a population through one generation.
        
        Args:
            population: Current population
            target_size: Desired population size
            selection_method: Selection method to use
            crossover_method: Crossover method to use
        
        Returns:
            New population after evolution
        """
        if not population:
            return []
        
        # Selection
        selection = self.select(population, target_size, selection_method)
        new_population = list(selection.elite_genes)
        
        # Fill remaining slots with offspring
        parents = selection.selected_genes
        while len(new_population) < target_size and len(parents) >= 2:
            # Select two parents
            p1, p2 = self.rng.sample(parents, 2)
            
            # Crossover
            result = self.crossover(p1, p2, crossover_method)
            
            # Mutation
            if result.child1:
                mutation1 = self.mutate(result.child1)
                new_population.append(mutation1.mutated_gene)
            
            if result.child2 and len(new_population) < target_size:
                mutation2 = self.mutate(result.child2)
                new_population.append(mutation2.mutated_gene)
        
        return new_population[:target_size]
