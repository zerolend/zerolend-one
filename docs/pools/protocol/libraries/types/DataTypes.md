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
  uint40 lastUpdateTimestamp;
  uint16 id;
  address aTokenAddress;
  address variableDebtTokenAddress;
  address interestRateStrategyAddress;
  uint128 accruedToTreasury;
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

### InterestRateMode

```solidity
enum InterestRateMode {
  NONE,
  VARIABLE
}
```

### ReserveCache

```solidity
struct ReserveCache {
  uint256 currScaledVariableDebt;
  uint256 nextScaledVariableDebt;
  uint256 currLiquidityIndex;
  uint256 nextLiquidityIndex;
  uint256 currVariableBorrowIndex;
  uint256 nextVariableBorrowIndex;
  uint256 currLiquidityRate;
  uint256 currVariableBorrowRate;
  uint256 reserveFactor;
  struct DataTypes.ReserveConfigurationMap reserveConfiguration;
  address aTokenAddress;
  address variableDebtTokenAddress;
  uint40 reserveLastUpdateTimestamp;
}
```

### ExecuteLiquidationCallParams

```solidity
struct ExecuteLiquidationCallParams {
  uint256 reservesCount;
  uint256 debtToCover;
  address collateralAsset;
  address debtAsset;
  bytes32 position;
  address oracle;
}
```

### ExecuteSupplyParams

```solidity
struct ExecuteSupplyParams {
  address asset;
  uint256 amount;
  bytes32 onBehalfOfPosition;
  uint16 referralCode;
}
```

### ExecuteBorrowParams

```solidity
struct ExecuteBorrowParams {
  address asset;
  address user;
  bytes32 onBehalfOfPosition;
  uint256 amount;
  uint16 referralCode;
  bool releaseUnderlying;
  uint256 reservesCount;
  address oracle;
}
```

### ExecuteRepayParams

```solidity
struct ExecuteRepayParams {
  address asset;
  uint256 amount;
  bytes32 onBehalfOfPosition;
}
```

### ExecuteWithdrawParams

```solidity
struct ExecuteWithdrawParams {
  address asset;
  uint256 amount;
  bytes32 position;
  uint256 reservesCount;
  address oracle;
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
  bytes32 position;
  address oracle;
}
```

### ValidateBorrowParams

```solidity
struct ValidateBorrowParams {
  struct DataTypes.ReserveCache reserveCache;
  struct DataTypes.UserConfigurationMap userConfig;
  address asset;
  bytes32 position;
  uint256 amount;
  uint256 reservesCount;
  address oracle;
}
```

### ValidateLiquidationCallParams

```solidity
struct ValidateLiquidationCallParams {
  struct DataTypes.ReserveCache debtReserveCache;
  uint256 totalDebt;
  uint256 healthFactor;
}
```

### CalculateInterestRatesParams

```solidity
struct CalculateInterestRatesParams {
  uint256 liquidityAdded;
  uint256 liquidityTaken;
  uint256 totalVariableDebt;
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
  address variableDebtAddress;
  address interestRateStrategyAddress;
  uint16 reservesCount;
  uint16 maxNumberReserves;
}
```

