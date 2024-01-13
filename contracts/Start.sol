// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract MyContract {
    bool public  myBool;
    uint public myUint;
    int public myInt;
    string public myString;
    bytes public myBytes;
    address public myAddress;

    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }
    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }
    function setMyInt(int _myInt) public {
        myInt = _myInt;
    }
    function setMyString(string memory _myString) public {
        myString = _myString;
    }
    function setMyBytes(bytes memory _myBytes) public {
        myBytes = _myBytes;
    }
    function setMyAddress(address _myAddress) public {
        myAddress = _myAddress;
    }

    function compareString(string memory secondString) public view returns (bool) {
        return keccak256(abi.encodePacked(myString)) == keccak256(abi.encodePacked(secondString));
    }

}