// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {PoolSetup} from './PoolSetup.sol';

contract PoolBasicTests is PoolSetup {
  function testPoolFactoryLength() external view {
    assertEq(poolFactory.poolsLength(), 1);
  }

  function testReserveList() external view {
    address[] memory reserveList = pool.getReservesList();
    assertEq(reserveList[0], address(tokenA));
    assertEq(reserveList[1], address(tokenB));
    assertEq(reserveList[2], address(tokenC));
  }
}
