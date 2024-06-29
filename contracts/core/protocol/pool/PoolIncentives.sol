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

import {PoolGetters} from './PoolGetters.sol';

/**
 * @title Pool Incentives
 * @author ZeroLend
 * @notice The child contract for the Pool to keep track of incentives.
 */
abstract contract PoolIncentives is PoolGetters {
  // add all pool incentive code here
  function _updateIncentives(address asset, bytes32 positionId, uint256 amount) internal {
    // todo
  }
}
