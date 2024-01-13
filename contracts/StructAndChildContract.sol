// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Wallet1 {
    ChildContractPayment public payment1;

    function setPayment1() public payable {
        payment1 = new ChildContractPayment(msg.sender, msg.value);
    }
}

contract ChildContractPayment {
    address public from;
    uint public value;

    constructor(address _from, uint _value) {
        from = _from;
        value = _value;
    }
}

contract Wallet2 {
    struct StructPayment {
        address from;
        uint value;
    }

    StructPayment public payment2;

    function setPayment() public payable {
        //payment2 = StructPayment(msg.sender, msg.value);
        payment2.from = msg.sender;
        payment2.value = msg.value;
    }
}
