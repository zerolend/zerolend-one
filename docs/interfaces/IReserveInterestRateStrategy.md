# Solidity API

## IReserveInterestRateStrategy

Interface for the calculation of the interest rates

### calculateInterestRates

```solidity
function calculateInterestRates(struct DataTypes.CalculateInterestRatesParams params) external view returns (uint256, uint256, uint256)
```

Calculates the interest rates depending on the reserve's state and configurations

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct DataTypes.CalculateInterestRatesParams | The parameters needed to calculate interest rates |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | liquidityRate The liquidity rate expressed in rays |
| [1] | uint256 | stableBorrowRate The stable borrow rate expressed in rays |
| [2] | uint256 | variableBorrowRate The variable borrow rate expressed in rays |

