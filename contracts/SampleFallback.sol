// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract SampleFallback {

    uint public lastValueSent;

    string public lastFunctionCalled;

    address public lastUserCalled;

    uint public myUint;

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    receive() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
        lastUserCalled = msg.sender;
    }

    fallback() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "fallback";
        lastUserCalled = msg.sender;
    }

}