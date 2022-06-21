//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;
contract ERC20 {
    string public name ;
    string public symbol ;
    uint256 public supply ;
    
    mapping(address=>uint256) public balances ;

    constructor(string memory _name, string memory _symbol) {
        _name = name ;
        _symbol = symbol ;
    }

    function decimals() external pure returns (uint8) {
        return 18;
    }

    function mint() public payable returns (bool) {
        require(msg.sender != address(0) , "Recipient Address Invalid");
        require(supply > 0 , "No More Token Can Be Minted");
        balances[msg.sender] += msg.value ;
        supply -= msg.value ;
        return true ;
    }

    function transfer(address from, address to, uint256 amount) external returns (bool) {
        uint256 inwallet = balances[from] ;
        require(inwallet >= amount , "Insufficient Funds");
        require(msg.sender == from, "Access Denied");
        balances[from] = inwallet - amount ;
        balances[to] += amount ;
        return true;
    }
}