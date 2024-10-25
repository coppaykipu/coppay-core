// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IFirstRound} from 'interfaces/IFirstRound.sol';
interface ISecondRound {
  /*///////////////////////////////////////////////////////////////
                              STRUCTS
  //////////////////////////////////////////////////////////////*/

  /*///////////////////////////////////////////////////////////////
                              EVENTS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Event emitted when a proposal is accepted
   * @param _proposalId The ID of the proposal
   */
  event ProposalAccepted(uint256 indexed _proposalId);

  /**
   * @notice Event emitted when a proposal is completed
   * @param _proposalId The ID of the proposal
   */
  event ProposalCompleted(uint256 indexed _proposalId);

  /**
   * @notice Event emitted when a proposal is voted
   * @param _proposalId The ID of the proposal
   * @param _numVotes The number of votes
   */
  event ProposalVoted(uint256 indexed _proposalId, address _user, uint256 _numVotes);

  /*///////////////////////////////////////////////////////////////
                              ERRORS
  //////////////////////////////////////////////////////////////*/

  /*///////////////////////////////////////////////////////////////
                              VIEWS
  //////////////////////////////////////////////////////////////*/

  /*///////////////////////////////////////////////////////////////
                              LOGIC
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Accept a proposal
   * @param _proposalId The ID of the proposal
   */
  function proposalAccepted(IFirstRound.Proposal memory _proposal) external;

  /**
   * @notice Complete a proposal which has had enough votes
   * @param _proposalId The ID of the proposal
   */
  function proposalComplete(uint256 _proposalId) external;

  /**
   * @notice Vote on a proposal
   * @param _proposalId The ID of the proposal
   * @param _numVotes The number of votes
   */
  function voteProposal(uint256 _proposalId, uint256 _numVotes) external;
}
