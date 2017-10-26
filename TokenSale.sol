pragma solidity ^0.4.0;

contract TokenSale {
    address owner;
    mapping (address => uint256) balances;

    event Payment(uint256 _payment);

    function TokenSale() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if(msg.sender != owner) {
            revert();
        }
        _;
    }

    function buyTokens() internal {
        balances[msg.sender] += msg.value;
    }

    function getBalance() public constant returns (uint256) {
        return balances[msg.sender];
    }

    function sendMoney(address _dst, uint256 _amount) public onlyOwner {
        _dst.transfer(_amount);
        balances[_dst] -= _amount;
        Payment(_amount); // event emitted
    }

    function () public payable {
        buyTokens();
    }

}