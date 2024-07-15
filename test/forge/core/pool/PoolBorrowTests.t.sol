// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {DataTypes} from './../../../../contracts/core/pool/configuration/DataTypes.sol';
import {UserConfiguration} from './../../../../contracts/core/pool/configuration/UserConfiguration.sol';
import {IPool, PoolEventsLib, PoolSetup} from './PoolSetup.sol';

contract PoolBorrowTests is PoolSetup {
  using UserConfiguration for DataTypes.UserConfigurationMap;

  address alice = address(1);
  address bob = address(2);

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
    uint256 mintAmount = 1000 ether;
    uint256 supplyAmount = 100 ether;
    _mintAndApprove(alice, tokenA, mintAmount, address(pool));

    vm.startPrank(alice);

    pool.supplySimple(address(tokenA), supplyAmount, 0);

    uint256 borrowAmount = supplyAmount;

    vm.expectRevert(bytes('COLLATERAL_CANNOT_COVER_NEW_BORROW'));
    pool.borrowSimple(address(tokenA), borrowAmount, 0);

    vm.stopPrank();
  }

  function testBorrowWhenReserveFrozen() external {
    configurator.setReserveFreeze(IPool(address(pool)), address(tokenA), true);

    vm.startPrank(address(1));
    tokenA.mint(address(1), 1e18);
    tokenA.approve(address(pool), 1e18);

    vm.expectRevert(bytes('RESERVE_FROZEN'));
    pool.borrowSimple(address(tokenA), 1e18, 0);
  }

  function testBorrowCapExceed() external {
    configurator.setBorrowCap(IPool(address(pool)), address(tokenA), 100);

    vm.startPrank(address(1));
    tokenA.mint(address(1), 1e18);
    tokenA.approve(address(pool), 1e18);

    vm.expectRevert(bytes('BORROW_CAP_EXCEEDED'));
    pool.borrowSimple(address(tokenA), 101e18, 0);
  }

  function testBorrowNotEnabled() external {
    configurator.setReserveBorrowing(IPool(address(pool)), address(tokenB), false);
    vm.startPrank(address(1));
    tokenB.mint(address(1), 2e18);
    tokenB.approve(address(pool), 2e18);

    vm.expectRevert(bytes('BORROWING_NOT_ENABLED'));
    pool.borrowSimple(address(tokenB), 2e18, 0);
  }

  function testBorrowEventEmit() external {
    bytes32 pos = keccak256(abi.encodePacked(alice, 'index', uint256(0)));
    uint256 mintAmount = 1000 ether;
    uint256 borrowAmount = 10 ether;

    _mintAndApprove(alice, tokenA, mintAmount, address(pool));
    _mintAndApprove(bob, tokenB, mintAmount, address(pool));

    vm.startPrank(bob);
    pool.supplySimple(address(tokenB), mintAmount, 0);
    vm.stopPrank();

    vm.startPrank(alice);
    pool.supplySimple(address(tokenA), mintAmount, 0);

    DataTypes.ReserveData memory data = pool.getReserveData(address(tokenA));
    vm.expectEmit(true, true, true, false);
    emit PoolEventsLib.Borrow(address(tokenB), address(alice), pos, borrowAmount, data.borrowRate);

    pool.borrowSimple(address(tokenB), borrowAmount, 0);
    assertEq(tokenB.balanceOf(address(pool)), mintAmount - borrowAmount);
    assertEq(pool.getDebt(address(tokenB), address(alice), 0), borrowAmount);
    assertEq(pool.totalDebt(address(tokenB)), borrowAmount);

    vm.stopPrank();
  }
}
