// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RevStake {
    event Stake(address sender, uint256 value);

    mapping(address => uint) balances;

    uint deadline = block.timestamp + 1 minutes;

    function stake() public payable {
        require(msg.value > 0, "No amount passed");
        balances[msg.sender] += msg.value;

        emit Stake(msg.sender, msg.value);
    }

    function showStake() external view returns (uint) {
        return balances[msg.sender];
    }

    function withdraw() public {
        require(block.timestamp > deadline, "Maturity not reached");
        require(balances[msg.sender] > 0, "You don't have a stake");

        uint amount = balances[msg.sender];
        
        balances[msg.sender] = 0;

        payable(msg.sender).transfer(amount);
    }

    receive() external payable {
        stake();
    }

    function timeLeft() external view returns (uint) {
        return deadline - block.timestamp;
    }
}