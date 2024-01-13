// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract ExampleMapping {
    
    mapping (uint => uint) public myMap;
    mapping (uint => mapping (int => string)) public doubleMap;

    function setValue(uint _index, uint _value) public {
        myMap[_index] = _value;
    }

    function setDoubleMap(uint _key1, int _key2, string memory _value) public {
        doubleMap[_key1][_key2] = _value;
    }
}