//SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

contract MappingsStructExample {

    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numDeposits;
        uint numWithdrawals;
        mapping(uint => Transaction) deposits;
        mapping(uint => Transaction) withdrawals;
    }

    mapping(address => Balance) public balanceReceived;


    function getBalance(address _addr) public view returns(uint) {
        return balanceReceived[_addr].totalBalance;
    }

    function depositMoney() public payable {
        balanceReceived[msg.sender].totalBalance += msg.value;

        Transaction memory deposit = Transaction(msg.value, block.timestamp);
        balanceReceived[msg.sender].deposits[balanceReceived[msg.sender].numDeposits] = deposit;
        balanceReceived[msg.sender].numDeposits++;
    }

    function withdrawMoney(address payable _to, uint _amount) public payable {
        balanceReceived[msg.sender].totalBalance -= _amount;

        Transaction memory withdrawal = Transaction(msg.value, block.timestamp);
        balanceReceived[msg.sender].withdrawals[balanceReceived[msg.sender].numWithdrawals] = withdrawal;
        balanceReceived[msg.sender].numWithdrawals++;

        _to.transfer(_amount);
    }
}