# Solidity API

## DataTypes

### ReserveData

```solidity
struct ReserveData {
  struct DataTypes.ReserveConfigurationMap configuration;
  uint128 liquidityIndex;
  uint128 currentLiquidityRate;
  uint128 variableBorrowIndex;
  uint128 currentVariableBorrowRate;
  uint128 currentStableBorrowRate;
  uint40 lastUpdateTimestamp;
  uint16 id;
  address aTokenAddress;
  address stableDebtTokenAddress;
  address variableDebtTokenAddress;
  address interestRateStrategyAddress;
  uint128 accruedToTreasury;
  uint128 unbacked;
  uint128 isolationModeTotalDebt;
}
```

### ReserveConfigurationMap

```solidity
struct ReserveConfigurationMap {
  uint256 data;
}
```

### UserConfigurationMap

```solidity
struct UserConfigurationMap {
  uint256 data;
}
```

### EModeCategory

```solidity
struct EModeCategory {
  uint16 ltv;
  uint16 liquidationThreshold;
  uint16 liquidationBonus;
  address priceSource;
  string label;
}
```

### InterestRateMode

```solidity
enum InterestRateMode {
  NONE,
  STABLE,
  VARIABLE
}
```

### ReserveCache

```solidity
struct ReserveCache {
  uint256 currScaledVariableDebt;
  uint256 nextScaledVariableDebt;
  uint256 currPrincipalStableDebt;
  uint256 currAvgStableBorrowRate;
  uint256 currTotalStableDebt;
  uint256 nextAvgStableBorrowRate;
  uint256 nextTotalStableDebt;
  uint256 currLiquidityIndex;
  uint256 nextLiquidityIndex;
  uint256 currVariableBorrowIndex;
  uint256 nextVariableBorrowIndex;
  uint256 currLiquidityRate;
  uint256 currVariableBorrowRate;
  uint256 reserveFactor;
  struct DataTypes.ReserveConfigurationMap reserveConfiguration;
  address aTokenAddress;
  address stableDebtTokenAddress;
  address variableDebtTokenAddress;
  uint40 reserveLastUpdateTimestamp;
  uint40 stableDebtLastUpdateTimestamp;
}
```

### ExecuteLiquidationCallParams

```solidity
struct ExecuteLiquidationCallParams {
  uint256 reservesCount;
  uint256 debtToCover;
  address collateralAsset;
  address debtAsset;
  address user;
  bool receiveAToken;
  address priceOracle;
  uint8 userEModeCategory;
  address priceOracleSentinel;
}
```

### ExecuteSupplyParams

```solidity
struct ExecuteSupplyParams {
  address asset;
  uint256 amount;
  address onBehalfOf;
  uint16 referralCode;
}
```

### ExecuteBorrowParams

```solidity
struct ExecuteBorrowParams {
  address asset;
  address user;
  address onBehalfOf;
  uint256 amount;
  enum DataTypes.InterestRateMode interestRateMode;
  uint16 referralCode;
  bool releaseUnderlying;
  uint256 maxStableRateBorrowSizePercent;
  uint256 reservesCount;
  address oracle;
  uint8 userEModeCategory;
  address priceOracleSentinel;
}
```

### ExecuteRepayParams

```solidity
struct ExecuteRepayParams {
  address asset;
  uint256 amount;
  enum DataTypes.InterestRateMode interestRateMode;
  address onBehalfOf;
  bool useATokens;
}
```

### ExecuteWithdrawParams

```solidity
struct ExecuteWithdrawParams {
  address asset;
  uint256 amount;
  address to;
  uint256 reservesCount;
  address oracle;
  uint8 userEModeCategory;
}
```

### ExecuteSetUserEModeParams

```solidity
struct ExecuteSetUserEModeParams {
  uint256 reservesCount;
  address oracle;
  uint8 categoryId;
}
```

### FinalizeTransferParams

```solidity
struct FinalizeTransferParams {
  address asset;
  address from;
  address to;
  uint256 amount;
  uint256 balanceFromBefore;
  uint256 balanceToBefore;
  uint256 reservesCount;
  address oracle;
  uint8 fromEModeCategory;
}
```

### FlashloanParams

```solidity
struct FlashloanParams {
  address receiverAddress;
  address[] assets;
  uint256[] amounts;
  uint256[] interestRateModes;
  address onBehalfOf;
  bytes params;
  uint16 referralCode;
  uint256 flashLoanPremiumToProtocol;
  uint256 flashLoanPremiumTotal;
  uint256 maxStableRateBorrowSizePercent;
  uint256 reservesCount;
  address addressesProvider;
  address pool;
  uint8 userEModeCategory;
  bool isAuthorizedFlashBorrower;
}
```

### FlashloanSimpleParams

```solidity
struct FlashloanSimpleParams {
  address receiverAddress;
  address asset;
  uint256 amount;
  bytes params;
  uint16 referralCode;
  uint256 flashLoanPremiumToProtocol;
  uint256 flashLoanPremiumTotal;
}
```

### FlashLoanRepaymentParams

```solidity
struct FlashLoanRepaymentParams {
  uint256 amount;
  uint256 totalPremium;
  uint256 flashLoanPremiumToProtocol;
  address asset;
  address receiverAddress;
  uint16 referralCode;
}
```

### CalculateUserAccountDataParams

```solidity
struct CalculateUserAccountDataParams {
  struct DataTypes.UserConfigurationMap userConfig;
  uint256 reservesCount;
  address user;
  address oracle;
  uint8 userEModeCategory;
}
```

### ValidateBorrowParams

```solidity
struct ValidateBorrowParams {
  struct DataTypes.ReserveCache reserveCache;
  struct DataTypes.UserConfigurationMap userConfig;
  address asset;
  address userAddress;
  uint256 amount;
  enum DataTypes.InterestRateMode interestRateMode;
  uint256 maxStableLoanPercent;
  uint256 reservesCount;
  address oracle;
  uint8 userEModeCategory;
  address priceOracleSentinel;
  bool isolationModeActive;
  address isolationModeCollateralAddress;
  uint256 isolationModeDebtCeiling;
}
```

### ValidateLiquidationCallParams

```solidity
struct ValidateLiquidationCallParams {
  struct DataTypes.ReserveCache debtReserveCache;
  uint256 totalDebt;
  uint256 healthFactor;
  address priceOracleSentinel;
}
```

### CalculateInterestRatesParams

```solidity
struct CalculateInterestRatesParams {
  uint256 unbacked;
  uint256 liquidityAdded;
  uint256 liquidityTaken;
  uint256 totalStableDebt;
  uint256 totalVariableDebt;
  uint256 averageStableBorrowRate;
  uint256 reserveFactor;
  address reserve;
  address aToken;
}
```

### InitReserveParams

```solidity
struct InitReserveParams {
  address asset;
  address aTokenAddress;
  address stableDebtAddress;
  address variableDebtAddress;
  address interestRateStrategyAddress;
  uint16 reservesCount;
  uint16 maxNumberReserves;
}
```

