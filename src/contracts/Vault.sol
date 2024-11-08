// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Initializable} from '../utils/Initializable.sol';
import {IAccessControl, ISecondRound, IVault} from 'interfaces/IVault.sol';

contract Vault is IVault, Initializable {
  /// @inheritdoc IVault
  ISecondRound public secondRound;
  /// @inheritdoc IVault
  IAccessControl public accessControl;
  /// @inheritdoc IVault
  uint256 public totalBudget;
  /// @inheritdoc IVault
  uint256 public lockedBudget;
  /// @inheritdoc IVault
  mapping(uint256 _proposalId => uint256 _amount) public proposalsBudget;

  /**
   * @notice Initialize the contract
   * @param _secondRound The address of the second round contract
   * @param _accessControl The address of the access control contract
   */
  function initialize(ISecondRound _secondRound, IAccessControl _accessControl) external initializer {
    secondRound = _secondRound;
    accessControl = _accessControl;
  }

  /**
   * @notice Check if the sender is the second round contract
   */
  modifier onlySecondRound() {
    if (msg.sender != address(secondRound)) revert NotSecondRound();
    _;
  }

  /**
   * @notice Check if the sender is the admin
   */
  modifier onlyAdmin() {
    accessControl.isAdmin(msg.sender);
    _;
  }

  /// @inheritdoc IVault
  function lockBudget(uint256 _proposalId, uint256 _amount) external onlySecondRound {
    // Revert if the amount is greater than the total budget
    if (_amount > totalBudget) revert InsufficientFunds();

    // Revert if the proposal already exists
    if (proposalsBudget[_proposalId] != 0) revert ProposalExists();

    // Lock the budget and update the total and locked budget
    totalBudget -= _amount;
    lockedBudget += _amount;
    proposalsBudget[_proposalId] = _amount;

    // Emit budget locked event
    emit BudgetLocked(_amount);
  }

  /// @inheritdoc IVault
  function unlockBudget(uint256 _proposalId) external onlySecondRound {
    // Revert if the proposal does not exist
    uint256 _amount = proposalsBudget[_proposalId];
    if (_amount == 0) revert ProposalNotFound();

    // Unlock the budget and update the total and locked budget
    totalBudget += _amount;
    lockedBudget -= _amount;
    proposalsBudget[_proposalId] = 0;

    // Emit budget unlocked event
    emit BudgetUnlocked(_amount);
  }

  /// @inheritdoc IVault
  function updateBudget(uint256 _amount) external onlyAdmin {
    // Revert if the amount is less than the total budget
    if (_amount < totalBudget) revert InsufficientFunds();
    totalBudget = _amount;

    // Emit budget updated event
    emit BudgetUpdated(_amount);
  }

  /// @inheritdoc IVault
  function proposalCompleted(uint256 _proposalId) external onlySecondRound {
    // Revert if the proposal does not exist
    uint256 _amount = proposalsBudget[_proposalId];
    if (_amount == 0) revert ProposalNotFound();

    // Unlock the budget and update the total and locked budget
    lockedBudget -= _amount;

    // Emit proposal completed event
    emit ProposalCompleted(_amount);
  }
}
