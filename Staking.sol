// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Staking {
    event Stake(address user, uint amount);

    uint256 deadline = block.timestamp + 5 minutes;

    mapping(address => uint) balances;

    function stake(address _user) public payable {
        require(msg.value > 0, "Insuficient funds");
        balances[_user] += msg.value;
    }

    function userBalance(address _user) external view returns(uint) {
        return balances[_user];
    }

    receive() external payable {
        stake(msg.sender);
        emit Stake(msg.sender, msg.value);
    }

    function withdraw() public {
        require(deadline < block.timestamp, "Deadline exceeded");
        require(balances[msg.sender] > 0, "No stake");

        uint amount = balances[msg.sender];

        balances[msg.sender] = 0;

        payable(msg.sender).transfer(amount);
    }


    function changeDeadline(uint _time) public {
        deadline = block.timestamp + _time;
    }

    function showDeadline() external view returns (uint) {
        return deadline;
    }
}