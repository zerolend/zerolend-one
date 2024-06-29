# Solidity API

## MarketAllocation

```solidity
struct MarketAllocation {
  contract IPool market;
  uint256 assets;
}
```

## MarketConfig

```solidity
struct MarketConfig {
  uint184 cap;
  bool enabled;
  uint64 removableAt;
}
```

## PendingUint192

```solidity
struct PendingUint192 {
  uint192 value;
  uint64 validAt;
}
```

## PendingAddress

```solidity
struct PendingAddress {
  address value;
  uint64 validAt;
}
```

## ICuratedVaultBase

_This interface is used for factorizing ICuratedVaultStaticTyping and ICuratedVault.
Consider using the ICuratedVault interface instead of this one._

### ZeroAddress

```solidity
error ZeroAddress()
```

Thrown when the address passed is the zero address.

### NotCuratorRole

```solidity
error NotCuratorRole()
```

Thrown when the caller doesn't have the curator role.

### NotAllocatorRole

```solidity
error NotAllocatorRole()
```

Thrown when the caller doesn't have the allocator role.

### NotGuardianRole

```solidity
error NotGuardianRole()
```

Thrown when the caller doesn't have the guardian role.

### NotCuratorNorGuardianRole

```solidity
error NotCuratorNorGuardianRole()
```

Thrown when the caller doesn't have the curator nor the guardian role.

### UnauthorizedMarket

```solidity
error UnauthorizedMarket(contract IPool id)
```

Thrown when the market `id` cannot be set in the supply queue.

### InconsistentAsset

```solidity
error InconsistentAsset(contract IPool id)
```

Thrown when submitting a cap for a market `id` whose loan token does not correspond to the underlying.
asset.

### SupplyCapExceeded

```solidity
error SupplyCapExceeded(contract IPool id)
```

Thrown when the supply cap has been exceeded on market `id` during a reallocation of funds.

### MaxFeeExceeded

```solidity
error MaxFeeExceeded()
```

Thrown when the fee to set exceeds the maximum fee.

### AlreadySet

```solidity
error AlreadySet()
```

Thrown when the value is already set.

### AlreadyPending

```solidity
error AlreadyPending()
```

Thrown when a value is already pending.

### MaxUint128Exceeded

```solidity
error MaxUint128Exceeded()
```

### PendingCap

```solidity
error PendingCap(contract IPool id)
```

Thrown when submitting the removal of a market when there is a cap already pending on that market.

### PendingRemoval

```solidity
error PendingRemoval()
```

Thrown when submitting a cap for a market with a pending removal.

### NonZeroCap

```solidity
error NonZeroCap()
```

Thrown when submitting a market removal for a market with a non zero cap.

### DuplicateMarket

```solidity
error DuplicateMarket(contract IPool id)
```

Thrown when market `id` is a duplicate in the new withdraw queue to set.

### InvalidMarketRemovalNonZeroCap

```solidity
error InvalidMarketRemovalNonZeroCap(contract IPool id)
```

Thrown when market `id` is missing in the updated withdraw queue and the market has a non-zero cap set.

### InvalidMarketRemovalNonZeroSupply

```solidity
error InvalidMarketRemovalNonZeroSupply(contract IPool id)
```

Thrown when market `id` is missing in the updated withdraw queue and the market has a non-zero supply.

### InvalidMarketRemovalTimelockNotElapsed

```solidity
error InvalidMarketRemovalTimelockNotElapsed(contract IPool id)
```

Thrown when market `id` is missing in the updated withdraw queue and the market is not yet disabled.

### NoPendingValue

```solidity
error NoPendingValue()
```

Thrown when there's no pending value to set.

### NotEnoughLiquidity

```solidity
error NotEnoughLiquidity()
```

Thrown when the requested liquidity cannot be withdrawn from Morpho.

### MarketNotCreated

```solidity
error MarketNotCreated()
```

Thrown when submitting a cap for a market which does not exist.

### MarketNotEnabled

```solidity
error MarketNotEnabled(contract IPool id)
```

Thrown when interacting with a non previously enabled market `id`.

### AboveMaxTimelock

```solidity
error AboveMaxTimelock()
```

Thrown when the submitted timelock is above the max timelock.

### BelowMinTimelock

```solidity
error BelowMinTimelock()
```

Thrown when the submitted timelock is below the min timelock.

### TimelockNotElapsed

```solidity
error TimelockNotElapsed()
```

Thrown when the timelock is not elapsed.

### MaxQueueLengthExceeded

```solidity
error MaxQueueLengthExceeded()
```

Thrown when too many markets are in the withdraw queue.

### ZeroFeeRecipient

```solidity
error ZeroFeeRecipient()
```

Thrown when setting the fee to a non zero value while the fee recipient is the zero address.

### InconsistentReallocation

```solidity
error InconsistentReallocation()
```

Thrown when the amount withdrawn is not exactly the amount supplied.

### AllCapsReached

```solidity
error AllCapsReached()
```

Thrown when all caps have been reached.

### SubmitTimelock

```solidity
event SubmitTimelock(uint256 newTimelock)
```

Emitted when a pending `newTimelock` is submitted.

### SetTimelock

```solidity
event SetTimelock(address caller, uint256 newTimelock)
```

Emitted when `timelock` is set to `newTimelock`.

### SetSkimRecipient

```solidity
event SetSkimRecipient(address newSkimRecipient)
```

Emitted when `skimRecipient` is set to `newSkimRecipient`.

### SetFee

```solidity
event SetFee(address caller, uint256 newFee)
```

Emitted `fee` is set to `newFee`.

### SetFeeRecipient

```solidity
event SetFeeRecipient(address newFeeRecipient)
```

Emitted when a new `newFeeRecipient` is set.

### SubmitGuardian

```solidity
event SubmitGuardian(address newGuardian)
```

Emitted when a pending `newGuardian` is submitted.

### SetGuardian

```solidity
event SetGuardian(address caller, address guardian)
```

Emitted when `guardian` is set to `newGuardian`.

### SubmitCap

```solidity
event SubmitCap(address caller, contract IPool pool, uint256 cap)
```

Emitted when a pending `cap` is submitted for market identified by `id`.

### SetCap

```solidity
event SetCap(address caller, contract IPool pool, uint256 cap)
```

Emitted when a new `cap` is set for market identified by `id`.

### UpdateLastTotalAssets

```solidity
event UpdateLastTotalAssets(uint256 updatedTotalAssets)
```

Emitted when the vault's last total assets is updated to `updatedTotalAssets`.

### SubmitMarketRemoval

```solidity
event SubmitMarketRemoval(address caller, contract IPool pool)
```

Emitted when the market identified by `id` is submitted for removal.

### SetCurator

```solidity
event SetCurator(address newCurator)
```

Emitted when `curator` is set to `newCurator`.

### SetIsAllocator

```solidity
event SetIsAllocator(address allocator, bool isAllocator)
```

Emitted when an `allocator` is set to `isAllocator`.

### RevokePendingTimelock

```solidity
event RevokePendingTimelock(address caller)
```

Emitted when a `pendingTimelock` is revoked.

### RevokePendingCap

```solidity
event RevokePendingCap(address caller, contract IPool pool)
```

Emitted when a `pendingCap` for the market identified by `id` is revoked.

### RevokePendingGuardian

```solidity
event RevokePendingGuardian(address caller)
```

Emitted when a `pendingGuardian` is revoked.

### RevokePendingMarketRemoval

```solidity
event RevokePendingMarketRemoval(address caller, contract IPool pool)
```

Emitted when a pending market removal is revoked.

### SetSupplyQueue

```solidity
event SetSupplyQueue(address caller, contract IPool[] newSupplyQueue)
```

Emitted when the `supplyQueue` is set to `newSupplyQueue`.

### SetWithdrawQueue

```solidity
event SetWithdrawQueue(address caller, contract IPool[] newWithdrawQueue)
```

Emitted when the `withdrawQueue` is set to `newWithdrawQueue`.

### ReallocateSupply

```solidity
event ReallocateSupply(address caller, address pool, uint256 suppliedAssets, uint256 suppliedShares)
```

Emitted when a reallocation supplies assets to the market identified by `id`.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| caller | address |  |
| pool | address | The id of the market. |
| suppliedAssets | uint256 | The amount of assets supplied to the market. |
| suppliedShares | uint256 | The amount of shares minted. |

### ReallocateWithdraw

```solidity
event ReallocateWithdraw(address caller, address pool, uint256 withdrawnAssets, uint256 withdrawnShares)
```

Emitted when a reallocation withdraws assets from the market identified by `id`.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| caller | address |  |
| pool | address | The id of the market. |
| withdrawnAssets | uint256 | The amount of assets withdrawn from the market. |
| withdrawnShares | uint256 | The amount of shares burned. |

### AccrueInterest

```solidity
event AccrueInterest(uint256 newTotalAssets, uint256 feeShares)
```

Emitted when interest are accrued.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newTotalAssets | uint256 | The assets of the vault after accruing the interest but before the interaction. |
| feeShares | uint256 | The shares minted to the fee recipient. |

### Skim

```solidity
event Skim(address caller, address token, uint256 amount)
```

Emitted when an `amount` of `token` is transferred to the skim recipient by `caller`.

### CreateMetaMorpho

```solidity
event CreateMetaMorpho(address metaMorpho, address caller, address initialOwner, uint256 initialTimelock, address asset, string name, string symbol, bytes32 salt)
```

Emitted when a new MetaMorpho vault is created.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| metaMorpho | address | The address of the MetaMorpho vault. |
| caller | address | The caller of the function. |
| initialOwner | address | The initial owner of the MetaMorpho vault. |
| initialTimelock | uint256 | The initial timelock of the MetaMorpho vault. |
| asset | address | The address of the underlying asset. |
| name | string | The name of the MetaMorpho vault. |
| symbol | string | The symbol of the MetaMorpho vault. |
| salt | bytes32 | The salt used for the MetaMorpho vault's CREATE2 address. |

### DECIMALS_OFFSET

```solidity
function DECIMALS_OFFSET() external view returns (uint8)
```

### curator

```solidity
function curator() external view returns (address)
```

The address of the curator.

### isAllocator

```solidity
function isAllocator(address target) external view returns (bool)
```

Stores whether an address is an allocator or not.

### guardian

```solidity
function guardian() external view returns (address)
```

The current guardian. Can be set even without the timelock set.

### fee

```solidity
function fee() external view returns (uint96)
```

The current fee.

### feeRecipient

```solidity
function feeRecipient() external view returns (address)
```

The fee recipient.

### skimRecipient

```solidity
function skimRecipient() external view returns (address)
```

The skim recipient.

### timelock

```solidity
function timelock() external view returns (uint256)
```

The current timelock.

### supplyQueue

```solidity
function supplyQueue(uint256) external view returns (contract IPool)
```

_Stores the order of markets on which liquidity is supplied upon deposit.
Can contain any market. A market is skipped as soon as its supply cap is reached._

### supplyQueueLength

```solidity
function supplyQueueLength() external view returns (uint256)
```

Returns the length of the supply queue.

### withdrawQueue

```solidity
function withdrawQueue(uint256) external view returns (contract IPool)
```

_Stores the order of markets from which liquidity is withdrawn upon withdrawal.
Always contain all non-zero cap markets as well as all markets on which the vault supplies liquidity,
without duplicate._

### withdrawQueueLength

```solidity
function withdrawQueueLength() external view returns (uint256)
```

Returns the length of the withdraw queue.

### lastTotalAssets

```solidity
function lastTotalAssets() external view returns (uint256)
```

Stores the total assets managed by this vault when the fee was last accrued.

_May be greater than `totalAssets()` due to removal of markets with non-zero supply or socialized bad debt.
This difference will decrease the fee accrued until one of the functions updating `lastTotalAssets` is
triggered (deposit/mint/withdraw/redeem/setFee/setFeeRecipient)._

### submitTimelock

```solidity
function submitTimelock(uint256 newTimelock) external
```

Submits a `newTimelock`.

_Warning: Reverts if a timelock is already pending. Revoke the pending timelock to overwrite it.
In case the new timelock is higher than the current one, the timelock is set immediately._

### acceptTimelock

```solidity
function acceptTimelock() external
```

Accepts the pending timelock.

### revokePendingTimelock

```solidity
function revokePendingTimelock() external
```

Revokes the pending timelock.

_Does not revert if there is no pending timelock._

### submitCap

```solidity
function submitCap(contract IPool pool, uint256 newSupplyCap) external
```

Submits a `newSupplyCap` for the market defined by `marketParams`.

_Warning: Reverts if a cap is already pending. Revoke the pending cap to overwrite it.
Warning: Reverts if a market removal is pending.
In case the new cap is lower than the current one, the cap is set immediately._

### acceptCap

```solidity
function acceptCap(contract IPool pool) external
```

Accepts the pending cap of the market defined by `marketParams`.

### revokePendingCap

```solidity
function revokePendingCap(contract IPool id) external
```

Revokes the pending cap of the market defined by `id`.

_Does not revert if there is no pending cap._

### submitMarketRemoval

```solidity
function submitMarketRemoval(contract IPool pool) external
```

Submits a forced market removal from the vault, eventually losing all funds supplied to the market.
Funds can be recovered by enabling this market again and withdrawing from it (using `reallocate`),
but funds will be distributed pro-rata to the shares at the time of withdrawal, not at the time of removal.
This forced removal is expected to be used as an emergency process in case a market constantly reverts.
To softly remove a sane market, the curator role is expected to bundle a reallocation that empties the market
first (using `reallocate`), followed by the removal of the market (using `updateWithdrawQueue`).

_Warning: Removing a market with non-zero supply will instantly impact the vault's price per share.
Warning: Reverts for non-zero cap or if there is a pending cap. Successfully submitting a zero cap will
prevent such reverts._

### revokePendingMarketRemoval

```solidity
function revokePendingMarketRemoval(contract IPool id) external
```

Revokes the pending removal of the market defined by `id`.

_Does not revert if there is no pending market removal._

### submitGuardian

```solidity
function submitGuardian(address newGuardian) external
```

Submits a `newGuardian`.
Warning: a malicious guardian could disrupt the vault's operation, and would have the power to revoke
any pending guardian.

_In case there is no guardian, the gardian is set immediately.
Warning: Submitting a gardian will overwrite the current pending gardian._

### acceptGuardian

```solidity
function acceptGuardian() external
```

Accepts the pending guardian.

### revokePendingGuardian

```solidity
function revokePendingGuardian() external
```

Revokes the pending guardian.

### skim

```solidity
function skim(address) external
```

Skims the vault `token` balance to `skimRecipient`.

### setIsAllocator

```solidity
function setIsAllocator(address newAllocator, bool newIsAllocator) external
```

Sets `newAllocator` as an allocator or not (`newIsAllocator`).

### setCurator

```solidity
function setCurator(address newCurator) external
```

Sets `curator` to `newCurator`.

### setFee

```solidity
function setFee(uint256 newFee) external
```

Sets the `fee` to `newFee`.

### setFeeRecipient

```solidity
function setFeeRecipient(address newFeeRecipient) external
```

Sets `feeRecipient` to `newFeeRecipient`.

### setSkimRecipient

```solidity
function setSkimRecipient(address newSkimRecipient) external
```

Sets `skimRecipient` to `newSkimRecipient`.

### setSupplyQueue

```solidity
function setSupplyQueue(contract IPool[] newSupplyQueue) external
```

Sets `supplyQueue` to `newSupplyQueue`.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| newSupplyQueue | contract IPool[] | is an array of enabled markets, and can contain duplicate markets, but it would only increase the cost of depositing to the vault. |

### updateWithdrawQueue

```solidity
function updateWithdrawQueue(uint256[] indexes) external
```

Updates the withdraw queue. Some markets can be removed, but no market can be added.
Removing a market requires the vault to have 0 supply on it, or to have previously submitted a removal
for this market (with the function `submitMarketRemoval`).
Warning: Anyone can supply on behalf of the vault so the call to `updateWithdrawQueue` that expects a
market to be empty can be griefed by a front-run. To circumvent this, the allocator can simply bundle a
reallocation that withdraws max from this market with a call to `updateWithdrawQueue`.

_Warning: Removing a market with supply will decrease the fee accrued until one of the functions updating
`lastTotalAssets` is triggered (deposit/mint/withdraw/redeem/setFee/setFeeRecipient).
Warning: `updateWithdrawQueue` is not idempotent. Submitting twice the same tx will change the queue twice._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| indexes | uint256[] | The indexes of each market in the previous withdraw queue, in the new withdraw queue's order. |

### reallocate

```solidity
function reallocate(struct MarketAllocation[] allocations) external
```

Reallocates the vault's liquidity so as to reach a given allocation of assets on each given market.
The allocator can withdraw from any market, even if it's not in the withdraw queue, as long as the loan
token of the market is the same as the vault's asset.

_The behavior of the reallocation can be altered by state changes, including:
- Deposits on the vault that supplies to markets that are expected to be supplied to during reallocation.
- Withdrawals from the vault that withdraws from markets that are expected to be withdrawn from during
reallocation.
- Donations to the vault on markets that are expected to be supplied to during reallocation.
- Withdrawals from markets that are expected to be withdrawn from during reallocation.
Sender is expected to pass `assets = type(uint256).max` with the last MarketAllocation of `allocations` to
supply all the remaining withdrawn liquidity, which would ensure that `totalWithdrawn` = `totalSupplied`._

## ICuratedVaultStaticTyping

_This interface is inherited by MetaMorpho so that function signatures are checked by the compiler.
Consider using the ICuratedVault interface instead of this one._

### config

```solidity
function config(contract IPool) external view returns (uint184 cap, bool enabled, uint64 removableAt)
```

Returns the current configuration of each market.

### pendingGuardian

```solidity
function pendingGuardian() external view returns (address guardian, uint64 validAt)
```

Returns the pending guardian.

### pendingCap

```solidity
function pendingCap(contract IPool) external view returns (uint192 value, uint64 validAt)
```

Returns the pending cap for each market.

### pendingTimelock

```solidity
function pendingTimelock() external view returns (uint192 value, uint64 validAt)
```

Returns the pending timelock.

## ICuratedVault

_Use this interface for MetaMorpho to have access to all the functions with the appropriate function signatures._

### config

```solidity
function config(contract IPool) external view returns (struct MarketConfig)
```

Returns the current configuration of each market.

### pendingGuardian

```solidity
function pendingGuardian() external view returns (struct PendingAddress)
```

Returns the pending guardian.

### pendingCap

```solidity
function pendingCap(contract IPool) external view returns (struct PendingUint192)
```

Returns the pending cap for each market.

### pendingTimelock

```solidity
function pendingTimelock() external view returns (struct PendingUint192)
```

Returns the pending timelock.

### initialize

```solidity
function initialize(address initialOwner, uint256 initialTimelock, address asset, string name, string symbol) external
```

