// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract VendingMachine {

    address public owner;
    uint public donutPrice;
    mapping (address => uint) public donutBalances;

    constructor(uint price) {
        owner = msg.sender;
        donutPrice = price * 1 ether;
        donutBalances[address(this)] = 100;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;  
    }

    function getVendingMachineBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }

    function setDonutPrice(uint price) public onlyOwner {
        donutPrice = price;
    }

    function callbackDonuts() public onlyOwner {
        donutBalances[address(this)] = 0;
    }

    function restock(uint amount) public onlyOwner {
        donutBalances[address(this)] += amount;
    }

    function purchase() public payable {
        uint buyedDonutCount = msg.value / donutPrice;
        require(donutBalances[address(this)] >= buyedDonutCount, "Not enough donuts in stock to complete this purchase");
        donutBalances[address(this)] -= buyedDonutCount;
        donutBalances[msg.sender] += buyedDonutCount;
        // Return additional funds back.
        payable(msg.sender).transfer(msg.value - buyedDonutCount * donutPrice);
    }
}