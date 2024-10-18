// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/**
 * @title IAccessControl
 * @notice Interface for the AccessControl contract
 */
interface IAccessControl {
  /*///////////////////////////////////////////////////////////////
                              EVENTS
  //////////////////////////////////////////////////////////////*/

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

  /**
   * @notice Event emitted when a user summit their aplicattion
   * @param _user The address of the user
   * @param _numOperationMP The number of operations in MP
   */
  event Submitted(address indexed _user, uint256 _numOperationMP);

  /*///////////////////////////////////////////////////////////////
                              ERRORS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Error emitted when a user is not registered
   */
  error NotRegistered(address _user);

  /**
   * @notice Error emitted when a user is already registered
   */
  error NotAdmin(address _user);

  /*///////////////////////////////////////////////////////////////
                              VIEWS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Check if a user is registered
   * @param _user The address of the user
   * @return _isRegistered True if the user is registered
   */
  function isRegistered(address _user) external view returns (bool _isRegistered);

  /**
   * @notice Check if a user is registered before a timestamp
   * @param _user The address of the user
   * @param _timestamp The timestamp to check
   * @return _isRegisteredBefore True if the user is registered before the timestamp
   */
  function isRegisteredBefore(address _user, uint256 _timestamp) external view returns (bool _isRegisteredBefore);

  /**
   * @notice Get the number of registered users
   * @return _usersCount The number of registered users
   */
  function getRegisteredUsersCount() external view returns (uint256 _usersCount);

  /**
   * @notice Check if a user is an admin
   * @param _user The address of the user
   * @return _isAdmin True if the user is an admin
   */
  function isAdmin(address _user) external view returns (bool _isAdmin);

  /*///////////////////////////////////////////////////////////////
                              LOGIC
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Register a user
   * @param _user The address of the user
   * @param _numOperationMP The number of the MP operation
   */
  function submit(address _user, uint256 _numOperationMP) external;

  /**
   * @notice Approve a user
   * @dev Only admin can call this function
   * @param _user The address of the user
   */
  function approveUser(address _user) external;

  /**
   * @notice Revoke a user
   * @dev Only admin can call this function
   * @param _user The address of the user
   */
  function revokeUser(address _user) external;
}
