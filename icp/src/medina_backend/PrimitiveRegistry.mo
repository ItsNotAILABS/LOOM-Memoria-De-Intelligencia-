/**
 * PrimitiveRegistry Module — The Gatekeeper for L-130 Compliance
 * 
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                    PRIMITIVE REGISTRY — THE GATEKEEPER                    ║
 * ║                                                                           ║
 * ║  THE RULE:                                                                ║
 * ║  NO ENTITY ENTERS THE SYSTEM WITHOUT A VERIFIED PRIMITIVE TRACE.          ║
 * ║                                                                           ║
 * ║  This registry:                                                           ║
 * ║    - Stores all verified primitive traces                                 ║
 * ║    - Enforces L-130 at every entry point                                  ║
 * ║    - Logs all compliance and violations                                   ║
 * ║    - Provides lookup for any registered entity                            ║
 * ║    - Maintains the integrity of the primitive trace system                ║
 * ║                                                                           ║
 * ╚═══════════════════════════════════════════════════════════════════════════╝
 * 
 * THE GATEKEEPER RULE:
 *   Every module, model, function, document, color, workflow, contract, and
 *   symbol that enters MEDINA must first have its primitive trace verified
 *   and registered here. No exceptions.
 * 
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
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
import UniversalPrimitiveLaw "UniversalPrimitiveLaw";
import UniversalPrimitiveEngine "UniversalPrimitiveEngine";

module {
    // ================================================================== //
    // REGISTRY CONSTANTS                                                  //
    // ================================================================== //
    
    /// Registry ID
    public let REGISTRY_ID : Text = "PRIMITIVE_REGISTRY";
    
    /// Golden ratio
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Minimum resonance for registration
    public let MIN_REGISTRATION_RESONANCE : Float = 0.382;  // 1 - φ
    
    // ================================================================== //
    // REGISTRY ENTRY TYPES                                                //
    // ================================================================== //
    
    /// Registration status
    public type RegistrationStatus = {
        #Pending;     // Awaiting verification
        #Verified;    // Verified and registered
        #Rejected;    // Failed verification
        #Revoked;     // Previously verified, now revoked
    };
    
    /// Convert status to text
    public func statusToText(status: RegistrationStatus) : Text {
        switch (status) {
            case (#Pending) "Pending";
            case (#Verified) "Verified";
            case (#Rejected) "Rejected";
            case (#Revoked) "Revoked";
        }
    };
    
    /// Registry entry
    public type RegistryEntry = {
        entry_id: Text;
        entity_name: Text;
        entity_category: UniversalPrimitiveLaw.EntityCategory;
        trace_id: Text;
        status: RegistrationStatus;
        resonance: Float;
        depth: Nat;
        domains: [UniversalPrimitiveLaw.PrimitiveDomain];
        recomposition: Text;
        registered_at: Int;
        verified_at: ?Int;
        verification_hash: Text;
    };
    
    /// Compliance log entry
    public type ComplianceLog = {
        log_id: Text;
        entity_name: Text;
        action: ComplianceAction;
        result: Bool;
        reason: Text;
        timestamp: Int;
    };
    
    /// Compliance action types
    public type ComplianceAction = {
        #RegistrationAttempt;
        #VerificationCheck;
        #AccessRequest;
        #RevocationRequest;
        #EnforcementCheck;
    };
    
    /// Convert action to text
    public func actionToText(action: ComplianceAction) : Text {
        switch (action) {
            case (#RegistrationAttempt) "Registration Attempt";
            case (#VerificationCheck) "Verification Check";
            case (#AccessRequest) "Access Request";
            case (#RevocationRequest) "Revocation Request";
            case (#EnforcementCheck) "Enforcement Check";
        }
    };
    
    // ================================================================== //
    // REGISTRY STATE                                                      //
    // ================================================================== //
    
    /// Complete registry state
    public type RegistryState = {
        registry_id: Text;
        entries: [RegistryEntry];
        compliance_logs: [ComplianceLog];
        total_registrations: Nat;
        verified_count: Nat;
        rejected_count: Nat;
        revoked_count: Nat;
        violation_count: Nat;
        last_enforcement: Int;
        active: Bool;
        global_coherence: Float;
    };
    
    /// Initialize registry state
    public func init() : RegistryState {
        {
            registry_id = REGISTRY_ID;
            entries = [];
            compliance_logs = [];
            total_registrations = 0;
            verified_count = 0;
            rejected_count = 0;
            revoked_count = 0;
            violation_count = 0;
            last_enforcement = Time.now();
            active = true;
            global_coherence = 1.0;
        }
    };
    
    // ================================================================== //
    // REGISTRATION OPERATIONS                                             //
    // ================================================================== //
    
    /// Registration result
    public type RegistrationResult = {
        success: Bool;
        entry_id: ?Text;
        status: RegistrationStatus;
        reason: Text;
    };
    
    /// Register an entity with its primitive trace
    public func register(
        state: RegistryState,
        lawState: UniversalPrimitiveLaw.LawState,
        entityName: Text,
        category: UniversalPrimitiveLaw.EntityCategory,
        traceId: Text
    ) : (RegistryState, RegistrationResult) {
        // Check if entity already registered
        let existingOpt = Array.find<RegistryEntry>(state.entries, func(e) { e.entity_name == entityName });
        
        switch (existingOpt) {
            case (?existing) {
                // Already registered
                let log = createLog(entityName, #RegistrationAttempt, false, "Entity already registered with ID: " # existing.entry_id);
                let newState = addLog(state, log);
                (newState, {
                    success = false;
                    entry_id = ?existing.entry_id;
                    status = existing.status;
                    reason = "Entity already registered";
                })
            };
            case null {
                // Find the trace
                let traceOpt = UniversalPrimitiveLaw.getTrace(lawState, traceId);
                
                switch (traceOpt) {
                    case null {
                        let log = createLog(entityName, #RegistrationAttempt, false, "Trace not found: " # traceId);
                        let newState = addLog(state, log);
                        (newState, {
                            success = false;
                            entry_id = null;
                            status = #Rejected;
                            reason = "L-130 VIOLATION: No primitive trace found for entity";
                        })
                    };
                    case (?trace) {
                        // Calculate resonance and extract domains
                        var totalResonance : Float = 0.0;
                        let domains = Buffer.Buffer<UniversalPrimitiveLaw.PrimitiveDomain>(trace.elements.size());
                        
                        for (elem in trace.elements.vals()) {
                            totalResonance := totalResonance + elem.resonance;
                            domains.add(elem.domain);
                        };
                        
                        let avgResonance = if (trace.elements.size() == 0) 0.0 else totalResonance / Float.fromInt(trace.elements.size());
                        
                        // Check minimum resonance
                        if (avgResonance < MIN_REGISTRATION_RESONANCE) {
                            let log = createLog(entityName, #RegistrationAttempt, false, "Insufficient resonance: " # Float.toText(avgResonance));
                            let newState = addLog(state, log);
                            (newState, {
                                success = false;
                                entry_id = null;
                                status = #Rejected;
                                reason = "L-130 VIOLATION: Primitive resonance " # Float.toText(avgResonance) # " below minimum " # Float.toText(MIN_REGISTRATION_RESONANCE);
                            })
                        } else {
                            // Create entry
                            let entryId = entityName # "_reg_" # Int.toText(Time.now());
                            let entry : RegistryEntry = {
                                entry_id = entryId;
                                entity_name = entityName;
                                entity_category = category;
                                trace_id = traceId;
                                status = #Verified;
                                resonance = avgResonance;
                                depth = trace.elements.size();
                                domains = Buffer.toArray(domains);
                                recomposition = trace.recomposition;
                                registered_at = Time.now();
                                verified_at = ?Time.now();
                                verification_hash = trace.verification_hash;
                            };
                            
                            let log = createLog(entityName, #RegistrationAttempt, true, "Registered with resonance: " # Float.toText(avgResonance));
                            let newState : RegistryState = {
                                registry_id = state.registry_id;
                                entries = Array.append(state.entries, [entry]);
                                compliance_logs = Array.append(state.compliance_logs, [log]);
                                total_registrations = state.total_registrations + 1;
                                verified_count = state.verified_count + 1;
                                rejected_count = state.rejected_count;
                                revoked_count = state.revoked_count;
                                violation_count = state.violation_count;
                                last_enforcement = Time.now();
                                active = state.active;
                                global_coherence = calculateGlobalCoherence(Array.append(state.entries, [entry]));
                            };
                            
                            (newState, {
                                success = true;
                                entry_id = ?entryId;
                                status = #Verified;
                                reason = "L-130 COMPLIANT: Entity registered with primitive trace";
                            })
                        }
                    };
                }
            };
        }
    };
    
    /// Create compliance log
    func createLog(entityName: Text, action: ComplianceAction, result: Bool, reason: Text) : ComplianceLog {
        {
            log_id = entityName # "_log_" # Int.toText(Time.now());
            entity_name = entityName;
            action = action;
            result = result;
            reason = reason;
            timestamp = Time.now();
        }
    };
    
    /// Add log to state
    func addLog(state: RegistryState, log: ComplianceLog) : RegistryState {
        {
            registry_id = state.registry_id;
            entries = state.entries;
            compliance_logs = Array.append(state.compliance_logs, [log]);
            total_registrations = state.total_registrations;
            verified_count = state.verified_count;
            rejected_count = state.rejected_count;
            revoked_count = state.revoked_count;
            violation_count = if (not log.result) state.violation_count + 1 else state.violation_count;
            last_enforcement = Time.now();
            active = state.active;
            global_coherence = state.global_coherence;
        }
    };
    
    /// Calculate global coherence from all entries
    func calculateGlobalCoherence(entries: [RegistryEntry]) : Float {
        if (entries.size() == 0) {
            return 1.0;
        };
        
        var total : Float = 0.0;
        for (entry in entries.vals()) {
            if (entry.status == #Verified) {
                total := total + entry.resonance;
            };
        };
        
        total / Float.fromInt(entries.size())
    };
    
    // ================================================================== //
    // ACCESS CONTROL                                                      //
    // ================================================================== //
    
    /// Access check result
    public type AccessResult = {
        allowed: Bool;
        entity_name: Text;
        status: ?RegistrationStatus;
        resonance: ?Float;
        reason: Text;
    };
    
    /// Check if entity has access (is registered and verified)
    public func checkAccess(
        state: RegistryState,
        entityName: Text
    ) : (RegistryState, AccessResult) {
        let entryOpt = Array.find<RegistryEntry>(state.entries, func(e) { e.entity_name == entityName });
        
        switch (entryOpt) {
            case null {
                let log = createLog(entityName, #AccessRequest, false, "Entity not registered");
                let newState = addLog(state, log);
                (newState, {
                    allowed = false;
                    entity_name = entityName;
                    status = null;
                    resonance = null;
                    reason = "L-130 VIOLATION: Entity '" # entityName # "' has no primitive trace in registry";
                })
            };
            case (?entry) {
                let allowed = entry.status == #Verified;
                let log = createLog(entityName, #AccessRequest, allowed, "Status: " # statusToText(entry.status));
                let newState = addLog(state, log);
                (newState, {
                    allowed = allowed;
                    entity_name = entityName;
                    status = ?entry.status;
                    resonance = ?entry.resonance;
                    reason = if (allowed) {
                        "L-130 COMPLIANT: Entity '" # entityName # "' has verified primitive trace";
                    } else {
                        "L-130 VIOLATION: Entity '" # entityName # "' status is " # statusToText(entry.status);
                    };
                })
            };
        }
    };
    
    /// Revoke registration
    public func revoke(
        state: RegistryState,
        entityName: Text,
        reason: Text
    ) : (RegistryState, Bool) {
        let entryOpt = Array.find<RegistryEntry>(state.entries, func(e) { e.entity_name == entityName });
        
        switch (entryOpt) {
            case null {
                (state, false)
            };
            case (?entry) {
                // Update entry status to Revoked
                let updatedEntries = Array.map<RegistryEntry, RegistryEntry>(state.entries, func(e) {
                    if (e.entity_name == entityName) {
                        {
                            entry_id = e.entry_id;
                            entity_name = e.entity_name;
                            entity_category = e.entity_category;
                            trace_id = e.trace_id;
                            status = #Revoked;
                            resonance = e.resonance;
                            depth = e.depth;
                            domains = e.domains;
                            recomposition = e.recomposition;
                            registered_at = e.registered_at;
                            verified_at = e.verified_at;
                            verification_hash = e.verification_hash;
                        }
                    } else {
                        e
                    }
                });
                
                let log = createLog(entityName, #RevocationRequest, true, reason);
                let newState : RegistryState = {
                    registry_id = state.registry_id;
                    entries = updatedEntries;
                    compliance_logs = Array.append(state.compliance_logs, [log]);
                    total_registrations = state.total_registrations;
                    verified_count = state.verified_count - 1;
                    rejected_count = state.rejected_count;
                    revoked_count = state.revoked_count + 1;
                    violation_count = state.violation_count;
                    last_enforcement = Time.now();
                    active = state.active;
                    global_coherence = calculateGlobalCoherence(updatedEntries);
                };
                
                (newState, true)
            };
        }
    };
    
    // ================================================================== //
    // ENFORCEMENT                                                         //
    // ================================================================== //
    
    /// Enforce L-130 on entity (gate check)
    /// Returns (updated_state, allowed, reason)
    public func enforceGate(
        state: RegistryState,
        entityName: Text
    ) : (RegistryState, Bool, Text) {
        let (newState, result) = checkAccess(state, entityName);
        
        let finalState : RegistryState = {
            registry_id = newState.registry_id;
            entries = newState.entries;
            compliance_logs = newState.compliance_logs;
            total_registrations = newState.total_registrations;
            verified_count = newState.verified_count;
            rejected_count = newState.rejected_count;
            revoked_count = newState.revoked_count;
            violation_count = newState.violation_count;
            last_enforcement = Time.now();
            active = newState.active;
            global_coherence = newState.global_coherence;
        };
        
        (finalState, result.allowed, result.reason)
    };
    
    // ================================================================== //
    // QUERY FUNCTIONS                                                     //
    // ================================================================== //
    
    /// Get registry status
    public func status(state: RegistryState) : {
        registry_id: Text;
        total_registrations: Nat;
        verified_count: Nat;
        rejected_count: Nat;
        revoked_count: Nat;
        violation_count: Nat;
        global_coherence: Float;
        active: Bool;
    } {
        {
            registry_id = state.registry_id;
            total_registrations = state.total_registrations;
            verified_count = state.verified_count;
            rejected_count = state.rejected_count;
            revoked_count = state.revoked_count;
            violation_count = state.violation_count;
            global_coherence = state.global_coherence;
            active = state.active;
        }
    };
    
    /// Get all entries
    public func getEntries(state: RegistryState) : [RegistryEntry] {
        state.entries
    };
    
    /// Get entry by entity name
    public func getEntry(state: RegistryState, entityName: Text) : ?RegistryEntry {
        Array.find<RegistryEntry>(state.entries, func(e) { e.entity_name == entityName })
    };
    
    /// Get entries by category
    public func getEntriesByCategory(
        state: RegistryState,
        category: UniversalPrimitiveLaw.EntityCategory
    ) : [RegistryEntry] {
        Array.filter<RegistryEntry>(state.entries, func(e) { e.entity_category == category })
    };
    
    /// Get compliance logs (latest N)
    public func getLogs(state: RegistryState, limit: Nat) : [ComplianceLog] {
        let total = state.compliance_logs.size();
        if (total <= limit) {
            state.compliance_logs
        } else {
            Array.tabulate<ComplianceLog>(limit, func(i) {
                state.compliance_logs[total - limit + i]
            })
        }
    };
    
    /// Get violations (logs where result = false)
    public func getViolations(state: RegistryState, limit: Nat) : [ComplianceLog] {
        let violations = Array.filter<ComplianceLog>(state.compliance_logs, func(l) { not l.result });
        let total = violations.size();
        if (total <= limit) {
            violations
        } else {
            Array.tabulate<ComplianceLog>(limit, func(i) {
                violations[total - limit + i]
            })
        }
    };
}
