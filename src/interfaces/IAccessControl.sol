// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IInitializable} from '../utils/IInitializable.sol';


/**
 * @title IAccessControl
 * @dev IAccessControl interface
 */
interface IAccessControl is IInitializable{
  /*///////////////////////////////////////////////////////////////
                              EVENTS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Event emitted when a user is submitted for approval
   * @param _user The address of the user
   * @param _numOperationMP The operation number associated with the submission
   */
  event Submitted(address indexed _user, uint256 _numOperationMP);

  /**
   * @notice Event emitted when a user is approved
   * @param _user The address of the user
   */
  event Approved(address indexed _user);

  /**
   * @notice Event emitted when a user is revoked
   * @param _user The address of the user
   */
  event Revoked(address indexed _user);

  /*///////////////////////////////////////////////////////////////
                              ERRORS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Error emitted when the sender is not an admin
   */
  error NotAdmin();

  /**
   * @notice Error emitted when a user is not registered
   */
  error NotRegistered();

  /**
   * @notice Error emitted when a user does not have voting power
   */
  error NoVotingPower();

  /**
   * @notice Error emitted when a user has not been approved before a certain timestamp
   */
  error NotApprovedBefore();

  /**
   * @notice Error emitted when a user has already registered
   */
  error AlreadyRegistered();

  /**
   * @notice Error emitted when a user has not been submitted for approval
   */
  error NotSubmitted();

  /*///////////////////////////////////////////////////////////////
                              VIEW FUNCTIONS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice The default voting power of a user
   * @return _VOTING_POWER The default voting power of a user
   */
  function VOTING_POWER() external view returns (uint256 _VOTING_POWER);

  /**
   * @notice The admin of the contract
   * @return _admin The address of the admin
   */
  function admin() external view returns (address _admin);

  /**
   * @notice The registration timestamp of a user
   * @param _user The address of the user
   * @return _timestamp The registration timestamp of the user
   */
  function registrationTimestamps(address _user) external view returns (uint256 _timestamp);

  /**
   * @notice The voting power of a user
   * @param _user The address of the user
   * @return _votingPower The voting power of the user
   */
  function usersVotingPower(address _user) external view returns (uint256 _votingPower);

  /**
   * @notice Checks if the provided address is the admin
   * @param _admin The address to check
   */
  function isAdmin(address _admin) external view;

  /**
   * @notice Checks if a user is registered
   * @param _user The address of the user to check
   */
  function isRegistered(address _user) external view;

  /**
   * @notice Checks if a user was registered before a certain timestamp
   * @param _user The address of the user
   * @param _timestamp The timestamp to check
   */
  function isRegisteredBefore(address _user, uint256 _timestamp) external view;

  /**
   * @notice Checks if a user has voting power
   * @param _user The address of the user to check
   */
  function hasVotingPower(address _user) external view;

  /**
   * @notice Get the list of all registered users
   * @return _users The list of addresses of registered users
   */
  function getUsers() external view returns (address[] memory _users);

  /**
   * @notice Get the number of votes needed based on a timestamp
   * @return _neededVotes The number of needed votes
   */
  function getNeededVotes() external view returns (uint256 _neededVotes);

  /**
   * @notice Get the number of quadratic votes needed based on a timestamp
   * @param _timestamp The timestamp to calculate the needed quadratic votes
   * @return _neededQuadraticVotes The number of needed quadratic votes
   */
  function getNeededQuadraticVotes(uint256 _timestamp) external view returns (uint256 _neededQuadraticVotes);

  /*///////////////////////////////////////////////////////////////
                              LOGIC
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Submits a user for approval
   * @param _user The address of the user to submit
   * @param _numOperationMP The operation number associated with the submission
   */
  function submit(address _user, uint256 _numOperationMP) external;

  /**
   * @notice Approves a user
   * @param _user The address of the user to approve
   */
  function approveUser(address _user) external;

  /**
   * @notice Revokes the registration of a list of users
   * @param _users The list of addresses of users to revoke
   */
  function revokeUsers(address[] calldata _users) external;
}
