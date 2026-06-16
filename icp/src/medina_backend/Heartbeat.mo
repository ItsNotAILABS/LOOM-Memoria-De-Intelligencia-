/**
 * MEDINA Heartbeat Module — Beat-driven orchestrator rhythm.
 * 
 * The heartbeat is the fundamental timing mechanism of MEDINA:
 * - Every operation synchronizes to beats
 * - Cadence classes define execution frequency
 * - Instruction budget enforces resource limits per beat
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import Time "mo:base/Time";

import Types "Types";
import Utils "Utils";

module {
    public type CadenceClass = Types.CadenceClass;
    public type BeatEvent = Types.BeatEvent;
    public type BeatMetrics = Types.BeatMetrics;
    
    /// Heartbeat state
    public type HeartbeatState = {
        var beat: Nat;
        var started_at: Int;
        var last_tick: Int;
        var events: [BeatEvent];
        var metrics: [BeatMetrics];
        var paused: Bool;
        var beat_budget: Nat;
        var idCounter: Nat;
    };
    
    /// Default budget per beat
    public let DEFAULT_BEAT_BUDGET : Nat = 10000;
    
    /// Initialize a new Heartbeat
    public func init() : HeartbeatState {
        {
            var beat = 0;
            var started_at = Time.now();
            var last_tick = 0;
            var events = [];
            var metrics = [];
            var paused = false;
            var beat_budget = DEFAULT_BEAT_BUDGET;
            var idCounter = 0;
        }
    };
    
    /// Get current beat number
    public func currentBeat(state: HeartbeatState) : Nat {
        state.beat
    };
    
    /// Check if heartbeat is paused
    public func isPaused(state: HeartbeatState) : Bool {
        state.paused
    };
    
    /// Execute one heartbeat cycle
    public func tick(state: HeartbeatState) : BeatMetrics {
        if (state.paused) {
            return {
                beat = state.beat;
                start_time = Time.now();
                end_time = Time.now();
                tasks_executed = 0;
                tasks_skipped = 0;
                events_emitted = 0;
                budget_exceeded = false;
            };
        };
        
        let startTime = Time.now();
        state.idCounter += 1;
        
        // Pre-beat event
        let preEvent : BeatEvent = {
            event_id = Utils.generateId("evt", state.idCounter);
            beat = state.beat;
            timestamp = startTime;
            phase = "pre_beat";
            payload = "{}";
        };
        
        state.idCounter += 1;
        
        // Post-beat event
        let endTime = Time.now();
        let postEvent : BeatEvent = {
            event_id = Utils.generateId("evt", state.idCounter);
            beat = state.beat;
            timestamp = endTime;
            phase = "post_beat";
            payload = "{\"tasks_executed\": 0}";
        };
        
        // Add events
        let eventBuffer = Buffer.fromArray<BeatEvent>(state.events);
        eventBuffer.add(preEvent);
        eventBuffer.add(postEvent);
        state.events := Buffer.toArray(eventBuffer);
        
        let metrics : BeatMetrics = {
            beat = state.beat;
            start_time = startTime;
            end_time = endTime;
            tasks_executed = 0;  // Tasks are executed by the platform
            tasks_skipped = 0;
            events_emitted = 2;
            budget_exceeded = false;
        };
        
        // Add metrics
        let metricsBuffer = Buffer.fromArray<BeatMetrics>(state.metrics);
        metricsBuffer.add(metrics);
        state.metrics := Buffer.toArray(metricsBuffer);
        
        // Advance beat
        state.last_tick := endTime;
        state.beat += 1;
        
        metrics
    };
    
    /// Execute N heartbeat cycles
    public func tickN(state: HeartbeatState, n: Nat) : [BeatMetrics] {
        let results = Buffer.Buffer<BeatMetrics>(n);
        for (_ in Iter.range(0, n - 1)) {
            results.add(tick(state));
        };
        Buffer.toArray(results)
    };
    
    /// Pause heartbeat execution
    public func pause(state: HeartbeatState) {
        state.paused := true;
    };
    
    /// Resume heartbeat execution
    public func resume(state: HeartbeatState) {
        state.paused := false;
    };
    
    /// Reset heartbeat to initial state
    public func reset(state: HeartbeatState) {
        state.beat := 0;
        state.started_at := Time.now();
        state.last_tick := 0;
        state.events := [];
        state.metrics := [];
    };
    
    /// Get events in a beat range
    public func getEvents(state: HeartbeatState, fromBeat: Nat, toBeat: Nat) : [BeatEvent] {
        let results = Buffer.Buffer<BeatEvent>(16);
        for (event in state.events.vals()) {
            if (event.beat >= fromBeat and event.beat <= toBeat) {
                results.add(event);
            };
        };
        Buffer.toArray(results)
    };
    
    /// Get recent metrics
    public func getMetrics(state: HeartbeatState, lastN: Nat) : [BeatMetrics] {
        let len = state.metrics.size();
        if (len <= lastN) {
            return state.metrics;
        };
        
        let start = len - lastN;
        let results = Buffer.Buffer<BeatMetrics>(lastN);
        for (i in Iter.range(start, len - 1)) {
            results.add(state.metrics[i]);
        };
        Buffer.toArray(results)
    };
    
    /// Get heartbeat status
    public func status(state: HeartbeatState) : {
        current_beat: Nat;
        paused: Bool;
        started_at: Int;
        last_tick: Int;
        event_log_size: Nat;
        beat_budget: Nat;
    } {
        {
            current_beat = state.beat;
            paused = state.paused;
            started_at = state.started_at;
            last_tick = state.last_tick;
            event_log_size = state.events.size();
            beat_budget = state.beat_budget;
        }
    };
}
