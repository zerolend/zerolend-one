# Solidity API

## ConfiguratorInputTypes

### InitReserveInput

```solidity
struct InitReserveInput {
  address aTokenImpl;
  address variableDebtTokenImpl;
  uint8 underlyingAssetDecimals;
  address interestRateStrategyAddress;
  address underlyingAsset;
  address treasury;
  address incentivesController;
  string aTokenName;
  string aTokenSymbol;
  string variableDebtTokenName;
  string variableDebtTokenSymbol;
  bytes params;
}
```

### UpdateATokenInput

```solidity
struct UpdateATokenInput {
  address asset;
  address treasury;
  address incentivesController;
  string name;
  string symbol;
  address implementation;
  bytes params;
}
```

### UpdateDebtTokenInput

```solidity
struct UpdateDebtTokenInput {
  address asset;
  address incentivesController;
  string name;
  string symbol;
  address implementation;
  bytes params;
}
```

