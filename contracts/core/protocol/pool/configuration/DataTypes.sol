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

library DataTypes {
  struct ReserveData {
    // stores the reserve configuration
    ReserveConfigurationMap configuration;
    // the liquidity index. Expressed in ray
    uint128 liquidityIndex;
    // the current supply rate. Expressed in ray
    uint128 currentLiquidityRate;
    // variable borrow index. Expressed in ray
    uint128 variableBorrowIndex;
    // the current variable borrow rate. Expressed in ray
    uint128 currentVariableBorrowRate;
    // timestamp of last update
    uint40 lastUpdateTimestamp;
    // the id of the reserve. Represents the position in the list of the active reserves
    uint16 id;
    // address of the interest rate strategy
    address interestRateStrategyAddress;
    // address of the oracle
    address oracle;
    // the current treasury balance in shares
    uint256 accruedToTreasuryShares;
  }

  struct ReserveConfigurationMap {
    // bit 0-15: LTV
    // bit 16-31: Liq. threshold
    // bit 32-47: Liq. bonus
    // bit 48-55: Decimals
    // bit 56: reserve is active
    // bit 57: reserve is frozen
    // bit 58: borrowing is enabled
    // bit 59: stable rate borrowing enabled
    // bit 60: asset is paused
    // bit 61: borrowing in isolation mode is enabled
    // bit 62: siloed borrowing enabled
    // bit 63: flashloaning enabled
    // bit 64-79: reserve factor
    // bit 80-115 borrow cap in whole tokens, borrowCap == 0 => no cap
    // bit 116-151 supply cap in whole tokens, supplyCap == 0 => no cap
    // bit 152-167 liquidation protocol fee
    // bit 168-175 eMode category
    // bit 176-211 unbacked mint cap in whole tokens, unbackedMintCap == 0 => minting disabled
    // bit 212-251 debt ceiling for isolation mode with (ReserveConfiguration::DEBT_CEILING_DECIMALS) decimals
    // bit 252-255 unused

    uint256 data;
  }

  struct UserConfigurationMap {
    /**
     * @dev Bitmap of the users collaterals and borrows. It is divided in pairs of bits, one pair per asset.
     * The first bit indicates if an asset is used as collateral by the user, the second whether an
     * asset is borrowed by the user.
     */
    uint256 data;
  }

  enum InterestRateMode {
    NONE,
    VARIABLE
  }

  struct ReserveCache {
    uint256 currScaledVariableDebt;
    uint256 nextScaledVariableDebt;
    uint128 currLiquidityIndex;
    uint128 nextLiquidityIndex;
    uint128 currVariableBorrowIndex;
    uint128 nextVariableBorrowIndex;
    uint256 currLiquidityRate;
    uint256 currVariableBorrowRate;
    // address asset;
    ReserveConfigurationMap reserveConfiguration;
    uint40 reserveLastUpdateTimestamp;
  }

  struct PositionBalance {
    uint256 supplyShares;
    uint128 lastSupplyLiquidtyIndex;
    uint256 debtShares;
    uint128 lastDebtLiquidtyIndex;
  }

  struct ReserveSupplies {
    uint256 collateral;
    uint256 debt;
  }

  struct ExecuteLiquidationCallParams {
    address collateralAsset;
    address debtAsset;
    address pool;
    bytes32 position;
    uint256 debtToCover;
    uint256 reservesCount;
    ExtraData data;
  }

  struct ExecuteSupplyParams {
    address asset;
    address pool;
    bytes32 position;
    uint256 amount;
    ExtraData data;
  }

  struct ExtraData {
    bytes interestRateData;
    bytes hookData;
  }

  struct ExecuteBorrowParams {
    address asset;
    address pool;
    address user;
    bytes32 position;
    uint256 amount;
    uint256 reservesCount;
    ExtraData data;
  }

  struct ExecuteRepayParams {
    address asset;
    address pool;
    address user;
    bytes32 position;
    uint256 amount;
    ExtraData data;
  }

  struct ExecuteWithdrawParams {
    address asset;
    address destination;
    uint256 amount;
    bytes32 position;
    uint256 reservesCount;
    address pool;
    ExtraData data;
  }

  struct FlashloanSimpleParams {
    address receiverAddress;
    address asset;
    uint256 amount;
    bytes params;
    uint256 flashLoanPremiumTotal;
    ExtraData data;
  }

  struct FlashLoanRepaymentParams {
    uint256 amount;
    uint256 totalPremium;
    address asset;
    address receiverAddress;
    address pool;
  }

  struct CalculateUserAccountDataParams {
    UserConfigurationMap userConfig;
    uint256 reservesCount;
    bytes32 position;
    address pool;
  }

  struct ValidateBorrowParams {
    ReserveCache reserveCache;
    UserConfigurationMap userConfig;
    address asset;
    bytes32 position;
    uint256 amount;
    uint256 reservesCount;
    address pool;
  }

  struct ValidateLiquidationCallParams {
    ReserveCache debtReserveCache;
    uint256 totalDebt;
    uint256 healthFactor;
  }

  struct CalculateInterestRatesParams {
    uint256 liquidityAdded;
    uint256 liquidityTaken;
    uint256 totalVariableDebt;
    uint256 reserveFactor;
    address reserve;
  }

  struct InitReserveConfig {
    uint256 ltv;
    uint256 liquidationThreshold;
    uint256 liquidationBonus;
    uint256 decimals;
    bool frozen;
    bool borrowable;
    uint256 borrowCap;
    uint256 supplyCap;
  }

  struct InitReserveParams {
    address asset;
    address oracle;
    address interestRateStrategyAddress;
    uint16 reservesCount;
    InitReserveConfig configuration;
  }

  struct InitPoolParams {
    address hook;
    address[] assets;
    address[] rateStrategyAddresses;
    address[] sources;
    DataTypes.InitReserveConfig[] configurations;
  }
}
