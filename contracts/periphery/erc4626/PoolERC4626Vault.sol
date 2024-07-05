// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IPool} from '../../core/interfaces/IPool.sol';

import {IPool} from '../../core/interfaces/IPool.sol';
import {DataTypes, ReserveConfiguration} from '../../core/protocol/libraries/configuration/ReserveConfiguration.sol';
import {TokenConfiguration} from '../../core/protocol/libraries/configuration/TokenConfiguration.sol';

import {IIncentivesController} from '../../core/interfaces/IIncentivesController.sol';

import {MathUtils} from '../../core/protocol/libraries/math/MathUtils.sol';
import {WadRayMath} from '../../core/protocol/libraries/math/WadRayMath.sol';

import {IERC20} from '@openzeppelin/contracts/interfaces/IERC20.sol';
import {Initializable} from '@openzeppelin/contracts/proxy/utils/Initializable.sol';
import {IERC20Metadata} from '@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from '@openzeppelin/contracts/utils/math/SafeCast.sol';

import {IPoolERC4626Vault} from '../interfaces/IPoolERC4626Vault.sol';
// import {IAToken} from './interfaces/IAToken.sol';

import {PoolERC4626VaultErrors} from './PoolERC4626VaultErrors.sol';
import {RayMathExplicitRounding, Rounding} from './RayMathExplicitRounding.sol';
import {ERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol';
import {IERC4626} from '@openzeppelin/contracts/interfaces/IERC4626.sol';

/**
 * @title PoolERC4626Vault
 * @notice Wrapper smart contract that allows to deposit tokens on the Aave protocol and receive
 * a token which balance doesn't increase automatically, but uses an ever-increasing exchange rate.
 * It supports claiming liquidity mining rewards from the Aave system.
 */
contract PoolERC4626Vault is ERC20Upgradeable, IPoolERC4626Vault {
  using SafeERC20 for IERC20;
  using SafeCast for uint256;
  using WadRayMath for uint256;
  using WadRayMath for address;
  using TokenConfiguration for address;
  using RayMathExplicitRounding for uint256;

  bytes32 public constant METADEPOSIT_TYPEHASH = keccak256(
    'Deposit(address depositor,address receiver,uint256 assets,uint16 referralCode,bool depositToAave,uint256 nonce,uint256 deadline,PermitParams permit)'
  );
  bytes32 public constant METAWITHDRAWAL_TYPEHASH =
    keccak256('Withdraw(address owner,address receiver,uint256 shares,uint256 assets,bool withdrawFromAave,uint256 nonce,uint256 deadline)');

  uint256 public constant STATIC__ATOKEN_LM_REVISION = 2;

  IPool public pool;
  IIncentivesController public incentives;
  IERC20 public underlying;
  bytes32 public positionId;

  uint8 internal _decimals;
  address[] internal _rewardTokens;
  mapping(address => RewardIndexCache) internal _startIndex;
  mapping(address => mapping(address => UserRewardsData)) internal _userRewardsData;

  ///@inheritdoc IPoolERC4626Vault
  function initialize(address _pool, address _underlying) external initializer {
    pool = IPool(_pool);
    underlying = IERC20(_underlying);

    __ERC20_init(
      string.concat(IERC20Metadata(_underlying).name(), ' 4262 Vault'), string.concat(IERC20Metadata(_underlying).symbol(), '-4262')
    );

    _decimals = IERC20Metadata(_underlying).decimals();
    underlying.approve(address(pool), type(uint256).max);

    if (incentives != IIncentivesController(address(0))) refreshRewardTokens();

    positionId = address(this).getPositionId(0);

    emit Initialized(_underlying, name(), symbol());
  }

  ///@inheritdoc IPoolERC4626Vault
  function refreshRewardTokens() public override {
    // todo
    // address[] memory rewards = incentives.getRewardsByAsset(address(underlying));
    // for (uint256 i = 0; i < rewards.length; i++) _registerRewardToken(rewards[i]);
  }

  ///@inheritdoc IPoolERC4626Vault
  function isRegisteredRewardToken(address reward) public view override returns (bool) {
    return _startIndex[reward].isRegistered;
  }

  ////@inheritdoc IPoolERC4626Vault
  function deposit(uint256 assets, address receiver, uint16 referralCode, bool depositToAave) external returns (uint256) {
    (uint256 shares,) = _deposit(msg.sender, receiver, 0, assets, referralCode, depositToAave);
    return shares;
  }

  ////@inheritdoc IERC4626
  function previewRedeem(uint256 shares) public view virtual returns (uint256) {
    return _convertToAssets(shares, Rounding.DOWN);
  }

  ////@inheritdoc IERC4626
  function previewMint(uint256 shares) public view virtual returns (uint256) {
    return _convertToAssets(shares, Rounding.UP);
  }

  ////@inheritdoc IERC4626
  function previewWithdraw(uint256 assets) public view virtual returns (uint256) {
    return _convertToShares(assets, Rounding.UP);
  }

  ////@inheritdoc IERC4626
  function previewDeposit(uint256 assets) public view virtual returns (uint256) {
    return _convertToShares(assets, Rounding.DOWN);
  }

  ///@inheritdoc IPoolERC4626Vault
  function rate() public view returns (uint256) {
    return pool.getReserveNormalizedIncome(address(underlying));
  }

  ///@inheritdoc IPoolERC4626Vault
  function collectAndUpdateRewards(address reward) public returns (uint256) {
    if (reward == address(0)) {
      return 0;
    }

    address[] memory assets = new address[](1);
    assets[0] = address(underlying);
    // todo
    return 0; // incentives.claimRewards(assets, type(uint256).max, address(this), reward);
  }

  ///@inheritdoc IPoolERC4626Vault
  function claimRewardsOnBehalf(address onBehalfOf, address receiver, address[] memory rewards) external {
    // todo
    // require(
    //   msg.sender == onBehalfOf || msg.sender == incentives.getClaimer(onBehalfOf),
    //   PoolERC4626VaultErrors.INVALID_CLAIMER
    // );
    _claimRewardsOnBehalf(onBehalfOf, receiver, rewards);
  }

  ///@inheritdoc IPoolERC4626Vault
  function claimRewards(address receiver, address[] memory rewards) external {
    _claimRewardsOnBehalf(msg.sender, receiver, rewards);
  }

  ///@inheritdoc IPoolERC4626Vault
  function claimRewardsToSelf(address[] memory rewards) external {
    _claimRewardsOnBehalf(msg.sender, msg.sender, rewards);
  }

  ///@inheritdoc IPoolERC4626Vault
  function getCurrentRewardsIndex(address reward) public view returns (uint256) {
    // todo
    // if (address(reward) == address(0)) {
    //   return 0;
    // }
    // (, uint256 nextIndex) = incentives.getAssetIndex(address(underlying), reward);
    // return nextIndex;
    return 0;
  }

  ///@inheritdoc IPoolERC4626Vault
  function getTotalClaimableRewards(address reward) external view returns (uint256) {
    if (reward == address(0)) {
      return 0;
    }

    address[] memory assets = new address[](1);
    assets[0] = address(underlying);
    return 0;
    // todo
    // uint256 freshRewards = incentives.getUserRewards(assets, address(this), reward);
    // return IERC20(reward).balanceOf(address(this)) + freshRewards;
  }

  ///@inheritdoc IPoolERC4626Vault
  function getClaimableRewards(address user, address reward) external view returns (uint256) {
    return _getClaimableRewards(user, reward, balanceOf(user), getCurrentRewardsIndex(reward));
  }

  ///@inheritdoc IPoolERC4626Vault
  function getUnclaimedRewards(address user, address reward) external view returns (uint256) {
    return _userRewardsData[user][reward].unclaimedRewards;
  }

  ////@inheritdoc IERC4626
  function asset() external view returns (address) {
    return address(underlying);
  }

  ///@inheritdoc IPoolERC4626Vault
  function rewardTokens() external view returns (address[] memory) {
    return _rewardTokens;
  }

  ////@inheritdoc IERC4626
  function totalAssets() external view returns (uint256) {
    return pool.getBalance(address(underlying), positionId);
  }

  ////@inheritdoc IERC4626
  function convertToShares(uint256 assets) external view returns (uint256) {
    return _convertToShares(assets, Rounding.DOWN);
  }

  ////@inheritdoc IERC4626
  function convertToAssets(uint256 shares) external view returns (uint256) {
    return _convertToAssets(shares, Rounding.DOWN);
  }

  ////@inheritdoc IERC4626
  function maxDeposit(address) public view virtual returns (uint256) {
    DataTypes.ReserveData memory reserveData = pool.getReserveData(address(underlying));

    // if inactive, paused or frozen users cannot deposit underlying
    if (ReserveConfiguration.getFrozen(reserveData.configuration)) {
      return 0;
    }

    uint256 supplyCap =
      ReserveConfiguration.getSupplyCap(reserveData.configuration) * (10 ** ReserveConfiguration.getDecimals(reserveData.configuration));
    // if no supply cap deposit is unlimited
    if (supplyCap == 0) return type(uint256).max;
    // return remaining supply cap margin

    // todo
    // uint256 currentSupply = (IAToken(reserveData.aTokenAddress).scaledTotalSupply() +
    //   reserveData.accruedToTreasury).rayMulRoundUp(_getNormalizedIncome(reserveData));
    // return currentSupply > supplyCap ? 0 : supplyCap - currentSupply;
    return 0;
  }

  ////@inheritdoc IERC4626
  function maxMint(address) public view virtual returns (uint256) {
    uint256 assets = maxDeposit(address(0));
    if (assets == type(uint256).max) return type(uint256).max;
    return _convertToShares(assets, Rounding.DOWN);
  }

  ////@inheritdoc IERC4626
  function maxWithdraw(address owner) public view virtual returns (uint256) {
    uint256 shares = maxRedeem(owner);
    return _convertToAssets(shares, Rounding.DOWN);
  }

  ////@inheritdoc IERC4626
  function maxRedeem(address owner) public view virtual returns (uint256) {
    address cachedATokenUnderlying = address(underlying);
    DataTypes.ReserveData memory reserveData = pool.getReserveData(cachedATokenUnderlying);

    // otherwise users can withdraw up to the available amount
    uint256 underlyingTokenBalanceInShares = _convertToShares(
      0,
      // todo
      // IERC20(cachedATokenUnderlying).balanceOf(reserveData.unde),
      Rounding.DOWN
    );
    uint256 cachedUserBalance = balanceOf(owner);
    return underlyingTokenBalanceInShares >= cachedUserBalance ? cachedUserBalance : underlyingTokenBalanceInShares;
  }

  // ////@inheritdoc IERC4626
  // function maxDeposit(address) public view virtual returns (uint256) {
  //   DataTypes.ReserveData memory reserveData = POOL.getReserveData(_aTokenUnderlying);

  //   // if inactive, paused or frozen users cannot deposit underlying
  //   if (
  //     !ReserveConfiguration.getActive(reserveData.configuration) ||
  //     ReserveConfiguration.getPaused(reserveData.configuration) ||
  //     ReserveConfiguration.getFrozen(reserveData.configuration)
  //   ) {
  //     return 0;
  //   }

  //   uint256 supplyCap = ReserveConfiguration.getSupplyCap(reserveData.configuration) *
  //     (10 ** ReserveConfiguration.getDecimals(reserveData.configuration));
  //   // if no supply cap deposit is unlimited
  //   if (supplyCap == 0) return type(uint256).max;
  //   // return remaining supply cap margin
  //   uint256 currentSupply = (IAToken(reserveData.aTokenAddress).scaledTotalSupply() +
  //     reserveData.accruedToTreasury).rayMulRoundUp(_getNormalizedIncome(reserveData));
  //   return currentSupply > supplyCap ? 0 : supplyCap - currentSupply;
  // }

  ////@inheritdoc IERC4626
  function deposit(uint256 assets, address receiver) external virtual returns (uint256) {
    (uint256 shares,) = _deposit(msg.sender, receiver, 0, assets, 0, true);
    return shares;
  }

  ////@inheritdoc IERC4626
  function mint(uint256 shares, address receiver) external virtual returns (uint256) {
    (, uint256 assets) = _deposit(msg.sender, receiver, shares, 0, 0, true);

    return assets;
  }

  ////@inheritdoc IERC4626
  function withdraw(uint256 assets, address receiver, address owner) external virtual returns (uint256) {
    (uint256 shares,) = _withdraw(owner, receiver, 0, assets, true);

    return shares;
  }

  ////@inheritdoc IERC4626
  function redeem(uint256 shares, address receiver, address owner) external virtual returns (uint256) {
    (, uint256 assets) = _withdraw(owner, receiver, shares, 0, true);

    return assets;
  }

  ///@inheritdoc IPoolERC4626Vault
  function redeem(uint256 shares, address receiver, address owner, bool withdrawFromAave) external virtual returns (uint256, uint256) {
    return _withdraw(owner, receiver, shares, 0, withdrawFromAave);
  }

  function _deposit(
    address depositor,
    address receiver,
    uint256 _shares,
    uint256 _assets,
    uint16 referralCode,
    bool depositToAave
  ) internal returns (uint256, uint256) {
    require(receiver != address(0), PoolERC4626VaultErrors.INVALID_RECIPIENT);
    require(_shares == 0 || _assets == 0, PoolERC4626VaultErrors.ONLY_ONE_AMOUNT_FORMAT_ALLOWED);

    uint256 assets = _assets;
    uint256 shares = _shares;
    if (shares > 0) {
      if (depositToAave) {
        require(shares <= maxMint(receiver), 'ERC4626: mint more than max');
      }
      assets = previewMint(shares);
    } else {
      if (depositToAave) {
        require(assets <= maxDeposit(receiver), 'ERC4626: deposit more than max');
      }
      shares = previewDeposit(assets);
    }
    require(shares != 0, PoolERC4626VaultErrors.INVALID_ZERO_AMOUNT);

    if (depositToAave) {
      address cachedATokenUnderlying = address(underlying);
      IERC20(cachedATokenUnderlying).safeTransferFrom(depositor, address(this), assets);
      // todo
      // pool.deposit(cachedATokenUnderlying, assets, address(this), referralCode);
    } else {
      // todo
      // _aToken.safeTransferFrom(depositor, address(this), assets);
    }

    _mint(receiver, shares);

    emit Deposit(depositor, receiver, assets, shares);

    return (shares, assets);
  }

  function _withdraw(
    address owner,
    address receiver,
    uint256 _shares,
    uint256 _assets,
    bool withdrawFromAave
  ) internal returns (uint256, uint256) {
    require(receiver != address(0), PoolERC4626VaultErrors.INVALID_RECIPIENT);
    require(_shares == 0 || _assets == 0, PoolERC4626VaultErrors.ONLY_ONE_AMOUNT_FORMAT_ALLOWED);
    require(_shares != _assets, PoolERC4626VaultErrors.INVALID_ZERO_AMOUNT);

    uint256 assets = _assets;
    uint256 shares = _shares;

    if (shares > 0) {
      if (withdrawFromAave) {
        require(shares <= maxRedeem(owner), 'ERC4626: redeem more than max');
      }
      assets = previewRedeem(shares);
    } else {
      if (withdrawFromAave) {
        require(assets <= maxWithdraw(owner), 'ERC4626: withdraw more than max');
      }
      shares = previewWithdraw(assets);
    }

    if (msg.sender != owner) {
      uint256 allowed = allowance(owner, msg.sender); // Saves gas for limited approvals.
      if (allowed != type(uint256).max) _approve(owner, msg.sender, allowed - shares);
    }

    _burn(owner, shares);

    emit Withdraw(msg.sender, receiver, owner, assets, shares);

    // if (withdrawFromAave) {
    //   pool.withdraw(_aTokenUnderlying, assets, receiver);
    // } else {
    //   _aToken.safeTransfer(receiver, assets);
    // }

    return (shares, assets);
  }

  /**
   * @notice Updates rewards for senders and receiver in a transfer (not updating rewards for address(0))
   * @param from The address of the sender of tokens
   * @param to The address of the receiver of tokens
   */
  function _beforeTokenTransfer(address from, address to, uint256) internal override {
    for (uint256 i = 0; i < _rewardTokens.length; i++) {
      address rewardToken = address(_rewardTokens[i]);
      uint256 rewardsIndex = getCurrentRewardsIndex(rewardToken);
      if (from != address(0)) {
        _updateUser(from, rewardsIndex, rewardToken);
      }
      if (to != address(0) && from != to) {
        _updateUser(to, rewardsIndex, rewardToken);
      }
    }
  }

  /**
   * @notice Adding the pending rewards to the unclaimed for specific user and updating user index
   * @param user The address of the user to update
   * @param currentRewardsIndex The current rewardIndex
   * @param rewardToken The address of the reward token
   */
  function _updateUser(address user, uint256 currentRewardsIndex, address rewardToken) internal {
    uint256 balance = balanceOf(user);
    if (balance > 0) {
      _userRewardsData[user][rewardToken].unclaimedRewards =
        _getClaimableRewards(user, rewardToken, balance, currentRewardsIndex).toUint128();
    }
    _userRewardsData[user][rewardToken].rewardsIndexOnLastInteraction = currentRewardsIndex.toUint128();
  }

  /**
   * @notice Compute the pending in WAD. Pending is the amount to add (not yet unclaimed) rewards in WAD.
   * @param balance The balance of the user
   * @param rewardsIndexOnLastInteraction The index which was on the last interaction of the user
   * @param currentRewardsIndex The current rewards index in the system
   * @param assetUnit One unit of asset (10**decimals)
   * @return The amount of pending rewards in WAD
   */
  function _getPendingRewards(
    uint256 balance,
    uint256 rewardsIndexOnLastInteraction,
    uint256 currentRewardsIndex,
    uint256 assetUnit
  ) internal pure returns (uint256) {
    if (balance == 0) {
      return 0;
    }
    return (balance * (currentRewardsIndex - rewardsIndexOnLastInteraction)) / assetUnit;
  }

  /**
   * @notice Compute the claimable rewards for a user
   * @param user The address of the user
   * @param reward The address of the reward
   * @param balance The balance of the user in WAD
   * @param currentRewardsIndex The current rewards index
   * @return The total rewards that can be claimed by the user (if `fresh` flag true, after updating rewards)
   */
  function _getClaimableRewards(address user, address reward, uint256 balance, uint256 currentRewardsIndex) internal view returns (uint256) {
    RewardIndexCache memory rewardsIndexCache = _startIndex[reward];
    require(rewardsIndexCache.isRegistered == true, PoolERC4626VaultErrors.REWARD_NOT_INITIALIZED);
    UserRewardsData memory currentUserRewardsData = _userRewardsData[user][reward];
    uint256 assetUnit = 10 ** _decimals;
    return currentUserRewardsData.unclaimedRewards
      + _getPendingRewards(
        balance,
        currentUserRewardsData.rewardsIndexOnLastInteraction == 0
          ? rewardsIndexCache.lastUpdatedIndex
          : currentUserRewardsData.rewardsIndexOnLastInteraction,
        currentRewardsIndex,
        assetUnit
      );
  }

  /**
   * @notice Claim rewards on behalf of a user and send them to a receiver
   * @param onBehalfOf The address to claim on behalf of
   * @param rewards The addresses of the rewards
   * @param receiver The address to receive the rewards
   */
  function _claimRewardsOnBehalf(address onBehalfOf, address receiver, address[] memory rewards) internal {
    for (uint256 i = 0; i < rewards.length; i++) {
      if (address(rewards[i]) == address(0)) {
        continue;
      }
      uint256 currentRewardsIndex = getCurrentRewardsIndex(rewards[i]);
      uint256 balance = balanceOf(onBehalfOf);
      uint256 userReward = _getClaimableRewards(onBehalfOf, rewards[i], balance, currentRewardsIndex);
      uint256 totalRewardTokenBalance = IERC20(rewards[i]).balanceOf(address(this));
      uint256 unclaimedReward = 0;

      if (userReward > totalRewardTokenBalance) {
        totalRewardTokenBalance += collectAndUpdateRewards(address(rewards[i]));
      }

      if (userReward > totalRewardTokenBalance) {
        unclaimedReward = userReward - totalRewardTokenBalance;
        userReward = totalRewardTokenBalance;
      }
      if (userReward > 0) {
        _userRewardsData[onBehalfOf][rewards[i]].unclaimedRewards = unclaimedReward.toUint128();
        _userRewardsData[onBehalfOf][rewards[i]].rewardsIndexOnLastInteraction = currentRewardsIndex.toUint128();
        IERC20(rewards[i]).safeTransfer(receiver, userReward);
      }
    }
  }

  function _convertToShares(uint256 assets, Rounding rounding) internal view returns (uint256) {
    if (rounding == Rounding.UP) return assets.rayDivRoundUp(rate());
    return assets.rayDivRoundDown(rate());
  }

  function _convertToAssets(uint256 shares, Rounding rounding) internal view returns (uint256) {
    if (rounding == Rounding.UP) return shares.rayMulRoundUp(rate());
    return shares.rayMulRoundDown(rate());
  }

  /**
   * @notice Initializes a new rewardToken
   * @param reward The reward token to be registered
   */
  function _registerRewardToken(address reward) internal {
    if (isRegisteredRewardToken(reward)) return;
    uint256 startIndex = getCurrentRewardsIndex(reward);

    _rewardTokens.push(reward);
    _startIndex[reward] = RewardIndexCache(true, startIndex.toUint240());

    emit RewardTokenRegistered(reward, startIndex);
  }

  /**
   * Copy of
   * https://github.com/aave/aave-v3-core/blob/29ff9b9f89af7cd8255231bc5faf26c3ce0fb7ce/contracts/protocol/libraries/logic/ReserveLogic.sol#L47
   * with memory instead of calldata
   * @notice Returns the ongoing normalized income for the reserve.
   * @dev A value of 1e27 means there is no income. As time passes, the income is accrued
   * @dev A value of 2*1e27 means for each unit of asset one unit of income has been accrued
   * @param reserve The reserve object
   * @return The normalized income, expressed in ray
   */
  function _getNormalizedIncome(DataTypes.ReserveData memory reserve) internal view returns (uint256) {
    uint40 timestamp = reserve.lastUpdateTimestamp;

    //solium-disable-next-line
    if (timestamp == block.timestamp) {
      //if the index was updated in the same block, no need to perform any calculation
      return reserve.liquidityIndex;
    } else {
      return MathUtils.calculateLinearInterest(reserve.currentLiquidityRate, timestamp).rayMul(reserve.liquidityIndex);
    }
  }

  function metaDeposit(
    address depositor,
    address receiver,
    uint256 assets,
    uint16 referralCode,
    bool depositToAave,
    uint256 deadline,
    PermitParams calldata permit,
    SignatureParams calldata sigParams
  ) external override returns (uint256) {}

  function metaWithdraw(
    address owner,
    address receiver,
    uint256 shares,
    uint256 assets,
    bool withdrawFromAave,
    uint256 deadline,
    SignatureParams calldata sigParams
  ) external override returns (uint256, uint256) {}

  function aToken() external view override returns (IERC20) {}
}
