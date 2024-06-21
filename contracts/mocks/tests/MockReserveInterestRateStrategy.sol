// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {IDefaultInterestRateStrategy} from '../../pools/interfaces/IDefaultInterestRateStrategy.sol';
import {WadRayMath} from '../../pools/protocol/libraries/math/WadRayMath.sol';
import {DataTypes} from '../../pools/protocol/libraries/types/DataTypes.sol';

abstract contract MockReserveInterestRateStrategy is IDefaultInterestRateStrategy {
  uint256 public OPTIMAL_USAGE_RATIO;
  uint256 internal _baseVariableBorrowRate;
  uint256 internal _variableRateSlope1;
  uint256 internal _variableRateSlope2;
  uint256 internal _stableRateSlope1;
  uint256 internal _stableRateSlope2;

  // Not used, only defined for interface compatibility
  uint256 public constant MAX_EXCESS_STABLE_TO_TOTAL_DEBT_RATIO = 0;
  uint256 public constant MAX_EXCESS_USAGE_RATIO = 0;
  uint256 public constant OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO = 0;

  uint256 internal _liquidityRate;
  uint256 internal _stableBorrowRate;
  uint256 internal _variableBorrowRate;

  constructor(
    uint256 optimalUsageRatio,
    uint256 baseVariableBorrowRate,
    uint256 variableRateSlope1,
    uint256 variableRateSlope2
  ) {
    OPTIMAL_USAGE_RATIO = optimalUsageRatio;
    _baseVariableBorrowRate = baseVariableBorrowRate;
    _variableRateSlope1 = variableRateSlope1;
    _variableRateSlope2 = variableRateSlope2;
  }

  function setLiquidityRate(uint256 liquidityRate) public {
    _liquidityRate = liquidityRate;
  }

  function setStableBorrowRate(uint256 stableBorrowRate) public {
    _stableBorrowRate = stableBorrowRate;
  }

  function setVariableBorrowRate(uint256 variableBorrowRate) public {
    _variableBorrowRate = variableBorrowRate;
  }

  function calculateInterestRates(
    address,
    bytes memory,
    DataTypes.CalculateInterestRatesParams memory
  ) external view override returns (uint256 liquidityRate, uint256 variableBorrowRate) {
    return (_liquidityRate, _variableBorrowRate);
  }

  function getVariableRateSlope1() external view returns (uint256) {
    return _variableRateSlope1;
  }

  function getVariableRateSlope2() external view returns (uint256) {
    return _variableRateSlope2;
  }

  function getStableRateSlope1() external view returns (uint256) {
    return _stableRateSlope1;
  }

  function getStableRateSlope2() external view returns (uint256) {
    return _stableRateSlope2;
  }

  function getBaseVariableBorrowRate() external view override returns (uint256) {
    return _baseVariableBorrowRate;
  }

  function getMaxVariableBorrowRate() external view override returns (uint256) {
    return _baseVariableBorrowRate + _variableRateSlope1 + _variableRateSlope2;
  }
}
