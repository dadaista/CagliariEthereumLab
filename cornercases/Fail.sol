pragma solidity ^0.4.24;

//Test your skills
//Which is the value of state x after execution of increase( )??
//Choose among: 0, 1, 2, other values,...
contract Fail{
    uint256 public x = 0;
    function increase() public{
        require(x < 2);
        x = x + 1 ;
        require(x < 2);
        x = x + 1;
        require(x < 2);
        x = x + 1;
    }
}
