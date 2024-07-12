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
import {IPoolFactory} from '../../interfaces/IPoolFactory.sol';
import {IWETH} from '../../interfaces/IWETH.sol';
import {NFTPositionManagerSetters} from './NFTPositionManagerSetters.sol';
import {IERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol';
import {SafeERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol';

/**
 * @title NFTPositionManager
 * @dev Manages the minting and burning of NFT positions, which represent liquidity positions in a pool.
 */
contract NFTPositionManagerStorage is NFTPositionManagerSetters {
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

  receive() external payable {
    weth.deposit{value: msg.value}();
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
    IERC20Upgradeable(params.asset).safeTransferFrom(msg.sender, address(this), params.amount);
    _supply(params);
  }

  function supplyETH(AssetOperationParams memory params) external {
    require(params.asset == address(weth), 'not weth');
    require(params.amount > IWETH(weth).balanceOf(address(this)), 'not enough weth');
    _supply(params);
  }

  /// @inheritdoc INFTPositionManager
  function borrow(AssetOperationParams memory params) external {
    _borrow(params);
  }

  function borrowETH(AssetOperationParams memory params) external {
    address dest = params.target;
    params.target = address(this);

    _borrow(params);
    weth.withdraw(params.amount);
    payable(dest).transfer(params.amount);
  }

  /// @inheritdoc INFTPositionManager
  function withdraw(AssetOperationParams memory params) external {
    _withdraw(params);
  }

  function withdrawETH(AssetOperationParams memory params) external {
    address dest = params.target;
    params.target = address(this);

    _withdraw(params);
    weth.withdraw(params.amount);
    payable(dest).transfer(params.amount);
  }

  /// @inheritdoc INFTPositionManager
  function repay(AssetOperationParams memory params) external {
    IERC20Upgradeable(params.asset).safeTransferFrom(msg.sender, address(this), params.amount);
    _repay(params);
  }

  function repayETH(AssetOperationParams memory params) external {
    require(params.asset == address(weth), 'not weth');
    require(params.amount > IWETH(weth).balanceOf(address(this)), 'not enough weth');
    _repay(params);
  }
}
