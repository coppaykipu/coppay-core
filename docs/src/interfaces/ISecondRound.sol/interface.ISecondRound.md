# ISecondRound
[Git Source](https://github.com/DonaCoop/pre-contracts/blob/262b4db7071d03d8e97973e03f384efa1ae981ee/src/interfaces/ISecondRound.sol)

Interface for the second round contract


## Functions
### accessControl

Get the access control contract


```solidity
function accessControl() external view returns (IAccessControl _accessControl);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_accessControl`|`IAccessControl`|The access control contract|


### vault

Get the vault contract


```solidity
function vault() external view returns (IVault _vault);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_vault`|`IVault`|The vault contract|


### firstRound

Get the first round contract


```solidity
function firstRound() external view returns (IFirstRound _firstRound);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_firstRound`|`IFirstRound`|The first round contract|


### proposalCount

Get the total proposal count


```solidity
function proposalCount() external view returns (uint256 _proposalCount);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_proposalCount`|`uint256`|The number of proposals|


### proposals

Get the proposal by ID


```solidity
function proposals(uint256 _proposalId)
  external
  view
  returns (
    uint256 _id,
    string calldata _description,
    uint256 _budget,
    uint256 _neededVotes,
    uint256 _totalVotes,
    uint256 _startDate
  );
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The ID of the proposal|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_id`|`uint256`|The ID of the proposal|
|`_description`|`string`|The description of the proposal|
|`_budget`|`uint256`|The budget of the proposal|
|`_neededVotes`|`uint256`|The needed votes to approve the proposal|
|`_totalVotes`|`uint256`|The total votes of the proposal|
|`_startDate`|`uint256`|The start date of the proposal|


### finishedProposals

Check if a proposal is finished


```solidity
function finishedProposals(uint256 _proposalId) external view returns (bool _isFinished);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The ID of the proposal|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_isFinished`|`bool`|True if the proposal is finished|


### completedProposals

Check if a proposal is completed


```solidity
function completedProposals(uint256 _proposalId) external view returns (bool _isCompleted);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The ID of the proposal|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_isCompleted`|`bool`|True if the proposal is completed|


### userVoted

Check if a user has voted for a proposal


```solidity
function userVoted(address _user, uint256 _proposalId) external view returns (bool _voted);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_user`|`address`|The address of the user|
|`_proposalId`|`uint256`|The ID of the proposal|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_voted`|`bool`|True if the user has voted|


### proposalPassRound

Pass a proposal from the first round to the second round


```solidity
function proposalPassRound(IFirstRound.Proposal calldata _proposal) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposal`|`IFirstRound.Proposal`|The proposal to pass|


### voteProposal

Vote for a proposal


```solidity
function voteProposal(uint256 _proposalId, uint256 _numVotes) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The ID of the proposal to vote for|
|`_numVotes`|`uint256`|The number of votes to emit|


### proposalComplete

Complete a proposal


```solidity
function proposalComplete(uint256 _proposalId, bool _completed) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The ID of the proposal to complete|
|`_completed`|`bool`|Whether the proposal is completed successfully|


## Events
### ProposalPassRound
Event emitted when a proposal passes the second round


```solidity
event ProposalPassRound(IFirstRound.Proposal _proposal);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposal`|`IFirstRound.Proposal`|The proposal that passed the second round|

### ProposalVoted
Event emitted when a proposal is voted


```solidity
event ProposalVoted(uint256 indexed _proposalId, address indexed _user, uint256 _votes);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The ID of the proposal|
|`_user`|`address`|The address of the user who voted|
|`_votes`|`uint256`|The total quadratic votes added|

### ProposalFinished
Event emitted when a proposal is finished


```solidity
event ProposalFinished(uint256 indexed _proposalId);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The ID of the proposal that was finished|

### ProposalCompleted
Event emitted when a proposal is completed


```solidity
event ProposalCompleted(uint256 indexed _proposalId);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The ID of the proposal that was completed|

## Errors
### ProposalExists
Error emitted when the proposal already exists


```solidity
error ProposalExists();
```

### ProposalNotFound
Error emitted when the proposal is not found


```solidity
error ProposalNotFound();
```

### ProposalAlreadyFinished
Error emitted when the proposal is finished


```solidity
error ProposalAlreadyFinished();
```

### ProposalExpired
Error emitted when the proposal is expired


```solidity
error ProposalExpired();
```

### AlreadyVoted
Error emitted when the user has already voted


```solidity
error AlreadyVoted();
```

### ProposalNotFinished
Error emitted when the proposal is not finished


```solidity
error ProposalNotFinished();
```

### ProposalAlreadyCompleted
Error emitted when the proposal is already completed


```solidity
error ProposalAlreadyCompleted();
```

### NotFirstRound
Error emitted when the sender is not the first round contract


```solidity
error NotFirstRound();
```

