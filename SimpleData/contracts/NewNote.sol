// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract NewNote {
    struct user {
        string name;
        uint number;
        string addr;
    }

    mapping(string => user) public users;

    function setUser(string memory name, uint number, string memory addr) public {
        users[name] = user(name, number, addr);
    }

    function getUser(string memory name) public view returns (uint number, string memory addr) {
        return (users[name].number, users[name].addr);
    }
}
