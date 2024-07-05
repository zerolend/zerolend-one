// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {IPool} from '../../contracts/interfaces/IPool.sol';
import {Pool, PoolFactoryTest} from './Core.t.sol';

import {DataTypes} from '../../contracts/core/pool/configuration/DataTypes.sol';

contract PoolSetup is PoolFactoryTest {
  DataTypes.InitPoolParams internal inputParams;
  DataTypes.InitReserveConfig internal basicConfig;
  DataTypes.InitReserveConfig[] configurations;

  Pool public pool;

  function setUp() public {
    config_factory();
    DataTypes.InitReserveConfig memory basicConfigLocal = DataTypes.InitReserveConfig({
      ltv: 7500,
      liquidationThreshold: 8000,
      liquidationBonus: 10_500,
      decimals: 18,
      frozen: false,
      borrowable: true,
      borrowCap: 0,
      supplyCap: 0
    });

    address[] memory assets = new address[](3);
    assets[0] = address(tokenA);
    assets[1] = address(tokenB);
    assets[2] = address(tokenC);

    address[] memory rateStrategyAddresses = new address[](3);
    rateStrategyAddresses[0] = address(irStrategy);
    rateStrategyAddresses[1] = address(irStrategy);
    rateStrategyAddresses[2] = address(irStrategy);

    address[] memory sources = new address[](3);
    sources[0] = address(oracleA);
    sources[1] = address(oracleB);
    sources[2] = address(oracleC);

    DataTypes.InitReserveConfig[] memory configurationLocal = new DataTypes.InitReserveConfig[](3);
    configurationLocal[0] = basicConfigLocal;
    configurationLocal[1] = basicConfigLocal;
    configurationLocal[2] = basicConfigLocal;

    DataTypes.InitPoolParams memory inputParamsLocal = DataTypes.InitPoolParams({
      hook: address(0),
      assets: assets,
      rateStrategyAddresses: rateStrategyAddresses,
      sources: sources,
      configurations: configurationLocal
    });

    poolFactory.createPool(inputParamsLocal);

    IPool poolAddr = poolFactory.pools(0);

    pool = Pool(address(poolAddr));
  }

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
