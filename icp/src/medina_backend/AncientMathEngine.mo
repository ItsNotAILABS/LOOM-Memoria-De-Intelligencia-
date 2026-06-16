/**
 * AncientMathEngine Module — Pythagorean, Euclidean, Mayan, Vedic, Chinese
 * 
 * Computational engine encoding ancient mathematical systems as executable
 * formulas. This module bridges timeless mathematical wisdom with canister
 * intelligence, providing the substrate for numerical computation aligned
 * with sacred geometry and cosmic patterns.
 * 
 * PYTHAGOREAN MATHEMATICS:
 *   - Perfect numbers, triangular numbers, square numbers
 *   - Pythagorean theorem and triples
 *   - Musical ratios (tetractys)
 *   - Sacred number sequences
 * 
 * EUCLIDEAN GEOMETRY:
 *   - GCD and LCM (Euclidean algorithm)
 *   - Geometric constructions
 *   - Proportional reasoning
 * 
 * MAYAN MATHEMATICS:
 *   - Vigesimal (base-20) system
 *   - Long Count calendar computation
 *   - Tzolkin cycle mathematics
 *   - Zero as placeholder
 * 
 * VEDIC MATHEMATICS:
 *   - Sutras for rapid calculation
 *   - Vertically and crosswise multiplication
 *   - Digital roots (Beejank)
 * 
 * CHINESE MATHEMATICS:
 *   - I Ching hexagram computation
 *   - Magic squares (Lo Shu)
 *   - Remainder theorem
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

import MatalkoICP "MatalkoICP";

module {
    // ================================================================== //
    // CONSTANTS                                                            //
    // ================================================================== //
    
    /// Golden ratio
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Pi
    public let PI : Float = MatalkoICP.PI;
    
    /// Square root of 2
    public let SQRT2 : Float = MatalkoICP.SQRT2;
    
    /// Square root of 3
    public let SQRT3 : Float = MatalkoICP.SQRT3;
    
    /// Square root of 5
    public let SQRT5 : Float = MatalkoICP.SQRT5;
    
    // ================================================================== //
    // PYTHAGOREAN MATHEMATICS                                              //
    // ================================================================== //
    
    /// Check if a number is perfect (equals sum of proper divisors)
    public func isPerfect(n: Nat) : Bool {
        if (n <= 1) { return false };
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
    
    /// Get nth triangular number: T(n) = n(n+1)/2
    public func triangularNumber(n: Nat) : Nat {
        n * (n + 1) / 2
    };
    
    /// Check if a number is triangular
    public func isTriangular(n: Nat) : Bool {
        // n is triangular if 8n + 1 is a perfect square
        let test = 8 * n + 1;
        let root = Float.toInt(Float.sqrt(Float.fromInt(test)));
        Int.abs(root) * Int.abs(root) == test
    };
    
    /// Get nth square number: S(n) = n²
    public func squareNumber(n: Nat) : Nat {
        n * n
    };
    
    /// Check if a number is a perfect square
    public func isPerfectSquare(n: Nat) : Bool {
        let root = Float.toInt(Float.sqrt(Float.fromInt(n)));
        Int.abs(root) * Int.abs(root) == n
    };
    
    /// Get nth pentagonal number: P(n) = n(3n-1)/2
    public func pentagonalNumber(n: Nat) : Nat {
        n * (3 * n - 1) / 2
    };
    
    /// Get nth hexagonal number: H(n) = n(2n-1)
    public func hexagonalNumber(n: Nat) : Nat {
        n * (2 * n - 1)
    };
    
    /// Pythagorean triple type
    public type PythagoreanTriple = {
        a: Nat;
        b: Nat;
        c: Nat;  // Hypotenuse
    };
    
    /// Check if (a, b, c) is a Pythagorean triple
    public func isPythagoreanTriple(a: Nat, b: Nat, c: Nat) : Bool {
        a * a + b * b == c * c
    };
    
    /// Generate primitive Pythagorean triple using Euclid's formula
    /// Given m > n > 0, coprime with m-n odd: a = m²-n², b = 2mn, c = m²+n²
    public func generateTriple(m: Nat, n: Nat) : ?PythagoreanTriple {
        if (m <= n or n == 0) { return null };
        
        let a = m * m - n * n;
        let b = 2 * m * n;
        let c = m * m + n * n;
        
        // Ensure a < b for canonical form
        if (a < b) {
            ?{ a = a; b = b; c = c }
        } else {
            ?{ a = b; b = a; c = c }
        }
    };
    
    /// First few primitive Pythagorean triples
    public func primitivePythagoreanTriples(count: Nat) : [PythagoreanTriple] {
        let triples = Buffer.Buffer<PythagoreanTriple>(count);
        var found : Nat = 0;
        var m : Nat = 2;
        
        label outer while (found < count) {
            var n : Nat = 1;
            while (n < m) {
                if ((m - n) % 2 == 1 and gcd(m, n) == 1) {
                    switch (generateTriple(m, n)) {
                        case (?triple) {
                            triples.add(triple);
                            found += 1;
                            if (found >= count) { break outer };
                        };
                        case (null) {};
                    };
                };
                n += 1;
            };
            m += 1;
        };
        
        Buffer.toArray(triples)
    };
    
    /// Tetractys - the sacred Pythagorean triangle of 10 points
    public type Tetractys = {
        monad: Nat;     // 1 - Unity, the source
        dyad: Nat;      // 2 - Duality, opposition
        triad: Nat;     // 3 - Harmony, synthesis
        tetrad: Nat;    // 4 - Completion, cosmos
        total: Nat;     // 10 - The sacred decad
    };
    
    /// Get the Tetractys structure
    public func tetractys() : Tetractys {
        {
            monad = 1;
            dyad = 2;
            triad = 3;
            tetrad = 4;
            total = 10;
        }
    };
    
    /// Musical ratios from Pythagorean tuning
    public type MusicalRatio = {
        name: Text;
        ratio: (Nat, Nat);
        centValue: Float;
    };
    
    /// Pythagorean musical intervals
    public func pythagoreanIntervals() : [MusicalRatio] {
        [
            { name = "Unison"; ratio = (1, 1); centValue = 0.0 },
            { name = "Octave"; ratio = (2, 1); centValue = 1200.0 },
            { name = "Perfect Fifth"; ratio = (3, 2); centValue = 701.96 },
            { name = "Perfect Fourth"; ratio = (4, 3); centValue = 498.04 },
            { name = "Major Second"; ratio = (9, 8); centValue = 203.91 },
            { name = "Minor Third"; ratio = (32, 27); centValue = 294.13 },
            { name = "Major Third"; ratio = (81, 64); centValue = 407.82 },
            { name = "Minor Sixth"; ratio = (128, 81); centValue = 792.18 },
            { name = "Major Sixth"; ratio = (27, 16); centValue = 905.87 },
        ]
    };
    
    // ================================================================== //
    // EUCLIDEAN MATHEMATICS                                                //
    // ================================================================== //
    
    /// Greatest common divisor (Euclidean algorithm)
    public func gcd(a: Nat, b: Nat) : Nat {
        if (b == 0) { return a };
        gcd(b, a % b)
    };
    
    /// Least common multiple
    public func lcm(a: Nat, b: Nat) : Nat {
        if (a == 0 or b == 0) { return 0 };
        (a / gcd(a, b)) * b
    };
    
    /// Extended Euclidean algorithm (returns gcd, x, y where ax + by = gcd)
    public func extendedGcd(a: Int, b: Int) : (Int, Int, Int) {
        if (b == 0) {
            return (a, 1, 0);
        };
        let (g, x1, y1) = extendedGcd(b, a % b);
        let x = y1;
        let y = x1 - (a / b) * y1;
        (g, x, y)
    };
    
    /// Check if two numbers are coprime
    public func areCoprime(a: Nat, b: Nat) : Bool {
        gcd(a, b) == 1
    };
    
    /// Euler's totient function φ(n) - count of integers ≤n coprime to n
    public func eulerTotient(n: Nat) : Nat {
        if (n <= 1) { return n };
        
        var result = n;
        var num = n;
        var p : Nat = 2;
        
        while (p * p <= num) {
            if (num % p == 0) {
                while (num % p == 0) {
                    num := num / p;
                };
                result := result - result / p;
            };
            p += 1;
        };
        
        if (num > 1) {
            result := result - result / num;
        };
        
        result
    };
    
    /// Modular exponentiation: base^exp mod modulus
    public func modPow(base: Nat, exp: Nat, modulus: Nat) : Nat {
        if (modulus == 1) { return 0 };
        
        var result : Nat = 1;
        var b = base % modulus;
        var e = exp;
        
        while (e > 0) {
            if (e % 2 == 1) {
                result := (result * b) % modulus;
            };
            e := e / 2;
            b := (b * b) % modulus;
        };
        
        result
    };
    
    // ================================================================== //
    // MAYAN MATHEMATICS                                                    //
    // ================================================================== //
    
    /// Mayan numeral representation
    public type MayanNumeral = {
        value: Nat;
        dots: Nat;        // Count of dots (1-4)
        bars: Nat;        // Count of bars (each = 5)
        shell: Bool;      // Zero symbol
        symbol: Text;     // Visual representation
    };
    
    /// Convert number to Mayan vigesimal numeral
    public func toMayanNumeral(n: Nat) : MayanNumeral {
        if (n == 0) {
            return {
                value = 0;
                dots = 0;
                bars = 0;
                shell = true;
                symbol = "◯";  // Shell for zero
            };
        };
        
        let singleDigit = n % 20;
        let bars = singleDigit / 5;
        let dots = singleDigit % 5;
        
        // Build symbol
        var symbol = "";
        var i : Nat = 0;
        while (i < dots) {
            symbol := symbol # "•";
            i += 1;
        };
        i := 0;
        while (i < bars) {
            symbol := symbol # "═";
            i += 1;
        };
        
        {
            value = singleDigit;
            dots = dots;
            bars = bars;
            shell = false;
            symbol = symbol;
        }
    };
    
    /// Convert number to full Mayan vigesimal (base-20) representation
    public func toMayanVigesimal(n: Nat) : [MayanNumeral] {
        if (n == 0) {
            return [toMayanNumeral(0)];
        };
        
        let digits = Buffer.Buffer<MayanNumeral>(8);
        var remaining = n;
        
        while (remaining > 0) {
            let digit = remaining % 20;
            digits.add(toMayanNumeral(digit));
            remaining := remaining / 20;
        };
        
        // Reverse to get most significant first
        Buffer.toArray(digits)
    };
    
    /// Mayan Long Count date
    public type MayanLongCount = {
        kin: Nat;         // Days (0-19)
        uinal: Nat;       // 20 days (0-17)
        tun: Nat;         // 360 days (0-19)
        katun: Nat;       // 7,200 days (0-19)
        baktun: Nat;      // 144,000 days (0-19)
        totalDays: Nat;   // Total days from creation
    };
    
    /// Calculate total days from Long Count components
    public func longCountToDays(baktun: Nat, katun: Nat, tun: Nat, uinal: Nat, kin: Nat) : Nat {
        baktun * 144000 + katun * 7200 + tun * 360 + uinal * 20 + kin
    };
    
    /// Convert days to Long Count
    public func daysToLongCount(totalDays: Nat) : MayanLongCount {
        var days = totalDays;
        
        let baktun = days / 144000;
        days := days % 144000;
        
        let katun = days / 7200;
        days := days % 7200;
        
        let tun = days / 360;
        days := days % 360;
        
        let uinal = days / 20;
        let kin = days % 20;
        
        {
            kin = kin;
            uinal = uinal;
            tun = tun;
            katun = katun;
            baktun = baktun;
            totalDays = totalDays;
        }
    };
    
    /// Mayan day signs (Tzolkin)
    public let MAYAN_DAY_SIGNS : [Text] = [
        "Imix", "Ik", "Akbal", "Kan", "Chicchan",
        "Cimi", "Manik", "Lamat", "Muluc", "Oc",
        "Chuen", "Eb", "Ben", "Ix", "Men",
        "Cib", "Caban", "Etznab", "Cauac", "Ahau"
    ];
    
    /// Tzolkin date (260-day sacred calendar)
    public type TzolkinDate = {
        number: Nat;      // 1-13
        daySign: Text;    // One of 20 day signs
        daySignIndex: Nat; // 0-19
        totalDay: Nat;    // Position in 260-day cycle
    };
    
    /// Calculate Tzolkin date from day number
    public func toTzolkin(dayNumber: Nat) : TzolkinDate {
        let number = (dayNumber % 13) + 1;
        let daySignIndex = dayNumber % 20;
        let daySign = MAYAN_DAY_SIGNS[daySignIndex];
        
        {
            number = number;
            daySign = daySign;
            daySignIndex = daySignIndex;
            totalDay = dayNumber % 260;
        }
    };
    
    // ================================================================== //
    // VEDIC MATHEMATICS                                                    //
    // ================================================================== //
    
    /// Digital root (Beejank) - sum digits until single digit
    public func digitalRoot(n: Nat) : Nat {
        if (n == 0) { return 0 };
        let remainder = n % 9;
        if (remainder == 0) { 9 } else { remainder }
    };
    
    /// Sum of digits
    public func digitSum(n: Nat) : Nat {
        var sum : Nat = 0;
        var num = n;
        while (num > 0) {
            sum += num % 10;
            num := num / 10;
        };
        sum
    };
    
    /// Vedic multiplication sutra: Vertically and Crosswise
    /// For 2-digit numbers: (10a + b) × (10c + d) = 100ac + 10(ad + bc) + bd
    public func vedicMultiply2Digit(ab: Nat, cd: Nat) : Nat {
        let a = ab / 10;
        let b = ab % 10;
        let c = cd / 10;
        let d = cd % 10;
        
        100 * a * c + 10 * (a * d + b * c) + b * d
    };
    
    /// Vedic sutra: Nikhilam (All from 9, last from 10)
    /// For multiplication near a base (e.g., 100)
    public type NikhilamResult = {
        left: Int;
        right: Nat;
        result: Nat;
    };
    
    /// Apply Nikhilam sutra for multiplication near 100
    /// 
    /// IMPORTANT: This sutra works best for numbers close to 100 (e.g., 88-112).
    /// For numbers significantly different from 100, the algorithm may produce
    /// unexpected results due to the deficit calculation method.
    /// 
    /// Example: 97 × 96 = (97-4) × 100 + (3×4) = 93 × 100 + 12 = 9312
    public func nikhilam100(a: Nat, b: Nat) : NikhilamResult {
        // Note: Works best when a and b are close to 100
        let defA = 100 - a;  // deficit from 100
        let defB = 100 - b;
        
        // Cross subtraction for left part
        let leftInt : Int = a - defB;  // or equivalently b - defA
        
        // Multiply deficits for right part
        let right = defA * defB;
        
        // Calculate result using left part as integer
        let leftNat : Nat = if (leftInt < 0) { 0 } else { Int.abs(leftInt) };
        
        {
            left = leftInt;
            right = right;
            result = leftNat * 100 + right;
        }
    };
    
    /// Vedic sutra: Ekadhikena Purvena (By one more than the previous)
    /// For squaring numbers ending in 5: (10n + 5)² = 100n(n+1) + 25
    public func squareEndingIn5(n: Nat) : Nat {
        // n is the tens digit(s)
        let left = n * (n + 1);
        left * 100 + 25
    };
    
    /// Vedic divisibility check by 9 (using digital root)
    public func divisibleBy9(n: Nat) : Bool {
        digitalRoot(n) == 9
    };
    
    /// Vedic divisibility check by 3
    public func divisibleBy3(n: Nat) : Bool {
        let dr = digitalRoot(n);
        dr == 3 or dr == 6 or dr == 9
    };
    
    // ================================================================== //
    // CHINESE MATHEMATICS                                                  //
    // ================================================================== //
    
    /// Lo Shu magic square (3×3)
    public let LO_SHU : [[Nat]] = [
        [4, 9, 2],
        [3, 5, 7],
        [8, 1, 6]
    ];
    
    /// Magic constant for n×n magic square
    public func magicConstant(n: Nat) : Nat {
        n * (n * n + 1) / 2
    };
    
    /// Check if a 3×3 array is a magic square
    public func isMagicSquare3(square: [[Nat]]) : Bool {
        let magic = 15;  // Magic constant for 3×3
        
        // Check rows
        for (row in square.vals()) {
            if (row.size() != 3) { return false };
            if (row[0] + row[1] + row[2] != magic) { return false };
        };
        
        // Check columns
        if (square[0][0] + square[1][0] + square[2][0] != magic) { return false };
        if (square[0][1] + square[1][1] + square[2][1] != magic) { return false };
        if (square[0][2] + square[1][2] + square[2][2] != magic) { return false };
        
        // Check diagonals
        if (square[0][0] + square[1][1] + square[2][2] != magic) { return false };
        if (square[0][2] + square[1][1] + square[2][0] != magic) { return false };
        
        true
    };
    
    /// Chinese Remainder Theorem
    /// Solve system: x ≡ a₁ (mod n₁), x ≡ a₂ (mod n₂), ...
    public type CRTInput = {
        remainder: Nat;
        modulus: Nat;
    };
    
    /// Solve Chinese Remainder Theorem for two congruences
    public func chineseRemainderTheorem2(r1: Nat, m1: Nat, r2: Nat, m2: Nat) : ?Nat {
        if (gcd(m1, m2) != 1) { return null };  // Must be coprime
        
        let (_, x, _) = extendedGcd(m1, m2);
        let m = m1 * m2;
        
        // x = r1 + m1 * ((r2 - r1) * x mod m2)
        let diff : Int = r2 - r1;
        let product : Int = diff * x;
        var result : Int = product % m2;
        if (result < 0) { result := result + m2 };
        result := r1 + m1 * result;
        result := result % m;
        if (result < 0) { result := result + m };
        
        ?Int.abs(result)
    };
    
    /// I Ching trigram
    public type Trigram = {
        index: Nat;       // 0-7
        name: Text;       // Chinese name
        meaning: Text;    // English meaning
        lines: [Bool];    // true = yang (solid), false = yin (broken)
        element: Text;
        symbol: Text;
    };
    
    /// Get trigram by index (0-7)
    public func getTrigram(index: Nat) : ?Trigram {
        let trigrams : [Trigram] = [
            { index = 0; name = "Qian"; meaning = "Heaven/Creative"; lines = [true, true, true]; element = "Heaven"; symbol = "☰" },
            { index = 1; name = "Dui"; meaning = "Lake/Joyous"; lines = [true, true, false]; element = "Lake"; symbol = "☱" },
            { index = 2; name = "Li"; meaning = "Fire/Clinging"; lines = [true, false, true]; element = "Fire"; symbol = "☲" },
            { index = 3; name = "Zhen"; meaning = "Thunder/Arousing"; lines = [true, false, false]; element = "Thunder"; symbol = "☳" },
            { index = 4; name = "Xun"; meaning = "Wind/Gentle"; lines = [false, true, true]; element = "Wind"; symbol = "☴" },
            { index = 5; name = "Kan"; meaning = "Water/Abysmal"; lines = [false, true, false]; element = "Water"; symbol = "☵" },
            { index = 6; name = "Gen"; meaning = "Mountain/Keeping Still"; lines = [false, false, true]; element = "Mountain"; symbol = "☶" },
            { index = 7; name = "Kun"; meaning = "Earth/Receptive"; lines = [false, false, false]; element = "Earth"; symbol = "☷" },
        ];
        
        if (index < 8) { ?trigrams[index] } else { null }
    };
    
    /// Calculate hexagram number from upper and lower trigram indices
    public func hexagramNumber(upper: Nat, lower: Nat) : Nat {
        // King Wen sequence mapping (simplified)
        upper * 8 + lower + 1
    };
}
