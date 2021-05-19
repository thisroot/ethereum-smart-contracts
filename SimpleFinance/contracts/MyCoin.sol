// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract MyCoin {
    address owner;
    string name;
    string symbol;
    uint256 totalCoins;

    mapping(address => uint256) public balance;

    function Coin() public {
        owner = msg.sender;
        name = "MyCoin";
        symbol = "MYC";
        totalCoins = 1000;
        balance[owner] = totalCoins;
    }

    function totalSupply() view public returns (uint256) {
        return totalCoins;
    }

    function balanceOf(address owner) view public returns (uint256) {
        return balance[owner];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        if (balance[msg.sender] > value) {
            address from = msg.sender;
            owner = to;
            emit Transfer(from, to, value);
            balance[from] = balance[from] - value;
            balance[to] = balance[to] + value;
            return true;
        }
        return false;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
}
