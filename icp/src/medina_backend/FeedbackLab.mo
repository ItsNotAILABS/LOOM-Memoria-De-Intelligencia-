/**
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                         FEEDBACK LABORATORY                               ║
 * ║                         "Laboratorium Responsi"                           ║
 * ║                                                                           ║
 * ║  INTERNAL FEEDBACK PROCESSING — THE LAB THAT MAINTAINS THE PLATFORM       ║
 * ║                                                                           ║
 * ║  "Omnis responsio est donum. Omnis donum est evolutio."                  ║
 * ║  (Every response is a gift. Every gift is evolution.)                    ║
 * ║                                                                           ║
 * ║  ARCHITECTURE:                                                            ║
 * ║  ┌─────────────────────────────────────────────────────────────────────┐ ║
 * ║  │                      FEEDBACK BOX (User-facing)                     │ ║
 * ║  │                               │                                      │ ║
 * ║  │                     ┌─────────┴─────────┐                           │ ║
 * ║  │                     │    INTAKE QUEUE   │                           │ ║
 * ║  │                     └─────────┬─────────┘                           │ ║
 * ║  │                               │                                      │ ║
 * ║  │  ┌─────────────────────────────────────────────────────────────┐   │ ║
 * ║  │  │                    FEEDBACK LABORATORY                       │   │ ║
 * ║  │  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐           │   │ ║
 * ║  │  │  │ GRADING │ │ ANALYZE │ │ RESEARCH│ │ ACTION  │           │   │ ║
 * ║  │  │  │  MODEL  │ │  MODEL  │ │  MODEL  │ │  MODEL  │           │   │ ║
 * ║  │  │  └────┬────┘ └────┬────┘ └────┬────┘ └────┬────┘           │   │ ║
 * ║  │  │       │           │           │           │                  │   │ ║
 * ║  │  │       └───────────┴─────┬─────┴───────────┘                  │   │ ║
 * ║  │  │                         │                                     │   │ ║
 * ║  │  │                   ┌─────┴─────┐                              │   │ ║
 * ║  │  │                   │ DECISION  │                              │   │ ║
 * ║  │  │                   │  ENGINE   │                              │   │ ║
 * ║  │  │                   └─────┬─────┘                              │   │ ║
 * ║  │  └─────────────────────────┼───────────────────────────────────┘   │ ║
 * ║  │                            │                                        │ ║
 * ║  │  ┌─────────────────┬───────┴───────┬─────────────────┐            │ ║
 * ║  │  │                 │               │                 │            │ ║
 * ║  │  ▼                 ▼               ▼                 ▼            │ ║
 * ║  │ REWARD          ORGANISM        RESEARCH          NOTIFY          │ ║
 * ║  │ USER            UPDATE          BRANCH            FOUNDER         │ ║
 * ║  └─────────────────────────────────────────────────────────────────────┘ ║
 * ║                                                                           ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez                          ║
 * ║  PROPRIETARY AND CONFIDENTIAL - MAXIMUM SECRECY                          ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import SemperMemoria "SemperMemoria";

module {
    // ================================================================== //
    // LABORATORY CONSTANTS                                                 //
    // ================================================================== //
    
    /// Lab doctrine in Latin
    public let LAB_DOCTRINE : Text = "Omnis responsio est donum. Omnis donum est evolutio.";
    
    /// Lab doctrine in English
    public let LAB_DOCTRINE_EN : Text = "Every response is a gift. Every gift is evolution.";
    
    /// Golden ratio for grading weights
    public let PHI : Float = MatalkoICP.PHI;
    
    // ================================================================== //
    // LABORATORY TYPES                                                     //
    // ================================================================== //
    
    /// Feedback Lab - internal processing unit
    public type FeedbackLab = {
        lab_id: Text;
        name: Text;
        
        // Models in this lab
        models: [LabModel];
        
        // Processing stats
        processed_today: Nat;
        processed_total: Nat;
        
        // Queue
        queue_size: Nat;
        oldest_in_queue: ?Int;
        
        // Health
        health: Float;
        capacity: Float;
        
        // Products served
        products_served: [SemperMemoria.SaaSProduct];
    };
    
    /// Lab Model - specialized feedback processing model
    public type LabModel = {
        model_id: Text;
        name: Text;
        model_type: LabModelType;
        
        // Performance
        accuracy: Float;
        throughput: Nat;  // Items per hour
        
        // State
        active: Bool;
        last_invoked: Int;
        invocation_count: Nat;
    };
    
    /// Types of lab models
    public type LabModelType = {
        #Grading;     // Grades feedback quality
        #Analysis;    // Analyzes content for insights
        #Research;    // Identifies research opportunities
        #Action;      // Determines required actions
        #Reward;      // Calculates user rewards
        #Notify;      // Handles founder notifications
    };
    
    /// Processed feedback result
    public type ProcessedFeedback = {
        // Original feedback
        original: SemperMemoria.Feedback;
        
        // Processing results
        grade: SemperMemoria.FeedbackGrade;
        analysis: FeedbackAnalysis;
        actions: [FeedbackAction];
        
        // Outcomes
        reward_amount: Nat;
        reward_issued: Bool;
        organism_updated: Bool;
        research_initiated: Bool;
        founder_notified: Bool;
        
        // Timing
        received_at: Int;
        processed_at: Int;
        processing_duration_ns: Int;
    };
    
    /// Detailed analysis of feedback
    public type FeedbackAnalysis = {
        // Content analysis
        sentiment: Sentiment;
        topics: [Text];
        keywords: [Text];
        
        // Impact assessment
        user_impact: Float;      // How much this affects users
        platform_impact: Float;  // How much this affects platform
        business_impact: Float;  // How much this affects business
        
        // Classification
        is_bug_report: Bool;
        is_feature_request: Bool;
        is_improvement: Bool;
        is_praise: Bool;
        is_complaint: Bool;
        
        // Patterns
        similar_feedback_count: Nat;  // How many similar reports exist
        trending: Bool;               // Is this a trending issue
        
        // Research potential
        research_potential: Float;    // 0-1 potential for new research
        model_opportunity: Bool;      // Could spawn new model
    };
    
    /// Sentiment analysis result
    public type Sentiment = {
        #VeryPositive;
        #Positive;
        #Neutral;
        #Negative;
        #VeryNegative;
    };
    
    /// Action to take based on feedback
    public type FeedbackAction = {
        action_id: Text;
        action_type: ActionType;
        priority: Nat;           // 1 (highest) to 5 (lowest)
        description: Text;
        
        // Execution
        auto_execute: Bool;      // Can be auto-executed
        requires_approval: Bool; // Needs founder approval
        executed: Bool;
        executed_at: ?Int;
    };
    
    /// Types of actions
    public type ActionType = {
        #RewardUser;
        #UpdateOrganism;
        #CreateResearchBranch;
        #NotifyFounder;
        #CreateTicket;
        #UpdateDocumentation;
        #ImproveModel;
        #CreateNewModel;
        #ScheduleMaintenance;
        #Acknowledge;
    };
    
    /// Founder notification
    public type FounderNotification = {
        notification_id: Text;
        feedback_id: Text;
        
        // Content
        summary: Text;
        urgency: Urgency;
        
        // Research opportunity
        research_branch: ?Text;
        potential_models: [Text];
        
        // Status
        sent_at: Int;
        sent_via: NotificationChannel;
        
        // Response
        response_received: Bool;
        response: ?FounderResponse;
        response_at: ?Int;
    };
    
    /// Notification urgency
    public type Urgency = {
        #Critical;    // Immediate attention required
        #High;        // Same-day response needed
        #Medium;      // Within 48 hours
        #Low;         // When convenient
        #Info;        // FYI only
    };
    
    /// Notification channel
    public type NotificationChannel = {
        #SMS;
        #Email;
        #InApp;
        #Webhook;
    };
    
    /// Founder's response to notification
    public type FounderResponse = {
        approved: Bool;
        feedback: ?Text;
        additional_instructions: ?Text;
    };
    
    // ================================================================== //
    // LAB CREATION                                                         //
    // ================================================================== //
    
    /// Create a feedback lab for a product
    public func createFeedbackLab(
        product: SemperMemoria.SaaSProduct
    ) : FeedbackLab {
        let lab_id = "LAB-" # SemperMemoria.productCode(product);
        
        {
            lab_id = lab_id;
            name = labNameForProduct(product);
            models = createLabModels(lab_id);
            processed_today = 0;
            processed_total = 0;
            queue_size = 0;
            oldest_in_queue = null;
            health = 1.0;
            capacity = 1.0;
            products_served = [product];
        }
    };
    
    /// Get Latin name for lab
    func labNameForProduct(product: SemperMemoria.SaaSProduct) : Text {
        switch (product) {
            case (#MemoriaPerpetua) { "Laboratorium Memoriae" };
            case (#Cognitio) { "Laboratorium Intelligentiae" };
            case (#Custodia) { "Laboratorium Gubernationis" };
            case (#DocumentumVivum) { "Laboratorium Documentorum" };
            case (#TresCorda) { "Laboratorium Cordium" };
            case (#CatenaAnima) { "Laboratorium Catenae" };
            case (#Templum) { "Laboratorium Templi" };
            case (#Socius) { "Laboratorium Sociorum" };
            case (#Praesidium) { "Laboratorium Praesidii" };
            case (#Infinitas) { "Laboratorium Infinitatis" };
        }
    };
    
    /// Create standard lab models
    func createLabModels(lab_id: Text) : [LabModel] {
        [
            createLabModel(lab_id, "Grading", #Grading),
            createLabModel(lab_id, "Analysis", #Analysis),
            createLabModel(lab_id, "Research", #Research),
            createLabModel(lab_id, "Action", #Action),
            createLabModel(lab_id, "Reward", #Reward),
            createLabModel(lab_id, "Notify", #Notify)
        ]
    };
    
    /// Create a single lab model
    func createLabModel(
        lab_id: Text,
        name: Text,
        model_type: LabModelType
    ) : LabModel {
        let model_id = lab_id # "-MODEL-" # name;
        
        {
            model_id = model_id;
            name = name;
            model_type = model_type;
            accuracy = 0.95;  // Default high accuracy
            throughput = 1000; // Items per hour
            active = true;
            last_invoked = Time.now();
            invocation_count = 0;
        }
    };
    
    // ================================================================== //
    // FEEDBACK PROCESSING                                                  //
    // ================================================================== //
    
    /// Process feedback through the lab
    public func processFeedback(
        lab: FeedbackLab,
        feedback: SemperMemoria.Feedback
    ) : ProcessedFeedback {
        let received_at = Time.now();
        
        // Step 1: Grade the feedback
        let grade = SemperMemoria.gradeFeedback(feedback);
        
        // Step 2: Analyze the feedback
        let analysis = analyzeFeedback(feedback);
        
        // Step 3: Determine actions
        let actions = determineActions(feedback, grade, analysis);
        
        // Step 4: Calculate reward
        let reward_amount = SemperMemoria.calculateReward(grade);
        
        // Step 5: Check if founder notification needed
        let notify_founder = grade.notify_founder;
        
        let processed_at = Time.now();
        
        {
            original = feedback;
            grade = grade;
            analysis = analysis;
            actions = actions;
            
            reward_amount = reward_amount;
            reward_issued = false;  // Will be issued separately
            organism_updated = false;
            research_initiated = grade.new_model_research;
            founder_notified = notify_founder;
            
            received_at = received_at;
            processed_at = processed_at;
            processing_duration_ns = processed_at - received_at;
        }
    };
    
    /// Analyze feedback content
    func analyzeFeedback(feedback: SemperMemoria.Feedback) : FeedbackAnalysis {
        // Determine sentiment from category and content
        let sentiment = determineSentiment(feedback);
        
        // Extract topics (simplified - would use NLP in production)
        let topics = extractTopics(feedback.content);
        
        // Extract keywords
        let keywords = extractKeywords(feedback.content);
        
        // Classify
        let is_bug = feedback.category == #Bug;
        let is_feature = feedback.category == #Feature;
        let is_improvement = feedback.category == #Improvement;
        let is_praise = feedback.category == #Praise;
        let is_complaint = sentimentToScore(sentiment) < 0.4;
        
        {
            sentiment = sentiment;
            topics = topics;
            keywords = keywords;
            
            user_impact = calculateUserImpact(feedback);
            platform_impact = calculatePlatformImpact(feedback);
            business_impact = calculateBusinessImpact(feedback);
            
            is_bug_report = is_bug;
            is_feature_request = is_feature;
            is_improvement = is_improvement;
            is_praise = is_praise;
            is_complaint = is_complaint;
            
            similar_feedback_count = 0;  // Would check database
            trending = false;             // Would check trends
            
            research_potential = calculateResearchPotential(feedback);
            model_opportunity = calculateResearchPotential(feedback) > 0.7;
        }
    };
    
    /// Determine sentiment
    func determineSentiment(feedback: SemperMemoria.Feedback) : Sentiment {
        switch (feedback.category) {
            case (#Praise) { #VeryPositive };
            case (#Feature) { #Positive };
            case (#Improvement) { #Neutral };
            case (#Question) { #Neutral };
            case (#Bug) { #Negative };
            case (#Other) { #Neutral };
        }
    };
    
    /// Convert sentiment to score
    func sentimentToScore(sentiment: Sentiment) : Float {
        switch (sentiment) {
            case (#VeryPositive) { 1.0 };
            case (#Positive) { 0.75 };
            case (#Neutral) { 0.5 };
            case (#Negative) { 0.25 };
            case (#VeryNegative) { 0.0 };
        }
    };
    
    /// Extract topics (simplified)
    func extractTopics(content: Text) : [Text] {
        // In production, would use NLP
        if (Text.contains(content, #text("memory"))) {
            return ["memory", "storage"];
        };
        if (Text.contains(content, #text("speed"))) {
            return ["performance", "optimization"];
        };
        if (Text.contains(content, #text("error"))) {
            return ["bugs", "stability"];
        };
        ["general"]
    };
    
    /// Extract keywords (simplified)
    func extractKeywords(content: Text) : [Text] {
        // In production, would use NLP
        []
    };
    
    /// Calculate user impact
    func calculateUserImpact(feedback: SemperMemoria.Feedback) : Float {
        switch (feedback.category) {
            case (#Bug) { 0.9 };
            case (#Feature) { 0.7 };
            case (#Improvement) { 0.6 };
            case (#Praise) { 0.3 };
            case (#Question) { 0.4 };
            case (#Other) { 0.5 };
        }
    };
    
    /// Calculate platform impact
    func calculatePlatformImpact(feedback: SemperMemoria.Feedback) : Float {
        switch (feedback.category) {
            case (#Bug) { 0.8 };
            case (#Feature) { 0.6 };
            case (#Improvement) { 0.5 };
            case (#Praise) { 0.2 };
            case (#Question) { 0.3 };
            case (#Other) { 0.4 };
        }
    };
    
    /// Calculate business impact
    func calculateBusinessImpact(feedback: SemperMemoria.Feedback) : Float {
        switch (feedback.category) {
            case (#Bug) { 0.7 };
            case (#Feature) { 0.8 };
            case (#Improvement) { 0.6 };
            case (#Praise) { 0.4 };
            case (#Question) { 0.3 };
            case (#Other) { 0.4 };
        }
    };
    
    /// Calculate research potential
    func calculateResearchPotential(feedback: SemperMemoria.Feedback) : Float {
        switch (feedback.category) {
            case (#Feature) { 0.9 };
            case (#Improvement) { 0.7 };
            case (#Bug) { 0.5 };
            case (#Question) { 0.4 };
            case (#Praise) { 0.2 };
            case (#Other) { 0.3 };
        }
    };
    
    /// Determine actions based on feedback
    func determineActions(
        feedback: SemperMemoria.Feedback,
        grade: SemperMemoria.FeedbackGrade,
        analysis: FeedbackAnalysis
    ) : [FeedbackAction] {
        let actions = Buffer.Buffer<FeedbackAction>(4);
        var action_counter : Nat = 0;
        
        // Always: Reward user
        action_counter += 1;
        actions.add({
            action_id = "ACT-" # feedback.feedback_id # "-" # Nat.toText(action_counter);
            action_type = #RewardUser;
            priority = 1;
            description = "Issue crypto reward to user";
            auto_execute = true;
            requires_approval = false;
            executed = false;
            executed_at = null;
        });
        
        // Always: Acknowledge
        action_counter += 1;
        actions.add({
            action_id = "ACT-" # feedback.feedback_id # "-" # Nat.toText(action_counter);
            action_type = #Acknowledge;
            priority = 1;
            description = "Acknowledge feedback receipt";
            auto_execute = true;
            requires_approval = false;
            executed = false;
            executed_at = null;
        });
        
        // If organism update needed
        if (grade.organism_update) {
            action_counter += 1;
            actions.add({
                action_id = "ACT-" # feedback.feedback_id # "-" # Nat.toText(action_counter);
                action_type = #UpdateOrganism;
                priority = 2;
                description = "Update organism based on feedback";
                auto_execute = false;
                requires_approval = true;
                executed = false;
                executed_at = null;
            });
        };
        
        // If research potential
        if (grade.new_model_research) {
            action_counter += 1;
            actions.add({
                action_id = "ACT-" # feedback.feedback_id # "-" # Nat.toText(action_counter);
                action_type = #CreateResearchBranch;
                priority = 3;
                description = "Create research branch for new model investigation";
                auto_execute = false;
                requires_approval = true;
                executed = false;
                executed_at = null;
            });
        };
        
        // If founder notification needed
        if (grade.notify_founder) {
            action_counter += 1;
            actions.add({
                action_id = "ACT-" # feedback.feedback_id # "-" # Nat.toText(action_counter);
                action_type = #NotifyFounder;
                priority = 1;
                description = "Notify founder of high-priority feedback";
                auto_execute = true;
                requires_approval = false;
                executed = false;
                executed_at = null;
            });
        };
        
        // If bug, create ticket
        if (analysis.is_bug_report) {
            action_counter += 1;
            actions.add({
                action_id = "ACT-" # feedback.feedback_id # "-" # Nat.toText(action_counter);
                action_type = #CreateTicket;
                priority = 2;
                description = "Create bug ticket for investigation";
                auto_execute = true;
                requires_approval = false;
                executed = false;
                executed_at = null;
            });
        };
        
        Buffer.toArray(actions)
    };
    
    // ================================================================== //
    // FOUNDER NOTIFICATION                                                 //
    // ================================================================== //
    
    /// Create founder notification
    public func createFounderNotification(
        processed: ProcessedFeedback
    ) : FounderNotification {
        let notification_id = "NOTIF-" # processed.original.feedback_id;
        
        // Determine urgency
        let urgency = if (processed.grade.overall >= 0.95) {
            #Critical
        } else if (processed.grade.overall >= 0.9) {
            #High
        } else if (processed.grade.overall >= 0.8) {
            #Medium
        } else {
            #Low
        };
        
        // Build summary
        let summary = buildNotificationSummary(processed);
        
        {
            notification_id = notification_id;
            feedback_id = processed.original.feedback_id;
            summary = summary;
            urgency = urgency;
            research_branch = processed.grade.branch_for_research;
            potential_models = [];  // Would be populated by research model
            sent_at = Time.now();
            sent_via = #SMS;  // Default to SMS for founder
            response_received = false;
            response = null;
            response_at = null;
        }
    };
    
    /// Build notification summary
    func buildNotificationSummary(processed: ProcessedFeedback) : Text {
        let category = switch (processed.original.category) {
            case (#Bug) { "BUG" };
            case (#Feature) { "FEATURE" };
            case (#Improvement) { "IMPROVEMENT" };
            case (#Praise) { "PRAISE" };
            case (#Question) { "QUESTION" };
            case (#Other) { "OTHER" };
        };
        
        "[" # category # "] Grade: " # 
        Float.toText(processed.grade.overall) # 
        " | Research: " # (if (processed.research_initiated) { "YES" } else { "NO" }) #
        " | Content: " # truncate(processed.original.content, 100)
    };
    
    /// Truncate text
    func truncate(text: Text, maxLen: Nat) : Text {
        if (Text.size(text) <= maxLen) {
            text
        } else {
            Text.fromIter(Text.toIter(text).take(maxLen)) # "..."
        }
    };
}
