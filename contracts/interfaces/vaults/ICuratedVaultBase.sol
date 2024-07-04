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

import {IPool} from '../IPool.sol';
import {IERC4626} from '@openzeppelin/contracts/interfaces/IERC4626.sol';
import {IERC20Permit} from '@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol';

struct MarketAllocation {
  /// @notice The market to allocate.
  IPool market;
  /// @notice The amount of assets to allocate.
  uint256 assets;
}

struct MarketConfig {
  /// @notice The maximum amount of assets that can be allocated to the market.
  uint184 cap;
  /// @notice Whether the market is in the withdraw queue.
  bool enabled;
  /// @notice The timestamp at which the market can be instantly removed from the withdraw queue.
  uint64 removableAt;
}

struct PendingUint192 {
  /// @notice The pending value to set.
  uint192 value;
  /// @notice The timestamp at which the pending value becomes valid.
  uint64 validAt;
}

struct PendingAddress {
  /// @notice The pending value to set.
  address value;
  /// @notice The timestamp at which the pending value becomes valid.
  uint64 validAt;
}

/// @dev This interface is used for factorizing ICuratedVaultStaticTyping and ICuratedVault.
/// @dev Consider using the ICuratedVault interface instead of this one.
interface ICuratedVaultBase {
  /// @notice Thrown when the address passed is the zero address.
  error ZeroAddress();

  /// @notice Thrown when the caller doesn't have the curator role.
  error NotCuratorRole();

  /// @notice Thrown when the caller doesn't have the allocator role.
  error NotAllocatorRole();

  /// @notice Thrown when the caller doesn't have the guardian role.
  error NotGuardianRole();

  /// @notice Thrown when the caller doesn't have the curator nor the guardian role.
  error NotCuratorNorGuardianRole();

  /// @notice Thrown when the market `id` cannot be set in the supply queue.
  error UnauthorizedMarket(IPool id);

  /// @notice Thrown when submitting a cap for a market `id` whose loan token does not correspond to the underlying.
  /// asset.
  error InconsistentAsset(IPool id);

  /// @notice Thrown when the supply cap has been exceeded on market `id` during a reallocation of funds.
  error SupplyCapExceeded(IPool id);

  /// @notice Thrown when the fee to set exceeds the maximum fee.
  error MaxFeeExceeded();

  /// @notice Thrown when the value is already set.
  error AlreadySet();

  /// @notice Thrown when a value is already pending.
  error AlreadyPending();

  error MaxUint128Exceeded();

  /// @notice Thrown when submitting the removal of a market when there is a cap already pending on that market.
  error PendingCap(IPool id);

  /// @notice Thrown when submitting a cap for a market with a pending removal.
  error PendingRemoval();

  /// @notice Thrown when submitting a market removal for a market with a non zero cap.
  error NonZeroCap();

  /// @notice Thrown when market `id` is a duplicate in the new withdraw queue to set.
  error DuplicateMarket(IPool id);

  /// @notice Thrown when market `id` is missing in the updated withdraw queue and the market has a non-zero cap set.
  error InvalidMarketRemovalNonZeroCap(IPool id);

  /// @notice Thrown when market `id` is missing in the updated withdraw queue and the market has a non-zero supply.
  error InvalidMarketRemovalNonZeroSupply(IPool id);

  /// @notice Thrown when market `id` is missing in the updated withdraw queue and the market is not yet disabled.
  error InvalidMarketRemovalTimelockNotElapsed(IPool id);

  /// @notice Thrown when there's no pending value to set.
  error NoPendingValue();

  /// @notice Thrown when the requested liquidity cannot be withdrawn from ZeroLend.
  error NotEnoughLiquidity();

  /// @notice Thrown when submitting a cap for a market which does not exist.
  error MarketNotCreated();

  /// @notice Thrown when interacting with a non previously enabled market `id`.
  error MarketNotEnabled(IPool id);

  /// @notice Thrown when the submitted timelock is above the max timelock.
  error AboveMaxTimelock();

  /// @notice Thrown when the submitted timelock is below the min timelock.
  error BelowMinTimelock();

  /// @notice Thrown when the timelock is not elapsed.
  error TimelockNotElapsed();

  /// @notice Thrown when too many markets are in the withdraw queue.
  error MaxQueueLengthExceeded();

  /// @notice Thrown when setting the fee to a non zero value while the fee recipient is the zero address.
  error ZeroFeeRecipient();

  /// @notice Thrown when the amount withdrawn is not exactly the amount supplied.
  error InconsistentReallocation();

  /// @notice Thrown when all caps have been reached.
  error AllCapsReached();

  /// @notice Emitted when a pending `newTimelock` is submitted.
  event SubmitTimelock(uint256 newTimelock);

  /// @notice Emitted when `timelock` is set to `newTimelock`.
  event SetTimelock(address indexed caller, uint256 newTimelock);

  /// @notice Emitted when `skimRecipient` is set to `newSkimRecipient`.
  event SetSkimRecipient(address indexed newSkimRecipient);

  /// @notice Emitted `fee` is set to `newFee`.
  event SetFee(address indexed caller, uint256 newFee);

  /// @notice Emitted when a new `newFeeRecipient` is set.
  event SetFeeRecipient(address indexed newFeeRecipient);

  /// @notice Emitted when a pending `newGuardian` is submitted.
  event SubmitGuardian(address indexed newGuardian);

  /// @notice Emitted when `guardian` is set to `newGuardian`.
  event SetGuardian(address indexed caller, address indexed guardian);

  /// @notice Emitted when a pending `cap` is submitted for market identified by `id`.
  event SubmitCap(address indexed caller, IPool indexed pool, uint256 cap);

  /// @notice Emitted when a new `cap` is set for market identified by `id`.
  event SetCap(address indexed caller, IPool indexed pool, uint256 cap);

  /// @notice Emitted when the vault's last total assets is updated to `updatedTotalAssets`.
  event UpdateLastTotalAssets(uint256 updatedTotalAssets);

  /// @notice Emitted when the market identified by `id` is submitted for removal.
  event SubmitMarketRemoval(address indexed caller, IPool indexed pool);

  /// @notice Emitted when `curator` is set to `newCurator`.
  event SetCurator(address indexed newCurator);

  /// @notice Emitted when an `allocator` is set to `isAllocator`.
  event SetIsAllocator(address indexed allocator, bool isAllocator);

  /// @notice Emitted when a `pendingTimelock` is revoked.
  event RevokePendingTimelock(address indexed caller);

  /// @notice Emitted when a `pendingCap` for the market identified by `id` is revoked.
  event RevokePendingCap(address indexed caller, IPool indexed pool);

  /// @notice Emitted when a `pendingGuardian` is revoked.
  event RevokePendingGuardian(address indexed caller);

  /// @notice Emitted when a pending market removal is revoked.
  event RevokePendingMarketRemoval(address indexed caller, IPool indexed pool);

  /// @notice Emitted when the `supplyQueue` is set to `newSupplyQueue`.
  event SetSupplyQueue(address indexed caller, IPool[] newSupplyQueue);

  /// @notice Emitted when the `withdrawQueue` is set to `newWithdrawQueue`.
  event SetWithdrawQueue(address indexed caller, IPool[] newWithdrawQueue);

  /// @notice Emitted when a reallocation supplies assets to the market identified by `id`.
  /// @param pool The id of the market.
  /// @param suppliedAssets The amount of assets supplied to the market.
  /// @param suppliedShares The amount of shares minted.
  event ReallocateSupply(address indexed caller, address indexed pool, uint256 suppliedAssets, uint256 suppliedShares);

  /// @notice Emitted when a reallocation withdraws assets from the market identified by `id`.
  /// @param pool The id of the market.
  /// @param withdrawnAssets The amount of assets withdrawn from the market.
  /// @param withdrawnShares The amount of shares burned.
  event ReallocateWithdraw(address indexed caller, address indexed pool, uint256 withdrawnAssets, uint256 withdrawnShares);

  /// @notice Emitted when interest are accrued.
  /// @param newTotalAssets The assets of the vault after accruing the interest but before the interaction.
  /// @param feeShares The shares minted to the fee recipient.
  event AccrueInterest(uint256 newTotalAssets, uint256 feeShares);

  /// @notice Emitted when an `amount` of `token` is transferred to the skim recipient by `caller`.
  event Skim(address indexed caller, address indexed token, uint256 amount);

  /// @notice Emitted when a new vault is created.
  /// @param vault The address of the vault.
  /// @param caller The caller of the function.
  /// @param initialOwner The initial owner of the vault.
  /// @param initialTimelock The initial timelock of the vault.
  /// @param asset The address of the underlying asset.
  /// @param name The name of the vault.
  /// @param symbol The symbol of the vault.
  /// @param salt The salt used for the vault's CREATE2 address.
  event CreateVault(
    address indexed vault,
    address indexed caller,
    address initialOwner,
    uint256 initialTimelock,
    address indexed asset,
    string name,
    string symbol,
    bytes32 salt
  );

  function DECIMALS_OFFSET() external view returns (uint8);

  /// @notice The address of the curator.
  function curator() external view returns (address);

  /// @notice Stores whether an address is an allocator or not.
  function isAllocator(address target) external view returns (bool);

  /// @notice The current guardian. Can be set even without the timelock set.
  function guardian() external view returns (address);

  /// @notice The current fee.
  function fee() external view returns (uint96);

  /// @notice The fee recipient.
  function feeRecipient() external view returns (address);

  /// @notice The skim recipient.
  function skimRecipient() external view returns (address);

  /// @notice The current timelock.
  function timelock() external view returns (uint256);

  /// @dev Stores the order of markets on which liquidity is supplied upon deposit.
  /// @dev Can contain any market. A market is skipped as soon as its supply cap is reached.
  function supplyQueue(uint256) external view returns (IPool);

  /// @notice Returns the length of the supply queue.
  function supplyQueueLength() external view returns (uint256);

  /// @dev Stores the order of markets from which liquidity is withdrawn upon withdrawal.
  /// @dev Always contain all non-zero cap markets as well as all markets on which the vault supplies liquidity,
  /// without duplicate.
  function withdrawQueue(uint256) external view returns (IPool);

  /// @notice Returns the length of the withdraw queue.
  function withdrawQueueLength() external view returns (uint256);

  /// @notice Stores the total assets managed by this vault when the fee was last accrued.
  /// @dev May be greater than `totalAssets()` due to removal of markets with non-zero supply or socialized bad debt.
  /// This difference will decrease the fee accrued until one of the functions updating `lastTotalAssets` is
  /// triggered (deposit/mint/withdraw/redeem/setFee/setFeeRecipient).
  function lastTotalAssets() external view returns (uint256);

  /// @notice Submits a `newTimelock`.
  /// @dev Warning: Reverts if a timelock is already pending. Revoke the pending timelock to overwrite it.
  /// @dev In case the new timelock is higher than the current one, the timelock is set immediately.
  function submitTimelock(uint256 newTimelock) external;

  /// @notice Accepts the pending timelock.
  function acceptTimelock() external;

  /// @notice Revokes the pending timelock.
  /// @dev Does not revert if there is no pending timelock.
  function revokePendingTimelock() external;

  /// @notice Submits a `newSupplyCap` for the market defined by `marketParams`.
  /// @dev Warning: Reverts if a cap is already pending. Revoke the pending cap to overwrite it.
  /// @dev Warning: Reverts if a market removal is pending.
  /// @dev In case the new cap is lower than the current one, the cap is set immediately.
  function submitCap(IPool pool, uint256 newSupplyCap) external;

  /// @notice Accepts the pending cap of the market defined by `marketParams`.
  function acceptCap(IPool pool) external;

  /// @notice Revokes the pending cap of the market defined by `id`.
  /// @dev Does not revert if there is no pending cap.
  function revokePendingCap(IPool id) external;

  /// @notice Submits a forced market removal from the vault, eventually losing all funds supplied to the market.
  /// @notice Funds can be recovered by enabling this market again and withdrawing from it (using `reallocate`),
  /// but funds will be distributed pro-rata to the shares at the time of withdrawal, not at the time of removal.
  /// @notice This forced removal is expected to be used as an emergency process in case a market constantly reverts.
  /// To softly remove a sane market, the curator role is expected to bundle a reallocation that empties the market
  /// first (using `reallocate`), followed by the removal of the market (using `updateWithdrawQueue`).
  /// @dev Warning: Removing a market with non-zero supply will instantly impact the vault's price per share.
  /// @dev Warning: Reverts for non-zero cap or if there is a pending cap. Successfully submitting a zero cap will
  /// prevent such reverts.
  function submitMarketRemoval(IPool pool) external;

  /// @notice Revokes the pending removal of the market defined by `id`.
  /// @dev Does not revert if there is no pending market removal.
  function revokePendingMarketRemoval(IPool id) external;

  /// @notice Submits a `newGuardian`.
  /// @notice Warning: a malicious guardian could disrupt the vault's operation, and would have the power to revoke
  /// any pending guardian.
  /// @dev In case there is no guardian, the gardian is set immediately.
  /// @dev Warning: Submitting a gardian will overwrite the current pending gardian.
  function submitGuardian(address newGuardian) external;

  /// @notice Accepts the pending guardian.
  function acceptGuardian() external;

  /// @notice Revokes the pending guardian.
  function revokePendingGuardian() external;

  /// @notice Skims the vault `token` balance to `skimRecipient`.
  function skim(address) external;

  /// @notice Sets `newAllocator` as an allocator or not (`newIsAllocator`).
  function setIsAllocator(address newAllocator, bool newIsAllocator) external;

  /// @notice Sets `curator` to `newCurator`.
  function setCurator(address newCurator) external;

  /// @notice Sets the `fee` to `newFee`.
  function setFee(uint256 newFee) external;

  /// @notice Sets `feeRecipient` to `newFeeRecipient`.
  function setFeeRecipient(address newFeeRecipient) external;

  /// @notice Sets `skimRecipient` to `newSkimRecipient`.
  function setSkimRecipient(address newSkimRecipient) external;

  /// @notice Sets `supplyQueue` to `newSupplyQueue`.
  /// @param newSupplyQueue is an array of enabled markets, and can contain duplicate markets, but it would only
  /// increase the cost of depositing to the vault.
  function setSupplyQueue(IPool[] calldata newSupplyQueue) external;

  /// @notice Updates the withdraw queue. Some markets can be removed, but no market can be added.
  /// @notice Removing a market requires the vault to have 0 supply on it, or to have previously submitted a removal
  /// for this market (with the function `submitMarketRemoval`).
  /// @notice Warning: Anyone can supply on behalf of the vault so the call to `updateWithdrawQueue` that expects a
  /// market to be empty can be griefed by a front-run. To circumvent this, the allocator can simply bundle a
  /// reallocation that withdraws max from this market with a call to `updateWithdrawQueue`.
  /// @dev Warning: Removing a market with supply will decrease the fee accrued until one of the functions updating
  /// `lastTotalAssets` is triggered (deposit/mint/withdraw/redeem/setFee/setFeeRecipient).
  /// @dev Warning: `updateWithdrawQueue` is not idempotent. Submitting twice the same tx will change the queue twice.
  /// @param indexes The indexes of each market in the previous withdraw queue, in the new withdraw queue's order.
  function updateWithdrawQueue(uint256[] calldata indexes) external;

  /// @notice Reallocates the vault's liquidity so as to reach a given allocation of assets on each given market.
  /// @notice The allocator can withdraw from any market, even if it's not in the withdraw queue, as long as the loan
  /// token of the market is the same as the vault's asset.
  /// @dev The behavior of the reallocation can be altered by state changes, including:
  /// - Deposits on the vault that supplies to markets that are expected to be supplied to during reallocation.
  /// - Withdrawals from the vault that withdraws from markets that are expected to be withdrawn from during
  /// reallocation.
  /// - Donations to the vault on markets that are expected to be supplied to during reallocation.
  /// - Withdrawals from markets that are expected to be withdrawn from during reallocation.
  /// @dev Sender is expected to pass `assets = type(uint256).max` with the last MarketAllocation of `allocations` to
  /// supply all the remaining withdrawn liquidity, which would ensure that `totalWithdrawn` = `totalSupplied`.
  function reallocate(MarketAllocation[] calldata allocations) external;
}
