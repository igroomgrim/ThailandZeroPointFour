pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract Thailand {
    using SafeMath for uint256;
    
    address public owner;
    address public primeMinister;
    address public commanderInChief;
    address public chairperson;    
    mapping (address => bool) public prisoners;
    
    // Modifier
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function Thailand() public {
        owner = msg.sender;
    }
    
    function nominatePrimeMinister(address _someOneElse) public onlyOwner {
        primeMinister = _someOneElse;
    }
    
    function nominateCommanderInChief(address _militaryMan) public onlyOwner {
        commanderInChief = _militaryMan;
    }
    
    function nominateChairperson(address _lazyBoy) public onlyOwner {
        chairperson = _lazyBoy;
    }
}