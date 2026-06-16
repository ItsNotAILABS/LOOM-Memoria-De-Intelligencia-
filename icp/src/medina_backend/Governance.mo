/**
 * MEDINA Governance Module — Proposal-based governance system.
 * 
 * Implements:
 * - Proposal creation and lifecycle
 * - Voting mechanism
 * - Gate enforcement integration
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Time "mo:base/Time";

import Types "Types";
import Utils "Utils";

module {
    public type Proposal = Types.Proposal;
    public type ProposalStatus = Types.ProposalStatus;
    public type ProposalCategory = Types.ProposalCategory;
    
    /// Governance state
    public type GovernanceState = {
        var proposals: [(Text, Proposal)];
        var idCounter: Nat;
        var created_at: Int;
    };
    
    /// Initialize governance system
    public func init() : GovernanceState {
        {
            var proposals = [];
            var idCounter = 0;
            var created_at = Time.now();
        }
    };
    
    /// Create a new proposal
    public func createProposal(
        state: GovernanceState,
        title: Text,
        description: Text,
        category: ProposalCategory,
        proposer: Principal
    ) : Proposal {
        state.idCounter += 1;
        let now = Time.now();
        
        let proposal : Proposal = {
            proposal_id = Utils.generateId("prop", state.idCounter);
            title = title;
            description = description;
            category = category;
            status = #DRAFT;
            proposer = proposer;
            created_at = now;
            updated_at = now;
            votes_for = 0;
            votes_against = 0;
        };
        
        let buffer = Buffer.fromArray<(Text, Proposal)>(state.proposals);
        buffer.add((proposal.proposal_id, proposal));
        state.proposals := Buffer.toArray(buffer);
        
        proposal
    };
    
    /// Get a proposal by ID
    public func getProposal(state: GovernanceState, proposalId: Text) : ?Proposal {
        for ((id, proposal) in state.proposals.vals()) {
            if (id == proposalId) {
                return ?proposal;
            };
        };
        null
    };
    
    /// Submit a proposal for review
    public func submitProposal(state: GovernanceState, proposalId: Text) : Bool {
        let now = Time.now();
        var found = false;
        
        state.proposals := Array.map<(Text, Proposal), (Text, Proposal)>(
            state.proposals,
            func((id, proposal)) : (Text, Proposal) {
                if (id == proposalId) {
                    switch (proposal.status) {
                        case (#DRAFT) {
                            found := true;
                            (id, {
                                proposal with
                                status = #SUBMITTED;
                                updated_at = now;
                            })
                        };
                        case (_) { (id, proposal) };
                    };
                } else {
                    (id, proposal)
                }
            }
        );
        
        found
    };
    
    /// Vote on a proposal
    public func vote(state: GovernanceState, proposalId: Text, inFavor: Bool) : Bool {
        let now = Time.now();
        var found = false;
        
        state.proposals := Array.map<(Text, Proposal), (Text, Proposal)>(
            state.proposals,
            func((id, proposal)) : (Text, Proposal) {
                if (id == proposalId) {
                    switch (proposal.status) {
                        case (#SUBMITTED or #UNDER_REVIEW) {
                            found := true;
                            (id, {
                                proposal with
                                status = #UNDER_REVIEW;
                                votes_for = if (inFavor) { proposal.votes_for + 1 } else { proposal.votes_for };
                                votes_against = if (not inFavor) { proposal.votes_against + 1 } else { proposal.votes_against };
                                updated_at = now;
                            })
                        };
                        case (_) { (id, proposal) };
                    };
                } else {
                    (id, proposal)
                }
            }
        );
        
        found
    };
    
    /// Approve a proposal (requires sufficient votes)
    public func approveProposal(state: GovernanceState, proposalId: Text) : Bool {
        let now = Time.now();
        var found = false;
        
        state.proposals := Array.map<(Text, Proposal), (Text, Proposal)>(
            state.proposals,
            func((id, proposal)) : (Text, Proposal) {
                if (id == proposalId) {
                    switch (proposal.status) {
                        case (#UNDER_REVIEW) {
                            if (proposal.votes_for > proposal.votes_against) {
                                found := true;
                                (id, {
                                    proposal with
                                    status = #APPROVED;
                                    updated_at = now;
                                })
                            } else {
                                (id, proposal)
                            }
                        };
                        case (_) { (id, proposal) };
                    };
                } else {
                    (id, proposal)
                }
            }
        );
        
        found
    };
    
    /// Reject a proposal
    public func rejectProposal(state: GovernanceState, proposalId: Text) : Bool {
        let now = Time.now();
        var found = false;
        
        state.proposals := Array.map<(Text, Proposal), (Text, Proposal)>(
            state.proposals,
            func((id, proposal)) : (Text, Proposal) {
                if (id == proposalId) {
                    switch (proposal.status) {
                        case (#UNDER_REVIEW) {
                            found := true;
                            (id, {
                                proposal with
                                status = #REJECTED;
                                updated_at = now;
                            })
                        };
                        case (_) { (id, proposal) };
                    };
                } else {
                    (id, proposal)
                }
            }
        );
        
        found
    };
    
    /// Execute an approved proposal
    public func executeProposal(state: GovernanceState, proposalId: Text) : Bool {
        let now = Time.now();
        var found = false;
        
        state.proposals := Array.map<(Text, Proposal), (Text, Proposal)>(
            state.proposals,
            func((id, proposal)) : (Text, Proposal) {
                if (id == proposalId) {
                    switch (proposal.status) {
                        case (#APPROVED) {
                            found := true;
                            (id, {
                                proposal with
                                status = #EXECUTED;
                                updated_at = now;
                            })
                        };
                        case (_) { (id, proposal) };
                    };
                } else {
                    (id, proposal)
                }
            }
        );
        
        found
    };
    
    /// Withdraw a proposal
    public func withdrawProposal(state: GovernanceState, proposalId: Text, caller: Principal) : Bool {
        let now = Time.now();
        var found = false;
        
        state.proposals := Array.map<(Text, Proposal), (Text, Proposal)>(
            state.proposals,
            func((id, proposal)) : (Text, Proposal) {
                if (id == proposalId and Principal.equal(proposal.proposer, caller)) {
                    switch (proposal.status) {
                        case (#DRAFT or #SUBMITTED) {
                            found := true;
                            (id, {
                                proposal with
                                status = #WITHDRAWN;
                                updated_at = now;
                            })
                        };
                        case (_) { (id, proposal) };
                    };
                } else {
                    (id, proposal)
                }
            }
        );
        
        found
    };
    
    /// List all proposals
    public func listProposals(state: GovernanceState) : [Proposal] {
        Array.map<(Text, Proposal), Proposal>(state.proposals, func((_, p)) : Proposal { p })
    };
    
    /// List proposals by status
    public func listByStatus(state: GovernanceState, status: ProposalStatus) : [Proposal] {
        let results = Buffer.Buffer<Proposal>(8);
        for ((_, proposal) in state.proposals.vals()) {
            if (proposalStatusEqual(proposal.status, status)) {
                results.add(proposal);
            };
        };
        Buffer.toArray(results)
    };
    
    /// Check if proposal statuses are equal
    func proposalStatusEqual(a: ProposalStatus, b: ProposalStatus) : Bool {
        switch (a, b) {
            case (#DRAFT, #DRAFT) true;
            case (#SUBMITTED, #SUBMITTED) true;
            case (#UNDER_REVIEW, #UNDER_REVIEW) true;
            case (#APPROVED, #APPROVED) true;
            case (#REJECTED, #REJECTED) true;
            case (#EXECUTED, #EXECUTED) true;
            case (#WITHDRAWN, #WITHDRAWN) true;
            case (_, _) false;
        }
    };
    
    /// Get governance status
    public func status(state: GovernanceState) : {
        total_proposals: Nat;
        pending_count: Nat;
        approved_count: Nat;
        rejected_count: Nat;
    } {
        var pending : Nat = 0;
        var approved : Nat = 0;
        var rejected : Nat = 0;
        
        for ((_, proposal) in state.proposals.vals()) {
            switch (proposal.status) {
                case (#DRAFT or #SUBMITTED or #UNDER_REVIEW) { pending += 1 };
                case (#APPROVED or #EXECUTED) { approved += 1 };
                case (#REJECTED) { rejected += 1 };
                case (_) {};
            };
        };
        
        {
            total_proposals = state.proposals.size();
            pending_count = pending;
            approved_count = approved;
            rejected_count = rejected;
        }
    };
    
    /// Get proposal count
    public func count(state: GovernanceState) : Nat {
        state.proposals.size()
    };
}
