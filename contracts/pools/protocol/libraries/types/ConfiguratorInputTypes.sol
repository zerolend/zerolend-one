// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

library ConfiguratorInputTypes {
  struct InitReserveInput {
    address interestRateStrategyAddress;
    address asset;
    bytes params;
    uint256 liquidationThreshold;
    uint256 liquidationBonus;
    uint256 ltv;
    uint8 underlyingAssetDecimals;
  }
}
