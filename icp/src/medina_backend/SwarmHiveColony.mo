/**
 * ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                                           ║
 * ║                            SWARM HIVE COLONY ARCHITECTURE                                                  ║
 * ║                       Biological Intelligence for System Management                                        ║
 * ║                                                                                                           ║
 * ║                        "Unum in Multis — Multi in Uno"                                                    ║
 * ║                        (One in Many — Many in One)                                                         ║
 * ║                                                                                                           ║
 * ║  ═══════════════════════════════════════════════════════════════════════════════════════════════════════  ║
 * ║                                                                                                           ║
 * ║  BIOLOGICAL ARCHITECTURES IMPLEMENTED:                                                                     ║
 * ║  ┌─────────────────────────────────────────────────────────────────────────────────────────────────────┐  ║
 * ║  │                                                                                                      │  ║
 * ║  │  🐜 ANT COLONY OPTIMIZATION (ACO)                                                                    │  ║
 * ║  │     └── Pheromone trails for path optimization                                                       │  ║
 * ║  │     └── Collective decision making                                                                   │  ║
 * ║  │     └── Task allocation via stigmergy                                                                │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  🐝 HIVE MIND ARCHITECTURE                                                                           │  ║
 * ║  │     └── Waggle dance for information sharing                                                         │  ║
 * ║  │     └── Queen/worker/drone hierarchy                                                                 │  ║
 * ║  │     └── Collective intelligence emergence                                                            │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  🦅 SWARM INTELLIGENCE                                                                               │  ║
 * ║  │     └── Particle swarm optimization                                                                  │  ║
 * ║  │     └── Flocking behavior (Reynolds rules)                                                           │  ║
 * ║  │     └── Emergent coordination                                                                        │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  🗳️ VOTING/BALLOT SYSTEM                                                                             │  ║
 * ║  │     └── Weighted voting with φ-scaling                                                               │  ║
 * ║  │     └── Quadratic voting for decisions                                                               │  ║
 * ║  │     └── Token-weighted governance                                                                    │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  🏛️ CIVILIZATION INFRASTRUCTURE                                                                       │  ║
 * ║  │     └── Capitalist foundation (commerce, markets)                                                    │  ║
 * ║  │     └── Democratic governance (voting, representation)                                               │  ║
 * ║  │     └── Legal framework (laws, contracts)                                                            │  ║
 * ║  │                                                                                                      │  ║
 * ║  └─────────────────────────────────────────────────────────────────────────────────────────────────────┘  ║
 * ║                                                                                                           ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, Texas                             ║
 * ║  PROPRIETARY AND CONFIDENTIAL — ALL RIGHTS RESERVED                                                       ║
 * ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Nat64 "mo:base/Nat64";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Iter "mo:base/Iter";

import MatalkoICP "MatalkoICP";

module SwarmHiveColony {
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // CONSTANTS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public let PHI : Float = 1.618033988749895;
    public let PHI_SQUARED : Float = PHI * PHI;
    
    public let DOCTRINE = {
        latin = "Unum in Multis — Multi in Uno";
        english = "One in Many — Many in One";
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // ANT COLONY OPTIMIZATION
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public module AntColony {
        
        /// Pheromone trail
        public type Pheromone = {
            pathId: Text;
            strength: Float;
            timestamp: Int;
            evaporationRate: Float;
        };
        
        /// Ant agent
        public type Ant = {
            id: Text;
            position: Nat;
            path: [Nat];
            pheromoneDeposit: Float;
            taskType: AntTask;
        };
        
        /// Ant task types
        public type AntTask = {
            #Scout;       // Find new paths
            #Worker;      // Follow and reinforce paths
            #Soldier;     // Protect critical paths
            #Queen;       // Coordinate colony
            #Nurse;       // Maintain internal systems
        };
        
        /// Colony state
        public type Colony = {
            ants: [Ant];
            pheromones: [Pheromone];
            foodSources: [Nat];  // Optimal solutions found
            nestPosition: Nat;
            generation: Nat;
        };
        
        /// ACO parameters
        public type ACOParams = {
            alpha: Float;        // Pheromone importance
            beta: Float;         // Heuristic importance
            evaporationRate: Float;
            q: Float;            // Pheromone deposit constant
            antCount: Nat;
        };
        
        /// Default parameters (φ-tuned)
        public func defaultParams() : ACOParams {
            {
                alpha = PHI;
                beta = 1.0 / PHI;
                evaporationRate = 0.1 / PHI;
                q = PHI_SQUARED;
                antCount = 89;  // Fibonacci
            }
        };
        
        /// Initialize colony
        public func initColony(antCount: Nat) : Colony {
            let ants = Buffer.Buffer<Ant>(antCount);
            for (i in Iter.range(0, antCount - 1)) {
                let taskType : AntTask = if (i < antCount / 10) { #Scout }
                                        else if (i < antCount / 2) { #Worker }
                                        else if (i < antCount * 3 / 4) { #Soldier }
                                        else if (i < antCount - 1) { #Nurse }
                                        else { #Queen };
                ants.add({
                    id = "ANT-" # Nat.toText(i);
                    position = 0;
                    path = [];
                    pheromoneDeposit = PHI;
                    taskType = taskType;
                });
            };
            
            {
                ants = Buffer.toArray(ants);
                pheromones = [];
                foodSources = [];
                nestPosition = 0;
                generation = 0;
            }
        };
        
        /// Calculate transition probability (φ-weighted)
        public func transitionProbability(
            pheromone: Float,
            heuristic: Float,
            params: ACOParams
        ) : Float {
            Float.pow(pheromone, params.alpha) * Float.pow(heuristic, params.beta)
        };
        
        /// Update pheromones (evaporation + deposit)
        public func updatePheromones(
            pheromones: [Pheromone],
            newDeposits: [(Text, Float)],
            evaporationRate: Float
        ) : [Pheromone] {
            let updated = Buffer.Buffer<Pheromone>(pheromones.size());
            
            // Evaporate existing
            for (p in pheromones.vals()) {
                let newStrength = p.strength * (1.0 - evaporationRate);
                if (newStrength > 0.001) {
                    updated.add({
                        pathId = p.pathId;
                        strength = newStrength;
                        timestamp = Time.now();
                        evaporationRate = evaporationRate;
                    });
                };
            };
            
            // Add new deposits
            for ((pathId, amount) in newDeposits.vals()) {
                var found = false;
                let final = Buffer.Buffer<Pheromone>(updated.size());
                for (p in updated.vals()) {
                    if (p.pathId == pathId) {
                        found := true;
                        final.add({
                            pathId = p.pathId;
                            strength = p.strength + amount;
                            timestamp = Time.now();
                            evaporationRate = p.evaporationRate;
                        });
                    } else {
                        final.add(p);
                    };
                };
                if (not found) {
                    final.add({
                        pathId = pathId;
                        strength = amount;
                        timestamp = Time.now();
                        evaporationRate = evaporationRate;
                    });
                };
            };
            
            Buffer.toArray(updated)
        };
        
        /// Collective decision using stigmergy
        public func collectiveDecision(
            options: [Text],
            pheromones: [Pheromone],
            params: ACOParams
        ) : ?Text {
            if (options.size() == 0) return null;
            
            var bestOption = options[0];
            var bestScore = 0.0;
            
            for (opt in options.vals()) {
                var score = 1.0;  // Base score
                for (p in pheromones.vals()) {
                    if (p.pathId == opt) {
                        score := transitionProbability(p.strength, 1.0, params);
                    };
                };
                if (score > bestScore) {
                    bestScore := score;
                    bestOption := opt;
                };
            };
            
            ?bestOption
        };
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // HIVE MIND ARCHITECTURE
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public module HiveMind {
        
        /// Bee role
        public type BeeRole = {
            #Queen;      // Decision maker, single per hive
            #Worker;     // Task execution
            #Drone;      // Information gathering
            #Scout;      // Exploration
            #Nurse;      // Internal maintenance
            #Guard;      // Security
        };
        
        /// Waggle dance (information sharing)
        public type WaggleDance = {
            dancerId: Text;
            direction: Float;    // Angle (0-360)
            distance: Float;     // Encoded as duration
            quality: Float;      // Resource quality (0-1)
            timestamp: Int;
        };
        
        /// Bee agent
        public type Bee = {
            id: Text;
            role: BeeRole;
            energy: Float;
            knowledge: [Text];
            currentTask: ?Text;
            lastDance: ?WaggleDance;
        };
        
        /// Hive state
        public type Hive = {
            queen: Bee;
            workers: [Bee];
            drones: [Bee];
            scouts: [Bee];
            dances: [WaggleDance];
            resources: Nat;
            generation: Nat;
        };
        
        /// Initialize hive
        public func initHive(workerCount: Nat) : Hive {
            let queen : Bee = {
                id = "QUEEN-0";
                role = #Queen;
                energy = PHI;
                knowledge = ["GOVERNANCE", "COORDINATION", "DECISION"];
                currentTask = ?"OVERSEE";
                lastDance = null;
            };
            
            let workers = Buffer.Buffer<Bee>(workerCount);
            let droneCount = workerCount / 5;
            let scoutCount = workerCount / 10;
            
            for (i in Iter.range(0, workerCount - 1)) {
                workers.add({
                    id = "WORKER-" # Nat.toText(i);
                    role = #Worker;
                    energy = 1.0;
                    knowledge = [];
                    currentTask = null;
                    lastDance = null;
                });
            };
            
            let drones = Buffer.Buffer<Bee>(droneCount);
            for (i in Iter.range(0, droneCount - 1)) {
                drones.add({
                    id = "DRONE-" # Nat.toText(i);
                    role = #Drone;
                    energy = 0.8;
                    knowledge = [];
                    currentTask = null;
                    lastDance = null;
                });
            };
            
            let scouts = Buffer.Buffer<Bee>(scoutCount);
            for (i in Iter.range(0, scoutCount - 1)) {
                scouts.add({
                    id = "SCOUT-" # Nat.toText(i);
                    role = #Scout;
                    energy = 1.2;
                    knowledge = [];
                    currentTask = null;
                    lastDance = null;
                });
            };
            
            {
                queen = queen;
                workers = Buffer.toArray(workers);
                drones = Buffer.toArray(drones);
                scouts = Buffer.toArray(scouts);
                dances = [];
                resources = 0;
                generation = 0;
            }
        };
        
        /// Create waggle dance
        public func createDance(
            dancerId: Text,
            direction: Float,
            distance: Float,
            quality: Float
        ) : WaggleDance {
            {
                dancerId = dancerId;
                direction = direction;
                distance = distance;
                quality = quality;
                timestamp = Time.now();
            }
        };
        
        /// Collective decision via dance recruitment
        public func collectiveDecision(dances: [WaggleDance]) : ?Float {
            if (dances.size() == 0) return null;
            
            // Weight by quality and recency
            var totalWeight = 0.0;
            var weightedSum = 0.0;
            let now = Time.now();
            
            for (d in dances.vals()) {
                let age = Float.fromInt(Int.abs(now - d.timestamp)) / 1_000_000_000.0;
                let recencyWeight = Float.exp(-age / PHI);
                let weight = d.quality * recencyWeight;
                totalWeight += weight;
                weightedSum += d.direction * weight;
            };
            
            if (totalWeight > 0.0) {
                ?(weightedSum / totalWeight)
            } else {
                null
            }
        };
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // PARTICLE SWARM OPTIMIZATION
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public module ParticleSwarm {
        
        /// Particle in swarm
        public type Particle = {
            id: Text;
            position: [Float];
            velocity: [Float];
            bestPosition: [Float];
            bestFitness: Float;
        };
        
        /// Swarm state
        public type Swarm = {
            particles: [Particle];
            globalBestPosition: [Float];
            globalBestFitness: Float;
            dimensions: Nat;
            iteration: Nat;
        };
        
        /// PSO parameters
        public type PSOParams = {
            w: Float;         // Inertia weight
            c1: Float;        // Cognitive coefficient
            c2: Float;        // Social coefficient
            particleCount: Nat;
        };
        
        /// Default parameters (φ-tuned)
        public func defaultParams() : PSOParams {
            {
                w = 1.0 / PHI;
                c1 = PHI;
                c2 = PHI;
                particleCount = 55;  // Fibonacci
            }
        };
        
        /// Initialize swarm
        public func initSwarm(dimensions: Nat, particleCount: Nat) : Swarm {
            let particles = Buffer.Buffer<Particle>(particleCount);
            
            for (i in Iter.range(0, particleCount - 1)) {
                let pos = Array.tabulate<Float>(dimensions, func(d) {
                    Float.fromInt(i * d + 1) / Float.fromInt(particleCount)
                });
                let vel = Array.tabulate<Float>(dimensions, func(_) { 0.0 });
                
                particles.add({
                    id = "PARTICLE-" # Nat.toText(i);
                    position = pos;
                    velocity = vel;
                    bestPosition = pos;
                    bestFitness = 0.0;
                });
            };
            
            let initialBest = Array.tabulate<Float>(dimensions, func(_) { 0.0 });
            
            {
                particles = Buffer.toArray(particles);
                globalBestPosition = initialBest;
                globalBestFitness = 0.0;
                dimensions = dimensions;
                iteration = 0;
            }
        };
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // VOTING / BALLOT SYSTEM
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public module VotingSystem {
        
        /// Vote type
        public type VoteType = {
            #Simple;           // One vote per voter
            #Weighted;         // Token-weighted
            #Quadratic;        // Cost = votes²
            #Conviction;       // Time-weighted
            #Ranked;           // Ranked choice
        };
        
        /// Vote record
        public type Vote = {
            voterId: Text;
            proposalId: Text;
            choice: Nat;       // Option index
            weight: Float;
            timestamp: Int;
        };
        
        /// Proposal
        public type Proposal = {
            id: Text;
            title: Text;
            description: Text;
            options: [Text];
            voteType: VoteType;
            startTime: Int;
            endTime: Int;
            quorum: Float;
            threshold: Float;
        };
        
        /// Ballot state
        public type Ballot = {
            proposal: Proposal;
            votes: [Vote];
            results: [Float];  // Score per option
            finalized: Bool;
            winner: ?Nat;
        };
        
        /// Calculate vote weight (φ-scaled)
        public func calculateWeight(
            tokens: Nat,
            voteType: VoteType
        ) : Float {
            switch (voteType) {
                case (#Simple) { 1.0 };
                case (#Weighted) { Float.fromInt(tokens) };
                case (#Quadratic) { Float.sqrt(Float.fromInt(tokens)) };
                case (#Conviction) { Float.fromInt(tokens) * PHI };
                case (#Ranked) { 1.0 };
            }
        };
        
        /// Tally votes
        public func tallyVotes(ballot: Ballot) : [Float] {
            let results = Array.tabulateVar<Float>(ballot.proposal.options.size(), func(_) { 0.0 });
            
            for (v in ballot.votes.vals()) {
                if (v.choice < results.size()) {
                    results[v.choice] := results[v.choice] + v.weight;
                };
            };
            
            Array.freeze(results)
        };
        
        /// Determine winner
        public func determineWinner(results: [Float], threshold: Float) : ?Nat {
            var maxIndex : ?Nat = null;
            var maxScore = 0.0;
            var totalScore = 0.0;
            
            var i = 0;
            for (score in results.vals()) {
                totalScore += score;
                if (score > maxScore) {
                    maxScore := score;
                    maxIndex := ?i;
                };
                i += 1;
            };
            
            // Check threshold
            if (totalScore > 0.0 and maxScore / totalScore >= threshold) {
                maxIndex
            } else {
                null
            }
        };
        
        /// Create ballot
        public func createBallot(
            proposalId: Text,
            title: Text,
            options: [Text],
            voteType: VoteType,
            durationNs: Int,
            quorum: Float,
            threshold: Float
        ) : Ballot {
            let now = Time.now();
            {
                proposal = {
                    id = proposalId;
                    title = title;
                    description = "";
                    options = options;
                    voteType = voteType;
                    startTime = now;
                    endTime = now + durationNs;
                    quorum = quorum;
                    threshold = threshold;
                };
                votes = [];
                results = Array.tabulate<Float>(options.size(), func(_) { 0.0 });
                finalized = false;
                winner = null;
            }
        };
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // CIVILIZATION INFRASTRUCTURE
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public module Civilization {
        
        /// Economic system type
        public type EconomicSystem = {
            #Capitalist;   // Free market
            #Mixed;        // Market + governance
            #Cooperative;  // Collective ownership
        };
        
        /// Governance type
        public type GovernanceType = {
            #Democracy;      // Majority rule
            #Republic;       // Representative
            #Technocracy;    // Expert rule
            #Meritocracy;    // Merit-based
            #Hybrid;         // Combined
        };
        
        /// Legal principle
        public type LegalPrinciple = {
            #RuleOfLaw;
            #DueProcess;
            #EqualProtection;
            #ContractEnforcement;
            #PropertyRights;
            #PrivacyRights;
        };
        
        /// Citizen role
        public type CitizenRole = {
            #Founder;        // Highest authority
            #Governor;       // Governance role
            #Representative; // Elected representative
            #Citizen;        // Standard member
            #Visitor;        // Limited access
        };
        
        /// Citizen record
        public type Citizen = {
            id: Text;
            role: CitizenRole;
            tokens: Nat;
            votingPower: Float;
            reputation: Float;
            joinedAt: Int;
        };
        
        /// Law record
        public type Law = {
            id: Text;
            title: Text;
            content: Text;
            principles: [LegalPrinciple];
            enactedAt: Int;
            amendable: Bool;
        };
        
        /// Market record
        public type Market = {
            id: Text;
            name: Text;
            assetType: Text;
            totalVolume: Nat;
            participants: Nat;
        };
        
        /// Civilization state
        public type CivilizationState = {
            name: Text;
            economic: EconomicSystem;
            governance: GovernanceType;
            citizens: [Citizen];
            laws: [Law];
            markets: [Market];
            treasury: Nat;
            foundedAt: Int;
        };
        
        /// Initialize civilization
        public func initCivilization(name: Text) : CivilizationState {
            let founder : Citizen = {
                id = "FOUNDER-MEDINA";
                role = #Founder;
                tokens = 1_000_000_000;  // Unlimited effective
                votingPower = PHI_SQUARED;
                reputation = 1.0;
                joinedAt = Time.now();
            };
            
            let foundingLaws : [Law] = [
                {
                    id = "LAW-001";
                    title = "Universal Primitive Law";
                    content = "No entity enters without primitive trace";
                    principles = [#RuleOfLaw, #DueProcess];
                    enactedAt = Time.now();
                    amendable = false;
                },
                {
                    id = "LAW-002";
                    title = "IP Protection Law";
                    content = "All intellectual property is protected by blockchain hash";
                    principles = [#PropertyRights, #ContractEnforcement];
                    enactedAt = Time.now();
                    amendable = false;
                },
                {
                    id = "LAW-003";
                    title = "Token Economy Law";
                    content = "Every decision mints proof tokens";
                    principles = [#ContractEnforcement, #PropertyRights];
                    enactedAt = Time.now();
                    amendable = false;
                }
            ];
            
            {
                name = name;
                economic = #Mixed;  // Capitalist foundation with governance
                governance = #Hybrid;
                citizens = [founder];
                laws = foundingLaws;
                markets = [];
                treasury = 0;
                foundedAt = Time.now();
            }
        };
        
        /// Add citizen
        public func addCitizen(
            state: CivilizationState,
            id: Text,
            role: CitizenRole
        ) : CivilizationState {
            let citizen : Citizen = {
                id = id;
                role = role;
                tokens = switch (role) {
                    case (#Founder) { 1_000_000_000 };
                    case (#Governor) { 100_000 };
                    case (#Representative) { 10_000 };
                    case (#Citizen) { 1_000 };
                    case (#Visitor) { 100 };
                };
                votingPower = switch (role) {
                    case (#Founder) { PHI_SQUARED };
                    case (#Governor) { PHI };
                    case (#Representative) { 1.0 };
                    case (#Citizen) { 1.0 / PHI };
                    case (#Visitor) { 0.0 };
                };
                reputation = switch (role) {
                    case (#Founder) { 1.0 };
                    case (#Governor) { 0.9 };
                    case (#Representative) { 0.8 };
                    case (#Citizen) { 0.5 };
                    case (#Visitor) { 0.1 };
                };
                joinedAt = Time.now();
            };
            
            let citizens = Buffer.fromArray<Citizen>(state.citizens);
            citizens.add(citizen);
            
            {
                name = state.name;
                economic = state.economic;
                governance = state.governance;
                citizens = Buffer.toArray(citizens);
                laws = state.laws;
                markets = state.markets;
                treasury = state.treasury;
                foundedAt = state.foundedAt;
            }
        };
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // FLOCKING BEHAVIOR (Reynolds Rules)
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public module Flocking {
        
        /// Boid (bird-oid) agent
        public type Boid = {
            id: Text;
            position: (Float, Float);
            velocity: (Float, Float);
        };
        
        /// Flock state
        public type Flock = {
            boids: [Boid];
            centerOfMass: (Float, Float);
            averageVelocity: (Float, Float);
        };
        
        /// Reynolds parameters
        public type ReynoldsParams = {
            separationWeight: Float;  // Avoid crowding
            alignmentWeight: Float;   // Steer toward average heading
            cohesionWeight: Float;    // Steer toward center of mass
            perceptionRadius: Float;
        };
        
        /// Default parameters (φ-tuned)
        public func defaultParams() : ReynoldsParams {
            {
                separationWeight = PHI;
                alignmentWeight = 1.0;
                cohesionWeight = 1.0 / PHI;
                perceptionRadius = PHI_SQUARED;
            }
        };
        
        /// Calculate separation force
        public func separation(boid: Boid, neighbors: [Boid], params: ReynoldsParams) : (Float, Float) {
            var fx = 0.0;
            var fy = 0.0;
            var count = 0;
            
            for (n in neighbors.vals()) {
                if (n.id != boid.id) {
                    let dx = boid.position.0 - n.position.0;
                    let dy = boid.position.1 - n.position.1;
                    let dist = Float.sqrt(dx * dx + dy * dy);
                    if (dist > 0.0 and dist < params.perceptionRadius) {
                        fx += dx / dist;
                        fy += dy / dist;
                        count += 1;
                    };
                };
            };
            
            if (count > 0) {
                (fx / Float.fromInt(count) * params.separationWeight,
                 fy / Float.fromInt(count) * params.separationWeight)
            } else {
                (0.0, 0.0)
            }
        };
        
        /// Calculate alignment force
        public func alignment(boid: Boid, neighbors: [Boid], params: ReynoldsParams) : (Float, Float) {
            var vx = 0.0;
            var vy = 0.0;
            var count = 0;
            
            for (n in neighbors.vals()) {
                if (n.id != boid.id) {
                    vx += n.velocity.0;
                    vy += n.velocity.1;
                    count += 1;
                };
            };
            
            if (count > 0) {
                ((vx / Float.fromInt(count) - boid.velocity.0) * params.alignmentWeight,
                 (vy / Float.fromInt(count) - boid.velocity.1) * params.alignmentWeight)
            } else {
                (0.0, 0.0)
            }
        };
        
        /// Calculate cohesion force
        public func cohesion(boid: Boid, neighbors: [Boid], params: ReynoldsParams) : (Float, Float) {
            var cx = 0.0;
            var cy = 0.0;
            var count = 0;
            
            for (n in neighbors.vals()) {
                if (n.id != boid.id) {
                    cx += n.position.0;
                    cy += n.position.1;
                    count += 1;
                };
            };
            
            if (count > 0) {
                let targetX = cx / Float.fromInt(count);
                let targetY = cy / Float.fromInt(count);
                ((targetX - boid.position.0) * params.cohesionWeight,
                 (targetY - boid.position.1) * params.cohesionWeight)
            } else {
                (0.0, 0.0)
            }
        };
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // INTEGRATED SWARM MANAGEMENT
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public type SwarmManagementState = {
        antColony: AntColony.Colony;
        hive: HiveMind.Hive;
        swarm: ParticleSwarm.Swarm;
        civilization: Civilization.CivilizationState;
    };
    
    /// Initialize full swarm management
    public func initSwarmManagement() : SwarmManagementState {
        {
            antColony = AntColony.initColony(89);  // Fibonacci
            hive = HiveMind.initHive(144);         // Fibonacci
            swarm = ParticleSwarm.initSwarm(8, 55); // Fibonacci
            civilization = Civilization.initCivilization("VOI Civilization");
        }
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // STATUS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public func status() : {
        doctrine: Text;
        antColonySize: Nat;
        hiveSize: Nat;
        swarmSize: Nat;
        civilizationName: Text;
        totalBiologicalAgents: Nat;
    } {
        {
            doctrine = DOCTRINE.english;
            antColonySize = 89;
            hiveSize = 144;
            swarmSize = 55;
            civilizationName = "VOI Civilization";
            totalBiologicalAgents = 89 + 144 + 55;
        }
    };
}
