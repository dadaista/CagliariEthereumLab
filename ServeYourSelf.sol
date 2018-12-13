pragma solidity 0.4.25;

interface Token {
    function totalSupply() external constant returns (uint);
    function balanceOf(address tokenOwner) external constant returns (uint balance);
    function allowance(address tokenOwner, address spender) external constant returns (uint remaining);
    function transfer(address to, uint tokens) external returns (bool success);
    function approve(address spender, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}


contract ServeYourSelf{
    mapping (address => bool) public stoplist;
    address public owner;
    Token public token;
    uint256 CEL = 1e18;
    uint256 penny = 1e16;
    uint256 airdrop = 30 * penny; 
      
    constructor(address _token) public{
        owner = msg.sender;
        token = Token(_token);
    }
    
    function pickTokens() public{
        require(stoplist[msg.sender] == false);
        stoplist[msg.sender] = true;
        token.transferFrom(owner, msg.sender, airdrop);
    } 
    
    function () payable public{
        require(msg.value <= 0.01 ether);
        pickTokens();
        
    }
    
    function close() public{
        require(msg.sender == owner);
        selfdestruct(owner);
    }
    
}
