// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {Errors} from '../helpers/Errors.sol';
import {DataTypes} from '../types/DataTypes.sol';
import {SafeCast} from '@openzeppelin/contracts/utils/math/SafeCast.sol';
import {WadRayMath} from '../math/WadRayMath.sol';

library PositionBalanceConfiguration {
  using WadRayMath for uint256;
  using SafeCast for uint256;

  function mintSupply(
    DataTypes.PositionBalance storage self,
    uint256 amount,
    uint256 index
  ) internal returns (bool) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_MINT_AMOUNT);

    uint256 scaledBalance = self.scaledSupplyBalance;
    uint256 balanceIncrease = scaledBalance.rayMul(index) -
      scaledBalance.rayMul(self.lastSupplyLiquidtyIndex);

    self.lastSupplyLiquidtyIndex = index.toUint128();
    self.scaledSupplyBalance += amountScaled.toUint128();

    return (scaledBalance == 0);
  }

  function mintDebt(
    DataTypes.PositionBalance storage self,
    uint256 amount,
    uint256 index
  ) internal returns (bool) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_MINT_AMOUNT);

    uint256 scaledBalance = self.scaledDebtBalance;
    uint256 balanceIncrease = scaledBalance.rayMul(index) -
      scaledBalance.rayMul(self.lastDebtLiquidtyIndex);

    self.lastDebtLiquidtyIndex = index.toUint128();
    self.scaledDebtBalance += amountScaled.toUint128();

    return (scaledBalance == 0);
  }

  function burnSupply(
    DataTypes.PositionBalance storage self,
    uint256 amount,
    uint256 index
  ) internal returns (uint256) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_BURN_AMOUNT);

    uint256 scaledBalance = self.scaledSupplyBalance;
    uint256 balanceIncrease = scaledBalance.rayMul(index) -
      scaledBalance.rayMul(self.lastSupplyLiquidtyIndex);

    self.lastSupplyLiquidtyIndex = index.toUint128();
    self.scaledSupplyBalance -= amountScaled.toUint128();
    return amountScaled.toUint128();
  }

  function burnDebt(
    DataTypes.PositionBalance storage self,
    uint256 amount,
    uint256 index
  ) internal returns (uint256) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_BURN_AMOUNT);

    uint256 scaledBalance = self.scaledDebtBalance;
    uint256 balanceIncrease = scaledBalance.rayMul(index) -
      scaledBalance.rayMul(self.lastDebtLiquidtyIndex);

    self.lastDebtLiquidtyIndex = index.toUint128();
    self.scaledDebtBalance -= amountScaled.toUint128();
    return amountScaled.toUint128();
  }
}
