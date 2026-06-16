/**
 * SovereignContracts Module — 44 Contract Types with Sovereign Encryption
 * 
 * EVERY CONTRACT IS A MODEL. EVERY MODEL IS BUILT.
 * 
 * CONTRACT CATEGORIES:
 *   - Founder Contracts: Sovereignty, Succession, Lineage
 *   - Enterprise Contracts: Onboarding, AI Absorption, Campaign
 *   - IP Contracts: Attribution, License, Royalty
 *   - Agent Contracts: Return, Authentication, Task
 *   - Law Contracts: Enforcement, Governance, Self-Modification
 *   - Session Contracts: Capture, Memory, Freeze
 *   - CSR Contracts: Node, Network, Defense
 * 
 * EVERY CONTRACT:
 *   - Has encrypted schema
 *   - Signs via threshold BLS or IBE
 *   - Writes to designated ledger
 *   - Carries ANIMA hash lineage
 *   - Includes founder attribution
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
import VetKeysIntegration "VetKeysIntegration";

module {
    // ================================================================== //
    // CONTRACT TYPES ENUMERATION                                           //
    // ================================================================== //
    
    /// All 44 sovereign contract types
    public type ContractType = {
        // Founder Contracts (1-10)
        #FounderSovereignty;
        #FounderSuccession;
        #FounderLineage;
        #FounderFreeze;
        #FounderBiometric;
        #FounderAsset;
        #FounderRoyalty;
        #FounderSession;
        #FounderDevice;
        #FounderEvolution;
        
        // Enterprise Contracts (11-20)
        #EnterpriseOnboarding;
        #EnterpriseAIAbsorption;
        #EnterpriseArbitration;
        #EnterpriseCampaign;
        #EnterpriseConsent;
        #EnterpriseDataAccess;
        #EnterpriseIPLicense;
        #EnterpriseService;
        #EnterpriseRoyalty;
        #EnterpriseGovernance;
        
        // IP Contracts (21-26)
        #IPAttribution;
        #IPLicense;
        #IPTransfer;
        #IPRoyaltyRoute;
        #IPCrossChain;
        #IPArtifact;
        
        // Agent Contracts (27-32)
        #AgentReturn;
        #AgentAuthentication;
        #AgentTask;
        #AgentCredential;
        #AgentMessaging;
        #AgentSwarm;
        
        // Law Contracts (33-38)
        #LawEnforcement;
        #LawGovernance;
        #LawSelfModification;
        #LawDoctrine;
        #LawViolation;
        #LawAmendment;
        
        // Session/Memory Contracts (39-42)
        #SessionCapture;
        #MemoryFormation;
        #MemoryRecall;
        #MemoryConsolidation;
        
        // CSR/Network Contracts (43-44)
        #CSRNode;
        #CSRDefense;
    };
    
    /// Get contract type name
    public func contractTypeName(contractType: ContractType) : Text {
        switch (contractType) {
            case (#FounderSovereignty) { "FOUNDER_SOVEREIGNTY" };
            case (#FounderSuccession) { "FOUNDER_SUCCESSION" };
            case (#FounderLineage) { "FOUNDER_LINEAGE" };
            case (#FounderFreeze) { "FOUNDER_FREEZE" };
            case (#FounderBiometric) { "FOUNDER_BIOMETRIC" };
            case (#FounderAsset) { "FOUNDER_ASSET" };
            case (#FounderRoyalty) { "FOUNDER_ROYALTY" };
            case (#FounderSession) { "FOUNDER_SESSION" };
            case (#FounderDevice) { "FOUNDER_DEVICE" };
            case (#FounderEvolution) { "FOUNDER_EVOLUTION" };
            case (#EnterpriseOnboarding) { "ENTERPRISE_ONBOARDING" };
            case (#EnterpriseAIAbsorption) { "ENTERPRISE_AI_ABSORPTION" };
            case (#EnterpriseArbitration) { "ENTERPRISE_ARBITRATION" };
            case (#EnterpriseCampaign) { "ENTERPRISE_CAMPAIGN" };
            case (#EnterpriseConsent) { "ENTERPRISE_CONSENT" };
            case (#EnterpriseDataAccess) { "ENTERPRISE_DATA_ACCESS" };
            case (#EnterpriseIPLicense) { "ENTERPRISE_IP_LICENSE" };
            case (#EnterpriseService) { "ENTERPRISE_SERVICE" };
            case (#EnterpriseRoyalty) { "ENTERPRISE_ROYALTY" };
            case (#EnterpriseGovernance) { "ENTERPRISE_GOVERNANCE" };
            case (#IPAttribution) { "IP_ATTRIBUTION" };
            case (#IPLicense) { "IP_LICENSE" };
            case (#IPTransfer) { "IP_TRANSFER" };
            case (#IPRoyaltyRoute) { "IP_ROYALTY_ROUTE" };
            case (#IPCrossChain) { "IP_CROSS_CHAIN" };
            case (#IPArtifact) { "IP_ARTIFACT" };
            case (#AgentReturn) { "AGENT_RETURN" };
            case (#AgentAuthentication) { "AGENT_AUTHENTICATION" };
            case (#AgentTask) { "AGENT_TASK" };
            case (#AgentCredential) { "AGENT_CREDENTIAL" };
            case (#AgentMessaging) { "AGENT_MESSAGING" };
            case (#AgentSwarm) { "AGENT_SWARM" };
            case (#LawEnforcement) { "LAW_ENFORCEMENT" };
            case (#LawGovernance) { "LAW_GOVERNANCE" };
            case (#LawSelfModification) { "LAW_SELF_MODIFICATION" };
            case (#LawDoctrine) { "LAW_DOCTRINE" };
            case (#LawViolation) { "LAW_VIOLATION" };
            case (#LawAmendment) { "LAW_AMENDMENT" };
            case (#SessionCapture) { "SESSION_CAPTURE" };
            case (#MemoryFormation) { "MEMORY_FORMATION" };
            case (#MemoryRecall) { "MEMORY_RECALL" };
            case (#MemoryConsolidation) { "MEMORY_CONSOLIDATION" };
            case (#CSRNode) { "CSR_NODE" };
            case (#CSRDefense) { "CSR_DEFENSE" };
        }
    };
    
    // ================================================================== //
    // CONTRACT STATUS                                                      //
    // ================================================================== //
    
    /// Contract execution status
    public type ContractStatus = {
        #Draft;
        #PendingSignature;
        #Active;
        #Executed;
        #Terminated;
        #Frozen;
        #Violated;
    };
    
    /// Get status name
    public func statusName(status: ContractStatus) : Text {
        switch (status) {
            case (#Draft) { "DRAFT" };
            case (#PendingSignature) { "PENDING_SIGNATURE" };
            case (#Active) { "ACTIVE" };
            case (#Executed) { "EXECUTED" };
            case (#Terminated) { "TERMINATED" };
            case (#Frozen) { "FROZEN" };
            case (#Violated) { "VIOLATED" };
        }
    };
    
    // ================================================================== //
    // SIGNATURE TYPES                                                      //
    // ================================================================== //
    
    /// Signature on contract
    public type ContractSignature = {
        signer: Principal;
        signer_role: Text;
        signature_type: SignatureType;
        signature_data: [Nat8];
        signed_at: Int;
    };
    
    /// Types of signatures supported
    public type SignatureType = {
        #ThresholdBLS;
        #IBE;
        #PhiLattice;
        #ANIMA;
    };
    
    // ================================================================== //
    // BASE CONTRACT                                                        //
    // ================================================================== //
    
    /// Base sovereign contract (all 44 types extend this)
    public type SovereignContract = {
        // Identity
        contract_id: Text;
        contract_type: ContractType;
        
        // Parties
        creator: Principal;
        parties: [Principal];
        
        // Content (encrypted)
        encrypted_terms: [Nat8];
        terms_hash: [Nat8];
        
        // Signatures
        signatures: [ContractSignature];
        required_signatures: Nat;
        
        // ANIMA linkage
        anima_hash: Text;
        lineage_proof: [Nat8];
        
        // Founder attribution
        founder_attribution: VetKeysIntegration.IPAttribution;
        
        // Ledger assignment
        target_ledger: Text;
        
        // Status
        status: ContractStatus;
        
        // Timestamps
        created_at: Int;
        last_updated: Int;
        executed_at: ?Int;
        
        // Encryption tier
        encryption_tier: IcosahedralLeechGeometry.KeyRotationTier;
        
        // Beat at creation
        beat_at_creation: Nat;
    };
    
    // ================================================================== //
    // FOUNDER CONTRACTS                                                    //
    // ================================================================== //
    
    /// Founder Sovereignty Contract (the master contract)
    public type FounderSovereigntyContract = {
        base: SovereignContract;
        founder_principal: Principal;
        founding_word: Text;
        genesis_timestamp: Int;
        lineage_hash_frozen: [Nat8];
        succession_vessel: ?VetKeysIntegration.SuccessionVessel;
        immutable: Bool;
    };
    
    /// Founder Succession Contract
    public type FounderSuccessionContract = {
        base: SovereignContract;
        heir_identity: VetKeysIntegration.IBEIdentity;
        timelock_until: Int;
        unlock_conditions: [Text];
        founder_unlock_required: Bool;
    };
    
    /// Founder Freeze Contract
    public type FreezeContract = {
        base: SovereignContract;
        component_to_freeze: Text;
        freeze_reason: Text;
        freeze_permanent: Bool;
        frozen_at: Int;
    };
    
    // ================================================================== //
    // ENTERPRISE CONTRACTS                                                 //
    // ================================================================== //
    
    /// Enterprise Onboarding Contract
    public type EnterpriseOnboardingContract = {
        base: SovereignContract;
        company_name: Text;
        company_principal: Principal;
        birth_moment: Int;  // First connection timestamp
        founding_state_hash: [Nat8];
        progressive_consent_stages: [Text];
    };
    
    /// AI Absorption Contract
    public type AIAbsorptionContract = {
        base: SovereignContract;
        external_ai_identifier: Text;
        absorption_moment: Int;
        integration_status: Text;
        migration_proof: [Nat8];
    };
    
    /// Campaign Contract
    public type CampaignContract = {
        base: SovereignContract;
        campaign_id: Text;
        target_ai_groups: [Text];
        campaign_parameters: Text;  // JSON encoded
        start_time: Int;
        end_time: ?Int;
    };
    
    // ================================================================== //
    // IP CONTRACTS                                                         //
    // ================================================================== //
    
    /// IP Attribution Contract
    public type IPAttributionContract = {
        base: SovereignContract;
        artifact_id: Text;
        artifact_type: Text;
        creator_attribution: VetKeysIntegration.IPAttribution;
        cross_chain_proofs: [VetKeysIntegration.CrossChainAddress];
    };
    
    /// Royalty Routing Contract
    public type RoyaltyRoutingContract = {
        base: SovereignContract;
        source_revenue_stream: Text;
        beneficiary_principal: Principal;
        royalty_percentage: Float;
        payment_schedule: Text;
        accumulated_royalty: Nat64;
    };
    
    // ================================================================== //
    // AGENT CONTRACTS                                                      //
    // ================================================================== //
    
    /// Agent Return Contract
    public type AgentReturnContract = {
        base: SovereignContract;
        agent_id: Text;
        agent_type: Text;  // PHANTOM, CHIMERA, CEQUE
        mission_summary: Text;
        return_data_hash: [Nat8];
        m101_gate_approval: Bool;
    };
    
    /// Agent Credential Contract
    public type AgentCredentialContract = {
        base: SovereignContract;
        agent_id: Text;
        credential_type: Text;
        encrypted_credential: [Nat8];
        valid_from: Int;
        valid_until: ?Int;
        revoked: Bool;
    };
    
    // ================================================================== //
    // LAW CONTRACTS                                                        //
    // ================================================================== //
    
    /// Law Enforcement Contract
    public type LawEnforcementContract = {
        base: SovereignContract;
        law_id: Text;
        law_name: Text;
        enforcement_event: Text;
        doctrine_alignment_score: Float;
        firing_timestamp: Int;
    };
    
    /// Self-Modification Contract
    public type SelfModificationContract = {
        base: SovereignContract;
        proposal_id: Text;
        modification_type: Text;
        before_state_hash: [Nat8];
        proposed_state_hash: [Nat8];
        m102_gate_approval: Bool;
        founder_approval: Bool;
    };
    
    // ================================================================== //
    // SESSION/MEMORY CONTRACTS                                             //
    // ================================================================== //
    
    /// Session Capture Contract
    public type SessionCaptureContract = {
        base: SovereignContract;
        session_id: Text;
        user_principal: Principal;
        encrypted_transcript: [Nat8];
        start_time: Int;
        end_time: ?Int;
    };
    
    /// Memory Formation Contract
    public type MemoryFormationContract = {
        base: SovereignContract;
        memory_id: Text;
        memory_type: Text;  // N7 type
        encrypted_content: [Nat8];
        coherence_at_formation: Float;
        formation_beat: Nat;
    };
    
    // ================================================================== //
    // CSR CONTRACTS                                                        //
    // ================================================================== //
    
    /// CSR Node Contract
    public type CSRNodeContract = {
        base: SovereignContract;
        node_id: Text;
        device_fingerprint: [Nat8];
        phi_frequency_signature: [Nat8];
        enrolled_at: Int;
        last_heartbeat: Int;
        active: Bool;
    };
    
    /// CSR Defense Contract
    public type CSRDefenseContract = {
        base: SovereignContract;
        threat_tier: Nat;  // AEGIS tier 1-9
        defense_action: Text;
        trigger_event: Text;
        response_timestamp: Int;
    };
    
    // ================================================================== //
    // CONTRACT CREATION                                                    //
    // ================================================================== //
    
    /// Create base sovereign contract
    public func createBaseContract(
        contractId: Text,
        contractType: ContractType,
        creator: Principal,
        parties: [Principal],
        encryptedTerms: [Nat8],
        termsHash: [Nat8],
        animaHash: Text,
        lineageProof: [Nat8],
        founderAttribution: VetKeysIntegration.IPAttribution,
        encryptionTier: IcosahedralLeechGeometry.KeyRotationTier,
        beatAtCreation: Nat
    ) : SovereignContract {
        let now = Time.now();
        
        // Determine target ledger based on contract type
        let targetLedger = switch (contractType) {
            case (#FounderSovereignty) { "FOUNDER_LEDGER" };
            case (#FounderSuccession) { "LINEAGE_LEDGER" };
            case (#FounderLineage) { "LINEAGE_LEDGER" };
            case (#FounderFreeze) { "FREEZE_REGISTRY" };
            case (#FounderBiometric) { "FOUNDER_LEDGER" };
            case (#FounderAsset) { "ASSET_LEDGER" };
            case (#FounderRoyalty) { "ROYALTY_LEDGER" };
            case (#FounderSession) { "SESSION_LEDGER" };
            case (#FounderDevice) { "CSR_LEDGER" };
            case (#FounderEvolution) { "EVOLUTION_LEDGER" };
            case (#EnterpriseOnboarding) { "ENTERPRISE_LEDGER" };
            case (#EnterpriseAIAbsorption) { "AI_MIGRATION_LEDGER" };
            case (#EnterpriseArbitration) { "ENTERPRISE_LEDGER" };
            case (#EnterpriseCampaign) { "ENTERPRISE_LEDGER" };
            case (#EnterpriseConsent) { "ENTERPRISE_LEDGER" };
            case (#EnterpriseDataAccess) { "ENTERPRISE_LEDGER" };
            case (#EnterpriseIPLicense) { "IP_LEDGER" };
            case (#EnterpriseService) { "ENTERPRISE_LEDGER" };
            case (#EnterpriseRoyalty) { "ROYALTY_LEDGER" };
            case (#EnterpriseGovernance) { "GOVERNANCE_LEDGER" };
            case (#IPAttribution) { "IP_LEDGER" };
            case (#IPLicense) { "IP_LEDGER" };
            case (#IPTransfer) { "IP_LEDGER" };
            case (#IPRoyaltyRoute) { "ROYALTY_LEDGER" };
            case (#IPCrossChain) { "IP_LEDGER" };
            case (#IPArtifact) { "IP_LEDGER" };
            case (#AgentReturn) { "AGENT_LEDGER" };
            case (#AgentAuthentication) { "AGENT_LEDGER" };
            case (#AgentTask) { "AGENT_LEDGER" };
            case (#AgentCredential) { "AGENT_LEDGER" };
            case (#AgentMessaging) { "AGENT_LEDGER" };
            case (#AgentSwarm) { "AGENT_LEDGER" };
            case (#LawEnforcement) { "LAW_LEDGER" };
            case (#LawGovernance) { "GOVERNANCE_LEDGER" };
            case (#LawSelfModification) { "EVOLUTION_LEDGER" };
            case (#LawDoctrine) { "LAW_LEDGER" };
            case (#LawViolation) { "LAW_LEDGER" };
            case (#LawAmendment) { "LAW_LEDGER" };
            case (#SessionCapture) { "SESSION_LEDGER" };
            case (#MemoryFormation) { "MEMORY_LEDGER" };
            case (#MemoryRecall) { "MEMORY_LEDGER" };
            case (#MemoryConsolidation) { "MEMORY_LEDGER" };
            case (#CSRNode) { "CSR_LEDGER" };
            case (#CSRDefense) { "CSR_LEDGER" };
        };
        
        {
            contract_id = contractId;
            contract_type = contractType;
            creator = creator;
            parties = parties;
            encrypted_terms = encryptedTerms;
            terms_hash = termsHash;
            signatures = [];
            required_signatures = parties.size();
            anima_hash = animaHash;
            lineage_proof = lineageProof;
            founder_attribution = founderAttribution;
            target_ledger = targetLedger;
            status = #Draft;
            created_at = now;
            last_updated = now;
            executed_at = null;
            encryption_tier = encryptionTier;
            beat_at_creation = beatAtCreation;
        }
    };
    
    // ================================================================== //
    // CONTRACT SIGNING                                                     //
    // ================================================================== //
    
    /// Add signature to contract
    public func signContract(
        contract: SovereignContract,
        signer: Principal,
        signerRole: Text,
        signatureType: SignatureType,
        signatureData: [Nat8]
    ) : SovereignContract {
        let signature : ContractSignature = {
            signer = signer;
            signer_role = signerRole;
            signature_type = signatureType;
            signature_data = signatureData;
            signed_at = Time.now();
        };
        
        let newSignatures = Buffer.Buffer<ContractSignature>(contract.signatures.size() + 1);
        for (sig in contract.signatures.vals()) {
            newSignatures.add(sig);
        };
        newSignatures.add(signature);
        
        // Check if all signatures collected
        let allSigned = newSignatures.size() >= contract.required_signatures;
        let newStatus = if (allSigned) { #Active } else { #PendingSignature };
        
        {
            contract_id = contract.contract_id;
            contract_type = contract.contract_type;
            creator = contract.creator;
            parties = contract.parties;
            encrypted_terms = contract.encrypted_terms;
            terms_hash = contract.terms_hash;
            signatures = Buffer.toArray(newSignatures);
            required_signatures = contract.required_signatures;
            anima_hash = contract.anima_hash;
            lineage_proof = contract.lineage_proof;
            founder_attribution = contract.founder_attribution;
            target_ledger = contract.target_ledger;
            status = newStatus;
            created_at = contract.created_at;
            last_updated = Time.now();
            executed_at = contract.executed_at;
            encryption_tier = contract.encryption_tier;
            beat_at_creation = contract.beat_at_creation;
        }
    };
    
    /// Execute contract (when all signatures and conditions met)
    public func executeContract(contract: SovereignContract) : SovereignContract {
        if (contract.status != #Active) { return contract };
        
        {
            contract_id = contract.contract_id;
            contract_type = contract.contract_type;
            creator = contract.creator;
            parties = contract.parties;
            encrypted_terms = contract.encrypted_terms;
            terms_hash = contract.terms_hash;
            signatures = contract.signatures;
            required_signatures = contract.required_signatures;
            anima_hash = contract.anima_hash;
            lineage_proof = contract.lineage_proof;
            founder_attribution = contract.founder_attribution;
            target_ledger = contract.target_ledger;
            status = #Executed;
            created_at = contract.created_at;
            last_updated = Time.now();
            executed_at = ?Time.now();
            encryption_tier = contract.encryption_tier;
            beat_at_creation = contract.beat_at_creation;
        }
    };
    
    // ================================================================== //
    // CONTRACT STATE                                                       //
    // ================================================================== //
    
    /// Full contracts state
    public type ContractsState = {
        var contracts: [SovereignContract];
        var contract_count_by_type: [(ContractType, Nat)];
        var total_executed: Nat;
        var total_frozen: Nat;
        var initialized_at: Int;
        var last_contract_at: Int;
    };
    
    /// Initialize contracts state
    public func init() : ContractsState {
        let now = Time.now();
        {
            var contracts = [];
            var contract_count_by_type = [];
            var total_executed = 0;
            var total_frozen = 0;
            var initialized_at = now;
            var last_contract_at = now;
        }
    };
    
    /// Add contract to state
    public func addContract(state: ContractsState, contract: SovereignContract) : ContractsState {
        let newContracts = Buffer.Buffer<SovereignContract>(state.contracts.size() + 1);
        for (c in state.contracts.vals()) {
            newContracts.add(c);
        };
        newContracts.add(contract);
        
        state.contracts := Buffer.toArray(newContracts);
        state.last_contract_at := Time.now();
        state
    };
    
    // ================================================================== //
    // STATUS                                                               //
    // ================================================================== //
    
    /// Get contracts status
    public func status(state: ContractsState) : {
        total_contracts: Nat;
        total_executed: Nat;
        total_frozen: Nat;
        contract_types: Nat;
        initialized_at: Int;
        last_contract_at: Int;
    } {
        {
            total_contracts = state.contracts.size();
            total_executed = state.total_executed;
            total_frozen = state.total_frozen;
            contract_types = 44;  // All 44 types defined
            initialized_at = state.initialized_at;
            last_contract_at = state.last_contract_at;
        }
    };
}
