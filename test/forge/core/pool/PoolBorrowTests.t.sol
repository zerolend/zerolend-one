// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {PoolSetup} from './PoolSetup.sol';

contract PoolBorrowTests is PoolSetup {
  event Supply(address indexed reserve, bytes32 indexed pos, uint256 amount);

  /// ------------Borrow------------
  function testBorrowAmountZero() external {
    vm.expectRevert(bytes('INVALID_AMOUNT'));
    pool.borrowSimple(address(tokenA), 0, 0);
  }

  function testFailBorrowZeroAssetAddress() external {
    pool.borrowSimple(address(0), 50 ether, 0);
  }
}
