# Solidity API

## CuratedVault

ERC4626 compliant vault allowing users to deposit assets to ZeroLend One.

### DECIMALS_OFFSET

```solidity
uint8 DECIMALS_OFFSET
```

OpenZeppelin decimals offset used by the ERC4626Upgradeable implementation.

_Calculated to be max(0, 18 - underlyingDecimals) at construction, so the initial conversion rate maximizes
precision between shares and assets._

### curator

```solidity
address curator
```

The address of the curator.

### isAllocator

```solidity
mapping(address => bool) isAllocator
```

Stores whether an address is an allocator or not.

### guardian

```solidity
address guardian
```

The current guardian. Can be set even without the timelock set.

### config

```solidity
mapping(contract IPool => struct MarketConfig) config
```

Returns the current configuration of each market.

### timelock

```solidity
uint256 timelock
```

The current timelock.

### pendingGuardian

```solidity
struct PendingAddress pendingGuardian
```

Returns the pending guardian.

### pendingCap

```solidity
mapping(contract IPool => struct PendingUint192) pendingCap
```

Returns the pending cap for each market.

### pendingTimelock

```solidity
struct PendingUint192 pendingTimelock
```

Returns the pending timelock.

### fee

```solidity
uint96 fee
```

The current fee.

### feeRecipient

```solidity
address feeRecipient
```

The fee recipient.

### skimRecipient

```solidity
address skimRecipient
```

The skim recipient.

### supplyQueue

```solidity
contract IPool[] supplyQueue
```

_Stores the order of markets on which liquidity is supplied upon deposit.
Can contain any market. A market is skipped as soon as its supply cap is reached._

### withdrawQueue

```solidity
contract IPool[] withdrawQueue
```

_Stores the order of markets from which liquidity is withdrawn upon withdrawal.
Always contain all non-zero cap markets as well as all markets on which the vault supplies liquidity,
without duplicate._

### lastTotalAssets

```solidity
uint256 lastTotalAssets
```

Stores the total assets managed by this vault when the fee was last accrued.

_May be greater than `totalAssets()` due to removal of markets with non-zero supply or socialized bad debt.
This difference will decrease the fee accrued until one of the functions updating `lastTotalAssets` is
triggered (deposit/mint/withdraw/redeem/setFee/setFeeRecipient)._

### positionId

```solidity
bytes32 positionId
```

### initialize

```solidity
function initialize(address owner, uint256 initialTimelock, address _asset, string _name, string _symbol) external
```

_Initializes the contract._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner of the contract. |
| initialTimelock | uint256 | The initial timelock. |
| _asset | address | The address of the underlying asset. |
| _name | string | The name of the vault. |
| _symbol | string | The symbol of the vault. |

### onlyCuratorRole

```solidity
modifier onlyCuratorRole()
```

_Reverts if the caller doesn't have the curator role._

### onlyAllocatorRole

```solidity
modifier onlyAllocatorRole()
```

_Reverts if the caller doesn't have the allocator role._

### onlyGuardianRole

```solidity
modifier onlyGuardianRole()
```

_Reverts if the caller doesn't have the guardian role._

### onlyCuratorOrGuardianRole

```solidity
modifier onlyCuratorOrGuardianRole()
```

_Reverts if the caller doesn't have the curator nor the guardian role._

### afterTimelock

```solidity
modifier afterTimelock(uint256 validAt)
```

_Makes sure conditions are met to accept a pending value.
Reverts if:
- there's no pending value;
- the timelock has not elapsed since the pending value has been submitted._

### setCurator

```solidity
function setCurator(address newCurator) external
```

Sets `curator` to `newCurator`.

### setIsAllocator

```solidity
function setIsAllocator(address newAllocator, bool newIsAllocator) external
```

Sets `newAllocator` as an allocator or not (`newIsAllocator`).

### setSkimRecipient

```solidity
function setSkimRecipient(address newSkimRecipient) external
```

Sets `skimRecipient` to `newSkimRecipient`.

### submitTimelock

```solidity
function submitTimelock(uint256 newTimelock) external
```

Submits a `newTimelock`.

_Warning: Reverts if a timelock is already pending. Revoke the pending timelock to overwrite it.
In case the new timelock is higher than the current one, the timelock is set immediately._

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

### submitGuardian

```solidity
function submitGuardian(address newGuardian) external
```

Submits a `newGuardian`.
Warning: a malicious guardian could disrupt the vault's operation, and would have the power to revoke
any pending guardian.

_In case there is no guardian, the gardian is set immediately.
Warning: Submitting a gardian will overwrite the current pending gardian._

### submitCap

```solidity
function submitCap(contract IPool id, uint256 newSupplyCap) external
```

Submits a `newSupplyCap` for the market defined by `marketParams`.

_Warning: Reverts if a cap is already pending. Revoke the pending cap to overwrite it.
Warning: Reverts if a market removal is pending.
In case the new cap is lower than the current one, the cap is set immediately._

### submitMarketRemoval

```solidity
function submitMarketRemoval(contract IPool id) external
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

### revokePendingTimelock

```solidity
function revokePendingTimelock() external
```

Revokes the pending timelock.

_Does not revert if there is no pending timelock._

### revokePendingGuardian

```solidity
function revokePendingGuardian() external
```

Revokes the pending guardian.

### revokePendingCap

```solidity
function revokePendingCap(contract IPool id) external
```

Revokes the pending cap of the market defined by `id`.

_Does not revert if there is no pending cap._

### revokePendingMarketRemoval

```solidity
function revokePendingMarketRemoval(contract IPool id) external
```

Revokes the pending removal of the market defined by `id`.

_Does not revert if there is no pending market removal._

### supplyQueueLength

```solidity
function supplyQueueLength() external view returns (uint256)
```

Returns the length of the supply queue.

### withdrawQueueLength

```solidity
function withdrawQueueLength() external view returns (uint256)
```

Returns the length of the withdraw queue.

### acceptTimelock

```solidity
function acceptTimelock() external
```

Accepts the pending timelock.

### acceptGuardian

```solidity
function acceptGuardian() external
```

Accepts the pending guardian.

### acceptCap

```solidity
function acceptCap(contract IPool id) external
```

Accepts the pending cap of the market defined by `marketParams`.

### skim

```solidity
function skim(address token) external
```

Skims the vault `token` balance to `skimRecipient`.

### decimals

```solidity
function decimals() public view returns (uint8)
```

_Returns the number of decimals used to get its user representation.
For example, if `decimals` equals `2`, a balance of `505` tokens should
be displayed to a user as `5.05` (`505 / 10 ** 2`).

Tokens usually opt for a value of 18, imitating the relationship between
Ether and Wei. This is the default value returned by this function, unless
it's overridden.

NOTE: This information is only used for _display_ purposes: it in
no way affects any of the arithmetic of the contract, including
{IERC20-balanceOf} and {IERC20-transfer}._

### maxDeposit

```solidity
function maxDeposit(address) public view returns (uint256)
```

_Warning: May be higher than the actual max deposit due to duplicate markets in the supplyQueue._

### maxMint

```solidity
function maxMint(address) public view returns (uint256)
```

_Warning: May be higher than the actual max mint due to duplicate markets in the supplyQueue._

### maxWithdraw

```solidity
function maxWithdraw(address owner) public view returns (uint256 assets)
```

_Warning: May be lower than the actual amount of assets that can be withdrawn by `owner` due to conversion
roundings between shares and assets._

### maxRedeem

```solidity
function maxRedeem(address owner) public view returns (uint256)
```

_Warning: May be lower than the actual amount of shares that can be redeemed by `owner` due to conversion
roundings between shares and assets._

### deposit

```solidity
function deposit(uint256 assets, address receiver) public returns (uint256 shares)
```

### mint

```solidity
function mint(uint256 shares, address receiver) public returns (uint256 assets)
```

### withdraw

```solidity
function withdraw(uint256 assets, address receiver, address owner) public returns (uint256 shares)
```

### redeem

```solidity
function redeem(uint256 shares, address receiver, address owner) public returns (uint256 assets)
```

### totalAssets

```solidity
function totalAssets() public view returns (uint256 assets)
```

### _decimalsOffset

```solidity
function _decimalsOffset() internal view returns (uint8)
```

### _maxWithdraw

```solidity
function _maxWithdraw(address owner) internal view returns (uint256 assets, uint256 newTotalSupply, uint256 newTotalAssets)
```

_Returns the maximum amount of asset (`assets`) that the `owner` can withdraw from the vault, as well as the
new vault's total supply (`newTotalSupply`) and total assets (`newTotalAssets`)._

### _maxDeposit

```solidity
function _maxDeposit() internal view returns (uint256 totalSuppliable)
```

_Returns the maximum amount of assets that the vault can supply on Morpho._

### _convertToShares

```solidity
function _convertToShares(uint256 assets, enum MathUpgradeable.Rounding rounding) internal view returns (uint256)
```

_The accrual of performance fees is taken into account in the conversion._

### _convertToAssets

```solidity
function _convertToAssets(uint256 shares, enum MathUpgradeable.Rounding rounding) internal view returns (uint256)
```

_The accrual of performance fees is taken into account in the conversion._

### _convertToSharesWithTotals

```solidity
function _convertToSharesWithTotals(uint256 assets, uint256 newTotalSupply, uint256 newTotalAssets, enum MathUpgradeable.Rounding rounding) internal view returns (uint256)
```

_Returns the amount of shares that the vault would exchange for the amount of `assets` provided.
It assumes that the arguments `newTotalSupply` and `newTotalAssets` are up to date._

### _convertToAssetsWithTotals

```solidity
function _convertToAssetsWithTotals(uint256 shares, uint256 newTotalSupply, uint256 newTotalAssets, enum MathUpgradeable.Rounding rounding) internal view returns (uint256)
```

_Returns the amount of assets that the vault would exchange for the amount of `shares` provided.
It assumes that the arguments `newTotalSupply` and `newTotalAssets` are up to date._

### _deposit

```solidity
function _deposit(address caller, address receiver, uint256 assets, uint256 shares) internal
```

_Used in mint or deposit to deposit the underlying asset to Morpho markets._

### _withdraw

```solidity
function _withdraw(address caller, address receiver, address owner, uint256 assets, uint256 shares) internal
```

_Used in redeem or withdraw to withdraw the underlying asset from Morpho markets.
Depending on 3 cases, reverts when withdrawing "too much" with:
1. NotEnoughLiquidity when withdrawing more than available liquidity.
2. ERC20InsufficientAllowance when withdrawing more than `caller`'s allowance.
3. ERC20InsufficientBalance when withdrawing more than `owner`'s balance._

### _accruedSupplyBalance

```solidity
function _accruedSupplyBalance(contract IPool pool) internal returns (uint256 assets, uint256 shares)
```

_Accrues interest on Morpho Blue and returns the vault's assets & corresponding shares supplied on the
market defined by `marketParams`, as well as the market's state.
Assumes that the inputs `marketParams` and `id` match._

### _checkTimelockBounds

```solidity
function _checkTimelockBounds(uint256 newTimelock) internal pure
```

_Reverts if `newTimelock` is not within the bounds._

### _setTimelock

```solidity
function _setTimelock(uint256 newTimelock) internal
```

_Sets `timelock` to `newTimelock`._

### _setGuardian

```solidity
function _setGuardian(address newGuardian) internal
```

_Sets `guardian` to `newGuardian`._

### _setCap

```solidity
function _setCap(contract IPool id, uint184 supplyCap) internal
```

_Sets the cap of the market defined by `id` to `supplyCap`.
Assumes that the inputs `marketParams` and `id` match._

### _supplyPool

```solidity
function _supplyPool(uint256 assets) internal
```

_Supplies `assets` to Morpho._

### _withdrawPool

```solidity
function _withdrawPool(uint256 assets) internal
```

_Withdraws `assets` from Morpho._

### _simulateWithdrawMorpho

```solidity
function _simulateWithdrawMorpho(uint256 assets) internal view returns (uint256)
```

_Simulates a withdraw of `assets` from Morpho._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The remaining assets to be withdrawn. |

### _withdrawable

```solidity
function _withdrawable(contract IPool marketParams, uint256 totalSupplyAssets, uint256 totalBorrowAssets, uint256 supplyAssets) internal view returns (uint256)
```

_Returns the withdrawable amount of assets from the market defined by `marketParams`, given the market's
total supply and borrow assets and the vault's assets supplied._

### _updateLastTotalAssets

```solidity
function _updateLastTotalAssets(uint256 updatedTotalAssets) internal
```

_Updates `lastTotalAssets` to `updatedTotalAssets`._

### _accrueFee

```solidity
function _accrueFee() internal returns (uint256 newTotalAssets)
```

_Accrues the fee and mints the fee shares to the fee recipient._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| newTotalAssets | uint256 | The vaults total assets after accruing the interest. |

### _accruedFeeShares

```solidity
function _accruedFeeShares() internal view returns (uint256 feeShares, uint256 newTotalAssets)
```

_Computes and returns the fee shares (`feeShares`) to mint and the new vault's total assets
(`newTotalAssets`)._

