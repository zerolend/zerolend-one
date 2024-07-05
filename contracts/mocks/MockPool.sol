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

import {DataTypes, Pool} from '../core/pool/Pool.sol';
import {ReserveLogic} from '../core/pool/logic/ReserveLogic.sol';

contract MockPool is Pool {
  using ReserveLogic for DataTypes.ReserveCache;
  using ReserveLogic for DataTypes.ReserveData;

  function forceUpdateReserve(address asset) public {
    DataTypes.ReserveData storage reserve = _reserves[asset];
    DataTypes.ReserveCache memory cache = reserve.cache(_totalSupplies[asset]);
    reserve.updateState(0, cache);
  }
}
