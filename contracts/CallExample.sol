// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Target contract
contract Target {
    uint256 public value;

    function setValue(uint256 _value) external {
        value = _value;
    }

    function getValue() external view returns (uint256) {
        return value;
    }
}

// Caller contract
contract Caller{
    Target public target;

    function setTarget(address _target) external {
        target = Target(_target);
    }

    function callUsingCall(uint256 _value) external {
        (bool success, bytes memory result) = address(target).call(abi.encodeWithSignature("setValue(uint256)", _value));
        // 'success' will be true, and 'result' will contain any returned data.
        // However, 'target.value' will not be modified in the 'Caller' contract.
    }

    function callUsingDelegateCall(uint256 _value) external {
        (bool success, bytes memory result) = address(target).delegatecall(abi.encodeWithSignature("setValue(uint256)", _value));
        // 'success' may be true, but 'result' and 'target.value' will reflect changes in the 'Caller' contract, not the 'Target' contract.
    }

    function callUsingStaticCall() external view returns (uint256) {
        (bool success, bytes memory result) = address(target).staticcall(abi.encodeWithSignature("getValue()"));
        require(success, "Static call failed");

        uint256 value;
        assembly {
            value := mload(add(result, 0x20))
        }

        return value;
        // 'success' will be true, and 'value' will contain the result from the 'getValue' function of the 'Target' contract.
        // 'target.value' and the state of the 'Caller' contract will not be modified.
    }
}

