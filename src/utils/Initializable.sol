// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IInitializable} from './IInitializable.sol';

/// @title Initializable Implementation
/// @notice Abstract contract that provides initialization functionality
/// @dev Implements IInitializable to provide one-time initialization capability
abstract contract Initializable is IInitializable {
  /// @dev Internal flag to track initialization state
  bool private _initialized;

  /// @notice Ensures the contract is only initialized once
  /// @dev Modifier that prevents a contract from being initialized multiple times
  modifier initializer() {
    if (_initialized) revert AlreadyInitialized();
    _initialized = true;
    _;
  }

  /// @inheritdoc IInitializable
  function isInitialized() external view returns (bool) {
    return _initialized;
  }
}
