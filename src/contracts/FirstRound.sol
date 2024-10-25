// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IAccessControl, IFirstRound, ISecondRound } from 'interfaces/IFirstRound.sol';

contract FirstRound is IFirstRound {
  /// @inheritdoc IFirstRound
  uint256 public constant PROPOSAL_TIME = 7 days;
  /// @inheritdoc IFirstRound
  IAccessControl public accessControl;
  /// @inheritdoc IFirstRound
  ISecondRound public secondRound;
  /// @inheritdoc IFirstRound
  uint256 public proposalIdCount;
  /// @inheritdoc IFirstRound
  mapping(uint256 _proposalId => Proposal _proposal) public proposals;
  /// @inheritdoc IFirstRound
  mapping(address _user => mapping(uint256 _proposalId => bool _voted)) public userVoted;

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
    if (bytes(_description).length == 0 || _budget == 0) revert ParamNotFound();
    proposalIdCount++;
    
    Proposal memory newProposal = Proposal({
      proposalId: proposalIdCount,
      description: _description,
      budget: _budget,
      neededVotes: _calculateNeededVotes() + 1,
      startDate: block.timestamp,
      totalVotes: 0
    });

    proposals[proposalIdCount] = newProposal;
    emit ProposalCreated(msg.sender, newProposal);
  }

  /// @inheritdoc IFirstRound
  function voteProposal(uint256 _proposalId) public OnlyUserRegistered() {
    Proposal memory _proposal =  proposals[_proposalId];
    if (_proposal.proposalId == 0) revert();//agregar modifier
    
    if (!accessControl.isRegisteredBefore(msg.sender, _proposal.startDate)) revert UserIsNotRegisteredBefore();
    if (block.timestamp > _proposal.startDate + PROPOSAL_TIME) revert();//agregar modifier
    
    bool _userVoted = userVoted[msg.sender][_proposalId];
    if (_userVoted) revert UserAlreadyVoted();
    
    _userVoted = true;
    _proposal.totalVotes++;
    
    if (_proposal.totalVotes > _proposal.neededVotes){
      _finalizeProposal(_proposal);
      delete proposals[_proposalId];
    }
    else{
      proposals[_proposalId] = _proposal; 
      userVoted[msg.sender][_proposalId] = _userVoted;
    }

    emit ProposalVoted(msg.sender, _proposalId, _proposal.totalVotes);
  }

  /**
   * @notice Finalize proposals
   * @param _proposal The proposal
   */
  function _finalizeProposal(Proposal memory _proposal) internal {
    secondRound.proposalAccepted(_proposal);
  }

  /**
   * @notice Get the needed votes to approve a proposal
   * @return _neededVotes The needed votes
   */
  function _calculateNeededVotes() private view returns (uint256 _neededVotes) {
    _neededVotes = accessControl.getRegisteredUsersCount()/2;
  }

  function getProposals() external view returns (Proposal[] memory _proposals){
    Proposal memory _proposal;
    for(uint256 _i; _i < proposalIdCount;_i++){
      _proposal = proposals[_i];
      if (_proposal.proposalId != 0){
        _proposals.push(_proposal);
      }
    }
  }
}
