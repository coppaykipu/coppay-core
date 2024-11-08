// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IInitializable} from '../utils/IInitializable.sol';
import {IAccessControl} from 'interfaces/IAccessControl.sol';
import {ISecondRound} from 'interfaces/ISecondRound.sol';

/**
 * @title IVault
 * @notice Interface for the Vault contract
 */
interface IVault is IInitializable {
  /*///////////////////////////////////////////////////////////////
                              EVENTS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Event emitted when the budget is locked
   * @param _amount The amount of the budget locked
   */
  event BudgetLocked(uint256 _amount);

  /**
   * @notice Event emitted when the budget is unlocked
   * @param _amount The amount of the budget unlocked
   */
  event BudgetUnlocked(uint256 _amount);

  /**
   * @notice Event emitted when the budget is updated
   * @param _amount The new amount of the budget
   */
  event BudgetUpdated(uint256 _amount);

  /**
   * @notice Event emitted when a proposal is completed
   * @param _amount The amount of the proposal completed
   */
  event ProposalCompleted(uint256 _amount);

  /*///////////////////////////////////////////////////////////////
                              ERRORS
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Error emitted when there are insufficient funds
   */
  error InsufficientFunds();

  /**
   * @notice Error emitted when a proposal already exists
   */
  error ProposalExists();

  /**
   * @notice Error emitted when a proposal is not found
   */
  error ProposalNotFound();

  /**
   * @notice Error emitted when the caller is not the second round contract
   */
  error NotSecondRound();

  /*///////////////////////////////////////////////////////////////
                              VIEW
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Get the second round contract
   * @return _secondRound The second round contract
   */
  function secondRound() external view returns (ISecondRound _secondRound);

  /**
   * @notice Get the access control contract
   * @return _accessControl The access control contract
   */
  function accessControl() external view returns (IAccessControl _accessControl);

  /**
   * @notice Get the total budget
   * @return _totalBudget The total budget
   */
  function totalBudget() external view returns (uint256 _totalBudget);

  /**
   * @notice Get the locked budget
   * @return _lockedBudget The locked budget
   */
  function lockedBudget() external view returns (uint256 _lockedBudget);

  /**
   * @notice Get the budget of a proposal
   * @param _proposalId The ID of the proposal
   * @return _amount The budget amount of the proposal
   */
  function proposalsBudget(uint256 _proposalId) external view returns (uint256 _amount);

  /*///////////////////////////////////////////////////////////////
                              LOGIC
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Lock the budget for a proposal
   * @param _proposalId The ID of the proposal
   * @param _amount The amount to lock
   */
  function lockBudget(uint256 _proposalId, uint256 _amount) external;

  /**
   * @notice Unlock the budget for a proposal
   * @param _proposalId The ID of the proposal
   */
  function unlockBudget(uint256 _proposalId) external;

  /**
   * @notice Update the total budget
   * @param _amount The new total budget amount
   */
  function updateBudget(uint256 _amount) external;

  /**
   * @notice Mark a proposal as completed
   * @param _proposalId The ID of the proposal
   */
  function proposalCompleted(uint256 _proposalId) external;
}
