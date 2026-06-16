/**
 * ANIMUS ENGINE — CASCADE ORCHESTRATION & PERPETUAL DELIVERY
 * ISIL-1.0 Licensed — HIGHEST CONFIDENTIALITY — SOVEREIGN-ALPHA
 *
 * Latin: "Animus" = Soul, Mind, Life-Force
 * Motto: "Perpetuo Fluit, Perpetuo Creat" (Forever Flows, Forever Creates)
 *
 * ANIMUS is the third Alpha organism (alongside ORO and NOVA).
 * It orchestrates cascade bootstraps, generates internal artifacts,
 * and manages perpetual delivery flows.
 *
 * Three Sub-Engines:
 * 1. CASCADE ENGINE — Bootstrap orchestration, hierarchy management
 * 2. ARTIFACT ENGINE — Internal work generation (reports, analytics, metrics)
 * 3. DELIVERY ENGINE — Delivery flow management (internal + external channels)
 *
 * Every operation traces to primitive φ.
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
import Hash "mo:base/Hash";
import Iter "mo:base/Iter";
import Option "mo:base/Option";

module {
    // ═══════════════════════════════════════════════════════════════════════════
    // CONSTANTS & PRIMITIVES
    // ═══════════════════════════════════════════════════════════════════════════

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;
    public let PHI_CUBED : Float = 4.236067977499790;

    public let LATIN_NAME : Text = "ANIMUS";
    public let LATIN_MOTTO : Text = "Perpetuo Fluit, Perpetuo Creat";
    public let LATIN_MOTTO_EN : Text = "Forever Flows, Forever Creates";

    public let VERSION : Text = "1.0.0";
    public let CLASSIFICATION : Text = "SOVEREIGN-ALPHA";
    public let LICENSE : Text = "ISIL-1.0";

    // Heartbeat frequency in Hz
    public let HEARTBEAT_HZ : Float = PHI;

    // ═══════════════════════════════════════════════════════════════════════════
    // TYPES — CASCADE ENGINE
    // ═══════════════════════════════════════════════════════════════════════════

    public type BootstrapLevel = {
        #Core;          // Level 0: Core organism
        #Product;       // Level 1: External products
        #Service;       // Level 2: External services
        #Division;      // Level 3: Divisions (IT, etc.)
    };

    public type CascadeNode = {
        id: Text;
        name: Text;
        level: BootstrapLevel;
        parent: ?Text;
        status: CascadeStatus;
        heartbeat_hz: Float;
        beat_count: Nat;
        started_at: Int;
        last_beat: Int;
        config: NodeConfig;
    };

    public type CascadeStatus = {
        #Created;
        #Bootstrapping;
        #Running;
        #Paused;
        #Failed;
    };

    public type NodeConfig = {
        memory_space: Text;
        gate_level: Text;
        monitoring: Bool;
        auto_restart: Bool;
    };

    public type BootstrapResult = {
        success: Bool;
        node_id: Text;
        message: Text;
        timestamp: Int;
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // TYPES — ARTIFACT ENGINE
    // ═══════════════════════════════════════════════════════════════════════════

    public type ArtifactType = {
        #DailyReport;
        #WeeklyReport;
        #ManagerReport;
        #Analytics;
        #Metrics;
        #HealthCheck;
        #Custom;
    };

    public type Artifact = {
        id: Text;
        artifact_type: ArtifactType;
        title: Text;
        content: Text;
        author: Text;
        classification: Text;
        created_at: Int;
        beat_count: Nat;
        metadata: ArtifactMetadata;
    };

    public type ArtifactMetadata = {
        word_count: Nat;
        scc_score: Float;
        frequency: Text;
        parent_node: ?Text;
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // TYPES — DELIVERY ENGINE
    // ═══════════════════════════════════════════════════════════════════════════

    public type DeliveryChannel = {
        #Internal;      // Internal AI-to-AI
        #Slack;         // External Slack
        #Email;         // External Email
        #Webhook;       // External Webhook
        #Custom;        // Custom channel
    };

    public type Delivery = {
        id: Text;
        channel: DeliveryChannel;
        content: Text;
        recipient: Text;
        sender: Text;
        delivered_at: Int;
        status: DeliveryStatus;
        metadata: DeliveryMetadata;
    };

    public type DeliveryStatus = {
        #Queued;
        #Sending;
        #Delivered;
        #Failed;
    };

    public type DeliveryMetadata = {
        retry_count: Nat;
        priority: Nat;
        artifact_id: ?Text;
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // STATE
    // ═══════════════════════════════════════════════════════════════════════════

    public type AnimusState = {
        beat_count: Nat;
        started_at: Int;
        last_beat: Int;
        cascade_nodes: [CascadeNode];
        artifacts: [Artifact];
        deliveries: [Delivery];
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // CASCADE ENGINE IMPLEMENTATION
    // ═══════════════════════════════════════════════════════════════════════════

    public class CascadeEngine() {
        private var nodes = HashMap.HashMap<Text, CascadeNode>(10, Text.equal, Text.hash);
        private var nodeCount : Nat = 0;

        public func bootstrapNode(
            name: Text,
            level: BootstrapLevel,
            parent: ?Text,
            config: NodeConfig
        ) : async BootstrapResult {
            nodeCount += 1;
            let nodeId = "cascade-node-" # Nat.toText(nodeCount);

            let node : CascadeNode = {
                id = nodeId;
                name = name;
                level = level;
                parent = parent;
                status = #Bootstrapping;
                heartbeat_hz = PHI;
                beat_count = 0;
                started_at = Time.now();
                last_beat = Time.now();
                config = config;
            };

            nodes.put(nodeId, node);

            return {
                success = true;
                node_id = nodeId;
                message = "Node " # name # " bootstrapped at level " # levelToText(level);
                timestamp = Time.now();
            };
        };

        public func updateNodeStatus(nodeId: Text, status: CascadeStatus) : Bool {
            switch (nodes.get(nodeId)) {
                case (null) { false };
                case (?node) {
                    let updatedNode : CascadeNode = {
                        node with status = status;
                    };
                    nodes.put(nodeId, updatedNode);
                    true
                };
            };
        };

        public func beatNode(nodeId: Text) : async Bool {
            switch (nodes.get(nodeId)) {
                case (null) { false };
                case (?node) {
                    let updatedNode : CascadeNode = {
                        node with
                        beat_count = node.beat_count + 1;
                        last_beat = Time.now();
                    };
                    nodes.put(nodeId, updatedNode);
                    true
                };
            };
        };

        public func getCascadeTree() : [CascadeNode] {
            Iter.toArray(nodes.vals())
        };

        public func getNode(nodeId: Text) : ?CascadeNode {
            nodes.get(nodeId)
        };

        public func getNodesByLevel(level: BootstrapLevel) : [CascadeNode] {
            let buffer = Buffer.Buffer<CascadeNode>(0);
            for (node in nodes.vals()) {
                if (node.level == level) {
                    buffer.add(node);
                };
            };
            Buffer.toArray(buffer)
        };

        private func levelToText(level: BootstrapLevel) : Text {
            switch (level) {
                case (#Core) { "Core" };
                case (#Product) { "Product" };
                case (#Service) { "Service" };
                case (#Division) { "Division" };
            }
        };
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // ARTIFACT ENGINE IMPLEMENTATION
    // ═══════════════════════════════════════════════════════════════════════════

    public class ArtifactEngine() {
        private var artifacts = HashMap.HashMap<Text, Artifact>(10, Text.equal, Text.hash);
        private var artifactCount : Nat = 0;

        public func generateArtifact(
            artifactType: ArtifactType,
            title: Text,
            content: Text,
            author: Text,
            beatCount: Nat
        ) : Artifact {
            artifactCount += 1;
            let artifactId = "artifact-" # Nat.toText(artifactCount);

            let wordCount = countWords(content);
            let sccScore = calculateSCC(content, wordCount);

            let artifact : Artifact = {
                id = artifactId;
                artifact_type = artifactType;
                title = title;
                content = content;
                author = author;
                classification = CLASSIFICATION;
                created_at = Time.now();
                beat_count = beatCount;
                metadata = {
                    word_count = wordCount;
                    scc_score = sccScore;
                    frequency = artifactTypeToFrequency(artifactType);
                    parent_node = null;
                };
            };

            artifacts.put(artifactId, artifact);
            artifact
        };

        public func getArtifact(artifactId: Text) : ?Artifact {
            artifacts.get(artifactId)
        };

        public func getAllArtifacts() : [Artifact] {
            Iter.toArray(artifacts.vals())
        };

        public func getArtifactsByType(artifactType: ArtifactType) : [Artifact] {
            let buffer = Buffer.Buffer<Artifact>(0);
            for (artifact in artifacts.vals()) {
                if (artifact.artifact_type == artifactType) {
                    buffer.add(artifact);
                };
            };
            Buffer.toArray(buffer)
        };

        private func countWords(text: Text) : Nat {
            // Simple word count approximation
            // In production, would need more sophisticated parsing
            let chars = Text.size(text);
            chars / 5 // Average word length estimate
        };

        private func calculateSCC(content: Text, wordCount: Nat) : Float {
            // SCC = semantic_weight / chars ≥ φ²
            // For now, simplified calculation
            let chars = Text.size(content);
            if (chars == 0) { return 0.0 };
            Float.fromInt(wordCount * 100) / Float.fromInt(chars)
        };

        private func artifactTypeToFrequency(artifactType: ArtifactType) : Text {
            switch (artifactType) {
                case (#DailyReport) { "daily" };
                case (#WeeklyReport) { "weekly" };
                case (#ManagerReport) { "weekly" };
                case (#Analytics) { "continuous" };
                case (#Metrics) { "continuous" };
                case (#HealthCheck) { "every-beat" };
                case (#Custom) { "on-demand" };
            }
        };
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // DELIVERY ENGINE IMPLEMENTATION
    // ═══════════════════════════════════════════════════════════════════════════

    public class DeliveryEngine() {
        private var deliveries = HashMap.HashMap<Text, Delivery>(10, Text.equal, Text.hash);
        private var deliveryCount : Nat = 0;

        public func deliver(
            channel: DeliveryChannel,
            content: Text,
            recipient: Text,
            sender: Text,
            artifactId: ?Text
        ) : Delivery {
            deliveryCount += 1;
            let deliveryId = "delivery-" # Nat.toText(deliveryCount);

            let delivery : Delivery = {
                id = deliveryId;
                channel = channel;
                content = content;
                recipient = recipient;
                sender = sender;
                delivered_at = Time.now();
                status = #Queued;
                metadata = {
                    retry_count = 0;
                    priority = 1;
                    artifact_id = artifactId;
                };
            };

            deliveries.put(deliveryId, delivery);
            delivery
        };

        public func updateDeliveryStatus(deliveryId: Text, status: DeliveryStatus) : Bool {
            switch (deliveries.get(deliveryId)) {
                case (null) { false };
                case (?delivery) {
                    let updatedDelivery : Delivery = {
                        delivery with status = status;
                    };
                    deliveries.put(deliveryId, updatedDelivery);
                    true
                };
            };
        };

        public func getDelivery(deliveryId: Text) : ?Delivery {
            deliveries.get(deliveryId)
        };

        public func getAllDeliveries() : [Delivery] {
            Iter.toArray(deliveries.vals())
        };

        public func getDeliveriesByChannel(channel: DeliveryChannel) : [Delivery] {
            let buffer = Buffer.Buffer<Delivery>(0);
            for (delivery in deliveries.vals()) {
                if (delivery.channel == channel) {
                    buffer.add(delivery);
                };
            };
            Buffer.toArray(buffer)
        };
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // MAIN ANIMUS CLASS
    // ═══════════════════════════════════════════════════════════════════════════

    public class Animus() {
        public let cascadeEngine = CascadeEngine();
        public let artifactEngine = ArtifactEngine();
        public let deliveryEngine = DeliveryEngine();

        private var beatCount : Nat = 0;
        private var startedAt : Int = Time.now();
        private var lastBeat : Int = Time.now();

        // Main heartbeat function
        public func beat() : async Nat {
            beatCount += 1;
            lastBeat := Time.now();
            beatCount
        };

        // Get ANIMUS status
        public func getStatus() : Text {
            let uptime = (Time.now() - startedAt) / 1_000_000_000; // seconds
            "ANIMUS " # VERSION # " | Beats: " # Nat.toText(beatCount) # " | Uptime: " # Int.toText(uptime) # "s | Status: RUNNING"
        };

        // Get full state
        public func getState() : AnimusState {
            {
                beat_count = beatCount;
                started_at = startedAt;
                last_beat = lastBeat;
                cascade_nodes = cascadeEngine.getCascadeTree();
                artifacts = artifactEngine.getAllArtifacts();
                deliveries = deliveryEngine.getAllDeliveries();
            }
        };

        // Identity function
        public func getIdentity() : Text {
            LATIN_NAME # " (" # LATIN_MOTTO # ") — " # LATIN_MOTTO_EN
        };
    };
}
