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

import {
  ICuratedVaultBase,
  ICuratedVaultStaticTyping,
  MarketAllocation,
  MarketConfig,
  PendingAddress,
  PendingUint192
} from '../../interfaces/ICuratedVault.sol';
import {IPool} from '../../interfaces/IPool.sol';
import {ConstantsLib} from './libraries/ConstantsLib.sol';

import {PendingLib} from './libraries/PendingLib.sol';

import {SharesMathLib} from './libraries/SharesMathLib.sol';
import {UtilsLib} from './libraries/UtilsLib.sol';
import {Ownable2StepUpgradeable, OwnableUpgradeable} from '@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol';
import {IERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol';
import {ERC20PermitUpgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PermitUpgradeable.sol';

import {
  ERC20Upgradeable,
  ERC4626Upgradeable,
  IERC4626Upgradeable,
  MathUpgradeable
} from '@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC4626Upgradeable.sol';
import {MulticallUpgradeable} from '@openzeppelin/contracts-upgradeable/utils/MulticallUpgradeable.sol';
import {IERC20} from '@openzeppelin/contracts/interfaces/IERC20.sol';
import {ERC20Permit} from '@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol';
import {IERC20Metadata} from '@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol';

import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from '@openzeppelin/contracts/utils/math/SafeCast.sol';

/// @title CuratedVault
/// @author Morpho Labs
/// @custom:contact security@morpho.org
/// @notice ERC4626 compliant vault allowing users to deposit assets to ZeroLend One.
contract CuratedVault is
  ERC4626Upgradeable,
  ERC20PermitUpgradeable,
  Ownable2StepUpgradeable,
  MulticallUpgradeable,
  ICuratedVaultStaticTyping
{
  using MathUpgradeable for uint256;
  using UtilsLib for uint256;
  using SafeCast for uint256;
  using SafeERC20 for IERC20;
  using SharesMathLib for uint256;
  using PendingLib for MarketConfig;
  using PendingLib for PendingUint192;
  using PendingLib for PendingAddress;

  /// @notice OpenZeppelin decimals offset used by the ERC4626Upgradeable implementation.
  /// @dev Calculated to be max(0, 18 - underlyingDecimals) at construction, so the initial conversion rate maximizes
  /// precision between shares and assets.
  uint8 public DECIMALS_OFFSET;

  /// @inheritdoc ICuratedVaultBase
  address public curator;

  /// @inheritdoc ICuratedVaultBase
  mapping(address => bool) public isAllocator;

  /// @inheritdoc ICuratedVaultBase
  address public guardian;

  /// @inheritdoc ICuratedVaultStaticTyping
  mapping(IPool => MarketConfig) public config;

  /// @inheritdoc ICuratedVaultBase
  uint256 public timelock;

  /// @inheritdoc ICuratedVaultStaticTyping
  PendingAddress public pendingGuardian;

  /// @inheritdoc ICuratedVaultStaticTyping
  mapping(IPool => PendingUint192) public pendingCap;

  /// @inheritdoc ICuratedVaultStaticTyping
  PendingUint192 public pendingTimelock;

  /// @inheritdoc ICuratedVaultBase
  uint96 public fee;

  /// @inheritdoc ICuratedVaultBase
  address public feeRecipient;

  /// @inheritdoc ICuratedVaultBase
  address public skimRecipient;

  /// @inheritdoc ICuratedVaultBase
  IPool[] public supplyQueue;

  /// @inheritdoc ICuratedVaultBase
  IPool[] public withdrawQueue;

  /// @inheritdoc ICuratedVaultBase
  uint256 public lastTotalAssets;

  bytes32 public positionId;

  /// @dev Initializes the contract.
  /// @param owner The owner of the contract.
  /// @param initialTimelock The initial timelock.
  /// @param _asset The address of the underlying asset.
  /// @param _name The name of the vault.
  /// @param _symbol The symbol of the vault.
  function initialize(
    address owner,
    uint256 initialTimelock,
    address _asset,
    string memory _name,
    string memory _symbol
  ) external initializer {
    __ERC20_init(_name, _symbol);
    __ERC20Permit_init(_name);
    __ERC4626_init(IERC20Upgradeable(_asset));
    __Multicall_init();
    __Ownable_init();
    __Ownable2Step_init();

    DECIMALS_OFFSET = uint8(uint256(18).zeroFloorSub(IERC20Metadata(_asset).decimals()));
    _checkTimelockBounds(initialTimelock);
    _setTimelock(initialTimelock);

    _transferOwnership(owner);

    positionId = keccak256(abi.encodePacked(address(this), 'index', uint256(0)));
  }

  /* MODIFIERS */

  /// @dev Reverts if the caller doesn't have the curator role.
  modifier onlyCuratorRole() {
    address sender = _msgSender();
    if (sender != curator && sender != owner()) revert NotCuratorRole();
    _;
  }

  /// @dev Reverts if the caller doesn't have the allocator role.
  modifier onlyAllocatorRole() {
    address sender = _msgSender();
    if (!isAllocator[sender] && sender != curator && sender != owner()) {
      revert NotAllocatorRole();
    }
    _;
  }

  /// @dev Reverts if the caller doesn't have the guardian role.
  modifier onlyGuardianRole() {
    if (_msgSender() != owner() && _msgSender() != guardian) revert NotGuardianRole();
    _;
  }

  /// @dev Reverts if the caller doesn't have the curator nor the guardian role.
  modifier onlyCuratorOrGuardianRole() {
    if (_msgSender() != guardian && _msgSender() != curator && _msgSender() != owner()) {
      revert NotCuratorNorGuardianRole();
    }
    _;
  }

  /// @dev Makes sure conditions are met to accept a pending value.
  /// @dev Reverts if:
  /// - there's no pending value;
  /// - the timelock has not elapsed since the pending value has been submitted.
  modifier afterTimelock(uint256 validAt) {
    if (validAt == 0) revert NoPendingValue();
    if (block.timestamp < validAt) revert TimelockNotElapsed();
    _;
  }

  /* ONLY OWNER FUNCTIONS */

  /// @inheritdoc ICuratedVaultBase
  function setCurator(address newCurator) external onlyOwner {
    if (newCurator == curator) revert AlreadySet();
    curator = newCurator;
    emit SetCurator(newCurator);
  }

  /// @inheritdoc ICuratedVaultBase
  function setIsAllocator(address newAllocator, bool newIsAllocator) external onlyOwner {
    if (isAllocator[newAllocator] == newIsAllocator) revert AlreadySet();
    isAllocator[newAllocator] = newIsAllocator;
    emit SetIsAllocator(newAllocator, newIsAllocator);
  }

  /// @inheritdoc ICuratedVaultBase
  function setSkimRecipient(address newSkimRecipient) external onlyOwner {
    if (newSkimRecipient == skimRecipient) revert AlreadySet();
    skimRecipient = newSkimRecipient;
    emit SetSkimRecipient(newSkimRecipient);
  }

  /// @inheritdoc ICuratedVaultBase
  function submitTimelock(uint256 newTimelock) external onlyOwner {
    if (newTimelock == timelock) revert AlreadySet();
    if (pendingTimelock.validAt != 0) revert AlreadyPending();
    _checkTimelockBounds(newTimelock);

    if (newTimelock > timelock) {
      _setTimelock(newTimelock);
    } else {
      // Safe "unchecked" cast because newTimelock <= MAX_TIMELOCK.
      pendingTimelock.update(uint184(newTimelock), timelock);

      emit SubmitTimelock(newTimelock);
    }
  }

  /// @inheritdoc ICuratedVaultBase
  function setFee(uint256 newFee) external onlyOwner {
    if (newFee == fee) revert AlreadySet();
    if (newFee > ConstantsLib.MAX_FEE) revert MaxFeeExceeded();
    if (newFee != 0 && feeRecipient == address(0)) revert ZeroFeeRecipient();

    // Accrue fee using the previous fee set before changing it.
    _updateLastTotalAssets(_accrueFee());

    // Safe "unchecked" cast because newFee <= MAX_FEE.
    fee = uint96(newFee);

    emit SetFee(_msgSender(), fee);
  }

  /// @inheritdoc ICuratedVaultBase
  function setFeeRecipient(address newFeeRecipient) external onlyOwner {
    if (newFeeRecipient == feeRecipient) revert AlreadySet();
    if (newFeeRecipient == address(0) && fee != 0) revert ZeroFeeRecipient();

    // Accrue fee to the previous fee recipient set before changing it.
    _updateLastTotalAssets(_accrueFee());

    feeRecipient = newFeeRecipient;

    emit SetFeeRecipient(newFeeRecipient);
  }

  /// @inheritdoc ICuratedVaultBase
  function submitGuardian(address newGuardian) external onlyOwner {
    if (newGuardian == guardian) revert AlreadySet();
    if (pendingGuardian.validAt != 0) revert AlreadyPending();

    if (guardian == address(0)) {
      _setGuardian(newGuardian);
    } else {
      pendingGuardian.update(newGuardian, timelock);

      emit SubmitGuardian(newGuardian);
    }
  }

  /* ONLY CURATOR FUNCTIONS */

  /// @inheritdoc ICuratedVaultBase
  function submitCap(IPool id, uint256 newSupplyCap) external onlyCuratorRole {
    // if (marketParams.loanToken != asset()) revert InconsistentAsset(id);
    // if (MORPHO.lastUpdate(id) == 0) revert MarketNotCreated();
    if (pendingCap[id].validAt != 0) revert AlreadyPending();
    if (config[id].removableAt != 0) revert PendingRemoval();
    uint256 supplyCap = config[id].cap;
    if (newSupplyCap == supplyCap) revert AlreadySet();

    if (newSupplyCap < supplyCap) {
      _setCap(id, newSupplyCap.toUint184());
    } else {
      pendingCap[id].update(newSupplyCap.toUint184(), timelock);
      emit SubmitCap(_msgSender(), id, newSupplyCap);
    }
  }

  /// @inheritdoc ICuratedVaultBase
  function submitMarketRemoval(IPool id) external onlyCuratorRole {
    if (config[id].removableAt != 0) revert AlreadyPending();
    if (config[id].cap != 0) revert NonZeroCap();
    if (!config[id].enabled) revert MarketNotEnabled(id);
    if (pendingCap[id].validAt != 0) revert PendingCap(id);

    // Safe "unchecked" cast because timelock <= MAX_TIMELOCK.
    config[id].removableAt = uint64(block.timestamp + timelock);
    emit SubmitMarketRemoval(_msgSender(), id);
  }

  /* ONLY ALLOCATOR FUNCTIONS */

  /// @inheritdoc ICuratedVaultBase
  function setSupplyQueue(IPool[] calldata newSupplyQueue) external onlyAllocatorRole {
    uint256 length = newSupplyQueue.length;

    if (length > ConstantsLib.MAX_QUEUE_LENGTH) revert MaxQueueLengthExceeded();

    for (uint256 i; i < length; ++i) {
      if (config[newSupplyQueue[i]].cap == 0) revert UnauthorizedMarket(newSupplyQueue[i]);
    }

    supplyQueue = newSupplyQueue;

    emit SetSupplyQueue(_msgSender(), newSupplyQueue);
  }

  /// @inheritdoc ICuratedVaultBase
  function updateWithdrawQueue(uint256[] calldata indexes) external onlyAllocatorRole {
    uint256 newLength = indexes.length;
    uint256 currLength = withdrawQueue.length;

    bool[] memory seen = new bool[](currLength);
    IPool[] memory newWithdrawQueue = new IPool[](newLength);

    for (uint256 i; i < newLength; ++i) {
      uint256 prevIndex = indexes[i];

      // If prevIndex >= currLength, it will revert with native "Index out of bounds".
      IPool id = withdrawQueue[prevIndex];
      if (seen[prevIndex]) revert DuplicateMarket(id);
      seen[prevIndex] = true;

      newWithdrawQueue[i] = id;
    }

    for (uint256 i; i < currLength; ++i) {
      if (!seen[i]) {
        IPool id = withdrawQueue[i];

        if (config[id].cap != 0) revert InvalidMarketRemovalNonZeroCap(id);
        if (pendingCap[id].validAt != 0) revert PendingCap(id);

        // todo
        // if (MORPHO.supplyShares(id, address(this)) != 0) {
        //   if (config[id].removableAt == 0) revert InvalidMarketRemovalNonZeroSupply(id);
        //   if (block.timestamp < config[id].removableAt) {
        //     revert InvalidMarketRemovalTimelockNotElapsed(id);
        //   }
        // }

        delete config[id];
      }
    }

    withdrawQueue = newWithdrawQueue;

    emit SetWithdrawQueue(_msgSender(), newWithdrawQueue);
  }

  /// @inheritdoc ICuratedVaultBase
  function reallocate(MarketAllocation[] calldata allocations) external onlyAllocatorRole {
    uint256 totalSupplied;
    uint256 totalWithdrawn;
    for (uint256 i; i < allocations.length; ++i) {
      MarketAllocation memory allocation = allocations[i];
      IPool pool = allocation.market;

      (uint256 supplyAssets, uint256 supplyShares) = _accruedSupplyBalance(pool);
      uint256 withdrawn = supplyAssets.zeroFloorSub(allocation.assets);

      if (withdrawn > 0) {
        if (!config[pool].enabled) revert MarketNotEnabled(pool);

        // Guarantees that unknown frontrunning donations can be withdrawn, in order to disable a market.
        uint256 shares;
        if (allocation.assets == 0) {
          shares = supplyShares;
          withdrawn = 0;
        }

        // todo

        uint256 withdrawnAssets = pool.withdrawSimple(asset(), withdrawn, 0);

        // emit ReallocateWithdraw(_msgSender(), id, withdrawnAssets, withdrawnShares);

        totalWithdrawn += withdrawnAssets;
      } else {
        uint256 suppliedAssets =
          allocation.assets == type(uint256).max ? totalWithdrawn.zeroFloorSub(totalSupplied) : allocation.assets.zeroFloorSub(supplyAssets);

        if (suppliedAssets == 0) continue;

        uint256 supplyCap = config[pool].cap;
        if (supplyCap == 0) revert UnauthorizedMarket(pool);

        if (supplyAssets + suppliedAssets > supplyCap) revert SupplyCapExceeded(pool);

        // todo
        // // The market's loan asset is guaranteed to be the vault's asset because it has a non-zero supply cap.
        // // IERC20(_asset).forceApprove(morpho, type(uint256).max);
        // (, uint256 suppliedShares) = MORPHO.supply(
        //   allocation.marketParams,
        //   suppliedAssets,
        //   0,
        //   address(this),
        //   hex''
        // );
        // emit ReallocateSupply(_msgSender(), id, suppliedAssets, suppliedShares);
        // totalSupplied += suppliedAssets;
      }
    }

    if (totalWithdrawn != totalSupplied) revert InconsistentReallocation();
  }

  /* REVOKE FUNCTIONS */

  /// @inheritdoc ICuratedVaultBase
  function revokePendingTimelock() external onlyGuardianRole {
    delete pendingTimelock;
    emit RevokePendingTimelock(_msgSender());
  }

  /// @inheritdoc ICuratedVaultBase
  function revokePendingGuardian() external onlyGuardianRole {
    delete pendingGuardian;
    emit RevokePendingGuardian(_msgSender());
  }

  /// @inheritdoc ICuratedVaultBase
  function revokePendingCap(IPool id) external onlyCuratorOrGuardianRole {
    delete pendingCap[id];
    emit RevokePendingCap(_msgSender(), id);
  }

  /// @inheritdoc ICuratedVaultBase
  function revokePendingMarketRemoval(IPool id) external onlyCuratorOrGuardianRole {
    delete config[id].removableAt;
    emit RevokePendingMarketRemoval(_msgSender(), id);
  }

  /* EXTERNAL */

  /// @inheritdoc ICuratedVaultBase
  function supplyQueueLength() external view returns (uint256) {
    return supplyQueue.length;
  }

  /// @inheritdoc ICuratedVaultBase
  function withdrawQueueLength() external view returns (uint256) {
    return withdrawQueue.length;
  }

  /// @inheritdoc ICuratedVaultBase
  function acceptTimelock() external afterTimelock(pendingTimelock.validAt) {
    _setTimelock(pendingTimelock.value);
  }

  /// @inheritdoc ICuratedVaultBase
  function acceptGuardian() external afterTimelock(pendingGuardian.validAt) {
    _setGuardian(pendingGuardian.value);
  }

  /// @inheritdoc ICuratedVaultBase
  function acceptCap(IPool id) external afterTimelock(pendingCap[id].validAt) {
    // Safe "unchecked" cast because pendingCap <= type(uint184).max.
    _setCap(id, uint184(pendingCap[id].value));
  }

  /// @inheritdoc ICuratedVaultBase
  function skim(address token) external {
    if (skimRecipient == address(0)) revert ZeroAddress();
    uint256 amount = IERC20(token).balanceOf(address(this));
    IERC20(token).safeTransfer(skimRecipient, amount);
    emit Skim(_msgSender(), token, amount);
  }

  /* ERC4626Upgradeable (PUBLIC) */

  /// @inheritdoc ERC20Upgradeable
  function decimals() public view override (ERC4626Upgradeable, ERC20Upgradeable) returns (uint8) {
    return ERC4626Upgradeable.decimals();
  }

  /// @inheritdoc IERC4626Upgradeable
  /// @dev Warning: May be higher than the actual max deposit due to duplicate markets in the supplyQueue.
  function maxDeposit(address) public view override returns (uint256) {
    return _maxDeposit();
  }

  /// @inheritdoc IERC4626Upgradeable
  /// @dev Warning: May be higher than the actual max mint due to duplicate markets in the supplyQueue.
  function maxMint(address) public view override returns (uint256) {
    uint256 suppliable = _maxDeposit();

    return _convertToShares(suppliable, MathUpgradeable.Rounding.Down);
  }

  /// @inheritdoc IERC4626Upgradeable
  /// @dev Warning: May be lower than the actual amount of assets that can be withdrawn by `owner` due to conversion
  /// roundings between shares and assets.
  function maxWithdraw(address owner) public view override returns (uint256 assets) {
    (assets,,) = _maxWithdraw(owner);
  }

  /// @inheritdoc IERC4626Upgradeable
  /// @dev Warning: May be lower than the actual amount of shares that can be redeemed by `owner` due to conversion
  /// roundings between shares and assets.
  function maxRedeem(address owner) public view override returns (uint256) {
    (uint256 assets, uint256 newTotalSupply, uint256 newTotalAssets) = _maxWithdraw(owner);

    return _convertToSharesWithTotals(assets, newTotalSupply, newTotalAssets, MathUpgradeable.Rounding.Down);
  }

  /// @inheritdoc IERC4626Upgradeable
  function deposit(uint256 assets, address receiver) public override returns (uint256 shares) {
    uint256 newTotalAssets = _accrueFee();

    // Update `lastTotalAssets` to avoid an inconsistent state in a re-entrant context.
    // It is updated again in `_deposit`.
    lastTotalAssets = newTotalAssets;
    shares = _convertToSharesWithTotals(assets, totalSupply(), newTotalAssets, MathUpgradeable.Rounding.Down);
    _deposit(_msgSender(), receiver, assets, shares);
  }

  /// @inheritdoc IERC4626Upgradeable
  function mint(uint256 shares, address receiver) public override returns (uint256 assets) {
    uint256 newTotalAssets = _accrueFee();

    // Update `lastTotalAssets` to avoid an inconsistent state in a re-entrant context.
    // It is updated again in `_deposit`.
    lastTotalAssets = newTotalAssets;
    assets = _convertToAssetsWithTotals(shares, totalSupply(), newTotalAssets, MathUpgradeable.Rounding.Up);
    _deposit(_msgSender(), receiver, assets, shares);
  }

  /// @inheritdoc IERC4626Upgradeable
  function withdraw(uint256 assets, address receiver, address owner) public override returns (uint256 shares) {
    uint256 newTotalAssets = _accrueFee();

    // Do not call expensive `maxWithdraw` and optimistically withdraw assets.
    shares = _convertToSharesWithTotals(assets, totalSupply(), newTotalAssets, MathUpgradeable.Rounding.Up);

    // `newTotalAssets - assets` may be a little off from `totalAssets()`.
    _updateLastTotalAssets(newTotalAssets.zeroFloorSub(assets));
    _withdraw(_msgSender(), receiver, owner, assets, shares);
  }

  /// @inheritdoc IERC4626Upgradeable
  function redeem(uint256 shares, address receiver, address owner) public override returns (uint256 assets) {
    uint256 newTotalAssets = _accrueFee();

    // Do not call expensive `maxRedeem` and optimistically redeem shares.
    assets = _convertToAssetsWithTotals(shares, totalSupply(), newTotalAssets, MathUpgradeable.Rounding.Down);

    // `newTotalAssets - assets` may be a little off from `totalAssets()`.
    _updateLastTotalAssets(newTotalAssets.zeroFloorSub(assets));
    _withdraw(_msgSender(), receiver, owner, assets, shares);
  }

  /// @inheritdoc IERC4626Upgradeable
  function totalAssets() public view override returns (uint256 assets) {
    for (uint256 i; i < withdrawQueue.length; ++i) {
      assets += withdrawQueue[i].getBalanceByPosition(asset(), positionId);
    }
  }

  /* ERC4626Upgradeable (INTERNAL) */

  /// @inheritdoc ERC4626Upgradeable
  function _decimalsOffset() internal view override returns (uint8) {
    return DECIMALS_OFFSET;
  }

  /// @dev Returns the maximum amount of asset (`assets`) that the `owner` can withdraw from the vault, as well as the
  /// new vault's total supply (`newTotalSupply`) and total assets (`newTotalAssets`).
  function _maxWithdraw(address owner) internal view returns (uint256 assets, uint256 newTotalSupply, uint256 newTotalAssets) {
    uint256 feeShares;
    (feeShares, newTotalAssets) = _accruedFeeShares();
    newTotalSupply = totalSupply() + feeShares;

    assets = _convertToAssetsWithTotals(balanceOf(owner), newTotalSupply, newTotalAssets, MathUpgradeable.Rounding.Down);
    assets -= _simulateWithdrawMorpho(assets);
  }

  /// @dev Returns the maximum amount of assets that the vault can supply on Morpho.
  function _maxDeposit() internal view returns (uint256 totalSuppliable) {
    for (uint256 i; i < supplyQueue.length; ++i) {
      IPool id = supplyQueue[i];

      uint256 supplyCap = config[id].cap;
      if (supplyCap == 0) continue;

      // todo
      // uint256 supplyShares = MORPHO.supplyShares(id, address(this));
      // (uint256 totalSupplyAssets, uint256 totalSupplyShares, , ) = MORPHO.expectedMarketBalances(
      //   _marketParams(id)
      // );
      // // `supplyAssets` needs to be rounded up for `totalSuppliable` to be rounded down.
      // uint256 supplyAssets = supplyShares.toAssetsUp(totalSupplyAssets, totalSupplyShares);

      // totalSuppliable += supplyCap.zeroFloorSub(supplyAssets);
    }
  }

  /// @inheritdoc ERC4626Upgradeable
  /// @dev The accrual of performance fees is taken into account in the conversion.
  function _convertToShares(uint256 assets, MathUpgradeable.Rounding rounding) internal view override returns (uint256) {
    (uint256 feeShares, uint256 newTotalAssets) = _accruedFeeShares();
    return _convertToSharesWithTotals(assets, totalSupply() + feeShares, newTotalAssets, rounding);
  }

  /// @inheritdoc ERC4626Upgradeable
  /// @dev The accrual of performance fees is taken into account in the conversion.
  function _convertToAssets(uint256 shares, MathUpgradeable.Rounding rounding) internal view override returns (uint256) {
    (uint256 feeShares, uint256 newTotalAssets) = _accruedFeeShares();
    return _convertToAssetsWithTotals(shares, totalSupply() + feeShares, newTotalAssets, rounding);
  }

  /// @dev Returns the amount of shares that the vault would exchange for the amount of `assets` provided.
  /// @dev It assumes that the arguments `newTotalSupply` and `newTotalAssets` are up to date.
  function _convertToSharesWithTotals(
    uint256 assets,
    uint256 newTotalSupply,
    uint256 newTotalAssets,
    MathUpgradeable.Rounding rounding
  ) internal view returns (uint256) {
    return assets.mulDiv(newTotalSupply + 10 ** _decimalsOffset(), newTotalAssets + 1, rounding);
  }

  /// @dev Returns the amount of assets that the vault would exchange for the amount of `shares` provided.
  /// @dev It assumes that the arguments `newTotalSupply` and `newTotalAssets` are up to date.
  function _convertToAssetsWithTotals(
    uint256 shares,
    uint256 newTotalSupply,
    uint256 newTotalAssets,
    MathUpgradeable.Rounding rounding
  ) internal view returns (uint256) {
    return shares.mulDiv(newTotalAssets + 1, newTotalSupply + 10 ** _decimalsOffset(), rounding);
  }

  /// @inheritdoc ERC4626Upgradeable
  /// @dev Used in mint or deposit to deposit the underlying asset to Morpho markets.
  function _deposit(address caller, address receiver, uint256 assets, uint256 shares) internal override {
    super._deposit(caller, receiver, assets, shares);

    _supplyPool(assets);

    // `lastTotalAssets + assets` may be a little off from `totalAssets()`.
    _updateLastTotalAssets(lastTotalAssets + assets);
  }

  /// @inheritdoc ERC4626Upgradeable
  /// @dev Used in redeem or withdraw to withdraw the underlying asset from Morpho markets.
  /// @dev Depending on 3 cases, reverts when withdrawing "too much" with:
  /// 1. NotEnoughLiquidity when withdrawing more than available liquidity.
  /// 2. ERC20InsufficientAllowance when withdrawing more than `caller`'s allowance.
  /// 3. ERC20InsufficientBalance when withdrawing more than `owner`'s balance.
  function _withdraw(address caller, address receiver, address owner, uint256 assets, uint256 shares) internal override {
    _withdrawPool(assets);
    super._withdraw(caller, receiver, owner, assets, shares);
  }

  /* INTERNAL */

  /// @dev Accrues interest on Morpho Blue and returns the vault's assets & corresponding shares supplied on the
  /// market defined by `marketParams`, as well as the market's state.
  /// @dev Assumes that the inputs `marketParams` and `id` match.
  function _accruedSupplyBalance(IPool pool) internal returns (uint256 assets, uint256 shares) {
    // MORPHO.accrueInterest(marketParams);
    // market = MORPHO.market(id);
    // shares = MORPHO.supplyShares(id, address(this));
    // assets = shares.toAssetsDown(market.totalSupplyAssets, market.totalSupplyShares);
  }

  /// @dev Reverts if `newTimelock` is not within the bounds.
  function _checkTimelockBounds(uint256 newTimelock) internal pure {
    if (newTimelock > ConstantsLib.MAX_TIMELOCK) revert AboveMaxTimelock();
    if (newTimelock < ConstantsLib.MIN_TIMELOCK) revert BelowMinTimelock();
  }

  /// @dev Sets `timelock` to `newTimelock`.
  function _setTimelock(uint256 newTimelock) internal {
    timelock = newTimelock;
    emit SetTimelock(_msgSender(), newTimelock);
    delete pendingTimelock;
  }

  /// @dev Sets `guardian` to `newGuardian`.
  function _setGuardian(address newGuardian) internal {
    guardian = newGuardian;
    emit SetGuardian(_msgSender(), newGuardian);
    delete pendingGuardian;
  }

  /// @dev Sets the cap of the market defined by `id` to `supplyCap`.
  /// @dev Assumes that the inputs `marketParams` and `id` match.
  function _setCap(IPool id, uint184 supplyCap) internal {
    MarketConfig storage marketConfig = config[id];

    if (supplyCap > 0) {
      if (!marketConfig.enabled) {
        withdrawQueue.push(id);

        if (withdrawQueue.length > ConstantsLib.MAX_QUEUE_LENGTH) revert MaxQueueLengthExceeded();

        marketConfig.enabled = true;

        // todo
        // // Take into account assets of the new market without applying a fee.
        // _updateLastTotalAssets(
        //   lastTotalAssets + MORPHO.expectedSupplyAssets(marketParams, address(this))
        // );

        emit SetWithdrawQueue(msg.sender, withdrawQueue);
      }

      marketConfig.removableAt = 0;
    }

    marketConfig.cap = supplyCap;
    emit SetCap(_msgSender(), id, supplyCap);
    delete pendingCap[id];
  }

  /* LIQUIDITY ALLOCATION */

  /// @dev Supplies `assets` to Morpho.
  function _supplyPool(uint256 assets) internal {
    for (uint256 i; i < supplyQueue.length; ++i) {
      IPool id = supplyQueue[i];

      uint256 supplyCap = config[id].cap;
      if (supplyCap == 0) continue;

      // IPool marketParams = _marketParams(id);
      // MORPHO.accrueInterest(marketParams);

      // todo
      // Market memory market = MORPHO.market(id);
      // uint256 supplyShares = MORPHO.supplyShares(id, address(this));
      // // `supplyAssets` needs to be rounded up for `toSupply` to be rounded down.
      // uint256 supplyAssets = supplyShares.toAssetsUp(
      //   market.totalSupplyAssets,
      //   market.totalSupplyShares
      // );

      // uint256 toSupply = UtilsLib.min(supplyCap.zeroFloorSub(supplyAssets), assets);

      // if (toSupply > 0) {
      //   // Using try/catch to skip markets that revert.
      //   try MORPHO.supply(marketParams, toSupply, 0, address(this), hex'') {
      //     assets -= toSupply;
      //   } catch {}
      // }

      if (assets == 0) return;
    }

    if (assets != 0) revert AllCapsReached();
  }

  /// @dev Withdraws `assets` from Morpho.
  function _withdrawPool(uint256 assets) internal {
    for (uint256 i; i < withdrawQueue.length; ++i) {
      IPool id = withdrawQueue[i];
      (uint256 supplyAssets,) = _accruedSupplyBalance(id);
      // uint256 toWithdraw = UtilsLib.min(
      //   _withdrawable(id, market.totalSupplyAssets, market.totalBorrowAssets, supplyAssets),
      //   assets
      // );
      // if (toWithdraw > 0) {
      //   // Using try/catch to skip markets that revert.
      //   try MORPHO.withdraw(marketParams, toWithdraw, 0, address(this), address(this)) {
      //     assets -= toWithdraw;
      //   } catch {}
      // }

      if (assets == 0) return;
    }

    if (assets != 0) revert NotEnoughLiquidity();
  }

  /// @dev Simulates a withdraw of `assets` from Morpho.
  /// @return The remaining assets to be withdrawn.
  function _simulateWithdrawMorpho(uint256 assets) internal view returns (uint256) {
    for (uint256 i; i < withdrawQueue.length; ++i) {
      IPool id = withdrawQueue[i];
      // MarketConfig marketParams = _marketParams(id);

      // todo
      // uint256 supplyShares = MORPHO.supplyShares(id, address(this));
      // (uint256 totalSupplyAssets, uint256 totalSupplyShares, uint256 totalBorrowAssets, ) = MORPHO
      //   .expectedMarketBalances(id);

      // // The vault withdrawing from Morpho cannot fail because:
      // // 1. oracle.price() is never called (the vault doesn't borrow)
      // // 2. the amount is capped to the liquidity available on Morpho
      // // 3. virtually accruing interest didn't fail
      // assets = assets.zeroFloorSub(
      //   _withdrawable(
      //     marketParams,
      //     totalSupplyAssets,
      //     totalBorrowAssets,
      //     supplyShares.toAssetsDown(totalSupplyAssets, totalSupplyShares)
      //   )
      // );

      if (assets == 0) break;
    }

    return assets;
  }

  /// @dev Returns the withdrawable amount of assets from the market defined by `marketParams`, given the market's
  /// total supply and borrow assets and the vault's assets supplied.
  function _withdrawable(
    IPool marketParams,
    uint256 totalSupplyAssets,
    uint256 totalBorrowAssets,
    uint256 supplyAssets
  ) internal view returns (uint256) {
    // todo
    // // Inside a flashloan callback, liquidity on Morpho Blue may be limited to the singleton's balance.
    // uint256 availableLiquidity = UtilsLib.min(
    //   totalSupplyAssets - totalBorrowAssets,
    //   ERC20(marketParams.loanToken).balanceOf(address(MORPHO))
    // );
    // return UtilsLib.min(supplyAssets, availableLiquidity);
    return 0;
  }

  /* FEE MANAGEMENT */

  /// @dev Updates `lastTotalAssets` to `updatedTotalAssets`.
  function _updateLastTotalAssets(uint256 updatedTotalAssets) internal {
    lastTotalAssets = updatedTotalAssets;

    emit UpdateLastTotalAssets(updatedTotalAssets);
  }

  /// @dev Accrues the fee and mints the fee shares to the fee recipient.
  /// @return newTotalAssets The vaults total assets after accruing the interest.
  function _accrueFee() internal returns (uint256 newTotalAssets) {
    uint256 feeShares;
    (feeShares, newTotalAssets) = _accruedFeeShares();
    if (feeShares != 0) _mint(feeRecipient, feeShares);
    emit AccrueInterest(newTotalAssets, feeShares);
  }

  /// @dev Computes and returns the fee shares (`feeShares`) to mint and the new vault's total assets
  /// (`newTotalAssets`).
  function _accruedFeeShares() internal view returns (uint256 feeShares, uint256 newTotalAssets) {
    newTotalAssets = totalAssets();

    uint256 totalInterest = newTotalAssets.zeroFloorSub(lastTotalAssets);
    if (totalInterest != 0 && fee != 0) {
      // It is acknowledged that `feeAssets` may be rounded down to 0 if `totalInterest * fee < WAD`.
      uint256 feeAssets = totalInterest.mulDiv(fee, 1e18);
      // The fee assets is subtracted from the total assets in this calculation to compensate for the fact
      // that total assets is already increased by the total interest (including the fee assets).
      feeShares = _convertToSharesWithTotals(feeAssets, totalSupply(), newTotalAssets - feeAssets, MathUpgradeable.Rounding.Down);
    }
  }
}
