// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface IVault {
  /*///////////////////////////////////////////////////////////////
                              STRUCTS
  //////////////////////////////////////////////////////////////*/

  /*///////////////////////////////////////////////////////////////
                              EVENTS
  //////////////////////////////////////////////////////////////*/

  /*///////////////////////////////////////////////////////////////
                              ERRORS
  //////////////////////////////////////////////////////////////*/

  /*///////////////////////////////////////////////////////////////
                              VIEWS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Check if a user has enough votes
   * @param _user The address of the user
   * @param _numVotes The number of votes
   * @return _hasVotes True if the user has enough votes
   */
  function haveVotes(address _user, uint256 _numVotes) external view returns (bool _hasVotes);

  /*///////////////////////////////////////////////////////////////
                              LOGIC
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Lock a budget for a proposal that has been accepted
   * @param _amount The amount to lock
   */
  function lockBudget(uint256 _amount) external;

  /**
   * @notice Unlock a budget for a proposal that has been cancelled
   * @param _amount The amount to unlock
   */
  function unlockBudget(uint256 _amount) external;

  /**
   * @notice Update the budget
   * @param _amount The amount to update
   */
  function updateBudget(uint256 _amount) external;
}
