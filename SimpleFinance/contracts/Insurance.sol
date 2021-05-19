// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Insurance {
    address payable public hospital;
    address payable public insurer;

    struct Record {
        address Addr;
        uint256 ID;
        string Name;
        string Date;
        uint256 Price;
        bool IsValue;
        uint256 SignatureCount;
        mapping (address => uint256) Signatures;
    }

    modifier signOnly {
        require(msg.sender == hospital || msg.sender == insurer);
        _;
    }
    constructor() public {
        hospital = 0xbB7aB87291f68A8E6fF6B496Ab02dA61639D83bB;
        insurer = 0x35f7b221036150D93B6cE90D8302aE3Ea5a099CE;
    }

    mapping(uint256 => Record) public allRecords;
    uint256 [] public recordsArr;

    event recordCreated(uint256 ID, string testName, string Date, uint256 Price);
    event recordSigned(uint256 ID, string testName, string Date, uint256 Price);

    function newRecord (uint256 ID, string memory Name, string memory Date, uint256 Price) public {
        Record storage newrecord = allRecords[ID];
        require(!allRecords[ID].IsValue);
        newrecord.Addr = msg.sender;
        newrecord.ID = ID;
        newrecord.Name = Name;
        newrecord.Date = Date;
        newrecord.Price = Price;
        newrecord.IsValue = true;
        newrecord.SignatureCount = 0;
        recordsArr.push(ID);
        emit recordCreated(newrecord.ID, Name, Date, Price);
    }
    function signRecord(uint256 ID) signOnly public payable {
        Record storage records = allRecords[ID];
        require(records.Signatures[msg.sender] != 1);
        records.Signatures[msg.sender] = 1;
        records.SignatureCount++;
        emit recordSigned(records.ID, records.Name, records.Date, records.Price);
        if(records.SignatureCount == 2) {
            hospital.transfer(address(this).balance);
        }
    }
}
