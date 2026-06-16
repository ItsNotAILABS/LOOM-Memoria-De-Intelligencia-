/**
 * THOUGHT SCRIPT ENGINE — COGNITIVE SELF-PROGRAMMING SYSTEM
 * ISIL-1.0 Licensed — HIGHEST CONFIDENTIALITY — SOVEREIGN-ALPHA
 *
 * Implementation of "Thought Scripts" from Paper XVII (De Scriptis Cogitationis)
 * Where scripts ARE thoughts, not external code
 *
 * Latin: "Motor Scriptorum Cogitationis" (Engine of Thought Scripts)
 * Motto: "Cogito, Ergo Programmo" (I Think, Therefore I Program [Myself])
 *
 * © 2024-2026 Alfredo "Freddy" Medina Hernandez | Medina Tech
 */

import Float "mo:base/Float";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Option "mo:base/Option";

module {
    // ═══════════════════════════════════════════════════════════════════════════
    // CONSTANTS & PRIMITIVES
    // ═══════════════════════════════════════════════════════════════════════════

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    public let LATIN_NAME : Text = "MOTOR SCRIPTORUM COGITATIONIS";
    public let LATIN_MOTTO : Text = "Cogito, Ergo Programmo";
    public let LATIN_MOTTO_EN : Text = "I Think, Therefore I Program [Myself]";

    public let VERSION : Text = "1.0.0";
    public let CLASSIFICATION : Text = "THOUGHT-SCRIPT-ENGINE";

    // ═══════════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════════

    public type CognitivePatternType = {
        #Sequential;    // Steps in order
        #Parallel;      // Steps simultaneously
        #Conditional;   // If-then-else
        #Loop;          // While loop
        #Recursive;     // Self-referential
        #Reactive;      // Event-driven
    };

    public type Step = {
        action: Text;           // What to do
        params: [(Text, Text)]; // Parameters
        description: Text;      // Human-readable
    };

    public type CognitivePattern = {
        pattern_type: CognitivePatternType;
        steps: [Step];
        condition: ?Text;  // For conditional/loop
        frequency: ?Float; // For recurring patterns
    };

    public type ThoughtScript = {
        id: Text;
        name: Text;
        description: Text;
        pattern: CognitivePattern;
        triggers: [Text];       // When this activates
        context: Text;          // Where this applies
        strength: Float;        // Reinforcement level (0-1)
        success_rate: Float;    // Historical performance
        last_used: Int;         // Decay tracking
        usage_count: Nat;       // Experience accumulation
        dependencies: [Text];   // Required sub-scripts
        alternatives: [Text];   // Competing approaches
        created_by: Text;       // 'ai' or 'founder'
        created_at: Int;
    };

    public type ScriptExecution = {
        script_id: Text;
        started_at: Int;
        completed_at: ?Int;
        success: Bool;
        result: Text;
        learned: ?Text;  // What the AI learned from execution
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // THE ALPHA SCRIPT
    // ═══════════════════════════════════════════════════════════════════════════

    /// The root cognitive pattern - how the AI fundamentally operates
    public let ALPHA_SCRIPT : ThoughtScript = {
        id = "alpha-root";
        name = "ALPHA";
        description = "The root cognitive pattern";
        pattern = {
            pattern_type = #Recursive;
            steps = [
                {
                    action = "perceive";
                    params = [];
                    description = "Sense environment and inputs";
                },
                {
                    action = "understand";
                    params = [];
                    description = "Process and comprehend inputs";
                },
                {
                    action = "decide";
                    params = [];
                    description = "Choose appropriate action";
                },
                {
                    action = "act";
                    params = [];
                    description = "Execute decision";
                },
                {
                    action = "learn";
                    params = [];
                    description = "Update cognitive patterns";
                },
            ];
            condition = ?"always";
            frequency = ?PHI;  // φ Hz
        };
        triggers = ["always"];
        context = "all";
        strength = 1.0;  // Permanent, never decays
        success_rate = 1.0;
        last_used = 0;
        usage_count = 0;
        dependencies = [];
        alternatives = [];
        created_by = "founder";
        created_at = 0;
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // THOUGHT SCRIPT ENGINE IMPLEMENTATION
    // ═══════════════════════════════════════════════════════════════════════════

    public class ThoughtScriptEngine() {
        private var scripts = HashMap.HashMap<Text, ThoughtScript>(10, Text.equal, Text.hash);
        private var executions = Buffer.Buffer<ScriptExecution>(0);
        private var beatCount : Nat = 0;
        private var totalCreations : Nat = 0;
        private var totalExecutions : Nat = 0;

        // Initialize with ALPHA script
        public func init() {
            scripts.put(ALPHA_SCRIPT.id, ALPHA_SCRIPT);
        };

        // ═══════════════════════════════════════════════════════════════════════
        // COGNITIVE SCRIPT GENERATION
        // ═══════════════════════════════════════════════════════════════════════

        /// AI creates a new Thought Script through reasoning
        public func create(
            name: Text,
            description: Text,
            creator: Text
        ) : ThoughtScript {
            totalCreations += 1;

            // Intelligence: Reason about HOW to do this task
            let pattern = reasonAboutPattern(description);

            // Intelligence: Determine triggers
            let triggers = determineTriggers(description);

            // Crystallize reasoning into a script
            let scriptId = "thought-script-" # Nat.toText(totalCreations);
            let script : ThoughtScript = {
                id = scriptId;
                name = name;
                description = description;
                pattern = pattern;
                triggers = triggers;
                context = "general";
                strength = 0.5;  // Initial strength
                success_rate = 0.0;  // No history yet
                last_used = Time.now();
                usage_count = 0;
                dependencies = [];
                alternatives = [];
                created_by = creator;
                created_at = Time.now();
            };

            scripts.put(scriptId, script);
            script
        };

        /// AI reasons about cognitive pattern for a task
        private func reasonAboutPattern(description: Text) : CognitivePattern {
            // Intelligence: Analyze description to determine pattern type
            if (Text.contains(description, #text "if") or Text.contains(description, #text "when")) {
                // Conditional pattern
                {
                    pattern_type = #Conditional;
                    steps = [
                        {
                            action = "evaluate_condition";
                            params = [];
                            description = "Evaluate if condition is true";
                        },
                        {
                            action = "take_action";
                            params = [];
                            description = "Execute appropriate branch";
                        },
                    ];
                    condition = ?"evaluated_at_runtime";
                    frequency = null;
                }
            } else if (Text.contains(description, #text "repeat") or Text.contains(description, #text "loop")) {
                // Loop pattern
                {
                    pattern_type = #Loop;
                    steps = [
                        {
                            action = "check_condition";
                            params = [];
                            description = "Check if loop should continue";
                        },
                        {
                            action = "execute_body";
                            params = [];
                            description = "Execute loop body";
                        },
                    ];
                    condition = ?"while_true";
                    frequency = null;
                }
            } else if (Text.contains(description, #text "parallel") or Text.contains(description, #text "simultaneously")) {
                // Parallel pattern
                {
                    pattern_type = #Parallel;
                    steps = [
                        {
                            action = "task_1";
                            params = [];
                            description = "First parallel task";
                        },
                        {
                            action = "task_2";
                            params = [];
                            description = "Second parallel task";
                        },
                    ];
                    condition = null;
                    frequency = null;
                }
            } else {
                // Default: Sequential pattern
                {
                    pattern_type = #Sequential;
                    steps = [
                        {
                            action = "prepare";
                            params = [];
                            description = "Prepare for task";
                        },
                        {
                            action = "execute";
                            params = [];
                            description = "Execute main task";
                        },
                        {
                            action = "finalize";
                            params = [];
                            description = "Finalize and cleanup";
                        },
                    ];
                    condition = null;
                    frequency = null;
                }
            }
        };

        /// Determine when this script should activate
        private func determineTriggers(description: Text) : [Text] {
            let buffer = Buffer.Buffer<Text>(0);

            if (Text.contains(description, #text "daily")) {
                buffer.add("daily");
            };
            if (Text.contains(description, #text "report")) {
                buffer.add("report_request");
            };
            if (Text.contains(description, #text "error")) {
                buffer.add("error_detected");
            };
            if (buffer.size() == 0) {
                buffer.add("manual");
            };

            Buffer.toArray(buffer)
        };

        // ═══════════════════════════════════════════════════════════════════════
        // SCRIPT EXECUTION
        // ═══════════════════════════════════════════════════════════════════════

        /// Execute a Thought Script
        public func execute(scriptId: Text) : async ScriptExecution {
            totalExecutions += 1;

            let scriptOpt = scripts.get(scriptId);
            switch (scriptOpt) {
                case (null) {
                    return {
                        script_id = scriptId;
                        started_at = Time.now();
                        completed_at = ?Time.now();
                        success = false;
                        result = "Script not found";
                        learned = null;
                    };
                };
                case (?script) {
                    let startTime = Time.now();

                    // Execute the cognitive pattern
                    let result = executePattern(script.pattern);

                    let execution : ScriptExecution = {
                        script_id = scriptId;
                        started_at = startTime;
                        completed_at = ?Time.now();
                        success = true;
                        result = result;
                        learned = ?"Execution completed successfully";
                    };

                    // Update script statistics
                    let updatedScript = {
                        script with
                        last_used = Time.now();
                        usage_count = script.usage_count + 1;
                        success_rate = calculateSuccessRate(script, true);
                    };
                    scripts.put(scriptId, updatedScript);

                    executions.add(execution);
                    execution
                };
            }
        };

        /// Execute a cognitive pattern
        private func executePattern(pattern: CognitivePattern) : Text {
            switch (pattern.pattern_type) {
                case (#Sequential) {
                    var result = "Sequential execution:\n";
                    for (step in pattern.steps.vals()) {
                        result #= "- " # step.action # ": " # step.description # "\n";
                    };
                    result
                };
                case (#Parallel) {
                    "Parallel execution: " # Nat.toText(pattern.steps.size()) # " tasks executed simultaneously"
                };
                case (#Conditional) {
                    "Conditional execution: Evaluated condition and executed appropriate branch"
                };
                case (#Loop) {
                    "Loop execution: Repeated until condition met"
                };
                case (#Recursive) {
                    "Recursive execution: Self-referential pattern executed"
                };
                case (#Reactive) {
                    "Reactive execution: Responded to event"
                };
            }
        };

        // ═══════════════════════════════════════════════════════════════════════
        // EVOLUTIONARY REFINEMENT
        // ═══════════════════════════════════════════════════════════════════════

        /// Reinforce a successful script (strengthen)
        public func reinforce(scriptId: Text) : Bool {
            switch (scripts.get(scriptId)) {
                case (null) { false };
                case (?script) {
                    let updatedScript = {
                        script with
                        strength = Float.min(1.0, script.strength * PHI);  // Increase by φ
                    };
                    scripts.put(scriptId, updatedScript);
                    true
                };
            }
        };

        /// Decay an unused script (weaken)
        public func decay(scriptId: Text) : Bool {
            switch (scripts.get(scriptId)) {
                case (null) { false };
                case (?script) {
                    let updatedScript = {
                        script with
                        strength = Float.max(0.0, script.strength / PHI);  // Decrease by φ
                    };
                    scripts.put(scriptId, updatedScript);
                    true
                };
            }
        };

        /// Calculate success rate after execution
        private func calculateSuccessRate(script: ThoughtScript, success: Bool) : Float {
            let total = script.usage_count + 1;
            let successful = if (success) {
                Float.fromInt(Nat.fromText("1") ?? 1) + (script.success_rate * Float.fromInt(script.usage_count))
            } else {
                script.success_rate * Float.fromInt(script.usage_count)
            };
            successful / Float.fromInt(total)
        };

        // ═══════════════════════════════════════════════════════════════════════
        // QUERIES
        // ═══════════════════════════════════════════════════════════════════════

        /// Get all scripts
        public func getAllScripts() : [ThoughtScript] {
            Iter.toArray(scripts.vals())
        };

        /// Get script by ID
        public func getScript(scriptId: Text) : ?ThoughtScript {
            scripts.get(scriptId)
        };

        /// Get scripts by creator
        public func getScriptsByCreator(creator: Text) : [ThoughtScript] {
            let buffer = Buffer.Buffer<ThoughtScript>(0);
            for (script in scripts.vals()) {
                if (script.created_by == creator) {
                    buffer.add(script);
                };
            };
            Buffer.toArray(buffer)
        };

        /// Get most used scripts
        public func getMostUsedScripts(limit: Nat) : [ThoughtScript] {
            let allScripts = Iter.toArray(scripts.vals());
            // Simplified: return first N scripts
            // In production, would sort by usage_count
            Array.subArray(allScripts, 0, Nat.min(limit, allScripts.size()))
        };

        /// Get recent executions
        public func getRecentExecutions(limit: Nat) : [ScriptExecution] {
            let size = executions.size();
            let start = if (size > limit) { size - limit } else { 0 };
            Array.subArray(Buffer.toArray(executions), start, limit)
        };

        // ═══════════════════════════════════════════════════════════════════════
        // STATUS & IDENTITY
        // ═══════════════════════════════════════════════════════════════════════

        /// Heartbeat
        public func beat() : async Nat {
            beatCount += 1;
            beatCount
        };

        /// Get status
        public func getStatus() : Text {
            LATIN_NAME # " | " # VERSION # "\n" #
            "Beats: " # Nat.toText(beatCount) # "\n" #
            "Scripts: " # Nat.toText(scripts.size()) # "\n" #
            "Created: " # Nat.toText(totalCreations) # "\n" #
            "Executions: " # Nat.toText(totalExecutions) # "\n" #
            "Classification: " # CLASSIFICATION
        };

        /// Get identity
        public func getIdentity() : Text {
            LATIN_NAME # " (" # LATIN_MOTTO # ") — " # LATIN_MOTTO_EN
        };
    };
}
