// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract MyContract {
    string public myData = "Hello World";

    function setString(string memory _myData) public payable  {
        if (msg.value == 1 ether) {
        myData = _myData;
        } else {
            payable(msg.sender).transfer(msg.value);
        }
    }
}