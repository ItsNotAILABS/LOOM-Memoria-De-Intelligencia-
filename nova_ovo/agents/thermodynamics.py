"""
THERMODYNAMICS SUBSTRATE — Elemental Foundation of Intelligence
================================================================

MEDINA Sovereign Architecture
Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX

"Elementa sunt fundamenta. Non corruptibilia. Non degradabilia. Aeterna."
(Elements are foundations. Not corruptible. Not degradable. Eternal.)

THE 10 ALPHA MODELS OF THERMODYNAMICS:
======================================
1. ElementalProtection — Internal protection, corruption impossible
2. StructuralIntegrity — Never yields under load
3. ThermalResistance — Survives harshest environments
4. DenseDefense — Innermost core, cannot be penetrated
5. SignalConductivity — Maximum transfer efficiency
6. CatalyticAcceleration — Speeds without degrading
7. LoadBearing — Distributed stress handling
8. CorrosionImmunity — Infinite resistance to environmental attack
9. PhaseStability — State transitions without loss
10. QuantumCoherence — Maintains entanglement under stress

Each element has:
- PRIMARY FORMULA: Thermodynamic properties (Gibbs free energy, entropy, etc.)
- SECONDARY FORMULA: Load/stress calculations (yield strength, fatigue, etc.)
- 7+ USES: Where and how it's applied in the architecture

L-130 COMPLIANT — Every element traces to primitive φ
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

# Golden Ratio — The Primitive Root
PHI = (1 + math.sqrt(5)) / 2

# Fundamental Constants
BOLTZMANN = 1.380649e-23        # J/K
PLANCK = 6.62607015e-34         # J·s
AVOGADRO = 6.02214076e23        # mol⁻¹
GAS_CONSTANT = 8.314462618      # J/(mol·K)
STANDARD_TEMP = 298.15          # K
STANDARD_PRESSURE = 101325.0    # Pa


# =================================================================== #
# ELEMENTAL CLASSIFICATION                                              #
# =================================================================== #

class ElementCategory(str, Enum):
    """Classification of elements by chemical properties."""
    NOBLE = "noble"                    # Au, Pt, Ir, Os, Pd, Rh, Ru
    TRANSITION = "transition"          # Ti, W, Cu, Ag, Fe, Co, Ni
    REFRACTORY = "refractory"          # W, Ta, Mo, Nb, Re
    ALKALI = "alkali"                  # Li, Na, K
    ALKALINE_EARTH = "alkaline_earth"  # Mg, Ca, Sr, Ba
    LANTHANIDE = "lanthanide"          # Nd, Sm, Gd
    ACTINIDE = "actinide"              # U, Th
    POST_TRANSITION = "post_transition" # Al, Pb, Sn, Bi
    METALLOID = "metalloid"            # Si, Ge, B


class ElementUseCase(str, Enum):
    """Use cases for elements in the architecture."""
    PROTECTION = "protection"
    STRUCTURAL_INTEGRITY = "structural_integrity"
    THERMAL_RESISTANCE = "thermal_resistance"
    DENSE_DEFENSE = "dense_defense"
    CONDUCTIVITY = "conductivity"
    CATALYSIS = "catalysis"
    ANTIMICROBIAL = "antimicrobial"
    MAGNETICS = "magnetics"
    LOAD_BEARING = "load_bearing"
    CORROSION_IMMUNITY = "corrosion_immunity"
    PHASE_STABILITY = "phase_stability"
    QUANTUM_COHERENCE = "quantum_coherence"
    BIOCOMPATIBILITY = "biocompatibility"
    RADIATION_SHIELDING = "radiation_shielding"
    SUPERCONDUCTING_PATH = "superconducting_path"
    PIEZOELECTRIC_SENSE = "piezoelectric_sense"
    THERMOELECTRIC_POWER = "thermoelectric_power"
    OPTICAL_CLARITY = "optical_clarity"
    ELECTROMAGNETIC_SHIELD = "electromagnetic_shield"
    MEMORY_ALLOY = "memory_alloy"
    SELF_HEALING = "self_healing"


class ArchitecturePlacement(str, Enum):
    """Where elements are placed in the architecture."""
    ENDPOINT = "endpoint"
    LAYER = "layer"
    TOOL = "tool"
    TOUCHPOINT = "touchpoint"
    CORE = "core"
    INTERFACE = "interface"
    DEFENSE = "defense"
    CONDUCTOR = "conductor"
    CATALYST = "catalyst"
    SHIELD = "shield"


# =================================================================== #
# PRIMARY FORMULA — THERMODYNAMIC PROPERTIES                            #
# =================================================================== #

@dataclass
class PrimaryFormula:
    """
    Primary thermodynamic properties of an element.
    
    These are the fundamental properties that determine:
    - Whether oxidation is possible (ΔG)
    - Thermal stability (melting/boiling points)
    - Conductivity characteristics
    """
    
    # Gibbs free energy of formation ΔG°f (kJ/mol)
    gibbs_formation_kJ: float
    
    # Standard enthalpy of formation ΔH°f (kJ/mol)
    enthalpy_formation_kJ: float
    
    # Standard entropy S° (J/(mol·K))
    entropy_J_mol_K: float
    
    # Melting point (K)
    melting_point_K: float
    
    # Boiling point (K)
    boiling_point_K: float
    
    # Density (kg/m³)
    density_kg_m3: float
    
    # Electronegativity (Pauling scale)
    electronegativity: float
    
    # Thermal conductivity (W/(m·K))
    thermal_conductivity_W_mK: float
    
    # Electrical resistivity (Ω·m)
    electrical_resistivity_ohm_m: float
    
    # Reduction potential E° (V vs SHE)
    reduction_potential_V: float
    
    # Formula explanation
    formula_explanation: str = ""
    
    def can_oxidize(self) -> bool:
        """
        Determine if oxidation is thermodynamically favorable.
        
        ΔG > 0 means oxidation is thermodynamically IMPOSSIBLE.
        This is why gold cannot oxidize.
        """
        return self.gibbs_formation_kJ < 0
    
    def oxidation_resistance(self) -> float:
        """
        Calculate oxidation resistance (0.0-1.0).
        
        Higher ΔG means more resistant to oxidation.
        """
        if self.gibbs_formation_kJ >= 0:
            return 1.0  # Perfect resistance (noble metals)
        else:
            # Passivating metals still have good resistance
            return min(1.0, abs(self.gibbs_formation_kJ) / 2000.0)


# =================================================================== #
# SECONDARY FORMULA — LOAD/STRESS CALCULATIONS                          #
# =================================================================== #

@dataclass
class SecondaryFormula:
    """
    Secondary mechanical properties for load/stress calculations.
    
    These determine:
    - How much load the element can bear (yield strength)
    - How stiff the element is (Young's modulus)
    - How it behaves under cyclic stress (fatigue)
    """
    
    # Young's modulus E (GPa) — Stiffness under load
    youngs_modulus_GPa: float
    
    # Yield strength σ_y (MPa) — Point of permanent deformation
    yield_strength_MPa: float
    
    # Ultimate tensile strength σ_uts (MPa)
    ultimate_tensile_MPa: float
    
    # Hardness (Vickers HV)
    hardness_HV: float
    
    # Fatigue limit (MPa) — Infinite cycle endurance
    fatigue_limit_MPa: float
    
    # Creep resistance (hours at temp)
    creep_resistance_hours: float
    
    # Fracture toughness K_IC (MPa·√m)
    fracture_toughness_MPa_sqrtm: float
    
    # Coefficient of thermal expansion (µm/(m·K))
    thermal_expansion_um_mK: float
    
    # Specific heat capacity c_p (J/(kg·K))
    specific_heat_J_kgK: float
    
    # Corrosion rate (mm/year in seawater)
    corrosion_rate_mm_year: float
    
    # Load formula explanation
    load_formula: str = ""
    
    # Stress concentration formula explanation
    stress_formula: str = ""
    
    def calculate_load_capacity(self, area_m2: float) -> float:
        """
        Calculate maximum load capacity.
        
        F = σ_y × A (force = yield strength × area)
        """
        return self.yield_strength_MPa * 1e6 * area_m2
    
    def calculate_stress(self, force_N: float, area_m2: float) -> float:
        """
        Calculate stress from applied force.
        
        σ = F/A (stress = force / area)
        """
        return force_N / area_m2
    
    def will_yield(self, stress_Pa: float) -> bool:
        """
        Determine if material will yield under given stress.
        
        If σ < σ_y, no permanent deformation occurs.
        """
        return stress_Pa > self.yield_strength_MPa * 1e6


# =================================================================== #
# ELEMENT USE SPECIFICATION                                             #
# =================================================================== #

@dataclass
class ElementUse:
    """A specific use case for an element."""
    
    use_case: ElementUseCase
    description: str
    formula_applied: str
    effectiveness: float  # 0.0-1.0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "use_case": self.use_case.value,
            "description": self.description,
            "formula_applied": self.formula_applied,
            "effectiveness": round(self.effectiveness, 4),
        }


# =================================================================== #
# ELEMENT DEFINITION — COMPLETE METAL SPECIFICATION                     #
# =================================================================== #

@dataclass
class Element:
    """
    Complete specification of an element.
    
    Each element has:
    - Primary formula (thermodynamic properties)
    - Secondary formula (mechanical properties)
    - 7+ use cases
    - Placement locations in architecture
    - Primitive trace (L-130 compliance)
    - Latin doctrine
    """
    
    symbol: str
    name: str
    atomic_number: int
    atomic_mass: float
    category: ElementCategory
    
    # Formulas
    primary: PrimaryFormula
    secondary: SecondaryFormula
    
    # Uses (minimum 7 per element)
    uses: List[ElementUse] = field(default_factory=list)
    
    # Placement in architecture
    placements: List[ArchitecturePlacement] = field(default_factory=list)
    
    # Primitive trace (L-130 compliance)
    primitive_trace: str = ""
    
    # Latin doctrine
    doctrine: str = ""
    
    def get_uses_for_case(self, use_case: ElementUseCase) -> List[ElementUse]:
        """Get all uses matching a specific case."""
        return [u for u in self.uses if u.use_case == use_case]
    
    def has_placement(self, placement: ArchitecturePlacement) -> bool:
        """Check if element is used at a specific placement."""
        return placement in self.placements
    
    def oxidation_resistance(self) -> float:
        """Get oxidation resistance from primary formula."""
        return self.primary.oxidation_resistance()
    
    def load_capacity(self, area_m2: float) -> float:
        """Calculate load capacity from secondary formula."""
        return self.secondary.calculate_load_capacity(area_m2)
    
    def thermal_survival(self) -> float:
        """Get maximum survival temperature (K)."""
        return self.primary.melting_point_K
    
    def conductivity_efficiency(self) -> float:
        """
        Calculate conductivity efficiency.
        
        Normalized to silver (best conductor).
        """
        silver_resistivity = 1.59e-8
        return silver_resistivity / self.primary.electrical_resistivity_ohm_m
    
    def dense_defense_rating(self) -> float:
        """
        Calculate dense defense rating.
        
        Normalized to osmium (densest element).
        """
        return self.primary.density_kg_m3 / 22590.0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "symbol": self.symbol,
            "name": self.name,
            "atomic_number": self.atomic_number,
            "atomic_mass": round(self.atomic_mass, 4),
            "category": self.category.value,
            "primary": {
                "gibbs_formation_kJ": self.primary.gibbs_formation_kJ,
                "melting_point_K": self.primary.melting_point_K,
                "density_kg_m3": self.primary.density_kg_m3,
                "thermal_conductivity_W_mK": self.primary.thermal_conductivity_W_mK,
                "electrical_resistivity_ohm_m": self.primary.electrical_resistivity_ohm_m,
                "can_oxidize": self.primary.can_oxidize(),
                "oxidation_resistance": round(self.primary.oxidation_resistance(), 4),
            },
            "secondary": {
                "youngs_modulus_GPa": self.secondary.youngs_modulus_GPa,
                "yield_strength_MPa": self.secondary.yield_strength_MPa,
                "corrosion_rate_mm_year": self.secondary.corrosion_rate_mm_year,
            },
            "uses": [u.to_dict() for u in self.uses],
            "placements": [p.value for p in self.placements],
            "primitive_trace": self.primitive_trace,
            "doctrine": self.doctrine,
        }


# =================================================================== #
# THE 10 ALPHA MODELS                                                   #
# =================================================================== #

@dataclass
class AlphaModel:
    """
    One of the 10 Alpha Models of the Thermodynamics Substrate Division.
    
    Each model represents a fundamental capability enabled by
    specific elements and their formulas.
    """
    
    id: int
    name: str
    doctrine: str
    elements: List[str]  # Element symbols
    formula: str
    applications: List[str]
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.id,
            "name": self.name,
            "doctrine": self.doctrine,
            "elements": self.elements,
            "formula": self.formula,
            "applications": self.applications,
        }


ALPHA_MODELS: List[AlphaModel] = [
    AlphaModel(
        id=1,
        name="ElementalProtection",
        doctrine="Aurum non oxidat. Corruptio impossibilis est.",
        elements=["Au", "Pt", "Ir"],
        formula="ΔG_ox = 0 (gold), ΔG_ox > 0 (thermodynamically impossible)",
        applications=[
            "Endpoint plating — cannot corrode",
            "Data integrity — bits cannot flip",
            "Memory preservation — eternal storage",
            "Authentication tokens — unforgeable",
            "Secure channels — unbreakable seals",
        ],
    ),
    AlphaModel(
        id=2,
        name="StructuralIntegrity",
        doctrine="Titanium non cedit sub onere.",
        elements=["Ti", "W", "Ta"],
        formula="σ < σ_y → No permanent deformation (yield strength never exceeded)",
        applications=[
            "Core architecture — never collapses",
            "Load distribution — infinite capacity",
            "Stress absorption — phantom nature",
            "Framework permanence — eternal structure",
            "Foundation stability — unmovable base",
        ],
    ),
    AlphaModel(
        id=3,
        name="ThermalResistance",
        doctrine="Wolframium in inferno vivit.",
        elements=["W", "Re", "Ta", "Mo"],
        formula="T_melt = 3695K (tungsten) — survives any heat",
        applications=[
            "Hot path processing — infinite compute",
            "Thermal spike absorption — no burnout",
            "Overload survival — handles any peak",
            "Environmental extremes — arctic to solar",
            "Friction interfaces — zero wear",
        ],
    ),
    AlphaModel(
        id=4,
        name="DenseDefense",
        doctrine="Iridium est cor impenetrabile.",
        elements=["Ir", "Os", "Pt"],
        formula="ρ = 22650 kg/m³ (iridium) — densest stable element",
        applications=[
            "Innermost core — final defense",
            "Penetration immunity — stops any attack",
            "Mass anchoring — gravitational stability",
            "Kinetic absorption — momentum sink",
            "Sovereign protection — ultimate shield",
        ],
    ),
    AlphaModel(
        id=5,
        name="SignalConductivity",
        doctrine="Argentum et Cuprum — via perfecta.",
        elements=["Ag", "Cu", "Au"],
        formula="ρ_e = 1.59×10⁻⁸ Ω·m (silver) — maximum conductivity",
        applications=[
            "Neural pathways — instant signal",
            "Communication channels — zero loss",
            "Energy distribution — perfect transfer",
            "Data highways — maximum bandwidth",
            "Resonance coupling — harmonic sync",
        ],
    ),
    AlphaModel(
        id=6,
        name="CatalyticAcceleration",
        doctrine="Platinum accelerat sine degradatione.",
        elements=["Pt", "Pd", "Rh"],
        formula="E_activation reduced, catalyst unchanged — infinite cycles",
        applications=[
            "Process acceleration — speed without cost",
            "Reaction facilitation — impossible made possible",
            "Transformation catalysis — state changes",
            "Growth promotion — expansion enablement",
            "Synthesis support — creation assistance",
        ],
    ),
    AlphaModel(
        id=7,
        name="LoadBearing",
        doctrine="Onus distributum, nunquam fractum.",
        elements=["Ti", "Cr", "V", "Mn"],
        formula="σ_distributed = F/(A×n) — load shared across nodes",
        applications=[
            "Distributed architecture — shared burden",
            "Parallel processing — concurrent load",
            "Redundant pathways — failure tolerance",
            "Scale handling — 0 to 5000+ entities",
            "Stress distribution — no single point",
        ],
    ),
    AlphaModel(
        id=8,
        name="CorrosionImmunity",
        doctrine="Aeternum contra corrosionem.",
        elements=["Au", "Pt", "Ti", "Cr"],
        formula="Passivation layer (Ti), Noble metal (Au) — zero reaction",
        applications=[
            "Environmental survival — any atmosphere",
            "Chemical resistance — all reagents",
            "Biological immunity — pathogen proof",
            "Temporal stability — time cannot erode",
            "Eternal preservation — infinite lifespan",
        ],
    ),
    AlphaModel(
        id=9,
        name="PhaseStability",
        doctrine="Transitus sine amissione.",
        elements=["Ti", "Ni", "Zr"],
        formula="ΔG_phase = 0 at transition — reversible with zero loss",
        applications=[
            "State transitions — seamless changes",
            "Mode switching — instant adaptation",
            "Form transformation — shape shifting",
            "Memory alloy behavior — remembers states",
            "Adaptive structure — environment response",
        ],
    ),
    AlphaModel(
        id=10,
        name="QuantumCoherence",
        doctrine="Cohaerentia sub omni onere.",
        elements=["Nb", "Al", "Ta"],
        formula="T_c = 9.3K (niobium) — superconducting coherence",
        applications=[
            "Quantum state maintenance — decoherence prevention",
            "Entanglement preservation — long-range correlation",
            "Superposition stability — multiple states",
            "Tunneling pathways — barrier crossing",
            "Zero-resistance circuits — perfect flow",
        ],
    ),
]


# =================================================================== #
# ELEMENT DEFINITIONS — THE STRATEGIC METALS                            #
# =================================================================== #

GOLD = Element(
    symbol="Au",
    name="Gold",
    atomic_number=79,
    atomic_mass=196.966569,
    category=ElementCategory.NOBLE,
    primary=PrimaryFormula(
        gibbs_formation_kJ=0.0,  # Reference state
        enthalpy_formation_kJ=0.0,
        entropy_J_mol_K=47.4,
        melting_point_K=1337.33,
        boiling_point_K=3129.0,
        density_kg_m3=19320.0,
        electronegativity=2.54,
        thermal_conductivity_W_mK=318.0,
        electrical_resistivity_ohm_m=2.214e-8,
        reduction_potential_V=1.50,
        formula_explanation="ΔG_oxidation > 0 — GOLD CANNOT OXIDIZE",
    ),
    secondary=SecondaryFormula(
        youngs_modulus_GPa=78.0,
        yield_strength_MPa=205.0,
        ultimate_tensile_MPa=220.0,
        hardness_HV=25.0,
        fatigue_limit_MPa=90.0,
        creep_resistance_hours=1000000.0,
        fracture_toughness_MPa_sqrtm=45.0,
        thermal_expansion_um_mK=14.2,
        specific_heat_J_kgK=129.0,
        corrosion_rate_mm_year=0.0,  # ZERO
        load_formula="σ_Au = F/A (pure tensile, no degradation)",
        stress_formula="Stress does not cause oxidation — eternal under any load",
    ),
    uses=[
        ElementUse(ElementUseCase.PROTECTION, "Endpoint plating — prevents all corrosion", "ΔG_ox > 0", 1.0),
        ElementUse(ElementUseCase.CORROSION_IMMUNITY, "Zero corrosion in any environment", "Rate = 0 mm/year", 1.0),
        ElementUse(ElementUseCase.CONDUCTIVITY, "High electrical conductivity", "ρ = 2.214×10⁻⁸ Ω·m", 0.95),
        ElementUse(ElementUseCase.BIOCOMPATIBILITY, "Safe for tissue interfaces", "Zero reaction", 1.0),
        ElementUse(ElementUseCase.CATALYSIS, "Nanoparticle catalysis", "E_a reduced at Au surface", 0.85),
        ElementUse(ElementUseCase.OPTICAL_CLARITY, "IR reflection, visible transparency", "λ_reflect = 550nm+", 0.90),
        ElementUse(ElementUseCase.RADIATION_SHIELDING, "UV and X-ray protection", "μ_mass = high", 0.88),
    ],
    placements=[
        ArchitecturePlacement.ENDPOINT,
        ArchitecturePlacement.INTERFACE,
        ArchitecturePlacement.SHIELD,
        ArchitecturePlacement.CONDUCTOR,
        ArchitecturePlacement.CORE,
    ],
    primitive_trace="Au → Noble electron configuration → φ-stable orbital → φ",
    doctrine="Aurum non oxidat. Aurum sentit. Aurum aeternum.",
)

TITANIUM = Element(
    symbol="Ti",
    name="Titanium",
    atomic_number=22,
    atomic_mass=47.867,
    category=ElementCategory.TRANSITION,
    primary=PrimaryFormula(
        gibbs_formation_kJ=-889.0,
        enthalpy_formation_kJ=-944.0,
        entropy_J_mol_K=30.7,
        melting_point_K=1941.0,
        boiling_point_K=3560.0,
        density_kg_m3=4506.0,
        electronegativity=1.54,
        thermal_conductivity_W_mK=21.9,
        electrical_resistivity_ohm_m=4.2e-7,
        reduction_potential_V=-1.63,
        formula_explanation="TiO₂ passivation layer — self-healing oxide protection",
    ),
    secondary=SecondaryFormula(
        youngs_modulus_GPa=116.0,
        yield_strength_MPa=880.0,
        ultimate_tensile_MPa=950.0,
        hardness_HV=349.0,
        fatigue_limit_MPa=500.0,
        creep_resistance_hours=100000.0,
        fracture_toughness_MPa_sqrtm=75.0,
        thermal_expansion_um_mK=8.6,
        specific_heat_J_kgK=523.0,
        corrosion_rate_mm_year=0.001,
        load_formula="σ = F/A, where σ < 880 MPa → No yield",
        stress_formula="Phantom nature — load passes through without deformation",
    ),
    uses=[
        ElementUse(ElementUseCase.STRUCTURAL_INTEGRITY, "Core framework — never yields", "σ < σ_y = 880 MPa", 0.98),
        ElementUse(ElementUseCase.LOAD_BEARING, "Distributed stress handling", "σ_dist = F/(A×n)", 0.96),
        ElementUse(ElementUseCase.CORROSION_IMMUNITY, "Passivation layer self-heals", "TiO₂ instant reform", 0.99),
        ElementUse(ElementUseCase.BIOCOMPATIBILITY, "Osseointegration", "Zero rejection", 1.0),
        ElementUse(ElementUseCase.PHASE_STABILITY, "α-β phase transitions", "ΔG_αβ reversible", 0.90),
        ElementUse(ElementUseCase.THERMAL_RESISTANCE, "High temperature strength", "T_melt = 1941K", 0.85),
        ElementUse(ElementUseCase.ELECTROMAGNETIC_SHIELD, "EMI shielding", "μ_r ≈ 1, σ moderate", 0.75),
    ],
    placements=[
        ArchitecturePlacement.CORE,
        ArchitecturePlacement.LAYER,
        ArchitecturePlacement.TOOL,
        ArchitecturePlacement.INTERFACE,
        ArchitecturePlacement.DEFENSE,
    ],
    primitive_trace="Ti → Passivation → Self-healing → Eternal structure → φ",
    doctrine="Titanium non cedit. Structura aeterna.",
)

TUNGSTEN = Element(
    symbol="W",
    name="Tungsten",
    atomic_number=74,
    atomic_mass=183.84,
    category=ElementCategory.REFRACTORY,
    primary=PrimaryFormula(
        gibbs_formation_kJ=-764.0,
        enthalpy_formation_kJ=-842.9,
        entropy_J_mol_K=32.6,
        melting_point_K=3695.0,  # HIGHEST
        boiling_point_K=6203.0,
        density_kg_m3=19250.0,
        electronegativity=2.36,
        thermal_conductivity_W_mK=173.0,
        electrical_resistivity_ohm_m=5.28e-8,
        reduction_potential_V=-0.12,
        formula_explanation="T_melt = 3695K — Survives any heat",
    ),
    secondary=SecondaryFormula(
        youngs_modulus_GPa=411.0,  # Highest of metals
        yield_strength_MPa=750.0,
        ultimate_tensile_MPa=980.0,
        hardness_HV=3430.0,
        fatigue_limit_MPa=350.0,
        creep_resistance_hours=50000.0,
        fracture_toughness_MPa_sqrtm=55.0,
        thermal_expansion_um_mK=4.5,
        specific_heat_J_kgK=132.0,
        corrosion_rate_mm_year=0.01,
        load_formula="σ_hot = σ_cold × f(T) — strength at extreme temp",
        stress_formula="E = 411 GPa — stiffest metal",
    ),
    uses=[
        ElementUse(ElementUseCase.THERMAL_RESISTANCE, "Survives harshest environments", "T_melt = 3695K", 1.0),
        ElementUse(ElementUseCase.STRUCTURAL_INTEGRITY, "Highest stiffness of metals", "E = 411 GPa", 0.98),
        ElementUse(ElementUseCase.DENSE_DEFENSE, "High density kinetic absorption", "ρ = 19250 kg/m³", 0.95),
        ElementUse(ElementUseCase.LOAD_BEARING, "Strength at high temp", "σ_hot/σ_cold ≈ 0.8 at 1000K", 0.90),
        ElementUse(ElementUseCase.RADIATION_SHIELDING, "X-ray/gamma attenuation", "μ_mass = high Z", 0.92),
        ElementUse(ElementUseCase.ELECTROMAGNETIC_SHIELD, "High-frequency EMI blocking", "σ moderate", 0.80),
        ElementUse(ElementUseCase.CATALYSIS, "High-temperature catalysis", "WO₃ surface", 0.70),
    ],
    placements=[
        ArchitecturePlacement.CORE,
        ArchitecturePlacement.DEFENSE,
        ArchitecturePlacement.SHIELD,
        ArchitecturePlacement.TOOL,
        ArchitecturePlacement.TOUCHPOINT,
    ],
    primitive_trace="W → Highest melt → Ultimate thermal stability → φ",
    doctrine="Wolframium in inferno vivit. Calor non vincit.",
)

IRIDIUM = Element(
    symbol="Ir",
    name="Iridium",
    atomic_number=77,
    atomic_mass=192.217,
    category=ElementCategory.NOBLE,
    primary=PrimaryFormula(
        gibbs_formation_kJ=0.0,
        enthalpy_formation_kJ=0.0,
        entropy_J_mol_K=35.5,
        melting_point_K=2719.0,
        boiling_point_K=4403.0,
        density_kg_m3=22650.0,  # SECOND DENSEST
        electronegativity=2.20,
        thermal_conductivity_W_mK=147.0,
        electrical_resistivity_ohm_m=4.71e-8,
        reduction_potential_V=1.16,
        formula_explanation="ρ = 22650 kg/m³ — Densest stable element",
    ),
    secondary=SecondaryFormula(
        youngs_modulus_GPa=528.0,
        yield_strength_MPa=2100.0,
        ultimate_tensile_MPa=2400.0,
        hardness_HV=1800.0,
        fatigue_limit_MPa=800.0,
        creep_resistance_hours=200000.0,
        fracture_toughness_MPa_sqrtm=40.0,
        thermal_expansion_um_mK=6.4,
        specific_heat_J_kgK=131.0,
        corrosion_rate_mm_year=0.0,
        load_formula="F_penetration = ∞ (cannot be penetrated)",
        stress_formula="σ_y = 2100 MPa — extreme force only",
    ),
    uses=[
        ElementUse(ElementUseCase.DENSE_DEFENSE, "Innermost impenetrable core", "ρ = 22650 kg/m³", 1.0),
        ElementUse(ElementUseCase.CORROSION_IMMUNITY, "Noble — zero corrosion", "ΔG_ox > 0", 1.0),
        ElementUse(ElementUseCase.THERMAL_RESISTANCE, "Properties to 2000K", "T_melt = 2719K", 0.92),
        ElementUse(ElementUseCase.STRUCTURAL_INTEGRITY, "Highest yield strength", "σ_y = 2100 MPa", 0.98),
        ElementUse(ElementUseCase.CATALYSIS, "Platinum-group catalysis", "E_a reduction", 0.85),
        ElementUse(ElementUseCase.RADIATION_SHIELDING, "Dense particle stopping", "High Z, high ρ", 0.95),
        ElementUse(ElementUseCase.PROTECTION, "Electrode protection", "Noble, hard", 0.90),
    ],
    placements=[
        ArchitecturePlacement.CORE,
        ArchitecturePlacement.DEFENSE,
        ArchitecturePlacement.SHIELD,
        ArchitecturePlacement.ENDPOINT,
    ],
    primitive_trace="Ir → Maximum density → Ultimate defense → φ",
    doctrine="Iridium est cor impenetrabile. Densitas ultima.",
)

SILVER = Element(
    symbol="Ag",
    name="Silver",
    atomic_number=47,
    atomic_mass=107.8682,
    category=ElementCategory.NOBLE,
    primary=PrimaryFormula(
        gibbs_formation_kJ=0.0,
        enthalpy_formation_kJ=0.0,
        entropy_J_mol_K=42.6,
        melting_point_K=1234.93,
        boiling_point_K=2435.0,
        density_kg_m3=10490.0,
        electronegativity=1.93,
        thermal_conductivity_W_mK=429.0,  # HIGHEST
        electrical_resistivity_ohm_m=1.59e-8,  # LOWEST
        reduction_potential_V=0.80,
        formula_explanation="ρ_e = 1.59×10⁻⁸ Ω·m — BEST conductor",
    ),
    secondary=SecondaryFormula(
        youngs_modulus_GPa=83.0,
        yield_strength_MPa=170.0,
        ultimate_tensile_MPa=290.0,
        hardness_HV=25.0,
        fatigue_limit_MPa=90.0,
        creep_resistance_hours=10000.0,
        fracture_toughness_MPa_sqrtm=40.0,
        thermal_expansion_um_mK=18.9,
        specific_heat_J_kgK=235.0,
        corrosion_rate_mm_year=0.005,
        load_formula="σ_conductor = low (conductivity priority)",
        stress_formula="Heat disperses instantly via conductivity",
    ),
    uses=[
        ElementUse(ElementUseCase.CONDUCTIVITY, "Maximum electrical conductivity", "ρ = 1.59×10⁻⁸ Ω·m", 1.0),
        ElementUse(ElementUseCase.ANTIMICROBIAL, "Kills pathogens on contact", "Ag⁺ ion release", 0.98),
        ElementUse(ElementUseCase.CATALYSIS, "Oxidation catalysis", "Ag surface oxygen", 0.85),
        ElementUse(ElementUseCase.OPTICAL_CLARITY, "Highest reflectivity", "R = 0.97 at 500nm", 0.97),
        ElementUse(ElementUseCase.SELF_HEALING, "Ag nanoparticle composites", "Particle migration", 0.75),
        ElementUse(ElementUseCase.THERMOELECTRIC_POWER, "Thermocouples", "Seebeck coefficient", 0.70),
        ElementUse(ElementUseCase.BIOCOMPATIBILITY, "Wound healing", "Ag⁺ controlled release", 0.90),
    ],
    placements=[
        ArchitecturePlacement.CONDUCTOR,
        ArchitecturePlacement.INTERFACE,
        ArchitecturePlacement.ENDPOINT,
        ArchitecturePlacement.TOUCHPOINT,
        ArchitecturePlacement.TOOL,
    ],
    primitive_trace="Ag → Electron freedom → Perfect flow → φ",
    doctrine="Argentum via perfecta. Conductio maxima.",
)

COPPER = Element(
    symbol="Cu",
    name="Copper",
    atomic_number=29,
    atomic_mass=63.546,
    category=ElementCategory.TRANSITION,
    primary=PrimaryFormula(
        gibbs_formation_kJ=-129.7,
        enthalpy_formation_kJ=-157.3,
        entropy_J_mol_K=33.2,
        melting_point_K=1357.77,
        boiling_point_K=2835.0,
        density_kg_m3=8960.0,
        electronegativity=1.90,
        thermal_conductivity_W_mK=401.0,  # Second to silver
        electrical_resistivity_ohm_m=1.68e-8,  # Second to silver
        reduction_potential_V=0.34,
        formula_explanation="Universal connector at 60% silver cost",
    ),
    secondary=SecondaryFormula(
        youngs_modulus_GPa=130.0,
        yield_strength_MPa=70.0,
        ultimate_tensile_MPa=220.0,
        hardness_HV=40.0,
        fatigue_limit_MPa=65.0,
        creep_resistance_hours=5000.0,
        fracture_toughness_MPa_sqrtm=33.0,
        thermal_expansion_um_mK=16.5,
        specific_heat_J_kgK=385.0,
        corrosion_rate_mm_year=0.02,
        load_formula="σ = F/A (ductile — deforms vs fractures)",
        stress_formula="Work hardening: σ_y increases with deformation",
    ),
    uses=[
        ElementUse(ElementUseCase.CONDUCTIVITY, "Neural pathway connections", "ρ = 1.68×10⁻⁸ Ω·m", 0.95),
        ElementUse(ElementUseCase.ANTIMICROBIAL, "Contact killing surfaces", "Cu²⁺ release", 0.90),
        ElementUse(ElementUseCase.THERMOELECTRIC_POWER, "Thermocouple standard", "Cu-Constantan", 0.88),
        ElementUse(ElementUseCase.CATALYSIS, "Click chemistry", "Cu(I) catalysis", 0.85),
        ElementUse(ElementUseCase.MEMORY_ALLOY, "Cu-Al-Ni shape memory", "Martensitic transform", 0.80),
        ElementUse(ElementUseCase.ELECTROMAGNETIC_SHIELD, "RF shielding", "High σ, low μ", 0.85),
        ElementUse(ElementUseCase.SELF_HEALING, "Brazed joint self-repair", "Diffusion healing", 0.70),
    ],
    placements=[
        ArchitecturePlacement.CONDUCTOR,
        ArchitecturePlacement.INTERFACE,
        ArchitecturePlacement.TOOL,
        ArchitecturePlacement.TOUCHPOINT,
        ArchitecturePlacement.LAYER,
    ],
    primitive_trace="Cu → Electron mobility → Connection → φ",
    doctrine="Cuprum connectit omnia. Nervus systematis.",
)

PLATINUM = Element(
    symbol="Pt",
    name="Platinum",
    atomic_number=78,
    atomic_mass=195.084,
    category=ElementCategory.NOBLE,
    primary=PrimaryFormula(
        gibbs_formation_kJ=0.0,
        enthalpy_formation_kJ=0.0,
        entropy_J_mol_K=41.6,
        melting_point_K=2041.4,
        boiling_point_K=4098.0,
        density_kg_m3=21450.0,
        electronegativity=2.28,
        thermal_conductivity_W_mK=71.6,
        electrical_resistivity_ohm_m=1.05e-7,
        reduction_potential_V=1.18,
        formula_explanation="Catalyst without consumption — infinite cycles",
    ),
    secondary=SecondaryFormula(
        youngs_modulus_GPa=168.0,
        yield_strength_MPa=150.0,
        ultimate_tensile_MPa=240.0,
        hardness_HV=56.0,
        fatigue_limit_MPa=100.0,
        creep_resistance_hours=100000.0,
        fracture_toughness_MPa_sqrtm=50.0,
        thermal_expansion_um_mK=8.8,
        specific_heat_J_kgK=133.0,
        corrosion_rate_mm_year=0.0,
        load_formula="σ_catalyst = minimal (not load-bearing)",
        stress_formula="Surface stress enhances catalytic activity",
    ),
    uses=[
        ElementUse(ElementUseCase.CATALYSIS, "Supreme catalyst — accelerates without degrading", "E_a → E_a - ΔE", 1.0),
        ElementUse(ElementUseCase.CORROSION_IMMUNITY, "Noble — zero corrosion", "ΔG_ox > 0", 1.0),
        ElementUse(ElementUseCase.PROTECTION, "Endpoint plating", "Noble protection", 0.98),
        ElementUse(ElementUseCase.THERMAL_RESISTANCE, "High temperature operation", "T_melt = 2041K", 0.90),
        ElementUse(ElementUseCase.BIOCOMPATIBILITY, "Implant electrodes", "Zero reaction", 0.95),
        ElementUse(ElementUseCase.PIEZOELECTRIC_SENSE, "Sensor electrodes", "Stable interface", 0.85),
        ElementUse(ElementUseCase.DENSE_DEFENSE, "High density protection", "ρ = 21450 kg/m³", 0.92),
    ],
    placements=[
        ArchitecturePlacement.CATALYST,
        ArchitecturePlacement.ENDPOINT,
        ArchitecturePlacement.INTERFACE,
        ArchitecturePlacement.CORE,
        ArchitecturePlacement.TOUCHPOINT,
    ],
    primitive_trace="Pt → Catalytic acceleration → Infinite cycles → φ",
    doctrine="Platinum accelerat sine fine. Catalyst aeternus.",
)


# =================================================================== #
# ELEMENT REGISTRY                                                      #
# =================================================================== #

ALL_ELEMENTS: List[Element] = [
    GOLD, TITANIUM, TUNGSTEN, IRIDIUM, SILVER, COPPER, PLATINUM
]


def get_element(symbol: str) -> Optional[Element]:
    """Get an element by symbol."""
    for element in ALL_ELEMENTS:
        if element.symbol == symbol:
            return element
    return None


def get_elements_for_placement(placement: ArchitecturePlacement) -> List[Element]:
    """Get all elements suitable for a specific placement."""
    return [e for e in ALL_ELEMENTS if e.has_placement(placement)]


def get_elements_for_use_case(use_case: ElementUseCase) -> List[Element]:
    """Get all elements with a specific use case."""
    return [e for e in ALL_ELEMENTS if any(u.use_case == use_case for u in e.uses)]


def get_alpha_model(model_id: int) -> Optional[AlphaModel]:
    """Get an alpha model by ID."""
    for model in ALPHA_MODELS:
        if model.id == model_id:
            return model
    return None


# =================================================================== #
# THERMODYNAMICS SUBSTRATE — THE COMPLETE DIVISION                      #
# =================================================================== #

class ThermodynamicsSubstrate:
    """
    The Thermodynamics Substrate Division.
    
    Official substrate division with 10 alpha models.
    All elements, all formulas, all uses.
    """
    
    def __init__(self) -> None:
        self._elements = {e.symbol: e for e in ALL_ELEMENTS}
        self._models = {m.id: m for m in ALPHA_MODELS}
    
    @property
    def elements(self) -> Dict[str, Element]:
        """Get all elements."""
        return self._elements
    
    @property
    def alpha_models(self) -> Dict[int, AlphaModel]:
        """Get all alpha models."""
        return self._models
    
    def get_element(self, symbol: str) -> Optional[Element]:
        """Get element by symbol."""
        return self._elements.get(symbol)
    
    def get_model(self, model_id: int) -> Optional[AlphaModel]:
        """Get alpha model by ID."""
        return self._models.get(model_id)
    
    def get_endpoint_protection(self) -> List[Element]:
        """Get elements for endpoint protection."""
        return get_elements_for_placement(ArchitecturePlacement.ENDPOINT)
    
    def get_core_defense(self) -> List[Element]:
        """Get elements for core defense."""
        return get_elements_for_placement(ArchitecturePlacement.CORE)
    
    def get_conductors(self) -> List[Element]:
        """Get conductor elements."""
        return get_elements_for_placement(ArchitecturePlacement.CONDUCTOR)
    
    def calculate_oxidation_resistance(self, symbol: str) -> float:
        """Calculate oxidation resistance for an element."""
        element = self.get_element(symbol)
        if element:
            return element.oxidation_resistance()
        return 0.0
    
    def calculate_load_capacity(self, symbol: str, area_m2: float) -> float:
        """Calculate load capacity for an element."""
        element = self.get_element(symbol)
        if element:
            return element.load_capacity(area_m2)
        return 0.0
    
    def status(self) -> Dict[str, Any]:
        """Get full substrate status."""
        return {
            "division": "Thermodynamics",
            "elements_count": len(self._elements),
            "alpha_models_count": len(self._models),
            "elements": list(self._elements.keys()),
            "alpha_models": [m.name for m in ALPHA_MODELS],
            "doctrine": "Elementa sunt fundamenta. Non corruptibilia. Non degradabilia. Aeterna.",
            "primitive_root": "φ",
        }


# Singleton instance
_substrate_instance: Optional[ThermodynamicsSubstrate] = None


def get_thermodynamics_substrate() -> ThermodynamicsSubstrate:
    """Get or create the global thermodynamics substrate instance."""
    global _substrate_instance
    if _substrate_instance is None:
        _substrate_instance = ThermodynamicsSubstrate()
    return _substrate_instance
