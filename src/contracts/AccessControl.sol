// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Math} from '@openzeppelin/contracts/utils/math/Math.sol';
import {EnumerableSet} from '@openzeppelin/contracts/utils/structs/EnumerableSet.sol';
import {IAccessControl} from 'interfaces/IAccessControl.sol';

contract AccessControl is IAccessControl {
  using EnumerableSet for EnumerableSet.AddressSet;
  using Math for uint256;

  /// @inheritdoc IAccessControl
  uint256 public constant VOTING_POWER = 500;
  /// @inheritdoc IAccessControl
  address public admin;
  /// @inheritdoc IAccessControl
  mapping(address _user => uint256 _timestamp) public registrationTimestamps;
  /// @inheritdoc IAccessControl
  mapping(address _user => uint256 _votingPower) public usersVotingPower;

  /**
   * @notice Set of registered users
   */
  EnumerableSet.AddressSet private _usersList;

  /**
   * @notice Set of users that have submitted their application
   */
  EnumerableSet.AddressSet private _usersSubmitted;

  /**
   * @notice Constructor
   * @param _admin The address of the admin
   */
  constructor(address _admin) {
    admin = _admin;
  }

  /// @inheritdoc IAccessControl
  function isAdmin(address _admin) public view {
    if (_admin != admin) revert NotAdmin();
  }

  /// @inheritdoc IAccessControl
  function isRegistered(address _user) public view {
    if (!_usersList.contains(_user)) revert NotRegistered();
  }

  /// @inheritdoc IAccessControl
  function isRegisteredBefore(address _user, uint256 _timestamp) external view {
    if (!_usersList.contains(_user) || registrationTimestamps[_user] < _timestamp) revert NotApprovedBefore();
  }

  /// @inheritdoc IAccessControl
  function hasVotingPower(address _user) external view {
    if (!_usersList.contains(_user) || usersVotingPower[_user] == 0) revert NoVotingPower();
  }

  /// @inheritdoc IAccessControl
  function getUsers() external view returns (address[] memory _users) {
    _users = _usersList.values();
  }

  /// @inheritdoc IAccessControl
  function getNeededVotes(uint256 _timestamp) external view returns (uint256 _neededVotes) {
    address _user;
    uint256 _usersCount;

    // Calculate the number of users that have registered before the timestamp
    for (uint256 _i; _i < _usersList.length(); _i++) {
      _user = _usersList.at(_i);
      if (registrationTimestamps[_user] < _timestamp) {
        _usersCount++;
      }
    }
    _neededVotes = _usersCount / 2;
  }

  /// @inheritdoc IAccessControl
  function getNeededQuadraticVotes(uint256 _timestamp) external view returns (uint256 _neededQuadraticVotes) {
    address _user;
    uint256 _usersCount;
    uint256 _totalPower;
    uint256 _totalUsersPower;

    // Calculate the total power of the users that have registered before the timestamp
    for (uint256 _i; _i < _usersList.length(); _i++) {
      _user = _usersList.at(_i);
      if (registrationTimestamps[_user] < _timestamp) {
        _usersCount++;
        _totalPower += usersVotingPower[_user];
      }
    }

    // Calculate the total power of the users that have registered before the timestamp
    _totalUsersPower = _usersCount * _totalPower;

    // The math for the needed votes is the square root of the total users power divided by 2
    _neededQuadraticVotes = Math.sqrt(_totalUsersPower / 2);
  }

  /// @inheritdoc IAccessControl
  function submit(address _user, uint256 _numOperationMP) external {
    // Check if the user is already registered or submitted
    if (_usersList.contains(_user) || _usersSubmitted.contains(_user)) revert AlreadyRegistered();

    // Add the user to the submitted list
    _usersSubmitted.add(_user);
    emit Submitted(_user, _numOperationMP);
  }

  /// @inheritdoc IAccessControl
  function approveUser(address _user) external {
    isAdmin(msg.sender);
    // Check if the user is already submitted or registered
    if (!_usersSubmitted.contains(_user)) revert NotSubmitted();
    if (_usersList.contains(_user)) revert AlreadyRegistered();

    // Add the user to the registered list and remove from the submitted list
    _usersList.add(_user);
    _usersSubmitted.remove(_user);
    registrationTimestamps[_user] = block.timestamp;
    usersVotingPower[_user] = VOTING_POWER;

    // Emit the Approved event
    emit Approved(_user);
  }

  /// @inheritdoc IAccessControl
  function revokeUsers(address[] calldata _users) external {
    isAdmin(msg.sender);
    address _user;
    for (uint256 _i; _i < _users.length; _i++) {
      _user = _users[_i];

      // Remove the user from the registered list
      _usersList.remove(_user);
      registrationTimestamps[_user] = 0;
      usersVotingPower[_user] = 0;
      emit Revoked(_user);
    }
  }
}
