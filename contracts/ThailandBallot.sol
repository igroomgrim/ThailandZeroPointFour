pragma solidity ^0.4.18;

import './ThailandMilitaryPower.sol';
import './Proposal.sol';

contract ThailandBollot is ThailandMilitaryPower {
    struct Voter {
        // This property should be hide :P
        // uint8 voteToProposal;
        bool voted;
    }

    // Fee for who want to be candidate
    uint256 public politicalFee;
    
    // Candidates
    Proposal[] public proposals;
    mapping (address => bool) public candidates;
    address[] public candidateList;
    
    
    // Voters
    address[] public voterList;
    mapping (address => Voter) public addressOfVoter;
    mapping (address => uint256) public voteCountOfProposal;
    
    // Election Time
    uint256 public startTime;
    uint256 public endTime;
    
    // Modifier
    modifier inTimeForVote() {
        require(now >= startTime && now <= endTime);
        _;
    }
    
    modifier onlyChairperson() {
        require(msg.sender == chairperson);
        _;
    }
    
    modifier onlyCandidate() {
        require(candidates[msg.sender]);
        _;
    }
    
    // 1514764800, 1546214400
    function ThailandBollot(uint256 _startTime, uint256 _endTime) public {
        startTime = _startTime;
        endTime = _endTime;
        politicalFee = 0.44 ether;
    }
    
    function updatePoliticalFee(uint256 _fee) public onlyChairperson {
        politicalFee = _fee;
    }
    
    function wantToBeCandidate() public payable {
        require(msg.value >= politicalFee);
        candidates[msg.sender] = true;
        candidateList.push(msg.sender);
    }
    
    function createProposal(string _manifesto) public onlyCandidate {
        proposals.push(new Proposal(msg.sender, _manifesto));
    }
    
    function vote(address _toProposal) public inTimeForVote {
        Voter storage voter = addressOfVoter[msg.sender];
        require(!voter.voted);
        require(_toProposal != address(0));
        
        voterList.push(msg.sender);
        voter.voted = true;
        voteCountOfProposal[_toProposal] = voteCountOfProposal[_toProposal].add(1);
    }
    
    function winningProposal() public view returns (address _winningProposal) {
        uint256 _winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++) {
            if (voteCountOfProposal[proposals[prop]] > _winningVoteCount) {
                _winningVoteCount = voteCountOfProposal[proposals[prop]];
                _winningProposal = proposals[prop];
            }
        }
        
        return _winningProposal;
    }
}