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
  struct DataTypes.ReserveConfigurationMap reserveConfiguration;
  uint40 reserveLastUpdateTimestamp;
}
```

### PositionBalance

```solidity
struct PositionBalance {
  uint256 scaledSupplyBalance;
  uint256 lastSupplyLiquidtyIndex;
  uint256 scaledDebtBalance;
  uint256 lastDebtLiquidtyIndex;
}
```

### ReserveSupplies

```solidity
struct ReserveSupplies {
  uint256 collateral;
  uint256 debt;
}
```

### ExecuteLiquidationCallParams

```solidity
struct ExecuteLiquidationCallParams {
  address collateralAsset;
  address debtAsset;
  address pool;
  bytes32 position;
  uint256 debtToCover;
  uint256 reservesCount;
}
```

### ExecuteSupplyParams

```solidity
struct ExecuteSupplyParams {
  address asset;
  address pool;
  bytes32 position;
  uint256 amount;
}
```

### ExtraData

```solidity
struct ExtraData {
  bytes interestRateData;
  bytes hookData;
}
```

### ExecuteBorrowParams

```solidity
struct ExecuteBorrowParams {
  address asset;
  address pool;
  address user;
  bytes32 position;
  uint256 amount;
  uint256 reservesCount;
}
```

### ExecuteRepayParams

```solidity
struct ExecuteRepayParams {
  address asset;
  address pool;
  address user;
  bytes32 position;
  uint256 amount;
}
```

### ExecuteWithdrawParams

```solidity
struct ExecuteWithdrawParams {
  address asset;
  address destination;
  uint256 amount;
  bytes32 position;
  uint256 reservesCount;
  address pool;
}
```

### FlashloanSimpleParams

```solidity
struct FlashloanSimpleParams {
  address receiverAddress;
  address asset;
  uint256 amount;
  bytes params;
  uint256 flashLoanPremiumTotal;
}
```

### FlashLoanRepaymentParams

```solidity
struct FlashLoanRepaymentParams {
  uint256 amount;
  uint256 totalPremium;
  address asset;
  address receiverAddress;
  address pool;
}
```

### CalculateUserAccountDataParams

```solidity
struct CalculateUserAccountDataParams {
  struct DataTypes.UserConfigurationMap userConfig;
  uint256 reservesCount;
  bytes32 position;
  address pool;
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
  address pool;
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
}
```

### InitReserveParams

```solidity
struct InitReserveParams {
  address asset;
  address interestRateStrategyAddress;
  uint16 reservesCount;
}
```

