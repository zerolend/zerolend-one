# Solidity API

## IFlashLoanSimpleReceiver

Defines the basic interface of a flashloan-receiver contract.

_Implement this interface to develop a flashloan-compatible flashLoanReceiver contract_

### executeOperation

```solidity
function executeOperation(address asset, uint256 amount, uint256 premium, address initiator, bytes params) external returns (bool)
```

Executes an operation after receiving the flash-borrowed asset

_Ensure that the contract can return the debt + premium, e.g., has
     enough funds to repay and has approved the Pool to pull the total amount_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the flash-borrowed asset |
| amount | uint256 | The amount of the flash-borrowed asset |
| premium | uint256 | The fee of the flash-borrowed asset |
| initiator | address | The address of the flashloan initiator |
| params | bytes | The byte-encoded params passed when initiating the flashloan |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the execution of the operation succeeds, false otherwise |

### POOL

```solidity
function POOL() external view returns (contract IPool)
```

