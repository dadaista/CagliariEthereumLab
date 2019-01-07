pragma solidity 0.4.25;


contract RSVP{
    mapping (address => bool) public bookings;
    address public owner;
    uint N=3;
    bytes32 [] unlockCodesHashes = new bytes32[](N);
    uint RESERVATION = 0;
    uint UNLOCKING = 1;
    uint state=RESERVATION;
    


    constructor() public{
        owner = msg.sender;
        unlockCodesHashes[0] = 0xA2242EAD55C94C3DEB7CF2340BFEF9D5BCACA22DFE66E646745EE4371C633FC8;//pippo
        unlockCodesHashes[1] = 0xC48B4DF565B0C96F84FEDF18F26596ED40AA9F46F11021AF7125D34D1D3ACFFE;//pluto
        unlockCodesHashes[2] = 0xF106E246ECDAB88CB2262780F60079651AEAA6A3C8F5B1E75FC2AB0582CD3F67;//paperino
    }
    
    function reserveSeat() payable public{
        require(state == RESERVATION);
        require(msg.value == 0.03 ether);
        require(bookings[msg.sender] == false);
        bookings[msg.sender] = true;
    } 
    
    function () payable public{
        reserveSeat();
    }
    
    function unlockStake(string code) public {
        require(state == UNLOCKING);
        require(bookings[msg.sender] == true);
        for(uint i=0;i<N;i++){
            if(sha256(code) == unlockCodesHashes[i]) {
                unlockCodesHashes[i]=0;
                msg.sender.transfer(0.03 ether);
            }
        }
        
        
    }
    
    function stopRSVP(){
        require(msg.sender == owner);
        state = UNLOCKING;
    }
    
    function close() public{
        require(msg.sender == owner);
        selfdestruct(owner);
    }
    
}
