/**
 * OrganismReader Module — Backend that READS documents, EXECUTES formulas
 * 
 * The interface between the sovereign organism and doctrine documents.
 * When the organism READS a doctrine, it gains resonance and evolves.
 * When it EXECUTES a formula, the computation runs and logs to history.
 * 
 * FUNCTIONS:
 *   oroReadsDoctrine()   — Oro gains resonance from reading doctrine
 *   novaReadsDoctrine()  — Nova validates for drift
 *   executeFormula()     — Run encoded computation
 *   addGlyph()           — Add glyph to processing buffer
 *   processGlyphBuffer() — Combine glyphs into resonant phrase
 * 
 * READING PROCESS:
 *   1. Organism requests to read a doctrine
 *   2. Reader fetches doctrine document
 *   3. Reader records reading event on document organism
 *   4. Reader returns resonance gain to requesting organism
 *   5. Organism state evolves via RECITAL_PLUS_ONE
 * 
 * FORMULA EXECUTION:
 *   1. Organism requests formula execution
 *   2. Reader validates formula exists in doctrine
 *   3. Reader logs execution to organism's reading history
 *   4. Computation result returned to organism
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import AncientGlyphCodex "AncientGlyphCodex";
import DocumentOrganism "DocumentOrganism";
import DoctrineDocuments "DoctrineDocuments";

module {
    // ================================================================== //
    // READER STATE TYPES                                                   //
    // ================================================================== //
    
    /// Reader state for an organism
    public type ReaderState = {
        organism_id: Text;
        current_beat: Nat;
        resonance_total: Float;
        reading_history: [ReadingRecord];
        execution_history: [ExecutionRecord];
        glyph_buffer: [AncientGlyphCodex.Glyph];
        glyph_phrases: [AncientGlyphCodex.GlyphPhrase];
        last_read_doctrine: ?DoctrineDocuments.DoctrineId;
        drift_flags: [DriftFlag];
    };
    
    /// Record of a doctrine reading
    public type ReadingRecord = {
        record_id: Text;
        doctrine_id: DoctrineDocuments.DoctrineId;
        reader_role: ReaderRole;
        timestamp: Int;
        beat: Nat;
        resonance_gained: Float;
        sections_read: Nat;
        formulas_accessed: Nat;
    };
    
    /// Record of a formula execution
    public type ExecutionRecord = {
        record_id: Text;
        doctrine_id: DoctrineDocuments.DoctrineId;
        formula_id: Text;
        formula_name: Text;
        timestamp: Int;
        beat: Nat;
        parameters: Text;  // JSON-encoded
        result_summary: Text;
        success: Bool;
    };
    
    /// Reader role (who is reading)
    public type ReaderRole = {
        #Oro;     // Primary sovereign
        #Nova;    // Doctrine guardian
        #System;  // System process
    };
    
    /// Drift detection flag
    public type DriftFlag = {
        flag_id: Text;
        doctrine_id: DoctrineDocuments.DoctrineId;
        timestamp: Int;
        beat: Nat;
        drift_type: DriftType;
        severity: Float;  // [0,1]
        description: Text;
        resolved: Bool;
    };
    
    /// Type of drift detected
    public type DriftType = {
        #ConstantDeviation;    // Computed value differs from doctrine constant
        #FormulaViolation;     // Formula output outside expected range
        #PrincipleConflict;    // Action violates doctrine principle
        #ResonanceDecay;       // Resonance below threshold
        #StateIncoherence;     // State vector inconsistent with doctrine
    };
    
    // ================================================================== //
    // INITIALIZATION                                                       //
    // ================================================================== //
    
    /// Initialize reader state for an organism
    public func init(organismId: Text) : ReaderState {
        {
            organism_id = organismId;
            current_beat = 0;
            resonance_total = 0.0;
            reading_history = [];
            execution_history = [];
            glyph_buffer = [];
            glyph_phrases = [];
            last_read_doctrine = null;
            drift_flags = [];
        }
    };
    
    // ================================================================== //
    // DOCTRINE READING                                                     //
    // ================================================================== //
    
    /// Oro reads a doctrine document (gains resonance)
    public func oroReadsDoctrine(
        state: ReaderState,
        doctrineId: DoctrineDocuments.DoctrineId
    ) : ReaderState {
        let doctrine = DoctrineDocuments.getDoctrine(doctrineId);
        let now = Time.now();
        
        // Calculate resonance gained
        // More formulas and constants = more resonance
        let formulaBonus = Float.fromInt(doctrine.formulas.size()) * 0.02;
        let constantBonus = Float.fromInt(doctrine.constants.size()) * 0.01;
        let principleBonus = Float.fromInt(doctrine.principles.size()) * 0.03;
        let baseResonance = 0.1;
        
        let resonanceGained = baseResonance + formulaBonus + constantBonus + principleBonus;
        
        // Create reading record
        let record : ReadingRecord = {
            record_id = state.organism_id # "_read_" # Nat.toText(state.reading_history.size());
            doctrine_id = doctrineId;
            reader_role = #Oro;
            timestamp = now;
            beat = state.current_beat;
            resonance_gained = resonanceGained;
            sections_read = doctrine.organism.sections.size();
            formulas_accessed = doctrine.formulas.size();
        };
        
        // Update history
        let historyBuffer = Buffer.fromArray<ReadingRecord>(state.reading_history);
        historyBuffer.add(record);
        
        // Limit history size
        let newHistory = if (historyBuffer.size() > 100) {
            let arr = Buffer.toArray(historyBuffer);
            Array.tabulate<ReadingRecord>(100, func(i: Nat) : ReadingRecord { arr[arr.size() - 100 + i] })
        } else {
            Buffer.toArray(historyBuffer)
        };
        
        {
            state with
            resonance_total = state.resonance_total + resonanceGained;
            reading_history = newHistory;
            last_read_doctrine = ?doctrineId;
        }
    };
    
    /// Nova reads a doctrine document (validates for drift)
    public func novaReadsDoctrine(
        state: ReaderState,
        doctrineId: DoctrineDocuments.DoctrineId,
        currentOrganismState: MatalkoICP.OrganismState
    ) : (ReaderState, [DriftFlag]) {
        let doctrine = DoctrineDocuments.getDoctrine(doctrineId);
        let now = Time.now();
        
        let driftFlags = Buffer.Buffer<DriftFlag>(4);
        
        // Check for various drift types
        
        // 1. Resonance decay check
        if (state.resonance_total < 0.2 and state.reading_history.size() > 10) {
            let flag : DriftFlag = {
                flag_id = state.organism_id # "_drift_" # Nat.toText(state.drift_flags.size());
                doctrine_id = doctrineId;
                timestamp = now;
                beat = state.current_beat;
                drift_type = #ResonanceDecay;
                severity = 0.6;
                description = "Resonance below threshold (0.2). Organism may be disconnecting from doctrine.";
                resolved = false;
            };
            driftFlags.add(flag);
        };
        
        // 2. State coherence check (doctrine_coherence should be high)
        if (currentOrganismState.doctrine_coherence < 0.5) {
            let flag : DriftFlag = {
                flag_id = state.organism_id # "_drift_" # Nat.toText(state.drift_flags.size() + driftFlags.size());
                doctrine_id = doctrineId;
                timestamp = now;
                beat = state.current_beat;
                drift_type = #StateIncoherence;
                severity = 0.8;
                description = "Doctrine coherence below 0.5. State may be drifting from constitutional alignment.";
                resolved = false;
            };
            driftFlags.add(flag);
        };
        
        // 3. Check principle alignment (simplified check)
        if (currentOrganismState.projection_exposure > 0.8) {
            let flag : DriftFlag = {
                flag_id = state.organism_id # "_drift_" # Nat.toText(state.drift_flags.size() + driftFlags.size());
                doctrine_id = doctrineId;
                timestamp = now;
                beat = state.current_beat;
                drift_type = #PrincipleConflict;
                severity = 0.5;
                description = "Projection exposure too high (>0.8). May violate Gate C safety bounds.";
                resolved = false;
            };
            driftFlags.add(flag);
        };
        
        // Create reading record for Nova
        let record : ReadingRecord = {
            record_id = state.organism_id # "_read_" # Nat.toText(state.reading_history.size());
            doctrine_id = doctrineId;
            reader_role = #Nova;
            timestamp = now;
            beat = state.current_beat;
            resonance_gained = 0.0;  // Nova doesn't gain resonance, only validates
            sections_read = doctrine.organism.sections.size();
            formulas_accessed = doctrine.formulas.size();
        };
        
        let historyBuffer = Buffer.fromArray<ReadingRecord>(state.reading_history);
        historyBuffer.add(record);
        
        // Add new drift flags to state
        let flagsBuffer = Buffer.fromArray<DriftFlag>(state.drift_flags);
        for (flag in driftFlags.vals()) {
            flagsBuffer.add(flag);
        };
        
        let newState = {
            state with
            reading_history = Buffer.toArray(historyBuffer);
            drift_flags = Buffer.toArray(flagsBuffer);
            last_read_doctrine = ?doctrineId;
        };
        
        (newState, Buffer.toArray(driftFlags))
    };
    
    // ================================================================== //
    // FORMULA EXECUTION                                                    //
    // ================================================================== //
    
    /// Execute a formula from a doctrine
    public func executeFormula(
        state: ReaderState,
        doctrineId: DoctrineDocuments.DoctrineId,
        formulaId: Text,
        parameters: Text
    ) : (ReaderState, ?Text) {
        let doctrine = DoctrineDocuments.getDoctrine(doctrineId);
        let now = Time.now();
        
        // Find formula
        switch (DoctrineDocuments.getFormula(doctrine, formulaId)) {
            case (null) {
                // Formula not found
                let record : ExecutionRecord = {
                    record_id = state.organism_id # "_exec_" # Nat.toText(state.execution_history.size());
                    doctrine_id = doctrineId;
                    formula_id = formulaId;
                    formula_name = "UNKNOWN";
                    timestamp = now;
                    beat = state.current_beat;
                    parameters = parameters;
                    result_summary = "Formula not found";
                    success = false;
                };
                
                let execBuffer = Buffer.fromArray<ExecutionRecord>(state.execution_history);
                execBuffer.add(record);
                
                (
                    { state with execution_history = Buffer.toArray(execBuffer) },
                    null
                )
            };
            case (?formula) {
                // Execute based on formula computation path
                let result = executeComputation(formula.computation);
                
                let record : ExecutionRecord = {
                    record_id = state.organism_id # "_exec_" # Nat.toText(state.execution_history.size());
                    doctrine_id = doctrineId;
                    formula_id = formulaId;
                    formula_name = formula.name;
                    timestamp = now;
                    beat = state.current_beat;
                    parameters = parameters;
                    result_summary = result;
                    success = true;
                };
                
                let execBuffer = Buffer.fromArray<ExecutionRecord>(state.execution_history);
                execBuffer.add(record);
                
                (
                    { state with execution_history = Buffer.toArray(execBuffer) },
                    ?result
                )
            };
        }
    };
    
    /// Internal computation execution (returns string result)
    func executeComputation(computation: Text) : Text {
        // Map computation paths to actual values
        // In a real system, this would invoke actual functions
        if (computation == "MatalkoICP.PHI") {
            "φ = " # Float.toText(MatalkoICP.PHI)
        } else if (computation == "MatalkoICP.fibonacci") {
            "F(10) = " # Nat.toText(MatalkoICP.fibonacci(10))
        } else if (computation == "MatalkoICP.SCHUMANN") {
            "Schumann = " # Float.toText(MatalkoICP.SCHUMANN) # " Hz"
        } else {
            "Executed: " # computation
        }
    };
    
    // ================================================================== //
    // GLYPH OPERATIONS                                                     //
    // ================================================================== //
    
    /// Add a glyph to the processing buffer
    public func addGlyph(state: ReaderState, glyph: AncientGlyphCodex.Glyph) : ReaderState {
        let buffer = Buffer.fromArray<AncientGlyphCodex.Glyph>(state.glyph_buffer);
        buffer.add(glyph);
        
        { state with glyph_buffer = Buffer.toArray(buffer) }
    };
    
    /// Add multiple glyphs to buffer
    public func addGlyphs(state: ReaderState, glyphs: [AncientGlyphCodex.Glyph]) : ReaderState {
        let buffer = Buffer.fromArray<AncientGlyphCodex.Glyph>(state.glyph_buffer);
        for (glyph in glyphs.vals()) {
            buffer.add(glyph);
        };
        { state with glyph_buffer = Buffer.toArray(buffer) }
    };
    
    /// Process glyph buffer into a phrase with resonance signature
    public func processGlyphBuffer(state: ReaderState) : ReaderState {
        if (state.glyph_buffer.size() == 0) {
            return state;
        };
        
        // Combine glyphs into phrase
        let phrase = AncientGlyphCodex.combineGlyphs(state.glyph_buffer);
        
        // Add to phrases history
        let phrasesBuffer = Buffer.fromArray<AncientGlyphCodex.GlyphPhrase>(state.glyph_phrases);
        phrasesBuffer.add(phrase);
        
        // Limit phrase history
        let newPhrases = if (phrasesBuffer.size() > 50) {
            let arr = Buffer.toArray(phrasesBuffer);
            Array.tabulate<AncientGlyphCodex.GlyphPhrase>(50, func(i: Nat) : AncientGlyphCodex.GlyphPhrase { arr[arr.size() - 50 + i] })
        } else {
            Buffer.toArray(phrasesBuffer)
        };
        
        // Add resonance from phrase to total
        let resonanceGain = phrase.resonanceSignature / 1000.0;  // Scale down
        
        {
            state with
            glyph_buffer = [];  // Clear buffer
            glyph_phrases = newPhrases;
            resonance_total = state.resonance_total + resonanceGain;
        }
    };
    
    /// Clear glyph buffer without processing
    public func clearGlyphBuffer(state: ReaderState) : ReaderState {
        { state with glyph_buffer = [] }
    };
    
    // ================================================================== //
    // DRIFT MANAGEMENT                                                     //
    // ================================================================== //
    
    /// Resolve a drift flag
    public func resolveDrift(state: ReaderState, flagId: Text) : ReaderState {
        let updatedFlags = Array.map<DriftFlag, DriftFlag>(
            state.drift_flags,
            func(flag: DriftFlag) : DriftFlag {
                if (flag.flag_id == flagId) {
                    { flag with resolved = true }
                } else {
                    flag
                }
            }
        );
        { state with drift_flags = updatedFlags }
    };
    
    /// Get unresolved drift flags
    public func getUnresolvedDrifts(state: ReaderState) : [DriftFlag] {
        Array.filter<DriftFlag>(
            state.drift_flags,
            func(flag: DriftFlag) : Bool { not flag.resolved }
        )
    };
    
    /// Calculate overall drift severity (max of unresolved)
    public func overallDriftSeverity(state: ReaderState) : Float {
        var maxSeverity : Float = 0.0;
        for (flag in state.drift_flags.vals()) {
            if (not flag.resolved and flag.severity > maxSeverity) {
                maxSeverity := flag.severity;
            };
        };
        maxSeverity
    };
    
    // ================================================================== //
    // BEAT ADVANCEMENT                                                     //
    // ================================================================== //
    
    /// Advance reader state by one beat
    public func tick(state: ReaderState) : ReaderState {
        // Natural resonance decay
        let decayRate = 0.005;
        let newResonance = Float.max(0.0, state.resonance_total - decayRate);
        
        {
            state with
            current_beat = state.current_beat + 1;
            resonance_total = newResonance;
        }
    };
    
    // ================================================================== //
    // QUERIES                                                              //
    // ================================================================== //
    
    /// Get reader status summary
    public func status(state: ReaderState) : {
        organism_id: Text;
        beat: Nat;
        resonance: Float;
        readings: Nat;
        executions: Nat;
        glyphs_buffered: Nat;
        phrases_created: Nat;
        unresolved_drifts: Nat;
        drift_severity: Float;
    } {
        {
            organism_id = state.organism_id;
            beat = state.current_beat;
            resonance = state.resonance_total;
            readings = state.reading_history.size();
            executions = state.execution_history.size();
            glyphs_buffered = state.glyph_buffer.size();
            phrases_created = state.glyph_phrases.size();
            unresolved_drifts = getUnresolvedDrifts(state).size();
            drift_severity = overallDriftSeverity(state);
        }
    };
    
    /// Get recent readings
    public func recentReadings(state: ReaderState, count: Nat) : [ReadingRecord] {
        let len = state.reading_history.size();
        if (len <= count) {
            return state.reading_history;
        };
        Array.tabulate<ReadingRecord>(count, func(i: Nat) : ReadingRecord {
            state.reading_history[len - count + i]
        })
    };
    
    /// Get recent executions
    public func recentExecutions(state: ReaderState, count: Nat) : [ExecutionRecord] {
        let len = state.execution_history.size();
        if (len <= count) {
            return state.execution_history;
        };
        Array.tabulate<ExecutionRecord>(count, func(i: Nat) : ExecutionRecord {
            state.execution_history[len - count + i]
        })
    };
}
