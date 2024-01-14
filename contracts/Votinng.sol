// SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/access/Ownable.sol";

// contract Voting is Ownable {
//     struct Voter {
//         bool isRegistered;
//         bool hasVoted;
//         uint votedProposalId;
//     }

//     struct Proposal {
//         string description;
//         uint voteCount;
//     }

//     enum WorkflowStatus {
//         RegisteringVoters,
//         ProposalsRegistrationStarted,
//         ProposalsRegistrationEnded,
//         VotingSessionStarted,
//         VotingSessionEnded,
//         VotesTallied
//     }

//     mapping(address => Voter) public voters;
//     Proposal[] public proposals;
//     WorkflowStatus public currentStatus;
//     uint public winningProposalId;

//     event VoterRegistered(address voterAddress);
//     event WorkflowStatusChange(
//         WorkflowStatus previousStatus,
//         WorkflowStatus newStatus
//     );
//     event ProposalRegistered(uint proposalId);
//     event Voted(address voter, uint proposalId);

//     // Register a new voter
//     function registerVoter(address _voter) public onlyOwner {
//         require(
//             currentStatus == WorkflowStatus.RegisteringVoters,
//             "Not in registering phase"
//         );
//         require(!voters[_voter].isRegistered, "Voter already registered");
//         voters[_voter] = Voter(true, false, 0);
//         emit VoterRegistered(_voter);
//     }

//     // Start the proposals registration session
//     function startProposalsRegistration() public onlyOwner {
//         require(
//             currentStatus == WorkflowStatus.RegisteringVoters,
//             "Voters registration is not finished"
//         );
//         currentStatus = WorkflowStatus.ProposalsRegistrationStarted;
//         emit WorkflowStatusChange(
//             WorkflowStatus.RegisteringVoters,
//             currentStatus
//         );
//     }

//     // Register a new proposal
//     function registerProposal(string memory _description) public {
//         require(
//             currentStatus == WorkflowStatus.ProposalsRegistrationStarted,
//             "Proposals registration not started"
//         );
//         require(
//             voters[msg.sender].isRegistered,
//             "You are not a registered voter"
//         );
//         proposals.push(Proposal(_description, 0));
//         emit ProposalRegistered(proposals.length - 1);
//     }

//     // End the proposals registration session
//     function endProposalsRegistration() public onlyOwner {
//         require(
//             currentStatus == WorkflowStatus.ProposalsRegistrationStarted,
//             "Proposals registration not started"
//         );
//         currentStatus = WorkflowStatus.ProposalsRegistrationEnded;
//         emit WorkflowStatusChange(
//             WorkflowStatus.ProposalsRegistrationStarted,
//             currentStatus
//         );
//     }

//     // Start the voting session
//     function startVotingSession() public onlyOwner {
//         require(
//             currentStatus == WorkflowStatus.ProposalsRegistrationEnded,
//             "Proposals registration not ended"
//         );
//         currentStatus = WorkflowStatus.VotingSessionStarted;
//         emit WorkflowStatusChange(
//             WorkflowStatus.ProposalsRegistrationEnded,
//             currentStatus
//         );
//     }

//     // Vote for a proposal
//     function vote(uint proposalId) public {
//         require(
//             currentStatus == WorkflowStatus.VotingSessionStarted,
//             "Voting session not started"
//         );
//         require(
//             voters[msg.sender].isRegistered,
//             "You are not a registered voter"
//         );
//         require(!voters[msg.sender].hasVoted, "You have already voted");
//         require(proposalId < proposals.length, "Invalid proposal ID");

//         voters[msg.sender].hasVoted = true;
//         voters[msg.sender].votedProposalId = proposalId;
//         proposals[proposalId].voteCount++;

//         emit Voted(msg.sender, proposalId);
//     }

//     // End the voting session
//     function endVotingSession() public onlyOwner {
//         require(
//             currentStatus == WorkflowStatus.VotingSessionStarted,
//             "Voting session not started"
//         );
//         currentStatus = WorkflowStatus.VotingSessionEnded;
//         emit WorkflowStatusChange(
//             WorkflowStatus.VotingSessionStarted,
//             currentStatus
//         );
//     }

//     // Tally the votes and determine the winning proposal
//     function tallyVotes() public onlyOwner {
//         require(
//             currentStatus == WorkflowStatus.VotingSessionEnded,
//             "Voting session not ended"
//         );

//         uint winningVoteCount = 0;
//         for (uint i = 0; i < proposals.length; i++) {
//             if (proposals[i].voteCount > winningVoteCount) {
//                 winningVoteCount = proposals[i].voteCount;
//                 winningProposalId = i;
//             }
//         }
//         currentStatus = WorkflowStatus.VotesTallied;
//         emit WorkflowStatusChange(
//             WorkflowStatus.VotingSessionEnded,
//             currentStatus
//         );
//     }

//     // Function to get the winning proposal's details
//     function getWinner() public view returns (uint, string memory) {
//         require(
//             currentStatus == WorkflowStatus.VotesTallied,
//             "Votes not tallied yet"
//         );
//         return (winningProposalId, proposals[winningProposalId].description);
//     }
// }
