# Solidity API

## INFTPositionManager

### NotTokenIdOwner

```solidity
error NotTokenIdOwner()
```

Error indicating that the caller is not the owner or approved operator of the token ID.

### ZeroAddressNotAllowed

```solidity
error ZeroAddressNotAllowed()
```

Error indicating that a zero address was provided, which is not allowed.

### ZeroValueNotAllowed

```solidity
error ZeroValueNotAllowed()
```

Error indicating that a zero value was provided, which is not allowed.

### BalanceMisMatch

```solidity
error BalanceMisMatch()
```

Error indicating a mismatch in balance.

### PositionNotCleared

```solidity
error PositionNotCleared()
```

Error indicating that the position is not cleared.

### NotPool

```solidity
error NotPool()
```

Error indicating that pool is not register in pool factory.

### BorrowIncreased

```solidity
event BorrowIncreased(address asset, uint256 amount, uint256 tokenId)
```

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset that we want to borrow. |
| amount | uint256 | The amount of the asset that we want to borrow. |
| tokenId | uint256 | The ID of the position token. |

### Withdrawal

```solidity
event Withdrawal(address asset, uint256 amount, uint256 tokenId)
```

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset that we want to withdraw |
| amount | uint256 | The amount of asset that we want to withdraw |
| tokenId | uint256 | The ID of the NFT. |

### Repay

```solidity
event Repay(address asset, uint256 tokenId, uint256 amount)
```

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset that we want to repay. |
| tokenId | uint256 | The ID of the NFT. |
| amount | uint256 | The amount of asset that we want to repay |

### LiquidityIncreased

```solidity
event LiquidityIncreased(address asset, uint256 tokenId, uint256 amount)
```

Emitted when liquidity is increased for a specific position token.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| asset | address | The address of the asset for which liquidity was increased. |
| tokenId | uint256 | The ID of the position token. |
| amount | uint256 | The amount of the asset that was added to the position. |

### MintParams

```solidity
struct MintParams {
  address asset;
  address pool;
  uint256 amount;
}
```

### LiquidityParams

```solidity
struct LiquidityParams {
  address asset;
  address pool;
  uint256 amount;
  uint256 tokenId;
}
```

### Asset

```solidity
struct Asset {
  address asset;
  uint256 balance;
  uint256 debt;
}
```

### Position

```solidity
struct Position {
  struct INFTPositionManager.Asset[] assets;
  address pool;
  address operator;
}
```

### AssetOperationParams

```solidity
struct AssetOperationParams {
  address asset;
  uint256 amount;
  uint256 tokenId;
}
```

