// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Note {
    string public name;
    string public addr;
    uint number;

    function set(string memory newName, uint newNumber, string memory newAddress) public {
        name = newName;
        number = newNumber;
        addr = newAddress;
    }

    function get() public view returns (string memory, uint, string memory) {
        return (name, number, addr);
    }
}
