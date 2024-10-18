// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IAccessControl, IFirstRound} from 'interfaces/IFirstRound.sol';

contract FirstRoundModule is IFirstRound {
  /// @inheritdoc IAccessControl
  uint256 public constant _PROPOSAL_TIME = 7 days;
  /// @inheritdoc IAccessControl
  IAccessControl public accessControl;
  /// @inheritdoc IAccessControl
  uint256 public _proposalId;
  /// @inheritdoc IAccessControl
  mapping(uint256 _proposalId => Proposal _proposal) proposals;
  /// @inheritdoc IAccessControl
  mapping(address _user => mapping(uint256 _proposalId => bool _voted)) userVoted;

  constructor(IAccessControl addressAccessControl) {
    accessControl = addressAccessControl;
  }
  /*
    modifier OnlyUserRegistered(){
        if(!accessControl.isRegistered(msg.sender)) revert NotUserRegistered();
        _;
    
    */

  /// @inheritdoc IAccessControl
  function createProposal(string memory _description, uint256 _budget) public /*OnlyUserRegistered()*/ {
    if (bytes(_description).length == 0 || _budget == 0) revert paramNotFound();
    _proposalId++;
    Proposal memory newProposal = Proposal({
      idProposal: _proposalId,
      description: _description,
      budget: _budget,
      neededVotes: _neededVotes(),
      startDate: block.timestamp,
      totalVotes: 0
    });
    proposals[_proposalId] = newProposal;
    emit proposalCreated(msg.sender, newProposal);
  }

  /// @inheritdoc IAccessControl
  function voteProposal(uint256 proposalId) public /*OnlyUserRegistered()*/ {
    /*if (!accessControl.isRegisteredBefore(msg.sender, proposals[proposalId].startDate)) revert userIsNotRegisteredBefore();*/
    if (userVoted[msg.sender][proposalId]) revert userAlreadyVoted();
    userVoted[msg.sender][proposalId] = true;
    proposals[proposalId].totalVotes++;
    emit proposalVoted(msg.sender, proposalId, proposals[proposalId].totalVotes);
  }

  /// @inheritdoc IAccessControl
  function finalizeProposal(uint256 _proposalId) external {
    _proposalId = 1;
  }

  /**
   * @notice Get the needed votes to approve a proposal
   * @return _neededVotes The needed votes
   */
  function _calculateNeededVotes() private view returns (uint256 _neededVotes) {
    /*
        return accessControl.getRegisteredUsersCount()/2;
        */
    return 1;
  }
}
