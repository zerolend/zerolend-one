# Solidity API

## MintableDelegationERC20

_ERC20 minting logic with delegation_

### delegatee

```solidity
address delegatee
```

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

### delegate

```solidity
function delegate(address delegateeAddress) external
```

