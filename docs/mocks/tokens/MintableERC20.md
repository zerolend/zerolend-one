# Solidity API

## MintableERC20

### constructor

```solidity
constructor(string name, string symbol) public
```

### mint

```solidity
function mint(uint256 value) public returns (bool)
```

_Function to mint tokens_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | uint256 | The amount of tokens to mint. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | A boolean that indicates if the operation was successful. |

### mint

```solidity
function mint(address account, uint256 value) public returns (bool)
```

_Function to mint tokens to address_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| account | address | The account to mint tokens. |
| value | uint256 | The amount of tokens to mint. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | A boolean that indicates if the operation was successful. |

