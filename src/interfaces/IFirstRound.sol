// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface IFirstRound {
  event proposalCreated(address user, Proposal proposal);
  event proposalVoted(address user, uint256 proposal, uint256 totalVotes);

  error userAlreadyVoted();
  error paramNotFound();
  error NotUserRegistered();
  error userIsNotRegisteredBefore();

  struct Proposal {
    uint256 idProposal;
    string description;
    uint256 budget;
    uint256 neededVotes;
    uint256 startDate;
    uint256 totalVotes;
  }

  function createProposal(string memory _description, uint256 _budget) external;
  function voteProposal(uint256 proposalId) external;
}
