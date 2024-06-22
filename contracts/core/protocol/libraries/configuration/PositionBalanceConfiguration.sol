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

import {Errors} from '../helpers/Errors.sol';
import {DataTypes} from '../types/DataTypes.sol';
import {WadRayMath} from '../math/WadRayMath.sol';
import {SafeCast} from '@openzeppelin/contracts/utils/math/SafeCast.sol';

library PositionBalanceConfiguration {
  using WadRayMath for uint256;
  using SafeCast for uint256;

  function mintSupply(
    DataTypes.PositionBalance storage self,
    uint256 amount,
    uint128 index
  ) internal returns (bool isFirst, uint256 supplyMinted) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_MINT_AMOUNT);

    uint256 scaledBalance = self.scaledSupplyBalance;

    self.lastSupplyLiquidtyIndex = index;
    self.scaledSupplyBalance += amountScaled;

    return (scaledBalance == 0, amountScaled);
  }

  function mintDebt(
    DataTypes.PositionBalance storage self,
    uint256 amount,
    uint128 index
  ) internal returns (bool isFirst, uint256 supplyMinted) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_MINT_AMOUNT);

    uint256 scaledBalance = self.scaledDebtBalance;

    self.lastDebtLiquidtyIndex = index;
    self.scaledDebtBalance += amountScaled;

    return (scaledBalance == 0, amountScaled);
  }

  function burnSupply(
    DataTypes.PositionBalance storage self,
    uint256 amount,
    uint128 index
  ) internal returns (uint256 supplyBurnt) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_BURN_AMOUNT);

    self.lastSupplyLiquidtyIndex = index;
    self.scaledSupplyBalance -= amountScaled;
    return amountScaled;
  }

  function burnDebt(
    DataTypes.PositionBalance storage self,
    uint256 amount,
    uint128 index
  ) internal returns (uint256 supplyBurnt) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_BURN_AMOUNT);

    self.lastDebtLiquidtyIndex = index;
    self.scaledDebtBalance -= amountScaled;
    return amountScaled;
  }

  function getSupply(
    DataTypes.PositionBalance storage self,
    uint256 index
  ) internal view returns (uint256 supply) {
    uint256 increase = self.scaledSupplyBalance.rayMul(index) -
      self.scaledSupplyBalance.rayMul(self.lastSupplyLiquidtyIndex);
    return self.scaledSupplyBalance + increase;
  }

  function getDebt(
    DataTypes.PositionBalance storage self,
    uint256 index
  ) internal view returns (uint256 debt) {
    uint256 increase = self.scaledDebtBalance.rayMul(index) -
      self.scaledDebtBalance.rayMul(self.lastDebtLiquidtyIndex);
    return self.scaledDebtBalance + increase;
  }
}
