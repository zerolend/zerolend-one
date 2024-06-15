// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {ReserveConfiguration} from '../../pools/protocol/libraries/configuration/ReserveConfiguration.sol';
import {DataTypes} from '../../pools/protocol/libraries/types/DataTypes.sol';

contract MockReserveConfiguration {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  DataTypes.ReserveConfigurationMap public configuration;

  function setLtv(uint256 ltv) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setLtv(ltv);
    configuration = config;
  }

  function getLtv() external view returns (uint256) {
    return configuration.getLtv();
  }

  function setLiquidationBonus(uint256 bonus) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setLiquidationBonus(bonus);
    configuration = config;
  }

  function getLiquidationBonus() external view returns (uint256) {
    return configuration.getLiquidationBonus();
  }

  function setLiquidationThreshold(uint256 threshold) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setLiquidationThreshold(threshold);
    configuration = config;
  }

  function getLiquidationThreshold() external view returns (uint256) {
    return configuration.getLiquidationThreshold();
  }

  function setDecimals(uint256 decimals) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setDecimals(decimals);
    configuration = config;
  }

  function getDecimals() external view returns (uint256) {
    return configuration.getDecimals();
  }

  function setFrozen(bool frozen) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setFrozen(frozen);
    configuration = config;
  }

  function getFrozen() external view returns (bool) {
    return configuration.getFrozen();
  }

  function setBorrowingEnabled(bool enabled) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setBorrowingEnabled(enabled);
    configuration = config;
  }

  function getBorrowingEnabled() external view returns (bool) {
    return configuration.getBorrowingEnabled();
  }

  function setBorrowCap(uint256 borrowCap) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setBorrowCap(borrowCap);
    configuration = config;
  }

  function getBorrowCap() external view returns (uint256) {
    return configuration.getBorrowCap();
  }

  function setSupplyCap(uint256 supplyCap) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setSupplyCap(supplyCap);
    configuration = config;
  }

  function getSupplyCap() external view returns (uint256) {
    return configuration.getSupplyCap();
  }

  function getFlags() external view returns (bool, bool, bool, bool, bool) {
    return configuration.getFlags();
  }

  function getParams() external view returns (uint256, uint256, uint256, uint256, uint256) {
    return configuration.getParams();
  }
}
