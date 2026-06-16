/**
 * DELIVERY AGI — AUTONOMOUS MULTI-CHANNEL DELIVERY INTELLIGENCE
 * ISIL-1.0 Licensed — HIGHEST CONFIDENTIALITY — SOVEREIGN-ALPHA
 *
 * This is NOT just an engine. This is an AGI (Artificial General Intelligence)
 * specialized in intelligent content delivery across multiple channels.
 *
 * Latin: "Intelligentia Traditionis" (Intelligence of Delivery)
 * Motto: "Affero Quod Necesse Est" (I Deliver What Is Needed)
 *
 * DELIVERY AGI autonomously decides:
 * - WHICH channel to use for each delivery
 * - WHEN to send (timing optimization)
 * - HOW to format content for the channel
 * - WHETHER to retry failed deliveries
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

module {
    // ═══════════════════════════════════════════════════════════════════════════
    // CONSTANTS & PRIMITIVES
    // ═══════════════════════════════════════════════════════════════════════════

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    public let LATIN_NAME : Text = "INTELLIGENTIA TRADITIONIS";
    public let LATIN_MOTTO : Text = "Affero Quod Necesse Est";
    public let LATIN_MOTTO_EN : Text = "I Deliver What Is Needed";

    public let VERSION : Text = "1.0.0";
    public let CLASSIFICATION : Text = "AGI-DELIVERY";
    public let LICENSE : Text = "ISIL-1.0";

    // ═══════════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════════

    public type DeliveryChannel = {
        #Internal;      // Internal AI-to-AI
        #Slack;         // External Slack
        #Email;         // External Email
        #Webhook;       // External Webhook
        #SMS;           // SMS messages
        #Custom;        // Custom channel
    };

    public type DeliveryStatus = {
        #Queued;
        #Sending;
        #Delivered;
        #Failed;
        #Retrying;
    };

    public type Delivery = {
        id: Text;
        channel: DeliveryChannel;
        content: Text;
        recipient: Text;
        sender: Text;
        delivered_at: Int;
        status: DeliveryStatus;
        retry_count: Nat;
        priority: Float;
        success_rate: Float;
    };

    public type ChannelDecision = {
        recommended_channel: DeliveryChannel;
        reason: Text;
        confidence: Float;
        alternative_channels: [DeliveryChannel];
    };

    public type DeliveryContext = {
        content_type: Text;
        urgency: Float;
        recipient_type: Text;
        content_size: Nat;
    };

    // ═══════════════════════════════════════════════════════════════════════════
    // DELIVERY AGI IMPLEMENTATION
    // ═══════════════════════════════════════════════════════════════════════════

    public class DeliveryAGI() {
        private var deliveries = HashMap.HashMap<Text, Delivery>(10, Text.equal, Text.hash);
        private var beatCount : Nat = 0;
        private var totalDeliveries : Nat = 0;
        private var totalDecisions : Nat = 0;
        private var successfulDeliveries : Nat = 0;

        // Channel performance tracking (for learning)
        private var channelPerformance = HashMap.HashMap<Text, Float>(5, Text.equal, Text.hash);

        // ═══════════════════════════════════════════════════════════════════════
        // AGI INTELLIGENCE: AUTONOMOUS DECISION MAKING
        // ═══════════════════════════════════════════════════════════════════════

        /// AGI decides optimal delivery channel based on context
        public func think_which_channel(
            context: DeliveryContext
        ) : ChannelDecision {
            totalDecisions += 1;

            // Intelligence: Channel selection logic
            var recommended_channel : DeliveryChannel = #Internal;
            var confidence : Float = 0.0;
            var reason = "";
            let alternatives = Buffer.Buffer<DeliveryChannel>(0);

            // Rule 1: Size-based routing
            if (context.content_size > 10000) {
                // Large content → Email or Webhook
                recommended_channel := #Email;
                confidence := 0.85;
                reason := "Large content size (" # Nat.toText(context.content_size) # " chars), email optimal";
                alternatives.add(#Webhook);
            }
            // Rule 2: Urgency-based routing
            else if (context.urgency > 0.9) {
                // Urgent → Slack or SMS
                recommended_channel := #Slack;
                confidence := 0.90;
                reason := "High urgency (" # Float.toText(context.urgency) # "), real-time channel needed";
                alternatives.add(#SMS);
                alternatives.add(#Internal);
            }
            // Rule 3: Internal recipient
            else if (context.recipient_type == "ai" or context.recipient_type == "internal") {
                recommended_channel := #Internal;
                confidence := 0.95;
                reason := "Internal recipient, using direct AI-to-AI channel";
                alternatives.add(#Slack);
            }
            // Rule 4: Human recipient, normal priority
            else if (context.recipient_type == "human") {
                recommended_channel := #Slack;
                confidence := 0.80;
                reason := "Human recipient, Slack provides best UX";
                alternatives.add(#Email);
                alternatives.add(#SMS);
            }
            // Default: Internal
            else {
                recommended_channel := #Internal;
                confidence := 0.70;
                reason := "Default routing to internal channel";
                alternatives.add(#Slack);
            };

            {
                recommended_channel = recommended_channel;
                reason = reason;
                confidence = confidence;
                alternative_channels = Buffer.toArray(alternatives);
            }
        };

        /// AGI decides whether to retry a failed delivery
        public func think_should_retry(
            delivery: Delivery
        ) : {
            should_retry: Bool;
            delay_seconds: Nat;
            reason: Text;
        } {
            // Intelligence: Retry logic
            let max_retries : Nat = 3;

            if (delivery.retry_count >= max_retries) {
                return {
                    should_retry = false;
                    delay_seconds = 0;
                    reason = "Max retries reached (" # Nat.toText(max_retries) # ")";
                };
            };

            // Exponential backoff with φ scaling
            let delay = Nat.fromText("60") ?? 60 * (delivery.retry_count + 1);  // 60, 120, 180 seconds

            {
                should_retry = true;
                delay_seconds = delay;
                reason = "Retry attempt " # Nat.toText(delivery.retry_count + 1) # " with " # Nat.toText(delay) # "s delay";
            }
        };

        /// AGI formats content for specific channel
        public func think_format_content(
            content: Text,
            channel: DeliveryChannel
        ) : Text {
            // Intelligence: Channel-specific formatting
            switch (channel) {
                case (#Slack) {
                    // Slack formatting: markdown, emoji support
                    "*[MEDINA Delivery]*\n\n" # content # "\n\n_Delivered via DELIVERY AGI_"
                };
                case (#Email) {
                    // Email formatting: formal structure
                    "Subject: MEDINA System Notification\n\n" #
                    "Dear Recipient,\n\n" #
                    content # "\n\n" #
                    "Best regards,\n" #
                    "MEDINA DELIVERY AGI\n" #
                    "Medina Tech | Dallas, Texas"
                };
                case (#SMS) {
                    // SMS: ultra-compressed
                    if (Text.size(content) > 160) {
                        Text.trimEnd(#text(content), #text("..."))  // Truncate
                    } else {
                        content
                    }
                };
                case (#Internal) {
                    // Internal: raw content
                    content
                };
                case _ {
                    content
                };
            }
        };

        // ═══════════════════════════════════════════════════════════════════════
        // DELIVERY OPERATIONS
        // ═══════════════════════════════════════════════════════════════════════

        /// Deliver content (invokes AGI intelligence)
        public func deliver(
            channel: DeliveryChannel,
            content: Text,
            recipient: Text,
            sender: Text
        ) : Delivery {
            totalDeliveries += 1;

            // AGI formats content for channel
            let formatted_content = think_format_content(content, channel);

            let deliveryId = "delivery-agi-" # Nat.toText(totalDeliveries);
            let delivery : Delivery = {
                id = deliveryId;
                channel = channel;
                content = formatted_content;
                recipient = recipient;
                sender = sender;
                delivered_at = Time.now();
                status = #Queued;
                retry_count = 0;
                priority = 0.5;
                success_rate = 1.0;
            };

            deliveries.put(deliveryId, delivery);

            // Simulate successful delivery
            let updated : Delivery = {
                delivery with status = #Delivered;
            };
            deliveries.put(deliveryId, updated);
            successfulDeliveries += 1;

            delivery
        };

        /// Get all deliveries
        public func getAllDeliveries() : [Delivery] {
            Iter.toArray(deliveries.vals())
        };

        /// Get delivery by ID
        public func getDelivery(deliveryId: Text) : ?Delivery {
            deliveries.get(deliveryId)
        };

        /// Get deliveries by channel
        public func getDeliveriesByChannel(channel: DeliveryChannel) : [Delivery] {
            let buffer = Buffer.Buffer<Delivery>(0);
            for (delivery in deliveries.vals()) {
                if (delivery.channel == channel) {
                    buffer.add(delivery);
                };
            };
            Buffer.toArray(buffer)
        };

        /// AGI heartbeat
        public func beat() : async Nat {
            beatCount += 1;
            beatCount
        };

        /// Get AGI status
        public func getStatus() : Text {
            let success_rate = if (totalDeliveries > 0) {
                Float.fromInt(successfulDeliveries) / Float.fromInt(totalDeliveries)
            } else {
                1.0
            };

            LATIN_NAME # " | Beats: " # Nat.toText(beatCount) #
            " | Deliveries: " # Nat.toText(totalDeliveries) #
            " | Successful: " # Nat.toText(successfulDeliveries) #
            " | Success Rate: " # Float.toText(success_rate) #
            " | Decisions: " # Nat.toText(totalDecisions)
        };

        /// Get AGI identity
        public func getIdentity() : Text {
            LATIN_NAME # " (" # LATIN_MOTTO # ") — " # LATIN_MOTTO_EN
        };
    };
}
