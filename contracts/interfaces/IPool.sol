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

import {DataTypes} from '../core/pool/configuration/DataTypes.sol';
import {IHook} from './IHook.sol';
import {IPoolFactory} from './IPoolFactory.sol';

/**
 * @title IPool
 * @notice Defines the basic interface for a ZeroLend Pool.
 */
interface IPool {
  /**
   * @dev Emitted on supply()
   * @param reserve The address of the underlying asset of the reserve
   * @param user The address initiating the supply
   * @param onBehalfOf The beneficiary of the supply, receiving the aTokens
   * @param amount The amount supplied
   */
  event Supply(address indexed reserve, address user, address indexed onBehalfOf, uint256 amount);

  /**
   * @dev Emitted on withdraw()
   * @param reserve The address of the underlying asset being withdrawn
   * @param user The address initiating the withdrawal, owner of aTokens
   * @param to The address that will receive the underlying
   * @param amount The amount to be withdrawn
   */
  event Withdraw(address indexed reserve, address indexed user, address indexed to, uint256 amount);

  /**
   * @dev Emitted on borrow() and flashLoan() when debt needs to be opened
   * @param reserve The address of the underlying asset being borrowed
   * @param user The address of the user initiating the borrow(), receiving the funds on borrow() or just
   * initiator of the transaction on flashLoan()
   * @param position The position to update for
   * @param amount The amount borrowed out
   * @param borrowRate The numeric rate at which the user has borrowed, expressed in ray
   */
  event Borrow(address indexed reserve, address user, bytes32 indexed position, uint256 amount, uint256 borrowRate);

  /**
   * @dev Emitted on repay()
   * @param reserve The address of the underlying asset of the reserve
   * @param user The beneficiary of the repayment, getting his debt reduced
   * @param repayer The address of the user initiating the repay(), providing the funds
   * @param amount The amount repaid
   * @param useATokens True if the repayment is done using aTokens, `false` if done with underlying asset directly
   */
  event Repay(address indexed reserve, address indexed user, address indexed repayer, uint256 amount, bool useATokens);

  /**
   * @dev Emitted on setUserUseReserveAsCollateral()
   * @param reserve The address of the underlying asset of the reserve
   * @param user The address of the user enabling the usage as collateral
   */
  event ReserveUsedAsCollateralEnabled(address indexed reserve, address indexed user);

  /**
   * @dev Emitted on setUserUseReserveAsCollateral()
   * @param reserve The address of the underlying asset of the reserve
   * @param user The address of the user enabling the usage as collateral
   */
  event ReserveUsedAsCollateralDisabled(address indexed reserve, address indexed user);

  /**
   * @dev Emitted on flashLoan()
   * @param target The address of the flash loan receiver contract
   * @param initiator The address initiating the flash loan
   * @param asset The address of the asset being flash borrowed
   * @param amount The amount flash borrowed
   * @param premium The fee flash borrowed
   */
  event FlashLoan(address indexed target, address initiator, address indexed asset, uint256 amount, uint256 premium);

  /**
   * @dev Emitted when a borrower is liquidated.
   * @param collateralAsset The address of the underlying asset used as collateral, to receive as result of the liquidation
   * @param debtAsset The address of the underlying borrowed asset to be repaid with the liquidation
   * @param user The address of the borrower getting liquidated
   * @param debtToCover The debt amount of borrowed `asset` the liquidator wants to cover
   * @param liquidatedCollateralAmount The amount of collateral received by the liquidator
   * @param liquidator The address of the liquidator
   * @param receiveAToken True if the liquidators wants to receive the collateral aTokens, `false` if he wants
   * to receive the underlying collateral asset directly
   */
  event LiquidationCall(
    address indexed collateralAsset,
    address indexed debtAsset,
    address indexed user,
    uint256 debtToCover,
    uint256 liquidatedCollateralAmount,
    address liquidator,
    bool receiveAToken
  );

  /**
   * @dev Emitted when the state of a reserve is updated.
   * @param reserve The address of the underlying asset of the reserve
   * @param liquidityRate The next liquidity rate
   * @param variableBorrowRate The next variable borrow rate
   * @param liquidityIndex The next liquidity index
   * @param borrowIndex The next variable borrow index
   */
  event ReserveDataUpdated(
    address indexed reserve,
    uint256 liquidityRate,
    uint256 variableBorrowRate,
    uint256 liquidityIndex,
    uint256 borrowIndex
  );

  /**
   * @dev Emitted when the protocol treasury receives minted aTokens from the accrued interest.
   * @param reserve The address of the reserve
   * @param amountMinted The amount minted to the treasury
   */
  event MintedToTreasury(address indexed reserve, uint256 amountMinted);

  /**
   * @dev Emitted when the collateralization risk parameters for the specified asset are updated.
   * @param asset The address of the underlying asset of the reserve
   * @param ltv The loan to value of the asset when used as collateral
   * @param liquidationThreshold The threshold at which loans using this asset as collateral will be considered undercollateralized
   * @param liquidationBonus The bonus liquidators receive to liquidate this asset
   */
  event CollateralConfigurationChanged(address indexed asset, uint256 ltv, uint256 liquidationThreshold, uint256 liquidationBonus);

  /**
   * @dev Emitted when a reserve is initialized.
   * @param asset The address of the underlying asset of the reserve
   * @param oracle The address of the oracle
   * @param interestRateStrategyAddress The address of the interest rate strategy for the reserve
   */
  event ReserveInitialized(address indexed asset, address oracle, address interestRateStrategyAddress);

  /**
   * Returns the version of the pool implementation
   * @return version The version of this pool's implementation
   */
  function revision() external view returns (uint256 version);

  /**
   * @notice Initializes the pool with the given parameters. This call sets all the assets and their configs (LTV/LT/Oracle etc..)
   * in one call. Since assets once created cannot be changed, this has to be done within the initialize call itself.
   * @dev This is function is called by the factory contract.
   * @param params The init parameters for the pool. See {DataTypes-InitPoolParams}
   */
  function initialize(DataTypes.InitPoolParams memory params) external;

  /**
   * @notice Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
   * - E.g. User supplies 100 USDC and gets in return 100 aUSDC
   * @param asset The address of the underlying asset to supply
   * @param amount The amount to be supplied
   * @param index The index of the user's position
   * @param data Extra data that gets passed to the hook and to the interest rate strategy
   * @return minted The amount of shares minted
   */
  function supply(
    address asset,
    uint256 amount,
    uint256 index,
    DataTypes.ExtraData memory data
  ) external returns (DataTypes.SharesType memory minted);

  /**
   * @dev See [supply(...)](#supply) for the full documentation. This call executes the same function with
   * dummy data params
   */
  function supplySimple(address asset, uint256 amount, uint256 index) external returns (DataTypes.SharesType memory);

  /**
   * @notice Withdraws an `amount` of underlying asset from the reserve, burning the equivalent aTokens owned
   * E.g. User has 100 aUSDC, calls withdraw() and receives 100 USDC, burning the 100 aUSDC
   * @param asset The address of the underlying asset to withdraw
   * @param amount The underlying amount to be withdrawn
   *   - Send the value type(uint256).max in order to withdraw the whole aToken balance
   * @param index The index of the user's position
   * @param data Extra data that gets passed to the hook and to the interest rate strategy
   * @return burnt The amount of shares burnt
   */
  function withdraw(
    address asset,
    uint256 amount,
    uint256 index,
    DataTypes.ExtraData memory data
  ) external returns (DataTypes.SharesType memory burnt);

  /**
   * @dev See [withdraw(...)](#withdraw) for the full documentation. This call executes the same function with
   * dummy data params
   */
  function withdrawSimple(address asset, uint256 amount, uint256 index) external returns (DataTypes.SharesType memory minted);

  /**
   * @notice Allows users to borrow a specific `amount` of the reserve underlying asset, provided that the borrower
   * already supplied enough collateral, or he was given enough allowance by a credit delegator on the
   * corresponding debt token (StableDebtToken or VariableDebtToken)
   * - E.g. User borrows 100 USDC passing as `onBehalfOf` his own address, receiving the 100 USDC in his wallet
   *   and 100 stable/variable debt tokens, depending on the `interestRateMode`
   * @param asset The address of the underlying asset to borrow
   * @param amount The amount to be borrowed
   * @param index The index of the user's position
   * @param data Extra data that gets passed to the hook and to the interest rate strategy
   * @return borrowed The amount of shares borrowed
   */
  function borrow(
    address asset,
    uint256 amount,
    uint256 index,
    DataTypes.ExtraData memory data
  ) external returns (DataTypes.SharesType memory borrowed);

  /**
   * @dev See [borrow(...)](#borrow) for the full documentation. This call executes the same function with
   * dummy data params
   */
  function borrowSimple(address asset, uint256 amount, uint256 index) external returns (DataTypes.SharesType memory);

  /**
   * @notice Repays a borrowed `amount` on a specific reserve, burning the equivalent debt tokens owned
   * - E.g. User repays 100 USDC, burning 100 variable/stable debt tokens of the `onBehalfOf` address
   * @param asset The address of the borrowed underlying asset previously borrowed
   * @param amount The amount to repay
   * - Send the value type(uint256).max in order to repay the whole debt for `asset` on the specific `debtMode`
   * @param index The index of the user's position
   * @param data Extra data that gets passed to the hook and to the interest rate strategy
   * @return repaid The amount of shares repaid
   */
  function repay(
    address asset,
    uint256 amount,
    uint256 index,
    DataTypes.ExtraData memory data
  ) external returns (DataTypes.SharesType memory repaid);

  /**
   * @dev See [repay(...)](#repay) for the full documentation. This call executes the same function with
   * dummy data params
   */
  function repaySimple(address asset, uint256 amount, uint256 index) external returns (DataTypes.SharesType memory);

  /**
   * @notice Allows suppliers to enable/disable a specific supplied asset as collateral
   * @param asset The address of the underlying asset supplied
   * @param index The index of the user's position
   * @param useAsCollateral True if the user wants to use the supply as collateral, false otherwise
   */
  function setUserUseReserveAsCollateral(address asset, uint256 index, bool useAsCollateral) external;

  /**
   * @notice Function to liquidate a non-healthy position collateral-wise, with Health Factor below 1
   * - The caller (liquidator) covers `debtToCover` amount of debt of the user getting liquidated, and receives
   *   a proportionally amount of the `collateralAsset` plus a bonus to cover market risk
   * @param collateralAsset The address of the underlying asset used as collateral, to receive as result of the liquidation
   * @param debtAsset The address of the underlying borrowed asset to be repaid with the liquidation
   * @param debtToCover The debt amount of borrowed `asset` the liquidator wants to cover
   * @param data Extra data that gets passed to the hook and to the interest rate strategy
   */
  function liquidate(
    address collateralAsset,
    address debtAsset,
    bytes32 position,
    uint256 debtToCover,
    DataTypes.ExtraData memory data
  ) external;

  /**
   * @dev See [liquidate(...)](#liquidate) for the full documentation. This call executes the same function with
   * dummy data params
   */
  function liquidateSimple(address collateralAsset, address debtAsset, bytes32 position, uint256 debtToCover) external;

  /**
   * @dev See [flashLoan(...)](#flashLoan) for the full documentation. This call executes the same function with
   * dummy data params
   */
  function flashLoanSimple(address receiverAddress, address asset, uint256 amount, bytes calldata params) external;

  /**
   * @notice Allows smartcontracts to access the liquidity of the pool within one transaction,
   * as long as the amount taken plus a fee is returned.
   * @dev IMPORTANT There are security concerns for developers of flashloan receiver contracts that must be kept
   * into consideration.
   * @param receiverAddress The address of the contract receiving the funds, implementing IFlashLoanSimpleReceiver interface
   * @param asset The address of the asset being flash-borrowed
   * @param amount The amount of the asset being flash-borrowed
   * @param params Variadic packed params to pass to the receiver as extra information
   * @param data Extra data that gets passed to the hook and to the interest rate strategy
   */
  function flashLoan(
    address receiverAddress,
    address asset,
    uint256 amount,
    bytes calldata params,
    DataTypes.ExtraData memory data
  ) external;

  /**
   * @notice Get the balance of a specific asset in a specific position.
   * @param asset The address of the asset.
   * @param positionId The ID of the position.
   * @return balance The balance of the specified asset in the specified position.
   */
  function getBalanceByPosition(address asset, bytes32 positionId) external view returns (uint256 balance);

  /**
   * @notice Get the balance of a specific asset for a user given a position index
   * @param asset The address of the asset.
   * @param who The user to find the balance of
   * @param index The index of the user's position
   * @return balance The balance of the specified asset for the given user and position idnex.
   */
  function getBalance(address asset, address who, uint256 index) external view returns (uint256 balance);

  /**
   * @notice Get the debt of a specific asset for a user given a position index
   * @param asset The address of the asset.
   * @param who The user to find the debt of
   * @param index The index of the user's position
   * @return debt The debt of the specified asset for the given user and position idnex.
   */
  function getDebt(address asset, address who, uint256 index) external view returns (uint256 debt);

  /**
   * @notice Get the debt of a specific asset in a specific position.
   * @param asset The address of the asset.
   * @param positionId The ID of the position.
   * @return debt The debt of the specified asset in the specified position.
   */
  function getDebtByPosition(address asset, bytes32 positionId) external view returns (uint256 debt);

  /**
   * @notice Gets the reserve factor that this pool charges. The reserve factory is the percentage of
   * revenue that the pool shares with the governance.
   * @dev This parameter is immutable.
   * @return reseveFactor The amount of revenue that gets shared to governance.
   */
  function getReserveFactor() external view returns (uint256 reseveFactor);

  /**
   * @notice The factory contract that created this contract
   */
  function factory() external view returns (IPoolFactory f);

  /**
   * @notice Returns the user account data across all the reserves
   * @param user The address of the user
   * @param index The index of the user's position
   * @return totalCollateralBase The total collateral of the user in the base currency used by the price feed
   * @return totalDebtBase The total debt of the user in the base currency used by the price feed
   * @return availableBorrowsBase The borrowing power left of the user in the base currency used by the price feed
   * @return currentLiquidationThreshold The liquidation threshold of the user
   * @return ltv The loan to value of The user
   * @return healthFactor The current health factor of the user
   */
  function getUserAccountData(
    address user,
    uint256 index
  )
    external
    view
    returns (
      uint256 totalCollateralBase,
      uint256 totalDebtBase,
      uint256 availableBorrowsBase,
      uint256 currentLiquidationThreshold,
      uint256 ltv,
      uint256 healthFactor
    );

  /**
   * @notice Sets the configuration bitmap of the reserve as a whole
   * @dev Only callable by the PoolConfigurator contract
   * @param asset The address of the underlying asset of the reserve
   * @param rateStrategyAddress The address of the rate strategy for the reserve
   * @param source The address of the oracle for the reserve
   * @param configuration The new configuration bitmap
   */
  function setReserveConfiguration(
    address asset,
    address rateStrategyAddress,
    address source,
    DataTypes.ReserveConfigurationMap calldata configuration
  ) external;

  /**
   * @notice Returns the configuration of the reserve
   * @param asset The address of the underlying asset of the reserve
   * @return The configuration of the reserve
   */
  function getConfiguration(address asset) external view returns (DataTypes.ReserveConfigurationMap memory);

  /**
   * @notice Returns the configuration of the user across all the reserves
   * @param user The user address
   * @param index The index of the user's position
   * @return The configuration of the user
   */
  function getUserConfiguration(address user, uint256 index) external view returns (DataTypes.UserConfigurationMap memory);

  /**
   * @notice Returns the normalized income of the reserve
   * @param asset The address of the underlying asset of the reserve
   * @return The reserve's normalized income
   */
  function getReserveNormalizedIncome(address asset) external view returns (uint256);

  /**
   * @notice Returns the normalized variable debt per unit of asset
   * @dev WARNING: This function is intended to be used primarily by the protocol itself to get a
   * "dynamic" variable index based on time, current stored index and virtual rate at the current
   * moment (approx. a borrower would get if opening a position). This means that is always used in
   * combination with variable debt supply/balances.
   * If using this function externally, consider that is possible to have an increasing normalized
   * variable debt that is not equivalent to how the variable debt index would be updated in storage
   * (e.g. only updates with non-zero variable debt supply)
   * @param asset The address of the underlying asset of the reserve
   * @return The reserve normalized variable debt
   */
  function getReserveNormalizedVariableDebt(address asset) external view returns (uint256);

  /**
   * @notice Returns the state and configuration of the reserve
   * @param asset The address of the underlying asset of the reserve
   * @return The state and configuration data of the reserve
   */
  function getReserveData(address asset) external view returns (DataTypes.ReserveData memory);

  /**
   * @notice Returns the list of the underlying assets of all the initialized reserves
   * @return The addresses of the underlying assets of the initialized reserves
   */
  function getReservesList() external view returns (address[] memory);

  /**
   * @notice Returns the number of initialized reserves
   * @return The count
   */
  function getReservesCount() external view returns (uint256);

  /**
   * @notice Returns the address of the underlying asset of a reserve by the reserve id as stored in the DataTypes.ReserveData struct
   * @param id The id of the reserve as stored in the DataTypes.ReserveData struct
   * @return The address of the reserve associated with id
   */
  function getReserveAddressById(uint16 id) external view returns (address);

  /**
   * @notice Returns the asset price in the base currency
   * @param asset The address of the asset
   * @return The price of the asset
   */
  function getAssetPrice(address asset) external view returns (uint256);

  /**
   * @notice Returns the current hook for the pool.
   * @dev The hook is immutable. Once it is set, it cannot be changed.
   * @return The hook for the pool, if set.
   */
  function getHook() external view returns (IHook);

  /**
   * @notice Gets the raw balance object for the asset for a given position id
   */
  function getBalanceRawByPositionId(address asset, bytes32 positionId) external view returns (DataTypes.PositionBalance memory);

  /**
   * @notice Gets the raw balance object for the asset for a given user and the position index.
   * @param asset The address of the asset
   * @param who The address of the user
   * @param index The index of the user's position
   */
  function getBalanceRaw(address asset, address who, uint256 index) external view returns (DataTypes.PositionBalance memory);

  /**
   * @notice Gets the raw reserve supply object for a given asset.
   * @param asset The address of the asset
   * @return data The reserve supply information of the given asset
   */
  function getTotalSupplyRaw(address asset) external view returns (DataTypes.ReserveSupplies memory data);

  /**
   * @notice Gets the Pool Configurator
   * @return The address of the Pool Configurator
   */
  function getConfigurator() external view returns (address);

  function totalAssets(address asset) external view returns (uint256 balance);

  function totalDebt(address asset) external view returns (uint256 balance);

  function supplyShares(address asset, bytes32 positionId) external view returns (uint256 shares);

  function forceUpdateReserves() external;

  function forceUpdateReserve(address asset) external;

  function marketBalances(
    address asset
  ) external view returns (uint256 totalSupplyAssets, uint256 totalSupplyShares, uint256 totalBorrowAssets, uint256 totalBorrowShares);

  function supplyAssets(address asset, bytes32 positionId) external view returns (uint256);
}
