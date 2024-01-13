// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

event Mes(string indexed);

contract Messenger {
    
    string public message;
    uint public messageChanged;
    address public owner = msg.sender;

    function serMessage(string calldata  message_) public {
            require(msg.sender == owner, "You are not owner!");
            message = message_;
            messageChanged++;
            emit Mes(message_);

    }
}