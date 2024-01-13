// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract SmartMoney {
    uint public balance;
    uint public perventage = 100;

    function depozit() public payable {
        balance += msg.value;
    }

    function getBalanceValue() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawAll() public payable {
        address payable to = payable(msg.sender);
        to.transfer(getBalanceValue());
    }

    function withdrawToOther(address payable to) public payable {
        to.transfer(getBalanceValue());
    }

    function setPercentage(uint _percentage) public payable {
        perventage = _percentage;
    }

    function withdrawPercentageToAddress(address payable to) public payable {
        to.transfer(getBalanceValue() * 100 / perventage);
    }
}