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

import {Errors} from '../utils/Errors.sol';
import {DataTypes} from '../configuration/DataTypes.sol';
import {WadRayMath} from '../utils/WadRayMath.sol';

library PositionBalanceConfiguration {
  using WadRayMath for uint256;

  function mintSupply(
    DataTypes.PositionBalance storage self,
    DataTypes.ReserveSupplies storage supply,
    uint256 amount,
    uint128 index
  ) internal returns (bool isFirst, uint256 supplyMinted) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_MINT_AMOUNT);

    uint256 scaledBalance = self.supplyShares;

    self.lastSupplyLiquidtyIndex = index;
    self.supplyShares += amountScaled;

    supply.collateral += amountScaled;

    return (scaledBalance == 0, amountScaled);
  }

  function mintDebt(
    DataTypes.PositionBalance storage self,
    DataTypes.ReserveSupplies storage supply,
    uint256 amount,
    uint128 index
  ) internal returns (bool isFirst, uint256 supplyMinted) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_MINT_AMOUNT);

    uint256 scaledBalance = self.debtShares;

    self.lastDebtLiquidtyIndex = index;
    self.debtShares += amountScaled;

    supply.debt += amountScaled;

    return (scaledBalance == 0, amountScaled);
  }

  function burnSupply(DataTypes.PositionBalance storage self, DataTypes.ReserveSupplies storage supply, uint256 amount, uint128 index) internal returns (uint256 supplyBurnt) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_BURN_AMOUNT);

    self.lastSupplyLiquidtyIndex = index;
    self.supplyShares -= amountScaled;

    supply.collateral -= amountScaled;

    return amountScaled;
  }

  function burnDebt(DataTypes.PositionBalance storage self, DataTypes.ReserveSupplies storage supply, uint256 amount, uint128 index) internal returns (uint256 supplyBurnt) {
    uint256 amountScaled = amount.rayDiv(index);
    require(amountScaled != 0, Errors.INVALID_BURN_AMOUNT);

    self.lastDebtLiquidtyIndex = index;
    self.debtShares -= amountScaled;

    supply.debt -= amountScaled;

    return amountScaled;
  }

  function getSupply(DataTypes.PositionBalance storage self, uint256 index) internal view returns (uint256 supply) {
    uint256 increase = self.supplyShares.rayMul(index) - self.supplyShares.rayMul(self.lastSupplyLiquidtyIndex);
    return self.supplyShares + increase;
  }

  function getDebt(DataTypes.PositionBalance storage self, uint256 index) internal view returns (uint256 debt) {
    uint256 increase = self.debtShares.rayMul(index) - self.debtShares.rayMul(self.lastDebtLiquidtyIndex);
    return self.debtShares + increase;
  }
}
