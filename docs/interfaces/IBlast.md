# Solidity API

## YieldMode

```solidity
enum YieldMode {
  AUTOMATIC,
  VOID,
  CLAIMABLE
}
```

## GasMode

```solidity
enum GasMode {
  VOID,
  CLAIMABLE
}
```

## IBlast

### configureContract

```solidity
function configureContract(address contractAddress, enum YieldMode _yield, enum GasMode gasMode, address governor) external
```

### configure

```solidity
function configure(enum YieldMode _yield, enum GasMode gasMode, address governor) external
```

### configureClaimableYield

```solidity
function configureClaimableYield() external
```

### configureClaimableYieldOnBehalf

```solidity
function configureClaimableYieldOnBehalf(address contractAddress) external
```

### configureAutomaticYield

```solidity
function configureAutomaticYield() external
```

### configureAutomaticYieldOnBehalf

```solidity
function configureAutomaticYieldOnBehalf(address contractAddress) external
```

### configureVoidYield

```solidity
function configureVoidYield() external
```

### configureVoidYieldOnBehalf

```solidity
function configureVoidYieldOnBehalf(address contractAddress) external
```

### configureClaimableGas

```solidity
function configureClaimableGas() external
```

### configureClaimableGasOnBehalf

```solidity
function configureClaimableGasOnBehalf(address contractAddress) external
```

### configureVoidGas

```solidity
function configureVoidGas() external
```

### configureVoidGasOnBehalf

```solidity
function configureVoidGasOnBehalf(address contractAddress) external
```

### configureGovernor

```solidity
function configureGovernor(address _governor) external
```

### configureGovernorOnBehalf

```solidity
function configureGovernorOnBehalf(address _newGovernor, address contractAddress) external
```

### claimYield

```solidity
function claimYield(address contractAddress, address recipientOfYield, uint256 amount) external returns (uint256)
```

### claimAllYield

```solidity
function claimAllYield(address contractAddress, address recipientOfYield) external returns (uint256)
```

### claimAllGas

```solidity
function claimAllGas(address contractAddress, address recipientOfGas) external returns (uint256)
```

### claimGasAtMinClaimRate

```solidity
function claimGasAtMinClaimRate(address contractAddress, address recipientOfGas, uint256 minClaimRateBips) external returns (uint256)
```

### claimMaxGas

```solidity
function claimMaxGas(address contractAddress, address recipientOfGas) external returns (uint256)
```

### claimGas

```solidity
function claimGas(address contractAddress, address recipientOfGas, uint256 gasToClaim, uint256 gasSecondsToConsume) external returns (uint256)
```

### readClaimableYield

```solidity
function readClaimableYield(address contractAddress) external view returns (uint256)
```

### readYieldConfiguration

```solidity
function readYieldConfiguration(address contractAddress) external view returns (uint8)
```

### readGasParams

```solidity
function readGasParams(address contractAddress) external view returns (uint256 etherSeconds, uint256 etherBalance, uint256 lastUpdated, enum GasMode)
```

## IBlastRebasingERC20

### configure

```solidity
function configure(enum YieldMode) external returns (uint256)
```

### claim

```solidity
function claim(address recipient, uint256 amount) external returns (uint256)
```

### getClaimableAmount

```solidity
function getClaimableAmount(address account) external view returns (uint256)
```

