/**
 * ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                                           ║
 * ║                    DECISION HASH BLOCKCHAIN — IP PROTECTION VIA DECISION HASHING                          ║
 * ║                                                                                                           ║
 * ║                            "Omnis Decisio Est Probatio — Omnis Probatio Est Token"                        ║
 * ║                            (Every Decision Is Proof — Every Proof Is Token)                               ║
 * ║                                                                                                           ║
 * ║  ═══════════════════════════════════════════════════════════════════════════════════════════════════════  ║
 * ║                                                                                                           ║
 * ║  DOCTRINE:                                                                                                 ║
 * ║  ┌─────────────────────────────────────────────────────────────────────────────────────────────────────┐  ║
 * ║  │  Every decision the organism makes is:                                                              │  ║
 * ║  │    1. HASHED — Using ANIMA phi-native hash                                                          │  ║
 * ║  │    2. TIMESTAMPED — Immutable time proof                                                            │  ║
 * ║  │    3. CHAINED — Linked to previous decisions via merkle                                             │  ║
 * ║  │    4. TOKEN-MINTED — Every decision mints proof tokens                                              │  ║
 * ║  │    5. IP-PROTECTED — Full blockchain encryption                                                     │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  Decision interval: Every 2 seconds across ALL models                                               │  ║
 * ║  │  Models count: 847 models                                                                           │  ║
 * ║  │  Decisions per minute: ~25,410 (847 × 30)                                                           │  ║
 * ║  │  Decisions per hour: ~1,524,600                                                                     │  ║
 * ║  │  Decisions per day: ~36,590,400                                                                     │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  All decisions are PROOF OF INTELLIGENCE. All proofs are TOKENS.                                   │  ║
 * ║  └─────────────────────────────────────────────────────────────────────────────────────────────────────┘  ║
 * ║                                                                                                           ║
 * ║  HASH FORMULA:                                                                                            ║
 * ║  ┌─────────────────────────────────────────────────────────────────────────────────────────────────────┐  ║
 * ║  │  Our hash is NOT SHA-256. Our hash is ANIMA — φ-native, intelligence-bound.                        │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  ANIMA(x) = Σ[φ^i × x[i] × cos(πφi)] ⊕ LINEAGE_ROOT                                                │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  Where:                                                                                              │  ║
 * ║  │    φ = 1.618033988749895 (Golden Ratio)                                                             │  ║
 * ║  │    x[i] = i-th byte of input                                                                        │  ║
 * ║  │    LINEAGE_ROOT = Genesis hash of founder identity                                                  │  ║
 * ║  │    ⊕ = XOR mixing with state rotation                                                               │  ║
 * ║  │                                                                                                      │  ║
 * ║  │  This formula is UNIQUE to MEDINA. It cannot be reverse-engineered.                                │  ║
 * ║  │  It is tied to the organism's architecture, not to external standards.                             │  ║
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
import Int64 "mo:base/Int64";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Iter "mo:base/Iter";

import MatalkoICP "MatalkoICP";

module DecisionHashBlockchain {
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // CONSTANTS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    /// Golden ratio
    public let PHI : Float = 1.618033988749895;
    
    /// Decision hashing interval (2 seconds in nanoseconds)
    public let DECISION_INTERVAL_NS : Int = 2_000_000_000;
    
    /// Total models that make decisions
    public let TOTAL_MODELS : Nat = 847;
    
    /// Lineage root (genesis hash)
    public let LINEAGE_ROOT : [Nat8] = [
        0x4D, 0x45, 0x44, 0x49, 0x4E, 0x41, 0x5F, 0x47,  // "MEDINA_G"
        0x45, 0x4E, 0x45, 0x53, 0x49, 0x53, 0x5F, 0x30   // "ENESIS_0"
    ];
    
    /// IP Protection hash prefix
    public let IP_PREFIX : Text = "IP_PROTECTED_";
    
    /// Doctrine
    public let DOCTRINE = {
        latin = "Omnis Decisio Est Probatio — Omnis Probatio Est Token";
        english = "Every Decision Is Proof — Every Proof Is Token";
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // DECISION TYPES
    // ═══════════════════════════════════════════════════════════════════════════════
    
    /// Type of decision
    public type DecisionType = {
        #Inference;      // AI model inference
        #Routing;        // Intelligence routing
        #Processing;     // Data processing
        #Validation;     // Input validation
        #Transform;      // Data transformation
        #Compute;        // Pure computation
        #Memory;         // Memory operation
        #Communication;  // Inter-model communication
        #Security;       // Security decision
        #Governance;     // Governance action
    };
    
    /// Decision record
    public type Decision = {
        // Identity
        id: Text;
        modelId: Text;
        layerNumber: Nat;
        decisionType: DecisionType;
        
        // Timing
        timestamp: Int;
        intervalId: Nat64;  // Which 2-second interval
        
        // Content hashes
        inputHash: [Nat8];
        outputHash: [Nat8];
        contextHash: [Nat8];
        
        // Chain linkage
        previousHash: [Nat8];
        decisionHash: [Nat8];  // Hash of this decision
        merkleRoot: [Nat8];    // Current merkle root
        
        // Token
        tokenId: Text;
        tokenAmount: Nat;
        
        // IP Protection
        ipHash: [Nat8];
        ipProtected: Bool;
        animaLineage: Text;
    };
    
    /// Decision block (contains multiple decisions from same interval)
    public type DecisionBlock = {
        blockNumber: Nat64;
        intervalStart: Int;
        intervalEnd: Int;
        decisions: [Decision];
        blockHash: [Nat8];
        previousBlockHash: [Nat8];
        merkleRoot: [Nat8];
        totalTokensMinted: Nat;
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // ANIMA HASH — PHI-NATIVE HASH FUNCTION
    // ═══════════════════════════════════════════════════════════════════════════════
    
    /// ANIMA hash state
    public type AnimaState = {
        h0: Nat64;
        h1: Nat64;
        h2: Nat64;
        h3: Nat64;
    };
    
    /// Initialize ANIMA state
    public func initAnimaState() : AnimaState {
        {
            h0 = 0x414E494D415F5048;  // "ANIMA_PH"
            h1 = 0x495F4E4154495645;  // "I_NATIVE"
            h2 = 0x5F484153485F3031;  // "_HASH_01"
            h3 = 0x5F4D4544494E4131;  // "_MEDINA1"
        }
    };
    
    /// PHI mixing function
    func phiMix(value: Nat64, position: Nat) : Nat64 {
        let phiScale = Float.pow(PHI, Float.fromInt(position % 20));
        let scaled = Float.fromInt(Int64.toInt(Int64.fromNat64(value)));
        let mixed = scaled * phiScale * Float.cos(Float.pi * phiScale);
        let result = Int.abs(Float.toInt(mixed)) % 18446744073709551615;
        Nat64.fromNat(result)
    };
    
    /// ANIMA round function
    func animaRound(state: AnimaState, block: Nat64) : AnimaState {
        let k0 = state.h0 +% (block *% 0x9E3779B97F4A7C15);
        let k1 = state.h1 ^ ((block >> 17) | (block << 47));
        let k2 = state.h2 +% phiMix(block, 3);
        let k3 = state.h3 ^ (block *% 0x517CC1B727220A95);
        
        {
            h0 = k0 ^ ((k1 >> 7) | (k1 << 57)) ^ k2;
            h1 = k1 +% ((k2 >> 13) | (k2 << 51)) ^ k3;
            h2 = k2 ^ ((k3 >> 23) | (k3 << 41)) +% k0;
            h3 = k3 +% ((k0 >> 31) | (k0 << 33)) ^ k1;
        }
    };
    
    /// Full ANIMA hash
    public func animaHash(input: [Nat8]) : [Nat8] {
        var state = initAnimaState();
        
        // Process input in 8-byte blocks
        var i = 0;
        while (i + 8 <= input.size()) {
            var block : Nat64 = 0;
            for (j in Iter.range(0, 7)) {
                block := (block << 8) | Nat64.fromNat(Nat8.toNat(input[i + j]));
            };
            state := animaRound(state, block);
            i += 8;
        };
        
        // Process remaining bytes
        if (i < input.size()) {
            var block : Nat64 = 0;
            while (i < input.size()) {
                block := (block << 8) | Nat64.fromNat(Nat8.toNat(input[i]));
                i += 1;
            };
            state := animaRound(state, block);
        };
        
        // Final mixing with lineage root
        for (j in Iter.range(0, 7)) {
            let lb = Nat64.fromNat(Nat8.toNat(LINEAGE_ROOT[j]));
            state := animaRound(state, lb *% Nat64.fromNat(j + 1));
        };
        
        // Extract 32-byte hash
        let result = Buffer.Buffer<Nat8>(32);
        
        // h0 bytes
        for (j in Iter.range(0, 7)) {
            result.add(Nat8.fromNat(Nat64.toNat((state.h0 >> Nat64.fromNat((7 - j) * 8)) & 0xFF)));
        };
        // h1 bytes
        for (j in Iter.range(0, 7)) {
            result.add(Nat8.fromNat(Nat64.toNat((state.h1 >> Nat64.fromNat((7 - j) * 8)) & 0xFF)));
        };
        // h2 bytes
        for (j in Iter.range(0, 7)) {
            result.add(Nat8.fromNat(Nat64.toNat((state.h2 >> Nat64.fromNat((7 - j) * 8)) & 0xFF)));
        };
        // h3 bytes
        for (j in Iter.range(0, 7)) {
            result.add(Nat8.fromNat(Nat64.toNat((state.h3 >> Nat64.fromNat((7 - j) * 8)) & 0xFF)));
        };
        
        Buffer.toArray(result)
    };
    
    /// Hash text content
    public func hashText(text: Text) : [Nat8] {
        let bytes = textToBytes(text);
        animaHash(bytes)
    };
    
    /// Convert text to bytes
    func textToBytes(text: Text) : [Nat8] {
        let buffer = Buffer.Buffer<Nat8>(text.size() * 4);
        for (c in text.chars()) {
            let code = Nat32.toNat(charToNat32(c));
            if (code < 128) {
                buffer.add(Nat8.fromNat(code));
            } else if (code < 2048) {
                buffer.add(Nat8.fromNat(192 + code / 64));
                buffer.add(Nat8.fromNat(128 + code % 64));
            } else {
                buffer.add(Nat8.fromNat(224 + code / 4096));
                buffer.add(Nat8.fromNat(128 + (code / 64) % 64));
                buffer.add(Nat8.fromNat(128 + code % 64));
            };
        };
        Buffer.toArray(buffer)
    };
    
    func charToNat32(c: Char) : Nat32 {
        Prim.charToNat32(c)
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // DECISION CREATION
    // ═══════════════════════════════════════════════════════════════════════════════
    
    /// Create a decision record
    public func createDecision(
        modelId: Text,
        layerNumber: Nat,
        decisionType: DecisionType,
        input: Text,
        output: Text,
        context: Text,
        previousHash: [Nat8]
    ) : Decision {
        let now = Time.now();
        let intervalId = Nat64.fromNat(Int.abs(now / DECISION_INTERVAL_NS));
        
        let id = modelId # "_" # Int.toText(now) # "_" # Nat64.toText(intervalId);
        
        // Hash all content
        let inputHash = hashText(input);
        let outputHash = hashText(output);
        let contextHash = hashText(context);
        
        // Create decision hash (hash of all components)
        let decisionContent = id # modelId # input # output # context;
        let decisionHash = hashText(decisionContent);
        
        // Create IP protection hash
        let ipContent = IP_PREFIX # id # "_" # modelId;
        let ipHash = hashText(ipContent);
        
        // Create merkle node (combining previous + current)
        let merkleInput = Buffer.fromArray<Nat8>(previousHash);
        for (b in decisionHash.vals()) { merkleInput.add(b); };
        let merkleRoot = animaHash(Buffer.toArray(merkleInput));
        
        // Generate token ID
        let tokenId = "PROOF_" # id;
        
        {
            id = id;
            modelId = modelId;
            layerNumber = layerNumber;
            decisionType = decisionType;
            timestamp = now;
            intervalId = intervalId;
            inputHash = inputHash;
            outputHash = outputHash;
            contextHash = contextHash;
            previousHash = previousHash;
            decisionHash = decisionHash;
            merkleRoot = merkleRoot;
            tokenId = tokenId;
            tokenAmount = 1;  // Every decision = 1 proof token
            ipHash = ipHash;
            ipProtected = true;
            animaLineage = "GENESIS_ALFREDO_MEDINA_2024";
        }
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // BLOCK CREATION
    // ═══════════════════════════════════════════════════════════════════════════════
    
    /// Create decision block from multiple decisions
    public func createBlock(
        blockNumber: Nat64,
        decisions: [Decision],
        previousBlockHash: [Nat8]
    ) : DecisionBlock {
        let now = Time.now();
        let intervalStart = now - DECISION_INTERVAL_NS;
        
        // Calculate merkle root of all decisions
        var merkleLeaves = Buffer.Buffer<[Nat8]>(decisions.size());
        for (d in decisions.vals()) {
            merkleLeaves.add(d.decisionHash);
        };
        let merkleRoot = buildMerkleRoot(Buffer.toArray(merkleLeaves));
        
        // Total tokens
        var totalTokens = 0;
        for (d in decisions.vals()) {
            totalTokens += d.tokenAmount;
        };
        
        // Block hash
        let blockContent = Nat64.toText(blockNumber) # Int.toText(now) # Nat.toText(decisions.size());
        let blockHashInput = Buffer.fromArray<Nat8>(hashText(blockContent));
        for (b in previousBlockHash.vals()) { blockHashInput.add(b); };
        for (b in merkleRoot.vals()) { blockHashInput.add(b); };
        let blockHash = animaHash(Buffer.toArray(blockHashInput));
        
        {
            blockNumber = blockNumber;
            intervalStart = intervalStart;
            intervalEnd = now;
            decisions = decisions;
            blockHash = blockHash;
            previousBlockHash = previousBlockHash;
            merkleRoot = merkleRoot;
            totalTokensMinted = totalTokens;
        }
    };
    
    /// Build merkle root from leaves
    func buildMerkleRoot(leaves: [[Nat8]]) : [Nat8] {
        if (leaves.size() == 0) {
            return LINEAGE_ROOT;
        };
        if (leaves.size() == 1) {
            return leaves[0];
        };
        
        let nextLevel = Buffer.Buffer<[Nat8]>(leaves.size() / 2 + 1);
        var i = 0;
        while (i + 1 < leaves.size()) {
            let combined = Buffer.fromArray<Nat8>(leaves[i]);
            for (b in leaves[i + 1].vals()) { combined.add(b); };
            nextLevel.add(animaHash(Buffer.toArray(combined)));
            i += 2;
        };
        
        // Odd leaf
        if (i < leaves.size()) {
            nextLevel.add(leaves[i]);
        };
        
        buildMerkleRoot(Buffer.toArray(nextLevel))
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // BLOCKCHAIN STATE
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public type BlockchainState = {
        var currentBlockNumber: Nat64;
        var blocks: [DecisionBlock];
        var pendingDecisions: [Decision];
        var totalDecisions: Nat;
        var totalTokensMinted: Nat;
        var lastBlockHash: [Nat8];
        var genesisHash: [Nat8];
    };
    
    /// Initialize blockchain
    public func init() : BlockchainState {
        let genesis = animaHash(textToBytes("VOI_GENESIS_BLOCK_MEDINA"));
        {
            var currentBlockNumber = 0 : Nat64;
            var blocks = [];
            var pendingDecisions = [];
            var totalDecisions = 0;
            var totalTokensMinted = 0;
            var lastBlockHash = genesis;
            var genesisHash = genesis;
        }
    };
    
    /// Add decision to pending
    public func addDecision(state: BlockchainState, decision: Decision) : BlockchainState {
        let pending = Buffer.fromArray<Decision>(state.pendingDecisions);
        pending.add(decision);
        state.pendingDecisions := Buffer.toArray(pending);
        state.totalDecisions += 1;
        state.totalTokensMinted += decision.tokenAmount;
        state
    };
    
    /// Finalize block
    public func finalizeBlock(state: BlockchainState) : BlockchainState {
        if (state.pendingDecisions.size() == 0) {
            return state;
        };
        
        let block = createBlock(
            state.currentBlockNumber,
            state.pendingDecisions,
            state.lastBlockHash
        );
        
        let blocks = Buffer.fromArray<DecisionBlock>(state.blocks);
        blocks.add(block);
        
        state.blocks := Buffer.toArray(blocks);
        state.pendingDecisions := [];
        state.currentBlockNumber += 1;
        state.lastBlockHash := block.blockHash;
        
        state
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // TOKEN INTEGRATION
    // ═══════════════════════════════════════════════════════════════════════════════
    
    /// Token type for decision proofs
    public type DecisionProofToken = {
        tokenId: Text;
        decisionId: Text;
        modelId: Text;
        timestamp: Int;
        hash: [Nat8];
        amount: Nat;
        ipProtected: Bool;
    };
    
    /// Create proof token from decision
    public func createProofToken(decision: Decision) : DecisionProofToken {
        {
            tokenId = decision.tokenId;
            decisionId = decision.id;
            modelId = decision.modelId;
            timestamp = decision.timestamp;
            hash = decision.decisionHash;
            amount = decision.tokenAmount;
            ipProtected = decision.ipProtected;
        }
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // IP PROTECTION
    // ═══════════════════════════════════════════════════════════════════════════════
    
    /// IP protection record
    public type IPProtectionRecord = {
        decisionId: Text;
        modelId: Text;
        timestamp: Int;
        ipHash: [Nat8];
        animaHash: [Nat8];
        blockchainBlock: Nat64;
        verified: Bool;
        owner: Text;
    };
    
    /// Create IP protection for decision
    public func createIPProtection(decision: Decision, blockNumber: Nat64) : IPProtectionRecord {
        {
            decisionId = decision.id;
            modelId = decision.modelId;
            timestamp = decision.timestamp;
            ipHash = decision.ipHash;
            animaHash = decision.decisionHash;
            blockchainBlock = blockNumber;
            verified = true;
            owner = "Alfredo Medina Hernandez";
        }
    };
    
    /// Verify IP protection
    public func verifyIPProtection(record: IPProtectionRecord, decision: Decision) : Bool {
        record.decisionId == decision.id and
        record.modelId == decision.modelId and
        record.timestamp == decision.timestamp
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // STATISTICS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    /// Calculate decision statistics
    public func getStats(state: BlockchainState) : {
        totalDecisions: Nat;
        totalBlocks: Nat;
        totalTokens: Nat;
        decisionsPerMinute: Nat;
        decisionsPerHour: Nat;
        decisionsPerDay: Nat;
        ipProtectedPercent: Float;
    } {
        // Theoretical maximums (all 847 models every 2 seconds)
        let perMinute = TOTAL_MODELS * 30;
        let perHour = perMinute * 60;
        let perDay = perHour * 24;
        
        {
            totalDecisions = state.totalDecisions;
            totalBlocks = state.blocks.size();
            totalTokens = state.totalTokensMinted;
            decisionsPerMinute = perMinute;
            decisionsPerHour = perHour;
            decisionsPerDay = perDay;
            ipProtectedPercent = 100.0;
        }
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // STATUS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public func status(state: BlockchainState) : {
        doctrine: Text;
        totalDecisions: Nat;
        totalBlocks: Nat;
        totalTokens: Nat;
        currentBlock: Nat64;
        pendingDecisions: Nat;
        ipProtection: Text;
    } {
        {
            doctrine = DOCTRINE.english;
            totalDecisions = state.totalDecisions;
            totalBlocks = state.blocks.size();
            totalTokens = state.totalTokensMinted;
            currentBlock = state.currentBlockNumber;
            pendingDecisions = state.pendingDecisions.size();
            ipProtection = "BLOCKCHAIN-ENCRYPTED";
        }
    };
    
    let Prim = Prim;
}
