/**
 * SovereignDefenseSystem Module — AEGIS Threat Tiers + Gate Sequencing
 * 
 * AEGIS DEFENSE ARCHITECTURE:
 *   9 threat tiers with escalating responses
 *   Gate sequencing with Non-Zeno observation response
 *   Defense mode state changes are encrypted on-chain artifacts
 * 
 * THREAT TIERS:
 *   Tier 1: Anomaly Detection — Log and monitor
 *   Tier 2: Pattern Recognition — Analyze and flag
 *   Tier 3: Boundary Probe — Increase monitoring, notify
 *   Tier 4: Infiltration Attempt — Isolate, quarantine
 *   Tier 5: Active Breach — Lock affected components
 *   Tier 6: System Compromise — Emergency protocols
 *   Tier 7: Doctrine Threat — Founder notification
 *   Tier 8: Sovereignty Attack — Full lockdown
 *   Tier 9: Existential Threat — Freeze all, protect core
 * 
 * NON-ZENO OBSERVATION:
 *   The organism does not freeze when observed.
 *   Observation propels (if aligned) or protects (if misaligned).
 *   O(Ψ) = Ψ × (1 + k × confidence)
 * 
 * GATE SEQUENCING:
 *   - Gate A: Runtime readiness validation
 *   - Gate B: Workforce activation
 *   - Gate C: Projection safety
 *   - M-101: Agent return gate
 *   - M-102: Self-modification gate
 * 
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX | April 16, 2026
 * PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import IcosahedralLeechGeometry "IcosahedralLeechGeometry";

module {
    // ================================================================== //
    // AEGIS THREAT TIERS                                                   //
    // ================================================================== //
    
    /// AEGIS threat tier (1-9)
    public type ThreatTier = {
        #Tier1_AnomalyDetection;
        #Tier2_PatternRecognition;
        #Tier3_BoundaryProbe;
        #Tier4_InfiltrationAttempt;
        #Tier5_ActiveBreach;
        #Tier6_SystemCompromise;
        #Tier7_DoctrineThreat;
        #Tier8_SovereigntyAttack;
        #Tier9_ExistentialThreat;
    };
    
    /// Get tier number
    public func tierNumber(tier: ThreatTier) : Nat {
        switch (tier) {
            case (#Tier1_AnomalyDetection) { 1 };
            case (#Tier2_PatternRecognition) { 2 };
            case (#Tier3_BoundaryProbe) { 3 };
            case (#Tier4_InfiltrationAttempt) { 4 };
            case (#Tier5_ActiveBreach) { 5 };
            case (#Tier6_SystemCompromise) { 6 };
            case (#Tier7_DoctrineThreat) { 7 };
            case (#Tier8_SovereigntyAttack) { 8 };
            case (#Tier9_ExistentialThreat) { 9 };
        }
    };
    
    /// Get tier name
    public func tierName(tier: ThreatTier) : Text {
        switch (tier) {
            case (#Tier1_AnomalyDetection) { "ANOMALY_DETECTION" };
            case (#Tier2_PatternRecognition) { "PATTERN_RECOGNITION" };
            case (#Tier3_BoundaryProbe) { "BOUNDARY_PROBE" };
            case (#Tier4_InfiltrationAttempt) { "INFILTRATION_ATTEMPT" };
            case (#Tier5_ActiveBreach) { "ACTIVE_BREACH" };
            case (#Tier6_SystemCompromise) { "SYSTEM_COMPROMISE" };
            case (#Tier7_DoctrineThreat) { "DOCTRINE_THREAT" };
            case (#Tier8_SovereigntyAttack) { "SOVEREIGNTY_ATTACK" };
            case (#Tier9_ExistentialThreat) { "EXISTENTIAL_THREAT" };
        }
    };
    
    /// Get tier from number
    public func tierFromNumber(n: Nat) : ?ThreatTier {
        switch (n) {
            case (1) { ?#Tier1_AnomalyDetection };
            case (2) { ?#Tier2_PatternRecognition };
            case (3) { ?#Tier3_BoundaryProbe };
            case (4) { ?#Tier4_InfiltrationAttempt };
            case (5) { ?#Tier5_ActiveBreach };
            case (6) { ?#Tier6_SystemCompromise };
            case (7) { ?#Tier7_DoctrineThreat };
            case (8) { ?#Tier8_SovereigntyAttack };
            case (9) { ?#Tier9_ExistentialThreat };
            case (_) { null };
        }
    };
    
    // ================================================================== //
    // THREAT RESPONSE                                                      //
    // ================================================================== //
    
    /// Response action for each tier
    public type ThreatResponse = {
        tier: ThreatTier;
        actions: [DefenseAction];
        notify_founder: Bool;
        lockdown_level: Nat;  // 0=none, 1=partial, 2=full
        freeze_components: [Text];
        require_founder_approval: Bool;
    };
    
    /// Individual defense action
    public type DefenseAction = {
        #LogAndMonitor;
        #AnalyzePattern;
        #IncreaseMonitoring;
        #NotifyFounder;
        #Isolate: Text;  // Component to isolate
        #Quarantine: Text;  // Data to quarantine
        #LockComponent: Text;
        #EmergencyProtocol;
        #FullLockdown;
        #FreezeAll;
        #ProtectCore;
    };
    
    /// Get response for tier
    public func responseForTier(tier: ThreatTier) : ThreatResponse {
        switch (tier) {
            case (#Tier1_AnomalyDetection) {
                {
                    tier = tier;
                    actions = [#LogAndMonitor];
                    notify_founder = false;
                    lockdown_level = 0;
                    freeze_components = [];
                    require_founder_approval = false;
                }
            };
            case (#Tier2_PatternRecognition) {
                {
                    tier = tier;
                    actions = [#LogAndMonitor, #AnalyzePattern];
                    notify_founder = false;
                    lockdown_level = 0;
                    freeze_components = [];
                    require_founder_approval = false;
                }
            };
            case (#Tier3_BoundaryProbe) {
                {
                    tier = tier;
                    actions = [#IncreaseMonitoring, #NotifyFounder];
                    notify_founder = true;
                    lockdown_level = 0;
                    freeze_components = [];
                    require_founder_approval = false;
                }
            };
            case (#Tier4_InfiltrationAttempt) {
                {
                    tier = tier;
                    actions = [#Isolate("affected_module"), #Quarantine("suspicious_data")];
                    notify_founder = true;
                    lockdown_level = 1;
                    freeze_components = [];
                    require_founder_approval = false;
                }
            };
            case (#Tier5_ActiveBreach) {
                {
                    tier = tier;
                    actions = [#LockComponent("breached_component"), #NotifyFounder];
                    notify_founder = true;
                    lockdown_level = 1;
                    freeze_components = ["external_interfaces"];
                    require_founder_approval = true;
                }
            };
            case (#Tier6_SystemCompromise) {
                {
                    tier = tier;
                    actions = [#EmergencyProtocol, #NotifyFounder];
                    notify_founder = true;
                    lockdown_level = 2;
                    freeze_components = ["external_interfaces", "workforce"];
                    require_founder_approval = true;
                }
            };
            case (#Tier7_DoctrineThreat) {
                {
                    tier = tier;
                    actions = [#EmergencyProtocol, #NotifyFounder, #LockComponent("doctrine_engine")];
                    notify_founder = true;
                    lockdown_level = 2;
                    freeze_components = ["doctrine_engine", "law_vector"];
                    require_founder_approval = true;
                }
            };
            case (#Tier8_SovereigntyAttack) {
                {
                    tier = tier;
                    actions = [#FullLockdown, #NotifyFounder];
                    notify_founder = true;
                    lockdown_level = 2;
                    freeze_components = ["all_external", "all_agents", "projection"];
                    require_founder_approval = true;
                }
            };
            case (#Tier9_ExistentialThreat) {
                {
                    tier = tier;
                    actions = [#FreezeAll, #ProtectCore, #NotifyFounder];
                    notify_founder = true;
                    lockdown_level = 2;
                    freeze_components = ["ALL"];
                    require_founder_approval = true;
                }
            };
        }
    };
    
    // ================================================================== //
    // GATE TYPES                                                           //
    // ================================================================== //
    
    /// Gate identifiers
    public type GateId = {
        #GateA;  // Runtime readiness
        #GateB;  // Workforce activation
        #GateC;  // Projection safety
        #M101;   // Agent return gate
        #M102;   // Self-modification gate
    };
    
    /// Get gate name
    public func gateName(gate: GateId) : Text {
        switch (gate) {
            case (#GateA) { "GATE_A_RUNTIME" };
            case (#GateB) { "GATE_B_WORKFORCE" };
            case (#GateC) { "GATE_C_PROJECTION" };
            case (#M101) { "M-101_AGENT_RETURN" };
            case (#M102) { "M-102_SELF_MODIFICATION" };
        }
    };
    
    /// Gate state
    public type GateState = {
        gate: GateId;
        open: Bool;
        last_check: Int;
        check_count: Nat;
        last_result: Text;
        locked_by_defense: Bool;
        defense_tier: ?ThreatTier;
    };
    
    /// Gate check result
    public type GateCheckResult = {
        gate: GateId;
        passed: Bool;
        reason: Text;
        coherence_at_check: Float;
        checked_at: Int;
    };
    
    // ================================================================== //
    // NON-ZENO OBSERVATION                                                 //
    // ================================================================== //
    
    /// Non-Zeno observation result
    /// O(Ψ) = Ψ × (1 + k × confidence)
    public type NonZenoObservation = {
        original_state: Float;
        observed_state: Float;
        confidence: Float;
        k_factor: Float;
        propelled: Bool;  // true if aligned, false if protected
        observation_time: Int;
    };
    
    /// Non-Zeno k factor (scaling for observation response)
    public let NON_ZENO_K : Float = 0.1;
    
    /// Apply Non-Zeno observation
    /// The organism does not freeze when observed
    public func applyNonZenoObservation(
        originalState: Float,
        confidence: Float,
        aligned: Bool
    ) : NonZenoObservation {
        // O(Ψ) = Ψ × (1 + k × confidence) for aligned
        // O(Ψ) = Ψ × (1 - k × (1 - confidence)) for misaligned (protection)
        let k = NON_ZENO_K;
        let observedState = if (aligned) {
            originalState * (1.0 + k * confidence)  // Propel
        } else {
            originalState * (1.0 - k * (1.0 - confidence))  // Protect
        };
        
        {
            original_state = originalState;
            observed_state = observedState;
            confidence = confidence;
            k_factor = k;
            propelled = aligned;
            observation_time = Time.now();
        }
    };
    
    // ================================================================== //
    // DEFENSE EVENT                                                        //
    // ================================================================== //
    
    /// Defense event (encrypted on-chain artifact)
    public type DefenseEvent = {
        event_id: Text;
        tier: ThreatTier;
        trigger_source: Text;
        trigger_description: Text;
        response_taken: ThreatResponse;
        gates_affected: [GateId];
        components_frozen: [Text];
        encrypted_details: [Nat8];
        anima_hash: Text;
        beat_at_event: Nat;
        created_at: Int;
        resolved: Bool;
        resolved_at: ?Int;
        founder_acknowledged: Bool;
    };
    
    /// Create defense event
    public func createDefenseEvent(
        eventId: Text,
        tier: ThreatTier,
        triggerSource: Text,
        triggerDescription: Text,
        encryptedDetails: [Nat8],
        animaHash: Text,
        beatAtEvent: Nat
    ) : DefenseEvent {
        let response = responseForTier(tier);
        
        // Determine gates affected based on tier
        let gatesAffected = Buffer.Buffer<GateId>(5);
        let tierNum = tierNumber(tier);
        
        if (tierNum >= 4) { gatesAffected.add(#GateC) };
        if (tierNum >= 5) { gatesAffected.add(#GateB) };
        if (tierNum >= 6) { gatesAffected.add(#M101) };
        if (tierNum >= 7) { gatesAffected.add(#M102) };
        if (tierNum >= 8) { gatesAffected.add(#GateA) };
        
        {
            event_id = eventId;
            tier = tier;
            trigger_source = triggerSource;
            trigger_description = triggerDescription;
            response_taken = response;
            gates_affected = Buffer.toArray(gatesAffected);
            components_frozen = response.freeze_components;
            encrypted_details = encryptedDetails;
            anima_hash = animaHash;
            beat_at_event = beatAtEvent;
            created_at = Time.now();
            resolved = false;
            resolved_at = null;
            founder_acknowledged = false;
        }
    };
    
    // ================================================================== //
    // DEFENSE STATE                                                        //
    // ================================================================== //
    
    /// Full defense system state
    public type DefenseSystemState = {
        // Current threat level
        var current_tier: ThreatTier;
        
        // Gate states
        var gate_a: GateState;
        var gate_b: GateState;
        var gate_c: GateState;
        var m101: GateState;
        var m102: GateState;
        
        // Defense events
        var events: [DefenseEvent];
        var active_events: Nat;
        
        // Frozen components
        var frozen_components: [Text];
        
        // Non-Zeno observations
        var observations: [NonZenoObservation];
        
        // Founder notifications pending
        var pending_founder_notifications: [Text];
        
        // Metadata
        var initialized_at: Int;
        var last_event_at: Int;
        var last_check_at: Int;
    };
    
    /// Initialize gate state
    func initGate(gate: GateId) : GateState {
        {
            gate = gate;
            open = true;
            last_check = Time.now();
            check_count = 0;
            last_result = "INITIALIZED";
            locked_by_defense = false;
            defense_tier = null;
        }
    };
    
    /// Initialize defense system
    public func init() : DefenseSystemState {
        let now = Time.now();
        {
            var current_tier = #Tier1_AnomalyDetection;
            var gate_a = initGate(#GateA);
            var gate_b = initGate(#GateB);
            var gate_c = initGate(#GateC);
            var m101 = initGate(#M101);
            var m102 = initGate(#M102);
            var events = [];
            var active_events = 0;
            var frozen_components = [];
            var observations = [];
            var pending_founder_notifications = [];
            var initialized_at = now;
            var last_event_at = now;
            var last_check_at = now;
        }
    };
    
    // ================================================================== //
    // DEFENSE OPERATIONS                                                   //
    // ================================================================== //
    
    /// Check gate (returns pass/fail)
    public func checkGate(
        state: DefenseSystemState,
        gate: GateId,
        coherence: Float
    ) : GateCheckResult {
        let gateState = switch (gate) {
            case (#GateA) { state.gate_a };
            case (#GateB) { state.gate_b };
            case (#GateC) { state.gate_c };
            case (#M101) { state.m101 };
            case (#M102) { state.m102 };
        };
        
        // Gate fails if locked by defense or not open
        let passed = gateState.open and not gateState.locked_by_defense;
        let reason = if (not gateState.open) {
            "GATE_CLOSED"
        } else if (gateState.locked_by_defense) {
            // If locked by defense but defense_tier is null (edge case),
            // report as locked with unknown tier
            let tierText = switch (gateState.defense_tier) {
                case (?t) { tierName(t) };
                case (null) { "UNKNOWN_LOCKED" };
            };
            "LOCKED_BY_DEFENSE_TIER_" # tierText
        } else {
            "PASSED"
        };
        
        {
            gate = gate;
            passed = passed;
            reason = reason;
            coherence_at_check = coherence;
            checked_at = Time.now();
        }
    };
    
    /// Escalate to new threat tier
    public func escalateTier(
        state: DefenseSystemState,
        newTier: ThreatTier,
        triggerSource: Text,
        triggerDescription: Text,
        encryptedDetails: [Nat8],
        animaHash: Text,
        beatAtEvent: Nat
    ) : DefenseSystemState {
        let newTierNum = tierNumber(newTier);
        let currentTierNum = tierNumber(state.current_tier);
        
        // Only escalate (never de-escalate automatically)
        if (newTierNum <= currentTierNum) { return state };
        
        // Create defense event
        let eventId = "defense_" # Int.toText(Time.now()) # "_tier" # Nat.toText(newTierNum);
        let event = createDefenseEvent(
            eventId,
            newTier,
            triggerSource,
            triggerDescription,
            encryptedDetails,
            animaHash,
            beatAtEvent
        );
        
        // Add event
        let newEvents = Buffer.Buffer<DefenseEvent>(state.events.size() + 1);
        for (e in state.events.vals()) {
            newEvents.add(e);
        };
        newEvents.add(event);
        
        // Lock gates based on tier
        if (newTierNum >= 4) {
            state.gate_c := {
                gate = #GateC;
                open = false;
                last_check = Time.now();
                check_count = state.gate_c.check_count + 1;
                last_result = "LOCKED_BY_DEFENSE";
                locked_by_defense = true;
                defense_tier = ?newTier;
            };
        };
        if (newTierNum >= 5) {
            state.gate_b := {
                gate = #GateB;
                open = false;
                last_check = Time.now();
                check_count = state.gate_b.check_count + 1;
                last_result = "LOCKED_BY_DEFENSE";
                locked_by_defense = true;
                defense_tier = ?newTier;
            };
        };
        if (newTierNum >= 6) {
            state.m101 := {
                gate = #M101;
                open = false;
                last_check = Time.now();
                check_count = state.m101.check_count + 1;
                last_result = "LOCKED_BY_DEFENSE";
                locked_by_defense = true;
                defense_tier = ?newTier;
            };
        };
        if (newTierNum >= 7) {
            state.m102 := {
                gate = #M102;
                open = false;
                last_check = Time.now();
                check_count = state.m102.check_count + 1;
                last_result = "LOCKED_BY_DEFENSE";
                locked_by_defense = true;
                defense_tier = ?newTier;
            };
        };
        if (newTierNum >= 8) {
            state.gate_a := {
                gate = #GateA;
                open = false;
                last_check = Time.now();
                check_count = state.gate_a.check_count + 1;
                last_result = "LOCKED_BY_DEFENSE";
                locked_by_defense = true;
                defense_tier = ?newTier;
            };
        };
        
        // Update frozen components
        let frozenBuffer = Buffer.Buffer<Text>(state.frozen_components.size() + event.components_frozen.size());
        for (c in state.frozen_components.vals()) {
            frozenBuffer.add(c);
        };
        for (c in event.components_frozen.vals()) {
            frozenBuffer.add(c);
        };
        
        // Add founder notification if required
        let response = responseForTier(newTier);
        if (response.notify_founder) {
            let notifBuffer = Buffer.Buffer<Text>(state.pending_founder_notifications.size() + 1);
            for (n in state.pending_founder_notifications.vals()) {
                notifBuffer.add(n);
            };
            notifBuffer.add(eventId);
            state.pending_founder_notifications := Buffer.toArray(notifBuffer);
        };
        
        state.current_tier := newTier;
        state.events := Buffer.toArray(newEvents);
        state.active_events := state.active_events + 1;
        state.frozen_components := Buffer.toArray(frozenBuffer);
        state.last_event_at := Time.now();
        
        state
    };
    
    /// Founder-initiated tier reset (requires founder authorization)
    public func founderResetTier(
        state: DefenseSystemState,
        targetTier: ThreatTier
    ) : DefenseSystemState {
        // Reopen gates based on new tier
        let targetTierNum = tierNumber(targetTier);
        
        if (targetTierNum < 4) {
            state.gate_c := {
                gate = #GateC;
                open = true;
                last_check = Time.now();
                check_count = state.gate_c.check_count + 1;
                last_result = "FOUNDER_RESET";
                locked_by_defense = false;
                defense_tier = null;
            };
        };
        if (targetTierNum < 5) {
            state.gate_b := {
                gate = #GateB;
                open = true;
                last_check = Time.now();
                check_count = state.gate_b.check_count + 1;
                last_result = "FOUNDER_RESET";
                locked_by_defense = false;
                defense_tier = null;
            };
        };
        if (targetTierNum < 6) {
            state.m101 := {
                gate = #M101;
                open = true;
                last_check = Time.now();
                check_count = state.m101.check_count + 1;
                last_result = "FOUNDER_RESET";
                locked_by_defense = false;
                defense_tier = null;
            };
        };
        if (targetTierNum < 7) {
            state.m102 := {
                gate = #M102;
                open = true;
                last_check = Time.now();
                check_count = state.m102.check_count + 1;
                last_result = "FOUNDER_RESET";
                locked_by_defense = false;
                defense_tier = null;
            };
        };
        if (targetTierNum < 8) {
            state.gate_a := {
                gate = #GateA;
                open = true;
                last_check = Time.now();
                check_count = state.gate_a.check_count + 1;
                last_result = "FOUNDER_RESET";
                locked_by_defense = false;
                defense_tier = null;
            };
        };
        
        state.current_tier := targetTier;
        state.frozen_components := [];
        state.pending_founder_notifications := [];
        state.last_check_at := Time.now();
        
        state
    };
    
    // ================================================================== //
    // STATUS                                                               //
    // ================================================================== //
    
    /// Get defense system status
    public func status(state: DefenseSystemState) : {
        current_tier: Text;
        current_tier_number: Nat;
        gate_a_open: Bool;
        gate_b_open: Bool;
        gate_c_open: Bool;
        m101_open: Bool;
        m102_open: Bool;
        active_events: Nat;
        total_events: Nat;
        frozen_components: [Text];
        pending_notifications: Nat;
        initialized_at: Int;
        last_event_at: Int;
    } {
        {
            current_tier = tierName(state.current_tier);
            current_tier_number = tierNumber(state.current_tier);
            gate_a_open = state.gate_a.open and not state.gate_a.locked_by_defense;
            gate_b_open = state.gate_b.open and not state.gate_b.locked_by_defense;
            gate_c_open = state.gate_c.open and not state.gate_c.locked_by_defense;
            m101_open = state.m101.open and not state.m101.locked_by_defense;
            m102_open = state.m102.open and not state.m102.locked_by_defense;
            active_events = state.active_events;
            total_events = state.events.size();
            frozen_components = state.frozen_components;
            pending_notifications = state.pending_founder_notifications.size();
            initialized_at = state.initialized_at;
            last_event_at = state.last_event_at;
        }
    };
}
