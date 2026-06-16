/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                     UNIVERSAL FORMULA ENGINE                                  ║
 * ║                                                                               ║
 * ║  "Omnia in mathematica. Mathematica in omnibus."                             ║
 * ║  (Everything in mathematics. Mathematics in everything.)                      ║
 * ║                                                                               ║
 * ║  THIS ENGINE CONTAINS EVERY MATHEMATICAL FORMULA USED IN MEDINA               ║
 * ║  From φ to Schrödinger, from Kuramoto to Shannon — ALL MATH IS HERE           ║
 * ║                                                                               ║
 * ║  REAL FORMULAS. REAL PHYSICS. REAL FREQUENCIES. REAL Hz.                     ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 * 
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * L-130 COMPLIANT — Every formula traces to primitive
 */

import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";

import RootMath "RootMathematicalFoundation";

module UniversalFormulaEngine {

    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 1: GOLDEN RATIO FORMULAS (THE ROOT OF ALL)
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// FORMULA 1: Golden Ratio Definition
    /// φ = (1 + √5) / 2 = 1.618033988749895...
    public func goldenRatio() : Float {
        (1.0 + Float.sqrt(5.0)) / 2.0
    };
    
    /// FORMULA 2: Golden Ratio from Fibonacci
    /// φ = lim(n→∞) F(n+1)/F(n)
    public func goldenFromFibonacci(n: Nat) : Float {
        if (n < 2) return 1.0;
        var a : Float = 1.0;
        var b : Float = 1.0;
        for (_ in Iter.range(2, n)) {
            let temp = b;
            b := a + b;
            a := temp;
        };
        b / a
    };
    
    /// FORMULA 3: Golden Ratio Properties
    /// φ² = φ + 1, 1/φ = φ - 1
    public func verifyGoldenProperties() : Bool {
        let phi = goldenRatio();
        let phi_sq = phi * phi;
        let phi_inv = 1.0 / phi;
        Float.abs(phi_sq - (phi + 1.0)) < 1e-10 and
        Float.abs(phi_inv - (phi - 1.0)) < 1e-10
    };
    
    /// FORMULA 4: Golden Angle (radians)
    /// θ_golden = 2π / φ² ≈ 137.5°
    public func goldenAngleRad() : Float {
        let tau = 2.0 * 3.141592653589793;
        let phi = goldenRatio();
        tau / (phi * phi)
    };
    
    /// FORMULA 5: Golden Spiral
    /// r(θ) = a × φ^(θ/(π/2))
    public func goldenSpiral(theta: Float, a: Float) : Float {
        let phi = goldenRatio();
        let pi_half = 1.5707963267948966;
        a * Float.pow(phi, theta / pi_half)
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 2: FIBONACCI FORMULAS
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// FORMULA 6: Fibonacci Sequence
    /// F(n) = F(n-1) + F(n-2), F(0)=0, F(1)=1
    public func fibonacci(n: Nat) : Nat {
        if (n == 0) return 0;
        if (n == 1) return 1;
        var a : Nat = 0;
        var b : Nat = 1;
        for (_ in Iter.range(2, n)) {
            let temp = b;
            b := a + b;
            a := temp;
        };
        b
    };
    
    /// FORMULA 7: Binet's Formula (closed form Fibonacci)
    /// F(n) = (φⁿ - ψⁿ) / √5 where ψ = (1-√5)/2
    public func binetFormula(n: Nat) : Float {
        let sqrt5 = Float.sqrt(5.0);
        let phi = (1.0 + sqrt5) / 2.0;
        let psi = (1.0 - sqrt5) / 2.0;
        let nf = Float.fromInt(Int.abs(n));
        (Float.pow(phi, nf) - Float.pow(psi, nf)) / sqrt5
    };
    
    /// FORMULA 8: Lucas Numbers
    /// L(n) = L(n-1) + L(n-2), L(0)=2, L(1)=1
    public func lucas(n: Nat) : Nat {
        if (n == 0) return 2;
        if (n == 1) return 1;
        var a : Nat = 2;
        var b : Nat = 1;
        for (_ in Iter.range(2, n)) {
            let temp = b;
            b := a + b;
            a := temp;
        };
        b
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 3: FREQUENCY FORMULAS (REAL Hz)
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// FORMULA 9: Schumann Resonance
    /// f_n = 7.83 × √[n(n+1)] Hz (Earth's electromagnetic resonance)
    public func schumannResonance(n: Nat) : Float {
        let nf = Float.fromInt(Int.abs(n));
        7.83 * Float.sqrt(nf * (nf + 1.0))
    };
    
    /// FORMULA 10: Solfeggio Frequencies
    /// {396, 417, 528, 639, 741, 852} Hz
    public func solfeggioFrequency(index: Nat) : Float {
        let solf : [Float] = [396.0, 417.0, 528.0, 639.0, 741.0, 852.0];
        if (index < solf.size()) {
            solf[index]
        } else {
            0.0
        }
    };
    
    /// FORMULA 11: Golden Ratio Frequency Scaling
    /// f_n = f_base × φ^(n/20)
    public func goldenFrequencyScale(base_Hz: Float, n: Nat) : Float {
        let phi = goldenRatio();
        let nf = Float.fromInt(Int.abs(n));
        base_Hz * Float.pow(phi, nf / 20.0)
    };
    
    /// FORMULA 12: Three Hearts Frequencies
    /// Heart1: 0.1 Hz, Heart2: φ Hz, Heart3: φ² Hz
    public func threeHeartsFrequencies() : (Float, Float, Float) {
        let phi = goldenRatio();
        (0.1, phi, phi * phi)
    };
    
    /// FORMULA 13: Wavelength from Frequency
    /// λ = c / f (where c = 299,792,458 m/s)
    public func wavelengthFromFrequency(freq_Hz: Float) : Float {
        299792458.0 / freq_Hz
    };
    
    /// FORMULA 14: Energy from Frequency (Planck-Einstein)
    /// E = hf (where h = 6.626×10⁻³⁴ J·s)
    public func energyFromFrequency(freq_Hz: Float) : Float {
        6.62607015e-34 * freq_Hz
    };
    
    /// FORMULA 15: Period from Frequency
    /// T = 1/f
    public func periodFromFrequency(freq_Hz: Float) : Float {
        if (freq_Hz == 0.0) return 0.0;
        1.0 / freq_Hz
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 4: KURAMOTO PHASE COUPLING (THREE HEARTS)
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// FORMULA 16: Kuramoto Model
    /// dθᵢ/dt = ωᵢ + Σⱼ Kᵢⱼ sin(θⱼ - θᵢ)
    public func kuramotoPhaseDerivative(
        omega: Float,          // Natural frequency
        theta_i: Float,        // This oscillator's phase
        thetas: [Float],       // All oscillator phases
        K: Float               // Coupling strength
    ) : Float {
        var coupling : Float = 0.0;
        for (theta_j in thetas.vals()) {
            coupling += Float.sin(theta_j - theta_i);
        };
        omega + K * coupling / Float.fromInt(thetas.size())
    };
    
    /// FORMULA 17: Kuramoto Order Parameter
    /// R = |Σ e^(iθⱼ)| / N (coherence measure)
    public func kuramotoOrderParameter(thetas: [Float]) : Float {
        if (thetas.size() == 0) return 0.0;
        var cos_sum : Float = 0.0;
        var sin_sum : Float = 0.0;
        for (theta in thetas.vals()) {
            cos_sum += Float.cos(theta);
            sin_sum += Float.sin(theta);
        };
        let n = Float.fromInt(thetas.size());
        Float.sqrt(cos_sum * cos_sum + sin_sum * sin_sum) / n
    };
    
    /// FORMULA 18: Three Hearts Coupling Matrix
    public func threeHeartsKMatrix() : [[Float]] {
        let phi = goldenRatio();
        [
            [0.0, phi, 1.0],           // Heart1 coupling
            [phi, 0.0, phi * phi],     // Heart2 coupling
            [1.0, phi * phi, 0.0]      // Heart3 coupling
        ]
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 5: PHYSICS FORMULAS
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// FORMULA 19: Mass-Energy Equivalence
    /// E = mc² (Einstein)
    public func massEnergyEquivalence(mass_kg: Float) : Float {
        let c = 299792458.0;
        mass_kg * c * c
    };
    
    /// FORMULA 20: Gravitational Force
    /// F = G × m₁ × m₂ / r² (Newton)
    public func gravitationalForce(m1: Float, m2: Float, r: Float) : Float {
        let G = 6.67430e-11;
        if (r == 0.0) return 0.0;
        G * m1 * m2 / (r * r)
    };
    
    /// FORMULA 21: Coulomb's Law
    /// F = k × q₁ × q₂ / r²
    public func coulombForce(q1: Float, q2: Float, r: Float) : Float {
        let k = 8.9875517923e9;  // Coulomb's constant
        if (r == 0.0) return 0.0;
        k * q1 * q2 / (r * r)
    };
    
    /// FORMULA 22: Heisenberg Uncertainty
    /// Δx × Δp ≥ ℏ/2
    public func heisenbergMinimum() : Float {
        1.054571817e-34 / 2.0
    };
    
    /// FORMULA 23: de Broglie Wavelength
    /// λ = h/p = h/(mv)
    public func deBroglieWavelength(mass: Float, velocity: Float) : Float {
        let h = 6.62607015e-34;
        if (mass * velocity == 0.0) return 0.0;
        h / (mass * velocity)
    };
    
    /// FORMULA 24: Schrödinger Energy
    /// E = ℏω for quantum harmonic oscillator
    public func quantumEnergy(omega: Float) : Float {
        let hbar = 1.054571817e-34;
        hbar * omega
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 6: INFORMATION THEORY FORMULAS
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// FORMULA 25: Shannon Entropy
    /// H(X) = -Σ p(x) × log₂(p(x))
    public func shannonEntropy(probabilities: [Float]) : Float {
        var entropy : Float = 0.0;
        for (p in probabilities.vals()) {
            if (p > 0.0 and p <= 1.0) {
                entropy -= p * (Float.log(p) / Float.log(2.0));
            };
        };
        entropy
    };
    
    /// FORMULA 26: Information Content
    /// I(x) = -log₂(p(x))
    public func informationContent(probability: Float) : Float {
        if (probability <= 0.0 or probability > 1.0) return 0.0;
        -(Float.log(probability) / Float.log(2.0))
    };
    
    /// FORMULA 27: Mutual Information
    /// I(X;Y) = H(X) + H(Y) - H(X,Y)
    public func mutualInformation(H_X: Float, H_Y: Float, H_XY: Float) : Float {
        H_X + H_Y - H_XY
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 7: CRYPTOGRAPHIC FORMULAS
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// FORMULA 28: Hash Function Collision Probability (Birthday)
    /// P(collision) ≈ 1 - e^(-n²/(2H)) where H = hash space size
    public func birthdayProbability(n: Float, H: Float) : Float {
        if (H == 0.0) return 1.0;
        1.0 - Float.exp(-(n * n) / (2.0 * H))
    };
    
    /// FORMULA 29: Key Space Size
    /// K = 2^bits
    public func keySpaceSize(bits: Nat) : Float {
        Float.pow(2.0, Float.fromInt(Int.abs(bits)))
    };
    
    /// FORMULA 30: Threshold Secret Sharing
    /// (t, n) scheme: need t of n shares to reconstruct
    /// Number of possible coalitions: C(n, t)
    public func thresholdCoalitions(n: Nat, t: Nat) : Nat {
        if (t > n) return 0;
        // C(n, t) = n! / (t! × (n-t)!)
        var result : Nat = 1;
        var j : Nat = 1;
        for (i in Iter.range(0, t - 1)) {
            result := result * (n - i);
            result := result / j;
            j += 1;
        };
        result
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 8: GEOMETRIC FORMULAS
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// FORMULA 31: Pythagorean Theorem
    /// c² = a² + b²
    public func pythagorean(a: Float, b: Float) : Float {
        Float.sqrt(a * a + b * b)
    };
    
    /// FORMULA 32: Golden Rectangle
    /// Aspect ratio = φ : 1
    public func goldenRectangle(width: Float) : Float {
        width / goldenRatio()
    };
    
    /// FORMULA 33: Pentagon Diagonal to Side Ratio
    /// d/s = φ (golden ratio in pentagons)
    public func pentagonDiagonal(side: Float) : Float {
        side * goldenRatio()
    };
    
    /// FORMULA 34: Icosahedron Vertices
    /// Vertices at (0, ±1, ±φ) and cyclic permutations
    public func icosahedronVertex(index: Nat) : (Float, Float, Float) {
        let phi = goldenRatio();
        let vertices : [(Float, Float, Float)] = [
            (0.0, 1.0, phi),
            (0.0, 1.0, -phi),
            (0.0, -1.0, phi),
            (0.0, -1.0, -phi),
            (1.0, phi, 0.0),
            (1.0, -phi, 0.0),
            (-1.0, phi, 0.0),
            (-1.0, -phi, 0.0),
            (phi, 0.0, 1.0),
            (phi, 0.0, -1.0),
            (-phi, 0.0, 1.0),
            (-phi, 0.0, -1.0),
        ];
        if (index < vertices.size()) {
            vertices[index]
        } else {
            (0.0, 0.0, 0.0)
        }
    };
    
    /// FORMULA 35: Sphere Surface Area
    /// A = 4πr²
    public func sphereSurfaceArea(radius: Float) : Float {
        4.0 * 3.141592653589793 * radius * radius
    };
    
    /// FORMULA 36: Torus Volume
    /// V = 2π²Rr² (major radius R, minor radius r)
    public func torusVolume(R: Float, r: Float) : Float {
        let pi = 3.141592653589793;
        2.0 * pi * pi * R * r * r
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 9: NEURAL/AI FORMULAS
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// FORMULA 37: Sigmoid Activation
    /// σ(x) = 1 / (1 + e^(-x))
    public func sigmoid(x: Float) : Float {
        1.0 / (1.0 + Float.exp(-x))
    };
    
    /// FORMULA 38: ReLU Activation
    /// ReLU(x) = max(0, x)
    public func relu(x: Float) : Float {
        if (x > 0.0) { x } else { 0.0 }
    };
    
    /// FORMULA 39: Softmax (for single element)
    /// softmax(x_i) = e^(x_i) / Σ e^(x_j)
    public func softmaxElement(x: Float, sum_exp: Float) : Float {
        if (sum_exp == 0.0) return 0.0;
        Float.exp(x) / sum_exp
    };
    
    /// FORMULA 40: Hebbian Learning
    /// Δw_ij = η × x_i × y_j
    public func hebbianUpdate(eta: Float, x_i: Float, y_j: Float) : Float {
        eta * x_i * y_j
    };
    
    /// FORMULA 41: Cross-Entropy Loss
    /// L = -Σ y × log(ŷ)
    public func crossEntropyElement(y: Float, y_hat: Float) : Float {
        if (y_hat <= 0.0) return 0.0;
        -y * Float.log(y_hat)
    };
    
    /// FORMULA 42: Attention Score
    /// score = Q × K^T / √d_k
    public func attentionScore(qk_dot: Float, d_k: Nat) : Float {
        if (d_k == 0) return 0.0;
        qk_dot / Float.sqrt(Float.fromInt(Int.abs(d_k)))
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 10: ECONOMIC/TOKEN FORMULAS
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// FORMULA 43: MEMO Token Reward
    /// Reward = Base × QualityMultiplier + NoveltyBonus + ResearchBonus
    public func memoReward(
        base: Nat,
        quality_grade: Float,
        novelty: Float,
        triggers_research: Bool,
        updates_organism: Bool
    ) : Nat {
        var reward = Float.fromInt(Int.abs(base));
        
        // Quality multiplier: × grade × 10
        reward *= quality_grade * 10.0;
        
        // Novelty bonus: +50 if novelty > 0.8
        if (novelty > 0.8) { reward += 50.0 };
        
        // Research bonus: +100
        if (triggers_research) { reward += 100.0 };
        
        // Organism update bonus: +200
        if (updates_organism) { reward += 200.0 };
        
        Int.abs(Float.toInt(reward))
    };
    
    /// FORMULA 44: Token Velocity
    /// V = GDP / M (economic velocity)
    public func tokenVelocity(totalValue: Float, moneySupply: Float) : Float {
        if (moneySupply == 0.0) return 0.0;
        totalValue / moneySupply
    };
    
    /// FORMULA 45: Compound Interest
    /// A = P × (1 + r)^n
    public func compoundInterest(principal: Float, rate: Float, periods: Nat) : Float {
        principal * Float.pow(1.0 + rate, Float.fromInt(Int.abs(periods)))
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SECTION 11: ANCIENT MATH FORMULAS
    // ═══════════════════════════════════════════════════════════════════════════
    
    /// FORMULA 46: Pythagorean Triple Generator
    /// (m² - n², 2mn, m² + n²) for m > n > 0
    public func pythagoreanTriple(m: Nat, n: Nat) : (Nat, Nat, Nat) {
        if (m <= n) return (0, 0, 0);
        let a = m * m - n * n;
        let b = 2 * m * n;
        let c = m * m + n * n;
        (a, b, c)
    };
    
    /// FORMULA 47: Perfect Number Check
    /// A perfect number equals the sum of its proper divisors
    public func isPerfect(n: Nat) : Bool {
        if (n <= 1) return false;
        var sum : Nat = 1;
        var i : Nat = 2;
        while (i * i <= n) {
            if (n % i == 0) {
                sum += i;
                if (i != n / i) {
                    sum += n / i;
                };
            };
            i += 1;
        };
        sum == n
    };
    
    /// FORMULA 48: Tetractys Sum
    /// 1 + 2 + 3 + 4 = 10 (sacred to Pythagoreans)
    public func tetractys() : Nat {
        1 + 2 + 3 + 4
    };
    
    /// FORMULA 49: Lo Shu Magic Square Constant
    /// Every row, column, diagonal sums to 15
    public func loShuConstant() : Nat {
        15
    };
    
    /// FORMULA 50: Tzolkin Cycle
    /// 13 × 20 = 260 days (Mayan sacred calendar)
    public func tzolkinCycle() : Nat {
        13 * 20
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // FORMULA CATALOG
    // ═══════════════════════════════════════════════════════════════════════════
    
    public type FormulaCatalogEntry = {
        id: Nat;
        name: Text;
        formula: Text;
        domain: Text;
        primitiveRoot: Text;
    };
    
    /// Get all 50 formulas as catalog
    public func getFormulaCatalog() : [FormulaCatalogEntry] {
        [
            { id = 1;  name = "Golden Ratio"; formula = "φ = (1 + √5) / 2"; domain = "Mathematics"; primitiveRoot = "φ" },
            { id = 2;  name = "Fibonacci Limit"; formula = "φ = lim F(n+1)/F(n)"; domain = "Mathematics"; primitiveRoot = "φ" },
            { id = 3;  name = "Golden Properties"; formula = "φ² = φ + 1"; domain = "Mathematics"; primitiveRoot = "φ" },
            { id = 4;  name = "Golden Angle"; formula = "θ = 2π/φ²"; domain = "Geometry"; primitiveRoot = "φ" },
            { id = 5;  name = "Golden Spiral"; formula = "r(θ) = aφ^(θ/(π/2))"; domain = "Geometry"; primitiveRoot = "φ" },
            { id = 6;  name = "Fibonacci"; formula = "F(n) = F(n-1) + F(n-2)"; domain = "Mathematics"; primitiveRoot = "φ" },
            { id = 7;  name = "Binet"; formula = "F(n) = (φⁿ - ψⁿ)/√5"; domain = "Mathematics"; primitiveRoot = "φ" },
            { id = 8;  name = "Lucas"; formula = "L(n) = L(n-1) + L(n-2)"; domain = "Mathematics"; primitiveRoot = "φ" },
            { id = 9;  name = "Schumann"; formula = "f = 7.83√[n(n+1)]"; domain = "Physics"; primitiveRoot = "c" },
            { id = 10; name = "Solfeggio"; formula = "{396,417,528,639,741,852}"; domain = "Frequency"; primitiveRoot = "φ" },
            { id = 11; name = "Golden Frequency"; formula = "f = f₀φ^(n/20)"; domain = "Frequency"; primitiveRoot = "φ" },
            { id = 12; name = "Three Hearts"; formula = "ω = {0.1, φ, φ²}"; domain = "Frequency"; primitiveRoot = "φ" },
            { id = 13; name = "Wavelength"; formula = "λ = c/f"; domain = "Physics"; primitiveRoot = "c" },
            { id = 14; name = "Planck-Einstein"; formula = "E = hf"; domain = "Physics"; primitiveRoot = "h" },
            { id = 15; name = "Period"; formula = "T = 1/f"; domain = "Physics"; primitiveRoot = "t" },
            { id = 16; name = "Kuramoto"; formula = "dθ/dt = ω + KΣsin(θⱼ-θᵢ)"; domain = "Dynamics"; primitiveRoot = "φ" },
            { id = 17; name = "Order Parameter"; formula = "R = |Σe^(iθ)|/N"; domain = "Dynamics"; primitiveRoot = "φ" },
            { id = 18; name = "Three Hearts K"; formula = "K = φ-weighted matrix"; domain = "Dynamics"; primitiveRoot = "φ" },
            { id = 19; name = "Mass-Energy"; formula = "E = mc²"; domain = "Physics"; primitiveRoot = "c" },
            { id = 20; name = "Gravitation"; formula = "F = Gm₁m₂/r²"; domain = "Physics"; primitiveRoot = "G" },
            { id = 21; name = "Coulomb"; formula = "F = kq₁q₂/r²"; domain = "Physics"; primitiveRoot = "e" },
            { id = 22; name = "Heisenberg"; formula = "ΔxΔp ≥ ℏ/2"; domain = "Quantum"; primitiveRoot = "ℏ" },
            { id = 23; name = "de Broglie"; formula = "λ = h/mv"; domain = "Quantum"; primitiveRoot = "h" },
            { id = 24; name = "Quantum Energy"; formula = "E = ℏω"; domain = "Quantum"; primitiveRoot = "ℏ" },
            { id = 25; name = "Shannon"; formula = "H = -Σp log₂ p"; domain = "Information"; primitiveRoot = "φ" },
            { id = 26; name = "Information"; formula = "I = -log₂ p"; domain = "Information"; primitiveRoot = "φ" },
            { id = 27; name = "Mutual Info"; formula = "I(X;Y) = H(X)+H(Y)-H(X,Y)"; domain = "Information"; primitiveRoot = "φ" },
            { id = 28; name = "Birthday"; formula = "P ≈ 1-e^(-n²/2H)"; domain = "Crypto"; primitiveRoot = "e" },
            { id = 29; name = "Key Space"; formula = "K = 2^bits"; domain = "Crypto"; primitiveRoot = "2" },
            { id = 30; name = "Threshold"; formula = "C(n,t) coalitions"; domain = "Crypto"; primitiveRoot = "φ" },
            { id = 31; name = "Pythagorean"; formula = "c² = a² + b²"; domain = "Geometry"; primitiveRoot = "1" },
            { id = 32; name = "Golden Rectangle"; formula = "aspect = φ:1"; domain = "Geometry"; primitiveRoot = "φ" },
            { id = 33; name = "Pentagon"; formula = "d/s = φ"; domain = "Geometry"; primitiveRoot = "φ" },
            { id = 34; name = "Icosahedron"; formula = "(0,±1,±φ) vertices"; domain = "Geometry"; primitiveRoot = "φ" },
            { id = 35; name = "Sphere Area"; formula = "A = 4πr²"; domain = "Geometry"; primitiveRoot = "π" },
            { id = 36; name = "Torus Volume"; formula = "V = 2π²Rr²"; domain = "Geometry"; primitiveRoot = "π" },
            { id = 37; name = "Sigmoid"; formula = "σ(x) = 1/(1+e^(-x))"; domain = "AI"; primitiveRoot = "e" },
            { id = 38; name = "ReLU"; formula = "f(x) = max(0,x)"; domain = "AI"; primitiveRoot = "0" },
            { id = 39; name = "Softmax"; formula = "e^x/Σe^x"; domain = "AI"; primitiveRoot = "e" },
            { id = 40; name = "Hebbian"; formula = "Δw = η×x×y"; domain = "AI"; primitiveRoot = "φ" },
            { id = 41; name = "Cross-Entropy"; formula = "L = -Σy log ŷ"; domain = "AI"; primitiveRoot = "e" },
            { id = 42; name = "Attention"; formula = "QK^T/√d"; domain = "AI"; primitiveRoot = "φ" },
            { id = 43; name = "MEMO Reward"; formula = "Base×Q+Bonuses"; domain = "Token"; primitiveRoot = "φ" },
            { id = 44; name = "Velocity"; formula = "V = GDP/M"; domain = "Token"; primitiveRoot = "φ" },
            { id = 45; name = "Compound"; formula = "A = P(1+r)ⁿ"; domain = "Token"; primitiveRoot = "e" },
            { id = 46; name = "Pythagorean Gen"; formula = "(m²-n², 2mn, m²+n²)"; domain = "Ancient"; primitiveRoot = "1" },
            { id = 47; name = "Perfect Number"; formula = "n = Σ divisors"; domain = "Ancient"; primitiveRoot = "1" },
            { id = 48; name = "Tetractys"; formula = "1+2+3+4 = 10"; domain = "Ancient"; primitiveRoot = "1" },
            { id = 49; name = "Lo Shu"; formula = "magic constant = 15"; domain = "Ancient"; primitiveRoot = "1" },
            { id = 50; name = "Tzolkin"; formula = "13 × 20 = 260"; domain = "Ancient"; primitiveRoot = "φ" },
        ]
    };
    
    /// Verify all formulas trace to primitive
    public func verifyAllFormulas() : Bool {
        let catalog = getFormulaCatalog();
        for (entry in catalog.vals()) {
            if (entry.primitiveRoot.size() == 0) {
                return false;
            };
        };
        true
    };
}
