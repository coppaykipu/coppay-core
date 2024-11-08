// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IAccessControl} from 'interfaces/IAccessControl.sol';
import {ISecondRound} from 'interfaces/ISecondRound.sol';
import {IInitializable} from '../utils/IInitializable.sol';
/**
 * @title IFirstRound
 * @notice Interface for the FirstRound contract
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
    uint256 proposalId;
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
   * @notice Error emitted when a proposal is not found
   */
  error ProposalNotFound();

  /**
   * @notice Error emitted when a proposal is expired
   */
  error ProposalExpired();

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
   * @notice Get the second round contract
   * @return _secondRound The second round contract
   */
  function secondRound() external view returns (ISecondRound _secondRound);

  /**
   * @notice Get the proposal ID
   * @return _proposalId The proposal ID
   */
  function proposalIdCount() external view returns (uint256 _proposalId);

  /**
   * @notice Get the proposal by ID
   * @param _proposalId The ID of the proposal
   * @return _id The ID of the proposal
   * @return _description The description of the proposal
   * @return _budget The budget of the proposal
   * @return _neededVotes The needed votes to approve the proposal
   * @return _totalVotes The total votes of the proposal
   * @return _startDate The start date of the proposal
   */
  function proposals(uint256 _proposalId)
    external
    view
    returns (
      uint256 _id,
      string calldata _description,
      uint256 _budget,
      uint256 _neededVotes,
      uint256 _totalVotes,
      uint256 _startDate
    );

  /**
   * @notice Check if a user voted
   * @param _user The address of the user
   * @param _proposalId The ID of the proposal
   * @return _voted True if the user voted
   */
  function userVoted(address _user, uint256 _proposalId) external view returns (bool _voted);

  /**
   * @notice Get the active proposals
   * @return _proposals The active proposals
   */
  function getProposals() external view returns (Proposal[] memory _proposals);

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
}
