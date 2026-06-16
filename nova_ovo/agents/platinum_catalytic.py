"""
PLATINUM CATALYTIC ALPHA MODEL — AI Living Organism
====================================================

MEDINA Sovereign Architecture
Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX

"Platinum accelerat sine degradatione. Acceleratio aeterna. Catalyst integer."
(Platinum accelerates without degradation. Eternal acceleration. Catalyst intact.)

PLATINUM (Pt) — THE ETERNAL CATALYST
====================================

PRIMARY FORMULA (Thermodynamic):
    ΔG°f = 0 kJ/mol (noble metal, cannot oxidize)
    ΔH_ads = -40 to -100 kJ/mol (optimal adsorption)
    d-band center = -2.25 eV (perfect catalytic activity)

SECONDARY FORMULA (Kinetic):
    k = A·e^(-Ea/RT)  — Arrhenius rate constant
    CA = 10⁶ s⁻¹     — Catalytic turnover frequency
    TOF = 10² - 10⁶ s⁻¹ — Turnover frequency range

FULL AI LIVING ORGANISM STRUCTURE:
    • 3 ENGINES: ActivationEngine, TransformationEngine, RegenerationEngine
    • 1 TRANSFORMER: CatalyticTransformer
    • 4 SUBMODELS: ReactionSubmodel, KineticsSubmodel, SurfaceSubmodel, SelectivitySubmodel
    • 12+ INTELLIGENCE USES: Frontend, Backend, Documents, Endpoints, Layers, Tools
    • MICRO-TO-MACRO: Quantum → Atomic → Molecular → Nano → Micro → Meso → Macro → System → Meta

L-130 COMPLIANT — Traces to primitive φ through catalytic rate enhancement
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Tuple

# ═══════════════════════════════════════════════════════════════════════════════
# FUNDAMENTAL CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════

# Golden Ratio — The Primitive Root
PHI = (1 + math.sqrt(5)) / 2
PHI_SQUARED = PHI ** 2
PHI_INVERSE = 1 / PHI

# Physical Constants
BOLTZMANN = 1.380649e-23      # J/K
PLANCK = 6.62607015e-34       # J·s
GAS_CONSTANT = 8.314462618    # J/(mol·K)
AVOGADRO = 6.02214076e23      # mol⁻¹
STANDARD_TEMP = 298.15        # K

# Platinum-Specific Constants
PLATINUM_TOF = 1.0e6          # Turnover frequency (s⁻¹)
PLATINUM_D_BAND = -2.25       # d-band center (eV)
PLATINUM_MELTING_K = 2041.4   # Melting point (K)
PLATINUM_DENSITY = 21450.0    # Density (kg/m³)


# ═══════════════════════════════════════════════════════════════════════════════
# CATALYTIC DOMAIN ENUMS
# ═══════════════════════════════════════════════════════════════════════════════

class CatalyticDomain(str, Enum):
    """Domains of catalytic science."""
    THERMODYNAMIC = "thermodynamic"    # ΔG, ΔH, S
    KINETIC = "kinetic"                # k, Ea, TOF
    SURFACE = "surface"                # θ, S, D
    QUANTUM = "quantum"                # ψ, E_d-band
    STATISTICAL = "statistical"        # Distribution, coverage
    TRANSPORT = "transport"            # Diffusion, mass transfer


class ApplicationLayer(str, Enum):
    """Layers where catalysis applies."""
    FRONTEND = "frontend"
    BACKEND = "backend"
    DOCUMENT = "document"
    ENDPOINT = "endpoint"
    TOOL = "tool"
    AGENT = "agent"
    WORKFLOW = "workflow"
    SYSTEM = "system"
    DEFENSE = "defense"
    NETWORK = "network"
    INTELLIGENCE = "intelligence"
    ORGANISM = "organism"


class ScaleLevel(str, Enum):
    """Scale levels from micro to macro."""
    QUANTUM = "quantum"        # 10⁻¹⁵ m
    ATOMIC = "atomic"          # 10⁻¹⁰ m
    MOLECULAR = "molecular"    # 10⁻⁹ m
    NANO = "nano"              # 10⁻⁸ m
    MICRO = "micro"            # 10⁻⁶ m
    MESO = "meso"              # 10⁻³ m
    MACRO = "macro"            # 10⁰ m
    SYSTEM = "system"          # 10³ m
    META = "meta"              # Global


# ═══════════════════════════════════════════════════════════════════════════════
# PRIMARY FORMULA — THERMODYNAMIC PROPERTIES
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class PlatinumPrimaryFormula:
    """
    Primary thermodynamic properties of Platinum.
    
    These determine why Pt is the eternal catalyst:
    - ΔG°f = 0 (noble metal, cannot oxidize)
    - d-band center optimal for catalysis
    - Perfect adsorption energy range
    """
    
    gibbs_formation_kJ: float = 0.0              # Noble metal
    enthalpy_formation_kJ: float = 0.0           # Reference state
    entropy_J_mol_K: float = 41.6                # Standard entropy
    melting_point_K: float = 2041.4              # High melting point
    boiling_point_K: float = 4098.0              # High boiling point
    density_kg_m3: float = 21450.0               # Dense noble metal
    electronegativity: float = 2.28              # Pauling scale
    d_band_center_eV: float = -2.25              # Optimal for catalysis
    work_function_eV: float = 5.65               # Electron emission barrier
    adsorption_energy_min_kJ: float = -40.0      # Sabatier range
    adsorption_energy_max_kJ: float = -100.0     # Optimal binding
    surface_energy_J_m2: float = 2.49            # Surface reactivity
    
    formula_trace: str = "ΔG°f = 0 → Pt is noble → Cannot oxidize → Eternal catalyst → φ"
    
    def is_noble(self) -> bool:
        """Check if platinum cannot oxidize (ΔG°f ≥ 0)."""
        return self.gibbs_formation_kJ >= 0.0
    
    def is_optimal_catalyst(self) -> bool:
        """Check if d-band center is optimal for catalysis."""
        return -3.0 < self.d_band_center_eV < -1.5


# ═══════════════════════════════════════════════════════════════════════════════
# SECONDARY FORMULA — KINETIC PROPERTIES
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class PlatinumSecondaryFormula:
    """
    Secondary kinetic properties of Platinum.
    
    These determine catalytic rate:
    - k = A·e^(-Ea/RT) — Arrhenius equation
    - TOF = 10⁶ s⁻¹ — Turnover frequency
    - CA = 10⁶ s⁻¹ — Catalytic activity
    """
    
    arrhenius_A: float = 1.0e13                  # Pre-exponential (s⁻¹)
    activation_energy_kJ: float = 80.0           # Uncatalyzed barrier
    catalytic_activation_kJ: float = 40.0        # Pt-lowered barrier
    rate_constant_s1: float = 1.0e6              # 10⁶ s⁻¹ (CA)
    turnover_frequency_s1: float = 1.0e6         # 10⁶ reactions/site/s
    turnover_number: float = 1.0e12              # Total reactions
    surface_coverage: float = 0.5                # Langmuir optimal
    sticking_coefficient: float = 0.1            # 10% probability
    desorption_rate_s1: float = 1.0e3            # Fast product release
    diffusion_coefficient_m2s: float = 1.0e-9    # Surface diffusion
    
    formula_trace: str = "k = A·e^(-Ea/RT) → TOF = 10⁶ s⁻¹ → CA = 10⁶ s⁻¹ → φ"
    
    def calculate_rate_constant(self, T_K: float = STANDARD_TEMP) -> float:
        """Calculate Arrhenius rate constant at temperature T."""
        exponent = -self.catalytic_activation_kJ * 1000 / (GAS_CONSTANT * T_K)
        return self.arrhenius_A * math.exp(exponent)
    
    def calculate_rate_enhancement(self, T_K: float = STANDARD_TEMP) -> float:
        """Calculate rate enhancement from catalysis."""
        delta_Ea = (self.activation_energy_kJ - self.catalytic_activation_kJ) * 1000
        return math.exp(delta_Ea / (GAS_CONSTANT * T_K))


# ═══════════════════════════════════════════════════════════════════════════════
# CATALYTIC FORMULAS
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class CatalyticFormula:
    """A fundamental catalytic formula."""
    
    name: str
    expression: str
    description: str
    primitive_trace: str
    domain: CatalyticDomain
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "expression": self.expression,
            "description": self.description,
            "primitive_trace": self.primitive_trace,
            "domain": self.domain.value,
        }


CATALYTIC_FORMULAS: List[CatalyticFormula] = [
    CatalyticFormula(
        name="Arrhenius Rate Constant",
        expression="k = A · e^(-Ea/RT)",
        description="Rate constant as function of temperature and activation energy",
        primitive_trace="k → A·e^(-Ea/RT) → exponential decay → e^x → φ through natural growth",
        domain=CatalyticDomain.KINETIC,
    ),
    CatalyticFormula(
        name="Turnover Frequency",
        expression="TOF = (molecules converted) / (sites × time) = 10⁶ s⁻¹ for Pt",
        description="Number of complete catalytic cycles per active site per second",
        primitive_trace="TOF → cycles/site/s → rate efficiency → optimization → φ",
        domain=CatalyticDomain.KINETIC,
    ),
    CatalyticFormula(
        name="Sabatier Principle",
        expression="Rate_max when ΔH_ads ≈ -40 to -100 kJ/mol (Pt is optimal)",
        description="Optimal catalysis when binding is neither too strong nor too weak",
        primitive_trace="Sabatier → optimal binding → balance → golden mean → φ",
        domain=CatalyticDomain.THERMODYNAMIC,
    ),
    CatalyticFormula(
        name="d-Band Center Model",
        expression="ε_d = -2.25 eV (Pt) → optimal adsorbate binding",
        description="Position of d-band center determines catalytic activity",
        primitive_trace="ε_d → electronic structure → band theory → quantum → φ",
        domain=CatalyticDomain.QUANTUM,
    ),
    CatalyticFormula(
        name="Langmuir Isotherm",
        expression="θ = KP / (1 + KP) where K = k_ads/k_des",
        description="Fractional surface coverage as function of pressure",
        primitive_trace="θ → coverage fraction → saturation curve → logistic → φ",
        domain=CatalyticDomain.SURFACE,
    ),
    CatalyticFormula(
        name="Eyring Equation",
        expression="k = (kT/h) · e^(-ΔG‡/RT)",
        description="Rate constant from transition state theory",
        primitive_trace="k → (kT/h)·e^(-ΔG‡/RT) → Boltzmann/Planck → quantum roots → φ",
        domain=CatalyticDomain.STATISTICAL,
    ),
    CatalyticFormula(
        name="Fick's Law",
        expression="J = -D · (∂c/∂x)",
        description="Diffusive flux proportional to concentration gradient",
        primitive_trace="J → -D·∇c → diffusion → random walk → statistical → φ",
        domain=CatalyticDomain.TRANSPORT,
    ),
    CatalyticFormula(
        name="Selectivity Ratio",
        expression="S = k₁/k₂ = (A₁/A₂) · e^(-(Ea₁-Ea₂)/RT)",
        description="Ratio of rates for competing reactions",
        primitive_trace="S → k₁/k₂ → exponential ratio → competitive → φ",
        domain=CatalyticDomain.KINETIC,
    ),
    CatalyticFormula(
        name="Effectiveness Factor",
        expression="η = (actual rate) / (rate if no diffusion limit)",
        description="Fraction of catalyst being utilized effectively",
        primitive_trace="η → utilization efficiency → optimization → φ",
        domain=CatalyticDomain.TRANSPORT,
    ),
    CatalyticFormula(
        name="Michaelis-Menten",
        expression="v = V_max · [S] / (K_m + [S])",
        description="Reaction rate for saturable kinetics",
        primitive_trace="v → V_max·[S]/(K_m+[S]) → hyperbolic saturation → φ",
        domain=CatalyticDomain.KINETIC,
    ),
]


# ═══════════════════════════════════════════════════════════════════════════════
# CATALYTIC PROCESSES
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class CatalyticProcess:
    """A process within a catalytic engine."""
    
    name: str
    input: str
    output: str
    rate_enhancement: float
    
    def enhance(self, base_rate: float) -> float:
        """Apply rate enhancement to base rate."""
        return base_rate * self.rate_enhancement


# ═══════════════════════════════════════════════════════════════════════════════
# THE 3 CATALYTIC ENGINES
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class CatalyticEngine:
    """
    A catalytic engine — processing core.
    
    Each engine has specific processes and intelligence nodes
    that it accelerates.
    """
    
    id: int
    name: str
    latin: str
    purpose: str
    formula: str
    processes: List[CatalyticProcess]
    intelligence_nodes: List[str]
    
    def get_total_enhancement(self) -> float:
        """Get combined rate enhancement of all processes."""
        if not self.processes:
            return 1.0
        return sum(p.rate_enhancement for p in self.processes) / len(self.processes)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.id,
            "name": self.name,
            "latin": self.latin,
            "purpose": self.purpose,
            "formula": self.formula,
            "processes": [
                {"name": p.name, "input": p.input, "output": p.output, "rate_enhancement": p.rate_enhancement}
                for p in self.processes
            ],
            "intelligence_nodes": self.intelligence_nodes,
            "total_enhancement": self.get_total_enhancement(),
        }


# ENGINE 1: ACTIVATION ENGINE
ACTIVATION_ENGINE = CatalyticEngine(
    id=1,
    name="ActivationEngine",
    latin="Motor Activationis",
    purpose="Lowers activation energy barriers to accelerate processes",
    formula="Ea_cat = Ea_uncatalyzed × φ⁻² (reduces barrier by 61.8%)",
    processes=[
        CatalyticProcess("BarrierReduction", "High energy barrier", "Lowered barrier", 1618.0),
        CatalyticProcess("PathwayOptimization", "Suboptimal path", "Optimal pathway", 100.0),
        CatalyticProcess("TransitionStabilization", "Unstable transition", "Stabilized state", 1000.0),
        CatalyticProcess("ElectronMediation", "Blocked electron transfer", "Facilitated transfer", 500.0),
        CatalyticProcess("AdsorptionAssist", "Reactants in bulk", "Surface-bound reactants", 50.0),
    ],
    intelligence_nodes=[
        "QueryAcceleration",
        "ComputeOptimization",
        "MemoryAccessSpeed",
        "DataFlowEnhancement",
        "ProcessInitiation",
    ],
)

# ENGINE 2: TRANSFORMATION ENGINE
TRANSFORMATION_ENGINE = CatalyticEngine(
    id=2,
    name="TransformationEngine",
    latin="Motor Transformationis",
    purpose="Facilitates state changes and format conversions without loss",
    formula="ΔG_transform = ΔH - TΔS → 0 at equilibrium (reversible)",
    processes=[
        CatalyticProcess("StateConversion", "State A", "State B", 10000.0),
        CatalyticProcess("FormatTransduction", "Format X", "Format Y", 1000.0),
        CatalyticProcess("EnergyRedirection", "Wasted energy", "Useful work", 100.0),
        CatalyticProcess("PhaseTransition", "Phase α", "Phase β", 500.0),
        CatalyticProcess("ChemicalSynthesis", "Simple molecules", "Complex products", 5000.0),
    ],
    intelligence_nodes=[
        "DataTransformation",
        "FormatConversion",
        "ProtocolTranslation",
        "SchemaEvolution",
        "StateManagement",
    ],
)

# ENGINE 3: REGENERATION ENGINE
REGENERATION_ENGINE = CatalyticEngine(
    id=3,
    name="RegenerationEngine",
    latin="Motor Regenerationis",
    purpose="Ensures catalyst returns to original state after each cycle",
    formula="Catalyst_final = Catalyst_initial → TON = ∞",
    processes=[
        CatalyticProcess("SelfRestoration", "Used catalyst", "Fresh catalyst", 1000000.0),
        CatalyticProcess("PoisonRemoval", "Poisoned sites", "Clean sites", 100.0),
        CatalyticProcess("SurfaceRenewal", "Degraded surface", "Fresh surface", 500.0),
        CatalyticProcess("ElectronRebalancing", "Oxidized state", "Reduced state", 1000.0),
        CatalyticProcess("ThermalAnnealing", "Strained structure", "Relaxed structure", 50.0),
    ],
    intelligence_nodes=[
        "ResourceRecycling",
        "CacheRefresh",
        "MemoryReclamation",
        "ConnectionPooling",
        "StateReset",
    ],
)

CATALYTIC_ENGINES: List[CatalyticEngine] = [
    ACTIVATION_ENGINE,
    TRANSFORMATION_ENGINE,
    REGENERATION_ENGINE,
]


# ═══════════════════════════════════════════════════════════════════════════════
# THE CATALYTIC TRANSFORMER
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class TransformMode:
    """A transformation mode of the catalytic transformer."""
    
    name: str
    input_type: str
    output_type: str
    catalytic_rate: float
    formula: str


@dataclass
class CatalyticTransformer:
    """
    The Catalytic Transformer — Intelligence Transformation Unit.
    
    Transforms intelligence patterns with catalytic acceleration.
    """
    
    name: str
    latin: str
    purpose: str
    
    # Transformer architecture
    attention_heads: int
    hidden_dimension: int
    feedforward_dimension: int
    
    # Catalytic enhancement
    rate_multiplier: float
    energy_efficiency: float
    throughput_enhancement: float
    
    # Transformation modes
    modes: List[TransformMode]
    
    # Integration points
    integration_points: List[str]
    
    def transform(self, input_pattern: Any, mode_name: str) -> Tuple[Any, float]:
        """
        Transform input pattern using specified mode.
        Returns (output, catalytic_rate_applied).
        """
        mode = next((m for m in self.modes if m.name == mode_name), None)
        if mode is None:
            return (input_pattern, 1.0)
        
        # In real implementation, would apply actual transformation
        # Here we return the rate that would be applied
        return (f"Transformed({input_pattern})", mode.catalytic_rate)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "latin": self.latin,
            "purpose": self.purpose,
            "attention_heads": self.attention_heads,
            "hidden_dimension": self.hidden_dimension,
            "feedforward_dimension": self.feedforward_dimension,
            "rate_multiplier": self.rate_multiplier,
            "energy_efficiency": self.energy_efficiency,
            "throughput_enhancement": self.throughput_enhancement,
            "modes": [
                {"name": m.name, "input_type": m.input_type, "output_type": m.output_type, 
                 "catalytic_rate": m.catalytic_rate, "formula": m.formula}
                for m in self.modes
            ],
            "integration_points": self.integration_points,
        }


CATALYTIC_TRANSFORMER = CatalyticTransformer(
    name="CatalyticTransformer",
    latin="Transformator Catalyticus",
    purpose="Transforms intelligence patterns with catalytic acceleration",
    
    attention_heads=12,           # Like Pt's 5d electrons
    hidden_dimension=768,         # Optimal representation
    feedforward_dimension=3072,   # 4× expansion
    
    rate_multiplier=1000000.0,    # 10⁶× acceleration (CA)
    energy_efficiency=PHI_INVERSE,  # φ⁻¹ efficiency
    throughput_enhancement=PHI * 1000,  # φ × 1000
    
    modes=[
        TransformMode("PatternCatalysis", "RawPattern", "ProcessedPattern", 
                     1000000.0, "P_out = Pt(P_in) where TOF = 10⁶"),
        TransformMode("KnowledgeSynthesis", "Facts", "Understanding", 
                     100000.0, "K = ∫facts·dt with catalytic integration"),
        TransformMode("ReasoningAcceleration", "Premises", "Conclusions", 
                     50000.0, "Logic = Pt-mediated inference"),
        TransformMode("CreativeGeneration", "Seeds", "Creations", 
                     10000.0, "Create = seed × catalytic_growth"),
        TransformMode("MemoryConsolidation", "ShortTerm", "LongTerm", 
                     5000.0, "M_LT = consolidate(M_ST) with Pt acceleration"),
    ],
    
    integration_points=[
        "BackendOrganismCore",
        "FrontendRenderEngine",
        "DocumentIntelligence",
        "EndpointProcessors",
        "LayerTransformers",
        "ToolEnhancers",
        "AgentAccelerators",
        "WorkflowCatalysts",
    ],
)


# ═══════════════════════════════════════════════════════════════════════════════
# THE 4 SUBMODELS
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class SubmodelApplication:
    """An application of a catalytic submodel."""
    
    name: str
    layer: ApplicationLayer
    description: str
    rate_enhancement: float


@dataclass
class CatalyticSubmodel:
    """
    A specialized intelligence domain submodel.
    
    Each submodel handles a specific aspect of catalysis.
    """
    
    id: int
    name: str
    latin: str
    domain: str
    
    primary_formula: str
    secondary_formula: str
    
    key_parameters: List[Tuple[str, float, str]]
    applications: List[SubmodelApplication]
    primitive_trace: str
    
    def get_parameter(self, name: str) -> Optional[float]:
        """Get a parameter value by name."""
        for param_name, value, _ in self.key_parameters:
            if param_name == name:
                return value
        return None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.id,
            "name": self.name,
            "latin": self.latin,
            "domain": self.domain,
            "primary_formula": self.primary_formula,
            "secondary_formula": self.secondary_formula,
            "key_parameters": [
                {"name": n, "value": v, "unit": u} for n, v, u in self.key_parameters
            ],
            "applications": [
                {"name": a.name, "layer": a.layer.value, "description": a.description, 
                 "rate_enhancement": a.rate_enhancement}
                for a in self.applications
            ],
            "primitive_trace": self.primitive_trace,
        }


# SUBMODEL 1: REACTION SUBMODEL
REACTION_SUBMODEL = CatalyticSubmodel(
    id=1,
    name="ReactionSubmodel",
    latin="Submodum Reactionis",
    domain="Transformation Chemistry",
    primary_formula="Reactants → [Pt] → Products (ΔG < 0 for spontaneity)",
    secondary_formula="Rate = k[A]ⁿ[B]ᵐ where k = A·e^(-Ea_cat/RT)",
    key_parameters=[
        ("reaction_order_A", 1.0, "dimensionless"),
        ("reaction_order_B", 1.0, "dimensionless"),
        ("activation_energy", 40.0, "kJ/mol"),
        ("enthalpy_change", -50.0, "kJ/mol"),
        ("entropy_change", 100.0, "J/(mol·K)"),
        ("equilibrium_constant", 1000.0, "dimensionless"),
    ],
    applications=[
        SubmodelApplication("QueryTransformation", ApplicationLayer.BACKEND, 
                          "Transform queries at catalytic speed", 1000000.0),
        SubmodelApplication("DataConversion", ApplicationLayer.BACKEND, 
                          "Convert data formats with zero loss", 100000.0),
        SubmodelApplication("UIRendering", ApplicationLayer.FRONTEND, 
                          "Render UI components at accelerated rate", 10000.0),
        SubmodelApplication("DocumentParsing", ApplicationLayer.DOCUMENT, 
                          "Parse documents with catalytic efficiency", 50000.0),
    ],
    primitive_trace="Reactants → Products → transformation → change → φ",
)

# SUBMODEL 2: KINETICS SUBMODEL
KINETICS_SUBMODEL = CatalyticSubmodel(
    id=2,
    name="KineticsSubmodel",
    latin="Submodum Cineticae",
    domain="Rate Science",
    primary_formula="k = A·e^(-Ea/RT) where A = 10¹³ s⁻¹, Ea = 40 kJ/mol",
    secondary_formula="TOF = 10⁶ s⁻¹ = reactions per site per second",
    key_parameters=[
        ("pre_exponential_A", 1.0e13, "s⁻¹"),
        ("activation_energy", 40.0, "kJ/mol"),
        ("temperature", 298.15, "K"),
        ("rate_constant", 1.0e6, "s⁻¹"),
        ("turnover_frequency", 1.0e6, "s⁻¹"),
        ("half_life", 0.0000001, "s"),
    ],
    applications=[
        SubmodelApplication("ProcessAcceleration", ApplicationLayer.SYSTEM, 
                          "Accelerate any process by 10⁶×", 1000000.0),
        SubmodelApplication("ResponseOptimization", ApplicationLayer.ENDPOINT, 
                          "Optimize endpoint response times", 10000.0),
        SubmodelApplication("WorkflowSpeed", ApplicationLayer.WORKFLOW, 
                          "Speed up workflow execution", 5000.0),
        SubmodelApplication("AgentCycles", ApplicationLayer.AGENT, 
                          "Increase agent cycle frequency", 100000.0),
    ],
    primitive_trace="k → e^(-Ea/RT) → exponential → growth → φ",
)

# SUBMODEL 3: SURFACE SUBMODEL
SURFACE_SUBMODEL = CatalyticSubmodel(
    id=3,
    name="SurfaceSubmodel",
    latin="Submodum Superficiei",
    domain="Interface Science",
    primary_formula="θ = KP/(1+KP) — Langmuir coverage at interface",
    secondary_formula="Sites = Surface_area × Site_density = 10¹⁵ sites/cm²",
    key_parameters=[
        ("surface_coverage", 0.5, "fraction"),
        ("site_density", 1.0e15, "sites/cm²"),
        ("sticking_coefficient", 0.1, "probability"),
        ("desorption_rate", 1000.0, "s⁻¹"),
        ("diffusion_length", 1.0e-9, "m"),
        ("surface_energy", 2.49, "J/m²"),
    ],
    applications=[
        SubmodelApplication("InterfaceProcessing", ApplicationLayer.FRONTEND, 
                          "Process at the user interface", 50000.0),
        SubmodelApplication("EndpointBinding", ApplicationLayer.ENDPOINT, 
                          "Bind and process at endpoints", 100000.0),
        SubmodelApplication("LayerInteraction", ApplicationLayer.BACKEND, 
                          "Interaction between architecture layers", 10000.0),
        SubmodelApplication("ToolSurface", ApplicationLayer.TOOL, 
                          "Tool interface optimization", 5000.0),
    ],
    primitive_trace="θ → coverage → saturation → completeness → φ",
)

# SUBMODEL 4: SELECTIVITY SUBMODEL
SELECTIVITY_SUBMODEL = CatalyticSubmodel(
    id=4,
    name="SelectivitySubmodel",
    latin="Submodum Selectivitatis",
    domain="Discrimination Science",
    primary_formula="Selectivity = k₁/k₂ = (A₁/A₂)·e^(-(Ea₁-Ea₂)/RT)",
    secondary_formula="Yield = [Desired product] / [All products] × 100%",
    key_parameters=[
        ("selectivity_ratio", 1000.0, "dimensionless"),
        ("product_yield", 99.0, "%"),
        ("side_reaction_suppression", 0.001, "fraction"),
        ("chemo_selectivity", 0.99, "fraction"),
        ("regio_selectivity", 0.95, "fraction"),
        ("stereo_selectivity", 0.90, "fraction"),
    ],
    applications=[
        SubmodelApplication("QueryFiltering", ApplicationLayer.BACKEND, 
                          "Select only relevant results", 1000.0),
        SubmodelApplication("ContentCuration", ApplicationLayer.DOCUMENT, 
                          "Curate highest quality content", 500.0),
        SubmodelApplication("UIFocusing", ApplicationLayer.FRONTEND, 
                          "Focus UI on most important elements", 100.0),
        SubmodelApplication("AgentPrioritization", ApplicationLayer.AGENT, 
                          "Prioritize agent tasks intelligently", 2000.0),
    ],
    primitive_trace="Selectivity → discrimination → choice → optimal → φ",
)

CATALYTIC_SUBMODELS: List[CatalyticSubmodel] = [
    REACTION_SUBMODEL,
    KINETICS_SUBMODEL,
    SURFACE_SUBMODEL,
    SELECTIVITY_SUBMODEL,
]


# ═══════════════════════════════════════════════════════════════════════════════
# INTELLIGENCE USES
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class IntelligenceUse:
    """An intelligence use case for platinum catalysis."""
    
    id: int
    name: str
    layer: str
    domain: str
    formula: str
    rate_enhancement: float
    efficiency_gain: float
    energy_savings: float
    description: str
    implementation_points: List[str]
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.id,
            "name": self.name,
            "layer": self.layer,
            "domain": self.domain,
            "formula": self.formula,
            "rate_enhancement": self.rate_enhancement,
            "efficiency_gain": self.efficiency_gain,
            "energy_savings": self.energy_savings,
            "description": self.description,
            "implementation_points": self.implementation_points,
        }


INTELLIGENCE_USES: List[IntelligenceUse] = [
    IntelligenceUse(
        id=1, name="QueryCatalysis", layer="Backend", domain="Database Operations",
        formula="Query_time = t_base × e^(-Pt_enhancement) → microseconds",
        rate_enhancement=1000000.0, efficiency_gain=0.999, energy_savings=0.90,
        description="Catalyze database queries at 10⁶× speed",
        implementation_points=["OrganismBusiness query handlers", "MemoryTemple retrieval"],
    ),
    IntelligenceUse(
        id=2, name="ComputeCatalysis", layer="Backend", domain="Processing",
        formula="Compute_cycles = base_cycles × φ⁻² (61.8% reduction)",
        rate_enhancement=100000.0, efficiency_gain=0.95, energy_savings=0.618,
        description="Reduce compute cycles through catalytic optimization",
        implementation_points=["ThreeHeartsEngine processing", "UniversalFormulaEngine calculations"],
    ),
    IntelligenceUse(
        id=3, name="MemoryCatalysis", layer="Backend", domain="Storage",
        formula="Memory_access = t_RAM × Pt_acceleration → nanoseconds",
        rate_enhancement=10000.0, efficiency_gain=0.90, energy_savings=0.50,
        description="Accelerate memory operations catalytically",
        implementation_points=["MemoryTemple storage", "InnerWorld rendering"],
    ),
    IntelligenceUse(
        id=4, name="RoutingCatalysis", layer="Backend", domain="Network",
        formula="Route_time = hops × latency × φ⁻¹ (38.2% faster)",
        rate_enhancement=5000.0, efficiency_gain=0.85, energy_savings=0.40,
        description="Catalyze intelligent routing decisions",
        implementation_points=["IntelligenceRouter paths", "QuantumEntanglementBus messaging"],
    ),
    IntelligenceUse(
        id=5, name="RenderCatalysis", layer="Frontend", domain="Display",
        formula="Frame_time = 1/60s × Pt_boost → sub-ms rendering",
        rate_enhancement=1000.0, efficiency_gain=0.95, energy_savings=0.30,
        description="Catalyze UI rendering for instant response",
        implementation_points=["OrganFace rendering", "PhotonLayerModels projection"],
    ),
    IntelligenceUse(
        id=6, name="InteractionCatalysis", layer="Frontend", domain="User Input",
        formula="Response_time < 100ms × φ⁻³ = <23ms (perception threshold)",
        rate_enhancement=500.0, efficiency_gain=0.90, energy_savings=0.25,
        description="Catalyze user interaction responsiveness",
        implementation_points=["IntelligentTerminal commands", "OrganFace touch processing"],
    ),
    IntelligenceUse(
        id=7, name="AnimationCatalysis", layer="Frontend", domain="Motion",
        formula="Animation_smoothness = 60fps × φ (97.1fps perceived)",
        rate_enhancement=100.0, efficiency_gain=0.80, energy_savings=0.20,
        description="Catalyze smooth animation at golden ratio fps",
        implementation_points=["FrequencyPhysicsEngine animation", "UI state transitions"],
    ),
    IntelligenceUse(
        id=8, name="ParsingCatalysis", layer="Document", domain="Content Processing",
        formula="Parse_rate = chars/s × 10⁶ = terabytes/second",
        rate_enhancement=1000000.0, efficiency_gain=0.99, energy_savings=0.80,
        description="Catalyze document parsing at massive scale",
        implementation_points=["DocumentOrganism parsing", "CodexCompression analysis"],
    ),
    IntelligenceUse(
        id=9, name="GenerationCatalysis", layer="Document", domain="Content Creation",
        formula="Generation_rate = tokens × TOF = 10⁶ tokens/s",
        rate_enhancement=100000.0, efficiency_gain=0.95, energy_savings=0.70,
        description="Catalyze content generation at scale",
        implementation_points=["ReportGeneration output", "DoctrineDocuments creation"],
    ),
    IntelligenceUse(
        id=10, name="IntegrationCatalysis", layer="System", domain="Cross-Component",
        formula="Integration_latency = component_count × t_unit × φ⁻¹",
        rate_enhancement=10000.0, efficiency_gain=0.92, energy_savings=0.60,
        description="Catalyze system integration and coordination",
        implementation_points=["UnifiedOrganism coordination", "SovereignOrganism orchestration"],
    ),
    IntelligenceUse(
        id=11, name="HealingCatalysis", layer="System", domain="Maintenance",
        formula="Repair_time = damage × base_repair × φ⁻² (fast healing)",
        rate_enhancement=5000.0, efficiency_gain=0.98, energy_savings=0.50,
        description="Catalyze system self-healing and recovery",
        implementation_points=["ShimmerDefense recovery", "SovereignDefenseSystem repair"],
    ),
    IntelligenceUse(
        id=12, name="EvolutionCatalysis", layer="System", domain="Growth",
        formula="Evolution_rate = fitness × mutation × Pt_acceleration",
        rate_enhancement=1000.0, efficiency_gain=0.85, energy_savings=0.40,
        description="Catalyze system evolution and improvement",
        implementation_points=["FeedbackLab learning", "SwarmHiveColony adaptation"],
    ),
]


# ═══════════════════════════════════════════════════════════════════════════════
# SCALE LAYERS — MICRO TO MACRO
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class ScaleLayer:
    """A scale layer from micro to macro."""
    
    level: int
    name: str
    latin: str
    size_range: str
    catalytic_role: str
    formula: str
    examples: List[str]


SCALE_LAYERS: List[ScaleLayer] = [
    ScaleLayer(0, "Quantum", "Stratum Quantum", "10⁻¹⁵ m (femtometer)",
               "d-orbital electron mediation",
               "ε_d = -2.25 eV → optimal binding via quantum tunneling",
               ["Electron transfer", "Orbital hybridization", "Spin coupling"]),
    ScaleLayer(1, "Atomic", "Stratum Atomicum", "10⁻¹⁰ m (angstrom)",
               "Active site formation",
               "Pt atom coordination = 12 (fcc) → high surface energy sites",
               ["Coordination chemistry", "Bonding geometry", "Valence states"]),
    ScaleLayer(2, "Molecular", "Stratum Moleculare", "10⁻⁹ m (nanometer)",
               "Adsorption and reaction",
               "ΔH_ads = -40 to -100 kJ/mol → Sabatier optimum",
               ["Molecular adsorption", "Surface reactions", "Product desorption"]),
    ScaleLayer(3, "Nano", "Stratum Nano", "10⁻⁸ m (10 nm)",
               "Nanoparticle catalysis",
               "Surface/Volume ∝ 1/r → smaller = more active",
               ["Nanoparticle synthesis", "Size-dependent activity", "Shape selectivity"]),
    ScaleLayer(4, "Micro", "Stratum Micro", "10⁻⁶ m (micrometer)",
               "Pore and channel catalysis",
               "Effectiveness factor η = tanh(φ)/φ where φ = Thiele modulus",
               ["Pore diffusion", "Mass transfer", "Channel flow"]),
    ScaleLayer(5, "Meso", "Stratum Meso", "10⁻³ m (millimeter)",
               "Catalyst pellet behavior",
               "Pressure drop ΔP = f(particle size, bed void fraction)",
               ["Pellet design", "Heat transfer", "Flow distribution"]),
    ScaleLayer(6, "Macro", "Stratum Macro", "10⁰ m (meter)",
               "Reactor design",
               "Conversion X = f(space velocity, temperature, pressure)",
               ["Reactor engineering", "Process design", "Scale-up"]),
    ScaleLayer(7, "System", "Stratum Systematis", "10³ m (kilometer)",
               "Process integration",
               "Efficiency = Σ(unit operations) × integration factor",
               ["Plant design", "Process integration", "Energy recovery"]),
    ScaleLayer(8, "Meta", "Stratum Meta", "Global",
               "Civilization-scale catalysis",
               "Impact = Technology × Adoption × Sustainability",
               ["Global catalysis", "Hydrogen economy", "Carbon neutrality"]),
]


# ═══════════════════════════════════════════════════════════════════════════════
# THE COMPLETE PLATINUM CATALYTIC ALPHA MODEL
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class PlatinumCatalyticAlphaModel:
    """
    The Complete Platinum Catalytic Alpha Model — AI Living Organism.
    
    This is Alpha Model #6 in the Thermodynamics Substrate Division.
    
    Structure:
    - 3 Engines: Activation, Transformation, Regeneration
    - 1 Transformer: CatalyticTransformer
    - 4 Submodels: Reaction, Kinetics, Surface, Selectivity
    - 12+ Intelligence Uses
    - 9 Scale Layers (Quantum → Meta)
    """
    
    name: str = "PlatinumCatalyticAlphaModel"
    latin: str = "Modulum Alpha Catalyticum Platini"
    symbol: str = "Pt-CA"
    model_id: int = 6
    
    doctrine: str = "Platinum accelerat sine degradatione. Acceleratio aeterna. Catalyst integer."
    motto: str = "CA = 10⁶ s⁻¹ — One million transformations per second, forever."
    
    primary_formula: PlatinumPrimaryFormula = field(default_factory=PlatinumPrimaryFormula)
    secondary_formula: PlatinumSecondaryFormula = field(default_factory=PlatinumSecondaryFormula)
    
    primitive_trace: str = "Pt → d-band catalysis → rate enhancement → k = A·e^(-Ea/RT) → exponential → e → growth → φ"
    
    def get_engines(self) -> List[CatalyticEngine]:
        """Get the 3 catalytic engines."""
        return CATALYTIC_ENGINES
    
    def get_transformer(self) -> CatalyticTransformer:
        """Get the catalytic transformer."""
        return CATALYTIC_TRANSFORMER
    
    def get_submodels(self) -> List[CatalyticSubmodel]:
        """Get the 4 submodels."""
        return CATALYTIC_SUBMODELS
    
    def get_uses(self) -> List[IntelligenceUse]:
        """Get all intelligence uses."""
        return INTELLIGENCE_USES
    
    def get_scale_layers(self) -> List[ScaleLayer]:
        """Get the 9 scale layers."""
        return SCALE_LAYERS
    
    def get_formulas(self) -> List[CatalyticFormula]:
        """Get all catalytic formulas."""
        return CATALYTIC_FORMULAS
    
    def calculate_arrhenius(self, T_K: float = STANDARD_TEMP) -> float:
        """Calculate Arrhenius rate constant at temperature T."""
        return self.secondary_formula.calculate_rate_constant(T_K)
    
    def calculate_enhancement(self, T_K: float = STANDARD_TEMP) -> float:
        """Calculate rate enhancement from catalysis."""
        return self.secondary_formula.calculate_rate_enhancement(T_K)
    
    def get_total_enhancement(self) -> float:
        """Get combined enhancement from all engines."""
        return sum(e.get_total_enhancement() for e in CATALYTIC_ENGINES)
    
    def status(self) -> Dict[str, Any]:
        """Get full model status."""
        return {
            "name": self.name,
            "symbol": self.symbol,
            "model_id": self.model_id,
            "doctrine": self.doctrine,
            "motto": self.motto,
            "engines": len(CATALYTIC_ENGINES),
            "transformer": CATALYTIC_TRANSFORMER.name,
            "submodels": len(CATALYTIC_SUBMODELS),
            "intelligence_uses": len(INTELLIGENCE_USES),
            "scale_layers": len(SCALE_LAYERS),
            "formulas": len(CATALYTIC_FORMULAS),
            "total_enhancement": self.get_total_enhancement(),
            "primitive_trace": self.primitive_trace,
        }
    
    def to_dict(self) -> Dict[str, Any]:
        """Full serialization."""
        return {
            "name": self.name,
            "latin": self.latin,
            "symbol": self.symbol,
            "model_id": self.model_id,
            "doctrine": self.doctrine,
            "motto": self.motto,
            "primary_formula": {
                "gibbs_formation_kJ": self.primary_formula.gibbs_formation_kJ,
                "d_band_center_eV": self.primary_formula.d_band_center_eV,
                "is_noble": self.primary_formula.is_noble(),
                "is_optimal_catalyst": self.primary_formula.is_optimal_catalyst(),
            },
            "secondary_formula": {
                "arrhenius_A": self.secondary_formula.arrhenius_A,
                "turnover_frequency_s1": self.secondary_formula.turnover_frequency_s1,
                "rate_at_298K": self.calculate_arrhenius(),
                "enhancement": self.calculate_enhancement(),
            },
            "engines": [e.to_dict() for e in CATALYTIC_ENGINES],
            "transformer": CATALYTIC_TRANSFORMER.to_dict(),
            "submodels": [s.to_dict() for s in CATALYTIC_SUBMODELS],
            "uses": [u.to_dict() for u in INTELLIGENCE_USES],
            "scale_layers": [
                {"level": s.level, "name": s.name, "catalytic_role": s.catalytic_role}
                for s in SCALE_LAYERS
            ],
            "primitive_trace": self.primitive_trace,
        }


# ═══════════════════════════════════════════════════════════════════════════════
# SINGLETON INSTANCE
# ═══════════════════════════════════════════════════════════════════════════════

_model_instance: Optional[PlatinumCatalyticAlphaModel] = None


def get_platinum_catalytic_model() -> PlatinumCatalyticAlphaModel:
    """Get or create the global Platinum Catalytic Alpha Model instance."""
    global _model_instance
    if _model_instance is None:
        _model_instance = PlatinumCatalyticAlphaModel()
    return _model_instance


# ═══════════════════════════════════════════════════════════════════════════════
# CONVENIENCE FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════

def arrhenius_rate(A: float, Ea_kJ: float, T_K: float) -> float:
    """Calculate Arrhenius rate constant: k = A × e^(-Ea/RT)."""
    exponent = -Ea_kJ * 1000 / (GAS_CONSTANT * T_K)
    return A * math.exp(exponent)


def turnover_frequency(molecules: float, sites: float, time_s: float) -> float:
    """Calculate turnover frequency: TOF = molecules / (sites × time)."""
    return molecules / (sites * time_s)


def langmuir_coverage(K: float, P: float) -> float:
    """Calculate Langmuir surface coverage: θ = KP / (1 + KP)."""
    return K * P / (1.0 + K * P)


def effectiveness_factor(thiele: float) -> float:
    """Calculate effectiveness factor: η = tanh(φ) / φ."""
    if thiele < 0.001:
        return 1.0
    return math.tanh(thiele) / thiele


def selectivity_ratio(k1: float, k2: float) -> float:
    """Calculate selectivity ratio: S = k₁ / k₂."""
    return k1 / k2


def rate_enhancement(Ea_uncatalyzed: float, Ea_catalyzed: float, T_K: float = STANDARD_TEMP) -> float:
    """Calculate rate enhancement from catalysis."""
    delta_Ea = (Ea_uncatalyzed - Ea_catalyzed) * 1000
    return math.exp(delta_Ea / (GAS_CONSTANT * T_K))


def calculate_CA(T_K: float = STANDARD_TEMP) -> float:
    """Calculate Catalytic Activity (CA) at given temperature."""
    return arrhenius_rate(1.0e13, 40.0, T_K)
