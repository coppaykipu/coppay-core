// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import {IAccessControl} from 'interfaces/IAccessControl.sol';

contract AccessControl is IAccessControl {
  using EnumerableSet for EnumerableSet.AddressSet;

  EnumerableSet.AddressSet private _approvedUsers;
  EnumerableSet.AddressSet private _registeredUsers;
  EnumerableSet.AddressSet private _admins;
  mapping (address => uint256) private _registrationTimestamps;
///cambiar el mapping
  constructor () {
    admins.add(msg.sender);
  }

  modifier onlyAdmin(){
    if(!isAdmin(msg.sender))){
      revert NotAdmin();
    }
    _;
  }

  modifier onlyRegistered(address _user){
    if(!isRegistered(_user))){
      revert NotRegistered(_user);
    }
    _;
  }

  function isRegistered(address _user) external view returns (bool _isRegistered){
    return _registeredUsers.contains(_user);
  }

  function isRegisteredBefore(address _user, uint256 _timestamp) external view returns (bool _isRegisteredBefore){
    return _registeredUsers.contains(_user) && _registrationTimestamps[_user] < _timestamp;
  }

  function getRegisteredUsersCount() external view returns (uint256 _usersCount){
    return _registeredUsers.length(); 
  }

  function isAdmin(address _user) external view returns (bool _isAdmin){
    return _admins.constains(user);
  }
  
  /// @inheritdoc IAccessControl
  function submit(address _user, uint256 _numOperationMP) external {
    if(!_registeredUsers.constains(_user)){
      revert NotRegistered(_user);
    }
    _registeredUsers.add(_user);
    _registrationTimestamps[_user] = block.timestamp;
    emit Submitted(_user, _numOperationMP);
  }

  /// @inheritdoc IAccessControl
  function approveUser(address _user) onlyAdmin onlyRegistered(_user) external;
    _approvedUsers.add(_user);
    emit Approved(_user);

  /// @inheritdoc IAccessControl
  function revokeUser(address _user) onlyAdmin onlyRegistered(_user) external{
    _registeredUsers.remove(_user);
    emit Revoked(_user);
  }
}
