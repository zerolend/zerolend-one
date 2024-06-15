# Solidity API

## MockFlashLoanReceiver

### ExecutedWithFail

```solidity
event ExecutedWithFail(address[] _assets, uint256[] _amounts, uint256[] _premiums)
```

### ExecutedWithSuccess

```solidity
event ExecutedWithSuccess(address[] _assets, uint256[] _amounts, uint256[] _premiums)
```

### _failExecution

```solidity
bool _failExecution
```

### _amountToApprove

```solidity
uint256 _amountToApprove
```

### _simulateEOA

```solidity
bool _simulateEOA
```

### constructor

```solidity
constructor(contract IPoolAddressesProvider provider) public
```

### setFailExecutionTransfer

```solidity
function setFailExecutionTransfer(bool fail) public
```

### setAmountToApprove

```solidity
function setAmountToApprove(uint256 amountToApprove) public
```

### setSimulateEOA

```solidity
function setSimulateEOA(bool flag) public
```

### getAmountToApprove

```solidity
function getAmountToApprove() public view returns (uint256)
```

### simulateEOA

```solidity
function simulateEOA() public view returns (bool)
```

### executeOperation

```solidity
function executeOperation(address[] assets, uint256[] amounts, uint256[] premiums, address, bytes) public returns (bool)
```

