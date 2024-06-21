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
  ) internal returns (bool isFirst, uint256 supplyMinted) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_MINT_AMOUNT);

    uint256 scaledBalance = self.scaledSupplyBalance;

    self.lastSupplyLiquidtyIndex = index.toUint128();
    self.scaledSupplyBalance += amountScaled.toUint128();

    return (scaledBalance == 0, amountScaled.toUint128());
  }

  function mintDebt(
    DataTypes.PositionBalance storage self,
    uint256 amount,
    uint256 index
  ) internal returns (bool isFirst, uint256 supplyMinted) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_MINT_AMOUNT);

    uint256 scaledBalance = self.scaledDebtBalance;

    self.lastDebtLiquidtyIndex = index.toUint128();
    self.scaledDebtBalance += amountScaled.toUint128();

    return (scaledBalance == 0, amountScaled.toUint128());
  }

  function burnSupply(
    DataTypes.PositionBalance storage self,
    uint256 amount,
    uint256 index
  ) internal returns (uint256 supplyBurnt) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_BURN_AMOUNT);

    self.lastSupplyLiquidtyIndex = index.toUint128();
    self.scaledSupplyBalance -= amountScaled.toUint128();
    return amountScaled.toUint128();
  }

  function burnDebt(
    DataTypes.PositionBalance storage self,
    uint256 amount,
    uint256 index
  ) internal returns (uint256 supplyBurnt) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_BURN_AMOUNT);

    self.lastDebtLiquidtyIndex = index.toUint128();
    self.scaledDebtBalance -= amountScaled.toUint128();
    return amountScaled.toUint128();
  }
}
