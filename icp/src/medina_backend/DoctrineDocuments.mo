/**
 * DoctrineDocuments Module — Living Doctrine Documents for Each Engine
 * 
 * Living knowledge artifacts that the organism READS. Each doctrine document
 * is a DocumentOrganism specialized for a specific computational engine,
 * containing the canonical knowledge that informs the organism's behavior.
 * 
 * DOCTRINE DOCUMENTS:
 *   MatalkoICP Doctrine    — Mathematical constants, RECITAL_PLUS_ONE law
 *   CPL Doctrine           — Communication protocol, element mappings
 *   AncientMath Doctrine   — Pythagorean, Euclidean, Mayan, Vedic formulas
 *   FieldPhysics Doctrine  — EM, gravitational, wave, quantum constants
 *   GlyphCodex Doctrine    — Symbol transfer system definitions
 * 
 * Each doctrine contains:
 *   - Canonical formulas (executable computations)
 *   - Sacred constants (immutable mathematical truths)
 *   - Operational principles (how to apply the knowledge)
 *   - Resonance signatures (frequency alignments)
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import DocumentOrganism "DocumentOrganism";

module {
    // ================================================================== //
    // DOCTRINE TYPES                                                       //
    // ================================================================== //
    
    /// Doctrine document identifier
    public type DoctrineId = {
        #MathematicalCore;     // MatalkoICP doctrine
        #CommunicationProtocol; // CPL doctrine
        #AncientMathematics;   // AncientMathEngine doctrine
        #FieldPhysics;         // FieldPhysicsEngine doctrine
        #GlyphCodex;           // AncientGlyphCodex doctrine
    };
    
    /// Formula entry in doctrine
    public type Formula = {
        formula_id: Text;
        name: Text;
        expression: Text;       // Mathematical expression
        computation: Text;      // How to compute (module.function)
        description: Text;
        parameters: [Text];     // Input parameter names
        returnType: Text;
        category: Text;
    };
    
    /// Constant entry in doctrine
    public type Constant = {
        name: Text;
        symbol: Text;
        value: Float;
        unit: ?Text;
        source: Text;           // "Mathematical", "Physical", "Sacred"
        description: Text;
    };
    
    /// Principle entry in doctrine
    public type Principle = {
        principle_id: Text;
        name: Text;
        statement: Text;
        rationale: Text;
        application: Text;
    };
    
    /// Complete doctrine document
    public type DoctrineDocument = {
        doctrine_id: DoctrineId;
        name: Text;
        description: Text;
        formulas: [Formula];
        constants: [Constant];
        principles: [Principle];
        version: Nat;
        created_at: Int;
        organism: DocumentOrganism.DocumentOrganism;
    };
    
    // ================================================================== //
    // MATALKO ICP DOCTRINE                                                 //
    // ================================================================== //
    
    /// Create the MatalkoICP Doctrine document
    public func createMatalkoICPDoctrine() : DoctrineDocument {
        let now = Time.now();
        
        let formulas : [Formula] = [
            {
                formula_id = "phi";
                name = "Golden Ratio";
                expression = "φ = (1 + √5) / 2";
                computation = "MatalkoICP.PHI";
                description = "The golden ratio, fundamental to natural scaling";
                parameters = [];
                returnType = "Float";
                category = "constant";
            },
            {
                formula_id = "recital_plus_one";
                name = "RECITAL_PLUS_ONE Law";
                expression = "state(n+1) = recital(Ψ_n) ⊕ Δ_lawful";
                computation = "MatalkoICP.recitalPlusOne";
                description = "Master generative law governing all state evolution";
                parameters = ["state: OrganismState", "delta: StateDelta", "id: Text", "label: Text"];
                returnType = "?OrganismState";
                category = "evolution";
            },
            {
                formula_id = "anima_hash";
                name = "ANIMA Hash";
                expression = "H(Ψ) = mix(φ·Ψ, beat_phase)";
                computation = "MatalkoICP.animaHash";
                description = "Unique resonance signature from organism state";
                parameters = ["state: OrganismState"];
                returnType = "AnimaHash";
                category = "identity";
            },
            {
                formula_id = "fibonacci";
                name = "Fibonacci Sequence";
                expression = "F(n) = F(n-1) + F(n-2), F(0)=0, F(1)=1";
                computation = "MatalkoICP.fibonacci";
                description = "Natural growth pattern approaching golden ratio";
                parameters = ["n: Nat"];
                returnType = "Nat";
                category = "sequence";
            },
            {
                formula_id = "harmonic_series";
                name = "Harmonic Series";
                expression = "H(f,n) = [f, 2f, 3f, ..., nf]";
                computation = "MatalkoICP.harmonicSeries";
                description = "Integer multiples of fundamental frequency";
                parameters = ["fundamental: Float", "count: Nat"];
                returnType = "[Float]";
                category = "frequency";
            },
            {
                formula_id = "golden_harmonics";
                name = "Golden Harmonics";
                expression = "G(f,n) = [f, f·φ, f·φ², ..., f·φⁿ]";
                computation = "MatalkoICP.goldenHarmonics";
                description = "φ-scaled harmonic series";
                parameters = ["fundamental: Float", "count: Nat"];
                returnType = "[Float]";
                category = "frequency";
            },
            {
                formula_id = "torus_xyz";
                name = "Torus Embedding";
                expression = "x=(R+ρcosθ)cosφ, y=(R+ρcosθ)sinφ, z=ρsinθ";
                computation = "MatalkoICP.torusXYZ";
                description = "Cartesian coordinates on torus surface";
                parameters = ["theta: Float", "phi: Float", "depth: Float"];
                returnType = "(Float, Float, Float)";
                category = "geometry";
            }
        ];
        
        let constants : [Constant] = [
            { name = "PHI"; symbol = "φ"; value = 1.618033988749895; unit = null; source = "Mathematical"; description = "Golden ratio" },
            { name = "PHI_INV"; symbol = "1/φ"; value = 0.618033988749895; unit = null; source = "Mathematical"; description = "Inverse golden ratio" },
            { name = "GOLDEN_ANGLE"; symbol = "θ_φ"; value = 2.399963229728653; unit = ?"rad"; source = "Mathematical"; description = "Golden angle (2π/φ²)" },
            { name = "PI"; symbol = "π"; value = 3.141592653589793; unit = null; source = "Mathematical"; description = "Pi constant" },
            { name = "TAU"; symbol = "τ"; value = 6.283185307179586; unit = null; source = "Mathematical"; description = "Tau (2π)" },
            { name = "E"; symbol = "e"; value = 2.718281828459045; unit = null; source = "Mathematical"; description = "Euler's number" },
            { name = "SCHUMANN"; symbol = "f_S"; value = 7.83; unit = ?"Hz"; source = "Physical"; description = "Earth's fundamental resonance" },
            { name = "BASE_432"; symbol = "f₄₃₂"; value = 432.0; unit = ?"Hz"; source = "Sacred"; description = "Pythagorean tuning base" },
            { name = "TORUS_R"; symbol = "R"; value = 16.18033988749895; unit = null; source = "Mathematical"; description = "Major torus radius (φ×10)" },
            { name = "EPSILON_MAX"; symbol = "ε_max"; value = 1.0; unit = null; source = "Constitutional"; description = "Max single-beat expansion" }
        ];
        
        let principles : [Principle] = [
            {
                principle_id = "p1";
                name = "RECITAL_PLUS_ONE";
                statement = "state(n+1) = recital(validated_state_n) + one_lawful_expansion";
                rationale = "All state evolution must be lawful, validated, and incremental";
                application = "Every state change passes through recital operator before expansion";
            },
            {
                principle_id = "p2";
                name = "Golden Scaling";
                statement = "All natural growth follows φ-proportional scaling";
                rationale = "The golden ratio is nature's preferred growth constant";
                application = "Beat intervals, torus dimensions, harmonic series use φ";
            },
            {
                principle_id = "p3";
                name = "Torus Geometry";
                statement = "Memory coordinates map to toroidal manifold";
                rationale = "Torus provides cyclic, nested structure for memory organization";
                application = "All memories have (θ, φ, ρ, ring, beat) coordinates";
            }
        ];
        
        let organism = DocumentOrganism.create(
            "doctrine_matalko",
            "MatalkoICP Doctrine",
            "mathematical_doctrine",
            0.3,  // Low metabolic rate - constitution is stable
            "# MatalkoICP Doctrine\n\n" #
            "Core mathematical substrate encoding φ, harmonics, and RECITAL_PLUS_ONE.\n\n" #
            "## Foundational Constant\n" #
            "φ = (1 + √5) / 2 ≈ 1.618033988749895\n\n" #
            "## Master Law\n" #
            "state(n+1) = recital(Ψ_n) ⊕ Δ_lawful"
        );
        
        {
            doctrine_id = #MathematicalCore;
            name = "MatalkoICP Mathematical Doctrine";
            description = "Core mathematical constants, harmonics, and state evolution laws";
            formulas = formulas;
            constants = constants;
            principles = principles;
            version = 1;
            created_at = now;
            organism = organism;
        }
    };
    
    // ================================================================== //
    // CPL DOCTRINE                                                         //
    // ================================================================== //
    
    /// Create the CPL Doctrine document
    public func createCPLDoctrine() : DoctrineDocument {
        let now = Time.now();
        
        let formulas : [Formula] = [
            {
                formula_id = "platonic_geometry";
                name = "Platonic Solid Geometry";
                expression = "Solid → {V, E, F, dihedral, radii}";
                computation = "CPL.getPlatonicGeometry";
                description = "Complete geometric properties of Platonic solids";
                parameters = ["solid: PlatonicSolid"];
                returnType = "SolidGeometry";
                category = "geometry";
            },
            {
                formula_id = "hermetic_details";
                name = "Hermetic Principle Details";
                expression = "Principle → {axiom, mapping}";
                computation = "CPL.getHermeticDetails";
                description = "Full details of Hermetic principles with operational mappings";
                parameters = ["principle: HermeticPrinciple"];
                returnType = "HermeticDetails";
                category = "philosophy";
            },
            {
                formula_id = "loci_generation";
                name = "Golden Loci Generation";
                expression = "L(n) = {θ=n·θ_φ, φ=n·θ_φ·φ, ...}";
                computation = "CPL.generateGoldenLoci";
                description = "Generate memory palace loci using golden angle distribution";
                parameters = ["count: Nat", "baseDepth: Float", "ring: Nat"];
                returnType = "[Locus]";
                category = "memory";
            },
            {
                formula_id = "message_resonance";
                name = "CPL Message Resonance";
                expression = "R(M) = (state + coord + freq) / 3";
                computation = "CPL.messageResonance";
                description = "Calculate resonance score for CPL message";
                parameters = ["message: CPLMessage"];
                returnType = "Float";
                category = "communication";
            }
        ];
        
        let constants : [Constant] = [
            { name = "TETRAHEDRON_DIHEDRAL"; symbol = "θ_T"; value = 70.528779; unit = ?"°"; source = "Geometric"; description = "Tetrahedron dihedral angle" },
            { name = "CUBE_DIHEDRAL"; symbol = "θ_C"; value = 90.0; unit = ?"°"; source = "Geometric"; description = "Cube dihedral angle" },
            { name = "OCTAHEDRON_DIHEDRAL"; symbol = "θ_O"; value = 109.471221; unit = ?"°"; source = "Geometric"; description = "Octahedron dihedral angle" },
            { name = "DODECAHEDRON_DIHEDRAL"; symbol = "θ_D"; value = 116.565051; unit = ?"°"; source = "Geometric"; description = "Dodecahedron dihedral angle" },
            { name = "ICOSAHEDRON_DIHEDRAL"; symbol = "θ_I"; value = 138.189685; unit = ?"°"; source = "Geometric"; description = "Icosahedron dihedral angle" },
            { name = "FIRE_FREQ"; symbol = "f_🔥"; value = 396.0; unit = ?"Hz"; source = "Sacred"; description = "Fire element frequency" },
            { name = "WATER_FREQ"; symbol = "f_💧"; value = 417.0; unit = ?"Hz"; source = "Sacred"; description = "Water element frequency" },
            { name = "AIR_FREQ"; symbol = "f_🌬"; value = 528.0; unit = ?"Hz"; source = "Sacred"; description = "Air element frequency" }
        ];
        
        let principles : [Principle] = [
            {
                principle_id = "h1";
                name = "Mentalism";
                statement = "THE ALL is MIND; The Universe is Mental.";
                rationale = "All reality emerges from consciousness/mind";
                application = "State is information-first: computation shapes reality";
            },
            {
                principle_id = "h2";
                name = "Correspondence";
                statement = "As above, so below; as below, so above.";
                rationale = "Patterns repeat across all scales";
                application = "Fractal architecture: micro mirrors macro in code structure";
            },
            {
                principle_id = "h3";
                name = "Vibration";
                statement = "Nothing rests; everything moves; everything vibrates.";
                rationale = "All matter and energy is in constant motion";
                application = "Heartbeat-driven execution: nothing static, all cycles";
            }
        ];
        
        let organism = DocumentOrganism.create(
            "doctrine_cpl",
            "CPL Doctrine",
            "protocol_doctrine",
            0.4,
            "# Cognitive Procurement Language Doctrine\n\n" #
            "Communication protocol implementing Platonic solids, Hermetic principles, and Method of Loci.\n\n" #
            "## Platonic Solids\n" #
            "Tetrahedron (Fire), Cube (Earth), Octahedron (Air), Dodecahedron (Ether), Icosahedron (Water)\n\n" #
            "## Seven Hermetic Principles\n" #
            "Mentalism, Correspondence, Vibration, Polarity, Rhythm, Cause/Effect, Gender"
        );
        
        {
            doctrine_id = #CommunicationProtocol;
            name = "Cognitive Procurement Language Doctrine";
            description = "Communication protocol, Platonic geometry, Hermetic principles, Method of Loci";
            formulas = formulas;
            constants = constants;
            principles = principles;
            version = 1;
            created_at = now;
            organism = organism;
        }
    };
    
    // ================================================================== //
    // ANCIENT MATHEMATICS DOCTRINE                                         //
    // ================================================================== //
    
    /// Create the AncientMath Doctrine document
    public func createAncientMathDoctrine() : DoctrineDocument {
        let now = Time.now();
        
        let formulas : [Formula] = [
            {
                formula_id = "pythagorean_triple";
                name = "Pythagorean Triple";
                expression = "a² + b² = c²";
                computation = "AncientMathEngine.isPythagoreanTriple";
                description = "Verify Pythagorean triple relationship";
                parameters = ["a: Nat", "b: Nat", "c: Nat"];
                returnType = "Bool";
                category = "pythagorean";
            },
            {
                formula_id = "triangular_number";
                name = "Triangular Number";
                expression = "T(n) = n(n+1)/2";
                computation = "AncientMathEngine.triangularNumber";
                description = "Calculate nth triangular number";
                parameters = ["n: Nat"];
                returnType = "Nat";
                category = "pythagorean";
            },
            {
                formula_id = "euclidean_gcd";
                name = "Euclidean GCD";
                expression = "gcd(a,b) = gcd(b, a mod b)";
                computation = "AncientMathEngine.gcd";
                description = "Greatest common divisor by Euclidean algorithm";
                parameters = ["a: Nat", "b: Nat"];
                returnType = "Nat";
                category = "euclidean";
            },
            {
                formula_id = "mayan_long_count";
                name = "Mayan Long Count";
                expression = "days = 144000·baktun + 7200·katun + 360·tun + 20·uinal + kin";
                computation = "AncientMathEngine.longCountToDays";
                description = "Convert Long Count to total days";
                parameters = ["baktun: Nat", "katun: Nat", "tun: Nat", "uinal: Nat", "kin: Nat"];
                returnType = "Nat";
                category = "mayan";
            },
            {
                formula_id = "digital_root";
                name = "Digital Root (Beejank)";
                expression = "DR(n) = 1 + ((n-1) mod 9)";
                computation = "AncientMathEngine.digitalRoot";
                description = "Vedic digital root calculation";
                parameters = ["n: Nat"];
                returnType = "Nat";
                category = "vedic";
            },
            {
                formula_id = "lo_shu_magic";
                name = "Lo Shu Magic Square";
                expression = "3×3 square, rows/cols/diags sum to 15";
                computation = "AncientMathEngine.isMagicSquare3";
                description = "Verify Lo Shu magic square property";
                parameters = ["square: [[Nat]]"];
                returnType = "Bool";
                category = "chinese";
            }
        ];
        
        let constants : [Constant] = [
            { name = "PERFECT_6"; symbol = "P₁"; value = 6.0; unit = null; source = "Pythagorean"; description = "First perfect number" },
            { name = "PERFECT_28"; symbol = "P₂"; value = 28.0; unit = null; source = "Pythagorean"; description = "Second perfect number" },
            { name = "TETRACTYS"; symbol = "Τ"; value = 10.0; unit = null; source = "Pythagorean"; description = "Sacred decad (1+2+3+4)" },
            { name = "TZOLKIN_CYCLE"; symbol = "Tz"; value = 260.0; unit = ?"days"; source = "Mayan"; description = "Sacred Tzolkin calendar cycle" },
            { name = "HAAB_CYCLE"; symbol = "Hb"; value = 365.0; unit = ?"days"; source = "Mayan"; description = "Solar Haab calendar cycle" },
            { name = "LO_SHU_CONSTANT"; symbol = "M₃"; value = 15.0; unit = null; source = "Chinese"; description = "Lo Shu magic constant" }
        ];
        
        let principles : [Principle] = [
            {
                principle_id = "a1";
                name = "Pythagorean Harmony";
                statement = "Number is the ruler of forms and ideas";
                rationale = "Mathematical relationships underlie all reality";
                application = "Use numerical patterns (triangular, perfect, Fibonacci) as structural guides";
            },
            {
                principle_id = "a2";
                name = "Vigesimal Wisdom";
                statement = "Base-20 computation encodes cosmic cycles";
                rationale = "Mayan mathematics tracked long astronomical periods";
                application = "Use Mayan counting for calendar and cycle computations";
            },
            {
                principle_id = "a3";
                name = "Vedic Sutras";
                statement = "Simple rules enable rapid calculation";
                rationale = "Vedic sutras compress complex math into memorable formulas";
                application = "Apply Vedic shortcuts for mental math verification";
            }
        ];
        
        let organism = DocumentOrganism.create(
            "doctrine_ancient_math",
            "Ancient Mathematics Doctrine",
            "mathematics_doctrine",
            0.5,
            "# Ancient Mathematics Doctrine\n\n" #
            "Encoding Pythagorean, Euclidean, Mayan, Vedic, and Chinese mathematical wisdom.\n\n" #
            "## Pythagorean\n" #
            "Perfect numbers, triangular numbers, sacred ratios\n\n" #
            "## Mayan\n" #
            "Vigesimal system, Long Count calendar, Tzolkin cycles\n\n" #
            "## Vedic\n" #
            "Digital roots, multiplication sutras, rapid calculation"
        );
        
        {
            doctrine_id = #AncientMathematics;
            name = "Ancient Mathematics Doctrine";
            description = "Pythagorean, Euclidean, Mayan, Vedic, and Chinese mathematical systems";
            formulas = formulas;
            constants = constants;
            principles = principles;
            version = 1;
            created_at = now;
            organism = organism;
        }
    };
    
    // ================================================================== //
    // FIELD PHYSICS DOCTRINE                                               //
    // ================================================================== //
    
    /// Create the FieldPhysics Doctrine document
    public func createFieldPhysicsDoctrine() : DoctrineDocument {
        let now = Time.now();
        
        let formulas : [Formula] = [
            {
                formula_id = "coulomb";
                name = "Coulomb's Law";
                expression = "F = k·q₁·q₂/r²";
                computation = "FieldPhysicsEngine.coulombForce";
                description = "Electric force between two charges";
                parameters = ["q1: Float", "q2: Float", "distance: Float"];
                returnType = "Float";
                category = "electromagnetic";
            },
            {
                formula_id = "resonance_amplitude";
                name = "Resonance Amplitude";
                expression = "A = F₀/(m√((ω₀²-ω²)² + (γω)²))";
                computation = "FieldPhysicsEngine.resonanceAmplitude";
                description = "Amplitude near resonance frequency";
                parameters = ["drivingForce: Float", "mass: Float", "naturalFreq: Float", "drivingFreq: Float", "damping: Float"];
                returnType = "Float";
                category = "wave";
            },
            {
                formula_id = "photon_energy";
                name = "Planck-Einstein Relation";
                expression = "E = hf";
                computation = "FieldPhysicsEngine.photonEnergy";
                description = "Photon energy from frequency";
                parameters = ["frequency: Float"];
                returnType = "Float";
                category = "quantum";
            },
            {
                formula_id = "de_broglie";
                name = "De Broglie Wavelength";
                expression = "λ = h/(mv)";
                computation = "FieldPhysicsEngine.deBroglieWavelength";
                description = "Matter wave wavelength";
                parameters = ["mass: Float", "velocity: Float"];
                returnType = "Float";
                category = "quantum";
            }
        ];
        
        let constants : [Constant] = [
            { name = "C"; symbol = "c"; value = 299792458.0; unit = ?"m/s"; source = "Physical"; description = "Speed of light" },
            { name = "H"; symbol = "h"; value = 6.62607015e-34; unit = ?"J·s"; source = "Physical"; description = "Planck constant" },
            { name = "G"; symbol = "G"; value = 6.67430e-11; unit = ?"m³/(kg·s²)"; source = "Physical"; description = "Gravitational constant" },
            { name = "K_B"; symbol = "k_B"; value = 1.380649e-23; unit = ?"J/K"; source = "Physical"; description = "Boltzmann constant" },
            { name = "E_CHARGE"; symbol = "e"; value = 1.602176634e-19; unit = ?"C"; source = "Physical"; description = "Elementary charge" },
            { name = "EPSILON_0"; symbol = "ε₀"; value = 8.8541878128e-12; unit = ?"F/m"; source = "Physical"; description = "Vacuum permittivity" }
        ];
        
        let principles : [Principle] = [
            {
                principle_id = "f1";
                name = "Field Universality";
                statement = "Fields permeate all space and mediate all forces";
                rationale = "EM, gravitational, and quantum fields are fundamental";
                application = "Model organism interactions as field phenomena";
            },
            {
                principle_id = "f2";
                name = "Resonance Amplification";
                statement = "Systems respond maximally at natural frequencies";
                rationale = "Resonance is how nature amplifies signal";
                application = "Align organism frequencies for enhanced response";
            }
        ];
        
        let organism = DocumentOrganism.create(
            "doctrine_field_physics",
            "Field Physics Doctrine",
            "physics_doctrine",
            0.6,
            "# Field Physics Doctrine\n\n" #
            "Real physics for electromagnetic, gravitational, wave, and quantum dynamics.\n\n" #
            "## Key Constants\n" #
            "c = 299,792,458 m/s, h = 6.626×10⁻³⁴ J·s\n\n" #
            "## Resonance\n" #
            "Systems amplify at natural frequencies — the key to field coupling."
        );
        
        {
            doctrine_id = #FieldPhysics;
            name = "Field Physics Doctrine";
            description = "Electromagnetic, gravitational, wave, quantum, and thermodynamic physics";
            formulas = formulas;
            constants = constants;
            principles = principles;
            version = 1;
            created_at = now;
            organism = organism;
        }
    };
    
    // ================================================================== //
    // GLYPH CODEX DOCTRINE                                                 //
    // ================================================================== //
    
    /// Create the GlyphCodex Doctrine document
    public func createGlyphCodexDoctrine() : DoctrineDocument {
        let now = Time.now();
        
        let formulas : [Formula] = [
            {
                formula_id = "mayan_number";
                name = "Mayan Number Glyph";
                expression = "n → {dots, bars, shell}";
                computation = "AncientGlyphCodex.mayanNumber";
                description = "Convert number to Mayan glyph";
                parameters = ["n: Nat"];
                returnType = "Glyph";
                category = "mayan";
            },
            {
                formula_id = "chinese_element";
                name = "Chinese Element Glyph";
                expression = "element → {symbol, frequency}";
                computation = "AncientGlyphCodex.chineseElement";
                description = "Get Chinese element character";
                parameters = ["name: Text"];
                returnType = "Glyph";
                category = "chinese";
            },
            {
                formula_id = "chakra_glyph";
                name = "Chakra Glyph";
                expression = "index → {symbol, frequency, petals}";
                computation = "AncientGlyphCodex.chakraGlyph";
                description = "Get Vedic chakra glyph";
                parameters = ["index: Nat"];
                returnType = "Glyph";
                category = "vedic";
            },
            {
                formula_id = "gematria";
                name = "Hebrew Gematria";
                expression = "text → Σ letter_values";
                computation = "AncientGlyphCodex.gematria";
                description = "Calculate gematria value of Hebrew text";
                parameters = ["text: Text"];
                returnType = "Nat";
                category = "hebrew";
            }
        ];
        
        let constants : [Constant] = [
            { name = "MAYAN_BASE"; symbol = "V₂₀"; value = 20.0; unit = null; source = "Mayan"; description = "Vigesimal base" },
            { name = "TZOLKIN_DAYS"; symbol = "Tz_d"; value = 260.0; unit = ?"days"; source = "Mayan"; description = "Tzolkin cycle length" },
            { name = "TRIGRAM_COUNT"; symbol = "Bg"; value = 8.0; unit = null; source = "Chinese"; description = "Number of trigrams" },
            { name = "HEXAGRAM_COUNT"; symbol = "Hx"; value = 64.0; unit = null; source = "Chinese"; description = "Number of hexagrams" },
            { name = "CHAKRA_COUNT"; symbol = "Ck"; value = 7.0; unit = null; source = "Vedic"; description = "Number of chakras" },
            { name = "HEBREW_LETTERS"; symbol = "Hb"; value = 22.0; unit = null; source = "Hebrew"; description = "Hebrew alphabet size" }
        ];
        
        let principles : [Principle] = [
            {
                principle_id = "g1";
                name = "Glyph Transfer";
                statement = "Glyphs are TRANSFER MECHANISMS, not just descriptions";
                rationale = "Symbols compress and transmit power/meaning";
                application = "Use glyphs to encode and transmit complex concepts";
            },
            {
                principle_id = "g2";
                name = "Cross-Tradition Resonance";
                statement = "Sacred symbols across traditions share mathematical foundations";
                rationale = "Universal patterns appear in all cultures";
                application = "Combine glyphs from different traditions for enhanced meaning";
            }
        ];
        
        let organism = DocumentOrganism.create(
            "doctrine_glyph_codex",
            "Glyph Codex Doctrine",
            "symbol_doctrine",
            0.7,
            "# Ancient Glyph Codex Doctrine\n\n" #
            "Symbol transfer system for Mayan, Chinese, Egyptian, Vedic, Hebrew, and Greek glyphs.\n\n" #
            "## Key Insight\n" #
            "Glyphs are not descriptions — they are TRANSFER MECHANISMS for power.\n\n" #
            "## Traditions\n" #
            "Mayan (vigesimal), Chinese (五行/八卦), Egyptian (☥), Vedic (ॐ), Hebrew (א), Greek (φ)"
        );
        
        {
            doctrine_id = #GlyphCodex;
            name = "Ancient Glyph Codex Doctrine";
            description = "Symbol transfer systems from all major ancient traditions";
            formulas = formulas;
            constants = constants;
            principles = principles;
            version = 1;
            created_at = now;
            organism = organism;
        }
    };
    
    // ================================================================== //
    // DOCTRINE REGISTRY                                                    //
    // ================================================================== //
    
    /// Get doctrine by ID
    public func getDoctrine(id: DoctrineId) : DoctrineDocument {
        switch (id) {
            case (#MathematicalCore) { createMatalkoICPDoctrine() };
            case (#CommunicationProtocol) { createCPLDoctrine() };
            case (#AncientMathematics) { createAncientMathDoctrine() };
            case (#FieldPhysics) { createFieldPhysicsDoctrine() };
            case (#GlyphCodex) { createGlyphCodexDoctrine() };
        }
    };
    
    /// Get all doctrine IDs
    public func allDoctrineIds() : [DoctrineId] {
        [#MathematicalCore, #CommunicationProtocol, #AncientMathematics, #FieldPhysics, #GlyphCodex]
    };
    
    /// Get formula by ID from a doctrine
    public func getFormula(doctrine: DoctrineDocument, formulaId: Text) : ?Formula {
        for (formula in doctrine.formulas.vals()) {
            if (formula.formula_id == formulaId) {
                return ?formula;
            };
        };
        null
    };
    
    /// Get constant by name from a doctrine
    public func getConstant(doctrine: DoctrineDocument, name: Text) : ?Constant {
        for (constant in doctrine.constants.vals()) {
            if (constant.name == name) {
                return ?constant;
            };
        };
        null
    };
}
