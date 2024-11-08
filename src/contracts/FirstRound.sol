// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IAccessControl, IFirstRound, ISecondRound} from 'interfaces/IFirstRound.sol';
import {Initializable} from '../utils/Initializable.sol';

contract FirstRound is IFirstRound,Initializable {
  /// @inheritdoc IFirstRound
  uint256 public constant PROPOSAL_TIME = 7 days;
  /// @inheritdoc IFirstRound
  IAccessControl public accessControl;
  /// @inheritdoc IFirstRound
  ISecondRound public secondRound;
  /// @inheritdoc IFirstRound
  uint256 public proposalIdCount;
  /// @inheritdoc IFirstRound
  mapping(uint256 _proposalId => Proposal _proposal) public proposals;
  /// @inheritdoc IFirstRound
  mapping(address _user => mapping(uint256 _proposalId => bool _voted)) public userVoted;

  function initalize(IAccessControl _accessControl,ISecondRound _secondRound) external initializer(){
    accessControl = _accessControl;
    secondRound = _secondRound;
  }

  /// @inheritdoc IFirstRound
  function getProposals() external view returns (Proposal[] memory _proposals) {
    Proposal memory _proposal;
    uint256 _proposalsCount;

    // Count the number of active proposals
    for (uint256 _i; _i < proposalIdCount; _i++) {
      _proposal = proposals[_i];
      if (_proposal.proposalId != 0) {
        _proposals[_proposalsCount] = _proposal;
        _proposalsCount++;
      }
    }
  }

  /// @inheritdoc IFirstRound
  function createProposal(string memory _description, uint256 _budget) external {
    // Check if the user is registered
    accessControl.isRegistered(msg.sender);
    // Check if the description and budget are provided
    if (bytes(_description).length == 0 || _budget == 0) revert ParamNotFound();
    proposalIdCount++;

    // Create a new proposal
    Proposal memory newProposal = Proposal({
      proposalId: proposalIdCount,
      description: _description,
      budget: _budget,
      neededVotes: accessControl.getNeededVotes(),
      startDate: block.timestamp,
      totalVotes: 0
    });

    // Save the proposal and emit an event
    proposals[proposalIdCount] = newProposal;
    emit ProposalCreated(msg.sender, newProposal);
  }

  /// @inheritdoc IFirstRound
  function voteProposal(uint256 _proposalId) external {
    Proposal memory _proposal = proposals[_proposalId];

    // Check if the proposal exists
    if (_proposal.proposalId == 0) revert ProposalNotFound();

    // Check if the user is registered before the proposal start date and the proposal is not expired
    accessControl.isRegisteredBefore(msg.sender, _proposal.startDate);
    if (block.timestamp > _proposal.startDate + PROPOSAL_TIME) revert ProposalExpired();

    // Check if the user already voted
    bool _userVoted = userVoted[msg.sender][_proposalId];
    if (_userVoted) revert UserAlreadyVoted();

    userVoted[msg.sender][_proposalId] = true;

    _proposal.totalVotes++;

    // If the proposal has enough votes, finalize it else update the proposal
    if (_proposal.totalVotes > _proposal.neededVotes) {
      secondRound.proposalPassRound(_proposal);
      delete proposals[_proposalId];
    } else {
      proposals[_proposalId] = _proposal;
    }

    // Emit an event
    emit ProposalVoted(msg.sender, _proposalId, _proposal.totalVotes);
  }
}
