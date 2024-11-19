# Coppay

Professional Practices Project by technical school students from the City of Buenos Aires, carried out together with the ETH Kipu Foundation.

## Smart Contracts

- [Coppay](#coppay)
	- [Smart Contracts](#smart-contracts)
		- [Overview](#overview)
		- [Core Components](#core-components)
			- [Access Control System](#access-control-system)
			- [First Round Voting](#first-round-voting)
			- [Second Round Voting](#second-round-voting)
			- [Vault Management](#vault-management)
		- [Security Features](#security-features)
			- [Budget Protection](#budget-protection)
			- [Voting Integrity](#voting-integrity)
			- [Events and Error Handling](#events-and-error-handling)
		- [Usage Flow](#usage-flow)
		- [Development Notes](#development-notes)

### Overview

Coppay smart contracts feature a decentralized proposal and voting system with two rounds of voting, access control, and vault management for budgets.

### Core Components

#### Access Control System

Contract: `AccessControl.sol`

Interface: `IAccessControl.sol`

Key Features:

- User registration and management
- Admin controls
- Voting power tracking

Main Functions:

- `isAdmin()`: Validates admin privileges
- `isRegistered()`: Checks if a user is registered
- `getNeededVotes()`: Calculates required votes (50% of users)
- `hasVotingPower()`: Verifies user voting power

#### First Round Voting

Contract: `FirstRound.sol`

Interface: `IFirstRound.sol`

Key Features:
- Initial proposal creation
- Basic voting mechanism
- 7-day proposal duration
- Proposal tracking

Proposal Structure:

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

Main Functions:

- `createProposal()`: Creates new proposals
- `voteProposal()`: Handles first round voting
- `getProposals()`: Retrieves active proposals

#### Second Round Voting

Contract: `SecondRound.sol`

Interface: `ISecondRound.sol`

Key Features:

- Advanced voting mechanism
- Quadratic voting implementation
- Proposal completion tracking
- Integration with vault for budget management

Main Functions:

- `proposalPassRound()`: Transitions proposals from first round
- `voteProposal()`: Handles second round voting
- `proposalComplete()`: Marks proposals as completed

#### Vault Management

Contract: `Vault.sol`

Interface: `IVault.sol`

Key Features:

- Budget management
- Funds locking mechanism
Proposal budget tracking
- Access control integration

Main functions:

- `updateBudget()`: Updates total available budget
- `proposalCompleted()`: Handles completion of proposals
- Budget locking and unlocking mechanisms

### Security Features

- Access Control
- Admin-only functions
- Registration verification
- Voting power validation

#### Budget Protection

- Locked budget tracking
- Insufficient funds checks
- Proposal budget validation

#### Voting Integrity
Double-voting prevention
- Time-based restrictions
- Quadratic voting implementation

#### Events and Error Handling

Key Events:
- Proposal creation and voting
- Budget updates and locks
- User registration and approval
- Proposal completion

Common errors:

- `NotAdmin`
- `InsufficientFunds`
- `NotRegistered`
- `ProposalNotFound`

### Usage Flow

- Proposal Creation
  - Registered user creates proposal
  - Includes description and budget
- First Round Voting
  - Users vote on proposals
  - 7-day voting period
  - Needs 50% of users to approve
- Second Round
  - Approved proposals move to second round
  - Quadratic voting mechanism
  - Budget allocation through vault
- Completion
  - Successful proposals marked complete
  - Budget released from vault
  - Events emitted for tracking

### Development Notes

- Solidity Version: 0.8.26

Dependencies:
- OpenZeppelin Math
- OpenZeppelin EnumerableSet

Testing Considerations

- Access control validation
- Voting mechanisms
- Budget calculations
- Time-based functions
- Gas Optimization
- Efficient mapping usage
- Minimal storage operations
- Optimized loops in getProposals

More details in the `docs` folder.