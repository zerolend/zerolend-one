// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {PoolSetup} from './PoolSetup.sol';

contract PoolBorrowTests is PoolSetup {
  uint256 supplyAmount = 1000e18;
  address alice = address(1);

  event Supply(address indexed reserve, bytes32 indexed pos, uint256 amount);

  /// ------------Borrow------------
  function testBorrowAmountZero() external {
    vm.expectRevert(bytes('INVALID_AMOUNT'));
    pool.borrowSimple(address(tokenA), 0, 0);
  }

  function testFailBorrowZeroAssetAddress() external {
    pool.borrowSimple(address(0), 50 ether, 0);
  }

  function testBorrowWhenCollateralIsZero() external {
    vm.expectRevert(bytes('COLLATERAL_BALANCE_IS_ZERO'));
    pool.borrowSimple(address(tokenA), 50 ether, 0);
  }

  function testBorrowMoreThenCollateral() external {
    _mintAndApprove(alice, tokenA, supplyAmount, address(pool));

    vm.startPrank(alice);

    pool.supplySimple(address(tokenA), supplyAmount, 0);

    uint256 borrowAmount = supplyAmount;

    vm.expectRevert(bytes('COLLATERAL_CANNOT_COVER_NEW_BORROW'));
    pool.borrowSimple(address(tokenA), borrowAmount, 0);

    vm.stopPrank();
  }
}
