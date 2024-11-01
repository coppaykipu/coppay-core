# IAccessControl
[Git Source](https://github.com/DonaCoop/pre-contracts/blob/262b4db7071d03d8e97973e03f384efa1ae981ee/src/interfaces/IAccessControl.sol)

*IAccessControl interface*


## Functions
### VOTING_POWER

The default voting power of a user


```solidity
function VOTING_POWER() external view returns (uint256 _VOTING_POWER);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_VOTING_POWER`|`uint256`|The default voting power of a user|


### admin

The admin of the contract


```solidity
function admin() external view returns (address _admin);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_admin`|`address`|The address of the admin|


### registrationTimestamps

The registration timestamp of a user


```solidity
function registrationTimestamps(address _user) external view returns (uint256 _timestamp);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_user`|`address`|The address of the user|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_timestamp`|`uint256`|The registration timestamp of the user|


### usersVotingPower

The voting power of a user


```solidity
function usersVotingPower(address _user) external view returns (uint256 _votingPower);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_user`|`address`|The address of the user|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_votingPower`|`uint256`|The voting power of the user|


### isAdmin

Checks if the provided address is the admin


```solidity
function isAdmin(address _admin) external view;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_admin`|`address`|The address to check|


### isRegistered

Checks if a user is registered


```solidity
function isRegistered(address _user) external view;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_user`|`address`|The address of the user to check|


### isRegisteredBefore

Checks if a user was registered before a certain timestamp


```solidity
function isRegisteredBefore(address _user, uint256 _timestamp) external view;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_user`|`address`|The address of the user|
|`_timestamp`|`uint256`|The timestamp to check|


### hasVotingPower

Checks if a user has voting power


```solidity
function hasVotingPower(address _user) external view;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_user`|`address`|The address of the user to check|


### getUsers

Get the list of all registered users


```solidity
function getUsers() external view returns (address[] memory _users);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_users`|`address[]`|The list of addresses of registered users|


### getNeededVotes

Get the number of votes needed based on a timestamp


```solidity
function getNeededVotes() external view returns (uint256 _neededVotes);
```

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_neededVotes`|`uint256`|The number of needed votes|


### getNeededQuadraticVotes

Get the number of quadratic votes needed based on a timestamp


```solidity
function getNeededQuadraticVotes(uint256 _timestamp) external view returns (uint256 _neededQuadraticVotes);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_timestamp`|`uint256`|The timestamp to calculate the needed quadratic votes|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_neededQuadraticVotes`|`uint256`|The number of needed quadratic votes|


### submit

Submits a user for approval


```solidity
function submit(address _user, uint256 _numOperationMP) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_user`|`address`|The address of the user to submit|
|`_numOperationMP`|`uint256`|The operation number associated with the submission|


### approveUser

Approves a user


```solidity
function approveUser(address _user) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_user`|`address`|The address of the user to approve|


### revokeUsers

Revokes the registration of a list of users


```solidity
function revokeUsers(address[] calldata _users) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_users`|`address[]`|The list of addresses of users to revoke|


## Events
### Submitted
Event emitted when a user is submitted for approval


```solidity
event Submitted(address indexed _user, uint256 _numOperationMP);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_user`|`address`|The address of the user|
|`_numOperationMP`|`uint256`|The operation number associated with the submission|

### Approved
Event emitted when a user is approved


```solidity
event Approved(address indexed _user);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_user`|`address`|The address of the user|

### Revoked
Event emitted when a user is revoked


```solidity
event Revoked(address indexed _user);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_user`|`address`|The address of the user|

## Errors
### NotAdmin
Error emitted when the sender is not an admin


```solidity
error NotAdmin();
```

### NotRegistered
Error emitted when a user is not registered


```solidity
error NotRegistered();
```

### NoVotingPower
Error emitted when a user does not have voting power


```solidity
error NoVotingPower();
```

### NotApprovedBefore
Error emitted when a user has not been approved before a certain timestamp


```solidity
error NotApprovedBefore();
```

### AlreadyRegistered
Error emitted when a user has already registered


```solidity
error AlreadyRegistered();
```

### NotSubmitted
Error emitted when a user has not been submitted for approval


```solidity
error NotSubmitted();
```

