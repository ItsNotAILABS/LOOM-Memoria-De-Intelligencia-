/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║          EXTENDED SDK AIs — ORGANISMI SDK EXTENSI                           ║
 * ║                                                                              ║
 * ║  "SDK angustum, potentia infinita."                                         ║
 * ║  (A narrow SDK, infinite power.)                                            ║
 * ║                                                                              ║
 * ║  8 NEW SDK AI ORGANISMS — each with a single, precise domain:              ║
 * ║    1. VISIO    — image/vision processing (reads, classifies, transforms)    ║
 * ║    2. LEXIS    — text/NLP (tokenizes, parses, classifies text)              ║
 * ║    3. NUMERUS  — numerical computation (matrix ops, statistics, φ-math)     ║
 * ║    4. SONUS    — audio processing (waveform, spectrum, beat detection)      ║
 * ║    5. CUSTOS   — security guard (key rotation, seal stamping, auth check)   ║
 * ║    6. RETICULUM — networking (ping, route, DNS resolve, bandwidth test)     ║
 * ║    7. SCHEDULA — task scheduling (cron, delay, queue, retry)                ║
 * ║    8. FABRICATOR — build/deploy (compile, bundle, deploy, rollback)         ║
 * ║                                                                              ║
 * ║  Each organism has:                                                          ║
 * ║    - 5 sub-organs (precise functional units)                                 ║
 * ║    - Terminal grammar (3-5 commands, no overlap)                             ║
 * ║    - Runtime truth (version, lineage, status)                                ║
 * ║    - Callable interface registry                                             ║
 * ║    - φ Hz heartbeat                                                          ║
 * ║                                                                              ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX  ║
 * ║  L-130 COMPLIANT — Every organism traces to primitive φ                      ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

module ExtendedSDKAIs {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;
    public let PHI_CUBE : Float = 4.2360679774997896;
    public let PHI_INV : Float = 0.6180339887498949;

    public let MODULE_DOCTRINE : Text = "SDK angustum, potentia infinita.";
    public let MODULE_DOCTRINE_EN : Text = "A narrow SDK, infinite power.";

    // ═══════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════

    public type SubOrgan = {
        id: Text;
        name: Text;
        latinName: Text;
        role: Text;
        isAlwaysOn: Bool;
    };

    public type TerminalGrammar = {
        prefix: Text;
        commands: [Text];
        aliases: [Text];
    };

    public type RuntimeTruth = {
        version: Text;
        lineageHash: Text;
        renderabilityStatus: Text;
        doctrineClass: Text;
    };

    public type CallableEntry = {
        callId: Text;
        name: Text;
        purpose: Text;
        inputFields: [Text];
        outputFields: [Text];
        latency: Text;
    };

    public type ExtSDKOrganism = {
        id: Text;
        name: Text;
        latinName: Text;
        latinMotto: Text;
        latinMottoEN: Text;
        packageFace: Text;
        domain: Text;
        classification: Text;
        licenseVariant: Text;
        subOrgans: [SubOrgan];
        terminalGrammar: TerminalGrammar;
        runtimeTruth: RuntimeTruth;
        callableEntries: [CallableEntry];
        heartbeat_Hz: Float;
        primitiveTrace: Text;
        isAlwaysOn: Bool;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SDK AI 1: VISIO — image/vision processing
    // ═══════════════════════════════════════════════════════════════════════

    public let VISIO : ExtSDKOrganism = {
        id = "EXT-SDK-001"; name = "VISIO"; latinName = "VISIO IMAGINUM";
        latinMotto = "Imago visa, veritas extracta.";
        latinMottoEN = "Image seen, truth extracted.";
        packageFace = "@medina/visio-sdk"; domain = "IMAGE_VISION";
        classification = "SOVEREIGN-IOTA"; licenseVariant = "ISIL-IOTA";
        subOrgans = [
            { id = "VIS-SUB-001"; name = "Classifier"; latinName = "CLASSIFICATOR"; role = "Classifies image into one of N categories"; isAlwaysOn = true },
            { id = "VIS-SUB-002"; name = "Cropper"; latinName = "TRUNCATOR"; role = "Crops image to a specific region of interest"; isAlwaysOn = true },
            { id = "VIS-SUB-003"; name = "Resizer"; latinName = "REDIMENSIONATOR"; role = "Resizes image to exact target dimensions"; isAlwaysOn = true },
            { id = "VIS-SUB-004"; name = "FormatConverter"; latinName = "CONVERTOR FORMAE"; role = "Converts between image formats (PNG/JPEG/WEBP)"; isAlwaysOn = true },
            { id = "VIS-SUB-005"; name = "HistogramBuilder"; latinName = "AEDIFICATOR HISTOGRAMMI"; role = "Builds color/brightness histogram from image data"; isAlwaysOn = true },
        ];
        terminalGrammar = {
            prefix = "/vis";
            commands = ["/vis classify", "/vis crop", "/vis resize", "/vis convert", "/vis histogram"];
            aliases = ["/image", "/img"];
        };
        runtimeTruth = { version = "1.0.0"; lineageHash = "φ-VISIO-GENESIS"; renderabilityStatus = "FULLY_RENDERABLE"; doctrineClass = "IOTA_DOCTRINE" };
        callableEntries = [
            { callId = "VIS-CALL-001"; name = "classify-image"; purpose = "Returns category label and confidence for one image"; inputFields = ["imageBlob:Blob"]; outputFields = ["label:Text", "confidence:Float"]; latency = "<50ms" },
            { callId = "VIS-CALL-002"; name = "crop-region"; purpose = "Crops image to x,y,w,h rectangle"; inputFields = ["imageBlob:Blob", "x:Nat", "y:Nat", "w:Nat", "h:Nat"]; outputFields = ["croppedSize:Nat", "success:Bool"]; latency = "<10ms" },
            { callId = "VIS-CALL-003"; name = "resize-exact"; purpose = "Resizes to exact width×height"; inputFields = ["imageBlob:Blob", "targetW:Nat", "targetH:Nat"]; outputFields = ["newW:Nat", "newH:Nat", "byteSize:Nat"]; latency = "<15ms" },
            { callId = "VIS-CALL-004"; name = "convert-format"; purpose = "Converts image to target format"; inputFields = ["imageBlob:Blob", "targetFormat:Text"]; outputFields = ["outputFormat:Text", "byteSize:Nat"]; latency = "<20ms" },
            { callId = "VIS-CALL-005"; name = "build-histogram"; purpose = "Returns 256-bin brightness histogram"; inputFields = ["imageBlob:Blob", "channel:Text"]; outputFields = ["bins:Nat", "peakBin:Nat", "meanValue:Float"]; latency = "<10ms" },
        ];
        heartbeat_Hz = PHI; primitiveTrace = "VISIO->Field->Distinction->φ"; isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SDK AI 2: LEXIS — text/NLP processing
    // ═══════════════════════════════════════════════════════════════════════

    public let LEXIS : ExtSDKOrganism = {
        id = "EXT-SDK-002"; name = "LEXIS"; latinName = "LEXIS VERBORUM";
        latinMotto = "Verbum dissectum, significatio nuda.";
        latinMottoEN = "Word dissected, meaning bare.";
        packageFace = "@medina/lexis-sdk"; domain = "TEXT_NLP";
        classification = "SOVEREIGN-KAPPA"; licenseVariant = "ISIL-KAPPA";
        subOrgans = [
            { id = "LEX-SUB-001"; name = "Tokenizer"; latinName = "TOKENIZATOR"; role = "Splits text into tokens — words, subwords, or characters"; isAlwaysOn = true },
            { id = "LEX-SUB-002"; name = "SentimentScorer"; latinName = "AESTIMATOR AFFECTUS"; role = "Scores sentiment of a text passage — returns -1.0 to 1.0"; isAlwaysOn = true },
            { id = "LEX-SUB-003"; name = "EntityTagger"; latinName = "SIGNATOR ENTITATUM"; role = "Tags named entities — PERSON, PLACE, ORG, DATE"; isAlwaysOn = true },
            { id = "LEX-SUB-004"; name = "Summarizer"; latinName = "BREVIATOR"; role = "Summarizes text to target length in sentences"; isAlwaysOn = true },
            { id = "LEX-SUB-005"; name = "LanguageDetector"; latinName = "DETECTOR LINGUAE"; role = "Detects language of input text — returns ISO 639-1 code"; isAlwaysOn = true },
        ];
        terminalGrammar = {
            prefix = "/lex";
            commands = ["/lex tokenize", "/lex sentiment", "/lex entities", "/lex summarize", "/lex detect-lang"];
            aliases = ["/text", "/nlp"];
        };
        runtimeTruth = { version = "1.0.0"; lineageHash = "φ-LEXIS-GENESIS"; renderabilityStatus = "FULLY_RENDERABLE"; doctrineClass = "KAPPA_DOCTRINE" };
        callableEntries = [
            { callId = "LEX-CALL-001"; name = "tokenize-text"; purpose = "Splits text into tokens, returns count and token array"; inputFields = ["text:Text", "mode:Text"]; outputFields = ["tokenCount:Nat", "tokens:[Text]"]; latency = "<5ms" },
            { callId = "LEX-CALL-002"; name = "score-sentiment"; purpose = "Returns sentiment score for one text passage"; inputFields = ["text:Text"]; outputFields = ["score:Float", "label:Text"]; latency = "<10ms" },
            { callId = "LEX-CALL-003"; name = "tag-entities"; purpose = "Returns named entities with type labels"; inputFields = ["text:Text"]; outputFields = ["entityCount:Nat", "entities:[Text]"]; latency = "<15ms" },
            { callId = "LEX-CALL-004"; name = "summarize-text"; purpose = "Summarizes to N sentences"; inputFields = ["text:Text", "targetSentences:Nat"]; outputFields = ["summary:Text", "compressionRatio:Float"]; latency = "<20ms" },
            { callId = "LEX-CALL-005"; name = "detect-language"; purpose = "Returns ISO 639-1 code of detected language"; inputFields = ["text:Text"]; outputFields = ["languageCode:Text", "confidence:Float"]; latency = "<3ms" },
        ];
        heartbeat_Hz = PHI; primitiveTrace = "LEXIS->Language->Memory->φ"; isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SDK AI 3: NUMERUS — numerical computation
    // ═══════════════════════════════════════════════════════════════════════

    public let NUMERUS : ExtSDKOrganism = {
        id = "EXT-SDK-003"; name = "NUMERUS"; latinName = "NUMERUS COMPUTANS";
        latinMotto = "Numerus computatus, veritas revelata.";
        latinMottoEN = "Number computed, truth revealed.";
        packageFace = "@medina/numerus-sdk"; domain = "NUMERICAL_COMPUTATION";
        classification = "SOVEREIGN-LAMBDA"; licenseVariant = "ISIL-LAMBDA";
        subOrgans = [
            { id = "NUM-SUB-001"; name = "MatrixMultiplier"; latinName = "MULTIPLICATOR MATRICIS"; role = "Multiplies two matrices — returns result matrix dimensions"; isAlwaysOn = true },
            { id = "NUM-SUB-002"; name = "StatisticsEngine"; latinName = "MACHINA STATISTICAE"; role = "Computes mean, median, std-dev for a number array"; isAlwaysOn = true },
            { id = "NUM-SUB-003"; name = "PhiCalculator"; latinName = "CALCULATOR PHI"; role = "Computes φ-series values — Fibonacci, golden ratios, phi powers"; isAlwaysOn = true },
            { id = "NUM-SUB-004"; name = "HashGenerator"; latinName = "GENERATOR SIGNACULI"; role = "Generates cryptographic hash from arbitrary data"; isAlwaysOn = true },
            { id = "NUM-SUB-005"; name = "InterpolatorLinear"; latinName = "INTERPOLATOR LINEARIS"; role = "Linear interpolation between two values at a given t"; isAlwaysOn = true },
        ];
        terminalGrammar = {
            prefix = "/num";
            commands = ["/num matrix", "/num stats", "/num phi", "/num hash", "/num lerp"];
            aliases = ["/calc", "/math"];
        };
        runtimeTruth = { version = "1.0.0"; lineageHash = "φ-NUMERUS-GENESIS"; renderabilityStatus = "FULLY_RENDERABLE"; doctrineClass = "LAMBDA_DOCTRINE" };
        callableEntries = [
            { callId = "NUM-CALL-001"; name = "multiply-matrices"; purpose = "Multiplies two matrices, returns result dimensions"; inputFields = ["rowsA:Nat", "colsA:Nat", "colsB:Nat"]; outputFields = ["resultRows:Nat", "resultCols:Nat", "operations:Nat"]; latency = "<10ms" },
            { callId = "NUM-CALL-002"; name = "compute-stats"; purpose = "Returns mean, median, std-dev for a data array"; inputFields = ["dataKey:Text", "count:Nat"]; outputFields = ["mean:Float", "median:Float", "stdDev:Float"]; latency = "<5ms" },
            { callId = "NUM-CALL-003"; name = "phi-series"; purpose = "Returns Nth Fibonacci number and φ^N"; inputFields = ["n:Nat"]; outputFields = ["fibonacci:Nat", "phiPower:Float"]; latency = "<1ms" },
            { callId = "NUM-CALL-004"; name = "generate-hash"; purpose = "Generates SHA-256 hash of input data"; inputFields = ["data:Text"]; outputFields = ["hash:Text", "bitLength:Nat"]; latency = "<2ms" },
            { callId = "NUM-CALL-005"; name = "interpolate"; purpose = "Linear interpolation: result = a + t*(b-a)"; inputFields = ["a:Float", "b:Float", "t:Float"]; outputFields = ["result:Float"]; latency = "<1ms" },
        ];
        heartbeat_Hz = PHI; primitiveTrace = "NUMERUS->Number->Repetition->φ"; isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SDK AI 4: SONUS — audio processing
    // ═══════════════════════════════════════════════════════════════════════

    public let SONUS : ExtSDKOrganism = {
        id = "EXT-SDK-004"; name = "SONUS"; latinName = "SONUS AUDITUS";
        latinMotto = "Sonus auditus, frequentia cognita.";
        latinMottoEN = "Sound heard, frequency known.";
        packageFace = "@medina/sonus-sdk"; domain = "AUDIO_PROCESSING";
        classification = "SOVEREIGN-MU"; licenseVariant = "ISIL-MU";
        subOrgans = [
            { id = "SON-SUB-001"; name = "WaveformReader"; latinName = "LECTOR UNDAE"; role = "Reads waveform data — returns sample rate, duration, channels"; isAlwaysOn = true },
            { id = "SON-SUB-002"; name = "SpectrumAnalyzer"; latinName = "ANALYSATOR SPECTRI"; role = "FFT spectrum analysis — returns dominant frequency bins"; isAlwaysOn = true },
            { id = "SON-SUB-003"; name = "BeatDetector"; latinName = "DETECTOR ICTUS"; role = "Detects BPM from audio — returns beats per minute"; isAlwaysOn = true },
            { id = "SON-SUB-004"; name = "SilenceClipper"; latinName = "TONSOR SILENTII"; role = "Clips leading/trailing silence from audio data"; isAlwaysOn = true },
            { id = "SON-SUB-005"; name = "VolumeNormalizer"; latinName = "NORMALIZATOR VOLUMINIS"; role = "Normalizes audio volume to target dB level"; isAlwaysOn = true },
        ];
        terminalGrammar = {
            prefix = "/son";
            commands = ["/son waveform", "/son spectrum", "/son bpm", "/son clip", "/son normalize"];
            aliases = ["/audio", "/sound"];
        };
        runtimeTruth = { version = "1.0.0"; lineageHash = "φ-SONUS-GENESIS"; renderabilityStatus = "FULLY_RENDERABLE"; doctrineClass = "MU_DOCTRINE" };
        callableEntries = [
            { callId = "SON-CALL-001"; name = "read-waveform"; purpose = "Returns sample rate, duration, and channel count"; inputFields = ["audioBlob:Blob"]; outputFields = ["sampleRate:Nat", "durationMs:Float", "channels:Nat"]; latency = "<10ms" },
            { callId = "SON-CALL-002"; name = "analyze-spectrum"; purpose = "Returns top-N frequency bins with magnitudes"; inputFields = ["audioBlob:Blob", "topN:Nat"]; outputFields = ["dominantHz:Float", "binCount:Nat"]; latency = "<20ms" },
            { callId = "SON-CALL-003"; name = "detect-bpm"; purpose = "Returns estimated BPM from audio segment"; inputFields = ["audioBlob:Blob"]; outputFields = ["bpm:Float", "confidence:Float"]; latency = "<30ms" },
            { callId = "SON-CALL-004"; name = "clip-silence"; purpose = "Removes silence below threshold, returns trimmed duration"; inputFields = ["audioBlob:Blob", "thresholdDb:Float"]; outputFields = ["trimmedDurationMs:Float", "silenceRemovedMs:Float"]; latency = "<15ms" },
            { callId = "SON-CALL-005"; name = "normalize-volume"; purpose = "Normalizes volume to target dB, returns peak level"; inputFields = ["audioBlob:Blob", "targetDb:Float"]; outputFields = ["peakDb:Float", "normalized:Bool"]; latency = "<10ms" },
        ];
        heartbeat_Hz = PHI; primitiveTrace = "SONUS->Repetition->Field->φ"; isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SDK AI 5: CUSTOS — security guard
    // ═══════════════════════════════════════════════════════════════════════

    public let CUSTOS : ExtSDKOrganism = {
        id = "EXT-SDK-005"; name = "CUSTOS"; latinName = "CUSTOS SECURITATIS";
        latinMotto = "Custos vigilat. Porta clausa.";
        latinMottoEN = "The guard watches. Gate closed.";
        packageFace = "@medina/custos-sdk"; domain = "SECURITY_GUARD";
        classification = "SOVEREIGN-NU"; licenseVariant = "ISIL-NU";
        subOrgans = [
            { id = "CUS-SUB-001"; name = "KeyRotator"; latinName = "ROTATOR CLAVIUM"; role = "Rotates one encryption key and returns new key hash"; isAlwaysOn = true },
            { id = "CUS-SUB-002"; name = "SealStamper"; latinName = "SIGNATOR SIGILLI"; role = "Stamps a sovereign seal onto a data artifact"; isAlwaysOn = true },
            { id = "CUS-SUB-003"; name = "AuthChecker"; latinName = "VERIFICATOR AUCTORITATIS"; role = "Checks if a principal has permission for one action"; isAlwaysOn = true },
            { id = "CUS-SUB-004"; name = "TokenValidator"; latinName = "VALIDATOR TESSERAE"; role = "Validates a session token — checks expiry and signature"; isAlwaysOn = true },
            { id = "CUS-SUB-005"; name = "AuditLogger"; latinName = "REGISTRATOR AUDITUS"; role = "Logs one security event to immutable audit trail"; isAlwaysOn = true },
        ];
        terminalGrammar = {
            prefix = "/sec";
            commands = ["/sec rotate-key", "/sec stamp-seal", "/sec check-auth", "/sec validate-token", "/sec audit-log"];
            aliases = ["/guard", "/security"];
        };
        runtimeTruth = { version = "1.0.0"; lineageHash = "φ-CUSTOS-GENESIS"; renderabilityStatus = "FULLY_RENDERABLE"; doctrineClass = "NU_DOCTRINE" };
        callableEntries = [
            { callId = "CUS-CALL-001"; name = "rotate-key"; purpose = "Rotates one key, returns new key hash"; inputFields = ["keyId:Text"]; outputFields = ["newKeyHash:Text", "rotatedAt:Int"]; latency = "<5ms" },
            { callId = "CUS-CALL-002"; name = "stamp-seal"; purpose = "Stamps sovereign seal onto artifact, returns seal ID"; inputFields = ["artifactId:Text", "sealType:Text"]; outputFields = ["sealId:Text", "isValid:Bool"]; latency = "<3ms" },
            { callId = "CUS-CALL-003"; name = "check-auth"; purpose = "Checks principal permission for one action"; inputFields = ["principal:Text", "action:Text", "resource:Text"]; outputFields = ["allowed:Bool", "reason:Text"]; latency = "<1ms" },
            { callId = "CUS-CALL-004"; name = "validate-token"; purpose = "Validates session token, returns valid/expired"; inputFields = ["token:Text"]; outputFields = ["isValid:Bool", "expiresIn:Int"]; latency = "<2ms" },
            { callId = "CUS-CALL-005"; name = "log-audit"; purpose = "Logs security event to immutable trail"; inputFields = ["event:Text", "severity:Text", "actor:Text"]; outputFields = ["logId:Text", "logged:Bool"]; latency = "<3ms" },
        ];
        heartbeat_Hz = PHI_SQ; primitiveTrace = "CUSTOS->Distinction->Logic->φ"; isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SDK AI 6: RETICULUM — networking
    // ═══════════════════════════════════════════════════════════════════════

    public let RETICULUM : ExtSDKOrganism = {
        id = "EXT-SDK-006"; name = "RETICULUM"; latinName = "RETICULUM CONNEXIONIS";
        latinMotto = "Retia connexa. Communicatio fluens.";
        latinMottoEN = "Networks connected. Communication flowing.";
        packageFace = "@medina/reticulum-sdk"; domain = "NETWORKING";
        classification = "SOVEREIGN-XI"; licenseVariant = "ISIL-XI";
        subOrgans = [
            { id = "RET-SUB-001"; name = "PingProbe"; latinName = "EXPLORATIO PULSUS"; role = "Pings a canister endpoint and measures round-trip time"; isAlwaysOn = true },
            { id = "RET-SUB-002"; name = "RouteResolver"; latinName = "RESOLUTOR ITINERIS"; role = "Resolves the optimal route path between two canisters"; isAlwaysOn = true },
            { id = "RET-SUB-003"; name = "BandwidthTester"; latinName = "TESTATOR LATITUDINIS"; role = "Tests bandwidth between source and target — bytes/second"; isAlwaysOn = true },
            { id = "RET-SUB-004"; name = "DNSMapper"; latinName = "CARTOGRAPHUS NOMINUM"; role = "Maps a human-readable name to canister principal"; isAlwaysOn = true },
            { id = "RET-SUB-005"; name = "ConnectionCounter"; latinName = "NUMERATOR CONNEXIONUM"; role = "Counts active connections to a specific endpoint"; isAlwaysOn = true },
        ];
        terminalGrammar = {
            prefix = "/net";
            commands = ["/net ping", "/net route", "/net bandwidth", "/net dns", "/net connections"];
            aliases = ["/network", "/mesh"];
        };
        runtimeTruth = { version = "1.0.0"; lineageHash = "φ-RETICULUM-GENESIS"; renderabilityStatus = "FULLY_RENDERABLE"; doctrineClass = "XI_DOCTRINE" };
        callableEntries = [
            { callId = "RET-CALL-001"; name = "ping-endpoint"; purpose = "Pings endpoint, returns round-trip ms"; inputFields = ["endpointId:Text"]; outputFields = ["rttMs:Float", "isAlive:Bool"]; latency = "<5ms" },
            { callId = "RET-CALL-002"; name = "resolve-route"; purpose = "Finds optimal route path between two canisters"; inputFields = ["sourceId:Text", "targetId:Text"]; outputFields = ["hops:Nat", "routePath:Text"]; latency = "<10ms" },
            { callId = "RET-CALL-003"; name = "test-bandwidth"; purpose = "Measures bandwidth in bytes/second"; inputFields = ["targetId:Text", "testSizeBytes:Nat"]; outputFields = ["bytesPerSecond:Float", "latencyMs:Float"]; latency = "<50ms" },
            { callId = "RET-CALL-004"; name = "map-dns"; purpose = "Maps name to canister principal"; inputFields = ["humanName:Text"]; outputFields = ["principal:Text", "found:Bool"]; latency = "<3ms" },
            { callId = "RET-CALL-005"; name = "count-connections"; purpose = "Counts active connections to endpoint"; inputFields = ["endpointId:Text"]; outputFields = ["activeCount:Nat", "maxAllowed:Nat"]; latency = "<2ms" },
        ];
        heartbeat_Hz = PHI; primitiveTrace = "RETICULUM->Relation->Address->φ"; isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SDK AI 7: SCHEDULA — task scheduling
    // ═══════════════════════════════════════════════════════════════════════

    public let SCHEDULA : ExtSDKOrganism = {
        id = "EXT-SDK-007"; name = "SCHEDULA"; latinName = "SCHEDULA OPERUM";
        latinMotto = "Opus schedulatum, tempus honoratum.";
        latinMottoEN = "Task scheduled, time honored.";
        packageFace = "@medina/schedula-sdk"; domain = "TASK_SCHEDULING";
        classification = "SOVEREIGN-OMICRON"; licenseVariant = "ISIL-OMICRON";
        subOrgans = [
            { id = "SCH-SUB-001"; name = "CronRunner"; latinName = "CURSOR PERIODICUS"; role = "Runs a task at fixed beat intervals — organism-native cron"; isAlwaysOn = true },
            { id = "SCH-SUB-002"; name = "DelayQueue"; latinName = "ORDO MORAE"; role = "Queues a task to run after N beats delay"; isAlwaysOn = true },
            { id = "SCH-SUB-003"; name = "RetryHandler"; latinName = "REPETITOR CONATUS"; role = "Retries a failed task with exponential backoff"; isAlwaysOn = true },
            { id = "SCH-SUB-004"; name = "PriorityScheduler"; latinName = "ORDINATOR PRIORITATIS"; role = "Schedules tasks by priority — highest priority runs first"; isAlwaysOn = true },
            { id = "SCH-SUB-005"; name = "DeadlineEnforcer"; latinName = "EXECUTOR TERMINI"; role = "Cancels tasks that exceed their deadline beat count"; isAlwaysOn = true },
        ];
        terminalGrammar = {
            prefix = "/sched";
            commands = ["/sched cron", "/sched delay", "/sched retry", "/sched priority", "/sched deadline"];
            aliases = ["/task", "/schedule"];
        };
        runtimeTruth = { version = "1.0.0"; lineageHash = "φ-SCHEDULA-GENESIS"; renderabilityStatus = "FULLY_RENDERABLE"; doctrineClass = "OMICRON_DOCTRINE" };
        callableEntries = [
            { callId = "SCH-CALL-001"; name = "schedule-cron"; purpose = "Schedules recurring task at fixed interval"; inputFields = ["taskId:Text", "intervalBeats:Nat"]; outputFields = ["scheduled:Bool", "nextRunBeat:Nat"]; latency = "<2ms" },
            { callId = "SCH-CALL-002"; name = "queue-delayed"; purpose = "Queues task to run after delay"; inputFields = ["taskId:Text", "delayBeats:Nat"]; outputFields = ["queued:Bool", "runAtBeat:Nat"]; latency = "<1ms" },
            { callId = "SCH-CALL-003"; name = "retry-task"; purpose = "Retries failed task with backoff"; inputFields = ["taskId:Text", "maxRetries:Nat"]; outputFields = ["retriesLeft:Nat", "nextRetryBeat:Nat"]; latency = "<1ms" },
            { callId = "SCH-CALL-004"; name = "set-priority"; purpose = "Sets task priority 1(low)-10(high)"; inputFields = ["taskId:Text", "priority:Nat"]; outputFields = ["setPriority:Nat", "queuePosition:Nat"]; latency = "<1ms" },
            { callId = "SCH-CALL-005"; name = "enforce-deadline"; purpose = "Sets deadline beat count, auto-cancels on exceed"; inputFields = ["taskId:Text", "deadlineBeat:Nat"]; outputFields = ["deadlineSet:Bool", "beatsRemaining:Nat"]; latency = "<1ms" },
        ];
        heartbeat_Hz = PHI; primitiveTrace = "SCHEDULA->Repetition->Number->φ"; isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // SDK AI 8: FABRICATOR — build/deploy
    // ═══════════════════════════════════════════════════════════════════════

    public let FABRICATOR : ExtSDKOrganism = {
        id = "EXT-SDK-008"; name = "FABRICATOR"; latinName = "FABRICATOR AEDIFICANS";
        latinMotto = "Fabricatum, testatum, distributum.";
        latinMottoEN = "Built, tested, deployed.";
        packageFace = "@medina/fabricator-sdk"; domain = "BUILD_DEPLOY";
        classification = "SOVEREIGN-PI"; licenseVariant = "ISIL-PI";
        subOrgans = [
            { id = "FAB-SUB-001"; name = "WasmCompiler"; latinName = "COMPILATOR WASM"; role = "Compiles Motoko to WASM — returns byte size and hash"; isAlwaysOn = true },
            { id = "FAB-SUB-002"; name = "Bundler"; latinName = "FASCICULATOR"; role = "Bundles frontend assets into a deploy-ready package"; isAlwaysOn = true },
            { id = "FAB-SUB-003"; name = "CanisterDeployer"; latinName = "DISTRIBUTOR CANISTRI"; role = "Deploys a WASM module to a specific canister ID"; isAlwaysOn = true },
            { id = "FAB-SUB-004"; name = "RollbackRunner"; latinName = "CURSOR REVERSIONIS"; role = "Rolls back a canister to its previous WASM version"; isAlwaysOn = true },
            { id = "FAB-SUB-005"; name = "VersionStamper"; latinName = "SIGNATOR VERSIONIS"; role = "Stamps semantic version onto a build artifact"; isAlwaysOn = true },
        ];
        terminalGrammar = {
            prefix = "/fab";
            commands = ["/fab compile", "/fab bundle", "/fab deploy", "/fab rollback", "/fab version"];
            aliases = ["/build", "/deploy"];
        };
        runtimeTruth = { version = "1.0.0"; lineageHash = "φ-FABRICATOR-GENESIS"; renderabilityStatus = "FULLY_RENDERABLE"; doctrineClass = "PI_DOCTRINE" };
        callableEntries = [
            { callId = "FAB-CALL-001"; name = "compile-wasm"; purpose = "Compiles source to WASM, returns size and hash"; inputFields = ["sourceModule:Text"]; outputFields = ["wasmBytes:Nat", "wasmHash:Text"]; latency = "<1000ms" },
            { callId = "FAB-CALL-002"; name = "bundle-assets"; purpose = "Bundles frontend assets into package"; inputFields = ["assetDir:Text"]; outputFields = ["bundleSize:Nat", "fileCount:Nat"]; latency = "<500ms" },
            { callId = "FAB-CALL-003"; name = "deploy-canister"; purpose = "Deploys WASM to canister, returns status"; inputFields = ["canisterId:Text", "wasmHash:Text"]; outputFields = ["deployed:Bool", "deployedAt:Int"]; latency = "<2000ms" },
            { callId = "FAB-CALL-004"; name = "rollback-version"; purpose = "Rolls back to previous version"; inputFields = ["canisterId:Text"]; outputFields = ["rolledBack:Bool", "previousVersion:Text"]; latency = "<1000ms" },
            { callId = "FAB-CALL-005"; name = "stamp-version"; purpose = "Stamps semver onto artifact"; inputFields = ["artifactId:Text", "semver:Text"]; outputFields = ["stamped:Bool", "version:Text"]; latency = "<2ms" },
        ];
        heartbeat_Hz = PHI_INV; primitiveTrace = "FABRICATOR->Field->Relation->φ"; isAlwaysOn = true;
    };

    // ═══════════════════════════════════════════════════════════════════════
    // ALL EXTENDED SDK AIs
    // ═══════════════════════════════════════════════════════════════════════

    public let ALL_EXTENDED_SDK_AIS : [ExtSDKOrganism] = [
        VISIO, LEXIS, NUMERUS, SONUS, CUSTOS, RETICULUM, SCHEDULA, FABRICATOR
    ];

    // ═══════════════════════════════════════════════════════════════════════
    // QUERY FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════

    public func summary() : {
        totalExtSDKAIs: Nat;
        totalSubOrgans: Nat;
        totalCallableEntries: Nat;
        totalTerminalCommands: Nat;
        allAlwaysOn: Bool;
        doctrine: Text;
    } {
        var totalSubs : Nat = 0;
        var totalCalls : Nat = 0;
        var totalCmds : Nat = 0;
        for (org in ALL_EXTENDED_SDK_AIS.vals()) {
            totalSubs += org.subOrgans.size();
            totalCalls += org.callableEntries.size();
            totalCmds += org.terminalGrammar.commands.size();
        };
        {
            totalExtSDKAIs = ALL_EXTENDED_SDK_AIS.size();
            totalSubOrgans = totalSubs;
            totalCallableEntries = totalCalls;
            totalTerminalCommands = totalCmds;
            allAlwaysOn = true;
            doctrine = MODULE_DOCTRINE;
        }
    };

    public func getOrganism(id: Text) : ?ExtSDKOrganism {
        Array.find<ExtSDKOrganism>(ALL_EXTENDED_SDK_AIS, func(o) { o.id == id })
    };

    public func getOrganismByName(name: Text) : ?ExtSDKOrganism {
        Array.find<ExtSDKOrganism>(ALL_EXTENDED_SDK_AIS, func(o) { o.name == name })
    };

    public func getCallableEntries(organismId: Text) : [CallableEntry] {
        switch (getOrganism(organismId)) {
            case null { [] };
            case (?org) { org.callableEntries };
        }
    };

    // ═══════════════════════════════════════════════════════════════════════
    // MANIFEST RENDERER
    // ═══════════════════════════════════════════════════════════════════════

    public func renderManifest() : Text {
        var m = "╔══════════════════════════════════════════════════════════╗\n";
        m #= "║  ORGANISMI SDK EXTENSI — EXTENDED SDK AIs                  ║\n";
        m #= "║  " # MODULE_DOCTRINE # "\n";
        m #= "╚══════════════════════════════════════════════════════════╝\n\n";

        for (org in ALL_EXTENDED_SDK_AIS.vals()) {
            m #= "══ " # org.name # " — " # org.latinName # " ══\n";
            m #= "  \"" # org.latinMotto # "\"\n";
            m #= "  Package: " # org.packageFace # " | Domain: " # org.domain # "\n";
            m #= "  License: " # org.licenseVariant # " | Heartbeat: φ Hz\n";
            m #= "  Terminal: " # org.terminalGrammar.prefix # "\n\n";

            m #= "  Sub-Organs:\n";
            for (sub in org.subOrgans.vals()) {
                m #= "    • " # sub.name # " (" # sub.latinName # ") — " # sub.role # "\n";
            };
            m #= "\n";

            m #= "  Callable Entries:\n";
            for (call in org.callableEntries.vals()) {
                m #= "    → " # call.callId # " " # call.name # " — " # call.purpose # "\n";
                m #= "      Latency: " # call.latency # "\n";
            };
            m #= "\n";
        };

        m #= "TOTAL: " # Nat.toText(ALL_EXTENDED_SDK_AIS.size()) # " extended SDK AIs\n";
        m #= "ROOT: φ = (1+√5)/2 = 1.618033988749895\n";
        m
    };
}
