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

import {ERC4626Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC4626Upgradeable.sol';
import {IERC20, SafeERC20} from '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';

contract SafetyPool is ERC4626Upgradeable {
  using SafeERC20 for IERC20;

  /// @notice Initializes the staking contract with a first set of parameters
  function __MultiStakingRewardsERC4626_init(
    string memory name,
    string memory symbol,
    address _stakingToken,
    address _governance,
    address _rewardToken,
    uint256 _rewardsDuration,
    address _staking
  ) internal onlyInitializing {
    __ERC20_init(name, symbol);
    // __ERC4626_init(IERC20(_stakingToken));
    // __AccessControlEnumerable_init();

    // require(_rewardToken1 != address(0), "reward token 1 is 0x0");
    // require(_rewardToken2 != address(0), "reward token 2 is 0x0");

    // We are not checking the compatibility of the reward token between the distributor and this contract here
    // because it is checked by the `RewardsDistributor` when activating the staking contract
    // // Parameters
    // rewardsDuration = _rewardsDuration;
    // rewardToken1 = IERC20(_rewardToken1);
    // rewardToken2 = IERC20(_rewardToken2);
    // staking = IOmnichainStaking(_staking);

    // register the erc20 event
    _mint(msg.sender, 1e18);
    _burn(msg.sender, 1e18);
  }
}
