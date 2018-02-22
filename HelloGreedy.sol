/*
A simple hello world. The last payer will see 
his name on greetings.
This version is greedy.
*/

contract HelloGreedy{
    address public greetings;
    address public owner;
    
    function HelloGreedy() public{
        owner = msg.sender;
    }
    
    //it accepts only 1 ether or more. It's greedy
    function () payable public{
        require(msg.value >= 1 ether);
        greetings = msg.sender;
    }
    
    //destroy function, the owner can destroy and take all the money
    function takeMoneyAndDestroy() public{
        require(msg.sender == owner);
        selfdestruct(owner);
    }
    
}
