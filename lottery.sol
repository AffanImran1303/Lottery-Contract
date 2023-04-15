//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.18;

contract lottery{
    //OWNER-who runs the lottery
    address public owner;
    //PLAYERS-who will participate in the lottery
    address payable[] public players;
    //

    //At the time of deploy constructor will only run once.
    constructor()
    {
        owner=msg.sender;
    }
    //Receiving the Minimum Amount(0.1ETH) from the players.
    receive() external payable{
        require(msg.value ==0.1 ether);
        players.push(payable(msg.sender));
    } 
    //Function to get the total balance of lottery.
    function lottery_Balance() public view returns(uint)
    {   
        require(msg.sender==owner);
        return address(this).balance;
    }
    //Function to generate the random number(index) of the player list.
    function random_player_id() public view returns(uint)
    {
      return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }
    //Function to select the winner of lottery.
    function selecting_winner() public 
    {
        require(msg.sender==owner);
        require(players.length>=3);
        uint player_id = random_player_id()%players.length;
        address payable winner;
        winner = players[player_id];
        winner.transfer(lottery_Balance());
    }
}