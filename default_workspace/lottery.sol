// SPDX-License-Identifier: GPL-3.0



pragma solidity >=0.5.0 <0.9.0;

contract Lottery
{

    address public manager;
    address payable[] public participants;


    constructor () {
         
         manager = msg.sender;

    }

    receive() external payable{

   /// ether is not == to 1 it will not work
        require(msg.value==1 ether);
        participants.push(payable(msg.sender));


    }

    function getBalance() public view returns(uint){


         require(msg.sender==manager);
        return address(this).balance;

    }
     // random no.. 
    function random() public view returns(uint){

        // keccak256(abi.encodePacked(block.difficulty,block.timestamp.participants.length))

         return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants.length)));

    }

        function pickWinner() public{

        require(msg.sender == manager);
        require (participants.length >= 3);

        uint r = random();
        address payable winner;

//// selecting the participant
        uint index = r % participants.length;

        winner = participants[index];

/// transfer all the winning amount to winner
        winner.transfer(getBalance());

 /// resetting the dynamic array ==0

        participants = new address payable[](0);
    }

}
/// BUG-CODING ...HAPPY CODING....
