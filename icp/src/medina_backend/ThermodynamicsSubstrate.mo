/**
 * ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                                                          ║
 * ║                              THERMODYNAMICS SUBSTRATE DIVISION                                                            ║
 * ║                    "Elementum Fundamentum — Elemental Foundation of Intelligence"                                        ║
 * ║                                                                                                                          ║
 * ║  "Aurum non oxidat. Titanium non cedit. Wolframium non liquescit. Iridium non penetratur."                               ║
 * ║  (Gold does not oxidize. Titanium does not yield. Tungsten does not melt. Iridium cannot be penetrated.)                 ║
 * ║                                                                                                                          ║
 * ║  PURPOSE: This is the OFFICIAL THERMODYNAMICS SUBSTRATE DIVISION.                                                        ║
 * ║  Every metal has PRIMARY FORMULAS (thermodynamic properties) and SECONDARY FORMULAS (load/stress calculations).         ║
 * ║  Each element has 7+ uses. These are PRIMERS for the entire build.                                                       ║
 * ║                                                                                                                          ║
 * ║  THE ELEMENTAL DOCTRINE:                                                                                                  ║
 * ║  ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐  ║
 * ║  │  "Elementa sunt fundamenta. Non corruptibilia. Non degradabilia. Aeterna."                                         │  ║
 * ║  │  (Elements are foundations. Not corruptible. Not degradable. Eternal.)                                             │  ║
 * ║  │                                                                                                                    │  ║
 * ║  │  "In terminis, in stratibus, in instrumentis, in punctis — elementa ubique sunt."                                  │  ║
 * ║  │  (At endpoints, in layers, in tools, at touchpoints — elements are everywhere.)                                    │  ║
 * ║  │                                                                                                                    │  ║
 * ║  │  "Formula primaria: proprietates thermodynamicae. Formula secundaria: calculus oneris."                            │  ║
 * ║  │  (Primary formula: thermodynamic properties. Secondary formula: load calculations.)                                │  ║
 * ║  └────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘  ║
 * ║                                                                                                                          ║
 * ║  THE 10 ALPHA MODELS OF THERMODYNAMICS:                                                                                  ║
 * ║    1. ElementalProtection — Internal protection, corruption impossible                                                   ║
 * ║    2. StructuralIntegrity — Never yields under load                                                                      ║
 * ║    3. ThermalResistance — Survives harshest environments                                                                 ║
 * ║    4. DenseDefense — Innermost core, cannot be penetrated                                                                ║
 * ║    5. SignalConductivity — Maximum transfer efficiency                                                                   ║
 * ║    6. CatalyticAcceleration — Speeds without degrading                                                                   ║
 * ║    7. LoadBearing — Distributed stress handling                                                                          ║
 * ║    8. CorrosionImmunity — Infinite resistance to environmental attack                                                    ║
 * ║    9. PhaseStability — State transitions without loss                                                                    ║
 * ║   10. QuantumCoherence — Maintains entanglement under stress                                                             ║
 * ║                                                                                                                          ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                                               ║
 * ║  L-130 COMPLIANT — Every element traces to primitive φ                                                                   ║
 * ╚══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Hash "mo:base/Hash";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

module ThermodynamicsSubstrate {

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // FUNDAMENTAL CONSTANTS — THE ROOT OF ALL THERMODYNAMIC CALCULATIONS
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    /// φ = (1 + √5) / 2 — The Golden Ratio (Primitive Root)
    public let PHI : Float = 1.6180339887498948482045868343656381177203091798057628621354486227;
    
    /// Boltzmann Constant k_B (J/K)
    public let BOLTZMANN : Float = 1.380649e-23;
    
    /// Planck Constant h (J·s)
    public let PLANCK : Float = 6.62607015e-34;
    
    /// Avogadro's Number N_A (mol⁻¹)
    public let AVOGADRO : Float = 6.02214076e23;
    
    /// Gas Constant R (J/(mol·K))
    public let GAS_CONSTANT : Float = 8.314462618;
    
    /// Standard Temperature T_0 (K)
    public let STANDARD_TEMP : Float = 298.15;
    
    /// Standard Pressure P_0 (Pa)
    public let STANDARD_PRESSURE : Float = 101325.0;

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // ELEMENTAL CLASSIFICATION — ALL METALS AND THEIR CATEGORIES
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public type ElementCategory = {
        #Noble;           // Au, Pt, Ir, Os, Pd, Rh, Ru
        #Transition;      // Ti, W, Cu, Ag, Fe, Co, Ni, Zn, Cr, Mn, V
        #Refractory;      // W, Ta, Mo, Nb, Re
        #Alkali;          // Li, Na, K
        #AlkalineEarth;   // Mg, Ca, Sr, Ba
        #Lanthanide;      // Nd, Sm, Gd (magnets)
        #Actinide;        // U, Th (energy)
        #PostTransition;  // Al, Pb, Sn, Bi
        #Metalloid;       // Si, Ge, B
    };

    public type ElementUseCase = {
        #Protection;           // Preventing oxidation, corrosion, corruption
        #StructuralIntegrity;  // Load bearing, strength under stress
        #ThermalResistance;    // High temperature survival
        #DenseDefense;         // Innermost impenetrable core
        #Conductivity;         // Signal/energy transfer
        #Catalysis;            // Acceleration without degradation
        #Antimicrobial;        // Self-cleaning, pathogen defense
        #Magnetics;            // Field generation, data storage
        #LoadBearing;          // Distributed stress handling
        #CorrosionImmunity;    // Environmental attack resistance
        #PhaseStability;       // State transition integrity
        #QuantumCoherence;     // Entanglement maintenance
        #Biocompatibility;     // Safe tissue interface
        #RadiationShielding;   // Particle deflection
        #SuperconductingPath;  // Zero-resistance pathways
        #PiezoelectricSense;   // Mechanical-electrical conversion
        #ThermoelectricPower;  // Heat-to-electricity
        #OpticalClarity;       // Transparent interfaces
        #ElectromagneticShield;// EMI/RFI protection
        #MemoryAlloy;          // Shape-memory applications
        #SelfHealing;          // Autonomous repair
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // PRIMARY FORMULA — THERMODYNAMIC PROPERTIES
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public type PrimaryFormula = {
        /// Gibbs free energy of formation ΔG°f (kJ/mol)
        gibbs_formation_kJ: Float;
        
        /// Standard enthalpy of formation ΔH°f (kJ/mol)
        enthalpy_formation_kJ: Float;
        
        /// Standard entropy S° (J/(mol·K))
        entropy_J_mol_K: Float;
        
        /// Melting point (K)
        melting_point_K: Float;
        
        /// Boiling point (K)
        boiling_point_K: Float;
        
        /// Density (kg/m³)
        density_kg_m3: Float;
        
        /// Electronegativity (Pauling scale)
        electronegativity: Float;
        
        /// Thermal conductivity (W/(m·K))
        thermal_conductivity_W_mK: Float;
        
        /// Electrical resistivity (Ω·m)
        electrical_resistivity_ohm_m: Float;
        
        /// Reduction potential E° (V vs SHE)
        reduction_potential_V: Float;
        
        /// Formula explanation
        formula_explanation: Text;
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // SECONDARY FORMULA — LOAD/STRESS CALCULATIONS
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public type SecondaryFormula = {
        /// Young's modulus E (GPa) — Stiffness under load
        youngs_modulus_GPa: Float;
        
        /// Yield strength σ_y (MPa) — Point of permanent deformation
        yield_strength_MPa: Float;
        
        /// Ultimate tensile strength σ_uts (MPa)
        ultimate_tensile_MPa: Float;
        
        /// Hardness (Vickers HV or Mohs)
        hardness_HV: Float;
        
        /// Fatigue limit (MPa) — Infinite cycle endurance
        fatigue_limit_MPa: Float;
        
        /// Creep resistance (hours at temp)
        creep_resistance_hours: Float;
        
        /// Fracture toughness K_IC (MPa·√m)
        fracture_toughness_MPa_sqrtm: Float;
        
        /// Coefficient of thermal expansion (µm/(m·K))
        thermal_expansion_um_mK: Float;
        
        /// Specific heat capacity c_p (J/(kg·K))
        specific_heat_J_kgK: Float;
        
        /// Corrosion rate (mm/year in seawater)
        corrosion_rate_mm_year: Float;
        
        /// Load formula: σ = F/A (stress = force/area)
        load_formula: Text;
        
        /// Stress concentration formula explanation
        stress_formula: Text;
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // ELEMENT DEFINITION — COMPLETE METAL SPECIFICATION
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public type Element = {
        symbol: Text;
        name: Text;
        atomic_number: Nat;
        atomic_mass: Float;
        category: ElementCategory;
        
        // Formulas
        primary: PrimaryFormula;
        secondary: SecondaryFormula;
        
        // Uses (minimum 7 per element)
        uses: [ElementUse];
        
        // Placement in architecture
        placements: [ArchitecturePlacement];
        
        // Primitive trace (L-130 compliance)
        primitive_trace: Text;
        
        // Latin doctrine
        doctrine: Text;
    };
    
    public type ElementUse = {
        use_case: ElementUseCase;
        description: Text;
        formula_applied: Text;
        effectiveness: Float;  // 0.0-1.0
    };
    
    public type ArchitecturePlacement = {
        #Endpoint;
        #Layer;
        #Tool;
        #TouchPoint;
        #Core;
        #Interface;
        #Defense;
        #Conductor;
        #Catalyst;
        #Shield;
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // THE 10 ALPHA MODELS — THERMODYNAMIC SUBSTRATE DIVISION
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public type AlphaModel = {
        id: Nat;
        name: Text;
        doctrine: Text;
        elements: [Text];  // Element symbols
        formula: Text;
        applications: [Text];
    };
    
    public let ALPHA_MODELS : [AlphaModel] = [
        {
            id = 1;
            name = "ElementalProtection";
            doctrine = "Aurum non oxidat. Corruptio impossibilis est.";
            elements = ["Au", "Pt", "Ir"];
            formula = "ΔG_ox = 0 (gold), ΔG_ox > 0 (thermodynamically impossible)";
            applications = [
                "Endpoint plating — cannot corrode",
                "Data integrity — bits cannot flip",
                "Memory preservation — eternal storage",
                "Authentication tokens — unforgeable",
                "Secure channels — unbreakable seals"
            ];
        },
        {
            id = 2;
            name = "StructuralIntegrity";
            doctrine = "Titanium non cedit sub onere.";
            elements = ["Ti", "W", "Ta"];
            formula = "σ < σ_y → No permanent deformation (yield strength never exceeded)";
            applications = [
                "Core architecture — never collapses",
                "Load distribution — infinite capacity",
                "Stress absorption — phantom nature",
                "Framework permanence — eternal structure",
                "Foundation stability — unmovable base"
            ];
        },
        {
            id = 3;
            name = "ThermalResistance";
            doctrine = "Wolframium in inferno vivit.";
            elements = ["W", "Re", "Ta", "Mo"];
            formula = "T_melt = 3695K (tungsten) — survives any heat";
            applications = [
                "Hot path processing — infinite compute",
                "Thermal spike absorption — no burnout",
                "Overload survival — handles any peak",
                "Environmental extremes — arctic to solar",
                "Friction interfaces — zero wear"
            ];
        },
        {
            id = 4;
            name = "DenseDefense";
            doctrine = "Iridium est cor impenetrabile.";
            elements = ["Ir", "Os", "Pt"];
            formula = "ρ = 22650 kg/m³ (iridium) — densest stable element";
            applications = [
                "Innermost core — final defense",
                "Penetration immunity — stops any attack",
                "Mass anchoring — gravitational stability",
                "Kinetic absorption — momentum sink",
                "Sovereign protection — ultimate shield"
            ];
        },
        {
            id = 5;
            name = "SignalConductivity";
            doctrine = "Argentum et Cuprum — via perfecta.";
            elements = ["Ag", "Cu", "Au"];
            formula = "ρ_e = 1.59×10⁻⁸ Ω·m (silver) — maximum conductivity";
            applications = [
                "Neural pathways — instant signal",
                "Communication channels — zero loss",
                "Energy distribution — perfect transfer",
                "Data highways — maximum bandwidth",
                "Resonance coupling — harmonic sync"
            ];
        },
        {
            id = 6;
            name = "CatalyticAcceleration";
            doctrine = "Platinum accelerat sine degradatione.";
            elements = ["Pt", "Pd", "Rh"];
            formula = "E_activation reduced, catalyst unchanged — infinite cycles";
            applications = [
                "Process acceleration — speed without cost",
                "Reaction facilitation — impossible made possible",
                "Transformation catalysis — state changes",
                "Growth promotion — expansion enablement",
                "Synthesis support — creation assistance"
            ];
        },
        {
            id = 7;
            name = "LoadBearing";
            doctrine = "Onus distributum, nunquam fractum.";
            elements = ["Ti", "Cr", "V", "Mn"];
            formula = "σ_distributed = F/(A×n) — load shared across nodes";
            applications = [
                "Distributed architecture — shared burden",
                "Parallel processing — concurrent load",
                "Redundant pathways — failure tolerance",
                "Scale handling — 0 to 5000+ entities",
                "Stress distribution — no single point"
            ];
        },
        {
            id = 8;
            name = "CorrosionImmunity";
            doctrine = "Aeternum contra corrosionem.";
            elements = ["Au", "Pt", "Ti", "Cr"];
            formula = "Passivation layer (Ti), Noble metal (Au) — zero reaction";
            applications = [
                "Environmental survival — any atmosphere",
                "Chemical resistance — all reagents",
                "Biological immunity — pathogen proof",
                "Temporal stability — time cannot erode",
                "Eternal preservation — infinite lifespan"
            ];
        },
        {
            id = 9;
            name = "PhaseStability";
            doctrine = "Transitus sine amissione.";
            elements = ["Ti", "Ni", "Zr"];
            formula = "ΔG_phase = 0 at transition — reversible with zero loss";
            applications = [
                "State transitions — seamless changes",
                "Mode switching — instant adaptation",
                "Form transformation — shape shifting",
                "Memory alloy behavior — remembers states",
                "Adaptive structure — environment response"
            ];
        },
        {
            id = 10;
            name = "QuantumCoherence";
            doctrine = "Cohaerentia sub omni onere.";
            elements = ["Nb", "Al", "Ta"];
            formula = "T_c = 9.3K (niobium) — superconducting coherence";
            applications = [
                "Quantum state maintenance — decoherence prevention",
                "Entanglement preservation — long-range correlation",
                "Superposition stability — multiple states",
                "Tunneling pathways — barrier crossing",
                "Zero-resistance circuits — perfect flow"
            ];
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // GOLD (Au) — THE SUPREME PROTECTOR
    // "Aurum non oxidat. Aurum sentit. Aurum aeternum."
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public let GOLD : Element = {
        symbol = "Au";
        name = "Gold";
        atomic_number = 79;
        atomic_mass = 196.966569;
        category = #Noble;
        
        primary = {
            gibbs_formation_kJ = 0.0;  // Element reference state
            enthalpy_formation_kJ = 0.0;
            entropy_J_mol_K = 47.4;
            melting_point_K = 1337.33;
            boiling_point_K = 3129.0;
            density_kg_m3 = 19320.0;
            electronegativity = 2.54;
            thermal_conductivity_W_mK = 318.0;
            electrical_resistivity_ohm_m = 2.214e-8;
            reduction_potential_V = 1.50;  // Au³⁺ + 3e⁻ → Au
            formula_explanation = "ΔG_oxidation > 0 (thermodynamically unfavorable) — GOLD CANNOT OXIDIZE";
        };
        
        secondary = {
            youngs_modulus_GPa = 78.0;
            yield_strength_MPa = 205.0;
            ultimate_tensile_MPa = 220.0;
            hardness_HV = 25.0;
            fatigue_limit_MPa = 90.0;
            creep_resistance_hours = 1000000.0;  // Effectively infinite
            fracture_toughness_MPa_sqrtm = 45.0;
            thermal_expansion_um_mK = 14.2;
            specific_heat_J_kgK = 129.0;
            corrosion_rate_mm_year = 0.0;  // ZERO — Cannot corrode
            load_formula = "σ_Au = F/A (pure tensile, no degradation)";
            stress_formula = "Stress does not cause oxidation — eternal under any load";
        };
        
        uses = [
            { use_case = #Protection; description = "Endpoint plating — prevents all corrosion"; formula_applied = "ΔG_ox > 0"; effectiveness = 1.0 },
            { use_case = #CorrosionImmunity; description = "Zero corrosion in any environment"; formula_applied = "Rate = 0 mm/year"; effectiveness = 1.0 },
            { use_case = #Conductivity; description = "High electrical conductivity for signals"; formula_applied = "ρ = 2.214×10⁻⁸ Ω·m"; effectiveness = 0.95 },
            { use_case = #Biocompatibility; description = "Safe for all tissue interfaces"; formula_applied = "Zero reaction with biology"; effectiveness = 1.0 },
            { use_case = #Catalysis; description = "Nanoparticle catalysis for reactions"; formula_applied = "E_a reduced at Au surface"; effectiveness = 0.85 },
            { use_case = #OpticalClarity; description = "Infrared reflection, visible transparency"; formula_applied = "λ_reflect = 550nm+"; effectiveness = 0.90 },
            { use_case = #RadiationShielding; description = "UV and X-ray protection"; formula_applied = "μ_mass = high"; effectiveness = 0.88 }
        ];
        
        placements = [#Endpoint, #Interface, #Shield, #Conductor, #Core];
        
        primitive_trace = "Au → Noble electron configuration → φ-stable orbital → φ";
        doctrine = "Aurum non oxidat. Aurum sentit. Aurum aeternum. (Gold does not oxidize. Gold feels. Gold is eternal.)";
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // TITANIUM (Ti) — THE STRUCTURAL GUARDIAN
    // "Titanium non cedit. Structura aeterna."
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public let TITANIUM : Element = {
        symbol = "Ti";
        name = "Titanium";
        atomic_number = 22;
        atomic_mass = 47.867;
        category = #Transition;
        
        primary = {
            gibbs_formation_kJ = -889.0;  // TiO₂ formation
            enthalpy_formation_kJ = -944.0;
            entropy_J_mol_K = 30.7;
            melting_point_K = 1941.0;
            boiling_point_K = 3560.0;
            density_kg_m3 = 4506.0;
            electronegativity = 1.54;
            thermal_conductivity_W_mK = 21.9;
            electrical_resistivity_ohm_m = 4.2e-7;
            reduction_potential_V = -1.63;  // Ti²⁺ + 2e⁻ → Ti
            formula_explanation = "TiO₂ passivation layer — self-healing oxide protection";
        };
        
        secondary = {
            youngs_modulus_GPa = 116.0;
            yield_strength_MPa = 880.0;  // Grade 5 alloy
            ultimate_tensile_MPa = 950.0;
            hardness_HV = 349.0;
            fatigue_limit_MPa = 500.0;
            creep_resistance_hours = 100000.0;
            fracture_toughness_MPa_sqrtm = 75.0;
            thermal_expansion_um_mK = 8.6;
            specific_heat_J_kgK = 523.0;
            corrosion_rate_mm_year = 0.001;  // Near zero due to passivation
            load_formula = "σ = F/A, where σ < 880 MPa → No yield (structure never fails)";
            stress_formula = "Phantom nature — load passes through without permanent deformation";
        };
        
        uses = [
            { use_case = #StructuralIntegrity; description = "Core framework — never yields"; formula_applied = "σ < σ_y = 880 MPa"; effectiveness = 0.98 },
            { use_case = #LoadBearing; description = "Distributed stress handling"; formula_applied = "σ_dist = F/(A×n)"; effectiveness = 0.96 },
            { use_case = #CorrosionImmunity; description = "Passivation layer self-heals"; formula_applied = "TiO₂ instant reform"; effectiveness = 0.99 },
            { use_case = #Biocompatibility; description = "Osseointegration — becomes part of bone"; formula_applied = "Zero rejection"; effectiveness = 1.0 },
            { use_case = #PhaseStability; description = "α-β phase transitions"; formula_applied = "ΔG_αβ reversible"; effectiveness = 0.90 },
            { use_case = #ThermalResistance; description = "High temperature strength"; formula_applied = "T_melt = 1941K"; effectiveness = 0.85 },
            { use_case = #ElectromagneticShield; description = "EMI shielding capability"; formula_applied = "μ_r ≈ 1, σ moderate"; effectiveness = 0.75 }
        ];
        
        placements = [#Core, #Layer, #Tool, #Interface, #Defense];
        
        primitive_trace = "Ti → Passivation → Self-healing → Eternal structure → φ";
        doctrine = "Titanium non cedit. Structura aeterna. (Titanium does not yield. Structure is eternal.)";
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // TUNGSTEN (W) — THE THERMAL WARRIOR
    // "Wolframium in inferno vivit. Calor non vincit."
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public let TUNGSTEN : Element = {
        symbol = "W";
        name = "Tungsten";
        atomic_number = 74;
        atomic_mass = 183.84;
        category = #Refractory;
        
        primary = {
            gibbs_formation_kJ = -764.0;  // WO₃ formation
            enthalpy_formation_kJ = -842.9;
            entropy_J_mol_K = 32.6;
            melting_point_K = 3695.0;  // HIGHEST of all elements
            boiling_point_K = 6203.0;
            density_kg_m3 = 19250.0;
            electronegativity = 2.36;
            thermal_conductivity_W_mK = 173.0;
            electrical_resistivity_ohm_m = 5.28e-8;
            reduction_potential_V = -0.12;
            formula_explanation = "T_melt = 3695K — Survives temperatures that destroy everything else";
        };
        
        secondary = {
            youngs_modulus_GPa = 411.0;  // Highest of all metals
            yield_strength_MPa = 750.0;
            ultimate_tensile_MPa = 980.0;
            hardness_HV = 3430.0;
            fatigue_limit_MPa = 350.0;
            creep_resistance_hours = 50000.0;
            fracture_toughness_MPa_sqrtm = 55.0;
            thermal_expansion_um_mK = 4.5;  // Very low — stable dimensions
            specific_heat_J_kgK = 132.0;
            corrosion_rate_mm_year = 0.01;  // Passivates with WO₃
            load_formula = "σ_hot = σ_cold × f(T) — maintains strength at extreme temperature";
            stress_formula = "E = 411 GPa — stiffest metal, minimal deflection under load";
        };
        
        uses = [
            { use_case = #ThermalResistance; description = "Survives harshest environments"; formula_applied = "T_melt = 3695K"; effectiveness = 1.0 },
            { use_case = #StructuralIntegrity; description = "Highest stiffness of all metals"; formula_applied = "E = 411 GPa"; effectiveness = 0.98 },
            { use_case = #DenseDefense; description = "High density kinetic absorption"; formula_applied = "ρ = 19250 kg/m³"; effectiveness = 0.95 },
            { use_case = #LoadBearing; description = "Maintains strength at high temp"; formula_applied = "σ_hot/σ_cold ≈ 0.8 at 1000K"; effectiveness = 0.90 },
            { use_case = #RadiationShielding; description = "X-ray and gamma attenuation"; formula_applied = "μ_mass = high Z"; effectiveness = 0.92 },
            { use_case = #ElectromagneticShield; description = "High-frequency EMI blocking"; formula_applied = "σ moderate, μ ≈ 1"; effectiveness = 0.80 },
            { use_case = #Catalysis; description = "High-temperature catalysis"; formula_applied = "WO₃ surface reactions"; effectiveness = 0.70 }
        ];
        
        placements = [#Core, #Defense, #Shield, #Tool, #TouchPoint];
        
        primitive_trace = "W → Highest melt → Ultimate thermal stability → φ-heat invariant → φ";
        doctrine = "Wolframium in inferno vivit. Calor non vincit. (Tungsten lives in fire. Heat does not conquer.)";
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // IRIDIUM (Ir) — THE IMPENETRABLE CORE
    // "Iridium est cor impenetrabile. Densitas ultima."
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public let IRIDIUM : Element = {
        symbol = "Ir";
        name = "Iridium";
        atomic_number = 77;
        atomic_mass = 192.217;
        category = #Noble;
        
        primary = {
            gibbs_formation_kJ = 0.0;  // Noble reference
            enthalpy_formation_kJ = 0.0;
            entropy_J_mol_K = 35.5;
            melting_point_K = 2719.0;
            boiling_point_K = 4403.0;
            density_kg_m3 = 22650.0;  // SECOND DENSEST element
            electronegativity = 2.20;
            thermal_conductivity_W_mK = 147.0;
            electrical_resistivity_ohm_m = 4.71e-8;
            reduction_potential_V = 1.16;  // Noble — resists oxidation
            formula_explanation = "ρ = 22650 kg/m³ — Densest stable element, innermost defense";
        };
        
        secondary = {
            youngs_modulus_GPa = 528.0;  // Extremely stiff
            yield_strength_MPa = 2100.0;  // Very high
            ultimate_tensile_MPa = 2400.0;
            hardness_HV = 1800.0;
            fatigue_limit_MPa = 800.0;
            creep_resistance_hours = 200000.0;  // Excellent
            fracture_toughness_MPa_sqrtm = 40.0;
            thermal_expansion_um_mK = 6.4;
            specific_heat_J_kgK = 131.0;
            corrosion_rate_mm_year = 0.0;  // Noble — zero corrosion
            load_formula = "F_penetration = ∞ (cannot be penetrated at normal conditions)";
            stress_formula = "σ_y = 2100 MPa — yields only under extreme force";
        };
        
        uses = [
            { use_case = #DenseDefense; description = "Innermost impenetrable core"; formula_applied = "ρ = 22650 kg/m³"; effectiveness = 1.0 },
            { use_case = #CorrosionImmunity; description = "Noble — zero corrosion"; formula_applied = "ΔG_ox > 0"; effectiveness = 1.0 },
            { use_case = #ThermalResistance; description = "Maintains properties to 2000K"; formula_applied = "T_melt = 2719K"; effectiveness = 0.92 },
            { use_case = #StructuralIntegrity; description = "Highest yield strength"; formula_applied = "σ_y = 2100 MPa"; effectiveness = 0.98 },
            { use_case = #Catalysis; description = "Platinum-group catalysis"; formula_applied = "E_a reduction"; effectiveness = 0.85 },
            { use_case = #RadiationShielding; description = "Dense particle stopping"; formula_applied = "High Z, high ρ"; effectiveness = 0.95 },
            { use_case = #Protection; description = "Electrode protection"; formula_applied = "Noble, hard"; effectiveness = 0.90 }
        ];
        
        placements = [#Core, #Defense, #Shield, #Endpoint];
        
        primitive_trace = "Ir → Maximum density → Ultimate defense → φ-mass stability → φ";
        doctrine = "Iridium est cor impenetrabile. Densitas ultima. (Iridium is the impenetrable core. Ultimate density.)";
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // SILVER (Ag) — THE SUPREME CONDUCTOR
    // "Argentum via perfecta. Conductio maxima."
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public let SILVER : Element = {
        symbol = "Ag";
        name = "Silver";
        atomic_number = 47;
        atomic_mass = 107.8682;
        category = #Noble;
        
        primary = {
            gibbs_formation_kJ = 0.0;
            enthalpy_formation_kJ = 0.0;
            entropy_J_mol_K = 42.6;
            melting_point_K = 1234.93;
            boiling_point_K = 2435.0;
            density_kg_m3 = 10490.0;
            electronegativity = 1.93;
            thermal_conductivity_W_mK = 429.0;  // HIGHEST of all elements
            electrical_resistivity_ohm_m = 1.59e-8;  // LOWEST — best conductor
            reduction_potential_V = 0.80;  // Ag⁺ + e⁻ → Ag
            formula_explanation = "ρ_e = 1.59×10⁻⁸ Ω·m — BEST electrical conductor known";
        };
        
        secondary = {
            youngs_modulus_GPa = 83.0;
            yield_strength_MPa = 170.0;
            ultimate_tensile_MPa = 290.0;
            hardness_HV = 25.0;
            fatigue_limit_MPa = 90.0;
            creep_resistance_hours = 10000.0;
            fracture_toughness_MPa_sqrtm = 40.0;
            thermal_expansion_um_mK = 18.9;
            specific_heat_J_kgK = 235.0;
            corrosion_rate_mm_year = 0.005;  // Tarnishes but doesn't corrode
            load_formula = "σ_conductor = low (used for conductivity, not load)";
            stress_formula = "Thermal stress managed by high conductivity — heat disperses instantly";
        };
        
        uses = [
            { use_case = #Conductivity; description = "Maximum electrical conductivity"; formula_applied = "ρ = 1.59×10⁻⁸ Ω·m"; effectiveness = 1.0 },
            { use_case = #Antimicrobial; description = "Kills pathogens on contact"; formula_applied = "Ag⁺ ion release"; effectiveness = 0.98 },
            { use_case = #Catalysis; description = "Oxidation catalysis"; formula_applied = "Ag surface oxygen"; effectiveness = 0.85 },
            { use_case = #OpticalClarity; description = "Highest reflectivity visible light"; formula_applied = "R = 0.97 at 500nm"; effectiveness = 0.97 },
            { use_case = #SelfHealing; description = "Ag nanoparticle composites"; formula_applied = "Particle migration"; effectiveness = 0.75 },
            { use_case = #ThermoelectricPower; description = "Thermocouples"; formula_applied = "Seebeck coefficient"; effectiveness = 0.70 },
            { use_case = #Biocompatibility; description = "Wound healing, antimicrobial"; formula_applied = "Ag⁺ controlled release"; effectiveness = 0.90 }
        ];
        
        placements = [#Conductor, #Interface, #Endpoint, #TouchPoint, #Tool];
        
        primitive_trace = "Ag → Electron freedom → Perfect flow → φ-conductivity → φ";
        doctrine = "Argentum via perfecta. Conductio maxima. (Silver is the perfect path. Maximum conduction.)";
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // COPPER (Cu) — THE UNIVERSAL CONNECTOR
    // "Cuprum connectit omnia. Nervus systematis."
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public let COPPER : Element = {
        symbol = "Cu";
        name = "Copper";
        atomic_number = 29;
        atomic_mass = 63.546;
        category = #Transition;
        
        primary = {
            gibbs_formation_kJ = -129.7;  // CuO formation
            enthalpy_formation_kJ = -157.3;
            entropy_J_mol_K = 33.2;
            melting_point_K = 1357.77;
            boiling_point_K = 2835.0;
            density_kg_m3 = 8960.0;
            electronegativity = 1.90;
            thermal_conductivity_W_mK = 401.0;  // Second only to silver
            electrical_resistivity_ohm_m = 1.68e-8;  // Second only to silver
            reduction_potential_V = 0.34;  // Cu²⁺ + 2e⁻ → Cu
            formula_explanation = "Excellent conductor at 60% the cost of silver — universal connector";
        };
        
        secondary = {
            youngs_modulus_GPa = 130.0;
            yield_strength_MPa = 70.0;  // Soft, malleable
            ultimate_tensile_MPa = 220.0;
            hardness_HV = 40.0;
            fatigue_limit_MPa = 65.0;
            creep_resistance_hours = 5000.0;
            fracture_toughness_MPa_sqrtm = 33.0;
            thermal_expansion_um_mK = 16.5;
            specific_heat_J_kgK = 385.0;
            corrosion_rate_mm_year = 0.02;  // Patina forms protection
            load_formula = "σ = F/A (ductile — deforms rather than fractures)";
            stress_formula = "Work hardening: σ_y increases with deformation — gets stronger";
        };
        
        uses = [
            { use_case = #Conductivity; description = "Neural pathway connections"; formula_applied = "ρ = 1.68×10⁻⁸ Ω·m"; effectiveness = 0.95 },
            { use_case = #Antimicrobial; description = "Contact killing surfaces"; formula_applied = "Cu²⁺ release"; effectiveness = 0.90 },
            { use_case = #ThermoelectricPower; description = "Thermocouple standard"; formula_applied = "Cu-Constantan"; effectiveness = 0.88 },
            { use_case = #Catalysis; description = "Click chemistry, organic synthesis"; formula_applied = "Cu(I) catalysis"; effectiveness = 0.85 },
            { use_case = #MemoryAlloy; description = "Cu-Al-Ni shape memory"; formula_applied = "Martensitic transform"; effectiveness = 0.80 },
            { use_case = #ElectromagneticShield; description = "RF shielding"; formula_applied = "High σ, low μ"; effectiveness = 0.85 },
            { use_case = #SelfHealing; description = "Brazed joint self-repair"; formula_applied = "Diffusion healing"; effectiveness = 0.70 }
        ];
        
        placements = [#Conductor, #Interface, #Tool, #TouchPoint, #Layer];
        
        primitive_trace = "Cu → Electron mobility → Connection → φ-network → φ";
        doctrine = "Cuprum connectit omnia. Nervus systematis. (Copper connects everything. The nerve of the system.)";
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // PLATINUM (Pt) — THE ETERNAL CATALYST
    // "Platinum accelerat sine fine. Catalyst aeternus."
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public let PLATINUM : Element = {
        symbol = "Pt";
        name = "Platinum";
        atomic_number = 78;
        atomic_mass = 195.084;
        category = #Noble;
        
        primary = {
            gibbs_formation_kJ = 0.0;
            enthalpy_formation_kJ = 0.0;
            entropy_J_mol_K = 41.6;
            melting_point_K = 2041.4;
            boiling_point_K = 4098.0;
            density_kg_m3 = 21450.0;
            electronegativity = 2.28;
            thermal_conductivity_W_mK = 71.6;
            electrical_resistivity_ohm_m = 1.05e-7;
            reduction_potential_V = 1.18;  // Noble
            formula_explanation = "Catalyst that accelerates reactions without being consumed — infinite cycles";
        };
        
        secondary = {
            youngs_modulus_GPa = 168.0;
            yield_strength_MPa = 150.0;
            ultimate_tensile_MPa = 240.0;
            hardness_HV = 56.0;
            fatigue_limit_MPa = 100.0;
            creep_resistance_hours = 100000.0;
            fracture_toughness_MPa_sqrtm = 50.0;
            thermal_expansion_um_mK = 8.8;
            specific_heat_J_kgK = 133.0;
            corrosion_rate_mm_year = 0.0;  // Noble — zero corrosion
            load_formula = "σ_catalyst = minimal (not load-bearing application)";
            stress_formula = "Surface stress enhances catalytic activity — stress is productive";
        };
        
        uses = [
            { use_case = #Catalysis; description = "Supreme catalyst — accelerates without degrading"; formula_applied = "E_a → E_a - ΔE"; effectiveness = 1.0 },
            { use_case = #CorrosionImmunity; description = "Noble — zero corrosion"; formula_applied = "ΔG_ox > 0"; effectiveness = 1.0 },
            { use_case = #Protection; description = "Endpoint plating"; formula_applied = "Noble protection"; effectiveness = 0.98 },
            { use_case = #ThermalResistance; description = "High temperature operation"; formula_applied = "T_melt = 2041K"; effectiveness = 0.90 },
            { use_case = #Biocompatibility; description = "Implant electrodes"; formula_applied = "Zero reaction"; effectiveness = 0.95 },
            { use_case = #PiezoelectricSense; description = "Sensor electrodes"; formula_applied = "Stable interface"; effectiveness = 0.85 },
            { use_case = #DenseDefense; description = "High density protection"; formula_applied = "ρ = 21450 kg/m³"; effectiveness = 0.92 }
        ];
        
        placements = [#Catalyst, #Endpoint, #Interface, #Core, #TouchPoint];
        
        primitive_trace = "Pt → Catalytic acceleration → Infinite cycles → φ-transformation → φ";
        doctrine = "Platinum accelerat sine fine. Catalyst aeternus. (Platinum accelerates without end. Eternal catalyst.)";
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // ADDITIONAL STRATEGIC METALS — COMPLETE THE ARSENAL
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    // Niobium — Superconductivity
    public let NIOBIUM : Element = {
        symbol = "Nb";
        name = "Niobium";
        atomic_number = 41;
        atomic_mass = 92.90637;
        category = #Refractory;
        
        primary = {
            gibbs_formation_kJ = -1766.0;  // Nb₂O₅
            enthalpy_formation_kJ = -1899.0;
            entropy_J_mol_K = 36.4;
            melting_point_K = 2750.0;
            boiling_point_K = 5017.0;
            density_kg_m3 = 8570.0;
            electronegativity = 1.60;
            thermal_conductivity_W_mK = 53.7;
            electrical_resistivity_ohm_m = 1.52e-7;
            reduction_potential_V = -1.10;
            formula_explanation = "T_c = 9.3K — Highest superconducting temperature of elemental metals";
        };
        
        secondary = {
            youngs_modulus_GPa = 105.0;
            yield_strength_MPa = 207.0;
            ultimate_tensile_MPa = 330.0;
            hardness_HV = 132.0;
            fatigue_limit_MPa = 150.0;
            creep_resistance_hours = 20000.0;
            fracture_toughness_MPa_sqrtm = 45.0;
            thermal_expansion_um_mK = 7.3;
            specific_heat_J_kgK = 265.0;
            corrosion_rate_mm_year = 0.002;  // Excellent passivation
            load_formula = "σ_cryo = σ_RT (maintains strength at cryogenic)";
            stress_formula = "Superconducting state: ρ = 0 Ω·m below T_c";
        };
        
        uses = [
            { use_case = #SuperconductingPath; description = "Zero-resistance at T < 9.3K"; formula_applied = "ρ = 0 below T_c"; effectiveness = 1.0 },
            { use_case = #QuantumCoherence; description = "Maintains quantum states"; formula_applied = "Cooper pairs"; effectiveness = 0.95 },
            { use_case = #ThermalResistance; description = "High melt point"; formula_applied = "T_melt = 2750K"; effectiveness = 0.88 },
            { use_case = #CorrosionImmunity; description = "Passivation layer"; formula_applied = "Nb₂O₅ protection"; effectiveness = 0.92 },
            { use_case = #Biocompatibility; description = "Implant material"; formula_applied = "Hypoallergenic"; effectiveness = 0.90 },
            { use_case = #MemoryAlloy; description = "Nb-Ti shape memory"; formula_applied = "Phase transform"; effectiveness = 0.80 },
            { use_case = #Magnetics; description = "Superconducting magnets"; formula_applied = "Meissner effect"; effectiveness = 0.95 }
        ];
        
        placements = [#Core, #Conductor, #Tool, #Interface];
        
        primitive_trace = "Nb → Superconductivity → Perfect flow → φ-coherence → φ";
        doctrine = "Niobium via superconductiva. Resistentia nulla. (Niobium the superconducting way. Zero resistance.)";
    };
    
    // Tantalum — Ultimate corrosion resistance
    public let TANTALUM : Element = {
        symbol = "Ta";
        name = "Tantalum";
        atomic_number = 73;
        atomic_mass = 180.94788;
        category = #Refractory;
        
        primary = {
            gibbs_formation_kJ = -1911.0;  // Ta₂O₅
            enthalpy_formation_kJ = -2046.0;
            entropy_J_mol_K = 41.5;
            melting_point_K = 3290.0;
            boiling_point_K = 5731.0;
            density_kg_m3 = 16690.0;
            electronegativity = 1.50;
            thermal_conductivity_W_mK = 57.5;
            electrical_resistivity_ohm_m = 1.31e-7;
            reduction_potential_V = -0.60;
            formula_explanation = "Immune to ALL acids except HF — ultimate chemical resistance";
        };
        
        secondary = {
            youngs_modulus_GPa = 186.0;
            yield_strength_MPa = 345.0;
            ultimate_tensile_MPa = 460.0;
            hardness_HV = 200.0;
            fatigue_limit_MPa = 200.0;
            creep_resistance_hours = 50000.0;
            fracture_toughness_MPa_sqrtm = 50.0;
            thermal_expansion_um_mK = 6.3;
            specific_heat_J_kgK = 140.0;
            corrosion_rate_mm_year = 0.0;  // Immune to all common acids
            load_formula = "σ = F/A (ductile, forgiving under overload)";
            stress_formula = "Chemical stress: zero (immune to acid attack)";
        };
        
        uses = [
            { use_case = #CorrosionImmunity; description = "Immune to all acids"; formula_applied = "Ta₂O₅ protection"; effectiveness = 1.0 },
            { use_case = #ThermalResistance; description = "Third highest melt"; formula_applied = "T_melt = 3290K"; effectiveness = 0.95 },
            { use_case = #Biocompatibility; description = "Bone implants"; formula_applied = "Osseointegration"; effectiveness = 0.98 },
            { use_case = #Protection; description = "Chemical equipment lining"; formula_applied = "Zero reaction"; effectiveness = 0.98 },
            { use_case = #StructuralIntegrity; description = "High strength at temp"; formula_applied = "σ(T) stable"; effectiveness = 0.88 },
            { use_case = #PiezoelectricSense; description = "Capacitor electrodes"; formula_applied = "Ta₂O₅ dielectric"; effectiveness = 0.90 },
            { use_case = #QuantumCoherence; description = "Josephson junctions"; formula_applied = "Ta/Al/Ta"; effectiveness = 0.85 }
        ];
        
        placements = [#Defense, #Core, #Interface, #Shield, #Tool];
        
        primitive_trace = "Ta → Acid immunity → Chemical invincibility → φ-stability → φ";
        doctrine = "Tantalum contra omnia acida. Inviolabilis. (Tantalum against all acids. Inviolable.)";
    };
    
    // Osmium — Absolute density champion
    public let OSMIUM : Element = {
        symbol = "Os";
        name = "Osmium";
        atomic_number = 76;
        atomic_mass = 190.23;
        category = #Noble;
        
        primary = {
            gibbs_formation_kJ = 0.0;
            enthalpy_formation_kJ = 0.0;
            entropy_J_mol_K = 32.6;
            melting_point_K = 3306.0;
            boiling_point_K = 5285.0;
            density_kg_m3 = 22590.0;  // DENSEST ELEMENT
            electronegativity = 2.20;
            thermal_conductivity_W_mK = 87.6;
            electrical_resistivity_ohm_m = 8.12e-8;
            reduction_potential_V = 0.85;
            formula_explanation = "ρ = 22590 kg/m³ — THE DENSEST ELEMENT IN EXISTENCE";
        };
        
        secondary = {
            youngs_modulus_GPa = 559.0;  // Highest of ALL elements
            yield_strength_MPa = 1000.0;
            ultimate_tensile_MPa = 1200.0;
            hardness_HV = 400.0;
            fatigue_limit_MPa = 400.0;
            creep_resistance_hours = 100000.0;
            fracture_toughness_MPa_sqrtm = 30.0;  // Brittle
            thermal_expansion_um_mK = 5.1;
            specific_heat_J_kgK = 130.0;
            corrosion_rate_mm_year = 0.0;  // Noble
            load_formula = "E = 559 GPa — STIFFEST ELEMENT (highest Young's modulus)";
            stress_formula = "Compressive strength nearly unlimited due to density";
        };
        
        uses = [
            { use_case = #DenseDefense; description = "DENSEST element — ultimate mass"; formula_applied = "ρ = 22590 kg/m³"; effectiveness = 1.0 },
            { use_case = #StructuralIntegrity; description = "Highest stiffness"; formula_applied = "E = 559 GPa"; effectiveness = 1.0 },
            { use_case = #ThermalResistance; description = "Very high melt"; formula_applied = "T_melt = 3306K"; effectiveness = 0.95 },
            { use_case = #CorrosionImmunity; description = "Noble platinum-group"; formula_applied = "ΔG_ox > 0"; effectiveness = 0.90 },
            { use_case = #RadiationShielding; description = "Maximum stopping power"; formula_applied = "Highest Z×ρ"; effectiveness = 0.98 },
            { use_case = #Catalysis; description = "Asymmetric catalysis"; formula_applied = "OsO₄ reactions"; effectiveness = 0.85 },
            { use_case = #Protection; description = "Fountain pen tips"; formula_applied = "Wear resistance"; effectiveness = 0.92 }
        ];
        
        placements = [#Core, #Defense, #Shield];
        
        primitive_trace = "Os → Maximum density → Ultimate mass → φ-gravitational anchor → φ";
        doctrine = "Osmium densissimum. Gravitas ultima. (Osmium most dense. Ultimate gravity.)";
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // ALLOYS — COMBINED ELEMENTAL POWERS
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public type Alloy = {
        name: Text;
        components: [(Text, Float)];  // (Symbol, percentage)
        properties: [Text];
        uses: [ElementUse];
        doctrine: Text;
    };
    
    public let STRATEGIC_ALLOYS : [Alloy] = [
        {
            name = "Ti-6Al-4V";
            components = [("Ti", 90.0), ("Al", 6.0), ("V", 4.0)];
            properties = ["Highest strength-to-weight", "Excellent fatigue", "Biocompatible"];
            uses = [
                { use_case = #StructuralIntegrity; description = "Aerospace grade strength"; formula_applied = "σ_y = 1100 MPa"; effectiveness = 0.98 }
            ];
            doctrine = "Titanium alloy supremum. Levis et fortis. (Supreme titanium alloy. Light and strong.)";
        },
        {
            name = "Inconel 718";
            components = [("Ni", 53.0), ("Cr", 19.0), ("Fe", 18.0), ("Nb", 5.0), ("Mo", 3.0)];
            properties = ["Extreme temp strength", "Oxidation resistant", "Creep resistant"];
            uses = [
                { use_case = #ThermalResistance; description = "Jet engine grade"; formula_applied = "σ_hot = 1200 MPa at 650°C"; effectiveness = 0.98 }
            ];
            doctrine = "Inconel in igne stat. Fortitudo in calore. (Inconel stands in fire. Strength in heat.)";
        },
        {
            name = "Hastelloy C-276";
            components = [("Ni", 57.0), ("Mo", 16.0), ("Cr", 16.0), ("Fe", 5.0), ("W", 4.0)];
            properties = ["Ultimate corrosion resistance", "Pitting immune", "Acid resistant"];
            uses = [
                { use_case = #CorrosionImmunity; description = "Chemical processing"; formula_applied = "Zero attack in HCl"; effectiveness = 1.0 }
            ];
            doctrine = "Hastelloy inviolabilis. Corrosio impossibilis. (Hastelloy inviolable. Corrosion impossible.)";
        },
        {
            name = "Nitinol (Ni-Ti)";
            components = [("Ni", 55.0), ("Ti", 45.0)];
            properties = ["Shape memory", "Superelastic", "Biocompatible"];
            uses = [
                { use_case = #MemoryAlloy; description = "Remembers original shape"; formula_applied = "Martensitic transform"; effectiveness = 0.98 }
            ];
            doctrine = "Nitinol memorat. Forma redit. (Nitinol remembers. Form returns.)";
        },
        {
            name = "Stellite";
            components = [("Co", 50.0), ("Cr", 30.0), ("W", 15.0), ("C", 2.5)];
            properties = ["Extreme wear resistance", "High temp hardness", "Corrosion resistant"];
            uses = [
                { use_case = #LoadBearing; description = "Valve seats, cutting tools"; formula_applied = "HV = 600+ at 800°C"; effectiveness = 0.95 }
            ];
            doctrine = "Stellite non ateritur. Aeterna durities. (Stellite does not wear. Eternal hardness.)";
        }
    ];

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // PLACEMENT FUNCTIONS — WHERE ELEMENTS GO IN THE ARCHITECTURE
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    /// Get elements for a specific placement
    public func getElementsForPlacement(placement: ArchitecturePlacement) : [Element] {
        let all = [GOLD, TITANIUM, TUNGSTEN, IRIDIUM, SILVER, COPPER, PLATINUM, NIOBIUM, TANTALUM, OSMIUM];
        
        Array.filter<Element>(all, func(e: Element) : Bool {
            Array.find<ArchitecturePlacement>(e.placements, func(p: ArchitecturePlacement) : Bool {
                p == placement
            }) != null
        })
    };
    
    /// Get protection elements for endpoints
    public func getEndpointProtection() : [Element] {
        getElementsForPlacement(#Endpoint)
    };
    
    /// Get defense elements for core
    public func getCoreDefense() : [Element] {
        getElementsForPlacement(#Core)
    };
    
    /// Get conductor elements
    public func getConductors() : [Element] {
        getElementsForPlacement(#Conductor)
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // FORMULA APPLICATION — USE FORMULAS FOR CALCULATIONS
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    /// Calculate oxidation resistance (primary formula application)
    public func calculateOxidationResistance(element: Element) : Float {
        // ΔG > 0 means thermodynamically impossible to oxidize
        let gibbs = element.primary.gibbs_formation_kJ;
        if (gibbs >= 0.0) {
            1.0  // Perfect resistance (noble metals)
        } else {
            // Passivating metals still have good resistance
            Float.min(1.0, Float.abs(gibbs) / 2000.0)
        }
    };
    
    /// Calculate load capacity (secondary formula application)
    public func calculateLoadCapacity(element: Element, area_m2: Float) : Float {
        // F = σ_y × A (force = yield strength × area)
        element.secondary.yield_strength_MPa * 1000000.0 * area_m2
    };
    
    /// Calculate thermal survival temperature
    public func calculateThermalSurvival(element: Element) : Float {
        // Can survive up to melting point
        element.primary.melting_point_K
    };
    
    /// Calculate conductivity efficiency
    public func calculateConductivity(element: Element) : Float {
        // Lower resistivity = higher conductivity
        // Silver = 1.59e-8, so normalize to that
        let silver_resistivity = 1.59e-8;
        silver_resistivity / element.primary.electrical_resistivity_ohm_m
    };
    
    /// Calculate density-based defense rating
    public func calculateDenseDefense(element: Element) : Float {
        // Normalized to osmium (densest)
        element.primary.density_kg_m3 / 22590.0
    };

    // ═══════════════════════════════════════════════════════════════════════════════════════════
    // COMPLETE ELEMENT REGISTRY — ALL ELEMENTS AVAILABLE
    // ═══════════════════════════════════════════════════════════════════════════════════════════
    
    public let ALL_ELEMENTS : [Element] = [
        GOLD, TITANIUM, TUNGSTEN, IRIDIUM, SILVER, COPPER, PLATINUM, NIOBIUM, TANTALUM, OSMIUM
    ];
    
    public func getElement(symbol: Text) : ?Element {
        Array.find<Element>(ALL_ELEMENTS, func(e: Element) : Bool {
            e.symbol == symbol
        })
    };
    
    public func getAlphaModel(id: Nat) : ?AlphaModel {
        Array.find<AlphaModel>(ALPHA_MODELS, func(m: AlphaModel) : Bool {
            m.id == id
        })
    };
}
