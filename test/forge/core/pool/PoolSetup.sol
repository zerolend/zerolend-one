// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {IPool} from '../../../../contracts/interfaces/IPool.sol';
import {CorePoolTests} from './CorePoolTests.sol';
import {DataTypes} from '../../../../contracts/core/pool/configuration/DataTypes.sol';

abstract contract PoolSetup is CorePoolTests {
  DataTypes.InitPoolParams internal basicPoolInitParams;
  DataTypes.InitReserveConfig internal basicConfig;
  IPool internal pool;

  function setUp() public virtual override {
    super.setUp();
    basicConfig = DataTypes.InitReserveConfig({
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
    configurationLocal[0] = basicConfig;
    configurationLocal[1] = basicConfig;
    configurationLocal[2] = basicConfig;

    basicPoolInitParams = DataTypes.InitPoolParams({
      hook: address(0),
      assets: assets,
      rateStrategyAddresses: rateStrategyAddresses,
      sources: sources,
      configurations: configurationLocal
    });

    poolFactory.createPool(basicPoolInitParams);

    IPool poolAddr = poolFactory.pools(0);

    pool = IPool(address(poolAddr));
  }
}
