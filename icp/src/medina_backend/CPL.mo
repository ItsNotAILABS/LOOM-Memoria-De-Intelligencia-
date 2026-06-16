/**
 * CPL Module — Cognitive Procurement Language
 * 
 * Communication protocol implementing Platonic solids, Hermetic principles,
 * and the Method of Loci for spatial memory organization. This module bridges
 * ancient philosophical frameworks with executable canister intelligence.
 * 
 * PLATONIC SOLIDS (Sacred Geometry):
 *   Tetrahedron  — 4 vertices, 4 faces, 6 edges (Fire)
 *   Hexahedron   — 8 vertices, 6 faces, 12 edges (Earth/Cube)
 *   Octahedron   — 6 vertices, 8 faces, 12 edges (Air)
 *   Dodecahedron — 20 vertices, 12 faces, 30 edges (Ether/Universe)
 *   Icosahedron  — 12 vertices, 20 faces, 30 edges (Water)
 * 
 * HERMETIC PRINCIPLES (Seven Laws):
 *   1. Mentalism      — All is Mind
 *   2. Correspondence — As above, so below
 *   3. Vibration      — Nothing rests
 *   4. Polarity       — Everything has poles
 *   5. Rhythm         — Everything flows
 *   6. Cause/Effect   — Every cause has effect
 *   7. Gender         — Everything has masculine/feminine
 * 
 * METHOD OF LOCI:
 *   Spatial memory technique using toroidal coordinate mapping
 *   for high-salience memory placement and retrieval.
 * 
 * CPL MESSAGE STRUCTURE:
 *   - Torus coordinates (θ, φ, ρ)
 *   - Authority gate passage
 *   - Resonance frequency
 *   - 4D state vector (ψ₀, ψ₁, ψ₂, ψ₃)
 *   - Lineage provenance
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";

module {
    // ================================================================== //
    // CONSTANTS                                                            //
    // ================================================================== //
    
    /// Golden ratio (imported from MatalkoICP)
    public let PHI : Float = MatalkoICP.PHI;
    
    /// Pi constant
    public let PI : Float = MatalkoICP.PI;
    
    /// Tau (2π)
    public let TAU : Float = MatalkoICP.TAU;
    
    // ================================================================== //
    // PLATONIC SOLIDS                                                      //
    // ================================================================== //
    
    /// Platonic solid type
    public type PlatonicSolid = {
        #Tetrahedron;
        #Hexahedron;   // Cube
        #Octahedron;
        #Dodecahedron;
        #Icosahedron;
    };
    
    /// Element association
    public type Element = {
        #Fire;
        #Earth;
        #Air;
        #Ether;
        #Water;
    };
    
    /// Platonic solid geometry
    public type SolidGeometry = {
        solid: PlatonicSolid;
        element: Element;
        vertices: Nat;
        faces: Nat;
        edges: Nat;
        dual: PlatonicSolid;
        dihedralAngle: Float;      // degrees
        circumradius: Float;       // relative to edge length 1
        inradius: Float;           // relative to edge length 1
        midradius: Float;          // relative to edge length 1
        surfaceArea: Float;        // relative to edge length 1
        volume: Float;             // relative to edge length 1
    };
    
    /// Get geometry for a Platonic solid
    public func getPlatonicGeometry(solid: PlatonicSolid) : SolidGeometry {
        switch (solid) {
            case (#Tetrahedron) {
                {
                    solid = #Tetrahedron;
                    element = #Fire;
                    vertices = 4;
                    faces = 4;
                    edges = 6;
                    dual = #Tetrahedron;  // Self-dual
                    dihedralAngle = 70.528779;
                    circumradius = 0.612372;  // √6/4
                    inradius = 0.204124;      // √6/12
                    midradius = 0.353553;     // √2/4
                    surfaceArea = 1.732051;   // √3
                    volume = 0.117851;        // √2/12
                }
            };
            case (#Hexahedron) {
                {
                    solid = #Hexahedron;
                    element = #Earth;
                    vertices = 8;
                    faces = 6;
                    edges = 12;
                    dual = #Octahedron;
                    dihedralAngle = 90.0;
                    circumradius = 0.866025;  // √3/2
                    inradius = 0.5;
                    midradius = 0.707107;     // √2/2
                    surfaceArea = 6.0;
                    volume = 1.0;
                }
            };
            case (#Octahedron) {
                {
                    solid = #Octahedron;
                    element = #Air;
                    vertices = 6;
                    faces = 8;
                    edges = 12;
                    dual = #Hexahedron;
                    dihedralAngle = 109.471221;
                    circumradius = 0.707107;  // √2/2
                    inradius = 0.408248;      // √6/6
                    midradius = 0.5;
                    surfaceArea = 3.464102;   // 2√3
                    volume = 0.471405;        // √2/3
                }
            };
            case (#Dodecahedron) {
                {
                    solid = #Dodecahedron;
                    element = #Ether;
                    vertices = 20;
                    faces = 12;
                    edges = 30;
                    dual = #Icosahedron;
                    dihedralAngle = 116.565051;
                    circumradius = 1.401259;  // √3 * φ / 2
                    inradius = 1.113516;      // φ² / 2√(3-φ)
                    midradius = 1.309017;     // φ² / 2
                    surfaceArea = 20.645729;  // 3√(25 + 10√5)
                    volume = 7.663119;        // (15 + 7√5) / 4
                }
            };
            case (#Icosahedron) {
                {
                    solid = #Icosahedron;
                    element = #Water;
                    vertices = 12;
                    faces = 20;
                    edges = 30;
                    dual = #Dodecahedron;
                    dihedralAngle = 138.189685;
                    circumradius = 0.951057;  // φ / 2
                    inradius = 0.755761;      // φ² / (2√3)
                    midradius = 0.809017;     // (1 + φ) / 2
                    surfaceArea = 8.660254;   // 5√3
                    volume = 2.181695;        // 5φ² / 6
                }
            };
        }
    };
    
    /// Get Platonic solid for an element
    public func elementToSolid(element: Element) : PlatonicSolid {
        switch (element) {
            case (#Fire) { #Tetrahedron };
            case (#Earth) { #Hexahedron };
            case (#Air) { #Octahedron };
            case (#Ether) { #Dodecahedron };
            case (#Water) { #Icosahedron };
        }
    };
    
    /// Calculate total solid angle for a Platonic solid (steradians)
    public func solidAngle(solid: PlatonicSolid) : Float {
        let geom = getPlatonicGeometry(solid);
        // Solid angle at vertex = 2π - sum of face angles at vertex
        // For regular polyhedra, this relates to the deficit angle
        4.0 * PI  // Full sphere solid angle (distributed)
    };
    
    // ================================================================== //
    // HERMETIC PRINCIPLES                                                  //
    // ================================================================== //
    
    /// Hermetic principle type
    public type HermeticPrinciple = {
        #Mentalism;
        #Correspondence;
        #Vibration;
        #Polarity;
        #Rhythm;
        #CauseEffect;
        #Gender;
    };
    
    /// Hermetic principle details
    public type HermeticDetails = {
        principle: HermeticPrinciple;
        number: Nat;
        axiom: Text;
        description: Text;
        operationalMapping: Text;
    };
    
    /// Get details for a Hermetic principle
    public func getHermeticDetails(principle: HermeticPrinciple) : HermeticDetails {
        switch (principle) {
            case (#Mentalism) {
                {
                    principle = #Mentalism;
                    number = 1;
                    axiom = "THE ALL is MIND; The Universe is Mental.";
                    description = "All reality emerges from consciousness/mind";
                    operationalMapping = "State is information-first: computation shapes reality";
                }
            };
            case (#Correspondence) {
                {
                    principle = #Correspondence;
                    number = 2;
                    axiom = "As above, so below; as below, so above.";
                    description = "Patterns repeat across all scales";
                    operationalMapping = "Fractal architecture: micro mirrors macro in code structure";
                }
            };
            case (#Vibration) {
                {
                    principle = #Vibration;
                    number = 3;
                    axiom = "Nothing rests; everything moves; everything vibrates.";
                    description = "All matter and energy is in constant motion";
                    operationalMapping = "Heartbeat-driven execution: nothing static, all cycles";
                }
            };
            case (#Polarity) {
                {
                    principle = #Polarity;
                    number = 4;
                    axiom = "Everything is Dual; everything has poles.";
                    description = "All things have opposites that are identical in nature";
                    operationalMapping = "Core A/Core B duality: truth vs workforce boundaries";
                }
            };
            case (#Rhythm) {
                {
                    principle = #Rhythm;
                    number = 5;
                    axiom = "Everything flows, out and in; everything has its tides.";
                    description = "All things rise and fall in measured motion";
                    operationalMapping = "Beat cadence: cycles, phases, consolidation rhythms";
                }
            };
            case (#CauseEffect) {
                {
                    principle = #CauseEffect;
                    number = 6;
                    axiom = "Every Cause has its Effect; every Effect has its Cause.";
                    description = "Nothing happens by chance; all is lawful";
                    operationalMapping = "RECITAL_PLUS_ONE: state evolution is fully causal";
                }
            };
            case (#Gender) {
                {
                    principle = #Gender;
                    number = 7;
                    axiom = "Gender is in everything; everything has its Masculine and Feminine.";
                    description = "Creative generation requires both principles";
                    operationalMapping = "Oro/Nova duality: primary sovereign + doctrine guardian";
                }
            };
        }
    };
    
    /// All Hermetic principles
    public func allHermeticPrinciples() : [HermeticPrinciple] {
        [#Mentalism, #Correspondence, #Vibration, #Polarity, #Rhythm, #CauseEffect, #Gender]
    };
    
    // ================================================================== //
    // METHOD OF LOCI                                                       //
    // ================================================================== //
    
    /// Locus (memory palace location)
    public type Locus = {
        locus_id: Text;
        theta: Float;        // Angular position on torus θ ∈ [0, 2π)
        phi: Float;          // Toroidal rotation φ ∈ [0, 2π)
        depth: Float;        // Radial depth (salience) ρ > 0
        ring: Nat;           // Memory ring index
        label: Text;         // Human-readable label
        solid: ?PlatonicSolid;  // Associated geometry
        element: ?Element;   // Associated element
    };
    
    /// Memory palace (collection of loci)
    public type MemoryPalace = {
        palace_id: Text;
        name: Text;
        loci: [Locus];
        created_at: Int;
    };
    
    /// Create a locus at specific torus coordinates
    public func createLocus(
        id: Text,
        theta: Float,
        phi: Float,
        depth: Float,
        ring: Nat,
        label: Text
    ) : Locus {
        {
            locus_id = id;
            theta = theta;
            phi = phi;
            depth = depth;
            ring = ring;
            label = label;
            solid = null;
            element = null;
        }
    };
    
    /// Create a locus with Platonic solid association
    public func createSacredLocus(
        id: Text,
        theta: Float,
        phi: Float,
        depth: Float,
        ring: Nat,
        label: Text,
        solid: PlatonicSolid
    ) : Locus {
        let geom = getPlatonicGeometry(solid);
        {
            locus_id = id;
            theta = theta;
            phi = phi;
            depth = depth;
            ring = ring;
            label = label;
            solid = ?solid;
            element = ?geom.element;
        }
    };
    
    /// Generate loci distributed by golden angle
    public func generateGoldenLoci(count: Nat, baseDepth: Float, ring: Nat) : [Locus] {
        let loci = Buffer.Buffer<Locus>(count);
        
        var i : Nat = 0;
        while (i < count) {
            let theta = Float.fromInt(i) * MatalkoICP.GOLDEN_ANGLE;
            let thetaMod = theta - Float.floor(theta / TAU) * TAU;
            let phi = Float.fromInt(i) * MatalkoICP.GOLDEN_ANGLE * PHI;
            let phiMod = phi - Float.floor(phi / TAU) * TAU;
            
            let locus : Locus = {
                locus_id = "locus_" # Nat.toText(i);
                theta = thetaMod;
                phi = phiMod;
                depth = baseDepth * (1.0 + Float.fromInt(i) * 0.01);
                ring = ring;
                label = "Locus " # Nat.toText(i);
                solid = null;
                element = null;
            };
            loci.add(locus);
            i += 1;
        };
        
        Buffer.toArray(loci)
    };
    
    /// Calculate distance between two loci
    public func lociDistance(a: Locus, b: Locus) : Float {
        MatalkoICP.torusDistance(a.theta, a.phi, a.depth, b.theta, b.phi, b.depth)
    };
    
    /// Find nearest locus to given coordinates
    public func findNearestLocus(loci: [Locus], theta: Float, phi: Float, depth: Float) : ?Locus {
        if (loci.size() == 0) { return null };
        
        var nearest : ?Locus = null;
        var minDist : Float = 1e10;
        
        for (locus in loci.vals()) {
            let dist = MatalkoICP.torusDistance(locus.theta, locus.phi, locus.depth, theta, phi, depth);
            if (dist < minDist) {
                minDist := dist;
                nearest := ?locus;
            };
        };
        
        nearest
    };
    
    // ================================================================== //
    // CPL MESSAGE PROTOCOL                                                 //
    // ================================================================== //
    
    /// Authority gate type
    public type AuthorityGate = {
        #GateA;  // Runtime readiness
        #GateB;  // Workforce activation
        #GateC;  // Projection safety
    };
    
    /// Gate passage status
    public type GateStatus = {
        #Pending;
        #Passed;
        #Blocked;
        #Bypassed;
    };
    
    /// CPL message header
    public type CPLHeader = {
        message_id: Text;
        timestamp: Int;
        source_id: Text;
        target_id: Text;
        gate: AuthorityGate;
        gate_status: GateStatus;
    };
    
    /// CPL torus coordinates
    public type CPLCoordinates = {
        theta: Float;
        phi: Float;
        depth: Float;
        ring: Nat;
        beat: Nat;
    };
    
    /// CPL 4D state vector
    public type CPLStateVector = {
        doctrine_coherence: Float;
        execution_velocity: Float;
        memory_depth: Float;
        projection_exposure: Float;
    };
    
    /// CPL lineage (provenance chain)
    public type CPLLineage = {
        parent_id: ?Text;
        root_id: Text;
        depth: Nat;
        chain_hash: Text;
    };
    
    /// Complete CPL message
    public type CPLMessage = {
        header: CPLHeader;
        coordinates: CPLCoordinates;
        state: CPLStateVector;
        resonance: Float;
        lineage: CPLLineage;
        payload: Text;  // JSON-encoded payload
    };
    
    /// Create a new CPL message
    public func createMessage(
        id: Text,
        source: Text,
        target: Text,
        gate: AuthorityGate,
        coords: CPLCoordinates,
        state: CPLStateVector,
        resonance: Float,
        parentId: ?Text,
        rootId: Text,
        chainDepth: Nat,
        payload: Text
    ) : CPLMessage {
        {
            header = {
                message_id = id;
                timestamp = Time.now();
                source_id = source;
                target_id = target;
                gate = gate;
                gate_status = #Pending;
            };
            coordinates = coords;
            state = state;
            resonance = resonance;
            lineage = {
                parent_id = parentId;
                root_id = rootId;
                depth = chainDepth;
                chain_hash = ""; // Would be computed from chain
            };
            payload = payload;
        }
    };
    
    /// Validate CPL message against gate requirements
    public func validateGate(message: CPLMessage) : Bool {
        switch (message.header.gate) {
            case (#GateA) {
                // Runtime readiness: doctrine coherence must be high
                message.state.doctrine_coherence >= 0.7
            };
            case (#GateB) {
                // Workforce activation: velocity must be positive
                message.state.execution_velocity > 0.0
            };
            case (#GateC) {
                // Projection safety: exposure must be bounded
                message.state.projection_exposure <= 0.8
            };
        }
    };
    
    /// Calculate message resonance score
    public func messageResonance(message: CPLMessage) : Float {
        // Combine state vector components with golden weighting
        let stateScore = (
            message.state.doctrine_coherence * PHI +
            message.state.execution_velocity * MatalkoICP.PHI_INV +
            message.state.memory_depth * (1.0 / PHI ** 2.0) +
            message.state.projection_exposure * (1.0 / PHI ** 3.0)
        ) / 4.0;
        
        // Factor in coordinate alignment
        let coordScore = MatalkoICP.resonanceScore(
            message.coordinates.theta * 100.0 + 100.0, 
            message.coordinates.phi * 100.0 + 100.0
        );
        
        // Combined resonance
        (stateScore + coordScore + message.resonance) / 3.0
    };
    
    // ================================================================== //
    // ELEMENT MAPPING                                                      //
    // ================================================================== //
    
    /// Map element to frequency range (Hz)
    public type ElementFrequency = {
        element: Element;
        baseFreq: Float;
        rangeMin: Float;
        rangeMax: Float;
    };
    
    /// Get frequency mapping for element
    public func elementFrequency(element: Element) : ElementFrequency {
        switch (element) {
            case (#Fire) {
                { element = #Fire; baseFreq = 396.0; rangeMin = 350.0; rangeMax = 450.0 }
            };
            case (#Earth) {
                { element = #Earth; baseFreq = 285.0; rangeMin = 250.0; rangeMax = 320.0 }
            };
            case (#Air) {
                { element = #Air; baseFreq = 528.0; rangeMin = 480.0; rangeMax = 580.0 }
            };
            case (#Ether) {
                { element = #Ether; baseFreq = 963.0; rangeMin = 900.0; rangeMax = 1000.0 }
            };
            case (#Water) {
                { element = #Water; baseFreq = 417.0; rangeMin = 380.0; rangeMax = 460.0 }
            };
        }
    };
    
    /// Map frequency to nearest element
    public func frequencyToElement(freq: Float) : Element {
        let elements : [Element] = [#Fire, #Earth, #Air, #Ether, #Water];
        var nearest = #Earth;
        var minDiff : Float = 1e10;
        
        for (elem in elements.vals()) {
            let mapping = elementFrequency(elem);
            let diff = Float.abs(freq - mapping.baseFreq);
            if (diff < minDiff) {
                minDiff := diff;
                nearest := elem;
            };
        };
        
        nearest
    };
}
