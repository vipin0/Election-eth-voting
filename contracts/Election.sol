pragma solidity ^0.5.11;


contract Election{
 
   uint public candidatesCount = 0;

    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    constructor ()public{
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }
    //uint public candidatesCount;

    event votedEvent (
        uint indexed _candidateId
    );

    mapping(uint => Candidate) public candidates;

    function addCandidate(string memory _name) private{
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount,_name,0);
    }

    mapping(address => bool) public voters;

    function vote(uint _candidateId) public{
        require(!voters[msg.sender],"Already Voted");

        require(_candidateId > 0 && _candidateId <= candidatesCount,"Invalid Candidate Id");

        voters[msg.sender] = true;

        candidates[_candidateId].voteCount++;

       emit votedEvent(_candidateId);
    }

    
}