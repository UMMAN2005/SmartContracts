// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract LowLevel {
    uint public balance;

    receive() external payable {
        balance += msg.value;
    }

    fallback() external payable {
        balance += msg.value;
        
    }
}