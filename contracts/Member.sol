// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Members {
    // Transfer
    function transfer(address payable transferAddress) public payable {
        transferAddress.transfer(msg.value);
    }

    // Send
    function send(address payable sendAddress) public payable {
        bool success = sendAddress.send(msg.value);
        require(success, "Failed to send Ether");
    }

    // Call
    function callAddress(address payable addr, string memory word) public payable {

        // Encode the function signature and parameters
        bytes memory payload = abi.encodeWithSignature("sayWord(string)", word);

        // Use the 'call' function to interact with the contract
        (bool success, bytes memory data) = addr.call{value: msg.value}(payload);
        require(success, string(data));
    }

}

contract Call {
    string public returned;
    uint public balance;

    // Mark the function as payable to receive Ether
    receive() external payable {}

    // Mark the function as payable to receive Ether
    function sayWord(string memory givenWord) public payable {
        returned = givenWord;
        balance += msg.value;
    }
}
