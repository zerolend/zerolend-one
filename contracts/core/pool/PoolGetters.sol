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

import {IAggregatorInterface} from '../../interfaces/IAggregatorInterface.sol';
import {IHook, IPool, IPoolFactory} from '../../interfaces/IPool.sol';

import {PoolStorage} from './PoolStorage.sol';
import {DataTypes} from './configuration/DataTypes.sol';
import {PositionBalanceConfiguration} from './configuration/PositionBalanceConfiguration.sol';
import {ReserveSuppliesConfiguration} from './configuration/ReserveSuppliesConfiguration.sol';

import {TokenConfiguration} from './configuration/TokenConfiguration.sol';
import {PoolLogic} from './logic/PoolLogic.sol';
import {ReserveLogic} from './logic/ReserveLogic.sol';

abstract contract PoolGetters is PoolStorage, IPool {
  using ReserveLogic for DataTypes.ReserveData;
  using TokenConfiguration for address;
  using ReserveSuppliesConfiguration for DataTypes.ReserveSupplies;
  using PositionBalanceConfiguration for DataTypes.PositionBalance;

  /// @inheritdoc IPool
  function getReserveData(address asset) external view virtual override returns (DataTypes.ReserveData memory) {
    return _reserves[asset];
  }

  /// @inheritdoc IPool
  function getBalanceByPosition(address asset, bytes32 positionId) external view returns (uint256 balance) {
    return _balances[asset][positionId].getSupplyBalance(_reserves[asset].liquidityIndex);
  }

  /// @inheritdoc IPool
  function getHook() external view returns (IHook) {
    return _hook;
  }

  /// @inheritdoc IPool
  function getBalance(address asset, address who, uint256 index) external view returns (uint256 balance) {
    bytes32 positionId = who.getPositionId(index);
    return _balances[asset][positionId].getSupplyBalance(_reserves[asset].liquidityIndex);
  }

  /// @inheritdoc IPool
  function getBalanceRawByPositionId(address asset, bytes32 positionId) external view returns (DataTypes.PositionBalance memory) {
    return _balances[asset][positionId];
  }

  /// @inheritdoc IPool
  function getBalanceRaw(address asset, address who, uint256 index) external view returns (DataTypes.PositionBalance memory) {
    bytes32 positionId = who.getPositionId(index);
    return _balances[asset][positionId];
  }

  /// @inheritdoc IPool
  function getTotalSupplyRaw(address asset) external view returns (DataTypes.ReserveSupplies memory) {
    return _totalSupplies[asset];
  }

  //// @inheritdoc IPool
  function totalAssets(address asset) external view returns (uint256 balance) {
    balance = _totalSupplies[asset].getSupplyBalance(_reserves[asset].liquidityIndex);
  }

  //// @inheritdoc IPool
  function totalDebt(address asset) external view returns (uint256 balance) {
    balance = _totalSupplies[asset].getDebtBalance(_reserves[asset].borrowIndex);
  }

  /// @inheritdoc IPool
  function getDebtByPosition(address asset, bytes32 positionId) external view returns (uint256 debt) {
    return _balances[asset][positionId].getDebtBalance(_reserves[asset].borrowIndex);
  }

  /// @inheritdoc IPool
  function getDebt(address asset, address who, uint256 index) external view returns (uint256 debt) {
    bytes32 positionId = who.getPositionId(index);
    return _balances[asset][positionId].getDebtBalance(_reserves[asset].borrowIndex);
  }

  /// @inheritdoc IPool
  function getUserAccountData(
    address user,
    uint256 index
  ) external view virtual override returns (uint256, uint256, uint256, uint256, uint256, uint256) {
    bytes32 positionId = user.getPositionId(index);
    return PoolLogic.executeGetUserAccountData(
      _balances,
      _reserves,
      _reservesList,
      DataTypes.CalculateUserAccountDataParams({
        userConfig: _usersConfig[positionId],
        reservesCount: _reservesCount,
        position: positionId,
        pool: address(this)
      })
    );
  }

  /// @inheritdoc IPool
  function getConfiguration(address asset) external view virtual override returns (DataTypes.ReserveConfigurationMap memory) {
    return _reserves[asset].configuration;
  }

  /// @inheritdoc IPool
  function getUserConfiguration(address user, uint256 index) external view virtual override returns (DataTypes.UserConfigurationMap memory) {
    return _usersConfig[user.getPositionId(index)];
  }

  /// @inheritdoc IPool
  function getReserveNormalizedIncome(address reserve) external view virtual override returns (uint256) {
    return _reserves[reserve].getNormalizedIncome();
  }

  /// @inheritdoc IPool
  function getReserveNormalizedVariableDebt(address reserve) external view virtual override returns (uint256) {
    return _reserves[reserve].getNormalizedDebt();
  }

  /// @inheritdoc IPool
  function getReservesList() external view virtual override returns (address[] memory) {
    address[] memory reservesList = new address[](_reservesCount);
    for (uint256 i = 0; i < _reservesCount; i++) {
      reservesList[i] = _reservesList[i];
    }
    return reservesList;
  }

  /// @inheritdoc IPool
  function getReservesCount() external view virtual override returns (uint256) {
    return _reservesCount;
  }

  /// @inheritdoc IPool
  function getConfigurator() external view override returns (address) {
    return address(_factory.configurator());
  }

  /// @inheritdoc IPool
  function getReserveAddressById(uint16 id) external view returns (address) {
    return _reservesList[id];
  }

  /// @inheritdoc IPool
  function getAssetPrice(address reserve) public view override returns (uint256) {
    return uint256(IAggregatorInterface(_reserves[reserve].oracle).latestAnswer());
  }

  /// @inheritdoc IPool
  function factory() external view returns (IPoolFactory) {
    return _factory;
  }

  /// @inheritdoc IPool
  function getReserveFactor() external view returns (uint256 reseveFactor) {
    return _factory.reserveFactor();
  }
}