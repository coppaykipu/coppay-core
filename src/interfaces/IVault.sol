// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface IVault {
  /*///////////////////////////////////////////////////////////////
                              STRUCTS
  //////////////////////////////////////////////////////////////*/

  /*///////////////////////////////////////////////////////////////
                              EVENTS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Event emitted when a budget is locked
   * @param _amount The amount locked
   */
  event BudgetLocked(uint256 _amount);

  /**
   * @notice Event emitted when a budget is unlocked
   * @param _amount The amount unlocked
   */
  event BudgetUnlocked(uint256 _amount);

  /**
   * @notice Event emitted when a budget is updated
   * @param _amount The amount updated
   */
  event BudgetUpdated(uint256 _amount);

  /*///////////////////////////////////////////////////////////////
                              ERRORS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Error emitted when a user does not have enough votes
   */
  error InsufficientVotes();

  /*///////////////////////////////////////////////////////////////
                              VIEWS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Check if a user has enough votes
   * @param _user The address of the user
   * @param _numVotes The number of votes
   */
  function haveVotes(address _user, uint256 _numVotes) external view;

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
