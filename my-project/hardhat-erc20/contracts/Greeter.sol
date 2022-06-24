//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;
contract ERC20 {
    string public name ;
    string public symbol ;
    uint256 public supply;
    
    mapping(address=>uint256) public balances ;
    mapping(address=>mapping(address=>uint256)) public allowances;

    constructor(string memory _name, string memory _symbol , uint256 _supply) {
        _name = name ;
        _symbol = symbol ;
        _supply = supply ;
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

    function transfer(address _to, uint256 value) external returns(bool) {
        return transfertemplate(msg.sender,_to,value);
    }

    function approve(address receiver, uint256 _Amount ) external returns (bool) {
        require(balances[msg.sender] >= _Amount , "Insufficienct funds") ;
        allowances[msg.sender][receiver] = _Amount ;
        return true;
    }

    function transferfrom(address _sender , address _receiver , uint256 _amount) external returns (bool) {
        require(allowances[_sender][msg.sender] >= _amount , "Allowances Limit Reached") ;
        uint256 currentallowances = allowances[_sender][_receiver]; 
        allowances[_sender][_receiver] = currentallowances - _amount ;
        return transfertemplate(_sender,_receiver,_amount); 
    }

    function transfertemplate(address from, address to, uint256 amount) private returns (bool) {
        uint256 inwallet = balances[from] ;
        require(inwallet >= amount , "Insufficient Funds");
        balances[from] = inwallet - amount ;
        balances[to] += amount ;
        return true;
    }
}