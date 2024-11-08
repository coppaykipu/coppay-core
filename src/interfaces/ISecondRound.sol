// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IAccessControl} from 'interfaces/IAccessControl.sol';
import {IFirstRound} from 'interfaces/IFirstRound.sol';
import {IVault} from 'interfaces/IVault.sol';
import {IInitializable} from '../utils/IInitializable.sol';

/**
 * @title ISecondRound
 * @notice Interface for the second round contract
 */
interface ISecondRound is IInitializable {
  /*///////////////////////////////////////////////////////////////
                              EVENTS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Event emitted when a proposal passes the second round
   * @param _proposal The proposal that passed the second round
   */
  event ProposalPassRound(IFirstRound.Proposal _proposal);

  /**
   * @notice Event emitted when a proposal is voted
   * @param _proposalId The ID of the proposal
   * @param _user The address of the user who voted
   * @param _votes The total quadratic votes added
   */
  event ProposalVoted(uint256 indexed _proposalId, address indexed _user, uint256 _votes);

  /**
   * @notice Event emitted when a proposal is finished
   * @param _proposalId The ID of the proposal that was finished
   */
  event ProposalFinished(uint256 indexed _proposalId);

  /**
   * @notice Event emitted when a proposal is completed
   * @param _proposalId The ID of the proposal that was completed
   */
  event ProposalCompleted(uint256 indexed _proposalId);

  /*///////////////////////////////////////////////////////////////
                              ERRORS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Error emitted when the proposal already exists
   */
  error ProposalExists();

  /**
   * @notice Error emitted when the proposal is not found
   */
  error ProposalNotFound();

  /**
   * @notice Error emitted when the proposal is finished
   */
  error ProposalAlreadyFinished();

  /**
   * @notice Error emitted when the proposal is expired
   */
  error ProposalExpired();

  /**
   * @notice Error emitted when the user has already voted
   */
  error AlreadyVoted();

  /**
   * @notice Error emitted when the proposal is not finished
   */
  error ProposalNotFinished();

  /**
   * @notice Error emitted when the proposal is already completed
   */
  error ProposalAlreadyCompleted();

  /**
   * @notice Error emitted when the sender is not the first round contract
   */
  error NotFirstRound();

  /*///////////////////////////////////////////////////////////////
                              VIEW
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Get the access control contract
   * @return _accessControl The access control contract
   */
  function accessControl() external view returns (IAccessControl _accessControl);

  /**
   * @notice Get the vault contract
   * @return _vault The vault contract
   */
  function vault() external view returns (IVault _vault);

  /**
   * @notice Get the first round contract
   * @return _firstRound The first round contract
   */
  function firstRound() external view returns (IFirstRound _firstRound);

  /**
   * @notice Get the total proposal count
   * @return _proposalCount The number of proposals
   */
  function proposalCount() external view returns (uint256 _proposalCount);

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
   * @notice Check if a proposal is finished
   * @param _proposalId The ID of the proposal
   * @return _isFinished True if the proposal is finished
   */
  function finishedProposals(uint256 _proposalId) external view returns (bool _isFinished);

  /**
   * @notice Check if a proposal is completed
   * @param _proposalId The ID of the proposal
   * @return _isCompleted True if the proposal is completed
   */
  function completedProposals(uint256 _proposalId) external view returns (bool _isCompleted);

  /**
   * @notice Check if a user has voted for a proposal
   * @param _user The address of the user
   * @param _proposalId The ID of the proposal
   * @return _voted True if the user has voted
   */
  function userVoted(address _user, uint256 _proposalId) external view returns (bool _voted);

  /*///////////////////////////////////////////////////////////////
                              LOGIC
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Pass a proposal from the first round to the second round
   * @param _proposal The proposal to pass
   */
  function proposalPassRound(IFirstRound.Proposal calldata _proposal) external;

  /**
   * @notice Vote for a proposal
   * @param _proposalId The ID of the proposal to vote for
   * @param _numVotes The number of votes to emit
   */
  function voteProposal(uint256 _proposalId, uint256 _numVotes) external;

  /**
   * @notice Complete a proposal
   * @param _proposalId The ID of the proposal to complete
   * @param _completed Whether the proposal is completed successfully
   */
  function proposalComplete(uint256 _proposalId, bool _completed) external;
}
