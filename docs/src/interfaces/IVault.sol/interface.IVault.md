# IVault
[Git Source](https://github.com/DonaCoop/pre-contracts/blob/262b4db7071d03d8e97973e03f384efa1ae981ee/src/interfaces/IVault.sol)

Interface for the Vault contract


## Functions
### secondRound

Get the second round contract


```solidity
function secondRound() external view returns (ISecondRound _secondRound);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_secondRound`|`ISecondRound`|The second round contract|


### accessControl

Get the access control contract


```solidity
function accessControl() external view returns (IAccessControl _accessControl);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_accessControl`|`IAccessControl`|The access control contract|


### totalBudget

Get the total budget


```solidity
function totalBudget() external view returns (uint256 _totalBudget);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_totalBudget`|`uint256`|The total budget|


### lockedBudget

Get the locked budget


```solidity
function lockedBudget() external view returns (uint256 _lockedBudget);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_lockedBudget`|`uint256`|The locked budget|


### proposalsBudget

Get the budget of a proposal


```solidity
function proposalsBudget(uint256 _proposalId) external view returns (uint256 _amount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The ID of the proposal|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_amount`|`uint256`|The budget amount of the proposal|


### lockBudget

Lock the budget for a proposal


```solidity
function lockBudget(uint256 _proposalId, uint256 _amount) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The ID of the proposal|
|`_amount`|`uint256`|The amount to lock|


### unlockBudget

Unlock the budget for a proposal


```solidity
function unlockBudget(uint256 _proposalId) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The ID of the proposal|


### updateBudget

Update the total budget


```solidity
function updateBudget(uint256 _amount) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_amount`|`uint256`|The new total budget amount|


### proposalCompleted

Mark a proposal as completed


```solidity
function proposalCompleted(uint256 _proposalId) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The ID of the proposal|


## Events
### BudgetLocked
Event emitted when the budget is locked


```solidity
event BudgetLocked(uint256 _amount);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_amount`|`uint256`|The amount of the budget locked|

### BudgetUnlocked
Event emitted when the budget is unlocked


```solidity
event BudgetUnlocked(uint256 _amount);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_amount`|`uint256`|The amount of the budget unlocked|

### BudgetUpdated
Event emitted when the budget is updated


```solidity
event BudgetUpdated(uint256 _amount);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_amount`|`uint256`|The new amount of the budget|

### ProposalCompleted
Event emitted when a proposal is completed


```solidity
event ProposalCompleted(uint256 _amount);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_amount`|`uint256`|The amount of the proposal completed|

## Errors
### InsufficientFunds
Error emitted when there are insufficient funds


```solidity
error InsufficientFunds();
```

### ProposalExists
Error emitted when a proposal already exists


```solidity
error ProposalExists();
```

### ProposalNotFound
Error emitted when a proposal is not found


```solidity
error ProposalNotFound();
```

### NotSecondRound
Error emitted when the caller is not the second round contract


```solidity
error NotSecondRound();
```

