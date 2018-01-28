
//This contract takes your money and store your addr
//for greetings. Nothing special. Then the deployer
//can destroy all and take money. Genius!

contract Hello{
    address public greetings;
    address public owner;
    function Hello() public{
        owner = msg.sender;
    }
    function () payable public{
        greetings = msg.sender;
    }
    
    function takeMoneyAndDestroy() public{
        require(msg.sender == owner);
        selfdestruct(owner);
    }
}
