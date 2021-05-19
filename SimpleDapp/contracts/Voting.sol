// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Voting {
    mapping(bytes32 => uint256) public votesReceived;
    bytes32 [] public candidateList;

    constructor(bytes32[] memory candidateNames) public {
        candidateList = candidateNames;
    }

    function tatalVotesFor(bytes32 candidate) view public returns (uint256) {
        require(validCandidate(candidate), "Candidate not exist");
        return votesReceived[candidate];
    }

    function voteForCandidate(bytes32 candidate) public {
        require(validCandidate(candidate), "Candidate not exist");
        votesReceived[candidate]++;
    }

    function validCandidate(bytes32 candidate) view public returns (bool) {
        for (uint i = 0; i < candidateList.length; i++) {
            if (candidateList[i] == candidate) {
                return true;
            }
        }
        return false;
    }
}
