// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.12;

import {RewardsDataTypes} from './RewardsDataTypes.sol';
import {IERC20Metadata} from '@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {IVotes} from '@openzeppelin/contracts/governance/utils/IVotes.sol';
import {SafeCast} from '@openzeppelin/contracts/utils/math/SafeCast.sol';
import {IRewardsController} from '../../core/interfaces/IRewardsController.sol';
import {IPool} from '../../core/interfaces/IPool.sol';
import {ITransferStrategyBase} from '../../core/interfaces/ITransferStrategyBase.sol';
import {IAggregatorInterface} from '../../core/interfaces/IAggregatorInterface.sol';
import {RewardsDistributor} from './RewardsDistributor.sol';

/**
 * @title IncentivesController
 * @notice Accounting contract to manage multiple staking distributions with multiple rewards
 * @author ZeroLend
 **/
abstract contract IncentivesController is RewardsDistributor, IRewardsController {
  using SafeCast for uint256;

  uint256 public constant REVISION = 3;

  // This mapping allows whitelisted addresses to claim on behalf of others
  // useful for contracts that hold tokens to be rewarded but don't have any native logic to claim Liquidity Mining rewards
  mapping(uint256 => address) internal _authorizedClaimers;

  // reward => transfer strategy implementation contract
  // The TransferStrategy contract abstracts the logic regarding
  // the source of the reward and how to transfer it to the user.
  mapping(address => ITransferStrategyBase) internal _transferStrategy;

  // This mapping contains the price oracle per reward.
  // A price oracle is enforced for integrators to be able to show incentives at
  // the current Aave UI without the need to setup an external price registry
  // At the moment of reward configuration, the Incentives Controller performs
  // a check to see if the provided reward oracle contains `latestAnswer`.
  mapping(address => IAggregatorInterface) internal _rewardOracle;

  modifier onlyAuthorizedClaimers(address claimer, uint256 user) {
    require(_authorizedClaimers[user] == claimer, 'CLAIMER_UNAUTHORIZED');
    _;
  }

  // modifier onlyEmissionManager() {
  //   // todo
  //   _;
  // }

  // constructor(address _emissionManager, address _staking) RewardsDistributor(_emissionManager, _staking) {}

  /**
   * @dev Initialize for RewardsController
   * @dev It expects an address as argument since its initialized via PoolAddressesProvider._updateImpl()
   **/
  // function initialize(address) external initializer {}

  //// @inheritdoc IRewardsController
  function getClaimer(uint256 user) external view returns (address) {
    return _authorizedClaimers[user];
  }

  /**
   * @dev Returns the revision of the implementation contract
   * @return uint256, current revision version
   */
  function getRevision() internal pure returns (uint256) {
    return REVISION;
  }

  //// @inheritdoc IRewardsController
  function getRewardOracle(address reward) external view returns (address) {
    return address(_rewardOracle[reward]);
  }

  //// @inheritdoc IRewardsController
  function getTransferStrategy(address reward) external view returns (address) {
    return address(_transferStrategy[reward]);
  }

  //// @inheritdoc IRewardsController
  function configureAssets(address pool, RewardsDataTypes.RewardsConfigInput[] memory config) external onlyEmissionManager(pool) {
    for (uint256 i = 0; i < config.length; i++) {
      // Get the current Scaled Total Supply of AToken or Debt token
      // todo
      // config[i].totalSupply = IScaledBalanceToken(config[i].asset).scaledTotalSupply();

      // Install TransferStrategy logic at IncentivesController
      _installTransferStrategy(config[i].reward, config[i].transferStrategy);

      // Set reward oracle, enforces input oracle to have latestPrice function
      _setRewardOracle(config[i].reward, config[i].rewardOracle);
    }
    _configureAssets(pool, config);
  }

  //// @inheritdoc IRewardsController
  function _handleSupplies(address pool, address asset, uint256 id) internal {
    _updateData(pool, asset, id, 0, 0);
  }

  function _handleDebt(address pool, address asset, uint256 id) internal {
    _updateData(pool, asset, id, 0, 0); // todo seperate debt and supply
  }

  // //// @inheritdoc IRewardsController
  // function claimRewards(address[] calldata assets, uint256 amount, address to, address reward) external returns (uint256) {
  //   require(to != address(0), 'INVALID_TO_ADDRESS');
  //   return _claimRewards(assets, amount, msg.sender, msg.sender, to, reward);
  // }

  //// @inheritdoc IRewardsController
  function claimRewardsOnBehalf(
    address pool,
    address[] calldata assets,
    uint256 amount,
    uint256 user,
    address to,
    address reward
  ) external onlyAuthorizedClaimers(msg.sender, user) returns (uint256) {
    require(user != uint256(0), 'INVALID_USER_ADDRESS');
    require(to != address(0), 'INVALID_TO_ADDRESS');
    return _claimRewards(pool, assets, amount, msg.sender, user, to, reward);
  }

  // //// @inheritdoc IRewardsController
  // function claimRewardsToSelf(address[] calldata assets, uint256 amount, address reward) external returns (uint256) {
  //   return _claimRewards(assets, amount, msg.sender, msg.sender, msg.sender, reward);
  // }

  //// @inheritdoc IRewardsController
  // function claimAllRewards(address[] calldata assets, address to) external returns (address[] memory rewardsList, uint256[] memory claimedAmounts) {
  //   require(to != address(0), 'INVALID_TO_ADDRESS');
  //   return _claimAllRewards(assets, msg.sender, msg.sender, to);
  // }

  //// @inheritdoc IRewardsController
  function claimAllRewardsOnBehalf(
    address pool,
    address[] calldata assets,
    uint256 user,
    address to
  ) external onlyAuthorizedClaimers(msg.sender, user) returns (address[] memory rewardsList, uint256[] memory claimedAmounts) {
    require(user != uint256(0), 'INVALID_USER_ADDRESS');
    require(to != address(0), 'INVALID_TO_ADDRESS');
    return _claimAllRewards(pool, assets, msg.sender, user, to);
  }

  // //// @inheritdoc IRewardsController
  // function claimAllRewardsToSelf(address[] calldata assets) external returns (address[] memory rewardsList, uint256[] memory claimedAmounts) {
  //   return _claimAllRewards(assets, msg.sender, msg.sender, msg.sender);
  // }

  //// @inheritdoc IRewardsController
  function setClaimer(address pool, uint256 user, address caller) external onlyEmissionManager(pool) {
    _authorizedClaimers[user] = caller;
    emit ClaimerSet(user, caller);
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
  ) internal view override returns (RewardsDataTypes.UserAssetBalance[] memory userAssetBalances) {
    userAssetBalances = new RewardsDataTypes.UserAssetBalance[](assets.length);
    for (uint256 i = 0; i < assets.length; i++) {
      userAssetBalances[i].asset = assets[i];
      // todo
      // (userAssetBalances[i].userBalance, userAssetBalances[i].totalSupply) = IScaledBalanceToken(assets[i]).getScaledUserBalanceAndSupply(user);
    }
    return userAssetBalances;
  }

  /**
   * @dev Claims one type of reward for a user on behalf, on all the assets of the pool, accumulating the pending rewards.
   * @param assets List of assets to check eligible distributions before claiming rewards
   * @param amount Amount of rewards to claim
   * @param claimer Address of the claimer who claims rewards on behalf of user
   * @param user Address to check and claim rewards
   * @param to Address that will be receiving the rewards
   * @param reward Address of the reward token
   * @return Rewards claimed
   **/
  function _claimRewards(address pool, address[] calldata assets, uint256 amount, address claimer, uint256 user, address to, address reward) internal returns (uint256) {
    if (amount == 0) {
      return 0;
    }
    uint256 totalRewards;

    _updateDataMultiple(pool, user, _getUserAssetBalances(pool, assets, user));
    for (uint256 i = 0; i < assets.length; i++) {
      address asset = assets[i];
      totalRewards += _poolAssets[pool][asset].rewards[reward].usersData[user].accrued;

      if (totalRewards <= amount) {
        _poolAssets[pool][asset].rewards[reward].usersData[user].accrued = 0;
      } else {
        uint256 difference = totalRewards - amount;
        totalRewards -= difference;
        _poolAssets[pool][asset].rewards[reward].usersData[user].accrued = difference.toUint128();
        break;
      }
    }

    if (totalRewards == 0) {
      return 0;
    }

    _transferRewards(to, reward, totalRewards);
    emit RewardsClaimed(user, reward, to, claimer, totalRewards);

    return totalRewards;
  }

  /**
   * @dev Claims one type of reward for a user on behalf, on all the assets of the pool, accumulating the pending rewards.
   * @param assets List of assets to check eligible distributions before claiming rewards
   * @param claimer Address of the claimer on behalf of user
   * @param user Address to check and claim rewards
   * @param to Address that will be receiving the rewards
   * @return
   *   rewardsList List of reward addresses
   *   claimedAmount List of claimed amounts, follows "rewardsList" items order
   **/
  function _claimAllRewards(
    address pool,
    address[] calldata assets,
    address claimer,
    uint256 user,
    address to
  ) internal returns (address[] memory rewardsList, uint256[] memory claimedAmounts) {
    uint256 rewardsListLength = _poolRewardsList[pool].length;
    rewardsList = new address[](rewardsListLength);
    claimedAmounts = new uint256[](rewardsListLength);

    _updateDataMultiple(pool, user, _getUserAssetBalances(pool, assets, user));

    for (uint256 i = 0; i < assets.length; i++) {
      address asset = assets[i];
      for (uint256 j = 0; j < rewardsListLength; j++) {
        if (rewardsList[j] == address(0)) {
          rewardsList[j] = _poolRewardsList[pool][j];
        }
        uint256 rewardAmount = _poolAssets[pool][asset].rewards[rewardsList[j]].usersData[user].accrued;
        if (rewardAmount != 0) {
          claimedAmounts[j] += rewardAmount;
          _poolAssets[pool][asset].rewards[rewardsList[j]].usersData[user].accrued = 0;
        }
      }
    }
    for (uint256 i = 0; i < rewardsListLength; i++) {
      _transferRewards(to, rewardsList[i], claimedAmounts[i]);
      emit RewardsClaimed(user, rewardsList[i], to, claimer, claimedAmounts[i]);
    }
    return (rewardsList, claimedAmounts);
  }

  /**
   * @dev Function to transfer rewards to the desired account using delegatecall and
   * @param to Account address to send the rewards
   * @param reward Address of the reward token
   * @param amount Amount of rewards to transfer
   */
  function _transferRewards(address to, address reward, uint256 amount) internal {
    ITransferStrategyBase transferStrategy = _transferStrategy[reward];

    bool success = transferStrategy.performTransfer(to, reward, amount);

    require(success == true, 'TRANSFER_ERROR');
  }

  /**
   * @dev Returns true if `account` is a contract.
   * @param account The address of the account
   * @return bool, true if contract, false otherwise
   */
  function _isContract(address account) internal view returns (bool) {
    // This method relies on extcodesize, which returns 0 for contracts in
    // construction, since the code is only stored at the end of the
    // constructor execution.

    uint256 size;
    // solhint-disable-next-line no-inline-assembly
    assembly {
      size := extcodesize(account)
    }
    return size > 0;
  }

  /**
   * @dev Internal function to call the optional install hook at the TransferStrategy
   * @param reward The address of the reward token
   * @param transferStrategy The address of the reward TransferStrategy
   */
  function _installTransferStrategy(address reward, ITransferStrategyBase transferStrategy) internal {
    require(address(transferStrategy) != address(0), 'STRATEGY_CAN_NOT_BE_ZERO');
    require(_isContract(address(transferStrategy)) == true, 'STRATEGY_MUST_BE_CONTRACT');

    _transferStrategy[reward] = transferStrategy;

    emit TransferStrategyInstalled(reward, address(transferStrategy));
  }

  /**
   * @dev Update the Price Oracle of a reward token. The Price Oracle must follow Chainlink IEACAggregatorProxy interface.
   * @notice The Price Oracle of a reward is used for displaying correct data about the incentives at the UI frontend.
   * @param reward The address of the reward token
   * @param rewardOracle The address of the price oracle
   */

  function _setRewardOracle(address reward, IAggregatorInterface rewardOracle) internal {
    require(rewardOracle.latestAnswer() > 0, 'ORACLE_MUST_RETURN_PRICE');
    _rewardOracle[reward] = rewardOracle;
    emit RewardOracleUpdated(reward, address(rewardOracle));
  }

  function setDistributionEnd(address asset, address reward, uint32 newDistributionEnd) external {}

  function setEmissionPerSecond(address asset, address[] calldata rewards, uint88[] calldata newEmissionsPerSecond) external {}

  function getDistributionEnd(address asset, address reward) external view returns (uint256) {}

  function getUserAssetIndex(uint256 user, address asset, address reward) external view returns (uint256) {}

  function getRewardsData(address asset, address reward) external view returns (uint256, uint256, uint256, uint256) {}

  function getAssetIndex(address asset, address reward) external view returns (uint256, uint256) {}

  function getRewardsByAsset(address asset) external view returns (address[] memory) {}

  function getRewardsList() external view returns (address[] memory) {}

  function getUserAccruedRewards(uint256 user, address reward) external view returns (uint256) {}

  function getUserRewards(address[] calldata assets, uint256 user, address reward) external view returns (uint256) {}

  function getAllUserRewards(address[] calldata assets, uint256 user) external view returns (address[] memory, uint256[] memory) {}

  function getAssetDecimals(address asset) external view returns (uint8) {}

  function setTransferStrategy(address reward, ITransferStrategyBase transferStrategy) external {}

  function setRewardOracle(address reward, IAggregatorInterface rewardOracle) external {}

  function configureAssets(RewardsDataTypes.RewardsConfigInput[] memory config) external {}

  function setClaimer(uint256 user, address claimer) external {}

  function getClaimer(address user) external view returns (address) {}

  function handleAction(address user, uint256 totalSupply, uint256 userBalance) external {}

  function claimRewards(address pool, address[] calldata assets, uint256 amount, address to, address reward) external returns (uint256) {}

  function claimRewardsOnBehalf(address[] calldata assets, uint256 amount, address user, address to, address reward) external returns (uint256) {}

  function claimRewardsToSelf(address pool, address[] calldata assets, uint256 amount, address reward) external returns (uint256) {}

  function claimAllRewards(address pool, address[] calldata assets, address to) external returns (address[] memory rewardsList, uint256[] memory claimedAmounts) {}

  function claimAllRewardsOnBehalf(address[] calldata assets, address user, address to) external returns (address[] memory rewardsList, uint256[] memory claimedAmounts) {}

  function claimAllRewardsToSelf(address pool, address[] calldata assets) external returns (address[] memory rewardsList, uint256[] memory claimedAmounts) {}
}
