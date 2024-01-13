//SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

contract Consumer {

    address payable public owner;

    constructor() {
        owner = payable (msg.sender);
    }

    function getMoneyToContract() public payable {
        payable(address(this)).transfer(msg.value);
    }

    function withdrawMoney(uint amount) public payable {
        require(amount <= address(this).balance, "Balance is not enough!");
        payable(msg.sender).transfer(amount);
    }

}

contract SampleWallet {

    address payable public owner;

    mapping(address => mapping(address => bool)) public guardianVoted;
    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;
    mapping(address => bool) public guardians;

    address payable nextOwner;
    uint guardiansResetCount;
    uint public constant confirmationsFromGuardiansForReset = 3;

    constructor() {
        owner = payable(msg.sender);
    }

    function setGuardian(address guardianAddress) public{
        require(owner == msg.sender, "You are not allowed!");
        guardians[guardianAddress] = false;
    }

    function proposeNewOwner(address payable newOwner) public {
        require(guardians[msg.sender], "You are no guardian, aborting!");
        require(guardianVoted[newOwner][msg.sender] = false, "You already have been voted!");
        if(nextOwner != newOwner) {
            nextOwner = newOwner;
            guardiansResetCount = 0;
        }

        guardiansResetCount++;

        if(guardiansResetCount >= confirmationsFromGuardiansForReset) {
            owner = nextOwner;
            nextOwner = payable(address(0));
        }
    }

    function setAllowance(address _from, uint _amount) public {
        require(msg.sender == owner, "You are not the owner, aborting!");
        allowance[_from] = _amount;
        isAllowedToSend[_from] = true;
    }

    function denySending(address _from) public {
        require(msg.sender == owner, "You are not the owner, aborting!");
        isAllowedToSend[_from] = false;
    }

    function transfer(address payable _to, uint _amount, bytes memory payload) public returns (bytes memory) {
        require(_amount <= address(this).balance, "Can't send more than the contract owns, aborting.");
        if(msg.sender != owner) {
            require(isAllowedToSend[msg.sender], "You are not allowed to send any transactions, aborting");
            require(allowance[msg.sender] >= _amount, "You are trying to send more than you are allowed to, aborting");
            allowance[msg.sender] -= _amount;
        }

        (bool success, bytes memory returnData) = _to.call{value: _amount}(payload);
        require(success, "Transaction failed, aborting");
        return returnData;
    }

    receive() external payable {}
}