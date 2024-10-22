// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IAccessControl, IFirstRound, ISecondRound } from 'interfaces/IFirstRound.sol';

contract FirstRound is IFirstRound {
  /// @inheritdoc IFirstRound
  uint256 public constant _PROPOSAL_TIME = 7 days;
  /// @inheritdoc IFirstRound
  IAccessControl public accessControl;
  /// @inheritdoc IFirstRound
  ISecondRound public secondRound;
  /// @inheritdoc IFirstRound
  uint256 public proposalIdCount;
  /// @inheritdoc IFirstRound
  mapping(uint256 _proposalId => Proposal _proposal) proposals;
  /// @inheritdoc IFirstRound
  mapping(address _user => mapping(uint256 _proposalId => bool _voted)) userVoted;

  constructor(IAccessControl _accessControl, ISecondRound _secondRound) {
    accessControl = _accessControl;
    secondRound = _secondRound;
  }
  
    modifier OnlyUserRegistered(){
        if(!accessControl.isRegistered(msg.sender)) revert NotUserRegistered();
        _;
    
    }

  /// @inheritdoc IFirstRound
  function createProposal(string memory _description, uint256 _budget) public OnlyUserRegistered() {
    if (bytes(_description).length == 0 || _budget == 0) revert   ParamNotFound();
    proposalIdCount++;
    
    Proposal memory newProposal = Proposal({
      proposalId: proposalIdCount,
      description: _description,
      budget: _budget,
      neededVotes: _calculateNeededVotes(),
      startDate: block.timestamp,
      totalVotes: 0
    });

    proposals[proposalIdCount] = newProposal;
    emit ProposalCreated(msg.sender, newProposal);
  }

  /// @inheritdoc IFirstRound
  function voteProposal(uint256 _proposalId) public OnlyUserRegistered() {
    if (!accessControl.isRegisteredBefore(msg.sender, proposals[_proposalId].startDate)) revert UserIsNotRegisteredBefore();
    if (userVoted[msg.sender][_proposalId]) revert UserAlreadyVoted();
    userVoted[msg.sender][_proposalId] = true;
    proposals[_proposalId].totalVotes++;
    
    
    if (proposals[_proposalId].totalVotes > proposals[_proposalId].neededVotes){
      _finalizeProposal(_proposalId);
    }
    emit ProposalVoted(msg.sender, _proposalId, proposals[_proposalId].totalVotes);
  }

  /**
   * @notice Finalize proposals
   * @param _proposalId The ID of the proposal
   */
  function _finalizeProposal(uint256 _proposalId) internal {
    secondRound.proposalAccepted(_proposalId);
  }

  /**
   * @notice Get the needed votes to approve a proposal
   * @return _neededVotes The needed votes
   */
  function _calculateNeededVotes() private view returns (uint256 _neededVotes) {
  
    return accessControl.getRegisteredUsersCount()/2;
  
  }
}
