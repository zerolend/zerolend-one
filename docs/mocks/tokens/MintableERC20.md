# Solidity API

## MintableERC20

_ERC20 minting logic_

### EIP712_REVISION

```solidity
bytes EIP712_REVISION
```

### EIP712_DOMAIN

```solidity
bytes32 EIP712_DOMAIN
```

### PERMIT_TYPEHASH

```solidity
bytes32 PERMIT_TYPEHASH
```

### _nonces

```solidity
mapping(address => uint256) _nonces
```

### DOMAIN_SEPARATOR

```solidity
bytes32 DOMAIN_SEPARATOR
```

### constructor

```solidity
constructor(string name, string symbol) public
```

### permit

```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external
```

Allow passing a signed message to approve spending

_implements the permit function as for
https://github.com/ethereum/EIPs/blob/8a34d644aacf0f9f8f00815307fd7dd5da07655f/EIPS/eip-2612.md_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner of the funds |
| spender | address | The spender |
| value | uint256 | The amount |
| deadline | uint256 | The deadline timestamp, type(uint256).max for max deadline |
| v | uint8 | Signature param |
| r | bytes32 | Signature param |
| s | bytes32 | Signature param |

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

### nonces

```solidity
function nonces(address owner) public view virtual returns (uint256)
```

