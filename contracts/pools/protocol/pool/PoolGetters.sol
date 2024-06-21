// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {DataTypes} from '../libraries/types/DataTypes.sol';
import {IPool} from '../../interfaces/IPool.sol';
import {PoolLogic} from '../libraries/logic/PoolLogic.sol';
import {PoolStorage} from './PoolStorage.sol';
import {ReserveLogic} from '../libraries/logic/ReserveLogic.sol';
import {TokenConfiguration} from '../libraries/configuration/TokenConfiguration.sol';

abstract contract PoolGetters is PoolStorage, IPool {
  using ReserveLogic for DataTypes.ReserveData;
  using TokenConfiguration for address;

  /// @inheritdoc IPool
  function getReserveData(
    address asset
  ) external view virtual override returns (DataTypes.ReserveData memory) {
    return _reserves[asset];
  }

  /// @inheritdoc IPool
  function getBalance(address asset, bytes32 positionId) external view returns (uint256 balance) {
    return _balances[asset][positionId].scaledSupplyBalance;
  }

  /// @inheritdoc IPool
  function getDebt(address asset, bytes32 positionId) external view returns (uint256 debt) {
    return _balances[asset][positionId].scaledDebtBalance;
  }

  /// @inheritdoc IPool
  function getUserAccountData(
    address user,
    uint256 index
  )
    external
    view
    virtual
    override
    returns (
      uint256 totalCollateralBase,
      uint256 totalDebtBase,
      uint256 availableBorrowsBase,
      uint256 currentLiquidationThreshold,
      uint256 ltv,
      uint256 healthFactor
    )
  {
    return
      PoolLogic.executeGetUserAccountData(
        _balances,
        _reserves,
        _reservesList,
        DataTypes.CalculateUserAccountDataParams({
          userConfig: _usersConfig[keccak256(abi.encodePacked(msg.sender, index))],
          reservesCount: _reservesCount,
          position: user.getPositionId(index),
          pool: address(this)
        })
      );
  }

  /// @inheritdoc IPool
  function getConfiguration(
    address asset
  ) external view virtual override returns (DataTypes.ReserveConfigurationMap memory) {
    return _reserves[asset].configuration;
  }

  /// @inheritdoc IPool
  function getUserConfiguration(
    address user,
    uint256 index
  ) external view virtual override returns (DataTypes.UserConfigurationMap memory) {
    return _usersConfig[user.getPositionId(index)];
  }

  /// @inheritdoc IPool
  function getReserveNormalizedIncome(
    address asset
  ) external view virtual override returns (uint256) {
    return _reserves[asset].getNormalizedIncome();
  }

  /// @inheritdoc IPool
  function getReserveNormalizedVariableDebt(
    address asset
  ) external view virtual override returns (uint256) {
    return _reserves[asset].getNormalizedDebt();
  }

  /// @inheritdoc IPool
  function getReservesList() external view virtual override returns (address[] memory) {
    address[] memory reservesList = new address[](_reservesCount);
    for (uint256 i = 0; i < _reservesCount; i++) reservesList[i] = _reservesList[i];
    return reservesList;
  }

  /// @inheritdoc IPool
  function getReservesCount() external view virtual override returns (uint256) {
    return _reservesCount;
  }

  /// @inheritdoc IPool
  function getReserveAddressById(uint16 id) external view returns (address) {
    return _reservesList[id];
  }

  function getAssetPrice(address asset) public view override returns (uint256) {
    return uint256(_assetsSources[asset].latestAnswer());
  }
}
