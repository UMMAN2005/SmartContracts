// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract B {
}

contract A {
    function f(uint value) public pure returns (uint out) {
        out = value;
    }

    function f(address value) public pure returns (address out) {
        out = value;
    }
}
