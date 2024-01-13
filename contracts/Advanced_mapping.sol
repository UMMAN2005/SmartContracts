// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract MyContract {
    uint public totalDepositedMoney;
    mapping (address => uint) public myMapping;
    uint public contractBalance;

    function deposit() public payable {
        totalDepositedMoney += msg.value;
        contractBalance += msg.value;
        myMapping[msg.sender] += msg.value;
    }

    function withdrawAllDepositedMoneyByYou() public payable {
        contractBalance -= myMapping[msg.sender];
        address payable sender = payable(msg.sender);
        sender.transfer(myMapping[msg.sender]);
    }
}
