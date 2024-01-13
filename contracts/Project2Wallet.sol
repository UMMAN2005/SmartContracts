// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;


event EDeposit (uint indexed amount);
event EWithdraw(uint indexed amount);
event EWithdrawAll(bool indexed sure);

contract Wallet {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    struct Transaction {
        uint depositedAmount;
        uint withdrawedAmount;
        address from;
        address to;
    }

    mapping (address => mapping(uint idOfTransaction => Transaction)) public transactions;
    mapping (address => uint idOfTransaction) public transactionCount;

    modifier Checker(uint amount) {
        require(msg.value == amount, "The values should be equal");
        require(owner == msg.sender, "You are not the owner");
        _;
    }

    function Deposit(uint amount) public payable Checker(amount) {
        require(msg.sender.balance >= msg.value, "You cannot deposit more than what you have!");

        transactionCount[msg.sender]++;

        transactions[msg.sender][transactionCount[msg.sender]].depositedAmount = msg.value;
        transactions[msg.sender][transactionCount[msg.sender]].withdrawedAmount = 0;
        transactions[msg.sender][transactionCount[msg.sender]].from = msg.sender;
        transactions[msg.sender][transactionCount[msg.sender]].to = address(this);

        payable(address(this)).transfer(msg.value);

        emit EDeposit(msg.value);
    }


    function Withdraw(uint amount) public payable Checker(amount) {
        require(address(this).balance >= amount, "There is no such amount of money in smart contract!");
        uint totalDepositedAmount;
        for (uint i = 1; i < transactionCount[msg.sender]; i++) {
            totalDepositedAmount += transactions[msg.sender][i].depositedAmount;
        }
        require(amount <= totalDepositedAmount, "You cannot withdraw more than what you deposited!");
        transactionCount[msg.sender]++;
        transactions[msg.sender][transactionCount[msg.sender]].depositedAmount = 0;
        transactions[msg.sender][transactionCount[msg.sender]].withdrawedAmount = amount;
        transactions[msg.sender][transactionCount[msg.sender]].from = address(this);
        transactions[msg.sender][transactionCount[msg.sender]].to = msg.sender;
        payable(msg.sender).transfer(amount);
        emit EWithdraw(amount);
    }

    function WidhtrawAll(bool sure) public payable {
        require(owner == msg.sender, "You are not the owner");
        require(sure, "You should be sure about this!");
        uint totalDepositedAmount;
        for (uint i = 1; i < transactionCount[msg.sender]; i++) {
            totalDepositedAmount += transactions[msg.sender][i].depositedAmount;
        }
        transactionCount[msg.sender]++;
        transactions[msg.sender][transactionCount[msg.sender]].depositedAmount = 0;
        transactions[msg.sender][transactionCount[msg.sender]].withdrawedAmount = totalDepositedAmount;
        transactions[msg.sender][transactionCount[msg.sender]].from = address(this);
        transactions[msg.sender][transactionCount[msg.sender]].to = msg.sender;
        payable(msg.sender).transfer(address(this).balance);
        emit EWithdrawAll(sure);
    }

    receive() external payable {}

    fallback() external payable {}
}