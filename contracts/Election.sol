pragma solidity >=0.4.0 <0.7.0;

contract Election{
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }
    mapping(address => bool) public voters;

    mapping(uint => Candidate) public candidates;

    uint public candidatesCount;

    event votedEvent (
        uint indexed _candidateId
    );

   constructor() public{
      addCandidate("Candidate 1");
      addCandidate("Candidate 2");
   }

   function addCandidate(string memory _name)private{

        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);

    }
    function vote(uint _candidateId) public {
       require(!voters[msg.sender], 'voter is voted already');

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount,'please vote for a valid candidate');

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        emit votedEvent(_candidateId);
    }

}