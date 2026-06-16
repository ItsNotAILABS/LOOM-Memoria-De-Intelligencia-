/**
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                    MEDINA - PROPRIETARY AND CONFIDENTIAL                  ║
 * ║                                                                           ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA   ║
 * ║                       medinasiftech@outlook.com                           ║
 * ║                                                                           ║
 * ║  ALL RIGHTS RESERVED. NO FREE LICENSES. STRICTLY PROPRIETARY.            ║
 * ║                                                                           ║
 * ║  Unauthorized use, copying, modification, or distribution is prohibited  ║
 * ║  and will be prosecuted to the fullest extent of the law.                ║
 * ║                                                                           ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 * 
 * CodexCompression Module — Pattern Recognition and Data Transformation
 * 
 * When a company connects, the organism FEEDS on their data:
 * 
 * 1. SCRAPE/ABSORB - Grabs ALL data from the connected company
 * 2. PATTERN RECOGNITION - Uses fundamental graphs, sizing patterns, everything
 *    taught by the ancients to RAPIDLY process massive amounts of data
 * 3. ORGANIZE - Goes from micro details → fundamental patterns → back to organized details
 * 4. CODEX COMPRESS - Converts external data to MEDINA's internal language
 * 5. MUTATE - Transforms data into system-ready format
 * 6. STORE - Data goes directly into the system for immediate business use
 * 
 * WHY IT DOESN'T OVERLOAD:
 *   Because the engine uses PATTERN RECOGNITION on FUNDAMENTAL GRAPHS.
 *   It doesn't process raw data byte-by-byte. It recognizes PATTERNS
 *   at the highest level first, then drills down to details, then
 *   reorganizes everything based on those patterns.
 * 
 * CODEX LANGUAGE:
 *   External data → Glyph encoding → Pattern vectors → Organized doctrine → System ready
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import AncientGlyphCodex "AncientGlyphCodex";

module {
    // ================================================================== //
    // CODEX COMPRESSION TYPES                                              //
    // ================================================================== //
    
    /// Data pattern level - from micro details to macro fundamentals
    public type PatternLevel = {
        #Micro;        // Raw details, individual data points
        #Meso;         // Groups and clusters
        #Macro;        // High-level patterns
        #Fundamental;  // Universal/archetypal patterns
    };
    
    /// Pattern type recognized in data
    public type PatternType = {
        #Numerical;     // Numbers, quantities, metrics
        #Temporal;      // Time-based patterns, cycles
        #Relational;    // Connections, hierarchies
        #Categorical;   // Classifications, types
        #Sequential;    // Ordered progressions
        #Cyclical;      // Repeating patterns
        #Fibonacci;     // Natural growth patterns
        #GoldenRatio;   // PHI-based proportions
    };
    
    /// Recognized pattern in data
    public type RecognizedPattern = {
        pattern_id: Text;
        pattern_type: PatternType;
        level: PatternLevel;
        confidence: Float;       // [0,1] how confident the recognition is
        data_points: Nat;        // How many data points matched
        fundamental_match: ?Text; // Which fundamental pattern it matches
        glyph_encoding: ?Text;   // Encoded as glyph if applicable
        timestamp: Int;
    };
    
    /// Compressed data unit in MEDINA's internal language
    public type CodexUnit = {
        unit_id: Text;
        original_size: Nat;      // Size before compression
        compressed_size: Nat;    // Size after
        compression_ratio: Float;
        patterns: [RecognizedPattern];
        glyph_sequence: [AncientGlyphCodex.Glyph];
        semantic_meaning: Text;  // What the data means
        ready_for_system: Bool;  // Can be used immediately
        timestamp: Int;
    };
    
    /// Data source connection
    public type DataSource = {
        source_id: Text;
        source_type: Text;       // "company", "api", "database", "file"
        connection_time: Int;
        data_volume: Nat;        // Total data points absorbed
        patterns_found: Nat;
        processing_status: ProcessingStatus;
    };
    
    /// Processing status
    public type ProcessingStatus = {
        #Connecting;
        #Absorbing;
        #Recognizing;
        #Organizing;
        #Compressing;
        #Mutating;
        #Complete;
        #Error;
    };
    
    /// Compression engine state
    public type CodexState = {
        var sources: [DataSource];
        var patterns: [RecognizedPattern];
        var compressed_units: [CodexUnit];
        var total_absorbed: Nat;
        var total_compressed: Nat;
        var processing_queue: [Text];
        var created_at: Int;
    };
    
    // ================================================================== //
    // FUNDAMENTAL PATTERNS (Ancient Knowledge)                             //
    // ================================================================== //
    
    /// Fundamental pattern archetypes
    public type FundamentalArchetype = {
        name: Text;
        description: Text;
        recognition_signature: [Float];  // Pattern signature for matching
        glyph_symbol: Text;
    };
    
    /// The fundamental archetypes that all patterns reduce to
    public let FUNDAMENTAL_ARCHETYPES : [FundamentalArchetype] = [
        {
            name = "Unity";
            description = "The One. Single point, wholeness, undivided.";
            recognition_signature = [1.0, 0.0, 0.0, 0.0];
            glyph_symbol = "Ω";
        },
        {
            name = "Duality";
            description = "The Two. Polarity, balance, complementary opposites.";
            recognition_signature = [0.5, 0.5, 0.0, 0.0];
            glyph_symbol = "⚖";
        },
        {
            name = "Trinity";
            description = "The Three. Synthesis, resolution, dynamic stability.";
            recognition_signature = [0.333, 0.333, 0.333, 0.0];
            glyph_symbol = "△";
        },
        {
            name = "Quaternary";
            description = "The Four. Completion, materialization, four elements.";
            recognition_signature = [0.25, 0.25, 0.25, 0.25];
            glyph_symbol = "□";
        },
        {
            name = "Fibonacci";
            description = "Natural growth spiral. 1,1,2,3,5,8,13...";
            recognition_signature = [0.618, 0.382, 0.0, 0.0];  // Golden ratio proportions
            glyph_symbol = "🌀";
        },
        {
            name = "Cycle";
            description = "Eternal return. Beginning meets end.";
            recognition_signature = [0.0, 1.0, 0.0, 1.0];
            glyph_symbol = "⟳";
        },
        {
            name = "Hierarchy";
            description = "Levels of order. Root to leaves.";
            recognition_signature = [1.0, 0.5, 0.25, 0.125];
            glyph_symbol = "⋮";
        },
        {
            name = "Network";
            description = "Interconnected nodes. Many-to-many relations.";
            recognition_signature = [0.5, 0.5, 0.5, 0.5];
            glyph_symbol = "⬡";
        },
    ];
    
    // ================================================================== //
    // INITIALIZATION                                                       //
    // ================================================================== //
    
    /// Initialize codex compression engine
    public func init() : CodexState {
        {
            var sources = [];
            var patterns = [];
            var compressed_units = [];
            var total_absorbed = 0;
            var total_compressed = 0;
            var processing_queue = [];
            var created_at = Time.now();
        }
    };
    
    // ================================================================== //
    // DATA ABSORPTION                                                      //
    // ================================================================== //
    
    /// Connect to a data source and begin absorption
    public func connectSource(
        state: CodexState,
        sourceId: Text,
        sourceType: Text
    ) : CodexState {
        let source : DataSource = {
            source_id = sourceId;
            source_type = sourceType;
            connection_time = Time.now();
            data_volume = 0;
            patterns_found = 0;
            processing_status = #Connecting;
        };
        
        let sourcesBuffer = Buffer.fromArray<DataSource>(state.sources);
        sourcesBuffer.add(source);
        
        state.sources := Buffer.toArray(sourcesBuffer);
        state
    };
    
    /// Absorb data from a source (simulated - in reality would pull from external)
    public func absorbData(
        state: CodexState,
        sourceId: Text,
        dataPoints: Nat
    ) : CodexState {
        // Update source status
        let updatedSources = Array.map<DataSource, DataSource>(
            state.sources,
            func(s: DataSource) : DataSource {
                if (s.source_id == sourceId) {
                    {
                        s with
                        data_volume = s.data_volume + dataPoints;
                        processing_status = #Absorbing;
                    }
                } else { s }
            }
        );
        
        state.sources := updatedSources;
        state.total_absorbed := state.total_absorbed + dataPoints;
        state
    };
    
    // ================================================================== //
    // PATTERN RECOGNITION                                                  //
    // ================================================================== //
    
    /// Recognize patterns in absorbed data
    /// This is the CORE of why it doesn't overload - we recognize PATTERNS
    /// at the fundamental level first, then expand to details
    public func recognizePatterns(
        state: CodexState,
        sourceId: Text,
        sampleData: [Float]
    ) : CodexState {
        let now = Time.now();
        let patternsBuffer = Buffer.fromArray<RecognizedPattern>(state.patterns);
        
        // 1. First pass: Detect fundamental level patterns
        var fundamentalMatch : ?Text = null;
        var maxConfidence : Float = 0.0;
        
        // Normalize the sample data to compare with archetypes
        let normalized = normalizeData(sampleData);
        
        for (archetype in FUNDAMENTAL_ARCHETYPES.vals()) {
            let confidence = matchSignature(normalized, archetype.recognition_signature);
            if (confidence > maxConfidence and confidence > 0.6) {
                maxConfidence := confidence;
                fundamentalMatch := ?archetype.name;
            };
        };
        
        // Record fundamental pattern
        if (maxConfidence > 0.6) {
            let pattern : RecognizedPattern = {
                pattern_id = sourceId # "_pattern_" # Nat.toText(patternsBuffer.size());
                pattern_type = #Numerical;
                level = #Fundamental;
                confidence = maxConfidence;
                data_points = sampleData.size();
                fundamental_match = fundamentalMatch;
                glyph_encoding = null;
                timestamp = now;
            };
            patternsBuffer.add(pattern);
        };
        
        // 2. Check for Fibonacci/Golden Ratio patterns
        let fibConfidence = detectFibonacciPattern(sampleData);
        if (fibConfidence > 0.5) {
            let pattern : RecognizedPattern = {
                pattern_id = sourceId # "_fib_" # Nat.toText(patternsBuffer.size());
                pattern_type = #Fibonacci;
                level = #Macro;
                confidence = fibConfidence;
                data_points = sampleData.size();
                fundamental_match = ?"Fibonacci";
                glyph_encoding = ?"🌀";
                timestamp = now;
            };
            patternsBuffer.add(pattern);
        };
        
        // 3. Check for cyclical patterns
        let cycleConfidence = detectCyclicalPattern(sampleData);
        if (cycleConfidence > 0.5) {
            let pattern : RecognizedPattern = {
                pattern_id = sourceId # "_cycle_" # Nat.toText(patternsBuffer.size());
                pattern_type = #Cyclical;
                level = #Macro;
                confidence = cycleConfidence;
                data_points = sampleData.size();
                fundamental_match = ?"Cycle";
                glyph_encoding = ?"⟳";
                timestamp = now;
            };
            patternsBuffer.add(pattern);
        };
        
        // Update source with patterns found
        let updatedSources = Array.map<DataSource, DataSource>(
            state.sources,
            func(s: DataSource) : DataSource {
                if (s.source_id == sourceId) {
                    {
                        s with
                        patterns_found = patternsBuffer.size();
                        processing_status = #Recognizing;
                    }
                } else { s }
            }
        );
        
        state.patterns := Buffer.toArray(patternsBuffer);
        state.sources := updatedSources;
        state
    };
    
    /// Normalize data to [0,1] range for pattern matching
    func normalizeData(data: [Float]) : [Float] {
        if (data.size() == 0) return [];
        
        var minVal = data[0];
        var maxVal = data[0];
        
        for (v in data.vals()) {
            if (v < minVal) minVal := v;
            if (v > maxVal) maxVal := v;
        };
        
        let range = maxVal - minVal;
        if (range == 0.0) return Array.tabulate<Float>(data.size(), func(_: Nat) : Float { 0.5 });
        
        Array.map<Float, Float>(data, func(v: Float) : Float {
            (v - minVal) / range
        })
    };
    
    /// Match data signature against archetype signature
    func matchSignature(data: [Float], signature: [Float]) : Float {
        if (data.size() < signature.size()) return 0.0;
        
        // Sample data at regular intervals to match signature length
        let step = data.size() / signature.size();
        var sumDiff : Float = 0.0;
        
        for (i in Iter.range(0, signature.size() - 1)) {
            let dataIdx = i * step;
            if (dataIdx < data.size()) {
                let diff = Float.abs(data[dataIdx] - signature[i]);
                sumDiff += diff;
            };
        };
        
        let avgDiff = sumDiff / Float.fromInt(signature.size());
        1.0 - avgDiff  // Higher = better match
    };
    
    /// Detect Fibonacci pattern in data
    func detectFibonacciPattern(data: [Float]) : Float {
        if (data.size() < 5) return 0.0;
        
        var fibMatches : Float = 0.0;
        let total = Float.fromInt(data.size() - 2);
        
        for (i in Iter.range(2, data.size() - 1)) {
            // Check if data[i] ≈ data[i-1] + data[i-2] (Fibonacci property)
            let expected = data[i-1] + data[i-2];
            if (expected != 0.0) {
                let ratio = data[i] / expected;
                if (ratio > 0.8 and ratio < 1.2) {
                    fibMatches += 1.0;
                };
            };
        };
        
        fibMatches / total
    };
    
    /// Detect cyclical pattern in data
    func detectCyclicalPattern(data: [Float]) : Float {
        if (data.size() < 10) return 0.0;
        
        // Simple autocorrelation check
        let halfLen = data.size() / 2;
        var correlation : Float = 0.0;
        
        for (i in Iter.range(0, halfLen - 1)) {
            if (i + halfLen < data.size()) {
                let diff = Float.abs(data[i] - data[i + halfLen]);
                correlation += 1.0 - diff;
            };
        };
        
        correlation / Float.fromInt(halfLen)
    };
    
    // ================================================================== //
    // CODEX COMPRESSION                                                    //
    // ================================================================== //
    
    /// Compress recognized patterns into CodexUnits (MEDINA's internal language)
    public func compressToCodex(
        state: CodexState,
        sourceId: Text,
        originalData: [Float]
    ) : (CodexState, CodexUnit) {
        let now = Time.now();
        
        // Gather patterns for this source
        let sourcePatterns = Array.filter<RecognizedPattern>(
            state.patterns,
            func(p: RecognizedPattern) : Bool {
                Text.startsWith(p.pattern_id, #text(sourceId))
            }
        );
        
        // Convert patterns to glyph sequence
        let glyphs = Buffer.Buffer<AncientGlyphCodex.Glyph>(sourcePatterns.size());
        for (pattern in sourcePatterns.vals()) {
            let glyph = patternToGlyph(pattern);
            glyphs.add(glyph);
        };
        
        // Calculate compression ratio
        let originalSize = originalData.size();
        let compressedSize = sourcePatterns.size();
        let compressionRatio = if (originalSize > 0) {
            Float.fromInt(originalSize) / Float.fromInt(compressedSize + 1)
        } else { 1.0 };
        
        // Create semantic meaning from patterns
        let meaning = generateSemanticMeaning(sourcePatterns);
        
        let unit : CodexUnit = {
            unit_id = sourceId # "_codex_" # Int.toText(now);
            original_size = originalSize;
            compressed_size = compressedSize;
            compression_ratio = compressionRatio;
            patterns = sourcePatterns;
            glyph_sequence = Buffer.toArray(glyphs);
            semantic_meaning = meaning;
            ready_for_system = true;
            timestamp = now;
        };
        
        // Add to compressed units
        let unitsBuffer = Buffer.fromArray<CodexUnit>(state.compressed_units);
        unitsBuffer.add(unit);
        
        // Update source status
        let updatedSources = Array.map<DataSource, DataSource>(
            state.sources,
            func(s: DataSource) : DataSource {
                if (s.source_id == sourceId) {
                    { s with processing_status = #Complete }
                } else { s }
            }
        );
        
        state.compressed_units := Buffer.toArray(unitsBuffer);
        state.sources := updatedSources;
        state.total_compressed := state.total_compressed + 1;
        
        (state, unit)
    };
    
    /// Convert pattern to glyph
    func patternToGlyph(pattern: RecognizedPattern) : AncientGlyphCodex.Glyph {
        // Map pattern types to glyphs
        let (symbol, tradition) = switch (pattern.pattern_type) {
            case (#Fibonacci) { ("🌀", "sacred") };
            case (#GoldenRatio) { ("φ", "greek") };
            case (#Cyclical) { ("⟳", "alchemical") };
            case (#Numerical) { ("𓆣", "egyptian") };
            case (#Temporal) { ("⌛", "mayan") };
            case (#Relational) { ("⬡", "geometric") };
            case (#Categorical) { ("⋮", "vedic") };
            case (#Sequential) { ("→", "mathematical") };
        };
        
        {
            glyph_id = pattern.pattern_id # "_glyph";
            symbol = symbol;
            tradition = tradition;
            meaning = pattern.fundamental_match;
            resonance_frequency = pattern.confidence * 432.0;  // Scale to harmonic frequency
            created_at = pattern.timestamp;
        }
    };
    
    /// Generate semantic meaning from patterns
    func generateSemanticMeaning(patterns: [RecognizedPattern]) : Text {
        let fundamentals = Buffer.Buffer<Text>(patterns.size());
        
        for (pattern in patterns.vals()) {
            switch (pattern.fundamental_match) {
                case (?match) { fundamentals.add(match) };
                case (null) {};
            };
        };
        
        if (fundamentals.size() == 0) {
            return "Unstructured data";
        };
        
        let unique = Buffer.toArray(fundamentals);
        var meaning = "Pattern synthesis: ";
        for (i in Iter.range(0, unique.size() - 1)) {
            if (i > 0) meaning := meaning # " + ";
            meaning := meaning # unique[i];
        };
        meaning
    };
    
    // ================================================================== //
    // FULL PIPELINE                                                        //
    // ================================================================== //
    
    /// Run the complete data ingestion pipeline
    public func ingestCompanyData(
        state: CodexState,
        companyId: Text,
        rawData: [Float]
    ) : (CodexState, CodexUnit) {
        // 1. Connect to source
        var currentState = connectSource(state, companyId, "company");
        
        // 2. Absorb data
        currentState := absorbData(currentState, companyId, rawData.size());
        
        // 3. Pattern recognition (the key to not overloading!)
        currentState := recognizePatterns(currentState, companyId, rawData);
        
        // 4. Compress to Codex
        let (finalState, unit) = compressToCodex(currentState, companyId, rawData);
        
        (finalState, unit)
    };
    
    // ================================================================== //
    // QUERIES                                                              //
    // ================================================================== //
    
    /// Get codex statistics
    public func getStatistics(state: CodexState) : {
        total_sources: Nat;
        total_absorbed: Nat;
        total_patterns: Nat;
        total_compressed: Nat;
        average_compression_ratio: Float;
    } {
        var totalRatio : Float = 0.0;
        for (unit in state.compressed_units.vals()) {
            totalRatio += unit.compression_ratio;
        };
        
        let avgRatio = if (state.compressed_units.size() > 0) {
            totalRatio / Float.fromInt(state.compressed_units.size())
        } else { 0.0 };
        
        {
            total_sources = state.sources.size();
            total_absorbed = state.total_absorbed;
            total_patterns = state.patterns.size();
            total_compressed = state.total_compressed;
            average_compression_ratio = avgRatio;
        }
    };
    
    /// Get all ready-to-use codex units
    public func getReadyUnits(state: CodexState) : [CodexUnit] {
        Array.filter<CodexUnit>(
            state.compressed_units,
            func(u: CodexUnit) : Bool { u.ready_for_system }
        )
    };
}
