# Solidity API

## EIP712Base

Base contract implementation of EIP712.

### EIP712_REVISION

```solidity
bytes EIP712_REVISION
```

### EIP712_DOMAIN

```solidity
bytes32 EIP712_DOMAIN
```

### _nonces

```solidity
mapping(address => uint256) _nonces
```

### _domainSeparator

```solidity
bytes32 _domainSeparator
```

### _chainId

```solidity
uint256 _chainId
```

### constructor

```solidity
constructor() internal
```

_Constructor._

### DOMAIN_SEPARATOR

```solidity
function DOMAIN_SEPARATOR() public view virtual returns (bytes32)
```

Get the domain separator for the token

_Return cached value if chainId matches cache, otherwise recomputes separator_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The domain separator of the token at current chain |

### nonces

```solidity
function nonces(address owner) public view virtual returns (uint256)
```

Returns the nonce value for address specified as parameter

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The address for which the nonce is being returned |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The nonce value for the input address` |

### _calculateDomainSeparator

```solidity
function _calculateDomainSeparator() internal view returns (bytes32)
```

Compute the current domain separator

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | The domain separator for the token |

### _EIP712BaseId

```solidity
function _EIP712BaseId() internal view virtual returns (string)
```

Returns the user readable name of signing domain (e.g. token name)

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | string | The name of the signing domain |

