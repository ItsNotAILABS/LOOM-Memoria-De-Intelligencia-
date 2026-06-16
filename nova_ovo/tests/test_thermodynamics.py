"""
Thermodynamics Substrate Tests — Elemental Protection Validation
=================================================================
Tests for the Thermodynamics Substrate Division with all metals,
formulas, and uses.
"""

import math
import unittest
from nova_ovo.agents.thermodynamics import (
    # Constants
    PHI,
    BOLTZMANN,
    PLANCK,
    
    # Enums
    ElementCategory,
    ElementUseCase,
    ArchitecturePlacement,
    
    # Data classes
    PrimaryFormula,
    SecondaryFormula,
    ElementUse,
    Element,
    AlphaModel,
    
    # Elements
    GOLD,
    TITANIUM,
    TUNGSTEN,
    IRIDIUM,
    SILVER,
    COPPER,
    PLATINUM,
    ALL_ELEMENTS,
    ALPHA_MODELS,
    
    # Functions
    get_element,
    get_elements_for_placement,
    get_elements_for_use_case,
    get_alpha_model,
    
    # Substrate
    ThermodynamicsSubstrate,
    get_thermodynamics_substrate,
)


class TestConstants(unittest.TestCase):
    """Test thermodynamic constants."""
    
    def test_phi_is_golden_ratio(self):
        """Test PHI is the golden ratio."""
        expected = (1 + math.sqrt(5)) / 2
        self.assertAlmostEqual(PHI, expected, places=10)
    
    def test_boltzmann_constant(self):
        """Test Boltzmann constant value."""
        self.assertAlmostEqual(BOLTZMANN, 1.380649e-23, places=28)
    
    def test_planck_constant(self):
        """Test Planck constant value."""
        self.assertAlmostEqual(PLANCK, 6.62607015e-34, places=42)


class TestPrimaryFormula(unittest.TestCase):
    """Test PrimaryFormula functionality."""
    
    def test_noble_metal_cannot_oxidize(self):
        """Test noble metals cannot oxidize (ΔG >= 0)."""
        formula = PrimaryFormula(
            gibbs_formation_kJ=0.0,  # Reference state
            enthalpy_formation_kJ=0.0,
            entropy_J_mol_K=47.4,
            melting_point_K=1337.0,
            boiling_point_K=3129.0,
            density_kg_m3=19320.0,
            electronegativity=2.54,
            thermal_conductivity_W_mK=318.0,
            electrical_resistivity_ohm_m=2.214e-8,
            reduction_potential_V=1.50,
        )
        
        self.assertFalse(formula.can_oxidize())
        self.assertEqual(formula.oxidation_resistance(), 1.0)
    
    def test_reactive_metal_can_oxidize(self):
        """Test reactive metals can oxidize (ΔG < 0)."""
        formula = PrimaryFormula(
            gibbs_formation_kJ=-889.0,  # TiO2 formation
            enthalpy_formation_kJ=-944.0,
            entropy_J_mol_K=30.7,
            melting_point_K=1941.0,
            boiling_point_K=3560.0,
            density_kg_m3=4506.0,
            electronegativity=1.54,
            thermal_conductivity_W_mK=21.9,
            electrical_resistivity_ohm_m=4.2e-7,
            reduction_potential_V=-1.63,
        )
        
        self.assertTrue(formula.can_oxidize())
        self.assertLess(formula.oxidation_resistance(), 1.0)
        self.assertGreater(formula.oxidation_resistance(), 0.0)


class TestSecondaryFormula(unittest.TestCase):
    """Test SecondaryFormula functionality."""
    
    def test_load_capacity_calculation(self):
        """Test load capacity = yield strength × area."""
        formula = SecondaryFormula(
            youngs_modulus_GPa=116.0,
            yield_strength_MPa=880.0,  # Titanium
            ultimate_tensile_MPa=950.0,
            hardness_HV=349.0,
            fatigue_limit_MPa=500.0,
            creep_resistance_hours=100000.0,
            fracture_toughness_MPa_sqrtm=75.0,
            thermal_expansion_um_mK=8.6,
            specific_heat_J_kgK=523.0,
            corrosion_rate_mm_year=0.001,
        )
        
        area = 0.001  # 1 cm²
        expected = 880.0 * 1e6 * area  # 880 kN
        self.assertAlmostEqual(formula.calculate_load_capacity(area), expected, places=0)
    
    def test_stress_calculation(self):
        """Test stress = force / area."""
        formula = SecondaryFormula(
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
        )
        
        force = 10000  # 10 kN
        area = 0.001   # 1 cm²
        expected = force / area  # 10 MPa
        self.assertAlmostEqual(formula.calculate_stress(force, area), expected, places=0)
    
    def test_yield_detection(self):
        """Test material yields when stress exceeds yield strength."""
        formula = SecondaryFormula(
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
        )
        
        # Below yield - no permanent deformation
        self.assertFalse(formula.will_yield(800e6))  # 800 MPa
        
        # Above yield - permanent deformation
        self.assertTrue(formula.will_yield(900e6))  # 900 MPa


class TestGold(unittest.TestCase):
    """Test Gold (Au) element - the supreme protector."""
    
    def test_gold_cannot_oxidize(self):
        """Test L-001: Gold cannot oxidize."""
        self.assertEqual(GOLD.primary.gibbs_formation_kJ, 0.0)
        self.assertFalse(GOLD.primary.can_oxidize())
        self.assertEqual(GOLD.oxidation_resistance(), 1.0)
    
    def test_gold_zero_corrosion(self):
        """Test gold has zero corrosion rate."""
        self.assertEqual(GOLD.secondary.corrosion_rate_mm_year, 0.0)
    
    def test_gold_has_seven_plus_uses(self):
        """Test gold has 7+ uses."""
        self.assertGreaterEqual(len(GOLD.uses), 7)
    
    def test_gold_protection_use(self):
        """Test gold has protection use case."""
        protection_uses = GOLD.get_uses_for_case(ElementUseCase.PROTECTION)
        self.assertGreater(len(protection_uses), 0)
        self.assertEqual(protection_uses[0].effectiveness, 1.0)
    
    def test_gold_endpoint_placement(self):
        """Test gold is used at endpoints."""
        self.assertTrue(GOLD.has_placement(ArchitecturePlacement.ENDPOINT))
    
    def test_gold_doctrine(self):
        """Test gold has Latin doctrine."""
        self.assertIn("Aurum", GOLD.doctrine)


class TestTitanium(unittest.TestCase):
    """Test Titanium (Ti) element - the structural guardian."""
    
    def test_titanium_high_yield_strength(self):
        """Test titanium has high yield strength."""
        self.assertGreaterEqual(TITANIUM.secondary.yield_strength_MPa, 800)
    
    def test_titanium_passivation(self):
        """Test titanium self-heals with TiO2 passivation."""
        self.assertLess(TITANIUM.secondary.corrosion_rate_mm_year, 0.01)
    
    def test_titanium_structural_integrity_use(self):
        """Test titanium has structural integrity use."""
        uses = TITANIUM.get_uses_for_case(ElementUseCase.STRUCTURAL_INTEGRITY)
        self.assertGreater(len(uses), 0)
    
    def test_titanium_core_placement(self):
        """Test titanium is used at core."""
        self.assertTrue(TITANIUM.has_placement(ArchitecturePlacement.CORE))


class TestTungsten(unittest.TestCase):
    """Test Tungsten (W) element - the thermal warrior."""
    
    def test_tungsten_highest_melting_point(self):
        """Test tungsten has highest melting point (3695K)."""
        self.assertEqual(TUNGSTEN.primary.melting_point_K, 3695.0)
        
        # Verify it's highest among our elements
        for element in ALL_ELEMENTS:
            if element.symbol != "W":
                self.assertLess(
                    element.primary.melting_point_K,
                    TUNGSTEN.primary.melting_point_K
                )
    
    def test_tungsten_thermal_resistance_use(self):
        """Test tungsten has thermal resistance use at 100% effectiveness."""
        uses = TUNGSTEN.get_uses_for_case(ElementUseCase.THERMAL_RESISTANCE)
        self.assertGreater(len(uses), 0)
        self.assertEqual(uses[0].effectiveness, 1.0)


class TestIridium(unittest.TestCase):
    """Test Iridium (Ir) element - the impenetrable core."""
    
    def test_iridium_second_densest(self):
        """Test iridium is second densest element (22650 kg/m³)."""
        self.assertEqual(IRIDIUM.primary.density_kg_m3, 22650.0)
    
    def test_iridium_dense_defense_use(self):
        """Test iridium has dense defense use at 100% effectiveness."""
        uses = IRIDIUM.get_uses_for_case(ElementUseCase.DENSE_DEFENSE)
        self.assertGreater(len(uses), 0)
        self.assertEqual(uses[0].effectiveness, 1.0)
    
    def test_iridium_defense_placement(self):
        """Test iridium is used for defense."""
        self.assertTrue(IRIDIUM.has_placement(ArchitecturePlacement.DEFENSE))


class TestSilver(unittest.TestCase):
    """Test Silver (Ag) element - the supreme conductor."""
    
    def test_silver_best_conductor(self):
        """Test silver has lowest resistivity (best conductor)."""
        self.assertEqual(SILVER.primary.electrical_resistivity_ohm_m, 1.59e-8)
        
        # Verify it's best among our elements
        for element in ALL_ELEMENTS:
            self.assertGreaterEqual(
                element.primary.electrical_resistivity_ohm_m,
                SILVER.primary.electrical_resistivity_ohm_m
            )
    
    def test_silver_conductivity_use(self):
        """Test silver has conductivity use at 100% effectiveness."""
        uses = SILVER.get_uses_for_case(ElementUseCase.CONDUCTIVITY)
        self.assertGreater(len(uses), 0)
        self.assertEqual(uses[0].effectiveness, 1.0)


class TestCopper(unittest.TestCase):
    """Test Copper (Cu) element - the universal connector."""
    
    def test_copper_good_conductor(self):
        """Test copper is a good conductor (second to silver)."""
        self.assertLess(COPPER.primary.electrical_resistivity_ohm_m, 2e-8)
    
    def test_copper_conductor_placement(self):
        """Test copper is used as conductor."""
        self.assertTrue(COPPER.has_placement(ArchitecturePlacement.CONDUCTOR))


class TestPlatinum(unittest.TestCase):
    """Test Platinum (Pt) element - the eternal catalyst."""
    
    def test_platinum_noble(self):
        """Test platinum is a noble metal (cannot oxidize)."""
        self.assertEqual(PLATINUM.primary.gibbs_formation_kJ, 0.0)
        self.assertFalse(PLATINUM.primary.can_oxidize())
    
    def test_platinum_catalysis_use(self):
        """Test platinum has catalysis use at 100% effectiveness."""
        uses = PLATINUM.get_uses_for_case(ElementUseCase.CATALYSIS)
        self.assertGreater(len(uses), 0)
        self.assertEqual(uses[0].effectiveness, 1.0)
    
    def test_platinum_catalyst_placement(self):
        """Test platinum is used as catalyst."""
        self.assertTrue(PLATINUM.has_placement(ArchitecturePlacement.CATALYST))


class TestAlphaModels(unittest.TestCase):
    """Test the 10 Alpha Models."""
    
    def test_ten_alpha_models_exist(self):
        """Test there are exactly 10 alpha models."""
        self.assertEqual(len(ALPHA_MODELS), 10)
    
    def test_model_ids_unique(self):
        """Test all model IDs are unique."""
        ids = [m.id for m in ALPHA_MODELS]
        self.assertEqual(len(ids), len(set(ids)))
    
    def test_elemental_protection_model(self):
        """Test ElementalProtection model (ID 1)."""
        model = get_alpha_model(1)
        self.assertIsNotNone(model)
        self.assertEqual(model.name, "ElementalProtection")
        self.assertIn("Au", model.elements)
    
    def test_structural_integrity_model(self):
        """Test StructuralIntegrity model (ID 2)."""
        model = get_alpha_model(2)
        self.assertIsNotNone(model)
        self.assertEqual(model.name, "StructuralIntegrity")
        self.assertIn("Ti", model.elements)
    
    def test_thermal_resistance_model(self):
        """Test ThermalResistance model (ID 3)."""
        model = get_alpha_model(3)
        self.assertIsNotNone(model)
        self.assertEqual(model.name, "ThermalResistance")
        self.assertIn("W", model.elements)
    
    def test_dense_defense_model(self):
        """Test DenseDefense model (ID 4)."""
        model = get_alpha_model(4)
        self.assertIsNotNone(model)
        self.assertEqual(model.name, "DenseDefense")
        self.assertIn("Ir", model.elements)
    
    def test_signal_conductivity_model(self):
        """Test SignalConductivity model (ID 5)."""
        model = get_alpha_model(5)
        self.assertIsNotNone(model)
        self.assertEqual(model.name, "SignalConductivity")
        self.assertIn("Ag", model.elements)
    
    def test_catalytic_acceleration_model(self):
        """Test CatalyticAcceleration model (ID 6)."""
        model = get_alpha_model(6)
        self.assertIsNotNone(model)
        self.assertEqual(model.name, "CatalyticAcceleration")
        self.assertIn("Pt", model.elements)
    
    def test_all_models_have_applications(self):
        """Test all models have applications."""
        for model in ALPHA_MODELS:
            self.assertGreater(len(model.applications), 0)


class TestElementRegistry(unittest.TestCase):
    """Test element registry functions."""
    
    def test_get_element_by_symbol(self):
        """Test getting element by symbol."""
        au = get_element("Au")
        self.assertIsNotNone(au)
        self.assertEqual(au.name, "Gold")
    
    def test_get_nonexistent_element(self):
        """Test getting nonexistent element returns None."""
        element = get_element("Xx")
        self.assertIsNone(element)
    
    def test_get_elements_for_endpoint(self):
        """Test getting elements for endpoint placement."""
        elements = get_elements_for_placement(ArchitecturePlacement.ENDPOINT)
        self.assertGreater(len(elements), 0)
        
        # Gold should be in endpoint elements
        symbols = [e.symbol for e in elements]
        self.assertIn("Au", symbols)
    
    def test_get_elements_for_protection(self):
        """Test getting elements for protection use case."""
        elements = get_elements_for_use_case(ElementUseCase.PROTECTION)
        self.assertGreater(len(elements), 0)


class TestThermodynamicsSubstrate(unittest.TestCase):
    """Test ThermodynamicsSubstrate class."""
    
    def setUp(self):
        self.substrate = get_thermodynamics_substrate()
    
    def test_substrate_has_elements(self):
        """Test substrate has elements."""
        self.assertGreater(len(self.substrate.elements), 0)
    
    def test_substrate_has_alpha_models(self):
        """Test substrate has alpha models."""
        self.assertGreater(len(self.substrate.alpha_models), 0)
    
    def test_get_endpoint_protection(self):
        """Test getting endpoint protection elements."""
        elements = self.substrate.get_endpoint_protection()
        self.assertGreater(len(elements), 0)
    
    def test_get_core_defense(self):
        """Test getting core defense elements."""
        elements = self.substrate.get_core_defense()
        self.assertGreater(len(elements), 0)
    
    def test_get_conductors(self):
        """Test getting conductor elements."""
        elements = self.substrate.get_conductors()
        self.assertGreater(len(elements), 0)
    
    def test_calculate_oxidation_resistance(self):
        """Test oxidation resistance calculation."""
        resistance = self.substrate.calculate_oxidation_resistance("Au")
        self.assertEqual(resistance, 1.0)  # Gold = perfect resistance
    
    def test_calculate_load_capacity(self):
        """Test load capacity calculation."""
        capacity = self.substrate.calculate_load_capacity("Ti", 0.001)
        self.assertGreater(capacity, 0)
    
    def test_status(self):
        """Test substrate status."""
        status = self.substrate.status()
        
        self.assertEqual(status["division"], "Thermodynamics")
        self.assertGreater(status["elements_count"], 0)
        self.assertEqual(status["alpha_models_count"], 10)
        self.assertEqual(status["primitive_root"], "φ")


class TestElementSerialization(unittest.TestCase):
    """Test element serialization."""
    
    def test_element_to_dict(self):
        """Test element serialization to dict."""
        d = GOLD.to_dict()
        
        self.assertEqual(d["symbol"], "Au")
        self.assertEqual(d["name"], "Gold")
        self.assertIn("primary", d)
        self.assertIn("secondary", d)
        self.assertIn("uses", d)
        self.assertIn("placements", d)
    
    def test_alpha_model_to_dict(self):
        """Test alpha model serialization."""
        model = ALPHA_MODELS[0]
        d = model.to_dict()
        
        self.assertIn("id", d)
        self.assertIn("name", d)
        self.assertIn("doctrine", d)
        self.assertIn("elements", d)
        self.assertIn("applications", d)


class TestPrimitiveTraces(unittest.TestCase):
    """Test L-130 compliance - all elements trace to φ."""
    
    def test_all_elements_trace_to_phi(self):
        """Test all elements have primitive trace ending in φ."""
        for element in ALL_ELEMENTS:
            self.assertIn("φ", element.primitive_trace)


if __name__ == "__main__":
    unittest.main()
