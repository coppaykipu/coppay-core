// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IAccessControl} from 'interfaces/IAccessControl.sol';

/**
 * @title IFirstRound
 * @dev IFirstRound interface
 */
interface IFirstRound {
  /*///////////////////////////////////////////////////////////////
                              STRUCTS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Proposal struct
   * @param proposalId The Id of the proposal
   * @param description The description of the proposal
   * @param budget The budget of the proposal
   * @param neededVotes The needed votes to approve the proposal
   * @param totalVotes The total votes of the proposal
   * @param startDate The start date of the proposal
   */
  struct Proposal {
    uint256 proposalID;
    string description;
    uint256 budget;
    uint256 neededVotes;
    uint256 totalVotes;
    uint256 startDate;
  }

  /*///////////////////////////////////////////////////////////////
                              EVENTS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Event emitted when a proposal is created
   * @param _user The address of the user
   * @param _proposal The proposal
   */
  event ProposalCreated(address indexed _user, Proposal _proposal);

  /**
   * @notice Event emitted when a proposal is voted
   * @param _user The address of the user
   * @param _proposalId The ID of the proposal
   * @param _totalVotes The total votes of the proposal
   */
  event ProposalVoted(address indexed _user, uint256 indexed _proposalId, uint256 _totalVotes);

  /*///////////////////////////////////////////////////////////////
                              ERRORS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Error emitted when a user already voted
   */
  error UserAlreadyVoted();

  /**
   * @notice Error emitted when a user is not registered
   */
  error ParamNotFound();

  /**
   * @notice Error emitted when a user is not registered
   */
  error NotUserRegistered();

  /**
   * @notice Error emitted when a user is not registered
   */
  error UserIsNotRegisteredBefore();

  /*///////////////////////////////////////////////////////////////
                              VIEW
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Get the proposal time
   * @return _PROPOSAL_TIME The proposal time
   */
  function PROPOSAL_TIME() external view returns (uint256 _PROPOSAL_TIME);

  /**
   * @notice Get the access control contract
   * @return _accessControl The access control contract
   */
  function accessControl() external view returns (IAccessControl _accessControl);

  /**
   * @notice Get the proposal ID
   * @return _proposalId The proposal ID
   */
  function proposalId() external view returns (uint256 _proposalId);

  /**
   * @notice Get the proposal by ID
   * @param _proposalId The ID of the proposal
   * @return _proposal The proposal
   */
  function proposal(uint256 _proposalId) external view returns (Proposal memory _proposal);

  /**
   * @notice Check if a user voted
   * @param _user The address of the user
   * @param _proposalId The ID of the proposal
   * @return _voted True if the user voted
   */
  function userVoted(address _user, uint256 _proposalId) external view returns (bool _voted);

  /*///////////////////////////////////////////////////////////////
                              LOGIC
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Create a proposal
   * @param _description The description of the proposal
   * @param _budget The budget of the proposal
   */
  function createProposal(string memory _description, uint256 _budget) external;

  /**
   * @notice Vote a proposal
   * @param proposalId The ID of the proposal
   */
  function voteProposal(uint256 proposalId) external;

  /**
   * @notice Finalize proposals
   * @param _proposalId The ID of the proposal
   */
  function finalizeProposal(uint256 _proposalId) external;
}
