// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IAccessControl} from 'interfaces/IAccessControl.sol';
import {IFirstRound} from 'interfaces/IFirstRound.sol';

contract FirstRoundModule is IFirstRound {
  IAccessControl public accessControl;

  constructor(address addressAccessControl) {
    accessControl = IAccessControl(addressAccessControl);
  }

  uint256 public constant _PROPOSAL_TIME = 7 days;
  uint256 public _proposalId;
  mapping(address _user => mapping(uint256 _proposalId => bool)) userVoted;
  mapping(uint256 _proposalId => Proposal) proposals;
  /*
    modifier OnlyUserRegistered(){
        if(!accessControl.isRegistered(msg.sender)) revert NotUserRegistered();
        _;
    
    */

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

  function voteProposal(uint256 proposalId) public /*OnlyUserRegistered()*/ {
    /*if (!accessControl.isRegisteredBefore(msg.sender, proposals[proposalId].startDate)) revert userIsNotRegisteredBefore();*/
    if (userVoted[msg.sender][proposalId]) revert userAlreadyVoted();
    userVoted[msg.sender][proposalId] = true;
    proposals[proposalId].totalVotes++;
    emit proposalVoted(msg.sender, proposalId, proposals[proposalId].totalVotes);
  }

  function _neededVotes() private view returns (uint256) {
    /*
        return accessControl.getRegisteredUsersCount()/2;
        */
    return 1;
  }
}
