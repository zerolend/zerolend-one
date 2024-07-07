// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

// ███████╗███████╗██████╗  ██████╗
// ╚══███╔╝██╔════╝██╔══██╗██╔═══██╗
//   ███╔╝ █████╗  ██████╔╝██║   ██║
//  ███╔╝  ██╔══╝  ██╔══██╗██║   ██║
// ███████╗███████╗██║  ██║╚██████╔╝
// ╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝

// Website: https://zerolend.xyz
// Discord: https://discord.gg/zerolend
// Twitter: https://twitter.com/zerolendxyz
// Telegram: https://t.me/zerolendxyz

import {ReserveConfiguration} from '../../core/pool/configuration/ReserveConfiguration.sol';
import {IPoolFactory} from '../../interfaces/IPoolFactory.sol';

import {IAggregatorInterface} from '../../interfaces/IAggregatorInterface.sol';
import {IPoolManager} from '../../interfaces/IPoolManager.sol';
import {IRevokableBeaconProxy} from '../../interfaces/IRevokableBeaconProxy.sol';
import {DataTypes, IPool} from '../../interfaces/pool/IPool.sol';
import {IERC20Metadata} from '@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract UIHelper {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  IPoolFactory public factory;
  IPoolManager public manager;

  struct ReserveConfig {
    address asset;
    address interestRateStrategy;
    address oracle;
    bool borrowable;
    bool frozen;
    string name;
    string symbol;
    uint256 borrowCap;
    uint256 decimals;
    uint256 liquidationBonus;
    uint256 liquidationThreshold;
    uint256 ltv;
    uint256 supplyCap;
    uint256 balanceOnchain;
    uint256 totalSupplyOnchain;
    uint128 liquidityIndex;
    uint128 liquidityRate;
    uint128 borrowIndex;
    uint128 borrowRate;
    uint40 reserveLastUpdateTimestamp;
    uint256 debtShares;
    uint256 supplyShares;
    uint128 underlyingBalance;
    uint256 debtAssets;
    uint256 supplyAssets;
    uint256 latestPrice;
  }

  struct PoolConfig {
    address hook;
    address proxyAdmin;
    address[] emergencyAdmins;
    address[] poolAdmins;
    address[] riskAdmins;
    bool proxyRevoked;
    ReserveConfig[] reserves;
    uint16 reservesCount;
  }

  constructor(address _factory, address _manager) {
    factory = IPoolFactory(_factory);
    manager = IPoolManager(_manager);
  }

  function getPoolAssetConfig(IPool pool, address asset) public view returns (ReserveConfig memory config) {
    DataTypes.ReserveConfigurationMap memory configRaw = pool.getConfiguration(asset);
    DataTypes.ReserveData memory data = pool.getReserveData(asset);
    DataTypes.ReserveSupplies memory supplies = pool.getTotalSupplyRaw(asset);

    config.borrowable = configRaw.getBorrowingEnabled();
    config.frozen = configRaw.getFrozen();
    config.borrowCap = configRaw.getBorrowCap();
    config.decimals = configRaw.getDecimals();
    config.liquidationBonus = configRaw.getLiquidationBonus();
    config.liquidationThreshold = configRaw.getLiquidationThreshold();
    config.ltv = configRaw.getLtv();
    config.supplyCap = configRaw.getSupplyCap();

    config.name = IERC20Metadata(asset).name();
    config.symbol = IERC20Metadata(asset).symbol();
    config.balanceOnchain = IERC20(asset).balanceOf(address(pool));
    config.totalSupplyOnchain = IERC20(asset).totalSupply();

    config.liquidityIndex = data.liquidityIndex;
    config.liquidityRate = data.liquidityRate;
    config.borrowIndex = data.borrowIndex;
    config.borrowRate = data.borrowRate;

    config.debtShares = supplies.debtShares;
    config.debtAssets = pool.totalDebt(asset);
    config.supplyShares = supplies.supplyShares;
    config.supplyAssets = pool.totalAssets(asset);
    config.underlyingBalance = supplies.underlyingBalance;

    config.asset = asset;
    config.interestRateStrategy = data.interestRateStrategyAddress;
    config.oracle = data.oracle;

    config.latestPrice = uint256(IAggregatorInterface(data.oracle).latestAnswer());
  }

  function getPoolFullConfigByIndex(uint256 start, uint256 end) public view returns (PoolConfig[] memory configs) {
    uint256 count = factory.poolsLength();
    if (end > count) end = count;
    if (start >= end) return configs;

    configs = new PoolConfig[](end - start);
    for (uint256 i = start; i < end; i++) {
      IPool pool = factory.pools(i);
      configs[i - start] = getPoolFullConfig(pool);
    }
  }

  function getPoolFullConfig(IPool pool) public view returns (PoolConfig memory config) {
    address[] memory reserves = pool.getReservesList();
    IRevokableBeaconProxy proxy = IRevokableBeaconProxy(address(pool));

    config.hook = address(pool.getHook());
    config.reservesCount = uint16(reserves.length);
    config.reserves = new ReserveConfig[](reserves.length);

    for (uint256 i = 0; i < reserves.length; i++) {
      config.reserves[i] = getPoolAssetConfig(pool, reserves[i]);
    }

    // details about the pool as a proxy
    config.proxyAdmin = proxy.admin();
    config.proxyRevoked = proxy.isBeaconRevoked();

    // find all the admins and send it back
    config.poolAdmins = getAllRoles(pool, manager, manager.POOL_ADMIN_ROLE());
    config.emergencyAdmins = getAllRoles(pool, manager, manager.EMERGENCY_ADMIN_ROLE());
    config.riskAdmins = getAllRoles(pool, manager, manager.RISK_ADMIN_ROLE());
  }

  function getAllRoles(IPool _pool, IPoolManager _manager, bytes32 role) public view returns (address[] memory users) {
    bytes32 poolRole = manager.getRoleFromPool(_pool, role);
    uint256 count = _manager.getRoleMemberCount(poolRole);
    users = new address[](count);
    for (uint256 i = 0; i < count; i++) {
      users[i] = _manager.getRoleMember(poolRole, i);
    }
  }
}
