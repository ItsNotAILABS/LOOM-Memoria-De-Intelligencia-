/**
 * ╔═══════════════════════════════════════════════════════════════════════════╗
 * ║                                                                           ║
 * ║                         MEMORIA TOKEN (MEMO)                              ║
 * ║                         "Praemium Contributionis"                         ║
 * ║                                                                           ║
 * ║  CRYPTO REWARDS FOR FEEDBACK CONTRIBUTORS                                 ║
 * ║                                                                           ║
 * ║  "Qui dat responsum, recipit memoriam."                                  ║
 * ║  (Who gives a response, receives memory.)                                ║
 * ║                                                                           ║
 * ║  TOKEN ECONOMICS:                                                         ║
 * ║  • Symbol: MEMO                                                           ║
 * ║  • Decimals: 8                                                            ║
 * ║  • Supply: Infinite (minted per feedback)                                ║
 * ║  • Distribution: Based on feedback grade                                  ║
 * ║                                                                           ║
 * ║  REWARD STRUCTURE:                                                        ║
 * ║  ┌─────────────────────────────────────────────────────────────────────┐ ║
 * ║  │  FEEDBACK GRADE              │  REWARD (MEMO)                       │ ║
 * ║  │  ─────────────────────────────────────────────────────────────────  │ ║
 * ║  │  Any feedback                │  100 MEMO (base)                     │ ║
 * ║  │  + Quality multiplier        │  × (grade × 10)                      │ ║
 * ║  │  + Novelty bonus             │  + 50 MEMO if novelty > 0.8          │ ║
 * ║  │  + Research trigger bonus    │  + 100 MEMO if triggers research     │ ║
 * ║  │  + Organism update bonus     │  + 200 MEMO if updates organism      │ ║
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
import Nat64 "mo:base/Nat64";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Time "mo:base/Time";

import MatalkoICP "MatalkoICP";
import SemperMemoria "SemperMemoria";

module {
    // ================================================================== //
    // TOKEN CONSTANTS                                                      //
    // ================================================================== //
    
    /// Token name
    public let TOKEN_NAME : Text = "Memoria Token";
    
    /// Token symbol
    public let TOKEN_SYMBOL : Text = "MEMO";
    
    /// Token decimals
    public let TOKEN_DECIMALS : Nat = 8;
    
    /// Token doctrine - Latin
    public let TOKEN_DOCTRINE : Text = "Qui dat responsum, recipit memoriam.";
    
    /// Token doctrine - English
    public let TOKEN_DOCTRINE_EN : Text = "Who gives a response, receives memory.";
    
    /// Golden ratio for calculations
    public let PHI : Float = MatalkoICP.PHI;
    
    // ================================================================== //
    // REWARD CONSTANTS                                                     //
    // ================================================================== //
    
    /// Base reward for any feedback (in smallest units)
    public let BASE_REWARD : Nat = 100_00000000; // 100 MEMO
    
    /// Novelty bonus threshold
    public let NOVELTY_THRESHOLD : Float = 0.8;
    
    /// Novelty bonus amount
    public let NOVELTY_BONUS : Nat = 50_00000000; // 50 MEMO
    
    /// Research trigger bonus
    public let RESEARCH_BONUS : Nat = 100_00000000; // 100 MEMO
    
    /// Organism update bonus
    public let ORGANISM_UPDATE_BONUS : Nat = 200_00000000; // 200 MEMO
    
    /// Maximum quality multiplier
    public let MAX_QUALITY_MULTIPLIER : Nat = 10;
    
    // ================================================================== //
    // TOKEN TYPES                                                          //
    // ================================================================== //
    
    /// Token balance entry
    public type Balance = {
        owner: Text;           // User hash (anonymized)
        amount: Nat;           // Balance in smallest units
        locked: Nat;           // Locked/vesting amount
        last_updated: Int;
    };
    
    /// Token transfer
    public type Transfer = {
        transfer_id: Text;
        from: Text;
        to: Text;
        amount: Nat;
        memo: ?Text;
        timestamp: Int;
        status: TransferStatus;
    };
    
    /// Transfer status
    public type TransferStatus = {
        #Pending;
        #Completed;
        #Failed;
        #Cancelled;
    };
    
    /// Reward issuance record
    public type RewardIssuance = {
        issuance_id: Text;
        recipient: Text;       // User hash
        feedback_id: Text;     // Related feedback
        
        // Breakdown
        base_amount: Nat;
        quality_bonus: Nat;
        novelty_bonus: Nat;
        research_bonus: Nat;
        organism_bonus: Nat;
        total_amount: Nat;
        
        // Status
        timestamp: Int;
        issued: Bool;
        tx_hash: ?Text;
    };
    
    /// Token supply info
    public type SupplyInfo = {
        total_minted: Nat;
        total_burned: Nat;
        circulating: Nat;
        locked: Nat;
        
        // Stats
        holders_count: Nat;
        transfers_count: Nat;
        rewards_issued_count: Nat;
        
        // Timestamps
        genesis_time: Int;
        last_mint: Int;
        last_burn: ?Int;
    };
    
    // ================================================================== //
    // REWARD CALCULATION                                                   //
    // ================================================================== //
    
    /// Calculate total reward for feedback
    public func calculateReward(
        grade: SemperMemoria.FeedbackGrade
    ) : RewardBreakdown {
        // Base reward
        let base = BASE_REWARD;
        
        // Quality bonus: base × (grade × 10)
        let quality_multiplier = Float.toInt(grade.overall * Float.fromInt(MAX_QUALITY_MULTIPLIER));
        let quality_bonus = base * Int.abs(quality_multiplier) / MAX_QUALITY_MULTIPLIER;
        
        // Novelty bonus
        let novelty_bonus = if (grade.novelty >= NOVELTY_THRESHOLD) {
            NOVELTY_BONUS
        } else { 0 };
        
        // Research trigger bonus
        let research_bonus = if (grade.new_model_research) {
            RESEARCH_BONUS
        } else { 0 };
        
        // Organism update bonus
        let organism_bonus = if (grade.organism_update) {
            ORGANISM_UPDATE_BONUS
        } else { 0 };
        
        // Total
        let total = base + quality_bonus + novelty_bonus + research_bonus + organism_bonus;
        
        {
            base_amount = base;
            quality_bonus = quality_bonus;
            novelty_bonus = novelty_bonus;
            research_bonus = research_bonus;
            organism_bonus = organism_bonus;
            total_amount = total;
        }
    };
    
    /// Reward breakdown
    public type RewardBreakdown = {
        base_amount: Nat;
        quality_bonus: Nat;
        novelty_bonus: Nat;
        research_bonus: Nat;
        organism_bonus: Nat;
        total_amount: Nat;
    };
    
    // ================================================================== //
    // REWARD ISSUANCE                                                      //
    // ================================================================== //
    
    /// Create reward issuance record
    public func createRewardIssuance(
        recipient: Text,
        feedback_id: Text,
        breakdown: RewardBreakdown
    ) : RewardIssuance {
        let issuance_id = "REWARD-" # feedback_id;
        
        {
            issuance_id = issuance_id;
            recipient = recipient;
            feedback_id = feedback_id;
            
            base_amount = breakdown.base_amount;
            quality_bonus = breakdown.quality_bonus;
            novelty_bonus = breakdown.novelty_bonus;
            research_bonus = breakdown.research_bonus;
            organism_bonus = breakdown.organism_bonus;
            total_amount = breakdown.total_amount;
            
            timestamp = Time.now();
            issued = false;
            tx_hash = null;
        }
    };
    
    /// Mark issuance as complete
    public func completeIssuance(
        issuance: RewardIssuance,
        tx_hash: Text
    ) : RewardIssuance {
        {
            issuance with
            issued = true;
            tx_hash = ?tx_hash
        }
    };
    
    // ================================================================== //
    // TOKEN FORMATTING                                                     //
    // ================================================================== //
    
    /// Format amount with decimals (e.g., 100_00000000 -> "100.00000000")
    public func formatAmount(amount: Nat) : Text {
        let integer_part = amount / (10 ** TOKEN_DECIMALS);
        let decimal_part = amount % (10 ** TOKEN_DECIMALS);
        
        Nat.toText(integer_part) # "." # padZeros(decimal_part, TOKEN_DECIMALS)
    };
    
    /// Format amount human-readable (e.g., 100_00000000 -> "100 MEMO")
    public func formatAmountHuman(amount: Nat) : Text {
        let integer_part = amount / (10 ** TOKEN_DECIMALS);
        Nat.toText(integer_part) # " " # TOKEN_SYMBOL
    };
    
    /// Pad with leading zeros
    func padZeros(n: Nat, length: Nat) : Text {
        var result = Nat.toText(n);
        while (Text.size(result) < length) {
            result := "0" # result;
        };
        result
    };
    
    // ================================================================== //
    // TOKEN INFO                                                           //
    // ================================================================== //
    
    /// Get token metadata
    public func getTokenMetadata() : TokenMetadata {
        {
            name = TOKEN_NAME;
            symbol = TOKEN_SYMBOL;
            decimals = TOKEN_DECIMALS;
            
            doctrine_latin = TOKEN_DOCTRINE;
            doctrine_english = TOKEN_DOCTRINE_EN;
            
            reward_structure = getRewardStructure();
        }
    };
    
    /// Token metadata
    public type TokenMetadata = {
        name: Text;
        symbol: Text;
        decimals: Nat;
        doctrine_latin: Text;
        doctrine_english: Text;
        reward_structure: Text;
    };
    
    /// Get reward structure description
    func getRewardStructure() : Text {
        "Base: " # formatAmountHuman(BASE_REWARD) # " | " #
        "Novelty (>" # Float.toText(NOVELTY_THRESHOLD) # "): +" # formatAmountHuman(NOVELTY_BONUS) # " | " #
        "Research: +" # formatAmountHuman(RESEARCH_BONUS) # " | " #
        "Organism Update: +" # formatAmountHuman(ORGANISM_UPDATE_BONUS)
    };
    
    // ================================================================== //
    // SUPPLY MANAGEMENT                                                    //
    // ================================================================== //
    
    /// Initialize supply info
    public func initSupplyInfo() : SupplyInfo {
        {
            total_minted = 0;
            total_burned = 0;
            circulating = 0;
            locked = 0;
            
            holders_count = 0;
            transfers_count = 0;
            rewards_issued_count = 0;
            
            genesis_time = Time.now();
            last_mint = Time.now();
            last_burn = null;
        }
    };
    
    /// Update supply after mint
    public func recordMint(supply: SupplyInfo, amount: Nat) : SupplyInfo {
        {
            supply with
            total_minted = supply.total_minted + amount;
            circulating = supply.circulating + amount;
            last_mint = Time.now();
            rewards_issued_count = supply.rewards_issued_count + 1
        }
    };
    
    /// Update supply after burn
    public func recordBurn(supply: SupplyInfo, amount: Nat) : SupplyInfo {
        {
            supply with
            total_burned = supply.total_burned + amount;
            circulating = if (supply.circulating >= amount) { supply.circulating - amount } else { 0 };
            last_burn = ?Time.now()
        }
    };
}
