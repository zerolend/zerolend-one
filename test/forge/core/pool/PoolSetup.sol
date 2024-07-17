// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {DataTypes} from '../../../../contracts/core/pool/configuration/DataTypes.sol';
import {IPool} from '../../../../contracts/interfaces/pool/IPool.sol';
import './CorePoolTests.sol';

abstract contract PoolSetup is CorePoolTests {
  IPool internal pool;

  function setUp() public virtual override {
    super.setUp();

    poolFactory.createPool(_basicPoolInitParams());

    IPool poolAddr = poolFactory.pools(0);

    pool = IPool(address(poolAddr));
  }

  function _basicPoolInitParams() internal view returns (DataTypes.InitPoolParams memory p) {
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

    DataTypes.InitReserveConfig memory config = _basicConfig();

    DataTypes.InitReserveConfig[] memory configurationLocal = new DataTypes.InitReserveConfig[](3);
    configurationLocal[0] = config;
    configurationLocal[1] = config;
    configurationLocal[2] = config;

    address[] memory admins = new address[](1);
    admins[0] = address(this);

    p = DataTypes.InitPoolParams({
      proxyAdmin: address(this),
      revokeProxy: false,
      admins: admins,
      emergencyAdmins: new address[](0),
      riskAdmins: new address[](0),
      hook: address(0),
      assets: assets,
      rateStrategyAddresses: rateStrategyAddresses,
      sources: sources,
      configurations: configurationLocal
    });
  }

  function _basicConfig() internal pure returns (DataTypes.InitReserveConfig memory c) {
    c = DataTypes.InitReserveConfig({
      ltv: 7500,
      liquidationThreshold: 8000,
      liquidationBonus: 10_500,
      decimals: 18,
      frozen: false,
      borrowable: true,
      borrowCap: 0,
      supplyCap: 0
    });
  }

  function _mintAndApprove(address user, MintableERC20 token, uint256 amount, address toApprove) public {
    vm.startPrank(user);
    token.mint(user, amount);
    token.approve(toApprove, amount);
    vm.stopPrank();
  }
}
