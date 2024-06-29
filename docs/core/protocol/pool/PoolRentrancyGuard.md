# Solidity API

## PoolRentrancyGuard

This is specialized rentrancy contract that checks the rentrancy state for lending, flashloans and
liquidations seperately.

### RentrancyKind

```solidity
enum RentrancyKind {
  LENDING,
  FLASHLOAN,
  LIQUIDATION
}
```

### __PoolRentrancyGuard_init

```solidity
function __PoolRentrancyGuard_init() internal
```

### nonReentrant

```solidity
modifier nonReentrant(enum PoolRentrancyGuard.RentrancyKind kind)
```

_Prevents a contract from calling itself, directly or indirectly.
Calling a `nonReentrant` function from another `nonReentrant`
function is not supported. It is possible to prevent this from happening
by making the `nonReentrant` function external, and making it call a
`private` function that does the actual work._

### _reentrancyGuardEntered

```solidity
function _reentrancyGuardEntered(enum PoolRentrancyGuard.RentrancyKind kind) internal view returns (bool)
```

_Returns true if the reentrancy guard is currently set to "entered", which indicates there is a
`nonReentrant` function in the call stack._

