/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║  AI SETTINGS · IMAGE EXTRACTOR · ANALYSIS · UPKEEP                         ║
 * ║  INSTRUMENTA PRAECISA ORGANISMI                                             ║
 * ║                                                                              ║
 * ║  "Instrumentum angustum est fortissimum. Latum est debile."                 ║
 * ║  (A narrow tool is the strongest. A broad tool is weak.)                    ║
 * ║                                                                              ║
 * ║  30 NARROW-SCOPED CALLABLE TOOLS:                                           ║
 * ║                                                                              ║
 * ║  AI SETTINGS (10):                                                          ║
 * ║    THEME-SETTER · VOICE-TUNER · RESPONSE-CALIBRATOR                        ║
 * ║    MEMORY-DEPTH-DIAL · PERMISSION-GATE · FREQUENCY-KNOB                    ║
 * ║    CONTEXT-WINDOW-SIZER · PERSONALITY-MIXER                                ║
 * ║    LANGUAGE-SELECTOR · SAFETY-THRESHOLD                                    ║
 * ║                                                                              ║
 * ║  IMAGE EXTRACTION (10):                                                     ║
 * ║    PIXEL-SCANNER · COLOR-MAPPER · EDGE-DETECTOR · GLYPH-READER            ║
 * ║    LAYER-PEELER · METADATA-HARVESTER · PATTERN-ISOLATOR                    ║
 * ║    DEPTH-PROBER · FREQUENCY-SLICER · THUMBNAIL-FORGER                     ║
 * ║                                                                              ║
 * ║  ANALYSIS (5):                                                              ║
 * ║    HASH-COMPARATOR · DRIFT-MEASURER · LOAD-WEIGHER                        ║
 * ║    ENTROPY-GAUGE · LATENCY-TIMER                                           ║
 * ║                                                                              ║
 * ║  UPKEEP (5):                                                                ║
 * ║    GARBAGE-SWEEPER · INDEX-REBUILDER · STALE-PRUNER                        ║
 * ║    HEALTH-PINGER · DEFRAG-RUNNER                                           ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every tool traces to primitive φ                          ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module AISettingsImageExtractor {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;
    public let PHI_CUBE : Float = 4.2360679774997896;
    public let PHI_INV : Float = 0.6180339887498949;
    public let SCHUMANN : Float = 7.83;

    public let MODULE_DOCTRINE : Text = "Instrumentum angustum est fortissimum. Latum est debile.";
    public let MODULE_DOCTRINE_EN : Text = "A narrow tool is the strongest. A broad tool is weak.";

    // ═══════════════════════════════════════════════════════════════════════
    // TYPES — reuse-compatible with CallableToolMarketplace
    // ═══════════════════════════════════════════════════════════════════════

    public type SchemaField = {
        fieldName: Text;
        fieldType: Text;
        required: Bool;
        description: Text;
    };

    public type CallSchema = {
        id: Text;
        name: Text;
        fields: [SchemaField];
        version: Text;
    };

    public type NarrowTool = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        purpose: Text;
        domain: Text;
        permissionClass: Text;
        inputSchema: CallSchema;
        outputSchema: CallSchema;
        latencyExpectation: Text;
        costWeight: Float;
        successContract: Text;
        failureContract: Text;
        houseId: Text;
        houseName: Text;
        frequency_Hz: Float;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
        version: Text;
        exposureTier: Text;
        billingClass: Text;
        trustTier: Text;
    };

    public type UpkeepCycle = {
        id: Text;
        name: Text;
        latinName: Text;
        intervalBeats: Nat;
        purpose: Text;
        toolId: Text;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // AI SETTINGS — 10 narrow-scoped tools
    // Each does exactly ONE thing to ONE setting
    // ═══════════════════════════════════════════════════════════════════════

    public let AI_SETTINGS_TOOLS : [NarrowTool] = [
        {
            id = "SET-001"; name = "THEME-SETTER"; latinName = "POSITOR THEMATIS";
            latinMotto = "Unum thema positum est.";
            latinMottoEN = "One theme is set.";
            purpose = "Sets the visual theme of the AI interface — dark, light, sovereign, custom palette";
            domain = "AI_SETTINGS"; permissionClass = "INTERNAL"; 
            inputSchema = { id = "SCH-SET-IN-001"; name = "ThemeInput"; fields = [
                { fieldName = "themeId"; fieldType = "Text"; required = true; description = "Theme identifier: DARK/LIGHT/SOVEREIGN/CUSTOM" },
                { fieldName = "customPalette"; fieldType = "[Text]"; required = false; description = "Custom hex colors if themeId=CUSTOM" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-SET-OUT-001"; name = "ThemeOutput"; fields = [
                { fieldName = "appliedTheme"; fieldType = "Text"; required = true; description = "Theme that was applied" },
                { fieldName = "colorCount"; fieldType = "Nat"; required = true; description = "Number of colors in palette" },
            ]; version = "1.0.0" };
            latencyExpectation = "<2ms"; costWeight = PHI_INV;
            successContract = "Theme applied, returns active theme ID";
            failureContract = "Returns current theme unchanged with error reason";
            houseId = "ORCH-HOUSE-003"; houseName = "DOMUS USUI";
            frequency_Hz = PHI_INV; primitiveTrace = "Theme->Distinction->phi"; isAlwaysOn = false;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "STANDARD";
        },
        {
            id = "SET-002"; name = "VOICE-TUNER"; latinName = "MODULATOR VOCIS";
            latinMotto = "Vox modulata, claritas nata.";
            latinMottoEN = "Voice tuned, clarity born.";
            purpose = "Adjusts AI voice parameters — tone, speed, formality, warmth for text generation";
            domain = "AI_SETTINGS"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-SET-IN-002"; name = "VoiceInput"; fields = [
                { fieldName = "tone"; fieldType = "Text"; required = true; description = "Tone class: FORMAL/CASUAL/TECHNICAL/WARM/NEUTRAL" },
                { fieldName = "speed"; fieldType = "Float"; required = false; description = "Response speed multiplier 0.5-2.0" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-SET-OUT-002"; name = "VoiceOutput"; fields = [
                { fieldName = "activeTone"; fieldType = "Text"; required = true; description = "Active tone after tuning" },
                { fieldName = "activeSpeed"; fieldType = "Float"; required = true; description = "Active speed multiplier" },
            ]; version = "1.0.0" };
            latencyExpectation = "<1ms"; costWeight = PHI_INV;
            successContract = "Voice parameters updated, returns active values";
            failureContract = "Returns previous voice params with rejection reason";
            houseId = "ORCH-HOUSE-003"; houseName = "DOMUS USUI";
            frequency_Hz = PHI_INV; primitiveTrace = "Voice->Language->phi"; isAlwaysOn = false;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "STANDARD";
        },
        {
            id = "SET-003"; name = "RESPONSE-CALIBRATOR"; latinName = "CALIBRATOR RESPONSI";
            latinMotto = "Responsum mensuratum, non fluctuans.";
            latinMottoEN = "Response measured, not wavering.";
            purpose = "Calibrates response length — sets min/max token bounds for AI output generation";
            domain = "AI_SETTINGS"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-SET-IN-003"; name = "CalibInput"; fields = [
                { fieldName = "minTokens"; fieldType = "Nat"; required = true; description = "Minimum tokens per response" },
                { fieldName = "maxTokens"; fieldType = "Nat"; required = true; description = "Maximum tokens per response" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-SET-OUT-003"; name = "CalibOutput"; fields = [
                { fieldName = "setMin"; fieldType = "Nat"; required = true; description = "Active minimum" },
                { fieldName = "setMax"; fieldType = "Nat"; required = true; description = "Active maximum" },
            ]; version = "1.0.0" };
            latencyExpectation = "<1ms"; costWeight = PHI_INV;
            successContract = "Token bounds set, returns active min/max";
            failureContract = "Returns current bounds if new values invalid";
            houseId = "ORCH-HOUSE-003"; houseName = "DOMUS USUI";
            frequency_Hz = PHI_INV; primitiveTrace = "Calibrate->Number->phi"; isAlwaysOn = false;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "STANDARD";
        },
        {
            id = "SET-004"; name = "MEMORY-DEPTH-DIAL"; latinName = "ROTA PROFUNDITATIS MEMORIAE";
            latinMotto = "Profunditas electa, non fortuita.";
            latinMottoEN = "Depth chosen, not accidental.";
            purpose = "Sets how many memory rings deep the AI searches when recalling — 1 (surface) to 7 (deepest)";
            domain = "AI_SETTINGS"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-SET-IN-004"; name = "DepthInput"; fields = [
                { fieldName = "ringDepth"; fieldType = "Nat"; required = true; description = "Memory ring depth 1-7" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-SET-OUT-004"; name = "DepthOutput"; fields = [
                { fieldName = "activeDepth"; fieldType = "Nat"; required = true; description = "Active ring depth" },
                { fieldName = "ringsAvailable"; fieldType = "Nat"; required = true; description = "Total rings available" },
            ]; version = "1.0.0" };
            latencyExpectation = "<1ms"; costWeight = PHI_INV;
            successContract = "Memory depth set, returns active depth and available count";
            failureContract = "Returns current depth if requested depth exceeds available rings";
            houseId = "ORCH-HOUSE-004"; houseName = "DOMUS INTERNAE";
            frequency_Hz = PHI; primitiveTrace = "MemoryDepth->Memory->phi"; isAlwaysOn = false;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "SET-005"; name = "PERMISSION-GATE"; latinName = "PORTA PERMISSIONIS";
            latinMotto = "Porta clausa, securitas certa.";
            latinMottoEN = "Gate closed, security certain.";
            purpose = "Toggles a single permission flag — enables or disables one specific access right for a caller";
            domain = "AI_SETTINGS"; permissionClass = "INTERNAL_SOVEREIGN";
            inputSchema = { id = "SCH-SET-IN-005"; name = "PermGateInput"; fields = [
                { fieldName = "permissionKey"; fieldType = "Text"; required = true; description = "Permission key to toggle" },
                { fieldName = "allow"; fieldType = "Bool"; required = true; description = "true=allow, false=deny" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-SET-OUT-005"; name = "PermGateOutput"; fields = [
                { fieldName = "permissionKey"; fieldType = "Text"; required = true; description = "Permission that was changed" },
                { fieldName = "isAllowed"; fieldType = "Bool"; required = true; description = "Current permission state" },
            ]; version = "1.0.0" };
            latencyExpectation = "<1ms"; costWeight = PHI;
            successContract = "Permission toggled, returns new state";
            failureContract = "Returns unchanged state with denial reason";
            houseId = "ORCH-HOUSE-006"; houseName = "DOMUS EXTERNAE";
            frequency_Hz = PHI_SQ; primitiveTrace = "PermGate->Distinction->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL_SOVEREIGN"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN";
        },
        {
            id = "SET-006"; name = "FREQUENCY-KNOB"; latinName = "TORQUATOR FREQUENTIAE";
            latinMotto = "Frequentia torquetur, harmonia mutatur.";
            latinMottoEN = "Frequency turned, harmony changes.";
            purpose = "Adjusts the operating frequency of a single organism layer — phi multiples only";
            domain = "AI_SETTINGS"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-SET-IN-006"; name = "FreqKnobInput"; fields = [
                { fieldName = "layerId"; fieldType = "Text"; required = true; description = "Layer to adjust frequency for" },
                { fieldName = "frequencyMultiplier"; fieldType = "Float"; required = true; description = "φ multiplier: 0.618, 1.0, 1.618, 2.618, 4.236" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-SET-OUT-006"; name = "FreqKnobOutput"; fields = [
                { fieldName = "layerId"; fieldType = "Text"; required = true; description = "Layer adjusted" },
                { fieldName = "newFrequency_Hz"; fieldType = "Float"; required = true; description = "New frequency in Hz" },
            ]; version = "1.0.0" };
            latencyExpectation = "<2ms"; costWeight = PHI_INV;
            successContract = "Frequency adjusted, returns new Hz value";
            failureContract = "Returns current frequency if multiplier not in phi set";
            houseId = "ORCH-HOUSE-004"; houseName = "DOMUS INTERNAE";
            frequency_Hz = PHI; primitiveTrace = "FreqKnob->Repetition->phi"; isAlwaysOn = false;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "SET-007"; name = "CONTEXT-WINDOW-SIZER"; latinName = "DIMENSATOR FENESTRAE CONTEXTUS";
            latinMotto = "Fenestra iusta, visio clara.";
            latinMottoEN = "Right window, clear vision.";
            purpose = "Sets the context window size in tokens for a single AI session — bounds how much history is visible";
            domain = "AI_SETTINGS"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-SET-IN-007"; name = "WindowInput"; fields = [
                { fieldName = "windowTokens"; fieldType = "Nat"; required = true; description = "Context window size in tokens" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-SET-OUT-007"; name = "WindowOutput"; fields = [
                { fieldName = "activeWindow"; fieldType = "Nat"; required = true; description = "Active window size" },
                { fieldName = "maxAllowed"; fieldType = "Nat"; required = true; description = "Maximum allowed window" },
            ]; version = "1.0.0" };
            latencyExpectation = "<1ms"; costWeight = PHI_INV;
            successContract = "Window set, returns active size and max allowed";
            failureContract = "Returns clamped window if requested exceeds max";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI; primitiveTrace = "ContextWindow->Memory->phi"; isAlwaysOn = false;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "SET-008"; name = "PERSONALITY-MIXER"; latinName = "MISCITOR PERSONAE";
            latinMotto = "Persona mixta, identitas una.";
            latinMottoEN = "Personality mixed, identity one.";
            purpose = "Sets the personality weight mix — adjusts ratios of analytical/creative/empathetic/direct traits";
            domain = "AI_SETTINGS"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-SET-IN-008"; name = "PersonalityInput"; fields = [
                { fieldName = "analyticalWeight"; fieldType = "Float"; required = true; description = "Analytical trait weight 0.0-1.0" },
                { fieldName = "creativeWeight"; fieldType = "Float"; required = true; description = "Creative trait weight 0.0-1.0" },
                { fieldName = "empatheticWeight"; fieldType = "Float"; required = true; description = "Empathetic trait weight 0.0-1.0" },
                { fieldName = "directWeight"; fieldType = "Float"; required = true; description = "Direct/concise trait weight 0.0-1.0" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-SET-OUT-008"; name = "PersonalityOutput"; fields = [
                { fieldName = "normalizedWeights"; fieldType = "Text"; required = true; description = "Normalized weights summing to 1.0" },
                { fieldName = "dominantTrait"; fieldType = "Text"; required = true; description = "Highest-weight trait name" },
            ]; version = "1.0.0" };
            latencyExpectation = "<1ms"; costWeight = PHI_INV;
            successContract = "Weights normalized and applied, returns dominant trait";
            failureContract = "Returns current weights if all inputs are zero";
            houseId = "ORCH-HOUSE-003"; houseName = "DOMUS USUI";
            frequency_Hz = PHI_INV; primitiveTrace = "Personality->Relation->phi"; isAlwaysOn = false;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "STANDARD";
        },
        {
            id = "SET-009"; name = "LANGUAGE-SELECTOR"; latinName = "SELECTOR LINGUAE";
            latinMotto = "Lingua electa, communicatio perfecta.";
            latinMottoEN = "Language chosen, communication perfected.";
            purpose = "Sets the primary response language for one AI session — ISO 639-1 code";
            domain = "AI_SETTINGS"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-SET-IN-009"; name = "LangInput"; fields = [
                { fieldName = "languageCode"; fieldType = "Text"; required = true; description = "ISO 639-1 language code (en, es, la, etc.)" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-SET-OUT-009"; name = "LangOutput"; fields = [
                { fieldName = "activeLanguage"; fieldType = "Text"; required = true; description = "Active language code" },
                { fieldName = "languageName"; fieldType = "Text"; required = true; description = "Human-readable language name" },
            ]; version = "1.0.0" };
            latencyExpectation = "<1ms"; costWeight = PHI_INV;
            successContract = "Language set, returns code and name";
            failureContract = "Returns 'en' default if code unrecognized";
            houseId = "ORCH-HOUSE-003"; houseName = "DOMUS USUI";
            frequency_Hz = PHI_INV; primitiveTrace = "Language->Language->phi"; isAlwaysOn = false;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "STANDARD";
        },
        {
            id = "SET-010"; name = "SAFETY-THRESHOLD"; latinName = "LIMEN SECURITATIS";
            latinMotto = "Limen positum, pericula exclusa.";
            latinMottoEN = "Threshold set, dangers excluded.";
            purpose = "Sets the safety filter threshold level — 1 (minimal) to 5 (maximum strictness)";
            domain = "AI_SETTINGS"; permissionClass = "INTERNAL_SOVEREIGN";
            inputSchema = { id = "SCH-SET-IN-010"; name = "SafetyInput"; fields = [
                { fieldName = "level"; fieldType = "Nat"; required = true; description = "Safety level 1-5" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-SET-OUT-010"; name = "SafetyOutput"; fields = [
                { fieldName = "activeLevel"; fieldType = "Nat"; required = true; description = "Active safety level" },
                { fieldName = "filterName"; fieldType = "Text"; required = true; description = "Filter name: MINIMAL/LOW/STANDARD/HIGH/MAXIMUM" },
            ]; version = "1.0.0" };
            latencyExpectation = "<1ms"; costWeight = PHI;
            successContract = "Safety level set, returns level and filter name";
            failureContract = "Returns STANDARD (3) if level out of 1-5 range";
            houseId = "ORCH-HOUSE-006"; houseName = "DOMUS EXTERNAE";
            frequency_Hz = PHI_SQ; primitiveTrace = "Safety->Distinction->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL_SOVEREIGN"; billingClass = "FREE_INTERNAL"; trustTier = "SOVEREIGN";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // IMAGE EXTRACTION — 10 narrow-scoped tools
    // Each extracts exactly ONE kind of data from an image
    // ═══════════════════════════════════════════════════════════════════════

    public let IMAGE_EXTRACTION_TOOLS : [NarrowTool] = [
        {
            id = "IMG-001"; name = "PIXEL-SCANNER"; latinName = "SCRUTATOR PIXELORUM";
            latinMotto = "Pixel scrutatur. Veritas in minimo.";
            latinMottoEN = "The pixel is scanned. Truth is in the smallest.";
            purpose = "Scans raw pixel data from an image blob — returns width, height, pixel count, bit depth";
            domain = "IMAGE_EXTRACTION"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-IMG-IN-001"; name = "PixelScanInput"; fields = [
                { fieldName = "imageBlob"; fieldType = "Blob"; required = true; description = "Raw image data" },
                { fieldName = "sampleRate"; fieldType = "Nat"; required = false; description = "Sample every Nth pixel (1=all)" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-IMG-OUT-001"; name = "PixelScanOutput"; fields = [
                { fieldName = "width"; fieldType = "Nat"; required = true; description = "Image width in pixels" },
                { fieldName = "height"; fieldType = "Nat"; required = true; description = "Image height in pixels" },
                { fieldName = "pixelCount"; fieldType = "Nat"; required = true; description = "Total pixel count" },
                { fieldName = "bitDepth"; fieldType = "Nat"; required = true; description = "Bits per pixel" },
            ]; version = "1.0.0" };
            latencyExpectation = "<10ms"; costWeight = PHI;
            successContract = "Returns dimensions and bit depth";
            failureContract = "Returns zero dimensions if blob is not valid image data";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI; primitiveTrace = "PixelScan->Field->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "METERED_PHI"; trustTier = "HIGH";
        },
        {
            id = "IMG-002"; name = "COLOR-MAPPER"; latinName = "CARTOGRAPHUS COLORUM";
            latinMotto = "Color mappatur. Spectrum revelatur.";
            latinMottoEN = "Color is mapped. The spectrum is revealed.";
            purpose = "Maps the dominant color frequencies in an image — returns top-N hex values with percentage";
            domain = "IMAGE_EXTRACTION"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-IMG-IN-002"; name = "ColorMapInput"; fields = [
                { fieldName = "imageBlob"; fieldType = "Blob"; required = true; description = "Raw image data" },
                { fieldName = "topN"; fieldType = "Nat"; required = false; description = "How many dominant colors to return (default 5)" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-IMG-OUT-002"; name = "ColorMapOutput"; fields = [
                { fieldName = "dominantColors"; fieldType = "[Text]"; required = true; description = "Hex color codes sorted by frequency" },
                { fieldName = "colorCount"; fieldType = "Nat"; required = true; description = "Total unique colors detected" },
            ]; version = "1.0.0" };
            latencyExpectation = "<20ms"; costWeight = PHI;
            successContract = "Returns top-N colors with hex codes";
            failureContract = "Returns empty array if image unreadable";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI; primitiveTrace = "ColorMap->Distinction->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "METERED_PHI"; trustTier = "HIGH";
        },
        {
            id = "IMG-003"; name = "EDGE-DETECTOR"; latinName = "DETECTOR LIMINUM";
            latinMotto = "Limen detectum. Forma emergit.";
            latinMottoEN = "Edge detected. Form emerges.";
            purpose = "Detects edges and boundaries in an image — returns edge count, density, and sharpness score";
            domain = "IMAGE_EXTRACTION"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-IMG-IN-003"; name = "EdgeInput"; fields = [
                { fieldName = "imageBlob"; fieldType = "Blob"; required = true; description = "Raw image data" },
                { fieldName = "sensitivity"; fieldType = "Float"; required = false; description = "Edge sensitivity 0.0-1.0 (default 0.5)" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-IMG-OUT-003"; name = "EdgeOutput"; fields = [
                { fieldName = "edgeCount"; fieldType = "Nat"; required = true; description = "Number of edges detected" },
                { fieldName = "edgeDensity"; fieldType = "Float"; required = true; description = "Edge density per 1000 pixels" },
                { fieldName = "sharpnessScore"; fieldType = "Float"; required = true; description = "Overall sharpness 0.0-1.0" },
            ]; version = "1.0.0" };
            latencyExpectation = "<30ms"; costWeight = PHI_SQ;
            successContract = "Returns edge metrics with sharpness score";
            failureContract = "Returns zero edges if image too small or corrupt";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI; primitiveTrace = "EdgeDetect->Distinction->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "METERED_PHI"; trustTier = "HIGH";
        },
        {
            id = "IMG-004"; name = "GLYPH-READER"; latinName = "LECTOR GLYPHORUM";
            latinMotto = "Glyphus lectus. Significatio extracta.";
            latinMottoEN = "Glyph read. Meaning extracted.";
            purpose = "Reads symbolic glyphs and text characters from an image region — OCR for single glyph zones";
            domain = "IMAGE_EXTRACTION"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-IMG-IN-004"; name = "GlyphInput"; fields = [
                { fieldName = "imageBlob"; fieldType = "Blob"; required = true; description = "Raw image data" },
                { fieldName = "regionX"; fieldType = "Nat"; required = false; description = "X offset of region to read" },
                { fieldName = "regionY"; fieldType = "Nat"; required = false; description = "Y offset of region to read" },
                { fieldName = "regionW"; fieldType = "Nat"; required = false; description = "Width of region to read" },
                { fieldName = "regionH"; fieldType = "Nat"; required = false; description = "Height of region to read" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-IMG-OUT-004"; name = "GlyphOutput"; fields = [
                { fieldName = "glyphsFound"; fieldType = "Nat"; required = true; description = "Number of glyphs found" },
                { fieldName = "extractedText"; fieldType = "Text"; required = true; description = "Extracted text content" },
                { fieldName = "confidence"; fieldType = "Float"; required = true; description = "OCR confidence 0.0-1.0" },
            ]; version = "1.0.0" };
            latencyExpectation = "<50ms"; costWeight = PHI_SQ;
            successContract = "Returns extracted text with confidence score";
            failureContract = "Returns empty text with confidence 0 if no glyphs found";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI; primitiveTrace = "GlyphRead->Language->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "METERED_PHI"; trustTier = "HIGH";
        },
        {
            id = "IMG-005"; name = "LAYER-PEELER"; latinName = "DECORTICATOR STRATORUM";
            latinMotto = "Stratum decorticatum. Profunditas revelata.";
            latinMottoEN = "Layer peeled. Depth revealed.";
            purpose = "Separates an image into distinct layers — foreground, midground, background, alpha channel";
            domain = "IMAGE_EXTRACTION"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-IMG-IN-005"; name = "LayerInput"; fields = [
                { fieldName = "imageBlob"; fieldType = "Blob"; required = true; description = "Raw image data" },
                { fieldName = "maxLayers"; fieldType = "Nat"; required = false; description = "Maximum layers to separate (default 4)" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-IMG-OUT-005"; name = "LayerOutput"; fields = [
                { fieldName = "layerCount"; fieldType = "Nat"; required = true; description = "Number of layers separated" },
                { fieldName = "layerNames"; fieldType = "[Text]"; required = true; description = "Layer identifiers" },
                { fieldName = "hasAlpha"; fieldType = "Bool"; required = true; description = "Whether alpha channel exists" },
            ]; version = "1.0.0" };
            latencyExpectation = "<40ms"; costWeight = PHI_SQ;
            successContract = "Returns layer names and alpha status";
            failureContract = "Returns single-layer result if separation impossible";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI; primitiveTrace = "LayerPeel->Field->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "METERED_PHI"; trustTier = "HIGH";
        },
        {
            id = "IMG-006"; name = "METADATA-HARVESTER"; latinName = "MESSOR METADATORUM";
            latinMotto = "Metadatum messum. Historia nota.";
            latinMottoEN = "Metadata harvested. History known.";
            purpose = "Extracts EXIF/XMP metadata from an image — camera, date, GPS, dimensions, format";
            domain = "IMAGE_EXTRACTION"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-IMG-IN-006"; name = "MetaInput"; fields = [
                { fieldName = "imageBlob"; fieldType = "Blob"; required = true; description = "Raw image data" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-IMG-OUT-006"; name = "MetaOutput"; fields = [
                { fieldName = "format"; fieldType = "Text"; required = true; description = "Image format (PNG/JPEG/WEBP/etc)" },
                { fieldName = "metadataFields"; fieldType = "Nat"; required = true; description = "Number of metadata fields found" },
                { fieldName = "hasGPS"; fieldType = "Bool"; required = true; description = "Whether GPS data exists" },
                { fieldName = "createdDate"; fieldType = "Text"; required = true; description = "Creation date if available, else empty" },
            ]; version = "1.0.0" };
            latencyExpectation = "<5ms"; costWeight = PHI;
            successContract = "Returns format, metadata count, GPS flag, creation date";
            failureContract = "Returns format=UNKNOWN with zero fields if unreadable";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI; primitiveTrace = "MetaHarvest->Memory->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "METERED_PHI"; trustTier = "HIGH";
        },
        {
            id = "IMG-007"; name = "PATTERN-ISOLATOR"; latinName = "SEPARATOR EXEMPLARIUM";
            latinMotto = "Exemplar separatum. Repetitio inventa.";
            latinMottoEN = "Pattern isolated. Repetition found.";
            purpose = "Isolates repeating visual patterns in an image — detects tiling, symmetry, and fractal motifs";
            domain = "IMAGE_EXTRACTION"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-IMG-IN-007"; name = "PatIsoInput"; fields = [
                { fieldName = "imageBlob"; fieldType = "Blob"; required = true; description = "Raw image data" },
                { fieldName = "minRepeat"; fieldType = "Nat"; required = false; description = "Minimum repeat count to qualify (default 2)" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-IMG-OUT-007"; name = "PatIsoOutput"; fields = [
                { fieldName = "patternsFound"; fieldType = "Nat"; required = true; description = "Distinct repeating patterns found" },
                { fieldName = "dominantSymmetry"; fieldType = "Text"; required = true; description = "Dominant symmetry type: RADIAL/MIRROR/TILE/FRACTAL/NONE" },
                { fieldName = "repetitionScore"; fieldType = "Float"; required = true; description = "Repetition density 0.0-1.0" },
            ]; version = "1.0.0" };
            latencyExpectation = "<60ms"; costWeight = PHI_SQ;
            successContract = "Returns pattern count, dominant symmetry, repetition score";
            failureContract = "Returns 0 patterns with NONE symmetry if image too noisy";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI; primitiveTrace = "PatternIso->Repetition->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "METERED_PHI"; trustTier = "HIGH";
        },
        {
            id = "IMG-008"; name = "DEPTH-PROBER"; latinName = "EXPLORATOR PROFUNDITATIS";
            latinMotto = "Profunditas explorata. Spatium cognitum.";
            latinMottoEN = "Depth probed. Space known.";
            purpose = "Estimates depth information from a 2D image — returns near/far planes and depth gradient";
            domain = "IMAGE_EXTRACTION"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-IMG-IN-008"; name = "DepthProbeInput"; fields = [
                { fieldName = "imageBlob"; fieldType = "Blob"; required = true; description = "Raw image data" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-IMG-OUT-008"; name = "DepthProbeOutput"; fields = [
                { fieldName = "nearPlane"; fieldType = "Float"; required = true; description = "Estimated near depth plane (relative 0.0-1.0)" },
                { fieldName = "farPlane"; fieldType = "Float"; required = true; description = "Estimated far depth plane (relative 0.0-1.0)" },
                { fieldName = "depthGradient"; fieldType = "Text"; required = true; description = "Gradient direction: TOP_TO_BOTTOM/LEFT_TO_RIGHT/CENTER_OUT/FLAT" },
            ]; version = "1.0.0" };
            latencyExpectation = "<40ms"; costWeight = PHI_SQ;
            successContract = "Returns near/far planes and gradient direction";
            failureContract = "Returns FLAT gradient with planes at 0.5 if estimation fails";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI; primitiveTrace = "DepthProbe->Field->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "METERED_PHI"; trustTier = "HIGH";
        },
        {
            id = "IMG-009"; name = "FREQUENCY-SLICER"; latinName = "SECTOR FREQUENTIARUM";
            latinMotto = "Frequentia secta. Signalum purum.";
            latinMottoEN = "Frequency sliced. Signal pure.";
            purpose = "Slices image into frequency bands — separates low-frequency (shapes) from high-frequency (details)";
            domain = "IMAGE_EXTRACTION"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-IMG-IN-009"; name = "FreqSliceInput"; fields = [
                { fieldName = "imageBlob"; fieldType = "Blob"; required = true; description = "Raw image data" },
                { fieldName = "bands"; fieldType = "Nat"; required = false; description = "Number of frequency bands (default 3: low/mid/high)" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-IMG-OUT-009"; name = "FreqSliceOutput"; fields = [
                { fieldName = "bandCount"; fieldType = "Nat"; required = true; description = "Number of frequency bands extracted" },
                { fieldName = "lowFreqEnergy"; fieldType = "Float"; required = true; description = "Energy in low-frequency band 0.0-1.0" },
                { fieldName = "highFreqEnergy"; fieldType = "Float"; required = true; description = "Energy in high-frequency band 0.0-1.0" },
            ]; version = "1.0.0" };
            latencyExpectation = "<30ms"; costWeight = PHI_SQ;
            successContract = "Returns band count and energy distribution";
            failureContract = "Returns single band with energy 1.0 if decomposition fails";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI; primitiveTrace = "FreqSlice->Repetition->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "METERED_PHI"; trustTier = "HIGH";
        },
        {
            id = "IMG-010"; name = "THUMBNAIL-FORGER"; latinName = "FABRICATOR IMAGUNCULAE";
            latinMotto = "Imaguncula fabricata. Praevius paratus.";
            latinMottoEN = "Thumbnail forged. Preview ready.";
            purpose = "Generates a fixed-size thumbnail from an image — exactly one output size, crops to center";
            domain = "IMAGE_EXTRACTION"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-IMG-IN-010"; name = "ThumbInput"; fields = [
                { fieldName = "imageBlob"; fieldType = "Blob"; required = true; description = "Raw image data" },
                { fieldName = "targetSize"; fieldType = "Nat"; required = true; description = "Square thumbnail side in pixels (e.g. 128, 256)" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-IMG-OUT-010"; name = "ThumbOutput"; fields = [
                { fieldName = "thumbnailSize"; fieldType = "Nat"; required = true; description = "Actual thumbnail side in pixels" },
                { fieldName = "byteSize"; fieldType = "Nat"; required = true; description = "Thumbnail data size in bytes" },
                { fieldName = "cropped"; fieldType = "Bool"; required = true; description = "Whether image was cropped to fit" },
            ]; version = "1.0.0" };
            latencyExpectation = "<15ms"; costWeight = PHI;
            successContract = "Returns thumbnail metadata with crop flag";
            failureContract = "Returns 0 size if source image is invalid";
            houseId = "ORCH-HOUSE-009"; houseName = "DOMUS COGNITAE";
            frequency_Hz = PHI; primitiveTrace = "Thumbnail->Field->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "METERED_PHI"; trustTier = "HIGH";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // ANALYSIS — 5 narrow-scoped tools
    // Each measures exactly ONE metric
    // ═══════════════════════════════════════════════════════════════════════

    public let ANALYSIS_TOOLS : [NarrowTool] = [
        {
            id = "ANL-001"; name = "HASH-COMPARATOR"; latinName = "COMPARATOR SIGNACULI";
            latinMotto = "Duo signacula comparata. Veritas cognita.";
            latinMottoEN = "Two hashes compared. Truth known.";
            purpose = "Compares two content hashes and returns match/mismatch with bit-distance";
            domain = "ANALYSIS"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-ANL-IN-001"; name = "HashCompInput"; fields = [
                { fieldName = "hashA"; fieldType = "Text"; required = true; description = "First hash to compare" },
                { fieldName = "hashB"; fieldType = "Text"; required = true; description = "Second hash to compare" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-ANL-OUT-001"; name = "HashCompOutput"; fields = [
                { fieldName = "isMatch"; fieldType = "Bool"; required = true; description = "Whether hashes match exactly" },
                { fieldName = "bitDistance"; fieldType = "Nat"; required = true; description = "Hamming distance in bits" },
                { fieldName = "similarity"; fieldType = "Float"; required = true; description = "Similarity score 0.0-1.0" },
            ]; version = "1.0.0" };
            latencyExpectation = "<1ms"; costWeight = PHI_INV;
            successContract = "Returns match boolean and bit distance";
            failureContract = "Returns isMatch=false with distance=max if hash format invalid";
            houseId = "ORCH-HOUSE-005"; houseName = "DOMUS PROFUNDAE";
            frequency_Hz = PHI; primitiveTrace = "HashComp->Logic->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "ANL-002"; name = "DRIFT-MEASURER"; latinName = "METITOR DERIVATIONIS";
            latinMotto = "Derivatio metitur. Deviatio cognoscitur.";
            latinMottoEN = "Drift is measured. Deviation is known.";
            purpose = "Measures how far a current state has drifted from a known baseline — returns delta percentage";
            domain = "ANALYSIS"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-ANL-IN-002"; name = "DriftInput"; fields = [
                { fieldName = "baselineKey"; fieldType = "Text"; required = true; description = "Baseline state identifier" },
                { fieldName = "currentKey"; fieldType = "Text"; required = true; description = "Current state identifier" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-ANL-OUT-002"; name = "DriftOutput"; fields = [
                { fieldName = "driftPercent"; fieldType = "Float"; required = true; description = "Drift percentage from baseline" },
                { fieldName = "direction"; fieldType = "Text"; required = true; description = "Drift direction: POSITIVE/NEGATIVE/STABLE" },
            ]; version = "1.0.0" };
            latencyExpectation = "<5ms"; costWeight = PHI;
            successContract = "Returns drift percentage and direction";
            failureContract = "Returns 0.0 drift STABLE if baseline not found";
            houseId = "ORCH-HOUSE-005"; houseName = "DOMUS PROFUNDAE";
            frequency_Hz = PHI; primitiveTrace = "Drift->Repetition->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "ANL-003"; name = "LOAD-WEIGHER"; latinName = "PONDERATOR ONERIS";
            latinMotto = "Onus ponderatum. Capacitas nota.";
            latinMottoEN = "Load weighed. Capacity known.";
            purpose = "Weighs current computational load on one specific house — returns utilization percentage";
            domain = "ANALYSIS"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-ANL-IN-003"; name = "LoadInput"; fields = [
                { fieldName = "houseId"; fieldType = "Text"; required = true; description = "House to weigh load for" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-ANL-OUT-003"; name = "LoadOutput"; fields = [
                { fieldName = "utilization"; fieldType = "Float"; required = true; description = "Load utilization 0.0-1.0" },
                { fieldName = "headroom"; fieldType = "Float"; required = true; description = "Remaining headroom 0.0-1.0" },
            ]; version = "1.0.0" };
            latencyExpectation = "<2ms"; costWeight = PHI_INV;
            successContract = "Returns utilization and headroom for the specified house";
            failureContract = "Returns utilization=0 headroom=1 if house ID unknown";
            houseId = "ORCH-HOUSE-010"; houseName = "DOMUS ORCHESTRATORUM";
            frequency_Hz = PHI; primitiveTrace = "LoadWeigh->Number->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "ANL-004"; name = "ENTROPY-GAUGE"; latinName = "METRUM ENTROPIAE";
            latinMotto = "Entropia metitur. Ordo vel chaos cognoscitur.";
            latinMottoEN = "Entropy is gauged. Order or chaos is known.";
            purpose = "Gauges entropy level of a data segment — returns bits-of-entropy and randomness score";
            domain = "ANALYSIS"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-ANL-IN-004"; name = "EntropyInput"; fields = [
                { fieldName = "dataKey"; fieldType = "Text"; required = true; description = "Data segment identifier to gauge" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-ANL-OUT-004"; name = "EntropyOutput"; fields = [
                { fieldName = "entropyBits"; fieldType = "Float"; required = true; description = "Shannon entropy in bits" },
                { fieldName = "randomnessScore"; fieldType = "Float"; required = true; description = "Randomness score 0.0 (ordered) to 1.0 (chaotic)" },
            ]; version = "1.0.0" };
            latencyExpectation = "<3ms"; costWeight = PHI;
            successContract = "Returns entropy bits and randomness score";
            failureContract = "Returns 0.0 entropy if data segment not found";
            houseId = "ORCH-HOUSE-005"; houseName = "DOMUS PROFUNDAE";
            frequency_Hz = PHI; primitiveTrace = "Entropy->Number->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "ANL-005"; name = "LATENCY-TIMER"; latinName = "CHRONOMETRUM MORAE";
            latinMotto = "Mora chronometrata. Velocitas cognita.";
            latinMottoEN = "Latency timed. Speed known.";
            purpose = "Times the round-trip latency of one specific endpoint call — returns milliseconds and percentile";
            domain = "ANALYSIS"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-ANL-IN-005"; name = "LatencyInput"; fields = [
                { fieldName = "endpointId"; fieldType = "Text"; required = true; description = "Endpoint to time" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-ANL-OUT-005"; name = "LatencyOutput"; fields = [
                { fieldName = "latencyMs"; fieldType = "Float"; required = true; description = "Latency in milliseconds" },
                { fieldName = "p99Ms"; fieldType = "Float"; required = true; description = "99th percentile latency" },
            ]; version = "1.0.0" };
            latencyExpectation = "<1ms"; costWeight = PHI_INV;
            successContract = "Returns latency in ms and p99";
            failureContract = "Returns -1.0 latency if endpoint unreachable";
            houseId = "ORCH-HOUSE-010"; houseName = "DOMUS ORCHESTRATORUM";
            frequency_Hz = PHI_SQ; primitiveTrace = "Latency->Number->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // UPKEEP — 5 narrow-scoped tools
    // Each performs exactly ONE maintenance action
    // ═══════════════════════════════════════════════════════════════════════

    public let UPKEEP_TOOLS : [NarrowTool] = [
        {
            id = "UPK-001"; name = "GARBAGE-SWEEPER"; latinName = "VERRITOR SPURCITIAE";
            latinMotto = "Spurcitia versa. Memoria liberata.";
            latinMottoEN = "Garbage swept. Memory freed.";
            purpose = "Sweeps and frees unused memory allocations in one specific canister — returns bytes freed";
            domain = "UPKEEP"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-UPK-IN-001"; name = "SweepInput"; fields = [
                { fieldName = "canisterId"; fieldType = "Text"; required = true; description = "Canister to sweep" },
                { fieldName = "aggressiveness"; fieldType = "Nat"; required = false; description = "Sweep level 1-3 (1=gentle, 3=aggressive)" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-UPK-OUT-001"; name = "SweepOutput"; fields = [
                { fieldName = "bytesFreed"; fieldType = "Nat"; required = true; description = "Bytes freed" },
                { fieldName = "objectsReclaimed"; fieldType = "Nat"; required = true; description = "Objects reclaimed" },
            ]; version = "1.0.0" };
            latencyExpectation = "<100ms"; costWeight = PHI;
            successContract = "Returns bytes freed and objects reclaimed";
            failureContract = "Returns 0 freed if canister not found or locked";
            houseId = "ORCH-HOUSE-010"; houseName = "DOMUS ORCHESTRATORUM";
            frequency_Hz = PHI_INV; primitiveTrace = "Sweep->Field->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "UPK-002"; name = "INDEX-REBUILDER"; latinName = "RECONSTRUCTOR INDICIS";
            latinMotto = "Index reconstructus. Quaestio velocior.";
            latinMottoEN = "Index rebuilt. Search faster.";
            purpose = "Rebuilds one specific search index from scratch — memory temple, tool registry, or package index";
            domain = "UPKEEP"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-UPK-IN-002"; name = "IndexInput"; fields = [
                { fieldName = "indexName"; fieldType = "Text"; required = true; description = "Index to rebuild: MEMORY/TOOLS/PACKAGES/AGENTS" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-UPK-OUT-002"; name = "IndexOutput"; fields = [
                { fieldName = "entriesIndexed"; fieldType = "Nat"; required = true; description = "Total entries indexed" },
                { fieldName = "rebuildTimeMs"; fieldType = "Float"; required = true; description = "Rebuild time in milliseconds" },
            ]; version = "1.0.0" };
            latencyExpectation = "<500ms"; costWeight = PHI_SQ;
            successContract = "Index rebuilt, returns entry count and time";
            failureContract = "Returns 0 entries if index name unrecognized";
            houseId = "ORCH-HOUSE-010"; houseName = "DOMUS ORCHESTRATORUM";
            frequency_Hz = PHI_INV; primitiveTrace = "IndexRebuild->Memory->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "UPK-003"; name = "STALE-PRUNER"; latinName = "PUTATOR OBSOLETORUM";
            latinMotto = "Obsoletum putatum. Viride crescit.";
            latinMottoEN = "Stale pruned. Fresh grows.";
            purpose = "Prunes stale entries from one cache or registry — removes entries older than threshold";
            domain = "UPKEEP"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-UPK-IN-003"; name = "PruneInput"; fields = [
                { fieldName = "registryName"; fieldType = "Text"; required = true; description = "Registry or cache to prune" },
                { fieldName = "maxAgeBeats"; fieldType = "Nat"; required = true; description = "Maximum age in heartbeats before pruning" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-UPK-OUT-003"; name = "PruneOutput"; fields = [
                { fieldName = "entriesPruned"; fieldType = "Nat"; required = true; description = "Entries pruned" },
                { fieldName = "entriesRetained"; fieldType = "Nat"; required = true; description = "Entries retained" },
            ]; version = "1.0.0" };
            latencyExpectation = "<50ms"; costWeight = PHI;
            successContract = "Returns pruned and retained counts";
            failureContract = "Returns 0 pruned if registry not found";
            houseId = "ORCH-HOUSE-010"; houseName = "DOMUS ORCHESTRATORUM";
            frequency_Hz = PHI_INV; primitiveTrace = "Prune->Memory->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "UPK-004"; name = "HEALTH-PINGER"; latinName = "PULSATOR SANITATIS";
            latinMotto = "Sanitas pulsata. Status cognitus.";
            latinMottoEN = "Health pinged. Status known.";
            purpose = "Pings one specific endpoint or house and returns alive/dead with response time";
            domain = "UPKEEP"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-UPK-IN-004"; name = "PingInput"; fields = [
                { fieldName = "targetId"; fieldType = "Text"; required = true; description = "House or endpoint ID to ping" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-UPK-OUT-004"; name = "PingOutput"; fields = [
                { fieldName = "isAlive"; fieldType = "Bool"; required = true; description = "Whether target responded" },
                { fieldName = "responseMs"; fieldType = "Float"; required = true; description = "Response time in milliseconds" },
            ]; version = "1.0.0" };
            latencyExpectation = "<5ms"; costWeight = PHI_INV;
            successContract = "Returns alive status and response time";
            failureContract = "Returns isAlive=false with responseMs=-1";
            houseId = "ORCH-HOUSE-010"; houseName = "DOMUS ORCHESTRATORUM";
            frequency_Hz = PHI; primitiveTrace = "HealthPing->Relation->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
        {
            id = "UPK-005"; name = "DEFRAG-RUNNER"; latinName = "CURSOR DEFRAGMENTATIONIS";
            latinMotto = "Fragmenta composita. Continuitas restaurata.";
            latinMottoEN = "Fragments composed. Continuity restored.";
            purpose = "Defragments one specific stable memory region — compacts scattered allocations into contiguous blocks";
            domain = "UPKEEP"; permissionClass = "INTERNAL";
            inputSchema = { id = "SCH-UPK-IN-005"; name = "DefragInput"; fields = [
                { fieldName = "memoryRegion"; fieldType = "Text"; required = true; description = "Memory region identifier to defragment" },
            ]; version = "1.0.0" };
            outputSchema = { id = "SCH-UPK-OUT-005"; name = "DefragOutput"; fields = [
                { fieldName = "fragmentsBefore"; fieldType = "Nat"; required = true; description = "Fragment count before" },
                { fieldName = "fragmentsAfter"; fieldType = "Nat"; required = true; description = "Fragment count after" },
                { fieldName = "compactionRatio"; fieldType = "Float"; required = true; description = "Compaction ratio achieved" },
            ]; version = "1.0.0" };
            latencyExpectation = "<200ms"; costWeight = PHI_SQ;
            successContract = "Returns before/after fragment counts and compaction ratio";
            failureContract = "Returns fragmentsBefore=fragmentsAfter if region locked";
            houseId = "ORCH-HOUSE-010"; houseName = "DOMUS ORCHESTRATORUM";
            frequency_Hz = PHI_INV; primitiveTrace = "Defrag->Field->phi"; isAlwaysOn = true;
            version = "1.0.0"; exposureTier = "INTERNAL"; billingClass = "FREE_INTERNAL"; trustTier = "HIGH";
        },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // UPKEEP CYCLES — scheduled maintenance intervals
    // ═══════════════════════════════════════════════════════════════════════

    public let ALL_UPKEEP_CYCLES : [UpkeepCycle] = [
        { id = "CYC-001"; name = "GARBAGE CYCLE"; latinName = "CYCLUS SPURCITIAE"; intervalBeats = 1000;
          purpose = "Runs GARBAGE-SWEEPER across all canisters every 1000 beats"; toolId = "UPK-001" },
        { id = "CYC-002"; name = "INDEX CYCLE"; latinName = "CYCLUS INDICIS"; intervalBeats = 5000;
          purpose = "Runs INDEX-REBUILDER on all 4 indices every 5000 beats"; toolId = "UPK-002" },
        { id = "CYC-003"; name = "PRUNE CYCLE"; latinName = "CYCLUS PUTATIONIS"; intervalBeats = 2000;
          purpose = "Runs STALE-PRUNER on caches every 2000 beats"; toolId = "UPK-003" },
        { id = "CYC-004"; name = "HEALTH CYCLE"; latinName = "CYCLUS SANITATIS"; intervalBeats = 100;
          purpose = "Runs HEALTH-PINGER on all 10 houses every 100 beats"; toolId = "UPK-004" },
        { id = "CYC-005"; name = "DEFRAG CYCLE"; latinName = "CYCLUS DEFRAGMENTATIONIS"; intervalBeats = 10000;
          purpose = "Runs DEFRAG-RUNNER on all memory regions every 10000 beats"; toolId = "UPK-005" },
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // COMBINED TOOL REGISTRY
    // ═══════════════════════════════════════════════════════════════════════

    public let ALL_NARROW_TOOLS : [NarrowTool] = [
        AI_SETTINGS_TOOLS[0],  AI_SETTINGS_TOOLS[1],  AI_SETTINGS_TOOLS[2],
        AI_SETTINGS_TOOLS[3],  AI_SETTINGS_TOOLS[4],  AI_SETTINGS_TOOLS[5],
        AI_SETTINGS_TOOLS[6],  AI_SETTINGS_TOOLS[7],  AI_SETTINGS_TOOLS[8],
        AI_SETTINGS_TOOLS[9],
        IMAGE_EXTRACTION_TOOLS[0], IMAGE_EXTRACTION_TOOLS[1], IMAGE_EXTRACTION_TOOLS[2],
        IMAGE_EXTRACTION_TOOLS[3], IMAGE_EXTRACTION_TOOLS[4], IMAGE_EXTRACTION_TOOLS[5],
        IMAGE_EXTRACTION_TOOLS[6], IMAGE_EXTRACTION_TOOLS[7], IMAGE_EXTRACTION_TOOLS[8],
        IMAGE_EXTRACTION_TOOLS[9],
        ANALYSIS_TOOLS[0], ANALYSIS_TOOLS[1], ANALYSIS_TOOLS[2],
        ANALYSIS_TOOLS[3], ANALYSIS_TOOLS[4],
        UPKEEP_TOOLS[0], UPKEEP_TOOLS[1], UPKEEP_TOOLS[2],
        UPKEEP_TOOLS[3], UPKEEP_TOOLS[4],
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func summary() : {
        totalNarrowTools: Nat;
        aiSettingsCount: Nat;
        imageExtractionCount: Nat;
        analysisCount: Nat;
        upkeepCount: Nat;
        upkeepCycles: Nat;
        doctrine: Text;
    } {
        {
            totalNarrowTools = ALL_NARROW_TOOLS.size();
            aiSettingsCount = AI_SETTINGS_TOOLS.size();
            imageExtractionCount = IMAGE_EXTRACTION_TOOLS.size();
            analysisCount = ANALYSIS_TOOLS.size();
            upkeepCount = UPKEEP_TOOLS.size();
            upkeepCycles = ALL_UPKEEP_CYCLES.size();
            doctrine = MODULE_DOCTRINE;
        }
    };

    public func getToolsByDomain(domain: Text) : [NarrowTool] {
        Array.filter<NarrowTool>(ALL_NARROW_TOOLS, func(t) { t.domain == domain })
    };

    public func getTool(toolId: Text) : ?NarrowTool {
        Array.find<NarrowTool>(ALL_NARROW_TOOLS, func(t) { t.id == toolId })
    };

    // ═══════════════════════════════════════════════════════════════════════
    // MANIFEST RENDERER
    // ═══════════════════════════════════════════════════════════════════════

    public func renderManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════╗\n";
        m #= "║  INSTRUMENTA PRAECISA ORGANISMI                           ║\n";
        m #= "║  AI SETTINGS · IMAGE EXTRACTOR · ANALYSIS · UPKEEP        ║\n";
        m #= "║  " # MODULE_DOCTRINE # "\n";
        m #= "╚══════════════════════════════════════════════════════════╝\n\n";

        m #= "═══ AI SETTINGS — 10 narrow-scoped tools ═══\n\n";
        for (t in AI_SETTINGS_TOOLS.vals()) {
            m #= "── " # t.name # " — " # t.latinName # " ──\n";
            m #= "  \"" # t.latinMotto # "\"\n";
            m #= "  Purpose: " # t.purpose # "\n";
            m #= "  Latency: " # t.latencyExpectation # " | Tier: " # t.exposureTier # "\n";
            m #= "  In: " # t.inputSchema.name # " | Out: " # t.outputSchema.name # "\n";
            m #= "  ✓ " # t.successContract # "\n";
            m #= "  ✗ " # t.failureContract # "\n\n";
        };

        m #= "═══ IMAGE EXTRACTION — 10 narrow-scoped tools ═══\n\n";
        for (t in IMAGE_EXTRACTION_TOOLS.vals()) {
            m #= "── " # t.name # " — " # t.latinName # " ──\n";
            m #= "  \"" # t.latinMotto # "\"\n";
            m #= "  Purpose: " # t.purpose # "\n";
            m #= "  Latency: " # t.latencyExpectation # " | Tier: " # t.exposureTier # "\n";
            m #= "  In: " # t.inputSchema.name # " | Out: " # t.outputSchema.name # "\n";
            m #= "  ✓ " # t.successContract # "\n";
            m #= "  ✗ " # t.failureContract # "\n\n";
        };

        m #= "═══ ANALYSIS — 5 narrow-scoped tools ═══\n\n";
        for (t in ANALYSIS_TOOLS.vals()) {
            m #= "── " # t.name # " — " # t.latinName # " ──\n";
            m #= "  \"" # t.latinMotto # "\"\n";
            m #= "  Purpose: " # t.purpose # "\n";
            m #= "  Latency: " # t.latencyExpectation # "\n";
            m #= "  ✓ " # t.successContract # "\n";
            m #= "  ✗ " # t.failureContract # "\n\n";
        };

        m #= "═══ UPKEEP — 5 narrow-scoped tools ═══\n\n";
        for (t in UPKEEP_TOOLS.vals()) {
            m #= "── " # t.name # " — " # t.latinName # " ──\n";
            m #= "  \"" # t.latinMotto # "\"\n";
            m #= "  Purpose: " # t.purpose # "\n";
            m #= "  Latency: " # t.latencyExpectation # "\n";
            m #= "  ✓ " # t.successContract # "\n";
            m #= "  ✗ " # t.failureContract # "\n\n";
        };

        m #= "═══ UPKEEP CYCLES — 5 scheduled intervals ═══\n\n";
        for (c in ALL_UPKEEP_CYCLES.vals()) {
            m #= "  " # c.id # " " # c.name # " (" # c.latinName # ") — every " # Nat.toText(c.intervalBeats) # " beats\n";
            m #= "    " # c.purpose # "\n\n";
        };

        m #= "TOTAL: " # Nat.toText(ALL_NARROW_TOOLS.size()) # " narrow-scoped callable tools\n";
        m #= "ROOT: φ = (1+√5)/2 = 1.618033988749895\n";
        m
    };
}
