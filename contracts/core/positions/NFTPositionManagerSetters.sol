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

import {DataTypes, IPool} from '../../interfaces/IPoolFactory.sol';
import {NFTRewardsDistributor} from './NFTRewardsDistributor.sol';
import {IERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol';
import {SafeERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol';
import {ERC721Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol';

abstract contract NFTPositionManagerSetters is NFTRewardsDistributor {
  using SafeERC20Upgradeable for IERC20Upgradeable;

  /**
   * @dev Modifier to check if the caller is pool or not.
   * @param pool Address of the pool.
   */
  modifier isPool(address pool) {
    if (!factory.isPool(pool)) {
      revert NotPool();
    }
    _;
  }

  /**
   * @notice Handles the liquidity operations including transferring tokens, approving the pool, and updating balances.
   * @param params The liquidity parameters including asset, pool, user, amount, and tokenId.
   * @custom:event LiquidityIncreased emitted whenever user supply asset
   */
  function _supply(AssetOperationParams memory params) internal nonReentrant {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();
    if (params.tokenId == 0) params.tokenId = _nextId - 1;
    IPool pool = IPool(_positions[params.tokenId].pool);

    // check permissions
    _isAuthorizedForToken(params.tokenId);

    IERC20Upgradeable(params.asset).forceApprove(address(pool), params.amount);
    pool.supply(params.asset, params.amount, params.tokenId, params.data);
    emit LiquidityIncreased(params.asset, params.tokenId, params.amount);

    // update incentives
    uint256 balance = pool.getBalance(params.asset, address(this), params.tokenId);
    _handleSupplies(address(pool), params.asset, params.tokenId, balance);
  }

  function _borrow(AssetOperationParams memory params) internal nonReentrant {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();
    if (params.tokenId == 0) params.tokenId = _nextId - 1;

    // check permissions
    _isAuthorizedForToken(params.tokenId);

    IPool pool = IPool(_positions[params.tokenId].pool);
    pool.borrow(params.asset, params.target, params.amount, params.tokenId, params.data);

    emit BorrowIncreased(params.asset, params.amount, params.tokenId);

    // update incentives
    uint256 balance = pool.getDebt(params.asset, address(this), params.tokenId);
    _handleDebt(address(pool), params.asset, params.tokenId, balance);
  }

  function _withdraw(AssetOperationParams memory params) internal nonReentrant {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();
    if (params.tokenId == 0) params.tokenId = _nextId - 1;

    // check permissions
    _isAuthorizedForToken(params.tokenId);

    IPool pool = IPool(_positions[params.tokenId].pool);

    pool.withdraw(params.asset, params.target, params.amount, params.tokenId, params.data);
    emit Withdrawal(params.asset, params.amount, params.tokenId);

    // update incentives
    uint256 balance = pool.getBalance(params.asset, address(this), params.tokenId);
    _handleSupplies(address(pool), params.asset, params.tokenId, balance);
  }

  function _repay(AssetOperationParams memory params) internal nonReentrant {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();
    if (params.tokenId == 0) params.tokenId = _nextId - 1;

    Position memory userPosition = _positions[params.tokenId];

    IPool pool = IPool(userPosition.pool);
    IERC20Upgradeable asset = IERC20Upgradeable(params.asset);

    asset.forceApprove(userPosition.pool, params.amount);

    uint256 previousDebtBalance = pool.getDebt(params.asset, address(this), params.tokenId);
    DataTypes.SharesType memory repaid = pool.repay(params.asset, params.amount, params.tokenId, params.data);
    uint256 currentDebtBalance = pool.getDebt(params.asset, address(this), params.tokenId);

    if (previousDebtBalance - currentDebtBalance != repaid.assets) {
      revert BalanceMisMatch();
    }

    if (currentDebtBalance == 0 && repaid.assets < params.amount) {
      asset.safeTransfer(msg.sender, params.amount - repaid.assets);
    }

    // update incentives
    _handleDebt(address(pool), params.asset, params.tokenId, currentDebtBalance);

    emit Repay(params.asset, params.amount, params.tokenId);
  }

  /// @dev Overrides _approve to use the operator in the position, which is packed with the position permit nonce
  function _approve(address to, uint256 tokenId) internal override (ERC721Upgradeable) {
    _positions[tokenId].operator = to;
    emit Approval(ownerOf(tokenId), to, tokenId);
  }

  function _isAuthorizedForToken(uint256 tokenId) internal view {
    if (!_isApprovedOrOwner(msg.sender, tokenId)) revert NotTokenIdOwner();
  }
}
