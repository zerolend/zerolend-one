# Solidity API

## ConfiguratorInputTypes

### InitReserveInput

```solidity
struct InitReserveInput {
  address interestRateStrategyAddress;
  address asset;
  bytes params;
  uint256 liquidationThreshold;
  uint256 liquidationBonus;
  uint256 ltv;
  uint8 underlyingAssetDecimals;
}
```

