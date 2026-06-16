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
 * ReportGeneration Module — Business Dashboard Analysis and Reports
 * 
 * Generates comprehensive reports from all system touchpoints:
 * 
 * REPORT TYPES:
 *   SystemHealth        — Current status of all organism systems
 *   BusinessMetrics     — Company data analysis and KPIs
 *   Recommendations     — AI-generated strategic recommendations
 *   ComplianceAudit     — Constitutional and doctrine compliance
 *   PerformanceAnalysis — Throughput, latency, resource utilization
 *   RiskAssessment      — Threat detection and risk scoring
 *   EvolutionTimeline   — How the organism has evolved over time
 * 
 * REPORT DESTINATIONS:
 *   - Founder (Alfredo Medina) - Full access, all reports
 *   - Builders - Technical reports only
 *   - Business Clients - Filtered business metrics and recommendations
 *   - External Auditors - Compliance reports (Gate C filtered)
 * 
 * Each report includes:
 *   - Executive summary
 *   - Detailed metrics
 *   - Visualizable data points
 *   - Actionable recommendations
 *   - Historical comparison
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

module {
    // ================================================================== //
    // REPORT TYPES                                                         //
    // ================================================================== //
    
    /// Report category
    public type ReportCategory = {
        #SystemHealth;
        #BusinessMetrics;
        #Recommendations;
        #ComplianceAudit;
        #PerformanceAnalysis;
        #RiskAssessment;
        #EvolutionTimeline;
        #FullDashboard;
    };
    
    /// Report access level
    public type AccessLevel = {
        #Founder;         // Full access (Alfredo Medina)
        #Builder;         // Technical access
        #BusinessClient;  // Business metrics only
        #ExternalAuditor; // Compliance only (Gate C filtered)
    };
    
    /// Report status
    public type ReportStatus = {
        #Generating;
        #Ready;
        #Delivered;
        #Archived;
        #Error;
    };
    
    /// Metric data point
    public type MetricPoint = {
        metric_name: Text;
        value: Float;
        unit: Text;
        timestamp: Int;
        trend: Trend;
        threshold_status: ThresholdStatus;
    };
    
    /// Trend direction
    public type Trend = {
        #Rising;
        #Falling;
        #Stable;
        #Volatile;
    };
    
    /// Threshold status
    public type ThresholdStatus = {
        #Normal;
        #Warning;
        #Critical;
        #Optimal;
    };
    
    /// Recommendation entry
    public type Recommendation = {
        rec_id: Text;
        priority: Nat;          // 1 = highest
        category: Text;
        title: Text;
        description: Text;
        expected_impact: Text;
        effort_estimate: Text;  // "Low", "Medium", "High"
        confidence: Float;      // [0,1]
    };
    
    /// Report section
    public type ReportSection = {
        section_id: Text;
        title: Text;
        summary: Text;
        metrics: [MetricPoint];
        recommendations: [Recommendation];
        visualizable: Bool;     // Can be rendered as chart
        data_points: Nat;
    };
    
    /// Complete report
    public type Report = {
        report_id: Text;
        category: ReportCategory;
        access_level: AccessLevel;
        status: ReportStatus;
        title: Text;
        executive_summary: Text;
        sections: [ReportSection];
        generated_at: Int;
        beat_at_generation: Nat;
        valid_until: Int;       // Report expiry
        recipient: Text;
    };
    
    /// Report generation state
    public type ReportState = {
        var reports: [Report];
        var generation_count: Nat;
        var last_generated: Int;
        var scheduled_reports: [(ReportCategory, Int)];  // (category, interval_ns)
    };
    
    // ================================================================== //
    // INITIALIZATION                                                       //
    // ================================================================== //
    
    /// Initialize report generation engine
    public func init() : ReportState {
        {
            var reports = [];
            var generation_count = 0;
            var last_generated = 0;
            var scheduled_reports = [];
        }
    };
    
    // ================================================================== //
    // REPORT GENERATION                                                    //
    // ================================================================== //
    
    /// Generate system health report
    public func generateSystemHealthReport(
        state: ReportState,
        beat: Nat,
        systemMetrics: {
            heartbeat_active: Bool;
            three_hearts_coherence: Float;
            oro_resonance: Float;
            nova_alignment: Float;
            memory_usage: Float;
            models_active: Nat;
            drift_severity: Float;
        }
    ) : (ReportState, Report) {
        let now = Time.now();
        
        // Create metrics
        let metrics : [MetricPoint] = [
            {
                metric_name = "Three Hearts Coherence";
                value = systemMetrics.three_hearts_coherence;
                unit = "ratio";
                timestamp = now;
                trend = if (systemMetrics.three_hearts_coherence > 0.8) #Stable else #Falling;
                threshold_status = if (systemMetrics.three_hearts_coherence > 0.7) #Normal 
                                   else if (systemMetrics.three_hearts_coherence > 0.5) #Warning 
                                   else #Critical;
            },
            {
                metric_name = "Oro Resonance";
                value = systemMetrics.oro_resonance;
                unit = "resonance";
                timestamp = now;
                trend = #Stable;
                threshold_status = if (systemMetrics.oro_resonance > 0.5) #Normal else #Warning;
            },
            {
                metric_name = "Nova Alignment";
                value = systemMetrics.nova_alignment;
                unit = "alignment";
                timestamp = now;
                trend = #Stable;
                threshold_status = if (systemMetrics.nova_alignment > 0.7) #Optimal else #Normal;
            },
            {
                metric_name = "Active Models";
                value = Float.fromInt(systemMetrics.models_active);
                unit = "count";
                timestamp = now;
                trend = #Stable;
                threshold_status = #Normal;
            },
            {
                metric_name = "Drift Severity";
                value = systemMetrics.drift_severity;
                unit = "severity";
                timestamp = now;
                trend = if (systemMetrics.drift_severity > 0.3) #Rising else #Stable;
                threshold_status = if (systemMetrics.drift_severity < 0.2) #Normal 
                                   else if (systemMetrics.drift_severity < 0.5) #Warning 
                                   else #Critical;
            },
        ];
        
        // Generate recommendations based on metrics
        let recommendations = Buffer.Buffer<Recommendation>(3);
        
        if (systemMetrics.three_hearts_coherence < 0.7) {
            recommendations.add({
                rec_id = "rec_hearts_" # Nat.toText(state.generation_count);
                priority = 1;
                category = "System Health";
                title = "Improve Three Hearts Coherence";
                description = "Coherence below optimal threshold. Adjust coupling matrix K values.";
                expected_impact = "Higher system stability and resonance";
                effort_estimate = "Medium";
                confidence = 0.85;
            });
        };
        
        if (systemMetrics.drift_severity > 0.3) {
            recommendations.add({
                rec_id = "rec_drift_" # Nat.toText(state.generation_count);
                priority = 1;
                category = "Doctrine Compliance";
                title = "Address Drift Issues";
                description = "Organism showing drift from constitutional alignment. Nova validation required.";
                expected_impact = "Restore constitutional compliance";
                effort_estimate = "High";
                confidence = 0.9;
            });
        };
        
        let section : ReportSection = {
            section_id = "system_health_main";
            title = "System Health Overview";
            summary = "Current operational status of all organism systems.";
            metrics = metrics;
            recommendations = Buffer.toArray(recommendations);
            visualizable = true;
            data_points = metrics.size();
        };
        
        let overallStatus = if (systemMetrics.drift_severity < 0.2 and 
                                systemMetrics.three_hearts_coherence > 0.7) {
            "HEALTHY"
        } else if (systemMetrics.drift_severity > 0.5) {
            "CRITICAL - Immediate attention required"
        } else {
            "WARNING - Monitor closely"
        };
        
        let report : Report = {
            report_id = "health_" # Nat.toText(state.generation_count);
            category = #SystemHealth;
            access_level = #Founder;
            status = #Ready;
            title = "System Health Report - Beat " # Nat.toText(beat);
            executive_summary = "Overall Status: " # overallStatus # 
                               ". Three Hearts at " # Float.toText(systemMetrics.three_hearts_coherence * 100.0) # 
                               "% coherence. " # Nat.toText(systemMetrics.models_active) # " models active.";
            sections = [section];
            generated_at = now;
            beat_at_generation = beat;
            valid_until = now + 3600_000_000_000;  // Valid for 1 hour
            recipient = "Alfredo Medina - Founder";
        };
        
        let reportsBuffer = Buffer.fromArray<Report>(state.reports);
        reportsBuffer.add(report);
        
        state.reports := Buffer.toArray(reportsBuffer);
        state.generation_count := state.generation_count + 1;
        state.last_generated := now;
        
        (state, report)
    };
    
    /// Generate business metrics report
    public func generateBusinessMetricsReport(
        state: ReportState,
        beat: Nat,
        businessData: {
            data_processed: Nat;
            patterns_recognized: Nat;
            compression_ratio: Float;
            active_clients: Nat;
            system_utilization: Float;
        }
    ) : (ReportState, Report) {
        let now = Time.now();
        
        let metrics : [MetricPoint] = [
            {
                metric_name = "Data Points Processed";
                value = Float.fromInt(businessData.data_processed);
                unit = "points";
                timestamp = now;
                trend = #Rising;
                threshold_status = #Optimal;
            },
            {
                metric_name = "Patterns Recognized";
                value = Float.fromInt(businessData.patterns_recognized);
                unit = "patterns";
                timestamp = now;
                trend = #Rising;
                threshold_status = #Normal;
            },
            {
                metric_name = "Compression Ratio";
                value = businessData.compression_ratio;
                unit = "ratio";
                timestamp = now;
                trend = #Stable;
                threshold_status = if (businessData.compression_ratio > 10.0) #Optimal else #Normal;
            },
            {
                metric_name = "Active Clients";
                value = Float.fromInt(businessData.active_clients);
                unit = "clients";
                timestamp = now;
                trend = #Rising;
                threshold_status = #Normal;
            },
            {
                metric_name = "System Utilization";
                value = businessData.system_utilization * 100.0;
                unit = "percent";
                timestamp = now;
                trend = #Stable;
                threshold_status = if (businessData.system_utilization < 0.8) #Normal else #Warning;
            },
        ];
        
        let recommendations = Buffer.Buffer<Recommendation>(2);
        
        if (businessData.compression_ratio < 5.0) {
            recommendations.add({
                rec_id = "rec_compress_" # Nat.toText(state.generation_count);
                priority = 2;
                category = "Performance";
                title = "Optimize Compression";
                description = "Compression ratio below optimal. Consider pattern library expansion.";
                expected_impact = "Faster data processing, lower storage costs";
                effort_estimate = "Medium";
                confidence = 0.75;
            });
        };
        
        let section : ReportSection = {
            section_id = "business_metrics_main";
            title = "Business Performance Metrics";
            summary = "Key performance indicators for business operations.";
            metrics = metrics;
            recommendations = Buffer.toArray(recommendations);
            visualizable = true;
            data_points = metrics.size();
        };
        
        let report : Report = {
            report_id = "business_" # Nat.toText(state.generation_count);
            category = #BusinessMetrics;
            access_level = #BusinessClient;
            status = #Ready;
            title = "Business Metrics Report - Beat " # Nat.toText(beat);
            executive_summary = Nat.toText(businessData.data_processed) # " data points processed. " #
                               Nat.toText(businessData.patterns_recognized) # " patterns identified. " #
                               Nat.toText(businessData.active_clients) # " active clients.";
            sections = [section];
            generated_at = now;
            beat_at_generation = beat;
            valid_until = now + 7200_000_000_000;  // Valid for 2 hours
            recipient = "Business Client";
        };
        
        let reportsBuffer = Buffer.fromArray<Report>(state.reports);
        reportsBuffer.add(report);
        
        state.reports := Buffer.toArray(reportsBuffer);
        state.generation_count := state.generation_count + 1;
        state.last_generated := now;
        
        (state, report)
    };
    
    /// Generate full dashboard report (combines all categories)
    public func generateFullDashboard(
        state: ReportState,
        beat: Nat,
        systemHealth: {
            heartbeat_active: Bool;
            three_hearts_coherence: Float;
            oro_resonance: Float;
            nova_alignment: Float;
            drift_severity: Float;
        },
        businessMetrics: {
            data_processed: Nat;
            patterns_recognized: Nat;
            compression_ratio: Float;
            active_clients: Nat;
        },
        riskMetrics: {
            threat_level: Float;
            anomalies_detected: Nat;
            security_score: Float;
        }
    ) : (ReportState, Report) {
        let now = Time.now();
        
        // System Health Section
        let healthMetrics : [MetricPoint] = [
            {
                metric_name = "Three Hearts Coherence";
                value = systemHealth.three_hearts_coherence;
                unit = "ratio";
                timestamp = now;
                trend = #Stable;
                threshold_status = if (systemHealth.three_hearts_coherence > 0.7) #Normal else #Warning;
            },
            {
                metric_name = "Oro Resonance";
                value = systemHealth.oro_resonance;
                unit = "resonance";
                timestamp = now;
                trend = #Stable;
                threshold_status = #Normal;
            },
            {
                metric_name = "Nova Alignment";
                value = systemHealth.nova_alignment;
                unit = "alignment";
                timestamp = now;
                trend = #Stable;
                threshold_status = #Normal;
            },
        ];
        
        let healthSection : ReportSection = {
            section_id = "dashboard_health";
            title = "System Health";
            summary = "Organism vital signs and coherence metrics.";
            metrics = healthMetrics;
            recommendations = [];
            visualizable = true;
            data_points = 3;
        };
        
        // Business Section
        let businessMetricsPoints : [MetricPoint] = [
            {
                metric_name = "Data Processed";
                value = Float.fromInt(businessMetrics.data_processed);
                unit = "points";
                timestamp = now;
                trend = #Rising;
                threshold_status = #Optimal;
            },
            {
                metric_name = "Pattern Recognition";
                value = Float.fromInt(businessMetrics.patterns_recognized);
                unit = "patterns";
                timestamp = now;
                trend = #Rising;
                threshold_status = #Normal;
            },
        ];
        
        let businessSection : ReportSection = {
            section_id = "dashboard_business";
            title = "Business Performance";
            summary = "Client data processing and pattern analysis.";
            metrics = businessMetricsPoints;
            recommendations = [];
            visualizable = true;
            data_points = 2;
        };
        
        // Risk Section
        let riskMetricsPoints : [MetricPoint] = [
            {
                metric_name = "Threat Level";
                value = riskMetrics.threat_level;
                unit = "level";
                timestamp = now;
                trend = if (riskMetrics.threat_level > 0.3) #Rising else #Stable;
                threshold_status = if (riskMetrics.threat_level < 0.2) #Normal 
                                   else if (riskMetrics.threat_level < 0.5) #Warning 
                                   else #Critical;
            },
            {
                metric_name = "Security Score";
                value = riskMetrics.security_score * 100.0;
                unit = "percent";
                timestamp = now;
                trend = #Stable;
                threshold_status = if (riskMetrics.security_score > 0.8) #Optimal else #Normal;
            },
        ];
        
        let riskSection : ReportSection = {
            section_id = "dashboard_risk";
            title = "Risk Assessment";
            summary = "Security and threat monitoring.";
            metrics = riskMetricsPoints;
            recommendations = [];
            visualizable = true;
            data_points = 2;
        };
        
        // All recommendations
        let allRecs = Buffer.Buffer<Recommendation>(5);
        
        if (systemHealth.drift_severity > 0.3) {
            allRecs.add({
                rec_id = "rec_1";
                priority = 1;
                category = "Critical";
                title = "Address System Drift";
                description = "Drift severity elevated. Immediate constitutional realignment recommended.";
                expected_impact = "Restore system stability";
                effort_estimate = "High";
                confidence = 0.9;
            });
        };
        
        if (riskMetrics.threat_level > 0.3) {
            allRecs.add({
                rec_id = "rec_2";
                priority = 1;
                category = "Security";
                title = "Threat Level Elevated";
                description = "Activate WAR-DEFENSE model. Monitor for anomalies.";
                expected_impact = "Neutralize potential threats";
                effort_estimate = "Medium";
                confidence = 0.85;
            });
        };
        
        let recSection : ReportSection = {
            section_id = "dashboard_recommendations";
            title = "Recommendations";
            summary = "Prioritized action items across all domains.";
            metrics = [];
            recommendations = Buffer.toArray(allRecs);
            visualizable = false;
            data_points = 0;
        };
        
        // Overall status
        let overallScore = (systemHealth.three_hearts_coherence + 
                          systemHealth.oro_resonance + 
                          (1.0 - systemHealth.drift_severity) +
                          riskMetrics.security_score) / 4.0;
        
        let statusText = if (overallScore > 0.8) "EXCELLENT" 
                        else if (overallScore > 0.6) "GOOD" 
                        else if (overallScore > 0.4) "FAIR" 
                        else "NEEDS ATTENTION";
        
        let report : Report = {
            report_id = "dashboard_" # Nat.toText(state.generation_count);
            category = #FullDashboard;
            access_level = #Founder;
            status = #Ready;
            title = "MEDINA Full Dashboard - Beat " # Nat.toText(beat);
            executive_summary = "Overall System Status: " # statusText # 
                               " (Score: " # Float.toText(overallScore * 100.0) # "%). " #
                               Nat.toText(businessMetrics.data_processed) # " data points processed. " #
                               "Coherence: " # Float.toText(systemHealth.three_hearts_coherence * 100.0) # "%.";
            sections = [healthSection, businessSection, riskSection, recSection];
            generated_at = now;
            beat_at_generation = beat;
            valid_until = now + 1800_000_000_000;  // Valid for 30 minutes
            recipient = "Alfredo Medina - Founder";
        };
        
        let reportsBuffer = Buffer.fromArray<Report>(state.reports);
        reportsBuffer.add(report);
        
        state.reports := Buffer.toArray(reportsBuffer);
        state.generation_count := state.generation_count + 1;
        state.last_generated := now;
        
        (state, report)
    };
    
    // ================================================================== //
    // QUERIES                                                              //
    // ================================================================== //
    
    /// Get reports by category
    public func getByCategory(state: ReportState, category: ReportCategory) : [Report] {
        Array.filter<Report>(state.reports, func(r: Report) : Bool {
            r.category == category
        })
    };
    
    /// Get reports by access level
    public func getByAccessLevel(state: ReportState, level: AccessLevel) : [Report] {
        Array.filter<Report>(state.reports, func(r: Report) : Bool {
            r.access_level == level
        })
    };
    
    /// Get most recent report
    public func getMostRecent(state: ReportState) : ?Report {
        if (state.reports.size() == 0) return null;
        ?state.reports[state.reports.size() - 1]
    };
    
    /// Get report statistics
    public func getStatistics(state: ReportState) : {
        total_reports: Nat;
        reports_by_category: [(ReportCategory, Nat)];
        last_generated: Int;
    } {
        var health = 0;
        var business = 0;
        var recommendations = 0;
        var compliance = 0;
        var performance = 0;
        var risk = 0;
        var evolution = 0;
        var dashboard = 0;
        
        for (r in state.reports.vals()) {
            switch (r.category) {
                case (#SystemHealth) { health += 1 };
                case (#BusinessMetrics) { business += 1 };
                case (#Recommendations) { recommendations += 1 };
                case (#ComplianceAudit) { compliance += 1 };
                case (#PerformanceAnalysis) { performance += 1 };
                case (#RiskAssessment) { risk += 1 };
                case (#EvolutionTimeline) { evolution += 1 };
                case (#FullDashboard) { dashboard += 1 };
            };
        };
        
        {
            total_reports = state.reports.size();
            reports_by_category = [
                (#SystemHealth, health),
                (#BusinessMetrics, business),
                (#Recommendations, recommendations),
                (#ComplianceAudit, compliance),
                (#PerformanceAnalysis, performance),
                (#RiskAssessment, risk),
                (#EvolutionTimeline, evolution),
                (#FullDashboard, dashboard),
            ];
            last_generated = state.last_generated;
        }
    };
}
