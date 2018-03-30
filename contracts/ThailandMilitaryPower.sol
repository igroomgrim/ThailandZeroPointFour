pragma solidity ^0.4.18;

import './Thailand.sol';

contract ThailandMilitaryPower is Thailand {
    uint256 public curfewStartTime;
    uint256 public curfewEndTime;
    
    // Modifier
    modifier whoHasATank() {
        require(msg.sender == commanderInChief);
        _;
    }
 
    function declareCoup() public whoHasATank {
        _transformToPrimeMinister(commanderInChief);
        address _goverment = this;
        commanderInChief.transfer(_goverment.balance);
        // In the real world case, it should be call selfdestruct :p
        // suicide(commanderInChief);
    }
    
    function imposeCurfew(uint256 _startTime, uint256 _endTime) public whoHasATank {
        curfewStartTime = _startTime;
        curfewEndTime = _endTime;
    }
    
    function arrest(address _victim) public whoHasATank {
        prisoners[_victim] = true;
    }
    
    function _transformToPrimeMinister(address _theChoosenOne) internal {
        primeMinister = _theChoosenOne;
    }
}