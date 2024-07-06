// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {PoolSetup} from './PoolSetup.sol';

contract PoolRepayTests is PoolSetup {
  /// ------------Repay------------
  function testRepayAmountZero() external {
    vm.expectRevert(bytes('INVALID_AMOUNT'));
    pool.repaySimple(address(tokenA), 0, 0);
  }

  function testFailRepayZeroAssetAddress() external {
    pool.repaySimple(address(0), 50 ether, 0);
  }
}
