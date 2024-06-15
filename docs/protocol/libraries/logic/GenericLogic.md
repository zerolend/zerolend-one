# Solidity API

## GenericLogic

Implements protocol-level logic to calculate and validate the state of a user

### CalculateUserAccountDataVars

```solidity
struct CalculateUserAccountDataVars {
  uint256 assetPrice;
  uint256 assetUnit;
  uint256 userBalanceInBaseCurrency;
  uint256 decimals;
  uint256 ltv;
  uint256 liquidationThreshold;
  uint256 i;
  uint256 healthFactor;
  uint256 totalCollateralInBaseCurrency;
  uint256 totalDebtInBaseCurrency;
  uint256 avgLtv;
  uint256 avgLiquidationThreshold;
  uint256 eModeAssetPrice;
  uint256 eModeLtv;
  uint256 eModeLiqThreshold;
  uint256 eModeAssetCategory;
  address currentReserveAddress;
  bool hasZeroLtvCollateral;
  bool isInEModeCategory;
}
```

### calculateUserAccountData

```solidity
function calculateUserAccountData(mapping(address => struct DataTypes.ReserveData) reservesData, mapping(uint256 => address) reservesList, mapping(uint8 => struct DataTypes.EModeCategory) eModeCategories, struct DataTypes.CalculateUserAccountDataParams params) internal view returns (uint256, uint256, uint256, uint256, uint256, bool)
```

Calculates the user data across the reserves.

_It includes the total liquidity/collateral/borrow balances in the base currency used by the price feed,
the average Loan To Value, the average Liquidation Ratio, and the Health factor._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| reservesData | mapping(address &#x3D;&gt; struct DataTypes.ReserveData) | The state of all the reserves |
| reservesList | mapping(uint256 &#x3D;&gt; address) | The addresses of all the active reserves |
| eModeCategories | mapping(uint8 &#x3D;&gt; struct DataTypes.EModeCategory) | The configuration of all the efficiency mode categories |
| params | struct DataTypes.CalculateUserAccountDataParams | Additional parameters needed for the calculation |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The total collateral of the user in the base currency used by the price feed |
| [1] | uint256 | The total debt of the user in the base currency used by the price feed |
| [2] | uint256 | The average ltv of the user |
| [3] | uint256 | The average liquidation threshold of the user |
| [4] | uint256 | The health factor of the user |
| [5] | bool | True if the ltv is zero, false otherwise |

### calculateAvailableBorrows

```solidity
function calculateAvailableBorrows(uint256 totalCollateralInBaseCurrency, uint256 totalDebtInBaseCurrency, uint256 ltv) internal pure returns (uint256)
```

Calculates the maximum amount that can be borrowed depending on the available collateral, the total debt
and the average Loan To Value

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| totalCollateralInBaseCurrency | uint256 | The total collateral in the base currency used by the price feed |
| totalDebtInBaseCurrency | uint256 | The total borrow balance in the base currency used by the price feed |
| ltv | uint256 | The average loan to value |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The amount available to borrow in the base currency of the used by the price feed |

