// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Dice {

    address public manager;
    address payable[] public players;

    modifier onlyManager() {
        require(manager == msg.sender, "Permission denied");
        _;
    }

    constructor() public {
        manager = msg.sender;
    }

    function CEO() public {
        manager = msg.sender;
    }

    function Enter() public payable {
        require(msg.value > .001 ether, "Dice is low!");
        players.push(msg.sender);
    }

    function getRandomNumber(uint number) private view returns (uint) {
        uint brosok = uint(keccak256(abi.encodePacked(now, msg.sender, number))) % 10;
        brosok = brosok + 2;
        return (brosok);
    }

    function Winner() public payable restricted returns (string memory, uint, uint) {
        uint player1 = getRandomNumber(0);
        uint player2 = getRandomNumber(1);
        if (player1 > player2) {
            players[0].transfer(address(this).balance);
            return ("1 player is Winner", player1, player2);
        }
        else if (player1 < player2) {
            players[1].transfer(address(this).balance);
            return ("2 player is Winner", player1, player2);
        }
        else return ("Nobody winners", player1, player2);
    }

    modifier restricted() {
        require(msg.sender == manager, "Permission denied");
        _;
    }
}
