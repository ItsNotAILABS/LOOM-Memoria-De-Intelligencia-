/**
 * AncientGlyphCodex Module — Mayan, Chinese, Egyptian, Vedic, Hebrew, Greek
 * 
 * Symbol transfer system encoding ancient glyphs as computational primitives.
 * Glyphs are not just descriptions — they are TRANSFER MECHANISMS for power
 * and meaning, compressing entire concepts into executable symbols.
 * 
 * MAYAN GLYPHS (Vigesimal Computation):
 *   - Number system with dots (1) and bars (5)
 *   - Long Count calendar encoding
 *   - Tzolkin day signs
 *   - Astronomical computation markers
 * 
 * CHINESE CHARACTERS (Compressed Meaning):
 *   - Five Elements (五行)
 *   - Eight Trigrams (八卦)
 *   - I Ching hexagrams
 *   - Radical components
 * 
 * EGYPTIAN HIEROGLYPHS (Sacred Geometry):
 *   - Sacred symbols (ankh, djed, was)
 *   - Pyramid geometry encoding
 *   - Eye of Horus fractions
 *   - Unit fraction decomposition
 * 
 * VEDIC MANTRAS (Frequency Encoding):
 *   - Bija (seed) mantras
 *   - Chakra glyphs
 *   - Sanskrit syllables
 *   - Yantra geometry
 * 
 * HEBREW LETTERS (Gematria):
 *   - 22 letter numerical values
 *   - Tree of Life paths
 *   - Divine names
 *   - Word value computation
 * 
 * GREEK LETTERS (Mathematical Constants):
 *   - Mathematical symbols
 *   - Isopsephy (Greek gematria)
 *   - Philosophical concepts
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

import MatalkoICP "MatalkoICP";

module {
    // ================================================================== //
    // GLYPH CORE TYPES                                                     //
    // ================================================================== //
    
    /// Glyph tradition origin
    public type GlyphTradition = {
        #Mayan;
        #Chinese;
        #Egyptian;
        #Vedic;
        #Hebrew;
        #Greek;
        #Universal;
    };
    
    /// Glyph category
    public type GlyphCategory = {
        #Number;
        #Symbol;
        #Element;
        #Time;
        #Sound;
        #Geometry;
        #Letter;
    };
    
    /// Base glyph type
    public type Glyph = {
        id: Text;
        tradition: GlyphTradition;
        category: GlyphCategory;
        symbol: Text;
        name: Text;
        meaning: Text;
        frequency: ?Float;        // Associated frequency (Hz)
        geometry: ?GlyphGeometry;
        numericValue: ?Nat;
    };
    
    /// Geometry associated with glyph
    public type GlyphGeometry = {
        vertices: Nat;
        edges: Nat;
        faces: Nat;
        angle: ?Float;           // Characteristic angle (degrees)
        ratio: ?Float;           // Sacred ratio if applicable
    };
    
    /// Glyph phrase (combined glyphs)
    public type GlyphPhrase = {
        glyphs: [Glyph];
        combinedMeaning: Text;
        resonanceSignature: Float;
        totalNumericValue: Nat;
    };
    
    // ================================================================== //
    // MAYAN GLYPHS                                                         //
    // ================================================================== //
    
    /// Mayan number glyph (0-19)
    public func mayanNumber(n: Nat) : Glyph {
        let value = n % 20;
        let dots = value % 5;
        let bars = value / 5;
        
        var symbol = "";
        if (value == 0) {
            symbol := "◯";  // Shell for zero
        } else {
            var i : Nat = 0;
            while (i < dots) {
                symbol := symbol # "•";
                i += 1;
            };
            if (bars > 0) {
                i := 0;
                while (i < bars) {
                    symbol := symbol # "═";
                    i += 1;
                };
            };
        };
        
        // Frequency based on sacred 432 Hz and golden ratio
        let freq = 432.0 * (1.0 + Float.fromInt(value) * 0.05);
        
        {
            id = "mayan_" # Nat.toText(value);
            tradition = #Mayan;
            category = #Number;
            symbol = symbol;
            name = "Mayan " # Nat.toText(value);
            meaning = "Mayan numeral representing " # Nat.toText(value);
            frequency = ?freq;
            geometry = ?{
                vertices = if (value == 0) { 0 } else { dots + bars };
                edges = 0;
                faces = if (value == 0) { 1 } else { 0 };
                angle = null;
                ratio = null;
            };
            numericValue = ?value;
        }
    };
    
    /// Mayan day signs (Tzolkin)
    public let MAYAN_DAY_SIGNS : [(Text, Text, Nat)] = [
        ("Imix", "Water Lily/Crocodile", 4),
        ("Ik", "Wind/Breath", 4),
        ("Akbal", "Night/Darkness", 4),
        ("Kan", "Seed/Corn", 4),
        ("Chicchan", "Serpent", 5),
        ("Cimi", "Death/Transformation", 6),
        ("Manik", "Deer/Hand", 4),
        ("Lamat", "Star/Venus", 8),
        ("Muluc", "Moon/Water", 4),
        ("Oc", "Dog", 4),
        ("Chuen", "Monkey/Artisan", 5),
        ("Eb", "Road/Grass", 4),
        ("Ben", "Reed/Corn Stalk", 4),
        ("Ix", "Jaguar", 4),
        ("Men", "Eagle", 4),
        ("Cib", "Owl/Wisdom", 4),
        ("Caban", "Earth/Movement", 4),
        ("Etznab", "Flint/Mirror", 4),
        ("Cauac", "Storm/Rain", 4),
        ("Ahau", "Sun/Lord", 4)
    ];
    
    /// Get Mayan day sign glyph
    public func mayanDaySign(index: Nat) : Glyph {
        let idx = index % 20;
        let (name, meaning, vertices) = MAYAN_DAY_SIGNS[idx];
        
        {
            id = "mayan_day_" # Nat.toText(idx);
            tradition = #Mayan;
            category = #Time;
            symbol = name;
            name = name;
            meaning = meaning;
            frequency = ?(432.0 * (1.0 + Float.fromInt(idx) * 0.03));
            geometry = ?{
                vertices = vertices;
                edges = vertices;
                faces = 1;
                angle = ?(360.0 / Float.fromInt(vertices));
                ratio = null;
            };
            numericValue = ?idx;
        }
    };
    
    /// Mayan Long Count to glyph phrase
    public func mayanLongCount(baktun: Nat, katun: Nat, tun: Nat, uinal: Nat, kin: Nat) : GlyphPhrase {
        let totalDays = baktun * 144000 + katun * 7200 + tun * 360 + uinal * 20 + kin;
        
        let glyphs = [
            mayanNumber(baktun % 20),
            mayanNumber(katun % 20),
            mayanNumber(tun % 20),
            mayanNumber(uinal % 20),
            mayanNumber(kin % 20)
        ];
        
        let resonance = 432.0 * MatalkoICP.PHI * Float.fromInt(totalDays % 260 + 1) / 260.0;
        
        {
            glyphs = glyphs;
            combinedMeaning = "Long Count: " # Nat.toText(baktun) # "." # 
                              Nat.toText(katun) # "." # Nat.toText(tun) # "." #
                              Nat.toText(uinal) # "." # Nat.toText(kin) #
                              " = " # Nat.toText(totalDays) # " days";
            resonanceSignature = resonance;
            totalNumericValue = totalDays;
        }
    };
    
    // ================================================================== //
    // CHINESE CHARACTERS                                                   //
    // ================================================================== //
    
    /// Five Elements (五行)
    public let CHINESE_ELEMENTS : [(Text, Text, Text, Float)] = [
        ("木", "Mù", "Wood/Growth", 396.0),
        ("火", "Huǒ", "Fire/Transformation", 396.0),
        ("土", "Tǔ", "Earth/Stability", 285.0),
        ("金", "Jīn", "Metal/Harvest", 741.0),
        ("水", "Shuǐ", "Water/Flow", 417.0)
    ];
    
    /// Get Chinese element glyph
    public func chineseElement(name: Text) : Glyph {
        let elements = [
            ("wood", 0), ("fire", 1), ("earth", 2), ("metal", 3), ("water", 4),
            ("mu", 0), ("huo", 1), ("tu", 2), ("jin", 3), ("shui", 4)
        ];
        
        var idx : Nat = 0;
        for ((n, i) in elements.vals()) {
            if (Text.toLowercase(name) == n) {
                idx := i;
            };
        };
        
        let (symbol, pinyin, meaning, freq) = CHINESE_ELEMENTS[idx];
        
        {
            id = "chinese_element_" # pinyin;
            tradition = #Chinese;
            category = #Element;
            symbol = symbol;
            name = pinyin;
            meaning = meaning;
            frequency = ?freq;
            geometry = ?{
                vertices = idx + 3;
                edges = idx + 3;
                faces = 1;
                angle = null;
                ratio = null;
            };
            numericValue = ?(idx + 1);
        }
    };
    
    /// Eight Trigrams (八卦)
    public let CHINESE_TRIGRAMS : [(Text, Text, Text, [Bool])] = [
        ("☰", "Qián", "Heaven/Creative", [true, true, true]),
        ("☱", "Duì", "Lake/Joyous", [false, true, true]),
        ("☲", "Lí", "Fire/Clinging", [true, false, true]),
        ("☳", "Zhèn", "Thunder/Arousing", [false, false, true]),
        ("☴", "Xùn", "Wind/Gentle", [true, true, false]),
        ("☵", "Kǎn", "Water/Abysmal", [false, true, false]),
        ("☶", "Gèn", "Mountain/Still", [true, false, false]),
        ("☷", "Kūn", "Earth/Receptive", [false, false, false])
    ];
    
    /// Get Chinese trigram glyph
    public func chineseTrigram(index: Nat) : Glyph {
        let idx = index % 8;
        let (symbol, pinyin, meaning, _) = CHINESE_TRIGRAMS[idx];
        
        {
            id = "trigram_" # Nat.toText(idx);
            tradition = #Chinese;
            category = #Symbol;
            symbol = symbol;
            name = pinyin;
            meaning = meaning;
            frequency = ?(528.0 * (1.0 + Float.fromInt(idx) * 0.05));
            geometry = ?{
                vertices = 3;
                edges = 3;
                faces = 1;
                angle = ?120.0;
                ratio = null;
            };
            numericValue = ?idx;
        }
    };
    
    /// Calculate I Ching hexagram number from two trigrams
    public func iChingHexagram(upper: Nat, lower: Nat) : GlyphPhrase {
        let upperTrigram = chineseTrigram(upper);
        let lowerTrigram = chineseTrigram(lower);
        let hexNum = (upper % 8) * 8 + (lower % 8) + 1;
        
        {
            glyphs = [upperTrigram, lowerTrigram];
            combinedMeaning = "Hexagram " # Nat.toText(hexNum) # ": " #
                              upperTrigram.name # " over " # lowerTrigram.name;
            resonanceSignature = 528.0 * MatalkoICP.PHI * Float.fromInt(hexNum) / 64.0;
            totalNumericValue = hexNum;
        }
    };
    
    // ================================================================== //
    // EGYPTIAN HIEROGLYPHS                                                 //
    // ================================================================== //
    
    /// Egyptian sacred symbols
    public let EGYPTIAN_SYMBOLS : [(Text, Text, Text, Nat)] = [
        ("☥", "Ankh", "Life/Eternal", 5),
        ("𓊽", "Djed", "Stability/Spine of Osiris", 4),
        ("𓌀", "Was", "Power/Dominion", 3),
        ("𓂀", "Eye of Horus", "Protection/Healing", 6),
        ("𓆣", "Scarab", "Transformation/Sun", 6),
        ("𓋹", "Shen", "Eternity/Protection", 0),  // Circle
        ("𓊖", "Pyramid", "Ascension/Sacred Geometry", 4),
        ("𓍯", "Ouroboros", "Cycles/Infinity", 0)
    ];
    
    /// Get Egyptian symbol glyph
    public func egyptianSymbol(name: Text) : Glyph {
        let names = ["ankh", "djed", "was", "eye", "scarab", "shen", "pyramid", "ouroboros"];
        var idx : Nat = 0;
        var i : Nat = 0;
        for (n in names.vals()) {
            if (Text.toLowercase(name) == n) {
                idx := i;
            };
            i += 1;
        };
        
        let (symbol, symName, meaning, vertices) = EGYPTIAN_SYMBOLS[idx];
        
        // Pyramid has special geometry
        let geom : GlyphGeometry = if (idx == 6) {
            {
                vertices = 4;
                edges = 6;
                faces = 4;
                angle = ?51.5;  // Great Pyramid angle
                ratio = ?MatalkoICP.PHI;
            }
        } else {
            {
                vertices = vertices;
                edges = vertices;
                faces = if (vertices == 0) { 1 } else { 1 };
                angle = null;
                ratio = null;
            }
        };
        
        {
            id = "egyptian_" # Text.toLowercase(symName);
            tradition = #Egyptian;
            category = #Symbol;
            symbol = symbol;
            name = symName;
            meaning = meaning;
            frequency = ?(432.0 * MatalkoICP.PHI);
            geometry = ?geom;
            numericValue = ?(idx + 1);
        }
    };
    
    /// Eye of Horus fraction system (1 = sum of parts)
    public let EYE_OF_HORUS_FRACTIONS : [(Text, Nat, Nat)] = [
        ("Right side of eye", 1, 2),    // 1/2
        ("Pupil", 1, 4),                // 1/4
        ("Eyebrow", 1, 8),              // 1/8
        ("Left side of eye", 1, 16),    // 1/16
        ("Curled portion", 1, 32),      // 1/32
        ("Teardrop", 1, 64)             // 1/64
    ];
    
    /// Maximum iterations for Egyptian fraction decomposition
    /// Limit of 10 is sufficient for most practical fractions and prevents
    /// infinite loops for fractions that converge slowly
    let EGYPTIAN_FRACTION_MAX_ITERATIONS : Nat = 10;
    
    /// Egyptian unit fraction decomposition (e.g., 3/7 as sum of 1/n)
    /// Uses the greedy algorithm to decompose fractions into unit fractions
    public func egyptianFraction(numerator: Nat, denominator: Nat) : [Nat] {
        if (denominator == 0 or numerator == 0) { return [] };
        if (numerator >= denominator) { return [1] };
        
        let fractions = Buffer.Buffer<Nat>(8);
        var num = numerator;
        var den = denominator;
        
        var iterations : Nat = 0;
        while (num > 0 and iterations < EGYPTIAN_FRACTION_MAX_ITERATIONS) {
            // Find smallest n such that 1/n ≤ num/den
            let unitDen = (den + num - 1) / num;  // Ceiling division
            fractions.add(unitDen);
            
            // Subtract: num/den - 1/unitDen = (num*unitDen - den)/(den*unitDen)
            num := num * unitDen - den;
            den := den * unitDen;
            
            // Simplify by GCD
            if (num > 0) {
                var a = num;
                var b = den;
                while (b > 0) {
                    let temp = b;
                    b := a % b;
                    a := temp;
                };
                let g = a;
                num := num / g;
                den := den / g;
            };
            
            iterations += 1;
        };
        
        Buffer.toArray(fractions)
    };
    
    // ================================================================== //
    // VEDIC MANTRAS                                                        //
    // ================================================================== //
    
    /// Bija (seed) mantras
    public let VEDIC_BIJA : [(Text, Text, Float)] = [
        ("ॐ", "Om", 136.1),           // Primordial
        ("ह्रीं", "Hreem", 136.1),      // Shakti
        ("क्लीं", "Kleem", 741.0),      // Attraction
        ("श्रीं", "Shreem", 639.0),     // Abundance
        ("ऐं", "Aim", 528.0),          // Wisdom
        ("हूं", "Hum", 396.0),          // Protection
        ("लं", "Lam", 256.0),          // Root
        ("वं", "Vam", 288.0),          // Sacral
        ("रं", "Ram", 320.0),          // Solar
        ("यं", "Yam", 341.3),          // Heart
        ("हं", "Ham", 384.0),          // Throat
        ("ॐ", "Om (Third Eye)", 426.7), // Third Eye
        ("अः", "Ah", 480.0)            // Crown
    ];
    
    /// Get Vedic bija mantra glyph
    public func vedicBija(name: Text) : Glyph {
        let names = ["om", "hreem", "kleem", "shreem", "aim", "hum", "lam", "vam", "ram", "yam", "ham", "aum", "ah"];
        var idx : Nat = 0;
        var i : Nat = 0;
        for (n in names.vals()) {
            if (Text.toLowercase(name) == n) {
                idx := i;
            };
            i += 1;
        };
        
        let (symbol, mantra, freq) = VEDIC_BIJA[idx % VEDIC_BIJA.size()];
        
        {
            id = "vedic_" # Text.toLowercase(mantra);
            tradition = #Vedic;
            category = #Sound;
            symbol = symbol;
            name = mantra;
            meaning = "Bija mantra: " # mantra;
            frequency = ?freq;
            geometry = null;
            numericValue = ?(idx + 1);
        }
    };
    
    /// Seven chakras
    public let CHAKRA_GLYPHS : [(Text, Text, Float, Text, Nat)] = [
        ("मूलाधार", "Muladhara", 256.0, "Red", 4),       // Root
        ("स्वाधिष्ठान", "Svadhisthana", 288.0, "Orange", 6), // Sacral
        ("मणिपूर", "Manipura", 320.0, "Yellow", 10),     // Solar
        ("अनाहत", "Anahata", 341.3, "Green", 12),       // Heart
        ("विशुद्ध", "Vishuddha", 384.0, "Blue", 16),     // Throat
        ("आज्ञा", "Ajna", 426.7, "Indigo", 2),          // Third Eye
        ("सहस्रार", "Sahasrara", 480.0, "Violet", 1000) // Crown
    ];
    
    /// Get chakra glyph
    public func chakraGlyph(index: Nat) : Glyph {
        let idx = index % 7;
        let (symbol, name, freq, color, petals) = CHAKRA_GLYPHS[idx];
        
        {
            id = "chakra_" # Nat.toText(idx);
            tradition = #Vedic;
            category = #Symbol;
            symbol = symbol;
            name = name;
            meaning = "Chakra " # Nat.toText(idx + 1) # ": " # name # " (" # color # ", " # Nat.toText(petals) # " petals)";
            frequency = ?freq;
            geometry = ?{
                vertices = petals;
                edges = petals;
                faces = 1;
                angle = ?(360.0 / Float.fromInt(petals));
                ratio = null;
            };
            numericValue = ?(idx + 1);
        }
    };
    
    // ================================================================== //
    // HEBREW LETTERS                                                       //
    // ================================================================== //
    
    /// Hebrew alphabet with gematria values
    public let HEBREW_LETTERS : [(Text, Text, Nat)] = [
        ("א", "Aleph", 1),
        ("ב", "Bet", 2),
        ("ג", "Gimel", 3),
        ("ד", "Dalet", 4),
        ("ה", "He", 5),
        ("ו", "Vav", 6),
        ("ז", "Zayin", 7),
        ("ח", "Chet", 8),
        ("ט", "Tet", 9),
        ("י", "Yod", 10),
        ("כ", "Kaf", 20),
        ("ל", "Lamed", 30),
        ("מ", "Mem", 40),
        ("נ", "Nun", 50),
        ("ס", "Samekh", 60),
        ("ע", "Ayin", 70),
        ("פ", "Pe", 80),
        ("צ", "Tsadi", 90),
        ("ק", "Qof", 100),
        ("ר", "Resh", 200),
        ("ש", "Shin", 300),
        ("ת", "Tav", 400)
    ];
    
    /// Get Hebrew letter glyph
    public func hebrewLetter(index: Nat) : Glyph {
        let idx = index % 22;
        let (symbol, name, value) = HEBREW_LETTERS[idx];
        
        {
            id = "hebrew_" # Text.toLowercase(name);
            tradition = #Hebrew;
            category = #Letter;
            symbol = symbol;
            name = name;
            meaning = "Hebrew letter " # name # " (Path " # Nat.toText(idx + 1) # " on Tree of Life)";
            frequency = ?(432.0 * Float.fromInt(value) / 400.0);
            geometry = null;
            numericValue = ?value;
        }
    };
    
    /// Calculate gematria value of Hebrew text
    /// Sum of numeric values of all Hebrew letters in the text
    public func gematria(text: Text) : Nat {
        var total : Nat = 0;
        
        // Iterate through each character in the text
        for (char in text.chars()) {
            let charText = Text.fromChar(char);
            // Check if this character matches any Hebrew letter
            for ((symbol, _, value) in HEBREW_LETTERS.vals()) {
                if (charText == symbol) {
                    total += value;
                };
            };
        };
        
        total
    };
    
    // ================================================================== //
    // GREEK LETTERS                                                        //
    // ================================================================== //
    
    /// Greek letters with mathematical associations
    public let GREEK_LETTERS : [(Text, Text, ?Float)] = [
        ("α", "alpha", null),
        ("β", "beta", null),
        ("γ", "gamma", ?0.5772156649),  // Euler-Mascheroni
        ("δ", "delta", null),
        ("ε", "epsilon", null),
        ("ζ", "zeta", null),
        ("η", "eta", null),
        ("θ", "theta", null),
        ("ι", "iota", null),
        ("κ", "kappa", null),
        ("λ", "lambda", null),
        ("μ", "mu", null),
        ("ν", "nu", null),
        ("ξ", "xi", null),
        ("ο", "omicron", null),
        ("π", "pi", ?3.141592653589793),
        ("ρ", "rho", null),
        ("σ", "sigma", null),
        ("τ", "tau", ?6.283185307179586),  // 2π
        ("υ", "upsilon", null),
        ("φ", "phi", ?1.618033988749895),   // Golden ratio
        ("χ", "chi", null),
        ("ψ", "psi", null),
        ("ω", "omega", null)
    ];
    
    /// Get Greek letter glyph
    public func greekLetter(name: Text) : Glyph {
        var idx : Nat = 0;
        var i : Nat = 0;
        var foundValue : ?Float = null;
        var foundSymbol = "α";
        var foundName = "alpha";
        
        for ((symbol, letterName, value) in GREEK_LETTERS.vals()) {
            if (Text.toLowercase(name) == letterName) {
                idx := i;
                foundValue := value;
                foundSymbol := symbol;
                foundName := letterName;
            };
            i += 1;
        };
        
        let meaning = switch (foundValue) {
            case (?v) { foundName # " = " # Float.toText(v) };
            case (null) { "Greek letter " # foundName };
        };
        
        {
            id = "greek_" # foundName;
            tradition = #Greek;
            category = #Letter;
            symbol = foundSymbol;
            name = foundName;
            meaning = meaning;
            frequency = switch (foundValue) {
                case (?v) { ?(v * 100.0) };
                case (null) { null };
            };
            geometry = null;
            numericValue = ?(idx + 1);
        }
    };
    
    // ================================================================== //
    // GLYPH OPERATIONS                                                     //
    // ================================================================== //
    
    /// Combine glyphs into phrase
    public func combineGlyphs(glyphs: [Glyph]) : GlyphPhrase {
        var totalValue : Nat = 0;
        var resonance : Float = 0.0;
        var meaningParts = Buffer.Buffer<Text>(glyphs.size());
        
        for (glyph in glyphs.vals()) {
            switch (glyph.numericValue) {
                case (?v) { totalValue += v };
                case (null) {};
            };
            switch (glyph.frequency) {
                case (?f) { resonance += f };
                case (null) {};
            };
            meaningParts.add(glyph.meaning);
        };
        
        // Average the resonance if there are glyphs
        if (glyphs.size() > 0) {
            resonance := resonance / Float.fromInt(glyphs.size());
        } else {
            resonance := 0.0;
        };
        
        {
            glyphs = glyphs;
            combinedMeaning = Text.join("; ", Buffer.toArray(meaningParts).vals());
            resonanceSignature = resonance;
            totalNumericValue = totalValue;
        }
    };
    
    /// Calculate resonance between two glyphs
    public func glyphResonance(a: Glyph, b: Glyph) : Float {
        let freqA = switch (a.frequency) { case (?f) { f }; case (null) { 432.0 } };
        let freqB = switch (b.frequency) { case (?f) { f }; case (null) { 432.0 } };
        
        MatalkoICP.resonanceScore(freqA, freqB)
    };
    
    /// Get all glyphs from a tradition
    public func glyphsFromTradition(tradition: GlyphTradition) : [Glyph] {
        let glyphs = Buffer.Buffer<Glyph>(20);
        
        switch (tradition) {
            case (#Mayan) {
                var i : Nat = 0;
                while (i < 20) {
                    glyphs.add(mayanNumber(i));
                    i += 1;
                };
            };
            case (#Chinese) {
                let elements = ["wood", "fire", "earth", "metal", "water"];
                for (e in elements.vals()) {
                    glyphs.add(chineseElement(e));
                };
                var i : Nat = 0;
                while (i < 8) {
                    glyphs.add(chineseTrigram(i));
                    i += 1;
                };
            };
            case (#Egyptian) {
                let symbols = ["ankh", "djed", "was", "eye", "scarab", "shen", "pyramid", "ouroboros"];
                for (s in symbols.vals()) {
                    glyphs.add(egyptianSymbol(s));
                };
            };
            case (#Vedic) {
                let bijas = ["om", "hreem", "kleem", "shreem"];
                for (b in bijas.vals()) {
                    glyphs.add(vedicBija(b));
                };
                var i : Nat = 0;
                while (i < 7) {
                    glyphs.add(chakraGlyph(i));
                    i += 1;
                };
            };
            case (#Hebrew) {
                var i : Nat = 0;
                while (i < 22) {
                    glyphs.add(hebrewLetter(i));
                    i += 1;
                };
            };
            case (#Greek) {
                let letters = ["alpha", "beta", "gamma", "pi", "phi", "omega"];
                for (l in letters.vals()) {
                    glyphs.add(greekLetter(l));
                };
            };
            case (#Universal) {
                // Add representative glyphs from each tradition
                glyphs.add(mayanNumber(13));
                glyphs.add(chineseElement("fire"));
                glyphs.add(egyptianSymbol("ankh"));
                glyphs.add(vedicBija("om"));
                glyphs.add(hebrewLetter(0));
                glyphs.add(greekLetter("phi"));
            };
        };
        
        Buffer.toArray(glyphs)
    };
}
