// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/// @title Initializable Interface
/// @notice Interface for contracts that need initialization
/// @dev Provides a standardized way to handle one-time initialization of contracts
interface IInitializable {
  /// @notice Thrown when attempting to initialize an already initialized contract
  error AlreadyInitialized();

  /// @notice Checks if the contract has been initialized
  /// @return bool True if the contract has been initialized, false otherwise
  function isInitialized() external view returns (bool);
}
