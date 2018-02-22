pragma solidity ^0.4.16;

import "./StandardToken.sol";

contract CELToken is StandardToken {

    function () {throw;}

    uint256 public initialSupply=9999 * 1e18;
    string public name = "Cagliari Ethereum Lab";  //fancy name: eg Simon Bucks
    uint8 public decimals=18;        //How many decimals to show. ie. There could 1000 base units with 3 decimals. Meaning 0.980 SBX = 980 base units. It's like comparing 1 wei to 1 ether.
    string public symbol="CEL";     //An identifier: eg SBX
    string public version = 'H0.3'; //human 0.1 standard. Just an arbitrary versioning scheme.
    function CELToken() {
        balances[msg.sender] = initialSupply;
        totalSupply = initialSupply;                        // Update total supply
    }

    /* Approves and then calls the receiving contract */
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);

        //call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesn't have to include a contract in here just for this.
        //receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)
        //it is assumed that when does this that the call *should* succeed, otherwise one would use vanilla approve instead.
        if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
        return true;
    }
    

}



