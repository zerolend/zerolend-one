// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

library TokenConfiguration {
  function getPositionId(address user, uint256 index) internal pure returns (bytes32) {
    return keccak256(abi.encodePacked(user, 'index', index));
  }
}
