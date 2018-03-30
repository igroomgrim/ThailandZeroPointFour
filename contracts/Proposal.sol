pragma solidity ^0.4.18;

contract Proposal {
    address public creator; // Candidate
    string public manifesto;
    
    modifier onlyCreator {
        require(msg.sender == creator);
        _;
    }
    
    function Proposal(address _creator, string _manifesto) public {
        creator = _creator;
        manifesto = _manifesto;
    }
    
    function editProposal(string _manifesto) public onlyCreator {
        manifesto = _manifesto;
    }
}