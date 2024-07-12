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

import {INFTPositionManager} from '../../interfaces/INFTPositionManager.sol';
import {DataTypes, IPool, IPoolFactory} from '../../interfaces/IPoolFactory.sol';
import {IWETH} from '../../interfaces/IWETH.sol';
import {NFTPositionManagerSetters} from './NFTPositionManagerSetters.sol';
import {IERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol';
import {SafeERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol';
import {ERC721Upgradeable, IERC721Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol';
import {MulticallUpgradeable} from '@openzeppelin/contracts-upgradeable/utils/MulticallUpgradeable.sol';

/**
 * @title NFTPositionManager
 * @dev Manages the minting and burning of NFT positions, which represent liquidity positions in a pool.
 */
abstract contract NFTPositionManagerStorage is NFTPositionManagerSetters {
  using SafeERC20Upgradeable for IERC20Upgradeable;

  /// @custom:oz-upgrades-unsafe-allow constructor
  constructor() {
    _disableInitializers();
  }

  /// @inheritdoc INFTPositionManager
  function initialize(address _factory, address _staking, address _owner, address _zero) external initializer {
    factory = IPoolFactory(_factory);
    __ERC721Enumerable_init();
    __ERC721_init('ZeroLend One Position', 'ZL-POS-ONE');
    __Ownable_init();
    __NFTRewardsDistributor_init(50_000_000, _staking, 14 days, _zero);
    _transferOwnership(_owner);
    _nextId = 1;
  }

  /// @inheritdoc INFTPositionManager
  function mint(address pool) external returns (uint256 tokenId) {
    require(factory.isPool(pool), 'not a pool');
    tokenId = _nextId;
    _nextId++;
    _positions[tokenId].pool = pool;
    _positions[tokenId].operator = address(0);
    _mint(msg.sender, tokenId);
  }

  /// @inheritdoc INFTPositionManager
  function supply(AssetOperationParams memory params) external {
    _supply(params);
  }

  /// @inheritdoc INFTPositionManager
  function borrow(AssetOperationParams memory params) external {
    _borrow(params);
  }

  /// @inheritdoc INFTPositionManager
  function withdraw(AssetOperationParams memory params) external {
    _withdraw(params);
  }

  /// @inheritdoc INFTPositionManager
  function repay(AssetOperationParams memory params) external {
    _repay(params);
  }

  function wrapEther() external payable {
    weth.deposit{value: msg.value}();
  }

  function unwrapEther() external payable {
    weth.deposit{value: msg.value}();
  }
}
