# Solidity API

## IFlashLoanReceiver

Defines the basic interface of a flashloan-receiver contract.

_Implement this interface to develop a flashloan-compatible flashLoanReceiver contract_

### executeOperation

```solidity
function executeOperation(address[] assets, uint256[] amounts, uint256[] premiums, address initiator, bytes params) external returns (bool)
```

Executes an operation after receiving the flash-borrowed assets

_Ensure that the contract can return the debt + premium, e.g., has
     enough funds to repay and has approved the Pool to pull the total amount_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| assets | address[] | The addresses of the flash-borrowed assets |
| amounts | uint256[] | The amounts of the flash-borrowed assets |
| premiums | uint256[] | The fee of each flash-borrowed asset |
| initiator | address | The address of the flashloan initiator |
| params | bytes | The byte-encoded params passed when initiating the flashloan |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if the execution of the operation succeeds, false otherwise |

### ADDRESSES_PROVIDER

```solidity
function ADDRESSES_PROVIDER() external view returns (contract IPoolAddressesProvider)
```

### POOL

```solidity
function POOL() external view returns (contract IPool)
```

