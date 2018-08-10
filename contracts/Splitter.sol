pragma solidity ^0.4.23;

contract Splitter {
    address public payer;
    address public splitOne;
    address public splitTwo;
    
    event LogSplitted(address indexed payer, address indexed first, address indexed second, uint256 remainder, uint256 amount);
    
    
    constructor (address addressOne, address addressTwo) public {
        payer = msg.sender;
        splitOne = addressOne;
        splitTwo = addressTwo;
    }
    
    modifier isAlice () {
        assert(msg.sender == payer);
        _;
    }
    
    function splitAmount (uint amount) private pure returns (uint amountForSplit) {
        if (amount % 2 != 0) {amountForSplit = amount/2 ;}
        else {amountForSplit = (amount-1)/2 ;}
        return amountForSplit;
    }
    
    function split () public isAlice payable {

        require(splitOne != address(0));
        require(splitTwo != address(0));
        require(msg.value != 0);
        require(splitOne != splitTwo);

        uint valueToSend;
        
        assert (msg.value > 0);
        valueToSend = splitAmount(msg.value);
        splitOne.transfer(valueToSend);
        splitTwo.transfer(valueToSend);
    }    
}