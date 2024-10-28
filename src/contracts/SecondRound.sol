// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IAccessControl, IFirstRound, ISecondRound, IVault} from 'interfaces/ISecondRound.sol';

contract SecondRound is ISecondRound {
  /// @inheritdoc ISecondRound
  IAccessControl public accessControl;
  /// @inheritdoc ISecondRound
  IVault public vault;
  /// @inheritdoc ISecondRound
  IFirstRound public firstRound;
  /// @inheritdoc ISecondRound
  uint256 public proposalCount;
  /// @inheritdoc ISecondRound
  mapping(uint256 _proposalId => IFirstRound.Proposal) public proposals;
  /// @inheritdoc ISecondRound
  mapping(uint256 _proposalId => bool _isFinished) public finishedProposals;
  /// @inheritdoc ISecondRound
  mapping(uint256 _proposalId => bool _isCompleted) public completedProposals;
  /// @inheritdoc ISecondRound
  mapping(address _user => mapping(uint256 _proposalId => bool _voted)) public userVoted;

  /**
   * @notice Constructor
   * @param _accessControl The address of the access control contract
   * @param _vault The address of the vault contract
   * @param _firstRound The address of the first round contract
   */
  constructor(IAccessControl _accessControl, IVault _vault, IFirstRound _firstRound) {
    accessControl = _accessControl;
    vault = _vault;
    firstRound = _firstRound;
  }

  /// @inheritdoc ISecondRound
  function proposalPassRound(IFirstRound.Proposal memory _proposal) external {
    // Check if the sender is the first round contract
    if (msg.sender != address(firstRound)) revert NotFirstRound();

    // Check if the proposal already exists
    if (proposals[_proposal.proposalId].proposalId != 0) revert ProposalExists();

    // Increment the proposal count
    proposalCount++;

    // Create a new proposal in the second round
    _proposal.proposalId = proposalCount;
    _proposal.neededVotes = accessControl.getNeededQuadraticVotes(block.timestamp);
    _proposal.startDate = block.timestamp;
    proposals[_proposal.proposalId] = _proposal;

    // Emit the proposal pass round event
    emit ProposalPassRound(_proposal);
  }

  /// @inheritdoc ISecondRound
  function voteProposal(uint256 _proposalId, uint256 _numVotes) external {
    // Check if the sender has voting power
    accessControl.hasVotingPower(msg.sender);
    // Get the proposal
    IFirstRound.Proposal memory _proposal = proposals[_proposalId];

    // Revert if the proposal is not found
    if (_proposal.proposalId == 0) revert ProposalNotFound();
    // Revert if proposal is finished
    if (finishedProposals[_proposalId]) revert ProposalAlreadyFinished();
    // Revert if the user has already voted
    if (userVoted[msg.sender][_proposalId]) revert AlreadyVoted();
    // Revert if the proposal is expired
    if (block.timestamp > _proposal.startDate + firstRound.PROPOSAL_TIME()) revert ProposalExpired();

    // Calculate the quadratic cost
    uint256 _quadraticCost = _calculateQuadraticCost(_numVotes);

    // Add the votes to the proposal
    _proposal.totalVotes += _quadraticCost;

    // Check if the proposal has enough votes
    if (_proposal.totalVotes >= _proposal.neededVotes) {
      // Mark the proposal as finished
      finishedProposals[_proposalId] = true;
      // Call the vault to lock the budget
      vault.lockBudget(_proposalId, _proposal.budget);
      // Emit the proposal finished event
      emit ProposalFinished(_proposalId);
    }
    emit ProposalVoted(_proposalId, msg.sender, _quadraticCost);
  }

  /// @inheritdoc ISecondRound
  function proposalComplete(uint256 _proposalId, bool _completed) external {
    // Check if the sender is an admin
    accessControl.isAdmin(msg.sender);
    // Get the proposal
    IFirstRound.Proposal memory _proposal = proposals[_proposalId];

    // Revert if the proposal is not found
    if (_proposal.proposalId == 0) revert ProposalNotFound();
    // Revert if the proposal is not finished
    if (!finishedProposals[_proposalId]) revert ProposalNotFinished();
    // Revert if the proposal is already completed
    if (completedProposals[_proposalId]) revert ProposalAlreadyCompleted();

    if (_completed) {
      vault.proposalCompleted(_proposalId);
    } else {
      // Call the vault to unlock the budget
      vault.unlockBudget(_proposalId);
    }

    // Mark the proposal as completed
    completedProposals[_proposalId] = true;

    // Emit the proposal completed event
    emit ProposalCompleted(_proposalId);
  }

  /**
   * @notice Get the quadratic cost of for a number of votes
   */
  function _calculateQuadraticCost(uint256 _numVotes) internal pure returns (uint256 _quadraticCost) {
    _quadraticCost = _numVotes * _numVotes;
  }
}
