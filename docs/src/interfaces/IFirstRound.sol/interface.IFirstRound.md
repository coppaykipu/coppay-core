# IFirstRound
[Git Source](https://github.com/DonaCoop/pre-contracts/blob/262b4db7071d03d8e97973e03f384efa1ae981ee/src/interfaces/IFirstRound.sol)

Interface for the FirstRound contract


## Functions
### PROPOSAL_TIME

Get the proposal time


```solidity
function PROPOSAL_TIME() external view returns (uint256 _PROPOSAL_TIME);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_PROPOSAL_TIME`|`uint256`|The proposal time|


### accessControl

Get the access control contract


```solidity
function accessControl() external view returns (IAccessControl _accessControl);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_accessControl`|`IAccessControl`|The access control contract|


### secondRound

Get the second round contract


```solidity
function secondRound() external view returns (ISecondRound _secondRound);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_secondRound`|`ISecondRound`|The second round contract|


### proposalIdCount

Get the proposal ID


```solidity
function proposalIdCount() external view returns (uint256 _proposalId);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The proposal ID|


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


### userVoted

Check if a user voted


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
|`_voted`|`bool`|True if the user voted|


### getProposals

Get the active proposals


```solidity
function getProposals() external view returns (Proposal[] memory _proposals);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_proposals`|`Proposal[]`|The active proposals|


### createProposal

Create a proposal


```solidity
function createProposal(string memory _description, uint256 _budget) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_description`|`string`|The description of the proposal|
|`_budget`|`uint256`|The budget of the proposal|


### voteProposal

Vote a proposal


```solidity
function voteProposal(uint256 proposalId) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`proposalId`|`uint256`|The ID of the proposal|


## Events
### ProposalCreated
Event emitted when a proposal is created


```solidity
event ProposalCreated(address indexed _user, Proposal _proposal);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_user`|`address`|The address of the user|
|`_proposal`|`Proposal`|The proposal|

### ProposalVoted
Event emitted when a proposal is voted


```solidity
event ProposalVoted(address indexed _user, uint256 indexed _proposalId, uint256 _totalVotes);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_user`|`address`|The address of the user|
|`_proposalId`|`uint256`|The ID of the proposal|
|`_totalVotes`|`uint256`|The total votes of the proposal|

## Errors
### UserAlreadyVoted
Error emitted when a user already voted


```solidity
error UserAlreadyVoted();
```

### ParamNotFound
Error emitted when a user is not registered


```solidity
error ParamNotFound();
```

### ProposalNotFound
Error emitted when a proposal is not found


```solidity
error ProposalNotFound();
```

### ProposalExpired
Error emitted when a proposal is expired


```solidity
error ProposalExpired();
```

## Structs
### Proposal
Proposal struct


```solidity
struct Proposal {
  uint256 proposalId;
  string description;
  uint256 budget;
  uint256 neededVotes;
  uint256 totalVotes;
  uint256 startDate;
}
```

**Properties**

|Name|Type|Description|
|----|----|-----------|
|`proposalId`|`uint256`|The Id of the proposal|
|`description`|`string`|The description of the proposal|
|`budget`|`uint256`|The budget of the proposal|
|`neededVotes`|`uint256`|The needed votes to approve the proposal|
|`totalVotes`|`uint256`|The total votes of the proposal|
|`startDate`|`uint256`|The start date of the proposal|

