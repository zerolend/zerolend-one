# Solidity API

## GPv2SafeERC20

_Gas-efficient version of Openzeppelin's SafeERC20 contract._

### safeTransfer

```solidity
function safeTransfer(contract IERC20 token, address to, uint256 value) internal
```

_Wrapper around a call to the ERC20 function `transfer` that reverts
also when the token returns `false`._

### safeTransferFrom

```solidity
function safeTransferFrom(contract IERC20 token, address from, address to, uint256 value) internal
```

_Wrapper around a call to the ERC20 function `transferFrom` that
reverts also when the token returns `false`._

