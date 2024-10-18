// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IAccessControl} from 'interfaces/IAccessControl.sol';

contract AccessControl is IAccessControl {
  /// @inheritdoc IAccessControl
  function submit(address _user, uint256 _numOperationMP) external;

  /// @inheritdoc IAccessControl
  function approveUser(address _user) external;

  /// @inheritdoc IAccessControl
  function revokeUser(address _user) external;
}
