// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Greetings {
    string greetings = "Hello world";

    function greet() public view returns (string memory) {
        return greetings;
    }

    function setGreetings(string memory _greetings) public returns (bool) {
        greetings = _greetings;
        return true;
    }
}
