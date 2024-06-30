// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.12;

import {RewardsDataTypes} from './RewardsDataTypes.sol';
import {IERC20Metadata} from '@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {IVotes} from '@openzeppelin/contracts/governance/utils/IVotes.sol';
import {SafeCast} from '@openzeppelin/contracts/utils/math/SafeCast.sol';
import {IRewardsDistributor} from '../../core/interfaces/IRewardsDistributor.sol';
import {IPool} from '../../core/interfaces/IPool.sol';

/**
 * @title RewardsDistributor
 * @notice Accounting contract to manage multiple staking distributions with multiple rewards
 * @author ZeroLend
 **/
abstract contract RewardsDistributor is IRewardsDistributor {
  using SafeCast for uint256;

  // Map of rewarded asset addresses and their data (assetAddress => assetData)
  // mapping(address => RewardsDataTypes.AssetData) internal _poolAssets;

  /// @dev Map of rewarded asset addresses and their data (assetAddress => assetData)
  mapping(address pool => mapping(address asset => RewardsDataTypes.AssetData data)) internal _poolAssets;

  // Map of reward assets (rewardAddress => enabled)
  // mapping(address => bool) internal _isPoolRewardEnabled[pool];

  mapping(address pool => mapping(address asset => bool enabled)) internal _isPoolRewardEnabled;

  // Rewards list
  // address[] internal _poolRewardsList[pool];

  mapping(address pool => address[] rewards) internal _poolRewardsList;

  // Assets list
  // address[] internal _poolRewardsList[pool];

  // Assets list
  mapping(address pool => address[] assets) internal _poolAssetList;

  uint256 internal _maxBoostRequirement;

  IVotes internal _staking;

  modifier onlyEmissionManager(address pool) {
    // require(msg.sender == EMISSION_MANAGER, 'ONLY_EMISSION_MANAGER');
    _;
  }

  function __RewardsDistributor_init(uint256 maxBoostRequirement_, address staking_) internal {
    _maxBoostRequirement = maxBoostRequirement_;
    _staking = IVotes(staking_);
  }

  //// @inheritdoc IRewardsDistributor
  function getRewardsData(address pool, address asset, address reward) public view returns (uint256, uint256, uint256, uint256) {
    return (
      _poolAssets[pool][asset].rewards[reward].index,
      _poolAssets[pool][asset].rewards[reward].emissionPerSecond,
      _poolAssets[pool][asset].rewards[reward].lastUpdateTimestamp,
      _poolAssets[pool][asset].rewards[reward].distributionEnd
    );
  }

  //// @inheritdoc IRewardsDistributor
  function getAssetIndex(address pool, address asset, address reward) external view returns (uint256, uint256) {
    RewardsDataTypes.RewardData storage rewardData = _poolAssets[pool][asset].rewards[reward];
    return (0, 0);
    // return _getAssetIndex(rewardData, IScaledBalanceToken(asset).scaledTotalSupply(), 10 ** _poolAssets[pool][asset].decimals);
  }

  //// @inheritdoc IRewardsDistributor
  function getDistributionEnd(address pool, address asset, address reward) external view returns (uint256) {
    return _poolAssets[pool][asset].rewards[reward].distributionEnd;
  }

  //// @inheritdoc IRewardsDistributor
  function getRewardsByAsset(address pool, address asset) external view returns (address[] memory) {
    uint128 rewardsCount = _poolAssets[pool][asset].availableRewardsCount;
    address[] memory availableRewards = new address[](rewardsCount);

    for (uint128 i = 0; i < rewardsCount; i++) {
      availableRewards[i] = _poolAssets[pool][asset].availableRewards[i];
    }
    return availableRewards;
  }

  //// @inheritdoc IRewardsDistributor
  function getRewardsList(address pool) external view returns (address[] memory) {
    return _poolRewardsList[pool];
  }

  //// @inheritdoc IRewardsDistributor
  function getUserAssetIndex(address pool, uint256 user, address asset, address reward) public view returns (uint256) {
    return _poolAssets[pool][asset].rewards[reward].usersData[user].index;
  }

  //// @inheritdoc IRewardsDistributor
  function getUserAccruedRewards(address pool, uint256 user, address reward) external view returns (uint256) {
    uint256 totalAccrued;
    for (uint256 i = 0; i < _poolRewardsList[pool].length; i++) {
      totalAccrued += _poolAssets[pool][_poolRewardsList[pool][i]].rewards[reward].usersData[user].accrued;
    }

    return totalAccrued;
  }

  //// @inheritdoc IRewardsDistributor
  function getUserRewards(address pool, address[] calldata assets, uint256 user, address reward) external view returns (uint256) {
    return _getUserReward(pool, user, reward, _getUserAssetBalances(pool, assets, user));
  }

  //// @inheritdoc IRewardsDistributor
  function getAllUserRewards(address pool, address[] calldata assets, uint256 user) external view returns (address[] memory rewardsList, uint256[] memory unclaimedAmounts) {
    RewardsDataTypes.UserAssetBalance[] memory userAssetBalances = _getUserAssetBalances(pool, assets, user);
    rewardsList = new address[](_poolRewardsList[pool].length);
    unclaimedAmounts = new uint256[](rewardsList.length);

    // Add unrealized rewards from user to unclaimedRewards
    for (uint256 i = 0; i < userAssetBalances.length; i++) {
      for (uint256 r = 0; r < rewardsList.length; r++) {
        rewardsList[r] = _poolRewardsList[pool][r];
        unclaimedAmounts[r] += _poolAssets[pool][userAssetBalances[i].asset].rewards[rewardsList[r]].usersData[user].accrued;

        if (userAssetBalances[i].userBalance == 0) {
          continue;
        }
        unclaimedAmounts[r] += _getPendingRewards(pool, user, rewardsList[r], userAssetBalances[i]);
      }
    }
    return (rewardsList, unclaimedAmounts);
  }

  /**
   * @dev Calculates the boosted balance for an account.
   * @param account The address of the account for which to calculate the boosted balance.
   * @return The boosted balance of the account.
   **/
  function boostedBalance(address account, uint256 balance) public view returns (uint256) {
    uint256 _boosted = (balance * 20) / 100;
    uint256 _stake = _staking.getVotes(account);

    uint256 _adjusted = ((balance * _stake * 80) / _maxBoostRequirement) / 100;

    // because of this we are able to max out the boost by 5x
    uint256 _boostedBalance = _boosted + _adjusted;
    return _boostedBalance > balance ? balance : _boostedBalance;
  }

  /**
   * @dev Configure the _poolAssets for a specific emission
   * @param rewardsInput The array of each asset configuration
   **/
  function _configureAssets(address pool, RewardsDataTypes.RewardsConfigInput[] memory rewardsInput) internal {
    for (uint256 i = 0; i < rewardsInput.length; i++) {
      if (_poolAssets[pool][rewardsInput[i].asset].decimals == 0) {
        // never initialized before, adding to the list of assets
        _poolRewardsList[pool].push(rewardsInput[i].asset);
      }

      // todo
      uint256 decimals = _poolAssets[pool][rewardsInput[i].asset].decimals = 0; // IERC20Detailed(rewardsInput[i].asset).decimals();

      RewardsDataTypes.RewardData storage rewardConfig = _poolAssets[pool][rewardsInput[i].asset].rewards[rewardsInput[i].reward];

      // Add reward address to asset available rewards if latestUpdateTimestamp is zero
      if (rewardConfig.lastUpdateTimestamp == 0) {
        _poolAssets[pool][rewardsInput[i].asset].availableRewards[_poolAssets[pool][rewardsInput[i].asset].availableRewardsCount] = rewardsInput[i].reward;
        _poolAssets[pool][rewardsInput[i].asset].availableRewardsCount++;
      }

      // Add reward address to global rewards list if still not enabled
      if (_isPoolRewardEnabled[pool][rewardsInput[i].reward] == false) {
        _isPoolRewardEnabled[pool][rewardsInput[i].reward] = true;
        _poolRewardsList[pool].push(rewardsInput[i].reward);
      }

      // Due emissions is still zero, updates only latestUpdateTimestamp
      (uint256 newIndex, ) = _updateRewardData(rewardConfig, rewardsInput[i].totalSupply, 10 ** decimals);

      // Configure emission and distribution end of the reward per asset
      uint88 oldEmissionsPerSecond = rewardConfig.emissionPerSecond;
      uint32 oldDistributionEnd = rewardConfig.distributionEnd;
      rewardConfig.emissionPerSecond = rewardsInput[i].emissionPerSecond;
      rewardConfig.distributionEnd = rewardsInput[i].distributionEnd;

      emit AssetConfigUpdated(
        rewardsInput[i].asset,
        rewardsInput[i].reward,
        oldEmissionsPerSecond,
        rewardsInput[i].emissionPerSecond,
        oldDistributionEnd,
        rewardsInput[i].distributionEnd,
        newIndex
      );
    }
  }

  /**
   * @dev Updates the state of the distribution for the specified reward
   * @param rewardData Storage pointer to the distribution reward config
   * @param totalSupply Current total of underlying assets for this distribution
   * @param assetUnit One unit of asset (10**decimals)
   * @return The new distribution index
   * @return True if the index was updated, false otherwise
   **/
  function _updateRewardData(RewardsDataTypes.RewardData storage rewardData, uint256 totalSupply, uint256 assetUnit) internal returns (uint256, bool) {
    (uint256 oldIndex, uint256 newIndex) = _getAssetIndex(rewardData, totalSupply, assetUnit);
    bool indexUpdated;
    if (newIndex != oldIndex) {
      require(newIndex <= type(uint104).max, 'INDEX_OVERFLOW');
      indexUpdated = true;

      //optimization: storing one after another saves one SSTORE
      rewardData.index = uint104(newIndex);
      rewardData.lastUpdateTimestamp = block.timestamp.toUint32();
    } else {
      rewardData.lastUpdateTimestamp = block.timestamp.toUint32();
    }

    return (newIndex, indexUpdated);
  }

  /**
   * @dev Updates the state of the distribution for the specific user
   * @param rewardData Storage pointer to the distribution reward config
   * @param user The address of the user
   * @param userBalance The user balance of the asset
   * @param newAssetIndex The new index of the asset distribution
   * @param assetUnit One unit of asset (10**decimals)
   * @return The rewards accrued since the last update
   **/
  function _updateUserData(
    RewardsDataTypes.RewardData storage rewardData,
    uint256 user,
    uint256 userBalance,
    uint256 newAssetIndex,
    uint256 assetUnit
  ) internal returns (uint256, bool) {
    // recalculate user balance based on boost
    // userBalance = boostedBalance(user, userBalance);

    uint256 userIndex = rewardData.usersData[user].index;
    uint256 rewardsAccrued;
    bool dataUpdated;
    if ((dataUpdated = userIndex != newAssetIndex)) {
      // already checked for overflow in _updateRewardData
      rewardData.usersData[user].index = uint104(newAssetIndex);
      if (userBalance != 0) {
        rewardsAccrued = _getRewards(userBalance, newAssetIndex, userIndex, assetUnit);

        rewardData.usersData[user].accrued += rewardsAccrued.toUint128();
      }
    }
    return (rewardsAccrued, dataUpdated);
  }

  /**
   * @dev Iterates and accrues all the rewards for asset of the specific user
   * @param asset The address of the reference asset of the distribution
   * @param user The user address
   * @param userBalance The current user asset balance
   * @param totalSupply Total supply of the asset
   **/
  function _updateData(address pool, address asset, uint256 user, uint256 userBalance, uint256 totalSupply) internal {
    uint256 assetUnit;
    uint256 numAvailableRewards = _poolAssets[pool][asset].availableRewardsCount;
    unchecked {
      assetUnit = 10 ** _poolAssets[pool][asset].decimals;
    }

    if (numAvailableRewards == 0) {
      return;
    }
    unchecked {
      for (uint128 r = 0; r < numAvailableRewards; r++) {
        address reward = _poolAssets[pool][asset].availableRewards[r];
        RewardsDataTypes.RewardData storage rewardData = _poolAssets[pool][asset].rewards[reward];

        (uint256 newAssetIndex, bool rewardDataUpdated) = _updateRewardData(rewardData, totalSupply, assetUnit);

        (uint256 rewardsAccrued, bool userDataUpdated) = _updateUserData(rewardData, user, userBalance, newAssetIndex, assetUnit);

        if (rewardDataUpdated || userDataUpdated) {
          // todo
          // emit Accrued(asset, reward, user, newAssetIndex, newAssetIndex, rewardsAccrued);
        }
      }
    }
  }

  /**
   * @dev Accrues all the rewards of the assets specified in the userAssetBalances list
   * @param user The address of the user
   * @param userAssetBalances List of structs with the user balance and total supply of a set of assets
   **/
  function _updateDataMultiple(address pool, uint256 user, RewardsDataTypes.UserAssetBalance[] memory userAssetBalances) internal {
    for (uint256 i = 0; i < userAssetBalances.length; i++) {
      _updateData(pool, userAssetBalances[i].asset, user, userAssetBalances[i].userBalance, userAssetBalances[i].totalSupply);
    }
  }

  /**
   * @dev Return the accrued unclaimed amount of a reward from a user over a list of distribution
   * @param user The address of the user
   * @param reward The address of the reward token
   * @param userAssetBalances List of structs with the user balance and total supply of a set of assets
   * @return unclaimedRewards The accrued rewards for the user until the moment
   **/
  function _getUserReward(
    address pool,
    uint256 user,
    address reward,
    RewardsDataTypes.UserAssetBalance[] memory userAssetBalances
  ) internal view returns (uint256 unclaimedRewards) {
    // Add unrealized rewards
    for (uint256 i = 0; i < userAssetBalances.length; i++) {
      if (userAssetBalances[i].userBalance == 0) {
        unclaimedRewards += _poolAssets[pool][userAssetBalances[i].asset].rewards[reward].usersData[user].accrued;
      } else {
        unclaimedRewards += _getPendingRewards(pool, user, reward, userAssetBalances[i]) + _poolAssets[pool][userAssetBalances[i].asset].rewards[reward].usersData[user].accrued;
      }
    }

    return unclaimedRewards;
  }

  /**
   * @dev Calculates the pending (not yet accrued) rewards since the last user action
   * @param user The address of the user
   * @param reward The address of the reward token
   * @param userAssetBalance struct with the user balance and total supply of the incentivized asset
   * @return The pending rewards for the user since the last user action
   **/
  function _getPendingRewards(address pool, uint256 user, address reward, RewardsDataTypes.UserAssetBalance memory userAssetBalance) internal view returns (uint256) {
    RewardsDataTypes.RewardData storage rewardData = _poolAssets[pool][userAssetBalance.asset].rewards[reward];
    uint256 assetUnit = 10 ** _poolAssets[pool][userAssetBalance.asset].decimals;
    (, uint256 nextIndex) = _getAssetIndex(rewardData, userAssetBalance.totalSupply, assetUnit);

    return _getRewards(userAssetBalance.userBalance, nextIndex, rewardData.usersData[user].index, assetUnit);
  }

  /**
   * @dev Internal function for the calculation of user's rewards on a distribution
   * @param userBalance Balance of the user asset on a distribution
   * @param reserveIndex Current index of the distribution
   * @param userIndex Index stored for the user, representation his staking moment
   * @param assetUnit One unit of asset (10**decimals)
   * @return The rewards
   **/
  function _getRewards(uint256 userBalance, uint256 reserveIndex, uint256 userIndex, uint256 assetUnit) internal pure returns (uint256) {
    uint256 result = userBalance * (reserveIndex - userIndex);
    assembly {
      result := div(result, assetUnit)
    }
    return result;
  }

  /**
   * @dev Calculates the next value of an specific distribution index, with validations
   * @param rewardData Storage pointer to the distribution reward config
   * @param totalSupply of the asset being rewarded
   * @param assetUnit One unit of asset (10**decimals)
   * @return The new index.
   **/
  function _getAssetIndex(RewardsDataTypes.RewardData storage rewardData, uint256 totalSupply, uint256 assetUnit) internal view returns (uint256, uint256) {
    uint256 oldIndex = rewardData.index;
    uint256 distributionEnd = rewardData.distributionEnd;
    uint256 emissionPerSecond = rewardData.emissionPerSecond;
    uint256 lastUpdateTimestamp = rewardData.lastUpdateTimestamp;

    if (emissionPerSecond == 0 || totalSupply == 0 || lastUpdateTimestamp == block.timestamp || lastUpdateTimestamp >= distributionEnd) {
      return (oldIndex, oldIndex);
    }

    uint256 currentTimestamp = block.timestamp > distributionEnd ? distributionEnd : block.timestamp;
    uint256 timeDelta = currentTimestamp - lastUpdateTimestamp;
    uint256 firstTerm = emissionPerSecond * timeDelta * assetUnit;
    assembly {
      firstTerm := div(firstTerm, totalSupply)
    }
    return (oldIndex, (firstTerm + oldIndex));
  }

  /**
   * @dev Get user balances and total supply of all the assets specified by the assets parameter
   * @param assets List of assets to retrieve user balance and total supply
   * @param user Address of the user
   * @return userAssetBalances contains a list of structs with user balance and total supply of the given assets
   */
  function _getUserAssetBalances(
    address pool,
    address[] calldata assets,
    uint256 user
  ) internal view virtual returns (RewardsDataTypes.UserAssetBalance[] memory userAssetBalances);

  //// @inheritdoc IRewardsDistributor
  function getAssetDecimals(address pool, address asset) external view returns (uint8) {
    return _poolAssets[pool][asset].decimals;
  }

  // //// @inheritdoc IRewardsDistributor
  // function getEmissionManager() external view returns (address) {
  //   return EMISSION_MANAGER;
  // }
}
