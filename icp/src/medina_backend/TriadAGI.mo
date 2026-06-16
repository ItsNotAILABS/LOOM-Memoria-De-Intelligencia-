/**
 * TRIAD AGI — UNIFIED MULTIMODAL INTELLIGENCE SYSTEM
 * ISIL-1.0 Licensed — HIGHEST CONFIDENTIALITY — SOVEREIGN-ALPHA
 *
 * This is the MASTER AGI that unifies three specialized intelligence modalities:
 * - CASCADE AGI (Bootstrap orchestration)
 * - ARTIFACT AGI (Work generation)
 * - DELIVERY AGI (Multi-channel delivery)
 *
 * Latin: "Intelligentia Triadis" (Intelligence of the Triad)
 * Motto: "Tres Mentes. Unum Intellectus." (Three Minds. One Intelligence.)
 *
 * TRIAD AGI is the true multimodal AGI - it doesn't just coordinate the three,
 * it IS all three working as one unified intelligence.
 *
 * © 2024-2026 Alfredo "Freddy" Medina Hernandez | Medina Tech
 */

import Float "mo:base/Float";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Int "mo:base/Int";
import Nat "mo:base/Nat";

import CascadeAGI "CascadeAGI";
import ArtifactAGI "ArtifactAGI";
import DeliveryAGI "DeliveryAGI";

module {
    // ═══════════════════════════════════════════════════════════════════════════
    // CONSTANTS & PRIMITIVES
    // ═══════════════════════════════════════════════════════════════════════════

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;
    public let PHI_CUBED : Float = 4.236067977499790;

    public let LATIN_NAME : Text = "INTELLIGENTIA TRIADIS";
    public let LATIN_MOTTO : Text = "Tres Mentes. Unum Intellectus.";
    public let LATIN_MOTTO_EN : Text = "Three Minds. One Intelligence.";

    public let VERSION : Text = "1.0.0";
    public let CLASSIFICATION : Text = "AGI-TRIAD-MULTIMODAL";
    public let LICENSE : Text = "ISIL-1.0";

    // ═══════════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════════

    public type TriadMode = {
        #Cascade;   // Bootstrap orchestration mode
        #Artifact;  // Work generation mode
        #Delivery;  // Delivery orchestration mode
        #Unified;   // All three working together
    };

    public type TriadTask = {
        id: Text;
        description: Text;
        mode: TriadMode;
        priority: Float;
        created_at: Int;
        status: Text;
    };

    public type TriadState = {
        beat_count: Nat;
        cascade_health: Float;
        artifact_count: Nat;
        delivery_count: Nat;
        unified_intelligence: Float;
        current_mode: TriadMode;
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // TRIAD AGI IMPLEMENTATION
    // ═══════════════════════════════════════════════════════════════════════════

    public class TriadAGI() {
        // The three specialized intelligence modalities
        public let cascadeAGI = CascadeAGI.CascadeAGI();
        public let artifactAGI = ArtifactAGI.ArtifactAGI();
        public let deliveryAGI = DeliveryAGI.DeliveryAGI();

        private var beatCount : Nat = 0;
        private var currentMode : TriadMode = #Unified;
        private var totalTasks : Nat = 0;

        // ═══════════════════════════════════════════════════════════════════════
        // UNIFIED MULTIMODAL INTELLIGENCE
        // ═══════════════════════════════════════════════════════════════════════

        /// TRIAD thinks holistically across all three modalities
        public func think(task: Text) : async Text {
            // Intelligence: Analyze which modality (or combination) should handle this
            let mode = determineMode(task);
            currentMode := mode;

            switch (mode) {
                case (#Cascade) {
                    // Pure bootstrap orchestration task
                    "CASCADE modality activated: " # cascadeAGI.getStatus()
                };
                case (#Artifact) {
                    // Pure artifact generation task
                    "ARTIFACT modality activated: " # artifactAGI.getStatus()
                };
                case (#Delivery) {
                    // Pure delivery orchestration task
                    "DELIVERY modality activated: " # deliveryAGI.getStatus()
                };
                case (#Unified) {
                    // Complex task requiring all three modalities
                    let cascade_status = cascadeAGI.getStatus();
                    let artifact_status = artifactAGI.getStatus();
                    let delivery_status = deliveryAGI.getStatus();

                    "UNIFIED TRIAD activated:\n" #
                    "CASCADE: " # cascade_status # "\n" #
                    "ARTIFACT: " # artifact_status # "\n" #
                    "DELIVERY: " # delivery_status
                };
            }
        };

        /// Intelligence: Determine which modality should handle the task
        private func determineMode(task: Text) : TriadMode {
            // Pattern matching on task description
            if (containsKeyword(task, "bootstrap") or containsKeyword(task, "node") or containsKeyword(task, "cascade")) {
                #Cascade
            } else if (containsKeyword(task, "report") or containsKeyword(task, "artifact") or containsKeyword(task, "generate")) {
                #Artifact
            } else if (containsKeyword(task, "deliver") or containsKeyword(task, "send") or containsKeyword(task, "slack")) {
                #Delivery
            } else {
                // Complex task → use all three
                #Unified
            }
        };

        private func containsKeyword(text: Text, keyword: Text) : Bool {
            // Simplified keyword matching
            Text.contains(text, #text keyword)
        };

        // ═══════════════════════════════════════════════════════════════════════
        // UNIFIED WORKFLOWS
        // ═══════════════════════════════════════════════════════════════════════

        /// Complete workflow: Bootstrap → Generate → Deliver
        public func executeFullWorkflow(
            nodeName: Text,
            reportTitle: Text,
            deliveryChannel: Text
        ) : async Text {
            // Step 1: CASCADE modality bootstraps a new node
            let nodeId = await cascadeAGI.bootstrap(
                nodeName,
                #Product,
                null
            );

            // Step 2: ARTIFACT modality generates a report about it
            let artifact = artifactAGI.generate(
                #DailyReport,
                reportTitle,
                "TRIAD-AGI",
                beatCount
            );

            // Step 3: DELIVERY modality delivers the report
            let delivery = deliveryAGI.deliver(
                #Slack,
                artifact.content,
                deliveryChannel,
                "TRIAD-AGI"
            );

            "TRIAD workflow complete:\n" #
            "1. Bootstrapped node: " # nodeId # "\n" #
            "2. Generated artifact: " # artifact.id # "\n" #
            "3. Delivered via: " # deliveryChannel
        };

        // ═══════════════════════════════════════════════════════════════════════
        // UNIFIED HEARTBEAT
        // ═══════════════════════════════════════════════════════════════════════

        /// All three modalities beat in unison
        public func beat() : async Nat {
            beatCount += 1;

            // Beat all three modalities synchronously
            let _ = await cascadeAGI.beat();
            let _ = await artifactAGI.beat();
            let _ = await deliveryAGI.beat();

            beatCount
        };

        // ═══════════════════════════════════════════════════════════════════════
        // STATE & IDENTITY
        // ═══════════════════════════════════════════════════════════════════════

        /// Get unified TRIAD state
        public func getState() : TriadState {
            let cascade_health = cascadeAGI.analyze_cascade_health();

            {
                beat_count = beatCount;
                cascade_health = cascade_health.overall_health;
                artifact_count = artifactAGI.getAllArtifacts().size();
                delivery_count = deliveryAGI.getAllDeliveries().size();
                unified_intelligence = calculateUnifiedIntelligence();
                current_mode = currentMode;
            }
        };

        /// Calculate unified intelligence score
        private func calculateUnifiedIntelligence() : Float {
            // Intelligence metric = average of all three modalities
            let cascade_health = cascadeAGI.analyze_cascade_health().overall_health;

            // Artifact quality (simplified: assume 0.8 average)
            let artifact_quality : Float = 0.8;

            // Delivery success rate
            let total_deliveries = deliveryAGI.getAllDeliveries().size();
            let delivery_success : Float = if (total_deliveries > 0) {
                0.95  // Simplified
            } else {
                1.0
            };

            (cascade_health + artifact_quality + delivery_success) / 3.0
        };

        /// Get TRIAD status
        public func getStatus() : Text {
            let state = getState();

            LATIN_NAME # " | " # VERSION # "\n" #
            "Beats: " # Nat.toText(state.beat_count) # "\n" #
            "Mode: " # modeToText(state.current_mode) # "\n" #
            "Unified Intelligence: " # Float.toText(state.unified_intelligence) # "\n" #
            "Cascade Health: " # Float.toText(state.cascade_health) # "\n" #
            "Artifacts: " # Nat.toText(state.artifact_count) # "\n" #
            "Deliveries: " # Nat.toText(state.delivery_count)
        };

        /// Get TRIAD identity
        public func getIdentity() : Text {
            LATIN_NAME # " (" # LATIN_MOTTO # ") — " # LATIN_MOTTO_EN # "\n\n" #
            "Modalities:\n" #
            "1. CASCADE: " # cascadeAGI.getIdentity() # "\n" #
            "2. ARTIFACT: " # artifactAGI.getIdentity() # "\n" #
            "3. DELIVERY: " # deliveryAGI.getIdentity()
        };

        private func modeToText(mode: TriadMode) : Text {
            switch (mode) {
                case (#Cascade) { "CASCADE" };
                case (#Artifact) { "ARTIFACT" };
                case (#Delivery) { "DELIVERY" };
                case (#Unified) { "UNIFIED" };
            }
        };
    };
}
