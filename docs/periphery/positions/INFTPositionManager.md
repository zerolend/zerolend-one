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

### InvalidAssetAddress

```solidity
error InvalidAssetAddress()
```

Error indicating that the provided address is invalid and not present in the debt market.

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

### NFTMinted

```solidity
event NFTMinted(address recipient, uint256 tokenId)
```

Emitted when an NFT is minted.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| recipient | address | The address that received the minted NFT. |
| tokenId | uint256 | The ID of the minted NFT. |

### NFTBurned

```solidity
event NFTBurned(uint256 tokenId)
```

Emitted when an NFT is burned.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | The ID of the burned NFT. |

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
  address recipient;
  address pool;
  uint256 amount;
}
```

### LiquidityParams

```solidity
struct LiquidityParams {
  address asset;
  address pool;
  address user;
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

### AddLiquidityParams

```solidity
struct AddLiquidityParams {
  address asset;
  uint256 amount;
  uint256 tokenId;
}
```

### BorrowParams

```solidity
struct BorrowParams {
  address asset;
  uint256 amount;
  uint256 tokenId;
}
```

### RepayParams

```solidity
struct RepayParams {
  address asset;
  uint256 amount;
  uint256 tokenId;
}
```

### WithdrawParams

```solidity
struct WithdrawParams {
  address asset;
  address user;
  uint256 amount;
  uint256 tokenId;
}
```

### OperationType

```solidity
enum OperationType {
  Supply,
  Borrow
}
```

### ActionType

```solidity
enum ActionType {
  Add,
  Subtract
}
```

