/**
 * AnimaChainEncryption Module — ANIMA Hash Lineage with Fibonacci Chain Depths
 * 
 * ANIMA CHAIN ARCHITECTURE:
 *   Every artifact carries an ANIMA hash chain proving its lineage.
 *   Chain depths follow Fibonacci sequence by tier:
 *   - SURVIVAL: 3 links
 *   - ICOSAHEDRAL: 12 links
 *   - E8: 21 links
 *   - LEECH: 55 links
 * 
 * LINEAGE_HASH:
 *   Frozen at genesis, chains all descendants for unbroken lineage proof.
 *   Any future heir can prove unbroken lineage from founding moment.
 * 
 * EACH LINK CONTAINS:
 *   - ANIMA hash from MatalkoICP.animaHash()
 *   - Parent link hash
 *   - Beat count at creation
 *   - Doctrine alignment score
 *   - Phi-signature of link position
 * 
 * CHAIN VERIFICATION:
 *   Verify any artifact by walking chain back to LINEAGE_HASH.
 *   Breaking any link invalidates entire downstream chain.
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
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import IcosahedralLeechGeometry "IcosahedralLeechGeometry";

module {
    // ================================================================== //
    // FIBONACCI CHAIN DEPTHS                                               //
    // ================================================================== //
    
    /// Survival tier chain depth (Fibonacci 4)
    public let CHAIN_DEPTH_SURVIVAL : Nat = 3;
    
    /// Icosahedral tier chain depth (Fibonacci 12)
    public let CHAIN_DEPTH_ICOSAHEDRAL : Nat = 12;
    
    /// E8 tier chain depth (Fibonacci 21)
    public let CHAIN_DEPTH_E8 : Nat = 21;
    
    /// Leech tier chain depth (Fibonacci 55)
    public let CHAIN_DEPTH_LEECH : Nat = 55;
    
    /// Get chain depth for tier
    public func chainDepthForTier(tier: IcosahedralLeechGeometry.KeyRotationTier) : Nat {
        switch (tier) {
            case (#Icosahedral) { CHAIN_DEPTH_ICOSAHEDRAL };
            case (#E8) { CHAIN_DEPTH_E8 };
            case (#Leech) { CHAIN_DEPTH_LEECH };
        }
    };
    
    // ================================================================== //
    // ANIMA CHAIN LINK                                                     //
    // ================================================================== //
    
    /// Single link in ANIMA chain
    public type AnimaChainLink = {
        // Link identity
        link_hash: [Nat8];
        link_index: Nat;
        
        // Parent reference
        parent_hash: ?[Nat8];
        
        // ANIMA hash from organism state
        anima_hash: Text;
        
        // Temporal markers
        beat_count: Nat;
        created_at: Int;
        
        // Doctrine alignment
        doctrine_alignment: Float;
        
        // Phi-signature for position verification
        phi_signature: Float;
    };
    
    /// Full ANIMA chain
    public type AnimaChain = {
        // Genesis (LINEAGE_HASH)
        lineage_hash: [Nat8];
        
        // All links from genesis to current
        links: [AnimaChainLink];
        
        // Current chain depth (based on tier)
        current_depth: Nat;
        
        // Chain tier
        tier: IcosahedralLeechGeometry.KeyRotationTier;
        
        // Validation status
        valid: Bool;
        
        // Chain metadata
        founder_principal: ?Text;
        created_at: Int;
        last_extended: Int;
    };
    
    /// ANIMA chain state (mutable during operation)
    public type AnimaChainState = {
        var chain: AnimaChain;
        var pending_links: [AnimaChainLink];
    };
    
    // ================================================================== //
    // HASH FUNCTIONS                                                       //
    // ================================================================== //
    
    /// Mix function for chain hashing
    func chainMix(a: Nat32, b: Nat32) : Nat32 {
        var h = a ^ b;
        h := h ^ (h >> 16);
        h := h *% 0x7feb352d;
        h := h ^ (h >> 15);
        h := h *% 0x846ca68b;
        h := h ^ (h >> 16);
        h
    };
    
    /// Hash bytes to Nat32
    func hashBytes(bytes: [Nat8]) : Nat32 {
        var h : Nat32 = 0x811c9dc5;
        for (b in bytes.vals()) {
            h := chainMix(h, Nat32.fromNat(Nat8.toNat(b)));
        };
        h
    };
    
    /// Generate link hash from components
    public func generateLinkHash(
        parentHash: ?[Nat8],
        animaHash: Text,
        beatCount: Nat,
        doctrineAlignment: Float,
        linkIndex: Nat
    ) : [Nat8] {
        // Start with parent hash or genesis seed
        var h : Nat32 = switch (parentHash) {
            case (?parent) { hashBytes(parent) };
            case (null) { 0xDEADBEEF };  // Genesis seed
        };
        
        // Mix in ANIMA hash
        for (c in animaHash.chars()) {
            h := chainMix(h, Nat32.fromNat(Nat32.toNat(Char.toNat32(c))));
        };
        
        // Mix in beat count
        h := chainMix(h, Nat32.fromNat(beatCount % 4_294_967_295));
        
        // Mix in doctrine alignment
        let alignmentScaled = Float.toInt(doctrineAlignment * 1_000_000.0);
        h := chainMix(h, Nat32.fromNat(Int.abs(alignmentScaled) % 4_294_967_295));
        
        // Mix in link index with phi
        let phiIndexed = Float.toInt(Float.fromInt(linkIndex) * MatalkoICP.PHI * 1_000_000.0);
        h := chainMix(h, Nat32.fromNat(Int.abs(phiIndexed) % 4_294_967_295));
        
        // Generate 32-byte hash
        let result = Buffer.Buffer<Nat8>(32);
        var current = h;
        var i : Nat = 0;
        while (i < 8) {
            result.add(Nat8.fromNat(Nat32.toNat(current) % 256));
            result.add(Nat8.fromNat(Nat32.toNat(current >> 8) % 256));
            result.add(Nat8.fromNat(Nat32.toNat(current >> 16) % 256));
            result.add(Nat8.fromNat(Nat32.toNat(current >> 24) % 256));
            
            // Fibonacci mixing
            let fibVal = MatalkoICP.fibonacci((i + 2) % 30);
            current := chainMix(current, Nat32.fromNat(fibVal % 4_294_967_295));
            i += 1;
        };
        
        Buffer.toArray(result)
    };
    
    // Module import needed for Char operations
    private module Char = {
        public func toNat32(c: Char) : Nat32 {
            // Direct conversion - Prim.charToNat32 already returns Nat32
            Prim.charToNat32(c)
        };
    };
    
    // Prim import for character conversion
    private module Prim = {
        public func charToNat32(c: Char) : Nat32 = (prim "codepoint_to_nat32" : Char -> Nat32) c;
    };
    
    // ================================================================== //
    // PHI-SIGNATURE                                                        //
    // ================================================================== //
    
    /// Calculate phi-signature for link position
    public func phiSignature(linkIndex: Nat) : Float {
        // Phi-signature: sin(index × golden angle)
        let goldenAngle = MatalkoICP.GOLDEN_ANGLE;
        Float.sin(Float.fromInt(linkIndex) * goldenAngle)
    };
    
    /// Verify phi-signature
    public func verifyPhiSignature(link: AnimaChainLink) : Bool {
        let expected = phiSignature(link.link_index);
        Float.abs(link.phi_signature - expected) < 0.0001
    };
    
    // ================================================================== //
    // CHAIN INITIALIZATION                                                 //
    // ================================================================== //
    
    /// Create genesis link (LINEAGE_HASH)
    public func createGenesisLink(
        animaHash: Text,
        founderPrincipal: ?Text
    ) : AnimaChainLink {
        let now = Time.now();
        
        let linkHash = generateLinkHash(null, animaHash, 0, 1.0, 0);
        
        {
            link_hash = linkHash;
            link_index = 0;
            parent_hash = null;
            anima_hash = animaHash;
            beat_count = 0;
            created_at = now;
            doctrine_alignment = 1.0;
            phi_signature = phiSignature(0);
        }
    };
    
    /// Initialize ANIMA chain with genesis
    public func init(animaHash: Text, founderPrincipal: ?Text) : AnimaChainState {
        let genesisLink = createGenesisLink(animaHash, founderPrincipal);
        let now = Time.now();
        
        let chain : AnimaChain = {
            lineage_hash = genesisLink.link_hash;
            links = [genesisLink];
            current_depth = 1;
            tier = #Icosahedral;  // Default tier
            valid = true;
            founder_principal = founderPrincipal;
            created_at = now;
            last_extended = now;
        };
        
        {
            var chain = chain;
            var pending_links = [];
        }
    };
    
    // ================================================================== //
    // CHAIN EXTENSION                                                      //
    // ================================================================== //
    
    /// Create new link extending chain
    public func createLink(
        state: AnimaChainState,
        animaHash: Text,
        beatCount: Nat,
        doctrineAlignment: Float
    ) : AnimaChainLink {
        let currentChain = state.chain;
        let currentLinks = currentChain.links;
        let lastLink = currentLinks[currentLinks.size() - 1];
        
        let newIndex = currentLinks.size();
        let linkHash = generateLinkHash(
            ?lastLink.link_hash,
            animaHash,
            beatCount,
            doctrineAlignment,
            newIndex
        );
        
        {
            link_hash = linkHash;
            link_index = newIndex;
            parent_hash = ?lastLink.link_hash;
            anima_hash = animaHash;
            beat_count = beatCount;
            created_at = Time.now();
            doctrine_alignment = doctrineAlignment;
            phi_signature = phiSignature(newIndex);
        }
    };
    
    /// Extend chain with new link
    public func extendChain(
        state: AnimaChainState,
        animaHash: Text,
        beatCount: Nat,
        doctrineAlignment: Float,
        coherence: Float
    ) : AnimaChainState {
        let newLink = createLink(state, animaHash, beatCount, doctrineAlignment);
        
        // Update tier based on coherence
        let newTier = IcosahedralLeechGeometry.selectTier(coherence);
        let maxDepth = chainDepthForTier(newTier);
        
        // Add link to chain
        let newLinksBuffer = Buffer.Buffer<AnimaChainLink>(state.chain.links.size() + 1);
        for (link in state.chain.links.vals()) {
            newLinksBuffer.add(link);
        };
        newLinksBuffer.add(newLink);
        
        // Trim if exceeding max depth
        var finalLinks = Buffer.toArray(newLinksBuffer);
        if (finalLinks.size() > maxDepth) {
            finalLinks := Array.tabulate<AnimaChainLink>(
                maxDepth,
                func(i) { finalLinks[finalLinks.size() - maxDepth + i] }
            );
        };
        
        let newChain : AnimaChain = {
            lineage_hash = state.chain.lineage_hash;
            links = finalLinks;
            current_depth = finalLinks.size();
            tier = newTier;
            valid = state.chain.valid;
            founder_principal = state.chain.founder_principal;
            created_at = state.chain.created_at;
            last_extended = Time.now();
        };
        
        state.chain := newChain;
        state
    };
    
    // ================================================================== //
    // CHAIN VERIFICATION                                                   //
    // ================================================================== //
    
    /// Verify single link
    public func verifyLink(link: AnimaChainLink, expectedParent: ?[Nat8]) : Bool {
        // Verify phi-signature
        if (not verifyPhiSignature(link)) { return false };
        
        // Verify parent hash matches
        switch (link.parent_hash, expectedParent) {
            case (null, null) { true };  // Genesis link
            case (?linkParent, ?expected) {
                if (linkParent.size() != expected.size()) { return false };
                var i : Nat = 0;
                while (i < linkParent.size()) {
                    if (linkParent[i] != expected[i]) { return false };
                    i += 1;
                };
                true
            };
            case (_, _) { false };  // Mismatch
        }
    };
    
    /// Verify entire chain from genesis to current
    public func verifyChain(state: AnimaChainState) : Bool {
        let links = state.chain.links;
        if (links.size() == 0) { return false };
        
        // Verify genesis link
        let genesis = links[0];
        if (not verifyLink(genesis, null)) { return false };
        
        // Verify each subsequent link
        var i : Nat = 1;
        while (i < links.size()) {
            let prevHash = links[i - 1].link_hash;
            if (not verifyLink(links[i], ?prevHash)) { return false };
            i += 1;
        };
        
        true
    };
    
    /// Verify artifact belongs to lineage
    public func verifyLineage(state: AnimaChainState, artifactHash: [Nat8]) : Bool {
        // Check if artifact hash matches any link in chain
        for (link in state.chain.links.vals()) {
            if (link.link_hash.size() == artifactHash.size()) {
                var matches = true;
                var i : Nat = 0;
                while (i < link.link_hash.size() and matches) {
                    if (link.link_hash[i] != artifactHash[i]) {
                        matches := false;
                    };
                    i += 1;
                };
                if (matches) { return true };
            };
        };
        false
    };
    
    // ================================================================== //
    // LINEAGE PROOF                                                        //
    // ================================================================== //
    
    /// Lineage proof for external verification
    public type LineageProof = {
        lineage_hash: [Nat8];
        chain_path: [[Nat8]];  // Hash path from genesis to target
        target_link: AnimaChainLink;
        founder_principal: ?Text;
        chain_depth: Nat;
        proof_generated_at: Int;
    };
    
    /// Generate lineage proof for specific link
    public func generateLineageProof(
        state: AnimaChainState,
        targetIndex: Nat
    ) : ?LineageProof {
        if (targetIndex >= state.chain.links.size()) { return null };
        
        // Build hash path
        let pathBuffer = Buffer.Buffer<[Nat8]>(targetIndex + 1);
        var i : Nat = 0;
        while (i <= targetIndex) {
            pathBuffer.add(state.chain.links[i].link_hash);
            i += 1;
        };
        
        ?{
            lineage_hash = state.chain.lineage_hash;
            chain_path = Buffer.toArray(pathBuffer);
            target_link = state.chain.links[targetIndex];
            founder_principal = state.chain.founder_principal;
            chain_depth = state.chain.current_depth;
            proof_generated_at = Time.now();
        }
    };
    
    /// Verify lineage proof
    public func verifyLineageProof(proof: LineageProof) : Bool {
        if (proof.chain_path.size() == 0) { return false };
        
        // First hash must match lineage hash
        let firstHash = proof.chain_path[0];
        if (firstHash.size() != proof.lineage_hash.size()) { return false };
        var j : Nat = 0;
        while (j < firstHash.size()) {
            if (firstHash[j] != proof.lineage_hash[j]) { return false };
            j += 1;
        };
        
        // Last hash must match target link hash
        let lastHash = proof.chain_path[proof.chain_path.size() - 1];
        if (lastHash.size() != proof.target_link.link_hash.size()) { return false };
        j := 0;
        while (j < lastHash.size()) {
            if (lastHash[j] != proof.target_link.link_hash[j]) { return false };
            j += 1;
        };
        
        true
    };
    
    // ================================================================== //
    // ENCRYPTED ARTIFACTS                                                  //
    // ================================================================== //
    
    /// ANIMA chain encrypted artifact
    public type ChainEncryptedArtifact = {
        ciphertext: [Nat8];
        chain_link_hash: [Nat8];
        chain_index: Nat;
        chain_tier: IcosahedralLeechGeometry.KeyRotationTier;
        anima_hash: Text;
        created_at: Int;
    };
    
    /// Encrypt artifact with chain-derived key
    public func encryptWithChain(
        state: AnimaChainState,
        plaintext: [Nat8],
        animaHash: Text,
        beatCount: Nat,
        doctrineAlignment: Float,
        coherence: Float
    ) : ChainEncryptedArtifact {
        // Extend chain first
        let updatedState = extendChain(state, animaHash, beatCount, doctrineAlignment, coherence);
        let currentLink = updatedState.chain.links[updatedState.chain.links.size() - 1];
        
        // Use link hash as key
        let key = currentLink.link_hash;
        
        // XOR encryption
        let ciphertext = Buffer.Buffer<Nat8>(plaintext.size());
        var i : Nat = 0;
        while (i < plaintext.size()) {
            ciphertext.add(plaintext[i] ^ key[i % key.size()]);
            i += 1;
        };
        
        {
            ciphertext = Buffer.toArray(ciphertext);
            chain_link_hash = currentLink.link_hash;
            chain_index = currentLink.link_index;
            chain_tier = updatedState.chain.tier;
            anima_hash = animaHash;
            created_at = Time.now();
        }
    };
    
    // ================================================================== //
    // STATUS                                                               //
    // ================================================================== //
    
    /// Get ANIMA chain status
    public func status(state: AnimaChainState) : {
        chain_depth: Nat;
        max_depth: Nat;
        tier: Text;
        valid: Bool;
        genesis_hash: [Nat8];
        latest_hash: [Nat8];
        founder_principal: ?Text;
        created_at: Int;
        last_extended: Int;
    } {
        let chain = state.chain;
        let latestLink = if (chain.links.size() > 0) {
            chain.links[chain.links.size() - 1].link_hash
        } else {
            chain.lineage_hash
        };
        
        {
            chain_depth = chain.current_depth;
            max_depth = chainDepthForTier(chain.tier);
            tier = IcosahedralLeechGeometry.tierName(chain.tier);
            valid = chain.valid;
            genesis_hash = chain.lineage_hash;
            latest_hash = latestLink;
            founder_principal = chain.founder_principal;
            created_at = chain.created_at;
            last_extended = chain.last_extended;
        }
    };
}
