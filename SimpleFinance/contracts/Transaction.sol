// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Transaction {

    address public owner;
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);

    constructor() public {
        owner = msg.sender;
    }

    function coin(address receiver, uint amount) public {
        require(msg.sender == owner, "Permission denied");
        require(amount < 1e60, "Amount is much");
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Not enough balance");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
